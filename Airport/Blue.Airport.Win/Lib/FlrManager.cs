using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace Blue.Airport.Win.Lib
{
    public class FlrManager
    {
        const string SP_flr_GetId = "flr_GetId";
        const string SP_flr_Insert = "flr_Insert";
        const string SP_flr_Update = "flr_Update";
        const string SP_flr_GetAllData = "flr_GetAllData";

        #region GetId

        static public int GetId(SqlCommand command,
            string fltsegment,
            string flightcode,
            string flighttime,
            string flightdate)
        {
            object o = DbUtility.ExecuteScalar(command, SP_flr_GetId,
                SqlHelper.BuildParameter("fltsegment", fltsegment),
                SqlHelper.BuildParameter("flightcode", flightcode),
                SqlHelper.BuildParameter("flighttime", flighttime),
                SqlHelper.BuildParameter("flightdate", flightdate));

            if (o == null)
                return -1;
            return (int)o;
        }

        #endregion

        #region Insert 

        static public int Insert(SqlCommand command,
            string flightdate,
            string flighttime,
            string flightcode,
            string fltsegment,
            string flrtype,
            int flrrcnfrm,
            int flrnrcfrm,
            int flrnohost,
            int flrconnect,
            int flrcnl,
            int flrcap,
            int flrlf)
        {


            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.CommandText = SP_flr_Insert;
            command.Parameters.Clear();
            SqlHelper.BuildParameter(command, "flightdate", flightdate);
            SqlHelper.BuildParameter(command, "flighttime", flighttime);
            SqlHelper.BuildParameter(command, "flightcode", flightcode);
            SqlHelper.BuildParameter(command, "fltsegment", fltsegment);
            SqlHelper.BuildParameter(command, "flrtype", flrtype);
            SqlHelper.BuildParameter(command, "flrrcnfrm", flrrcnfrm);
            SqlHelper.BuildParameter(command, "flrnrcfrm", flrnrcfrm);
            SqlHelper.BuildParameter(command, "flrnohost", flrnohost);
            SqlHelper.BuildParameter(command, "flrconnect", flrconnect);
            SqlHelper.BuildParameter(command, "flrcnl", flrcnl);
            SqlHelper.BuildParameter(command, "flrcap", flrcap);
            SqlHelper.BuildParameter(command, "flrlf", flrlf);

            return command.ExecuteNonQuery();
        }

      


        #endregion

        #region Update

        static public int Update(SqlCommand command,
          int Id,
          string flightdate,
          string flighttime,
          string flightcode,
          string fltsegment,
          string flrtype,
          int flrrcnfrm,
          int flrnrcfrm,
          int flrnohost,
          int flrconnect,
          int flrcnl,
          int flrcap,
          int flrlf)
        {
            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.CommandText = SP_flr_Update;
            command.Parameters.Clear();
            SqlHelper.BuildParameter(command, "Id", Id);
            SqlHelper.BuildParameter(command, "flightdate", flightdate);
            SqlHelper.BuildParameter(command, "flighttime", flighttime);
            SqlHelper.BuildParameter(command, "flightcode", flightcode);
            SqlHelper.BuildParameter(command, "fltsegment", fltsegment);
            SqlHelper.BuildParameter(command, "flrtype", flrtype);
            SqlHelper.BuildParameter(command, "flrrcnfrm", flrrcnfrm);
            SqlHelper.BuildParameter(command, "flrnrcfrm", flrnrcfrm);
            SqlHelper.BuildParameter(command, "flrnohost", flrnohost);
            SqlHelper.BuildParameter(command, "flrconnect", flrconnect);
            SqlHelper.BuildParameter(command, "flrcnl", flrcnl);
            SqlHelper.BuildParameter(command, "flrcap", flrcap);
            SqlHelper.BuildParameter(command, "flrlf", flrlf);

            return command.ExecuteNonQuery();
        }

        #endregion

        static public DataTable GetData(ref int total, int pageSize, int currentPage)
        {

            SqlParameter totalPara = new SqlParameter();
            totalPara.ParameterName = "total";
            totalPara.DbType = DbType.Int32;
            totalPara.Direction = ParameterDirection.Output;

            DataSet ds = SqlHelper.GetDataSet(Lib.DbUtility.GetConnection(),
                 CommandType.StoredProcedure,
                 SP_flr_GetAllData,
                 totalPara,
                 SqlHelper.BuildParameter("pageSize", pageSize),
                 SqlHelper.BuildParameter("currentPage", currentPage));
            total = (int)totalPara.Value;
            return ds.Tables[0];
        }
    }
}
