-- Generated by Oracle SQL Developer Data Modeler 20.3.0.283.0710
--   at:        2021-05-07 13:53:28 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



DROP TABLE čas CASCADE CONSTRAINTS;

DROP TABLE članovi_komisije CASCADE CONSTRAINTS;

DROP TABLE fakultet CASCADE CONSTRAINTS;

DROP TABLE ispit CASCADE CONSTRAINTS;

DROP TABLE izvor CASCADE CONSTRAINTS;

DROP TABLE komisija CASCADE CONSTRAINTS;

DROP TABLE lista_pitanja_za_ispit CASCADE CONSTRAINTS;

DROP TABLE lista_studenata_na_ispitu CASCADE CONSTRAINTS;

DROP TABLE nivo_studija CASCADE CONSTRAINTS;

DROP TABLE obaveza CASCADE CONSTRAINTS;

DROP TABLE pitanje CASCADE CONSTRAINTS;

DROP TABLE plan_ispita CASCADE CONSTRAINTS;

DROP TABLE predavač CASCADE CONSTRAINTS;

DROP TABLE predmet CASCADE CONSTRAINTS;

DROP TABLE rok CASCADE CONSTRAINTS;

DROP TABLE smer CASCADE CONSTRAINTS;

DROP TABLE student CASCADE CONSTRAINTS;

DROP TABLE tip_ispita CASCADE CONSTRAINTS;

DROP TABLE uplata_za_ispit CASCADE CONSTRAINTS;

DROP TABLE vreme_polaganja CASCADE CONSTRAINTS;

DROP TABLE žiro_račun CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE čas (
    čas_id             VARCHAR2(6) NOT NULL,
    tip_časa           VARCHAR2(10) NOT NULL,
    opis_nastave       VARCHAR2(50),
    predmet_predmetid  INTEGER NOT NULL,
    način_izvršavanja  VARCHAR2(20) NOT NULL
);

ALTER TABLE čas ADD CONSTRAINT čas_pk PRIMARY KEY ( čas_id );

CREATE TABLE članovi_komisije (
    datum_pristupanja     DATE NOT NULL,
    predavač_predavačid   VARCHAR2(6) NOT NULL,
    komisija_komisija_id  VARCHAR2(15) NOT NULL
);

ALTER TABLE članovi_komisije ADD CONSTRAINT članovi_komisije_pk PRIMARY KEY ( predavač_predavačid,
                                                                              komisija_komisija_id );

CREATE TABLE fakultet (
    fakultetid     VARCHAR2(6) NOT NULL,
    naziv          VARCHAR2(50) NOT NULL,
    žiro_račun     VARCHAR2(30) NOT NULL,
    adresa         VARCHAR2(30) NOT NULL,
    kontakt        VARCHAR2(20) NOT NULL,
    link_ka_sajtu  VARCHAR2(30)
);

ALTER TABLE fakultet ADD CONSTRAINT fakultet_pk PRIMARY KEY ( fakultetid );

CREATE TABLE ispit (
    ispitid                            VARCHAR2(10) NOT NULL,
    ocena                              INTEGER NOT NULL,
    overen_semestar                    CHAR(1) NOT NULL,
    predmet_predmetid                  INTEGER NOT NULL, 
    v_p_vreme_pid  VARCHAR2(8) NOT NULL,
    tip_ispita_tip_ispita_id           VARCHAR2(10) NOT NULL,
    komisija_komisija_id               VARCHAR2(15) NOT NULL
);

ALTER TABLE ispit ADD CONSTRAINT ispit_pk PRIMARY KEY ( ispitid,
                                                        predmet_predmetid );

CREATE TABLE izvor (
    izvor_id             VARCHAR2(15) NOT NULL,
    tip_izvora           VARCHAR2(10) NOT NULL,
    referenca_ka_izvoru  VARCHAR2(15)
);

ALTER TABLE izvor ADD CONSTRAINT izvor_pk PRIMARY KEY ( izvor_id );

CREATE TABLE komisija (
    komisija_id              VARCHAR2(15) NOT NULL,
    datum_stvaranja          DATE NOT NULL,
    datum_raspuštanja        DATE,
    broj_nadgledanih_ispita  INTEGER NOT NULL
);

ALTER TABLE komisija ADD CONSTRAINT komisija_pk PRIMARY KEY ( komisija_id );

