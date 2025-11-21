/* Task 1 */

-- show rows do not have title inside context
SELECT
    title,
    context,
    INSTR(context, title)
FROM staging.squad
WHERE NOT regexp_matches(context, title); -- two arguments are string not substring

/* Task 2 */

-- show rows if context starting with title