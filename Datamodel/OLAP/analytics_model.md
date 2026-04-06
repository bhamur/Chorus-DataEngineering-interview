## **Analytical Requirements**

The analytical model should support answering the following questions:

1. How many task occurrences are completed on a daily basis?
2. How many task occurrences are completed on a weekly basis?
3. How many task occurrences are completed on a monthly basis?
4. Who are the top 5 users who completed the highest number of task occurrences in a month?
5. What are the top 5 task occurrences based on duration?
6. Which task occurrences exceeded the allocated duration?

I want to design a star schema with below dimension tables. When the task is not completed, the dim_enddate_id and dim_endtime_id should be null.

### **Dimension Tables**

#### **dim_date**
- **dim_date_id** (PK)
- full_date
- calendar_year
- quarter
- month_number
- month_name
- day_of_week
- day_of_month
- day_of_year
- week_number

#### **dim_time**
- **dim_time_id** (PK)
- hour
- minute
- second

#### **dim_user**
- **dim_user_id** (PK)
- user_id
- user_first_name
- user_last_name
- user_dob
- user_email_id

#### **dim_task**
- **dim_task_id** (PK)
- task_id
- task_description
- task_recurrence
- task_duedate

---

### **Fact Table**

#### **fct_task_occurrence**
- **fct_task_occurrence_key** (PK)
- dim_user_id (FK)
- dim_task_id (FK)
- dim_start_date_id (FK)
- dim_start_time_id (FK)
- dim_end_date_id (FK, nullable)
- dim_end_time_id (FK, nullable)
- is_completed
- task_duration
- dim_task_due_date_id