; -*- Mode:Lisp; Package: INTERFACE-TOOLS; -*-

;;	Change History (most recent first):
;;  3 6/2/97   akh  see below
;;  4 5/20/96  akh  select-several-items finds any view - not just dialog-item
;;  3 3/20/95  akh  view-contains-point-p uses view-window vs view-container
;;  (do not edit before this line!!)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  dialog-editor.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995-2000 Digitool, Inc.
;;
;;  the main code of the dialog-editor portion of the interface designer
;;

;;;;;;;;;;;;;;;;;;;;
;;
;; Change History
;;
;; windows are theme-background t
;; ---- 5.2b6
;; view-find-vacant-position uses view-outer-size
;; -------- 5.1b1
;; put the OK button on the right
;; --------- 5.0 final
;; enhancememt from Shannon Spires
;; fix so dragging a scroll-bar drags whole container - this fixes feedback too
;; ----------- 4.4b4
;; create-new-dialog gets theme-background
;; ---------- 4.4b3
;; akh no mo require control-key for drag from palette ??
;; ------- 4.4b1
;; carbon-compat - use drag-and-drop
;; visrgn is a handle - new interfaces wanna know that
;; ----------- 4.3
;; 04/27/97 AKH select-all and window-can-do-operation call dialog-items with class 'simple-view 
;; 04/27/97 akh select-all :around ((window window)) doesn't select scroll bars of table-dialog-item
;; 03/04/97 bill    Add view-owner generic function with a scroll-bar-dialog-item
;;                  method that returns the scroll-bar-scrollee.
;;                  sloppy-find-view-containing-point returns the view-owner
;;                  if there is one instead of the view. This prevents selecting a
;;                  scroll bar of a table-dialog-item.
;; ---------------- 4.0
;; akh select-several-items finds any view - not just dialog-item
;; 01/09/96 bill  remove explicit return type from (#_EmptyRect ...)
;;  5/04/95 slh   use tool background color
;;-----------------
;; if creating item palette before new-dialog, let it finish drawing
;; item-palette-size skinnier, *item-palette-position* no overlap new-dialog dialog
;; make-instance-from-prototype scrolling-fred-view save-buffer-p t for good measure
;; create-new-dialog sets *editing-dialogs* t etc. (she is always enabled)
;; remove-view-from-window defined on simple-view
;;-----------------
;; 03/20/93 alice view-contains-point-p was not correct.
;; 02/15/93 alice *edit-menu* => (edit-menu)
;; 12/21/92 alice remove-view-from-window method for scrolling-fred-view
;; 11/14/92 alice set-item-nick-name defined on simple-view so scrolling-fred works
;;		  pop-up-menu editor should let you enter a nick-name too
;; 11/11/92 alice add scrolling fred dialog, :movable-dialog and use :movable-dialog
;; 11/04/92 alice add pop-up-menus, make sure palette is wholly on screen (bottom right);;
;; 07/22/92 bill  Luke Hohmann's view-key-event-handler
;; 04/08/92 bill  make sloppy-find-view-containing-point search from front to back.
;; -------------- 2.0
;; 01/09/91 alice put back  cut etal:around methods, update edit-menu in select-and-add-xx -??????
;;		  select-all was broken
;; 12/29/91 alice window-do-operation has another argument
;; 12/18/91 bill  prevent errors in remove-editable-dialog-item
;; -------------  2.0b4
;; 11/05/91 bill  nuke nfunction
;; 10/15/91 alice remove window-can-undo-p, add window-can-do-operation.
;;		Advise window-do-operation to do cut etal inline instead of via
;;		:around methods because there are no longer any methods for them to be :around.
;; 09/23/91 bill #'(setf view-nick-name) -> #'set-view-nick-name
;; 09/09/91 bill show item-palette only after adding subviews
;; 09/06/91 bill autosize the item-palette, (use-dialogs) on close-box click in item-palette
;; 08/12/91 alice lets not die in select-all;;
;; 07/26/91 bill WINDOW-CAN-UNDO-p was mis-parenthesized, CLEAR was brain-damaged
;;               GROW-ITEM-OUTLINE needed to constain mouse movement
;; 02/07/91 bill move-selected-dialog-items fixed for user dragging outside of window
;; *2.0b1*
;; 01/30/91 bill select-and-add-dialog-item takes a mouse-pos parameter and
;;               shows an outline on all monitors.
;;

(in-package :interface-tools)

;;;;;;;;;;;;;;;;;;;;
;;
;; misc
;;

(proclaim '(special *dialog-change-undohook* *selected-dialog-items*
            *dialog-item-scrap* *grow-cursor*))


;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; variables & classes
;;


; has one method - view-cursor
(defclass proto-editable-text-dialog-item (editable-text-dialog-item)())


(defvar *guide-gravity* 3
  "how far you can be from a guide to still snap to it")

(defclass window-type-r-b (radio-button-dialog-item)
  ((attribute :initarg :attribute :accessor dialog-item-attribute)))

(defclass frame-window-r-b (window-type-r-b)
  ())

(defclass box-window-r-b (window-type-r-b)
  ())

(defclass dialog-editor (non-editable-dialog)
  ((edited-dialog :initarg :dialog :accessor dialog-editor-dialog))
  (:default-initargs :window-type :movable-dialog
                     :window-title ""
                     :view-position '(:top 100)
                     :view-size #@(372 98)
                     :window-show nil
                     :close-box-p nil
                     ;:content-color *tool-back-color*
                     ;:back-color *tool-back-color*
                     :theme-background t
                     ))

