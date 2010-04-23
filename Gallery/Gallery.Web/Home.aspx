<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Gallery.Web._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Page</title>
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
        #Menu
        {
            position: absolute;
            left: 20px;
            top: 10px;
            width: 120px;
            height: 400px;
            border: solid 1px red;
        }
        #Menu div
        {
            width: 100px;
            margin-top: 10px;
            font-size: 15pt;
            font-weight: bold;
            color: #ffffff;
            display: none;
            cursor: pointer;
        }
        #Content
        {
            position: absolute;
            left: 150px;
            top: 10px;
            background-color: #fff;
        }
        .ContentItem
        {
            position: absolute;
            left: 2000px;
            top: 10px;
            width: 400px;
            height: 500px;
            overflow:hidden;
            display:none;
            color:#fff;
        }
    </style>

    <script language="javascript" src="scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

    <script language="javascript" src="scripts/home.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div id="Menu">
        <div cid="Home">
            Home</div>
        <div cid="Gallery">
            Gallery</div>
        <div cid="Contact">
            Contact</div>
    </div>
    <div id="Content">
    </div>
    <div class="ContentItem" id="Home">
        Home</div>
    <div class="ContentItem" id="Gallery">
        Gallery</div>
    <div class="ContentItem" id="Contact">
        Contact</div>
    </form>
</body>
</html>
