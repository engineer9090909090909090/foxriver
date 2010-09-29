WITH tabCA1828 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1828' GROUP BY ticsellagt) 

, tabCA1588  AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1588' GROUP BY ticsellagt) 

, tabFM9258  AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9258' GROUP BY ticsellagt) 

, tabMU2288  AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode ='MU2288' GROUP BY ticsellagt) 

, tabCZ3788  AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHCAN' and flightcode = 'CZ3788' GROUP BY ticsellagt) 

, tabCZ3787  AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHHRB' and flightcode = 'CZ3787' GROUP BY ticsellagt) 

, tabWEHTYN  AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHTYN' and flightcode = 'HU7590' GROUP BY ticsellagt) 

,tabWEHTNA   AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHTNA' GROUP BY ticsellagt) 

,  tabCA147 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA147' GROUP BY ticsellagt) 

,  tabMU2017 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2017'GROUP BY ticsellagt) 


SELECT DISTINCT mlbtable.ticsellagt AS 代理人, 
tabCA1828.cnt AS CA1828, 
tabCA1588.cnt AS CA1588,
tabFM9258.cnt AS FM9258, 
tabMU2288.cnt AS MU2288, 
tabCZ3788.cnt AS CZ3788wehcan, 
tabCZ3787.cnt AS CZ3787wehhrb, 
tabWEHTYN.cnt AS HU7590wehtyn, 
tabWEHTNA.cnt AS HU7590wehtna, 
tabCA147.cnt AS CA147, 
tabMU2017.cnt AS MU2017 
FROM mlbtable 
LEFT JOIN  tabCA1828 ON(tabCA1828.ticsellagt =mlbtable.ticsellagt)

LEFT JOIN  tabCA1588 ON(tabCA1588.ticsellagt = mlbtable.ticsellagt)

LEFT JOIN  tabFM9258 ON(tabFM9258.ticsellagt = mlbtable.ticsellagt)

LEFT JOIN  tabMU2288 ON(tabMU2288.ticsellagt = mlbtable.ticsellagt)

LEFT JOIN  tabCZ3788 ON(tabCZ3788.ticsellagt = mlbtable.ticsellagt)

LEFT JOIN  tabCZ3787 ON(tabCZ3787.ticsellagt = mlbtable.ticsellagt)

LEFT JOIN  tabWEHTYN ON(tabWEHTYN.ticsellagt = mlbtable.ticsellagt)

LEFT JOIN  tabWEHTNA ON(tabWEHTNA.ticsellagt=mlbtable.ticsellagt)

LEFT JOIN  tabCA147 ON(tabCA147.ticsellagt = mlbtable.ticsellagt)

LEFT JOIN  tabMU2017 ON(tabMU2017.ticsellagt = mlbtable.ticsellagt) 

WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
