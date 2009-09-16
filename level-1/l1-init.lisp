;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-init.lisp,v $
;;  Revision 1.14  2006/03/21 01:55:03  alice
;;  ;; *read-default-float-format* is 'double-float !!  - is effectively back compatible with MCL 5.1 brain death and best IMHO
;;
;;  Revision 1.13  2006/03/08 20:39:27  alice
;;  ;; float constants - single-float same as short-float please?
;;
;;  Revision 1.12  2006/02/19 22:30:47  alice
;;  ;; simplify resolve-macho-entry-point
;; ----- 5.2b1
;;
;;  Revision 1.11  2006/02/03 01:51:20  alice
;;  ;; put macho-entry-point stuff here
;;
;;  Revision 1.10  2005/11/29 21:06:29  alice
;;  ;; screen-size/position - say href (the href/pref deducer for rref is temporarily broken and shouldn't be counted on anyway)
;;
;;  Revision 1.9  2004/03/03 00:41:47  svspire
;;  Define system-version. Less overhead than (gestalt "sysv"), and better than defining an endless
;;  series of non-backward compatible [large-cat-du-jour]-p functions. At least this way there's only one non-backward compatible function, and it's easy to check with fboundp and punt with gestalt if not there.
;;
;;  Revision 1.8  2003/12/08 08:38:12  gtbyers
;;  *LOAD-VERBOSE* moved to level-0.  Use DBG in early ERROR.
;;
;;  Revision 1.7  2003/12/01 17:56:07  gtbyers
;;  recover pre-MOP changes
;;
;;  Revision 1.5  2003/10/19 04:56:58  alice
;;  ;; check-carbonlib-version may whine about preferred-size too
;;
;;  Revision 1.4  2003/07/10 18:38:17  alice
;;  ;; get-current-screen-size sets *screen-gdevice* too
;;
;;  Revision 1.3  2003/02/06 19:35:38  gtbyers
;;  Move defvars of *BLACK-RGB*, *WHITE-RGB*, *IS-NORMALIZED* here.
;;
;;  17 9/4/96  akh  short-float-epsilon for 68K
;;  16 7/18/96 akh  fix xx-float-epsilon and xx-float-negative-epsilon
;;  9 2/19/96  akh  read-default-float-format reverts to single-float
;;  8 2/19/96  akh  reinstate short float constants (eql double-float ditto)
;;  6 12/1/95  akh  get most/least-positive-fixnum right
;;  5 11/22/95 akh  constants most/least/positive/negative double float return
;;  6 5/4/95   akh  char-code-limit
;;  6 3/2/95   slh  array limit mods
;;  4 1/11/95  akh  move modeline
;;  3 1/11/95  akh  add ccl-3 to *features*
;;  (do not edit before this line!!)

;; L1-init.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;; *read-default-float-format* => 'single-float (??)
;; char-code-limit = 65536
;; define string here - bootstrap
;; ----- 5.2b6
;; fiddle with load-framework-bundle so can be redefined later for bundles in other locations
;; *read-default-float-format* is 'double-float !!  - is effectively back compatible with MCL 5.1 brain death and best IMHO
;; add "AGL.framework" to (all-bundles)  add function add-framework-bundle
;; float constants - single-float same as short-float please?
;; simplify resolve-macho-entry-point
;; ----- 5.2b1
;; put macho-entry-point stuff here
;; screen-size/position - say href (the href/pref deducer for rref is temporarily broken and shouldn't be counted on anyway)
;; ---- 5.1 final
;; define system-version. Less overhead than (gestalt "sysv"), and better than defining an endless
;;   series of non-backward compatible [large-cat-du-jour]-p functions.
;;----------- 5.1b1
;; check-carbonlib-version may whine about preferred-size too
;; get-current-screen-size sets *screen-gdevice* too - does "cnfg" notify about this change?
; ----------- 5.0 final
; osx-p no longer defined here - defined earlier
; *pixels-per-inch-x*/y fixed for OSX - does anybody care
; ----------- 4.4b5
; define jaguar-p
;; ------ 4.4b4
; 02/19/02 fix bbox-p
; 12/08/01 check-carbonlib-version at startup
; 03/21/01 akh add bbox-p
; carbon-compat
; change pen-modes stuff
; getqdglobalsmumble
;02/01/00 akh lose getwmgrport (for OSX), add osx-p
; --------- 4.3f1c1
; 03/14/99 akh  increase hpos of *window-default-position* for OS 8 etc.
;                we assume view-default-position is only called before the window is shown so
;                anything fancier would be pointless.
; 03/14/99 akh  get-current-screen-size - factored out of def-ccl-pointers
;;---------------- 4.2
; 02/17/97 gb   short-float constants.  Should split to ppc, 68k ?
; ------------  4.0
; 09/25/96 bill (def-ccl-pointers qd ...) initializes *current-cursor* to
;               a copy of *arrow-cursor*.
; ------------  4.0b2
;  9/04/96 slh  *current-cursor* (for GC to restore)
; 06/20/96 gb   *total-gc-microseconds* now an array of unsigned-wide
; 04/25/96 bill ":AppGen.fasl" => (merge-pathnames *.fasl-pathname* ":AppGen")
; ------------- MCL-PPC 3.9
; 04/12/96 bill *window-default-size* gets 38 pixels higher.
;               *listener-window-position* moves down to compensate and moves
;               right 2 pixels to line up horizontally.
;               This is as tall as you can go and still fit on the smallest
;               screen (640x400) with room for the control strip below.
; 03/26/96  gb  lowmem accessors.
;03/14/96 bill  *ccl-file-creator* -> #:|CCL2|
;03/10/96 gb    *ccl-file-creator* -> #:|PMCL|
;12/27/95 gb    PPC gc-metering vars.
;11/07/95 gb    new QD globals initialization.
;10/20/95 slh   de-lapified; *features* -> l0-init.lisp
; 3/12/95 gb    no more %nilreg-mumble-symbols%.
; 5/12/95 slh   :apple back on *features*; added :interfaces-2, :digitool!
; 4/04/95 slh   *ccl-file-creator*
; 3/07/95 slh   new *main-listener-process-name*
; 3/02/95 slh   array-dimension-limit, array-total-size-limit corrected again
;-------------  3.0d17
; 1/25/95 slh   array-dimension-limit, array-total-size-limit corrected
;-------------  3.0d16
;06/22/93 bill  Can again use #_GetCursor instead of #_GetResource for *i-beam-cursor*
;               and *watch-cursor* (saves some Mac Heap on machines where these are
;               ROM resources).
;-------------  3.0d11
;05/06/93 bill  *pre-gc-hook-list*, *post-gc-hook-list*
;-------------  3.0d8
;05/03/93 bill  *menu-id-object-alist* -> l1-menus & changes its name
;04/30/93 bill  add :processes to *features*
;04/26/93 bill  *event-processing-loop-tag*
;03/23/93 alice fred-help-window-size&pos
;03/19/93 bill defvar's for *pre-gc-hook* and *post-gc-hook*
;03/08.93 bill multiple-values-limit is now 200
;12/31/92 bill *eventhook*, *modal-dialog-on-top*, & *selected-window* are
;              defined with DEFGLOBAL instead of DEFVAR.
;11/20/92 gb   *last-break-level*.
;-------- 2.0
;02/22/92 gb   Move (re-)initialization of *TEMP-RGN*, *TEMP-RGN-2*, *EMPTY-RGN*, 
;              *SIMPLE-VIEW-CLIP-REGION* here from views.lisp.
;-------- 2.0f2c5
;12/20/91 gb   :cltl2 on *features*.
;-------- 2.0b4
;10/17/91 bill (defvar *gc-event-status-bits*)
;10/27/91 gb   no more *fasl-compiler-warnings*.
;-------- 2.0b3
;08/29/91 gb   array-total-size-limit was wrong; array-dimension-limit was probably
;              wrong.
;08/24/91 gb   new trap syntax.
;07/21/91 gb   no more kernel type symbols.  Declaim.  *BREAK-ON-WARNINGS* not
;              given mystery treatment.  No more *save-link-maps*.
;06/29/91 alice nuke *stepper-running*
;06/17/91 bill *current-font-view*
;----------- 2.0b2
;05/23/91 bill open-doc-string-file moved from here to startup-ccl2
;05/20/91 gb   new short-float constants.  &restv a lambda-list keyword.
;03/04/91 bill load the help map at startup if *arglist-on-space* is turned on.
;01/28/91 gb   *apropos-case-sensitive-p*.
;01/14/91 gb   internal-time-units-per-second now 1000.
;----------- 2.0b1
;01/07/91 akh  *mini-buffer-help-output* T
;01/09/91 bill :MACL -> :MCL in *features*
;01/07/91 gb   *autoload-lisp-package*
;01/01/91 bill *inspector-disassembly*
;12/28/90 bill *arglist-on-space* defaults to T (as a fixup)
;12/07/90 bill *fast-help*
;11/12/90 gb   don't defparameter things which are already inited.  Turn
;              *save-local-symbols* off; can turn on before shipping if need be.
;11/07/90 bill *white-color* comes here from color.lisp
;10/16/90 gb   manual will now have to explain to beginners why gc takes so
;              long & happens so often. (*save-local-symbols* defaults to T)
;09/10/90 bill *autoload-traps*
;08/29/90 joe  removed *fred-window-position* and *fred-window-size*
;              add *window-default-position* *window-default-size*
;              *window-default-zoom-position* *window-default-zoom-size*
;              changed screen-size def-load-pointers to fill in the default-zoom
;08/28/90 bill Remove variable *%saved-method-var%*, just initialize the nilreg offset
;08/07/90 bill delete *default-save-as-directory*
;07/26/90 bill *listener-default-font-spec*
;07/05/90 bill *minibuffer-help-output* -> *mini-buffer-help-output*
;06/27/90 bill add *%saved-method-var%*
;05/30/90 gb   %cons-name%.
;05/05/90 bill *scrap-ok* no longer needed.
;05/04/90 bill change *foreground* def to defparameter so it gets set.
;03/20/90 gz   normalized float constants.
;04/30/90 gb   forget *compiler-warnings* (should forget *fasl-compiler-warnings*
;              as well.) Get cursors from anywhere but ROM.  No more char-foo-limit.
;              New restart stuff.
;02/28/90 bill color-window-mixin moved to l1-windows.
;02/16/90 bill *write-pb1* & *write-pb-2* are no longer used.
;01/15/90 bill Added *modal-dialog-on-top*
;01/09/90 bill Added *selected-window*
;12/29/89 bill Moved *color-available* and *black-color* from color.lisp
;12/27/89 bill added *lisp-startup-functions* & *current-view*
;12/27/89 gz  No more $sym_bit_unshad.
;             Recompute :mc68881 feature on startup.
;             Added *load-print*, %unbound-function%.
;             Removed obsolete #-bccl conditionalizations.
;             Removed *processing-setf*.
;11/27/89 gb No compiler warnings until CL loaded. Bypass _GetCursor (ROM rsrc bd).
;10/16/89 gz  Removed %object-name%.
;10/13/89 bill Added *lisp-cleanup-functions*
;09/30/89 bill Removed the def-print-exception forms: new printer doesn't use them
;09/27/89 gb  some defvars here from eval.lisp .
;09/17/89 gb  transformed lap-functions don't lfret.  No object lisp.
;09/16/89 bill Removed the last vestiges of object-lisp windows.
;              Still contains (have 'object-children nil 'object-name nil)
;09/14/89 bill add *level-1-loaded*
;9/13/89  gz  flushed *lisp-fasl-file-version*
;09/04/89 gz  added :ccl-2 to *features*
;08/29/89 gb  Flush *cl-special-forms*.
;07/20/89 gz  clos menus.
;05/31/89 gz  nilreg symbols variables.
;05/02/89 gz  *save-link-maps*
;23-mar-89 as *color-window-mixin*
;04/15/89 gz  %real-name%.
;04/07/89 gb  $sp8 -> $sp.
;03/22/89 gz  Constants for kernel. Unshadowable bit munging (from the kernel).
;	      *interrupt-level*.  Clear write-pb's.
;03/10/89 gz  No more *dribble-input-mixin*
;03/03/89 gz  %lisp-system-fixups%
;2-mar-89 as  removed window-selection-menu-item
;             added windows-menu-menu-item
;01/10/89 gb  PBs for sysio.
;01/10/89 gz  %restarts% and %handlers%.
;01/04/89 gz  added buffer streams, changed selection streams.
;12/31/88 gz  Reset pattern pointers on reload.  Init cursor vars, reader vars.
;11/28/88 gz  added *screen-size*, *fred-help-window-size/position*
;11/23/88 gb  proclaim streams to be streams.
;11/09/88 gb  no more &KEY*.
;10/29/88 gb  define lisp-package constants here.
;10/23/88 gb  8.9 upload.
;9/02/88  gz  moved *font-list*, *big-rgn*, *big-rect*, *grow-bm* to l1-windows.
;8/23/88  gz   removed *warnings* and *fasl-compiler-warnings*, nx8-*ignored-symbols*
;		$inest-ptr-8 -> $inest
;8/16/88  gz   *file-compiling* -> *compiling-file*...
;8/02/88  gz   Added *file-compiling*
;7/26/88  gz   Put :MC68881 on *features* if Lisp is using the 68881 (which is
;		not nec. the same as the machine having one).
;  3/30/88 gz  New macptr scheme. Flushed pre-1.0 edit history.

;6/27/88  jaj ignore and ignored no longer ignored
;6/23/88  as  *paste-with-styles*, *fasl-compiler-warnings*
;             *save-definitions* defaults to nil.
;6/22/88  jaj removed %doc-file-refnum
;6/9/88   jaj moved %doc-string-file here from misc.lisp added
;             %doc-file-refnum
;6/8/88   jaj added *save-local-symbols*, nx-*ignored-symbols*
;6/6/88   jaj added *window-selection-menu-item*
;5/31/88  as  *save-fred-window-positions*
;5/19/88  as  punted *abort-character*
;5/19/88  jaj *features* doesn't initially check for 68881
;5/11/88  jaj added *compiler-warnings*, *warnings*, *idle*
;4/06/88  as  added *fred-default-font-spec*
;4/5/88   jaj added objvars around window-[grow/drag]-rect
;4/4/88   jaj added *processing-setf*
;10/22/87 jaj added *foreground*
;10/21/87 jaj *grow-rect*, *drag-rect* -> window-grow-rect, window-drag-rect
;  3/01/88  gz Eliminate compiler warnings.
; 10/22/87 jaj added *foreground*
; 10/21/87 jaj *grow-rect*, *drag-rect* -> window-grow-rect, window-drag-rect
;              and have them in *window*
; 10/19/87 jaj  changed *grow-rect* and *drag-rect* to be non-special
; 10/16/87 jaj  removed *i-beam* bootstrap
; 10/15/87 cfry *ibeam-cursor* -> *i-beam-cursor*
; 10/15/87 jaj moved *next-screen-context-lines* here from fred-additions-2
;              added *warn-if-redefine-kernel*
; 10/12/87 cfry removed (ask *file-stream*
;                             (have 'open-file-streams nil))
;          added (defvar *open-file-streams* nil)
;-----------------------------Version 1.0---------------------------------------

(defvar *ccl-file-creator* #+ppc-target :|CCL2| #-ppc-target :|CCL2|)





#+ppc-target ; test this!
(eval-when (:compile-toplevel :execute :load-toplevel)

(defconstant most-positive-short-float (make-short-float-from-fixnums (1- (ash 1 23)) 254 0))
(defconstant most-negative-short-float (make-short-float-from-fixnums (1- (ash 1 23)) 254 -1))
(defconstant most-positive-single-float (make-short-float-from-fixnums (1- (ash 1 23)) 254 0))
(defconstant most-negative-single-float (make-short-float-from-fixnums (1- (ash 1 23)) 254 -1))


(defconstant least-positive-short-float (make-short-float-from-fixnums 1 0 0))
(defconstant least-negative-short-float (make-short-float-from-fixnums 1 0 -1))
(defconstant least-positive-single-float (make-short-float-from-fixnums 1 0 0))
(defconstant least-negative-single-float (make-short-float-from-fixnums 1 0 -1))

(defconstant short-float-epsilon (make-short-float-from-fixnums 1 103 0))
(defconstant short-float-negative-epsilon (make-short-float-from-fixnums 1 102 0))
(defconstant single-float-epsilon (make-short-float-from-fixnums 1 103 0))
(defconstant single-float-negative-epsilon (make-short-float-from-fixnums 1 102 0))

(defconstant least-positive-normalized-short-float (make-short-float-from-fixnums 1 1 0))
(defconstant least-negative-normalized-short-float (make-short-float-from-fixnums 1 1 -1))
(defconstant least-positive-normalized-single-float (make-short-float-from-fixnums 1 1 0))
(defconstant least-negative-normalized-single-float (make-short-float-from-fixnums 1 1 -1))

(let ((bigfloat (make-float-from-fixnums #x1ffffff #xfffffff #x7fe 0)))
  ; do it this way if you want to be able to compile before reading floats works  
  (defconstant most-positive-double-float bigfloat)
  (defconstant most-positive-long-float bigfloat)
  ;(defconstant most-positive-single-float bigfloat)
  )

(let ((littleposfloat (make-float-from-fixnums 0 1 0 0 )))
  (defconstant least-positive-double-float littleposfloat)
  (defconstant least-positive-long-float littleposfloat)
  ;(defconstant least-positive-single-float littleposfloat)
  )

(let ((littlenegfloat (make-float-from-fixnums 0 1 0 -1)))  
  (defconstant least-negative-double-float littlenegfloat)
  (defconstant least-negative-long-float littlenegfloat)
  ;(defconstant least-negative-single-float littlenegfloat)
  )

(let ((bignegfloat (make-float-from-fixnums #x1ffffff #xfffffff #x7fe -1)))
  (defconstant most-negative-double-float bignegfloat)
  (defconstant most-negative-long-float bignegfloat)
  ;(defconstant most-negative-single-float bignegfloat)
  )

(let ((eps (make-float-from-fixnums #x1000000 1 #x3ca 0))) ;was wrong
  (defconstant double-float-epsilon eps)
  (defconstant long-float-epsilon eps)
  ;(defconstant single-float-epsilon eps)
  )

(let ((eps- (make-float-from-fixnums #x1000000 1 #x3c9 1)))
  (defconstant double-float-negative-epsilon eps-)
  (defconstant long-float-negative-epsilon eps-)
  ;(defconstant single-float-negative-epsilon eps-)
  )

(let ((norm (make-float-from-fixnums 0 0 1 0)))
  (defconstant least-positive-normalized-double-float norm)
  (defconstant least-positive-normalized-long-float norm)
  ;(defconstant least-positive-normalized-single-float norm)
  )

(let ((norm- (make-float-from-fixnums 0 0 1 -1)))
  (defconstant least-negative-normalized-double-float norm-)
  (defconstant least-negative-normalized-long-float norm-)
  ;(defconstant least-negative-normalized-single-float norm-)
  )

(defconstant pi (make-float-from-fixnums #x921fb5 #x4442d18 #x400 0))

)

(defun error (condition &rest args) ;; temp
  (declare (ignore args))
  (bug "Error during cold load.  DBG trap follows.")
  (dbg condition))


#-ppc-target ; cross-compiling problems
(progn

(let ((bigfloat (old-lap-inline ()
                  (move.l ($ #x7fef #xffff) arg_y)
                  (move.l ($ -1) arg_z)
                  (jsr_subprim $sp-makefloat))))
(defconstant most-positive-double-float bigfloat)
(defconstant most-positive-long-float bigfloat)
(defconstant most-positive-single-float bigfloat))

(defconstant most-positive-short-float (lap-inline ()
                                         (move.l ($ (+ (ash #x8f 23)
                                                       (1- (ash 1 23)))) acc)
                                         (rol.l ($ 4) acc)
                                         (add.b ($ (- $t_sfloat 4)) acc)))

(let ((littleposfloat (old-lap-inline ()
                        (move.l ($ 0) arg_y)
                        (move.l ($ 1) arg_z)
                        (jsr_subprim $sp-makefloat))))
(defconstant least-positive-double-float littleposfloat)
(defconstant least-positive-long-float littleposfloat)
(defconstant least-positive-single-float littleposfloat))

(defconstant least-positive-short-float (lap-inline (0.0s0)
                                          (add.b ($ (ash 1 4)) acc)))
(defconstant least-positive-normalized-short-float least-positive-short-float)

(let ((littlenegfloat (old-lap-inline ()
                        (move.l ($ #x8000 0) arg_y)
                        (move.l ($ 1) arg_z)
                        (jsr_subprim $sp-makefloat))))
(defconstant least-negative-double-float littlenegfloat)
(defconstant least-negative-long-float littlenegfloat)
(defconstant least-negative-single-float littlenegfloat))

(defconstant least-negative-short-float (lap-inline (-0.0s0)
                                          (add.b ($ (ash 1 4)) acc)))
(defconstant least-negative-normalized-short-float least-negative-short-float)

(let ((bignegfloat (old-lap-inline ()
                     (move.l ($ #xffef #xffff) arg_y)
                     (move.l ($ -1) arg_z)
                     (jsr_subprim $sp-makefloat))))
(defconstant most-negative-double-float bignegfloat)
(defconstant most-negative-long-float bignegfloat)
(defconstant most-negative-single-float bignegfloat))

(defconstant most-negative-short-float (lap-inline ()
                                         (move.l ($ (+ (ash #x18f 23)
                                                       (1- (ash 1 23)))) acc)
                                         (rol.l ($ 4) acc)
                                         (add.b ($ (- $t_sfloat 4)) acc)))

(let ((eps (old-lap-inline ()
             (move.l ($ #x3ca0 #x0) arg_y)
             (move.l ($ 1) arg_z)
             (jsr_subprim $sp-makefloat))))
(defconstant double-float-epsilon eps)
(defconstant long-float-epsilon eps)
(defconstant single-float-epsilon eps))

(let ((eps- (old-lap-inline ()
              (move.l ($ #x3c90 #x0) arg_y)
              (move.l ($ 1) arg_z)
              (jsr_subprim $sp-makefloat))))
(defconstant double-float-negative-epsilon eps-)
(defconstant long-float-negative-epsilon eps-)
(defconstant single-float-negative-epsilon eps-))

;the best one can do
(defconstant short-float-epsilon least-positive-short-float)
; ditto
(defconstant short-float-negative-epsilon least-positive-short-float)



(let ((norm (old-lap-inline ()
              (move.l ($ #x0010 #x0000) arg_y)
              (move.l ($ 0) arg_z)
              (jsr_subprim $sp-makefloat))))
  (defconstant least-positive-normalized-double-float norm)
  (defconstant least-positive-normalized-long-float norm)
  (defconstant least-positive-normalized-single-float norm))

(let ((norm- (old-lap-inline ()
              (move.l ($ #x8010 #x0000) arg_y)
              (move.l ($ 0) arg_z)
              (jsr_subprim $sp-makefloat))))
  (defconstant least-negative-normalized-double-float norm-)
  (defconstant least-negative-normalized-long-float norm-)
  (defconstant least-negative-normalized-single-float norm-))

(defconstant pi (old-lap-inline ()
                  (move.l ($ #x4009 #x21fb) arg_y)
                  (move.l ($ #x5444 #x2d18) arg_z)
                  (jsr_subprim $sp-makefloat)))

) ; #-ppc-target


(defun string (thing)
  (if (stringp thing)
    thing
    (if (symbolp thing)
      (symbol-name thing)
      (if (characterp thing)
        (make-string 1 
                     :element-type (if (typep thing 'base-character) 'base-character 'character)
                     :initial-element thing)
        (report-bad-arg thing '(or string symbol character))))))

(defconstant boole-clr 0)
(defconstant boole-set 1)
(defconstant boole-1 2)
(defconstant boole-2 3)
(defconstant boole-c1 4)
(defconstant boole-c2 5)
(defconstant boole-and 6)
(defconstant boole-ior 7)
(defconstant boole-xor 8)
(defconstant boole-eqv 9)
(defconstant boole-nand 10)
(defconstant boole-nor 11)
(defconstant boole-andc1 12)
(defconstant boole-andc2 13)
(defconstant boole-orc1 14)
(defconstant boole-orc2 15)



(defconstant internal-time-units-per-second 1000)

(defconstant char-code-limit #x10000)  ;; or #x10000 ?

(defconstant array-rank-limit #x2000)
(defconstant multiple-values-limit 200)
(defconstant lambda-parameters-limit #x2000)
(defconstant call-arguments-limit #x2000)

; Currently, vectors can be at most (expt 2 22) bytes, and
; the largest element (double-float or long-float) is 8 bytes:
#| to get largest element size...
(apply #'max (mapcar #'(lambda (type)
                         (%vect-byte-size (make-array 1 :element-type type)))
                     *cl-types*))
|#

(defconstant array-dimension-limit array-total-size-limit)

#+ppc-clos
(progn
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun hide-lsh (a b) ; so the compiler won't constant fold at compile time
    (lsh a b)))

(defconstant most-positive-fixnum (load-time-value (hide-lsh -1 -1)))
(defconstant most-negative-fixnum (load-time-value (1- (- (hide-lsh -1 -1)))))
)

#-ppc-clos
(progn
(defconstant most-positive-fixnum #.(lsh -1 -1))
(defconstant most-negative-fixnum (ash -1 (- 31 $fixnumshift)))
)

#| ; argh its reffed in level-0 before defined  here
; revert to constant when not cross compiling - if constant when cross compiling
; the wrong val will be used within ppc code
(eval-when (:compile-toplevel :load-toplevel :execute) 
  (makunbound 'most-positive-fixnum)
  (makunbound 'most-negative-fixnum)
  (defvar most-positive-fixnum (load-time-value (lsh -1 -1)))
  (defvar most-negative-fixnum (load-time-value (1- (- (lsh -1 -1))))))
|#

; single-float ought to be ok if only one format but not sure it will work today
;(defvar *read-default-float-format* 'double-float)

(defconstant lambda-list-keywords 
  '(&OPTIONAL &REST &AUX &KEY &ALLOW-OTHER-KEYS &BODY &ENVIRONMENT &WHOLE))




#-ppc-target
(defparameter %unbound-function%         ;Initialized by kernel.
  (old-lap-inline () (move.l (special %unbound-function%) acc)))

(defparameter %toplevel-catch% ':toplevel)

(defvar *read-default-float-format* 'single-float)

(defvar *read-suppress* nil)

(defvar *read-base* 10.)


(defvar %doc-string-file ())
(defvar *fast-help* t)
(defglobal *idle* nil)
(defparameter *foreground* t)
(defparameter *warn-if-redefine-kernel* nil)
(defvar *next-screen-context-lines* 2 "Number of lines to show of old screen
  after a scroll-up or scroll-down.")

(defparameter *compiling-file* nil 
  "Name of outermost file being compiled or NIL if not compiling a file.")

(defvar *eval-fn-name* nil)


(defvar *compile-definitions* t
  "When non-NIL and the evaluator's lexical environment contains no
  lexical entities, causes FUNCTION and NFUNCTION forms to be compiled.")
#|
(defvar *fast-eval* ()
  "If non-nil, compile-and-call any forms which would be expensive to evaluate.")
|#
(defparameter *save-arglist-info* nil)
(defvar *declaration-handlers* ())

(defvar *eval-macro-displacement* nil)

(defvar *cursorhook* nil)
;(defvar *scrap-ok* t)
(defvar *scrap-count* -1)
(defvar *current-view* nil)
(defvar *current-font-view* nil)

(defglobal *selected-window* nil)
(defglobal *modal-dialog-on-top* nil)

(defvar *lisp-system-pointer-functions* nil)
(defvar *lisp-user-pointer-functions* nil)
(defvar *lisp-cleanup-functions* nil)   ; list of (0-arg) functions to call before quitting Lisp
(defvar *lisp-startup-functions* nil)   ; list of funs to call after startup.
(defvar %lisp-system-fixups% nil)


(setf (*%saved-method-var%*) nil)

; The GC expects these to be NIL or a function of no args
(defvar *pre-gc-hook* nil)
(defvar *post-gc-hook* nil)

; These are used by add-gc-hook, delete-gc-hook
(defvar *pre-gc-hook-list* nil)
(defvar *post-gc-hook-list* nil)

(defvar *backtrace-dialogs* nil)
;(defvar *stepper-running* nil)
(defparameter *last-mouse-down-time* 0)
(defparameter *last-mouse-down-position* 0)

(defvar %handlers% ())

;;;;;;;;;;;; macho stuff

;; moved here from ppc-callback-support
(defppclapfunction %fixnum-from-macptr ((macptr arg_z))
  (check-nargs 1)
  (trap-unless-typecode= arg_z ppc::subtag-macptr)
  (lwz imm0 ppc::macptr.address arg_z)
  (trap-unless-fixnum imm0 imm1)
  (mr arg_z imm0)
  (blr))

;; from l1-aprims
(defun %cstr-pointer (string pointer &optional script)
  (if (base-string-p string)
    (multiple-value-bind (s o n) (dereference-base-string string)
      (declare (fixnum o n))
      (do* ((o o (1+ o))
            (i 0 (1+ i)))
           ((= i n) (setf (%get-byte pointer i) 0))
        (declare (fixnum o i))
        (setf (%get-byte pointer i) (%scharcode s o))))
    (%put-cstring pointer string 0 nil script))
  nil)

(defun simple-string= (str1 str2)
  (%simple-string= str1 str2 0 0 (length str1)(length str2)))

(defun macho-address (entry-point &optional nil-if-not-found)
  (declare (optimize (speed 3)(safety 0)))
  (or (macho.address entry-point)
      (resolve-macho-entry-point entry-point)
      (if nil-if-not-found
        nil
        (error "Couldn't find address for ~S" (macho.name entry-point)))))

#+ignore
(defmacro macho-address-macro (entry-point)
  `(or (macho.address ,entry-point)
       (macho-address ,entry-point)))


#| ;; save a few instructions if anybody cares - and of course ppclap will be history
(defppclapfunction macho-address2 ((ep arg_z))
  (LWZ temp3 (+ ppc::misc-data-offset  4) arg_z)  ;; 2
  (CMPW temp3 RNIL)
  (beq harder)
  (mr arg_z temp3)
  (blr)
harder
  (lwz temp3 'macho-address fn)
  (ba .spjmpsym))
 
|#

(defun resolve-macho-entry-point (macho-ep)  
  (let ((framework-name (macho.framework macho-ep))
        (symbol-name (macho.name macho-ep))
        (address nil))
    (or (and framework-name 
             (let ((bundle (get-bundle-for-framework-name framework-name)))
               (and bundle 
                    (setq address (lookup-function-in-bundle symbol-name bundle t)))))
        (dolist (bundle-thing (all-bundles) nil)
          (let ((bundle (or (car bundle-thing)
                            (get-bundle-for-framework-name (cdr bundle-thing) bundle-thing))))
            (when bundle
              (setq address (lookup-function-in-bundle symbol-name bundle t))
              (when address 
                (setf (macho.framework macho-ep) (cdr bundle-thing))
                (return))))))
    (setf (macho.address macho-ep) address)
    address))

(defun get-bundle-for-framework-name (framework-name &optional (bundle-thing (rassoc framework-name (all-bundles) :test  #'simple-string=)))
  (when bundle-thing
    (or (car bundle-thing)
        (let ((bundle (load-framework-bundle framework-name)))
          (rplaca bundle-thing bundle)
          bundle))))

#|
;; ?? maybe unload a bundle when loading it served no purpose

(defun resolve-macho-entry-point (macho-ep)  
  (let ((framework-name (macho.framework macho-ep))
        (symbol-name (macho.name macho-ep))
        (address nil))
    (or (and framework-name 
             (let* ((bundle-thing (rassoc framework-name (all-bundles) :test  #'simple-string=))
                    (loaded-p (car bundle-thing))
                    (bundle (or loaded-p (get-bundle-for-framework-name framework-name bundle-thing))))
               (when bundle 
                 (setq address (lookup-function-in-bundle symbol-name bundle t))
                 (when (not address)  ;; if not found forget the framework hint
                   (setf (macho.framework macho-ep) nil)
                   (when (not loaded-p)  ;; unload it if not previously loaded - and loading it served no purpose?
                     (unload-bundle bundle))))
               address))
        (dolist (bundle-thing (all-bundles) nil)
          (let* ((loaded-p (car bundle-thing))
                 (bundle (or loaded-p
                            (get-bundle-for-framework-name (cdr bundle-thing) bundle-thing))))
            (when bundle
              (setq address (lookup-function-in-bundle symbol-name bundle t))
              (when (and (not address)(not loaded-p))(unload-bundle bundle))
              (when address 
                (setf (macho.framework macho-ep) (cdr bundle-thing))
                (return))))))
    (setf (macho.address macho-ep) address)
    address))

(defun unload-bundle (bundle)
  (without-interrupts
   (let ((thing (assoc (all-bundles) bundle)))
     (when thing
       (rplaca thing nil))
     (#_CFBundleUnloadExecutable bundle))))
|#




(compiler-let ((*dont-use-cfm* nil))  ;; bootstrapping


#|
;; only works for 7bit-ascii
(defun CFSTR (string)
  (with-cstrs ((cstr string))
    (ppc-ff-call (%kernel-import ppc::kernel-import-__CFStringMakeConstantString)
                       :address cstr 
                       :address)))
|#


#|
(defun create-cfstring-simple (string)
  (with-cstrs ((cstr string))
    (#_CFStringCreateWithCString (%null-ptr) cstr #$kCFStringEncodingISOLatin1)))
|#

;; this works
(defun create-cfstring-simple (string)
  (with-cstrs ((cstr string))
    ;(#_CFStringCreateWithCString (%null-ptr) cstr #$kCFStringEncodingISOLatin1)                 
    (ppc-ff-call (%kernel-import ppc::kernel-import-CFStringCreateWithCString)
                 :address (%null-ptr)
                 :address cstr
                 :unsigned-fullword #$kCFStringEncodingISOLatin1
                 :address)))

(defun cfrelease-boot (ptr)
  (ppc-ff-call (%kernel-import ppc::kernel-import-CFRelease)
               :address ptr
               :void))

  
;; formerly known as lookup-function-in-framework
(defun lookup-function-in-bundle (symbol-name bundle &optional nil-if-not-found)
  (with-macptrs ((cfname (create-cfstring-simple symbol-name)))
    (unwind-protect
      (with-macptrs ((addr (#_CFBundleGetFunctionPointerForName bundle cfname))) ;; ppc-ff-call here fails
        (if (%null-ptr-p addr)
          (if nil-if-not-found
            nil
            (error "Couldn't resolve address of foreign function ~s" symbol-name))
          ;; This may be a little confusing: MCL uses fixnums (whose low 2 bits are
          ;; zero) to represent function addresses (whose low 2 bits are zero ...)         
          (%fixnum-from-macptr addr)))          
      ;(#_CFRelease cfname)
      (cfrelease-boot cfname)  ;; OK
      )))

#|
(defun lookup-function-in-bundleBAD (symbol-name bundle &optional nil-if-not-found)
  (with-macptrs ((cfname (create-cfstring-simple symbol-name)))
    (unwind-protect
      (with-macptrs ((addr ;(#_CFBundleGetFunctionPointerForName bundle cfname)
                           (ppc-ff-call (%kernel-import ppc::kernel-import-CFBundleGetFunctionPointerForName)
                                        :address bundle
                                        :address cfname
                                        :address)
                           )) ;; ppc-ff-call here fails
        (if (%null-ptr-p addr)
          (if nil-if-not-found
            nil
            (error "Couldn't resolve address of foreign function ~s" symbol-name))
          ;; This may be a little confusing: MCL uses fixnums (whose low 2 bits are
          ;; zero) to represent function addresses (whose low 2 bits are zero ...)
          (%fixnum-from-macptr addr)
          #+ignore
          (rlet ((buf :long))
            (setf (%get-ptr buf) addr)
            (ash (%get-signed-long buf) -2))))
      ;(#_CFRelease cfname)
      (cfrelease-boot cfname)  ;; OK
      )))
|#


#|
(defun create-frameworks-url ()
  (rlet ((fsref :fsref))
    (let* ((err (#_FSFindFolder #$kOnAppropriateDisk #$kFrameworksFolderType t fsref)))
      (if (eq #$noErr err)
        (let* ((url (#_CFURLCreateFromFSRef (%null-ptr) fsref)))
          (if (%null-ptr-p url)
            (error "Failed to create URL")
            url))
        (error "Couldn't find system Frameworks folder")))))
|#

;; this works
(defun create-frameworks-url ()
  (rlet ((fsref :fsref))
    (let* ((err ;(#_FSFindFolder #$kOnAppropriateDisk #$kFrameworksFolderType t fsref)
                (ppc-ff-call (%kernel-import ppc::kernel-import-FSFindFolder)
                              :signed-halfword #$kOnAppropriateDisk
                              :unsigned-fullword #$kFrameworksFolderType
                              :signed-byte 1
                              :address fsref
                              :signed-halfword
                              )))
      (if (eq #$noErr err)
        (let* ((url ;(#_CFURLCreateFromFSRef (%null-ptr) fsref)
                    (ppc-ff-call (%kernel-import ppc::kernel-import-CFURLCreateFromFSRef)
                                 :address (%null-ptr)
                                 :address fsref
                                 :address)
                    ))
          (if (%null-ptr-p url)
            (error "Failed to create URL")
            url))
        (error "Couldn't find system Frameworks folder")))))

(defvar *frameworks-url* nil)

(defun frameworks-url ()
  (or *frameworks-url*
      (setq *frameworks-url* (create-frameworks-url))))

;; redefined later
(defun load-framework-bundle (framework-name)
  (load-framework-bundle-simple framework-name (frameworks-url)))

(defun load-framework-bundle-simple (framework-name frameworks-url)
  (with-macptrs ((cfname (create-cfstring-simple framework-name)))
    (with-macptrs ((bundle-url #+ignore
                               (#_CFURLCreateCopyAppendingPathComponent
                                (%null-ptr)
                                frameworks-url   ; file:///System/Library/Frameworks/
                                cfname
                                nil)
                               (ppc-ff-call (%kernel-import ppc::kernel-import-CFURLCreateCopyAppendingPathComponent)  ;; OK
                                            :address (%null-ptr)
                                            :address frameworks-url
                                            :address cfname
                                            :signed-byte 0  ;; ??
                                            :address)
                               ))
      (if (%null-ptr-p bundle-url)
        (error "Can't create URL for ~s in provided frameworks folder" 
               framework-name)
        (let* ((bundle ;(#_CFBundleCreate (%null-ptr) bundle-url)  ;; this works
                       (ppc-ff-call (%kernel-import ppc::kernel-import-CFBundleCreate)
                                    :address (%null-ptr)
                                    :address bundle-url
                                    :address)
                       ))
          ;(#_cfrelease bundle-url) ;; ??  
          (cfrelease-boot bundle-url)
          ;(#_cfrelease cfname)
          (cfrelease-boot cfname)
          (if (%null-ptr-p bundle)
            (error "Can't create bundle for ~s" framework-name)
            (if ;(null (#_CFBundleLoadExecutable bundle)
                  (eq 0  (ppc-ff-call (%kernel-import ppc::kernel-import-CFBundleLoadExecutable)  ;; OK
                                   :address bundle
                                   :signed-byte))              
              (error "Couldn't load bundle for ~s" framework-name)
               bundle)))))))

(defvar *system-framework-bundle* nil)

;;; Most BSD/Mach functions are in the System framework.
(defun system-framework-bundle ()
  (or *system-framework-bundle*
      (setq *system-framework-bundle*
            (cons nil "System.framework"))))

(defvar *application-services-bundle* nil)
(defun application-services-bundle ()
  (or *application-services-bundle*
      (setq *application-services-bundle*
            (cons nil "ApplicationServices.framework"))))

(defvar *agl-framework-bundle* nil)
(defun agl-framework-bundle ()
  (or *agl-framework-bundle*
      (setq *agl-framework-bundle*
            (cons nil "AGL.framework"))))

(defvar *carbon-framework-bundle* nil)

(defun carbon-framework-bundle ()
  (or *carbon-framework-bundle*
      (setq *carbon-framework-bundle*
            (cons (load-framework-bundle "Carbon.framework")
                  "Carbon.framework"))))


;; well there are actually something like 58 or 92 frameworks
(defvar *bundles* nil)
(defun all-bundles ()
  (or *bundles*
      (setq *bundles*
            (list (carbon-framework-bundle)
                  (agl-framework-bundle)
                  (system-framework-bundle)
                  (application-services-bundle)                  
                  #+ignore
                  (with-macptrs ((id (create-cfstring-simple "com.apple.CoreGraphics")))  ;with-cfstrs ((id "com.apple.CoreGraphics"))  ;; i think all these are in all of the above? 
                    (let* ((bundle (#_CFBundleGetBundleWithIdentifier id)))
                      (cons bundle "com.apple.CoreGraphics")))))))

)  ;; END COMPILER-LET


(defun initialize-bundles ()  ;; called by restore-lisp-pointers BEFORE restore-pascal-functions and lisp-system-pointer-functions
  (setq *frameworks-url* nil)
  (dolist (x (all-bundles))
    (rplaca x nil)))

;; for users
#| ;; moved to deftrap.lisp
;; (export 'add-framework-bundle :ccl)  - too soon ?? l1-init precedes def of export in l1-symhash
(defun add-framework-bundle (framework-name)  ;; e.g. "AGL.framework"
  (when (not (member framework-name *bundles* :test #'(lambda (x y) (equal x (cdr y)))))  ;; was string-equal
    (setq *bundles*
          (append *bundles*
                  (list (cons nil framework-name))))))
|#

 
;;;;;; end macho stuff



#|
(defvar %restarts% (list (list (%cons-restart 'abort
                                              #'(lambda (&rest ignore)
                                                  (declare (ignore ignore))
                                                  (throw :toplevel nil))
                                              "Restart the toplevel loop."
                                              nil
                                              nil))))
|#

(defvar %restarts% nil)

(defvar ccl::*kernel-restarts* nil)
(defvar *condition-restarts* nil "explicit mapping between c & r")
(declaim (type list %handlers% %restarts% ccl::*kernel-restarts* *condition-restarts*))

;; this is silly - alist or something - still used by quickdraw.lisp
(defparameter *pen-modes*
 '(:srcCopy :srcOr :srcXor :srcBic :notSrcCopy :notSrcOr :notsrcXor :notsrcBic 
   :patCopy :patOr :patXor :patBic :notPatCopy :notPatOr :notPatXor :notPatBic))


;; actually both pen and text modes
(defparameter *pen-modes-alist*
  `((:srcCopy . #.#$srccopy) 
    (:srcOr . #.#$srcor)
    (:srcXor . #.#$srcxor)
    (:srcBic . #.#$srcbic)
    (:notSrcCopy . #.#$notSrcCopy)
    (:notSrcOr . #.#$notSrcOr)
    (:notsrcXor . #.#$notsrcXor)
    (:notsrcBic . #.#$notsrcBic) 
    (:patCopy . #.#$patCopy)
    (:patOr . #.#$pator)
    (:patXor . #.#$patxor)
    (:patBic . #.#$patbic)
    (:notPatCopy . #.#$notpatcopy)
    (:notPatOr . #.#$notpator)
    (:notPatXor . #.#$notpatxor)
    (:notPatBic . #.#$notPatBic)
    (:blend . #.#$blend)
    (:addpin . #.#$addpin)
    (:addover . #.#$addover)
    (:subpin . #.#$subpin)
    (:transparent . #.#$transparent)
    (:addmax . #.#$addmax)
    (:subover . #.#$subover)
    (:admin . #.#$admin)
    (:grayishTextOr . #.#$grayishTextOr)
    (:hilite . #.#$hilite)
    (:dithercopy . #.#$dithercopy)))

(defun xfer-mode-arg (name &optional error-p)
  (or (cdr (assq name *pen-modes-alist*))
      (when error-p (error "Unknown transfer mode ~s" name))))

(defun xfer-mode-to-name (mode)
  (or 
   (dolist (x *pen-modes-alist*)
     (if (eq mode (%cdr x))(return (%car x))))
   (error "Unknown transfer mode value ~s" mode)))

   

  

(defvar *arrow-cursor* nil)
(defvar *i-beam-cursor* nil)
(defvar *watch-cursor* :watch-cursor)
(defvar *white-pattern* nil)
(defvar *black-pattern* nil)
(defvar *gray-pattern* nil)
(defvar *light-gray-pattern* nil)
(defvar *dark-gray-pattern* nil)

; Temporary regions for short-time use
(defvar *temp-rgn* nil)
(defvar *temp-rgn-2* nil)
(defvar *temp-rgn-3* nil)  ;; for carbon goo

; And a permanently empty region.
(defvar *empty-rgn* nil)

; A temporary region for use as the clip-region of simple-view's
(defvar *simple-view-clip-region* nil)

(defvar *current-cursor* nil)


(def-ccl-pointers init-1 ()
  #+carbon-compat  
  (progn
    (let ((pat-len (record-length :pattern))
          (curs-len (record-length :cursor)))
      (setq *white-pattern* (#_newptr pat-len)) ;; make-record of :pattern makes a handle - sigh
      (setq *black-pattern* (#_newptr pat-len))
      (setq *gray-pattern* (#_newptr pat-len))
      (setq *light-gray-pattern* (#_newptr pat-len))
      (setq *dark-gray-pattern* (#_newptr pat-len))
      (setq *arrow-cursor* (#_newptr curs-len))))
  (setq *i-beam-cursor* (#_GetCursor #$ibeamcursor))  ;; faster than using :i-beam-cursor
  ;(setq *watch-cursor* (#_GetCursor #$watchcursor))
  (setq *temp-rgn* (#_NewRgn))
  (setq *temp-rgn-2* (#_NewRgn))
  (setq *temp-rgn-3* (#_NewRgn))
  (setq *empty-rgn* (#_NewRgn))
  (setq *simple-view-clip-region* (#_NewRgn)))
  
  
  

(def-ccl-pointers qd () 
  ;; something busted here - we get mess for patterns and arrowcursor - OK now, ptr vs handle
  (progn    
    (#_getqdglobalswhite *white-pattern*)    
    (#_getqdglobalsblack *black-pattern*)    
    (#_getqdglobalsgray *gray-pattern*)    
    (#_getqdglobalslightgray *light-gray-pattern*)  ;; unused    
    (#_getqdglobalsdarkgray *dark-gray-pattern*)    ;; unused
    (#_getqdglobalsarrow *arrow-cursor*))
  (setq *current-cursor* (%inc-ptr *arrow-cursor* 0))
  )
  

; These are initialized in color.lisp
; Needed here because l1-windows uses them.
(defvar *color-available* nil)
(defvar *black-color* 0)
(defvar *white-color* 16777215)

(defglobal *eventhook* '())
(defglobal *event-processing-loop-tag* nil)
(defparameter *menubar-frozen* nil)
(defparameter *dribble-stream* nil)
(defparameter *verbose-eval-selection* nil)
(defparameter *%periodic-tasks%* nil)

(defconstant *keyword-package* *keyword-package*)
(defconstant *common-lisp-package* *common-lisp-package*)
(defconstant *ccl-package* *ccl-package*)


(defparameter *load-print* nil)
(defparameter *loading-files* nil)
(defvar *loading-file-source-file* nil)
(defparameter *break-level* 0)
(defparameter *last-break-level* 0)
(defvar *record-source-file* nil)       ; set in l1-utils.
(defvar *warn-if-redefine* nil)         ; set in l1-utils.
(defparameter *level-1-loaded* nil)     ; set t by l1-boot
(defparameter *save-definitions* nil)
(defparameter *save-local-symbols* nil)

(defvar *modules* nil
  "Holds list of names of modules that have been loaded thus far.
   The names are case sensitive strings.")
(defvar *module-file-alist* nil
  "Holds an alist of modules and associated pathnames known to the system.")

;A key event is a candidate for _MenuKey iff
; (eql (logand *menukey-modifier-mask* modifiers) *menukey-modifier-value*)
;Mac-mode defaults:
(defparameter *menukey-modifier-mask* #x300)  ;Only cmd and shift keys matter
(defparameter *menukey-modifier-value* #x100) ;cmd must be on, shift key off.

;event system vars
(declaim (special *current-event*))

(defparameter *style-alist* 
  '((:plain . 0)(:bold . 1)(:italic . 2)(:underline . 4)
    (:outline . 8)(:shadow . 16)(:condense . 32)(:extend . 64)))
(defparameter *eof-value* (cons nil nil))
(defvar *interrupt-level*)  ;Initialized by kernel.
(defvar *gc-event-status-bits*)         ; also initialized by kernel

(defparameter *top-listener* nil)

(defvar *main-listener-process-name* "Listener")

(defvar *open-file-streams* nil)

; Note: all the stream definitions have moved to l1-streams:
; *terminal-io*, *standard-input*, *standard-output*, *pop-up-terminal-io*,
; *error-output*, *trace-output*
;
; All the window definitions are in l1-windows & l1-edwin

(defparameter *screen-width* 0)
(defparameter *screen-height* 0)
(defparameter *screen-size* 0)
(defparameter *pixels-per-inch-x* 72) ; usually 72
(defparameter *pixels-per-inch-y* 72) ; usually 72
(defparameter *menubar-bottom* 38) ;the location of the line under the menu bar.

; here are the default window sizes & zoom positions
(defparameter *window-default-position* #@(10 44))  ;; was 6 44
(defparameter *window-default-size* #@(502 188))
(defparameter *window-default-zoom-position* #@(6 44)) ; these are filled in by the
(defparameter *window-default-zoom-size* #@(502 150))  ; def-load-pointers in l1-windows


;These are as defined by fry... Might want to change it?
 (defparameter *fred-help-window-size&pos* (list #@(370 282)))

#|
(defun get-current-screen-size ()
  (let ((wm (#_LMGetWMgrPort)))
    (setq *screen-width*
          (%i- (rref wm grafport.portbits.bounds.right)
               (rref wm grafport.portbits.bounds.left)))
    (setq *screen-height*
          (%i- (rref wm grafport.portbits.bounds.bottom)
               (rref wm grafport.portbits.bounds.top)))
    (setq *screen-size* (make-point *screen-width* *screen-height*))
    (values *screen-size* *screen-width* *screen-height*)))
|#


;(export '(bbox-p osx-p)) ;; later - bootstrapping


(defvar *osx-p* nil)
(defvar *jaguar-growl-p* nil)
(defvar *system-version* 0)

(def-ccl-pointers osx-pp ()
  (rlet ((res :longint))
    (#_Gestalt "sysv" res)
    (let ((sysv (%get-long res)))
      ;; oh gaak it's bcd
      ;(setq *osx-p* (if (>= sysv #x1000) t nil))
      (setq *jaguar-growl-p* (if (>= sysv #x1020) t nil))
      (setq *system-version* sysv)
      )))

;(defun osx-p () *osx-p*)
(defun jaguar-p () *jaguar-growl-p*)
(defun system-version () *system-version*)

(defvar *bbox-p* nil)

(def-ccl-pointers bbox-pp1 ()
  (rlet ((res :longint))
    (if (eql 0 (#_Gestalt "bbox" res))
      (let ((bbox (%get-long res)))
        (setq *bbox-p* (logbitp #$gestaltMacOSCompatibilityBoxPresent bbox)))
      (setq *bbox-p* nil))))



(progn
  (defun check-carbonlib-version ()
    #+ignore
    (when (not (osx-p))
      (rlet ((res :longint))
        (if (eql 0 (#_gestalt "cbon" res))
          (let ((cv (%get-long res)))
            (when (not (>= cv #x140))
              (warn "This version of MCL requires CarbonLib 1.4 or later"))))))
    (when t ;(osx-p)
      (let ((preferred (preferred-size-from-size-resource))
            (total (total-heap-allocated)))
        (when (< total preferred)
          (warn "Requested ~D bytes of heap. Max is ~D bytes." preferred total)))))
  ;(pushnew 'check-carbonlib-version *lisp-startup-functions*)
  )

(defun bbox-p () *bbox-p*)  

(defun screen-position (screen)
  (href screen :GDevice.gdRect.topleft))

(defun screen-size (screen)
  (subtract-points
   (href screen :GDevice.gdRect.bottomright)
   (screen-position screen)))

(defun get-current-screen-size ()
  #+Carbon-compat
  ;; this really isn't the same if multiple screens ?? Actually width and height are documented to be the main screen!  
  (let ((s (#_GetMainDevice)))
    (setq *screen-gdevice* s)
    (setq *screen-size* (screen-size s))
    (setq *screen-width* (point-h *screen-size*))
    (setq *screen-height* (point-v *screen-size*))
    (values *screen-size* *screen-width* *screen-height* (screen-position s)))
  #-carbon-compat
  (let ((wm (#_LMGetWMgrPort)))
    (setq *screen-width*
          (%i- (rref wm grafport.portbits.bounds.right)
               (rref wm grafport.portbits.bounds.left)))
    (setq *screen-height*
          (%i- (rref wm grafport.portbits.bounds.bottom)
               (rref wm grafport.portbits.bounds.top)))
    (setq *screen-size* (make-point *screen-width* *screen-height*))
    (values *screen-size* *screen-width* *screen-height* 
            (make-point (rref wm grafport.portbits.bounds.left)
                        (rref wm grafport.portbits.bounds.top)))))

  
(def-ccl-pointers screen-size ()
  (if t ;(osx-p)
    ;; should work for non osx-p as well
    (multiple-value-setq (*pixels-per-inch-x* *pixels-per-inch-y*)
      (with-macptrs ((s (#_getmaindevice)))
        (let ((pmap (href s :gdevice.gdpmap)))
          ;; what are the low bits?
          (values (ash (href pmap :pixmap.hres) -16)
                  (ash (href pmap :pixmap.vres) -16)))))
    (progn 
      ;; hres/vres ret -1 on osx
      (setq *pixels-per-inch-x* (#_LMGetScrHRes))
      (setq *pixels-per-inch-y* (#_LMGetScrVRes))))
  (setq *menubar-bottom* (+ (#_GetMBarHeight) 18))  ;; wtf is this for
  (let ((position (nth-value 3 (get-current-screen-size))))
    (setq *window-default-zoom-position* ;; these aren't used but are documented ??
          (add-points #@(3 41) position))
    (setq *window-default-zoom-size*
          (subtract-points *screen-size* #@(6 44))))
  ;(setq *screen-size* (make-point *screen-width* *screen-height*))
  #+carbon-compat22 (make-screen-window)
  (rplacd  *fred-help-window-size&pos*
        (subtract-points (subtract-points *screen-size* #@(15 15))
                         (car *fred-help-window-size&pos*))))



(defparameter *fred-keystroke-hook* nil)
(defparameter *fred-default-font-spec* '("monaco" 9 :plain))
(defparameter *mini-buffer-font-spec* '("monaco" 9 :plain))
(defparameter *listener-default-font-spec* *fred-default-font-spec*)
(defparameter *save-fred-window-positions* t)
(defparameter *paste-with-styles* t)

(defparameter *arglist-on-space* nil)
(defparameter *mini-buffer-help-output* t)

#| ; let lib;arglist set it if loaded
(queue-fixup 
 (setq *arglist-on-space* t))
|#

(defparameter *autoload-traps* t)

(defvar *inspector-disassembly* nil)

(defvar *listener-window-position* #@(6 256))
(defvar *listener-window-size*  #@(502 118))
(defvar *listener-indent* nil)

(defparameter *window-object-alist* nil)

; PBs for file io.
#| No longer used
(defvar *write-pb-1* nil)
(defvar *write-pb-2* nil)

(def-ccl-pointers file-pbs ()
  (setq *write-pb-1* (#_NewPtr :clear $ioQelSiZe))
  (setq *write-pb-2* (#_NewPtr :clear $ioQelSiZe)))
|#


(defparameter *autoload-lisp-package* nil)   ; Make 'em suffer
(defparameter *apropos-case-sensitive-p* nil)

#+ppc-target
(progn
(defloadvar *total-gc-microseconds* (#_NewPtrClear (* 5 8)))
(defloadvar *total-bytes-freed* (make-record (:unsignedwide :clear t)))
)

(defvar *black-rgb*)
(defvar *white-rgb*)


(defvar *is-normalized* nil)




; MCL-Appgen build constants...
(defconstant *genapp-src* ":AppGen.lisp")
(defconstant *genapp-fsl* #.(merge-pathnames *.fasl-pathname* ":AppGen"))

; end of L1-init.lisp


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
