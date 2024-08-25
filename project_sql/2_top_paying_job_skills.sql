/*
What skills are required for the top-paying business analyst jobs?
- Use the 10 highest paying business analyst job from previous query.
- Add the specific skills required for these roles
- Provide information on which skilld do high-paying business analyst roles require.
*/




SELECT 
  job_id,
  job_title,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS company_name
FROM
  job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
  job_title_short = 'Business Analyst' AND
  job_location = 'Anywhere' AND
  salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10