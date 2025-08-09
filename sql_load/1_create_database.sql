select job_id, salary_year_avg,
    CASE
        when job_title LIKE '%Senior%' then 'Senior'
        when job_title like '%Manager%' or job_title like '%Lead' then 'Lead/Manager'
        when job_title like '%Junior%' or job_title like '%Entry%' then 'Junior/Entry'
        else 'Not Specified'
        end as experience_level,
    CASE
        when job_work_from_home = TRUE then 'Yes'
        else 'No'
        end as remote_option
from job_postings_fact
where salary_year_avg is not NULL
order by job_id

select * from job_postings_fact
limit 100