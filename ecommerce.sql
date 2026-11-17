use ecommerce_sales;


#1.Display all records from the list_orders table.
select * from list_orders;

#2. Find all orders placed in Gujarat.
select * from list_orders where state="Gujarat";

#3. Display customers from the city of Mumbai.
select * from list_orders where city="Mumbai";

#4. Find all products belonging to the Furniture category.
select * from order_details where category="Furniture";

#5. Display products where the Amount is greater than 1,000.
select * from order_details where amount>1000;

#6. Find all records where Profit is negative.
select * from order_details where profit<0;

#7. Display the top 10 orders with the highest Amount.
select * from order_details order by amount desc
limit 10;

#8. Find the total sales amount.
select sum(target) as tot from sales_target;

#9. Calculate the total profit.
select sum(profit) as pf from order_details;

#10. Find the total quantity sold in each category.
select category,sum(quantity) as qy from order_details
group by category
order by qy desc;

#11.Find the average profit for each category.
select category,round(avg(quantity)) as avq from order_details
group by category
order by avq desc;

#12.Display the top 5 cities based on total sales.
select l.city,count(o.order_id) as total_sales from list_orders as l inner join order_details as o
on l.order_id=o.order_id
group by l.city
order by total_sales desc
limit 5;

#13.Find the most profitable sub-category.
select s_category,sum(profit) as tot_pf from order_details
group by s_category
order by tot_pf desc
limit 1;

#14.Count the total number of unique customers.
select count(distinct CustomerName) as tot_cust
from list_orders;

#15.Find all states where total profit is negative.
select l.state,sum(o.profit) as pf from list_orders as l inner join order_details as o
on l.order_id=o.order_id
group by l.state
having sum(o.profit)<0;

#16.Combine all three tables using appropriate JOIN conditions.
select * from list_orders as l inner join order_details as o 
on l.order_id=o.order_id
inner join sales_target as s 
on o.Category=s.Category;

#17.Find the total sales for each customer.
select l.CustomerName,sum(o.amount) as total_amt from list_orders as l
inner join order_details as o 
on l.order_id=o.order_id
group by l.CustomerName
order by total_amt desc;

#18.Find the maximum profit recorded.
select category, max(profit) as max_profit from order_details
group by category
order by max_profit desc;

#19.Find the minimum sales amount.
select category,min(amount) as min_amount from order_details
group by category
order by min_amount desc;

#20.Find categories where total sales exceed 50,000
SELECT category,sum(amount) as total_sales from order_details group by Category 
having sum(amount) > 50000
order by total_sales desc;

#21.Find states where total profit is greater than 5,000.
select l.State,sum(o.profit) as stat_pf from list_orders as l inner join order_details as o 
on l.order_id=o.order_id
group by l.state
having sum(o.profit)>5000
order by stat_pf desc;

#22.Find customers who have placed more than 5 orders.
select CustomerName,count(distinct order_id) as most_order from list_orders 
group by CustomerName 
having count(distinct order_id)>5
order by most_order desc;

#23.Create a view showing customers from the state of Madhya Pradesh.
create view mp_customers as 
select * from list_orders 
where state='Madhya Pradesh';
select * from mp_customers;

#24.Find the rank of each order based on Amount (highest first).
select order_id,amount,
rank() over(order by amount desc) as order_amt
from order_details;

#25.Find customers who placed orders in Mumbai.
select CustomerName,city from list_orders
where order_id in (
select order_id from list_orders where city='Mumbai');

#26.Find total profit for each category.
with cat_prof as (
select category,sum(profit) as tot_pf from order_details
group by category )
select * from cat_prof 
order by tot_pf desc; 
