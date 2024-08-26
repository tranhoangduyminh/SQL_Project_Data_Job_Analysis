/* 
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Business Analyst position
- Focus roles with specified salaries, regarding of location
=> Reveal how different skills impact salary levels for Business Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/


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

/*
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
*/