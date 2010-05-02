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
        const string TARGET_FOLDER = "~/Photos";
        protected void Page_Load(object sender, EventArgs e)
        {
            //string FILE_ID = "fileToUpload";
            string FILE_ID = Request.QueryString["name"];
            string photoType = Request.QueryString["ptype"];
            int photoId = int.Parse(Request.QueryString["pid"]);

            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty };
            if (Request.Files[FILE_ID] == null || Request.Files[FILE_ID].ContentLength == 0)
            {
                ar.Message = "No file found";
                ar.ReturnCode = 1;
            }
            else
            {
                HttpPostedFile file = Request.Files[FILE_ID];
                string fileName = Guid.NewGuid().ToString() + file.FileName.Substring(file.FileName.LastIndexOf("."));
                string folder = Server.MapPath(TARGET_FOLDER);
                string combined = string.Empty;
                if (folder.EndsWith("\\"))
                {
                    combined = folder + fileName;
                }
                else
                {
                    combined = folder + "\\" + fileName;
                }
                try
                {
                    //if (folder.EndsWith("\\"))
                    //{
                    //    file.SaveAs(folder + fileName);
                    //}
                    //else
                    //{
                    //    file.SaveAs(folder + "\\" + fileName);
                    //}

                    file.SaveAs(combined);

                    ar.Message = fileName;

                    // update db
                    Utility.UpdatePhotoFile(photoId, fileName, photoType);

                    if (photoType.Equals("s2"))
                    {
                        Utility.UpdatePhotoSize(combined);

                        System.Drawing.Size photoSize = Utility.GetPhotoSizeById(photoId);
                        ar.Json = "{" + string.Format("\"width\":{0},\"height\":{1}", photoSize.Width, photoSize.Height) + "}";
                    }


                }
                catch (System.Exception ex)
                {
                    ar.ReturnCode = 2;
                    ar.Message = ex.Message + " and the file name is :" + combined.Replace("\\", "\\\\");
                    ar.Message.Replace("\\", "?");
                }
            }
            //Response.ContentType = "application/x-javascript;charset=UTF-8";
            Response.Clear();
            WebMethods.OutputResult(ar);
            Response.End();
        }
    }
}
