IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'mlb_Update_ticsellagt')
	BEGIN
		DROP  Procedure  mlb_Update_ticsellagt
	END

GO

CREATE Procedure mlb_Update_ticsellagt
@Id int,
@ticsellagt nvarchar(6)
AS

UPDATE mlbtable SET ticsellagt = @ticsellagt WHERE [Id] =@Id;

GO