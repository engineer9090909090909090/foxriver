using System;
using System.Collections.Generic;
using System.Text;
using System.Drawing;
using System.Windows.Forms;
using System.ComponentModel;

namespace Blue.Airport.Win.Lib
{
    partial class frmMain
    {
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.sysMenu = new System.Windows.Forms.MainMenu(this.components);
            this.mnFile = new System.Windows.Forms.MenuItem();
            this.mnImport = new System.Windows.Forms.MenuItem();
            this.mnEdit = new System.Windows.Forms.MenuItem();
            this.mnExport = new System.Windows.Forms.MenuItem();
            this.menuItem1 = new System.Windows.Forms.MenuItem();
            this.mnSelectAll = new System.Windows.Forms.MenuItem();
            this.mnQueue = new System.Windows.Forms.MenuItem();
            this.mnExcecuteQueue = new System.Windows.Forms.MenuItem();
            this.menuItem4 = new System.Windows.Forms.MenuItem();
            this.menuItem3 = new System.Windows.Forms.MenuItem();
            this.mnManageQueue = new System.Windows.Forms.MenuItem();
            this.menuItem2 = new System.Windows.Forms.MenuItem();
            this.txtsql = new System.Windows.Forms.TextBox();
            this.openImpDialog = new System.Windows.Forms.OpenFileDialog();
            this.resDataGridView = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.resDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // sysMenu
            // 
            this.sysMenu.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
            this.mnFile,
            this.mnEdit,
            this.mnQueue});
            // 
            // mnFile
            // 
            this.mnFile.Index = 0;
            this.mnFile.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
            this.mnImport});
            this.mnFile.Text = "文件(&F)";
            // 
            // mnImport
            // 
            this.mnImport.Index = 0;
            this.mnImport.Shortcut = System.Windows.Forms.Shortcut.F1;
            this.mnImport.Text = "导入源文件(&I)...";
            this.mnImport.Click += new System.EventHandler(this.mnImport_Click);
            // 
            // mnEdit
            // 
            this.mnEdit.Index = 1;
            this.mnEdit.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
            this.mnExport,
            this.menuItem1,
            this.mnSelectAll});
            this.mnEdit.Text = "编辑(&E)";
            // 
            // mnExport
            // 
            this.mnExport.Enabled = false;
            this.mnExport.Index = 0;
            this.mnExport.Shortcut = System.Windows.Forms.Shortcut.CtrlC;
            this.mnExport.Text = "复制(&C)";
            this.mnExport.Click += new System.EventHandler(this.mnExport_Click);
            // 
            // menuItem1
            // 
            this.menuItem1.Index = 1;
            this.menuItem1.Text = "-";
            // 
            // mnSelectAll
            // 
            this.mnSelectAll.Index = 2;
            this.mnSelectAll.Shortcut = System.Windows.Forms.Shortcut.CtrlA;
            this.mnSelectAll.Text = "全选(&A)";
            this.mnSelectAll.Click += new System.EventHandler(this.mnSelectAll_Click);
            // 
            // mnQueue
            // 
            this.mnQueue.Index = 2;
            this.mnQueue.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] {
            this.mnExcecuteQueue,
            this.menuItem4,
            this.menuItem3,
            this.mnManageQueue,
            this.menuItem2});
            this.mnQueue.Text = "查询(&R)";
            // 
            // mnExcecuteQueue
            // 
            this.mnExcecuteQueue.Index = 0;
            this.mnExcecuteQueue.Text = "运行查询(&E)";
            this.mnExcecuteQueue.Click += new System.EventHandler(this.mnExcecuteQueue_Click);
            // 
            // menuItem4
            // 
            this.menuItem4.Enabled = false;
            this.menuItem4.Index = 1;
            this.menuItem4.Shortcut = System.Windows.Forms.Shortcut.F2;
            this.menuItem4.Text = "统计查询(&S)";
            this.menuItem4.Click += new System.EventHandler(this.menuItem4_Click);
            // 
            // menuItem3
            // 
            this.menuItem3.Index = 2;
            this.menuItem3.Text = "-";
            // 
            // mnManageQueue
            // 
            this.mnManageQueue.Index = 3;
            this.mnManageQueue.Text = "管理存储查询项(&M)...";
            this.mnManageQueue.Click += new System.EventHandler(this.mnManageQueue_Click);
            // 
            // menuItem2
            // 
            this.menuItem2.Index = 4;
            this.menuItem2.Text = "-";
            // 
            // txtsql
            // 
            this.txtsql.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtsql.Dock = System.Windows.Forms.DockStyle.Top;
            this.txtsql.Location = new System.Drawing.Point(0, 0);
            this.txtsql.Multiline = true;
            this.txtsql.Name = "txtsql";
            this.txtsql.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtsql.Size = new System.Drawing.Size(646, 56);
            this.txtsql.TabIndex = 1;
            this.txtsql.Text = "手动查询栏, 按F5执行";
            this.txtsql.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtsql_KeyDown);
            // 
            // openImpDialog
            // 
            this.openImpDialog.Filter = "eTerm文本文件|*.txt";
            // 
            // resDataGridView
            // 
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.LightSteelBlue;
            this.resDataGridView.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.resDataGridView.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.resDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.resDataGridView.Location = new System.Drawing.Point(5, 63);
            this.resDataGridView.Name = "resDataGridView";
            this.resDataGridView.RowTemplate.Height = 23;
            this.resDataGridView.Size = new System.Drawing.Size(637, 342);
            this.resDataGridView.TabIndex = 2;
            this.resDataGridView.Sorted += new System.EventHandler(this.resDataGridView_Sorted);
            this.resDataGridView.SelectionChanged += new System.EventHandler(this.resDataGridView_SelectionChanged);
            // 
            // frmMain
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(646, 411);
            this.Controls.Add(this.resDataGridView);
            this.Controls.Add(this.txtsql);
            this.Menu = this.sysMenu;
            this.Name = "frmMain";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.frmMain_Load);
            ((System.ComponentModel.ISupportInitialize)(this.resDataGridView)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }
    }
}
