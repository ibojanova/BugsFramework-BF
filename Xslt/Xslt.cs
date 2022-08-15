using System.Xml;
using System.Xml.Xsl;

namespace Xslt
{
    static public class Xslt
    {
        static public void Transform(string xsltFile, string inputXmlFile, string outputXmlFile, XsltArgumentList? args = null)
        {
            var xslt = new XslCompiledTransform();
            xslt.Load(xsltFile, XsltSettings.TrustedXslt, new XmlUrlResolver());
            using (var i = XmlReader.Create(inputXmlFile))
            using (var o = XmlWriter.Create(outputXmlFile, xslt.OutputSettings))
                xslt.Transform(i, args, o, new XmlUrlResolver());
        }
    }
}