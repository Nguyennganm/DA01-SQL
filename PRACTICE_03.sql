--EX01:
SELECT NAME FROM STUDENTS WHERE MARKS >75 ORDER BY RIGHT(NAME,3),ID;
--EX02:
select user_id, concat(upper(left(name,1)),lower(right(name,length(name)-1))) as name From users order by user_id;
--EX03:
select manufacturer, concat('$',round(sum(total_sales/1000000),0),' ','milion') as sale from pharmacy_sales group by manufacturer order by sum(total_sales) DESC, manufacturer;
--EX04:
select extract(month from submit_date) as mth, product_id as product, round(avg(stars),2) as avg_stars from reviews group by mth, product order by mth, product;
--EX05:
SELECT sender_id, count(message_id) as message_count FROM messages where extract(month from sent_date)=8 and EXTRACT(YEAR FROM sent_date)=2022 group by sender_id ORDER BY message_count DESC limit 2;
--EX06;
select tweet_id from Tweets where length(content) > 15;
--EX08:
select count(id) AS employees_hired from employees where extract(month from joining_date) between 01 and 07 and extract(year from joining_date)=2022;
--EX09:
select position('a'in first_name) as position from worker where first_name = 'Amitah';
--EX10:
select substring(title, length(winery)+2,4) from winemag_p2 where country = 'Macedonia';
