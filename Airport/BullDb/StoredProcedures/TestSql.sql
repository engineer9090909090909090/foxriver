WITH  tabCA1827 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1827' GROUP BY ticsellagt)
, tabCA1587 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1587' GROUP BY ticsellagt)
, tabFM9257 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9257' GROUP BY ticsellagt)
, tabMU2287 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode ='MU2287' GROUP BY ticsellagt)
, tabCZ3787 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' and fltsegment = 'CANWEH' GROUP BY ticsellagt)
, tabCZ3788 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' and fltsegment = 'HRBWEH' GROUP BY ticsellagt)
, tabTYNWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TYNWEH' and flightcode = 'HU7589'GROUP BY ticsellagt)
, tabTNAWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAWEH' and flightcode = 'HU7589'GROUP BY ticsellagt)
, tabCA148 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA148' GROUP BY ticsellagt)
, tabMU2018 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2018' GROUP BY ticsellagt)

SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1827.cnt AS CA1827, tabCA1587.cnt AS CA1587,tabFM9257.cnt AS FM9257, tabMU2287.cnt AS MU2287, tabCZ3787.cnt AS CZ3787canweh, tabCZ3788.cnt AS CZ3788hrbweh, tabTYNWEH.cnt AS HU7589tynweh, tabTNAWEH.cnt AS HU7589tnaweh, tabCA148.cnt AS CA148, tabMU2018.cnt AS MU2018 FROM mlbtable  
LEFT JOIN  tabCA1827 ON (tabCA1827.ticsellagt =mlbtable.ticsellagt )
LEFT JOIN  tabCA1587 ON (tabCA1587.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabFM9257 ON (tabFM9257.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU2287 ON (tabMU2287.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCZ3787 ON (tabCZ3787.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCZ3788 ON (tabCZ3788.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabTYNWEH ON (tabTYNWEH.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabTNAWEH ON (tabTNAWEH.ticsellagt =mlbtable.ticsellagt )
LEFT JOIN  tabCA148 ON (tabCA148.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU2018 ON (tabMU2018.ticsellagt = mlbtable.ticsellagt )
WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
