﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="Gallery.Web.Services" %>
<%@ Register TagName="Header" TagPrefix="Gallery" Src="~/SiteHeader.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DxD Photography - Specializing in Equine Photography</title>
    <meta name="keywords" content="Equine photography, Pet photography, Pet portraits" />
    <link href="Style.css" type="text/css" rel="Stylesheet" />

    <%--<script language="javascript" src="scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

    <script language="javascript" src="scripts/index.js" type="text/javascript"></script>
--%>
    <style type="text/css">
        .price
        {
            width: 370px;
            height: 370px;
            background-image: url(images/price_bg.jpg);
            font-size: 10pt;
        }
        .pleft
        {
            margin-left: 10px;
            font-size: 10pt;
            font-weight: bolder;
            height: 17px;
            line-height: 17px;
            overflow: hidden;
            float: left;
            width: 250px;
            font-family: Tahoma;
            letter-spacing: 0px;
        }
        .pright
        {
            font-size: 10pt;
            font-weight: 900;
            height: 17px;
            line-height: 17px;
            overflow: hidden;
            float: left;
        }
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
    <Gallery:Header ID="Header1" runat="server" />
    <script language="javascript" type="text/javascript">
    var PriceSettings = '<%= PriceSettings %>';
    $(document).ready(function() {
        var ps = PriceSettings.split(',');
        var count = 0;
        $('.pright', $('#left')).each(function(){
            $(this).text('$' +ps[count]);
            ++count;
        });
    });
    </script>
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
                <br />
                <br />
                <br />
                <div class="price">
                    <div class="pleft" style="margin-top: 10px; font-size: 11pt; font-family: Verdana">
                        Pet Portrait and Equine Photography</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft">
                        1 Hour Session Package</div>
                    <div class="pright">
                        $150.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 360px; font-family: Tahoma; letter-spacing: 0px;
                        font-size: 11px; font-weight: bold;">
                        Includes Horse/Pet Portrait and action with horse or pet</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft">
                        1/2 Hour Session - Portrait</div>
                    <div class="pright">
                        $80.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft">
                        1/2 Hour Session -
                    </div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        Action with horse or pet</div>
                    <div class="pright">
                        $80.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft">
                        CD containing session photos</div>
                    <div class="pright">
                        $20.00</div>
                    <div style="clear: both; background-color: Blue;">
                    </div>
                    <!--</div>-->
                    <div class="pleft">
                        Prints</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        4X6</div>
                    <div class="pright" style="float: left; margin-right: 40px;">
                        $10.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        5X7</div>
                    <div class="pright" style="float: left; margin-right: 40px;">
                        $15.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        8X10</div>
                    <div class="pright" style="float: left; margin-right: 40px;">
                        $20.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft">
                        Larger prints available upon request</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="margin-top: 10px;">
                        Print Service</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        Dry mount</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        5X7</div>
                    <div class="pright" style="float: left; margin-right: 40px;">
                        $5.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        8X10</div>
                    <div class="pright" style="float: left; margin-right: 40px;">
                        $10.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px; margin-top: 15px;">
                        Mat ( single white Mat )
                    </div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        5X7 (11X14 external)</div>
                    <div class="pright" style="float: left; margin-right: 40px;">
                        $10.00</div>
                    <div style="clear: both;">
                    </div>
                    <div class="pleft" style="width: 200px; margin-left: 60px;">
                        8X10 (16X20 external)</div>
                    <div class="pright" style="float: left; margin-right: 40px;">
                        $20.00</div>
                    <div style="clear: both;">
                    </div>
                </div>
                <!--<img height="370" src="Images/PriceList_1.jpg" width="370" border="0" />-->
                <div class="Paragraph">
                    Additional print services available on request. Sessions can be on location at your
                    home or ranch.
                </div>
                <div class="Paragraph">
                    Travel charges may apply outside of Southern California.
                </div>
            </div>
            <div id="right">
                <br />
                <br />
                <img height="336" src="images/c-Show Jumping 2 179_resize.jpg" width="224" border="0" /><br />
            </div>
            <div style="clear: both">
            </div>
        </div>
    </div>
    <p align="center">
        <font color="#ffffff">Copyright © DxD Photography. All rights reserved.</font></p>
    </form>
</body>
</html>
