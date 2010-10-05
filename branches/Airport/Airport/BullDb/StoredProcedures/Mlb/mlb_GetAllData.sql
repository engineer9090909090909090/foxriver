IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'mlb_GetAllData')
	BEGIN
		DROP  Procedure  mlb_GetAllData
	END

GO

CREATE Procedure mlb_GetAllData

@total int OUTPUT,
@pageSize int,
@currentPage int,

@flightDateBegin dateTime,
@flightDateEnd datetime
AS

SELECT @total = COUNT(*) FROM mlbtable WHERE  flightdate >= @flightDateBegin AND flightdate <= @flightDateEnd;


SELECT row_index as [序号],
	flightdate as 班期,
	_flight_date as FlightDate,
	fltsegment as 航程, 
	flightcode as 航班号, 
	ticketname as 旅客姓名, 
	-- ticketcls as 舱位,[there is no this field]
	ticketseat as 舱位,
	ticketcode as 记录编号,
	ticketstat as 确认记录,
	ticbuydate as 购票日期,
	
	ticsellagt as 代理人  FROM
	( 
		SELECT *, ROW_NUMBER() over (order by [id] ASC) AS row_index  FROM mlbtable WHERE _flight_date >= @flightDateBegin AND _flight_date <= @flightDateEnd
	) AS NEW_TABLE
WHERE row_index between (@currentPage - 1 ) * @pageSize and @currentPage * @pageSize

GO


