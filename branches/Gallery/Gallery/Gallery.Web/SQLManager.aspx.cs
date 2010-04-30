using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Gallery.Web
{
    public partial class SQLManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            //System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();
            //conn.ConnectionString = ConfigurationManager.ConnectionStrings["Gallery"].ConnectionString;
            try
            {
                SqlCommand comm = Utility.GetCommand();

                //conn.Open();
                //conn.Dispose();
                comm.Connection.Close();
                comm.Dispose();
                Info.Text = "Connection is OK!";
            }
            catch (System.Exception ex)
            {
                Info.Text = ex.Message;

            }
            finally
            {
                //conn.Dispose();
            }
        }



        protected void btnCreateDb_Click(object sender, EventArgs e)
        {
            using (SqlCommand command = Utility.GetCommand())
            {
                command.CommandText = DBSchema.Text;

                try
                {
                    command.ExecuteNonQuery();
                }
                catch (System.Exception ex)
                {
                    Info.Text = ex.Message;
                }
                command.Connection.Close();
                command.Connection.Dispose();
                command.Dispose();
            }

        }

        protected void btnRun_Click(object sender, EventArgs e)
        {
            SqlCommand command = Utility.GetCommand(tbSQL.Text.Trim());
            command.ExecuteNonQuery();
            command.Connection.Close();
            command.Dispose();
        }

        protected void btnGenereateGridView_Click(object sender, EventArgs e)
        {
            DataTable table = Utility.GetTable(tbSQL.Text.Trim());
            gv.DataSource = table;
            gv.DataBind();
        }
    }
}
