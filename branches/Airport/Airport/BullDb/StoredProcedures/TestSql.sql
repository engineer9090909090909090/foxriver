WITH
tabWEHPEK AS
(SELECT ticsellagt, COUNT(*) AS [cnt] FROM mlbtable WHERE fltsegment = 'WEHPEK' GROUP BY ticsellagt)
,
tabWEHSHA AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHSHA' GROUP BY ticsellagt)
,
tabWEHCAN AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHCAN' GROUP BY ticsellagt) 
,
tabWEHHRB AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHHRB' GROUP BY ticsellagt)
,
tabWEHTNA AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHTNA' GROUP BY ticsellagt)
,
tabWEHTYN AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHTYN' GROUP BY ticsellagt) 
,
tabWEHICN AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHICN' GROUP BY ticsellagt) 


SELECT DISTINCT mlbtable.ticsellagt AS [代理人], 
	[tabWEHPEK].[cnt] AS [威海北京], 
	tabWEHSHA.cnt AS 威海上海, 
	tabWEHCAN.cnt AS 威海广州, 
	tabWEHHRB.cnt AS 威海哈尔滨, 
	tabWEHTNA.cnt AS 威海济南, 
	tabWEHTYN.cnt AS 威海太原, 
	tabWEHICN.cnt AS 威海汉城 FROM mlbtable
LEFT JOIN tabWEHPEK ON (tabWEHPEK.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabWEHSHA ON (tabWEHSHA.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabWEHCAN ON (tabWEHCAN.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabWEHHRB ON (tabWEHHRB.ticsellagt = mlbtable.ticsellagt) 
LEFT JOIN tabWEHTNA ON (tabWEHTNA.ticsellagt = mlbtable.ticsellagt) 
LEFT JOIN tabWEHTYN ON (tabWEHTYN.ticsellagt = mlbtable.ticsellagt) 
LEFT JOIN tabWEHICN ON (tabWEHICN.ticsellagt = mlbtable.ticsellagt)
WHERE  mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
--)

--select * from Result
/*
select * from tabWEHICN


SELECT DISTINCT mlbtable.ticsellagt AS 代理人, 

	tabWEHPEK.cnt AS 威海北京, 
	tabWEHSHA.cnt AS 威海上海, 
	tabWEHCAN.cnt AS 威海广州, 
	tabWEHHRB.cnt AS 威海哈尔滨, 
	tabWEHTNA.cnt AS 威海济南, 
	tabWEHTYN.cnt AS 威海太原, 
	tabWEHICN.cnt AS 威海汉城 FROM 
(
(
((((

(mlbtable) LEFT JOIN tabWEHPEK
 
  ON(tabWEHPEK.ticsellagt = mlbtable.ticsellagt)) 
  
  LEFT JOIN  tabWEHSHA  ON(tabWEHSHA.ticsellagt = mlbtable.ticsellagt)) 
  LEFT JOIN   tabWEHCAN)  ON(tabWEHCAN.ticsellagt = mlbtable.ticsellagt)) 
  LEFT JOIN   tabWEHHRB  ON(tabWEHHRB.ticsellagt = mlbtable.ticsellagt)) 
  LEFT JOIN  tabWEHTNA  ON(tabWEHTNA.ticsellagt = mlbtable.ticsellagt)) 
  LEFT JOIN   tabWEHTYN  ON(tabWEHTYN.ticsellagt = mlbtable.ticsellagt)) 
  LEFT JOIN   tabWEHICN   ON(tabWEHICN.ticsellagt = mlbtable.ticsellagt) 
  
  WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
  */