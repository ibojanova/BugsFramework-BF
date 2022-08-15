using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public class Consequence : ValueComment
    {
        [XmlAttribute] public string Type { get; set; } = string.Empty;

        public override string ToString() => $"{Type}>{Value} {(string.IsNullOrEmpty(Comment) ? string.Empty : $"({Comment})")}";
    }
}