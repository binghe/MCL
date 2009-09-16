;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 10/5/97  akh  see below
;;  5 6/9/97   akh  moved some stuff
;;  14 1/22/97 akh  change remove-ordered-subview  to put mini-buffer last to avoid double redraw in some cases
;;  12 9/13/96 akh   split pane - only put splitters in new where exist in original.
;;  11 7/18/96 akh  fred-update in view-click... poof-button
;;  8 3/9/96   akh  poof button and bar-draggers get cursors
;;  6 12/1/95  akh  %i+
;;  5 11/17/95 akh  color-patch from Kalman - in case no color
;;  2 10/17/95 akh  merge patches
;;  18 6/10/95 akh  buffer-color-vector - nil if start = end and color 0
;;  17 6/9/95  akh  use *mini-buffer-font-spec*
;;  16 6/7/95  akh  delegate window-selection-stream
;;  15 5/19/95 akh  kill-erase-region check for nil
;;  14 5/15/95 akh  bills fix to buffer-color-vector
;;                  fix mini-buffer package to use *package* of window-process
;;  12 5/8/95  akh  maybe no change
;;  11 5/4/95  akh  no more %ilogand of ff. comment below belongs elsewhere
;;  10 5/4/95  akh  frec-screen-line-vpos checks if up to date cause called by fred-line-vpos which is documented
;;  9 5/4/95   akh  :direction initarg => :split-view-direction
;;  8 5/1/95   akh  fix some mini-buffer things so no error if user deletes something
;;  5 4/24/95  akh  more initargs for fred-window, 
;;                  dont error if no h-scrollp - but omitting scroll bars really doesnt work
;;  4 4/10/95  akh  fred-window takes :comtab initarg
;;  3 4/7/95   akh  delegated selection-range method was wrong
;;  2 4/4/95   akh  add fred-delegation-mixin stuff
;;  11 3/22/95 akh  add window-show-cursor for fred-window
;;  10 3/20/95 akh  let margin default (to 3)
;;  9 3/14/95  akh  delegator for fred-word-wrap-p was wrong
;;  8 2/27/95  slh  stream-filename mod.
;;  7 2/17/95  akh  use accessors vs slot-value
;;  6 2/3/95   akh  added bills color stuff
;;  4 1/17/95  akh  mini-buffer-update doesnt if no mini-buffer
;;  3 1/13/95  akh  set-mini-buffer doesnt when wptr is nil
;;  (do not edit before this line!!)

; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2007 Digitool, Inc.

; new-fred-window.lisp
;


; split pane - only put splitters in new where exist in original.
; new file - a fred-window is now a split-view initially containing two scrolling-
; fred-views. The lower one is the mini-buffer.

; a split view has a direction and n subviews all the same height or width
; direction vertical means all same width and vertically stacked
; horizontal means all same height and horizontally stacked

; a dragger has a direction and intuits the controlled views


;;;;;;;;;;;;;;;;;;;;;;;
;
; Modification History

