Below are the analytical questions that are needed to answer using the model

1. How many task occurances are completed on a daily basis?
2. How many tasks occurances are completed on a weekly basis?
3. How many tasks occurances are completed on a monthly basis?
4. Top 5 people to complete the maximum number of task occurances in a month. 
5. Top 5 task occurances based on the duration.
6. Task occurances that increased the allocated duration.

I want to design a star schema with below dimension tables. When the task is not completed, the dim_enddate_id and dim_endtime_id should be null.

dim_date
date_date_id
date



dim_time
dim_time_id




dim_user
dim_user_id
user_id
user_fname
user_lname
user_dob
user_email_id

dim_task
dim_tas_id
task_id
task_description
task_recoccurence
task_allocated_time 

fct_occurance
fct_occurence_key
dim_user_id
dim_task_id
dim_start_date_id
dim_end_date_id
is_completed
task_duration
