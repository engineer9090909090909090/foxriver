IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'mlb_GetAllData')
	BEGIN
		DROP  Procedure  mlb_GetAllData
	END

GO

CREATE Procedure mlb_GetAllData

@total int OUTPUT,
@pageSize int,
@currentPage
AS

--SELECT@total= COUNT(*) FROM mlbtable;
select * from mlbtable


--SELECT * FROM
	--( SELECT *, ROW_NUMBER() over (order by [id] ASC) AS row_index ) FROM mlbtable ) AS NEW_TABLE
--WHERE row_index between (@currentPage - 1 ) * @pageSize and @currentPage * @pageSize

GO


