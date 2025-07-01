#ifndef __BRWHASH1271__
#define __BRWHASH1271__

#include "brwhash1271_basictypes.h"

#define KEY_LENGTH 126
#define BLOCK_LENGTH 120
#define KEY_SIZE 16
#define BLOCK_SIZE 15
#define MAX_MSG_SIZE 4194315
#define MAX_MSG_LENGTH 33554432
#define MAX_KP_SIZE 38

void brwhash1271(uchar8 *,const uchar8 *,const uint64 *,const uint64);

extern void brwhash1271_t5_maax(uint64 *,const uint64 *,const uint64 *,const uint64);
extern void brwhash1271_keypowers(uint64 *,const uint64);

#endif
