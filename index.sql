
drop schema if exists parcoursup cascade;

create schema parcoursup;

set schema 'parcoursup';




CREATE TABLE _academie(
    Academie_nom VARCHAR PRIMARY KEY,
);

CREATE TABLE _filiere(
    filiere_id int PRIMARY KEY NOT NULL,
    filiere_libelle VARCHAR(200) NOT NULL,
    filiere_libelle_tres_abrege VARCHAR(50) NOT NULL,
    filiere_libelle_abrege VARCHAR(100) NOT NULL,
    filiere_libelle_detaille_bis VARCHAR(300) NOT NULL,
);

CREATE TABLE _etablissement(
    etablissement_code_uai VARCHAR(10),
    etablissement_nom VARCHAR(50),
    etablissemet_statut VARCHAR(50),
);

CREATE TABLE _formation(
    cod_aff_form varchar PRIMARY KEY,
    filiere_libelle_detaille varchar,
    cooordonnees_gps varchar,
    list_com varchar,
    concours_communs_banque_epreuve varchar,
    url_formation varchar,
    tri varchar,
);



create table _session(
    session_annee int primary key
);


create table _mention_bac(
    libelle_mention varchar primary key
);

create table _effectif_selon_mention(
    effectif_admis_neo_bac_selon_mention int

    
)





create Table _type_bac(
    type_bac varchar Primary key
);

create table _admissions_selon_type_neo_bac(
    effectif_candidat_neo_bac_classes int

    



)

create table _regroupement(
    libelle_regroupement varchar primary key
)

create table rang_dernier_appele_selon_regroupement(
    rang_dernier_appele int

    

)