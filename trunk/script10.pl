#!/usr/bin/perl -w
# Script per a traduir una seqüència de DNA a proteines, comprobant que sigui DNA i que tingui els codons necesaris
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores <noemseelteuemail@estudiants.urv.cat>

use Getopt::Long; #S'emprara la funció Getopt per recuperar els arguments de l'script

#####----------------------------------------START: Definició de variables----------------------------------------#####
$patro = 0; #Posició des d'on començar a llegir la cadena de DNA. Pot ser 0, 1 o 2. No gaire útil, per ara.
$resultat='';
$Translatecount = 0; #Nombre d'iteracion de --translate dutes a terme
$save_file=0; #Guardar a un fitxer? Per defecte no
$sufix ="_translated.txt"; #Postfix del nom de la traducció
$separator = "--------------------------------------------------------------------------------\n";
$Usage = "Ús:
    perl script10.pl [OPCIONS] ARXIU1 [ARXIU2] [ARXIU3] ...

Possibles opcions:

    --translate SEQÜÈNCIA
      Pren l'argument SEQÜÈNCIA com a seqüència en comptes de com a fitxer. 

    --transl_table TRANS_TABLE
      Els valors de TRANSL_TABLE es poden trobar a http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi

    --output FITXER
      Desa tota la sortida a un fitxer

    --save
      Desa al directori de treball la seqüència traduïda com a 'ARXIU$sufix'[TRANS_TABLE] (seqüències des de fitxers) o 'DNA#$sufix'[TRANS_TABLE] (seqüències no provinents de fitxers). Si ja existia un fitxer amb aquell nom, serà sobreescrit

Totes les opcions son combinables

Si s'executa sense arguments, demanarà l'entrada manual de la seqüència d'un gen.
Per defecte, es fa servir el codi genètic estàndard, però sense notificacions al respecte. Si s'especifica --transl_table 1, sí que es notificarà que s'està fent servir el codi genètic estàndard.
"; #Missatge d'ajuda per a l'ús de l'script
#####----------------------------------------END: Definició de variables----------------------------------------#####

#####----------------------------------------START: Definicions de les taules genètiques----------------------------------------#####
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

#Diferents codis genetics extrets de: http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi?mode=t#SG3

#Codi genetic per mitocondries de vertebrats
sub mtVertebrate{	#transl_table=2
  $resultat .="Es traduirà segons el genoma mitocondrial de vertebrats (transl_table=2)\n\n";
  $CodiGenetic{'AGA'} = '_';
  $CodiGenetic{'AGG'} = '_';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATT","ATC","ATA","ATG","GTG");
}

#Codi genetic per mitocondries de llevats
sub mtYeast {	#transl_table=3
  $resultat .="Es traduirà segons el genoma mitocondrial de llevats (transl_table=3)\n\n";
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
  $resultat .="Es traduirà segons el genoma de micoplasmes/spiroplasmes i de mitocondris de molses, protozous i colenterats (transl_table=4)\n\n";
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTA","TTG","CTG","ATT","ATC","ATA","ATG","GTG");
}

#Codi genetic per mitocondries d'invertebrats
sub mtInvertebrate{	#transl_table=5
  $resultat .="Es traduirà segons el genoma mitocondral d'invertebrats (transl_table=5)\n\n";
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTG","ATT","ATC","ATA","ATG","GTG");
}

#The Ciliate, Dasycladacean and Hexamita Nuclear Code
sub Ciliate { #transl_table=6
  $resultat .="Es traduirà segons el genoma dels ciliats, dasicladacis i hexamites (transl_table=6)\n\n";
  $CodiGenetic{'TAA'} = 'Q';
  $CodiGenetic{'TAG'} = 'Q';
  @CodoInicial = ("ATG")
}

#The Echinoderm and mtFlatworm Mitochondrial Code
sub mtEchinoderm { #transl_table=9
  $resultat .="Es traduirà segons el genoma d'equinoderms i de mitocondris de plathielmints (transl_table=9)\n\n";
  $CodiGenetic{'AAA'} = 'N';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATG","CTG")
}

#Euplotid Nuclear Code
sub Euplotid { #transl_table=10
  $resultat .="Es traduirà segons el genoma dels euplòtids (transl_table=10)\n\n";
  $CodiGenetic{'TGA'} = 'C';
  @CodoInicial = ("ATG")
}

#Bacterial, Archaeal and Plant Plastid Code
sub Plastid { #transl_table=11
  $resultat .="Es traduirà segons el genoma de bacteris, arquees i plastos vegetals (transl_table=11)\n\n";
  @CodoInicial = ("TTG","CTG","ATT","ATC","ATA","ATG","GTG")
}

#Alternative Yeast Nuclear Code
sub AltYeast { #transl_table=12
  $resultat .="Es traduirà segons el genoma alternatiu de llevats (transl_table=12)\n\n";
  $CodiGenetic{'CTG'} = 'S';
  @CodoInicial = ("ATG","CTG")
}

