#!/usr/bin/env python
# -*- coding: utf-8 -*-
#Script per a traduir una seqüència de DNA a proteines, comprobant que sigui DNA i que tingui els codons necesaris
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>

import re,sys,getopt

#Comencem a definir coses
Usage = "Ús:\npython script10.py [OPCIONS] ARXIU1 [ARXIU2] [ARXIU3] ...\nO bé:\npython script10.py --translate SEQÜÈNCIA1 [SEQÜÈNCIA2] [SEQÜÈNCIA3] ...\n\nPossibles opcions:\n\n--transl_table TRANS_TABLE\n\nEls valors de TRANSL_TABLE es poden trobar a http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi\n\nSi s'executa sense arguments, demanarà l'entrada manual de la seqüència d'un gen" #Missatge d'ajuda per a l'ús de l'script
patro = 0 #Posició des d'on començar a llegir la cadena de DNA. Pot ser 0, 1 o 2. No gaire útil, per ara.
transl_table='1' #Declaració de la variable per la taula de traducció del DNA

#Codi genetic estandard
CodiGenetic = { #Fem un Hash enmagatzemant el codi genetic
  'TCA':'S', #Serine
  'TCC':'S', #Serine
  'TCG':'S', #Serine
  'TCT':'S', #Serine
  'TTC':'F', #Phenylalanine
  'TTT':'F', #Phenylalanine
  'TTA':'L', #Leucine
  'TTG':'L', #Leucine
  'TAC':'Y', #Tyrosine
  'TAT':'Y', #Tyrosine
  'TAA':'_', #Stop
  'TAG':'_', #Stop
  'TGC':'C', #Cysteine
  'TGT':'C', #Cysteine
  'TGA':'_', #Stop
  'TGG':'W', #Tryptophan
  'CTA':'L', #Leucine
  'CTC':'L', #Leucine
  'CTG':'L', #Leucine
  'CTT':'L', #Leucine
  'CCA':'P', #Proline
  'CAT':'H', #Histidine
  'CAA':'Q', #Glutamine
  'CAG':'Q', #Glutamine
  'CGA':'R', #Arginine
  'CGC':'R', #Arginine
  'CGG':'R', #Arginine
  'CGT':'R', #Arginine
  'ATA':'I', #Isoleucine
  'ATC':'I', #Isoleucine
  'ATT':'I', #Isoleucine
  'ATG':'M', #Methionine
  'ACA':'T', #Threonine
  'ACC':'T', #Threonine
  'ACG':'T', #Threonine
  'ACT':'T', #Threonine
  'AAC':'N', #Asparagine
  'AAT':'N', #Asparagine
  'AAA':'K', #Lysine
  'AAG':'K', #Lysine
  'AGC':'S', #Serine
  'AGT':'S', #Serine
  'AGA':'R', #Arginine
  'AGG':'R', #Arginine
  'CCC':'P', #Proline
  'CCG':'P', #Proline
  'CCT':'P', #Proline
  'CAC':'H', #Histidine
  'GTA':'V', #Valine
  'GTC':'V', #Valine
  'GTG':'V', #Valine
  'GTT':'V', #Valine
  'GCA':'A', #Alanine
  'GCC':'A', #Alanine
  'GCG':'A', #Alanine
  'GCT':'A', #Alanine
  'GAC':'D', #Aspartic Acid
  'GAT':'D', #Aspartic Acid
  'GAA':'E', #Glutamic Acid
  'GAG':'E', #Glutamic Acid
  'GGA':'G', #Glycine
  'GGC':'G', #Glycine
  'GGG':'G', #Glycine
  'GGT':'G', #Glycine
}

CodoInicial = ("ATG","TTG","CTG")#Array dels codons inicials del codi genètic estàndard

#Diferents codis genetics estrests de: http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi?mode=t#SG3

#Codi genetic per mitocondries de vertebrats
def mtVertebrate():	#transl_table=2
  CodiGenetic['AGA'] = '_'
  CodiGenetic['AGG'] = '_'
  CodiGenetic['ATA'] = 'M'
  CodiGenetic['TGA'] = 'W'
  CodoInicial = ("ATT","ATC","ATA","ATG","GTG")

#Codi genetic per mitocondries de llevats
def mtYeast():	#transl_table=3
  CodiGenetic['ATA'] = 'M'
  CodiGenetic['CTT'] = 'T'
  CodiGenetic['CTC'] = 'T'
  CodiGenetic['CTA'] = 'T'
  CodiGenetic['CTG'] = 'T'
  CodiGenetic['TGA'] = 'W'
  CodiGenetic['CGA'] = '-'#Absent
  CodiGenetic['CGC'] = '-'#Absent
  CodoInicial = ("ATA","ATG")


