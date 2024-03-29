﻿using System;
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
#if DEBUG
                return System.Configuration.ConfigurationManager.ConnectionStrings["Blue.Airport.Win.Properties.Settings.BullConnectionString"].ConnectionString;
#else
                return System.Configuration.ConfigurationManager.ConnectionStrings["Blue.Airport.Win.Properties.Settings.BullConnectionString_Release"].ConnectionString;
#endif
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
            SqlCommand command = conn.CreateCommand();
            command.CommandTimeout = 300;
            return command;
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

        #region ExecuteScalar

        static public object ExecuteScalar(SqlCommand command, string spName, params SqlParameter[] paraList)
        {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = spName;
            command.Parameters.Clear();
            command.Parameters.AddRange(paraList);
            object o = command.ExecuteScalar();
            if (o == DBNull.Value)
                return null;
            return o;
        }

        #endregion

        #region GetDataFromCommand

        static public DataTable GetDataFromCommand(string command)
        {
            using (SqlConnection con = GetConnection())
            {
                DataTable t = SqlHelper.GetDataTable(con,
                     CommandType.Text,
                     command);
                con.Close();
                return t;

            }

        }

        static public DataTable GetDataFromSp(string spName)
        {
            using (SqlConnection con = GetConnection())
            {
                DataTable t = SqlHelper.GetDataTable(con,
                     CommandType.StoredProcedure,
                     spName);
                con.Close();
                return t;

            }
        }

        #endregion
    }
}
