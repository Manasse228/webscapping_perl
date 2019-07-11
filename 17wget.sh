#!/bin/bash



i=0; while read line;

 do 


i=$((i+1));

echo 'wget'' -t1  --timeout=8 -P ./garedetri/17wget/'$line' http://www.'$line >> ./wget18.sh;


 done < ./garedetri/16extract/extract.csv;


#ajout de 2 lignes en debut de fichiers
sed -i 1i'\\' ./wget18.sh;
sed -i 1i'\#!/bin/bash\' ./wget18.sh;

echo "Script wget18.sh fabriqué!";

bash wget18.sh;

echo "Fichiers wgets sont dans dossier 17wget!";

exit;
