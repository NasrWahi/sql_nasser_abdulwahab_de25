CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.squad AS (
    SELECT * FROM read_csv_auto('data/squad.csv')
)