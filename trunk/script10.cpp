#include "script10.hpp"

namespace __script10__ {

str *const_0, *const_1, *const_10, *const_100, *const_101, *const_102, *const_103, *const_104, *const_105, *const_106, *const_107, *const_108, *const_109, *const_11, *const_110, *const_111, *const_112, *const_113, *const_114, *const_115, *const_116, *const_117, *const_118, *const_119, *const_12, *const_120, *const_121, *const_122, *const_123, *const_124, *const_125, *const_126, *const_127, *const_128, *const_129, *const_13, *const_130, *const_131, *const_132, *const_133, *const_134, *const_14, *const_15, *const_16, *const_17, *const_18, *const_19, *const_2, *const_20, *const_21, *const_22, *const_23, *const_24, *const_25, *const_26, *const_27, *const_28, *const_29, *const_3, *const_30, *const_31, *const_32, *const_33, *const_34, *const_35, *const_36, *const_37, *const_38, *const_39, *const_4, *const_40, *const_41, *const_42, *const_43, *const_44, *const_45, *const_46, *const_47, *const_48, *const_49, *const_5, *const_50, *const_51, *const_52, *const_53, *const_54, *const_55, *const_56, *const_57, *const_58, *const_59, *const_6, *const_60, *const_61, *const_62, *const_63, *const_64, *const_65, *const_66, *const_67, *const_68, *const_69, *const_7, *const_70, *const_71, *const_72, *const_73, *const_74, *const_75, *const_76, *const_77, *const_78, *const_79, *const_8, *const_80, *const_81, *const_82, *const_83, *const_84, *const_85, *const_86, *const_87, *const_88, *const_89, *const_9, *const_90, *const_91, *const_92, *const_93, *const_94, *const_95, *const_96, *const_97, *const_98, *const_99;

list<str *> *__7, *args;
dict<str *, lambda0> *CodisGenetics;
int __6, __9, patro;
tuple2<list<tuple2<str *, str *> *> *, list<str *> *> *__2;
OSError *__exception;
tuple2<str *, str *> *CodoInicial, *__3;
__iter<str *> *__8;
str *Arg, *DNA, *FromFile, *Usage, *__name__, *a, *escrita, *o, *transl_table;
list<tuple2<str *, str *> *> *__4, *opts;
dict<str *, str *> *CodiGenetic;
__iter<tuple2<str *, str *> *> *__5;

void __init() {
    const_0 = new str("\303\232s:\npython script10.py [OPCIONS] ARXIU1 [ARXIU2] [ARXIU3] ...\nO b\303\251:\npython script10.py --translate SEQ\303\234\303\210NCIA1 [SEQ\303\234\303\210NCIA2] [SEQ\303\234\303\210NCIA3] ...\n\nPossibles opcions:\n\n--transl_table TRANS_TABLE\n\nEls valors de TRANSL_TABLE es poden trobar a http://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi\n\nSi s'executa sense arguments, demanar\303\240 l'entrada manual de la seq\303\274\303\250ncia d'un gen");
    const_1 = new str("1");
    const_2 = new str("TCA");
    const_3 = new str("S");
    const_4 = new str("TCC");
    const_5 = new str("TCG");
    const_6 = new str("TCT");
    const_7 = new str("TTC");
    const_8 = new str("F");
    const_9 = new str("TTT");
    const_10 = new str("TTA");
    const_11 = new str("L");
    const_12 = new str("TTG");
    const_13 = new str("TAC");
    const_14 = new str("Y");
    const_15 = new str("TAT");
    const_16 = new str("TAA");
    const_17 = new str("_");
    const_18 = new str("TAG");
    const_19 = new str("TGC");
    const_20 = new str("C");
    const_21 = new str("TGT");
    const_22 = new str("TGA");
    const_23 = new str("TGG");
    const_24 = new str("W");
    const_25 = new str("CTA");
    const_26 = new str("CTC");
    const_27 = new str("CTG");
    const_28 = new str("CTT");
    const_29 = new str("CCA");
    const_30 = new str("P");
    const_31 = new str("CAT");
    const_32 = new str("H");
    const_33 = new str("CAA");
    const_34 = new str("Q");
    const_35 = new str("CAG");
    const_36 = new str("CGA");
    const_37 = new str("R");
    const_38 = new str("CGC");
    const_39 = new str("CGG");
    const_40 = new str("CGT");
    const_41 = new str("ATA");
    const_42 = new str("I");
    const_43 = new str("ATC");
    const_44 = new str("ATT");
    const_45 = new str("ATG");
    const_46 = new str("M");
    const_47 = new str("ACA");
    const_48 = new str("T");
    const_49 = new str("ACC");
    const_50 = new str("ACG");
    const_51 = new str("ACT");
    const_52 = new str("AAC");
    const_53 = new str("N");
    const_54 = new str("AAT");
    const_55 = new str("AAA");
    const_56 = new str("K");
    const_57 = new str("AAG");
    const_58 = new str("AGC");
    const_59 = new str("AGT");
    const_60 = new str("AGA");
    const_61 = new str("AGG");
    const_62 = new str("CCC");
    const_63 = new str("CCG");
    const_64 = new str("CCT");
    const_65 = new str("CAC");
    const_66 = new str("GTA");
    const_67 = new str("V");
    const_68 = new str("GTC");
    const_69 = new str("GTG");
    const_70 = new str("GTT");
    const_71 = new str("GCA");
    const_72 = new str("A");
    const_73 = new str("GCC");
    const_74 = new str("GCG");
    const_75 = new str("GCT");
    const_76 = new str("GAC");
    const_77 = new str("D");
    const_78 = new str("GAT");
    const_79 = new str("GAA");
    const_80 = new str("E");
    const_81 = new str("GAG");
    const_82 = new str("GGA");
    const_83 = new str("G");
    const_84 = new str("GGC");
    const_85 = new str("GGG");
    const_86 = new str("GGT");
    const_87 = new str("2");
    const_88 = new str("3");
    const_89 = new str("4");
    const_90 = new str("5");
    const_91 = new str("6");
    const_92 = new str("9");
    const_93 = new str("10");
    const_94 = new str("11");
    const_95 = new str("12");
    const_96 = new str("13");
    const_97 = new str("14");
    const_98 = new str("15");
    const_99 = new str("16");
    const_100 = new str("21");
    const_101 = new str("22");
    const_102 = new str("23");
    const_103 = new str("h?");
    const_104 = new str("help");
    const_105 = new str("translate");
    const_106 = new str("transl_table=");
    const_107 = new str("True");
    const_108 = new str("-h");
    const_109 = new str("--help");
    const_110 = new str("-?");
    const_111 = new str("--translate");
    const_112 = new str("False");
    const_113 = new str("--transl_table");
    const_114 = new str("N\303\272mero de taula de transcripci\303\263 incorrecte\n");
    const_115 = new str("Unknown option ");
    const_116 = new str("Introduiu la seq\303\274\303\250ncia de DNA d'un gen:");
    const_117 = new str("Error: la seq\303\274\303\250ncia introdu\303\257da no corresponia a un gen de DNA");
    const_118 = new str("Cadena tradu\303\257da: ");
    const_119 = new str("-");
    const_120 = new str("");
    const_121 = new str("Llegint ");
    const_122 = new str("... ");
    const_123 = new str("rb");
    const_124 = new str("\n");
    const_125 = new str("seq\303\274\303\250ncia incompleta! No \303\251s m\303\272ltiple de 3\nAbortant...");
    const_126 = new str("[^A^C^T^G]");
    const_127 = new str("La seq\303\274\303\250ncia no est\303\241 formada nom\303\251s per A,T,C o G, abortant");
    const_128 = new str("El cod\303\263 inicial PrimerCodo no \303\251s un cod\303\263 d'inici!");
    const_129 = new str("El cod\303\263 final ");
    const_130 = new str(" no \303\251s un cod\303\263 de stop!");
    const_131 = new str("\nCadena de DNA: ");
    const_132 = new str("Cod\303\263 desconegut:");
    const_133 = new str("!");
    const_134 = new str("?");

    __name__ = new str("__main__");

    Usage = const_0;
    patro = 0;
    transl_table = const_1;
    CodiGenetic = (new dict<str *, str *>(64, new tuple2<str *, str *>(2,const_2,const_3), new tuple2<str *, str *>(2,const_4,const_3), new tuple2<str *, str *>(2,const_5,const_3), new tuple2<str *, str *>(2,const_6,const_3), new tuple2<str *, str *>(2,const_7,const_8), new tuple2<str *, str *>(2,const_9,const_8), new tuple2<str *, str *>(2,const_10,const_11), new tuple2<str *, str *>(2,const_12,const_11), new tuple2<str *, str *>(2,const_13,const_14), new tuple2<str *, str *>(2,const_15,const_14), new tuple2<str *, str *>(2,const_16,const_17), new tuple2<str *, str *>(2,const_18,const_17), new tuple2<str *, str *>(2,const_19,const_20), new tuple2<str *, str *>(2,const_21,const_20), new tuple2<str *, str *>(2,const_22,const_17), new tuple2<str *, str *>(2,const_23,const_24), new tuple2<str *, str *>(2,const_25,const_11), new tuple2<str *, str *>(2,const_26,const_11), new tuple2<str *, str *>(2,const_27,const_11), new tuple2<str *, str *>(2,const_28,const_11), new tuple2<str *, str *>(2,const_29,const_30), new tuple2<str *, str *>(2,const_31,const_32), new tuple2<str *, str *>(2,const_33,const_34), new tuple2<str *, str *>(2,const_35,const_34), new tuple2<str *, str *>(2,const_36,const_37), new tuple2<str *, str *>(2,const_38,const_37), new tuple2<str *, str *>(2,const_39,const_37), new tuple2<str *, str *>(2,const_40,const_37), new tuple2<str *, str *>(2,const_41,const_42), new tuple2<str *, str *>(2,const_43,const_42), new tuple2<str *, str *>(2,const_44,const_42), new tuple2<str *, str *>(2,const_45,const_46), new tuple2<str *, str *>(2,const_47,const_48), new tuple2<str *, str *>(2,const_49,const_48), new tuple2<str *, str *>(2,const_50,const_48), new tuple2<str *, str *>(2,const_51,const_48), new tuple2<str *, str *>(2,const_52,const_53), new tuple2<str *, str *>(2,const_54,const_53), new tuple2<str *, str *>(2,const_55,const_56), new tuple2<str *, str *>(2,const_57,const_56), new tuple2<str *, str *>(2,const_58,const_3), new tuple2<str *, str *>(2,const_59,const_3), new tuple2<str *, str *>(2,const_60,const_37), new tuple2<str *, str *>(2,const_61,const_37), new tuple2<str *, str *>(2,const_62,const_30), new tuple2<str *, str *>(2,const_63,const_30), new tuple2<str *, str *>(2,const_64,const_30), new tuple2<str *, str *>(2,const_65,const_32), new tuple2<str *, str *>(2,const_66,const_67), new tuple2<str *, str *>(2,const_68,const_67), new tuple2<str *, str *>(2,const_69,const_67), new tuple2<str *, str *>(2,const_70,const_67), new tuple2<str *, str *>(2,const_71,const_72), new tuple2<str *, str *>(2,const_73,const_72), new tuple2<str *, str *>(2,const_74,const_72), new tuple2<str *, str *>(2,const_75,const_72), new tuple2<str *, str *>(2,const_76,const_77), new tuple2<str *, str *>(2,const_78,const_77), new tuple2<str *, str *>(2,const_79,const_80), new tuple2<str *, str *>(2,const_81,const_80), new tuple2<str *, str *>(2,const_82,const_83), new tuple2<str *, str *>(2,const_84,const_83), new tuple2<str *, str *>(2,const_85,const_83), new tuple2<str *, str *>(2,const_86,const_83)));
    CodoInicial = (new tuple2<str *, str *>(3, const_45, const_12, const_27));
    CodisGenetics = (new dict<str *, lambda0>(17, new tuple2<str *, lambda0>(2,const_1,foo), new tuple2<str *, lambda0>(2,const_87,mtVertebrate), new tuple2<str *, lambda0>(2,const_88,mtYeast), new tuple2<str *, lambda0>(2,const_89,Mycoplasma), new tuple2<str *, lambda0>(2,const_90,mtInvertebrate), new tuple2<str *, lambda0>(2,const_91,Ciliate), new tuple2<str *, lambda0>(2,const_92,mtEchinoderm), new tuple2<str *, lambda0>(2,const_93,Euplotid), new tuple2<str *, lambda0>(2,const_94,Plastid), new tuple2<str *, lambda0>(2,const_95,AltYeast), new tuple2<str *, lambda0>(2,const_96,mtAscidian), new tuple2<str *, lambda0>(2,const_97,mtFlatworm), new tuple2<str *, lambda0>(2,const_98,Blepharisma), new tuple2<str *, lambda0>(2,const_99,mtChlorophycean), new tuple2<str *, lambda0>(2,const_100,mtTrematode), new tuple2<str *, lambda0>(2,const_101,mtScenedesmus), new tuple2<str *, lambda0>(2,const_102,mtThraustochytrium)));
    try {
        __2 = __getopt__::getopt((__sys__::argv)->__slice__(1, 1, 0, 0), const_103, (new list<str *>(3, const_104, const_105, const_106)));
        opts = __2->__getfirst__();
        args = __2->__getsecond__();
    } catch (__getopt__::GetoptError *err) {
        print(1, __str(err));
        print(1, Usage);
        __ss_exit(1);
    }
    FromFile = const_107;

    FOR_IN_SEQ(__3,opts,4,6)
        __3 = __3;
        o = __3->__getfirst__();
        a = __3->__getsecond__();
        if (((new list<str *>(3, const_108, const_109, const_110)))->__contains__(o)) {
            print(1, Usage);
            __ss_exit(0);
        }
        else if (__eq(o, const_111)) {
            FromFile = const_112;
        }
        else if ((const_113)->__contains__(o)) {
            transl_table = a;
            try {
                CodisGenetics->__getitem__(transl_table)();
            } catch (Exception *e) {
                print(1, __str(e));
                print(1, const_114);
                print(1, Usage);
                __ss_exit(1);
            }
        }
        else {
            print(1, (const_115)->__add__(o));
            __ss_exit(1);
        }
    END_FOR


    while ((len(args)<1)) {
        FromFile = const_112;
        escrita = raw_input(const_116);
        args = (new list<str *>(3, (__sys__::argv)->__getfast__(0), const_111, escrita));
    }

    FOR_IN_SEQ(Arg,args,7,9)
        if (__eq(FromFile, const_112)) {
            DNA = DNAParser(Arg);
        }
        else {
            DNA = DNAParser(File2Line(Arg));
        }
        if (__eq(DNA, const_112)) {
            print(1, const_117);
        }
        else {
            print(1, (const_118)->__add__(DNA2aa(DNA)));
        }
    END_FOR

}

void *mtVertebrate() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_60, const_17);
    CodiGenetic->__setitem__(const_61, const_17);
    CodiGenetic->__setitem__(const_41, const_46);
    CodiGenetic->__setitem__(const_22, const_24);
    CodoInicial = (new tuple2<str *, str *>(5, const_44, const_43, const_41, const_45, const_69));
    return NULL;
}

