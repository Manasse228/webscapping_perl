#!/usr/bin/perl -w
use strict;
use File::Basename;
use DBI;    
use Time::Piece;
use File::Copy;


				#Les paramètres de connexion à la base de données
my $bd          = 'wpweb_base'; 
my $host        = 'localhost';
my $user        = 'root';       
my $password    = 'a48b59!'; 
my $port	    = '3306';

				#Connection à la base de données
	my $dbh = DBI->connect( "DBI:mysql:database=$bd;host=$host;port=$port", 
    $user, $password, { RaiseError => 1, mysql_enable_utf8 => 1}  ) 
    or die "Connection impossible à la base de données $bd !\n $! \n $@\n$DBI::errstr";
    
    my $sth = $dbh->prepare('SELECT option_value FROM wp_options WHERE option_name = "active_plugins" ');
$sth->execute();
my @data;
my $informations="";
while (@data = $sth->fetchrow_array()) { $informations = $data[0]; }

	  my @rien = split('', $informations);
	  my @content;
	  my @listDesPlugins;
	  my $index=0;
	  my $textpart1="";
	  my $textpart2="";
	  my $text="";
	  my $nombreDePlugins=0;
	  my $spy=0;
	  #On récupere tout le script(données receuillies depuis la base de données) dans un tableau content
	  foreach my $vall (@rien){push @content, $vall;  }
	
	  #on obtient la taille du tableau pour récupérer les deux parties du plugin
	  my $taille = scalar @content;		  
	  for (my $i=0;$i<$taille;$i++){
		  if($content[$i] eq "i"){
			  $index = $i;
			  while($content[$index] ne '"'){
			   $textpart1 .= $content[$index];
			    $index++;
		     }
		     $textpart1 .= " ";
		     while($content[$index] ne ';'){
				 $textpart2 .= $content[$index];
				 $index++;
			 }
			 $textpart2 .= "\n";
			 $text = $textpart1." ".$textpart2;
			#Insertion des deux parties séparées d'un espace dans un tableau listplugins
			 push @listDesPlugins, $text;
			 $spy++;
			 $nombreDePlugins++;
			 $textpart1="";
			 $textpart2="";
		  } 
	  }
	  
	  
	  my @listPluginsTrie;
	  #On vérifie si l'un des plugins qu'on reche n'est pas ici par hasard si cest le cas on
	  #le copie pas dans le nouveau tableau listpluginstrie
	  foreach my $contenuPlugin (@listDesPlugins){
		  unless($contenuPlugin =~ /postTabs/){ 
		push  @listPluginsTrie, $contenuPlugin; 
		$spy--;
	  }
	   
	 }
	 
	 $nombreDePlugins=$nombreDePlugins-$spy;
        
	 my $donnesGauche="";
	 my $donnesDroite="";
	 my $donnes="";
	 my $version=0;
	 my $scriptReconstituer="";
	 #on reconstitue le script à nouveau pour apres avoir enlever le plugin à enlever
	 foreach my $val12 (@listPluginsTrie){
		 my $cpt=0;
		 my @values = split(' ', $val12);
		  foreach my $val (@values){
			  $cpt++;
			  if ($cpt==1){
				 $donnesGauche=$val;
					my @values = split(';', $donnesGauche);
					foreach my $val (@values){
						$donnesGauche=$val;
					}
					
			  }
			  $donnesDroite=$val;
			  
		  }
		  $donnes .= "i:".$version.";".$donnesGauche."".$donnesDroite.";";
		  $version++;
	 }
	  $scriptReconstituer = "a:".$nombreDePlugins.":{".$donnes."} \n";
	  print $scriptReconstituer;


#a:2:{i:0;s:36:"contact-form-7/wp-contact-form-7.php";i:1;s:21:"posttabs/postTabs.php";}

