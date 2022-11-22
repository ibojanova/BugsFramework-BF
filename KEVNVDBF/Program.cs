using System.IO.Compression;
using System.Runtime.Serialization.Json;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;
using File = System.IO.File;

namespace KEVNVDBF
{
    internal class Program
    {
        static readonly HttpClient client = new();

        const string
            kevUri = $@"https://www.cisa.gov/sites/default/files/feeds",
            nvdUri = $@"https://nvd.nist.gov/feeds/json/cve/1.1";

        static XmlReader JsonStreamToXml(Stream stream) =>
            JsonReaderWriterFactory.CreateJsonReader(stream, new XmlDictionaryReaderQuotas());

        static async Task Main(string[] _)
        {
            var solutionDir = Directory.GetParent(Directory.GetCurrentDirectory())!.Parent!.Parent!.Parent!.FullName;
            var dir = Path.Combine(solutionDir, @"_DB\KEVNVDBF");
            var excel = Path.Combine(dir, "KEV-NVD-BF-excel.xml");
            var allFile = Path.Combine(dir, $@"all.xml");
            var all = new XElement("ALL");
            var xslt = new XslCompiledTransform();

            var download = true; //true -- to update from URIs
            if (!download)
                all = XElement.Load(allFile);
            else {
                using (var reader = FromString(Properties.Resources.CVE_CVSS_CWE))
                    xslt.Load(reader);
                using (var allWriter = all.CreateWriter())
                {
                    var kevFile = "known_exploited_vulnerabilities.json";
                    Console.WriteLine(kevFile);
                    var kevUrl = $@"{kevUri}/{kevFile}";
                    using (var stream = await client.GetStreamAsync(kevUrl))
                    using (var reader = JsonStreamToXml(stream))
                    {
                        allWriter.WriteStartElement("KEV");
                        allWriter.WriteNode(reader, false);
                        allWriter.WriteEndElement();
                    }

                    for (int i = DateTime.Today.Year; i >= 2002; i--)
                    {
                        var nvdFile = $"nvdcve-1.1-{i}.json";
                        Console.WriteLine(nvdFile);
                        var nvdUrl = $@"{nvdUri}/{nvdFile}.zip";
                        using var stream = await client.GetStreamAsync(nvdUrl);
                        using var zip = new ZipArchive(stream);
                        using var json = zip.GetEntry(nvdFile)!.Open();
                        using var reader = JsonStreamToXml(json);
                        xslt.Transform(reader, allWriter);
                    }

                    Console.WriteLine(nameof(BF.Properties.Resources.BFCWE));
                    using (var reader = FromString(BF.Properties.Resources.BFCWE))
                        allWriter.WriteNode(reader, false);
                }
                Console.WriteLine(allFile);
                all.Save(allFile);
            }

            using (var reader = FromString(Properties.Resources.KEV_NVD_BF_excel))
                xslt.Load(reader, XsltSettings.TrustedXslt, new XmlUrlResolver());

            using (var xmlReader = all.CreateReader())
            using (var excelFile = File.Create(excel))
                xslt.Transform(xmlReader, null, excelFile);

            //====================================
            //BFCWECVE - redo
            var xsltDir = Path.Combine(solutionDir, @"KEVNVDBF\XSLT");
            string nvdcveJson = @"nvdcve-1.1-2002.json";
            string nvdcveXml = @"nvdcve-1.1-2022.xml";
            var cwecve = Path.Combine(dir, @"CWE-CVE.xml");
            var bfcwecve = Path.Combine(dir, @"BF-CWE-CVE.xml");

            JSONtoXML(dir, nvdcveJson, nvdcveXml);
            var xd = XDocument.Load(Path.Combine(dir, nvdcveXml));
            var r = new XElement("CWECVE",
                xd.XPathSelectElements("/root/CVE_Items/item/cve").Select(n => new
                {
                    v = n.XPathSelectElement("CVE_data_meta/ID")?.Value ?? string.Empty,
                    w = n.XPathSelectElement("problemtype/problemtype_data/item/description/item/value")?.Value ?? string.Empty,
                    d = n.XPathSelectElement("description/description_data/item/value")?.Value ?? string.Empty
                }).GroupBy(x => x.w, (w, g) => new XElement("CWE", new XAttribute("Id", w), g.Select(v => new XElement("CVE", new XAttribute("Name", v.v), new XText(v.d))))));

            r.Save(cwecve);

            //run BF-CWE-CVE.xslt
            var xsltFile = Path.Combine(xsltDir, "BF-CWE-CVE.xslt");
            var argsL = new XsltArgumentList();
            argsL.AddParam("Clusters", String.Empty, BF.BFCWE.Clusters());
            Xslt.Xslt.Transform(xsltFile, cwecve, bfcwecve, args: argsL);

        }

        public static XmlReader FromString(string resource) => XmlReader.Create(new StringReader(resource));
        public static void JSONtoXML(string dir, string inFile, string outFile)
        {
            using var s = File.OpenRead(Path.Combine(dir, inFile));
            using var j = JsonReaderWriterFactory.CreateJsonReader(s, new XmlDictionaryReaderQuotas());
            using var x = XmlWriter.Create(Path.Combine(dir, outFile), new XmlWriterSettings { Indent = true, OmitXmlDeclaration = true });
            x.WriteNode(j, false);
        }
    }
}