#Codi genetic per micoplasmes/spiroplames i mitocondries de molses, protozous, colenterats
def Mycoplasma():	#transl_table=4
  CodiGenetic['TGA'] = 'W'
  CodoInicial = ("TTA","TTG","CTG","ATT","ATC","ATA","ATG","GTG")

#Codi genetic per mitocondries d'invertebrats
def mtInvertebrate():	#transl_table=5
  CodiGenetic['AGA'] = 'S'
  CodiGenetic['AGG'] = 'S'
  CodiGenetic['ATA'] = 'M'
  CodiGenetic['TGA'] = 'W'
  CodoInicial = ("TTG","ATT","ATC","ATA","ATG","GTG")

#The Ciliate, Dasycladacean and Hexamita Nuclear Code
def Ciliate(): #transl_table=6
  CodiGenetic['TAA'] = 'Q'
  CodiGenetic['TAG'] = 'Q'
  CodoInicial = ("ATG")

#The Echinoderm and Flatworm Mitochondrial Code
def mtEchinoderm(): #transl_table=9
  CodiGenetic['AAA'] = 'N'
  CodiGenetic['AGA'] = 'S'
  CodiGenetic['AGG'] = 'S'
  CodiGenetic['TGA'] = 'W'
  CodoInicial = ("ATG","CTG")

#Euplotid Nuclear Code
def Euplotid(): #transl_table=10
  CodiGenetic['TGA'] = 'C'
  CodoInicial = ("ATG")

#Bacterial, Archaeal and Plant Plastid Code
def Plastid(): #transl_table=11
  CodoInicial = ("TTG","CTG","ATT","ATC","ATA","ATG","GTG")

#Alternative Yeast Nuclear Code
def AltYeast(): #transl_table=12
  CodiGenetic['CTG'] = 'S'
  CodoInicial = ("ATG","CTG")

#Codi genetic per mitocondris d'ascidis
def mtAscidian():	#transl_table=13
  CodiGenetic['AGA'] = 'G'
  CodiGenetic['AGG'] = 'G'
  CodiGenetic['ATA'] = 'M'
  CodiGenetic['TGA'] = 'W'
  CodoInicial = ("TTG","ATA","ATG","GTG")

#Alternative Flatworm Mitochondrial Code
def mtFlatworm(): #transl_table=14
  CodiGenetic['AAA'] = 'N'
  CodiGenetic['AGA'] = 'S'
  CodiGenetic['AGG'] = 'S'
  CodiGenetic['TAA'] = 'Y'
  CodiGenetic['TGA'] = 'W'
  CodoInicial = ("ATG")

#Blepharisma Nuclear Code
def Blepharisma(): #transl_table=15
  CodiGenetic['TAG'] = 'Q'
  CodoInicial = ("ATG")

#Chlorophycean Mitochondrial Code
def mtChlorophycean(): #transl_table=16
  CodiGenetic['TAG'] = 'L'
  CodoInicial = ("ATG")

#Trematode Mitochondrial Code
def mtTrematode(): #transl_table=21
  CodiGenetic['TGA'] = 'W'
  CodiGenetic['ATA'] = 'M'
  CodiGenetic['AGA'] = 'S'
  CodiGenetic['AGG'] = 'S'
  CodiGenetic['AAA'] = 'N'
  CodoInicial = ("ATG","GTG")

#Scenedesmus obliquus mitochondrial Code
def mtScenedesmus(): #transl_table=22
  CodiGenetic['TCA'] = '_'
  CodiGenetic['TAG'] = 'L'
  CodoInicial = ("ATG")

#Thraustochytrium Mitochondrial Code
def mtThraustochytrium(): #transl_table=23
  CodiGenetic['TTA'] = '_'
  CodoInicial = ("ATG","ATT","GTG")

def foo():
  print

CodisGenetics = {
  "1":foo,
  "2":mtVertebrate,
  "3":mtYeast,
  "4":Mycoplasma,
  "5":mtInvertebrate,
  "6":Ciliate,
  "9":mtEchinoderm,
  "10":Euplotid,
  "11":Plastid,
  "12":AltYeast,
  "13":mtAscidian,
  "14":mtFlatworm,
  "15":Blepharisma,
  "16":mtChlorophycean,
  "21":mtTrematode,
  "22":mtScenedesmus,
  "23":mtThraustochytrium,
}

