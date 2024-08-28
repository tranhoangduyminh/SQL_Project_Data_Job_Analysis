# Introduction
📊 This project is part of a SQL course from Luke Barousse. Focusing on Business Analyst roles, this project explores 🤑 top-paying jobs, 💻 in demand skills, and where high demand meets 🫂 high salary in Business Analytics.

👀 SQL queries? Check them out here: [project_sql folder](/project_sql/).
# Background
Pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.
## The questions answered through the queries:

1. What are the top-paying Business Analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for Business Analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I used
- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

## 1. Top paying Business Analyst jobs:
To identify the highest-paying roles, I filtered business analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
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
```
| job_id | job_title | job_location | job_schedule_type | salary_year_avg | job_posted_date | company_name |
|--------|-----------|--------------|-------------------|-----------------|-----------------|--------------|
| 502610 | Lead Business Intelligence Engineer | Anywhere | Full-time | 220000.0 | 2023-08-29 18:26:36 | Noom |
| 112859 | Manager II, Applied Science - Marketplace Dynamics | Anywhere | Full-time | 214500.0 | 2023-12-18 08:02:37 | Uber |
| 1069582 | Analyst | Anywhere | Full-time | 200000.0 | 2023-12-21 13:01:17 | Multicoin Capital |
| 998056 | Analyst | Anywhere | Full-time | 200000.0 | 2023-10-04 11:01:48 | Multicoin Capital |
| 17458 | Senior Economy Designer | Anywhere | Full-time | 190000.0 | 2023-06-21 18:11:35 | Harnham |
| 416185 | Staff Revenue Operations Analyst | Anywhere | Full-time | 170500.0 | 2023-12-21 09:50:43 | Gladly |
| 1099753 | REMOTE - Business Intelligence Analyst (Leadership Role) - GCP | Anywhere | Full-time | 162500.0 | 2023-10-11 12:01:45 | CyberCoders |
| 1313937 | Manager Analytics and Reporting | Anywhere | Full-time | 145000.0 | 2023-06-22 13:01:41 | CyberCoders |
| 106225 | Business Strategy Analyst Senior (Hybrid) | Anywhere | Full-time | 138640.0 | 2023-06-30 14:01:54 | USAA |
| 661103 | Marketing Analytics Manager | Anywhere | Full-time | 134550.0 | 2023-08-03 19:59:22 | Get It Recruit - Marketing |
## 2. Skills required for top-paying jobs:
Identify which skilld do high-paying business analyst roles require: **(1)** use the list of top 10 high-paying jobs from query 1 **(2)** add specific skills name by using INNER JOIN on *skills_job_dim* and *skills_dim* tables **(3)** add specific skills required for each high-paying job.

```sql
WITH top_paying_jobs AS (
  SELECT 
    job_id,
    job_title,
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
)

SELECT
  top_paying_jobs.*,
  skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