(defvar *prototype-dialog-items* '())

(defvar *current-item-palette* nil)

(defparameter *item-palette-size* #@(100 200))

(defparameter *item-palette-position* (make-point (min (+ 200
                                                          (truncate *screen-width* 2))
                                                       (- *screen-width*
                                                          (point-h *item-palette-size*)))
                                                  70))


(defclass item-palette (windoid non-editable-dialog)
  ()
  (:default-initargs :window-title "Palette"))


;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  definitions and redefinitions for the *dialog* class
;;

(defmacro get-window-type (window)
  `(view-get ,window 'window-type))

(defmacro get-vertical-guides (window)
  `(view-get ,window 'vertical-guides))

(defmacro get-horizontal-guides (window)
  `(view-get ,window 'horizontal-guides))

(defmethod initialize-instance :around ((window window) &key
                                        window-type)
  (declare (dynamic-extent initargs))
  (prog1
    (call-next-method)
    (setf (get-window-type window) window-type)
    (setf (get-vertical-guides window) ())
    (setf (get-horizontal-guides window) ())))

(defmethod window-update-cursor :around ((window window) where)
  (declare (ignore where))
  (if (ccl::editing-dialogs-p window)
    (set-cursor (if (command-key-p)
                  *grow-cursor*
                  *cross-hair-cursor*))
    (call-next-method)))

(defmethod view-draw-contents :around ((window window))
  (call-next-method)
  (when (ccl::editing-dialogs-p window)
    (draw-dialog-guides window)
    (highlight-selected-items window t t)))

(defmethod view-deactivate-event-handler :around ((window window))
  (call-next-method)
  (setq *dialog-change-undohook* nil)
  (when *selected-dialog-items*
    (reset-selected-item-list window)))

(defmethod ccl::view-owner ((view t))
  nil)

(defmethod ccl::view-owner ((view scroll-bar-dialog-item))
  (scroll-bar-scrollee view))

(defun sloppy-find-view-containing-point (view point slop)
  (let* ((views (view-subviews view)))
    (do* ((i (1- (length views)) (1- i))
          subview)
         ((< i 0))
      (setq subview (aref views i))
      (let* ((tl (view-position subview))
             (br (add-points tl (view-size subview)))
             (top (ccl::%i- (point-v tl) slop))
             (bottom (ccl::%i+ (point-v br) slop))
             (left (ccl::%i- (point-h tl) slop))
             (right (ccl::%i+ (point-h br) slop))
             (h (point-h point))
             (v (point-v point)))
        (when (and (ccl::%i<= top v)
                   (ccl::%i<= v bottom)
                   (ccl::%i<= left h)
                   (ccl::%i<= h right))
          (return (or (ccl::view-owner subview) subview)))))))

(defmethod view-click-event-handler :around ((window window) where &aux
                                             (move-p (ccl::editing-dialogs-p window))
                                             (item (sloppy-find-view-containing-point 
                                                    window where 3)))
  (setq *dialog-change-undohook* nil)
  (if move-p
      (with-focused-view window
        (cond ((command-key-p)
               (grow-or-move-window window where))
              ((or (memq (point-h where) (get-vertical-guides window))
                   (memq (point-v where) (get-horizontal-guides window)))
               (drag-guide window where))
              (item
               ;move, resize, or edit the item
               (if (double-click-p)
                 (edit-dialog-item item)
                 (let ((was-selected (dialog-item-selected-p item)))
                   (if (shift-key-p)
                     (grow-or-move-dialog-item window where item was-selected)
                     (progn
                       (unless was-selected
                         (reset-selected-item-list window))
                       (grow-or-move-dialog-item window where item nil))))))
              (t (select-several-items window where))))
      (call-next-method)))

;; move selected dialog items based on the arrow keys
;; command-key allows delete even if current-key-handler
(defmethod view-key-event-handler :around ((window window) char)
  (if (and (ccl::editing-dialogs-p window)
           (or (member char '(#\UpArrow #\ForwardArrow #\BackArrow #\DownArrow))
               (and (eq char #\delete)(or (command-key-p)(not (current-key-handler window))))))
    (if (eq char #\delete)
      (clear window)
      (with-focused-view window
        (dolist (item *selected-dialog-items*)
          (highlight-one-selected-item window item t nil)
          (set-view-position
           item
           (case char
             (#\UpArrow      (add-points (view-position item) #@(0 -1)))
             (#\ForwardArrow (add-points (view-position item) #@(1 0)))
             (#\BackArrow    (add-points (view-position item) #@(-1 0)))
             (#\DownArrow    (add-points (view-position item) #@(0 1)))))
          (highlight-one-selected-item window item t t))))
      (call-next-method)))

;;;;;;;;;;;
;;
;; cut/copy/paste/clear/select-all
;;


(defmethod copy-selected-dialog-items ((window window))
  (mapcar #'(lambda (item)
              (copy-instance item))
          *selected-dialog-items*))


(defmethod cut :around ((window window))
  (if (ccl::editing-dialogs-p window)
      (progn (setq *dialog-item-scrap* *selected-dialog-items*)
             (clear window))
      (when (next-method-p)(call-next-method))))

(defmethod copy :around ((window window))
  (if (ccl::editing-dialogs-p window)
      (setq *dialog-item-scrap* (copy-selected-dialog-items window))
      (when (next-method-p)(call-next-method))))

(defmethod paste :around ((window window))
  (if (ccl::editing-dialogs-p window)
      (let ((items *dialog-item-scrap*))
        (if items
            (progn
              (setq *dialog-change-undohook*
                    (cons "Undo Paste"
                          #'(lambda ()
                              (apply
                                #'remove-subviews window items)
                              (setq *dialog-item-scrap* items
                                    *dialog-change-undohook* nil))))
              (apply
                #'add-subviews window items)
              (setq *dialog-item-scrap* ()))
            (message-dialog "No items to paste!")))
      (call-next-method)))

(defmethod clear :around ((window window))
  (if (ccl::editing-dialogs-p window)
      (let* ((items *selected-dialog-items*))
        (if items
            (progn 
              (setq *dialog-change-undohook*
                    (cons "Undo Clear"
                          #'(lambda ()
                              (reset-selected-item-list window)
                              (apply
                                #'add-subviews window items)
                              (dolist (item items)
                                (select-dialog-item window item))
                              (setq *dialog-change-undohook* nil))))
              (apply
                #'remove-subviews window items))
            (message-dialog "No items to remove!")))
      (when (next-method-p)(call-next-method))))

(defmethod select-all :around ((window window))
  (if (ccl::editing-dialogs-p window)
    (dolist (item (dialog-items window 'simple-view))
      (when (not (ccl::view-owner item))
        (select-dialog-item window item)))
    (when (next-method-p)(call-next-method))))


(defmethod undo :around ((window window))
  (if (ccl::editing-dialogs-p window)
    (funcall (cdr *dialog-change-undohook*))
    (when (next-method-p)(call-next-method))))


(defmethod window-can-do-operation :around ((window window) op &optional item)
  (cond
   ((ccl::editing-dialogs-p window)
    (case op
      (undo 
       (when *dialog-change-undohook*
         (set-menu-item-title item (car *dialog-change-undohook*))
         t))
      (select-all
       (dialog-items window 'simple-view))
      ((clear copy cut) *selected-dialog-items*)
      (paste *dialog-item-scrap*)))
   ((next-method-p)(call-next-method))))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  definitions and redefinitions for dialog-items
;;

(defvar *dialog-item-editor-hash* (make-hash-table :test 'eq :weak t))

(defun get-dialog-item-editor (item)
  (gethash item *dialog-item-editor-hash*))

(defun (setf get-dialog-item-editor) (editor item)
  (if editor
    (setf (gethash item *dialog-item-editor-hash*) editor)
    (remhash item *dialog-item-editor-hash*))
  editor)

(defun dialog-item-selected-p (item)
  (member item *selected-dialog-items* :test #'eq))

(defmethod remove-view-from-window :around ((item simple-view))
  (when (dialog-item-selected-p item)
    (unselect-dialog-item (view-container item) item))
  (call-next-method))


(defmethod (setf wptr) :around (new-wptr (item simple-view))  ; was dialog-item
  (when (null new-wptr)
    (let* ((my-ed (get-dialog-item-editor item)))
      (when my-ed
        (window-close my-ed)
        (setf (get-dialog-item-editor item) nil))))
  (call-next-method))

; Patch the method for simple-view - this was WRONG!!!!!!!!! now its RIGHT
; say view-window vs view-container - be more right !!!!!!
(defmethod view-contains-point-p :around ((item simple-view) point)  ; was dialog-item
  (if (not (ccl::editing-dialogs-p (view-window item)))
    (call-next-method)
    (let* ((offset 3)
           (point-h (point-h point))
           (point-v (point-v point))
           (item-p (view-position item))
           (item-s (view-size item))
           (item-left (- (point-h item-p) offset))
           (item-top (- (point-v item-p) offset)))
      (declare (fixnum point-h point-v item-left item-top))
      (and (<= item-left point-h)
           (<= item-top point-v)      
           (let*
             ((item-right (+ offset offset
                             item-left (point-h item-s)))
              (item-bottom (+ offset offset
                              item-top (point-v item-s))))
             (and (< point-h item-right)
                  (< point-v item-bottom)))))))

(defmethod new-action-from-dialog ((item dialog-item))
  (let ((*save-definitions* t))
    (setf (dialog-item-action-function item)
           (eval (read-from-string    ; EVAL??
                  (get-text-from-user
                   "Please enter text for the dialog-item-action:"
                   (dialog-item-action-source item)))))))

(defmethod dialog-item-action-source ((item dialog-item) &aux old-source)
  (let* ((*print-pretty* t))
  (format nil
          "(function~%  ~a)"
          (let ((f (dialog-item-action-function item)))
            (if f
              (or (and (setq old-source (uncompile-function f))
                       (format nil "~s" old-source))
                  "  (lambda (item)
;The previous source code for the action could not be found.
;Perhaps the code for the dialog was loaded from a fasl file,
;or was compiled with *save-definitions* bound to nil
)")
              "  (lambda (item)
      item
;Enter action source code here.
)")))))

(defmethod set-item-nick-name ((item simple-view))
  (let ((new-name (read-from-string
                   (get-string-from-user "Enter a nick-name for the item."
                                         :initial-string (string (or (view-nick-name item)
                                                                     ""))))))
    (set-view-nick-name item new-name)))

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; support for moving and resizing windows
;;


(defmethod grow-or-move-window ((window window) where)
  (if (double-click-p)
      (edit-dialog window)              ;code for this is down at the bottom
      (let* ((wptr (wptr window))
             (global-where (ccl::%local-to-global wptr where))
             (w-size (view-size window)))
        (reset-selected-item-list window)
        (if (and (> 15 (- (point-h w-size)
                          (point-h where)))
                 (> 15 (- (point-v w-size)
                          (point-v where))))
            (grow-window window)
            (progn
              (#_DragWindow :ptr wptr
                            :long global-where
                            :ptr (window-drag-rect window)))))))

(defmethod grow-window ((window window) &aux (pos (view-position window)))
  #+carbon-compat
  (window-grow-event-handler window (add-points pos (view-size window)))
  #-carbon-compat
  (set-view-size  window
                    (subtract-points (grow-gray-rect pos
                                                     (view-size window)
                                                     (window-manager-port)
                                                    45)
                                    pos))
  )

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  support for guides
;;


(defmethod draw-dialog-guides ((window window))
  (let* ((w-size (view-size window))
         (w-height (point-v w-size))
         (w-width (point-h w-size)))
  (with-focused-view window
    (with-pen-saved
      (#_PenMode :word (position :patxor *pen-modes*))
      (#_PenPat :ptr *gray-pattern*)
      (dolist (guide (get-vertical-guides window))
        (draw-one-guide window :vertical guide w-height))
      (dolist (guide (get-horizontal-guides window))
        (draw-one-guide window :horizontal guide w-width))))))

(defmethod draw-one-guide ((window window) direction position end)
  "port, pattern, and mode must already be set"
  (case direction
    (:vertical
     (#_MoveTo :word position
               :word 0)
     (#_LineTo :word position
               :word end))
    (:horizontal
     (#_MoveTo :word 0
               :word position)
     (#_LineTo :word end
               :word position))
    (t (error "bad argument: ~s " direction))))

(defmethod add-guide ((window window) direction)
  (draw-dialog-guides window)
  (unwind-protect
    (case direction
      (:vertical
       (push 50 (get-vertical-guides window)))
      (:horizontal
       (push 50 (get-horizontal-guides window)))
      (t (error "bad argument: ~s " direction)))
    (draw-dialog-guides window)))

(defmethod add-horizontal-guide ((window window))
  (add-guide window :horizontal))

(defmethod add-vertical-guide ((window window))
  (add-guide window :vertical))

(defmethod drag-guide ((window window) where
                       &aux guide direction end extractor)
  (let ((horizontal-guides (get-horizontal-guides window))
        (vertical-guides (get-vertical-guides window)))
    (cond
     ((setq guide
            (car (memq (point-h where) vertical-guides)))
      (setq vertical-guides
            (setf (get-vertical-guides window) (delete guide vertical-guides))
            direction :vertical
            end (point-v (view-size window))
            extractor #'point-h))
     ((setq guide
            (car (memq (point-v where) horizontal-guides)))
      (setq horizontal-guides 
            (setf (get-horizontal-guides window) (delete guide horizontal-guides))
            direction :horizontal
            end (point-h (view-size window))
            extractor #'point-v))
     (t (error "bad argument: ~s " where)))
    (with-focused-view window
      (with-pen-saved
        (#_PenMode :word (position :patxor *pen-modes*))
        (#_PenPat :ptr *gray-pattern*)
        (do* ((old-mouse (funcall extractor where)
                         new-mouse)
              (new-mouse old-mouse
                         (funcall extractor (view-mouse-position window))))
             ((not (mouse-down-p))
              (when (> old-mouse 0)
                (if (eq direction :vertical)
                  (when (< old-mouse (point-h (view-size window)))
                    (setf (get-vertical-guides window)
                          (push old-mouse vertical-guides)))
                  (when (< old-mouse (point-v (view-size window)))
                    (setf (get-horizontal-guides window)
                          (push old-mouse horizontal-guides))))))
          (draw-one-guide window direction old-mouse end)
          (draw-one-guide window direction new-mouse end)
          (sleep 1/60))))))

(defmethod guide-align ((window window) point)
  (let* ((h (point-h point))
         (v (point-v point)))
    (when (setq point
                (car (member h (get-vertical-guides window) :test #'on-guide-p)))
      (setq h point))
    (when (setq point
                (car (member v (get-horizontal-guides window) :test #'on-guide-p)))
      (setq v point))
    (make-point h v)))

(defun on-guide-p (num-1 num-2)
  (<= (abs (- num-1 num-2)) *guide-gravity*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  support for selecting/moving/resizing dialog items
;;


(defmethod select-dialog-item ((window window) item)
  (pushnew item *selected-dialog-items*)
  (with-focused-view window
    (highlight-one-selected-item window item t)))

(defmethod unselect-dialog-item ((window window) item)
  (setq *selected-dialog-items*
        (delete item *selected-dialog-items*))
  (with-focused-view window
    (highlight-one-selected-item window item nil)))

(defmethod reset-selected-item-list ((window window))
  (highlight-selected-items window nil)
  (setq *selected-dialog-items* nil))

(defmethod highlight-selected-items ((window window) on-p &optional draw-p)
  (with-focused-view window
    (dolist (item *selected-dialog-items*)
      (highlight-one-selected-item window item on-p draw-p))))

(defmethod highlight-one-selected-item ((window window) item on-p &optional draw-p)
  "port should already be set"
  (declare (optimize (speed 3) (safety 0)))
  (declare (special on-p draw-p))       ; temporary until stack-consed closures
  (let* (pos size end)
    (setq pos (view-position item)
          size (view-size item)
          end (add-points pos size))
    (let* ((delta 3)
           (top (point-v pos))
           (top-top (- top delta))
           (bottom (point-v end))
           (bottom-bottom (+ bottom delta))
           (left (point-h pos))
           (left-left (- left delta))
           (right (point-h end))
           (right-right (+ right delta))
           (left-center (+ 1 left-left (ash (point-h size) -1)))
           (right-center (+ left-center delta))
           (top-center (+ 1 top-top (ash (point-v size) -1)))
           (bottom-center (+ top-center delta)))
      (declare (fixnum delta top top-top bottom bottom-bottom
                       left left-left right right-right
                       left-center right-center top-center bottom-center))
      (rlet ((rect :rect))
        (declare (special rect))        ; temporary until stack-consed closures
        (flet ((do-rect (top bottom left right)
                        (rset rect rect.top top)
                        (rset rect rect.left left)
                        (rset rect rect.bottom bottom)
                        (rset rect rect.right right)
                        (if on-p
                          (if draw-p
                            (#_PaintRect :ptr rect)
                            #-carbon-compat
                            (#_InvalRect :ptr rect)
                            #+carbon-compat
                            (ccl::inval-window-rect (wptr window) rect))
                          (progn
                            (invalidate-corners 
                             window
                             (make-point left top)
                             (make-point right bottom)
                             t)))))
          (declare (dynamic-extent do-rect))
          (do-rect top-top top left-left left)
          (do-rect top-top top left-center right-center)
          (do-rect top-top top right right-right)
          (do-rect top-center bottom-center left-left left)
          (do-rect top-center bottom-center right right-right)
          (do-rect bottom bottom-bottom left-left left)
          (do-rect bottom bottom-bottom left-center right-center)
          (do-rect bottom bottom-bottom right right-right))))))

(defmethod select-several-items ((window window) where &aux scratch)
  (unless (shift-key-p)
    (reset-selected-item-list window))
  (rlet ((user-rect :rect)
         (scratch-rect :rect)
         (i-rect :rect))
    (#_pt2rect :long where
               :long (grow-gray-rect where 0 (wptr window) nil)
               :ptr user-rect)
    (dolist (item (dialog-items window 'simple-view))
      (setq scratch (view-position item))
      (rset i-rect :rect.topleft scratch)
      (rset i-rect :rect.bottomright (add-points
                                      scratch
                                      (view-size item)))
      (#_SectRect :ptr user-rect :ptr i-rect :ptr scratch-rect)
      (unless (#_EmptyRect scratch-rect)
        (select-dialog-item window item)))))

(defmethod grow-or-move-dialog-item ((window window) where item was-selected)  
  (while (eq where (view-mouse-position window))
    (unless (mouse-down-p)
      (if was-selected
        (unselect-dialog-item window item)
        (select-dialog-item window item))
      (return-from grow-or-move-dialog-item)))
  (select-dialog-item window item)
  (let* (pos end)
    (setq pos (view-position item)
          end (add-points pos (view-size item)))
    (rlet ((item-rect :rect
                      :topleft pos
                      :bottomright end))
      (unwind-protect
        (progn
          (#_HideCursor)
          (if (or (#_PtInRect where item-rect)
                  (> (length *selected-dialog-items*) 1))
            (move-selected-dialog-items window where item-rect)
            (grow-dialog-item window item item-rect where)))
        (#_ShowCursor)))))

(defmethod grow-dialog-item ((window window) item item-rect where &aux new-pos)
  (highlight-one-selected-item window item nil)
  (let* ((old-pos (rref item-rect :rect.topleft))
         (old-size (subtract-points
                    (rref item-rect :rect.bottomright)
                    old-pos)))
    (setq item-rect
          (grow-item-outline window item-rect where))
    (without-interrupts 
     (invalidate-view item t)
     (set-view-position item (setq new-pos
                                   (rref item-rect :rect.topleft)))
     (set-view-size item (subtract-points
                          (rref item-rect :rect.bottomright)
                          new-pos)))
    (highlight-one-selected-item window item t)
    (setq *dialog-change-undohook*
          (cons "Undo Resize"
                #'(lambda ()
                    (with-focused-view window
                      (without-interrupts
                       (highlight-one-selected-item window item nil)
                       (set-view-size item old-size)
                       (set-view-position item old-pos)
                       (highlight-one-selected-item window item t))))))))

(defmethod grow-item-outline ((window window) rect where)
  "destructively modifies the rect"
  (let* ((flag nil)
         (pos where)
         (pos-h (point-h pos))
         (pos-v (point-v pos))
         (top (+ (rref rect :rect.top) 3))
         (left (+ (rref rect :rect.left) 3))
         (bottom (- (rref rect :rect.bottom) 3))
         (right (- (rref rect :rect.right) 3))
         (min-v (+ top 2))
         (min-h (+ left 2))
         (max-v (- bottom 2))
         (max-h (- right 2)))
    (setq flag
          (cond ((< pos-h left)    ;on left side
                 (cond
                  ((< pos-v top) (setq min-h -4095 min-v -4095) :topleft)
                  ((> pos-v bottom) (setq min-h -4095 max-v 4095) :bottomleft)
                  (t (setq min-h -4095 min-v 0 max-v 0) :left)))
                ((> pos-h right)   ;on right side
                 (cond
                  ((< pos-v top) (setq max-h 4095 min-v -4095) :topright)
                  ((> pos-v bottom) (setq max-h 4095 max-v 4095) :bottomright)
                  (t (setq max-h 4095 min-v 0 max-v 0) :right)))
                (t                 ;in the middle
                 (cond ((< pos-v top) (setq min-v -4095 min-h 0 max-h 0) :top)
                       (t (setq max-v 4095 min-h 0 max-h 0) :bottom)))))
    (with-focused-view window
      (with-pen-saved
        (#-carbon-compat let #-carbon-compat ((arect (rref (wptr window) :grafport.portrect)))
         #+carbon-compat rlet #+carbon-compat ((arect :rect))
         #+carbon-compat (#_getwindowportbounds (wptr window) arect) 
         (with-clip-rect arect
           (#_PenMode :word (position :patxor *pen-modes*))
           (#_PenPat :ptr *gray-pattern*)
           (#_FrameRect :ptr rect)
           (setq pos (make-point (max min-h (min max-h (point-h pos)))
                                 (max min-v (min max-v (point-v pos)))))
           (do* ((old-mouse pos new-mouse)
                 (new-mouse pos (view-mouse-position window)))
                ((not (mouse-down-p)))
             (setq new-mouse (make-point (max min-h (min max-h (point-h new-mouse)))
                                         (max min-v (min max-v (point-v new-mouse)))))
             (unless (eq old-mouse new-mouse)
               (#_FrameRect :ptr rect)
               (update-rect flag rect (subtract-points new-mouse old-mouse))
               (#_FrameRect :ptr rect)))
           (#_FrameRect :ptr rect)
           rect))))))

(defun update-rect (flag rect delta)
  (case flag
    (:left (rset rect :rect.left (+ (rref rect :rect.left) (point-h delta))))
    (:right (rset rect :rect.right (+ (rref rect :rect.right) (point-h delta))))
    (:top (rset rect :rect.top (+ (rref rect :rect.top) (point-v delta))))
    (:bottom (rset rect :rect.bottom (+ (rref rect :rect.bottom) (point-v delta))))
    (:topleft (update-rect :top rect delta) (update-rect :left rect delta))
    (:bottomright (update-rect :bottom rect delta) (update-rect :right rect delta))
    (:topright (update-rect :top rect delta) (update-rect :right rect delta))
    (:bottomleft (update-rect :bottom rect delta) (update-rect :left rect delta))))

(defmethod move-selected-dialog-items ((window window) where total-rect &aux
                                       (item-old-pos-a-list ())
                                       (constrained (shift-key-p))
                                       (wptr (wptr window))
                                       reg pos)
  (when (option-key-p)
    (duplicate-selected-dialog-items window))
  (rlet ((one-rect :rect))
    (dolist (item *selected-dialog-items*)
      (highlight-one-selected-item window item nil)
      (rset one-rect :rect.topleft (setq pos (view-position item)))
      (rset one-rect :rect.bottomright (add-points pos (view-size item)))
      (#_UnionRect :ptr one-rect
                   :ptr total-rect
                   :ptr total-rect)
      (push (cons item pos) item-old-pos-a-list)))
  (setq constrained
        (if constrained
            (if (eq (point-h where) (point-h (view-mouse-position window)))
                2   ;vertical constraint
                1)  ;horizontal constraint
            0))
  (unwind-protect
    (progn
      (setq reg (#_NewRgn))
      (#_RectRgn :ptr reg :ptr total-rect)
      (rlet ((slop-rect :rect))
        #-carbon-compat (copy-record (rref wptr windowRecord.portrect) :rect slop-rect)
        #+carbon-compat (#_getwindowportbounds wptr slop-rect) 
        (#_InsetRect :ptr slop-rect :word -10 :word -10)
        (rlet ((rect2 :rect))
          (declare (ignore-if-unused rect2))
          #+carbon-compat
          (#_getwindowportbounds wptr rect2)
          (setq pos 
                (#_DragGrayRgn reg where #-carbon-compat (rref wptr windowRecord.portrect) #+carbon-compat rect2
                 slop-rect
                 constrained
                 (ccl::%null-ptr))))))
    (when reg
      (#_DisposeRgn reg)
      (unless (eql -32768 (point-h pos))   ;some Mac magic number.  should be an equate
        (setq pos (best-guide-delta window total-rect pos))
        (dolist (item *selected-dialog-items*)
          (without-interrupts
           (set-view-position item (add-points pos (view-position item)))
           (invalidate-view item)
           (highlight-one-selected-item window item t)))
        (setq *dialog-change-undohook*
              (cons "Undo Move"
                    #'(lambda ()
                        (reset-selected-item-list window)
                        (dolist (item/pos item-old-pos-a-list)
                          (set-view-position (car item/pos) (cdr item/pos))
                          (select-dialog-item window (car item/pos))))))))))

(defmethod best-guide-delta ((window window) rect delta)
  (let* ((topleft (add-points delta (rref rect :rect.topleft)))
         (bottomright (add-points delta (rref rect :rect.bottomright)))
         (new-tl topleft)
         (new-br bottomright)
         (new-delta-h (point-h delta))
         (new-delta-v (point-v delta))
         temp1
         temp2)
    (setq topleft (guide-align window topleft))
    (setq bottomright (guide-align window bottomright))
    (if (neq (setq temp1 (point-v topleft))
             (setq temp2 (point-v new-tl)))
        (setq new-delta-v (+ new-delta-v (- temp1 temp2)))
        (when (neq (setq temp1 (point-v bottomright))
                   (setq temp2 (point-v new-br)))
          (setq new-delta-v (+ new-delta-v (- temp1 temp2)))))
    (if (neq (setq temp1 (point-h topleft))
             (setq temp2 (point-h new-tl)))
        (setq new-delta-h (+ new-delta-h (- temp1 temp2)))
        (when (neq (setq temp1 (point-h bottomright))
                   (setq temp2 (point-h new-br)))
          (setq new-delta-h (+ new-delta-h (- temp1 temp2)))))
    (make-point new-delta-h new-delta-v)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  code for adding dialog-items
;;


(defmethod duplicate-selected-dialog-items ((window window))
  (let ((new-items (copy-selected-dialog-items window)))
    (reset-selected-item-list window)
    (apply #'add-subviews window new-items)
    (dolist (item new-items)
      (select-dialog-item window item))))

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  item selection palette
;;

(defmethod initialize-instance ((palette item-palette) &rest initargs &key 
                                (window-show t))
  (declare (dynamic-extent initargs))
  (apply #'call-next-method
         palette
         :window-show nil
         :view-size *item-palette-size*
         :view-position *item-palette-position*
         initargs)
  (apply #'add-subviews
         palette
         *prototype-dialog-items*)
  (when (not (window-on-screen-p palette))
    (let* ((pos (view-position palette))
          (size (view-size palette))
          (h (point-h pos))
          (v (point-v pos)))
    (when (> (+ h (point-h size)) *screen-width*)
      (setq h (- *screen-width* (point-h size))))
    (when (> (+ v (point-v size)) *screen-height*)
      (setq v (- *screen-height* v))) 
    (set-view-position palette (make-point h v)))) 
  (when window-show
    (window-show palette))
  (setq *current-item-palette* palette))

(defmethod install-view-in-window :after (view (palette item-palette))
  (let* ((size (view-size palette))
         (view-br (add-points (view-position view) (view-size view)))
         (max-h (max (point-h size) (+ 5 (point-h view-br))))
         (max-v (max (point-v size) (+ 5 (point-v view-br)))))
    (unless (eql size (setq size (make-point max-h max-v)))
      (set-view-size palette size))))

(defmethod ccl::view-find-vacant-position ((palette item-palette) subview)
  (let ((size (view-size palette))
        (subview-size (view-outer-size subview)))
    (unless (>= (point-v size) (point-v subview-size))
      (setq size (set-view-size palette (point-h size) (+ 10 (point-v subview-size)))))    
    (progn      
      (let ((pos (call-next-method)))        
        (if (neq pos #@(0 0))
          pos
          (progn
            ;(setf (slot-value subview 'view-position) pos)
            (set-view-size palette 
                           (max (point-h size) (+ 5 (point-h subview-size)))
                           (+ (point-v size) (point-v subview-size) 12))
            (setf (slot-value subview 'view-position) nil)
            (setq pos (call-next-method))
            (while (eq pos #@(0 0))  ;; keep on growing till we win            
              (setq size (view-size palette))
              (set-view-size palette (point-h size)(+ (point-v size) 12))
              (setq pos (call-next-method)))
            pos))))))

(defmethod window-close-event-handler ((palette item-palette))
  (use-dialogs))

(defmethod window-close :before ((palette item-palette))
  (setq *current-item-palette* nil)
  (setq *item-palette-position* (view-position palette)
        *item-palette-size* (view-size palette)))

(defmethod view-click-event-handler ((palette item-palette) where)
  (let* ((item (find-view-containing-point palette where nil t)))
    (when item
      (select-and-add-dialog-item palette item where))))

(defmethod make-instance-from-prototype ((proto dialog-item) pos)
  (make-instance (type-of proto) :dialog-item-text "Untitled"
                 :view-position pos))

(defmethod make-instance-from-prototype ((proto proto-editable-text-dialog-item) pos)
  (make-instance 'editable-text-dialog-item :dialog-item-text "Untitled"
                 :view-position pos))

(defmethod make-instance-from-prototype ((proto pop-up-menu) pos)
  (make-instance 'pop-up-menu :item-display :selection
                                     :auto-update-default t
                                     :view-position pos))

(defmethod make-instance-from-prototype ((proto ccl::scrolling-fred-view) pos)
  (make-instance (class-of proto)
    :save-buffer-p t
    :wrap-p t
    :view-position pos :view-size (view-size proto)))
  

(defmethod select-and-add-dialog-item ((palette item-palette) item mouse-pos)
  (declare (optimize (debug 3)))
  (let* ((offset (view-position palette))
         (topleft (add-points offset (view-position item)))
         #-carbon-compat
         (bottomright  (add-points topleft (view-size item)))
         (reg (#_NewRgn))
         #-carbon-compat 
         (wmgrPort (window-manager-port))  ;; this won't work in OSX
         mouse-offset)
    (declare (ignore-if-unused mouse-offset))
    (setq mouse-pos (add-points mouse-pos offset)
          mouse-offset (subtract-points mouse-pos topleft))
    (unwind-protect
      #+carbon-compat
      (progn ;; done with drag and drop - requires control-key - why?
        )
      #-carbon-compat
      (with-port wmgrPort
        (rlet ((rect :rect
                     :topleft topleft
                     :bottomright bottomright))
          (#_RectRgn :ptr reg :ptr rect)            ;get a region of the item outline
          (with-macptrs ((visrgn (rref wmgrPort :grafport.visrgn)))
            (setf (pref rect :rect.topleft) (href visrgn :region.rgnBbox.topLeft))  ;; itsa handle schmuck
            (setf (pref rect :rect.bottomright) (href visrgn :region.rgnbbox.botRight)))
          (with-clip-rect rect
            (let* ((pos (add-points mouse-pos (#_DragGrayRgn reg
                                               mouse-pos
                                               rect
                                               rect
                                               0         ;not constrained
                                               (ccl::%null-ptr))))
                   (window (front-window))
                   (wpos (view-position window))
                   (size (add-points wpos (view-size window))))
              (when (and (ccl::editing-dialogs-p window)
                         (point>= pos wpos)
                         (point< pos size))
                (add-subviews 
                 window
                 (let ((pos (subtract-points (subtract-points pos wpos)
                                             mouse-offset)))
                   (make-instance-from-prototype item pos))))))))
      (#_DisposeRgn reg)))
  (menu-update (ccl::edit-menu )))


(defun point< (pt1 pt2)
  (and (< (point-h pt1) (point-h pt2))
       (< (point-v pt1) (point-v pt2))))

(defun point>= (pt1 pt2)
  (and (>= (point-h pt1) (point-h pt2))
       (>= (point-v pt1) (point-v pt2))))


(defun add-editable-dialog-item (proto-item)
  (let* ((class (class-of proto-item)))
    (when (member class *prototype-dialog-items* :key #'class-of)
      (remove-editable-dialog-item class))
    (push proto-item *prototype-dialog-items*)
    (when *current-item-palette*
      (add-subviews *current-item-palette* proto-item))))

(defun remove-editable-dialog-item (class)
  (let* ((item (find class *prototype-dialog-items* :key #'class-of)))
    (when item
      (setq *prototype-dialog-items*
            (delete item *prototype-dialog-items*))
      (when *current-item-palette*
        (remove-subviews *current-item-palette* item))
      (setf (slot-value item 'view-position) nil))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  dialog for creating new dialog windows
;;


(defmethod dialog-item-action :before ((button frame-window-r-b))
  (dialog-item-enable (find-named-sibling button 'item-close-box)))

(defmethod dialog-item-action :before ((button box-window-r-b))
  (let ((close-box (find-named-sibling button 'item-close-box)))
    (check-box-uncheck close-box)
    (dialog-item-disable close-box)))

(defun create-new-dialog ()
  (let* ((options nil))
    (setq *editing-dialogs* t)
    (unless *current-item-palette*
      (make-instance 'item-palette)
      ; let it be drawn
      (with-event-processing-enabled (event-dispatch)))
    (setq options
          (modal-dialog
           (make-instance
            'dialog
            :window-type :movable-dialog
            :window-title ""
            :view-position '(:top 100)
            :view-size #@(342 165)
            :window-show nil
            ;:back-color *tool-back-color*
            ;:content-color *tool-back-color*
            :theme-background t
            :view-subviews
            (list
             (make-dialog-item 'static-text-dialog-item
                               #@(3 3) #@(206 18)
                               "Select Dialog Window Options:")
             (make-dialog-item 'button-dialog-item
                               #@(269 140) #@(62 18) "OK"
                               #'(lambda (item)
                                   (let ((dialog (view-container item)))
                                     (return-from-modal-dialog
                                      (list
                                       (check-box-checked-p
                                        (view-named 'item-color-window dialog))
                                       (dialog-item-attribute
                                        (pushed-radio-button dialog))
                                       (check-box-checked-p
                                        (view-named 'item-close-box dialog))))))
                               :default-button t)
             (make-dialog-item 'button-dialog-item
                               #@(180 140) #@(62 18) "Cancel"
                               #'(lambda (item)
                                   (declare (ignore item))
                                   (return-from-modal-dialog :cancel)))
             (make-dialog-item 'check-box-dialog-item
                               #@(4 117) #@(139 17) "Include Close Box" nil
                               :check-box-checked-p t
                               :view-nick-name 'item-close-box)
             (make-dialog-item 'check-box-dialog-item
                               #@(4 140) #@(139 16) "Color Window" nil
                               :check-box-checked-p t
                               :view-nick-name 'item-color-window)
             (make-dialog-item 'frame-window-r-b
                               #@(4 26) #@(94 16) "Document" nil
                               :radio-button-pushed-p t
                               :attribute :document)
             (make-dialog-item 'frame-window-r-b
                               #@(4 49) #@(163 16) "Document with Grow" nil
                               :attribute :document-with-grow)
             (make-dialog-item 'frame-window-r-b
                               #@(4 71) #@(163 16) "Document with Zoom" nil
                               :attribute :document-with-zoom)             
             (make-dialog-item 'frame-window-r-b
                               #@(4 93) #@(72 16) "Tool" nil
                               :attribute :tool #+carbon-compat :dialog-item-enabled-p #+carbon-compat nil)
             (make-dialog-item 'box-window-r-b
                               #@(190 25) #@(133 17) "Single Edge Box" nil
                               :attribute :single-edge-box)
             (make-dialog-item 'box-window-r-b
                               #@(190 49) #@(130 16) "Double Edge Box" nil
                               :attribute :double-edge-box)
             (make-dialog-item 'box-window-r-b
                               #@(190 71) #@(134 16) "Shadow Edge Box" nil
                               :attribute :shadow-edge-box)
             (make-dialog-item 'box-window-r-b
                               #@(190 93) #@(134 16) "Movable Dialog" nil
                               :attribute :movable-dialog)))))
    #+carbon-compat (pop options)
    (make-instance #+carbon-compat 'ccl::drag-receiver-dialog
                   #-carbon-compat
                   (if (pop options)
                     'color-dialog
                     'dialog)
                   :window-type (pop options)
                   :close-box-p (pop options)
                   :view-size #@(300 150)
                   :view-position '(:top 60))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  code for editing features of a dialog
;;

(defmethod edit-dialog ((window window))
  (modal-dialog
   (make-instance 'dialog-editor
                  :dialog window)))


(defmethod initialize-instance ((editor dialog-editor) &rest initargs &key dialog)
  (declare (dynamic-extent initargs))
  (apply #'call-next-method
         editor
         :window-title (format nil "~s Dialog" (window-title dialog))
         initargs)
  (add-control-items editor dialog)
  (add-attribute-items editor dialog))

(defmethod add-control-items ((editor dialog-editor) dialog)
  (declare (ignore dialog))
  (add-subviews
   editor
   (make-dialog-item 'button-dialog-item
                     #@(310 72) #@(50 16) "OK"
                     #'(lambda (item &aux new-pos new-size title)
                         (let* ((editor (view-container item))
                                (dialog (dialog-editor-dialog editor)))
                           (setq new-pos
                                 (read-from-string
                                  (dialog-item-text
                                   (view-named 'item-view-position editor)))
                                 title 
                                 (dialog-item-text 
                                  (view-named 'item-title editor)))
                           (set-window-title dialog title)
                           (set-view-position dialog new-pos)
                           (setq new-size
                                 (ignore-errors
                                  (read-from-string
                                   (dialog-item-text (view-named 'size editor)))))
                           ; should warn if nil
                           (if new-size (set-view-size dialog new-size)))
                         (return-from-modal-dialog t))
                     :default-button t)
   (make-dialog-item 'button-dialog-item
                     #@(247 72) #@(50 16) "Cancel"
                     #'(lambda (item)
                         (declare (ignore item))
                         (return-from-modal-dialog :cancel)))))

(defmethod add-attribute-items ((editor dialog-editor) dialog)
  (let* ((the-pos (window-centered-p dialog)) (size (ppoint (view-size dialog))))
    (when (fixnump the-pos) (setq the-pos (ppoint the-pos)))
    (add-subviews
     editor
     (make-dialog-item 'static-text-dialog-item
                       #@(7 11) #@(92 15) "Window Title:")
     (make-dialog-item 'editable-text-dialog-item
                       #@(104 11) #@(252 16) (window-title dialog) nil
                       :allow-returns nil
                       :view-nick-name 'item-title)
     (make-dialog-item 'static-text-dialog-item
                       #@(7 42) #@(130 16) "Window Position:" nil)
     (make-dialog-item 'editable-text-dialog-item
                       #@(130 42) #@(105 16) (let ((*print-base* 10))
                                               (format nil "~s" the-pos)) nil
                       :view-nick-name 'item-view-position)
     (make-dialog-item 'static-text-dialog-item
                       #@(7 72) #@(130 16) "Window Size:" nil)
     (make-dialog-item 'editable-text-dialog-item
                       #@(130 72) #@(105 16) (let ((*print-base* 10))
                                               (format nil "~s" size)) nil
                       :view-nick-name 'size))))

#+carbon-compat
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :drag-and-drop))
#+carbon-compat
(progn
 ;; to do - change-class of drag-receiver-dialog back and forth when changing between use and design
 ;; but that's not possible cause we dunno which dialogs were once receivers and are no more
 ;; so just depend on *editing-dialogs* ?? or who cares because the palette ain't there but ...
  
(defclass ccl::drag-receiver-dialog (color-dialog drag-view-mixin)
  ()
  (:default-initargs
    :drag-allow-copy-p nil
    :drag-allow-move-p nil
    :drag-auto-scroll-p nil
    :drag-accepted-flavor-list :|view|
    )
  )

(defclass item-palette (windoid non-editable-dialog drag-view-mixin)
  ()
  (:default-initargs :window-title "Palette"))


(defmethod drag-receive-dropped-flavor ((view ccl::drag-receiver-dialog)
                                        (flavor (eql :|view|))
                                        (data-ptr simple-view) (data-size integer)
                                        (item-reference integer))
  (declare (ignore data-size item-reference))
  (let* ((drag-pos (drag-mouse-original-position (view-window data-ptr)))
         (drop-pos (drag-mouse-drop-position view))
         (old-view-pos (convert-coordinates (view-position data-ptr) 
                                            (view-container data-ptr)
                                            (VIEW-WINDOW DATA-PTR)))
         (offset (subtract-points drag-pos old-view-pos))
         )
    (add-subviews view (make-instance-from-prototype data-ptr (subtract-points drop-pos offset))))
  t)

;; maybe dont need these now
(defmethod make-instance-from-prototype ((view fred-item) pos)
  (make-instance-from-prototype (view-container view) pos))

;; don't want lonely scroll-bars
(defmethod make-instance-from-prototype ((view ccl::fred-h-scroll-bar) pos)
  (make-instance-from-prototype (view-container view) pos))
(defmethod make-instance-from-prototype ((view ccl::fred-v-scroll-bar) pos)
  (make-instance-from-prototype (view-container view) pos))



(defun view-position-in-window (view)
  (let* ((container (view-container view))
         (window (view-window view)))
    (convert-coordinates (view-position view) container window)))
      

(defmethod drag-add-drag-contents ((view item-palette))
  (when *mouse-view*
    (let* ((view-region (new-region))
           ;; use container to get whole scrolling fred view
           (the-view (if (eq (view-container *mouse-view*) view) *mouse-view* (view-container *mouse-view* )))
           (position (view-position-in-window the-view))
           (size (view-size the-view))
           (bounds (add-points position size)))
      (drag-add-mcl-object-flavor 1 :|view| the-view)
      (unwind-protect
        (progn
          (set-rect-region view-region
                           (point-h position) (point-v position)
                           (point-h bounds) (point-v bounds))
          (drag-create-item-bounds view 1 view-region))
        (dispose-region view-region))))
  t)

(defmethod drag-selection-p ((view item-palette) local-mouse-position)
  (declare (ignore local-mouse-position))
  (and (not (typep *mouse-view* 'window))
       ;(command-key-p)
       ;(control-key-p)  ;; why did we do this?
       ))

(defmethod window-is-drag-proxy ((w item-palette)) w)
(defmethod window-is-drag-proxy ((w ccl::drag-receiver-dialog)) w)
(defmethod window-is-drag-proxy ((w window)) nil)


;; ?? 
(defmethod drag-proxy ((view simple-view))
  (let ((window (view-window view)))
    (window-is-drag-proxy window)))

;; stuff below from Shannon Spires
;;; Makes it possible to drag IFT items into windows that were not created with IFT when
;;;   drag & drop is handling drags. It's a Carbon thing.

(defun ccl::make-programmatic-class (name superclass-list 
                                          &key (metaclass 'standard-class)
                                          (slots nil)) ; use the slots arg to create new slots
  (let ((newclass
         (make-instance metaclass ;   all the superclasses
           :name name
           :direct-superclasses superclass-list
           :direct-slots (when slots
                           (cons nil slots))) ; I don't know why
         ;           I have to cons nil here, but I do in MCL
         ))
    (setf (find-class name) newclass) ; Make sure find-class can find it
    newclass))

(defun ccl::ensure-dynamic-class (class1 class2)
  "Looks for a class that inherits from precisely class1 and class2
   in that order. If it can't find one, it makes one. New name becomes
   concatenation of class1 and class2 in class1's package."
  (flet ((symbolic-name (class)
           (if (symbolp class)
             class
             (class-name class)))
         (true-class (class)
           (if (typep class 'standard-class)
             class
             (find-class class))))
    
    (let* ((newname (intern (concatenate 'string
                                         (string (symbolic-name class1))
                                         "/"
                                         (string (symbolic-name class2)))
                            (symbol-package (symbolic-name class1)))))
      (or (find-class newname nil)
          
          (ccl::make-programmatic-class
           newname
           (list (true-class class1) (true-class class2)))
          
          ; we don't need no steenking evals
          ;(eval `(defclass ,newname (,(symbolic-name class1) ,(symbolic-name class2)) ()))
          ))))
              
