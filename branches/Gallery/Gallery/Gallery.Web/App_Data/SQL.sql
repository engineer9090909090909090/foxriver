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