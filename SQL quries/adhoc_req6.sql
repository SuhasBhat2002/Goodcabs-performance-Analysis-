USE trips_db;
SHOW TABLES;
-- Bussness Request 5 Heighest revenue for each month
SELECT *
FROM fact_trips;

WITH city_totals AS (
    SELECT 
        c.city_name,
        COUNT(f.trip_id) AS total_city_passengers,
        COUNT(CASE WHEN f.passenger_type = 'repeated' THEN 1 END) AS total_city_repeat_passengers
    FROM fact_trips f
    JOIN dim_city c ON f.city_id = c.city_id
    GROUP BY c.city_name
)
SELECT 
    c.city_name,
    DATE_FORMAT(f.date, '%M') AS month,
    COUNT(f.trip_id) AS total_passengers,
    COUNT(CASE WHEN f.passenger_type = 'repeated' THEN 1 END) AS total_repeat_passengers,
    ROUND(
        100 * COUNT(CASE WHEN f.passenger_type = 'repeated' THEN 1 END) / COUNT(f.trip_id), 
        2
    ) AS monthly_repeat_passenger_rate,
    ROUND(
        100 * city_totals.total_city_repeat_passengers / city_totals.total_city_passengers, 
        2
    ) AS city_repeat_passenger_rate
FROM fact_trips f
JOIN dim_city c ON f.city_id = c.city_id
JOIN city_totals 
    ON c.city_name = city_totals.city_name
GROUP BY 
    c.city_name, 
    DATE_FORMAT(f.date, '%M'), 
    city_totals.total_city_passengers, 
    city_totals.total_city_repeat_passengers;



