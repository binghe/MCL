;;-*- Mode: Lisp; Package: CCL -*-
;;
;; resources.lisp
;;
;; Simple resource accessors
;;
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-1999 Digitool, Inc.

;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; open-resource-file, with-open-resource-file get data-fork-p arg
;; ------- 5.2b6
;; open-resource-file was broken when file no exist and :if-does-not-exist = :create
;; ------- 5.1b1
;; get-ind-resource uses %get-string-from-handle
;; open-resource-file more politically correct
;; --------- 5.0 final
;; 12/24/99 akh  open-resource-file and with-ditto take a direction argument and perm (for cfm mover)
;; 02/29/96 bill export detach-resource as recommended by Andrew Begel
;; 02/16/96 bill Edward Lay's fix to open-resource-file
;; ------------- 3.0
;; 04/24/92 bill export get-string & get-ind-string (thanx to Bob Strong)
;; ------------- 2.0
;; 12/12/91 gb   %signal-error -> %err-disp.
;; 12/12/91 bill get-resource defaults to loading the resource
;; ------------- 2.0b4
;; 11/20/91 bill open-resource-file now resolves aliases
;; 09/27/91 bill $fnfErr & friends -> #$fnfErr & #friends
;; 07/05/91 bill New file
;;


(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(with-open-resource-file open-resource-file close-resource-file
             use-resource-file current-resource-file using-resource-file
             get-resource load-resource release-resource detach-resource
             add-resource delete-resource remove-resource
             get-string get-ind-string)))


; Execute the BODY with REFNUM-VAR bound to the refnum for the resource
; file of FILE.  :IF-DOES-NOT-EXIST can be NIL, :ERROR, or :CREATE
(defmacro with-open-resource-file ((refnum-var file &rest args &key (if-does-not-exist :error)
                                               perm direction data-fork-p) 
                                   &body body)
  (declare (ignore perm direction if-does-not-exist data-fork-p))
  `(let ((,refnum-var nil))
     (unwind-protect
       (progn
         (setq ,refnum-var
               (open-resource-file ,file ,@args))
         ,@body)
       (if ,refnum-var
         (close-resource-file ,refnum-var)))))

;; just like %open-res-file2 but with perms arg and no errorp arg - rets errno as second value
#+ignore
(defun %open-res-file-with-perms (name &optional (perms #$fsrdwrperm))
  (let ((truename (truename name))
        (refnum)
        err)
    (rletZ ((fsref :fsref))
      (make-fsref-from-path-simple truename fsref)
      (multiple-value-setq (refnum err) (open-resource-file-from-fsref fsref perms))
      (when (eq refnum -1)
        (fscreate-res-file truename)        
        (multiple-value-setq (refnum err) (open-resource-file-from-fsref fsref perms)))
    (values (And (neq refnum -1) refnum)
            err))
   ))

; Open the resource FILE and return it's refnum.
; if-does-not-exist can be :error, nil or :create (just like OPEN).
; If ERRORP is NIL and there is an error, return two values: NIL and
; the error code.

(defun open-resource-file (file &key (if-does-not-exist :error) (errorp t) (direction :io)
                                perm data-fork-p)
  (when (not perm)
    (setq perm (case direction
                 (:io  #$fsRdWrPerm)
                 (:input #$fsrdperm)
                 (:output #$fswrperm)
                 (:shared #$fsRdWrShPerm)
                 (t #$fsRdWrPerm))))
  (cond
   ((eq if-does-not-exist :create)
    (let ((refnum (%open-res-file2 file perm data-fork-p)))
      (cond ((or (null refnum)(eq refnum -1))
             (if errorp 
               (signal-file-error #$fnferr file)
               (values nil #$fnferr)))
            (t refnum))))
   (t (rlet ((fsref :fsref))
        (multiple-value-bind (found dirflg) (path-to-fsref file fsref)
          (when (or (not found) dirflg)        
            (if errorp
              (signal-file-error #$fnferr file)
              (return-from open-resource-file (values nil #$fnferr)))))          
        (multiple-value-bind (refnum errno)
                             (open-resource-file-from-fsref fsref perm data-fork-p)
          (if errno          
            (if errorp
              (signal-file-error errno file) 
              (values nil errno))
            refnum))))))
    
    
; Close the resource file with the given refnum
(defun close-resource-file (refnum)
  (#_CloseResFile refnum)
  (res-error))

; General error checker for resource manager traps
(defun res-error ()
  (let ((err (#_ResError)))
    (unless (eql 0 err)
      (%err-disp err))))

; Use the resource file with the given refnum
(defun use-resource-file (refnum)
  (prog1
    (#_CurResFile)
    (#_UseResFile refnum)
    (res-error)))

(defmacro using-resource-file (refnum &body body)
  (let ((old-refnum (gensym)))
    `(let (,old-refnum)
       (unwind-protect
         (progn
           (setq ,old-refnum (use-resource-file ,refnum))
           ,@body)
         (when ,old-refnum
           (use-resource-file ,old-refnum))))))

