**Global Superstore Data Analysis Report**

A Deep Dive into Profitability, Customer Segmentation, and Operational Efficiency

By Suranjana Aryal

Saint Mary’s College of California|MSBA














## 1. Project Goal

The objective of this project was to conduct an in-depth exploratory data analysis (EDA) of the Global Superstore dataset (2011-2014). The goal was to move beyond surface-level metrics (like total sales) and uncover actionable, data-driven insights into the key drivers of profitability, customer behavior, and operational efficiency. This analysis aims to identify specific opportunities for cost reduction, marketing optimization, and strategic growth.

## 2. Libraries & Tools Used

This analysis was performed in a Google Colab notebook using Python. The primary libraries leveraged were:

•	Pandas: For data loading, cleaning, manipulation, merging, and complex aggregation.

•	NumPy: For efficient numerical operations, particularly np.where for safe, conditional feature creation.

•	Matplotlib & Seaborn: For a wide range of static and statistical visualizations, including bar charts, scatter plots, line plots, and count plots.

•	datetime: For parsing date columns and calculating customer recency.

•	itertools & collections: For performing a basic market basket analysis to find co-purchased item pairs.

## 3. Analytical Workflow & Code Explanations

The analysis followed a structured workflow, starting with data preparation and moving to advanced feature engineering and strategic analysis.

3.1. Data Unification (Merging)

The raw data was provided in three separate Excel sheets: Orders (the main transaction table), Returns (logging returned orders), and People (mapping managers to regions).

• Code Explanation:

- df_merged = pd.merge(df_orders, df_returns, on='Order ID', how='left'): A left join was used to combine Orders with Returns. This is crucial as it retains all orders (our primary data) and simply appends return information (like 'Yes') to those orders that were returned. An inner join would have incorrectly dropped all non-returned orders.

- df = pd.merge(df_merged, df_people, on='Region', how='inner'): An inner join was used to map regional managers to each order. Since every order has a valid region and every region has a manager, this join cleanly enriches the dataset with performance accountability data.

3.2. Feature Engineering (Creating "So What" Metrics)

Raw data is often not enough to answer business questions. New features were engineered to provide deeper context:

•Code Explanation:

- df['Is_Returned'] = df['Returned'].apply(lambda x: 1 if x == 'Yes' else 0): Converted the 'Yes'/NaN Returned column into a binary Is_Returned (1/0) flag. This allows for easy numerical aggregation to calculate return rates and financial impact.

- df['Order Fulfillment Time'] = (df['Ship Date'] - df['Order Date']).dt.days: Calculated the time (in days) between an order being placed and shipped. This is a key metric for logistics efficiency.

- df['Product Cost'] = df['Sales'] - df['Profit']: Calculated the underlying cost of goods sold.

- df['Profit Margin'] = np.where(df['Sales'] == 0, 0, df['Profit'] / df['Sales']): Created the critical profit margin metric, which measures efficiency (Profit per $1 of Sales). np.where was used to prevent divide-by-zero errors.

- df['Markup Percentage'] = np.where(df['Product Cost'] == 0, 0, (df['Profit'] / df['Product Cost']) * 100): Created the markup metric, which measures pricing strategy (Profit per $1 of Cost).

- df['Shipping_Cost_Pct_Sales'] = (df['Shipping Cost'] / df['Sales']) * 100: Created a metric to see which items have disproportionately high shipping costs relative to their sale price.

- profit_vs_shipping['Profit_After_Shipping'] = ...: This powerful metric subtracts Total_Shipping_Cost from Total_Profit to find the true profitability of product sub-categories, revealing that items like 'Machines' and 'Chairs' are unprofitable once shipping is factored in.

3.3. Profitability Analysis (BCG Matrix Concept)

To find the true profit drivers, I analyzed product sub-categories by both volume and efficiency, applying the concepts of a BCG (Boston Consulting Group) matrix.

• Code Explanation:

- sub_category_analysis = df.groupby('Sub-Category').agg(...): Aggregated Total_Sales and Total_Profit for all 17 sub-categories.

- pd.merge(sub_category_analysis, category_map, ...): Merged in the parent category ('Furniture', 'Technology', 'Office Supplies') to add a strategic layer to the visualizations.

**Bar Plot Visualization (sns.barplot):**

- This plot's bar length is mapped to Total_Profit (volume).

- The bar color is mapped to Profit_Margin (efficiency) using the coolwarm palette.

- Insight: This dual-encoding immediately highlights problem areas. "Tables" has a long bar (high sales/loss) but is colored bright red (negative margin), flagging it as a major profit drain.

• Scatter Plot (Quadrant Analysis):

- This plot maps Total_Sales (X-axis) vs. Profit_Margin (Y-axis) and uses hue to color by Category.

- Insight: This is a classic business strategy plot.

- Stars (Top-Right): 'Copiers' and 'Phones' (Technology) have high sales and high margins.