#Codi genetic per mitocondris d'ascidis
sub mtAscidian{	#transl_table=13
  $resultat .="Es traduirà segons el genoma mitocondrial d'ascidis (transl_table=13)\n\n";
  $CodiGenetic{'AGA'} = 'G';
  $CodiGenetic{'AGG'} = 'G';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTG","ATA","ATG","GTG");
}

#Alternative mtFlatworm Mitochondrial Code
sub mtAltFlatworm { #transl_table=14
  $resultat .="Es traduirà segons el genoma mitocondrial alternatiu de platielmints(transl_table=14)\n\n";
  $CodiGenetic{'AAA'} = 'N';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'TAA'} = 'Y';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATG")
}

#Blepharisma Nuclear Code
sub Blepharisma { #transl_table=15
  $resultat .="Es traduirà segons el genoma de blefarismes(transl_table=15)\n\n";
  $CodiGenetic{'TAG'} = 'Q';
  @CodoInicial = ("ATG")
}

#Chlorophycean Mitochondrial Code
sub mtChlorophycean { #transl_table=16
  $resultat .="Es traduirà segons el genoma mitocondrial de clorofícies(transl_table=16)\n\n";
  $CodiGenetic{'TAG'} = 'L';
  @CodoInicial = ("ATG")
}

#Trematode Mitochondrial Code
sub mtTrematode { #transl_table=21
  $resultat .="Es traduirà segons el genoma mitocondrial de tremàtodes(transl_table=21)\n\n";
  $CodiGenetic{'TGA'} = 'W';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'AAA'} = 'N';
  @CodoInicial = ("ATG","GTG")
}

#Scenedesmus obliquus mitochondrial Code
sub mtScenedesmus { #transl_table=22
  $resultat .="Es traduirà segons el genoma mitocondrial de Scenedesmus obliquus(transl_table=22)\n\n";
  $CodiGenetic{'TCA'} = '_';
  $CodiGenetic{'TAG'} = 'L';
  @CodoInicial = ("ATG")
}

#Thraustochytrium Mitochondrial Code
sub mtThraustochytrium { #transl_table=23
  $resultat .="Es traduirà segons el genoma mitocondrial de Thraustochytrium sp. (transl_table=23)\n\n";
  $CodiGenetic{'TTA'} = '_';
  @CodoInicial = ("ATG","ATT","GTG")
}

#Hash que relaciona els valors de --transl_table amb els diversos codis genètics
%CodisGenetics = (
  "1"=>sub {$resultat .= "Es traduirà segons el genoma estàndard (transl_table=1)\n\n";},
  "2"=>\&mtVertebrate,
  "3"=>\&mtYeast,
  "4"=>\&Mycoplasma,
  "5"=>\&mtInvertebrate,
  "6"=>\&Ciliate,
  "9"=>\&mtEchinoderm,
  "10"=>\&Euplotid,
  "11"=>\&Plastid,
  "12"=>\&AltYeast,
  "13"=>\&mtAscidian,
  "14"=>\&mtFlatworm,
  "15"=>\&Blepharisma,
  "16"=>\&mtChlorophycean,
  "21"=>\&mtTrematode,
  "22"=>\&mtScenedesmus,
  "23"=>\&mtThraustochytrium,
);
#####----------------------------------------END: Definicions de les taules genètiques----------------------------------------#####

#####----------------------------------------START: Definició de funcions de processament----------------------------------------#####

#Funció que obre un fitxer i el retorna en una variable d'una línia
sub File2Line{
  $Line = ""; #Inicialitza la variable on guardarem la seqüència, per a cada volta del bucle
  $File = $_[0]; #Aquest es el fitxer d'on treurem la seqüència
  $resultat .= "Fitxer d'origen: $File\n";
  open(INPUT,"<","$File")|| return "False";  # Obre el fitxer d'entrada
  while ($line = <INPUT>){ #Bucle per passar les línies sense \n a la variable $RawSeq
    chomp $line; #Treiem el canvi de linia de cada linia
    $Line .= $line; #Afegim la linia a la cadena
  }
  close INPUT; #Tanquem el fitxer, ja no el necessitem obert
  return $Line;
}

# Subrutina que procesa i valida la seqüència d'entrada
sub DNAParser{ 
  $RawSeq = uc $_[0]; #Passem a majúscules
  $SeqLen = length $RawSeq;#Calculem la longitud de la cadena
  $PrimerCodo = substr($RawSeq, $patro, 3); #Llegim i enmagatzemem el primer codo per la seva posterior comprovació
  if ( $SeqLen%3 != 0){ #Comprovem si és divisible entre 3, i si no ho és abortem
    $resultat .= "seqüència incompleta! No és múltiple de 3\nAbortant...\n";
    return "False"
  } elsif($RawSeq =~ /[^ACGT]/g){ #Ara busquem bases que no sigui(substr($RawSeq, $patro, 3))n A,C,G o T
    $resultat .=  "La seqüència no está formada només per A,T,C o G, abortant\n"; #Si les trobem, no continuem
    return "False";
  }elsif(not(grep(/$PrimerCodo$/,@CodoInicial))){ #Comprovem que comenci per un codó d'inici
    $resultat .=  "El codó inicial $PrimerCodo no és un codó d'inici!\n";#I si no ho fa, abortem
    return "False";
  }elsif($CodiGenetic{(substr($RawSeq, $SeqLen-3, 3))} ne "_"){ #Comprovem que acabi amb un codó de stop
    $resultat .=  "El codó final ".(substr($RawSeq, $SeqLen-3, 3))." no és un codó de stop!\n";#I si no ho fa, abortem
    return "False";
  }else{ #Si no, seguim
    #Continuem...
    return $RawSeq;
  }
}