void *mtYeast() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_41, const_46);
    CodiGenetic->__setitem__(const_28, const_48);
    CodiGenetic->__setitem__(const_26, const_48);
    CodiGenetic->__setitem__(const_25, const_48);
    CodiGenetic->__setitem__(const_27, const_48);
    CodiGenetic->__setitem__(const_22, const_24);
    CodiGenetic->__setitem__(const_36, const_119);
    CodiGenetic->__setitem__(const_38, const_119);
    CodoInicial = (new tuple2<str *, str *>(2, const_41, const_45));
    return NULL;
}

void *Mycoplasma() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_22, const_24);
    CodoInicial = (new tuple2<str *, str *>(8, const_10, const_12, const_27, const_44, const_43, const_41, const_45, const_69));
    return NULL;
}

void *mtInvertebrate() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_60, const_3);
    CodiGenetic->__setitem__(const_61, const_3);
    CodiGenetic->__setitem__(const_41, const_46);
    CodiGenetic->__setitem__(const_22, const_24);
    CodoInicial = (new tuple2<str *, str *>(6, const_12, const_44, const_43, const_41, const_45, const_69));
    return NULL;
}

void *Ciliate() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_16, const_34);
    CodiGenetic->__setitem__(const_18, const_34);
    CodoInicial = const_45;
    return NULL;
}

