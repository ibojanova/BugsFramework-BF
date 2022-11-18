using System.Runtime.Serialization.Json;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;

namespace CVEBF
{
    public partial class CVEBFForm : Form
    {
        private const string subdir = "\\_DB\\CVEBF";

        public CVEBFForm()
        {
            InitializeComponent();

            var solutionDir = Directory.GetParent(Directory.GetCurrentDirectory())!.Parent!.Parent!.Parent!.FullName;
            var dir = solutionDir + subdir;

            //download nvdcve-x.x-xxxx.json from https://nvd.nist.gov/vuln/data-feeds
            string nvdcveJSON = @"Input\nvdcve-1.1-2022.json";
            string nvdcveXML = @"Input\nvdcve-1.1-2022.xml";
            JSONtoXML(dir, nvdcveJSON, nvdcveXML);

            //download known_exploited_vulnerabilities.json from https://www.cisa.gov/known-exploited-vulnerabilities-catalog
            string kevJSON = @"Input\known_exploited_vulnerabilities.json";
            string kevXML = @"Input\known_exploited_vulnerabilities.xml";
            JSONtoXML(dir, kevJSON, kevXML);

            var xd = XDocument.Load(Path.Combine(dir, nvdcveXML));
            var r = new XElement("CVECWE-NVD",
                xd.XPathSelectElements("/root/CVE_Items/item/cve").Select(n => new
                {
                    v = n.XPathSelectElement("CVE_data_meta/ID")?.Value ?? string.Empty,
                    w = n.XPathSelectElement("problemtype/problemtype_data/item/description/item/value")?.Value ?? string.Empty,
                    d = n.XPathSelectElement("description/description_data/item/value")?.Value ?? string.Empty
                }).GroupBy(x => x.w, (w, g) => new XElement("CWE", new XAttribute("Id", w), g.Select(v => new XElement("CVE", new XAttribute("Name", v.v), new XText(v.d))))));

            r.Save(Path.Combine(dir, @"Input\CVECWE-NVD.xml"));

            //run CVEBF.xslt
            var args = new XsltArgumentList();
            args.AddParam("Clusters", String.Empty, BF.BFCWE.Clusters());
            Xslt.Xslt.Transform(Path.Combine(solutionDir, @"CVEBF\XSLT\CVEBF.xslt"), Path.Combine(dir, @"Input\CVECWE-NVD.xml"), Path.Combine(dir, @"CVEBF.xml"), args: args);
        }

        public void JSONtoXML(string dir, string inFile, string outFile)
        {
            using (var s = File.OpenRead(Path.Combine(dir, inFile)))
            using (var j = JsonReaderWriterFactory.CreateJsonReader(s, new XmlDictionaryReaderQuotas()))
            using (var x = XmlWriter.Create(Path.Combine(dir, outFile), new XmlWriterSettings { Indent = true, OmitXmlDeclaration = true }))
                x.WriteNode(j, false);
        }
    }
}