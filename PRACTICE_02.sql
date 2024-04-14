--EX1:
select distinct city from station where MOD(ID,2) = 0;
--EX2:
select count (city) - count(distinct city) from station;
--EX3:

--EX4:
SELECT ROUND(cast(SUM(item_count*order_occurrences)/SUM(order_occurrences) as DECIMAL),1) AS mean FROM items_per_order;
--EX5:
SELECT candidate_id FROM candidates WHERE SKILL IN('Python','Tableau','PostgreSQL') GROUP BY candidate_id HAVING COUNT(SKILL)=3;
--EX6:
SELECT user_id, DATE(max(post_date)) - DATE(min(post_date)) as days_between FROM posts WHERE post_date>='2021-01-01' AND post_date<'2022-01-01' GROUP BY user_id HAVING COUNT(post_id)>=2;
--EX7:
SELECT card_name, max(issued_amount) - min(issued_amount) AS difference FROM monthly_cards_issued group by card_name order by difference desc;
--EX8:
SELECT manufacturer, count(drug) as drug_count, ABS(sum(cogs-total_sales)) as total_loss FROM pharmacy_sales where total_sales<cogs group by manufacturer order by total_loss DESC;
--EX9:
select * from cinema where id%2=1 and description <> 'boring' order by rating desc;
--EX10:
select teacher_id, count(distinct subject_id) as cnt from teacher group by teacher_id;
--EX11:
select user_id, count(follower_id) as followers_count from followers group by user_id order by user_id;
--EX12:
select class from Courses group by class having count(student) >=5;
