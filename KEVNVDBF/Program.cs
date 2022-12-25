using System.Runtime.Serialization.Json;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;
using File = System.IO.File;

/*@author Irena Bojanova(ivb)
 *@date - 12/06/2022 */

namespace KEVNVDBF
{
    internal class Program
    {
        //xxx redo
        static readonly HttpClient client = new();

        const string
            kevUrl = $@"https://www.cisa.gov/sites/default/files/feeds",
            kevJson = @"known_exploited_vulnerabilities.json",
            nvdUri = @"https://services.nvd.nist.gov/rest/json";

        static readonly string
            nvdCvesUrl = Path.Combine(nvdUri, $@"cves/2.0");

        static XmlReader JsonStreamToXml(Stream stream) =>
            JsonReaderWriterFactory.CreateJsonReader(stream, Encoding.UTF8, new XmlDictionaryReaderQuotas(), null);

        static async Task Main(string[] _)
        {
            var solutionDir = Directory.GetParent(Directory.GetCurrentDirectory())!.Parent!.Parent!.Parent!.FullName;
            var dir = Path.Combine(solutionDir, @"_DB\KEVNVDBF");
            var xmlFile = Path.Combine(dir, $@"KEV-NVD-BF.xml");
            var excelFile = Path.Combine(dir, "KEV-NVD-BF-excel.xml");
            var allXml = new XElement("KEV-NVD-BF");
            var xslt = new XslCompiledTransform();

            var download = true; //true -- to update from URLs
            if (!download)
                allXml = XElement.Load(xmlFile);
            else {
                using (var xsltReader = FromString(Properties.Resources.CVE_CVSS_CWE))
                    xslt.Load(xsltReader);
                using (var xmlWriter = allXml.CreateWriter())
                {
                    Console.WriteLine(kevJson);
                    var kevUrl = $@"{Program.kevUrl}/{kevJson}";
                    using (var kevStream = await client.GetStreamAsync(kevUrl))
                    using (var kevReader = JsonStreamToXml(kevStream))
                    {
                        xmlWriter.WriteStartElement("KEV");
                        xmlWriter.WriteNode(kevReader, false);
                        xmlWriter.WriteEndElement();
                    }

                    var xd = new XDocument();
                    using (var nvdStream = await client.GetStreamAsync(nvdCvesUrl))
                    using (var xmlReader = JsonStreamToXml(nvdStream))
                        xd = XDocument.Load(xmlReader);
                    using (var nvdReader = xd.CreateReader())
                        xslt.Transform(nvdReader, xmlWriter);

                    //return;

                    Console.WriteLine(nameof(BF.Properties.Resources.BFCWE));
                    using var reader = FromString(BF.Properties.Resources.BFCWE);
                    xmlWriter.WriteNode(reader, false);
                }
                Console.WriteLine(xmlFile);
                allXml.Save(xmlFile);
            }
            //return;

            using (var xsltReader = FromString(Properties.Resources.KEV_NVD_BF_excel))
                xslt.Load(xsltReader, XsltSettings.TrustedXslt, new XmlUrlResolver());

            using (var xmlReader = allXml.CreateReader())
            using (var excel = File.Create(excelFile))
                xslt.Transform(xmlReader, null, excel);

            return;

            //====================================
            //BFCWECVE - redo
            var xsltDir = Path.Combine(solutionDir, @"KEVNVDBF\XSLT");
            string nvdcveJson = @"nvdcve-1.1-2002.json";
            string nvdcveXml = @"nvdcve-1.1-2022.xml";
            var cwecve = Path.Combine(dir, @"CWE-CVE.xml");
            var bfcwecve = Path.Combine(dir, @"BF-CWE-CVE.xml");

            JSONtoXML(dir, nvdcveJson, nvdcveXml);
            var xdd = XDocument.Load(Path.Combine(dir, nvdcveXml));
            var r = new XElement("CWECVE",
                xdd.XPathSelectElements("/root/CVE_Items/item/cve").Select(n => new
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