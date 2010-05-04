<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClientManagement.aspx.cs"
    Inherits="Gallery.Web.ClientManagement" %>

<%@ Register TagPrefix="Gallery" TagName="MH" Src="~/ManagementHeader.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Client Management</title>
    <style type="text/css">
        .row
        {
            width: 900px;
            height: 23px;
            color: #ffffff;
            line-height: 23px;
            border-bottom: solid 1px silver;
            margin-top: 1px;
            display: none;
            color: #000000;
        }
        .row a
        {
            color: #666666;
        }
        .header
        {
            width: 900px;
            background-color: #000000;
            color: #ffffff;
            height: 25px;
            line-height: 25px;
            font-weight: bold;
            overflow: hidden;
        }
        .first_name
        {
            float: left;
            width: 120px;
        }
        .last_name
        {
            float: left;
            width: 120px;
        }
        .client_password
        {
            float: left;
            width: 150px;
        }
        .client_password input
        {
            width: 50px;
        }
        .client_email
        {
            float: left;
            width: 180px;
        }
        .send
        {
            float: left;
            width: 80px;
        }
        .gallery
        {
            float: left;
            width: 200px;
        }
    </style>

    <script language="javascript" src="scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
    var clients = <%= Clients %>;
    var gList = <%= Galleries %>
    </script>

    <script language="javascript" src="scripts/client.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <Gallery:MH ID="MH1" runat="server" />
    <div class="win" style="width: 900px; z-index: 20; left: 20px;" id="priceWin">
        <div class="window_header" style="width: 900px;">
            Client Maintainance
        </div>
        <div class="window_content" style="width: 900px; height: 600px;" id="ClientTable">
            <div class="header">
                <div class="first_name">
                    First Name</div>
                <div class="last_name">
                    Last Name</div>
                <div class="client_email">
                    Email</div>
                <div class="client_password">
                    Password</div>
                <div class="gallery">
                    Gallery</div>
                <div class="send">
                    Send Mail</div>
                <div style="clear: both;">
                </div>
            </div>
            <div class="row" id="TEMP">
                <div class="first_name">
                    First Name</div>
                <div class="last_name">
                    Last Name</div>
                <div class="client_email">
                    Email</div>
                
                <div class="client_password">
                    <input type="text" />
                    <a href="javascript:void(0);">set</a>
                </div>
                
                <div class="gallery">
                    <select id="selGalleries">
                        <option value="-1">Not Assigned</option>
                    </select>
                </div>
                <div class="send">
                    <a href="javascript:void(0);">send</a></div>
                <div style="clear: both;">
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
