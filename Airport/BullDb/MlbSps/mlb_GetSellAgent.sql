IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'mlb_GetSellAgent')
	BEGIN
		DROP  Procedure  mlb_GetSellAgent
	END

GO

CREATE Procedure mlb_GetSellAgent

	@ticketName nvarchar(15),
	@ticketcode nvarchar(5),
	@flightdate nvarchar(50),
	@flightcode nvarchar(5)
AS
SELECT Id, ticsellagt FROM mlbtable WHERE ticketname LIKE  @ticketName + '%'
	AND ticketcode = @ticketcode
	AND flightdate = @flightdate
	AND flightcode = @flightcode;


GO