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
    public partial class FrmDataGridView : Form
    {
        public FrmDataGridView()
        {
            InitializeComponent();
        }

        internal void LoadData(string sql)
        {
            this.resDataGridView.DataSource = DbUtility.GetDataFromCommand(sql);
        }
    }
}
