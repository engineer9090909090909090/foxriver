<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="Gallery.Web.Gallery" %>

<%@ Register TagName="Player" TagPrefix="Gallery" Src="~/GalleryControl.ascx" %>
<%@ Register TagName="Header" TagPrefix="Gallery" Src="~/SiteHeader.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DxD Photography - Specializing in Equine Photography</title>
    <meta name="keywords" content="Equine photography, Pet photography, Pet portraits" />
    <link href="Style.css" type="text/css" rel="Stylesheet" />
       <script language="javascript" type="text/javascript">
    var photoList = <%= Photos %>;
    var description = "<%= Description %>";
    </script>

    <style type="text/css">
        .thumb
        {
            width: 50px;
            height: 50px;
            margin-top: 0px;
            margin-bottom: 10px;
            margin-left: 18px;
            float: left;
            cursor: pointer;
        }
        .img_thumb
        {
            width: 50px;
            height: 50px;
            margin: 0;
            border: none;
        }
        #outerContainer
        {
            width: 150px;
            height: 360px;
            overflow: hidden;
            z-index: 10;
            position: relative;
        }
        #Slide
        {
            position: relative;
            top: 0px;
            left: 0px;
            z-index: 0;
            overflow: hidden;
        }
        #cpBottom
        {
            text-align: center;
            height: 25px;
            line-height: 25px;
        }
        #cp a
        {
            color: #ffffff;
            text-decoration: none;
        }
        #cpTop
        {
            height: 25px;
            line-height: 25px;
        }
    </style>
</head>
<body>
    <Gallery:Header ID="Header1" runat="server" />
            <Gallery:Player ID="Player1" runat="server" />

    
       
     
     <p style="visibility: visible" align="center">
            &nbsp;<br />
            <font color="#ffffff">Copyright © DxD Photography. All rights reserved.</font></p>
    
</body>
</html>
