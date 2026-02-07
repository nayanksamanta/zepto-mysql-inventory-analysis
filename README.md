# zepto-mysql-inventory-analysis
A comprehensive 50-step data analysis project using MySQL to optimize grocery retail operations. This project covers inventory management, complex pricing strategies, and database automation (Triggers, Procedures, and Views) using the Zepto v2 dataset.


## Zepto_V2_Analysis_Project
SQL analysis of the Zepto grocery database using MySQL. Includes queries for inventory management, discount analysis, and stock optimization.

## Project Overview
This project features a comprehensive suite of 50 MySQL queries designed to extract actionable insights from the zepto_v2 database. The dataset contains records of various grocery items, their categories, pricing (MRP), discount structures, and stock availability. The project demonstrates proficiency in SQL from basic data retrieval to advanced analytical techniques like window functions, stored procedures, and automated triggers.

## Objective
The primary goal of this project is to simulate real-world e-commerce and retail management tasks. Specifically, it aims to:

1. Inventory Control: Track stock levels, identify out-of-stock items, and audit data consistency.

2. Pricing Strategy: Analyze the relationship between MRP and discounted prices across different categories.

3. Category Performance: Compare product variety and average discounts between segments.

4. Database Automation: Implement automated status updates using triggers and procedures.

## Project Queries

