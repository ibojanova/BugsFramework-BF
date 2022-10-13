using System.Xml.Linq;
using System.Xml.XPath;

namespace BF
{
    static public class BFCWE
    {
        static public XPathNavigator Clusters() => XElement.Parse(Properties.Resources.BFCWE).CreateNavigator();

    }
}
