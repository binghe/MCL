;;;-*- Mode: Lisp; Package: CCL -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; q.lisp
;; A simple fifo queue. Why isn't this part of Common Lisp
;;
;; Copyright © 1996 Digitool, Inc.
;; Copyright © 1992-1995 Apple Computer, Inc.
;; All rights reserved.
;; Permission is given to use, copy, and modify this software provided
;; that Digitool is given credit in all derivative works.
;; This software is provided "as is". Digitool makes no warranty or
;; representation, either express or implied, with respect to this software,
;; its quality, accuracy, merchantability, or fitness for a particular
;; purpose.

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; -------------  0.96
;; 08/27/96 bill  Added copyright and mod history comments
;;

(in-package :ccl)

(export '(make-q enq deq q-empty-p))

(require "LISPEQU")                     ; %cons-pool, pool.data

(defstruct q
  start-buf
  start-index
  end-buf
  end-index)

(defmethod print-object ((q q) stream)
  (print-unreadable-object (q stream :type t :identity t)
    ))

(defconstant $q-buf-size 512)

(defvar *q-bufs* (%cons-pool))

(defun make-q-buf ()
  (without-interrupts
   (let ((buf (pool.data *q-bufs*)))
     (if buf
       (progn
         (setf (pool.data *q-bufs*) (svref buf 0))
         (dotimes (i $q-buf-size)
           (setf (svref buf i) nil))
         buf)
       (make-array $q-buf-size)))))

(defun free-q-buf (buf)
  (without-interrupts
   (setf (svref buf 0) (pool.data *q-bufs*)
         (pool.data *q-bufs*) buf)
   nil))

(defun enq (q elt)
  (setq q (require-type q 'q))
  (let ((buf (q-end-buf q))
        (index (q-end-index q)))
    (if (null buf)
      (setf buf (make-q-buf)
            (q-start-buf q) buf
            (q-start-index q) 1
            (q-end-buf q) buf
            (q-end-index q) (setq index 1))
      (when (>= index $q-buf-size)
        (setf (q-end-buf q)
              (setf buf
                    (setf (svref buf 0) (make-q-buf)))
              (q-end-index q) (setq index 1))))
    (setf (svref buf index) elt)
    (setf (q-end-index q) (1+ index)))
  elt)

(defun q-empty-p (q)
  (setq q (require-type q 'q))
  (let ((start-buf (q-start-buf q)))
    (or (null start-buf)
        (and (eq start-buf (q-end-buf q))
             (eql (q-start-index q)
                  (q-end-index q))))))

(defun deq (q &optional (error-if-empty t))
  (when (q-empty-p q)
    (if error-if-empty
      (error "Empty q: ~s" q)
      (return-from deq nil)))
  (let ((buf (q-start-buf q))
        (index (q-start-index q)))
    (prog1
      (svref buf index)
      (when (eql (incf index) $q-buf-size)
        (setq index 1)
        (unless (setf (q-start-buf q) (svref buf 0))
          (setf (q-end-buf q) nil))
        (free-q-buf buf))
      (setf (q-start-index q) index))))

(provide "Q")
;;;    1   3/10/94  bill         1.8d247
