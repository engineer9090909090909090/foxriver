﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Gallery.Web.About" %>
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
            
            <div id="content">
                <div id="left">
                <div class="Paragraph">My name is Donna Delikat and I am the owner and principal photographer of <span style="font-weight:900;">DxD Photography</span>.  I specialize in all aspects of equine and pet photography, including equine and pet portraits, competition and action (with or without a rider).  If you have something special in mind, please call us.  It is likely that we can accommodate your request.
                </div>
                <div class="Paragraph">I love photography and I love animals.  My work is more than just being a photographer.  It is about combining two passions into a career that allows me to be creative and provide beautiful images for my clients to love and enjoy for many years. </div>
                
                </div>
                <div id="right">
                    <p>
                        <img height="125" src="images/asmptag_sm.jpg"  border="0" />
                        <br />
                        <br />
                        
                        <img height="146" src="images/EPN_logo.gif" width="150" border="0" /><br />
                        <br />
                        <a href="http://www.socalequine.com/" target="SoCalEquine">
                            <img height="60" alt="#1 Resource Guide in the California Equestrian Marketplace!"
                                src="http://www.socalequine.com/webservices/socalequine2.jpg" width="286" border="0" /></a>
                        <br />
                        <font face="Tahoma" color="#cc6600" size="2" font="font">Member</font><font face="Tahoma"
                            color="#cc6600" size="2" font=""><br />
                            <a href="http://www.socalequine.com/" target="SCED">The Southern California Equestrian
                                Directory</a> </font>
                    </p>
                </div>
                <div style="clear:both;"></div>
            </div>
            <div id="footer">
                <p align="center">
                    <font color="#ffffff">Copyright © DxD Photography. All rights reserved.</font></p>
            </div>
        </div>
    </form>
</body>
</html>
