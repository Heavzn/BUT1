--exo3 Q1
\! echo 'Voici le resultat de la requete exo3 Q1 \n' 
\! echo 'Requete qui afficher n56 et le recalcule à partir de n57,n58 et n59'
\! sleep 3

select n56,(n57+n58+n59) as calcul  
from import 
group BY n56,n57,n58,n59 
limit 10;



--exo3 Q2
\! echo 'Voici la verification du resultat de la requete exo3 Q1 (Q2)'
\! echo 'Qui est une soustraction de n56 par n57,n58 et n59 et qui affiche ce qui est different de 0 pour voir la difference '
\! sleep 3

select n56-(n57+n58+n59) as verification 
from import 
where n56-(n57+n58+n59) <> 0  
group by n56,n57,n58,n59
limit 10;

--exo3 Q3
\! echo 'Voici le resultat de la requete exo3 Q3 \n'
\! echo ' Requete qui affiche n74 et le recalcule à partir de n51 et n47'
\! sleep 3

select n74,round((n51*100)/n47) as calcul 
from import 
where n47 <> 0 
group by n74,n51,n47
limit 10;

--exo3 Q4
\! echo 'Voici la vérification de la requete exo3 Q3 (Q4) \n'
\! echo 'Qui est une soustraction de n74 par (n51*100)/n47 et qui affiche ce qui est different de 0 pour voir la difference '
\! sleep 3

select n74-round((n51*100)/n47) as calcul 
from import where n47<> 0 and (n74-round(((n51*100)/n47))) <>0 
group by n74,n51,n47
limit 10;

--exo3 Q5
\! echo 'Voici le resultat de la requete exo3 Q5 \n'
\! echo 'Requete qui affiche n76 et le recalcule à partir de n53 et n47 '
\! sleep 3

select n76,round((n53*100)/n47) as calcul 
from import 
where n47 <> 0 
group by n76,n53,n47
limit 10;

\! echo 'Verification de la Q5 :'
\! sleep 3

select n76,round((n53*100)/n47) as calcul 
from import 
where n47 <> 0 and n76-round(((n53*100)/n47)) <>0  
group by n76,n53,n47
limit 10;

--exo3 Q6
\! echo 'Voici le resultat de la requete exo3 Q6 : \n'
\! echo 'Requete qui affiche le taux en pourcent d"admis avant la fin de la procédure principale sur le total d"admis'
\! sleep 3

select round((Admis_avant_fin_procedure_princ*100)/Total_accept_prop) 
from Données_admission 
where Total_accept_prop <>0 
group by Admis_avant_fin_procedure_princ,Total_accept_prop
limit 10;

--exo3 Q7
\! echo 'Voici le resultat de la requete exo3 Q7 : \n'
\! echo 'Requete qui affiche n81 et la recalcule à partir de n55 et n56'
\! sleep 3

select n81, round(round(n55)/round(n56)*100) as calcul 
from import 
where n56 <> 0 
group by n81,n55,n56  
limit 10;

--exo3 Q8
\! echo "Voici le resultat de la requete exo3 Q8 : \n"
\! sleep 3

select round(round(Admis_boursiers_neo_bac)/round(Admis_neo_bac_techno+Admis_neo_bac_gen+Admis_neo_bac_pro)*100) as calcul 
from Données_admission 
where round(Admis_neo_bac_techno+Admis_neo_bac_gen+Admis_neo_bac_pro)<>0 
group by Admis_boursiers_neo_bac,Admis_neo_bac_gen,Admis_neo_bac_pro,Admis_neo_bac_techno 
limit 10 ;



\! echo "Voici les lignes pour le calcul de la question 7 pour lesquelles les tables ventilé et l'import n'on pas le meme resultat : \n"
\! sleep 3

select n81, round(round(Admis_boursiers_neo_bac)/round(Admis_neo_bac_techno+Admis_neo_bac_gen+Admis_neo_bac_pro)*100) as taux_boursier_neo_bachelier 
from Données_admission,import 
where Données_admission.Admis_boursiers_neo_bac=import.n55 
and  Données_admission.Admis_neo_bac_gen=import.n57 
and  Données_admission.Admis_neo_bac_pro=import.n59 
and  Données_admission.Admis_neo_bac_techno=import.n58 
and round(Admis_neo_bac_techno+Admis_neo_bac_gen+Admis_neo_bac_pro) <> 0 
and n81-round(round(Admis_boursiers_neo_bac)/round(Admis_neo_bac_techno+Admis_neo_bac_gen+Admis_neo_bac_pro)*100) <> 0 
limit 10;

\! echo "Fin de l'exercice 3 et du script"