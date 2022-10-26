using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;

/*@author Irena Bojanova(ivb)
 *@date - 2/27/2022 */

/*xxx Do THIS if package is missing
1.Install package from NuGet
- right click solution > "Manage NuGet Packages for Solution"
- Browse for WindowsDesktop.App.Ref
- Install to Utility project (althoug it may fail, it actually installs)

2.If different path/version, correct it in all three occurances in Utilities.csproj:
e.g. ...Microsoft.WindowsDesktop.App.Ref\6.0.8...
*/

namespace Utilities
{
    //adds new NodeData member to hold extra data 
    public class TreeNode<Data> : TreeNode
    {
        public Data? NodeData;

        public TreeNode(string id, string? toolTip, Data? nodeData = default)
            : this(id, toolTip, Enumerable.Empty<TreeNode>(), nodeData) { }
        public TreeNode(string id, string? toolTip, IEnumerable<System.Windows.Forms.TreeNode> children, Data? nodeData = default)
            : base(id, children.ToArray()) => (Name, ToolTipText, NodeData) = (id, toolTip, nodeData);

        //xxx should revice this xxx here and in the subclasses
        //public IEnumerable<TreeNode<Data>> SubNodes => Nodes.OfType<TreeNode<Data>>();
    }

    public static class TreeViewExtensions
    {
        public static void SetNodes(this TreeView treeView, IEnumerable<System.Windows.Forms.TreeNode> nodes)
        {
            treeView.Nodes.Clear();
            treeView.Nodes.AddRange(nodes.ToArray());
        }

        public static IEnumerable<T> SubNodes<T> (this TreeView treeView) where T : System.Windows.Forms.TreeNode => treeView.Nodes.OfType<T>();

        public static bool HasChildren(this System.Windows.Forms.TreeNode? node) => (node?.Nodes.Count ?? 0) > 0;

        public static void KeepSelectionColor(this TreeView treeView)
        {
            treeView.DrawMode = TreeViewDrawMode.OwnerDrawText;
            treeView.DrawNode += (sender, e) =>
            {
                if (e.State.HasFlag(TreeNodeStates.Selected))
                {
                    e.Graphics.FillRectangle(Brushes.Blue, e.Node!.Bounds);
                    Font nodeFont = e.Node.NodeFont;
                    if ((nodeFont == null) && (sender is TreeView treeView))
                        nodeFont = treeView.Font;
                    e.Graphics.DrawString(e.Node.Text, nodeFont!, Brushes.White, Rectangle.Inflate(e.Bounds, 2, 0));
                }
                else
                    e.DrawDefault = true;

                if (e.State.HasFlag(TreeNodeStates.Focused))
                {
                    using Pen focusPen = new(Color.Black);
                    focusPen.DashStyle = System.Drawing.Drawing2D.DashStyle.Dot;
                    Rectangle focusBounds = e.Node!.Bounds;
                    focusBounds.Size = new Size(focusBounds.Width - 1, focusBounds.Height - 1);
                    e.Graphics.DrawRectangle(focusPen, focusBounds);
                }
            };
        }
    }

}
