using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Blue.Airport.Win.Lib;
using System.IO;

namespace Blue.Airport.Win
{
    public partial class Form1 : Form
    {
        const string END_ALL = "--END ALL";
        const string COMMAND_BEGIN = "--BEGIN";
        const string COMMAND_END = "--END COMMAND";
        const int COMMAND_START_INDEX = 7;
        const string COMMAND_TXT_NAME = "Blue.Airport.Win.App_Data.Sitioparser.queues.txt.sql";

        public Form1()
        {
            InitializeComponent();

            SetEventHandler();
            LoadSavedQuerys();
            LoadMonth();
        }

        #region LoadMonthData

        void LoadMonth()
        {
            /*
            var list = new object[12];
            List<object> monList = new List<object>();
            monList.Add( new { tag = 0, name = "JAN" });

            list[0] = new { tag = 0, name = "JAN" };
            list[1] = new { tag = 1, name = "FEB" };
            list[2] = new { tag = 2, name = "MAR" };
            list[3] = new { tag = 3, name = "APR" };
            list[4] = new { tag = 4, name = "MAY" };
            list[5] = new { tag = 5, name = "JUN" };
            list[6] = new { tag = 6, name = "JUL" };
            list[7] = new { tag = 7, name = "AUG" };
            list[8] = new { tag = 8, name = "SEP" };
            list[9] = new { tag = 9, name = "OCT" };
            list[10] = new { tag = 10, name = "NOV" };
            list[11] = new { tag = 11, name = "DEC" };
            for (int i = 0; i < list.Length; ++i)
            {
                //list[i].
            }
            */
            AddMonthLink(1, "Jan");
            AddMonthLink(2, "Feb");
            AddMonthLink(3, "Mar");
            AddMonthLink(4, "Apr");
            AddMonthLink(5, "May");
            AddMonthLink(6, "Jun");
            AddMonthLink(7, "Jul");
            AddMonthLink(8, "Aug");
            AddMonthLink(9, "Sep");
            AddMonthLink(10, "Oct");
            AddMonthLink(11, "Nov");
            AddMonthLink(12, "Dec");
        }

        void AddMonthLink(int index, string name)
        {
            LinkLabel lnL = new LinkLabel();
            lnL.Tag = index;
            lnL.Text = name;
            lnL.Width = 40;
            lnL.Left = ddlYear.Right + index * 40;
            lnL.Top = ddlYear.Top;
            panel1.Controls.Add(lnL);
            lnL.Click += new EventHandler(lnL_Click);
        }

        void lnL_Click(object sender, EventArgs e)
        {
            if (ddlYear.SelectedItem == null)
                return;

            int year = int.Parse(ddlYear.SelectedValue.ToString());
            int monty = (int)((LinkLabel)sender).Tag;

        }

        #endregion

        #region LoadSavedQuerys

        void LoadSavedQuerys()
        {
            System.Text.StringBuilder sqlCommand = new StringBuilder();
            System.Reflection.Assembly appDll = System.Reflection.Assembly.GetExecutingAssembly();
            using (System.IO.Stream stream = appDll.GetManifestResourceStream(COMMAND_TXT_NAME))
            {
                bool findCommand = false;
                ToolStripMenuItem item = null;
                using (System.IO.StreamReader reader = new StreamReader(stream))
                {
                    string line = reader.ReadLine();

                    while (line != null)
                    {

                        // command file end
                        if (line.Equals(END_ALL))
                            break;

                        if (!findCommand && line.StartsWith(COMMAND_BEGIN))
                        {
                            findCommand = true;
                            item = new ToolStripMenuItem();
                            item.Text = line.Substring(COMMAND_START_INDEX);
                            line = reader.ReadLine();
                            continue;
                        }

                        line = line.Trim();

                        // find empty line
                        if (line.Length == 0)
                        {
                            line = reader.ReadLine();
                            continue;
                        }

                        // find command end
                        if (findCommand && line.Equals(COMMAND_END))
                        {
                            findCommand = false;
                            item.Tag = sqlCommand.ToString();
                            sqlCommand.Remove(0, sqlCommand.Length);
                            item.Click += delegate(object sender, EventArgs ea)
                            {
                                ToolStripMenuItem i = (ToolStripMenuItem)sender;
                                //string sql = (string)i.Tag;
                                FrmDataGridView gv = new FrmDataGridView();
                                gv.LoadData((string)i.Tag);
                                gv.ShowDialog(this);
                                GC.Collect();
                            };

                            //this.mnQueue.MenuItems.Add(item);
                            //item
                            btnQuerys.DropDownItems.Add(item);
                            line = reader.ReadLine();
                            continue;
                        }

                        // find comments line
                        if (line.StartsWith("--"))
                        {
                            line = reader.ReadLine();
                            continue;
                        }
                        sqlCommand.Append(line);
                        // add return character
                        sqlCommand.Append("\r\n");

                        // move to next command
                        line = reader.ReadLine();
                    }

                }
                stream.Close();
            }

            GC.Collect();
        }

        #endregion


        void SetEventHandler()
        {
            btnLoadFlr.Click += delegate
            {
                // load year list
                System.Data.DataTable yearList = DbUtility.GetDataFromSp("flr_GetYearList");
                ddlYear.DataSource = yearList;
                this.paging1.AppendLoadData(new Paging.LoadDataMethod(Lib.FlrManager.GetData), this.dataGridView1);
            };

            btnLoadMlb.Click += delegate
            {
                System.Data.DataTable yearList = DbUtility.GetDataFromSp("mlb_GetYearList");
                ddlYear.DataSource = yearList;
                this.paging1.AppendLoadData(new Paging.LoadDataMethod(Lib.MlbManager.GetData), this.dataGridView1);
            };
        }


        private void btnImport_Click(object sender, EventArgs e)
        {
            if (this.openImpDialog.ShowDialog(this) != DialogResult.Cancel)
            {
                FrmWaiting wait = new FrmWaiting();
                wait.BeginOperate(this, new FrmWaiting.OperationDelegate(delegate
                {
                    CParser parser = new CParser(this.openImpDialog.FileName);
                    parser.WaitingForm = wait;
                    parser.WaitingMethod += delegate(string text)
                    {
                        wait.WaitingText = text;
                    };
                    //parser.lcDbLocation = this.lcDbLocation;
                    parser.parseMLB();
                    parser.parseFLR();

                    GC.Collect();
                }));
            }
        }

        private void btnOldParser_Click(object sender, EventArgs e)
        {
            Lib.frmMain old = new frmMain();
            old.ShowDialog(this);
        }

    }
}
