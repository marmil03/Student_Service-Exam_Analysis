DROP TABLE Čas                        CASCADE CONSTRAINTS;
DROP TABLE Članovi_Komisije           CASCADE CONSTRAINTS;
DROP TABLE Fakultet                   CASCADE CONSTRAINTS;
DROP TABLE Ispit                      CASCADE CONSTRAINTS;
DROP TABLE Izvor                      CASCADE CONSTRAINTS;
DROP TABLE Komisija                   CASCADE CONSTRAINTS;
DROP TABLE Lista_Pitanja_Za_Ispit     CASCADE CONSTRAINTS;
DROP TABLE Lista_Studenata_Na_Ispitu  CASCADE CONSTRAINTS;
DROP TABLE Nivo_Studija               CASCADE CONSTRAINTS;
DROP TABLE Obaveza                    CASCADE CONSTRAINTS;
DROP TABLE Pitanje                    CASCADE CONSTRAINTS;
DROP TABLE Plan_Ispita                CASCADE CONSTRAINTS;
DROP TABLE Predavač                   CASCADE CONSTRAINTS;
DROP TABLE Predmet                    CASCADE CONSTRAINTS;
DROP TABLE Rok                        CASCADE CONSTRAINTS;
DROP TABLE Smer                       CASCADE CONSTRAINTS;
DROP TABLE Student                    CASCADE CONSTRAINTS;
DROP TABLE Tip_Ispita                 CASCADE CONSTRAINTS;
DROP TABLE Uplata_Za_Ispit            CASCADE CONSTRAINTS;
DROP TABLE Vreme_Polaganja            CASCADE CONSTRAINTS;
DROP TABLE Žiro_Račun                 CASCADE CONSTRAINTS;

CREATE TABLE Čas (
    Čas_Id             varchar2(6) PRIMARY KEY,
    Tip_Časa           varchar2(10) NOT NULL,
    Opis_Nastave       varchar2(50),
    Predmet_Predmetid  integer NOT NULL,
    Način_Izvršavanja  varchar2(30) NOT NULL
);

CREATE TABLE Žiro_Račun (
    Žr_Id                varchar2(30) NOT NULL,
    Fakultet_Fakultetid  varchar2(6) NOT NULL,
	Stanje               integer NOT NULL
);

CREATE TABLE Članovi_Komisije (    
	Komisija_Komisija_Id  varchar2(15) NOT NULL,
	Predavač_Predavačid   varchar2(6) NOT NULL,
    Datum_Pristupanja     date NOT NULL
);

CREATE TABLE Izvor (
    Izvor_Id             varchar2(15) PRIMARY KEY,
    Tip_Izvora           varchar2(15) NOT NULL,
    Referenca_Ka_Izvoru  varchar2(15)
);

CREATE TABLE Fakultet (
    Fakultetid     varchar2(6) PRIMARY KEY,
    Naziv          varchar2(50) NOT NULL,
    Adresa         varchar2(30) NOT NULL,
    Kontakt        varchar2(20) NOT NULL,
    Link_Ka_Sajtu  varchar2(30)
);

CREATE TABLE Komisija (
    Komisija_Id              varchar2(15) PRIMARY KEY,
    Datum_Stvaranja          date NOT NULL,
    Datum_Raspuštanja        date,
    Broj_Nadgledanih_Ispita  integer
);

CREATE TABLE Uplata_Za_Ispit (
    Datum_I_Vreme          date NOT NULL,
    Iznos                  integer NOT NULL,
    Žiro_Račun_Žr_Id       varchar2(30) NOT NULL,
    Student_Studentid      integer NOT NULL,
    Žiro_Račun_Fakultetid  varchar2(6) NOT NULL
);

CREATE TABLE Lista_Pitanja_Za_Ispit (
    Ispit_Ispitid            varchar2(10) NOT NULL,
    Ispit_Predmet_Predmetid  integer NOT NULL,
	Pitanje_Pitanje_Id       varchar2(7) NOT NULL,
    Pitanje_Izvor_Id         varchar2(15) NOT NULL,
    Datum_Kreiranja          date NOT NULL,
    Broj_Pitanja             integer NOT NULL
);

