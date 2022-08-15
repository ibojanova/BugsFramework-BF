using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using System.Xml.XPath;

namespace BF
{
    static public class BFCWE
    {

        static public XPathNavigator Clusters() => XElement.Parse(Properties.Resources.BFCWE).CreateNavigator();

    }
}
