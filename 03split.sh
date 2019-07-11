#!/bin/bash

s1=$(date +%s)

files=./garedetri/02source/csv.csv
var=$(du $files)
date=$(date +%m':'%d':'%h':'%M)

if [ "$var" > "25" ]
then
	tail -n +2 $files | split -l 2500 - split_
	for file in split_*
	do
		head -n 1 $files > tmp_file
   		cat $file >> tmp_file
		mv tmp_file $file
		mv $file ./garedetri/03split/$date\_$file

	done
	rm $files
	echo "Split terminé -- - - --------------YEAH"
else
	echo "Pas besoin de split"
fi



date=$(date +%d'/'%m'/'%y)
heure=$(date +%H':'%M)
minute='0'
s2=$(date +%s)
temps=$(($s2 - $s1))

while [ $temps -ge 60 ]
do
        minute=$(($minute + 1))
        temps=$(($temps - 60))
done

final=$minute':'$temps


mysql -D r2d4_muta2 -u root -pa48b59! -e "INSERT INTO console (Heure, Date, NomScript, Operation, Temps) VALUES('$heure', '$date', '03split.sh', '$k', '$final')"
