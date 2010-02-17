CC=g++
CCFLAGS=-O2 -pipe -Wno-deprecated $(CPPFLAGS) -I. -I/usr/lib/python2.5/site-packages/shedskin/lib
LFLAGS=-lgc -lpcre $(LDFLAGS)

.PHONY: all run full clean

all:	script10

run:	all
	./script10

full:
	shedskin script10; $(MAKE) run

CPPFILES=/usr/lib/python2.5/site-packages/shedskin/lib/sys.cpp /usr/lib/python2.5/site-packages/shedskin/lib/re.cpp /usr/lib/python2.5/site-packages/shedskin/lib/builtin.cpp script10.cpp
HPPFILES=/usr/lib/python2.5/site-packages/shedskin/lib/sys.hpp /usr/lib/python2.5/site-packages/shedskin/lib/re.hpp /usr/lib/python2.5/site-packages/shedskin/lib/builtin.hpp script10.hpp

script10:	$(CPPFILES) $(HPPFILES)
	$(CC) $(CCFLAGS) $(CPPFILES) $(LFLAGS) -o script10

clean:
	rm script10
