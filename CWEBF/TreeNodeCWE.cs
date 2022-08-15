using BF;
using Utilities;

/*@author Irena Bojanova(ivb)
 *@date - 5/01/2022 */

namespace CWEBF
{
    public record CWE (int ID, OtherGroup Group);

    public class TreeNodeCWE : TreeNode<CWE>
    {
        public TreeNodeCWE(string id, string? toolTip, CWE cwes)
            : base(id, toolTip, cwes) { }
    }
}
