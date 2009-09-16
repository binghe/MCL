;;;-*- Mode: Lisp; Package: cl-user
;;;
;;; example.lisp
;;;
;; Copyright © 1996 Digitool, Inc.
;; Copyright © 1992-1995 Apple Computer, Inc.
;; All rights reserved.
;; Permission is given to use, copy, and modify this software provided
;; that Digitool is given credit in all derivative works.
;; This software is provided "as is". Digitool makes no warranty or
;; representation, either express or implied, with respect to this software,
;; its quality, accuracy, merchantability, or fitness for a particular
;; purpose.

;;; Example file showing one way to save person records in a persistent heap.
;;; If your "Wood" directory is not accessible as "ccl:wood;", you
;;; will need to change the pathname in the (require "WOOD" ...) form below.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification history
;;;
;;; ------------- 0.96
;;; ------------- 0.95
;;; ------------- 0.94
;;; ------------- 0.93
;;; ------------- 0.9
;;; ------------- 0.8
;;; ------------- 0.6
;;; 12/09/92 bill "wood:" package prefix in commented out code.
;;; 09/14/92 bill move to CL-USER package. (require "WOOD" ...)
;;; 07/31/92 bill Matthew Cornell's typo fixes in the commented out code.
;;; ------------- 0.5
;;;

(in-package "CL-USER")

(eval-when (:compile-toplevel :execute :load-toplevel)
  (require "WOOD" "ccl:wood;wood"))

