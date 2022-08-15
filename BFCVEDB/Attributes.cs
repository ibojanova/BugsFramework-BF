using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public class Attributes
    {
        [XmlElement("Operation")] public OperationAttribute? OperationAttribute { get; set; }
        [XmlElement("Operand")] public OperandAttribute[]? OperandAttribute { get; set; }
    }
}