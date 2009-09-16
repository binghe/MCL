;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 3/2/95   akh  say 'base-character
;;  1 2/15/95  slh  moved from expamples, for boyer-moore.lisp
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; mac-file-io.lisp
;;
;;Copyright 1990-1994, Apple Computer, Inc
;;Copyright 1995-1999, Digitool, Inc
;;

;; This file implements something similar to the high-level file I/O
;; primitives in Inside Macintosh.
;; It does NOT support asynchronous I/O (and neither does the Macintosh, really).

;; Routines that take an errorp parameter will signal an error if
;; the parameter is unspecified or true, otherwise, if there is an
;; error they return two values: NIL & the error number.
;; If there is no error, routines return one or more values the
;; first of which is non-NIL.

;;;;;;;;;;;;;
;;
;; Modification History
;;
;; with-fsopen-file - stack allocate fsref and paramblock
;; fsopen-file-p - only cons paths if this is called which is unlikely
;; ------ 5.2b5
;; add macro with-fsopen-file-no-error-on-close
;; fsclose - don't #_disposeptr if error
;; ------- 5.2b4
;; fix getvinfo for new interfaces- but still sort of obsolete
;; 07/06/05 FSClose - do #_disposeptr fsref
;; -------- 5.1 final
;; I think setfpos was broken
;; fix getEOF to not clobber fpos
;; -------- 5.1b1
;; use fsref and fsforkioparam for long files and unicode/long names - GetVinfo ain't converted
;; ---------- 5.0 final 
;; 04/14/99 fsread and write dont make new macptr when offset is 0
;;------------ 4.3b1
;;  1/05/96 bill #_GetEOF -> #_PBGetEOFSync
;;  5/30/95 slh  added with-FSOpen-file-noerr
;;  4/03/95 slh  GetVInfo: fixed free space calculation (use %get-unsigned-XXX).
;;  2/15/95 slh  moved to lib
;; ------------- 3.0d17
;; 03/24/92 wkf  Added GetVInfo lisp version based on Inside Mac Volume IV p107
;; ------------- 2.0
;; 02/27/92 bill fsopen returns a useful value again.
;; 02/23/92 gb   Use newer traps, records, constants.
;; 02/12/92 bill fsopen gets a resolve-aliases-p parameter
;; ------------- 2.0f2
;; 12/31/91 bill use ccl::%err-disp in maybe-file-error
;; ------------- 2.0b4
;; 10/08/91 bill Move to CCL package
;; 09/05/91 bill no longer (require :records)
;; 08/24/91 gb   Use new trap syntax so no more 1.3.2.
;; 08/19/91 bill in FSOpen: (%put-word paramBlock $fsAtMark $ioPosOffset) ->
;;                          (%put-word paramBlock $fsAtMark $ioPosMode)
;;               (thanx to Dale J. Skrien)
;;

(in-package :ccl)

(eval-when (:compile-toplevel :execute)
  (require 'sysequ))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(with-FSOpen-file FSOpen FSClose FSRead FSWrite setFPos getFPos getEOF)))

#|
(defmacro with-FSOpen-file ((pb filename &optional read-write-p (vrefnum 0))
                            &body body)
  `(let ((,pb (FSOpen ,filename ,read-write-p ,vrefnum)))
     (unwind-protect
       (progn ,@body)
       (FSClose ,pb))))
|#

(defmacro with-FSOpen-file ((pb filename &optional read-write-p (vrefnum 0) )
                             &body body)
  (declare (ignore vrefnum))
  (let ((fsrefsym (gensym)))
    `(rletZ ((,pb :fsforkioparam)
             (,fsrefsym :fsref))
       (let ((,pb (FSOpen2 ,filename ,read-write-p ,pb ,fsrefsym)))
         (unwind-protect
           (progn ,@body)
           (FSClose2 ,pb))))))

#|
(defmacro with-FSOpen-file-no-error-on-close ((pb filename &optional read-write-p (vrefnum 0))
                            &body body)
  `(let ((,pb (FSOpen ,filename ,read-write-p ,vrefnum)))
     (unwind-protect
       (progn ,@body)
       (FSClose ,pb nil))))
|#

(defmacro with-FSOpen-file-no-error-on-close ((pb filename &optional read-write-p (vrefnum 0) )
                             &body body)
  (declare (ignore vrefnum))
  (let ((fsrefsym (gensym)))
    `(rletZ ((,pb :fsforkioparam)
             (,fsrefsym :fsref))
       (let ((,pb (FSOpen2 ,filename ,read-write-p ,pb ,fsrefsym)))
         (unwind-protect
           (progn ,@body)
           (FSClose2 ,pb nil))))))



