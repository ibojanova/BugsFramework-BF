using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public class OperationAttribute
    {
        [XmlElement] public Attribute[]? Attribute;
    }
}
