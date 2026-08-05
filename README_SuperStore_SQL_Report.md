## About the Dataset

The SuperStore data is a sales data containing Information related to Sales, Profits, Products, categories and other interesting facts of a Superstore giant. The Dataset contains a total of 9,994 records and 21 columns for a period of 3 years spanning 2014-2017.
## Objective

The objective of this Project is to identify the key drivers of sales and profit for the SuperStore, evaluate the performance of sales according to the products, categories, region, and customers segments, aiming to give insights that will impact decisions on investments and resource allocation.
### Problem Statement

Superstore is a superficial giant store that has generated **$2.30M** in **sales** and **$286K** in **profit** (a 12.47% overall margin) between 2014 and 2017. But margin is not evenly earned — some categories, regions, and customers are actively losing money while others carry the business. Leadership needs a clear, data-backed view of where profit is really coming from, where it's leaking, and what to do about it — across products, regions, segments, and across time— to reallocate investment, fix pricing/discount policy, and grow profitably rather than just growing sales.

## 1. Product & Category Analysis

In this analysis, we answer questions about the product's performance in reference to the sales, profit, quantity sold, and profit margin in each category.

**Worst performers:**

/* 
**by profit*
| "category  | "subcategory" | "total_sales" | "total_profit" | "pct_margin%" | "total_quantity" | "product_count"|
|---|---|---|---|---|---|---|
| "Furniture" |    **"Tables"**	 | 206965.53 |    -17725.48	    | -8.56	            | 1241	   | 57
| "Furniture" |	  **"Bookcases"**	 | 114880.00 |     -3472.56	    | -3.02	            | 868	         | 49
| "Office Supplies" |	"Supplies"	 | 46673.54	 |    -1189.10	    | -2.55	            | 647	         | 38
| "Office Supplies" |	"Fasteners"	 | 3024.28	 |     949.52	    | 31.40	            | 914	         | 43
| "Technology" |	 "Machines"	       | 189238.63 |   3384.76	    | 1.79	            | 440	         | 63

-- by sales
| "category"  | "subcategory" | "total_sales"   | "total_profit" | "pct_margin%" | 	"total_quantity" | "product_count"|
|---|---|---|---|---|---|---|
| "Office Supplies" | 	**"Fasteners"** | 3024.28    | 949.52	      | 31.40	          | 914	        | 43
| "Office Supplies" | 	**"Labels"**  | 12486.31     | 5546.25	      | 44.42	          | 1400	        | 70
| "Office Supplies" | 	"Envelopes"	 | 16476.40	      | 6964.18	      | 42.27	          | 906	         | 54
| "Office Supplies" | 	"Art"	       | 27118.79	     | 6527.79	      | 24.07	        |  3000	        | 163
| "Office Supplies" | 	"Supplies"	 | 46673.54   | -1189.10         | -2.55	             | 647	        | 38
*/

**Best performers:** Copiers (+$55.6K profit, 37% margin), Phones (+$44.5K), Accessories (+$41.9K), Paper (+$34.1K), Binders (+$30.2K), Chairs (+$26.6K).

**Worst individual products:** The Cubify CubeX 3D Printer (Double Head) lost **-$8,880** alone; the Triple Head version lost another -$3,840. The Lexmark MX611dhe printer lost -$4,590. Several conference/meeting tables (Chromcraft, Bush, BoxOffice) are each losing $1,100–$2,900.

**Insight:** Furniture is the category dragging down overall profitability — driven almost entirely by Tables and Bookcases. Technology is the profit engine, led by Copiers and Phones.

**Recommendation:** Investigate Tables pricing/costs — likely over-discounted or high shipping/fulfillment cost relative to price. Consider renegotiating supplier terms, repricing, or discontinuing the worst SKUs (Cubify 3D printers, low-end conference tables). Double down on Copiers and Accessories with more marketing/inventory investment.

---

## 2. Regional Analysis

| Region | Sales | Profit | Margin % |
|---|---|---|---|
| West | $725,458 | $108,418 | 14.94% |
| East | $678,781 | $91,523 | 13.48% |
| South | $391,722 | $46,749 | 11.93% |
| Central | $501,240 | $39,706 | **7.92%** |

**Worst states by profit:**

| State | Sales | Profit |
|---|---|---|
| Texas | $170,188 | **-$25,729** |
| Ohio | $78,258 | **-$16,971** |
| Pennsylvania | $116,512 | **-$15,560** |
| Illinois | $80,166 | **-$12,608** |
| North Carolina | $55,603 | -$7,491 |

