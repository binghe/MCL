; -*- Mode:Lisp; Package:INSPECTOR; -*-

;;	Change History (most recent first):
;;  $Log: inspector-objects.lisp,v $
;;  Revision 1.9  2004/02/24 16:16:16  alice
;;  ;; theme-background
;;
;;  Revision 1.8  2004/02/23 04:14:58  svspire
;;  5.1b2 comment was premature
;;
;;  Revision 1.7  2004/02/18 05:18:32  svspire
;;  Make universal-time-string robust to weird args
;;
;;  Revision 1.6  2004/01/28 22:12:58  alice
;;  ;; lose some bold font
;;
;;  Revision 1.5  2003/12/08 08:18:11  gtbyers
;;  Navigate new CLOS objects.
;;
;;  2 10/5/97  akh  see below
;;  2 12/1/95  akh  fix choose-record-type (esp iff only one exists)
;;  3 4/24/95  akh  no edit-value button in record inspectors
;;  2 4/12/95  akh  no edit-value button in processes inspector
;;  4 1/25/95  akh  processes dialog doesnt offer "debugger" on exhausted dialogs.
;;  3 1/17/95  akh  use with-event-processing-enabled
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  inspector-objects.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995-2004 Digitool, Inc.
;;
;;  inspect/describe/backtrace
;;

(in-package :inspector)

;;;;;;;
;;
;; Change history
;;
;; message-dialog -> standard-alert-dialog
;; classes get methods menu-item - from James Anderson
;; ---- 5.2b6
;; 02/22/04 "Choose or Enter Record Type" gets theme-background
;; ss - make universal-time-string robust to weird args
;; lose some mis placed bold font
;; ----------- 5.1b1
;; funcall-with-chosen-record-type  move down by 4 pixels
;; inspector::line-n - don't barf if float nan or infinity (from Toomas Altosaar)
;; -------- 5.0 final
;; integer shows integer-length, float distinguishes short/double
;; -------- 4.3
;; 06/26/99 akh integer shows IP address maybe - from shannon spires
;; ------------- 4.3b3
;; 06/02/99 akh changes for integer, adding color, from Toomas Altosaar
;; ------------ 4.3b2
;; 09/28/97 akh   fix 68K compute-line-count (array inspector) rank 1
;; 10/28/96 bill  (method compute-line-count (array-inspector)) again works correctly for multi-dimensional arrays
;; -------------  4.0
;; 10/16/96 bill  (method compute-line-count (array-inspector)) now works correctly for ppc-target
;;                on a displaced array with no fill pointer.
;; -------------  4.0f2
;; 10/10/96 bill  (method line-n (stack-group-inspector t)) doesn't attempt to call %int-to-ptr
;;                on a negative number.
;;                (ccl::sg.cs-overflow-limit is negative in the stack overflow yellow zone).
;; -------------  4.0f1
;; 09/12/96 bill  Remove special casing for strings at Richard Greenblatt's request.
;; -------------  4.0b1
;; 08/13/96 bill  Don't disassemble interpreted functions:
;;                (method compute-line-count (function-inspector)) sets disasm-p to nil for them.
;; 06/26/96 bill  (method (setf line-n) (t array-inspector t)) sets the correct element on the ppc-target.
;; 06/25/96 bill  (method compute-line-count :before (stack-group-inspector)) calls %normalize-areas
;; -------------- MCL-PPC 3.9
;; 04/02/96 bill  load-all-records-and-continue & funcall-with-chosen-record-type
;;                to avoid loading all records in the ccl::*event-processor*
;; 03/22/96 bill  more fixes for array-inspector.
;; 03/08/96 bill  update array-inspector for PPC
;; 01/24/96 bill  PPC stack-group-inspector
;; 01/05/96 bill  use closed-over-value-p, closed-over-value, & set-closed-over-value
;;                instead of inline knowledge of how value cells are represented.
;;                The PPC has no symbol-locative, so conditionalize the reference.
;;  6/08/95 slh   help-specs
;;  5/10/95 slh   closure-inspector's line-n, setf: closure value car & cdr were reversed
;;  3/07/95 slh   inspect-processes-print-function: fix idle time calculation
;; -------------- 3.0d17
;; add "enter record type" as a command in inspect-record-types
;; inspector menu item returns as a sub menu, record-field-types reuses its window
;; choose-record-type provides typein possibility right there vs yet another dialog (costs 300+ bytes)
;;-------------------------
;; 07/20/93 bill  "utilisation" -> "utilization"
;; 07/13/93 bill  inspect-record-type, inspect-record-types, & inspect-record-field-types
;;                are now accessible from the "Commands" pull-down of record inspectors
;;                and each other.
;; -------------- 3.0d12
;; 04/29/93 bill  all-processes & friends -> *all-processes* & friends
;; 04/28/93 bill  inspect-processes
;; -------------- 2.1d5
;; 03/10/93 alice choose-record-type uses select-item-from-list - nuke fred-menu
;; 02/23/93 bill inspect-record
;; 02/17/93 bill stack group buffer inspector
;; 12/17/92 bill "Remove method" command for gf-inspector (thanx to Rainer Joswig)
;; ------------- 2.0
;; 03/13/92 bill make the binary, octal, & hex displays for integers look
;;               like the twos complement representation.
;; 03/12/92 bill Do not offer to "Require Records". Instead, allow user to
;;              "Specify record type".
;; ------------- 2.0f3
;; 10/31/91 bill add a "Set History Length" command to the Inspector History window.
;; 09/09/91 bill autoload records in (method inspector-commands (symbol))
;; 08/30/91 bill Ask for confirmation before MAKUNBOUND & FMAKUNBOUND
;; 08/28/91 bill add load-all-records to choose-record-type
;;               inspect-record-types, inspect-record-field-types
;; 07/30/91 bill remove (method uvector-name-list (hash-table))
;; 07/09/91 bill add "ccl::" package prefix for unexported symbols
;; 06/24/91 bill little bug in gf-inspector
;; 07/12/91 gb   Still no such animal as "#d".
;; 05/17/91 bill nuke *history-window*.  Display message if history empty.
;; 05/02/91 alms fix to no-home-package case
;; 03/05/91 bill Display slots of generic-functions that have them.
;; 03/04/91 bill Don't rely on macros being able to expand into declarations.
;; 02/18/91 gb   %uvsize -> uvsize.
;; 03/07/91 alice add logical hosts to inspector central
;; 02/07/91 bill remove duplicate ECASE key in (method (setf line-n) (t symbol))
;; 02/07/91 gb   remove duplicate ecase key in symbol's (setf line-n) method.
;;--------------- 2.0b1
;; 01/09/90 bill update uvector-name-list for new *def-accessor-types* format.
;; 01/08/91 bill convert to new traps
;; 01/04/91 bill don't autoload record-type for symbols.
;; 01/01/91 bill disassembly is optional, defaults to ccl:*inspect-disassembly*
;;               Remove "Record Types" & "Field Types" from inspect-system-data
;; 11/12/90 bill fencepost in universal-time-string
;; 11/02/90 bill string-inspector based on array-inspector vice vector-inspector
;;               record-type-field-names eliminate guts of the first sub-record.
;; 10/24/90 bill changed many defmethod's to defun's


;;;;;;;
;;
;; Lists
;;
(defclass cons-inspector (basics-first-mixin inspector) ())

(defclass list-inspector (basics-first-mixin inspector)
  ((length :accessor list-inspector-length)
   (dotted-p :accessor list-inspector-dotted-p)
   (nthcdr :accessor list-inspector-nthcdr)
   (n :accessor list-inspector-n)))

