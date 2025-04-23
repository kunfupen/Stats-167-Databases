-- Question 1

-- (a)
SELECT COUNT(*) 
FROM products;

-- productCode is the primary key.


-- (b)
SELECT productLine, COUNT(*) AS productCount
FROM products
GROUP BY productLine
ORDER BY productCount DESC;

-- (c)
SELECT COUNT(*) AS productCount
FROM products
WHERE buyPrice BETWEEN 20 and 100
AND productLine IN (
    SELECT productLine
    FROM products
    GROUP BY productLine
    ORDER BY COUNT(*) DESC
    LIMIT 3
);

-- (d)

-- Average buy price of products from each vendor
SELECT productVendor, AVG(buyPrice) AS avgBuyPrice
FROM products
GROUP BY productVendor
ORDER BY avgBuyPrice DESC;

-- Most expensive product from each vendor
SELECT productVendor, MAX(buyPrice) AS maxBuyPrice
FROM products
GROUP BY productVendor
ORDER BY maxBuyPrice DESC
LIMIT 1;

-- Least expensive product from each vendor
SELECT productVendor, MIN(buyPrice) AS minBuyPrice
FROM products
GROUP BY productVendor
ORDER BY minBuyPrice
LIMIT 1;

-- Greatest range in price of products from each vendor
SELECT productVendor, MAX(buyPrice) - MIN(buyPrice) AS priceRange
FROM products
GROUP BY productVendor
ORDER BY priceRange DESC
LIMIT 1;

-- (e)
SELECT productVendor, SUM(quantityInStock * (MSRP  - buyPrice)) AS profit,
         AVG(buyPrice) AS avgBuyPrice
FROM products
GROUP BY productVendor
ORDER BY profit DESC;


-- Question 2

-- (a)
SELECT country, COUNT(*) AS customerCount
FROM customers
GROUP BY country
ORDER BY customerNumber DESC
LIMIT 8;

-- (b)
SELECT country, COUNT(customerNumber) AS numCustomer
FROM customers
GROUP BY country
WHERE numCustomer >= 5;

/* Where filters the rows before they are grouped. 
In this case we would want to use HAVING so that we can filter the grouped results.
*/


-- (c)
SELECT COUNT(*) 
FROM customers
WHERE creditLimit > 50000
AND country IN ('USA', 'CANADA');

-- (d)
SELECT salesRepEmployeeNumber, COUNT(DISTINCT country) AS countryCount
FROM customers
WHERE salesRepEmployeeNumber IS NOT NULL
GROUP BY salesRepEmployeeNumber
HAVING countryCount > 1;

-- Question 3

-- (a)
SELECT MAX(DATE(orderDate)), MIN(DATE(orderDate))
FROM orders

-- (b)
SELECT customerNumber, COUNT(*) AS orderCount
FROM orders
GROUP BY customerNumber
ORDER BY orderCount DESC
LIMIT 4;

-- (c)
SELECT customerNumber, DATE(orderDate) AS orderDate,
COUNT(*) AS orderPlaced
FROM orders
GROUP BY customerNumber, Date(orderDate)
ORDER BY orderPlaced DESC
LIMIT 1;

-- (d)
SELECT COUNT(*)
FROM orders
WHERE status != 'Shipped'
AND (comments LIKE '%ustomer%');


-- Question 4

-- Wrong Query
SELECT customerNumber, country, salesRepEmployeeNumber, creditLimit
FROM Customers
WHERE creditLimit >= 5e4 AND country = 'USA' OR country = 'Germany' OR country = 'France'
ORDER BY creditLimit DESC, country;

/* WHERE is used wrong, 
ORDER BY is used to sort the results after the WHERE clause has been applied.
*/

-- Correct Query
SELECT customerNumber, country, salesRepEmployeeNumber, creditLimit
FROM Customers
WHERE creditLimit >= 5e4
AND country IN ('USA', 'Germany', 'France')
ORDER BY country  DESC, creditLimit DESC;