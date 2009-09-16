;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;; $Log: fred-misc.lisp,v $
;; Revision 1.8  2005/02/08 00:54:01  alice
;; ;; forget *string-compare-script* in buffer-upcase etal
;;
;; Revision 1.7  2005/02/08 00:32:12  alice
;; ;; forget *string-compare-script* in buffer-upcase etal
;;
;; Revision 1.6  2004/12/20 22:13:42  alice
;; ;; 12/10/04 eol stuff
;;
;; Revision 1.5  2003/12/08 08:08:59  gtbyers
;; Use WITH-SLOTS instead of WITH-SLOT-VALUES.
;;
;; 12/20/02 akh fix window-show-range to not run past end of buffer
;; --------- 4.4b5
;;  10 1/22/97 akh  ed-toggle-auto-keyscript (meta-j) for Kanji users
;;  8 6/16/96  akh  window-show-range for the 88th time
;;  7 5/20/96  akh  window-show-range again - check beginning of last line vs end
;;  6 4/17/96  akh  window-show-selection - focus
;;  4 4/1/96   akh  fix window-show-range
;;  3 2/19/96  akh  window-show-range - don't frec-update with no-drawing -
;;                   messes up when paste or yank at end of listener
;;  6 5/23/95  akh  focus in window-show-range
;;  5 5/23/95  akh  added window-show-range - used by yank, yank-pop and paste
;;  4 5/17/95  akh  window-show-selection - always set c = position
;;  3 5/8/95   akh  probably no change
;;  10 3/15/95 akh  window-show-selection - back to min else too slow when growing search string
;;  9 3/14/95  akh  use with-text-colors
;;  8 3/2/95   akh  add a comment in window-scroll-to-bottom
;;  7 1/30/95  akh  window-scroll-to-bottom assures frec is up to date
;;  (do not edit before this line!!)

;; fred-misc.lisp - assorted "small" commands and functions.

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-1999 Digitool, Inc.

