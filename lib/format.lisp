;;; -*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  7 9/13/96  akh  merge with 3.1 version
;;  6 7/18/96  akh  float-string - faster, conses less (don't expect miracles)
;;  4 6/7/96   akh  float-string stuff
;;  3 5/20/96  akh  flonum-to-string - use integer-length vs bogus precision calculation cause we don't have short floats
;;                  float-string - some optimizations re 10-to-e
;;                  #. some require-type thing
;;  4 6/1/95   akh  format-fixed-aux - scale was off by 1 in d and no w case
;;  3 5/30/95  akh  format fixed aux, dont mess with width if d > w - just let it be
;;  2 5/26/95  akh  fix a bunch of bugs in float printing especially in exp aux-  dont ignore d if w is nil.
;;                  use float sign instead of minusp for -0.0
;;  4 3/2/95   akh  say element-type 'base-character
;;  3 1/30/95  akh  format-print-number conses less - from patch
;;  (do not edit before this line!!)

;; Copyright 1986-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-2000 Digitool, Inc.

;;; Functions to implement FORMAT.
;;;

(in-package "CCL")

; Modification History
; 06/08/2004 ss defformat #\linefeed so that tilde-linefeed works the same as tilde-return (fix suggested by gb)
;;; -------- 5.1b1
; format-fixed-aux and format-exp-aux less likely to prin1 when w and d are nil - see format-digits-limit
; flonum-to-string don't error if nan or infinity, format-fixed-aux etal just print nan or infinity normally
;; --------- 4.4b4
; 09/05/01 akh see float-string ?? fix ~1f looping forever
; 07/16/99 akh don't specify type to make-string-output-stream
; ---------- 4.3f1c1
; 07/18/98 format-fixed-aux for -0.0
;
; akh 10-to-e vs (expt 10 e) in float-string
; akh #.char-code-limit, flonum-to-string get precision from integer-length vs type
; 5/15/96 slh   format-print-number: check for missing quote for padchar
;01/25/95 slh   format-write-field: allow nil mincol, so (format nil "~f" nil) works
;-------------- 2.1d16
;03/31/93 bill  float-string can now generate an empty string first value.
;               e.g. (format nil "~,2f" 0.003) now returns "0.00", not "0.003"
;-------------- 2.1d5
;02/21/93 alice flonum-to-string binds *print-radix* nil
;02/19/93 bill  fix error message in format-print-old-roman & format-print-roman
;02/11/93 bill  (format nil "DURATION:  ~5,,,'?f sec" 0.09786848072562358) no longer
;               prints 5 question marks for the number.
;01/11/92 bill  *format-string-output-stream* - with-string-output-stream.
;               Makes the code work with multiple processes.
;12/16/92 bill  format-print-number no longer conses
;08/15/92 alice fix format-print-number for mincol, padchar neq #\space, and comma char or interval
; ------------- 2.0
;11/26/91 alice tweak float-string for 1e23
;12/10/91 gb    gratuitous fixnum declaration.
;------------- 2.0b4
;11/21/91 alice format-exp-aux dont die if fwidth nil, always check exp.
;	 #\g dont default ovf and use the right metric for number of digits
;11/16/91 alice dont call flonum-to-string with negative width
;11/11/91 gb    call the function GET-XP-STREAM in logical-block-sub.
;11/11/91 alice lets make format-exp-aux work for numbers less than 1
;11/11/91 alice format-exp-aux adjust spaceleft if exponent changes due to round up
;11/08/91 alice scale-exponent just returns the exponent since thats all we use
;11/07/91 alice flonum-to-string - just does the digits - no dots no zeros no nothing
;	  remove bogosity from format-exp-aux. all guys use new flonum-to-string
;10/05/91 alice ~( if pretty omitted a NIL
;------------- 2.0b3
;09/04/91 bill remove force-output from format
;07/21/91 gb  wimpy defconstants.
;06/25/91 akh shrink format-do-iteration, catch some illegal usages within normal ~<~>
;06/17/91 akh (sort of) fix format-character
;06/05/91 akh teach format capitalization about xp so nested blocks & capitalizations will work
;06/01/91 akh allow @: in addition to :@
;05/30/91 akh ~n@* in ~{ ~} was wrong for ~@{ case
;05/30/91 akh ~{ with no : or @ didn't do ~^ correctly (since forever)
;05/30/91 akh make ~? and ~{~:} take a function
;05/30/91 alice don't use short floats internally cause of machines without fpu & loss of precision
;05/22/91 akh no more char=, member=>memq, etc
;05/22/91 akh use %str-member instead of find (doesn't make much difference)
;------------- 2.0b2 (sort of)
;05/22/91 bill GB's fix to scale-exponent & format-dollars
;05/20/91 gb  short-float printing.
;05/20/91 akh add XP stuff (carefully)
;05/20/91 akh call stream-write-string using length
;05/09/91 akh write-char => stream-tyo etc.
;05/08/91 akh ~/ make : and :: equivalent (idiocy in CLtL2)
;04/29/91 akh add ~/ = call function
;03/04/91 akh give report-bad-arg a second arg. 
; ------------- 2.0b1
;01/28/91 akh format-print-number - heed provided commachar and interval even if no colon
;01/17/91 akh remaining problems scale-exponent fails for extremes, format-general-aux is still screwy
;             format-exp-aux louses up the number (by calling scale-exponent which does the dirty deed)
;01/17/91 akh float-string optionally dont return leading and trailing zeros, do tell me how many leading 0's
;01/15/91 akh format-general-aux - try not to print 101 digits, format-exponential dont default e to 1
;01/15/91 akh float-string - cut consing in half by taking loop invariant ceiling out of loop, and another hack
;             and some more tweaks to make consing bearable
;01/14/91 akh format-fixed-aux, format-exp-aux, call prin1 again when no w,d
;;; ---------------- 2.0a5 (d83)
;01/08/91 akh parse-format-operation - return the parameters in the right order (i.e. nreverse em)
;01/07/91 akh FLOAT-STRING fix if fmin but no fdigits, take sign, FLONUM-TO-STRINGt take signp
;01/01/91 gb  resident decl in float-string.
;11/06/90 gb  new format-eat-whitespace. Macro NEXTCHAR -> function FORMAT-NEXTCHAR,
;             macro FORMAT-PEEK -> function.
;09/06/90 akh fix ~G & ~E to not bomb on negative number and  w = nil
;08/16/90 bill *format-string-output-stream* to reduce consing.
;              dynamic-extent rest args:  what a concept.
;07/26/90 akh make format float always be pretty (better solution is to fix prin1)
;07/23/90 gb  compiler bug allegedly fixed now.
;07/10/90 akh fix ~:{  with ~:^
;07/10/90 akh format-capitalize pass the format-escape throw onward
;07/05/90 akh make format-find-command skip to avoid bugs and consing, optionally get params
;07/03/90 akh fix blecherous bug in format-find-command, fix format-get-segments
;06/07/90 bill Format accespt a string as output stream again.
;05/20/90 gb  Format accepts function vice format string, ~V & ~{ should as well.
;05/12/90 gb  flush *digits* as well.
;05/04/90 alms fixed format-capitalization
;04/28/90 gb  support commainterval in format-print-number, per FORMAT-COMMA-INTERVAL.
;05/01/90 gz  Don't bind *standard-output*.
;             Don't use *digit-string*, cons a new string each time in
;             flonum-to-string.  Note it conses bignums all over the place anyhow.
;02/20/90 mly ~? fix.
;12/29/89 gz  Bind *print-escape* to nil in format-print-number, per
;             FORMAT-PRETTY-PRINT.
;10/12/89 as  don't bind print-pretty/nil
; 3/16/89 gz (ask stream (stream-line-length -> (stream-line-length stream
; 03/15/89 gb  invert error message args in format-justification,
; 13-Feb-89 Mly fix bugs in format-print-number.  Flush format-add-commas.
;               This code is REVOLTING!
; 9/23/88 gb   fix type specifiers in format-write-field, format-justification.
; 9/8/88  gb   (re)defconstant compile-time constants.
; 8/10/88 gz   format-*.lisp -> format.lisp, flushed pre-1.0 edit history.
; 5/26/88 jaj  fix in ~s for "()"
; 5/20/88 jaj  in ~a and ~s print nil according to *print-case*
;              ~$ handles non-floats
; 5/16/88 jaj  the true clause is now optional form ~:[.  format-do-iteration
;              properly exits with ~{ (no colon or atsign) and ~^. fixed
;              format-round-columns. padchar may be a fixnum
;              format-add-commas fixed for negative numbers
; 5/12/88 jaj  added quintillion to large numbers list
;1/22/88 cfry format with illegal destination now errors.
; 1/18/88 cfry fixed format-capitalization
; 12/30/87 cfry fixed format-exp-aux to not print trailing zero after
;           decimal point unless the number itself is zero. See CLtL p 393

(eval-when (:compile-toplevel :execute)
  (require "NUMBER-MACROS"))

;;; Special variables local to FORMAT
;;; why do these have top-level bindings ????? - seems wrong or at least unnecessary

(defvar *format-control-string* ""
  "The current FORMAT control string")

(defvar *format-index* 0
  "The current index into *format-control-string*")

(defvar *format-length* 0
  "The length of the current FORMAT control string")

(defvar *format-arguments* ()
  "Arguments to the current call of FORMAT")

(defvar *format-original-arguments* ()
 "Saved arglist from top-level FORMAT call for ~* and ~@*")

(defvar *format-stream-stack* ()
  "A stack of string streams for collecting FORMAT output")

; prevent circle checking rest args. Really EVIL when dynamic-extent
(defvar *format-top-level* nil)

;;; Specials imported from ERRORFUNS

(declaim (special *error-output*))

;;; ERRORS

;;; Since errors may occur while an indirect control string is being
;;; processed, i.e. by ~? or ~{~:}, some sort of backtrace is necessary
;;; in order to indicate the location in the control string where the
;;; error was detected.  To this end, errors detected by format are
;;; signalled by throwing a list of the form ((control-string args))
;;; to the tag FORMAT-ERROR.  This throw will be caught at each level
;;; of indirection, and the list of error messages re-thrown with an
;;; additional message indicating that indirection was present CONSed
;;; onto it.  Ultimately, the last throw will be caught by the top level
;;; FORMAT function, which will then signal an error to the Slisp error
;;; system in such a way that all the errror messages will be displayed
;;; in reverse order.

(defun format-error (complaint &rest args)
  (throw 'format-error
         (list (list "~1{~:}~%~S~%~V@T^" complaint args
                    *format-control-string* (1+ *format-index*)))))


;;; MACROS

;;; This macro establishes the correct environment for processing
;;; an indirect control string.  CONTROL-STRING is the string to
;;; process, and FORMS are the forms to do the processing.  They 
;;; invariably will involve a call to SUB-FORMAT.  CONTROL-STRING
;;; is guaranteed to be evaluated exactly once.
(eval-when (compile eval #-bccl load)

; does this need to exist?????
#| ; put it out of its misery
(defmacro format-with-control-string (control-string &rest forms)
  `(let ((string (if (simple-string-p ,control-string)
                     ,control-string
                     (coerce ,control-string 'simple-base-string))))
        (declare (simple-string string))
        (let ((error (catch 'format-error
                            (let ((*format-control-string* string)
                                  (*format-length* (length string))
                                  (*format-index* 0))
                                 ,@forms
                                 nil))))
          
             (when error
                   (throw 'format-error
                          (cons (list "While processing indirect control string~%~S~%~V@T^"
                                      *format-control-string*
                                      (1+ *format-index*))
                                error))))))
|#
(defmacro format-indirect-error (error)
  `(throw 'format-error
         (cons (list "While processing indirect control string~%~S~%~V@T^"
                     *format-control-string*
                     (1+ *format-index*))
               ,error)))


(defmacro get-a-format-string-stream ()
  '(or (pop *format-stream-stack*) (make-string-output-stream))) ; ??

;;; This macro rebinds collects output to the standard output stream
;;; in a string.  For efficiency, we avoid consing a new stream on
;;; every call.  A stack of string streams is maintained in order to
;;; guarantee re-entrancy.

(defmacro with-format-string-output (stream-sym &rest forms)
  `(let ((,stream-sym nil))
     (unwind-protect
       (progn
         (setq ,stream-sym (get-a-format-string-stream))
         ,@forms
         (prog1
           (get-output-stream-string ,stream-sym)
           (push ,stream-sym *format-stream-stack*)))
       (when ,stream-sym (stream-position ,stream-sym 0)))))

;;; This macro decomposes the argument list returned by PARSE-FORMAT-OPERATION.
;;; PARMVAR is the list of parameters.  PARMDEFS is a list of lists of the form
;;; (<var> <default>).  The FORMS are evaluated in an environment where each 
;;; <var> is bound to either the value of the parameter supplied in the 
;;; parameter list, or to its <default> value if the parameter was omitted or
;;; explicitly defaulted.

(defmacro with-format-parameters (parmvar parmdefs &body  body &environment env)
  (do ((parmdefs parmdefs (cdr parmdefs))
       (bindings () (cons `(,(caar parmdefs) (or (if ,parmvar (pop ,parmvar))
                                                 ,(cadar parmdefs)))
                          bindings)))
      ((null parmdefs)
       (multiple-value-bind (forms decls) (parse-body body env)
         `(let ,(nreverse bindings)
            ,@decls
            (when ,parmvar
              (format-error "Too many parameters"))
            ,@forms)))))



;;; Returns the index of the first occurrence of the specified character
;;; between indices START (inclusive) and END (exclusive) in the control
;;; string.


(defmacro format-find-char (char start end)
  `(%str-member  ,char *format-control-string*
                   ,start ,end))


) ;end of eval-when for macros

;;; CONTROL STRING PARSING 

;;; The current control string is kept in *format-control-string*. 
;;; The variable *format-index* is the position of the last character
;;; processed, indexing from zero.  The variable *format-length* is the
;;; length of the control string, which is one greater than the maximum
;;; value of *format-index*.  


;;; Gets the next character from the current control string.  It is an
;;; error if there is none.  Leave *format-index* pointing to the
;;; character returned.

(defun format-nextchar ()
  (let ((index (%i+ 1 *format-index*)))    
    (if (%i< (setq *format-index* index) *format-length*)
      (schar *format-control-string* index)
      (format-error "Syntax error"))))



;;; Returns the current character, i.e. the one pointed to by *format-index*.

(defmacro format-peek ()
  `(schar *format-control-string* *format-index*))




;;; Attempts to parse a parameter, starting at the current index.
;;; Returns the value of the parameter, or NIL if none is found. 
;;; On exit, *format-index* points to the first character which is
;;; not a part of the recognized parameter.

(defun format-get-parameter (ch)
  "Might someday want to add proper format error checking for negative 
      parameters"
  (let (neg-parm)
    (when (eq ch #\-)(setq neg-parm ch)
          (setq ch (format-nextchar)))
    (case ch
      (#\# (format-nextchar) (length *format-arguments*))
      ((#\V #\v)
       (prog1 (pop-format-arg) (format-nextchar)))
      (#\' (prog1 (format-nextchar) (format-nextchar)))
      (t (cond ((setq ch (digit-char-p ch))
                (do ((number ch (%i+ ch (%i* number 10))))
                    ((not (setq ch (digit-char-p (format-nextchar))))
                     (if neg-parm (- number) number))))
               (t nil))))))

(defun format-skip-parameter (ch) ; only caller is parse-format-operation
  "Might someday want to add proper format error checking for negative 
      parameters"
  (let ()
    (case ch
      ((#\V #\v #\#)
       (format-nextchar))
      (#\' (format-nextchar) (format-nextchar))
      (#\,)
      (t (cond (T ;(or (eq ch #\-)(digit-char-p ch)) ; t
                (while (digit-char-p (format-nextchar))))
               (t nil))))))


;;; Parses a format directive, including flags and parameters.  On entry,
;;; *format-index* should point to the "~" preceding the command.  On
;;; exit, *format-index* points to the command character itself.
;;; Returns the list of parameters, the ":" flag, the "@" flag, and the
;;; command character as multiple values.  Explicitly defaulted parameters
;;; appear in the list of parameters as NIL.  Omitted parameters are simply 
;;; not included in the list at all.

(defun parse-format-operation (&optional get-params) ; only caller is format-find-command
  (let ((ch (format-nextchar)) parms colon atsign)
    (when (or (digit-char-p ch)
              ;(%str-member ch ",#Vv'"))
              (memq ch '(#\- #\, #\# #\V #\v #\')))      
      (cond (get-params
             (setq parms (list (format-get-parameter ch)))
             (until (neq (setq ch (format-peek)) #\,)
               (setq ch (format-nextchar))
               (push (format-get-parameter ch) parms)))
            (t (setq parms t)  ; tell caller there were some so we get correct error msgs
               (format-skip-parameter ch)
               (until (neq (setq ch (format-peek)) #\,)
                 (setq ch (format-nextchar))
                 (format-skip-parameter ch)))))
    ; allow either order - (also allows :: or @@)
    (case ch
      (#\: (setq colon t))
      (#\@ (setq atsign t)))
    (when (or colon atsign)
      (case (setq ch (format-nextchar))
        (#\: (setq colon t)
         (setq ch (format-nextchar)))
        (#\@ (setq atsign t)
         (setq ch (format-nextchar)))))
    (values (if (consp parms) (nreverse parms) parms)
            colon
            atsign
            ch)))


;;; Starting at the current value of *format-index*, finds the first
;;; occurrence of one of the specified directives. Embedded constructs,
;;; i.e. those inside ~(~), ~[~], ~{~}, or ~<~>, are ignored.  And error is
;;; signalled if no satisfactory command is found.  Otherwise, the
;;; following are returned as multiple values:
;;;
;;;     The value of *format-index* at the start of the search
;;;     The index of the "~" character preceding the command
;;;     The parameter list of the command
;;;     The ":" flag
;;;     The "@" flag
;;;     The command character
;;;
;;; Implementation note:  The present implementation is not particulary
;;; careful with storage allocation.  It would be a good idea to have
;;; a separate function for skipping embedded constructs which did not
;;; bother to cons parameter lists and then throw them away. This issue has been addressed. (akh)
;;;
;;; We go to some trouble here to use POSITION for most of the searching.
;;; God only knows why!!!!

;; and interesting note - the only caller who wants parameters is format-get-segments for
;; ~< .... ~n:; ...~>
(defun format-find-command (command-list &optional get-params evil-commands)
  (let* ((start *format-index*)
         (length *format-length*)
         tilde)
    (loop
      (setq tilde (format-find-char #\~ *format-index* length))
      (if (not tilde) (format-error "Expecting one of ~S" command-list))
      (setq *format-index* tilde)
      (multiple-value-bind (parms colon atsign command)
                           (parse-format-operation get-params)
        (when (memq command command-list)
          (return (values start tilde parms colon atsign command)))
        (when (and evil-commands (memq command  '(#\w #\_ #\i #\W #\I)))
          (format-error "Illegal in this context"))
        (case command
          (#\{ (format-nextchar)(format-find-command '(#\})))
          (#\< (format-nextchar)(format-find-command '(#\>)))
          (#\( (format-nextchar)(format-find-command '(#\))))
          (#\[ (format-nextchar)(format-find-command '(#\])))
          ((#\} #\> #\) #\])
           (format-error "No matching bracket")))))))

;;; This is the FORMAT top-level function.

(defun format (stream control-string &rest format-arguments)
  (declare (dynamic-extent format-arguments))
  (if (or (null stream) (stringp stream))
    (with-string-output-stream (output-stream)
      (let (old-string)
        (unwind-protect
          (progn
            (when stream
              (setq old-string (slot-value output-stream 'my-string)) 
              (setf (string-output-stream-string output-stream) stream))
            (apply #'format output-stream control-string format-arguments)
            (unless stream
              (get-output-stream-string output-stream)))
          (when old-string
            (setf (slot-value output-stream 'my-string) old-string)))))
    (let ((*format-top-level* t))
      (when (xp-structure-p stream)(setq stream (xp-stream-stream stream))) ; for xp tests only! They call format on a structure
      (setq stream (if (eq stream t)
                     *standard-output*
                     (require-type stream 'stream)))     
      (if (functionp control-string)
        (apply control-string stream format-arguments)
        (let ((*format-control-string* (ensure-simple-string control-string)))          
          (cond
           ((and (or *print-pretty* *print-circle*)
                 (not (typep stream 'xp-stream)))
            (maybe-initiate-xp-printing
             #'(lambda (s o)
                 (do-sub-format-1 s o))
                 stream format-arguments))
           (t 
            (let ((*format-original-arguments* format-arguments)
                  (*format-arguments* format-arguments)
                  (*format-colon-rest* 'error)) ; what should this be??
              (declare (special *format-original-arguments* *format-arguments*
                                *format-control-string* *format-colon-rest*))
              (do-sub-format stream))))))
      nil)))

(defun do-sub-format (stream)
  (let (errorp)
    (setq errorp
          (catch 'format-error
            (catch 'format-escape 
              (sub-format stream 0 (length *format-control-string*)))
            nil))    
    (when errorp
      (error "~%~:{~@?~%~}" (nreverse errorp)))))

;;; This function does the real work of format.  The segment of the control
;;; string between indiced START (inclusive) and END (exclusive) is processed
;;; as follows: Text not part of a directive is output without further
;;; processing.  Directives are parsed along with their parameters and flags,
;;; and the appropriate handlers invoked with the arguments COLON, ATSIGN, and
;;; PARMS. 
;;;

;;; POP-FORMAT-ARG also defined in l1-format

; in l1-format
(defvar *logical-block-xp* nil)
(defun pop-format-arg (&aux (args *format-arguments*)(xp *logical-block-xp*))
  (when xp
    (if (pprint-pop-check+ args xp) ; gets us level and length stuff in logical block
      (throw 'logical-block nil)))           
  (if (and (null args)(null xp)) ; what if its 3?
      (format-error "Missing argument")
    (progn
     (setq *format-arguments* (cdr args))
     (%car args))))

; SUB-FORMAT is now defined in L1-format.lisp
; DEFFORMAT is also defined there.

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; pretty-printing stuff
;;; 

(defformat #\W format-write (stream colon atsign)
  (let ((arg (pop-format-arg)))
    (cond (atsign
       (let ((*print-level* nil)
             (*print-length* nil))
         (if colon
           (let ((*print-pretty* t))
             (write-1 arg stream))
           (write-1 arg stream))))
      (t (if colon
           (let ((*print-pretty* t))
             (write-1 arg stream))
           (write-1 arg stream))))))

(defformat #\I format-indent (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (declare (ignore atsign))
  (with-format-parameters parms ((n 0))
    (pprint-indent (if colon :current :block) n stream)))

(defformat #\_ format-conditional-newline (stream colon atsign)
  (let ((option
         (cond (atsign
                (cond (colon  :mandatory)
                      (t :miser)))
               (colon :fill)
               (t :linear))))
    (pprint-newline option stream)))

;;; Tabulation  ~T 

(defformat #\T format-tab (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (with-format-parameters parms ((colnum 1) (colinc 1))
    (cond ((or (typep stream 'xp-stream)(xp-structure-p stream))
           (let ((which
                  (if colon
                    (if atsign :section-relative :section)
                    (if atsign :line-relative :line))))
             (pprint-tab which colnum colinc stream)))
          (t (pprint-tab-not-pretty stream colnum colinc atsign)))))

(defun pprint-tab-not-pretty (stream colnum colinc &optional atsign)
  (let* ((position (column stream))
         (count (if atsign
                  (if position
                    (if (zerop colinc)
                      colnum (+ colnum (mod (- (+ position colnum)) colinc)))
                    colnum)
                  (if position
                    (if (<= colnum position)
                      (if (zerop colinc)
                        0 (- colinc (mod (- position colnum) colinc)))
                      (- colnum position))
                    2))))
    (while (> count 0)
      (stream-write-string stream
                           "                                                                                "
                           0 (min count 80))
      (setq count (- count 80)))))


;;; ~/ call function
(defformat #\/ format-call-function (stream colon atsign &rest parms)
  (let* ((string *format-control-string*)
         (ipos (1+ *format-index*))
         (epos (format-find-char #\/ ipos *format-length*)))    
    ; the spec is DUMB here - it requires that : and :: be treated the same
    (when (not epos) (format-error "Unmatched ~~/"))
    (let ((cpos (format-find-char #\: ipos epos))
          package)
      (cond (cpos 
             (setq package (string-upcase (%substr string ipos cpos)))
             (when (eql #\: (schar string (%i+ 1 cpos)))
               (setq cpos (%i+ cpos 1)))
             (setq ipos (%i+ cpos 1)))
            (t (setq package :cl-user)))
      (let ((thing (intern (string-upcase (%substr string ipos epos)) (find-package package))))
        (setq *format-index* epos) ; or 1+ epos?
        (apply thing stream (pop-format-arg) colon atsign parms)))))

;;; Conditional case conversion  ~( ... ~)

#| coral's old version
(defformat #\( format-capitalization (stream colon atsign)
  (format-nextchar)
  (multiple-value-bind
   (prev tilde end-parms end-colon end-atsign)
   (format-find-command '(#\)))
   (when (or end-parms end-colon end-atsign)
         (format-error "Flags or parameters not allowed"))
   (let* (finished
          (string (with-format-string-output stream
                    (setq finished (catch 'format-escape (sub-format stream prev tilde) t)))))
     (stream-write-string
         stream
         (cond ((and atsign colon)
                (nstring-upcase string))
               (colon
                (nstring-capitalize string))
               (atsign
                (let ((strlen (length string)))
                     ;; Capitalize the first word only
                     (nstring-downcase string)
                     (do ((i 0 (1+ i)))
                         ((or (<= strlen i) (alpha-char-p (char string i)))
                          (setf (char string i) (char-upcase (char string i)))
                          string))))
               (t (nstring-downcase string)))
         0 (length string))
     (unless finished (throw 'format-escape nil)))))

|#

(defformat #\( format-capitalization (stream colon atsign)
  (format-nextchar)
  (multiple-value-bind
    (prev tilde end-parms end-colon end-atsign)
    (format-find-command '(#\)))
    (when (or end-parms end-colon end-atsign)
      (format-error "Flags or parameters not allowed"))
    (let (catchp)
      (cond ((typep stream 'xp-stream)
             (let ((xp (slot-value stream 'xp-structure)))
               (push-char-mode xp (cond ((and colon atsign) :UP)
				         (colon :CAP1)
				         (atsign :CAP0)
				         (T :DOWN)))
               (setq catchp
                     (catch 'format-escape
                       (sub-format stream prev tilde)
                       nil))
	       (pop-char-mode xp)))
            (t
             (let* ((string (with-format-string-output stream                      
                              (setq catchp (catch 'format-escape
                                             (sub-format stream prev tilde)
                                             nil)))))
               (stream-write-string
                stream         
                (cond ((and atsign colon)
                       (nstring-upcase string))
                      (colon
                       (nstring-capitalize string))
                      (atsign
                       ;; Capitalize the first word only
                       (nstring-downcase string)
                       (dotimes (i (length string) string)
                         (let ((ch (char string i)))
                           (when (alpha-char-p ch)
                             (setf (char string i) (char-upcase ch))
                             (return string)))))
                      (t (nstring-downcase string)))
                0 (length string)))))
      (when catchp
        (throw 'format-escape catchp))
      )))

;;; Up and Out (Escape)  ~^

(defformat #\^ format-escape (stream colon atsign &rest parms)
  (declare (special *format-colon-rest*)) ; worry about this later??
  (declare (ignore stream))
  (declare (dynamic-extent parms))
  (when atsign
    (format-error "FORMAT command ~~~:[~;:~]@^ is undefined" colon))
  (when
    (cond ((null parms)
           (null (if colon *format-colon-rest* *format-arguments*)))
          ((null (cdr parms))
           (zerop (car parms)))
          ((null (cddr parms))
           (equal (car parms)(cadr parms)))
          (t (let ((first (car parms))(second (cadr parms))(third (caddr parms)))
               (typecase second
                 (integer
                  (<= first second third))
                 (character
                  (char< first second third))
                 (t nil)))))  ; shouldnt this be an error??
    (throw 'format-escape (if colon 'format-colon-escape t))))

;;; Conditional expression  ~[ ... ]


;;; ~[  - Maybe these guys should deal with ~^ too - i.e. catch format-escape etc.
;;; but I cant think of a case where just throwing to the { catcher fails

(defun format-untagged-condition (stream)
  (let ((test (pop-format-arg)))
    (unless (integerp test)
      (format-error "Argument to ~~[ must be integer - ~S" test))
    (do ((count 0 (1+ count)))
        ((= count test)
         (multiple-value-bind (prev tilde parms colon atsign cmd)
                              (format-find-command '(#\; #\]))
           (declare (ignore colon))
           (when (or atsign parms)
             (format-error "Atsign flag or parameters not allowed"))
           (sub-format stream prev tilde)
           (unless (eq cmd #\])
             (format-find-command '(#\])))))
      (multiple-value-bind (prev tilde parms colon atsign cmd)
                           (format-find-command '(#\; #\]))
        (declare (ignore prev tilde))
        (when (or atsign parms)
          (format-error "Atsign flag or parameters not allowed"))
        (when (eq cmd #\]) (return))
        (when colon
          (format-nextchar)
          (multiple-value-bind (prev tilde parms colon atsign cmd)
                               (format-find-command '(#\; #\]))
            (declare (ignore parms colon atsign))
            (sub-format stream prev tilde)
            (unless (eq cmd #\])
              (format-find-command '(#\]))))
          (return))
        (format-nextchar)))))


;;; ~@[

(defun format-funny-condition (stream)
  (multiple-value-bind (prev tilde parms colon atsign) (format-find-command '(#\]))
    (when (or colon atsign parms)
      (format-error "Flags or arguments not allowed"))
    (if *format-arguments*
      (if (car *format-arguments*)
        (sub-format stream prev tilde)
        (pop *format-arguments*))
      (format-error "Missing argument"))))


;;; ~:[ 

(defun format-boolean-condition (stream)
  (multiple-value-bind
    (prev tilde parms colon atsign command)
    (format-find-command '(#\; #\]))
    (when (or parms colon atsign)
      (format-error "Flags or parameters not allowed"))
    (unless (eq command #\])
      (format-nextchar))
    (if (pop-format-arg)
      (if (eq command #\;)
        (multiple-value-bind (prev tilde parms colon atsign)
                             (format-find-command '(#\]))
          (when (or colon atsign parms)
            (format-error "Flags or parameters not allowed"))
          (sub-format stream prev tilde)))
      (progn
        (sub-format stream prev tilde)
        (unless (eq command #\])
          (format-find-command '(#\])))))))


(defformat #\[ format-condition (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (when parms
    (push (pop parms) *format-arguments*)
    (unless (null parms)
      (format-error "Too many parameters to ~[")))
  (format-nextchar)
  (cond (colon
         (when atsign
           (format-error  "~~:@[ undefined"))
         (format-boolean-condition stream))
        (atsign
         (format-funny-condition stream))
        (t (format-untagged-condition stream))))


;;; Iteration  ~{ ... ~}

(defformat #\{ format-iteration (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (with-format-parameters parms ((max-iter -1))
    (format-nextchar)
    (multiple-value-bind (prev tilde end-parms end-colon end-atsign)
                         (format-find-command '(#\}))
      (when (or end-atsign end-parms)
        (format-error "Illegal terminator for ~~{"))
      (if (= prev tilde)
        ;; Use an argument as the control string if ~{~} is empty
        (let ((string (pop-format-arg)))
          (cond ((stringp string)
                 (when (not (simple-string-p string)) ; fix here too
                   (setq string (coerce string 'simple-string))))
                ((not (functionp string))
                 (format-error "Control string is not a string or function")))          
          (let ((error 
                 (catch 'format-error
                   (cond
                    ((stringp string)
                     (let* ((length (length (the simple-string string)))
                            (*format-control-string* string)
                            (*format-length* length)
                            (*format-index* 0))
                       (format-do-iteration stream 0 length
                                            max-iter colon atsign end-colon)))
                    (t ;(functionp string)
                     (format-do-iteration stream string nil 
                                          max-iter colon atsign end-colon)))
                   nil)))
            (when error (format-indirect-error error))))
        (format-do-iteration stream prev tilde 
                             max-iter colon atsign end-colon)))))


;;; The two catch tags FORMAT-ESCAPE and FORMAT-COLON-ESCAPE are needed here
;;; to correctly implement ~^ and ~:^.  The former aborts only the current
;;; iteration, but the latter aborts the entire iteration process.
;;; ~{ arg is a list  ~:{ arg is list of sublists, ~@{  arg is spread ~:@{ spread lists
;;; We have nuked two catch tags. Instead throw two different values:
;;; T if ~^ and 'format-colon-escape if ~:^

(defun format-do-iteration (stream start end max-iter colon atsign at-least-once-p)
  (flet ((do-iteration-1 (stream start end colon at-least-once-p)
           (let (catchp)
             (do* ((count 0 (1+ count)))
                  ((or (= count max-iter)
                       (and (null *format-arguments*)
                            (if (= count 0) (not at-least-once-p) t))))
               (setq catchp
                     (catch 'format-escape
                       (if colon
                         (let* ((args (unless (and at-least-once-p (null *format-arguments*))
                                        (pop-format-arg)))
                                (*format-top-level* nil)
                                (*format-colon-rest* *format-arguments*)
                                (*format-arguments* args)
                                (*format-original-arguments* args))
                           (declare (special *format-colon-rest*))
                           (unless (listp *format-arguments*)
                             (format-error "Argument must be a list"))
                           (if (functionp start)
                             (apply start stream args)
                             (sub-format stream start end)))
                         (let ((*format-original-arguments* *format-arguments*))
                           (if (functionp start)
                             (setq *format-arguments* (apply start stream *format-arguments*))
                             (sub-format stream start end))))
                       nil))
               (when (or (eq catchp 'format-colon-escape)
                         (and catchp (null colon)))
                 (return-from do-iteration-1  nil))))))
      (if atsign
        (do-iteration-1 stream start end colon at-least-once-p)        
        ; no atsign - munch on first arg
        (let* ((*format-arguments* (pop-format-arg))
               (*format-top-level* nil)
               (*format-original-arguments* *format-arguments*))
          (unless (listp *format-arguments*)
            (format-error "Argument must be a list"))
          (do-iteration-1 stream start end colon at-least-once-p)))))
  

;;; Justification  ~< ... ~>

;;; Parses a list of clauses delimited by ~; and terminated by ~>.
;;; Recursively invoke SUB-FORMAT to process them, and return a list
;;; of the results, the length of this list, and the total number of
;;; characters in the strings composing the list.


(defun format-get-trailing-segments ()
  (format-nextchar)
  (multiple-value-bind (prev tilde colon atsign parms cmd)
                       (format-find-command '(#\; #\>) nil T)
    (when colon
      (format-error "~~:; allowed only after first segment in ~~<"))
    (when (or atsign parms)
      (format-error "Flags and parameters not allowed"))
    (let ((str (catch 'format-escape
                 (with-format-string-output stream
                   (sub-format stream prev tilde)))))      
      (if (stringp str)
        (if (eq cmd #\;)
          (multiple-value-bind
            (segments numsegs numchars)
            (format-get-trailing-segments)
            (values (cons str segments)
                    (1+ numsegs)
                    (+ numchars
                       (length str))))
          (values (list str)
                  1
                  (length str)))
        (progn
          (unless (eq cmd #\>) (format-find-command '(#\>) nil T))
          (values () 0 0))))))


;;; Gets the first segment, which is treated specially.  Call 
;;; FORMAT-GET-TRAILING-SEGMENTS to get the rest.

(defun format-get-segments ()
  (let (ignore)
    (declare (ignore-if-unused ignore)) ; why??
    (multiple-value-bind (prev tilde parms colon atsign cmd)
                         (format-find-command '(#\; #\>) nil T) ; skipping
      (when atsign
        (format-error "Atsign flag not allowed"))
      ;(setq *format-arguments* blech)
      (let ((first-seg (catch 'format-escape
                         (with-format-string-output stream
                           (sub-format stream prev tilde)))))
        (if (stringp first-seg)
          (if (eq cmd #\;)
            (progn
              (when parms
                (setq *format-index* tilde)
                ; now get the parameters if any - do this way cause of the V thingies
                ; maybe only necessary in the : case
                (multiple-value-setq (ignore ignore parms)
                                     (format-find-command '(#\; #\>) t T)))              
              (multiple-value-bind
                (segments numsegs numchars)
                (format-get-trailing-segments)
                (if colon
                  (values first-seg parms segments numsegs numchars)
                  (values nil nil (cons first-seg segments)
                          (1+ numsegs)
                          (+ (length first-seg) numchars)))))
            (values nil nil (list first-seg) 1 (length first-seg)))
          (progn
            (unless (eq cmd #\>) (format-find-command '(#\>) nil T))
            (values nil nil () 0 0)))))))


#|
;;; Given the total number of SPACES needed for padding, and the number
;;; of padding segments needed (PADDINGS), returns a list of such segments.
;;; We try to allocate the spaces equally to each segment.  When this is
;;; not possible, we allocate the left-over spaces randomly, to improve the
;;; appearance of many successive lines of justified text.
;;; 
;;; Query:  Is this right?  Perhaps consistency might be better for the kind
;;; of applications ~<~> is used for.

(defun make-pad-segs (spaces paddings)
  (do* ((extra-space () (and (plusp extra-spaces)
                             (< (random (float 1)) (/ segs extra-spaces))))
        (result () (cons (if extra-space (1+ min-space) min-space) result))
        (min-space (truncate spaces paddings))
        (extra-spaces (- spaces (* paddings min-space))
                      (if extra-space (1- extra-spaces) extra-spaces))
        (segs paddings (1- segs)))
       ((zerop segs) result)))
|#
(defun make-pad-segs (spaces segments)
  (multiple-value-bind (min-space extra-spaces) (truncate spaces segments)
    (declare (fixnum min-space extra-spaces))
    (let* ((result (make-list segments :initial-element min-space))
           (res result))
      (setq min-space (1+ min-space))
      (dotimes (i extra-spaces)
        (rplaca res min-space)
        (setq res (%cdr res)))
      result)))

;;; Determine the actual width to be used for a field requiring WIDTH
;;; characters according to the following rule:  If WIDTH is less than or
;;; equal to MINCOL, use WIDTH as the actual width.  Otherwise, round up 
;;; to MINCOL + k * COLINC for the smallest possible positive integer k.

(defun format-round-columns (width mincol colinc)
  (if (< width mincol)
    (+ width (* colinc (ceiling (- mincol width) colinc)))
    width))

(defformat #\< format-justification (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (multiple-value-bind (start tilde eparms ecolon eatsign)
                       (format-find-command '(#\>)) ; bumps format-index
    (declare (ignore tilde eparms))
    (cond
     (ecolon
      (format-logical-block stream colon atsign eatsign start *format-index* parms))
     (t (setq *format-index* start)
        (with-format-parameters parms ((mincol 0) (colinc 1) (minpad 0) (padchar #\space))
          (unless (and (integerp mincol) (not (minusp mincol)))
            (format-error "Mincol must be a non-negative integer - ~S" mincol))
          (unless (and (integerp colinc) (plusp colinc))
            (format-error "Colinc must be a positive integer - ~S" colinc))
          (unless (and (integerp minpad) (not (minusp minpad)))
            (format-error "Minpad must be a non-negative integer - ~S" minpad))
          (unless (characterp padchar)
            (if (typep padchar `(integer 0 #.char-code-limit))
              (setq padchar (code-char padchar))
              (format-error "Padchar must be a character or integer from 0 to ~a - ~S"
                            char-code-limit padchar)))
          (format-nextchar)
          (multiple-value-bind (special-arg special-parms segments numsegs numchars)
                               (format-get-segments)
            (if (null segments) () ;Not clear what to do...
                (let* ((padsegs (+ (if (or colon (= numsegs 1)) 1 0)
                                   (1- numsegs)
                                   (if atsign 1 0)))
                       (width (format-round-columns (+ numchars (* minpad padsegs))
                                                    mincol colinc))
                       (spaces (if (and atsign (not colon) (= numsegs 1)) ;dirty but works
                                 (list 0 (- width numchars))
                                 (append (if (or colon (= numsegs 1)) () '(0))
                                         (make-pad-segs (- width numchars) padsegs)
                                         (if atsign () '(0))))))
                  (when special-arg
                    (with-format-parameters special-parms ((spare 0)
                                                           (linel (stream-line-length stream)))
                      
                      (let ((pos (column stream)))
                        (when (> (+ pos width spare) linel)
                          (stream-write-entire-string stream special-arg)))))
                  (do ((segs segments (cdr segs))
                       (spcs spaces (cdr spcs)))
                      ((null segs) (dotimes (i (car spcs)) (stream-tyo stream padchar)))
                    (dotimes (i (car spcs)) (stream-tyo stream padchar))
                    (stream-write-entire-string stream (car segs)))))))))))


(defun format-logical-block (stream colon atsign end-atsign start end &rest parms)
  (declare (ignore parms))
  (flet ((format-check-simple (str)
           (when (and str (or (%str-member #\~ str) (%str-eol-member str)))
             (format-error "Suffix and prefix must be simple")))
         (first-block-p (start)
           (let* ((*format-index* 0))
             (loop
               (parse-format-operation)
               (when (eq (format-peek) #\<)
                 (cond ((eq *format-index* start)
                        (return t))
                       (t (return nil))))))))
    (let ((format-string *format-control-string*)
          (prefix "")
          (suffix "")
          body-string start1 tilde ignore colon1 atsign1 per-line-p)
      (declare (ignore-if-unused ignore colon1))
      (setq *format-index* start)
      (multiple-value-setq (start1 tilde ignore colon1 atsign1)
        (format-find-command  '(#\; #\>)))
      (setq body-string (%substr format-string (1+ start) tilde))
      (cond ((eql *format-index* end) ; 1 segment - also atsign here
             (if colon (setq prefix "("  suffix  ")")))
            (t (setq prefix body-string)
               (if atsign1 (setq per-line-p t))
               (multiple-value-setq (start1 tilde)
                 (format-find-command '(#\; #\>)))
               (setq body-string (%substr format-string (1+ start1) tilde))
               (when (neq *format-index* end)
                 (multiple-value-setq (start1 tilde)(format-find-command  '(#\; #\>)))
                 (setq suffix (%substr format-string (1+ start1) tilde))
                 (when (neq *format-index* end)
                   (format-error "Too many chunks")))))
      (when end-atsign (setq body-string (format-fill-transform body-string)))
      (format-check-simple prefix)
      (format-check-simple suffix)
      (let ((args (if (not atsign)
                    ; This piece of garbage is needed to avoid double length counting from (formatter ...) things
                    ; but also to allow (flet . t) not to barf.
                    ; Was formerly simply  (if *format-arguments* (pop-format-arg))
                    ; Actually wanna not count the arg iff the ~< is at the top level
                    ; in a format string i.e. "is this the first ~< in THIS string?"                    
                    (when *format-arguments*
                      (if  (and (listp *format-arguments*)
                                (first-block-p start))
                        (pop *format-arguments*)  ; dont count
                        (pop-format-arg))) ; unless not listp or not first
                    (prog1 *format-arguments*
                      (setq *format-arguments* nil))))
            (*format-control-string* body-string)
            (*format-top-level* (and atsign *format-top-level*)))
        (let ((xp-struct (cond ((xp-structure-p stream) stream)
                               ((typep stream 'xp-stream)
                                (slot-value stream 'xp-structure)))))
          ; lets avoid unnecessary closures
          (cond (xp-struct (logical-block-sub xp-struct args  prefix suffix per-line-p atsign))
                (t (maybe-initiate-xp-printing
                    #'(lambda (s o)
                        (logical-block-sub s o  prefix suffix per-line-p atsign))
                    stream args))))))))


    
; flet?
(defun logical-block-sub (stream args  prefix suffix per-line-p atsign)
  ;(push (list args body-string) barf)
  (let ((circle-chk (not (or *format-top-level* (and atsign (eq *current-length* -1)))))) ; i.e. ~<~@<
    (let ((*current-level* (1+ *current-level*)) ; these are for pprint
          (*current-length* -1))
      (declare (special *current-level* *current-length*))
      (unless (check-block-abbreviation stream args circle-chk) ;(neq args *format-original-arguments*)) ;??
        (start-block stream prefix per-line-p suffix)
        (let ((*logical-block-xp* stream)    ; for pop-format-arg
              (my-stream (if (xp-structure-p stream) (get-xp-stream stream) stream)))
          (catch 'logical-block
            (do-sub-format-1 my-stream args)))
        (end-block stream suffix)))))

; bash in fill conditional newline after white space (except blanks after ~<newline>)
; I think this is silly!
(defun format-fill-transform (string)
  (let ((pos 0)(end (length (the string string)))(result "") ch)
    (while (%i< pos end)
      (let ((wsp-pos (min (or (%str-member #\space string pos) end)
                          (or (%str-member #\tab string pos) end)))
            (yes nil))
        (when (%i< wsp-pos end)
          (when (not (and (%i> wsp-pos 1)
                          (char-eolp (schar string (%i- wsp-pos 1)))
                          (or (eq (setq ch (schar string (%i- wsp-pos 2))) #\~)
                              (and (%i> wsp-pos 2)
                                   (memq ch '(#\: #\@))
                                   (eq (schar string (%i- wsp-pos 3)) #\~)))))
            (setq yes t))
          (loop 
            (while (%i< wsp-pos end)
              (setq ch (schar string wsp-pos))
              (when (Not (%str-member ch wsp)) (return))
              (setq wsp-pos (%i+ 1 wsp-pos)))
            (return)))
        (setq result (%str-cat result (%substr string pos  wsp-pos) (if yes "~:_" "")))
      (setq pos wsp-pos)))
    result))


;;;;some functions needed for dealing with floats

;;;; Floating Point printing
;;;
;;;  Written by Bill Maddox
;;;
;;;
;;;
;;; FLONUM-TO-STRING (and its subsidiary function FLOAT-STRING) does most of 
;;; the work for all printing of floating point numbers in the printer and in
;;; FORMAT.  It converts a floating point number to a string in a free or 
;;; fixed format with no exponent.  The interpretation of the arguments is as 
;;; follows:
;;;
;;;     X        - The floating point number to convert, which must not be
;;;                negative.
;;;     WIDTH    - The preferred field width, used to determine the number
;;;                of fraction digits to produce if the FDIGITS parameter
;;;                is unspecified or NIL.  If the non-fraction digits and the
;;;                decimal point alone exceed this width, no fraction digits
;;;                will be produced unless a non-NIL value of FDIGITS has been
;;;                specified.  Field overflow is not considerd an error at this
;;;                level.
;;;     FDIGITS  - The number of fractional digits to produce. Insignificant
;;;                trailing zeroes may be introduced as needed.  May be
;;;                unspecified or NIL, in which case as many digits as possible
;;;                are generated, subject to the constraint that there are no
;;;                trailing zeroes.
;;;     SCALE    - If this parameter is specified or non-NIL, then the number
;;;                printed is (* x (expt 10 scale)).  This scaling is exact,
;;;                and cannot lose precision.
;;;     FMIN     - This parameter, if specified or non-NIL, is the minimum
;;;                number of fraction digits which will be produced, regardless
;;;                of the value of WIDTH or FDIGITS.  This feature is used by
;;;                the ~E format directive to prevent complete loss of
;;;                significance in the printed value due to a bogus choice of
;;;                scale factor.
;;;
;;; Most of the optional arguments are for the benefit for FORMAT and are not
;;; used by the printer.
;;;
;;; Returns:
;;; (VALUES DIGIT-STRING DIGIT-LENGTH LEADING-POINT TRAILING-POINT DECPNT)
;;; where the results have the following interpretation:
;;;
;;;     DIGIT-STRING    - The decimal representation of X, with decimal point.
;;;     DIGIT-LENGTH    - The length of the string DIGIT-STRING.
;;;     LEADING-POINT   - True if the first character of DIGIT-STRING is the
;;;                       decimal point.
;;;     TRAILING-POINT  - True if the last character of DIGIT-STRING is the
;;;                       decimal point.
;;;     POINT-POS       - The position of the digit preceding the decimal
;;;                       point.  Zero indicates point before first digit.
;;;     NZEROS          - number of zeros after point
;;;
;;; WARNING: For efficiency, there is a single string object *digit-string*
;;; which is modified destructively and returned as the value of
;;; FLONUM-TO-STRING.  Thus the returned value is not valid across multiple 
;;; calls.
;;;
;;; NOTE:  FLONUM-TO-STRING goes to a lot of trouble to guarantee accuracy.
;;; Specifically, the decimal number printed is the closest possible 
;;; approximation to the true value of the binary number to be printed from 
;;; among all decimal representations  with the same number of digits.  In
;;; free-format output, i.e. with the number of digits unconstrained, it is 
;;; guaranteed that all the information is preserved, so that a properly-
;;; rounding reader can reconstruct the original binary number, bit-for-bit, 
;;; from its printed decimal representation. Furthermore, only as many digits
;;; as necessary to satisfy this condition will be printed.
;;;
;;;
;;; FLOAT-STRING actually generates the digits for positive numbers.  The
;;; algorithm is essentially that of algorithm Dragon4 in "How to Print 
;;; Floating-Point Numbers Accurately" by Steele and White.  The current 
;;; (draft) version of this paper may be found in [CMUC]<steele>tradix.press.
;;; DO NOT EVEN THINK OF ATTEMPTING TO UNDERSTAND THIS CODE WITHOUT READING 
;;; THE PAPER!

;(defvar *digits* "0123456789")
  
;(defvar *digit-string*
;  (make-array 50 :element-type 'base-character :fill-pointer 0 :adjustable t))
#|
(defun flonum-to-string (x &optional width fdigits scale fmin no-zeros
                           ;&aux (string *digit-string*)
                           &aux (string (make-array 10 :element-type 'base-character :fill-pointer 0 :adjustable t)))
  ;(setf (fill-pointer string) 0)
  (cond ((zerop x)
         ;;zero is a special case which float-string cannot handle
         (vector-push-extend #\0 string)
         (when (not no-zeros)(vector-push-extend #\. string))
         (let ((count (max (or fmin 0) (or fdigits (and width (- width 2)) 0))))
           (dotimes (i count)
             (declare (fixnum i))
             (vector-push-extend #\0 string))
           (values string (+ count 2) nil (eq 0 count) 1)))
        (t
         (multiple-value-bind (sig exp) (integer-decode-float x)
           ;;24 and 53 are the number of bits of information in the
           ;;significand, less sign, of a short float and a long float
           ;;respectively.
           (float-string string sig exp (if (typep x 'short-float) 24 53) width fdigits scale fmin no-zeros)))))

; If no-zeros is T just return the non-leading/trailing 0 digits.
; The #\. is in the string only if it is neither preceded nor followed by insignificant zeros
; Well leading dots are there, trailing dots are not
(defun float-string (string fraction exponent precision width fdigits scale fmin &optional no-zeros)
  (declare (resident))
  (flet ((nth-digit (n) (%code-char (%i+ n (%char-code #\0)))))
    (let ((r fraction) (s 1) (m- 1) (m+ 1) (k 0)
          (digits 0) (decpnt 0) (cutoff nil) (roundup nil) u low high (nzeros 0))
      ;;Represent fraction as r/s, error bounds as m+/s and m-/s.
      ;;Rational arithmetic avoids loss of precision in subsequent calculations.
      (cond ((> exponent 0)
             (setq r (ash fraction exponent))
             (setq m- (ash 1 exponent))
             (setq m+ m-))
            ((< exponent 0)
             (setq s (ash 1 (- exponent)))))
      ;;adjust the error bounds m+ and m- for unequal gaps
      (when (= fraction (ash 1 precision))  ; can this ever be true??
        (setq m+ (ash m+ 1))
        (setq r (ash r 1))
        (setq s (ash s 1)))
      ;;scale value by requested amount, and update error bounds
      (when (and (or (null scale)(zerop scale))(not (zerop exponent)))
        ; approximate k
        (let ((fudge 0))
          (when (>= fraction (ash 1 (1- precision)))
            (setq fudge precision))
          (setq k (truncate (*  (+ exponent fudge) .301)))
          (when (not (= 0 k))
            (setq scale (- k)))))
      (when scale
        (if (minusp scale)
          (let ((scale-factor (expt 10 (- scale))))
            (setq s (* s scale-factor)))
          (let ((scale-factor (expt 10 scale)))
            (setq r (* r scale-factor))
            (setq m+ (* m+ scale-factor))
            (setq m- (* m- scale-factor)))))
      ;;scale r and s and compute initial k, the base 10 logarithm of r
      (let ((ceil (ceiling s 10))(fudge 1))
        (do ()
            ((>= r ceil))
          (setq k (1- k))
          (setq r (* r 10))
          (setq fudge (* fudge 10)))
        (when (> fudge 1)
          (setq m- (* m- fudge))
          (setq m+ (* m+ fudge))))
      ;(print (list k r s m+ m-))
      (let ((ash-r-1 (ash r 1)))
        (loop
          (do ()
              ((and (< r s) ; save some bignums (everything is positive)
                    (< (+ ash-r-1 m+) (ash s 1))))
            (setq s (* s 10))
            (setq k (1+ k)))
          ;;determine number of fraction digits to generate
          (cond (fdigits
                 ;;use specified number of fraction digits
                 (setq cutoff (- fdigits))
                 ;;don't allow less than fmin fraction digits
                 (if (and fmin (> cutoff (- fmin))) (setq cutoff (- fmin))))
                (width
                 ;;use as many fraction digits as width will permit
                 ;;but force at least fmin digits even if width will be exceeded
                 (if (< k 0)
                   (setq cutoff (- 1 width))
                   (setq cutoff (1+ (- k width))))
                 (if (and fmin (> cutoff (- fmin))) (setq cutoff (- fmin)))))
          ;;If we decided to cut off digit generation before precision has
          ;;been exhausted, rounding the last digit may cause a carry propagation.
          ;;We can prevent this, preserving left-to-right digit generation, with
          ;;a few magical adjustments to m- and m+.  Of course, correct rounding
          ;;is also preserved.
          (when (or fdigits width)
            (let ((a (- cutoff k))
                  (y s))
              (if (>= a 0)
                (dotimes (i a) (declare (fixnum i)) (setq y (* y 10)))
                (dotimes (i (- a)) (declare (fixnum i)) (setq y (ceiling y 10))))
              (setq m- (max y m-))
              (setq m+ (max y m+))
              (when (= m+ y) (setq roundup t))))
          (when (< (+ ash-r-1 m+) (ash s 1)) (return))))
      ;(print k)
      ;(print (list r s m+))     
      ;;zero-fill before fraction if no integer part      
      (when (< k 0)
        (setq decpnt digits)
        (when (null no-zeros)(vector-push-extend #\. string))
        (dotimes (i (- k))
          (declare (fixnum i))
          (setq digits (1+ digits))
          (setq nzeros (1+ nzeros))
          (when (null no-zeros)(vector-push-extend #\0 string))))
      ;;generate the significant digits
      (loop
        (setq k (1- k))
        (when (= k -1)
          (vector-push-extend #\. string)
          (setq decpnt digits))
        (multiple-value-setq (u r) (truncate (* r 10) s))
        (setq m- (* m- 10))
        (setq m+ (* m+ 10))
        (let ((ash-r-1 (ash r 1)))
          (setq low (< ash-r-1 m-))
          (if roundup
            (setq high (>= ash-r-1 (- (ash s 1) m+)))
            (setq high (> ash-r-1 (- (ash s 1) m+)))))
        ;;stop when either precision is exhausted or we have printed as many
        ;;fraction digits as permitted
        (when (or low high (and cutoff (<= k cutoff))) (return))
        (vector-push-extend (nth-digit u) string)
        (setq digits (1+ digits)))
      ;;if cutoff occured before first digit, then no digits generated at all
      (when (or (not cutoff) (>= k cutoff))
        ;;last digit may need rounding
        (vector-push-extend (nth-digit
                             (cond ((and low (not high)) u)
                                   ((and high (not low)) (1+ u))
                                   (t (if (<= (ash r 1) s) u (1+ u)))))
                            string)
        (setq digits (1+ digits)))
      ;;zero-fill after integer part if no fraction
      (when (>= k 0)
        (dotimes (i k) 
          (declare (fixnum i))
          (setq digits (1+ digits))
          (if (null no-zeros)(vector-push-extend #\0 string)))
        (if (null no-zeros)(vector-push-extend #\. string))
        (setq decpnt digits))
      ;;add trailing zeroes to pad fraction if fdigits specified
      (when (or fdigits fmin)
        (dotimes (i (- (or fdigits fmin) (- digits decpnt)))
          (declare (fixnum i))
          (setq digits (1+ digits))
          (vector-push-extend #\0 string)))
      ;;all done      
      (values string (1+ digits) (= decpnt 0)
              (= decpnt digits) decpnt nzeros))))
|#


(defun flonum-to-string (n &optional width fdigits scale)
  (let ((*print-radix* nil))
    (cond ((zerop n)(values "" 0 0))
          ((and (not (or width fdigits scale))
                (double-float-p n)
                ; cheat for the only (?) number that fails to be aesthetically pleasing
                (= n 1e23))
           (values "1" 24 23))
          (t (let ((string (make-array 12 :element-type 'base-character
                                       :fill-pointer 0 :adjustable t))
                   sig exp)
               (if (nan-or-infinity-p n)
                 (without-float-invalid
                   (multiple-value-setq (sig exp) (integer-decode-float n)))
                 (multiple-value-setq (sig exp)(integer-decode-float n)))
               (float-string string sig exp (integer-length sig) width fdigits scale))))))

; if width given and fdigits nil then if exponent is >= 0 returns at most width-1 digits
;    if exponent is < 0 returns (- width (- exp) 1) digits
; if fdigits given width is ignored, returns fdigits after (implied) point
; The Steele/White algorithm can produce a leading zero for 1e23
; which lies exactly between two double floats - rounding picks the float whose rational is
; 99999999999999991611392. This guy wants to print as 9.999999999999999E+22. The untweaked
; algorithm generates a leading zero in this case.
; (actually wants to print as 1e23!)
; If we choose s such that r < s - m/2, and r = s/10 - m/2 (which it does in this case)
; then r * 10 < s => first digit is zero
; and (remainder (* r 10) s) is r * 10 = new-r, 10 * m = new-m
; new-r = s - new-m/2 so high will be false and she won't round up
#|
(defun float-string (string f e p &optional width fdigits scale)
  (flet ((nth-digit (n) (%code-char (%i+ n (%char-code #\0)))))
  (let ((r f)(s 1)(m- 1)(m+ 1)(k 0) cutoff roundup (mm nil))
    (cond ((> e 0)
           (setq r (ash f e))
           (setq m- (ash 1 e))
           (setq m+ m-))
          ((< e 0)
           (setq s (ash 1 (- e)))))
    (when (= f (if (eql p 53) #.(ash 1 52) (ash 1 (1- p))))
      (setq m+ (+ m+ m+))
      (setq mm t)
      (setq r (+ r r))
      (setq s (+ s s)))
    (when (and (or (null scale)(zerop scale)))
      ; approximate k
      (let ((fudge 0))
        (setq fudge (truncate (*  (%i+ e p) .301)))
        (when (neq fudge 0)
          (setq k fudge)
          (setq scale (- k)))))
    (when (and scale (not (eql scale 0)))      
      (if (minusp scale)
        (setq s (* s (10-to-e  (- scale))))
        (let ((scale-factor (10-to-e scale)))
          (setq r (* r scale-factor))
          (setq m+ (* m+ scale-factor))
          (when mm (setq m- (* m- scale-factor))))))
    (let ((ceil (ceiling s 10))(fudge 1))
      (while (< r ceil)
        (setq k (1- k))
        (setq r (* r 10))
        (setq fudge (* fudge 10)))
      (when (> fudge 1)
        (setq m+ (* m+ fudge))
        (when mm (setq m- (* m- fudge)))))    
    (let ((2r (+ r r)))
      (loop
        (let ((2rm+ (+ 2r m+)))          
          (while
            (if (not roundup)  ; guarantee no leading zero
              (> 2rm+ (+ s s))
              (>=  2rm+ (+ s s)))
            (setq s (* s 10))
            (setq k (1+ k))))
        (when (not (or fdigits width))(return)) ; omit this makes 1e23 print right but others wrong??
        (cond 
         (fdigits
          (setq cutoff (- fdigits))
          ;(if (and fmin (> cutoff (- fmin))) (setq cutoff (- fmin)))
          )
         (width
          (setq cutoff
                (if (< k 0) (- 1 width)(1+ (- k width))))
          ;(if (and fmin (> cutoff (- fmin))) (setq cutoff (- fmin)))
          ))
        (let ((a (if cutoff (- cutoff k) 0))
              (y s))
          (DECLARE (FIXNUM A))
          (if (>= a 0)
            (WHEN (> A 0)(SETQ Y (* Y (10-to-e a))))
            ;(dotimes (i (the fixnum a))  (setq y (* y 10)))
            ;(dotimes (i (the fixnum (- a))) (setq y (ceiling y 10)))
            (SETQ Y (CEILING Y (10-to-e (THE FIXNUM (- A))))))
          (when mm (setq m- (max y m-)))
          (setq m+ (max y m+))
          (when (= m+ y) (setq roundup t)))
        (when (if (not roundup)   ; tweak as above
                (<= (+ 2r m+)(+ s s))
                (< (+ 2r m+)(+ s s)))
          (return))))
    (let* ((h k)
           ;(2s (+ s s))
           (half-m+ (* m+ 5))  ; 10 * m+/2
           (half-m- (if mm (* m- 5)))
           u high low 
           ;2r
           )
      ;(print (list r s m+ roundup))
      (unless (and fdigits (>= (- k) fdigits))
        (loop
          (setq k (1- k))
          (multiple-value-setq (u r) (truncate (* r 10) s))          
          ;(setq 2r (+ r r))
          (setq low (< r (if mm half-m- half-m+)))
          (setq high 
                (if (not roundup)
                  (> r (- s half-m+))
                  (>= r (- s half-m+))))                   
          (if (or low high)
            (return)
            (progn
              (vector-push-extend (nth-digit u) string)))
          (when mm (setq half-m- (* half-m- 10) ))
          (setq half-m+ (* half-m+ 10)))
        ;(print (list r s  high low h k))
        (vector-push-extend
         (nth-digit (cond
                     ((and low (not high)) u) 
                     ((and high (not low))(+ u 1))
                     
                     (t ;(and high low)
                      (if (<= (+ r r) s) u (1+ u)))))
         string))
      ; second value is exponent, third is exponent - # digits generated
      (values string h k)))))
|#
; yet another
; instead of multiplying r * (expt 2 e) and s * (expt 10 (- scale))
; we do r * (expt 2 (- e (- scale))) and s * (expt 5 (- scale))
; i.e. both less by (expt 2 (- scale))

(defun float-string (string f e p &optional width fdigits scale)
  (macrolet ((nth-digit (n) `(%code-char (%i+ ,n (%char-code #\0)))))    
    (let ((r f)(s 1)(m- 1)(m+ 1)(k 0) cutoff roundup (mm nil))
      (when (= f (if (eql p 53) #.(ash 1 52) (ash 1 (1- p))))
        (setq mm t))
      (when (and (or (null scale)(zerop scale)))
        ; approximate k
        (let ((fudge 0))
          (setq fudge (truncate (*  (%i+ e p) .301)))
          (when (neq fudge 0)
            (setq k fudge)
            (setq scale (- k)))))
      (when (and scale (not (eql scale 0)))      
        (if (minusp scale)
          (setq s (* s (5-to-e  (- scale))))
          (let ((scale-factor (5-to-e scale)))
            (setq r (* r scale-factor))
            (setq m+ scale-factor)
            (when mm (setq m- scale-factor)))))
      (let ((shift (- e (if scale (- scale) 0))))
        (declare (fixnum shift))
        ;(print (list e scale shift))
        (cond ((> shift 0)
               (setq r (ash f shift))
               (setq m+ (ash m+ shift))
               (when mm (setq m- (ash m- shift))))
              ((< shift 0)
               (setq s (ash s (- shift))))))
      (when mm
        (setq m+ (+ m+ m+))
        (setq r (+ r r))
        (setq s (+ s s)))    
      (let ((ceil (ceiling s 10))(fudge 1))
        (while (< r ceil)
          (setq k (1- k))
          (setq r (* r 10))
          (setq fudge (* fudge 10)))
        (when (> fudge 1)
          (setq m+ (* m+ fudge))
          (when mm (setq m- (* m- fudge)))))    
      (let ((2r (+ r r)))
        (loop
          (let ((2rm+ (+ 2r m+)))          
            (while
              (if (not roundup)  ; guarantee no leading zero
                (> 2rm+ (+ s s))
                (>=  2rm+ (+ s s)))
              (setq s (* s 10))
              (setq k (1+ k))))
          (when (not (or fdigits width))(return))
          (cond 
           (fdigits
            (setq cutoff (- fdigits))
            ;(if (and fmin (> cutoff (- fmin))) (setq cutoff (- fmin)))
            )
           ((and width (> width 0)) ;; << ??
            (setq cutoff
                  (if (< k 0) (- 1 width)(1+ (- k width))))
            ;(if (and fmin (> cutoff (- fmin))) (setq cutoff (- fmin)))
            ))
          (let ((a (if cutoff (- cutoff k) 0))
                (y s))
            (DECLARE (FIXNUM A))
            (if (>= a 0)
              (WHEN (> A 0)(SETQ Y (* Y (10-to-e a))))
              ;(dotimes (i (the fixnum a))  (setq y (* y 10)))
              ;(dotimes (i (the fixnum (- a))) (setq y (ceiling y 10)))
              (SETQ Y (CEILING Y (10-to-e (THE FIXNUM (- A))))))
            (when mm (setq m- (max y m-)))
            (setq m+ (max y m+))
            (when (= m+ y) (setq roundup t)))
          (when (if (not roundup)   ; tweak as above
                  (<= (+ 2r m+)(+ s s))
                  (< (+ 2r m+)(+ s s)))
            (return))))
      ;(print (list r s m+))
      (let* ((h k)
             ;(2s (+ s s))
             (half-m+ (* m+ 5))  ; 10 * m+/2
             (half-m- (if mm (* m- 5)))
             u high low 
             ;2r
             )
        ;(print (list r s m+ roundup))
        (unless (and fdigits (>= (- k) fdigits))
          (loop
            (setq k (1- k))
            (multiple-value-setq (u r) (truncate (* r 10) s))          
            ;(setq 2r (+ r r))
            (setq low (< r (if mm half-m- half-m+)))
            (setq high 
                  (if (not roundup)
                    (> r (- s half-m+))
                    (>= r (- s half-m+))))                   
            (if (or low high)
              (return)
              (progn
                (vector-push-extend (nth-digit u) string)))
            (when mm (setq half-m- (* half-m- 10) ))
            (setq half-m+ (* half-m+ 10)))
          ;(print (list r s  high low h k))
          (vector-push-extend
           (nth-digit (cond
                       ((and low (not high)) u) 
                       ((and high (not low))(+ u 1))
                       
                       (t ;(and high low)
                        (if (<= (+ r r) s) u (1+ u)))))
           string))
        ; second value is exponent, third is exponent - # digits generated
        (values string h k)))))

#|
(defparameter integer-powers-of-10 (make-array (+ 12 (floor 324 12))))
|#

(defparameter integer-powers-of-10 
  #(1 10 100 1000 10000 100000 1000000 10000000 100000000 1000000000
    10000000000 100000000000 1000000000000 1000000000000000000000000
    1000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000 
    1000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000 
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)
 )
; e better be positive
(defun 10-to-e (e)
  (declare (fixnum e)(optimize (speed 3)(safety 0)))
  (if (> e 335)
    (* (10-to-e 334) (10-to-e (%i- e 334)))
    (if (< e 12)
      (svref integer-powers-of-10 e)
      (multiple-value-bind (q r) (truncate e 12)
        (declare (fixnum q r))        
        (if (eql r 0)
          (svref integer-powers-of-10 (%i+ q 11))
          (* (svref integer-powers-of-10 r)
             (svref integer-powers-of-10 (%i+ q 11))))))))

#|
;; can't USE EXPT now that expt uses this table
(let ((array integer-powers-of-10)
      (N 1))
  (dotimes (i 12)
    (setf (svref array i)  N)
    (SETQ N (* N 10)))
  (LET ((M N))
    (dotimes (i (floor 324 12))
      (setf (svref array (+ i 12)) M)
      (SETQ M (* M N)))))
|#
#|
(defun 10-to-e (e)
  (ash (5-to-e e) e))
|#
      



;;; Given a non-negative floating point number, SCALE-EXPONENT returns a
;;; new floating point number Z in the range (0.1, 1.0] and and exponent
;;; E such that Z * 10^E is (approximately) equal to the original number.
;;; There may be some loss of precision due the floating point representation.
;;; JUST do the EXPONENT since thats all we use


(defconstant long-log10-of-2 0.30103d0)

#| 
(defun scale-exponent (x)
  (if (floatp x )
      (scale-expt-aux (abs x) 0.0d0 1.0d0 1.0d1 1.0d-1 long-log10-of-2)
      (report-bad-arg x 'float)))

#|this is the slisp code that was in the place of the error call above.
  before floatp was put in place of shortfloatp.
      ;(scale-expt-aux x (%sp-l-float 0) (%sp-l-float 1) %long-float-ten
      ;                %long-float-one-tenth long-log10-of-2)))
|#

; this dies with floating point overflow (?) if fed least-positive-double-float

(defun scale-expt-aux (x zero one ten one-tenth log10-of-2)
  (let ((exponent (nth-value 1 (decode-float x))))
    (if (= x zero)
      (values zero 1)
      (let* ((e (round (* exponent log10-of-2)))
             (x (if (minusp e)		;For the end ranges.
                  (* x ten (expt ten (- -1 e)))
                  (/ x ten (expt ten (1- e))))))
        (do ((d ten (* d ten))
             (y x (/ x d))
             (e e (1+ e)))
            ((< y one)
             (do ((m ten (* m ten))
                  (z y (* z m))
                  (e e (1- e)))
                 ((>= z one-tenth) (values x e)))))))))
|#

(defun scale-exponent (n)
  (let ((exp (nth-value 1 (decode-float n))))
    (values (round (* exp long-log10-of-2)))))


;;; Page  ~|

(defformat #\| format-page (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (format-no-flags colon atsign)
  (with-format-parameters parms ((repeat-count 1))
    (declare (fixnum repeat-count))
    (dotimes (i repeat-count) (stream-tyo stream #\page))))


(defun format-eat-whitespace ()
  (do* ((i *format-index* (1+ i))
        (s *format-control-string*)
        (n *format-length*))
       ((or (= i n)
            (not (whitespacep (schar s i))))
        (setq *format-index* (1- i)))))

(defun format-newline (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (when parms
    (format-error "Parameters not allowed"))
  (cond (colon
         (when atsign (format-error "~:@<newline> is undefined")))
        (atsign (terpri stream) (format-eat-whitespace))
        (t (format-eat-whitespace))))

(defformat  #\linefeed format-newline (stream colon atsign &rest parms)
  (apply #'format-newline stream colon atsign parms))

(defformat #\return format-newline (stream colon atsign &rest parms)
  (apply #'format-newline stream colon atsign parms))

;;; Indirection  ~?

(defformat #\? format-indirection (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (when (or colon parms)
    (format-error "Flags or parameters not allowed"))
  (let ((string (pop-format-arg)))
    (unless (or (stringp string)(functionp string))
      (format-error "Indirected control string is not a string or function"))
    ; fix so 3.1 doesn't make an extended-string here! for which %str-member was busted
    ; it didn't fail in 3.0 cause the setq was erroneously missing
    ; should really fix the compiler macro to not do that! - done 
    (when (AND (stringp string)(NOT (SIMPLE-STRING-P STRING)))
      (setq string (coerce string 'simple-string)))
    (catch 'format-escape
      (let ((error 
             (catch 'format-error
               (cond 
                ((stringp string)
                 (let* ((length (length (the simple-string string)))
                        (*format-control-string* string)
                        (*format-length* length)
                        (*format-index* 0))
                    (if atsign
                      (sub-format stream 0 length)
                      (let ((args (pop-format-arg)))
                        (let ((*format-top-level* nil)
                              (*format-arguments* args)
                              (*format-original-arguments* args))
                          (sub-format stream 0 length))))))
                (T ;(functionp string)
                 (if (not atsign)
                   (apply string stream (pop-format-arg))
                   ; account for the args it eats
                   (setq *format-arguments* (apply string stream *format-arguments*)))))
               nil)))
        (when error (format-indirect-error error))))))




;;; Ascii  ~A

(defformat #\A format-princ (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (let ((arg (pop-format-arg)))
    (if (null parms)
      (princ (or arg (if colon "()" nil)) stream)
      (with-format-parameters parms ((mincol 0) (colinc 1) (minpad 0) (padchar #\space))
        (format-write-field
         stream
         (if (or arg (not colon))
           (princ-to-string arg)
           "()")
         mincol colinc minpad padchar atsign)))))



;;; S-expression  ~S
	    
(defformat #\S format-prin1 (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (let ((arg (pop-format-arg)))
    (if (null parms)
      (if (or arg (not colon)) (prin1 arg stream) (princ "()" stream))
      (with-format-parameters parms ((mincol 0) (colinc 1) (minpad 0) (padchar #\space))
        (format-write-field
         stream
         (if (or arg (not colon))
           (prin1-to-string arg)
           "()")
         mincol colinc minpad padchar atsign)))))



;;; Character  ~C

(defformat #\C format-print-character (stream colon atsign)
  (let* ((char (character (pop-format-arg)))
         (code (char-code char))
         (name (char-name char)))
    (cond ((and atsign (not colon))
           (prin1 char stream))
          ((< 127 code)
           (stream-tyo stream char)
           (when (and atsign
                      (neq #\Null (setq char (schar unoption-unkeymap code))))
             (princ " (Option " stream)
             (stream-tyo stream char)
             (stream-tyo stream #\))))
          ((not (or atsign colon))
           (stream-tyo stream char))
          ((and (< code 32) atsign)
           (stream-tyo stream #\^)
           (stream-tyo stream (setq char (code-char (logxor code 64))))
           (princ " (" stream)
           (if (%str-member char "CHIJLM[\]^_")
             (princ name stream)
             (progn
               (princ "Control " stream)
               (stream-tyo stream char)))
           (stream-tyo stream #\)))
          (name (princ name stream))
          (t (stream-tyo stream char)))))


;;; NUMERIC PRINTING



;;; Output a string in a field at MINCOL wide, padding with PADCHAR.
;;; Pads on the left if PADLEFT is true, else on the right.  If the
;;; length of the string plus the minimum permissible padding, MINPAD,
;;; is greater than MINCOL, the actual field size is rounded up to
;;; MINCOL + k * COLINC for the smallest possible positive integer k.

(defun format-write-field (stream string mincol colinc minpad padchar padleft)
  (unless (or (null mincol)
              (and (integerp mincol)
                   (not (minusp mincol))))
    (format-error "Mincol must be a non-negative integer - ~S" mincol))
  (unless (and (integerp colinc) (plusp colinc))
    (format-error "Colinc must be a positive integer - ~S" colinc))
  (unless (and (integerp minpad) (not (minusp minpad)))
    (format-error "Minpad must be a non-negative integer - ~S" minpad))
  (unless (characterp padchar)
    (if (typep padchar `(integer 0 #.char-code-limit))
      (setq padchar (code-char padchar))
      (format-error "Padchar must be a character or integer from 0 to ~a - ~S"
                    char-code-limit padchar)))
  (let* ((strlen (length (the string string)))
         (strwid (+ strlen minpad))
         (width (if mincol
                  (format-round-columns strwid mincol colinc)
                  strwid)))
    (if padleft
      (dotimes (i (the fixnum (- width strlen))) (stream-tyo stream padchar)))
    (stream-write-string stream string 0 strlen)
    (unless padleft
      (dotimes (i (the fixnum (- width strlen))) (stream-tyo stream padchar)))))


;;; This functions does most of the work for the numeric printing
;;; directives.  The parameters are interpreted as defined for ~D.

(defun format-print-number (stream number radix print-commas-p print-sign-p parms)
  (declare (dynamic-extent parms))
  (declare (type t number) (type fixnum radix))
  (when (> (length parms) 2) (setq print-commas-p t)) ; print commas if char or interval provided
  (if (not (integerp number))
      (let ((*print-base* radix)
            (*print-escape* nil)
            (*print-radix* nil))
        (declare (special *print-base* *print-radix*))
        (princ number stream))
    (with-format-parameters parms
          ((mincol 0) (padchar #\space) (commachar #\,) (commainterval 3))
      ; look out for ",0D" - should be ",'0D"
      (unless (characterp padchar)
        (error "Use '~A instead of ~A for padchar in format directive" padchar padchar))
       (setq print-sign-p 
             (cond ((and print-sign-p (>= number 0)) #\+)
                   ((< number 0) #\-)))
       (setq number (abs number))
       (block HAIRY
         (block SIMPLE
           (if (and (not print-commas-p) (eql 0 mincol))
             (return-from SIMPLE))
           (let ((lg 0)
                 (commas 0))
             (declare (type fixnum lg commas))
             (do ((n (abs number) (floor n radix)))
                 ((%i< n radix))
               (declare (type integer n))
               (setq lg (%i+ lg 1))) ; lg is 1- significant digits             
             (setq commas (if print-commas-p
                            (if  (and (neq padchar #\space)(< lg mincol))
                              (floor (if print-sign-p (1- mincol) mincol)
                                     (1+ commainterval))
                              (floor lg commainterval))
                            0))
             (when print-sign-p
               (setq lg (1+ lg)))
             (when (and (eq commas 0)
                        (%i<= mincol lg))
               (return-from SIMPLE))
             ;; Cons-o-rama no more !
             (with-string-output-stream (s)
               (when print-sign-p (stream-tyo s print-sign-p))
               (when  (neq padchar #\space)
                 (dotimes (i (- mincol (+ lg commas) 1))
                   (stream-tyo s padchar)))
               (%pr-integer  number radix s)                           
               (dotimes (i (the fixnum commas)) (stream-tyo s commachar))
               (let ((text (slot-value s 'my-string)))
                 (declare (type string text))
                 ;; -1234567,, => -1,234,567
                 (when (%i> commas 0)
                   (do* ((dest (%i- (length text) 1))
                         (source (%i- dest commas)))
                        ((= source dest))
                     (declare (type fixnum dest source))
                     (dotimes (i (the fixnum commainterval))
                       (setf (char text dest) (char text source)
                             dest (1- dest) 
                             source (1- source)))
                     (setf (char text dest) commachar
                           dest (1- dest))))
                 (format-write-field stream text mincol 1 0 padchar t)
                 (return-from HAIRY)))))
         ;; SIMPLE case         
         (when print-sign-p (stream-tyo stream print-sign-p))
         (%pr-integer number radix stream))))
  nil)

;;; Print a cardinal number in English

(eval-when (:compile-toplevel :execute)
(defmacro cardinal-ones ()
  "Table of cardinal ones-place digits in English"
        '#(nil "one" "two" "three" "four" "five" "six" "seven" "eight" "nine"))
(defmacro cardinal-tens ()
  "Table of cardinal tens-place digits in English"
        '#(nil nil "twenty" "thirty" "forty"
           "fifty" "sixty" "seventy" "eighty" "ninety"))
(defmacro cardinal-teens ()
        '#("ten" "eleven" "twelve" "thirteen" "fourteen"  ;;; RAD
	   "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"))
)


(defun format-print-small-cardinal (stream n)
  (multiple-value-bind (hundreds rem) (truncate n 100)
    (when (plusp hundreds)
      (write-string (svref (cardinal-ones) hundreds) stream)
      (write-string " hundred" stream)
      (when (plusp rem) (stream-tyo stream #\space)))    ; ; ; RAD
    (when (plusp rem)
      (multiple-value-bind (tens ones) (truncate rem 10)
        (cond ((< 1 tens)
               (write-string (svref (cardinal-tens) tens) stream)
               (when (plusp ones)
                 (stream-tyo stream #\-)
                 (write-string (svref (cardinal-ones) ones) stream)))
              ((= tens 1)
               (write-string (svref (cardinal-teens) ones) stream))
              ((plusp ones)
               (write-string (svref (cardinal-ones) ones) stream)))))))

(eval-when (:compile-toplevel :execute)
  (defmacro cardinal-periods ()
    "Table of cardinal 'teens' digits in English"
    '#("" " thousand" " million" " billion" " trillion" " quadrillion"
       " quintillion" " sextillion" " septillion" " octillion" " nonillion" 
       " decillion"))
)


(defun format-print-cardinal (stream n)
  (cond ((minusp n)
         (stream-write-entire-string stream "negative ")
         (format-print-cardinal-aux stream (- n) 0 n))
        ((zerop n)
         (stream-write-entire-string stream "zero"))
        (t (format-print-cardinal-aux stream n 0 n))))

(defun format-print-cardinal-aux (stream n period err)
  (multiple-value-bind (beyond here) (truncate n 1000)
    (unless (<= period 10)
      (format-error "Number too large to print in English: ~:D" err))
    (unless (zerop beyond)
      (format-print-cardinal-aux stream beyond (1+ period) err))
    (unless (zerop here)
      (unless (zerop beyond) (stream-tyo stream #\space))
      (format-print-small-cardinal stream here)
      (stream-write-entire-string stream (svref (cardinal-periods) period)))))


;;; Print an ordinal number in English


(eval-when (:compile-toplevel :execute)
(defmacro ordinal-ones ()
  "Table of ordinal ones-place digits in English"
  '#(nil "first" "second" "third" "fourth"
         "fifth" "sixth" "seventh" "eighth" "ninth"))
(defmacro ordinal-tens ()
  "Table of ordinal tens-place digits in English"
  '#(nil "tenth" "twentieth" "thirtieth" "fortieth"
         "fiftieth" "sixtieth" "seventieth" "eightieth" "ninetieth"))
)

(defun format-print-ordinal (stream n)
  (when (minusp n)
    (stream-write-entire-string stream "negative "))
  (let ((number (abs n)))
    (multiple-value-bind (top bot) (truncate number 100)
      (unless (zerop top) (format-print-cardinal stream (- number bot)))
      (when (and (plusp top) (plusp bot)) (stream-tyo stream #\space))
      (multiple-value-bind (tens ones) (truncate bot 10)
        (cond ((= bot 12) (stream-write-entire-string stream "twelfth"))
              ((= tens 1)
               (stream-write-entire-string stream (svref (cardinal-teens) ones));;;RAD
               (stream-write-entire-string stream "th"))
              ((and (zerop tens) (plusp ones))
               (stream-write-entire-string stream (svref (ordinal-ones) ones)))
              ((and (zerop ones)(plusp tens))
               (stream-write-entire-string stream (svref (ordinal-tens) tens)))
              ((plusp bot)
               (stream-write-entire-string stream (svref (cardinal-tens) tens))
               (stream-tyo stream #\-)
               (stream-write-entire-string stream (svref (ordinal-ones) ones)))
              ((plusp number) (stream-write-string stream "th" 0 2))
              (t (stream-write-entire-string stream "zeroth")))))))


;;; Print Roman numerals

(defun format-print-old-roman (stream n)
  (unless (< 0 n 5000)
          (format-error "Number out of range for old Roman numerals: ~:D" n))
  (do ((char-list '(#\D #\C #\L #\X #\V #\I) (cdr char-list))
       (val-list '(500 100 50 10 5 1) (cdr val-list))
       (cur-char #\M (car char-list))
       (cur-val 1000 (car val-list))
       (start n (do ((i start (progn (stream-tyo stream cur-char) (- i cur-val))))
                    ((< i cur-val) i))))
      ((zerop start))))


(defun format-print-roman (stream n)
  (unless (< 0 n 4000)
          (format-error "Number out of range for Roman numerals: ~:D" n))
  (do ((char-list '(#\D #\C #\L #\X #\V #\I) (cdr char-list))
       (val-list '(500 100 50 10 5 1) (cdr val-list))
       (sub-chars '(#\C #\X #\X #\I #\I) (cdr sub-chars))
       (sub-val '(100 10 10 1 1 0) (cdr sub-val))
       (cur-char #\M (car char-list))
       (cur-val 1000 (car val-list))
       (cur-sub-char #\C (car sub-chars))
       (cur-sub-val 100 (car sub-val))
       (start n (do ((i start (progn (stream-tyo stream cur-char) (- i cur-val))))
                    ((< i cur-val)
                     (cond ((<= (- cur-val cur-sub-val) i)
                            (stream-tyo stream cur-sub-char)
                            (stream-tyo stream cur-char)
                            (- i (- cur-val cur-sub-val)))
                           (t i))))))
      ((zerop start))))


;;; Decimal  ~D

(defformat #\D format-print-decimal (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (format-print-number stream (pop-format-arg) 10 colon atsign parms))


;;; Binary  ~B

(defformat #\B format-print-binary (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (format-print-number stream (pop-format-arg) 2 colon atsign parms))


;;; Octal  ~O

(defformat #\O format-print-octal (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (format-print-number stream (pop-format-arg) 8 colon atsign parms))


;;; Hexadecimal  ~X

(defformat #\X format-print-hexadecimal (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (format-print-number stream (pop-format-arg) 16 colon atsign parms))


;;; Radix  ~R

(defformat #\R format-print-radix (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (let ((number (pop-format-arg)))
       (if parms
           (format-print-number stream number (pop parms) colon atsign parms)
           (if atsign
               (if colon
                   (format-print-old-roman stream number)
                   (format-print-roman stream number))
               (if colon
                   (format-print-ordinal stream number)
                   (format-print-cardinal stream number))))))

;;; FLOATING-POINT NUMBERS


;;; Fixed-format floating point  ~F

(defformat #\F format-fixed (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (when colon
    (format-error "Colon flag not allowed"))
  (with-format-parameters parms ((w nil) (d nil) (k nil) (ovf nil) (pad #\space))
    ;;Note that the scale factor k defaults to nil.  This is interpreted as
    ;;zero by flonum-to-string, but more efficiently.
    (let ((number (pop-format-arg))(*print-escape* nil))
      (if (floatp number)
        (format-fixed-aux stream number w d k ovf pad atsign)
        (if (rationalp number)
          (format-fixed-aux stream (coerce number 'double-float) w d k ovf pad atsign)
          (let ((*print-base* 10))
            (format-write-field stream (princ-to-string number) w 1 0 #\space t)))))))

; do something ad hoc if d > w - happens if (format nil "~15g" (- 2.3 .1))
; called with w = 11 d = 16 - dont do it after all.

(defvar format-digits-limit 100)

(defun format-fixed-aux (stream number w d k ovf pad atsign)  
  (if  (and (floatp number)(nan-or-infinity-p number))  ; perhaps put this back when prin1 is better
    (prin1 number stream)
    (let ((spaceleft w)
          (abs-number (abs number))
          strlen zsuppress flonum-to-string-width)
      (when (and w (or atsign 
                       (or (minusp number)  ;  oh foo -0.0
                           (and (floatp number)
                                (minusp (float-sign number))))))
        (decf spaceleft))
      (when nil ;(and d w (> d w))  ; ad hoc - 5/25 - was wrong pg 589
        (setq d (- w 2)))
      (when (and d w (eq w (1+ d)))
        (setq zsuppress t))
      (when (and d (minusp d))
        (format-error "Illegal value for d"))
      (setq flonum-to-string-width
            (and w
                 (if (and (< abs-number 1) (not zsuppress))
                   (1- spaceleft)   ; room for leading 0
                   spaceleft)))
      (when (and w (not (plusp flonum-to-string-width)))
        (if ovf 
          (progn
            (dotimes (i w) (stream-tyo stream ovf))
            (return-from format-fixed-aux))
          (setq spaceleft nil w nil)))
      (multiple-value-bind (str before-pt after-pt)
                           (flonum-to-string abs-number
                                             flonum-to-string-width
                                             d k)
        (setq strlen (length str))
        ;(print (list 'barf before-pt after-pt))
        (COND 
         ((and (not (or w d)) (> (max (abs before-pt )(abs after-pt)) format-digits-limit))
          (PRIN1 number stream))
         (t 
          
          (cond (w (decf spaceleft (+ (max before-pt 0) 1))
                   (when (and (< before-pt 1) (not zsuppress))
                     (decf spaceleft))
                   (if d
                     (decf spaceleft d)
                     (setq d (max (min spaceleft (- after-pt)) 1)
                           spaceleft (- spaceleft d))))
                ((null d) (setq d (max (- after-pt) 1))))
          (cond ((and w (< spaceleft 0) ovf)
                 ;;field width overflow
                 (dotimes (i w) (declare (fixnum i)) (stream-tyo stream ovf)))
                (t (when w (dotimes (i spaceleft) (declare (fixnum i)) (stream-tyo stream pad)))
                   (if (minusp (float-sign number)) ; 5/25
                     (stream-tyo stream #\-)
                     (if atsign (stream-tyo stream #\+)))
                   (cond
                    ((> before-pt 0)
                     (cond ((> strlen before-pt)
                            (stream-write-string stream str 0 before-pt)
                            (stream-tyo stream #\.)
                            (stream-write-string stream str before-pt strlen)
                            (dotimes (i (- d (- strlen before-pt)))
                              (stream-tyo stream #\0)))
                           (t ; 0's after
                            (stream-write-entire-string stream str)
                            (dotimes (i (-  before-pt strlen))
                              (stream-tyo stream #\0))
                            (stream-tyo stream #\.)
                            (dotimes (i d)
                              (stream-tyo stream #\0)))))
                    (t (unless zsuppress (stream-tyo stream #\0))
                       (stream-tyo stream #\.)
                       (dotimes (i (- before-pt))
                         (stream-tyo stream #\0))
                       (stream-write-entire-string stream str)
                       (dotimes (i (+ d after-pt)) 
                         (stream-tyo stream #\0))))))))))))
#|
; (format t "~7,3,-2f" 8.88)
; (format t "~10,5,2f" 8.88)
; (format t "~10,5,-2f" 8.88)
; (format t "~10,5,2f" 0.0)
; (format t "~10,5,2f" 9.999999999)
; (format t "~7,,,-2e" 8.88) s.b. .009e+3 ??
; (format t "~10,,2f" 8.88)
; (format t "~10,,-2f" 8.88)
; (format t "~10,,2f" 0.0)
; (format t "~10,,2f" 0.123454)
; (format t "~10,,2f" 9.9999999)
 (defun foo (x)
    (format nil "~6,2f|~6,2,1,'*f|~6,2,,'?f|~6f|~,2f|~F"
     x x x x x x))

|#

                  

;;; Exponential-format floating point  ~E


(defformat #\E format-exponential (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (when colon
    (format-error "Colon flag not allowed"))
  (with-format-parameters parms ((w nil) (d nil) (e nil) (k 1) (ovf nil) (pad #\space) (marker nil))
    (let ((number (pop-format-arg)))
      (if (floatp number)
        (format-exp-aux stream number w d e k ovf pad marker atsign)
        (if (rationalp number)
          (format-exp-aux stream (coerce number 'double-float) w d e k ovf pad marker atsign)
          (let ((*print-base* 10))
            (format-write-field stream (princ-to-string number) w 1 0 #\space t)))))))
#|
(defun format-exponent-marker (number)
  (if (typep number *read-default-float-format*)
      #\E
      (cond ((double-floatp) #\D)
            ((short-floatp number) #\S)
            ((single-floatp number) #\F)
            ((long-floatp) #\L))))
|#
(eval-when (eval compile #-bccl load)
  (defmacro format-exponent-marker (number)
    `(float-exponent-char ,number))
)

;;;Here we prevent the scale factor from shifting all significance out of
;;;a number to the right.  We allow insignificant zeroes to be shifted in
;;;to the left right, athough it is an error to specify k and d such that this
;;;occurs.  Perhaps we should detect both these condtions and flag them as
;;;errors.  As for now, we let the user get away with it, and merely guarantee
;;;that at least one significant digit will appear.
;;; THE ABOVE COMMENT no longer applies

(defun format-exp-aux (stream number w d e k ovf pad marker atsign &optional string exp)
  (when (not k) (setq k 1))
  (if (or (not (or w d e marker atsign (neq k 1))) (nan-or-infinity-p number))
    (print-a-float number stream t)
    (prog () 
      (when d
        (when (or (minusp d)
                  (and (plusp k)(>= k (+ d 2)))
                  (and (minusp k)(< k (- d))))
          (format-error "incompatible values for k and d")))
      (when (not exp) (setq exp (scale-exponent  number)))
      AGAIN
      (let* ((expt (- exp k))
             (estr (let ((*print-base* 10))
                     (princ-to-string (abs expt))))
             (elen (max (length estr) (or e 0)))
             (spaceleft (if w (- w 2 elen) nil))
             (fwidth) scale)
        (when (and w (or atsign (minusp (float-sign number)))) ; 5/25
          (setq spaceleft (1- spaceleft)))
        (if w
          (progn 
          (setq fwidth (if d 
                         (if (> k 0)(+ d 2)(+ d k 1))
                         (if (> k 0) spaceleft (+ spaceleft k))))
          (when (minusp exp) ; i don't claim to understand this
            (setq fwidth (- fwidth exp))
            (when (< k 0) (setq fwidth (1- fwidth)))))          
          (when (and d  (not (zerop number))) ; d and no w
            (setq scale (- 2  k exp))))  ; 2 used to be 1  - 5/31
        (when (or (and w e ovf (> elen e))(and w fwidth (not (plusp fwidth))))
          ;;exponent overflow
          (dotimes (i w) (declare (fixnum i)) (stream-tyo stream ovf))
          (if (plusp fwidth)
            (return-from format-exp-aux nil)
            (setq fwidth nil)))
        (when (not string)
          (multiple-value-bind (new-string before-pt) (flonum-to-string number fwidth 
                                                                        (if (not fwidth) d)
                                                                        (if (not fwidth) scale))
            (setq string new-string)
            (when scale (setq before-pt (- (+ 1 before-pt) k scale))) ; sign right?            
            (when (neq exp before-pt)
              ;(print (list 'agn exp before-pt))
              ;(setq string new-string)
              (setq exp before-pt)
              (go again))))
          (let ((strlen (length string)))
            (when w
              (if d 
                (setq spaceleft (- spaceleft (+ d 2)))
                (if (< k 1)
                  (setq spaceleft (- spaceleft (+ 2 (- k)(max strlen 1))))
                  (setq spaceleft (- spaceleft (+ 1 k (max 1 (- strlen k))))))))
            (when (and w (< spaceleft 0))
              (if (and ovf (or (plusp k)(< spaceleft -1)))            
                (progn (dotimes (i w) (declare (fixnum i)) (stream-tyo stream ovf))
                       (return-from format-exp-aux nil))))
            (when w
              (dotimes (i  spaceleft)
                (declare (fixnum i))
                (stream-tyo stream pad)))
            (if (minusp (float-sign number)) ; 5/25
              (stream-tyo stream #\-)
              (if atsign (stream-tyo stream #\+)))
            (cond 
             ((< k 1)
              (when (not (minusp spaceleft))(stream-tyo stream #\0))
              (stream-tyo stream #\.)
              (dotimes (i (- k))
                (stream-tyo stream #\0))
              (if (and (eq strlen 0)(not d))
                (stream-tyo stream #\0)
                (stream-write-entire-string stream string))
              (if d
                (dotimes (i (- (+ d k) strlen))
                  (stream-tyo stream #\0))))
             (t 
              (stream-write-string stream string 0 (min k strlen))
              (dotimes (i (- k strlen))
                (stream-tyo stream #\0))                    
              (stream-tyo stream #\.)
              (when (> strlen k)
                (stream-write-string stream string k strlen))
              (if (not d) 
                (when (<= strlen k)(stream-tyo stream #\0))
                (dotimes (i (1+ (- d k (max 0 (- strlen k)))))
                  (stream-tyo stream #\0)))))
            (stream-tyo stream
                        (if marker
                          marker
                          (format-exponent-marker number)))
            (stream-tyo stream (if (minusp expt) #\- #\+))
            (when e 
              ;;zero-fill before exponent if necessary
              (dotimes (i (- e (length estr)))
                (declare (fixnum i))
                (stream-tyo stream #\0)))
            (stream-write-entire-string stream estr))))))
#|
; (format t "~7,3,,-2e" 8.88) s.b. .009e+3 
; (format t "~10,5,,2e" 8.888888888) ; "88.8889E-1"
; (format t "~10,5,,-2e" 8.88)   "0.00888E+3"
; (format t "~10,5,,-2e" .00123445) ; "0.00123E+0"
; (format t "~10,5,,-3e" .00123445) ; "0.00012E+1"
; (format t "~10,,,-2e" .123445)
; (format t "~10,5,,2e" .0012349999e-4)
; (format t "~10,5,,2e" 9.9999999)
; (format t "~10,5,,2e" 0.0)
; (format t "~10,5,,0e" 40000000.0)
; (format t "~10,5,,2e" 9.9999999)
; (format t "~7,,,-2e" 8.88) s.b. .009e+3 ??
; (format t "~10,,,2e" 8.888888)
; (format t "~10,,,-2e" 8.88)
; (format t "~10,,,-2e" 0.0)
; (format t "~10,,,2e" 0.0) 
; (format t "~10,,,2e" 9.9999999)
; (format t "~10,,,2e" 9.9999999e100)
; (format t "~10,5,3,2,'xe" 10e100)
; (format t "~9,3,2,-2e" 1100.0)
(defun foo (x)
  (format nil
          "~9,2,1,,'*e|~10,3,2,2,'?,,'$e|~9,3,2,-2,'%@e|~9,2e"
          x x x x))
|#


;;; General Floating Point -  ~G

(defformat #\G format-general-float (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (when colon
    (format-error "Colon flag not allowed"))
  (with-format-parameters parms ((w nil) (d nil) (e nil) (k nil) (ovf nil) (pad #\space) (marker nil))
    (let ((number (pop-format-arg)))
      ;;The Excelsior edition does not say what to do if
      ;;the argument is not a float.  Here, we adopt the
      ;;conventions used by ~F and ~E.
      (if (floatp number)
        (format-general-aux stream number w d e k ovf pad marker atsign)
        (if (rationalp number)
          (format-general-aux stream (coerce number 'double-float) w d e k ovf pad marker atsign)
          (let ((*print-base* 10))
            (format-write-field stream (princ-to-string number) w 1 0 #\space t)))))))

#|
; completely broken
(defun foo (x)
  (format nil
          "~9,2,1,,'*g|~10,3,2,2,'?,,'$g|~9,3,2,-2,'%@g|~9,2g"
          x x x x))
|#


(defun format-general-aux (stream number w d e k ovf pad marker atsign)
  (if (nan-or-infinity-p number)
    (prin1 number stream)
    (multiple-value-bind (str n #|after-pt|#)(flonum-to-string number)
      ;;Default d if omitted.  The procedure is taken directly
      ;;from the definition given in the manual, and is not
      ;;very efficient, since we generate the digits twice.
      ;;Future maintainers are encouraged to improve on this.
      (let* ((d2 (or d (max (length str) (min n 7))))
             (ee (if e (+ e 2) 4))
             (ww (if w (- w ee) nil))
             (dd (- d2 n)))
        (cond ((<= 0 dd d2)
               ; this causes us to print 1.0 as 1. - seems weird
               (format-fixed-aux stream number ww dd nil ovf pad atsign)
               (dotimes (i ee) (declare (fixnum i)) (stream-tyo stream #\space)))
              (t (format-exp-aux stream number w d e (or k 1) ovf pad marker atsign nil n)))))))


;;; Dollars floating-point format  ~$

(defformat #\$ format-dollars (stream colon atsign &rest parms)
  (declare (dynamic-extent parms))
  (with-format-parameters parms ((d 2) (n 1) (w 0) (pad #\space))
    (let* ((number (float (pop-format-arg)))
           (signstr (if (minusp (float-sign number)) "-" (if atsign "+" "")))
           (spaceleft)
           strlen)
      (multiple-value-bind (str before-pt after-pt) (flonum-to-string number nil d)
        (setq strlen (length str))
        (setq spaceleft (- w (+ (length signstr) (max before-pt n) 1 d)))
        (when colon (stream-write-entire-string stream signstr))
        (dotimes (i spaceleft) (stream-tyo stream pad))
        (unless colon (stream-write-entire-string stream signstr))
        (cond
         ((> before-pt 0)
          (cond ((> strlen before-pt)
                 (dotimes (i (- n before-pt))
                   (stream-tyo stream #\0))
                 (stream-write-string stream str 0 before-pt)
                 (stream-tyo stream #\.)
                 (stream-write-string stream str before-pt strlen)
                 (dotimes (i (- d (- strlen before-pt)))
                   (stream-tyo stream #\0)))
                (t ; 0's after
                 (stream-write-entire-string stream str)
                 (dotimes (i (-  before-pt strlen))
                   (stream-tyo stream #\0))
                 (stream-tyo stream #\.)
                 (dotimes (i d)
                   (stream-tyo stream #\0)))))
         (t (dotimes (i n)
              (stream-tyo stream #\0))
            (stream-tyo stream #\.)
            (dotimes (i (- before-pt))
              (stream-tyo stream #\0))
            (stream-write-entire-string stream str)
            (dotimes (i (+ d after-pt))
              (stream-tyo stream #\0))))))))

(defun y-or-n-p (&optional format-string &rest arguments &aux response)
  (declare (dynamic-extent arguments))
  (loop
    (when format-string
      (fresh-line *query-io*)
      (apply 'format *query-io* format-string arguments))
    (princ " (y or n)  " *query-io*)
    (setq response (read-char *query-io*))
    (if (char-equal response #\y) (return t))
    (if (char-equal response #\n) (return nil))
    (ed-beep)))

(defun yes-or-no-p (&optional format-string &rest arguments &aux response)
  (declare (dynamic-extent arguments))
  (loop
    (when format-string
      (fresh-line *query-io*)
      (apply 'format *query-io* format-string arguments))
    (princ " (yes or no)  " *query-io*)
    (setq response (read-line *query-io*))
    (when response
      (setq response (string-trim wsp response))
      (if (string-equal response "yes") (return t))
      (if (string-equal response "no") (return nil)))))

