;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  10 4/19/96 akh  from gb
;;  2 11/13/95 akh  comment out stuff that wont compile
;;  3 4/24/95  akh  support for restart-frame and return-from-frame
;;  (do not edit before this line!!)


; backtrace-lds.lisp
; low-level support for stack-backtrace dialog (Lisp Development System)
; Copyright 1987-1988, Coral Software Corp.
; Copyright 1989-1994, Apple Computer, Inc.
; Copyright 1995, Digitool, Inc.

(in-package :ccl)

;; Modification History
;
; AKH MAYBE FIX LOOKUP-REGISTERS SOME MORE??
;------------ 4.3F1C1
; 01/18/98 akh fix lookup-registers
; 10/27/97 akh  set-saved-register use *saved-register-count* vs 5 
; 02/28/97 bill last-catch-since passes stack-group to %stack<
; ------------- 4.0
; 10/11/96 bill active-tsp-count no longer calls ff-call-instruction-p since callback
;               no longer pushes a TSP frame. ff-call-instruction-p commented out.
; ------------- 4.0f1
; 07/12/96 bill lookup-registers handles unwind-protect stack frames correctly.
;               It also works at the boundary between two vsp stack segments.
; 05/21/96 bill frame-supplied-args properly ignores its child arg. 
; 05/02/96 bill categorize-instruction no longer says that ffcall instructions push a tsp frame.
;               active-tsp-count calls ff-call-instruction-p on the instruction before the
;               active PC. If it is an ff-call instruction, then there is one more TSP frame
;               (pushed by callback).
; 04/17/96 gb   frame-supplied-args: walk the stack from parent to current, not current to child.
; ------ 3.9f1c2
; 04/08/96 bill %%apply-in-frame handles a fake parent-frame
; 03/25/96 bill active-tsp-count uses *branch-tree-hash* to save recomputation.
; 03/14/96 bill last-catch-since uses next-catch instead of uvref'ing itself. Tests for NIL instead of 0.
;               Finish %apply-in-frame by making it call (new) active-tsp-count to determine
;               how many tsp frames to pop.
;               Make frame-restartable-p look up the saved registers between the last catch frame
;               and the requested one (I forgot this before).
; 03/01/96 gb   no lfun attributes
; 02/22/96 bill Do more of apply-in-frame
; 02/16/96 bill last-catch-since & parent-frame-saved-vars use %stack< instead of assuming
;               that frame pointers are fixnums
; 01/05/96 bill last-catch-since-saved-vars uses catch-frame-sp instead of assuming that
;               the catch frame is in the control stack.
; 12/19/95 bill (%cons-saved-register-vector) replaces explicit use of dsave0 & friends.
;  3/30/95 slh  merge in base-app changes
;-------------- 3.0d18
;04/13/93 bill set-nth-value-in-frame works again.
;------------- 2.1d5
;03/16/93 bill return-from-frame works in the new order.
;03/12/93 bill frame-vsp updated for segmented stacks.
;03/01/93 bill teach last-frame-ptr about segmented stacks
;11/20/92 gb   pass stack-group around; needs to work with discontiguous stacks.
;------------- 2.0
;11/11/91 gb   use "safe-cell-value" to lie about nilreg v,fcells.
;------------- 2.0b3
;07/21/91 gb   Declaim, %badarg.
;06/13/91 bill "saved ~s" -> "saved ~a"
;------------- 2.0b2
;05/06/91 bill set-saved-register, set-register-value
;              find-local-name returns "saved xSAVEn" vice xSAVEn for argtype
;05/03/91 bill set-nth-value-in-frame
;05/20/91 gb   FUNCTION-ARGS groks &restv.
;05/01/91 alice nth-value-in-frame - as gary suggests don't _debugger, make range check work
;03/04/91 alice report-bad-arg gets 2 args
;02/18/91 gb   %uvsize -> uvsize.
;02/07/91 alice ccl; => ccl:
;-------------- 2.0b1
;11/21/90 gb   slight mods to (select-)backtrace.
;10/23/90 akh  gary's fix to show nilreg-relative specials in nth-value-in-frame
;10/16/90 bill frame-supplied-args, *proto-return* interracts correctly with PROGV.
;10/11/90 bill Remove old backtrace window
;10/10/90 bill add identification of saved registers to find-local-name
;10/09/90 bill parent-frame-saved-vars, saved-register-values
;10/05/90 bill make *proto-return*'s agree with last-catch-since (unsigned compare).
;              Also pop CSAREA to below target SP.
;09/14/90 bill *use-new-backtrace* in select-backtrace.
;09/06/90 bill Invalidate the backtrace-dialog after set-view-size
;08/30/90 bill add PC to print-call-history
;08/24/90 bill frame-lfun
;08/02/90 bill Fix drawing in set-view-size
;07/26/90 bill function-args returns NIL for NKEYS if &key not mentioned.
;07/13/90 alice put find-local-name from patch-2.0a1 (correct??)
;07/05/90 bill  Fix some sizes to prevent overlapping.
;07/04/90 bill  bug in find-local-name when lfun arg was nil.
;06/25/90 bill  :table-width & :table-height -> :table-dimensions.
;06/22/90 bill  :window-font -> :view-font
;06/13/90 bill  resize the backtrace-dialog.
;06/12/90 gb    FIND-LOCAL-NAME counts nkeys twice (for key-supplied-p stuff.)
;06/04/90 gb     return-from-frame rides again.
;05/27/90 gb     move trace etc. to encapsulate.lisp.
;05/24/90 bill  :window-size -> :view-size
;04/30/90 gb    new stack walkers.  apply-in-frame still broken.
;01/17/90  gz   pass $lfatr-noname-bit to %make-lfun.
;02/10/90 bill  without-dialog-drawing => with-quieted-view
;12/29/89 bill  Remove (method window-deativate-event-handler :after (backtrace-dialog))
;               The dialog does this automagically.
;12/27/89  gz   Use defsetf to def a setf.
; 10/24/89 gb   trace-global-def makes a closure.  What a concept.
; 9/27/89 gb    defvar -> proclaim of *backtrace-dialogs*.
; 9/17/89 gb    removed ASKs from trace functions.
; 9/17/89  gz   $lfatr-regs-mask in registers-used-by.
; 9/16/89 bill  Left a couple of ASK's in trace functions.
; 9/10/89  gz   use first-selected-cell.
;               (%cdr (%sym-fn-loc x)) -> (fboundp x)
; 09/09/89 bill $catchtop => $ccatchtop in last-catch-since
; 09/07/89 bill add without-dialog-item-drawing-if to 
;               backtrace-frame-table-update to prevent double drawing
; 09/06/89 bill CLOSify the dialog
;               apply-in-frame: imms returned from decompose-fn was assumed
;               to be a simple-vector: (svset ...) => (setf (aref ...))
;08/24/89 gb  gratuitous fascist global name changes.
; 07/28/89 bill "dialog" => "dialog-object"
;5/8/89   gz  %make-compiled-function -> %make-lfun (new regime)
;04/27/89 gb  backtrace-frame-table-update : set instance variables before calling SCROLL-TO-CELL
;             and/or SET-TABLE-DIMENSIONS.  Btw, why all the update events all of a sudden?
;04/07/89 gb  $sp8 -> $sp.
; 03/18/89 gz  window-foo -> window-object-foo.
; 7-apr-89 as  %str-cat takes rest arg
; 03/04/89 gz  put trace/untrace here.  New %make-compiled-function args,
;              symbolic names for lfun bits.
; 02/23/89 gb  shared-macptr bug in cell-sp.
; 12/01/88 gz  use defobject.
; 9/11/88 gb   life after cfp; make local, setf-local work.
; 8/23/88 gz   declarations
; 8/17/88 gb   sp-lfun -> cfp-lfun.
; 6/22/88 as   saved-specials always described in backtrace
; 6/21/88 as   (setf (local . . .))
;              inspect function-object, not symbol
; 6/20/88 as   add 10 to pc when displaying it (but not when storing it)
; 6/16/88 as   new features
; 6/10/88 jaj  added closed-over-value-p and use it
; 6/7/88  gb   put in local name stuff
; 6/01/88 as   catch :truncate
; 5/13/88 jaj  made room for package of *debug-value*

