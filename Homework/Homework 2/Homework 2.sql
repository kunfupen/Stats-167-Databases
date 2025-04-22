-- Question 1

-- (a)
SELECT COUNT(*) 
FROM products

PRAGMA classic(products);


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
SELECT MSRP
FROM products