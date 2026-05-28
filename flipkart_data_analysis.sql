CREATE DATABASE flipkart_data_analysis
USE flipkart_data_analysis

SELECT * FROM flipkart_products

-- 1. Total Number of Products
SELECT COUNT(*) AS total_products
FROM flipkart_products;

-- 2. Average Retail Price and Discounted Price
SELECT 
    AVG(retail_price) AS avg_retail_price,
    AVG(discounted_price) AS avg_discounted_price
FROM flipkart_products;

-- 3. Top Categories by Product Count
SELECT 
    product_category_tree,
    COUNT(*) AS total_products
FROM flipkart_products
GROUP BY product_category_tree
ORDER BY total_products DESC;

-- 4. Top Brands by Number of Products
SELECT 
    brand,
    COUNT(*) AS total_products
FROM flipkart_products
GROUP BY brand
ORDER BY total_products DESC;

-- 5. Average Discount Percentage by Category
SELECT 
    product_category_tree,
    AVG(discount_percentage) AS avg_discount_percentage
FROM flipkart_products
GROUP BY product_category_tree
ORDER BY avg_discount_percentage DESC;

-- 6. Products with Highest Discount Percentage
SELECT TOP 10
    product_name,
    brand,
    retail_price,
    discounted_price,
    discount_percentage
FROM flipkart_products
ORDER BY discount_percentage DESC;

-- 7. Most Expensive Products
SELECT TOP 10
    product_name,
    brand,
    retail_price
FROM flipkart_products
ORDER BY retail_price DESC;

-- 8. Cheapest Products
SELECT TOP 10
    product_name,
    brand,
    discounted_price
FROM flipkart_products
ORDER BY discounted_price ASC;

-- 9. Average Rating by Category
SELECT 
    product_category_tree,
    AVG(product_rating) AS avg_rating
FROM flipkart_products
GROUP BY product_category_tree
ORDER BY avg_rating DESC;

-- 10. Brands with Highest Average Ratings
SELECT 
    brand,
    AVG(product_rating) AS avg_rating
FROM flipkart_products
GROUP BY brand
ORDER BY avg_rating DESC;

-- 11. Products with High Discount but Low Rating
SELECT 
    product_name,
    brand,
    retail_price,
    discounted_price,
    product_rating,
    discount_percentage
FROM flipkart_products
WHERE discount_percentage > 50
  AND product_rating < 3
ORDER BY product_rating ASC;

-- 12. Products with High Rating and Low Discount
SELECT 
    product_name,
    brand,
    retail_price,
    discounted_price,
    product_rating,
    discount_percentage
FROM flipkart_products
WHERE product_rating >= 4
  AND discount_percentage < 10
ORDER BY product_rating DESC;

-- 13. Products Giving Maximum Savings
SELECT TOP 10
    product_name,
    brand,
    retail_price,
    discounted_price,
    (retail_price - discounted_price) AS savings
FROM flipkart_products
ORDER BY savings DESC;

-- 14. Number of Products in Each Category
SELECT 
    product_category_tree,
    COUNT(*) AS total_products
FROM flipkart_products
GROUP BY product_category_tree
ORDER BY total_products DESC;

-- 15. Category with Highest Average Selling Price
SELECT 
    product_category_tree,
    AVG(discounted_price) AS avg_selling_price
FROM flipkart_products
GROUP BY product_category_tree
ORDER BY avg_selling_price DESC;

-- 16. Products Above Category Average Price
SELECT 
    product_name,
    brand,
    discounted_price,
    product_category_tree
FROM flipkart_products p
WHERE discounted_price >
(
    SELECT AVG(discounted_price)
    FROM flipkart_products
    WHERE product_category_tree = p.product_category_tree
);
-- 17. Products Below Category Average Price
SELECT 
    product_name,
    brand,
    discounted_price,
    product_category_tree
FROM flipkart_products p
WHERE discounted_price <
(
    SELECT AVG(discounted_price)
    FROM flipkart_products
    WHERE product_category_tree = p.product_category_tree
);

-- 18. Rating Distribution
SELECT 
    product_rating,
    COUNT(*) AS total_products
FROM flipkart_products
GROUP BY product_rating
ORDER BY product_rating DESC;

-- 19. Brands with High Ratings and High Discounts
SELECT 
    brand,
    AVG(product_rating) AS avg_rating,
    AVG(discount_percentage) AS avg_discount
FROM flipkart_products
GROUP BY brand
HAVING AVG(product_rating) >= 4
ORDER BY avg_discount DESC;

-- 20. Best Value Products
SELECT TOP 20
    product_name,
    brand,
    product_rating,
    retail_price,
    discounted_price,
    discount_percentage
FROM flipkart_products
WHERE product_rating >= 4
ORDER BY discount_percentage DESC, product_rating DESC;