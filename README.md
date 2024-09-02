### Project Title: RFM Analysis for Customer Segmentation

**Project Overview:**
This project involved conducting an RFM (Recency, Frequency, Monetary) analysis using SQL on a dataset. 

The goal was to segment customers based on their purchasing behavior and provide actionable insights for targeted marketing strategies. The analysis used one year of data from 2010-12-01 to 2011-12-01, focusing on identifying key customer groups for better engagement and retention efforts.

**Objectives:**
- Calculate RFM values for each customer using data within a specified timeframe.
- Score each customer on recency, frequency, and monetary value using quartiles, resulting in R, F, and M scores ranging from 1 to 4.
- Generate a common RFM score to effectively segment the customers.
- Categorize customers into distinct segments such as Best Customers, Loyal Customers, Big Spenders, and others based on their RFM scores.
- Present the findings in a clear and interactive dashboard using Tableau, Power BI, or Looker Studio.
- Provide insights and recommendations on which customer groups should be prioritized by the marketing team.

**Methodology:**
1. **Data Selection and Preparation:**
   - Extracted data from the "rfm" table within the database.
   - Filtered data to include transactions from 2010-12-01 to 2011-12-01.
   - Calculated recency from the reference date of 2011-12-01.
   
2. **RFM Calculation:**
   - Used SQL's `APPROX_QUANTILES` function to divide recency, frequency, and monetary values into quartiles.
   - Assigned R, F, and M scores between 1 and 4 based on these quartiles.

3. **Customer Segmentation:**
   - Combined the R, F, and M scores to generate a common RFM score for each customer.
   - Segmented customers into 11 distinct groups:
     1. Best Customers
     2. Big Spenders
     3. Loyal Customers
     4. Promising
     5. Customers Needing Attention
     6. New Customers
     7. At Risk
     8. About to Sleep
     9. Can’t Lose Them
     10. Hibernating
     11. Lost

4. **Visualization and Insights:**
   - Created a Tableau dashboard to visualize customer segments, highlighting key metrics and trends.
   - Identified customer groups with the highest potential for marketing efforts and provided recommendations for targeted strategies.

**Results and Insights:**
- Best Customers and Loyal Customers were identified as the primary groups to focus on for retention strategies.
- Big Spenders showed potential for upselling and cross-selling opportunities.
- Customers Needing Attention and At Risk groups were highlighted for re-engagement campaigns to prevent churn.

**Tools Used:**
- **SQL** for data extraction and analysis.
- **Google sheets** for data report. 
- **Tableau** for data visualization.


**Conclusion:**
This project demonstrated the power of RFM analysis in understanding customer behavior and tailoring marketing efforts to specific customer segments. The insights gained enabled the formulation of strategic recommendations aimed at improving customer engagement, retention, and overall business performance.

---

This is the link to my [spreadsheet](https://docs.google.com/spreadsheets/d/1mNcXYXKZWFSwf5dKu3y57ZeLaViLOd9y6hWdJlKglYA/edit?usp=sharing) and my Tableau dashboard is [here](https://public.tableau.com/views/CLVandcustomersegmentation/Dashboard1?:language=en-GB&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link). 

Note: *I have also attached the .sql file to this repository*. You can also check the SQL Query [here](https://github.com/bayoxx/RFM-Analysis-for-Customer-Segmentation/blob/main/CLV%20and%20customer%20segmentation.sql) and the presentation slides [here](https://github.com/bayoxx/RFM-Analysis-for-Customer-Segmentation/blob/main/RFM%20SEGMENTATION.pdf) .