#Subrutina per a traduir la cadena de DNA prèviament validada i processada a aminoàcids
sub DNA2aa { 
  my $DnaLen = length $_[0]; #Quants nucleòtids tenim
  my $Proteina = ""; #Inicialitzem la variable contenidora de la proteina
  for ($pos=$patro; $pos < $DnaLen; $pos +=3) {#Bucle per a traduir els nucleotids de 3 en 3
    $codon = substr($_[0], $pos, 3);#agafa els 3 nucleòtids més a l'esquerra que no hem llegit encara
    $aa = $CodiGenetic{$codon}; #Tradueix el codó
    if ($aa eq '_'){ #Si es un stop, atura
      last;#Finalitza aquí el bucle
    }elsif ($aa eq ''){#Això no hauria de passar, però si trobem un codó que no es contempla al codi genètic...(segurament per culpa d'un bug) 
      $resultat .= "Codó desconegut:$codon !\n";
      $aa = "?"; #Queixem-nos i posem un interrogant a la proteina
    }
    $Proteina .= $aa;
  }
  print "\n";
  return $Proteina; #Retornem la proteina
}

sub recupera_ARGV{
  local $SIG{__WARN__}= sub {die "Opció desconeguda\n".$Usage;}; #Amb qualsevol warning mor! es excessiu
  GetOptions(
    'help|?',
    'transl_table=s' => \$transl_table,
    'translate=s' => \@translate,
    'output=s' => \$output_file,
    'save' => \$save_file
  );
  if($opt_help){die $Usage;};
}

#####----------------------------------------END: Definició de funcions de processament----------------------------------------#####

#####----------------------------------------START: Execució de l'script----------------------------------------#####

#Recuperem els arguments establerts

&recupera_ARGV;#Digereix els argument

#Carreguem el codi genètic adient
eval{#eval per morir si s'intenta fer servir una taula inexistent
  if($transl_table){ #Si no es defineix transl_table, no cal que intentem fer res al diccionari, ni que especifiquem que fer servir el codi genètic estàndard
    $CodisGenetics{$transl_table}();
    $sufix = "_transl_table=$transl_table.txt"; #Si fem servir una taula no estàndard,  pot interessar reflectir-ho al nom del fitxer
  }else{
  print "";#Per a que l'eval no mori si no esta definit $transl_table
  }
} or die "Número de taula de transcripció incorrecta\n$Usage";

if(@translate){
  @Args = @translate; #Si estem traduint directament un string, el que ens interessa està a $translate
}
if (not(@ARGV or @translate)){ #Si no hi ha arguments, demana l'entrada manual d'una seq.
  print "Introduiu la seqüència de DNA d'un gen:\n";
  @translate = <> ;
  chomp $translate[0];
  @Args = $translate[0];
}else{
  @Args = (@Args,@ARGV); #Si tenim arguments i no $translate, agafem arguments com a fitxers
}
foreach $argument (@Args){
  $resultat .= $separator; #Afegim separador al resultat
  if(grep(/$argument$/,@translate)){ #Si $translate es $argument, no cal processar més $argument, perquè és la seqüència 
    $DNA = &DNAParser($argument);#Comprovem que sigui DNA gènic vàlid
    $save_filename = "DNA".$Translatecount.$sufix;#Canviem el nom de fitxer, ja que no hi ha fitxer d'entrada
    $Translatecount += 1;
  }else{
    $DNA = &DNAParser(&File2Line($argument)); #Passem el fitxer a string
    $save_filename = $argument.$sufix;
  }
  if($DNA eq "False"){#Si la cosa no surt be...
    $resultat .= "Error: la seqüència introduïda no corresponia a un gen de DNA\n";
    $resultat .= $separator; #Afegim separador al resultat
  }else{#Si surt be
    $Prot = &DNA2aa($DNA); #Traduim el DNA
    if($save_file){ #Si cal guardar-ho a un fitxer
      open (FITXER, '>', $save_filename); #Obrim el fitxer on guardar la proteina
      print FITXER $Prot."\n"; #Guarda la proteina resultant
      close (FITXER);
    }
  $resultat .=  "Cadena original: $DNA\n\n";#Mostra la cadena original
  $resultat .=  "Cadena traduïda: $Prot\n"; #Mostra la proteina resultant
  $resultat .= $separator; #Afegim separador al resultat;
  } 
}

print $resultat;#Mostrem el resultat

if($output_file){ #Si la opció de desar en disc s'havia especificat, el desem
  open (FITXER, '>', $output_file);
  print FITXER $resultat;
  close (FITXER);
}
#####----------------------------------------END: Execució de l'script----------------------------------------#####