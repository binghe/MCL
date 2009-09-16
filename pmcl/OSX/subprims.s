
/*
;;	Change History (most recent first):
;;  3 8/25/97  akh  see below
;;  5 12/22/95 gb   getXlong does UUO, not dc.l
;;  3 11/15/95 gb   toplevel-loop allows throwing to toplevel
;;  (do not edit before this line!!)

;;; 02/14/97 gb   maintain NV FP regs.
;;; --- 4.0
;;; 09/10/96 gb   fix integer_sign.
;;; 06/19/96 bill call_closure computes old top of VSP as index from new top instead of
;;;               remembering the old top. This makes it work if vpushing the extra nils
;;;               causes a stack segment overflow.
;;; 06/13/96 gb  maintain fp_zero in start_lisp
;;; --- 3.9 release ---
;;; 03/20/96 gb  start_lisp gets a reset_p arg, calls .SPreset when true.
;;; 03/07/96 bill getxlong handles extended strings
;;; 12/13/95 gb  toplevel-loop: return nil, init fn to 0.
;;; 11/15/95 gb  toplevel-loop different.
;;; 11/04/95 gb  getxlong uses symbolic header constants
*/

	include(lisp.s)
	_beginfile

	.globl _SPmkcatch1v
	.globl _SPnthrow1value	


/* This is called from a c-style context and calls a lisp function. */
/* This does the moral equivalent of */
/*   (loop 
       (catch %toplevel-catch% 
         (let* ((fn (symbol-value *toplevel-function*)))
           (if fn (funcall fn) (return nil))))))) 
*/

_exportfn(toplevel_loop)
	__(mflr imm0)
	__(stw imm0,c_frame.savelr(sp))
	__(b local_label(test))
local_label(loop):
	__(ref_nrs_value(arg_z,toplcatch))
	__(bl _SPmkcatch1v)
	__(b local_label(test))			/* cleanup address, not really a branch */

	
	__(ref_nrs_value(temp0,toplfunc))
	__(cmpw cr0,temp0,rnil)
	__(set_nargs(0))
	__(beq cr0,local_label(test))
	__(bl _SPfuncall)
	__(mr arg_z,rnil)
	__(li imm0,fixnum_one)
	__(bl _SPnthrow1value)
local_label(test):
	__(ref_nrs_value(temp0,toplfunc))
	__(cmpw cr0,temp0,rnil)
	__(bne cr0,local_label(loop))
local_label(back_to_c):
	__(lwz imm0,c_frame.savelr(sp))
	__(mtlr imm0)
	__(blr)
	_endfn



/* This sucker gets called with R3 pointing to lisp_nil.
;; r4 is 0 if we want to start the whole thing rolling,
;; non-zero if we want to reset the current process
;; by throwing to toplevel
;; Whatever -was- in rtoc isn't very interesting to us.
*/
	.globl _SPreset

_exportfn(C(start_lisp))
	__(mflr r0)
	__(mr rnil,r3)
	__(stw r0,c_frame.savelr(sp))
	__(stwu sp,-(c_frame.minsiz+(32*4))(sp))
	__(stmw r13,c_frame.minsiz(sp))		/* don't worry about the stmw. */
	__(stfd fp_zero,c_frame.minsiz+(18*4)(sp))
	__(stfd fp_s32conv,c_frame.minsiz+(19*4)(sp))
	__(lwi(r30,0x43300000))
	__(lwi(r31,0x80000000))
	__(stw r30,-8(sp))
	__(stw r31,-4(sp))
	__(lfd fp_s32conv,-8(sp))

	__(lfs fp_zero,lisp_globals.short_float_zero(rnil))
	__(li rzero,0)
	__(mr save0,rnil)
	__(mr save1,rnil)
	__(mr save2,rnil)
	__(mr save3,rnil)
	__(mr save4,rnil)
	__(mr save5,rnil)
	__(mr save6,rnil)
	__(mr save7,rnil)
	__(mr arg_z,rnil)
	__(mr arg_y,rnil)
	__(mr arg_x,rnil)
	__(mr temp0,rnil)
	__(mr temp1,rnil)
	__(mr temp2,rnil)
	__(mr temp3,rnil)
	__(li fn,0)
	__(li loc_g,0)
	__(li loc_pc,0)
	__(cmpwi cr0,r4,0)
	__(ref_global(vsp,save_vsp))
	__(ref_global(tsp,save_tsp))
	__(ref_global(freeptr,save_freeptr))
	__(mr initptr,freeptr)
	__(bne cr0,1f)
	__(bl toplevel_loop)
	__(b 2f)
1:
	__(bl _SPreset)
2:	
	__(set_global(freeptr,save_freeptr))
	__(set_global(tsp,save_tsp))
	__(set_global(vsp,save_vsp))
	__(lmw r13,c_frame.minsiz(sp))
	__(mr r3,rnil)
	__(lfd fp_zero,c_frame.minsiz+(18*4)(sp))
	__(lfd fp_s32conv,c_frame.minsiz+(19*4)(sp))
	__(lwz r0,(c_frame.minsiz+(32*4)+c_frame.savelr)(sp))
	__(mtlr r0)
	__(la sp,(c_frame.minsiz+(32*4))(sp))
	__(blr)


/*
	export start_lisp{ds}
	csect start_lisp{ds}
	dc.l start_lisp,TOC{tc0}
	
	toc
	tc start_lisp,start_lisp{ds}
*/

_exportfn(C(subprims_end))


 _exportfn(_SPsp_end)   /* huh? */
	nop
	_endfile

	

