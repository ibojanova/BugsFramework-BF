using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;

/*@author Irena Bojanova(ivb)
 *@date - 4/20/2022 */

namespace CWEBFDB
{
    public class CWEBF
    {
        [XmlElement] public ClusterCWEs[] Clusters { get; set; } = Array.Empty<ClusterCWEs>();

        XPathNavigator CWEsNavigator(ClusterCWEs cluster, string[] className)
        {
            return new XElement(XmlConvert.EncodeLocalName(cluster.Name),
                cluster.CWEs.Where(m => className.Contains(m.Class)).Select(m => new XElement("Class", new XAttribute("name", m.Class), m.ShowClassCWEs.Select(c => new XElement("CWE", c)))))
                .CreateNavigator();    
        }
    }
}