IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'flr_GetId')
	BEGIN
		DROP  Procedure  flr_GetId
	END

GO

CREATE Procedure flr_GetId
@fltsegment nvarchar(50),
@flightcode nvarchar(50),
@flighttime nvarchar(50),
@flightdate nvarchar(50)
AS

SELECT Id FROM flrtable WHERE fltsegment = @fltsegment
	AND flightcode = @flightcode
	AND flighttime = @flighttime 
	AND flightdate = @flightdate;

GO

