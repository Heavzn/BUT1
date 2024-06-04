#  README - Projet Réseaux

Développé par: \<Mathis Magnier> \<Milan Theron> \<Aymane Benfaquir>\
Contacts : <mathis.magnier.etu@univ-lille.fr> , <milan.theron.etu@univ-lille.fr>, <aymane.benfaquir.etu@univ-lille.fr>


# Comment obtenir les fichiers html, pdf et markdown avec pandoc


Pour obtenir les rapports en html et pdf, ouvrez un terminal dans le dossier contenant le rapport en markdown puis exécutez simplement les commande ci-dessous : 

(vous pouvez copier la commande avec ctrl + c et la coller dans le terminal avec ctrl + shift + v )


Pour obtenir le fichier en pdf: pandoc -f markdown -t pdf -N -s Rapport.md metadata.yaml -o Rapport.pdf  --toc -V geometry:margin=1in
Pour obtenir le fichier en html: pandoc -f markdown -t html -N -s Rapport.md metadata.yaml --css Style.css -o Rapport.html  --toc 
