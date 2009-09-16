;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; platinum-pop-up-menus.lisp
;;;
;;; OS8-STYLE 3D POPUP MENUS
;;;
;;; Copyright ©1997-1998
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
;;; Authors: Eric Russell <eric-r@nwu.edu>,
;;;          Terje Norderhaug <terje@in-progress.com> of Media Design in*Progress
;;; 
;;; When *appearance-available-p* is non-nil and *appearance-
;;; compatibility-mode-p* is nil, all pop-up-menus will be drawn
;;; with the new, OS 8, "platinum" appearance. Now just tests for
;;; appearance-available-p. The part colors 
;;; :menu-body and :menu-title will apply only to the title displayed 
;;; to the left of the menu. Actually now the :menu-title color also
;;; applies to the menu text in the body and :menu-body color overrides 
;;; the so-called platinum color. All pull down menus will be drawn
;;; with the "platinum" background color and 3D hilites.
;;; Now pull-down-menus are unaffected by this file.
;;;

;; 11/08/02 akh fix to deduce icon-type if possible - from Terje N.
;; -------- 4.4b5
;; 02/10/02 akh add icon if any from Terje N.
;;; 12/15/01 akh fix goof in maybe-draw-new-pop-up re pull-down
;; Somewhat modified by akh@tiac.net to use advise vs copying existing code which
;; changes from time to time. Also added knowledge of some colors to draw-new-pop-up-menu.
;; (:menu-body, :menu-title, :menu-frame, :title-background)


(in-package :ccl)

;; this file is superseded by the following setting
(setq *use-pop-up-control* t)

#|
;;;----------------------------------------------------------------------
;;; Requirements