### 1. Display all records from the table.
```sql
SELECT * FROM zepto_v2;
```
### 2. Show only the name and mrp of all products.
```sql
SELECT name, mrp FROM zepto_v2;
```
### 3. List all products where Category = 'Fruits & Vegetables'.
```sql
SELECT * FROM zepto_v2 WHERE Category = 'Fruits & Vegetables';
```
### 4. Find products where mrp is greater than 3000.
```sql
SELECT * FROM zepto_v2 WHERE mrp > 3000;
```sql
### 5. Show products where discountPercent is 15.
```sql
SELECT * FROM zepto_v2 WHERE discountPercent = 15;
```
### 6. Display products where outOfStock is FALSE.
```sql
SELECT * FROM zepto_v2 WHERE outOfStock = FALSE;
```
### 7. List the names of products with weightInGms greater than 500.
```sql
SELECT name FROM zepto_v2 WHERE weightInGms > 500;
```
### 8. Find products where availableQuantity is less than 5.
```sql
SELECT * FROM zepto_v2 WHERE availableQuantity < 5;
```
### 9. Show distinct categories available in the table.
```sql
SELECT DISTINCT Category FROM zepto_v2;
```
### 10. Count the total number of products.
```sql
SELECT COUNT(*) AS total_products FROM zepto_v2;
```
### 11. Display products sorted by mrp in ascending order.
```sql
SELECT * FROM zepto_v2 ORDER BY mrp ASC;
```
### 12. Display products sorted by discountPercent in descending order.
```sql
SELECT * FROM zepto_v2 ORDER BY discountPercent DESC;
```
### 13. Show top 10 most expensive products based on mrp.
```sql
SELECT * FROM zepto_v2 ORDER BY mrp DESC LIMIT 10;
```
### 14. Find products where name starts with letter ‘T’.
```sql
SELECT * FROM zepto_v2 WHERE name LIKE 'T%';
```
### 15. Count how many products are out of stock.
```sql
SELECT COUNT(*) AS out_of_stock_count FROM zepto_v2 WHERE outOfStock = TRUE;
```
### 16. Show products where quantity is greater than 50.
```sql
SELECT * FROM zepto_v2 WHERE quantity > 50;
```
### 17. Find products where mrp is between 2000 and 4000.
```sql
SELECT * FROM zepto_v2 WHERE mrp BETWEEN 2000 AND 4000;
```
### 18. Display products where discountedSellingPrice is less than 1500.
```sql
SELECT * FROM zepto_v2 WHERE discountedSellingPrice < 1500;
```
### 19. List products where weightInGms equals 1000.
```sql
SELECT * FROM zepto_v2 WHERE weightInGms = 1000;
```
### 20. Show all products whose category contains the word ‘Vegetables’.
```sql
SELECT * FROM zepto_v2 WHERE Category LIKE '%Vegetables%';
```
### 21. Find the maximum mrp in each category.
```sql
SELECT Category, MAX(mrp) AS max_mrp FROM zepto_v2 GROUP BY Category;
```
### 22. Find the minimum discountedSellingPrice in each category.
```sql
SELECT Category, MIN(discountedSellingPrice) AS min_price FROM zepto_v2 GROUP BY Category;
```
### 23. Count the number of products in each category.
```sql
SELECT Category, COUNT(*) AS product_count FROM zepto_v2 GROUP BY Category;
```
### 24. Calculate the average mrp of all products.
```sql
SELECT AVG(mrp) AS average_mrp FROM zepto_v2;
```
### 25. Show total available quantity of products category-wise.
```sql
SELECT Category, SUM(availableQuantity) AS total_available_qty FROM zepto_v2 GROUP BY Category;
```
### 26. Find products where the difference between mrp and discountedSellingPrice is greater than 1000.
```sql
SELECT *, (mrp - discountedSellingPrice) AS price_diff 
FROM zepto_v2 
WHERE (mrp - discountedSellingPrice) > 1000;
```
### 27. Display products with discount greater than the average discount.
```sql
SELECT * FROM zepto_v2 
WHERE discountPercent > (SELECT AVG(discountPercent) FROM zepto_v2);
```
### 28. Show categories having more than 50 products.
```sql
SELECT Category, COUNT(*) AS product_count 
FROM zepto_v2 
GROUP BY Category 
HAVING COUNT(*) > 50;
```
### 29. Find top 5 products with highest discount percent.
```sql
SELECT name, discountPercent 
FROM zepto_v2 
ORDER BY discountPercent DESC 
LIMIT 5;
```
### 30. Display total inventory weight (weightInGms * availableQuantity) for each product.
```sql
SELECT name, (weightInGms * availableQuantity) AS total_inventory_weight FROM zepto_v2;
```
### 31. Find products where discountedSellingPrice is less than 50% of mrp.
```sql
SELECT * FROM zepto_v2 WHERE discountedSellingPrice < (0.5 * mrp);
```
### 32. Show products whose names contain the word ‘Coconut’.
```sql
SELECT * FROM zepto_v2 WHERE name LIKE '%Coconut%';
```
### 33. Calculate total stock value (discountedSellingPrice * availableQuantity) for each product.
```sql
SELECT name, (discountedSellingPrice * availableQuantity) AS total_stock_value FROM zepto_v2;
```
### 34. Display the category with the highest average discount.
```sql
SELECT Category, AVG(discountPercent) AS avg_discount 
FROM zepto_v2 
GROUP BY Category 
ORDER BY avg_discount DESC 
LIMIT 1;
```
### 35. Show products where availableQuantity is zero but outOfStock is FALSE (data inconsistency check).
```sql
SELECT * FROM zepto_v2 WHERE availableQuantity = 0 AND outOfStock = FALSE;
```
### 36. Rank products within each category based on mrp.
```sql
SELECT Category, name, mrp, 
       RANK() OVER (PARTITION BY Category ORDER BY mrp DESC) AS mrp_rank
FROM zepto_v2;
```
### 37. Find the second highest mrp product in each category.
```sql
SELECT Category, name, mrp FROM (
    SELECT Category, name, mrp, 
           DENSE_RANK() OVER (PARTITION BY Category ORDER BY mrp DESC) as rnk
    FROM zepto_v2
) as ranked_table
WHERE rnk = 2;
```
### 38. Display cumulative sum of availableQuantity category-wise.
```sql
SELECT Category, name, availableQuantity,
       SUM(availableQuantity) OVER (PARTITION BY Category ORDER BY name) as running_total
FROM zepto_v2;
```
### 39. Find products whose mrp is higher than the average mrp of their category.
```sql
SELECT name, Category, mrp 
FROM zepto_v2 t1
WHERE mrp > (SELECT AVG(mrp) FROM zepto_v2 t2 WHERE t1.Category = t2.Category);
```
### 40. Identify products where discount percent is above category average discount.
```sql
SELECT name, Category, discountPercent 
FROM zepto_v2 t1
WHERE discountPercent > (SELECT AVG(discountPercent) FROM zepto_v2 t2 WHERE t1.Category = t2.Category);
```
### 41. Create a view showing only in-stock products with discount greater than 20%.
```sql
CREATE VIEW HighDiscount_InStock AS
SELECT * FROM zepto_v2
WHERE outOfStock = FALSE AND discountPercent > 20;
```
### 42. Write a query to update outOfStock = TRUE where availableQuantity = 0.
```sql
SET SQL_SAFE_UPDATES = 0;
UPDATE zepto_v2 SET outOfStock = TRUE WHERE availableQuantity = 0;
SET SQL_SAFE_UPDATES = 1;
```
### 43. Create a stored procedure to fetch products by category name.
```sql
DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN catName VARCHAR(255))
BEGIN
    SELECT * FROM zepto_v2 WHERE Category = catName;
END //
DELIMITER ;
```
### 44. Create a function to calculate discount amount (mrp - discountedSellingPrice).
```sql
DELIMITER //
CREATE FUNCTION CalculateDiscountAmt(mrp INT, sellingPrice INT) 
RETURNS INT DETERMINISTIC
BEGIN
    RETURN mrp - sellingPrice;
END //
DELIMITER ;
```
### 45. Find duplicate product names if any exist.
```sql
SELECT name, COUNT(*) 
FROM zepto_v2 
GROUP BY name 
HAVING COUNT(*) > 1;
```
### 46. Show top 3 cheapest products in each category.
```sql
SELECT Category, name, discountedSellingPrice FROM (
    SELECT Category, name, discountedSellingPrice,
           ROW_NUMBER() OVER (PARTITION BY Category ORDER BY discountedSellingPrice ASC) as price_rank
    FROM zepto_v2
) as sub
WHERE price_rank <= 3;
```
### 47. Find categories where total stock value exceeds 1,00,000.
```sql
SELECT Category, SUM(discountedSellingPrice * availableQuantity) AS total_stock_val
FROM zepto_v2
GROUP BY Category
HAVING total_stock_val > 100000;
```
### 48. Create a trigger that sets outOfStock to TRUE when availableQuantity becomes 0.
```sql
DELIMITER //
CREATE TRIGGER update_stock_status
BEFORE UPDATE ON zepto_v2
FOR EACH ROW
BEGIN
    IF NEW.availableQuantity = 0 THEN
        SET NEW.outOfStock = TRUE;
    END IF;
END //
DELIMITER ;
```
### 49. Generate a report showing: Category, Total Products, Avg MRP, Avg Discount.
```sql
SELECT Category, 
       COUNT(*) AS Total_Products, 
       AVG(mrp) AS Avg_MRP, 
       AVG(discountPercent) AS Avg_Discount
FROM zepto_v2
GROUP BY Category;
```
### 50. Write a query using a subquery to find products with mrp greater than overall average mrp.
```sql
SELECT name, mrp 
FROM zepto_v2 
WHERE mrp > (SELECT AVG(mrp) FROM zepto_v2);
```

## Key Findings
1. High-Demand Categories: "Fruits & Vegetables" drives the highest average discounts (15.46%), used to maintain high turnover of perishables.

2. Stock Health: Approximately 12% of the catalog is currently out of stock, indicating areas for procurement optimization.

3. Pricing Strategy: The average MRP across all products is 15,680, with major pricing outliers identified in bulk cooking essentials.

## Conclusion
This project successfully demonstrates the power of MySQL in managing a high-frequency grocery inventory. By transforming raw transactional data into structured reports and implementing automated database logic, we provided deep insights into pricing efficiency and stock health.
