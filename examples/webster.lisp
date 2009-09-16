;-*- Mode: Lisp; Package: CCL -*-
; webster.lisp
; Define c-X $ to look up the definition of a word
; Copyright 1995-1996 Digitool, Inc.

#| PLEASE NOTE: As of 1996, the mintaka.lcs.mit.edu server specified below is no longer accepting
Webster connections, and we do not know of any others that do. If you find one, please let us know.
|#

; Change History
;
; 10/09/96 slh  note about mintaka server
; 11/22/91 bill Again: New get-string-from-user arglist.
; 08/23/90 bill fred-start-mark -> fred-display-start-mark
; 07/31/90 bill  New get-string-from-user arglist.
; 07/05/90 bill wptr-if-bound -> wptr
; 05/08/90 gz Released

(in-package "CCL")

(require "MACTCP")

(declaim (ftype (function (&rest t) t) ccl::telnet-read-line)
         (ftype (function (&rest t) t) ccl::telnet-write-line)
         (ftype (function (&rest t) t) ccl::open-tcp-stream)
         (ftype (function (&rest t) t) ccl::tcp-connection-state))

(defvar *webster-stream* nil)

(defun webster-stream ()
  (unless (and *webster-stream* (eql (tcp-connection-state *webster-stream*) 8))   ; established
    (webster-close)
    (setq *webster-stream* (open-tcp-stream "mintaka.lcs.mit.edu" 103)))
  *webster-stream*)

(defun webster-close ()
  (when *webster-stream*
    (close *webster-stream*)
    (setq *webster-stream* nil)))

(defmethod ed-define-word ((w fred-mixin) &optional word &aux (buffer (fred-buffer w)))
  ;Maybe when have a selection, should split it into a list of words,
  ;and do them all.  The problem is that then there would be no way to define
  ;a multi-word phrase.
  (let* ((word (or word
                   (multiple-value-bind (b e) (selection-range w)
                     (block nil
                       (when (eq b e)
                         (multiple-value-setq (b e) (buffer-word-bounds buffer))
                         (when (eq b e)
                           (return (get-string-from-user "Word to define:"))))
                       (buffer-substring buffer b e)))))
         (stream (webster-stream)))
    (telnet-write-line stream "DEFINE ~A" word)
    (let ((line (telnet-read-line stream)))
      (case (char line 0)
        (#\W                            ; wild
         (if (string-equal line "WILD")
           (ed-define-word w (webster-select-word stream))
           (webster-error "No wildcard match for ~S" word)))
        (#\S                            ; spelling
         (if (string-equal line "SPELLING")
           (ed-define-word w (webster-select-word stream))
           (webster-error "No dictionary entry for ~S" word)))
        (#\D                            ; definition
         (let* ((xrefs ())
                (win (webster-window))
                (start-pos (buffer-position (fred-buffer win))))
           (dotimes (i (parse-integer line :start (1+ (position #\Space line))))
             (push (let ((line (telnet-read-line stream)))
                     (subseq line (1+ (position #\Space line)))) xrefs))
           (let (char)
             (do* ()
                  ((eql (setq char (ccl:stream-tyi stream)) #\200))
               (when (and (eql char #\CR) (eql (ccl:stream-peek stream) #\LF))
                 (ccl:stream-tyi stream))
               (ccl:stream-tyo win char)))
           (when xrefs
             (format win "~&~%See also:~%")
             (dolist (line (nreverse xrefs))
               (princ line win)
               (terpri win)))
           (set-mark (fred-buffer win)
                     (set-mark (fred-display-start-mark win) start-pos))
           (force-output win)))
        (t ;#\E                            ; error
         (webster-error "Server error: ~A" line))))))

(comtab-set-key *control-x-comtab* #\$ 'ed-define-word)

(defun webster-select-word (stream)
  (let ((matches ()))
    (do* ()
         ((eql (peek-char nil stream) #\200))
      (push (let ((line (telnet-read-line stream)))
              (subseq line (1+ (position #\Space line)))) matches))
    (read-char stream)
    (select-item-from-list (nreverse matches))))

(defun webster-error (&rest format-args)
  (declare (dynamic-extent format-args))
  (message-dialog (apply #'format nil format-args))
  (throw-cancel))

(defvar *definition-window* nil)

(defun webster-window ()
  (unless (and *definition-window*
               (wptr *definition-window*))
    (setq *definition-window*
          (make-instance 'fred-window :scratch-p t :window-title "Define word")))
  (set-mark (fred-buffer *definition-window*) t)
  (fresh-line *definition-window*)
  (ed-push-mark *definition-window* t t)
  *definition-window*)

