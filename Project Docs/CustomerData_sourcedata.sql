-- Create the CustomerData table
CREATE TABLE CustomerData (
    CustomerID INT,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    PurchaseHistory VARCHAR(100),
    Preferences VARCHAR(100)
);


-- Create a stored procedure to generate random data
CREATE PROCEDURE GenerateRandomData()
BEGIN
    DECLARE counter INT DEFAULT 1;

    WHILE counter <= 100 DO
        INSERT INTO CustomerData (CustomerID, Name, Age, Gender, PurchaseHistory, Preferences)
        VALUES (
            counter,
            CONCAT('Customer', CAST(counter AS CHAR(10))),
            ROUND(RAND() * 50 + 20),
            IF(RAND() < 0.5, 'Male', 'Female'),
            CONCAT('Product', CHAR(65 + ROUND(RAND() * 25)), ', Product', CHAR(65 + ROUND(RAND() * 25))),
            CONCAT('Category', CHAR(65 + ROUND(RAND() * 25)), ', Category', CHAR(65 + ROUND(RAND() * 25)))
        );

        SET counter = counter + 1;
    END WHILE;
END;


CALL GenerateRandomData();

CREATE CLUSTERED COLUMNSTORE INDEX [IndexCustomerData] ON [CustomerData];

-- Output the generated customerdata
SELECT * FROM CustomerData;

-- Drop the table
DROP TABLE CustomerData;
