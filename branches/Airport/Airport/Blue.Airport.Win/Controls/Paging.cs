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
        public delegate DataTable LoadDataMethod(ref int total, int pageSize, int currentPage);
        public LoadDataMethod LoadDataHandler;
        int _TotalPage = -10;


        public Paging()
        {
            InitializeComponent();
            SetEventHandler();
            PageSize = 1000;
        }

        int _CurrentPage = 1;
        public int CurrentPage
        {
            get
            {
                /*
                if (ddlPage.Items.Count == 0)
                    return 0;
                // don't have data, current page is zero
                if (_Total <= 0)
                    return 0;

                return int.Parse(ddlPage.SelectedValue.ToString()) + 1;
                */
                return _CurrentPage;
            }
            set
            {
                /*
                //_CurrentPage = value;
                if (value < 0 || value >= ddlPage.Items.Count)
                    return;

                ddlPage.SelectedIndex = value - 1;
                */
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

                lblRowsPerPage.Text = string.Format("{0} Records / Page", value);
            }
        }

        int _Total = 0;
        public int Total
        {
            get
            {
                return _Total;
            }
            set
            {
                _Total = value;
            }
        }
        #region Buttons

        /*
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
        */

        #endregion

        #region AppendLoadData

        public void AppendLoadData(LoadDataMethod loadData, DataGridView gridView)
        {
            this.LoadDataHandler = loadData;
            _GridView = gridView;

            _TotalPage = -1;
            //CurrentPage = 1;
            BindGridView();
        }

        #endregion

        #region SetEventHandler

        void SetEventHandler()
        {
            btnFirst.Click += delegate
            {
                if (_TotalPage < 1)
                    return;
                
                CurrentPage = 1;
                BindGridView();
                
            };
            btnNext.Click += delegate
            {
                if (_TotalPage < 1)
                    return;

                if (CurrentPage == _TotalPage)
                {
                    MessageBox.Show("Arrive at last page");
                    return;
                }
                
                ++CurrentPage;
                BindGridView();
            };
            btnPrevious.Click += delegate
            {
                if (_TotalPage < 1)
                    return;
                if (CurrentPage <= 1)
                {
                    MessageBox.Show("Arrive at first page");
                    return;
                }
                --CurrentPage;
                BindGridView();
            };

            btnLast.Click += delegate
            {
                if (_TotalPage < 1)
                    return;
                CurrentPage = _TotalPage;
                BindGridView();
            };
            ddlPage.SelectedIndexChanged += delegate
            {
                if (_TotalPage < 1)
                    return;
                CurrentPage = int.Parse(ddlPage.SelectedItem.ToString());
                BindGridView();
            };

        }

        #endregion

        #region BindGridView

        void BindGridView()
        {
            if (this._GridView == null ||
                this.LoadDataHandler == null)
                return;
            //int total = 0;
            //if (CurrentPage - 1 == ddlPage.SelectedIndex)
            //    return;
            this._GridView.DataSource = this.LoadDataHandler(ref _Total, PageSize, CurrentPage);
            lblTotal.Text = _Total.ToString();

            #region reset page properties
            if (_TotalPage < 0)
            {
                ddlPage.Items.Clear();

                if (Total == 0)
                {
                    _TotalPage = 0;
                }
                else
                {
                    if (Total % PageSize == 0)
                    {
                        _TotalPage = Total / PageSize;
                    }
                    else
                    {
                        _TotalPage = Total / PageSize + 1;
                    }
                }
                lblTotalPages.Text = _TotalPage.ToString();
                for (int i = 1; i <= _TotalPage; ++i)
                {
                    ddlPage.Items.Add(i.ToString());
                }
            }
            #endregion

            //ddlPage.SelectedIndex = cur
            if (_TotalPage == 0)
            {
                return;
            }
            //if (CurrentPage > ddlPage.Items.Count)
            //{
            //    CurrentPage = 1;
            //}
            ddlPage.SelectedIndex = CurrentPage - 1;

        }

        #endregion

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

        #region RebindGridView

        public void RebindGridView()
        {
            _TotalPage = -10;
            BindGridView();
        }

        #endregion
    }
}
