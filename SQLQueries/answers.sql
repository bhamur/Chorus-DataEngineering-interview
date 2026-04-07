/*Retrieve all active patients
Write a query to return all patients who are active.*/

SELECT *
FROM public."Patient"
WHERE active IS TRUE;

/*Find encounters for a specific patient
Given a patient_id, retrieve all encounters for that patient, including the status and encounter date.*/

/*Provide the patient_id in the place of '8f562c5f-9dcd-4a4e-b1e1-1417544539d3'
We can list the required columns from both tables, here i have listed all colums from patient table and status and encounter_date from Encounter table */
WITH params AS (
    SELECT '8f562c5f-9dcd-4a4e-b1e1-1417544539d3'::uuid AS patient_id
)
SELECT
    pat.*,
    enc.status,
    enc.encounter_date
FROM public."Patient" pat
INNER JOIN public."Encounter" enc
    ON pat.id = enc.patient_id
INNER JOIN params
    ON pat.id = params.patient_id;


/*List all observations recorded for a patient
Write a query to fetch all observations for a given patient_id, showing the observation type, value, unit, and recorded date.*/

WITH params AS (
    SELECT '8f562c5f-9dcd-4a4e-b1e1-1417544539d3'::uuid AS patient_id
)
SELECT
    obs.patient_id,
    obs.type AS observation_type,
    obs.value,
    obs.unit,
    obs.recorded_at
FROM public."Observation" obs
INNER JOIN params
    ON obs.patient_id = params.patient_id;

/*Intermediate Level (4-7)*/

/*Find the most recent encounter for each patient
Retrieve each patient’s most recent encounter (based on encounter_date). Return the patient_id, encounter_date, and status.*/

WITH latest_encounter AS (
    SELECT
        enc.*,
        ROW_NUMBER() OVER (
            PARTITION BY patient_id
            ORDER BY encounter_date DESC
        ) AS rn
    FROM public."Encounter" enc
)
SELECT
    latest_encounter.patient_id,
    latest_encounter.status,
    latest_encounter.encounter_date
FROM latest_encounter
WHERE rn = 1;

/*
Testing:
select * from public."Encounter"
where patient_id = '8f562c5f-9dcd-4a4e-b1e1-1417544539d3'
max encounter : 2026-03-24 22:28:46.896091, status:planned
*/

/*Find patients who have had encounters with more than one practitioner
Write a query to return a list of patient IDs who have had encounters with more than one distinct practitioner.*/

SELECT patient_id
FROM public."Encounter"
GROUP BY patient_id
HAVING COUNT(DISTINCT practitioner_id) > 1;


/*Find the top 3 most prescribed medications
Write a query to find the three most commonly prescribed medications from the MedicationRequest table, sorted by the number of prescriptions.*/

SELECT
    medication_name,
    COUNT(id) AS no_medicationrequests
FROM public."MedicationRequest"
GROUP BY medication_name
ORDER BY no_medicationrequests DESC
LIMIT 3;

/*Get practitioners who have never prescribed any medication
Write a query to find all practitioners who do not appear in the MedicationRequest table as a prescribing practitioner.*/

SELECT
    prct.id,
    prct.name
FROM public."Practitioner" prct
LEFT JOIN public."MedicationRequest" mr
    ON prct.id = mr.practitioner_id
WHERE mr.id IS NULL;

/*
Testing:
There are 5 practitioners and select distinct practitioner_id from public."MedicationRequest" returns all 5.

*/

/*Find the average number of encounters per patient
Calculate the average number of encounters per patient, rounded to two decimal places.*/

WITH patient_cnt AS (
    SELECT COUNT(id) AS patient_cnt
    FROM public."Patient"
),
enc_cnt AS (
    SELECT COUNT(id) AS enc_cnt
    FROM public."Encounter"
)
SELECT ROUND(enc_cnt.enc_cnt::numeric / patient_cnt.patient_cnt, 2)
FROM patient_cnt, enc_cnt;


/*Identify patients who have never had an encounter but have a medication request
Write a query to find patients who have a record in the MedicationRequest table but no associated encounters in the Encounter table.*/

SELECT DISTINCT mr.patient_id
FROM public."MedicationRequest" mr
LEFT JOIN public."Encounter" enc
    ON enc.patient_id = mr.patient_id
WHERE enc.id IS NULL;

/*Determine patient retention by cohort
Write a query to count how many patients had their first encounter in each month (YYYY-MM format) and still had at least one encounter in the following six months.*/
WITH first_encounter AS (
    SELECT
        patient_id,
        MIN(encounter_date) AS first_encounter_date
    FROM public."Encounter"
    GROUP BY patient_id
),
encounter_sixmonths AS (
    SELECT DISTINCT
        f.patient_id,
        f.first_encounter_date
    FROM first_encounter f
    JOIN public."Encounter" e
      ON e.patient_id = f.patient_id
     AND e.encounter_date > f.first_encounter_date
     AND e.encounter_date <= f.first_encounter_date + INTERVAL '6 months'
)
SELECT
    TO_CHAR(first_encounter_date, 'YYYY-MM') AS first_encounter_month,
    COUNT(patient_id) AS patient_count
FROM encounter_sixmonths
GROUP BY TO_CHAR(first_encounter_date, 'YYYY-MM')
ORDER BY first_encounter_month;