CREATE TABLE lista_pitanja_za_ispit (
    datum_kreiranja          DATE NOT NULL,
    broj_pitanja             INTEGER NOT NULL,
    ispit_ispitid            VARCHAR2(10) NOT NULL,
    ispit_predmet_predmetid  INTEGER NOT NULL,
    pitanje_pitanje_id       VARCHAR2(7) NOT NULL,
    pitanje_izvor_id         VARCHAR2(15) NOT NULL
);

ALTER TABLE lista_pitanja_za_ispit
    ADD CONSTRAINT lista_pitanja_za_ispit_pk PRIMARY KEY ( ispit_ispitid,
                                                           ispit_predmet_predmetid,
                                                           pitanje_pitanje_id,
                                                           pitanje_izvor_id );

CREATE TABLE lista_studenata_na_ispitu (
    uplatio                  CHAR(1) NOT NULL,
    ispit_ispitid            VARCHAR2(10) NOT NULL,
    student_studentid        INTEGER NOT NULL,
    ispit_predmet_predmetid  INTEGER NOT NULL
);

ALTER TABLE lista_studenata_na_ispitu
    ADD CONSTRAINT lista_studenata_na_ispitu_pk PRIMARY KEY ( ispit_ispitid,
                                                              ispit_predmet_predmetid,
                                                              student_studentid );

CREATE TABLE nivo_studija (
    nivo_studija_id           VARCHAR2(10) NOT NULL,
    godina_trajanja           INTEGER NOT NULL,
    zvanje_po_zavšetku        VARCHAR2(20) NOT NULL,
    naziv                     VARCHAR2(20) NOT NULL,
    smer_smerid               VARCHAR2(6) NOT NULL,
    smer_fakultet_fakultetid  VARCHAR2(6) NOT NULL
);

ALTER TABLE nivo_studija ADD CONSTRAINT nivo_studija_pk PRIMARY KEY ( nivo_studija_id );

CREATE TABLE obaveza (
    obaveza_id         VARCHAR2(10) NOT NULL,
    rok_završetka      DATE NOT NULL,
    datum_zadavanja    DATE NOT NULL,
    broj_bodova        INTEGER NOT NULL,
    opis_obaveze       VARCHAR2(50) NOT NULL,
    čas_čas_id         VARCHAR2(6) NOT NULL,
    student_studentid  INTEGER NOT NULL
);

ALTER TABLE obaveza
    ADD CONSTRAINT obaveza_pk PRIMARY KEY ( obaveza_id,
                                            čas_čas_id,
                                            student_studentid );

CREATE TABLE pitanje (
    pitanje_id        VARCHAR2(7) NOT NULL,
    tekst_pitanja     VARCHAR2(250) NOT NULL,
    rešenje           VARCHAR2(250) NOT NULL,
    bodovna_vrednost  INTEGER NOT NULL,
    lekcija           VARCHAR2(20) NOT NULL,
    izvor_izvor_id    VARCHAR2(15) NOT NULL
);

ALTER TABLE pitanje ADD CONSTRAINT pitanje_pk PRIMARY KEY ( pitanje_id,
                                                            izvor_izvor_id );

CREATE TABLE plan_ispita (
    rednibr            INTEGER NOT NULL,
    datum_polaganja    DATE NOT NULL,
    mesto_polaganja    VARCHAR2(15) NOT NULL,
    predmet_predmetid  INTEGER NOT NULL
);

ALTER TABLE plan_ispita ADD CONSTRAINT plan_ispita_pk PRIMARY KEY ( rednibr );

CREATE TABLE predavač (
    predavačid           VARCHAR2(6) NOT NULL,
    ime                  VARCHAR2(30) NOT NULL,
    prezime              VARCHAR2(30) NOT NULL,
    telefon              VARCHAR2(15) NOT NULL,
    "E-mail"             VARCHAR2(20) NOT NULL,
    jmbg                 VARCHAR2(13) NOT NULL,
    akademsko_zvanje     VARCHAR2(10) NOT NULL,
    izborno_zvanje       VARCHAR2(10),
    predmet_predmetid    INTEGER NOT NULL,
    plan_ispita_rednibr  INTEGER
);

ALTER TABLE predavač ADD CONSTRAINT predavač_pk PRIMARY KEY ( predavačid );

CREATE TABLE predmet (
    predmetid    INTEGER NOT NULL,
    naziv        VARCHAR2(20) NOT NULL,
    broj_časova  INTEGER NOT NULL,
    semestar     INTEGER NOT NULL
);

