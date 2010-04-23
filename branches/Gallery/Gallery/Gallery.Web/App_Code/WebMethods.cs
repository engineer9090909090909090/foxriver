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
            OutputResult(ar);

            //response.Write("{\"msgId\":0, \"message\":\"hi\"}");
            //response.Write("{msgId:0}");
            response.End();
            return ar;
        }

        #endregion

        static public void OutputResult(AjaxResult ar)
        {
            HttpContext.Current.Response.Write("{" + string.Format("\"msgId\":{0},\"message\" :\"{1}\"",
                          ar.ReturnCode,
                          ar.Message.Replace("\"", "\\\"")) + "}");
        }
    }

    public class AjaxResult
    {
        public int ReturnCode { get; set; }
        public string Message { get; set; }
    }
}
