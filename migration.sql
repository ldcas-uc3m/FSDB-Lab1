set echo off
clear screen


-- Specialty -
insert into Specialty
  select distinct specialty, desc_specialty
  from fsdb.doctors where specialty is not null and desc_specialty is not null;

-- Insurance_Company -no funciona porque patata (ORA-01722)
insert into Insurance_Company 
  select distinct taxID_insurer, insurer, address_insurer, town_insurer, ZIP_insurer, phone_insurer, email_insurer, web_insurer
  from fsdb.contracts
  where taxID_insurer is not null and insurer is not null and address_insurer is not null and town_insurer is not null and ZIP_insurer is not null and phone_insurer is not null and email_insurer is not null and web_insurer is not null;


-- Hospital 
INSERT INTO Hospital 
SELECT DISTINCT hospital, null, address_hospital, address_emergency, town_hospital, country_hospital, ZIP_hospital, phone_hospital
FROM fsdb.doctors
WHERE hospital is not null and address_hospital is not null and town_hospital is not null and  country_hospital is not null and ZIP_hospital is not null and phone_hospital is not null;


-- Customer -
insert into Customer
  select distinct passport, name, surname1, surname2, gender, email
  from fsdb.clients
  where name is not null and surname1 is not null and gender is not null and email is not null and passport != '69100500-J';

/* checking error:
select passport from(
select distinct passport, name, surname1, surname2, gender, email
from fsdb.clients
where name is not null and surname1 is not null and gender is not null and email is not null)
group by passport having count('x')>1;

select * from fsdb.clients
where passport = '69100500-J';
*/

-- Doctor (EN REVISON) ---
insert into Doctor
select distinct collegiateNum, phoneNum, name, surname1, surname2, passport, hospital
from fsdb.doctors
where collegiateNum is not null and phoneNum is not null and name is not null and surname1 is not null and passport is not null;

-- Doctor_Specialty (EN REVISON) ---
insert into Doctor
select distinct collegiateNum, phoneNum, name, surname1, surname2, passport, hospital
from fsdb.doctors
where collegiateNum is not null and phoneNum is not null and name is not null and surname1 is not null and passport is not null;


-- Hospital_Specialty
INSERT INTO Hospital_Specialty
select distinct hospital, specialty
from fsdb.doctors
where hospital is not null and specialty is not null;


-- Doctor_Specialty (EN REVISION) ---
insert into Doctor_Specialty
  select distinct collegiateNum, specialty
  from fsdb.doctors
  where collegiateNum is not null and specialty is not null;

-- Concert
insert into Concert
  select distinct taxID_insurer, hospital, start_date, end_date 
  from fsdb.contracts
  where taxID_insurer is not null and hospital is not null and start_date is not null;

-- Product 
insert into product
select distinct product, cif_insurer, version
  from fsdb.clients
  where product is not null and cif_insurer is not null and version is not null ; 

-- Product_Coverages

insert into Product_coverages
  SELECT DISTINCT
    fsdb.coverages.product,
    fsdb.coverages.coverage,
    MAX(fsdb.coverages.waiting_period) AS "Max_WAITING_PERIOD",
    fsdb.coverages.taxid_insurer,
    MAX(CAST(fsdb.coverages.launch AS DATE)) AS "Max_LAUNCH",
    fsdb.coverages.retired
FROM
    fsdb.coverages
WHERE
    fsdb.coverages.product IS NOT NULL
    AND fsdb.coverages.taxid_insurer IS NOT NULL
    AND fsdb.coverages.coverage IS NOT NULL
    AND fsdb.coverages.version IS NOT NULL
GROUP BY
    fsdb.coverages.product,
    fsdb.coverages.taxid_insurer,
    fsdb.coverages.coverage,
    fsdb.coverages.version,
    fsdb.coverages.retired
ORDER BY
    fsdb.coverages.product,
    fsdb.coverages.coverage,
    "Max_WAITING_PERIOD",
    "Max_LAUNCH";


-- Contract
insert into Contract
  select distinct passport, product,  cif_insurer, version, contracted, duration
  from fsdb.clients where product is not null and cif_insurer is not null and duration is not null and contracted is not null and  passport != '69100500-J';


-- Appointment

