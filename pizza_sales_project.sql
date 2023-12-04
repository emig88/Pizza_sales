select sum(quantity) / count(distinct order_id) as avg_pizza_orders
from pizza_sales

set sql_safe_updates = 0

update pizza_sales 
set order_date = Case 
	when order_date like '%/%' then date_format(
	str_to_date(order_date,'%d/%m/%Y'),'%Y-%m-%d')
	when order_date like '%-%' then date_format(
	str_to_date(order_date,'%d-%m-%Y'),'%Y-%m-%d')
	else null
	end;

select order_date from pizza_sales;

alter table pizza_sales
modify column order_date DATE;

select dayname(order_date), count(distinct order_id) as total_orders
from pizza_sales
group by dayname(order_date) 



select monthname(order_date) as month,
count(distinct order_id) as total_orders
from pizza_sales
group by monthname(order_date)
order by total_orders desc 


select  pizza_category,
		round(sum(total_price),2) as sales,
		
        sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as total_sales
from pizza_sales
group by pizza_category 


select  pizza_size,
		round(sum(total_price),2) as sales,
		
        cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal (10,2 )) as total_sales
from pizza_sales
group by pizza_size


select name,
	   revenue,
	   dense_rank() over(order by revenue desc) as top_5
from(

select pizza_name as name,
	   sum(total_price) as revenue
from pizza_sales
group by name)
 t
limit 5


select name,
	   revenue,
	   dense_rank() over(order by revenue asc) as top_5
from(

select pizza_name as name,
	   sum(total_price) as revenue
from pizza_sales
group by name)t
limit 5



select name,
	   total_q,
	   dense_rank() over(order by total_q asc) as top_5
from(

select pizza_name as name,
	   count(distinct order_id) as total_q
from pizza_sales
group by name)
 t
limit 5

select name,
	   total_q,
	   dense_rank() over(order by total_q desc) as top_5
from(

select pizza_name as name,
	   count(distinct order_id) as total_q
from pizza_sales
group by name)t


