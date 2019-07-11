#!/usr/bin/perl -w
use strict;
use File::Basename;
use DBI;    
use Time::Piece;
use File::Copy;
	

my @tablodefichier= <garedetri/13whoisorg/*.csv>;



#Verification si le dossier est vide
if(my @files = glob("garedetri/13whoisorg/*.csv") ){
	
		foreach my $nomfichier (@tablodefichier) {
            my $detect=0;
			if (open(FIC, "<$nomfichier")){

			while(my $line = <FIC>){

					#Recuperation du registrar
					if( ($line =~ "Registrant Country:") ){
						my $registrar="";
					my @values = split(':', $line);
					foreach my $val (@values) {
							$registrar=$val;
                       }
                       $registrar =~ s/^\s+//; #Supprimer les espaces en début de mot
				       $registrar =~ s/\s+$//; #Supprime les espaces en fin de mot
				       #$registrar =~ s/\s+//; #Supprime tous les espaces
                       if( $registrar eq "FR" ){
						  $detect=1;
						 # print "${registrar} et $nomfichier \n";
					   }
				}
					
				
			}
			close(FIC);

			}else{
						#Ouverture impossible du fichier
die("Ouverture impossible du fichier: $!\n");
			}
if( $detect == 1 ){
	move $nomfichier, "garedetri/14org/"; 
}else{
	unlink $nomfichier;
}			

}	
	}else{
		print "le repertoire est  vide ... \n";
	}





