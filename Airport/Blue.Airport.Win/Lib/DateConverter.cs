using System;
using System.Collections.Generic;
using System.Text;

namespace Blue.Airport.Win.Lib
{
    public class DateConverter
    {
        #region FromFlightDate

        static public DateTime FromFlightDate(string flight)
        {
            //01JAN08
            if (flight.Length != 7)
                throw new Exception("The formate is not correct");

            try
            {
                int day = int.Parse(flight.Substring(0, 2));
                int month = 0;
                switch (flight.Substring(2, 3))
                {
                    case "JAN":
                        month = 1;
                        break;
                    case "FEB":
                        month = 2;
                        break;
                    case "MAR":
                        month = 3;
                        break;
                    case "APR":
                        month = 4;
                        break;
                    case "MAY":
                        month = 5;
                        break;
                    case "JUN":
                        month = 6;
                        break;
                    case "JUL":
                        month = 7;
                        break;
                    case "AUG":
                        month = 8;
                        break;
                    case "SEP":
                        month = 9;
                        break;
                    case "OCT":
                        month = 10;
                        break;
                    case "NOV":
                        month = 11;
                        break;
                    case "DEC":
                        month = 12;
                        break;
                }// end convert month

                int year = int.Parse(flight.Substring(5, 2));
                if (year < 50)
                    year += 2000;
                else
                    year = 1900 + year;

                return new DateTime(year, month, day);
            }
            catch
            {
                return new DateTime(1999, 1, 1);
            }
        }

        #endregion

        #region GetLastDayOfAMonth

        static public DateTime GetLastDayOfAMonth(DateTime firstDayOfAMonth)
        {
            /*
            if (firstDayOfAMonth.Day != 1)
            {
                throw new Exception("所选的日期不是当月的第一天");
            }
            */

            //int month = firstDayOfAMonth.Month;
            /*
            DateTime ret = new DateTime(firstDayOfAMonth.Year, firstDayOfAMonth.Month, 2);
            while (ret.Month == month)
            {
                ret.ad
            }
            */
            DateTime ret = firstDayOfAMonth.AddMonths(1);
            ret = ret.AddDays(-1);
            return ret;
        }

        #endregion
    }
}