(defmethod maybe-become-ift-drag-target ((w window))
  (when (ccl::editing-dialogs-p w)
    (unless (typep w 'ccl::drag-receiver-dialog)
      (change-class w (ccl::ensure-dynamic-class 'ccl::drag-receiver-dialog
                                                 (class-of w)
                                                 )
                    :drag-accepted-flavor-list (list :|view|) ; is this even necessary?
                    )
      (view-activate-event-handler w) ; ensure the window gets put on the *drag-&-drop-window-list*
      ; Yes, we really do have to re-call view-activate-event-handler even if
      ;  it called us, because of the change-class. 
      )))



; Handle other case where user creates a new, non-editable (yet) window and *editing-dialogs* is already t
(let ((*warn-if-redefine-kernel* nil))
  (defmethod ccl::view-activate-event-handler :before ((w window))
    (view-remprop w :display-in-menu-when-hidden)
    (when ccl::*foreground*
      (ccl::hilite-wptr (wptr w) t)
      (window-draw-grow-icon w)
      (maybe-become-ift-drag-target w) ; new
      )))

)

#+ignore ; moved to pop-up-menu
;; trying to avoid leaving turds when move or resize - ugh
(defmethod view-corners ((item pop-up-menu))
  (if (and (ccl::osx-p)(ccl::control-handle item)) ;(ccl::editing-dialogs-p (view-window item)))
    (multiple-value-bind (tl br) (call-next-method)
      (values (subtract-points tl #@(2 2)) (add-points br #@(4 4))))
    (call-next-method)))

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
