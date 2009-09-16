;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 10/27/95 akh  make-uvector => make-array
;;  5 10/27/95 akh  damage control
;;  4 10/26/95 gb   not sure
;;  2 10/23/95 akh  probably no change
;;  (do not edit before this line!!)


;; L1-format.lisp
;; Copyright 1987-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-2000 Digitool, Inc.

;
; This file contains the definition for SUB-FORMAT, the dispatching part
; of FORMAT. It also contains an interim definition for FORMAT and a few
; incompletely implemented directives.

; 04/20/00 akh format-* fix when *print-circle* t
; --------- 4.3.1b1
; 08/03/99 akh sub-format checks char-code < 128 before svref
; ---------- 4.3f1c1
; 04/01/95 gb   de-lapify subformat.  (only 1.5 times as large and conses a little less.)
; 07/21/91 gb   report-bad-args good.
; 06/21/91 alice defformat makes anonymous functions saving 36 symbols
; 06/03/91 alice don't error in format-*. If someone needs an arg, she will error.
;		Also avoid bogus circle indication.
; 04/24/91 alice use stream-write-string instead of stream-tyo in sub-format
; 02/26/91 alice allow ~^
;--------------- 2.0b1
; 10/16/90 gb  no more %str-length.
; 08/16/90 bill dynamic-extent &rest args
; 06/07/90 bill in format: ensure-simple-string was called twice.
; 5/30/90 gb  Format accepts a function in lieu of a control string, returns
;             result of calling it.  [Is this correct ?]
; 4/30/90 gz  Pass the output stream around.
;04/20/90 gz  Change a cmp.w to a cmp.b in sub-format.
;12/29/89 gz  Use a vector for dispatch chars (with 30 format directives, it's
;             only a few cells larger than the alist was).
;             Modernize lap sub-format.
;12/27/89 gz   remove obsolete #-bccl conditionals.
;11/04/89 gb   sub-format - replace (eval-when (eval) ...), don't use LOOP.
;10/30/89 bill stream arg to %write-string is no longer optional.
;09/30/89 bill change pr-%print-string-n-esc to %write-string for new printer
;09/27/89 gb simple-string -> ensure-simple-string.
;04/07/89 gb  $sp8 -> $sp.
;11/02/88 gb  #\+ starts numbers as well as @\-.
; 9/11/88 gb  ~nD, hide "extra" vsp in sub-format.
; 9/2/88  gz  No more list-nreverse.
; 8/28/88 gz  ~D.
; 8/26/88 gz  don't call acons.
; 8/13/88 gb  ref specials vice magic stack offsets in sub-format.
; 8/09/88 gz  ($ #\x) -> '#\x
; 8/1/88  gb  new lap sub-format.
; 5/16/88 jaj ~* doesn't signal error when going beyond last argument
;             (which is legal if there are no more args needed)
;1/22/88 cfry ~-2% now errors [can't do negative number of newlines.
; 12/14/87 gb require lap & lapmacros (vice libfasl).
;---------------------------------Version 1.0----------------------------------
; 08/03/87 gz #-bccl on all shadowed directives. Don't uppercase pad chars.
;             ~0& is a noop.
; 07/23/87 gb #-bccl load of defformat macro, #-bccl'ed a simple ~X.
; 06/22/87 am made format accept non-simple-string control-strings.
; 06/22/87 gz #-BCCL on format.
; 06/21/87 gb try to handle (format nil ...); call CCL printer.
; 06/16/87 gz ignore decls
; 06/06/87 gb new lap lfun bits.
; 05/20/87 gb Later that same night: lap rides again (kindof)
; 05/20/87 gb Use bootstrapping sub-format until Lap rides again; make
;             it push colon-p, atsign-p in right order.
; 04/16/87 gz Accept both :@ and @:.
; 04/01/87 gz made defformat take the fn name.
;             instance of format-pop-arg -> pop-format-arg
;             change handling of *format-index* in sub-format to be like CCL.
; 02/03/87 gz new file


(eval-when (eval compile #-bccl load)  ;Load-time as well so CCL can use it.
  (defmacro defformat (char name &rest def)
    `(progn
       (add-format-char ,char (function (lambda . ,def)))
       ',name))
  )

(defparameter *format-char-table* (make-array 128 :initial-element nil))

(defun add-format-char (char def)
  (unless (and (characterp char) (%i< (%char-code char) 128))
    (report-bad-arg char 'standard-char))
  (setf (svref *format-char-table* (%char-code (char-upcase char))) def))

(proclaim '(special *format-original-arguments*   ;For ~*
                    *format-arguments*            ;For pop-format-arg
                    *format-control-string*       ;For ~?, ~{
                    *format-index*
                    *format-length*))

(defun pop-format-arg (&aux (args *format-arguments*))
  (if (null args)
      (format-error "Missing argument"))
    (progn
     (setq *format-arguments* (cdr args))
     (%car args)))
 
;SUB-FORMAT parses (a range of) the control string, finding the directives
;and applying them to their parameters.
;Implicit arguments to SUB-FORMAT: *format-control-string*, *format-arguments*,
;*format-original-arguments*, *standard-output*, *format-char-table*
;*format-control-string* must be a simple string.
;Directive functions' arglist should be (colon-p atsign-p &rest params)
;In addition when the directive is called, *format-index* and *format-length*
;are bound to start and end pos (in *format-control-string*) of the rest of the
; control string.  The directive may modify *format-index*, but not
; *format-control-string* and *format-length*, before returning.

(defun sub-format (stream *format-index* *format-length* &aux (string *format-control-string*) char)
  (prog* ((length *format-length*) (i *format-index*) (lastpos i))
    (declare (fixnum i length lastpos))
    (go START)
    EOF-ERROR
    (setq *format-index* *format-length*)
    (format-error "Premature end of control string")
    START
    (do* ()
         ((= i length) (unless (= i lastpos) 
                         (stream-write-string stream string lastpos i)))
      (setq char (schar string i) i (1+ i))
      (when (eq char #\~)
        (let* ((limit (the fixnum (1- i))))
          (unless (= limit lastpos) 
            (stream-write-string stream string lastpos limit)))
        (let ((params nil) (fn) (colon nil) (atsign nil))
          (block nil
            (tagbody
              NEXT
              (if (= i length) (go EOF-ERROR))
              (setq char (schar string i) i (1+ i))
              (cond ((eq char #\#)
                     (push (list-length *format-arguments*) params))
                    ((eq char #\')
                     (if (= i length) (go EOF-ERROR))
                     (push (schar string i) params)
                     (incf i))
                    ((eq char #\,)
                     (push nil params)
                     (go NEXT))
                    ((or (eq char #\V) (eq char #\v))
                     (push (pop-format-arg) params))
                    ((or (eq char #\-) (digit-char-p char))
                     (let ((start (%i- i 1)) n)
                       (loop
                         (when (= i length) (go EOF-ERROR))
                         (unless (digit-char-p (schar string i)) (return))
                         (incf i))
                       (when (null (setq n (%parse-number-token string start i)))
                         (setq *format-index* i)
                         (format-error "Illegal parameter"))
                       (push n params)))
                    (t (return)))
              (if (= i length) (go EOF-ERROR))
              (setq char (schar string i) i (1+ i))
              (when (neq char #\,) (return))
              (go NEXT)))
          (cond ((eq char #\:) 
                 (if (= i length) (go EOF-ERROR))
                 (setq colon t char (schar string i) i (1+ i))
                 (when (eq char #\@)
                   (if (= i length) (go EOF-ERROR))                     
                   (setq atsign t char (schar string i) i (1+ i))))
                ((eq char #\@)
                 (if (= i length) (go EOF-ERROR))
                 (setq atsign t char (schar string i) i (1+ i))
                 (when (eq char #\:)
                   (if (= i length) (go EOF-ERROR))
                   (setq colon t char (schar string i) i (1+ i)))))
          (setq *format-index* (%i- i 1))
          (let ((code (%char-code (char-upcase char))))
            (if (and (< code 128)(setq fn (svref *format-char-table* code)))
              (apply fn stream colon atsign (nreverse params))
              (format-error "Unknown directive")))
          (setq i (%i+ *format-index* 1)
                lastpos i))))))


#|
(eval-when (load)
  ;The non-consing version.
(defun sub-format (stream *format-index* *format-length*)
  (declare (special *format-index* *format-length*))
  (old-lap-inline (stream)
    (preserve_regs #(asave0 asave1 dsave0 dsave1 dsave2))
    (defreg Control-string asave0 Index dsave0 Length dsave1 NumParams dsave2 Stream asave1)
    (move.l acc Stream)
    (move.l (special *format-index*) Index)       ; *format-index*
    (move.l (special *format-length*) Length)      ; *format-length*
    (specref *format-control-string*)
    (move.l acc Control-string)

    ;Make sure everything is in bounds, so don't have to worry about
    ;boxing, bounds checking, etc.
start
    (movereg Control-string arg_z)
    (jsr_subprim $sp-length)
    (ccall <= '0 Index Length acc)
    (cmp.l nilreg acc)
    (beq done)
    (move.l Index db)
    (loop#
      (if# (eq Length Index)
        (cmp.l db Index)
        (beq done)
        (ccall 'stream-write-string Stream Control-string db Index)
        (bra done))
      (move.l Index da)
      (getint da)
      (move.l ($ $t_imm_char 0) acc)
      (move.b (Control-string da.l $v_data) acc)
      (add.l (fixnum 1) Index)
      (cmp.b ($ #\~) acc)
      (beq tilde))

nextchar
    (if# (eq Length Index)
      (move.l '"Premature end of format control string" arg_z)
      (add.w ($ 4) sp)                  ; flush internal bsr.
      (bra error))
    (move.l Index da)
    (getint da)
    (move.b (Control-string da.l $v_data) acc)
    (add.l (fixnum 1) Index)
    (if# (and (ge (cmp.b ($ #\a) acc)) (le (cmp.b ($ #\z) acc)))
      (sub.b ($ 32) acc))
    (rts)

tilde
    (move.l Index da)
    (sub.l (fixnum 1) da)
    (if# (not (eq da db))      
      (ccall 'stream-write-string Stream Control-string db da))
    (vpush Stream)
    (vpush nilreg)             ;assume no :
    (vpush nilreg)             ;assume no @
    (move.l (fixnum 3) NumParams)
do-param
    (bsr nextchar)
    (if# (or (eq (cmp.b ($ #\+) acc))
             (eq (cmp.b ($ #\-) acc))
             (and (ge (cmp.b ($ #\0) acc)) (le (cmp.b ($ #\9) acc))))
      (move.l Index da)
      (sub.l (fixnum 1) da)
      (vpush da)
      (prog#
       (bsr nextchar)
       (until# (or (lt (cmp.b ($ #\0) acc)) (gt (cmp.b ($ #\9) acc)))))
      (sub.l (fixnum 1) Index)   ;unread the non-digit char
      (ccall %parse-number-token Control-string vsp@+ Index)
      (cmp.l nilreg acc)
      (bne push-param)
      (move.l '"Illegal format parameter" arg_z)
      (bra error))

    (if# (eq (cmp.b ($ #\#) acc))
      (move.l (special *format-arguments*) acc)
      (jsr_subprim $sp-length)
      (bra push-param))

    (if# (eq (cmp.b ($ #\') acc))
      (bsr nextchar)
      (move.l ($ $t_imm_char 0) acc)
      (move.b (Control-string da.l $v_data) acc)  ;Get the non-uppercased version...
      (swap acc)
      (bra push-param))

    (if# (eq (cmp.b ($ #\,) acc))
      (sub.l (fixnum 1) Index)   ;Re-read the comma.
      (move.l nilreg acc)
      (bra push-param))

    (if# (eq (cmp.b ($ #\V) acc))
      (ccall 'pop-format-arg)
      ;(bra push-param)
     push-param
      (vpush acc)
      (add.l (fixnum 1) NumParams)
      (bsr nextchar)
      (cmp.b ($ #\,) acc)
      (beq do-param))

    (move.l NumParams nargs)
    (vscale.l nargs)
    (cmp.b ($ #\:) acc)
    (if# eq
      (bsr nextchar)
      (cmp.b ($ #\@) acc)
      (bne @a)
      (move.l (a5 $t) (vsp nargs.w -12))
     else#
      (cmp.b ($ #\@) acc)
      (bne @b)
      (move.l (a5 $t) (vsp nargs.w -12))
      (bsr nextchar)
      (cmp.b ($ #\:) acc)
      (bne @b))
    (bsr nextchar)
@a  (move.l (a5 $t) (vsp nargs.w -8))
@b  (moveq 127 da)
    (and.w acc da)
    (bif (ne (cmp.b da acc)) nofun)
    (lsl.w 2 da)
    (move.l (special *format-char-table*) atemp0)
    (move.l (atemp0 da.w $v_data) atemp0)
    (cmp.l atemp0 nilreg)
    (beq nofun)
    (move.l Index da)
    (sub.l (fixnum 1) da)
    (move.l da (special *format-index*))
    (move.l NumParams nargs)
    (vscale.l nargs)                    ; at least 3 args.
    (movem.l vsp@+ #(arg_z arg_y arg_x))
    (jsr_subprim $sp-funcall)
    (specref '*format-index*)
    (add.l (fixnum 1) acc)
    (move.l acc Index)
    (bra start)

nofun
    (move.l '"Unknown format directive" acc)
error
    (move.l Index (special *format-index*))
    (fsymevalapply 'format-error 1)

done
    (restore_regs)
    ))
) ;end of eval-when (load)

|#

;Interim definitions

;This function is shadowed by CCL in order to use ~{ to print error messages.
(defun format (stream control-string &rest format-arguments)
  (declare (dynamic-extent format-arguments))
  (when (eq stream t) (setq stream *standard-output*))
  (when (null stream)
   (return-from format 
    (with-output-to-string (x)
     (apply #'format x control-string format-arguments))))
  (unless (streamp stream) (report-bad-arg stream 'stream))
  (if (functionp control-string)
    (apply control-string stream format-arguments)
    (progn
      (setq control-string (ensure-simple-string control-string))
      (let* ((*format-original-arguments* format-arguments)
             (*format-arguments* format-arguments)
             (*format-control-string* control-string))
        (catch 'format-escape
         (sub-format stream 0 (length control-string)))
        nil))))

(defun format-error (&rest args)
   (format t "~&FORMAT error at position ~A in control string ~S "
             *format-index* *format-control-string*)
   (apply #'error args))

(defun format-no-flags (colon atsign)
  (when (or colon atsign) (format-error "Flags not allowed")))

;Redefined later
(defformat #\A format-a (stream colon atsign)
   (declare (ignore colon atsign))
   (princ (pop-format-arg) stream))

;Redefined later
(defformat #\S format-s (stream colon atsign)
  (declare (ignore colon atsign))
  (prin1 (pop-format-arg) stream))

;Redefined later
(defformat #\^ format-escape (stream colon atsign)
  (declare (ignore stream colon atsign))
  (throw 'format-escape t))

;Final version
(defformat #\% format-% (stream colon atsign &optional repeat-count)
  (cond ((or (not repeat-count)
            (and repeat-count (fixnump repeat-count)
                 (> repeat-count -1)))
         (format-no-flags colon atsign)
         (dotimes (i (or repeat-count 1)) (declare (fixnum i)) (terpri stream)))
        (t (format-error "Bad repeat-count."))))

;Final version
(defformat #\& format-& (stream colon atsign &optional repeat-count)
  (format-no-flags colon atsign)
  (unless (eq repeat-count 0)
    (fresh-line stream)
    (dotimes (i (1- (or repeat-count 1))) (declare (fixnum i)) (terpri stream))))

;Final version
(defformat #\~ format-~ (stream colon atsign &optional repeat-count)
  (format-no-flags colon atsign)
  (dotimes (i (or repeat-count 1)) (declare (fixnum i)) (stream-tyo stream #\~)))

;Final version
(defformat #\P format-p (stream colon atsign)
  (when colon
     (let ((end *format-arguments*) (list *format-original-arguments*))
        (tagbody loop
           (if list
             (when (neq (cdr list) end)
               (setq list (%cdr list))
               (go loop))
             (format-error "No previous argument")))
        (setq *format-arguments* list)))
   (%write-string (if (eq (pop-format-arg) 1)
                    (if atsign "y" "")
                    (if atsign "ies" "s"))
                  stream))

;Final version
(defformat #\* format-* (stream colon atsign &optional count)
  (declare (ignore stream)(special *circularity-hash-table*))
  (let* ((orig *format-original-arguments*)
         (where (- (list-length orig)   ; will error if args circular
                   (list-length *format-arguments*)))
         (to (if atsign 
               (or count 0) ; absolute
               (progn
                 (when (null count)(setq count 1))
                 (when colon (setq count (- count)))
                 (%i+ where count))))
         (args (nthcdr-no-overflow to orig)))
    ; avoid bogus circularity indication
    (when (and (consp args) (<= to where) *circularity-hash-table*)
      ; copy only from to thru where in case  some real shared structure
      (let ((l args) new)
        (dotimes (i (1+  (- where to)))
          (declare (fixnum i))
          (push (car l) new)
          (setq l (cdr l))
          (when (null l)(return))) ;; <<
        (setq args (nreconc new (nthcdr (1+ where) orig))))) ;(copy-list args)))
    ;(when (eq args :error) (format-error "Can't go to non-existent argument"))
    (setq *format-arguments* args)))

; Redefined later.
(defformat #\NewLine format-newline (&rest ignore)
  (declare (ignore ignore))
  (do* ((i *format-index* (1+ i))
        (s *format-control-string*)
        (n *format-length*))
       ((or (= i n)
            (not (whitespacep (schar s i))))
        (setq *format-index* (1- i)))))
        
(defun nthcdr-no-overflow (count list)
  "If cdr beyond end of list return :error"  
  (if (or (> count (list-length list)) (< count 0))
    nil ;:error
    (nthcdr count list)))

;Redefined later
(defformat #\X format-x (stream colon atsign)
  (declare (ignore colon atsign))
  (let* ((*print-base* 16.)
         (*print-radix* nil))
    (prin1 (pop-format-arg) stream)))

;Redefined later
(defformat #\D format-d (stream colon atsign &rest ignore)
  (declare (ignore colon atsign ignore))
  (let* ((*print-base* 10.)
         (*print-radix* nil))
    (prin1 (pop-format-arg) stream)))
