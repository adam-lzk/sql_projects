-- Math operations

SELECT product_id, product_name, unit_price
FROM products;

SELECT product_id, product_name, unit_price * units_in_stock
FROM products;

SELECT order_id, shipped_date - order_date
FROM orders;  -- math operations



-- DISTINCT

SELECT country
FROM employees;

SELECT DISTINCT country
FROM employees;  -- get only distinct (different) values (like set in c++)



SELECT city, country
FROM employees;

SELECT DISTINCT city, country
FROM employees;  -- get only distinct pair city:country



-- COUNT

SELECT *
FROM employees;

SELECT COUNT(*)
FROM employees;  -- get the number of rows in table employees

SELECT COUNT (DISTINCT country)
FROM employees;  -- get the number of different values of column country of table employees



-- WHERE

SELECT company_name, contact_name, phone
FROM customers
WHERE country = 'USA';

SELECT COUNT(*)
FROM products
WHERE unit_price > 20;

SELECT *
FROM customers
WhERE city != 'Berlin';

SELECT *
FROM orders
WHERE order_date > '1998-03-01';

SELECT *
FROM products
WHERE unit_price > 25 AND units_in_stock > 40;

SELECT *
FROM orders
WHERE shipped_date > '1998-04-30' AND (freight < 75 OR freight > 150);

SELECT COUNT (*)
FROM orders
WHERE freight BETWEEN 20 AND 40;  -- the same as WHERE freight >= 20 AND freight <= 40



SELECT *
FROM customers
WHERE country = 'Mexico' OR country = 'Germany' OR country = 'USA' OR country = 'Canada';

SELECT *
FROM customers
WHERE country IN ('Mexico', 'Germany', 'USA', 'Canada');  -- the same as previous request

SELECT *
FROM customers
WHERE country NOT IN ('Mexico', 'Germany', 'USA', 'Canada');



-- ORDER BY

SELECT DISTINCT country
FROM customers
ORDER BY country ASC;  -- ascending is the default

SELECT DISTINCT country
FROM customers
ORDER BY country DESC;

SELECT DISTINCT country, city
FROM customers
ORDER BY country DESC, city ASC;




-- MIN, MAX, AVG

SELECT ship_city, order_date
FROM orders
WHERE ship_city = 'London'
ORDER BY order_date;

SELECT MIN(order_date)
FROM orders
WHERE ship_city = 'London';

SELECT AVG(unit_price)
FROM products
WHERE discontinued != 1;

SELECT SUM(units_in_stock)
FROM products
WHERE discontinued != 1;



-- LIKE
-- % - 0, 1 or more characters
-- _ - only one character

SELECT last_name, first_name
FROM employees
WHERE first_name LIKE '%n';  -- 0, 1 or more characters at the beginning and the letter 'n' at the end

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'S%';

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE '_e%';



-- LIMIT

SELECT product_name, unit_price
FROM products;

SELECT product_name, unit_price
FROM products
LIMIT 10;

SELECT product_name, unit_price
FROM products
WHERE discontinued != 1
ORDER BY unit_price DESC
LIMIT 10;



-- IS NULL

SELECT *
FROM orders;

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NULL;

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NOT NULL;



-- GROUP BY

SELECT ship_country, COUNT (*)
FROM orders
WHERE freight > 50
GROUP BY ship_country;

SELECT ship_country, COUNT (*)
FROM orders
WHERE freight > 50
GROUP BY ship_country
ORDER BY COUNT (*) ASC;



SELECT category_id, SUM (units_in_stock)
FROM products
GROUP BY category_id
ORDER BY SUM (units_in_stock) DESC;



-- HAVING
-- WHERE - primary filter,  HAVING - secondary filter

SELECT category_id, SUM(unit_price * units_in_stock)
FROM products
WHERE discontinued != 1
GROUP BY category_id
ORDER BY SUM(unit_price * units_in_stock);

SELECT category_id, SUM(unit_price * units_in_stock)
FROM products
WHERE discontinued != 1
GROUP BY category_id
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY SUM(unit_price * units_in_stock);



-- UNION, INTERSECT, EXCEPT

SELECT country
FROM customers;

SELECT country
FROM employees;

SELECT country
FROM customers
UNION
SELECT country
FROM employees;  -- UNION eliminates duplicates (A or B) (DISTINCT)

SELECT country
FROM customers
UNION ALL
SELECT country
FROM employees;  -- doesn't eliminate duplicates (not DISTINCT)



SELECT country
FROM customers;

SELECT country
FROM suppliers;

SELECT country
FROM customers
INTERSECT
SELECT country
FROM suppliers;  -- A and B (DISTINCT)



SELECT country
FROM customers;

SELECT country
FROM suppliers;

SELECT country
FROM customers
EXCEPT
SELECT country
FROM suppliers;  -- A without B (DISTINCT)

SELECT country
FROM customers
EXCEPT ALL
SELECT country
FROM suppliers;



-- INNER JOIN

SELECT product_name, suppliers.company_name, units_in_stock
FROM products
INNER JOIN suppliers ON products.supplier_id = suppliers.supplier_id;



SELECT order_id, customer_id, first_name, last_name, title
FROM orders
INNER JOIN employees ON orders.employee_id = employees.employee_id;



SELECT category_name, SUM (units_in_stock)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY category_name
ORDER BY SUM (units_in_stock) DESC;



SELECT category_name, SUM(unit_price * units_in_stock)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
WHERE discontinued != 1
GROUP BY category_name
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY SUM (unit_price * units_in_stock) DESC;



SELECT order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id;



SELECT contact_name, company_name, phone, first_name, last_name, title,
	   order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
JOIN order_details ON orders.order_id = order_details.order_id  -- the same as INNER JOIN
INNER JOIN products ON order_details.product_id = products.product_id
JOIN customers ON orders.customer_id = customers.customer_id
JOIN employees ON orders. employee_id = employees. employee_id
WHERE ship_country = 'USA';



-- LEFT JOIN

SELECT company_name, product_name
FROM suppliers
LEFT JOIN products ON suppliers.supplier_id = products.supplier_id;



SELECT company_name, order_id
FROM customers
JOIN orders ON orders.customer_id = customers. customer_id
WHERE order_id IS NULL;

SELECT company_name, order_id
FROM customers
LEFT JOIN orders ON orders.customer_id = customers. customer_id
WHERE order_id IS NULL;



SELECT company_name, order_id
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.customer_id
WHERE order_id IS NULL;



-- RIGHT JOIN

SELECT company_name, order_id
FROM orders
RIGHT JOIN customers ON orders.customer_id = customers.customer_id
WHERE order_id IS NULL;  -- the same as previous request, but with RIGHT JOIN



-- SELF JOIN

-- ?



-- Creating aliases using AS

SELECT COUNT (*)
FROM employees;

SELECT COUNT (*) AS employees_count
FROM employees;



SELECT COUNT (DISTINCT country) AS country
FROM employees;



SELECT category_id, SUM (units_in_stock)
FROM products
GROUP BY category_id;

SELECT category_id, SUM (units_in_stock) AS units_in_stock
FROM products
GROUP BY category_id
ORDER BY units_in_stock DESC;



SELECT category_id, SUM(unit_price * units_in_stock) AS total_price
FROM products
WHERE discontinued != 1
GROUP BY category_id
HAVING SUM (unit_price * units_in_stock) > 5000
ORDER BY total_price DESC;
