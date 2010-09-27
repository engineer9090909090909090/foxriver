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

            return command.ExecuteNonQuery();
        }
    }
}
