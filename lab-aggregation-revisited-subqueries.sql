use sakila;

-- Select the first name, last name, and email address of all the customers who have rented a movie.

select distinct c.first_name, c.last_name, c.email from rental r
join customer c on r.customer_id = c.customer_id
order by r.customer_id;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select p.customer_id, concat(c.first_name, ' ', c.last_name) customer_name, avg(p.amount) avg_payment from payment p
join customer c on p.customer_id = c.customer_id
group by p.customer_id
order by p.customer_id;

/* Select the name and email address of all the customers who have rented the "Action" movies.*/
-- Write the query using multiple join statements.
select distinct concat(c.first_name, ' ', c.last_name) customer_name, c.email from rental r
join customer c on r.customer_id = c.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category cat on fc.category_id = cat.category_id
where cat.name = 'Action'
order by r.customer_id;

-- Write the query using sub queries with multiple WHERE clause and IN condition.
select distinct concat(first_name, ' ', last_name) customer_name, email from customer
where customer_id in (
	select customer_id from rental
    where inventory_id in (
    	select inventory_id from inventory 
		where film_id in (
			select film_id from film_category
            where category_id in (
				select category_id from category
                where name = 'Action'
)))) order by customer_id;

/* Use the case statement to create a new column classifying existing columns as either or high value transactions 
based on the amount of payment. 
If the amount is between 0 and 2, label should be low. 
If the amount is between 2 and 4, the label should be medium. 
If it is more than 4, then it should be high.*/

select *,
case
	when amount < 2 then 'Low'
    when amount between 2 and 4 then 'Medium'
    when amount > 4 then 'high'
end value_trans
from payment;