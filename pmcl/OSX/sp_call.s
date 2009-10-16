
/* this file now includes all spentry files */


	include(lisp.s)
        _beginfile
        .align 2
	
	
define([_spentry],[ifdef([__func_name],[_endfn],[])
	_exportfn(_SP$1)
	.line  __line__
])

             
define([_endsubp],[
	_endfn(_SP$1)
# __line__
])


                	
               
define([jump_builtin],[
	ref_nrs_value(fname,builtin_functions)
	set_nargs($2)
	vref32(fname,fname,$1)
	jump_fname()
])

_spentry(jmpsym)
	__(jump_fname())
        
_spentry(jmpnfn)
	__(jump_nfn())
        
	/* Call temp0 if it's either a symbol or function */
_spentry(funcall)
	__(do_funcall())

/* Signal an error synchronously, via %ERR-DISP. */
/* If %ERR-DISP isn't fbound, it'd be nice to print a message */
/* on the C runtime stderr. */

_spentry(ksignalerr)
	__(la fname,nrs.errdisp(rnil))
	__(jump_fname)

/* from sp_catch.s */
_spentry(mkcatch1v)
	__(li imm2,0)
	__(b local_label(_mkcatch))

_spentry(mkunwind)
	__(lwi(arg_z,unbound_marker)) /* yikes */
	__(li imm2,fixnum_one)
	__(b local_label(_mkcatch))

_spentry(mkcatchmv)
	__(li imm2,fixnum_one)
	__(b local_label(_mkcatch))

/*	
;; Push a catch frame on the temp stack (and some of it on the cstack, as well.)
;; The PC in question is 4 bytes past the caller's return address. ALWAYS.
;; The catch tag is in arg_z, the multiple-value flags is in imm2.
;; Bash some of the imm registers and loc_pc.
*/


/*  THIS HAS TO LOOK ATOMIC TO ANY (future) preemptive scheduler. */
local_label(_mkcatch):
	/* stw rzero,-4096(tsp)		; overflow probe. */
	__(mflr loc_pc)
	__(ref_global(imm0,catch_top))
	__(lwz imm1,0(loc_pc))	/* a forward branch to the catch/unwind cleanup */
	__(rlwinm imm1,imm1,0,6,29)	/* extract LI */
	__(add loc_pc,loc_pc,imm1)
	__(stwu sp,-lisp_frame.size(sp))
	__(stw fn,lisp_frame.savefn(sp))
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(stw vsp,lisp_frame.savevsp(sp))
	__(sub loc_pc,loc_pc,imm1)
	__(la loc_pc,4(loc_pc))	/* skip over the forward branch */
	__(mtlr loc_pc)
	__(mr initptr,tsp)
	__(stwu tsp,-(catch_frame.size+8)(tsp))
	__(stw rzero,4(tsp))
	__(la imm1,8+fulltag_misc(tsp))
	__(stw arg_z,catch_frame.catch_tag(imm1))
	__(stw imm0,catch_frame.link(imm1))
	__(stw imm2,catch_frame.mvflag(imm1))
	__(ref_global(imm0,db_link))
	__(stw sp,catch_frame.csp(imm1))
	__(lwi(imm2,(catch_frame.element_count<<num_subtag_bits)|subtag_catch_frame))
	__(stw imm0,catch_frame.db_link(imm1))
 	__(stmw first_nvr,catch_frame.regs(imm1))
	__(stw imm2,catch_frame.header(imm1))
	__(ref_global(imm0,xframe))
	__(stw imm0,catch_frame.xframe(imm1))
	__(stw rzero,catch_frame.tsp_segment(imm1))
	__(mr initptr,freeptr)
	__(set_global(imm1,catch_top))
	__(b _SPtscheck)

/* Caller has pushed tag and 0 or more values; nargs = nvalues. */
/* Otherwise, process unwind-protects and throw to indicated catch frame. */

_spentry(throw)
	__(ref_global(imm1,catch_top))
	__(li imm0,0)		/* count intervening catch/unwind-protect frames. */
	__(cmpwi cr0,imm1,0)
	__(lwzx temp0,vsp,nargs)
	__(beq cr0,local_label(_throw_tag_not_found))
local_label(_throw_loop):	
	__(lwz temp1,catch_frame.catch_tag(imm1))
	__(cmpw cr0,temp0,temp1)
	__(mr imm2,imm1)
	__(lwz imm1,catch_frame.link(imm1))
	__(cmpwi cr1,imm1,0)
	__(beq cr0,local_label(_throw_found))
	__(addi imm0,imm0,fixnum_one)
	__(beq cr1,local_label(_throw_tag_not_found))
	__(b local_label(_throw_loop))
/* imm2: (tstack-consed) target catch frame, imm0: count of intervening frames.
  If target isn't a multiple-value receiver, discard extra values 
  (less hair, maybe.) */
local_label(_throw_found):
	__(lwz imm1,catch_frame.mvflag(imm2))
	__(cmpwi cr0,imm1,0)
	__(cmpwi cr1,nargs,0)
	__(li fn,0)
	__(add imm1,vsp,nargs)
	__(la imm1,-4(imm1))
	__(bne cr0,local_label(_throw_all_values))
	__(set_nargs(1))
	__(beq cr1,local_label(_throw_default_1_val))
	__(mr vsp,imm1)
	__(b local_label(_throw_all_values))
local_label(_throw_default_1_val):
	__(vpush(rnil))
local_label(_throw_all_values):
	__(bl _SPnthrowvalues)
	__(ref_global(imm3,catch_top))
	__(ref_global(imm1,db_link))
	__(lwz imm0,catch_frame.db_link(imm3))
	__(lwz imm4,catch_frame.mvflag(imm3))
	__(cmpw cr0,imm0,imm1)
	__(cmpwi cr1,imm4,0)
	__(la tsp,-(fulltag_misc+8)(imm3))
	__(bnel cr0,_SPunbind_to)
	__(add imm0,vsp,nargs)
	__(cmpwi cr0,nargs,0)
	__(lwz imm1,catch_frame.csp(imm3))
	__(lwz imm1,lisp_frame.savevsp(imm1))
	__(bne cr1,local_label(_throw_multiple))
/* Catcher expects single value in arg_z */
	__(lwz arg_z,-4(imm0))
	__(b local_label(_throw_pushed_values))

local_label(_throw_multiple):
	__(beq cr0,local_label(_throw_pushed_values))
	__(mr imm2,nargs)
local_label(_throw_mvloop):
	__(subi imm2,imm2,fixnum_one)
	__(cmpwi imm2,0)
	__(lwzu temp0,-4(imm0))
	__(push(temp0,imm1))
	__(bgt local_label(_throw_mvloop))
local_label(_throw_pushed_values):
	__(mr vsp,imm1)
	__(lwz sp,catch_frame.csp(imm3))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(la sp,lisp_frame.size(sp))
	__(mtlr loc_pc)
	__(lmw first_nvr,catch_frame.regs(imm3))
	__(lwz imm1,catch_frame.xframe(imm3))
	__(set_global(imm1,xframe))
	__(lwz imm3,catch_frame.link(imm3))
	__(set_global(imm3,catch_top))
	__(unlink(tsp))
        __(ref_global(arg_x,current_cs))
        __(lwz imm0,area.hardlimit(arg_x))
        __(ref_global(extra,cs_overflow_limit))
        __(cmpw imm0,extra)
        __(bne check_vs)
        __(lwz imm0,area.softlimit(arg_x))
        __(la extra,1024(imm0))
        __(cmplw sp,extra)
        __(blt check_vs)
        __(set_global(imm0,cs_overflow_limit))
check_vs:
        __(ref_global(arg_x,current_vs))
        __(lwz imm0,area.hardlimit(arg_x))
        __(ref_global(extra,vs_overflow_limit))
        __(cmpw imm0,extra)
        __(bne check_ts)
        __(lwz imm0,area.softlimit(arg_x))
        __(la extra,1024(imm0))
        __(cmplw vsp,extra)
        __(blt check_ts)
        __(set_global(imm0,vs_overflow_limit))
check_ts:       
        __(ref_global(arg_x,current_ts))
        __(lwz imm0,area.hardlimit(arg_x))
        __(ref_global(extra,ts_overflow_limit))
        __(cmpw imm0,extra)
        __(bnelr)
        __(lwz imm0,area.softlimit(arg_x))
        __(la extra,1024(imm0))
        __(cmplw tsp,extra)
        __(bltlr)
        __(set_global(imm0,ts_overflow_limit))
	__(blr)
local_label(_throw_tag_not_found):
        __(bl _SPxuuo_interr)
	__(uuo_interr(error_throw_tag_missing,temp0))
	__(stwux temp0,vsp,nargs)
	__(b _SPthrow)

/* This takes N multiple values atop the vstack. */
_spentry(nthrowvalues)
	__(mr imm4,imm0)
local_label(_nthrowv_nextframe):
	__(subi imm4,imm4,fixnum_one)
	__(cmpwi cr1,imm4,0)
	__(ref_global(temp0,catch_top))
	/*;; lwz imm3,catch_frame.link(temp0) ;; move below */
	__(ref_global(imm1,db_link))
	__(bltlr cr1)
        __(lwz imm3,catch_frame.link(temp0))        
	__(lwz imm0,catch_frame.db_link(temp0))
	__(cmpw cr0,imm0,imm1)
	__(set_global(imm3,catch_top))
	__(lwz temp1,catch_frame.catch_tag(temp0))
	__(cmpwi cr7,temp1,unbound_marker)		/* unwind-protect ? */
	__(lwz sp,catch_frame.csp(temp0))
	__(beq cr0,local_label(_nthrowv_dont_unbind))
	__(mflr loc_pc)
	 __(bl _SPunbind_to)
	 __(mtlr loc_pc)
local_label(_nthrowv_dont_unbind):
	__(beq cr7,local_label(_nthrowv_do_unwind))
/* A catch frame.  If the last one, restore context from there. */
	__(bne cr1,local_label(_nthrowv_skip))
	__(lwz first_nvr,catch_frame.xframe(temp0))
	__(set_global(first_nvr,xframe))
	__(lwz imm0,lisp_frame.savevsp(sp))
	__(stw rzero,lisp_frame.savevsp(sp))	/* marker for stack overflow code */
	__(add imm1,vsp,nargs)
	__(mr imm2,nargs)
	__(b local_label(_nthrowv_push_test))
local_label(_nthrowv_push_loop):
	__(lwzu temp1,-4(imm1))
	__(push(temp1,imm0))
local_label(_nthrowv_push_test):
	__(cmpwi imm2,0)
	__(subi imm2,imm2,fixnum_one)
	__(bne local_label(_nthrowv_push_loop))
	__(mr vsp,imm0)
	__(lmw first_nvr,catch_frame.regs(temp0))

local_label(_nthrowv_skip):
	__(la tsp,-(8+fulltag_misc)(temp0))
	__(unlink(tsp))
	__(la sp,lisp_frame.size(sp))
	__(b local_label(_nthrowv_nextframe))
local_label(_nthrowv_do_unwind):
/* This is harder.  Call the cleanup code with the multiple values (and */
/* nargs, which is a fixnum.)  Remember the throw count (also a fixnum) */
/* as well. */
/* Save our caller's LR and FN in the csp frame created by the unwind- */
/* protect.  (Clever, eh ?) */

	__(lwz first_nvr,catch_frame.xframe(temp0))
	__(set_global(first_nvr,xframe))
	__(lmw first_nvr,catch_frame.regs(temp0))
	__(la tsp,-(8+fulltag_misc)(temp0))
	__(unlink(tsp))
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz nfn,lisp_frame.savefn(sp))
	__(mtctr loc_pc)		/* cleanup code address. */
	__(stw fn,lisp_frame.savefn(sp))
	__(mflr loc_pc)
	__(mr fn,nfn)
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(addi imm0,nargs,(8+8))	/* tsp overhead, nargs, throw count */
	__(neg imm0,imm0)
	__(bitclr(imm0,imm0,2))    /* bitclr is a bloody macro */
	__(stwux tsp,tsp,imm0)
	__(stw rzero,4(tsp))
	__(mr imm2,nargs)
	__(add imm1,nargs,vsp)
	__(sub imm0,tsp,imm0)                      /* end of tsp frame */
	__(stw rzero,-4(imm0))
	__(la imm0,8(tsp))
	__(stw nargs,0(imm0))
	__(b local_label(_nthrowv_tpushtest))
local_label(_nthrowv_tpushloop):
	__(lwzu temp0,-4(imm1))
	__(stwu temp0,4(imm0))
	__(subi imm2,imm2,fixnum_one)

