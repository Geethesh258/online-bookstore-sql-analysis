-- Basic Filters
SELECT * FROM books WHERE genre = 'Fantasy';
SELECT * FROM books WHERE published_year > 1950;
SELECT * FROM customers WHERE country = 'Canada';
SELECT * FROM orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- Revenue & Inventory
SELECT SUM(stock) AS total_stock FROM books;
SELECT SUM(total_amount) AS total_revenue FROM orders;
SELECT * FROM books ORDER BY price DESC LIMIT 1;
SELECT * FROM books ORDER BY stock ASC;

-- Sales Analysis
SELECT DISTINCT genre FROM books;

SELECT b.genre, SUM(o.quantity) AS books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;

SELECT AVG(price) AS average_price
FROM books
WHERE LOWER(genre) = 'fantasy';

-- Customer Insights
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2;

SELECT c.name, SUM(o.total_amount) AS total_spending
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spending DESC
LIMIT 1;

-- Inventory After Orders
SELECT b.book_id,
       b.title,
       b.stock,
       COALESCE(SUM(o.quantity),0) AS ordered,
       b.stock - COALESCE(SUM(o.quantity),0) AS remaining_stock
FROM books b
LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;
