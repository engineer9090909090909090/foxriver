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

        OperationDelegate _Operation;
        public void BeginOperate(OperationDelegate operationMethod)
        {
            _Operation = operationMethod;
            if (operationMethod == null)
                return;


            //operationMethod();
            Thread thread = new Thread(new ThreadStart(this.BeginOperate));
            thread.Start();

        }

        public void BeginOperate(OperationDelegate operationMethod, string waitingText)
        {
            /*
            this.WaitingText = waitingText;

            if (operationMethod == null)
                return;
            //Thread myThread = new Thread(new ThreadStart(threadfun));
          IAsyncResult ar =   this.BeginInvoke(operationMethod);
            //ar.AsyncWaitHandle.WaitOne(

            //operationMethod();
            */
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
