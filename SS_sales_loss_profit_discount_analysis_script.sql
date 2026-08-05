/* SALES, PROFIT, LOSS, DISCOUNT ANALYSIS.
Analyzing the sales performance, discover trends and patterns of sales, loss and profit monthly
yearly, quarterly.
*/

-- SALES ANALYSIS
-- Monthly, quarterly, yearly sales trend

SELECT --total year sales analysis
	EXTRACT(year from order_date) as year,
	count(order_id) as total_order,
	sum(quantity) as quantity_total,
	sum(sales) as sum_sales,
	sum(profit) as sum_profit,
	sum(discount) as sum_discount
FROM sales_raw
GROUP BY year
ORDER BY year;

SELECT -- Total quarterly analysis per region
	region,
	EXTRACT(YEAR FROM order_date) as year,
	EXTRACT(QUARTER FROM order_date) as quarter,
	SUM(sales) as total_sales
	--window functions for partitioned analysis
--
FROM sales_raw
GROUP BY region, year,quarter
ORDER BY quarter;
	
SELECT -- Total monthly analysis per region	
	region,
	TO_CHAR(order_date,'yyyy-Mon') as month,
	SUM(sales) as total_sales
FROM sales_raw
GROUP BY region, month
ORDER BY total_sales desc;

