Below are the analytical questions that are needed to answer using the model. 

1. How many task occurances are completed on a daily basis?
2. How many tasks occurances are completed on a weekly basis?
3. How many tasks occurances are completed on a monthly basis?
4. Top 5 people to complete the maximum number of task occurances in a month. 
5. Top 5 task occurances based on the duration.
6. Task occurances that increased the allocated duration.

I want to design a star schema with below dimension tables. When the task is not completed, the dim_enddate_id and dim_endtime_id should be null.

dim_date:
date_date_id(PKß)
fulldate
Calendar_year
Quarter
Month_number
month_name
Day_of_week
Day_of_month
day_of_year


dim_time:
dim_time_id(PK)
Hour
Minue
Second


dim_user:
dim_user_id(PK)
user_id
user_fname
user_lname
user_dob
user_email_id

dim_task:
dim_tas_id(PK)
task_id
task_description
task_recoccurence
task_allocated_time 

fct_occurance:
fct_occurence_key(PK)
dim_user_id(FK)
dim_task_id(FK)
dim_start_date_id(FK)
dim_end_date_id(FK)
is_completed
task_duration
