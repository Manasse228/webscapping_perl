#!/usr/bin/perl -w
use strict;
use File::Copy;
#use warnings;

	#Recuperation des fichiers d'extention .csv
my @tablodefichiers = <atrier/source/*.csv>;
my $i=0;


	#Parcours du tableau contant les fichiers
  foreach my $nomfichier (@tablodefichiers) {

	#Verification du contenu du fichier
if (-z $nomfichier){
#print "Le fichier ${nomfichier} est vide\n";
}else{
	#Si le fichier nest pas vide
#print "Le fichier ${nomfichier} n'est pas vide\n";

	#Tentative d'ouverture du fichier
if (open(FICHIER, "<$nomfichier")){
#print "le fichier ${tablodefichiers[0]} est ouvert Merci\n";

	#Recuperation de toutes les lignes du fichier
my @lignes = <FICHIER>;
foreach my $ligne (@lignes) {
chomp ($ligne);

	#recherche du mot en question
if( $ligne =~ /Registrant Country: FR/ ){
#print "le mot recherché est dans ce fichier $nomfichier\n";
$i=1;
last;
}else{
	$i=2;
}

}

if($i == 1){
	copy("$nomfichier",'atrier/sortie/')  or die "Echec de la copie vers le dossier sortie: $!";	
}else{
	copy("$nomfichier",'atrier/corbeille/')  or die "Echec de la copie vers le dossier corbeille: $!";
}
$i=0;
	#Fermeture du fichier
close(FICHIER);
}else{
	#Ouverture impossible du fichier
die("open: $!");
}


}
}



