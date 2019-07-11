#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Copy;


	#Recuperation des fichiers d'extention .csv
my @tablodefichiers = <garedetri/tri.com/*.csv>;

my compteur=0;
	#Parcours du tableau contant tous les fichiers
  foreach my $nomfichier (@tablodefichiers) {

if (-z $nomfichier){
print "Le fichier ${nomfichier} est vide\n";
	#Supression du ficher
	unlink $nomfichier;
}else{
	
	#Tentative d'ouverture du fichier
if (open(FICUNDERSCORE, "<$nomfichier")){
	
	#Recuperation de toutes les lignes du fichier en mode lecture
my @lignes = <FICUNDERSCORE>;
close(FICUNDERSCORE);

foreach my $ligne (@lignes) {
	if ( ($ligne =~ /Registrant Country: FR/) || ($ligne =~ /FR/) ) {
	$compteur++; 
}

}

if($compteur == 0){
	
	#Supression du ficher
	unlink $nomfichier;
}else{
	 #Deplacement des fichiers vers le dosser spécifiques
	move( $nomfichier, 'garedetri/tri.com.select/' ) 
	or die "Echec de la copie du fichier ${nomfichier}: $!";
}
$compteur=0;

	close(FICUNDERSCORE);
}else{
	#Ouverture impossible du fichier
die("Ouverture impossible du fichier: $!\n");
}

}	
}
