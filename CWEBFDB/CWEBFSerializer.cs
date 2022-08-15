using System.Xml;
using System.Xml.Serialization;

/*@author Irena Bojanova(ivb)
 *@date - 4/20/2022 */

namespace CWEBFDB
{
    public static class CWEBFSerializer
    {
        readonly static XmlSerializer Serializer = new(typeof(CWEBF));
        readonly static XmlSerializerNamespaces NoNamespace = new(new XmlQualifiedName[] { XmlQualifiedName.Empty });

        //xxxneed to add validation towards schema
        public static CWEBF? Load(string fileName)
        {
            using var file = File.OpenRead(fileName);
            return Serializer.Deserialize(file) as CWEBF;
        }

        public static void Save (CWEBF cwebf, string fileName)
        {
            using var file = File.Create(fileName);
            Serializer.Serialize(file, cwebf, NoNamespace);
        }
    }
}
