-- ==============================================
-- SQL Business Intelligence for EV Charging Stations
-- Dataset: U.S. EV Charging Stations (Open Data)
-- Author: Jenny Tran
-- Description: This script analyzes EV station performance,
-- utilization, availability, and efficiency.
-- ==============================================

-- 1️⃣ Total Number of Charging Stations by State
-- This query provides a state-by-state breakdown of the number of available charging stations.
SELECT 
    state,
    COUNT(station_id) AS total_stations
FROM ev_charging_stations
WHERE status = 'Operational'
GROUP BY state
ORDER BY total_stations DESC;

-- 2️⃣ Identifying Peak Charging Hours
-- This query analyzes usage data to determine the busiest hours for EV charging.
SELECT 
    EXTRACT(HOUR FROM start_time) AS charging_hour,
    COUNT(session_id) AS total_sessions
FROM charging_sessions
GROUP BY charging_hour
ORDER BY total_sessions DESC;

-- 3️⃣ Availability of Fast Charging (DC) Stations
-- This query finds the percentage of stations that offer DC fast charging.
SELECT 
    COUNT(CASE WHEN charger_type = 'DC Fast' THEN 1 END) * 100.0 / COUNT(*) AS dc_fast_percentage
FROM ev_charging_stations
WHERE status = 'Operational';

-- 4️⃣ Station Utilization Rate
-- This query calculates the average number of sessions per charging station.
SELECT 
    station_id,
    COUNT(session_id) AS total_sessions,
    ROUND(COUNT(session_id) / (SELECT COUNT(DISTINCT station_id) FROM charging_sessions), 2) AS avg_sessions_per_station
FROM charging_sessions
GROUP BY station_id
ORDER BY total_sessions DESC
LIMIT 10;

-- 5️⃣ Identifying Underutilized Stations
-- This query identifies stations with fewer than 5 charging sessions per day.
SELECT 
    station_id,
    COUNT(session_id) AS total_sessions
FROM charging_sessions
GROUP BY station_id
HAVING COUNT(session_id) < 5
ORDER BY total_sessions ASC;

-- 6️⃣ Average Charging Time by Charger Type
-- This query compares average charging duration for different charger types.
SELECT 
    charger_type,
    ROUND(AVG(end_time - start_time), 2) AS avg_charging_duration
FROM charging_sessions
GROUP BY charger_type
ORDER BY avg_charging_duration DESC;

-- 7️⃣ Fastest Growing States for EV Charging Stations
-- This query identifies states with the highest growth in charging station installations.
SELECT 
    state,
    COUNT(station_id) AS new_stations,
    COUNT(station_id) - LAG(COUNT(station_id), 1) OVER (ORDER BY year) AS growth_rate
FROM ev_charging_stations
WHERE status = 'Operational'
GROUP BY state, year
ORDER BY growth_rate DESC
LIMIT 10;

-- 8️⃣ Average Revenue Per Charging Station
-- This query estimates the revenue per station based on session pricing.
SELECT 
    station_id,
    SUM(price_per_kwh * energy_consumed_kwh) AS total_revenue,
    ROUND(AVG(price_per_kwh * energy_consumed_kwh), 2) AS avg_revenue_per_session
FROM charging_sessions
GROUP BY station_id
ORDER BY total_revenue DESC
LIMIT 10;

-- 9️⃣ Charger Availability by City
-- This query ranks cities with the highest availability of chargers.
SELECT 
    city,
    COUNT(charger_id) AS total_chargers
FROM ev_charging_stations
WHERE status = 'Operational'
GROUP BY city
ORDER BY total_chargers DESC
LIMIT 10;

-- 🔟 Charging Station Downtime Analysis
-- This query finds stations with the most downtime occurrences.
SELECT 
    station_id,
    COUNT(CASE WHEN status = 'Non-Operational' THEN 1 END) AS downtime_count
FROM ev_charging_stations
GROUP BY station_id
ORDER BY downtime_count DESC
LIMIT 10;
