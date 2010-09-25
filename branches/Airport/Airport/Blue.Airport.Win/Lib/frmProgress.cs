using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Drawing;

namespace Blue.Airport.Win.Lib
{
    public class frmProgress : Form
    {
        // Fields
        private IContainer components;
        public ProgressBar progressBar;
        public Label txtProgress;

        // Methods
        public frmProgress()
        {
            this.InitializeComponent();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing && (this.components != null))
            {
                this.components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            this.progressBar = new ProgressBar();
            this.txtProgress = new Label();
            base.SuspendLayout();
            this.progressBar.Location = new Point(12, 0x1a);
            this.progressBar.Name = "progressBar";
            this.progressBar.Size = new Size(0x182, 0x2a);
            this.progressBar.Style = ProgressBarStyle.Continuous;
            this.progressBar.TabIndex = 0;
            this.txtProgress.AutoSize = true;
            this.txtProgress.BackColor = Color.Transparent;
            this.txtProgress.Location = new Point(12, 9);
            this.txtProgress.Name = "txtProgress";
            this.txtProgress.Size = new Size(0x1d, 12);
            this.txtProgress.TabIndex = 1;
            this.txtProgress.Text = "解析";
            base.AutoScaleDimensions = new SizeF(6f, 12f);
            base.AutoScaleMode = AutoScaleMode.Font;
            base.ClientSize = new Size(410, 80);
            base.ControlBox = false;
            base.Controls.Add(this.progressBar);
            base.Controls.Add(this.txtProgress);
            base.FormBorderStyle = FormBorderStyle.None;
            base.Name = "frmProgress";
            base.StartPosition = FormStartPosition.CenterScreen;
            this.Text = "解析进度";
            base.ResumeLayout(false);
            base.PerformLayout();
        }
    }




}
