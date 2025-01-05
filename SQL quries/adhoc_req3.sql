USE trips_db;
SHOW TABLES;
-- Bussness Request 3 City Level Repeat Passenger Trip frequency Report
SELECT *
FROM dim_repeat_trip_distribution;

SELECT 
	c.city_name,
    ROUND((SUM(CASE WHEN r.trip_count = "2-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_2_perc,
    ROUND((SUM(CASE WHEN r.trip_count = "3-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_3_perc,
    ROUND((SUM(CASE WHEN r.trip_count = "4-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_4_perc,
    ROUND((SUM(CASE WHEN r.trip_count = "5-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_5_perc,
    ROUND((SUM(CASE WHEN r.trip_count = "6-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_6_perc,
    ROUND((SUM(CASE WHEN r.trip_count = "7-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_7_perc,
    ROUND((SUM(CASE WHEN r.trip_count = "8-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_8_perc,
    ROUND((SUM(CASE WHEN r.trip_count = "9-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_9_perc,
    ROUND((SUM(CASE WHEN r.trip_count = "10-Trips" THEN r.repeat_passenger_count ELSE 0 END)/SUM(r.repeat_passenger_count))*100,2) AS trip_10_perc
FROM dim_repeat_trip_distribution r
JOIN dim_city c ON r.city_id = c.city_id
GROUP BY city_name;