ALTER TABLE predmet ADD CONSTRAINT predmet_pk PRIMARY KEY ( predmetid );

CREATE TABLE rok (
    rokid                     VARCHAR2(5) NOT NULL,
    naziv                     VARCHAR2(30) NOT NULL,
    smer_smerid               VARCHAR2(6) NOT NULL,
    smer_fakultet_fakultetid  VARCHAR2(6) NOT NULL
);

ALTER TABLE rok ADD CONSTRAINT rok_pk PRIMARY KEY ( rokid );

CREATE TABLE smer (
    smerid                     VARCHAR2(6) NOT NULL,
    naziv                      VARCHAR2(30) NOT NULL,
    maksimalan_broj_studenata  INTEGER NOT NULL,
    fakultet_fakultetid        VARCHAR2(6) NOT NULL
);

ALTER TABLE smer ADD CONSTRAINT smer_pk PRIMARY KEY ( smerid,
                                                      fakultet_fakultetid );

CREATE TABLE student (
    studentid                 INTEGER NOT NULL,
    broj_indeksa              VARCHAR2(10) NOT NULL,
    ime                       VARCHAR2(30) NOT NULL,
    prezime                   VARCHAR2(30) NOT NULL,
    jmbg                      VARCHAR2(13) NOT NULL,
    smer_smerid               VARCHAR2(6) NOT NULL,
    smer_fakultet_fakultetid  VARCHAR2(6) NOT NULL
);

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( studentid );

CREATE TABLE tip_ispita (
    tip_ispita_id                  VARCHAR2(10) NOT NULL,
    broj_espb_bodova_po_položenom  INTEGER NOT NULL,
    broj_bodova_usmeno             INTEGER NOT NULL,
    broj_bodova_pismeno            INTEGER NOT NULL
);

ALTER TABLE tip_ispita ADD CONSTRAINT tip_ispita_pk PRIMARY KEY ( tip_ispita_id );

CREATE TABLE uplata_za_ispit (
    datum_i_vreme          DATE NOT NULL,
    iznos                  INTEGER NOT NULL,
    žiro_račun_žr_id       VARCHAR2(30) NOT NULL,
    student_studentid      INTEGER NOT NULL,
    žiro_račun_fakultetid  VARCHAR2(6) NOT NULL
);

ALTER TABLE uplata_za_ispit
    ADD CONSTRAINT uplata_za_ispit_pk PRIMARY KEY ( datum_i_vreme,
                                                    žiro_račun_žr_id,
                                                    žiro_račun_fakultetid,
                                                    student_studentid );

CREATE TABLE vreme_polaganja (
    vreme_polaganjaid  VARCHAR2(8) NOT NULL,
    školska_godina     VARCHAR2(9) NOT NULL,
    datum_polaganja    DATE NOT NULL,
    rok_rokid          VARCHAR2(5) NOT NULL
);

ALTER TABLE vreme_polaganja ADD CONSTRAINT vreme_polaganja_pk PRIMARY KEY ( vreme_polaganjaid );

CREATE TABLE žiro_račun (
    žr_id                VARCHAR2(30) NOT NULL,
    stanje               INTEGER NOT NULL,
    fakultet_fakultetid  VARCHAR2(6) NOT NULL
);

ALTER TABLE žiro_račun ADD CONSTRAINT žiro_račun_pk PRIMARY KEY ( žr_id,
                                                                  fakultet_fakultetid );

ALTER TABLE čas
    ADD CONSTRAINT čas_predmet_fk FOREIGN KEY ( predmet_predmetid )
        REFERENCES predmet ( predmetid );

ALTER TABLE članovi_komisije
    ADD CONSTRAINT članovi_komisije_komisija_fk FOREIGN KEY ( komisija_komisija_id )
        REFERENCES komisija ( komisija_id );

ALTER TABLE članovi_komisije
    ADD CONSTRAINT članovi_komisije_predavač_fk FOREIGN KEY ( predavač_predavačid )
        REFERENCES predavač ( predavačid );

ALTER TABLE ispit
    ADD CONSTRAINT ispit_komisija_fk FOREIGN KEY ( komisija_komisija_id )
        REFERENCES komisija ( komisija_id );

ALTER TABLE ispit
    ADD CONSTRAINT ispit_predmet_fk FOREIGN KEY ( predmet_predmetid )
        REFERENCES predmet ( predmetid );

