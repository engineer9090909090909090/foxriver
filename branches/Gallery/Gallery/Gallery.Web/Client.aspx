<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Client.aspx.cs" Inherits="Gallery.Web.Client" %>

<%@ Register TagName="Header" TagPrefix="Gallery" Src="~/SiteHeader.ascx" %>
<%@ Register TagName="Player" TagPrefix="Gallery" Src="~/GalleryControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DxD Photography - Specializing in Equine Photography</title>
    <meta name="keywords" content="Equine photography, Pet photography, Pet portraits" />
    <link href="Style.css" type="text/css" rel="Stylesheet" />
    <style type="text/css">
        .content
        {
            width: 717px;
            text-align: center;
            margin: 0 auto;
        }
        .img_div
        {
            width: 289;
            text-align: center;
            margin: 30 auto;
            border: solid 2px lightgreen;
        }
        .input_div
        {
            float: left;
            color: #ffffff;
            font-family: Verdana;
            margin-right: 10px;
            height: 25px;
            line-height: 25px;
        }
        .input_div a
        {
            color: #ffffff;
            text-decoration: none;
        }
        .input_div a:hover
        {
            text-decoration: underline;
        }
    </style>

    <script language="javascript" type="text/javascript">
    function sendPassword() {
        var pwd = $('#ClientPwd').attr('value');
        if ($.trim(pwd).length == 0 ) {
            alert ( "Please enter password!");
            return;
        }
        
        _postJSON({'method':'GetPhotosFromClient'}, {'password':$.trim(pwd)}, function (data) {
            _IsRequesting = false;
            //alert(data.msgId);
            if ( data.msgId || data.data.length == 0 ) {
                return;
            }
            photoList = data.data;
            description = data.message;
            $des.text(description)
                .fadeIn('slow');
            $('#passwordContainer').fadeOut('slow', function() {
                $('#playerContainer').fadeIn('fast');
            });
            Gallery_Init();
            Play();
        });
    };
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <Gallery:Header runat="server" />
    <div id="playerContainer" style="display: none;">
        <Gallery:Player runat="server" />
    </div>
    <div id="passwordContainer" class="content" style="width: 350px;">
        <div style="margin-top: 20px;">
        </div>
        <img src="images/homepage.jpg" class="img_div" alt="Please enter password" />
        <div style="margin-top: 20px;">
            <div class="input_div">
                Enter password:
            </div>
            <div class="input_div">
                <input type="password" id="ClientPwd" /></div>
            <div class="input_div">
                <a href="javascript:void(0);" onclick="sendPassword();">Submit</a>
            </div>
            <div style="clear: both;">
            </div>
        </div>
    </div>
    <div class="Content">
        <p style="visibility: visible" align="center">
            &nbsp;<br />
            <font color="#ffffff">Copyright © DxD Photography. All rights reserved.</font></p>
    </div>
    </form>
</body>
</html>
