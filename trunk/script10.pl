#!/usr/bin/perl -w
#Script per a traduir una seqüència de DNA a proteines, comprobant que sigui DNA i que tingui els codons necesaris
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores <noemseelteuemail@estudiants.urv.cat>

#Comencem a definir coses
$Usage = "Ús:\nperl script10.pl [OPCIONS] ARXIU1 [ARXIU2] [ARXIU3] ...\nO bé:\nperl script10.pl --translate SEQÜÈNCIA1 [SEQÜÈNCIA2] [SEQÜÈNCIA3] ...\n\nPossibles opcions:\n\n--transl_table TRANS_TABLE\n\nEls valors de TRANSL_TABLE es poden trobar a http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi\n\nSi s'executa sense arguments, demanarà l'entrada manual de la seqüència d'un gen\n"; #Missatge d'ajuda per a l'ús de l'script
$patro = 0; #Posició des d'on començar a llegir la cadena de DNA. Pot ser 0, 1 o 2. No gaire útil, per ara.

#Codi genetic estandard
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
  'ATA'=>'I', #Isoleucine
  'ATC'=>'I', #Isoleucine
  'ATT'=>'I', #Isoleucine
  'ATG'=>'M', #Methionine
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

@CodoInicial = ("ATG","TTG","CTG");#Array dels codons inicials del codi genètic estàndard

#Diferents codis genetics estrests de: http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi?mode=t#SG3


#Codi genetic per mitocondries de vertebrats
sub mtVertebrate{	#transl_table=2
  $CodiGenetic{'AGA'} = '_';
  $CodiGenetic{'AGG'} = '_';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATT","ATC","ATA","ATG","GTG");
}

#Codi genetic per mitocondries de llevats
sub mtYeast {	#transl_table=3
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'CTT'} = 'T';
  $CodiGenetic{'CTC'} = 'T';
  $CodiGenetic{'CTA'} = 'T';
  $CodiGenetic{'CTG'} = 'T';
  $CodiGenetic{'TGA'} = 'W';
  $CodiGenetic{'CGA'} = '-';#Absent
  $CodiGenetic{'CGC'} = '-';#Absent
  @CodoInicial = ("ATA","ATG");
}

#Codi genetic per micoplasmes/spiroplames i mitocondries de molses, protozous, colenterats
sub Mycoplasma{	#transl_table=4
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTA","TTG","CTG","ATT","ATC","ATA","ATG","GTG");
}

#Codi genetic per mitocondries d'invertebrats
sub mtInvertebrate{	#transl_table=5
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTG","ATT","ATC","ATA","ATG","GTG");
}

#The Ciliate, Dasycladacean and Hexamita Nuclear Code
sub Ciliate { #transl_table=6
  $CodiGenetic{'TAA'} = 'Q';
  $CodiGenetic{'TAG'} = 'Q';
  @CodoInicial = ("ATG")
}

#The Echinoderm and Flatworm Mitochondrial Code
sub mtEchinoderm { #transl_table=9
  $CodiGenetic{'AAA'} = 'N';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATG","CTG")
}

#Euplotid Nuclear Code
sub Euplotid { #transl_table=10
  $CodiGenetic{'TGA'} = 'C';
  @CodoInicial = ("ATG")
}

#Bacterial, Archaeal and Plant Plastid Code
sub Plastid { #transl_table=11
  @CodoInicial = ("TTG","CTG","ATT","ATC","ATA","ATG","GTG")
}

#Alternative Yeast Nuclear Code
sub AltYeast { #transl_table=12
  $CodiGenetic{'CTG'} = 'S';
  @CodoInicial = ("ATG","CTG")
}

#Codi genetic per mitocondris d'ascidis
sub mtAscidian{	#transl_table=13
  $CodiGenetic{'AGA'} = 'G';
  $CodiGenetic{'AGG'} = 'G';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTG","ATA"."ATG","GTG");
}

#Alternative Flatworm Mitochondrial Code
sub Flatworm { #transl_table=14
  $CodiGenetic{'AAA'} = 'N';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'TAA'} = 'Y';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATG")
}

#Blepharisma Nuclear Code
sub Blepharisma { #transl_table=15
  $CodiGenetic{'TAG'} = 'Q';
  @CodoInicial = ("ATG")
}

#Chlorophycean Mitochondrial Code
sub mtChlorophycean { #transl_table=16
  $CodiGenetic{'TAG'} = 'L';
  @CodoInicial = ("ATG")
}

#Trematode Mitochondrial Code
sub mtTrematode { #transl_table=21
  $CodiGenetic{'TGA'} = 'W';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'AAA'} = 'N';
  @CodoInicial = ("ATG","GTG")
}

#Scenedesmus obliquus mitochondrial Code
sub mtScenedesmus { #transl_table=22
  $CodiGenetic{'TCA'} = '_';
  $CodiGenetic{'TAG'} = 'L';
  @CodoInicial = ("ATG")
}

#Thraustochytrium Mitochondrial Code
sub mtThrau { #transl_table=23
  $CodiGenetic{'TTA'} = '_';
  @CodoInicial = ("ATG","ATT","GTG")
}

