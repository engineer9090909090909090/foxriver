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
    public partial class ClientManagement : ManagementBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (_IsAjaxRequest)
            {
                return;
            }
        }


        protected string Clients
        {
            get
            {
                return WebMethods.GetClients().Json;
            }
        }
    }
}
