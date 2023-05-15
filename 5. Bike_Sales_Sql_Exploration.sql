-- Create View or Temporary Table -- Table Name: Analytics Query

create or replace table `sqlproject-379113.bike_sales.analytics_query` as(select
    a.Date,
    a.Year,
    a.Day_Name,
    a.Month_Name,
    a.Weekend_Flag,
    b.Customer_Age,
    b.Customer_Gender,
    b.Customer_Age_Group,
    c.State,
    c.Country,
    d.Product_Category,
    d.Sub_Category,
    d.Product,
    e.Order_Quantity,
    e.Unit_Cost,
    e.Unit_Price,
    e.Cost,
    f.Profit,
    f.Revenue
from `sqlproject-379113.bike_sales.Bike_date_dim` a
join `sqlproject-379113.bike_sales.Bike_Customr_dim` b on a.Date_Id=b.Customer_Id
join `sqlproject-379113.bike_sales.Bike_demographic_dim` c on a.Date_Id=c.Demographic_Id
join `sqlproject-379113.bike_sales.bike_product_dim` d on a.Date_Id=d.Product_Id
join `sqlproject-379113.bike_sales.bike_order_dim` e on a.Date_Id=e.Order_info_Id
join `sqlproject-379113.bike_sales.fact_table` f on a.Date_Id=f.Order_Id);


-- Total Row Number
select
    count(*) as total_row
from 
    `sqlproject-379113.bike_sales.analytics_query`;

-- Total Revenue
select
    sum(Revenue) as total_Revenue
from 
    `sqlproject-379113.bike_sales.analytics_query`;

   
-- Total Revenue
select
    avg(Revenue) as avg_Revenue
from 
    `sqlproject-379113.bike_sales.analytics_query`;

   
-- Total Profit
select
    sum(Profit) as avg_Revenue
from 
    `sqlproject-379113.bike_sales.analytics_query`;

   
-- Total Profit
select
    round(avg(Profit),2) as avg_Profit
from 
    `sqlproject-379113.bike_sales.analytics_query`;

-- Avg Age 
select
    avg(Customer_Age) as avg_Age
from 
    `sqlproject-379113.bike_sales.analytics_query`;

-- Profit Margin
select
    (sum(Profit)/sum(Revenue)*100) as Profit_Margin
from
  `sqlproject-379113.bike_sales.analytics_query`;


-- Gender by Revenue\\

select
    Customer_Gender,
    count(Customer_Gender) as cnt,
    sum(Revenue) as Total_Sales
from
   `sqlproject-379113.bike_sales.analytics_query`
group by Customer_Gender
order by Total_Sales ,cnt desc;

-- Gender by Profit\\

select
    Customer_Gender,
    count(Customer_Gender) as cnt,
    sum(Profit) as Total_Profit
from
   `sqlproject-379113.bike_sales.analytics_query`
group by Customer_Gender
order by Total_Profit,cnt desc;

-- Customer Age Group by Revenue\\

select
    Customer_Age_Group,
    count(Customer_Age_Group) as cnt,
    sum(Revenue) as Total_Sales
from
   `sqlproject-379113.bike_sales.analytics_query`
group by Customer_Age_Group
order by Total_Sales desc ,cnt desc;

-- Gender by Profit\\

select
    Customer_Age_Group,
    count(Customer_Age_Group) as cnt,
    sum(Profit) as Total_Profit
from
   `sqlproject-379113.bike_sales.analytics_query`
group by Customer_Age_Group
order by Total_Profit desc,cnt desc;

-- Year by Profit
select
   Year,
    sum(Revenue) as Total_Sales
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
      Year
order by
     Total_Sales desc;


-- Year by Profit
select
   Year,
    sum(Profit) as Total_Profit
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
      Year
order by
     Total_Profit desc;



-- Day by Revenue
select
   Day_Name,
    sum(Revenue) as Total_Sales
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
      Day_Name
order by
     Total_Sales desc;


-- Day by Profit
select
   Day_Name,
    sum(Profit) as Total_Profit
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
    Day_Name
order by
     Total_Profit desc;



-- Country USA vs Revenue
select
   Country,
   Product_Category,
   sum(Revenue) as total_sales
from
   `sqlproject-379113.bike_sales.analytics_query`
where country="United States"
group by
     Country,Product_Category
order by
     total_sales desc;


-- Weekend Flag Profit

select
    Weekend_Flag,
    count(Weekend_Flag) as cnt,
    sum(Profit) as total_Profit
