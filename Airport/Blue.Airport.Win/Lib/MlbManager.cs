using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace Blue.Airport.Win.Lib
{
    public class MlbManager
    {
        const string SP_GET_AGENT = "mlb_GetSellAgent";
        const string SP_mlb_Insert = "mlb_Insert";
        const string SP_mlb_Update_ticsellagt = "mlb_Update_ticsellagt";
        const string SP_mlb_GetAllData = "mlb_GetAllData";

        #region GetAgent

        static public MlbEntity GetAgent(SqlCommand command,
            string ticketName,
            string ticketcode,
            string flightdate,
            string flightcode)
        {
            //return null;

            DataRow row = DbUtility.GetDataRow(command, SP_GET_AGENT,
                SqlHelper.BuildParameter("ticketName", ticketName),
               SqlHelper.BuildParameter("ticketcode", ticketcode),
               SqlHelper.BuildParameter("flightdate", flightdate),
               SqlHelper.BuildParameter("flightcode", flightcode));
            if (row == null)
                return null;
            MlbEntity me = new MlbEntity() { Id = (int)row["Id"], ticsellagt = row["ticsellagt"].ToString() };
            return me;
        }

        #endregion

        #region Insert

        static public int Insert(SqlCommand command,
            string flightdate,
string flightcode,
string fltsegment,
string ticketName,
string ticketseat,
string ticketcode,
string ticketstat,
string ticbuydate,
string ticsellagt
            )
        {

            command.CommandType = System.Data.CommandType.StoredProcedure;
            command.CommandText = SP_mlb_Insert;
            command.Parameters.Clear();
            SqlHelper.BuildParameter(command, "flightdate", flightdate);
            SqlHelper.BuildParameter(command, "flightcode", flightcode);
            SqlHelper.BuildParameter(command, "fltsegment", fltsegment);
            SqlHelper.BuildParameter(command, "ticketName", ticketName);
            SqlHelper.BuildParameter(command, "ticketseat", ticketseat);
            SqlHelper.BuildParameter(command, "ticketcode", ticketcode);
            SqlHelper.BuildParameter(command, "ticketstat", ticketstat);
            SqlHelper.BuildParameter(command, "ticbuydate", ticbuydate);
            SqlHelper.BuildParameter(command, "ticsellagt", ticsellagt);
            SqlHelper.BuildParameter(command, "_flight_date", DateConverter.FromFlightDate(flightdate));
            SqlHelper.BuildParameter(command, "_ticket_buy_date", DateConverter.FromFlightDate(ticbuydate));

            return command.ExecuteNonQuery();
        }

        #endregion

        #region Update_ticsellagt

        static public int Update_ticsellagt(SqlCommand command, int id, string ticsellagt)
        {
            command.CommandType = CommandType.StoredProcedure;
            command.CommandText = SP_mlb_Update_ticsellagt;
            command.Parameters.Clear();
            SqlHelper.BuildParameter(command, "Id", id);
            SqlHelper.BuildParameter(command, "ticsellagt", ticsellagt);

            return command.ExecuteNonQuery();
        }

        #endregion

        #region GetData

        /*
        static public DataTable GetData(ref int total, int pageSize, int currentPage)
        {
            SqlParameter totalPara = new SqlParameter();
            totalPara.ParameterName = "total";
            totalPara.DbType = DbType.Int32;
            totalPara.Direction = ParameterDirection.Output;

            DataSet ds = SqlHelper.GetDataSet(Lib.DbUtility.GetConnection(),
                 CommandType.StoredProcedure,
                 SP_mlb_GetAllData,
                 totalPara,
                 SqlHelper.BuildParameter("pageSize", pageSize),
                 SqlHelper.BuildParameter("currentPage", currentPage));
            total = (int)totalPara.Value;
            return ds.Tables[0];
        }
        */

        static public DataTable GetData(ref int total, int pageSize, int currentPage, int year, int month)
        {
            DateTime beginDate = new DateTime(year, month, 1);
            DateTime endDate = DateConverter.GetLastDayOfAMonth(beginDate);

            SqlParameter totalPara = new SqlParameter();
            totalPara.ParameterName = "total";
            totalPara.DbType = DbType.Int32;
            totalPara.Direction = ParameterDirection.Output;



            DataSet ds = SqlHelper.GetDataSet(Lib.DbUtility.GetConnection(),
                 CommandType.StoredProcedure,
                 SP_mlb_GetAllData,
                 totalPara,
                 SqlHelper.BuildParameter("pageSize", pageSize),
                 SqlHelper.BuildParameter("currentPage", currentPage),
                 SqlHelper.BuildParameter("flightDateBegin", beginDate),
                SqlHelper.BuildParameter("flightDateEnd", endDate));
            total = (int)totalPara.Value;
            return ds.Tables[0];
        }

        #endregion
    }
}
