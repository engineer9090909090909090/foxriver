IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'flr_Insert')
	BEGIN
		DROP  Procedure  flr_Insert
	END

GO

CREATE Procedure flr_Insert

@flightdate nvarchar(50),
@flighttime nvarchar(50), 
@flightcode nvarchar(50), 
@fltsegment nvarchar(50), 
@flrtype nvarchar(50), 
@flrrcnfrm int, 
@flrnrcfrm int, 
@flrnohost int, 
@flrconnect int, 
@flrcnl int, 
@flrcap int, 
@flrlf int,
@_flight_date datetime

AS

INSERT INTO flrtable (flightdate,    flighttime,    flightcode,     fltsegment,    flrtype,    flrrcnfrm,     flrnrcfrm,    flrnohost,    flrconnect,     flrcnl,    flrcap,     flrlf,    flrreal, _flight_date) VALUES (
                                 @flightdate, @flighttime, @flightcode, @fltsegment, @flrtype, @flrrcnfrm, @flrnrcfrm, @flrnohost, @flrconnect, @flrcnl, @flrcap, @flrlf, @flrrcnfrm + @flrnrcfrm, @_flight_date)
GO