from
   `sqlproject-379113.bike_sales.analytics_query`
where Year=2022
group by
     Weekend_Flag;


select
    Country,
    Customer_Age_Group,
    Product_Category,
    sum(Revenue) as total_Revenue
from `sqlproject-379113.bike_sales.analytics_query`
group by 
    Country,
    Customer_Age_Group,
    Product_Category
   order by
        total_Revenue desc;

-- Top Proudct Category by Revenue

select
     Product_Category,
     sum(Revenue) as Revenue
from
   `sqlproject-379113.bike_sales.analytics_query`
group by Product_category
order by Revenue desc
limit 1;

-- Top Proudct Category by Profit

select
     Product_Category,
     sum(Profit) as Profit
from
   `sqlproject-379113.bike_sales.analytics_query`
group by Product_category
order by Profit desc
limit 1;


-- Bottom 10  Proudct  by Revenue

select
     Product,
     sum(Revenue) as Revenue
from
   `sqlproject-379113.bike_sales.analytics_query`
group by Product
order by Revenue Asc
limit 10;


-- Top 10  Proudct  by Revenue

select
     Product,
     count(Product) as cnt,
     sum(Revenue) as Revenue
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
     Product
order by
     Revenue desc,cnt desc
limit 10;


-- Top 5 Sub_category  by Revenue

select
     Sub_category,
     count(Sub_category) as cnt,
     sum(Revenue) as Revenue
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
     Sub_category
order by
     Revenue desc,cnt desc
limit 5;


-- Bottom 5 Sub_category  by Revenue

select
     Sub_category,
     count(Sub_category) as cnt,
     sum(Revenue) as Revenue
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
     Sub_category
order by
     Revenue asc
limit 5;

-- Bottom 5 Sub_category  by Profit

select
     Sub_category,
     count(Sub_category) as cnt,
     sum(Profit) as Profit
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
     Sub_category
order by
     Profit asc
limit 5;

select
    *
from `sqlproject-379113.bike_sales.analytics_query`;

--- Top 2 Product Each Category by Revenue
with rnk as(select
    Sub_Category,
    Product,
    Revenue,
    dense_rank() over( partition by Sub_Category order by Revenue desc) as rn
from `sqlproject-379113.bike_sales.analytics_query`)
select
   Sub_Category,
   sum(Revenue) as Revenue,
   rn
from rnk
where rn<2
group by Sub_Category,rn
ORDER BY Revenue desc;

--- Year to Year Growth

WITH cte AS (
  SELECT
    Year,
    SUM(Revenue) AS TotalRevenue
  FROM
    `sqlproject-379113.bike_sales.analytics_query`
  GROUP BY
    Year
)
SELECT
  Year,
  TotalRevenue,
  LAG(TotalRevenue) OVER (ORDER BY Year) AS PreviousYearRevenue,
  LEAD(TotalRevenue) OVER (ORDER BY Year) AS NextYearRevenue,
  (TotalRevenue - LAG(TotalRevenue) OVER (ORDER BY Year)) / LAG(TotalRevenue) OVER (ORDER BY Year) AS YOYGrowthRate
FROM
  cte
ORDER BY
  Year;



-- Female and Male count by country
select
    Customer_Gender,
    Country,
    count(Customer_Gender) as Cnt
from
   `sqlproject-379113.bike_sales.analytics_query`
group by
   Country,Customer_Gender;


   -- Product Category and Country by revenue

   select
       Product_Category,
       Country,
       count(*) as cnt,
       sum(Revenue) as Total_Sales
   from 
      `sqlproject-379113.bike_sales.analytics_query`
   group by
        Product_Category,
       Country;

-- Product Category and Country by Profit

   select
       Product_Category,
       Country,
       count(*) as cnt,
       sum(Profit) as Total_profit
   from 
      `sqlproject-379113.bike_sales.analytics_query`
   group by
        Product_Category,
       Country;


--- Year to Year Profit

WITH cte AS (
  SELECT
    Year,
    SUM(Profit) AS TotalProfit
  FROM
    `sqlproject-379113.bike_sales.analytics_query`
  GROUP BY
    Year
)
SELECT
  Year,
  TotalProfit,
  LAG(TotalProfit) OVER (ORDER BY Year) AS PreviousYearRevenue,
  (((TotalProfit - LAG(TotalProfit) OVER (ORDER BY Year)) / LAG(TotalProfit) OVER (ORDER BY Year))*100) AS YOYGrowthRate
FROM
  cte
ORDER BY
  Year;

