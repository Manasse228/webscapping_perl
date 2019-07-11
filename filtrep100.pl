#!/usr/bin/perl -w

use File::Basename;


#  Calcul du % de lignes restantes après application du filtre

$file= "garedetri/01brut/csv.csv";
 
open(FILE, "<", $file)
 or die "Impossible d'ouvrir $file: $!";
$count01++ while <FILE>;

$file2= "garedetri/02source/csv.csv";
open(FILE, "<", $file2)
 or die "Impossible d'ouvrir $file2: $!";
$count02++ while <FILE>;



$count=($count02*100)/$count01;


print ("****************");
print "\n";
print ("***  ");print sprintf ("%0.1f", $count),(" %");print ("  ***");
print "\n";
print ("****************");
print "\n";