(defmethod inspector-class ((o list))
  (if (listp (cdr o))
    'list-inspector
    'cons-inspector))

; Same as list-length-and-final-cdr, but computes the real length of the list
(defun real-list-length (list)
  (multiple-value-bind (len final-cdr max-circ-len) (list-length-and-final-cdr list)
    (if (null max-circ-len)
      (values len final-cdr nil)
      (let ((middle (nthcdr max-circ-len list))
            (n 1))
        (loop (when (eq list middle) (return))
          (pop list)
          (incf n))
        (pop list)
        (loop (when (eq list middle) (return))
          (pop list)
          (incf n))
        (values nil nil n)))))        

(defmethod compute-line-count ((i list-inspector))
  (multiple-value-bind (len final-cdr circ-len) (real-list-length (inspector-object i))
    (setf (list-inspector-dotted-p i) final-cdr)
    (setf (list-inspector-nthcdr i) (inspector-object i))
    (setf (list-inspector-n i) 0)
    (+ 1                                ; regular, dotted, or circular
       1                                ; length
       (abs (setf (list-inspector-length i)
                  (or len (- circ-len))))   ; the elements
       (if final-cdr 2 0))))            ; the final-cdr and it's label

(defmethod compute-line-count ((i cons-inspector))
  2)                                    ; car & cdr

(defmethod line-n ((i list-inspector) en &aux (n en))
  (let* ((circ? (list-inspector-length i))
         (length (abs circ?)))
    (cond ((eql 0 n)
           (values nil (cond ((list-inspector-dotted-p i) "Dotted List")
                             ((< circ? 0) "Circular List")
                             (t "Normal List"))
                   *plain-comment-type*))
          ((eql 0 (decf n)) (values length "Length: "))
          ((>= (decf n) (setq length length))   ; end of dotted list
           (let ((final-cdr (list-inspector-dotted-p i)))
             (unless final-cdr (line-n-out-of-range i en))
             (if (eql n length)
               (values nil "Non-nil final cdr" *plain-comment-type*)
               (values final-cdr (- length 0.5) :colon))))
          (t (let* ((saved-n (list-inspector-n i))
                    (nthcdr (if (>= n saved-n)
                              (nthcdr (- n saved-n) (list-inspector-nthcdr i))
                              (nthcdr n (inspector-object i)))))
               (setf (list-inspector-nthcdr i) nthcdr
                     (list-inspector-n i) n)
               (values (car nthcdr) n :colon))))))

(defmethod line-n ((i cons-inspector) n)
  (let ((object (inspector-object i)))
    (ecase n
           (0 (values (car object) "Car: "))
           (1 (values (cdr object) "Cdr: ")))))

(defmethod (setf line-n) (value (i list-inspector) n)
  (when (< n 2)
    (setf-line-n-out-of-range i n))
  (decf n 2)
  (setf (elt (inspector-object i) n) value)
  (resample-it))

(defmethod (setf line-n) (value (i cons-inspector) n)
  (let ((object (inspector-object i)))
    (ecase n
           (0 (setf (car object) value))
           (1 (setf (cdr object) value))))
  (resample-it))

;;;;;;;
;;
;; General uvector's
;;
(defclass uvector-inspector (basics-first-mixin inspector)
  ((name-list :initarg :name-list :initform nil :accessor name-list)))

(defmethod uvector-name-list (object) 
  (let* ((type (type-of object))
         (names (cdr (assq type ccl::*def-accessor-types*)))
         (names-size (length names))
         res)
    (when names
      (dotimes (i (uvsize object))
        (declare (fixnum i))
        (let ((name (and (> names-size i) (aref names i))))
          (if name
            (push (if (listp name) (car name) name) res)
            (if (and (eql i 0) (typep object 'ccl::internal-structure))
              (push 'type res)
              (push i res)))))
      (nreverse res))))

(defmethod compute-line-count ((i uvector-inspector))
  (setf (name-list i) (uvector-name-list (inspector-object i)))
  (uvsize (inspector-object i)))

(defmethod line-n ((i uvector-inspector) n)
  (values (uvref (inspector-object i) n)
          (or (let ((name-list (name-list i))) (and name-list (nth n (name-list i))))
              n)
          :colon))

(defmethod (setf line-n) (new-value (i uvector-inspector) n)
  (setf (uvref (inspector-object i) n) new-value))

(defmethod inspector-commands ((i uvector-inspector))
  (let ((object (inspector-object i)))
    (if (method-exists-p #'inspector-commands object)
      (inspector-commands object))))

;;;;;;;
;;
;; Vectors & Arrays
;;
(defmethod inspector-class ((v ccl::simple-1d-array))
  'usual-basics-first-inspector)

(defmethod compute-line-count ((v ccl::simple-1d-array))
  (+ 1 (length v)))

(defmethod line-n ((v ccl::simple-1d-array) n)
  (cond ((eql 0 n) (values (length v) "Length" :static 'prin1-colon-line))
        (t (decf n 1)
           (values (aref v n) n :colon))))

(defmethod (setf line-n) (value (v ccl::simple-1d-array) n)
  (when (<= n 0)
    (setf-line-n-out-of-range v n))
  (decf n 1)
  (prog1 (setf (aref v n) value)
    (resample-it)))

(defclass array-inspector (uvector-inspector) ())

(defmethod inspector-class ((v array))
  'array-inspector)

#-ppc-target
(defmethod uvector-name-list ((a array))
  (if (eql 1 (array-rank a))
    '("Flags" "Displacement" "Displaced to" "Length" "Fill Pointer")
    `("Flags" "Displacement" "Displaced to" "Dim0" "Dim1" "Dim2" "Dim3")))

#+ppc-target
(defmethod uvector-name-list ((a array))
  (if (eql 1 (array-rank a))
    (if (array-has-fill-pointer-p a)
      '("Fill Pointer" "Physical size" "Data vector" "Displacement" "Flags")
      '("Logical size" "Physical size" "Data vector" "Displacement" "Flags"))
    `("Rank" "Physical size" "Data vector" "Displacement" "Flags" "Dim0" "Dim1" "Dim2" "Dim3")))

(defmethod compute-line-count ((i array-inspector))
  (let* ((a (inspector-object i))
         (rank (array-rank a)))
    (call-next-method)                  ; calculate name list
    (+ #+ppc-target
       (if (eql rank 1) (1+ (uvsize a)) 7)
       #-ppc-target
       (if (eql rank 1) (uvsize a) 5)
       #-ppc-target
       (if (array-has-fill-pointer-p a) 1 0)
       #+ppc-target
       (apply #'* (array-dimensions a)))))

(defmethod line-n ((i array-inspector) n)
  (let* ((v (inspector-object i))
         (rank (array-rank v))
         #-ppc-target
         (uvsize (if (eql rank 1)
                   (+ (uvsize v) (if (array-has-fill-pointer-p v) 1 0))
                   5))
         #+ppc-target
         (uvsize (if (eql rank 1)
                   (+ (uvsize v) 1)
                   7)))
    (cond ((eql 0 n) (values (array-element-type v)
                             (if (adjustable-array-p v)
                               "Adjustable, Element type"
                               "Element type")
                             :static 'prin1-colon-line))
          ((eql #-ppc-target 1 #+ppc-target 5 n)
           (values #-ppc-target (uvref v 0)
                   #+ppc-target (uvref v ppc::vectorH.flags-cell)
                   "Flags: "
                   :static
                   #'(lambda (i s v l type)
                       (format-normal-line i s v l type "#x~x"))))
          ((and (eql #-ppc-target 4 #+ppc-target 6 n) (not (eql rank 1)))
           (values (array-dimensions v) "Dimensions: " :static))
          ((< n uvsize) (call-next-method i (1- n)))
          (t (let ((index (- n uvsize)))
               (values (row-major-aref v index) (array-indices v index) :colon))))))

(defmethod (setf line-n) (new-value (i array-inspector) n)
  (let* ((v (inspector-object i))
         (rank (array-rank v))
         #-ppc-target
         (uvsize (if (eql rank 1)
                   (+ (uvsize v) (if (array-has-fill-pointer-p v) 1 0))
                   5))
         #+ppc-target
         (uvsize (if (eql rank 1)
                   (+ (uvsize v) 1)
                   7)))
    (prog1
      (cond ((or (eql 0 n) (eql 1 n) (and (eql 4 n) (not (eql rank 1))))
             (setf-line-n-out-of-range i n))
            ((< n uvsize)
             (if (eql 3 n)
               (setq new-value (require-type new-value 'array))
               (setq new-value (require-type new-value 'fixnum)))
             (call-next-method new-value i (1- n)))
          (t (let ((index (- n uvsize)))
               (setf (row-major-aref v index) new-value))))
      (resample-it))))

(defun array-indices (a row-major-index)
  (let ((rank (array-rank a)))
    (if (eql 1 rank)
      row-major-index
      (let ((res nil)
            dim
            (dividend row-major-index)
            remainder)
        (loop
          (when (zerop rank) (return res))
          (setq dim (array-dimension a (decf rank)))
          (multiple-value-setq (dividend remainder) (floor dividend dim))
          (push remainder res))))))
  
(defmethod prin1-line ((i array-inspector) stream value &optional
                       label type function)
  (declare (ignore stream value type function))
  (if (or (numberp label) (listp label))   ; First line or contents lines
    (call-next-method)
    (let ((*print-array* nil))
      (call-next-method))))

;;;;;;;
;;
;; Strings
;;
#|
(defmethod inspector-class ((o simple-string))
  'usual-basics-first-inspector)

(defmethod compute-line-count ((o simple-string))
  1)
|#

(defmethod inspector-commands ((s string))
  `(("Display in a Fred Window"
     ,#'(lambda () (let ((w (make-instance 'fred-window
                                           :window-show nil
                                           :wrap-p t
                                           :scratch-p t)))
                     (stream-write-string w s 0 (length s))
                     (window-select w))))))

#|
(defmethod line-n ((o simple-string) n)
  (ecase n
    (0 (values (length o) "Length: " :static))))

(defclass string-inspector (array-inspector) ())

(defmethod inspector-class ((o string)) 'string-inspector)

(defmethod compute-line-count ((i string-inspector))
  (- (call-next-method) 
     (array-dimension (inspector-object i) 0)))

(defmethod line-n ((i string-inspector) n)
  (let* ((string (inspector-object i))
         (uvsize (+ (uvsize i) (if (array-has-fill-pointer-p string) 1 0))))
    (if (< n uvsize)
      (call-next-method)
      (line-n-out-of-range i n))))

(defmethod inspector-commands ((i string-inspector))
  (inspector-commands (inspector-object i)))
|#

;;;;;;;
;;
;; Numbers
;;
(defmethod inspector-class ((num number)) 'usual-formatting-inspector)

; floats
(defmethod compute-line-count ((num float)) 5)

(eval-when (:compile-toplevel :execute)
  (defmacro handle-error (return fn-to-call-on-error &body body)
    ;;; 2003-05-04TA - fn-to-call-on-error is a function to run if an error occured
    ;;; It takes 2 args: return and the error
    (let ((val (gensym)) (err (gensym)) (error (gensym)) (condition (gensym)))
      `(multiple-value-bind
         (,val ,error) (handler-case ,@body
                         (error (,condition)
                                (values ',err ,condition)))
         (if (eq ,val ',err)
           (let ((return-value (funcall ,fn-to-call-on-error ',return ,error)))
             (return-from ,return return-value))
           (return-from ,return nil))
         ,val)))
  )

(defun safe-rationalize (number)
  (handle-error
    safe-rationalize
    #'(lambda (ret err) (format nil "Error in ~a: ~a " ret err)) ; return a descriptive string for the inspector
    (rationalize number)))

(defun safe-round (number)
  (handle-error
    safe-round
    #'(lambda (ret err) (format nil "Error in ~a: ~a " ret err)) ; return a descriptive string for the inspector
    (round number)))

(defmethod line-n ((num float) n)
  (let ((type :static))
    (ecase n
      (0 (if (typep num 'short-float)
           (values num "Short float:     " type)
           (Values num "Double float:    " type)))
      (1 (values num   "Scientific:      " type
                 (if (< num 0) "~8,2e" "~7,2e")))
      (2 (values (if (zerop num) "illegal" (log num 2))
                     "Log base 2:      " type "~d"))
      (3 (values (safe-rationalize num)
                     "Ratio equiv:     " type))
      (4 (values (safe-round num)
                     "Nearest integer: " type)))))

; complex numbers
(defmethod compute-line-count ((num complex)) 3)

(defmethod line-n ((num complex) n)
  (let ((type :static))
    (ecase n
      (0 (values num            "Complex num:    " type))
      (1 (values (realpart num) "Real part:      " type))
      (2 (values (imagpart num) "Imaginary part: " type)))))

; ratios
(defmethod compute-line-count ((num ratio)) 6)

(defmethod line-n ((num ratio) n)
  (let ((type :static))
    (ecase n
      (0 (values num               "Ratio:           " type))
      (1 (values (float num)       "Scientific:      " type 
                 (if (< num 0) "~8,2e" "~7,2E")))
      (2 (values (if (zerop num) "illegal" (log num 2))
                                   "Log base 2:      " type "~d"))
      (3 (values (round num)       "Nearest integer: " type))
      (4 (values (numerator num)   "Numerator:       " type))
      (5 (values (denominator num) "Denominator:     " type)))))

; integers
(defmethod compute-line-count ((num integer)) 
  (let ((res 16))
    (unless (< 0 num 4000) (decf res))   ; not a roman number
    (unless (<= 0 num 255) (decf res))   ; not a character
    (unless (<= #x-1000 (ash num -16) #xfff) 
      (decf res))                       ; not a point
    (unless (<= *black-color* num *white-color*)
      (decf res))                       ; not an RGB color
    (unless (fboundp 'ccl::tcp-addr-to-str) (decf res))
    res))

(defmethod line-n ((num integer) n)
  (if (and (>= n 7) (not (< 0 num 4000))) (incf n))   ; maybe skip roman.
  (if (and (>= n 8) (not (<= 0 num 255))) (incf n))   ; maybe skip character.
  (if (and (>= n 9) (not (<= #x-1000 (ash num -16) #xfff)))
    (incf n))                ; maybe skip point
  (if (and (>= n 10)
           (not (<= *black-color* num *white-color*)))
    (incf n))                ; maybe skip RGB color
  (let* ((type :static)
         (neg? (< num 0))
         (norm (if neg? 
                 (+ num (expt 2 (max 32 (* 4 (round (+ (integer-length num) 4) 4)))))
                 num)))
    (ecase n
      (0  (values num
                (if (fixnump num)
                  "Fixnum:      "
                  "Bignum:      ")
                type "~s"))
      (1  (values (float num)
                  "Scientific:  " type
                  (if (< num 0) "~8,2e" "~7,2e")))
      (2  (values (if (zerop num) "illegal" (log num 2)) 
                  "Log base 2:  " type "~d"))
      (3  (values norm
                  "Binary:      " type
                  (if neg? "#b...~b" "#b~b")))
      (4  (values norm
                  "Octal:       " type
                  (if neg? "#o...~o" "#o~o")))
      (5  (values num
                  "Decimal:     " type "~d."))
      (6  (values norm
                  "Hex:         " type
                  (if neg? "#x...~x" "#x~x")))
      (7  (values (format nil "~@r" num)
                  "Roman:       " type "~a"))
      (8  (values (code-char num)
                  "Character:   " type "~s"))
      (9  (values (point-string num)
                  "As a point:  " type "~a")) ; string was "As a point: "
      (10 (values (multiple-value-bind (r g b) (color-values num)
                    (format nil "Red: ~d; Green: ~d; Blue: ~a" r g b))
                  "RGB color:   " type "~a"))
      (11 (values (ccl::ensure-simple-string (prin1-to-string num)) ; index was 10
                  "Abbreviated: "
                  type #'format-abbreviated-string))
      (12 (values (universal-time-string num)                       ; index was 11
                  "As time:     " type "~a"))
      (13 (values (integer-length num) "Integer length: " type "~A"))
      (14 (if (< num 0)                                             ; index was 12
            (values most-negative-fixnum 'most-negative-fixnum type '("~d." t))
            (values most-positive-fixnum 'most-positive-fixnum type '("~d." t))))
      (15 (values (if (fboundp 'ccl::tcp-addr-to-str)
                    (funcall 'ccl::tcp-addr-to-str num)
                    "N/A")
                  "As IP address: "
                  type
                  "~A")))))

(defun format-abbreviated-string (stream string)
  (setq string (require-type string 'simple-string))
  (let ((length (length string)))
    (if (< length 7)
      (princ string stream)
      (format stream "~a <- ~s digits -> ~a"
              (subseq string 0 3)
              (- length 6)
              (subseq string (- length 3) length)))))

(defun universal-time-string (num)
    (or
     (ignore-errors
      (multiple-value-bind (second minute hour date month year day)
                           (decode-universal-time num)
        (with-output-to-string (s)
          (format s "~d:~2,'0d:~2,'0d " hour minute second)
          (princ (nth day '("Monday" "Tuesday" "Wednesday" "Thursday" "Friday"
                            "Saturday" "Sunday"))
                 s)
          (format s ", ~d " date)
          (princ (nth month '("" "January" "February" "March" "April" "May" "June" "July"
                              "August" "September" "October" "November" "December"))
                 s)
          (format s ", ~d" year))))
     "N/A"))


; Characters
(defmethod compute-line-count ((ch character)) 2)

(defmethod line-n ((ch character) n)
  (let ((type :static))
    (ecase n
      (0 (values ch             "Character: " type))
      (1 (values (char-code ch) "char-code: " type)))))

;;;;;;;
;;
;; Symbols
;;
(defun symbol-has-bindings-p (sym)
  (or (constantp sym) (proclaimed-special-p sym) (boundp sym)
      (special-form-p sym) (macro-function sym) (fboundp sym)
      (type-specifier-p sym) (record-type-p sym nil)
      (find-class sym nil)))

(defmethod inspector-class ((sym symbol)) 'usual-inspector)

; Don't want symbol locatives around anywhere but in the stack backtrace.
#-ppc-target
(defmethod inspector-class ((o ccl::symbol-locative))
  (values 'usual-inspector (ccl::%symbol-locative-symbol o)))

(defmethod compute-line-count ((sym symbol))
  (+ 1                                  ; The symbol
     (if (symbol-has-bindings-p sym) 1 0)
     1                                  ; package
     1                                  ; symbol-name
     1                                  ; symbol-value
     1                                  ; symbol-function
     (if (fboundp sym) 1 0)             ; arglist
     1                                  ; plist
     (if (find-class sym nil) 1 0)      ; class
     ))

(defmethod normalize-line-number ((sym symbol) n)
  (if (and (>= n 1) (not (symbol-has-bindings-p sym))) (incf n))
  (if (and (>= n 6) (not (fboundp sym))) (incf n))
  n)

(defmethod line-n ((sym symbol) n)
  (setq n (normalize-line-number sym n))
  (let ((type :normal)
        (comment '(:comment (:bold)))
        (static :static))
    (ecase n
      (0 (values sym "Symbol: " type))
      (1 (values nil (symbol-type-line sym) comment))
      (2 (let ((p (symbol-package sym)))
           (if (null p)
             (values nil "No home package." comment)
             (multiple-value-bind (found kind) (find-symbol (symbol-name sym) p)
               (values p 
                       (if (or (null kind) (neq found sym))
                         "NOT PRESENT in home package: "
                         (format nil "~a in package: " kind))
                       static)))))
      (3 (values (symbol-name sym) "Print name: " static))
      (4 (values (if (boundp sym) (symbol-value sym) *unbound-marker*)
                 "Value: " type))
      (5 (values (if (fboundp sym)
                   (cond ((macro-function sym))
                         ((special-form-p sym) sym)
                         (t (symbol-function sym)))
                   *unbound-marker*)
                 "Function: " type))
      (6 (values (and (fboundp sym) (arglist sym))
                 "Arglist: " static))
      (7 (values (symbol-plist sym) "Plist: " type))
      (8 (values (find-class sym) "Class: " static)))))

(defmethod (setf line-n) (value (sym symbol) n)
  (let (resample-p)
    (setq n (normalize-line-number sym n))
    (setq value (restore-unbound value))
    (ecase n
      (0 (replace-object *inspector* value))
      ((1 2 3 6) (setf-line-n-out-of-range sym n))
      (4 (setf resample-p (not (boundp sym))
               (symbol-value sym) value))
      (5 (setf resample-p (not (fboundp sym))
               (symbol-function sym) value))
      (7 (setf (symbol-plist sym) value)))
    (when resample-p (resample-it))
    value))

; Add arglist here.
(defun symbol-type-line (sym)
  (let ((types (list
                (cond ((constantp sym)
                       "Constant")
                      ((proclaimed-special-p sym)
                       "Special Variable")
                      ((boundp sym)
                       "Non-special Variable")
                      (t nil))
                (cond ((special-form-p sym)
                       "Special Form")
                      ((macro-function sym)
                       "Macro")
                      ((fboundp sym)
                       "Function")
                      (t nil))
                (if (type-specifier-p sym) "Type Specifier")
                (if (record-type-p sym nil) "Record Type")
                (if (find-class sym nil) "Class Name")))
        flag)
    (with-output-to-string (s)
      (dolist (type types)
        (when type
          (if flag (write-string ", " s))
          (setq flag t)
          (write-string type s))))))
    

(defmethod inspector-commands ((sym symbol))
  (let ((res nil))
    (push (list "Documentation" #'(lambda () (show-documentation sym)))
          res)
    (if (get-source-files sym)
      (push (list "Edit Definition" #'(lambda () (edit-definition sym))) res))
    (let ((class (find-class sym nil)))
      (if class
        (push (list "Inspect Class" #'(lambda () (inspect class))) res)))
    (if (boundp sym)
      (push (list "MAKUNBOUND" #'(lambda () (when (y-or-n-dialog (format nil "~s?" `(makunbound ',sym)))
                                              (makunbound sym) (resample-it))))
            res))
    (if (fboundp sym)
      (push (list "FMAKUNBOUND" #'(lambda () (when (y-or-n-dialog (format nil "~s?" `(fmakunbound ',sym)))
                                               (fmakunbound sym) (resample-it))))
            res))
    (if (record-type-p sym)
      (push (list "Inspect Record Type" #'(lambda () (inspect-record-type sym)))
            res))
    (nreverse res)))

(defmethod line-n-inspector ((sym symbol) n value label type)
  (declare (ignore label type))
  (setq n (normalize-line-number sym n))
  (if (eql n 7)
    (make-instance 'plist-inspector :symbol sym :object value)
    (call-next-method)))

(defclass plist-inspector (inspector)
  ((symbol :initarg :symbol :reader plist-symbol)))

(defmethod inspector-window-title ((i plist-inspector))
  (format nil "~a of ~s" 'plist (plist-symbol i)))

(defmethod compute-line-count ((i plist-inspector))
  (+ 3 (/ (length (inspector-object i)) 2)))

(defmethod line-n ((i plist-inspector) n)
  (let* ((plist (inspector-object i)))
    (cond ((eql 0 n) (values plist "Plist: "))
          ((eql 1 n) (values (plist-symbol i) "Symbol: " :static))
          ((eql 2 n) (values nil nil :comment))
          (t (let ((rest (nthcdr (* 2 (- n 3)) plist)))
               (values (cadr rest) (car rest) :colon))))))

(defmethod (setf line-n) (new-value (i plist-inspector) n)
  (let* ((plist (inspector-object i)))
    (if (eql n 0)
      (replace-object i new-value)
      (if (< n 3)
        (setf-line-n-out-of-range i n)
        (let ((rest (nthcdr (* 2 (- n 3)) plist)))
          (setf (cadr rest) new-value)
          (resample-it))))))

;;;;;;;
;;
;; Functions
;;
(defclass function-inspector (inspector)
  ((disasm-p :accessor disasm-p :initform *inspector-disassembly*)
   (disasm-info :accessor disasm-info)
   (pc-width :accessor pc-width)
   (pc :initarg :pc :initform nil :accessor pc)))

(defclass closure-inspector (function-inspector)
  ((n-closed :accessor closure-n-closed)))

(defmethod inspector-class ((f function)) 'function-inspector)
(defmethod inspector-class ((f compiled-lexical-closure)) 'closure-inspector)

; This is executed when we find an old window for a new inspector consed up from the
; backtrace window.
(defmethod copy-random-inspector-state ((from function-inspector) (to function-inspector))
  (let ((from-pc (pc from))
        (to-pc (pc to)))
    (prog1 (unless (eq from-pc to-pc)
             (setf (pc to) from-pc)
             t)
      (show-pc to))))

(defmethod set-initial-scroll ((f function-inspector))
  (let ((pc (pc f)))
    (if pc
      (show-pc f nil)
      (call-next-method))))
(defvar *do-inspect-interpreted-functions* nil)
(defmethod compute-line-count ((f function-inspector))
  (when (and (typep (inspector-object f) 'ccl::interpreted-function)(not *do-inspect-interpreted-functions*))
    (setf (disasm-p f) nil))
  (+ 1                                  ; the function
     1                                  ; name
     1                                  ; arglist
     (compute-disassembly-lines f))) 

(defmethod compute-line-count ((f closure-inspector))
  (let ((o (inspector-object f)))
    (multiple-value-bind (nreq nopt restp keys allow-other-keys optinit lexprp
                               ncells nclosed)
                         (function-args (ccl::closure-function o))
      (declare (ignore nreq nopt restp keys allow-other-keys optinit lexprp ncells))
      (setf (closure-n-closed f) nclosed)
      (+ (call-next-method)
         1                              ; the function we close over
         1                              ; "Closed over values"
         nclosed
         (if (disasm-p f) 1 0)))))      ; "Disassembly"

(defun first-disassembly-line (f)
  (setq f (require-type f 'function-inspector))
  (let* ((lines (or (inspector-line-count f) (compute-line-count f)))
         (assembler-lines (length (disasm-info f))))
    (- lines assembler-lines)))

(defun show-pc (function-inspector &optional refresh?)
  (let ((info (disasm-info function-inspector))
        (pc (and (disasm-p function-inspector) (pc function-inspector))))
    (when pc
      (dotimes (i (length info))
        (let ((addr (car (svref info i))))
          (when (listp addr) (setq addr (cadr addr)))
          (when (eq pc addr)
            (let ((view (inspector-view function-inspector)))
              (when view
                (scroll-to-line 
                 view (+ i (first-disassembly-line function-inspector)) refresh? 0.5)))
            (return)))))))

(defmethod inspector-commands ((f function-inspector))
  (let ((commands nil)
        (function (inspector-object f)))
    (when (edit-definition-p function)
      (push (list "Edit Definition" #'(lambda () (edit-definition function))) commands))
    (when (and (pc f) (disasm-p f))
      (push (list "Show PC" #'(lambda () (show-pc f))) commands))
    (flet ((disasm () (setf (disasm-p f) t) (resample (inspector-view f)))
           (no-disasm () (setf (disasm-p f) nil) (resample (inspector-view f))))
      (push (if (disasm-p f)
              (list "Hide Disassembly" #'no-disasm)
              (list "Show Disassembly" #'disasm))
          commands)
      (push (if *inspector-disassembly*
              (list "Default Hide Disassembly"
                    #'(lambda ()
                        (setq *inspector-disassembly* nil)
                        (when (disasm-p f) (no-disasm))))
              (list "Default Show Disassembly"
                    #'(lambda ()
                        (setq *inspector-disassembly* t)
                        (unless (disasm-p f) (disasm)))))
            commands))
    (nreverse commands)))

(defmethod line-n ((f function-inspector) n)
  (let ((o (inspector-object f)))
    (case n
      (0 (values o ""))
      (1 (values (function-name o) "Name" :colon))
      (2 (multiple-value-bind (arglist type) (arglist o)
           (let ((label (if type (format nil "Arglist (~(~a~))" type) "Arglist unknown")))
             (values arglist label (if type :colon '(:comment (:plain)))))))
      (t (disassembly-line-n f (- n 3))))))

(defmethod line-n ((f closure-inspector) n)
  (let ((o (inspector-object f))
        (nclosed (closure-n-closed f)))
    (if (<= (decf n 2) 0)
      (call-next-method)
      (cond ((eql (decf n) 0)
             (values (ccl::closure-function o) "Inner lfun: " :static))
            ((eql (decf n) 0)
             (values 0 "Closed over values" :comment #'prin1-comment))
            ((< (decf n) nclosed)
             (let* ((value (ccl::%nth-immediate (ccl::%lfun-vector o) (- nclosed n)))
                    (map (car (ccl::function-symbol-map (ccl::closure-function o))))
                    (label (or (and map (svref map (+ n (- (length map) nclosed))))
                               n))
                    (cellp (ccl::closed-over-value-p value)))
               (when cellp
                 (setq value (ccl::closed-over-value value)
                       label (format nil "(~a)" label)))
               (values value label (if cellp :normal :static) #'prin1-colon-line)))
            ((eql (decf n nclosed) 0)
             (values 0 "Disassembly" :comment #'prin1-comment))
            (t (disassembly-line-n f (- n 1)))))))

(defmethod (setf line-n) (new-value (f function-inspector) n)
  (let ((o (inspector-object f)))
    (case n
      (0 (replace-object f new-value))
      (1 (ccl::lfun-name o new-value) (resample-it))
      (2 (setf (arglist o) new-value))
      (t
       (if (>= n 3) 
         (set-disassembly-line-n f (- n 3) new-value)
         (setf-line-n-out-of-range f n)))))
  new-value)

(defmethod (setf line-n) (new-value (f closure-inspector) en &aux (n en))
  (let ((o (inspector-object f))
        (nclosed (closure-n-closed f)))
    (if (<= (decf n 2) 0)               ; function itself, name, or arglist
      (call-next-method)
      (cond ((<= (decf n 2) 0)          ; inner-lfun or "Closed over values"
             (setf-line-n-out-of-range f en))
            ((< (decf n) nclosed)       ; closed-over variable
             (let* ((value (ccl::%nth-immediate (ccl::%lfun-vector o) (- nclosed n)))
                    (cellp (ccl::closed-over-value-p value)))
               (unless cellp (setf-line-n-out-of-range f en))
               (ccl::set-closed-over-value value new-value)))
            ((eql (decf n nclosed) 0)   ; "Disassembly"
             (setf-line-n-out-of-range f en))
            (t (set-disassembly-line-n f (- n 1) new-value))))))

(defun compute-disassembly-lines (f &optional (function (inspector-object f)))
  (if (functionp function)
    (let* ((info (and (disasm-p f) (list-to-vector (ccl::disassemble-list function))))
           (length (length info))
           (last-pc (if info (car (svref info (1- length))) 0)))
      (if (listp last-pc) (setq last-pc (cadr last-pc)))
      (setf (pc-width f) (length (format nil "~d" last-pc)))
      (setf (disasm-info f) info)
      length)
    0))

(defun list-to-vector (list)
  (let* ((length (length list))
         (vec (make-array length)))
    (dotimes (i length)
      (declare (fixnum i))
      (setf (svref vec i) (pop list)))
    vec))

(defvar *disassembly-comment-type* nil)

(defun disassembly-comment-type ()
  (let ((type *disassembly-comment-type*))
    (if (and (eq (second type) *default-label-font*)
             (eq (third type) *default-value-font*))
      type
      (setq *disassembly-comment-type* `(:comment ,*default-label-font* ,*default-value-font*)))))

(defun disassembly-line-n (f n)
  (let* ((line (svref (disasm-info f) n))
         (value (disasm-line-immediate line)))
    (values value line (if value :static (disassembly-comment-type)))))

(defun set-disassembly-line-n (f n new-value &optional 
                                 (function (inspector-object f)))
  (declare (ignore new-value function))
  (setf-line-n-out-of-range f n))

(defun disasm-line-immediate (line &optional (lookup-functions t))
  (pop line)                        ; remove address
  (when (eq (car line) 'ccl::jsr_subprim)
    (return-from disasm-line-immediate (find-symbol (cadr line) :ccl)))
  (let ((res nil))
    (labels ((inner-last (l)
               (cond ((atom l) l)
                     ((null (cdr l)) (car l))
                     (t (inner-last (last l))))))
      (dolist (e line)
        (cond ((numberp e) (when (null res) (setq res e)))
              ((consp e)
               (cond ((eq (car e) 'function)
                      (setq res (or (and lookup-functions (fboundp (cadr e))) (cadr e))))
                     ((eq (car e) 17)   ; locative
                      (setq e (cadr e))
                      (unless (atom e)
                        (cond ((eq (car e) 'special) 
                               (setq res (cadr e)))
                              ((eq (car e) 'function) 
                               (setq res (or (and lookup-functions (fboundp (cadr e))) (cadr e))))
                              (t (setq res (inner-last e))))))
                     ((or (null res) (numberp res))
                      (setq res (inner-last e))))))))
    res))

(defmethod inspector-print-function ((i function-inspector) type)
  (declare (ignore type))
  'prin1-normal-line)

(defmethod prin1-label ((f function-inspector) stream value &optional label type)
  (declare (ignore value type))
  (if (atom label)                      ; not a disassembly line
    (call-next-method)
    (let* ((pc (car label))
           (label-p (and (listp pc) (setq pc (cadr pc))))
           (pc-mark (pc f)))
      (if (eq pc pc-mark)
        (format stream "*~vd" (pc-width f) pc)
        (format stream "~vd" (+ (pc-width f) (if pc-mark 1 0)) pc))
      (tyo (if label-p #\= #\ ) stream))))

(defmethod prin1-value ((f function-inspector) stream value &optional label type)
  (if (atom label)                      ; not a disassembly line
    (unless (eq (if (consp type) (car type) type) :comment)
      (call-next-method))
    (let ((q (cdr label)))
      (tyo #\( stream)
      (loop (if (null q) (return))
        (ccl::disasm-prin1 (pop q) stream)
        (if q (tyo #\space stream)))
      (tyo #\) stream)))
  value)

;; Generic-functions
;; Display the list of methods on a line of its own to make getting at them faster
;; (They're also inside the dispatch-table which is the first immediate in the disassembly).
(defclass gf-inspector (function-inspector)
  ((method-count :accessor method-count)
   (slot-count :accessor slot-count :initform 0)
   (forwarded-p :accessor forwarded-p :initform nil)))

(defmethod inspector-class ((f standard-generic-function))
  (if (functionp f) 
    'gf-inspector
    'standard-object-inspector))

(defmethod compute-line-count ((f gf-inspector))
  (let* ((gf (inspector-object f))
         (count (length (generic-function-methods gf)))
         (res (+ 1 (setf (method-count f) count)  
                 (call-next-method))))
    (if (disasm-p f) (1+ res) res)))


(defmethod line-n ((f gf-inspector) n)
  (let* ((count (method-count f))
         (slot-count (slot-count f))
         (lines (1+ count)))
    (if (<= 3 n (+ lines slot-count 3))
      (let ((methods (generic-function-methods (inspector-object f))))
        (cond ((eql (decf n 3) 0) (values methods "Methods: " :static))
              ((<= n count)
               (values (nth (- n 1) methods) nil :static))
              ((< (decf n (1+ count)) slot-count)
               (standard-object-line-n f n))
              (t
               (values 0 "Disassembly" :comment #'prin1-comment))))
      (call-next-method f (if (< n 3) n (- n lines slot-count 1))))))

(defmethod (setf line-n) (new-value (f gf-inspector) n)
  (let* ((count (method-count f))
         (slot-count (slot-count f))
         (lines (1+ count)))
    (if (<= 3 n (+ lines slot-count 3))
      (let ((en n))
        (cond ((<= (decf en 3) count)
               (setf-line-n-out-of-range f n))
              ((< (decf en (1+ count)) slot-count)
               (standard-object-setf-line-n new-value f en))
              (t (setf-line-n-out-of-range f n))))
      (call-next-method new-value f (if (< n 3) n (- n lines slot-count 1))))))

(defmethod inspector-commands ((f gf-inspector))
  (let* ((function (inspector-object f))
         (method (selected-object (inspector-view f))))
    (if (typep method 'method)
      (nconc
       (call-next-method)
       `(("Remove method"
         ,#'(lambda ()
              (remove-method function method)
              (resample-it)))))
      (call-next-method))))

(defclass method-inspector (standard-object-inspector function-inspector)
  ((standard-object-lines :accessor standard-object-lines)))

(defmethod inspector-class ((object standard-method))
  'method-inspector)

(defmethod compute-line-count ((i method-inspector))
  (+ (setf (standard-object-lines i) (call-next-method))
     (if (disasm-p i) 1 0)              ; "Disassembly"
     (compute-disassembly-lines i (method-function (inspector-object i)))))

(defmethod line-n ((i method-inspector) n)
  (let ((sol (standard-object-lines i)))
    (cond ((< n sol) (call-next-method))
          ((eql n sol) (values nil "Disassembly" :comment))
          (t (disassembly-line-n i (- n sol 1))))))

(defmethod (setf line-n) (new-value (i method-inspector) n)
  (let ((sol (standard-object-lines i)))
    (cond ((< n sol) (call-next-method))
          ((eql n sol) (setf-line-n-out-of-range i n))
          (t (set-disassembly-line-n
              i n new-value (method-function (inspector-object i)))))))

; funtion-inspector never does prin1-comment.
(defmethod prin1-normal-line ((i method-inspector) stream value &optional
                              label type colon-p)
  (declare (ignore colon-p))
  (if (eq type :comment)
    (prin1-comment i stream value label type)
    (call-next-method)))


;;;;;;;
;;
;; Structures
;;
(defmethod inspector-class ((s structure-object))
  'usual-basics-first-inspector)

(defun structure-slots (s)
  (let ((slots (ccl::sd-slots (ccl::struct-def s))))
    (if (symbolp (caar slots))
      slots
      (cdr slots))))

(defmethod compute-line-count ((s structure-object))
  (length (structure-slots s)))

(defmethod line-n ((s structure-object) n)
  (let ((slot (nth n (structure-slots s))))
    (if slot
      (values (uvref s (ccl::ssd-offset slot)) (ccl::ssd-name slot) :colon)
      (line-n-out-of-range s n))))

(defmethod (setf line-n) (new-value (s structure-object) n)
  (let ((slot (nth n (structure-slots s))))
    (if slot
      (setf (uvref s (ccl::ssd-offset slot)) new-value)
      (setf-line-n-out-of-range s n))))

;;;;;;;
;;
;; packages
;;
(defclass package-inspector (uvector-inspector) ())

(defmethod inspector-class ((p package)) 'package-inspector)

(defmethod compute-line-count ((i package-inspector))
  (+ 2 (call-next-method)))

(defmethod line-n ((i package-inspector) n)
  (cond ((eql n 0) (values (ccl::%pkgtab-count (ccl::pkg.itab (inspector-object i)))
                           "Internal Symbols: " :static))
        ((eql n 1) (values (ccl::%pkgtab-count (ccl::pkg.etab (inspector-object i)))
                           "External Symbols: " :static))
        (t (call-next-method i (- n 2)))))

(defmethod (setf line-n) (new-value (i package-inspector) n)
  (if (< n 2)
    (setf-line-n-out-of-range i n)
    (call-next-method new-value i (- n 2))))

(defmethod inspector-commands ((i package-inspector))
  `(("Inspect all packages" ,#'(lambda () (inspect (list-all-packages))))
    (,(format nil "(setq *package* '~a" (inspector-object i))
     ,#'(lambda () (setq *package* (inspector-object i))))))

;;;;;;;
;;
;; Records
;;
(defclass record-inspector (object-first-inspector)
  ((record-type :accessor record-type)
   (field-names :accessor field-names)
   (unlock :initform nil :accessor unlock)))

(defmethod inspector-class ((o macptr))
  (if (or (zone-pointerp o) (handlep o))
    'record-inspector
    'uvector-inspector))

(defmethod inspector-commands ((p macptr))
  `(,@(unless (%null-ptr-p p)
        `(("Inspect as a record"
           ,#'(lambda ()
                (funcall-with-chosen-record-type
                 #'(lambda (record-type)
                     (make-inspector-window 
                      (make-instance 'record-inspector :object p :record-type record-type))))))))
    ,@(macptr-commands p)))

(defmethod inspector-commands ((i record-inspector))
  (let ((macptr (inspector-object i)))
    `(("Choose different record type"
       ,#'(lambda ()
            (funcall-with-chosen-record-type
             #'(lambda (record-type)
                 (make-inspector-window
                  (if record-type
                    (make-instance 'record-inspector 
                      :object macptr :record-type record-type)
                    (make-instance 'uvector-inspector :object macptr))))
             macptr t)))
      ,@(macptr-commands macptr)
      ("Inspect as a MACPTR"
       ,#'(lambda () (make-inspector-window
                      (make-instance 'uvector-inspector :object macptr))))
      ("Inspect record type"
       ,#'(lambda ()
            (inspect-record-type (record-type i))))
      ("Inspect all record types" inspect-record-types))))

(defun macptr-commands (macptr)
  (when (handlep macptr)
    (let ((locked-p (handle-locked-p macptr)))
      (list `(,(if locked-p "Unlock Handle" "Lock Handle")
               ,#'(lambda ()
                    (if locked-p
                      (#_HUnLock macptr)
                      (#_HLock macptr))
                    (resample-it)))))))

(defmethod inspectors-match-p ((pane-inspector record-inspector) 
                               (new-inspector record-inspector)
                               object)
  (and (eql (inspector-object pane-inspector) object)
       (eq (record-type pane-inspector) (record-type new-inspector))))

(eval-when (compile eval)
  (require 'defrecord))

(defmethod initialize-instance ((i record-inspector) &key object record-type)
  (require 'defrecord)
  (call-next-method)
  (if (%null-ptr-p object)
    (setq record-type nil)
    (unless record-type
      (setq record-type (choose-record-type object))))
  (if record-type
    (setf (record-type i) record-type)
    (change-class i 'uvector-inspector)))

(defmethod compute-line-count ((i record-inspector))
  (let ((field-names (setf (field-names i)
                           (record-type-field-names (record-type i)))))
    (1+ (length field-names))))

(defmethod line-n ((i record-inspector) n)
  (if (eql n 0)
    (values (record-type i) "Record type = ")
    (let ((name (svref (field-names i) (1- n))))
      (values (get-record-field (inspector-object i) (record-type i) name)
              name
              :colon))))

(defmethod (setf line-n) (new-value (i record-inspector) n)
  (if (eql n 0)
    (if (and (or (symbolp new-value) (stringp new-value))
             (record-type-p (setq new-value
                                  (intern (string new-value) "KEYWORD"))))
      (progn
        (setf (record-type i) new-value)
        (resample-it))
      (ed-beep))
    (let ((name (svref (field-names i) (1- n))))
      (set-record-field (inspector-object i) (record-type i) name new-value))))

(defmethod line-n-inspector ((i record-inspector) n value label type)
  (declare (ignore value label type))
  (if (< n 2)
    (call-next-method)
    (let ((object (inspector-object i)))
      (multiple-value-bind (value record-type)
                           (get-record-field object (record-type i)
                                             (svref (field-names i) (- n 2)))
        (if (and (macptrp value) (record-type-p record-type))
          (progn
            (when (and (handlep object) (not (handle-locked-p object)))
              (#_HLock :errchk object)
              (setf (unlock i) t))
            (make-instance 'record-inspector :object value :record-type record-type))
          (call-next-method))))))

(defun inspect-record (macptr record-type)
  (setq macptr (require-type macptr 'macptr))
  (make-inspector-window
   (make-instance 'record-inspector :object macptr :record-type record-type)))

(defmethod window-closing ((i record-inspector))
  (let ((object (inspector-object i)))
    (when (and (unlock i) (handlep object))
      (#_HUnLock :errchk object))))

(defun record-type-field-names (record-type)
  (let ((fields (copy-list (record-descriptor-fields
                            (find-record-descriptor record-type)))))
    (map 'vector #'field-descriptor-name
         (sort fields
               #'(lambda (x y)
                   (< (field-descriptor-offset x) (field-descriptor-offset y)))))))

(defun choose-record-type (&optional form force-choose)
  (funcall-with-chosen-record-type
   #'(lambda (record-type)
       (return-from choose-record-type record-type))
   form force-choose t))

(defun funcall-with-chosen-record-type (function &optional form force-choose no-new-process-p)
  ; form is nil from show-all - so relevant-types returns all known records
  (let* ((relevant-types (relevant-record-types form)))
    (if (and form
             (eq 1 (length relevant-types))
             (if force-choose ; what?
               (progn (setq relevant-types (copy-list *record-types*))
                      nil)
               t))
      (funcall function (car relevant-types))
      (let* ((table (make-instance 'ccl::arrow-dialog-item
                      :view-size #@(288 98)
                      :view-position #@(6 30)
                      :view-font '("monaco" 9)
                      :help-spec 15172
                      ;:table-hscrollp nil
                      :table-sequence
                      `(("Load all records" ccl::load-all-records)
                         ;("Specify record type" :type)
                         ,@(unless (or (not *record-types*)
                                       (eql (length *record-types*)
                                            (length relevant-types)))
                             '(("Show ALL Record Types" :show-all)))
                         ("Inspect as a MACPTR" nil)
                         ("" nil t)
                         ,@(mapcar #'(lambda (type)
                                       `(,(symbol-name type)
                                         ,type)) 
                                   (sort relevant-types #'string-lessp 
                                         :key #'symbol-name)))
                      :table-print-function #'(lambda (thing &optional (stream t))
                                                 (princ (car thing) stream))))
             (dialog (make-instance 'ccl::select-dialog ; get the set-view-size method
                       :window-title "Choose or Enter Record Type"
                       :window-type :document-with-grow
                       :theme-background t
                       :close-box-p nil
                       :view-size #@(300 162)
                       :view-position '(:top 44) ;; was 40
                       :help-spec 15170
                       :view-subviews
                       (list
                        table
                        (make-dialog-item 'static-text-dialog-item #@(4 7) nil "Record Type:" nil
                                          :view-font '("chicago" 10))
                        (make-dialog-item 'editable-text-dialog-item #@(88 7) #@(204 12) "" nil
                                          :view-font '("monaco" 9)
                                          :help-spec 15171)
                        (make-dialog-item 'button-dialog-item #@(206 138) #@(60 18) "OK"                                          
                                          #'(lambda (i)
                                              (let ((key (current-key-handler (view-window i))))
                                               (return-from-modal-dialog
                                                (if (eq table key)
                                                  (ccl::selected-cell-contents table)
                                                  key))))
                                          :default-button t
                                          :help-spec 15174)
                        (make-dialog-item 'button-dialog-item #@(129 138) #@(60 18) "Cancel"
                                          #'ccl::return-cancel
                                          :help-spec 15173))))
             (key (modal-dialog dialog)))
        (let* ((chosen-record
                (if (consp key)
                  (cadr key)
                  (when key
                    (let* ((type-string (dialog-item-text key))
                           (type (ignore-errors
                                  (let ((*package* ccl::*keyword-package*))
                                    (read-from-string type-string)))))
                      (if (and type (symbolp type) (find-record-descriptor type nil))
                        type
                        (progn
                          (standard-alert-dialog ;message-dialog
                           (format nil "There is no record type named ~s" type)
                           :yes-text "Ok" :no-text nil :cancel-text nil :alert-type :note)
                          (choose-record-type form force-choose))))))))
          (cond ((eq chosen-record 'ccl::load-all-records)
                 (if no-new-process-p
                   (progn
                     ; This is a kluge because I didn't want to rearrange everything
                     ; to always be able to do this in another process.
                     (when (and (eq *current-process* ccl::*event-processor*)
                                (not ccl::*single-process-p*))
                       (unless (y-or-n-dialog (format nil
                                                      "Loading all records in the event processor will ~
                                                       make your lisp behave strangely until it's done. ~
                                                       The only way to stop it is to abort the \"Initial\" ~
                                                       or \"Event processing standin\" process. Go ahead?"
                                                      :cancel-text nil))
                         (cancel)))
                     (ccl::load-all-records)
                     (choose-record-type form force-choose))
                   (load-all-records-and-continue
                    #'(lambda () (funcall-with-chosen-record-type function form force-choose)))))
                ((eq chosen-record :show-all)
                 (funcall-with-chosen-record-type function))
                (t (funcall function chosen-record))))))))

(defun relevant-record-types (form &aux size res)
  (or (and (macptrp form)
           (setq size (pointer-size form))
           (dolist (r *record-types* res)
             (when (eql size (record-descriptor-length 
                              (gethash r ccl::%record-descriptors%)))
               (push r res))))
      (and (null form) (copy-list *record-types*))
      ))

(defun inspect-record-types (&rest ignore)
  (declare (ignore ignore))
  (let ((w (find-window "Record Types" 'inspector-window)))
    (if (and w (typep (inspector w) 'sequence-inspector))
      (progn
        (window-select w)
        (resample w))
      (make-inspector-window              
       (make-instance 'sequence-inspector
         :window-title "Record Types"
         :resample-function #'(lambda (i)
                                (declare (ignore i))
                                (sort (copy-list *record-types*) #'string-lessp))
         :setf-line-n-p nil
         :line-n-inspector #'(lambda (i n value label type)
                               (declare (ignore i n label type))
                               (make-record-type-inspector value))
         :commands `(("Load all records"
                      ,#'(lambda ()
                           (let ((w (front-window)))
                             (load-all-records-and-continue
                              #'(lambda ()
                                  (when (wptr w) (resample w)))))))
                     ("Enter record type"
                      ,#'(lambda ()
                           (let* ((string (get-string-from-user "Enter record type:" :size #@(280 80)))
                                  (type (ignore-errors
                                         (let ((*package* ccl::*keyword-package*))
                                           (read-from-string string)))))
                             (if (and type (symbolp type) (find-record-descriptor type nil))
                               (progn 
                                 (cons type *record-types*)
                                 (resample (front-window)))
                               (progn
                                 (standard-alert-dialog ;message-dialog
                                  (format nil "There is no record type named ~s" type)
                                  :yes-text "Ok" :no-text nil :cancel-text nil :alert-type :note))))))))
       :edit-value-button nil))))

(defun load-all-records-and-continue (&optional thunk)
  (ccl::maybe-process-run-function
   "Load all records"
   #'(lambda (thunk)
       (with-event-processing-enabled
         (ccl::load-all-records))
       (when thunk (funcall thunk)))
   thunk))

(defun inspect-record-field-types (&rest ignore)
  (declare (ignore ignore))
  (let ((w (find-window "Record Field Types" 'inspector-window)))
    (if (and w (typep (inspector w) 'sequence-inspector))
      (progn
        (window-select w)
        (resample w))
      (make-inspector-window
       (make-instance 'sequence-inspector
         :window-title "Record Field Types"
         :resample-function #'(lambda (i)
                                (declare (ignore i))
                                (sort (copy-list *mactypes*) #'string-lessp))
         :setf-line-n-p nil
         :line-n-inspector #'(lambda (i n value label type)
                               (declare (ignore i n label type))
                               (make-inspector (ccl::find-mactype value nil)))
         :line-n-function #'(lambda (i n)
                              (let ((value (nth n (inspector-object i))))
                                (values value
                                        (ccl::mactype-record-size (ccl::find-mactype value))
                                        :static
                                        #'(lambda (i stream value label type)
                                            (declare (ignore i type))
                                            (declare-stream-fonts stream t :plain)
                                            (set-stream-font stream :plain)
                                            (format stream "~20s ~3@s" value label)))))
         :commands `(("Load all mactypes"
                      ,#'(lambda ()
                           (let ((w (front-window)))
                             (with-event-processing-enabled ;ccl::let-globally ((ccl::*processing-events* nil))
                               (ccl::load-all-mactypes)
                               (when (wptr w) (resample w))))))))
       :edit-value-button nil))))

(defun inspect-record-type (record-type)
  (make-inspector-window (make-record-type-inspector record-type)))

(defun make-record-type-inspector (record-type)
  (let* ((desc (or (find-record-descriptor record-type nil)
                   (return-from make-record-type-inspector nil)))
         (name (record-descriptor-name desc))
         (length (record-descriptor-length desc))
         (storage (record-descriptor-storage desc))
         (fields (sort (copy-list (record-descriptor-fields desc))
                       #'< :key #'field-descriptor-offset)))
    (map-windows #'(lambda (w)
                     (let ((i (inspector w))
                           seq)
                       (when (and (typep i 'sequence-inspector)
                                  (listp (setq seq (inspector-object i)))
                                  (>= (length seq) 5)
                                  (eq (car seq) name)
                                  (typep (nth 3 seq) 'ccl::record-descriptor))
                         (return-from make-record-type-inspector i))))
                 :class 'inspector-window)
    (make-instance 'sequence-inspector
      :window-title (format nil "~s Record" name)
      :resample-function #'(lambda (i)
                             (declare (ignore i))
                             `(,name ,length ,storage ,desc nil ,@fields))
      :setf-line-n-p nil
      :line-n-function #'(lambda (i n)
                           (let ((value (nth n (inspector-object i))))
                             (case n
                               (0 (values value "Record Type:  " :static))
                               (1 (values value "Length:       " :static))
                               (2 (values value "Storage Type: " :static))
                               (3 (values value "Descriptor:   " :static))
                               (4 (values nil "field-name        field-type          byte-offset  length"
                                          *bold-comment-type*))
                               (t (values value nil :static
                                          #'(lambda (i stream value label type)
                                              (declare (ignore i label type))
                                              (declare-stream-fonts stream t :plain)
                                              (set-stream-font stream :plain)
                                              (format stream "~20s ~26s ~3@s ~12@s"
                                                  (field-descriptor-name value)
                                                  (field-descriptor-type value)
                                                  (field-descriptor-offset value)
                                                  (field-descriptor-length value))))))))
      :line-n-inspector #'(lambda (i n value label type)
                            (declare (ignore i label type))
                            (when (> n 3)
                              (let ((type (field-descriptor-type value))
                                    thing)
                                (if (and (listp type)
                                         (listp (cdr type)))
                                  (setq type (cadr type)))
                                (cond ((not (symbolp type)) nil)
                                      ((setq thing (find-record-descriptor type nil))
                                       (make-record-type-inspector type))
                                      ((setq thing (ccl::find-mactype type nil))
                                       (make-inspector thing)))))))))

;;;;;;;
;;
;; Classes
;;


(defclass standard-class-inspector (standard-object-inspector)
   ())

(defmethod inspector-class ((s standard-class))
   'standard-class-inspector)

(defmethod inspector-commands ((i standard-class-inspector))
  (append (call-next-method)
          (list `("Methods"
                  ,#'(lambda () 
                       (inspect (specializer-direct-methods (inspector-object i))))))))
       
;;;;;;;
;;
;; stack group buffer inspector
;;
#-ppc-target
(progn

(defclass sgbuf-inspector (uvector-inspector) ())

(defmethod inspector-class ((sgbuf ccl::sgbuf))
  'sgbuf-inspector)

(defmethod line-n ((i sgbuf-inspector) n)
  (declare (ignore n))
  (multiple-value-bind (value label type) (call-next-method)
    (values
     (if (memq label '(ccl::sgbuf.csbuf ccl::sgbuf.vsbuf ccl::sgbuf.tempvbuf
                       ccl::sgbuf.cslimit ccl::sgbuf.vslimit))
       (%int-to-ptr (ash value ccl::$fixnumshift))
       value)
     label
     type)))

(defmethod line-n-inspector ((i sgbuf-inspector) n value label type)
  (declare (ignore n type))
  (if (and (memq label '(ccl::sgbuf.csbuf ccl::sgbuf.vsbuf ccl::sgbuf.tempvbuf))
           (not (%null-ptr-p value)))
    (make-instance 'record-inspector
      :object value
      :record-type :stackseg)
    (call-next-method)))

)  ; end of progn

;;;;;;;
;;
;; PPC stack group inspector
;;
#+ppc-target
(progn

(defclass stack-group-inspector (uvector-inspector) ())

(defmethod inspector-class ((sg ccl::stack-group))
  'stack-group-inspector)

(defmethod compute-line-count :before ((i stack-group-inspector))
  (when (eq (inspector-object i) ccl::*current-stack-group*)
    (ccl::%normalize-areas)))

(defmethod line-n ((sg stack-group-inspector) n)
  (declare (ignore n))
  (multiple-value-bind (value label type) (call-next-method)
    (values
     (or (and (fixnump value)
              (>= value 0)
              (memq label '(ccl::sg.xframe ccl::sg.cs-area ccl::sg.vs-area
                            ccl::sg.ts-area ccl::sg.cs-overflow-limit))
              (%int-to-ptr (ash value 2)))
         value)
     label
     type)))

(defmethod line-n-inspector ((i stack-group-inspector) n value label type)
  (declare (ignore n type))
  (or (and value
           (macptrp value)
           (not (%null-ptr-p value))
           (cond ((memq label '(ccl::sg.cs-area ccl::sg.vs-area ccl::sg.ts-area))
                  (make-instance 'record-inspector
                    :object value
                    :record-type :gc-area))
                 ((eq label 'ccl::sg.xframe)
                  (make-instance 'record-inspector
                    :object value
                    :record-type :xframe-list))
                 (t nil)))
      (call-next-method)))
)

;;;;;;;
;;
;; The "Inspector Central" window is history
;;
#|
(defvar *inspect-system-data-window* nil)

(defun ccl::inspect-system-data ()
  (if (and *inspect-system-data-window*
           (wptr *inspect-system-data-window*))
    (window-select *inspect-system-data-window*)
    (let ((w (select-item-from-list ;make-button-list-window              
              `(("Record Types" inspect-record-types :help-spec 14052)
                ("Record Field Types" inspect-record-field-types :help-spec 14053)
                ;("Inspector History" inspect-history :help-spec 14042)
                ("")
                ("Inspector Help" inspector-help :help-spec 14041)
                ("Disk Devices" inspect-devices :help-spec 14043)
                ;("Logical Directory Names" inspect-logical-directories :help-spec 14044)
                ("Logical Hosts" inspect-logical-hosts :help-spec 14045)
                ("")
                #|("(windows)" ,#'(lambda (i) (declare (ignore i)) (inspect-object (windows)))
                 :help-spec 14046)
                ("(front-window)" ,#'(lambda (i) (declare (ignore i)) (inspect-object (target)))
                 :help-spec 14047)
                (nil)|#
                ("*features*" ,#'(lambda () (inspect-object *features*))
                 :help-spec 14048)
                ("(list-all-packages)" ,#'(lambda ()  (inspect-object (list-all-packages)))
                 :help-spec 14049)
                ("*package*" ,#'(lambda ()  (inspect-object *package*))
                 :help-spec 14050)
                ("*readtable*" ,#'(lambda ()  (inspect-object *readtable*))
                 :help-spec 14051))
              :view-size #@(220 165)
              :window-title "Inspector Central"
              :action-function #'(lambda (list)(funcall (cadar list)))
              :table-print-function #'(lambda (x &optional (stream t))(princ (car x) stream))
              :modeless t)))
      (setq *inspect-system-data-window* w)
      w)))
|#



(eval-when (:load-toplevel :execute)
  
(let* ((menu (find-menu-item *tools-menu* "Inspector")))
  (let ((sub-items (menu-items menu)))
    (when (not sub-items)
      (apply #'add-menu-items 
       menu       
       (ccl::make-menu-items 
        `(("Record Types" inspector::inspect-record-types :help-spec 14052)
          ("Record Field Types" 
                       inspector::inspect-record-field-types :help-spec 14053)
          "-"
          ("Inspector Help" inspector-help :help-spec 14041)
          ("Inspector History" inspect-history :help-spec 14042)
          "-"
          ("Disk Devices" inspector::inspect-devices :help-spec 14043)
          ;("Logical Directory Names" inspect-logical-directories :help-spec 14044)
          ("Logical Hosts" inspector::inspect-logical-hosts :help-spec 14045)
          "-"
          ("Packages" ,#'(lambda ()  (inspector::inspect-object (list-all-packages)))
                       :help-spec 14049)
          ("*package*" ,#'(lambda ()  (inspector::inspect-object *package*))
                       :help-spec 14050)
          ("*readtable*" ,#'(lambda ()  (inspector::inspect-object *readtable*))
                       :help-spec 14051)
       ))))))
)

                      

(defun inspector-help ()
  ;(declare (ignore i))
  (ed "ccl:inspector;Inspector Help"))

(defclass inspector-history-window (inspector-window) ())

(defun inspect-history ()
  (let ((w (front-window :class 'inspector-history-window)))
    (if w
      (window-select w)
      (flet ((resample-function (i)
               (declare (ignore i))
               (or *inspector-history*
                   '("Choose the Set History Length command to keep a history"))))
        (setq w
              (make-instance 
               'inspector-history-window
               :inspector (make-instance 'sequence-inspector
                                         :object (resample-function nil)
                                         :window-title "Inspector History" 
                                         :print-function 
                                         #'(lambda (thing stream)
                                             (prin1 (if (typep thing 'inspector)
                                                      (inspector-object thing)
                                                      thing)
                                                    stream))
                                         :resample-function #'resample-function
                                         :setf-line-n-p nil
                                         :commands `(("Clear History"
                                                      ,#'(lambda ()
                                                           (setq *inspector-history*
                                                                 (make-list (length *inspector-history*)))
                                                           (resample-it)))
                                                     ("Set History LengthÉ"
                                                      ,#'(lambda ()
                                                           (let ((s (get-string-from-user
                                                                     "Enter new Inspector history length"
                                                                     :initial-string
                                                                     (format nil "~d" (length *inspector-history*)))))
                                                             (multiple-value-bind (new-length pos) (parse-integer s :junk-allowed t)
                                                               (if (eql pos (length s))
                                                                 (progn 
                                                                   (setq *inspector-history* (make-list new-length))
                                                                   (resample-it))
                                                                 (ed-beep)))))))
                                         :line-n-inspector
                                         #'(lambda (i n value label type)
                                             (declare (ignore i n label type))
                                             (make-inspector
                                              (if (typep value 'inspector)
                                                (inspector-object value)
                                                value)))
                                         :replace-object-p nil)))))))

(defmethod copy ((i inspector-history-window))
  (call-next-method)
  (put-scrap :lisp (inspector-object (get-scrap :lisp))))

(defun inspect-devices ()  
  (let* ((title " Devices ")            ; Spaces distinguish from the symbol
         (w (find-window title 'inspector-window)))
    (if w
      (window-select w)
      (make-instance
       'inspector-window
       :inspector (make-instance
                   'sequence-inspector
                   :window-title title
                   :object (directory "*:")
                   :print-function #'princ
                   :resample-function #'(lambda (i)
                                          (declare (ignore i))
                                          (directory "*:"))
                   :replace-object-p nil)))))
#|                                                 
(defun inspect-logical-directories ()  
  (let* ((title  "Logical Directories")
         (w (find-window title 'inspector-window)))
    (if w
      (window-select w)
      (make-instance
       'inspector-window
       :inspector (make-instance 
                   'sequence-inspector
                   :window-title title
                   :object ccl::*logical-directory-alist*
                   :print-function #'(lambda (o s)
                                       (format s "\"~a;\" -> ~s"
                                               (car o) (cdr o)))
                   :resample-function #'(lambda (i)
                                          (declare (ignore i))
                                          ccl::*logical-directory-alist*)
                   :replace-object-p nil
                   :setf-line-n-p nil)))))
|#


(defun inspect-logical-hosts ()
  (flet ((mashit (lst)
                 (mapcan #'(lambda (x)
                             (copy-list x))
                         lst)))
  (let* ((title  "Logical Hosts")
         (w (find-window title 'inspector-window)))
    (if w
      (window-select w)
      (make-instance
       'inspector-window
       :inspector (make-instance 
                   'sequence-inspector
                   :window-title title
                   :object (mashit ccl::%logical-host-translations%)
                   :print-function #'(lambda (o s)
                                       (if (not (consp o))
                                         (format s "Logical host ~s" o)
                                         (format s "   \"~a\" -> \"~a\"" (car o)(cadr o))))
                   :resample-function #'(lambda (i)
                                          (declare (ignore i))
                                          (mashit ccl::%logical-host-translations%))
                   :replace-object-p nil
                   :setf-line-n-p nil))))))

(defclass processes-inspector (sequence-inspector) ())


(defmethod inspector-commands ((i processes-inspector))
  (let* ((view (inspector-view i))
         (selection (selection view))
         (processes (inspector-object i))
         (p (and selection (elt processes selection))))
    (nconc
     `(("Clear run times" ,#'(lambda ()
                               (dolist (p (cdr processes))
                                 (clear-process-run-time p))
                               (resample-it))))
     (when p
       (flet ((doit (function &optional warning-message)
                (let ((p (elt processes selection)))
                  (when (or (null warning-message)
                            (y-or-n-dialog (format nil warning-message p)
                                           :cancel-text nil))
                    (funcall function p)
                    (resample-it)))))
         ; It's not nice to do some things to the event processing process
         `(,@(when (and (neq p ccl::*event-processor*)
                        (neq p ccl::*initial-process*))
               `(("Arrest" ,#'(lambda () (doit 'ccl::process-enable-arrest-reason)))
                 ("Un-Arrest" ,#'(lambda () (doit 'ccl::process-disable-arrest-reason)))
                 ("Reset" ,#'(lambda () (doit 'ccl::process-reset
                                              "Do you really want to reset ~s?")))
                 ("Kill" ,#'(lambda () (doit 'ccl::process-kill-and-wait
                                             "Do you really want to kill ~s?")))))
           ; You can enter a break loop in the *initial-process*
           ; but not in the event processing standin.
           ,@(when (and (or (neq p ccl::*event-processor*)
                            (eq ccl::*event-processor* ccl::*initial-process*))
                        (not (ccl::process-exhausted-p p)))
               `(("Debugger" ,#'(lambda ()
                                  (doit #'(lambda (p)
                                            (ccl::process-interrupt p #'break)))))))))))))

(defun ccl::inspect-processes ()
  (let* ((title "Processes")
         (w (find-window title 'inspector-window)))
    (flet ((get-process-list (&optional ignore)
             (declare (ignore ignore))
             (cons #.(format nil "Name~30tState~50tPriority~60tIdle~67t% Utilization")
                   (copy-list ccl::*all-processes*))))
      (if w
        (progn (window-select w) (resample w))
        (make-instance 'inspector-window
          :edit-value-button nil
          :inspector (make-instance 'processes-inspector
                       :window-title title
                       :object (get-process-list)
                       :print-function 'inspect-processes-print-function
                       :line-n-function #'(lambda (i n)
                                            (let ((o (inspector-object i)))
                                              (if (eql n 0)
                                                (values nil (elt o 0) '(:comment (:underline)))
                                                (values (elt o n) nil :static))))
                       :resample-function #'get-process-list
                       :replace-object-p nil
                       :setf-line-n-p nil))))))

(defun inspect-processes-print-function (p s)
  (if (stringp p)
    (format s p)
    (let ((idle-time (if (eq p *current-process*)
                       0.0
                       (/ (ccl::%tick-difference
                           (ccl::get-tick-count)
                           (process-last-run-time p))
                          60.0)))
          (idle-units "s"))
      (when (>= idle-time 60)
        (setq idle-time (/ idle-time 60)
              idle-units "m")
        (when (>= idle-time 60)
          (setq idle-time (/ idle-time 60)
                idle-units "h")
          (when (>= idle-time 24)
            (setq idle-time (/ idle-time 24)
                  idle-units "d"))))
      (format s "~a~30t~a~52t~3d~56t~8,2f~a~71t~5,1f"
              (process-name p)
              (process-whostate p)
              (process-priority p)
              idle-time idle-units
              (* 100.0
                 (let ((ticks (- (#_TickCount) (process-creation-time p))))
                   (/ (process-total-run-time p)
                      (if (eql ticks 0) 1 ticks))))))))

; This is the last file of the inspector.
(provide :inspector)

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
