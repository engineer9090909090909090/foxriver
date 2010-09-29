using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Blue.Airport.Win.Lib;

namespace Blue.Airport.Win
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            LoadData();

            SetEventHandler();
        }

        void LoadData()
        {
            this.paging1.AppendLoadData(new Paging.LoadDataMethod(Lib.MlbManager.GetData), this.dataGridView1);
        }

        void SetEventHandler()
        {
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            this.openImpDialog.ShowDialog(this);

            if (this.openImpDialog.ShowDialog() != DialogResult.Cancel)
            {
                FrmWaiting wait = new FrmWaiting();
                wait.BeginOperate(this, new FrmWaiting.OperationDelegate(delegate
                {
                    CParser parser = new CParser(this.openImpDialog.FileName);
                    //parser.lcDbLocation = this.lcDbLocation;
                    parser.parseMLB();
                    parser.parseFLR();
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