;10/28/87 gb   require traps.
;10/15/87 jaj  *d* renamed to *debug-value* %lfun-name-string only has offsets
;              if above A5.
; 9/15/87 jaj    print *d* using ~s, don't print hex addresses in block-compiled
;                version.  new function %lfun-name-string, other changes.
;---------------------------------Version 1.0----------------------------------
; 8/01/87  gb    made backtrace-frame-table-update scroll to cell 0.  made
;                frame-title's size a little shorter to reduce update glitches.
; 7/28/87  as    changed wording of dialog message
; 7/28/87  gz    draw to self in draw-cell-contents, per gb.
; 7/24/87  as    single click displays frame values.
;                new text item tells about *d*
;                made de-activation more visually informative
; 7/23/87  gb    changed position, size of static-text-item, made it
;                print frame address in hex.
; 7/21/87  gz    select-backtrace does a modeless backtrace,
;                backtrace does a modal one.
;                Fencepost in backtrace-table-update.
; 7/19/87 as/gb  switched font to monaco 9
;                binds *d* to selected value in selected frame.
; 7/17/87 jaj    up to window spec
; 7/14/87  gb    require defrecord, provide backtrace.
; 7/13/87 jaj    init-lists use keywords
; 7/11/87  as    backtrace uses table-double-click-p
; 7/6/87   gz    new EXIST arg scheme
; 7/02/87  gb    don't compile dialog-item-action every time. Fencepost
;                in count-values-in-frame.  Set flags in table handles to allow
;                at most one cell to be selected.  Deselect old cell when
;                selecting new frames.
; 6/30/87  gz    bind *print-length* and *print-level* when drawing frames.
; 6/25/87  gz    put 'version, autoload dialogs.
; 6/24/87  gb    re-worked.
; 6/22/87  gb    still modeless but finds functions better.
; 6/19/87  gb    %have -> have.
; 6/18/87  jaj   New file.

