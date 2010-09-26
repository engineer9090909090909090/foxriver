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
    }
}
