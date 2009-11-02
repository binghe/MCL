;; Set the RMCL version resource to the lisp implementation version, rather than the other way around.;; Provides a new application-version-string method like in Clozure to customize the version string for applications.;; See Issue #15: http://code.google.com/p/mcl/issues/detail?id=15;;;; Terje Norderhaug, November 2009.;; terje@in-progress.com(in-package :ccl)(defvar *mcl-revision* (with-open-file (in "ccl:.hg;branchheads.cache" :if-does-not-exist nil)                               (when in                                 (subseq (read-line in) 0 10))))
(defmethod application-version-string ((a application))  NIL)(defmethod application-version-string ((a lisp-development-system))  (concatenate 'string   (lisp-implementation-version-less-patch)   (when *new-lisp-patch-version*     (format nil "p~A" *new-lisp-patch-version*))))#+ignore(defmethod application-name ((app lisp-development-system))  (get-app-name))(defun new-version-resource ()
  (let ((version-string (application-version-string *application*)))
    (when version-string
      (let ((resh (%null-ptr))
            (curfile (#_CurResFile))
            oldsize)
        (unwind-protect
          (progn 
            (#_UseResFile (#_LMGetCurApRefNum))
            (%setf-macptr resh (#_Get1Resource :|vers| 1))
            (unless (%null-ptr-p resh)
	      (#_LoadResource resh)
              (setq oldsize (#_GetHandleSize resh))              
              (with-dereferenced-handles ((r resh))
                (let* ((len1 (%get-byte r 6))
                       (str1 version-string)
                       (str2 (%get-string r (+ 7 len1)))
                       (delta (- (length str1) len1)))
                  (setq str2 (%str-cat str1 (%substr str2 len1 (length str2))))
                  (let ((newres (#_NewHandle :errchk (+ oldsize delta delta))))
                    (with-dereferenced-handles ((p newres))
                      (dotimes (i 3)
                        (declare (fixnum i))
                        (%put-word p (%get-word r (+ i i)) (+ i i)))
                      (%put-string p str1  6)
                      (%put-string p str2 (+ 7 (length str1))))
                    (list newres :|vers| 1))))))
          (#_UseResFile curfile)))))); (new-version-resource)