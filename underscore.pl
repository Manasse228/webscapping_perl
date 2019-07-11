#!/usr/bin/perl -w
use strict;

	#Recuperation des fichiers d'extention .csv
my @tablodefichiers = <beta/source/*.csv>;


	#Parcours du tableau contant les fichiers
  foreach my $nomfichier (@tablodefichiers) {

	#Verification du contenu du fichier
if (-z $nomfichier){
#print "Le fichier ${nomfichier} est vide\n";
}else{
	#Si le fichier nest pas vide
	#Tentative d'ouverture du fichier
if (open(FICUNDERSCORE, "<$nomfichier")){
	
	#Recuperation de toutes les lignes du fichier en mode lecture
my @lignes = <FICUNDERSCORE>;
close(FICUNDERSCORE);


	#Reouverture du fichier en mode ecriture
open( my $fichierouvert, ">", $nomfichier)
or die ("Impossible d'écrire dans le fichier ${nomfichier} : $!\n");
 
foreach my $ligne (@lignes) {

	#recherche de l'underscore
 print {$fichierouvert} $ligne unless ( $ligne =~ /_/ ); 
}

	#Fermeture du fichier
close(FICUNDERSCORE);
}else{
	#Ouverture impossible du fichier
die("Ouverture impossible du fichier: $!\n");
}


}
}



