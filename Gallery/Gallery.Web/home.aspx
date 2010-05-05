﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Gallery.Web.home" %>
<%@ Register TagName="Header" TagPrefix="Gallery" Src="~/SiteHeader.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>DxD Photography - Specializing in Equine Photography</title>
    <meta name="keywords" content="Equine photography, Pet photography, Pet portraits" />
    <link href="Style.css" type="text/css" rel="Stylesheet" />


</head>
<body>
    <form id="form1" runat="server">
    
        <Gallery:Header ID="Header1" runat="server" />
    <div id="container">
        <%--<div id="header">
            <div id="header_text">
                <p>
                    &nbsp;</p>
            </div>
            <ul id="Menu">
            </ul>
        </div>--%>
        <div id="content">
            <div id="left">
                <div class="Paragraph">
                    Photographic images give us a lasting record of the parts of our lives that we most
                    want to preserve. At DxD Photography, we have the skills and experience to provide
                    you with a unique array of images that is tailored to you and your horse or pet.
                    No two photography sessions are ever alike, and we are always open to any suggestions
                    or ideas you may wish to offer to ensure you have the treasured essence of your
                    horse or pet captured forever.
                </div>
                <div class="Paragraph">
                    Our Gallery Photographs are available for sale in various sizes. If you are interested
                    in purchasing a use license for any of the Gallery images, please use the contact
                    page to inquire.
                </div>
                <div class="Paragraph">
                    Our photography services are provided primarily in Southern California.
                </div>
                <div class="Paragraph">
                    Thank you for visiting the DxD Photography website. We hope you enjoy the images.
                </div>
            </div>
            <div id="right">
                <p>
                    <br />
                    <img height="284" src="Images/homepage.jpg" width="189" border="0" />
                </p>
            </div>
            <div style="clear:both;"></div>
        </div>
        <div id="footer">
            <font color="#ffffff">Copyright © DxD Photography. All rights reserved.</font></div>
    </div>
    </form>
</body>
</html>
