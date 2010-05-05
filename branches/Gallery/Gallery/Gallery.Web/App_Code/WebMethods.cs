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
using System.Data.SqlClient;

namespace Gallery.Web
{
    public class WebMethods
    {
        const string SESSION_SIGN_IN = "SignIn";
        static internal int IsSignIn
        {
            get
            {
                if (HttpContext.Current.Session[SESSION_SIGN_IN] != null)
                {
                    return 1;
                }
                return 0;
            }
        }
        static public AjaxResult Login()
        {
            /*
            HttpRequest req = HttpContext.Current.Request;
            string name = req.Form["name"];
            string password = req.Form["password"];

            using (SqlCommand comm = Utility.GetCommand())
            {
                comm.CommandText = "select count(*) from testtable";
                object o = comm.ExecuteScalar();
                comm.Connection.Close();
                comm.Connection.Dispose();
            }
            */
            HttpContext.Current.Session[SESSION_SIGN_IN] = 1;

            return new AjaxResult { ReturnCode = 0, Message = string.Empty };
        }

        #region GetPhotos

        static string JsonlizePhotoList(DataTable t)
        {
            System.Text.StringBuilder json = new System.Text.StringBuilder();
            json.Append("[");
            //DataTable t = Utility.GetPhotos(gId);
            if (t.Rows.Count > 0)
            {
                int count = 0;
                foreach (DataRow row in t.Rows)
                {
                    if (count > 0)
                    {
                        json.Append(",");
                    }
                    json.Append("{");

                    // id
                    json.AppendFormat("\"id\":{0}", row["ID"].ToString());
                    json.AppendFormat(",\"s1\":\"{0}\"", row["ThumbName"]);
                    json.AppendFormat(",\"s2\":\"{0}\"", row["PhotoName"]);
                    json.AppendFormat(",\"order\":{0}", row["OrderIndex"].ToString());
                    json.AppendFormat(",\"width\":{0}", row["Width"].ToString());
                    json.AppendFormat(",\"height\":{0}", row["Height"].ToString());
                    json.Append("}");
                    ++count;
                }
            }
            json.Append("]");

            return json.ToString();
        }

        static public AjaxResult GetPhotos()
        {
            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty };
            HttpRequest req = HttpContext.Current.Request;

            if (string.IsNullOrEmpty(req["galleryId"]))
            //if (string.IsNullOrEmpty(req.Form["galleryId"]))
            {
                ar.ReturnCode = -1;
                ar.Message = "NO Gallery Found!";
                OutputResult(ar);
            }

            //int gId = int.Parse(req.Form["galleryId"]);
            int gId = int.Parse(req["galleryId"]);
            DataTable t = Utility.GetPhotos(gId);
            /*
            System.Text.StringBuilder json = new System.Text.StringBuilder();
            json.Append("[");
            if (t.Rows.Count > 0)
            {
                int count = 0;
                foreach (DataRow row in t.Rows)
                {
                    if (count > 0)
                    {
                        json.Append(",");
                    }
                    json.Append("{");

                    // id
                    json.AppendFormat("\"id\":{0}", row["ID"].ToString());
                    json.AppendFormat(",\"s1\":\"{0}\"", row["ThumbName"]);
                    json.AppendFormat(",\"s2\":\"{0}\"", row["PhotoName"]);
                    json.AppendFormat(",\"order\":{0}", row["OrderIndex"].ToString());
                    json.AppendFormat(",\"width\":{0}", row["Width"].ToString());
                    json.AppendFormat(",\"height\":{0}", row["Height"].ToString());
                    json.Append("}");
                    ++count;
                }
            }
            json.Append("]");

            //ar.Message = json.ToString();
            */
            ar.Json = JsonlizePhotoList(t);
            //HttpContext.Current.Response.Write("{\"msgId:0,\"message\":" + json.ToString() + "}");
            return ar;
        }

        #endregion

        #region AddPhoto

        static public AjaxResult AddPhoto()
        {
            int gId = int.Parse(HttpContext.Current.Request.Form["galleryId"]);
            AjaxResult ar = new AjaxResult();
            ar.Message = string.Empty;
            ar.ReturnCode = 0;
            ar.Json = Utility.AddPhoto(gId).ToString();
            return ar;
        }

