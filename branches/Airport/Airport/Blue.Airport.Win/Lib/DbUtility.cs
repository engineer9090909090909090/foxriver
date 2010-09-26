using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace Blue.Airport.Win.Lib
{
    public class DbUtility
    {
        #region ConnectionString

        static public string ConnectionString
        {
            get
            {
                return System.Configuration.ConfigurationManager.ConnectionStrings["Blue.Airport.Win.Properties.Settings.BullConnectionString"].ConnectionString;
                //return System.Configuration.ConfigurationSettings.AppSettings["Blue.Airport.Win.Properties.Settings.BullConnectionString"];
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

        #region GetDataTable

        static public DataTable GetDataTable(SqlCommand command, string sqlText, CommandType commandType, params SqlParameter[] paraList)
        {
            command.CommandType = commandType;
            command.CommandText = sqlText;
            command.Parameters.Clear();
            command.Parameters.AddRange(paraList);
            DataSet ds = new DataSet();
            SqlDataAdapter ada = new SqlDataAdapter(command);
            ada.Fill(ds);
            if (ds.Tables.Count > 0)
                return ds.Tables[0];

            return null;
        }

        static public DataTable GetDataTable(SqlCommand command, string spName, params SqlParameter[] paraList)
        {
            return GetDataTable(command, spName, CommandType.StoredProcedure, paraList);
        }

        #endregion

        #region GetDataRow

        static public DataRow GetDataRow(SqlCommand command, string sqlText, CommandType commandType, params SqlParameter[] paraList)
        {
            DataTable t = GetDataTable(command, sqlText, commandType, paraList);
            if (t == null)
                return null;
            if (t.Rows.Count == 0)
                return null;
            return t.Rows[0];
        }

        static public DataRow GetDataRow(SqlCommand command, string spName, params SqlParameter[] paraList)
        {
            return GetDataRow(command, spName, CommandType.StoredProcedure, paraList);
        }

        #endregion
    }
}
