using BF;
using Utilities;

/*@author Irena Bojanova(ivb)
 *@date - 5/01/2022 */

namespace CWEBF
{
    //Corresponds to ShowOther CWEs in the xslt
    public record OtherGroup (string Name, Color Fill);

    public class TreeNodeOtherGroup : TreeNode<OtherGroup>
    {
        public TreeNodeOtherGroup(string id, string? toolTip, OtherGroup cwes)
            : base(id, toolTip, cwes) { }
    }
}
