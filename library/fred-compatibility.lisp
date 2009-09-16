;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  1 4/4/95   slh  New file
;;  (do not edit before this line!!)

; Copyright 1995 Digitool, Inc. The 'tool rules!

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; A bunch of methods that delegate from fred-window to its window-key-handler
;;; and from scrolling-fred-view to its fred-item.
;;; Helps to compensate for the fact that fred-window no longer inherits from fred-mixin
;;; and neither does scrolling-fred-view. In MCL 2.0 scrolling-fred-dialog-item
;;; and fred-window did inherit from fred-mixin.
;;; This is not the complete set of fred-mixin methods, so add any you need.


(in-package :ccl)


#|
; These definitions are in the image already

(defmethod fred-item ((w fred-window))
  (window-key-handler w))

(defclass fred-delegation-mixin () ())

(defclass fred-window (fred-delegation-mixin window split-view )
  (;(window-cursor :allocation :class)
   (modified-marker :allocation :class :initform #\240 :reader modified-marker)
   ;(defs-dialog :initform nil)
   ;(status-line :initform nil :accessor view-status-line)
   )
  (:default-initargs
    :copy-styles-p t
    :history-length *fred-history-length*
    :text-edit-sel-p t
    :direction :vertical
    ;:view-size #@(300 200)
    ;:view-position '(:top 50)
    :track-thumb-p *fred-track-thumb-p*
    :erase-anonymous-invalidations nil
    :h-pane-splitter :right
    :v-pane-splitter :top))

(defclass scrolling-fred-view (fred-delegation-mixin view)
  ((scroll-bar-correction :initform #@(17 17) :accessor scroll-bar-correction)
   (grow-box-p :initarg :grow-box-p :initform nil :reader grow-box-p) ; just means leave room for it!
   (h-scroll-fraction :initform nil :initarg :h-scroll-fraction :accessor h-scroll-fraction) 
   (draw-scroller-outline :initarg :draw-scroller-outline :initform t :accessor draw-scroller-outline))   
  (:default-initargs
    ;:view-size nil
    :view-position nil
    :h-scroll-class 'fred-h-scroll-bar
    :v-scroll-class 'fred-v-scroll-bar
    :track-thumb-p *fred-track-thumb-p*
    :h-scrollp t
    :v-scrollp t
    :bar-dragger nil
    :h-pane-splitter nil
    :v-pane-splitter nil
    :view-font *fred-default-font-spec*
    :allow-returns t
    :allow-tabs t
    :margin 3   
    :text-edit-sel-p t  
    ;:save-buffer-p t    ; no longer needed
    ))
|#




(defmethod stream-tyo ((f fred-delegation-mixin) char)
  (stream-tyo (fred-item f) char))

(defmethod stream-write-string ((f fred-delegation-mixin) string start end)
  (stream-write-string (fred-item f) string start end))

(defmethod STREAM-TYI ((f fred-delegation-mixin))
  (stream-tyi (fred-item f)))

(defmethod STREAM-unTYI ((f fred-delegation-mixin) char)
  (stream-untyi (fred-item f) char))

(defmethod STREAM-eofp ((f fred-delegation-mixin))
  (stream-eofp (fred-item f)))

(defmethod STREAM-force-output ((f fred-delegation-mixin))
  (stream-force-output (fred-item f)))

(defmethod STREAM-fresh-line ((f fred-delegation-mixin))
  (stream-fresh-line (fred-item f)))

(defmethod interactive-stream-p ((f fred-delegation-mixin))
  (interactive-stream-p (fred-item f)))

(defmethod STREAM-filename ((f fred-delegation-mixin))
  (stream-filename (fred-item f)))

(defmethod STREAM-column ((f fred-delegation-mixin))
  (stream-column (fred-item f)))

(defmethod STREAM-position ((f fred-delegation-mixin) &optional new-pos)
  (stream-position (fred-item f) new-pos))

#|
; this is silly so dont do it.
(defmethod set-initial-view-font ((f fred-delegation-mixin) font)
  (let ((fred (fred-item f)))
    (when fred ; need this test else crash
      (set-initial-view-font (fred-item f) font))))
|#


#|
; already defined
(defmethod view-font-codes ((f fred-delegation-mixin))
  ;(call-next-method))
  (view-font-codes (fred-item f)))

 ; already defined
(defmethod set-view-font ((f fred-delegation-mixin) font)
  ;(call-next-method))
  (set-view-font (fred-item f) font))


