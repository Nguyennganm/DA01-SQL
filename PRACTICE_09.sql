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

 
