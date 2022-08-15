using System.Xml;
using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public static class BFCVESerializer
    {
        readonly static XmlSerializer Serializer = new(typeof(CVE));
        readonly static XmlSerializerNamespaces NoNamespace = new(new XmlQualifiedName[] { XmlQualifiedName.Empty });

        //xxxneed to add validation towards schema
        public static CVE? Load(string fileName)
        {
            using var file = File.OpenRead(fileName);
            return Serializer.Deserialize(file) as CVE;
        }

        public static void Save (CVE cve, string fileName)
        {
            using var file = File.Create(fileName);
            Serializer.Serialize(file, cve, NoNamespace);
        }
    }
}
