

;;	Change History (most recent first):
;;  4 7/18/96  akh  probably no change
;;  2 10/27/95 bill see below
;;  (do not edit before this line!!)
;;
;;  read-only.lisp
;;
;;  teach fred about projector resources and read-only windows

;;
;;  Based on work by Ora Lassila (ora@hutcs.hut.fi)
;;
;; use fsrefs vs. HOpenResFile
;; ------- 5.0 final
;;  01/03/96 bill Convert LAP for PPC
;;                #_RmveResource -> #_RemoveResource
;;  10/25/95 bill All callers of #_OpenResfile call probe-file to resolve aliases
;;; 11/05/91 gz  Convert to new traps.
;;  11/05/91  alms mini-buffer icons moved to listeners-and-windows
;;  31-oct-91 jaj add projector icons to mini-buffer
;;  10/09/91  alms many changes
;;  27-sep-91 jaj  added transfer-ckid
;;  15-aug-91 gz   added symbolic ckid constants
;;  15-aug-91 jaj added set-file-modify-read-only
;;  05-Jun-91 Vrhel.T to clean up comtab, add minibuffer alert for checked out files
;;  09-May-91 Andy Stadler   to better support ModifyReadOnly
;;  31-jan-91 alms Ported to MCL 2.0 and expanded

(in-package :ccl)

;;access to the ckid resource

