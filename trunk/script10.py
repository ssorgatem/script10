#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Adrià Cereto Massagué <adrian.cereto@estudiants.urv.cat>
"""
Script per a traduir una seqüència de DNA a proteines, comprobant que sigui DNA i que tingui els codons necesaris
"""
import sys #Importem mòduls bàsics
#Comencem a definir coses
Usage = "Ús:\npython script10.py ARXIU1 [ARXIU2] [ARXIU3] ...\n" #Missatge d'ajuda per a l'ús de l'script

#Aquí comença l'execució
if "-h" in sys.argv or "--help" in sys.argv or sys.argv == [sys.argv[0]]: #Interceptem falta d'arguments o demanda d'ajuda
  print Usage
  exit(0)

for NumArgs in sys.argv[1:]:  #Bucle per a dur a terme les operacions sobre tots els fitxers passats com a arguments

  RawSeq = "" #Inicialitza la variable on guardarem la seqüència, per a cada volta del bucle
  InputFile = NumArgs
  
  INPUT = open(InputFile,"r")  # Obre el fitxer d'entrada
  RawSeq = INPUT.read().replace("\n","")
  INPUT.close() #Tanquem el fitxer, ja no el necessitem obert

  #Ara toca començar-ne el procesament
  RawSeq = RawSeq.upper() #Passem a majúscules
  
  SeqLen = len(RawSeq) #Calculem la longitud de la cadena

  if  SeqLen%3 != 0 : #Comprovem si és divisible entre 3, i si no ho és abortem
    print "Seqüència incompleta! No és múltiple de 3"
  else: 
    print "és múltiple de 3"
    print  RawSeq  #Mostrem el contingut de la variable.
    #Continuem...
  

