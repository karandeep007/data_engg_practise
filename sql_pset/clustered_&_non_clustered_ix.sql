/*
* Ref article : https://www.sqlshack.com/top-10-questions-answers-sql-server-indexes/
*/
--Clustered index
CREATE CLUSTERED INDEX [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] ON [Sales].[SalesOrderDetail]
(
	[SalesOrderID] ASC,
	[SalesOrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

--Non Clustered Index on repeating Product ID
CREATE NONCLUSTERED INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

--Disable an index
ALTER INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail]
DISABLE;  

--Enable / rebuild all indexes
ALTER INDEX ALL ON [Sales].[SalesOrderDetail]
REBUILD; 

--Query using non-clustered index during search on product ID
select * 
from [Sales].[SalesOrderDetail]
where ProductID = 755
