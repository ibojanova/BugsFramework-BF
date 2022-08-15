using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public class Weakness
    {
        [XmlAttribute] public string Type { get; set; } = string.Empty;
        [XmlAttribute] public string Class { get; set; } = string.Empty;
        public Cause Cause { get; set; } = new ();
        public Operation Operation { get; set; } = new();
        public Consequence Consequence { get; set; } = new();
        public Attributes? Attributes { get; set; }
    }
}