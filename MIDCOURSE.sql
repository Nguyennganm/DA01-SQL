--EX01:
select distinct film_id, title, replacement_cost
from film
group by film_id
order by replacement_cost
--EX02:
select
case when replacement_cost between 9.99 and 19.99 then 'low'
when replacement_cost between 20.00 and 24.99 then 'medium'
when replacement_cost between 25.00 and 29.99 then 'high'
end category, count(*) as so_luong
from film
group by category
--EX03:
select a.title, a.length, c.name as category_name
from film as a
inner join public.film_category as b
on a.film_id=b.film_id
inner join public.category as c
on b.category_id=c.category_id
where c.name in ('Drama','Sports')
order by a.length desc
--EX04:
select c.name as category_name,count(a.title) as so_luong
from film as a
inner join public.film_category as b
on a.film_id=b.film_id
inner join public.category as c
on b.category_id=c.category_id
group by c.name
order by so_luong desc
--EX05:
select a.first_name, a.last_name, count(b.film_id) as so_luong
from public.actor as a
inner join public.film_actor as b
on a.actor_id=b.actor_id
group by a.first_name, a.last_name
order by so_luong desc
--EX06:
select count(*)
from public.address as a
left join public.customer as b
on a.address_id=b.address_id
where b.customer_id is null
--EX07:
select a.city, sum(d.amount)
from public.city as a
join public.address as b
on a.city_id=b.city_id
join public.customer as c
on b.address_id=c.address_id
join public.payment as d
on c.customer_id=d.customer_id
group by a.city
order by sum(d.amount) desc
--EX08:
select concat(a.city,', ',e.country), sum(d.amount)
from public.city as a
join public.address as b on a.city_id=b.city_id
join public.customer as c on b.address_id=c.address_id
join public.payment as d on c.customer_id=d.customer_id
join public.country as e on a.country_id=e.country_id
group by concat(a.city,', ',e.country)
order by sum(d.amount) desc
