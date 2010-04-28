<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Gallery.Web.Admin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Page</title>
    <style type="text/css">
        BODY
        {
            border-right: 0px;
            padding-right: 0px;
            border-top: 0px;
            padding-left: 0px;
            background: url(Images/desk.jpg) #3d71b8 no-repeat left top;
            padding-bottom: 0px;
            margin: 0px;
            font: 12px tahoma, arial, verdana, sans-serif;
            overflow: hidden;
            border-left: 0px;
            padding-top: 0px;
            border-bottom: 0px;
            height: 100%;
        }
        a.selected
        {
        	color:Blue;
        }
        A
        {
            display: block;
            width: 64px;
            color: white;
            text-decoration: none;
        }
        a:hover
        {
            text-decoration: underline;
        }
        a img
        {
            border-right: 0px;
            border-top: 0px;
            border-left: 0px;
            border-bottom: 0px;
        }
        .menu_container
        {
            position: absolute;
            left: 10px;
            top: 20px;
            width: 90px;
            text-align: center;
        }
        .menu_item
        {
            width: 64px;
        }
        .win
        {
            border: solid 2px #649fe5;
            position: absolute;
            left: 300px;
            top: 90px;
            display: none;
        }
        .window_header
        {
            height: 25px;
            line-height: 25px;
            background: url(images/top-bottom.png) repeat-x 0px 0px;
            border-bottom: solid 2px #649fe5;
            font-weight: bold;
        }
        .window_content
        {
            background-color: #ffffff;
        }
    </style>
    <script language="javascript">
    var _IsSignIn = <%= IsSignIn %>;
    </script>

    <script language="javascript" src="scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

    <script language="javascript" src="scripts/admin.js" type="text/javascript"></script>

    <script language="javascript" src="scripts/ajaxfileupload.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    
    <div class="menu_container" id="menu_container">
    </div>
    <div id="Login" class="win" style="width: 300px;">
        <div class="window_header" style="width: 300px;">
            Login
        </div>
        <div class="window_content">
            <table>
                <tr>
                    <td>
                        User Name
                    </td>
                    <td>
                        <input type="text" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Password
                    </td>
                    <td>
                        <input type="password" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="button" value="Login" onclick="Login();" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="passwordManagement" class="win" style="width: 300px;">
        <div class="window_header" style="width: 300px;">
            Password Maintainance
        </div>
        <div class="window_content" style="">
            user name:
        </div>
    </div>
    
    <div id="galleryManagement" class="win" style="width: 500px;">
        <div class="window_header" style="width: 500px;">
            Gallery Management
        </div>
        <div class="window_content" style="">
            user name:
        </div>
    </div>
    
    <div id="photo" class="win" style="width: 500px;">
        <div class="window_header" style="width: 500px;">
            Photo Upload
        </div>
        <div class="window_content" style="">
            <input type="file" id="fileToUpload" name="fileToUpload" />
        </div>
        <div><input type="button" value="Save" onclick="SavePhoto();"/></div>
    </div>
    
    
    <img id="Loading" src="images/loading.gif" style="position: absolute; left: 250px; top: 200px;display:none;" />
    </form>
</body>
</html>
