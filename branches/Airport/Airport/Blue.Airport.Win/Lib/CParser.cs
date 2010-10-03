using System;
using System.Collections.Generic;
using System.Text;
using System.Data.OleDb;
using System.Windows.Forms;
using System.IO;
using System.Data.SqlClient;

namespace Blue.Airport.Win.Lib
{
    public class CParser
    {
        // Fields
        private string filename;
        public delegate void ShowWaitingText(string text);
        public ShowWaitingText WaitingMethod;

        internal FrmWaiting WaitingForm { get; set; }

        // Methods
        public CParser(string Filename)
        //public CParser(string Filename, ShowWaitingText waitingMethod)
        {
            this.filename = Filename;
            //_ShowWaitingText = waitingMethod;
        }

        #region checkDB
        /*
        public bool checkDB()
        {

            this.tfrmProgress.txtProgress.Text = "正在验证数据库版本";
            this.tfrmProgress.Refresh();
            this.tfrmProgress.progressBar.Value = 0;

            OleDbConnection connection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + this.lcDbLocation);
            connection.Open();
            OleDbCommand command = new OleDbCommand();
            command.Connection = connection;
            try
            {
                command.CommandText = "SELECT Version FROM version";
                OleDbDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    string str = reader.GetString(0);
                    if (str == Application.ProductVersion)
                    {
                        return true;
                    }
                    MessageBox.Show("数据库版本号与程序不符\n数据库版本 = " + str + "\n本程序版本 = " + Application.ProductVersion + "\n解析将无法继续", "数据库版本号错误", MessageBoxButtons.OK, MessageBoxIcon.Hand);
#warning Just return true
                    return true;
                    //return false;
                }
                MessageBox.Show("无法读取数据库版本号，可能是由于数据库版本过老造成，解析将无法继续", "数据库版本号错误", MessageBoxButtons.OK, MessageBoxIcon.Hand);

                return false;
            }
            catch (OleDbException)
            {
                MessageBox.Show("无法读取数据库版本号，可能是由于数据库版本过老造成，解析将无法继续", "数据库版本号错误", MessageBoxButtons.OK, MessageBoxIcon.Hand);

#warning just change to true
                return true;
                //return false;
            }
        }
        */
        #endregion

