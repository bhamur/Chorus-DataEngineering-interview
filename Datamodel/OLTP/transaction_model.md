# Q1. Data Model

I used ChatGPT to help come up with the data model diagram.

Below are the business rules I provided:

- A user can be assigned multiple task occurrences.
- One task occurrence can be assigned to only one user.
- One task can have multiple task occurrences.

## Entities Identified

- User
- Task
- Task Occurrence

## Data Model Type

This data model is designed for a transactional system.

## Table Definitions

### User
- `user_id` (PK)
- `first_name`
- `last_name`
- `dob`
- `email_id`

### Task
- `task_id` (PK)
- `task_description`
- `recurrence_time`
- `max_occurrence`

### Task_Occurrence
- `task_occurrence_id` (PK)
- `user_assignment_id` (FK)
- `task_id` (FK)
- `task_occurrence_status`
- `task_occurrence_start_time`
- `task_occurrence_completion_time`
- `task_occurrence_due_date`