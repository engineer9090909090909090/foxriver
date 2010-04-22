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
        #region GetCommand

        static public SqlCommand GetCommand()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Gallery"].ConnectionString);
            SqlCommand com = conn.CreateCommand();
            com.CommandType = CommandType.Text;
            conn.Open();
            return com;
        }

        #endregion

        public int UpdateConfig(string name, string value)
        {
            using (SqlCommand command = GetCommand())
            {
                command.CommandText = "DELETE FROM [TConfig] WHERE [Key] = @Key AND [Value] = @Value";
                command.Parameters.Add(new SqlParameter("Key", name));
                command.Parameters.Add(new SqlParameter("Value", value));
                command.ExecuteNonQuery();
                command.Connection.Close();
                command.Connection.Dispose();
            }
            return 0;
        }

        public int UpdatePassword(string oldPwd, string newPwd)
        {
           //ushort
            using (SqlCommand command = GetCommand())
            {
                command.CommandText = "SELECT COUNT(*) FROM TConfig WHERE ";
                //int 
            }
            return -1;
        }
    }
}
