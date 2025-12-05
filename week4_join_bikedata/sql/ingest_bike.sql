CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.order_items AS (
    SELECT * FROM read_csv_auto('data/order_items.csv')
);

CREATE TABLE IF NOT EXISTS staging.products AS (
    SELECT * FROM read_csv_auto('data/products.csv')
);