WITH  tabYNTPEK AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTPEK' GROUP BY ticsellagt),

tabYNTSHA  AS 
 (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSHA' GROUP BY ticsellagt),
 
tabYNTHRB AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTHRB' GROUP BY ticsellagt) ,

 tabYNTTNA AS
 (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTTNA' GROUP BY ticsellagt) ,

tabYNTCAN AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTCAN' GROUP BY ticsellagt) ,

tabYNTSZX AS
 (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSZX' GROUP BY ticsellagt) ,
 
 tabYNTSHE AS
 (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSHE' GROUP BY ticsellagt) ,
 
 tabYNTYNJ AS
 (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTYNJ' GROUP BY ticsellagt) ,
 
tabYNTICN AS 
 (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTICN' GROUP BY ticsellagt) 
 
SELECT DISTINCT mlbtable.ticsellagt AS 代理人, 
tabYNTPEK.cnt AS 烟台北京, 
tabYNTSHA.cnt AS 烟台上海, 
tabYNTHRB.cnt AS 烟台哈尔滨, 
tabYNTTNA.cnt AS 烟台济南, 
tabYNTCAN.cnt AS 烟台广州, 
tabYNTSZX.cnt AS 烟台深圳, 
tabYNTSHE.cnt AS 烟台沈阳,
tabYNTYNJ.cnt AS 烟台延吉, 
tabYNTICN.cnt AS 烟台汉城 FROM mlbtable
LEFT JOIN  tabYNTPEK ON (tabYNTPEK.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN   tabYNTSHA ON(tabYNTSHA.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabYNTHRB ON(tabYNTHRB.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN  tabYNTTNA ON(tabYNTTNA.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN  tabYNTCAN ON(tabYNTCAN.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN   tabYNTSZX ON(tabYNTSZX.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN  tabYNTSHE ON(tabYNTSHE.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN  tabYNTYNJ ON(tabYNTYNJ.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN  tabYNTICN ON(tabYNTICN.ticsellagt = mlbtable.ticsellagt) 
WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
