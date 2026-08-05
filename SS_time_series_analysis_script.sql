-- TIME SERIES ANALYSIS
-- yearly performance analysis
SELECT
	EXTRACT(YEAR FROM order_date) as year,
	count(order_id) as total_orders,
	round(SUM(sales),1) as year_sales,
	round(SUM(profit),1) as year_profit,
	round(SUM(profit)/SUM(sales)*100,0) as yr_profit_margin_pct
FROM sales_raw
GROUP BY year
ORDER BY year_profit DESC;

-- year and month performance analysis
SELECT 
	EXTRACT(YEAR FROM order_date) AS year,
	TO_CHAR(order_date, 'Mon') AS month,
	round(sum(sales),2)as total_sales,
	ROUND(sum(profit),2)as total_profit
FROM sales_raw
GROUP BY year,month
ORDER BY total_sales DESC;

-- results top monthly sales
"year"	"month"	"total_sales"	"total_profit"
2017	"Nov"	118447.83	9690.10
2016	"Dec"	96999.04	17885.31
2017	"Sep"	87866.65	10991.56
2017	"Dec"	83829.32	8483.35
2014	"Sep"	81777.35	8328.10

--results bottom monthly sales by year
"year"	"month"	"total_sales"	"total_profit"
2016	"Jan"	18542.49	2824.82
2015	"Jan"	18174.08	-3281.01
2014	"Jan"	14236.90	2450.19
2015	"Feb"	11951.41	2813.85
2014	"Feb"	4519.89	    862.31


-- CATEGORY TIME SERIES PERFORMANCE
SELECT
	EXTRACT(YEAR FROM order_date) AS year,
	TO_CHAR(order_date, 'Mon') as month,
	category,
	count(DISTINCT order_id) as order_count,
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit
FROM sales_raw
GROUP BY year, month,category
ORDER BY total_profit Desc;
-- results
"year"	"month"	"category"	"order_count"	"total_sales"	"total_profit"
2017	"Nov"	"Technology"	79			49918.77	5674.94
2016	"Dec"	"Office Supplies" 	128		37997.57	11466.67
2017	"Nov"	"Furniture"	 85				37056.72	406.06
2016	"Dec"	"Furniture"	69				36678.72	2828.67
2015	"Dec"	"Technology"	57			35632.03	4956.21

-- MONTHLY SALES TREND FOR TOP PRODUCTS
WITH monthly_product_sales AS (
    SELECT 
		category,
        product_name,
        DATE_TRUNC('month', order_date) as month,
        SUM(sales) as monthly_sales,
        SUM(profit) as monthly_profit,
        COUNT(DISTINCT order_id) as order_count
    FROM sales_raw
    WHERE product_name IN (
        SELECT product_name 
        FROM sales_raw 
        GROUP BY product_name 
        ORDER BY SUM(profit) DESC 
        LIMIT 5
    )
    GROUP BY category,product_name, DATE_TRUNC('month', order_date)
)
SELECT 
	category,
    product_name,
    TO_CHAR(month, 'YYYY-MM') as month,
    ROUND(monthly_sales, 2) as sales,
    ROUND(monthly_profit, 2) as profit,
    order_count,
    ROUND(AVG(monthly_sales) OVER (PARTITION BY 
	product_name ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)::NUMERIC, 2) as three_month_avg
FROM monthly_product_sales
ORDER BY sales desc;