CREATE TABLE Tip_Ispita (
    Tip_Ispita_Id                  varchar2(10) PRIMARY KEY,
    Broj_Espb_Bodova_Po_Položenom  integer NOT NULL,
    Broj_Bodova_Usmeno             integer NOT NULL,
    Broj_Bodova_Pismeno            integer NOT NULL
);

CREATE TABLE Nivo_Studija (
    Nivo_Studija_Id           varchar2(10) PRIMARY KEY,
    Godina_Trajanja           integer NOT NULL,
    Zvanje_Po_Zavšetku        varchar2(30) NOT NULL,
    Naziv                     varchar2(30) NOT NULL,
    Smer_Smerid               varchar2(6) NOT NULL,
    Smer_Fakultet_Fakultetid  varchar2(6) NOT NULL
);

CREATE TABLE Obaveza (
    Obaveza_Id         varchar2(10) NOT NULL,
	Datum_Zadavanja    date NOT NULL,
    Rok_Završetka      date NOT NULL,
    Broj_Bodova        integer NOT NULL,
    Opis_Obaveze       varchar2(50),
    Čas_Čas_Id         varchar2(6) NOT NULL,
    Student_Studentid  integer NOT NULL,
	Završena		   integer
);

CREATE TABLE Pitanje (
    Pitanje_Id        varchar2(7) NOT NULL,
    Tekst_Pitanja     varchar2(250) NOT NULL,
    Rešenje           varchar2(250) NOT NULL,
    Bodovna_Vrednost  integer NOT NULL,
    Lekcija           varchar2(20) NOT NULL,
    Izvor_Izvor_Id    varchar2(15) NOT NULL
);

CREATE TABLE Smer (
    Smerid                     varchar2(6) NOT NULL,
	Fakultet_Fakultetid        varchar2(6) NOT NULL,
	Naziv                      varchar2(30) NOT NULL,
    Maksimalan_Broj_Studenata  integer NOT NULL
);

CREATE TABLE Student (
    Studentid                 integer PRIMARY KEY,
    Broj_Indeksa              varchar2(10) NOT NULL,
    Ime                       varchar2(30) NOT NULL,
    Prezime                   varchar2(30) NOT NULL,
    Jmbg                      varchar2(13) NOT NULL,
    Smer_Smerid               varchar2(6) NOT NULL,
    Smer_Fakultet_Fakultetid  varchar2(6) NOT NULL
);

CREATE TABLE Rok (
    Rokid                     varchar2(5) PRIMARY KEY,
    Naziv                     varchar2(30) NOT NULL,
    Smer_Smerid               varchar2(6) NOT NULL,
    Smer_Fakultet_Fakultetid  varchar2(6) NOT NULL
);

CREATE TABLE Vreme_Polaganja (
    Vreme_Polaganjaid  varchar2(8) PRIMARY KEY,
    Školska_Godina     varchar2(9) NOT NULL,
    Datum_Polaganja    timestamp NOT NULL,
    Rok_Rokid          varchar2(5) NOT NULL
);

CREATE TABLE Plan_Ispita (
    Rednibr            integer NOT NULL,
	Rok_ID			   varchar2(5) NOT NULL,
    Datum_Polaganja    timestamp NOT NULL,
    Mesto_Polaganja    varchar2(20) NOT NULL,
    Predmet_Predmetid  integer NOT NULL
);

CREATE TABLE Predavač (
    Predavačid           varchar2(6) PRIMARY KEY,
    Ime                  varchar2(30) NOT NULL,
    Prezime              varchar2(30) NOT NULL,
    Telefon              varchar2(15) NOT NULL,
    "E-Mail"             varchar2(30) NOT NULL,
    Jmbg                 varchar2(13) NOT NULL,
    Akademsko_Zvanje     varchar2(30) NOT NULL,
	Predmet_Predmetid    integer NOT NULL,
    Izborno_Zvanje       varchar2(10),
    Plan_Ispita_Rednibr  integer,
	Plan_Ispita_Rokid	 varchar2(5)
);

