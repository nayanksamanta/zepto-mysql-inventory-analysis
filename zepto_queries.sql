CREATE DATABASE zepto;
USE zepto;

-- 1. Display all records from the table.
SELECT * FROM zepto_v2 LIMIT 20;

-- 2. Show only the name and mrp of all products
SELECT name,mrp from zepto_v2;

-- 3. List all products where category = 'Fruits & Vegetables'
DESCRIBE zepto_v2;

ALTER TABLE zepto_v2
RENAME COLUMN `﻿Category` TO category;

SELECT * 
FROM zepto_v2
WHERE category = 'Fruits & Vegetables';


-- 4. Find products where mrp is greater than 3000
SELECT * FROM zepto_v2 WHERE mrp > 3000;

-- 5. Show products where discountPercent is 15
SELECT * FROM zepto_v2 WHERE discountPercent=15;

-- 6. Display products where outOfStock is FALSE
SELECT * FROM zepto_v2 WHERE outOfStock=FALSE;

-- 7. List the names of products with weightInGms greater than 500
SELECT name, weightInGms FROM zepto_v2 WHERE weightInGms > 500;

-- 8. Find products where availableQuantity is less than 5
SELECT name, availableQuantity FROM zepto_v2 WHERE availableQuantity < 5;

-- 9. Show distinct categories available in the table
SELECT DISTINCT category FROM zepto_v2;

-- 10. Count the total number of products
SELECT COUNT(*) FROM zepto_v2;

-- 11. Display products sorted by mrp in ascending order
SELECT name, mrp FROM zepto_v2 ORDER BY mrp ASC;

-- 12. Display products sorted by discountPercent in descending order
SELECT name, discountPercent FROM zepto_v2 ORDER BY discountPercent DESC;

-- 13. Show top 10 most expensive products based on mrp
SELECT name, mrp FROM zepto_v2 ORDER BY mrp DESC LIMIT 10;

-- 14. Find products where name starts with letter ‘T’
SELECT * FROM zepto_v2 WHERE name  LIKE 'T%';

-- 15. Count how many products are out of stock
SELECT COUNT(outOfStock) FROM zepto_v2 WHERE outOfStock= 'TRUE';

-- 16. Show products where quantity is greater than 50
SELECT * FROM zepto_v2 WHERE quantity > 50;

-- 17. Find products where mrp is between 2000 and 4000
SELECT * FROM zepto_v2 WHERE mrp BETWEEN 2000 AND 4000;

-- 18. Display products where discountedSellingPrice is less than 1500
SELECT * FROM zepto_v2 WHERE discountedSellingPrice < 1500;

-- 19. List products where weightInGms equals 1000
SELECT * FROM zepto_v2 WHERE weightInGms = 1000;

-- 20. Show all products whose category contains the word ‘Vegetables’
SELECT * FROM zepto_v2 WHERE category LIKE '%Vegetables%';

-- 21. Find the maximum mrp in each category
SELECT category, MAX(mrp) AS Max_MRP 
FROM zepto_v2 
GROUP BY category;

-- 22. Find the minimum discountedSellingPrice in each category
SELECT category, MIN(discountedSellingPrice) AS Min_Price 
FROM zepto_v2 
GROUP BY category;

-- 23. Count the number of products in each category
SELECT category, COUNT(*) AS Product_Count FROM zepto_v2 GROUP BY category;

-- 24. Calculate the average mrp of all products
SELECT AVG(mrp) AS Average_MRP FROM zepto_v2;

-- 25. Show total available quantity of products category-wise
SELECT category, SUM(availableQuantity) AS Total_Quantity 
FROM zepto_v2 
GROUP BY category;

-- 26. Find products where the difference between mrp and discountedSellingPrice is greater than 1000
SELECT * FROM zepto_v2 
WHERE (mrp - discountedSellingPrice) > 1000;

-- 27. Display products with discount greater than the average discount
SELECT * FROM zepto_v2 
WHERE discountPercent > (SELECT AVG(discountPercent) FROM zepto_v2);

-- 28. Show categories having more than 50 products
SELECT category, COUNT(*) AS Product_Count 
FROM zepto_v2 
GROUP BY category 
HAVING COUNT(*) > 50;

-- 29. Find top 5 products with highest discount percent
SELECT name, discountPercent 
FROM zepto_v2 
ORDER BY discountPercent DESC 
LIMIT 5;

-- 30. Display total inventory weight (weightInGms * availableQuantity) for each product
SELECT name, (weightInGms * availableQuantity) AS Total_Inventory_Weight 
FROM zepto_v2;

