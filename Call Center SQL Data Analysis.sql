--- Selecting and viewing all data from table ---
SELECT TOP 5 *
FROM call_center

--- Changing table name ---
EXEC sp_rename 'CallCenter', 'call_center';


--- Query to view datatypes in the table ---
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'call_center';

--- Changing the date column to date data type ---
ALTER TABLE call_center
ALTER COLUMN call_timestamp DATE;

SELECT * FROM call_center WHERE csat_score IS NULL

--- Query to set csat_score column to replace missing values to NULL --- 
UPDATE call_center
SET csat_score = NULL
WHERE csat_score IS NULL;

--- Count of num of rows and num of columns in table to generate table stats ---
SELECT COUNT(*) AS num_rows FROM call_center;
SELECT COUNT(*) AS num_columns 
FROM information_schema.columns
WHERE table_name = 'call_center';

--- checking for duplicate ids ---
SELECT id, COUNT(*) AS duplicate_count
FROM call_center
GROUP BY id
HAVING COUNT(*) > 1;

--- checking distinct values from columns ---
SELECT DISTINCT sentiment FROM call_center
SELECT DISTINCT reason FROM call_center
SELECT DISTINCT channel FROM call_center
SELECT DISTINCT response_time FROM call_center
SELECT DISTINCT call_center FROM call_center

---- Calculations ---
SELECT
  MIN([call duration in minutes]) AS min_duration,
  MAX([call duration in minutes]) AS max_duration,
  ROUND(AVG([call duration in minutes]),2) AS avg_duration
FROM call_center


SELECT
  MIN(csat_score) AS min_csat,
  MAX(csat_score) AS max_csat,
  ROUND(AVG(csat_score), 2) AS avg_csat
FROM call_center
WHERE csat_score <> 0;

SELECT call_center, response_time, COUNT(*) as num_count
FROM call_center 
GROUP BY call_center, response_time 
ORDER BY call_center,num_count DESC;

--- Call count of=n each day---
SELECT FORMAT(call_timestamp,'ddd') AS day_of_week,
COUNT(*) AS call_count
FROM call_center
GROUP BY FORMAT(call_timestamp,'ddd')
ORDER BY call_count DESC;

SELECT
  DATENAME(day,call_timestamp) AS call_day,
  MAX([call duration in minutes]) AS max_call_duration
FROM call_center
GROUP BY DATENAME(day,call_timestamp)
ORDER BY call_day;

--- to count and % from total of each distinct values in a column in call_center table ---
SELECT city,
  COUNT(*) AS count,
  COUNT(*) * 100.0 / (SELECT COUNT(*) FROM call_center) AS percentage
FROM call_center
GROUP BY city
ORDER BY count DESC;
