--===============================================================================
--LOOK FOR NULL VALUES THROUGHOUT THE ANNUAL TABLE
--===============================================================================

-- calculating
-- difference between the total count of all records 
-- and 
-- the count of records where the (respective) column is not null
-- this would give you the count of records where (respective) column is null
SELECT 
 COUNT(*) - COUNT(ride_id) as ride_id,
 COUNT(*) - COUNT(rideable_type) as rideable_type,
 COUNT(*) - COUNT(started_at) as started_at,
 COUNT(*) - COUNT(ended_at) as ended_at,
 COUNT(*) - COUNT(start_station_name) as start_station_name,
 COUNT(*) - COUNT(start_station_id) as start_station_id,
 COUNT(*) - COUNT(end_station_name) as end_station_name,
 COUNT(*) - COUNT(end_station_id) as end_station_id,
 COUNT(*) - COUNT(start_lat) as start_lat,
 COUNT(*) - COUNT(start_lng) as start_lng,
 COUNT(*) - COUNT(end_lat) as end_lat,
 COUNT(*) - COUNT(end_lng) as end_lng,
 COUNT(*) - COUNT(member_casual) as member_casual
FROM `cyclistic_dataset.2022-annual`;


--===============================================================================
--EXPLORE DATA ONE BY ONE FROM LEFT COLUMN TO RIGHT COLUMN
--===============================================================================

-- 1. rider_id: the length of the rider id should be uniform ====================
SELECT 
    LENGTH(ride_id) as rider_id_length
FROM 
    `cyclistic_dataset.2022-annual`
GROUP BY 
    LENGTH(ride_id); 
-- INSIGHT: the ride_id is consistent with 16 characters


-- 2. rideable_type: determine the type of bikes ================================
SELECT 
    rideable_type
FROM 
    `cyclistic_dataset.2022-annual`
GROUP BY 
    rideable_type; 
-- INSIGHT: there are three types of bike: classic, electric and docked 


-- 3. started_at, ended_at: ride duration =======================================
SELECT 
    ride_id, started_at, ended_at
FROM 
    `cyclistic_dataset.2022-annual`
WHERE 
    TIMESTAMP_DIFF(ended_at, started_at, MINUTE) <= 1 
    OR
    TIMESTAMP_DIFF(ended_at, started_at, MINUTE) >= 1440;
-- the end time is behind the start time
-- TIMESTAMP is in YYYY-MM-DD hh:mm:ss UTC format
-- INSIGHT: Returned rows when the ride time is less than a minute or longer than a day


-- 4. name & id of start_station and end_station ================================
SELECT 
    DISTINCT start_station_name, COUNT(*) AS start_station_count
FROM 
    `cyclistic_dataset.2022-annual`
GROUP BY 
    start_station_name;
-- INSIGHT: In total, 833064 start_station_name with null values are returned

SELECT 
    DISTINCT end_station_name, COUNT(*) AS end_station_count
FROM 
    `cyclistic_dataset.2022-annual`
GROUP BY 
    end_station_name;
-- INSIGHT: In total, 892742 end_station_name with null values are returned 

SELECT 
    DISTINCT start_station_id, end_station_id
FROM 
    `cyclistic_dataset.2022-annual`
WHERE 
    start_station_id IS NOT NULL 
    OR
    end_station_id IS NOT NULL;
-- INSIGHT: Null values observed & the string lengths of station id are inconsistent. 
--          However, We can ignore station id as it is not important for our analysis


-- 5. Latitude(lat) & Longitude(lng) of start and end ===========================
SELECT 
    * 
FROM 
    `cyclistic_dataset.2022-annual`
WHERE
    start_lat IS NULL 
        OR
    start_lng IS NULL 
        OR
    end_lat IS NULL 
        OR
    end_lng IS NULL;
-- INSIGHT: 5858 null values returned

-- 6. member_casual: type of membership ========================================
SELECT 
    member_casual, 
    COUNT(*) as membership_count
FROM 
    `cyclistic_dataset.2022-annual`
GROUP BY 
    member_casual;
-- INSIGHT: 2 types: Member & Casual. Total membership count = Total number of rows
-- COUNT: Casual - 2322032
-- COUNT: Member - 3345685