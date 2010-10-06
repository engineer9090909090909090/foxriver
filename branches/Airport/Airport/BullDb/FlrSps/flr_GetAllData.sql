IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'flr_GetAllData')
	BEGIN
		DROP  Procedure  flr_GetAllData
	END

GO

CREATE Procedure flr_GetAllData
@total int OUTPUT,
@pageSize int,
@currentPage int,

@flightDateBegin dateTime,
@flightDateEnd datetime
AS

SELECT @total = COUNT(*) FROM flrtable WHERE  flightdate >= @flightDateBegin AND flightdate <= @flightDateEnd

SELECT row_index as [序号],
	flightdate as 航班日期, 
	fltsegment as 航程, 
	flightcode as 航班号, 
	flighttime as 航班时刻, 
	flrtype as 机型, 
	flrreal as 实际人数, 
	flrcap as 座位配置, 
	flrlf as 乘坐率
 FROM
	(
	SELECT *, ROW_NUMBER() over (order by [id] ASC) AS row_index  FROM flrtable WHERE flightdate >= @flightDateBegin AND flightdate <= @flightDateEnd
	) AS NEW_TABLE
WHERE row_index between (@currentPage - 1 ) * @pageSize and @currentPage * @pageSize
GO