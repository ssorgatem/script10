CC=g++
CCFLAGS=-O2 -pipe -Wno-deprecated $(CPPFLAGS) -I. -IZ:/home/ssorgatem/Desktop/shedskin-0.3/shedskin/shedskin/lib
LFLAGS=-lgc -lpcre $(LDFLAGS)

.PHONY: all run full clean

all:	script10

run:	all
	./script10

full:
	shedskin script10; $(MAKE) run

CPPFILES=Z:/home/ssorgatem/Desktop/shedskin-0.3/shedskin/shedskin/lib/sys.cpp Z:/home/ssorgatem/Desktop/shedskin-0.3/shedskin/shedskin/lib/re.cpp Z:/home/ssorgatem/Desktop/shedskin-0.3/shedskin/shedskin/lib/builtin.cpp script10.cpp
HPPFILES=Z:/home/ssorgatem/Desktop/shedskin-0.3/shedskin/shedskin/lib/sys.hpp Z:/home/ssorgatem/Desktop/shedskin-0.3/shedskin/shedskin/lib/re.hpp Z:/home/ssorgatem/Desktop/shedskin-0.3/shedskin/shedskin/lib/builtin.hpp script10.hpp

script10:	$(CPPFILES) $(HPPFILES)
	$(CC) $(CCFLAGS) $(CPPFILES) $(LFLAGS) -o script10

clean:
	rm script10.exe
