using CWEBFDB;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml.Xsl;
using Utilities;
using static BF.BFParser;

/*@author Irena Bojanova(ivb)
 *@date - 4/20/2022 */

namespace CWEBF
{
    public partial class CWEBFForm : Form
    {
        private const string subdir = "\\_DB\\CWEBF";

        readonly IEnumerable<(TreeView treeView, TextBox textBox)> CommentMap;
        public CWEBFForm()
        {
            InitializeComponent();
            CommentMap = new[]
            {
                (classes, shouwClassCWEs),
            };
        }

        private void BFtoCWE_Load(object sender, EventArgs e)
        {
            classes.KeepSelectionColor();

            Editing = Edited = false;
            CWEBF = new CWEBFDB.CWEBF();
            //NewMappingNode(Nature.ChildOf);
        }

        #region Properties

        public CWEBFDB.CWEBF CWEBF
        {
            get; set;
            //get => new() { Clusters = classes.SubNodes<TreeNodeClusterCWEs>().Select(n => new ClusterCWEs { Name = n.Name, CWEs = n.SubNodes.Select(s => new ClassCWEs { Class = s.Name, ShowCWEsText = s.Comment }).ToArray() }).ToArray() };
            ////xxx color
            /////get => new CWEBFDB.CWEBF { Clusters = classes.SubNodes<TreeNodeX>().Select(n => new Cluster { Name = n.Name, CWEs = n.SubNodes.Select(s => new CWEs { Class = s.Name, Color = s.Color, ShowCWEsText = s.Comment }).ToArray() }).ToArray() };
            //set
            //{
            //    classes.SetNodes(Parser.GetClasses().Select(i =>
            //        new TreeNodeClassCWEs(i.Key.Name, i.Key.Definition, i.Value.Select(j =>
            //            new TreeNodeClassCWEs(j.Name, j.Definition) { 
            //                Comment = value.Clusters.SingleOrDefault(c => c.Name == i.Key.Name)?.CWEs.SingleOrDefault(m => m.Class == j.Name)?.ShowCWEsText,
            //                //Color = value.Clusters.SingleOrDefault(c => c.Name == i.Key.Name)?.CWEs.SingleOrDefault(m => m.Class == j.Name)?.Color
            //            }))));
            //    Editing = false;
            //}
        } 

        //public TreeNode? SelectedMappingNode
        //{
        //    get => classes.SelectedNode as System.Windows.Forms.TreeNode;
        //    set
        //    {
        //        classes.SelectedNode = value;
        //        if (value is null) AfterSelect(default!, default!);
        //    }
        //}

        //public Nature _CurrentNature = Nature.ChildOf;
        //public Nature CurrentNature
        //{
        //    get => _CurrentNature;
        //    set
        //    {
        //        _CurrentNature = value;

        //        //classes.SetNodes(Parser.GetClasses().Select(i =>
        //        //    new Utilities.TreeNodeX(i.Key.Name, i.Key.Definition, i.Value.Select(j =>
        //        //        new Utilities.TreeNodeX(j.Name, j.Definition)))));
        //    }
        //}

        //private void NewMappingNode(Nature nature)
        //{
        //    CurrentNature = nature;
        //}

        #endregion Properties

        #region Properties to control editing

        bool _Editing = false;
        bool Editing
        {
            get => _Editing;
            set { _Editing = value; }
        }

        bool _Edited = false;
        bool Edited
        {
            get => _Edited;
            set { _Edited = value; }
        }

        #endregion

        #region File New/Open/Save

        private void OnFileNew(object sender, EventArgs e)
        {
            if (Editing || Edited)
                if (MessageBox.Show("Changes are not saved. Continue anyway?", "New", MessageBoxButtons.YesNo) != DialogResult.Yes) 
                    return;

            Editing = Edited = false;
            CWEBF = new CWEBFDB.CWEBF();
            //Mapping = null;
            //NewMappingNode(Nature.ChildOf);
        }

