/*=================================================================
 * toint64.cpp
 * Concatenates 8-bit values into one 64-bit value
 * @author Ossian O'Reilly ooreilly@stanford.edu 
 *=================================================================*/ 
#include "toint64.h"

/* Take 8 or less 8-bit values and concatenate them into one 64-bit value  */ 
uint64_t toint64_8(const uint8_t *in, uint8_t nvals){
    uint64_t out = 0;
    for (int index = 0; index != nvals; ++index )
        out = out | (uint64_t)in[index] << 8*index;         
    return out;
}
/* Take 12 or less 8-bit values and concatenate them into one 64-bit value  */ 
uint64_t toint64_12(const uint8_t *in, uint8_t nvals){
    uint64_t out = 0;
    for (int index = 0; index != nvals; ++index )
        out = out | (uint64_t)in[index] << 5*index;         
    return out;
}  

/* Take 16 or less 8-bit values and concatenate them into one 64-bit value  */ 
uint64_t toint64_16(const uint8_t *in, uint8_t nvals){
    uint64_t out = 0;
    for (int index = 0; index != nvals; ++index )
        out = out | (uint64_t)in[index] << 4*index;         
    return out;
}  