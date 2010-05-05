<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GalleryControl.ascx.cs"
    Inherits="Gallery.Web.GalleryControl" %>
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

<div id="divDescription" style="display: none; width: 717px; text-align: left; margin: 0 auto;
    color: #ffffff; font-weight: bold;">
</div>
<div id="content" style="width: 717px; text-align: center; margin: 0 auto;">
    <div id="cp" style="width: 148px; border: solid 1px silver; height: 440px; float: left;
        margin-top: 5px;">
        <div id="cpTop">
            <a href="javascript:void(0);" title="Play" onclick="Play();">►</a> <a href="javascript:void(0);"
                title="Stop" onclick="Stop();">◙ </a>
        </div>
        <div id="outerContainer">
            <div id="Slide">
            </div>
        </div>
        <div id="cpBottom">
            <a href="javascript:void(0);" onclick="Up();" title="Page Up">▲</a> <a href="javascript:void(0);"
                onclick="Down();" title="Page Down">▼</a>
        </div>
    </div>
    <div style="float: left; margin-left: 5px; width: 558px; margin-top: 5px; height: 558px;
        border: solid 2px silver;" id="imgHolder">
    </div>
    <div style="clear: both;">
    </div>
    <%--<p style="visibility: visible" align="center">
        &nbsp;<br />
        <font color="#ffffff">Copyright © DxD Photography. All rights reserved.</font></p>--%>
</div>

<script language="javascript" type="text/javascript">
    var photoList = <%= Photos %>;
    var description = "<%= Description %>";
</script>
<script language="javascript" src="scripts/gallery.js" type="text/javascript"></script>
