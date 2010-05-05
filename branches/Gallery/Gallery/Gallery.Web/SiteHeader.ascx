<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SiteHeader.ascx.cs"
    Inherits="Gallery.Web.SiteHeader" %>


<script language="javascript" src="scripts/jquery-1.4.1.min.js" type="text/javascript"></script>

<script language="javascript" src="scripts/index.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
$(document).ready(function(){
    ProcessGalleryList(<%= GalleryList %>);
});
</script>

<div id="container">
    <div id="header">
        <div id="header_text">
            <p>
                &nbsp;</p>
        </div>
        <ul id="Menu">
        </ul>
    </div>
</div>
