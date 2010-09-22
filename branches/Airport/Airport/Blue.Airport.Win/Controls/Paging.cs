using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;

namespace Blue.Airport.Win
{
    public partial class Paging : UserControl
    {
        public delegate void LoadDataMethod(ref int total, int pageSize, int currentPage);
        public LoadDataMethod LoadDataHandler;

        public void Test(ref int total, int pageSize, int currentPage)
        {
        }
        public Paging()
        {
            InitializeComponent();
        }

        int _CurrentPage = 0;
        public int CurrentPage
        {
            get
            {
                return _CurrentPage;
            }
            set
            {
                _CurrentPage = value;
            }
        }

        int _PageSize = 1000;
        public int PageSize
        {
            get
            {
                return _PageSize;
            }
            set
            {
                _PageSize = value;
                if (LoadDataHandler != null)
                {
                    //LoadDataHandler(
                }
            }
        }


        #region Buttons

        public Button BtnPrevious
        {
            get
            {
                return btnPrevious;
            }
        }
        public Button BtnNext
        {
            get
            {
                return btnNext;
            }
        }
        public Button BtnLast
        {
            get
            {
                return btnLast;
            }
        }

        public Button BtnFirst
        {
            get
            {
                return btnFirst;
            }
        }

        #endregion

        public void AppendLoadData(LoadDataMethod loadData)
        {
            this.LoadDataHandler = loadData;
        }
        public void AppendLoadData(LoadDataMethod loadData, DataGridView gridView)
        {
            this.LoadDataHandler = loadData;
            _GridView = gridView;
        }

        #region GridView

        DataGridView _GridView = null;
        public DataGridView GridView
        {
            set
            {
                _GridView = value;
            }
            get
            {
                return _GridView;
            }
        }

        #endregion

    }
}
