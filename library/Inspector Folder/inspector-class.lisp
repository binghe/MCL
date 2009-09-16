;; -*- Mode:Lisp; Package:INSPECTOR; -*-

;;	Change History (most recent first):
;;  $Log: inspector-class.lisp,v $
;;  Revision 1.9  2006/02/06 20:50:38  alice
;;  ;; remove typo
;;
;;  Revision 1.8  2006/02/06 00:35:10  alice
;;  ;; dont say #_moveto :word

;;
;;  Revision 1.7  2005/02/08 04:48:01  alice
;;  ; already-focused-stream-write-string lets grafport-write-string deal with unicode
;;
;;  Revision 1.6  2004/09/08 02:43:09  alice
;;  ;; 09/06/04 akh say "confused" rather than error when line n out of range, probably due to redefined class
;;
;;  Revision 1.5  2004/01/28 10:01:31  gtbyers
;;  Handle %SLOT-UNBOUND-MARKER.
;;
;;  Revision 1.4  2003/12/08 08:17:46  gtbyers
;;  Navigate new CLOS objects.
;;
;;  2 10/17/95 akh  merge patches
;;  4 5/7/95   slh  balloon help mods.
;;  2 4/28/95  akh  stream-font-codes?
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  inspector-class.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  inspect/describe/backtrace
;;

