;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  2 6/2/97   akh  don't remember
;;  4 9/3/96   akh  
;;  (do not edit before this line!!)


; Copyright 1995-1999 Digitool, Inc.

(in-package :ccl)

; Modification History
;
; 09/27/98 akh doc-window word-wraps in case long arglists
; 04/26/96 akh   get-doc-string-file does (or (ignore-errors (probe-file "ccl:")) (startup-directory))
;                in case host "ccl" is messed up somehow.
; 08/19/96 bill get-doc-string-file avoids multiple dialogs by binding *getting-doc-string-file*.
;               Bind c-x c-d to ed-get-documentation
; ------------- MCL-PPC 3.9
; 02/08/96 bill maybe-load-help-map sets *fast-help* to NIL if it fails to
;               become a hash table by loading the help map file. This
;               stops it from attempting to load the help map file every
;               time arglist on space goes off.
; 4/06/95 slh   new from misc.lisp


;;following code is not cl, but our own environment stuff for doc strings

(defmethod ed-get-documentation ((w fred-mixin))
  (multiple-value-bind (sym endp) (ed-current-sexp w)
    (if (null endp)
      (edit-anything-dialog :documentation) ;(documentation-dialog)
      (progn
        (when (consp sym) (setq sym (car sym)))
        (if (symbolp sym)
          (show-documentation sym)      
          (ed-beep))))))

(comtab-set-key *control-x-comtab* '(:control #\d) 'ed-get-documentation)

