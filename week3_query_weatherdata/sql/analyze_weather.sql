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
WHERE "Country/Region" = 'Sweden'; -- nnote the use of single and double quotations