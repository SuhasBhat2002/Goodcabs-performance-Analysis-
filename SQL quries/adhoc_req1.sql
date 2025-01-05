USE trips_db;
SHOW TABLES;
-- Bussness Request 1 - City Level fare and Trip Summary Report
SELECT *
FROM fact_trips;

SELECT 
    c.city_name, 
    COUNT(t.trip_id) AS total_trips, 
    SUM(t.fare_amount) / SUM(t.distance_travelled_km) AS fare_per_km, 
    AVG(t.fare_amount) AS fare_per_trip, 
    ROUND(COUNT(t.trip_id) / NULLIF((SELECT COUNT(trip_id) FROM fact_trips), 0) * 100, 2) AS trip_contribution_percentage
FROM 
    fact_trips t
JOIN 
    dim_city c 
    ON t.city_id = c.city_id
GROUP BY 
    c.city_name;
