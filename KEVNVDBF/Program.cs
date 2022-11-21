using System.IO;
using System.IO.Compression;
using System.Runtime.Serialization.Json;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;
using Xslt;
using static System.Net.WebRequestMethods;
using File = System.IO.File;

namespace KEVNVDBF
{
    internal class Program
    {
        static HttpClient client = new HttpClient();

        const string
            kevUri = $@"https://www.cisa.gov/sites/default/files/feeds",
            nvdUri = $@"https://nvd.nist.gov/feeds/json/cve/1.1";

        static XmlReader JsonStreamToXml(Stream stream) =>
            JsonReaderWriterFactory.CreateJsonReader(stream, new XmlDictionaryReaderQuotas());

        static async Task Main(string[] args)
        {
            var solutionDir = Directory.GetParent(Directory.GetCurrentDirectory())!.Parent!.Parent!.Parent!.FullName;
            var dbDir = Path.Combine(solutionDir, @"_DB\KEVNVDBF");
            var xsltDir = Path.Combine(solutionDir, @"KEVNVDBF\XSLT");
            var excel = Path.Combine(dbDir, "KEV-NVD-BF-excel.xml");
            //xxx BF.BFCWE
            var bfcweFile = "BFCWE.xml";
            var bfcwe = Path.Combine(solutionDir, $@"BF\XML\{bfcweFile}");

            var nvdXslt = Path.Combine(xsltDir, "CVE-CVSS-CWE.xslt");
            var excelXslt = Path.Combine(xsltDir, "KEV-NVD-BF-excel.xslt");

            var xslt = new XslCompiledTransform();
            var all = new XElement("ALL");

            xslt.Load(nvdXslt);
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
                    using (var stream = await client.GetStreamAsync(nvdUrl))
                    using (var zip = new ZipArchive(stream))
                    using (var json = zip.GetEntry(nvdFile)!.Open())
                    using (var reader = JsonStreamToXml(json))
                        xslt.Transform(reader, allWriter);
                }

                Console.WriteLine(bfcweFile);
                using (var reader = XmlReader.Create(bfcwe))
                    allWriter.WriteNode(reader, false);

            }

            xslt.Load(excelXslt, XsltSettings.TrustedXslt, new XmlUrlResolver());
            using (var xmlReader = all.CreateReader())
            using (var excelFile = File.Create(excel))
                xslt.Transform(xmlReader, null, excelFile);

            //====================================
            //BFCWECVE - redo
            string nvdcveJson = @"nvdcve-1.1-2002.json";
            string nvdcveXml = @"nvdcve-1.1-2022.xml";
            var cwecve = Path.Combine(dbDir, @"CWE-CVE.xml");
            var bfcwecve = Path.Combine(dbDir, @"BF-CWE-CVE.xml");

            JSONtoXML(dbDir, nvdcveJson, nvdcveXml);
            var xd = XDocument.Load(Path.Combine(dbDir, nvdcveXml));
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
        public static void JSONtoXML(string dir, string inFile, string outFile)
        {
            using (var s = File.OpenRead(Path.Combine(dir, inFile)))
            using (var j = JsonReaderWriterFactory.CreateJsonReader(s, new XmlDictionaryReaderQuotas()))
            using (var x = XmlWriter.Create(Path.Combine(dir, outFile), new XmlWriterSettings { Indent = true, OmitXmlDeclaration = true }))
                x.WriteNode(j, false);
        }
    }
}