;; fred-update of window-fred-item doesn't need to map-frecs
;; initialize-window :after for fred-window does the ed-xform-crlf task if need be.
;; ------- 5.2b5
;; define and call application-pathname-to-window-title
;; add-window-proxy-icon only done once, remember fsref of file
;; ------- 5.2b3
;; change ed-yank-file - hasn't worked post MCL 5.0 , no one has complained - new version different
;; add method add-window-proxy-icon - use it ?
;; ---- 5.2b1
;; convert-char-to-unicode - error vs crash if conversion fails.
;; insetrect :ptr p .. -> insetrect p ..
;; set-window-title-cfstring is a method
;; minor simplification to window-key-handler
;; buffer-color-vector fix for nfonts > 128
;; fix set-window-title - use cfstr if not 7bit-ascii-p
; small change to convert-char-to-unicode
; -------- 5.1 final
; use with-pen-saved-simple, fix usage of wait-mouse-up-or-moved in track-and-draw
; --------- 5.1b3
; theme-background only #$kThemeBrushDocumentWindowBackground if required by #$kWindowMetalAttribute 
; *metallic-fred-windows* initially nil
; *live-resize-fred-windows* initially true - only works on OSX
;; fiddle with color of active poof-button
;; small change to split-pane if osx-p
; new variable *metallic-fred-windows* - if true fred-windows are "metallic", i.e. can drag by borders - cool, title bar darker - who knows
; poof-button draws gray if inactive
; ------- 5.1b2
; 04/29/04 poof button gets gray background
; 04/08/04 use wait-mouse-up-or-moved vs mouse-down-p
;; 03/18/04 simplify track-and-draw
; 12/02/03 timer stuff
; use new-with-pointer
; mess with set-window-title-cfstring
; set-window-title does encoded strings
;; --------- 5.0release
; add stuff for modified dot in close bubble
; 5.0b5 or 6
; make track-and-draw more lively on OSX - from toomas altosaar
; --------- 4.4b5
; fix to maybe-un-poof
; --------- 4.4b4
; 05/07/02 akh maybe un-poof when unsplitting a window split vertically
; --------- 4.4b3
; reinstate tileing of "New" windows
; 04/12/01 more carbon-compat re titlehandle in fred-update
; carbon-compat windowrecord.titlehandle
; 08/11/99 akh ed-yank-file - no :draw-outline (it's obsolete)
;; -------- 4.3F1C2
; 08/16/98 akh set-mini-buffer binds *print-circle* nil
; 04/28/98 AKH window-make-parts - call to string-equal re "new" dont specify end-2
; 06/06/97 akh fred-palette-closest-entry and friends moved to l1-edcmd
; 02/28/97 akh split-pane, get rid of blinkers differently, reorder-subviews for the heck of it.
; 04/25/97 bill  Don't call view-activate-event-handler in (method initialize-instance (fred-window))
; -------------- 4.1f1
; 02/04/97 bill  funcall-with-foreground-rgb binds *default-foreground-rgb*. This makes the
;                default font color appear as the fred item's :text part-color.
; -------------- 4.0
; 11/15/96 alice remove-ordered-subview reorders subviews to fix double drawing when revert to single pane.
; 09/26/96 bill  (method view-click-event-handler (bar-dragger t)) handles double clicks
;                by eliminating the lower or right pane.
;                (method pane-splitter-handle-double-click (fred-item t t)) splits the pane in two
; -------------  4.0b2
; 05/22/96 bill  def-load-pointers => def-ccl-pointers for initialize-foreground-rgb
; -------------  MCL-PPC 3.9
; 03/05/96 bill  in view-package-string, don't call symbol-value-in-process on an
;                exhausted process.
;                Remove some underlining.
; 01/17/96 bill  (initialize-fred-palette) moves from here to "ccl:lib;color.lisp"
; 11/09/95 bill  #_getenvirons -> #_GetScriptManagerVariable
; akh add word-wrap-p etc initargs
; akh selection-range was wrong
;  2/22/95 slh   stream-filename: allow null window-key-handler
;     ?    alice read on...
; tweak view-draw/activate/deactivate for poof-button
; nuke redundant inititalize-instance (bar-dragger)
; fred-window accepts wrap-p, copy-styles-p, history-length, part-color-list initargs
; set-current-key-handler doesnt need to call view-activate/deactivate
; mini-buffer-update preserves text hanging out after package
; window-scroll and split-pane use set-fred-display-start-mark, method fred-update (fred-window)
; hair moves to fred-update (fred-item)
; default-initarg erase-anonymous-invalidations nil has minor benefit in that last
;  line in buffer doesnt twitch when drag-split - also makes life simpler.
; remove-ordered-subview and split-pane - no more with-preserved-buffers or messing
;  with key-handler as long as they are careful that remaining views are always contained in window
; window-make-parts - tiling is fn of pos of highest numbered new window vs. fn of number
; set-mini-buffer limits lines to fn of *max-mini-buffer-lines*
; more select-all nil in calls to set-current-key-handler
; drag-split better still by telling window-update not to erase, fred-window accepts save-buffer-p initarg
; window-key-handler sensible when current-key-handler is nil
; split-pane and drag-split less flashy -  replace-view-in-split-view changes to accomodate
; there were 2 defs of window-needs-saving-p
; window-make-parts accepts and passes along buffer arg, don't make up a position if position arg is given
; remove-ordered-subview - if outer not a split-view set containers container to nil
; added macro with-preserved-buffer and use it to prevent loss of buffer when changing
; containers - so we can reinstate reuse of buffer chunks (save-buffer-p nil)
; add fred-save-buffer-p and setf ditto for some containers - used by above.
;
; 11/08/93 alice set-window-title also sets defs-dialog title if any
; 10/17/93 alice view-activate/deactivate-event-handler (fred-window) not needed.
; 10/12/93 alice window-cursor (fred-window) is same as window = arrow, view-cursor (poof-button) unnecessary
; 10/03/93 alice nuke redundant def of pathname-to-window and redundant view-cursor (bar-dragger)
; 09/30/93 alice set-mini-buffer defined for window vs fred-window so remove-shadowing-comtab
;		doesnt puke if no mini-buffer
; 08/16/93 alice view-font-codes for fred-window delegates. set-window-title & window-title
;		use system-script not (font2script view-font-codes).
;----------------
; 07/15/93 alice define nop set-initial-view-font for fred-window
; 07/14/93 alice fred-class -> fred-item-class
;;start of added text
; 08/16/93 alice view-font-codes for fred-window delegates. set-window-title & window-title
;                use system-script not (font2script view-font-codes).
; 08/13/93 bill  restore the fresh-line in set-mini-buffer
; 07/28/93 bill  (method fred-history (fred-window))
; 07/27/93 bill  (method frec (fred-window))
; 07/26/93 bill  do-all-frecs -> map-frecs
; 07/21/93 bill  (method view-font-codes (fred-window))
; 07/13/93 bill  :copy-styles-p initarg returns to fred-window class, default of T.
;                Passed on to scrolling-fred-dialog-item by window-make-parts.
;                :wrap-p & :buffer also passed on to scrolling-fred-dialog-item
; -------------- 3.0d12
; 07/15/93 alice define nop set-initial-view-font for fred-window
; 07/14/93 alice fred-class -> fred-item-class, etc.
; 07/10/93 alice mini-buffer gets v-scroller at 55 vs 62, h-scroller-outline defaults t so don't supply t
; 07/05/93 alice set-view-font and set-view-font-codes methods for fred-window delegate
;		 to window-key-handler
; 07/01/93 alice replace-view-in-split-view is now a gf so container need not be a split-view
;		 split-pane tweaked a bit for same reason, also remove-ordered-subview.
;		 dragger-direction scrolling-fdi is nil if no dragger.
;		 split-pane of scrolling-fdi does not assume existence of a mini-buffer.
;		 ordered-subviews and split-view direction of vanilla view are nil
; 06/14/93 alice set-window-title and window-title deal with scripts
; -------------- 3.0d9
; 05/03/93 alice drag-split for fred-window fix case of superior being split and inferior precedes mini-buffer
; 05/04/93 bill in window-make-parts - set-window-filename with the real filename
;               in initialize-instance - delay window-show of a fred-window
; 04/19/93 bill window-needs-saving-p method so that "Save" menu item gets enabled correctly.
; 04/15/93 bill mis-parenthesized unwind-protect in window-make-parts
;               window-close handles key-handler of NIL so that aborting after a
;               no-such-file error won't error again.
; -------------- 2.1d5
; 04/23/93 alice drag-split - don't assume key handler is superior view, split-pane no longer
;		changes the key handler, so replace-view-in-split-view remembers and restores it
; 04/21/93 alice bill's idea to allow horizontal split without first poofing the mini-buffer
; 04/19/93 alice view-click-.. poof-button and bar-dragger don't resample mouse
; 04/08/93 alice window-save method for fred-window so save menu item gets enabled
; 04/04/93 alice - tile "New" windows up to a point
; minimize mini-buffer history length and chunk-size
; ------------- 2.1d4
;

(eval-when (:compile-toplevel :execute)

; to assure that buffers not disappear when changing containers
; i.e. setting container to nil temporarily does not count - (not needed today)
(defmacro with-preserved-buffers (view &rest body)
  (let ((save-var (gensym))
        (view-var (gensym)))
    `(let* ((,view-var ,view)
            (,save-var (fred-save-buffer-p ,view-var)))
       (setf (fred-save-buffer-p ,view-var) t)
       ,@body
       (setf (fred-save-buffer-p ,view-var) ,save-var))))
)

#|
(eval-when (:compile-toplevel :execute :load-toplevel)
; maybe movve this to l1-edfrec - done
(defmacro with-foreground-rgb (&body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-foreground-rgb ,thunk))))
)
|#

(export 'fred-palette-closest-entry)

(defvar *foreground-rgb* nil)
(defvar *foreground-rgb-port* nil)
(defvar *default-foreground-rgb* nil)
(defvar *fred-palette* nil)

#|
(defun funcall-with-foreground-rgb (thunk)
  (with-macptrs ((wptr (%getport)))
    (if (or (null *fred-palette*)
            (eql *foreground-rgb-port* wptr))
      (funcall thunk)
      (let* ((*foreground-rgb-port* wptr))
        (rlet ((*foreground-rgb* :RGBColor))
          #-carbon-compat
          (#_GetForeColor *foreground-rgb*)
          #+carbon-compat
          (#_GetPortForeColor wptr *foreground-rgb*)
          (let ((*default-foreground-rgb* *foreground-rgb*))
            (unwind-protect
              (funcall thunk)
              (#_RGBForeColor *foreground-rgb*))))))))
|#

(defun funcall-with-foreground-rgb (thunk)
  (with-port-macptr wptr
    (if (or (null *fred-palette*)
            (eql *foreground-rgb-port* wptr))
      (funcall thunk)
      (let* ((*foreground-rgb-port* wptr))
        (rlet ((*foreground-rgb* :RGBColor))
          #-ignore
          (#_GetForeColor *foreground-rgb*)
          #+ignore
          (#_GetPortForeColor wptr *foreground-rgb*)
          (let ((*default-foreground-rgb* *foreground-rgb*))
            (unwind-protect
              (funcall thunk)
              (#_RGBForeColor *foreground-rgb*))))))))

#| ; not needed today
;(defmethod fred-save-buffer-p ((view split-view))
  ; assume all the same
  (fred-save-buffer-p (find-a-key-handler view)))

;(defmethod fred-save-buffer-p ((view scrolling-fred-view))
  (fred-save-buffer-p (fred-item view)))

;(defmethod (setf fred-save-buffer-p) (value (view scrolling-fred-view))
  (setf (fred-save-buffer-p (fred-item view)) value))

;(defmethod (setf fred-save-buffer-p) (value (view split-view))
  (dolist (v (ordered-subviews view))
    (setf (fred-save-buffer-p (fred-item v)) value)))
|#


(defclass split-view (view)
  ((split-view-direction :initarg :split-view-direction :reader split-view-direction)
   (ordered-subviews :initarg :ordered-subviews :initform nil :accessor ordered-subviews)))

(defclass new-mini-buffer (scrolling-fred-view) ()
  (:default-initargs
    :fred-item-class 'mini-buffer-fred-item))

;;;;;;;;;;;
;;
;; when one clicks this button the mini-buffer goes below the scroll bar and is resizable
;;

(defclass poof-button (simple-view) ())

(defmethod initialize-instance ((view new-mini-buffer) &key poof-button)
  (call-next-method)
  (when poof-button
    (make-instance 'poof-button
      :view-size #@(16 16)
      :view-position (subtract-points (view-size view) #@(16 16))
      :view-nick-name 'poof
      :view-container view)))

(defmethod view-cursor ((view poof-button) where)
  (declare (ignore where))
  *vertical-ps-cursor*)

(defmethod view-click-event-handler ((p poof-button) where)
  ;(declare (ignore where))
  (let* ((mb (view-container p))
         (w (view-container mb))
         (superior (do ((l (ordered-subviews w) (cdr l)))
                       ((null l))
                     (when (null (cddr l))(return (car l)))))
         (s-tl (view-position superior))
         (s-br (add-points (view-position superior)
                           (subtract-points (view-size superior) #@(1 1)))))
    (let* ((mouse-pos (convert-coordinates where mb w)) ; (view-mouse-position w))
           (my-min (view-minimum-size superior))
           (pos (convert-coordinates (view-position p) 
                                     mb ;(view-container mb)
                                     w)) 
           min max min-pos max-pos drawn delta)
      (setq min (point-h s-tl)     ; min and max are extent of line
            max (- (point-h s-br) 2)            
            max-pos (+ (point-v (view-position superior))   ; min-pos and max-pos are extent of drag 
                       (point-v (view-size superior)) -1)
            min-pos (+ (point-v my-min) (point-v (view-position superior)))
            pos (+ (point-v pos) (point-v (view-size mb)) -1) ; just (point-v pos) is also interesting
            delta (- pos (point-v mouse-pos)))
      (flet ((draw-line (pos)                   
               (draw-dragger-outline
                w p pos min max :horizontal
                (or (< pos min-pos)(> pos max-pos)))))
        (declare (dynamic-extent #'draw-line))
        ;(format t "~% pos ~S min-pos ~S max-pos ~S" pos min-pos max-pos)
        (multiple-value-setq (pos drawn)
          (track-and-draw w #'draw-line pos :vertical delta min-pos max-pos))
        (when drawn
          (when (<= pos (- max-pos 15))
            (set-view-container p nil)
            (set-view-position mb -1 pos)            
            (setf (h-scroll-fraction superior) nil)                  
            (let* ((h-scroller (h-scroller superior))                   
                   (h-size (point-h (view-size superior))))
              (when h-scroller
                (set-pane-splitter-position h-scroller  :left)
                (setf (pane-splitter-cursor (pane-splitter h-scroller)) *left-ps-cursor*))
              (make-instance 'bar-dragger
                :split-view-direction :vertical
                :view-container superior
                :view-nick-name 'bar-dragger
                :view-position #@(-3000 -3000))
              (set-view-size mb h-size (1+ (- max-pos pos)))
              (set-view-size superior h-size (- (point-v (view-size superior))(- max-pos pos)))
              (add-remove-scroll-bars mb)))
          (fred-update w) ; added 7/3 - lose caret turds
          )
        (set-current-key-handler w (fred-item superior) nil)))))

(defun poof (superior mb)
  (let* ((p (view-named 'poof mb)))
    (set-view-container p nil)
    (setf (h-scroll-fraction superior) nil)                  
    (let* ((h-scroller (h-scroller superior))           
           (h-size (point-h (view-size superior))))
      (set-pane-splitter-position h-scroller  :left)
      (setf (pane-splitter-cursor (pane-splitter h-scroller)) *left-ps-cursor*)
      (make-instance 'bar-dragger
        :split-view-direction :vertical
        :view-container superior
        :view-nick-name 'bar-dragger
        :view-position #@(-3000 -3000))
      (let ((v (point-v (view-size mb))))
        (set-view-size mb h-size v)
        (set-view-size superior h-size (- (point-v (view-size superior)) (1- v)))))))
    
#|
;(defmethod view-cursor ((p poof-button) where)
  (declare (ignore where))
  *arrow-cursor*)
|#
(defparameter *lighter-gray-color* #xdddddd) ;; also in color.lisp
(defmethod view-draw-contents ((p poof-button)) 
  (let ((active-p (window-active-p (view-window p))))
    (with-focused-view p
      (with-back-color (if active-p *lighter-gray-color* nil)        
        (rlet ((r :rect
                  :topleft 0
                  :bottomright (view-size p)))
          (#_FrameRect r)
          (#_insetrect r 1 1)     
          (#_eraserect r)      
          (with-fore-color (if active-p  *dark-gray-color* *gray-color*)       
            ; like draw-vertical-dragger only different - now same
            (draw-vertical-dragger)))))))

(defmethod view-activate-event-handler ((view poof-button))
  (invalidate-view view))

(defmethod view-deactivate-event-handler ((view poof-button))
  (invalidate-view view))
          

(defclass mini-buffer-fred-item (fred-item) ()
  (:default-initargs :word-wrap-p t))

(defmethod ed-self-insert ((it mini-buffer-fred-item))
  (ed-beep))

(defmethod view-draw-contents ((view new-mini-buffer))
  (call-next-method)
  (let ((h-scroller (h-scroller view)))
    (when h-scroller
      (let ((pos (view-position h-scroller)))
        (#_moveto 0 (point-v pos))
        (#_lineto (point-h pos) (point-v pos))))))

(defmethod view-size-parts ((view new-mini-buffer))
  (call-next-method)
  (let ((poof (view-named 'poof view)))
    (when poof (set-view-position poof (subtract-points (view-size view) #@(16 16)))))
  (let ((frec (frec (fred-item view))))
    (when frec (setf (fr.leading frec) 2))) ; so wrapped lines arent partly visible below- cool
  (let ((status-line (view-named 'status-line view))
        (h-scroller (h-scroller view)))
    (when (and status-line h-scroller)
      (let ((pos (view-position h-scroller)))
        (set-view-position status-line 2 (+ 1 (point-v pos)))
        (set-view-size status-line
                       (- (point-h pos) 2)
                       (- (point-v (view-size h-scroller)) 1))))))
    
(defclass tsm-document-mixin ()())  ;; defined for real later

(defclass tsm-fred-item (tsm-document-mixin fred-item) ())

(defclass window-fred-item (tsm-fred-item)())
  

; above class exists so we can have the following method. 

#|
(defmethod fred-update ((fred window-fred-item))
  (call-next-method)
  (let* ((w (view-window fred))
         wptr)
    (when  (and w (setq wptr (wptr w)))
      (unless (view-quieted-p w)        
        (without-interrupts     
         (let ()
           (with-focused-view w              
             (let* ((marker (char-code (fred-title-marker w))))  ;<<
               (unless (eq marker 
                           (%hget-byte (%get-ptr wptr $wtitleHandle) 1))  ;; thou should be shot for this
                 (let* ((buffer (fred-buffer fred))
                        owner wptr
                        (mapper #'(lambda (frec)
                                    (let* ((buf2 (fr.buffer frec)))
                                      (when (and (same-buffer-p buf2 buffer)
                                                 (setq owner (fr.owner frec)))
                                        (let ((w2 (view-window owner)))
                                          (when (typep w2 'fred-window)
                                            (when (neq marker 
                                                       (%hget-byte (%get-ptr (setq wptr (wptr w2))
                                                                             $wtitleHandle)
                                                                   1))
                                              (%stack-block ((sp 256))
                                                (#_GetWTitle wptr sp)
                                                (%put-byte sp marker 1)
                                                (#_SetWTitle wptr sp))))))))))
                   (declare (dynamic-extent mapper))
                   (map-frecs mapper))))
             (let () ;((mini (view-status-line w)))
               (when nil ;mini 
                 (when nil ;(slot-value mini 'string-changed)
                   (mini-buffer-update w)))))))))))
|#


;; which comes first - the chicken or the egg
#+ignore
(defun get-wptr-marker (wptr)
  (%stack-block ((sp 256))
    (#_GetWTitle wptr sp)
    (%get-byte sp 1)))

;; use #_SetWindowTitleWithCFString
;; and #_CopyWindowTitleAsCFString()
(defmethod fred-update ((fred window-fred-item))
  (call-next-method)
  (let* ((w (view-window fred))
         wptr)
    (when  (and w (setq wptr (wptr w)))
      (unless (view-quieted-p w)        
        (without-interrupts 
           (with-focused-view w              
             (let* ((marker (fred-title-marker w)))  ;<<  what mark should be in the title               
               (unless (eq marker (saved-title-marker w))  ;; whats in the title now
                 (if (eq marker (modified-marker w))
                   (set-wptr-modified wptr t)
                   (set-wptr-modified wptr nil))
                 (set-saved-title-marker w marker)
                 (set-window-title w (window-title w))  
                 ;; AFAIK there are never 2 windows with the same buffer - oops
                 (when (fboundp 'clone-window)  ;; ugh its in examples;assorted-fred-commands
                   (let* ((buffer (fred-buffer fred))
                          (mapper #'(lambda (win2)
                                      (let* ((buf2 (fred-buffer win2)))
                                        (when (and (neq win2 w)(same-buffer-p buf2 buffer))
                                          (when (neq marker (saved-title-marker win2))
                                            (if (eq marker (modified-marker win2))  ;; ??
                                              (set-wptr-modified (wptr win2) t)
                                              (set-wptr-modified (wptr win2) nil))                                                
                                            (set-saved-title-marker win2 marker)
                                            (set-window-title win2 (window-title win2))))))))
                     (declare (dynamic-extent mapper))
                     (map-windows-simple mapper 'fred-window)))))
             ))))))

(defparameter *metallic-fred-windows* nil)  ;; seems to have a glitch re grow icon when resize by a small amount and the grow icon is bigger
(defparameter *live-resize-fred-windows* t)  ;;  works but clunky

(defclass fred-window (fred-delegation-mixin window split-view)
  (;(window-cursor :allocation :class)
   (modified-marker :allocation :class :initform #\240 :reader modified-marker)  ;; thats MacRoman for #\ 
   (real-file-name :initform nil)
   ;(defs-dialog :initform nil)
   ;(status-line :initform nil :accessor view-status-line)
   )
  (:default-initargs
    :copy-styles-p t
    :history-length *fred-history-length*
    :text-edit-sel-p t
    :split-view-direction :vertical
    ;:view-size #@(300 200)
    ;:view-position '(:top 50)
    :track-thumb-p *fred-track-thumb-p*
    :erase-anonymous-invalidations nil
    :h-pane-splitter :right
    :v-pane-splitter :top
    ;:window-other-attributes #$kWindowMetalAttribute 
    ;:theme-background #$kThemeBrushDocumentWindowBackground
    ))

; use something that is visible #\\ (what does it mean?) - maybe + instead
(defmethod modified-marker ((w fred-window))
  (if (eql (default-script nil) #$smJapanese)
    #\+ (slot-value w 'modified-marker)))

; user access to read-only-marker and the whole marker business
; new
(defmethod fred-title-marker ((w fred-window))
  (let ((fred (fred-item w)))
    (if fred
      (if (window-buffer-read-only-p fred)
        (read-only-marker w)
        (if (window-needs-saving-p fred)   ;Update the modified marker in title
          (modified-marker w)
          #\space))
      #\space)))
; new
(defmethod read-only-marker ((w fred-window)) #.(code-char #xa8))

(defmethod window-set-not-modified ((w fred-window))
  (window-set-not-modified (window-key-handler w))) 
  

(defmethod fred-update ((w fred-window))
  (let ((fred (window-key-handler w)))
    (when fred (fred-update fred))))

(defmethod window-show-cursor ((w fred-delegation-mixin) &optional pos scrolling)
  (window-show-cursor (fred-item w) pos scrolling))

(defmethod window-selection-stream ((w fred-delegation-mixin) start end)
  (window-selection-stream (fred-item w) start end))
                                     

;dont mess with my fonts
(defmethod set-initial-view-font ((w fred-window) font-spec)
  (declare (ignore font-spec)))

#|
(defvar *window-color-part-alist*
  '((:content . #.$wContentColor)
    (:frame . #.$wFrameColor)
    (:text . #.$wTextColor)
    (:hilite . #.$wHiliteColor)
    (:title-bar . #.$wTitleBarColor)))
|#
 ;; ?????? 
(defmethod set-part-color ((w fred-window) part color)
  (if (assq part *window-color-part-alist*)
    (call-next-method)
    (set-part-color (window-key-handler w) part color)))


; when views overlap the behavior of both view-cursor and view-click-event handler
; depends on the order of view-subviews - they look at last first.
; und so we do this. 

(defmethod view-click-event-handler ((w fred-window) where)
  (let ((mb (view-mini-buffer w)))    
    (if 
      (and mb
           (setq mb (view-container mb))
           (point-in-click-region-p mb where))
      (view-convert-coordinates-and-click mb where w)
      (call-next-method))))

(defmethod find-clicked-subview ((w fred-window) where)
  (let ((mb (view-mini-buffer w)))
    (if 
      (and mb 
        (setq mb (view-container mb)) 
        (point-in-click-region-p mb where))
      (find-clicked-subview mb (convert-coordinates where w mb))
      (call-next-method))))

(defmethod window-save ((w fred-window))
  (window-save (window-key-handler w)))

(defmethod window-ask-save ((w fred-window))
  (window-ask-save (window-key-handler w)))
  

(defmethod window-needs-saving-p ((w fred-window))
  (window-needs-saving-p (window-key-handler w))) 

(defmethod set-selection-range ((w fred-delegation-mixin) &optional start end)
  (set-selection-range (fred-item w) start end))

(defmethod selection-range ((w fred-delegation-mixin))
  (selection-range (fred-item w)))

(defmethod fred-display-start-mark ((w fred-delegation-mixin))
  (fred-display-start-mark (fred-item w)))

(defmethod stream-tyo ((w fred-window) char)
  (stream-tyo (window-key-handler w) char))

(defmethod stream-write-string ((w fred-window) string start end)
  (stream-write-string (window-key-handler w) string start end))


(defmethod set-view-font-codes ((w fred-delegation-mixin) ff ms &optional old-ff old-ms)
  (set-view-font-codes (fred-item w) ff ms old-ff old-ms))



#|
;(defmethod set-view-font ((w fred-window) spec)
  (set-view-font (window-key-handler w) spec))


;(defmethod view-font-codes ((w fred-window))
  (view-font-codes (window-key-handler w)))
|#


(defmethod stream-force-output ((w fred-window))
  (stream-force-output (window-key-handler w)))

(defmethod stream-fresh-line ((w fred-window))
  (stream-fresh-line (window-key-handler w)))

(defmethod stream-column ((w fred-window))
  (stream-column (window-key-handler w)))

(defmethod stream-position ((w fred-window) &optional new)
  (stream-position (window-key-handler w) new))

(defmethod window-hardcopy ((w fred-window) &optional (show-dialog t))
  (window-hardcopy (window-key-handler w) show-dialog))

(defmethod fred-text-edit-sel-p ((w fred-delegation-mixin))
  (fred-text-edit-sel-p (fred-item w)))

(defmethod (setf fred-text-edit-sel-p) (value (w fred-delegation-mixin))
  (setf (fred-text-edit-sel-p (fred-item w)) value))

#|
;(defmethod fred-wrap-p ((w fred-window))
  (fred-wrap-p (window-key-handler w)))


;(defmethod (setf fred-wrap-p) (value (w fred-window))
  (setf (fred-wrap-p (window-key-handler w)) value))
|#

(defmethod fred-word-wrap-p ((w fred-delegation-mixin))  ; was text-edit-xxx-p
  (fred-word-wrap-p (fred-item w)))

(defmethod (setf fred-word-wrap-p) (value (w fred-delegation-mixin))
  (setf (fred-word-wrap-p (fred-item w)) value))

(defmethod fred-justification ((w fred-delegation-mixin))
  (fred-justification (fred-item w)))

(defmethod (setf fred-justification) (value (w fred-delegation-mixin))
  (setf (fred-justification (fred-item w)) value))

(defmethod fred-line-right-p ((w fred-delegation-mixin))
  (fred-line-right-p (fred-item w)))

(defmethod (setf fred-line-right-p) (value (w fred-delegation-mixin))
  (setf (fred-line-right-p (fred-item w)) value))

(defmethod fred-chunk-size ((w fred-window))  ; who needs this? its documented
  (fred-chunk-size (window-key-handler w)))

(defmethod (setf fred-tabcount) (value (w fred-delegation-mixin))
  (setf (fred-tabcount (fred-item w)) value))

(defmethod fred-tabcount ((w fred-delegation-mixin))
  (fred-tabcount (fred-item w)))

(defmethod stream-fresh-line ((view mini-buffer-fred-item))
  (with-focused-view view  ; seems to mess up - maybe this will help- if it does figure out why??
    (let* ((w (view-window view))
           (buf (fred-buffer view))
           (pos (buffer-size buf)))
      (set-mark buf pos)
      (if (not (view-status-line w))
        (progn 
          (unless (and (> pos 2)(eql (buffer-char buf (- pos 2)) #\|))            
            (stream-tyo view #\return)
            (princ (view-package-string w) view)
            (princ "| " view)
            (set-fred-display-start-mark view (1+ pos))
            (fred-update view)))
        (call-next-method)))))

(defmethod window-package ((w fred-window))
  (window-package (window-key-handler w)))

(defmethod view-package-string ((w fred-window))
  (let ((fred (window-key-handler w)))
    (when fred
      (let* ((p (or (sneaky-window-package fred)
                    (let ((process (window-process w)))
                      (and process
                           (neq process *current-process*)
                           (not (process-exhausted-p process))
                           (symbol-value-in-process '*package* process)))
                    *package*)))        
        (or (and p (packagep p) (package-name p)
                 (shortest-package-nickname p))
            (if (packagep p)
              "(Deleted package!)"
              (if (consp p) (format nil "(New package ~A)" (car p))
                  "(Invalid package!)")))))))     

(defmethod mini-buffer-update ((x fred-item))
  (mini-buffer-update (view-window x)))

#| callers
(
#<STANDARD-METHOD REPARSE-MODELINE (FRED-MIXIN)>
#<STANDARD-METHOD DRAG-SPLIT (FRED-WINDOW T T T T T T T)>
 #<STANDARD-METHOD MINI-BUFFER-UPDATE (fred-item)>
#<STANDARD-METHOD FRED-PACKAGE (FRED-MIXIN)>)
|#

; this is the guy that assures that the package shows up!
; call something else for other purposes
(defmethod mini-buffer-update ((w fred-window))
  (when  (wptr w)    
    (let ((status (view-status-line w))
          (pkg-str (%str-cat (view-package-string w) "| ")))
      (if status
        (set-dialog-item-text status pkg-str)
        (let* ((mb (view-mini-buffer w)))
          (when mb
            (with-focused-view mb  ; shouldnt help and prob wont
            (let* ((buf (fred-buffer mb))
                   (size (buffer-size buf)))
              (set-mark buf size)
              (stream-tyo mb #\return)
              (princ pkg-str mb)
              (set-fred-display-start-mark mb (1+ size))
              (fred-update mb)))))))))

(defmethod mini-buffer-show-cursor ((item fred-mixin))
  (mini-buffer-show-cursor (view-window item)))


(defmethod mini-buffer-show-cursor ((w fred-window))
  (when (wptr w)
    (let ((mb (view-mini-buffer w)))
      (when mb (window-show-cursor mb (buffer-line-start (fred-buffer mb)))))))


(defmethod view-mini-buffer ((view fred-item))
  (let ((w (view-window view)))
    (when w (view-mini-buffer w))))


(defmethod view-mini-buffer ((w fred-window))
  (let ((v (view-named 'mini-buffer w)))
    (when v (fred-item v))))

(defmethod view-status-line ((w fred-window))
  (let ((mb (view-mini-buffer w)))
    (when mb (view-named 'status-line mb))))

(defmethod set-mini-buffer ((view window-fred-item) string &rest args)
  (declare (dynamic-extent args))
  (apply #'set-mini-buffer (view-window view) string args))

(defmethod set-mini-buffer ((view fred-mixin) string &rest args)
  (declare (ignore string args)))

(defparameter *max-mini-buffer-lines* 20)

(when (not (fboundp 'lines-in-buffer))
  (defun lines-in-buffer (x)  ; bootstrapping
    (declare (ignore x))
    22))

#|
(defmethod set-mini-buffer ((w window) string &rest format-args)
  (declare (dynamic-extent format-args))
  (when (wptr w)
    (let ((mini-buffer (view-mini-buffer w)))
      (when mini-buffer
        ;(terpri mini-buffer)
        (let* ((max *max-mini-buffer-lines*)
               (buf (fred-buffer mini-buffer))
               (lines (lines-in-buffer buf)))
          (let ((*print-circle* nil)
                (*print-pretty* nil))
            ;; string often contains ~&
            ;; so if we aren't at beginning of line we do stream-fresh-line  which reprints the package
            ;; but if *print-circle* is t then the stream-fresh-line goes to the xp-stream
            (apply #'format mini-buffer string format-args))
          (when (> lines (+ max max))
            (buffer-delete buf 0 (buffer-line-start buf 0 max)))
          (window-show-cursor mini-buffer (buffer-line-start buf)))))))
|#

(defmethod set-mini-buffer ((w window) string &rest format-args)
  (declare (dynamic-extent format-args))
  (when (wptr w)
    (let ((mini-buffer (view-mini-buffer w)))
      (when mini-buffer
        ;(terpri mini-buffer)
        (let* ((max *max-mini-buffer-lines*)
               (buf (fred-buffer mini-buffer))
               (lines (lines-in-buffer buf)))
          (let ((*print-circle* nil)
                (*print-pretty* nil))
            #+ignore
            (when (and (base-string-p string)(not (7bit-ascii-p string)))
              ;; fix ellipsis things
              (setq string (convert-string string #$kcfstringencodingmacroman #$kcfstringencodingunicode)))
            ;; string often contains ~&
            ;; so if we aren't at beginning of line we do stream-fresh-line  which reprints the package
            ;; but if *print-circle* is t then the stream-fresh-line goes to the xp-stream
            (apply #'format mini-buffer string format-args))
          (when (> lines (+ max max))
            (buffer-delete buf 0 (buffer-line-start buf 0 max)))
          (window-show-cursor mini-buffer (buffer-line-start buf)))))))

(defmethod window-eval-selection ((w window) &optional eval-p)
  (let ((key (current-key-handler w)))
    (when key
      (window-eval-selection  key eval-p))))

#|
;(defmethod window-restore-position ((w fred-window) &optional (name (window-filename w)))
  (let ((key (window-key-handler w)))    
    (view-restore-position key name)))
|#

(defmethod window-eval-whole-buffer ((w window))
  (let ((key (current-key-handler w)))
    (when key (window-eval-whole-buffer key))))

; these 3 are required by maybe-start-isearch
#|
;(defmethod ed-beginning-of-buffer ((w fred-window))
  (ed-beginning-of-buffer (current-key-handler w)))
|#

(defmethod window-show-selection ((w fred-delegation-mixin))
  (window-show-selection (fred-item w)))

(defmethod collapse-selection ((w fred-delegation-mixin) forward-p)
  (collapse-selection (fred-item w) forward-p))

(defmethod set-selection-range ((w fred-delegation-mixin)  &optional b e)
  (set-selection-range (fred-item w) b e))


(defmethod view-key-event-handler ((w fred-window) char)  
  (let ((key (current-key-handler w)))
    (if (null key)
      (call-next-method)
      (view-key-event-handler key char))))
#|
(def-ccl-pointers fred ()
  (set-class-slot-value
   (find-class 'fred-window) 'window-cursor *arrow-cursor*))
|#


(defmethod initialize-instance ((w fred-window)
                                &rest initargs
                                &key (window-show t)
                                (window-other-attributes 0)
                                (theme-background nil))
  (declare (dynamic-extent initargs))
  (let ((other-attrs (if *metallic-fred-windows* #$kWindowMetalAttribute 0)))
    (if *live-resize-fred-windows* (setq other-attrs (logior other-attrs #$kwindowliveresizeattribute))) 
    (let* ((attrs (logior window-other-attributes other-attrs)))
      (if (and (neq 0 (logand #$kWindowMetalAttribute attrs))(not theme-background))
        ;; theme-background costs in with-fore and back color
        (setq theme-background #$kThemeBrushDocumentWindowBackground))
      (apply #'call-next-method w :window-show nil 
             :window-other-attributes  attrs
             :theme-background theme-background
             initargs)))
  (let* ()
    ;(key-handler-hammer w nil t) ; gets the bar outlines drawn
    ;(setf (mini-buffer-view (view-status-line w)) w)
    (set-current-key-handler w (fred-item (car (ordered-subviews w))) nil)
    (set-mini-buffer w "~&") ; makes the package show up
    ;(view-activate-event-handler w)
    )
  (fred-update w)                       ; otherwise window-title flashes
  (when window-show
    (window-show w)))

#| ;; too soon

(defmethod application-pathname-to-window-title ((app lisp-development-system)
                                            (window fred-window)
                                            pathname)
    (pathname-to-window-title pathname nil)  ;; include directory info
    )


(defmethod application-pathname-to-window-title ((app application)
                                            (window window)
                                            pathname)
  (pathname-to-window-title pathname t)  ;; omit directory info
  )
|#

(defmethod application-pathname-to-window-title (app window pathname)
  (pathname-to-window-title pathname))

(export 'application-pathname-to-window-title :ccl)



(defmethod set-current-key-handler ((w fred-window) view &optional (all nil))
  (declare (ignore all))
  (let  ((old (current-key-handler w)))
    (unless (eq old view)        
      (call-next-method w view nil)
      (when view
        (let ()
          ;(view-activate-event-handler view)          
          (when (and old ; maybe nuke this??
                     ;(eq (type-of old)(type-of view))  ; eschew mini-buffer
                     (not (same-buffer-p (fred-buffer view)(fred-buffer old))))            
            (let ((file (window-filename view)))
              (when file (set-window-title w (application-pathname-to-window-title *application* w file)))))))
      (when nil old
        (view-deactivate-event-handler old)))))

#|
;(defun key-handler-hammer (view key)
  (dolist (v (key-handler-list (view-window view)))
    (when (neq v key)
      (view-deactivate-event-handler v))))
|#


#|
;(defmethod view-activate-event-handler ((w fred-window))
  (when *foreground*
    (without-interrupts
     (unless (window-active-p w)
       ;(setf (window-active-p w) t) ; if we do this first the scroll bars won't activate
       (call-next-method)
       ;(mini-buffer-update w)  ; needed ?
       (setf (window-active-p w) t)))))

;(defmethod view-activate-event-handler :after ((w fred-window))  
  (let ((key (current-key-handler w)))
    (when key (key-handler-hammer w key))))

;(defmethod view-deactivate-event-handler ((w fred-window))
  (without-interrupts
   (when (window-active-p w)
     (call-next-method)
     (setf (window-active-p w) nil))))
|#

;; use #_CopyWindowTitleAsCFString - or DONT DO IT
(defmethod window-title ((w fred-window))  
  (let* ((nm (slot-value w 'object-name)))
    (or nm 
        (error "SHOULDN'T"))))

#|
;(defmethod set-window-title ((w fred-window) new-title)
  (let ((wptr (wptr w)))
    (%stack-block ((np 256))
      (let ((size (length (setq new-title (ensure-simple-string (string-arg new-title))))))
        (if (%i> size 254) (error "Title ~S too long"  new-title))
        (%put-byte np (%i+ size 1))
        (%put-byte np (%hget-byte (rref wptr windowrecord.titlehandle) 1) 1)
        (dotimes (i size)
          (%put-byte np (char-code (schar new-title i))(+ i 2)))
        (#_SetWTitle wptr np)
        (setf (slot-value w 'object-name) new-title)))
  new-title))
|#


;; use _SetWindowTitleWithCFString
(defmethod set-window-title ((w fred-window) new-title)
  (let ((wptr (wptr w)))    
    (if (and new-title ;; sometimes nil
             (or (typep new-title 'encoded-string)
                 (not (7bit-ascii-p new-title))))
      (set-window-title-cfstring w new-title)
      (progn 
        (when t (setq new-title (ensure-simple-string (string-arg new-title))))
        (%stack-block ((np 256))
          ; rats - we do this before the window has font-codes i think 
          (let* ((script (#_GetScriptManagerVariable #$smSysScript))
                 (n (byte-length new-title script)))
            (when (%i> n 254)
              (error "Title ~S too long"  new-title))
            ; leave room for the mystery byte
            (new-with-pointer (p np 2)
              (%put-string-contents p new-title 254 script))
            (%put-byte np (1+ n) 0)
            ; its the modified marker
            #-carbon-compat
            (%put-byte np (%hget-byte (rref wptr windowrecord.titlehandle) 1) 1)
            #+carbon-compat            
            (%put-byte np (char-code (saved-title-marker w)) 1)
            (#_SetWTitle wptr np)))))
    (setf (slot-value w 'object-name) new-title)
    (let ((frob (assq w *defs-dialogs*)))
      (when frob (set-window-title (cdr frob) (maybe-encoded-strcat "Definitions in " new-title))))
    new-title))

;; new-title may be encoded string
(defmethod set-window-title-cfstring ((w fred-window) new-title)  
  (let* ((first-c (saved-title-marker w))
         (string (if (typep new-title 'encoded-string)(the-string new-title) new-title))
         (new-len (length string)))
    (setq new-title (ensure-simple-string (string-arg new-title)))
    (when (> (char-code first-c) #x7f) (setq first-c (convert-char-to-unicode first-c)))
    (%stack-block ((sb (+ 2 (* 2 new-len))))
      (%put-word sb (char-code first-c) 0)
      (if (extended-string-p string)
        (%copy-ivector-to-ptr string 0 sb 2 (* 2 new-len))
        (dotimes (i new-len)
          (%put-word sb (%scharcode string i)(+ 2 i i))))
      ;(%put-word sb 0 (+ 2 (* 2 new-len)))
      (with-macptrs ((cfstr (#_CFStringCreateWithCharacters (%null-ptr) sb (1+ new-len))))
        ;(print (list (type-of (the-string new-title)) first-c (length (the-string new-title)) (#_cfstringgetlength cfstr)))
        (#_SetWindowTitleWithCFString (wptr w) cfstr)
        (#_cfrelease cfstr)))))

(defmethod set-saved-title-marker ((w fred-window) char) ;; char is macroman
  (view-put w 'title-marker char))
(defmethod saved-title-marker ((w fred-window))
  (or (view-get w 'title-marker) #\space))

#|
(defun convert-char-to-unicode (c &optional (encoding #$kcfstringencodingmacroman))
  ;; perhaps make more efficient
  (let* ((string (string c))
        (new-str (convert-string string encoding #$kcfstringencodingunicode)))
    (%schar new-str 0)))
|#

(defun convert-char-to-unicode (char &optional (encoding #$kcfstringencodingmacroman))
  ;; do we mean script or encoding??
  (let ((code (%char-code char))
        (flen 1))
    (declare (fixnum code))
    (if (or (and (memq encoding '(#.#$kcfstringencodingMacRoman #.#$kcfstringencodingMacJapanese #.#$kCFStringEncodingMacChineseTrad
                                  #.#$kCFStringEncodingMacKorean #.#$kCFStringEncodingMacChineseSimp))
                 (<= code #x7f))
            (< code #x20))  ;; random crock - exclude #\newline etc.
      char 
      (let () ;((script (encoding-to-script encoding)))
        (%stack-block ((cbuf 2))
          (if (> code #xff) ;(and script (two-byte-script-p script))
            (progn (setq flen 2)
                   (%put-word cbuf code))
            (%put-byte cbuf code))
          (with-macptrs ((cfstr (#_CFStringCreateWithBytes (%null-ptr) cbuf
                                 flen encoding nil)))
            (when (%null-ptr-p cfstr)
              (error "Illegal character conversion for code ~s from encoding #x~x" code encoding))
            (let ((uni-len (#_cfstringgetlength cfstr)))
              (if (neq uni-len 1) (error "Can't handle conversion of #x~X to unicode" code))
              (%stack-block ((to-buf 2 :clear t))                        
                (CFStringGetCharacters cfstr 0 1 to-buf)
                (#_cfrelease cfstr)
                (%code-char (%get-word to-buf))))))))))

#|
(defun convert-char-to-unicode-given-script (char script)  
  ;; do we mean script or encoding?? - here we mean script ;; and assume script = encoding
  (let ((code (%char-code char))
        (flen 1))
    (declare (fixnum code))
    (if (<= code #x7f)
      char
      (%stack-block ((cbuf 2))
        (if (> code #xff) ;(and script (two-byte-script-p script))
          (progn (setq flen 2)
                 (%put-word cbuf code))
          (%put-byte cbuf code))
        (with-macptrs ((cfstr (#_CFStringCreateWithBytes (%null-ptr) cbuf
                               flen script nil)))
          (let ((uni-len (#_cfstringgetlength cfstr)))
            (if (neq uni-len 1) (error "Can't handle conversion of ~X to unicode" code))
            (%stack-block ((to-buf 2 :clear t))                        
              (#_CFStringGetCharacters cfstr 0 1 to-buf)
              (#_cfrelease cfstr)
              (%code-char (%get-word to-buf)))))))))
|#



(defmethod window-revert ((w fred-window) &optional dp)
  (window-revert (window-key-handler w) dp))

;; this is stupid
(defmethod window-filename ((w fred-window))
   (or (slot-value w 'real-file-name)
       (buffer-filename (fred-buffer w))))

(defmethod stream-filename ((w fred-window))
  (window-filename w))

(defmethod pane-splitter-handle-double-click ((view fred-item) pane-splitter where)
  (declare (ignore where))
  (let* ((scroll-bar (scroll-bar pane-splitter))
         (direction (scroll-bar-direction pane-splitter))
         (view-pos (view-position view))
         (view-size (view-size view))
         (accessor (if (eq direction :vertical) #'point-v #'point-h))
         (pos (+ (funcall accessor view-pos) (round (funcall accessor view-size) 2))))
    ; Acount for size of new scroll bar
    (incf pos 8)
    (split-pane view scroll-bar pos direction t)
    t))

(defmethod split-pane ((fred fred-item) scroll-bar pos direction flag)
  ;(declare (ignore scroll-bar))
  (when flag
    (let* ((view (view-container fred))
           (w (view-window view))
           ;(key (current-key-handler w))
           (old-size (view-size view))
           (old-pos (view-position view))
           (min-size (view-minimum-size view))
           (h (point-h old-size))
           (v (point-v old-size))
           (h-scroller (h-scroller view))
           (v-scroller (v-scroller view))
           poofed)
      (when (or (and (eq direction :vertical)
                     (or (< (- v pos)(point-v min-size))
                         (< (+ pos 1) (point-v min-size))))
                (and (eq direction :horizontal) 
                     (or (< (+ pos 1)(point-h min-size))
                         (< (- h pos) (point-h min-size)))))        
        (return-from split-pane nil))
      (when (eq direction :horizontal)
                 (let ((mb (view-mini-buffer w)))
                   (when (and mb
                              (setq mb (view-container mb))
                              (view-named 'poof mb)
                              (view-contains-point-p  view (view-position mb)))
                     (poof view mb)
                     (setq poofed t)
                     (setq old-size (view-size view))
                     (setq v (point-v old-size)))))
      (without-interrupts
       (progn ;with-preserved-buffers view
         (let* ((container (view-container view))             
                (buf (fred-buffer fred))
                (modcnt (buffer-modcnt buf))
                (file-modcnt (slot-value fred 'file-modcnt))
                (new-container-pos old-pos)
                (new-container (if (and (typep container 'split-view)
                                        (eq (split-view-direction container) direction))
                                 container
                                 (make-instance 'split-view
                                   :view-size old-size
                                   :view-position #@(-3000 -3000)
                                   :view-container container
                                   ;:ordered-subviews (list view)
                                   :split-view-direction direction)))
                new new-pos new-size new-new-size)
           (when (neq container new-container)
             (if (typep container 'split-view)
               (let ((ph (point-h old-pos))
                     (pv (point-v old-pos)))
                 (setq old-pos (make-point (if (eq ph -1) 0 ph)(if (eq pv -1) 0 pv))))
               (setq old-pos #@(0 0))))
           (if (eq direction :vertical) ; in the vertical bar we split horizontally
             (progn 
               (setq new-size (make-point h (- v pos ))
                     new-pos (make-point (if (eq (point-h old-pos) -1) -1 0)
                                         (+ (point-v old-pos) pos)))
               (setq new-new-size (make-point h (+ pos 1))))
             (progn 
               (setq new-size (make-point (- h pos -1) v))
               (setq new-new-size (make-point  pos v))
               (setq new-pos (make-point (+  -1  (point-h old-pos) pos) 0))))
           (setq new
                 (make-instance 'scrolling-fred-view
                   ;:view-container new-container
                   :buffer (make-mark buf)
                   ;:filename (window-filename fred) ; it reverts the buffer - yech
                   :view-size new-new-size  ; (add-points w-size #@(0 0)) ; huh
                   :view-position (if (eq new-container container) old-pos #@(0 0))
                   :fred-item-class (class-of fred)
                   :grow-box-p nil
                   :view-font (view-font view)
                   :track-thumb-p (scroll-bar-track-thumb-p scroll-bar)
                   :bar-dragger  direction
                   :v-pane-splitter (when (and v-scroller (pane-splitter v-scroller)) :top)
                   :h-pane-splitter (when (and h-scroller (pane-splitter h-scroller)) :left)))
           ;(setf (slot-value (fred-item new) 'my-file-name)(window-filename fred))
           ; somebody is messing with buffer-modcnt above, restore it
           (set-buffer-modcnt buf modcnt)
           (setf (slot-value (fred-item new) 'file-modcnt) file-modcnt)
           (set-mark (fred-display-start-mark (fred-item new))
                     (fred-display-start-mark fred))
           #|(set-fred-display-start-mark (fred-item new) 
                                        (fred-display-start-mark fred) t)|#
           (if (neq container new-container)
             (progn
               (setf (ordered-subviews new-container) (list new view))
               (replace-view-in-split-view container view new-container)
               (set-view-size view new-size) ; dont do these until in correct container
               (set-view-position view new-pos)
               (set-view-position new-container new-container-pos))
             (progn 
               (set-view-size view new-size)
               (set-view-position view new-pos)
               (add-view-to-split-view container new view)))
           (let ()
             (set-view-container new new-container) ; does view-activate  which turns on the ffing blinkers
             (view-deactivate-event-handler (fred-item new)) ; so turn them off
             (reorder-subviews new-container)
             (if nil #|(not (osx-p))|# (kill-erase-region w)) ;; fixes an osx glitch sometimes
             (fred-update new)  ; get scroll bars right
             ) 
           (unless poofed
             (validate-scroll-bar view (if (eq direction :vertical) :horizontal :vertical)))
           ))))))

(defun kill-erase-region (w)
  (let ((er (window-erase-region w)))
    (when er
      (#_setEmptyRgn er))))  

(defun add-view-to-split-view (container new before)
  ; assumes already on subviews
  (do ((last nil l)
       (l (ordered-subviews container) (cdr l)))
      ((null l))
    (when (eq (car l) before)
      (if last (rplacd last (cons new l))
          (setf (ordered-subviews container) (cons new l)))
      (return))))

(defmethod replace-view-in-split-view ((container split-view) view new-container)
  (do ((l (ordered-subviews container)(cdr l)))
      ((null l))
    (when (eq (car l) view)
      (rplaca l new-container)
      (call-next-method)
      (return))))
      
(defmethod replace-view-in-split-view (container view new-container)
  (declare (ignore container))
  (let* ()
    (set-view-container view new-container)))

(defmethod set-file-external-format ((w fred-window) format)
  (view-put w :external-format format))

(defmethod file-external-format ((w fred-window))
  (view-get w :external-format))
    

(defmethod initialize-window :after ((w fred-window) &key) 
  ;(setf (mini-buffer-view (view-mini-buffer w)) w)
  (let ((view (current-key-handler w))
        did-it)
    (when view ;; why nil sometimes? IFT?? seems unlikely
      (when (fixnump (slot-value view 'file-modcnt))
        (let* ((file (window-filename w))
               (external-format (file-external-format w)))
          (when (and file (or *transform-CRLF-to-CarriageReturn* *transform-CRLF-to-preferred-eol*)
                     (not external-format))                       
            (setq did-it (ed-xform-CRLF view))))
        (when (not did-it)
          (setf (slot-value view 'file-modcnt) (buffer-modcnt (fred-buffer view))))))))



(defmethod fred-buffer ((w fred-window))
  (fred-buffer (window-key-handler w)))

(defparameter *default-fred-item-class* 'window-fred-item)

(defmethod window-make-parts ((w fred-window) &rest initargs
                              &key
                              filename
                              buffer
                              scratch-p
                              window-title wptr
                              view-position
                              view-font                                       
                              track-thumb-p
                              h-pane-splitter
                              v-pane-splitter
                              save-buffer-p
                              wrap-p
                              word-wrap-p
                              justification
                              line-right-p
                              (buffer-chunk-size #x1000)
                              copy-styles-p
                              text-edit-sel-p
                              history-length
                              part-color-list
                              comtab
                              (h-scrollp t)
                              (v-scrollp t)
                              (mini-buffer-p t)
                              (fred-item-class *default-fred-item-class*)
                              &aux win-p)
  (declare (dynamic-extent initargs))
  ; :SCRATCH-P means never "needs saving", i.e. don't offer to save, don't
  ;            show modified marker in title.
  (let* ((wptr-arg wptr)
         (file filename)) ; huh?
    (unwind-protect
      (progn
        (apply #'call-next-method
               w
               :window-title
               (or window-title
                   (unless file (new-window-title)))
               initargs)
        (setq wptr (wptr w))
        (let* ((w-size (view-size w))
               (h (point-h w-size))
               (v (point-v w-size))
               (mini-height 15)
               )          
          (setf 
           (ordered-subviews w)
           (list*
            (prog1
            (make-instance 'scrolling-fred-view
              :view-container w
              :view-size (make-point (+ h 2) (+ v 2 0)) ; (add-points w-size #@(0 0)) ; huh
              :view-position #@(-1 -1)
              ;:margin 3
              ;:draw-outline nil
              ;:draw-scroller-outline t
              :grow-box-p (null mini-buffer-p)
              :view-font view-font
              :filename filename
              :buffer buffer
              :h-scroll-fraction 4
              :fred-item-class fred-item-class
              :track-thumb-p track-thumb-p
              :bar-dragger  nil ;(if v-scrollp :vertical)
              :h-pane-splitter h-pane-splitter
              :v-pane-splitter v-pane-splitter
              :comtab comtab  ; or here
              :save-buffer-p save-buffer-p
              :wrap-p wrap-p
              :word-wrap-p word-wrap-p
              :justification justification
              :line-right-p line-right-p
              :buffer-chunk-size buffer-chunk-size
              :copy-styles-p copy-styles-p
              :history-length history-length
              :text-edit-sel-p text-edit-sel-p
              :part-color-list part-color-list
              :h-scrollp h-scrollp
              :v-scrollp v-scrollp)
              )
            (when mini-buffer-p
              (list
               (make-instance 'new-mini-buffer
                 :view-nick-name 'mini-buffer
                 :view-container w
                 :view-font *mini-buffer-font-spec*
                 :view-size (make-point (+ h 2 (- (max 64 (truncate h 4)))) (+ mini-height 1))
                 :view-position (make-point -1 (- v mini-height))
                 ;:draw-scroller-outline t
                 ;:fred-item-class 'fred-item
                 ;:draw-outline -1
                 :h-scrollp nil     
                 :v-scrollp nil                 
                 ;:h-scroll-fraction 4
                 :grow-box-p t ; leave room for poof button or grow-box
                 :poof-button t
                 :history-length 2
                 :buffer-chunk-size 256
                 :view-font view-font
                 :track-thumb-p t))))))
        (when file
          (set-window-filename w (setq file (window-filename w)))
          (set-file-external-format w (utf-something-p filename)))
        (when scratch-p
          (setf (slot-value (current-key-handler w) 'file-modcnt) t))          
        (when  (and file *save-fred-window-positions*)
          (view-restore-position (window-key-handler w) file))
        (when (and (not file) (not view-position))
          (let () ;(title (window-title w)))
            (when t ;(string-equal "new" title )
              (multiple-value-bind (idx pos)(new-window-number)
                (when (not (eql idx 0))
                  (set-view-position w (+ (point-h pos) 10)(+ (point-v pos) 15))
                  ; ok so they stop tiling after 12 on rgb monitor
                  (window-ensure-on-screen w))))))
        (setq win-p t))

      (unless win-p
        (unless wptr-arg (window-close w)))
      )))

;; lose the one for fred-mixin
(defmethod set-window-filename ((w fred-window) new-name)
  (let ((*use-namestring-caches* nil))
    (let ((title (application-pathname-to-window-title *application* w new-name))
          (buffer (fred-buffer w)))
      (setq new-name (full-pathname (pathname new-name)))
      (setf (slot-value w 'real-file-name) new-name)
      (set-window-title w title)
      (setf (buffer-filename buffer) new-name)
      (let ((mapper
             #'(lambda (frec &aux owner)
                 (when (and (same-buffer-p buffer (fr.buffer frec))
                            (typep (setq owner (fr.owner frec)) 'fred-mixin))
                   (setf (file-modcnt owner) -1)
                   ;(setf (slot-value owner 'my-file-name) new-name)
                   (let ((win (view-window owner)))
                     (when (and win (neq win w) (typep win 'fred-window))
                       (setf (slot-value win 'real-file-name) new-name)
                       (set-window-title win title)))))))
        (declare (dynamic-extent mapper))
        (map-frecs mapper)
        ;(setf (buffer-file-write-date buffer) nil)
        (fred-update w))
      new-name)))



(defmethod SET-WINDOW-FILENAME :after ((w fred-window) Pathname)
  (add-window-proxy-icon (view-window w) Pathname))


#|
(defmethod ADD-WINDOW-PROXY-ICON ((w window) &optional (Pathname (window-filename w)))
  "Set the proxy icon of window."
  (when pathname    
    (rlet ((Fsref :fsref)
           (alias :aliashandle))
      (when (path-to-fsref pathname fsref t)
        (errchk (#_FSNewAliasMinimal fsref alias))
        (with-macptrs ((the-alias (%get-ptr alias)))
          (unless (%null-ptr-p the-alias)
            (errchk (#_SetWindowProxyAlias (wptr w) the-alias))
            (unless (%null-ptr-p the-alias)
              (#_disposehandle the-alias))))))))
|#

(defmethod ADD-WINDOW-PROXY-ICON ((w window) pathname)
  "Set the proxy icon of window."
  (when (and pathname (not (window-fsref w)))
    ;; don't do this multiple times!! - dump fsref on window-close
    ;; and beware window-save-as
    (rlet ((alias :aliashandle))
      (let ((fsref (make-record :fsref)))  ;; will follow file movement
        (when (path-to-fsref pathname fsref t)
          (errchk (#_FSNewAliasMinimal  fsref alias))
          (with-macptrs ((the-alias (%get-ptr alias)))
            (unless (%null-ptr-p the-alias)
              (errchk (#_SetWindowProxyAlias (wptr w) the-alias))
              (setf (window-fsref w) fsref)  ;; keep that instead of window-filename ?
              (unless (%null-ptr-p the-alias)
                (#_disposehandle the-alias)))))))))

;; or do this instead of stashing fsref?
#+ignore
(defun get-proxy-filename (window)
  (let ((wptr (wptr window)))
    (rlet ((alias :pointer)
           (fsref :fsref)
           (was-changed :boolean))
      (errchk (#_getwindowproxyalias wptr alias))
      (errchk (#_FSResolvealias
               (%null-ptr)
               (%get-ptr alias)
               fsref
               was-changed))
      (%path-from-fsref fsref))))





(defmethod window-menu-item ((w fred-window))    
  (let* ((item (call-next-method))
         (mark))      
    (setq mark (saved-title-marker w))
    (set-menu-item-check-mark item (if (and mark (neq mark  #\space)) mark nil))
    item))



(defmethod ed-push-mark ((w fred-window) &optional a b)
  (ed-push-mark (current-key-handler w) a b))

(defmethod window-scroll ((w fred-window) &optional pos count)
  "count is the number of lines between the first line displayed and
   the line that POS is on. If this number is <= 0, then POS will be visible."
  (let* ((fred (window-key-handler w))
        (frec (frec fred)))
    (when (null count)
      (setq count (- (next-screen-context-lines (frec-full-lines frec)))))
    (frec-set-sel frec pos pos)   
    (set-fred-display-start-mark fred (frec-screen-line-start frec pos count))))

#|
; this doesn't work - apparently need to call window-update-event-handler before fred-update of fdi
;(defmethod window-scroll ((w fred-window) &optional pos count)
  "count is the number of lines between the first line displayed and
   the line that POS is on. If this number is <= 0, then POS will be visible."
  (let* ((fred (current-key-handler w)))
    (window-scroll fred pos count)
    (fred-update w)))
|#
; so the delegation stuff works
(defmethod fred-item ((w fred-window))
  (window-key-handler w))

; find a key handler that is not the mini-buffer
#+ignore
(defun window-key-handler (w)
  (let ((key (current-key-handler w))
        (mini (view-mini-buffer w)))
    (if (and key (neq key mini))
      key
      (dolist (x (key-handler-list w))
        (when (neq x mini)
          (return x))))))

(defun window-key-handler (w)
  (let ((key (current-key-handler w)))
    (if (and key (not (typep key 'mini-buffer-fred-item)))
      key
      (dolist (x (key-handler-list w))
        (when (not (typep x 'mini-buffer-fred-item))
          (return x))))))

(defmethod window-close ((w fred-window))
  (let ((fred (window-key-handler w)))
    (without-interrupts
     (when (and fred
                (not (and (slot-boundp fred 'frec)
                          (frec fred)
                          (window-ask-save w)))
                *save-position-on-window-close*)
       (view-save-position fred nil t))
     (let ((fsref (window-fsref w)))
       (when fsref 
         (setf (window-fsref w) nil)
         (#_disposeptr fsref)))
     (let ((frob (assq w *defs-dialogs*)))
       (when frob 
         (window-close (cdr frob))
         (setq *defs-dialogs* (delq frob *defs-dialogs*))))     
     (call-next-method))))


(defmethod window-size-parts ((w fred-window))
  (view-size-parts w))


(defmethod view-size-parts ((view fred-window))
  ; assumes that the parts HAD reasonable sizes!
  (let* ((direction (split-view-direction view))
         (size (view-size view))
         (h (point-h size))
         (v (point-v size))
         (views (ordered-subviews view))
         (mini (view-mini-buffer view))
         (pos -1))
    (when mini (setq mini (view-container mini)))
    (case direction      
      (:vertical
       (let* ((last (or mini (car (last views))))
              (old-height               
               (%i+ (point-v (view-position last))
                    (point-v (view-size last))
                    -1)))         
         (let ((len (length views))
               last)                 
           (multiple-value-bind (delta remainder) (truncate (%i-  v old-height) 
                                                            (if mini (1- len) len))
             (declare (fixnum delta remainder))
             (dolist (s views)
               (let* ((inc (cond ((> remainder 0) 1)
                                 ((< remainder 0) -1)
                                 (t 0)))
                      (size-v (if (eq s mini)
                                (point-v (view-size s))
                                (%i+ (point-v (view-size s)) delta inc))))
                 (declare (fixnum inc))
                 (setq remainder (- remainder inc))
                 (if (and (eq s mini) (view-named 'poof s))
                   (let ((size-v (point-v (view-size s)))
                         (h-scroller (h-scroller last)))
                     
                     (set-view-size s (%i+ h 2 -14 (- (if h-scroller (scroll-bar-length h-scroller) 0))) size-v)                     
                     (set-view-position  s -1 (%i- (%i+ (point-v (view-size last))
                                                    (point-v (view-position last)))
                                                 size-v)))
                   (progn                     
                     (set-view-size s (%i+ h 2) size-v)
                     (set-view-position s -1 pos)))
                 (setq last s)
                 (setq pos (%i+ pos size-v -1))))))))
      (t (error "asdf")))))

(defmethod set-view-size ((view split-view) h &optional v)
  (declare (ignore h v))
  (call-next-method)
  (view-size-parts view))

(defmethod view-size-parts ((view split-view))
  (let* ((direction (split-view-direction view))
         (size (view-size view))
         (h (point-h size))
         (v (point-v size))
         (views (ordered-subviews view))
         (last (car (last views)))
         (pos 0))
    (case direction      
      (:vertical
       (let* ((old-height (%i+ (point-v (view-position last))
                               (point-v (view-size last))
                               -1)))
         (unless nil ;(eql old-height (1- v))
           (multiple-value-bind (delta remainder)
                                (truncate (%i- (1- v) old-height) (length views))
             (declare (fixnum delta remainder))
             (dolist (s views)
               (let* ((inc (cond ((> remainder 0) 1)
                                 ((< remainder 0) -1)
                                 (t 0)))
                      (size-v (%i+ (point-v (view-size s)) delta inc)))
                 (setq remainder (- remainder inc))
                 (set-view-size s h size-v)
                 (set-view-position s 0 pos)
                 (setq pos (%i+ pos size-v -1))))))))
      (t
       (let* ((old-width (%i+ (point-h (view-position last))
                            (point-h (view-size last))
                            -1)))
         (multiple-value-bind (delta remainder)
                              (truncate (%i- (1- h) old-width) (length views))
           (declare (fixnum delta remainder))
           (dolist (s views)
             (let* ((inc (cond ((> remainder 0) 1)
                               ((< remainder 0) -1)
                               (t 0)))
                    (size-h (%i+ (point-h (view-size s)) delta inc)))
               (declare (fixnum inc))
               (setq remainder (- remainder inc))
               (set-view-size s size-h v)
               (set-view-position s pos 0)
               (setq pos (%i+ pos size-h -1))))))))))
    
    
    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; scroll-bar draggers 


(defmethod view-click-event-handler ((dragger bar-dragger) where)
  ;(declare (ignore where))
  ; his container is a fred-dialog-item today
  (let* ((direction (dragger-direction dragger))
         (superior (bar-dragger-superior dragger))
         (inferior (bar-dragger-inferior dragger superior)))    
    (when inferior
      (let* ((container (view-container superior))
             (inferior-min (view-minimum-size inferior))
             (s-tl (view-position superior))
             (s-br (add-points (view-position inferior)
                               (subtract-points (view-size inferior) #@(1 1)))))
        ;(format t "~% ~S ~S ~S ~s" direction superior inferior container)
        (when (double-click-p)
          (return-from view-click-event-handler
            (drag-split container dragger most-positive-fixnum direction t nil superior inferior)))
        (let* ((mouse-pos (convert-coordinates  where (view-container dragger) container)) ;(view-mouse-position container))
               (my-min (view-minimum-size superior))
               (pos (convert-coordinates (view-position dragger) 
                                         (view-container dragger)
                                         container)) 
               min  max min-pos max-pos drawn line-direction delta
               min-drag-pos max-drag-pos)
          (if (eq direction :vertical)
            (let* ()
              (setq min (point-h s-tl)     ; min and max are extent of line
                    max (- (point-h s-br) 2)
                    min-pos (point-v (view-position superior))  ; min-pos and max-pos are extent of drag or unsplit
                    max-pos (+ (point-v (view-position inferior))
                               (point-v (view-size inferior)) -1)
                    min-drag-pos (+ (point-v my-min) min-pos)   ; extent of drag
                    max-drag-pos (-  max-pos (point-v inferior-min))
                    pos (+ (point-v pos)(point-v (view-size dragger)))
                    delta (- pos (point-v mouse-pos))
                    line-direction :horizontal))
            (let* ()
              (setq min (point-v s-tl)
                    max (- (point-v s-br) 2)
                    min-pos (point-h (view-position superior))
                    max-pos (+ (point-h (view-position inferior))
                               (point-h (view-size inferior)) -1)
                    min-drag-pos (+ (point-h my-min) min-pos)
                    max-drag-pos (- max-pos (point-h inferior-min))
                    pos (+ (point-h pos)(point-h (view-size dragger)))
                    delta (- pos (point-h mouse-pos))
                    line-direction :vertical)))                             
          ;(format t "~% pos ~S min-pos ~S max-pos ~S" pos min-pos max-pos)
          (flet ((draw-line (pos)                   
                   (draw-dragger-outline
                    container dragger pos min max line-direction
                    (or (< pos min-drag-pos)(> pos max-drag-pos)))))
            (declare (dynamic-extent #'draw-line))
            (multiple-value-setq (pos drawn)
              (track-and-draw container #'draw-line pos direction delta min-pos max-pos)))          
          ; And call the user method to actually do something.
          (drag-split container dragger pos  direction drawn
                        (<= min-drag-pos pos max-drag-pos)
                        superior inferior))))))

#|
(defun track-and-draw (container function pos direction delta min-pos max-pos)
  (let* ((mouse-pos (view-mouse-position container))
         (wait-ticks 1) ; (max 1 (floor internal-time-units-per-second 30))) ; why a (* 16 33) = 528 ms delay?
         (time (get-internal-run-time))
         (size (view-size container))
         (drawn t))
    (with-focused-view container
      (with-pen-saved
        (#_PenPat *gray-pattern*)
        (#_PenMode (xfer-mode-arg :patxor))
        (funcall function pos)
        (unwind-protect
          (loop
            (unless (mouse-down-p) (return))
            (let* ((new-mouse (view-mouse-position container))
                   (new-pos (+ delta (case direction
                                       (:vertical (point-v new-mouse))
                                       (t (point-h new-mouse)))))
                   (in-range (and (<= min-pos pos max-pos)
                                  (point<= #@(0 0) mouse-pos size))))              
              (cond ((not (or (eql mouse-pos new-mouse)
                              (<= (get-internal-run-time) (+ time wait-ticks))))
                     (when (and drawn  (or (not (eql new-pos pos))(not in-range)))
                       (funcall function pos)
                       (setq drawn (not drawn))
                       (setq time (get-internal-run-time)))
                     (setq pos new-pos mouse-pos new-mouse)
                     (when (and (not drawn) in-range)
                       (setq time (get-internal-run-time))
                       (setq drawn (not drawn))
                       (funcall function  pos)))
                    (t ; mouse stalled - now do a redraw
                     (let ((wptr (wptr container)))
                         (when (ok-wptr wptr)
                           (#_QDFlushPortBuffer (#_GetWindowPort wptr) *null-ptr*)))
                       ))))
          (when drawn (funcall function pos)))))
    (values pos drawn)))
|#

#+ignore
(defun track-and-draw (container function pos direction delta min-pos max-pos)
  (let* ((mouse-pos (view-mouse-position container))
         (wait-ticks 1) ; (max 1 (floor internal-time-units-per-second 30))) ; why a (* 16 33) = 528 ms delay?
         (time (get-internal-run-time))
         (size (view-size container))
         (drawn t))
    (with-focused-view container
      (with-pen-saved
        (#_PenPat *gray-pattern*)
        (#_PenMode (xfer-mode-arg :patxor))
        (funcall function pos)
        (unwind-protect
          (with-timer
            (loop
              (unless (mouse-down-p) (return))
              (let* ((new-mouse (view-mouse-position container))
                     (new-pos (+ delta (case direction
                                         (:vertical (point-v new-mouse))
                                         (t (point-h new-mouse)))))
                     (in-range (and (<= min-pos pos max-pos)
                                    (point<= #@(0 0) mouse-pos size))))              
                (cond ((not (or (eql mouse-pos new-mouse)
                                (<= (get-internal-run-time) (+ time wait-ticks))))
                       (when (and drawn  (or (not (eql new-pos pos))(not in-range)))
                         (funcall function pos)
                         (setq drawn (not drawn))
                         (setq time (get-internal-run-time)))
                       (setq pos new-pos mouse-pos new-mouse)
                       (when (and (not drawn) in-range)
                         (setq time (get-internal-run-time))
                         (setq drawn (not drawn))
                         (funcall function  pos)))
                      (t ; mouse stalled - now do a redraw
                       (let ((wptr (wptr container)))
                         (when (ok-wptr wptr)
                           (#_QDFlushPortBuffer (#_GetWindowPort wptr) *null-ptr*)))
                       )))))
          (when drawn (funcall function pos)))))
    (values pos drawn)))

#-ignore
(defun track-and-draw (container function pos direction delta min-pos max-pos)
  (let* ((mouse-pos (view-mouse-position container))
         ;(wait-ticks 1)
         ;(time (get-internal-run-time))
         (size (view-size container))
         (drawn t))
    (with-focused-view container
      (with-pen-saved-simple
        (#_PenPat *gray-pattern*)
        (#_PenMode (xfer-mode-arg :patxor))
        (funcall function pos)
        (unwind-protect
          (with-timer
            (loop
              (when (not (#_stilldown))(return))
              (when (eql (%get-local-mouse-position) mouse-pos)
                (when (not (wait-mouse-up-or-moved))(return)))
              (let* ((new-mouse (%get-local-mouse-position))
                     (new-pos (+ delta (case direction
                                         (:vertical (point-v new-mouse))
                                         (t (point-h new-mouse)))))
                     (in-range (and (<= min-pos pos max-pos)
                                    (point<= #@(0 0) mouse-pos size))))                
                (when (and drawn  (or (not (eql new-pos pos))(not in-range)))
                  (funcall function pos)
                  (setq drawn (not drawn))
                  )
                (setq pos new-pos mouse-pos new-mouse)
                (when (and (not drawn) in-range)                  
                  (setq drawn (not drawn))
                  (funcall function  pos)))
              ))
          (when drawn (funcall function pos)))))
    (values pos drawn)))



(defmethod ordered-subviews (view)
  (declare (ignore view))
  nil)

(defmethod split-view-direction (view)
  (declare (ignore view))
  nil)


(defun bar-dragger-superior (dragger)
  (let* ((direction (dragger-direction dragger))
         (inner (view-container dragger)) 
         (outer (view-container inner)))
    (loop
      (when (null outer)(return inner))
      (when (neq inner (car (last (ordered-subviews outer))))
        (when (eq (split-view-direction outer) direction)
          (return inner)))
      (setq inner outer
            outer (view-container inner)))))

(defun bar-dragger-inferior (dragger superior)
  (declare (ignore dragger))
  (let* (;(direction (dragger-direction dragger))
         (container (view-container superior))
         (views (ordered-subviews container)))
    (do ((l views (cdr l)))
        ((null l))
      (when (eq (car l) superior)
        (return (cadr l))))))


(defun draw-dragger-outline (scrollee dragger pos min max direction flag)
  (declare (ignore scrollee))
  (if (eq direction :horizontal)
    (progn (#_MoveTo min pos)
           (#_LineTo max pos)
           (when (not flag)
             (setq pos (- pos (point-v (view-size dragger))))
             (#_moveto min pos)
             (#_lineto max pos)))             
    (progn (#_MoveTo pos min)
           (#_LineTo pos max)
           (when (not flag)
             (setq pos (- pos (point-h (view-size dragger))))
             (#_moveto pos min)
             (#_LineTo pos max)))))

(defmethod view-minimum-size ((view scrolling-fred-view))
  (let ((h-scroll (h-scroller view))
        (v-scroll (v-scroller view)))
    (make-point (+ (if h-scroll 45 15) (if v-scroll 17 0))
                (+ (if v-scroll 45 15) (if h-scroll 17 0)))))

(defmethod pane-splitter-outline-position ((view fred-item) scroll-bar mouse-pos)
  (declare (ignore mouse-pos))
  (add-points #@(1 1) (view-position (pane-splitter scroll-bar))))

(defmethod pane-splitter-limiting-container ((view fred-item))
  (view-container view))

(defmethod pane-splitter-corners ((view fred-item) scroll-bar)
  (declare (ignore scroll-bar))
  (values #@(0 0) (view-size (view-container view))))

(defmethod view-minimum-size ((view new-mini-buffer))
  #@(62 0))


(defmethod view-minimum-size ((view split-view))
  (view-minimum-size (car (ordered-subviews view))))

(defmethod view-minimum-size ((view simple-view))
  #@(45 45))

; pos is in split-view coordinates
(defmethod drag-split ((split-view split-view)
                       dragger pos direction drawn in-drag-range view-one view-two)
  ;(declare (ignore dragger))
  (when drawn 
    (let* ((pos-two (view-position view-two))
           (delta (- pos (if (eq direction :vertical)
                           (point-v pos-two)
                           (point-h pos-two))))
           (w (view-window view-one))
           (size1 (view-size view-one))
           (size2 (view-size view-two)))
      (when (not (= 0 delta)) ;(not (<= -1 delta 1))
        (cond
         (in-drag-range
            (case direction
              (:vertical
               (let* ((width (point-h size1)))                 
                 (set-view-position view-two  0 pos)
                 (set-view-size view-two width (- (point-v size2) delta))
                 (set-view-size  view-one  width (+ (point-v size1) delta))))
              (t (let* ((height (point-v size1)))                   
                   (set-view-position view-two pos 0)
                   (set-view-size view-two  (- (point-h size2) delta) height)
                   (set-view-size view-one (+ (point-h size1) delta) height))))            
            (kill-erase-region w) ; hit it with a hammer
            (validate-scroll-bar view-two (if (eq direction :vertical) :horizontal :vertical)))            
         (t
          (let ((container (view-container view-one))
                (fudge #@(0 0))
                (new-size (case direction
                            (:horizontal (make-point (+ (point-h size1)(point-h size2) -1)
                                                     (point-v size1)))
                            (t (make-point (point-h size1)
                                           (+ (point-v size1)(point-v size2) -1))))))
            ; with the mod that clicking in controls no longer changes key handler
            ; we can't assume that superior is the key handler
            (cond
             ((> delta 0) ; lose inferior, superior is and remains the key-handler
              (when (key-handler-in-p view-two)
                (set-current-key-handler w (find-a-key-handler view-one) nil))
              (setf (dragger-direction dragger)(dragger-direction view-two))
              (set-view-size view-one new-size)
              (remove-ordered-subview view-two container)
              (maybe-un-poof view-one direction w)
              ;(Fred-update view-one)
              )
             (t ; lose superior
              (when (key-handler-in-p view-one)
                (set-current-key-handler w (find-a-key-handler view-two) nil))              
              (when (not (remove-ordered-subview view-one container)) ; when it did not get promoted
                (when (eq (view-container view-two) w)
                  (setq fudge #@(1 1)))                
                (set-view-position view-two 
                                   (subtract-points (view-position view-one)
                                                    fudge)))
              
              (set-view-size view-two new-size)
              (maybe-un-poof view-two direction w)              
              )))))))))

(defun maybe-un-poof (view direction w)
  (when (and (eq direction :horizontal) (view-mini-buffer w))
    (when (and (eq (view-container view) w)(eq view (car (last (ordered-subviews w) 2 ))))  ;(typep (elt (ordered-subviews w) 0) 'split-view))
      (un-poof view (view-container (view-mini-buffer w))))))
  

(defmethod validate-scroll-bar ((view scrolling-fred-view) direction)
  (let ((scroll (if (eq direction :vertical)(v-scroller view)(h-scroller view))))    
    (when scroll
      (validate-corners view 
                        (scroll-bar-and-splitter-corners scroll)
                        (view-size view)))))

(defmethod validate-scroll-bar ((view split-view) direction)
  ; validate entire right or bottom edge of a split-view
  ; assumes that there are horizontal and vertical scroll bars on the edges
  ; and that they are standard width and full length
  (let ((size (view-size view)))    
    (validate-corners view 
                      (if (eq direction :vertical)
                        (make-point (- (point-h size) 16) 0)
                        (make-point 0 (- (point-v size) 16)))
                      size)))

(defun view-superior-p (v1 v2)
  (let* ((c (view-container v1))
         (views (ordered-subviews c)))
    (do ((l  views (cdr l)))
        ((null l) nil)
      (when (eq (car l) v1)
        (return (eq (cadr l) v2))))))

(defmethod dragger-direction ((view split-view))
  (dragger-direction (car (last (ordered-subviews view)))))

(defmethod dragger-direction ((view scrolling-fred-view))
  (let ((dragger (bar-dragger view)))
    (when dragger (dragger-direction dragger))))

(defun remove-ordered-subview (view container)
  (without-interrupts
   (let ((newsub (nremove view (ordered-subviews container))))
     (cond
      ((null (cdr newsub))
       ; only one left - pfooey
       ; the single remaining view replaces container in container's container
       (let* ((last (car newsub)) ; is the single remaining view in a split-view
              (outer (view-container container)))
         (progn ;with-preserved-buffers last           
           (if (typep outer 'split-view)
             (progn
               (view-subst last container outer))
             (progn
               (set-view-size last (view-size container))
               (set-view-position last (view-position container))
               (set-view-container last outer)
               (set-view-container container nil)))
           (when (typep outer 'window) ; need in same order (minibuffer last) for redraw
                 (reorder-subviews outer)))
         t))     
      (t (setf (ordered-subviews container) newsub)
         (set-view-container view nil)
         (when (typep container 'window) 
           (reorder-subviews container))
         nil)))))

(defun reorder-subviews (outer)
  ; having two representations of subviews is pretty silly.
  ; do this so mini-buffer is last - still all but first subview are drawn twice
  (let* ((newsub (ordered-subviews outer))
         (subviews (view-subviews outer)))
    (do* ((i 0 (1+ i))
          (lis newsub (cdr lis)))
         ((null lis))
      (setf (elt subviews i) (car lis)))))

(defun view-subst (new old container)
  (let* ((outer-subs (ordered-subviews container))
         direction)
    (if (and (typep new 'split-view)
             (eq (setq direction (split-view-direction  new))
                 (split-view-direction container)))
      ; replace old with subviews of new
      (let ((inner-subs (ordered-subviews new)))        
        (let* ((p (view-position old))
               (d (case direction
                    (:vertical (point-v p))
                    (t (point-h p))))
               (fudge (if (typep container 'window) 1 0)))          
          (dolist (s inner-subs)                  
            (let ((spos (view-position s)))
              (case direction
                (:vertical
                 (set-view-position s (- (point-h spos) fudge)
                                    (- (+ d (point-v spos)) 0)))
                (t (set-view-position s (+ d (point-h spos))
                                      (point-v spos)))))
            (set-view-container s container)))
        (do ((last nil l)
             (l outer-subs (cdr l)))
            ((null l))
          (when (eq old (car l))
            (cond
             (last (rplacd last inner-subs)
                   (rplacd (last inner-subs)(cdr l)))
             (t (rplacd (last inner-subs) (cdr l))
                (setf (ordered-subviews container) inner-subs)))
            (return))))
      (progn 
        ; just replace old with new        
        (set-view-position new (view-position old))
        (nsubst new old outer-subs)
        (set-view-container new container)))
    (set-view-container old nil)))



 ; too complicated if one has split the view above the mb - so don't do it
(defmethod un-poof (last mb)
  (let* ((w (view-window last))
         ;(mb (view-container (view-mini-buffer w)))
         (size (view-size mb))
         (status (view-status-line w)))
    (when status (set-view-container status nil))
    (remove-scroller mb :horizontal)
    (remove-scroller mb :vertical)
    (set-view-container (bar-dragger last) nil)
    (set-view-size mb (point-h size) 16)    
    (make-instance 'poof-button
      :view-size #@(16 16)
      :view-position #@(-3000 -3000)
      :view-nick-name 'poof
      :view-container mb)    
    (set-view-position mb -1 (- (point-v (view-size w))
                                15))    
    (setf (h-scroll-fraction last) 4)    
    (let* ((scroller (h-scroller last))
           (splitter (pane-splitter scroller)))
      (set-pane-splitter-position scroller :right)
      (setf (pane-splitter-cursor splitter) *right-ps-cursor*))
    (set-view-size last (point-h (view-size last))(+ (point-v (view-size last)) (point-v size) -1))    
    ; gets the mini-buffer size adjusted for the size of the scroll bar
    (view-size-parts w)    
    (mini-buffer-update w)))



(defmethod add-remove-scroll-bars ((view new-mini-buffer))
  (let ((w (view-window view))
        (v (point-v (view-size view))))
    (if (h-scroller view)                  
      (when (<= v 30)
        (remove-scroller view :horizontal)
        (let ((status (view-status-line w)))
          (when status (set-view-container status nil)))
        (mini-buffer-update w)
        (view-size-parts view))
      (when (> v 30)
        (add-scroller view :horizontal)
        (setf (h-scroll-fraction view) 4)
        (make-instance 'static-text-dialog-item
          :view-nick-name 'status-line
          :view-container view
          :dialog-item-text ""
          :view-font (view-font view))                   
        (view-size-parts view)
        (stream-fresh-line (view-mini-buffer w))
        (mini-buffer-update w)
        ))
    (if (v-scroller view)
      (when (<= v 55)
        (remove-scroller view :vertical))
      (when (> v 55)
        (add-scroller view :vertical)))))

;don't nuke bottom-most subview and positions in a window differ from those in a view

(defmethod drag-split ((w fred-window) 
                       dragger pos direction drawn in-drag-range view-one view-two)
  (when drawn
    (if (eq direction :horizontal) (error "asdf"))
    (let* ((delta (- pos (point-v (view-position view-two))))
           (subviews (ordered-subviews w))
           (size1 (view-size view-one))
           (size2 (view-size view-two)))
      (when (not (= 0 delta))
        (cond 
         (in-drag-range
          (let* ((width (point-h size1))
                 (mb (view-container (view-mini-buffer w)))
                 (v (- (point-v size2) delta)))
            (when (eq view-two mb)
              (when (<= v 15)
                (when (not (typep view-one 'split-view))
                  (un-poof  view-one view-two))
                (return-from drag-split nil)))
            (set-view-position view-two -1 pos)
            (set-view-size view-one width (+ (point-v size1) delta))
            (set-view-size view-two width v)
            (if (eq view-two mb)
              (add-remove-scroll-bars mb)
              (progn 
                (kill-erase-region (view-window view-one))
                (validate-scroll-bar view-two :horizontal)))))
         (t (when (> (length subviews) 2)
              (cond
               ((> delta 0) ; lose inferior - unless last
                (when (eq view-two (car (last subviews)))
                  (return-from drag-split nil))
                (let* ((mb (view-mini-buffer w))
                       (mb-container (and mb (view-container mb)))
                       (poof (and mb (view-named 'poof mb-container))))
                  (when (and poof (view-superior-p view-two mb-container))
                    (if (typep view-one 'split-view)
                      (progn  (poof view-two mb-container)
                              (setq size2 (view-size view-two)))
                      (progn 
                        (set-view-container dragger nil)
                        (let* ((scroller (h-scroller view-one))
                               (splitter (pane-splitter scroller)))
                          (when splitter
                            (set-pane-splitter-position scroller :right)
                            (setf (pane-splitter-cursor splitter) *right-ps-cursor*)))
                        (setf (h-scroll-fraction view-one) 4)))))                          
                (when (key-handler-in-p view-two)
                  (set-current-key-handler w (find-a-key-handler view-one) nil))
                (remove-ordered-subview view-two w))             
               (t ; lose superior
                (when (key-handler-in-p view-one)
                  (set-current-key-handler w (find-a-key-handler view-two) nil))                  
                (remove-ordered-subview view-one w)                  
                (set-view-position view-two (view-position view-one))
                (setq view-one view-two)))            
              (set-view-size view-one 
                             (point-h size1)
                             (+ (point-v size1) (point-v size2) -1)))))))))


(defmethod find-a-key-handler ((view scrolling-fred-view))
  (fred-item view))

(defmethod find-a-key-handler ((view split-view))
  (dolist (v (ordered-subviews view) nil)
    (let ((k (find-a-key-handler v)))
      (when k (return k)))))

(defmethod key-handler-in-p ((view split-view))
  (dolist (v (ordered-subviews view) nil)
    (when (key-handler-in-p v)(return t))))

(defmethod key-handler-in-p ((view scrolling-fred-view))
  (eq (current-key-handler (view-window view)) (fred-item view)))



; why scrolling-fdi  is not a dialog item - unnecessary dialog-item baggage
; dialog-item-text
; dialog-item-handle
; dialog-item-enabled-p ?
; dialog-item-action-function
; line-height  ; goes away anyway
; font-ascent  ; ditto
; draw-outline


(defmethod fred-shadowing-comtab ((v simple-view))
  (declare (ignore v))
  nil)



(comtab-set-key *control-x-comtab* '(:control #\y) 'ed-yank-file)

; this changes the order of subviews which changes the order in which subviews
; are drawn 
;; this gets nasty error in MCL versions after 5.0
#+ignore
(defmethod ed-yank-file ((item window-fred-item))
  ; probably a bad idea to do this into the "mini-buffer"
  ; also need to check that it isn't already open here or elsewhere
  ; and check that what was there is not the last instance of
  ; something that has changed
  (let* ((size (view-size item))
         (pos (view-position item))
         (container (view-container item))
         (h-scroll (h-scroller container))
         (v-scroll (v-scroller container))
         (file (catch-cancel (choose-file-dialog :mac-file-type :text))))
      (when (neq file :cancel)        
        (set-view-container item nil) ; more to do here?????
        ; have to fix the scrollee of the pane-splitter
        ; and the scroll-bars
        (setq item (make-instance 'window-fred-item 
                     :view-container container
                     :view-nick-name 'fred-item
                     ;:draw-outline nil
                     :view-size size
                     :view-position pos
                     ;:save-buffer-p t
                     :filename file))
        (when h-scroll
          (setf (slot-value h-scroll 'scrollee) item))
        (when v-scroll
          (setf (slot-value v-scroll 'scrollee) item))
        (dovector (v (view-subviews container))
          (when (typep v 'pane-splitter)
            (setf (slot-value v 'scrollee) item)))
        (set-current-key-handler (view-window container) item nil))))

;; not really the same but at least doesn't fail
(defmethod ed-yank-file ((item window-fred-item))
  ; probably a bad idea to do this into the "mini-buffer"
  ; also need to check that it isn't already open here or elsewhere
  ; and check that what was there is not the last instance of
  ; something that has changed
  (let* (;(size (view-size item))
         ;(pos (view-position item))
         ;(container (view-container item))
         ;(h-scroll (h-scroller container))
         ;(v-scroll (v-scroller container))
         (file (catch-cancel (choose-file-dialog :mac-file-type :text))))
      (when (neq file :cancel)
        (let ((buf (fred-buffer item)))
          (buffer-delete buf 0 t)
          (buffer-insert-file buf file)
          (set-file-external-format item (utf-something-p file))
          (set-mark buf 0)
          (set-window-filename item file)
          (window-set-not-modified item)))))

(defmethod ed-yank-file ((item mini-buffer-fred-item))
  (ed-beep))

        


#|; should look at all fdi's - currently same as def in fred-additions
;(defun pathname-to-window (pathname &aux wpath)
  (setq pathname (or (probe-file pathname)
                     (probe-file (merge-pathnames pathname *.lisp-pathname*))
                     ;Default type to :unspecific, since that's what
                     ;a window-filename would have.
                     (let ((fpath (full-pathname pathname)))
                       (if (null fpath)
                         (file-namestring pathname) 
                         (merge-pathnames fpath #1P"")))))
  (dolist (w1 (windows :include-invisibles t))
    (if (and (setq wpath (window-filename w1))
             (or (equalp pathname wpath)
                 (equalp pathname (full-pathname wpath))))
        (return w1))))
|#

#| we moved this stuff to color.lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; This  adds color to font specs and Fred windows & dialog items.
;;; A font spec can have one of 256 colors. The colors are represented
;;; by their index in the system 8-bit color table, with the exception
;;; that color index 0 means use the default foreground color.
;;;
;;; A font spec can now have a (:color x) or (:color-index y) entry.
;;; x is a 24-bit MCL color, as returned by make-color
;;; y is an integer between 0 and 255 inclusive.
;;; Examples: (font-codes '("Monaco" 12 :bold (:color #.*red-color*)))
;;;           (font-codes '("Chicago" 9 (:color-index 5)))
;;;
;;; should we be conditional on *color-available* which isnt defined till later?

;;; should we be conditional on *color-available* which isnt defined till later?
;;; It shouldn't be later, initializing it is on *lisp-system-pointer-functions*
;;; and this is on *lisp-user-pointer-functions*.  -- K‡lm‡n

(defun initialize-fred-palette ()
  (let (ctable)
    (if *color-available*
      (unwind-protect
        (progn
          (setq ctable (#_GetCTable 72))
          (when (%null-ptr-p ctable)
            (error "Can't allocate color table"))
          (let* ((entries (1+ (href ctable :colorTable.ctSize)))
                 (palette (#_NewPalette entries ctable #$pmCourteous 0)))
            (when (%null-ptr-p palette)
              (error "Couldn't allocate palette"))
            #|
          (rlet ((rgb :RGBColor
                      :red 0 :green 0 :blue 0))
            (#_SetEntryColor palette 0 rgb)
            (setf (pref rgb :RGBColor.red) 65535
                  (pref rgb :RGBColor.green) 65535
                  (pref rgb :RGBColor.blue) 65535)
            (#_SetEntryColor palette (1- entries) rgb))
          |#
            (setq *fred-palette* palette)))
        (when (and ctable (not (%null-ptr-p ctable)))
          (#_DisposeCTable ctable)))
      (setq *fred-palette* nil))
    )
  nil)
|#

#| ; moved to "ccl:lib;color.lisp"
(def-load-pointers initialize-fred-color-table ()
  (initialize-fred-palette))
|#

; or something like this
(def-ccl-pointers initialize-foreground-rgb ()
  (setq *default-foreground-rgb* (make-record :rgbcolor))
  (with-port %temp-port%
    (#_getforecolor *default-foreground-rgb*)))

; maybe with-fore-color should interact with this too.
; also if index is same as last index - do nothing.

; Callers of this should be wrapped in with-foreground-rgb.
(defun set-grafport-fred-color (index)
  (when *fred-palette*
    (if (and (eql index 0) *default-foreground-rgb*)
      (#_RGBForeColor *default-foreground-rgb*)
      (rlet ((rgb :RGBColor))
        (#_GetEntryColor *fred-palette* index rgb)
        (#_RGBForeColor rgb)))))

#| ; moved to l1-edcmd
(defun fred-palette-closest-entry (color)
  (if *fred-palette*
    (palette-closest-entry *fred-palette* color t)
    *black-color*)
  )

; This is wrong, but simple: cartesian distance in the RGB cube is
; not a very good measure of color closeness.
; palette is a palette handle
; color is an MCL 24-bit color
(defun palette-closest-entry (palette color &optional ignore-0)
  (flet ((hi8 (x) (round x 256)))
    (multiple-value-bind (red green blue) (color-values color)
      (setq red (hi8 red)
            green (hi8 green)
            blue (hi8 blue))
      (let ((distance (* 3 256 256))
            (index 0))
        (flet ((square (x) (* x x)))
          (rlet ((rgb :RGBColor))
            (dotimes (i (href palette :palette.PMEntries))
              (unless (and ignore-0 (eql i 0))
                (#_GetEntryColor palette i rgb)
                (let ((d (+ (square (- red (hi8 (pref rgb :RGBColor.red))))
                            (square (- green (hi8 (pref rgb :RGBColor.green))))
                            (square (- blue (hi8 (pref rgb :RGBColor.blue)))))))
                  (when (< d distance)
                    (setq distance d
                          index i)
                    (when (eq d 0) (return))))))))
        index))))
|#

#|
(defclass fred-color-table-view (view) ())

(defclass fred-color-table-window (fred-color-table-view window) 
  ()
  (:default-initargs
    :color-p t
    :grow-icon-p nil
    :view-size #.(let ((size 8)) (make-point (* size 32) (* size 8)))))

;(defmethod view-draw-contents ((view fred-color-table-view))
  (let* ((size (view-size view))
         (h (point-h size))
         (v (point-v size))
         (h/32 (floor h 32))
         (v/8 (floor v 8)))
    (setq h (* h/32 32)
          v (* v/8 v))
    (dotimes (i 9)
      (let ((v-i (* i v/8)))
        (#_MoveTo 0 v-i)
        (#_LineTo h v-i)))
    (dotimes (i 33)
      (let ((h-i (* i h/32)))
        (#_MoveTo h-i 0)
        (#_LineTo h-i v)))
    (rlet ((oldRGB :RGBColor))
      (#_GetForeColor oldRGB)
      (unwind-protect
        (let ((index 0))
          (dotimes (row 8)
            (let ((v-i (1+ (* row v/8))))
              (dotimes (column 32)
                (let ((h-i (1+ (* column h/32))))
                  (rlet ((rect :rect :top v-i
                               :left h-i
                               :bottom (+ v-i (- v/8 1))
                               :right (+ h-i (- h/32 1))))
                    (rlet ((rgb :RGBColor))
                      (#_GetEntryColor *fred-palette* index rgb)
                      (#_RGBForeColor rgb)
                      (#_FillRect rect *black-pattern*))
                    (incf index))))))))
        (#_RGBForeColor oldRGB)))))

(make-instance 'fred-color-table-window)
|#

(defun buffer-color-vector (buf &optional (start buf) (end t))
  (setq start (buffer-position buf start))
  (setq end (buffer-position buf (or end t)))
  (when (< end start)
    (psetq start end end start))
  (if (eql start end)
    (let ((color (logand #xff (point-h (buffer-char-font-codes buf start)))))
      (unless (eql color 0)  ; fix to not do if color 0 6/9 95
        (let ((vect (make-array 2 :element-type '(unsigned-byte 16))))
          (setf (uvref vect 0) 1)           ; 1 font
          (setf (uvref vect 1) (logand #xff (point-h (buffer-char-font-codes buf start))))
          vect)))
    (let* ((the-buf (mark-buffer buf))
           (nfonts (+ 2 (ash (length (bf.flist the-buf)) -1)))
           (seen-array (make-array nfonts :initial-element nil))
           (color-array (make-array nfonts :initial-element nil))
           (count 0)
           (non-zero? nil))
      (declare (dynamic-extent seen-array color-array))
      (flet ((process-index (index)
               (unless (aref seen-array index)
                 (let ((color (logand 255 (point-h (buffer-font-index-codes buf index)))))
                   (unless (eql color 0)
                     (setq non-zero? t))
                   (setf (aref seen-array index) t
                         (aref color-array count) color)
                   (incf count)))))
        (declare (dynamic-extent #'process-index))
        (process-index (buffer-empty-font-index buf))
        (loop
          (when (or (null start) (>= start end)) (return))
          (process-index (buffer-char-font-index buf start))
          (setq start (buffer-next-font-change buf start))))
      (when non-zero?
        (let ((vector (make-array (the fixnum (1+ count)) :element-type '(signed-byte 16))))
          (setf (aref vector 0) count)
          (dotimes (i count)
            (setf (aref vector (1+ i)) (aref color-array i)))
          vector)))))
                 

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
