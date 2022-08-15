using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 4/20/2022 */

namespace CWEBFDB
{
    public class ClusterCWEs
    {
        [XmlAttribute] public string Name { get; set; } = string.Empty;
        [XmlElement("Class")] public ClassCWEs[] CWEs { get; set; } = Array.Empty<ClassCWEs>();
        //[XmlElement("CWE")] public int[] hideCWEs { get; set; } = Array.Empty<int>();
    }
}