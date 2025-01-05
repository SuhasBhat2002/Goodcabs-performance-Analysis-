USE trips_db;
SHOW TABLES;
-- Bussness Request 5 Heighest revenue for each month
SELECT *
FROM fact_trips;

SELECT *
FROM dim_date;

SELECT 
	c.city_name,
    DATE_FORMAT(f.date, '%M') AS month,
    SUM(fare_amount) AS revenue,
ROUND(
        (SUM(f.fare_amount) * 100.0) /(SELECT SUM(f2.fare_amount)
                                        FROM fact_trips f2
                                        JOIN dim_date d2 ON f2.date = d2.date) ,
        2
    ) AS percent_contribution
FROM fact_trips f
JOIN dim_city c ON f.city_id = c.city_id
JOIN dim_date d ON f.date = d.date
GROUP BY month, city_name;