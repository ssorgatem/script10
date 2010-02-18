#!/usr/bin/perl -w
#Script per a traduir una seqüència de DNA a proteines, comprobant que sigui DNA i que tingui els codons necesaris
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores <noemseelteuemail@estudiants.urv.cat>

use Getopt::Long; #S'emprara la funció Getopt per recuperar els arguments de l'script

#Comencem a definir coses
$output_file=0; #Guardar a un fitxer? Per defecte no
$output_filename = ''; #Nom del fitxer a guardar
$postfix ="_translated.txt"; #Postfix del nom de la traducció

$Usage = "Ús:
    perl script10.pl [OPCIONS] ARXIU1 [ARXIU2] [ARXIU3] ...

Possibles opcions:

    --translate SEQÜÈNCIA
      Es traduirà SEQÜÈNCIA directament, en comptes de llegir arxius o demanar la introducció d'una seqüència.

    --transl_table TRANS_TABLE
      Els valors de TRANSL_TABLE es poden trobar a http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi

    --output|save 
      Guarda la seqüència traduïda a 'ARXIU$postfix ', o 'Manual_DNA_entry$postfix ' o 'DNA$postfix ', segons el mètode d'entrada.

Totes les opcions són combinables.

Si s'executa sense arguments, demanarà l'entrada manual de la seqüència d'un gen\n"; #Missatge d'ajuda per a l'ús de l'script

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
  print "Es traduirà segons el genoma mitocondrial de vertebrats\n\n";
  $CodiGenetic{'AGA'} = '_';
  $CodiGenetic{'AGG'} = '_';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATT","ATC","ATA","ATG","GTG");
}

#Codi genetic per mitocondries de llevats
sub mtYeast {	#transl_table=3
  print "Es traduirà segons el genoma mitocondrial de llevats\n\n";
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
  print "Es traduirà segons el genoma de micoplasmes/spiroplasmes i de mitocondris de molses, protozous i colenterats\n\n";
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTA","TTG","CTG","ATT","ATC","ATA","ATG","GTG");
}

#Codi genetic per mitocondries d'invertebrats
sub mtInvertebrate{	#transl_table=5
  print "Es traduirà segons el genoma mitocondral d'invertebrats\n\n";
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTG","ATT","ATC","ATA","ATG","GTG");
}

#The Ciliate, Dasycladacean and Hexamita Nuclear Code
sub Ciliate { #transl_table=6
  print "Es traduirà segons el genoma dels ciliats, dasicladacis i hexamites\n\n";
  $CodiGenetic{'TAA'} = 'Q';
  $CodiGenetic{'TAG'} = 'Q';
  @CodoInicial = ("ATG")
}

#The Echinoderm and mtFlatworm Mitochondrial Code
sub mtEchinoderm { #transl_table=9
  print "Es traduirà segons el genoma d'equinoderms i de mitocondris de plathielmints\n\n";
  $CodiGenetic{'AAA'} = 'N';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATG","CTG")
}

#Euplotid Nuclear Code
sub Euplotid { #transl_table=10
  print "Es traduirà segons el genoma dels euplòtids\n\n";
  $CodiGenetic{'TGA'} = 'C';
  @CodoInicial = ("ATG")
}

#Bacterial, Archaeal and Plant Plastid Code
sub Plastid { #transl_table=11
  print "Es traduirà segons el genoma de bacteris, arquees i plastos vegetals\n";
  @CodoInicial = ("TTG","CTG","ATT","ATC","ATA","ATG","GTG")
}

#Alternative Yeast Nuclear Code
sub AltYeast { #transl_table=12
  print "Es traduirà segons el genoma alternatiu de llevats\n\n";
  $CodiGenetic{'CTG'} = 'S';
  @CodoInicial = ("ATG","CTG")
}

#Codi genetic per mitocondris d'ascidis
sub mtAscidian{	#transl_table=13
  print "Es traduirà segons el genoma mitocondrial d'ascidis\n\n";
  $CodiGenetic{'AGA'} = 'G';
  $CodiGenetic{'AGG'} = 'G';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("TTG","ATA","ATG","GTG");
}

#Alternative mtFlatworm Mitochondrial Code
sub mtAltFlatworm { #transl_table=14
  print "Es traduirà segons el genoma mitocondrial alternatiu de plathielmints\n\n";
  $CodiGenetic{'AAA'} = 'N';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'TAA'} = 'Y';
  $CodiGenetic{'TGA'} = 'W';
  @CodoInicial = ("ATG")
}

#Blepharisma Nuclear Code
sub Blepharisma { #transl_table=15
  print "Es traduirà segons el genoma de blefarismes\n\n";
  $CodiGenetic{'TAG'} = 'Q';
  @CodoInicial = ("ATG")
}

#Chlorophycean Mitochondrial Code
sub mtChlorophycean { #transl_table=16
  print "Es traduirà segons el genoma mitocondrial de clorofícies\n\n";
  $CodiGenetic{'TAG'} = 'L';
  @CodoInicial = ("ATG")
}

