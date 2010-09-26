using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Data.OleDb;
using System.Collections;
using System.Drawing;
using System.IO;
using System.Data;

namespace Blue.Airport.Win.Lib
{
    public partial class frmMain : Form
    {
        // Fields
        private IContainer components;
        private frmConfigDB configDialog;
        private frmGUISQL guiSqlDialog;
        public string lcDbLocation;
        private MenuItem menuItem1;
        private MenuItem menuItem2;
        private MenuItem menuItem3;
        private MenuItem menuItem4;
        private MenuItem mnConfig;
        private MenuItem mnConfigDB;
        private MenuItem mnEdit;
        private MenuItem mnExcecuteQueue;
        private MenuItem mnExport;
        private MenuItem mnFile;
        private MenuItem mnImport;
        private MenuItem mnManageQueue;
        private MenuItem mnQueue;
        private MenuItem mnSelectAll;
        private OpenFileDialog openImpDialog;
        public DataGridView resDataGridView;
        private frmSQLMan sqlManDialog;
        private MainMenu sysMenu;
        private TextBox txtsql;

        // Methods
        public frmMain()
        {
            this.InitializeComponent();
        }

        private void addGridNum()
        {
            for (int i = 0; i < this.resDataGridView.Rows.Count; i++)
            {
                this.resDataGridView.Rows[i].HeaderCell.Value = (i + 1).ToString();
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

        private void frmMain_Load(object sender, EventArgs e)
        {
            this.Text = Application.ProductName + " " + Application.ProductVersion;
            this.configDialog = new frmConfigDB();
            this.sqlManDialog = new frmSQLMan();
            this.configDialog.loadConfigDB();
            this.sqlManDialog.loadConfigFile();
            this.lcDbLocation = this.configDialog.getDBLocation();
            ArrayList list = this.sqlManDialog.getSQLList();
            this.resDataGridView.ClipboardCopyMode = DataGridViewClipboardCopyMode.EnableAlwaysIncludeHeaderText;
            for (int i = 0; i < this.sqlManDialog.getSQLList().Count; i++)
            {
                MenuItem item = new MenuItem();
                item.Text = ((sqlitem)list[i]).sqlname;
                item.Click += new EventHandler(this.mnStoQueueMenu_Click);
                this.mnQueue.MenuItems.Add(item);
            }
        }


        /*
        [STAThread]
        private static void Main()
        {
            Application.Run(new frmMain());
        }
        */

        private void menuItem4_Click(object sender, EventArgs e)
        {
            if (this.guiSqlDialog == null)
            {
                this.guiSqlDialog = new frmGUISQL(this);
                this.guiSqlDialog.Show();
            }
            this.guiSqlDialog.Show();
            this.guiSqlDialog.Focus();
        }

        private void mnConfigDB_Click(object sender, EventArgs e)
        {
            if (this.configDialog.ShowDialog() != DialogResult.Cancel)
            {
                StreamWriter writer = File.CreateText(Environment.SystemDirectory + @"\Sitioparser.config.txt");
                writer.WriteLine(this.configDialog.getDBLocation());
                writer.Close();
                this.lcDbLocation = this.configDialog.getDBLocation();
            }
        }

        private void mnExcecuteQueue_Click(object sender, EventArgs e)
        {
            this.runSql();
        }

        private void mnExport_Click(object sender, EventArgs e)
        {
            Clipboard.SetDataObject(this.resDataGridView.GetClipboardContent());
        }

        private void mnImport_Click(object sender, EventArgs e)
        {
            if (this.openImpDialog.ShowDialog() != DialogResult.Cancel)
            {
                FrmWaiting wait = new FrmWaiting();
                wait.BeginOperate(this, new FrmWaiting.OperationDelegate(delegate
                {
                    CParser parser = new CParser(this.openImpDialog.FileName);
                    parser.lcDbLocation = this.lcDbLocation;
                    parser.parseMLB();
                    parser.parseFLR();
                }));
                /*
                 * OLD CODE
                frmProgress progress = new frmProgress();
                string[] strArray = File.ReadAllLines(this.openImpDialog.FileName);
                progress.progressBar.Maximum = strArray.Length;
                parser.tfrmProgress = progress;
                progress.Show();
                if (parser.checkDB())
                {
                    parser.parseMLB();
                    parser.parseFLR();
                }
                progress.Hide();
                */
            }
        }

        private void mnManageQueue_Click(object sender, EventArgs e)
        {
            if (this.sqlManDialog.ShowDialog() != DialogResult.Cancel)
            {
                StreamWriter writer = File.CreateText(Environment.SystemDirectory + @"\Sitioparser.queues.txt");
                writer.WriteLine("<SQL>");
                ArrayList list = this.sqlManDialog.getSQLList();
                for (int i = 0; i < this.sqlManDialog.getSQLList().Count; i++)
                {
                    writer.WriteLine(((sqlitem)list[i]).sqlname);
                    writer.WriteLine(((sqlitem)list[i]).sqlstring);
                }
                writer.Close();
            }
        }

        private void mnSelectAll_Click(object sender, EventArgs e)
        {
            this.resDataGridView.SelectAll();
        }

        private void mnStoQueueMenu_Click(object sender, EventArgs e)
        {
            MenuItem item = (MenuItem)sender;
            ArrayList list = this.sqlManDialog.getSQLList();
            for (int i = 0; i < this.sqlManDialog.getSQLList().Count; i++)
            {
                if (item.Text == ((sqlitem)list[i]).sqlname)
                {
                    this.txtsql.Text = ((sqlitem)list[i]).sqlstring;
                }
            }
        }

        private void resDataGridView_SelectionChanged(object sender, EventArgs e)
        {
            if (this.resDataGridView.SelectedCells.Count > 0)
            {
                this.mnExport.Enabled = true;
            }
            else
            {
                this.mnExport.Enabled = false;
            }
        }

        private void resDataGridView_Sorted(object sender, EventArgs e)
        {
            this.addGridNum();
        }

        private void runSql()
        {
            if ((this.txtsql.Text == "手动查询栏, 按F5执行") || (this.txtsql.Text == ""))
            {
                MessageBox.Show("请先在手动查询栏中写入有效SQL语句再查询", "无效SQL语句", MessageBoxButtons.OK, MessageBoxIcon.Hand);
            }
            else
            {
                try
                {
                    OleDbConnection selectConnection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + this.configDialog.getDBLocation());
                    OleDbDataAdapter adapter = new OleDbDataAdapter(this.txtsql.Text, selectConnection);
                    DataSet dataSet = new DataSet();
                    selectConnection.Open();
                    adapter.Fill(dataSet, "queueresult");
                    selectConnection.Close();
                    this.resDataGridView.DataSource = dataSet;
                    if (adapter.SelectCommand.CommandText.Substring(0, 6).ToLower() != "delete")
                    {
                        this.resDataGridView.DataMember = "queueresult";
                        this.addGridNum();
                    }
                }
                catch (OleDbException exception)
                {
                    MessageBox.Show("查询语句中有错误，无法正确查询\n错误内容:" + exception.Message, "查询错误", MessageBoxButtons.OK, MessageBoxIcon.Hand);
                }
            }
        }

        private void txtsql_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F5)
            {
                this.runSql();
            }
        }
    }




}
