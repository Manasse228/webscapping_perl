#! /bin/bash



while read line; 
do   
    echo  $line
linkchecker www.$line -v -ocsv > ./link/sortie/$line.csv
   sleep=18s
   echo  'finished'
done < ./link/source/csv.csv







