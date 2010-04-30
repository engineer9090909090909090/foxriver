using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gallery.Web
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["ajax"]))
            {
                WebMethods.Process();
                //Response.End();
                return;
            }
        }

        protected string Galleries
        {
            get
            {
                return Utility.GetGalleriesJson();
            }
        }
    }
}
