using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using System.ComponentModel;
using System.Data.OleDb;
using System.Drawing;

namespace Blue.Airport.Win.Lib
{
    public class frmGUISQL : Form
    {
        // Fields
        private Button btClose;
        private Button btRun;
        private Button btTotal;
        private CheckBox chkMlbCode;
        private CheckBox chkMlbDate;
        private CheckBox chkMlbSegment;
        private CheckedListBox chlColumns;
        private ComboBox cmbCode;
        private ComboBox cmbSellagt;
        private ComboBox cmSegment;
        private IContainer components;
        private DateTimePicker datEnd;
        private DateTimePicker datStart;
        private GroupBox grpMLB;
        private Label label1;
        private Label label2;
        private Label label4;
        private Label lbTo;
        private RadioButton rdRange;
        private RadioButton rdSingle;
        private TabPage tabFLR;
        private TabPage tabMLB;
        private TabControl tabQueues;
        private frmMain tfrmMain;

        // Methods
        public frmGUISQL(frmMain tfrmMain)
        {
            this.InitializeComponent();
            this.tfrmMain = tfrmMain;
        }

        private void btClose_Click(object sender, EventArgs e)
        {
            base.Hide();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing && (this.components != null))
            {
                this.components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void frmGUISQL_Load(object sender, EventArgs e)
        {
            try
            {
                OleDbConnection connection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + this.tfrmMain.lcDbLocation);
                connection.Open();
                OleDbCommand command = new OleDbCommand();
                command.Connection = connection;
                command.CommandText = "SELECT ticsellagt FROM mlbtable GROUP BY ticsellagt";
                OleDbDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    this.cmbSellagt.Items.Add(reader.GetString(0));
                }
            }
            catch (Exception exception)
            {
                MessageBox.Show("数据库访问错误:\n" + exception.Message, "数据库打开错误", MessageBoxButtons.OK, MessageBoxIcon.Hand);
                base.Close();
            }
        }

