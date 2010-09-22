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
            this.paging1 = new Blue.Airport.Win.Paging();
            this.testEntityBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.idDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.birthdayDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSetBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSetBindingSource1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.testEntityBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idDataGridViewTextBoxColumn,
            this.nameDataGridViewTextBoxColumn,
            this.birthdayDataGridViewTextBoxColumn});
            this.dataGridView1.DataSource = this.testEntityBindingSource;
            this.dataGridView1.Location = new System.Drawing.Point(31, 77);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowTemplate.Height = 27;
            this.dataGridView1.Size = new System.Drawing.Size(751, 186);
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
            // paging1
            // 
            this.paging1.CurrentPage = 0;
            this.paging1.GridView = null;
            this.paging1.Location = new System.Drawing.Point(335, 12);
            this.paging1.Name = "paging1";
            this.paging1.PageSize = 1000;
            this.paging1.Size = new System.Drawing.Size(509, 30);
            this.paging1.TabIndex = 0;
            // 
            // testEntityBindingSource
            // 
            this.testEntityBindingSource.DataSource = typeof(Blue.Airport.Win.TestEntity);
            // 
            // idDataGridViewTextBoxColumn
            // 
            this.idDataGridViewTextBoxColumn.DataPropertyName = "Id";
            this.idDataGridViewTextBoxColumn.HeaderText = "Id";
            this.idDataGridViewTextBoxColumn.Name = "idDataGridViewTextBoxColumn";
            // 
            // nameDataGridViewTextBoxColumn
            // 
            this.nameDataGridViewTextBoxColumn.DataPropertyName = "Name";
            this.nameDataGridViewTextBoxColumn.HeaderText = "Name";
            this.nameDataGridViewTextBoxColumn.Name = "nameDataGridViewTextBoxColumn";
            // 
            // birthdayDataGridViewTextBoxColumn
            // 
            this.birthdayDataGridViewTextBoxColumn.DataPropertyName = "Birthday";
            this.birthdayDataGridViewTextBoxColumn.HeaderText = "Birthday";
            this.birthdayDataGridViewTextBoxColumn.Name = "birthdayDataGridViewTextBoxColumn";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(870, 352);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.paging1);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSetBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bullDataSetBindingSource1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.testEntityBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Paging paging1;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource bullDataSetBindingSource;
        private Blue.Airport.Win.App_Data.BullDataSet bullDataSet;
        private System.Windows.Forms.BindingSource bullDataSetBindingSource1;
        private System.Windows.Forms.DataGridViewTextBoxColumn idDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn nameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn birthdayDataGridViewTextBoxColumn;
        private System.Windows.Forms.BindingSource testEntityBindingSource;
    }
}

