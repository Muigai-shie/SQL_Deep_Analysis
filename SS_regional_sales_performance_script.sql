-- REGIONAL SALES PERFORMANCE
-- regional performance summary
SELECT
	region,
	--count(DISTINCT state_) as state_count,
	-- count(DISTINCT city) as city_count,
	count(DISTINCT order_id) as order_count,
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit,
	round(SUM(sales)/COUNT(DISTINCT order_id),2) as AVG_order_value,
	round(SUM(discount),0) as total_discount,
	round(avg(profit),2) as AVG_profit,
	round(sum(profit)/sum(sales)*100,0)as margin_pct,
	round(sum(profit)/count(DISTINCT customer_id),2) as profit_per_customer
FROM sales_raw
GROUP BY region
ORDER BY total_profit DESC;

--performance by cities and states
--top 10 and bottom 10 states by profit
WITH state_performance AS(
	SELECT
	state_,
	count(DISTINCT order_id) as order_count,
	count(DISTINCT customer_id) as customer_count,
	round(sum(sales),0) as total_sales,
	round(sum(profit),0) as total_profit,
	round((sum(profit)/sum(sales))*100,0) as profit_margin_pct
FROM sales_raw
GROUP BY state_
),
ranked_states AS(
SELECT *,
	RANK() OVER(ORDER BY total_profit DESC) as profit_rank_desc,
	RANK() OVER(ORDER BY total_profit ASC) as profit_rank_asc
FROM state_performance
)
SELECT
	state_,
	order_count,
	customer_count,
	total_sales,
	total_profit,
	profit_margin_pct,
	CASE
		WHEN profit_rank_desc <=5 THEN 'Top 5'
		WHEN profit_rank_asc <=5 THEN 'Bottom 5'
		ELSE 'Middle'
	END as state_performance_category
FROM ranked_states
WHERE profit_rank_desc <=5 OR profit_rank_asc <=5
ORDER BY total_profit DESC;

--top 10 and bottom 10 cities by profit
WITH city_metrics AS(
SELECT
	city,
	count(DISTINCT order_id) as order_count,
	count(DISTINCT customer_id) as customer_count,
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit,
	sum(quantity) as total_ord_quantity,
	round((sum(profit)/sum(sales))*100,2) as profit_margin_pct
FROM sales_raw
GROUP BY city
),
ranked_cities AS(
SELECT *,
	RANK() OVER(ORDER BY total_profit DESC) as profit_rank_desc,
	RANK() OVER(ORDER BY total_profit ASC) as profit_rank_asc
FROM city_metrics
)
SELECT 
	city,
	order_count,
	customer_count,
	total_sales,
	total_profit,
	profit_margin_pct,
	CASE
		WHEN profit_rank_desc <=10 THEN 'Top 10 city'
		WHEN profit_rank_asc <= 10 THEN 'Bottom 10 city'
		ELSE 'Middle'
	END as city_performance_category
FROM ranked_cities
WHERE profit_rank_desc<=10 or profit_rank_asc<=10
ORDER BY total_profit DESC;

-- Regional Product Category Performance by profit
SELECT
	region,
	category,
	count(DISTINCT order_id) as order_count,
	count(DISTINCT customer_id) as customer_count,
	round(sum(sales),2) as total_sales,
	round(sum(profit),2) as total_profit,
	round(avg(discount),2) as AVG_discount,
	round((sum(profit)/sum(sales))*100,2) as cat_profit_margin_pct,
	round(sum(sales)/Sum(sum(sales)) OVER(PARTITION BY region)*100,1) as sales_pct_region
FROM sales_raw
--WHERE category='Technology'
GROUP BY region, category
ORDER BY total_profit DESC;

-- state vs region performance
SELECT 
	state_,
	region,
	round(SUM(sales),1) as total_sales,
	round(SUM(profit),1) as total_profit,
	round(SUM(profit)/SUM(sales)*100,0) as profit_margin_pct
FROM sales_raw
where region='West'
GROUP BY state_, region
ORDER BY total_profit DESC;
