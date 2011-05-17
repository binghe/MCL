;;-*- mode: lisp; package: ccl -*-;; Don't fail when using logical pathnames with a pathname-version "newest". ;; May 2011.Terje Norderhaug <terje@in-progress.com>;; License: LLGPL.(in-package :ccl)#| DESCRIPTION:The usocket library uses pathname version :newest and defines a logical pathname translation for it.However, MCL doesn't properly resolve these logical pathnames.Calling full-pathname for a logical pathname with a version "newest" component returns NIL.This causes probe-file for such pathnames to fail, reporting that NIL is not of the expected type (OR STRING ENCODED-STRING PATHNAME STREAM).(setf (logical-pathname-translations "usocket")
      `(("**;*.*.NEWEST" ,(loading-file-source-file))
        ("**;*.*" ,(loading-file-source-file))))
(defparameter *pathnm* (make-pathname :name "usocket" :type "lisp"))(defparameter *newest* (make-pathname :name "usocket" :type "lisp" :version "NEWEST"))(full-pathname (make-pathname :name "usocket" :type "lisp"))(full-pathname (make-pathname :name "usocket" :type "lisp" :version "NEWEST"))Hyperspec says:valid pathname version n.: a non-negative integer, or one of :wild, :newest, :unspecific, or nil. The symbols :oldest, :previous, and :installed are semi-standard special version symbols. http://clhs.lisp.se/Body/26_glo_v.htm#valid_pathname_version|#; new, like %std-directory-component:(defun %std-version-component (version)  (typecase version    ((eql :newest) "newest")    (fixnum (%integer-to-string version))    (otherwise version))) (let ((*warn-if-redefine* nil)      (*warn-if-redefine-kernel* nil))(defun pathname-match-p (pathname wildname)
  (let ((path-host (pathname-host pathname))
        (wild-host (pathname-host wildname)))    
    (and
     (%component-match-p path-host wild-host)
     (%component-match-p (pathname-device pathname)(pathname-device wildname))
     (%pathname-match-directory
      (%std-directory-component (pathname-directory pathname) path-host)
      (%std-directory-component (pathname-directory wildname) wild-host))
     (%component-match-p (pathname-name pathname)(pathname-name wildname))
     (%component-match-p (pathname-type pathname)(pathname-type wildname))     (%component-match-p       (%std-version-component (pathname-version pathname))      (%std-version-component (pathname-version wildname))))))(defun translate-pathname (source from-wildname to-wildname &key reversible)
  (when (not (pathnamep source))(setq source (pathname source)))
  (flet ((foo-error (source from)
                    (error "Source ~S and from-wildname ~S do not match" source from)))
    (let (r-host r-device r-directory r-name r-type r-version s-host f-host t-host)
      (setq s-host (pathname-host source))
      (setq f-host (pathname-host from-wildname))
      (setq t-host (pathname-host to-wildname))
      (if (not (%component-match-p s-host f-host))(foo-error source from-wildname))
      (setq r-host (translate-component s-host f-host t-host reversible))
      (let ((s-dir (%std-directory-component (pathname-directory source) s-host))
            (f-dir (%std-directory-component (pathname-directory from-wildname) f-host))
            (t-dir (%std-directory-component (pathname-directory to-wildname) t-host)))
        (let ((match (%pathname-match-directory s-dir f-dir)))
          (if (not match)(foo-error source from-wildname))
          (setq r-directory  (translate-directory s-dir f-dir t-dir reversible t-host))))
      (let ((s-name (pathname-name source))
            (f-name (pathname-name from-wildname))
            (t-name (pathname-name to-wildname)))
        (if (not (%component-match-p s-name f-name))(foo-error source from-wildname))        
        (setq r-name (translate-component s-name f-name t-name reversible)))
      (let ((s-type (pathname-type source))
            (f-type (pathname-type from-wildname))
            (t-type (pathname-type to-wildname)))
        (if (not (%component-match-p s-type f-type))(foo-error source from-wildname))
        (setq r-type (translate-component s-type f-type t-type reversible)))
      (let ((s-version (%std-version-component (pathname-version source)))
            (f-version (%std-version-component (pathname-version from-wildname)))
            (t-version (%std-version-component (pathname-version to-wildname))))
        (if (not (%component-match-p s-version f-version))(foo-error source from-wildname))
        (setq r-version (translate-component s-version f-version t-version reversible))
        ;(if (eq r-version :unspecific)(setq r-version nil))
        )
      (make-pathname :device r-device :host r-host :directory r-directory
                     :name r-name :type r-type :version r-version :defaults nil)
      )))
#+ignore(defun translate-logical-pathname (pathname &key)
  (setq pathname (pathname pathname))
  (let ((host (pathname-host pathname)))
    (if (or (null host) (eq host :unspecific))
      (if (logical-pathname-p pathname)
        (%cons-pathname (pathname-directory pathname)(pathname-name pathname) (pathname-type pathname))
        pathname)
      (let ((rule (assoc pathname (logical-pathname-translations host)
                         :test #'pathname-match-p)))  ; how can they match if hosts neq??
        (if rule
          (translate-logical-pathname
           (translate-pathname pathname (car rule) (cadr rule)))
          (signal-file-error $xnotranslation pathname))))))
#+ignore(defun full-pathname (path &key (no-error t))
  (let ((orig-path path))
    (cond (no-error
           ; note that ignore-errors wont work until var %handlers% is defined (in l1-init)
           (setq path (ignore-errors
                       (translate-logical-pathname (merge-pathnames path))))
           (when (null path) (return-from full-pathname nil)))
          (t (setq path (translate-logical-pathname (merge-pathnames path)))))
    (let* ((ihost (pathname-host orig-path))
           (dir (%pathname-directory path)))
      (when (and no-error (not dir) (%pathname-directory path)) ; WHAT is  that noop - since 3.0??
        (return-from full-pathname nil))
      (when (and ihost (neq ihost :unspecific))  ; << this is new. is it right?
        (if (eq (car dir) :relative)  ; don't make relative to mac-default-dir if had a host???
          (setq dir (cons :absolute (cdr dir)))))
      (setq dir (absolute-directory-list dir))      
      (unless (eq dir (%pathname-directory path))
        (setq path (cons-pathname dir (%pathname-name path) (%pathname-type path)
                                  (pathname-host path) (pathname-version path))))
      path)))
)