(defmethod set-view-font-codes ((f fred-delegation-mixin) ff ms &optional ff-mask ms-mask)
  (set-view-font-codes (fred-item f) ff ms ff-mask ms-mask))
|#


(defmethod fred-blink-position ((f fred-delegation-mixin))
  (fred-blink-position (fred-item f)))


(defmethod ED-EVAL-OR-COMPILE-TOP-LEVEL-SEXP ((f fred-delegation-mixin))
  (ED-EVAL-OR-COMPILE-TOP-LEVEL-SEXP (fred-item f)))
#|
(defmethod PART-COLOR-LIST ((f fred-delegation-mixin))
  (part-color-list (fred-item f)))
|#

(defmethod (setf PART-COLOR-LIST) (list (f fred-delegation-mixin))
  (setf (part-color-list (fred-item f)) list))

(defmethod (SETF FRED-COPY-STYLES-P) (value (f fred-delegation-mixin))
  (setf (FRED-COPY-STYLES-P (fred-item f)) value))

(defmethod FRED-COPY-STYLES-P ((f fred-delegation-mixin))
  (fred-copy-styles-p (fred-item f)))

(defmethod (SETF FRED-SAVE-BUFFER-P) (value (f fred-delegation-mixin))
  (setf (FRED-save-buffer-p (fred-item f)) value))

(defmethod FRED-save-buffer-p ((f fred-delegation-mixin))
  (fred-save-buffer-p (fred-item f)))

#| ; already there
(defmethod part-color ((f fred-delegation-mixin) part)
  (part-color (fred-item f) part))

(defmethod fred-word-wrap-p ((f fred-delegation-mixin))
  (fred-word-wrap-p (fred-item f)))

(defmethod (setf fred-word-wrap-p) (value (f fred-delegation-mixin))
  (setf (fred-word-wrap-p (fred-item f)) value))

(defmethod fred-wrap-p ((f fred-delegation-mixin))
  (fred-wrap-p (fred-item f)))

(defmethod (setf fred-wrap-p) (value (f fred-delegation-mixin))
  (setf (fred-wrap-p (fred-item f)) value))

(defmethod fred-text-edit-sel-p ((f fred-delegation-mixin))
  (fred-text-edit-sel-p (fred-item f)))

(defmethod (setf fred-text-edit-sel-p) (value (f fred-delegation-mixin))
  (setf (fred-text-edit-sel-p (fred-item f)) value))


(defmethod fred-justification ((f fred-delegation-mixin))
  (fred-justification (fred-item f)))

(defmethod (setf fred-justification) (value (f fred-delegation-mixin))
  (setf (fred-justification (fred-item f)) value))

(defmethod fred-line-right-p ((f fred-delegation-mixin))
  (fred-line-right-p (fred-item f)))

(defmethod (setf fred-line-right-p) (value (f fred-delegation-mixin))
  (setf (fred-line-right-p (fred-item f)) value))

|#

(defmethod fred-comtab ((f fred-delegation-mixin))
  (fred-comtab (fred-item f)))

(defmethod ed-set-view-font ((f fred-delegation-mixin) font)
  (ed-set-view-font (fred-item f) font))

(defmethod ed-view-font-codes ((f fred-delegation-mixin))
  (ed-view-font-codes (fred-item f)))

#|
(defmethod FRED-DISPLAY-START-MARK ((f fred-delegation-mixin))
  (fred-display-start-mark (fred-item f)))
|#

(defmethod SET-FRED-DISPLAY-START-MARK ((f fred-delegation-mixin) position &optional no-drawing)
  (set-fred-display-start-mark (fred-item f) position no-drawing))

(defmethod FRED-hscroll ((f fred-delegation-mixin))
  (fred-hscroll (fred-item f)))

(defmethod set-FRED-hscroll ((f fred-delegation-mixin) value)
  (set-fred-hscroll (fred-item f) value))

(defmethod FRED-margin ((f fred-delegation-mixin))
  (fred-margin (fred-item f)))

(defmethod set-FRED-margin ((f fred-delegation-mixin) value)
  (set-fred-margin (fred-item f) value))

#|
(defmethod set-selection-range ((f fred-delegation-mixin)  &optional b e)
  (set-selection-range (fred-item f)  b e))

