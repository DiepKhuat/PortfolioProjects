# Data Cleaning in SQL
## Project Overview
This project focuses on cleaning and standardizing a dataset using SQL queries. The goal is to ensure the data is in a usable format for further analysis. The SQL queries used for data cleaning are available on my [GitHub repository](https://github.com/DiepKhuat/PortfolioProjects/blob/main/Data%20Cleaning%20in%20SQL.sql).

## Data Source
The dataset used in this project includes property addresses and other related information. The data required cleaning to be standardized and made consistent.

## Tools and Technologies
- **SQL Server:** For data cleaning and querying.
- **GitHub:** For storing SQL queries and sharing project documentation.
## Data Cleaning Process
### 1. Standardizing Date Format
The `CONVERT` function was used to change or standardize the date format to ensure consistency across the dataset.

```sql
UPDATE dataset
SET date_column = CONVERT(varchar, date_column, 23);
```
### 2. Breaking Out Property Address
The `PropertyAddress` column was populated and then broken out into individual columns (address, city, state) using `SUBSTRING`, `CHARINDEX`, `PARSENAME`, and `REPLACE` functions.

```sql
UPDATE dataset
SET address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1),
    city = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, CHARINDEX(',', PropertyAddress, CHARINDEX(',', PropertyAddress) + 1) - CHARINDEX(',', PropertyAddress) - 1),
    state = PARSENAME(REPLACE(PropertyAddress, ',', '.'), 1);
```
### 3. Changing Y to Yes and N to No
The `CASE` statement was used to change values from 'Y' to 'Yes' and 'N' to 'No'.

```sql
UPDATE dataset
SET column_name = CASE 
    WHEN column_name = 'Y' THEN 'Yes'
    WHEN column_name = 'N' THEN 'No'
    ELSE column_name
END;
```
### 4. Removing Duplicates
Duplicates were removed using a `ROW_NUMBER`, `CTE`, and `WINDOW FUNCTION` of `PARTITION BY`.

```sql
WITH cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY unique_column ORDER BY unique_column) AS row_num
    FROM dataset
)
DELETE FROM cte
WHERE row_num > 1;
```
### 5. Deleting Useless Columns
Finally, a few useless columns were deleted from the dataset to streamline the data.

```sql
ALTER TABLE dataset
DROP COLUMN useless_column1, useless_column2;
```
### Conclusion
The data cleaning process ensured that the dataset was standardized, consistent, and ready for analysis. These steps are crucial in preparing data for meaningful insights and accurate results in subsequent analyses.

## Future Work
- **Automate Data Cleaning:** Develop scripts to automate the data cleaning process for future datasets.
- **Data Validation:** Implement checks to validate the integrity of the cleaned data.
- **Advanced Cleaning Techniques:** Explore more advanced data cleaning techniques to handle complex datasets.
