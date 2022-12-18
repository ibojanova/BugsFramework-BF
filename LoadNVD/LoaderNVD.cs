using BFData;
using System.Collections.Specialized;
using System.Net.Http.Json;
using System.Runtime.CompilerServices;
using System.Threading.Channels;
using static System.Web.HttpUtility;

namespace LoadNVD
{
    internal class LoaderNVD
    {
        static readonly Uri UriNVD = new(@"https://services.nvd.nist.gov/rest/json/cves/2.0");
        static readonly HttpClient loader = new();

        static LoaderNVD()
        {
            loader.DefaultRequestHeaders.Add("From", @"irena.bojanova@nist.gov");
            loader.DefaultRequestHeaders.Add("apiKey", @"d6f447c5-8c29-4ae9-ad44-6157317efa6a");
        }

        public IAsyncEnumerable<NVDCVE> GetVulnerabilities(CancellationToken cancel = default) => QueryNVD(UriNVD, cancel);

        //public ValueTask<NVDCVE?> GetVulnerability(string cve)
        //{
        //    var query = ParseQueryString(UriNVD.Query);
        //    query["cveId"] = cve;
        //    return QueryNVD(UriNVD.WithQuery(query)).FirstOrDefaultAsync();
        //}

        //public async IAsyncEnumerable<NVDCVE> Load(DateTimeOffset? lastModified = null)
        //{
        //    var query = ParseQueryString(UriNVD.Query);
        //    if (lastModified.HasValue)
        //    {
        //        query["lastModStartDate"] = lastModified.Value.ToString("s");
        //        query["lastModEndDate"] = DateTimeOffset.Now.ToString("s");
        //    }
        //    await foreach (var item in QueryNVD(UriNVD.WithQuery(query))) yield return item;
        //}

        #region Implementation

        static async IAsyncEnumerable<NVDCVE> QueryNVD(Uri uri, [EnumeratorCancellation] CancellationToken cancel = default)
        {
            var query = ParseQueryString(uri.Query);

            Info info = new(1, 0, default, default);
            for (int i = 0; i < info.totalResults; i += info.resultsPerPage)
            {
                //Console.Write("*");
                query["startIndex"] = i.ToString();
                if (await loader.GetFromJsonAsync<Info>(uri.WithQuery(query), cancel) is Info data && data.vulnerabilities is not null)
                    info = data;
                else yield break;

                foreach (var vulnerability in info.vulnerabilities)
                    yield return new NVDCVE(vulnerability.cve.id, 
                        vulnerability.cve.metrics?.cvssMetricV30?.FirstOrDefault()?.cvssData?.baseScore,
                        vulnerability.cve.weaknesses?.SelectMany(w => w.description?.Select(d => d.value) ?? Enumerable.Empty<string>()).Distinct().ToArray());
            }
        }

        internal record Info(int totalResults, int startIndex, int resultsPerPage, VulnerabilityData[]? vulnerabilities);
            internal record VulnerabilityData(CVE cve);
                internal record CVE(string id, DateTimeOffset lastModified, Weekness[]? weaknesses, Metrics? metrics);
                    internal record Weekness(WeeknessDescr[]? description);
                        internal record WeeknessDescr(string value);
                    internal record Metrics(Scores[]? cvssMetricV30);
                        internal record Scores(CVSSData? cvssData);
                            internal record CVSSData(double? baseScore);

        #endregion
    }

    public static class Extensions
    {
        public static Uri WithQuery(this Uri uri, NameValueCollection query) => new UriBuilder(uri) { Query = query.ToString() }.Uri;
    }

}
