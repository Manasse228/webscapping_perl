#!/bin/bash

rm garedetri/01brut/*

dir=./garedetri/01alpha/*

for files in $dir ;

do cat $files >> ./garedetri/01brut/tmp.csv ;

done


sort -u ./garedetri/01brut/tmp.csv > ./garedetri/01brut/csv.csv



rm garedetri/01alpha/*
rm garedetri/01brut/tmp.csv

echo "C'est fait !";

