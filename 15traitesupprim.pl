#!/usr/bin/perl -w
use strict;
use File::Find;
use File::Path;


my @tablofichier = <garedetri/15traites/*>;

foreach my $fichiers (@tablofichier){
	my $age = int (-M $fichiers);
	
	if( ($age >= 15 ) && (-d $fichiers) ){
		print  "Mon âge est: ".$age." ".$fichiers."\n";
		
if(rmtree([$fichiers], 1, 1)!=0){
}else{
   print "Erreur lors de la suppression de $fichiers.\n";
}
		
	}
		
	
}
