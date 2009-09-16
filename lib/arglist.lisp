;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  2 6/2/97   akh  don't remember
;;  8 10/3/96  akh  move set *arglist-on-space* to queue-fixup in l1-boot-lds
;;  7 9/3/96   akh  set *arglist-on-space* here, conditionalize re interp fn
;;  5 7/18/96  akh  def-fred-command here
;;  4 6/7/96   akh  get arglists for interpreted function from the lexenv struc
;;  3 10/23/95 akh  ppc stuff - %make-temp-uvector with right subtype
;;  2 10/9/95  akh  arglist-sym-and-def - fix for standard-generic-function-p
;;  2 4/7/95   akh  'character => 'base-character
;;  (do not edit before this line!!)


(in-package :ccl)

; Copyright 1995-1999 Digitool, Inc.
;; Modification History

; akh ed-arglist no error if no mini-buffer
;---------- 5.0b3
;
; 10/14/98 akh  %arglist-internal from Ralf M, lose &method next-method-context when saved def
;                arglist-from-map - exclude next-method-context and get others from right index
; 05/01/97 akh   arglist-sym-and-def from alanr so arglist of traced gf's works
; 10/07/96 bill  arglist-from-compiled-def returns an interpreted function's args in
;                the correct order.
; -------------  4.0
; 08/21/96 bill  Change comment for record-arglist. It's used now by defgeneric.
; -------------  4.0b1
; akh if interpreted-function use arglist info in lexical-environment
;  4/06/95 slh   new from fred-additions.lisp



