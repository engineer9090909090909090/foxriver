-- Used for Account Table
CREATE TABLE [dbo].[TAccount](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[LastName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Email] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Password] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_TAccount] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[TAccount_Mail_History] (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] INT NOT NULL,
	[SendDate] [DateTime] NULL,
	[Password] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[GalleryName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL
CONSTRAINT [PK_TAccount_Mail_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

-- NEED To RUN ON Production