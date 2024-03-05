--===============================================================================
--CREATED NEW TABLE WITH MODIFIED & CLEAN DATA
--===============================================================================


CREATE TABLE `cyclistic_dataset.2022-annual-cleaned` AS (
  SELECT 
    ride_id, 
    rideable_type,
    started_at,
    ended_at,
    ride_length_in_mins,
  CASE 
    EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'January'
      WHEN 2 THEN 'February'
      WHEN 3 THEN 'March'
      WHEN 4 THEN 'April'
      WHEN 5 THEN 'May'      
      WHEN 6 THEN 'June'
      WHEN 7 THEN 'July'
      WHEN 8 THEN 'August'
      WHEN 9 THEN 'September'
      WHEN 10 THEN 'October'      
      WHEN 11 THEN 'November'
      WHEN 12 THEN 'December'
  END AS month,
  CASE 
    EXTRACT(DAYOFWEEK FROM started_at)
      WHEN 1 THEN 'Sunday'
      WHEN 2 THEN 'Monday'
      WHEN 3 THEN 'Tuesday'
      WHEN 4 THEN 'Wednesday'
      WHEN 5 THEN 'Thursday'
      WHEN 6 THEN 'Friday'
      WHEN 7 THEN 'Saturday'    
  END AS day_of_week,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual,
  FROM 
    `cyclistic_dataset.2022-annual` AS t1
  JOIN 
    (
      SELECT 
        ride_id,
        TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length_in_mins
      FROM 
        `cyclistic_dataset.2022-annual`
    ) AS t2
  USING(ride_id)
  WHERE 
    ride_length_in_mins > 1 
    AND 
    ride_length_in_mins < 1440 
    AND
    start_station_name IS NOT NULL
    AND
    start_station_id IS NOT NULL 
    AND
    end_station_name IS NOT NULL 
    AND
    end_station_id IS NOT NULL 
    AND
    start_lat IS NOT NULL 
    AND
    start_lng IS NOT NULL 
    AND
    end_lat IS NOT NULL 
    AND
    end_lng IS NOT NULL
);

-- Added 2 new columns 'month' & 'day_of week' 
-- Where 1: Sunday, 2: Monday, 3: Tuesday, 4: Wednesday, 5: Thursday, 6: Friday, 7: Saturday  
-- Determined ride length in minutes 
-- Removed rows with null values 

-- ON vs Using (JOIN)
-- ON is the more general of the two. One can join tables ON a column, a set of columns and even a condition
-- USING is useful when both tables share a column of the exact same name on which they join

-- this SQL query creates a new cleaned-up version of the original dataset. It includes information about each bike ride, 
-- such as the ride ID, type of bike used, start and end times, duration, month and day of the week of the ride, 
-- station names and IDs, coordinates, and whether the rider is a member or a casual user. It also filters out any rides 
-- that are too short or too long or have missing station information
