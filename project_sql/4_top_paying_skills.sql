/*Answer: What are the top skills based on salary?** 

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

select 
    skills,
    ROUND(avg(salary_year_avg),2) as avg_salary
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and salary_year_avg IS NOT NULL
group by skills
order by avg_salary desc
limit 25


/*
High Demand for Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies
(PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy),
reflecting the industry;s high valuation of data processing and predictive modeling capabilities

Software Development & Deployment Proficiency: Knowledge in development and deployment tools
(Gitlab, Kubernates, Airflow) indicates a lucrative crossover between data analytics and
engineering, with a premium on skills that facilitate automation and efficent data pipeline management.

Cloud Computing Expertise: Familiarity with cloud and data engineerig tools (Elasticsearch, Databricks, GCP)
underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly
boosts earning potential in data analytics