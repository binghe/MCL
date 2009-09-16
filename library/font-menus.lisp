    ;;-*- Mode: Lisp; Package: CCL -*-

;; Change History (most recent first):
;;  4 8/25/97  akh  dunno
;;  3 7/4/97   akh  add-font-menus brain death
;;  6 1/22/97  akh  add-font-menus updates the items to get check-mark in new item.
;;                  menu-update does call-next-method iff enabled and not same items
;;  2 7/26/96  akh  handle modify-read-only-buffer in wrap item
;;  4 5/10/95  akh  bill's color menu
;;  3 5/2/95   akh  dont die if system script is non roman in menu-install
;;  2 5/1/95   akh  copyright
;;  3 2/7/95   akh  probably none
;;  (do not edit before this line!!)

;; 02/27/97 akh in menu-update dont call get-selection-fonts on NIL - ift??

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; font-menus.lisp
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-2001 Digitool, Inc.
;;
;;
;;  this file defines a set of hierarchical menus which can be used for
;;  setting the font of the current window.
;;
;;
 
(in-package :ccl)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Mod History
;;
;; font-number-from-name-simple faster in usual case
;; ------ 5.2b6
;; (re) define font-number-from-name-simple here for boot reasons
;; def-ccl-pointers for weird-fonts that drawtheme does better than quickdraw 
;; ------- 5.1 final
;; font-menu sometimes not enabled when window is keystroke-action-dialog
;; font-menu draws item names using the item's font, lose "Euphemia UCAS Italic"
;; ------- 5.1b2 
;; 11/12/01 akh see fix-font-scripts, font-number-from-name-simple
;; 06/07/01 akh fix add-font-menus for script - old bug
;; ------- 4.4b1
;; omit fonts with zero length (where do they come from?)
;; define functions add-font-color-items, add-font-style-items for font-search example
;; omit fonts starting with "."
;; use set-menu-item-script
;; enable-font-menus-p nil for keystroke-action-dialog - nah
;; -------- 4.3f1c1
;; 03/31/98 akh small tweaks to menu-install
;;; ----------- MCL 4.2
;; 07/06/97 akh attribute-reader for style menu was wrong (tho it's usage worked)
;; 07/03/97 akh menu-item-update ((item font-menu-item)) cons nothing - no closures
;; 07/01/97 akh add-font-menus - update-menu-items ONCE not n times - nah just set attribute-values empty ONCE.
;; 02/28/97 akh menu-update - don't if key-handler is NIL - fixes bad interaction with IFT which used to define ed-set-view-font for T - it doesn' any more
;; 11/24/96 akh add-font-menus updates the items to get check-mark in new item.
;;               menu-update does call-next-method iff enabled and not same items
;; 09/13/96 bill  Make styles toggle when appropriate.
;;                If there are multiple attributes in the selection, mark the menu items accordingly.
;; -------------  4.0b1
;; 08/06/96 bill  Alice's fix for the handler-bind in *toggle-wrap-menu-item*
;; 07/30/96 gb    don't enable-font-menus-p for da-windows.  Yuck.
;; 07/10/96 bill  *toggle-wrap-menu-item*
;; -------------  MCL-PPC 3.9
;; 01/04/96 bill  New trap names
;; 10/19/95 bill  add some caching to speed up menu-update
;; 05/09/95 bill  add a "Font Color" menu.
;; -------------  3.0b1
;; 05/21/93 bill  make font names in the non-system script appear in that script.
;; -------------- 2.1d6
;; 11/23/92 alice set-view-font => ed-set-view-font,
;;                view-font-codes => ed-view-font-codes - undoes 6/13/92
;; 10/19/92 bill enable-font-menus-p is a little more general
;; 08/05/92 bill use buffer-set-font-spec, not buffer-set-font-codes
;; 06/13/92 bill Engber's idea to change the insertion font if
;;               the whole window is selected.
;; ------------- 2.0
;; 03/10/92 bill Doug Currie's enable-font-menus
;; 02/28/92 gb   remove redundant when from menu-item-action
;; ------------- 2.0f3
;; 10/16/91 bill eliminate consing at menu-update time.
;; 09/19/91 bill replace slot-value with accessors
;; 09/08/91 wkf  Prevent unneccessary consing and speed up menu-item-update.
;; 06/25/91 bill The *font-menu* is updated at startup.
;; 06/13/91 bill WKF's fix for menu-item-update when no windows are open.
;; 04/03/91 bill Prevent error in menu-item-update when there are no windows
;;

;; redefined here for boot reasons
(defun font-number-from-name-simple (name)
  (if (or (7bit-ascii-p name)(not *font-name-number-alist*))
     (rlet ((fnum :signed-integer))
        (with-pstrs ((np name))
          (#_GetFNum np fnum))
        (%get-signed-word fnum))
     (cdr (assoc name *font-name-number-alist* :test #'string-equal))))


(defun font-number-from-mac-name (name)
  (rlet ((fnum :signed-integer))
    (with-pstrs ((np name))
      (#_GetFNum np fnum))
    (%get-signed-word fnum))) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  define a font-menu class and some methods.
;;
 
(defclass font-menu (menu)
  ((selection-fonts :initform (make-array 2 :adjustable t :fill-pointer 0) :accessor selection-fonts)
   (attribute-reader :initform nil
                     :initarg :attribute-reader
                     :accessor attribute-reader)
   (attribute-values :initform (make-array 1 :adjustable t :fill-pointer 0)
                     :accessor attribute-values)))
 
(defgeneric enable-font-menus-p (view)
  (:method ((v fred-mixin)) t)
  (:method ((v basic-editable-text-dialog-item)) t)
  (:method ((v da-window)) nil)
  (:method ((v keystroke-action-dialog))
           (if (front-window :class 'allow-view-draw-contents-mixin)
             ;; if Edit menu is selected during a modal-dialog invoked by
             ;; something in an allow-vdc window, a drawing mess ensues so don't let it happen
             nil
             (call-next-method)))
  (:method ((v t))
           (or (method-exists-p 'set-view-font-codes v)  ;; true for any window
               (method-exists-p 'ed-set-view-font v)
               (method-exists-p 'set-view-font v))))

(defmethod get-selection-fonts ((view simple-view) selection-fonts)
  (setf (fill-pointer selection-fonts) 0)
  (multiple-value-bind (ff ms) (ed-view-font-codes view)
    (vector-push-extend ff selection-fonts)
    (vector-push-extend ms selection-fonts))
  selection-fonts)

(defmethod get-selection-fonts ((view fred-mixin) selection-fonts)
  (multiple-value-bind (start end) (selection-range view)
    (if (eql start end)
      (call-next-method)
      (let ((buf (fred-buffer view)))
        (setf (fill-pointer selection-fonts) 0)
        (loop
          (multiple-value-bind (ff ms) (buffer-char-font-codes buf start)
            (let ((len (length selection-fonts)))
              (when (do ((i 0 (+ i 2)))
                        ((>= i len) t)
                      (declare (fixnum i))
                      (when (and (eql ff (aref selection-fonts i))
                                 (eql ms (aref selection-fonts (1+ i))))
                        (return nil)))
                (vector-push-extend ff selection-fonts)
                (vector-push-extend ms selection-fonts))))
          (setq start (buffer-next-font-change buf start))
          (when (or (null start) (>= start end))
            (return)))
        selection-fonts))))


(defmethod menu-update ((self font-menu))
  (let* ((w (front-window))
         (key-handler (and w  (or (current-key-handler w) w)))
         (selection-fonts (selection-fonts self)))
    (if (and key-handler (enable-font-menus-p key-handler))
      (progn
        (menu-item-enable self)
        (get-selection-fonts key-handler selection-fonts)
        (let* ((reader (attribute-reader self))
               (index 0))
          (declare (fixnum index))
          (when reader 
            (let* ((values (attribute-values self))
                   (values-length (length values))
                   (pair-count (truncate (length selection-fonts) 2))
                   (same-values? (eql values-length pair-count)))
              (declare (fixnum values-length pair-count))
              (setf (fill-pointer values) 0)
              (dotimes (i pair-count)
                (let* ((ff (aref selection-fonts index))
                       (ms (aref selection-fonts (1+ index)))
                       (value (funcall reader ff ms)))
                  (unless (and (< i values-length) (eql value (aref values i)))
                    (setq same-values? nil))
                  (vector-push-extend value values)
                  (incf index 2)))
              (when same-values? 
                (return-from menu-update nil)))))
        (call-next-method))
      (menu-item-disable self))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  define some variables for holding the menus
;;
 
(defvar *font-menu*
  (make-instance 'font-menu
    :menu-title "Font"
    :attribute-reader #'(lambda (ff ms)
                          (declare (ignore ms))
                          (point-v ff))))

(defvar *font-size-menu*
  (make-instance 'font-menu
    :menu-title "Font Size"
    :attribute-reader #'(lambda (ff ms)
                          (declare (ignore ff))
                          (point-h ms))))

(defvar *font-style-menu*
  (make-instance 'font-menu
    :menu-title "Font Style"
    :attribute-reader #'(lambda (ff ms)
                          (declare (ignore ms))
                          (the fixnum
                            (ash (the fixnum (point-h ff)) -8)))))

(defvar *font-color-menu*
  (make-instance 'font-menu
    :menu-title "Font Color"
    :attribute-reader #'(lambda (ff ms)
                          (declare (ignore ms))
                          (the fixnum
                            (logand 255 (the fixnum (point-h ff)))))))

(defvar *toggle-wrap-menu-item*
  (make-instance 'window-menu-item
    :menu-item-title "Word Wrap"
    :menu-item-action
    #'(lambda (w)
        (let ((item (current-key-handler w)))
          (block wrap
            (handler-bind ((modify-read-only-buffer
                            #'(lambda (c)
                                (declare (ignore c))
                                (if (buffer-whine-read-only item)
                                  (return-from wrap
                                    (setf (fred-word-wrap-p item) (not (fred-word-wrap-p item))))
                                  (return-from wrap nil)))))
              (setf (fred-word-wrap-p item) (not (fred-word-wrap-p item)))))))
    :update-function
    #'(lambda (menu-item)
        (let* ((w (front-window))
               (item (and w (current-key-handler w))))
          (if (and item (method-exists-p #'fred-word-wrap-p item))
            (progn
              (menu-item-enable menu-item)
              (set-menu-item-check-mark menu-item (fred-word-wrap-p item)))
            (progn
              (menu-item-disable menu-item)
              (set-menu-item-check-mark menu-item nil)))))))
 
; In case this file is loaded more than once.
(apply 'remove-menu-items *font-menu* (menu-items *font-menu*))
(apply 'remove-menu-items *font-size-menu* (menu-items *font-size-menu*))
(apply 'remove-menu-items *font-style-menu* (menu-items *font-style-menu*))
(apply 'remove-menu-items *font-color-menu* (menu-items *font-color-menu*))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  create a new class of menu-items for setting font attribute.
;;
;;  each menu-item has a title, and an attribute.  When the item is
;;  selected, it asks the top window to set-view-font to the attribute.
;;  In this way, there is only one action for the whole class.  (Each instance
;;  doesn't need its own action.  Each one just needs its own attribute).
;;
;;  The fact that the attribute is just like the name of the menu item
;;  is also convenient.
;;
 
(defclass font-menu-item (menu-item)
  ((attribute :initarg :attribute
              :reader attribute
              :initform '("chicago" 12 :plain))))

(defclass font-size-menu-item (font-menu-item) ())
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  arrange to put check marks by the current values of the font attributes,
;;  by asking the view what the font is and seeing if this attribute is present
;;  in addition, if this is a size attribute, see if the font is real
;;


(defmethod menu-item-update ((item font-size-menu-item))
  (let* ((owner           (menu-item-owner item))
         (selection-fonts (selection-fonts owner))
         (font-count      (floor (length selection-fonts) 2))
         (attribute       (attribute item))
         (real-font :unknown)
         (one-match nil)
         (all-match t))
    (dotimes (i font-count)
      (let ((ff (aref selection-fonts (+ i i)))
            (ms (aref selection-fonts (+ i i 1))))
        (if (progn 
              (if (#_RealFont (point-v ff) attribute)                
                (unless (null real-font)
                  (setq real-font t))
                (setq real-font nil))
              (eql attribute (point-h ms)))
          (setq one-match t)
          (setq all-match nil))))
    (set-menu-item-check-mark 
     item
     (and one-match
          (if all-match t #\+)))
    (unless (eq real-font :unknown)
      (set-menu-item-style 
       item
       (if real-font :outline :plain)))
    ))
 
(defmethod menu-item-update ((item font-menu-item))
  ;; !!! Get selection font from menu which calculates it just once per update. 9-Aug-91 -wkf
  (let* ((owner           (menu-item-owner item))
         (selection-fonts (selection-fonts owner))
         (font-count      (floor (length selection-fonts) 2))
         (attribute       (attribute item))
         (real-font       :unknown)
         (one-match nil)
         (all-match t)
         (test-function   (cond ((stringp attribute)    ; font name
                                 #'(lambda (ff ms attribute)
                                     (declare (ignore ms))
                                     (let ((aff (font-codes attribute)))
                                       (eql (point-v aff) (point-v ff)))))
                                #+ignore
                                ((integerp attribute)   ; font size
                                 #'(lambda (ff ms attribute)
                                     (if (#_RealFont (point-v ff) attribute)
                                       (unless (null real-font)
                                         (setq real-font t))
                                       (setq real-font nil))
                                     (eql attribute (point-h ms))))
                                ((and (consp attribute)
                                      (consp (car attribute))
                                      (eql :color-index (caar attribute)))      ; font color
                                 #'(lambda (ff ms attribute)
                                     (declare (ignore ms))
                                     (let ((color-code (logand #xff (point-h ff))))
                                       (eql color-code (second (car attribute))))))
                                (t #'(lambda (ff ms attribute)
                                       (declare (ignore ms))
                                       (let* ((cell (assq attribute *style-alist*))
                                              (value (cdr cell)))
                                         (and value
                                              (let ((face-code (lsh (point-h ff) -8)))
                                                (if (eql 0 value)
                                                  (eql 0 face-code)
                                                  (not (eql 0 (logand face-code value)))))))))))
         (index 0))
    (dotimes (i font-count)
      (let ((ff (aref selection-fonts index))
            (ms (aref selection-fonts (1+ index))))
        (incf index 2)
        (if (funcall test-function ff ms attribute)
          (setq one-match t)
          (setq all-match nil))))
    (set-menu-item-check-mark 
     item
     (and one-match
          (if all-match t #\+)))
    (unless (eq real-font :unknown)
      (set-menu-item-style 
       item
       (if real-font :outline :plain)))))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  the menu-item-action asks the front window to set its view-font
;;  to the menu-item's attribute.
;;  FRED-MIXIN instances are handled specially so that if the
;;  font of the entire screen is changed, the insertion font
;;  will track it (Mike Engber's idea).
;;
 
(defmethod menu-item-action ((item font-menu-item))
  (let ((w (front-window)))
    (when w
      (let* ((attribute (attribute item))
             (key-handler (or (current-key-handler w) w))
             (style-code (cdr (assq attribute *style-alist*))))
        (if style-code
          (style-menu-item-action item key-handler attribute style-code)
          (ed-set-view-font key-handler attribute))))))

(defun style-menu-item-action (item key-handler attribute style-code)
  (let ((check-mark (menu-item-check-mark item)))
    (if (or (eql style-code 0) (not (eql check-mark #\CheckMark)))
      (ed-set-view-font key-handler attribute)
      (ed-toggle-style-code key-handler style-code))))

(defmethod ed-toggle-style-code ((view simple-view) style-code)
  (multiple-value-bind (ff ms) (ed-view-font-codes view)
    (setq ff (make-point (logxor (point-h ff) (ash style-code 8))
                         (point-v ff)))
    (set-view-font-codes view ff ms)))

(defmethod ed-toggle-style-code ((view fred-mixin) style-code)
  (handler-bind
    ((modify-read-only-buffer
      #'(lambda (c)                                    
          (declare (ignore c))
          (if (null (buffer-whine-read-only view))
            (return-from ed-toggle-style-code nil)
            (return-from ed-toggle-style-code (ed-toggle-style-code view style-code))))))
    (multiple-value-bind (start end) (selection-range view)
      (if (eql start end)
        (call-next-method)
        (let* ((buf (fred-buffer view))
               (style (buffer-get-style buf start end))
               (here start)
               next)
          (loop 
            (setq next (or (buffer-next-font-change buf here) end))
            (multiple-value-bind (ff ms) (buffer-char-font-codes buf here)
              (setq ff (make-point (logxor (point-h ff) (ash style-code 8))
                                   (point-v ff)))
              (buffer-set-font-codes buf ff ms here next)
              (setq here next)
              (when (>= here end) (return))))
          (ed-history-add view start (cons "" style))
          (set-fred-undo-string view "Style Change"))))
    (fred-update view)))

(defmethod ed-set-view-font ((view simple-view) thing)
  (set-view-font view thing))

#|
(defmethod smart-set-view-font (self font-spec)
  (set-view-font self font-spec))

(defmethod smart-set-view-font ((self fred-mixin) font-spec)
  (let ((all-selected? nil)
        (buf (fred-buffer self)))
    (multiple-value-bind (start end) (selection-range self)
      (if (eql start end)
        (buffer-set-font-spec buf font-spec)
        (progn
          (buffer-set-font-spec buf font-spec start end)
          (when (setq all-selected?
                      (and (zerop start) (= end (buffer-size buf))))
            (buffer-set-font-spec buf font-spec)))))
    (buffer-remove-unused-fonts (fred-buffer self))
    (if all-selected?
      (fred-update self)
      (window-show-cursor self))))
|#

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  here we set up the font menu.  We make an item for each font listed
;;  in the global variable *font-list*.  In this case, the menu-item name
;;  and the attribute are exactly the same (a string giving the name of a
;;  font).
;;
;;  We process the *font-list* to remove fonts that begin with a "%",
;;  because these aren't meant to be displayed in font menus.
;;  Lose "." too.
;;

#| From Deborah Goldsmith, Apple Unicode guru
The Euphemia UCAS family (with regular, bold, and italic faces) was new 
in Mac OS X 10.3 (Panther). It won't appear if you have an earlier OS 
release. Also, it's an optional install: you need to select "Fonts for 
Additional Languages" in the installer, or you won't get it. It's a 
font for Canadian native languages such as Inuktitut and Cree (UCAS 
stands for "Unified Canadian Aboriginal Syllabics", the part of Unicode 
used to write such languages).
|#
 
(defun add-font-menus ()
  (apply #'remove-menu-items *font-menu* (menu-items *font-menu*))
  (let ((handle (menu-handle *font-menu*))
        (n 1))
    (dolist (thing (remove-if #'(lambda (item)
                                  (let ((name (car item)))                                    
                                    (or (eql (length name) 0)
                                        (memq (elt name 0) '(#\% #\.))
                                        ;; lose mr. Euphemia - is fukt everywhere
                                        (string-equal name  "Euphemia UCAS Italic"))))
                              *font-list*))
      (let ((menu-item (make-instance 'font-menu-item
                         :menu-item-title (car thing)  ;; title is mac-encoded
                         :attribute (cadr thing))))   ;; attribute is unicode                
        (add-menu-items *font-menu* menu-item)
        (when handle
          (#_setmenuitemfontid handle n (third thing)))
        (incf n))))
  ;(show-font-menu-fonts)
  #+ignore
  (when (cdr *script-list*)
    (fix-font-scripts *font-menu*))
  ; nuke attribute-values from before save-application so check-mark gets set
  (setf (fill-pointer (attribute-values *font-menu*)) 0)
  ;(update-menu-items *font-menu*)
  )

#+ignore
(defun fix-font-scripts (menu) ;; menu is *font-menu* we hope
  (let* ((system-script (#_GetScriptManagerVariable #$smSysScript))         
         (n 0))
    (declare (fixnum n))
    ;; this now crashes OSX dunno why - twas only here for OSX anyway - fixed
    (when t ;(not (osx-p))
      (dolist (item (menu-items menu))
        (setq n (1+ n))
        (let* ((font-num (font-number-from-name-simple (menu-item-title item)))
               (font-script (#_FontToScript font-num)))
          (unless (eql system-script font-script)
            (set-menu-item-script item font-script n)))))))


;; do we need this?
(defun show-font-menu-fonts ()
  (let* ((menu *font-menu*)
         (items (menu-items menu))
         (handle (menu-handle menu))
         (n 0))
    (declare (fixnum n))
    (when handle
      (dolist (item items)
        (setq n (1+ n))
        (let* ((title (menu-item-title item))  ;; title is mac encoded name
               (font (font-number-from-mac-name title)))          
          (when (not (string-equal "Euphemia UCAS Italic" title)) ; this font appears fukt on 10.3
            (#_setmenuitemfontid handle n font)))))))

      
 
; Ensure that font names in other than the system script appear
; in that script. This doesn't appear to work on a IIci, but
; #_AddResMenu has the same problem.
(defmethod menu-install :after ((menu font-menu))
  ; Need to make fonts not in the system script appear in their script
  (when (eq menu *font-menu*)
    (show-font-menu-fonts))
  #+ignore
  (when (and (eq menu *font-menu*)(cdr *script-list*))
    (fix-font-scripts menu)))

#| moved to sysutils
;; we know the font exists in this case - 
(defun font-number-from-name-simple (name)
  (rlet ((fnum :signed-integer))
    (with-pstrs ((np name))
      (#_GetFNum np fnum))
    (%get-signed-word fnum)))
|#

(pushnew 'add-font-menus *lisp-startup-functions*)
(add-font-menus)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  here we set up the font size menu.  Each menu-item has a number
;;  for its attribute.  To get the name of the menu-item, we just print
;;  the number into a string using the function FORMAT.
;;
 
 
(dolist (font-size '(9 10 12 14 18 24 30 36))
  (add-menu-items *font-size-menu*
                  (make-instance 'font-size-menu-item
                                 :menu-item-title (format nil "~d" font-size)
                                 :attribute font-size)))
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  here we set up the font style menu.  In this case it's easiest to just
;;  give the attribute explicitly.
;;
;;  Once the menu-items are set up, we ask them to change their font style,
;;  so that they are displayed in the style they represent.
;;
 

(defun add-font-style-items (menu) 
  (add-menu-items
   menu
   (make-instance 'font-menu-item :menu-item-title "Plain" :attribute :plain)
   (make-instance 'font-menu-item :menu-item-title "Bold" :attribute :bold)
   (make-instance 'font-menu-item :menu-item-title "Italic" :attribute :italic)
   (make-instance 'font-menu-item :menu-item-title "Underline" :attribute :underline)
   (make-instance 'font-menu-item :menu-item-title "Outline" :attribute :outline)
   (make-instance 'font-menu-item :menu-item-title "Shadow" :attribute :shadow)
   (make-instance 'font-menu-item :menu-item-title "Condense" :attribute :condense)
   (make-instance 'font-menu-item :menu-item-title "Extend" :attribute :extend))
  (dolist (menu-item (menu-items menu))
    (set-menu-item-style menu-item (attribute menu-item))))

(add-font-style-items *font-style-menu*)
 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  here we set up the font color menu.
;;

(defparameter *font-menu-colors*
  `(("Black" . (0))
    ("Dark Gray" . ,*dark-gray-color*)
    ("Gray" . ,*gray-color*)
    ;("Light Gray" . ,*light-gray-color*)
    nil
    ("Red" . ,*red-color*)
    ("Pink" . ,*pink-color*)
    ("Purple" . ,*purple-color*)
    ("Blue" . ,*blue-color*)
    ("Light Blue" . ,*light-blue-color*)
    nil
    ("Dark Green" . ,*dark-green-color*)
    ("Green" . ,*green-color*)
    ("Brown" . ,*brown-color*)
    ("Tan" . ,*tan-color*)
    ("Orange" . ,*orange-color*)
    ;("Yellow" . ,*yellow-color*)
    ))
(defun add-font-color-items (menu)
  (let ((colors *font-menu-colors*))
    (dolist (color-spec colors)
      (let* ((name (car color-spec))
             (color (cdr color-spec))
             (color-index (if (listp color)
                            (car color)
                            (fred-palette-closest-entry color))))
        (add-menu-items
         menu
         (if name
           (let ((item (make-instance 'font-menu-item
                         :menu-item-title name
                         :attribute (list (list :color-index color-index)))))
             (set-part-color item :item-title (if (listp color) *black-color* color))
             item)
           (make-instance 'menu-item :menu-item-title "-")))))))

(add-font-color-items *font-color-menu*)

; This fixes an OS bug. The colors don't get properly
; initialized until the default item color is set
(def-ccl-pointers *font-color-menu* ()
  (set-part-color *font-color-menu* :default-item-title *black-color*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  now that we have all the menus, we just add them to the *edit-menu*
;;  (preceded by a blank-line menu-item).
;;
 
(unless (find-menu-item *edit-menu* (menu-item-title *font-menu*))
  (add-menu-items *edit-menu*
                  (make-instance 'menu-item :menu-item-title "-")   ;a blank line
                  *font-menu* *font-size-menu* *font-style-menu* *font-color-menu*
                  (make-menu-item "-") *toggle-wrap-menu-item*))

;; fonts that drawtheme does better than quickdraw 
;; put here for lack of a better place
(def-ccl-pointers gb18030p ()
  (setq *weird-fonts* nil)
  (when (osx-p)
    (let* ((sysfont-id (ash (sys-font-codes) -16))
           (geez (ash (font-codes '("GB18030 Bitmap")) -16))) ;; this is ChineseSimp I think
      (when (neq geez sysfont-id)
        (push geez *weird-fonts*))
      (setq geez (ash (font-codes '("Geeza Pro")) -16))  ;; these are macroman
      (when (neq geez sysfont-id)
        (push geez *weird-fonts*))
      (setq geez (ash (font-codes '("Geeza Pro Bold")) -16))
      (when (neq geez sysfont-id)
        (push geez *weird-fonts*)))))

(provide "FONT-MENUS")
 



#|
	Change History (most recent last):
	2	1/2/95	akh	provide font-menus
|# ;(do not edit past this line!!)