        #region parseFLR OLD
        /*
        public void parseFLR_OLD()
        {
            this.tfrmProgress.txtProgress.Text = "正在解析FLR纪录";
            this.tfrmProgress.Refresh();
            this.tfrmProgress.progressBar.Value = 0;
            StreamReader reader = File.OpenText(this.filename);
            string str2 = "";
            string str3 = "";
            string str4 = "";
            string str5 = "";
            string str6 = "";
            int num = 0;
            int num2 = 0;
            int num3 = 0;
            int num4 = 0;
            int num5 = 0;
            int num6 = 0;
            int num7 = 0;
            bool flag = false;
            int num8 = 0;
            OleDbConnection connection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + this.lcDbLocation);
            connection.Open();
            OleDbCommand command = new OleDbCommand();
            OleDbCommand command2 = new OleDbCommand();
            command.Connection = connection;
            command2.Connection = connection;
            string str = reader.ReadLine();
            this.tfrmProgress.progressBar.Increment(1);
            while (str != null)
            {
                str = reader.ReadLine();
                this.tfrmProgress.progressBar.Increment(1);
                if (str != null)
                {
                    str = str.Trim();
                    if ((str.Length > 4) && (str.Substring(0, 5) == "-END-"))
                    {
                        flag = false;
                    }
                    else if (str.Length > 6)
                    {
                        if ((str.Substring(0, 4).ToLower() == ">flr") && (str.Substring(str.Length - 1, 1).ToLower() == "f"))
                        {
                            flag = true;
                            str = reader.ReadLine();
                            this.tfrmProgress.progressBar.Increment(1);
                            str3 = str.Substring(5).Split(new char[] { '/' })[1].ToUpper();
                            str = reader.ReadLine();
                            this.tfrmProgress.progressBar.Increment(1);
                            continue;
                        }
                        if (str.Substring(0, 5) == "TOTAL")
                        {
                            flag = false;
                            continue;
                        }
                        if ((str.Substring(str.Length - 1, 1) == "+") || (str.Substring(str.Length - 1, 1) == "-"))
                        {
                            str = str.Substring(0, str.Length - 1).Trim();
                        }
                        if (((str.Length > 60) && flag) && (str.Trim().Substring(0, 4) != "TIME"))
                        {
                            str4 = str.Substring(0, 7).Trim();
                            str4 = str4.Substring(0, 3) + str4.Substring(4, 3);
                            str5 = str.Substring(8, 4).Trim();
                            str2 = str.Substring(14, 7).Trim();
                            str6 = str.Substring(0x16, 4).Trim();
                            num = int.Parse(str.Substring(0x1c, 4).Trim());
                            num2 = int.Parse(str.Substring(0x24, 4).Trim());
                            num3 = int.Parse(str.Substring(0x2c, 4).Trim());
                            num4 = int.Parse(str.Substring(0x34, 4).Trim());
                            num5 = int.Parse(str.Substring(0x3b, 4).Trim());
                            num6 = int.Parse(str.Substring(0x41, 4).Trim());
                            num7 = int.Parse(str.Substring(0x49, 3).Trim());
                            command.CommandText = "SELECT Id FROM flrtable WHERE fltsegment = '" + str4 + "' AND flightcode = '" + str2 + "' AND flighttime = '" + str5 + "' AND flightdate = '" + str3 + "'";
                            OleDbDataReader reader2 = command.ExecuteReader();
                            if (!reader2.Read())
                            {
                                reader2.Close();
                                command2.CommandText = string.Concat(new object[] { 
                                "INSERT INTO flrtable (flightdate,flighttime,flightcode,fltsegment,flrtype,flrrcnfrm,flrnrcfrm,flrnohost,flrconnect,flrcnl,flrcap,flrlf,flrreal) VALUES ('", str3, "','", str5, "','", str2, "','", str4, "','", str6, "','", num, "','", num2, "','", num3, 
                                "','", num4, "','", num5, "','", num6, "','", num7, "','", num + num2, "')"
                             });
                                reader2 = command2.ExecuteReader();
                                num8++;
                            }
                            else
                            {
                                bool flag2 = false;
                                int num9 = reader2.GetInt32(0);
                                reader2.Close();
                                command.CommandText = "SELECT * FROM flrtable WHERE Id = " + num9;
                                reader2 = command.ExecuteReader();
                                reader2.Read();
                                if (reader2.GetString(1) != str3)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetString(2) != str5)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetString(3) != str2)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetString(4) != str4)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetString(5) != str6)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetInt32(6) != num)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetInt32(7) != num2)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetInt32(8) != num3)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetInt32(9) != num4)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetInt32(10) != num5)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetInt32(11) != num6)
                                {
                                    flag2 = true;
                                }
                                if (reader2.GetInt32(12) != num7)
                                {
                                    flag2 = true;
                                }
                                if (flag2)
                                {
                                    reader2.Close();
                                    command2.CommandText = string.Concat(new object[] { 
                                    "UPDATE flrtable SET flightdate='", str3, "', flighttime = '", str5, "', flightcode = '", str2, "', fltsegment = '", str4, "', flrtype = '", str6, "', flrrcnfrm = '", num, "', flrnrcfrm = '", num2, "', flrnohost = '", num3, 
                                    "', flrconnect = '", num4, "', flrcnl = '", num5, "', flrcap = '", num6, "', flrlf = '", num7, "', flrlf = '", num2 + num, "' WHERE Id = ", num9
                                 });
                                    reader2 = command2.ExecuteReader();
                                    num8++;
                                }
                            }
                            reader2.Close();
                        }
                    }
                }
            }
            connection.Close();
            reader.Close();
            if (num8 > 0)
            {
                MessageBox.Show("FLR数据库共提取" + num8.ToString() + "条记录", "FLR解析完毕", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("FLR数据库未搜索到任何新记录", "FLR解析完毕", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
        }
        */
        #endregion

        #region parseFLR

