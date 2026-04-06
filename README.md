# Chorus-DataEngineering-interview

# Chorus Data Engineering Interview

This repository contains my submission for the Chorus Data Engineering take-home assignment.

## Overview

The assignment was to build a data model for a task management system and provide SQL queries to answer common business questions.

I have included both a **transactional model (OLTP)** and an **analytical model (OLAP)** because the data modeling approach differs based on how the system is used:

- The **transactional model** is designed for day-to-day application operations such as storing tasks, task occurrences, user assignments, and statuses.
- The **analytical model** is designed for reporting and trend analysis, where query simplicity and performance are more important than normalization.

I chose a **star schema** for the analytical model because it is well suited for reporting use cases such as daily, weekly, and monthly completion tracking, top performers, and task duration analysis.

## Repository Structure

### `Datamodel/OLTP`
Contains the transactional data model for the task management system.

This model focuses on representing the core business entities and relationships needed for operational processing.

### `Datamodel/OLAP`
Contains the analytical data model.

This model is structured as a star schema to support business reporting and aggregation-based queries efficiently.

### `SQLQueries`
Contains SQL queries written to answer the required questions.

### `Architechture_Diagram`
Contains architecture diagram files included as part of the submission.

## Why Both Models

A single model does not serve both operational and analytical needs equally well.

The transactional model is better for:
- maintaining data integrity
- capturing individual task occurrences
- supporting application workflows and updates

The analytical model is better for:
- reporting
- aggregations
- trend analysis
- top-N and time-based business questions

Because of this difference in usage, I provided both models separately.


## Trade-offs and Assumptions

The trade-offs and design assumptions for each model are documented in the corresponding markdown files within:

- `Datamodel/OLTP`
- `Datamodel/OLAP`

## AI Usage Disclosure

AI was used to help brainstorm diagram structure and presentation.

The final schema design, attribute selection, and SQL solutions were reviewed and adjusted by me.

