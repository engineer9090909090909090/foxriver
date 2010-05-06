<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GalleryManager.aspx.cs"
    Inherits="Gallery.Web._Default" %>

<%@ Register TagPrefix="Gallery" TagName="MH" Src="~/ManagementHeader.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gallery Management</title>
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
            top: 40px;
            width: 120px;
            height: 400px;
            border: solid 1px silver;
            font-size: 13pt;
            color: #fff;
        }
        #Menu div
        {
            width: 100px;
            margin-top: 10px;
            font-size: 10pt;
            color: #ffffff;
            cursor: pointer;
            font-weight: normal;
            margin-left: 15px;
        }
        .ContentItem
        {
            position: absolute;
            left: 2000px;
            top: 10px;
            width: 400px;
            height: 500px;
            overflow: hidden;
            display: none;
            color: #fff;
        }
        
        .table_header
        {
            width: 650px;
            border-bottom: solid 1px silver;
        }
        .window_content a
        {
            color: Blue;
            text-decoration: underline;
            margin-left: 20px;
        }
        .row
        {
            width: 650px;
            height: 50px;
            line-height: 50px;
            border-bottom: solid 1px silver;
            margin-top: 5px;
        }
        .thumb
        {
            width: 50px;
            height: 50px;
            line-height: 50px;
            float: left;
        }
        .photo
        {
            width: 400px;
            height: 50px;
            line-height: 50px;
            float: left;
            margin-left: 20px;
            border-left: solid 1px silver;
        }
        .Operation
        {
            margin-left: 5px;
            border-left: solid 1px silver;
            width: 130px;
            height: 50px;
            line-height: 50px;
            float: left;
        }
    </style>

    <script language="javascript" src="/scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

    <script language="javascript" src="/scripts/ajaxfileupload.js" type="text/javascript"></script>

    <script language="javascript" src="GalleryManagement.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
    var GalleryList = <%= Galleries %>;
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <Gallery:MH ID="MH1" runat="server" />
    <div id="Menu">
        <div style="text-decoration: underline; font-weight: bold; margin-left: 5px; font-size: 10pt;">
            Gallery List</div>
    </div>
    <div class="win" style="width: 700px;" id="phtoWin">
        <div class="window_header" style="width: 700px;">
            Gallery Maintainance
        </div>
        <div class="window_content" style="width: 700px; height: 600px;">
            <div class="table_header">
                <div style="float: left;">
                    <div>
                        <input type="text" value="" id="tbGalleryName" />
                        <input type="checkbox" id="cbxShow" />Show this gallery.
                    </div>
                    <div>
                        Comments</div>
                    <div>
                        <textarea style="width: 250px; height: 50px;" id="tbDescription"></textarea></div>
                </div>
                <div style="float: left; margin-top: 55px;">
                    <a href="javascript:void(0);" onclick="UpdateGallery();">Update</a></div>
                <div style="float: right; margin-top: 55px;">
                    <a href="javascript:void(0);" onclick="Add_Click();">Add Row</a> <a style="display: none;"
                        href="javascript:void(0);">Save Row's Order</a>
                </div>
                <div style="clear: both;">
                </div>
            </div>
            <div style="width: 700px; height: 578px; overflow: auto; background-color: #ffffff;"
                id="RowContainer">
            </div>
        </div>
    </div>
    <div class="row" id="TempRow" style="display: none">
        <div class="thumb">
            <img src="/images/defaultThumb.jpg" style="width: 50px; height: 50px;" />
        </div>
        <div class="photo">
            <div style="height: 25px; line-height: 25px;">
                <input type="file" name="s1" ptype="s1" />
                <a href="javascript:void(0);">Upload Thumbnail</a>
            </div>
            <div style="height: 25px; line-height: 25px;">
                <input type="file" name="s2" ptype="s2" />
                <a href="javascript:void(0);">Upload Photo</a>
            </div>
        </div>
        <div class="Operation">
            <a href="javascript:void(0);" style="margin-left: 5px;">Del</a> <a href="javascript:void(0);"
                style="margin-left: 5px; display: none;">Up</a> <a href="javascript:void(0);" style="display: none;
                    margin-left: 5px;">Down</a> <a href="javascript:void(0);" style="margin-left: 5px;">
                        View </a>
        </div>
        <div style="clear: both;">
        </div>
    </div>
    <img id="Loading" src="/images/loading.gif" style="position: absolute; left: 250px;
        top: 200px; display: none;" />
    </form>
</body>
</html>
