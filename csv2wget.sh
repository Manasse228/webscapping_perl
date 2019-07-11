#!/bin/bash

rm ./garedetri/05csv/*
rm wget.sh;


i=0; while read line;

 do 


i=$((i+1));

echo 'wget'' -t1  --timeout=8 -P ./garedetri/17wget/'$line' http://www.'$line >> ./wget.sh;


 done < ./garedetri/02source/csv.csv;

#ajout de 2 lignes en debut de fichiers
sed -i 1i'\\' ./wget.sh;
sed -i 1i'\#!/bin/bash\' ./wget.sh;

echo "yeahh !";


exit;