(defun current-resource-file ()
  (#_CurResFile))

; Get a resource with the given type and name-or-number.
; (string type) should be a four-character string
; name-or-number should be an integer or a string
; if used-file-only? is true, Get1Resource is used instead of GetResource.
; if load? is true (the default), load the resource as well.
; Return NIL if the resource is not found for any reason.
(defun get-resource (type name-or-number &optional 
                          used-file-only?
                          (load? t))
  (let ((res (if (integerp name-or-number)
               (if used-file-only?
                 (#_Get1Resource type name-or-number)
                 (#_GetResource type name-or-number))
               (with-pstr (ps name-or-number)
                 (if used-file-only?
                   (#_Get1NamedResource type ps)
                   (#_GetNamedResource type ps))))))
    (unless (%null-ptr-p res)
      (when load?
        (load-resource res))
      res)))

; Get the 'STR ' resource with the given NAME-OR-NUMBER
(defun get-string (name-or-number &optional used-file-only? dont-release)
  (let ((str (get-resource "STR " name-or-number used-file-only?)))
    (when str
      (unwind-protect
        (%get-string str)
        (unless dont-release (#_ReleaseResource str))))))

; get the INDEX'th string from the 'STR#' resource with the given NAME-OR-NUMBER
; Returns NIL if there is no such 'STR#' resource.
; Returns two values, NIL and the number of strings in the resource, if there
; is a matching 'STR#' resource, but the INDEX is too big.
; INDEX starts at 1 to copy the broken Mac definition.
(defun get-ind-string (name-or-number index &optional used-file-only? dont-release)
  (unless (and (fixnump index) (>= index 1))
    (report-bad-arg index '(fixnum 1 *)))
  (let ((index (1- (the fixnum index)))
        (str# (get-resource "STR#" name-or-number used-file-only? nil)))
    (declare (fixnum index))
    (when str#
      (unwind-protect
        (without-interrupts               ; don't want anyone to purge this resource
         (load-resource str#)
         (let ((count (%hget-word str#)))
           (if (<= count index)
             (values nil count)
             (let ((offset 2))
               (dotimes (i index)
                 (declare (fixnum i))
                 (setq offset (+ 1 offset (%hget-byte str# offset))))
               (%get-string-from-handle str# offset)))))
        (unless dont-release (#_ReleaseResource str#))))))

(defun %get-string-from-handle (handle &optional (offset 0))
  (with-dereferenced-handle (hp handle)
    (%get-string hp offset)))

; Load a resource
(defun load-resource (resource)
  (#_LoadResource resource)
  (res-error))

; Release the given resource
(defun release-resource (resource)
  (#_ReleaseResource resource)
  (res-error))

; Add resource to the currently used resource
(defun add-resource (resource type id &key name attributes)
  (with-pstr (ps (or name ""))
    (#_AddResource resource type id ps)
    (res-error)
    (when attributes
      (#_SetResAttrs resource attributes)
      (res-error))
    resource))

(defun write-resource (resource)
  (#_WriteResource resource)
  (res-error))

(defun delete-resource (type id-or-name &optional (used-file-only? t))
  (unwind-protect
    (progn
      (#_SetResLoad nil)
      (let ((resource (get-resource type id-or-name used-file-only?)))
        (when resource
          (remove-resource resource)
          (#_DisposeHandle resource)
          t)))
    (#_SetResLoad t)))

; Note that this does not free the memory allocated for the resource.
(defun remove-resource (resource)
  (using-resource-file (#_HomeResFile resource)
    (#_RemoveResource resource))
  (res-error))

(defun detach-resource (resource)
  (#_DetachResource resource)
  (res-error))

(provide "RESOURCES")
