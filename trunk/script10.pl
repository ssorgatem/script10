#!/usr/bin/env perl -w
#Descripció de l'script 10
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores 

use Bio::Seq #Importem mòduls útils

$Seq = ""; #Inicialitza la variable on guardarem la seqüència

$InputFile = "seq_script7"; # Fitxer d'entrada. Ho hem de canviar per a que sigui el primer argument, o enbolcallar-ho en un for per a cada argument.

open INPUT, "<$InputFile";  # Obre el fitxer d'entrada
  while ($line = <INPUT>){ #Bucle per passar les línies sense \n a la variable $Seq
    chomp $line;
    $Seq = $Seq.$line;
  }
close INPUT; #Tanquem el fitxer, ja no el necessitem obert

#Ara toca començar-ne el procesament

print "$Seq \n";