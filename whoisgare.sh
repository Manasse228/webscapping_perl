#!/bin/bash

while read line
do
	whois $line >> ./garedetri/12csvwhois/$line.csv

	echo "2s attente pour ligne Suivante"
	sleep 2s

done < ./garedetri/source/csv.csv

exit



