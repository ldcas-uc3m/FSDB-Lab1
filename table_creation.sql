set echo off
clear screen


-- Drops Section --

drop table Appointment;
drop table Contract;
drop table Product_Coverages;
drop table Product;
drop table Concert;
drop table Doctor_Specialty;
drop table Hospital_Specialty;
drop table Doctor_Hospital;
drop table Doctor;
drop table Customer;
drop table Hospital;
drop table Insurance_Company;
drop table Specialty;



-- Tables Creation Section --

create table Specialty (
    name varchar2(50),
    description varchar2(150) not null,
    constraint PK_specialty primary key(name)
);


create table Insurance_Company (
    cif varchar2(9),
    name varchar2(40) not null,
    address varchar2(50) not null,
    city varchar2(35) not null,
    zip number(5) not null,
    telephone varchar2(14) not null,
    email varchar2(30) not null,
    url varchar2(30) not null,
    constraint PK_insurance_company primary key(cif),
    constraint UK_insurance_company_name unique(name),
    constraint UK_insurance_company_address unique(address),
    constraint UK_insurance_company_telephone unique(telephone),
    constraint UK_insurance_company_email unique(email),
    constraint UK_insurance_company_url unique(url)
);


create table Hospital (
    name varchar2(50),
    cif varchar2(9),
    main_entrance varchar2(50) not null,
    emergency_entrance varchar2(50),
    city varchar2(35) not null,
    country varchar2(50) not null,
    zip number(5) not null,
    telephone varchar2(14) not null,
    constraint PK_hospital primary key(name),
    constraint UK_hospital_cif unique(cif),
    constraint UK_hospital_main_entrance unique(main_entrance),
    constraint CH_hospital_telephone check(telephone > 0),
    constraint CH_hospital_zip check(zip > 0)
);


create table Customer (
    id varchar2(15),
    name varchar2(40) not null,
    surname1 varchar2(25) not null,
    surname2 varchar2(25),
    sex varchar2(6) not null,
    email varchar2(60) not null,
    constraint PK_customer primary key(id),
    constraint UK_Customer_email unique(email)
);


create table Doctor (
    collegiate varchar2(12) not null,
    locator varchar2(14),
    name varchar2(40) not null,
    surname1 varchar2(25) not null,
    surname2 varchar2(25),
    id varchar2(15) not null,
    constraint PK_doctor primary key(collegiate),
    constraint UK_doctor_locator unique(locator),
    constraint UK_doctor_id unique(id)
);


create table Doctor_Hospital (
    doctor_collegiate varchar2(12),
    hospital_name varchar2(50),
    constraint PK_doctor_hospital primary key(doctor_collegiate, hospital_name),
    constraint FK_doctor_hospital_doctor_collegiate foreign key(doctor_collegiate) references Doctor(collegiate) on delete cascade,
    constraint FK_doctor_hospital_hospital_name foreign key(hospital_name) references Hospital(name) on delete cascade
);


create table Hospital_Specialty (
    hospital_name varchar2(50),
    specialty_name varchar2(50),
    constraint PK_hospital_specialty primary key(hospital_name, specialty_name),
    constraint FK_hospital_specialty_hospital_name foreign key(hospital_name) references Hospital(name) on delete cascade,
    constraint FK_hospital_specialty_specialty_name foreign key(specialty_name) references Specialty(name) on delete cascade
);


create table Doctor_Specialty (
    doctor_collegiate varchar2(12),
    specialty_name varchar2(50),
    constraint PK_doctor_specialty primary key(doctor_collegiate, specialty_name),
    constraint FK_doctor_specialty_doctor_name foreign key(doctor_collegiate) references Doctor(collegiate) on delete cascade,
    constraint FK_doctor_specialty_specialty_name foreign key(specialty_name) references Specialty(name) on delete cascade
);


create table Concert (
    insurance_cif varchar2(9),
    hospital_name varchar2(50),
    start_date varchar2(10),
    end_date varchar2(10),
    constraint PK_concert primary key(insurance_cif, hospital_name, start_date),
    constraint FK_concert_insurance_cif foreign key(insurance_cif) references Insurance_Company(cif),
    constraint FK_concert_hospital_name foreign key(hospital_name) references Hospital(name),
    constraint CH_concert_date check(end_date is not null or end_date > start_date)
);


create table Product (
    name varchar2(50),
    company_cif varchar2(10),
    version number(4,2) not null,
    constraint PK_product primary key(name, company_cif),
    constraint FK_product_company_cif foreign key(company_cif) references Insurance_Company(cif),
    constraint CH_product_version check(version >= 0)
);


create table Product_Coverages (
    product_name varchar2(50),
    company_cif varchar2(9),
    specialty_name varchar2(50),
    wait_period varchar2(12) not null,
    launch varchar2(10) not null,
    retired varchar2(10),
    constraint PK_product_coverages primary key(product_name, specialty_name, launch, company_cif),
    constraint FK_product_coverages_product_name foreign key(product_name, company_cif) references Product(name, company_cif) on delete cascade,
    constraint FK_product_coverages_company_cif foreign key(company_cif) references Insurance_Company(cif) on delete cascade,
    constraint FK_product_coverages_specialty_name foreign key(specialty_name) references Specialty(name) on delete cascade,
    constraint CH_product_coverages_ check(retired > launch)
);


create table Contract (
    customer_id varchar2(15),
    product_name varchar2(50),
    company_cif varchar2(9),
    start_date date not null,
    duration number(4) not null,
    end_date date not null,
    constraint PK_contract primary key(customer_id, product_name, company_cif),
    constraint FK_contract_customer_id foreign key(customer_id) references Customer(id) on delete cascade,
    constraint FK_contract_product_name foreign key(product_name, company_cif) references Product(name, company_cif) on delete cascade,
    constraint CH_contract_date check(end_date is not null or end_date > start_date)
);


create table Appointment (
    doctor_collegiate varchar2(12),
    client_id varchar2(15),
    appointment_date date,
    hospital_name varchar2(50),
    specialty_name varchar2(50),
    constraint PK_appointment primary key(doctor_collegiate, client_id, appointment_date, hospital_name, specialty_name),
    constraint FK_appointment_doctor_collegiate foreign key(doctor_collegiate) references Doctor(collegiate),
    constraint FK_appointment_client_id foreign key(client_id) references Customer(id),
    constraint FK_appointment_hospital_name foreign key(hospital_name) references Hospital(name)
);