(eval-when (eval compile #-debugged load)
  (defrecord (ckid :handle)
    (checkSum longint)
    (LOC longint)
    (version integer)                   ;  this definition is for VERSION 4
    (readOnly integer)                  ;  0 = readonly   nonzero = readwrite
    (branch byte)
    (modifyReadOnly boolean)            ;  T = modreadonly 
    (unused longint)
    (checkoutTime longint)
    (modDate longint)
    (pida longint)
    (pidb longint)
    (userID integer)
    (fileID integer)
    (revID integer)
    (projectlen byte))

#-ppc-target
(eval-when (:compile-toplevel :execute)
  (require :lapmacros))


;; file-modifiable-state is:  -1 = modifyreadonly,  0 = readwrite, >0 = readonly, -2 is checkedout 

(defconstant $ckid-checkedout -2)
(defconstant $ckid-modifyreadonly -1)
(defconstant $ckid-readwrite 0)
(defconstant $ckid-readonly 1)
)

(defun file-modifiable-state (filename)
  (if (or (null filename) 
          (null (setq filename (probe-file filename))))
    $ckid-readwrite
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple filename fsref)
      (let ((ref (open-resource-file-from-fsref fsref #$fsrdwrperm)))
        (cond ((eql ref -1) $ckid-readwrite)
              (t (unwind-protect (let ((ckid (#_Get1Resource :|ckid| 128)))
                                   (cond ((%null-ptr-p ckid) $ckid-readwrite)
                                         ((neq 4 (rref ckid ckid.version)) $ckid-readwrite)
                                         ((neq 0 (rref ckid ckid.readOnly)) $ckid-checkedout)
                                         ((rref ckid ckid.modifyReadOnly) $ckid-modifyreadonly)
                                         (t $ckid-readonly)))
                   (#_CloseResFile ref))))))))

(defun set-file-modify-read-only (filename &optional (value t))
  (let ((real-filename (probe-file filename)))
    (unless real-filename
      (error "Non-existent file: ~s" filename))
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple real-filename fsref)
      (let ((date (file-write-date filename))
            (ref (open-resource-file-from-fsref fsref #$fsrdwrperm)))
        (unwind-protect 
          (let ((ckid (#_Get1Resource :|ckid| 128)))                        
            (setf (rref ckid ckid.modifyReadOnly) value)
            (setf (rref ckid ckid.checksum) (handle-checksum ckid))
            (#_ChangedResource ckid))
          (#_CloseResFile ref)
          (set-file-write-date real-filename date))))))

(defun set-file-local-checked-out-p (filename value)
  (let ((real-filename (probe-file filename)))
    (unless real-filename
      (error "Non-existent file: ~s" filename))
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple real-filename fsref)
      (let* ((date (file-write-date real-filename))
             (ref (open-resource-file-from-fsref fsref #$fsrdwrperm)))
        (unwind-protect 
          (let ((ckid (#_Get1Resource :|ckid| 128)))
            (setf (rref ckid ckid.readonly) (if value 8 0))
            (setf (rref ckid ckid.checksum) (handle-checksum ckid))
            (#_ChangedResource ckid))
          (#_CloseResFile ref)
          (set-file-write-date filename date))))))

#|
(defun file-local-checked-out-p (filename)
  (let ((real-filename (probe-file filename)))
    (unless real-filename (error "Non-existent file: ~s" filename))
    (with-pstrs ((str (mac-namestring real-filename)))
      (let ((ref (#_OpenResFile str)))
        (unwind-protect (let ((ckid (#_Get1Resource :|ckid| 128)))
                          (rref ckid ckid.readonly))
          (#_CloseResFile ref))))))

(file-local-checked-out-p (choose-file-dialog))
|#


#|
(defun test-ckid-checksum (filename)
  (let ((real-filename (probe-file filename)))
    (unless real-filename
      (error "Non-existent file: ~s" filename))
    (with-pstrs ((str (mac-namestring real-filename)))
      (let ((ref (#_OpenResFile str)))
        (unwind-protect (let ((ckid (#_Get1Resource :|ckid| 128)))
                          (print-db (rref ckid ckid.checksum) (handle-checksum ckid))
                          (#_CloseResFile ref)))))))

(test-ckid-checksum (choose-file-dialog))
|#

(defun handle-checksum (handle)
  (let ((count (- (truncate (#_GetHandleSize handle) 4) 1)))
    (with-dereferenced-handles ((p handle))
      (pointer-checksum (%incf-ptr p 4) count))))

#-ppc-target
(defun pointer-checksum (p count)
  (decf count)                          ; dbf stops when negative
  (ccl::lap-inline ()
    (:variable p count)
    ;(ccl::dc.w #_debugger)
    (ccl::move.l (ccl::varg p) ccl::a0)
    (ccl::move.l (ccl::a0 ccl::$macptr.ptr) ccl::a0)
    (ccl::move.l (ccl::varg count) ccl::da)
    (ccl::getint ccl::da)
    (ccl::clr.l ccl::dx)
    @loop
    (ccl::add.l ccl::a0@+ ccl::dx)
    (ccl::dbf ccl::da @loop)
    (ccl::move.l ccl::dx ccl::d0)
    (ccl::jsr_subprim ccl::$sp-mklong)))

#+ppc-target
(defppclapfunction pointer-checksum ((p arg_y) (count arg_z))
  (check-nargs 2)
  (macptr-ptr imm0 p)
  (la imm0 -4 imm0)
  (li imm2 0)
  (li imm3 '1)
  loop
  (sub. arg_z arg_z imm3)
  (lwzu imm1 4 imm0)
  (add imm2 imm2 imm1)
  (bgt loop)
  (mtxer rzero)
  (addo imm2 imm0 imm0)
  (addo. arg_z imm2 imm2)
  (bnslr)
  (ba .SPbox-signed))

(defun remove-ckid-resource (filename)
  (if (or (null filename)
          (null (setq filename (probe-file filename))))
    0
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple filename fsref)
      (let ((ref (open-resource-file-from-fsref fsref #$fsrdwrperm)))
        (unless (eq ref -1)
          (let ((ckid (#_Get1Resource :|ckid| 128)))
            (if (not (%null-ptr-p ckid))
              (#_RemoveResource ckid)))
          (#_CloseResFile ref))))))

(defun transfer-ckid (from-file to-file &aux ckid)
  (let ((real-from-file (probe-file from-file))
        (real-to-file (probe-file to-file)))
    (unless real-from-file
      (error "Non-existent file: ~s" from-file))
    (unless real-to-file
      (error "Non-existent file: ~s" to-file))
    (rlet ((fsref :fsref)) ; ((str (mac-namestring real-from-file)))
      (make-fsref-from-path-simple real-from-file fsref)
      (let ((ref (open-resource-file-from-fsref fsref #$fsrdwrperm)))
        (when (eq ref -1) (error "no resource file"))
                (unwind-protect
                   (progn
                      (setq ckid (#_Get1Resource :|ckid| 128))
           (when (%null-ptr-p ckid) (error "No 'ckid' resource in file: ~s" from-file))
           (#_DetachResource ckid))
          (#_CloseResFile ref))))
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple real-to-file fsref) ;with-pstrs ((str (mac-namestring real-to-file)))
      (let ((ref (open-resource-file-from-fsref fsref #$fsrdwrperm)))
        (when (eq ref -1) (error "no-resource-file"))
        (let ((old (#_Get1Resource :|ckid| 128)))
                    (#_RemoveResource old))
                (#_AddResource ckid :|ckid| 128 (%null-ptr))
       (#_CloseResFile ref)))))


;;  new version of file-is-modifiable-p, defined in terms of file-modifiable-state

(defun file-is-modifiable-p (filename)
  (or (null filename)                   ;  empty filename, return t
      (< (file-modifiable-state filename) $ckid-readonly)))     ;  -1 or 0 are writeable

;;;
;;;  Use a hash table to attach the file-is-modifiable value to each window
;;;


(defmethod read-only-state ((f fred-window))
  (view-get f :ckid-state $ckid-readwrite))

(defmethod (setf read-only-state) (state (f fred-window))
  (view-put f :ckid-state state)
  (ccl::%buffer-set-read-only (fred-buffer f) (= state $ckid-readonly))
  (fred-update f))

(defmethod is-read-only ((f fred-window))
  (= (read-only-state f) $ckid-readonly))

(defmethod initialize-instance :after ((f fred-window) &rest ignore)
  (declare (ignore ignore))
  (setf (read-only-state f) (file-modifiable-state (window-filename f)))
  (mini-buffer-update f))


(provide :read-only)




#|
	Change History (most recent last):
	2	5/6/91	ads	1.  Supressing the "beep" when opening RO files
				2.  Fixing RO problems w/cut, paste, return
	2	5/30/91	tv 	Added :read-only to *features* to prevent multiple loads
	3	6/3/91	jcg	update to Leibniz 1.0:
				  + put in ralphdebug package (adbg)
	4	6/4/91	wrs	Cleaned up a bit, moved to PROJECTOR package, and
				turned over to TV.
	5	6/5/91	tv  	cleaned up dialog behavior, comtab errors
				
	7	6/6/91	   	making backwards compatible to MacRalph
	8	6/7/91	   	fixing MacRalph compatibility
	9	6/7/91	   	macralph stuff
	10	6/7/91	   	More MacRalph Compatibility
	11	6/10/91	   	adbg::find-or-make-buffer removed
	12	6/18/91	tv 	Lost code! re-adding remove-ckid-resource
	13	6/20/91	tv 	basic sanity test of 1.1d13
               08/05/91 gz      Use symbolic constants.
                                null -> %null-ptr-p in file-modifiable-state
	5	11/5/91	alms	Move mini-buffer-update definition.
	7	1/21/92	jaj	added set-file-local-checked-out-p
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	4/11/94	akh	Require lapmacros
	2	12/23/94	akh	set-file-modro and set-file-local-checked-out-p dont change file write date

|# ;(do not edit past this line!!)