(defmacro with-FSOpen-file-noerr ((pb filename &optional read-write-p (vrefnum 0))
                                  &body body)
  `(let ((,pb (ignore-errors
               (FSOpen ,filename ,read-write-p ,vrefnum))))
     (when ,pb
       (unwind-protect
         (progn ,@body)
         (FSClose ,pb)))))


(defloadvar *fsopen-files* nil)

;; return paramblock for file if open by fsopen
#|
(defun fsopen-file-p (file)
  (let ((true (truename file)))
    (cdr (assoc true *fsopen-files* :test #'equal))))
|#

;; not used, not exported
(defun fsopen-file-p (file)
  (let ((true (truename file)))
    (dolist (foo *fsopen-files* nil)
      (let ((path (car foo)))
        (when (or (not (pathnamep path))(logical-pathname-p path))
          (setq path (probe-file path))
          (rplaca foo path))
        (if (equal true path)(return (cdr foo)))))))

(defun FSOpen (filename &optional read-write-p (vrefnum 0) (errorp t)
                        (resolve-aliases-p t))
  (declare (ignore vrefnum resolve-aliases-p))
  ;(when resolve-aliases-p (setq filename (truename filename))) ;; resolve better be true
  (let ((fsref (make-record (:FSRef :clear t)))
        (paramblock (make-record (:fsforkioparam :clear t))))
    (fsopen2 filename read-write-p paramblock fsref errorp)))

(defun FSOpen2 (filename read-write-p paramblock fsref &optional (errorp t))
  (let ((fname  (data-fork-name))
        (ok nil))
    (multiple-value-bind (resref is-dir is-alias)(if errorp (path-to-fsref filename fsref) ;; might error
                                                     (ignore-errors (path-to-fsref filename fsref)))
      (cond ((null resref) (maybe-file-error errorp $fnferr filename))
            (is-dir (maybe-file-error errorp $xdirnotfile filename))
            (t (setf (pref paramblock :FSForkIOParam.ref) fsref
                     (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)
                     (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
                     (pref paramblock :FSForkIOParam.permissions) (if read-write-p #$fsrdwrperm #$fsrdperm))
               (let ((res (#_PBOpenForkSync paramblock)))                
                 (if (eql #$noErr res)
                   (setq ok t)
                   (maybe-file-error errorp res filename)))))
      (when ok 
        (push (cons (if is-alias (%path-from-fsref resref) filename) paramblock) *fsopen-files*)
        paramblock))))

; Returns an fsforkioparam for doing furthur I/O with the file
#|
(defun FSOpen (filename &optional read-write-p (vrefnum 0) (errorp t)
                        (resolve-aliases-p t))
  (declare (ignore vrefnum resolve-aliases-p))
  ;(when resolve-aliases-p (setq filename (truename filename))) ;; resolve better be true
  (let ((fsref (make-record (:FSRef :clear t)))
        (paramblock (make-record (:fsforkioparam :clear t)))
        (fname  (data-fork-name))
        (ok nil))
    (unwind-protect
      (multiple-value-bind (resref is-dir)(if errorp (path-to-fsref filename fsref) ;; might error
                                              (ignore-errors (path-to-fsref filename fsref)))
        (cond ((null resref) (maybe-file-error errorp $fnferr filename))
              (is-dir (maybe-file-error errorp $xdirnotfile filename))
              (t (setf (pref paramblock :FSForkIOParam.ref) fsref
                       (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)
                       (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
                       (pref paramblock :FSForkIOParam.permissions) (if read-write-p #$fsrdwrperm #$fsrdperm))
                 (let ((res (#_PBOpenForkSync paramblock)))                
                   (if (eql #$noErr res)
                     (setq ok t)
                     (maybe-file-error errorp res filename)))))
        (when ok 
          ;; dont cons path unless needed - unlikely that it is
          ;(push (cons (%path-from-fsref resref) paramblock) *fsopen-files*)
          (push (cons nil paramblock) *fsopen-files*)          
          paramblock))
      (when (not ok)
        (#_DisposePtr (pref paramblock :FSForkIOParam.ref))
        (#_disposeptr paramblock)))))  ;; flush the fsref too? - the paramblock aint disposed when other errors - probably correct
|#


(defun pb-locked-p (paramblock)
  (with-macptrs ((fsref (pref paramblock :fsforkioparam.ref)))
    (let ((bits (fsref-node-bits fsref)))
      (logbitp #$kFSNodeLockedBit bits))))

(defun pb-unlock (paramblock)
  (with-macptrs ((fsref (pref paramblock :fsforkioparam.ref)))
    (unlock-file-fsref fsref)))


(defun FSClose2 (paramblock &optional (errorp t))
  (let ((errnum (#_PBCloseforkSync paramBlock)))
    (let ((foo (rassoc paramblock *fsopen-files*)))
      (when foo (setq *fsopen-files* (delete foo *fsopen-files*))))    
    (or (eql errnum #$noErr)
        (maybe-file-error errorp errnum))))

(defun FSClose (paramblock &optional (errorp t))
  (let ((errnum (#_PBCloseforkSync paramBlock)))
    (let ((foo (rassoc paramblock *fsopen-files*)))
      (when foo (setq *fsopen-files* (delete foo *fsopen-files*))))
    (when (eql errnum #$noErr) 
      (#_DisposePtr (pref paramblock :FSForkIOParam.ref))
      (#_DisposePtr paramBlock))
    (or (eql errnum #$noErr)
        (maybe-file-error errorp errnum))))

;; avoid consing a macptr
(defmacro paramblock-position (paramblock)
  `(with-macptrs ((foo (pref ,paramblock :FSForkIOParam.positionOffset)))
     (unsignedwide->integer foo)))


