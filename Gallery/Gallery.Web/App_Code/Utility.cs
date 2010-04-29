#define COM
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
#if COM
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Gallery_VM_COMPANY"].ConnectionString);
#else
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Gallery"].ConnectionString);
#endif
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

        #region UpdateConfig

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

        #endregion

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

        #region AddPhoto

        static public int AddPhoto(int galleryId)
        {
            SqlCommand comm = GetCommand(string.Format("INSERT INTO TPhotos ( GalleryId ) VALUES ({0});SELECT @@IDENTITY", galleryId));
            //comm.ExecuteNonQuery();
            object o = comm.ExecuteScalar();
            comm.Connection.Close();
            comm.Dispose();

            return int.Parse(o.ToString());
        }

        #endregion

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

        #region DeletePhoto

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

        #endregion

        #region DeleteFile

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

        #endregion

        #region UpdateGallery

        static internal void UpdateGallery(int galleryId, string galleryName, int show)
        {
            string sql = "UPDATE [TGallery] SET [GalleryName] = '{0}', [Show] = {1} WHERE [ID] = {2};";
            SqlCommand command = GetCommand(string.Format(sql, galleryName.Replace("'", "''"), show, galleryId));
            command.ExecuteNonQuery();
            command.Connection.Close();
            command.Dispose();
        }

        #endregion

        #region UpdatePhotoFile

        static internal void UpdatePhotoFile(int photoId, string newPhotoName, string photoType)
        {
            string field = "[ThumbName]";
            if (string.Compare( photoType, "s2", true) == 0 )
            {
                field = "[PhotoName]";
            }
            DataTable t = GetTable(string.Format("SELECT {0} FROM [TPhotos] WHERE [ID] = {1}", field, photoId));

            if (t.Rows.Count == 0)
                return;

            if (t.Rows[0][0] != DBNull.Value)
            {
                // delete old photos
                DeleteFile(t.Rows[0][0].ToString());
            }

            SqlCommand comm = GetCommand(string.Format("UPDATE [TPhotos] SET {0} = '{1}' WHERE [ID] = {2}",
                field, newPhotoName, photoId));
            comm.ExecuteNonQuery();
            comm.Connection.Close();
            comm.Dispose();

        }

        #endregion
    }
}
