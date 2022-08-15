using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public class OperandAttribute
    {
        [XmlAttribute] public string Name = string.Empty;
        [XmlElement] public Attribute[]? Attribute;
    }
}
