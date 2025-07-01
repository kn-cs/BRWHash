INCDRS = -I../include/

SRCFLS = ../source/brwhash1271_const.S 	\
	 ../source/brwhash1271_t5_maax.S	\
	 ../source/brwhash1271_keypowers.S	\
	 ../source/brwhash1271_input.c 	\
	 ../source/brwhash1271.c
         
OBJFLS = ../source/brwhash1271_const.o 	\
	 ../source/brwhash1271_t5_maax.o	\
	 ../source/brwhash1271_keypowers.o	\
	 ../source/brwhash1271_input.o 	\
	 ../source/brwhash1271.o

TESTSRC = ./brwhash1271_t5_verify.c
TESTOBJ = ./brwhash1271_t5_verify.o

SPEEDSRC = ./brwhash1271_t5_speed.c
SPEEDOBJ = ./brwhash1271_t5_speed.o

RECORDSRC = ./brwhash1271_t5_record_speed.c
RECORDOBJ = ./brwhash1271_t5_record_speed.o
	  
EXE1    = brwhash1271_t5_verify
EXE2    = brwhash1271_t5_speed
EXE3    = brwhash1271_t5_record_speed

CFLAGS = -march=native -mtune=native -m64 -O3 -funroll-loops -fomit-frame-pointer

CC     = gcc-10
LL     = gcc-10

all:	$(EXE1) $(EXE2) $(EXE3)

$(EXE1): $(TESTOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(TESTOBJ) -lm
	
$(EXE2): $(SPEEDOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(SPEEDOBJ) -lm -lcpucycles
	
$(EXE3): $(RECORDOBJ) $(OBJFLS)
	$(LL) -o $@ $(OBJFLS) $(RECORDOBJ) -lm -lcpucycles

.c.o:
	$(CC) $(INCDRS) $(CFLAGS) -o $@ -c $<

clean:
	-rm $(EXE1) $(EXE2) $(EXE3)
	-rm $(TESTOBJ) $(SPEEDOBJ) $(RECORDOBJ)
	-rm $(OBJFLS)	

