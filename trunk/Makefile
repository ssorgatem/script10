CC=g++
CCFLAGS=-O2 -pipe -Wno-deprecated $(CPPFLAGS) -I. -I/usr/lib/python2.5/site-packages/shedskin/lib
LFLAGS=-lgc -lpcre $(LDFLAGS) -lutil

.PHONY: all run full clean

all:	script10

run:	all
	./script10

full:
	shedskin script10; $(MAKE) run

CPPFILES=/usr/lib/python2.5/site-packages/shedskin/lib/stat.cpp script10.cpp /usr/lib/python2.5/site-packages/shedskin/lib/sys.cpp /usr/lib/python2.5/site-packages/shedskin/lib/re.cpp /usr/lib/python2.5/site-packages/shedskin/lib/builtin.cpp /usr/lib/python2.5/site-packages/shedskin/lib/getopt.cpp /usr/lib/python2.5/site-packages/shedskin/lib/os/__init__.cpp /usr/lib/python2.5/site-packages/shedskin/lib/os/path.cpp
HPPFILES=/usr/lib/python2.5/site-packages/shedskin/lib/stat.hpp script10.hpp /usr/lib/python2.5/site-packages/shedskin/lib/sys.hpp /usr/lib/python2.5/site-packages/shedskin/lib/re.hpp /usr/lib/python2.5/site-packages/shedskin/lib/builtin.hpp /usr/lib/python2.5/site-packages/shedskin/lib/getopt.hpp /usr/lib/python2.5/site-packages/shedskin/lib/os/__init__.hpp /usr/lib/python2.5/site-packages/shedskin/lib/os/path.hpp

script10:	$(CPPFILES) $(HPPFILES)
	$(CC) $(CCFLAGS) $(CPPFILES) $(LFLAGS) -o script10

clean:
	rm script10
