; -*- Mode:Lisp; Package:CL-USER; -*-

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

(in-package :cl-user)
(defvar foo)
(defvar checking)
(defvar changing)

;;Checking is a simple editable-text-dialog-item
(setq Checking (make-instance 'editable-text-dialog-item
                 :dialog-item-text "Click here to check"
                 :view-position #@(16 16)))

;; changer-text-item is a new subclass
(defclass changer-text-item (editable-text-dialog-item) ()
  (:default-initargs :dialog-item-text 
                     "Change me and see what happens"))


;; changer-text-item has methods for enter-key-handler 
;; and exit-key-handler
(defmethod exit-key-handler ((changer-text-item changer-text-item) next-item)
  (declare (ignore next-item))
  (unless (equalp (dialog-item-text changer-text-item) 
                     "Change me and see what happens")
    (message-dialog "You changed me!"))
           t)

(defmethod enter-key-handler ((changer-text-item changer-text-item) old-text)
  (unless (equalp (dialog-item-text Checking)
                  "Click here to check")
    (set-current-key-handler 
       (view-window changer-text-item) old-text)))

(setq  foo (make-instance 'dialog))

(setq Changing (make-instance 'changer-text-item 
                 :view-position #@(10 100)
                 :draw-outline nil))

(add-subviews foo Checking Changing)
