using BFData;
using System.Net.Http.Json;
using System.Runtime.CompilerServices;

namespace LoadKEV
{
    internal class LoaderKEV
    {
        static readonly Uri UriKEV = new(@"https://www.cisa.gov/sites/default/files/feeds/known_exploited_vulnerabilities.json");

        static readonly HttpClient loader = new();

        public async IAsyncEnumerable<KEVCVE> GetVulnerabilities([EnumeratorCancellation] CancellationToken cancel = default) 
        {

            if (await loader.GetFromJsonAsync<Info>(UriKEV, cancel) is Info info && info.vulnerabilities is not null)
                foreach (var v in info.vulnerabilities)
                    yield return new KEVCVE(v.cveID, v.vendorProject, v.product, v.vulnerabilityName, v.dateAdded, v.shortDescription);
        }

        internal record Info(VulnerabilityData[]? vulnerabilities);
            internal record VulnerabilityData(string cveID, string? vendorProject, string? product, string? vulnerabilityName, DateTime? dateAdded, string? shortDescription);

    }

}