**Best states:** California (+$76.4K), New York (+$74.0K), Washington (+$33.4K).

**Region × Category:** Central region's Furniture is the *only* region-category combination that's net negative (**-$2,871**). Every other region's Furniture is at least marginally profitable, meaning Central has a specific, fixable problem — not just a category-wide one.

**Insight:** Four states — Texas, Ohio, Pennsylvania, and Illinois — collectively lose over **$70,000**, all within the Central region, which explains why Central has the weakest margin despite solid sales. California and New York alone contribute more profit than the entire South region.

**Recommendation:** Audit pricing, discount authorization, and shipping costs specifically in Texas, Ohio, Pennsylvania, and Illinois — this is likely a regional discounting/sales-rep behavior issue, not a demand issue (sales there are healthy, profit isn't). Protect and expand investment in California/New York/Washington, which are proven high-margin markets.

---

## 3. Customer Segment Analysis

| Segment | Orders | Sales | Profit | Avg Order Value |
|---|---|---|---|---|
| Consumer | 2,586 | $1,161,401 | $134,119 | $449.11 |
| Corporate | 1,514 | $706,146 | $91,979 | $466.41 |
| Home Office | 909 | $429,653 | $60,299 | $472.67 |

**Top customers by profit:** Tamara Chand (+$8,981), Raymond Buch (+$6,976), Sanjit Chand (+$5,757), Hunter Lopez (+$5,622), Adrian Barton (+$5,445).

**Worst customers by profit:** Cindy Stewart (**-$6,626**), Grant Thornton (**-$4,109**), Luke Foster (-$3,584), Sharelle Roach (-$3,334), Henry Goldwyn (-$2,798).

**Segment × Category:** Consumer segment drives the most Technology profit ($70.8K) and Office Supplies profit ($56.3K). Furniture is the weak link in *every* segment, but especially Consumer, where despite the highest order volume, Furniture profit is only $6,991.

**Insight:** Consumer is the largest and most profitable segment overall, but Home Office has the highest average order value — an under-leveraged segment worth targeted growth. A small number of customers are consistently unprofitable across many orders, likely due to heavy, repeated discounting.

**Recommendation:** Review discount authorization for the bottom five customers individually — are they receiving discounts that structurally exceed their order profitability? Consider tiered account management: extend more attention/upsell to top-tier customers (Tamara Chand, Raymond Buch, etc.) and cap discount flexibility for chronic loss-makers.

---

## 4. Time-Series & Seasonality

| Year | Sales | Profit |
|---|---|---|
| 2014 | $484,248 | $49,544 |
| 2015 | $470,533 | $61,619 |
| 2016 | $609,206 | $81,795 |
| 2017 | $733,215 | $93,439 |

Sales grew **+51%** and profit grew **+89%** from 2014 to 2017 — profit is growing faster than sales, a healthy sign of improving efficiency.

**Monthly pattern:** Every year shows a consistent **Q4 spike** — November and December are reliably the two strongest months (e.g., Nov 2017: $118,448 in sales, the single highest month in the dataset). September also shows a secondary peak each year (back-to-school/fiscal year-end buying).

**Insight:** The business has a clear, repeatable seasonal cycle: strong in September, and strongest in November–December.

**Recommendation:** Align inventory build-up, staffing, and marketing spend around September and November–December. Given profit is outpacing sales growth, current strategy overall is working — the goal is to fix the specific loss pockets (Tables, Central region, deep discounts) rather than change overall direction.

---

## Summary of Key Findings

1. **Furniture (esp. Tables & Bookcases) is dragging down profit** — Tables alone lost $17,725.
2. **Central region, and specifically Texas, Ohio, Pennsylvania, Illinois, are structurally unprofitable** despite healthy sales — a discounting/pricing issue, not a demand issue.
3. **Technology (Copiers, Phones, Accessories) and Office Supplies (Paper, Binders) are the profit engines.**
4. **Business is improving over time** — profit growing faster than sales (89% vs 51%, 2014→2017), with a reliable Q4 seasonal peak.

## Top Recommendations

1. **Fix Tables & Bookcases**: renegotiate costs, reprice, or cut the worst SKUs (e.g., Cubify 3D printers, low-end conference tables).
2. **Regional intervention in Central**: audit sales rep discount behavior in TX, OH, PA, IL specifically.
4. **Protect and grow what works**: reinvest in California, New York, Washington, and the Technology category.
5. **Shift marketing dollars toward retention**, not just acquisition, given the outsized profit gap between repeat and one-time customers.
6. **Plan inventory/staffing around the Q4 (Nov–Dec) and September peaks.**
