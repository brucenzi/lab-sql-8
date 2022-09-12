use sakila;

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column).
	-- Select only columns title, length and rank in your output.

select * from film;
select title, length, rank() over(order by length desc) as "rank"
from film where length is not null; 


-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
	-- In your output, only select the columns title, length, rating and rank.

select * from film;
select title, length, rating, rank() over(order by length desc, rating desc) as "rank"
from film where length is not null;     
    
-- 3. How many films are there for each of the categories in the category table? 

select * from category;
select * from film_category;

select c.name, fc.film_id from film_category fc
left join category c
on c.category_id = fc.category_id
group by c.name; 

-- 4. Which actor has appeared in the most films? 

select * from actor;
select * from film_actor;

select a.actor_id, concat(a.first_name," ",a.last_name) as "Actors", count(film_id) as "Film Appearences" from film_actor f
left join actor a
on a.actor_id = f.actor_id
group by a.actor_id
order by count(f.film_id) desc; -- first of the list is the actor that appeared the most ("Gina Degeneres")

-- 5. Which is the most active customer (the customer that has rented the most number of films)? 
    
select * from customer;
select * from rental;   

select c.customer_id, concat(c.first_name," ",c.last_name) as "Customers", count(r.rental_id) as "Number of Rentals" from rental r
left join customer c
on c.customer_id = r.customer_id
group by c.customer_id
order by count(r.rental_id) desc; -- first of the list is the most active customer ("Eleanor Hunt")

-- 6. Bonus: Which is the most rented film?

select * from film;
select * from rental;
select * from inventory;

select f.film_id, f.title, count(r.rental_id) as "Number of Movie Rentals" from rental r
left join inventory i
on i.inventory_id = r.inventory_id
left join film f
on f.film_id = i.film_id
group by f.film_id
order by count(r.rental_id) desc; -- first of the list is the most rented film ("Bucket Brotherhood")
