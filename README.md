# Chorus-DataEngineering-interview

Q1. Data Model: 

I have used chatgpt and below are the prompts i provided to come up with a diagram. 

Below are the Business rules assumed 

1. An User can be assigned multiple task Occurances. 
2. One task occurance can be assigned to only one user. 
3. One task can have multiple task occurances.

Below are the Entities identified:

1. User
2. task
3. Task Occurance 

The data model is desgined for transaction system. The list of attributes for each table is as below

User:
User_id (PK)
Firstname
LastName
DOB
email_id

Task:
Task_id (PK)
Task_description
Recurrance_time

Task_Occurance:
task_occurance_id(PK)
user_assignment_id (FK)
task_id (FK)
task_occurance_status
Task_occurance_starttime
task_occurance_completion_time


