/*
  12/26/95  gb  lots o macros.
*/


#ifndef __bits_h__
#define __bits_h__ 1

#include <string.h>

typedef unsigned *bitvector;

#ifdef PPC64
#define bitmap_shift 6
#define BIT0_MASK 0x8000000000000000ULL
#define ALL_ONES  0xffffffffffffffffULL
#else
#define bitmap_shift 5
#define BIT0_MASK 0x80000000U 
#define ALL_ONES  0xFFFFFFFFU
#endif


int set_bit(bitvector,unsigned);	/* returns old set-ness */
void set_n_bits(bitvector,unsigned,unsigned);
int clr_bit(bitvector,unsigned);	/* returns old clr-ness */
unsigned ref_bit(bitvector,unsigned);
bitvector new_bitvector(unsigned);
void zero_bits(bitvector, unsigned);
void ior_bits(bitvector,bitvector,unsigned);

#define BIT0_MASK 0x80000000U 
#define bits_word_index(bitnum) (((unsigned)(bitnum)) >> 5)
#define bits_bit_index(bitnum) (((unsigned)(bitnum)) & 0x1f)
#define bits_word_ptr(bits,bitnum) \
  ((unsigned *) (((unsigned *) bits) + ((unsigned) (bits_word_index(bitnum)))))
#define bits_word_mask(bitnum) ((BIT0_MASK) >> bits_bit_index(bitnum))
#define bits_indexed_word(bitv,indexw) ((((unsigned *)(bitv))[indexw]))
#define bits_word(bitv,bitnum) bits_indexed_word(bits,bits_word_index(bitnum))

/* Evaluates some arguments twice */

#define set_bits_vars(BITVvar,BITNUMvar,BITPvar,BITWvar,MASKvar) \
{ BITPvar = bits_word_ptr(BITVvar,BITNUMvar); BITWvar = *BITPvar; MASKvar = bits_word_mask(BITNUMvar); }

#define set_bitidx_vars(BITVvar,BITNUMvar,BITPvar,BITWvar,BITIDXvar) \
{ BITPvar = bits_word_ptr(BITVvar,BITNUMvar); BITIDXvar = bits_bit_index(BITNUMvar); \
    BITWvar = (*BITPvar << BITIDXvar) >> BITIDXvar; }

/* The MetroWerks compiler open codes this, but doing two machine
   instructions out-of-line won't kill us. */

#ifdef __MWERKS__
#define count_leading_zeros(x) __cntlzw(x)
#else
unsigned
count_leading_zeros(unsigned);
#endif



                                        
#endif /* __bits_h__ */