(defmethod selection-range ((f fred-delegation-mixin))
  (selection-range (fred-item f)))
|#

(defmethod selectionp ((f fred-delegation-mixin))
  (selectionp (fred-item f)))

#|
(defmethod window-show-cursor ((f fred-delegation-mixin) &optional pos scrolling) ; should be renamed
  (window-show-cursor (fred-item f) pos scrolling))


(defmethod WINDOW-SHOW-SELECTION ((f fred-delegation-mixin))
  (window-show-selection (fred-item f)))
|#

(defmethod window-eval-whole-buffer ((f fred-delegation-mixin)) ; should be renamed
  (window-eval-whole-buffer (fred-item f)))

(defmethod window-eval-selection ((f fred-delegation-mixin) &optional evalp) ; should be renamed
  (window-eval-selection (fred-item f) evalp))

(defmethod ed-insert-char ((f fred-delegation-mixin) char)
  (ed-insert-char (fred-item f) char))

(defmethod ED-DELETE-WITH-UNDO ((f fred-delegation-mixin) start end &optional save-p reverse-p append-p)
  (ed-delete-with-undo (fred-item f) start end save-p reverse-p append-p))

(defmethod ED-BACKWARD-SEXP ((f fred-delegation-mixin) &optional select)
  (ed-backward-sexp (fred-item f) select))

(defmethod ED-BACKWARD-SELECT-SEXP ((f fred-delegation-mixin))
  (ed-backward-select-sexp (fred-item f)))

(defmethod ED-forwarD-SEXP ((f fred-delegation-mixin) &optional select)
  (ed-forward-sexp (fred-item f) select))

(defmethod ED-forWARD-SELECT-SEXP ((f fred-delegation-mixin))
  (ed-forward-select-sexp (fred-item f)))

(defmethod ED-RUBOUT-CHAR ((f fred-delegation-mixin))
  (ed-rubout-char (fred-item f)))

(defmethod ED-DELETE-CHAR ((f fred-delegation-mixin))
  (ed-delete-char (fred-item f)))

(defmethod ED-DELETE-N ((f fred-delegation-mixin) n)
  (ed-delete-n (fred-item f) n))

(defmethod ED-KILL-LINE ((f fred-delegation-mixin))
  (ed-kill-line (fred-item f)))

(defmethod ED-END-OF-LINE ((f fred-delegation-mixin))
  (ed-end-of-line (fred-item f)))

(defmethod ED-SELECT-END-OF-LINE ((f fred-delegation-mixin))
  (ed-select-end-of-line (fred-item f)))

(defmethod ED-END-OF-BUFFER ((f fred-delegation-mixin))
  (ed-end-of-buffer (fred-item f)))

(defmethod ED-FORWARD-WORD ((f fred-delegation-mixin))
  (ed-forward-word (fred-item f)))

(defmethod ED-BEGINNING-OF-LINE ((f fred-delegation-mixin))
  (ed-beginning-of-line (fred-item f)))

(defmethod ED-SELECT-BEGINNING-OF-LINE ((f fred-delegation-mixin))
  (ed-select-beginning-of-line (fred-item f)))

(defmethod ED-BEGINNING-OF-BUFFER ((f fred-delegation-mixin))
  (ed-beginning-of-buffer (fred-item f)))

(defmethod ED-FORWARD-CHAR ((f fred-delegation-mixin) &optional (fwd t) select)
  (ed-forward-char (fred-item f) fwd select))

(defmethod ED-BACKWARD-CHAR ((f fred-delegation-mixin))
  (ed-backward-char (fred-item f)))

(defmethod ED-FORWARD-SELECT-CHAR ((f fred-delegation-mixin))
  (ed-forward-select-char (fred-item f)))

(defmethod ED-BACKWARD-SELECT-CHAR ((f fred-delegation-mixin))
  (ed-backward-select-char (fred-item f)))

(defmethod ED-BACKWARD-WORD ((f fred-delegation-mixin) &optional select)
  (ed-backward-word (fred-item f) select))

(defmethod ED-BACKWARD-SELECT-WORD ((f fred-delegation-mixin) &optional fwd)
  (ed-backward-select-word (fred-item f) fwd))
           
(defmethod ED-FORWARD-SELECT-WORD ((f fred-delegation-mixin))
  (ed-forward-select-word (fred-item f)))

