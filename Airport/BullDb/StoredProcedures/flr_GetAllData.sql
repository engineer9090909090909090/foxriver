IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'flr_GetAllData')
	BEGIN
		DROP  Procedure  flr_GetAllData
	END

GO

CREATE Procedure flr_GetAllData
@total int OUTPUT,
@pageSize int,
@currentPage int
AS

SELECT @total = COUNT(*) FROM flrtable;

SELECT * FROM
	( SELECT *, ROW_NUMBER() over (order by [id] ASC) AS row_index  FROM flrtable ) AS NEW_TABLE
WHERE row_index between (@currentPage - 1 ) * @pageSize and @currentPage * @pageSize
GO