void *mtEchinoderm() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_55, const_53);
    CodiGenetic->__setitem__(const_60, const_3);
    CodiGenetic->__setitem__(const_61, const_3);
    CodiGenetic->__setitem__(const_22, const_24);
    CodoInicial = (new tuple2<str *, str *>(2, const_45, const_27));
    return NULL;
}

void *Euplotid() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_22, const_20);
    CodoInicial = const_45;
    return NULL;
}

void *Plastid() {
    tuple2<str *, str *> *CodoInicial;

    CodoInicial = (new tuple2<str *, str *>(7, const_12, const_27, const_44, const_43, const_41, const_45, const_69));
    return NULL;
}

void *AltYeast() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_27, const_3);
    CodoInicial = (new tuple2<str *, str *>(2, const_45, const_27));
    return NULL;
}

void *mtAscidian() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_60, const_83);
    CodiGenetic->__setitem__(const_61, const_83);
    CodiGenetic->__setitem__(const_41, const_46);
    CodiGenetic->__setitem__(const_22, const_24);
    CodoInicial = (new tuple2<str *, str *>(4, const_12, const_41, const_45, const_69));
    return NULL;
}

void *mtFlatworm() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_55, const_53);
    CodiGenetic->__setitem__(const_60, const_3);
    CodiGenetic->__setitem__(const_61, const_3);
    CodiGenetic->__setitem__(const_16, const_14);
    CodiGenetic->__setitem__(const_22, const_24);
    CodoInicial = const_45;
    return NULL;
}

