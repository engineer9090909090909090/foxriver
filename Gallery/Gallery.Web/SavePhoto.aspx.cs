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
    public partial class SavePhoto : System.Web.UI.Page
    {
        const string FILE_ID = "fileToUpload";
        const string TARGET_FOLDER = "~/Photos";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty };
            if (Request.Files[FILE_ID] == null || Request.Files[FILE_ID].ContentLength == 0)
            {
                ar.Message = "No file found";
                ar.ReturnCode = 1;
            }
            else
            {
                try
                {
                    HttpPostedFile file = Request.Files[FILE_ID];
                    string fileName = Guid.NewGuid().ToString() + file.FileName.Substring(file.FileName.LastIndexOf("."));
                    string folder = Server.MapPath(TARGET_FOLDER);
                    if (folder.EndsWith("\\"))
                    {
                        file.SaveAs(folder + fileName);
                    }
                    else
                    {
                        file.SaveAs(folder + "\\" + fileName);
                    }

                    ar.Message = fileName;
                }
                catch (System.Exception ex)
                {
                    ar.ReturnCode = 2;
                    ar.Message = ex.Message;

                }
            }
            //Response.ContentType = "application/x-javascript;charset=UTF-8";
            Response.Clear();
            WebMethods.OutputResult(ar);
            Response.End();
        }
    }
}
