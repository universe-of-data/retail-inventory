-- Create the Sales Transactions table
CREATE TABLE [SourceSalesTransactions] (
    TransactionID INT PRIMARY KEY,
    CustomerID INT,
    ProductID VARCHAR(10),
    Quantity INT,
    Timestamp DATETIME
);

-- Insert random data into the Sales Transactions table
DECLARE @i INT = 1;
WHILE @i <= 700
BEGIN
    INSERT INTO [SourceSalesTransactions] (TransactionID, CustomerID, ProductID, Quantity, Timestamp)
    VALUES (
        @i, -- TransactionID
        ABS(CHECKSUM(NEWID())) % 100 + 100, -- CustomerID
        'P' + RIGHT('00' + CAST((ABS(CHECKSUM(NEWID())) % 10 + 1) AS VARCHAR), 3), -- ProductID
        ABS(CHECKSUM(NEWID())) % 10 + 1, -- Quantity
        DATEADD(MINUTE, (ABS(CHECKSUM(NEWID())) % 1440), '2024-06-01') -- Timestamp
    );
    SET @i = @i + 1;
END;


SELECT COUNT(*) FROM [SourceSalesTransactions]; 
SELECT * FROM [SourceSalesTransactions];
