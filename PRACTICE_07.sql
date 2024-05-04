--EX01:
SELECT extract(year from transaction_date) as year,
product_id, 
spend as curr_year_spend,
lag(spend) OVER(PARTITION BY product_id order by transaction_date)
as prev_year_spend, 
round((spend
-lag(spend) OVER(PARTITION BY product_id order by transaction_date))*100/
lag(spend) OVER(PARTITION BY product_id order by transaction_date),2)
as yoy_rate
FROM user_transactions;
--EX02:
SELECT distinct card_name,
first_value (issued_amount) over (partition by card_name 
order by issue_year,issue_month)
FROM monthly_cards_issued
order by first_value (issued_amount) over (partition by card_name 
order by issue_year,issue_month) desc;
--EX03:
with a as 
(SELECT user_id,spend,transaction_date, 
row_number() over(partition by user_id order by transaction_date)
FROM transactions
group by user_id,spend,transaction_date)
select user_id,spend,transaction_date
from a where row_number = 3;
--EX04:
with cte as 
(SELECT product_id, user_id, spend, transaction_date,
 MAX(transaction_date) OVER(PARTITION by user_id) 
 FROM user_transactions)
SELECT transaction_date, user_id, COUNT(product_id) AS purchase_count
FROM cte 
WHERE transaction_date=max
GROUP BY transaction_date, user_id;
--EX 05:
with cte as
(SELECT user_id, tweet_date,tweet_count,
lag(tweet_count) over(partition by user_id order by tweet_date) as pre_tweet_date1,
lag(tweet_count,2) over(partition by user_id order by tweet_date) as pre_tweet_date2
from tweets)
select user_id, tweet_date, 
 CASE 
  WHEN pre_tweet_date1 IS NULL AND pre_tweet_date2 IS NULL THEN ROUND(tweet_count, 2)
  WHEN pre_tweet_date1 IS NULL THEN ROUND((pre_tweet_date2 + tweet_count) / 2.0, 2)
  WHEN pre_tweet_date2 IS NULL THEN ROUND((pre_tweet_date1 + tweet_count) / 2.0, 2)
  ELSE ROUND((pre_tweet_date1 + pre_tweet_date2 + tweet_count) / 3.0, 2)
  END as rolling_avg_3d
from cte
order by user_id;
--EX06:
with cte as 
(SELECT transaction_id, merchant_id, credit_card_id, amount, 
transaction_timestamp, LAG(transaction_timestamp)
OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp)
AS previous_transaction, EXTRACT(EPOCH from (transaction_timestamp -
LAG(transaction_timestamp)
OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp)))/60
AS minute_difference
FROM transactions)
select COUNT(merchant_id) AS payment_count
FROM cte 
WHERE minute_difference <= 10;
--EX07:
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
--EX08:
with compute_rankings_cte as (
select a.artist_name,
Dense_Rank() over (ORDER BY COUNT(s.song_id) DESC) as rnk
from global_song_rank gsk
inner join 
songs s on
gsk.song_id=s.song_id
inner join 
artists a on
a.artist_id=s.artist_id
where gsk.rank<=10
group by a.artist_name)
select compute_rankings_cte.artist_name, 
compute_rankings_cte.rnk as artist_rank
from compute_rankings_cte
where compute_rankings_cte.rnk<=5;
