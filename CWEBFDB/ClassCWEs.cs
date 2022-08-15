using System.Xml.Serialization;
using System.Drawing;

/*@author Irena Bojanova(ivb)
 *@date - 4/20/2022 */

namespace CWEBFDB
{
    public class ClassCWEs
    {
        [XmlAttribute ("name")] public string Class { get; set; } = string.Empty;
        [XmlElement ("CWE")] public int[] ShowClassCWEs { get; set; } = Array.Empty<int>();
        //[XmlElement("CWE")] public int[] showOtherCWEs { get; set; } = Array.Empty<int>();
        //[XmlElement("CWE")] public int[] showConsequenceCWEs { get; set; } = Array.Empty<int>();
        //iii color
        //[XmlAttribute("color")] public Color Color { get; set; } = Color.Black;

        [XmlIgnore] 
        public string ShowCWEsText
        {
            get => string.Join(',', (ShowClassCWEs ?? Array.Empty<int>()).Select(i => i.ToString()));
            set => ShowClassCWEs = (value ?? string.Empty).Split(',', StringSplitOptions.RemoveEmptyEntries).Select(x => int.Parse(x)).ToArray();
        }

        //[XmlIgnore] 
        //public string showOtherCWEs
        //{
        //    get => string.Join(',', (ShowClassCWEs ?? Array.Empty<int>()).Select(i => i.ToString()));
        //    set => ShowClassCWEs = (value ?? string.Empty).Split(',', StringSplitOptions.RemoveEmptyEntries).Select(x => int.Parse(x)).ToArray();
        //}

        //[XmlIgnore]
        //public string showConsequenceCWEs
        //{
        //    get => string.Join(',', (ShowClassCWEs ?? Array.Empty<int>()).Select(i => i.ToString()));
        //    set => ShowClassCWEs = (value ?? string.Empty).Split(',', StringSplitOptions.RemoveEmptyEntries).Select(x => int.Parse(x)).ToArray();
        //}

        //[XmlIgnore]
        //public string hideCWEs
        //{
        //    get => string.Join(',', (ShowClassCWEs ?? Array.Empty<int>()).Select(i => i.ToString()));
        //    set => ShowClassCWEs = (value ?? string.Empty).Split(',', StringSplitOptions.RemoveEmptyEntries).Select(x => int.Parse(x)).ToArray();
        //}

    }
}