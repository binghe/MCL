/*
This code is derived from David Keppel's QuickThreads --
Threads-building toolkit. 

Copyright (c) 1993 by David Keppel

Permission to use, copy, modify and distribute this software and
its documentation for any purpose and without fee is hereby
granted, provided that the above copyright notice and this notice
appear in all copies.  This software is provided as a
proof-of-concept and for demonstration purposes; there is no
representation about the suitability of this software for any
purpose.

*/

#ifndef QT_H
#define QT_H

#define QT_STKALIGN 16

  /* and grow towards arithmetically lower addresses */
#define QT_GROW_DOWN

/* A QuickThreads thread is represented by it's current stack pointer.
   To restart a thread, you merely need pass the current sp (qt_t*) to
   a QuickThreads primitive.  `qt_t*' is a location on the stack.  To
   improve type checking, represent it by a particular struct. */

typedef struct qt_t {
  char dummy;
} qt_t;


extern void qt_start(void);
#define QT_STKROUNDUP(bytes) \
  (((bytes)+QT_STKALIGN) & ~(QT_STKALIGN-1))


/* Find ``top'' of the stack, space on the stack. */
#define QT_SP(sto, size)	((qt_t *)(&((char *)(sto))[(size)]))



/* The type of the user function:
   For non-varargs, takes one void* function.
*/
typedef void *(qt_userf_t)(void *pu);

/* For non-varargs, just call a client-supplied function,
   it does all startup and cleanup, and also calls the user's
   function. */
typedef void (qt_only_t)(void *pu, void *pt, qt_userf_t *userf);

/* Must match the definition in qtppc.s */

typedef struct QT_save {
	unsigned backlink;
	unsigned crsave;
	unsigned savelr;
	unsigned unused[2];
	unsigned savetoc;
	unsigned params[8];
	unsigned savevrsave;
	unsigned savenvrs[19];	/* 34 words */
	double savefpscr;
	double savefprs[18];	/* 38 words */
	double savevrs[25];		/* 50 words */
} QT_save;

#ifndef offsetof
#define offsetof(struct, field) ((unsigned) (&(((struct *)0)->field)))
#endif
#define Woffsetof(struct, field) ((offsetof(struct,field)/4))
#define QT_save_size_in_words 112


#define QT_R1 Woffsetof(QT_save,backlink)
#define QT_LR Woffsetof(QT_save,savelr)
#define QT_R13 Woffsetof(QT_save,savenvrs)
#define QT_R14 (QT_R13+1)
#define QT_R15 (QT_R14+1)
#define QT_R16 (QT_R15+1)
#define QT_R17 (QT_R16+1)
#define QT_FPSCR Woffsetof(QT_save,savefpscr)
#define QT_NEXTFRAME QT_save_size_in_words
#define QT_NEXTLR (QT_NEXTFRAME+QT_LR)
#define QT_STKBASE (QT_NEXTFRAME*2)


#define QT_ONLY_INDEX QT_R17
#define QT_ARGU_INDEX QT_R14
#define QT_ARGT_INDEX QT_R15
#define QT_USER_INDEX QT_R16

typedef unsigned long qt_word_t;

/* Internal helper for putting stuff on stack. */
#define QT_SPUT(top, at, val)	\
    (((qt_word_t *)(top))[(at)] = (qt_word_t)(val))

#define QT_SET_NEXTLR(top, val) \
     QT_SPUT(top, QT_NEXTLR, ((qt_word_t)val))

#define QT_SET_NEXTSP(top) \
     QT_SPUT(top, QT_NEXTFRAME, ((char *)(top))+QT_STKBASE)

#define QT_SET_FPSCR(top, val) \
     QT_SPUT(top, QT_FPSCR, ((qt_word_t)val))

#define QT_SETSP(top) \
     QT_SPUT(top, QT_R1,((char *)(((qt_word_t *)top) + QT_NEXTFRAME)))

#define QT_ARGS_MD(top) \
     QT_SET_NEXTSP(top), \
     QT_SETSP(top),\
     QT_SET_NEXTLR(top, qt_startTPP),\
     QT_SET_FPSCR(top, initial_fpscr)

#define initial_fpscr 0

/* Push arguments for the non-varargs case. */

/* All things are put on the stack relative to the final value of
   the stack pointer. */
#define QT_ADJ(sp)	(((char *)sp) - QT_STKROUNDUP(QT_STKBASE))


#define QT_ARGS(sp, pu, pt, userf, only) \
    (QT_ARGS_MD (QT_ADJ(sp)), \
     QT_SPUT (QT_ADJ(sp), QT_ONLY_INDEX, only), \
     QT_SPUT (QT_ADJ(sp), QT_USER_INDEX, userf), \
     QT_SPUT (QT_ADJ(sp), QT_ARGT_INDEX, pt), \
     QT_SPUT (QT_ADJ(sp), QT_ARGU_INDEX, pu), \
     ((qt_t *)QT_ADJ(sp)))


/* Save the state of the thread and call the helper function
   using the stack of the new thread. */
typedef void *(qt_helper_t)(qt_t *old, void *a0, void *a1);
typedef void *(qt_block_t)(qt_helper_t *helper, void *a0, void *a1,
			  qt_t *newthread);

/* Rearrange the parameters so that things passed to the helper
   function are already in the right argument registers. */

extern void *qt_block (qt_helper_t *h, void *a0, void *a1,
		       qt_t *newthread);
#define QT_BLOCK(h, a0, a1, newthread) \
    (qt_block (h, a0, a1, newthread))



#endif /* ndef QT_H */