- Problem Children (Bottom-Right): 'Tables', 'Bookcases', and 'Chairs' (Furniture) have high sales but low/negative margins.

- Opportunities (Top-Left): 'Paper' has the highest margin in the company but low sales.

- Dogs (Bottom-Left): 'Fasteners' and 'Supplies' have low sales and low margins.

3.4. Customer Segmentation (RFM Analysis)

To understand customer behavior, I applied RFM (Recency, Frequency, Monetary) segmentation, a powerful marketing technique.

• Code Explanation:

- groupby('Customer ID').agg(...): Calculated the raw Recency (days since last order), Frequency (total unique orders), and Monetary (total sales) value for every customer.

- pd.qcut(...): Scored each customer from 1 (worst) to 5 (best) for each of the three metrics.

- assign_segment(): A custom function was used to assign descriptive names based on their R and F scores.

- Insight: This moves beyond the static 'Consumer' segment to identify behavioral groups. The analysis revealed key segments like:

I. Champions: ~430 high-value customers who buy often, spend a lot, and bought recently.

II. At Risk: ~370 customers who used to buy frequently but haven't returned in a while.

- Visualization (sns.countplot): The bar chart was ordered by each segment's Avg_Monetary value, providing a clear view of which customer groups are most valuable.

3.5. Market Basket & Operational Analysis

This section identified co-purchase patterns and quantified operational impacts.

• Code Explanation (Market Basket):

-  itertools.combinations & collections.Counter: These tools were used to find and count the most common pairs of sub-categories purchased within the same Order ID.

- Insight: 'Binders' and 'Storage' are the most common pair, suggesting a bundling opportunity. More critically, the unprofitable 'Tables' are frequently purchased with profitable items, indicating they are dragging down the average cart value.

• Code Explanation (Discounting):

- pd.cut(...): Binned the discount percentages (0.1, 0.15, 0.2, etc.) into clean groups ('0-10%', '10-20%').

- Insight: The dual-axis chart plotting Total_Sales vs. Average_Profit_Margin for these bins clearly shows that the tipping point for profitability is ~25%. Any discount higher than this results in an average loss.

• Code Explanation (Management Performance):

- groupby('Person').agg(...): Created a management scorecard with Total_Sales, Total_Profit, Total_Orders, and derived efficiency metrics (Avg_Profit_Margin, Profit_Per_Order).

- Insight: The scatter plot (Total_Sales vs. Avg_Profit_Margin) provided a balanced view of performance. It identified managers like Nicole Hansen as highly efficient (27% margin) in a small market, and managers like Alejandro Ballentine as highly inefficient (2% margin) in a large market.

## 4. Key Findings Summary

1. "Tables" are a Crisis: The 'Tables' sub-category is the single biggest profit drain, losing over $66,000 in gross profit and $141,000 after shipping costs, despite generating $717,000 in sales.

2. Discounts Kill Profit: Discounts above 25% are consistently unprofitable.

3. Shipping Wipes Out Gains: High shipping costs, representing over 10% of sales for bulky items, eliminate all profits for 'Machines' and 'Chairs'.

4. Customer Segments are Actionable: The business has a large base of high-value 'Champions' to nurture, but also a significant 'At Risk' segment (customers who haven't bought in 3-9 months) that requires immediate re-engagement.

5. Manager Performance is Unbalanced: Some managers (like Alejandro Ballentine, 2% margin) are "busy but not profitable," while others (like Nicole Hansen, 27% margin) are "efficient but not busy."

## 5. Actionable Recommendations

• Product Strategy:

1. Fix or Remove 'Tables': Immediately conduct a full review of the 'Tables' category. Increase prices, cut all discounts, renegotiate costs, or delist the most unprofitable models.

2. Optimize 'Machines' & 'Chairs': The profits for these items are lost to shipping. Implement shipping surcharges for these bulky categories or require a minimum order value to make them viable.

3. Grow 'Paper': Promote 'Paper' (the most efficient item at a 25% margin) as an add-on or cross-sell to high-volume orders to increase overall cart profitability.

• Pricing Strategy: 4. Cap Discounts: Implement a hard rule capping discounts at 25% for most items, with higher exceptions only for 'Copiers' and 'Phones'. 5. Bundle Smart: Offer a 'Binders & Storage' bundle (the most common pair) but ensure the bundle discount does not erode margins below the 6.79% company average.

• Marketing Strategy: 6. Segmented Campaigns: Launch two distinct marketing campaigns: A Loyalty Program for 'Champions' and 'Loyal Customers'.  A "We Miss You" Re-engagement Campaign with a smart, one-time offer for the 'At Risk' segment.

• Operational Strategy: 7. Share Best Practices: Analyze the strategies of high-efficiency managers (Nicole Hansen, Shirley Daniels) and create a best-practice-guide for low-efficiency managers (Alejandro Ballentine, Chuck Magee) to improve their margins.



