#!/usr/bin/perl -w
#Script per a traduir una seqüència de DNA a proteines, comprobant que sigui DNA i que tingui els codons necesaris
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores <noemseelteuemail@estudiants.urv.cat>

#TODO: DNAParser: definir tots els filtre per a determinar que sigui només un gen

#Comencem a definir coses
$Usage = "Ús:\nperl script10.pl ARXIU1 [ARXIU2] [ARXIU3] ...\n"; #Missatge d'ajuda per a l'ús de l'script
$patro = 0; #Posició des d'on començar a llegir la cadena de DNA. Pot ser 0, 1 o 2

%CodiGenetic = ( #Fem un Hash enmagatzemant el codi genetic
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
  'AGC'=>'S', #Serine
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

sub DNAParser{ # SubrutinAa que procesa i valida la seqüència d'entrada
   $RawSeq = ""; #Inicialitza la variable on guardarem la seqüència, per a cada volta del bucle
   $InputFile = $_[0]; #Aquest es el fitxer d'on treurem la seqüència
  print "Llegint $InputFile"."... ";
  open INPUT, "<$InputFile" || return "False";  # Obre el fitxer d'entrada
    while ($line = <INPUT>){ #Bucle per passar les línies sense \n a la variable $RawSeq
      chomp $line; #Treiem el canvi de linia de cada linia
      $RawSeq .= $line; #Afegim la linia a la cadena
    }
  close INPUT; #Tanquem el fitxer, ja no el necessitem obert
  

  #Ara toca començar-ne el procesament
  $RawSeq = uc $RawSeq; #Passem a majúscules
  $SeqLen = length $RawSeq;#Calculem la longitud de la cadena

  if ( $SeqLen%3 != 0){ #Comprovem si és divisible entre 3, i si no ho és abortem
    print "seqüència incompleta! No és múltiple de 3\nAbortant...\n";
    return "False"
  } elsif($RawSeq =~ /[^ACGT]/g){ #Ara busquem bases que no siguin A,C,G o T
    print "La seqüència no está formada només per A,T,C o G, abortant\n"; #Si les trobem, no continuem
    return "False";
  }elsif((substr($RawSeq, $pos, 3)) ne "ATG"){ #Comprovem que comenci per un codó d'inici
    print "La seqüència no comença per un codó d'inici!\n";#I si no ho fa, abortem
    return "False";
  }else{ #Si no, seguim
    #Continuem...
    print "\nCadena de DNA: "."$RawSeq \n"; #Mostrem el contingut de la variable.
    return $RawSeq;
  }
}

sub DNA2aa { #Subrutina per a traduir la cadena de DNA prèviament validada i processada a aminoàcids
  my $DnaLen = length $_[0]; #Quants nucleòtids tenim
  my $Proteina = ""; #Inicialitzem la variable contenidora de la proteina
  for ($pos=$patro; $pos < $DnaLen; $pos +=3) {#Bucle per a traduir els nucleotids de 3 en 3
    $codon = substr($_[0], $pos, 3);#agafa els 3 nucleòtids més a l'esquerra que no hem llegit encara
    $aa = $CodiGenetic{$codon}; #Tradueix el codó
    if ($aa eq '_'){ #Si es un stop, atura
      last;#Finalitza aquí el bucle
    }elsif ($aa eq ''){#Això no hauria de passar, però si trobem un codó que no es contempla al codi genètic...(segurament per culpa d'un bug) 
      print "Codó desconegut:$codon !\n";
      $aa = "?"; #Queixem-nos i posem un interrogant a la proteina
    }else{#Si no, guardem l'aminoàcid a la variable $Proteina
      $Proteina = $Proteina.$aa;
    }
  }
  print "\n";
  return $Proteina; #Retornem la proteina
}

#Aquí comença l'execució
if ($ARGV[0] eq "-h" || $ARGV[0] eq "--help" || $ARGV[0] eq ""){ #Interceptem falta d'arguments o demanda d'ajuda
  die $Usage;
}

foreach $NumArgs (0 .. $#ARGV) { #Bucle per a dur a terme les operacions sobre tots els fitxers passats com a arguments
  $DNA = &DNAParser($ARGV[$NumArgs]);#Cridem a la subrutina DNAParser, i el que retorna ho passem com a argument a la subrutina DNA2aa, que retornarà la proteina si tot va bé
  if ($DNA eq "False"){
    print "Error: la seqüència introduïda no corresponia a un gen de DNA\n";
  } else{
    print "Cadena traduïda: ".&DNA2aa($DNA)."\n";
  }
}