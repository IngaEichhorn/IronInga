#Lab | SQL Subqueries
use sakila;

#1. How many copies of the film Hunchback Impossible exist in the inventory system?
select count(film_id) as counts from inventory
where film_id = (
select film_id from sakila.film
where title = 'Hunchback Impossible'
);

#2. List all films whose length is longer than the average of all the films.
select title, length from film
where film.length > (
select avg(film.length) from film
)
order by film.length desc;

#3. Use subqueries to display all actors who appear in the film Alone Trip.
select concat(first_name,' ',last_name) as actor_name from actor
where actor.actor_id in (
select actor.actor_id from film_actor
where film_actor.film_id = (
select film.film_id from film
where film.title = 'Alone Trip'
));

#4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select film.title from film 
where film.film_id in (
select film_category.film_id from film_category
where film_category.category_id in (
select category.category_id from category
where name = 'family'
));

#5. Get name and email from customers from Canada using subqueries. Do the same with joins.
# Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

#subqueriess
select concat(customer.first_name,' ', customer.last_name) as name, customer.email from customer
where customer.address_id in (
select address.address_id from address
where address.city_id in (
select city.city_id from city
where city.country_id in (
select country.country_id from country 
where country = 'canada'
)));

#join
select concat(customer.first_name,' ', customer.last_name) as name, customer.email
from customer
inner join address
using (address_id)
inner join city
using (city_id)
inner join country
using (country_id)
where country = 'canada';


#6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
#First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

#child query aka most prolific actor (from join excerise):
select actor.actor_id    #here only one column as singlöe output is expected in parent query, see below
from actor
inner join film_actor
using (actor_id)
group by actor.actor_id
order by count(film_id) desc
limit 1;

#full query
select concat(actor.first_name, ' ', actor.last_name) as name, film.title
from actor
inner join film_actor
using (actor_id)
inner join film
using (film_id)
where actor_id=(
select actor.actor_id
from actor
inner join film_actor
using (actor_id)
group by actor.actor_id
order by count(film_id) desc
limit 1
);

#7. Films rented by most profitable customer.
#You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

#child query aka most profitable customer:
select customer.customer_id
from customer
inner join payment
using (customer_id)
group by customer.customer_id
order by sum(amount) desc
limit 1;

#full query:
select film.title, rental.rental_date  from film
inner join inventory
using (film_id)
inner join rental
using (inventory_id)
inner join payment
using (rental_id) 
where rental.customer_id=(
select customer.customer_id
from customer
inner join payment
using (customer_id)
group by customer.customer_id
order by sum(amount) desc
limit 1
)
order by rental.rental_date;


#8. Customers who spent more than the average payments.
select concat(customer.first_name, ' ', customer.last_name) as customer_name, sum(amount) as total_payment
from customer
inner join payment
using (customer_id)
group by customer_name
having sum(amount) > (    ####HAVING is a filter on grouped filter (it needs group by), while WHERE is used on data before group by
select avg(total_payment)
from (
select customer_name, sum(amount) as total_payment
from payment
group by customer_id
) as sub1)
order by total_payment desc;
