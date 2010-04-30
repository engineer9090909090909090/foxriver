namespace ThumbGenerator
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
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.btnGenerate = new System.Windows.Forms.Button();
            this.btnBrowse = new System.Windows.Forms.Button();
            this.folderBrowserDialog1 = new System.Windows.Forms.FolderBrowserDialog();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.tbThumbWidth = new System.Windows.Forms.TextBox();
            this.tbThumbHeight = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.tbGeneratedSQL = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.tbGalleryId = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(12, 77);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(422, 21);
            this.textBox1.TabIndex = 0;
            this.textBox1.Text = "E:\\SourceJpegs";
            // 
            // btnGenerate
            // 
            this.btnGenerate.Location = new System.Drawing.Point(334, 104);
            this.btnGenerate.Name = "btnGenerate";
            this.btnGenerate.Size = new System.Drawing.Size(75, 23);
            this.btnGenerate.TabIndex = 1;
            this.btnGenerate.Text = "Generate";
            this.btnGenerate.UseVisualStyleBackColor = true;
            this.btnGenerate.Click += new System.EventHandler(this.btnGenerate_Click);
            // 
            // btnBrowse
            // 
            this.btnBrowse.Location = new System.Drawing.Point(452, 75);
            this.btnBrowse.Name = "btnBrowse";
            this.btnBrowse.Size = new System.Drawing.Size(75, 23);
            this.btnBrowse.TabIndex = 2;
            this.btnBrowse.Text = "Browse";
            this.btnBrowse.UseVisualStyleBackColor = true;
            this.btnBrowse.Click += new System.EventHandler(this.btnBrowse_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(65, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(71, 12);
            this.label1.TabIndex = 3;
            this.label1.Text = "Thumb Width";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(65, 42);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(77, 12);
            this.label2.TabIndex = 4;
            this.label2.Text = "Thumb Height";
            // 
            // tbThumbWidth
            // 
            this.tbThumbWidth.Enabled = false;
            this.tbThumbWidth.Location = new System.Drawing.Point(142, 10);
            this.tbThumbWidth.Name = "tbThumbWidth";
            this.tbThumbWidth.Size = new System.Drawing.Size(100, 21);
            this.tbThumbWidth.TabIndex = 5;
            this.tbThumbWidth.Text = "50";
            // 
            // tbThumbHeight
            // 
            this.tbThumbHeight.Enabled = false;
            this.tbThumbHeight.Location = new System.Drawing.Point(142, 37);
            this.tbThumbHeight.Name = "tbThumbHeight";
            this.tbThumbHeight.Size = new System.Drawing.Size(100, 21);
            this.tbThumbHeight.TabIndex = 6;
            this.tbThumbHeight.Text = "50";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 104);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(230, 23);
            this.button1.TabIndex = 7;
            this.button1.Text = "Open Site Image Management";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Visible = false;
            // 
            // tbGeneratedSQL
            // 
            this.tbGeneratedSQL.Location = new System.Drawing.Point(23, 213);
            this.tbGeneratedSQL.Multiline = true;
            this.tbGeneratedSQL.Name = "tbGeneratedSQL";
            this.tbGeneratedSQL.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.tbGeneratedSQL.Size = new System.Drawing.Size(504, 183);
            this.tbGeneratedSQL.TabIndex = 8;
            this.tbGeneratedSQL.WordWrap = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 189);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(131, 12);
            this.label3.TabIndex = 9;
            this.label3.Text = "Generated TPhotos SQL";
            // 
            // tbGalleryId
            // 
            this.tbGalleryId.Location = new System.Drawing.Point(487, 186);
            this.tbGalleryId.Name = "tbGalleryId";
            this.tbGalleryId.Size = new System.Drawing.Size(40, 21);
            this.tbGalleryId.TabIndex = 10;
            this.tbGalleryId.Text = "1";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(410, 189);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(71, 12);
            this.label4.TabIndex = 11;
            this.label4.Text = "Gallery ID:";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(548, 408);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.tbGalleryId);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.tbGeneratedSQL);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.tbThumbHeight);
            this.Controls.Add(this.tbThumbWidth);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnBrowse);
            this.Controls.Add(this.btnGenerate);
            this.Controls.Add(this.textBox1);
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Thumbnail Generator";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button btnGenerate;
        private System.Windows.Forms.Button btnBrowse;
        private System.Windows.Forms.FolderBrowserDialog folderBrowserDialog1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox tbThumbWidth;
        private System.Windows.Forms.TextBox tbThumbHeight;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox tbGeneratedSQL;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tbGalleryId;
        private System.Windows.Forms.Label label4;
    }
}

