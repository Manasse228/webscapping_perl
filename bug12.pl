use strict;
use strict;
use File::Basename;
use DBI;    
use Time::Piece;
use File::Copy;



my @tablodefichier = <garedetri/12csvwhois/12csvwhois/*>;

foreach my $fichier (@tablodefichier){
	
	move $fichier , "garedetri/12csvwhois/";
	
}