(defclass doc-output-class (fred-window) ()
  (:default-initargs :window-title "Documentation"
    :v-pane-splitter nil
    :mini-buffer-p nil
    :h-scrollp  nil
    :scratch-p t
    :view-size #@(390 120)
    :view-position #@(3 41)))

(defvar *doc-output* nil)

(defvar *plain-doc-font* nil)
(defvar *bold-doc-font* nil)
(defvar *italic-doc-font* nil)
(defvar *doc-font* nil)
(defvar *doc-font-alist* nil)

(def-ccl-pointers doc-font-spec ()
  (let ((plain '("monaco" 9 :srcor :plain))
        (bold '("monaco" 9 :srcor :plain :bold))
        (best '("geneva" 10 :srcor :plain))
        (medium '("new york" 10 :srcor :plain))
        (last-resort '("geneva" 9 :srcor :plain))
        use)
    (setq use
          (if (real-font best) best
              (if (real-font medium) medium
                  last-resort)))
    (flet ((font-codes-list (spec)
              (multiple-value-bind (ff ms) (font-codes spec)
                (list ff ms))))
      (setq *plain-doc-font* (font-codes-list plain)
            *bold-doc-font* (font-codes-list bold)
            *doc-font* (font-codes-list use)
            *italic-doc-font* (font-codes-list (append use '(:italic)))
            *doc-font-alist* `((#\p . ,*plain-doc-font*)
                               (#\b . ,*bold-doc-font*)
                               (#\d . ,*doc-font*)
                               (#\i . ,*italic-doc-font*))
            %doc-string-file nil
            *fast-help* (and *fast-help* t)))))

(defmethod window-close :before ((w doc-output-class)) 
  (setq *doc-output* nil))

(defun begin-doc-output (&optional where)
  (let ((w (or where
               *doc-output*
               (setq *doc-output* (make-instance 'doc-output-class
                                    :view-size #@(390 120)
                                    :view-position '(:top 75)
                                    :word-wrap-p t
                                    )))))
    (if (typep w 'window)(window-select w))
    (if (typep w 'fred-window) (setq w (current-key-handler w)))
    (view-put w  :right-margin (- (point-h (view-size w)) 10))
    (set-selection-range w nil nil)
    (set-mark (fred-buffer w) t)    
    (stream-fresh-line w)
    (set-mark (fred-display-start-mark w) t)
    w))

#+ignore
(defun documentation-p (symbol)
  (or (gethash symbol %documentation)
      (get-help-file-entry symbol #'read-to-double-newline t)
      (nth-value 2 (trap-args-and-return symbol))))


;; from Gary Warren King
(defun documentation-p (symbol)
  (or (gethash symbol %documentation)
      (get-help-file-entry symbol #'read-to-double-newline t)
      (nth-value 2 (trap-args-and-return symbol))
      (and (typep (fboundp symbol) 'generic-function)
           (documentation (fboundp symbol)))
      (and (find-class symbol nil)
           (lookup-documentation (find-class symbol nil) nil))))


; use buffer-set-font-codes because set-view-font-codes for
; fred-dialog-item sets font for whole buffer

(defun show-documentation (symbol &optional where &aux doc)
  "prints the doc-string to the documentation window.
 called by ed-get-documentation [through keyboard or menu]."
  (if (not (symbolp symbol))
    (ed-beep)
    (unless (or (show-help-file-documentation symbol where)
                (show-trap-documentation symbol where))
      (let* ((doc-out (begin-doc-output where))
             (buf (fred-buffer doc-out)))
        (flet ((set-font (font) (apply 'set-view-font-codes doc-out font)))
          (declare (inline set-font))          
          (set-font *bold-doc-font*)
          (format doc-out "~S" symbol)
          (set-font *doc-font*)
          (multiple-value-bind (arglist arglist-p) (arglist symbol)
            (when arglist-p
              (cond ((null arglist) (format doc-out " ()"))
                    (t (let ((italic? nil))
                         (dolist (arg arglist)
                           (if (memq arg lambda-list-keywords)
                             (progn
                               (set-font *doc-font*)
                               (when italic?
                                 (tyo #\space doc-out)
                                 (setq italic? nil)))
                             (progn
                               (set-font *italic-doc-font*)
                               (setq italic? t)))
                           (let ((*print-case* :downcase))
                             (format doc-out " ~a" arg))))))))
          (set-font *doc-font*)
          (terpri doc-out)
          (setq doc (gethash symbol %documentation))
          (let* ((gf (fboundp symbol))
                 (gf-doc (and (typep gf 'generic-function) (documentation gf))))
            (when gf-doc (push (cons 'generic-function gf-doc) doc)))
          (let* ((class (find-class symbol nil))
                 (class-doc (and class (lookup-documentation class nil))))
            (when class-doc
              (push (cons 'type class-doc) doc)))
          (if doc
            (dolist (one-more doc)
              (buffer-insert buf #\[)
              (set-font *italic-doc-font*)
              (format doc-out "~(~A~)"
                      (let ((type (car one-more)))
                        (if (eq type 'function)
                          (cond ((macro-function symbol) 'macro)
                                ((special-form-p symbol) "special form")
                                (t type))
                          type)))
              (set-font *doc-font*)
              (format doc-out "]~%~A~%" (cdr one-more)))
            (format doc-out "No documentation available.~%"))
          (force-output doc-out)
          (values))))))

(defun show-trap-documentation (symbol where)
  "If the symbol is a trap defined by deftrap, show the arglist with types."
  (multiple-value-bind (args returns foundp) (trap-args-and-return symbol)
    (when foundp
      (let* ((doc-out (begin-doc-output where))
             (*package* :traps)
             (buf (fred-buffer doc-out))
             (right-margin (ed-right-margin doc-out)))
        (flet ((set-font (font) (apply 'set-view-font-codes doc-out font)))
          (declare (inline set-font))          
            (set-font *bold-doc-font*)
            (format doc-out "~a" symbol)
            (set-font *doc-font*)
            (dolist (arg args)
              (format doc-out " (~a ~s)" 
                      (string-downcase (car arg)) (cdr arg))
              (when (> (fred-hpos doc-out) right-margin)
                (ed-backward-sexp doc-out)
                (ed-insert-char doc-out #\newline)
                (ed-end-of-line doc-out)))
           (format doc-out "~%[")
           (set-font *italic-doc-font*)
           (buffer-insert buf "trap ")
           (set-font *doc-font*)
           (buffer-insert buf #\])
            (format doc-out "~%Returns: ")
            (if (consp (car returns))
              (dolist (return returns)
                (format doc-out " ~s" (cdr return)))
              (format doc-out " ~s" (cdr returns)))
            (force-output doc-out)
            t)))))

(defun show-help-file-documentation (symbol &optional where)
  "gets the documentation from a resource, and prints it to the
doc-string window.  Returns non-NIL if it finds an entry in the help file"
  (let ((doc-string (get-help-file-entry symbol #'read-to-double-newline t)))
    (when doc-string
      (let* ((win (begin-doc-output where))
             (buf (fred-buffer win))
             pos)
        (without-interrupts
         (apply 'set-view-font-codes win *bold-doc-font*)
         (format win "~s " symbol)
         (apply 'set-view-font-codes win *doc-font*)
         (set-selection-range win buf buf)
         (ed-push-mark win buf t)
         (setq pos (buffer-position buf))
         (buffer-insert buf doc-string)
         (buffer-insert buf #\newline)
         (parse-font-changes buf pos (buffer-position buf))
         (ed-fill-region win t))
        (force-output win))
      t)))

(defun maybe-load-help-map (&optional (force (and *fast-help* (not (hash-table-p *fast-help*)))))
  (when force
    (ignore-errors (load "ccl:MCL Help Map" :if-does-not-exist nil :verbose nil))
    (unless (hash-table-p *fast-help*)
      (setq *fast-help* nil)))
  *fast-help*)

(defvar *doc-string-stream* nil)

(defun open-doc-string-file (&optional reopen (query-for-help-file-p t))
  (let ((stream *doc-string-stream*))
    (if (and (streamp stream)
             (open-stream-p stream)
             (if reopen
               (progn (close stream) (setq *doc-string-stream* nil))
               t))
      stream
      (setq *doc-string-stream*
            (let ((file (get-doc-string-file query-for-help-file-p)))
              (when file
                (ignore-errors
                 (with-open-file (s file :direction :io :if-exists :overwrite :element-type 'base-character)
                   (if s
                     (check-index-file-length s))))   ; may need to reindex.
                (ignore-errors (open file :direction :input))))))))

; Called by ARGLIST-FROM-HELP-FILE, too
(defun get-help-file-entry (symbol &optional (string-reader #'read-to-double-newline) query-for-help-file-p)
  (ignore-errors
   (when (get-doc-string-file query-for-help-file-p)
     (let ((stream (open-doc-string-file nil query-for-help-file-p)))
       (when stream
         (accessing-index-stream stream
           (if (and *fast-help*
                    (progn
                      (if (eq *fast-help* t)
                        (maybe-load-help-map))
                      (hash-table-p *fast-help*)))
             (let ((pos (gethash symbol *fast-help*)))
               (when pos
                 (multiple-value-bind (reader arg) (stream-reader stream)
                   (stream-position stream pos)
                   (funcall string-reader reader arg))))
             (when (search-index-stream stream symbol)
               (multiple-value-bind (reader arg) (stream-reader stream)
                 (funcall string-reader reader arg))))))))))

(defun parse-font-changes (buf &optional (start 0) (end (buffer-size buf)))
  (let ((m (make-mark buf start))
        (em (make-mark buf end))
        p type font-codes)
    (loop
      (setq p (buffer-forward-find-char m #\@ m em))
      (unless p (return))
      (set-mark m (decf p))
      (setq type (buffer-char m (1+ p)))
      (if (eql #\@ type)
        (progn
          (buffer-delete m p (1+ p))
          (move-mark m 1))
        (progn
          (buffer-delete m p (+ p 2))
          (setq font-codes (cdr (assoc type *doc-font-alist* :test #'string-equal)))
          (when font-codes
            (buffer-set-font-codes m (car font-codes) (cadr font-codes) m em)))))))

(defglobal *getting-doc-string-file* nil)

(defun get-doc-string-file (&optional query-p)
  (if %doc-string-file
    (if (eq %doc-string-file t)
      nil
      %doc-string-file)
    (let  ((attempt (probe-file "CCL:MCL Help")))
      (unless (and attempt (eq (mac-file-type attempt) :HELP))
        (if (and query-p (not *getting-doc-string-file*))
          (let-globally ((*getting-doc-string-file* t))
            (if (y-or-n-dialog
                 "The Help File could not be found.  Would you like to locate the file?")
              (setq attempt (choose-file-dialog :directory (or (ignore-errors (probe-file "ccl:"))
                                                               (startup-directory))
                                                :mac-file-type :HELP))
              (progn
                (setq %doc-string-file t)
                (return-from get-doc-string-file nil))))
          (setq attempt nil)))
      (setq %doc-string-file attempt))))

; End of doc-window.lisp
