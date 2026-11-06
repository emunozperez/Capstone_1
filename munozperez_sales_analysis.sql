-- New Jersey Sales Analysis 

USE sample_sales;

-- What is total revenue overall for sales in the assigned territory, plus the start date and end date
-- that tell you what period the data covers?
SELECT
   SUM(Sale_Amount) Total_Sales,
   MIN(ss.Transaction_Date) AS Start_Date,
   MAX(ss.Transaction_Date) AS End_Date
FROM Store_Sales AS ss
JOIN Store_Locations AS sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New Jersey';
-- What is the revenue breakdown by year and month for the sales territory?
SELECT
    YEAR(ss.Transaction_Date) AS Sales_Year,
    MONTH(ss.Transaction_Date) AS Sales_Month,
    SUM(ss.Sale_Amount) AS Monthly_Revenue
FROM Store_Sales AS ss
JOIN Store_Locations AS sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New Jersey'
GROUP BY
    YEAR(ss.Transaction_Date),
    MONTH(ss.Transaction_Date)
ORDER BY
    Sales_Year,
    Sales_Month;
    -- Provide a comparison of total revenue for the specific sales territory and the region it belongs to.
    SELECT
    m.Region,
    SUM(ss.Sale_Amount) AS Total_Revenue
FROM Store_Sales AS ss
JOIN Store_Locations AS sl
    ON ss.Store_ID = sl.StoreId
JOIN Management AS m
    ON sl.State = m.State
WHERE m.Region = 'Northeast'
GROUP BY
    m.Region;
-- What is the number of transactions per month and average transaction amount by product
-- category for the sales territory?
SELECT
   YEAR(Transaction_Date) Year,
   MONTH(Transaction_Date) Month, 
   ic.Category Category, 
   COUNT(Sale_Amount) Transaction_Count,
   ROUND(AVG(Sale_Amount), 2) Average_Sales
FROM store_sales ss
JOIN store_locations sl
	ON ss.Store_ID = sl.StoreID
JOIN products p
	ON p.Prodnum = ss.Prod_Num
JOIN inventory_categories ic
	ON ic.Categoryid = p. Categoryid
WHERE State = 'New Jersey'
GROUP BY 
	YEAR(Transaction_Date),
    MONTH(Transaction_Date),
    ic.Category;
-- Can you provide a ranking of in-store sales performance by each store in the sales territory, or a
-- ranking of online sales performance by state within an online sales territory?

SELECT
    sl.StoreId AS Store_ID,
    sl.StoreLocation AS Store_Location,
    ic.Category AS Product_Category,
    COUNT(*) AS Total_Category_Sales
FROM Store_Sales AS ss
JOIN Store_Locations AS sl
    ON ss.Store_ID = sl.StoreId
JOIN Products AS p
    ON ss.Prod_Num = p.ProdNum
JOIN Inventory_Categories AS ic
    ON p.Categoryid = ic.Categoryid
WHERE sl.State = 'New Jersey'
GROUP BY
    sl.StoreId,
    sl.StoreLocation,
    ic.Category
ORDER BY
    ic.Category,
    Total_Category_Sales DESC;
    
-- Based on the analysis of New Jersey in-store sales, I recommend focusing next quarter on the Paterson location since they made less than 
-- $70,000 while the other locations have made over $250,000. I also suggest focusing on Apparel and Merchandise or Sationary and Supplies 
-- since Apparel and Merchandise has kept high sales over the years, Stationary and Supplies has made a large but steady climb in sales aswell. 

-- To improve performance next quarter, I recommend:
-- Focus on high-performing categories: Maintain inventory and support for categories generating strong revenue.
-- Investigate underperforming stores: Review possible reasons for lower sales and identify opportunities for improvement.
-- Monitor monthly trends: Use historical revenue patterns to support planning for upcoming sales periods.