        #endregion

        #region DeletePhoto

        static public AjaxResult DeletePhoto()
        {
            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = "{}" };
            //DataTable = Utility.GetTable(

            try
            {
                int photoId = int.Parse(HttpContext.Current.Request.Form["photoId"]);
                ar.ReturnCode = Utility.DeletePhoto(photoId);
            }
            catch (System.Exception ex)
            {
                ar.Message = ex.Message;
            }
            return ar;
        }

        #endregion

        #region Process

        static public AjaxResult Process()
        {
            return Process(true);
        }
        static public AjaxResult Process(bool needAuthentication)
        {

            HttpResponse response = System.Web.HttpContext.Current.Response;
            response.ContentType = "application/x-javascript;charset=UTF-8";
            response.Clear();
            string methodName = HttpContext.Current.Request.QueryString["method"];

            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty };
            if (string.IsNullOrEmpty(methodName))
            {
                ar.ReturnCode = -1001;
                ar.Message = "No method found!";
            }
            else
            {
                System.Reflection.MethodInfo method = typeof(WebMethods).GetMethod(methodName);
                try
                {
                    ar = (AjaxResult)method.Invoke(null, null);
                }
                catch (System.Exception ex)
                {
                    ar.ReturnCode = -1;
                    ar.Message = ex.Message;
                }
            }
            //response.Write("{" + string.Format("\"msgId\":{0},\"message\" :\"{1}\"",
            //       ar.ReturnCode,
            //       ar.Message.Replace("\"", "\\\"")) + "}");
            //ar.Json = jsonData;
            OutputResult(ar);

            //response.Write("{\"msgId\":0, \"message\":\"hi\"}");
            //response.Write("{msgId:0}");
            response.End();
            return ar;
        }

        #endregion

        #region OutputResult

        static public void OutputResult(AjaxResult ar)
        {
            if (string.IsNullOrEmpty(ar.Json))
            {
                ar.Json = "{}";
            }
            HttpContext.Current.Response.Write("{" + string.Format("\"msgId\":{0},\"message\" :\"{1}\",\"data\":{2}",
                          ar.ReturnCode,
                          ar.Message.Replace("\"", "\\\""),
                          ar.Json) + "}");
        }

        #endregion

        #region UpdateGallery

        static public AjaxResult UpdateGallery()
        {
            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = "{}" };
            HttpRequest req = HttpContext.Current.Request;
            try
            {
                int galleryId = int.Parse(req.Form["galleryId"]);
                int show = int.Parse(req.Form["Show"]);
                string galleryName = req.Form["galleryName"];
                string comments = req.Form["galleryDescription"];

                Utility.UpdateGallery(galleryId, galleryName, show, comments);
            }
            catch (System.Exception ex)
            {
                ar.ReturnCode = 1;
                ar.Message = ex.Message;
            }
            return ar;
        }

        #endregion

        #region GetGalleries

        static public AjaxResult GetGalleries()
        {
            //DataTable t = Utility.GetGalleries();
            //DataRow[] rows = t.Select("Show=1");
            //for (int i = 0; i < rows.Count; ++i)
            //{
            //}

            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = Utility.GetGalleriesJson() };
            return ar;

        }

        #endregion

        #region AddAccount

        static public AjaxResult AddAccount()
        {
            HttpRequest req = HttpContext.Current.Request;
            string firstName = req.Form["firstName"];
            string lastName = req.Form["lastName"];
            string email = req.Form["email"];

            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = "{}" };
            if (Utility.CheckAccountExist(email))
            {
                ar.ReturnCode = -1;
                ar.Message = "The current email has been regeistered before!";
                return ar;
            }

            Utility.AddAccount(firstName, lastName, email);
            return ar;
        }

        #endregion

        #region UpdatePriceSettings

        static public AjaxResult UpdatePriceSettings()
        {
            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = "{}" };

            Utility.UpdatePriceSettigns(HttpContext.Current.Request.Form["priceSettings"]);

            return ar;
        }

        #endregion

        #region GetClients

        static public AjaxResult GetClients()
        {
            DataTable t = Utility.GetTable("SELECT [ID],[FirstName],[LastName],[Email],[Password],[GalleryId] FROM [TAccount]");
            AjaxResult ar = new AjaxResult();
            ar.ReturnCode = 0;
            ar.Message = string.Empty;

            if (t.Rows.Count == 0)
            {
                ar.Json = "{}";
                return ar;
            }

            System.Text.StringBuilder json = new System.Text.StringBuilder();
            json.Append("[");
            int count = 0;
            foreach (DataRow row in t.Rows)
            {
                if (count > 0)
                {
                    json.Append(",");
                }

                //string firstName =   row["FirstName"] == DBNull.Value ? string.Empty : row["FirstName"].ToString().Replace("\"", "\\\"");
                //string lastName = row["LastName

                json.Append("{");
                json.AppendFormat("\"id\":{0}", row["ID"]);
                json.AppendFormat(",\"firstName\":\"{0}\"", Utility.JsonCellData(row["FirstName"]));
                json.AppendFormat(",\"lastName\":\"{0}\"", Utility.JsonCellData(row["LastName"]));
                json.AppendFormat(",\"email\":\"{0}\"", Utility.JsonCellData(row["Email"]));
                json.AppendFormat(",\"password\":\"{0}\"", Utility.JsonCellData(row["Password"]));
                json.AppendFormat(",\"galleryId\":{0}", row["GalleryId"]);
                json.Append("}");

                ++count;
            }
            json.Append("]");

            ar.Json = json.ToString();
            return ar;
        }

        #endregion

        #region SetClientPassword

        static public AjaxResult SetClientPassword()
        {
            HttpRequest req = HttpContext.Current.Request;
            string password = req.Form["password"];
            int id = int.Parse(req.Form["id"]);
            int galleryId = int.Parse(req.Form["galleryId"]);

            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = "{}" };

            if (Utility.CheckPasswordExist(password))
            {
                ar.ReturnCode = -1;
                ar.Message = "The password has been used. Please select another onee!";
                return ar;
            }
            Utility.SetClientPassword(id, password, galleryId);
            return ar;

        }

        static public AjaxResult RemovePassword()
        {
            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = "{}" };

            int id = int.Parse(HttpContext.Current.Request.Form["id"]);

            /*
            SqlCommand command = Utility.GetCommand(string.Format("DELETE FROM [TAccount] WHERE [ID] = {0}", id));
            command.ExecuteNonQuery();
            command.Connection.Close();
            command.Dispose();
            */

            Utility.SetClientPassword(id, string.Empty, -1);

            return ar;

        }

        #endregion

        static public AjaxResult GetPhotosFromClient()
        {
            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = "[]" };
            HttpRequest req = HttpContext.Current.Request;

            string password = req.Form["password"];
            if (string.IsNullOrEmpty(password))
            {
                return ar;
            }

            string sql = "SELECT TOP 1 [GalleryId] FROM [TAccount] WHERE Password = '" + password.Replace("'", "''") + "';";
            DataTable t = Utility.GetTable(sql);
            if (t.Rows.Count == 0)
                return ar;


            int galleryId = int.Parse(t.Rows[0][0].ToString());
            //req.Form.Add("galleryId", galleryId.ToString() );
            //req.Form.Set("galleryId", galleryId.ToString());


            ar.Json = JsonlizePhotoList(Utility.GetPhotos(galleryId));
            ar.Message = Utility.GetGalleryDescription(galleryId);
            if (ar.Message == null)
            {
                ar.Message = string.Empty;
            }
            return ar;
        }

        static public AjaxResult DeleteClient()
        {
            int clientId = int.Parse(HttpContext.Current.Request.Form["clientId"]);

            string sql = "DELETE FROM [TAccount] WHERE [ID] = " + clientId;
            SqlCommand com = Utility.GetCommand(sql);
            com.ExecuteNonQuery();
            com.Connection.Close();
            com.Dispose();

            AjaxResult ar = new AjaxResult { ReturnCode = 0, Message = string.Empty, Json = "{}" };
            return ar;
        }
    }

    public class AjaxResult
    {
        public int ReturnCode { get; set; }
        public string Message { get; set; }
        public string Json { get; set; }
    }
}
