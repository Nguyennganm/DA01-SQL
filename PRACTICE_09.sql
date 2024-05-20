--1.
select * from SALES_DATASET_RFM_PRJ

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN ordernumber TYPE numeric USING (trim(ordernumber)::numeric)

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN quantityordered TYPE integer USING (quantityordered::integer)

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN priceeach TYPE numeric USING (trim(priceeach)::numeric)

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN orderlinenumber TYPE integer USING (orderlinenumber::integer)

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN sales TYPE numeric USING (trim(sales)::numeric)

SET datestyle = US, MDY;

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN orderdate TYPE timestamp with time zone 
USING (trim(orderdate)::timestamp with time zone)

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN sales TYPE numeric USING (trim(sales)::numeric)

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN status TYPE varchar

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN productline TYPE varchar

ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN productcode TYPE varchar
--2.
select ORDERNUMBER from SALES_DATASET_RFM_PRJ
where ORDERNUMBER is null

select QUANTITYORDERED from SALES_DATASET_RFM_PRJ
where QUANTITYORDERED is null

select PRICEEACH from SALES_DATASET_RFM_PRJ
where PRICEEACH is null

select ORDERLINENUMBER from SALES_DATASET_RFM_PRJ
where ORDERLINENUMBER is null

select SALES from SALES_DATASET_RFM_PRJ
where SALES is null

select ORDERDATE from SALES_DATASET_RFM_PRJ
where ORDERDATE is null

--3.
select * from SALES_DATASET_RFM_PRJ

ALTER TABLE SALES_DATASET_RFM_PRJ
ADD column CONTACTFIRSTNAME  VARCHAR(50)

UPDATE SALES_DATASET_RFM_PRJ 
SET CONTACTFIRSTNAME=SUBSTRING(contactfullname 
FROM 1 FOR POSITION('-'IN contactfullname)-1)

ALTER TABLE sales_dataset_rfm_prj 
ADD COLUMN contactlastname VARCHAR(50)
UPDATE sales_dataset_rfm_prj 
SET contactlastname=SUBSTRING(contactfullname FROM (POSITION ('-' IN contactfullname)+1) FOR LENGTH(contactfullname))

--4. 
ALTER TABLE sales_dataset_rfm_prj
ADD column QTR_ID VARCHAR(50)

UPDATE sales_dataset_rfm_prj
SET QTR_ID=EXTRACT(QUARTER FROM ORDERDATE)

ALTER TABLE sales_dataset_rfm_prj
ADD column MONTH_ID integer

UPDATE sales_dataset_rfm_prj
SET MONTH_ID= EXTRACT(MONTH FROM ORDERDATE)

ALTER TABLE sales_dataset_rfm_prj
ADD column YEAR_ID integer

UPDATE sales_dataset_rfm_prj
SET YEAR_ID= EXTRACT(YEAR FROM ORDERDATE)
--5.1
with twt_min_max_value as (
select Q1-1.5*IQR as min_value,
Q3+1.5*IQR as max_value
from(
select
percentile_cont (0.25) WITHIN GROUP (ORDER BY QUANTITYORDERED) AS Q1,
percentile_cont (0.75) WITHIN GROUP (ORDER BY QUANTITYORDERED) AS Q3,
percentile_cont (0.75) WITHIN GROUP (ORDER BY QUANTITYORDERED) -
percentile_cont (0.25) WITHIN GROUP (ORDER BY QUANTITYORDERED) AS IQR
from sales_dataset_rfm_prj) as a)
select * from sales_dataset_rfm_prj
where QUANTITYORDERED < (select min_value from twt_min_max_value)
or QUANTITYORDERED > (select max_value from twt_min_max_value)
--5.2
with cte as (
select orderdate,
QUANTITYORDERED,
(select avg(QUANTITYORDERED)
from sales_dataset_rfm_prj) as avg,
(select
stddev(QUANTITYORDERED)
from sales_dataset_rfm_prj)as stddev
from sales_dataset_rfm_prj),

twt_outlier as (
select orderdate, QUANTITYORDERED, (QUANTITYORDERED - avg)/stddev as z_score from cte
where abs((QUANTITYORDERED - avg)/stddev)>3) DELETE FROM sales_dataset_rfm_prj
where QUANTITYORDERED in (select QUANTITYORDERED from twt_outlier)

 
