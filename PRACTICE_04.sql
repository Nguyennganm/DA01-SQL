--EX01:
select sum(case when device_type ='laptop' then 1 else 0 end) as laptop_views, sum(case when device_type in ('phone','tablet') then 1 else 0 end) as mobile_views from viewership;
--EX02:
select x,y,z, case when (x+y)>z then 'Yes' else 'No' end as triangle from Triangle
--EX03:
select round(1.0*sum(case when call_category is null or call_category = 'n/a' then 1 else 0 end)/count(case_id)*100,1) as call_percentage from callers;
--EX04:
SELECT NAME FROM CUSTOMER WHERE REFEREE_ID <>2 OR REFEREE_ID IS NULL;
--EX05:
select survived, sum(case when pclass = 1 then 1 else 0 end) as first_class,
sum(case when pclass = 2 then 1 else 0 end) as second_class, 
sum(case when pclass = 3 then 1 else 0 end) as third_class from titanic 
group by survived; 
