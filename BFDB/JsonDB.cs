using System.Data.SqlClient;
using System.Data;
using System.Text.Json;

namespace BFDB
{
    public class JsonDB<Json> : SQL 
    {
        public JsonDB(string connection) : base(connection) { }

        const int PAGE = 100;
        public async Task SaveVulnerabilities(IAsyncEnumerable<Json> vulnerabilities, string proc, CancellationToken cancel = default)
        {
            var pages = vulnerabilities.Select((v, i) => new { page = i / PAGE, v }).GroupBy(x => x.page, (_, g) => g.Select(x => x.v));
            await foreach (var page in pages)
            {
                await Execute(proc, CommandType.StoredProcedure, token: cancel, parameters:
                    new SqlParameter("@data", SqlDbType.NVarChar) { Value = JsonSerializer.Serialize(await page.ToArrayAsync()) });
                Console.Write(".");
            }
        }
    }
}