;;Bootstrapping.
(when (listp %lambda-lists%)
  (setq %lambda-lists% (alist-hash-table (if *save-arglist-info* %lambda-lists%) :test #'eq :weak t)))

(defun record-arglist (name args)
  "Used by defmacro & defgeneric"
  (when (or *save-arglist-info* *save-local-symbols*)
    (setf (gethash name %lambda-lists%) args)))

; Returns two values: the arglist & it's functions binding.
; If the second arg is NIL, there was no function binding.
(defun arglist (sym &optional include-bindings (use-help-file t))
  (%arglist sym include-bindings nil use-help-file))

(defun arglist-string (sym &optional include-bindings)
  (multiple-value-bind (res type)
                       (%arglist-internal sym include-bindings nil nil t)
    (values
     (if (stringp res)
       res
       (and res (prin1-to-string res)))
     type)))

(defun set-arglist (sym arglist)
  (let ((real-sym (arglist-sym-and-def sym)))
    (when (or real-sym (null sym))
      (if (eq arglist t)
        (remhash real-sym %lambda-lists%)
        (setf (gethash real-sym %lambda-lists%) arglist)))))

(defsetf arglist set-arglist)

; Same as ARGLIST, but has the option of using TEMP-CONS instead of CONS
; to cons up the list.
(defun %arglist (sym &optional include-bindings temp-cons-p (use-help-file t))
  (multiple-value-bind (res type)
                       (%arglist-internal
                        sym include-bindings temp-cons-p nil use-help-file)
    (when (stringp res)
      (with-input-from-string (stream res)
        (setq res nil)
        (let ((eof (list nil))
              val errorp)
          (declare (dynamic-extent eof))
          (loop
            (multiple-value-setq (val errorp)
              (ignore-errors (values (read stream nil eof))))
            (when errorp
              (if use-help-file
                (return-from %arglist 
                  (%arglist sym include-bindings temp-cons-p nil)))
              (push '&rest res)
              (push ':unparseable res)
              (return))
            (when (eq val eof)
              (return))
            (push val res))
          (setq res
                (if (and (null (cdr res)) (listp (car res)))
                  (car res)
                  (nreverse res))))))
    (values res type)))

#|
(defun %arglist-internal (sym include-bindings temp-cons-p string use-help-file 
                              &aux def type)
  (multiple-value-setq (sym def) (arglist-sym-and-def sym))
  (when (standard-generic-function-p def)
    (let ((methods (%gf-methods def)))
      (if methods
        (setq def (closure-function
                   (find-unencapsulated-definition
                     (%method-function (car methods))))
              type :analysis))))
  (let ((ll (gethash sym %lambda-lists% *eof-value*))
        (conser (if temp-cons-p #'temp-cons #'cons))
        (macrop (and (symbolp sym) (eq (macro-function sym) def))))
    (flet ((strip (f) (if (stringp f) f (strip-bindings f include-bindings conser))))
      (declare (dynamic-extent #'strip))
      (cond ((neq ll *eof-value*) (values (strip ll) :declaration))
            ((consp def)
             ;; Presumably (lambda (... arglist) ...)
             (values (strip (cadr def)) :definition))
            ((neq (setq ll (getf (%lfun-info def) 'arglist *eof-value*)) *eof-value*)
             (values ll :definition))
            ((and (not macrop) (setq ll (uncompile-function def)))
             (values (strip (cadr ll)) (or type :definition)))
            ((lfunp def)
             (multiple-value-bind (arglist gotit) 
                                  (unless macrop (arglist-from-map def conser))
               (if gotit
                 (values arglist :analysis)
                 (cond ((and use-help-file
                             sym
                             (setq arglist (arglist-from-help-file sym string)))
                        (values arglist :declaration))
                       (macrop (values nil :unknown))
                       (t (values (arglist-from-compiled-def def conser) :analysis))))))
            ((and use-help-file (setq def (arglist-from-help-file sym string)))
             (values def :declaration))
            (t (values nil nil))))))
|#

;; from Ralf Moeller
(defun %arglist-internal (sym include-bindings temp-cons-p string use-help-file 
                              &aux def type)
  (multiple-value-setq (sym def) (arglist-sym-and-def sym))
  (when (standard-generic-function-p def)
    (let ((methods (%gf-methods def)))
      (if methods
        (setq def (closure-function
                   (find-unencapsulated-definition
                     (%method-function (car methods))))
              type :analysis))))
  (let ((ll (gethash sym %lambda-lists% *eof-value*))
        (conser (if temp-cons-p #'temp-cons #'cons))
        (macrop (and (symbolp sym) (eq (macro-function sym) def))))
    (flet ((strip (f) (if (stringp f) f (strip-bindings f include-bindings conser)))
           ;; ********* NEW aux function **********
           (strip-method-context (method-spec)
             (if (and (consp method-spec)
                      (eq (first method-spec) '&method))
               (rest (rest method-spec))
               method-spec)))
      (declare (dynamic-extent #'strip))
      (cond ((neq ll *eof-value*) (values (strip ll) :declaration))
            ((consp def)
             ;; Presumably (lambda (... arglist) ...)
             (values (strip (cadr def)) :definition))
            ((neq (setq ll (getf (%lfun-info def) 'arglist *eof-value*)) *eof-value*)
             (values ll :definition))
            ((and (not macrop) (setq ll (uncompile-function def)))
             (values (strip-method-context (strip (cadr ll)))
                     ;; *** CALLED HERE ***********
                     (or type :definition)))
            ((lfunp def) 
             (multiple-value-bind (arglist gotit) 
                                  (unless macrop (arglist-from-map def conser))
               (if gotit
                 (values arglist :analysis)
                 (cond ((and use-help-file
                             sym
                             (setq arglist (arglist-from-help-file sym string)))
                        (values arglist :declaration))
                       (macrop (values nil :unknown))
                       (t (values (arglist-from-compiled-def def conser) :analysis))))))
            ((and use-help-file (setq def (arglist-from-help-file sym string)))
             (values def :declaration))
            (t (values nil nil))))))

(defun arglist-from-help-file (sym &optional string)
  (flet ((string-reader (reader arg)
           (unless (and string (stringp string)
                        (array-has-fill-pointer-p string))
             (setq string (make-array 10 :fill-pointer 0 :adjustable t
                                      :element-type 'base-character)))
           (setf (fill-pointer string) 0)
           (let (char)
             (loop                         ; strip the font info
               (setq char (funcall reader arg))
               (loop
                 (unless (eql #\@ char) (return))
                 (setq char (funcall reader arg))
                 (if (eql #\@ char)
                   (return)
                   (setq char (funcall reader arg))))
               (when (or (null char) (char-eolp  char))
                 (return string))
               (vector-push-extend char string)))))
    (declare (dynamic-extent #'string-reader))
    (get-help-file-entry sym #'string-reader)))            

(defun strip-bindings (arglist include-bindings conser)
  (if include-bindings
    arglist
    (macrolet ((push (elt list)
                 `(setq ,list (funcall conser ,elt ,list))))
      (let ((res nil))
        (do ((args arglist (%cdr args)))
            ((not (consp args)) (nreconc res args))
          (let ((arg (car args)))
            (cond ((atom arg)
                   (push arg res))
                  ((atom (car arg))
                   (push (car arg) res))
                  (t (push (caar arg) res)))))))))

(defun arglist-sym-and-def (sym &aux def)
   (if (and (symbolp sym)
             (fboundp sym)
             (typep (symbol-function sym) 'standard-generic-function))
      (setq sym  (symbol-function sym)))
  (cond ((functionp sym)
         (setq def sym
               sym (function-name def))
         (unless (and (symbolp sym) (eq def (fboundp sym)))
           (setq sym nil)))
        ((listp sym)
         (if (eq (car sym) 'setf)
           (setq sym (setf-function-name (cadr sym))
                 def (find-unencapsulated-definition (fboundp sym)))
           (setq sym nil def nil)))
        ((standard-method-p sym)
         (setq def (closure-function 
                    (find-unencapsulated-definition (%method-function sym)))))
        ((and (macro-function sym))
         (setq def (macro-function sym)))
        ((special-form-p sym)
         nil)
        (t (setq def (find-unencapsulated-definition (fboundp sym)))))
  (values sym (if (standard-generic-function-p def) def (closure-function def))))

(defun arglist-from-map (lfun &optional (conser #'cons))
  (multiple-value-bind (nreq nopt restp nkeys allow-other-keys
                             optinit lexprp
                             ncells nclosed)
                       (function-args lfun)
    (declare (ignore optinit ncells))
    (macrolet ((push (elt list)
                     `(setf ,list (funcall conser ,elt ,list))))
      (when (not lexprp)
        (let ((map (car (function-symbol-map lfun))))
          
          (when map
            (let ((total (+ nreq nopt (if restp 1 0) (or nkeys 0)))
                  (idx (- (length map) nclosed))
                  (res nil))
              ;; Kludge to exclude next-method-context and get the rest right
              (when (>= nreq 1)
                (let ((sym (elt map (1- (length map)))))
                  (when (and (symbolp sym)(string= (symbol-name sym) "NEXT-METHOD-CONTEXT"))
                    (decf idx))))              
              (if (%izerop total)
                (values nil t)
                (progn
                  (dotimes (x nreq)
                    (declare (fixnum x))
                    (push (if (> idx 0) (elt map (decf idx)) (make-arg "REQ" x)) res))
                  (when (neq nopt 0)
                    (push '&optional res)
                    (dotimes (x (the fixnum nopt))
                      (push (if (> idx 0) (elt map (decf idx)) (make-arg "OPT" x)) res)))
                  (when restp
                    (push '&rest res)
                    (push (if (> idx 0) (elt map (decf idx)) 'the-rest) res))
                  (when nkeys
                    (push '&key res)
                    (let ((keyvect (lfun-keyvect lfun)))
                      (dotimes (i (length keyvect))
                        (push (elt keyvect i) res))))
                  (when allow-other-keys
                    (push '&allow-other-keys res))))
              (values (nreverse res) t))))))))

(defvar *make-arg-string* (make-array 6 
                                      :element-type 'base-character
                                      :fill-pointer 0
                                      :adjustable t))
(defun make-arg (prefix count)
  (without-interrupts
   (let ((string *make-arg-string*)
         (*make-arg-string* nil))
     (setf (fill-pointer string) 0)
     (format string "~a-~d" prefix count)
     (consless-intern string :ccl))))

(defun consless-intern (string &optional package)
  (if (and (stringp string) (not (simple-string-p string)))
    (with-managed-allocation
      (let* ((length (length string))
             (copy (%make-temp-uvector length #-ppc-target $v_sstr
                                       #+ppc-target ppc::subtag-simple-base-string)))
        (dotimes (i length) (declare (fixnum i)) (setf (uvref copy i) (aref string i)))
        (or (find-symbol copy package)
            (intern (ensure-simple-string string) package))))
    (intern string package)))

(defun arglist-from-compiled-def (lfun &optional (conser #'cons) 
                                       &aux (res nil) argnames)
  (multiple-value-bind (nreq nopt restp nkeys allow-other-keys
                        optinit lexprp
                        ncells nclosed)
          (function-args lfun)
    (declare (ignore optinit ncells nclosed))
    #+ppc-target
    (when (typep lfun 'interpreted-function)
      (setq argnames (evalenv-names (%nth-immediate lfun 0))))
    (macrolet ((push (elt list)
                     `(setf ,list (funcall conser ,elt ,list))))
      (flet ((push-various-args (prefix count)
               (dotimes (i (the fixnum count))
                 (push (make-arg prefix i) res))))
        (declare (dynamic-extent #'push-various-args))
        (cond (lexprp
               nil)
              ((and (eq 0 (+ nreq nopt (or nkeys 0))) (not restp))
               nil)
              (t 
               (if argnames
                 (setq res (reverse (butlast argnames (- (length argnames) nreq))))
                 (push-various-args "ARG" nreq))
               (when (> nopt 0)
                 (push '&optional res)
                 (if argnames
                   (setq res (append (reverse (subseq argnames nreq (+ nreq nopt))) res))
                   (push-various-args "OPT" nopt)))
               (when restp
                 (push '&rest res)
                 (if argnames
                   (push (nth (+ nreq nopt) argnames) res)
                   (push 'the-rest res)))
               (when nkeys
                 (push '&key res)
                 (let ((keyvect (lfun-keyvect lfun)))
                   (dotimes (i (length keyvect))
                     (push (elt keyvect i) res))))
               (when allow-other-keys
                 (push '&allow-other-keys res))
               (nreverse res)))))))

; c-x c-a
(defmethod ed-arglist ((w fred-mixin) &optional (symbol nil symbolp))
  (let* ((buf (fred-buffer w))
         (pos (buffer-position buf))
         char)
    (unless symbolp      
      #|(let ((foopos (buffer-bwd-up-sexp buf pos))) ; cute sometimes but not for out of context symbol
        (when foopos (setq pos (1+ foopos))))|#
      (when (and (> pos 0)(eq #\space (buffer-char buf (1- pos))))
        (setq pos (1- pos)))
      (multiple-value-setq (symbol symbolp char) (ed-current-symbol w #'read-#-prefixed-symbol pos)))
    ;(print (list symbol symbolp char))
    (cond ((not symbolp)
           (when (view-mini-buffer w)(stream-fresh-line (view-mini-buffer w)))
           (buffer-arglist-pos buf nil))
          (t
           (if *mini-buffer-help-output*
             (if (and (mini-buffer-arglist w symbol)(eq char #\()) ; if form begins and arglist exists, make it sticky
                 (buffer-arglist-pos buf pos symbol)
                 (buffer-arglist-pos buf nil))
             (progn
               (format *help-output* "~s arglist: " symbol)
               (arglist-to-stream symbol *standard-output*)))))))


(defun mini-buffer-arglist (w &optional (symbol nil symbolp) &aux
                                (stream (view-mini-buffer w))
                                open-paren?)
  (when stream
    (unless symbolp
      (multiple-value-bind (sym foundp pre-char)
                           (ed-current-symbol w #'read-#-prefixed-symbol)
        (setq open-paren? (eq pre-char #\())
        (if (and foundp open-paren?)
          (setq symbol sym
                symbolp t))))
    (when t (stream-fresh-line stream))
    (when symbolp 
      (prog1 (arglist-to-stream symbol stream)
        (mini-buffer-show-cursor w)))))

(defvar *arglist-string* 
  (make-array 10 :fill-pointer 0 :adjustable t :element-type 'base-character))

; Gives the arglist of a generic-function as the arglist of its first method.
(defun arglist-to-stream (sym stream &optional def)
  (with-managed-allocation
    (multiple-value-bind (arglist type)
                         (%arglist-internal (or def sym) nil t *arglist-string* t)      
      (when type 
        (cond ((stringp arglist)
               (cond 
                ((find-if #'(lambda (c) (neq c #\space)) arglist)
                 (let ((start 0)
                       (end (length arglist)))
                   (declare (fixnum start end))
                   (when (and (> end 0)
                              (eql #\( (char arglist 0))
                              (eql #\) (char arglist (1- end)))
                              (not (eql end 2)))
                     (setq start 1 end (1- end)))
                   (stream-write-string stream arglist start end))
                 T)
                 ((fboundp sym)
                   (%write-string "()" stream)
                   t)))
              ((null arglist)
               (%write-string (if (eq type :unknown) "??" "()") stream)
               t)
              (t (do ((args arglist (cdr args)))
                     ((not (consp args))
                      (unless (null args) (format stream " . ~a" args)))
                   (format stream "~a " (car args)))
                 t))))))

; #\space
(defmethod interactive-arglist ((w fred-mixin))
  (ed-self-insert w)
  (when (and *arglist-on-space* (view-mini-buffer w))
    (if (let ((package (buffer-getprop (fred-buffer w) 'package)))
               (or (null package) (packagep package)))
      (let* ((buf (fred-buffer w))
             (pos (1- (buffer-position buf))))
        (unless (buffer-arglist-pos buf)
          (multiple-value-bind (sym foundp pre-char)
                               (ed-current-symbol w #'read-#-prefixed-symbol  pos)            
            (when (and foundp (eql #\( pre-char))            
              (mini-buffer-arglist w sym)))))
      (set-mini-buffer w "~&c-m-m sets the package."))))


(let ((comtab *control-x-comtab*))
  (comtab-set-key comtab '(:control #\a)    'ed-arglist))

(let ((comtab %initial-comtab%))
  (comtab-set-key comtab #\space                 'interactive-arglist)
)
;(setq *arglist-on-space* t)   ; aargh

; End of arglist.lisp
