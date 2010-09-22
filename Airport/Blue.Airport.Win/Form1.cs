using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Blue.Airport.Win
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            LoadData();
        }

        void LoadData()
        {
            int total = 0;
            this.dataGridView1.DataSource = Test.GetTestData(ref total, 2, 1000);
        }
    }
}
