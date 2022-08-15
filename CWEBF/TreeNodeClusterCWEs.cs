using BF;
using Utilities;

/*@author Irena Bojanova(ivb)
 *@date - 5/01/2022 */

namespace CWEBF
{
    //xxx rename General to Gray in the xslt
    public record ClusterCWEs (int[] GrayCWEList, int[] HideCWEList);

    public class TreeNodeClusterCWEs : TreeNode<ClusterCWEs>
    {
        public TreeNodeClusterCWEs(string id, string? toolTip, ClusterCWEs cwes)
            : base(id, toolTip, cwes) { }
    }
}
