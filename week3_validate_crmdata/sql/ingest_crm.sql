CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.crm_new AS (
    SELECT * FROM read_csv_auto('data/crm_new.csv')
);

CREATE TABLE IF NOT EXISTS staging.crm_old AS (
    SELECT * FROM read_csv_auto('data/crm_old.csv')
);