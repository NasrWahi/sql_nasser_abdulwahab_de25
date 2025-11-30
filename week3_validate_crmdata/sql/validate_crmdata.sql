/* Task 2 */
-- find invalid emails
-- use LIKE operator with wildcard % for the old data
SELECT * FROM staging.crm_old
WHERE NOT email LIKE '%@%.%';

-- use REGEXP for the new data
-- because the above query cannot deal with the new data
SELECT * FROM staging.crm_new
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+');

-- combine all three conditions
SELECT * FROM staging.crm_old
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
  NOT region IN ('EU', 'US') OR 
  NOT status IN ('active', 'inactive');

SELECT * FROM staging.crm_new
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
  NOT region IN ('EU', 'US') OR 
  NOT status IN ('active', 'inactive');

/* Task 3 */
CREATE SCHEMA IF NOT constrained;

CREATE TABLE IF NOT EXISTS constrained.crm_old (
    customer_id INTEGER UNIQUE,
    -- customer_id INTEGER UNIQUE,
    name VARCHAR NOT NULL,
    email VARCHAR CHECK(email LIKE '%@%.%'),
    region VARCHAR CHECk(region IN ('EU', 'US')),
    status VARCHAR CHECK (status IN ('active', 'inactive'))
);

CREATE TABLE IF NOT EXISTS constrained.crm_new (
    customer_id INTEGER UNIQUE,
    name VARCHAR NOT NULL,
    email VARCHAR CHECK (regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+')),
    region VARCHAR CHECK(region IN ('EU', 'US')),
    status VARCHAR CHECK (status IN ('active', 'inactive'))
);

INSERT INTO constrained.crm_old
SELECT * 
FROM staging.crm_old
WHERE regexp_matches(email,'[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]
') AND
  region IN ('EU', 'US') OR 
  status IN ('active', 'inactive');

INSERT INTO constrained.crm_new
SELECT *
FROM staging.crm_new
WHERE regexp_matches(email,'[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]
') AND
  region IN ('EU', 'US') OR 
  status IN ('active', 'inactive');

/* Task 4 */
-- how many customers are only in the old crm system
-- 7 customers are there
SELECT customer_id
FROM staging.crm_old
EXCEPT
SELECT customer_id
FROM staging.crm_new 

-- 6 customers are only in the new crm system
SELECT customer_id
FROM staging.crm_new
EXCEPT
SELECT customer_id
FROM staging.crm_old

-- 7 common customers in both crm systems
SELECT customer_id
FROM staging.crm_new
INTERSECT
SELECT customer_id
FROM staging.crm_old

/*Task 5 */
-- subquery 1: customers only in the old crm system
(SELECT *
FROM staging.crm_old
EXCEPT
SELECT *
FROM staging.crm_new)
UNION
-- subquery 2: customers only in the new crm system
(SELECT *
FROM staging.crm_new
EXCEPT
SELECT *
FROM staging.crm_old)
UNION
-- subquery 3: customers violating constraints in the old crm system
(SELECT * FROM staging.crm_old
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
  NOT region IN ('EU', 'US') OR 
  NOT status IN ('active', 'inactive'))
UNION
-- subquery 4: customers violating constraints in the new crm system
(SELECT * FROM staging.crm_new
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
  NOT region IN ('EU', 'US') OR 
  NOT status IN ('active', 'inactive'))
  