namespace Blue.Airport.Win
{
    partial class Form1
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.bullDataSet = new Blue.Airport.Win.App_Data.BullDataSet();
            this.bullDataSetBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.bullDataSetBindingSource1 = new System.Windows.Forms.BindingSource(this.components);
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.viewToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.btnLoadMlb = new System.Windows.Forms.ToolStripMenuItem();
            this.btnLoadFlr = new System.Windows.Forms.ToolStripMenuItem();
            this.dataToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.btnImport = new System.Windows.Forms.ToolStripMenuItem();
            this.exportToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.btnOldParser = new System.Windows.Forms.ToolStripMenuItem();
            this.openImpDialog = new System.Windows.Forms.OpenFileDialog();
            this.btnQuerys = new System.Windows.Forms.ToolStripMenuItem();
            this.paging1 = new Blue.Airport.Win.Paging();
            this.testEntityBindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSetBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSetBindingSource1)).BeginInit();
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.testEntityBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(23, 82);
            this.dataGridView1.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowTemplate.Height = 27;
            this.dataGridView1.Size = new System.Drawing.Size(972, 418);
            this.dataGridView1.TabIndex = 1;
            // 
            // bullDataSet
            // 
            this.bullDataSet.DataSetName = "BullDataSet";
            this.bullDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // bullDataSetBindingSource
            // 
            this.bullDataSetBindingSource.DataSource = this.bullDataSet;
            this.bullDataSetBindingSource.Position = 0;
            // 
            // bullDataSetBindingSource1
            // 
            this.bullDataSetBindingSource1.DataSource = this.bullDataSet;
            this.bullDataSetBindingSource1.Position = 0;
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.viewToolStripMenuItem,
            this.dataToolStripMenuItem,
            this.btnQuerys,
            this.helpToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1022, 27);
            this.menuStrip1.TabIndex = 2;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // viewToolStripMenuItem
            // 
            this.viewToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnLoadMlb,
            this.btnLoadFlr});
            this.viewToolStripMenuItem.Name = "viewToolStripMenuItem";
            this.viewToolStripMenuItem.Size = new System.Drawing.Size(55, 23);
            this.viewToolStripMenuItem.Text = "View";
            // 
            // btnLoadMlb
            // 
            this.btnLoadMlb.Name = "btnLoadMlb";
            this.btnLoadMlb.Size = new System.Drawing.Size(107, 24);
            this.btnLoadMlb.Text = "MLB";
            // 
            // btnLoadFlr
            // 
            this.btnLoadFlr.Name = "btnLoadFlr";
            this.btnLoadFlr.Size = new System.Drawing.Size(107, 24);
            this.btnLoadFlr.Text = "FLR";
            // 
            // dataToolStripMenuItem
            // 
            this.dataToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnImport,
            this.exportToolStripMenuItem});
            this.dataToolStripMenuItem.Name = "dataToolStripMenuItem";
            this.dataToolStripMenuItem.Size = new System.Drawing.Size(53, 23);
            this.dataToolStripMenuItem.Text = "Data";
            // 
            // btnImport
            // 
            this.btnImport.Name = "btnImport";
            this.btnImport.Size = new System.Drawing.Size(152, 24);
            this.btnImport.Text = "Import";
            this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
            // 
            // exportToolStripMenuItem
            // 
            this.exportToolStripMenuItem.Name = "exportToolStripMenuItem";
            this.exportToolStripMenuItem.Size = new System.Drawing.Size(152, 24);
            this.exportToolStripMenuItem.Text = "Export";
            this.exportToolStripMenuItem.Visible = false;
            // 
            // helpToolStripMenuItem
            // 
            this.helpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnOldParser});
            this.helpToolStripMenuItem.Name = "helpToolStripMenuItem";
            this.helpToolStripMenuItem.Size = new System.Drawing.Size(53, 23);
            this.helpToolStripMenuItem.Text = "Help";
            // 
            // btnOldParser
            // 
            this.btnOldParser.Name = "btnOldParser";
            this.btnOldParser.Size = new System.Drawing.Size(265, 24);
            this.btnOldParser.Text = "Check Old Parser Program";
            this.btnOldParser.Visible = false;
            this.btnOldParser.Click += new System.EventHandler(this.btnOldParser_Click);
            // 
            // openImpDialog
            // 
            this.openImpDialog.Filter = "eTerm文本文件|*.txt";
            // 
            // btnQuerys
            // 
            this.btnQuerys.Name = "btnQuerys";
            this.btnQuerys.Size = new System.Drawing.Size(64, 23);
            this.btnQuerys.Text = "Query";
            // 
            // paging1
            // 
            this.paging1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.paging1.CurrentPage = 1;
            this.paging1.GridView = null;
            this.paging1.Location = new System.Drawing.Point(434, 35);
            this.paging1.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.paging1.Name = "paging1";
            this.paging1.PageSize = 1000;
            this.paging1.Size = new System.Drawing.Size(561, 47);
            this.paging1.TabIndex = 0;
            this.paging1.Total = 0;
            // 
            // testEntityBindingSource
            // 
            this.testEntityBindingSource.DataSource = typeof(Blue.Airport.Win.TestEntity);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1022, 527);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.paging1);
            this.Controls.Add(this.menuStrip1);
            this.MainMenuStrip = this.menuStrip1;
            this.Margin = new System.Windows.Forms.Padding(2, 3, 2, 3);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSetBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSetBindingSource1)).EndInit();
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.testEntityBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Paging paging1;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource bullDataSetBindingSource;
        private Blue.Airport.Win.App_Data.BullDataSet bullDataSet;
        private System.Windows.Forms.BindingSource bullDataSetBindingSource1;
        private System.Windows.Forms.BindingSource testEntityBindingSource;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem viewToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem btnLoadMlb;
        private System.Windows.Forms.ToolStripMenuItem btnLoadFlr;
        private System.Windows.Forms.ToolStripMenuItem dataToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem btnImport;
        private System.Windows.Forms.ToolStripMenuItem exportToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem helpToolStripMenuItem;
        private System.Windows.Forms.OpenFileDialog openImpDialog;
        private System.Windows.Forms.ToolStripMenuItem btnOldParser;
        private System.Windows.Forms.ToolStripMenuItem btnQuerys;
    }
}

