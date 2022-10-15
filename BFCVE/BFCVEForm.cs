using static BF.BFParser;
using BFCVEDB;
using Utilities;
using BF;
using static BFCVE.TreeNodeComment;

/*@author Irena Bojanova(ivb)
 *@date - 2/27/2022 */

namespace BFCVE
{
    public partial class BFCVEForm : Form
    {
        const string Title = "Bugs Framework (BF)          ";
        string TitleFile {
            get => Text.Substring(Title.Length);
            set => Text = string.Concat(Title,value);
        }

        readonly IEnumerable<(TreeView treeView, TextBox textBox)> CommentMap;

        public BFCVEForm()
        {
            InitializeComponent();
            CommentMap = new[]
            {
                (causes, causeComment),
                (operations, operationComment),
                (consequences, consequenceComment),
                (operationAttributes, operationAttributeComment),
                (operandAttributes, operandAttributeComment),
            };
        }

        private void BF_Load(object sender, EventArgs e)
        {
            cve.KeepSelectionColor();
            classes.KeepSelectionColor();
            operations.KeepSelectionColor();
            causes.KeepSelectionColor();
            consequences.KeepSelectionColor();

            Editing = Edited = false;
            NewCVENode(BWF.Bug);
        }

        #region Properties

        public CVE? CVE
        {
            get => !CVENodes.Any() ? null : new CVE()
            {
                //xxx change name to be selected from list
                Name = Path.GetFileNameWithoutExtension(TitleFile),
                Bug = CVENodes.Take(1)?.SingleOrDefault(w => w.TypeBWF == BWF.Bug)?.Weakness ?? throw new Exception("Missing Bug"),
                Weaknesses = CVENodes.Where(w => w.TypeBWF == BWF.Weakness).Select(w => w.Weakness).ToArray(),
                Failure = CVENodes.TakeLast(1)?.SingleOrDefault(w => w.TypeBWF == BWF.Failure)?.Weakness ?? throw new Exception("Missing Failure"),
            };
            set
            {
                cve.Nodes.Clear();
                if (value != null)
                {
                    cve.Nodes.Add(new TreeNodeWeakness(value.Bug, BWF.Bug));
                    if (value.Weaknesses != null)
                        cve.Nodes.AddRange(value.Weaknesses.Select(w => new TreeNodeWeakness(w, BWF.Weakness)).ToArray());
                    cve.Nodes.Add(new TreeNodeWeakness(value.Failure, BWF.Failure));
                }
                SelectedCVENode = CVENodes.FirstOrDefault();
            }
        }
        public IEnumerable<TreeNodeWeakness> CVENodes => cve.SubNodes<TreeNodeWeakness>();

        public TreeNodeWeakness? SelectedCVENode
        {
            get => cve.SelectedNode as TreeNodeWeakness;
            set
            {
                cve.SelectedNode = value;
                if (value is null) CVE_AfterSelect(default!, default!);
            }
        }

        public BWF _CurrentType = BWF.Failure;
        public BWF CurrentType
        {
            get => _CurrentType;
            set
            {
                _CurrentType = value;
                BWFGroupBox.Text = value.ToString() + ":";

                classes.SetNodes(Parser.GetClasses(value).Select(i =>
                    new TreeNodeComment(i.Key, Parser.GetDefinition(i.Key), i.Value.Select(j =>
                        new TreeNodeComment(j, Parser.GetDefinition(j))))));
            }
        }

        private void NewCVENode(BWF typeBWF)
        {
            if (!TryCommit()) return;

            CurrentType = typeBWF;
            SelectedCVENode = null;
        }

