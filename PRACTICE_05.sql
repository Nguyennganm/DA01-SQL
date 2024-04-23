--EX01:
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) FROM CITY AS CITY JOIN COUNTRY AS COUNTRY ON CITY.COUNTRYCODE=COUNTRY.CODE GROUP BY COUNTRY.Continent;
--EX02:
SELECT round(sum(case when texts.signup_action = 'Confirmed' then 1 else 0 end)*1.00/count(texts.signup_action),2) as confirm_rate FROM emails JOIN texts ON emails.email_id=texts.email_id;
--EX03:
SELECT age_breakdown.age_bucket,
ROUND(100*SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END)/SUM(activities.time_spent),2) AS send_perc,
ROUND(100*SUM(CASE WHEN activity_type ='open' THEN time_spent ELSE 0 END) /SUM(activities.time_spent),2) AS open_perc
FROM activities JOIN age_breakdown 
ON activities.user_id=age_breakdown.user_id
WHERE activities.activity_type IN ('send','open')
GROUP BY age_breakdown.age_bucket;
--EX04:
SELECT customer_id
FROM customer_contracts AS A
JOIN products AS B
ON A.product_id=B.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category) FROM products)
ORDER BY customer_id;
--EX05:
select E.reports_to as employee_id , M.name, count(E.reports_to) as reports_count, round(avg(E.age),0) as average_age
from Employees as E join Employees as M on E.reports_to=M.employee_id
group by E.reports_to
order by E.reports_to;
--EX06:
select Products.product_name, sum(Orders.unit) as unit
from Products join Orders on Products.product_id=Orders.product_id
where Orders.order_date between '2020-02-01' and '2020-02-29'
group by product_name
having sum(Orders.unit)>=100;
--EX07:
SELECT pages.page_id 
FROM pages
left join page_likes
on pages.page_id = page_likes.page_id 
where page_likes.liked_date is null
order by pages.page_id;
