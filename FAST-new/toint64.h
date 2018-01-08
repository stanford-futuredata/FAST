/*=================================================================
 * toint64.h
 * Concatenates 8-bit values into one 64-bit value
 * @author Ossian O'Reilly ooreilly@stanford.edu 
 *=================================================================*/ 
#include <limits.h>   

#ifndef _TOINT64_H_
#define _TOINT64_H_

//-----------------------------------------------------------------------------
// Platform-specific functions and macros

// Microsoft Visual Studio

#if defined(_MSC_VER)

typedef unsigned char uint8_t;
typedef unsigned long uint32_t;
typedef unsigned __int64 uint64_t;

// Other compilers

#else   // defined(_MSC_VER)

#include <stdint.h>

#endif // !defined(_MSC_VER)

//----------------------------------------------------------------------------- 


uint64_t toint64_8(const uint8_t *in, uint8_t nvals); 
uint64_t toint64_12(const uint8_t *in, uint8_t nvals); 
uint64_t toint64_16(const uint8_t *in, uint8_t nvals); 

#endif // _TOINT64_H_  