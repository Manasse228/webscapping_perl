#!/usr/bin/perl -w
use strict;
use File::Basename;
use DBI;    
use Time::Piece;
use File::Copy;


				#Les paramètres de connexion à la base de données
my $bd          = 'wpa'; 
my $host        = 'localhost';
my $user        = 'root';       
my $password    = 'a48b59!'; 
my $port	    = '3306';

				#Connection à la base de données
	my $dbh = DBI->connect( "DBI:mysql:database=$bd;host=$host;port=$port", 
    $user, $password, { RaiseError => 1, mysql_enable_utf8 => 1}  ) 
    or die "Connection impossible à la base de données $bd !\n $! \n $@\n$DBI::errstr";
    
    #Requête paramétrée
	my $requete = "INSERT INTO listeplugs (nom,chemin,version) VALUES (?,?,?)";
	
	
	my $nom="";
  my $chemin="";
  my $version="";
  
      
my $sth = $dbh->prepare('SELECT option_value FROM wpweb_base.wp_options WHERE option_name = "active_plugins" ');
$sth->execute();
my @data;
while (@data = $sth->fetchrow_array()) {
            my $informations = $data[0];
          
            my @values = split('"', $informations);
					my $cpt=0;
					my @part;
					my @tablo;
					
					foreach my $val (@values) {
						       @part = split('/', $val);
							foreach my $partval (@part){
								$cpt++;
							}
							if( $cpt > 1 ){
								push @tablo, $val;
							}
						$cpt=0;
             }
             
          foreach my $plugin (@tablo){
			  my @values = split ('/', $plugin);
			  $cpt=0;
			  foreach my $val (@values){
				  $cpt++;
				  if($cpt == 1){ 
					  $nom = $val; 
					  $nom =~ s/^\s+//; #Supprimer les espaces en début de mot
                      $nom =~ s/\s+$//; #Supprime les espaces en fin de mot
					  }
				  if($cpt == 2){ 
					  $chemin ="/var/www/wpweb.cf/wp-content/plugins/".$nom."/".$val;
					  if (open(FIC, "<$chemin")){
			               while(my $line = <FIC>){
							    if( ($line =~ "Version:") ){
									my @lineversion = split(':', $line);
									foreach my $ver (@lineversion){
										$version = $ver;
									}
								}
							   
						   }
						
						close(FIC);   
					   }else{
                          die("open: ".$chemin." $!");
                              }
							$version =~ s/^\s+//; #Supprimer les espaces en début de mot
                            $version =~ s/\s+$//; #Supprime les espaces en fin de mot
                            
                          #  print "Nom: ".$nom." Chemin: ".$chemin." Version: ".$version."\n";
                             my $insc = $dbh->prepare($requete) or die $dbh->errstr; 
                             $insc->execute($nom,$chemin,$version) or die $dbh->errstr; 
					   }
	
			  }
			  $cpt=0;
		  }
            
		}
  
    
    #Deconection du serveur
 $dbh->disconnect();

