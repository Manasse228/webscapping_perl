#!/bin/bash

while read line
do
	whois $line >> ./garedetri/12csvwhois/$line.csv

	echo "16s attente pour ligne Suivante"
	sleep 16s

done < ./garedetri/source/01.csv

exit



