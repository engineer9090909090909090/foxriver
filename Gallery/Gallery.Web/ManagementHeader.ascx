<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManagementHeader.ascx.cs"
    Inherits="Gallery.Web.ManagementHeader" %>
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
    .win
    {
        border: solid 2px #649fe5;
        position: absolute;
        left: 150px;
        top: 40px;
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
    .MenuUl
    {
        background-color: #000000;
        width: 711px;
        border: 3px solid #FFFFFF;
        display: block;
        top: 0px;
        position: absolute;
        margin: 0px 0px 0px 0px;
        height: 22px;
        padding: 5px 0px 0px 0px;
    }
    .MenuUl li
    {
        display: inline;
    }
    .MenuUl li a
    {
        text-decoration: none;
        color: #FFFFFF;
        margin: 0px 15px;
        font-family: Verdana;
        font-size: 14px;
    }
    .MenuUl li a:hover
    {
        text-decoration: underline;
        color: #28556b;
    }
</style>
<ul class="MenuUl">
    <li><a href="GalleryManager.aspx">Gallery Management</a></li>
    <li><a href="PriceSettings.aspx">Price Setttings</a></li>
    <li><a href="ClientManagement.aspx">Client Management</a></li>
</ul>