ALTER TABLE ispit
    ADD CONSTRAINT ispit_tip_ispita_fk FOREIGN KEY ( tip_ispita_tip_ispita_id )
        REFERENCES tip_ispita ( tip_ispita_id );

ALTER TABLE ispit
    ADD CONSTRAINT ispit_vreme_polaganja_fk FOREIGN KEY ( v_p_vreme_pid )
        REFERENCES vreme_polaganja ( vreme_polaganjaid );
 
ALTER TABLE lista_pitanja_za_ispit
    ADD CONSTRAINT lista_p_za_i_ispit_fk FOREIGN KEY ( ispit_ispitid,
                                                                 ispit_predmet_predmetid )
        REFERENCES ispit ( ispitid,
                           predmet_predmetid );

ALTER TABLE lista_pitanja_za_ispit
    ADD CONSTRAINT lista_p_za_i_pitanje_fk FOREIGN KEY ( pitanje_pitanje_id,
                                                                   pitanje_izvor_id )
        REFERENCES pitanje ( pitanje_id,
                             izvor_izvor_id );

ALTER TABLE lista_studenata_na_ispitu
    ADD CONSTRAINT lista_s_na_i_ispit_fk FOREIGN KEY ( ispit_ispitid,
                                                                    ispit_predmet_predmetid )
        REFERENCES ispit ( ispitid,
                           predmet_predmetid );

ALTER TABLE lista_studenata_na_ispitu
    ADD CONSTRAINT lista_s_na_i_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

ALTER TABLE nivo_studija
    ADD CONSTRAINT nivo_studija_smer_fk FOREIGN KEY ( smer_smerid,
                                                      smer_fakultet_fakultetid )
        REFERENCES smer ( smerid,
                          fakultet_fakultetid );

ALTER TABLE obaveza
    ADD CONSTRAINT obaveza_čas_fk FOREIGN KEY ( čas_čas_id )
        REFERENCES čas ( čas_id );

ALTER TABLE obaveza
    ADD CONSTRAINT obaveza_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

ALTER TABLE pitanje
    ADD CONSTRAINT pitanje_izvor_fk FOREIGN KEY ( izvor_izvor_id )
        REFERENCES izvor ( izvor_id );

ALTER TABLE plan_ispita
    ADD CONSTRAINT plan_ispita_predmet_fk FOREIGN KEY ( predmet_predmetid )
        REFERENCES predmet ( predmetid );

ALTER TABLE predavač
    ADD CONSTRAINT predavač_plan_ispita_fk FOREIGN KEY ( plan_ispita_rednibr )
        REFERENCES plan_ispita ( rednibr );

ALTER TABLE predavač
    ADD CONSTRAINT predavač_predmet_fk FOREIGN KEY ( predmet_predmetid )
        REFERENCES predmet ( predmetid );

ALTER TABLE rok
    ADD CONSTRAINT rok_smer_fk FOREIGN KEY ( smer_smerid,
                                             smer_fakultet_fakultetid )
        REFERENCES smer ( smerid,
                          fakultet_fakultetid );

ALTER TABLE smer
    ADD CONSTRAINT smer_fakultet_fk FOREIGN KEY ( fakultet_fakultetid )
        REFERENCES fakultet ( fakultetid );

ALTER TABLE student
    ADD CONSTRAINT student_smer_fk FOREIGN KEY ( smer_smerid,
                                                 smer_fakultet_fakultetid )
        REFERENCES smer ( smerid,
                          fakultet_fakultetid );

ALTER TABLE uplata_za_ispit
    ADD CONSTRAINT uplata_za_ispit_student_fk FOREIGN KEY ( student_studentid )
        REFERENCES student ( studentid );

ALTER TABLE uplata_za_ispit
    ADD CONSTRAINT uplata_za_ispit_žr_fk FOREIGN KEY ( žiro_račun_žr_id,
                                                               žiro_račun_fakultetid )
        REFERENCES žiro_račun ( žr_id,
                                fakultet_fakultetid );

ALTER TABLE vreme_polaganja
    ADD CONSTRAINT vreme_polaganja_rok_fk FOREIGN KEY ( rok_rokid )
        REFERENCES rok ( rokid );

ALTER TABLE žiro_račun
    ADD CONSTRAINT žiro_račun_fakultet_fk FOREIGN KEY ( fakultet_fakultetid )
        REFERENCES fakultet ( fakultetid );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            21
-- CREATE INDEX                             0
-- ALTER TABLE                             46
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   5 -- fixed
-- WARNINGS                                 0
