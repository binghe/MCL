; -*- Mode:Lisp; Package:INSPECTOR; -*-

;;	Change History (most recent first):
;;  11 5/7/95  slh  balloon help mods.
;;  9 4/28/95  akh  make minimum size bigger for list views
;;  8 4/24/95  akh  window-can-do-operation - no undo-more etc
;;  7 4/12/95  akh  no more edit-value button in processes-inspector
;;  5 4/10/95  akh  make edit-value button disabled when appropriate
;;  3 4/7/95   akh  put back "edit value" button, make "resample" be default button
;;  2 4/6/95   akh  use 3d-button, add crescent to pull-down-menu
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  inspector-window.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  inspect/describe/backtrace user-interface
;;

(in-package :inspector)

;; Change history
;; compute-window-title - substitute something for eol's if thing is a string
;; copy for inspector-view uses put-scraps
;; ----- 5.2b5
;; eql #\newline -> char-eolp
;; ----- 5.2b4
;; back to "Geneva" 10 to make Toomas Altosaar happy
;; ----- 5.2b1
;; dont say moveto :word ..., use #_getregionbounds
;; "Geneva" 10 => "Courier" 12 - somewhat less ugly
;; use ccl::truncate-string
;; ------- 5.1 final
;; set-initial-stuff no longer uses *window-default-top-right* which isn't kept up to date - from Gary King
;; -------- 5.1b3
;; inspector-editor gets theme-background and cancel-button  is declared
;; set-view-size :after ((view inspector-view) - always invalidate-view
;; ----- 5.1b2
;; command-pane is theme-background-view
;; reinstate use of #_stilldown - not evil in this context!
;; ----- 5.1b1
;; lose #_stilldown - it's evil
;; fix temp-regions - does it matter? probably not
;; ------- 5.0 final
;; akh no more "chicago"
;; --------- 4.4b3
;; 01/27/97 bill  view-default-position no longer returns the maximum
;;                integer point. This keeps it from overflowing into
;;                a cons when you add the window size.
;; -------------  4.0
;; 05/17/96 bill  David B. Lamkins patch to (method scroll-bar-changed (inspector-pane t)).
;;                This makes continuous scrolling update correctly when a windoid
;;                is in front of the inspector window.
;; -------------- MCL-PPC 3.9
;; 03/18/96 bill  scroll-view uses #_ScrollRect instead of #_CopyBits so
;;                that it will work correctly if the window is partially off-screen
;;                of obscured by a windoid.
;; 01/04/96 bill  1 more pixel of overhead-height in set-initial-stuff
;; 12/27/95 gb    make-cache make-array call.
;;  6/08/95 slh   help-specs
;; -------------- 3.0d17
;; highlight-selection was off by one in inactive case
;; make-button-list-window/view not used, fix paste for inspector-window - no edit button today
;; 07/15/93 bill  Mark Nahabedian's fix to view-line-font-info
;; -------------- 3.0d12
;; 06/21/93 alice make-cache-entry-stream - character => base-character
;; 05/05/93 bill  in add-command-pane-items - button-size no longer used. Nuke it.
;; 04/28/93 bill  fencepost in RESAMPLE's clearing of selection
;; 04/27/93 bill  (method stream-write-string :after (cache-entry-stream)) increments stream-column
;; -------------- 2.1d5
;; 04/17/93 alice resample-button is its default-size, position via ceiling not floor 
;; -------------- 2.0
;; 03/10/93 alice inspector-editor buttons were not tall enough - UI makeover stuff
;; 02/02/93 alicd pop-ups enable with menu-enable not dialog-item
;; 01/18/93 alice pop-up => pull-down, allow non-zero vertical pos of inspector-view
;; 03/02 93 bill  %hilite-region now looks up its constants rather than
;;                hard-coding them in.
;; 01/07/92 gb    don't require RECORDS.
;; 10/31/91 bill  allow arbitrary initargs in the specs for make-button-list-view
;; 10/16/91 bill  *undo-menu-item* is no more, view-can-undo-p isn't exported, so it doesn't need to be generic
;; 10/15/91 bill  Make room for the cute little System 7 triangle in the "Commands" menu
;; 09/02/91 bill  don't error on option-click in empty space of inspector window.
;;----------- 2.0b3
;; 08/24/91 gb    use new trap syntax.
;; 07/27/91 alice window-can-undo-p => window-can-do-operation
;; 07/21/91 alice cut ((pane inspector-pane)) => copy (inspector-view pane)
;; 07/09/91 bill add "ccl::" package prefix for unexported symbols
;; 05/17/91 bill nuke *history-window*
;; 04/30/90 alms make-inspector-window asks inspector what class of window
;;                and what class of inspector-view
;; 05/06/91 bill undo-view-mixin for use by backtrace.
;; 04/25/91 bill add a little checking for uninitialized inspector windows
;;               to code called by find-inspector-pane
;; 04/03/91 bill in draw-cache-entry - the catch was around too much.
;; 03/26/91 bill Outline the selection when the window is not active.
;; 03/25/91 bill the scroll-bar becomes the first subview of an inspector-pane
;;               so that it draws first.
;; 03/14/91 bill with-errorfree-printing around draw-inspector-view-internal
;; 03/04/91 bill *inspector-history* defaults to empty.
;;----------- 2.0b1
;; 01/28/91 bill in draw-cache-entry: (catch (line-truncation-tag ...) ...)
;; 01/08/91 bill convert to new traps
;; 01/01/91 bill (method resample (inspector-view)) updates the command-pane and window-title
;; 12/13/90 bill make-button-list-window needed a :min-width 10 pixels wider.
;; 11/20/90 bill set-view-size of bottom-line-mixin inval'd wrong on v change.
;;               inspector-window inherits it's default-font.
;; 10/30/90 alice add-command-pane-item back to defmethod
;; 10/24/90 bill changed many defmethod's to defun's
;; 10/15/90 bill edit-value
;; 10/03/90 bill Change history added.

(eval-when (compile load eval)
  (require :scroll-bar-dialog-items)
  (require :pop-up-menu))


(defclass inspector-view (font-size-manager)
  ((inspector :reader inspector :accessor inspector-slot :initform nil)
   (start-line :initarg :start-line :reader start-line :initform 0)
   (pretty-p :initarg :pretty-p :reader pretty-p :initform nil)
   (cache-p :reader cache-p :initform t :initarg :cache-p)
   (cache :accessor cache :initform nil)
   (line-positions :accessor line-positions
                   :initform (make-array 10 :fill-pointer 0 :adjustable t))
   (selection :accessor selection :initform nil)
   (highlight-region :initform nil))
  (:default-initargs
   :page-truncation-tag :end-of-page
   :line-truncation-tag :end-of-line
   :margin 3))

(defmethod initialize-instance ((view inspector-view) &key inspector inspector-object)
  (call-next-method)
  (if inspector
    (setf (inspector view) inspector)
    (setf (inspector-object view) inspector-object)))

(defmethod view-draw-contents ((view inspector-view))
  (multiple-value-bind (ff ms) (view-font-codes (view-window view))
    (with-font-codes ff ms
      (unhighlight-selection view)
      (clear-margin view)                   ; For moving between color & non-color screens
      (let ((line-positions (line-positions view)))
        (setf (fill-pointer line-positions) 1)
        (setf (aref line-positions 0) 0))   ; first line always at 0
      (draw-inspector-view-internal view)
      (highlight-selection view))))

(defun draw-inspector-view-internal (view &optional
                                         (start-line (start-line view)) end-line (vpos 0))
  (let ((inspector (inspector view)))
    (when inspector
      (with-errorfree-printing
        (with-focused-view view             ; simple-view's don't get focused
          (let* ((pretty-p  (pretty-p view))
                 (*print-pretty* pretty-p)
                 (*print-circle* (and pretty-p *print-circle*))
                 (*print-right-margin* 
                  (floor (point-h (view-size view)) (string-width "N")))
                 (cache-p (and (not pretty-p) (cache-p view)))
                 (real-end-line (or end-line (inspector-line-count inspector))))
            (with-preserved-stream-font view
              (set-stream-font view '(:srccopy))
              (catch (page-truncation-tag view)
                (if (eql 0 vpos)
                  (top-of-page view)
                  (progn
                    (setf (newline-pending? view) nil)
                    (#_MoveTo (margin view) vpos)))
                (if cache-p
                  (draw-cached view start-line real-end-line)
                  (draw-uncached view start-line real-end-line))
                (unless end-line
                  (clear-to-eop view))))))))))

(defun draw-uncached (inspector-view start-line end-line)
  (setf (caar (fsm-font-codes inspector-view)) nil)   ; force font to be sampled first time.
  (map-lines (inspector inspector-view)
             #'(lambda (i value &rest rest)
                 (declare (dynamic-extent rest))
                 (catch (line-truncation-tag inspector-view)
                   (apply #'prin1-line i inspector-view value rest))
                 (add-line-position inspector-view)
                 (stream-tyo inspector-view #\newline))
             start-line
             end-line))

(defun add-line-position (view)
  (vector-push-extend (+ (point-v (%getpen))
                         (descent (a-d-l view)))
                      (line-positions view)))


;;;;;;;
;;
;; PRINT is too slow to use as the only refresh mechanism
;; Therefore, need to cache printed strings:

(defclass cache-entry ()
  ((value :accessor cache-entry-value)
   (label :accessor cache-entry-label)
   (type :accessor cache-entry-type)
   (font-declarations :initform nil :accessor cache-entry-font-declarations)
   (actions :initform nil :accessor cache-entry-actions)))

(defclass cache-entry-stream (truncating-string-stream)
  ((cache-entry :initform nil :accessor cache-entry)
   (font-codes :initform (list 0 0) :initarg :font-codes :accessor ces-font-codes)
   (column :initform 0 :accessor stream-column)))

(defmethod init-cache-entry-stream (stream &optional cache-entry)
  (setq stream (require-type stream 'cache-entry-stream))
  (let ((font-codes (ces-font-codes stream)))
    (setf (car font-codes) 0
          (cadr font-codes) 0))
  (setf (stream-column stream) 0)
  (setf (cache-entry stream) cache-entry)
  stream)

(defmethod push-action ((ce cache-entry) function &rest args)
  (push (cons function args) (cache-entry-actions ce)))

(defmethod push-action ((stream cache-entry-stream) function &rest args)
  (declare (dynamic-extent args))
  (apply #'push-action (cache-entry stream) function args))

(defun nreverse-actions (cache-entry)
  (setf (cache-entry-actions cache-entry)
        (nreverse (cache-entry-actions cache-entry))))

(defun push-write-string (stream)
  (let* ((string (get-output-stream-string stream))
         (length (length string)))
    (unless (eql length 0)
      (push-action (cache-entry stream)
                   #'already-focused-stream-write-string
                   string 0 length))))

(defvar *newline-substitute* nil)

(defmethod stream-tyo ((stream cache-entry-stream) char)
  (if (ccl::char-eolp char) ;(eql char #\newline)
    (if *newline-substitute*
      (progn
        (call-next-method stream *newline-substitute*)
        (incf (stream-column stream)))
      (progn
        (push-write-string stream)
        (push-action stream #'stream-tyo char)
        (setf (stream-column stream) 0)))
    (progn
      (call-next-method)
      (incf (stream-column stream))))
  char)

(defmethod stream-write-string :after ((stream cache-entry-stream) string start end)
  (declare (ignore string))
  (incf (stream-column stream) (- end start)))

(defmethod stream-font-codes ((stream cache-entry-stream))
  (apply #'values (ces-font-codes stream)))

(defmethod declare-stream-font-info ((stream cache-entry-stream)
                                     ascent descent maxwid leading)
  (push-write-string stream)
  (let ((cache-entry (cache-entry stream)))
    (unless (cache-entry-font-declarations cache-entry)
      (setf (cache-entry-font-declarations cache-entry)
            (list ascent descent leading maxwid)))
    (push-action cache-entry #'declare-stream-font-info ascent descent maxwid leading)))

(defmethod set-stream-font-codes ((stream cache-entry-stream) ff ms &optional 
                                  ff-mask ms-mask)
  (let* ((font-codes (ces-font-codes stream))
         (old-ff (car font-codes))
         (old-ms (cadr font-codes)))
    (multiple-value-bind (ff ms) (merge-font-codes old-ff old-ms ff ms
                                                   ff-mask ms-mask)
      (unless (and (eql ff old-ff) (eql ms old-ms))
        (setf (car font-codes) ff
              (cadr font-codes) ms)
        (push-write-string stream)
        (push-action stream #'(lambda (view ff ms ff-mask ms-mask)
                                (declare (ignore view))
                                (set-grafport-font-codes ff ms ff-mask ms-mask))
                     ff ms ff-mask ms-mask)))))

(defun draw-cached (view start-line end-line)
  (setq view (require-type view 'inspector-view))
  (let* ((inspector (inspector view))
         (cache (cache view)))
    (do ((line start-line (1+ line)))
        ((>= line end-line))
      (let ((cache-entry (aref cache line)))
        (unless cache-entry
          (setq cache-entry
                (setf (aref cache line)
                      (compute-cache-entry view inspector line))))
        (draw-cache-entry view cache-entry)
        (add-line-position view)))))

; Won't quite fill a big screen in a small font.
; Change it if you really need such long strings.
(defparameter *max-cached-string-length* 254)

(defun make-cache-entry-stream (&optional (length *max-cached-string-length*))
  (make-instance 'cache-entry-stream
                 :string (make-array length :element-type 'base-character :fill-pointer 0)))

(defparameter *cache-entry-stream* (make-cache-entry-stream))

(defun compute-cache-entry (view inspector line)
  (let* ((stream (or *cache-entry-stream* (make-cache-entry-stream)))
         (*cache-entry-stream* nil)
         (cache-entry (make-instance 'cache-entry)))
    (init-cache-entry-stream stream cache-entry)
    (multiple-value-bind (ff ms) (stream-font-codes view)
      (let ((font-codes (ces-font-codes stream)))
        (setf (car font-codes) ff
              (cadr font-codes) ms)))
    (flet ((doit (value &optional label type &rest rest)
             (declare (dynamic-extent rest))
             (catch :truncate
               (let ((*newline-substitute* #\¦))
                 (apply #'prin1-line inspector stream value label type rest)))
             (setf (cache-entry-value cache-entry) value
                   (cache-entry-label cache-entry) label
                   (cache-entry-type cache-entry) type)))
      (declare (dynamic-extent #'doit))
      (multiple-value-call #'doit (line-n inspector line)))
    (push-write-string stream)
    (nreverse-actions cache-entry)
    (setf (cache-entry stream) nil)
    cache-entry))

(defmethod call-with-preserved-stream-font ((stream cache-entry-stream) thunk)
  (let* ((font-codes (ces-font-codes stream))
         (ff (car font-codes))
         (ms (cadr font-codes)))
    (unwind-protect
      (funcall thunk)
      (setf (car font-codes) ff
            (cadr font-codes) ms))))

(defun draw-cache-entry (view cache-entry)
  (with-font-codes nil nil
    (catch (line-truncation-tag view)
      (dolist (action (cache-entry-actions cache-entry))
        (apply (car action) view (cdr action))))
    (stream-tyo view #\newline)))

;;;;;;;
;;
;; Higlighting
;;

; Invert a region using the highlight color (see Inside Mac V-62)
#|
(defun %invert-region (rgn)
  (with-macptrs ((hiliteMode (%int-to-ptr #$HiliteMode)))
    (%put-byte hiliteMode
               (logand (lognot (ash 1 #$hiliteBit)) (%get-byte hiliteMode))))
  (#_InvertRgn :ptr rgn))
|#

(defun %invert-region (rgn)
  (#_lmsethilitemode (logand (lognot (ash 1 #$hiliteBit)) (#_lmgethilitemode)))
  (#_InvertRgn rgn))

(defun highlight-region (view)
  (let ((rgn (slot-value view 'highlight-region)))
    (unless (handlep rgn)
      (setq rgn (setf (slot-value view 'highlight-region) (ccl::%new-rgn))))
    rgn))

(defvar *temp-rgn* nil)
(defvar *temp-rgn-2* nil)
(defvar ccl::*temp-rgn-3* nil)

(defun temp-regions ()
  (let ((temp-rgn *temp-rgn*)
        (temp-rgn-2 *temp-rgn-2*)
        (temp-rgn-3 ccl::*temp-rgn-3*))
    (unless (handlep temp-rgn)
      (setq temp-rgn (setq *temp-rgn* (ccl::%new-rgn))))
    (unless (handlep temp-rgn-2)
      (setq temp-rgn-2 (setq *temp-rgn-2* (ccl::%new-rgn))))
    (unless (handlep temp-rgn-3)
      (setq temp-rgn-3 (setq ccl::*temp-rgn-3* (ccl::%new-rgn))))
    (values temp-rgn temp-rgn-2 temp-rgn-3)))

(defun highlight-selection (view)
  (let ((selection (selection view)))
    (when selection
      (let* ((rgn (highlight-region view))
             (line-positions (line-positions view))
             (start-line (start-line view))
             (index (1+ (- selection start-line))))
        (when (< 0 index (length line-positions))
          (let* ((size (view-size view))
                 (width (point-h size))
                 (v1 (aref line-positions (1- index)))
                 (v2 (aref line-positions index))
                 (window (view-window view))
                 (clip-region (view-clip-region view)))
            (with-focused-view view
              (without-interrupts
               (multiple-value-bind (temp-rgn temp-rgn-2 temp-rgn-3) (temp-regions)
                 ;(declare (ignore-if-unused temp-rgn-3))
                 (#_CopyRgn rgn temp-rgn)
                 (if (window-active-p window)
                   (#_SetRectRgn rgn 0 v1 width v2)
                   (progn
                     (#_SetRectRgn rgn  0 v1 width v2)
                     (#_SetRectRgn temp-rgn-2  1 (1+ v1) (1- width) (1- v2))
                     (#_DiffRgn rgn temp-rgn-2 rgn)))
                 (let ((update-rgn temp-rgn-3))
                   (ccl::get-window-updatergn (wptr view) update-rgn)                                
                   (#_SectRgn rgn clip-region rgn)
                   (#_CopyRgn  rgn temp-rgn-2)
                   (let ((offset (add-points (view-origin view) (view-position window)))) 
                     (#_OffSetRgn temp-rgn-2  (point-h offset)(point-v offset)))
                   (#_SectRgn temp-rgn-2 update-rgn temp-rgn-2)
                   (if (#_EmptyRgn temp-rgn-2)
                     (progn
                       (#_XorRgn rgn temp-rgn temp-rgn)
                       (%invert-region temp-rgn))
                     (progn             ; newly selected window                       
                       (ccl::inval-window-rgn (wptr view) rgn)                       
                       (ccl::inval-window-rgn (wptr view) temp-rgn)
                       (#_CopyRgn temp-rgn rgn))) )
                 (#_SetEmptyRgn temp-rgn)
                 (#_SetEmptyRgn temp-rgn-2)))))
          (return-from highlight-selection nil)))))
  (unhighlight-selection view))

(defun unhighlight-selection (inspector-view)
  (let ((rgn (highlight-region inspector-view)))
    (when (and (handlep rgn) (not (#_EmptyRgn  rgn)))
      (with-focused-view inspector-view
        (%invert-region rgn)
        (#_SetEmptyRgn  rgn)))))

; During scrolling, the highlight can be overwritten.
; This routine cleans up after that happens.
; from & to are the vertical coordinates that were overwritten.
; Must be focused on view.
(defun highlight-overwritten (inspector-view from to)
  (let ((rgn (highlight-region inspector-view)))
    (when (handlep rgn)
      (rlet ((rect :rect))
        (#_getregionbounds rgn rect)
        (let* ((top (pref rect :rect.topleft))
               (bottom (pref rect :rect.botright)))
          ;        (format t "from: ~d, to: ~d, top: ~d, bottom: ~d~%"
          ;                from to top bottom)
          (when (or (<= from top to) (<= from bottom to)
                    (<= top from bottom) (<= top to bottom))
            (clear-margin inspector-view from to)
            (without-interrupts
             (let ((temp-rgn (temp-regions)))
               (#_SetRectRgn temp-rgn
                0  from 
                (point-h (view-size inspector-view)) to)
               (#_DiffRgn  rgn temp-rgn rgn)))))))))

(defun scroll-highlight-region (inspector-view from to)
  (let ((rgn (highlight-region inspector-view)))
    (when (handlep rgn)
      (#_OffsetRgn  rgn 0 (- to from))
      (#_SectRgn  rgn (view-clip-region inspector-view)  rgn))))

(defmethod view-activate-event-handler ((view inspector-view))
  (highlight-selection view))

(defmethod view-deactivate-event-handler ((view inspector-view))
  (highlight-selection view))

; Simple views are normally clicked focused on their parents.
; We don't want that.
(defmethod view-convert-coordinates-and-click ((view inspector-view) where container)
  (view-click-event-handler view (convert-coordinates where container view)))

(defmethod view-click-event-handler ((view inspector-view) where)
  (let ((single-click-inspect (and (not (shift-key-p)) (any-modifier-keys-p))))
    (if (and (not single-click-inspect) (double-click-p))
      (inspect-selection view)
      (progn
        (select-inspector-view (view-container view) view)
        (let ((v (point-v where))
              (line-positions (line-positions view))
              temp
              new-selection)
          (when line-positions
            (setq temp (aref line-positions 0))
            (dotimes (i (1- (length line-positions)))
	      (declare (fixnum i))
              (when (and (<= temp v)
                         (< v (setq temp (aref line-positions (1+ i)))))
                (let ((selection (+ (start-line view) i)))
                  (unless (eq (cached-type-n view selection) :comment)
                    (setq new-selection selection)
                    (return)))))
            (set-selection view new-selection)
            (update (view-container view))
            ; this doesnt get backtrace command-pane
            ;(update (command-pane (view-window view)))
            ; this does
            (update (view-named 'command-pane (view-window view)))
            (if single-click-inspect (inspect-selection view))))))))

; This should make the selection visible, too.
(defun set-selection (view new-selection)
  (setf (selection view) new-selection)
  (highlight-selection view))

(defun cached-type-n (view n)
  (multiple-value-bind (value label type) (cached-line-n view n)
    (declare (ignore value label))
    (parse-type (inspector view) type)))

(defun cached-line-n (view n)
  (let* ((cache (cache view))
         (cache-entry (and cache (< n (length cache)) (aref cache n))))
    (if cache-entry
      (values (cache-entry-value cache-entry)
              (cache-entry-label cache-entry)
              (cache-entry-type cache-entry))
      (multiple-value-bind (value label type) (line-n (inspector view) n)
        (values value label type)))))   ; line-n may return 4 values.  We must return 3

(defvar *view-to-resample* nil)
(defvar *did-resample* nil)

(defun set-cached-line-n (view n new-value)
  (let* ((cache (cache view))
         (cache-entry (and cache (< n (length cache)) (aref cache n)))
         (inspector (inspector view)))
    (if cache-entry
      (setf (aref cache n) nil))
    (let ((*view-to-resample* view)
          (*did-resample* nil))
      (setf (line-n inspector n) new-value)
      (unless *did-resample*
        (invalidate-view view))))
  new-value)

; This is called by (setf line-n) methods to say that there were global changes
(defun resample-it ()
  (let ((view *view-to-resample*)
        window)
    (when view
      (setq window (view-window view))
      (resample view)
      (let ((command-pane (command-pane window)))
        (when command-pane
          (update command-pane)
          (install-commands command-pane))))
    (compute-window-title window)
    (setq *did-resample* t)))


;;;;;;;
;;
;; Some state modifiers for inspector-view's
;;

(defmethod (setf cache-p) (value (view inspector-view))
  (unless (eq (not value) (not (cache-p view)))
    (setf (slot-value view 'cache-p) value)
    (resample view))
  value)

(defun make-cache (inspector-view)
  (let ((inspector (inspector inspector-view)))
    (setf (cache inspector-view) 
          (and inspector (cache-p inspector-view)
               (make-array (the fixnum (inspector-line-count inspector)) :initial-element nil)))))

(defun invalidate-line-positions (view)
  (setf (fill-pointer (line-positions view)) 0)
  (invalidate-view view t))

(defmethod resample ((view inspector-view))
  (let ((lines  (update-line-count (inspector view))))
    (if (> (start-line view) lines)
      (setf (slot-value view 'start-line) 0))
    (if (>= (or (selection view) 0) lines)
      (setf (selection view) nil)))
  (let* ((pane (view-container view))
         (window (and pane (view-window pane)))
         (command-pane (and window (command-pane window))))
    (when (and command-pane (eq pane (selected-pane window)))
      (update command-pane window)
      (install-commands command-pane (inspector view))
      (compute-window-title window)))
  (make-cache view)
  (invalidate-line-positions view))

(defmethod (setf inspector) (new-inspector (view inspector-view))
  (unless (eql new-inspector (inspector view))
    (setf (inspector-slot view) new-inspector)
    (setf (inspector-view new-inspector) view)
    (set-start-line view 0)
    (resample view))
  new-inspector)

(defmethod inspector-object ((view inspector-view))
  (and (inspector view) (inspector-object (inspector view))))

(defmethod (setf inspector-object) (new-object (view inspector-view))
  (unless (and (inspector view) (eq new-object (inspector-object view)))
    (setf (inspector view) (make-inspector new-object)))
  new-object)

(defmethod (setf pretty-p) (new-pretty-p (view inspector-view))
  (unless (eql new-pretty-p (pretty-p view))
    (setf (slot-value view 'pretty-p) new-pretty-p)
    (invalidate-line-positions view))
  new-pretty-p)

;;;;;;;
;;
;; Hairy code to handle scrolling
;; Don't ask me how it works.  I wrote it, but I don't claim to understand it.
;;
(defmethod (setf start-line) (new-start-line (view inspector-view))
  (set-start-line view new-start-line))

(defun scroll-to-line (view line-number &optional 
                           refresh? (context-lines 2))
  (setq view (require-type view 'inspector-view))
  (let* ((visible-lines (visible-lines view))
         (context-lines (if (fixnump context-lines) 
                          context-lines 
                          (max 0 (1- (floor (* context-lines visible-lines))))))
        (target (max 0 (- line-number context-lines))))
    (unless (or (eql 0 line-number) (pretty-p view))
      (let ((lines (inspector-line-count (inspector view)))
            (visible-lines (visible-lines view)))
        (if (< (- lines target) visible-lines)
          (setq target (max 0 (- lines visible-lines))))))
    (set-start-line view target refresh?)
    (set-scroll-bar-limits (view-container view))
    target))

(defun set-start-line (view new-start-line &optional refresh?)
  (setq view (require-type view 'inspector-view))
  (setq new-start-line (require-type new-start-line 'fixnum))
  (let ((inspector (inspector view))
        (old-start-line (start-line view)))
    (setf (slot-value view 'start-line) new-start-line)
    (when inspector
      (if (and (neq 0 new-start-line)
               (>= new-start-line (inspector-line-count inspector)))
        (setq new-start-line 0))
      (unless (eql old-start-line new-start-line)
        (when (and (wptr view) (< 0 (length (line-positions view))))
          (if refresh?
            (set-start-line-internal view new-start-line old-start-line)
            (invalidate-view view)))))
    (highlight-selection view))
  new-start-line)

(defvar *temp-line-positions* nil)

(defun set-start-line-internal (view new-start-line old-start-line)
  (with-focused-view view
    (let ((line-dif (- new-start-line old-start-line))
          (line-positions (line-positions view)))
      (if (< line-dif 0)                  ; (< new-start-line old-start-line)
        (scroll-down view new-start-line old-start-line line-dif line-positions)
        (scroll-up view new-start-line old-start-line line-dif line-positions)))))

(defun scroll-down (view new-start-line old-start-line line-dif line-positions)
  (declare (ignore line-dif))
  (let* ((room (add-line-heights view new-start-line old-start-line))
         (temp-pos (prog1
                     (or *temp-line-positions*
                         (make-array (length line-positions) 
                                     :adjustable t :fill-pointer 0))
                     (setq *temp-line-positions* nil))))
    (scroll-view view 0 room)
    (setf (line-positions view) temp-pos)
    (setf (fill-pointer temp-pos) 1)
    (setf (aref temp-pos 0) 0)          ; first line always at 0
    (draw-inspector-view-internal view new-start-line old-start-line)
    (let* ((lines-drawn (1- (length temp-pos)))
           (pen-pos (aref temp-pos lines-drawn))
           (height (point-v (view-size view))))
      (when (< pen-pos height)          ; nothing more to do if went off end of screen
        (unless (eql lines-drawn (- old-start-line new-start-line))
          (error "Inconsistency."))
        (if (eql room pen-pos)          ; Guessed right.
          (let ((l (length line-positions)))
            (do ((index 1 (1+ index)))
                ((>= index l))
              (let ((pos (+ (aref line-positions index) room)))
                (vector-push-extend pos temp-pos)
                (if (> pos height) (return)))))
          ; Must have pretty printed a multi-line line: all our work was for naught.
          (multiple-value-bind (a d l) (view-line-font-info view old-start-line)
            (declare (ignore d l))
            (highlight-overwritten view 0 pen-pos)
            (unhighlight-selection view)
            (draw-inspector-view-internal view old-start-line nil (+ pen-pos a))))))
    (setf (fill-pointer line-positions) 0)
    (setq *temp-line-positions* line-positions)))

(defun scroll-up (view new-start-line old-start-line line-dif line-positions)
  (declare (ignore old-start-line))
  (let ((height (point-v (view-size view)))
        (vis-lines (length line-positions))
        bottom
        first-line-to-print)
    (do ((i (1- vis-lines) (1- i)))
        ((< i 0) (error "line-positions inconsistent."))
      (when (< (aref line-positions i) height)
        (setq bottom i)
        (return)))
    (if (> line-dif bottom)
      (invalidate-line-positions view)
      (let ((offset (aref line-positions line-dif)))
        (do ((to 0 (1+ to))
             (from line-dif (1+ from))
             (pos 0))
            ((> from bottom)
             (setf (fill-pointer line-positions) to
                   first-line-to-print (+ new-start-line to -1)
                   bottom pos))         ; where we start printing new stuff
          (setf (aref line-positions to)
                (setq pos (- (aref line-positions from) offset))))
        (scroll-view view offset 0)
        (unless (>= first-line-to-print (inspector-line-count (inspector view)))
          (multiple-value-bind (a d l) (view-line-font-info view first-line-to-print)
            (declare (ignore d l))
            (draw-inspector-view-internal view first-line-to-print nil (+ bottom a))
            (highlight-overwritten view bottom (point-v (view-size view)))))))))

(defun view-line-font-info (view line)
  (let* ((cache (cache view))
         (cache-entry (and cache (aref cache line)))
         (font-decls (and cache-entry (cache-entry-font-declarations cache-entry))))
    (if font-decls
      (apply #'values font-decls)
      (multiple-value-bind (ff ms) (stream-font-codes view)
        (let ((inspector (inspector view)))
          (multiple-value-bind (value label type) (line-n inspector line)
            (declare (ignore value label))
            (multiple-value-bind (type label-font value-font) (parse-type inspector type)
              (declare (ignore type))
              (let (a1 d1 w l1)
                (declare (ignore-if-unused w))
                (multiple-value-bind (ff ms) (font-codes label-font ff ms)
                  (multiple-value-setq (a1 d1 w l1) (font-codes-info ff ms)))
                (multiple-value-bind (ff ms) (font-codes value-font ff ms)
                  (multiple-value-bind (a d w l) (font-codes-info ff ms)
                    (declare (ignore w))
                    (values (max a1 a) (max d1 d) (max l1 l))))))))))))

; Add the line heights of all lines from new-start-line upto but not including
; old-start-line.  Eventually, want to use the cached info here.
(defun add-line-heights (view new-start-line old-start-line)
  (let ((sum 0)
        (max (point-v (view-size view))))
    (do ((i new-start-line (1+ i)))
        ((>= i old-start-line))
      (multiple-value-bind (a d l) (view-line-font-info view i)
        (incf sum (+ a d l))
        (if (>= sum max) (return))))
    sum))

; Scroll (vertically) the section of view between FROM and the end to TO.
#| ; old version. Doesn't work if a windoid is in front of the inspector window
(defun scroll-view (view from to)
  (setq view (require-type view 'inspector-view))
  (let* ((size (view-size view))
         (h (point-h size))
         (v (point-v size))
         (mode (position :srccopy *pen-modes*))
         (bitmap (rref (wptr view) :windowrecord.portbits))
         erase-start
         erase-end)
    (declare (dynamic-extent bitmap))
    (with-focused-view view
      (if (< from to)
        (setq size (- v (- to from))
              erase-start from
              erase-end to)
        (setq size (- v from)
              erase-start (+ to (- v from))
              erase-end v))
      (rlet ((from-rect :rect :top from :left 0 :bottom (+ from size) :right h)
             (to-rect :rect :top to :left 0 :bottom (+ to size) :right h))
        (#_CopyBits :ptr bitmap :ptr bitmap :ptr from-rect :ptr to-rect :word mode
                    :ptr (%null-ptr)))
      (rlet ((erase-rect :rect :top erase-start :left 0 :bottom erase-end :right h))
        (#_EraseRect :ptr erase-rect))))
  (scroll-highlight-region view from to))
|#

(defun scroll-view (view from to)
  (setq view (require-type view 'inspector-view))
  (let* ((dv (- to from))
         (size (view-size view))
         (h (point-h size))
         (v (point-v size))
         erase-start
         erase-end)
    (with-focused-view view
      (if (< from to)
        (setq size (- v (- to from))
              erase-start from
              erase-end to)
        (setq size (- v from)
              erase-start (+ to (- v from))
              erase-end v))
      (without-interrupts
       (rlet ((rect :rect :top (min from to) :left 0 :bottom v :right h))
         (let ((rgn (temp-regions)))
           (#_ScrollRect rect 0 dv rgn)
           (invalidate-region view rgn))))
      (rlet ((erase-rect :rect :top erase-start :left 0 :bottom erase-end :right h))
        (#_EraseRect erase-rect)
        #-carbon-compat
        (#_ValidRect erase-rect)
        #+carbon-compat
        (ccl::valid-window-rect (wptr view) erase-rect)
        )))
  (scroll-highlight-region view from to))

;;;;;;;
;;
;; bottom-line-mixin
;; A little mixin to draw a line across the bottom of a view
;;
(defclass bottom-line-mixin ()
  ())

(defmethod view-draw-contents :after ((view bottom-line-mixin))
  (unless (view-named 'double-bottom-line view)
    (with-focused-view view               ; might be a simple-view
      (let* ((size (view-size view))
             (h (point-h size))
             (v (1- (point-v size))))
        (#_moveto 0 v)
        (#_lineto  h  v)))))

(defmethod set-view-size ((view bottom-line-mixin) h &optional v)
  (declare (ignore h v))
  (let ((old-size (view-size view)))
    (call-next-method)
    (let* ((size (view-size view))
           (h (point-h size))
           (v (point-v size))
           (old-h (point-h old-size)))
      (if (eql v (point-v old-size))
        (if (< old-h h)
          (invalidate-corners view
                              (make-point old-h (1- v))
                              (make-point h v))
          (invalidate-corners view
                              (make-point h (1- v))
                              (make-point old-h v)
                              t))
        (let ((old-v (point-v old-size)))
          (invalidate-corners view
                              (make-point 0 (1- old-v))
                              (make-point old-h old-v)
                              t))))))

(defclass double-bottom-line (simple-view)
  ())


(defmethod view-draw-contents  ((view double-bottom-line))
  (with-focused-view view
    (let* ((size (view-size view))
           (h (point-h size))
           (v (- (point-v size) 1)))
      (#_moveto  0  0)
      (#_lineto  h 0)
      (#_moveto 0 v)
      (#_lineto h v))))

;;;;;;;
;;
;; inspector-pane
;; An inspector-view plus a scroll bar.
(defclass inspector-pane (bottom-line-mixin view)
  ((grow-box-p :initform nil :initarg :grow-box-p :reader grow-box-p)
   (command-pane :initform nil :initarg :command-pane :accessor command-pane))
  (:default-initargs :view-size #@(500  200)
                     :view-position #@(0 0)))

(defclass inspector-scroll-bar (scroll-bar-dialog-item)
  ((set-limits-pending-p :initform nil :accessor set-limits-pending-p)))

(defmethod initialize-instance ((pane inspector-pane) &rest initargs
                                &key pane-splitter-class pane-splitter pane-splitter-cursor
                                pane-splitter-length &allow-other-keys)
  (declare (dynamic-extent initargs))
  (call-next-method)
  (let* ((size (view-size pane))
         (width (- (point-h size) 15))
         (height (point-v size)))
    (make-instance 'inspector-scroll-bar
                   :view-position (make-point width -1)
                   :direction :vertical
                   :length (+ 1 height (if (grow-box-p pane) -15 0))
                   :scrollee pane
                   :pane-splitter-class pane-splitter-class
                   :pane-splitter-length pane-splitter-length
                   :pane-splitter-cursor pane-splitter-cursor
                   :pane-splitter pane-splitter
                   :view-nick-name 'scroll-bar
                   :view-container pane)
    (apply #'make-inspector-view pane initargs)
    (set-scroll-bar-limits pane)))
                   
(defmethod inspector-view ((pane inspector-pane))
  (view-named 'inspector-view pane))

(defun make-inspector-view (pane &rest initargs
                                 &key (inspector-view-class 'inspector-view)
                                 &allow-other-keys)
  (declare (dynamic-extent initargs))
  (setq pane (require-type pane 'inspector-pane))
  (let ((old-view (inspector-view pane)))
    (when old-view
      (set-view-container old-view nil)))
  (let* ((size (view-size pane))
         (width (- (point-h size) 15))
         (height (point-v size)))
    (apply #'make-instance
           inspector-view-class
           :view-size (make-point width (- height 3)) ; was -1
           :view-position #@(0 2)  ; was 0 0
           :view-container pane
           :view-nick-name 'inspector-view
           :allow-other-keys t
           initargs)))

(defmethod inspector ((pane inspector-pane))
  (let ((view (inspector-view pane)))
    (and view (inspector view))))

(defun scroll-bar (pane)
  (view-named 'scroll-bar pane))

(defmacro def-pass-thru (function-name class accessor)
  (let ((new-value (gensym)))
    `(progn
       (defmethod ,function-name ((,class ,class))
         (,function-name (,accessor ,class)))
       (defmethod (setf ,function-name) (,new-value (,class ,class))
         (setf (,function-name (,accessor ,class)) ,new-value)))))

(def-pass-thru inspector-object inspector-pane inspector-view)
(def-pass-thru cache-p inspector-pane inspector-view)
(def-pass-thru pretty-p inspector-pane inspector-view)
(def-pass-thru selection inspector-pane inspector-view)

(defmethod visible-lines ((pane inspector-pane))
  (visible-lines (inspector-view pane)))

(defmethod visible-lines ((view inspector-view))
  (multiple-value-bind (ff ms) (stream-font-codes view)
    (multiple-value-bind (a d w l) (font-codes-info ff ms)
      (declare (ignore w))
      (values (floor (point-v (view-size view)) (+ a d l))))))

(defmethod set-scroll-bar-limits (pane)
  (let ((inspector (inspector pane)))
    (when inspector
      (let* ((lines (inspector-line-count (inspector pane)))
             (visible-lines (visible-lines pane))
             (pretty-p (pretty-p pane))
             (max (if pretty-p
                    (1- lines)
                    (max 1 (- lines visible-lines))))
             (scroll-bar (scroll-bar pane))
             (start-line (start-line (inspector-view pane))))
        (setf (scroll-bar-max scroll-bar) max)
        (set-dialog-item-enabled-p
         scroll-bar
         (or (not (eql 0 start-line)) pretty-p (> lines visible-lines)))
        (setf (scroll-bar-setting scroll-bar) start-line)))))

(defmethod view-draw-contents ((pane inspector-pane))
  (set-scroll-bar-limits pane)
  (call-next-method)
  (set-scroll-bar-page-size pane))

(defun set-scroll-bar-page-size (pane)
  (when (inspector pane)
    (setf (scroll-bar-page-size (scroll-bar pane))
          (if (pretty-p pane)
            (max 1 (- (length (line-positions (inspector-view pane))) 2))
            (visible-lines pane)))))

(defmethod set-view-size ((pane inspector-pane) h &optional v)
  (without-interrupts
   (call-next-method)
   (let* ((bottom (view-named 'double-bottom-line pane))
          (pt (make-point h v))
          (h (- (point-h pt) 15))
          (v (point-v pt)))     
     (let ((iview (inspector-view pane))
           (v-bottom (when bottom (point-v (view-size bottom)))))
       (when bottom
         (set-view-size bottom h v-bottom)
         (set-view-position bottom 0 (- v v-bottom)))         
       (set-view-size iview h (- v (point-v (view-position iview)) (or v-bottom 1))))
     (let ((scroll-bar (scroll-bar pane)))
       (set-view-position scroll-bar h -1)
       (setf (scroll-bar-length scroll-bar)
             (+ 1 v (if (grow-box-p pane) -15 0)))
       (set-scroll-bar-limits pane)))))

(defmethod (setf grow-box-p) (grow-box-p (pane inspector-pane))
  (setf (slot-value pane 'grow-box-p) grow-box-p)
  (set-view-size pane (view-size pane)))

(defmethod set-view-size :after ((view inspector-view) h &optional v)
  (declare (ignore h v))
  (if t ;(pretty-p view)
    (invalidate-view view)))

(defmethod scroll-bar-changed ((pane inspector-pane) scroll-bar)
  (let ((start-line (scroll-bar-setting scroll-bar)))
    (set-start-line (inspector-view pane) start-line t)
    (setf (set-limits-pending-p scroll-bar) (eql 0 start-line)))
  ;; When mouse is still down, we're going to scroll again.
  ;; Fix up the damaged part of the window to handle the case
  ;; when we're not frontmost, i.e. partially covered by a windoid.
  (when #-ignore (#_StillDown) #+ignore (mouse-down-p) (window-update-event-handler (view-window pane))))

; This handles the obscure case of the user making the window big
; enough to not need a scroll bar when it is scrolled past the first
; line, then scrolling back to the first line: it disables the scroll bar.
; Can't do this inside of SCROLL-BAR-CHANGED, as that is called from the
; ROM, and disabling a control that is currently tracking does not work.
(defmethod view-click-event-handler :after ((item inspector-scroll-bar) where)
  (declare (ignore where))
  (when (set-limits-pending-p item)
    (setf (set-limits-pending-p item) nil)
    (set-scroll-bar-limits (view-container item))))

; This is necessary to make sure the scroll bar image is updated
; along with the view
(defmethod invalidate-view :after ((view inspector-view) &optional erase-p)
  (declare (ignore erase-p))
  (unhighlight-selection view)
  (let ((pane (view-container view)))
    (if (typep pane 'inspector-pane)
      (mapc #'invalidate-view (ccl::view-scroll-bars pane)))))

;;;;;;;
;;
;; command-pane
;; This is where the pull-down menus and buttons for the inspector-window are kept
;;

(defclass command-pane-mixin ()
  ()
  (:default-initargs
    :help-spec 14089))

(defclass command-pane (command-pane-mixin bottom-line-mixin ccl::theme-background-view)
  ())

(defparameter *command-pane-min-height* 18)

(defmethod initialize-instance ((pane command-pane) &rest initargs
                                &key view-container edit-value-button)
  (declare (dynamic-extent initargs))
  (apply #'call-next-method pane :view-container nil initargs)
  (add-command-pane-items pane edit-value-button)
  (when view-container
    (let* ((size (view-size view-container))
           (width (point-h size))
           (menu (view-named 'command-menu pane)))
      (when (and menu (not (view-size menu)))(set-view-size menu (view-default-size menu)))
      (when (not menu)(setq menu (elt (view-subviews pane) 0)))
      (set-view-size pane width (if #|menu|# nil (point-v (view-size menu)) *command-pane-min-height*))
      (set-view-position pane 0 0))
    (set-view-container pane view-container)))

(defun make-window-menu-item (title action)
  (make-instance 'window-menu-item 
                 :menu-item-title title
                 :menu-item-action action))

(defun make-and-size-dialog-item (class &rest initargs)
  (declare (dynamic-extent initargs))
  (let ((item (apply #'make-instance class initargs)))
    (unless (view-size item)
      (setf (slot-value item 'view-size)
            (view-default-size item)))
    item))

(defun make-seperator-menu-item ()
  (make-instance 'menu-item :menu-item-title "-"))

; This makes resample-it called from inside on of the commands work
(defmethod view-click-event-handler ((view command-pane) where)
  (declare (ignore where))
  (let ((*view-to-resample* (inspector-view (view-window view)))
        (*did-resample* nil))
    (declare (special *view-to-resample* *did-resample*))
    (call-next-method)))

(defmethod add-command-pane-items ((command-pane command-pane) &optional (edit-value-button t))
  (let* ((font '("Geneva" 10 :bold))
         ;(width (+ 8 19 (string-width "Commands" font)))        ; 19 is for the little triangle
         ;(height (+ 5 (font-line-height font))) 
         ;(menu-size (make-point width height))
         (resample-button (make-and-size-dialog-item
                           'ccl::3d-button ;'subtle-button
                           :view-nick-name 'resample-button
                           :frame-p t
                           ;:border-p nil
                           :default-button t
                           :dialog-item-text "Resample"
                           :view-font font
                           :dialog-item-action
                           #'(lambda (item)
                               (resample (view-window item)))))
         ;(button-size (view-size resample-button))
         )
    ;(set-view-size resample-button button-size)    
    (add-subviews command-pane
                  (make-instance 'pull-down-menu
                                 :item-display "Commands"
                                 :view-nick-name 'command-menu
                                 :crescent t
                                 :view-font font
                                 :view-size nil
                                 :menu-items nil
                                 :enabledp nil
                                 :auto-update-default nil
                                 :update-function #'(lambda (menu) 
                                                      (install-commands 
                                                       (view-container menu))))
                  resample-button)
    (when edit-value-button
      (add-subviews command-pane                  
                 (make-instance
                   'ccl::3d-button ;button-dialog-item
                   ;:view-size button-size
                   :view-nick-name 'Edit-button
                   :dialog-item-text "Edit Value"
                   :view-font font
                   ;:border-p nil
                   :frame-p t
                   :dialog-item-action
                   #'(lambda (item)
                       (edit-selection (view-window item))))
                   #|
                  (make-instance
                   'button-dialog-item ;'subtle-button
                    :default-button t
                   :view-size button-size
                   :view-nick-name 'inspect-button
                   :dialog-item-text "Inspect"
                   :view-font font
                   ;:border-p nil
                   :dialog-item-action
                   #'(lambda (item)
                       (inspect-selection (view-window item))))|#
                  ))))

(defmethod set-view-size ((pane command-pane-mixin) h &optional v)
  (let* ((size (make-point h v))
         (h (point-h size))         
         (menu (view-named 'command-menu pane))
         ;(button (elt (view-subviews pane) 0))
         ;(mv (if menu (point-v (view-size menu)) 0))
         ;(v (max mv (point-v size) (+ 6 (point-v (view-size button)))))
         )    
    (call-next-method pane h *command-pane-min-height*)
    (adjust-subview-positions pane)
    ; or maybe 0 0
    ; the menu is 2 pixels smaller than the button - phooey
    ; makes the crescent look funny (2 pix white above)
    (when menu 
      (set-view-size menu (point-h (view-size menu))(1+ (point-v (view-size pane))))
      (set-view-position menu 0 0)) ; (+ 1 (- v mv))))
    size))

(defmethod adjust-subview-positions ((pane command-pane-mixin))
  (let* ((items (subviews pane 'ccl::3d-button))
         (size (view-size pane))
         (width (point-h size))
         (height (1- (point-v (view-size pane))))
         (space (if (and items (view-get (car items) 'ccl::no-border)) 2 0))  ; was 10
         (pos (- width space)))    
    (dolist (item items) ;(reverse items))
      (when (not (view-size item))(set-view-size item (view-default-size item)))
      (let* ((size (view-size item))
             (h (point-h size))
             (v (point-v size)))
        (set-view-position item (- pos h) (ceiling (- height v) 2))
        (decf pos (+ h space))))
    (let ((max-pos pos))
      (setq pos space)
      (do-subviews (item pane)
        (unless (typep item 'ccl::3d-button)
          (let* ((size (view-size item))
                 (h (point-h size))
                 (v (point-v size)))
            (set-view-position
             item (min pos (- max-pos h)) (floor (- height v) 2))
            (incf pos (+ h space))))))))

; Returns a list each element of which is a string or a list of
; a string and a function of no args.
(defmethod inspector-commands ((i inspector))
  nil)

(defun install-commands (pane &optional
                              (inspector (inspector (view-window pane))))
  (setq pane (require-type pane 'command-pane))  
  (let* ((w (view-window pane))
         (menu (view-named 'command-menu pane))
         (commands (inspector-commands inspector))
         (items (menu-items menu)))
    (if items
      (apply #'remove-menu-items menu (cdddr items))
      (progn (add-new-item menu "Help" 'inspector-help :help-spec 14041)
             (add-new-item menu "Inspect" #'(lambda () (inspect-selection w))
                           :update-function
                           #'(lambda (item)                               
                               (let* ((view (inspector-view w))
                                      (selection (selection view))
                                      (selection-p (not (null selection))))
                                 (set-menu-item-enabled-p item selection-p))))
             
             (add-new-item menu "Edit ValueÉ" #'(lambda () (edit-selection w))
                           :update-function
                           #'(lambda (item)
                               (set-menu-item-enabled-p item (edit-value-ok w))))
             (add-new-item menu "-")))
    (dolist (command commands)
      (let (title function)
        (if (atom command)
          (setq title command)
          (setq title (car command)
                function (cadr command)))
        (add-new-item menu title function :disabled (null function))))
    (setq items (menu-items menu))
    (menu-item-update (cadr items))
    (menu-item-update (caddr items))
    (menu-enable menu)))
   #| (unless 
      (dolist (item items nil)
        (when (menu-item-enabled-p item)(menu-enable menu)(return t)))
      (menu-disable menu))))|#
                    
;;;;;;;
;;
;; The inspector-window
;;
(defclass undo-view-mixin ()
  ((the-undo-view :initform nil :accessor the-undo-view)
   (the-undo-selection :initform nil :accessor the-undo-selection)
   (the-undo-value :initform nil :accessor the-undo-value)
   (the-undo-function :initform nil :accessor the-undo-function)
   (the-undo-string :initform nil :accessor the-undo-string)))

(defclass inspector-window (undo-view-mixin window)
  ((selected-pane :initform nil :accessor selected-pane)
   (user-title :accessor user-title))
  (:default-initargs :window-title nil))

(def-pass-thru inspector-view inspector-window selected-pane)
(def-pass-thru selection inspector-window inspector-view)
(def-pass-thru inspector-object inspector-window selected-pane)
(def-pass-thru inspector inspector-window selected-pane)
(def-pass-thru resample inspector-pane inspector-view)

(defmethod view-key-event-handler ((view inspector-window) key)
  (unless (and (eq key #\return)
               (let ((d-button (default-button view)))
                 (when(and d-button (dialog-item-enabled-p d-button))
                   (press-button d-button)
                   t)))
    (ed-beep)))

(defmethod selected-object ((w inspector-window))
  (selected-object (selected-pane w)))

(defmethod selected-object ((pane inspector-pane))
  (selected-object (inspector-view pane)))

(defmethod selected-object ((view inspector-view))
  (let* ((selection (selection view)))
    (values (and selection (cached-line-n view selection))
            selection)))

(defmethod initialize-instance ((w inspector-window) &rest initargs &key
                                (edit-value-button t)
                                (window-show t) inspector-object inspector
                                window-title)
  (declare (dynamic-extent initargs))
  (apply #'call-next-method w 
         :window-show nil
         :window-title (or window-title "")
         initargs)
  (setf (user-title w) window-title)
  (let* ((command-pane (make-instance 'command-pane
                         	      :edit-value-button edit-value-button                                      
                                      :view-container w
                                      :view-nick-name 'command-pane))
         (size (view-size w))
         (width (point-h size))
         (height (point-v size))
         (pane-top (point-v (view-size command-pane))))
    (adjust-subview-positions command-pane)
    (setf (selected-pane w)
          (make-instance 'inspector-pane
                         :inspector inspector
                         :inspector-object inspector-object
                         :inspector-view-class (inspector-view-class inspector)
                         :command-pane command-pane
                         :grow-box-p t
                         :view-container w
                         :view-position (make-point 0 pane-top)
                         :view-size (make-point width 
                                                (- height pane-top -1))))
    (install-commands command-pane)
    (set-initial-stuff w)
    (update command-pane w))
  (set-initial-scroll (inspector w))
  (when window-show
    (window-show w))
  w)

; Keep the dialog designer off my inspector windows
(defmethod ccl::editing-dialogs-p ((view inspector-window))
  nil)

(defmethod set-initial-scroll ((i inspector))
  nil)

(defmethod command-pane ((w inspector-window))
  (view-named 'command-pane w))

(defvar *window-default-top-right* nil)

(ccl::def-ccl-pointers window-default-top-right ()
   (setq *window-default-top-right*
         (make-point (- *screen-width* 46) (point-v *window-default-position*))))
(defparameter *window-tiling-offset-h* 16)
(defparameter *window-tiling-offset-v* 17)
(defparameter *max-default-window-height* 300)

(defmethod view-default-position ((w inspector-window))
  (let ((top-inspector (front-window :class 'inspector-window)))
    (if top-inspector 
      (add-points (view-position top-inspector)
                  (make-point (- *window-tiling-offset-h*)
                              *window-tiling-offset-v*))
      #@(20000 20000))))

(defun set-initial-stuff (w)
  (setq w (require-type w 'inspector-window))
  (let* ((view (inspector-view w))
         (line-count (inspector-line-count (inspector view)))
         (line-height (font-line-height (view-font w)))
         ; The answer really IS 42. nah its 67
         (items-height (max 60 (* line-count line-height)))
         (overhead-height (+ 2 (point-v (view-size (command-pane w)))))
         (height (+ items-height overhead-height))
         (width (point-h *window-default-size*))
         (top-inspector (front-window :class 'inspector-window))
         (user-position (view-position w))
         (position (if (eql #@(32767 32767) user-position)
                     (and top-inspector 
                          (add-points (view-position top-inspector)
                                      (make-point (- *window-tiling-offset-h*)
                                                  *window-tiling-offset-v*)))
                     user-position)))
    (when (> height *max-default-window-height*)
      (setq height (+ overhead-height
                      (* line-height (floor (- *max-default-window-height*
                                               overhead-height)
                                            line-height)))))
    (when (or (null position)
              (> (+ (point-v position) height) *screen-height*)
              (< (point-h position) 0))
      
      (setq position (subtract-points (make-point (- *screen-width* 46) (point-v *window-default-position*))
                                      (make-point width 0)))
      #+Remove
      (setq position (subtract-points *window-default-top-right*
                                      (make-point width 0))))
    (when (< (point-h position) 0)
      (setq position *window-default-position*))
    (set-view-position w position)
    (set-view-size w width height)
    (compute-window-title w)))

(defparameter *max-title-width* 45)

(defun make-truncated-string (ob-or-fun &optional (length *max-title-width*) &aux
                                        truncated string)
  (if (stringp ob-or-fun) 
    (setq string
          (if (<= (length ob-or-fun) length)
            (ccl::ensure-simple-string ob-or-fun)
            (progn (setq truncated t)
                   (subseq ob-or-fun 0 length))))
    (let ((stream (ccl::make-truncating-string-stream length)))
      (setq truncated t)
      (catch :truncate
        (if (functionp ob-or-fun)
          (funcall ob-or-fun stream)
          (prin1 ob-or-fun stream))
        (setq truncated nil))
      (setq string (get-output-stream-string stream))))
  (if truncated
    (setq string (ccl::truncate-string  string (1- length))))
  string)

; Get's called if an inspector-pane's window is not an inspector-window
(defmethod compute-window-title ((w window))
  nil)

#|
(defmethod compute-window-title ((w inspector-window))
  (unless (user-title w)
    (let ((title (inspector-window-title (inspector w))))      
      (set-window-title
       w
       (make-truncated-string title)))))
|#

(defmethod compute-window-title ((w inspector-window))
  (unless (user-title w)
    (let* ((title (inspector-window-title (inspector w))))
      (when (stringp title)
        (multiple-value-bind (s-title start)(ccl::array-data-and-offset title) 
          (let* ((len (length title))
                 (eol-pos (ccl::simple-string-eol-position s-title start (+ start len))))
            (when eol-pos
              (setq title (subseq s-title start (+ start len)))
              (setq eol-pos (- eol-pos start))
              (setf (schar title eol-pos) #\¦)
              (do ((i (1+ eol-pos) (1+ i)))
                  ((>= i len))
                (when (char-eolp (schar title i))
                  (setf (schar title i) #\¦)))))))
      (set-window-title
       w
       (make-truncated-string title)))))

(defmethod inspector-window-title ((i inspector))
  (let ((o (inspector-object i)))
    (if (functionp o)
      #'(lambda (stream) (prin1 o stream))
      o)))

(defmethod window-size-parts ((w inspector-window))
  (let* ((size (view-size w))
         (width (point-h size))
         (height (point-v size))
         (command-pane (or (command-pane w)
                           (return-from window-size-parts nil)))
         (v (point-v (view-size command-pane)))
         (bottom (1+ height))
         (room (- bottom v))
         (panes (sort (subviews w 'inspector-pane)
                      #'<
                      :key #'(lambda (p) (point-v (view-position p)))))
         (last-pane (car (last panes)))
         (old-room (apply #'+ (mapcar #'(lambda (p) (point-v (view-size p)))
                                      panes))))
    (set-view-size command-pane width v)
    (dolist (pane panes)
      (set-view-position pane 0 v)
      (let ((old-height (point-v (view-size pane))))
        (if (eq pane last-pane)
          (set-view-size pane width (- bottom v))
          (let ((new-height (floor (* old-height room) old-room)))
            (set-view-size pane width new-height)
            (incf v new-height)))))
    size))

; gets called if an inspector-view's pane is not an inspector-pane
(defmethod select-inspector-view ((pane view) view)
  (declare (ignore view))
  nil)

(defmethod select-inspector-view ((pane inspector-pane) view)
  (declare (ignore view))
  (select-pane (view-container pane) pane))

(defmethod select-pane (window pane)
  (declare (ignore window pane)))

(defmethod select-pane ((window inspector-window) pane)
  (let ((old-pane (selected-pane window)))
    (when (and old-pane (neq old-pane pane))
      (let ((view (inspector-view pane)))
        (setf (selection view) nil)
        (unhighlight-selection view)))
    (setf (selected-pane window) pane)))

; Make the font menus work.
(defmethod set-view-font :after ((w inspector-window) font-spec)
  (declare (ignore font-spec))
  (resample w))

; Records need to be cleaned up when the window closes
(defmethod window-close ((w inspector-window))
  (window-closing (inspector w))
  (call-next-method))

(defmethod window-closing (inspector)
  (declare (ignore inspector))
  nil)

;;;;;;;
;;
;; Commands from the command-pane
;;
(defmethod inspect-selection ((w inspector-window))
  (inspect-selection (inspector-view w)))

(defmethod inspect-selection ((v inspector-view))
  (let ((option-key (option-key-p)))
    (if (and option-key (or (command-key-p) (control-key-p)))
      (unless (edit-definition (selected-object v))
        (ed-beep))
      (let ((pane (view-container v)))
        (unless (and option-key (replace-object-p pane)
                     (inspect-selection-in-this-pane pane))
          (inspect-selection-in-new-window v))))))

(defmethod replace-object-p ((pane inspector-pane))
  (replace-object-p (inspector-view pane)))

(defmethod replace-object-p ((view inspector-view))
  (replace-object-p (inspector view)))

(defmethod replace-object-p ((inspector inspector)) t)

(defun inspect-selection-in-new-window (v)
  (setq v (require-type v 'inspector-view))
  (multiple-value-bind (object selection) (selected-object v)
    (declare (ignore object))
    (when selection
      (make-inspector-window (multiple-value-call #'line-n-inspector
                                                  (inspector v)
                                                  selection
                                                  (cached-line-n v selection))))))

(defvar *inspector-history* nil)

(defun init-inspector-history ()
  (do ((l *inspector-history* (cdr l)))
      ((null l))
    (setf (car l) nil)))

(pushnew 'init-inspector-history *save-exit-functions*)

(defun push-inspector-history (inspector)
  (labels ((doit (h i inspector)
             (cond ((null h))
                   ((and (eq (class-of (car h)) (class-of inspector))
                         (eq (inspector-object (car h)) (inspector-object inspector)))
                    (setf (car h) i))
                   (t (doit (cdr h) (car h) inspector) 
                      (setf (car h) i)))))
    (let ((h *inspector-history*))
      (doit h inspector inspector)
      h)))
  

(defmethod make-inspector-window ((inspector inspector) &rest initargs)
  (let ((pane (and (not (shift-key-p))
                   (find-inspector-pane (inspector-object inspector) inspector))))
    (if pane
      (let ((window (view-window pane)))
        (window-select window)
        (setf (selected-pane window) pane)
        (push-inspector-history (inspector pane))
        window)
      (prog1
        (apply #'make-instance (inspector-window-class inspector)
               :inspector inspector
               initargs)
        (push-inspector-history inspector)))))

; This returns non-NIL if something was changed requiring refresh.
; This is used to update the PC on an existing function-inspector
(defmethod copy-random-inspector-state (from to) 
  (declare (ignore from to))
  nil)

(defun find-inspector-pane (object &optional inspector)
  (flet ((look-for-pane (window)
           (do-subviews (pane window 'inspector-pane)
             (let ((pane-inspector (inspector pane)))
               (when (and pane-inspector
                          (inspectors-match-p pane-inspector inspector object))
                 (when (copy-random-inspector-state inspector pane-inspector)
                   (window-select (view-window pane))   ; I know, this is ugly
                   (resample pane))
                 (return-from find-inspector-pane pane))))))
    (declare (dynamic-extent #'look-for-pane))
    (map-windows #'look-for-pane
                 :class 'inspector-window :include-invisibles t)))

; This is not in-line above so it can be specialized.
(defmethod inspectors-match-p ((pane-inspector inspector) new-inspector object)
  (let ((inspector-class (if new-inspector (class-of new-inspector) (inspector-class object))))
    (and (eq inspector-class (class-of pane-inspector))
         (eq object (inspector-object pane-inspector)))))

(defmethod line-n-inspector (i n value label type)
  (declare (ignore i n label type))
  (make-inspector value))

(defmethod line-n-inspector ((i usual-inspector) n value label type)
  (let ((object (inspector-object i)))
    (if (typep object 'usual-inspector)
      (make-inspector value)
      (line-n-inspector (inspector-object i) n value label type))))

(defun inspect (object)
  (inspect-object object))

(defun inspect-object (object &optional window-title)
  (make-inspector-window (make-inspector object) :window-title window-title))

(defmethod inspect-selection-in-this-pane ((v view))
  nil)

(defmethod inspect-selection-in-this-pane ((p inspector-pane))
  (multiple-value-bind (object selection) (selected-object p)
    (declare (ignore object))
    (when selection
      (install-new-inspector p (multiple-value-call #'line-n-inspector
                                                    (inspector p)
                                                    selection
                                                    (cached-line-n (inspector-view p) selection)))))
  t)

(defun install-new-inspector (inspector-pane inspector)
  (make-inspector-view 
   inspector-pane
   :inspector inspector)
  (compute-window-title (view-window inspector-pane))
  (install-commands (command-pane inspector-pane))
  (push-inspector-history inspector)
  inspector)

; These three methods fix some startup transients.
; Also, a backtrace-window has no selected-pane or command-pane.
(defmethod update (frob &optional window) 
  (declare (ignore frob window))
  nil)

(defmethod selected-pane (frob)
  (declare (ignore frob))
  nil)

(defmethod command-pane (frob)
  (declare (ignore frob))
  nil)

(defmethod update ((pane inspector-pane) &optional window)
  (unless window (setq window (view-window pane)))
  (when (eq pane (selected-pane window))
    (update (command-pane window) window)))

(defmethod edit-value-ok ((window inspector-window))
  (let* ((view (inspector-view window))
         (selection (selection view))
         (selection-p (not (null selection))))
    (and selection-p 
         (memq (cached-type-n view selection) 
               '(nil :normal :colon)))))

  
(defmethod update ((pane command-pane) &optional (window(view-window pane)))
  (let ((b (view-named 'edit-button pane)))
    (when b      
        (set-dialog-item-enabled-p b (edit-value-ok window)))))

(defmethod resample ((w inspector-window))
  (do-subviews (pane w 'inspector-pane)
    (resample pane)))

(defun command-menu-item (inspector-window menu-name item-name)
  (find-menu-item (view-named menu-name (command-pane inspector-window)) 
                  item-name))

(defun resample-pane (w)
  (resample (selected-pane w)))

(defmethod cut ((w inspector-window))
  (cut (selected-pane w)))

(defmethod cut ((pane inspector-pane))
  (copy (inspector-view pane)))

(defmethod copy ((w inspector-window))
  (copy (inspector-view (selected-pane w))))

#|
(defmethod copy ((view inspector-view))
  (multiple-value-bind (object selection) (selected-object view)
    (if selection
      (put-scrap :lisp object)
      (ed-beep))))
|#

(defmethod copy ((view inspector-view))
  (multiple-value-bind (object selection) (selected-object view)
    (if selection
      (ccl::put-scraps object
                  (with-output-to-string (stream)
                    (format stream "~A~%" object)))
      (ed-beep))))

(defmethod paste ((w inspector-window))
  (let ((view (inspector-view (selected-pane w))))
    (if (and view (selection view))
      (paste view)
      (ed-beep))))

(defmethod paste ((view inspector-view))
  (let* ((selection (selection view)))
    (when selection
      (labels ((undo () (do-undo view #'redo "Redo Paste"))
               (redo () (do-undo view #'undo "Undo Paste")))
        (setup-undo view #'undo "Undo Paste"))
      (set-cached-line-n view selection (get-scrap :lisp)))))

(defmethod setup-undo ((view inspector-view) undo-function
                       &optional (string "Undo"))
  (let* ((window (view-window view))
         (selection (selection view))
         (value (cached-line-n view selection)))
    (setf (the-undo-view window) view
          (the-undo-value window) value
          (the-undo-selection window) selection
          (the-undo-function window) undo-function
          (the-undo-string window) string)))

(defmethod do-undo ((view inspector-view) redo-function redo-string)
  (let* ((window (view-window view))
         (selection (selection view))
         (the-undo-view (the-undo-view window))
         (the-undo-selection (the-undo-selection window))
         (the-undo-value (the-undo-value window)))
    (unless (and (eql selection the-undo-selection)
                 (eq the-undo-view view))
      (error "Inconsistent undo stuff."))
    (setup-undo view redo-function redo-string)
    (set-cached-line-n view selection the-undo-value)))

(defmethod undo ((window inspector-window))
  (undo (inspector-view (selected-pane window))))

(defmethod undo ((view inspector-view))
  (let ((f (the-undo-function (view-window view))))
    (when f (funcall f))))

(defmethod ccl::window-can-do-operation ((window inspector-window) op &optional item)
  (case op
    (undo
     (view-can-undo-p (inspector-view (selected-pane window)) item))
    ((undo-more select-all cut clear) nil) ; uh we dont do these
    (t (method-exists-p op window))))

(defun view-can-undo-p (view item)
  (let* ((window (view-window view))
         (the-undo-view (the-undo-view window))
         (the-undo-selection (the-undo-selection window)))
    (and (eq view the-undo-view)
         (eql (selection view) the-undo-selection)
         (progn
           (set-menu-item-title item (the-undo-string window))
           t))))

    
;;;;;;;
;;
;; Temporary pop-up editor
;;
(defclass inspector-editor (window)
  ((done-fun :initarg :done-fun :accessor done-fun)
   (value :initarg :value :accessor value)
   (modcnt :initform -1 :accessor modcnt))
  (:default-initargs
   :WINDOW-TYPE :DOCUMENT
   :view-position ':CENTERED
   :view-size #@(452 175)
   :theme-background t
   :CLOSE-BOX-P t
   :view-FONT (ccl::sys-font-spec))) ;'("Chicago" 12 :SRCOR :PLAIN)))

; Keep the dialog designer off these windows.
(defmethod ccl::editing-dialogs-p ((editor inspector-editor))
  nil)

(defmethod initialize-instance ((editor inspector-editor) &rest initargs
                                &key done-fun (window-show t))
  (declare (dynamic-extent initargs))
  (apply #'call-next-method 
         editor
         :window-show nil
         :window-type (if done-fun :document :double-edge-box)
         :done-fun (if done-fun
                     #'(lambda (value ok-button-p)
                         (update-modcnt editor)
                         (window-close editor)
                         (funcall done-fun value ok-button-p))
                     #'(lambda (value ok-button-p)
                         (return-from-modal-dialog (values value ok-button-p))))
         initargs)
  (add-subviews
   editor 
   (MAKE-DIALOG-ITEM 'fred-DIALOG-ITEM
                     #@(19 13)
                     #@(408 124)
                     ""
                     NIL
                     :VIEW-NICK-NAME ':editable-text
                     :view-font
                     *fred-default-font-spec*
                     :ALLOW-RETURNS T
                     :allow-tabs t
                     :text-edit-sel-p nil
                     :help-spec 15161)
   (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM
                     #@(37 148)
                     nil ;#@(62 18)
                     "Eval"
                     #'(LAMBDA
                         (ITEM)
                         ITEM
                         (INSPECTOR-EDITOR-EVAL (view-window ITEM)))
                     :view-font
                     (ccl::sys-font-spec) ;'("Chicago" 0 :SRCCOPY :PLAIN)
                     :DEFAULT-BUTTON NIL
                     :help-spec 15162)
   (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM
                     #@(283 148)
                     nil ;#@(62 18)
                     "Cancel"                     
                     #'(LAMBDA (ITEM)
                         (funcall (done-fun (view-window ITEM)) nil nil))
                     :view-font
                     (ccl::sys-font-spec) ;'("Chicago" 0 :SRCCOPY :PLAIN)
                     :cancel-BUTTON t
                     :help-spec 15163)
   (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM
                     #@(364 148)
                     nil ;@(62 18)
                     "OK"
                     #'(LAMBDA
                         (ITEM)
                         ITEM
                         (INSPECTOR-EDITOR-OK (view-window ITEM)))
                     :view-font
                     (ccl::sys-font-spec) ;'("Chicago" 0 :SRCCOPY :PLAIN)
                     :DEFAULT-BUTTON T
                     :help-spec 15164))
  (display-value editor)
  (update-modcnt editor)
  (when window-show (window-show editor)))

(defun nominal-columns (view &optional (sample-letter #\N))
  (setq sample-letter (string (character sample-letter)))
  (with-focused-view view
    (let ((width (point-h (view-size view)))
          (char-width (string-width sample-letter (view-font view))))
      (floor width char-width))))

(defun display-value (editor)
  (let* ((value (value editor))
         (item (view-named :editable-text editor))
         (columns (nominal-columns item)))
    (set-dialog-item-text item "")
    (let ((*print-circle* t)
          (*print-right-margin* columns)
          (*print-pretty* t))
      (prin1 value item))
    (set-selection-range item 0 t)))

(defun update-modcnt (editor)
  (setq editor (require-type editor 'inspector-editor))
  (setf (modcnt editor)
        (buffer-modcnt (fred-buffer (view-named :editable-text editor)))))

(defun get-modcnt (editor)
  (setq editor (require-type editor 'inspector-editor))
  (buffer-modcnt (fred-buffer (view-named :editable-text editor))))

(defun inspector-editor-eval (editor)
  (let* ((item (view-named :editable-text editor))
         (value (eval (read-from-string (dialog-item-text item)))))
    (setf (value editor) value)
    (display-value editor)
    (update-modcnt editor)))

(defun inspector-editor-ok (editor)
  (let ((value (value editor))
        error-p)
    (unless (eql (modcnt editor) (get-modcnt editor))
      (multiple-value-setq (value error-p)
                           (ignore-errors (values
                                           (read-from-string
                                            (dialog-item-text 
                                             (view-named :editable-text editor))))))
      (when error-p
        (return-from inspector-editor-ok (ed-beep))))
    (funcall (done-fun editor) value t)))

(defmethod window-close-event-handler ((editor inspector-editor))
  (funcall (done-fun editor) nil nil))

(defun edit-value (value done-fun &rest initargs)
  (declare (dynamic-extent initargs))
  (let ((w (apply #'make-instance 'inspector-editor
                  :value value :done-fun done-fun initargs)))
    (if done-fun
      w
      (modal-dialog w))))

(def-pass-thru edit-selection inspector-window inspector-view)

(defmethod edit-selection ((view inspector-view))
  (let ((selection (selection view)))
    (when selection
      (let* ((title (flet ((f (stream)
                            (princ "Editor for " stream)
                            (prin1 (inspector-object view) stream)))
                      (declare (dynamic-extent #'f))
                      (make-truncated-string #'f))))
        (edit-value (cached-line-n view selection)
                    #'(lambda (new-value ok-button-p)
                        (when ok-button-p
                          (window-select (view-window view))
                          (without-interrupts
                           (put-scrap :lisp new-value)
                           (set-selection view selection)
                           (paste view))))
                    :window-title title
                    :help-spec 15160)))))
#|
; The spec is an list of (text function) pairs
(defun make-button-list-view (spec &rest initargs &key
                                   (class 'view)
                                   (min-width 150)
                                   (view-font *fred-default-font-spec*)
                                   border-p
                                   &allow-other-keys)
  (declare (dynamic-extent initargs))
  (let* ((view (apply #'make-instance class
                      :view-font view-font
                      :allow-other-keys t
                      initargs))
         (v -1)
         (max-width min-width)
         height)
    (multiple-value-bind (a d w l) (font-info view-font)
      (declare (ignore w))
      (setq height (+ a d l 2)))
    (dolist (pair spec)
      (let* ((name (car pair))
             (action (cadr pair))
             (initargs (cddr pair))
             (button (when name
                       (apply #'make-instance
                              'button-dialog-item
                              :border-p border-p
                              :dialog-item-text name
                              :dialog-item-action action
                              :view-font view-font
                              :view-container view
                              :view-position (make-point -1 v)
                              initargs)))
             (size (make-point (if button (point-h (view-size button)) 0) height)))
        (if button (set-view-size button size))
        (incf v (1- height))
        (setq max-width (max max-width (point-h size)))))
    (set-view-size view (- max-width 2) v)
    (do-subviews (button view)
      (set-view-size button (make-point max-width (point-v (view-size button)))))
    view))

(defun make-button-list-window (title spec &rest initargs &key
                                      (class 'window)
                                      (view-position '(:top 100))
                                      (window-show t)
                                      (window-type :document)
                                      &allow-other-keys)
  (declare (dynamic-extent initargs))
  (let ((window (apply #'make-button-list-view spec 
                       :class class
                       :min-width (+ 70 (string-width title '("Chicago" 0)))
                       :view-position view-position
                       :window-show nil
                       :window-type window-type
                       :window-title title
                       :allow-other-keys t
                       initargs)))
    (when window-show
      (window-show window))
    window))
|#

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
