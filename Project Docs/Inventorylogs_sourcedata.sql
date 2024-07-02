
-- Check if the table exists and drop it if it does
IF EXISTS (SELECT * FROM sys.tables WHERE name = 'InventoryLogs' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    DROP TABLE [InventoryLogs];
END

-- Create the InventoryLogs table with distribution and indexing
CREATE TABLE InventoryLogs (
    LogID INT,
    ProductID VARCHAR(10),
    Action VARCHAR(20),
    Quantity INT,
    [Date] DATE
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN
);














-- Variables for random data generation
DECLARE @i INT = 1;
DECLARE @productIDs VARCHAR(30) = 'P001,P002,P003'; -- Sample product IDs
DECLARE @actions VARCHAR(20) = 'Received,Sold';
DECLARE @startDate DATE = '2024-01-01'; -- Start date for random date generation
DECLARE @endDate DATE = '2024-06-30';   -- End date for random date generation

SET @i = 1; -- Initialize @i variable

-- Generate random sample data
WHILE @i <= 700
BEGIN
    INSERT INTO InventoryLogs (LogID, ProductID, Action, Quantity, [Date])
    SELECT
        @i,
        PARSENAME(REPLACE(@productIDs, ',', '.'), ROUND(RAND() * 2 + 1, 0)),
        PARSENAME(REPLACE(@actions, ',', '.'), ROUND(RAND() * 1 + 1, 0)),
        CAST(RAND() * 10 + 1 AS INT), -- Random quantity between 1 and 10
        DATEADD(day, CAST(RAND() * DATEDIFF(day, @startDate, @endDate) AS INT), @startDate) -- Random date between @startDate and @endDate

    SET @i = @i + 1;
END


-- Create a clustered columnstore index
CREATE CLUSTERED COLUMNSTORE INDEX [IndexInventoryLogs] 
ON [InventoryLogs];



SELECT count(*) FROM InventoryLogs;
SELECT * FROM InventoryLogs;


-- Drop the index before dropping the table
DROP INDEX ClusteredIndex_85f2017eecc64ed4b3c8c99118ef7ff4 ON [InventoryLogs];

-- Drop the table
DROP TABLE [InventoryLogs];
