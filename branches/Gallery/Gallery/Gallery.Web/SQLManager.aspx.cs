using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;

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

        #region btnCreateDb

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

        #endregion

        #region Run & Generate Grid View

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

        #endregion

        protected void btnUpdatePhotoSizeFromFile_Click(object sender, EventArgs e)
        {
            
            string folder = Server.MapPath("~/Photos");
            System.Text.StringBuilder error = new System.Text.StringBuilder();
            System.IO.DirectoryInfo photoFolder = new System.IO.DirectoryInfo(folder);
            System.IO.FileInfo[] photos = photoFolder.GetFiles();
            foreach (FileInfo file in photos)
            {
                if (file.FullName.IndexOf("_thumb.") > -1)
                {
                    continue;
                }
                try
                {
                    Utility.UpdatePhotoSize(file.FullName);
                }
                catch (System.Exception ex)
                {
                    error.Append(ex.Message);
                    error.Append("\r\n");
                }
            }

            if (error.Length > 0)
            {
                Info.Text = error.ToString();
            }
            else
            {
                Info.Text = "Update OK";
            }
        }


        void ProcessSinglePhoto(FileInfo file)
        {
            //System.Drawing.Image img = System.Drawing.Image.FromFile(file);


        }
    }
}
