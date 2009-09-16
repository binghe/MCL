;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 10/13/95 bill ccl3.0x25
;;  4 5/22/95  akh  ed-next-window - get window before set-window-layer
;;  3 5/1/95   akh  copyright
;;  2 4/4/95   akh  fix ed-scroll-up, c-m-w now toggles word-wrap vs wrap
;;  3 2/15/95  slh  added c-x 0 through c-x 9
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; assorted-fred-commands.lisp
;; Copyright 1990-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;;
;;  Examples of additional Fred commands.
;;
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Change History
;; comment out autoloading-edit-definition - reader macros do it already
;; usages of #\newline => various eol functions
;; ------- 5.2b6
;; clone-window - gets a proxy icon 
;; -------- 5.2b5
;; 10/13/95 bill  ed-other-window switches between multiple panes in
;;                a single window if there are any.
;; fix ed-scroll-up for nwo
;; clone-window - slots are now in fred-item not window, use window-filename vs pathname else
;; error if no file, new file-modcnt = old file-modcnt
;;-----------------
;; 11/23/92 alice set-view-font => ed-set-view-font
;; 02/23/93 bill ed-mpw-mode
;; 12/16/92 bill compile-file-for-buffer & friends now work correctly if
;;               the file name contains a "~" character.
;; 11/13/92 bill call frec functions that redraw with-focused-view.
;; 06/25/92 bill ed-delete-selection-silently
;; 06/02/92 bill clone-window uses its argument's class if it is a window.
;;-------------- 2.0
;; 01/06/92 bill add :shift in fred keystroke names where appropriate
;; 12/17/91 bill c-m-l -> c-m-L (c-m-l is ed-last-buffer)
;; ------------- 2.0b4
;; 08/28/91 gb   add an attribute line.
;; 08/28/91 bill c-m-. is ed-autoloading-edit-definition
;; 08/20/91 bill no more downward-function
;; 07/09/91 bill ed-fill-paragraph fills the first line of the paragraph
;; 05/30/91 bill c-m-C is compile-load-file-for-buffer
;;               c-m-l (small "L") is load-file-for-buffer
;;               c-m-B is ed-bold
;;               c-m-I (Capital "i") is ed-italic
;;               c-m-P is ed-plain
;; 05/16/91 bill It's not nice to bind a key to a function before it's been defined.
;;               prefix-numeric-value -> fred-prefix-numeric-value
;; 05/01/91 alice undo wants absolute buffer positions instead of marks, fred-prefix-numeric-value
;; 05/01/91 bill ed-scroll-up does a screenful if the shift key is not down.
;; 03/15/91 bill prefix-arg on TAB means indent region rigidly
;;               "C-x ." is ed-set-fill-prefix
;;               "C-x C-." is ed-set-fill-margin. The margin defaults
;;               to 72 pixels from the right edge of the view.
;;               "M-q" is ed-fill-paragraph
;; 02/27/91 bill Add buffer-remove-unsed-fonts to ed-refresh-screen.
;----------- 2.0b1
;; 01/24/91 bill m-n -> c-<shift>-V, m-p -> m-<shift>-V
;;               (scroll up or down one line)
;;

(in-package :ccl)