(defmethod ED-NEXT-LINE ((f fred-delegation-mixin) &optional select)
  (ed-next-line (fred-item f) select))
 
(defmethod ED-PREVIOUS-LINE ((f fred-delegation-mixin))
  (ed-previous-line (fred-item f)))

(defmethod ED-SELECT-NEXT-LINE ((f fred-delegation-mixin) &optional n)
  (ed-select-next-line (fred-item f) n))

(defmethod ED-SELECT-PREVIOUS-LINE ((f fred-delegation-mixin))
  (ed-select-previous-line (fred-item f)))

#|
(defmethod COLLAPSE-SELECTION ((f fred-delegation-mixin) fwdp)
  (collapse-selection (fred-item f) fwdp))
|#

(defmethod ED-NEXT-SCREEN ((f fred-delegation-mixin) &optional select)
  (ed-next-screen (fred-item f) select))

(defmethod ED-SELECT-NEXT-SCREEN ((f fred-delegation-mixin))
  (ed-select-next-screen (fred-item f)))

(defmethod ED-PREVIOUS-SCREEN ((f fred-delegation-mixin) &optional select)
  (ed-previous-screen (fred-item f) select))

(defmethod ED-SELECT-PREVIOUS-SCREEN ((f fred-delegation-mixin))
  (ed-select-previous-screen (fred-item f)))

(defmethod ED-CAPITALIZE-WORD ((f fred-delegation-mixin))
  (ed-capitalize-word (fred-item f)))

(defmethod ED-UPCASE-WORD ((f fred-delegation-mixin))
  (ed-upcase-word (fred-item f)))

(defmethod ED-DOWNCASE-WORD ((f fred-delegation-mixin))
  (ed-downcase-word (fred-item f)))

(defmethod ED-KILL-SELECTION ((f fred-delegation-mixin))
  (ed-kill-selection (fred-item f)))

(defmethod ED-EDIT-CALLERS ((f fred-delegation-mixin) &optional pos)
  (ed-edit-callers (fred-item f) pos))

#| ;already there
(defmethod frec ((f fred-delegation-mixin))
  (frec (fred-item f)))
|#

(defmethod DRAW-HARDCOPY ((f fred-delegation-mixin))
  (draw-hardcopy (fred-item f)))

(defmethod WINDOW-HARDCOPY ((f fred-delegation-mixin) &optional (show-dialog t))
  (window-hardcopy (fred-item f) show-dialog))

(defmethod FRED-HPOS ((f fred-delegation-mixin) &optional pos)
  (fred-hpos (fred-item f) pos))

(defmethod FRED-VPOS ((f fred-delegation-mixin) &optional pos)
  (let ((fred (fred-item f)))
    (when (not pos) (setq pos (buffer-position (fred-buffer fred))))
    (fred-vpos (fred-item f) pos)))

(defmethod ED-RUBOUT-WORD ((f fred-delegation-mixin))
  (ed-rubout-word (fred-item f)))

(defmethod ED-DELETE-WORD ((f fred-delegation-mixin))
  (ed-delete-word (fred-item f)))


