;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 9/4/96   akh  some setf fixes
;;  1 7/18/96  akh  new file - split out of fred-additions
;;  (do not edit before this line!!)

; Change History:

;; edit-definition-p - if ask for type 'variable (e.g. from apropos) look for type 'constant as well 
;; --------- 5.1 final
;; call to y-or-n-dialog specifies :cancel-text  vs :no-text
;; ------- 5.1b2 
;; make search-method-classes find methods on aliased classes (classes that have >1 name)
;; make finding accessors and slot-names work
;; edit-definition-2 from Gary Warren King, slightly modified
;; ----- 5.1b1
;; updated fix below
;;fix so edit-definition finds methods defined as below - from Gary Warren King
;;(defgeneric foo (a b)
;; (:method ((a bar) (b baz))
;; ...)
;; ...)
;;
;; ---------- 4.4b4
;; 05/23/02 edit-definition doesn't proliferate windows for same request - from Gary Warren King
;; ------ 4.4b3
;; 08/15/01 akh edit-definition-2 uncollapses window if collapsed
;; ------- 4.4b1
;; akh parse-definition-spec deals with ' and #'
; --------- 4.3b2
; 04/12/99 akh - from slh search-method-classes for eql 'mumble

;----------- 4.3b1
; 01/14/98 akh search-method-classes - beware buffer-getprop returning non-package - e.g. cons => non-existent package
; 11/03/97 akh   edit-definition-2 does vanilla edit-definition-error if file not found
; 02/25/97 akh   search-method-classes fix for (eql foo)
; 09/30/96 bill  edit-definition-2 eliminates flashing on new windows by
;                saying (make-instance *default-editor-class* ... :window-show nil)
;                instead of (ed ...), then showing the window after it's been scrolled.
; ------------   4.0b2
;  9/11/96 slh   search-method-classes: always use ~S to get class name,
;                so package prefix used


(in-package :ccl)

;; moved from fred-additions

(comtab-set-key %initial-comtab% '(:meta  #\.)           'ed-edit-definition)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; source files stuff
;;

