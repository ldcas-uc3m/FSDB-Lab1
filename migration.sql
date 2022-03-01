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
SELECT DISTINCT hospital, NULL, address_hospital, address_emergency, town_hospital, country_hospital, ZIP_hospital, phone_hospital
FROM fsdb.doctors
WHERE hospital is not null and address_hospital is not null and address_emergency is not null and town_hospital is not null and  country_hospital is not null and ZIP_hospital is not null and phone_hospital is not null;



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

-- Doctor



-- Hospital_Specialty
/*
no hay ciff de hospital f 
INSERT INTO Hospital_Specialty
select distinct "hcif", specialty
from fsdb doctors;
WHERE CIF is not null and speciality is not null;
*/

-- Doctor_Specialty
insert into Doctor_Specialty
  select distinct collegiateNum, specialty
  from fsdb.doctors
  where collegiateNum is not null and specialty is not null;

-- Concert
insert into Concert
  select distinct taxID_insurer, xx, launch, retired, 
  from fsdb.coverages
  where taxID_insurer is not null and launch is not null and retired is not null;

-- Product
insert into Product
  select distinct product, coverage, waiting_period, to_date(retired,'DD/MM/YYYY'), version, to_date(launch, 'DD/MM/YYYY')
  from fsdb.coverages
  where product is not null and coverage is not null and waiting_period is not null; 


-- Contract
insert into Contract
  select distinct passport, product,  specialty?, contracted, duration, end_date?, number_of_people?
  from fsdb.clients where passport is not null join 




-- Appointment