CREATE TABLE Predmet (
    Predmetid    integer PRIMARY KEY,
    Naziv        varchar2(30) NOT NULL,
    Broj_Časova  integer NOT NULL,
    Semestar     integer NOT NULL
);

CREATE TABLE Ispit (
    Ispitid                            varchar2(10) NOT NULL,
	Predmet_Predmetid                  integer NOT NULL,
    Overen_Semestar                    char(1) NOT NULL,
    V_P_Vreme_Pid  					   varchar2(8) NOT NULL,
    Tip_Ispita_Tip_Ispita_Id           varchar2(10) NOT NULL,
    Komisija_Komisija_Id               varchar2(15) NOT NULL
);

CREATE TABLE Lista_Studenata_Na_Ispitu (
    Ispit_Ispitid            varchar2(10) NOT NULL,
	Ispit_Predmet_Predmetid  integer NOT NULL,
    Student_Studentid        integer NOT NULL,
	Uplatio                  char(1) NOT NULL,
	Ocena					 integer 
);

ALTER TABLE Žiro_Račun                ADD CONSTRAINT Žiro_Račun_Pk                PRIMARY KEY ( Žr_Id,Fakultet_Fakultetid );
ALTER TABLE Uplata_Za_Ispit           ADD CONSTRAINT Uplata_Za_Ispit_Pk           PRIMARY KEY ( Datum_I_Vreme,Žiro_Račun_Žr_Id,Žiro_Račun_Fakultetid,Student_Studentid );
ALTER TABLE Obaveza                   ADD CONSTRAINT Obaveza_Pk                   PRIMARY KEY ( Obaveza_Id,Čas_Čas_Id,Student_Studentid );
ALTER TABLE Pitanje                   ADD CONSTRAINT Pitanje_Pk                   PRIMARY KEY ( Pitanje_Id,Izvor_Izvor_Id );
ALTER TABLE Ispit                     ADD CONSTRAINT Ispit_Pk                     PRIMARY KEY ( Ispitid,Predmet_Predmetid );
ALTER TABLE Smer                      ADD CONSTRAINT Smer_Pk                      PRIMARY KEY ( Smerid,Fakultet_Fakultetid );
ALTER TABLE Plan_Ispita               ADD CONSTRAINT Plan_Ispita_Pk               PRIMARY KEY (Rednibr,Rok_Id);
ALTER TABLE Lista_Studenata_Na_Ispitu ADD CONSTRAINT Lista_Studenata_Na_Ispitu_Pk PRIMARY KEY ( Ispit_Ispitid,Ispit_Predmet_Predmetid,Student_Studentid );
ALTER TABLE Lista_Pitanja_Za_Ispit    ADD CONSTRAINT Lista_Pitanja_Za_Ispit_Pk    PRIMARY KEY ( Ispit_Ispitid,Ispit_Predmet_Predmetid,Pitanje_Pitanje_Id,Pitanje_Izvor_Id );
ALTER TABLE Članovi_Komisije          ADD CONSTRAINT Članovi_Komisije_Pk          PRIMARY KEY ( Predavač_Predavačid,Komisija_Komisija_Id );
----
ALTER TABLE Čas                       ADD CONSTRAINT Čas_Predmet_Fk               FOREIGN KEY ( Predmet_Predmetid )                      REFERENCES Predmet         ( Predmetid );
ALTER TABLE Članovi_Komisije          ADD CONSTRAINT Članovi_Komisije_Komisija_Fk FOREIGN KEY ( Komisija_Komisija_Id )                   REFERENCES Komisija        ( Komisija_Id );
ALTER TABLE Članovi_Komisije          ADD CONSTRAINT Članovi_Komisije_Predavač_Fk FOREIGN KEY ( Predavač_Predavačid )                    REFERENCES Predavač        ( Predavačid );
ALTER TABLE Ispit                     ADD CONSTRAINT Ispit_Komisija_Fk            FOREIGN KEY ( Komisija_Komisija_Id )                   REFERENCES Komisija        ( Komisija_Id );
ALTER TABLE Ispit                     ADD CONSTRAINT Ispit_Predmet_Fk             FOREIGN KEY ( Predmet_Predmetid )                      REFERENCES Predmet         ( Predmetid );
ALTER TABLE Ispit                     ADD CONSTRAINT Ispit_Tip_Ispita_Fk          FOREIGN KEY ( Tip_Ispita_Tip_Ispita_Id )               REFERENCES Tip_Ispita      ( Tip_Ispita_Id );
ALTER TABLE Ispit                     ADD CONSTRAINT Ispit_Vreme_Polaganja_Fk     FOREIGN KEY ( V_P_Vreme_Pid )                          REFERENCES Vreme_Polaganja ( Vreme_Polaganjaid );
ALTER TABLE Lista_Pitanja_Za_Ispit    ADD CONSTRAINT Lista_P_Za_I_Ispit_Fk        FOREIGN KEY ( Ispit_Ispitid,Ispit_Predmet_Predmetid )  REFERENCES Ispit           ( Ispitid,Predmet_Predmetid );
ALTER TABLE Lista_Pitanja_Za_Ispit    ADD CONSTRAINT Lista_P_Za_I_Pitanje_Fk      FOREIGN KEY ( Pitanje_Pitanje_Id,Pitanje_Izvor_Id )    REFERENCES Pitanje         ( Pitanje_Id,Izvor_Izvor_Id );
ALTER TABLE Lista_Studenata_Na_Ispitu ADD CONSTRAINT Lista_S_Na_I_Ispit_Fk        FOREIGN KEY ( Ispit_Ispitid,Ispit_Predmet_Predmetid )  REFERENCES Ispit           ( Ispitid,Predmet_Predmetid );
ALTER TABLE Lista_Studenata_Na_Ispitu ADD CONSTRAINT Lista_S_Na_I_Student_Fk      FOREIGN KEY ( Student_Studentid )                      REFERENCES Student         ( Studentid );
ALTER TABLE Nivo_Studija              ADD CONSTRAINT Nivo_Studija_Smer_Fk         FOREIGN KEY ( Smer_Smerid, Smer_Fakultet_Fakultetid )  REFERENCES Smer            ( Smerid,Fakultet_Fakultetid );
ALTER TABLE Obaveza                   ADD CONSTRAINT Obaveza_Čas_Fk               FOREIGN KEY ( Čas_Čas_Id )                             REFERENCES Čas             ( Čas_Id );
ALTER TABLE Obaveza                   ADD CONSTRAINT Obaveza_Student_Fk           FOREIGN KEY ( Student_Studentid )                      REFERENCES Student         ( Studentid );
ALTER TABLE Pitanje                   ADD CONSTRAINT Pitanje_Izvor_Fk             FOREIGN KEY ( Izvor_Izvor_Id )                         REFERENCES Izvor           ( Izvor_Id );
ALTER TABLE Plan_Ispita               ADD CONSTRAINT Plan_Ispita_Predmet_Fk       FOREIGN KEY ( Predmet_Predmetid )                      REFERENCES Predmet         ( Predmetid );
ALTER TABLE Plan_Ispita               ADD CONSTRAINT Plan_Ispita_Rok_Fk           FOREIGN KEY ( Rok_Id )                                 REFERENCES Rok             ( Rokid );
ALTER TABLE Predavač                  ADD CONSTRAINT Predavač_Plan_Ispita_Fk      FOREIGN KEY ( Plan_Ispita_Rednibr,Plan_Ispita_Rokid )  REFERENCES Plan_Ispita     ( Rednibr,Rok_ID);
ALTER TABLE Predavač                  ADD CONSTRAINT Predavač_Predmet_Fk          FOREIGN KEY ( Predmet_Predmetid )                      REFERENCES Predmet         ( Predmetid );
ALTER TABLE Rok                       ADD CONSTRAINT Rok_Smer_Fk                  FOREIGN KEY ( Smer_Smerid,Smer_Fakultet_Fakultetid )   REFERENCES Smer            ( Smerid,Fakultet_Fakultetid );
ALTER TABLE Smer                      ADD CONSTRAINT Smer_Fakultet_Fk             FOREIGN KEY ( Fakultet_Fakultetid )                    REFERENCES Fakultet        ( Fakultetid );
ALTER TABLE Student                   ADD CONSTRAINT Student_Smer_Fk              FOREIGN KEY ( Smer_Smerid, Smer_Fakultet_Fakultetid )  REFERENCES Smer            ( Smerid,Fakultet_Fakultetid );
ALTER TABLE Uplata_Za_Ispit           ADD CONSTRAINT Uplata_Za_Ispit_Student_Fk   FOREIGN KEY ( Student_Studentid )                      REFERENCES Student         ( Studentid );
ALTER TABLE Uplata_Za_Ispit           ADD CONSTRAINT Uplata_Za_Ispit_Žr_Fk        FOREIGN KEY ( Žiro_Račun_Žr_Id,Žiro_Račun_Fakultetid ) REFERENCES Žiro_Račun      ( Žr_Id,Fakultet_Fakultetid );
ALTER TABLE Vreme_Polaganja           ADD CONSTRAINT Vreme_Polaganja_Rok_Fk       FOREIGN KEY ( Rok_Rokid )                              REFERENCES Rok             ( Rokid );
ALTER TABLE Žiro_Račun                ADD CONSTRAINT Žiro_Račun_Fakultet_Fk       FOREIGN KEY ( Fakultet_Fakultetid )                    REFERENCES Fakultet        ( Fakultetid );
----Gotovo
INSERT INTO Fakultet VALUES('ETF001','Elektrotehnički Fakultet','Studentski trg 15','+381 112223033',null);
INSERT INTO Fakultet VALUES('FTN002','Fakultet Tehničkih Nauka','Kneza Mihaila 25','+381 113223033',null);
INSERT INTO Fakultet VALUES('RAF003','Računarski Fakultet','Studentski trg 25','+381 11422033',null);
INSERT INTO Fakultet VALUES('FON004','Fakultet Organizacionih Nauka','Kneza Mihaila 105','+381 11442033',null);
INSERT INTO Fakultet VALUES('MAT005','Matematički Fakultet','Studentski trg 55','+381 115554422',null);
----Gotovo
INSERT INTO Smer VALUES('SI0001','ETF001','Softversko Inženjerstvo',150);
INSERT INTO Smer VALUES('ER0002','ETF001','Elektrotehnika i Računarstvo',500);
INSERT INTO Smer VALUES('RD0001','RAF003','Računarski Dizajn',150);
INSERT INTO Smer VALUES('CS0001','RAF003','Kompjuterske Nauke',24);
INSERT INTO Smer VALUES('CE0002','RAF003','Kompjutersko inženjerstvo',24);
----Gotovo
INSERT INTO Student VALUES(2022001,'688/55MM','Marko','Milovanov','1408003871999','SI0001','ETF001');
INSERT INTO Student VALUES(2022002,'688/56MK','Mina','Kovačević','1808003865001','SI0001','ETF001');
INSERT INTO Student VALUES(2022003,'688/57DP','Dejan','Pavlović','2307003860006','SI0001','ETF001');
INSERT INTO Student VALUES(2022004,'688/58MP','Marko','Pojatar','0908003860001','SI0001','ETF001');
INSERT INTO Student VALUES(2022005,'688/59AŽ','Aleksandra','Živković','0204003865001','CE0002','RAF003');
----Gotovo
INSERT INTO Rok VALUES('SEPE1','Septembarski ispitni rok','SI0001','ETF001');
INSERT INTO Rok VALUES('SEPE2','Septembarski ispitni rok','ER0002','ETF001');
INSERT INTO Rok VALUES('DECE1','Decembarski ispitni rok','SI0001','ETF001');
INSERT INTO Rok VALUES('JUNE1','Junski ispitni rok','SI0001','ETF001');
INSERT INTO Rok VALUES('SEPR1','Septembarski ispitni rok','CS0001','RAF003');
----Gotovo
INSERT INTO Vreme_Polaganja VALUES('SEP27/PS','2020/2021','27-SEP-2020 12:00:00','SEPE1');
INSERT INTO Vreme_Polaganja VALUES('SEP30/US','2020/2021','30-SEP-2020 11:00:00','SEPE2');
INSERT INTO Vreme_Polaganja VALUES('DEC20/PS','2021/2022','20-DEC-2021 11:30:00','DECE1');
INSERT INTO Vreme_Polaganja VALUES('JUN27/PR','2020/2021','27-JUN-2021 12:00:00','JUNE1');
INSERT INTO Vreme_Polaganja VALUES('SEP27/US','2020/2021','27-SEP-2020 11:00:00','SEPR1');
----Gotovo
INSERT INTO Predmet VALUES(1,'Matematika I',108,1);
INSERT INTO Predmet VALUES(2,'Fizika II',108,2);
INSERT INTO Predmet VALUES(3,'Matematika II',54,2);
INSERT INTO Predmet VALUES(4,'Osnove Elektrotehnike I',88,2);
INSERT INTO Predmet VALUES(5,'Osnove Elektronike',54,2);
INSERT INTO Predmet VALUES(6,'Baze Podataka',54,3);
----Gotovo
INSERT INTO Plan_Ispita VALUES(1,'SEPE1','21-SEP-2020 11:00:00','SALA-11',1);
INSERT INTO Plan_Ispita VALUES(2,'SEPE1','22-SEP-2020 12:00:00','SALA-15',2);
INSERT INTO Plan_Ispita VALUES(3,'SEPE1','23-SEP-2020 12:00:00','LABARATORIJA-11a',3);
INSERT INTO Plan_Ispita VALUES(4,'SEPE1','24-SEP-2020 11:00:00','SALA-12',4);
INSERT INTO Plan_Ispita VALUES(5,'SEPE1','25-SEP-2020 12:00:00','SALA-RC1',5);
----Gotovo
INSERT INTO Predavač VALUES('KTBPJB','Jasna','Bošković','061/6660666','etf.baze.podataka@edu.etf.rs','0101986885001','Doktor Računarskih Nauka',6,NULL,NULL,null);
INSERT INTO Predavač VALUES('KTMTMJ','Marina','Jelenković','061/9990999','etf.matematika@edu.etf.rs','0202986885001','Doktor Matematike',1,null,null,null);
INSERT INTO Predavač VALUES('KTFZJM','Jelena','Marković','061/8880888','etf.fizika@edu.etf.rs','0303986885001','Doktor Teoretske Fizike',2,null,null,null);
INSERT INTO Predavač VALUES('KTETMP','Marijana','Peregi','061/7770777','etf.oe@edu.etf.rs','0404986885001','Master Elektroinženjerstva',4,null,null,null);
INSERT INTO Predavač VALUES('KTELNM','Nemanja','Marjanović','061/4440444','etf.oet@edu.etf.rs','0505986885001','Master Elektroinženjerstva',5,null,null,null);
----Gotovo
INSERT INTO Komisija VALUES('KOM001S','01-JAN-1999',null,null);
INSERT INTO Komisija VALUES('KOM002S','25-FEB-2005',null,null);
INSERT INTO Komisija VALUES('KOM003S','12-MAR-2001',null,null);
INSERT INTO Komisija VALUES('KOM004S','03-JAN-2000','04-MAR-2002',45);
INSERT INTO Komisija VALUES('KOM005S','09-SEP-1999','09-SEP-2020',250);
----Gotovo
INSERT INTO Članovi_Komisije VALUES('KOM001S','KTBPJB','01-JAN-1999');
INSERT INTO Članovi_Komisije VALUES('KOM001S','KTMTMJ','02-FEB-1999');
INSERT INTO Članovi_Komisije VALUES('KOM001S','KTELNM','04-JUN-1999');
INSERT INTO Članovi_Komisije VALUES('KOM002S','KTBPJB','15-JAN-2018');
INSERT INTO Članovi_Komisije VALUES('KOM002S','KTETMP','25-FEB-2005');
INSERT INTO Članovi_Komisije VALUES('KOM002S','KTFZJM','01-MAR-2005');
INSERT INTO Članovi_Komisije VALUES('KOM003S','KTETMP','12-MAR-2001');
INSERT INTO Članovi_Komisije VALUES('KOM004S','KTBPJB','03-JAN-2000');
INSERT INTO Članovi_Komisije VALUES('KOM005S','KTETMP','09-SEP-1999');
INSERT INTO Članovi_Komisije VALUES('KOM005S','KTFZJM','01-JAN-2005');
----Gotovo
INSERT INTO Tip_Ispita VALUES('US255',3,100,0);
INSERT INTO Tip_Ispita VALUES('PS214',4,0,100);
INSERT INTO Tip_Ispita VALUES('LAB422',4,20,80);
INSERT INTO Tip_Ispita VALUES('KOM125',3,50,50);
INSERT INTO Tip_Ispita VALUES('US112',5,100,0);
----Gotovo
INSERT INTO Ispit VALUES('IS0012',1,1,'SEP27/PS','US255','KOM001S');
INSERT INTO Ispit VALUES('IS0013',2,1,'SEP27/PS','PS214','KOM001S');
INSERT INTO Ispit VALUES('IS0014',4,1,'SEP30/US','LAB422','KOM002S');
INSERT INTO Ispit VALUES('IS0016',3,1,'JUN27/PR','US255','KOM002S');
INSERT INTO Ispit VALUES('IS0015',5,1,'DEC20/PS','US255','KOM002S');
----Gotovo
INSERT INTO Lista_Studenata_Na_Ispitu VALUES('IS0012',1,2022001,1,10);
INSERT INTO Lista_Studenata_Na_Ispitu VALUES('IS0013',2,2022001,1,9);
INSERT INTO Lista_Studenata_Na_Ispitu VALUES('IS0013',2,2022002,1,8);
INSERT INTO Lista_Studenata_Na_Ispitu VALUES('IS0015',5,2022002,0,NULL);
INSERT INTO Lista_Studenata_Na_Ispitu VALUES('IS0015',5,2022003,0,8);
----Gotovo
INSERT INTO Žiro_Račun VALUES('155-00125455-11','ETF001',25000);
INSERT INTO Žiro_Račun VALUES('156-55451200-11','FTN002',20000);
INSERT INTO Žiro_Račun VALUES('157-22125455-11','RAF003',30000);
INSERT INTO Žiro_Račun VALUES('158-11125455-11','FON004',25000);
INSERT INTO Žiro_Račun VALUES('159-10125455-11','MAT005',10000);
----Gotovo
INSERT INTO Čas VALUES('MIFS12','Teorija',null,1,'Usmeno predavanje');
INSERT INTO Čas VALUES('MIFS13','Vezbe',null,1,'Primena znanja u praksi');
INSERT INTO Čas VALUES('MIFS14','Teorija',null,1,'Usmeno predavanje');
INSERT INTO Čas VALUES('FIFS12','Teorija',null,2,'Usmeno predavanje');
INSERT INTO Čas VALUES('OEFS12','Teorija',null,4,'Usmeno predavanje');
----Gotovo->Proveri vezu
INSERT INTO Obaveza VALUES('OBCDS11','01-JAN-2020','20-JAN-2020',15,null,'MIFS12',2022001,1);
INSERT INTO Obaveza VALUES('OBCDS12','02-JAN-2020','30-MAR-2020',25,null,'MIFS13',2022001,1);
INSERT INTO Obaveza VALUES('OBCDS13','15-JAN-2020','25-JAN-2020',15,null,'MIFS14',2022001,1);
INSERT INTO Obaveza VALUES('OBCDS14','05-JAN-2020','05-SEP-2020',75,null,'FIFS12',2022001,0);
INSERT INTO Obaveza VALUES('OBCDS15','03-JAN-2020','20-FEB-2020',20,'Domaci zadatak','OEFS12',2022001,1);
INSERT INTO Obaveza VALUES('OBCDS16','01-JAN-2020','20-JAN-2020',15,null,'MIFS12',2022002,0);
INSERT INTO Obaveza VALUES('OBCDS17','05-JAN-2020','20-JAN-2020',20,'Projekat','FIFS12',2022002,0);
INSERT INTO Obaveza VALUES('OBCDS18','03-JAN-2020','20-JAN-2020',25,'Istrazivacki rad','OEFS12',2022002,1);
INSERT INTO Obaveza VALUES('OBCDS19','15-JAN-2020','20-JAN-2020',10,null,'MIFS14',2022002,1);
INSERT INTO Obaveza VALUES('OBCDS20','01-JAN-2020','20-JUN-2020',20,null,'MIFS12',2022003,1);
INSERT INTO Obaveza VALUES('OBCDS21','05-JAN-2020','21-JUL-2020',40,null,'FIFS12',2022003,0);
INSERT INTO Obaveza VALUES('OBCDS22','01-JAN-2020','20-MAR-2020',25,null,'MIFS12',2022004,1);
INSERT INTO Obaveza VALUES('OBCDS23','05-JAN-2020','20-JUL-2020',15,'Istrazivacki rad','FIFS12',2022004,0);
INSERT INTO Obaveza VALUES('OBCDS24','03-JAN-2020','20-JAN-2020',60,'Praktican rad','OEFS12',2022004,0);
----Gotovo
INSERT INTO Nivo_Studija VALUES('OAK4SI',4,'Diplomirani inzenjer ER','Osnovne akademske studije','SI0001','ETF001');
INSERT INTO Nivo_Studija VALUES('OAK4ER',4,'Diplomirani inzenjer ER','Osnovne akademske studije','ER0002','ETF001');
INSERT INTO Nivo_Studija VALUES('OSS3RD',3,'Diplomirani dizajner','Osnovne strukovne studije','RD0001','RAF003');
INSERT INTO Nivo_Studija VALUES('OAK4CS',4,'Diplomirani informaticar','Osnovne akademske studije','CS0001','RAF003');
INSERT INTO Nivo_Studija VALUES('OAK4CE',4,'Diplomirani inzenjer racunara','Osnovne akademske studije','CE0002','RAF003');
----Gotovo
INSERT INTO Uplata_Za_Ispit VALUES('01-JUL-2020',1500,'155-00125455-11',2022001,'ETF001');
INSERT INTO Uplata_Za_Ispit VALUES('20-JUL-2020',2500,'155-00125455-11',2022001,'ETF001');
INSERT INTO Uplata_Za_Ispit VALUES('15-JUL-2020',1000,'155-00125455-11',2022001,'ETF001');
----Gotovo
INSERT INTO Izvor VALUES('OSET1','Zbirka zadataka',null);
INSERT INTO Izvor VALUES('OSET2','Zbirka zadataka',null);
----Gotovo
INSERT INTO Pitanje VALUES('PITA777','Odredi struju I1 na sledecem kolu.','I1=0,27mA',5,'Jednosmerna struja','OSET1');
INSERT INTO Pitanje VALUES('PITA778','Odredi struju I2 na sledecem kolu.','I2=0,5mA',5,'Jednosmerna struja','OSET1');
INSERT INTO Pitanje VALUES('PITA779','Odredi struje I2,i na sledecem kolu.','I2=0,22mA,i=0,5j',5,'Naizmenicna struja','OSET2');
INSERT INTO Pitanje VALUES('PITA780','Odredi napone U1,U2 na sledecem kolu.','U1=0,75mV,U2=0,5V',5,'Jednosmeran napon','OSET1');
INSERT INTO Pitanje VALUES('PITA781','Odredi napone u1,u2 na sledecem kolu.','u1=(0,55j)V,u2=(1-0,2j)mV',5,'Naizmenicni napon','OSET2');
----Gotovo
INSERT INTO Lista_Pitanja_Za_Ispit VALUES('IS0012',1,'PITA777','OSET1','01-JAN-2018',1);
INSERT INTO Lista_Pitanja_Za_Ispit VALUES('IS0013',2,'PITA778','OSET1','01-JAN-2018',1);
INSERT INTO Lista_Pitanja_Za_Ispit VALUES('IS0014',4,'PITA779','OSET2','01-JAN-2018',1);
INSERT INTO Lista_Pitanja_Za_Ispit VALUES('IS0016',3,'PITA780','OSET1','01-JAN-2018',1);
INSERT INTO Lista_Pitanja_Za_Ispit VALUES('IS0015',5,'PITA781','OSET2','01-JAN-2018',1);


