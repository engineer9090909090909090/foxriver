IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'mlb_GetYearList')
	BEGIN
		DROP  Procedure  mlb_GetYearList
	END

GO

CREATE Procedure mlb_GetYearList
AS

select distinct year(_flight_date)  as [year] from mlbtable

GO


