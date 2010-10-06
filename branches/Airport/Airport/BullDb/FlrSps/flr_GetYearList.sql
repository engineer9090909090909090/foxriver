IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'flr_GetYearList')
	BEGIN
		DROP  Procedure  flr_GetYearList
	END

GO

CREATE Procedure flr_GetYearList
AS

select distinct year(_flight_date) as [year] from flrtable

GO


