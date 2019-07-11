#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Copy;
use File::Copy::Recursive qw (fcopy rcopy dircopy fmove rmove dirmove);
use HTML::TagParser;
use File::Path;



sub renommage{
	
	my @tabloderep= <garedetri/09filti/*>;
	foreach my $nomdurepertoire (@tabloderep) {
	
	my @tablodefichier= <$nomdurepertoire/*.html>;
	my $dest="garedetri/09filti/";	
	my $doc ="$nomdurepertoire";	
	my @values = split('/', $doc);
	my $nbre=0;
    my $count=0;
    my $rep="";
    
    foreach my $val (@values) {
    $nbre++;
    }
  
  foreach my $val (@values) {
	  $count++;
	  if($count == $nbre){
		 $rep=$val;
	  }
  }
  
	foreach my $nomfichier (@tablodefichier) {
			#Recuperation du fichier 
       my $nomfichiersimple = basename("$nomfichier");
		if( ( $rep  ne "09ftitles") || ( $rep  ne "10ftitles") || ( $rep  ne "10bestones") ) {
			my $docdepart ="$nomdurepertoire/$nomfichiersimple";
			rename $docdepart, $dest.$rep.".html" or die "Echec du renommage: $!";	
			#supprimer le dossier
			deletefolder($nomdurepertoire);
		}
	}		
	}
}


sub traitement{
my @tabloderep= <garedetri/09filti/*.html>;
foreach my $nomdufichier (@tabloderep) {

  my $repertoire ="$nomdufichier";
  my $dest="garedetri/10bestones/";
  my $nbre=0;
  my $count=0;
  my $fichier="";
  my @values = split('/', $repertoire);

  foreach my $val (@values) {
    $nbre++;
  }
  
  foreach my $val (@values) {
	  $count++;
	  if($count == $nbre){
		 $fichier=$val;
	  }
  }
  

	#rmove($doc,$dest.$rep) or die("Impossible de copier $doc $!");
	
	#si le title du fichier est vide on le supprimer
	#si le fichier contient l'un desmots appartenant à une liste  (mots anglais) suppressio net non copie
	#
	#print "fichier $fichier\n";
	
	my $compteur=0;
	if (open(FIC, "<$nomdufichier")){
		while(my $line = <FIC>){
			if( ($line =~ /advanced/) 
 		  || ($line =~ /almost/)
 	      || ($line=~ /amazing/)
 		  || ($line =~ /Another/)
 		  || ($line =~ /another/)
 		  || ($line =~ /associate/)
 		  || ($line =~ /Associate/)
 	      || ($line =~ /Brand/)
 	      || ($line =~ /build/)
 	      || ($line =~ /buy/) 
 	      || ($line =~ /Buy/) 
		|| ($line =~ /coming/)  
      || ($line=~ /cheap/)  
   || ($line =~ /china/)  
  || ($line =~ /craz/) 
  || ($line =~ /diese/)
  || ($line =~ /Diese/)
  || ($line =~ /disabled/) 
  || ($line =~ /Disabled/)
  || ($line =~ /Doména/)
				|| ($line =~ /download/)  
	|| ($line =~ /Download/)
 		  || ($line =~ /error/)  
 		  || ($line =~ /Error/) 
    || ($line=~ /estate/)
 || ($line =~ /first/)   
  || ($line =~ /focus/) 
  || ($line =~ /found/) 
				|| ($line =~ /gator/)   
      || ($line=~ /get/)  
      || ($line=~ /godaddy/) 
      || ($line=~ /HugeDomains/) 
    || ($line =~ /hier/)   
    || ($line =~ /hosted/)  
    || ($line =~ /Hosted/)
 || ($line =~ /LLC/) 
 || ($line =~ /Llc/) 
 || ($line =~ /Ltd/)
  || ($line =~ /ltd/)
				|| ($line =~ /official/)  
|| ($line =~ /Official/) 
    || ($line=~ /online/) 
   || ($line =~ /personal/) 
   || ($line =~ /Portal/)
   || ($line =~ /portal/)
|| ($line =~ /quite/) 
				|| ($line =~ /registered/) 
|| ($line =~ /Registered/) 
   || ($line=~ /review/)  
 || ($line =~ /sehen/)  
 || ($line =~ /soon/)   
 || ($line =~ /Soon/)  
  || ($line =~ /site est en vente/) 
				|| ($line =~ /under/)  
       || ($line=~ /untitled/) 
       || ($line=~ /Untitled/) 
 || ($line =~ /used/)  
   || ($line =~ /Website/) 
   || ($line =~ /WebSite/) 
   || ($line =~ /website/)
   || ($line =~ /welcome/) 
   || ($line =~ /Welcome/) 
				|| ($line =~ /website/)  
	|| ($line =~ /Website/)  
	|| ($line =~ /Wedding/) 
	|| ($line =~ /wedding/)
	|| ($line =~ /杭/)
	|| ($line =~ /州/)
	|| ($line =~ /画/)
	|| ($line =~ /室/)
	|| ($line =~ /杭/)
	|| ($line =~ /州/)
	|| ($line =~ /美/)
	|| ($line =~ /术/)
	|| ($line =~ /培/)
     || ($line eq "PAS DE TITLE")  ){
					
				$compteur++;
			}	
		}
		close(FIC);		
	}else{
		print "Ouverture impossible du fichier\n";
	}
	
	if($compteur==0){
			#on procede au deplacement du fichier
			move $nomdufichier, $dest;
			
	}else{
			#on suprime le fichier
			unlink $nomdufichier;
	}
	
  
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



operation();

sub operation{
renommage();
traitement();
}


