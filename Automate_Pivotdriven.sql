

select * from HumanResources.Department
select GroupName, count(DepartmentID) from HumanResources.Department
group by GroupName


-- Create a table

IF OBJECT_ID('PivotDrivenReport_Excel') IS NOT NULL
DROP TABLE PivotDrivenReport_Excel

Create Table PivotDrivenReport_Excel
(
Demo_id Nvarchar(200),
Indicator Nvarchar(200),
[Location] Nvarchar(200),
Country Nvarchar(200),
[Time] NVarchar(200),
[Value] FLOAT,
[Flag Codes] Nvarchar(200),
Flags NVARCHAR(200)
)

-- Select * from PivotDrivenReport_Excel


-- Import the data

Bulk insert PivotDrivenReport_Excel
from 'C:\Users\15193\Desktop\Pivot_Driven\gdp_raw_data.csv'
with (FORMAT='CSV')

SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'PivotDrivenReport_Excel';

-- select * from dbo.PivotDrivenReport_Excel;

--Create a view - one off

-- Drop View GDP_Input

Create View GDP_Input As

Select a.*, b.gdp_per_capita from 
	(Select Country, [Time] as year_no, [Value] as gdp_value from PivotDrivenReport_Excel
	where Indicator = 'GDP (current US$)') a

	LEFT JOIN
	(Select Country, [Time] as year_no, [Value] as gdp_per_capita from PivotDrivenReport_Excel
	where Indicator = 'GDP per capita (current US$)') b
	ON a.Country = b.Country and a.year_no = b.year_no


-- Step 1. Create a stored procedure
-- drop procedure gdp_data

Create procedure gdp_data as

IF OBJECT_ID('PivotDrivenReport_Excel') IS NOT NULL
DROP TABLE PivotDrivenReport_Excel

Create Table PivotDrivenReport_Excel
(
Demo_id Nvarchar(200),
Indicator Nvarchar(200),
[Location] Nvarchar(200),
Country Nvarchar(200),
[Time] NVarchar(200),
[Value] FLOAT,
[Flag Codes] Nvarchar(200),
Flags NVARCHAR(200)
)

-- Select * from PivotDrivenReport_Excel

-- Import the data

Bulk insert PivotDrivenReport_Excel
from 'C:\Users\15193\Desktop\Pivot_Driven\gdp_raw_data.csv'
with (FORMAT='CSV')


-- exec gdp_data

-- Step 2. Schedule the procedure to run at a certain time using SQL server agent

--			Make sure to enable tcp/ip in SQL server network configuration

--			SQL srerver agent to start automatically


-- Step3. Create a job in SQl Seerver agent

-- Step4. Open excel and create connection 












