#!/usr/bin/env perl -w
#Descripció de l'script 10
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores <noemseelteuemail@estudiants.urv.cat>

#Comencem a definir coses
$Usage = "Ús:\nperl script10.pl ARXIU1 [ARXIU2] [ARXIU3] ...\n"; #Missatge d'ajuda per a l'ús de l'script

#Aquí comença l'execució
if ($ARGV[0] eq "-h" || $ARGV[0] eq "--help" || $ARGV[0] eq ""){ #Interceptem falta d'arguments o demanda d'ajuda
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
  $RawSeq = uc $RawSeq; #Passem a majúscules
  $SeqLen = length $RawSeq;#Calculem la longitud de la cadena

  if ( $SeqLen%3 != 0){ #Comprovem si és divisible entre 3, i si no ho és abortem
    print "Seqüència incompleta! No és múltiple de 3\n";
  } else {
    print "és múltiple de 3\n";
    print  " $RawSeq \n"; #Mostrem el contingut de la variable.
    #Continuem...
  }
}