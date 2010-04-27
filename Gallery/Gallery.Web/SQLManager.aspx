<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SQLManager.aspx.cs" Inherits="Gallery.Web.SQLManager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Button runat="server" Text="Test Connection" onclick="Unnamed1_Click" />
    <asp:Label runat="server" ID="Info"></asp:Label>
    
    <br />
    <asp:TextBox ID="DBSchema" runat="server" TextMode="MultiLine">
    INSERT INTO TGallery ( GalleryName ) VALUES ('Equine Portraits')
INSERT INTO TGallery ( GalleryName ) VALUES ('Pet Portraits')
INSERT INTO TGallery ( GalleryName ) VALUES ('Event Photography')
INSERT INTO TGallery ( GalleryName ) VALUES ('Gallery 1')
INSERT INTO TGallery ( GalleryName ) VALUES ('Gallery 2')
INSERT INTO TGallery ( GalleryName ) VALUES ('Gallery 3')
INSERT INTO TGallery ( GalleryName ) VALUES ('Gallery 4')
INSERT INTO TGallery ( GalleryName ) VALUES ('Gallery 5')
INSERT INTO TGallery ( GalleryName ) VALUES ('Gallery  6')
INSERT INTO TGallery ( GalleryName ) VALUES ('Gallery 7')
    </asp:TextBox>
    <asp:Button ID="btnCreateDb" runat="server" Text="Create" 
            onclick="btnCreateDb_Click" />
    </div>
    </form>
</body>
</html>