local_label(_nthrowv_tpushtest):
	__(cmpwi imm2,0)
	__(bne local_label(_nthrowv_tpushloop))
	__(stwu imm4,4(imm0))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(stw rzero,lisp_frame.savevsp(sp))       /* tell stack overflow code to skip this frame */
	__(bctrl)
	__(la imm0,8(tsp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(unlink(sp))
	__(mtlr loc_pc)
	__(lwz nargs,0(imm0))
	__(mr imm2,nargs)
	__(b local_label(_nthrowv_tpoptest))
local_label(_nthrowv_tpoploop):
	__(lwzu temp0,4(imm0))
	__(vpush(temp0))
	__(subi imm2,imm2,fixnum_one)
local_label(_nthrowv_tpoptest):
	__(cmpwi imm2,0)
	__(bne local_label(_nthrowv_tpoploop))
	__(lwz imm4,4(imm0))
	__(unlink(tsp))
	__(b local_label(_nthrowv_nextframe))

/* This is a (slight) optimization.  When running an unwind-protect, */
/* save the single value and the throw count in the tstack frame. */
/* Note that this takes a single value in arg_z. */
_spentry(nthrow1value)
	__(mr imm4,imm0)
local_label(_nthrow1v_nextframe):
	__(subi imm4,imm4,fixnum_one)
	__(cmpwi cr1,imm4,0)
	__(ref_global(temp0,catch_top))
	/* lwz imm3,catch_frame.link(temp0) ;; move below, temp0 might be 0, osx doesn't like that */
	__(ref_global(imm1,db_link))
	__(set_nargs(1))
	__(bltlr cr1)
        __(lwz imm3,catch_frame.link(temp0)) 
	__(lwz imm0,catch_frame.db_link(temp0))
	__(cmpw cr0,imm0,imm1)
	__(set_global(imm3,catch_top))
	__(lwz temp1,catch_frame.catch_tag(temp0))
	__(cmpwi cr7,temp1,unbound_marker)		/* unwind-protect ? */
	__(lwz sp,catch_frame.csp(temp0))
	__(beq cr0,local_label(_nthrow1v_dont_unbind))
	__(mflr loc_pc)
	__(bl _SPunbind_to)
	__(mtlr loc_pc)
local_label(_nthrow1v_dont_unbind):
	__(beq cr7,local_label(_nthrow1v_do_unwind))
/* A catch frame.  If the last one, restore context from there. */
	__(bne cr1,local_label(_nthrow1v_skip))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(lwz first_nvr,catch_frame.xframe(temp0))
	__(set_global(first_nvr,xframe))
	__(lmw first_nvr,catch_frame.regs(temp0))
local_label(_nthrow1v_skip):
	__(la tsp,-(8+fulltag_misc)(temp0))
	__(unlink(tsp))
	__(la sp,lisp_frame.size(sp))
	__(b local_label(_nthrow1v_nextframe))
local_label(_nthrow1v_do_unwind):
/* This is harder, but not as hard (not as much BLTing) as the */
/* multiple-value case. */

/* Save our caller's LR and FN in the csp frame created by the unwind- */
/* protect.  (Clever, eh ?) */
	
	__(lwz first_nvr,catch_frame.xframe(temp0))
	__(set_global(first_nvr,xframe))
	__(lmw first_nvr,catch_frame.regs(temp0))
	__(la tsp,-(8+fulltag_misc)(temp0))
	__(unlink(tsp))
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz nfn,lisp_frame.savefn(sp))
	__(mtctr loc_pc)		/* cleanup code address. */
	__(stw fn,lisp_frame.savefn(sp))
	__(mflr loc_pc)
	__(mr fn,nfn)
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(stwu tsp,-(8+8)(tsp))	/* tsp overhead, value, throw count */
	__(stw rzero,4(tsp))
	__(stw arg_z,8(tsp))
	__(stw imm4,12(tsp))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(stw rzero,lisp_frame.savevsp(sp))       /* Tell stack overflow code to ignore this frame */
	__(bctrl)
	__(lwz arg_z,8(tsp))
	__(lwz imm4,12(tsp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(unlink(sp))
	__(mtlr loc_pc)
	__(unlink(tsp))
	__(b local_label(_nthrow1v_nextframe))

/*  end sp_catch.s */

/*
;;; Note: all the tXXXslide functions MUST use a variable other than VSP while pushing to the slid location.
;;; This causes do_vsp_overflow in "lisp-exceptions.c" to allocate a new segment for the overflow, ensuring
;;; that it won't overwrite the stuff being slid.
;;; (They have to do so anyway, so that the VSP protects everything during the slide, but someone may
;;; need to remember the do_vsp_overflow assumption sometime).

*/

/* Tail-recursively call the (known symbol) in fname. */
/* In the general case, we don't know if any args were */
/* vpushed or not.  If so, we have to "slide" them down */
/* to the base of the frame.  If not, we can just restore */
/* vsp, lr, fn from the saved lisp frame on the control stack. */
_spentry(tcallsymgen)
	__(cmpwi cr0,nargs,nargregs<<fixnumshift)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(mtlr loc_pc)
	__(ble cr0,2f)
	__(lwz imm0,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	/* can use nfn (= temp2) as a temporary */
	__(subi imm1,nargs,nargregs<<fixnumshift)
	__(add imm1,imm1,vsp)
1:
	__(lwzu temp2,-4(imm1))
	__(cmpw cr0,imm1,vsp)
	__(push(temp2,imm0))
	__(bne cr0,1b)
	__(mr vsp,imm0)
	__(jump_fname)
2:		
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	__(jump_fname)

/* Some args were vpushed.  Slide them down to the base of */
/* the current frame, then do funcall. */
_spentry(tcallsymslide)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz imm0,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	__(mtlr loc_pc)
	/* can use nfn (= temp2) as a temporary */
	__(subi imm1,nargs,nargregs<<fixnumshift)
	__(add imm1,imm1,vsp)
1:	
        __(lwzu temp2,-4(imm1))
	__(cmpw cr0,imm1,vsp)
	__(push(temp2,imm0))
	__(bne cr0,1b)
	__(mr vsp,imm0)
	__(jump_fname)

/* No args were vpushed; recover saved context & call symbol */
_spentry(tcallsymvsp)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	__(mtlr loc_pc)
	__(jump_fname)



/* Tail-recursively call the function in nfn. */
	/* Pretty much the same as the tcallsym* cases above. */
_spentry(tcallnfngen)
	__(cmpwi cr0,nargs,nargregs<<fixnumshift)
	__(ble cr0,_SPtcallnfnvsp)
	__(b _SPtcallnfnslide)

/* Some args were vpushed.  Slide them down to the base of */
/* the current frame, then do funcall. */
_spentry(tcallnfnslide)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz imm0,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	__(mtlr loc_pc)
	/* Since we have a known function, can use fname as a temporary. */
	__(subi imm1,nargs,nargregs<<fixnumshift)
	__(add imm1,imm1,vsp)
1:
	__(lwzu fname,-4(imm1))
	__(cmpw cr0,imm1,vsp)
	__(push(fname,imm0))
	__(bne cr0,1b)
	__(mr vsp,imm0)
        __(jump_nfn)

_spentry(tcallnfnvsp)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	__(mtlr loc_pc)
	__(jump_nfn())

/*
_spentry(jmpnfn)
	__(jump_nfn())
*/


/* Tail-recursively funcall temp0. */
	/* Pretty much the same as the tcallsym* cases above. */
_spentry(tfuncallgen)
	__(cmpwi cr0,nargs,nargregs<<fixnumshift)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(mtlr loc_pc)
	__(ble cr0,2f)
	__(lwz imm0,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	/* can use nfn (= temp2) as a temporary */
	__(subi imm1,nargs,nargregs<<fixnumshift)
	__(add imm1,imm1,vsp)
1:
	__(lwzu temp2,-4(imm1))
	__(cmpw cr0,imm1,vsp)
	__(push(temp2,imm0))
	__(bne cr0,1b)
	__(mr vsp,imm0)
	__(do_funcall())
2:
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	__(do_funcall())
	/* Some args were vpushed.  Slide them down to the base of */
	/* the current frame, then do funcall. */

_spentry(tfuncallslide)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz imm0,lisp_frame.savevsp(sp))
	__(la sp,lisp_frame.size(sp))
	__(mtlr loc_pc)
	/* can use nfn (= temp2) as a temporary */
	__(subi imm1,nargs,nargregs<<fixnumshift)
	__(add imm1,imm1,vsp)
1:
	__(lwzu temp2,-4(imm1))
	__(cmpw cr0,imm1,vsp)
	__(push(temp2,imm0))
	__(bne cr0,1b)
	__(mr vsp,imm0)
	__(do_funcall())

	/* No args were vpushed; recover saved context & do funcall */
_spentry(tfuncallvsp)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(mtlr loc_pc)
	__(la sp,lisp_frame.size(sp))
	__(do_funcall())
	
_spentry(reset)
	.globl _SPthrow
	__(nop)
	__(ref_nrs_value(temp0,toplcatch))
	__(li temp1,XSTKOVER)
	__(vpush(temp0))
	__(vpush(temp1))
	__(set_nargs(1))
	__(b _SPthrow)

/*  Restore the special bindings from the top of the tstack, */
/* leaving the tstack frame allocated. */
/* Note that there might be 0 saved bindings, in which case */
/* do nothing. */
/* Note also that this is -only- called from an unwind-protect */
/* cleanup form, and that .SPnthrowXXX is keeping one or more */
/*   values in a frame on top of the tstack. */

_spentry(callbuiltin)
	__(ref_nrs_value(fname,builtin_functions))
	__(la imm0,misc_data_offset(imm0))
	__(lwzx fname,fname,imm0)
	__(jump_fname())	

/*
;;; the value of the nilreg-relative symbol %builtin-functions% should be
;;; a vector of symbols.  Funcall the symbol indexed by imm0 (boxed) and
;;; return a single value.
*/

_spentry(callbuiltin0)
	__(set_nargs(0))
	__(ref_nrs_value(fname,builtin_functions))
	__(la imm0,misc_data_offset(imm0))
	__(lwzx fname,fname,imm0)
	__(jump_fname())

_spentry(callbuiltin1)
	__(set_nargs(1))
	__(ref_nrs_value(fname,builtin_functions))
	__(la imm0,misc_data_offset(imm0))
	__(lwzx fname,fname,imm0)
	__(jump_fname())

_spentry(callbuiltin2)
	__(set_nargs(2))
	__(ref_nrs_value(fname,builtin_functions))
	__(la imm0,misc_data_offset(imm0))
	__(lwzx fname,fname,imm0)
	__(jump_fname())


_spentry(callbuiltin3)
	__(set_nargs(3))
	__(ref_nrs_value(fname,builtin_functions))
	__(la imm0,misc_data_offset(imm0))
	__(lwzx fname,fname,imm0)
	__(jump_fname())

_spentry(popj)
	.globl C(popj)
C(popj):
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(mtlr loc_pc)
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(la sp,lisp_frame.size(sp))
	__(blr)

_spentry(restorefullcontext)
	__(mflr loc_pc)
	__(mtctr loc_pc)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(mtlr loc_pc)
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(la sp,lisp_frame.size(sp))
	__(bctr)	

/* Like .SPrestorefullcontext, only the saved return address */
/* winds up in loc-pc instead of getting thrashed around ... */
_spentry(restorecontext)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(la sp,lisp_frame.size(sp))
	__(blr)


_spentry(savecontext0)
	__(stwu sp,-lisp_frame.size(sp))
	__(add imm0,vsp,imm0)
	__(stw fn,lisp_frame.savefn(sp))
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(stw imm0,lisp_frame.savevsp(sp))
	__(mr fn,nfn)
        __(b _SPcscheck)



_spentry(savecontextvsp)
	__(li imm0,0)
	__(b _SPsavecontext0)


/*
;;; Nargs is valid; all arg regs, lexpr-count pushed by caller.
;;; imm0 = vsp to restore.
;;; Return all values returned by caller to its caller, hiding
;;; the variable-length arglist.
;;; If we can detect that the caller's caller didn't expect
;;; multiple values, then things are even simpler.
*/
_spentry(lexpr_entry)
	__(ref_global(imm1,ret1val_addr))
	__(cmpw cr0,imm1,loc_pc)
	__(stwu sp,-lisp_frame.size(sp))
	__(stw fn,lisp_frame.savefn(sp))
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(stw imm0,lisp_frame.savevsp(sp))
	__(bne cr0,1f)
	__(ref_global(imm0,lexpr_return))
	__(stwu sp,-lisp_frame.size(sp))
	__(stw rzero,lisp_frame.savefn(sp))
	__(stw imm0,lisp_frame.savelr(sp))
	__(stw vsp,lisp_frame.savevsp(sp))
	__(mr loc_pc,imm1)
	__(li fn,0)
        __(b _SPcscheck)


/* The single-value case just needs to return to something that'll pop */
/* the variable-length frame off of the vstack. */
1:
	__(ref_global(loc_pc,lexpr_return1v))
	__(li fn,0)
        __(b _SPcscheck)


/*
;;; If arg_z is an integer, return in imm0 something whose sign
;;; is the same as arg_z's.  If not an integer, error.
*/
_spentry(integer_sign)
	__(extract_typecode(imm0,arg_z))
	__(cmpri(cr1,imm0,tag_fixnum))
	__(cmpri(cr0,imm0,subtag_bignum))
	__(mr imm0,arg_z)
	__(beqlr cr1)
	__(bne cr0,1f)
	__(getvheader(imm0,arg_z))
        __ifdef([PPC64])
         __(header_size(imm0,imm0))
         __(sldi imm0,imm0,2)
        __else
         __(header_length(imm0,imm0)) /* boxed length = scaled size */
        __endif
        __(addi imm0,imm0,misc_data_offset-4) /* bias, less 1 element */
	__(lwzx imm0,arg_z,imm0)
	__(cmpwi cr0,imm0,0)
	__(li imm0,1)
	__(bgelr cr0)
	__(li imm0,-1)
	__(blr)
1:
        __(bl _SPxuuo_interr)
	__(uuo_interr(error_object_not_integer,arg_z))

/*
;;; Prepend all but the first two (closure code, fn) and last two
;;; (function name, lfbits) elements of nfn to the "arglist".
;;; Doing things this way (the same way that 68K MCL does) lets
;;; functions which take "inherited arguments" work consistently
;;; even in cases where no closure object is created.
*/
_spentry(call_closure)        
	__(cmpwi cr0,nargs,nargregs<<fixnumshift)
	__(cmpwi cr1,nargs,fixnum_one)
	__(vector_length(imm0,nfn,imm0))
	__(subi imm0,imm0,4<<fixnumshift) /* imm0 = inherited arg count */
	__(li imm1,misc_data_offset+(2<<fixnumshift)) /* point to 1st arg */
	__(ble cr0,local_label(no_insert))
	/* Some arguments have already been vpushed.  Vpush imm0's worth */
	/* of NILs, copy those arguments that have already been vpushed from */
	/* the old TOS to the new, then insert all of the inerited args */
	/* and go to the function. */
	__(li imm2,0)
local_label(push_nil_loop):
	__(addi imm2,imm2,fixnum_one)
	__(cmpw cr2,imm2,imm0)
	__(vpush(rnil))
	__(bne cr2,local_label(push_nil_loop))

	__(mr imm3,vsp)
	__(add imm4,vsp,imm0)
	__(subi imm2,nargs,nargregs<<fixnumshift)
local_label(copy_already_loop):
	__(cmpwi cr2,imm2,fixnum_one)
	__(subi imm2,imm2,fixnum_one)
	__(lwz fname,0(imm4))
	__(addi imm4,imm4,fixnum_one)
	__(stw fname,0(imm3))
	__(addi imm3,imm3,fixnum_one)
	__(bne cr2,local_label(copy_already_loop))

local_label(insert_loop):
	__(cmpwi cr2,imm0,fixnum_one)
	__(lwzx fname,nfn,imm1)
	__(addi imm1,imm1,fixnum_one)
	__(addi nargs,nargs,fixnum_one)
	__(subi imm0,imm0,fixnum_one)
	__(push(fname,imm4))
	__(bne cr2,local_label(insert_loop))
	__(b local_label(go))
local_label(no_insert):
	/* nargregs or fewer args were already vpushed. */
	/* if exactly nargregs, vpush remaining inherited vars. */
	__(add imm2,imm1,imm0)
	__(bne cr0,local_label(set_regs))
local_label(vpush_remaining):
	__(cmpwi cr2,imm0,fixnum_one)
	__(lwzx fname,nfn,imm1)
	__(addi imm1,imm1,fixnum_one)
	__(vpush(fname))
	__(subi imm0,imm0,fixnum_one)
	__(addi nargs,nargs,fixnum_one)
	__(bne cr2,local_label(vpush_remaining))
	__(b local_label(go))
local_label(set_regs):
	/* if nargs was > 1 (and we know that it was < 3), it must have */
	/* been 2.  Set arg_x, then vpush the remaining args. */
	__(ble cr1,local_label(set_y_z))
local_label(set_arg_x):
	__(subi imm0,imm0,fixnum_one)
	__(cmpwi cr0,imm0,0)
	__(subi imm2,imm2,fixnum_one)
	__(lwzx arg_x,nfn,imm2)
	__(addi nargs,nargs,fixnum_one)
	__(bne cr0,local_label(vpush_remaining))
	__(b local_label(go))
	/* Maybe set arg_y or arg_z, preceding args */
local_label(set_y_z):
	__(bne cr1,local_label(set_arg_z))
	/* Set arg_y, maybe arg_x, preceding args */
local_label(set_arg_y):
	__(subi imm0,imm0,fixnum_one)
	__(cmpwi cr0,imm0,0)
	__(subi imm2,imm2,fixnum_one)
	__(lwzx arg_y,nfn,imm2)
	__(addi nargs,nargs,fixnum_one)
	__(bne cr0,local_label(set_arg_x))
	__(b local_label(go))
local_label(set_arg_z):
	__(subi imm0,imm0,fixnum_one)
	__(cmpwi cr0,imm0,0)
	__(subi imm2,imm2,fixnum_one)
	__(lwzx arg_z,nfn,imm2)
	__(addi nargs,nargs,fixnum_one)
	__(bne cr0,local_label(set_arg_y))

local_label(go):
	__(vref32(nfn,nfn,1))  /* vref32 */
	__(lwz temp0,_function.codevector(nfn))
        __(la loc_pc,misc_data_offset(temp0))
	__(mtctr loc_pc)
	__(bctr)

/* Go out of line to do this.  Sheesh. */

_spentry(vpopargregs)
	__(cmpri(cr0,nargs,0))
	__(cmpri(cr1,nargs,2<<fixnumshift))
	__(beqlr cr0)
	__(beq cr1,local_label(yz))
	__(blt cr1,local_label(z))
	__(ldr(arg_z,0(vsp)))  /* node_sizw*0 */
	__(ldr(arg_y,4(vsp)))
	__(ldr(arg_x,8(vsp)))
	__(la vsp,12(vsp))
	__(blr)
local_label(yz):
	__(ldr(arg_z,0(vsp)))
	__(ldr(arg_y,4(vsp)))
	__(la vsp,8(vsp))
	__(blr)
local_label(z):
	__(ldr(arg_z,0(vsp)))
	__(la vsp,4(vsp))
	__(blr)

/*		
;This (for better or worse) treats anything that's either
; (signed-byte 32), (unsigned-byte 32), (simple-base-string 4), or 
; (satisfies (lambda (s) (and (symbolp s) (typep (symbol-name s) '(simple-base-string 4)))
; as if it denoted a 32-bit value.
; Argument in arg_z, result in imm0.  May use temp0.
*/
_spentry(getxlong)
	__(extract_lisptag(imm0,arg_z))
	__(cmpwi imm0,tag_fixnum)
	__(cmpwi cr1,imm0,tag_misc)
	__(unbox_fixnum(imm0,arg_z))
	__(beqlr cr0)
	__(mr temp0,arg_z)
	__(bne cr1,local_label(error))
	__(getvheader(imm0,temp0))
	__(cmpwi cr0,imm0,symbol_header)
	__(cmpwi cr1,imm0,one_digit_bignum_header)
	__(cmpwi cr7,imm0,two_digit_bignum_header)
	__(bne cr0,local_label(not_sym))
	__(lwz temp0,symbol.pname(arg_z))
	__(getvheader(imm0,temp0))	
local_label(not_sym):
	__(cmpwi cr0,imm0,(4<<num_subtag_bits)|subtag_simple_base_string)
	__(beq cr1,local_label(big1))
	__(beq cr0,local_label(big1))
	__(bne cr7,local_label(extended))

local_label(big2):
	__(vref32(imm0,temp0,1))   /* sign digit must be 0 */
	__(cmpwi imm0,0)
	__(bne local_label(error))
local_label(big1):
	__(vref32(imm0,temp0,0))
	__(blr)

local_label(extended):
	/* Handle extended strings. Maybe later handle displaced strings */
	__(cmpwi cr0,imm0,(4<<num_subtag_bits)|subtag_simple_general_string)
        __(bne cr0,local_label(error))

	__(vref16(imm0,temp0,3))
	__(cmpwi cr0,imm0,256)
	__(vref16(imm1,temp0,2))
	__(cmpwi cr1,imm1,256)
	__(rlwimi imm0,imm1,8,16,23)
	__(vref16(imm1,temp0,1))
	__(bge cr0,local_label(error))
	__(cmpwi cr0,imm1,256)
	__(rlwimi imm0,imm1,16,8,15)
	__(vref16(imm1,temp0,0))
	__(bge cr1,local_label(error))
	__(cmpwi cr1,imm1,256)
	__(rlwimi imm0,imm1,24,0,7)
	__(bge cr0,local_label(error))
	__(bge cr1,local_label(error))
	__(blr)

local_label(error):
        __(bl _SPxuuo_interr)
	__(uuo_interr(error_object_not_integer,arg_z)) /* not quite right but what 68K MCL said */

/* Everything up to the last arg has been vpushed, nargs is set to 
   the (boxed) count of things already pushed. 
   On exit, arg_x, arg_y, arg_z, and nargs are set as per a normal 
   function call (this may require vpopping a few things.) 
   ppc2-invoke-fn assumes that temp1 is preserved here. */

_spentry(spreadargz)        
	 __(extract_lisptag(imm1,arg_z))
	 __(cmpwi cr1,imm1,tag_list)
	__(cmpw cr0,arg_z,rnil)
	__(li imm0,0)
	__(mr arg_y,arg_z)		/*  save in case of error */
	__(beq cr0,2f)
1:
	__(bne cr1,3f)
	__(_car(arg_x,arg_z))
	__(_cdr(arg_z,arg_z))
	__(cmpw cr0,arg_z,rnil)        
	__(extract_lisptag(imm1,arg_z))
	 __(cmpwi cr1,imm1,tag_list)
	__(vpush(arg_x))
	__(addi imm0,imm0,fixnum_one)
	__(bne cr0,1b)
2:
	__(add. nargs,nargs,imm0)
	__(cmpwi cr2,nargs,2<<fixnumshift)
	__(beqlr cr0)
	__(vpop(arg_z))
	__(bltlr cr2)
	__(vpop(arg_y))
	__(beqlr cr2)
	__(vpop(arg_x))
	__(blr)
/*  Discard whatever's been vpushed already, complain. */
3:	
	__(add vsp,vsp,imm0)
	__(mr arg_z,arg_y)		/* recover original arg_z */
	__(li arg_y,XNOSPREAD)
	__(set_nargs(2))
	__(b _SPksignalerr)



/*
;;; subtype (boxed, of course) is vpushed, followed by nargs bytes worth of
;;; initial-contents.  Note that this can be used to cons any type of initialized
;;; node-header'ed misc object (symbols, closures, ...) as well as vector-like
;;; objects.
;;; Note that we're guaranteed to win (or force GC, or run out of memory)
;;; because nargs < 32K.
*/
_spentry(gvector)
	__(lwzx arg_z,vsp,nargs)
	__(unbox_fixnum(imm0,arg_z))
	__(rlwimi imm0,nargs,num_subtag_bits-fixnum_shift,0,31-num_subtag_bits)
	__(addi imm1,nargs,4+7)
	__(clrrwi imm1,imm1,3)
        __(ref_global(extra,heap_limit))
        __(add freeptr,freeptr,imm1)
        __(leaf_do_xalloc())
	__(stw imm0,0(initptr))
	__(la arg_z,fulltag_misc(initptr))
	__(mr initptr,freeptr)
	__(mr imm1,nargs)
	__(addi imm2,imm1,misc_data_offset)
	__(b local_label(test))
local_label(loop):
	__(stwx temp0,arg_z,imm2)
local_label(test):
	__(subi imm1,imm1,4)
	__(cmpwi cr0,imm1,0)
	__(subi imm2,imm2,4)
	__(vpop(temp0))         /* Note the intentional fencepost:
				      discard the subtype as well. */
	__(bge cr0,local_label(loop))
	__(blr)

/* Provide default (NIL) values for &optional arguments; imm0 is 
   the (fixnum) upper limit on the total of required and &optional 
   arguments.  nargs is preserved, all arguments wind up on the 
   vstack. */
_spentry(default_optional_args)
	__(cmplw  cr7,nargs,imm0)
	__(vpush_argregs())
	__(mr imm1,nargs)
	__(bgelr cr7)
1:	
	__(addi imm1,imm1,fixnum_one)
	__(cmpw cr0,imm1,imm0)
	__(vpush(rnil))
	__(bne cr0,1b)
	__(blr)

/* Indicate whether &optional arguments were actually supplied.  nargs 
   contains the actual arg count (minus the number of required args); 
   imm0 contains the number of &optional args in the lambda list. 
   Note that nargs may be > imm0 if &rest/&key is involved. */
_spentry(opt_supplied_p)
	__(li imm1,0)
1:
	/* (vpush (< imm1 nargs)) */
        
	 __(xor imm2,imm1,nargs)
	 __(srawi imm2,imm2,31)
	 __(or imm2,imm2,imm1)
	 __(addi imm1,imm1,fixnumone)
	 __(cmpw cr0,imm1,imm0)
	 __(subf imm2,nargs,imm2)
	 __(srwi imm2,imm2,31)
	 __(insrwi imm2,imm2,1,27)
	 __(add imm2,rnil,imm2)
	 __(vpush(imm2))
	 __(bne cr0,1b)
	 __(blr)


/* If nargs is <= imm0, vpush a nil.  Otherwise, cons a list of length 
   (- nargs imm0) and vpush it. 
   Use this entry point to heap-cons a simple &rest arg. */
_spentry(heap_rest_arg)
	__(li imm0,0)
	__(vpush_argregs())
	__(b local_label(heap_rest_common))

        


/* And this entry point when the argument registers haven't yet been 
   vpushed (as is typically the case when required/&rest but no &optional/&key.) */

_spentry(req_heap_rest_arg)
	__(vpush_argregs())
	__(b local_label(heap_rest_common))

_spentry(heap_cons_rest_arg)
local_label(heap_rest_common):
 	__(sub imm1,nargs,imm0)
        __(cmpwi cr0,imm1,0)
	__(mr arg_z,rnil)
	__(ble cr0,2f)  /* done */
        __(add imm1,imm1,imm1)
        __(ref_global(extra,heap_limit))
        __(add freeptr,freeptr,imm1)
        __(early_leaf_do_xalloc())
        __(la arg_y,-cons.size+fulltag_cons(freeptr))
1: /* @loop: */	
	__(subi imm1,imm1,8)
	__(cmpwi cr0,imm1,0)
	__(vpop(arg_x))
        __(_rplacd(arg_y,arg_z))
	__(_rplaca(arg_y,arg_x))
        __(mr arg_z,arg_y)
        __(la arg_y,-cons.size(arg_y))
        __(bne cr0,1b)
2: /* @done: */	
        __(vpush(arg_z))
        __(mr initptr,freeptr)
        __(blr)


/* As in the heap-consed cases, only stack-cons the &rest arg */
_spentry(stack_rest_arg)
	__(li imm0,0)
	__(vpush_argregs())
        __(b local_label(stack_rest_common))

	
_spentry(req_stack_rest_arg)
	__(vpush_argregs())
        __(b local_label(stack_rest_common))
	
_spentry(stack_cons_rest_arg)
local_label(stack_rest_common):
	__(sub imm1,nargs,imm0)
	__(cmpwi cr0,imm1,0)
	__(cmpwi cr1,imm1,(4096-8)/2)
	__(mr arg_z,rnil)
	__(ble cr0,3f)		/* always temp-push something. */
        __(bge cr1,4f)
	__(add imm1,imm1,imm1)
	__(neg imm2,imm1)
	__(subi imm2,imm2,8)
	__(mr initptr,tsp)	/*  uninterruptable */
	__(stwux tsp,tsp,imm2)
	__(sub initptr,tsp,imm2)
	__(la arg_y,-cons.size+fulltag_cons(initptr))
1: /* @loop: */
	__(cmpwi cr0,imm1,8)	/* last time through ? */
	__(subi imm1,imm1,8)
	__(vpop(arg_x))
	__(_rplacd(arg_y,arg_z))
	__(_rplaca(arg_y,arg_x))
	__(mr arg_z,arg_y)
	__(la arg_y,-cons.size(arg_y))
	__(bne cr0,1b)
        __(stw rzero,4(tsp))
	__(mr initptr,freeptr)
	__(vpush(arg_z))
	__(blr)
3:  /* @nil: */
	__(stwu tsp,-8(tsp))
	__(stw rzero,4(tsp))
	__(vpush(arg_z))
	__(blr)
4: /* @too_big:  */
	__(stwu tsp,-8(tsp))
	__(stw rzero,4(tsp))
	__(b local_label(heap_rest_common))


_spentry(simple_keywords)
	__(li imm0,0)
        __(vpush_argregs())
        __(b local_label(keywordbind))
                
_spentry(keyword_args)
	__(vpush_argregs())
        __(b local_label(keywordbind))


/* Treat the last (- nargs imm0) values on the vstack as keyword/value 
   pairs.  There'll be imm3 keyword arguments.  Imm2 contains flags 
   that indicate whether &allow-other-keys was specified and whether 
   or not to leave the keyword/value pairs on the vstack for an &rest 
   argument.  Temp3 contains a vector of keyword specifiers which we 
   must (in general) match. 
   If the number of arguments is greater than imm0, the difference must 
   be even. 
   Note that the caller hasn't yet saved its caller's context and that 
   the temp registers used to pass closure_data (temp0) and next_method_context 
   (temp1) may still have "live" values in them, as does nfn (temp2). */

define([keyword_flags],[imm2])
define([keyword_vector],[temp3])
define([keyword_count],[imm3])



define([varptr],[save0])
define([valptr],[save1])
define([limit],[save2])

_spentry(keyword_bind)
local_label(keywordbind):
	/* Before we can really do anything, we have to */
	/* save the caller's context.  To do so, we need to know */
	/* how many args have actually been pushed.  Ordinarily, that'd */
	/* be "nargs", but we may have pushed more args than we received */
	/* if we had to default any &optionals. */
	/* So, the number of args pushed so far is the larger of nargs */
	/* and the (canonical) total of required/&optional args received. */
	__(cmpw cr0,nargs,imm0)
	__(add arg_z,vsp,nargs)
	__(bge cr0,1f)
	__(add arg_z,vsp,imm0)
1:
	/* __(build_lisp_frame(fn,loc_pc,arg_z))  */  /* in macros.s */
	__(stwu sp,-lisp_frame.size(sp))
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(stw arg_z,lisp_frame.savevsp(sp))
	__(stw fn,lisp_frame.savefn(sp))
	__(mr fn,nfn)
	/* If there are key/value pairs to consider, we slide them down */
	/* the vstack to make room for the value/supplied-p pairs. */
	/* The first step in that operation involves pushing imm3 pairs */
	/* of NILs. */
	/* If there aren't any such pairs, the first step is the last */
	/* step. */
	__(cmpwi cr0,imm3,0)
	__(li arg_z,0)
	__(sub imm1,nargs,imm0)
	__(mr imm4,vsp)	/* in case odd keywords error */
	__(cmpwi cr1,imm1,0)
	__(b 3f)
2:
	__(addi arg_z,arg_z,fixnum_one)
	__(cmplw cr0,arg_z,imm3)
	__(vpush(rnil))
	__(vpush(rnil))
3:
	__(bne cr0,2b)
	__(andi. arg_z,imm1,fixnum_one)
	__(blelr cr1)	/* no keyword/value pairs to consider. */
	__(bne cr0,odd_keywords)
	/* We have key/value pairs.  Move them to the top of the vstack, */
	/* then set the value/supplied-p vars to NIL. */
	/* Have to use some save regs to do this. */
	__(vpush(limit))
	__(vpush(valptr))
	__(vpush(varptr))
	/* recompute ptr to user args in case stack overflowed */
	__(add imm4,vsp,imm3)
	__(add imm4,imm4,imm3)
	__(addi imm4,imm4,3*node_size)
	/* error if odd number of keyword/value args */
	__(mr varptr,imm4)
	__(la limit,3*node_size(vsp))
	__(mr valptr,limit)
	__(mr arg_z,imm1)
4:
	__(subi arg_z,arg_z,2<<fixnumshift)
	__(cmplri(cr0,arg_z,0))
	__(ldr(arg_x,node_size*0(varptr)))
	__(ldr(arg_y,node_size*1(varptr)))
	__(str(rnil,node_size*0(varptr)))
	__(str(rnil,node_size*1(varptr)))
	__(la varptr,node_size*2(varptr))
	__(str(arg_x,node_size*0(valptr)))
	__(str(arg_y,node_size*1(valptr)))
	__(la valptr,node_size*2(valptr))
	__(bne cr0,4b)
/* Now, iterate through each supplied keyword/value pair.  If 
   it's :allow-other-keys and the corresponding value is non-nil, 
   note that other keys will be allowed. 
   Find its position in the function's keywords vector.  If that's 
   nil, note that an unknown keyword was encountered. 
   Otherwise, if the keyword arg hasn't already had a value supplied, 
   supply it. 
   When done, complain if any unknown keywords were found and that 
   situation was unexpected. */
	__(mr imm4,valptr)
5:
        __(cmpri(cr0,keyword_flags,16<<fixnumshift)) /* seen :a-o-k yet ? */
	__(ldru(arg_z,-node_size(valptr)))
	__(ldru(arg_y,-node_size(valptr)))
	__(cmpw cr1,arg_y,rnil)
	__(la arg_x,nrs.kallowotherkeys(rnil))
        /* cr6_eq <- (eq current-keyword :allow-other-keys) */
	__(cmpr(cr6,arg_x,arg_z))
	__(cmpr(cr7,valptr,limit))
	__(bne cr6,6f)
        __(bge cr0,6f) /* Already seen :allow-other-keys */
        __(ori keyword_flags,keyword_flags,16<<fixnumshift)
	__(beq cr1,6f)
	__(ori keyword_flags,keyword_flags,fixnum_one)
6:
	__(cmpri(cr1,imm3,0))
	__(li imm1,misc_data_offset)
	__(li imm0,0)
	__(b 8f)
7:
	__(addi imm0,imm0,fixnum_one)
	__(cmpr(cr1,imm0,imm3))
	__(ldrx(arg_x,keyword_vector,imm1))
	__(cmpr(cr0,arg_x,arg_z))
	__(addi imm1,imm1,fixnum_one)
	__(bne cr0,8f)
	__(add imm0,imm0,imm0)
	__(sub imm0,varptr,imm0)
	__(ldr(arg_x,0(imm0)))
	__(cmpw cr0,arg_x,rnil)
	__(la arg_z,t_offset(rnil))
	__(bne cr0,9f)
	__(str(arg_y,node_size(imm0)))
	__(str(arg_z,0(imm0)))
	__(b 9f)
8:
	__(bne cr1,7b)
	/* Unknown keyword. If it was :allow-other-keys, cr6_eq will still
           be set. */
        __(beq cr6,9f)
	__(ori keyword_flags,keyword_flags,2<<fixnumshift)
9:
	__(bne cr7,5b)
	__(vpop(varptr))
	__(vpop(valptr))
	__(vpop(limit))
	/* All keyword/value pairs have been processed. */
	/* If we saw an unknown keyword and didn't expect to, error. */
	/* Unless bit 2 is set in the fixnum in keyword_flags, discard the */
	/* keyword/value pairs from the vstack. */
	__(andi. imm0,keyword_flags,(fixnum_one)|(2<<fixnumshift))
	__(cmpri(cr0,imm0,2<<fixnumshift))
	__(beq cr0,badkeys)
	__(andi. imm2,keyword_flags,4<<fixnumshift)
	__(bnelr cr0)
	__(mr vsp,imm4)
	__(blr)

/* stuff formerly in sp_vref */

_spentry(misc_ref)
	__(leaf_trap_unless_uvector(arg_y,imm0))
	__(leaf_trap_unless_fixnum(arg_z,imm0))
	__(vector_length(imm0,arg_y,imm1))
        __(cmplw arg_z,imm0)
	__(extract_lowbyte(imm1,imm1))	/* imm1 = subtag */
        __(bge vref_oob)

/* Reference index arg_z of a misc-tagged object (arg_y). 
   Note that this conses in some cases.  Return a properly-tagged 
   lisp object in arg_z.  Do type and bounds-checking. 
*/
local_label(misc_ref_common):   
	 __(extract_fulltag(imm2,imm1))
	 __(cmpri(cr0,imm2,fulltag_nodeheader))
	 __(cmpri(cr1,imm1,max_32_bit_ivector_subtag))
	 __(cmpri(cr2,imm1,max_8_bit_ivector_subtag))
	 __(addi imm0,arg_z,misc_data_offset)
	 __(bne cr0,local_label(ref_imm))
	 /* A node vector. */
	 __(ldrx(arg_z,arg_y,imm0))
	 __(blr)
local_label(ref_imm):
	 __(bgt cr1,local_label(ref_not32))
	 __(cmpri(cr1,imm1,subtag_single_float_vector))
	 __(cmpri(cr0,imm1,subtag_s32_vector))
	 __(ldrx(imm0,arg_y,imm0))
	 __(beq cr1,local_label(ref_sfloat))
	 __(beq cr0,local_label(ref_signed))
local_label(ref_unsigned):	 
	 __(srawi. imm1,imm0,31-nfixnumtagbits)
	 __(box_fixnum(arg_z,imm0))
	 __(beqlr cr0)
         __(b _SPbox_unsigned)
local_label(ref_signed):
	 __(mtxer rzero)  /* __(mcrxr cr0) */
	 __(addo imm1,imm0,imm0)
	 __(addo. arg_z,imm1,imm1)
	 __(bnslr)
         __(mtxer rzero)
         __(b _SPbox_signed)
	
local_label(ref_sfloat):        
	 __(li imm1,(1<<num_subtag_bits)|subtag_single_float)
         __(ref_global(extra,heap_limit))
         __(la freeptr,single_float.size(freeptr))
         __(leaf_do_xalloc())
         __(stw imm1,0(initptr))
         __(stw imm0,4(initptr))
         __(la arg_z,fulltag_misc(initptr))
         __(mr initptr,freeptr)
         __(blr)
local_label(ref_not32):	
	 __(cmpri(cr1,imm1,max_16_bit_ivector_subtag))
	 __(bgt cr2,local_label(ref_not8))
	 /* 8-bit objects are either u8, s8, or base_strings. */
	 /* cr2_eq is set if base_string (= max_8_bit_ivector_subtag) */
	 __(cmpri(cr1,imm1,subtag_s8_vector))
	 __(srwi imm0,arg_z,2)
	 __(la imm0,misc_data_offset(imm0))
	 __(lbzx imm0,arg_y,imm0)
	 __(beq cr2,local_label(ref_char))
	 __(bne cr1,local_label(ref_box))
	 __(extsb imm0,imm0)
local_label(ref_box):	
	 __(box_fixnum(arg_z,imm0))
	 __(blr)
local_label(ref_char):	
	 __(slwi arg_z,imm0,charcode_shift)
	 __(ori arg_z,arg_z,subtag_character)
	 __(blr)
local_label(ref_not8):
	 __(cmpri(cr2,imm1,subtag_bit_vector))
	 __(bgt cr1,local_label(ref_not16))
	 /* 16-bit objects are either u16, s16, or general_strings. */
	 /* cr1_eq is set if s16_vector (= max_16_bit_ivector_subtag) */
	 __(cmpri(cr0,imm1,subtag_simple_general_string))
	 __(srwi imm0,arg_z,1)
	 __(la imm0,misc_data_offset(imm0))
	 __(lhzx imm0,arg_y,imm0)
	 __(beq cr0,local_label(ref_char))
	 __(bne cr1,local_label(ref_box))
	 __(extsh imm0,imm0)
	 __(b local_label(ref_box))
local_label(ref_not16):
	 __(bne cr2,local_label(ref_dfloat))
	 __(extrwi imm1,arg_z,5,32-(fixnumshift+5))	/* imm1 = bitnum */
	 __(la imm1,1+fixnumshift(imm1))
	 __(rlwinm imm0,arg_z,32-5,5,31-fixnumshift)
	 __(la imm0,misc_data_offset(imm0))
	 __(ldrx(imm0,arg_y,imm0))
	 __(rlwnm arg_z,imm0,imm1,31-fixnumshift,31-fixnumshift)
	 __(blr)
local_label(ref_dfloat):
	 __(slwi imm0,arg_z,1)
	 __(la imm0,misc_dfloat_offset(imm0))
	 __(la imm1,4(imm0))
	 __(lwzx imm0,arg_y,imm0)
	 __(lwzx imm1,arg_y,imm1)
	 __(li imm2,(double_float.element_count<<num_subtag_bits)|subtag_double_float)
         __(ref_global(extra,heap_limit))
         __(la freeptr,double_float.size(freeptr))
         __(leaf_do_xalloc())
	 __(la arg_z,fulltag_misc(initptr))
         __(stw imm2,double_float.header(arg_z))
	 __(stw imm0,double_float.value(arg_z))
	 __(stw imm1,double_float.value+4(arg_z))
         __(mr initptr,freeptr)
	 __(blr)



/* like misc_ref, only the boxed subtag is in arg_x. 
*/
_spentry(subtag_misc_ref)
	__(leaf_trap_unless_uvector(arg_y,imm0))
        __(leaf_trap_unless_fixnum(arg_z,imm0))
	__(vector_length(imm0,arg_y,imm1))
        __(cmplw arg_z,imm0)
	__(unbox_fixnum(imm1,arg_x))
        __(bge vref_oob)
        __(b local_label(misc_ref_common))
vref_oob:
        __(mr temp0,arg_y)
        __(mr arg_y,arg_z)
        __(mr arg_z,temp0)
        __(li arg_x,XARROOB)
        __(set_nargs(3))
        __(b _SPksignalerr)
         
       

/* like misc_set, only pass the (boxed) subtag in temp0 */
_spentry(subtag_misc_set)
        __(leaf_trap_unless_uvector(arg_x,imm0))
        __(leaf_trap_unless_fixnum(arg_y,imm0))
	__(vector_length(imm0,arg_x,imm1))
        __(cmplw arg_y,imm0)
	__(unbox_fixnum(imm1,temp0))
        __(bge vset_oob)
	__(b local_label(misc_set_common))
vset_oob:        
        __(mr arg_z,arg_x)
        __(set_nargs(3))
        __(li arg_x,XARROOB)
        __(b _SPksignalerr)
                 

/* misc_set (vector index newval) : if a node object, may need to
;;; memoize the assignment.  Otherwise, pretty damned similar to
;;; misc_ref, as one might imagine. */
_spentry(misc_set)
        __(leaf_trap_unless_uvector(arg_x,imm0))
        __(leaf_trap_unless_fixnum(arg_y,imm0))
	__(vector_length(imm0,arg_x,imm1))
        __(cmplw arg_y,imm0)
	__(extract_lowbyte(imm1,imm1))
        __(bge vset_oob)
local_label(misc_set_common):	
	__(extract_fulltag(imm2,imm1))
	__(cmpwi cr0,imm2,fulltag_nodeheader)
	__(cmpwi cr1,imm1,max_32_bit_ivector_subtag)
	__(cmpwi cr2,imm1,max_8_bit_ivector_subtag)
	__(addi imm0,arg_y,misc_data_offset)
	__(bne cr0,local_label(misc_set_imm))
	/* A node vector. If value is other than fixnum, tag_imm, nil, */
	/* need to memoize for EGC. */
	__(cmpw cr0,arg_z,rnil)
	__(extract_lisptag(imm2,arg_z))
	__(cmpwi cr1,imm2,tag_imm)
	__(cmpwi cr2,imm2,tag_fixnum)
	__(beq cr0,local_label(misc_set_simple))
	__(beq cr1,local_label(misc_set_simple))
	__(beq cr2,local_label(misc_set_simple))
	__(add loc_g,arg_x,imm0)
	__(stw arg_z,0(loc_g))
	__(b _SPwrite_barrier)
local_label(misc_set_simple):
	__(stwx arg_z,arg_x,imm0)
	__(blr)
local_label(misc_set_imm):
	__(extract_lisptag(imm2,arg_z))
	__(cmpwi cr7,imm2,tag_misc)
	__(cmpwi cr5,imm2,tag_fixnum)
	__(bgt cr1,local_label(misc_set_not32))
	__(cmpwi cr1,imm1,subtag_single_float_vector)
	__(cmpwi cr0,imm1,subtag_s32_vector)
	__(beq cr1,local_label(misc_set_sfloat))
	__(beq cr0,local_label(misc_set_signed))
	/* Either a non-negative fixnum, a one-digit bignum, or a two-digit */
	/* bignum whose sign-digit is 0 is ok. */
	__(srawi. imm1,arg_z,fixnum_shift)
	__(bne cr5,local_label(misc_set_not_fixnum_u32))
	__(blt cr0,local_label(misc_set_bad))
local_label(misc_set_set32):	
	__(stwx imm1,arg_x,imm0)
	__(blr)
local_label(misc_set_not_fixnum_u32):
	__(bne cr7,local_label(misc_set_bad))
	__(extract_header(imm2,arg_z))
	__(cmpwi cr0,imm2,one_digit_bignum_header)
	__(cmpwi cr1,imm2,two_digit_bignum_header)
	__(vref32(imm1,arg_z,0))
	__(cmpwi cr2,imm1,0)
	__(bne cr0,local_label(misc_set_not_1_digit))
	__(bge cr2,local_label(misc_set_set32))
	__(b local_label(misc_set_bad))
local_label(misc_set_not_1_digit):
	__(bne cr1,local_label(misc_set_bad))
	__(vref32(imm2,arg_z,1))
	__(cmpwi cr0,imm2,0)
	__(bne cr1,local_label(misc_set_bad))
	__(beq cr0,local_label(misc_set_set32))
local_label(misc_set_bad):
	/* arg_z doesn't match the array-element-type of arg_x. */
	__(mr arg_y,arg_z)
	__(mr arg_z,arg_x)
	__(li arg_x,XNOTELT)
	__(set_nargs(3))
	__(b _SPksignalerr)  /* ?? */
local_label(misc_set_signed):
	__(unbox_fixnum(imm1,arg_z))
	__(beq cr5,local_label(misc_set_set32))
	__(bne cr7,local_label(misc_set_bad))
	__(extract_header(imm2,arg_z))
	__(cmpwi cr0,imm2,one_digit_bignum_header)
	__(vref32(imm1,arg_z,0))
	__(bne cr0,local_label(misc_set_bad))
	__(stwx imm1,arg_x,imm0)
	__(blr)
local_label(misc_set_sfloat):
	__(bne cr7,local_label(misc_set_bad))
	__(extract_header(imm2,arg_z))
	__(cmpwi cr0,imm2,single_float_header)
        __(bne cr0,local_label(misc_set_bad))
	__(lwz imm1,single_float.value(arg_z))
	__(stwx imm1,arg_x,imm0)
	__(blr)
	
local_label(misc_set_not32):
	__(cmpwi cr1,imm1,max_16_bit_ivector_subtag)
	__(bgt cr2,local_label(misc_set_not8))
	/* 8-bit objects are either u8, s8, or base_strings. */
	/* cr2_eq is set if base_string (= max_8_bit_ivector_subtag) */
	__(cmpwi cr1,imm1,subtag_s8_vector)
	__(extract_lisptag(imm2,arg_z))
	__(srwi imm0,arg_y,2)
	__(la imm0,misc_data_offset(imm0))
	__(extract_unsigned_byte_bits_(imm1,arg_z,8))
	__(beq cr2,local_label(misc_set_char8))
	__(beq cr1,local_label(misc_set_signed8))
	__(unbox_fixnum(imm1,arg_z))
	__(bne cr0,local_label(misc_set_bad))
	__(stbx imm1,arg_x,imm0)
	__(blr)
local_label(misc_set_char8):
	__(extract_lowbyte(imm2,arg_z))
	__(cmpwi cr2,imm2,subtag_character)
	__(srwi imm1,arg_z,charcode_shift)
	__(bne cr2,local_label(misc_set_bad))
	__(stbx imm1,arg_x,imm0)
	__(blr)
local_label(misc_set_signed8):
	__(unbox_fixnum(imm1,arg_z))
	__(extsb imm2,imm1)
	__(cmpw cr0,imm2,imm1)
	__(bne cr5,local_label(misc_set_bad))
	__(bne cr0,local_label(misc_set_bad))
	__(stbx imm1,arg_x,imm0)
	__(blr)
local_label(misc_set_not8):
	__(cmpwi cr2,imm1,subtag_bit_vector)
	__(bgt cr1,local_label(misc_set_not16))
	/* 16-bit objects are either u16, s16, or general_strings. */
	/* cr1_eq is set if s16_vector (= max_16_bit_ivector_subtag) */
	__(cmpwi cr0,imm1,subtag_simple_general_string)
	__(srwi imm0,arg_y,1)
	__(la imm0,misc_data_offset(imm0))
	__(beq cr1,local_label(misc_set_s16))
	__(beq cr0,local_label(misc_set_char16))
	__(extract_unsigned_byte_bits_(imm1,arg_z,16))
	__(unbox_fixnum(imm1,arg_z))
	__(bne cr0,local_label(misc_set_bad))
	__(sthx imm1,arg_x,imm0)
	__(blr)
local_label(misc_set_s16):
	__(unbox_fixnum(imm1,arg_z))
	__(extsh imm2,imm1)
	__(cmpw cr0,imm2,imm1)
	__(bne cr5,local_label(misc_set_bad))
	__(bne cr0,local_label(misc_set_bad))
	__(sthx imm1,arg_x,imm0)
	__(blr)
local_label(misc_set_char16):
	__(extract_lowbyte(imm2,arg_z))
	__(cmpwi cr0,imm2,subtag_character)
	__(srwi imm1,arg_z,charcode_shift)
	__(bne cr0,local_label(misc_set_bad))
	__(sthx imm1,arg_x,imm0)
	__(blr)
local_label(misc_set_not16):
	__(bne cr2,local_label(misc_set_dfloat))
	/* Bit vector case. */
	__(cmplwi cr2,arg_z,fixnumone)   /* nothing not a (boxed) bit */ 
	__(extrwi imm1,arg_y,5,32-(fixnumshift+5))	/* imm1 = bitnum */
	__(extlwi imm2,arg_z,1,31-fixnumshift)
	__(srw imm2,imm2,imm1)
	__(lis imm3,0x8000)
	__(rlwinm imm0,arg_y,32-5,5,31-fixnumshift)
	__(la imm0,misc_data_offset(imm0))
	__(srw imm3,imm3,imm1)
	__(bgt cr2,local_label(misc_set_bad))
	__(lwzx imm1,arg_x,imm0)
	__(andc imm1,imm1,imm3)
	__(or imm1,imm1,imm2)
	__(stwx imm1,arg_x,imm0)
	__(blr)

local_label(misc_set_dfloat):	
	__(bne cr7,local_label(misc_set_bad))		/* not tag_misc */
	__(extract_header(imm2,arg_z))
	__(cmpwi cr0,imm2,double_float_header)
        __(slwi imm0,arg_y,1)  /*  imm0 gets index * 2 */
	__(la imm0,misc_dfloat_offset(imm0)) /* + offset */
	__(bne cr0,local_label(misc_set_bad))
	__(lwz imm1,double_float.value(arg_z)) /* get value parts */
	__(lwz imm2,double_float.value+4(arg_z))
	__(stwx imm1,arg_x,imm0)
	__(la imm0,4(imm0))
	__(stwx imm2,arg_x,imm0)
	__(blr)


/* end stuff from sp_vref.s */




/* Signal an error.  We saved context on entry, so this thing doesn't 
   have to. 
   The "unknown keywords" error could be continuable (ignore them.) 
   It might be hard to then cons an &rest arg. 
   In the general case, it's hard to recover the set of args that were 
   actually supplied to us ... */
/* For now, just cons a list out of the keyword/value pairs
   that were actually provided, and signal an "invalid keywords"
   error with that list as an operand. */
odd_keywords:
	__(mr vsp,imm4)
	__(mr nargs,imm1)
	__(b 1f)
badkeys:
	__(sub nargs,imm4,vsp)
1:
	__(bl _SPconslist)
	__(li arg_y,XBADKEYS)
	__(set_nargs(2))
	__(b _SPksignalerr)

/* from sp_heap_cons.s */
_spentry(conslist)
	__(mr arg_z,rnil)
	      /* can we just fall in */
 
_spentry(conslist_star)
        __(cmpwi nargs,0)
	__(add imm0,nargs,nargs)
        __(add freeptr,freeptr,imm0)
        __(ref_global(extra,heap_limit))
        __(leaf_do_xalloc())
	__(la initptr,-8+fulltag_cons(freeptr))
	__(b local_label(init_list_from_stack))
local_label(init_list_from_stack_loop):
	__(lwz temp0,0(vsp))
	__(cmpwi nargs,fixnum_one)
	__(la vsp,4(vsp))
	__(stw arg_z,cons.cdr(initptr))
	__(subi nargs,nargs,fixnum_one)
	__(stw temp0,cons.car(initptr))
	__(mr arg_z,initptr)
	__(subi initptr,initptr,8)
local_label(init_list_from_stack):
	__(bne local_label(init_list_from_stack_loop))
	__(mr initptr,freeptr)
	__(blr)


_spentry(misc_alloc)
	 __(extract_unsigned_byte_bits_(imm2,arg_y,24))
	 __(unbox_fixnum(imm0,arg_z))
	 __(extract_fulltag(imm1,imm0))
	 __(bne cr0,9f)
	 __(cmpri(cr0,imm1,fulltag_nodeheader))
	 __(mr imm3,imm0)
	 __(cmplri(cr1,imm0,max_32_bit_ivector_subtag))
	 __(rlwimi imm0,arg_y,num_subtag_bits-fixnum_shift,0,31-num_subtag_bits	/* imm0 now = header */)
	 __(mr imm2,arg_y)
	 __(beq cr0,1f)	/* do probe if node object (fixnum element count = byte count). */
	 __(cmplri(cr0,imm3,max_16_bit_ivector_subtag))
	 __(bng cr1,1f)	/* do probe if 32-bit imm object */
	 __(cmplri(cr1,imm3,max_8_bit_ivector_subtag))
	 __(srwi imm2,imm2,1)
	 __(bgt cr0,2f)
	 __(bgt cr1,1f)
	 __(srwi imm2,imm2,1)
/* imm2 now = byte count.  Add 4 for header, 7 to align, then clear low three bits. */
1:
        __(addi imm2,imm2,4+7)
	__(clrrwi imm2,imm2,3)
/* The freepointer needs to advance by imm2 bytes, if possible.  Advancing it may write to a protected
;;; group of 8 4K pages, and doing so may trigger a GC.  That's all transparent to us.
;;; What's not transparent is that we can only do this if we're allocating 32K bytes or less; otherwise,
;;; we'll have to think a bit harder.
*/
        __(add freeptr,freeptr,imm2)
        __(ref_global(extra,heap_limit))
        __(leaf_do_xalloc())
	__(stw imm0,0(initptr))
	__(la arg_z,fulltag_misc(initptr))
	__(mr initptr,freeptr)
	__(blr)
2:
	 __(cmplri(imm3,subtag_double_float_vector))
	 __(slwi imm2,arg_y,1)
	 __(beq 1b)
	 __(addi imm2,arg_y,7<<fixnumshift)
	 __(srwi imm2,imm2,fixnumshift+3)
	 __(b 1b)
9:
         __(bl _SPxuuo_interr)
	 __(uuo_interr(error_object_not_unsigned_byte_24,arg_y))

/* Like misc_alloc (a LOT like it, since it does most of the work), but takes */
/* an initial-value arg in arg_z, element_count in arg_x, subtag in arg_y. */
/* Calls out to %init-misc, which does the rest of the work. */

_spentry(misc_alloc_init)
	__(mflr loc_pc)
        __(stwu sp,-lisp_frame.size(sp))
        __(stw fn,lisp_frame.savefn(sp))
        __(stw loc_pc,lisp_frame.savelr(sp))
        __(stw vsp,lisp_frame.savevsp(sp))
	/* __(build_lisp_frame(fn,loc_pc,vsp)) */
	__(li fn,0)
	__(mr temp0,arg_z)		/* initval */
	__(mr arg_z,arg_y)		/* subtag */
	__(mr arg_y,arg_x)		/* element-count */
	__(bl _SPmisc_alloc)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(mtlr loc_pc)
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz vsp,lisp_frame.savevsp(sp)) 
	/* __(discard_lisp_frame()) */
        __(la sp,lisp_frame.size(sp))
        __(la fname,nrs.init_misc(rnil))
	__(set_nargs(2))
	__(mr arg_y,temp0)
	__(jump_fname())

_spentry(newblocktag)
        __(ref_global(imm0,block_tag_counter))  /* is this defined? */
	__(addi imm0,imm0,1<<num_subtag_bits)
	__(cmpri(imm0,0))
	__(ori arg_z,imm0,subtag_block_tag)
	__(beq local_label(cons_nil_nil))
        __(set_global(imm0,block_tag_counter))
	__(blr)

local_label(cons_nil_nil):
        __(ref_global(extra,heap_limit))
        __(la freeptr,cons.size(freeptr))
        __(leaf_do_xalloc())
	__(la arg_z,fulltag_cons(initptr))
	__(stw rnil,cons.car(arg_z))
	__(stw rnil,cons.cdr(arg_z))
	__(mr initptr,freeptr)
	__(blr)

_spentry(newgotag)
	__(ref_global(imm0,go_tag_counter))
	__(addi imm0,imm0,1<<num_subtag_bits)
	__(cmpwi imm0,0)
	__(ori arg_z,imm0,subtag_go_tag)
	__(beq local_label(cons_nil_nil))
	__(set_global(imm0,go_tag_counter))
	__(blr)

/* from sp_ffi.s */

_spentry(unused)
        __(b _SPbreakpoint)
_spentry(unused1)
        __(b _SPbreakpoint)

/* Enter the debugger */
_spentry(breakpoint)
	__(li r3,0)
	__(tw 28,sp,sp)		/* 28 = lt|gt|eq (assembler bug for the latter) */
	__(blr)			/* if handler didn't */


	
/* This subprim is used by the trap expansion code.
;;; It takes a shared-library-entry-point (slep) instance in arg_z and
;;; the other arguments as for ffcall.
;;; If (slep.address slep) is non-nil, it is the (fixnum) address of the function to call.
;;; Otherwise, call back to resolve-slep-address to look up the address. */
_spentry(ffcallslep)
	__(mr arg_y,arg_z)
	__(vref32(arg_z,arg_z,1))                   /* (slep.address slep) */
	__(cmpw cr0,arg_z,rnil)
	__(bne cr0,_SPffcalladdress)

	/* this matches the code between ffcalladdress & ffcalladdress_proper */
	__(mflr loc_pc)
	__(stw rzero,c_frame.savelr(sp))           /* make sure stack overflow code skips this frame */
	__(vpush_saveregs())
	__(lwz imm1,0(sp))
	__(la imm2,-lisp_frame.size(imm1))
	__(stw imm1,0(imm2))
	__(stw imm2,0(sp))
	__(stw loc_pc,lisp_frame.savelr(imm2))
	__(stw vsp,lisp_frame.savevsp(imm2))
	__(stw fn,lisp_frame.savefn(imm2))

	/* Save the floating point registers in a new stack frame
	;; Can't use temp stack here (unless we pushed a catch frame),
	;; since apply-in-frame wouldn't know about the extra temp stack frame.
	*/
	__(stwu imm2,-(13*8 + 8 + lisp_frame.size)(sp))  /* round up to 16 byte align */
	__(stw rzero,lisp_frame.savelr(sp))
	__(la imm1,lisp_frame.size-8(sp))
	__(stfdu f1,8(imm1))  /* these were e.g. fp1 */
	__(stfdu f2,8(imm1))
	__(stfdu f3,8(imm1))
	__(stfdu f4,8(imm1))
	__(stfdu f5,8(imm1))
	__(stfdu f6,8(imm1))
	__(stfdu f7,8(imm1))
	__(stfdu f8,8(imm1))
	__(stfdu f9,8(imm1))
	__(stfdu f10,8(imm1))
	__(stfdu f11,8(imm1))
	__(stfdu f12,8(imm1))
	__(stfdu f13,8(imm1))

	/* Call resolve-slep-address to get the address (or error) */
	__(li fn,0)
	__(mr arg_z,arg_y)
	__(la fname,nrs.resolve_slep_address(rnil))
	__(set_nargs(1))
	__(bl _SPjmpsym)

	/* Restore the floating point registers and pop off the new stack frame */
	__(la imm1,lisp_frame.size-8(sp))
	__(lfdu f1,8(imm1))
	__(lfdu f2,8(imm1))
	__(lfdu f3,8(imm1))
	__(lfdu f4,8(imm1))
	__(lfdu f5,8(imm1))
	__(lfdu f6,8(imm1))
	__(lfdu f7,8(imm1))
	__(lfdu f8,8(imm1))
	__(lfdu f9,8(imm1))
	__(lfdu f10,8(imm1))
	__(lfdu f11,8(imm1))
	__(lfdu f12,8(imm1))
	__(lfdu f13,8(imm1))
	__(la sp,(13*8 + 8 + lisp_frame.size)(sp))

	/* Finally, continue with the ff-call */
	__(lwz imm2,c_frame.backlink(sp))
	__(b ffcalladdress_proper)

/*
;;; Caller has created a C frame on SP, with 4 "extra" fullwords at the bottom
;;; of the frame.  C-style arguments are sitting in that frame (we load all
;;; of the C argument registers); a macptr to the function descriptor is in
;;; arg_z.
;;; We save all of the lisp NVRs and other state, use the 4 extra words to
;;; make a lisp frame, do the ff-call, discard the C frame, recover the
;;; saved registers and other state, and return to the lisp frame (with the
;;; result in imm0 (R3)).
*/
_spentry(ffcall)
	__(lwz arg_z,macptr.address(arg_z))  /* a fixnum */
	__(b local_label(ffcalladdr))

_spentry(ffcalladdress)
local_label(ffcalladdr):
	__(mflr loc_pc)
	__(stw rzero,c_frame.savelr(sp))           /* make sure stack overflow code skips this frame */
	__(vpush_saveregs())
	__(lwz imm1,0(sp))
	__(la imm2,-lisp_frame.size(imm1))
	__(stw imm1,0(imm2))
	__(stw imm2,0(sp))
	__(stw loc_pc,lisp_frame.savelr(imm2))
	__(stw vsp,lisp_frame.savevsp(imm2))
	__(stw fn,lisp_frame.savefn(imm2))
ffcalladdress_proper:
	/* imm2 = lisp_frame (under c_frame on tos.) */
	__(ref_global(imm3,current_cs))
	__(stw imm2,area.active(imm3))
	__(set_global(freeptr,save_freeptr))
	__(set_global(tsp,save_tsp))
	__(set_global(vsp,save_vsp))               /* where callback can find it */
	__(mr r12,arg_z)                           /* use r12 vice r11 they tell me for OSX */
	__(set_global(rzero,ffi_exception))
        __(lfs fp_zero,lisp_globals.short_float_zero(rnil))		/* ensure that fp_zero contains 0.0 should not be needed here */
	__(mtfsf 0xfc,fp_zero)
	__(stw rnil,c_frame.savetoc(sp))
	/* Could use lswi, but that's frowned on. */
	__(lwz r3,c_frame.params+(0*4)(sp))
	__(lwz r4,c_frame.params+(1*4)(sp))
	__(lwz r5,c_frame.params+(2*4)(sp))
	__(lwz r6,c_frame.params+(3*4)(sp))
	__(lwz r7,c_frame.params+(4*4)(sp))
	__(lwz r8,c_frame.params+(5*4)(sp))
	__(lwz r9,c_frame.params+(6*4)(sp))
	__(lwz r10,c_frame.params+(7*4)(sp))
	__(lwz r0,0(r12))
	__(mtctr r0)
	__(lwz rtoc,4(r12))	
	__(bctrl)
	__(lwz imm2,c_frame.savetoc(sp))    /* recover rnil */
	__(mr arg_z,imm2)
#ifndef PMCL_OSX_NATIVE_KERNEL
	__(lwz imm1,lisp_globals.emulator_registers(imm2)) /* what !! */       
        __(cmpwi imm1,0)
        /* if osx we dont want to reference location  0 */
        __(beq 1f)
	__(lwz imm1,0(imm1))
	/*  Ok to step now */
	__(extsh imm1,imm1)
	__(box_fixnum(arg_z,imm1))
#endif
1:
        /* Shouldn't be needed, either */
        __(lis r31,0x4330)
        __(lis r30,0x8000)
        __(stw r31,-8(sp))
        __(stw r30,-4(sp))
        __(lfd fp_s32conv,-8(sp))
	__(lwz sp,0(sp))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(vpop_saveregs())
	__(li rzero,0)
	__(mr loc_g,rzero)
	__(mr arg_x,imm2)
	__(mr arg_y,imm2)
	/* mr arg_z,imm2  */
	__(mr temp0,imm2)
	__(mr temp1,imm2)
	__(mr temp2,imm2)
	__(mr temp3,imm2)
	__(mr fn,imm2)
	__(mr rnil,imm2)
       /* ;; should not be needed but may fix a crock in Classic and OSX?? */
        __(lfs fp_zero,lisp_globals.short_float_zero(rnil)) 	/* ensure that fp_zero contains 0.0 */
	__(ref_global(freeptr,save_freeptr))
	__(mr initptr,freeptr)
	__(ref_global(tsp,save_tsp))
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(mtlr loc_pc)
	__(lwz fn,lisp_frame.savefn(sp))
	__(la sp,lisp_frame.size(sp))
	__(cmpwi cr0,arg_z,0)
	__(mcrfs cr1,0)
	__(li imm2,0)		/* assume no FP exception */
	__(set_global(imm2,ffi_exception))
	__(blelr cr1)
	__(lwi(imm2,0x40000000))
	__(set_global(imm2,ffi_exception))
	__(bns cr1,2f)
/* The mcrfs cleared OX.  Set it again, then clear FEX. */
	__(mtfsb1 3)
2:	
	__(mtfsb0 1)
	__(blr)

/* ;;; On entry, TOC -> nilreg, callback-index
;;; Restore lisp context, then funcall #'%pascal-functions% with
;;; two args: callback-index, args-ptr (a macptr pointing to the args on the stack)
;;; When it returns, coerce the result, either a macptr or an integer, to 32 bits
;;; and return as a C function would. */
_spentry(callback)
	/* Save arg registers (r3-r10) */
	__(stw r3,c_frame.params+(0*4)(sp))
	__(stw r4,c_frame.params+(1*4)(sp))
	__(stw r5,c_frame.params+(2*4)(sp))
	__(stw r6,c_frame.params+(3*4)(sp))
	__(stw r7,c_frame.params+(4*4)(sp))
	__(stw r8,c_frame.params+(5*4)(sp))
	__(stw r9,c_frame.params+(6*4)(sp))
	__(stw r10,c_frame.params+(7*4)(sp))
	__(mflr imm3)
	__(stw imm3,c_frame.savelr(sp))
	__(mfcr imm0)
	__(stw imm0,c_frame.crsave(sp))

	/* This code depends on the fact that imm0, imm1, imm3 & tsp are
	;; not r13-r31 (the non-volatile C registers). */
	__(lwz imm0,4(rtoc))                /* callback-index */
	__(lwz imm1,0(rtoc))                /* nil */
	__(la rnil,-1(imm1))               /* Marker for TSP overflow code */
	__(lwz tsp,lisp_globals.save_tsp(imm1))

	/* Save the non-volatile registers on the sp stack
	;; This is a non-standard stack frame, but noone will ever see it,
        ;; so it doesn't matter. It will look like more of the stack frame pushed below. */
	__(stwu sp,-(c_reg_save.size)(sp))
	/* ;stw sp,c_reg_save.tsp_mark(sp) */                 /* ; "raw" tsp frame. */
	__(stmw r13,c_reg_save.save_gprs(sp))
	__(stfd fp_zero,c_reg_save.save_fp_zero(sp))  /* fp_zero = f31 */
	__(stfd fp_s32conv,c_reg_save.save_fp_s32conv(sp)) /* fp_s32conv],[f30 */
	__(mffs f0)
	__(stfd f0,-8(sp))
	__(lwz r31,-4(sp))
	__(lwz r30,lisp_globals.ffi_exception(imm1))
	__(or r31,r30,r31)
	__(stw r31,c_reg_save.save_fpscr(sp))   /* c_reg_save ?? */
	__(lwi(r30,0x43300000))
	__(lwi(r31,0x80000000))
	__(stw r30,-8(sp))
	__(stw r31,-4(sp))
	__(lfd f30,-8(sp))
	__(lfs f31,lisp_globals.short_float_zero(imm1))		/* ensure that fp_zero contains 0.0 */
	__(mtfsf 0xfc,f31)		; clear "status", preserve "control"

	/* Restore rest of Lisp context.
	;; Could spread out the memory references here to gain a little speed */
	__(lwz freeptr,lisp_globals.save_freeptr(imm1))
	__(mr initptr,freeptr)
	__(lwz vsp,lisp_globals.save_vsp(imm1))
	__(li rzero,0)
	__(mtxer rzero)                     /* eventually, lisp may depend on the overflow bit being clear */
	__(mr loc_g,rzero)
	__(mr loc_pc,rzero)
	__(mr fn,rzero)                    /* subprim, not a lisp function */
	__(mr temp3,imm1)
	__(mr temp2,imm1)
	__(mr temp1,imm1)
	__(mr temp0,imm1)
	__(mr arg_x,imm1)

	/* restore saved registers.
	; They are in exception_saved_registers if it is non-zero.
	; Otherwise, they are on top of the VSP stack (but 1) */
	__(lwz imm2,lisp_globals.exception_saved_registers(imm1))
	__(cmpwi cr0,imm2,0)
	__(beq cr0,1f)
	__(stw rzero,lisp_globals.exception_saved_registers(imm1))
	__(b 2f)
1:
	__(la imm2,4(vsp))
2:
	__(restore_saveregs(imm2))

	/* load the arg registers & nargs and callback to the lisp */
	__(mr arg_y,imm0)                   /* callback-index */
	__(la arg_z,c_reg_save.size+c_frame.params(sp))    /* parameters (tagged as a fixnum) */
	__(set_nargs(2))
	__(mr rnil,imm1)                    /* lisp context restored */
	__(ref_global(imm2,current_cs))
	__(lwz imm4,area.active(imm2))
	__(stwu imm4,-lisp_frame.size(sp))
	__(stw imm3,lisp_frame.savelr(sp))
	__(stw vsp,lisp_frame.savevsp(sp))	/* for stack overflow code */
	__(la fname,nrs.callbacks(rnil))   /* %pascal-functions% */
	__(bl _SPjmpsym)
	__(lwz imm2,lisp_frame.backlink(sp))
	__(ref_global(imm3,current_cs))
	__(stw imm2,area.active(imm3))
	__(la sp,lisp_frame.size(sp))
	/* save_freeptr & save_memo may be different due to consing
	;; save_vsp will be restored from ff_call's stack frame, but
	;; I included it here for consistency.
	;; save_tsp is set below after we exit Lisp context. */
	__(set_global(freeptr,save_freeptr))
	__(set_global(vsp,save_vsp))

	/* Exit lisp context
	;; This is not necessary yet, but will be once we can be interrupted */
	__(mr imm1,rnil)
	__(li rnil,0)                       /* could lwz rnil,c_reg_save.size+c_frame.savetoc(sp), but that costs time */

	/* Restore the non-volatile registers & fpscr */
	__(lwz r31,c_reg_save.save_fpscr(sp))
	__(rlwinm r30,r31,0,1,1)	/* extract FEX bit */
	__(rlwinm r31,r31,0,2,0)	/* clear it */
	__(stw r31,-4(sp))
	__(lfd f0,-8(sp))
	__(mtfsf 0xff,f0)
	__(stw r30,lisp_globals.ffi_exception(imm1))
	__(lmw r13,c_reg_save.save_gprs(sp))
	__(lfd fp_zero,c_reg_save.save_fp_zero(sp))
	__(lfd fp_s32conv,c_reg_save.save_fp_s32conv(sp))
	__(lwz sp,0(sp))
	__(stw tsp,lisp_globals.save_tsp(imm1))

	/* The lisp code has left the return value in c_frame.params(sp)
	;; We just need to load it into R3 to return to the caller */
	__(lwz r3,c_frame.params(sp)) 
	__(lwz r4,c_frame.crsave(sp))
	__(mtcr r4)
	__(lwz r4,c_frame.savelr(sp))
	__(mtlr r4)
	__(blr)

/* from sp_bind.s */

/* Set the special variable in arg_y to the value in arg_z.
;;; Error if arg_y is a constant.
;;; arg_y is a known, non-nil symbol. */
_spentry(setqsym)
	__(lwz imm0,symbol.flags(arg_y))
	__(andi. imm0,imm0,(1<<sym_vbit_const))
	__(bne cr0,1f)
	__(la loc_g,symbol.vcell(arg_y))
	__(stw arg_z,0(loc_g))
	__(b _SPwrite_barrier)
1:
	__(mr arg_z,arg_y)
	__(lwi(arg_y,XCONST))
	__(set_nargs(2))
	__(b _SPksignalerr)  /* ?? */
	
/* Bind special symbol in arg_y to value in arg_z. */
_spentry(bind)
	__(lwz temp1,symbol.vcell(arg_y))
	__(ref_global(imm1,db_link))
	__(vpush(temp1))
	__(vpush(arg_y))
	__(vpush(imm1))
	__(set_global(vsp,db_link))
	__(stw arg_z,symbol.vcell(arg_y))
	__(blr)

/* Bind special symbol in arg_z to its current value. */
_spentry(bind_self_boundp_check)
	__(lwz temp1,symbol.vcell(arg_z))
        __(cmpwi temp1,unbound_marker)
        __(bne local_label(bind_self_aux))
        __(mflr loc_pc)
        __(create_lisp_frame())
        __(stwu sp,-lisp_frame.size(sp))
        __(stw vsp,lisp_frame.savevsp(sp))
        __(stw loc_pc,lisp_frame.savelr(sp))
        __(stw fn,lisp_frame.savefn(sp))
        __(bl _SPuuounbound)
        __(uuo_unbound(temp1,arg_z))
        __(lwz loc_pc,lisp_frame.savelr(sp))
        __(la sp,lisp_frame.size(sp))
        __(mtlr loc_pc)
        __(b _SPbind_self_boundp_check)

	
_spentry(bind_self)
	__(lwz temp1,symbol.vcell(arg_z))
local_label(bind_self_aux):	
	__(ref_global(imm1,db_link))
	__(vpush(temp1))
	__(vpush(arg_z))
	__(vpush(imm1))
	__(set_global(vsp,db_link))
	__(blr)

/* Bind special symbol in arg_z to  NIL. */	
_spentry(bind_nil)
	__(lwz temp1,symbol.vcell(arg_z))
	__(ref_global(imm1,db_link))
	__(vpush(temp1))
	__(vpush(arg_z))
	__(vpush(imm1))
	__(set_global(vsp,db_link))
	__(stw rnil,symbol.vcell(arg_z))
	__(blr)

/* Undo one special binding. */
_spentry(unbind)
	__(ref_global(imm1,db_link))
	__(lwz temp0,4(imm1))
	__(lwz temp1,8(imm1))
	__(lwz imm1,0(imm1))
	__(set_global(imm1,db_link))
	__(stw temp1,symbol.vcell(temp0))
	__(blr)

/* Undo N special bindings: imm0 = n, unboxed and >0. */
_spentry(unbind_n)
	__(ref_global(imm1,db_link))
1:
	__(subi imm0,imm0,1)
	__(cmpwi cr0,imm0,0)
	__(lwz temp0,4(imm1))
	__(lwz temp1,8(imm1))
	__(lwz imm1,0(imm1))
	__(stw temp1,symbol.vcell(temp0))
	__(bne cr0,1b)
	__(set_global(imm1,db_link))
	__(blr)

/* ;;; Unwind special bindings until the head of the linked list = imm0. */
/* Clobbers arg_x, arg_y, imm2, imm1. */
_spentry(unbind_to)
	__(ref_global(imm1,db_link))
1:
	__(lwz imm2,0(imm1))
	__(lwz arg_x,4(imm1))
	__(cmpw cr0,imm0,imm2)
	__(lwz arg_y,8(imm1))
	__(mr imm1,imm2)
	__(stw arg_y,symbol.vcell(arg_x))
	__(bne cr0,1b)
	__(set_global(imm1,db_link))
	__(blr)

/*  save the values of a list of special variables (arg_y); set them
;;; to the corresponding values in the list in arg_z.
;;; We've checked to make sure that arg_y is a proper list of bindable
;;; symbols, but we're not sure what's in arg_z.
;;; Save the special binding triplets on the tstack.  If there's not
;;; enough room, die.  Prepend the triplets with a boxed triplet
;;; count. */
_spentry(progvsave)
        /* First, determine the length of arg_y.  We */
        /* know that it's a proper list. */
        __(li imm0,-4)
        __(mr temp0,arg_y)
0:
	__(cmpw cr0,temp0,rnil)
	__(la imm0,4(imm0))
	__(_cdr(temp0,temp0)) 
	__(bne 0b)
	/* imm0 is now (boxed) triplet count. */
	/* Determine word count, add 1 (to align), and make room. */
	/* if count is 0, make an empty tsp frame and exit */
	__(cmpwi cr0,imm0,0)
	__(add imm1,imm0,imm0)
	__(add imm1,imm1,imm0)
	__(la imm1,4+7(imm1))
	__(clrrwi imm1,imm1,3)
	__(bne cr0,1f)
	__(stwu tsp,-16(tsp))
	__(stw rzero,4(tsp))
	__(stw rzero,8(tsp))
	__(stw rzero,12(tsp))
	__(blr)
1:
	__(neg imm1,imm1)
	__(la imm1,-8(imm1))	/* tsp header */
	__(mr initptr,tsp)      /* uninterruptable */
	__(stwux tsp,tsp,imm1)
	__(stw rzero,4(tsp))
	__(sub initptr,tsp,imm1)	/* in case we just overflowed the stack segment */
	__(stw imm0,8(tsp))
	__(stw rzero,12(tsp))
	__(mr temp0,arg_y)
	__(ref_global(imm1,db_link))
	/*  Save all bindings, then do the setqs. */
2:   /* @save_loop: */	
	__(_car(temp1,temp0))
	__(_cdr(temp0,temp0))
	__(cmpw cr0,temp0,rnil)
	__(lwz temp2,symbol.vcell(temp1))
	__(push(temp2,initptr))
	__(push(temp1,initptr))
	__(push(imm1,initptr))
	__(mr imm1,initptr)
	__(bne cr0,2b)
	__(set_global(imm1,db_link))
	/* Now do assignments.  The TSP frame is gc-safe, */
	/* so it's safe to error if arg_z isn't a proper list. */
	__(mr initptr,freeptr)
	__(mr temp0,arg_z)

3:  /* @set_loop: */
	__(leaf_trap_unless_list(temp0,imm0))
        __(cmpw cr0,temp0,rnil)
	__(_car(temp1,arg_y))
	__(_cdr(arg_y,arg_y))
	__(cmpw cr1,arg_y,rnil)
        __(li temp2,unbound_marker)
        __(beq cr0,4f)
	__(_car(temp2,temp0))
	__(_cdr(temp0,temp0))
4:
	__(stw temp2,symbol.vcell(temp1))        
	__(bne cr1,3b)
	__(blr)

/* ;;; Restore the special bindings from the top of the tstack,
;;; leaving the tstack frame allocated.
;;; Note that there might be 0 saved bindings, in which case
;;; do nothing.
;;; Note also that this is -only- called from an unwind-protect
;;; cleanup form, and that .SPnthrowXXX is keeping one or more
;;; values in a frame on top of the tstack.
*/

_spentry(progvrestore)
	__(lwz imm0,0(tsp))		/* ignore .SPnthrowXXX values frame */
	__(lwz imm0,8(imm0))
	__(cmpwi cr0,imm0,0)
	__(unbox_fixnum(imm0,imm0))
	__(bne cr0,_SPunbind_n) 
	__(blr)	

/* from sp_lambda.s */
/* Destructuring-bind, macro-bind. */ 
   
/* OK to use arg_x, arg_y for whatever (tagged) purpose; 
   likewise immX regs. 
   arg_z preserved, nothing else in particular defined on exit. 
   nargs contains req count (0-255) in PPC bits mask_req_start/mask_req_width, 
                  opt count (0-255) in PPC bits mask_opt_start/mask_opt_width, 
                  key count (0-255) in PPC bits mask_key_start/mask_key_width, 
                  opt-supplied-p flag in PPC bit mask_initopt, 
                  keyp flag in PPC bit mask_keyp, 
                  &allow-other-keys flag in PPC bit mask_aok, 
   		   &rest flag in PPC bit mask_restp. 
   When mask_keyp bit is set, keyvect contains vector of keyword symbols, 
	length key count. */

_spentry(macro_bind)
	__(mr whole_reg,arg_reg)
	__(extract_lisptag(imm0,arg_reg))
	__(cmpwi cr0,imm0,tag_list)
	__(bne cr0,1f)
	__(_cdr(arg_reg,arg_reg))
	__(b local_label(destbind1))
1:
	__(li arg_y,XCALLNOMATCH)
	__(mr arg_z,whole_reg)
	__(set_nargs(2))
	__(b _SPksignalerr)
	
_spentry(destructuring_bind_inner)
	__(mr whole_reg,arg_z)
	__(b local_label(destbind1))

_spentry(destructuring_bind)
	__(mr whole_reg,arg_reg)
	/* b destbind1 */

local_label(destbind1):
	/* Extract required arg count. */
	__(extrwi. imm0,nargs,mask_req_width,mask_req_start)
	__(extrwi  imm1,nargs,mask_opt_width,mask_opt_start)
	__(rlwinm  imm2,nargs,0,mask_initopt,mask_initopt)
	__(rlwinm  imm4,nargs,0,mask_keyp,mask_keyp)
	__(cmpwi cr4,imm4,0)
	__(rlwinm imm4,nargs,0,mask_restp,mask_restp)
	__(cmpwi cr5,imm4,0)
	__(cmpwi cr1,imm1,0)
	__(cmpwi cr2,imm2,0)
	/* Save entry vsp in case of error. */
	__(mr imm4,vsp)
	__(beq cr0,2f)
1: /* @req_loop: */
	__(cmpw cr7,arg_reg,rnil)
	__(extract_lisptag(imm3,arg_reg))
	__(cmpwi cr3,imm3,tag_list)
	__(subi imm0,imm0,1)
	__(cmpwi cr0,imm0,0)
	__(beq cr7,toofew)
	__(bne cr3,badlist)
	__(lwz arg_x,cons.car(arg_reg))
	__(lwz arg_reg,cons.cdr(arg_reg))
	__(vpush(arg_x))
	__(bne cr0,1b)
2: /* @do_opt: */	
	__(beq cr1,rest_keys)
	__(bne cr2,opt_supp)
	/* 'simple' &optionals:	 no supplied-p, default to nil. */
simple_opt_loop:
	__(cmpw cr0,arg_reg,rnil)
	__(extract_lisptag(imm3,arg_reg))
	__(cmpwi cr3,imm3,tag_list)
	__(subi imm1,imm1,1)
	__(cmpwi cr1,imm1,0)
	__(beq cr0,default_simple_opt)
	__(bne cr3,badlist)
	__(lwz arg_x,cons.car(arg_reg))
	__(lwz arg_reg,cons.cdr(arg_reg))
	__(vpush(arg_x))
	__(bne cr1,simple_opt_loop)
	__(b rest_keys)
default_simple_opt_loop:
	__(subi imm1,imm1,1)
	__(cmpwi cr1,imm1,0)
default_simple_opt:
	__(vpush(rnil))
	__(bne cr1,default_simple_opt_loop)
	__(b rest_keys)
	/* Provide supplied-p vars for the &optionals. */
opt_supp:
	__(la arg_y,t_offset(rnil))
opt_supp_loop:
	__(cmpw cr0,arg_reg,rnil)
	__(extract_lisptag(imm3,arg_reg))
	__(cmpwi cr3,imm3,tag_list)
	__(subi imm1,imm1,1)
	__(cmpwi cr1,imm1,0)
	__(beq cr0,default_hard_opt)
	__(bne cr3,badlist)
	__(lwz arg_x,cons.car(arg_reg))
	__(lwz arg_reg,cons.cdr(arg_reg))
	__(vpush(arg_x))
	__(vpush(arg_y))
	__(bne cr1,opt_supp_loop)
	__(b rest_keys)
default_hard_opt_loop:
	__(subi imm1,imm1,1)
	__(cmpwi cr1,imm1,0)
default_hard_opt:
	__(vpush(rnil))
	__(vpush(rnil))
	__(bne cr1,default_hard_opt_loop)
rest_keys:
	__(cmpw cr0,arg_reg,rnil)
	__(bne cr5,have_rest)
	__(bne cr4,have_keys)
	__(bne cr0,toomany)
	__(blr)
have_rest:	
	__(vpush(arg_reg))
	__(beqlr cr4)
have_keys:
	/* Ensure that arg_reg contains a proper,even-length list. */
	/* Insist that its length is <= 512 (as a cheap circularity check.) */
	__(li imm0,256)
	__(mr arg_x,arg_reg)
count_keys_loop:
	__(extract_lisptag(imm3,arg_x))
	__(cmpwi cr3,imm3,tag_list)
	__(cmpw cr0,arg_x,rnil)
	__(subi imm0,imm0,1)
	__(cmpwi cr4,imm0,0)
	__(bne cr3,badlist)
	__(beq cr0,counted_keys)
	__(lwz arg_x,cons.cdr(arg_x))
	__(extract_lisptag(imm3,arg_x))
	__(cmpwi cr3,imm3,tag_list)
	__(blt cr4,toomany)
	__(cmpw cr0,arg_x,rnil)
	__(bne cr3,badlist)
	__(beq cr0,db_badkeys)
	__(lwz arg_x,cons.cdr(arg_x))
	__(b count_keys_loop)	
counted_keys:
	/* We've got a proper, even-length list of key/value pairs in arg_reg. */
	/* For each keyword var in the lambda-list, push a pair of NILs on the vstack. */
	__(extrwi. imm0,nargs,mask_key_width,mask_key_start)
	__(mr imm2,imm0)		/* save number of keys */
	__(b push_pair_test)
push_pair_loop:
	__(cmpwi cr0,imm0,1)
	__(subi imm0,imm0,1)
	__(vpush(rnil))
	__(vpush(rnil))
push_pair_test:
	__(bne cr0,push_pair_loop)
	__(slwi imm2,imm2,3)		/* pairs -> bytes */
	__(add imm2,vsp,imm2)		/* imm2 points below pairs */
	__(li imm0,0)			/* count unknown keywords so far */
	__(extrwi imm1,nargs,1,mask_aok)	/* unknown keywords allowed */
	__(extrwi nargs,nargs,mask_key_width,mask_key_start)
	/* Now, for each keyword/value pair in the list */
	/*  a) if the keyword is found in the keyword vector, set the */
	/*     corresponding entry on the vstack to the value and the */
	/*     associated supplied-p var to T. */
	/*  b) Regardless of whether or not the keyword is found, */
	/*     if the keyword is :ALLOW-OTHER-KEYS and the value is non-nil, */
	/*     set imm1 to a non-zero value to indicate that unknown keywords */
	/*     are acceptable. */
	/*  c) If the keyword is not found (and isn't :ALLOW-OTHER-KEYS), increment */
	/*     the count of unknown keywords in imm0. */
	/* At the end of the list, signal an error if any unknown keywords were seen */
	/* but not allowed.  Otherwise, return. */
match_keys_loop:
	__(cmpw cr0,arg_reg,rnil)
	__(li imm0,0)
	__(li imm3,misc_data_offset)
	__(beq cr0,matched_keys)
	__(lwz arg_x,cons.car(arg_reg))
	__(la arg_y,nrs.kallowotherkeys(rnil))
	__(cmpw cr3,arg_x,arg_y)	/* :ALLOW-OTHER-KEYS ? */
	__(lwz arg_reg,cons.cdr(arg_reg))
	__(lwz arg_y,cons.car(arg_reg))
	__(cmpw cr0,arg_y,rnil)
	__(cmpw cr4,imm0,nargs)
	__(lwz arg_reg,cons.cdr(arg_reg))
	__(bne cr3,match_test)
	__(beq cr0,match_test)
	__(ori imm1,imm1,1)
	__(b match_test)
match_loop:
	__(lwzx temp0,keyvect_reg,imm3)
	__(cmpw cr0,arg_x,temp0)
	__(addi imm0,imm0,1)
	__(cmpw cr4,imm0,nargs)
	__(addi imm3,imm3,4)
	__(bne cr0,match_test)
	/* Got a hit.  Unless this keyword's been seen already, set it. */
	__(slwi imm0,imm0,3)
	__(subf imm0,imm0,imm2)
	__(lwz temp0,0(imm0))
	__(cmpw cr0,temp0,rnil)
	__(la temp0,t_offset(rnil))
	__(bne cr0,match_keys_loop)	/* already saw this */
	__(stw arg_y,4(imm0))
	__(stw temp0,0(imm0))
	__(b match_keys_loop)
match_test:
	__(bne cr4,match_loop)
	__(oris imm1,imm1,0x8000)
	__(b match_keys_loop)
matched_keys:	
	__(cmpwi cr1,imm1,0)
	__(add imm1,imm1,imm1)
	__(cmpwi cr0,imm1,0)
	__(bgelr cr1)
	__(bnelr cr0)
	/* Some unrecognized keywords.  Complain generically about */
	/* invalid keywords. */
db_badkeys:
	__(li arg_y,XBADKEYS)
	__(b destructure_error)
toomany:
	__(li arg_y,XCALLTOOMANY)
	__(b destructure_error)
toofew:
	__(li arg_y,XCALLTOOFEW)
	__(b destructure_error)
badlist:
	__(li arg_y,XCALLNOMATCH)
	/* b destructure_error */
destructure_error:	
	__(mr vsp,imm4)		/* undo everything done to the stack */
	__(mr arg_z,whole_reg)
	__(set_nargs(2))
	__(b _SPksignalerr)

/* "spread" the lexpr in arg_z. 
   ppc2-invoke-fn assumes that temp1 is preserved here. */
_spentry(spread_lexprz)
	__(lwz imm0,0(arg_z))
	__(cmpwi cr3,imm0,3<<fixnumshift)
	__(cmpwi cr4,imm0,2<<fixnumshift)
	__(add imm1,arg_z,imm0)
	__(cmpwi cr0,imm0,0)
	__(add nargs,nargs,imm0)
	__(cmpwi cr1,nargs,0)
	__(cmpwi cr2,nargs,2<<fixnumshift)
	__(la imm1,4(imm1))
	__(bge cr3,9f)  /* @many_test */
	__(beq cr4,2f)
	__(bne cr0,1f)
	/* lexpr count was 0; vpop the arg regs that */
	/* were vpushed by the caller */
	__(beqlr cr1)
        __(vpop(arg_z))
        __(bltlr cr2)
        __(vpop(arg_y))
        __(beqlr cr2)
        __(vpop(arg_x))
        __(blr)

	/* vpush args from the lexpr until we have only */
	/* three left, then assign them to arg_x, arg_y, */
	/* and arg_z. */
8:  /* @many_loop: */
	__(cmpwi cr3,imm0,4<<fixnumshift)
	__(subi imm0,imm0,fixnumone)
	__(lwzu arg_z,-4(imm1))
	__(vpush(arg_z))
9:  /* @many_test: */
	__(bne cr3,8b)
	__(lwz arg_x,-4(imm1))
	__(lwz arg_y,-8(imm1))
	__(lwz arg_z,-12(imm1))
	__(blr)

	/* lexpr count is two: set arg_y, arg_z from the */
	/* lexpr, maybe vpop arg_x */
2:	
	__(lwz arg_y,-4(imm1))
	__(lwz arg_z,-8(imm1))
	__(beqlr cr2)		/* return if (new) nargs = 2 */
	__(vpop(arg_x))
	__(blr)

	/* lexpr count is one: set arg_z from the lexpr, */
	/* maybe vpop arg_y, arg_x */
1:
	__(lwz arg_z,-4(imm1))
	__(bltlr cr2)		/* return if (new) nargs < 2 */
	__(vpop(arg_y))
	__(beqlr cr2)		/* return if (new) nargs = 2 */
	__(vpop(arg_x))
	__(blr)

/* from sp_stack_cons.s */

/* Make a cons cell on the vstack.  Always push 3 words, 'cause we're  
   not sure how the vstack will be aligned. */
_spentry(stkconsyz)
	__(vpush(rnil))
	__(vpush(rnil))
	__(vpush(rnil))
	__(andi. imm0,vsp,1<<2)	/* (oddp vsp ?) */
	__(beq cr0,1f)
	__(stw arg_y,8(vsp))	/* car */
	__(stw arg_z,4(vsp))	/* cdr */
	__(la arg_z,fulltag_cons+4(vsp))
	__(blr)
1:
	__(stw arg_y,4(vsp))	/* car, again */
	__(stw arg_z,0(vsp))
	__(la arg_z,fulltag_cons(vsp))
	__(blr)

/* Make a stack-consed value cell.  Much like the case of stack-allocating a cons */
/* cell.  Imm0 points to the closed-over value (already vpushed).  Replace */
/* that locative with the vcell. */

_spentry(stkvcellvsp)
	__(mr imm0,vsp)
	__(b _SPstkvcell0)

/* Make a stack-consed value cell.  Much like the case of
   stack-allocating a cons cell.  Imm0 points to the closed-over value
   (already vpushed).  Replace that locative with the vcell. */
_spentry(stkvcell0)
	__(sub imm1,imm0,vsp)	/* imm1 = delta from vsp to value cell loc */
	__(vpush(rnil))
	__(vpush(rnil))
	__(vpush(rnil))
	__(addi imm1,imm1,12)
	__(add imm0,vsp,imm1)	/* in case stack overflowed */
	__(andi. imm1,vsp,1<<2)	/* (oddp vsp) ? */
	__(li imm1,value_cell_header)
	__(lwz arg_z,0(imm0))
	__(beq cr0,1f)
	__(stw arg_z,8(vsp))
	__(stw imm1,4(vsp))
	__(la arg_z,fulltag_misc+4(vsp))
	__(stw arg_z,0(imm0))
	__(blr)
1:	
	__(stw arg_z,4(vsp))
	__(stw imm1,0(vsp))
	__(la arg_z,fulltag_misc(vsp))
	__(stw arg_z,0(imm0))
	__(blr)

/*
;;; Make a "raw" area on the temp stack, stack-cons a macptr to point to it,
;;; and return the macptr.  Size (in bytes, boxed) is in arg_z on entry; macptr in
;;; arg_z on exit.
;;; It would be nice to cons in the Mac heap if there's not room on
;;; the tstack. This code will handle a new tstack segment being added. */
_spentry(makestackblock)
	__(unbox_fixnum(imm0,arg_z))
	__(la imm0,8+macptr.size+7(imm0))
	__(clrrwi imm0,imm0,3)
	__(cmpwi cr0,imm0,4096)
	__(neg imm0,imm0)
	__(bge cr0,1f) 
	__(stwux tsp,tsp,imm0)
	__(stw tsp,4(tsp))		/* "raw" block. */
	__(li imm0,macptr_header)
	__(la imm1,8+macptr.size(tsp))
	__(la arg_z,8+fulltag_misc(tsp))
	__(stw imm0,macptr.header(arg_z))
	__(stw imm1,macptr.address(arg_z))   /* makestackblock0 expects the address to be in imm1 */
	__(b _SPtscheck)

/* Too big. Heap cons a gcable macptr */
1:
	__(stwu tsp,-8(tsp))
	__(stw tsp,4(tsp))          /* "raw" block to make the compiler happy */
	__(set_nargs(1))
	__(la fname,nrs.new_gcable_ptr(rnil))
	__(jump_fname())
	

/* As above, only set the block's contents to 0. */
_spentry(makestackblock0)
	__(mr arg_y,arg_z)                        /* save block size */
	__(unbox_fixnum(imm0,arg_z))
	__(la imm0,8+macptr.size+7(imm0))
	__(clrrwi imm0,imm0,3)
	__(cmpwi cr0,imm0,4096)
	__(neg imm0,imm0)
	__(bge cr0,3f)

	__(stwux tsp,tsp,imm0)
	__(stw tsp,4(tsp))                        /* "raw" block. */
	__(li imm0,macptr_header)
	__(la imm1,8+macptr.size(tsp))
	__(la arg_z,8+fulltag_misc(tsp))
	__(stw imm0,macptr.header(arg_z))
	__(stw imm1,macptr.address(arg_z))         /* makestackblock0 expects the address to be in imm1 */

	__(unbox_fixnum(imm0,arg_y))
	__(la imm0,7(imm0))
	__(clrrwi imm0,imm0,3)
	__(add imm2,imm1,imm0)                    /* end of the line */
	__(cmpw cr0,imm1,imm2)
	__(la imm2,-8(imm2))
	__(b 2f)
1:  /* @initloop: */
	__(cmpw cr0,imm1,imm2)
	__(stw rzero,0(imm1))
	__(la imm1,8(imm1))
	__(stw rzero,-4(imm1))
2:
	__(bne cr0,1b)
	__(b _SPtscheck)
	
/* Too big. Heap cons a gcable macptr */
3: /* @heapblock0: */
	__(stwu tsp,-8(tsp))
	__(stw tsp,4(tsp))          /* "raw" block to make the compiler happy */
	
	__(la arg_z,nrs.tsym(rnil))                /* clear-p arg to %new-gcable-ptr */
	__(set_nargs(2))
	__(la fname,nrs.new_gcable_ptr(rnil))
	__(jump_fname())

/* Make a list of length arg_y (boxed), initial-element arg_z (boxed) on 
   the tstack.  Return the list in arg_z. */
_spentry(makestacklist)
	__(add imm0,arg_y,arg_y)
	__(cmpwi cr1,imm0,4096-8)
	__(addi imm0,imm0,8)
	__(neg imm0,imm0)
	__(bge cr1,3f)
	__(mr imm1,arg_y)
	__(cmpwi cr1,imm1,0)
	__(mr arg_y,arg_z)
	__(mr arg_z,rnil)
	__(mr initptr,tsp)			/* uninterruptable */
	__(stwux tsp,tsp,imm0)
	__(stw rzero,4(tsp))
	__(sub initptr,tsp,imm0)		/* correct for stack overflow */
	__(la initptr,-8+tag_list(initptr))
	__(b 2f)
1:  /* @loop: */
	__(subi imm1,imm1,fixnum1)
	__(cmpwi cr1,imm1,0)
	__(_rplacd(initptr,arg_z))
	__(_rplaca(initptr,arg_y))
	__(mr arg_z,initptr)
	__(subi initptr,initptr,cons.size)
2: /* @test: */
	__(bne cr1,1b)
	__(mr initptr,freeptr)
	__(b _SPtscheck)

3:  /* @heap_cons: */
        __(cmpwi cr1,arg_y,0)
	__(stwu tsp,-8(tsp))                       /* make the compiler happy */
	__(stw rzero,4(tsp))
	__(mr imm1,arg_y)                          /* count */
	__(mr arg_y,arg_z)                         /* initial value */
	__(mr arg_z,rnil)                          /* result */
        __(b 5f)
4: /* @heap_loop: */
	__(subi imm1,imm1,fixnum1)
	__(cmpwi cr1,imm1,0)
	__(stwu rzero,cons.size(freeptr))
	__(la initptr,tag_list(initptr))
	__(_rplaca(initptr,arg_y))
	__(_rplacd(initptr,arg_z))
	__(mr arg_z,initptr)
	__(mr initptr,freeptr)
5: /* @heap_test: */
	__(bne cr1,4b)
	__(blr)


/* subtype (boxed) vpushed before initial values. (Had better be a node header subtag.)
  Nargs set to count of things vpushed. */
_spentry(stkgvector)
	__(la imm0,-4(nargs))
	__(cmpwi cr0,imm0,0)
	__(add imm1,vsp,nargs)
	__(lwzu temp0,-4(imm1))
	__(slwi imm2,imm0,num_subtag_bits-fixnumshift)
	__(rlwimi imm2,temp0,32-fixnumshift,32-num_subtag_bits,31)
	__(la imm0,(8+4+7)(imm0))
	__(clrrwi imm0,imm0,3)
	__(neg imm0,imm0)
	__(mr initptr,tsp)			/* uninterruptable */
	__(stwux tsp,tsp,imm0)
	__(sub initptr,tsp,imm0)		/* correct for stack overflow */
	__(stw rzero,-4(initptr))
	__(stw rzero,4(tsp))
	__(la arg_z,8+fulltag_misc(tsp))
	__(la initptr,misc_header_offset(arg_z))
	__(stw imm2,0(initptr))
	__(li imm0,fixnum1)
	__(b 2f)
1:
	__(addi imm0,imm0,fixnum1)
	__(cmpw cr0,imm0,nargs)
	__(lwzu temp0,-4(imm1))
	__(stwu temp0,4(initptr))
2:
	__(bne cr0,1b)
	__(mr initptr,freeptr)
	__(add vsp,vsp,nargs)
	__(b _SPtscheck)


/* We always have to create a tsp frame (even if nargs is 0), so the compiler
 doesn't get confused. */
_spentry(stkconslist)
	__(mr arg_z,rnil)
	__(b local_label(stkconsliststar))

/* do list*: last arg in arg_z, all others vpushed, nargs set to #args vpushed. */
_spentry(stkconslist_star)
	/* ;stw rzero,-4096(tsp)		; half-hearted stack probe. */
local_label(stkconsliststar):
	__(cmpwi nargs,0)
	__(add imm1,nargs,nargs)
	__(addi imm1,imm1,8)
	__(neg imm1,imm1)
	__(mr initptr,tsp)			/* uninterruptable */
	__(stwux tsp,tsp,imm1)
	__(sub initptr,tsp,imm1)		/* correct for stack overflow */
	__(la initptr,-8+fulltag_cons(initptr))
	__(stw rzero,4(tsp))
	__(b local_label(init_list_from_stack))  /* ?? */

/* Make a stack-consed simple-vector out of the NARGS objects 
	on top of the vstack; return it in arg_z. */
_spentry(mkstackv)
	/* stw rzero,-4096(tsp) */
	__(cmpwi nargs,0)
	__(neg imm1,nargs)
	__(la imm1,-(4+8)(imm1))
	__(bitclr(imm1,imm1,2))
	__(mr initptr,tsp)			/* uninterruptable */
	__(stwux tsp,tsp,imm1)
	__(sub initptr,tsp,imm1)		/* correct for stack overflow */
	__(stw rzero,4(tsp))
	__(stw rzero,-4(initptr))
	__(slwi imm0,nargs,num_subtag_bits-fixnumshift)
	__(ori imm0,imm0,subtag_simple_vector)
	__(stw imm0,8(tsp))
	__(la arg_z,8+fulltag_misc(tsp))
	__(beq 2f)
	__(la imm0,8+4(tsp))
	__(add initptr,imm0,nargs)
1:
	__(la nargs,-4(nargs))
	__(cmpwi nargs,0)
	__(lwz temp1,0(vsp))
	__(la vsp,4(vsp))
	__(stwu temp1,-4(initptr))
	__(bne 1b)
2:	
	__(mr initptr,freeptr)
	__(b _SPtscheck)

/* Allocate a miscobj on the temp stack.  (Push a frame on the tsp and 
   heap-cons the object if there's no room on the tstack.) */
_spentry(stack_misc_alloc)
	__(rlwinm. imm2,arg_y,32-fixnumshift,0,(8+fixnumshift)-1)
	__(unbox_fixnum(imm0,arg_z))
	__(extract_fulltag(imm1,imm0))
	__(bne cr0,3f)
	__(cmpwi cr0,imm1,fulltag_nodeheader)
	__(mr imm3,imm0)
	__(cmplwi cr1,imm0,max_32_bit_ivector_subtag)
	__(rlwimi imm0,arg_y,num_subtag_bits-fixnum_shift,0,31-num_subtag_bits)	/* imm0 now = header */
	__(mr imm2,arg_y)
	__(beq cr0,1f)	/* do probe if node object (fixnum element count = byte count). */
	__(cmplwi cr0,imm3,max_16_bit_ivector_subtag)
	__(bng cr1,1f)	/* do probe if 32-bit imm object */
	__(cmplwi cr1,imm3,max_8_bit_ivector_subtag)
	__(srwi imm2,imm2,1)
	__(bgt cr0,4f)
	__(bgt cr1,1f)
	__(srwi imm2,imm2,1)
/* imm2 now = byte count.  Add 4 for header, 7 to align, then clear low three bits. */
1: /* probe */
	__(addi imm2,imm2,4+7)
	__(clrrwi imm2,imm2,3)
	__(la imm3,8(imm2))		/* account for tsp header */
	__(cmpwi cr0,imm3,0x1000)	/* more than 4k ? */
	__(bgt cr0,3f)  /* do_heap_alloc) */
	__(neg imm3,imm3)
	__(mr initptr,tsp)		/* no interrupts */
	__(stwux tsp,tsp,imm3)
	__(sub initptr,tsp,imm3)	/* correct for stack overflow */
	__(stw rzero,4(tsp))
/* Even if we're going to initialize this to some non-zero value in a second, we */
/* initialize the vector's contents to 0 now, so that the period in which we're */
/* not gc-safe is as short as possible. */
/* Note that the loop can be written to assume that we've always got at least */
/* one doubleword to initialize (because of the vector header.) */
2:  /* @initloop: */
	__(subi imm2,imm2,8)
	__(cmpwi cr0,imm2,0)
	__(subi initptr,initptr,8)
	__(stw rzero,4(initptr))
	__(stw rzero,0(initptr))
	__(bne cr0,2b)
/* Slap the header on the vector, then fix initptr & return. */
	__(la arg_z,fulltag_misc(initptr))
	__(mr initptr,freeptr)
	__(stw imm0,misc_header_offset(arg_z))
	__(b _SPtscheck)
/* @badsize: */ 
3:  /* @do_heap_alloc: */
/* Too large to safely fit on tstack.  Heap-cons the vector, but make */
/* sure that there's an empty tsp frame to keep the compiler happy. */
	__(stwu tsp,-8(tsp))
	__(stw rzero,4(tsp))
	__(b _SPmisc_alloc)
4: /* @dfloat_or_bit: */
	__(cmplwi imm3,subtag_double_float_vector)
	__(slwi imm2,arg_y,1)
	__(beq 1b)
	__(addi imm2,arg_y,7<<fixnumshift)
	__(srwi imm2,imm2,fixnumshift+3)
	__(b 1b)

/* As in stack_misc_alloc above, only with a non-default initial-value. */

_spentry(stack_misc_alloc_init)
	__(mflr loc_pc)
	__(stwu sp,-lisp_frame.size(sp))
	__(stw fn,lisp_frame.savefn(sp))
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(stw vsp,lisp_frame.savevsp(sp))
	__(li fn,0)
	__(mr temp0,arg_z)		/* initval */
	__(mr arg_z,arg_y)		/* subtag */
	__(mr arg_y,arg_x)		/* element-count */
	__(bl _SPstack_misc_alloc)
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(mtlr loc_pc)
	__(lwz fn,lisp_frame.savefn(sp))
	__(lwz vsp,lisp_frame.savevsp(sp)) /* vsp may have changed due to overflowing a stack segment */
	__(la sp,lisp_frame.size(sp))
	__(la fname,nrs.init_misc(rnil))
	__(set_nargs(2))
	__(mr arg_y,temp0)
	__(jump_fname())

/* from sp_values.s */

/* funcall temp0, returning multiple values if it does. */
_spentry(mvpass)
	__(mflr loc_pc)
	__(mr imm0,vsp)
	__(cmpwi cr0,nargs,4*nargregs)
	__(stwu sp,-lisp_frame.size(sp))
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(stw fn,lisp_frame.savefn(sp))
	__(ref_global(loc_pc,ret1val_addr))
	__(ble cr0,1f)
	 __(subi imm0,imm0,4*nargregs)
	 __(add imm0,imm0,nargs)
1:
	__(stw imm0,lisp_frame.savevsp(sp))
	__(li fn,0)
	__(mtlr loc_pc)
	__(b _SPfuncall)
	

/* ret1valn returns "1 multiple value" when a called function does not */
/* return multiple values.  Its presence on the stack (as a return address) */
/* identifies the stack frame to code which returns multiple values. */

_exportfn(C(ret1valn))
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz vsp,lisp_frame.savevsp(sp))
	__(mtlr loc_pc)
	__(lwz fn,lisp_frame.savefn(sp))
	__(la sp,lisp_frame.size(sp))
	__(vpush(arg_z))
	__(set_nargs(1))
	__(blr)
	


	.globl C(nvalret)
	
	/* Come here with saved context on top of stack. */
_spentry(nvalret)
C(nvalret):
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(lwz temp0,lisp_frame.savevsp(sp))
	__(lwz fn,lisp_frame.savefn(sp))
	__(la sp,lisp_frame.size(sp))
	__(b local_label(return_values))

	/* Come here to return multiple values when */
	/* the caller's context isn't saved in a lisp_frame. */
	/* lr, fn valid; temp0 = entry vsp */

_spentry(values)
	__(mflr loc_pc)
local_label(return_values):
	__(ref_global(imm0,ret1val_addr))
	__(mr arg_z,rnil)
	/* max tsp frame is 4K. 8+8 is overhead for save_values_to_tsp below */
	/* and @do_unwind in nthrowvalues in "sp_catch.s". */
	__(cmpwi cr2,nargs,4096-(8+8))
	__(cmpw cr1,imm0,loc_pc)
	__(cmpwi cr0,nargs,fixnum_one)
	__(bge cr2,2f)
	__(beq cr1,3f)
	__(mtlr loc_pc)
	__(add imm0,nargs,vsp)
	__(blt cr0,1f)
	 __(lwz arg_z,-4(imm0))
1: /* @home: */
	__(mr vsp,temp0)
	__(blr)

2: /* @too_many_values: */
        __(bl _SPxuuo_interr)
	__(uuo_interr(error_too_many_values,nargs))
	__(b 2b)

/* Return multiple values to real caller. */
3: /* @xfer: */
	__(lwz loc_pc,lisp_frame.savelr(sp))
	__(add imm1,nargs,vsp)
	__(mtlr loc_pc)
	__(lwz imm0,lisp_frame.savevsp(sp))
	__(cmpw cr0,imm1,imm0)		/* a fairly common case */
	__(lwz fn,lisp_frame.savefn(sp))
	__(cmpwi cr1,nargs,fixnum_one)	/* sadly, a very common case */
	__(la sp,lisp_frame.size(sp))
	__(beqlr cr0)			/* already in the right place */
	__(bne cr1,4f)
	 __(lwz arg_z,0(vsp))
	 __(mr vsp,imm0)
	 __(vpush(arg_z))
	 __(blr)
4:  /* @do_xfer_loop: */
	__(blt cr1,6f)
	__(li imm2,fixnum_one)
5: /* @xfer_loop: */
	__(cmpw cr0,imm2,nargs)
	__(addi imm2,imm2,fixnum_one)
	__(lwzu arg_z,-4(imm1))
	__(push(arg_z,imm0))
	__(bne cr0,5b)
6: /* @zero_values_case */
	__(mr vsp,imm0)
	__(blr)
_spentry(fitvals)
	__(subf. imm0,nargs,imm0)
	__(bge 2f)
	__(sub vsp,vsp,imm0)
	__(blr)
1:
	__(subic. imm0,imm0,4)
	__(vpush(rnil))
	__(addi nargs,nargs,4)
2:
	__(bne 1b)
	__(blr)
_spentry(nthvalue)
	__(add imm0,vsp,nargs)
	__(lwz imm1,0(imm0))
	__(cmplw imm1,nargs)	/*  do unsigned compare: if (n < 0) => nil. */
	__(mr arg_z,rnil)
	__(neg imm1,imm1)
	__(subi imm1,imm1,4)
	__(bge 1f)
	__(lwzx arg_z,imm0,imm1)
1:
	__(la vsp,4(imm0))
	__(blr)


/* "slide" nargs worth of values up the vstack.  IMM0 contains */
/*   the difference between the current VSP and the target. */
_spentry(mvslide)
	__(cmpwi cr0,nargs,0)
	__(mr imm3,nargs)
	__(add imm2,vsp,nargs)
	__(add imm2,imm2,imm0)
	__(add imm0,vsp,nargs)
	__(beq 2f)
1:
	__(cmpwi cr0,imm3,1<<fixnumshift)
	__(subi imm3,imm3,1<<fixnumshift)
	__(lwzu temp0,-4(imm0))
	__(stwu temp0,-4(imm2))
	__(bne cr0,1b)
2:
	__(mr vsp,imm2)
	__(blr)

/* Build a new TSP area to hold nargs worth of multiple-values. */
/* Pop the multiple values off of the vstack. */
/* The new TSP frame will look like this: */
/* 
+--------+-------+-------+---------+--------+--------+--------+======+----------+
| ptr to | zero  | nargs | ptr to  | valn-1 | valn-2 | val-0  | ???? | prev TSP | 
|  prev  |       |       |  prev   |        |        |        | fill |          | 
| TSP    |       |       | segment |        |        |        |      |          |
+--------+-------+-------+---------+--------+--------+--------+------+----------+ 
 */
/* e.g., the first multiple value goes in the last cell in the frame, the */
/* count of values goes in the first word, and the word after the value count */
/* is 0 if the number of values is even (for alignment). */
/* Subsequent calls to .SPadd_values preserve this alignment. */
/* .SPrecover_values is therefore pretty simple. */

_spentry(save_values)
	__(mr imm1,tsp)

/* common exit: nargs = values in this set, imm1 = ptr to tsp before call to save_values */
local_label(save_values_to_tsp):
	__(li imm0,-(8+8))		/* space for backptr, zero, count, link */
	__(mr imm2,tsp)
	__(sub imm0,imm0,nargs)
	__(bitclr(imm0,imm0,2))	/* down to dword boundary */
	__(mr initptr,tsp)		/* uninterruptable */
	__(stwux imm1,tsp,imm0)     /* keep one tsp "frame" as far as rest of lisp is concerned */
	__(sub initptr,tsp,imm0)	/* correct for stack overflow */
	__(stw rzero,-4(initptr))   /* just in case odd values */
	__(stw rzero,4(tsp))        /* lisp frame */
	__(stw nargs,8(tsp))
	__(stw imm2,12(tsp))        /* previous tsp */
	__(la initptr,16(tsp))
	__(add initptr,initptr,nargs)
	__(add imm0,vsp,nargs)
	__(cmpw cr0,imm0,vsp)
	__(b 2f)
1: /* @loop:  */
	__(lwzu arg_z,-4(imm0))
	__(cmpw cr0,imm0,vsp)
	__(stwu arg_z,-4(initptr))
2: /* @test: */
	__(bne cr0,1b)
	__(mr initptr,freeptr)
	__(add vsp,vsp,nargs)	/*  discard values */
	__(blr)

/* Add the multiple values that are on top of the vstack to the set */
/* saved in the top tsp frame, popping them off of the vstack in the */
/* process.  It is an error (a bad one) if the TSP contains something */
/* other than a previously saved set of multiple-values. */
/* Since adding to the TSP may cause a new TSP segment to be allocated, */
/* each add_values call adds another linked element to the list of */
/* values. This makes recover_values harder. */

_spentry(add_values)
	__(cmpwi cr0,nargs,0)
	__(lwz imm1,0(tsp))
	__(bne cr0,local_label(save_values_to_tsp))
	__(blr)

/* vpush the values in the value set atop the vsp, incrementing nargs. */
/* Discard the tsp frame; leave values atop the vsp. */

_spentry(recover_values)

/* First, walk the segments reversing the pointer to previous segment pointers */
/* Can tell the end because that previous segment pointer is the prev tsp pointer */
	__(lwz imm0,0(tsp))         /* previous tsp */
	__(mr imm1,tsp)             /* current segment */
	__(mr imm2,tsp)             /* last segment */
1: /* @walkloop: */
	__(lwz imm3,12(imm1))       /* next segment */
	__(cmpw cr0,imm0,imm3)     /* last segment? */
	__(stw imm2,12(imm1))       /* reverse pointer */
	__(mr imm2,imm1)            /* last segment <- current segment */
	__(mr imm1,imm3)           /* current segment <- next segment */
	__(bne cr0,1b)

/* the final segment ptr is now in imm2 */
/* walk backwards, pushing values on VSP and incrementing NARGS */
2: /* @pushloop: */
	__(lwz imm0,8(imm2))        /* nargs in segment */
	__(cmpwi cr0,imm0,0)
	__(cmpw cr1,imm2,tsp)
	__(la initptr,16(imm2))
	__(add initptr,initptr,imm0)
	__(add nargs,nargs,imm0)
	__(b 4f)
3: /* @loop: */
	__(lwzu arg_z,-4(initptr))
	__(cmpwi cr0,imm0,fixnum_one)
	__(subi imm0,imm0,fixnum_one)
	__(vpush(arg_z))
4: /* @test: */
	__(bne cr0,3b)
	__(lwz imm2,12(imm2))       /* previous segment  */
	__(bne cr1,2b)
	__(mr initptr,freeptr)
	__(unlink(tsp))
	__(blr)

/* from sp_builtin.s */

_spentry(builtin_plus)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(mtxer rzero)
	__(addo. imm0,arg_y,arg_z)
	__(bns 2f)
1:
	__(jump_builtin(_builtin_plus,2))
2:
        __(mr arg_z,imm0)
	__(blr)

_spentry(builtin_minus)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(mtxer rzero)
	__(subo. imm0,arg_y,arg_z)
	__(bns 2f)
1:
	__(jump_builtin(_builtin_minus,2))
2:
        __(mr arg_z,imm0)
	__(blr)



_spentry(builtin_times)
	__(jump_builtin(_builtin_times,2))

_spentry(builtin_div)
	__(jump_builtin(_builtin_div,2))

_spentry(builtin_eq)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(cmpr(cr2,arg_y,arg_z))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(mr arg_z,rnil)
	__(bnelr cr2)
	__(la arg_z,t_offset(rnil))
	__(blr)
1:
	__(jump_builtin(_builtin_eq,2))

_spentry(builtin_ne)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(cmpr(cr2,arg_y,arg_z))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(mr arg_z,rnil)
	__(beqlr cr2)
	__(la arg_z,t_offset(rnil))
	__(blr)
1:
	__(jump_builtin(_builtin_ne,2))
	
_spentry(builtin_gt)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(cmpr(cr2,arg_y,arg_z))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(mr arg_z,rnil)
	__(bnglr cr2)
	__(la arg_z,t_offset(rnil))
	__(blr)
1:
	__(jump_builtin(_builtin_gt,2))
	
_spentry(builtin_ge)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(cmpr(cr2,arg_y,arg_z))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(mr arg_z,rnil)
	__(bltlr cr2)
	__(la arg_z,t_offset(rnil))
	__(blr)
1:
	__(jump_builtin(_builtin_ge,2))
	
_spentry(builtin_lt)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(cmpr(cr2,arg_y,arg_z))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(mr arg_z,rnil)
	__(bnllr cr2)
	__(la arg_z,t_offset(rnil))
	__(blr)
1:
	__(jump_builtin(_builtin_lt,2))
	
_spentry(builtin_le)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(cmpr(cr2,arg_y,arg_z))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(mr arg_z,rnil)
	__(bgtlr cr2)
	__(la arg_z,t_offset(rnil))
	__(blr)
1:
	__(jump_builtin(_builtin_le,2))
	
	
_spentry(builtin_eql)
	__(cmpw cr0,arg_y,arg_z)
	__(extract_lisptag(imm0,arg_y))
	__(extract_lisptag(imm1,arg_z))
	__(cmpw cr1,imm0,imm1)
	__(beq cr0,1f)
	__(cmpwi cr0,imm0,tag_misc)
	__(bne cr1,2f)
	__(bne cr0,2f)
	__(jump_builtin(_builtin_eql,2))
1: /* @win: */
	__(la arg_z,t_offset(rnil))
	__(blr)
2: /* @lose: */
	__(mr arg_z,rnil)
	__(blr)

_spentry(builtin_length)
	__(cmpw cr1,arg_z,rnil)
	__(extract_typecode(imm0,arg_z))
	__(cmpwi cr0,imm0,min_vector_subtag)
	__(beq cr1,2f)
	__(beq cr0,1f)
	__(blt cr0,3f)
	/* (simple-array * (*))  */
	__(vector_length(arg_z,arg_z,imm0))
	__(blr)
1: /* @header: */
	__(lwz arg_z,vectorH.logsize(arg_z))
	__(blr)
2: /* @nil: */
	__(li arg_z,0)
	__(blr)
3: /* @do_call:	*/
	__(jump_builtin(_builtin_length,1))

_spentry(builtin_seqtype)
	__(extract_typecode(imm0,arg_z))
	__(cmpwi cr0,imm0,tag_list)
	__(cmpwi cr1,imm1,min_vector_subtag)
	__(beq cr0,1f)
	__(blt cr1,2f)
	__(mr arg_z,rnil)
	__(blr)
1: /* @t: */
	__(la arg_z,t_offset(rnil))
	__(blr)
2: /* @do_call: */
	__(jump_builtin(_builtin_seqtype,1))

_spentry(builtin_assq)
	__(cmpw cr0,arg_z,rnil)
	__(beqlr)
	__(jump_builtin(_builtin_assq,2))

_spentry(builtin_memq)
	__(jump_builtin(_builtin_memq,2))


_spentry(builtin_logbitp)
	/* Call out unless both fixnums,0 <=  arg_y < 30 */
        __(cmplri(cr2,arg_y,30<<fixnum_shift))
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(unbox_fixnum(imm0,arg_y))
	__(subfic imm0,imm0,30)        
  	__(rlwnm imm0,arg_z,imm0,31,31)
	__(rlwimi imm0,imm0,4,27,27)
	__(bnl cr2,1f)
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(add arg_z,rnil,imm0)
	__(blr)
1:
	__(jump_builtin(_builtin_logbitp,2))
	
_spentry(builtin_logior)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(or arg_z,arg_y,arg_z)
	__(blr)
1:
	__(jump_builtin(_builtin_logior,2))
_spentry(builtin_logand)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(and arg_z,arg_y,arg_z)
	__(blr)
1:
	__(jump_builtin(_builtin_logand,2))

_spentry(builtin_ash)
	__(jump_builtin(_builtin_ash,2))

_spentry(builtin_negate)
	__(extract_lisptag_(imm0,arg_z))
	__(bne cr0,1f)
	__(mtxer rzero) /* ;;mcrxr cr0 */
	__(nego. imm0,arg_z)
	__(bns 2f)
	
1: /* @do_call: */
	__(jump_builtin(_builtin_negate,1))
2: /* @retimm0: */
       __(mr arg_z, imm0)
      __(blr)


_spentry(builtin_logxor)
        __(extract_lisptag(imm0,arg_y))
        __(extract_lisptag(imm1,arg_z))
        __(cmpri(cr0,imm0,tag_fixnum))
        __(cmpri(cr1,imm1,tag_fixnum))
	__(bne cr0,1f)
        __(bne cr1,1f)
	__(xor arg_z,arg_y,arg_z)
	__(blr)
1: /* @do_call: */
	__(jump_builtin(_builtin_logxor,2))

_spentry(builtin_aref1)
	__(extract_typecode(imm0,arg_y))
	__(cmpwi cr0,imm0,min_vector_subtag)
	__(box_fixnum(arg_x,imm0))
	__(bgt cr0,_SPsubtag_misc_ref)
	__(jump_builtin(_builtin_aref1,2))

_spentry(builtin_aset1)
	__(extract_typecode(imm0,arg_x))
	__(cmpwi cr0,imm0,min_vector_subtag)
	__(box_fixnum(temp0,imm0))
	__(bgt cr0, _SPsubtag_misc_set)
	__(jump_builtin(_builtin_aset1,3))

/* 'trapless' stuff, for Rosetta. */

/* Make an ExceptionInformationPowerPC structure on ths stack; link it into the
   xframe list, and return its (fixnum-tagged) address in arg_z. */
save_xp:
        __(stwu sp,-(c_frame.minsiz+STACK_ALIGN(RegisterInformationPowerPC.size))(sp))
        __(stw r3,c_frame.minsiz+RegisterInformationPowerPC.R3.lo(sp))
        __(la r3,c_frame.minsiz(sp))
        __(stw rzero,RegisterInformationPowerPC.R0.hi(r3))
        __(stw r0,RegisterInformationPowerPC.R0.lo(r3))
        __(stw rzero,RegisterInformationPowerPC.R1.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R2.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R3.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R4.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R5.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R6.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R7.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R8.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R9.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R10.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R11.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R12.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R13.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R14.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R15.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R16.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R17.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R18.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R19.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R20.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R21.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R22.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R23.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R24.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R25.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R26.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R27.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R28.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R29.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R30.hi(r3))
        __(stw rzero,RegisterInformationPowerPC.R31.hi(r3))
	
        __(stw r31,RegisterInformationPowerPC.R31.lo(r3))
        __(stw r30,RegisterInformationPowerPC.R30.lo(r3))
        __(stw r29,RegisterInformationPowerPC.R29.lo(r3))
        __(stw r28,RegisterInformationPowerPC.R28.lo(r3))

        __(stw r27,RegisterInformationPowerPC.R27.lo(r3))
        __(stw r26,RegisterInformationPowerPC.R26.lo(r3))
        __(stw r25,RegisterInformationPowerPC.R25.lo(r3))
        __(stw r24,RegisterInformationPowerPC.R24.lo(r3))

        __(stw r23,RegisterInformationPowerPC.R23.lo(r3))
        __(stw r22,RegisterInformationPowerPC.R22.lo(r3))
        __(stw r21,RegisterInformationPowerPC.R21.lo(r3))
        __(stw r20,RegisterInformationPowerPC.R20.lo(r3))

        __(stw r19,RegisterInformationPowerPC.R19.lo(r3))
        __(stw r18,RegisterInformationPowerPC.R18.lo(r3))
        __(stw r17,RegisterInformationPowerPC.R17.lo(r3))
        __(stw r16,RegisterInformationPowerPC.R16.lo(r3))

        __(stw r15,RegisterInformationPowerPC.R15.lo(r3))
        __(stw r14,RegisterInformationPowerPC.R14.lo(r3))
        __(stw r13,RegisterInformationPowerPC.R13.lo(r3))
        __(stw r12,RegisterInformationPowerPC.R12.lo(r3))

        __(stw r11,RegisterInformationPowerPC.R11.lo(r3))
        __(stw r10,RegisterInformationPowerPC.R10.lo(r3))
        __(stw r9,RegisterInformationPowerPC.R9.lo(r3))
        __(stw r8,RegisterInformationPowerPC.R8.lo(r3))

        __(stw r7,RegisterInformationPowerPC.R7.lo(r3))
        __(stw r6,RegisterInformationPowerPC.R6.lo(r3))
        __(stw r5,RegisterInformationPowerPC.R5.lo(r3))
        __(stw r4,RegisterInformationPowerPC.R4.lo(r3))

        __(stw r2,RegisterInformationPowerPC.R2.lo(r3))
        __(lwz r4,0(sp))
        __(stw r4,RegisterInformationPowerPC.R1.lo(r3))
        __(stwu r4,-(STACK_ALIGN(FPUInformationPowerPC.size))(sp))
        __(la r4,c_frame.minsiz(sp))
        
        __(stfd f0,0*8(r4))
        __(stfd f1,1*8(r4))
        __(stfd f2,2*8(r4))
        __(stfd f3,3*8(r4))

        __(stfd f4,4*8(r4))
        __(stfd f5,5*8(r4))
        __(stfd f6,6*8(r4))
        __(stfd f7,7*8(r4))

        __(stfd f8,8*8(r4))
        __(stfd f9,9*8(r4))
        __(stfd f10,10*8(r4))
        __(stfd f11,11*8(r4))

        __(stfd f12,12*8(r4))
        __(stfd f13,13*8(r4))
        __(stfd f14,14*8(r4))
        __(stfd f15,15*8(r4))

        __(stfd f16,16*8(r4))
        __(stfd f17,17*8(r4))
        __(stfd f18,18*8(r4))
        __(stfd f19,19*8(r4))

        __(stfd f20,20*8(r4))
        __(stfd f21,21*8(r4))
        __(stfd f22,22*8(r4))
        __(stfd f23,23*8(r4))

        __(stfd f24,24*8(r4))
        __(stfd f25,25*8(r4))
        __(stfd f26,26*8(r4))
        __(stfd f27,27*8(r4))

        __(stfd f28,28*8(r4))
        __(stfd f29,29*8(r4))
        __(stfd f30,30*8(r4))
        __(stfd f31,31*8(r4))
	
        __(mffs f0)
        __(stfd f0,FPUInformationPowerPC.FPSCR(r4))
        __(lwz r6,FPUInformationPowerPC.Reserved(r4))
        __(stw r6,FPUInformationPowerPC.FPSCR(r4))
        __(lwz r5,0(sp))
        __(stwu r5,-(STACK_ALIGN(MachineInformationPowerPC.size))(sp))
        __(mfcr r6)
        __(mfxer r7)
        __(la r5,c_frame.minsiz(sp))
        __(stw r6,MachineInformationPowerPC.CR(r5))
        __(stw r7,MachineInformationPowerPC.XER(r5))
        __(stw rzero,MachineInformationPowerPC.CTR.hi(r5))
        __(stw loc_pc,MachineInformationPowerPC.CTR.lo(r5))
        __(stw rzero,MachineInformationPowerPC.LR.hi(r5))
        __(stw loc_pc,MachineInformationPowerPC.LR.lo(r5))
        __(stw rzero,MachineInformationPowerPC.PC.hi(r5))
        __(stw loc_pc,MachineInformationPowerPC.PC.lo(r5))
        __(lwz r7,0(sp))
        __(stwu r7,-c_frame.minsiz(sp))
        __(la arg_z,c_frame.minsiz(sp))
        __(stw r3,ExceptionInformationPowerPC.registerImage(arg_z))
        __(stw r4,ExceptionInformationPowerPC.FPUImage(arg_z))
        __(stw r5,ExceptionInformationPowerPC.MachineState(arg_z))
        __(stw rzero,ExceptionInformationPowerPC.theKind(arg_z))
        __(stw rzero,ExceptionInformationPowerPC.info(arg_z))
        __(stw rzero,ExceptionInformationPowerPC.vectorImage(arg_z))
        __(la r3,24(sp))
        __(ref_global(r4,xframe))
        __(stw arg_z,0(r3))
        __(stw r4,4(r3))
        __(set_global(r3,xframe))
        __(stw rzero,c_frame.savelr(sp))
        __(blr)

restore_xp:
        __(ref_global(r3,xframe))
        __(lwz arg_z,0(r3))
        __(lwz r4,4(r3))
        __(set_global(r4,xframe))
        /* After calling out to lisp, save and restore freeptr/initptr */
        __(lwz r3,ExceptionInformationPowerPC.registerImage(arg_z))
        __(stw r10,RegisterInformationPowerPC.R10.lo(r3))
        __(stw r9,RegisterInformationPowerPC.R9.lo(r3))
restore_xp_from_arg_z:             
        __(lwz r3,ExceptionInformationPowerPC.registerImage(arg_z))
        __(lwz r4,ExceptionInformationPowerPC.FPUImage(arg_z))
        __(lwz r5,ExceptionInformationPowerPC.MachineState(arg_z))
        __(lwz r6,MachineInformationPowerPC.CR(r5))
        __(lwz r7,MachineInformationPowerPC.XER(r5))
        __(mtcr r6)
        __(mtxer r7)
        __(lwz r5,FPUInformationPowerPC.FPSCR(r4))
        __(stw r5,FPUInformationPowerPC.Reserved(r4))
        __(lfd f0,FPUInformationPowerPC.FPSCR(r4))
        __(mtfsf 0xff,f0)
        __(lfd f0,0*8(r4))
        __(lfd f1,1*8(r4))
        __(lfd f2,2*8(r4))
        __(lfd f3,3*8(r4))
        __(lfd f4,4*8(r4))
        __(lfd f5,5*8(r4))
        __(lfd f6,6*8(r4))
        __(lfd f7,7*8(r4))
        __(lfd f8,8*8(r4))
        __(lfd f9,9*8(r4))
        __(lfd f10,10*8(r4))
        __(lfd f11,11*8(r4))
        __(lfd f12,12*8(r4))
        __(lfd f13,13*8(r4))
        __(lfd f14,14*8(r4))
        __(lfd f15,15*8(r4))
        __(lfd f16,16*8(r4))
        __(lfd f17,17*8(r4))
        __(lfd f18,18*8(r4))
        __(lfd f19,19*8(r4))
        __(lfd f20,20*8(r4))
        __(lfd f21,21*8(r4))
        __(lfd f22,22*8(r4))
        __(lfd f23,23*8(r4))
        __(lfd f24,24*8(r4))
        __(lfd f25,25*8(r4))
        __(lfd f26,26*8(r4))
        __(lfd f27,27*8(r4))
        __(lfd f28,28*8(r4))
        __(lfd f29,29*8(r4))
        __(lfd f30,30*8(r4))
        __(lfd f31,31*8(r4)        )
        __(lwz r31,RegisterInformationPowerPC.R31.lo(r3))
        __(lwz r30,RegisterInformationPowerPC.R30.lo(r3))
        __(lwz r29,RegisterInformationPowerPC.R29.lo(r3))
        __(lwz r28,RegisterInformationPowerPC.R28.lo(r3))
        __(lwz r27,RegisterInformationPowerPC.R27.lo(r3))
        __(lwz r26,RegisterInformationPowerPC.R26.lo(r3))
        __(lwz r25,RegisterInformationPowerPC.R25.lo(r3))
        __(lwz r24,RegisterInformationPowerPC.R24.lo(r3))
        __(lwz r23,RegisterInformationPowerPC.R23.lo(r3))
        __(lwz r22,RegisterInformationPowerPC.R22.lo(r3))
        __(lwz r21,RegisterInformationPowerPC.R21.lo(r3))
        __(lwz r20,RegisterInformationPowerPC.R20.lo(r3))
        __(lwz r19,RegisterInformationPowerPC.R19.lo(r3))
        __(lwz r18,RegisterInformationPowerPC.R18.lo(r3))
        __(lwz r17,RegisterInformationPowerPC.R17.lo(r3))
        __(lwz r16,RegisterInformationPowerPC.R16.lo(r3))
        __(lwz r15,RegisterInformationPowerPC.R15.lo(r3))
        __(lwz r14,RegisterInformationPowerPC.R14.lo(r3))
        __(lwz r13,RegisterInformationPowerPC.R13.lo(r3))
        __(lwz r12,RegisterInformationPowerPC.R12.lo(r3))
        __(lwz r11,RegisterInformationPowerPC.R11.lo(r3))
        __(lwz r10,RegisterInformationPowerPC.R10.lo(r3))
        __(lwz r9,RegisterInformationPowerPC.R9.lo(r3))
        __(lwz r8,RegisterInformationPowerPC.R8.lo(r3))
        __(lwz r7,RegisterInformationPowerPC.R7.lo(r3))
        __(lwz r6,RegisterInformationPowerPC.R6.lo(r3))
        __(lwz r5,RegisterInformationPowerPC.R5.lo(r3))
        __(lwz r4,RegisterInformationPowerPC.R4.lo(r3))
        __(lwz r2,RegisterInformationPowerPC.R2.lo(r3))
        __(mr r1,r3)
        __(lwz r3,RegisterInformationPowerPC.R3.lo(r3))
        __(lwz r1,RegisterInformationPowerPC.R1.lo(r1))
        __(li rzero,0)
        __(blr)


_spentry(fixnum_overflow)
        __(unbox_fixnum(imm0,arg_z))
        __(xoris imm0,imm0,0xc000)
_spentry(box_signed)
        __(ref_global(extra,heap_limit))
        __(la freeptr,8(freeptr))
        __(leaf_do_xalloc())
        __(li imm1,one_digit_bignum_header)
finish_bignum:
        __(stw imm1,0(initptr))
        __(stw imm0,4(initptr))
        __(la arg_z,fulltag_misc(initptr))
        __(mr initptr,freeptr)
        __(blr)
        
_spentry(box_unsigned)
        __(cmpwi imm0,0)
        __(bge _SPbox_signed)
        __(ref_global(extra,heap_limit))
        __(la freeptr,16(freeptr))
        __(leaf_do_xalloc())
        __(li imm1,two_digit_bignum_header)
        __(b finish_bignum)
        
        


         
	
_spentry(xuuo_interr)
        __(mflr loc_pc)
        __(la loc_pc,4(loc_pc))
        __(bl save_xp)
        __(mtlr loc_pc)
        __(lwz imm0,-4(loc_pc))
        __(clrlslwi arg_y,imm0,6,fixnumshift)
        __(li arg_x,XUUOINTERR)
        __(set_nargs(3))
        __(b _SPksignalerr)

        
_spentry(xuuo_intcerr)
        __(mflr loc_pc)
        __(la loc_pc,4(loc_pc))
        __(bl save_xp)
        __(stwu sp,-lisp_frame.size(sp))
        __(stw loc_pc,lisp_frame.savelr(sp))
        __(stw vsp,lisp_frame.savevsp(sp))
        __(stw fn,lisp_frame.savefn(sp))
        __(li fn,0)
        __(lwz imm0,-4(loc_pc))
        __(clrlslwi arg_y,imm0,6,fixnumshift)
        __(li arg_z,XUUOINTCERR)
        __(set_nargs(3))
        __(bl _SPksignalerr)
        __(bl restore_xp)
        __(mtlr loc_pc)
        __(blr)

	
_spentry(trap_wrongnargs)
	__(li imm2,XWRONGNARGS)
	__(b handle_wrong_nargs)
_spentry(trap_toofewargs)
	__(li imm2,XTOOFEWARGS)
	__(b handle_wrong_nargs)
_spentry(trap_toomanyargs)
	__(li imm2,XTOOMANYARGS)
handle_wrong_nargs:
	__(vpush_argregs())
	__(stwu sp,-lisp_frame.size(sp))
	__(add imm0,vsp,nargs)
	__(stw fn,lisp_frame.savefn(sp))
	__(stw loc_pc,lisp_frame.savelr(sp))
	__(stw imm0,lisp_frame.savevsp(sp))
	__(mr fn,nfn)
	__(mr arg_z,nargs)
	__(mr arg_y,fn)
	__(mr arg_x,imm2)
	__(set_nargs(3))
	__(b _SPksignalerr)

_spentry(trap_intpoll)
	__(ref_nrs_value(nargs,interrupt_level))
	__(cmpwi cr6,nargs,0)
	__(blelr cr6)
        __(mflr loc_pc)
        __(bl save_xp)
        __(ref_global(imm1,db_link))
        __(la imm2,nrs.interrupt_level(rnil))
        __(vpush(rzero))
        __(vpush(imm2))
        __(vpush(imm1))
        __(set_global(vsp,db_link))
	__(li nargs,-1<<fixnumshift)
        __(set_nrs_value(nargs,interrupt_level))
        __(create_lisp_frame())
	__(li fn,0)
	__(li arg_z,XINTPOLL)
	__(set_nargs(1))
        __(li imm0,0xd0)
        __(stw imm0,-4(sp))
        __(lfd f0,-8(sp))
        __(mtfsf 0xff,f0)
	__(bl _SPksignalerr)
        __(la sp,lisp_frame.size(sp))
        __(ref_global(imm1,db_link))
        __(lwz imm1,0(imm1))
        __(set_global(imm1,db_link))
        __(bl restore_xp)
        __(mtlr loc_pc)
	__(set_nrs_value(rzero,interrupt_level))
	__(blr)

/* Ensure that enough heap space is available to alocate a single CONS cell; leave FREEPTR pointing past */
/* it and INITPTR pointing to the 8 bytes of newly allocated, zeroed memory.  */
_spentry(ensure_cons)
        __(ref_global(extra,heap_limit))
        __(la freeptr,cons.size(freeptr))
        __(cmplw freeptr,extra)
        __(blelr+)
allocate_via_xalloc:    
        __(mflr loc_pc)
        __(build_lisp_frame())
        __(bl _SPxalloc_handler)
        __(uuo_xalloc(rnil,0,0))
        __(lwz loc_pc,lisp_frame.savelr(sp))
        __(la sp,lisp_frame.size(sp))
        __(mtlr loc_pc)
        __(blr)
                
/* Do what a call to xalloc_handler followed by a 'uuo_xalloc rnil,0,0' would do, but don't 
 expect a UUO to follow. */
_spentry(finish_alloc)
        __(mflr loc_pc)
        __(mr extra,sp)
        __(bl save_xp)
        __(set_global(r4,xframe))
/* A 'uuo_xalloc rnil,0,0' instruction  has the value 0x40018b */
        __(lis imm0,0x40)                   /* high 16 bits */
        __(mr imm1,arg_z)
        __(ori imm0,imm0,0x18b)     /* low 16 bits */
        __(ref_global(imm2,xalloc))
        __(ref_global(imm3,current_cs))
        __(stw extra,area.active(imm3))
        __(mtctr imm2)
        __(bctrl)
        __(bl restore_xp_from_arg_z)
        __(mtlr loc_pc)
        __(blr)
                
/* Ensure that extra bytes of heap space are available, GCing if necessary.  (extra should contain room for
 headers and alignment.) */
_spentry(ensure_heap_space)
        __(add freeptr,freeptr,extra)
        __(ref_global(extra,heap_limit))
        __(cmplw freeptr,extra)
        __(blelr)
        __(b allocate_via_xalloc)

        
/* likewise */
_spentry(leaf_ensure_heap_space)
        __(b _SPensure_heap_space)
        
/*  We've done a store into loc_g.  If the stored value is
    potentially younger than loc_g (at a greater heap address),
    set a refbit.  (Yes, every once in a while that means
    we set the bit when a fixnum is stored, or something like
    that.)  Try real hard to preserve all registers. */
_spentry(write_barrier)
        __(lwz rzero,0(loc_g))
        __(cmplw rzero,loc_g)
        __(ble 9f)
        __(stw imm0,-4(sp))
        __(stw imm1,-8(sp))
        __(ref_global(imm1,heap_start))
        __(sub imm0,loc_g,imm1)
        __(srwi imm0,imm0,dnode_shift)
        __(ref_global(imm1,oldspace_dnode_count))
        __(cmplw imm0,imm1)
        __(bge 8f)
        __(mr imm1,imm0)
        __(lis rzero,0x8000)
        __(clrlwi imm0,imm0,27)
        __(srw imm0,rzero,imm0)
        __(srwi imm1,imm1,5)
        __(slwi imm1,imm1,2)
        __(ref_global(rzero,refbits))
        __(add imm1,imm1,rzero)
        __(lwz rzero,0(imm1))
        __(or imm0,rzero,imm0)
        __(stw imm0,0(imm1))
8:
        __(lwz imm1,-8(sp))
        __(lwz imm0,-4(sp))
9:
        __(li rzero,0)
        __(mr loc_g,rzero)
        __(blr)

/* Store key (arg_z) in hash_vector (arg_x) at index (arg_y). If we need to memoize
    the store, set a refbit for the hash-vector, too.
   This can clobber imm regs and temporaries; it's called as a function. */
_spentry(set_hash_key)
        __(cmplw arg_z,arg_x)
        __(la imm0,misc_data_offset(arg_y))
        __(stwx arg_z,arg_x,imm0)
        __(blelr)
        __(add imm0,arg_x,imm0)
        __(ref_global(imm4,heap_start))
        __(sub imm0,imm0,imm4)
        __(ref_global(imm3,oldspace_dnode_count))
        __(srwi imm0,imm0,dnode_shift)
        __(cmplw imm0,imm3)
        __(bgelr)
        __(clrlwi imm1,imm0,27)
        __(lis imm2,0x8000)
        __(srw imm1,imm2,imm1)
        __(ref_global(imm3,refbits))
        __(srwi imm0,imm0,5)
        __(slwi imm0,imm0,2)
        __(lwzx imm2,imm3,imm0)
        __(or imm2,imm1,imm2)
        __(stwx imm2,imm3,imm0)
        __(sub imm0,arg_x,imm4)
        __(srwi imm0,imm0,dnode_shift)
        __(clrlwi imm1,imm0,27)
        __(lis imm2,0x8000)
        __(srw imm1,imm2,imm1)
        __(srwi imm0,imm0,5)
        __(slwi imm0,imm0,2)
        __(lwzx imm2,imm3,imm0)
        __(or imm2,imm1,imm2)
        __(stwx imm2,imm3,imm0)
        __(blr)


_spentry(udfcall)
        __(mflr loc_pc)
        __(bl save_xp)
        __(mtlr loc_pc)
        __(li arg_y,XXUDFCALL               )
        __(set_nargs(2))
        __(b _SPksignalerr)
        
/* Not continuable */
_spentry(uuovectorbounds)
        __(mflr loc_pc)
        __(la loc_pc,4(loc_pc))
        __(bl save_xp)
        __(mtlr loc_pc)
        __(lwz imm0,-4(loc_pc))
        __(clrlslwi arg_y,imm0,6,fixnumshift)
        __(li arg_x,XUUOVECTORBOUNDS)
        __(b _SPksignalerr)

/* Pretty much has to be continuable */
_spentry(uuoslotunbound)
        __(mflr loc_pc)
        __(la loc_pc,4(loc_pc))
        __(bl save_xp)
        __(create_lisp_frame())
        __(li fn,0)
        __(lwz imm0,-4(loc_pc))
        __(clrlslwi arg_y,imm0,6,fixnumshift)
        __(li arg_x,XUUOSLOTUNBOUND)
        __(set_nargs(3))
        __(bl _SPksignalerr)
        __(bl restore_xp)
        __(mtlr loc_pc)
        __(blr)

_spentry(uuounbound)  
        __(mflr loc_pc)
        __(la loc_pc,4(loc_pc))
        __(bl save_xp)
        __(create_lisp_frame())
        __(li fn,0)
        __(lwz imm0,-4(loc_pc))
        __(clrlslwi arg_y,imm0,6,fixnumshift)
        __(li arg_x,XUUOUNBOUND)
        __(set_nargs(3))
        __(bl _SPksignalerr)
        __(bl restore_xp)
        __(mtlr loc_pc)
        __(blr)

/* This needs to ffcall into the kernel. 'uuo_xalloc rt,ra,rb' instructions have been used */
/* both to allocate "large" (>= 32KB) objects and to invoke GC-related functionality.  We */
/* want to change the way that allocation works, but still need a way to call into the kernel */
/* if we can't trap into it (to invoke/configure the GC, SAVE-APPLICATION, etc.) */
_spentry(xalloc_handler)
        __(mflr loc_pc)
        __(mr extra,sp)
        __(la loc_pc,4(loc_pc))
        __(bl save_xp)
        __(set_global(r4,xframe))
        __(lwz imm0,-4(loc_pc))
        __(mr imm1,arg_z)
        __(ref_global(imm2,xalloc))
        __(ref_global(imm3,current_cs))
        __(stw extra,area.active(imm3))
        __(mtctr imm2)
        __(bctrl)
        __(bl restore_xp_from_arg_z)
        __(mtlr loc_pc)
        __(blr)
        
        
/* Check for overflow on the cstack (and, soon, the vstack.) */
_spentry(cscheck)
        __(ref_global(extra,cs_overflow_limit))
        __(cmplw sp,extra)
        __(bgt check_vstack)
        __(ref_global(imm0,current_cs))
        __(lwz imm1,area.softlimit(imm0))
        __(lwz imm2,area.hardlimit(imm0))
        __(cmpw extra,imm1)
        __(bne hard_overflow)
        __(set_global(imm2,cs_overflow_limit))
        __(li arg_y,XXSTKOVER)
        __(li arg_z,fixnumone)
        __(set_nargs(2))
        __(b _SPksignalerr)
check_vstack:   
        __(ref_global(extra,vs_overflow_limit))
        __(cmplw vsp,extra)
        __(bgtlr)
        __(ref_global(imm0,current_vs))
        __(lwz imm1,area.softlimit(imm0))
        __(lwz imm2,area.hardlimit(imm0))
        __(cmpw extra,imm1)
        __(bne hard_overflow)
        __(set_global(imm2,vs_overflow_limit))
        __(li arg_y,XXSTKOVER)
        __(li arg_z,13<<fixnumshift)
        __(set_nargs(2))
        __(b _SPksignalerr)
hard_overflow:  
        __(ref_nrs_value(temp0,toplcatch))
        __(li temp1,XSTKOVER)
        __(vpush(temp0))
        __(vpush(temp1))
        __(set_nargs(1))
        __(b _SPthrow)        
                

_spentry(tscheck)
        __(ref_global(extra,ts_overflow_limit))
        __(cmplw tsp,extra)
        __(bgtlr)
        __(ref_global(imm0,current_ts))
        __(lwz imm1,area.softlimit(imm0))
        __(lwz imm2,area.hardlimit(imm0))
        __(cmpw extra,imm1)
        __(bne hard_overflow)
        __(set_global(imm2,ts_overflow_limit))
        __(li arg_y,XXSTKOVER)
        __(li arg_z,12<<fixnumshift)
        __(set_nargs(2))
        __(b _SPksignalerr)

        
_spentry(xpfu_exception)
/* The instruction that follows the LR is a copy of the FP instruction that caused the exception. */
/* We need to split it into two fixnums: major opcode (in high 6 bits), and everything else. */
        __(mflr loc_pc)
        __(la loc_pc,4(loc_pc))
        __(bl save_xp)
        __(mtlr loc_pc)
        __(lwz imm0,-4(loc_pc))
        __(clrlslwi arg_y,imm0,6,fixnumshift)
        __(clrrwi arg_x,imm0,26)
        __(srwi arg_x,arg_x,26-fixnumshift)
        __(li imm0,XFPUEXCEPTION)
        __(vpush(imm0))
        __(set_nargs(4))
        __(b _SPksignalerr)
        
 

	
        
	
/*  EOF, basically */
        .globl _SPsp_end
       b _SPsp_end
	_endfile
