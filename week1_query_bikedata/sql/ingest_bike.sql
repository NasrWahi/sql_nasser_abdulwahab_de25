CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.customers AS (
    SELECT * FROM read_csv_auto('data/bike/customers.csv')
);
