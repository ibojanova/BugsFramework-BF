/*@author Irena Bojanova(ivb)
 *@date - 4/20/2022 */

namespace CWEBFDB
{
    public class CWE
    {
        //xxx should be int
        public string ID { get; set; } = string.Empty;
    }

    public enum Nature { ChildOf, CanPrecede, CanFollow, CanAlsoBe, PeerOf };
}
