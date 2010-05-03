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
    public partial class Gallery : System.Web.UI.Page
    {
        int gid = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Request.Form["galleryId"] != null)
            {
                if (!int.TryParse(Request.Form["galleryId"], out gid))
                {
                    gid = -1;
                }
            }
            */
            if (Request.QueryString["galleryId"] != null)
            {
                if (!int.TryParse(Request.QueryString["galleryId"], out gid))
                {
                    gid = -1;
                }
            }

        }

        protected string Description
        {
            get
            {
                if (gid < 0)
                    return string.Empty;
                string des = Utility.GetGalleryDescription(gid);

                if (string.IsNullOrEmpty(des))
                    return string.Empty;

                return des.Replace("\"", "\\\"");
                //return Utility.GetGalleryDescription(gid);
            }
        }

        protected string Photos
        {
            get
            {
                //DataTable t = Utility.GetPhotos(gid);
                //return "";
                if (gid < 0)
                {
                    return "[]";
                }
                AjaxResult ar = WebMethods.GetPhotos();
                if (ar.ReturnCode != 0)
                {
                    return "[]";
                }
                return ar.Json;
            }
        }

    }
}
