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
        //Data Source=207.56.187.6,1433\SQLExpress1;Initial Catalog=dxdpho;User Id=dxdphosql;Password=your password;
        #region GetCommand

        static public SqlCommand GetCommand()
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Gallery"].ConnectionString);
            SqlCommand com = conn.CreateCommand();
            com.CommandType = CommandType.Text;
            conn.Open();
            return com;
        }

        static public SqlCommand GetCommand(string sql)
        {
            SqlCommand comm = GetCommand();
            comm.CommandText = sql;
            return comm;
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

        #region GetGallery

        static public DataTable GetGalleries()
        {
            using (SqlCommand command = GetCommand())
            {
                command.CommandText = "SELECT [ID], [GalleryName],[Show] FROM TGallery";

                DataTable t = new DataTable();
                SqlDataAdapter ada = new SqlDataAdapter(command);
                ada.Fill(t);

                command.Connection.Close();
                command.Dispose();

                return t;
            }
        }

        static public string GetGalleriesJson()
        {
            System.Text.StringBuilder json = new System.Text.StringBuilder();
            json.Append("[");

            DataTable t = GetGalleries();

            if (t.Rows.Count > 0)
            {
                int count = 0;
                foreach (DataRow row in t.Rows)
                {
                    if (count > 0)
                        json.Append(",");
                    json.Append("{");
                    json.AppendFormat("\"id\":{0},\"text\":\"{1}\",\"show\":{2}",
                        row[0].ToString(),
                        row[1].ToString().Replace("\"", "\\\""),
                        row[2].ToString());
                    json.Append("}");
                    ++count;
                }
            }
            json.Append("]");

            return json.ToString();
        }

        #endregion

        #region GetPhotos

        static public DataTable GetPhotos(int galleryId)
        {
            SqlCommand command = GetCommand();
            command.CommandText = "SELECT [ID],	[ThumbName],[PhotoName],[OrderIndex],[GalleryId] FROM TPhotos WHERE [GalleryId] = " + galleryId.ToString();

            DataTable t = new DataTable();
            SqlDataAdapter ada = new SqlDataAdapter(command);
            ada.Fill(t);
            command.Connection.Close();
            command.Dispose();
            ada.Dispose();

            return t;
        }

        #endregion

        static public int AddPhoto(int galleryId)
        {
            SqlCommand comm = GetCommand(string.Format("INSERT INTO TPhotos ( GalleryId ) VALUES ({0});SELECT @@IDENTITY", galleryId));
            //comm.ExecuteNonQuery();
            object o = comm.ExecuteScalar();
            comm.Connection.Close();
            comm.Dispose();

            return int.Parse(o.ToString());
        }

        #region GetTable

        static public DataTable GetTable(string commandText)
        {
            DataTable t = new DataTable();
            SqlCommand command = GetCommand(commandText);

            SqlDataAdapter ada = new SqlDataAdapter(command);
            ada.Fill(t);
            command.Connection.Close();

            command.Dispose();
            ada.Dispose();
            return t;
        }

        #endregion

        static public int DeletePhoto(int photoId)
        {
            DataTable t = GetTable(string.Format("SELECT [ID],	[ThumbName],[PhotoName],[OrderIndex],[GalleryId] FROM TPhotos WHERE [ID] = {0}", photoId));
            if (t.Rows.Count == 0)
                return -1;

            string photosFolder = HttpContext.Current.Server.MapPath("~/Photos");
            if (t.Rows[0]["ThumbName"] != DBNull.Value)
            {
                //string photoName = photosFolder.EndsWith("\\")
                DeleteFile(t.Rows[0]["ThumbName"].ToString());
            }
            if (t.Rows[0]["PhotoName"] != DBNull.Value)
            {
                DeleteFile(t.Rows[0]["PhotoName"].ToString());
            }

            SqlCommand comm = GetCommand(string.Format("DELETE FROM TPhotos WHERE [ID] = {0}", photoId));
            comm.ExecuteNonQuery();
            comm.Connection.Close();
            comm.Dispose();
            return 0;
        }

        static void DeleteFile(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
            {
                return;
            }
            string folder = HttpContext.Current.Server.MapPath("~/Photos");
            string target = folder.EndsWith("\\") ? folder + fileName : folder + "\\" + fileName;
            if (System.IO.File.Exists(target))
            {
                System.IO.File.Delete(target);
            }
        }
    }
}
