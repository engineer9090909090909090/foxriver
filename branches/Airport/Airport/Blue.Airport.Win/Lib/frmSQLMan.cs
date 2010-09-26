using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Collections;
using System.Drawing;
using System.IO;

namespace Blue.Airport.Win.Lib
{
    public class frmSQLMan : Form
    {
        // Fields
        private Button btAdd;
        private Button btClose;
        private Button btDelete;
        private Container components;
        public ArrayList itemlist;
        private Label label1;
        private Label label2;
        private ContextMenu listsqlmenu;
        private ListBox listsqls;
        private MenuItem mnModSQL;
        private MenuItem mnRename;
        private frmSQLEdit sqlEditDialog;
        private TextBox txtsql;

        // Methods
        public frmSQLMan()
        {
            this.InitializeComponent();
            this.itemlist = new ArrayList();
        }

        private void btAdd_Click(object sender, EventArgs e)
        {
            this.sqlEditDialog = new frmSQLEdit();
            if (this.sqlEditDialog.ShowDialog() != DialogResult.Cancel)
            {
                this.itemlist.Add(this.sqlEditDialog.saveditem);
                this.listsqls.Items.Add(this.sqlEditDialog.saveditem.sqlname);
            }
        }

        private void btClose_Click(object sender, EventArgs e)
        {
            base.DialogResult = DialogResult.OK;
            base.Close();
        }

        private void btDelete_Click(object sender, EventArgs e)
        {
            if (this.listsqls.SelectedIndex != -1)
            {
                this.itemlist.RemoveAt(this.listsqls.SelectedIndex);
                this.listsqls.Items.RemoveAt(this.listsqls.SelectedIndex);
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

        public ArrayList getSQLList()
        {
            return this.itemlist;
        }

        private void InitializeComponent()
        {
            this.listsqls = new ListBox();
            this.listsqlmenu = new ContextMenu();
            this.mnRename = new MenuItem();
            this.mnModSQL = new MenuItem();
            this.btAdd = new Button();
            this.btDelete = new Button();
            this.label1 = new Label();
            this.txtsql = new TextBox();
            this.label2 = new Label();
            this.btClose = new Button();
            base.SuspendLayout();
            this.listsqls.ItemHeight = 12;
            this.listsqls.Location = new Point(10, 0x1a);
            this.listsqls.Name = "listsqls";
            this.listsqls.Size = new Size(0xc0, 280);
            this.listsqls.TabIndex = 0;
            this.listsqls.SelectedIndexChanged += new EventHandler(this.listsqls_SelectedIndexChanged);
            this.listsqlmenu.MenuItems.AddRange(new MenuItem[] { this.mnRename, this.mnModSQL });
            this.mnRename.Index = 0;
            this.mnRename.Text = "重命名";
            this.mnRename.Click += new EventHandler(this.mnRename_Click);
            this.mnModSQL.Index = 1;
            this.mnModSQL.Text = "修改SQL";
            this.mnModSQL.Click += new EventHandler(this.mnModSQL_Click);
            this.btAdd.Location = new Point(10, 0x13f);
            this.btAdd.Name = "btAdd";
            this.btAdd.Size = new Size(0x60, 0x22);
            this.btAdd.TabIndex = 1;
            this.btAdd.Text = "添加";
            this.btAdd.Click += new EventHandler(this.btAdd_Click);
            this.btDelete.Location = new Point(0x6a, 0x13f);
            this.btDelete.Name = "btDelete";
            this.btDelete.Size = new Size(0x60, 0x22);
            this.btDelete.TabIndex = 2;
            this.btDelete.Text = "删除";
            this.btDelete.Click += new EventHandler(this.btDelete_Click);
            this.label1.AutoSize = true;
            this.label1.Location = new Point(10, 8);
            this.label1.Name = "label1";
            this.label1.Size = new Size(0x4d, 12);
            this.label1.TabIndex = 3;
            this.label1.Text = "已存储查询项";
            this.txtsql.Enabled = false;
            this.txtsql.Location = new Point(0xd3, 0x1a);
            this.txtsql.Multiline = true;
            this.txtsql.Name = "txtsql";
            this.txtsql.ScrollBars = ScrollBars.Vertical;
            this.txtsql.Size = new Size(0x193, 0x11c);
            this.txtsql.TabIndex = 4;
            this.label2.AutoSize = true;
            this.label2.Location = new Point(0xd3, 8);
            this.label2.Name = "label2";
            this.label2.Size = new Size(0x35, 12);
            this.label2.TabIndex = 5;
            this.label2.Text = "查询语句";
            this.btClose.Location = new Point(0x1f3, 0x13f);
            this.btClose.Name = "btClose";
            this.btClose.Size = new Size(0x73, 0x22);
            this.btClose.TabIndex = 6;
            this.btClose.Text = "关闭";
            this.btClose.Click += new EventHandler(this.btClose_Click);
            this.AutoScaleBaseSize = new Size(6, 14);
            base.ClientSize = new Size(0x271, 0x16b);
            base.ControlBox = false;
            base.Controls.Add(this.listsqls);
            base.Controls.Add(this.txtsql);
            base.Controls.Add(this.btClose);
            base.Controls.Add(this.btDelete);
            base.Controls.Add(this.btAdd);
            base.Controls.Add(this.label2);
            base.Controls.Add(this.label1);
            base.FormBorderStyle = FormBorderStyle.FixedDialog;
            base.Name = "frmSQLMan";
            this.Text = "查询项管理";
            base.ResumeLayout(false);
            base.PerformLayout();
        }

        private void listsqls_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.listsqls.SelectedIndex != -1)
            {
                this.txtsql.Text = ((sqlitem)this.itemlist[this.listsqls.SelectedIndex]).sqlstring;
                this.listsqls.ContextMenu = this.listsqlmenu;
            }
        }

