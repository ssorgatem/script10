#ifndef __SCRIPT10_HPP
#define __SCRIPT10_HPP

#include "os/path.hpp"
#include "getopt.hpp"
#include "script10.hpp"
#include "sys.hpp"
#include "re.hpp"
#include "stat.hpp"
#include "builtin.hpp"
#include "os/__init__.hpp"

using namespace __shedskin__;
namespace __script10__ {

extern str *const_0, *const_1, *const_10, *const_100, *const_101, *const_102, *const_103, *const_104, *const_105, *const_106, *const_107, *const_108, *const_109, *const_11, *const_110, *const_111, *const_112, *const_113, *const_114, *const_115, *const_116, *const_117, *const_118, *const_119, *const_12, *const_120, *const_121, *const_122, *const_123, *const_124, *const_125, *const_126, *const_127, *const_128, *const_129, *const_13, *const_130, *const_131, *const_132, *const_133, *const_134, *const_14, *const_15, *const_16, *const_17, *const_18, *const_19, *const_2, *const_20, *const_21, *const_22, *const_23, *const_24, *const_25, *const_26, *const_27, *const_28, *const_29, *const_3, *const_30, *const_31, *const_32, *const_33, *const_34, *const_35, *const_36, *const_37, *const_38, *const_39, *const_4, *const_40, *const_41, *const_42, *const_43, *const_44, *const_45, *const_46, *const_47, *const_48, *const_49, *const_5, *const_50, *const_51, *const_52, *const_53, *const_54, *const_55, *const_56, *const_57, *const_58, *const_59, *const_6, *const_60, *const_61, *const_62, *const_63, *const_64, *const_65, *const_66, *const_67, *const_68, *const_69, *const_7, *const_70, *const_71, *const_72, *const_73, *const_74, *const_75, *const_76, *const_77, *const_78, *const_79, *const_8, *const_80, *const_81, *const_82, *const_83, *const_84, *const_85, *const_86, *const_87, *const_88, *const_89, *const_9, *const_90, *const_91, *const_92, *const_93, *const_94, *const_95, *const_96, *const_97, *const_98, *const_99;



typedef void *(*lambda14)();
typedef void *(*lambda8)();
typedef void *(*lambda17)(void *, void *, void *, void *, void *);
typedef void *(*lambda16)();
typedef void *(*lambda9)();
typedef void *(*lambda5)();
typedef void *(*lambda10)();
typedef void *(*lambda4)();
typedef void *(*lambda13)();
typedef void *(*lambda3)();
typedef void *(*lambda1)();
typedef void *(*lambda12)();
typedef void *(*lambda2)();
typedef void *(*lambda15)();
typedef void *(*lambda0)();
typedef void *(*lambda7)();
typedef void *(*lambda6)();
typedef void *(*lambda11)();

extern list<str *> *__7, *args;
extern dict<str *, lambda0> *CodisGenetics;
extern int __6, __9, patro;
extern tuple2<list<tuple2<str *, str *> *> *, list<str *> *> *__2;
extern OSError *__exception;
extern tuple2<str *, str *> *CodoInicial, *__3;
extern __iter<str *> *__8;
extern str *Arg, *DNA, *FromFile, *Usage, *__name__, *a, *escrita, *o, *transl_table;
extern list<tuple2<str *, str *> *> *__4, *opts;
extern dict<str *, str *> *CodiGenetic;
extern __iter<tuple2<str *, str *> *> *__5;

void *mtVertebrate();
void *mtYeast();
void *Mycoplasma();
void *mtInvertebrate();
void *Ciliate();
void *mtEchinoderm();
void *Euplotid();
void *Plastid();
void *AltYeast();
void *mtAscidian();
void *mtFlatworm();
void *Blepharisma();
void *mtChlorophycean();
void *mtTrematode();
void *mtScenedesmus();
void *mtThraustochytrium();
void *foo();
str *File2Line(str *File);
str *DNAParser(str *RawSeq);
str *DNA2aa(str *DNA);

} // module namespace
#endif
