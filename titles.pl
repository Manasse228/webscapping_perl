#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Copy::Recursive qw (fcopy rcopy dircopy fmove rmove dirmove);
use HTML::TagParser;
use File::Path;
use File::stat;

my @tabloderep= <garedetri/07wget/*>;
foreach my $nomdurepertoire (@tabloderep) {

  my $doc ="$nomdurepertoire";
  my $dest="garedetri/08titles/";
  my $nbre=0;
  my $count=0;
  my $rep="";
  my @values = split('/', $doc);

  foreach my $val (@values) {
    $nbre++;
  }
  
  foreach my $val (@values) {
	  $count++;
	  if($count == $nbre){
		 $rep=$val;
	  }
  }
  rmove($doc,$dest.$rep) or die("Impossible de copier $doc $!");
}



		#Recuperation de tous les repertoires du dossier
my @tabloderepertoire= <garedetri/08titles/*>;

		#Parcours du tableau contant tous les repertoires
  foreach my $nomrepertoire (@tabloderepertoire) {
	  
if(-d $nomrepertoire){

	
	if(my @files = glob("$nomrepertoire/*") ){
		# le repertoire n' est pas vide
		
				#Recuperation de tous les fichiers du repertoire courant
my @tablodefichier= <$nomrepertoire/*.html>;

		#Parcours du tableau contant tous les fichiers du repertoire courant
  foreach my $nomfichier (@tablodefichier) {
	  
		#Tentative d'ouverture du fichier
	  if (open(FIC, "<$nomfichier")){
		  my $compteur=0;
		#Verification du contenu du fichier ar son size
		while(my $line = <FIC>){
			if( ($line =~ "<html>") || ($line=~ "</html>") || ($line =~ "<title>") || ($line =~ "</title>") ){
				$compteur++;
			}
		}
		  if ( $compteur ==0) {
			  
		#on le supprimer
deletefolder($nomrepertoire);  		  
		  }else{
my $html = HTML::TagParser->new($nomfichier);
my $balise = $html->getElementsByTagName( "title" );

if( ref $balise){
	my $titre = $balise->innerText();
		
	#Reouverture du fichier en mode ecriture
open( my $fichierouvert, ">", $nomfichier)
or die ("Impossible d'écrire dans le fichier ${nomfichier} : $!\n");
if($titre eq ""){
	$titre="PAS DE TITLE";
}
	print {$fichierouvert} $titre ; 
}else{
		#on le supprimer
deletefolder($nomrepertoire);

}  
		  }
close(FIC);
	  }else{
		  
		#Ouverture impossible du fichier
die("Ouverture impossible du fichier: $!\n");
		#on le supprimer
deletefolder($nomrepertoire);
 }  	 
  }

}else{
	#Le repertoire est vide
	print "Le repertoire est vide $nomrepertoire\n";
}
}else{
	print"ce n'est pas un repertoire\n";
}


}


sub deletefolder {
	my(@args) = @_;
	my $dir="@args/";
if(rmtree([$dir], 1, 1)!=0){
   ## print "Suppression de###################### $dir\n";
}else{
   print "Erreur lors de la suppression de $dir.\n";
}
}
