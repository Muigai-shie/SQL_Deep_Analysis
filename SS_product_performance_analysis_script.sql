/* PRODUCT PERFORMANCE ANALYSIS 
In this analysis, we answer questions about the product's performance in reference to the sales, profit, and 
quantity sold, in each category.
*/
 -- BASIC ANALYSIS
-- Category performance by sales, profit, profit margin, product count & quantity ordered
SELECT
	category,
	ROUND(SUM(sales),2) as total_sales,
	ROUND(SUM(profit),2) as total_profit,
	ROUND(SUM(profit)/SUM(sales)*100,2) as pct_margin,
	SUM(quantity) as total_quantity,
	COUNT(DISTINCT product_id) as product_count
FROM sales_raw
GROUP BY category
ORDER BY total_sales DESC; 

-- breaking down to subcategory
SELECT
	category,
	subcategory,
	ROUND(SUM(sales),2) as total_sales,
	ROUND(SUM(profit),2) as total_profit,
	ROUND(SUM(profit)/SUM(sales)*100,2) as pct_margin,
	SUM(discount) as total_discount,
	SUM(quantity) as total_quantity,
	COUNT(DISTINCT product_id) as product_count
FROM sales_raw
GROUP BY category, subcategory
ORDER BY total_profit DESC;

-- profit by subcategory breakdown
SELECT
	category,
	subcategory,
	ROUND(SUM(sales),2) as total_sales,
	ROUND(SUM(profit),2) as total_profit,
	ROUND(SUM(profit)/SUM(sales)*100,2) as pct_margin,
	SUM(quantity) as total_quantity,
	COUNT(DISTINCT product_id) as product_count
FROM sales_raw
GROUP BY category, subcategory
ORDER BY total_profit DESC;

-- Profit analysis of products per category
-- using CTE
WITH product_profits AS (
    SELECT 
        product_name,
        category,
        subcategory,
        round(SUM(profit),0) AS product_profit,
		round(SUM(sales),2) AS total_sales_$,
		sum(quantity) as prod_quantity
    FROM sales_raw
    GROUP BY product_name, category, subcategory
)
SELECT product_name,
       category,
       subcategory,
       product_profit,
	   total_sales_$,
	   prod_quantity
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY category 
               ORDER BY product_profit DESC
           ) AS rn
    FROM product_profits
) ranked 
WHERE rn<3
ORDER BY product_profit DESC;
--

-- Loss analysis per product
SELECT 
    product_name,
    category,
    subcategory,
    ROUND(SUM(sales), 2) as total_sales,
    ROUND(SUM(profit), 2) as total_loss
FROM sales_raw
GROUP BY product_name, category, subcategory
HAVING SUM(profit) < 0
ORDER BY total_loss ASC
LIMIT 10;



-- Recommendation extra queries analysis
--deep dive into the furniture/ tables and bookcases
SELECT category,
	subcategory,
	product_name,
	SUM(sales) as total_sales,
	SUM(profit) as total_profit,
	sum(quantity) as quantity,
	sum(discount) as disc,
	ROUND(SUM(profit)/SUM(sales)*100,1) as profit_margin
FROM sales_raw
GROUP BY category, subcategory, product_name
having sum(discount)<=0
ORDER BY total_profit;