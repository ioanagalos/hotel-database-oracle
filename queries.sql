UPDATE AANGAJATI
SET prenume='ANDREI' where id_angajat=101;
select * from aangajati;

update CAMERE
set pret_camera=260 where id_camera=14;
select * from camere;

UPDATE CLIENTI
SET prenume='VASILE' where id_client=410;
select * from clienti;

UPDATE FACTURI
SET total_plata=550 where id_factura=6;
select * from facturi;

update functii
set denumire='Manager general' where id_functie=100;
select * from functii;

update hoteluri_1
set nume_hotel='NOXUS' where id_hotel=950;
select * from hoteluri_1;

Drop Table aangajati;
Flashback Table aangajati TO BEFORE DROP;

DELETE FROM CLIENTI
WHERE id_client = 320;

SELECT c.nume, f.id_factura
FROM clienti c
RIGHT JOIN facturi f ON c.id_client = f.id_client;

SELECT c.nume, f.id_factura
FROM clienti c
FULL OUTER JOIN facturi f ON c.id_client = f.id_client;

SELECT A.nume AS Nume_Angajat, A.salariu AS Salariu, H.nume_hotel AS Nume_Hotel, H.adresa AS Adresa_Hotel
FROM AANGAJATI A
JOIN HOTELURI_1 H ON A.id_hotel = H.id_hotel;

select aa.nume, aa.prenume, h.nume_hotel, aa.feedback from aangajati aa inner join hoteluri_1 h
on aa.id_hotel = h.id_hotel where aa.feedback = 'P';

select c.nume, c.prenume, f.id_factura from clienti c left join facturi f on c.id_factura = f.id_factura;

select c.nume, c.prenume, f.id_factura from clienti c left join facturi f on c.id_factura = f.id_factura where c.id_factura is null;

SELECT id_hotel, SUM(salariu)
FROM aangajati
GROUP BY id_hotel;

SELECT MIN(salariu)
FROM aangajati;

SELECT id_camera, COUNT(*)
FROM clienti
GROUP BY id_camera;

SELECT ROUND(AVG(salariu), 2) AS Salariu_Mediu
FROM AANGAJATI;

SELECT count(distinct salariu) FROM aangajati;

SELECT id_hotel, ROUND(AVG(salariu)) AS Salariu_Mediu
FROM aangajati
GROUP BY id_hotel
HAVING AVG(salariu) > 4000;

select c.nume, c.prenume, f.total_plata
from clienti c, facturi f
where c.id_factura = f.id_factura and f.total_plata between 250 and 400
order by f.total_plata desc;

alter table AANGAJATI add id_sef number(3);

update AANGAJATI set id_sef = null where id_angajat in (101,201,301,401);
update AANGAJATI set id_sef = 101 where id_angajat in (102,103,104,105);
update AANGAJATI set id_sef = 201 where id_angajat in (202,203);
update AANGAJATI set id_sef = 301 where id_angajat in (302,303,304,305,306);
update AANGAJATI set id_sef = 401 where id_angajat in (402);

select level as nivel,
id_angajat,
nume,
prenume
from AANGAJATI
start with id_sef is null
connect by prior id_angajat = id_sef;

SELECT LEVEL AS nivel,
id_angajat,
nume,
prenume
FROM AANGAJATI
START WITH id_angajat = 101
CONNECT BY PRIOR id_angajat = id_sef;

SELECT LEVEL AS nivel,
a.id_angajat,
a.nume,
a.prenume,
h.nume_hotel
FROM AANGAJATI a
JOIN HOTELURI_1 h ON a.id_hotel = h.id_hotel
START WITH a.id_sef IS NULL
CONNECT BY PRIOR a.id_angajat = a.id_sef;

SELECT MAX(LEVEL) AS nivel_maxim
FROM AANGAJATI
START WITH id_sef IS NULL
CONNECT BY PRIOR id_angajat = id_sef;

SELECT SYS_CONNECT_BY_PATH(nume, ' -> ') AS traseu_ierarhic
FROM AANGAJATI
START WITH id_sef IS NULL
CONNECT BY PRIOR id_angajat = id_sef;

SELECT nume FROM aangajati
UNION
SELECT nume FROM clienti;

SELECT id_camera FROM camere
INTERSECT
SELECT id_camera FROM clienti;

SELECT nume FROM aangajati
MINUS
SELECT nume FROM clienti;

SELECT
nume,
prenume,
DECODE(nume, 'MARINESCU', 500, 0) AS Bonus
FROM aangajati;

SELECT nume_hotel, DECODE(numar_stele, 1, '*', 2, '**', 3, '***', 4, '****', 5, '*****') stele FROM hoteluri_1;

SELECT
ID_angajat,
nume,
salariu,
CASE
WHEN SALARIU >= 2500 THEN 'Mare'
ELSE 'Mic'
END AS STARE_SALARIU
FROM aangajati;

SELECT
id_angajat,
nume,
ani_vechime,
CASE
WHEN ani_vechime >= 5 THEN 'Experimentat'
WHEN ani_vechime >= 2 THEN 'Intermediar'
ELSE 'Incepator'
END AS Nivel_Experienta
FROM aangajati;

SELECT H.nume_hotel,
(SELECT COUNT(*)
FROM AANGAJATI A
WHERE A.id_hotel = H.id_hotel) AS Numar_Angajati
FROM HOTELURI_1 H;

select c.id_client, c.nume, c.prenume
from clienti c
where c.id_client not in (
select c2.id_client
from clienti c2
join camere ca2 on ca2.id_camera = c2.id_camera
where ca2.id_hotel = 300
);

SELECT nume || ' ' || prenume AS Nume_Complet
FROM AANGAJATI;

SELECT UPPER(nume_hotel) AS Nume_Hotel_Majuscule
FROM HOTELURI_1;

select substr(nume, 1, 1) as Initiala_nume, substr(prenume, 1, 1) as Initiala_prenume from aangajati;

select id_factura, data_factura from facturi where
EXTRACT(YEAR FROM data_factura) != 2022;

SELECT id_factura, data_factura FROM facturi
WHERE data_factura BETWEEN TO_DATE('2022-01-15','yyyy-mm-dd') AND TO_DATE('2022-01-31','yyyy-mm-dd');

SELECT nume, prenume FROM clienti WHERE id_client IN (110,330,420);

CREATE OR REPLACE VIEW Vizualizare_Angajati_Hoteluri AS
SELECT A.nume AS Nume_Angajat, H.nume_hotel AS Nume_Hotel
FROM AANGAJATI A
JOIN HOTELURI_1 H ON A.id_hotel = H.id_hotel;

SELECT * FROM Vizualizare_Angajati_Hoteluri;

CREATE SYNONYM cc FOR clienti;
SELECT * FROM cc;
DROP SYNONYM cc;

CREATE INDEX idx_tot_plata ON facturi(total_plata);

CREATE SEQUENCE seq_id_client
start with 1000
increment by 1
NOCACHE
NOCYCLE;

select *
from user_sequences
where sequence_name = 'SEQ_ID_CLIENT';
