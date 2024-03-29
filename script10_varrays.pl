#!/usr/bin/perl -w
use Getopt::Long; #S'emprara la funció Getopt per recuperar els arguments de l'script
# Script per a traduir una seqüència de DNA a proteines, comprobant que sigui DNA i que tingui els codons necesaris
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>, David Carrasco Flores <noemseelteuemail@estudiants.urv.cat>

#####----------------------------------------START: Definició de variables----------------------------------------#####
  $Usage = "Ús:\n    perl script10.pl [OPCIONS] ARXIU1 [ARXIU2] [ARXIU3] ...\nO bé:\n    perl script10.pl --translate SEQÜÈNCIA1 [SEQÜÈNCIA2] [SEQÜÈNCIA3] ...\n\nPossibles opcions:\n\n    --transl_table TRANS_TABLE\n      Els valors de TRANSL_TABLE es poden trobar a http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi\n\n    --output FILE\n\nSi s'executa sense arguments, demanarà l'entrada manual de la seqüència d'un gen\n"; #Missatge d'ajuda per a l'ús de l'script

  $patro = 0; #Posició des d'on començar a llegir la cadena de DNA. Pot ser 0, 1 o 2. No gaire útil, per ara.

  $transl_table=1; #Declaració de la variable per la taula de traducció del DNA

  @translate; #Array per les possibles cadenes de DNA a traduir

  $output_file='';

  $resultat='';
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

  #Diferents codis genetics estrests de: http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi?mode=t#SG3

  #Codi genetic per mitocondries de vertebrats
  sub mtVertebrate{	#transl_table=2
    $resultat=($resultat,"Es traduirà segons el genoma mitocondrial de vertebrats\n\n");
    $CodiGenetic{'AGA'} = '_';
    $CodiGenetic{'AGG'} = '_';
    $CodiGenetic{'ATA'} = 'M';
    $CodiGenetic{'TGA'} = 'W';
    @CodoInicial = ("ATT","ATC","ATA","ATG","GTG");
  }

  #Codi genetic per mitocondries de llevats
  sub mtYeast {	#transl_table=3
    $resultat=($resultat,"Es traduirà segons el genoma mitocondrial de llevats\n\n");
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
    $resultat=($resultat,"Es traduirà segons el genoma de micoplasmes/spiroplasmes i de mitocondris de molses, protozous i colenterats\n\n");
    $CodiGenetic{'TGA'} = 'W';
    @CodoInicial = ("TTA","TTG","CTG","ATT","ATC","ATA","ATG","GTG");
  }

  #Codi genetic per mitocondries d'invertebrats
  sub mtInvertebrate{	#transl_table=5
    $resultat=($resultat,"Es traduirà segons el genoma mitocondral d'invertebrats\n\n");
    $CodiGenetic{'AGA'} = 'S';
    $CodiGenetic{'AGG'} = 'S';
    $CodiGenetic{'ATA'} = 'M';
    $CodiGenetic{'TGA'} = 'W';
    @CodoInicial = ("TTG","ATT","ATC","ATA","ATG","GTG");
  }

  #The Ciliate, Dasycladacean and Hexamita Nuclear Code
  sub Ciliate { #transl_table=6
    $resultat=($resultat,"Es traduirà segons el genoma dels ciliats, dasicladacis i hexamites\n\n");
    $CodiGenetic{'TAA'} = 'Q';
    $CodiGenetic{'TAG'} = 'Q';
    @CodoInicial = ("ATG")
  }

  #The Echinoderm and mtFlatworm Mitochondrial Code
  sub mtEchinoderm { #transl_table=9
    $resultat=($resultat,"Es traduirà segons el genoma d'equinoderms i de mitocondris de plathielmints\n\n");
    $CodiGenetic{'AAA'} = 'N';
    $CodiGenetic{'AGA'} = 'S';
    $CodiGenetic{'AGG'} = 'S';
    $CodiGenetic{'TGA'} = 'W';
    @CodoInicial = ("ATG","CTG")
  }

  #Euplotid Nuclear Code
  sub Euplotid { #transl_table=10
    $resultat=($resultat,"Es traduirà segons el genoma dels euplòtids\n\n");
    $CodiGenetic{'TGA'} = 'C';
    @CodoInicial = ("ATG")
  }

  #Bacterial, Archaeal and Plant Plastid Code
  sub Plastid { #transl_table=11
    $resultat=($resultat,"Es traduirà segons el genoma de bacteris, arquees i plastos vegetals\n\n");
    @CodoInicial = ("TTG","CTG","ATT","ATC","ATA","ATG","GTG")
  }

  #Alternative Yeast Nuclear Code
  sub AltYeast { #transl_table=12
    $resultat=($resultat,"Es traduirà segons el genoma alternatiu de llevats\n\n");
    $CodiGenetic{'CTG'} = 'S';
    @CodoInicial = ("ATG","CTG")
  }

  #Codi genetic per mitocondris d'ascidis
  sub mtAscidian{	#transl_table=13
    $resultat=($resultat,"Es traduirà segons el genoma mitocondrial d'ascidis\n\n");
    $CodiGenetic{'AGA'} = 'G';
    $CodiGenetic{'AGG'} = 'G';
    $CodiGenetic{'ATA'} = 'M';
    $CodiGenetic{'TGA'} = 'W';
    @CodoInicial = ("TTG","ATA","ATG","GTG");
  }

  #Alternative mtFlatworm Mitochondrial Code
  sub mtAltFlatworm { #transl_table=14
    $resultat=($resultat,"Es traduirà segons el genoma mitocondrial alternatiu de plathielmints\n\n");
    $CodiGenetic{'AAA'} = 'N';
    $CodiGenetic{'AGA'} = 'S';
    $CodiGenetic{'AGG'} = 'S';
    $CodiGenetic{'TAA'} = 'Y';
    $CodiGenetic{'TGA'} = 'W';
    @CodoInicial = ("ATG")
  }

  #Blepharisma Nuclear Code
  sub Blepharisma { #transl_table=15
    $resultat=($resultat,"Es traduirà segons el genoma de blefarismes\n\n");
    $CodiGenetic{'TAG'} = 'Q';
    @CodoInicial = ("ATG")
  }

  #Chlorophycean Mitochondrial Code
  sub mtChlorophycean { #transl_table=16
    $resultat=($resultat,"Es traduirà segons el genoma mitocondrial de clorofícies\n\n");
    $CodiGenetic{'TAG'} = 'L';
    @CodoInicial = ("ATG")
  }

  #Trematode Mitochondrial Code
  sub mtTrematode { #transl_table=21
    $resultat=($resultat,"Es traduirà segons el genoma mitocondrial de tremàtodes\n\n");
    $CodiGenetic{'TGA'} = 'W';
    $CodiGenetic{'ATA'} = 'M';
    $CodiGenetic{'AGA'} = 'S';
    $CodiGenetic{'AGG'} = 'S';
    $CodiGenetic{'AAA'} = 'N';
    @CodoInicial = ("ATG","GTG")
  }

  #Scenedesmus obliquus mitochondrial Code
  sub mtScenedesmus { #transl_table=22
    $resultat=($resultat,"Es traduirà segons el genoma mitocondrial de Scenedesmus obliquus\n\n");
    $CodiGenetic{'TCA'} = '_';
    $CodiGenetic{'TAG'} = 'L';
    @CodoInicial = ("ATG")
  }

  #Thraustochytrium Mitochondrial Code
  sub mtThraustochytrium { #transl_table=23
    $resultat=($resultat,"Es traduirà segons el genoma mitocondrial de Thraustochytrium sp.\n\n");
    $CodiGenetic{'TTA'} = '_';
    @CodoInicial = ("ATG","ATT","GTG")
  }

  #Hash que relaciona els valors de --transl_table amb els diversos codis genètics
  %CodisGenetics = (
    "1"=>sub {$resultat=$resultat . "Es traduirà segons el genoma estàndard\n\n";},
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
    $esInici = grep(/$PrimerCodo$/,@CodoInicial);#Comprovem que comenci per un codó d'inici

    if ( $SeqLen%3 != 0){ #Comprovem si és divisible entre 3, i si no ho és abortem
      return ["False","$RawSeq\nSeqüència incompleta! No és múltiple de 3\nAbortant..."];
    }elsif($RawSeq =~ /[^ACGT]/g){ #Ara busquem bases que no sigui(substr($RawSeq, $patro, 3))n A,C,G o T
      return ["False","$RawSeq\nLa seqüència no está formada només per A,T,C o G, abortant"]; #Si les trobem, no continuem
    }elsif(not($esInici)){ #Comprovem que comenci per un codó d'inici
      return ["False","$RawSeq\nEl codó inicial $PrimerCodo no és un codó d'inici!"];#I si no ho fa, abortem
    }elsif($CodiGenetic{(substr($RawSeq, $SeqLen-3, 3))} ne "_"){ #Comprovem que acabi amb un codó de stop
      return ["False","$RawSeq\nEl codó final ".(substr($RawSeq, $SeqLen-3, 3))." no és un codó de stop!"];#I si no ho fa, abortem
    }else{ #Si no, seguim
      return ["True",$RawSeq];
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
	print "Codó desconegut:$codon !\n";
	$aa = "?"; #Queixem-nos i posem un interrogant a la proteina
      }else{#Si no, guardem l'aminoàcid a la variable $Proteina
	$Proteina = $Proteina.$aa;
      }
    }
    print "\n";
    return $Proteina; #Retornem la proteina
  }

  sub recupera_ARGV{
    $SIG{__WARN__}= sub {die $Usage;};
    GetOptions(
      'help|?',
      'transl_table=i' => \$transl_table,
      'translate=s' => \@translate,
      'output=s' => \$output_file
    );
    if($opt_help){die $Usage;};
  }

