# File Structures and Databases Lab1
By Ignacio Arnaiz Tierraseca, Luis Daniel Casais Mezquida & Iván Darío Cersósimo  
Bachelor's Degree in Computer Science and Engineering,  
Universidad Carlos III de Madrid

## Problem Description

The Terrestrial Confederation of Physicians (identified by the acronym CONGATE) is an international ministry to which most of the health professionals on this planet belong. This institution wants to launch the Congate-Cares website, where citizens can find information about private health insurance and the companies that offer it. For its development, they have collected the information requirements that must be observed through the design of the DB that will support that website.  
  
For each insurance company, it is required to register its commercial name, CIF (tax identifier), headquarters address, city, ZIP code, telephone, email, URL of its website and the information of the hospitals associated with that company.  
  
The name of a hospital is unique and identifies the hospital throughout the world. Any hospital can have a concert with an insurance company, with several, or with none of them. In addition to the name of the hospital, we need to observe the hospital tax identifier code (CIF) and its address. Regarding addresses, we should record both the main entrance and its emergency service entrance. Nonetheless, both entries may coincide, and it is also possible that the hospital does not have an emergency service. Apart from that, there are some other characteristics related to hospitals, as the name of the city/town, ZIP code and telephone number (13 digits, different for each hospital).  
Collaboration contracts (hospital-insurance company) have start and end dates and cannot overlap in time. If a new contract is signed before a previous contract ends, the previous contract is immediately resolved (the end date of the former contract will be automatically assigned to the day before the new contract becomes effective, that is, the new contract’s starting date minus one), so that the contracts do not overlap in time. In addition, any two contracts with the same parties (same hospital and company) cannot have the same starting date.  
  
Each hospital has a range of specialties (orthopedics, dermatology, dentistry, etc.; there are currently 49 different ones). For each specialty, its name (identifier), a brief description, and the hospitals that are offering such medical services are to be recorded.  
At each hospital, each specialty can be supported by one or more physicians (or none, in case that hospital doesn’t offer that specialty). For each doctor, it is required to keep the collegiate number (identifier), full name, citizen ID (DNI) / passport number (up to 15 characters), locator number and his/her specialties (at least one).  
Any doctor can only practice the specialty(s) in which he/she is a specialist, although there is no limit to the number of specialties held. If a hospital goes bankrupt, its doctors would be temporarily unemployed (unassigned). 
  
Each insurance company may offer different types of insurance (products). Each of them will have its own set of specialty coverages. For example, VITASA's “Basic” insurance only covers the “family doctor” specialty, with a 0-day waiting period. The “waiting period” is the stipulated time that must elapse from the contracting of the product until the client is effectively covered and can have the correspondent medical services. The coverages linked to a product cannot be removed or modified while the product is contracted by any customer. A new version of the product can be released, with different coverages, and this new version can become the active one, making the previous one obsolete so no longer it can be contracted. 

For this web service, only basic personal data is collected from customers (DNI or passport, which is univocal; name, surname/s, gender, and personal email). In addition, it must allow collecting what product each client has contracted (or products, because they can have more than one), with start date, duration in days, number of people covered by the coverage, and medical appointments (past and future), so the platform will allow managing appointments at some time in the future. Appointments are defined as a visit by a patient (client) to a doctor in a hospital to handle a problem related to a specialty (held by that doctor), on a certain date and time. 

## Previous design
The current database is extremely poor, with only four disjointed tables (and hardly any restrictions): a table registering doctors and their specialties; another one regarding accords between insurance companies and hospitals; another one including descriptions of products and their coverages; and the last one keeping the insurance policies (contracts between clients and insurance companies).

```
fsdb.doctors
Name                     Null?    Type
------------------------ -------- -------------
collegiateNum                     VARCHAR2(12)
name                              VARCHAR2(40)
surname1                          VARCHAR2(25)
surname2                          VARCHAR2(25)
passport                          VARCHAR2(15)
phoneNum                          NUMBER(13)
specialty                         VARCHAR2(50)
desc_specialty                    VARCHAR2(150)
hospital                          VARCHAR2(50)
address_hospital                  VARCHAR2(50)
address_emergency                 VARCHAR2(50)
ZIP_hospital                      NUMBER(5)
town_hospital                     VARCHAR2(35)
country_hospital                  VARCHAR2(50)
phone_hospital                    VARCHAR2(14)
```

```
fsdb.contracts
Name                     Null?    Type
------------------------ -------- -------------
hospital                          VARCHAR2(50)
address_hospital                  VARCHAR2(50)
address_emergency                 VARCHAR2(50)
ZIP_hospital                      NUMBER(5)
town_hospital                     VARCHAR2(35)
country_hospital                  VARCHAR2(50)
phone_hospital                    VARCHAR2(14)
insurer                           VARCHAR2(40)
taxID_insurer                     VARCHAR2(10)
address_insurer                   VARCHAR2(50)
ZIP_insurer                       NUMBER(5)
town_insurer                      VARCHAR2(35)
phone_insurer                     VARCHAR2(14)
email_insurer                     VARCHAR2(30)
web_insurer                       VARCHAR2(30)
start_date                        VARCHAR2(10)
end_date                          VARCHAR2(10)
```

```
fsdb.coverages
Name                     Null?    Type
------------------------ -------- -------------
product                           VARCHAR2(50)
version                           VARCHAR2(5)
launch                            VARCHAR2(10)
retired                           VARCHAR2(10)
coverage                          VARCHAR2(50)
description                       VARCHAR2(150)
waiting_period                    VARCHAR2(12)
insurer                           VARCHAR2(40)
taxID_insurer                     VARCHAR2(10)
address_insurer                   VARCHAR2(50)
ZIP_insurer                       NUMBER(5)
town_insurer                      VARCHAR2(35)
phone_insurer                     VARCHAR2(14)
email_insurer                     VARCHAR2(60)
web_insurer                       VARCHAR2(30)
```

```
fsdb.clients
Name                     Null?    Type
------------------------ -------- -------------
passport                          VARCHAR2(15)
name                              VARCHAR2(40)
surname1                          VARCHAR2(25)
surname2                          VARCHAR2(25)
gender                            VARCHAR2(6)
email                             VARCHAR2(60)
CIF_insurer                       VARCHAR2(10)
product                           VARCHAR2(50)
version                           NUMBER(4,2)
contracted                        VARCHAR2(10)
duration                          NUMBER(4)
```