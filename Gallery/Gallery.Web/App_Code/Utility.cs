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
    public class Utility
    {
        static public SqlCommand GetCommand()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Gallery"].ConnectionString);
            SqlCommand com = conn.CreateCommand();
            com.CommandType = CommandType.Text;
            conn.Open();
            return com;
        }
    }
}
