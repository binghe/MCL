; -*- Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-io.lisp,v $
;;  Revision 1.10  2006/02/03 20:10:26  alice
;;  ; write-a-macptr now dares to call handlep which may not crash today
;;
;;  Revision 1.9  2005/05/22 04:01:34  alice
;;  ; write-a-macptr - dont call handlep on OSX since we have no macro (ignore-crashes ...
;;
;;  Revision 1.8  2005/02/02 00:49:51  alice
;;    ; write-pname unicode savvy
;;
;;  Revision 1.7  2004/03/03 17:21:15  gtbyers
;;  Ensure that NAME slot is bound before trying to print CLASS-NAME of class.
;;
;;  Revision 1.6  2003/12/29 04:17:05  gtbyers
;;  PRINT-OBJECT method for SLOT-ID.   Use UNCANONICALIZE-SPECIALIZERS in PRINT-METHOD.
;;
;;  Revision 1.5  2003/12/08 08:31:05  gtbyers
;;  Use CLASS-NAME instead of CCL::%CLASS-NAME.  PRINT-OBJECT method for
;;  SLOT-DEFINITION, EQL-SPECIALIZER objects.
;;
;;  3 7/4/97   akh  see below
;;  2 6/2/97   akh  see below
;;  17 9/26/96 akh  write-pname calls real-xstring-p vs extended-string-p
;;  16 6/7/96  akh  beats me
;;  14 5/20/96 akh  float-exponent-char = quoted types if possible - prefer #\d vs s
;;  13 4/17/96 akh  print-a-float - special case nan's and infinities.
;;  7 11/9/95  akh  delete unused function write-type-and-address
;;  6 11/8/95  slh  nuke extra right-parens
;;  5 11/7/95  akh  ppc mods for print-object, write-a-uvector etc.
;;  3 10/17/95 akh  merge patches
;;  2 10/9/95  akh  write-a-function - dtrt with standard-generic-function
;;  9 3/14/95  akh  write-pname - check for "looks like number" using *read-base* vs *print-base*
;;  7 3/2/95   akh  add a comment in write-perverted-string
;;  6 2/21/95  slh  removed naughty word (file is public now)
;;  5 2/10/95  slh  
;;  4 2/10/95  slh  
;;  3 2/10/95  slh  write-a-macptr extended for terminables
;;  (do not edit before this line!!)

;; L1-io.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;
; fix write-pname for  #:|6|
; ------- 5.2b6
; write-a-macptr now dares to call handlep which may not crash today
; write-a-macptr - dont call handlep on OSX since we have no macro (ignore-crashes ...
; write-pname unicode savvy
;; --------- 5.1 final
; write-a-macptr says window or port or menu ptr on OSX or always
; --------- 5.0 final
; 12/27/01 akh fix write-a-macptr for case where handlesize may be a secret on osx
; --------- 4.4b2
; 06/01/00 akh %lfun-name-string may say interpreted
;---------
; 07/10/99 akh write-pname and write-perverted-string only make fat string if needed
; --------- 4.3b3
; 05/12/99 akh write-string checks start >= 0
; ---------------- 4.3b1
; 01/30/99 akh write-a-structure deal with :print-object as well as :print-function
; 06/23/97 akh write-pname only slashify # when first, per alanr request
; 05/17/97 akh  write-pname does the right thing re print-case when escaped
; 05/01/97 akh  print-a-nan uses #f if *print-readably* is true, #f knows how to make de nan
; 05/24/96 bill slh's addition of write-a-dead-macptr to (method print-object (t t))
; 04/14/96 akh  add print-a-nan called by print-a-float
; 04/07/96 gb   recognize ppc block-tags/go-tags in PRINT-OBJECT T
; 03/26/96 gb   %lfun-name-string: kernel-function-p has nothing to do with A5.
; 03/07/96 bill (method print-object (value-cell t))
; 12/06/95 slh  no uvrefs for ratio/complex
; 11/10/95 gb   put parens in the right place.
; 10/20/95 slh  de-lapified: bogus-thing-p & friends -> level-0
;  4/10/95 gb   %IN-GSPACE-P and %IN-ISPACE-P check static space as well
;-------------  3.0d18
;  2/28/95 slh  %write-macptr-termination-info stub
;-------------  3.0d17
; 06/04/93 bill write-a-structure ignores *print-structure* if *print-readtably* is true.
;-------------  3.0d11
; 04/07/93 bill doc for *print-array* says nothing but strings will ever be printed if it is NIL.
;               Hence, the AND was correct. Change it back.
;  ??	   alice one of the clauses in write-an-array had (and print-array..) stead of OR
; 02/22/93 bill  print-a-float no longer prints a "." after the exponent
;                when *print-radix* is true.
; 10/20/92  gb   new bogus-thing-p; print stack groups.
;--------------- 2.0
; 02/22/92 (alice from "post 2.0f2c5:default-float-patch") dtrt with 
;                *read-default-float-format* in PRINT-A-FLOAT.
; 02/22/92 (alice from "post 2.0f2c5:print-readablly-patch")
;                fix print-array when *print-readably* in GET-*PRINT-FROB*.
; -------------- 2.0f2c5
; 12/31/91 gb    Add BOGUS-THING-P and make WRITE-INTERNAL call it.
; 12/14/91 alice write-a-function knows about interpreted methods, add print-object for interpreted-method-function
; -------------- 2.0b4
; 11/21/91 bill  A null END argument to write-string means the length of the string.
; 11/11/91 gb    write-a-structure uses superclasses' print-function, maybe.
; 11/07/91 alice adapt print-a-float to new flonum-to-string
; 10/10/91 alice call pretty-structure and pretty-array from here so users print-objects will be called
; 10/04/91 alice write-a-structure no space if no slots
; 09/30/91 alice *print-simple-vector* etal - do nil correctly, %print-unreadable-object had extra space
; 09/26/91 alice princ also binds *print-circle* to nil
; 09/09/91 alice princ binds *print-readably* nil - do we like it?  moon and guy do, must be right
; --------- 2.0b3
;08/24/91 gb    use new traps.
;08/21/91 alice nuke bogus def of xp-structure-p
;07/29/91 alice print-level truncate instead of error in print-method and write-1
;07/21/91 gb    xp-structures aren't.
;07/25/91 alice backtranslate-level defend against nil
;07/18/91 alice print-a-float - if exp-p say E+n for format ~E
;07/09/91 alice write-internal-1 (xp-stream) and write-not-pretty: let em tail-call
;07/01/91 alice fix *print-readably* in write-an-array, get-*print-frob* lies if *print-readably* is T
;06/25/91 bill  Make user generic-function classes print recognizeably.
;06/07/91 bill  print-object for standard-class instances no longer errors in find-class
;06/11/91 alice write-pname do readcase :preserve & :invert,
;	fix  readcase = :downcase  & print-case = :upcase or :capitalize
;05/25/91 gb    write-internal was trusting (DECLARE DOWNWARD-FUNCTION) too much.
;               Leave Burbank. 
;05/20/91 gb    Print resource type & id when handle is resource.  Be aware of
;               short floats.
;05/11/91 alice nuke write-aux-stream, add xp-stream, integrate with new pprint
;03/05/91 alice all but one report-bad-arg gets 2 args
; 02/18/91 gb    %uvsize -> uvsize.
;--------------- 2.0b1
;;01/21/91 bill in write-a-function: remove extraneous space in closure printing.
; 01/17/91 alice change print-a-float for new float-string (he counts the zeros now)
; 01/14/91 alice fix print of floats. Not always fixed format. But do use flonum-to-string
;------- 2.0 a5 (d83)
;;12/13/90 gb    use flonum-to-string vice %float-to-string. Tell it fmin 1 fract digit, signp
;;11/27/90 alice write-a-function knows about interpreted functions
;;11/20/90 bill  write-pname buffers its output instead of stream-tyo (faster that way).
;;               %write-string knows how to write a character, too.
;;10/24/90 bill  print go-tags.
;;10/16/90 gb    write-aux-stream is an output-stream; no more %str-length.
;;10/16/90 bill  Make anonymous method-function's print without error.
;;10/10/90 bill  use stream-writer vice stream-write-string in write-escaped-string
;;               for better interruptability.
;;09/27/90 bill  write-internal was heap-consing a closure.
;;09/26/90 bill  add CLASS-WRAPPER to WRITE-AN-ISTRUCT, print block-tag's
;;09/19/90 bill  eliminate double-space in #<Anonymous function  #xnnnnnn> and
;;               #<Compiled-function FOO (Non-Global)  #xnnnnnn>
;;08/28/90 alice remove some obsolete stuff from  write-a-function
;;09/12/90 bill  *signal-printing-errors*
;;09/08/90 bill  Glitch in printing method-functions
;;09/05/90 bill  (method print-object (standard-method t)) prints the name of
;;               the method's class instead of "Method".
;;08/02/90 gb    minor fix to write-a-macptr.
;;07/17/90 alice minor fix to write-a-function
;;07/02/90 bill  (method print-object (method-function t))
;;06/30/90 bill  method-function now points back at method.
;;06/13/90 bill  write-a-macptr writes address inside of the macptr.
;;06/08/90 gb    print-unreadable-object: keyword name is :identity, not :id.
;;               write-a-functions uses print-unreadable-object again.
;;               %lfun-name-string made even more evil.
;; 06/06/90 alice fix write-a-function
;;06/07/90  bill (type string-char delim) -> (type character delim)
;;06/05/90  bill Fix *print-level* handling.
;;06/02/90  bill Make lfun-name-string handle generic-function's
;;05/30/90  gb   clear-input returns NIL.
;;05/30/90  gb   use print-unreadable-object at the slightest provocation.  Accept
;;               more keyword args in write[-to-string].
;; 05/25/90 alice bugger write-a-function for encapsulations
;;05/10/90  gb   write-pname: consecutive escaped chars merit vertical bars.
;;05/04/90  bill Recursive printer error handler
;;05/03/90  gz   Change base-character declarations to character declarations.  Just because
;;               a character comes from a string doesn't mean it's a base-character....
;;               (someday, that might be true.)
;;04/02/90  gz   No more *write-istruct-alist*, let them eat CLOS.
;;90/04/30  gb   ignore BASE-CHARACTER declarations.   Half-change write-pname to interact
;;               ;; with new studly readtable. ;;
;;3/12/90 bill   optimise write-escaped-string by using stream-write-string on pieces of string!
;;01-Jan-89 gz   Use uvectorp.  #-bccl require in get-write-aux-stream.
;;27-Dec-89 gz   Allow non-symbolic function names.
;;23-Dec-89 gz   No more %method-function-method, so no more write-a-method-function.
;;09-Dec-89 Mly  Repair write-pname BD.
;;08-Dec-89 bill Mly's minor tweaks to print-object & write-a-uvector
;;07-Dec-89 bill remove standard-method from function-is-current-definition? (methods are
;;               no longer functionp).
;;               In (method print-object (combined-method t)): specializers are no longer
;;               stored in a combined-method.
;;11/17/89  gz   stream-tyo arg order.  Flush %print, %print-to, %write.
;;               structure mods.
;;20-Nov-89 Mly  Reinstate *print-structure*
;;12-Nov-89 Mly  Moved *name-char-alist* to l1-readloop
;;               *write-istruct-alist*  (hash-tables not loaded yet.  SIgh.)
;;01-Nov-89 bill Typos in write-a-symbol-locative, write-a-uvector,
;;               (method stream-write-string (write-aux-stream))
;;30-Oct-89 bill rename pr-%print-hash-table to write-a-hash-table & add stream arg.
;;               pr-%print-random-state => write-a-random-state & ditto.
;;               pr-%print-pathname => write-a-pathname & ditto.
;;28-Oct-89 bill Added support for new methods, method-functions, combined-methods.
;;               Added traps for generic-function, & metaobject which are now of type
;;               standard-object, but represented very differently
;;25-Oct-89 Mly  Flush %write-char,%write-strings. Always pass stream arg. Flush vestigial ASK.
;;               Never call FORMAT.  write-an-integer.  Make some things print %address-of
;;               Use correct level in (method print-object (t t))
;;               Don't bind *standard-output*.  Fix callers instead!
; 09/17/89  gb   No more $sym.gfunc.
;  05/25/89 gb   What's a "flavors-instance" ?
;;11-oct-89 bill This is Richard's printer from 1.3.  The old 2.0 printer is dead.
;;03-oct-89 bill (%uvref structure 0) is a symbol in 2.0, not a cons as in 1.3.
;;01-oct-89 bill (method stream-write-string (write-aux-stream)):
;;               Pass off the stream-write-string for-stream instead of tyo
;;30-sep-89 bill Rename from write.lisp to l1-io.lisp and replace old printer.
;;28-sep-89 bill Finish up conversion.  Use stream-write-string when possible
;;25-sep-89 bill convert to clos for lisp 2.0
;;  4-sep-89 Mly randomise write-a-structure/write-a-truly-random-frob
;;               fix write-a-symbol for *print-escape* t, *print-case* :downcase
;; 21-jul-89 as  bind *load-verbose* to nil when loading pprint
;;30-jun-89  as  bind *print-pretty* to nil when requiring pprint
;; 23-jun-89 mly (and *print-string-length* *print-array*)
;; 18-jun-89 mly check-circle does list-kludge hacks
;;               cache tyo method in loops.  " . " -> (pp-space) "." (pp-space)
;; 12-jun-89 mly general uvector printing and structure care.  *write-uvector-alist*
;;           (pcl can use this)
;; 11-jun-89 as have+setf -> have
;;  6-jun-89 jaj fixed printing of random-states

(eval-when (:compile-toplevel :execute)
  (require "NUMBER-MACROS"))


;;;; ======================================================================
;;;; Standard CL IO frobs

(defun eofp (&optional (stream *standard-input*))
  (stream-eofp stream))

(defun force-output (&optional (stream *standard-output*))
  (stream-force-output (real-print-stream stream))
  nil)

(defun listen (&optional (stream *standard-input*))
  (stream-listen (real-print-stream stream)))

(defun close (stream &key abort)
  (setq stream (real-print-stream stream))
  (if abort (stream-abort stream))
  (stream-close stream))

(defun fresh-line (&optional (stream *standard-output*))
  (stream-fresh-line (real-print-stream stream)))

(defun clear-input (&optional stream)
  (stream-clear-input (cond ((null stream) *standard-input*)
                            ((eq stream t) *terminal-io*)
                            (t stream)))
  nil)

(defun write-char (char &optional (output-stream nil))
  (stream-tyo (real-print-stream output-stream) char)
  char)

(defun write-string (string &optional output-stream &key (start 0) end)
  (let ((length (length string)))
    (declare (fixnum length))
    (if (not end)
      (setq end length)
      (when (> end length)
        (require-type end `(integer 0 ,length))))
    (unless (and (fixnump start)
                 (locally (declare (type fixnum start end))
                   (and (>= start 0) (<= start end))))
      (setq start (require-type start `(integer 0 ,end))))  
    (stream-write-string (real-print-stream output-stream)
                         string start end)
    string))

(defun write-line (string &optional output-stream
                          &key (start 0) (end (length string)))
  (let ((stream (real-print-stream output-stream)))
    (write-string string stream :start start :end end)
    (terpri stream)
    string))

(defun terpri (&optional (stream *standard-output*))
  (stream-tyo (real-print-stream stream) (or *preferred-eol-character* #\return))
  nil)

;;;; ----------------------------------------------------------------------


(defun tyo (char &optional (stream *standard-output*))
  (stream-tyo stream char))

(defun tyi (&optional (stream *standard-input*))
  (stream-tyi stream))

(defun untyi (char &optional (stream *standard-input*))
  (stream-untyi stream char)
  nil)



;;;; ======================================================================
;;;; The Lisp Printer


;; coral extensions
(defvar *print-abbreviate-quote* t
  "Non-NIL means that the normal lisp printer --
not just the pretty-printer -- should print
lists whose first element is QUOTE or FUNCTION specially.
This variable is not part of standard Common Lisp.")

(defvar *print-structure* t
  "Non-NIL means that lisp structures should be printed using
\"#S(...)\" syntax.  if nil, structures are printed using \"#<...>\".
This variable is not part of standard Common Lisp.")

;; things Richard Mlynarik likes.
(defvar *print-simple-vector* nil
  "Non-NIL means that simple-vectors whose length is less than
the value of this variable are printed even if *PRINT-ARRAY* is false.
this variable is not part of standard Common Lisp.")

(defvar *print-simple-bit-vector* nil
  "Non-NIL means that simple-bit-vectors whose length is less than
the value of this variable are printed even if *PRINT-ARRAY* is false.
This variable is not part of standard Common Lisp.")

(defvar *print-string-length* nil
  "Non-NIL means that strings longer than this are printed
using abbreviated #<string ...> syntax.
This variable is not part of standard Common Lisp.")

(defvar *print-escape* t
  "Non-NIL means that the lisp printer should -attempt- to output
expressions `readably.'  When NIL the attempts to produce output
which is a little more human-readable (for example, pathnames
are represented by the characters of their namestring.)")

(defvar *print-pretty* nil
  "Non-NIL means that the lisp printer should insert extra
indentation and newlines to make output more readable and `prettier.'")

(defvar *print-base* 10.
  "The output base for integers and rationals.
Must be an integer between 2 and 36.")

(defvar *print-radix* nil
  "Non-NIL means that the lisp printer will explicitly indicate
the output radix (see *PRINT-BASE*) which is used to print
integers and rational numbers.")

(defvar *print-level* nil
  "Specifies the depth at which printing of lisp expressions
should be truncated.  NIL means that no such truncation should occur.
Truncation is indicated by printing \"#\" instead of the
representation of the too-deeply-nested structure.
See also *PRINT-LENGTH*")

(defvar *print-length* nil
  "Specifies the length at which printing of lisp expressions
should be truncated.  NIL means that no such truncation should occur.
truncation is indicated by printing \"...\" instead of the
rest of the overly-long list or vector.
See also *PRINT-LEVEL*")

(defvar *print-circle* nil
  "Non-NIL means that the lisp printer should attempt to detect
circular structures, indicating them by using \"#n=\" and \"#n#\" syntax.
If this variable is false then an attempt to
output circular structure may cause unbounded output.")

(defvar *print-case* ':upcase
  "Specifies the alphabetic case in which symbols should
be printed.  Possible values include :UPCASE, :DOWNCASE and :CAPITALIZE") ; and :StuDLy

(defvar *print-array* t
  "Non-NIL means that arrays should be printed using \"#(...)\" or
\"=#nA(...)\" syntax to show their contents.
If NIL, arrays other than strings are printed using \"#<...>\".
See also the (non-Common Lisp) variables *PRINT-SIMPLE-VECTOR*
and *PRINT-SIMPLE-BIT-VECTOR*")

(defvar *print-gensym* t
  "Non-NIL means that symbols with no home package should be
printed using \"#:\" syntax.  NIL means no prefix is printed.")

(defvar *print-readably* nil
  "Non-NIL means that attempts to print unreadable objects
   signal PRINT-NOT-READABLE errors.  NIL doesn't.")

(defvar *PRINT-RIGHT-MARGIN* nil
  "+#/NIL the right margin for pretty printing")

(defvar *PRINT-MISER-WIDTH* 40.
  "+#/NIL miser format starts when there is less than this width left")

(defvar *PRINT-LINES* nil
  "+#/NIL truncates printing after # lines")

(defvar *DEFAULT-RIGHT-MARGIN* 70
  "Controls default line length;  Must be a non-negative integer")

(defvar *PRINT-PPRINT-DISPATCH* nil) ; We have to support this.

(defvar *xp-current-object* nil)  ; from xp

(defvar *circularity-hash-table* nil) ; ditto

(defvar *current-level* nil)

(defvar *current-length* nil) ; must be nil at top level


;;;; ======================================================================

(defclass xp-stream (output-stream)
   (xp-structure))

(defun %write-string (string stream)
  (if (characterp string)
    (stream-tyo stream string)
    (stream-write-entire-string stream string)))

;(defun %write-strings (stream &rest strings)
;  (declare (dynamic-extent strings))
;  (dolist (s strings)
;    (%write-string s stream)))

;; *print-simple-vector*
;; *print-simple-bit-vector*
;; *print-string-length*
;; for things like *print-level* which must [no longer] be integers > 0
(defun get-*print-frob* (symbol
                         &optional (nil-means most-positive-fixnum)
                         (t-means nil))
  (declare (type symbol symbol))
  (let ((value (symbol-value symbol)))
    (when *print-readably*
      (case symbol
        ((*print-length* *print-level* *print-lines* *print-string-length*)
         (setq value nil))
        ((*print-escape* *print-gensym* *print-array* *print-simple-vector*
                         *print-simple-bit-vector*)
         (setq value t))
        (t nil)))
    (cond ((null value)
           nil-means)
          ((and (integerp value)) ; (> value 0))
           (min (max value -1) value most-positive-fixnum))
          ((and t-means (eq value 't))
           t-means)
          (t
           (setf (symbol-value symbol) nil)
           (error "~s had illegal value ~s.  reset to ~s"
                  symbol value 'nil)))))


(defun pp-newline (stream kind)
  (case kind
    ((:newline)
     (stream-fresh-line stream))
    ((:unconditional :mandatory)
     (stream-tyo stream (or *preferred-eol-character* #\return)))
    (t nil)))



(defun pp-space (stream &optional (newline-kind ':fill))
  (stream-tyo stream #\space)
  (pp-newline stream newline-kind))

(defun pp-start-block (stream &optional prefix)
  (cond ((null prefix))
        ((characterp prefix)
         (stream-tyo stream prefix))
        ((stringp prefix)
         (%write-string prefix stream))
        (t (report-bad-arg prefix '(or character string (eql nil))))))


(defun pp-end-block (stream &optional suffix)
  (cond ((null suffix))
        ((characterp suffix)
         (stream-tyo stream suffix))
        ((stringp suffix)
         (%write-string suffix stream))
        (t (report-bad-arg suffix '(or character string (eql nil))))))


#|
(defmethod pp-set-indentation ((stream stream) kind n)
  (declare (ignore kind n))
  nil)
|#


;;;; ======================================================================
;; list-kludge is so that we can simultaneously detect shared list tails
;;   and avoid printing lists as (foo . (bar . (baz . nil)))
;; if non-nil, it is the remaining *print-length* and object is
;;   a list tail



(defmethod write-internal-1 ((stream stream) object level list-kludge)
  (declare (type fixnum level) (type (or null fixnum) list-kludge))
  ;;>> Anybody passing in list-kludge had better be internal to the lisp printer.
  ;(if list-kludge (error "Internal printer error"))
    (let ((circle *print-circle*)
          (pretty *print-pretty*))
      (cond ((or pretty circle)
             ; what about this level stuff??
             ; most peculiar
             (maybe-initiate-xp-printing
              #'(lambda (s o) (write+ o s)) stream object))
            ((not list-kludge)
             (write-a-frob object stream level list-kludge))
            ((null object))
            (t
             (stream-tyo stream #\space)
             (when (not (consp object))
               (stream-tyo stream #\.)
               (stream-tyo stream #\space))
             (write-a-frob object stream level list-kludge)))))



(defmethod write-internal-1 ((stream xp-stream) object level list-kludge)
  (when level
    (setq *current-level* (if (and *print-level* (not *print-readably*))
                            (- *print-level* level)
                            0)))
  (write+ object (slot-value stream 'xp-structure) list-kludge))


(defvar *inside-printer-error* nil)

(defvar *signal-printing-errors* nil)
(queue-fixup (setq *signal-printing-errors* t))

(defun write-internal (stream object level list-kludge)
  (if (bogus-thing-p object)
    (print-unreadable-object
      (object stream)
      (princ (%str-cat "BOGUS object @ #x" (%integer-to-string (%address-of object) 16.)) 
             stream))
    (progn
      (flet ((handler (condition)
               (declare (ignore condition))
               (unless *signal-printing-errors*
                 (return-from write-internal
                   (let ((*print-pretty* nil)
                         (*print-circle* nil))
                     (if *inside-printer-error*
                       (if (eql 1 (incf *inside-printer-error*))
                         (%write-string "#<Recursive printing error>" stream))
                       (let ((*inside-printer-error* 0))
                         ; using format here considered harmful.
                         (%write-string "#<error printing " stream)
                         (write-internal stream (type-of object) (max level 2) nil)
                         (stream-tyo stream #\space)
                         (%write-address (%address-of object) stream)
                         (stream-tyo stream #\>))))))))
        (declare (dynamic-extent #'handler))
        (handler-bind
          ((error #'handler))
          (write-internal-1 stream object level list-kludge)))
      object)))

#|
(defun write-abbreviation (stream object kind)
  (declare (ignore object))
  (cond ((stringp kind)
         (%write-string kind stream))
        (t;(and (integerp kind) (> kind 0))
         (stream-tyo stream #\#)
         (%pr-integer kind 10. stream)
         (stream-tyo stream #\#))))
|#

;;;; ======================================================================
;;;; internals of write-internal

;; bd common-lisp (and lisp machine) printer depth counts
;;  count from 0 upto *print-level* instead of from
;;  *print-level* down to 0 (which this printer sensibly does.)
(defun backtranslate-level (level)
  (let ((print-level (get-*print-frob* '*print-level*)))
    (if (not (and level print-level))
      most-positive-fixnum
      (if (> level print-level)
        ;; wtf!
        1
        (- print-level level)))))

; so we can print-circle for print-object methods.
(defvar %current-write-level% nil)
(defvar %current-write-stream% nil)
(defun %current-write-level% (stream &optional decrement?)
  (if (eq stream %current-write-stream%)
    (if decrement? (1- %current-write-level%) %current-write-level%)
    (get-*print-frob* '*print-level*)))
      
;;>> Some notes:
;;>> CL defining print-object to be a multmethod dispatching on
;;>>  both the object and the stream just can't work
;;>> There are a couple of reasons:
;;>>  - CL wants *print-circle* structure to be automatically detected
;;>>    This means that there must be a printing pre-pass to some stream
;;>>    other than the one specified by the user, which means that any
;;>>    print-object method which specialises on its second argument is
;;>>    going to lose big.

;;>>  - CL wants *print-level* truncation to happen automatically
;;>>    and doesn't pass a level argument to print-object (as it should)
;;>>    This means that the current level must be associated with the
;;>>    stream in some fashion.  The quicky kludge Bill uses here
;;>>    (binding a special variable) loses for
;;>>    + Entering a break loop whilst printing to a stream
;;>>      (Should start level from (get-*print-level*) again)
;;>>    + Performing output to more than one stream in an interleaved fashion
;;>>      (Say a print-object method which writes to *trace-output*)
;;>>    The solution, again, is to actually call the print-object methods
;;>>    on a write-aux-stream, where that stream is responsible for
;;>>    doing *print-level* truncation.
;;>>  - BTW The select-method-order should be (stream object) to even have
;;>>    a chance of winning.  Not that it could win in any case, for the above reasons.
;;>> It isn't that much work to change the printer to always use an
;;>> automatically-level-truncating write-aux-stream
;;>> It is a pity that CL is so BD.
;;>>

(defun write-a-frob (object stream level list-kludge)
  (declare (type stream stream) (type fixnum level)
           (type (or null fixnum) list-kludge))
  (cond ((not list-kludge)
         (let ((%current-write-stream% stream)   ;>> SIGH
               (%current-write-level% level))
           (print-object object stream)))
        ((%i< list-kludge 1)
         ;; *print-length* truncation
         (stream-write-entire-string stream "..."))
        ((not (consp object))
         (write-a-frob object stream level nil))
        (t
         (write-internal stream (%car object) level nil)
         ;;>> must do a tail-call!!
         (write-internal-1 stream (%cdr object) level (%i- list-kludge 1)))))

(defmethod print-object ((object t) stream)
  (let ((level (%current-write-level% stream))   ; what an abortion.  This should be an ARGUMENT!
        (%type (%type-of object)))
    (declare (type symbol %type)
             (type fixnum level))
    (flet ((depth (stream v)
             (declare (type fixnum v) (type stream stream))
             (when (%i<= v 0)
               ;; *print-level* truncation
               (stream-write-entire-string stream "#")
               t)))
      (cond
        ((eq %type 'cons)
         (unless (depth stream level)
           (write-a-cons object stream level)))
        ((or (eq %type 'symbol) (null object))
         ;; Don't do *print-level* truncation;
         ;;  even though strictly necessary it's pretty pointless for symbols
         (write-a-symbol object stream))
        ((depth stream level))
        ((eq %type 'package)
         (write-a-package object stream))
        ((eq %type 'buffer-mark)
         (write-a-mark object stream level))
        ((eq %type 'macptr)
         (write-a-macptr object stream))
        ((eq %type 'dead-macptr)
         (write-a-dead-macptr object stream))
        ((eq %type 'internal-structure)
         (write-an-istruct object stream level))        
        ((and (eq %type 'structure)
              (not (null (ccl::struct-def object))))  ; ??
         ;; else fall through to write-a-uvector
         (if (and *print-pretty* *print-structure*)
           (let ((*current-level* (if (and *print-level* (not *print-readably*))
                                    (- *print-level* level)
                                    0)))
             (pretty-structure stream object)) 
           (write-a-structure object stream level)))
        ((functionp object)
         (write-a-function object stream level))
        ((arrayp object)
         (cond ((or (not (stringp object))
                    (%i> (length (the string object))
                         (get-*print-frob* '*print-string-length*)))
                (write-an-array object stream level))
               ((or *print-escape* *print-readably*)
                (write-escaped-string object stream))
               (t
                (%write-string object stream))))
        #-ppc-target ; won't happen ?? but avoid compiler warns??
        ((eq %type 'symbol-locative)
         (write-a-symbol-locative object stream)) ; whazzat        
        ((uvectorp object)  ; in ppc land this is catch all for misc - pretty much same as 68k here.
         ; does e.g. population, pool, hash-table-vector
         (write-a-uvector object stream level))
        (t
         (print-unreadable-object (object stream)
           (let* ((address (%address-of object))
                  (low-bits (logand #xff address)))
             (cond ((eq object (%unbound-marker-8))
                    (%write-string "Unbound" stream))
                   (t
                    (cond ; whats this business - does it apply this year?
                     ((eq #+ppc-target ppc::subtag-block-tag #-ppc-target $block-tag low-bits)
                      (%write-string "BLOCK-TAG " stream))
                     ((eq #+ppc-target ppc::subtag-go-tag #-ppc-target $go-tag low-bits)
                      (%write-string "GO TAG " stream))
                     (t
                      (%write-string "Unprintable " stream)
                      (write-a-symbol %type stream)
                      (%write-string " : " stream)))
                    (%write-address address stream))))))))
    nil))

(defun write-a-dead-macptr (macptr stream)
  (print-unreadable-object (macptr stream)
    (%write-string "A Dead Mac Pointer" stream)))


;;;; ======================================================================
;;;; Powerful, wonderful tools for printing unreadable objects.

(defun print-not-readable-error (object stream)
  (error (make-condition 'print-not-readable :object object :stream stream)))

; Start writing an unreadable OBJECT on STREAM, error out if *PRINT-READABLY* is true.
(defun write-unreadable-start (object stream)
  (if *print-readably* 
    (print-not-readable-error object stream)
    (pp-start-block stream "#<")))

(defun %print-unreadable-object (object stream type id thunk)
  (write-unreadable-start object stream)
  (when type
    (princ (type-of object) stream))
  (when thunk 
    (when type (tyo #\space stream))
    (funcall thunk))
  (if id
    (%write-address object stream #\>)
    (pp-end-block stream ">")))

;;;; ======================================================================
;;;; internals of internals of write-internal

(defmethod print-object ((char character) stream &aux name)
  (cond ((or *print-escape* *print-readably*)   ;print #\ for read-ability
         (stream-tyo stream #\#)
         (stream-tyo stream #\\)
         (if (setq name (char-name char))
             (%write-string name stream)
             (stream-tyo stream char)))
        (t
         (stream-tyo stream char))))

(defun get-*print-base* ()
  (let ((base *print-base*))
    (unless (and (fixnump base)
                 (%i< 1 base) (%i< base 37.))
      (setq *print-base* 10.)
      (error "~S had illegal value ~S.  Reset to ~S"
             '*print-base* base 10))
    base))

(defun write-radix (base stream)
  (stream-tyo stream #\#)
  (case base
    (2 (stream-tyo stream #\b))
    (8 (stream-tyo stream #\o))
    (16 (stream-tyo stream #\x))
    (t (%pr-integer base 10. stream)
       (stream-tyo stream #\r))))

(defun write-an-integer (num stream
                         &optional (base (get-*print-base*))
                                   (print-radix *print-radix*))
  (when (and print-radix (not (eq base 10)))
    (write-radix base stream))
  (%pr-integer num base stream)
  (when (and print-radix (eq base 10))
    (stream-tyo stream #\.)))

(defmethod print-object ((num integer) stream)
  (write-an-integer num stream))

(defun %write-address (object stream &optional foo)
  (if foo (pp-space stream))
  (write-an-integer (if (integerp object) object (%address-of object)) stream 16. t)
  (if foo (pp-end-block stream foo)))

(defmethod print-object ((num ratio) stream)
  (let ((base (get-*print-base*)))
    ;;>> What to do when for *print-radix* and *print-base* = 10?
    (when (and *print-radix* (not (eq base 10)))
      (write-radix base stream))
    (%pr-integer (numerator num) base stream)
    (stream-tyo stream #\/)
    (%pr-integer (denominator num) base stream)))

;;>> Doesn't do *print-level* truncation
(defmethod print-object ((c complex) stream)
  (pp-start-block stream "#c(")
  (print-object (realpart c) stream)
  (pp-space stream)
  (print-object (imagpart c) stream)
  (pp-end-block stream #\)))

(defmethod print-object ((float float) stream)
  (print-a-float float stream))

(defun float-exponent-char (float)
  (if (case *read-default-float-format*
        (single-float (typep float 'single-float))
        (double-float (typep float 'double-float))
        (t (typep float *read-default-float-format*)))
    #\E  
    (if (typep float 'double-float)
      #\D
      #\S)))

(defun default-float-p (float)
  (case *read-default-float-format*
        (single-float (typep float 'single-float))
        (double-float (typep float 'double-float))
        (t (typep float *read-default-float-format*))))

#| ;; moved to number-macros
(defmacro without-float-invalid (&body body)
  (let ((flags (gensym)))
    `(let ((,flags (%get-fpscr-control)))
       (unwind-protect
         (progn (%set-fpscr-control (logand (lognot (ash 1 (- 31 ppc::fpscr-ve-bit))) ,flags))
                ,@body)
         (%set-fpscr-status 0) ; why do we need this? status bits get set in any case?
         (%set-fpscr-control ,flags)))))
|#
          
  

; maybe should be more specific
(defun print-a-nan (float stream)
  (if *print-readably*
    (progn
      (stream-write-entire-string stream "#F")
      (prin1
       (if (typep float 'short-float)
         (multiple-value-bind (mant exp sign)(fixnum-decode-short-float float)
           (declare (ignore exp))
           (list (if (infinity-p float) :infinity :nan)
                 :short
                 (logand mant #x7fffff)
                 (if (eq sign 0) 1 -1)))
         (multiple-value-bind (hi lo exp sign)(fixnum-decode-float float)
           (declare (ignore exp))
           (list (if (infinity-p float) :infinity :nan)
                 :double
                 (logior (ash (logand hi #xFFFFFF) 28) lo)
                 sign)))
       stream))
    (progn
      (stream-write-entire-string stream (if (infinity-p float)
                                           "#<INFINITY "
                                           "#<NaN "))
      ; print it with invalid-operation disabled
      (without-float-invalid
        (print-a-float float stream nil t))
      (stream-tyo stream #\>))))
             
;; nanning => recursive from print-a-nan - don't check again
(defun print-a-float (float stream &optional exp-p nanning)
  (let ((strlen 0) (exponent-char (float-exponent-char float)))
    (declare (fixnum exp strlen))
    (Setq stream (real-print-stream stream))
    (if (and (not nanning)(nan-or-infinity-p float))
      (print-a-nan float stream)    
      (multiple-value-bind (string before-pt #|after-pt|#)
                           (flonum-to-string float)
        (declare (fixnum before-pt after-pt))
        (setq strlen (length string))
        (when (minusp (float-sign float))
          (stream-tyo stream #\-))
        (cond
         ((and (not exp-p) (zerop strlen))
          (stream-write-entire-string stream "0.0"))
         ((and (> before-pt 0)(<= before-pt 7)(not exp-p))
          (cond ((> strlen before-pt)
                 (stream-write-string stream string 0 before-pt)
                 (stream-tyo stream #\.)
                 (stream-write-string stream string before-pt strlen))
                (t ; 0's after
                 (stream-write-entire-string stream string)
                 (dotimes (i (-  before-pt strlen))
                   (stream-tyo stream #\0))
                 (stream-write-entire-string stream ".0"))))
         ((and (> before-pt -3)(<= before-pt 0)(not exp-p))
          (stream-write-entire-string stream "0.")
          (dotimes (i (- before-pt))
            (stream-tyo stream #\0))
          (stream-write-entire-string stream string))
         (t
          (setq exp-p t)
          (stream-tyo stream (if (> strlen 0)(char string 0) #\0))
          (stream-tyo stream #\.)
          (if (> strlen 1)
            (stream-write-string stream string 1 strlen)
            (stream-tyo stream #\0))
          (stream-tyo stream exponent-char)
          (when (and exp-p (not (minusp (1- before-pt))))
            (stream-tyo stream #\+))
          (let ((*print-base* 10)
                (*print-radix* nil))
            (princ (1- before-pt) stream))))
        (when (and (not exp-p)
                   (not (default-float-p float)))
          (stream-tyo stream exponent-char)
          (stream-tyo stream #\0))))))

;;>> Doesn't do *print-level* truncation
(defmethod print-object ((class class) stream)
  (print-unreadable-object (class stream)
    (print-object (class-name (class-of class)) stream)
    (when (slot-boundp class 'name)
      (let* ((name (class-name class)))
	(pp-space stream)
	(print-object name stream)))))

#+ppc-target
(defmethod print-object ((value-cell value-cell) stream)
  (print-unreadable-object (value-cell stream :type t :identity t)
    (prin1 (uvref value-cell ppc::value-cell.value-cell) stream)))

;(defun symbol-begins-with-vowel-p (sym)
;  (and (symbolp sym)
;       (not (%izerop (%str-length (setq sym (symbol-name sym)))))
;       (%str-member (schar sym 0) "AEIOU")))

;;;; ----------------------------------------------------------------------
;;;; CLOSsage

;;>> Doesn't do *print-level* truncation
(defmethod print-object ((instance standard-object) stream)
  (print-unreadable-object (instance stream :identity t)
    (let* ((class (class-of instance))
           (class-name (class-name class)))
      (cond ((not (and (symbolp class-name)
                       (eq class (find-class class-name))))
             (%write-string "An instance of" stream)
             (pp-space stream)
             (print-object class stream))
            (t
             (write-a-symbol class-name stream))))))

(defmethod print-object ((method standard-method) stream)
  (print-method method stream (class-name (class-of method))))

(defmethod print-object ((method-function method-function) stream)
  (let ((method (%method-function-method method-function)))
    (if (typep method 'standard-method)
      (print-method (%method-function-method method-function)
                    stream
                    (class-name (class-of method-function)))
      (call-next-method))))

(defmethod print-object ((method-function interpreted-method-function) stream)
  (let ((method (%method-function-method method-function)))
    (if (typep method 'standard-method)
      (print-method (%method-function-method method-function)
                    stream
                    (class-name (class-of method-function)))
      (call-next-method))))

(defun print-method (method stream type-string)
  (print-unreadable-object (method stream)
    (let ((name (method-name method))
          (qualifiers (method-qualifiers method))
          (specializers (uncanonicalize-specializers (method-specializers method)))
          (level-1 (%i- %current-write-level% 1)))
      (cond
       ((< level-1 0)
        ;; *print-level* truncation
        (stream-write-entire-string stream "#"))
       (t 
        (prin1 type-string stream)
        (pp-space stream)
        (write-internal stream name level-1 nil)
        (pp-space stream)
        (when qualifiers
          (write-internal stream (if (cdr qualifiers) qualifiers (car qualifiers))
                          level-1 nil)
          (pp-space stream))
        (write-internal stream specializers level-1 nil))))))

;; Need this stub or we'll get the standard-object method
(defmethod print-object ((gf standard-generic-function) stream)
  (write-a-function gf stream (%current-write-level% stream)))

;; This shouldn't ever happen, but if it does, don't want the standard-object method
(defmethod print-object ((mo metaobject) stream)
  (print-unreadable-object (mo stream :type t :identity t)))

(defmethod print-object ((cm combined-method) stream)
  (print-unreadable-object (cm stream :identity t)
    (%write-string "Combined-Method" stream)
    (pp-space stream)
    (let ((name (function-name cm)))
      (if (and (functionp name) (function-is-current-definition? name))
        (setq name (function-name name)))
      (write-internal stream name (%current-write-level% stream) nil))))

(defun print-specializer-names (specializers stream)
  (flet ((print-specializer (spec stream)
           (write-1 (if (typep spec 'class) (class-name spec) spec) stream)))
    (pp-start-block stream #\()
    (if (atom specializers)
        (print-specializer specializers stream)
      (progn (print-specializer (car specializers) stream)
             (dolist (spec (cdr specializers))
               (pp-space stream)
               (print-specializer spec stream))))
    (pp-end-block stream #\))))


;;;; ----------------------------------------------------------------------
            
(defun write-a-cons (cons stream level)
  (declare (type cons cons) (type stream stream) (type fixnum level))
  (let ((print-length (get-*print-frob* '*print-length*))
        (level-1 (%i- level 1))
        (head (%car cons))
        (tail (%cdr cons)))
    (declare (type fixnum print-length) (type fixnum level-1))
    (unless (and *print-abbreviate-quote*
                 (write-abbreviate-quote head tail stream level-1))
        (progn
          (pp-start-block stream #\()
          (write-internal stream head level-1 nil)
          (write-internal-1 stream tail level-1 (%i- print-length 1))
          (pp-end-block stream #\))))))

;;;; hack for quote and backquote

;; for debugging
;(setq *backquote-expand* nil)

(defvar *backquote-hack* (list '*backquote-hack*)) ;uid
(defun write-abbreviate-quote (head tail stream level-1)
  (declare (type stream stream) (type fixnum level-1))
  (when (symbolp head)
    (cond ((or (eq head 'quote) (eq head 'function))
           (when (and (consp tail)
                      (null (%cdr tail)))
             (%write-string (if (eq head 'function) "#'" "'") stream)
             (write-internal stream (%car tail) level-1 nil)
             t))
          ((eq head 'backquote-expander)
           (when (eq (list-length tail) 4)
             (let ((tail tail))
               (set (%car tail)
                    *backquote-hack*)  ;,
               (set (%car (setq tail (%cdr tail)))
                    *backquote-hack*)  ;,.
               (set (%car (setq tail (%cdr tail)))
                    *backquote-hack*)  ;,@
               (stream-tyo stream #\`)
               (write-internal stream (%cadr tail) level-1 nil)
               t)))
          ((and (boundp head)
                (eq (symbol-value head) *backquote-hack*))
           ;",foo" = (#:|,| . foo)
           (stream-tyo stream #\,)
           (let* ((n (symbol-name head))
                  (l (length n)))
             (declare (type simple-string n) (type fixnum l))
             ;; possibilities are #:|`,| #:|,.| and #:|,@|
             (if (eql l 3)
               (stream-tyo stream (schar n 2)))
             (write-internal stream tail level-1 nil)
             t))
          (t nil))))

(eval-when (compile eval)
(defmacro %char-needs-escape-p (char escape &rest losers)
  (setq losers (remove-duplicates (cons escape losers)))
  (setq char (require-type char 'symbol))
  (dolist (c losers)
    (unless (or (characterp c) (symbolp c)) (report-bad-arg c '(or character symbol))))
  (cond ((null (cdr losers))
         `(eq ,char ,escape))
        ((and (every #'characterp losers)
              ;(every #'string-char-p losers)
              (%i> (length losers) 2))
         `(%str-member ,char ,(concatenate 'string losers)))
        (t
         `(or ,@(mapcar #'(lambda (e) `(eq ,char ,e))
                        losers)))))

(defmacro %write-escaped-char (stream char escape &rest losers)
  `(progn
     (when (%char-needs-escape-p ,char ,escape ,@losers)
       (stream-tyo ,stream ,escape))
     (stream-tyo ,stream ,char)))
)

(defun write-escaped-string (string stream &optional (delim #\"))
  (declare (type string string) (type character delim)
           (type stream stream))
  (multiple-value-bind (writer writer-arg) (stream-writer stream)
    (funcall writer writer-arg delim)
    (do* ((limit (length string))
         (i 0 (1+ i)))
        ((= i limit))
      (declare (type fixnum last)) (declare (type fixnum limit) (type fixnum i))
      (let* ((char (char string i))
             (needs-escape? (%char-needs-escape-p char #\\ delim)))
        (if needs-escape?
          (funcall writer writer-arg #\\))
        (funcall writer writer-arg char)))
    (funcall writer writer-arg delim)))


;;;; ----------------------------------------------------------------------
;;;; printing symbols

(defun get-*print-case* ()
  (let ((case *print-case*))
    (unless (or (eq case ':upcase) (eq case ':downcase) 
                (eq case ':capitalize) (eq case ':studly))
      (setq *print-case* ':upcase)
      (error "~S had illegal value ~S.  Reset to ~S"
             '*print-case* case ':upcase))
    case))

(defun write-a-symbol (symbol stream)
  (declare (type symbol symbol) (type stream stream))
  (let ((case (get-*print-case*))
        (name (symbol-name symbol))
        (package (symbol-package symbol)))
    (declare (type simple-string name) (type package package))
    (when (or *print-readably* *print-escape*)
      (cond ((keywordp symbol)
             (stream-tyo stream #\:))
            ((null package)
             (when (or *print-readably* *print-gensym*)
               (multiple-value-bind (s flag)
                                    (find-symbol name *package*)
                 (unless (and flag (eq s symbol))
                   (stream-tyo stream #\#)
                   (stream-tyo stream #\:)))))
            (t
             (multiple-value-bind (s flag)
                                  (find-symbol name *package*)
               (unless (and flag (eq s symbol))
                 (multiple-value-setq (s flag)
                                      (find-symbol name package))
                 (unless (and flag (eq s symbol))
                   (%write-string "#|symbol not found in home package!!|#"
                                  stream))
                 (write-pname (package-name package) case stream)
                 (stream-tyo stream #\:)
                 (unless (eq flag ':external)
                   (stream-tyo stream #\:)))))))
    (write-pname name case stream)))


(defvar *pname-buffer* (%cons-pool "12345678901234567890"))

#|
(defun write-pname (name case stream)
  (declare (type simple-string name) (stream stream)
           (optimize (speed 3)(safety 0)))
  (let* ((readtable *readtable*)
         (readcase (readtable-case readtable))
         (escape? (or *print-readably* *print-escape*))
         (xstring-p (real-xstring-p name))
         (script (if xstring-p (extended-string-script)))) ; <<    
    (flet ((xupper-case-p (c)
             (if script (not (eql c (xchar-up-down c t script)))
                 (upper-case-p c)))
           (xlower-case-p (c)
             (if script (not (eql c (xchar-up-down c nil script)))
                 (lower-case-p c))))
      (declare (dynamic-extent xupper-case-p xlower-case-p))
      (flet ((slashify? (char pos)
               (declare (type character char))
               (and escape?
                    (if (if script (xalpha-char-p char script)
                            (alpha-char-p char)) ; _chartype and _getscript
                      (if (eq readcase :upcase)
                        (xlower-case-p char)  ; _tolower
                        (if (eq readcase :downcase)
                          (xupper-case-p char)))
                      ; should be using readtable here - but (get-macro-character #\|) is nil
                      (if (and (eql char #\#)(neq pos 0))
                        nil
                        (not (%str-member
                              char
                              "!$%&*0123456789.<=>?@[]^_{}~+-/"))))))
             (single-case-p (name)
               (let ((sofar nil))
                 (dotimes (i (length name) sofar)
                   (declare (type fixnum i))
                   (declare (type simple-string name))
                   (let* ((c (schar name i))
                          (c-case (if (xupper-case-p c)
                                    :upcase
                                    (if (xlower-case-p c)
                                      :downcase))))
                     (when c-case
                       (if sofar 
                         (if (neq sofar c-case)
                           (return nil))
                         (setq sofar c-case))))))))
        (declare (dynamic-extent slashify? single-case-p))
        (block alice
          (let ((len (length name))
                (slash-count 0)
                (last-slash-pos 0))
            (declare (type fixnum len)
                     (type fixnum slash-count last-slash-pos))                
            (when escape?
              (when (or (%izerop len)                        
                        (and (not (memq readcase '(:invert :preserve))) ; these never slashify alpha-p
                             (let ((m (max (floor len 4) 2)))
                               (dotimes (i (the fixnum len) nil)
                                 (declare (type fixnum i))
                                 (let ((char (schar name i)))
                                   (when (slashify? char i)
                                     (setq slash-count (%i+ slash-count 1))
                                     (when (or (eql slash-count m)
                                               (eq i (1+ last-slash-pos)))
                                       (return t))
                                     (setq last-slash-pos i)))))))
                (return-from alice  ; if several slashified
                  (write-escaped-string name stream #\|)))
              (when (or ;; could be read as a number -- is there no simpler way?
                     (%parse-number-token name 0 len *read-base*)
                     ;; commonlisp doesn't like symbols consisting entirely of .'s
                     (dotimes (i len t)
                       (declare (fixnum i))
                       (unless (eql (schar name i) #\.)
                         (return nil))))
                (stream-tyo stream #\\)))
            (case readcase
              (:preserve (return-from alice  (stream-write-string stream name 0 len)))
              (:invert (return-from alice
                         (cond ((single-case-p name)(write-perverted-string name stream len :invert xstring-p))
                               (t (stream-write-string stream name 0 len)))))
              (t 
               (when (eql slash-count 0)
                 (return-from alice
                   (cond ((eq readcase case)
                          (stream-write-string stream name 0 len))
                         (t (write-perverted-string name stream len case xstring-p)))))))
            (let* ((outbuf-len (+ len len))
                   (outbuf-ptr -1)
                   (pool *pname-buffer*)
                   (outbuf (pool.data pool)))
              (declare (fixnum outbuf-ptr) (simple-string outbuf))
              (setf (pool.data pool) nil)   ; grab it.
              (when (or (null outbuf)(< (length outbuf) outbuf-len)
                        (and xstring-p (not (extended-string-p outbuf))))
                (setq outbuf (make-array outbuf-len :element-type (if xstring-p 'character 'base-character))))
              (dotimes (pos (the fixnum len))
                (declare (type fixnum pos))
                (let* ((char (schar name pos))
                       (slashify? (cond ((eql slash-count 0)
                                         nil)
                                        ((eql slash-count 1)
                                         (eql pos last-slash-pos))                                        
                                        (t
                                         (slashify? char pos)))))
                  (declare (type character char))
                  (if slashify?
                    (progn
                      (setq slash-count (%i- slash-count 1))
                      (setf (schar outbuf (incf outbuf-ptr)) #\\)
                      (setf (schar outbuf (incf outbuf-ptr)) char))                    
                    (setf (schar outbuf (incf outbuf-ptr))
                          (if (eq case readcase)
                            char
                            (if (eq case :upcase)
                              (char-upcase char)
                              (if (eq case :downcase)
                                (char-downcase char)
                                char)))))))
              (stream-write-string stream outbuf 0 (1+ outbuf-ptr))
              (setf (pool.data pool) outbuf))))))))
|#

(defun write-pname (name case stream)
  (declare (type simple-string name) (stream stream)
           (optimize (speed 3)(safety 0)))
  (let* ((readtable *readtable*)
         (readcase (readtable-case (if *print-readably*
                                       %initial-readtable%
                                       readtable)))
         (escape? (or *print-readably* *print-escape*)))
      (flet ((slashify? (char pos)
               (declare (type character char))
               (and escape?
                    (if (alpha-char-p char) 
                      (if (eq readcase :upcase)
                        (lower-case-p char)  ; _tolower
                        (if (eq readcase :downcase)
                          (upper-case-p char)))
                      ; should be using readtable here - but (get-macro-character #\|) is nil
                      (if (and (eql char #\#)(neq pos 0))
                        nil
                        (not (%str-member
                              char
                              "!$%&*0123456789.<=>?@[]^_{}~+-/"))))))
             (single-case-p (name)
               (let ((sofar nil))
                 (dotimes (i (length name) sofar)
                   (declare (type fixnum i))
                   (declare (type simple-string name))
                   (let* ((c (schar name i))
                          (c-case (if (upper-case-p c)
                                    :upcase
                                    (if (lower-case-p c)
                                      :downcase))))
                     (when c-case
                       (if sofar 
                         (if (neq sofar c-case)
                           (return nil))
                         (setq sofar c-case))))))))
        (declare (dynamic-extent slashify? single-case-p))
        (block samson
          (let ((len (length name))
                (slash-count 0)
                (last-slash-pos 0))
            (declare (type fixnum len)
                     (type fixnum slash-count last-slash-pos))                
            (when escape?
              (when (or (%izerop len)
                        ;; if more than a few \, just use |...|
                        (and (not (memq readcase '(:invert :preserve))) ; these never slashify alpha-p
                             (let ((m (max (floor len 4) 2)))
                               (dotimes (i (the fixnum len) nil)
                                 (declare (type fixnum i))
                                 (let ((char (schar name i)))
                                   (when (slashify? char i)
                                     (setq slash-count (%i+ slash-count 1))
                                     (when (or (eql slash-count m)
                                               (eq i (1+ last-slash-pos)))
                                       (return t))
                                     (setq last-slash-pos i))))))
                        ;; or could be read as a number
                        (%parse-number-token name 0 len *print-base*)
                        ;; or symbol consisting entirely of .'s
                        (dotimes (i len t)
                          (declare (fixnum i))
                          (unless (eql (schar name i) #\.)
                            (return nil))))
                (return-from samson
                  (write-escaped-string name stream #\|))))
            (case readcase
              (:preserve (return-from samson  (write-string name stream :start  0 :end len)))
              (:invert (return-from samson
                         (cond ((single-case-p name)(write-perverted-string name stream len :invert))
                               (t (write-string name stream :start  0 :end len)))))
              (t 
               (when (eql slash-count 0)
                 (return-from samson
                   (cond ((eq readcase case)
                          (write-string name stream :start  0 :end len))
                         (t (write-perverted-string name stream len case)))))))
            (let* ((outbuf-len (+ len len))
                   (outbuf-ptr -1)
                   (pool *pname-buffer*)
                   (outbuf (pool.data pool)))
              (declare (fixnum outbuf-ptr) (simple-string outbuf))
              (setf (pool.data pool) nil)   ; grab it.
              (unless (and outbuf (>= (length outbuf) outbuf-len))
                (setq outbuf (make-array outbuf-len :element-type 'character)))
              (dotimes (pos (the fixnum len))
                (declare (type fixnum pos))
                (let* ((char (schar name pos))
                       (slashify? (cond ((eql slash-count 0)
                                         nil)
                                        ((eql slash-count 1)
                                         (eql pos last-slash-pos))
                                        (t
                                         (slashify? char pos)))))
                  (declare (type character char))
                  (when slashify?
                    (setq slash-count (%i- slash-count 1))
                    (setf (schar outbuf (incf outbuf-ptr)) #\\))
                  (setf (schar outbuf (incf outbuf-ptr)) char)))
              (write-string outbuf stream :start  0 :end (1+ outbuf-ptr))
              (setf (pool.data pool) outbuf)))))))

#|
(defun write-studly-string (string stream)
  (declare (type string string) (stream stream))
  (let* ((offset 0)
         (end (length string))
         (pool *pname-buffer*)
         (outbuf-ptr -1)
         (outbuf (pool.data pool)))
    (declare (fixnum offset end outbuf-ptr))
    (setf (pool.data pool) nil)
    (unless (and outbuf (>= (length outbuf) end))
      (setq outbuf (make-array end :element-type 'character)))
    (do ((i 0 (%i+ i 1)))
        ((%i>= i end))
      (declare (type fixnum i))
      (setq offset (%i+ offset (char-int (char string i)))))
    (do ((i 0 (%i+ i 1)))
        ((%i>= i end))
      (declare (type fixnum i))
      (let ((c (char string i)))
        (declare (type character c))
        (cond ((not (and (%i< (%ilogand2
                                     (%i+ (char-int c) offset)
                                     15.)
                                   6.)
                         (alpha-char-p c))))
              ((upper-case-p c)
               (setq c (char-downcase c)))
              (t
               (setq c (char-upcase c))))
        (setf (schar outbuf (incf outbuf-ptr)) c)))
    (stream-write-string stream outbuf 0 end)
    (setf (pool.data pool) outbuf)))
|#

(defun write-perverted-string (string stream end type)
  ; type :invert :upcase :downcase :capitalize or :studly
  (declare (fixnum end))
  (let* ((readtable *readtable*)
         (readcase (readtable-case readtable))
         (pool *pname-buffer*)
         (outbuf-ptr -1)
         (outbuf (pool.data pool))
         (word-start t)
         (offset 0))
    (declare (fixnum offset outbuf-ptr))
    (setf (pool.data pool) nil)
    (unless (and outbuf (>= (length outbuf) end))
      (setq outbuf (make-array end :element-type 'character)))  ; this  may be fat string now - do we care?
    (when (eq type :studly)
      (do ((i 0 (%i+ i 1)))
          ((%i>= i end))
        (declare (type fixnum i))
        (setq offset (%i+ offset (char-int (char string i))))))
    (do ((i 0 (%i+ i 1)))
        ((%i>= i end))
      (declare (type fixnum i))
      (let ((c (char string i)))
        (declare (type character c))        
        (cond ((alpha-char-p c)
               (case type
                 (:studly
                  (cond ((not (%i< (%ilogand2
                                    (%i+ (char-int c) offset)
                                    15.)
                                   6.)))
                        ((upper-case-p c)
                         (setq c (char-downcase c)))
                        (t
                         (setq c (char-upcase c)))))
                 (:invert
                  (setq c (if (upper-case-p c)(char-downcase c)(char-upcase c))))
                 (:upcase
                  (setq c (char-upcase c)))
                 (:downcase
                  (setq c (char-downcase c)))
                 (:capitalize (setq c (cond (word-start
                                             (setq word-start nil)
                                             (if (eq readcase :upcase)
                                                 c
                                                 (char-upcase c)))
                                            (t
                                             (if (eq readcase :upcase)
                                                 (char-downcase c)
                                                 c)))))))
              ((digit-char-p c)(setq word-start nil))
              (t (setq word-start t)))
        (setf (schar outbuf (incf outbuf-ptr)) c)))
    (write-string outbuf stream :start  0 :end end)
    (setf (pool.data pool) outbuf)))


;;;; ----------------------------------------------------------------------
;;;; printing arrays

;; *print-array*
;; *print-simple-vector*
;; *print-simple-bit-vector*
;; *print-string-length*
(defun write-an-array (array stream level)
  (declare (type array array) (type stream stream) (type fixnum level))
  (let* ((rank (array-rank array))
         (vector? (eql rank 1))
         (simple? (simple-array-p array))
         (simple-vector? (simple-vector-p array))
         ;; non-*print-string-length*-truncated strings are printed by
         ;;  write-a-frob
         (string? (stringp array))
         (bit-vector? (bit-vector-p array))
         (fill-pointer? (array-has-fill-pointer-p array))
         (adjustable? (adjustable-array-p array))
         (displaced? (displaced-array-p array))
         (total-size (array-total-size array))
         (length (and vector? (length array)))
         (print-length (get-*print-frob* '*print-length*))
         (print-array (get-*print-frob* '*print-array* nil t)))
    (declare (type fixnum rank) (type fixnum total-size)
             (type fixnum print-length))
    (unless
      (cond (string?
             nil)
            (bit-vector?
             (when (or print-array
                       (and simple?
                            (%i<= length
                                  (max 26 (get-*print-frob*
                                           '*print-simple-bit-vector*
                                           ;; there's no reason not to print
                                           ;;  short bit-vectors -- #*0101010
                                           ;;  is shorter than #<array ...>
                                           0
                                           most-positive-fixnum)))))
               (stream-tyo stream #\#) (stream-tyo stream #\*)
               (do ((i 0 (%i+ i 1))
                    (l print-length (%i- l 1)))
                   (nil)
                 (declare (type fixnum i) (type fixnum l))
                 (cond ((eql i length)
                        (return))
                       ((eql l 0)
                        (%write-string "..." stream))
                       (t
                        (stream-tyo stream (if (eql (bit array i) 0) #\0 #\1)))))
               t))
            ((and *print-pretty* print-array)
             (let ((*current-level* (if (and *print-level* (not *print-readably*))
                                      (- *print-level* level)
                                      0)))
               (pretty-array stream array))
             t)
            (vector?
             (when (or print-array
                       (and simple-vector?
                            (%i<= length (get-*print-frob* 
                                          '*print-simple-vector*
                                          0
                                          most-positive-fixnum))))
               (pp-start-block stream "#(")
               (do ((i 0 (%i+ i 1))
                    (l print-length (%i- l 1)))
                   (nil)
                 (declare (type fixnum i) (type fixnum l))
                 (cond ((eql i length)
                        (return))
                       ((eql l 0)
                        ;; can't use write-abbreviation since there is
                        ;;  no `object' for the abbreviation to represent
                        (%write-string " ..." stream)
                        (return))
                       (t (unless (eql i 0) (pp-space stream))
                          (write-internal stream (aref array i) (%i- level 1) nil))))
               (pp-end-block stream #\))
               t))
            ((and print-array (and (eq (array-element-type array) t)
                                   (not fill-pointer?)(not adjustable?)))
             (let ((rank (array-rank array)))
               (stream-tyo stream #\#)
               (%pr-integer rank 10. stream)
               (stream-tyo stream #\a)
               (if (eql rank 0)
                 (write-internal stream (aref array) (%i- level 1) nil)
                 (multiple-value-bind (array-data offset)
                                      (array-data-and-offset array)
                   (write-array-elements-1 
                     stream level
                     array-data offset
                     (array-dimensions array)))))
             t)
            (t 
             ;; fall through -- print randomly
             nil))
      ;; print array using #<...>
      (print-unreadable-object (array stream)
        (if vector?
          (progn
            (write-a-symbol (cond (simple-vector?
                                   'simple-vector)
                                  (string?
                                   (if simple? 'simple-string 'string))
                                  (bit-vector?
                                   (if simple? 'simple-bit-vector 'bit-vector))
                                  (t 'vector))
                            stream)
            (pp-space stream)
            (%pr-integer total-size 10. stream)
            (when fill-pointer?
              (let ((fill-pointer (fill-pointer array)))
                (declare (fixnum fill-pointer))
                (pp-space stream)
                (%write-string "fill-pointer" stream)
                (unless (eql fill-pointer total-size)
                  (stream-tyo stream #\space)
                  (%pr-integer fill-pointer 10. stream)))))
          (progn
            (write-a-symbol 'array stream)
            (pp-space stream)
            (if (eql rank 0) (%write-string "0-dimensional" stream))
            (dotimes (i (the fixnum rank))
              (unless (eql i 0) (stream-tyo stream #\x))
              (%pr-integer (array-dimension array i) 10. stream))))
        (let ((type (array-element-type array)))
          (unless (or simple-vector? string? bit-vector?   ; already written "#<string" or whatever
                      (eq type 't))
            (pp-space stream)
            (%write-string "type " stream)
            (write-internal stream type
                            ;; yes, I mean level, not (1- level)
                            ;; otherwise we end up printing things
                            ;; like "#<array 4 type #>"
                            level nil)))
        (cond (simple?
               (unless (or simple-vector? string? bit-vector?)
                 ;; already written "#<simple-xxx"
                 (stream-tyo stream #\,)
                 (pp-space stream)
                 (%write-string "simple" stream)))
              (adjustable?
               (stream-tyo stream #\,)
               (pp-space stream)
               (%write-string "adjustable" stream))
              (displaced?
               ;; all multidimensional (and adjustable) arrays in ccl are
               ;;  displaced, even when they are simple-array-p
               (stream-tyo stream #\,)
               (pp-space stream)
               (%write-string "displaced" stream)))
        ;; (when stack-allocated? ...) etc, etc
        (when (and string? (%i> length 20))
          (flet ((foo (stream string start end)
                      (declare (type fixnum start) (type fixnum end)
                               (type string string))
                      (do ((i start (%i+ i 1)))
                          ((%i>= i end))
                        (let ((c (char string i)))
                          (declare (type character c))
                          (if (not (graphic-char-p c))
                            (return)
                            (%write-escaped-char stream c #\\ #\"))))))
            #|(%write-string " \"" stream)|# (pp-space stream)
            (foo stream array 0 12)
            (stream-tyo stream #\É)
            (foo stream array (%i- length 6) length)
              #|(stream-tyo stream #\")|#))))))

(defun write-array-elements-1 (stream level
                               array-data offset
                               dimensions)
  (declare (type stream stream) (type fixnum level) 
           (type vector array-data) (type fixnum offset)
           (type list dimensions))
  (block written
    (let ((tail (%cdr dimensions))
          (print-length (get-*print-frob* '*print-length*))
          (level-1 (%i- level 1))
          (limit (%car dimensions))
          (step 1))
      (when (and (null tail)
                 (%i> level-1 0)
                 (or (bit-vector-p array-data)
                     (and (stringp array-data)
                          (%i<= limit print-length))))
        (return-from written
          ;;>> cons cons.  I was lazy.
          ;;>>  Should code a loop to write the elements instead
          (write-an-array (%make-displaced-array
                            ;; dimensions displaced-to
                            limit array-data 
                            ;; fill-pointer adjustable
                            nil nil
                            ;; displaced-index-offset
                            offset)
                          stream level-1)))
      (pp-start-block stream #\()
      (dolist (e tail) (setq step (%i* e step)))
      (do* ((o offset (%i+ o step))
            (i 0 (1+ i)))
           (nil)
        (declare (type fixnum o) (type fixnum i) (type fixnum limit)
                 (type fixnum step) (type fixnum print-length) 
                 (type fixnum level-1))
        (cond ((eql i print-length)
               (%write-string " ..." stream)
               (return))
              ((eql i limit)
               (return))
              ((= i 0))
              (t
               (pp-space stream (if (null tail) ':fill ':linear))))
        (cond ((null tail)
               (write-internal stream (aref array-data o) level-1 nil))
              ((eql level-1 0)
               ;; can't use write-abbreviation since this doesn't really
               ;;  abbreviate a single object
               (stream-tyo stream #\#))
              (t
               (write-array-elements-1 stream level-1
                                       array-data o tail))))
      (pp-end-block stream #\)))))
    
;;;; ----------------------------------------------------------------------

; A "0" in the sd-print-function => inherit from superclass.
(defun structure-print-function (class)
  (let* ((pf (ccl::sd-print-function class))
         (supers (cdr (sd-superclasses class))))
    (do* ()
         ((neq pf 0) pf)
      (if supers 
        (setq pf (sd-print-function (gethash (pop supers) %defstructs%)))
        (return)))))

(defun write-a-structure (object stream level)
  (declare (type stream stream) (type fixnum level))
  (let* ((class (ccl::struct-def object)) ;;guaranteed non-NIL if this function is called
         (pf (structure-print-function class)))
    (cond (pf           
           (if (and (consp pf)(eq (cdr pf) :print-object))
             (funcall (car pf) object stream)
             (funcall pf 
                      object stream (backtranslate-level level))))
          ((and (not *print-structure*) (not *print-readably*))
           (print-unreadable-object (object stream :identity t)
            (write-a-symbol (ccl::sd-name class) stream)))
          (t
           (let ((level-1 (ccl::%i- level 1))
                 (slots (ccl::sd-slots class)))
             (declare (type fixnum level-1) (type list slots))
             (%write-string "#S(" stream)
             ;; deliberately not (1- level)
             (write-a-symbol (ccl::sd-name class) stream)
             (when (not (null (cdr slots)))(pp-start-block stream #\Space))
             (if (and (%i< level 1) (not (null slots)))
                 ;; It would be stupid to print "#S(# # # # # # #)"
                 (%write-string " # ..." stream)
               (do ((l (%i- (get-*print-frob* '*print-length*) 1)
                       (%i- l 2))
                    (first? t)
                    (print-case (get-*print-case*)))
                   (nil)
                 (declare (type fixnum l))
                 (cond ((null slots)
                        (return))
                       ((%i< l 1)
                        ;; Note write-abbreviation since it isn't abbreviating an object
                        (%write-string " ..." stream)
                        (return)))
                 (let* ((slot (prog1 (%car slots)
                                (setq slots (%cdr slots))))
                        (symbol (ccl::ssd-name slot)))
                   (when (symbolp symbol)
                     (if first?
                         (setq first? nil)
                         (pp-space stream ':linear))
                     (stream-tyo stream #\:)
                     (write-pname (symbol-name symbol) print-case stream)
                     (when (%i> l 1)
                       (pp-space stream)
                       (write-internal stream (uvref object (ccl::ssd-offset slot))
                                       level-1 nil)))))))
           (pp-end-block stream #\))))))

(%fhave 'encapsulated-function-name ;(fn) ;Redefined in encapsulate
        (qlfun bootstrapping-encapsulated-function-name (fn)
          (declare (ignore fn))
          nil))


(%fhave '%traced-p ;(fn) ;Redefined in encapsulate
        (qlfun bootstrapping-%traced-p (fn)
          (declare (ignore fn))
          nil))

(%fhave '%advised-p ;(fn) ;Redefined in encapsulate
        (qlfun bootstrapping-%advised-p (fn)
          (declare (ignore fn))
          nil))



(defun write-a-function (lfun stream level)  ; screwed up
  (print-unreadable-object (lfun stream :identity t)
    (let* ((name (function-name lfun))
           ; actually combined-method has its oun print-object method and doesn't get here.
           ; standard-generic-function has a print-object method that just calls this.
           (gf-or-cm (or (standard-generic-function-p lfun) (combined-method-p lfun))))
      (cond ((and (not (compiled-function-p lfun))
                  (not gf-or-cm))
             ; i.e. closures
             (write-internal stream (%type-of lfun) level nil)
             (when name
               (pp-space stream)
               (write-internal stream name (%i- level 1) nil)))
            ((not name)
             (%lfun-name-string lfun stream t))
            (t
             (if gf-or-cm
               (write-internal stream (class-name (class-of lfun)) level nil)
               ; we also have print-object methods for method-function and interpreted-method-function
               (%write-string (cond ((typep lfun 'interpreted-method-function)
                                     "Interpreted Method-function")
                                    ((typep lfun 'method-function)
                                     "Compiled Method-function")
                                    ((typep lfun 'interpreted-function)
                                     "Interpreted-function")
                                    (t "Compiled-function"))
                            stream))
             (stream-tyo stream #\space)
             (write-internal stream name (%i- level 1) nil)
             (cond ((and (symbolp name) (eq lfun (macro-function name)))
                    (%write-string " Macroexpander" stream)) ;What better?                 
                   ((not (function-is-current-definition? lfun))
                    ;;>> Nice if it could print (Traced), (Internal), (Superseded), etc
                    (cond ((%traced-p name)
                           (%write-string " (Traced Original) " stream))
                          ((%advised-p name)
                           (%write-string " (Advised Original) " stream))
                          (t (%write-string " (Non-Global) " stream))))))))))


(defun function-is-current-definition? (function)
  (let ((name (function-name function)))
    (and name
         (function-spec-p name)
         (eq function (fboundp name)))))

;; outputs to stream or returns a string.  Barf!
;; Making not matters not worse ...
(defun %lfun-name-string (lfun &optional stream suppress-address)
  (unless (functionp lfun) (report-bad-arg lfun 'function))
  (if (null stream)
    (with-output-to-string (s) (%lfun-name-string lfun s))
    (if (typep lfun 'stack-group)
      (print-stack-group lfun stream suppress-address)
      (let ((name (function-name lfun)))
        (if name
          (prin1 name stream)
          (let* ((fnaddr (%address-of lfun))
                 (kernel-function-p (kernel-function-p lfun)))
            (%write-string (if kernel-function-p
                             "Internal " "Anonymous ")
                           stream)
            (if (typep lfun 'interpreted-function)
              (%write-string "Interpreted " stream))
            (if (standard-generic-function-p lfun)
              (prin1 (class-name (class-of lfun)) stream)
              (%write-string "Function" stream))
            (unless suppress-address
              (stream-tyo stream #\ )
              (write-an-integer #-ppc-target
                                (if kernel-function-p
                                  (- fnaddr (%get-long (%int-to-ptr $CurrentA5)))
                                  fnaddr)
                                #+ppc-target fnaddr
                                stream 16. t))))))))


;;;; ----------------------------------------------------------------------

(defun write-a-package (pkg stream)
  (print-unreadable-object (pkg stream)
    (if (null (pkg.names pkg))
      (%write-string "Deleted Package" stream)
      (progn
        (%write-string "Package " stream)
        (write-escaped-string (package-name pkg) stream)))))

(defun write-a-mark (mark stream level)
  (print-unreadable-object (mark stream :type t)
    (write-internal stream (buffer-position mark) level nil)
    (stream-tyo stream #\/)
    (write-internal stream (buffer-size mark) level nil)))
  

#-ppc-target ; ??
(defun write-a-symbol-locative (loc stream)
  (print-unreadable-object (loc stream)
    (multiple-value-bind (sym offset)
                         (%symbol-locative-symbol loc)
      (pp-start-block stream "Symbol-")
      (%write-string (cond ((eq offset $sym.gvalue) "Value")
                           ((eq offset $sym.fapply) "Function")   ; "Entry"
                           (t "???"))
                     stream)
      (%write-string "-Locative" stream)
      (pp-space stream)
      (write-a-symbol sym stream))))

#+carbon-compat
(defun control-handlep (macptr)
  ;; assume a macptr - is it a P.O.S
  ;; this con crash
  (#_isvalidcontrolhandle macptr))

(defun write-a-macptr (macptr stream)
  (let ((null (%null-ptr-p macptr)))
    (print-unreadable-object (macptr stream)
      (if null
        (%write-string "A Null Mac Pointer" stream)
        (progn
          (pp-start-block stream "A Mac ")
          (cond (#+carbon-compat (control-handlep macptr) #-carbon-compat nil
                 (%write-string "Control Handle" stream))
                ((and #|(osx-p)|#(#_isvalidwindowptr macptr))
                 (%write-string "Window Pointer" stream))
                ((and #|(osx-p)|#(#_isvalidport macptr))
                 (%write-string "Port Pointer" stream))
                ((and #|(osx-p)|# (#_isvalidmenu macptr)) ;; true too often on OS9
                 (%write-string "Menu Handle" stream))                
                ((and (handlep macptr))  ;; new version of handlep may not crash - yes it can                
                 (%write-string "Handle" stream)
                 ;(pp-space stream)
                 (if (handle-locked-p macptr)
                   (write-string " Locked" stream))
                 (let* ((size (#_GetHandleSize macptr))
                        (err (#_memerror)))
                   (when (eq err #$noerr)
                     (pp-space stream)
                     (%write-string "Size " stream)
                     (write-an-integer size stream))))                
                ((zone-pointerp macptr)  ;; is this silly?
                 (%write-string "Zone Pointer" stream)
                 (let* ((size (#_getptrsize macptr))
                        (err (#_memerror)))
                   (when (eq err #$noerr)
                     (pp-space stream)
                     (%write-string "Size " stream)
                     (write-an-integer size stream))))
                (t
                 (%write-string "Non-zone Pointer" stream)
                 (%write-macptr-termination-info macptr stream)))
          (tyo #\  stream)
          (write-an-integer (%ptr-to-int macptr) stream 16. t))))))

; redefined by macptr-termination.lisp
(defun %write-macptr-termination-info (macptr stream)
  (declare (ignore macptr stream)))

(defun %write-handle-resource-info (handle stream)
  (if (logbitp 5 (the fixnum (#_HGetState handle)))
    (%stack-block ((rname 256) ; It's a resource; get type & id.
                   (rtype 4)
                   (rid 2))
      (#_GetResInfo handle rid rtype rname)
      (%write-string " to resource '" stream)
      (%write-string (%str-from-ptr rtype 4) stream)
      (%write-string "'(" stream)
      (write-an-integer (%get-signed-word rid) stream)
      (%write-string ") : " stream))
    (%write-string ", " stream)))

; This special-casing for wrappers is cheaper than consing a class
(defun write-an-istruct (istruct stream level)
  (let* ((type (uvref istruct 0))
         (wrapper-p  (eq type 'class-wrapper)))
    (print-unreadable-object (istruct stream :identity t)
      (write-internal stream (uvref istruct 0) (%i- level 1) nil)
      (when wrapper-p
        (pp-space stream)
        (print-object (class-name (%wrapper-class istruct)) stream)))))



#+ppc-target
(defun write-a-uvector (uvec stream level)
  (declare (ignore level))
  (print-unreadable-object (uvec stream :identity t :type t)))
  

(defmethod print-object ((slotdef slot-definition) stream)
  (print-unreadable-object (slotdef stream :identity t :type t)
    (format stream "for ~a slot ~s"
            (string-downcase (slot-definition-allocation slotdef))
            (standard-slot-definition.name slotdef))))

(defmethod print-object ((spec eql-specializer) stream)
  (print-unreadable-object (spec stream :identity t :type t)
    (format stream "~s" (if (slot-boundp spec 'object)
			  (eql-specializer-object spec)
			  "<unbound>"))))

(defmethod print-object ((slot-id slot-id) stream)
  (print-unreadable-object (slot-id stream :identity t :type t)
    (format stream "for ~s/~d"
            (slot-id.name  slot-id)
            (slot-id.index  slot-id))))


;;; ======================================================================


(defun real-print-stream (&optional (stream nil))
  (cond ((null stream)
         *standard-output*)
        ((eq stream t)
         *terminal-io*)
        ((streamp stream)
         stream)
        ((istruct-typep stream 'xp-structure)
         (get-xp-stream stream))
        (t
         (report-bad-arg stream '(or stream (member nil t))))))

(defun write-1 (object stream &optional levels-left)
  (setq stream (real-print-stream stream))
  (when (not levels-left)
    (setq levels-left
          (if *current-level* 
            (if *print-level*
              (- *print-level* *current-level*)
              most-positive-fixnum)
            (%current-write-level% stream t))))
  (cond 
   ((< levels-left 0)
    ;; *print-level* truncation
    (stream-write-entire-string stream "#"))
   (t (write-internal stream
                      object 
                      (min levels-left most-positive-fixnum)
                      nil)))
  object)

;;;; ----------------------------------------------------------------------
;;;; User-level interface to the printer


(defun write (object
              &key (stream *standard-output*)
                   (escape *print-escape*)
                   (radix *print-radix*)
                   (base *print-base*)
                   (circle *print-circle*)
                   (pretty *print-pretty*)
                   (level *print-level*)
                   (length *print-length*)
                   (case *print-case*)
                   (gensym *print-gensym*)
                   (array *print-array*)
                   (readably *print-readably*)
                   (right-margin *print-right-margin*)
                   (miser-width *print-miser-width*)
                   (lines *print-lines*)
                   (pprint-dispatch *print-pprint-dispatch*)
                   ;;>> Do I really want to add these to WRITE??
                   (structure *print-structure*)
                   (simple-vector *print-simple-vector*)
                   (simple-bit-vector *print-simple-bit-vector*)
                   (string-length *print-string-length*))
  (let ((*print-escape* escape)
        (*print-radix* radix)
        (*print-base* base)
        (*print-circle* circle)
        (*print-pretty* pretty)
        (*print-level* level)
        (*print-length* length)
        (*print-case* case)
        (*print-gensym* gensym)
        (*print-array* array)
        (*print-readably* readably)
        (*print-right-margin* right-margin)
        (*print-miser-width* miser-width)
        (*print-lines* lines)
        (*print-pprint-dispatch* pprint-dispatch)
        ;;>> Do I really want to add these to WRITE??
        (*print-structure* structure)
        (*print-simple-vector* simple-vector)
        (*print-simple-bit-vector* simple-bit-vector)
        (*print-string-length* string-length))
    (write-1 object stream)))

(defun write-to-string (object
                        &key (escape *print-escape*)
                             (radix *print-radix*)
                             (base *print-base*)
                             (circle *print-circle*)
                             (pretty *print-pretty*)
                             (level *print-level*)
                             (length *print-length*)
                             (case *print-case*)
                             (gensym *print-gensym*)
                             (array *print-array*)
                             (readably *print-readably*)
                             (right-margin *print-right-margin*)
                             (miser-width *print-miser-width*)
                             (lines *print-lines*)
                             (pprint-dispatch *print-pprint-dispatch*)
                             ;;>> Do I really want to add these to WRITE??
                             (structure *print-structure*)
                             (simple-vector *print-simple-vector*)
                             (simple-bit-vector *print-simple-bit-vector*)
                             (string-length *print-string-length*))
    (let ((*print-escape* escape)
          (*print-radix* radix)
          (*print-base* base)
          (*print-circle* circle)
          (*print-pretty* pretty)
          (*print-level* level)
          (*print-length* length)
          (*print-case* case)
          (*print-gensym* gensym)
          (*print-array* array)
          ;; I didn't really wan't to add these, but I had to.
          (*print-readably* readably)
          (*print-right-margin* right-margin)
          (*print-miser-width* miser-width)
          (*print-lines* lines)
          (*print-pprint-dispatch* pprint-dispatch)
          ;;>> Do I really want to add these to WRITE??
          (*print-structure* structure)
          (*print-simple-vector* simple-vector)
          (*print-simple-bit-vector* simple-bit-vector)
          (*print-string-length* string-length))
      (with-output-to-string (stream)
        (write-1 object stream))))

(defun prin1-to-string (object)
  (with-output-to-string (s)
    (prin1 object s)))

(defun princ-to-string (object)
  (with-output-to-string (s)
    (princ object s)))

(defun prin1 (object &optional stream)
  (let ((*print-escape* t))
    (write-1 object stream)))

(defun princ (object &optional stream)
  (let ((*print-escape* nil)
        (*print-readably* nil)
        (*print-circle* nil))
    (write-1 object stream)))

(defun print (object &optional stream)
  (setq stream (real-print-stream stream))
  (terpri stream)
  (let ((*print-escape* t))
    (write-1 object stream))
  (write-char #\Space stream)
  object)

; redefined by pprint module if loaded
(defun pprint (object &optional stream)
  (print object stream)
  nil)                                  ; pprint returns nil

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
