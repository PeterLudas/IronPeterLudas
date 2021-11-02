# 1
SELECT a.first_name AS 'first name', a.last_name AS 'last name', count(f.actor_id) as movie_count
FROM film_actor as f
	INNER JOIN actor as a
		ON f.actor_id = a.actor_id
GROUP BY f.actor_id
ORDER BY count(f.actor_id)
LIMIT 1;
# 2 
SELECT c.first_name AS 'first name', c.last_name AS 'surname', count(r.rental_id) AS 'total number of rentals'
FROM customer AS c
	INNER JOIN rental AS r
		ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY count(r.rental_id) DESC LIMIT 1;
# 3
SELECT fc.category_id AS 'category ID', count(f.film_id) AS 'number of films'
FROM film_category AS fc
	RIGHT JOIN film AS f
		ON fc.film_id = f.film_id
GROUP BY fc.category_id
ORDER BY fc.category_id;
# 4
SELECT s.first_name AS 'first name', s.last_name AS 'surname', a.address
FROM staff AS s
	LEFT JOIN address AS a
		ON s.address_id = a.address_id
ORDER BY s.last_name;
# 5
SELECT sum(p.amount) AS 'August income', s.first_name AS 'First name', s.last_name AS 'Surname'
FROM payment AS p
	INNER JOIN staff AS s
		ON p.staff_id = s.staff_id
WHERE payment_date >= '2005-08-01 00:00:00' and payment_date <= '2005-08-31 23:59:59'
GROUP BY s.staff_id
ORDER BY payment_date; 
# 6
SELECT title AS 'Title', count(actor_id) AS 'number of actors'
FROM film AS f
	LEFT JOIN film_actor AS fa
		ON f.film_id = fa.film_id
GROUP BY f.title
ORDER BY f.title;
# 7
SELECT c.first_name AS 'first name', c.last_name AS 'surname', sum(p.amount) AS 'total fee paid'
FROM customer AS c
	RIGHT JOIN payment AS p
		ON c.customer_id = p.customer_id
GROUP BY c.customer_id
order BY c.last_name;
# bonus  
SELECT f.title, count(r.rental_id) 
FROM inventory AS i
	INNER JOIN rental as r
		ON i.inventory_id = r.inventory_id
	INNER JOIN film as f
		ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY count(r.rental_id) DESC
LIMIT 1;

# Multi-table joins
# 1 
SELECT s.store_id, a.address, ci.city, co.country
FROM address AS a
	INNER JOIN store AS s
		USING (address_id)
	INNER JOIN city AS ci
		USING (city_id)
	INNER JOIN country AS co
		USING (country_id);
# 2
SELECT store_id, sum(amount) AS 'total USD'
FROM store
	INNER JOIN staff
		USING (store_id)
	INNER JOIN payment
		USING (staff_id)
GROUP BY store_id;
# 3
SELECT c.name as Category, avg(f.length) AS 'average length'
FROM film_category
	INNER JOIN category AS c
		USING (category_id)
	INNER JOIN film AS f
		USING (film_id)
GROUP BY c.name
ORDER BY avg(f.length) DESC;
# 4
SELECT c.name AS category, max(f.length) AS 'max. length'
FROM film_category
	INNER JOIN category AS c
		USING (category_id)
	INNER JOIN film AS f
		USING (film_id)
GROUP BY c.name
ORDER BY max(f.length) DESC;
# 5
SELECT title AS 'title', count(rental_id) AS 'times rented'
FROM inventory
	INNER JOIN film
		USING (film_id)
	INNER JOIN rental
		USING (inventory_id)
GROUP BY title
ORDER BY count(rental_id) DESC;
# 6
SELECT name AS 'category', (sum(amount) - replacement_cost) AS 'total revenue'
FROM film
INNER JOIN film_category
		USING (film_id)
	INNER JOIN category
		USING (category_id)
	INNER JOIN inventory
		USING (film_id)
	INNER JOIN rental
		USING (inventory_id)
	INNER JOIN payment
		USING (rental_id)
GROUP BY name, replacement_cost
ORDER BY (sum(amount) - replacement_cost) desc;
# 7
SELECT store_id, title AS 'title', count(store_id) AS 'stock'
FROM store store
	LEFT JOIN inventory
		USING (store_id)
	LEFT JOIN film
		USING (film_id)
WHERE title = 'Academy Dinosaur' AND store_id = 1
GROUP BY title
ORDER BY store_id;

