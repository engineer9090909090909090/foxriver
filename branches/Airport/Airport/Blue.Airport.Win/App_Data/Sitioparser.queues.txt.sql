--BEGIN显示MLB有效数据
SELECT flightdate as 班期,
	fltsegment as 航程, 
	flightcode as 航班号, 
	ticketname as 旅客姓名, 
	-- ticketcls as 舱位,[there is no this field]
	ticketcode as 记录编号,
	ticketstat as 确认记录,
	ticbuydate as 购票日期,
	ticsellagt as 代理人 FROM mlbtable
--END COMMAND


--BEGIN显示FLR有效数据
SELECT flightdate as 航班日期, 
	fltsegment as 航程, 
	flightcode as 航班号, 
	flighttime as 航班时刻, 
	flrtype as 机型, 
	flrreal as 实际人数, 
	flrcap as 座位配置, 
	flrlf as 乘坐率 FROM flrtable
--END COMMAND

--BEGIN查询特定单项
select * from mlbtable where ticketname = 'FEAS'
--END COMMAND

--BEGIN查询航班(航线)日(月)数据MLB
SELECT flightdate as 班期, fltsegment as 航程, flightcode as 航班号, ticketname as 旅客姓名,
--ticketcls as 舱位, [No such field]

ticketcode as 记录编号,ticketstat as 确认记录,ticbuydate as 购票日期,ticsellagt as 代理人 FROM mlbtable where fltsegment = 'WEHPEK'and flightcode = 'CA1828' and flightdate like '%%' and ticsellagt like 'weh%'
--END COMMAND

--BEGIN查询航班月(航线日)数据FLR
SELECT flightdate as 航班日期, fltsegment as 航程, flightcode as 航班号, flighttime as 航班时刻, flrtype as 机型, flrreal as 实际人数, flrcap as 座位配置, flrlf as 乘坐率 FROM flrtable where flightdate like '%%' and flightcode = 'ca1588' and fltsegment = 'WEHPEK' 
--END COMMAND

--BEGINMLB数据统计
/*
SELECT sum(人数) as 总人数, 
	avg(人数) as 平均值, 
	min(人数) as 最低, 
	max(人数) as 最高 
FROM (
	SELECT ticsellagt as 代理人, 
		count(*) as 人数 FROM mlbtable 
		where ticsellagt like 'weh%' 
			and fltsegment = 'WEHPEK'
			and flightcode = 'CA1828' 
			and ticbuydate like '%%' 
		--GROUP BY ticsellagt ORDER BY count(*) DESC
		GROUP BY ticsellagt
) --End FROM
*/
WITH basic AS 
(
	SELECT ticsellagt as 代理人, 
		count(*) as 人数 FROM mlbtable 
		where ticsellagt like 'weh%' 
			and fltsegment = 'WEHPEK'
			and flightcode = 'CA1828' 
			and ticbuydate like '%%' 
		--GROUP BY ticsellagt ORDER BY count(*) DESC
		GROUP BY ticsellagt
)

SELECT sum(人数) as 总人数, 
	avg(人数) as 平均值, 
	min(人数) as 最低, 
	max(人数) as 最高 FROM basic
--END COMMAND

--BEGIN各航班月(日)人数统计MLB
SELECT flightcode as 航班号, count(*) as 人数 FROM mlbtable where flightdate like '%%'GROUP BY flightcode
--END COMMAND

--BEGIN各航线月(日)人数统计MLB
SELECT fltsegment as 航程, count(*) as 人数 FROM mlbtable where flightdate like '%%'GROUP BY fltsegment
--END COMMAND

--BEGIN各航线月(日)人数统计FLR
SELECT fltsegment as 航程, count(*) as 架次, sum(flrreal) as 总人数, sum(flrcap) as 座位配置, (sum(flrreal)/sum(flrcap)*100) as 平均乘坐率 FROM flrtable where flightdate like '%%' GROUP BY fltsegment
--END COMMAND

--BEGIN代理人航线(航班)月(日)销售统计
SELECT ticsellagt as 代理人, count(*) as 人数 FROM mlbtable where ticsellagt like 'weh%' and fltsegment = 'WEHPEK'and flightcode = 'ca1588' and flightdate like '%%' group by ticsellagt ORDER BY count(*) DESC
--END COMMAND

--BEGIN代理人销售威海出港航线业绩统计
-- SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabWEHPEK.cnt AS 威海北京, tabWEHSHA.cnt AS 威海上海, tabWEHCAN.cnt AS 威海广州, tabWEHHRB.cnt AS 威海哈尔滨, tabWEHTNA.cnt AS 威海济南, tabWEHTYN.cnt AS 威海太原, tabWEHICN.cnt AS 威海汉城 FROM (((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHPEK' GROUP BY ticsellagt) AS tabWEHPEK) ON(tabWEHPEK.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHSHA' GROUP BY ticsellagt) AS tabWEHSHA) ON(tabWEHSHA.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHCAN' GROUP BY ticsellagt) AS tabWEHCAN) ON(tabWEHCAN.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHHRB' GROUP BY ticsellagt) AS tabWEHHRB) ON(tabWEHHRB.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHTNA' GROUP BY ticsellagt) AS tabWEHTNA) ON(tabWEHTNA.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHTYN' GROUP BY ticsellagt) AS tabWEHTYN) ON(tabWEHTYN.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHICN' GROUP BY ticsellagt) AS tabWEHICN) ON(tabWEHICN.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
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
--END COMMAND

--BEGIN代理人销售威海进港航线业绩统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabPEKWEH.cnt AS 北京威海, tabSHAWEH.cnt AS 上海威海, tabCANWEH.cnt AS 广州威海, tabHRBWEH.cnt AS 哈尔滨威海, tabTNAWEH.cnt AS 济南威海, tabTYNWEH.cnt AS 太原威海, tabICNWEH.cnt AS 汉城威海 FROM (((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'PEKWEH' GROUP BY ticsellagt) AS tabPEKWEH) ON(tabPEKWEH.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHAWEH' GROUP BY ticsellagt) AS tabSHAWEH) ON(tabSHAWEH.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'CANWEH' GROUP BY ticsellagt) AS tabCANWEH) ON(tabCANWEH.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'HRBWEH' GROUP BY ticsellagt) AS tabHRBWEH) ON(tabHRBWEH.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAWEH' GROUP BY ticsellagt) AS tabTNAWEH) ON(tabTNAWEH.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TYNWEH' GROUP BY ticsellagt) AS tabTYNWEH) ON(tabTYNWEH.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'ICNWEH' GROUP BY ticsellagt) AS tabICNWEH) ON(tabICNWEH.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
WITH tabPEKWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'PEKWEH' GROUP BY ticsellagt),

tabSHAWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHAWEH' GROUP BY ticsellagt),

tabCANWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'CANWEH' GROUP BY ticsellagt),

tabHRBWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'HRBWEH' GROUP BY ticsellagt),

tabTNAWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAWEH' GROUP BY ticsellagt),

tabTYNWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TYNWEH' GROUP BY ticsellagt),

tabICNWEH AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'ICNWEH' GROUP BY ticsellagt)


SELECT DISTINCT mlbtable.ticsellagt AS 代理人,
tabPEKWEH.cnt AS 北京威海, 
tabSHAWEH.cnt AS 上海威海, 
tabCANWEH.cnt AS 广州威海, 
tabHRBWEH.cnt AS 哈尔滨威海, 
tabTNAWEH.cnt AS 济南威海,
tabTYNWEH.cnt AS 太原威海, 
tabICNWEH.cnt AS 汉城威海
  
FROM mlbtable
    
