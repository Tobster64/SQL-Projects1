(select job_id, job_title, 'With Salary Info' as salary_info
from job_postings_fact
where salary_year_avg IS NOT NULL or salary_hour_avg IS NOT NULL)

UNION ALL

(select job_id,job_title, 'Without Salary Info' as salary_info
from job_postings_fact
where salary_year_avg IS NULL and salary_hour_avg IS NULL)

order by salary_info desc, job_id