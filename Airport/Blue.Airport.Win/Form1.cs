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

        int _SelectedMonth = 1;
        Lib.DataBaseType _SelectedDatabase = DataBaseType.MLB;
        List<LinkLabel> _MonthButtonList = new List<LinkLabel>();
        LinkLabel _SelectedMonthButton = null;

        public Form1()
        {
            InitializeComponent();

            SetEventHandler();
            LoadSavedQuerys();
            LoadMonth();

            btnLoadMlb.Tag = Lib.DataBaseType.MLB;
            btnLoadFlr.Tag = Lib.DataBaseType.FLR;
        }

        #region LoadMonthData

        void LoadMonth()
        {
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

            _MonthButtonList[0].Font = new Font(_MonthButtonList[0].Font, FontStyle.Bold);
            _SelectedMonthButton = _MonthButtonList[0];
        }

        void AddMonthLink(int index, string name)
        {
            LinkLabel lnL = new LinkLabel();
            lnL.Tag = index;
            lnL.Text = name;
            lnL.Width = 40;
            lnL.Left = ddlYear.Right + index * 40;
            lnL.Top = ddlYear.Top;
            pnlControl.Controls.Add(lnL);
            _MonthButtonList.Add(lnL);
            lnL.Click += new EventHandler(lnL_Click);
        }

        void lnL_Click(object sender, EventArgs e)
        {
            if (ddlYear.SelectedItem == null)
                return;

            LinkLabel currentButton = (LinkLabel)sender;
            if (currentButton == _SelectedMonthButton)
                return;

            _SelectedMonthButton.Font = new Font(_SelectedMonthButton.Font, FontStyle.Regular);
            currentButton.Font = new Font(currentButton.Font, FontStyle.Bold);
            _SelectedMonthButton = currentButton;

            //LinkLabel currentButton = _MonthButtonList.Find(button => (int)button.Tag == (int)_SelectedMonthButton.Tag);
            //if (currentButton != null)
            //{
            //    return;
            //}



            /*
            int year = int.Parse(ddlYear.SelectedValue.ToString());
            int monty = (int)((LinkLabel)sender).Tag;
            */
            _SelectedMonth = (int)((LinkLabel)sender).Tag;
            if (_SelectedDatabase == DataBaseType.MLB)
            {
                this.paging1.AppendLoadData(new Paging.LoadDataMethod(this.LoadMlbData), this.dataGridView1);
            }
            else if (_SelectedDatabase == DataBaseType.FLR)
            {
                this.paging1.AppendLoadData(new Paging.LoadDataMethod(this.LoadFlrData), this.dataGridView1);
            }
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

        #region SetEventHandler

        void SetEventHandler()
        {
            btnLoadFlr.Click += delegate
            {
                pnlControl.Visible = true;
                _SelectedDatabase = DataBaseType.FLR;
                // load year list
                System.Data.DataTable yearList = DbUtility.GetDataFromSp("flr_GetYearList");
                ddlYear.DataSource = yearList;
                //this.paging1.AppendLoadData(new Paging.LoadDataMethod(Lib.FlrManager.GetData), this.dataGridView1);
                this.paging1.AppendLoadData(new Paging.LoadDataMethod(this.LoadFlrData), this.dataGridView1);
            };

            btnLoadMlb.Click += delegate
            {
                pnlControl.Visible = true;
                _SelectedDatabase = DataBaseType.MLB;
                System.Data.DataTable yearList = DbUtility.GetDataFromSp("mlb_GetYearList");
                ddlYear.DataSource = yearList;
                //this.paging1.AppendLoadData(new Paging.LoadDataMethod(Lib.MlbManager.GetData), this.dataGridView1);
                this.paging1.AppendLoadData(new Paging.LoadDataMethod(this.LoadMlbData), this.dataGridView1);
            };
        }

        DataTable LoadMlbData(ref int total, int pageSize, int currentPage)
        {
            if (ddlYear.Items.Count == 0)
                return null;

            int year = int.Parse(ddlYear.SelectedValue.ToString());
            int month = _SelectedMonth;
            return MlbManager.GetData(ref total, pageSize, currentPage, year, month);
        }

        DataTable LoadFlrData(ref int total, int pageSize, int currentPage)
        {
            if (ddlYear.Items.Count == 0)
                return null;

            int year = int.Parse(ddlYear.SelectedValue.ToString());
            int month = _SelectedMonth;
            return FlrManager.GetData(ref total, pageSize, currentPage, year, month);
        }

        #endregion

        #region Import

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

        #endregion

        private void btnOldParser_Click(object sender, EventArgs e)
        {
            Lib.frmMain old = new frmMain();
            old.ShowDialog(this);
        }


    }
}
