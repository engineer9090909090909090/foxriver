 WITH tabPEKYNT AS
  (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'PEKYNT' GROUP BY ticsellagt) 
 
 , tabSHAYNT AS
  (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHAYNT' GROUP BY ticsellagt)
  
 , tabHRBYNT AS
   (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'HRBYNT' GROUP BY ticsellagt)
   
 , tabTNAYNT AS
    (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAYNT' GROUP BY ticsellagt) 
   
 , tabCANYNT AS
    (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'CANYNT' GROUP BY ticsellagt) 
   
 , tabSZXYNT AS
    (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SZXYNT' GROUP BY ticsellagt) 
   
 , tabSHEYNT AS 
    (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHEYNT' GROUP BY ticsellagt) 
   
   
 , tabYNJYNT AS
    (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNJYNT' GROUP BY ticsellagt) 
   
 , tabICNYNT AS
    (SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'ICNYNT' GROUP BY ticsellagt) 


SELECT DISTINCT mlbtable.ticsellagt AS 代理人,
 tabPEKYNT.cnt AS 北京烟台,
  tabSHAYNT.cnt AS 上海烟台,
 tabHRBYNT.cnt AS 哈尔滨烟台, 
 tabTNAYNT.cnt AS 济南烟台, 
 tabCANYNT.cnt AS 广州烟台, 
 tabSZXYNT.cnt AS 深圳烟台,
  tabSHEYNT.cnt AS 沈阳烟台, 
  tabYNJYNT.cnt AS 延吉烟台, 
  tabICNYNT.cnt AS 汉城烟台 
 FROM mlbtable
 LEFT JOIN   tabPEKYNT ON(tabPEKYNT.ticsellagt = mlbtable.ticsellagt)
 
 LEFT JOIN   tabSHAYNT ON(tabSHAYNT.ticsellagt = mlbtable.ticsellagt)
  
  LEFT JOIN     tabHRBYNT ON(tabHRBYNT.ticsellagt = mlbtable.ticsellagt)
   
   LEFT JOIN   tabTNAYNT ON(tabTNAYNT.ticsellagt = mlbtable.ticsellagt)
   
   LEFT JOIN  tabCANYNT ON(tabCANYNT.ticsellagt = mlbtable.ticsellagt)
   
   LEFT JOIN   tabSZXYNT ON(tabSZXYNT.ticsellagt = mlbtable.ticsellagt)
   
   LEFT JOIN   tabSHEYNT ON(tabSHEYNT.ticsellagt = mlbtable.ticsellagt)
   
   LEFT JOIN  tabYNJYNT ON(tabYNJYNT.ticsellagt = mlbtable.ticsellagt)
   
   LEFT JOIN  tabICNYNT ON(tabICNYNT.ticsellagt = mlbtable.ticsellagt) 
   
   WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