        public Weakness? CurrentWeakness
        {
            get => classes.SelectedNode is not TreeNode classNode ? throw new Exception("Invalid Cause") : new Weakness()
            {
                Type = classNode.Parent.Name,
                Class = classNode.Name,
                Cause = causes.SelectedNode is TreeNodeComment causeNode && !causeNode.HasChildren() ?
                    new Cause() { Type = causeNode.Parent.Name, Value = causeNode.Name, Comment = causeNode.Comment }
                    : throw new Exception("Invalid Cause"),
                Operation = operations.SelectedNode is TreeNodeComment operationNode && !operationNode.HasChildren() ?
                    new Operation() { Value = operationNode.Name, Comment = operationNode.Comment }
                    : throw new Exception("Invalid Operation"),
                Consequence = consequences.SelectedNode is TreeNodeComment consequenceNode && !consequenceNode.HasChildren() ?
                    new Consequence() { Type = consequenceNode.Parent.Name, Value = consequenceNode.Name, Comment = consequenceNode.Comment }
                    : throw new Exception("Invalid Consequence"),
                Attributes = new Attributes
                {
                    OperationAttribute = new OperationAttribute()
                    {
                        Attribute = operationAttributes.SubNodes<TreeNodeComment>().SelectMany(t => t.SubNodes.Where(x => x.Checked).Select(x =>
                            new BFCVEDB.Attribute() { Type = t.Name, Value = x.Name, Comment = x.Comment })).ToArray()
                    },
                    OperandAttribute = operandAttributes.SubNodes<TreeNodeComment>().Select(t => new OperandAttribute()
                    {
                        Name = t.Name,
                        Attribute = t.SubNodes.SelectMany(a => a.SubNodes.Where(v => v.Checked)
                            .Select(v => new BFCVEDB.Attribute { Type = a.Name, Value = v.Name, Comment = v.Comment })).ToArray()
                    }).Where(x => x.Attribute!.Any()).ToArray()
                }
            };
            set
            {
                if (value is Weakness weakness && SelectByName(classes, weakness.Class))
                {

                    SelectByName(causes, weakness.Cause.Value, weakness.Cause.Comment);
                    SelectByName(operations, weakness.Operation.Value, weakness.Operation.Comment);
                    SelectByName(consequences, weakness.Consequence.Value, weakness.Consequence.Comment);

                    foreach (TreeNodeComment t in operationAttributes.Nodes)
                    {
                        t.Checked = false;
                        var tx = weakness.Attributes?.OperationAttribute?.Attribute?.SingleOrDefault(a => a.Type == t.Name);
                        foreach (TreeNodeComment v in t.Nodes)
                        {
                            v.Checked = (v.Name == tx?.Value); //xxx in check event uncheck the rest
                            if (v.Checked) v.Comment = tx?.Comment;
                        }
                    }

                    foreach (TreeNodeComment t in operandAttributes.Nodes)
                    {
                        t.Checked = false;
                        var tx = weakness.Attributes?.OperandAttribute?.SingleOrDefault(a => a.Name == t.Name);
                        foreach (TreeNodeComment n in t.Nodes)
                        {
                            n.Checked = false;
                            var nx = tx?.Attribute?.SingleOrDefault(a => a.Type == n.Name);
                            foreach (TreeNodeComment v in n.Nodes)
                            {
                                v.Checked = (v.Name == nx?.Value); //xxx in check event uncheck the rest
                                if (v.Checked) v.Comment = nx?.Comment;
                            }
                        }
                    }
                }
                else Classes_AfterSelect(classes, default!);
                Editing = false;
            }
        }

        Cause? PeerCause => (SelectedCVENode?.NextNode as TreeNodeWeakness)?.Weakness.Cause;
        Consequence? PeerConsequence => ((SelectedCVENode is TreeNodeWeakness current ? current.PrevNode : CVENodes.LastOrDefault()) as TreeNodeWeakness)?.Weakness.Consequence;

        #endregion Properties

        #region Properties to control editing

        bool _Editing = false;
        bool Editing {
            get => _Editing;
            set
            {
                _Editing = value;
                buttonCommit.Enabled = value;
                buttonRollback.Enabled = value;
            }
        }

        bool _Edited = false;
        bool Edited
        {
            get => _Edited;
            set { _Edited = value; }
        }

        private void Commit()
        {
            if (!Editing) return;
            if (CurrentWeakness is not Weakness weakness) return;

            if (SelectedCVENode is TreeNodeWeakness selection)
                selection.SetWeakness(weakness);
            else 
                cve.Nodes.Add(new TreeNodeWeakness(weakness, CurrentType));

            Editing = false;
            Edited = true;
        }

