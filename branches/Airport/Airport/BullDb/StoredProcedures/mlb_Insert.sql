IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'mlb_Insert')
	BEGIN
		DROP  Procedure  mlb_Insert
	END

GO

CREATE Procedure mlb_Insert

@flightdate nvarchar(50),
@flightcode nvarchar(50),
@fltsegment nvarchar(50), 
@ticketName nvarchar(50), 
@ticketseat nvarchar(50), 
@ticketcode nvarchar(50), 
@ticketstat nvarchar(50), 
@ticbuydate nvarchar(50), 
@ticsellagt nvarchar(50)
AS
INSERT INTO mlbtable (
flightdate,     flightcode,    fltsegment,    ticketname,     ticketseat,    ticketcode,    ticketstat,     ticbuydate,    ticsellagt) VALUES (
@flightdate ,@flightcode ,@fltsegment, @ticketName, @ticketseat, @ticketcode, @ticketstat, @ticbuydate, @ticsellagt );


GO



