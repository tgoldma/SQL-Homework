use sakila;

select * from actor;
/*1a*/
select first_name, last_name from actor;
/*2b*/
select concat(first_name,last_name) as "Actor Name" 
from actor;

select concat(first_name,' ',last_name) as "Actor Name"
from actor;

/*2a*/
select actor_id, first_name, last_name
from actor
where first_name = 'JOE';
/*2b*/
select * 
from actor
where last_name like '%GEN%';
/*2c*/
select last_name, first_name
from actor
where last_name like '%LI%';
/*2d*/
select country_id, country 
from country 
where country in ('Afghanistan', 'Bangladesh', 'China');
/*3a*/
alter table actor add description BLOB(100) not null;
/*3b*/
alter table actor drop description;
/*4a*/
select last_name, count(last_name)
from actor
group by last_name;
/*4b*/
select last_name, count(last_name)
from actor
group by last_name
having count(last_name) >= 2;

select * from actor;
/*4c*/
update actor 
set first_name = 'HARPO'
Where actor_id = 172;
/*4d*/
update actor 
set first_name = 'GROUCHO'
Where actor_id = 172;
/*5a*/
show create table address;

select * from staff;
select * from payment;
/*6a*/
select first_name, last_name, address, address2, district, postal_code
from staff
inner join address on staff.address_id = address.address_id;
/*6b*/
select first_name, last_name, sum(amount)
from staff
inner join payment on staff.staff_id = payment.staff_id
where payment_date between '2005-07-31 23:40:35' and '2006-02-14 15:16:03'
group by staff.first_name, staff.last_name;

select * from film_actor;
select * from film;
/*6c*/
select title, count(actor_id)
from film_actor
inner join film on film_actor.film_id = film.film_id
group by title;

select * from inventory;
/*6d*/
select film_id, count(film_id) 
from inventory
where film_id = '439';

select * from payment;
select * from customer;
/*6e*/
select last_name, first_name, sum(amount)
from payment
inner join customer on payment.customer_id = customer.customer_id
group by last_name, first_name;

select * from film;
select * from customer;
select * from language;
select * from film_actor;
select * from actor;
/*7a*/
SELECT title AS 'English Films with K or Q Titles' FROM  film 
WHERE 
	(title LIKE 'K%' OR title LIKE 'Q%')
	AND language_id in (SELECT language_id FROM language WHERE name = 'English');
/*7b*/
select first_name as 'Actors In', last_name as 'Alone Trip'
from actor
where actor_id in
(
	select actor_id
    from film_actor
    where film_id in
    (
    select film_id
    from film
    where title = "Alone Trip"
    )
);
select * from customer;
select * from country;
select * from address;
select * from store;
/*7c*/
select first_name, last_name, email, country
from customer c
join address a
on (c.address_id = a.address_id)
join city ci
on a.city_id = ci.city_id
join country co
on ci.country_id = co.country_id
where country = 'Canada';

select * from film;
select * from film_category;
select * from category;

/*7d*/
SELECT film_id, title, name 
FROM film
JOIN film_category 
ON film.film_id = film_category.film_id 
JOIN category 
ON film_category.category_id = category.category_id 
WHERE name = 'family';

/*7e*/

select * from film;
select * from inventory;
select * from rental;

SELECT title, COUNT(rental_id) AS 'How ManyTimes Rented' 
FROM film 
JOIN inventory 
ON film.film_id=inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY COUNT(rental_id) DESC;

/*7f*/

select * from payment;
select * from inventory;
select * from rental;

SELECT store_id, SUM(amount) 
FROM payment
JOIN rental
ON payment.rental_id=rental.rental_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
GROUP BY store_id;

/*7g*/
select * from inventory;
select * from city;
select * from country;
select * from store;
select * from address;

select store_id, city, country
from store
inner join address on store.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = city.country_id;

/*7h*/

select * from inventory;
select * from rental;
select * from payment;
select * from film_category;
select * from category;

SELECT name, sum(amount) AS 'Gross Revenue' 
FROM payment INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY sum(amount) DESC
LIMIT 5;

/*8a*/
create view top_5_categories as
SELECT name, sum(amount) AS 'Gross Revenue' 
FROM payment INNER JOIN rental ON payment.rental_id = rental.rental_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film_category ON inventory.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY category.category_id
ORDER BY sum(amount) DESC
LIMIT 5;

/*8b*/

select * from top_5_categories;

/*8c*/

drop view top_5_categories



