#Trematode Mitochondrial Code
sub mtTrematode { #transl_table=21
  print "Es traduirà segons el genoma mitocondrial de tremàtodes\n\n";
  $CodiGenetic{'TGA'} = 'W';
  $CodiGenetic{'ATA'} = 'M';
  $CodiGenetic{'AGA'} = 'S';
  $CodiGenetic{'AGG'} = 'S';
  $CodiGenetic{'AAA'} = 'N';
  @CodoInicial = ("ATG","GTG")
}

#Scenedesmus obliquus mitochondrial Code
sub mtScenedesmus { #transl_table=22
  print "Es traduirà segons el genoma mitocondrial de Scenedesmus obliquus\n\n";
  $CodiGenetic{'TCA'} = '_';
  $CodiGenetic{'TAG'} = 'L';
  @CodoInicial = ("ATG")
}

#Thraustochytrium Mitochondrial Code
sub mtThraustochytrium { #transl_table=23
  print "Es traduirà segons el genoma mitocondrial de Thraustochytrium sp.\n\n";
  $CodiGenetic{'TTA'} = '_';
  @CodoInicial = ("ATG","ATT","GTG")
}

sub File2Line{
  $Line = ""; #Inicialitza la variable on guardarem la seqüència, per a cada volta del bucle
  $File = $_[0]; #Aquest es el fitxer d'on treurem la seqüència
  print "Llegint $File...\n";
  open(INPUT,"<","$File")|| return "False";  # Obre el fitxer d'entrada
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

sub recupera_ARGV{ #Funció per digerir els arguments
  $SIG{__WARN__}= sub {die "Opció incorrecta.\n$Usage";}; #Mor si hi ha opcions desconegudes
  GetOptions( #Implementa les diferents opcions
    'help|?',
    'transl_table=i' => \$transl_table,
    'translate=s' => \$translate,
    'output|save' => \$output_file
  );
  if($opt_help){ #Si ens demanen ajuda
    die $Usage; #Morim ajudant
  };
}

#Aqui ve un hash de funcions per a cridar a cada codi genètic per seu número de transl_table
%CodisGenetics = (
  "1"=>sub {print "" }, #Fer res, perquè és l'standard.
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

#Aquí comença l'execució

&recupera_ARGV; #Digereix els argument

eval{ #eval per morir si s'intenta fer servir una taula inexistent
  if($transl_table){
    $CodisGenetics{$transl_table}();
    $postfix = "_transl_table=$transl_table.txt"; #Si fem servir una taula no estàndard,  pot interessar reflectir-ho al nom del fitxer
  }
} or die "Número de taula de transcripció incorrecta\n$Usage";

if($translate){
  @Args = ($translate); #Si estem traduint directament un string, el que ens interessa està a $translate
}elsif (not(@ARGV)){ #Si no hi ha arguments, demana l'entrada manual d'una seq.
  print "Introduiu la seqüència de DNA d'un gen:\n";
  $escrita = <> ;
  chomp $escrita;
  @Args = $escrita;
  $translate = "1"; # A partir d'ara és com si fessim servir $translate
  $output_filename = "Manual_DNA_entry".$postfix; #Canviem el nom de fitxer, ja que no hi ha fitxer d'entrada
}else{
  @Args = @ARGV; #Si tenim arguments i no $translate, agafem arguments com a fitxers
}
foreach $argument (@Args){
  if($translate){ #Si $translate, no cal processar més $argument
    $output_filename = "DNA".$postfix;#Canviem el nom de fitxer, ja que no hi ha fitxer d'entrada
    $translatable=$argument;
  }else{
    $translatable=&File2Line($argument); #Passem el fitxer a string
  }
  $DNA = &DNAParser($translatable);  #Comprovem que sigui DNA gènic vàlid
  if($DNA eq "False"){#Si la cosa no surt be...
    print "Error: la seqüència introduïda no corresponia a un gen de DNA\n";
  }else{#Si surt be
    $Prot = &DNA2aa($DNA); #Traduim el DNA
    if($output_file){ #Si cal guardar-ho a un fitxer
      if ($output_filename eq ''){
	$output_filename = $argument.$postfix;
      }
      open (FITXER, '>', $output_filename); #No volem afegir coses al fitxer, sinó sobreescriure'l. Era bonic fer un fitxer amb l'output de la consola, pero és poc pràctic. És més útil fer un fitxer per cada seqncia proteica, que només tingui la cadena d'aminoàcids
      print FITXER $Prot."\n"; #Guarda la proteina resultant
      close (FITXER);
    }
  print "--------------------------------------------------------------------------------\n";
  print "Cadena original: $DNA\n\n";#Mostra la cadena original
  print "Cadena traduïda: $Prot\n"; #Mostra la proteina resultant
  print "--------------------------------------------------------------------------------\n";
  } 
}