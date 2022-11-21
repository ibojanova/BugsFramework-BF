using System.IO.Compression;

namespace test
{
    internal class Program
    {
        private const string subdir = "\\_DB\\CVEBF";
        static HttpClient client = new HttpClient();
    static async Task Main(string[] args)
        {
            var solutionDir = Directory.GetParent(Directory.GetCurrentDirectory())!.Parent!.Parent!.Parent!.FullName;
            var dir = solutionDir + subdir;

            
            for (int i = DateTime.Today.Year; i >= 2002; i--)
            {
                var f = $"nvdcve-1.1-{i}.json";
                var x = $@"https://nvd.nist.gov/feeds/json/cve/1.1/{f}.zip";
                using var y = await client.GetStreamAsync(x);
                using var z = new ZipArchive(y);
                z.ExtractToDirectory(dir);
            }

        }
    }
}