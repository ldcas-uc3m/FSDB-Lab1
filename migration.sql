--set echo off
clear screen


-- Specialty -
insert into Specialty
  select distinct
    specialty,
    desc_specialty
  from fsdb.doctors 
  where
    specialty is not null
    and desc_specialty is not null
;


-- Insurance_Company
insert into Insurance_Company 
  select distinct 
    taxID_insurer,
    insurer,
    address_insurer,
    town_insurer,
    ZIP_insurer,
    phone_insurer,
    email_insurer,
    web_insurer
  from fsdb.contracts
  where
    taxID_insurer is not null
    and insurer is not null
    and address_insurer is not null
    and town_insurer is not null
    and ZIP_insurer is not null
    and phone_insurer is not null
    and email_insurer is not null
    and web_insurer is not null
;


-- Hospital
insert into Hospital 
  select distinct
    hospital,
    null,
    address_hospital,
    address_emergency,
    town_hospital,
    country_hospital,
    ZIP_hospital,
    phone_hospital
  from fsdb.doctors
  where
    hospital is not null
    and address_hospital is not null
    and town_hospital is not null
    and country_hospital is not null
    and ZIP_hospital is not null
    and phone_hospital is not null
;


-- Customer
insert into Customer
  select distinct
    passport,
    name,
    surname1,
    surname2,
    gender,
    email
  from fsdb.clients
  where
    name is not null
    and surname1 is not null
    and gender is not null
    and email is not null
    and passport != '69100500-J'
;

/* checking error:
select passport
from (
  select distinct passport, name, surname1, surname2, gender, email
  from fsdb.clients
  where name is not null and surname1 is not null and gender is not null and email is not null
)
group by passport having count('x')>1
;

select * from fsdb.clients
where passport = '69100500-J';
*/


-- Doctor
insert into Doctor
  select distinct
    collegiateNum,
    phoneNum,
    name,
    surname1,
    surname2,
    passport
  from fsdb.doctors
  where
    collegiateNum is not null
    and phoneNum is not null
    and name is not null
    and surname1 is not null
    and passport is not null
;


-- Doctor_Hospital
insert into Doctor_Hospital
  select distinct
    collegiateNum,
    hospital
  from fsdb.doctors
  where
    collegiateNum is not null
    and hospital is not null;


-- Hospital_Specialty
insert into Hospital_Specialty
  select distinct
    hospital,
    specialty
  from fsdb.doctors
  where
    hospital is not null
    and specialty is not null
;


-- Doctor_Specialty
insert into Doctor_Specialty
  select distinct
    collegiateNum,
    specialty
  from fsdb.doctors
  where
    collegiateNum is not null
    and specialty is not null
;


-- Concert
insert into Concert
  select distinct
    taxID_insurer,
    hospital,
    start_date,
    end_date 
  from fsdb.contracts
  where
    taxID_insurer is not null
    and hospital is not null
    and start_date is not null
;


-- Product 
insert into Product
   SELECT DISTINCT
    fsdb.coverages.product,
    fsdb.coverages.taxid_insurer,
    to_number(fsdb.coverages.version, '9.99') ,
    MAX(CAST(fsdb.coverages.launch AS DATE)) AS "Max_LAUNCH",
    fsdb.coverages.retired,
    case
	when retired is not null then 0
        when retired is null then 1
    end
FROM
    fsdb.coverages
WHERE
    fsdb.coverages.product IS NOT NULL
    AND fsdb.coverages.taxid_insurer IS NOT NULL
    AND fsdb.coverages.version IS NOT NULL
GROUP BY
    fsdb.coverages.product,
    fsdb.coverages.taxid_insurer,
    fsdb.coverages.version,
    fsdb.coverages.retired
ORDER BY
    fsdb.coverages.product,
    "Max_LAUNCH";



/*
select distinct product, taxid_insurer, coverage, launch from fsdb.coverages
 group by product, taxid_insurer, coverage, launch having count('x')>1
 order by product;
*/

-- Product_Coverages (REVISAR)
insert into Product_Coverages
  select distinct
    product,
    taxID_insurer,
    version,
    coverage,
    waiting_period,
  from fsdb.coverages
  where
    product is not null
    and taxID_insurer is not null
    and version is not null
    and coverage is not null
    and verswaiting_periodion is not null
;


-- Contract (TESTEAR)
insert into Contract
  select distinct
    passport,
    product,
    cif_insurer,
    to_date(contracted, 'DD/MM/YY'),
    duration,
    to_date(contracted, 'DD/MM/YY') + duration
  from fsdb.clients
  where 
    product is not null 
    and cif_insurer is not null 
    and duration is not null 
    and contracted is not null
    and passport != '69100500-J'
;


-- Appointment
-- this table is empty, as it's a new functionality