        private void OnFileOpen(object sender, EventArgs e)
        {
            if ((Editing || Edited) && (MessageBox.Show("Changes are not saved. Continue anyway?", "Open", MessageBoxButtons.YesNo) != DialogResult.Yes)) return;
            if (openFileDialog.ShowDialog() != DialogResult.OK) return;

            if (TryLoadMapping(openFileDialog.FileName) is not CWEBFDB.CWEBF cwebf) return;
            Editing = Edited = false;
            CWEBF = cwebf;

            static CWEBFDB.CWEBF? TryLoadMapping(string fileName)
            {
                try { return CWEBFSerializer.Load(fileName); }
                catch (Exception error) { MessageBox.Show(error.Message, "Open"); return null; }
            }
        }

        private void OnFileSave(object sender, EventArgs e)
        {
            try
            {
                //save CWE to BF mappings
                //if (saveFileDialog.ShowDialog() != DialogResult.OK) return;
                //CWEBFSerializer.Save(CWEBF, saveFileDialog.FileName);

                //transform to PPT -- ran CWEBF.xslt
                var solutionDir = Directory.GetParent(Directory.GetCurrentDirectory())!.Parent!.Parent!.Parent!.FullName;
                var dir = solutionDir + subdir;
                //demo on create args
                //var aaa = XElement.Parse("<root abc='xyz'/>");
                //var bbb = XElement.Parse("<root abc='xyz'/>");
                //var x = new XsltArgumentList();
                //x.AddParam("showClassCWEs", String.Empty, aaa.CreateNavigator());
                //x.AddParam("showOtherCWEs", String.Empty, bbb.CreateNavigator());


                var args = new XsltArgumentList();
                args.AddParam("Clusters", String.Empty, BF.BFCWE.Clusters());
                Xslt.Xslt.Transform(Path.Combine(solutionDir, @"CWEBF\XSLT\CWEBF.xslt"), Path.Combine(dir, @"Input\cwec_v4.8.xml"), Path.Combine(dir, @"CWEBF.xml"), args:args);

                Editing = Edited = false;
            }
            catch (Exception error)
            {
                MessageBox.Show(error.Message);
            }
        }

        private void OnFileClose(object sender, EventArgs e)
        {
            if (Editing || Edited)
                if (MessageBox.Show("Changes are not saved. Continue anyway?", "Exit", MessageBoxButtons.YesNo) != DialogResult.Yes)
                    return;

            Close();
        }

        #endregion

        private void BeforeSelect(object sender, TreeViewCancelEventArgs e)
            => e.Cancel = e.Node.HasChildren() /*|| (e.Node is TreeNodeComment node && node.Disabled)*/;

        //private void AfterSelect(object sender, TreeViewEventArgs e)
        //{
        //    if (sender is not TreeView treeView
        //        || treeView.SelectedNode is not TreeNodeComment node
        //        || CommentMap.FirstOrDefault(m => m.treeView == treeView) is not (_, TextBox commentTextBox)) return;
        //    commentTextBox.Text = node.Comment;
        //    commentTextBox.Enabled = true;

        //    if (classes.SelectedNode is not TreeNodeComment selectedClass) return;
        //    Editing = true;

        //    operations.SetNodes(Parser.GetOperations(selectedClass.Name).Select(i =>
        //        new TreeNodeComment(i, Parser.GetDefinition(i))));

        //    consequences.SetNodes(Parser.GetConsequences(selectedClass.Name).Select(i =>
        //    {
        //        return new TreeNodeComment(i.Key.Name, i.Key.Definition, children: i.Value.Select(j =>
        //            new TreeNodeComment(j, Parser.GetDefinition(j))));
        //    }));
        //}

        private void Comment_TextChanged(object sender, EventArgs e) => Editing = true;

        //xxxdoes not take the last change 
        //private void Comment_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        //{
        //    if (sender is not TextBox textBox
        //        || CommentMap.FirstOrDefault(m => m.textBox == textBox) is not (TreeView treeView, _)
        //        || treeView.SelectedNode is not TreeNodeComment node) return;
        //    node.Comment = textBox.Text;
        //}

        private void colorButton_Click(object sender, EventArgs e)
        {
            if (colorDialog.ShowDialog() == DialogResult.OK)
            {
                colorButton.BackColor = colorDialog.Color;
                classes.SelectedNode.ForeColor = colorDialog.Color;
            }
        }

        private void transformButton_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }
    }
}