(let* ((path (pathname *loading-file-source-file*))
       (dirpath (make-pathname :directory (pathname-directory path)
                               :host (pathname-host path)
                               :name nil
                               :type nil
                               :defaults nil)))
  (pushnew dirpath *module-search-path* :test #'equalp))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :pop-up-menu)
  (require :appearance-globals)
  ;(require :appearance-manager)
  )

(setq *draw-inactive-dialog-items-as-disabled* nil) ;; doesnt appeal to me this week (akh)



;;;----------------------------------------------------------------------
;;; Redefine the draw, default-size, and size-rectangle methods to 
;;; dispatch to new functions

#|
(let ((*warn-if-redefine*        nil)
      (*warn-if-redefine-kernel* nil))

  ;; Not needed now. Original changed to work in either case without knowledge of which case.
  (defmethod menu-select ((menu typein-menu-menu) num)
    (declare (ignore num))
    (let ((num (pop-up-menu-default-item menu)))
      (if (and num (> num 1))
        (call-next-method)      
        (let* ((c (view-container menu))
               (pos (typein-menu-menu-position c))
               (view-pos (view-position menu))
               (w (- (point-h (view-size menu)) 2))
               (tl view-pos)
               (br (make-point (point-h (view-size c)) 1))
               t-pos t-w)
          (when (eq pos :left)
            (let ((text (typein-editable-text c)))
              (setq t-pos (subtract-points (view-position text) #@(2 2)))
              (setq t-w (+  (point-h (view-size text)) 3))
              (setq tl #@(0 0))))
          (rlet ((rect :rect :topleft tl :bottomright br))
            ; erase top edge which is not obscured by the menu contents
            (unless (appearance-available-p)
              (#_eraserect rect))
            (call-next-method)
            ; restore top edge
            (if (menu-enabled-p menu)
              (unless (appearance-available-p)                 
                (#_moveto :long view-pos)
                (#_line :word w :word 0)
                (when (eq pos :left)
                  (#_moveto :long t-pos)
                  (#_line :word t-w :word 0)))
              (invalidate-corners c tl br)))))))

)
|#

(advise (:method view-draw-contents (pop-up-menu)) (or (maybe-draw-new-pop-up (car arglist)) (:do-it))
        :when :around :name draw-pop-up)

(defun maybe-draw-new-pop-up (menu)
  (when (and (appearance-available-p)
             (not (typep menu 'pull-down-menu))
             (or (not (fboundp 'control-handle))(not (funcall 'control-handle menu))))
    ;; dont mess with pull-down menus - If I want a gray one I'll say so.
    ;; They are intended to look like menus in the menubar which do not have any
    ;; shading or other embellishments.
    (new-draw-pop-up-menu menu)
    t))

(advise (:method view-default-size (pop-up-menu)) (let ((size (:do-it)))
                                                    (if (and (appearance-available-p) 
                                                             (or (not (fboundp 'control-handle))(not (funcall 'control-handle (car arglist)))))
                                                      (adjust-default-size (car arglist) size)
                                                      size))
        :when :around :name size-pop-up)


  

;;;----------------------------------------------------------------------
;;; Code copied from "ccl:library;pop-up-menu.lisp"

;; the pop-up-menu.lisp code is no longer copied

;;;----------------------------------------------------------------------
;;; New code (derived from the original view-draw-contents).
#|
(defun new-draw-pop-up-menu (menu)
  (let* ((text         (menu-title menu))
         (ti-rect      (pop-up-menu-title-rect menu))
         (no-title     (equal text ""))
         (enabled      (and (menu-enabled-p menu)
                            (or (not *draw-inactive-dialog-items-as-disabled*)
                                (window-active-p (view-window menu)))))
         (colorp       (and (color-or-gray-p menu) (window-color-p (view-window menu))))
         (pull-down-p  (pull-down-menu-p menu))
         (disabled-color (if (and (not enabled) colorp)
                           +shadow-color+))
         (title-color (or disabled-color
                          (part-color menu :menu-title))))
    (with-focused-dialog-item (menu)
      (multiple-value-bind (ascent descent width) (view-font-codes-info menu)
        (declare (ignore descent))
        (rlet ((a-rect :rect))
          (copy-record (pop-up-menu-rect menu) :rect a-rect)
          (let* ((mi-title      (get-menu-body-text menu))
                 (left          (rref a-rect rect.left))
                 (top           (rref a-rect rect.top))
                 (right         (- (rref a-rect rect.right) 1))
                 (bottom        (- (rref a-rect rect.bottom) 1))
                 (arrow-width   (+ (- bottom top) 4))
                 (text-baseline (+ top ascent 1)))
            (declare (fixnum left top right bottom arrow-width text-baseline))
            ; Draw the title
            ;
            (unless no-title
              (with-fore-color title-color
                (with-back-color (part-color menu :title-background)
                  (#_EraseRect :ptr ti-rect)
                  (#_MoveTo :word (+ (rref ti-rect rect.left) 3) :word text-baseline)
                  (with-pstrs ((di-title text))
                    (#_DrawString :ptr di-title)))))
            (with-fore-color (if (and (not enabled) colorp)
                               +shadow-color+
                               *black-color*)
              (with-back-color (or (getf (slot-value menu 'color-list) :menu-body) +background-color+)
                (unless pull-down-p
                  (#_InsetRect :ptr a-rect :long #@(1 1)))                
                (#_FillRect :ptr a-rect :ptr *white-pattern*)
                (unless pull-down-p
                  (draw-triangle-box (max (- right arrow-width) left) 
                                     (+ top 1)
                                     (- right 1) 
                                     (- bottom 1)
                                     colorp
                                     enabled))                
                (cond ((not pull-down-p)
                       (with-fore-color (part-color menu :menu-frame)                         
                         (#_MoveTo :word (+ left 2)  :word  top)
                         (#_LineTo :word (- right 2) :word  top)
                         (#_LineTo :word  right      :word (+ top 2))
                         (#_LineTo :word  right      :word (- bottom 2))
                         (#_LineTo :word (- right 2) :word  bottom)
                         (#_LineTo :word (+ left 2)  :word  bottom)
                         (#_LineTo :word  left       :word (- bottom 2))
                         (#_LineTo :word  left       :word (+ top 2))
                         (#_LineTo :word (+ left 2)  :word  top))
                       (when (and colorp (< left (- right arrow-width 2))) ;; akh added 2 here for typein-menu-menu
                         (with-fore-color +light-shadow-color+
                           (#_MoveTo (- right arrow-width) (+ top    1))
                           (#_LineTo (- right arrow-width) (- bottom 1))
                           (when enabled
                             (#_LineTo (+ left 2) (- bottom 1))))
                         (when enabled
                           (with-fore-color *white-color*
                             (#_MoveTo (+ left 2) (+ top 1))
                             (#_LineTo (- right arrow-width) (+ top 1)) 
                             (#_MoveTo (+ left 1) (+ top 2))
                             (#_LineTo (+ left 1) (- bottom 2))
                             ))))
                      (t ;; never happens today
                       #-ignore (error "shouldnt")
                       #+ignore
                       (when colorp
                         (with-fore-color *white-color*
                           (#_MoveTo :word left  :word top)
                           (#_LineTo :word right :word top)
                           (#_MoveTo :word left  :word (- bottom 2))
                           (#_LineTo :word left  :word top))
                         (with-fore-color +light-shadow-color+
                           (#_MoveTo :word left  :word (1- bottom))
                           (#_Lineto :word right :word (1- bottom))))
                       #+ignore
                       (when (crescent menu)
                         (draw-crescent top left colorp))))
                (#_InsetRect :ptr a-rect :long #@(1 1))
                (with-fore-color title-color
                  (let* ((text-left     (+ (rref a-rect rect.left) (if pull-down-p 6 (max 6 width)))))
                    (#_MoveTo :word text-left :word text-baseline)                    
                    (with-clip-rect-intersect a-rect
                      (draw-string-crop mi-title (- right text-left (if pull-down-p 0 arrow-width))))))
                ))))
        (unless (or enabled colorp)
          (paint-menu-gray menu))))))
|#

;; from Terje N - slightly modified - does icons
(defun new-draw-pop-up-menu (menu)
  (let* ((text         (menu-title menu))
         (ti-rect      (pop-up-menu-title-rect menu))
         (no-title     (equal text ""))
         (enabled      (and (menu-enabled-p menu)
                            (or (not *draw-inactive-dialog-items-as-disabled*)
                                (window-active-p (view-window menu)))))
         (colorp       (and (color-or-gray-p menu) (window-color-p (view-window menu))))
         (pull-down-p  (pull-down-menu-p menu))
         (disabled-color (if (and (not enabled) colorp)
                           +shadow-color+))
         (title-color (or disabled-color
                          (part-color menu :menu-title))))
    (with-focused-dialog-item (menu)
      (multiple-value-bind (ascent descent width) (view-font-codes-info menu)
        (declare (ignore descent))
        (rlet ((a-rect :rect))
          (copy-record (pop-up-menu-rect menu) :rect a-rect)
          (let* ((mi-title      (get-menu-body-text menu))
                 (left          (rref a-rect rect.left))
                 (top           (rref a-rect rect.top))
                 (right         (- (rref a-rect rect.right) 1))
                 (bottom        (- (rref a-rect rect.bottom) 1))
                 (arrow-width   (+ (- bottom top) 4))
                 (center (1+ (floor (+ top bottom) 2)))
                 (text-baseline (max (+ center (floor ascent 2) -2)
                                     (+ top ascent 1))))
            ;     (text-baseline (+ top ascent 1)))
            (declare (fixnum left top right bottom arrow-width text-baseline))
            ; Draw the title
            ;
            (unless no-title
              (with-fore-color title-color
                (with-back-color (part-color menu :title-background)
                  (#_EraseRect :ptr ti-rect)
                  (#_MoveTo :word (+ (rref ti-rect rect.left) 3) :word text-baseline)
                  (with-pstrs ((di-title text))
                    (#_DrawString :ptr di-title)))))
            (with-fore-color (if (and (not enabled) colorp)
                               +shadow-color+
                               *black-color*)
              (with-back-color (or (getf (slot-value menu 'color-list) :menu-body) +background-color+)
                (unless pull-down-p
                  (#_InsetRect :ptr a-rect :long #@(1 1)))
                (#_FillRect :ptr a-rect :ptr *white-pattern*)
                (unless pull-down-p
                  (draw-triangle-box (max (- right arrow-width) left)
                                     (+ top 1)
                                     (- right 1)
                                     (- bottom 1)
                                     colorp
                                     enabled))
                (cond ((not pull-down-p)
                       (with-fore-color (part-color menu :menu-frame)

                         (#_MoveTo :word (+ left 2)  :word  top)
                         (#_LineTo :word (- right 2) :word  top)
                         (#_LineTo :word  right      :word (+ top 2))
                         (#_LineTo :word  right      :word (- bottom 2))
                         (#_LineTo :word (- right 2) :word  bottom)
                         (#_LineTo :word (+ left 2)  :word  bottom)
                         (#_LineTo :word  left       :word (- bottom 2))
                         (#_LineTo :word  left       :word (+ top 2))
                         (#_LineTo :word (+ left 2)  :word  top))
                       (when (and colorp (< left (- right arrow-width 2))) ;; akh added 2 here for typein-menu-menu
                         (with-fore-color +light-shadow-color+
                           (#_MoveTo (- right arrow-width) (+ top    1))
                           (#_LineTo (- right arrow-width) (- bottom 1))
                           (when enabled
                             (#_LineTo (+ left 2) (- bottom 1))))
                         (when enabled
                           (with-fore-color *white-color*
                             (#_MoveTo (+ left 2) (+ top 1))
                             (#_LineTo (- right arrow-width) (+ top 1))
                             (#_MoveTo (+ left 1) (+ top 2))
                             (#_LineTo (+ left 1) (- bottom 2))
                             ))))
                      (t ;; never happens today
                       #-ignore (error "shouldnt")
                       #+ignore
                       (when colorp
                         (with-fore-color *white-color*
                           (#_MoveTo :word left  :word top)
                           (#_LineTo :word right :word top)
                           (#_MoveTo :word left  :word (- bottom 2))
                           (#_LineTo :word left  :word top))
                         (with-fore-color +light-shadow-color+
                           (#_MoveTo :word left  :word (1- bottom))
                           (#_Lineto :word right :word (1- bottom))))
                       #+ignore
                       (when (crescent menu)
                         (draw-crescent top left colorp))))
                (#_InsetRect :ptr a-rect :long #@(1 1))
                (with-fore-color title-color
                  (let* ((text-left     (+ (rref a-rect rect.left) (if pull-down-p 6 (max 6 width))))
                         (selection (pop-up-menu-default-item menu))
                         (item (when (and selection (plusp selection))
                                 (nth (1- (pop-up-menu-default-item menu))
                                      (menu-items menu))))
                         (icon (when (and item (eq (pop-up-menu-item-display menu) :selection))
                                 (or (menu-item-icon-num item)
                                     (menu-item-icon-handle item)))))
                    (with-clip-rect-intersect a-rect
                      (when (and icon (neq icon 0))
                        (setf text-left (+ (rref a-rect rect.left) 4))
                        ;; below may not be right for some icon-types - not all are 16X16 but do seem to shrink to fit
                        (rlet ((icon-rect :rect
                                          :left text-left
                                          :top (- center 8)
                                          :right (+ text-left 16)
                                          :bottom (+ center 8)))
                          (if (fixnump icon)
                            (with-macptrs ((resource (%null-ptr)))
                              (without-interrupts
                               (%setf-macptr resource (#_geticon icon))
                               (unless (%null-ptr-p resource)
                                 (#_ploticon icon-rect resource))))                            
                            (if (handlep icon)
                              (let ((icon-type (or (menu-item-icon-type item)
                                                   (get-icon-type-num (menu-item-icon-handle item)))))
                                (cond ((memq icon-type '(#.#$kMenuShrinkIconType  #.#$Kmenuicontype))
                                       (#_ploticon icon-rect icon))
                                      ((eq icon-type #$kMenuColorIconType)
                                       (#_plotcicon icon-rect icon))
                                      ((eq icon-type #$kMenuIconSuiteType)
                                       (#_PlotIconSuite
                                        icon-rect
                                        #$kAlignAbsoluteCenter
                                        #$kTransformNone
                                        icon))
                                      ((eq icon-type #$kMenuSmallIconType)
                                       (#_PlotSICNHandle
                                        icon-rect
                                        #$kAlignAbsoluteCenter
                                        #$kTransformNone
                                        icon))))))
                            ;; see above
                            (incf text-left (+ 16 5))))
                      (#_MoveTo :word text-left :word text-baseline)

                      (draw-string-crop mi-title (- right text-left (if pull-down-p 0 arrow-width))))))
                ))))
        (unless (or enabled colorp)
          (paint-menu-gray menu))))))

#|
(defun new-pop-up-menu-default-size (menu)
  (multiple-value-bind (ff ms) (view-font-codes menu)
    (let* ((item-display (slot-value menu 'item-display))
           (max-menu-width (max 10 (if (stringp item-display)
                                     (font-codes-string-width item-display ff ms)
                                     (if (and (eq item-display :selection)
                                              (not (menu-items menu)))
                                       (font-codes-string-width  "<no items>" ff ms)
                                       0))))
           (title (menu-title menu))
           (title-width (if (eq 0 (length title)) 0 (font-codes-string-width title ff ms))))
      (setq max-menu-width
            (+ (if (eq 0 title-width) 9 18)
               ; we used to dolist always
               (if (eq item-display :selection)
                 (let ((item-max (max-menu-width menu)))
                   (if (> item-max max-menu-width)
                     item-max
                     max-menu-width))
                 max-menu-width)))
      (multiple-value-bind (ascent descent width leading) (font-codes-info ff ms)
        (let* ((size-v (max 16 (+ ascent descent (max 1 leading) 4)))
               (size-h (+  title-width
                           max-menu-width 
                           (if (pull-down-menu-p menu) 
                             5 
                             (+ width size-v 4)))))
          (make-point size-h size-v))))))
|#

(defmethod adjust-default-size ((pop-up pop-up-menu) size)  
  (let* ((h (point-h size))
         (v (point-v size)))
    (multiple-value-bind (a d w l)(view-font-codes-info pop-up)
      (declare (ignore a d w))
      (if (eq l 0)(incf v)) ;; ??
      (setq v (max 16 v))
      (incf h (+ v 4 -12 )))
    (make-point h v)))

(defmethod adjust-default-size ((pull-down pull-down-menu) size)
  size)


;;;----------------------------------------------------------------------
;;; Invalidate ourselves when activated or deactivated, if we'll need
;;; to be redrawn.

(defmethod view-activate-event-handler ((menu pop-up-menu))
  (when (and (appearance-available-p)
             ;(not *appearance-compatibility-mode-p*)
             *draw-inactive-dialog-items-as-disabled*)
    (invalidate-view menu))
  (call-next-method))

(defmethod view-deactivate-event-handler ((menu pop-up-menu))
  (when (and (appearance-available-p)
             ;(not *appearance-compatibility-mode-p*)
             *draw-inactive-dialog-items-as-disabled*)
    (invalidate-view menu))
  (call-next-method))

;;;----------------------------------------------------------------------
;;; Support functions for new drawing code

(defun draw-triangle-box (left top right bottom color-p enabled-p)
  (with-fore-color (if (and color-p (not enabled-p))
                     +shadow-color+
                     *black-color*)
    (draw-triangles left top right bottom))
  (when (and color-p enabled-p)
    (draw-box left top right bottom)))

(defun draw-triangles (left top right bottom) 
  (let* ((triangle-height (if (> (- bottom top) 14) 10 8))
         (triangle-width  (if (eq triangle-height 10) 7 5)))
    (#_MoveTo 
     (+ left (ash (- right left triangle-width 5)  -1) 3)
     (+ top  (ash (- bottom top triangle-height 4) -1) 2))
    (cond ((eq triangle-height 10) ; Big triangles
           (#_Move :long #@( 3 0))
           (#_Line :long #@( 1 1))
           (#_Line :long #@(-2 0))
           (#_Line :long #@(-1 1))
           (#_Line :long #@( 4 0))
           (#_Line :long #@( 1 1))
           (#_Line :long #@(-6 0))
           (#_Move :long #@( 0 3))
           (#_Line :long #@( 6 0))
           (#_Line :long #@(-1 1))
           (#_Line :long #@(-4 0))
           (#_Line :long #@( 1 1))
           (#_Line :long #@( 2 0))
           (#_Line :long #@(-1 1)))
          ((eq triangle-height 8)   ; Small triangles
           (#_Move :long #@( 2 0))
           (#_Line :long #@( 1 1))
           (#_Line :long #@(-2 0))
           (#_Line :long #@(-1 1))
           (#_Line :long #@( 4 0))
           (#_Move :long #@( 0 3))
           (#_Line :long #@(-4 0))
           (#_Line :long #@( 1 1))
           (#_Line :long #@( 2 0))
           (#_Line :long #@(-1 1))))))
  
(defun draw-box (left top right bottom)
  (with-fore-color +background-color+
    (#_MoveTo :word left :word top)
    (#_LineTo :word left :word top))
  (with-fore-color *white-color*
    (#_MoveTo :word (+ left 2)  :word (- bottom 2))
    (#_LineTo :word (+ left 2)  :word (+ top 1))
    (#_LineTo :word (- right 2) :word (+ top 1)))
  (with-fore-color +dark-background-color+
    (#_MoveTo :word (- right 1) :word  top)
    (#_LineTo :word (- right 1) :word  top)
    (#_MoveTo :word (+ left 1)  :word  bottom)
    (#_LineTo :word (+ left 1)  :word  bottom))
  (with-fore-color +light-shadow-color+
    (#_MoveTo :word  right      :word (+ top 1))
    (#_LineTo :word (- right 1) :word (+ top 2))
    (#_LineTo :word (- right 1) :word (- bottom 2))
    (#_MoveTo :word (- right 2) :word (- bottom 1))
    (#_LineTo :word (+ left 3)  :word (- bottom 1)))
  (with-fore-color +dark-shadow-color+
    (#_MoveTo :word (+ left 2)  :word  bottom)
    (#_LineTo :word (- right 1) :word  bottom)
    (#_LineTo :word (- right 1) :word (- bottom 1))
    (#_LineTo :word  right      :word (- bottom 1))
    (#_LineTo :word  right      :word (+ top 2))))

;; not called today
#+ignore
(defun draw-crescent (left top colorp)
  (cond (colorp
         (with-fore-color *black-color*
           (#_MoveTo :word left :word top)
           (dolist (length '(4 3 2 0 0))
             (#_Line :word length     :word 0)
             (#_Move :word (- length) :word 1)))
         (with-fore-color +very-dark-shadow-color+
           (#_MoveTo :word (+ left 5) :word  top)
           (#_Line   :word  0         :word  0)
           (#_MoveTo :word  left      :word (+ top 5))
           (#_Line   :word  0         :word  0)
           (#_MoveTo :word (+ left 1) :word (+ top 3))
           (#_LineTo :word (+ left 3) :word (+ top 1)))
         (with-fore-color +light-shadow-color+
           (#_MoveTo :word (+ left 6) :word  top)
           (#_Line   :word  0         :word  0)
           (#_Moveto :word (+ left 4) :word (+ top 1))
           (#_Line   :word  0         :word  0)
           (#_MoveTo :word (+ left 1) :word (+ top 4))
           (#_Line   :word  0         :word  0)
           (#_MoveTo :word  left      :word (+ top 6))
           (#_Line   :word  0         :word  0))
         (with-fore-color +background-color+
           (#_MoveTo :word (+ left 7) :word  top)
           (#_Line   :word  0         :word  0)
           (#_MoveTo :word  left      :word (+ top 7))
           (#_Line   :word  0         :word  0))
         (with-fore-color *white-color*
           (#_MoveTo :word (+ left 1) :word (+ top 7))
           (#_LineTo :word (+ left 1) :word (+ top 5))
           (#_LineTo :word (+ left 5) :word (+ top 1))
           (#_LineTo :word (+ left 7) :word (+ top 1))))
        (t
         (#_moveto :word left :word top)
         (dolist (length '(5 3 2 1 0 0))
           (#_line :word length :word 0)
           (#_move :word (- length) :word 1)))))

;;;----------------------------------------------------------------------

|#

(provide :platinum-pop-up-menus)