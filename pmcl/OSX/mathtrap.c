


/*
  Emulate some arithmetic operations.
  Should probably have lisp do this for us,
  instead of the other way around.
*/

/*
  07/14/96  gb cons_small_bignum: egc changes.
  ----- 3.9 -----
  03/10/96  gb new protection scheme
  02/20/96  gb reset_xp_overflow.
  01/10/96  gb cons_small_bignum GCs if it has to.
               add fix_fixnum_overflow.
*/

#include "lisp.h"
#include "lisp_globals.h"
#include "lisp-exceptions.h"
#include "area.h"

void
reset_xp_overflow(ExceptionInformation *xp)
{
  /* Reset the XER's SO and OV bits; reset all SO bits in CR. */
  xp->machineState->XER &= 0x3fffffff;
  xp->machineState->CRRegister &= 0xeeeeeeee;
}


LispObj
cons_small_bignum(ExceptionInformation *xp, unsigned ndigits, unsigned destreg)
{
  unsigned nbytes = align_to_power_of_2(4+(ndigits<<2),3);
  BytePtr
    curfree = (BytePtr) xpGPR(xp,freeptr),
    newfree = curfree+nbytes;
  protected_area_ptr boundary = find_protected_area(newfree);
  LispObj 
    header = make_header(subtag_bignum,ndigits),
    retval;
  area *a = active_dynamic_area;

  if (boundary && boundary->why == kHEAPhard) {
    /* 
      Need to gc; doing so will change the freeptr
      and we'll have to check again.
      If we find that we're up against the hard limit again,
      we're SOL.
      */
    a->active = curfree;
    untenure_from_area(tenured_area); /*  force a full gc */
    gc_from_xp(xp);
    curfree = (BytePtr) xpGPR(xp,freeptr),
    newfree = curfree+nbytes;
    boundary = find_protected_area(newfree);
    if (boundary && boundary->why == kHEAPhard) {
      /* If we can't cons a small bignum, calling Lisp code isn't a very good idea. */
      handle_error(xp, error_alloc_failed, rnil, (unsigned) lisp_nil, (unsigned) xpPC(xp));
    }
  }
  if (boundary && boundary->why == kHEAPsoft) {
    BytePtr lowprot = boundary->start;

    /* Maybe invoke the egc.  If we do so, try allocation again. */
    if (a->older && lisp_global(OLDEST_EPHEMERAL)) {
      if ((curfree - a->low) >= a->threshold) {
        gc_from_xp(xp);
        return cons_small_bignum(xp, ndigits, destreg);
      }
    }
    
    unprotect_area_prefix(boundary, 0x8000);
    zero_heap_segment(lowprot);
    if (boundary->nprot == 0) {
      protect_area(active_dynamic_area->hardprot);
    }
  }
  /* OK, we aren't going to cross a protected page boundary.
     Update lisp's freeptr register, slap the header on the
     bignum, set the destination register to the bignum,
     update lisp's initptr, and return the (tagged!) bignum.
     */
  set_xpGPR(xp,freeptr,newfree);
  *(LispObj *) curfree = header;
  retval = (LispObj) (curfree+fulltag_misc);
  set_xpGPR(xp,destreg,retval);
  set_xpGPR(xp,initptr,newfree);
 
  return retval;
}

/* 
  The fixnum in RA has overflowed by one bit (presumably as the result of
  an addition or subtraction.  Cons a bignum (always 1 digit) and return
  it in RT (which may well be the same as RA.)
  */
OSStatus
fix_fixnum_overflow(ExceptionInformation *xp, unsigned destreg, unsigned srcreg)
{
  int val = (int) xpGPR(xp,srcreg);
  LispObj bignum = cons_small_bignum(xp, 1, destreg);

  /* Overflow means that the apparent sign bit doesn't match
     the invisible sign bits (in bits 32-inf).  Shift the
     signed value right fixnumshift bits, then invert the
     top fixnumshift bits.
     */

  /* MrC will probably evaluate this expression at runtime,
     as a debugging aid.
     */

  val = (val >> fixnumshift) ^ (0xffffffff << (32 - fixnumshift));
  deref(bignum,1) = val;
  reset_xp_overflow(xp);

  return 0;
}

/*
  Boxing a signed 32 bit value always results in a 1-digit bignum.
*/

OSStatus
box_signed_integer(ExceptionInformation *xp, unsigned destreg, unsigned srcreg)
{
  int val = (int) xpGPR(xp,srcreg);
  LispObj bignum = cons_small_bignum(xp, 1, destreg);

  deref(bignum,1) = val;
  reset_xp_overflow(xp);

  return 0;
}

/*
  Boxing an unsigned integer returns a 1-digit bignum if
  the integer's "sign" bit is clear, else a second (zero)
  sign digit.
*/
OSStatus
box_unsigned_integer(ExceptionInformation *xp, unsigned destreg, unsigned srcreg)
{
  unsigned val = (int) xpGPR(xp,srcreg);
  LispObj bignum = cons_small_bignum(xp, (val & 0x80000000) ? 2 : 1, destreg);

  deref(bignum,1) = val;
  /* 
    Since "uninitialized" newly-allocated memory is always zeroed, it's not
    necessary to say:

    if (val & 0x80000000) {
      deref(bignum,2) = 0;
    }
    */

  reset_xp_overflow(xp);
  return 0;
}


OSStatus
add_fixnums(ExceptionInformation *xp, unsigned rt, unsigned ra, unsigned rb)
{
  int
    a_val = unbox_fixnum(xpGPR(xp,ra)),
    b_val = unbox_fixnum(xpGPR(xp,rb));

  LispObj bignum = cons_small_bignum(xp, 1, rt);

  deref(bignum,1) = (LispObj)(a_val+b_val);

  reset_xp_overflow(xp);
  return 0;
}


OSStatus
sub_fixnums(ExceptionInformation *xp, unsigned rt, unsigned ra, unsigned rb)
{
  int
    a_val = unbox_fixnum(xpGPR(xp,ra)),
    b_val = unbox_fixnum(xpGPR(xp,rb));

  LispObj bignum = cons_small_bignum(xp, 1, rt);

  deref(bignum,1) = (LispObj)(a_val-b_val);

  reset_xp_overflow(xp);
  return 0;
}



