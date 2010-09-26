using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;

namespace Blue.Airport.Win.Lib
{
    public class DbUtility
    {
        #region ConnectionString

        static public string ConnectionString
        {
            get
            {
                return System.Configuration.ConfigurationSettings.AppSettings["Blue.Airport.Win.Properties.Settings.BullConnectionString"];
            }
        }

        #endregion

        #region GetConnection

        static public SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConnectionString;// System.Configuration.ConfigurationManager.ConnectionStrings[CONN_NAME].ConnectionString;
            return conn;
        }

        #endregion

        #region GetCommand

        static public SqlCommand GetCommand()
        {
            SqlConnection conn = GetConnection();
            conn.Open();
            return conn.CreateCommand();
        }

        #endregion
    }
}