        private bool TryCommit()
        {
            try
            {
                Commit();
                return true; // !!! CurrentWeakness is not null
            }
            catch(Exception error) 
            {
                Editing = false;
                if (MessageBox.Show($"{error.Message}.{Environment.NewLine}Cancel the entries for this Bug/Weakness/Failure?", "Error", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    CurrentWeakness = SelectedCVENode?.Weakness; // Rollback!
                    return true;
                }
                else
                {
                    Editing = true;
                    return false;
                }
            } 
        }

        #endregion

        #region File New/Open/Save

        private void OnFileNew(object sender, EventArgs e)
        {
            if ((Editing || Edited) && (MessageBox.Show("Changes are not saved. Continue anyway?", "New", MessageBoxButtons.YesNo) != DialogResult.Yes)) return;
            TitleFile = "";

            Editing = Edited = false;
            CVE = null;
            NewCVENode(BWF.Bug);
        }

        private void OnFileOpen(object sender, EventArgs e)
        {
            if ((Editing || Edited) && (MessageBox.Show("Changes are not saved. Continue anyway?", "Open", MessageBoxButtons.YesNo) != DialogResult.Yes)) return;
            if (openFileDialog.ShowDialog() != DialogResult.OK) return;

            if (TryLoadCVE(openFileDialog.FileName) is not CVE cve) return;
            TitleFile = Path.GetFileNameWithoutExtension(openFileDialog.FileName);

            Editing = Edited = false;
            CVE = cve;

            static CVE? TryLoadCVE(string fileName)
            {
                try { return BFCVESerializer.Load(fileName); }
                catch (Exception error) { MessageBox.Show(error.Message, "Open"); return null; }
            }
        }

        private void OnFileSave(object sender, EventArgs e)
        {
            try
            {
                if (Editing) Commit();
                if (CVE is null) return;

                saveFileDialog.FileName = TitleFile;
                if (saveFileDialog.ShowDialog() != DialogResult.OK) return;
                TitleFile = Path.GetFileNameWithoutExtension(saveFileDialog.FileName);

                BFCVESerializer.Save(CVE, saveFileDialog.FileName);
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

        private void CVE_BeforeSelect(object sender, TreeViewCancelEventArgs e) => e.Cancel = !TryCommit();

        private void CVE_AfterSelect(object sender, TreeViewEventArgs e)
        {
            var node = SelectedCVENode;
            if (node is not null) CurrentType = node!.TypeBWF;
            CurrentWeakness = node?.Weakness;

            peerConseqeunce.Text = PeerConsequence?.Value;
            peerCause.Text = PeerCause?.Value;

            prevButton.Enabled = CurrentType != BWF.Bug;
            nextButton.Enabled = CurrentType != BWF.Failure;
            endButton.Enabled = cve.Nodes.Count > 0 || Editing;  
        }

        private void Classes_AfterSelect(object sender, TreeViewEventArgs e)
        {
            foreach (var (treeView, comment) in CommentMap)
            {
                treeView.Nodes.Clear();
                comment.Text = null;
                comment.Enabled = false;
            }
            if (classes.SelectedNode is not TreeNodeComment selectedClass) return; 
            Editing = true;

            var peerCauseType = PeerCause?.Type;
            var peerConsequenceType = PeerConsequence?.Type;
            var typeBWF = CurrentType;

            causes.SetNodes(Parser.GetCauses(selectedClass.Name).Select(i =>
            {
                var mismatch = (i.Key.BWFType != typeBWF) || (peerConsequenceType?.Equals(i.Key.Name) == false);
                return new TreeNodeComment(i.Key.Name, Parser.GetDefinition(i.Key.Name), disable: mismatch, children: i.Value.Select(j =>
                    new TreeNodeComment(j, Parser.GetDefinition(j), mismatch))) ;
            }));
            if (SelectedCVENode == null && PeerConsequence?.Value is string name) SelectByName(causes, name, hasComment:false);

            operations.SetNodes(Parser.GetOperations(selectedClass.Name).Select(i =>
                new TreeNodeComment(i, Parser.GetDefinition(i))));

            consequences.SetNodes(Parser.GetConsequences(selectedClass.Name).Select(i =>
            {
                var mismatch = peerCauseType?.Equals(i.Key.Name) == false;
                return new TreeNodeComment(i.Key.Name, Parser.GetDefinition(i.Key.Name), disable: mismatch, children: i.Value.Select(j =>
                    new TreeNodeComment(j, Parser.GetDefinition(j), mismatch)));
            }));

            operationAttributes.SetNodes(Parser.GetOperationAttributes(selectedClass.Name).Select(i =>
                new TreeNodeComment(i.Key, Parser.GetDefinition(i.Key), i.Value.Select(k =>
                    new TreeNodeComment(k, Parser.GetDefinition(k))))));

            operandAttributes.SetNodes(Parser.GetOperandAttributes(selectedClass.Name).Select(i =>
                new TreeNodeComment(i.Key, Parser.GetDefinition(i.Key), i.Value.Select(j =>
                    new TreeNodeComment(j.Key, Parser.GetDefinition(j.Key), j.Value.Select(k =>
                        new TreeNodeComment(k, Parser.GetDefinition(k))))))));
        }

        private void Any_BeforeSelect(object sender, TreeViewCancelEventArgs e)
            => e.Cancel = e.Node.HasChildren() || (e.Node is TreeNodeComment node && node.Disabled);

        private void Any_AfterSelect(object sender, TreeViewEventArgs e)
        {
            if (sender is not TreeView treeView
                || treeView.SelectedNode is not TreeNodeComment node
                || CommentMap.FirstOrDefault(m => m.treeView == treeView) is not (_, TextBox commentTextBox)) return;
            commentTextBox.Text = node.Comment;
            commentTextBox.Enabled = true;
            if ((treeView != operationAttributes) && (treeView != operandAttributes)) Editing = true;
        }

        private void Comment_TextChanged(object sender, EventArgs e) => Editing = true;

        private void Comment_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (sender is not TextBox textBox
                || CommentMap.FirstOrDefault(m => m.textBox == textBox) is not (TreeView treeView, _)
                || treeView.SelectedNode is not TreeNodeComment node) return;
            node.Comment = textBox.Text;
        }

        private void Attributes_BeforeCheck(object sender, TreeViewCancelEventArgs e)
        {
            if (e.Action == TreeViewAction.Unknown) return; // not user activity
            if (e.Node is not TreeNode node || node.Checked) return; // uncheck is always fine

            if (node.FirstNode != null) e.Cancel = true; // do not check non-leaf nodes
            else foreach (TreeNode peer in Peers(node)) peer.Checked = false; // uncheck peers

            static IEnumerable<TreeNode> Peers (TreeNode node)
            {
                for (TreeNode peer = node; (peer = peer.PrevNode) != null;) yield return peer;
                for (TreeNode peer = node; (peer = peer.NextNode) != null;) yield return peer;
            }
        }

        private void Attributes_AfterCheck(object sender, TreeViewEventArgs e) => Editing = true;

        private void ButtonRollback_Click(object sender, EventArgs e) => CurrentWeakness = SelectedCVENode?.Weakness;

        private void ButtonCommit_Click(object sender, EventArgs e)
        {
            try { Commit(); }
            catch (Exception error) { MessageBox.Show(error.Message); }
        }

        private void PrevButton_Click(object sender, EventArgs e)
        {
            if (!TryCommit()) return;
            this.cve.SelectedNode = this.SelectedCVENode is global::System.Windows.Forms.TreeNode node ? node.PrevNode : this.CVENodes.LastOrDefault<global::BFCVE.TreeNodeWeakness>();
        }

        private void NextButton_Click(object sender, EventArgs e)
        {
            if (!TryCommit()) return;

            if (SelectedCVENode?.NextNode is TreeNode nextNode)
                cve.SelectedNode = nextNode;
            else
                NewCVENode(CVENodes.Any() ? BWF.Weakness : BWF.Bug);
        }

        private void EndButton_Click(object sender, EventArgs e)
        {
            if (!TryCommit() || (cve.Nodes.Count == 0)) return;

            if (CVENodes.LastOrDefault() is TreeNodeWeakness node && node.TypeBWF == BWF.Failure)
                cve.SelectedNode = node;
            else
                NewCVENode(BWF.Failure);
        }

    }
}
