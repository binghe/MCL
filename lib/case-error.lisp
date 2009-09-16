; -*- Mode:Lisp; Package:CCL; -*-

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

#|
09/30/91 alice assert evals args
----------- 2.0b3
09/02/91 gb  assert conses conditions at run time.
08/23/91 alice assert deal with multiple-values and conditions
01/15/91 gb typecase, etypecase, ctypecase to level-2.  Fixed case-body by removing it.
01/14/91 gb move ecase, ccase to level-2.
01/14/91 bill fix case-body.
04/30/90 gb Please, God, let us do check-type mostly out-of-line .
12/28/89 gz no more catch-error.
6/22/88 jaj check-type doesn't eval second arg, returns nil
6/21/88 jaj catch :error -> catch-error
5/31/88 as  %error -> :error
5/12/88 jaj  check-type works with objects
1/26/88 cfry fixed case-body to check for > 1 T or OTHERWISE clause.

|#

(in-package "CCL")

;I wanted a read that would not error even when given a #<
; and also allow backspace and such.
(defun read-line-no-error (&optional (stream *standard-output*) &aux result)
  (ignore-errors
     (setq result (read-from-string (read-line stream) nil))
     (return-from read-line-no-error (values result t)))
  (values nil nil))



;;;; Assert & Check-Type

;;; Assert-Value-Prompt  --  Internal
;;;
;;;    Prompt for a new value to set a place to.   We do a read-line,
;;; and if there is anything there, we eval it and return the second
;;; value true, otherwise it is false.
;;;
(defun assertion-value-prompt (place)
  (let* ((nvals (length (nth-value 2 (get-setf-method-multiple-value place))))
         (vals nil))
    (dotimes (i nvals)
      (if (eq nvals 1)
        (format *query-io* "Value for ~S: " place)
        (format *query-io* "Value ~D for ~S: " i place))
      (let* ((line (read-line *query-io*))
             (object  (read-from-string line nil *eof-value*)))
        (if (eq object *eof-value*)
            (return)
            (push (eval object) vals))))
    (values (nreverse vals) (not (null vals)))))

(defun %assertion-failure (setf-places-p test-form string &rest condition-args)
  (cerror 
   (if setf-places-p 
     "allow some places to be set and test the assertion again."
     "test the assertion again.")
   (cond
    ((stringp string)
     (make-condition 'simple-error
                     :format-string string
                     :format-arguments  condition-args))
    ((null string)
     (make-condition 'simple-error
                     :format-string "Failed assertion: ~S"
                     :format-arguments (list test-form)))
    ((typep string 'condition)
     (when  condition-args (error "No args ~S allowed with a condition ~S"  condition-args string))
     string)
    (t (apply #'make-condition string  condition-args)))))

(defmacro assert (test-form &optional (places ()) string &rest args)
  "ASSERT Test-Form [(Place*) [String Arg*]]
  If the Test-Form is not true, then signal a correctable error.  If Places
  are specified, then new values are prompted for when the error is proceeded.
  String and Args are the format string and args to the error call."
  (let* ((TOP (gensym))
         (setf-places-p (not (null places))))
    `(tagbody
       ,TOP
       (unless ,test-form
         (%assertion-failure ,setf-places-p ',test-form ,string ,@args)
         ,@(if places
             `((write-line "Type expressions to set places to, or nothing to leave them alone."
                           *query-io*)
               ,@(mapcar #'(lambda (place &aux (new-val (gensym))
                                          (set-p (gensym)))
                             `(multiple-value-bind
                                (,new-val ,set-p)
                                (assertion-value-prompt ',place)
                                (when ,set-p (setf ,place (values-list ,new-val)))))
                         places)))
         (go ,TOP)))))


(defmacro check-type (place typespec &optional string)
  "CHECK-TYPE Place Typespec [String]
  Signal a correctable error if Place does not hold an object of the type
  specified by Typespec."
  `(progn
     (setf ,place 
           (ensure-value-of-type 
            ,place 
            ',typespec 
            ',place 
            ,(if string string (list 'quote typespec))))
     nil))
