USE trips_db;
SHOW TABLES;
-- Bussness Request 4 Highest and Lowest city based on New Passengers
SELECT *
FROM fact_passenger_summary;

SELECT 
	c.city_name,
    SUM(s.new_passengers) AS total_new_passengers,
    RANK() OVER(ORDER BY SUM(s.new_passengers) DESC) AS cities_rank
FROM fact_passenger_summary s
JOIN dim_city c ON s.city_id = c.city_id
GROUP BY city_name;