LEFT JOIN tabPEKWEH ON(tabPEKWEH.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabSHAWEH ON(tabSHAWEH.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabCANWEH ON(tabCANWEH.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabHRBWEH ON(tabHRBWEH.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabTNAWEH ON(tabTNAWEH.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabTYNWEH ON(tabTYNWEH.ticsellagt = mlbtable.ticsellagt)
LEFT JOIN tabICNWEH ON(tabICNWEH.ticsellagt = mlbtable.ticsellagt)
WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
--END COMMAND

--BEGIN代理人销售烟台出港航线业绩统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabYNTPEK.cnt AS 烟台北京, tabYNTSHA.cnt AS 烟台上海, tabYNTHRB.cnt AS 烟台哈尔滨, tabYNTTNA.cnt AS 烟台济南, tabYNTCAN.cnt AS 烟台广州, tabYNTSZX.cnt AS 烟台深圳, tabYNTSHE.cnt AS 烟台沈阳, tabYNTYNJ.cnt AS 烟台延吉, tabYNTICN.cnt AS 烟台汉城 FROM (((((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTPEK' GROUP BY ticsellagt) AS tabYNTPEK) ON(tabYNTPEK.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSHA' GROUP BY ticsellagt) AS tabYNTSHA) ON(tabYNTSHA.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTHRB' GROUP BY ticsellagt) AS tabYNTHRB) ON(tabYNTHRB.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTTNA' GROUP BY ticsellagt) AS tabYNTTNA) ON(tabYNTTNA.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTCAN' GROUP BY ticsellagt) AS tabYNTCAN) ON(tabYNTCAN.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSZX' GROUP BY ticsellagt) AS tabYNTSZX) ON(tabYNTSZX.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSHE' GROUP BY ticsellagt) AS tabYNTSHE) ON(tabYNTSHE.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTYNJ' GROUP BY ticsellagt) AS tabYNTYNJ) ON(tabYNTYNJ.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTICN' GROUP BY ticsellagt) AS tabYNTICN) ON(tabYNTICN.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
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
--END COMMAND

--BEGIN代理人销售烟台进港航线业绩统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabPEKYNT.cnt AS 北京烟台, tabSHAYNT.cnt AS 上海烟台, tabHRBYNT.cnt AS 哈尔滨烟台, tabTNAYNT.cnt AS 济南烟台, tabCANYNT.cnt AS 广州烟台, tabSZXYNT.cnt AS 深圳烟台, tabSHEYNT.cnt AS 沈阳烟台, tabYNJYNT.cnt AS 延吉烟台, tabICNYNT.cnt AS 汉城烟台 FROM (((((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'PEKYNT' GROUP BY ticsellagt) AS tabPEKYNT) ON(tabPEKYNT.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHAYNT' GROUP BY ticsellagt) AS tabSHAYNT) ON(tabSHAYNT.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'HRBYNT' GROUP BY ticsellagt) AS tabHRBYNT) ON(tabHRBYNT.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAYNT' GROUP BY ticsellagt) AS tabTNAYNT) ON(tabTNAYNT.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'CANYNT' GROUP BY ticsellagt) AS tabCANYNT) ON(tabCANYNT.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SZXYNT' GROUP BY ticsellagt) AS tabSZXYNT) ON(tabSZXYNT.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHEYNT' GROUP BY ticsellagt) AS tabSHEYNT) ON(tabSHEYNT.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNJYNT' GROUP BY ticsellagt) AS tabYNJYNT) ON(tabYNJYNT.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'ICNYNT' GROUP BY ticsellagt) AS tabICNYNT) ON(tabICNYNT.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
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

--END COMMAND

--BEGIN威海出港各航班代理人销售统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1828.cnt AS CA1828, tabCA1588.cnt AS CA1588,tabFM9258.cnt AS FM9258, tabMU2288.cnt AS MU2288, tabCZ3788.cnt AS CZ3788wehcan, tabCZ3787.cnt AS CZ3787wehhrb, tabWEHTYN.cnt AS HU7590wehtyn, tabWEHTNA.cnt AS HU7590wehtna, tabCA147.cnt AS CA147, tabMU2017.cnt AS MU2017 FROM ((((((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1828' GROUP BY ticsellagt) AS tabCA1828) ON(tabCA1828.ticsellagt =mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1588' GROUP BY ticsellagt) AS tabCA1588) ON(tabCA1588.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9258' GROUP BY ticsellagt) AS tabFM9258) ON(tabFM9258.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode ='MU2288' GROUP BY ticsellagt) AS tabMU2288) ON(tabMU2288.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHCAN' and flightcode = 'CZ3788' GROUP BY ticsellagt) AS tabCZ3788) ON(tabCZ3788.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHHRB' and flightcode = 'CZ3787' GROUP BY ticsellagt) AS tabCZ3787) ON(tabCZ3787.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHTYN' and flightcode = 'HU7590' GROUP BY ticsellagt) AS tabWEHTYN) ON(tabWEHTYN.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'WEHTNA' GROUP BY ticsellagt) AS tabWEHTNA) ON(tabWEHTNA.ticsellagt=mlbtable.ticsellagt))LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA147' GROUP BY ticsellagt) AS tabCA147) ON(tabCA147.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2017'GROUP BY ticsellagt) AS tabMU2017) ON(tabMU2017.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
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

--END COMMAND

--BEGIN威海进港各航班代理人销售统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1827.cnt AS CA1827, tabCA1587.cnt AS CA1587,tabFM9257.cnt AS FM9257, tabMU2287.cnt AS MU2287, tabCZ3787.cnt AS CZ3787canweh, tabCZ3788.cnt AS CZ3788hrbweh, tabTYNWEH.cnt AS HU7589tynweh, tabTNAWEH.cnt AS HU7589tnaweh, tabCA148.cnt AS CA148, tabMU2018.cnt AS MU2018 FROM ((((((((((mlbtable)  LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1827' GROUP BY ticsellagt) AS tabCA1827) ON(tabCA1827.ticsellagt =mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1587' GROUP BY ticsellagt) AS tabCA1587) ON(tabCA1587.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9257' GROUP BY ticsellagt) AS tabFM9257) ON(tabFM9257.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode ='MU2287' GROUP BY ticsellagt) AS tabMU2287) ON(tabMU2287.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' and fltsegment = 'CANWEH' GROUP BY ticsellagt) AS tabCZ3787) ON(tabCZ3787.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' and fltsegment = 'HRBWEH' GROUP BY ticsellagt) AS tabCZ3788) ON(tabCZ3788.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TYNWEH' and flightcode = 'HU7589'GROUP BY ticsellagt) AS tabTYNWEH) ON(tabTYNWEH.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAWEH' and flightcode = 'HU7589'GROUP BY ticsellagt) AS tabTNAWEH) ON(tabTNAWEH.ticsellagt =mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA148' GROUP BY ticsellagt) AS tabCA148) ON(tabCA148.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2018' GROUP BY ticsellagt) AS tabMU2018) ON(tabMU2018.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
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
--END COMMAND

--BEGIN威海出港各航班月销售统计表MLB
--SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1828.cnt AS CA1828, tabCA1588.cnt AS CA1588, tabFM9258.cnt AS FM9258, tabMU2288.cnt AS MU2288, tabCZ3788.cnt AS CZ3788wehcan, tabCZ3787.cnt AS CZ3787wehhrb, tabWEHTYN.cnt AS HU7590wehtyn, tabWEHTNA.cnt AS HU7590wehtna, tabCA147.cnt AS CA147, tabMU2017.cnt AS MU2017 FROM ((((((((((mlbtable)  LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1828' GROUP BY flightdate) AS tabCA1828) ON(tabCA1828.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1588' GROUP BY flightdate) AS tabCA1588) ON(tabCA1588.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9258' GROUP BY flightdate) AS tabFM9258) ON(tabFM9258.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2288' GROUP BY flightdate) AS tabMU2288) ON(tabMU2288.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' and fltsegment = 'WEHCAN' GROUP BY flightdate) AS tabCZ3788) ON(tabCZ3788.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' and fltsegment = 'WEHHRB' GROUP BY flightdate) AS tabCZ3787) ON(tabCZ3787.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7590' and fltsegment = 'WEHTYN' GROUP BY flightdate) AS tabWEHTYN) ON(tabWEHTYN.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7590' and fltsegment = 'WEHTNA' GROUP BY flightdate) AS tabWEHTNA) ON(tabWEHTNA.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA147' GROUP BY flightdate) AS tabCA147) ON(tabCA147.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2017' GROUP BY flightdate) AS tabMU2017) ON(tabMU2017.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
WITH  tabCA1828 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1828' GROUP BY flightdate)
, tabCA1588 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1588' GROUP BY flightdate)
, tabFM9258 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9258' GROUP BY flightdate)
, tabMU2288 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2288' GROUP BY flightdate)
, tabCZ3788 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' and fltsegment = 'WEHCAN' GROUP BY flightdate)
, tabCZ3787 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' and fltsegment = 'WEHHRB' GROUP BY flightdate)
, tabWEHTYN AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7590' and fltsegment = 'WEHTYN' GROUP BY flightdate)
, tabWEHTNA AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7590' and fltsegment = 'WEHTNA' GROUP BY flightdate)
, tabCA147 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA147' GROUP BY flightdate)
, tabMU2017 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2017' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1828.cnt AS CA1828, tabCA1588.cnt AS CA1588, tabFM9258.cnt AS FM9258, tabMU2288.cnt AS MU2288, tabCZ3788.cnt AS CZ3788wehcan, tabCZ3787.cnt AS CZ3787wehhrb, tabWEHTYN.cnt AS HU7590wehtyn, tabWEHTNA.cnt AS HU7590wehtna, tabCA147.cnt AS CA147, tabMU2017.cnt AS MU2017 FROM mlbtable  
LEFT JOIN  tabCA1828 ON (tabCA1828.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1588 ON (tabCA1588.flightdate = mlbtable.flightdate )
LEFT JOIN  tabFM9258 ON (tabFM9258.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU2288 ON (tabMU2288.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ3788 ON (tabCZ3788.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ3787 ON (tabCZ3787.flightdate = mlbtable.flightdate )
LEFT JOIN  tabWEHTYN ON (tabWEHTYN.flightdate = mlbtable.flightdate )
LEFT JOIN  tabWEHTNA ON (tabWEHTNA.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA147 ON (tabCA147.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU2017 ON (tabMU2017.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN威海进港各航班月销售统计表MLB
--SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1827.cnt AS CA1827, tabCA1587.cnt AS CA1587, tabFM9257.cnt AS FM9257, tabMU2287.cnt AS MU2287, tabCZ3787.cnt AS CZ3787canweh, tabCZ3788.cnt AS CZ3788hrbweh, tabTYNWEH.cnt AS HU7589tynweh, tabTNAWEH.cnt AS HU7589tnaweh, tabCA148.cnt AS CA148, tabMU2018.cnt AS MU2018 FROM ((((((((((mlbtable)  LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1827' GROUP BY flightdate) AS tabCA1827) ON(tabCA1827.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1587' GROUP BY flightdate) AS tabCA1587) ON(tabCA1587.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9257' GROUP BY flightdate) AS tabFM9257) ON(tabFM9257.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2287' GROUP BY flightdate) AS tabMU2287) ON(tabMU2287.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' and fltsegment = 'CANWEH' GROUP BY flightdate) AS tabCZ3787) ON(tabCZ3787.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' and fltsegment = 'HRBWEH' GROUP BY flightdate) AS tabCZ3788) ON(tabCZ3788.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7589' and fltsegment = 'TYNWEH' GROUP BY flightdate) AS tabTYNWEH) ON(tabTYNWEH.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7589' and fltsegment = 'TNAWEH' GROUP BY flightdate) AS tabTNAWEH) ON(tabTNAWEH.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA148' GROUP BY flightdate) AS tabCA148) ON(tabCA148.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2018' GROUP BY flightdate) AS tabMU2018) ON(tabMU2018.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
WITH  tabCA1827 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1827' GROUP BY flightdate)
, tabCA1587 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1587' GROUP BY flightdate)
, tabFM9257 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9257' GROUP BY flightdate)
, tabMU2287 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2287' GROUP BY flightdate)
, tabCZ3787 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' and fltsegment = 'CANWEH' GROUP BY flightdate)
, tabCZ3788 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' and fltsegment = 'HRBWEH' GROUP BY flightdate)
, tabTYNWEH AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7589' and fltsegment = 'TYNWEH' GROUP BY flightdate)
, tabTNAWEH AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7589' and fltsegment = 'TNAWEH' GROUP BY flightdate)
, tabCA148 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA148' GROUP BY flightdate)
, tabMU2018 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2018' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1827.cnt AS CA1827, tabCA1587.cnt AS CA1587, tabFM9257.cnt AS FM9257, tabMU2287.cnt AS MU2287, tabCZ3787.cnt AS CZ3787canweh, tabCZ3788.cnt AS CZ3788hrbweh, tabTYNWEH.cnt AS HU7589tynweh, tabTNAWEH.cnt AS HU7589tnaweh, tabCA148.cnt AS CA148, tabMU2018.cnt AS MU2018 FROM mlbtable  
LEFT JOIN  tabCA1827 ON (tabCA1827.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1587 ON (tabCA1587.flightdate = mlbtable.flightdate )
LEFT JOIN  tabFM9257 ON (tabFM9257.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU2287 ON (tabMU2287.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ3787 ON (tabCZ3787.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ3788 ON (tabCZ3788.flightdate = mlbtable.flightdate )
LEFT JOIN  tabTYNWEH ON (tabTYNWEH.flightdate = mlbtable.flightdate )
LEFT JOIN  tabTNAWEH ON (tabTNAWEH.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA148 ON (tabCA148.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU2018 ON (tabMU2018.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN威海出港各航班代理人销售月报表
--SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1828.cnt AS CA1828, tabCA1588.cnt AS CA1588, tabFM9258.cnt AS FM9258, tabMU2288.cnt AS MU2288, tabCZ3788.cnt AS CZ3788wehcan, tabCZ3787.cnt AS CZ3787wehhrb, tabWEHTYN.cnt AS HU7590wehtyn, tabWEHTNA.cnt AS HU7590wehtna, tabCA147.cnt AS CA147,tabMU2017.cnt AS MU2017 FROM ((((((((((mlbtable)  LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1828' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1828) ON(tabCA1828.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1588' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1588) ON(tabCA1588.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9258' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabFM9258) ON(tabFM9258.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2288' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU2288) ON(tabMU2288.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' AND fltsegment = 'WEHCAN' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCZ3788) ON(tabCZ3788.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' AND fltsegment = 'WEHHRB' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCZ3787) ON(tabCZ3787.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7590' AND fltsegment = 'WEHTYN' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabWEHTYN) ON(tabWEHTYN.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7590' AND fltsegment = 'WEHTNA' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabWEHTNA) ON(tabWEHTNA.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA147'  AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA147) ON(tabCA147.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2017' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU2017) ON(tabMU2017.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%'ORDER BY mlbtable.flightdate 
WITH  tabCA1828 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1828' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA1588 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1588' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabFM9258 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9258' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU2288 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2288' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCZ3788 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' AND fltsegment = 'WEHCAN' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCZ3787 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' AND fltsegment = 'WEHHRB' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabWEHTYN AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7590' AND fltsegment = 'WEHTYN' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabWEHTNA AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7590' AND fltsegment = 'WEHTNA' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA147 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA147'  AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU2017 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2017' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1828.cnt AS CA1828, tabCA1588.cnt AS CA1588, tabFM9258.cnt AS FM9258, tabMU2288.cnt AS MU2288, tabCZ3788.cnt AS CZ3788wehcan, tabCZ3787.cnt AS CZ3787wehhrb, tabWEHTYN.cnt AS HU7590wehtyn, tabWEHTNA.cnt AS HU7590wehtna, tabCA147.cnt AS CA147,tabMU2017.cnt AS MU2017 FROM mlbtable  
LEFT JOIN  tabCA1828 ON (tabCA1828.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1588 ON (tabCA1588.flightdate = mlbtable.flightdate )
LEFT JOIN  tabFM9258 ON (tabFM9258.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU2288 ON (tabMU2288.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ3788 ON (tabCZ3788.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ3787 ON (tabCZ3787.flightdate = mlbtable.flightdate )
LEFT JOIN  tabWEHTYN ON (tabWEHTYN.flightdate = mlbtable.flightdate )
LEFT JOIN  tabWEHTNA ON (tabWEHTNA.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA147 ON (tabCA147.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU2017 ON (tabMU2017.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%'ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN威海进港各航班代理人销售月报表
--SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1827.cnt AS CA1827, tabCA1587.cnt AS CA1587, tabFM9257.cnt AS FM9257, tabMU2287.cnt AS MU2287, tabCZ3787.cnt AS CZ3787canweh, tabCZ3788.cnt AS CZ3788hrbweh, tabTYNWEH.cnt AS HU7589tynweh, tabTNAWEH.cnt AS HU7589tnaweh, tabCA148.cnt AS CA148,tabMU2018.cnt AS MU2018 FROM ((((((((((mlbtable)  LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1827' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1827) ON(tabCA1827.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1587' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1587) ON(tabCA1587.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9257' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabFM9257) ON(tabFM9257.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2287' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU2287) ON(tabMU2287.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' AND fltsegment = 'CANWEH' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCZ3787) ON(tabCZ3787.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' AND fltsegment = 'HRBWEH' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCZ3788) ON(tabCZ3788.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7589' AND fltsegment = 'TYNWEH' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabTYNWEH) ON(tabTYNWEH.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7589' AND fltsegment = 'TNAWEH' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabTNAWEH) ON(tabTNAWEH.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA148'  AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA148) ON(tabCA148.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2018' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU2018) ON(tabMU2018.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%'ORDER BY mlbtable.flightdate
WITH  tabCA1827 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1827' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA1587 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1587' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabFM9257 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9257' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU2287 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2287' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCZ3787 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3787' AND fltsegment = 'CANWEH' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCZ3788 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ3788' AND fltsegment = 'HRBWEH' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabTYNWEH AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7589' AND fltsegment = 'TYNWEH' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabTNAWEH AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'HU7589' AND fltsegment = 'TNAWEH' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA148 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA148'  AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU2018 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2018' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1827.cnt AS CA1827, tabCA1587.cnt AS CA1587, tabFM9257.cnt AS FM9257, tabMU2287.cnt AS MU2287, tabCZ3787.cnt AS CZ3787canweh, tabCZ3788.cnt AS CZ3788hrbweh, tabTYNWEH.cnt AS HU7589tynweh, tabTNAWEH.cnt AS HU7589tnaweh, tabCA148.cnt AS CA148,tabMU2018.cnt AS MU2018 FROM mlbtable  
LEFT JOIN  tabCA1827 ON (tabCA1827.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1587 ON (tabCA1587.flightdate = mlbtable.flightdate )
LEFT JOIN  tabFM9257 ON (tabFM9257.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU2287 ON (tabMU2287.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ3787 ON (tabCZ3787.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ3788 ON (tabCZ3788.flightdate = mlbtable.flightdate )
LEFT JOIN  tabTYNWEH ON (tabTYNWEH.flightdate = mlbtable.flightdate )
LEFT JOIN  tabTNAWEH ON (tabTNAWEH.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA148 ON (tabCA148.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU2018 ON (tabMU2018.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%'ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN烟台出港北京航班代理人销售统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1586.cnt AS CA1586, tabSC1586.cnt AS SC1586,tabCA1972.cnt AS CA1972, tabSC1972.cnt AS SC1972, tabSC4851.cnt AS SC4851, tabSC4855.cnt AS SC4855, tabMU5135.cnt AS MU5135, tabMU5483.cnt AS MU5483, tabMU514.cnt AS MU514, tabCA1546.cnt AS CA1546, tabCA1830.cnt AS CA1830 FROM (((((((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1586' AND flightdate like '%%'GROUP BY ticsellagt) AS tabCA1586) ON(tabCA1586.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1586' AND flightdate like '%%'GROUP BY ticsellagt) AS tabSC1586) ON(tabSC1586.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1972' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCA1972) ON(tabCA1972.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1972' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC1972) ON(tabSC1972.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4851' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4851) ON(tabSC4851.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4855' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4855) ON(tabSC4855.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5135' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU5135) ON(tabMU5135.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5483' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU5483) ON(tabMU5483.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU514'  AND fltsegment = 'YNTPEK' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU514) ON(tabMU514.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1546' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCA1546) ON(tabCA1546.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1830' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCA1830) ON(tabCA1830.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%'ORDER BY mlbtable.ticsellagt
WITH  tabCA1586 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1586' AND flightdate like '%%'GROUP BY ticsellagt)
, tabSC1586 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1586' AND flightdate like '%%'GROUP BY ticsellagt)
, tabCA1972 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1972' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC1972 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1972' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4851 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4851' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4855 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4855' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU5135 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5135' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU5483 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5483' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU514 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU514'  AND fltsegment = 'YNTPEK' AND flightdate like '%%' GROUP BY ticsellagt)
, tabCA1546 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1546' AND flightdate like '%%' GROUP BY ticsellagt)
, tabCA1830 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1830' AND flightdate like '%%' GROUP BY ticsellagt)

SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1586.cnt AS CA1586, tabSC1586.cnt AS SC1586,tabCA1972.cnt AS CA1972, tabSC1972.cnt AS SC1972, tabSC4851.cnt AS SC4851, tabSC4855.cnt AS SC4855, tabMU5135.cnt AS MU5135, tabMU5483.cnt AS MU5483, tabMU514.cnt AS MU514, tabCA1546.cnt AS CA1546, tabCA1830.cnt AS CA1830 FROM mlbtable 
LEFT JOIN  tabCA1586 ON (tabCA1586.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC1586 ON (tabSC1586.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCA1972 ON (tabCA1972.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC1972 ON (tabSC1972.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4851 ON (tabSC4851.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4855 ON (tabSC4855.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU5135 ON (tabMU5135.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU5483 ON (tabMU5483.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU514 ON (tabMU514.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCA1546 ON (tabCA1546.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCA1830 ON (tabCA1830.ticsellagt = mlbtable.ticsellagt )
WHERE mlbtable.ticsellagt LIKE 'weh%'ORDER BY mlbtable.ticsellagt
--END COMMAND

--BEGIN烟台进港北京航班代理人销售统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1585.cnt AS CA1585, tabSC1585.cnt AS SC1585,tabCA1971.cnt AS CA1971, tabSC1971.cnt AS SC1971, tabSC4852.cnt AS SC4852, tabSC4856.cnt AS SC4856, tabMU5136.cnt AS MU5136, tabMU5484.cnt AS MU5484, tabMU513.cnt AS MU513, tabCA1545.cnt AS CA1545, tabCA1829.cnt AS CA1829 FROM (((((((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1585' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCA1585) ON(tabCA1585.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1585' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC1585) ON(tabSC1585.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1971' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCA1971) ON(tabCA1971.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1971' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC1971) ON(tabSC1971.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4852' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4852) ON(tabSC4852.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4856' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4856) ON(tabSC4856.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5136' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU5136) ON(tabMU5136.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5484' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU5484) ON(tabMU5484.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU513'  AND fltsegment = 'PEKYNT' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU513) ON(tabMU513.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1545' AND flightdate like '%%'GROUP BY ticsellagt) AS tabCA1545) ON(tabCA1545.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1829' AND flightdate like '%%'GROUP BY ticsellagt) AS tabCA1829) ON(tabCA1829.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt 
WITH  tabCA1585 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1585' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC1585 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1585' AND flightdate like '%%' GROUP BY ticsellagt)
, tabCA1971 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1971' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC1971 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1971' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4852 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4852' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4856 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4856' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU5136 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5136' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU5484 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5484' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU513 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU513'  AND fltsegment = 'PEKYNT' AND flightdate like '%%' GROUP BY ticsellagt)
, tabCA1545 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1545' AND flightdate like '%%'GROUP BY ticsellagt)
, tabCA1829 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1829' AND flightdate like '%%'GROUP BY ticsellagt)

SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1585.cnt AS CA1585, tabSC1585.cnt AS SC1585,tabCA1971.cnt AS CA1971, tabSC1971.cnt AS SC1971, tabSC4852.cnt AS SC4852, tabSC4856.cnt AS SC4856, tabMU5136.cnt AS MU5136, tabMU5484.cnt AS MU5484, tabMU513.cnt AS MU513, tabCA1545.cnt AS CA1545, tabCA1829.cnt AS CA1829 FROM mlbtable 
LEFT JOIN  tabCA1585 ON (tabCA1585.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC1585 ON (tabSC1585.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCA1971 ON (tabCA1971.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC1971 ON (tabSC1971.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4852 ON (tabSC4852.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4856 ON (tabSC4856.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU5136 ON (tabMU5136.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU5484 ON (tabMU5484.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU513 ON (tabMU513.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCA1545 ON (tabCA1545.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCA1829 ON (tabCA1829.ticsellagt = mlbtable.ticsellagt )
WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
--END COMMAND

--BEGIN烟台出港上海航班代理人销售统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1962.cnt AS CA1962, tabSC1962.cnt AS SC1962,tabSC4861.cnt AS SC4861, tabSC4865.cnt AS SC4865, tabMU5546.cnt AS MU5546, tabMU5548.cnt AS MU5548, tabFM9252.cnt AS FM9252, tabSC4863.cnt AS SC4863, tabCZ6551.cnt AS CZ6551, tabAB0001.cnt AS AB0001, tabAB0002.cnt AS AB0002 FROM (((((((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1962' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCA1962) ON(tabCA1962.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1962' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC1962) ON(tabSC1962.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4861' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4861) ON(tabSC4861.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4865' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4865) ON(tabSC4865.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5546' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU5546) ON(tabMU5546.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5548' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU5548) ON(tabMU5548.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9252' AND flightdate like '%%' GROUP BY ticsellagt) AS tabFM9252) ON(tabFM9252.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4863' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4863) ON(tabSC4863.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ6551'  AND fltsegment = 'YNTSHA' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCZ6551) ON(tabCZ6551.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'AB0001' AND flightdate like '%%' GROUP BY ticsellagt) AS tabAB0001) ON(tabAB0001.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'AB0002' AND flightdate like '%%' GROUP BY ticsellagt) AS tabAB0002) ON(tabAB0002.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
WITH  tabCA1962 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1962' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC1962 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1962' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4861 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4861' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4865 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4865' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU5546 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5546' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU5548 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5548' AND flightdate like '%%' GROUP BY ticsellagt)
, tabFM9252 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9252' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4863 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4863' AND flightdate like '%%' GROUP BY ticsellagt)
, tabCZ6551 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ6551'  AND fltsegment = 'YNTSHA' AND flightdate like '%%' GROUP BY ticsellagt)
, tabAB0001 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'AB0001' AND flightdate like '%%' GROUP BY ticsellagt)
, tabAB0002 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'AB0002' AND flightdate like '%%' GROUP BY ticsellagt)

SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1962.cnt AS CA1962, tabSC1962.cnt AS SC1962,tabSC4861.cnt AS SC4861, tabSC4865.cnt AS SC4865, tabMU5546.cnt AS MU5546, tabMU5548.cnt AS MU5548, tabFM9252.cnt AS FM9252, tabSC4863.cnt AS SC4863, tabCZ6551.cnt AS CZ6551, tabAB0001.cnt AS AB0001, tabAB0002.cnt AS AB0002 FROM mlbtable 
LEFT JOIN  tabCA1962 ON (tabCA1962.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC1962 ON (tabSC1962.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4861 ON (tabSC4861.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4865 ON (tabSC4865.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU5546 ON (tabMU5546.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU5548 ON (tabMU5548.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabFM9252 ON (tabFM9252.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4863 ON (tabSC4863.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCZ6551 ON (tabCZ6551.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabAB0001 ON (tabAB0001.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabAB0002 ON (tabAB0002.ticsellagt = mlbtable.ticsellagt )
WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
--END COMMAND

--BEGIN烟台进港上海航班代理人销售统计
--SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1961.cnt AS CA1961, tabSC1961.cnt AS SC1961,tabSC4862.cnt AS SC4862, tabSC4866.cnt AS SC4866, tabSC4864.cnt AS SC4864, tabMU5545.cnt AS MU5545, tabMU5547.cnt AS MU5547, tabFM9251.cnt AS FM9251, tabCZ6552.cnt AS CZ6552, tabBA0001.cnt AS BA0001, tabBA0002.cnt AS BA0002 FROM (((((((((((mlbtable) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1961' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCA1961) ON(tabCA1961.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1961' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC1961) ON(tabSC1961.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4862' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4862) ON(tabSC4862.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4866' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4866) ON(tabSC4866.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4864' AND flightdate like '%%' GROUP BY ticsellagt) AS tabSC4864) ON(tabSC4864.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5545' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU5545) ON(tabMU5545.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5547' AND flightdate like '%%' GROUP BY ticsellagt) AS tabMU5547) ON(tabMU5547.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9251' AND flightdate like '%%' GROUP BY ticsellagt) AS tabFM9251) ON(tabFM9251.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ6552'  AND fltsegment = 'SHAYNT' AND flightdate like '%%' GROUP BY ticsellagt) AS tabCZ6552) ON(tabCZ6552.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'BA0001' AND flightdate like '%%' GROUP BY ticsellagt) AS tabBA0001) ON(tabBA0001.ticsellagt = mlbtable.ticsellagt)) LEFT JOIN ((SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'BA0002' AND flightdate like '%%' GROUP BY ticsellagt) AS tabBA0002) ON(tabBA0002.ticsellagt = mlbtable.ticsellagt) WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
WITH  tabCA1961 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1961' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC1961 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1961' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4862 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4862' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4866 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4866' AND flightdate like '%%' GROUP BY ticsellagt)
, tabSC4864 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4864' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU5545 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5545' AND flightdate like '%%' GROUP BY ticsellagt)
, tabMU5547 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5547' AND flightdate like '%%' GROUP BY ticsellagt)
, tabFM9251 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9251' AND flightdate like '%%' GROUP BY ticsellagt)
, tabCZ6552 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ6552'  AND fltsegment = 'SHAYNT' AND flightdate like '%%' GROUP BY ticsellagt)
, tabBA0001 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'BA0001' AND flightdate like '%%' GROUP BY ticsellagt)
, tabBA0002 AS
(SELECT ticsellagt, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'BA0002' AND flightdate like '%%' GROUP BY ticsellagt)

SELECT DISTINCT mlbtable.ticsellagt AS 代理人, tabCA1961.cnt AS CA1961, tabSC1961.cnt AS SC1961,tabSC4862.cnt AS SC4862, tabSC4866.cnt AS SC4866, tabSC4864.cnt AS SC4864, tabMU5545.cnt AS MU5545, tabMU5547.cnt AS MU5547, tabFM9251.cnt AS FM9251, tabCZ6552.cnt AS CZ6552, tabBA0001.cnt AS BA0001, tabBA0002.cnt AS BA0002 FROM mlbtable 
LEFT JOIN  tabCA1961 ON (tabCA1961.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC1961 ON (tabSC1961.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4862 ON (tabSC4862.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4866 ON (tabSC4866.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabSC4864 ON (tabSC4864.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU5545 ON (tabMU5545.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabMU5547 ON (tabMU5547.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabFM9251 ON (tabFM9251.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabCZ6552 ON (tabCZ6552.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabBA0001 ON (tabBA0001.ticsellagt = mlbtable.ticsellagt )
LEFT JOIN  tabBA0002 ON (tabBA0002.ticsellagt = mlbtable.ticsellagt )
WHERE mlbtable.ticsellagt LIKE 'weh%' ORDER BY mlbtable.ticsellagt
--END COMMAND

--BEGIN烟台出港北京航班威海销售月报表
--SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1586.cnt AS CA1586, tabSC1586.cnt AS SC1586, tabCA1972.cnt AS CA1972, tabSC1972.cnt AS SC1972, tabSC4851.cnt AS SC4851, tabSC4855.cnt AS SC4855, tabMU5135.cnt AS MU5135,tabMU5483.cnt AS MU5483, tabMU514.cnt AS MU514, tabCA1546.cnt AS CA1546, tabCA1830.cnt AS CA1830 FROM (((((((((((mlbtable) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1586' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1586) ON(tabCA1586.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1586' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC1586) ON(tabSC1586.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1972' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1972) ON(tabCA1972.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1972' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC1972) ON(tabSC1972.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4851' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4851) ON(tabSC4851.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4855' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4855) ON(tabSC4855.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5135' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU5135) ON(tabMU5135.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5483' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU5483) ON(tabMU5483.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU514'  AND fltsegment = 'YNTPEK' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU514) ON(tabMU514.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1546' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1546) ON(tabCA1546.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1830' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1830) ON(tabCA1830.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%'ORDER BY mlbtable.flightdate
WITH  tabCA1586 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1586' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC1586 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1586' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA1972 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1972' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC1972 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1972' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4851 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4851' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4855 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4855' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU5135 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5135' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU5483 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5483' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU514 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU514'  AND fltsegment = 'YNTPEK' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA1546 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1546' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA1830 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1830' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1586.cnt AS CA1586, tabSC1586.cnt AS SC1586, tabCA1972.cnt AS CA1972, tabSC1972.cnt AS SC1972, tabSC4851.cnt AS SC4851, tabSC4855.cnt AS SC4855, tabMU5135.cnt AS MU5135,tabMU5483.cnt AS MU5483, tabMU514.cnt AS MU514, tabCA1546.cnt AS CA1546, tabCA1830.cnt AS CA1830 FROM mlbtable 
LEFT JOIN  tabCA1586 ON (tabCA1586.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC1586 ON (tabSC1586.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1972 ON (tabCA1972.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC1972 ON (tabSC1972.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4851 ON (tabSC4851.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4855 ON (tabSC4855.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU5135 ON (tabMU5135.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU5483 ON (tabMU5483.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU514 ON (tabMU514.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1546 ON (tabCA1546.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1830 ON (tabCA1830.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%'ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN烟台进港北京航班威海销售月报表
--SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1585.cnt AS CA1585, tabSC1585.cnt AS SC1585, tabCA1971.cnt AS CA1971, tabSC1971.cnt AS SC1971, tabSC4852.cnt AS SC4852, tabSC4856.cnt AS SC4856, tabMU5136.cnt AS MU5136, tabMU5484.cnt AS MU5484, tabMU513.cnt AS MU513, tabCA1545.cnt AS CA1545, tabCA1829.cnt AS CA1829 FROM (((((((((((mlbtable) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1585' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1585) ON(tabCA1585.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1585' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC1585) ON(tabSC1585.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1971' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1971) ON(tabCA1971.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1971' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC1971) ON(tabSC1971.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4852' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4852) ON(tabSC4852.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4856' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4856) ON(tabSC4856.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5136' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU5136) ON(tabMU5136.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5484' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU5484) ON(tabMU5484.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU513'  AND fltsegment = 'PEKYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU513) ON(tabMU513.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1545' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1545) ON(tabCA1545.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1829' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1829) ON(tabCA1829.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%'ORDER BY mlbtable.flightdate 
WITH  tabCA1585 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1585' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC1585 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1585' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA1971 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1971' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC1971 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1971' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4852 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4852' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4856 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4856' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU5136 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5136' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU5484 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5484' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU513 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU513'  AND fltsegment = 'PEKYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA1545 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1545' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCA1829 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1829' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1585.cnt AS CA1585, tabSC1585.cnt AS SC1585, tabCA1971.cnt AS CA1971, tabSC1971.cnt AS SC1971, tabSC4852.cnt AS SC4852, tabSC4856.cnt AS SC4856, tabMU5136.cnt AS MU5136, tabMU5484.cnt AS MU5484, tabMU513.cnt AS MU513, tabCA1545.cnt AS CA1545, tabCA1829.cnt AS CA1829 FROM mlbtable 
LEFT JOIN  tabCA1585 ON (tabCA1585.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC1585 ON (tabSC1585.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1971 ON (tabCA1971.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC1971 ON (tabSC1971.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4852 ON (tabSC4852.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4856 ON (tabSC4856.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU5136 ON (tabMU5136.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU5484 ON (tabMU5484.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU513 ON (tabMU513.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1545 ON (tabCA1545.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCA1829 ON (tabCA1829.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%'ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN烟台出港上海航班威海销售月报表
--SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1962.cnt AS CA1962, tabSC1962.cnt AS SC1962, tabSC4861.cnt AS SC4861, tabSC4865.cnt AS SC4865, tabMU5546.cnt AS MU5546, tabMU5548.cnt AS MU5548, tabFM9252.cnt AS FM9252,tabSC4863.cnt AS SC4863, tabCZ6551.cnt AS CZ6551, tabAB0001.cnt AS AB0001, tabAB0002.cnt AS AB0002 FROM (((((((((((mlbtable)  LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1962' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1962) ON(tabCA1962.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1962' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC1962) ON(tabSC1962.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4861' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4861) ON(tabSC4861.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4865' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4865) ON(tabSC4865.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5546' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU5546) ON(tabMU5546.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5548' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU5548) ON(tabMU5548.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9252' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabFM9252) ON(tabFM9252.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4863' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4863) ON(tabSC4863.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ6551'  AND fltsegment = 'YNTSHA' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCZ6551) ON(tabCZ6551.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'AB0001' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabAB0001) ON(tabAB0001.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'AB0002' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabAB0002) ON(tabAB0002.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate 
WITH  tabCA1962 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1962' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC1962 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1962' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4861 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4861' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4865 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4865' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU5546 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5546' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU5548 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5548' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabFM9252 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9252' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4863 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4863' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCZ6551 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ6551'  AND fltsegment = 'YNTSHA' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabAB0001 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'AB0001' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabAB0002 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'AB0002' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1962.cnt AS CA1962, tabSC1962.cnt AS SC1962, tabSC4861.cnt AS SC4861, tabSC4865.cnt AS SC4865, tabMU5546.cnt AS MU5546, tabMU5548.cnt AS MU5548, tabFM9252.cnt AS FM9252,tabSC4863.cnt AS SC4863, tabCZ6551.cnt AS CZ6551, tabAB0001.cnt AS AB0001, tabAB0002.cnt AS AB0002 FROM mlbtable  
LEFT JOIN  tabCA1962 ON (tabCA1962.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC1962 ON (tabSC1962.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4861 ON (tabSC4861.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4865 ON (tabSC4865.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU5546 ON (tabMU5546.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU5548 ON (tabMU5548.flightdate = mlbtable.flightdate )
LEFT JOIN  tabFM9252 ON (tabFM9252.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4863 ON (tabSC4863.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ6551 ON (tabCZ6551.flightdate = mlbtable.flightdate )
LEFT JOIN  tabAB0001 ON (tabAB0001.flightdate = mlbtable.flightdate )
LEFT JOIN  tabAB0002 ON (tabAB0002.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN烟台进港上海航班威海销售月报表
--SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1961.cnt AS CA1961, tabSC1961.cnt AS SC1961, tabSC4862.cnt AS SC4862, tabSC4866.cnt AS SC4866, tabSC4864.cnt AS SC4864,tabMU5545.cnt AS MU5545, tabMU5547.cnt AS MU5547,tabFM9251.cnt AS FM9251, tabCZ6552.cnt AS CZ6552, tabBA0001.cnt AS BA0001, tabBA0002.cnt AS BA0002 FROM (((((((((((mlbtable) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1961' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCA1961) ON(tabCA1961.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1961' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC1961) ON(tabSC1961.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4862' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4862) ON(tabSC4862.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4866' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4866) ON(tabSC4866.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4864' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSC4864) ON(tabSC4864.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5545' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU5545) ON(tabMU5545.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5547' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabMU5547) ON(tabMU5547.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9251' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabFM9251) ON(tabFM9251.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ6552'  AND fltsegment = 'SHAYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCZ6552) ON(tabCZ6552.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'BA0001' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabBA0001) ON(tabBA0001.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'BA0002' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabBA0002) ON(tabBA0002.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
WITH  tabCA1961 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1961' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC1961 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC1961' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4862 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4862' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4866 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4866' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSC4864 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'SC4864' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU5545 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5545' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabMU5547 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU5547' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabFM9251 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9251' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCZ6552 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CZ6552'  AND fltsegment = 'SHAYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabBA0001 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'BA0001' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabBA0002 AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'BA0002' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 班期, tabCA1961.cnt AS CA1961, tabSC1961.cnt AS SC1961, tabSC4862.cnt AS SC4862, tabSC4866.cnt AS SC4866, tabSC4864.cnt AS SC4864,tabMU5545.cnt AS MU5545, tabMU5547.cnt AS MU5547,tabFM9251.cnt AS FM9251, tabCZ6552.cnt AS CZ6552, tabBA0001.cnt AS BA0001, tabBA0002.cnt AS BA0002 FROM mlbtable 
LEFT JOIN  tabCA1961 ON (tabCA1961.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC1961 ON (tabSC1961.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4862 ON (tabSC4862.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4866 ON (tabSC4866.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSC4864 ON (tabSC4864.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU5545 ON (tabMU5545.flightdate = mlbtable.flightdate )
LEFT JOIN  tabMU5547 ON (tabMU5547.flightdate = mlbtable.flightdate )
LEFT JOIN  tabFM9251 ON (tabFM9251.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCZ6552 ON (tabCZ6552.flightdate = mlbtable.flightdate )
LEFT JOIN  tabBA0001 ON (tabBA0001.flightdate = mlbtable.flightdate )
LEFT JOIN  tabBA0002 ON (tabBA0002.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN烟台出港各航线威海月销售统计表
--SELECT DISTINCT mlbtable.flightdate AS 代理人, tabYNTPEK.cnt AS 烟台北京, tabYNTSHA.cnt AS 烟台上海, tabYNTHRB.cnt AS 烟台哈尔滨, tabYNTTNA.cnt AS 烟台济南, tabYNTCAN.cnt AS 烟台广州, tabYNTSZX.cnt AS 烟台深圳, tabYNTSHE.cnt AS 烟台沈阳, tabYNTYNJ.cnt AS 烟台延吉, tabYNTICN.cnt AS 烟台汉城 FROM (((((((((mlbtable) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTPEK' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTPEK) ON(tabYNTPEK.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSHA' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTSHA) ON(tabYNTSHA.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTHRB' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTHRB) ON(tabYNTHRB.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTTNA' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTTNA) ON(tabYNTTNA.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTCAN' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTCAN) ON(tabYNTCAN.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSZX' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTSZX) ON(tabYNTSZX.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSHE' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTSHE) ON(tabYNTSHE.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTYNJ' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTYNJ) ON(tabYNTYNJ.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTICN' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNTICN) ON(tabYNTICN.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
WITH  tabYNTPEK AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTPEK' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNTSHA AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSHA' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNTHRB AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTHRB' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNTTNA AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTTNA' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNTCAN AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTCAN' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNTSZX AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSZX' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNTSHE AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTSHE' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNTYNJ AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTYNJ' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNTICN AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNTICN' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 代理人, tabYNTPEK.cnt AS 烟台北京, tabYNTSHA.cnt AS 烟台上海, tabYNTHRB.cnt AS 烟台哈尔滨, tabYNTTNA.cnt AS 烟台济南, tabYNTCAN.cnt AS 烟台广州, tabYNTSZX.cnt AS 烟台深圳, tabYNTSHE.cnt AS 烟台沈阳, tabYNTYNJ.cnt AS 烟台延吉, tabYNTICN.cnt AS 烟台汉城 FROM mlbtable 
LEFT JOIN  tabYNTPEK ON (tabYNTPEK.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNTSHA ON (tabYNTSHA.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNTHRB ON (tabYNTHRB.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNTTNA ON (tabYNTTNA.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNTCAN ON (tabYNTCAN.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNTSZX ON (tabYNTSZX.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNTSHE ON (tabYNTSHE.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNTYNJ ON (tabYNTYNJ.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNTICN ON (tabYNTICN.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
--END COMMAND

--BEGIN烟台进港各航线威海月销售统计表
--SELECT DISTINCT mlbtable.flightdate AS 代理人, tabPEKYNT.cnt AS 北京烟台, tabSHAYNT.cnt AS 上海烟台, tabHRBYNT.cnt AS 哈尔滨烟台, tabTNAYNT.cnt AS 济南烟台, tabCANYNT.cnt AS 广州烟台, tabSZXYNT.cnt AS 深圳烟台, tabSHEYNT.cnt AS 沈阳烟台, tabYNJYNT.cnt AS 延吉烟台, tabICNYNT.cnt AS 汉城烟台 FROM (((((((((mlbtable) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'PEKYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabPEKYNT) ON(tabPEKYNT.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHAYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSHAYNT) ON(tabSHAYNT.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'HRBYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabHRBYNT) ON(tabHRBYNT.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabTNAYNT) ON(tabTNAYNT.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'CANYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabCANYNT) ON(tabCANYNT.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SZXYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSZXYNT) ON(tabSZXYNT.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHEYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabSHEYNT) ON(tabSHEYNT.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNJYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabYNJYNT) ON(tabYNJYNT.flightdate = mlbtable.flightdate)) LEFT JOIN ((SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'ICNYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate) AS tabICNYNT) ON(tabICNYNT.flightdate = mlbtable.flightdate) WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
WITH  tabPEKYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'PEKYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSHAYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHAYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabHRBYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'HRBYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabTNAYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabCANYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'CANYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSZXYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SZXYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabSHEYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'SHEYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabYNJYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'YNJYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)
, tabICNYNT AS
(SELECT flightdate, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'ICNYNT' AND ticsellagt LIKE 'weh%' GROUP BY flightdate)

SELECT DISTINCT mlbtable.flightdate AS 代理人, tabPEKYNT.cnt AS 北京烟台, tabSHAYNT.cnt AS 上海烟台, tabHRBYNT.cnt AS 哈尔滨烟台, tabTNAYNT.cnt AS 济南烟台, tabCANYNT.cnt AS 广州烟台, tabSZXYNT.cnt AS 深圳烟台, tabSHEYNT.cnt AS 沈阳烟台, tabYNJYNT.cnt AS 延吉烟台, tabICNYNT.cnt AS 汉城烟台 FROM mlbtable 
LEFT JOIN  tabPEKYNT ON (tabPEKYNT.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSHAYNT ON (tabSHAYNT.flightdate = mlbtable.flightdate )
LEFT JOIN  tabHRBYNT ON (tabHRBYNT.flightdate = mlbtable.flightdate )
LEFT JOIN  tabTNAYNT ON (tabTNAYNT.flightdate = mlbtable.flightdate )
LEFT JOIN  tabCANYNT ON (tabCANYNT.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSZXYNT ON (tabSZXYNT.flightdate = mlbtable.flightdate )
LEFT JOIN  tabSHEYNT ON (tabSHEYNT.flightdate = mlbtable.flightdate )
LEFT JOIN  tabYNJYNT ON (tabYNJYNT.flightdate = mlbtable.flightdate )
LEFT JOIN  tabICNYNT ON (tabICNYNT.flightdate = mlbtable.flightdate )
WHERE mlbtable.flightdate LIKE '%%' ORDER BY mlbtable.flightdate
--END COMMAND
--END ALL

--BEGIN威海出港航班舱位销售统计表
--SELECT DISTINCT mlbtable.ticketcls AS 舱位, tabCA1828.cnt AS CA1828, tabCA1588.cnt AS CA1588,tabFM9258.cnt AS FM9258, tabMU2288.cnt AS MU2288, tabWEHCAN.cnt AS 威—穗, tabWEHHRB.cnt AS 威—哈, tabCANHRB.cnt AS 穗—哈, tabWEHTYN.cnt AS 威—原, tabWEHTNA.cnt AS 威—济, tabWEHDLC.cnt AS 威—连, tabCA147.cnt AS CA147, tabMU2017.cnt AS MU2017 FROM ((((((((((((mlbtable) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1828' GROUP BY ticketcls) AS tabCA1828) ON(tabCA1828.ticketcls =mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1588' GROUP BY ticketcls) AS tabCA1588) ON(tabCA1588.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9258' GROUP BY ticketcls) AS tabFM9258) ON(tabFM9258.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode ='MU2288' GROUP BY ticketcls) AS tabMU2288) ON(tabMU2288.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHCAN' GROUP BY ticketcls) AS tabWEHCAN) ON(tabWEHCAN.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHHRB' GROUP BY ticketcls) AS tabWEHHRB) ON(tabWEHHRB.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'CANHRB' and flightcode = 'CZ3787' GROUP BY ticketcls) AS tabCANHRB) ON(tabCANHRB.ticketcls = mlbtable.ticketcls))  LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHTYN' GROUP BY ticketcls) AS tabWEHTYN) ON(tabWEHTYN.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHTNA' GROUP BY ticketcls) AS tabWEHTNA) ON(tabWEHTNA.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHDLC' GROUP BY ticketcls) AS tabWEHDLC) ON(tabWEHDLC.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA147' GROUP BY ticketcls) AS tabCA147) ON(tabCA147.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2017'GROUP BY ticketcls) AS tabMU2017) ON(tabMU2017.ticketcls = mlbtable.ticketcls) WHERE mlbtable.ticketcls LIKE '%%' ORDER BY mlbtable.ticketcls
WITH  tabCA1828 AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1828' GROUP BY ticketcls)
, tabCA1588 AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1588' GROUP BY ticketcls)
, tabFM9258 AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9258' GROUP BY ticketcls)
, tabMU2288 AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode ='MU2288' GROUP BY ticketcls)
, tabWEHCAN AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHCAN' GROUP BY ticketcls)
, tabWEHHRB AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHHRB' GROUP BY ticketcls)
, tabCANHRB AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'CANHRB' and flightcode = 'CZ3787' GROUP BY ticketcls)
, tabWEHTYN AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHTYN' GROUP BY ticketcls)
, tabWEHTNA AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHTNA' GROUP BY ticketcls)
, tabWEHDLC AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE  fltsegment = 'WEHDLC' GROUP BY ticketcls)
, tabCA147 AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA147' GROUP BY ticketcls)
, tabMU2017 AS
(SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2017'GROUP BY ticketcls)

SELECT DISTINCT mlbtable.ticketcls AS 舱位, tabCA1828.cnt AS CA1828, tabCA1588.cnt AS CA1588,tabFM9258.cnt AS FM9258, tabMU2288.cnt AS MU2288, tabWEHCAN.cnt AS [威—穗], tabWEHHRB.cnt AS [威—哈], tabCANHRB.cnt AS [穗—哈], tabWEHTYN.cnt AS [威—原], tabWEHTNA.cnt AS [威—济], tabWEHDLC.cnt AS [威—连], tabCA147.cnt AS CA147, tabMU2017.cnt AS MU2017 FROM mlbtable 
LEFT JOIN  tabCA1828 ON (tabCA1828.ticketcls =mlbtable.ticketcls )
LEFT JOIN  tabCA1588 ON (tabCA1588.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabFM9258 ON (tabFM9258.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabMU2288 ON (tabMU2288.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabWEHCAN ON (tabWEHCAN.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabWEHHRB ON (tabWEHHRB.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabCANHRB ON (tabCANHRB.ticketcls = mlbtable.ticketcls  )
LEFT JOIN  tabWEHTYN ON (tabWEHTYN.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabWEHTNA ON (tabWEHTNA.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabWEHDLC ON (tabWEHDLC.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabCA147 ON (tabCA147.ticketcls = mlbtable.ticketcls )
LEFT JOIN  tabMU2017 ON (tabMU2017.ticketcls = mlbtable.ticketcls )
WHERE mlbtable.ticketcls LIKE '%%' ORDER BY mlbtable.ticketcls
--END COMMAND
--END ALL

--BEGIN威海进港航班舱位销售统计表
SELECT DISTINCT mlbtable.ticketcls AS [舱位], tabCA1827.cnt AS CA1827, tabCA1587.cnt AS CA1587,tabFM9257.cnt AS FM9257, tabMU2287.cnt AS MU2287, tabCANWEH.cnt AS [穗—威], tabHRBWEH.cnt AS [哈—威], tabHRBCAN.cnt AS [哈—穗], tabTYNWEH.cnt AS [原—威], tabTNAWEH.cnt AS [济—威], tabDLCWEH.cnt AS [连—威], tabCA148.cnt AS CA148, tabMU2018.cnt AS MU2018 FROM ((((((((((((mlbtable)  LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1827' GROUP BY ticketcls) AS tabCA1827) ON(tabCA1827.ticketcls =mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA1587' GROUP BY ticketcls) AS tabCA1587) ON(tabCA1587.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'FM9257' GROUP BY ticketcls) AS tabFM9257) ON(tabFM9257.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode ='MU2287' GROUP BY ticketcls) AS tabMU2287) ON(tabMU2287.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'CANWEH' GROUP BY ticketcls) AS tabCANWEH) ON(tabCANWEH.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'HRBWEH' GROUP BY ticketcls) AS tabHRBWEH) ON(tabHRBWEH.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'HRBCAN' and flightcode = 'CZ3788' GROUP BY ticketcls) AS tabHRBCAN) ON(tabHRBCAN.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TYNWEH' GROUP BY ticketcls) AS tabTYNWEH) ON(tabTYNWEH.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'TNAWEH' GROUP BY ticketcls) AS tabTNAWEH) ON(tabTNAWEH.ticketcls =mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE fltsegment = 'DLCWEH' GROUP BY ticketcls) AS tabDLCWEH) ON(tabDLCWEH.ticketcls =mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'CA148' GROUP BY ticketcls) AS tabCA148) ON(tabCA148.ticketcls = mlbtable.ticketcls)) LEFT JOIN ((SELECT ticketcls, COUNT(*) AS cnt FROM mlbtable WHERE flightcode = 'MU2018' GROUP BY ticketcls) AS tabMU2018) ON(tabMU2018.ticketcls = mlbtable.ticketcls) WHERE mlbtable.ticketcls LIKE '%%' ORDER BY mlbtable.ticketcls
--END COMMAND
--END ALL