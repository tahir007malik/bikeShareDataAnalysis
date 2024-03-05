--===============================================================================
-- ANALYZING NEW CLEANED DATA TABLE FOR EXTRACTING INSIGHTS
--===============================================================================


-- Types of bike
SELECT 
    member_casual, 
    rideable_type, 
    COUNT(*) AS total_rides
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
GROUP BY 
    member_casual, 
    rideable_type
ORDER BY 
    member_casual, 
    total_rides ASC;
-- total rides for member with classic bike is the highest (1651328) 
-- while lowest (172397) for casual with docked_bike 


-- No. of rides per month
SELECT 
    member_casual, 
    month, 
    COUNT(*) AS total_rides_per_month
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
GROUP BY 
    member_casual, month
ORDER BY 
    member_casual;

-- No.of rides per day of week 
SELECT 
    member_casual, 
    day_of_week,COUNT(*) AS total_rides_per_week
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
GROUP BY 
    member_casual,day_of_week
ORDER BY 
    member_casual;


-- No. of trips per hour
SELECT 
    member_casual, 
    EXTRACT(HOUR FROM started_at) AS hour_of_day, 
    COUNT(*) AS total_trips
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
GROUP BY 
    member_casual,hour_of_day
ORDER BY 
    member_casual;


-- Average ride length per day of week
SELECT 
    member_casual, 
    day_of_week, 
    AVG(ride_length_in_mins) AS avg_ride_length, -- AVG(ride_length_in_mins) gives you the average ride length for each day of the week for each type of rider
    AVG(AVG(ride_length_in_mins)) OVER(PARTITION BY member_casual) AS combined_avg_ride_length -- AVG(AVG(ride_length_in_mins)) OVER(PARTITION BY member_casual) gives you the average ride length for each type of rider across all days of the week
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
GROUP BY 
    member_casual, day_of_week
ORDER BY 
    member_casual;


-- Starting location for member
SELECT 
    member_casual, 
    start_station_name,
    AVG(start_lat) AS start_lat, 
    AVG(start_lng) AS start_lng,
    COUNT(*) AS total_rides
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
WHERE 
    member_casual = 'casual'
GROUP BY 
    member_casual, 
    start_station_name;


-- Ending location for member
SELECT 
    member_casual, 
    end_station_name,
    AVG(end_lat) AS end_lat, 
    AVG(end_lng) AS end_lng,
    COUNT(*) AS total_rides
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
WHERE 
    member_casual = 'member'
GROUP BY 
    member_casual, end_station_name;


-- Starting location for casual
SELECT 
    member_casual, 
    start_station_name,
    AVG(start_lat) AS start_lat, 
    AVG(start_lng) AS start_lng,
    COUNT(*) AS total_rides
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
WHERE 
    member_casual = 'casual'
GROUP BY 
    member_casual, start_station_name;


-- Ending location for casual 
SELECT 
    member_casual, 
    end_station_name,
    AVG(end_lat) AS end_lat, 
    AVG(end_lng) AS end_lng,
    COUNT(*) AS total_rides
FROM 
    `cyclistic_dataset.2022-annual-cleaned`
WHERE 
    member_casual = 'member'
GROUP BY 
    member_casual, 
    end_station_name;