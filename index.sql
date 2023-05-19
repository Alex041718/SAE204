DROP SCHEMA if exists parcoursup CASCADE;

CREATE SCHEMA parcoursup;
SET SCHEMA 'parcoursup';

CREATE TABLE _region 
(
  region_nom   VARCHAR(30),
  PRIMARY KEY (region_nom)
);

CREATE TABLE _departement 
(
  departement_code   VARCHAR(3) PRIMARY KEY,
  departement_nom    VARCHAR(23),
  -- CLÉ ÉTRANGÈRE 
  region_nom         VARCHAR(30),
  -- CONTRAINTES
  constraint departement_fk_region FOREIGN KEY (region_nom) REFERENCES _region(region_nom)
);

CREATE TABLE _commune 
(
  commune_nom         VARCHAR(30),
  -- CLÉ ÉTRANGÈRE 
  departement_code VARCHAR(3),
  -- DOUBLE CLÉ PRIMAIRE
  PRIMARY KEY (commune_nom,departement_code),
  -- CONTRAINTES
  CONSTRAINT commune_fk_departement FOREIGN KEY (departement_code) REFERENCES _departement (departement_code)
);

CREATE TABLE _academie 
(
  academie_nom   VARCHAR(21) PRIMARY KEY
);

CREATE TABLE _filiere 
(
  filiere_id                     INT PRIMARY KEY,
  filiere_libelle                VARCHAR(291) NOT NULL,
  filiere_libelle_tres_abrege    VARCHAR(18) NOT NULL,
  filiere_libelle_abrege         VARCHAR(68) NOT NULL,
  filiere_libelle_detaille_bis   VARCHAR(342) NOT NULL
);
CREATE TABLE _etablissement 
(
  etablissement_code_uai   VARCHAR(8) PRIMARY KEY,
  etablissement_nom        VARCHAR(136),
  etablissemet_statut      VARCHAR(33)
);

CREATE TABLE _mention_bac 
(
  libelle_mention   VARCHAR PRIMARY KEY
);

CREATE TABLE _regroupement 
(
  libelle_regroupement   VARCHAR PRIMARY KEY
);

CREATE TABLE _type_bac 
(
  type_bac   VARCHAR PRIMARY KEY
);

CREATE TABLE _session 
(
  session_annee   INT PRIMARY KEY
);

CREATE TABLE _formation 
(
  cod_aff_form                      VARCHAR PRIMARY KEY,
  filiere_libelle_detaille          VARCHAR NOT NULL,
  cooordonnees_gps                  VARCHAR NOT NULL,
  list_com                          VARCHAR NOT NULL,
  concours_communs_banque_epreuve   VARCHAR NOT NULL,
  url_formation                     VARCHAR NOT NULL,
  tri                               VARCHAR NOT NULL,
  -- CLÉ ÉTRANGÈRE 
  commune_nom                       VARCHAR(30),
  departement_code                  VARCHAR(3),
  etablissement_code_uai            VARCHAR(8),
  academie_nom                      VARCHAR(21),
  filiere_id                        INT,
  -- CONTRAINTES
  constraint formation_fk_commune FOREIGN KEY (commune_nom,departement_code) REFERENCES _commune(commune_nom,departement_code),
  CONSTRAINT formation_fk_etablissement FOREIGN KEY (etablissement_code_uai) REFERENCES _etablissement (etablissement_code_uai),
  CONSTRAINT formation_fk_academie FOREIGN KEY (academie_nom) REFERENCES _academie (academie_nom),
  CONSTRAINT formation_fk_filiere FOREIGN KEY (filiere_id) REFERENCES _filiere (filiere_id)
);

-- Table Association
CREATE TABLE _admissions_selon_type_neo_bac 
(
  effectif_candidat_neo_bac_classes   INT,
  -- CLÉ ÉTRANGÈRE 
  session_annee                       INT,
  cod_aff_form                        VARCHAR,
  type_bac   VARCHAR,
  primary key (type_bac,session_annee,cod_aff_form),
  -- CONTRAINTES
  CONSTRAINT _admissions_selon_type_neo_bac_fk_type_bac FOREIGN KEY (type_bac) REFERENCES _type_bac (type_bac),
  CONSTRAINT _admissions_selon_type_neo_bac_fk_session_annee FOREIGN KEY (session_annee) REFERENCES _session (session_annee),
  CONSTRAINT _admissions_selon_type_neo_bac_fk_formation FOREIGN KEY (cod_aff_form) REFERENCES _formation (cod_aff_form)
);

CREATE TABLE _admissions_generalites 
(
  selectivite                 VARCHAR,
  capacite                    INT,
  effectif_total_candidats    INT,
  effectif_total_candidates   INT,
  -- CLÉ ÉTRANGÈRE 
  session_annee               INT,
  cod_aff_form                VARCHAR,
  -- CONTRAINTES
  constraint _admissions_generalites_fk_session_annee FOREIGN KEY (session_annee) REFERENCES _session(session_annee),
  CONSTRAINT _admissions_generalites_fk_formation FOREIGN KEY (cod_aff_form) REFERENCES _formation (cod_aff_form)
);

CREATE TABLE _rang_dernier_appele_selon_regroupement 
(
  rang_dernier_appele                    INT,
  -- CLÉ ÉTRANGÈRE 
  libelle_regroupement                   VARCHAR,
  session_annee                          INT,
  cod_aff_form                           VARCHAR(30),
  -- CONTRAINTES
  constraint _rang_dernier_appele_selon_regroupement_fk_formation FOREIGN KEY (cod_aff_form) REFERENCES _formation(cod_aff_form),
  CONSTRAINT _rang_dernier_appele_selon_regroupement_fk_regroupement FOREIGN KEY (libelle_regroupement) REFERENCES _regroupement (libelle_regroupement),
  CONSTRAINT _rang_dernier_appele_selon_regroupement_fk_session_annee FOREIGN KEY (session_annee) REFERENCES _session (session_annee)
);

CREATE TABLE _effectif_selon_mention
(
  effectif_admis_neo_bac_selon_mention   INT,
  -- CLÉ ÉTRANGÈRE 
  cod_aff_form                           VARCHAR(30),
  session_annee                          INT,
  libelle_mention                        VARCHAR,
  -- CONTRAINTES
  CONSTRAINT _effectif_selon_mention_fk_session FOREIGN KEY (session_annee) REFERENCES _session (session_annee),
  CONSTRAINT _effectif_selon_mention_mention_bac FOREIGN KEY (libelle_mention) REFERENCES _mention_bac (libelle_mention)
);
