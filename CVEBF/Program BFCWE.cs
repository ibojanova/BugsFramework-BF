using System.IO.Compression;
using System.Runtime.Serialization.Json;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;
using File = System.IO.File;

namespace CVEBF
{
    internal class ProgramBFCWE
    {
        static HttpClient client = new HttpClient();
        static async Task Main1(string[] args)
        {
            var solutionDir = Directory.GetParent(Directory.GetCurrentDirectory())!.Parent!.Parent!.Parent!.FullName;
            var dbDir = $@"{solutionDir}\_DB\CVEBF\";
            var inDir = dbDir + @"Input\";
            var xsltDir = $@"{solutionDir}\CVEBF\XSLT\";

            for (int i = DateTime.Today.Year; i >= 2002; i--)
            {
                var nvdFile = $"nvdcve-1.1-{i}";
                var nvdJson = $@"{inDir}{nvdFile}.json";
                var nvdXml = $@"{inDir}{nvdFile}.xml";
                var xslt = $@"{xsltDir}CVEBF.xslt";
                var cwecvfXML = $@"{dbDir}CWECV.xml";
                var bfcweXml = $@"{dbDir}BFCWE.xml";

                //download NVD https://nvd.nist.gov/vuln/data-feeds //xxx add code for CVE-Recent?
                //var nvdFileURL = $@"https://nvd.nist.gov/feeds/json/cve/1.1/{nvdFile}.json.zip";
                //using var nvdZip = new ZipArchive(await client.GetStreamAsync(nvdFileURL));
                //nvdZip.ExtractToDirectory(inDir, true); //no overrite -- false
                //Console.WriteLine(nvdJson);
                //JSONtoXML(nvdJson,nvdXml);
                
                Console.WriteLine(nvdXml);
                transformXML(xslt, nvdXml, bfcweXml, cwecvfXML);
            }

            var kevFile = "known_exploited_vulnerabilities";
            var kevJson = $@"{inDir}{kevFile}.json";
            var kevXML = $@"{inDir}{kevFile}.xml";

            //var xsltFile = $@"{xsltDir}CVEBF.xslt";
            //download KEV https://www.cisa.gov/known-exploited-vulnerabilities-catalog
            //var kevFileURL = $@"https://www.cisa.gov/sites/default/files/feeds/{kevFile}.json";
            //using var kevS = await client.GetStreamAsync(kevFileURL);
            //using (var kevFs = new FileStream(kevJson, FileMode.Create)) //no overrite -- FileMode.CreateNew
            //    await kevS.CopyToAsync(kevFs);
            //Console.WriteLine(kevJson);
            //JSONtoXML(kevJson,kevXML);
            //Console.WriteLine(kevXML);

        }
        static public void JSONtoXML(string jsonFile, string xmlFile)
        {
            using (var s = File.OpenRead(jsonFile))
            using (var j = JsonReaderWriterFactory.CreateJsonReader(s, new XmlDictionaryReaderQuotas()))
            using (var x = XmlWriter.Create(xmlFile, new XmlWriterSettings { Indent = true, OmitXmlDeclaration = true }))
                x.WriteNode(j, false);
        }

        static public void transformXML(string xslt, string nvdXml, string bfcweXml, string cwecvXML)
        {
            var xd = XDocument.Load(nvdXml);
            var r = new XElement("CWECVE",
                xd.XPathSelectElements("/root/CVE_Items/item/cve").Select(n => new
                {
                    v = n.XPathSelectElement("CVE_data_meta/ID")?.Value ?? string.Empty,
                    w = n.XPathSelectElement("problemtype/problemtype_data/item/description/item/value")?.Value ?? string.Empty,
                    d = n.XPathSelectElement("description/description_data/item/value")?.Value ?? string.Empty
                }).GroupBy(x => x.w, (w, g) => new XElement("CWE", new XAttribute("Id", w), g.Select(y => new XElement("CVE", new XAttribute("Name", y.v), new XText(y.d))))));

            r.Save(cwecvXML);

            //run CVEBF.xslt
            var args = new XsltArgumentList();
            args.AddParam("Clusters", string.Empty, BF.BFCWE.Clusters());
            Xslt.Xslt.Transform(xslt, cwecvXML, bfcweXml, args: args);
        }
    }
}