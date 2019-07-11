#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Copy::Recursive qw (fcopy rcopy dircopy fmove rmove dirmove);
use HTML::TagParser;
use HTML::TokeParser;
use File::Path;
use File::stat;
use URI::URL; 
use LWP::Simple;
use DBI;
##use diagnostics;

sub getPerlCode{ 
				#Les paramètres de connexion à la base de données
my $bd          = 'r2d4_muta2'; 
my $host        = 'localhost';
my $user        = 'root';       
my $password    = 'a48b59!';	 
my $port	    = '3306';
#a48b59!
				#Connection à la base de données
	my $dbh = DBI->connect( "DBI:mysql:database=$bd;host=$host;port=$port", 
    $user, $password, { RaiseError => 1, mysql_enable_utf8 => 1}  ) 
    or die "Connection impossible à la base de données $bd !\n $! \n $@\n$DBI::errstr";
       

my $sth = $dbh->prepare('SELECT id,Nomdom FROM datadom WHERE description IS NULL ');
$sth->execute();
my @data;
while (@data = $sth->fetchrow_array()) {
	                   my $nomDeDomaine = $data[1];
	                   $nomDeDomaine =~ s/^\s+//; #Supprimer les espaces en début de mot
				       $nomDeDomaine =~ s/\s+$//; #Supprime les espaces en fin de mot
				       #$nomDeDomaine =~ s/\s+//; #Supprime tous les espaces
				       open my $nouveaufichier, '>', 'garedetri/16extract/'.$nomDeDomaine.'.pl';
				       
				      
                  
print {$nouveaufichier} "#!/usr/bin/perl -w\n  use strict;\n   use URI::URL;\n  use LWP::Simple;\n      
 open my \$nouveaufichier, '>', 'garedetri/17wget/$nomDeDomaine.index.html'; \n
 print {\$nouveaufichier} get(url('http://www.$nomDeDomaine')) .'\\n' ; \n 
 close \$nouveaufichier; \n   " ;
close($nouveaufichier);
}

#Deconection du serveur
 $dbh->disconnect();
 
}
 
operation();
 
sub operation{
getPerlCode();
getPageWeb();
}

sub getPageWeb{ 
my @tablodefichiers= <garedetri/16extract/*.pl>;
foreach my $nomfichier (@tablodefichiers){
system("perl $nomfichier");
unlink $nomfichier;
} 
 }
