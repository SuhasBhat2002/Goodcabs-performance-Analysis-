USE trips_db;
SHOW TABLES;
-- Bussness Request 2 - Monthly citl level trips target performance Report
SELECT *
FROM dim_date;

SHOW TABLES FROM targets_db;

SELECT *
FROM targets_db.monthly_target_trips;

WITH target_t AS (
    SELECT 
        DATE_FORMAT(month, '%M') AS month_name, 
        city_id, 
        total_target_trips
    FROM 
        targets_db.monthly_target_trips
)


SELECT 
    c.city_name,
    m.month_name,
    COUNT(f.trip_id) AS actual_trips,
    tt.total_target_trips,
    CASE WHEN COUNT(f.trip_id) > total_target_trips THEN 'Above Target'
	 WHEN COUNT(f.trip_id) < total_target_trips THEN 'Below Target'
     ELSE 'Met'
     END AS performance_status,
	ROUND((COUNT(f.trip_id) - tt.total_target_trips) / tt.total_target_trips * 100,2) AS difference_percentage
FROM 
    fact_trips f
JOIN dim_city c ON f.city_id = c.city_id
JOIN dim_date m ON f.date = m.date
JOIN target_t tt ON m.month_name = tt.month_name AND f.city_id = tt.city_id
GROUP BY c.city_name, m.month_name;
