/* CUSTOMERS SEGMENT PERFORMANCE ANALYSIS
*/
-- Segment analysis
/*customer segment performance overview by sales and profit 
Average order value and average ordered quantity by segment*/
SELECT segment,
	sum(sales) as total_sales,
	sum(profit) as total_profit,
	sum(quantity) as total_quantity,
	round(avg(profit),2) as AVG_profit_per_order,
	round(sum(sales)/count(distinct order_id),2) as AVG_order_value,
	round((sum(profit)/sum(sales))*100,2) as profit_margin_pct,
	round(avg(discount),2) as AVG_discount_per_customer,
	round(sum(profit)/count(DISTINCT customer_id),2) as profit_per_customer,
	RANK() OVER (ORDER BY SUM(profit) DESC) as segment_rank
FROM sales_raw
GROUP BY segment
ORDER BY total_profit DESC;


-- which customer & segment made the most purchases and profit
SELECT 
	segment,
	customer_name,
	count(order_id) as order_count,
	SUM(quantity) as total_quantity_ordered,
	SUM(sales) as total_sales,
	SUM(profit) as profit_per_customer
FROM sales_raw
GROUP BY segment,customer_name
ORDER BY profit_per_customer DESC;

-- worst customer profit
SELECT 
	segment,
	customer_name,
	SUM(sales) as total_sales,
	SUM(profit) as profit_per_customer,
	SUM(discount) as disc_per_customer
FROM sales_raw
GROUP BY segment,customer_name
ORDER BY profit_per_customer;
/* Mr William made a total of 37 orders/purchases. Top 5 purchasers are:["William Brown"
"John Lee"
"Matt Abelman"
"Paul Prost"
"Chloris Kastensmidt"] */

-- number of customers per segment
SELECT 
	segment,
	COUNT(DISTINCT customer_id) as customer_count,
	SUM(quantity) as total_quantity_ordered,
	SUM(sales) as total_sales
FROM sales_raw
GROUP BY segment
ORDER BY customer_count DESC;
/* Top customer segment:"Consumer"==> 409 customers 
*/

-- Customers Segment performance by category
SELECT segment,
	category,
	subcategory,
	SUM(discount) as total_disc,
	ROUND(SUM(sales),0) as total_sales,
	ROUND(SUM(profit),0) as total_profit
FROM sales_raw
GROUP BY segment, category, subcategory
ORDER BY total_disc DESC;


-- Customer Lifetime Value Analysis
WITH customer_metrics AS (
    SELECT 
        customer_id,
        customer_name,
        segment,
        COUNT(DISTINCT order_id) as order_count,
        MIN(order_date) as first_purchase,
        MAX(order_date) as last_purchase,
        ROUND(SUM(sales),3) as total_spent,
        ROUND(SUM(profit),2) as total_profit,
        AVG(discount) as avg_discount,
        ROUND(SUM(sales) / NULLIF(COUNT(DISTINCT order_id),0),2) as avg_order_value,
        EXTRACT(DAY FROM AGE(MAX(order_date), MIN(order_date))) as customer_lifetime_days
    FROM sales_raw
    GROUP BY customer_id, customer_name, segment
),
clv_ranking AS (
    SELECT 
        customer_id,
        customer_name,
        segment,
        order_count,
        first_purchase,
        last_purchase,
        total_spent,
        total_profit,
        avg_order_value,
        customer_lifetime_days,
        RANK() OVER (ORDER BY total_profit DESC) as profit_rank
    FROM customer_metrics
    WHERE customer_lifetime_days > 0
)
SELECT 
    customer_id,
    customer_name,
    segment,
    order_count,
    total_spent,
    total_profit,
    avg_order_value,
    customer_lifetime_days,
    profit_rank
FROM clv_ranking
WHERE profit_rank <= 30 --top 30 high profit customers
ORDER BY profit_rank;
/* From the above query we can derive the following analysis:
1. Customer name "Tamara Chand", in the Corporate segement from the Central Region Spent the highest
amount of $ 18,437.138, earning the store a profit of $8,745.06 with a csutomer lifetime days of 25 days,
ranked top in profit.
2. The Maximum customer lifetime days is 25-30 days.
*/

-- RFM Analysis (customer segmentation by value)
WITH customer_rfm AS (
    SELECT 
        customer_id,
        customer_name,
        segment,
        COUNT(DISTINCT order_id) AS frequency,
        ROUND(AVG(sales)::numeric, 2) AS avg_order_value,
        ROUND(SUM(sales)::numeric, 2) AS monetary,
        ROUND(SUM(profit)::numeric, 2) AS total_profit,
        MAX(order_date) AS last_order_date,
        ROUND(AVG(discount)::numeric, 4) AS avg_discount
    FROM sales_raw
    GROUP BY customer_id, customer_name, segment
),
customer_tiers AS (
    SELECT 
        *,
        NTILE(4) OVER (ORDER BY monetary DESC) AS monetary_tier,
        NTILE(4) OVER (ORDER BY frequency DESC) AS frequency_tier,
        CASE 
            WHEN monetary > (SELECT AVG(monetary) FROM customer_rfm) 
                 AND frequency > (SELECT AVG(frequency) FROM customer_rfm) 
            THEN 'High Value'
            WHEN monetary > (SELECT AVG(monetary) FROM customer_rfm) 
            THEN 'High Spend'
            WHEN frequency > (SELECT AVG(frequency) FROM customer_rfm) 
            THEN 'Frequent'
            ELSE 'Low Value'
        END AS customer_segment_tier
    FROM customer_rfm
)
SELECT 
    customer_segment_tier,
    COUNT(*) AS customer_count,
    ROUND(AVG(monetary)::numeric, 2) AS avg_lifetime_value,
    ROUND(AVG(total_profit)::numeric, 2) AS avg_profit,
    ROUND(AVG(frequency)::numeric, 2) AS avg_frequency,
    ROUND(AVG(avg_discount)::numeric, 4) AS avg_discount_rate
FROM customer_tiers
GROUP BY customer_segment_tier
ORDER BY avg_lifetime_value DESC;