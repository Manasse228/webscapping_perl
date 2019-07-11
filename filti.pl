#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Copy;
use File::Copy::Recursive qw (fcopy rcopy dircopy fmove rmove dirmove);
use HTML::TagParser;
use File::Path;


sub deplacement{
  my @tabloderep= <garedetri/08titles/*>;
foreach my $nomdurepertoire (@tabloderep) {

  my $doc ="$nomdurepertoire";
  my $dest="garedetri/09filti/";
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
  
  if( ( $rep  eq "09ftitles") || ( $rep  eq "10ftitles") || ( $rep  eq "10bestones")  ) {
  }else{
	  rmove($doc,$dest.$rep) or die("Impossible de copier $doc $!");
  }
}	
}

deplacement();