        public void parseFLR()
        {
            /*
            this.tfrmProgress.txtProgress.Text = "正在解析FLR纪录";
            this.tfrmProgress.Refresh();
            this.tfrmProgress.progressBar.Value = 0;
            */
            StreamReader reader = File.OpenText(this.filename);
            string flightcode = "";
            string flightdate = "";
            string fltsegment = "";
            string flighttime = "";
            string flrtype = "";
            int flrrcnfrm = 0;
            int flrnrcfrm = 0;
            int flrnohost = 0;
            int flrconnect = 0;
            int flrcnl = 0;
            int flrcap = 0;
            int flrlf = 0;
            bool flag = false;
            int insertCount = 0;
            SqlConnection connection = DbUtility.GetConnection();
            connection.Open();
            SqlCommand command = connection.CreateCommand();// new OleDbCommand();
            string line = reader.ReadLine();

            while (line != null)
            {
                line = reader.ReadLine();
                if (line == null)
                {
                    continue;
                }
                line = line.Trim();
                ShowProcessingText(line);
                if ((line.Length > 4) && (line.Substring(0, 5) == "-END-"))
                {
                    flag = false;
                }
                else if (line.Length > 6)
                {
                    if ((line.Substring(0, 4).ToLower() == ">flr") && (line.Substring(line.Length - 1, 1).ToLower() == "f"))
                    {
                        flag = true;
                        line = reader.ReadLine();
                        flightdate = line.Substring(5).Split(new char[] { '/' })[1].ToUpper();
                        line = reader.ReadLine();
                        continue;
                    }
                    if (line.Substring(0, 5) == "TOTAL")
                    {
                        flag = false;
                        continue;
                    }
                    if ((line.Substring(line.Length - 1, 1) == "+") || (line.Substring(line.Length - 1, 1) == "-"))
                    {
                        line = line.Substring(0, line.Length - 1).Trim();
                    }
                    if (((line.Length > 60) && flag) && (line.Trim().Substring(0, 4) != "TIME"))
                    {
                        fltsegment = line.Substring(0, 7).Trim();
                        fltsegment = fltsegment.Substring(0, 3) + fltsegment.Substring(4, 3);
                        flighttime = line.Substring(8, 4).Trim();
                        flightcode = line.Substring(14, 7).Trim();
                        flrtype = line.Substring(0x16, 4).Trim();
                        flrrcnfrm = int.Parse(line.Substring(0x1c, 4).Trim());
                        flrnrcfrm = int.Parse(line.Substring(0x24, 4).Trim());
                        flrnohost = int.Parse(line.Substring(0x2c, 4).Trim());
                        flrconnect = int.Parse(line.Substring(0x34, 4).Trim());
                        flrcnl = int.Parse(line.Substring(0x3b, 4).Trim());
                        flrcap = int.Parse(line.Substring(0x41, 4).Trim());
                        flrlf = int.Parse(line.Substring(0x49, 3).Trim());

                        // get id to check if there is data with same id exist
                        int savedId = FlrManager.GetId(command,
                            fltsegment, flightcode, flighttime, flightdate);

                        if ( savedId < 0 )
                        {
                            FlrManager.Insert(command, flightdate, flighttime, flightcode, fltsegment, flrtype, flrrcnfrm, flrnrcfrm, flrnohost, flrconnect, flrcnl, flrcap, flrlf);
                            insertCount++;
                        }
                        else
                        {
                            bool flag2 = false;
                            int num9 = savedId;// reader2.GetInt32(0);
                            command.CommandText = "SELECT * FROM flrtable WHERE Id = " + num9;
                            command.CommandType = System.Data.CommandType.Text;
                            SqlDataReader reader2 = command.ExecuteReader();
                            reader2.Read();
                            if (reader2.GetString(1) != flightdate)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetString(2) != flighttime)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetString(3) != flightcode)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetString(4) != fltsegment)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetString(5) != flrtype)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetInt32(6) != flrrcnfrm)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetInt32(7) != flrnrcfrm)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetInt32(8) != flrnohost)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetInt32(9) != flrconnect)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetInt32(10) != flrcnl)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetInt32(11) != flrcap)
                            {
                                flag2 = true;
                            }
                            if (reader2.GetInt32(12) != flrlf)
                            {
                                flag2 = true;
                            }
                            // close reader2
                            reader2.Close();

                            if (flag2)
                            {
                                /*
                                 * OLD method, i think the real field has errors
                                command2.CommandText = string.Concat(new object[] { 
                                    "UPDATE flrtable SET flightdate='", flightdate, "', flighttime = '", flighttime, "', flightcode = '", flightcode, "', fltsegment = '", fltsegment, "', flrtype = '", flrtype, "', flrrcnfrm = '", flrrcnfrm, "', flrnrcfrm = '", flrnrcfrm, "', flrnohost = '", flrnohost, 
                                    "', flrconnect = '", flrconnect, "', flrcnl = '", flrcnl, "', flrcap = '", flrcap, "', flrlf = '", flrlf, "', flrlf = '", flrnrcfrm + flrrcnfrm, "' WHERE Id = ", num9
                                 });
                                */
                                FlrManager.Update(command,
                                    num9,
                                    flightdate,
                                    flighttime,
                                    flightcode,
                                    fltsegment,
                                    flrtype,
                                    flrrcnfrm,
                                    flrnrcfrm,
                                    flrnohost,
                                    flrconnect,
                                    flrcnl,
                                    flrcap,
                                    flrlf);
                                
                                insertCount++;
                            }
                        }
                    }
                }
            }
            connection.Close();
            reader.Close();
            /*
            if (insertCount > 0)
            {
                MessageBox.Show("FLR数据库共提取" + insertCount.ToString() + "条记录", "FLR解析完毕", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("FLR数据库未搜索到任何新记录", "FLR解析完毕", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            */
        }

        #endregion

        #region parseMLB old
        /*
        public void parseMLB_OLD()
        {
            this.tfrmProgress.txtProgress.Text = "正在解析MLB纪录";
            this.tfrmProgress.Refresh();
            this.tfrmProgress.progressBar.Value = 0;
            StreamReader reader = File.OpenText(this.filename);
            string str2 = "";
            string str3 = "";
            string str4 = "";
            string s = "";
            string str6 = "";
            string str7 = "";
            string str8 = "";
            string str9 = "";
            string str10 = "";
            string str11 = "";
            string str12 = "";
            bool flag = false;
            int num2 = 0;
            int num3 = 0;
            OleDbConnection connection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + this.lcDbLocation);
            connection.Open();
            OleDbCommand command = new OleDbCommand();
            OleDbCommand command2 = new OleDbCommand();
            command.Connection = connection;
            command2.Connection = connection;
            string str = reader.ReadLine();
            //this.tfrmProgress.progressBar.Increment(1);
            while (str != null)
            {
                str = reader.ReadLine();
                //this.tfrmProgress.progressBar.Increment(1);
                if (str == null)
                {
                    continue;
                }
                str = str.Trim();
                if (str.Length <= 5)
                {
                    continue;
                }
                if (str.Substring(0, 4).ToLower() == ">mlb")
                {
                    flag = true;
                    str2 = str.Split(new char[] { '/' })[1].ToUpper();
                    str = reader.ReadLine();
                    this.tfrmProgress.progressBar.Increment(1);
                    str = reader.ReadLine();
                    if (str.Trim().Length != 0)
                    {
                        this.tfrmProgress.progressBar.Increment(1);
                        str3 = str.Split(new char[] { '/' })[1].Substring(0, 7);
                    }
                    continue;
                }
                if (str.Substring(0, 5) == "TOTAL")
                {
                    flag = false;
                    continue;
                }
                if ((str.Substring(str.Length - 3, 3) == "* +") || (str.Substring(str.Length - 3, 3) == "* -"))
                {
                    str = str.Substring(0, str.Length - 3).Trim();
                }
                if (((str.Substring(str.Length - 1, 1) == "+") || (str.Substring(str.Length - 1, 1) == "-")) || (str.Substring(str.Length - 1, 1) == "*"))
                {
                    str = str.Substring(0, str.Length - 1).Trim();
                }
                if ((str.Length == 6) && flag)
                {
                    str4 = str;
                }
                if ((str.Length <= 50) || !flag)
                {
                    continue;
                }
                s = str.Substring(6, 1).Trim();
                if (int.Parse(s) < 1)
                {
                    continue;
                }
                str6 = str.Substring(7, 15).Trim();
                str7 = str.Substring(0x18, 5).Trim();
                str8 = str.Substring(30, 1).Trim();
                str9 = str.Substring(0x20, 4).Trim();
                str10 = str.Substring(0x26, 6).Trim();
                str12 = str.Substring(0x2d, 7).Trim();
                if (str12.Length < 7)
                {
                    str12 = str3;
                }
                if (str.Length == 0x4b)
                {
                    str11 = str.Substring(0x45, 6);
                }
                else
                {
                    str11 = str10;
                }
                command.CommandText = "SELECT Id, ticsellagt FROM mlbtable WHERE ticketname LIKE '" + str6 + "%' AND ticketcode = '" + str7 + "'AND flightdate = '" + str3 + "'AND flightcode = '" + str2 + "'";
                OleDbDataReader reader2 = command.ExecuteReader();
                if (!reader2.Read())
                {
                    if (int.Parse(s) == 1)
                    {
                        reader2.Close();
                        command2.CommandText = "INSERT INTO mlbtable (flightdate,flightcode,fltsegment,ticketname,ticketseat,ticketcode,ticketstat,ticbuydate,ticsellagt) VALUES ('" + str3 + "','" + str2 + "','" + str4 + "','" + str6 + "','" + str8 + "','" + str7 + "','" + str9 + "','" + str12 + "','" + str11 + "')";
                        reader2 = command2.ExecuteReader();
                        num2++;
                        goto Label_066E;
                    }
                    try
                    {
                        for (num3 = 1; num3 <= int.Parse(s); num3++)
                        {
                            reader2.Close();
                            command2.CommandText = "INSERT INTO mlbtable (flightdate,flightcode,fltsegment,ticketname,ticketseat,ticketcode,ticketstat,ticbuydate,ticsellagt) VALUES ('" + str3 + "','" + str2 + "','" + str4 + "','" + str6 + "#" + num3.ToString() + "','" + str8 + "','" + str7 + "','" + str9 + "','" + str12 + "','" + str11 + "')";
                            reader2 = command2.ExecuteReader();
                            num2++;
                        }
                        goto Label_066E;
                    }
                    catch (OleDbException exception)
                    {
                        MessageBox.Show(string.Concat(new object[] { "代号: ", exception.ErrorCode, ": ", exception.Message, "\n发现无法处理的错误，此行数据将被丢弃，根据新版本解决方案，解析将继续进行\n纠错用SQL指令内容: ", command2.CommandText }), "错误:" + exception.ErrorCode, MessageBoxButtons.OK, MessageBoxIcon.Hand);
                        reader2.Close();
                        continue;
                    }
                }
                if (reader2.GetString(1).Trim() == "PEK1E")
                {
                    int num = reader2.GetInt32(0);
                    reader2.Close();
                    command2.CommandText = "UPDATE mlbtable SET ticsellagt='" + str11 + "' WHERE Id=" + num.ToString();
                    reader2 = command2.ExecuteReader();
                }
            Label_066E:
                reader2.Close();
            }
            connection.Close();
            reader.Close();
            if (num2 > 0)
            {
                MessageBox.Show("MLB数据库共提取" + num2.ToString() + "条记录", "MLB解析完毕", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("MLB数据库未搜索到任何新记录", "MLB解析完毕", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
        }
        */

        #endregion

        void ShowProcessingText(string line)
        {
            //_ShowWaitingText(line);
            if (WaitingForm != null && WaitingMethod != null)
            {
                //WaitingForm.ShowText(line);
                WaitingForm.Invoke(WaitingMethod, new object[] { line });
            }
        }

        #region parseMLB

        public void parseMLB()
        {
            StreamReader fileReader = File.OpenText(this.filename);
            string flightcode = "", flightdate = "", ticketName = "", ticketcode = "", ticsellagt = "", fltsegment = "";
            string s = "";
            string ticketseat = "";
            string ticketstat = "";
            string str10 = "";
            string ticbuydate = "";
            bool flag = false;
            int insertCount = 0;
            int num3 = 0;

            string line = fileReader.ReadLine();

            SqlConnection connection = DbUtility.GetConnection();
            connection.Open();
            SqlCommand command = connection.CreateCommand();

            while (line != null)
            {
                line = fileReader.ReadLine();
                if (line == null)
                    continue;

                line = line.Trim();
                if (line.Length <= 5)
                {
                    continue;
                }
                ShowProcessingText(line);

                if (line.Substring(0, 4).ToLower() == ">mlb")
                {
                    flag = true;
                    flightcode = line.Split(new char[] { '/' })[1].ToUpper();
                    line = fileReader.ReadLine();
                    line = fileReader.ReadLine();
                    if (line.Trim().Length != 0)
                    {
                        flightdate = line.Split(new char[] { '/' })[1].Substring(0, 7);
                    }
                    continue;
                }
                if (line.Substring(0, 5) == "TOTAL")
                {
                    flag = false;
                    continue;
                }
                if ((line.Substring(line.Length - 3, 3) == "* +") || (line.Substring(line.Length - 3, 3) == "* -"))
                {
                    line = line.Substring(0, line.Length - 3).Trim();
                }
                if (((line.Substring(line.Length - 1, 1) == "+") || (line.Substring(line.Length - 1, 1) == "-")) || (line.Substring(line.Length - 1, 1) == "*"))
                {
                    line = line.Substring(0, line.Length - 1).Trim();
                }
                if ((line.Length == 6) && flag)
                {
                    fltsegment = line;
                }
                if ((line.Length <= 50) || !flag)
                {
                    continue;
                }
                s = line.Substring(6, 1).Trim();
                if (int.Parse(s) < 1)
                {
                    continue;
                }
                ticketName = line.Substring(7, 15).Trim();
                ticketcode = line.Substring(0x18, 5).Trim();
                ticketseat = line.Substring(30, 1).Trim();
                ticketstat = line.Substring(0x20, 4).Trim();
                str10 = line.Substring(0x26, 6).Trim();
                ticbuydate = line.Substring(0x2d, 7).Trim();
                if (ticbuydate.Length < 7)
                {
                    ticbuydate = flightdate;
                }
                if (line.Length == 0x4b)
                {
                    ticsellagt = line.Substring(0x45, 6);
                }
                else
                {
                    ticsellagt = str10;
                }


                MlbEntity entity = MlbManager.GetAgent(command, ticketName, ticketcode, flightdate, flightcode);
                if (entity == null)
                {
                    if (int.Parse(s) == 1)
                    {
                        MlbManager.Insert(command,
                            flightdate,
                            flightcode,
                            fltsegment,
                            ticketName,
                            ticketseat,
                            ticketcode,
                            ticketstat,
                            ticbuydate,
                            ticsellagt);

                        insertCount++;
                        goto Label_066E;
                    }
                    try
                    {
                        for (num3 = 1; num3 <= int.Parse(s); num3++)
                        {
                            MlbManager.Insert(command, flightdate, flightcode, fltsegment, ticketName + "#" + num3.ToString(), ticketseat, ticketcode, ticketstat, ticbuydate, ticsellagt);
                            insertCount++;
                        }
                        goto Label_066E;
                    }
                    catch (SqlException exception)
                    {
                        MessageBox.Show(string.Concat(new object[] { "代号: ", exception.ErrorCode, ": ", exception.Message, "\n发现无法处理的错误，此行数据将被丢弃，根据新版本解决方案，解析将继续进行\n纠错用SQL指令内容: ", command.CommandText }), "错误:" + exception.ErrorCode, MessageBoxButtons.OK, MessageBoxIcon.Hand);
                        continue;
                    }
                }

                if (entity.ticsellagt.Trim() == "PEK1E")
                {
                    /*
                    int num = entity.Id;
                    command.CommandText = "UPDATE mlbtable SET ticsellagt='" + ticsellagt + "' WHERE Id=" + num.ToString();
                    command.CommandType = System.Data.CommandType.Text;
                    command.ExecuteNonQuery();
                    */
                    MlbManager.Update_ticsellagt(command, entity.Id, ticsellagt);
                }
            Label_066E: ;
            }// End While
            connection.Close();
            fileReader.Close();

            /*
            if (insertCount > 0)
            {
                MessageBox.Show("MLB数据库共提取" + insertCount.ToString() + "条记录", "MLB解析完毕", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            else
            {
                MessageBox.Show("MLB数据库未搜索到任何新记录", "MLB解析完毕", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
            }
            */
        }

        #endregion
    }
}