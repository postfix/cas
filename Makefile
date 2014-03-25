DEPEN_LIBCDS_INC=../libcds/includes/
DEPEN_LIBCDS=../libcds/lib/libcds.a

CC=g++

DEBUG_CFLAGS = -c -Wall -I$(DEPEN_LIBCDS_INC) -O0 -I../wtmatrix/  -g -DDEBUG 

EXPERIMENTS = -DEXPERIMENTS

CFLAGS=-c -Wall -I$(DEPEN_LIBCDS_INC) -O3 -I../wtmatrix/ 
LDFLAGS=-Wall $(DEPEN_LIBCDS) -lm ../wtmatrix/wavelet_matrix.o

EXT=

SOURCES=tgs.cpp arraysort.cpp
OBJECTS=$(SOURCES:.cpp=.o)

MAINSRC=use.cpp create.cpp benchmark.cpp getsize.cpp  text2adjacencybin.cpp
MAINOBJ=$(MAINSRC:.cpp=.o)

EXECUTABLE=create use benchmark getsize text2adjacencybin

#all: CFLAGS += -O9
all: $(SOURCES) $(MAINSRC) $(MAINOBJ) $(OBJECTS) $(EXECUTABLE) 

debug: CFLAGS = $(DEBUG_CFLAGS)
debug: clean all

experiments: CFLAGS += $(EXPERIMENTS)
experiments: clean all

#$(EXECUTABLE): $(MAINOBJ) $(OBJECTS)
#	$(CC) $(LDFLAGS) $(OBJECTS) $(DEPENOBJS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

clean: cleanobj cleanexe

cleanobj:
	rm -f $(OBJECTS) $(MAINOBJ)

cleanexe:
	rm -f $(EXECUTABLE)

create: create.o
	$(CC) $(OBJECTS) $(DEPENOBJS) $< -o $@$(EXT) $(LDFLAGS)

use: use.o tgs.o
	$(CC) $(OBJECTS) $(DEPENOBJS) $< -o $@$(EXT) $(LDFLAGS)

benchmark: benchmark.o
	$(CC) $(OBJECTS) $(DEPENOBJS) $< -o $@$(EXT) $(LDFLAGS)

getsize: getsize.o
	$(CC) $(OBJECTS) $(DEPENOBJS) $< -o $@$(EXT) $(LDFLAGS)

text2adjacencybin: text2adjacencybin.o
	$(CC) $(OBJECTS) $(DEPENOBJS) $< -o $@$(EXT) $(LDFLAGS)