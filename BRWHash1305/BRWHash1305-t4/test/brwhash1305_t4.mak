INCDRS = -I../include/

SRCFLS = ../source/brwhash1305_const.S 	\
	 ../source/brwhash1305_t4_maax.S	\
	 ../source/brwhash1305_keypowers.S	\
	 ../source/brwhash1305_input.c 	\
	 ../source/brwhash1305.c
         
OBJFLS = ../source/brwhash1305_const.o 	\
	 ../source/brwhash1305_t4_maax.o	\
	 ../source/brwhash1305_keypowers.o	\
	 ../source/brwhash1305_input.o 	\
	 ../source/brwhash1305.o

TESTSRC = ./brwhash1305_t4_verify.c
TESTOBJ = ./brwhash1305_t4_verify.o

SPEEDSRC = ./brwhash1305_t4_speed.c
SPEEDOBJ = ./brwhash1305_t4_speed.o

RECORDSRC = ./brwhash1305_t4_record_speed.c
RECORDOBJ = ./brwhash1305_t4_record_speed.o
	  
EXE1    = brwhash1305_t4_verify
EXE2    = brwhash1305_t4_speed
EXE3    = brwhash1305_t4_record_speed

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

