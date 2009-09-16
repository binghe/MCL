;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; query-replace.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;; c-m-r is query-replace, (or  meta-% ?)
;; m-r is replace-string
;; Both behave very much like the EMACS versions.
;; Type "?" during query-replace for documentation.

; 04/21/93 bill  update for new fred windows
;--------------  2.1d4
;--------------  2.0
; 03/10/92 bill  don't (require 'fred-misc)
; -------------  2.0f3
; 08/27/91 bill  qr-search had the wrong sense for it's comparison
; 07/29/91 alice replace-rest goes from cursor position to end & is a single command for undo
;		One at a time replacements are separate commands
; 04/22/91 alice get both strings in one dialog ala search, use "undo aware" functions 
;          window-replace and window-replace-all.


(in-package :ccl)

(defparameter *qr-comtab*
  (let ((comtab (make-comtab 'qr-bad-key)))
    (comtab-set-key comtab #\space 'qr-replace/search)
    (comtab-set-key comtab #\y 'qr-replace/search)
    (comtab-set-key comtab #\Y 'qr-replace/search)
    (comtab-set-key comtab #\delete 'qr-search)
    (comtab-set-key comtab #\backspace 'qr-search)
    (comtab-set-key comtab #\n 'qr-search)
    (comtab-set-key comtab #\N 'qr-search)
    (comtab-set-key comtab #\^ 'qr-search-bwd)
    (comtab-set-key comtab #\. 'qr-replace-and-quit)
    (comtab-set-key comtab #\, 'qr-replace)
    (comtab-set-key comtab #\! 'qr-replace-rest)
    (comtab-set-key comtab '(:control #\g) #'(lambda (w) (ed-beep) (qr-quit w)))
    (comtab-set-key comtab #\q 'qr-quit)
    (comtab-set-key comtab #\Q 'qr-quit)
    comtab))

(defvar *qr-search-string* "")
(defvar *qr-replace-string* "")
(defvar *qr-search-dialog* nil)
(defvar *qr-search-dialog-pos* '(:bottom 130))
(defvar *qr-query-p*)

(defclass qr-search-dialog (dialog) ())


(defmethod window-close :before ((w qr-search-dialog))
  (setq *search-default* (dialog-item-text (view-named 'search-text-item w))
        *replace-default* (dialog-item-text (view-named 'replace-text-item w))
        *qr-search-dialog-pos* (view-position w)
        *qr-search-dialog* nil))

(defmethod view-activate-event-handler :after ((w qr-search-dialog))
  (let ((text (view-named 'search-text-item w)))
    (set-current-key-handler w text)
    (set-selection-range text 0 32000)))

(defun query-replace (w)
  (declare (ignore w))
  (setq *qr-query-p* t)
  (qr-window-dialog t))

#|
(defun get-replace-strings (&optional (msg-prefix "Query replace"))
  (setq *qr-search-string* (get-string-from-user
                            (concatenate 'string msg-prefix ":")
                            :initial-string *qr-search-string*))
  (setq *qr-replace-string* (get-string-from-user
                             (concatenate 'string 
                                          msg-prefix
                                          " \""
                                          *qr-search-string*
                                          "\" with:")
                             :initial-string *qr-replace-string*)))
|#


(defun get-qr-strings (dialog &optional (w (window-key-handler (target))))
  (setq *qr-search-string* (dialog-item-text (view-named 'search-text-item dialog)))
  (setq *qr-replace-string* (dialog-item-text (view-named 'replace-text-item dialog)))
  (let ((window (view-window w)))
    (if *qr-query-p*
      (progn
        (install-shadowing-comtab w *qr-comtab* nil)
        (window-select window)
        (qr-search w))
      (progn
        (window-top w)
        (window-select window)
        (qr-replace-rest w)))))
    

(defun qr-search (w &optional silent-p)
  (unless (window-search w *qr-search-string* nil silent-p)
      (progn (qr-quit w) nil)))  

(defun qr-search-bwd (w)
  (window-search w *qr-search-string* t))

(defun qr-quit (w)
  (collapse-selection w t)
  (let ((from *qr-search-string*)
        (to *i-search-search-string*))
    ; Copy *qr-search-string* to *i-search-search-string*
    (setf (fill-pointer to) 0)
    (dovector (char from)
      (vector-push-extend char to)))
  (remove-shadowing-comtab w "Done.")
  (window-close *qr-search-dialog*))

(defun qr-replace (w)
  (multiple-value-bind (b e) (selection-range w)
    (unless (eq b e)
      (window-replace w *qr-replace-string*)      
      t)))

(defun qr-replace/search (w)
  (qr-replace w)
  (or (window-search w *qr-search-string*)
      (progn (qr-quit w) nil)))

(defun qr-replace-and-quit (w)
  (qr-replace w)
  (qr-quit w))

(defun qr-replace-rest (w)
  (let ((buf (fred-buffer w)))
    (multiple-value-bind (b e)(selection-range w)
      (set-mark buf (min b e))
      (window-replace-all w *qr-search-string* *qr-replace-string*)
      (qr-quit w))))

(defun qr-bad-key (w)
  (declare (ignore w))
  (message-dialog
"Type Space or \"y\" to replace and search,
Delete or \"n\" to skip replace,
Period to replace one match and exit,
Comma to replace but not search,
\"!\" to replace all remaining matches,
\"^\" to search backwards,
\"q\" or ^G to exit."
:size #@(370 150)))

#|
; make this work too
(defun replace-string (w)
  (get-replace-strings "Replace string")
  (let ((display-mark (make-mark (fred-display-start-mark w)))
        (pos-mark (make-mark (fred-buffer w)))
        (count 0))
    (while (qr-search w t)
      (qr-replace w)
      (incf count))
    (set-mark (fred-display-start-mark w) display-mark)
    (set-mark (fred-buffer w) pos-mark)
    (set-mini-buffer w "~d replacements." count)))
|#

(defun replace-string (w)
  (declare (ignore w))
   (setq *qr-query-p* nil)
   (qr-window-dialog))

(def-fred-command (:control :meta #\r) query-replace)
(def-fred-command (:meta #\r) replace-string)


(defun qr-window-dialog (&optional query (w (window-key-handler (front-window))))
  (unless *qr-search-dialog*
    (setq *qr-search-dialog*
          (make-instance 'qr-search-dialog
                         ;:window-title (if query "Query Replace" "Replace")
                         :view-position *qr-search-dialog-pos*
                         :view-size #@(362 85)
                         :window-show nil))
    (add-subviews
     *qr-search-dialog*
     (make-dialog-item 'default-button-dialog-item
                       #@(10 55) #@(55 16) "OK"
                       #'(lambda (item)
                           (get-qr-strings (view-container item) w)))
     (make-dialog-item 'static-text-dialog-item
                       #@(10 7) #@(94 16) "Search For")
     (make-dialog-item 'editable-text-dialog-item
                       #@(107 7) #@(247 16) *search-default* nil
                       :view-nick-name 'search-text-item)
     (make-dialog-item 'static-text-dialog-item
                       #@(10 30) #@(94 16)  "Replace With")
     (make-dialog-item 'editable-text-dialog-item
                       #@(107 30) #@(247 16) *replace-default* nil
                       :view-nick-name 'replace-text-item)))
  (set-window-title *qr-search-dialog* (if query "Query Replace" "Replace"))
  (window-select *qr-search-dialog*))
