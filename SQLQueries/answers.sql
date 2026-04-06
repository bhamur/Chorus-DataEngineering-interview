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

/*Intermediate Level (4-7)*/

/*Find the most recent encounter for each patient
Retrieve each patient’s most recent encounter (based on encounter_date). Return the patient_id, encounter_date, and status.*/

With latest_encounter AS
(select 
Enc.*,
ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY encounter_date desc) as rn
from public."Encounter" enc)
select latest_encounter.patient_id, latest_encounter.status, latest_encounter.encounter_date
from latest_encounter
where rn =1 

/*
Testing:
select * from public."Encounter"
where patient_id = '8f562c5f-9dcd-4a4e-b1e1-1417544539d3'
max encounter : 2026-03-24 22:28:46.896091, status:planned
*/

/*Find patients who have had encounters with more than one practitioner
Write a query to return a list of patient IDs who have had encounters with more than one distinct practitioner.*/

select patient_id from public."Encounter"
group by patient_id
having count(distinct practitioner_id) > 1;


/*Find the top 3 most prescribed medications
Write a query to find the three most commonly prescribed medications from the MedicationRequest table, sorted by the number of prescriptions.*/

select medication_name, 
count(id) as no_medicationrequests 
from public."MedicationRequest"
group by medication_name
order by no_medicationrequests desc limit 3

/*Get practitioners who have never prescribed any medication
Write a query to find all practitioners who do not appear in the MedicationRequest table as a prescribing practitioner.*/

select prct.id, prct.name from
public."Practitioner" prct
left join public."MedicationRequest" mr 
on prct.id = mr.practitioner_id 
where mr.id is null

/*
Testing:
There are 5 practitioners and select distinct practitioner_id from public."MedicationRequest" returns all 5.

*/

