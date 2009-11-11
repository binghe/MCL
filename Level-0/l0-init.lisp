;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l0-init.lisp,v $
;;  Revision 1.10  2006/02/03 19:52:39  alice
;;  ; add :ccl-5.2 to *features*
;;
;;  Revision 1.9  2003/12/08 23:01:50  svspire
;;  :mcl-enhanced-mop still doesn't sound right. Change to
;;  :mcl-common-mop-subset and :mcl-mop-2.
;;  :mcl-common-mop-subset should be used in OpenMCL too.
;;  :mcl-mop-2 is specific to MCL, and says what level
;;  of MOP support is present.
;;
;;  Revision 1.8  2003/12/08 22:17:33  svspire
;;  :mcl-partial-mop feature --> :mcl-enhanced-mop
;;
;;  Revision 1.7  2003/12/08 07:56:05  gtbyers
;;  Define *LOAD-VERBOSE* here.  Add :CCL-5.1, :MCL-PARTIAL-MOP to *FEATURES*.
;;
;;  2 10/5/97  akh  features
;;  3 12/22/95 gb   add :ppc-target to *features* on ppc
;;  2 12/1/95  akh  get most/least positive-fixnum right
;;  (do not edit before this line!!)


;; L0-init.lisp
; Copyright 1995-1999 Digitool, Inc. 

;; Modification History
;
; remove :cltl2 from *features*
; ------ 5.2b6
; add :ccl-5.2 to *features*
; ---- 5.1 final
; more *features* 4.3.5 and 5.0
; add carbon-compat to *features* here
; ------- 4.4b5
; 4.3.1 on *features*
; ------------
; 08/20/96 bill ccl-4 on *features*
; ------------- 4.0b1
; 07/16/96 gb   :PPC-CLOS on *features*.
; ----- 3.9 ----
; 11/27/95 akh the float constants etc are defined in l1-init, array-total-size-limit was wrong?
; 10/20/95 slh   new from l1-init.lisp

(defconstant array-total-size-limit 
  #-ppc-target #.(/ (expt 2 22) 8)
  #+ppc-target #.(expt 2 (- ppc::nbits-in-word ppc::num-subtag-bits)))


;Features for #+/- conditionalization:
; #+:CORAL = common to ccl and beanie
; #+:COMMON-LISP = not MacLisp, not Scheme...
; #+:CCL = this particular lisp implementation
(defparameter *features*
  '(:ccl :ccl-2 :ccl-3
    :coral :apple :digitool
    :common-lisp :mcl
    ;:cltl2    ;; a dietz test doesn't like this
    :processes
    :carbon-compat
    #+interfaces-2 :interfaces-2
    #+ppc-target :ccl-4
    #+ppc-target :ccl-4.2
    #+ppc-target :ccl-4.3
    #+ppc-target :ccl-4.3.1
    #+ppc-target :ccl-4.4
    #+ppc-target :ccl-4.3.5
    #+ppc-target :ccl-5.0
    #+ppc-target :ccl-5.1
    #+ppc-target :ccl-5.2    #+ppc-target :ccl-5.2.1
    #+ppc-target :powerpc
    #+ppc-target :ppc-target
    #+ppc-target :ppc-clos              ; used in encapsulate
    #+ppc-target :rmcl
    :mcl-common-mop-subset ; Feature common to MCL and OpenMCL indicating "almost complete MOP".
    :mcl-mop-2             ;  This says just how complete. :mcl-mop-1 would have described the
                           ;  level of MOP support in MCL 5.0 and previous. Namely, not very much, but not zero either.

))

(defparameter *load-verbose* nil)

;All Lisp package variables... Dunno if this still matters, but it
;used to happen in the kernel...
(dolist (x '(* ** *** *APPLYHOOK* *DEBUG-IO*
             *DEFAULT-PATHNAME-DEFAULTS* *ERROR-OUTPUT* *EVALHOOK*
             *FEATURES* *LOAD-VERBOSE* *MACROEXPAND-HOOK* *MODULES*
             *PACKAGE* *PRINT-ARRAY* *PRINT-BASE* *PRINT-CASE* *PRINT-CIRCLE*
             *PRINT-ESCAPE* *PRINT-GENSYM* *PRINT-LENGTH* *PRINT-LEVEL*
             *PRINT-PRETTY* *PRINT-RADIX* *QUERY-IO* *RANDOM-STATE* *READ-BASE*
             *READ-DEFAULT-FLOAT-FORMAT* *READ-SUPPRESS* *READTABLE*
             *STANDARD-INPUT* *STANDARD-OUTPUT* *TERMINAL-IO* *TRACE-OUTPUT*
             + ++ +++ - / // /// ARRAY-DIMENSION-LIMIT ARRAY-RANK-LIMIT
             ARRAY-TOTAL-SIZE-LIMIT BOOLE-1 BOOLE-2 BOOLE-AND BOOLE-ANDC1
             BOOLE-ANDC2 BOOLE-C1 BOOLE-C2 BOOLE-CLR BOOLE-EQV BOOLE-IOR
             BOOLE-NAND BOOLE-NOR BOOLE-ORC1 BOOLE-ORC2 BOOLE-SET BOOLE-XOR
             CALL-ARGUMENTS-LIMIT CHAR-CODE-LIMIT
             DOUBLE-FLOAT-EPSILON DOUBLE-FLOAT-NEGATIVE-EPSILON
             INTERNAL-TIME-UNITS-PER-SECOND LAMBDA-LIST-KEYWORDS
             LAMBDA-PARAMETERS-LIMIT LEAST-NEGATIVE-DOUBLE-FLOAT
             LEAST-NEGATIVE-LONG-FLOAT LEAST-NEGATIVE-SHORT-FLOAT
             LEAST-NEGATIVE-SINGLE-FLOAT LEAST-POSITIVE-DOUBLE-FLOAT
             LEAST-POSITIVE-LONG-FLOAT LEAST-POSITIVE-SHORT-FLOAT
             LEAST-POSITIVE-SINGLE-FLOAT LONG-FLOAT-EPSILON
             LONG-FLOAT-NEGATIVE-EPSILON MOST-NEGATIVE-DOUBLE-FLOAT
             MOST-NEGATIVE-FIXNUM MOST-NEGATIVE-LONG-FLOAT
             MOST-NEGATIVE-SHORT-FLOAT MOST-NEGATIVE-SINGLE-FLOAT
             MOST-POSITIVE-DOUBLE-FLOAT MOST-POSITIVE-FIXNUM
             MOST-POSITIVE-LONG-FLOAT MOST-POSITIVE-SHORT-FLOAT
             MOST-POSITIVE-SINGLE-FLOAT MULTIPLE-VALUES-LIMIT PI
             SHORT-FLOAT-EPSILON SHORT-FLOAT-NEGATIVE-EPSILON
             SINGLE-FLOAT-EPSILON SINGLE-FLOAT-NEGATIVE-EPSILON))
  (%symbol-bits x (%ilogior2 (%symbol-bits x) (ash 1 $sym_bit_special))))

; end
