drop table IF EXISTS import, Lieu, Formation, Etablissement, Données_admission, Donnees_candidature CASCADE;
\! echo "Telechargement des données"
\! sleep 3

\! wget -O Données.csv https://data.enseignementsup-recherche.gouv.fr/api/explore/v2.1/catalog/datasets/fr-esr-parcoursup/exports/csv?lang=fr&timezone=Europe%2FBerlin&use_labels=true&delimiter=%3B & wait

\! echo "Création de la table import qui contient toutes les colonnes du fichier csv avec leur types respectifs"
\! sleep 3

CREATE TABLE import(
 n1 int , n2 varchar(343) , n3 varchar(343) , n4 varchar(343) , n5 varchar(343) , n6 varchar(343) , n7 varchar(343) , n8 varchar(343) , n9 varchar(343) , n10 varchar(343) , n11 varchar(343) , n12 varchar(343) , n13 varchar(343) , n14 varchar(343) , n15 varchar(343) , n16 varchar(343) , n17 varchar(343) , n18 int , n19 int , n20 int , n21 int , n22 varchar(343) , n23 int , n24 int , n25 int , n26 int , n27 int , n28 int , n29 int , n30 int , n31 int , n32 int , n33 int , n34 int , n35 int , n36 int , n37 varchar(343) , n38 varchar(343) , n39 int , n40 int , n41 int , n42 int , n43 int , n44 int , n45 int , n46 int , n47 int , n48 int , n49 int , n50 int , n51 FLOAT , n52 FLOAT , n53 FLOAT , n54 varchar(343) , n55 int , n56 int , n57 int , n58 int , n59 int , n60 int , n61 int , n62 int , n63 int , n64 int , n65 int , n66 FLOAT , n67 int , n68 int , n69 int , n70 varchar(343) , n71 varchar(343) , n72 int , n73 int , n74 FLOAT , n75 FLOAT , n76 FLOAT , n77 FLOAT , n78 FLOAT , n79 FLOAT , n80 FLOAT , n81 FLOAT , n82 FLOAT , n83 FLOAT , n84 FLOAT , n85 FLOAT , n86 FLOAT , n87 FLOAT , n88 FLOAT , n89 FLOAT , n90 FLOAT , n91 FLOAT , n92 FLOAT , n93 FLOAT , n94 FLOAT , n95 FLOAT , n96 FLOAT , n97 FLOAT , n98 FLOAT , n99 FLOAT , n100 FLOAT , n101 FLOAT , n102 varchar(343) , n103 varchar(343) , n104 varchar(343) , n105 varchar(343) , n106 varchar(343) , n107 varchar(343) , n108 varchar(343) , n109 varchar(343) , n110 varchar(343) , n111 varchar(343) , n112 varchar(343) , n113 varchar(343) , n114 varchar(343) , n115 varchar(343) , n116 varchar(343) , n117 varchar(343) , n118 varchar(343) 
);

\copy import from Données.csv delimiter ';' csv header;

\! echo "Creation des 5 tables du MCD"
\! sleep 3

create table Etablissement(
    eno serial PRIMARY KEY, Code_UAI VARCHAR(100) , Nom varchar(500), Academie varchar(100), Statut varchar (100), Coordonnees_GPS varchar(500)
);

create table Formation(
    Code_aff_form VARCHAR(100) PRIMARY KEY, Selectivite varchar(100), typeF varchar(250), Filiere varchar(350), Domaine varchar(350), Filiere_tres_detaillee varchar(350), eno int,  FOREIGN KEY (eno) REFERENCES Etablissement(eno) ON DELETE CASCADE
);

create table Lieu(
    lno serial PRIMARY KEY, num_departement VARCHAR(100), nom_region varchar(300), nom_departement varchar(300), commune varchar(300), eno int,  Code_UAI VARCHAR(200), FOREIGN KEY (eno) REFERENCES Etablissement(eno) ON DELETE CASCADE 
);


