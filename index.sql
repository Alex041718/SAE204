CREATE DATABASE Parcoursup;


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