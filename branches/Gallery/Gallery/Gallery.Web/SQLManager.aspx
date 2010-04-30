<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SQLManager.aspx.cs" Inherits="Gallery.Web.SQLManager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
    function createDbSchema() {
         return confirm("Are you sure to build the database again, this will result all exist data lost!");
    }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Button runat="server" Text="Test Connection" onclick="Unnamed1_Click" />
    <asp:Label runat="server" ID="Info"></asp:Label>
    
    <br />
    <asp:TextBox ID="DBSchema" runat="server" TextMode="MultiLine" Width="700px" Height="250px">
if   object_id('TPhotos','u') is not null 
	DROP TABLE TPhotos
	
if   object_id('TGallery','u') is not null 	
DROP TABLE TGallery

CREATE TABLE [dbo].[TGallery](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GalleryName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Show] [int] NOT NULL CONSTRAINT [DF_TGallery_Show]  DEFAULT ((0)),
 CONSTRAINT [PK_TGallery] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[TPhotos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ThumbName] [varchar](100) COLLATE Chinese_PRC_CI_AS NULL,
	[PhotoName] [varchar](100) COLLATE Chinese_PRC_CI_AS NULL,
	[OrderIndex] [int] NOT NULL CONSTRAINT [DF_TPhotos_OrderIndex]  DEFAULT ((0)),
	[GalleryId] [int] NOT NULL,
 CONSTRAINT [PK_TPhotos] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[TPhotos]  WITH CHECK ADD  CONSTRAINT [FK_TPhotos_TGallery] FOREIGN KEY([GalleryId])
REFERENCES [dbo].[TGallery] ([ID])


INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Equine Portraits',1)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Pet Portraits',1)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Event Photography',1)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Gallery 1',0)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Gallery 2',0)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Gallery 3',0)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Gallery 4',0)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Gallery 5',0)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Gallery  6',0)
INSERT INTO TGallery ( GalleryName, Show ) VALUES ('Gallery 7',0)
    </asp:TextBox>
    <asp:Button ID="btnCreateDb" runat="server" Text="Create" 
            onclick="btnCreateDb_Click" OnClientClick="return createDbSchema();" />
            
            <asp:TextBox ID="tbSQL" runat="server" Width="800px" Height="80px" TextMode="MultiLine"></asp:TextBox>
            <asp:Button ID="btnRun" runat="server" Text="Execute" OnClick="btnRun_Click" />
            <asp:Button ID="btnGenereateGridView" runat="server" Text="Genereate Grid View" OnClick="btnGenereateGridView_Click" />
            <asp:GridView ID="gv" runat="server" AutoGenerateColumns="true" ></asp:GridView>
    </div>
    </form>
</body>
</html>
