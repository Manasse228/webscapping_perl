#! /bin/bash

s1=$(date +%s)

perl bug12.pl


heure=$(date +%H':'%M)
date=$(date +%d'/'%m'/'%y)
minute='0'
s2=$(date +%s)
temps=$(($s2 - $s1))

while [ $temps -ge 60 ]
do
	minute=$(($minute + 1))
	temps=$(($temps - 60))
done

final=$minute':'$temps

mysql -D r2d4_muta2 -u root -pa48b59! -e "INSERT INTO console (Heure, Date, NomScript, Operation, Temps) VALUES('$heure', '$date', 'bug12.sh', '0', '$final')"