        public void loadConfigFile()
        {
            try
            {
                StreamReader reader = File.OpenText(Environment.SystemDirectory + @"\Sitioparser.queues.txt");
                string str = reader.ReadLine();
                while (str != null)
                {
                    str = reader.ReadLine();
                    string str2 = reader.ReadLine();
                    if ((str != null) && (str2 != null))
                    {
                        sqlitem sqlitem = new sqlitem();
                        sqlitem.sqlname = str;
                        sqlitem.sqlstring = str2;
                        this.itemlist.Add(sqlitem);
                        this.listsqls.Items.Add(sqlitem.sqlname);
                    }
                }
                reader.Close();
            }
            catch (FileNotFoundException)
            {
                MessageBox.Show("没有找到查询语句纪录文件，将重建一个\n将会关闭程序，请重新启动", "未找到查询语句纪录文件");
                StreamWriter writer = File.CreateText(Environment.SystemDirectory + @"\Sitioparser.queues.txt");
                writer.WriteLine("<SQL>");
                writer.Close();
                Application.Exit();
            }
        }

        private void mnModSQL_Click(object sender, EventArgs e)
        {
            this.sqlEditDialog = new frmSQLEdit();
            this.sqlEditDialog.txttitle.Text = ((sqlitem)this.itemlist[this.listsqls.SelectedIndex]).sqlname;
            this.sqlEditDialog.txtsql.Text = ((sqlitem)this.itemlist[this.listsqls.SelectedIndex]).sqlstring;
            this.sqlEditDialog.txttitle.Enabled = false;
            if (this.sqlEditDialog.ShowDialog() != DialogResult.Cancel)
            {
                this.itemlist[this.listsqls.SelectedIndex] = this.sqlEditDialog.saveditem;
            }
        }

        private void mnRename_Click(object sender, EventArgs e)
        {
            this.sqlEditDialog = new frmSQLEdit();
            this.sqlEditDialog.txttitle.Text = ((sqlitem)this.itemlist[this.listsqls.SelectedIndex]).sqlname;
            this.sqlEditDialog.txtsql.Text = ((sqlitem)this.itemlist[this.listsqls.SelectedIndex]).sqlstring;
            this.sqlEditDialog.txtsql.Enabled = false;
            if (this.sqlEditDialog.ShowDialog() != DialogResult.Cancel)
            {
                this.itemlist[this.listsqls.SelectedIndex] = this.sqlEditDialog.saveditem;
                this.listsqls.Items[this.listsqls.SelectedIndex] = this.sqlEditDialog.txttitle.Text;
            }
        }
    }
}
