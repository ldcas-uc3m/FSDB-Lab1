-- set echo off
clear screen


-- Drops Section --

drop table Appointment;
drop table Contract;
drop table Costumer;
drop table Product;
drop table Concert;
drop table Hospital;
drop table Doctor_Specialty;
drop table Doctor;
drop table Insurance_Company;
drop table Hospital_Specialty;
drop table Specialty;


-- Tables Creation Section --

create table Specialty(
    name varchar2(50),
    description varchar2(150) not null,
    
    constraint PK_specialty primary key(name)
);


create table Insurance_Company(
    cif varchar2(10),
    name varchar2(40) not null,
    address varchar2(50) not null,
    city varchar2(35) not null,
    zip number(5) not null,
    telephone number(13) not null,
    email varchar2(60) not null,
    url varchar2(30) not null,

    constraint PK_insurance_company primary key(cif),
    
    constraint UK_insurance_company_name unique(name),
    constraint UK_insurance_company_address unique(address),
    constraint UK_insurance_company_telephone unique(telephone),
    constraint UK_insurance_company_email unique(email),
    constraint UK_insurance_company_url unique(url)
);


create table Hospital(
    name varchar2(50) not null,
    cif  varchar2(10)not null,
    main_entrance varchar2(50) not null,
    emergency_entrance varchar2(50),
    city varchar2(35) not null,
    country varchar2(50) not null,
    zip number(5) not null,
    telephone number(13) not null,

    constraint PK_hospital primary key(cif)
);


create table Customer(
    id varchar2(15),
    name varchar2(40) not null, 
    surname1 varchar(25) not null,
    surname2 varchar(25) not null, 
    sex varchar(6) not null,
    email varchar(60) not null,

    constraint PK_customer primary key(id),
    
    constraint UK_Customer_email unique(email)
);


create table Doctor(
    collegiate varchar(12) not null,
    locator number(13) not null,
    name varchar(40) not null,
    surname1 varchar2(25) not null, 
    surname2 varchar2(25),
    id varchar(15) not null,
    hospital_cif varchar2(10),
    
    constraint PK_doctor primary key(collegiate),
    
    constraint UK_doctor unique(locator),
    constraint UK_doctor unique(id),

    constraint FK_doctor foreign key(hospital_cif) references Hospital(cif)
);


create table Hospital_Specialty(
    hospital_cif varchar2(50) not null,
    specialty_name varchar2(50) not null,

    constraint PK_hospital_specialty primary key(hospital, specialty),

    constraint FK_hospital_specialty foreign key(hospital_cif) references Hospitals(name) on delete cascade,
    constraint FK_hospital_specialty foreign key(specialty_name) references Specialty(name) on delete cascade
);


create table Doctor_Specialty(
    doctor varchar2(12), 
    specialty varchar2(50) not null,

    constraint PK_doctor_specialty primary key(doctor, specialty),
    
    constraint FK_doctor_specialty foreign key(doctor) references Doctor(name) on delete cascade,
    constraint FK_doctor_specialty foreign key(specialty) references Specialty(name) on delete cascade
);


create table Concert(
    insurance_cif varchar2(10),
    hospital_cif varchar2(10),
    start_date date,
    end_date not null,
    
    constraint PK_concert primary key (insurance_cif, hospital_cif, start_date),

    constraint FK_concert_insurance_cif foreign key (insurance_cif) references Insurance_Company(cif),
    constraint FK_concert_hospital_cif foreign key (hospital_cif) references Hospital(cif)
);


create table Product(
    name varchar2(50),
    specialty varchar2(50), 
    wait_period varchar2(12) not null, 
    active varchar2(10),
    version number(4,2) not null,
    launch date not null,
    retired date not null,

    constraint PK_product primary key(name, specialty),

    constraint FK_product_specialty foreign key(specialty) references Specialty(name) on delete cascade 
);


create table Contract(
    customer_id varchar2(15),
    product_name varchar2(50),
    product_specialty varchar2(50) not null,
    start date not null,
    duration number(4) not null,
    end_date date not null,
    number_of_people varchar2(10) not null,

    constraint PK_Contract primary key(customer_id, product),

    constraint FK_contract_customer foreign key(customer_id) references Customer(id),
    constraint FK_contract_product_name foreign key(product_name) references Product(name) on delete cascade,
    constraint FK_contract_product_specialty foreign key(product_specialty) references Product(specialty) on delete cascade
);


create table Appointment(
    doctor_collegiate varchar2(12),
    client_id varchar2(15),
    date number(7),
    time number(4),
    hospital_cif varchar2(10),
    specialty_name varchar2(50),
    contract_customer varchar2(15),
    contract_product_name varchar2(50),
    contract_product_specialty varchar(50),

    constraint PK_appointment primary key(doctor, client_id, date, time, hospital_cif, specialty_name)

    constraint FK_appointment_doctor_cif foreign key(doctor_cif) references Doctor(cif),
    constraint FK_appointment_client_id foreign key (client_id) references Customer(id),
    constraint FK_appointment_hospital_cif foreign key (hospital_cif) references Hospital(cif),
    constraint FK_appointment_contract_product_specialty foreign key (contract_product_specialty) references Contract(product_specialty)
);