using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Drawing;

namespace Blue.Airport.Win.Lib
{
    public class frmSQLEdit : Form
    {
        // Fields
        private Button btCancel;
        private Button btSave;
        private Container components;
        private Label label1;
        private Label label2;
        public sqlitem saveditem;
        public TextBox txtsql;
        public TextBox txttitle;

        // Methods
        public frmSQLEdit()
        {
            this.InitializeComponent();
        }

        private void btCancel_Click(object sender, EventArgs e)
        {
            base.DialogResult = DialogResult.Cancel;
            base.Close();
        }

        private void btSave_Click(object sender, EventArgs e)
        {
            if (this.txttitle.Text == "")
            {
                MessageBox.Show("查询项标题不能为空!", "提交错误", MessageBoxButtons.OK, MessageBoxIcon.Hand);
            }
            else
            {
                this.saveditem.sqlname = this.txttitle.Text;
                this.saveditem.sqlstring = this.txtsql.Text;
                base.DialogResult = DialogResult.OK;
                base.Close();
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing && (this.components != null))
            {
                this.components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void frmSQLEdit_Load(object sender, EventArgs e)
        {
            this.saveditem = new sqlitem();
        }

        private void InitializeComponent()
        {
            this.label1 = new Label();
            this.txttitle = new TextBox();
            this.label2 = new Label();
            this.txtsql = new TextBox();
            this.btSave = new Button();
            this.btCancel = new Button();
            base.SuspendLayout();
            this.label1.AutoSize = true;
            this.label1.Location = new Point(10, 13);
            this.label1.Name = "label1";
            this.label1.Size = new Size(0x1d, 12);
            this.label1.TabIndex = 0;
            this.label1.Text = "标题";
            this.txttitle.Anchor = AnchorStyles.Right | AnchorStyles.Left | AnchorStyles.Top;
            this.txttitle.Location = new Point(0x30, 9);
            this.txttitle.Name = "txttitle";
            this.txttitle.Size = new Size(0x27f, 0x15);
            this.txttitle.TabIndex = 1;
            this.label2.AutoSize = true;
            this.label2.Location = new Point(10, 0x2a);
            this.label2.Name = "label2";
            this.label2.Size = new Size(0x35, 12);
            this.label2.TabIndex = 2;
            this.label2.Text = "查询语句";
            this.txtsql.AcceptsReturn = true;
            this.txtsql.AcceptsTab = true;
            this.txtsql.Anchor = AnchorStyles.Right | AnchorStyles.Left | AnchorStyles.Bottom | AnchorStyles.Top;
            this.txtsql.Location = new Point(10, 60);
            this.txtsql.Multiline = true;
            this.txtsql.Name = "txtsql";
            this.txtsql.ScrollBars = ScrollBars.Vertical;
            this.txtsql.Size = new Size(0x2a5, 0x170);
            this.txtsql.TabIndex = 3;
            this.btSave.Anchor = AnchorStyles.Right | AnchorStyles.Bottom;
            this.btSave.Location = new Point(0x1c8, 0x1b5);
            this.btSave.Name = "btSave";
            this.btSave.Size = new Size(0x73, 0x22);
            this.btSave.TabIndex = 4;
            this.btSave.Text = "保存";
            this.btSave.Click += new EventHandler(this.btSave_Click);
            this.btCancel.Anchor = AnchorStyles.Right | AnchorStyles.Bottom;
            this.btCancel.Location = new Point(0x23b, 0x1b5);
            this.btCancel.Name = "btCancel";
            this.btCancel.Size = new Size(0x74, 0x22);
            this.btCancel.TabIndex = 5;
            this.btCancel.Text = "取消";
            this.btCancel.Click += new EventHandler(this.btCancel_Click);
            this.AutoScaleBaseSize = new Size(6, 14);
            base.ClientSize = new Size(0x2b8, 0x1dd);
            base.Controls.Add(this.btCancel);
            base.Controls.Add(this.btSave);
            base.Controls.Add(this.txtsql);
            base.Controls.Add(this.label2);
            base.Controls.Add(this.txttitle);
            base.Controls.Add(this.label1);
            base.Name = "frmSQLEdit";
            this.Text = "查询项修改";
            base.Load += new EventHandler(this.frmSQLEdit_Load);
            base.ResumeLayout(false);
            base.PerformLayout();
        }
    }




}
