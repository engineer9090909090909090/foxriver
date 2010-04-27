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
            System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["Gallery"].ConnectionString;
            try
            {
                conn.Open();
                conn.Dispose();
                Info.Text = "Connection is OK!";
            }
            catch (System.Exception ex)
            {
                Info.Text = ex.Message;

            }
            finally
            {
                conn.Dispose();
            }
        }

        const string SQL_GALLERIES = @"
INSERT INTO TGallery( GalleryName ) VALUES ( '')
";
        void InsertGalleries()
        {
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
    }
}
