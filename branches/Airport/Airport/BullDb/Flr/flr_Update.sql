IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'flr_Update')
	BEGIN
		DROP  Procedure  flr_Update
	END

GO

CREATE Procedure flr_Update
@Id int,
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
@flrlf int
AS
UPDATE flrtable SET flightdate= @flightdate,
	flighttime = @flighttime,
	flightcode = @flightcode,
	fltsegment = @fltsegment,
	flrtype = @flrtype,
	flrrcnfrm = @flrrcnfrm,
	flrnrcfrm = @flrnrcfrm,
	flrnohost = @flrnohost, 
	flrconnect = @flrconnect,
	flrcnl = @flrcnl,
	flrcap = @flrcap,
	flrlf = @flrlf,
	flrreal = @flrnrcfrm + @flrrcnfrm
WHERE Id = @Id
                                

GO