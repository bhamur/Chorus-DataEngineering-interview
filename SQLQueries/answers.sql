/*Retrieve all active patients
Write a query to return all patients who are active.*/

select * from public."Patient"
where active is True


/*Find encounters for a specific patient
Given a patient_id, retrieve all encounters for that patient, including the status and encounter date.*/

/*Provide the patient_id in the place of '8f562c5f-9dcd-4a4e-b1e1-1417544539d3'
We can list the required columns from both tables, here i have listed all colums from patient table and status and encounter_date from Encounter table */
WITH params AS (
  SELECT
    '8f562c5f-9dcd-4a4e-b1e1-1417544539d3'::uuid AS patient_id
)
select pat.*, Enc.status, Enc.encounter_date from 
public."Patient" pat inner join 
public."Encounter" Enc
on pat.id = Enc.patient_id
inner join params
on pat.id = params.patient_id


/*List all observations recorded for a patient
Write a query to fetch all observations for a given patient_id, showing the observation type, value, unit, and recorded date.*/

WITH params AS (
  SELECT
    '8f562c5f-9dcd-4a4e-b1e1-1417544539d3'::uuid AS patient_id
)
select pat.id, obs.type as observation_type, value, unit, recorded_at
from 
public."Patient" pat inner join
public."Observation" obs
on pat.id = obs.patient_id
inner join params
on pat.id = params.patient_id