;;Bootstrapping.
(defvar %source-files% (let ((a (make-hash-table :test #'eq
                                                 :weak t
                                                 :size 7000
                                                 :rehash-threshold .9)))
                         (do-all-symbols (s)
                           (let ((f (get s 'bootstrapping-source-files)))
                             (when f
                               (setf (gethash s a) f)
                               (remprop s 'bootstrapping-source-files))))
                         a))
;These two exist only so that record-source-file can occur early in level-1.
;Maybe should just redefine it here...
(%fhave '%source-files (qlfun %source-files (name)
                         (gethash name %source-files%)))
(%fhave '%set-source-files (qlfun %set-source-files (name value)
                             (puthash name %source-files% value)))

; doesnt get the files for (setf blah)
(defun get-source-files (sym &optional (type t) &aux result result-1)
  (setq result (%source-files sym))
  (when result
    (if (not (consp result))
      (list result)
      (cond ((neq type t)
             (setq result (%cdr (assq type result)))
             (when (and result (not (consp result)))
               (setq result (list result)))
             result)
            (t 
             (dolist (type.files result result-1)
               (let ((files (cdr type.files)))
                 (setq result-1 (append (if (consp files) files (list files)) result-1)))))))))


#|
; not used
(defun get-source-files-with-types (sym &optional (type t))
  (let ((result (%source-files sym)))
    (flet ((merge-types (l)
              (let ((type (car l)))
                (mapcan #'(lambda (x) (when x (list (cons type x)))) (cdr l)))))
      (if (eq type t)
        (mapcan #'merge-types result)
        (merge-types (assq type result))))))
|#

; sym can be (setf blah)
(defun get-source-files-with-types&classes (sym &optional (type t) classes qualifiers the-method)
  (labels 
    ((merge-types (l)
       (let ((ftype (car l)))
         (cond
          ((eq ftype 'setf) ; it's (setf (function . file))
           (let ((res (mapcan #'merge-types (cdr l))))
             (if (typep (caar res) 'method)
               res
               (mapcar #'(lambda (x)(cons 'setf (cdr x))) res))))
          ((or (eq type t)(eq ftype type))
           (let* ((foo #'(lambda (x)
                           (when x
                             ; if x is consp it's (<method> file file ..)
                             (cond 
                              ((consp x)
                               (when (or (not (or classes qualifiers))
                                         (if the-method 
                                           (methods-match-p (car x) the-method)
                                           (source-files-like-em classes qualifiers
                                                                 (car x))))
                                 (merge-class x)))
                              (t (list (cons ftype x))))))))
             (declare (dynamic-extent foo))
             (mapcan foo (if (consp (cdr l)) (cdr l)(list (cdr l)))))))))
     (merge-class (l)
       (if (consp (cdr l))
         (mapcan 
          #'(lambda (x) 
              (when x (list (cons (car l) x))))
          (cdr l))
         (list l))))
    (declare (dynamic-extent #'merge-types)(special *direct-methods-only*))
    (let (files)
      (when (and (not the-method)(eq type 'method) classes (not *direct-methods-only*))
        (let ((methods (find-applicable-methods sym classes qualifiers)))          
          (when methods            
            (setq files (mapcan
                         #'(lambda (m)
                             (or (edit-definition-p m)(list (list m))))
                         methods)))))
      (if files files
          (let (setf-p result)
            (if (and (consp sym)(eq (car sym) 'setf))
              (setq sym (cadr sym) setf-p t))
            (setq result (%source-files sym))
            (if (not (consp result))
              (setq result
                    (if (not setf-p)
                      (if (or (eq type t)(eq type 'function))
                        `((function . ,result)))))
              (if setf-p (setq result (list (assq 'setf result)))))
            (mapcan #'merge-types result))))))


; Do this just in case record source file doesn't remember the right definition
(defun methods-match-p (x y)  
  (or (eq x y)
      (and (typep x 'method)
           (typep y 'method)
           (equal (method-name x)
                  (method-name y))
           (equal (method-specializers x)
                  (method-specializers y))
           (equal (method-qualifiers x)
                  (method-qualifiers y)))))



(defun source-files-like-em (classes qualifiers method)
  (when (equal (canonicalize-specializers classes)
               (method-specializers method))
      (or (eq qualifiers t)
          (equal qualifiers (%method-qualifiers method)))))

; This is a copy of the first half of edit-definition
(defun edit-definition-p (name &optional (type t) &aux specializers qualifiers the-method)
  (when (consp name)
    (multiple-value-setq (type name specializers qualifiers)
      (parse-definition-spec name)))
  (when (and specializers (consp specializers)) (setq type 'method))
  ; might be a method-function whose name is the method
  (when (typep name 'function)(setq name (function-name name)))
  (when (typep name 'method)
     (setq qualifiers (%method-qualifiers name)
           specializers (uncanonicalize-specializers (%method-specializers name))
           the-method name
           name (%method-name name)
           type 'method))
  (let (files str newstr newname)    
    (setq files (or (get-source-files-with-types&classes name type specializers qualifiers the-method)
                    (and (eq type 'variable)  (get-source-files-with-types&classes name 'constant specializers qualifiers)) ;; ??
                    (and 
                     (not the-method)
                     (symbolp name)
                     (or (and
                          (setq str (symbol-name name))
                          (memq (schar str (1- (length str))) '(#\.  #\, #\:))
                          (setq newname
                                (find-symbol (setq newstr (%substr str 0 (1- (length str))))
                                             (symbol-package name)))
                          (get-source-files-with-types&classes newname type specializers qualifiers))
                         (unless *current-package-only*
                           (let ((syms (nconc (find-all-symbols name)
                                              (and newstr (find-all-symbols newstr)))))
                             (do ((lst syms (cdr lst))
                                  (val nil))
                                 ((null lst) nil)
                               (when (and (neq (car lst) name)
                                          (setq val 
                                                (get-source-files-with-types&classes
                                                 (car lst) type specializers qualifiers)))
                                 (setq newname (car lst))
                                 (return val)))))))))         
  (multiple-value-bind (ipath itype) (interface-definition-p name type)
    (when (and ipath (not (member (pathname-name ipath) files 
                                  :key #'(lambda (x) (pathname-name (cdr x))) :test 'equal)))
      (push (cons itype ipath) files)))
  (when (and files newname) (setq name newname))
  (values files name type specializers qualifiers)))

; name can be (setf blah)

(defclass defs-select-dialog (select-dialog) ())


#|
(defun edit-definition (name &optional (type t) no-show)
  (multiple-value-bind (files name type classes qualifiers)
                       (edit-definition-p name type)
    (declare (ignore-if-unused type))
    (if (not files)
      (values nil nil name type classes qualifiers)
      (cond ((null (cdr files))
             (if  no-show
               (values t files name type classes qualifiers)
               (let ((pos (edit-definition-2 (car files) name)))
                 (values pos files name type classes qualifiers))))
            (t 
             (let* (w)
               (when (not classes)
                 (setq files (sort files #'edit-definition-spec-lessp :key #'car)))
               (when (not no-show)                 
                 (setq w
                       (select-item-from-list
                        files
                        :dialog-class 'defs-select-dialog
                        :table-print-function (make-defs-print-function files name)
                        :window-title              
                        (let ((*print-case* :downcase))
                          (format nil "Definitions of ~S" name))
                        :modeless t
                        ;:view-position (edit-anything-result-pos 140)  ; was previously unspecified
                        :view-size #@(400 138)
                        :default-button-text "Find it"
                        :action-function
                        #'(lambda (list)
                            (if (option-key-p) (window-close w))
                            (edit-definition-2 (car list) name)))))
               (values t files name type classes qualifiers)))))))
|#

(defun edit-definition-window-title (name)
  (let ((*print-case* :downcase))
    (format nil "Definitions of ~S" name)))

(defun edit-definition (name &optional (type t) no-show)
  (multiple-value-bind (files name type classes qualifiers)
                       (edit-definition-p name type)
    (declare (ignore-if-unused type))
    (if (not files)
      (values nil nil name type classes qualifiers)
      (let* ((window-title (edit-definition-window-title name))
             (old-window (find-window window-title 'defs-select-dialog))
             (view-size (when old-window (view-size old-window)))
             (view-position (when old-window (view-position old-window)))
             (args nil))
        (cond ((null (cdr files))
               (if  no-show
                 (values t files name type classes qualifiers)
                 (let ((pos (edit-definition-2 (car files) name)))
                   (values pos files name type classes qualifiers))))
              (t 
               (let* (w)
                 (when (not classes)
                   (setq files (sort files #'edit-definition-spec-lessp :key #'car)))
                 (unless no-show
                   ;; set size and position to much putative old window
                   (push (if view-size view-size #@(400 138)) args)
                   (push :view-size args)
                   (when view-position
                     (push view-position args)
                     (push :view-position args))
                   ;; go for it
                   (setq w
                         (apply #'select-item-from-list
                                files
                                :dialog-class 'defs-select-dialog
                                :table-print-function (make-defs-print-function files name)
                                :window-title window-title
                                :modeless t
                                :default-button-text "Find it"
                                :action-function
                                #'(lambda (list)
                                    (if (option-key-p) (window-close w))
                                    (edit-definition-2 (car list) name))
                                args))
                   ;; close old window
                   (when old-window (window-close old-window))))
               (values t files name type classes qualifiers)))))))

(defun make-defs-print-function (defs name)
  (let ((ed-show-setf
         (dolist (f defs)
           (let ((thing (car f)))                              
             (when (and (typep thing 'method)
                        (consp (setq thing (method-name thing)))
                        (not (equal thing name)))
               (return t))))))
    #'(lambda (a &optional (b t))
        (let ((*ed-show-setf* ed-show-setf))
          (format-definition-pathnames a b t name)))))
  
#|
(defun edit-anything-result-pos (height)
  (let ((e-dialog *edit-anything-dialog*))
    (if (and e-dialog (wptr e-dialog)(eq e-dialog (front-window)))
      (let* ((e-pos (view-position e-dialog))
             (e-size (view-size e-dialog))
             (top (+ (point-v e-pos)(point-v e-size) 20)))
        (if (<= (+ top height) *screen-height*) ; what if its on a second screen?
          (make-point (point-h  e-pos) top)
          '(:top 90)))
      '(:top 90))))
|#
  

; compares two args for edit-definition.
; symbols come first and are sorted by name
; methods come next and are sorted by specializer names, then qualifiers
; everything else is sorted by address
; slight tweak to make it applicable for edit callers
(defun edit-definition-spec-lessp (x y)
  (cond ((symbolp x)
         (if (symbolp y) (string-lessp x y) t))
        ((symbolp y) nil)
        ((typep x 'standard-method)
         (if (typep y 'standard-method)
           (let ((y-name (method-name y))
                 (x-name (method-name x)))             
             (if (not (equal x-name y-name))
               (progn
                 (if (consp x-name)(setq x-name (format nil "~A" x-name)))
                 (if (consp y-name)(setq y-name (format nil "~A" y-name)))
                 (string-lessp x-name y-name))
               (let ((y-specs (method-specializers y))
                     y-spec)
                 (dolist (x-spec (method-specializers x)
                                 (or y-specs
                                     (let ((y-qs (method-qualifiers y))
                                           y-q)
                                       (dolist (x-q (method-qualifiers x) y-qs)
                                         (unless y-qs (return nil))
                                         (setq y-q (pop y-qs))
                                         (cond ((string-lessp x-q y-q)
                                                (return t))
                                               ((string-lessp y-q x-q)
                                                (return nil)))))))
                   (unless y-specs (return nil))
                   (setq y-spec (pop y-specs))
                   (if (typep x-spec 'class)
                     (if (typep y-spec 'class)
                       (let ((x-name (class-name x-spec))
                             (y-name (class-name y-spec)))
                         (if (edit-definition-spec-lessp x-name y-name)
                           (return t))
                         (if (edit-definition-spec-lessp y-name x-name)
                           (return nil)))
                       (return nil))
                     (return t))))))
           t))
        ((typep y 'standard-method) nil)
        ;; Someone clearly should have had the crap beaten out of them long
        ;; ago.
        (t (< (%address-of x) (%address-of y)))))

#| ;; from Gary King
Attached is a patch for edit-definition-2. It assumes that 
%method-specializers for a method with eql specializers will return a 
list of classes and conses (where the conses look like (eql <foo>)). 
Under the MOP, %method-specializers returns a list of classes and 
instances of the class eql-specializer.
|#
(defun edit-definition-2 (pathname &optional name)

  ; pathname isn't. Car is 'variable, a method, 'function, 'class etc.
  ; Cdr is the pathname. - only called if source file info
  (let (type pos new-window classes qualifiers file-not-found)
    (when pathname
      (setq type (car pathname)
            pathname (cdr pathname))
      (typecase type
        (method
         (setq qualifiers (%method-qualifiers type)
               classes (mapcar #'(lambda (s)
                                  (typecase s
                                     (eql-specializer (list 'eql (eql-specializer-object s ))) ;; <<
                                     (cons s)
                                     (t (class-name s))))
                               (%method-specializers type))
               name (%method-name type)
               type 'method)))
      (when (and (eq type 'setf)(not (consp name)))
        (setq name (list 'setf name)))
      (setq new-window 
            (or (and pathname (pathname-to-window pathname))
                (and (stringp pathname)                       
                     ; does it look like a real pathname ?
                     ;(equalp pathname "New")
                     ; No, look for a  fred window with no pathname and matching title.
                     (my-string-to-window pathname))))
      (let ((*gonna-change-pos-and-sel* t)
            really-new)
        (if new-window
          (progn 
            (window-select new-window)
            (when (appearance-available-p)              
              (let ((wptr (wptr new-window)))
                (when (#_IsWindowCollapsed wptr)
                  (#_CollapseWindow wptr nil))))) 
          ; don't error if window e.g. "New 1" isnt there any longer
          (when (and (or (pathnamep pathname)(and (stringp pathname) (%path-mem ":;" pathname)))
                     (or (probe-file pathname)(progn (setq file-not-found t) nil)))
            (setq new-window 
                  (make-instance *default-editor-class*
                    :filename pathname
                    :window-show nil))
            (setq really-new t)))
        (when new-window
          (unwind-protect
            (let ((buf (fred-buffer new-window)))
              (setq pos (or (search-for-def buf name type classes qualifiers)
                            ; ? do we really want to do this ?
                            (search-for-def-dumb buf name type classes qualifiers
                                                 0 (buffer-size buf) T))) ; and dumber            
              (when pos
                (ed-push-mark new-window)
                (window-scroll new-window pos)))
            (when really-new
              (window-select new-window))))))
    (when (not pos)
      (edit-definition-error name classes qualifiers pathname file-not-found))
    (values pos pathname)))

;method stuff cribbed from print-object for methods
(defun format-definition-pathnames (object &optional (stream t) (with-x t) name)
  (let ((thing (car object))
        (path (cdr object))
        (fstr "~a<~s ~s>")
        (pfx (if with-x "  " "")))
    (if (typep thing 'standard-method)
      (progn
        (when (and with-x (not (%method-gf thing)))
          (setq pfx "X "))
        (if (and *ed-show-setf* (consp (method-name thing)))
          (setq fstr"~a<SETF ~s ~s>"))
        (let ((qualifiers (%method-qualifiers thing)))
          (format stream fstr pfx (case (length qualifiers)
                                     (0 :primary)
                                     (1 (car qualifiers))
                                     (t qualifiers))
                  (uncanonicalize-specializers (%method-specializers thing)))))
      (let ((pfx (if with-x "  " "")))
        (when with-x
          (when (and (eq thing 'function)                     
                     name
                     (not (fboundp name)))
            (setq pfx "X ")))                        
        (format stream "~a~s" pfx thing)))
    (when (or (stringp path) (pathnamep path))
      (format stream " ~s" (pathname-to-window-title path)))))

; modified version of %compute-applicable-methods*
; omit errors and args are class names not instances
; returns a new list.
(defun find-applicable-methods (name args qualifiers)
  (let ((gf (fboundp name)))
    (when (and gf (typep gf 'standard-generic-function))
      (let* ((methods (%gf-methods gf))
             (args-length (length args))
             (bits (lfun-bits (closure-function gf)))  ; <<
             arg-count res)
        (when methods
          (setq arg-count (length (%method-specializers (car methods))))
          (unless (or (logbitp $lfbits-rest-bit bits)
                      (logbitp $lfbits-keys-bit bits)
                      (<= args-length 
                          (+ (ldb $lfbits-numreq bits) (ldb $lfbits-numopt bits))))
            (return-from find-applicable-methods))
          (cond 
           ((null args)
            (dolist (m methods res)
              (when (or (eq qualifiers t)
                        (equal qualifiers (%method-qualifiers m))) 
                (push m res))))
           ((%i< args-length arg-count)
            (let (spectails)
              (dolist (m methods)
                (let ((mtail (nthcdr args-length (%method-specializers m))))
                  (pushnew mtail spectails :test #'equal)))
              (dolist (tail spectails)
                (setq res 
                      (nconc res (find-applicable-methods 
                                  name 
                                  (append args (mapcar 
                                                #'(lambda (x) (if (consp x) x (class-name x)))
                                                tail))
                                  qualifiers))))
              (if (%cdr spectails)
                (delete-duplicates res :from-end t :test #'eq)
                res)))
           (t 
            (let ((cpls (make-list arg-count)))
              (declare (dynamic-extent cpls))
              (do ((args-tail args (cdr args-tail))
                   (cpls-tail cpls (cdr cpls-tail)))
                  ((null cpls-tail))
                (declare (type list args-tail cpls-tail))
                (let ((arg (car args-tail)) thing)
                  (if (consp arg)
                    (setq thing (class-of (cadr arg)))
                    (setq thing (find-class (or arg t) nil)))
                  (when thing
                    (setf (car cpls-tail)                
                          (%class-precedence-list thing)))))
              (dolist (m methods)
                (when (%my-method-applicable-p m args cpls)
                  (push m res)))
              (let ((methods (sort-methods res cpls (%gf-precedence-list gf))))
                (when (eq (generic-function-method-combination gf)
                          *standard-method-combination*)
                  ; around* (befores) (afters) primaries*
                  (setq methods (compute-method-list methods))
                  (when methods
                    (setq methods
                          (if (not (consp methods))
                            (list methods)
                            (let ((afters (cadr (member-if #'listp methods))))
                              (when afters (nremove afters methods))
                              (nconc
                               (mapcan #'(lambda (x)(if (listp x) x (cons x nil)))
                                       methods)
                               afters))))))
                (if (and qualifiers (neq qualifiers t))
                  (delete-if #'(lambda (m)(not (equal qualifiers (%method-qualifiers m))))
                             methods)
                  methods))))))))))

; modified version of %method-applicable-p - args are class names not instances
(defun %my-method-applicable-p (method args cpls)
  (do ((specs (%method-specializers method) (cdr specs))
       (args args (cdr args))
       (cpls cpls (cdr cpls)))
      ((null specs) t)
    (declare (type list specs args cpls))
    (let ((spec (car specs)))
      (if (listp spec)
        (unless (equal (car args) spec)
          (return nil))
        (unless (memq spec (car cpls))
          (return nil))))))

(defun parse-definition-spec (form)
  (let ((type t)
        name classes qualifiers)
    (cond
     ((consp form)
      (cond ((eq (car form) 'setf)
             (setq name form))
            ((eq (car form) 'function)
             (setq type 'function)
             (setq name (cadr form)))
            ((eq (car form) 'quote)
             (setq name (cadr form)))
            (t (setq name (car form))
               (let ((last (car (last (cdr form)))))
                 (cond ((and (listp last)(or (null last)(neq (car last) 'eql)))
                        (setq classes last)
                        (setq qualifiers (butlast (cdr form))))
                       (t (setq classes (cdr form)))))                   
               (cond ((null qualifiers)
                      (setq qualifiers t))
                     ((equal qualifiers '(:primary))
                      (setq qualifiers nil))))))
     (t (setq name form)))
    (when (and (consp name)(eq (car name) 'setf))
        (setq name (or (%setf-method (cadr name)) name))) ; e.g. rplacd
    (when (not (function-spec-p name))(return-from parse-definition-spec))
    (when (consp qualifiers)
      (mapc #'(lambda (q)
                (when (listp q)
                  (return-from parse-definition-spec)))
          qualifiers))
    (when classes
      (mapc #'(lambda (c)
                (when (not (and c (or (symbolp c)(and (consp c)(eq (car c) 'eql)))))
                  (return-from parse-definition-spec)))
            classes))            
    (when (or (consp classes)(consp qualifiers))(setq type 'method))
    (values type name classes qualifiers)))

(defmethod ed-edit-definition ((w fred-mixin) &optional pos)
  (let ((form (or (standard-method-kludge w pos)  ; m.b. first else find #'>
                  (ignore-errors (ed-current-sexp w pos)))))
    (cond
     ((null form)
      (edit-anything-dialog :definition))
     (t (edit-definition-spec form)))))

(defun edit-definition-spec (form &optional no-show)
  (multiple-value-bind (pos files name type classes qualifiers)
                       (edit-definition form t no-show)
    (cond (name
           (when (and (not pos)(not files))            
             ; if no source file info - search all buffers?
             (when (y-or-n-dialog (format nil "No source file information for ~s.~%Search fred windows?" form)
                                  :cancel-text "No" :no-text nil :theme-background t)
               (dolist (ww (windows))
                 (when (and (typep ww 'fred-window)
                            (not (typep ww *default-listener-class*)))
                   (setq pos (search-for-def (fred-buffer ww) name type classes qualifiers))
                   (when pos
                     (window-select ww)
                     (ed-push-mark ww)
                     (window-scroll ww pos)
                     (return))))
               (when (not pos)
                 (edit-definition-error name classes qualifiers nil)))))
          (t (let ((*print-length* 3)(*print-level* 2))
               (ed-beep)
               (format t "~S not understood by edit definition." form))))
    (values files name)))

(defun edit-definition-error (name classes qualifiers file &optional file-not-found)
  (ed-beep)
  (when (eq t qualifiers)(setq qualifiers nil))
  (let ((*print-length* 3)
        (*print-level* 2))
    (if file
      (if file-not-found
        (format t "Can't find file ~s containing ~s~@[ with specializers ~s~]~@[ qualifiers ~s~]."
                file name classes qualifiers)
        (format t "Can't find ~s~@[ with specializers ~s~]~@[ qualifiers ~s~] in file ~s."
                name classes qualifiers file))
      (format t "There is no source file information for ~s~@[ with specializers ~s~]~@[ qualifiers ~s~]."
              name classes qualifiers))))

; symbol can be (setf blob)
(defun search-for-def (w symbol &optional type classes qualifiers)
  (let ((pos 0)(end (buffer-size w))
        (target (if (symbolp symbol) 
                  (symbol-name symbol)
                  (format nil "~A" symbol))))
    ; sigh -  consistency is the symptom of a weak mind
    ;(when (eq type 'structure)(setq target (%str-cat "(" target)))
    (search-for-def-sub w target type classes qualifiers pos end t)))


;; eschew this first and last stuff - do what lispm does - find all
;; and give the guy a way to bop through them with control-.
;; somebody is searching the listener if it aint found in file - is this reasonable?
;; ahh it searches the active window which is sometimes the listener
;; Sometimes we actually know that the thing is/was defined in the listener
;; Should we use this info?
;; also look top-level compiler-let?? generic-flet?? macrolet flet symbol-macrolet locally

(defparameter *search-top-level-forms*
  '(("eval-when" . 9)("progn" . 5)("locally" . 7)("macrolet" . 8)
    ("flet" . 4)("let" . 3)("let*" . 4)("symbol-macrolet" . 15)))

;; look for a defclass, then look within for target
(defun search-for-any-class (w target type classes qualifiers pos end toplevel)
  (let ((start-pos (search-for-def-sub w "" 'class nil nil pos end toplevel T))  ;; rats - search-for-def-sub will find last defclass
        end-pos)
    ;(print (list 'entry target type pos end start-pos))
    (when start-pos
      ;(print (list 'sp start-pos))
      (setq end-pos (buffer-fwd-sexp w start-pos))
      ;(print (list 'ep end-pos))
      (when end-pos
        (let ((found (buffer-forward-search w target start-pos end-pos)))
          ;(print (list target found))
          (when found (return-from search-for-any-class found))
          (search-for-any-class w target type classes qualifiers (1+ end-pos) end toplevel))))))

(defun search-for-def-sub (w target type classes qualifiers pos end toplevel &optional find-first)
  (let ((target-length (length target))
        char result)
    (while (and pos (< pos end))
      (setq pos (buffer-skip-fwd-wsp&comments w pos end))
      ; (print (list "after wsp" pos end))
      (when (memq type '(accessor slot-name)) ;(print (list 'cow pos end))
        (let ((foo (search-for-any-class w target 'class nil nil pos end toplevel)))
          (if foo (return-from search-for-def-sub foo))))
      (when (and pos  (< pos end))
        (case (setq char (buffer-char w pos))
          (#\#
           (if (< (+ pos 3) end)
             (case (setq char (buffer-char w (1+ pos)))
               (#\\ (setq pos (+ pos 3)))  ; just skip the char- dont care about #\return
               ((#\+ #\-) (setq pos (search-def-features w pos end char)))
               (t ; this is iffy
                (setq pos (buffer-fwd-sexp w (+ pos 2) end))))
             (setq pos nil)))
          (#\(
           (let* ((expend (buffer-fwd-up-sexp w (1+ pos) end))
                  (defend (buffer-fwd-symbol w (1+ pos) end))
                  before-d-e-f)
             (cond
              ((null expend)(setq result nil))
              ((or (and (buffer-substring-p w "def" (1+ pos))
                        (setq before-d-e-f (1+ pos)))
                   (setq before-d-e-f
                         (buffer-substring-with-package-p w "def" (1+ pos) defend 3)))
               (let* ((defstart pos)
                      (after-d-e-f (+ before-d-e-f 3))
                      (found-in-def nil)
                      (found-in-method-classes nil))
                 (setq pos (buffer-skip-fwd-wsp&comments w defend end))
                 (when (and (setq pos (buffer-delimited-substring-with-package-p
                                       w target pos expend target-length))
                            (or toplevel
                                ; be fussier when not toplevel? e.g. require newline
                                t)
                            (or (null type)
                                (setf found-in-def 
                                      (search-check-type w type after-d-e-f expend)))
                            (or (neq type 'method)
                                (setf found-in-method-classes
                                      (search-method-classes w classes qualifiers pos expend found-in-def defstart))))
                   (setq result (if (and found-in-method-classes
                                         (numberp found-in-method-classes))
                                  found-in-method-classes defstart)))))
              (t ; here want to look inside top level sexps - e.g. eval-when, progn
               ; is it reasonable to go only one level? - conditional on found already?
               (when (or ;toplevel ; dunno about this
                      (do ((thing *search-top-level-forms* (cdr thing)))
                          ((null thing) nil)
                        (when (buffer-delimited-substring-p
                               w (caar thing) (1+ pos) end (cdar thing))
                          (return t))))
                 (setq result
                       (or (search-for-def-sub w target type classes qualifiers
                                               (1+ pos) expend nil)
                           result)))))
                 ;(when (and pos expend (> pos expend)) (break))
                 (setq pos expend)))
             (t (setq pos (buffer-fwd-sexp w pos end char)))))
      (when (and pos result find-first)(return-from search-for-def-sub result)))
    (when (and (eq type 'structure)(not result)(neq  (schar target 0) #\())
      (setq result (search-for-def-sub w (%str-cat "(" target)
                                       type classes qualifiers pos end toplevel)))
    ;(print (list "exiting" result))(break)
    result))

; pos is after a "(" and end is after the matching ")"
; returns pos of beginning of str

; I assume caller has already tried buffer-substring-p and end is end of token
(defun buffer-substring-with-package-p (w str pos end strlen)
    (when
      (let ((send (%i+ strlen pos))
             colon-pos)
        (when end
          (cond ((%i< end send)
                 nil)
                (t (setq colon-pos (buffer-forward-search w ":" pos end))
                   (when (and colon-pos (eq (buffer-char w colon-pos) #\:))
                     (setq colon-pos (1+ colon-pos)))
                   (when colon-pos (setq pos colon-pos))
                   (buffer-substring-p w str pos)))))
     pos))

; returns pos of end of str
(defun buffer-delimited-substring-with-package-p (w str pos end &optional length)
  (when (null length)(setq length (length str)))
  (if (eq length 0)
    pos    
    (if (eq (schar str 0) #\()   ; special kludge for (setf blah) & strucs
      (if (buffer-substring-p w str pos)(%i+ pos length))    
      (let ((token-end (buffer-fwd-symbol w pos end))(send (%i+ pos length)) colon-pos)
        (when
          (cond ((%i< token-end send)
                 nil)
                ((eq token-end send)
                 (buffer-substring-p w str pos))
                (t (setq colon-pos (buffer-forward-search w ":" pos token-end))
                   (when colon-pos 
                     (when (eq (buffer-char w colon-pos) #\:)
                       (setq colon-pos (%i+ colon-pos 1)))
                     (setq pos colon-pos))
                   (when (eq (%i+ pos length) token-end)
                     (buffer-substring-p w str pos))))
          token-end)))))

; returns pos of end of str - needs an end arg so buff ending with "(defun foo" wont break
(defun buffer-delimited-substring-p (w string pos end &optional length &aux send)
  (when (null length)(setq length (length string)))
  (setq send (%i+ pos length))
  (and (buffer-substring-p w string pos)
       (or (eq end send)
           (%str-member (buffer-char w send) "()'
 ;#`\""))  ; '(#\( #\) #\' #\return #\space #\; #\# #\` #\")
       send))  

; do #+ #-
; this guys job is to return a pos that is either before or after the next form
; depending on whether or not the feature spec is true.
(defun search-def-features (w pos end char)
  ; pos is at the #
  (labels ((blob (thing)
               (cond ((consp thing)
                      (case (car thing)
                        (:or (do ((lst (cdr thing) (cdr lst)))
                                 ((null lst) nil)
                               (when (blob (car lst))
                                 (return t))))
                        (:and (do ((lst (cdr thing)(cdr lst)))
                                  ((null lst) t)
                                (when (not (blob (car lst)))
                                  (return nil))))
                        (:not (not (blob (cadr thing))))
                        (t nil)))
                     ((memq thing *features*) T))))
    (let ((fend (buffer-fwd-sexp w (+ pos 2) end)) foo true)
      (if (not fend)
        (+ pos 2)
        (progn (setq foo (ignore-errors 
                          (let ((*package* (find-package 'keyword)))
                            (read-from-string (buffer-substring w (+ pos 2) fend)))))
               (setq true (blob foo))
               (if (eq char #\-)(setq true (not true)))
               (if true
                 fend
                 (buffer-fwd-sexp w fend end)))))))

(defun add-definition-type (type-name after-def-string)
  ; possibly wiser to add new things at end
  (let ((thing (assq type-name *define-type-alist*)))
    (if (not thing)
      (push (list type-name after-def-string) *define-type-alist*)
      (let ((p (dolist (str (cdr thing))
                 (when (string-equal after-def-string str)
                   (return t)))))
        (if (not p)(rplacd thing (cons after-def-string (cdr thing))))))))		 
		 

(defparameter *define-type-alist*
  '((function "un" "macro" "ine-compiler-macro" "trap" "generic"
              #-bccl "nx1" #-bccl "nx2")
    (constant "constant")
    (variable "var" "parameter" "global")
    (class "class" "ine-condition")
    (method "method" "generic")
    (macro "macro") ; does this ever occur?
    (structure "struct")
    (lap "lapgen" "lapop")
    (method-combination "ine-method-combination")
    (method-combination-evaluator "ine-method-combination-evaluator")))

(defun search-check-type (w type pos end)
  (if (eq type t) t
      (let ((str (cdr (assq type *define-type-alist*))))
        (or (null str)
            (if (not (consp str))
              (buffer-delimited-substring-p w str pos end)
              (do ((s str (cdr s)))
                  ((null s) nil)
                (when (buffer-delimited-substring-p w (car s) pos end)
                  ;; (format t "~&Found ~A with ~A" type (first s))
                  (return (first s)))))))))

(defconstant +size-of-method-declaration+ 9
  "Just how big is '(:method ' anyway?")

(defun search-defgeneric (w classes qualifiers pos end)
  ;; skip generic arguments
  (setf pos (buffer-skip-fwd-wsp&comments w pos end))
  (setf pos (buffer-fwd-sexp w pos))
  (setf pos (buffer-skip-fwd-wsp&comments w pos end))
  ; (print (list pos (buffer-char w pos)))
  
  (loop while (and pos (< pos end)) do
        (when (buffer-substring-p w ":method" (1+ pos))
          (let ((result (search-method-classes 
                         w classes qualifiers
                         (+ pos +size-of-method-declaration+) end)))
            (when result (return-from search-defgeneric 
                           (- result +size-of-method-declaration+)))))
        (setf pos (buffer-fwd-sexp w pos))
        (setf pos (buffer-skip-fwd-wsp&comments w pos end))))



; called when smarter version fails - blind search
(defun search-for-def-dumb (w target type classes qualifiers pos end &optional dumber)  
   (when (null (stringp target))
     (setq target (if (symbolp target) (symbol-name target)(format nil "~A" target)))
     (when (eq type 'structure)(setq target (%str-cat "(" target))))
  (let ((target-length (length target))
        result)
    (while (and pos (< pos end))
      (setq pos (buffer-forward-search w "(def" pos end))
      (when pos
        (let* ((defstart (- pos 4))
               (after-d-e-f pos)
               (defend (buffer-fwd-symbol w (1- after-d-e-f) end)))
          (setq pos (buffer-skip-fwd-wsp&comments w defend end))
          (when (and (setq pos (buffer-delimited-substring-p w target pos end target-length))
                     (or (= defstart 0)
                         ; at least avoid finding (let ((def (blah))))
                         (memq (buffer-char w (1- defstart)) '(#\return #\linefeed #\space)))
                     (or (neq type 'method)
                         (search-method-classes w classes qualifiers pos end)))
            (setq result defstart))
          (setq pos defend))))
    (or result (when dumber
                 (setq result 0)
                 (while (setq result (buffer-forward-search w target result end))
                   (when  (%str-member  (buffer-char w result) symbol-specials)
                     (return-from search-for-def-dumb (- result target-length))))))))

; pos is after method name
#|
(defun search-method-classes (w classes qualifiers pos end)
  (let () ; eventually do all classes
    (when (and (setq pos (buffer-skip-fwd-wsp&comments w pos end))
               (cond 
                ((eq qualifiers t)
                 (while (eq (buffer-char w pos) #\:)   ; skip :before, :after, :around
                   (setq pos (buffer-fwd-symbol w pos end))
                   (setq pos (buffer-skip-fwd-wsp&comments w pos end)))
                 t)
                ((null qualifiers) t)
                ((and (eq (buffer-char w pos) #\:)
                      (setq pos (buffer-delimited-substring-p w (symbol-name (car qualifiers))
                                                         (1+ pos) end)))
                 (setq pos (buffer-skip-fwd-wsp&comments w pos end))))
               (eq (buffer-char w pos) #\( )
               ;(progn (print-db "Found the open paren") t)
               (setq pos (buffer-skip-fwd-wsp&comments w (1+ pos) end)))
      (or (eq classes t)
          (dolist (class classes t)                    
            (cond
             ((not (%str-member (buffer-char w pos) symbol-specials))
              (unless (and (eq class t) 
                           (setq pos (buffer-fwd-symbol w pos end)))
                (return nil)))
             (t (let ((class-name (if (classp class)(class-name class) class)))
                  (unless
                    (and (eq (buffer-char w pos) #\()
                         (setq pos (buffer-fwd-symbol w (1+ pos) end))
                         (setq pos (buffer-skip-fwd-wsp&comments w pos end))
                         ;(setq pos (buffer-delimited-substring-p w class-name pos end))
                         (if (symbolp class-name)
                           (let ((package (buffer-getprop w 'package)))
                             (when (not (typep package 'package)) (setq package (symbol-package class-name))) ;; ???
                             (and (eq class-name
                                      (buffer-current-symbol w pos pos nil package))
                                  (setq pos (buffer-fwd-symbol w pos end))))
                           (let ((str (format nil "~s" class-name)))  ; maybe its (eql foo)
                             (and (buffer-substring-p w str pos)
                                  (setq pos (+ pos (length str))))))
                         (setq pos (buffer-skip-fwd-wsp&comments w pos end))
                         (eq (buffer-char w pos) #\))
                         (setq pos (1+ pos)))
                    (return nil)))))
            (unless (setq pos (buffer-skip-fwd-wsp&comments w pos end))
              (return nil)))))))
|#

(defun search-method-classes (w classes qualifiers pos end &optional found-in-def result)
  (let ((original-pos pos))
    (cond ((and found-in-def (string-equal found-in-def "generic"))
           ;; we're in a defgeneric, do something special
           (values (search-defgeneric w classes qualifiers pos end)))
          (t
           (when (and (setq pos (buffer-skip-fwd-wsp&comments w pos end))
                      (cond 
                       ((eq qualifiers t)
                        (while (eq (buffer-char w pos) #\:)   ; skip :before, :after, :around
                          (setq pos (buffer-fwd-symbol w pos end))
                          (setq pos (buffer-skip-fwd-wsp&comments w pos end)))
                        t)
                       ((null qualifiers) t)
                       ((and (eq (buffer-char w pos) #\:)
                             (setq pos (buffer-delimited-substring-p w (symbol-name (car qualifiers))
                                                                     (1+ pos) end)))
                        (setq pos (buffer-skip-fwd-wsp&comments w pos end))))
                      (eq (buffer-char w pos) #\( )
                      ;(progn (print-db "Found the open paren") t)
                      (setq pos (buffer-skip-fwd-wsp&comments w (1+ pos) end)))
             (or (eq classes t)
                 (dolist (class classes (if result result original-pos))                    
                   (cond
                    ((not (%str-member (buffer-char w pos) symbol-specials))
                     (unless (and (eq class t) 
                                  (setq pos (buffer-fwd-symbol w pos end)))
                       (return nil)))
                    (t (let ((class-name (if (classp class) (class-name class) class)))
                         (unless
                           (and (eq (buffer-char w pos) #\()
                                (setq pos (buffer-fwd-symbol w (1+ pos) end))
                                (setq pos (buffer-skip-fwd-wsp&comments w pos end))
                                ;(setq pos (buffer-delimited-substring-p w class-name pos end))
                                (if (symbolp class-name)
                                  (let ((package (buffer-getprop w 'package))
                                        (this-symbol nil))
                                    (when (not (typep package 'package)) (setq package (symbol-package class-name))) ;; ???
                                    (setf this-symbol (buffer-current-symbol w pos pos nil package))
                                    (and (or (eq class-name
                                             this-symbol)
                                             (eq (find-class class-name nil) ; handle aliased class names
                                                 (find-class this-symbol nil)))
                                         (setq pos (buffer-fwd-symbol w pos end))))
                                  (let* ((target (cadr class-name))
                                         (str (if (and (eq (car class-name) 'eql)
                                                       (symbolp target)
                                                       (not (keywordp target))
                                                       (not (memq target '(t nil))))
                                                (format nil "(EQL '~S)" target)
                                                (format nil "~s" class-name))))
                                    (and (buffer-substring-p w str pos)
                                         (setq pos (+ pos (length str))))))
                                (setq pos (buffer-skip-fwd-wsp&comments w pos end))
                                (eq (buffer-char w pos) #\))
                                (setq pos (1+ pos)))
                           (return nil)))))
                   (unless (setq pos (buffer-skip-fwd-wsp&comments w pos end))
                     (return nil)))))))))





#|
; T if any "file" is a string rather than a pathname
(defun defined-in-listener-p (things)
  (dolist (ls things nil)
    (cond 
     ((null (consp (cdr ls)))
      (when (stringp (cdr ls))
        (return t)))
     (t (dolist (f (cdr ls))
          (cond ((consp f)  ; setf or method
                 (case (car f)
                   ((setf method)
                    (when (defined-in-listener-p (cdr f))
                      (return-from defined-in-listener-p t)))))
                (t (when (stringp f)(return-from defined-in-listener-p t)))))))))
|#

; deal with #<standard-method poo (bar)> - must be at start or end
(defun standard-method-kludge (w &optional pos)
  (let ((buf (fred-buffer w))
        name qual spec end)
    (ignore-errors
     (when (not pos)(setq pos (buffer-position buf)))
     (when (eq (buffer-char buf (1- pos)) #\>)
       (setq end (1- pos))
       (setq pos (1- (buffer-backward-find-char buf #\< end))))     
     (when (and pos (buffer-substring-p buf "#<STANDARD-METHOD " pos))
       (setq pos (+ pos 17))
       (when (not end)(setq end (buffer-forward-find-char buf #\>)))
       (multiple-value-setq (name pos)(buffer-read buf pos))
       (multiple-value-setq (qual pos)(buffer-read buf pos))
       (if  (< pos end)
         (setq spec (buffer-read buf pos))
         (progn (setq spec qual qual nil)))
       (find-method-by-names name (if qual (list qual)) spec)))))