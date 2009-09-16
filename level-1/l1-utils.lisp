;;;-*-Mode: LISP; Package: CCL -*-

;; new file - shared l1-utils stuff

;; mod history
;; fix stupid error in fix below
;; record-source-file - don't whine if slot-name or accessor multiply defined
;; ------- 5.1b1
;; 07/03/99 akh record-source-file does front window if no *enqueued-file-name*

#+allow-in-package
(in-package "CCL")

(setq *warn-if-redefine* nil)
(setq *record-source-file* t)

; Kluge for record-source-file bootstrapping

; Set T by l1-boot.lisp
(setq *level-1-loaded* nil)

(%fhave 'full-pathname (qlfun bootstrapping-full-pathname (name) name))

(%fhave '%source-files (qlfun bootstrapping-%source-files (name)
                         (get name 'bootstrapping-source-files)))
(%fhave '%set-source-files (qlfun bootstrapping-%set-source-files (name value)
                             (put name 'bootstrapping-source-files value)))





; real one is  in setf.lisp
(%fhave '%setf-method (qlfun bootstripping-setf-fsname (spec)
                                   spec nil))

; this new thing breaks for case of a function being defined in non-file place
; use some euphemism for that such as t or "{No file}"
; something is broken (probably) here calling assq with garbage



(defun source-file-or-files (symbol type setf-p method)
  (let ((source-files-info (%source-files symbol))    
        assoc-pair files)
    (cond ((null (consp source-files-info))
           (values source-files-info
                   nil
                   (if (and source-files-info (eq type 'function)(not setf-p)) source-files-info)))
          (t (setq assoc-pair (assq type (if setf-p
                                           (cdr (assq 'setf source-files-info))
                                           source-files-info)))
             (if (neq type 'method)
               (setq files assoc-pair)
               (setq files
                     (do* ((lst (cdr assoc-pair) (cdr lst))
                           (clst (car lst)(car lst)))
                          ((null lst) nil)
                       (when (consp clst)
                         (when (or (eq method (car clst))  ; method is a place holder for q's and s's 
                                   (and (methods-congruent-p method (car clst))
                                        ; below avoids clutter
                                        (rplaca clst method)))
                           (return clst))))))
             (values source-files-info assoc-pair files)))))

; warn if defining in no file iff previously defined in a file (i.e. dont
; warn every time something gets redefined in the listener)
; fix to not to bitch if file is anywhere in list
; name is function-name or (method-name (class-names)) or ((setf method-name) (class-names))
; store('method (method file  file) (method file file) ...)
; if type is 'method we expect name to be an actual method
; Remember to smash old methods with newer methods to avoid clutter - done

(defun physical-pathname-p (file)(declare (ignore file)) nil) ; redefined later


;(%defvar *enqueued-window-title* nil)

(defun booted-probe-file (file)
  (declare (ignore file))
  nil)

(queue-fixup
 (defun booted-probe-file (file)
   (probe-file file)))



(defun record-source-file (name def-type
                                &optional (file-name *loading-file-source-file*))
  (declare (special *enqueued-window-title*))
  ;(print (list file-name *load-pathname* *load-truename*))
  (when nil ; (and file-name (not (probe-file file-name)) *load-pathname*)
    (let ((alt (merge-pathnames *.lisp-pathname* *load-pathname*)))
      (when (probe-file alt)(setq file-name alt))))  
  (let (symbol setf-p method old-file)
    (flet ((same-file (x y)
             (or (eq x y)
                 ; funny because equal not defined before us
                 (and x y (or (equal x y)
                              (equal (or (booted-probe-file x) (full-pathname x))
                                     (or (booted-probe-file y) (full-pathname y))))))))
      (when (null file-name)
        (setq file-name (or (and (boundp '*enqueued-window-title*)
                                 *enqueued-window-title*)
                            (let* ((c (find-class 'fred-window nil))
                                   (w (when c (front-window :class 'fred-window))))
                              (when w  (window-title w)))))
        #| ; this was brain dead if a warning happened - making listener the front window
        (let* ((c (find-class 'fred-window nil))
               (w (when c (front-window :class 'fred-window))))
          (when w (setq file-name (window-title w))))|#
        )     
      (when (and *record-source-file* ) ;file-name)
        (when (and file-name (physical-pathname-p file-name))
          (setq file-name (namestring (back-translate-pathname file-name)))  ; namestring ??
          (cond ((equalp file-name *last-back-translated-name*)
                 (setq file-name *last-back-translated-name*))
                (t (setq *last-back-translated-name* file-name))))
        (when (eq t def-type) (report-bad-arg def-type '(not (eql t))))
        (cond ((eq def-type 'method)
               (setq method name symbol (%method-name name) name nil))
              ((consp name)
               (cond ((neq (car name) 'setf)
                      (warn "record-source-file hates ~s" name))
                     (t (setq symbol name))))
              ((symbolp name) (setq symbol name)))
        (cond ((and (consp symbol)(eq (car symbol) 'setf))
               (let ((tem (%setf-method (cadr symbol))))
                 (if tem 
                   (setq symbol tem)
                   (progn (setq symbol (cadr symbol))
                          (setq setf-p t))))))
        ; assoc-pair is e.g. (function file1 ...) or (class . file)
        ; or (method (method-object  file1 ...) ...) or (method (method-object . file) ...)
        (when (symbolp symbol)  ; avoid boot problems - you thought          
          (multiple-value-bind (source-files-info assoc-pair files)
                               (source-file-or-files symbol def-type setf-p method)                                             
            (setq old-file 
                  (cond ((consp files)
                         (if (consp (cdr files)) (cadr files) (cdr files)))
                        (t files)))
            (unless
              (if (or (not (consp files))(not (consp (cdr files))))
                (same-file old-file file-name)
                (do ((lst (cdr files)(cdr lst)))
                    ((null (consp lst)) nil) 
                  (when (same-file file-name (car lst))
                    (rplaca lst (cadr files))
                    (rplaca (cdr files) file-name)
                    (return t))))
              (when (and *warn-if-redefine*
                         (not (memq def-type '(method slot-name accessor)))   ; This should be more specific
                         (cond ((eq def-type 'function)
                                (and (fboundp name) old-file))
                               (t old-file)))
                (warn " ~S ~S previously defined in: ~A
         is now being redefined in: ~A~%"
                      def-type
                      name
                      (or old-file "{Not Recorded}")
                      (or file-name "{No file}")))
              (if (consp files)
                (%rplacd files (cons file-name 
                                     (if (consp (cdr files))(cdr files)(list (cdr files)))))
                
                (if assoc-pair
                  (%rplacd assoc-pair (cons (if (eq def-type 'method)
                                              `(,method . , file-name)
                                              file-name)
                                            (if (consp (%cdr assoc-pair))
                                              (%cdr assoc-pair)
                                              (list (%cdr assoc-pair)))))
                    (%set-source-files
                     symbol
                     (cond ((and (eq def-type 'function)
                                 (null setf-p)
                                 (not (consp  source-files-info)))
                            (if (null old-file)
                              file-name
                              `((function ,file-name ,old-file))))
                           (t
                            (when (and source-files-info
                                       (not (consp source-files-info)))
                              (setq source-files-info `((function . , source-files-info))))
                            (let ((thing (if (neq def-type 'method) 
                                             `(,def-type . ,file-name)
                                             `(,def-type (,method . ,file-name)))))
                              (cons (if setf-p `(setf ,thing) thing) source-files-info))))))))
))))))


(record-source-file 'record-source-file 'function)


(defun inherit-from-p (ob parent)
  (memq (if (symbolp parent) (find-class parent nil) parent)
        (%inited-class-cpl (class-of ob))))

; returns new plist with value spliced in or key, value consed on.
(defun setprop (plist key value &aux loc)
 (if (setq loc (pl-search plist key))
  (progn (%rplaca (%cdr loc) value) plist)
  (cons key (cons value plist))))

(defun getf-test (place indicator test &optional default)
  (loop
    (when (null place)
      (return default))
    (when (funcall test indicator (car place))
      (return (cadr place)))
    (setq place (cddr place))))

(defun setprop-test (plist indicator test value)
  (let ((tail plist))
    (loop
      (when (null tail)
        (return (cons indicator (cons value plist))))
      (when (funcall test indicator (car tail))
        (setf (cadr tail) value)
        (return plist))
      (setq tail (cddr tail)))))



(defun plistp (p &aux len)
  (and (listp p)
       (setq len (list-length p))
       (not (%ilogbitp 0 len))))  ; (evenp p)

(defun %imax (i1 i2)
 (if (%i> i1 i2) i1 i2))

(defun %imin (i1 i2)
  (if (%i< i1 i2) i1 i2))

(defun nremove (elt list)
  (let* ((handle (cons nil list))
         (splice handle))
    (declare (dynamic-extent handle))
    (loop
      (if (eq elt (car (%cdr splice)))
        (unless (setf (%cdr splice) (%cddr splice)) (return))
        (unless (cdr (setq splice (%cdr splice)))
          (return))))
    (%cdr handle)))


#| ;; to l1-utils-ppc
(defun %define-symbol-macro (name expansion)
  (let ((info (make-symbol-macro-info name expansion)))
    ;; check for special - should do vv too
    (when (nx-proclaimed-special-p name)
      (error "Can't define symbol macro for special variable ~S ." name))
    (pushnew info
             *nx-symbol-macros*
             :test  #'(lambda (x y) 
                        (and (eq (var-name x)
                                 (var-name y))
                             (equal (var-ea x) (var-ea y)))))))
|#