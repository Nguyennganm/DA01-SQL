--EX01:
with duplicate_jobs as 
(select company_id, title, description, count(job_id) as count_job
from job_listings
group by company_id, title, description
order by company_id)
select count(company_id) as duplicate_companies
from duplicate_jobs
where count_job > 1;
--EX02:
with category_appliance as 
(select case when category = 'appliance' then 'appliance' end as category ,
product, sum(spend) as total_spend
from product_spend
where extract(year from transaction_date)='2022'
group by category, product
order by category,sum(spend) desc
limit 2), category_electronics as
(select case when category = 'electronics' then 'electronics' end as category ,
product, sum(spend) as total_spend
from product_spend
where extract(year from transaction_date)='2022'
group by category, product
order by category,sum(spend) desc
limit 2)
select * from category_appliance union all select * from category_electronics ;
--EX03:
with holder_count as 
(SELECT policy_holder_id, count(case_id) as policy_holder
from callers
group by policy_holder_id
having count(case_id)>=3)
select count(policy_holder_id) as policy_holder_count from holder_count;
--EX04:
SELECT pages.page_id 
FROM pages
left join page_likes
on pages.page_id = page_likes.page_id 
where page_likes.liked_date is null
order by pages.page_id;
--EX05:

