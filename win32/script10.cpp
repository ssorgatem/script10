#include "script10.hpp"

namespace __script10__ {

str *const_0, *const_1, *const_10, *const_100, *const_101, *const_102, *const_103, *const_104, *const_105, *const_106, *const_107, *const_108, *const_109, *const_11, *const_110, *const_111, *const_112, *const_113, *const_114, *const_115, *const_116, *const_117, *const_118, *const_119, *const_12, *const_120, *const_121, *const_122, *const_123, *const_124, *const_125, *const_126, *const_127, *const_128, *const_13, *const_14, *const_15, *const_16, *const_17, *const_18, *const_19, *const_2, *const_20, *const_21, *const_22, *const_23, *const_24, *const_25, *const_26, *const_27, *const_28, *const_29, *const_3, *const_30, *const_31, *const_32, *const_33, *const_34, *const_35, *const_36, *const_37, *const_38, *const_39, *const_4, *const_40, *const_41, *const_42, *const_43, *const_44, *const_45, *const_46, *const_47, *const_48, *const_49, *const_5, *const_50, *const_51, *const_52, *const_53, *const_54, *const_55, *const_56, *const_57, *const_58, *const_59, *const_6, *const_60, *const_61, *const_62, *const_63, *const_64, *const_65, *const_66, *const_67, *const_68, *const_69, *const_7, *const_70, *const_71, *const_72, *const_73, *const_74, *const_75, *const_76, *const_77, *const_78, *const_79, *const_8, *const_80, *const_81, *const_82, *const_83, *const_84, *const_85, *const_86, *const_87, *const_88, *const_89, *const_9, *const_90, *const_91, *const_92, *const_93, *const_94, *const_95, *const_96, *const_97, *const_98, *const_99;

list<str *> *__6;
int __2, __3, __4, __5, __8, patro;
OSError *__exception;
tuple2<str *, str *> *CodoInicial;
str *Arg, *DNA, *FromFile, *Usage, *__name__, *escrita;
__iter<str *> *__7;
dict<str *, str *> *CodiGenetic;

void __init() {
    const_0 = new str("\303\232s:\nperl script10.pl [OPCIONS] ARXIU1 [ARXIU2] [ARXIU3] ...\nO b\303\251:\nperl script10.pl --translate SEQ\303\234\303\210NCIA1 [SEQ\303\234\303\210NCIA2] [SEQ\303\234\303\210NCIA3] ...\n\nPossibles opcions:\n\n--transl_table TRANS_TABLE\n\nEls valors de TRANSL_TABLE es poden trobar a http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi\n\nSi s'executa sense arguments, demanar\303\240 l'entrada manual de la seq\303\274\303\250ncia d'un gen");
    const_1 = new str("TCA");
    const_2 = new str("S");
    const_3 = new str("TCC");
    const_4 = new str("TCG");
    const_5 = new str("TCT");
    const_6 = new str("TTC");
    const_7 = new str("F");
    const_8 = new str("TTT");
    const_9 = new str("TTA");
    const_10 = new str("L");
    const_11 = new str("TTG");
    const_12 = new str("TAC");
    const_13 = new str("Y");
    const_14 = new str("TAT");
    const_15 = new str("TAA");
    const_16 = new str("_");
    const_17 = new str("TAG");
    const_18 = new str("TGC");
    const_19 = new str("C");
    const_20 = new str("TGT");
    const_21 = new str("TGA");
    const_22 = new str("TGG");
    const_23 = new str("W");
    const_24 = new str("CTA");
    const_25 = new str("CTC");
    const_26 = new str("CTG");
    const_27 = new str("CTT");
    const_28 = new str("CCA");
    const_29 = new str("P");
    const_30 = new str("CAT");
    const_31 = new str("H");
    const_32 = new str("CAA");
    const_33 = new str("Q");
    const_34 = new str("CAG");
    const_35 = new str("CGA");
    const_36 = new str("R");
    const_37 = new str("CGC");
    const_38 = new str("CGG");
    const_39 = new str("CGT");
    const_40 = new str("ATA");
    const_41 = new str("I");
    const_42 = new str("ATC");
    const_43 = new str("ATT");
    const_44 = new str("ATG");
    const_45 = new str("M");
    const_46 = new str("ACA");
    const_47 = new str("T");
    const_48 = new str("ACC");
    const_49 = new str("ACG");
    const_50 = new str("ACT");
    const_51 = new str("AAC");
    const_52 = new str("N");
    const_53 = new str("AAT");
    const_54 = new str("AAA");
    const_55 = new str("K");
    const_56 = new str("AAG");
    const_57 = new str("AGC");
    const_58 = new str("AGT");
    const_59 = new str("AGA");
    const_60 = new str("AGG");
    const_61 = new str("CCC");
    const_62 = new str("CCG");
    const_63 = new str("CCT");
    const_64 = new str("CAC");
    const_65 = new str("GTA");
    const_66 = new str("V");
    const_67 = new str("GTC");
    const_68 = new str("GTG");
    const_69 = new str("GTT");
    const_70 = new str("GCA");
    const_71 = new str("A");
    const_72 = new str("GCC");
    const_73 = new str("GCG");
    const_74 = new str("GCT");
    const_75 = new str("GAC");
    const_76 = new str("D");
    const_77 = new str("GAT");
    const_78 = new str("GAA");
    const_79 = new str("E");
    const_80 = new str("GAG");
    const_81 = new str("GGA");
    const_82 = new str("G");
    const_83 = new str("GGC");
    const_84 = new str("GGG");
    const_85 = new str("GGT");
    const_86 = new str("--transl_table");
    const_87 = new str("1");
    const_88 = new str("2");
    const_89 = new str("3");
    const_90 = new str("4");
    const_91 = new str("5");
    const_92 = new str("6");
    const_93 = new str("9");
    const_94 = new str("10");
    const_95 = new str("11");
    const_96 = new str("12");
    const_97 = new str("13");
    const_98 = new str("14");
    const_99 = new str("15");
    const_100 = new str("16");
    const_101 = new str("21");
    const_102 = new str("22");
    const_103 = new str("23");
    const_104 = new str("N\303\272mero de taula de transcripci\303\263 incorrecte\n$Usage");
    const_105 = new str("Introduiu la seq\303\274\303\250ncia de DNA d'un gen:");
    const_106 = new str("--translate");
    const_107 = new str("-h");
    const_108 = new str("--help");
    const_109 = new str("True");
    const_110 = new str("False");
    const_111 = new str("Error: la seq\303\274\303\250ncia introdu\303\257da no corresponia a un gen de DNA");
    const_112 = new str("Cadena tradu\303\257da: ");
    const_113 = new str("-");
    const_114 = new str("");
    const_115 = new str("Llegint ");
    const_116 = new str("... ");
    const_117 = new str("rb");
    const_118 = new str("\n");
    const_119 = new str("seq\303\274\303\250ncia incompleta! No \303\251s m\303\272ltiple de 3\nAbortant...");
    const_120 = new str("[^A^C^T^G]");
    const_121 = new str("La seq\303\274\303\250ncia no est\303\241 formada nom\303\251s per A,T,C o G, abortant");
    const_122 = new str("El cod\303\263 inicial PrimerCodo no \303\251s un cod\303\263 d'inici!");
    const_123 = new str("El cod\303\263 final ");
    const_124 = new str(" no \303\251s un cod\303\263 de stop!");
    const_125 = new str("\nCadena de DNA: ");
    const_126 = new str("Cod\303\263 desconegut:");
    const_127 = new str("!");
    const_128 = new str("?");

    __name__ = new str("__main__");

    Usage = const_0;
    patro = 0;
    CodiGenetic = (new dict<str *, str *>(64, new tuple2<str *, str *>(2,const_1,const_2), new tuple2<str *, str *>(2,const_3,const_2), new tuple2<str *, str *>(2,const_4,const_2), new tuple2<str *, str *>(2,const_5,const_2), new tuple2<str *, str *>(2,const_6,const_7), new tuple2<str *, str *>(2,const_8,const_7), new tuple2<str *, str *>(2,const_9,const_10), new tuple2<str *, str *>(2,const_11,const_10), new tuple2<str *, str *>(2,const_12,const_13), new tuple2<str *, str *>(2,const_14,const_13), new tuple2<str *, str *>(2,const_15,const_16), new tuple2<str *, str *>(2,const_17,const_16), new tuple2<str *, str *>(2,const_18,const_19), new tuple2<str *, str *>(2,const_20,const_19), new tuple2<str *, str *>(2,const_21,const_16), new tuple2<str *, str *>(2,const_22,const_23), new tuple2<str *, str *>(2,const_24,const_10), new tuple2<str *, str *>(2,const_25,const_10), new tuple2<str *, str *>(2,const_26,const_10), new tuple2<str *, str *>(2,const_27,const_10), new tuple2<str *, str *>(2,const_28,const_29), new tuple2<str *, str *>(2,const_30,const_31), new tuple2<str *, str *>(2,const_32,const_33), new tuple2<str *, str *>(2,const_34,const_33), new tuple2<str *, str *>(2,const_35,const_36), new tuple2<str *, str *>(2,const_37,const_36), new tuple2<str *, str *>(2,const_38,const_36), new tuple2<str *, str *>(2,const_39,const_36), new tuple2<str *, str *>(2,const_40,const_41), new tuple2<str *, str *>(2,const_42,const_41), new tuple2<str *, str *>(2,const_43,const_41), new tuple2<str *, str *>(2,const_44,const_45), new tuple2<str *, str *>(2,const_46,const_47), new tuple2<str *, str *>(2,const_48,const_47), new tuple2<str *, str *>(2,const_49,const_47), new tuple2<str *, str *>(2,const_50,const_47), new tuple2<str *, str *>(2,const_51,const_52), new tuple2<str *, str *>(2,const_53,const_52), new tuple2<str *, str *>(2,const_54,const_55), new tuple2<str *, str *>(2,const_56,const_55), new tuple2<str *, str *>(2,const_57,const_2), new tuple2<str *, str *>(2,const_58,const_2), new tuple2<str *, str *>(2,const_59,const_36), new tuple2<str *, str *>(2,const_60,const_36), new tuple2<str *, str *>(2,const_61,const_29), new tuple2<str *, str *>(2,const_62,const_29), new tuple2<str *, str *>(2,const_63,const_29), new tuple2<str *, str *>(2,const_64,const_31), new tuple2<str *, str *>(2,const_65,const_66), new tuple2<str *, str *>(2,const_67,const_66), new tuple2<str *, str *>(2,const_68,const_66), new tuple2<str *, str *>(2,const_69,const_66), new tuple2<str *, str *>(2,const_70,const_71), new tuple2<str *, str *>(2,const_72,const_71), new tuple2<str *, str *>(2,const_73,const_71), new tuple2<str *, str *>(2,const_74,const_71), new tuple2<str *, str *>(2,const_75,const_76), new tuple2<str *, str *>(2,const_77,const_76), new tuple2<str *, str *>(2,const_78,const_79), new tuple2<str *, str *>(2,const_80,const_79), new tuple2<str *, str *>(2,const_81,const_82), new tuple2<str *, str *>(2,const_83,const_82), new tuple2<str *, str *>(2,const_84,const_82), new tuple2<str *, str *>(2,const_85,const_82)));
    CodoInicial = (new tuple2<str *, str *>(3, const_44, const_11, const_26));
    if (__AND((len(__sys__::argv)>2), __eq((__sys__::argv)->__getfast__(1), const_86), 2)) {
        if (__eq((__sys__::argv)->__getfast__(2), const_87)) {
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_88)) {
            mtVertebrate();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_89)) {
            mtYeast();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_90)) {
            Mycoplasma();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_91)) {
            mtInvertebrate();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_92)) {
            Ciliate();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_93)) {
            mtEchinoderm();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_94)) {
            Euplotid();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_95)) {
            Plastid();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_96)) {
            AltYeast();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_97)) {
            mtAscidian();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_98)) {
            Flatworm();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_99)) {
            Blepharisma();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_100)) {
            mtChlorophycean();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_101)) {
            mtTrematode();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_102)) {
            mtScenedesmus();
        }
        else if (__eq((__sys__::argv)->__getfast__(2), const_103)) {
            mtThrau();
        }
        else {
            print(1, const_104);
            __ss_exit(1);
        }
        __sys__::argv = (__sys__::argv)->__slice__(1, 2, 0, 0);
    }

    while ((len(__sys__::argv)<2)) {
        escrita = raw_input(const_105);
        __sys__::argv = (new list<str *>(3, (__sys__::argv)->__getfast__(0), const_106, escrita));
    }
    if (__OR(__eq((__sys__::argv)->__getfast__(1), const_107), __eq((__sys__::argv)->__getfast__(1), const_108), 4)) {
        print(1, Usage);
        __ss_exit(1);
    }
    else {
        FromFile = const_109;

        FOR_IN_SEQ(Arg,(__sys__::argv)->__slice__(1, 1, 0, 0),6,8)
            if (__eq(Arg, const_106)) {
                FromFile = const_110;
                continue;
            }
            if (__eq(FromFile, const_110)) {
                DNA = DNAParser(Arg);
            }
            else {
                DNA = DNAParser(File2Line(Arg));
            }
            if (__eq(DNA, const_110)) {
                print(1, const_111);
            }
            else {
                print(1, (const_112)->__add__(DNA2aa(DNA)));
            }
        END_FOR

    }
}

void *mtVertebrate() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_59, const_16);
    CodiGenetic->__setitem__(const_60, const_16);
    CodiGenetic->__setitem__(const_40, const_45);
    CodiGenetic->__setitem__(const_21, const_23);
    CodoInicial = (new tuple2<str *, str *>(5, const_43, const_42, const_40, const_44, const_68));
    return NULL;
}

void *mtYeast() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_40, const_45);
    CodiGenetic->__setitem__(const_27, const_47);
    CodiGenetic->__setitem__(const_25, const_47);
    CodiGenetic->__setitem__(const_24, const_47);
    CodiGenetic->__setitem__(const_26, const_47);
    CodiGenetic->__setitem__(const_21, const_23);
    CodiGenetic->__setitem__(const_35, const_113);
    CodiGenetic->__setitem__(const_37, const_113);
    CodoInicial = (new tuple2<str *, str *>(2, const_40, const_44));
    return NULL;
}

void *Mycoplasma() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_21, const_23);
    CodoInicial = (new tuple2<str *, str *>(8, const_9, const_11, const_26, const_43, const_42, const_40, const_44, const_68));
    return NULL;
}

void *mtInvertebrate() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_59, const_2);
    CodiGenetic->__setitem__(const_60, const_2);
    CodiGenetic->__setitem__(const_40, const_45);
    CodiGenetic->__setitem__(const_21, const_23);
    CodoInicial = (new tuple2<str *, str *>(6, const_11, const_43, const_42, const_40, const_44, const_68));
    return NULL;
}

void *Ciliate() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_15, const_33);
    CodiGenetic->__setitem__(const_17, const_33);
    CodoInicial = const_44;
    return NULL;
}

void *mtEchinoderm() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_54, const_52);
    CodiGenetic->__setitem__(const_59, const_2);
    CodiGenetic->__setitem__(const_60, const_2);
    CodiGenetic->__setitem__(const_21, const_23);
    CodoInicial = (new tuple2<str *, str *>(2, const_44, const_26));
    return NULL;
}

void *Euplotid() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_21, const_19);
    CodoInicial = const_44;
    return NULL;
}

void *Plastid() {
    tuple2<str *, str *> *CodoInicial;

    CodoInicial = (new tuple2<str *, str *>(7, const_11, const_26, const_43, const_42, const_40, const_44, const_68));
    return NULL;
}

void *AltYeast() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_26, const_2);
    CodoInicial = (new tuple2<str *, str *>(2, const_44, const_26));
    return NULL;
}

void *mtAscidian() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_59, const_82);
    CodiGenetic->__setitem__(const_60, const_82);
    CodiGenetic->__setitem__(const_40, const_45);
    CodiGenetic->__setitem__(const_21, const_23);
    CodoInicial = (new tuple2<str *, str *>(4, const_11, const_40, const_44, const_68));
    return NULL;
}

void *Flatworm() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_54, const_52);
    CodiGenetic->__setitem__(const_59, const_2);
    CodiGenetic->__setitem__(const_60, const_2);
    CodiGenetic->__setitem__(const_15, const_13);
    CodiGenetic->__setitem__(const_21, const_23);
    CodoInicial = const_44;
    return NULL;
}

void *Blepharisma() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_17, const_33);
    CodoInicial = const_44;
    return NULL;
}

void *mtChlorophycean() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_17, const_10);
    CodoInicial = const_44;
    return NULL;
}

void *mtTrematode() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_21, const_23);
    CodiGenetic->__setitem__(const_40, const_45);
    CodiGenetic->__setitem__(const_59, const_2);
    CodiGenetic->__setitem__(const_60, const_2);
    CodiGenetic->__setitem__(const_54, const_52);
    CodoInicial = (new tuple2<str *, str *>(2, const_44, const_68));
    return NULL;
}

void *mtScenedesmus() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_1, const_16);
    CodiGenetic->__setitem__(const_17, const_10);
    CodoInicial = const_44;
    return NULL;
}

void *mtThrau() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_9, const_16);
    CodoInicial = (new tuple2<str *, str *>(3, const_44, const_43, const_68));
    return NULL;
}

str *File2Line(str *File) {
    str *Line;
    file *INPUT;

    Line = const_114;
    printc(1, __add_strs(3, const_115, File, const_116));
    try {
        INPUT = open(File, const_117);
        Line = (INPUT->read())->replace(const_118, const_114);
        INPUT->close();
        return Line;
    } catch (Exception *) {
        return const_110;
    }
    return 0;
}

str *DNAParser(str *RawSeq) {
    str *PrimerCodo;
    int SeqLen;

    RawSeq = RawSeq->upper();
    SeqLen = len(RawSeq);
    PrimerCodo = RawSeq->__slice__(2, 0, 3, 0);
    if ((__mods(SeqLen, 3)!=0)) {
        print(1, const_119);
        return const_110;
    }
    else if (___bool(__re__::search(const_120, RawSeq))) {
        print(1, repr(RawSeq));
        print(1, __re__::search(const_120, RawSeq));
        print(1, const_121);
        return const_110;
    }
    else if ((!CodoInicial->__contains__(PrimerCodo))) {
        print(1, const_122);
        return const_110;
    }
    else if (__ne(CodiGenetic->__getitem__(RawSeq->__slice__(1, (-3), 0, 0)), const_16)) {
        print(1, __add_strs(3, const_123, RawSeq->__slice__(1, (-3), 0, 0), const_124));
        return const_110;
    }
    else {
        print(1, (const_125)->__add__(RawSeq));
        return RawSeq;
    }
    return 0;
}

str *DNA2aa(str *DNA) {
    str *Proteina, *aa, *codon;
    int DnaLen, __0, __1, pos;

    DnaLen = len(DNA);
    Proteina = const_114;

    FAST_FOR(pos,patro,DnaLen,(+3),0,1)
        codon = DNA->__slice__(3, pos, (pos+3), 0);
        aa = CodiGenetic->__getitem__(codon);
        if (__eq(aa, const_16)) {
            break;
        }
        else if (__eq(aa, const_114)) {
            print(1, __add_strs(3, const_126, codon, const_127));
            aa = const_128;
        }
        else {
            Proteina = Proteina->__iadd__(aa);
        }
    END_FOR

    print(0);
    return Proteina;
}

} // module namespace

int main(int argc, char **argv) {
    __shedskin__::__init();
    __re__::__init();
    __sys__::__init(argc, argv);
    __script10__::__init();
    __shedskin__::__exit();
}