CREATE TABLE Données_admission(
    Ano serial PRIMARY KEY, Candidates_admises INT, Admis_phase_principal int, Admis_phase_complementaire int, Admis_procédure_princ int, Admis_avant_bac int, Admis_avant_fin_procedure_princ int, Admis_boursiers_neo_bac int, Admis_neo_bac_gen int, Admis_neo_bac_techno int, Admis_neo_bac_pro int, Admis_autres int, Total_accept_prop int
);

Create TABLE Donnees_candidature(
    Cno serial PRIMARY KEY, Candidates int, Candidats_boursier_gen int, Candidats_gen_par_etablissement int, Candidats_tech_par_etablissement int, Candidats_pro_par_etablissement int, Autre_candidats_par_etablissement int, Candidats_boursier_gen_par_etablissement int, 
    Candidats_boursier_tech_par_etablissement int, Candidats_boursier_pro_par_etablissement int, Autres_candidats INT
);

\! echo "Import des données de la tables import dans les 5 tables ventilés :"
\! sleep 3

INSERT INTO Etablissement (Code_UAI, nom, Academie, Statut, Coordonnees_GPS) SELECT DISTINCT n3, n4, n8, n2, n17 FROM import group by n3, n4, n8, n2, n17;

Insert into Formation (Code_aff_form, Selectivite, typeF, Filiere, Domaine, Filiere_tres_detaillee) Select distinct(n110), n11, n12, n14, n15, n16 from import;

Insert into Lieu (num_departement, nom_region, nom_departement, commune, Code_UAI) Select distinct(n5), n7, n6, n9, n110 from import;

ALTER TABLE Formation ADD cno INT;
ALTER TABLE Formation ADD FOREIGN KEY (cno) REFERENCES Donnees_candidature(cno) ON DELETE CASCADE;
ALTER TABLE Formation ADD ano INT;
ALTER TABLE Formation ADD FOREIGN KEY (ano) REFERENCES Données_admission(ano) ON DELETE CASCADE;

INSERT INTO Données_admission (Candidates_admises, Admis_phase_principal, Admis_phase_complementaire, Admis_procédure_princ, Admis_avant_bac, Admis_avant_fin_procedure_princ, Admis_boursiers_neo_bac, Admis_neo_bac_gen, Admis_neo_bac_techno, Admis_neo_bac_pro, Admis_autres, Total_accept_prop) SELECT n48, n49, n50, n51, n52, n53, n55, n57, n58, n59, n60, n47 FROM import;

INSERT INTO Donnees_candidature (Candidates, Candidats_boursier_gen, Candidats_gen_par_etablissement, Candidats_tech_par_etablissement, Candidats_pro_par_etablissement, 
Candidats_boursier_gen_par_etablissement, Candidats_boursier_tech_par_etablissement, Candidats_boursier_pro_par_etablissement, Autres_candidats) SELECT n20, n23, n39, n41, n43, n45, n40, n42, n44 from import;

\! echo "Reponses au questions de l'exercices 2 :"
\! sleep 3

\! echo '1) Taille en octet du fichier récupéré :'
\! wc -c Données.csv
\! sleep 3

\! echo '2) Taille en octet de la table import :'
select pg_total_relation_size('import');
\! sleep 3

\! echo '3) Taille en octet de la somme des tables créées :'

\! sleep 3

select pg_total_relation_size('Etablissement')+pg_total_relation_size('Formation')+pg_total_relation_size('Lieu')+pg_total_relation_size('Données_admission')+pg_total_relation_size('Donnees_candidature')as taille_somme_table;

\! echo '4) Exportation des tables ventilées dans le dossier "tables_exportée" :'
\! sleep 3

\copy Données_admission to 'tables_exportée/Données_admission.csv';
\copy Donnees_candidature to 'tables_exportée/Donnees_candidature.csv';
\copy Lieu to 'tables_exportée/Lieu.csv';
\copy Etablissement to 'tables_exportée/Etablissement.csv';
\copy Formation to 'tables_exportée/Formation.csv';

\! echo 'reponse à la question 4 :'
\! sleep 3

\! wc -c tables_exportée/Lieu.csv -c tables_exportée/Formation.csv -c tables_exportée/Donnees_candidature.csv -c tables_exportée/Données_admission.csv -c tables_exportée/Etablissement.csv

\! echo "Suppression du fichier Données.csv"
\! rm Données.csv