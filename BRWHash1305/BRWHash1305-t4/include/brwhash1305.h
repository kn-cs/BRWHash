#ifndef __BRWHASH1305__
#define __BRWHASH1305__

#include "brwhash1305_basictypes.h"

#define KEY_LENGTH 128
#define BLOCK_LENGTH 128
#define KEY_SIZE 16
#define BLOCK_SIZE 16
#define MAX_MSG_SIZE 4194304
#define MAX_MSG_LENGTH 33554432
#define MAX_KP_SIZE 57

void brwhash1305(uchar8 *,const uchar8 *,const uint64 *,const uint64);

extern void brwhash1305_t4_maax(uint64 *,const uint64 *,const uint64 *,const uint64);
extern void brwhash1305_keypowers(uint64 *,const uint64);

#endif
