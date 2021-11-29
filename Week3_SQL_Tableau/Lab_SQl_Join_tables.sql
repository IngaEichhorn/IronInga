#Lab | SQL Queries - Join Two Tables
use sakila;

#1. Which actor has appeared in the most films?
select a.first_name, a.last_name, a.actor_id, count(film_id) as number_films
from actor as a
inner join film_actor as fa
on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
order by number_films desc
limit 1;

#2. Most active customer (the customer that has rented the most number of films)
select r.rental_id, cust.customer_id, count(rental_id)  as Total_Rentals
from rental as r
inner join customer as cust
on r.customer_id = cust.customer_id
group by cust.customer_id
order by count(*) desc
limit 1;

#3. List number of films per category
select name as category_name, count(*) as num_films
from category as cat
inner join film_category as fc
on cat.category_id = fc.category_id
group by name
order by num_films desc;

#4. Display the first and last names, as well as the address, of each staff member.
select staff.first_name, staff.last_name, address.address
from address
inner join staff
on staff.address_id = address.address_id;

#5. Display the total amount rung up by each staff member in August of 2005.
select staff.first_name, staff.last_name, sum(payment.amount)
from staff
inner join payment
on staff.staff_id = payment.staff_id
where month(payment.payment_date) = 8 and year(payment.payment_date) = 2005
group by staff.staff_id; #without groupby just in staff member shown

#6. List each film and the number of actors who are listed for that film.
select film.title, count(film_actor.actor_id)
from film
inner join film_actor
on film.film_id = film_actor.film_id
group by film.film_id;

#7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
select customer.first_name, customer.last_name, sum(payment.amount) as 'total paid'
from customer
left join payment
on customer.customer_id = payment.customer_id
group by customer.customer_id
order by customer.last_name asc;

 #Bonus: Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. Give it a try.
 select film.title, count(rental.rental_id) as rent_count
 from film
 right join inventory
 on film.film_id = inventory.film_id
 left join rental
 on inventory.inventory_id = rental.inventory_id
 group by film.film_id
 order by rent_count desc;
 
 #Optional
 #1. Write a query to display for each store its store ID, city, and country.
 select store.store_id, city.city, country.country
 from store
 inner join address 
 on store.address_id = address.address_id
 inner join city
 on address.city_id = city.city_id
 inner join country
 on city.country_id = country.country_id
 group by store.store_id;
 
select distinct(store.store_id) from store;
#
select * from store;
