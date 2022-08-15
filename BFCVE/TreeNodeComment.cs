using Utilities;

/*@author Irena Bojanova(ivb)
 *@date - 5/01/2022 */

namespace BFCVE
{
    //adds Comment and an Unable/Disable flag to change color of node text
    public class TreeNodeComment : TreeNode<string>
    {
        public string? Comment { get => NodeData; set => NodeData = value; }
        public readonly bool Disabled;

        public TreeNodeComment(string id, string? toolTip, bool disable = false)
            : this(id, toolTip, Enumerable.Empty<TreeNode>(), disable) { }
        public TreeNodeComment(string id, string? toolTip, IEnumerable<TreeNode> children, bool disable = false)
            : base(id, toolTip, children)
        {
            if (Disabled = disable) ForeColor = SystemColors.GrayText; else Expand();
        }

        public IEnumerable<TreeNodeComment> SubNodes => Nodes.OfType<TreeNodeComment>();

        public static bool SelectByName(TreeView treeView, string name, string? comment = null)
        {
            var node = treeView.Nodes.Find(name, true).FirstOrDefault();
            if (node is TreeNodeComment xNode)
            {
                xNode.Comment = comment;
                treeView.SelectedNode = xNode.Disabled ? null : node;
            }
            else treeView.SelectedNode = node;
            return node is not null;
        }
    }

}