def File2Line(File):
  Line = "" #Inicialitza la variable on guardarem la seqüència, per a cada volta del bucle
  print "Llegint " + File + "... ",
  try:
    INPUT = open(File,"rb") # Obre el fitxer d'entrada
    Line = INPUT.read().replace("\n","") #Afegim la linia a la cadena
    INPUT.close() #Tanquem el fitxer, ja no el necessitem obert
    return Line
  except:
    return "False"

def DNAParser(RawSeq): # Subrutina que procesa i valida la seqüència d'entrada
  #Ara toca començar-ne el procesament
  RawSeq = RawSeq.upper() #Passem a majúscules
  SeqLen = len(RawSeq)#Calculem la longitud de la cadena
  PrimerCodo = RawSeq[:3] #Llegim i enmagatzemem el primer codo per la seva posterior comprovació

  if SeqLen%3 != 0: #Comprovem si és divisible entre 3, i si no ho és abortem
    print "seqüència incompleta! No és múltiple de 3\nAbortant..."
    return "False"
  elif re.search("[^A^C^T^G]",RawSeq): #Ara busquem bases que no sigui(substr(RawSeq, $patro, 3))n A,C,G o T
    print repr(RawSeq)
    print re.search("[^A^C^T^G]",RawSeq)
    print "La seqüència no está formada només per A,T,C o G, abortant" #Si les trobem, no continuem
    return "False"
  elif PrimerCodo not in CodoInicial: #Comprovem que comenci per un codó d'inici
    print "El codó inicial PrimerCodo no és un codó d'inici!"#I si no ho fa, abortem
    return "False"
  elif CodiGenetic[RawSeq[-3:]] != "_": #Comprovem que acabi amb un codó de stop
    print "El codó final "+RawSeq[-3:]+" no és un codó de stop!"#I si no ho fa, abortem
    return "False"
  else: #Si no, seguim
    #Continuem...
    print "\nCadena de DNA: "+ RawSeq #Mostrem el contingut de la variable.
    return RawSeq

def DNA2aa(DNA): #Subrutina per a traduir la cadena de DNA prèviament validada i processada a aminoàcids
  DnaLen = len(DNA) #Quants nucleòtids tenim
  Proteina = "" #Inicialitzem la variable contenidora de la proteina
  for pos in xrange(patro,DnaLen,+3):#Bucle per a traduir els nucleotids de 3 en 3
    codon = DNA[pos:pos+3]#agafa els 3 nucleòtids més a l'esquerra que no hem llegit encara
    aa = CodiGenetic[codon] #Tradueix el codó
    if aa == '_': #Si es un stop, atura
      break #Finalitza aquí el bucle
    elif aa == '':#Això no hauria de passar, però si trobem un codó que no es contempla al codi genètic...(segurament per culpa d'un bug) 
      print "Codó desconegut:" + codon +"!"
      aa = "?" #Queixem-nos i posem un interrogant a la proteina
    else:#Si no, guardem l'aminoàcid a la variable $Proteina
      Proteina += aa  
  print
  return Proteina #Retornem la proteina

#Aquí comença l'execució

try:
  opts, args = getopt.getopt(sys.argv[1:], "h?", ["help","translate", "transl_table="])
except getopt.GetoptError, err:
  print str(err)
  print Usage
  exit(1)

FromFile = "True"

for o, a in opts:
  if o in ["-h","--help","-?"]:
    print Usage
    exit(0)
  elif o == "--translate":
    FromFile = "False"
  elif o in "--transl_table":
    transl_table = a
    try:
      CodisGenetics[transl_table]()
    except Exception,e:
      print str(e)
      print "Número de taula de transcripció incorrecte\n" #Número desconegut == morir
      print Usage
      exit(1)
  else:
    print "Unknown option " + o
    exit(1)

while len(args) < 1:
  FromFile = "False"
  escrita = raw_input("Introduiu la seqüència de DNA d'un gen:")
  args = [sys.argv[0],"--translate", escrita]

for Arg in args: #Bucle per a dur a terme les operacions sobre tots els fitxers passats com a arguments
  if FromFile == "False":
    DNA = DNAParser(Arg)#Usa directament la seqüència des de l'argument, sense obrir un fitxer
  else:
    DNA = DNAParser(File2Line(Arg))#Cridem a la subrutina DNAParser, i el que retorna ho passem com a argument a la subrutina DNA2aa, que retornarà la proteina si tot va bé  
  if DNA == "False":
    print "Error: la seqüència introduïda no corresponia a un gen de DNA"
  else:
    print "Cadena traduïda: " + DNA2aa(DNA) #Tradueix i mostra la proteina resultant