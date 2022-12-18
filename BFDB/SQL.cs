namespace BFDB;

using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Runtime.CompilerServices;

public class SQL
{
    public readonly DbProviderFactory Provider;
    public readonly string ConnectionString;

    public SQL(string connectionString, DbProviderFactory? provider = null)
    {
        Provider = provider ?? SqlClientFactory.Instance;

        var normalizer = Provider.CreateConnectionStringBuilder()!;
        normalizer.ConnectionString = connectionString;
        ConnectionString = normalizer.ConnectionString;
    }

    public delegate Task<Data> DbDataRetrievalAsync<Data>(DbCommand command, CancellationToken cancellationToken = default);
    public delegate IAsyncEnumerable<Data> DbDataCollectionRetrievalAsync<Data>(DbCommand command, CancellationToken cancellationToken = default);
    public delegate Task<Data> DbSimpleDataRetrievalAsync<Data>(DbDataReader reader, CancellationToken cancellationToken = default);

    public async IAsyncEnumerable<Data> GetDatabaseData<Data>(DbDataCollectionRetrievalAsync<Data> retrieveData, string codeSQL, CommandType typeSQL = CommandType.Text
        , IsolationLevel? isolationLevel = null, TimeSpan? timeout = null
        , [EnumeratorCancellation] CancellationToken token = default, params DbParameter[] parameters)
    {
        await using var connection = Provider.CreateConnection()!;
        connection.ConnectionString = ConnectionString;
        await connection.OpenAsync(token);

        using var cancel = CancellationTokenSource.CreateLinkedTokenSource(token);
        await using var transaction = isolationLevel.HasValue ? await connection.BeginTransactionAsync(isolationLevel.Value, token) : await connection.BeginTransactionAsync(token);
        await using var command = connection.CreateCommand();
        try
        {
            command.Transaction = transaction;
            command.CommandText = codeSQL;
            command.CommandType = typeSQL;
            command.Parameters.AddRange(parameters);
            if (timeout.HasValue) command.CommandTimeout = (int)timeout.Value.TotalSeconds;

            await using var cursor = retrieveData(command, cancel.Token).GetAsyncEnumerator(cancel.Token);
            while (!cancel.IsCancellationRequested)
            {
                try { if (!await cursor.MoveNextAsync()) break; } catch { cancel.Cancel(); throw; }
                yield return cursor.Current;
            }
        }
        finally
        {
            try { if (cancel.IsCancellationRequested) await transaction.RollbackAsync(); else await transaction.CommitAsync(); } catch { }
            await connection.CloseAsync();
        }
    }


    internal static async IAsyncEnumerable<Data> CastDataFromReaderAsync<Data>(DbSimpleDataRetrievalAsync<Data> castToDataAsync, DbCommand command, [EnumeratorCancellation] CancellationToken token = default)
    {
        await using var r = await command.ExecuteReaderAsync(token);
        while (await r.ReadAsync(token))
            yield return await castToDataAsync(r, token);
    }
    public IAsyncEnumerable<Data> GetDatabaseData<Data>(DbSimpleDataRetrievalAsync<Data> castToDataAsync
        , string codeSQL, CommandType typeSQL = CommandType.Text, IsolationLevel? isolationLevel = null
        , TimeSpan? timeout = null, CancellationToken token = default, params DbParameter[] parameters)
    => GetDatabaseData((cmd, cancel) => CastDataFromReaderAsync(castToDataAsync, cmd, cancel), codeSQL, typeSQL, isolationLevel, timeout, token, parameters);


    internal static async IAsyncEnumerable<DataType> GetSingleValue<DataType>
        (DbDataRetrievalAsync<DataType> getData, DbCommand cmd, [EnumeratorCancellation] CancellationToken token = default)
    { yield return await getData(cmd, token); }

    public ValueTask<Data> GetDatabaseValue<Data>(DbDataRetrievalAsync<Data> getData, string codeSQL, CommandType typeSQL = CommandType.Text
        , IsolationLevel? isolationLevel = null, TimeSpan? timeout = null, CancellationToken token = default, params DbParameter[] parameters)
    => GetDatabaseData((cmd, cancel) => GetSingleValue(getData, cmd, cancel), codeSQL, typeSQL, isolationLevel, timeout, token, parameters).FirstAsync(token);

    public ValueTask<Data> GetDatabaseValue<Data>(DbSimpleDataRetrievalAsync<Data> getData, string codeSQL, CommandType typeSQL = CommandType.Text
        , IsolationLevel? isolationLevel = null, TimeSpan? timeout = null, CancellationToken token = default, params DbParameter[] parameters)
    => GetDatabaseData(getData, codeSQL, typeSQL, isolationLevel, timeout, token, parameters).FirstAsync(token);


    /* Generic GetData, GetValue, and Execute */

    public ValueTask<object?> GetValue(string codeSQL, CommandType typeSQL = CommandType.Text, IsolationLevel? isolationLevel = null
        , TimeSpan? timeout = null, CancellationToken token = default, params DbParameter[] parameters)
    => GetDatabaseValue(async (command, cancel) => await command.ExecuteScalarAsync(cancel), codeSQL, typeSQL, isolationLevel, timeout, token, parameters);

    public ValueTask<int> Execute(string codeSQL, CommandType typeSQL = CommandType.Text, IsolationLevel? isolationLevel = null
        , TimeSpan? timeout = null, CancellationToken token = default, params DbParameter[] parameters)
    => GetDatabaseValue(async (command, cancel) => await command.ExecuteNonQueryAsync(cancel), codeSQL, typeSQL, isolationLevel, timeout, token, parameters);

}