sub File2Line{
  $Line = ""; #Inicialitza la variable on guardarem la seqüència, per a cada volta del bucle
  $File = $_[0]; #Aquest es el fitxer d'on treurem la seqüència
  print "Llegint $File"."... ";
  open INPUT, "<$File" || return "False";  # Obre el fitxer d'entrada
  while ($line = <INPUT>){ #Bucle per passar les línies sense \n a la variable $RawSeq
    chomp $line; #Treiem el canvi de linia de cada linia
    $Line .= $line; #Afegim la linia a la cadena
  }
  close INPUT; #Tanquem el fitxer, ja no el necessitem obert
  return $Line;
}

sub DNAParser{ # Subrutina que procesa i valida la seqüència d'entrada
  #Ara toca començar-ne el procesament
  $RawSeq = uc $_[0]; #Passem a majúscules
  $SeqLen = length $RawSeq;#Calculem la longitud de la cadena
  $PrimerCodo = substr($RawSeq, $patro, 3); #Llegim i enmagatzemem el primer codo per la seva posterior comprovació
  $esInici = grep(/$PrimerCodo$/,@CodoInicial);#Comprovem que comenci per un codó d'inici

  if ( $SeqLen%3 != 0){ #Comprovem si és divisible entre 3, i si no ho és abortem
    print "seqüència incompleta! No és múltiple de 3\nAbortant...\n";
    return "False"
  } elsif($RawSeq =~ /[^ACGT]/g){ #Ara busquem bases que no sigui(substr($RawSeq, $patro, 3))n A,C,G o T
    print "La seqüència no está formada només per A,T,C o G, abortant\n"; #Si les trobem, no continuem
    return "False";
  }elsif(not($esInici)){ #Comprovem que comenci per un codó d'inici
    print "El codó inicial $PrimerCodo no és un codó d'inici!\n";#I si no ho fa, abortem
    return "False";
  }elsif($CodiGenetic{(substr($RawSeq, $SeqLen-3, 3))} ne "_"){ #Comprovem que acabi amb un codó de stop
    print "El codó final ".(substr($RawSeq, $SeqLen-3, 3))." no és un codó de stop!\n";#I si no ho fa, abortem
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

if($ARGV[0] eq "--transl_table"){ #Per si volem fer servir un altre codi genètic
  if($ARGV[1] eq "1"){ #Cada número executa la subrutina del codi corresponent
  }elsif($ARGV[1] eq "2"){
    &mtVertebrate()
  }elsif($ARGV[1] eq "3"){
    &mtYeast()
  }elsif($ARGV[1] eq "4"){
    &Mycoplasma()
  }elsif($ARGV[1] eq "5"){
    &mtInvertebrate()
  }elsif($ARGV[1] eq "6"){
    &Ciliate()
  }elsif($ARGV[1] eq "9"){
    &mtEchinoderm()
  }elsif($ARGV[1] eq "10"){
    &Euplotid()
  }elsif($ARGV[1] eq "11"){
    &Plastid()
  }elsif($ARGV[1] eq "12"){
    &AltYeast()
  }elsif($ARGV[1] eq "13"){
    &mtAscidian()
  }elsif($ARGV[1] eq "14"){
    &Flatworm()
  }elsif($ARGV[1] eq "15"){
    &Blepharisma()
  }elsif($ARGV[1] eq "16"){
    &mtChlorophycean()
  }elsif($ARGV[1] eq "21"){
    &mtTrematode()
  }elsif($ARGV[1] eq "22"){
    &mtScenedesmus()
  }elsif($ARGV[1] eq "23"){
    &mtThrau()
  }else{
    die "Número de taula de transcripció incorrecte\n$Usage"; #Número desconegut == morir
  }
  shift @ARGV; #Retirem els dos primers arguments (--code i el numero) per a processar la resta de forma normal
  shift @ARGV;
}

until($ARGV[0] ne ""){
  print "Introduiu la seqüència de DNA d'un gen:\n";
  $escrita = <> ;
  chomp $escrita;
  @ARGV = ("--translate", $escrita);
}
if ($ARGV[0] eq "-h" || $ARGV[0] eq "--help" || $ARGV[0] eq ""){ #Interceptem falta d'arguments o demanda d'ajuda
  die $Usage;
}else{
  foreach $NumArgs (0 .. $#ARGV) { #Bucle per a dur a terme les operacions sobre tots els fitxers passats com a arguments
    if($ARGV[$NumArgs] eq "--translate"){
      $FromFile = "False"; #Si el primer argument és --translate, no procesarlo, pero canviar el comportament
      next;
    }
    if($FromFile eq "False"){
      $DNA = &DNAParser($ARGV[$NumArgs]);#Usa directament la seqüència des de l'argument, sense obrir un fitxer
    }else{
      $DNA = &DNAParser(&File2Line($ARGV[$NumArgs]));#Cridem a la subrutina DNAParser, i el que retorna ho passem com a argument a la subrutina DNA2aa, que retornarà la proteina si tot va bé
    }
    if($DNA eq "False"){
      print "Error: la seqüència introduïda no corresponia a un gen de DNA\n";
    }else{
      print "Cadena traduïda: ".&DNA2aa($DNA)."\n"; #Tradueix i mostra la proteina resultant
    }
  }
}