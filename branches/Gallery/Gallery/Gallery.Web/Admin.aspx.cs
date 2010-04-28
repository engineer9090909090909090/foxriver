using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace Gallery.Web
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["ajax"]))
            {
                WebMethods.Process();
                //Response.End();
                return;
            }

            //System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();
            //conn.ConnectionString= @"Data Source=207.56.187.6,1433\SQLExpress1;Initial Catalog=dxdpho;User Id=dxdphosql;Password=dxdpho;";
            //try
            //{
            //    conn.Open();
            //    Response.Write("Connection is OK!");

            //}
            //catch(System.Exception ex)
            //{
            //    Response.Write(ex.Message);
            //}
            //conn.Dispose();

        }

        protected int IsSignIn
        {
            get
            {
                return WebMethods.IsSignIn;
            }
        }

    }

    
}
