-- Used for Update Table

-- Add Width & Height for TPhotos
alter Table [TPhotos] add [Width] INT DEFAULT 558 NOT NULL
alter Table [TPhotos] add [Height] INT DEFAULT 558 NOT NULL

alter Table [TGallery] add [Description] nvarchar(250) NULL