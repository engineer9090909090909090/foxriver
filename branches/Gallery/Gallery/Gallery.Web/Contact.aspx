﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Gallery.Web.Contact" %>

<%@ Register TagName="Header" TagPrefix="Gallery" Src="~/SiteHeader.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>DxD Photography - Specializing in Equine Photography</title>
    <meta name="keywords" content="Equine photography, Pet photography, Pet portraits" />
    <link href="Style.css" type="text/css" rel="Stylesheet" />
    
    <style type="text/css">
        .left_cell
        {
            float: left;
            width: 100px;
            height: 24px;
            line-height: 24px;
            text-align: right;
            margin-right: 5px;
            font-size: 14px;
        }
        .right_cell
        {
            float: left;
            width: 300px;
            height: 24px;
            line-height: 24px;
        }
        input
        {
            width: 240px;
        }
        div
        {
            font-family: Verdana;
            font-size: 14px;
        }
        .signup_button
        {
            background-attachment: scroll;
            background-repeat: repeat-x;
            background-position: 0px -555px;
            background-color: #79bb16;
            border: solid 1px #6699cc;
            color: #ffffff;
            font-weight: 700;
            font-size: 120%;
            text-align: center;
            text-decoration: none;
            padding-top: 2px;
            padding-right: 16px;
            padding-bottom: 2px;
            padding-left: 16px;
            cursor: pointer;
            width: 140px;
        }
    </style>

    <script language="javascript" type="text/javascript">
    function singUp() {
        var firstName =$.trim( $('#tbFirstName').attr('value'));
        var lastName = $.trim($('#tbLastName').attr('value'));
        var email = $.trim($('#tbEmail').attr('value'));
        
        if ( firstName.length == 0 || lastName.length == 0 ) {
            alert("Please enter your fist name or last name!");
            return;
        }
        var emailTest = /^([\w]+)(.[\w]+)*@([\w-]+\.){1,5}([A-Za-z]){2,4}$/;
        if (!emailTest.test(email)) {
            alert( "Please enter correct email adderss");
            return;
        }
        
        var url = "admin.aspx?nothing=" + encodeURI( new Date().toString())
            +"&method=AddAccount&ajax=1";
        $.post(url,
            {'firstName':firstName,'lastName':lastName,'email':email},
            function(data) {
                if ( data.msgId< 0) {
                    alert(data.message);
                    return;
                } else {
                    $('#tbFirstName').attr('value','');
                    $('#tbLastName').attr('value','');
                    $('#tbEmail').attr('value','');
                    
                    alert("Thanks for your sign up!");
                }
            },'json');
    };
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <Gallery:Header ID="Header1" runat="server" />
    <div id="container">
        <div id="content">
            <div id="left" style="font-family: Verdana; color: #ffffff">
                <div style="font-family: Verdana; font-size: 14px;">
                    <div style="font-weight: bold; margin-top: 20px;">
                        Contact Us</div>
                    <div style="margin-top: 20px;">
                        Photographs by Donna Delikat</div>
                    <div style="text-decoration: underline;">
                        858.336.6016</div>
                    <div style="margin-top: 20px;">
                        Contact: <a href="mailto:Donna@DxDPhotography.com" style="color: #ffffff;">donna@dxdphotography.com</a>
                    </div>
                    <div style="margin-top: 20px; font-weight: bold;">
                        Call or Email for an Appointment
                    </div>
                </div>
                <div style="width: 420px; margin: 30px auto; font-family: Verdana; color: #ffffff;">
                    <div style="font-size: 14px; font-weight: bold;margin-bottom:5px;">
                        Sign up for Newsletters and Price Specials</div>
                    <div>
                        <div class="left_cell">
                            First Name:</div>
                        <div class="right_cell">
                            <input id="tbFirstName" />
                        </div>
                        <div style="clear: both;">
                        </div>
                        <div class="left_cell">
                            Last Name:</div>
                        <div class="right_cell">
                            <input id="tbLastName" />
                        </div>
                        <div style="clear: both;">
                        </div>
                        <div class="left_cell">
                            Email:</div>
                        <div class="right_cell">
                            <input id="tbEmail" />
                        </div>
                        <div style="clear: both;">
                        </div>
                    </div>
                    <div style="width: 100%; text-align: center; margin-top: 10px;">
                        <input type="button" value="Sign Up Now" class="signup_button" onclick="singUp();" />
                    </div>
                </div>
            </div>
            <div id="right">
                <p>
                    <br />
                    <img height="336" src="images/c-IMG_0164_resize.jpg" width="224" border="0" />
                </p>
            </div>
            <div style="clear: both;">
            </div>
        </div>
        <div id="footer">
            <p align="center">
                <font color="#ffffff">Copyright © DxD Photography. All rights reserved.</font></p>
        </div>
    </div>
    </form>
</body>
</html>
