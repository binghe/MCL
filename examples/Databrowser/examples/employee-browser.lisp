;; Copyright (2004) Sandia Corporation. Under the terms of Contract DE-AC04-94AL85000 with
;; Sandia Corporation, the U.S. Government retains certain rights in this software.

;; This software is governed by the terms
;; of the Lisp Lesser GNU Public License
;; (http://opensource.franz.com/preamble.html),
;; known as the LLGPL.

;; This software is available at
;; http://aisl.sandia.gov/source/

;;; employee-browser.lisp

; This is an example of having editable stuff in a databrowser widget.
; This uses the high-level API and should be emulated in real programs.

(in-package :cl-user)

(require :databrowser)
(require :autosize)

(defparameter *employee-data* #( ("Sam Smith"  45 "800-555-1234" t)
                                 ("Jane Jones" 36 "800-555-2345" nil)
                                 ("Fred Apple" 24 "800-555-3456" t)
                                 ("Sue Miller" 51 "800-555-4567" t)))

(defun set-name (value employee-record)
  (setf (first employee-record) value))

(defun set-age (new-age employee-record)
  "New-age comes in as a string, therefore we have to parse it to get it back into numeric form.
   Keeping it numeric ensures that sorting on this column works intuitively."
  (let ((good-age (ignore-errors (read-from-string new-age nil nil))))
    (if (and good-age (numberp good-age))
      (setf (second employee-record) good-age)
      ; Otherwise, we simply don't store the new value anywhere.
      )))

(defun set-phone (value employee-record)
  (setf (third employee-record) value))

(defun set-training (value employee-record)
  (setf (fourth employee-record) value))

(defun employee-browser (&optional (initial-allow-edits nil))
  (let* ((w (make-instance 'color-dialog
              :window-type :document-with-grow
              :window-title "Employee Records"
              :VIEW-SIZE #@(536 355)))
         (databrowser (MAKE-INSTANCE 'brw:collection-databrowser
                        :column-descriptors #((first ; could have said car here
                                               :title "Name" :justification :left :editable t
                                                     :setter set-name
                                                     ; NOTE: since (setf car) is not a function,
                                                     ;       we have to explicitly specify setters here
                                                     )
                                              (second :title "Age" :editable t :setter set-age
                                                      :maxwidth 100)
                                              (third :title "Phone" :editable t
                                                     :minwidth 120
                                                     :setter set-phone)
                                              (fourth :title "Training Done?" :property-type :checkbox
                                                      :editable t 
                                                      :minwidth 110
                                                      :setter set-training))
                        :triangle-space t ; no twist-downs this demo but leave space anyway
                        :view-nick-name 'employee-browser-view
                        :VIEW-SIZE #@(460 224)
                        :VIEW-POSITION #@(40 58)
                        :view-font '("Hoefler Text" 12 :srcor :plain)
                        :draggable-columns t
                        :view-container w)))
    (MAKE-DIALOG-ITEM 'ccl::CHECK-BOX-DIALOG-ITEM-AR #@(41 298) #@(112 20) "Allow edits"
                      #'(lambda (view) (setf (brw:databrowser-allow-edits databrowser) (check-box-checked-p view)))
                      :VIEW-NICK-NAME 'ALLOW-EDITS-BUTTON
                      :check-box-checked-p initial-allow-edits
                      :view-container w)

    (setf (brw:databrowser-allow-edits databrowser) initial-allow-edits) ; so the after method will run

    #| Unnecessary
     (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM #@(401 298) #@(72 20) "Refresh"
                      #'(lambda (view) (declare (ignore view)) (brw:databrowser-update databrowser nil))
                      :VIEW-NICK-NAME 'REFRESH-BUTTON
                      :DEFAULT-BUTTON NIL
                      :view-container w)
    |#
    (brw:databrowser-add-items databrowser *employee-data*)
    databrowser
    ))

(employee-browser nil)

; Notice that if you run (employee-browser nil) a second time, your changes will still be there,
;   unless you reevaluate the defparameter for *employee-data* above.

; Also notice that if you click the Name column, the employee names sort by first name, which
;   is usually the wrong thing. The example below shows how to fix that.

#|
; Below is a slightly modified version of the above that causes employee names to sort
;   properly by last name only. It uses :more-function-parameters to accomplish this.

(defun smarter-employee-name (item comparing-p browser rowID)
  "Just return the last name if comparing-p is true. This could be made much more complicated
   by doing a secondary sort on first name if two last names were equal. Of course, in 
   a real application you'd probably create records with separate fields for family name
   and given name. This is just an example after all."
  (declare (ignore browser rowID))
  (if comparing-p
    (let ((pos (position #\space (first item) :from-end t :test #'char=))) ; get just the last name
      (if (integerp pos)
        (subseq (first item) (1+ pos))
        (first item)))
    (first item)))

(defun employee-browser (&optional (initial-allow-edits nil))
  (let* ((w (make-instance 'color-dialog
              :window-type :document-with-grow
              :window-title "Employee Records"
              :VIEW-SIZE #@(536 355)))
         (databrowser (MAKE-INSTANCE 'brw:collection-databrowser


;;; only the next two lines are different
                        :column-descriptors #((smarter-employee-name
                                               :more-function-parameters t


                                               :title "Name" :justification :left :editable t
                                                     :setter set-name
                                                     ; NOTE: since (setf car) is not a function,
                                                     ;       we have to explicitly specify setters here
                                                     )
                                              (second :title "Age" :editable t :setter set-age
                                                      :maxwidth 100)
                                              (third :title "Phone" :editable t
                                                     :minwidth 120
                                                     :setter set-phone)
                                              (fourth :title "Training Done?" :property-type :checkbox
                                                      :editable t 
                                                      :minwidth 110
                                                      :setter set-training))
                        :triangle-space t ; no twist-downs this demo but leave space anyway
                        :view-nick-name 'employee-browser-view
                        :VIEW-SIZE #@(460 224)
                        :VIEW-POSITION #@(40 58)
                        :view-font '("Hoefler Text" 12 :srcor :plain)
                        :draggable-columns t
                        :view-container w)))
    (MAKE-DIALOG-ITEM 'ccl::CHECK-BOX-DIALOG-ITEM-AR #@(41 298) #@(112 20) "Allow edits"
                      #'(lambda (view) (setf (brw:databrowser-allow-edits databrowser) (check-box-checked-p view)))
                      :VIEW-NICK-NAME 'ALLOW-EDITS-BUTTON
                      :check-box-checked-p initial-allow-edits
                      :view-container w)

    (setf (brw:databrowser-allow-edits databrowser) initial-allow-edits) ; so the after method will run

    #| Unnecessary
     (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM #@(401 298) #@(72 20) "Refresh"
                      #'(lambda (view) (declare (ignore view)) (brw:databrowser-update databrowser nil))
                      :VIEW-NICK-NAME 'REFRESH-BUTTON
                      :DEFAULT-BUTTON NIL
                      :view-container w)
    |#
    (brw:databrowser-add-items databrowser *employee-data*)
    databrowser
    ))
|#