-- 31. Find products where discountedSellingPrice is less than 50% of mrp
SELECT * FROM zepto_v2 
WHERE discountedSellingPrice < (0.5 * mrp);

-- 32. Show products whose names contain the word ‘Coconut’
SELECT * FROM zepto_v2 
WHERE name LIKE '%Coconut%';

-- 33. Calculate total stock value (discountedSellingPrice * availableQuantity) for each product
SELECT name, (discountedSellingPrice * availableQuantity) AS Total_Stock_Value 
FROM zepto_v2;

-- 34. Display the category with the highest average discount
SELECT category, AVG(discountPercent) AS Avg_Discount 
FROM zepto_v2 
GROUP BY category 
ORDER BY Avg_Discount DESC 
LIMIT 1;

-- 35. Show products where availableQuantity is zero but outOfStock is FALSE
SELECT * FROM zepto_v2 
WHERE availableQuantity = 0 AND outOfStock = FALSE;

-- 36. Rank products within each category based on mrp
SELECT category, name, mrp, 
       RANK() OVER (PARTITION BY category ORDER BY mrp DESC) AS mrp_rank
FROM zepto_v2;

-- 37. Find the second highest mrp product in each category
SELECT category, name, mrp FROM (
    SELECT category, name, mrp, 
           DENSE_RANK() OVER (PARTITION BY category ORDER BY mrp DESC) as rnk
    FROM zepto_v2
) as ranked_table
WHERE rnk = 2;

-- 38. Display cumulative sum of availableQuantity category-wise
SELECT category, name, availableQuantity,
       SUM(availableQuantity) OVER (PARTITION BY category ORDER BY name) as running_total
FROM zepto_v2;

-- 39. Find products whose mrp is higher than the average mrp of their category
SELECT name, category, mrp 
FROM zepto_v2 t1
WHERE mrp > (SELECT AVG(mrp) FROM zepto_v2 t2 WHERE t1.category = t2.category);

-- 40. Identify products where discount percent is above category average discount
SELECT name, category, discountPercent 
FROM zepto_v2 t1
WHERE discountPercent > (SELECT AVG(discountPercent) FROM zepto_v2 t2 WHERE t1.category = t2.category);

-- 41. Create a view showing only in-stock products with discount greater than 20%
CREATE VIEW HighDiscount_InStock AS
SELECT * FROM zepto_v2
WHERE outOfStock = FALSE AND discountPercent > 20;


-- 42. Write a query to update outOfStock = TRUE where availableQuantity = 0
SET SQL_SAFE_UPDATES = 0;

UPDATE zepto_v2 
SET outOfStock = TRUE 
WHERE availableQuantity = 0;

SET SQL_SAFE_UPDATES = 1;

-- 43. Create a stored procedure to fetch products by category name
DELIMITER //
CREATE PROCEDURE GetProductsBycategory(IN catName VARCHAR(255))
BEGIN
    SELECT * FROM zepto_v2 WHERE category = catName;
END //
DELIMITER ;

-- 44. Create a function to calculate discount amount (mrp - discountedSellingPrice)
DELIMITER //
CREATE FUNCTION CalculateDiscountAmt(mrp INT, sellingPrice INT) 
RETURNS INT DETERMINISTIC
BEGIN
    RETURN mrp - sellingPrice;
END //
DELIMITER ;

-- 45. Find duplicate product names if any exist
SELECT name, COUNT(*) 
FROM zepto_v2 
GROUP BY name 
HAVING COUNT(*) > 1;

-- 46. Show top 3 cheapest products in each category
SELECT category, name, discountedSellingPrice FROM (
    SELECT category, name, discountedSellingPrice,
           ROW_NUMBER() OVER (PARTITION BY category ORDER BY discountedSellingPrice ASC) as price_rank
    FROM zepto_v2
) as sub
WHERE price_rank <= 3;

-- 47. Find categories where total stock value exceeds 1,00,000
SELECT category, SUM(discountedSellingPrice * availableQuantity) AS Total_Stock_Value
FROM zepto_v2
GROUP BY category
HAVING Total_Stock_Value > 100000;

-- 48. Create a trigger that sets outOfStock to TRUE when availableQuantity becomes 0


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

-- 49. Generate a report showing: Category, Total Products, Avg MRP, Avg Discount
SELECT category, 
       COUNT(*) AS Total_Products, 
       AVG(mrp) AS Avg_MRP, 
       AVG(discountPercent) AS Avg_Discount
FROM zepto_v2
GROUP BY category;

-- 50. Write a query using a subquery to find products with mrp greater than overall average mrp
SELECT name, mrp 
FROM zepto_v2 
WHERE mrp > (SELECT AVG(mrp) FROM zepto_v2);