        private void InitializeComponent()
        {
            this.grpMLB = new GroupBox();
            this.btTotal = new Button();
            this.btClose = new Button();
            this.btRun = new Button();
            this.chlColumns = new CheckedListBox();
            this.label1 = new Label();
            this.cmbCode = new ComboBox();
            this.chkMlbCode = new CheckBox();
            this.cmSegment = new ComboBox();
            this.chkMlbSegment = new CheckBox();
            this.chkMlbDate = new CheckBox();
            this.cmbSellagt = new ComboBox();
            this.label4 = new Label();
            this.datEnd = new DateTimePicker();
            this.lbTo = new Label();
            this.datStart = new DateTimePicker();
            this.label2 = new Label();
            this.rdRange = new RadioButton();
            this.rdSingle = new RadioButton();
            this.tabQueues = new TabControl();
            this.tabMLB = new TabPage();
            this.tabFLR = new TabPage();
            this.grpMLB.SuspendLayout();
            this.tabQueues.SuspendLayout();
            this.tabMLB.SuspendLayout();
            base.SuspendLayout();
            this.grpMLB.Controls.Add(this.btTotal);
            this.grpMLB.Controls.Add(this.btClose);
            this.grpMLB.Controls.Add(this.btRun);
            this.grpMLB.Controls.Add(this.chlColumns);
            this.grpMLB.Controls.Add(this.label1);
            this.grpMLB.Controls.Add(this.cmbCode);
            this.grpMLB.Controls.Add(this.chkMlbCode);
            this.grpMLB.Controls.Add(this.cmSegment);
            this.grpMLB.Controls.Add(this.chkMlbSegment);
            this.grpMLB.Controls.Add(this.chkMlbDate);
            this.grpMLB.Controls.Add(this.cmbSellagt);
            this.grpMLB.Controls.Add(this.label4);
            this.grpMLB.Controls.Add(this.datEnd);
            this.grpMLB.Controls.Add(this.lbTo);
            this.grpMLB.Controls.Add(this.datStart);
            this.grpMLB.Controls.Add(this.label2);
            this.grpMLB.Controls.Add(this.rdRange);
            this.grpMLB.Controls.Add(this.rdSingle);
            this.grpMLB.Location = new Point(6, 6);
            this.grpMLB.Name = "grpMLB";
            this.grpMLB.Size = new Size(420, 0x206);
            this.grpMLB.TabIndex = 0;
            this.grpMLB.TabStop = false;
            this.grpMLB.Text = "代理人销售业绩查询";
            this.btTotal.Location = new Point(0xc6, 0x1e1);
            this.btTotal.Name = "btTotal";
            this.btTotal.Size = new Size(0x67, 0x1f);
            this.btTotal.TabIndex = 20;
            this.btTotal.Text = "显示总数";
            this.btTotal.UseVisualStyleBackColor = true;
            this.btClose.Location = new Point(0x133, 0x1e1);
            this.btClose.Name = "btClose";
            this.btClose.Size = new Size(0x67, 0x1f);
            this.btClose.TabIndex = 0x13;
            this.btClose.Text = "关闭";
            this.btClose.UseVisualStyleBackColor = true;
            this.btClose.Click += new EventHandler(this.btClose_Click);
            this.btRun.Location = new Point(0x59, 0x1e1);
            this.btRun.Name = "btRun";
            this.btRun.Size = new Size(0x67, 0x1f);
            this.btRun.TabIndex = 0x12;
            this.btRun.Text = "查询";
            this.btRun.UseVisualStyleBackColor = true;
            this.chlColumns.FormattingEnabled = true;
            this.chlColumns.Items.AddRange(new object[] { "班期", "航程", "航班号", "旅客姓名", "记录编号", "确认记录", "购票日期", "代理人" });
            this.chlColumns.Location = new Point(8, 0xf9);
            this.chlColumns.Name = "chlColumns";
            this.chlColumns.Size = new Size(0x192, 0xa4);
            this.chlColumns.TabIndex = 0x11;
            this.label1.AutoSize = true;
            this.label1.Location = new Point(6, 0xea);
            this.label1.Name = "label1";
            this.label1.Size = new Size(0x2f, 12);
            this.label1.TabIndex = 0x10;
            this.label1.Text = "显示列:";
            this.cmbCode.FormattingEnabled = true;
            this.cmbCode.Location = new Point(0x2d, 0xd3);
            this.cmbCode.Name = "cmbCode";
            this.cmbCode.Size = new Size(0xa8, 20);
            this.cmbCode.TabIndex = 15;
            this.chkMlbCode.AutoSize = true;
            this.chkMlbCode.Location = new Point(8, 0xbd);
            this.chkMlbCode.Name = "chkMlbCode";
            this.chkMlbCode.Size = new Size(0x42, 0x10);
            this.chkMlbCode.TabIndex = 14;
            this.chkMlbCode.Text = "航班号:";
            this.chkMlbCode.UseVisualStyleBackColor = true;
            this.cmSegment.FormattingEnabled = true;
            this.cmSegment.Location = new Point(0x2d, 0xa3);
            this.cmSegment.Name = "cmSegment";
            this.cmSegment.Size = new Size(0xa8, 20);
            this.cmSegment.TabIndex = 13;
            this.chkMlbSegment.AutoSize = true;
            this.chkMlbSegment.Location = new Point(8, 0x8d);
            this.chkMlbSegment.Name = "chkMlbSegment";
            this.chkMlbSegment.Size = new Size(0x36, 0x10);
            this.chkMlbSegment.TabIndex = 12;
            this.chkMlbSegment.Text = "航程:";
            this.chkMlbSegment.UseVisualStyleBackColor = true;
            this.chkMlbDate.AutoSize = true;
            this.chkMlbDate.Location = new Point(8, 0x3a);
            this.chkMlbDate.Name = "chkMlbDate";
            this.chkMlbDate.Size = new Size(0x36, 0x10);
            this.chkMlbDate.TabIndex = 11;
            this.chkMlbDate.Text = "日期:";
            this.chkMlbDate.UseVisualStyleBackColor = true;
            this.cmbSellagt.FormattingEnabled = true;
            this.cmbSellagt.Location = new Point(0x2d, 0x20);
            this.cmbSellagt.Name = "cmbSellagt";
            this.cmbSellagt.Size = new Size(0xa8, 20);
            this.cmbSellagt.TabIndex = 8;
            this.label4.AutoSize = true;
            this.label4.Location = new Point(6, 0x11);
            this.label4.Name = "label4";
            this.label4.Size = new Size(0x2f, 12);
            this.label4.TabIndex = 7;
            this.label4.Text = "代理人:";
            this.datEnd.Location = new Point(0xf2, 0x72);
            this.datEnd.Name = "datEnd";
            this.datEnd.Size = new Size(0xa8, 0x15);
            this.datEnd.TabIndex = 6;
            this.datEnd.Visible = false;
            this.lbTo.AutoSize = true;
            this.lbTo.Location = new Point(0xdb, 0x76);
            this.lbTo.Name = "lbTo";
            this.lbTo.Size = new Size(0x11, 12);
            this.lbTo.TabIndex = 5;
            this.lbTo.Text = "至";
            this.lbTo.Visible = false;
            this.datStart.Location = new Point(0x2d, 0x72);
            this.datStart.Name = "datStart";
            this.datStart.Size = new Size(0xa8, 0x15);
            this.datStart.TabIndex = 4;
            this.label2.AutoSize = true;
            this.label2.Location = new Point(0x2b, 0x63);
            this.label2.Name = "label2";
            this.label2.Size = new Size(0x71, 12);
            this.label2.TabIndex = 3;
            this.label2.Text = "指定时间/开始时间:";
            this.rdRange.AutoSize = true;
            this.rdRange.Location = new Point(0x75, 80);
            this.rdRange.Name = "rdRange";
            this.rdRange.Size = new Size(0x3b, 0x10);
            this.rdRange.TabIndex = 2;
            this.rdRange.Text = "时间段";
            this.rdRange.UseVisualStyleBackColor = true;
            this.rdRange.CheckedChanged += new EventHandler(this.rdRange_CheckedChanged);
            this.rdSingle.AutoSize = true;
            this.rdSingle.Checked = true;
            this.rdSingle.Location = new Point(0x2d, 80);
            this.rdSingle.Name = "rdSingle";
            this.rdSingle.Size = new Size(0x47, 0x10);
            this.rdSingle.TabIndex = 1;
            this.rdSingle.TabStop = true;
            this.rdSingle.Text = "指定日期";
            this.rdSingle.UseVisualStyleBackColor = true;
            this.tabQueues.Controls.Add(this.tabMLB);
            this.tabQueues.Controls.Add(this.tabFLR);
            this.tabQueues.Location = new Point(12, 10);
            this.tabQueues.Name = "tabQueues";
            this.tabQueues.SelectedIndex = 0;
            this.tabQueues.Size = new Size(0x1b7, 0x22b);
            this.tabQueues.TabIndex = 1;
            this.tabMLB.Controls.Add(this.grpMLB);
            this.tabMLB.Location = new Point(4, 0x15);
            this.tabMLB.Name = "tabMLB";
            this.tabMLB.Padding = new Padding(3);
            this.tabMLB.Size = new Size(0x1af, 530);
            this.tabMLB.TabIndex = 0;
            this.tabMLB.Text = "MLB";
            this.tabMLB.UseVisualStyleBackColor = true;
            this.tabFLR.Location = new Point(4, 0x15);
            this.tabFLR.Name = "tabFLR";
            this.tabFLR.Padding = new Padding(3);
            this.tabFLR.Size = new Size(0x1af, 530);
            this.tabFLR.TabIndex = 1;
            this.tabFLR.Text = "FLR";
            this.tabFLR.UseVisualStyleBackColor = true;
            base.AutoScaleDimensions = new SizeF(6f, 12f);
            base.AutoScaleMode = AutoScaleMode.Font;
            base.ClientSize = new Size(0x1d0, 0x241);
            base.ControlBox = false;
            base.Controls.Add(this.tabQueues);
            base.FormBorderStyle = FormBorderStyle.FixedDialog;
            base.MaximizeBox = false;
            base.Name = "frmGUISQL";
            this.Text = "统计查询";
            base.Load += new EventHandler(this.frmGUISQL_Load);
            this.grpMLB.ResumeLayout(false);
            this.grpMLB.PerformLayout();
            this.tabQueues.ResumeLayout(false);
            this.tabMLB.ResumeLayout(false);
            base.ResumeLayout(false);
        }

        private void rdRange_CheckedChanged(object sender, EventArgs e)
        {
            if (this.rdRange.Checked)
            {
                this.lbTo.Visible = true;
                this.datEnd.Visible = true;
            }
            else
            {
                this.lbTo.Visible = false;
                this.datEnd.Visible = false;
            }
        }
    }



}
