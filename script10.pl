#!/usr/bin/env perl -w
#Descripció de l'script 10
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores 

use Bio::Seq; #Importem mòduls útils
use Bio::SeqIO;

$Usage = "Ús:
perl script10.pl ARXIU1 [ARXIU2] [ARXIU3] ...
";

if ($ARGV[0] eq "-h" || $ARGV[0] eq "--help" || $ARGV[0] eq ""){
  die $Usage;
}

foreach $NumArgs (0 .. $#ARGV) { #Bucle per a dur a terme les operacions sobre tots els fitxers passats com a arguments

   $RawSeq = ""; #Inicialitza la variable on guardarem la seqüència, per a cada volta del bucle
   $InputFile = $ARGV[$NumArgs];

  open INPUT, "<$InputFile";  # Obre el fitxer d'entrada
    while ($line = <INPUT>){ #Bucle per passar les línies sense \n a la variable $RawSeq
      chomp $line;
      $RawSeq = $RawSeq.$line;
    }
  close INPUT; #Tanquem el fitxer, ja no el necessitem obert

  #Ara toca començar-ne el procesament
  $RawSeq = uc $RawSeq #Passem a majúscules

  print "$RawSeq \n"; #Mostrem el contingut de la variable.
  
  $Seq = Bio::PrimarySeq->new( -seq => $RawSeq,  #Creem un objecte Bio::PrimarySeq a partir del contingut de la variable $RawSeq
			      -id  => 'id_qualsevol', #Qualsevol valor ens servirà per accession_number i id, ja que no els farem servir.
			      -accession_number => '',
  );
 # 

  if ($Seq->length()%3 != 0){ #Calculem la longitud de la cadena i comprovem si és divisible entre 3, i si no ho és abortem
    print "Seqüencia incompleta! No és múltiple de 3\n";
  } else {
    print "és múltiple de 3\n";

    print $Seq->alphabet;

    print "\n";
  }
}