#####----------------------------------------END: Definició de funcions de processament----------------------------------------#####

#####----------------------------------------START: Execució de l'script----------------------------------------#####

  #Recuperem els arguments establerts
  &recupera_ARGV;

  #Carreguem el codi genètic adient
  eval{
    $CodisGenetics{$transl_table}();
  } or die "Número de taula de transcripció incorrecta\n$Usage";

  #Avaluem l'origen de la seqüència de DNA
  if(@ARGV){
    #Si hem donat el nom d'algun(s) arxiu(s)
    foreach $ARGV(@ARGV){
      @translate=(@translate,[$ARGV,&File2Line($ARGV)]); #Afegeix el nom d'arxiu i la cadena a la matriu @translate mitjançant una matriu
    }
  }elsif(not @translate){
  #Si no hem afegit l'argument --translate <Codi DNA> ni cap arxiu
      print "Introduiu la seqüència de DNA d'un gen:\n";
      $escrita = <> ;
      chomp $escrita;
      @translate=$escrita;
  }

  foreach $cadena(@translate){ #Processem cadascuna de les entrades de @translate
    @DNA; #Array local que contindrà si és una cadena vàlida i la cadena/error
    if (@$cadena[1]){
      #Si és un array tindrà [0] el nom de l'arxiu i [1] el contingut
      $resultat=$resultat . "Fitxer d'origen: @$cadena[0]\n";
      $resultat=$resultat . "----------------------------------------\n";
      @DNA=@{DNAParser(@$cadena[1])}; #Desreferenciem la matriu resultant de la funció i l'emmagatzemem temporalment
    }else{
      #Si no es un array, per tant només és una cadena
      $resultat=$resultat . "----------------------------------------\n";
      @DNA=@{DNAParser($cadena)};
    }

    $resultat=$resultat . "Cadena de DNA: $DNA[1]\n";

    if($DNA[0] eq "True"){
      $resultat=$resultat . "\nProteïna: " . DNA2aa($DNA[1]) . "\n";
    }

    $resultat=$resultat . "----------------------------------------\n\n\n";
  }

  print $resultat; #Mostrem el resultat per pantalla
    
  if($output_file ne ''){ #Si la opció de desar en disc s'havia especificat, el desem
    open (FITXER, '>', $output_file);
    print FITXER $resultat;
    close (FITXER);
  }
#####----------------------------------------END: Execució de l'script----------------------------------------#####