(eval-when (eval compile #-bccl load)
  (require 'streams))

(eval-when (eval compile)
  ;(require 'toolequ)
  (require 'sysequ)
  (require 'lispequ)
  #-ppc-target
  (require 'subprims8 "ccl:compiler;subprims8")
  (require 'backquote)
)


; Act as if VSTACK-INDEX points somewhere where DATA could go & put it there.
(defun set-lisp-data (vstack-index data)
  (let* ((old (%access-lisp-data vstack-index)))
    (if (closed-over-value-p old)
      (set-closed-over-value old data)
      (%store-lisp-data vstack-index data))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;extensions to let user access and modify values

#-ppc-target   ; PPC version in "ccl:l1;ppc-stack-groups.lisp"
(defun set-nth-value-in-frame (sp n sg new-value &optional child-frame &aux 
                              (i -1)
                              special)
  (declare (ignore child-frame))
  (let* ((curvsp (frame-vsp sp)))
    (loop
      (setq special (saved-binding-p sg curvsp) 
            i (%i+ i 1))
      (when (eq n i)
        (set-lisp-data curvsp new-value)
        (return new-value))
      (setq curvsp (%i- curvsp (if special 3 1))))))

; Returns five values: (ARGS TYPES NAMES COUNT NCLOSED)
; ARGS is a list of the args supplied to the function
; TYPES is a list of the types of the args.
; NAMES is a list of the names of the args.
;       TYPES & NAMES will hae entries only for closed-over, required, & optional args.
; COUNT is the number of known-correct elements of ARGS, or T if they're all correct.
;       ARGS will be filled with NIL up to the number of required args to lfun
; NCLOSED is the number of closed-over values that are in the prefix of ARGS
;       If COUNT < NCLOSED, it is not safe to restart the function.
(defun frame-supplied-args (frame lfun pc child sg)
  (declare (ignore child))
  (multiple-value-bind (req opt restp keys allow-other-keys optinit lexprp ncells nclosed)
                       (function-args lfun)
    (declare (ignore allow-other-keys lexprp ncells))
    (let* ((vsp (1- (frame-vsp (parent-frame frame sg))))
           (child-vsp (1- (frame-vsp frame)))
           (frame-size (- vsp child-vsp))
           (res nil)
           (types nil)
           (names nil))
      (flet ((push-type&name (cellno)
               (multiple-value-bind (type name) (find-local-name cellno lfun pc)
                 (push type types)
                 (push name names))))
        (declare (dynamic-extent #'push-type&name))
        (if (or #-ppc-target (logbitp ccl::$lfatr-novpushed-args-bit (ccl::lfun-attributes lfun))
                (<= frame-size 0))
          ; Can't parse the frame, but all but the last 3 args are on the stack
          (let* ((nargs (+ nclosed req))
                 (vstack-args (max 0 (min frame-size (- nargs 3)))))
            (dotimes (i vstack-args)
              (declare (fixnum i))
              (push (access-lisp-data vsp) res)
              (push-type&name i)
              (decf vsp))
            (values (nreconc res (make-list (- nargs vstack-args)))
                    (nreverse types)
                    (nreverse names)
                    vstack-args
                    nclosed))
          ; All args were vpushed.
          (let* ((might-be-rest (> frame-size (+ req opt)))
                 (rest (and restp might-be-rest (access-lisp-data (- vsp req opt))))
                 (cellno -1))
            (declare (fixnum cellno))
            (when (and keys might-be-rest (null rest))
              (let ((vsp (- vsp req opt))
                    (keyvect (lfun-keyvect lfun))
                    (res nil))
                (dotimes (i keys)
                  (declare (fixnum i))
                  (when (access-lisp-data (1- vsp))   ; key-supplied-p
                    (push (aref keyvect i) res)
                    (push (access-lisp-data vsp) res))
                  (decf vsp 2))
                (setq rest (nreverse res))))
            (dotimes (i nclosed)
              (declare (fixnum i))
              (when (<= vsp child-vsp) (return))
              (push (access-lisp-data vsp) res)
              (push-type&name (incf cellno))
              (decf vsp))
            (dotimes (i req)
              (declare (fixnum i))
              (when (<= vsp child-vsp) (return))
              (push (access-lisp-data vsp) res)
              (push-type&name (incf cellno))
              (decf vsp))
            (if rest
              (dotimes (i opt)              ; all optionals were specified
                (declare (fixnum i))
                (when (<= vsp child-vsp) (return))
                (push (access-lisp-data vsp) res)
                (push-type&name (incf cellno))
                (decf vsp))
              (let ((offset (+ opt (if restp 1 0) (if keys (+ keys keys) 0)))
                    (optionals nil))
                (dotimes (i opt)            ; some optionals may have been omitted
                  (declare (fixnum i))
                  (when (<= vsp child-vsp) (return))
                  (let ((value (access-lisp-data vsp)))
                    (if optinit
                      (if (access-lisp-data (- vsp offset))
                        (progn
                          (push value optionals)
                          (push-type&name (incf cellno))
                          (return)))
                      (progn (push value optionals)
                             (push-type&name (incf cellno))))
                    (decf vsp)))
                (unless optinit
                  ; assume that null optionals were not passed.
                  (while (and optionals (null (car optionals)))
                    (pop optionals)
                    (pop types)
                    (pop names)))
                (setq rest (nreconc optionals rest))))
            (values (nreconc res rest) (nreverse types) (nreverse names)
                    t nclosed)))))))

; nth-frame-info, set-nth-frame-info, & frame-lfun are in "inspector;new-backtrace"

(defun frame-name-number (symbol)
  "given a name, returns index of slot in frame."
  (let* ((names (names-in-frame))
         (tail (memq symbol names)))
    (if tail
      (if (memq symbol (cdr tail))
        (error "~s is bound more than once in the current frame.~
        ~%Please refer to it by number." symbol)
        (- (list-length names)
           (list-length tail)))
      (error "~s is not bound in the current frame." symbol))))

(defmacro local (indicator)
  (if (symbolp indicator)
    `(values (nth-frame-info (frame-name-number ',indicator)))
    (progn
      (unless (fixnump indicator)
        (report-bad-arg indicator '(or symbol (integer 0 #.call-arguments-limit))))
      `(values (nth-frame-info ,indicator)))))

(defmacro set-local (indicator new-value)
  (if (symbolp indicator)
    `(set-nth-frame-value (frame-name-number ',indicator) ,new-value)
    (progn
      (unless (fixnump indicator)
        (report-bad-arg indicator '(or symbol (integer 0 #.most-positive-fixnum))))
      `(set-nth-frame-value ,indicator ,new-value))))

(defsetf local set-local)

; Returns the segment containing index, or NIL if it's not in the stack
; actually returns index or nil - or something -  ok its just a predicate
#-ppc-target
(defun %stack-member (index stackseg)
  (lap-inline (index stackseg)
    (move.l arg_z atemp0)
    (index->address arg_y arg_y) ; index as address
    (move.l atemp0 atemp1)  ; stackseg
    (prog#
     (if# (cc (atemp1 $stackseg.first) arg_y)
       (if# (cs (atemp1 $stackseg.last) arg_y)
         (address->index arg_y acc)  ; address as index - i.e. original index
         (bra (exit#))))
     (move.l (atemp1 $stackseg.older) da)
     (move.l da atemp1)
     (bne (top#))
     (move.l nilreg acc)))) 
 
#-ppc-target
(defun %stack< (index1 index2 stackseg)
  (lap-inline (index1 index2 stackseg)
    (move.l arg_z atemp0)     ; stackseg
    (index->address arg_x arg_x)
    (index->address arg_y arg_y)
    (move.l atemp0 atemp1)  ; stackseg
    (prog#
     (if# (cc (atemp1 $stackseg.first) arg_x)
       (bif (cs (atemp1 $stackseg.last) arg_x) (exit#)))
     (move.l (atemp1 $stackseg.older) da)
     (move.l da atemp1)   ; prior seg to atemp1 - atemp1 is seg containing index1
     (bne (top#))
     (ccall error '"Couldn't find index1 in stack"))
    (prog#
     (if# (cc (atemp0 $stackseg.first) arg_y)
       (bif (cs (atemp0 $stackseg.last) arg_y) (exit#)))
     (if# (eq atemp0 atemp1)
       (move.l 't acc)
       (lfret))
     (move.l (atemp0 $stackseg.older) atemp0)
     (bra (top#)))
    (move.l nilreg acc)
    (if# (and (eq atemp0 atemp1)
              (cc arg_x arg_y)
              ne)
      (add.l ($ $t_val) acc))))
       



#-ppc-target
(defun last-catch-since (sp sg) 
  ;(declare (%noforcestk))
  (lap-inline ()(:variable sp sg)
   (index->address arg_y db)  ; so sp is an index
   (move.l arg_z atemp0)
   (move.l (atemp0 $sg.sgbuf) atemp0)
   (move.l (svref atemp0 sgbuf.csbuf) atemp0)  ; some side effect I dont understand
   (if# (ne (special *current-stack-group*) arg_z)
     (move.l (atemp0 $stackseg.first) atemp1)
    else#
     (move.l sp (atemp0 $stackseg.first))
     (move.l (a5 $ccatchtop) atemp1))
   (prog#
    (if# (cc (atemp0 $stackseg.first) db)
      (bif (cs (atemp0 $stackseg.last) db) (exit#)))
    (move.l (atemp0 $stackseg.older) da)
    (move.l da atemp0)
    (bne (top#))
    (ccall error '"Can't find stack segment"))
   ; db = sp arg as an address
   ; atemp0 = stack seg containing sp
   ; atemp1 = first catch frame
   (moveq 0 dtemp1)
   (bra @test)
   (prog#
    (move.l atemp1 dtemp1)
    (move.l (atemp1 $catch.link) atemp1)
    @test
    (bif (eq (move.l atemp1 da)) (exit#))
    (if# (and (cc (atemp0 $stackseg.first) atemp1)
              (cs (atemp0 $stackseg.last) atemp1))
      (bif (cc atemp1 db) (top#))
      (bra (exit#)))
    (spush atemp0)
    (bra @nextseg)
    (prog#
     (bif (and (cc (atemp0 $stackseg.first) atemp1)
               (cs (atemp0 $stackseg.last) atemp1))
          (exit#))
     @nextseg
     (move.l (atemp0 $stackseg.older) acc)
     (move.l acc atemp0)
     (bif ne (top#)))
    (spop atemp0)
    (bif eq (top#)))
   (move.l nilreg acc)
   (if# (ne (tst.l dtemp1))
     (add.l ($ $catch.pc) dtemp1)
     (address->index dtemp1 acc))))

#+ppc-target
(defun last-catch-since (sp sg)
  (let ((catch (%catch-top sg))
        (last-catch nil))
    (loop
      (unless catch (return last-catch))
      (let ((csp (uvref catch ppc::catch-frame.csp-cell)))
        (when (%stack< sp csp sg) (return last-catch))
        (setq last-catch catch
              catch (next-catch catch))))))

(defparameter *saved-register-count*
  #-ppc-target 5
  #+ppc-target 8)

(defparameter *saved-register-count+1*
  (1+ *saved-register-count*))

(defparameter *saved-register-names*
  #-ppc-target #(asave1 asave0 dsave2 dsave1 dsave0)
  #+ppc-target #(save7 save6 save5 save4 save3 save2 save1 save0))

(defparameter *saved-register-numbers*
  #-ppc-target #(11 10 7 6 5)
  #+ppc-target #(31 30 29 28 27 26 25 24))

; Don't do unbound checks in compiled code
(declaim (type t *saved-register-count* *saved-register-count+1*
               *saved-register-names* *saved-register-numbers*))

(defmacro %cons-saved-register-vector ()
  `(make-array (the fixnum *saved-register-count+1*) :initial-element nil))

(defun copy-srv (from-srv &optional to-srv)
  (if to-srv
    (if (eq from-srv to-srv)
      to-srv
      (dotimes (i (uvsize from-srv) to-srv)
        (setf (uvref to-srv i) (uvref from-srv i))))
    (copy-uvector from-srv)))

(defmacro srv.unresolved (saved-register-vector)
  `(svref ,saved-register-vector 0))

(defmacro srv.register-n (saved-register-vector n)
  `(svref ,saved-register-vector (1+ ,n)))

; This isn't quite right - has to look at all functions on stack, not just those that saved VSPs.
#-ppc-target
(defun frame-restartable-p (target &optional (sg *current-stack-group*))
  (let ((srv (%cons-saved-register-vector)))
    (let* ((catch (last-catch-since target sg))
           lfun
           pc
           (unresolved 0)
           (frame (parent-frame catch sg))
           (child (child-frame frame sg)))
      #-bccl (unless frame (break "bug: null frame"))
      (loop
        (unless (multiple-value-setq (lfun pc) (cfp-lfun frame sg child)) (return nil))
        (multiple-value-bind (mask where) (registers-used-by lfun pc)
          (when mask
            (if (not where) 
              (setq unresolved (%ilogior unresolved mask))
              (let ((vsp (- (frame-vsp frame) where (1- (logcount mask))))
                    (j *saved-register-count*))
                (dotimes (i j)
                  (declare (fixnum i))
                  (when (%ilogbitp (setq j (%i- j 1)) mask)
                    (setf (srv.register-n srv i) vsp
                          vsp (1+ vsp)
                          unresolved (%ilogand unresolved (%ilognot (%ilsl j 1))))))))))
        (when (eq target frame)
          (return (setf (srv.unresolved srv) (if (eql unresolved 0) target))))
        (setq child frame)
        (unless (setq frame (parent-frame frame sg))
          (return))))
    ;(break "target = ~s ~s ~x" target (index->address target) (index->address target))
    (and (srv.unresolved srv) srv)))

#+ppc-target
(defun frame-restartable-p (target &optional (sg *current-stack-group*))
  (multiple-value-bind (frame last-catch srv) (last-catch-since-saved-vars target sg)
    (when frame
      (loop
        (when (null frame)
          (return-from frame-restartable-p nil))
        (when (eq frame target) (return))
        (multiple-value-setq (frame last-catch srv)
          (ccl::parent-frame-saved-vars sg frame last-catch srv srv)))
      (when (and srv (eql 0 (srv.unresolved srv)))
        (setf (srv.unresolved srv) last-catch)
        srv))))

#-ppc-target                            ; ppc version in ppc-stack-groups
(defun next-catch (catch)
  (lap-inline (catch)
    (index->address arg_z atemp0)
    (move.l nilreg acc)
    (if# (ne (move.l (atemp0 (- $catch.link $catch.pc)) da))
      (add.l ($ $catch.pc) da)
      (address->index da acc))))

; get the saved register addresses for this frame
; still need to worry about this unresolved business
; could share some code with parent-frame-saved-vars
(defun my-saved-vars (sg frame &optional (srv-out (%cons-saved-register-vector)))
  (let ((unresolved 0))
    (multiple-value-bind (lfun pc) (cfp-lfun frame sg)
        (if lfun
          (multiple-value-bind (mask where) (registers-used-by lfun pc)
            (when mask
              (if (not where) 
                (setq unresolved (%ilogior unresolved mask))
                (let ((vsp (- (frame-vsp frame) where (1- (logcount mask))))
                      (j *saved-register-count*))
                  (declare (fixnum j))
                  (dotimes (i j)
                    (declare (fixnum i))
                    (when (%ilogbitp (decf j) mask)
                      (setf (srv.register-n srv-out i) vsp
                            vsp (1+ vsp)
                            unresolved (%ilogand unresolved (%ilognot (%ilsl j 1))))))))))
          (setq unresolved (1- (ash 1 *saved-register-count*)))))
    (setf (srv.unresolved srv-out) unresolved)
    srv-out))

#-ppc-target                            ; ppc version in ppc-stack-groups
(defun catch-frame-sp (catch)
  catch)

#-ppc-target
(defun parent-frame-saved-vars 
       (sg frame last-catch srv &optional (srv-out (%cons-saved-register-vector)))
  (copy-srv srv srv-out)
  (let* ((parent (and frame (parent-frame frame sg))))
    ;(print  (list frame parent last-catch))
    (when parent
      (loop (let ((next-catch (and last-catch (next-catch last-catch))))
              ;(declare (ignore next-catch))
              (if (and next-catch (< (catch-frame-sp next-catch) parent))
                (progn
                  (setf last-catch next-catch
                        (srv.unresolved srv-out) 0)
                  (dotimes (i *saved-register-count*)
                    (setf (srv.register-n srv i) nil)))
                (return))))
      (multiple-value-bind (lfun pc) (cfp-lfun parent sg frame)
        (if lfun
          (multiple-value-bind (mask where) (registers-used-by lfun pc)
            (when mask
              (locally (declare (fixnum mask))
                (if (not where) 
                  (setf (srv.unresolved srv-out) (%ilogior (srv.unresolved srv-out) mask))
                  (let ((vsp (- (frame-vsp parent) where (1- (logcount mask))))
                        (j *saved-register-count*))
                    (declare (fixnum j))
                    (dotimes (i j)
                      (declare (fixnum i))
                      (when (%ilogbitp (decf j) mask)
                        (setf (srv.register-n srv-out i) vsp
                              vsp (1+ vsp)
                              (srv.unresolved srv-out)
                              (%ilogand (srv.unresolved srv) (%ilognot (%ilsl j 1)))))))))))
          (progn
            (setf (srv.unresolved srv-out) (1- (ash 1 *saved-register-count*)))
            (dotimes (i *saved-register-count*)
                (setf (srv.register-n srv-out i) nil)))))
      (values parent last-catch srv-out))))

#+ppc-target
(defun parent-frame-saved-vars 
       (sg frame last-catch srv &optional (srv-out (%cons-saved-register-vector)))
  (copy-srv srv srv-out)
  (let* ((parent (and frame (parent-frame frame sg)))
         (grand-parent (and parent (parent-frame parent sg))))
    (when grand-parent
      (loop (let ((next-catch (and last-catch (next-catch last-catch))))
              ;(declare (ignore next-catch))
              (if (and next-catch (%stack< (catch-frame-sp next-catch) grand-parent sg))
                (progn
                  (setf last-catch next-catch
                        (srv.unresolved srv-out) 0)
                  (dotimes (i *saved-register-count*)
                    (setf (srv.register-n srv i) nil)))
                (return))))
      (lookup-registers parent sg grand-parent srv-out)
      (values parent last-catch srv-out))))

#|
(defun lookup-registers (parent sg grand-parent srv-out)
  (unless (or (eql (frame-vsp grand-parent) 0)              
              (let ((gg-parent (parent-frame grand-parent sg)))
                (eql (frame-vsp gg-parent) 0)))
    (multiple-value-bind (lfun pc) (cfp-lfun parent sg nil)
      (when lfun
        (multiple-value-bind (mask where) (registers-used-by lfun pc)
          (when mask
            (locally (declare (fixnum mask))
              (if (not where) 
                (setf (srv.unresolved srv-out) (%ilogior (srv.unresolved srv-out) mask))                
                (let* ((parent-vsp (frame-vsp parent))
                       (grand-parent-vsp (frame-vsp grand-parent)))
                  (when (eql parent-vsp 0)
                    ;; copied from vsp-limits
                    (setq parent-vsp (%frame-savevsp (child-frame parent sg))))
                  (let ((parent-area (when (not (eql 0 parent-vsp))(%active-area (sg.vs-area sg) parent-vsp))))                  
                  ;; parent-vsp is 0 parent-area is nil                  
                  (when parent-area
                    (unless (%ptr-in-area-p  grand-parent-vsp parent-area) 
                      (setq grand-parent-vsp (%fixnum-ref parent-area ppc::area.high))))
                  (let ((vsp (- grand-parent-vsp where 1))
                        (j *saved-register-count*))
                    (declare (fixnum j))
                    (dotimes (i j)
                      (declare (fixnum i))
                      (when (%ilogbitp (decf j) mask)
                        (setf (srv.register-n srv-out i) vsp
                              vsp (1- vsp)
                              (srv.unresolved srv-out)
                              (%ilogand (srv.unresolved srv-out) (%ilognot (%ilsl j 1)))))))))))))))))
|#
;; MAYBE ??
(defun lookup-registers (parent sg grand-parent srv-out)
  (unless (or (eql (frame-vsp grand-parent) 0)              
              (let ((gg-parent (parent-frame grand-parent sg)))
                (eql (frame-vsp gg-parent) 0)))
    (multiple-value-bind (lfun pc) (cfp-lfun parent sg nil)
      (when lfun
        (multiple-value-bind (mask where) (registers-used-by lfun pc)
          (when mask
            (locally (declare (fixnum mask))
              (if (not where) 
                (setf (srv.unresolved srv-out) (%ilogior (srv.unresolved srv-out) mask))
                (multiple-value-bind (parent-vsp grand-parent-vsp)(vsp-limits parent sg)
                  (cond ((eql parent-vsp grand-parent-vsp)  ;; does this ever happen?
                         (setf (srv.unresolved srv-out) (%ilogior (srv.unresolved srv-out) mask)))
                        (t 
                         (let ((vsp (- grand-parent-vsp where 1))
                               (j *saved-register-count*))
                           (declare (fixnum j))
                           (dotimes (i j)
                             (declare (fixnum i))
                             (when (%ilogbitp (decf j) mask)
                               (setf (srv.register-n srv-out i) vsp
                                     vsp (1- vsp)
                                     (srv.unresolved srv-out)
                                     (%ilogand (srv.unresolved srv-out) (%ilognot (%ilsl j 1))))))))))))))))))


; initialization for looping on parent-frame-saved-vars
(defun last-catch-since-saved-vars (frame sg)
  (let* ((parent (parent-frame frame sg))
         (last-catch (and parent (last-catch-since parent sg))))
    (when last-catch
      (let ((frame (catch-frame-sp last-catch))
            (srv (%cons-saved-register-vector)))
        (setf (srv.unresolved srv) 0)
        (let* ((parent (parent-frame frame sg))
               (child (and parent (child-frame parent sg))))
          (when child
            (lookup-registers child sg parent srv))
          (values child last-catch srv))))))

; Returns 2 values:
; mask srv
; The mask says which registers are used at PC in LFUN.
; srv is a saved-register-vector whose register contents are the register values
; registers whose bits are not set in MASK or set in UNRESOLVED will
; be returned as NIL.

(defun saved-register-values 
       (lfun pc child last-catch srv &optional (srv-out (%cons-saved-register-vector)))
  (declare (ignore child))
  (cond ((null srv-out) (setq srv-out (copy-uvector srv)))
        ((eq srv-out srv))
        (t (dotimes (i (the fixnum (uvsize srv)))
             (setf (uvref srv-out i) (uvref srv i)))))
  (let ((mask (or (registers-used-by lfun pc) 0))
        (unresolved (srv.unresolved srv))
        (j *saved-register-count*))
    (declare (fixnum j))
    (dotimes (i j)
      (declare (fixnum i))
      (setf (srv.register-n srv-out i)
            (and (%ilogbitp (setq j (%i- j 1)) mask)
                 (not (%ilogbitp j unresolved))
                 (safe-cell-value (get-register-value (srv.register-n srv i) last-catch j)))))
    (setf (srv.unresolved srv-out) mask)
    (values mask srv-out)))

; Set the nth saved register to value.
(defun set-saved-register (value n lfun pc child last-catch srv)
  (declare (ignore lfun pc child) (dynamic-extent saved-register-values))
  (let ((j (- ccl::*saved-register-count* 1 n))
        (unresolved (srv.unresolved srv))
        (addr (srv.register-n srv n)))
    (when (logbitp j unresolved)
      (error "Can't set register ~S to ~S" n value))
    (set-register-value value addr last-catch j))
  value)

; Index is bit number in register mask:
; 4=dsave0, 3=dsave1, 2=dsave2, 1=asave0, 0=asave1
#-ppc-target
(defun get-register-value (address last-catch index)
  (declare (%noforcestk))
  (lap-inline (address last-catch index)
    (if# (ne (cmp.l arg_x nilreg))      ; address
      (index->address arg_x atemp0)
      (move.l @atemp0 acc)
     else#
      (index->address arg_y atemp0)     ; last-catch
      (vscale.l arg_z)                  ; index
      (neg.l arg_z)
      (move.l (atemp0 arg_z (- (+ $catch.regs (* 4 4)) $catch.pc)) acc))))

#+ppc-target
(ppc-defun get-register-value (address last-catch index)
  (if address
    (%fixnum-ref address)
    (uvref last-catch (+ index ppc::catch-frame.save-save7-cell))))

; Inverse of get-register-value
#-ppc-target
(defun set-register-value (value address last-catch index)
  (declare (%noforcestk))
  (lap-inline (value address last-catch index)
    (if# (ne (cmp.l arg_x nilreg))      ; address
      (index->address arg_x atemp0)
      (move.l @vsp @atemp0)
     else#
      (index->address arg_y atemp0)     ; last-catch
      (vscale.l arg_z)                  ; index
      (neg.l arg_z)
      (move.l @vsp (atemp0 arg_z (- (+ $catch.regs (* 4 4)) $catch.pc))))))

#+ppc-target
(ppc-defun set-register-value (value address last-catch index)
  (if address
    (%fixnum-set address value)
    (setf (uvref last-catch (+ index ppc::catch-frame.save-save7-cell)) value)))

(defun return-from-nth-frame (n &rest values)
  (apply-in-nth-frame n #'values values))

(defun apply-in-nth-frame (n fn arglist)
  (let* ((bt-info (car *backtrace-dialogs*)))
    (and bt-info
         (let* ((frame (nth-frame nil (bt.youngest bt-info) n)))
           (and frame (apply-in-frame frame fn arglist)))))
  (format t "Can't return to frame ~d ." n))

; This method is shadowed by one for the backtrace window.
(defmethod nth-frame (w target n &aux (sg *current-stack-group*))
  (declare (ignore w))
  (and target (dotimes (i n target)
                (declare (fixnum i))
                (unless (setq target (parent-frame target sg)) (return nil)))))

; If this returns at all, it's because the frame wasn't restartable.
(defun apply-in-frame (frame fn arglist &optional (sg *current-stack-group*))
  (let* ((srv (frame-restartable-p frame sg))
         (target-sp (and srv (srv.unresolved srv))))
    (if target-sp
      (apply-in-frame-internal sg frame fn arglist srv))))

(defun apply-in-frame-internal (sg frame fn arglist srv)
  (if (eq sg *current-stack-group*)
    (%apply-in-frame frame fn arglist srv)
    (let ((process (stack-group-process sg)))
      (if process
        (process-interrupt
         process
         #'%apply-in-frame
         frame fn arglist srv)
        (error "Can't find active process for ~s" sg)))))

#-ppc-target
(defun %apply-in-frame (frame fn arglist srv)
  (unless (and fn
               (or (symbolp fn)
                   (functionp fn)))
    (report-bad-arg fn '(or function symbol)))
  (let* ((catch (last-catch-since  frame *current-stack-group*))
         #|
           ; this sort of works & they are = but if we just do my-last-catch-since it crashes
           (cadr (list nil ;(last-catch-since  frame *current-stack-group*)
                              (my-last-catch-since  frame *current-stack-group*)))) |#
         (sgbuf (sg-buffer *current-stack-group*))
         (csbuf (sgbuf.csbuf sgbuf))
         (vsbuf (sgbuf.vsbuf sgbuf))
         (vsp (lap-inline (frame)
                (index->address arg_z atemp0)
                (address->index @atemp0 acc)))
         (dblink (let ((link (lap-inline ()
                               (move.l (a5 $db_link) acc)
                               (address->index acc acc))))
                   (lap-inline (csbuf vsbuf)
                     (index->address arg_z atemp0)  ; arg_y arg_z backwards?
                     (move.l vsp (atemp0 $stackseg.first))
                     (index->address arg_y atemp0)
                     (move.l sp (atemp0 $stackseg.first)))  ; WHAT Again

                   (loop
                     (when (or (eql 0 link)
                               (and (%stack-member link vsbuf)
                                    (or (eql link vsp)
                                        (%stack< vsp link vsbuf)))
                               (and (%stack-member link csbuf)
                                    (%stack< frame link csbuf)))
                       (return))
                     (setq link (lap-inline (link)
                                  (index->address arg_z atemp0)
                                  (move.l @atemp0 acc)
                                  (address->index acc acc))))   ; assumes 0 -> 0
                   link))
         (csarea (let ((csarea (lap-inline ()
                                 (move.l (a5 $csarea) acc)
                                 (address->index acc acc))))    ; assumes 0 -> 0
                   (loop
                     (when (or (eql 0 csarea)
                               (%stack< frame csarea csbuf))
                       (return))
                     (setq csarea (lap-inline (csarea)
                                    (index->address arg_z atemp0)
                                    (move.l @atemp0 acc)
                                    (address->index acc acc))))         ; assumes 0 -> 0
                   csarea))
         (dsave0-loc (srv.register-n srv 0))
         (dsave1-loc (srv.register-n srv 1))
         (dsave2-loc (srv.register-n srv 2))
         (asave0-loc (srv.register-n srv 3))
         (asave1-loc (srv.register-n srv 4))
         (v (vector catch dblink csarea frame fn arglist
                    dsave0-loc dsave1-loc dsave2-loc asave0-loc asave1-loc)))
    (lap-inline (v)
      (movereg arg_z acc)
      (move.l acc atemp0)
      (move.l (svref atemp0 0) da)      ; catch
      (if# ne
        (index->address da da)
        (sub.l ($ $catch.pc) da)
        (address->index da da)
        (move.l da (svref atemp0 0)))
      (loop#
       (move.l acc atemp0)
       (move.l (svref atemp0 0) da)
       (index->address da da)           ; assumes that 0 -> 0
       (if# (eq (move.l (a5 $ccatchtop) db))
         ; Can't get to the end as *%dynvfp%* & *%dynvlimit%* are always bound
         (ccall error '"End of catch chain. This shouldn't ever happen"))
       (bif (eq db da) (exit#))
       (jsr_subprim $sp-nthrow1v1))
      (if# (ne (tst.l (a5 $ccatchtop)))  ; then throw one more - odd
        (jsr_subprim $sp-nthrow1v1))
      (move.l acc atemp0)
      (move.l (svref atemp0 1) da)      ; dblink
      (index->address da da)
      (loop#
       (move.l (a5 $db_link) db)
       (bif (eq db da) (exit#))
       (if# (eq (tst.l db))
         (ccall error '"End of dynamic binding chain. This should never happen."))
       (jsr_subprim $sp-payback))       ; assumes $sp-payback preserves acc & da
      (vpush acc)
      (move.l acc atemp0)
      (move.l (svref atemp0 2) acc)     ; csarea
      (loop#
       (move.l acc da)
       (index->address da da)           ; assumes 0 -> 0
       (move.l (a5 $csarea) db)
       (bif (eq db da) (exit#))
       (if# (eq (tst.l db))
         (ccall error '"End of csarea chain. This shouldn't happen."))
       (jsr_subprim $sp-popnlisparea))
      (vpop acc)
      (move.l acc atemp0)
      (lea (svref atemp0 6) atemp0)     ; dsave0-loc
      (move.l atemp0@+ da)
      (if# (ne da nilreg)
        (index->address da atemp1)
        (move.l @atemp1 dsave0))
      (move.l atemp0@+ da)
      (if# (ne da nilreg)
        (index->address da atemp1)
        (move.l @atemp1 dsave1))
      (move.l atemp0@+ da)
      (if# (ne da nilreg)
        (index->address da atemp1)
        (move.l @atemp1 dsave2))
      (move.l atemp0@+ da)
      (if# (ne da nilreg)
        (index->address da atemp1)
        (move.l @atemp1 asave0))
      (move.l atemp0@+ da)
      (if# (ne da nilreg)
        (index->address da atemp1)
        (move.l @atemp1 asave1))
      (move.l acc atemp0)
      (move.l (svref atemp0 3) da)      ; frame
      (index->address da sp)
      (move.l @sp vsp)
      (move.l (svref atemp0 5) arg_z)   ; arglist
      (move.l (svref atemp0 4) atemp0)          ; fn
      (set_nargs 0)
      (jsr_subprim $sp-spreadargz-vextend-save-atemp0)
      (jmp_subprim $sp-tfuncallgen-vchunkpop))))

#+ppc-target
; (srv.unresolved srv) is the last catch frame, left there by frame-restartable-p
; The registers in srv are locations of variables saved between frame and that catch frame.
(defun %apply-in-frame (frame fn arglist srv)
  (declare (fixnum frame))
  (let* ((catch (srv.unresolved srv))
         (tsp-count 0)
         (sg *current-stack-group*)
         (parent (parent-frame frame sg))
         (vsp (frame-vsp parent))
         (catch-top (%catch-top sg))
         (db-link (%svref catch ppc::catch-frame.db-link-cell))
         (catch-count 0))
    (declare (fixnum parent vsp db-link catch-count))
    ; Figure out how many catch frames to throw through
    (loop
      (unless catch-top
        (error "Didn't find catch frame"))
      (incf catch-count)
      (when (eq catch-top catch)
        (return))
      (setq catch-top (next-catch catch-top)))
    ; Figure out where the db-link should be
    (loop
      (when (or (eql db-link 0) (>= db-link vsp))
        (return))
      (setq db-link (%fixnum-ref db-link)))
    ; Figure out how many TSP frames to pop after throwing.
    (let ((sp (catch-frame-sp catch)))
      (loop
        (multiple-value-bind (f pc) (cfp-lfun sp sg)
          (when f (incf tsp-count (active-tsp-count f pc))))
        (setq sp (parent-frame sp sg))
        (when (eql sp parent) (return))
        (unless sp (error "Didn't find frame: ~s" frame))))
    #+debug
    (cerror "Continue" "(apply-in-frame ~s ~s ~s ~s ~s ~s ~s)"
            catch-count srv tsp-count db-link parent fn arglist)
    (%%apply-in-frame catch-count srv tsp-count db-link parent fn arglist)))

(defppclapfunction %%apply-in-frame ((catch-count imm0) (srv temp0) (tsp-count imm0) (db-link imm0)
                                     (parent arg_x) (function arg_y) (arglist arg_z))
  (check-nargs 7)

  ; Throw through catch-count catch frames
  (lwz imm0 12 vsp)                      ; catch-count
  (vpush parent)
  (vpush function)
  (vpush arglist)
  (bla .SPnthrowvalues)

  ; Pop tsp-count TSP frames
  (lwz tsp-count 16 vsp)
  (cmpi cr0 tsp-count 0)
  (b @test)
@loop
  (subi tsp-count tsp-count '1)
  (cmpi cr0 tsp-count 0)
  (lwz tsp 0 tsp)
@test
  (bne cr0 @loop)

  ; Pop dynamic bindings until we get to db-link
  (lwz imm0 12 vsp)                     ; db-link
  (ref-global imm1 db-link)
  (cmp cr0 imm0 imm1)
  (beq cr0 @restore-regs)               ; .SPunbind-to expects there to be something to do
  (bla .SPunbind-to)

@restore-regs
  ; restore the saved registers from srv
  (lwz srv 20 vsp)
@get0
  (svref imm0 1 srv)
  (cmp cr0 imm0 rnil)
  (beq @get1)
  (lwz save0 0 imm0)
@get1
  (svref imm0 2 srv)
  (cmp cr0 imm0 rnil)
  (beq @get2)
  (lwz save1 0 imm0)
@get2
  (svref imm0 3 srv)
  (cmp cr0 imm0 rnil)
  (beq @get3)
  (lwz save2 0 imm0)
@get3
  (svref imm0 4 srv)
  (cmp cr0 imm0 rnil)
  (beq @get4)
  (lwz save3 0 imm0)
@get4
  (svref imm0 5 srv)
  (cmp cr0 imm0 rnil)
  (beq @get5)
  (lwz save4 0 imm0)
@get5
  (svref imm0 6 srv)
  (cmp cr0 imm0 rnil)
  (beq @get6)
  (lwz save5 0 imm0)
@get6
  (svref imm0 7 srv)
  (cmp cr0 imm0 rnil)
  (beq @get7)
  (lwz save6 0 imm0)
@get7
  (svref imm0 8 srv)
  (cmp cr0 imm0 rnil)
  (beq @got)
  (lwz save7 0 imm0)
@got

  (vpop arg_z)                          ; arglist
  (vpop temp0)                          ; function
  (vpop parent)                         ; parent
  (extract-lisptag imm0 parent)
  (cmpi cr0 imm0 ppc::tag-fixnum)
  (if (:cr0 :ne)
    ; Parent is a fake-stack-frame. Make it real
    (progn
      (svref sp %fake-stack-frame.sp parent)
      (stwu sp (- ppc::lisp-frame.size) sp)
      (svref fn %fake-stack-frame.fn parent)
      (stw fn ppc::lisp-frame.savefn sp)
      (svref temp1 %fake-stack-frame.vsp parent)
      (stw temp1 ppc::lisp-frame.savevsp sp)
      (svref temp1 %fake-stack-frame.lr parent)
      (extract-lisptag imm0 temp1)
      (cmpi cr0 imm0 ppc::tag-fixnum)
      (if (:cr0 :ne)
        ; must be a macptr encoding the actual link register
        (macptr-ptr loc-pc temp1)
        ; Fixnum is offset from start of function vector
        (progn
          (svref temp2 0 fn)        ; function vector
          (unbox-fixnum temp1 temp1)
          (add loc-pc temp2 temp1)))
      (stw loc-pc ppc::lisp-frame.savelr sp))
    ; Parent is a real stack frame
    (mr sp parent))
  (set-nargs 0)
  (bla .SPspreadargz)
  (ba .SPtfuncallgen))

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Code to determine how many tsp frames to pop.
;;; This is done by parsing the code.
;;; active-tsp-count is the entry point below.
;;;

#+ppc-target
(progn

(defstruct (branch-tree (:print-function print-branch-tree))
  first-instruction
  last-instruction
  branch-target     ; a branch-tree or nil
  fall-through)     ; a branch-tree or nil

(defun print-branch-tree (tree stream print-level)
  (declare (ignore print-level))
  (print-unreadable-object (tree stream :type t :identity t)
    (format stream "~s-~s"
            (branch-tree-first-pc tree)
            (branch-tree-last-pc tree))))

(defun branch-tree-first-pc (branch-tree)
  (let ((first (branch-tree-first-instruction branch-tree)))
    (and first (ppc-instruction-element-address first))))

(defun branch-tree-last-pc (branch-tree)
  (let ((last (branch-tree-last-instruction branch-tree)))
    (if last
      (ppc-instruction-element-address last)
      (branch-tree-first-pc branch-tree))))

(defun branch-tree-contains-pc-p (branch-tree pc)
  (<= (branch-tree-first-pc branch-tree)
      pc
      (branch-tree-last-pc branch-tree)))

(defvar *branch-tree-hash*
  (make-hash-table :test 'eq :weak :value))

(defun get-branch-tree (function)
  (or (gethash function *branch-tree-hash*)
      (let* ((dll (function-to-dll-header function))
             (tree (dll-to-branch-tree dll)))
        (setf (gethash function *branch-tree-hash*) tree))))         

; Return the number of TSP frames that will be active after throwing out
; of all the active catch frames in function at pc.
; PC is a byte address, a multiple of 4.
(defun active-tsp-count (function pc)
  (setq function
        (require-type
         (if (symbolp function)
           (symbol-function function)
           function)
         'compiled-function))
  (let* ((tree (get-branch-tree function))
         (visited nil))
    (labels ((find-pc (branch path)
               (unless (memq branch visited)
                 (push branch path)
                 (if (branch-tree-contains-pc-p branch pc)
                   path
                   (let ((target (branch-tree-branch-target branch))
                         (fall-through (branch-tree-fall-through branch)))
                     (push branch visited)
                     (if fall-through
                       (or (and target (find-pc target path))
                           (find-pc fall-through path))
                       (and target (find-pc target path))))))))
      (let* ((path (nreverse (find-pc tree nil)))
             (last-tree (car (last path)))
             (catch-count 0)
             (tsp-count 0))
        (unless path
          (error "Can't find path to pc: ~s in ~s" pc function))
        (dolist (tree path)
          (let ((next (branch-tree-first-instruction tree))
                (last (branch-tree-last-instruction tree)))
            (loop
              (when (and (eq tree last-tree)
                         (eql pc (ppc-instruction-element-address next)))
                ; If the instruction before the current one is an ff-call,
                ; then callback pushed a TSP frame.
                #| ; Not any more
                (when (ff-call-instruction-p (dll-node-pred next))
                  (incf tsp-count))
                |#
                (return))
              (multiple-value-bind (type target fall-through count) (categorize-instruction next)
                (declare (ignore target fall-through))
                (case type
                  (:tsp-push
                   (when (eql catch-count 0)
                     (incf tsp-count count)))
                  (:tsp-pop
                   (when (eql catch-count 0)
                     (decf tsp-count count)))
                  ((:catch :unwind-protect)
                   (incf catch-count))
                  (:throw
                   (decf catch-count count))))
              (when (eq next last)
                (return))
              (setq next (dll-node-succ next)))))
        tsp-count))))
        
#|  ; No longer used

; True if instr is a foreign function subprim call or a label after one.
(defun ff-call-instruction-p (instr)
  (loop
    (unless (typep instr 'ppc-lap-label) (return))
    (setq instr (dll-node-pred instr)))
  (and (typep instr 'ppc-lap-instruction)
       (let ((opcode (ppc-lap-instruction-opcode instr)))
         (and (typep opcode 'ppc::ppc-opcode)
              (equalp (ppc::ppc-opcode-name opcode) "bla")
              (memq (car (ppc-lap-instruction-parsed-operands instr))
                    '(.SPffcall .SPffcallslep .SPffcalladdress))))))

|#

(defun dll-to-branch-tree (dll)
  (let* ((hash (make-hash-table :test 'eql))    ; start-pc -> branch-tree
         (res (collect-branch-tree (dll-header-first dll) dll hash))
         (did-something nil))
    (loop
      (setq did-something nil)
      (let ((mapper #'(lambda (key value)
                        (declare (ignore key))
                        (flet ((maybe-collect (pc)
                                 (when (integerp pc)
                                   (let ((target-tree (gethash pc hash)))
                                     (if target-tree
                                       target-tree
                                       (progn
                                         (collect-branch-tree (dll-pc->instr dll pc) dll hash)
                                         (setq did-something t)
                                         nil))))))
                          (declare (dynamic-extent #'maybe-collect))
                          (let ((target-tree (maybe-collect (branch-tree-branch-target value))))
                            (when target-tree (setf (branch-tree-branch-target value) target-tree)))
                          (let ((target-tree (maybe-collect (branch-tree-fall-through value))))
                            (when target-tree (setf (branch-tree-fall-through value) target-tree)))))))
        (declare (dynamic-extent mapper))
        (maphash mapper hash))
      (unless did-something (return)))
    ; To be totally correct, we should fix up the trees containing
    ; the BLR instruction for unwind-protect cleanups, but none
    ; of the users of this code yet care that it appears that the code
    ; stops there.
    res))

(defun collect-branch-tree (instr dll hash)
  (unless (eq instr dll)
    (let ((tree (make-branch-tree :first-instruction instr))
          (pred nil)
          (next instr))
      (setf (gethash (ppc-instruction-element-address instr) hash)
            tree)
      (loop
        (when (eq next dll)
          (setf (branch-tree-last-instruction tree) pred)
          (return))
        (multiple-value-bind (type target fall-through) (categorize-instruction next)
          (case type
            (:label
             (when pred
               (setf (branch-tree-last-instruction tree) pred
                     (branch-tree-fall-through tree) (ppc-instruction-element-address next))
               (return)))
            ((:branch :catch :unwind-protect)
             (setf (branch-tree-last-instruction tree) next
                   (branch-tree-branch-target tree) target
                   (branch-tree-fall-through tree) fall-through)
             (return))))
        (setq pred next
              next (dll-node-succ next)))
      tree)))

; Returns 4 values:
; 1) type: one of :regular, :label, :branch, :catch, :unwind-protect, :throw, :tsp-push, :tsp-pop
; 2) branch target (or catch or unwind-protect cleanup)
; 3) branch-fallthrough (or catch or unwind-protect body)
; 4) Count for throw, tsp-push, tsp-pop
(defun categorize-instruction (instr)
  (etypecase instr
    (ppc-lap-label :label)
    (ppc-lap-instruction
     (let* ((opcode (ppc-lap-instruction-opcode instr))
            (opcode-p (typep opcode 'ppc::ppc-opcode))
            (name (if opcode-p (ppc::ppc-opcode-name opcode) opcode))
            (pc (ppc-lap-instruction-address instr))
            (operands (ppc-lap-instruction-parsed-operands instr)))
       (cond ((equalp name "bla")
              (let ((subprim (car operands)))
                (case subprim
                  (.SPmkunwind
                   (values :unwind-protect (+ pc 4) (+ pc 8)))
                  ((.SPmkcatch1v .SPmkcatchmv)
                   (values :catch (+ pc 4) (+ pc 8)))
                  (.SPthrow
                   (values :branch nil nil))
                  ((.SPnthrowvalues .SPnthrow1value)
                   (let* ((prev-instr (require-type (ppc-lap-instruction-pred instr)
                                                    'ppc-lap-instruction))
                          (prev-name (ppc::ppc-opcode-name (ppc-lap-instruction-opcode prev-instr)))
                          (prev-operands (ppc-lap-instruction-parsed-operands prev-instr)))
                     ; Maybe we should recognize the other possible outputs of ppc2-lwi, but I
                     ; can't imagine we'll ever see them
                     (unless (and (equalp prev-name "li")
                                  (equalp (car prev-operands) "imm0"))
                       (error "Can't determine throw count for ~s" instr))
                     (values :throw nil (+ pc 4) (ash (cadr prev-operands) (- ppc::fixnum-shift)))))
                  ((.SPprogvsave
                    .SPstack-rest-arg .SPreq-stack-rest-arg .SPstack-cons-rest-arg
                    .SPmakestackblock .SPmakestackblock0 .SPmakestacklist .SPstkgvector
                    .SPstkconslist .SPstkconslist-star
                    .SPmkstackv .SPstack-misc-alloc .SPstack-misc-alloc-init
                    .SPstkvcell0 .SPstkvcellvsp
                    .SPsave-values)
                   (values :tsp-push nil nil 1))
                  (.SPrecover-values
                   (values :tsp-pop nil nil 1))
                  (t :regular))))
             ((or (equalp name "lwz") (equalp name "addi"))
              (if (equalp (car operands) "tsp")
                (values :tsp-pop nil nil 1)
                :regular))
             ((equalp name "stwu")
              (if (equalp (car operands) "tsp")
                (values :tsp-push nil nil 1)
                :regular))
             ((member name '("ba" "blr" "bctr") :test 'equalp)
              (values :branch nil nil))
             ; It would probably be faster to determine the branch address by adding the PC and the offset.
             ((equalp name "b")
              (values :branch (branch-label-address instr (car (last operands))) nil))
             ((and opcode-p (eql (ppc::ppc-opcode-majorop opcode) 16))
              (values :branch (branch-label-address instr (car (last operands))) (+ pc 4)))
             (t :regular))))))

(defun branch-label-address (instr label-name &aux (next instr))
  (loop
    (setq next (dll-node-succ next))
    (when (eq next instr)
      (error "Couldn't find label ~s" label-name))
    (when (and (typep next 'ppc-lap-label)
               (eq (ppc-lap-label-name next) label-name))
      (return (ppc-instruction-element-address next)))))

(defun dll-pc->instr (dll pc)
  (let ((next (dll-node-succ dll)))
    (loop
      (when (eq next dll)
        (error "Couldn't find pc: ~s in ~s" pc dll))
      (when (eql (ppc-instruction-element-address next) pc)
        (return next))
      (setq next (dll-node-succ next)))))

)  ; end of #+ppc-target progn

#|
(setq *save-local-symbols* t)

(defun test (flip flop &optional bar)
  (let ((another-one t)
        (bar 'quux))
    (break)))

(test '(a b c d) #\a)

(defun closure-test (flim flam)
  (labels ((inner (x)
              (let ((ret (list x flam)))
                (break))))
    (inner flim)
    (break)))

(closure-test '(a b c) 'quux)

(defun set-test (a b)
  (break)
  (+ a b))

(set-test 1 'a)

|#


(provide 'backtrace)

; End of backtrace-lds.lisp
