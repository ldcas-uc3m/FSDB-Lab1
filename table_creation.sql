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
    name varchar2(50) not null,
    address varchar2(50) not null,
    city varchar2(35) not null,
    zip number(5) not null,
    telephone varchar2(14) not null,
    email varchar2(60) not null,
    url varchar2(60) not null,
    constraint PK_Insurance_Company primary key(cif),
    constraint UK_Insurance_Company_name unique(name),
    constraint UK_Insurance_Company_address unique(address),
    constraint UK_Insurance_Company_telephone unique(telephone),
    constraint UK_Insurance_Company_email unique(email),
    constraint UK_Insurance_Company_url unique(url)
);


create table Hospital (
    name varchar2(50),
    cif varchar2(9),
    main_entrance varchar2(50) not null,
    emergency_entrance varchar2(50),
    city varchar2(50) not null,
    country varchar2(50) not null,
    zip number(5) not null,
    telephone varchar2(14) not null,
    constraint PK_Hospital primary key(name),
    constraint UK_Hospital_cif unique(cif),
    constraint UK_Hospital_main_entrance unique(main_entrance),
    constraint CH_Hospital_zip check(zip > 0)
);


create table Customer (
    id varchar2(15),
    name varchar2(40) not null,
    surname1 varchar2(25) not null,
    surname2 varchar2(25),
    sex varchar2(6) not null,
    email varchar2(60) not null,
    constraint PK_Customer primary key(id),
    constraint UK_Customer_email unique(email)
);


create table Doctor (
    collegiate varchar2(12) not null,
    locator varchar2(14),
    name varchar2(40) not null,
    surname1 varchar2(25) not null,
    surname2 varchar2(25),
    id varchar2(15) not null,
    constraint PK_Doctor primary key(collegiate),
    constraint UK_Doctor_locator unique(locator),
    constraint UK_Doctor_id unique(id)
);


create table Doctor_Hospital (
    doctor_collegiate varchar2(12),
    hospital_name varchar2(50),
    constraint PK_Doctor_Hospital primary key(doctor_collegiate, hospital_name),
    constraint FK_Doctor_Hospital_doctor_collegiate foreign key(doctor_collegiate) references Doctor(collegiate) on delete cascade,
    constraint FK_Doctor_Hospital_hospital_name foreign key(hospital_name) references Hospital(name) on delete cascade
);


create table Hospital_Specialty (
    hospital_name varchar2(50),
    specialty_name varchar2(50),
    constraint PK_Hospital_Specialty primary key(hospital_name, specialty_name),
    constraint FK_Hospital_Specialty_hospital_name foreign key(hospital_name) references Hospital(name) on delete cascade,
    constraint FK_Hospital_Specialty_specialty_name foreign key(specialty_name) references Specialty(name) on delete cascade
);


create table Doctor_Specialty (
    doctor_collegiate varchar2(12),
    specialty_name varchar2(50),
    constraint PK_Doctor_Specialty primary key(doctor_collegiate, specialty_name),
    constraint FK_Doctor_Specialty_doctor_name foreign key(doctor_collegiate) references Doctor(collegiate) on delete cascade,
    constraint FK_Doctor_Specialty_specialty_name foreign key(specialty_name) references Specialty(name) on delete cascade
);


create table Concert (
    insurance_cif varchar2(9),
    hospital_name varchar2(50),
    start_date date,
    end_date date,
    constraint PK_Concert primary key(insurance_cif, hospital_name, start_date),
    constraint FK_Concert_insurance_cif foreign key(insurance_cif) references Insurance_Company(cif),
    constraint FK_Concert_hospital_name foreign key(hospital_name) references Hospital(name),
    constraint CH_Concert_date check(end_date is not null or end_date > start_date)
);

-- 1 active; 0 inactive
create table Product (
    name varchar2(50),
    company_cif varchar2(10),
    version number(4,2) not null,
    launch date not null,
    retired date,
    active number(1) not null,
    constraint PK_Product primary key(name, company_cif, version),
    constraint FK_Product_company_cif foreign key(company_cif) references Insurance_Company(cif),
    constraint CH_Product_version check(version >= 0),
    constraint CH_Product_retired check(retired is not null or retired > launch),
    constraint CH_Product_active check((retired is not null and active = 0) or (retired is null and active = 1))
);


create table Product_Coverages (
    product_name varchar2(50),
    company_cif varchar2(9),
    product_version number(4,2),
    specialty_name varchar2(50),
    wait_period varchar2(12) not null,
    constraint PK_Product_Coverages primary key(product_name, company_cif, product_version, specialty_name),
    constraint FK_Product_Coverages_product_name foreign key(product_name, company_cif, product_version) references Product(name, company_cif, version) on delete cascade
);


create table Contract (
    customer_id varchar2(15),
    product_name varchar2(50),
    company_cif varchar2(9),
    product_version number(4,2) not null,
    start_date date not null,
    duration number(4) not null,
    end_date date not null,
    constraint PK_Contract primary key(customer_id, product_name, company_cif, product_version),
    constraint FK_Contract_customer_id foreign key(customer_id) references Customer(id) on delete cascade,
    constraint FK_Contract_product_name foreign key(product_name, company_cif, product_version) references Product(name, company_cif, version) on delete cascade,
    constraint CH_Contract_date check(start_date + duration = end_date)
);


create table Appointment (
    doctor_collegiate varchar2(12),
    client_id varchar2(15),
    appointment_date date,
    hospital_name varchar2(50),
    specialty_name varchar2(50),
    constraint PK_Appointment primary key(doctor_collegiate, client_id, appointment_date, hospital_name, specialty_name),
    constraint FK_Appointment_doctor_collegiate foreign key(doctor_collegiate) references Doctor(collegiate),
    constraint FK_Appointment_client_id foreign key(client_id) references Customer(id),
    constraint FK_Appointment_hospital_name foreign key(hospital_name) references Hospital(name)
);


