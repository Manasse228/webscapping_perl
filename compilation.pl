#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Copy::Recursive qw (fcopy rcopy dircopy fmove rmove dirmove);
use HTML::TagParser;
use File::Path;




		#Recuperation de tous les repertoires du dossier
my @tabloderepertoire= <garedetri/08titles/09ftitle/*>;
		#Création du fichier contenant la liste des titles
open my $nouveaufichier, '>', 'garedetri/08titles/09ftitle/csv.csv';

		#Parcours du tableau contant tous les repertoires
  foreach my $nomrepertoire (@tabloderepertoire) {
	  
if(-d $nomrepertoire){
	
	if(my @files = glob("$nomrepertoire/*") ){
		
		#Recuperation de tous les fichiers du repertoire courant
my @tablodefichier= <$nomrepertoire/*.html>;

		#Parcours du tableau contant tous les fichiers du repertoire courant
  foreach my $nomfichier (@tablodefichier) {
	  
		#Tentative d'ouverture du fichier
	  if (open(FIC, "<$nomfichier")){
		  
		while(my $ligne =<FIC>){
					#Ecriture dans le fichier
print {$nouveaufichier} $ligne. "\n";
		}
		
		
close(FIC);
	  }else{
		  
		#Ouverture impossible du fichier
die("Ouverture impossible du fichier: $!\n");

 }  	 
  }
		
}else{
	#Desole le repertoire est vide
		print "le repertoire est vide\n";	

}
}else{
	print"ce n'est pas un repertoire\n";
}


}
close $nouveaufichier;
