namespace Blue.Airport.Win
{
    partial class FrmDataGridView
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            this.resDataGridView = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.resDataGridView)).BeginInit();
            this.SuspendLayout();
            // 
            // resDataGridView
            // 
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.LightSteelBlue;
            this.resDataGridView.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.resDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.resDataGridView.Dock = System.Windows.Forms.DockStyle.Fill;
            this.resDataGridView.Location = new System.Drawing.Point(0, 0);
            this.resDataGridView.Name = "resDataGridView";
            this.resDataGridView.RowTemplate.Height = 23;
            this.resDataGridView.Size = new System.Drawing.Size(1132, 688);
            this.resDataGridView.TabIndex = 3;
            // 
            // FrmDataGridView
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1132, 688);
            this.Controls.Add(this.resDataGridView);
            this.Name = "FrmDataGridView";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Query Result";
            ((System.ComponentModel.ISupportInitialize)(this.resDataGridView)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        public System.Windows.Forms.DataGridView resDataGridView;
    }
}