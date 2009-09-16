;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  5 3/2/95   akh  use application-file-creator
;;  4 2/22/95  slh  added SourceServer; removed PRINTs
;;  3 2/17/95  akh  make it work by spelling "ckid" correctly
;;  2 2/10/95  akh  dont delete fred or mpsr, do delete ckid and just reset size, pos etc. in mpsr
;;  (do not edit before this line!!)

; ship-files.lisp
; Remove the font & position resources from distribution source files.
; (SHIP-FILES)

; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

; Modification History
;
; use path-to-fsref vs %path-to-iopb
; ------ 5.1 final
; 04/08/97 bill  remove-fred-resources isn't so eager to call mac-namestring.
;                with-preserved-file-info doesn't like to see unquoted "*"'s in name strings.
; -------------  4.1b1
;  4/12/96 slh   added do-text-files
; 11/29/95 bill  new trap names.
;  2/22/95 slh   added SourceServer dir; removed spurious PRINT
; 11/19/91 bill  remove-resource -> remove-resource-if-found to
;                prevent name conflict with "ccl:library;resources.lisp"
; 11/13/91 bill  Correct default directories to ship-files
; 08/24/91 gb    no more old trap syntax.
; 07/21/91 gb    no more DOWNWARD-FUNCTION.
; 04/16/91 bill  pass VERBOSE parameter from SHIP-FILES to SHIP-FILE
; 04/03/91 bill  normalize type & creator
; 02/07/91 alice ccl; => ccl:

(in-package :ccl)


#|
(defmacro with-preserved-file-info (file &body body)
  (let* ((temp (gensym)))
    `(let* ((,temp #'(lambda () ,@body)))
       (declare (dynamic-extent ,temp))
       (call-with-preserved-file-info ,file ,temp))))

(defun call-with-preserved-file-info (file chunk)
  (%stack-iopb (pb np)
    (unwind-protect
      (progn
        (%path-to-iopb file pb t)  ;; this is gone now
        (%put-word pb 0 $ioFDirIndex)
        (let ((dirid1 (%get-word pb $ioDirID1))
              (dirid2 (%get-word pb $ioDirID2)))
          (file-errchk (#_PBHGetFInfoSync pb) file)
          (%put-word pb dirid1 $ioDirID1)
          (%put-word pb dirid2 $ioDirID2))        
        (funcall chunk))
      (file-errchk (#_PBHSetFInfoSync pb) file))))
|#

(defun remove-unwanted-resources (filename &optional allow-date-change)
  (setq filename (or (probe-file (merge-pathnames filename ".lisp"))
                     (error "No such file: ~s" filename)))
  (rlet ((fsref :fsref))
    (path-to-fsref filename fsref)
    (flet ((doit ()
             (let ((refnum -1))
               (unwind-protect
                 (unless (eq -1 (setq refnum (open-resource-file-from-fsref fsref #$fsrdwrperm)))
                   (#_UseResFile refnum)
                   (with-macptrs ((rsrc (#_Get1Resource "ckid" 128)))
                     (when (not (%null-ptr-p rsrc))
                       (#_RemoveResource rsrc)))
                   (reset-size-pos-etc))
                 (unless (eq -1 refnum)                    
                   (#_CloseResFile refnum))))))
      (declare (dynamic-extent #'doit))
      (if allow-date-change
        (doit)
        (rlet ((catinfo :fscataloginfo)) 
          (fsref-get-cat-info fsref catinfo #$kFSCatInfoAllDates)
          (doit)
          (fsref-set-cat-info fsref catinfo #$kFSCatInfoAllDates))))))
;; (with-preserved-file-info filename (doit)))


(defun reset-size-pos-etc ()
  (with-macptrs (rsrc)
    (%setf-macptr rsrc (#_Get1Resource "MPSR" 1005))
    (unless (%null-ptr-p rsrc)
      (#_LoadResource rsrc)
      (with-dereferenced-handles ((rp rsrc))
        (setf (%get-long rp 38) *window-default-position*
              (%get-long rp 42) (add-points *window-default-position*
                                            *window-default-size*)
              (%get-long rp 58) 0  ; pos
              (%get-long rp 62) 0  ; end sel
              (%get-long rp 66) 0)) ; display start
      (#_ChangedResource rsrc))))

(defun remove-resource-if-found (ostype index)
  (with-macptrs ((rsrc (#_GetResource ostype index)))
    (unless (%null-ptr-p rsrc)
      (#_RemoveResource rsrc)
      (#_DisposeHandle rsrc)
      t)))

(defun ship-file (file &optional verbose)
  (if verbose (print file))
  (remove-unwanted-resources file)
  (set-mac-file-type file :TEXT)
  (set-mac-file-creator file (application-file-creator *application*))
  file)

(defun ship-files (&key verbose
                        (directories
                         '("ccl:compiler;**;"
                           "ccl:examples;**;"
                           "ccl:interface tools;**;"
                           "ccl:level-1;"
                           "ccl:lib;**;"
                           "ccl:library;**;"
                           "ccl:interfaces;**;"
                           "ccl:inspector;**;"
                           "ccl:series;**;"
                           "ccl:SourceServer;**;")))
  (flet ((ship-directory (dir)
           (dolist (file (directory (merge-pathnames "*.lisp" dir)))
             (ship-file file verbose))))
    (mapcar #'ship-directory
            (if (listp directories) directories (list directories))))
  t)

(defvar *shipping-files* nil)

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))
  (defun %path-mac-namestring (name)
    (when (%path-mem-last-quoted ":" name)
      (signal-file-error $xbadfilenamechar name #\:))
    (unless *shipping-files*
      (when (%path-mem-last "*" name)
        (signal-file-error $xillwild name)))
    (%path-std-quotes name "" ""))
  )

(defun do-text-files (dir &key (verbose t))
  (let ((*shipping-files* t))
    (flet ((text-file-p (file)
             (eq (mac-file-type file) :text)))
      (declare (dynamic-extent #'text-file-p))
      (dolist (file (directory dir :test #'text-file-p))
        (ship-file file verbose))))
  t)


#| le grande enchilada...

(do-text-files "mcl sources:MCL-PPC 3.9f1c1:**:*")

(do-text-files "bigzoe-real:MCL 4.3b3:**:*")

(ship-files :verbose t
            :directories
            '("ccl:build;**;"
              "ccl:compiler;**;"
              "ccl:examples;**;"
              "ccl:fixedcontribs;**;"
              "ccl:help-maker;**;"
              "ccl:interface tools;**;"
              "ccl:level-1;"
              "ccl:lib;**;"
              "ccl:library;**;"
              "ccl:lispdcmds;**;"
              "ccl:pinterface translator;**;"
              "ccl:ptable-sources;**;"
              "ccl:series;**;"
              "ccl:SourceServer;**;"
              "ccl:swapping;**;"
              "ccl:tests;**;"
              "ccl:wood;**;"
              "ccl:xdump;**;"
              ))
|#

; End of ship-files.lisp
