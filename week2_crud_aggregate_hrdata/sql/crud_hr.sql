/* ============
   DDL - CREATE
   ============ */
-- create schema
CREATE SCHEMA IF NOT EXISTS staging; 

-- create sequence to generate values for employee_id column later
CREATE SEQUENCE IF NOT EXISTS id_sequence START 1; 

-- create table
CREATE TABLE IF NOT EXISTS staging.employees (
    employee_id INTEGER DEFAULT nextval('id_sequence'),
    department VARCHAR,
    employment_year INTEGER
); 

/* =============
   CRUD - CREATE 
   ============= */
-- insert 3 rows manually
INSERT INTO
    staging.employees (department, employment_year)
VALUES
    ('Sales', 2001),
    ('Logistics', 2002),
    ('IT', 2002);

-- insert with read_csv() function
-- ref: https://duckdb.org/docs/stable/guides/file_formats/csv_import
INSERT INTO
    staging.employees (department, employment_year)
    SELECT * FROM read_csv('data/employees.csv');

/* =============
   CRUD - Read 
   ============= */
SELECT * FROM staging.employees; 
--LIMIT 10;
--OFFSET 10; 

/* ==============
   CRUD - Update 
   ============== */
-- modify existing data
UPDATE staging.employees
SET employment_year = 2023
WHERE employee_id IN (98,99);
--WHERE employee_id = 98 OR employee_id = 99; 

/* ============
   DDL - Alter
   ============ */
ALTER TABLE staging.employees
ADD COLUMN pension_plan VARCHAR DEFAULT 'plan 1'

/* ==============
   CRUD - Update 
   ============== */
UPDATE staging.employees
SET pension_plan = 'plan 2'
WHERE employment_year > 2015; 

/* ==============
   CRUD - Delete 
   ============== */
-- always check the rows you plan to delete first
SELECT *
FROM staging.employees
WHERE employee_id = 1; 

DELETE
FROM staging.employees
WHERE employee_id = 1; 