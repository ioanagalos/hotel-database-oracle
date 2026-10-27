drop table FACTURI cascade constraints;
drop table CLIENTI cascade constraints;
drop table CAMERE cascade constraints;
drop table AANGAJATI cascade constraints;
drop table FUNCTII cascade constraints;
drop table HOTELURI_1 cascade constraints;

create table HOTELURI_1
(
id_hotel NUMBER(3) primary key,
nume_hotel VARCHAR2(50) not null,
adresa VARCHAR2(80),
numar_stele NUMBER(1)
);

alter table HOTELURI_1 add constraint HOTELURI_UK_1 unique(nume_hotel);
alter table HOTELURI_1 add constraint HOTELURI_CK_STELE check (numar_stele between 1 and 5);

create table FUNCTII
(
id_functie NUMBER(3) primary key,
denumire varchar2(30) not null,
salariu_min number(4)
);

create table AANGAJATI (
id_angajat number(3) primary key,
nume varchar2(20) not null,
prenume varchar2(20),
telefon varchar2(20),
email varchar2(50),
id_functie number(3),
id_hotel number(3),
ani_vechime number(2),
salariu number(4),
feedback char(1)
);

alter table AANGAJATI
add constraint AANGAJATI_FK
foreign key (id_hotel) references HOTELURI_1 (id_hotel);

alter table AANGAJATI
add constraint AANGAJATI_FK2
foreign key (id_functie) references FUNCTII (id_functie);

alter table AANGAJATI add constraint AANGAJATI_CK_SAL check (salariu > 0);
alter table AANGAJATI add constraint AANGAJATI_CK_FEEDBACK check (feedback in ('P', 'N'));

create table CAMERE (
id_camera number(2) primary key,
numar_persoane number(1),
pret_camera number(4),
id_hotel number(3)
);

alter table CAMERE
add constraint CAMERE_FK_HOTEL
foreign key (id_hotel) references HOTELURI_1 (id_hotel);

create table CLIENTI (
id_client number(3) primary key,
nume varchar2(20) not null,
prenume varchar2(20),
telefon varchar2(20),
email varchar2(50),
id_camera number(2),
id_factura number(2)
);

alter table CLIENTI
add constraint CLIENTI_FK_CAMERA
foreign key (id_camera) references CAMERE (id_camera);

create table FACTURI
(
id_factura number(2) primary key,
data_factura date,
id_client number(3),
id_camera number(2),
total_plata number(5),
durata number(2)
);

alter table FACTURI add constraint FACTURI_FK1
foreign key (id_client) references CLIENTI (id_client);

alter table FACTURI add constraint FACTURI_FK2
foreign key (id_camera) references CAMERE (id_camera);
