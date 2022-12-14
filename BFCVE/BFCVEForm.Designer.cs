using Utilities;

namespace BFCVE
{
    partial class BFCVEForm
        {
            /// <summary>
            ///  Required designer variable.
            /// </summary>
            private System.ComponentModel.IContainer components = null;

            /// <summary>
            ///  Clean up any resources being used.
            /// </summary>
            /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
            protected override void Dispose(bool disposing)
            {
                if (disposing && (components != null))
                {
                    components.Dispose();
                }
                base.Dispose(disposing);
            }

            #region Windows Form Designer generated code

            /// <summary>
            ///  Required method for Designer support - do not modify
            ///  the contents of this method with the code editor.
            /// </summary>
            private void InitializeComponent()
            {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(BFCVEForm));
            this.operations = new System.Windows.Forms.TreeView();
            this.consequenceComment = new System.Windows.Forms.TextBox();
            this.conseqeunceLabel = new System.Windows.Forms.Label();
            this.operationComment = new System.Windows.Forms.TextBox();
            this.operationCommentLabel = new System.Windows.Forms.Label();
            this.causeComment = new System.Windows.Forms.TextBox();
            this.causeCommentLabel = new System.Windows.Forms.Label();
            this.toolTip = new System.Windows.Forms.ToolTip(this.components);
            this.classes = new System.Windows.Forms.TreeView();
            this.consequences = new System.Windows.Forms.TreeView();
            this.causes = new System.Windows.Forms.TreeView();
            this.classLabel = new System.Windows.Forms.Label();
            this.toolStrip = new System.Windows.Forms.ToolStrip();
            this.newToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.openToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.saveToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.exitToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.bfcve = new System.Windows.Forms.TreeView();
            this.BFcveDescriptionLabel = new System.Windows.Forms.Label();
            this.prevButton = new System.Windows.Forms.Button();
            this.nextButton = new System.Windows.Forms.Button();
            this.peerConseqeunce = new System.Windows.Forms.TextBox();
            this.peerConseqeunceLabel = new System.Windows.Forms.Label();
            this.causeGroupBox = new System.Windows.Forms.GroupBox();
            this.operationAttributeComment = new System.Windows.Forms.TextBox();
            this.operationAttributes = new Utilities.TreeViewFix();
            this.operationGroupBox = new System.Windows.Forms.GroupBox();
            this.conseqeunceGroupBox = new System.Windows.Forms.GroupBox();
            this.WeaknessFailureGroupBox = new System.Windows.Forms.GroupBox();
            this.operandAttributsGgroupBox = new System.Windows.Forms.GroupBox();
            this.faultAttributes = new Utilities.TreeViewFix();
            this.faultAttributeComment = new System.Windows.Forms.TextBox();
            this.operandAttributeCommentLabel = new System.Windows.Forms.Label();
            this.buttonRollback = new System.Windows.Forms.Button();
            this.peerCause = new System.Windows.Forms.TextBox();
            this.peerCauseLabel = new System.Windows.Forms.Label();
            this.operationAttributesGroupBox = new System.Windows.Forms.GroupBox();
            this.operationAttributesCommentLabel = new System.Windows.Forms.Label();
            this.buttonCommit = new System.Windows.Forms.Button();
            this.endButton = new System.Windows.Forms.Button();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.menuStrip = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.newToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.openToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.cveComboBoxLabel = new System.Windows.Forms.Label();
            this.cveComboBox = new System.Windows.Forms.ComboBox();
            this.cveDescription = new System.Windows.Forms.TextBox();
            this.cveDesriptionLabel = new System.Windows.Forms.Label();
            this.toolStrip.SuspendLayout();
            this.causeGroupBox.SuspendLayout();
            this.operationGroupBox.SuspendLayout();
            this.conseqeunceGroupBox.SuspendLayout();
            this.WeaknessFailureGroupBox.SuspendLayout();
            this.operandAttributsGgroupBox.SuspendLayout();
            this.operationAttributesGroupBox.SuspendLayout();
            this.menuStrip.SuspendLayout();
            this.SuspendLayout();
            // 
            // operations
            // 
            this.operations.HideSelection = false;
            this.operations.Location = new System.Drawing.Point(6, 20);
            this.operations.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.operations.Name = "operations";
            this.operations.ShowNodeToolTips = true;
            this.operations.Size = new System.Drawing.Size(218, 211);
            this.operations.TabIndex = 141;
            this.operations.BeforeSelect += new System.Windows.Forms.TreeViewCancelEventHandler(this.Any_BeforeSelect);
            this.operations.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.Any_AfterSelect);
            // 
            // consequenceComment
            // 
            this.consequenceComment.Enabled = false;
            this.consequenceComment.Location = new System.Drawing.Point(6, 247);
            this.consequenceComment.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.consequenceComment.Multiline = true;
            this.consequenceComment.Name = "consequenceComment";
            this.consequenceComment.Size = new System.Drawing.Size(218, 28);
            this.consequenceComment.TabIndex = 156;
            this.consequenceComment.TextChanged += new System.EventHandler(this.Comment_TextChanged);
            this.consequenceComment.Validating += new System.ComponentModel.CancelEventHandler(this.Comment_Validating);
            // 
            // conseqeunceLabel
            // 
            this.conseqeunceLabel.AutoSize = true;
            this.conseqeunceLabel.Location = new System.Drawing.Point(4, 232);
            this.conseqeunceLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.conseqeunceLabel.Name = "conseqeunceLabel";
            this.conseqeunceLabel.Size = new System.Drawing.Size(64, 15);
            this.conseqeunceLabel.TabIndex = 155;
            this.conseqeunceLabel.Text = "Comment:";
            // 
            // operationComment
            // 
            this.operationComment.Enabled = false;
            this.operationComment.Location = new System.Drawing.Point(7, 247);
            this.operationComment.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.operationComment.Multiline = true;
            this.operationComment.Name = "operationComment";
            this.operationComment.Size = new System.Drawing.Size(218, 28);
            this.operationComment.TabIndex = 146;
            this.operationComment.TextChanged += new System.EventHandler(this.Comment_TextChanged);
            this.operationComment.Validating += new System.ComponentModel.CancelEventHandler(this.Comment_Validating);
            // 
            // operationCommentLabel
            // 
            this.operationCommentLabel.AutoSize = true;
            this.operationCommentLabel.Location = new System.Drawing.Point(4, 232);
            this.operationCommentLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.operationCommentLabel.Name = "operationCommentLabel";
            this.operationCommentLabel.Size = new System.Drawing.Size(64, 15);
            this.operationCommentLabel.TabIndex = 145;
            this.operationCommentLabel.Text = "Comment:";
            // 
            // causeComment
            // 
            this.causeComment.Enabled = false;
            this.causeComment.Location = new System.Drawing.Point(6, 247);
            this.causeComment.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.causeComment.Multiline = true;
            this.causeComment.Name = "causeComment";
            this.causeComment.Size = new System.Drawing.Size(218, 28);
            this.causeComment.TabIndex = 136;
            this.causeComment.TextChanged += new System.EventHandler(this.Comment_TextChanged);
            this.causeComment.Validating += new System.ComponentModel.CancelEventHandler(this.Comment_Validating);
            // 
            // causeCommentLabel
            // 
            this.causeCommentLabel.AutoSize = true;
            this.causeCommentLabel.Location = new System.Drawing.Point(4, 232);
            this.causeCommentLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.causeCommentLabel.Name = "causeCommentLabel";
            this.causeCommentLabel.Size = new System.Drawing.Size(64, 15);
            this.causeCommentLabel.TabIndex = 135;
            this.causeCommentLabel.Text = "Comment:";
            // 
            // toolTip
            // 
            this.toolTip.AutoPopDelay = 5000;
            this.toolTip.BackColor = System.Drawing.Color.Gray;
            this.toolTip.ForeColor = System.Drawing.Color.IndianRed;
            this.toolTip.InitialDelay = 0;
            this.toolTip.IsBalloon = true;
            this.toolTip.OwnerDraw = true;
            this.toolTip.ReshowDelay = 100;
            this.toolTip.ToolTipTitle = "Definition: ";
            // 
            // classes
            // 
            this.classes.HideSelection = false;
            this.classes.Location = new System.Drawing.Point(12, 40);
            this.classes.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.classes.Name = "classes";
            this.classes.ShowNodeToolTips = true;
            this.classes.Size = new System.Drawing.Size(84, 577);
            this.classes.TabIndex = 111;
            this.classes.BeforeSelect += new System.Windows.Forms.TreeViewCancelEventHandler(this.Any_BeforeSelect);
            this.classes.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.Classes_AfterSelect);
            // 
            // consequences
            // 
            this.consequences.HideSelection = false;
            this.consequences.Location = new System.Drawing.Point(6, 20);
            this.consequences.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.consequences.Name = "consequences";
            this.consequences.ShowNodeToolTips = true;
            this.consequences.Size = new System.Drawing.Size(218, 211);
            this.consequences.TabIndex = 151;
            this.consequences.BeforeSelect += new System.Windows.Forms.TreeViewCancelEventHandler(this.Any_BeforeSelect);
            this.consequences.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.Any_AfterSelect);
            // 
            // causes
            // 
            this.causes.HideSelection = false;
            this.causes.Location = new System.Drawing.Point(6, 20);
            this.causes.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.causes.Name = "causes";
            this.causes.ShowNodeToolTips = true;
            this.causes.Size = new System.Drawing.Size(218, 211);
            this.causes.TabIndex = 131;
            this.causes.BeforeSelect += new System.Windows.Forms.TreeViewCancelEventHandler(this.Any_BeforeSelect);
            this.causes.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.Any_AfterSelect);
            // 
            // classLabel
            // 
            this.classLabel.AutoSize = true;
            this.classLabel.Location = new System.Drawing.Point(12, 25);
            this.classLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.classLabel.Name = "classLabel";
            this.classLabel.Size = new System.Drawing.Size(53, 15);
            this.classLabel.TabIndex = 110;
            this.classLabel.Text = "BF Class:";
            // 
            // toolStrip
            // 
            this.toolStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newToolStripButton,
            this.openToolStripButton,
            this.saveToolStripButton,
            this.exitToolStripButton});
            this.toolStrip.Location = new System.Drawing.Point(0, 24);
            this.toolStrip.Name = "toolStrip";
            this.toolStrip.Padding = new System.Windows.Forms.Padding(0, 0, 2, 0);
            this.toolStrip.Size = new System.Drawing.Size(1343, 25);
            this.toolStrip.TabIndex = 66;
            this.toolStrip.Text = "toolStrip1";
            // 
            // newToolStripButton
            // 
            this.newToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.newToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("newToolStripButton.Image")));
            this.newToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.newToolStripButton.Name = "newToolStripButton";
            this.newToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.newToolStripButton.Text = "New";
            this.newToolStripButton.Click += new System.EventHandler(this.OnFileNew);
            // 
            // openToolStripButton
            // 
            this.openToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.openToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("openToolStripButton.Image")));
            this.openToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.openToolStripButton.Name = "openToolStripButton";
            this.openToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.openToolStripButton.Text = "Open";
            this.openToolStripButton.Click += new System.EventHandler(this.OnFileOpen);
            // 
            // saveToolStripButton
            // 
            this.saveToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.saveToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("saveToolStripButton.Image")));
            this.saveToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.saveToolStripButton.Name = "saveToolStripButton";
            this.saveToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.saveToolStripButton.Text = "Save";
            this.saveToolStripButton.Click += new System.EventHandler(this.OnFileSave);
            // 
            // exitToolStripButton
            // 
            this.exitToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.exitToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("exitToolStripButton.Image")));
            this.exitToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.exitToolStripButton.Name = "exitToolStripButton";
            this.exitToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.exitToolStripButton.Text = "Exit";
            this.exitToolStripButton.Click += new System.EventHandler(this.OnFileClose);
            // 
            // bfcve
            // 
            this.bfcve.FullRowSelect = true;
            this.bfcve.HideSelection = false;
            this.bfcve.Location = new System.Drawing.Point(18, 150);
            this.bfcve.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.bfcve.Name = "bfcve";
            this.bfcve.ShowNodeToolTips = true;
            this.bfcve.Size = new System.Drawing.Size(110, 601);
            this.bfcve.TabIndex = 11;
            this.bfcve.BeforeSelect += new System.Windows.Forms.TreeViewCancelEventHandler(this.CVE_BeforeSelect);
            this.bfcve.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.CVE_AfterSelect);
            // 
            // BFcveDescriptionLabel
            // 
            this.BFcveDescriptionLabel.AutoSize = true;
            this.BFcveDescriptionLabel.Location = new System.Drawing.Point(18, 134);
            this.BFcveDescriptionLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.BFcveDescriptionLabel.Name = "BFcveDescriptionLabel";
            this.BFcveDescriptionLabel.Size = new System.Drawing.Size(110, 15);
            this.BFcveDescriptionLabel.TabIndex = 10;
            this.BFcveDescriptionLabel.Text = "BF CVE Description:";
            // 
            // prevButton
            // 
            this.prevButton.Location = new System.Drawing.Point(1062, 772);
            this.prevButton.Margin = new System.Windows.Forms.Padding(2);
            this.prevButton.Name = "prevButton";
            this.prevButton.Size = new System.Drawing.Size(80, 22);
            this.prevButton.TabIndex = 72;
            this.prevButton.Text = "<<";
            this.prevButton.UseVisualStyleBackColor = true;
            this.prevButton.Click += new System.EventHandler(this.PrevButton_Click);
            // 
            // nextButton
            // 
            this.nextButton.Location = new System.Drawing.Point(1153, 771);
            this.nextButton.Margin = new System.Windows.Forms.Padding(2);
            this.nextButton.Name = "nextButton";
            this.nextButton.Size = new System.Drawing.Size(80, 22);
            this.nextButton.TabIndex = 73;
            this.nextButton.Text = ">>";
            this.nextButton.UseVisualStyleBackColor = true;
            this.nextButton.Click += new System.EventHandler(this.NextButton_Click);
            // 
            // peerConseqeunce
            // 
            this.peerConseqeunce.Location = new System.Drawing.Point(130, 40);
            this.peerConseqeunce.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.peerConseqeunce.Multiline = true;
            this.peerConseqeunce.Name = "peerConseqeunce";
            this.peerConseqeunce.ReadOnly = true;
            this.peerConseqeunce.Size = new System.Drawing.Size(218, 28);
            this.peerConseqeunce.TabIndex = 121;
            // 
            // peerConseqeunceLabel
            // 
            this.peerConseqeunceLabel.AutoSize = true;
            this.peerConseqeunceLabel.Location = new System.Drawing.Point(130, 23);
            this.peerConseqeunceLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.peerConseqeunceLabel.Name = "peerConseqeunceLabel";
            this.peerConseqeunceLabel.Size = new System.Drawing.Size(83, 15);
            this.peerConseqeunceLabel.TabIndex = 120;
            this.peerConseqeunceLabel.Text = "Previous Error:";
            // 
            // causeGroupBox
            // 
            this.causeGroupBox.Controls.Add(this.causes);
            this.causeGroupBox.Controls.Add(this.causeComment);
            this.causeGroupBox.Controls.Add(this.causeCommentLabel);
            this.causeGroupBox.Location = new System.Drawing.Point(151, 76);
            this.causeGroupBox.Margin = new System.Windows.Forms.Padding(2);
            this.causeGroupBox.Name = "causeGroupBox";
            this.causeGroupBox.Padding = new System.Windows.Forms.Padding(2);
            this.causeGroupBox.Size = new System.Drawing.Size(229, 282);
            this.causeGroupBox.TabIndex = 130;
            this.causeGroupBox.TabStop = false;
            this.causeGroupBox.Text = "Bug/Fault Cause:";
            // 
            // operationAttributeComment
            // 
            this.operationAttributeComment.Enabled = false;
            this.operationAttributeComment.Location = new System.Drawing.Point(400, 625);
            this.operationAttributeComment.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.operationAttributeComment.Multiline = true;
            this.operationAttributeComment.Name = "operationAttributeComment";
            this.operationAttributeComment.Size = new System.Drawing.Size(218, 28);
            this.operationAttributeComment.TabIndex = 169;
            this.operationAttributeComment.TextChanged += new System.EventHandler(this.Comment_TextChanged);
            this.operationAttributeComment.Validating += new System.ComponentModel.CancelEventHandler(this.Comment_Validating);
            // 
            // operationAttributes
            // 
            this.operationAttributes.CheckBoxes = true;
            this.operationAttributes.HideSelection = false;
            this.operationAttributes.Location = new System.Drawing.Point(400, 398);
            this.operationAttributes.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.operationAttributes.Name = "operationAttributes";
            this.operationAttributes.ShowNodeToolTips = true;
            this.operationAttributes.Size = new System.Drawing.Size(218, 211);
            this.operationAttributes.TabIndex = 167;
            this.operationAttributes.BeforeCheck += new System.Windows.Forms.TreeViewCancelEventHandler(this.Attributes_BeforeCheck);
            this.operationAttributes.AfterCheck += new System.Windows.Forms.TreeViewEventHandler(this.Attributes_AfterCheck);
            this.operationAttributes.BeforeSelect += new System.Windows.Forms.TreeViewCancelEventHandler(this.Any_BeforeSelect);
            this.operationAttributes.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.Any_AfterSelect);
            // 
            // operationGroupBox
            // 
            this.operationGroupBox.Controls.Add(this.operations);
            this.operationGroupBox.Controls.Add(this.operationComment);
            this.operationGroupBox.Controls.Add(this.operationCommentLabel);
            this.operationGroupBox.Location = new System.Drawing.Point(393, 76);
            this.operationGroupBox.Margin = new System.Windows.Forms.Padding(2);
            this.operationGroupBox.Name = "operationGroupBox";
            this.operationGroupBox.Padding = new System.Windows.Forms.Padding(2);
            this.operationGroupBox.Size = new System.Drawing.Size(229, 282);
            this.operationGroupBox.TabIndex = 140;
            this.operationGroupBox.TabStop = false;
            this.operationGroupBox.Text = "Operation:";
            // 
            // conseqeunceGroupBox
            // 
            this.conseqeunceGroupBox.Controls.Add(this.consequenceComment);
            this.conseqeunceGroupBox.Controls.Add(this.conseqeunceLabel);
            this.conseqeunceGroupBox.Controls.Add(this.consequences);
            this.conseqeunceGroupBox.Location = new System.Drawing.Point(635, 76);
            this.conseqeunceGroupBox.Margin = new System.Windows.Forms.Padding(2);
            this.conseqeunceGroupBox.Name = "conseqeunceGroupBox";
            this.conseqeunceGroupBox.Padding = new System.Windows.Forms.Padding(2);
            this.conseqeunceGroupBox.Size = new System.Drawing.Size(229, 282);
            this.conseqeunceGroupBox.TabIndex = 150;
            this.conseqeunceGroupBox.TabStop = false;
            this.conseqeunceGroupBox.Text = "Error/Final Error Conseqeunce:";
            // 
            // WeaknessFailureGroupBox
            // 
            this.WeaknessFailureGroupBox.Controls.Add(this.operandAttributsGgroupBox);
            this.WeaknessFailureGroupBox.Controls.Add(this.buttonRollback);
            this.WeaknessFailureGroupBox.Controls.Add(this.operationAttributeComment);
            this.WeaknessFailureGroupBox.Controls.Add(this.conseqeunceGroupBox);
            this.WeaknessFailureGroupBox.Controls.Add(this.peerConseqeunce);
            this.WeaknessFailureGroupBox.Controls.Add(this.peerConseqeunceLabel);
            this.WeaknessFailureGroupBox.Controls.Add(this.peerCause);
            this.WeaknessFailureGroupBox.Controls.Add(this.operationAttributes);
            this.WeaknessFailureGroupBox.Controls.Add(this.peerCauseLabel);
            this.WeaknessFailureGroupBox.Controls.Add(this.causeGroupBox);
            this.WeaknessFailureGroupBox.Controls.Add(this.operationGroupBox);
            this.WeaknessFailureGroupBox.Controls.Add(this.classes);
            this.WeaknessFailureGroupBox.Controls.Add(this.classLabel);
            this.WeaknessFailureGroupBox.Controls.Add(this.operationAttributesGroupBox);
            this.WeaknessFailureGroupBox.Location = new System.Drawing.Point(141, 134);
            this.WeaknessFailureGroupBox.Margin = new System.Windows.Forms.Padding(2);
            this.WeaknessFailureGroupBox.Name = "WeaknessFailureGroupBox";
            this.WeaknessFailureGroupBox.Padding = new System.Windows.Forms.Padding(2);
            this.WeaknessFailureGroupBox.Size = new System.Drawing.Size(900, 677);
            this.WeaknessFailureGroupBox.TabIndex = 100;
            this.WeaknessFailureGroupBox.TabStop = false;
            this.WeaknessFailureGroupBox.Text = "Weakness/Failure";
            // 
            // operandAttributsGgroupBox
            // 
            this.operandAttributsGgroupBox.Controls.Add(this.faultAttributes);
            this.operandAttributsGgroupBox.Controls.Add(this.faultAttributeComment);
            this.operandAttributsGgroupBox.Controls.Add(this.operandAttributeCommentLabel);
            this.operandAttributsGgroupBox.Location = new System.Drawing.Point(156, 382);
            this.operandAttributsGgroupBox.Name = "operandAttributsGgroupBox";
            this.operandAttributsGgroupBox.Size = new System.Drawing.Size(229, 278);
            this.operandAttributsGgroupBox.TabIndex = 205;
            this.operandAttributsGgroupBox.TabStop = false;
            this.operandAttributsGgroupBox.Text = "Fault Attributes:";
            // 
            // faultAttributes
            // 
            this.faultAttributes.CheckBoxes = true;
            this.faultAttributes.HideSelection = false;
            this.faultAttributes.Location = new System.Drawing.Point(-5, 16);
            this.faultAttributes.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.faultAttributes.Name = "faultAttributes";
            this.faultAttributes.ShowNodeToolTips = true;
            this.faultAttributes.Size = new System.Drawing.Size(218, 211);
            this.faultAttributes.TabIndex = 182;
            this.faultAttributes.BeforeCheck += new System.Windows.Forms.TreeViewCancelEventHandler(this.Attributes_BeforeCheck);
            this.faultAttributes.AfterCheck += new System.Windows.Forms.TreeViewEventHandler(this.Attributes_AfterCheck);
            this.faultAttributes.BeforeSelect += new System.Windows.Forms.TreeViewCancelEventHandler(this.Any_BeforeSelect);
            this.faultAttributes.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.Any_AfterSelect);
            // 
            // faultAttributeComment
            // 
            this.faultAttributeComment.Enabled = false;
            this.faultAttributeComment.Location = new System.Drawing.Point(6, 243);
            this.faultAttributeComment.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.faultAttributeComment.Multiline = true;
            this.faultAttributeComment.Name = "faultAttributeComment";
            this.faultAttributeComment.Size = new System.Drawing.Size(218, 28);
            this.faultAttributeComment.TabIndex = 184;
            // 
            // operandAttributeCommentLabel
            // 
            this.operandAttributeCommentLabel.AutoSize = true;
            this.operandAttributeCommentLabel.Location = new System.Drawing.Point(5, 228);
            this.operandAttributeCommentLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.operandAttributeCommentLabel.Name = "operandAttributeCommentLabel";
            this.operandAttributeCommentLabel.Size = new System.Drawing.Size(64, 15);
            this.operandAttributeCommentLabel.TabIndex = 183;
            this.operandAttributeCommentLabel.Text = "Comment:";
            // 
            // buttonRollback
            // 
            this.buttonRollback.Location = new System.Drawing.Point(12, 637);
            this.buttonRollback.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.buttonRollback.Name = "buttonRollback";
            this.buttonRollback.Size = new System.Drawing.Size(82, 22);
            this.buttonRollback.TabIndex = 202;
            this.buttonRollback.Text = "Rollback";
            this.buttonRollback.UseVisualStyleBackColor = true;
            this.buttonRollback.Click += new System.EventHandler(this.ButtonRollback_Click);
            // 
            // peerCause
            // 
            this.peerCause.Location = new System.Drawing.Point(671, 387);
            this.peerCause.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.peerCause.Multiline = true;
            this.peerCause.Name = "peerCause";
            this.peerCause.ReadOnly = true;
            this.peerCause.Size = new System.Drawing.Size(218, 28);
            this.peerCause.TabIndex = 181;
            // 
            // peerCauseLabel
            // 
            this.peerCauseLabel.AutoSize = true;
            this.peerCauseLabel.Location = new System.Drawing.Point(671, 371);
            this.peerCauseLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.peerCauseLabel.Name = "peerCauseLabel";
            this.peerCauseLabel.Size = new System.Drawing.Size(64, 15);
            this.peerCauseLabel.TabIndex = 180;
            this.peerCauseLabel.Text = "Next Fault:";
            // 
            // operationAttributesGroupBox
            // 
            this.operationAttributesGroupBox.Controls.Add(this.operationAttributesCommentLabel);
            this.operationAttributesGroupBox.Location = new System.Drawing.Point(394, 382);
            this.operationAttributesGroupBox.Name = "operationAttributesGroupBox";
            this.operationAttributesGroupBox.Size = new System.Drawing.Size(229, 278);
            this.operationAttributesGroupBox.TabIndex = 203;
            this.operationAttributesGroupBox.TabStop = false;
            this.operationAttributesGroupBox.Text = "Opertion Attributes:";
            // 
            // operationAttributesCommentLabel
            // 
            this.operationAttributesCommentLabel.AutoSize = true;
            this.operationAttributesCommentLabel.Location = new System.Drawing.Point(5, 228);
            this.operationAttributesCommentLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.operationAttributesCommentLabel.Name = "operationAttributesCommentLabel";
            this.operationAttributesCommentLabel.Size = new System.Drawing.Size(64, 15);
            this.operationAttributesCommentLabel.TabIndex = 204;
            this.operationAttributesCommentLabel.Text = "Comment:";
            // 
            // buttonCommit
            // 
            this.buttonCommit.Location = new System.Drawing.Point(27, 771);
            this.buttonCommit.Margin = new System.Windows.Forms.Padding(3, 2, 3, 2);
            this.buttonCommit.Name = "buttonCommit";
            this.buttonCommit.Size = new System.Drawing.Size(82, 22);
            this.buttonCommit.TabIndex = 201;
            this.buttonCommit.Text = "Commit";
            this.buttonCommit.UseVisualStyleBackColor = true;
            this.buttonCommit.Visible = false;
            this.buttonCommit.Click += new System.EventHandler(this.ButtonCommit_Click);
            // 
            // endButton
            // 
            this.endButton.Location = new System.Drawing.Point(1244, 771);
            this.endButton.Margin = new System.Windows.Forms.Padding(2);
            this.endButton.Name = "endButton";
            this.endButton.Size = new System.Drawing.Size(80, 22);
            this.endButton.TabIndex = 74;
            this.endButton.Text = "Finish";
            this.endButton.UseVisualStyleBackColor = true;
            this.endButton.Click += new System.EventHandler(this.EndButton_Click);
            // 
            // saveFileDialog
            // 
            this.saveFileDialog.DefaultExt = "bfcve";
            this.saveFileDialog.Title = "Save CVE";
            // 
            // menuStrip
            // 
            this.menuStrip.ImageScalingSize = new System.Drawing.Size(32, 32);
            this.menuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem});
            this.menuStrip.Location = new System.Drawing.Point(0, 0);
            this.menuStrip.Name = "menuStrip";
            this.menuStrip.Padding = new System.Windows.Forms.Padding(4, 1, 0, 1);
            this.menuStrip.Size = new System.Drawing.Size(1343, 24);
            this.menuStrip.TabIndex = 204;
            this.menuStrip.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newToolStripMenuItem,
            this.openToolStripMenuItem,
            this.saveToolStripMenuItem,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(37, 22);
            this.fileToolStripMenuItem.Text = "File";
            // 
            // newToolStripMenuItem
            // 
            this.newToolStripMenuItem.Name = "newToolStripMenuItem";
            this.newToolStripMenuItem.Size = new System.Drawing.Size(103, 22);
            this.newToolStripMenuItem.Text = "New";
            this.newToolStripMenuItem.Click += new System.EventHandler(this.OnFileNew);
            // 
            // openToolStripMenuItem
            // 
            this.openToolStripMenuItem.Name = "openToolStripMenuItem";
            this.openToolStripMenuItem.Size = new System.Drawing.Size(103, 22);
            this.openToolStripMenuItem.Text = "Open";
            this.openToolStripMenuItem.Click += new System.EventHandler(this.OnFileOpen);
            // 
            // saveToolStripMenuItem
            // 
            this.saveToolStripMenuItem.Name = "saveToolStripMenuItem";
            this.saveToolStripMenuItem.Size = new System.Drawing.Size(103, 22);
            this.saveToolStripMenuItem.Text = "Save";
            this.saveToolStripMenuItem.Click += new System.EventHandler(this.OnFileSave);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(103, 22);
            this.exitToolStripMenuItem.Text = "Exit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.OnFileClose);
            // 
            // cveComboBoxLabel
            // 
            this.cveComboBoxLabel.AutoSize = true;
            this.cveComboBoxLabel.Location = new System.Drawing.Point(18, 70);
            this.cveComboBoxLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.cveComboBoxLabel.Name = "cveComboBoxLabel";
            this.cveComboBoxLabel.Size = new System.Drawing.Size(31, 15);
            this.cveComboBoxLabel.TabIndex = 208;
            this.cveComboBoxLabel.Text = "CVE:";
            // 
            // cveComboBox
            // 
            this.cveComboBox.DisplayMember = "cve";
            this.cveComboBox.FormattingEnabled = true;
            this.cveComboBox.Location = new System.Drawing.Point(18, 88);
            this.cveComboBox.Name = "cveComboBox";
            this.cveComboBox.Size = new System.Drawing.Size(121, 23);
            this.cveComboBox.TabIndex = 207;
            this.cveComboBox.SelectedIndexChanged += new System.EventHandler(this.cveComboBox_SelectedIndexChanged);
            // 
            // cveDescription
            // 
            this.cveDescription.Enabled = false;
            this.cveDescription.Location = new System.Drawing.Point(153, 83);
            this.cveDescription.Margin = new System.Windows.Forms.Padding(2, 1, 2, 1);
            this.cveDescription.Multiline = true;
            this.cveDescription.Name = "cveDescription";
            this.cveDescription.Size = new System.Drawing.Size(888, 28);
            this.cveDescription.TabIndex = 138;
            // 
            // cveDesriptionLabel
            // 
            this.cveDesriptionLabel.AutoSize = true;
            this.cveDesriptionLabel.Location = new System.Drawing.Point(151, 68);
            this.cveDesriptionLabel.Margin = new System.Windows.Forms.Padding(2, 0, 2, 0);
            this.cveDesriptionLabel.Name = "cveDesriptionLabel";
            this.cveDesriptionLabel.Size = new System.Drawing.Size(88, 15);
            this.cveDesriptionLabel.TabIndex = 137;
            this.cveDesriptionLabel.Text = "CVE Desription:";
            // 
            // BFCVEForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(1343, 824);
            this.Controls.Add(this.cveDescription);
            this.Controls.Add(this.cveDesriptionLabel);
            this.Controls.Add(this.cveComboBoxLabel);
            this.Controls.Add(this.cveComboBox);
            this.Controls.Add(this.buttonCommit);
            this.Controls.Add(this.endButton);
            this.Controls.Add(this.bfcve);
            this.Controls.Add(this.BFcveDescriptionLabel);
            this.Controls.Add(this.nextButton);
            this.Controls.Add(this.toolStrip);
            this.Controls.Add(this.menuStrip);
            this.Controls.Add(this.prevButton);
            this.Controls.Add(this.WeaknessFailureGroupBox);
            this.MainMenuStrip = this.menuStrip;
            this.Margin = new System.Windows.Forms.Padding(2);
            this.Name = "BFCVEForm";
            this.Text = "Bugs Framework (BF)";
            this.Load += new System.EventHandler(this.BF_Load);
            this.toolStrip.ResumeLayout(false);
            this.toolStrip.PerformLayout();
            this.causeGroupBox.ResumeLayout(false);
            this.causeGroupBox.PerformLayout();
            this.operationGroupBox.ResumeLayout(false);
            this.operationGroupBox.PerformLayout();
            this.conseqeunceGroupBox.ResumeLayout(false);
            this.conseqeunceGroupBox.PerformLayout();
            this.WeaknessFailureGroupBox.ResumeLayout(false);
            this.WeaknessFailureGroupBox.PerformLayout();
            this.operandAttributsGgroupBox.ResumeLayout(false);
            this.operandAttributsGgroupBox.PerformLayout();
            this.operationAttributesGroupBox.ResumeLayout(false);
            this.operationAttributesGroupBox.PerformLayout();
            this.menuStrip.ResumeLayout(false);
            this.menuStrip.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

            }

        #endregion

            private Label BFcveDescriptionLabel;
            private TreeView bfcve;

            private GroupBox WeaknessFailureGroupBox;

            private Label classLabel;
            private TreeView classes;

            private GroupBox causeGroupBox;
            private TreeView causes;
            private Label causeCommentLabel;
            public TextBox causeComment;

            private GroupBox operationGroupBox;
            private TreeView operations;
            private Label operationCommentLabel;
            public TextBox operationComment;

            private GroupBox conseqeunceGroupBox;
            private TreeView consequences;
            private Label conseqeunceLabel;
            public TextBox consequenceComment;

            private Label peerConseqeunceLabel;
            public TextBox peerConseqeunce;

            private Label peerCauseLabel;
            public TextBox peerCause;

            private MenuStrip menuStrip;
            private ToolStripMenuItem fileToolStripMenuItem;
            private ToolStripMenuItem newToolStripMenuItem;
            private ToolStripMenuItem openToolStripMenuItem;
            private ToolStripMenuItem saveToolStripMenuItem;
            private ToolStripMenuItem exitToolStripMenuItem;

            private ToolStrip toolStrip;
            private ToolStripButton newToolStripButton;
            private ToolStripButton openToolStripButton;
            private ToolStripButton saveToolStripButton;
            private ToolStripButton exitToolStripButton;
            private ToolTip toolTip;

            private Button prevButton;
            private Button nextButton;
            private Button endButton;

            private SaveFileDialog saveFileDialog;
            private OpenFileDialog openFileDialog;

            private Button buttonCommit;
            private Button buttonRollback;

            private GroupBox operationAttributesGroupBox;
            private TreeViewFix operationAttributes;
            public TextBox operationAttributeComment;
            private Label operationAttributesCommentLabel;
        private GroupBox operandAttributsGgroupBox;
        private TreeViewFix faultAttributes;
        public TextBox faultAttributeComment;
        private Label operandAttributeCommentLabel;
        private Label cveComboBoxLabel;
        private ComboBox cveComboBox;
        public TextBox cveDescription;
        private Label cveDesriptionLabel;
    }
    }