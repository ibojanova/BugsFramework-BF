using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public class ValueComment
    {
        [XmlText] public string Value { get; set; } = string.Empty;
        [XmlAttribute] public string? Comment { get; set; }
    }
}