; Commands to change the font.
; Change the insertion font if nothing is selected, or the selection otherwise.
(defmethod ed-italic ((w fred-mixin))
  (ed-set-view-font w '(:italic)))

(defmethod ed-plain ((w fred-mixin))
  (ed-set-view-font w '(:plain)))

(defmethod ed-bold ((w fred-mixin))
  (ed-set-view-font w '(:bold)))


(comtab-set-key *comtab* '(:meta :control #\I) 'ed-italic)
(comtab-set-key *comtab* '(:meta :control :shift #\P) 'ed-plain)
(comtab-set-key *comtab* '(:meta :control :shift #\B) 'ed-bold)

; M-N & M-P are similar to C-N & C-P, but the screen is moved, not the cursor.
(defmethod ed-scroll-up ((w fred-mixin) &optional lines)
  (if (shift-key-p)
    (let* ((mark (fred-display-start-mark w))
           (frec (frec w)))
      (set-fred-display-start-mark
       w 
       (frec-screen-line-start frec mark (or lines (fred-prefix-numeric-value w))))    
      (setq *show-cursor-p* nil))
    (if (and lines (< lines 0))
      (ed-previous-screen w)
      (ed-next-screen w))))

(defmethod ed-scroll-down ((w fred-mixin) &optional lines)
  (ed-scroll-up w (- (or lines (fred-prefix-numeric-value w)))))

(comtab-set-key *comtab* '(:control :shift #\V) 'ed-scroll-up)
(comtab-set-key *comtab* '(:meta :shift #\V) 'ed-scroll-down)

; C-L refreshes the screen.
(defmethod ed-scroll-cursor-to-top ((w fred-mixin))
  (let* ((frec (frec w))
         (bpos (buffer-position (fred-buffer w)))
         (lines (frec-full-lines frec))
         (context (next-screen-context-lines lines)))
    (set-mark (fred-display-start-mark w)
              (frec-screen-line-start frec bpos (- context)))
    (with-focused-view w
      (frec-draw-contents frec t))))

(defmethod ed-refresh-screen ((w fred-mixin))
  (buffer-remove-unused-fonts (fred-buffer w))
  (with-focused-view w
    (frec-draw-contents (frec w) t)))

; You may prefer ed-scroll-cursor-to-top to ed-refresh-screen here.
(comtab-set-key *comtab* '(:control #\l) 'ed-refresh-screen)


; C-M-W toggles word  wrapping.
(defun ed-toggle-wrap-p (w)
  (setf (fred-word-wrap-p w) (not (fred-word-wrap-p w)))
  ;(ed-refresh-screen w)
  )

(comtab-set-key *comtab* '(:control :meta #\w) 'ed-toggle-wrap-p)


; C-X O moves to the next window that is not a listener.
;       or moves to the next key-handler in the current window, if there is one.
; C-X N moves the top window to the bottom.
; C-X P moves the bottom window to the top.
(defmethod ed-other-window ((view fred-mixin))
  (let* ((w (view-window view))
         (pred #'(lambda (v) (and (key-handler-p v)
                                  (not (typep v 'mini-buffer-fred-item)))))
         (key-handlers (%get-key-handler-list w))
         (next-handler (or (find-if pred (cdr (memq view key-handlers)))
                           (find-if pred key-handlers))))
    (if (and next-handler (neq next-handler view))
      (set-current-key-handler w next-handler nil)
      (if *modal-dialog-on-top*
        (ed-beep)
        (let ((other-window #'(lambda (window)
                                (unless (or (eq w window) (typep window 'listener))
                                  (window-select window)
                                  (return-from ed-other-window window)))))
          (declare (dynamic-extent other-window))
          (map-windows other-window))))))

(defmethod ed-next-window ((w fred-mixin))
  (let ((the-win (view-window w)))
    (set-window-layer the-win 10000)))

(defmethod ed-previous-window ((w fred-mixin))
  (let ((last (car (last (windows)))))
    (when last
      (window-select last))))

(comtab-set-key *control-x-comtab* '(#\o) 'ed-other-window)
(comtab-set-key *control-x-comtab* '(#\n) 'ed-next-window)
(comtab-set-key *control-x-comtab* '(#\p) 'ed-previous-window)

; <Shift><Tab> inserts a tab character in the buffer.
; <Prefix Argument><Tab> indents the region by <Prefix Argument> spaces
; (which must be positive)

(defmethod ed-tab ((w fred-mixin))
  (if (shift-key-p)
    (ed-self-insert w)
    (let ((value (fred-prefix-argument w)))
      (if value
        (fred-indent-region-rigidly w value)
        (ed-indent-for-lisp w)))))

; This should really support undo.
(defmethod fred-indent-region-rigidly ((w fred-mixin) &optional 
                                       (value (fred-prefix-numeric-value w)))
  (multiple-value-bind (b e) (kill-range w)
    (if (< e b)
      (psetq e b b e))
    (if (= e b) (return-from fred-indent-region-rigidly nil))
    (let* ((buf (fred-buffer w))
           (start (buffer-line-start buf b))
           (bmark (make-mark buf b t))
           (emark (make-mark buf e))
           (string (buffer-substring buf b e))
           (style (buffer-get-style buf b e)))
      (setq e (make-mark buf (1- e)))
      (unwind-protect
        (flet ((insert-indentation (buf value pos)
                 (dotimes (i value)
                   (buffer-insert buf #\space pos))))
          (if (eql b start) (insert-indentation buf value b))
          (loop
            (setq b (buffer-forward-find-eol buf b (buffer-position e)))
            (unless b (return))
            (unless (or (eq b (buffer-size buf)) (char-eolp (buffer-char buf b)))
              (insert-indentation buf value b))))
        (setup-undo w #'(lambda ()
                          (buffer-delete buf (buffer-position bmark) (buffer-position emark))
                          (buffer-insert-with-style buf string style)
                          (fred-update w)))))))

(comtab-set-key *comtab* '#\tab 'ed-tab)

(defmethod ed-set-fill-prefix ((w fred-mixin))
  (let* ((buf (fred-buffer w))
         (pos (buffer-position buf))
         (start (buffer-line-start buf))
         (prefix (unless (eql start pos)
                   (cons (buffer-substring buf start pos)
                         (buffer-get-style buf start pos)))))
    (if prefix
      (setf (view-get w 'fill-prefix) prefix)
      (view-remprop w 'fill-prefix))))

(defmethod ed-set-fill-margin ((w fred-mixin))
  (let* ((buf (fred-buffer w))
         (pos (buffer-position buf))
         (start (buffer-line-start buf))
         (wid (buffer-string-width buf start pos)))
    (setf (view-get w 'fill-margin) wid)))

(comtab-set-key *control-x-comtab* #\. 'ed-set-fill-prefix)
(comtab-set-key *control-x-comtab* '(:control #\.) 'ed-set-fill-margin)

(defconstant *paragraph-marker*
"

")




;; same as wsp&cr in fredenv.lisp
(defconstant *wsp&cr* #.(let ((str (make-string 9 :element-type 'extended-character)))
                        (set-schar str 0 #\Space)
                        (set-schar str 1 (code-char 13)) ;; #\return
                        (set-schar str 2 (code-char 9)) ;; #\tab
                        (set-schar str 3 (code-char 12)) ;; #\page
                        (set-schar str 4 (code-char 0)) ;; #\null
                        (set-schar str 5 (code-char 10)) ;; #\linefeed
                        (set-schar str 6 (code-char #xa0))  ;; non breaking space
                        (set-schar str 7 (code-char #x2028)) ;; line separator
                        (set-schar str 8 (code-char #x2029)) ;; paragraph separator
                        str))

(defmethod paragraph-bounds ((w fred-mixin))
  (multiple-value-bind (b e) (selection-range w)
    (when (eq b e)
      (let* ((buf (fred-buffer w)))
        (setq b (buffer-backward-find-eol buf ))
        (if b
          (loop
            (if (<= b 0) (return))
            (let ((b2 (buffer-backward-find-eol buf  b 0)))
              (unless b2 (return (setq b 0)))
              (unless (buffer-forward-find-not-char buf *wsp&cr* b2 b)
                (return (incf b)))
              (setq b b2)))
          (setq b 0))
        (setq e (buffer-forward-find-eol buf ))
        (if e
          (loop
            (if (>= e (buffer-size buf)) (return))
            (let ((e2 (buffer-forward-find-eol buf  e)))
              (unless e2 (return (setq e (buffer-size buf))))
              (unless (buffer-forward-find-not-char buf *wsp&cr* e e2)
                (return (decf e)))
              (setq e e2)))
          (setq e (buffer-size buf)))))
    (values b e)))

(defmethod ed-fill-paragraph ((w fred-mixin))
  (multiple-value-bind (b e) (paragraph-bounds w)
    (unless (eq b e)
      (let* ((buf (fred-buffer w))
             (margin (or (view-get w 'fill-margin) (- (point-h (view-size w)) 72)))
             (prefix (view-get w 'fill-prefix))
             (bmark (make-mark buf b t))
             (emark (make-mark buf e))
             (string (buffer-substring buf b e))
             (style (buffer-get-style buf b e))
             p last-word-end wsp-end done?)
        (unwind-protect
          (progn
            (setq e (make-mark buf e))
            (if (and (eql b (buffer-line-start buf b))
                     (setq p (buffer-forward-find-not-char buf *wsp&cr* b e)))
              (progn
                (buffer-delete buf b (decf p))
                (setq p b)
                (when prefix
                  (buffer-insert-with-style buf (car prefix) (cdr prefix) b)
                  (incf p (length (car prefix)))))
              (setq p b))
            (loop
              (setq p (buffer-forward-find-char buf *wsp&cr* p e))
              (if p 
                (progn
                  (setq wsp-end (buffer-forward-find-not-char buf *wsp&cr* p e)
                        p (1- p)
                        wsp-end (if wsp-end (1- wsp-end) e))
                  (buffer-delete buf p wsp-end)
                  (buffer-insert buf " " p))
                (setq p (buffer-position e) wsp-end p done? t))
              (if (> (buffer-string-width buf b p) margin)
                (progn
                  (unless last-word-end
                    (if done? (return))
                    (setq last-word-end p))
                  (buffer-delete buf last-word-end (1+ last-word-end))
                  (buffer-insert buf (or *preferred-eol-character* #\newline) last-word-end)
                  (setq b (1+ last-word-end)
                        p b)
                  (if (>= p (buffer-position e)) (return))
                  (when prefix
                    (buffer-insert-with-style buf (car prefix) (cdr prefix) b)
                    (incf p (length (car prefix))))
                  (setq last-word-end nil))
                (progn
                  (setq last-word-end p)
                  (incf p)))
              (if done? (return))))
          (setup-undo w #'(lambda ()
                            (buffer-delete bmark (buffer-position bmark) (buffer-position emark))
                            (buffer-insert-with-style bmark string style)
                            (fred-update w))))))))

(comtab-set-key *comtab* '(:meta #\q) 'ed-fill-paragraph)

; C-X C-Y replaces the selection with a file.
(comtab-set-key *control-x-comtab* '(:control #\y)
                'ed-replace-selection-with-chosen-file)
 
(defmethod ed-replace-selection-with-chosen-file ((w fred-mixin))
   (let ((the-pathname
          (catch-cancel (choose-file-dialog :button-string "File"))))
      (unless (eql the-pathname :CANCEL)
         (ed-kill-selection w)    ;If there is a selection, just kill it.
         (let ((start-pos (buffer-position (fred-buffer w))))
            (buffer-insert
             (fred-buffer w)
             (use-logical-dir (namestring the-pathname) '("ccl;" "home;")))
            (set-selection-range w start-pos))))) ;select what was inserted
 
(defun use-logical-dir (the-namestring logical-dir-list
                                       &aux dir-namestring)
   "If the expansion of a given logical directory matches the prefix
    of the pathname, a string is returned with the substitution made,
    otherwise the original namestring is returned."
   (dolist (a-logical-dir logical-dir-list)
      (setq dir-namestring (namestring (full-pathname a-logical-dir)))
      (if (eql (search dir-namestring the-namestring) 0)
         (return-from
          use-logical-dir
          (concatenate
           'simple-string
           a-logical-dir
           (subseq the-namestring (length dir-namestring))))))
   the-namestring)

; Disable the dead keys.
; You may not want to do this if you use accents a lot.
(def-load-pointers disable-dead-keys ()
  (set-dead-keys nil))


; C-M-C compiles the file for a fred-window.
(defun compile-file-for-buffer (w)
  (let ((file (pathname w)))
    (if file
      (let ((format-string "Compiling \"~a\"É~:[~; done.~]"))
        (window-save w)
        (set-mini-buffer w format-string file nil)
        (fred-update w)
        (eval-enqueue
         `(progn
            (compile-file ',file)
            (set-mini-buffer ',w ,format-string ,file t))))
      (ed-beep))))

(defun load-file-for-buffer (w)
  (let ((file (pathname w)))
    (if file
      (progn
        (setq file (make-pathname :type nil :defaults file))
        (let ((format-string "Loading \"~a\"É~:[~; done.~]"))
          (window-save w)
          (set-mini-buffer w format-string file nil)
          (fred-update w)
          (eval-enqueue
           `(progn
              (load ',file)
              (set-mini-buffer ',w ,format-string ,file t)))))
      (ed-beep))))

(defun compile-load-file-for-buffer (w)
  (let ((file (pathname w)))
    (if file
      (let ((format-string "Compiling & loading \"~a\"É~:[~; done.~]"))
        (window-save w)
        (set-mini-buffer w format-string file nil)
        (fred-update w)
        (eval-enqueue
         `(progn
            (compile-load ',file)
            (set-mini-buffer ',w ,format-string ,file t))))
      (ed-beep))))


(comtab-set-key *comtab* '(:control :meta #\c) 'compile-file-for-buffer)
(comtab-set-key *comtab* '(:control :meta :shift #\C) 'compile-load-file-for-buffer)
(comtab-set-key *comtab* '(:control :meta :shift #\L) 'load-file-for-buffer)

; C-M-Y makes a second copy of the top window sharing it's buffer.
; This still has a bug in that the modified markers are not updated in parallel.
; Well they are now.
; does anybody use this ?? - maybe did before split panes
(defmethod clone-window ((view fred-mixin))
  (let ((w (view-window view)))
    (let* ((is-modif (window-needs-saving-p (fred-item w)))
           (new-w (make-instance (if (typep view 'window)
                                   (class-of view)
                                   *default-editor-class*)
                    :view-size (view-size w)
                    :view-position (add-points (view-position w) #@(15 15))
                    :buffer (make-mark (fred-buffer view))
                    ;:scratch-p t ; prevents brief appearance of modified mark in original 
                    :window-show nil))
           (filename (window-filename w))
           (fred-item (window-key-handler new-w)))
      (setf (slot-value fred-item 'file-modcnt) (slot-value view 'file-modcnt))
      (when filename
        #+ignore
        (setf (slot-value fred-item 'my-file-name) filename
              (fred-save-buffer-p view) t ) 
        (set-window-filename new-w filename))
      (when (not is-modif)
        (window-set-not-modified w))
      ;(fred-update w)
      (fred-update new-w)
      (set-mark (fred-display-start-mark new-w) 
                (buffer-position (fred-display-start-mark view)))
      (window-show new-w))))

(comtab-set-key *comtab* '(:control :meta #\y) 'clone-window)

; edit-definition, but look for unloaded interface definitions, too
#|
(defun autoloading-edit-definition (def)
  (or (edit-definition def)
      (let ((*autoload-traps* t)) 
        (or (and (ignore-errors (load-trap def))
                 (edit-definition def))
            (and (load-record def)
                 (edit-definition def))
            (and (ignore-errors (load-trap-constant def))
                 (edit-definition def))
            (and (load-mactype def)
                 (edit-definition def))))))

(defun ed-autoloading-edit-definition (w)
  (let ((form (ignore-errors (ed-current-sexp w))))
    (if (and form (symbolp form))
      (autoloading-edit-definition form)
      (ed-edit-definition w))))

(comtab-set-key *comtab* '(:control :meta #\.) 'ed-autoloading-edit-definition)
|#

(defun ed-delete-selection-silently (self)
  (multiple-value-bind (b e) (selection-range self)
    (unless (eql b e)
      (let ((buf (fred-buffer self)))
        (buffer-delete buf b e)))))

(def-fred-command (:control #\delete) ed-delete-selection-silently)

; Some simple editor mode handling stuff.
(defun ed-enter-mode (w mode-name &rest bindings)
  (let* ((buf (fred-buffer w))
         (modes (buffer-getprop buf :modes))
         (comtab (slot-value w 'comtab)))
    (when (eq comtab *comtab*)
      (setf (slot-value w 'comtab)
            (setq comtab (copy-comtab comtab))))
    (when (assq mode-name modes)
      (ed-exit-mode w mode-name)
      (setq modes (buffer-getprop buf :modes)))
    (let ((old-bindings (insert-key-bindings comtab bindings)))
      (setf (buffer-getprop buf :modes)
            (cons (cons mode-name old-bindings)
                  modes)))))

(defun insert-key-bindings (comtab bindings)
  (let (old-bindings)
    (loop
      (unless bindings (return))
      (let* ((key (pop bindings))
             (function (pop bindings)))
        (push key old-bindings)
        (push (comtab-get-key comtab key) old-bindings)
        (comtab-set-key comtab key function)))
    (nreverse old-bindings)))

(defun ed-exit-mode (w mode-name)
  (let* ((buf (fred-buffer w))
         (modes (buffer-getprop buf :modes))
         (this-mode (assq mode-name modes))
         (comtab (slot-value w 'comtab))
         later-modes)
    (when this-mode
      (loop
        (let ((mode (pop modes)))
          (when (eq mode this-mode)
            (insert-key-bindings comtab (cdr mode))
            (return))
          (push (cons (car mode) (insert-key-bindings comtab (cdr mode)))
                later-modes)))
      (dolist (mode later-modes)
        (push (cons (car mode) (insert-key-bindings comtab (cdr mode)))
              modes))
      (setf (buffer-getprop buf :modes) modes))))

; A mode that makes #\return & #\tab behave as they do in MPW
(defun ed-mpw-mode (w)
  (ed-enter-mode w :mpw
                 #\return 'ed-return-and-indent-for-mpw
                 #\tab 'ed-self-insert
                 '(:meta :shift #\M) 'ed-end-mpw-mode)
  (set-mini-buffer w "MPW mode."))

(defun ed-end-mpw-mode (w)
  (ed-exit-mode w :mpw)
  (set-mini-buffer w "End MPW mode."))

(defconstant *wsp* #.(coerce #(#\space #\tab) 'string))

(defun ed-return-and-indent-for-mpw (w)
  (let* ((buf (fred-buffer w))
         (start (buffer-line-start buf))
         (end (buffer-forward-find-not-char buf *wsp* start buf)))
    (if end
      (decf end)
      (setq end (buffer-position buf)))
    (buffer-insert buf #\return)
    (buffer-insert buf (buffer-substring buf start end))))

(comtab-set-key *comtab* '(:meta :shift #\m) 'ed-mpw-mode)
            

;;; C-X C-0 through C-X C-9 select 0-9th pane

(defmethod ed-nth-pane ((item fred-mixin))
  (let* ((pane-num (- *current-keystroke* #.(char-code #\0)))
         (w (view-window item))
         (key-handlers (key-handler-list w))
         (mb-pos (position (view-mini-buffer w) key-handlers))
         (new-handler (nth (if (< pane-num mb-pos)
                             pane-num
                             (1+ pane-num))
                           key-handlers)))
    (if new-handler
      (set-current-key-handler w new-handler)
      (ed-beep))))

(dotimes (i 10)
  (comtab-set-key *control-x-comtab*
                  `(,(code-char (+ #.(char-code #\0) i)))
                  'ed-nth-pane))

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
