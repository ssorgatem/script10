#!/usr/bin/env perl -w
#Descripció de l'script 10
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores 

use Bio::Seq; #Importem mòduls útils
use Bio::SeqIO;

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

  print "$RawSeq \n"; #Mostrem el contingut de la variable.
  
  $Seq = Bio::PrimarySeq->new( -seq => $RawSeq,  #Creem un objecte Bio::PrimarySeq a partir del contingut de la variable $RawSeq
			      -id  => 'id_qualsevol', #Qualsevol valor ens servirà per accession_number i id, ja que no els farem servir.
			      -accession_number => '',
  );

  #$PrintableSeq = $Seq->seq();
  $len = $Seq->length(); # Calculem la longitud de la cadena

  if ($len%3 == 0){ #Comprovem si és divisible entre 3, i si no ho és abortem
    print "és múltiple de 3\n";
  } else {
    print "Seqüencia incompleta! No és múltiple de 3\n";
    break
  }

  print $Seq->alphabet;

  print "\n";
  print $@;
  print  "\n";
}