```

| job_id | job_title | salary_year_avg | job_posted_date | company_name | skills |
|--------|-----------|-----------------|-----------------|--------------|--------|
| 502610 | Lead Business Intelligence Engineer | 220000.0 | 2023-08-29 18:26:36 | Noom | sql, python, excel, tableau, looker, chef |
| 112859 | Manager II, Applied Science - Marketplace Dynamics | 214500.0 | 2023-12-18 08:02:37 | Uber | python |
| 17458 | Senior Economy Designer | 190000.0 | 2023-06-21 18:11:35 | Harnham | sql, python, r |
| 416185 | Staff Revenue Operations Analyst | 170500.0 | 2023-12-21 09:50:43 | Gladly | excel |
| 1099753 | REMOTE - Business Intelligence Analyst (Leadership Role) - GCP | 162500.0 | 2023-10-11 12:01:45 | CyberCoders | sql, python, bigquery, gcp, looker, word, sheets |
| 1313937 | Manager Analytics and Reporting | 145000.0 | 2023-06-22 13:01:41 | CyberCoders | sql, excel, tableau |
| 106225 | Business Strategy Analyst Senior (Hybrid) | 138640.0 | 2023-06-30 14:01:54 | USAA | sql, python, r, sas, phoenix, excel, tableau |
| 661103 | Marketing Analytics Manager | 134550.0 | 2023-08-03 19:59:22 | Get It Recruit - Marketing | tableau |

## 3. Identify skills most in demand for Business Analysts:
Using INNER JOIN to combine required skills to jobs postings. Then COUNT is used to aggregate the number of jobs available for the top 5 skills

```sql
SELECT
  skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
  job_title_short = 'Business Analyst' AND
  job_work_from_home = true
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5
```

| skills   | demand_count |
|----------|--------------|
| sql      | 1266         |
| excel    | 983          |
| tableau  | 728          |
| power bi | 555          |
| python   | 546          |
## 4. Identify skills associated with high salaries:
(1) Identify average salary associated with each skill for Business Analyst positions (2) filter to remote jobs using WHERE (3) reveal how different skills impact salary levels for Business Analysts and helps identify the most financially rewarding skills to acquire or improve.

```sql
SELECT
  skills,
  ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
  job_title_short = 'Business Analyst'
  AND salary_year_avg IS NOT NULL
  AND job_work_from_home = true
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
```
| Skills         | Avg_Salary |
| -------------- | ---------- |
| Chef           | 220,000    |
| Phoenix        | 135,990    |
| Looker         | 130,400    |
| MongoDB        | 120,000    |
| Python         | 116,516    |
| BigQuery       | 115,833    |
| GCP            | 115,833    |
| R              | 114,629    |
| Snowflake      | 114,500    |
| DB2            | 114,500    |
| SSRS           | 111,500    |
| NoSQL          | 110,490    |
| Qlik           | 110,175    |
| Elasticsearch  | 110,000    |
| MXNet          | 110,000    |
| TensorFlow     | 110,000    |
| Databricks     | 110,000    |
| Node.js        | 110,000    |
| Chainer        | 110,000    |
| PyTorch        | 110,000    |
| Visio          | 106,250    |
| Tableau        | 104,233    |
| Hadoop         | 101,993    |
| Word           | 101,250    |
| PowerPoint     | 100,800    |

The list of top-paying skills for business analysts highlights several trends in the job market, especially within the tech and data-driven industries. Here are some key insights:

1. High Demand for Specialized Tools and Platforms:
Chef, a configuration management tool, tops the list with a notably high average salary. This reflects the demand for automation in infrastructure management.
Phoenix, a web development framework, also commands high pay, indicating the need for scalable web applications.

2. Data and Cloud Skills Dominate:
Skills like Looker, BigQuery, GCP, Snowflake, and Databricks are highly valued. These tools are central to data analysis, business intelligence, and cloud computing.
MongoDB and NoSQL databases also appear, signaling the importance of managing and analyzing large, unstructured data sets.

3. Programming and Machine Learning:
Programming languages and frameworks like Python, R, Node.js, TensorFlow, PyTorch, and MXNet feature prominently. This indicates a strong demand for skills in AI, machine learning, and data science.
Elasticsearch, Chainer, and SSRS show a preference for advanced data processing and visualization capabilities.

4. Traditional Office Tools Still Relevant:
Despite the tech-heavy focus, tools like Visio, Tableau, Word, and PowerPoint still appear in the top 25, albeit with lower salaries. These tools remain essential for communication, reporting, and presenting data.
Diverse Skill Sets are Rewarded:

The list suggests that business analysts with a mix of cloud, data, programming, and even traditional office tools are highly valued, with the potential for substantial earnings.
This data implies a strong trend toward hybrid roles that require both technical expertise and the ability to communicate insights effectively. The highest-paying jobs are those that combine cutting-edge technology with specialized tools and platforms.

## 5. Identifying optimal skills to learn:

Target skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in business analysis.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Business Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
| skill_id | skills   | demand_count | avg_salary |
|----------|----------|--------------|------------|
| 1        | python   | 20           | 116516     |
| 182      | tableau  | 27           | 104233     |
| 0        | sql      | 42           | 99120      |
| 181      | excel    | 31           | 94132      |
| 183      | power bi | 12           | 90448      |

# What I learned
- **Query Crafting:** Being able to write and understand basic SQL (merging tables, WITH clause).
- **Data Aggregation:** Being able to use GROUP BY, COUNT, AVG to summarize data.
- **Analytical Skills:** Understand data from analysis, convert information into actionable insights.
# Conclusion 
This project enhanced my SQL skills and provided valuable insights into the business analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.