-- Used for Config Table
CREATE TABLE [dbo].[TConfig](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Value] [nvarchar](1000) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_TConfig] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

INSERT [TConfig] ([Key],[Value]) VALUES ( 'PRICE', '');
-- NEED To RUN ON Production