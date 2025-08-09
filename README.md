# Introduction
Dive into the data job marker! Focusing on data nalyst roles, this project explores top paying jobs, in-demand skills, and where high demand meets high salary in data analytics

For SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background
The motivation for this project came from my goal of gaining a deeper understanding of the data analyst job market. I wanted to identify which skills are both highly paid and in demand, enabling me to focus my job search more strategically and effectively.

The dataset used in this analysis comes from [Luke Barousse’s SQL Course](include link to the course). It contains information on job titles, salaries, locations, and the skills required for various data analyst roles.

Through my SQL queries, I set out to answer the following questions:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn for a data analyst looking to maximize job market value?
# Tools I Used
In this project, I utilized a variety of tools to conduct my analysis:

- **SQL** (Structured Query Language): Enabled me to interact with the database, extract insights, and answer my key questions through queries.
- **PostgreSQL**: As the database management system, PostgreSQL allowed me to store, query, and manipulate the job posting data.
- **Visual Studio Code:** This open-source administration and development platform helped me manage the database and execute SQL queries.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
select 
    job_id, 
    job_title, 
    job_location, 
    job_schedule_type, 
    salary_year_avg, 
    job_posted_date, 
    name as company_name
from job_postings_fact
left join company_dim on job_postings_fact.company_id = company_dim.company_id
where job_title_short = 'Data Analyst' and job_location = 'Anywhere' and salary_year_avg is not NULL
order by salary_year_avg desc
limit 10
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

![Top Paying Roles](assets\top_10_highest_paying_jobs.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs as 
    (select 
        job_id, 
        job_title, 
        salary_year_avg, 
        job_posted_date, 
        name as company_name
    from job_postings_fact
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
    where job_title_short = 'Data Analyst' and job_location = 'Anywhere' and salary_year_avg is not NULL
    order by salary_year_avg desc
    limit 10)

select 
    top_paying_jobs.*,
    skills
from top_paying_jobs
inner join skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
order by salary_year_avg desc
limit 100
```
Here's the breakdown of the most demanded skills for data analysts in 2023, based on job postings:
- SQL is leading with a count of 8
- Python follows closely with a count of 7
- Tableau is also highly sought after with a count of 6
- Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

### 3. In-Demand Skils for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
select 
    skills,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst'
group by skills
order by demand_count desc
limit 5
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remmain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation
- **Programing** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills  | Demand Count |
|---------|--------------|
| SQL     | 7291         |
| Excel   | 4611         |
| Python  | 4330         |
| Tableau | 3745         |
| Power BI | 2609        |
*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```
Here's the breakdown of the highest paying skills for data analysts in 2023:

- **Specialized or niche tools dominate**: SVN and Solidity stand out at the top, suggesting rare skills in version control for legacy systems and blockchain development bring premium pay for data analysts.

- **High salaries for tech stack breadth**: Skills in both data-specific tools (dplyr, Datarobot, Couchbase) and infrastructure/devops tools (Terraform, VMware, GitLab) show that blending analytics with engineering yields higher pay.

- **Emerging tech boosts earning power**: Machine learning frameworks (MXNet) and AI/automation platforms (Datarobot) appear alongside core programming languages (Golang), highlighting demand for analysts who can operate in cutting-edge environments.

- **Cloud Computing Expertise**: Familiarity with cloud and data engineerig tools (**Elasticsearch, Databricks, GCP**)
underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly
boosts earning potential in data analytics

| Rank | Skill       | Average Salary ($) |
|------|-------------|--------------------|
| 1    | svn         | $400,000.00         |
| 2    | solidity    | $179,000.00         |
| 3    | couch base  | $160,515.00         |
| 4    | datarobot   | $155,485.50         |
| 5    | golang      | $155,000.00         |
| 6    | mxnet       | $149,000.00         |
| 7    | dplyr       | $147,633.33         |
| 8    | vmware      | $147,500.00         |
| 9    | terraform   | $146,733.83         |
| 10   | twilio      | $138,500.00         |
| 11   | gitlab      | $134,126.00         |
*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
WITH skills_demand AS (
  SELECT
    skills_dim.skill_id,
		skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
  FROM
    job_postings_fact
	  INNER JOIN
	    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	  INNER JOIN
	    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
		AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = True
  GROUP BY
    skills_dim.skill_id
),
-- Skills with high average salaries for Data Analyst roles
-- Use Query #4 (but modified)
average_salary AS (
  SELECT
    skills_job_dim.skill_id,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
  FROM
    job_postings_fact
	  INNER JOIN
	    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	  -- There's no INNER JOIN to skills_dim because we got rid of the skills_dim.name 
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
		AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = True
  GROUP BY
    skills_job_dim.skill_id
)
-- Return high demand and high salaries for 10 skills 
SELECT
  skills_demand.skills,
  skills_demand.demand_count,
  ROUND(average_salary.avg_salary, 2) AS avg_salary --ROUND to 2 decimals 
FROM
  skills_demand
	INNER JOIN
	  average_salary ON skills_demand.skill_id = average_salary.skill_id
-- WHERE demand_count > 10
ORDER BY
  demand_count DESC, 
	avg_salary DESC
LIMIT 10 --Limit 25
; 
```
Here's a breakdown of the most optimal skills for Data Analysts in 2023:
- **SQL remains the top foundational skill**: With the highest demand count (398) and a solid average salary (~$97k), it’s essential for job security in data analytics.

- **Programming skills boost earning power**: Python, R, and Looker not only command six-figure average salaries but also rank in the top demand list, making them strong investments for skill-building.

- **Visualization & business tools are strategic add-ons**: Tableau, Power BI, and Excel combine high demand with competitive pay, ensuring versatility across technical and stakeholder-facing tasks.

| Rank | Skill       | Demand Count | Average Salary ($) |
|------|-------------|--------------|--------------------|
| 1    | sql         | 398          | $97,237.16          |
| 2    | excel       | 256          | $87,288.21          |
| 3    | python      | 236          | $101,397.22         |
| 4    | tableau     | 230          | $99,287.65          |
| 5    | r           | 148          | $100,498.77         |
| 6    | power bi    | 110          | $97,431.30          |
| 7    | sas         | 63           | $98,902.37          |
| 8    | powerpoint  | 58           | $88,701.09          |
| 9    | looker      | 49           | $103,795.30         |

# What I Learned
Throughout this project, I honed several key SQL techniques and skills:

- **Complex Query Construction**: Learning to build advanced SQL queries that combine multiple tables and employ functions like **`WITH`** clauses for temporary tables.
- **Data Aggregation**: Utilizing **`GROUP BY`** and aggregate functions like **`COUNT()`** and **`AVG()`** to summarize data effectively.
- **Analytical Thinking**: Developing the ability to translate real-world questions into actionable SQL queries that got insightful answers.

# Conclusions
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

# Closing Thoughts
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guideline for me to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.