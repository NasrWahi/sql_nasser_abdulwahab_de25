CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.daily_weather_2020 AS(
    SELECT * FROM read_csv_auto('data/daily_weather_2020.csv')
);