#|
Modification History
;; dont use buffer-roman
;; use *preferred-eol-character* if non nil in a couple of places
;; with-slots is silly
;; ------- 5.2b6
;; forget *string-compare-script* in buffer-upcase etal etc
;; 12/10/04 eol stuff
;; ------- 5.1 final
05/`9.add ed-reset-font
--------- 4.3b2
 akh ed-toggle-auto-keyscript (meta-j) for Kanji users
 08/20/96 bill  AlanR's idea: (method window-search (fred-mixin t)) turns off
                fr.frame-sel-p in the frec if the search is successful.
                This makes the outlined search string easier to see.
 -------------- MCL 4.0b1
 -------------- MCL-PPC 3.9
 akh window-show-range yet again - check not past end
 akh window-show-range again - check beginning of last line vs end
 04/15/96 akh window-show-selection - focus

 12/21/95 slh   add require fredenv form
 10/13/95 slh   add in-package form
ed-previous-screen dtrt when pos is 0
01/03/95 alice fred-selection-for-word-command deal with non-roman scripts
ed-transpose-sexps fix so that undo works reliably & dont do it if string1 is inside string2
ed-what-cursor-position - shows pos in mini-buffer too
09/24/93 alice ed-move-over-close-and-reindent and ed-indent-comment act like self-insert if no kill
		ed-delimit-selection uses ed-insert-char (self-insert) if no selection.
;-------------
07/06/93 alice buffer-upcase downcase and capitalize are function of script.
04/16/93 alice ed-back-to-indentation does collapse-selection
 11/30/92 alice - ed-delimit-selection heeds font *last-command*
		things that don't are yank, yank-pop, various indenters
; 10/23/92 alice ed-yank, ed-yank-pop deal with list of lists
; 10/07/92 alice c-return act like self-insert w.r.to undo
; 02/22/92 alice ed-newline-and-indent - kill selection, then get position
11/17/92 bill  fr.xxx -> higher-level accessors
03/24/92 bill  Reparse-modeline no longer causes an infinite loop when
               the modeline creates the package.
-------------- 2.0f3
12/19/91 alice reparse-modeline gets no-create arg
12/04/91 alice fix ed-delete-whitespace to not leave a space between (( or ))
;		fix m-) for Henry Lieberman
12/17/91 bill  remove binary-search def.  There's another one in simple-db.lisp
------------- 2.0b4
07/29/91 alice window-replace-all gets optional start arg
07/21/91 alice ed-transpose-xxx boundaries 
07/18/91 alice ed-yank and ed-yank-pop guard against nil killed-string
07/15/91 alice insert-with-history => insert-with-undo ditto replace-with
07/08/91 bill set-selection-range was needlessly redefined here.
06/07/91 bill buffer-remove-unused-fonts in reparse-modeline
06/05/91 bill Jim Grandy's ed-insert-delimited

06/21/91 alice ed-yank history append to kill if any
;-------------- 2.0b2
05/30/91 alice fix fix to window-show-selection
05/29/91 bill add-modeline
05/17/91 bill ed-transpose-words needed some buffer-position's
05/15/91 bill reparse-modeline no longer does buffer-first-in-package
04/25/91 bill fix window-show-selection
04/16/91 bill ed-indent-comment uses tab stops if the line-length is greater
              than the comment-column.  Fix little bug.
05/03/91 alice ed-kill-backward-sexp, switch b and e
05/03/91 alice prefix-numeric-value => fred-prefix-numeric-value
05/02/91 alice ed-yank got broken when history stuff added
05/02/91 alice fred-selection-for-word-command - reset b and e after collapse-selection
05/01/91 alice select iff shift-key-p (i.e. not shift-lock)
04/30/91 alice ed-next-screen and previous screen had args to extend-sel backwards
04/21/91 alice fix upcase and downcase undo, transpose-words, sexps
04/18/91 alice history stuff added
03/26/91 alice ed-universal-argument - deal with 'minus from m--
03/25/91 alice ed-next/previous-screen had bogus calls to frec-extend-selection-2
03/25/91 alice upcase, downcase and capitalize word - use common routine - respect region
03/25/91 bill buffer-line was missing
03/20/91 alice prefix numerics set *prefix-command-p* t not fred-last-command = 'prefix
03/19/91 alice add ed-select-next-screen and ed-select-previous-screen extend-sel
03/13/91 alice fred-selection-for-word-command do prefix arg
03/12/91 alice added ed-back-to-indentation - m-m
03/11/91 alice mark-ring remembers fred-display-start pos and restores that too
               ed-yank - if new pos not visible, make it so near the bottom not top
03/08/91 alice ed-kill-backward-sexp - call delete-with-undo with backwards t
               negative numeric arguments were TOTALLY broken(-2 => -12)
------------- 2.0b1
02/05/91 bill ed-push/pop-mark-ring makes a backward mark.
02/01/91 bill ed-universal-argument clears mini-buffer before printing.
01/24/91 bill in ed-transpose-sexp: over-sharps to buffer-bwd-sexp
01/16/91 bill add silent-p arg to window-search
01/15/91 bill Make window-search return a success value.
01/02/90 bill ed-transpose-chars no longer errors on an empty buffer.
12/28/90 bill ed-transpose-chars works more like EMACS at end of buffer.
12/06/90 bill ed-fill-region: (<= dif 0) -> (< dif 0)
11/30/90 bill ed-fill-region, binary-search.
11/01/90 bill reparse-modeline doesn't change the package if there's no modeline.
              (slot-value w 'prefix-argument) - (fred-prefix-argument w)
              (slot-value w 'last-command) - (fred-last-command w)
10/16/90 gb   no more %str-length.
09/21/90 bill ed-push/pop-mark-ring needed to collapse-selection on pop.
08/23/90 bill fred-start-mark -> fred-display-start-mark
07/31/90 bill use next-screen-context-lines function as opposed to *next-screen-context-lines* var.
07/06/90 bill ed-kill-comments err'd when there was none.
06/15/90 bill in ed-universal-argument: (slot-value * 'mini-buffer) -> (view-mini-buffer *)
06/12/90 bill ed-kill-sexp -> ed-kill-forward-sexp, ed-kill-backward-sexp,
              window-buffer -> fred-buffer, window-update -> fred-update,
              window-start-mark -> fred-start-mark
06/01/90 bill Don't push a mark on mouse selection.  Make ed-kill-region & ed-copy-region-as-kill
              look for a mouse-selection or between point & mark: kill-range.
05/06/90 bill New scrap handler: (car *killed-strings*) => (first-killed-string)
04/07/90 bill added buffer-first-in-package to reparse-modeline
04/11/90  gz  word-chars -> *fred-word-constituents*
              Added fred-selection-for-word-command.
04/07/90 bill added buffer-first-in-package to reparse-modeline
02/14/90 bill Push the starting end of a mouse-selection on the mark ring.
              ed-kill-region now kills between point and top of mark-ring.
              ed-kill-selection kills the highlighted selection.
              ed-rubout-word appends killed word to front of previous stuff.
              WSearch: frec-set-sel => set-selection-range.
01/13/90 gz   wtop->window-top, wsearch-> window-search, wreplace -> window-replace.
09/12/89 bill Convert to CLOS
08/30/89  gz  add numarg and mark ring fns.
              Make yanking leave a mark behind.
              count-buffer-lines is gone, don't call it.
07/24/89 bill add reparse-modeline
05/20/89  gz window-update -> window-object-update.
03/18/89  gz window-foo -> window-object-foo.
10-apr-89 as ed-delete-whitespace
12/30/88  gz new buffers.
12/16/88  gz ed-lquoted-p -> buffer-lquoted-p. tb$maxasc -> %buffer-maxasc.
12/11/88  gz mark-position -> buffer-position
12/2/88   gz moved buffer-line here, renamed to count-buffer-lines.
From 1.3: 10/27/88 as abstracted window-show-selection from wsearch
10/18/88 gz Lotsa mods new fred windows.
8/20/88  gz fix compiler warnings...
8/11/88  gz split off from fred-additions and l1-edcmd. Flushed ed-unselect.
           Added indent-comment et. al.
|#

(in-package "CCL")

(eval-when (:compile-toplevel :execute)
  (require "FREDENV"))

; m-space
(defmethod ed-delete-whitespace ((w fred-mixin))
  (let ((buffer (fred-buffer w)))
    (multiple-value-bind (b e) (selection-range w)
      (when (/= b e) 
        (setq b (buffer-position buffer))
        (set-selection-range w b b))
      (let* ((start (1+ (or (buffer-backward-find-not-char
                             buffer wsp&cr b 0)
                            -1)))
             (end (1- (or (buffer-forward-find-not-char
                           buffer wsp&cr b t)
                          (1+ (buffer-size buffer))))) 
             (scratch-char nil))
        (unless (eq start end) 
          (ed-delete-with-history w start end)
          (when (< 0 start)
            (unless (and (%str-member
                              (setq scratch-char
                                    (buffer-char buffer (1- start)))
                              "()[]{}")
                         (eq scratch-char (buffer-char buffer start)))
              (ed-insert-with-undo w #\space start t))))))))

; used internally 
(defmethod ed-kill-selection ((w fred-mixin))
  (multiple-value-bind (b e) (selection-range w)
    (unless (eq b e)
      (ed-delete-with-undo w b e) T)))

; c-w
(defmethod ed-kill-region ((w fred-mixin))
  (multiple-value-bind (b e) (kill-range w)
    (unless (or (null e) (eq b e))
      (ed-delete-with-undo w b e))))

(defmethod ed-copy-region-as-kill ((w fred-mixin) &aux (buf (fred-buffer w)))
  (multiple-value-bind (b e) (kill-range w)
    (unless (or (null e) (eq b e))
      (add-to-killed-strings
       (cons (buffer-substring buf b e)
             (if (fred-copy-styles-p w)(buffer-get-style buf b e))))
      (set-mini-buffer w "~&Copied"))))

(defun point-to-mark-range (w)
  (let* ((point (fred-buffer w))
         (mark&start (car (slot-value w 'mark-ring)))
         (mark (car mark&start)))
    (values (buffer-position point)
            (and mark (buffer-position mark)))))

(defun kill-range (w)
  (multiple-value-bind (b e) (selection-range w)
    (when (or (null e) (eq b e))
      (multiple-value-setq (b e) (point-to-mark-range w)))
    (values b e)))

(defun fred-selection-for-word-command (w forward? &optional select)
  (let* ((n  (fred-prefix-numeric-value w))
         (buf (fred-buffer w))
         (wordchars *fred-word-constituents*)
         (b (buffer-position buf))
         (e b))
    (when (and n (minusp n))(setq n (- n) forward? (not forward?)))
    (cond ((not select)
           (collapse-selection w forward?)
           (setq e (setq b (buffer-position buf))))
          (t (multiple-value-bind (bs es)
                                  (selection-range w)
               (when (eq bs es)
                 (multiple-value-setq (bs es)(buffer-word-bounds buf b))
                 (when (< bs b es)
                   (setq b bs e es n (1- n)))))))
    (let ((roman nil)) ;(if forward? (buffer-roman buf e)(buffer-roman buf 0 b))))
      (dotimes (i n)
        (declare (fixnum i))
        (if forward?
          (cond ((null (setq e (if roman 
                                 (buffer-forward-find-char buf wordchars e)
                                 (buffer-forward-not-break-char buf e))))
                 (ed-beep)
                 (setq b nil)
                 (return))
                ((setq e (if roman 
                           (buffer-forward-find-not-char buf wordchars e)
                           (buffer-forward-break-char buf e)))
                 (setq e (%i- e 1)))
                (t (setq e (buffer-size buf))))
          (cond ((null (setq b 
                             (if roman
                               (buffer-backward-find-char buf wordchars b)
                               (buffer-backward-not-break-char buf b))))
                 (ed-beep)
                 (setq e nil)
                 (return))
                ((setq b 
                       (if roman
                         (buffer-backward-find-not-char buf wordchars b)
                         (buffer-backward-break-char buf b)))
                 (setq b (%i+ b 1)))
                (t (setq b 0))))))
    (values b e forward?)))   

;Should be called ed-kill-word.
(defmethod ed-delete-word ((w fred-mixin))
  (multiple-value-bind (b e fwd) (fred-selection-for-word-command w t)
    (when b (ed-delete-with-undo w b e t (null fwd)))))

(defmethod ed-kill-forward-sexp ((w fred-mixin) &aux (buf (fred-buffer w)))
  (multiple-value-bind (b e) (selection-range w)
    (when (eq b e)
      (when (null (setq e (buffer-fwd-sexp buf b)))
        (return-from ed-kill-forward-sexp (ed-beep))))
    (ed-delete-with-undo w b e)))

(defmethod ed-kill-backward-sexp ((w fred-mixin) &aux (buf (fred-buffer w)))
  (multiple-value-bind (b e) (selection-range w)
    (when (eq b e)
      (when (null (setq b (buffer-bwd-sexp buf e)))
        (return-from ed-kill-backward-sexp (ed-beep))))
    (ed-delete-with-undo w b e t t)))

(defmethod ed-rubout-word ((w fred-mixin))
  (multiple-value-bind (b e fwd) (fred-selection-for-word-command w nil)
    (when b (ed-delete-with-undo w b e t (null fwd)))))


; selection empty or numeric arg, deselect & do words
; else if selection use it
; upcase, downcase or capitalize
(defun ed-region-or-words (w fn &optional undo-fn)
  (let ((fwd t))
    (multiple-value-bind (pos end) (selection-range w)
     (when (or (eq pos end)
               (fred-prefix-argument w))
       (multiple-value-setq (pos end fwd) (fred-selection-for-word-command w t)))
     (when (and pos end)
        (let ((buf (fred-buffer w)))
          (ed-modify-region-with-history w pos end fn undo-fn)
          (set-mark buf (if fwd end pos)))))))

; use for region ops which do not change region size
(defun ed-modify-region-with-history (w start end fn &optional undo-fn)
  (let ((buf (fred-buffer w)))
    (cond (undo-fn
           (funcall fn buf start end)
           (ed-history-add w #'ed-modify-region-with-history (list start end undo-fn fn)))
          (t (ed-history-add w start (make-undo-cons w start end))
             (funcall fn buf start end)
             (ed-history-add w start (buffer-substring buf start end) t)))
    (set-mark buf end)))


(defmethod ed-capitalize-word ((w fred-mixin))
  (ed-region-or-words w #'buffer-capitalize-region))

; upcase and downcase aren't true undos of each other but I think below is cool
; could check if region is all up or down case
(defmethod ed-upcase-word ((w fred-mixin))
  (ed-region-or-words w #'buffer-upcase-region)) ;  #'buffer-downcase-region))

(defmethod ed-downcase-word ((w fred-mixin))
  (ed-region-or-words w #'buffer-downcase-region)) ;  #'buffer-upcase-region))

(defun buffer-capitalize-region (buffer start &optional end &aux char downp)
  (setq start (buffer-position buffer start)
        end (buffer-position buffer end))
  (when (%i< end start) (psetq start end end start))
  (while (< start end)    
    (setq char (buffer-char buffer start))
    (when (if downp (upper-case-p char) (lower-case-p char))
      (buffer-char-replace buffer
                           (if downp (char-downcase char) (char-upcase char))
                           start))
    (setq downp (alpha-char-p char))
    (setq start (%i+ start 1))))

(defun buffer-downcase-region (buffer start &optional end &aux char)
  (setq start (buffer-position buffer start)
        end (buffer-position buffer end))
  (when (%i< end start) (psetq start end end start))
  (while (< start end)    
    (when (upper-case-p (setq char (buffer-char buffer start)))
      (buffer-char-replace buffer (char-downcase char) start))
    (setq start (%i+ start 1))))

(defun buffer-upcase-region (buffer start &optional end &aux char)
  (setq start (buffer-position buffer start)
        end (buffer-position buffer end))
  (when (%i< end start) (psetq start end end start))
  (while (< start end)    
    (when (lower-case-p (setq char (buffer-char buffer start)))
      (buffer-char-replace buffer (char-upcase char) start))
    (setq start (%i+ start 1))))

(defmethod ed-transpose-chars ((w fred-mixin) &optional pos)
  (let ((buf (fred-buffer w)))
    (when (not pos)(setq pos (buffer-position buf)))
    (when (or (buffer-end-p buf pos)
              (char-eolp  (buffer-char buf pos)))
      (decf pos))
    (if (and (not (<= pos 0))(not (buffer-end-p buf pos))) ;(<  pos (buffer-size buf)))
      (multiple-value-bind (bff bms) (buffer-char-font-codes buf (%i- pos 1))        
        (multiple-value-bind (aff ams) (buffer-char-font-codes buf pos)
          (buffer-set-font-codes buf aff ams (%i- pos 1) pos)
          (buffer-set-font-codes buf bff bms pos (%i+ pos 1))
          (buffer-char-replace buf
                               (buffer-char-replace buf (buffer-char buf pos) (%i- pos 1))
                               pos))
        (ed-history-add w #'ed-transpose-chars pos))
      (ed-beep))))

(defmethod ed-transpose-words ((w fred-mixin) &optional pos)
  (let ((buf (fred-buffer w)))
    (when (not pos)(setq pos (buffer-position buf)))
    (let (bpos1 bpos2 epos1 epos2 string1 style1 string2 style2)
      (setq epos2 (ed-forward-word w))
      (when epos2  ; avoid multiple beeps
        (setq bpos2 (ed-backward-word w))
        (when bpos2
          (setq bpos1 (ed-backward-word w))
          (when bpos1
            (setq epos1 (ed-forward-word w))
            (when epos1
              ;(set-mark buf pos)
              (setq string2 (buffer-substring buf bpos2 epos2))
              (setq style2 (buffer-get-style buf bpos2 epos2))
              (setq string1 (buffer-substring buf bpos1 epos1))
              (setq style1 (buffer-get-style buf bpos1 epos1))
              (buffer-delete buf bpos2 epos2)
              (ed-insert-with-style w string1 style1 bpos2)
              (if (>= pos bpos2) (set-mark buf bpos2))
              (buffer-delete buf bpos1 epos1)
              (ed-insert-with-style w string2 style2 bpos1)
              (ed-history-add w #'ed-transpose-words  (%i+ bpos1 (%i- epos2 bpos2)))))))
      (when (not (and bpos1 epos1 bpos2 epos2)) (set-mark buf pos)))))


(defmethod ed-transpose-sexps ((w fred-mixin) &optional pos)
  (let ((buf (fred-buffer w)))
    (when (not pos)(setq pos (buffer-position buf)))
    (let* ((epos2 (buffer-fwd-sexp buf pos))
           (bpos2 (buffer-bwd-sexp buf epos2 t))
           (bpos1 (buffer-bwd-sexp buf pos t))
           (epos1 (buffer-fwd-sexp buf bpos1)))
      (cond
       ((or (not  (and bpos1 epos1 bpos2 epos2))(>= bpos1 bpos2))
        (set-mark buf pos)(ed-beep))
       (t
        (let* ((string1 (make-undo-cons w bpos1 epos1))
               (string2 (make-undo-cons w bpos2 epos2)))
          (ed-delete-with-history w bpos2 epos2)
          (ed-insert-with-undo w string1 bpos2 t)
          (if (>= pos bpos2) (set-mark buf bpos2))
          (ed-delete-with-history w bpos1 epos1 t)
          (ed-insert-with-undo w string2 bpos1 t)))))))

(defmethod ed-yank ((w fred-mixin) &aux insertion-cons start kill)
  (when *killed-strings*
    (setq insertion-cons (first-killed-string))
    (setq kill (ed-kill-selection w))
    (setq start (buffer-position (fred-buffer w)))
    (let ((len 0))
      (when insertion-cons
        (cond ((and (consp insertion-cons)
                    (consp (car insertion-cons)))
               (let ((b start))
                 (dolist (e insertion-cons)
                   (ed-insert-with-undo w e b kill)
                   (setq kill t)
                   (let ((le (length (car e))))
                     (setq b (+ b le))
                     (setq len (+ len le))))))
              (t (ed-insert-with-undo w insertion-cons start kill)
                 (setq len (length (car insertion-cons))))))
      (set-fred-undo-stuff
       w
       (list 'ed-yank-pop
             start
             (+ start len))
       "Yank")
      (let ((pos (buffer-position (fred-buffer w))))
        (window-show-range w start pos)
        (setq *show-cursor-p* nil)
        (unless (eql pos start)
          (ed-push-mark w start)
          (set-mini-buffer w "~&Mark set"))))))



#|
; if pos not visible, move such that pos is visible near screen bottom (not top)
(defun window-scroll-to-bottom (w &optional (pos (buffer-position (fred-buffer w))))  
  (let* ((frec (frec w))
         (point (frec-pos-point frec pos)))
    (when (not point)
      (set-mark (fred-display-start-mark w)
                (buffer-line-start (fr.cursor frec) pos (- 2 (frec-full-lines frec)))))))
|#

; only called upon forward motion - so doesn't check for off the top
; make pos visible near bottom of screen
(defun window-scroll-to-bottom (w &optional pos)
  (let* ((frec (frec w))
         (start (fred-display-start-mark w))         
         (buf (fred-buffer w)))
    (without-interrupts
     (with-focused-view w
       (with-text-colors w
         (frec-update frec t)  ; may not need this now - else frec-pos-visible-p isnt reliable
         (let ((lines (frec-full-lines frec)))
           (unless pos (setq pos (buffer-position buf)))
           (unless (frec-pos-visible-p frec pos)
             (when (> pos (buffer-line-start start start lines))
               (set-mark start
                         (buffer-line-start buf pos (- 2 lines)))
               (fred-update w)))))))))

(defun line-count-between (buf from to)
  (when (typep from 'buffer-mark)(setq from (buffer-position from)))
  (when (typep to 'buffer-mark)(setq to (buffer-position to))) 
  (when (> from to)(psetq to from from to))
  (let ((n -1)(size (buffer-size buf)))
    (block nil ; snarl
      (while (%i< from  to)
        (setq n (%i+ n 1))
        (setq from (%i+ 1 (buffer-line-end buf from)))
        (when (%i>= from size) (return))))
    n))


(defmethod ed-back-to-indentation ((w fred-mixin))
  (let* ((buf (fred-buffer w))
         (pos (buffer-position buf))
         (b (buffer-line-start buf pos))
         (e (buffer-line-end buf pos)))
    (collapse-selection w :dont)    
    (setq pos (when b (buffer-forward-find-not-char buf wsp b e)))
    (if pos (set-mark buf (%i- pos 1))(ed-beep))))

         
#|    
; m-y
(defmethod ed-yank-pop ((w fred-mixin) &aux  insert-cons first-p
                                            (buf (fred-buffer w)))
  "Does an EMACs style rotating yank."
  (declare (special *last-command*))
  (if (and (consp *last-command*)
           (eq (car *last-command*) 'ed-yank-pop))
    (progn
     (setq start (cadr *last-command*)
           end (caddr *last-command*)
           *last-command* nil)
     (ed-delete-with-history w start end) ; undoable - not on killed-strings
     (rotate-killed-strings))
    (progn
        (setq first-p t)
        ))
  ; we don't get the yank and deletion merged
  (ed-yank w))
|#


(defmethod ed-yank-pop ((w fred-mixin) &aux start end insert-cons first-p
                        (buf (fred-buffer w)))
  "Does an EMACs style rotating yank."
  (declare (special *last-command*))
  (if (and (consp *last-command*)
           (eq (car *last-command*) 'ed-yank-pop))
    (setq start (cadr *last-command*)
          end (caddr *last-command*)
          *last-command* nil)
    (progn
      (setq first-p t)
      (multiple-value-setq (start end) (selection-range w))))
  (if first-p
    (progn
      (setq insert-cons (first-killed-string))
      (unless (eq start end)
        (ed-delete-with-undo w start end nil)))
    (progn
      (rotate-killed-strings)
      (setq insert-cons (first-killed-string))
      (ed-delete-with-history w start end)))
  (let ((len 0))
    (when insert-cons
      (cond ((and (consp insert-cons)
                  (consp (car insert-cons)))
             (let ((b start))
               (dolist (e insert-cons)
                 (ed-insert-with-undo w e b t)               
                 (let ((le (length (car e))))
                   (setq b (+ b le))
                   (setq len (+ len le))))))
            (t (ed-insert-with-undo w insert-cons start t)
               (setq len (length (car insert-cons))))))
    (let ((pos (buffer-position buf)))
      (window-show-range w start pos)
      (setq *show-cursor-p* nil)
      (unless (eql pos start)
        (ed-push-mark w start)
        (set-mini-buffer w "~&Mark set")))
    (set-fred-undo-stuff w
                         (list 'ed-yank-pop
                               start
                               (%i+ start len))
                         "Yank")))


;c-return
(defmethod ed-newline-and-indent ((w fred-mixin) &aux (buf (fred-buffer w)))
  (let ((flg (or (ed-kill-selection w)(eq *last-command* :self-insert))))
    (ed-insert-with-undo w (or *preferred-eol-character* #\return) (buffer-position buf) flg)
    (set-fred-last-command w :append) ; a message for indent-for-lisp
    (ed-indent-for-lisp w)
    (set-fred-last-command w :self-insert)))


(defmethod ed-next-screen ((w fred-mixin) &optional select)
  (let* ((frec (frec w))
         (height (frec-full-lines frec))
         (context (next-screen-context-lines height))
         (wpos (fred-display-start-mark w))
         (newpos (frec-screen-line-start frec wpos (- height context))))
    ; this is weird because the selected stuff disappears from view
    (if select
      (frec-extend-selection frec newpos)
      (collapse-selection w t))
    (set-mark (fred-buffer w) (set-mark wpos newpos))))

(Defmethod ed-select-next-screen ((w fred-mixin))
  (ed-next-screen w t))

(defmethod ed-previous-screen ((w fred-mixin) &optional select)
  (let* ((frec (frec w))
         (wpos (fred-display-start-mark w))
         (newpos (find-frec-prev-page frec wpos))
         (height (frec-full-lines frec))
         (context (next-screen-context-lines height)))
    (unless (eq 0 newpos)
      (setq newpos (frec-screen-line-start frec newpos context)))
    (if select 
      (frec-extend-selection frec newpos)
      (collapse-selection w nil))
    (set-mark (fred-buffer w)
              (set-mark wpos newpos))))

(defmethod ed-select-previous-screen ((w fred-mixin))
  (ed-previous-screen w t))


(defun buffer-column (buffer &optional pos)
  (- (buffer-position buffer pos) (buffer-line-start buffer pos)))




(defun lines-in-buffer (buf)
  (let ((count (buffer-count-eol buf 0 t))
        (size (buffer-size buf)))
    (if (or (eql 0 size) (char-eolp (buffer-char buf (%i- size 1))))
	count (%i+ count 1))))


#|
(defun buffer-line (buf &optional (position buf))
  (buffer-count-char buf #\newline 0 position))
|#


(defun buffer-count-eol (mark &optional start (end t))
  (multiple-value-setq (start end)(buffer-range mark end start))
  (locally (declare (fixnum start end))
    (let* ((n 0)
           (pos start))
      (declare (fixnum n))
      (while 
        (setq pos (buffer-forward-find-eol mark  pos end))
        (setq n (1+ n)))
      n)))


(defun buffer-line (buf &optional (position buf))
  (buffer-count-eol buf 0 position))


;This is braindamaged, who's gonna think to look in the listener to see the
; output of an editor command?
;It should put something in the window's minibuffer instead.
(defmethod ed-what-cursor-position ((w fred-mixin) &aux
                                    (buf (fred-buffer w)))
  (if (= (buffer-position buf) (buffer-size buf))
    (format t "~&At end of buffer.")
    (let ((char (buffer-char buf)))
      (format t "~&Char: ~@C with char code: ~D." char (char-code char))))
  (format t "~&Column: ~S Line: ~S" (buffer-column buf)
          (buffer-count-eol buf 0 buf))
  (let ((str "~&Char position: ~S")
        (pos (buffer-position buf)))
    (format t str pos)
    (set-mini-buffer w str pos))
  (format t "~&Buffer chars: ~S  Buffer lines: ~S"
          (buffer-size buf)
          (lines-in-buffer buf)))
; m-\
(defmethod ed-delete-horizontal-whitespace ((w fred-mixin))
  (let ((buf (fred-buffer w)))
    (multiple-value-bind (b e) (selection-range w)
      (when (/= b e)
        (setq b (buffer-position buf))
        (set-selection-range w b b))
      (let ((one (ed-delete-forward-whitespace-1 w t)))
        (ed-delete-with-history w (1+ (or (buffer-backward-find-not-char buf wsp)
                                          -1)) 
                                b one)))))
  
; c-x c-space
(defmethod ed-delete-forward-whitespace ((w fred-mixin))
  (ed-delete-forward-whitespace-1 w))

(defun ed-delete-forward-whitespace-1 (w &optional horiz)
  (let ((buffer (fred-buffer w)))
    (multiple-value-bind (b e) (selection-range w)
      (when (/= b e)        
        (setq b (buffer-position buffer))
        (set-selection-range w b b))
      (ed-delete-with-history w b (or (buffer-not-char-pos buffer (if horiz wsp wsp&cr)
                                                           :start b)
                                      (buffer-size buffer))))))

(defun buffer-not-char-pos (buf char-or-string &key start end from-end &aux pos)
  (setq start (buffer-position buf (or start (if from-end 0)))
        end (buffer-position buf (or end (if (not from-end) t))))
     (cond ((> start end) (error "start > end: ~S ~S" start end))
         (from-end ;search backwards
          (buffer-backward-find-not-char buf char-or-string start end))
         (t ;search forward
           (setq pos (buffer-forward-find-not-char buf char-or-string 
                                                   start end))
           (if pos 
               (- pos 1)))))

(defmethod ed-delimit-selection ((w fred-mixin)
                                 start-delim
                                 stop-delim)  
  (multiple-value-bind (sel-start sel-end) (selection-range w)
    (cond ((eq sel-start sel-end)
           (ed-insert-char w start-delim)
           (ed-insert-char w stop-delim))
          (t (let* ((lc *last-command*)
                    (font (when (and (consp lc)(eq (car lc) 'set-font))
                            (add-buffer-font (fred-buffer w) (cadr lc) (caddr lc)))))
               (ed-insert-with-undo w stop-delim sel-end nil font)
               (ed-insert-with-undo w start-delim sel-start t font))))))

(defmethod ed-insert-sharp-comment ((w fred-mixin))
  (ed-delimit-selection w "#|
" "
|#")
  (move-mark (fred-buffer w) -3))

(defmethod ed-insert-double-quotes ((w fred-mixin) &aux 
                                    (buf (fred-buffer w)))
  (ed-delimit-selection w "\"" "\"")
  (move-mark buf -1))

(defmethod ed-insert-parens ((w fred-mixin) &aux (buf (fred-buffer w)))
  (ed-delimit-selection w "(" ")")
  (move-mark buf -1))

; m-)
(defmethod ed-move-over-close-and-reindent ((w fred-mixin) &aux
                                            pos (buf (fred-buffer w)))
  (let ((kill (ed-kill-selection w)))
    (when (setq pos (buffer-fwd-up-sexp buf))
      (set-mark buf pos)
      (when (> pos 0)
        (let* ((start (1+ (or (buffer-backward-find-not-char
                               buf wsp&cr (1- pos) 0)
                              -1))))
          (unless (eq start (1- pos))
            (ed-delete-with-history w start (1- pos) kill)
            (setq kill t))))
      (ed-insert-with-undo w (or *preferred-eol-character* #\return) (buffer-position buf) kill)
      (set-fred-last-command w :append)
      (ed-indent-for-lisp w)      
      (when kill (set-fred-last-command w nil))
      )))

(defun buffer-find-comment (buf &optional pos &aux eol)
  (setq eol (buffer-line-end buf pos)
        pos (buffer-line-start buf pos))
  (while (and pos (setq pos (buffer-fwd-skip-delimited buf "\\\";" pos eol)))
    (when (eq (buffer-char buf (%i- pos 1)) #\;)
      (return-from buffer-find-comment (%i- pos 1)))
    (setq pos (buffer-fwd-skip-delimited buf "\\\"" pos eol))))

(defun buffer-bwd-skip-wsp (buf pos)
  (while (and (not (eql 0 pos))
              (%str-member (buffer-char buf (1- pos)) wsp)
              (not (buffer-lquoted-p buf (%i- pos 1))))
    (setq pos (%i- pos 1)))
  pos)

;Comments will be indented to at least comment-column.  Can be shadowed
;per-window via c-x ;
;comment-start is the string to insert to start a new comment

(defmethod ed-indent-comment ((w fred-mixin) &aux (buf (fred-buffer w)))
  "Indents all comments in selection.
   If no selection, inserts a new comment if there isn't one already"
  (let (any)
    (multiple-value-bind (b e) (selection-range w)
      (collapse-selection w t)
      (if (< b (setq e (buffer-line-start buf e)))
        (let* (cpos col pos)
          (while (<= b e)
            (when (setq cpos (buffer-find-comment buf b))
              (setq col (+ (buffer-line-start buf b) 
                           (slot-value w 'comment-column))
                    pos (buffer-bwd-skip-wsp buf cpos))
              (when (>= pos col) (setq col (+ pos 4)))
              (set-mark buf pos)
              (when (neq pos cpos)
                (ed-delete-with-history w cpos pos any)
                (setq any t))
              (when (neq col pos)
                (ed-insert-with-undo w (make-string (- col pos) :element-type 'base-character :initial-element #\space) pos any)
                (setq any t)))
            (setq b (buffer-line-start buf b 1)))
          (when pos (move-mark buf 1)))
        (let* ((cpos (buffer-find-comment buf))
               (end (or cpos (buffer-line-end buf)))
               (line-start (buffer-line-start buf))
               (col (+ line-start (slot-value w 'comment-column)))
               (pos (buffer-bwd-skip-wsp buf end)))
          (when (> (+ pos 3) col)
            (setq col (+ line-start (* 8 (ceiling (- (+ pos 3) line-start) 8)))))
          (set-mark buf pos)
          (setq any (ed-delete-with-history w pos end))
          (when (neq col pos)
            (ed-insert-with-undo w (make-string (- col pos) :element-type 'base-character :initial-element #\space) pos any)
            (setq any t))
          (let ((comment-start (slot-value w 'comment-start)))
            (if cpos
              (move-mark buf
                         (if (buffer-substring-p buf comment-start)
                           (length comment-start)
                           1))
              (progn 
                (ed-insert-with-undo w comment-start col any)
                (set-fred-last-command w :self-insert)))))))))


(defmethod ed-kill-comment ((w fred-mixin) &aux (buf (fred-buffer w)))
  (collapse-selection w t)           ; not really right...
  (let ((*last-command* nil)
        (comment (buffer-find-comment buf)))
    (when comment
      (ed-delete-with-undo
       w
       (buffer-bwd-skip-wsp buf comment)
       (buffer-line-end buf)))))

(defmethod ed-set-comment-column ((w fred-mixin) &aux (buf (fred-buffer w)))
  (setf (slot-value w 'comment-column)
        (- (buffer-position buf) (buffer-line-start buf)))
  (set-mini-buffer w "~&comment-column = ~D" (slot-value w 'comment-column)))

;;;; stuff for the open-selected-file menu item

(defmethod open-file-item-title ((w fred-mixin) last-sel-string &aux
                                 (buf (fred-buffer w)))
  (multiple-value-bind (b e) (selection-range w)
    (when (and (neq b e)
               (< (- e b) 300)
               (not (buffer-forward-find-eol buf b e)))
      (let ((len (min (- e b) 21)))
        (unless (and last-sel-string
                     (eq (length last-sel-string) len)
                     (buffer-substring-p buf last-sel-string b))
          (setq last-sel-string (buffer-substring buf b (+ b len)))
          (when (eq len 21)
            (set-schar last-sel-string 20 #\É)))
        last-sel-string))))

(defmethod open-file-item-file ((w fred-mixin) &aux (buf (fred-buffer w)))
  (multiple-value-bind (b e) (selection-range w)
    (and (neq b e)
         (< (- e b) 300)
         (not (buffer-forward-find-eol buf b e))
         (buffer-substring buf b e))))

;;;;;  Stuff for search dialog

(defmethod window-search ((w fred-mixin) string &optional reverse-p silent-p)
  (let ((frec (frec w))
        (c (fred-buffer w))
        pos)
    (multiple-value-bind (b e) (frec-get-sel frec)
      (unless (eq (setq pos b) e)
        (setq pos (if reverse-p (%i- e 1) (%i+ b 1)))))
    (if (setq pos (if reverse-p
                    (buffer-backward-search c string pos)
                    (buffer-forward-search c string pos)))
      (progn
        (setf (fr.frame-sel-p (frec w)) nil)
        (set-selection-range w (if reverse-p (%i+ pos (length string))
                                   (%i- pos (length string))) pos)
        (window-show-selection w)
        t)
      (progn
        (set-fred-last-command w nil)
        (unless silent-p
          (ed-beep)
          nil)))))

; Original
; if beginning and end of selection are visible, do nothing
; else make sure beginning is visible. Used by search.
(defmethod window-show-selection ((w fred-mixin) &aux 
                                  (frec (frec w))
                                  c)
  "slightly different from window-object-show-cursor, but two could be folded"
  (with-focused-view w
    (without-interrupts
     (multiple-value-bind (b e) (selection-range w)
       (setq c (min b e))
       ; this is bogus - below really wants a frec-update 
       (unless (and (frec-pos-visible-p frec b)
                    (frec-pos-visible-p frec e))
         (set-mark (fred-display-start-mark w)                  
                   (frec-screen-line-start 
                    frec c
                    (- (next-screen-context-lines (frec-full-lines frec))))))
       (window-show-cursor w c)))))

; if start and end are visible do nothing
; else make sure end is visible very near the bottom
; Used by paste and yank 

(defmethod window-show-range ((w fred-mixin) start end &aux (frec (frec w)))
  (without-interrupts
   (with-focused-view w
     (with-text-colors w ; makes paste work - yank already worked cause view-key-event-handler did it
       (frec-update frec)  ; << nuke - no put back but DO draw
       (let ()
         (unless (and (frec-pos-visible-p frec start)  ; else he will update with no draw
                      (frec-pos-visible-p frec (frec-screen-line-start frec end)))
           (setq start (min (find-frec-prev-page frec end t)(buffer-size (fred-buffer w))))
           (set-mark (fred-display-start-mark w) start))
         (fred-update w))))))
    


#|
(defmethod window-show-selection ((w fred-mixin) &aux 
                                  (frec (frec w))
                                  c)
  "slightly different from window-object-show-cursor, but two could be folded"
  (multiple-value-bind (b e) (selection-range w)
    (frec-update frec t)
    (unless (and (frec-pos-visible-p frec b)
                 (frec-pos-visible-p frec e))
      (without-interrupts
       (setq c (min b e))
       (window-show-cursor w c)))))
|#

(defmethod window-top ((w fred-mixin))
  (ed-beginning-of-buffer w)
  (fred-update w))

(defmethod window-replace ((w fred-mixin) text)
  (when (window-buffer-read-only-p w)
    (if (null (buffer-whine-read-only w))
      (return-from window-replace)))
  (multiple-value-bind (b e) (selection-range w)
    (ed-replace-with-undo w b e text)
    (window-show-cursor w)))

(defmethod window-replace-all ((w fred-mixin) search-text replace-text &optional start)
  (when (window-buffer-read-only-p w)
    (if (null (buffer-whine-read-only w))
      (return-from window-replace-all)))
  (let* ((search-text-length (length search-text))
         (next 0)
         (buf (fred-buffer w)))
    (when start (set-mark buf start))
    (setq next (buffer-forward-search buf search-text))
    (do ((count 0 (+ count 1)))
        ((not next)
         (set-mini-buffer w "~&~a replacements." count)
         (fred-update w))
      (set-mark buf (setq start (- next search-text-length)))
      (ed-replace-with-undo w start next replace-text (> count 0))
      (setq next (buffer-forward-search buf search-text)))))

(defmethod reparse-modeline ((w fred-mixin) &optional no-create)
  (let* ((buffer (fred-buffer w))
         (package (or (buffer-modeline-package buffer no-create)
                      (buffer-first-in-package buffer no-create))))
    (if (eq package t)(setq package nil))
    (if no-create
      (when package (set-window-package w (if (packagep package) package (list package))))
      (progn
        (unless (or #|(null package)|# (eq package (sneaky-window-package w)))
          (set-window-package w package)
          (mini-buffer-update w))
        (buffer-remove-unused-fonts (fred-buffer w))))
    package))

(defmethod add-modeline ((w fred-mixin))
  (flet ((package-string (w) 
           (format nil "~a" (package-name (or (window-package w) *package*)))))
    (let ((buf (fred-buffer w)))
      (let ((start (buffer-modeline-range buf)))
        (if start
          (multiple-value-bind (s e) (buffer-modeline-attribute-range buf 'package)
            (if s
              (set-selection-range w s e)
              (progn
                (set-mark buf start)
                (buffer-insert buf " Package: ")
                (buffer-insert buf (package-string w))
                (buffer-insert buf ";")
                (unless (%str-member (buffer-char buf) wsp)
                  (buffer-insert buf #\space))
                (add-modeline w))))
          (progn
            (set-mark buf 0)
            (buffer-insert buf ";;;-*- Mode: Lisp; Package: ")
            (buffer-insert buf (package-string w))
            (buffer-insert buf " -*-")
            (buffer-insert buf (or *preferred-eol-character* #\return))
            (add-modeline w)))))))

(defmethod ed-universal-argument ((w fred-mixin) &aux arg)
  (declare (special *prefix-command-p*))
  (when (null (setq arg (fred-prefix-argument w)))
    (setf (fred-prefix-argument w) (setq arg (list 1))))
  (cond ((listp arg)
         (let ((val (car arg)))
           (rplaca arg (* 4 val))
           (let ((mini-buffer (view-mini-buffer w)))
             (terpri mini-buffer)
             (until (eql val 0)
               (format-keystroke *current-keystroke* mini-buffer)
               (princ " " mini-buffer)
               (setq val (ash val -2))))))
        (t (when (eq arg 'minus)(setq arg -1))
           (setf (fred-prefix-argument w) (setq arg (* 4 arg)))
           (set-mini-buffer w "~&M-~D " arg)))
  (setq *prefix-command-p* t))


(defmethod ed-numeric-argument ((w fred-mixin) &aux arg)
  (declare (special *prefix-command-p*))
  (let* ((val (or (digit-char-p
                   (code-char (logand *current-keystroke* #xFF))) 'minus)))
    (cond ((listp (setq arg (fred-prefix-argument w)))  ; null or cons...
           (setf (fred-prefix-argument w) val))
          ((eq val 'minus) ; i.e. minus in the middle
           (ed-beep))
          ((eq arg 'minus)
           (setf (fred-prefix-argument w)(setq val (- val))))
          (t (when (minusp arg)(setq val (- val)))
             (setf (fred-prefix-argument w)
                 (setq val (+ (* 10 arg) val)))))
    (if (numberp val)(set-mini-buffer w "~&M-~D " val)(set-mini-buffer w "~&M--"))
    (setq *prefix-command-p* t)))

(defmethod ed-push/pop-mark-ring ((w fred-mixin))
  "Without a prefix argument, push caret position onto mark ring.
With an argument pop top of ring into caret"
  (if (fred-prefix-argument w)
    (let* ((ring (slot-value w 'mark-ring))
           (mark&start (car ring))
           (mark (car mark&start)))
      (if (null mark)
        (ed-beep)
        (progn 
          (setf (slot-value w 'mark-ring) (nconc (cdr ring) (rplacd ring nil)))
          (collapse-selection w t)
          (set-mark (fred-buffer w) mark) 
          (let* ((frec (frec w))
                 (pos (buffer-position mark))
                 (start  (cdr mark&start)))              
            (when (not (frec-pos-point frec pos)) ; on screen? is this reliable?
              ; ok unless line size grew or buffer shrank
              ; punt in those cases
              (when start ; its lines from top today
                (set-mark (fred-display-start-mark w) 
                          (buffer-line-start (fred-buffer w) pos (- start))) 
                (fred-update w)))))))
    (progn
      (ed-push-mark w (fred-buffer w) t)
      (set-mini-buffer w "~&Mark set"))))

; #\escape
(defmethod ed-collapse-selection ((w fred-mixin))
  (collapse-selection w :dont))

(defmethod ed-push-mark ((w fred-mixin) &optional pos backward-p &aux ring)
  (let ((mark (fred-buffer w)))
    (setf (slot-value w 'mark-ring)
          (setq ring (cons (cons (make-mark mark pos backward-p)
                                 (line-count-between mark (fred-display-start-mark w) mark))
                           (slot-value w 'mark-ring))))
    (when (> (length ring) *mark-ring-length*)
      (setf (nthcdr *mark-ring-length* ring) nil))))

(defmethod ed-exchange-point-and-mark ((w fred-mixin))
  "Exchange point and top mark.  With argument, select the range as well"
  (let* ((mark&start (car (slot-value w 'mark-ring)))
         (mark (car mark&start)))
    (if (null mark)
      (ed-beep)
      (let ((mark-pos (buffer-position mark))
            (buffer-mark (fred-buffer w)))
        (set-mark mark buffer-mark)
        (set-mark buffer-mark mark-pos)
        (if (fred-prefix-argument w)
          (set-selection-range w mark)    
          (set-selection-range w buffer-mark))
        mark-pos))))

(defmethod ed-right-margin ((w fred-mixin))
  (or (view-get w :right-margin)
      (- (point-h (view-size w)) 36)))   ; 1/2 inch (on many monitors)

#| ; Defined in simple-db.lisp
; Repeatedly calls PREDICATE with four values:
;     guess, start, end, tag
; Predicate should either throw a result to TAG or
; return two values: the values of START & END for next time.
(defun binary-search (start end predicate &aux guess)
  (let ((tag (list nil)))
    (declare (dynamic-extent tag))
    (catch tag
      (loop    
        (unless (<= start end) (return nil))
        (setq guess (floor (+ start end) 2))
        (multiple-value-setq (start end) (funcall predicate guess start end tag))))))
|#

(defun ed-fill-region (w &optional preserve-newlines)
  (setq w (require-type w 'fred-mixin))
  (multiple-value-bind (b e) (kill-range w)
    (if (> b e)
      (psetq b e e b))
    (let* ((buf (fred-buffer w))
           (m (make-mark buf b))
           (em (make-mark buf e))
           ; (left (or (view-get w :left-margin) 0))
           (right (ed-right-margin w))
           p mp ep)
      (set-mark m (if (setq p (buffer-backward-find-eol m))
                    (1+ p) 0))
      (set-mark em (or (buffer-forward-find-eol em) t))
      (unless preserve-newlines
        ; replace <CR><Whitespace> with a single space
        (let ((end (buffer-position em))
              (m (make-mark m)))
          (loop
            (setq p (buffer-forward-find-eol m))
            (when (or (null p) (>= p end)) (return))
            (if (char-eolp (buffer-char m p))
              (set-mark m (1+ p))
              (progn 
                (buffer-char-replace m #\space (1- p))
                (set-mark m p)
                (setq p (buffer-forward-find-not-char m wsp))
                (when p
                  (buffer-delete m (1- p))))))))
      (loop
        (setq ep (buffer-position em)
              mp (buffer-position m))
        (when (>= mp ep) (return))
        (setq p (or (buffer-forward-find-eol m) ep))
        (set-mark m p)
        (flet ((pred (pos start end tag)
;                 (format t "~&start: ~d, pos: ~d, end: ~d~%" start pos end)
                 (let* ((width (buffer-string-width m mp pos))
                        (dif (- right width)))
                   (if (< dif 0)
                     (values start (1- pos))
                     (if (or (eq start end)
                             (and (< (1+ pos) ep)
                                  (> (buffer-string-width m pos (1+ pos)) dif)))
                       (throw tag pos)
                       (values (1+ pos) end))))))
          (declare (dynamic-extent #'pred))
          (when (and (setq p (binary-search mp p #'pred))
                     (not (eql p (buffer-position m))))
            (set-mark m p)
            (setq p (buffer-backward-find-char m wsp mp m))
            (if p
              (progn
                (set-mark m (1+ p))
                (setq p (buffer-backward-find-not-char m wsp mp m))
                (setq p (if p (1+ p) mp))
                (buffer-delete m p))
              (progn
                (setq p (buffer-forward-find-char m wsp m ep))
                (unless p (return))
                (set-mark m (1- p))
                (setq p (buffer-forward-find-not-char m wsp m ep))
                (setq p (if p (1- p) ep))
                (buffer-delete m p)))
            (buffer-insert m (or *preferred-eol-character* #\return))))))))

(defvar *fred-auto-set-keyscript* t)

(defmethod ed-toggle-auto-keyscript ((w fred-mixin))
  (setq *fred-auto-set-keyscript* (null *fred-auto-set-keyscript*)))

(defmethod ed-reset-font ((w fred-mixin))
  (let ((mark (fred-buffer w)))
    (multiple-value-bind (ff ms)(buffer-empty-font-codes mark)
      (ed-set-view-font w (font-spec ff ms)))))

        

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/2/95	akh	minor change to window-show-selection - didnt help much
	4	1/5/95	akh	non-roman script word breaks
  5   1/6/95   akh   window-show-selection - revert to original
|# ;(do not edit past this line!!)
