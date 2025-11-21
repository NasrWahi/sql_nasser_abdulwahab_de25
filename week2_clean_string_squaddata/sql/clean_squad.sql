/* ========
   Task 2 
   ======== */

-- show rows do not have title inside context
SELECT
    title,
    context,
    INSTR(context, title)
FROM staging.squad
WHERE NOT regexp_matches(context, title); -- two arguments are string not substring

/* ========
   Task 3 
   ======== */

-- show rows if context starting with title

-- use LIKE operator with wildcard %
SELECT
  *
FROM staging.squad
WHERE context LIKE CONCAT(title, '%');
-- check the results for Southern_California
-- the results are not ok due to the wildcard _

-- if you use a regular expression functions, underscore will be a literal character
SELECT *
FROM staging.squad
WHERE regexp_matches(context, CONCAT('^', title));

/* ========
   Task 4 
   ======== */

   -- show a new column which is the first answer from thw AI model
   -- without pattern matching
SELECT
 answers[18:], -- slicing
 answers[18], -- indexing
 CASE
  WHEN answers[18] = ',' THEN NULL
  ELSE answers[18:]
 END AS striped_answers,
 INSTR(striped_answers, '''') AS first_quotation_index, -- a single quotation needs to be typed as ''
 striped_answers[:first_quotation_index-1] AS first_answers,
 answers
FROM staging.squad;

/* ========
   Task 5 
   ======== */

   -- generate the same results from task 4, but with 
SELECT
  -- don't allow single quotation
  regexp_extract(answers, '''([^'']+)'',') AS first_answer, 
  -- allows upper and lower case letters, digits, space, comma
  regexp_extract(answers, '''([A-Za-z0-9 ,]+)'',') AS first_answer_1,
  -- use the grouping optional argument in regexp_extract function
  regexp_extract(answers, '''([A-Za-z0-9 ,]+)'',', 1) AS first_answer_2,
  answers
FROM staging.squad;