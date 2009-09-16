;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; chasing-arrows-dialog-item.lisp
;;;
;;; CHASING ARROWS CONTROL
;;;
;;; Copyright ©1997-1999
;;; Supportive Inquiry Based Learning Environments Project
;;; Learning Sciences Program
;;; School of Education & Social Policy
;;; Northwestern University
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice is included intact.
;;;
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Eric Russell <eric-r@nwu.edu>
;;;

;;; fix for being contained in subview - from Terje N.
;;; fix moved to class new-control-dialog-item

(in-package :ccl)

(export '(chasing-arrows-dialog-item))

;;;----------------------------------------------------------------------
;;; Requirements

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :new-control-dialog-item "ccl:examples;appearance-manager-folder;new-control-dialog-item"))

;;;----------------------------------------------------------------------
;;; The class

(defclass chasing-arrows-dialog-item (new-control-dialog-item)
  ((procid :initarg :procid :initform #$kControlChasingArrowsProc :allocation :class)))

;;;----------------------------------------------------------------------
;;; Method

(defmethod view-default-size ((item chasing-arrows-dialog-item))
  (if (installed-item-p item)
    (call-next-method)
    #@(16 16)))


;;;----------------------------------------------------------------------

(provide :chasing-arrows-dialog-item)