/* Task 1 */

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
  NOT region IN ('Eu', 'US') OR 
  NOT status IN ('active', 'inactive');


SELECT * FROM staging.crm_new
WHERE NOT regexp_matches(email, '[A-Za-z0-9]+@[A-Za-z]+\.[A-Za-z]+') OR
  NOT region IN ('Eu', 'US') OR 
  NOT status IN ('active', 'inactive');