/* ==========
    Task 2
   ========== */

   -- find the data types of columns
DESC staging.daily_weather_2020;

DESC staging.daily_weather_2020;
SELECT
  sunriseTime,
  sunsetTime,
  temperatureHighTime
  temperatureLowTime,
  windGustTime,
  precipIntensityMaxTime,
FROM staging.daily_weather_2020

-- show the UNIX values of these columns
-- the values are the numbers of seconds counted from a reference time point (1970-01-01 00:00:00)
SELECT
  sunriseTime,
  sunsetTIME,
  temperatureHighTime,
  temperatureLowTime,
  windGustTime,
  precipIntensityMaxTime
FROM staging.daily_weather_2020;

/* ==========
    Task 3
   ========== */

-- each row in the dataset contains weather data for each combination of Country/Region, Province/State and date (time column)
-- it's important to understand which columns can be used to uniquely identify each row
-- use aggregation function together with GROUP BY
SELECT
  "Country/Region" AS Country, -- use of "" for column names
  "Province/State" AS State,
  COUNT(*) AS Nr_Records,
FROM staging.daily_weather_2020
GROUP BY "Country/Region", "Province/State"
ORDER BY "Country/Region", "Province/State";

/* ==========
    Task 4
   ========== */
SELECT
  to_timestamp(sunriseTime) AS sunrise_utc, -- this function transfers numeric columns to timestamp
  to_timestamp(sunriseTime) AT TIME ZONE 'Europe/Stockholm' AS sunrise_swtime,
  to_timestamp(sunsetTime) AS sunset_utc,
  to_timestamp(sunsetTime) AT TIME ZONE 'Europe/Stockholm' AS sunset_swtime,
FROM staging.daily_weather_2020
WHERE "Country/Region" = 'Sweden'; -- note the use of single and double quotations

/* ==========
    Task 5
   ========== */
   
-- the new year and month columns involves subtracting a part of timestamp
-- to pick up the date with the largest gap within a month involves the use of aggregation function
-- the gaps can be calculated directly with UNIX time
SELECT 
  date_part('year', to_timestamp(sunriseTime)) AS year,
  date_part('month', to_timestamp(sunriseTime)) AS month,
  MAX(to_timestamp(sunriseTime)) AS sunrise_largest_gap_date, -- MAX() will pick up the first row
  MAX(to_timestamp(sunsetTime)) AS sunset_largest_gap_date, -- MAX() will pick up the first row
  MAX(ROUND((sunsetTime-sunriseTime)/3600)) AS gap_hours,
FROM staging.daily_weather_2020
WHERE "Country/Region" = 'Sweden'
GROUP BY year, month
ORDER BY year, month, gap_hours DESC; -- make sure the date with the largest gap is always the first row for each year-month
/* ==========
    Task 6
   ========== */

-- concatenate integer and string
SELECT
  to_timestamp(windGustTime) AT TIME ZONE 'Europe/Stockholm' AS most_windy_timestamp,
  date_part('hour', most_windy_timestamp) AS most_windy_hour,
  CONCAT('It''s dangerous to use the crane at kl.', most_windy_hour)
FROM staging.daily_weather_2020
WHERE "Country/Region" = 'Sweden';
-- ^ alternative 1

-- concatenate string and string
SELECT
  to_timestamp(windGustTime) AT TIME ZONE 'Europe/Stockholm' AS most_windy_timestamp,
  -- strftime(), string format time, transforms timestamp to string
  -- use the format, like '%H', to design the presentation
  -- strptime() , string past time, transforms string to timestamp
  strftime(most_windy_timestamp,'%H') AS most_windy_hour,
  CONCAT('It''s dangerous to use the crane at kl.', most_windy_hour)
FROM staging.daily_weather_2020
WHERE "Country/Region" = 'Sweden';
-- ^ alternative 2