; Returns two values: the number of bytes actually read, and the
; location of the file mark.
(defun fsRead (paramBlock count buffer &optional (offset 0) (errorp t))
  (setf (pref paramblock :fsforkioparam.buffer)  (if (eq offset 0) buffer (%inc-ptr buffer offset))
        (pref paramblock :FSForkIOParam.requestCount) count
        (pref paramblock :FSForkIOParam.positionMode) #$fsAtMark) ;; was from start
  (let ((errnum (#_PBReadForkSync paramBlock)))
    (setf (pref paramblock :FSForkIOParam.positionMode) #$fsAtMark)
    (let ()
      (if (or (eql #$noErr errnum) (eql #$eofErr errnum))
        (values (pref paramblock :FSForkIOParam.actualCount)
                (paramblock-position paramblock)) ;(unsignedwide->integer (pref paramblock :FSForkIOParam.positionOffset)))
        (maybe-file-error errorp errnum)))))

; Returns two values: the number of bytes actually written, and the
; location of the file mark.
(defun fsWrite (paramBlock count buffer &optional (offset 0) (errorp t))
  (setf (pref paramblock :fsforkioparam.buffer)  (if (eq offset 0) buffer (%inc-ptr buffer offset))
        (pref paramblock :FSForkIOParam.requestCount) count)
  (let ((errnum (#_PBWriteForkSync paramBlock)))
    (setf (pref paramblock :FSForkIOParam.positionMode) #$fsAtMark)
    (let ()
      (if (or (eql #$noErr errnum) (eql #$eofErr errnum))
        (values (pref paramblock :FSForkIOParam.actualCount)
                (paramblock-position paramblock)) ;(unsignedwide->integer (pref paramblock :FSForkIOParam.positionOffset)))
        (maybe-file-error errorp errnum)))))

(defun setFPos (paramBlock pos)
  (setf (pref paramblock :FSForkIOParam.positionOffset.hi) (ldb uw-hi pos)
        (pref paramblock :FSForkIOParam.positionOffset.lo) (ldb uw-lo pos)
        (pref paramblock :fsforkioparam.PositionMode) #$fsFromStart)  ;; atmark??
  (errchk (#_PBSetForkPositionSync paramblock))
  ;(setf (pref paramblock :fsforkioparam.PositionMode) #$fsAtMark)  ;; needed??
  pos)

(defun getFPos (paramBlock)
  (paramblock-position paramblock)) ;(unsignedwide->integer (pref paramblock :FSForkIOParam.positionOffset)))

(defun getEOF (paramBlock &optional (errorp t))
  (let ((cur-pos (getFPos paramblock)))
    (unwind-protect
      (let* ((errnum (#_PBGetForkSizeSync paramBlock)))
        (if (eql #$noErr errnum)
          (paramblock-position paramblock) ;(unsignedwide->integer (pref paramblock :FSForkIOParam.positionOffset))
          (maybe-file-error errorp errnum)))
      (setFPos paramblock cur-pos))))

;; no good for unicode/long names - probably unused anyway

#+interfaces-3
(defun GetVInfo (&key (volName "") (vRefNum 0))
  (let* ((vol-pathname (truename (make-pathname :type nil :name nil :defaults volName)))
         (directory    (pathname-directory vol-pathname)))
    (assert (and directory (eq :absolute (car directory))))
    (rlet ((paramBlock :hparamblockrec))
      (with-returned-pstrs ((pname (cadr directory)))
        (setf (pref paramblock :hparamblockrec.volumeparam.ioCompletion) (%null-ptr)
              (pref paramblock :hparamblockrec.volumeparam.ioNamePtr)    pname
              (pref paramblock :hparamblockrec.volumeparam.ioVRefNum)    vRefNum
              (pref paramblock :hparamblockrec.volumeparam.ioVolIndex)   0)
        (values (#_PBHGetVInfoSync paramBlock)
                (* (pref paramblock :hparamblockrec.volumeparam.ioVAlBlkSiz) ;(%get-unsigned-long paramblock $ioVAlBlkSiz)         ; see IM:Files 2-46
                   (pref paramblock :hparamblockrec.volumeparam.ioVFrBlk))    ;; this is old fashioned
                (pref paramblock :hparamblockrec.volumeparam.ioVRefNum)
                (%get-string (pref paramblock :hparamblockrec.volumeparam.ioNamePtr)))))))



(defun maybe-file-error (errorp errnum &optional filename)
  (if errorp
    (%err-disp errnum filename)
    (values nil errnum)))

(provide :mac-file-io)

; End of mac-file-io.lisp