#|
; these are defined  for fred-mixin & are not delegated
(setq mm-names 
'((SETF WPTR)
  UNDO CUT COPY PASTE CLEAR select-all ; ?? - maybe not 
 (SETF PART-COLOR-LIST) PART-COLOR-LIST ; - ? 
(SETF FRED-SHADOWING-COMTAB) FRED-SHADOWING-COMTAB;- ?
 (SETF FRED-PREFIX-ARGUMENT) 
FRED-PREFIX-ARGUMENT (SETF FRED-LAST-COMMAND) FRED-LAST-COMMAND 
(SETF FILE-MODCNT) FILE-MODCNT (SETF FRED-COMTAB)
FRED-HISTORY FRED-UNDO-REDO SET-FRED-LAST-COMMAND 
SET-FRED-SHADOWING-COMTAB FRED-AUTO-PURGE-FONTS-P
FRED-CHUNK-SIZE
WINDOW-PACKAGE SNEAKY-WINDOW-PACKAGE 
FRED-PACKAGE SET-WINDOW-PACKAGE SET-FRED-PACKAGE
 WINDOW-NEEDS-SAVING-P SET-WINDOW-DOESNT-NEED-SAVING 
WINDOW-BUFFER-READ-ONLY-P WINDOW-SAVE-POSITION VIEW-SAVE-POSITION
WINDOW-RESTORE-POSITION VIEW-RESTORE-POSITION WINDOW-ASK-SAVE
WINDOW-SAVE-FILE WINDOW-SAVE-COPY-AS WINDOW-SAVE-AS WINDOW-SAVE 
WINDOW-SET-NOT-MODIFIED WINDOW-REVERT SET-WINDOW-FILENAME 
WINDOW-ENQUEUE-REGION WINDOW-SELECTION-STREAM 

KEYSTROKE-FUNCTION
RUN-DEFAULT-COMMAND RUN-FRED-COMMAND RUN-FRED-PREFIX 
SETUP-UNDO SETUP-UNDO-WITH-ARGS WINDOW-CAN-DO-OPERATION UNDO-MORE 
INTERACTIVE-ARGLIST
 ED-SELECT-NEXT-LIST ED-NEXT-LIST ED-SELECT-PREVIOUS-LIST
ED-PREVIOUS-LIST ED-BWD-UP-LIST ED-DOWN-LIST ED-FWD-UP-LIST
 FRED-PREFIX-NUMERIC-VALUE ED-LAST-BUFFER ED-SELF-INSERT ED-DIGIT 
ED-OPEN-LINE ED-SPLIT-LINE 
 ED-INDENT-FOR-LISP ED-INDENT-DIFFERENTLY
ED-INSERT-WITH-STYLE FRED-POINT-POSITION 
 FRED-LINE-VPOS WINDOW-TOP WINDOW-SEARCH WINDOW-REPLACE
WINDOW-REPLACE-ALL  MINI-BUFFER-SHOW-CURSOR 
SET-MINI-BUFFER  ED-PUSH-MARK ED-YANK 
ED-YANK-POP REPARSE-MODELINE TOGGLE-BLINKERS ED-DELETE-WHITESPACE 
 ED-KILL-REGION ED-COPY-REGION-AS-KILL
 ED-KILL-FORWARD-SEXP ED-KILL-BACKWARD-SEXP 
 ED-TRANSPOSE-CHARS 
ED-TRANSPOSE-WORDS ED-TRANSPOSE-SEXPS ED-BACK-TO-INDENTATION 
ED-NEWLINE-AND-INDENT  ED-WHAT-CURSOR-POSITION
ED-DELETE-HORIZONTAL-WHITESPACE ED-DELETE-FORWARD-WHITESPACE 
ED-DELIMIT-SELECTION ED-INSERT-SHARP-COMMENT ED-INSERT-DOUBLE-QUOTES 
ED-INSERT-PARENS ED-MOVE-OVER-CLOSE-AND-REINDENT ED-INDENT-COMMENT
ED-KILL-COMMENT ED-SET-COMMENT-COLUMN OPEN-FILE-ITEM-TITLE OPEN-FILE-ITEM-FILE 
ADD-MODELINE ED-UNIVERSAL-ARGUMENT ED-NUMERIC-ARGUMENT ED-PUSH/POP-MARK-RING 
ED-COLLAPSE-SELECTION ED-EXCHANGE-POINT-AND-MARK ED-RIGHT-MARGIN 
 ED-EDIT-DEFINITION ED-ARGLIST ED-CURRENT-SEXP ED-READ-CURRENT-SEXP 
ED-INSPECT-CURRENT-SEXP ED-INFO-CURRENT-SEXP ED-GET-DOCUMENTATION
ED-EVAL-OR-COMPILE-CURRENT-SEXP ED-EVAL-CURRENT-SEXP 
ED-MACROEXPAND-CURRENT-SEXP ED-MACROEXPAND-1-CURRENT-SEXP
ED-EVAL-OR-COMPILE-TOP-LEVEL-SEXP ED-START-TOP-LEVEL-SEXP
ED-SELECT-START-TOP-LEVEL-SEXP ED-CURRENT/NEXT-TOP-LEVEL-SEXP 
ED-END-TOP-LEVEL-SEXP ED-SELECT-END-TOP-LEVEL-SEXP 
ED-SELECT-TOP-LEVEL-SEXP ED-SELECT-CURRENT-SEXP ED-INDENT-SEXP 
ED-I-SEARCH-FORWARD ED-I-SEARCH-REVERSE DIALOG-ITEM-TEXT-LENGTH 
))

|#