void *Blepharisma() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_18, const_34);
    CodoInicial = const_45;
    return NULL;
}

void *mtChlorophycean() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_18, const_11);
    CodoInicial = const_45;
    return NULL;
}

void *mtTrematode() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_22, const_24);
    CodiGenetic->__setitem__(const_41, const_46);
    CodiGenetic->__setitem__(const_60, const_3);
    CodiGenetic->__setitem__(const_61, const_3);
    CodiGenetic->__setitem__(const_55, const_53);
    CodoInicial = (new tuple2<str *, str *>(2, const_45, const_69));
    return NULL;
}

void *mtScenedesmus() {
    str *CodoInicial;

    CodiGenetic->__setitem__(const_2, const_17);
    CodiGenetic->__setitem__(const_18, const_11);
    CodoInicial = const_45;
    return NULL;
}

void *mtThraustochytrium() {
    tuple2<str *, str *> *CodoInicial;

    CodiGenetic->__setitem__(const_10, const_17);
    CodoInicial = (new tuple2<str *, str *>(3, const_45, const_44, const_69));
    return NULL;
}

void *foo() {
    
    print(0);
    return NULL;
}

str *File2Line(str *File) {
    str *Line;
    file *INPUT;

    Line = const_120;
    printc(1, __add_strs(3, const_121, File, const_122));
    try {
        INPUT = open(File, const_123);
        Line = (INPUT->read())->replace(const_124, const_120);
        INPUT->close();
        return Line;
    } catch (Exception *) {
        return const_112;
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
        print(1, const_125);
        return const_112;
    }
    else if (___bool(__re__::search(const_126, RawSeq))) {
        print(1, repr(RawSeq));
        print(1, __re__::search(const_126, RawSeq));
        print(1, const_127);
        return const_112;
    }
    else if ((!CodoInicial->__contains__(PrimerCodo))) {
        print(1, const_128);
        return const_112;
    }
    else if (__ne(CodiGenetic->__getitem__(RawSeq->__slice__(1, (-3), 0, 0)), const_17)) {
        print(1, __add_strs(3, const_129, RawSeq->__slice__(1, (-3), 0, 0), const_130));
        return const_112;
    }
    else {
        print(1, (const_131)->__add__(RawSeq));
        return RawSeq;
    }
    return 0;
}

str *DNA2aa(str *DNA) {
    str *Proteina, *aa, *codon;
    int DnaLen, __0, __1, pos;

    DnaLen = len(DNA);
    Proteina = const_120;

    FAST_FOR(pos,patro,DnaLen,(+3),0,1)
        codon = DNA->__slice__(3, pos, (pos+3), 0);
        aa = CodiGenetic->__getitem__(codon);
        if (__eq(aa, const_17)) {
            break;
        }
        else if (__eq(aa, const_120)) {
            print(1, __add_strs(3, const_132, codon, const_133));
            aa = const_134;
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
    __stat__::__init();
    __os__::__path__::__init();
    __os__::__init();
    __getopt__::__init();
    __script10__::__init();
    __shedskin__::__exit();
}
