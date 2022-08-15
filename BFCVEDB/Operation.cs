/*@author Irena Bojanova(ivb)
 *@date - 2/9/2022 */

namespace BFCVEDB
{
    public class Operation : ValueComment
    {
        public override string ToString() => $"{Value} {(string.IsNullOrEmpty(Comment) ? string.Empty : $"({Comment})")}";
    }
}