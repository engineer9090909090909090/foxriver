using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Threading;

namespace Blue.Airport.Win.Lib
{
    public partial class FrmWaiting : Form
    {
        public delegate void OperationDelegate();

        public delegate void ShowWaitingText(string text);

        ShowWaitingText _Waiting;
        public void ShowText(string text)
        {
            this.BeginInvoke(_Waiting);
        }

        OperationDelegate _Operation;
        public void BeginOperate(Form parentForm, OperationDelegate operationMethod)
        {
            /*
            _Operation = operationMethod;
            if (operationMethod == null)
                return;


            //operationMethod();
            Thread thread = new Thread(new ThreadStart(this.BeginOperate));
            thread.Start();
            */
            BeginOperate(parentForm, operationMethod, null);
        }

        public void BeginOperate(Form parentForm, OperationDelegate operationMethod, string waitingText)
        {
            if (!string.IsNullOrEmpty(waitingText))
            {
                this.WaitingText = waitingText;
            }
            if (operationMethod == null)
                return;
            _Operation = operationMethod;
            Thread thread = new Thread(new ThreadStart(this.BeginOperate));
            thread.Priority = ThreadPriority.AboveNormal;
            thread.Start();
            this.ShowDialog(parentForm);
        }

        //bool _OperationFinished = true;
        void BeginOperate()
        {
            //method();
            // _OperationFinished = false;
            _Operation();
            //_OperationFinished = true;
            MethodInvoker mi = new MethodInvoker(delegate
            {
                this.Close();
            });
            this.BeginInvoke(mi);
            //this.BeginInvoke(delegate { });
        }
        public FrmWaiting()
        {
            InitializeComponent();

            WaitingText = "Please wait...";

            this._Waiting = new ShowWaitingText(delegate(string text)
            {
                this.WaitingText = text;
            });
        }

        public string WaitingText
        {
            get
            {
                return label1.Text;
            }
            set
            {
                label1.Text = value;
                this.Text = value;
            }
        }
    }
}
