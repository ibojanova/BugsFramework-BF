using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public class CVE
    {
        [XmlAttribute] public string Name { get; set; } = string.Empty;
        [XmlElement] public Weakness Bug { get; set; } = new();
        [XmlElement ("Weakness")] public Weakness[]? Weaknesses { get; set; }
        [XmlElement] public Weakness Failure { get; set; } = new();

        public override string ToString() => 
            @$"{Name}:{Bug}{Environment.NewLine}{string.Concat(Weaknesses?.Select(w => Environment.NewLine + w.ToString()) ?? Enumerable.Empty<string>())}{Environment.NewLine}{Failure}";
    }
}
