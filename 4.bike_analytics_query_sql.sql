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
