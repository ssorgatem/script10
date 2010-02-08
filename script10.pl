#!/usr/bin/env perl -w
#Script per a traduir una seqüència de DNA a proteines, comprobant que sigui DNA i que tingui els codons necesaris
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores <noemseelteuemail@estudiants.urv.cat>

#Comencem a definir coses
$Usage = "Ús:\nperl script10.pl ARXIU1 [ARXIU2] [ARXIU3] ...\n"; #Missatge d'ajuda per a l'ús de l'script

%CodiGenetic = (
'TCA'=>'S', #Serine
'TCC'=>'S', #Serine
'TCG'=>'S', #Serine
'TCT'=>'S', #Serine
'TTC'=>'F', #Phenylalanine
'TTT'=>'F', #Phenylalanine
'TTA'=>'L', #Leucine
'TTG'=>'L', #Leucine
'TAC'=>'Y', #Tyrosine
'TAT'=>'Y', #Tyrosine
'TAA'=>'_', #Stop
'TAG'=>'_', #Stop
'TGC'=>'C', #Cysteine
'TGT'=>'C', #Cysteine
'TGA'=>'_', #Stop
'TGG'=>'W', #Tryptophan
'CTA'=>'L', #Leucine
'CTC'=>'L', #Leucine
'CTG'=>'L', #Leucine
'CTT'=>'L', #Leucine
'CCA'=>'P', #Proline
'CAT'=>'H', #Histidine
'CAA'=>'Q', #Glutamine
'CAG'=>'Q', #Glutamine
'CGA'=>'R', #Arginine
'CGC'=>'R', #Arginine
'CGG'=>'R', #Arginine
'CGT'=>'R', #Arginine
'ATA'=>'T', #Isoleucine
'ATC'=>'T', #Isoleucine
'ATT'=>'T', #Isoleucine
'ATG'=>'M', #Methionine #Start
'ACA'=>'T', #Threonine
'ACC'=>'T', #Threonine
'ACG'=>'T', #Threonine
'ACT'=>'T', #Threonine
'AAC'=>'N', #Asparagine
'AAT'=>'N', #Asparagine
'AAA'=>'K', #Lysine
'AAG'=>'K', #Lysine
'AGC'=>'S', #Serine#Valine
'AGT'=>'S', #Serine
'AGA'=>'R', #Arginine
'AGG'=>'R', #Arginine
'CCC'=>'P', #Proline
'CCG'=>'P', #Proline
'CCT'=>'P', #Proline
'CAC'=>'H', #Histidine
'GTA'=>'V', #Valine
'GTC'=>'V', #Valine
'GTG'=>'V', #Valine
'GTT'=>'V', #Valine
'GCA'=>'A', #Alanine
'GCC'=>'A', #Alanine
'GCG'=>'A', #Alanine
'GCT'=>'A', #Alanine
'GAC'=>'D', #Aspartic Acid
'GAT'=>'D', #Aspartic Acid
'GAA'=>'E', #Glutamic Acid
'GAG'=>'E', #Glutamic Acid
'GGA'=>'G', #Glycine
'GGC'=>'G', #Glycine
'GGG'=>'G', #Glycine
'GGT'=>'G', #Glycine
); 

sub DNAParser{
   $RawSeq = ""; #Inicialitza la variable on guardarem la seqüència, per a cada volta del bucle
   $InputFile = $_[0];
  print "Llegint $InputFile"."... ";
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
    print "seqüència incompleta! No és múltiple de 3\nAbortant...\n";
  } else {
    print "és múltiple de 3\n";
    print  "$RawSeq \n"; #Mostrem el contingut de la variable.
    #Continuem...
    return $RawSeq;
  }
}

sub DNA2aa {
  $DnaLen = length $_[0];
  $Proteina = "";
  for ($pos=0; $pos <= $DnaLen; $pos +=3) {
    $codon = substr($_[0], $pos, 3);
    print $codon.";";
    $Proteina = $Proteina.$CodiGenetic{$codon};
  }
  print "\n";
  return $Proteina;
}

#Aquí comença l'execució
if ($ARGV[0] eq "-h" || $ARGV[0] eq "--help" || $ARGV[0] eq ""){ #Interceptem falta d'arguments o demanda d'ajuda
  die $Usage;
}

foreach $NumArgs (0 .. $#ARGV) { #Bucle per a dur a terme les operacions sobre tots els fitxers passats com a arguments
  print &DNA2aa(&DNAParser($ARGV[$NumArgs]));
  print "\n";
}