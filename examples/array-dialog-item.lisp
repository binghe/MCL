;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 5/1/95   akh  copyright
;;  (do not edit before this line!!)


;;;;;;;;;;;;;
;;
;; array-dialog-item.lisp
;; Copyright 1991-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;; Example of making a special purpose table-dialog-item.
;;

;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 12/23/91 bill export set-xxx
;; 11/22/91 bill (setf (table-subscript ...) ...) -> (setf (table-subscript-slot ...) ...)
;; 11/06/91 bill translated from ObjectLisp
;;

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(array-dialog-item table-array h-specifier v-specifier table-subscript
            set-table-array set-h-specifier set-v-specifier set-table-subscript)))

(defclass array-dialog-item (table-dialog-item)
  ((array :reader table-array :writer (setf table-array-slot))
   (dimensions :accessor table-array-dimensions)
   (h-specifier :reader h-specifier :writer (setf h-specifier-slot))
   (v-specifier :reader v-specifier :writer (setf v-specifier-slot))
   (table-subscript :reader table-subscript :writer (setf table-subscript-slot))))

(defmethod initialize-instance ((item array-dialog-item) &rest rest &key
                                (table-array #2a((0 0)(0 0)))
                                (h-specifier 0)
                                (v-specifier 1)
                                table-subscript table-dimensions)
  (declare (dynamic-extent rest))
  (let ((array-dimensions (array-dimensions table-array)))
    (if (< (length array-dimensions) 2)
      (error "Arrays for array-dialog-items must have two or more dimensions.
Passed array is: ~s. Use sequence-dialog-items for vectors." table-array))
    (if table-subscript
      (unless (eql (length table-subscript) (length array-dimensions))
        (error "table-subscript is the wrong length."))
      (setq table-subscript
            (make-list (length array-dimensions) :initial-element 0)))
    (setq table-dimensions
          (if table-dimensions
            (require-type table-dimensions 'integer)
            (make-point (elt array-dimensions h-specifier)
                        (elt array-dimensions v-specifier))))
    (setf (table-array-slot item) table-array
          (table-array-dimensions item) array-dimensions
          (h-specifier-slot item) h-specifier
          (v-specifier-slot item) v-specifier
          (table-subscript-slot item) table-subscript)
    (apply #'call-next-method
           item
           :table-dimensions table-dimensions
           rest)))

(defmethod cell-to-subscript ((item array-dialog-item) point)
  (let ((table-subscript (table-subscript item)))
    (setf (elt table-subscript (h-specifier item)) (point-h point))
    (setf (elt table-subscript (v-specifier item)) (point-v point))
    (if (apply #'array-in-bounds-p (table-array item) table-subscript)
      table-subscript)))

(defmethod subscript-to-cell ((item array-dialog-item) subscript)
  (let ((table-subscript (table-subscript item))
        (h-specifier (h-specifier item))
        (v-specifier (v-specifier item)))
    (if (eq (length subscript) (length table-subscript))
      (progn
        (setf (elt table-subscript (h-specifier item)) (elt subscript h-specifier))
        (setf (elt table-subscript (v-specifier item)) (elt subscript v-specifier))
        (if (equal subscript table-subscript)
          (make-point (elt subscript h-specifier) (elt subscript v-specifier)))))))

(defmethod cell-contents ((item array-dialog-item) h &optional v &aux subscript)
  (if (setq subscript (cell-to-subscript item (make-point h v)))
      (apply #'aref (table-array item) subscript)
      ""))

(defun readjust-table-dimensions (item)
  (let ((array-dimensions (array-dimensions (table-array item))))
    (set-table-dimensions item
                          (elt array-dimensions (h-specifier item))
                          (elt array-dimensions (v-specifier item)))))

(defmethod set-h-specifier ((item array-dialog-item) dimension)
  (setf (h-specifier-slot item) dimension)
  (readjust-table-dimensions item)
  dimension)

(defmethod set-v-specifier ((item array-dialog-item) dimension)
  (setf (v-specifier-slot item) dimension)
  (readjust-table-dimensions item)
  dimension)

(defmethod set-table-array ((item array-dialog-item) new-array)
  (let ((array-dimensions (array-dimensions new-array)))
    (if (< (length array-dimensions) 2)
      (error "Arrays for array-dialog-items must have two or more dimensions.
Passed array is: ~s. Use sequence-dialog-items for vectors." new-array))
    (setf (table-array-dimensions item) array-dimensions)
    (setf (table-array-slot item) new-array)
    (setf (h-specifier-slot item) 0)
    (setf (v-specifier-slot item) 1)
    (setf (table-subscript-slot item)
          (make-sequence 'list (length array-dimensions) :initial-element 0))
    (readjust-table-dimensions item)
    new-array))

(defmethod set-table-subscript ((item array-dialog-item) new-subscript)
  (if (apply #'array-in-bounds-p (table-array item) new-subscript)
    (progn
      (setf (table-subscript-slot item) new-subscript)
      (readjust-table-dimensions item)
      new-subscript)
    (error "Subscript ~s Out of bounds" new-subscript)))

#|

(defun make-test-array (&rest dimensions)
  (let* ((a (make-array dimensions))
         (dims (make-list (length dimensions) :initial-element 0)))
    (loop
      (setf (apply #'aref a dims) (copy-list dims))
      (do ((ds dims (cdr ds))
           (lims dimensions (cdr lims)))
          ((null ds) (return-from make-test-array a))
        (if (>= (incf (car ds)) (car lims))
          (setf (car ds) 0)
          (return))))))

(defun array-dialog-item-example (&rest dimensions)
  (let* ((a (apply #'make-test-array dimensions))
         (w (make-instance 'window :view-size #@(400 300))))
    (make-instance 'array-dialog-item
      :table-array a
      :table-hscrollp t
      :table-vscrollp t
      :view-container w)))

(array-dialog-item-example 20 20)

|#