 declare @total int
 declare @pageSize int
 declare @currentPage int
 
 set @pageSize = 10;
 set @currentPage  =1;
 --seelect @total = COUNT(*) from mlbtable
 exec mlb_GetAllData @total output, @pageSize, @currentPage
 
 print @total