;; define the PERSON class
(defclass person ()
  ((first-name
    :initarg :first-name
    :accessor person-first-name)
   (last-name
    :initarg :last-name
    :accessor person-last-name)
   (age
    :initarg :age
    :accessor person-age)
   (sex
    :initarg :sex
    :accessor person-sex)
   (occupation
    :initarg :occupation
    :accessor person-occupation)
   (ss#
    :initarg :ss#
    :accessor person-ss#)))

(defmethod person-name ((self person))
  (concatenate 'string (person-first-name self) " " (person-last-name self)))

(defmethod print-object ((object person) stream)
  (print-unreadable-object (object stream :type t :identity t)
    (format stream "~a ~a, ~a"
            (person-first-name object)
            (person-last-name object)
            (person-occupation object))))

;; Create a persistent heap for storing indexed PERSON instances.
;; The root object is a three element list.
;; The first element identifies the file.
;; The second element is a btree mapping social security number to person.
;; The third element is a btree mapping last name to a list of people.
(defun create-person-file (&key (filename "People.wood")
                                (if-exists :error))
  (let ((pheap (wood:open-pheap filename 
                                :if-exists if-exists
                                :if-does-not-exist :create)))
    (setf (wood:root-object pheap)
          (wood:p-list
           pheap
           "People"                     ; Identify this file
           (wood:p-make-btree pheap)    ; ss# -> person
           (wood:p-make-btree pheap)    ; last-name -> (person ...)
           ))
    pheap))

; I wouldn't really look up the root for every access in a production system.
(defun person-pheap-tables (pheap)
  (let ((root (wood:p-load (wood:root-object pheap))))
    (unless (and (listp root)
               (eql 3 (length root))
               (equal "People" (first root))
               (wood:p-btree-p (second root))
               (wood:p-btree-p (third root)))
      (error "~s does not appear to be a person file" pheap))
    (values (second root) (third root))))

(defun store-person (pheap person)
  (setq person (require-type person 'person))
  (multiple-value-bind (ss#->person last-name->person-list)
                       (person-pheap-tables pheap)
    (let ((ss# (person-ss# person))
          (last-name (string-upcase (person-last-name person))))
      (unless (wood:p-btree-lookup ss#->person ss#)
        (setf (wood:p-btree-lookup ss#->person (person-ss# person)) person
              (wood:p-btree-lookup last-name->person-list last-name)
              (cons person
                    (wood:p-load
                     (wood:p-btree-lookup last-name->person-list last-name)))))))
  person)

(defun find-person-with-ss# (pheap ss#)
  (let ((ss#->person (person-pheap-tables pheap)))
    (wood:p-load (wood:p-btree-lookup ss#->person ss#))))

(defun find-people-with-last-name (pheap last-name)
  (multiple-value-bind (ss#->person last-name->person-list)
                       (person-pheap-tables pheap)
    (declare (ignore ss#->person))
    (wood:p-load
     (wood:p-btree-lookup last-name->person-list (string-upcase last-name)))))

(defun print-people-by-ss# (pheap)
  (let ((ss#->person (person-pheap-tables pheap)))
    (wood:p-map-btree ss#->person
                      #'(lambda (ss# person)
                          (format t "~&~a ~s~%" ss# (wood:p-load person))))))

(defun print-people-by-last-name (pheap)
  (multiple-value-bind (ss#->person last-name->person-list)
                       (person-pheap-tables pheap)
    (declare (ignore ss#->person))
    (wood:p-map-btree last-name->person-list
                      #'(lambda (last-name person-list)
                          (declare (ignore last-name))
                          (setq person-list
                                (sort (mapcar 'wood:p-load
                                              (wood:p-load person-list))
                                      #'string<
                                      :key 'person-first-name))
                          (dolist (person person-list)
                            (format t "~&~s~%" person))))))

;; Code for creating random PERSON instances.
(defparameter *first-names*
  '(("Alan" . M)
    ("Abraham" . M)
    ("Andrew" . M)
    ("Alice" . F)
    ("Susan" . F)
    ("Bob" . M)
    ("Hillary" . F)
    ("Joe" . M)
    ("Bill" . M)
    ("Matthew" . M)
    ("Gail" . F)
    ("Gary" . M)
    ("Doug" . M)
    ("Christie" . F)
    ("Steve" . M)
    ("Elizabeth" . F)
    ("Melissa" . F)
    ("Karla" . F)
    ("Dan" . M)
    ("Irving" . M)))

(defparameter *last-names*
  '("Smith" "Jones" "Peterson" "Williams" "Kennedy" "Johnson"
    "Riley" "Sylversteen" "Wilson" "Cranshaw" "Ryan" "O'Neil"
    "McAllister"))

(defparameter *occupations*
  '("Butcher" "Baker" "Candlestick Maker"
    "Engineer" "Hacker" "Tailor" "Cop" "Lawyer" "Doctor"
    "Dentist" "Politician" "Cashier" "Insurance Sales"
    "Advertising"))

(defun random-person ()
  (multiple-value-bind (first-name last-name sex) (random-name)
    (make-instance 'person
      :first-name first-name
      :last-name last-name
      :sex sex
      :age (random 100)
      :occupation (random-element *occupations*)
      :ss# (random-ss#))))

(defun random-element (sequence)
  (elt sequence (random (length sequence))))
    
(defun random-name ()
  (let ((first.sex (random-element *first-names*))
        (last (random-element *last-names*)))
    (values
     (car first.sex) 
     last
     (cdr first.sex))))

(defvar *ss#s* (make-hash-table :test 'equal))

(defun random-ss# ()
  (with-standard-io-syntax
    (loop
      (let ((ss# (write-to-string
                  (+ (expt 10 8) (random (- (expt 10 9) (expt 10 8)))))))
        (unless (gethash ss# *ss#s*)
          (return
           (setf (gethash ss# *ss#s*) ss#)))))))

(defun store-n-random-people (pheap n)
  (dotimes (i n)
    (store-person pheap (random-person))))

#|
(defparameter *p* (create-person-file :if-exists :supersede))
; or
(defparameter *p* (wood:open-pheap "People.wood"))

(store-n-random-people *p* 100)

(print-people-by-ss# *p*)

(print-people-by-last-name *p*)

(wood:close-pheap *p*)
|#
;;;    1   3/10/94  bill         1.8d247
;;;    2   3/23/95  bill         1.11d010