;;;;;;;
;;
;; Change log
;; eq #\newline -> char-eolp
;; ----- 5.2b4
;; dont say #_moveto :word
;; already-focused-stream-write-string lets grafport-write-string deal with unicode
;; ------- 5.1 final
;; 09/06/04 akh say "confused" rather than error when line n out of range, probably due to redefined class
;; --------- 5.1b2
;; 12/30/96 bill standard-object-compute-line-count knows about the new order's way
;;               of telling if an instance is forwarded.
;; ------------- 4.0
;; 08/27/96 bill (method inspector-class :around (t)) returns 'bogus-object-inspector
;;               for objects that are ccl::bogus-thing-p.
;;               eliminate-unbound returns a bogus-object-wrapper instance for them.
;; ------------- 4.0b1
;; clear-margin don't assume vpos is 0, it isn't always. (still assumes hpos is 0)
;;----------------
;; 06/06/93 alice - undo below - it broke describe
;; 07/13/93 bill update-line-count returns to (method initialize-instance :after (inspector))
;;               but with a :update-line-count keyword arg to enable it.
;;               sequence-inspector has (:default-initargs :update-line-count t)
;; 06/30/93 bill add update-line-count to describe-object
;; ------------- 3.0d12
;; 06/06/93 alice - undo below - it broke describe
;; ------------- 3.0d9
;; 05/25/93 bill no more update-line-count in (method initialize-instance :after (inspector))
;;               It will happen when the inspector is added to an inspector-view.
;;               This speeds up the creation of an inspector window.
;; ------------- 3.0d8
;; 02/04/92 bill font-info -> font-codes-info
;; 10/15/91 bill PRINC sometimes for labels of standard-object-inspector instances
;; 10/04/91 bill prin1, not princ for slot names
;; 08/22/91 bill old error in parse-type
;; 07/12/91 bill :around methods eliminate & restore #<unbound> for line-n
;; 07/09/91 bill "ccl::" package prefix for unexported symbols
;; 06/24/91 bill handle standard-object instances with no instance slots.
;; 04/30/91 alms (defmethod inspector-window-class ((inspector inspector))
;;               (defmethod  inspector-view-class ((insp inspector))
;; 03/14/91 bill with-errorfree-printing & use of it in describe-object
;; 03/05/91 bill split off the bodies of the standard-object-inspector methods
;;               so that gf-inspector can use them.
;;----------- 2.0b1
;; 01/08/91 bill convert to new traps
;; 12/10/90 bill bind *signal-printing-errors* to NIL in prin1-line
;; 10/24/90 bill changed many defmethod's to defun's
;; 10/10/90 bill inspector-class can return a second value: an alias for the object.
;; 09/25/90 bill Add stream arg to describe
;; 09/18/90 bill Created
;;
;;;;;;;

(in-package :inspector)

; The basic inspector object.
; Note that this knows nothing about windows.
; It merely knows how to number the constituent parts of an object,
; How to access a constituent, and how to print a constituent to a stream.
(defclass inspector ()
  ((object :accessor inspector-object :initarg :object)
   (line-count :accessor inspector-line-count :initarg :line-count :initform nil)
   (view :accessor inspector-view :initform nil :initarg :view)))

; The usual way to cons up an inspector
(defmethod make-inspector (object)
  (multiple-value-bind (class alias) (inspector-class object)
    (make-instance class :object (or alias object))))

(defmethod initialize-instance :after ((i inspector) &key update-line-count)
  (when update-line-count
    (update-line-count i)))

(defmethod inspector-window-class ((inspector inspector))
  'inspector-window)

(defmethod  inspector-view-class ((insp inspector))
  'inspector-view)

;;;;;;;
;;
;; The protocol for an inspector.
;; Change these to defgeneric's when it exists.
;;
;; Usually, you need to define methods only for
;; inspector-class, compute-line-count, line-n, and (setf line-n)

; Return the type of inspector for an object
(defmethod inspector-class (object)
  (cond ((method-exists-p #'line-n object 0) 'usual-inspector)
        ((and (uvectorp object)
              (find-class 'uvector-inspector nil))
         'uvector-inspector)
        (t 'basic-inspector)))

; Return three values: the value, label, and type of the nth line of the object
; Valid types are:
;  :NORMAL or NIL  - a normal constituent line: changeable
;  :COLON          - a normal line with ": " between the label and the value
;  :COMMENT        - a commentary line - Print only the label
;  :STATIC         - a commentary line with an inspectable value: not changeable
; Or a list whose first element is one of the types above and whose
; second and third elements are font-specs for the label & value, respectively.
; If there is no third element, then the second element is the font-spec.
; for both the label and value.
(defmethod line-n ((i inspector) n)
  (declare (ignore n)))

; set the value of line n of the object (the label is fixed)
(defmethod (setf line-n) (value (i inspector) n)
  (declare (ignore value n)))

; Compute the number of lines in the object
(defmethod compute-line-count ((i inspector))
  )

; Compute the number of lines in the object and set the line-count slot
; If the length is greater than the limit, return (list limit)
(defun update-line-count (inspector)
  (setf (inspector-line-count inspector) (compute-line-count inspector)))

; Print the nth line to a stream
(defmethod prin1-line-n ((i inspector) stream n)
  (multiple-value-call #'prin1-line i stream (line-n i n)))

(defmethod prin1-line ((i inspector) stream value &optional
                       label type function)
  (unless function
    (setq function (inspector-print-function i type)))
  (funcall function i stream value label type))

(defmethod inspector-print-function ((i inspector) type)
  (if (consp type) (setq type (car type)))
  (if (eq type :comment)
    'prin1-comment
    'prin1-normal-line))

(defmacro with-preserved-stream-font (stream &body body)
  (let* ((temp (gensym)))
    `(let* ((,temp #'(lambda () ,@body)))
       (declare (dynamic-extent ,temp))
       (call-with-preserved-stream-font ,stream ,temp))))

(defmethod call-with-preserved-stream-font ((stream stream) thunk)
  (multiple-value-bind (ff ms) (stream-font-codes stream)
    (unwind-protect
      (funcall thunk)
      (set-stream-font-codes stream ff ms))))

; Print a value to a stream.
; Defaults to :ITALIC for labels, and :NORMAL for values.
(defmethod prin1-normal-line ((i inspector) stream value &optional label type
                              colon-p)
  (multiple-value-bind (type-sym label-font value-font)
                       (parse-type i type)
    (if (eq type-sym :colon) (setq colon-p t))
    (with-preserved-stream-font stream
      (declare-stream-fonts stream t label-font value-font)
      (when label
        (set-stream-font stream label-font)
        (prin1-label i stream value label type)
        (if colon-p (princ ": " stream)))
      (end-of-label stream)              ; used by cacheing code
      (set-stream-font stream value-font)
      (prin1-value i stream value label type))))

(defun prin1-colon-line (i stream value &optional label type)
  (prin1-normal-line i stream value label type t))

(defmethod prin1-label ((i inspector) stream value &optional label type)
  (declare (ignore value type))
  (if (stringp label)
    (stream-write-string stream label 0 (length label))
    (princ label stream)))

(defmethod prin1-value ((i inspector) stream value &optional label type)
  (declare (ignore label type))
  (prin1 value stream))

(defmethod prin1-comment ((i inspector) stream value &optional label type)
  (multiple-value-bind (type-sym font) (parse-type i type)
    (declare (ignore type-sym))
    (when label
      (with-preserved-stream-font stream
        (declare-stream-fonts stream t font)
        (set-stream-font stream font)
        (prin1-label i stream value label type)
        (end-of-label stream)))))
  
; Call function on the inspector object and its value, label, & type, for
; each line in the selected range (default to the whole thing).
; This can avoid (e.g.) doing NTH for each element of a list.
; This is the generic-function which the inspector-window uses to
; display a screenful.
(defmethod map-lines ((i inspector) function &optional 
                      (start 0) 
                      end)
  (unless end
    (setq end (inspector-line-count i)))
  (when (and start end)
    (let ((index start))
      (dotimes (c (- end start))
        (declare (fixnum c))
        (multiple-value-call function i (line-n i index))
        (incf index)))))

;;;;;;;
;;
;; Dealing with unbound slots and bogus objects
;;
(defclass unbound-marker () ())

(defvar *unbound-marker* (make-instance 'unbound-marker))
(defvar *slot-unbound-marker* (make-instance 'unbound-marker))

(defmethod print-object ((x unbound-marker) stream)
  (print-object (ccl::%unbound-marker-8) stream))

(defclass bogus-object-wrapper ()
  ((address :initarg :address)))

(defmethod print-object ((x bogus-object-wrapper) stream)
  (print-unreadable-object (x stream)
    (format stream "BOGUS object @ #x~x" (slot-value x 'address))))

(defvar *bogus-object-hash*
  (make-hash-table :test 'eql :weak :value :size 0))

(defun bogus-object-wrapper (x)
  (let ((address (%address-of x)))
    (or (gethash address *bogus-object-hash*)
        (setf (gethash address *bogus-object-hash*)
              (make-instance 'bogus-object-wrapper :address address)))))

(defun eliminate-unbound (x)
  (cond ((eq x (ccl::%unbound-marker-8))
         *unbound-marker*)
        ((eq x (ccl::%slot-unbound-marker))
         *slot-unbound-marker*)
        ((ccl::bogus-thing-p x)
         (bogus-object-wrapper x))
        (t x)))

(defun restore-unbound (x)
  (if (eq x *unbound-marker*)
    (ccl::%unbound-marker-8)
    (if (eq x *slot-unbound-marker*)
      (ccl::%slot-unbound-marker)
      x)))

(defmethod line-n :around ((i inspector) n)
  (declare (ignore n))
  (let ((res (multiple-value-list (call-next-method))))
    (declare (dynamic-extent rest))
    (apply #'values (eliminate-unbound (car res)) (cdr res))))

(defmethod (setf line-n) :around (new-value (i inspector) n)
  (call-next-method (restore-unbound new-value) i n))


;;;;;;;
;;
;; describe-object
;; Eventually, this wants to reuse a global inspector rather than
;; consing one.
(defparameter *describe-pretty* t)

(defmacro with-errorfree-printing (&body body)
  `(let ((*print-readably* nil)
         (*signal-printing-errors* nil))
     ,@body))

(defun describe (object &optional stream)
  (cond ((null stream) (setq stream *standard-output*))
        ((eq stream t) (setq stream *terminal-io*)))
  (setq stream (require-type stream 'stream))
  (describe-object object stream)
  (values))

(defmethod describe-object (object stream)
  (let ((inspector (make-inspector object)))
    (when (null (inspector-line-count inspector))
      (update-line-count inspector))
    (with-focused-view (if (typep stream 'simple-view) stream nil)
      (with-preserved-stream-font stream
        (with-errorfree-printing
          (let* ((*print-pretty* (or *print-pretty* *describe-pretty*))
                 (temp #'(lambda (i value &rest rest)
                            (declare (dynamic-extent rest))
                           (apply #'prin1-line i stream value rest)
                           (terpri stream))))
            (declare (dynamic-extent temp))
            (map-lines inspector temp))))))
  (values))

;;;;;;;
;;
;; formatting-inspector
;; This one prints using a format string.
;; Expects line-n to return (values value label type format-string)

(defclass formatting-inspector (inspector) ())
(defclass usual-formatting-inspector (usual-inspector formatting-inspector) ())

(defmethod prin1-line ((i formatting-inspector) stream value
                       &optional label type (format-string "~s"))
  (if (eq :comment (if (consp type) (car type) type))
    (prin1-comment i stream value label type)
    (funcall (if (listp format-string) #'apply #'funcall)
             #'format-normal-line i stream value label type format-string)))

(defmethod format-normal-line ((i inspector) stream value &optional 
                               label type (format-string "~s") colon-p)
  (multiple-value-bind (type-sym label-font value-font)
                       (parse-type i type)
    (if (eq type-sym :colon) (setq colon-p t))
    (with-preserved-stream-font stream
      (declare-stream-fonts stream t label-font value-font)
      (when label
        (set-stream-font stream label-font)
        (if (stringp label)
          (stream-write-string stream label 0 (length label))
          (princ label stream))
        (if colon-p (princ ": " stream)))
      (end-of-label stream)              ; used by cacheing code
      (set-stream-font stream value-font)
      (format stream format-string value))))

;;;;;;;
;;
;; inspectors for CCL objects
;;

; First the font handling stuff
(defparameter *default-label-font* '(:bold))   ; change to :plain to speed up
(defparameter *default-value-font* '(:plain))
(defparameter *default-comment-font* '(:bold :underline))
(defparameter *default-static-font* '(:plain))

(defmethod default-label-font ((i inspector)) *default-label-font*)
(defmethod default-value-font ((i inspector)) *default-value-font*)
(defmethod default-comment-font ((i inspector)) *default-comment-font*)
(defmethod default-static-font ((i inspector)) *default-static-font*)

(defparameter *plain-comment-type* '(:comment (:plain)))
(defparameter *bold-comment-type* '(:comment (:bold)))

(defmethod parse-type ((i inspector) type &optional default1 default2)
  (multiple-value-bind (type-sym label-font value-font)
                       (if (consp type)
                         (values (car type) 
                                 (or (cadr type) default1)
                                 (or (caddr type) default2))
                         (values type default1 default2))
    (if (eq type-sym :comment)
      (let ((comment-font (default-comment-font i)))
        (unless value-font (setq value-font (or label-font comment-font)))
        (unless label-font (setq label-font comment-font)))
      (progn
        (unless value-font (setq value-font
                                 (or label-font
                                     (if (eq type-sym :static)
                                       (default-static-font i)
                                       (default-value-font i)))))
        (unless label-font (setq label-font (default-label-font i)))))
    (values type-sym label-font value-font)))

;;;;;
;;
;; Font handling
;;
;; Implementation of set-stream-font & declare-stream-fonts
;;

; Used by the cache-entry-stream class to save the column where the label ends.
(defmethod end-of-label (stream)
  (declare (ignore stream)))

(defmethod set-stream-font (stream font)
  (multiple-value-call #'set-stream-font-codes stream (font-codes font)))

(defmethod set-stream-font-codes (stream ff ms &optional ff-mask ms-mask)
  (declare (ignore stream ff-mask ms-mask))
  (values ff ms))

(defmethod set-stream-font-codes ((stream window) ff ms &optional ff-mask ms-mask)
  (set-view-font-codes stream ff ms ff-mask ms-mask))

(defmethod set-stream-font-codes ((stream simple-view) ff ms &optional 
                                  ff-mask ms-mask)
  (set-view-font-codes (view-window stream) ff ms ff-mask ms-mask))

(defmethod stream-font-codes (stream)
  (declare (ignore stream))
  (font-codes *fred-default-font-spec*))

(defmethod stream-font-codes ((stream window))
  (view-font-codes stream))

(defmethod stream-font-codes ((stream simple-view))
  (stream-font-codes (view-window stream)))

; This class exists to figure out the proper amount of vertical space
; to allow for a newline.  Users of it should call declare-stream-fonts
; (or declare-stream-font-codes) at the beginning of every line of output
; that has different fonts than the line before.
; It also handles line & page truncation by throwing to the specified tag
; if output goes off the right or bottom edge of the view.
(defclass font-size-manager (simple-view)
  ((margin :initform 0 :initarg :margin :accessor margin)
   (column :initform 0 :accessor stream-column)
   (newline-pending? :initform nil :accessor newline-pending?)
   (line-truncation-tag :initarg :line-truncation-tag 
                        :initform nil
                        :accessor line-truncation-tag)
   (page-truncation-tag :initarg :page-truncation-tag 
                        :initform nil
                        :accessor page-truncation-tag)
   (a-d-l :initform (list 0 0 0 0) :accessor a-d-l)   ; Ascent-Descent-Leading
   (last-a-d-l :initform (list 0 0 0 0) :accessor last-a-d-l)
   (font-codes :initform (list (list nil nil nil nil) (list nil nil nil nil))
               :accessor fsm-font-codes)))

(defmacro ascent (a-d-l) `(car ,a-d-l))
(defmacro descent (a-d-l) `(cadr ,a-d-l))
(defmacro leading (a-d-l) `(caddr ,a-d-l))
(defmacro maxwid (a-d-l) `(cadddr ,a-d-l))

(defmethod (setf margin) :after (new-margin (stream font-size-manager))
  (declare (ignore new-margin))
  (invalidate-view stream t))

(defmethod stream-tyo ((stream font-size-manager) char)
  (with-focused-view stream
    (if (newline-pending? stream)
      (do-terpri stream))
    (if (ccl::char-eolp char)
      (progn
        (setf (newline-pending? stream) t
              (stream-column stream) 0)
        (clear-to-eol stream)
        (let ((last-a-d-l (last-a-d-l stream))
              (a-d-l (a-d-l stream)))
          (setf (ascent last-a-d-l) (ascent a-d-l)
                (descent last-a-d-l) (descent a-d-l)
                (leading last-a-d-l) (leading a-d-l)
                (maxwid last-a-d-l) (maxwid a-d-l))))
      (progn
        (check-line-truncation stream)
        (incf (stream-column stream))
        (call-next-method))))
  char)

; Assume no newlines are included here
(defmethod stream-write-string ((stream font-size-manager) string start end)
  (declare (ignore string))
  (with-focused-view stream
    (if (newline-pending? stream)
      (do-terpri stream))
    (check-line-truncation stream)
    (incf (stream-column stream) (- end start))
    (call-next-method)))

; A faster version of the above that writes to the current grafport.
#|
(defun already-focused-stream-write-string (stream string start end)
      (if (newline-pending? stream)
        (do-terpri stream))
      (check-line-truncation stream)
      (incf (stream-column stream) (- end start))
      (if (and (ccl::extended-string-p string)
               (ccl::real-xstring-p string))
        (multiple-value-bind (ff ms)(grafport-font-codes)
          (let* ((script (ccl::ff-script ff))
                 eff)
            (if (AND (logbitp #$smsfSingByte (#_getscriptvariable script #$smscriptflags))
                     (SETQ EFF (ccl::extended-string-font-codes)))
              (with-font-codes (make-point (point-h ff)(point-v eff)) ms
                    (grafport-write-string string start end ))
              (grafport-write-string string start end))))
        (grafport-write-string string start end)))
|#

(defun already-focused-stream-write-string (stream string start end)
  (if (newline-pending? stream)
    (do-terpri stream))
  (check-line-truncation stream)
  (incf (stream-column stream) (- end start))          
  (grafport-write-string string start end))

; Clear to end of line
(defun clear-to-eol (stream)
  (with-focused-view stream
    (let* ((a-d-l (a-d-l stream))
           (ascent (ascent a-d-l))
           (descent (+ (descent a-d-l) (leading a-d-l)))
           (pen-pos (%getpen))
           (left (point-h pen-pos))
           (v (point-v pen-pos))
           (top (- v ascent))
           (bottom (+ v descent))
           (right (point-h (view-size stream))))
      (rlet ((rect :rect :top top :left left :bottom bottom :right right))
        (#_EraseRect rect)))))

; Clear to end of page
(defun clear-to-eop (stream)
  (with-focused-view stream
    (if (newline-pending? stream) (do-terpri stream))
    (let ((pen-pos (%getpen)))
      (unless (<= (point-h pen-pos) (margin stream))
        (clear-to-eol stream)
        (catch (page-truncation-tag stream)
          (do-terpri stream))
        (setq pen-pos (%getpen)))
      (let* ((a-d-l (a-d-l stream))
             (ascent (ascent a-d-l))
             (left 0)
             (top (- (point-v pen-pos) ascent))
             (size (view-size stream))
             (bottom (point-v size))
             (right (point-h size)))
        (rlet ((rect :rect :top top :left left :bottom bottom :right right))
          (#_EraseRect rect))))))

; Assumes view is focused
(defun do-terpri (stream)
  (setf (newline-pending? stream) nil)
  (let* ((a-d-l (a-d-l stream))
         (last-a-d-l (last-a-d-l stream))
         (leading (leading last-a-d-l))
         (margin (margin stream))
         (ascent (ascent a-d-l))
         (height (+ ascent (descent last-a-d-l) leading)))
    (let ((v (+ (point-v (%getpen)) height))
          (tag (page-truncation-tag stream)))
      (#_MoveTo margin  v)
      (if (> leading 0)
        (rlet ((rect :rect :left 0 :top (- v ascent leading)
                     :right (point-h (view-size stream)) :bottom (- v ascent)))
          (#_EraseRect rect)))
      (when tag
        (when (< (point-v (view-size stream)) (- v (ascent a-d-l)))
          (throw tag :end-of-page))))))

; Clear the margin.  Assumes that the stream is focused.
(defmethod clear-margin ((stream font-size-manager) &optional
                         (top (point-v (view-position stream)))
                         (bottom (+ top (point-v (view-size stream)))))
  (let* ((margin (margin stream)))
    (when (> margin 0)
      (rlet ((rect :rect :left 0 :top top :right margin :bottom bottom))        
        (#_EraseRect rect)))))

(defun check-line-truncation (stream)
  (let ((tag (line-truncation-tag stream)))
    (when tag
      (when (> (point-h (%getpen)) (point-h (view-size stream)))
        (throw tag :end-of-line)))))

(defmethod top-of-page (stream)
  (declare (ignore stream)))

(defmethod top-of-page ((stream font-size-manager))
  (let ((last-a-d-l (last-a-d-l stream)))
    (setf (ascent last-a-d-l) 0
          (descent last-a-d-l) 0
          (leading last-a-d-l) 0
          (maxwid last-a-d-l) 0))
  (with-focused-view stream
    (#_MoveTo (margin stream)  0))
  (setf (newline-pending? stream) t))    

(defun declare-stream-fonts (stream init-p &rest fonts)
  (declare (dynamic-extent fonts))
  (apply #'declare-stream-fonts-internal stream init-p nil fonts))

; All this rigamarole is to prevent consing
(defun declare-stream-fonts-internal (stream init-p font-codes &rest fonts)
  (declare (dynamic-extent fonts))
  (if (null fonts)
    (apply #'declare-stream-font-codes stream init-p (nreverse font-codes))
    (multiple-value-bind (ff ms ff-mask ms-mask) (font-codes (car fonts))
      (let* ((code-list (list ff ms ff-mask ms-mask))
             (new-font-codes (cons code-list font-codes)))
        (declare (dynamic-extent code-list new-font-codes))
        (apply #'declare-stream-fonts-internal
               stream init-p new-font-codes (cdr fonts))))))

(defun xfer-list (from to &key truncate-p null-fill-p)
  (let ((from from)
        (to to)
        f)
    (loop
      (unless (setf f (pop from)) (return))
      (setf (car to) f)
      (pop to))
    (when to
      (when truncate-p
        (setf (cdr to) nil))
      (when null-fill-p
        (loop (when (null to) (return))
              (setf (car to) nil)
              (pop to)))))
  to)

(defmethod declare-stream-font-codes ((stream font-size-manager) init-p &rest fonts)
  (declare (dynamic-extent fonts))
  (let ((fsm-font-codes (fsm-font-codes stream)))
    (if (and init-p (null (cddr fonts)))
      (if (and (equal (car fonts) (car fsm-font-codes))
               (equal (cadr fonts) (cadr fsm-font-codes)))
        (return-from declare-stream-font-codes nil)
        (progn
          (xfer-list (car fonts) (car fsm-font-codes) :null-fill-p t)
          (xfer-list (cadr fonts) (cadr fsm-font-codes) :null-fill-p t)))
      (setf (caar fsm-font-codes) nil
            (caadr fsm-font-codes) nil)))
  (call-next-method))

(defmethod declare-stream-font-codes ((stream stream) init-p &rest fonts)
  (multiple-value-bind (ff ms) (stream-font-codes stream)
    (let ((ascent 0)
          (descent 0)
          (leading 0)
          (maxwid 0))
      (declare (fixnum ascent descent leading maxwid))
      (unless init-p
        (let ((a-d-l (a-d-l stream)))
          (setq ascent (ascent a-d-l)
                descent (descent a-d-l)
                leading (leading a-d-l)
                maxwid (maxwid a-d-l))))
      (dolist (font fonts)
        (multiple-value-setq (ff ms) (apply #'merge-font-codes ff ms font))
        (multiple-value-bind (a d w l) (font-codes-info ff ms)
          (declare (fixnum a d w l))
          (if (> a ascent) (setq ascent a))
          (if (> d descent) (setq descent d))
          (if (> l leading) (setq leading l))
          (if (> w maxwid) (setq maxwid w))))
      (declare-stream-font-info stream ascent descent maxwid leading))))

(defmethod declare-stream-font-info ((stream stream)
                                     ascent descent maxwid leading)
  (declare (ignore ascent descent leading maxwid)))

(defmethod declare-stream-font-info ((stream font-size-manager)
                                     ascent descent maxwid leading)
  (let ((a-d-l (a-d-l stream)))
    (setf (ascent a-d-l) ascent
          (descent a-d-l) descent
          (leading a-d-l) leading
          (maxwid a-d-l) maxwid)))

; Pretty printer calls this
(defmethod stream-line-length ((stream font-size-manager))
  (let ((maxwid (maxwid (a-d-l stream))))
    (when (<= maxwid 0)
      (multiple-value-bind (ff ms) (view-font-codes (view-window stream))
        (multiple-value-bind (a d w) (font-codes-info ff ms)
          (declare (ignore a d))
          (setq maxwid w))))
    (values (floor (point-h (view-size stream)) maxwid))))

;;;;;
;;
;; The default inspector class
;; Used when we don't know what else to do
;;

(defclass basic-inspector (inspector) ())

(defmethod compute-line-count ((i basic-inspector))
  3)                                    ; type, class, value

(defun line-n-out-of-range (i n)
  (error "~s is not a valid index for line-n of ~s" n i))

(defun setf-line-n-out-of-range (i n)
  (error "~s is not a valid index for setf-line-n of ~s" n i))

(defmethod line-n ((i basic-inspector) n)
  (let ((object (inspector-object i)))
    (case n
      (0 (values object nil :static))
      (1 (values (type-of object) "Type: " :static))
      (2 (values (class-of object) "Class: " :static))
      (t (line-n-out-of-range i n)))))

;;;;;;;
;;
;; Automate the object being the first line
;;
(defclass object-first-mixin () ())
(defclass object-first-inspector (object-first-mixin inspector) ())

(defmethod compute-line-count :around ((i object-first-mixin))
  (1+ (call-next-method)))

(defmethod line-n :around ((i object-first-mixin) n)
  (if (eql 0 n)
    (values (inspector-object i) nil)
    (call-next-method i (1- n))))

(defmethod (setf line-n) :around (value (i object-first-mixin) n)
  (if (eql n 0)
    (replace-object i value)
    (call-next-method value i (1- n))))

(defun replace-object (inspector new-object)
  (let* ((view (inspector-view inspector))
         (pane (and view (view-container view))))
    (when (typep pane 'inspector-pane)
      (install-new-inspector pane (make-inspector new-object)))))


; A mixin that displays the object, its type, and its class as the first three lines.
(defclass basics-first-mixin () ())

(defmethod compute-line-count :around ((i basics-first-mixin))
  (+ 3 (call-next-method)))

(defmethod line-n :around ((i basics-first-mixin) n)
  (let ((object (inspector-object i)))
    (case n
      (0 (values object nil))
      (1 (values (type-of object) "Type: " :static))
      (2 (values (class-of object) "Class: " :static))
      (t (call-next-method i (- n 3))))))

(defmethod (setf line-n) :around (new-value (i basics-first-mixin) n)
  (case n
    (0 (replace-object i new-value))
    ((1 2) (setf-line-n-out-of-range i n))
    (t (call-next-method new-value i (- n 3)))))

;;;;;;;
;;
;; usual-inspector
;; Objects that know how to inspect themselves but don't need any
;; special info other than the object can be a usual-inspector.
;; This class exists mostly to save consing a class for every type
;; of object in the world.
(defclass usual-inspector (inspector)
  ())
(defclass usual-object-first-inspector (object-first-mixin usual-inspector)
  ())
(defclass usual-basics-first-inspector (basics-first-mixin usual-inspector)
  ())

(defvar *inspector*)

(defmethod compute-line-count ((i usual-inspector))
  (let ((*inspector* i))
    (compute-line-count (inspector-object i))))

(defmethod line-n ((i usual-inspector) n)
  (let ((*inspector* i))
    (line-n (inspector-object i) n)))

(defmethod (setf line-n) (value (i usual-inspector) n)
  (let ((*inspector* i))
    (setf (line-n (inspector-object i) n) value)))

(defmethod inspector-commands ((i usual-inspector))
  (let ((*inspector* i))
    (inspector-commands (inspector-object i))))

(defmethod inspector-commands (random)
  (declare (ignore random))
  nil)

;;;;;;;
;;
;; Bogus objects
;;

(defclass bogus-object-inspector (object-first-inspector)
  ())

(defmethod compute-line-count ((i bogus-object-inspector))
  3)

(defmethod line-n ((i bogus-object-inspector) n)
  (values
   nil
   (case n
     (0 "One cause of a bogus object is when a stack consed object is stored")
     (1 "in a register and then control exits the dynamic-extent of the object.")
     (2 "The compiler doesn't bother to clear the register since it won't be used again."))
   '(:comment :plain :plain)))

(defmethod inspector-class :around (object)
  (if (ccl::bogus-thing-p object)
    'bogus-object-inspector
    (call-next-method)))

;;;;;;;
;;
;; A general sequence inspector
;;
(defclass sequence-inspector (inspector)
  ((print-function :initarg :print-function :initform #'prin1 :reader print-function)
   (window-title :initarg :window-title :initform nil :reader window-title)
   (commands :initarg :commands :initform nil :accessor inspector-commands)
   (line-n-inspector :initform nil :initarg :line-n-inspector
                     :accessor line-n-inspector-function)
   (replace-object-p :initform nil :initarg :replace-object-p
                     :reader replace-object-p)
   (resample-function :initform nil :initarg :resample-function
                      :reader resample-function)
   (line-n-function :initform nil :initarg :line-n-function
                    :reader line-n-function)
   (setf-line-n-p :initform t :initarg :setf-line-n-p
                  :reader setf-line-n-p))
  (:default-initargs :update-line-count t))


(defmethod inspector-window-title ((i sequence-inspector))
  (or (window-title i) (call-next-method)))

(defmethod compute-line-count ((i sequence-inspector))
  (let ((resample-function (resample-function i)))
    (when resample-function
      (setf (inspector-object i) (funcall resample-function i))))
  (length (inspector-object i)))

(defmethod line-n ((i sequence-inspector) n)
  (let ((f (line-n-function i)))
    (if f
      (funcall f i n)
      (values (elt (inspector-object i) n) nil (unless (setf-line-n-p i) :static)))))

(defmethod (setf line-n) (new-value (i sequence-inspector) n)
  (if (setf-line-n-p i)
    (setf (elt (inspector-object i) n) new-value)
    (setf-line-n-out-of-range i n)))

(defmethod prin1-value ((inspector sequence-inspector) stream value
                        &optional label type)
  (declare (ignore label type))
  (funcall (print-function inspector) value stream))

(defmethod line-n-inspector ((i sequence-inspector) n value label type)
  (let ((f (line-n-inspector-function i)))
    (or (and f (funcall f i n value label type)) (call-next-method))))

;;;;;;;
;;
;; standard-object
;; This should be redone to use the exported class query functions
;; (as soon as they exist)
;;
(defclass standard-object-inspector (object-first-inspector)
  ((forwarded-p :initform nil :accessor forwarded-p)))

(defmethod inspector-class ((o standard-object))
  'standard-object-inspector)

(defmethod compute-line-count ((i standard-object-inspector))
  (standard-object-compute-line-count i))

(defun standard-object-compute-line-count (i)  
  (let* ((object (ccl::maybe-update-obsolete-instance (inspector-object i)))
         (class (class-of object)))
    (multiple-value-bind (instance-slots class-slots) (ccl::extract-instance-and-class-slotds (ccl::class-slots class))
      (let* ((ninstance-slots (length instance-slots))
             (nclass-slots (length class-slots)))
        (+ 2                                ; class, wrapper
           (if (eql 0 ninstance-slots)
             0
             (1+ ninstance-slots))
           (if (eql 0 nclass-slots)
             0
             (1+ nclass-slots))
           (if (eql 0 (+ nclass-slots ninstance-slots))
             1
             0))))))



(defun slot-value-or-unbound (instance slot-name)
  (eliminate-unbound (ccl::slot-value-if-bound instance slot-name
					       (ccl::%slot-unbound-marker))))

(defparameter *standard-object-type* (list nil))
(defparameter *standard-object-static-type*
  (cons :static (cdr *standard-object-type*)))
(defparameter *standard-object-comment-type* 
  (list :comment))

(defmethod line-n ((i standard-object-inspector) n)
  (standard-object-line-n i n))

(defmethod prin1-label ((i standard-object-inspector) stream value &optional label type)
  (declare (ignore value type))
  (if (symbolp label)
    (prin1 label stream)
    (call-next-method)))

; Looks like
; Class:
; Wrapper:
; [Forwarded to:]
; [Instance slots:
;  slots...]
; [Class slots:
;  slots...]
(defun standard-object-line-n (i n)
  (let* ((instance (inspector-object i))
         (class (class-of instance))
         (wrapper (ccl::instance.class-wrapper instance))
	 (instance-start 2))
    (if (< n instance-start)
      (if (eql n 0)
	(values class "Class: " :normal)
	(values wrapper "Wrapper: " :static))
      (let* ((slotds (ccl::extract-instance-effective-slotds class))
             (instance-count (length slotds))
             (shared-start (+ instance-start instance-count
                              (if (eql 0 instance-count) 0 1))))
        (if (< n shared-start)
          (if (eql n instance-start)
            (values nil "Instance slots" :comment)
            (let ((slot-name (slot-definition-name
                              (elt slotds (- n instance-start 1)))))
              (values (slot-value-or-unbound instance slot-name)
                      slot-name
                      :colon)))
          (let* ((slotds (ccl::extract-class-effective-slotds class))
                 (shared-count (length slotds))
                 (shared-end (+ shared-start shared-count
                                (if (eql shared-count 0) 0 1))))
            (if (< n shared-end)
              (if (eql n shared-start)
                (values nil "Class slots" :comment)
                (let ((slot-name (slot-definition-name 
                                  (elt slotds (- n shared-start 1)))))
                  (values (slot-value-or-unbound instance slot-name)
                           slot-name
                           :colon)))
              (if (and (eql 0 instance-count) (eql 0 shared-count) (eql n shared-end))
                (values nil "No Slots" :comment)
                ;(line-n-out-of-range i n)
                (values nil (format nil "Confused re class ~s Try Resample" class) :comment)))))))))

(defmethod (setf line-n) (value (i standard-object-inspector) n)
  (standard-object-setf-line-n value i n))

(defun standard-object-setf-line-n (value i n)
  (let* ((instance (inspector-object i))
         (class (class-of instance))
         (forwarded-p (forwarded-p i))
         (instance-start (if forwarded-p 3 2)))
    (if (< n instance-start)
      (cond
       ((eql n 0) (change-class instance value)
         (update-line-count i))
        (t (setf-line-n-out-of-range i n)))
      (let* ((slotds (ccl::extract-instance-effective-slotds class))
             (instance-count (length slotds))
             (shared-start (+ instance-start instance-count
                              (if (eql 0 instance-count) 0 1))))
        (if (< n shared-start)
          (if (eql n instance-start)
            (setf-line-n-out-of-range i n)
            (let ((slot-name (slot-definition-name
                              (elt slotds (- n instance-start 1)))))
              (setf (slot-value instance slot-name) (restore-unbound value))))
          (let* ((slotds (ccl::extract-class-effective-slotds class))
                 (shared-count (length slotds))
                 (shared-end (+ shared-start shared-count
                                (if (eql shared-count 0) 0 1))))
            (if (< n shared-end)
              (if (eql n shared-start)
                (setf-line-n-out-of-range i n)
                (let ((slot-name (slot-definition-name 
                                  (elt slotds (- n shared-start 1)))))
                  (setf (slot-value instance slot-name)
                        (restore-unbound value))))
              (setf-line-n-out-of-range i n))))))))


#|
(defclass test-window (font-size-manager window)
  ()
  (:default-initargs :page-truncation-tag :end-of-page
                     :line-truncation-tag :end-of-line
                     :margin 3))

(defmethod describe-object :around (object (stream test-window))
  (declare (ignore object))
  (catch (page-truncation-tag stream)
    (call-next-method)))

(defmethod prin1-line :around (inspector (stream test-window) value &optional
                                         label type function)
  (declare (ignore inspector value label type function))
  (catch (line-truncation-tag stream)
    (call-next-method)))

|#

#|
	Change History (most recent last):
	2	12/29/94	akh	
|# ;(do not edit past this line!!)
