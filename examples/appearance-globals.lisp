;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; appearance-globals.lisp
;;;
;;; GLOBAL VARIABLES AND CONSTANTS FOR THE APPEARANCE-MANAGER MODULE
;;;
;;; Copyright ©1998-1999
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

(in-package :ccl)

;;;----------------------------------------------------------------------
;;; Constants

;;
;; Colors
;;

(defconstant +hilight-color+ *white-color*)
(defconstant +light-background-color+ (make-color 61423 61423 61423))
(defconstant +background-color+ (make-color 57054 57054 57054))
(defconstant +dark-background-color+ (make-color 48573 48573 48573))
(defconstant +light-shadow-color+ (make-color 44461 44461 44461))
(defconstant +shadow-color+ (make-color 33924 33924 33924))
(defconstant +dark-shadow-color+ (make-color 29555 29555 29555))
(defconstant +very-dark-shadow-color+ (make-color 21074 21074 21074))

;;
;; Font code masks
;;

(defconstant +font-only-ff-mask+ #xFFFF0000)
(defconstant +face-only-ff-mask+ #x0000FF00)
(defconstant +color-only-ff-mask+ #x000000FF)

(defconstant +mode-only-ms-mask+ #xFFFF0000)
(defconstant +size-only-ms-mask+ #x0000FFFF)

;;
;; Tab bar
;;

(defconstant +initial-tab-h+ 5)
(defconstant +default-tab-side-width+ 10)
(defconstant +default-tab-width-correction+ 16)

;;
;; Resource ids
;;

(defconstant +disclosure-triangle-up-id+ 512)
(defconstant +disclosure-triangle-down-id+ 513)

;;;----------------------------------------------------------------------
;;; Globals

(let ((*warn-if-redefine* nil))
  (defvar *appearance-available-p* nil)
  )

(defvar *appearance-compatibility-mode-p* t)

(defvar *draw-inactive-dialog-items-as-disabled* t
  "If this variable is non-nil, inactive dialog-items will be drawn
like disabled menus, to go along with Apple's grayscale appearance.")

;;;----------------------------------------------------------------------

(provide :appearance-globals)