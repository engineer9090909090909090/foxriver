using System;
using System.Data;
using System.Configuration;
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
    public class ManagementBase : System.Web.UI.Page
    {
        protected bool _IsAjaxRequest = false;
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);


            if (!string.IsNullOrEmpty(Request.QueryString["ajax"]))
            {
                _IsAjaxRequest = true;
                WebMethods.Process();
                //Response.End();
                return;
            }
        }
        
    }
}
