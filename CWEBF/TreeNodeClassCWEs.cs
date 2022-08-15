using BF;
using Utilities;

/*@author Irena Bojanova(ivb)
 *@date - 5/01/2022 */

namespace CWEBF
{
    public record ClassCWEs (CWE [] ShowCWEList, Color Color);

    public class TreeNodeClassCWEs : TreeNode<ClassCWEs>
    {
        public TreeNodeClassCWEs(string id, string? toolTip, ClassCWEs cwes)
            : base(id, toolTip, cwes) { }
    }
}
