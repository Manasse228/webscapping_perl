#!/usr/bin/perl -w
use strict;
use File::Find;


my @tablofichier = <garedetri/15supprim/*.csv>;

foreach my $fichiers (@tablofichier){
	my $age = int (-M $fichiers);
	
	if($age >= 15 ){
		#print  "Mon âge est: ".$age." ".$fichiers."\n";
		unlink $fichiers;
	}
		
	
}
