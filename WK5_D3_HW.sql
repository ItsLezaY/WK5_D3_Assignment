-------------------------------WK5 D3 Homework Assignment-------------------------------


-- 1. List all customers who live in Texas (use JOINs)

SELECT first_name, last_name, address, city, country
FROM address
INNER JOIN customer
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE district = 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full Name

SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;


-- 3. Show all customers names who have made payments over $175(use subqueries)

SELECT store_id, first_name, last_name,
(
	SELECT SUM(amount)
	FROM payment
	WHERE payment.customer_id = customer.customer_id
	GROUP BY payment.customer_id
	HAVING SUM(amount) > 175
) AS payments_over_175
FROM customer
WHERE customer.customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
)
ORDER BY payments_over_175 DESC;


-- 4. List all customers that live in Nepal (use the city table)

SELECT first_name, last_name, address, city, country
FROM address
INNER JOIN customer
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';


-- 5. Which staff member had the most transactions?

SELECT first_name, last_name, 
COUNT(payment.payment_id) AS transaction_count
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id, first_name, last_name
ORDER BY transaction_count DESC
LIMIT 1;


-- 6. How many movies of each rating are there?

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating
ORDER BY rating;


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING COUNT(payment_id) = 1
);


-- 8. How many free rentals did our stores give away?

SELECT COUNT(*) AS free_rentals
FROM rental
JOIN payment
ON rental.rental_id = payment.rental_id
WHERE payment.amount = 0;

