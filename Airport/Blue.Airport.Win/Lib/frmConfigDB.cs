using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Drawing;
using System.ComponentModel;

namespace Blue.Airport.Win.Lib
{
    public class frmConfigDB : Form
    {
        // Fields
        private Button btAccept;
        private Button btCancel;
        private Button btLocatedb;
        private Container components;
        private Label label1;
        private OpenFileDialog openDBDialog;
        private TextBox txtdb;

        // Methods
        public frmConfigDB()
        {
            this.InitializeComponent();
        }

        private void btAccept_Click(object sender, EventArgs e)
        {
            base.DialogResult = DialogResult.OK;
        }

        private void btLocatedb_Click(object sender, EventArgs e)
        {
            if (this.openDBDialog.ShowDialog() != DialogResult.Cancel)
            {
                string[] strArray = this.openDBDialog.FileName.Split(new char[] { '\\' });
                this.txtdb.Text = string.Join(@"\\", strArray);
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

        private void frmConfigDB_Load(object sender, EventArgs e)
        {
            this.loadConfigDB();
        }

        public string getDBLocation()
        {
            return this.txtdb.Text;
        }

        private void InitializeComponent()
        {
            this.btAccept = new Button();
            this.btCancel = new Button();
            this.label1 = new Label();
            this.txtdb = new TextBox();
            this.btLocatedb = new Button();
            this.openDBDialog = new OpenFileDialog();
            base.SuspendLayout();
            this.btAccept.Location = new Point(0xad, 0x34);
            this.btAccept.Name = "btAccept";
            this.btAccept.Size = new Size(0x7d, 0x22);
            this.btAccept.TabIndex = 0;
            this.btAccept.Text = "确定";
            this.btAccept.Click += new EventHandler(this.btAccept_Click);
            this.btCancel.DialogResult = DialogResult.Cancel;
            this.btCancel.Location = new Point(0x12a, 0x34);
            this.btCancel.Name = "btCancel";
            this.btCancel.Size = new Size(0x7c, 0x22);
            this.btCancel.TabIndex = 1;
            this.btCancel.Text = "取消";
            this.label1.AutoSize = true;
            this.label1.Location = new Point(10, 0x16);
            this.label1.Name = "label1";
            this.label1.Size = new Size(0x41, 12);
            this.label1.TabIndex = 2;
            this.label1.Text = "数据库位置";
            this.txtdb.Enabled = false;
            this.txtdb.Location = new Point(0x60, 0x11);
            this.txtdb.Name = "txtdb";
            this.txtdb.Size = new Size(0x12a, 0x15);
            this.txtdb.TabIndex = 4;
            this.btLocatedb.Location = new Point(0x18a, 0x11);
            this.btLocatedb.Name = "btLocatedb";
            this.btLocatedb.Size = new Size(0x1c, 0x16);
            this.btLocatedb.TabIndex = 6;
            this.btLocatedb.Text = "...";
            this.btLocatedb.Click += new EventHandler(this.btLocatedb_Click);
            this.openDBDialog.Filter = "Access数据库文件|*.mdb";
            base.AcceptButton = this.btAccept;
            this.AutoScaleBaseSize = new Size(6, 14);
            base.CancelButton = this.btCancel;
            base.ClientSize = new Size(0x1ac, 0x5f);
            base.ControlBox = false;
            base.Controls.Add(this.btLocatedb);
            base.Controls.Add(this.txtdb);
            base.Controls.Add(this.label1);
            base.Controls.Add(this.btCancel);
            base.Controls.Add(this.btAccept);
            base.FormBorderStyle = FormBorderStyle.FixedDialog;
            base.Name = "frmConfigDB";
            this.Text = "设置数据库";
            base.Load += new EventHandler(this.frmConfigDB_Load);
            base.ResumeLayout(false);
            base.PerformLayout();
        }

        public void loadConfigDB()
        {
            try
            {
                StreamReader reader = File.OpenText(Environment.SystemDirectory + @"\Sitioparser.config.txt");
                this.txtdb.Text = reader.ReadLine();
                reader.Close();
            }
            catch (FileNotFoundException)
            {
                MessageBox.Show("没有找到数据库设置文件，将重建一个\n将会关闭程序，请重新启动", "未找到数据库设置文件");
                StreamWriter writer = File.CreateText(Environment.SystemDirectory + @"\Sitioparser.config.txt");
                writer.WriteLine(@"C:\mlb2.mdb");
                writer.Close();
                Application.Exit();
            }
        }
    }

    public class sqlitem
    {
        // Fields
        public string sqlname;
        public string sqlstring;
    }

 



}
