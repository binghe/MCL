/* Totally different content than 'macros.s' */

/*
  06/23/07 akh add ptr_to/from_lispobj
  12/27/95 gb  deref works on pointers
  12/13/95 gb  new boundp, fboundp
*/

#ifndef __macros__
#define __macros__

#define ptr_to_lispobj(p) ((LispObj)((unsigned_of_pointer_size)(p)))
#define ptr_from_lispobj(o) ((LispObj*)((unsigned_of_pointer_size)(o)))
#define lisp_reg_p(reg)  ((reg) > fn)

#define fulltag_of(o)  ((o) & fulltagmask)
#define tag_of(o) ((o) & tagmask)
#define untag(o) ((o) & ~fulltagmask)

#define deref(o,n) (*((LispObj*) ((LispObj *)(untag((LispObj)o)))+(n)))
#define header_of(o) deref(o,0)

#define header_subtag(h) ((h) & subtagmask)
#define header_element_count(h) ((h) >> num_subtag_bits)
#define make_header(subtag,element_count) ((subtag)|((element_count)<<num_subtag_bits))

#define unbox_fixnum(x) ((int)(((int)(x))>>fixnum_shift))
#define box_fixnum(x) ((x)<<fixnum_shift)

#define car(x) (((cons *)(untag(x)))->car)
#define cdr(x) (((cons *)(untag(x)))->cdr)

/* "sym" is an untagged pointer to a symbol */
#define BOUNDP(sym)  ((((lispsymbol *)(sym))->vcell) != undefined)

/* Likewise. */
#define FBOUNDP(sym) ((((lispsymbol *)(sym))->fcell) != nrs_UDF.vcell)


/* lfuns */
#define lfun_bits(f) (deref(f,header_element_count(header_of(f))))
#define named_function_p(f) (!(lfun_bits(f)&(1<<(29+fixnum_shift))))
#define named_function_name(f) (deref(f,-1+header_element_count(header_of(f))))

#endif
