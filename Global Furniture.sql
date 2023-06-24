--Start by analyzing the data

--Change dates date types(From datetime to date)

ALTER TABLE Global_Furniture..Orders
ALTER COLUMN [Order Date] DATE;

ALTER TABLE Global_Furniture..Orders
ALTER COLUMN [Ship Date] DATE;

--Create a new columns to determine the ship duration

SELECT [Order Date], [Ship Date], DATEDIFF(day, [Order Date], [Ship Date]) AS [Ship Duration]
FROM Global_Furniture..Orders;

-- Add a new column for ship duration
ALTER TABLE Global_Furniture..Orders
ADD [Ship Duration] INT;

-- Update the ship duration column with calculated values
UPDATE Global_Furniture..Orders
SET [Ship Duration] = DATEDIFF(day, [Order Date], [Ship Date]);


SELECT *
FROM Global_Furniture..Orders;

--Remove the Postal Code Column

ALTER TABLE Global_Furniture..Orders
DROP COLUMN [Postal Code];

--Add to the returns table Customer Name, State, Country, Category, Sub-Category, Product Name, Ship Duration

--First Alter the table

ALTER TABLE Global_Furniture..Returns
ADD [Customer Name] NVARCHAR(255) NULL,
    [State] NVARCHAR(255) NULL,
	[Country] NVARCHAR(255) NULL,
	[Sub-Category] NVARCHAR(255) NULL,
	[Product Name] NVARCHAR(255) NULL,
	[Ship Duration] INT NULL;

--Update it to match the data
--Then join them in their common column


UPDATE Global_Furniture..Returns
SET [Customer Name] = Orders.[Customer Name],
    [State] = Orders.[State],
    [Country] = Orders.[Country],
    [Sub-Category] = Orders.[Sub-Category],
    [Product Name] = Orders.[Product Name],
    [Ship Duration] = Orders.[Ship Duration]
FROM Global_Furniture..Returns
JOIN Global_Furniture..Orders ON Returns.[Order ID] = Orders.[Order ID];


SELECT *
FROM Global_Furniture..Returns
---------------------------------------------------------------------------------------------------------------------------
--Add to the Order table Rturned column

ALTER TABLE Global_Furniture..Orders
ADD [Returned] NVARCHAR(255) NULL;


UPDATE Global_Furniture..Orders
SET [Returned] = Returns.[Returned]
FROM Global_Furniture..Returns
JOIN Global_Furniture..Orders ON Returns.[Order ID] = Orders.[Order ID];
