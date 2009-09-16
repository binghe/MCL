;;;-*- Mode: Lisp; Package: (CFM-MOVER) -*-

;;; cfm-mover.lisp
;;;
;;; A utility similar to the Font/DA Mover for moving CFM
;;; libraries between files.
;;;

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; update some constant names
;;; ---- 5.1 final
;;; 12/12/99 akh   no more open-resource-file patch - always supply perm
;;; 04/11/97 bill  make open-resource-file & with-open-resource-file patches load at
;;;                :load-toplevel time as well.
;;; 04/07/97 bill  4.0 -> 4.1 in commented out example code.
;;; -------------  4.1b1
;;; 10/09/96 slh   move export to inside eval-when; new example form
;;;  9/20/96 slh   report missing files early
;;; 08/15/96 bill  Update app names in example form at end of file.
;;; 07/25/96 bill  export merge-application-and-libraries.
;;;                provide "CFM-MOVER"
;;;                Update example of use at end of file with likely shipping file names.
;;; 06/27/96 bill  create-cfm-file aligns cfrg data to 16 byte boundary.
;;;  6/11/96 slh   use HFS traps, specify permissions; restore resload state in get-file-resource-list; don't release
;;;                resources (see comments); woi in get-file-resource-list; copy-resource-list-to-file: bind hstate,
;;;                merge res attrs, return not-found rsrcs too; merge-application-and-libraries: return
;;;                not-founds; fixed cfrg contents: CFM & ResEdit want descriptors long-aligned, frag names
;;;                need only pad to word; create-cfm-file: set pos to end of file if appending; create-cfm-file:
;;;                longword-align fragments
;;; 05/10/96 bill  New file
;;;

(defpackage cfm-mover)

(in-package :cfm-mover)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (export '(merge-application-and-libraries
            parse-cfrg-resource)))

(provide "CFM-MOVER")

(eval-when (:execute :compile-toplevel :load-toplevel)

  (defconstant rAttrMask (logior #$resPreload #$resProtected
                                 #$resLocked #$resPurgeable #$resSysHeap))
  #+ignore
  (let ((*warn-if-redefine* nil)
        (*warn-if-redefine-kernel* nil))
    
    ; use _HOpenResFile, _HCreateResFile
    (defun open-resource-file (file &key (if-does-not-exist :error) (errorp t) (perm $fsRdPerm))
      (let ((real-file (probe-file file)))          ; resolve alias
        (setq real-file (mac-namestring (or real-file file)))
        (with-pstrs ((pf real-file))
          (let ((res (#_Hopenresfile 0 0 Pf Perm)))
            (declare (fixnum res))
            (when (< res 0)
              (flet ((err (code)
                       (if errorp
                         (ccl::signal-file-error code file)
                         (return-from open-resource-file (values nil code)))))
                (declare (dynamic-extent #'err))
                (let ((code (#_ResError)))
                  (unless (or (eq code #$fnfErr)
                              (eq code #$eofErr)
                              (eq code #$resFNotFound))
                    (err code))
                  (case if-does-not-exist
                    (:create
                     (#_HCreateResFile 0 0 pf)
                     (setq res (#_HOpenResFile 0 0 pf perm))
                     (when (< res 0) (err (#_ResError))))
                    (:error
                     (err code))
                    ((nil) (return-from open-resource-file nil))
                    (t (error (ccl::%badarg if-does-not-exist '(member nil :create :error))))))))
            res))))

    ; perm keyword arg
    (defmacro with-open-resource-file ((refnum-var file &key
                                                   (if-does-not-exist :error)
                                                   (perm $fsRdPerm))
                                       &body body)
      `(let ((,refnum-var nil))
         (unwind-protect
           (progn
             (setq ,refnum-var
                   (open-resource-file ,file :if-does-not-exist ',if-does-not-exist :perm ,perm))
             ,@body)
           (if ,refnum-var
             (close-resource-file ,refnum-var)))))
    ))

; Information about the 'cfrg' resource format
; starts on page 3-29 of the "Power PC System Software" manual.

(defrecord fragment-descriptor
  (code-type :ostype)                   ; #$kPowerPC
  (update-level :long)                  ; #$kFullLib or #$KUpdateLib
  (current-version :long)               ; version number
  (oldest-definition-version :long)     ; compatible back to version number
  (application-stack-size :long)        ; stack size for application
  (application-library-directory :word) ; index of 'alis' record
  (fragment-type :byte)                 ; #$kIsLib, #$kIsApp, #$kIsDropIn
  (fragment-location :byte)             ; #$kInMem, #$kOnDiskFlat, #$kOnDiskSegmented
  (fragment-offset :long)               ; see table below
  (fragment-length :long)               ; see table below
  (reserved-1 :long)
  (reserved-2 :long)
  (record-length :unsigned-word)        ; total length of this record
  (name (:array :byte 0)))              ; Pascal string padded with 0's to record-length

; fragment-location         fragment-offset        fragment-length
; -----------------         ---------------        ---------------
; #$kInMem                  memory address         size in bytes
; #$kOnDiskFlat             Offset in data fork    size in bytes or #$kWholeFork (0)
; #$kOnDiskSegmented        resource type          resource index

(defrecord cfrg-header
  (reserved-1 :long)
  (reserved-2 :long)
  (version :long)
  (reserved-3 :long)
  (reserved-4 :long)
  (reserved-5 :long)
  (reserved-6 :long)
  (fragment-descriptor-count :long)
  (descriptors (:array :fragment-descriptor 0)))

; The value in the cfrg-header.version slot
(defparameter $cfrg-version 1)
  
(defstruct (cfrg (:print-function print-cfrg))
  name
  code-type
  update-level
  current-version
  oldest-definition-version
  application-stack-size
  application-library-directory
  fragment-type
  fragment-location
  fragment-offset
  fragment-length
  file)

(defun print-cfrg (cfrg stream level)
  (declare (ignore level))
  (print-unreadable-object (cfrg stream :type t)
    (format stream "~s ~s/~s"
            (cfrg-name cfrg)
            (cfrg-fragment-offset cfrg)
            (cfrg-fragment-length cfrg))))  

; Get the 'cfrg' resource from the given file.
; return it as a handle or NIL if the file can't
; be found or there is no cfrg resource.
(defun get-cfrg-resource (file)
  (with-open-resource-file (refnum file :if-does-not-exist nil :perm #$fsrdperm)
    (when refnum
      (let ((resource (get-resource :|cfrg| 0 t)))
        (when resource
          (detach-resource resource)
          resource)))))

(defparameter *update-level-alist*
  '((#.#$kIsCompleteCFrag . :kFullLib)
    (#.#$kFirstCFragUpdate . :kUpdateLib)))

(defparameter *fragment-type-alist*
  '((#.#$kImportLibraryCFrag . :kIsLib)
    (#.#$kApplicationCFrag . :kIsApp)
    (#.#$kDropInAdditionCFrag . :kIsDropIn)))

(defparameter *fragment-location-alist*
  '((#.#$kMemoryCFragLocator . :kInMem)
    (#.#$kDataForkCFragLocator . :kOnDiskFlat)  ; ??
    (#.#$kResourceCFragLocator . :kOnDiskSegmented))) ; ??

(defun alist-lookup-or-self (item alist)
  (or (cdr (assoc item alist)) item))

(defun alist-reverse-lookup-or-default (item alist &optional default)
  (or (car (rassoc item alist)) default))

; cfrg is a handle to a 'cfrg' resource.
; file is the pathname of the file for the resource
; Parses it into a list of cfrg instances
; If file is included, this may include some with a null name, to
; fill in holes in the data fork.
(defun parse-cfrg-resource (file &optional (cfrg-handle nil cfrg-handle-p))
  (when (and file (not cfrg-handle-p))
    (setq cfrg-handle (get-cfrg-resource file)))
  (let ((data-fork-size (and file (ccl::file-data-size file))))
    (if (null cfrg-handle)
      (when (and data-fork-size (not (eql 0 data-fork-size)))
        (list (make-cfrg :name nil
                         :fragment-location :kOnDiskFlat
                         :fragment-offset 0
                         :fragment-length data-fork-size
                         :file file)))
      (unwind-protect
        (with-dereferenced-handles ((cfrg-pointer cfrg-handle))
          (let ((version (pref cfrg-pointer :cfrg-header.version)))
            (unless (eql version $cfrg-version)
              (error "Wrong cfrg version: ~s" version)))
          (let ((count (pref cfrg-pointer :cfrg-header.fragment-descriptor-count))
                (res nil))
            (with-macptrs ((desc (pref cfrg-pointer :cfrg-header.descriptors)))
              (dotimes (i count)
                (let* ((code-type (pref desc :fragment-descriptor.code-type))
                       (update-level (alist-lookup-or-self
                                      (pref desc :fragment-descriptor.update-level)
                                      *update-level-alist*))
                       (current-version (pref desc :fragment-descriptor.current-version))
                       (oldest-definition-version (pref desc :fragment-descriptor.oldest-definition-version))
                       (application-stack-size (pref desc :fragment-descriptor.application-stack-size))
                       (application-library-directory (pref desc :fragment-descriptor.application-library-directory))
                       (fragment-type (alist-lookup-or-self
                                       (pref desc :fragment-descriptor.fragment-type)
                                       *fragment-type-alist*))
                       (fragment-location (alist-lookup-or-self
                                           (pref desc :fragment-descriptor.fragment-location)
                                           *fragment-location-alist*))
                       (fragment-offset (if (eq fragment-location :kOnDiskSegmented)
                                          (%get-ostype 
                                           desc (get-field-offset :fragment-descriptor.fragment-offset))
                                          (pref desc :fragment-descriptor.fragment-offset)))
                       (fragment-length (pref desc :fragment-descriptor.fragment-length))
                       (name (%get-string desc (get-field-offset :fragment-descriptor.name))))
                  (push (make-cfrg
                         :name name
                         :code-type code-type
                         :update-level update-level
                         :current-version current-version
                         :oldest-definition-version oldest-definition-version
                         :application-stack-size application-stack-size
                         :application-library-directory application-library-directory
                         :fragment-type fragment-type
                         :fragment-location fragment-location
                         :fragment-offset fragment-offset
                         :fragment-length fragment-length
                         :file file)
                        res))
                (%incf-ptr desc (pref desc :fragment-descriptor.record-length))))
            (setq res (nreverse res))
            ; If we know the file, add dummy cfrg's to fill in holes
            (when file
              (flet ((key (cfrg)
                       (if (eq (cfrg-fragment-location cfrg) :kOnDiskFlat)
                         (cfrg-fragment-offset cfrg)
                         0)))
                (setq res (sort res '< :key #'key))
                (let ((pos 0)
                      (additions nil))
                  (flet ((make-dummy-cfrg (start-pos end-pos)
                           (make-cfrg :name nil
                                      :fragment-location :kOnDiskFlat
                                      :fragment-offset start-pos
                                      :fragment-length (- end-pos start-pos)
                                      :file file)))
                    (dolist (cfrg res)
                      (when (eq (cfrg-fragment-location cfrg) :kOnDiskFlat)
                        (let ((offset (cfrg-fragment-offset cfrg))
                              (length (cfrg-fragment-length cfrg)))
                          (when (eql length #$kCFragGoesToEOF)
                            (setq length (- data-fork-size offset)))
                          (if (< offset pos)
                            ; Found an overlapping fragment
                            (setq pos (max pos (+ offset length)))
                            (progn
                              (when (> offset pos)
                                (push (make-dummy-cfrg pos offset) additions))
                              (setq pos (+ offset length)))))))
                    (when (> data-fork-size pos)
                      (push (make-dummy-cfrg pos data-fork-size) additions)))
                  (when additions
                    (setq res (sort (nconc res additions) '< :key #'key))))))
            res))
        ; unwind-protect cleanup
        (when (and cfrg-handle (not cfrg-handle-p))
          (#_DisposeHandle cfrg-handle))))))


; Copy the cfrg structures in cfrgs to filename.
; Currently only handles #$kOnDiskFlat fragments, but that's all MCL uses.
; dont-copy is a list of cfrgs to not copy.
; This only makes sense if if-exists is :append and those cfrgs are
; the first ones and you have already copied that data.
(defun create-cfm-file (filename cfrgs &key 
                                 (if-exists :error)
                                 file-type creator dont-copy)
  (unless (if dont-copy
            (and (eq if-exists :append)
                 (let ((cfrgs-tail cfrgs))
                   (prog1
                     (dolist (dont dont-copy t)
                       (unless (eq dont (pop cfrgs-tail))
                         (return nil)))
                     (mapl #'(lambda (x) (setf (car x) (copy-cfrg (car x))))
                           cfrgs-tail))))
            (neq if-exists :append))
    (error "dont-copy doesn't agree with if-exists and cfrgs"))
  (let* ((appl-p (find-if #'(lambda (cfrg)
                              (eq :kIsApp (cfrg-fragment-type cfrg)))
                          cfrgs))
         (file-type (or file-type (if appl-p :APPL :|shlb|)))
         (creator (or creator (if appl-p :???? :|cfmg|))))
    (with-open-file (stream filename
                            :direction :output
                            :if-exists if-exists
                            :if-does-not-exist :create
                            :mac-file-creator creator
                            :external-format file-type
                            :elements-per-buffer 4096)
      ; In case the user says :if-exists :overwrite
      (set-mac-file-type filename file-type)
      (set-mac-file-creator filename creator)
      (file-position stream (if (eq if-exists :append)
                              (file-length stream)
                              0))
      (dolist (cfrg cfrgs)
        ; Align to longword
        (dotimes (i (let ((rem (mod (file-length stream) 16)))
                      (if (zerop rem) 0 (- 16 rem))))
          (write-char #\Null stream))
        ; This modifies the fragment-offset & fragment-length fields
        (unless (memq cfrg dont-copy)
          (append-cfrg-to-stream cfrg stream)))))
  (let ((handle (create-cfrg-handle cfrgs)))
    (with-open-resource-file (refnum filename :if-does-not-exist :create :perm $fsWrPerm)
      (add-resource handle :|cfrg| 0)))
  t)

; Append the given cfrg to the stream.
; On entry, cfrg represents its offset & length in its cfrg-file slot.
; On exit, cfrg represents its offset & length in the output stream.
(defun append-cfrg-to-stream (cfrg stream)
  (multiple-value-bind (writer writer-arg) (stream-writer stream)
    (let ((file (cfrg-file cfrg))
          (location (cfrg-fragment-location cfrg))
          (offset (cfrg-fragment-offset cfrg))
          (length (cfrg-fragment-length cfrg)))
      (unless file
        (error "~s has no file" cfrg))
      (unless (eq location :kOnDiskFlat)
        (error "Can't copy memory or resource fragment: ~s" cfrg))
      (with-open-file (in-stream file :direction :input :elements-per-buffer 4096)
        (when (eql length #$kCFragGoesToEOF)
          (setq length (- (file-length in-stream) offset))
          (setf (cfrg-fragment-length cfrg) length))
        (setf (cfrg-fragment-offset cfrg) (file-position stream))
        (file-position in-stream offset)
        (multiple-value-bind (reader reader-arg) (stream-reader in-stream)
          (dotimes (i length)
            (let ((char (funcall reader reader-arg)))
              (unless char
                (error "EOF on ~s" in-stream))
              (funcall writer writer-arg char))))))))

; Create a single :|cfrg| handle containing the list of cfrgs.
(defun create-cfrg-handle (cfrgs)
  (labels ((align (value align)
             (* align (ceiling value align)))
           (name-length (name)
             (align (1+ (length name)) 2)))
    (let* ((real-cfrgs (remove-if #'(lambda (cfrg) (null (cfrg-name cfrg))) cfrgs))
           (count (length real-cfrgs))
           (size (+ (record-length :cfrg-header)
                    (reduce '+ real-cfrgs :key #'(lambda (cfrg)
                                                   (align (+ (record-length :fragment-descriptor)
                                                             (name-length (cfrg-name cfrg)))
                                                          4)))))
           (handle (#_NewHandleClear :errchk size)))
      (with-dereferenced-handles ((ptr handle))
        (setf (pref ptr :cfrg-header.version) $cfrg-version
              (pref ptr :cfrg-header.fragment-descriptor-count) count)
        (with-macptrs ((p (pref ptr :cfrg-header.descriptors)))
          (dolist (cfrg real-cfrgs)
            (let* ((name (cfrg-name cfrg))
                   (name-length (name-length name))
                   (record-length (align (+ (record-length :fragment-descriptor) name-length) 4))
                   (code-type (cfrg-code-type cfrg))
                   (update-level (cfrg-update-level cfrg))
                   (current-version (cfrg-current-version cfrg))
                   (oldest-definition-version (cfrg-oldest-definition-version cfrg))
                   (application-stack-size (cfrg-application-stack-size cfrg))
                   (application-library-directory (cfrg-application-library-directory cfrg))
                   (fragment-type (cfrg-fragment-type cfrg))
                   (fragment-location (cfrg-fragment-location cfrg))
                   (fragment-offset (cfrg-fragment-offset cfrg))
                   (fragment-length (cfrg-fragment-length cfrg)))
              (setq update-level (alist-reverse-lookup-or-default
                                  update-level *update-level-alist* update-level)
                    fragment-type (alist-reverse-lookup-or-default
                                   fragment-type *fragment-type-alist* fragment-type)
                    fragment-location (or (alist-reverse-lookup-or-default
                                           fragment-location *fragment-location-alist*)
                                          (error "Unknown fragment-location: ~s" fragment-location)))
              (setf (pref p :fragment-descriptor.code-type) code-type
                    (pref p :fragment-descriptor.update-level) update-level
                    (pref p :fragment-descriptor.current-version) current-version
                    (pref p :fragment-descriptor.oldest-definition-version) oldest-definition-version
                    (pref p :fragment-descriptor.application-stack-size) application-stack-size
                    (pref p :fragment-descriptor.application-library-directory) application-library-directory
                    (pref p :fragment-descriptor.fragment-type)  fragment-type
                    (pref p :fragment-descriptor.fragment-location)  fragment-location
                    (pref p :fragment-descriptor.fragment-length)  fragment-length
                    (pref p :fragment-descriptor.record-length)  record-length)
              (if (eql fragment-location #$kResourceCFragLocator)
                (setf (%get-ostype p (get-field-offset :fragment-descriptor.fragment-offset))
                      fragment-offset)
                (setf (pref p :fragment-descriptor.fragment-offset) fragment-offset))
              (%put-string p name (get-field-offset :fragment-descriptor.name))
              (%incf-ptr p record-length))))
        handle))))

(defstruct rsrc
  type
  ID
  name
  attributes
  file)

(defun get-resource-info (rsrc)
  (rlet ((the-name (:string 255))
         (the-type :ostype)
         (the-ID :signed-integer))
    (#_GetResInfo rsrc the-ID the-type the-name)
    (ccl::res-error)
    (values (unless (eql 0 (%get-byte the-name))
              (%get-string the-name))
            (%get-ostype the-type)
            (%get-word the-ID))))

; Return a list of rsrc structures describing the resources in a file
(defun get-file-resource-list (file &optional ignore-types)
  (with-open-resource-file (refnum file :perm #$fsrdperm)
    (without-interrupts ; while messing with SetResLoad
     (let ((resload (#_LMGetResLoad)))
       (unwind-protect
         (let ((type-count (#_Count1Types))
               (res nil))
           (#_SetResLoad nil)
           (rlet ((the-type :ostype))
             (dotimes (i type-count)
               (#_Get1IndType the-type (1+ i))
               (let* ((type (%get-ostype the-type))
                      (rsrc-count (#_Count1Resources type)))
                 (unless (memq type ignore-types)
                   (dotimes (i rsrc-count)
                     (let* ((rsrc (#_Get1IndResource type (1+ i)))
                            (attributes (#_GetResAttrs rsrc)))
                       (multiple-value-bind (name type id) (get-resource-info rsrc)
                         ; If the resource fork is from the running application, this loses.
                         ; To do it right: get, detach, and add in one loop.
                         #+no (release-resource rsrc)
                         (push (make-rsrc :type type
                                          :ID id
                                          :name name
                                          :attributes attributes
                                          :file file)
                               res))))))))
           (nreverse res))
         ; unwind-protect cleanup
         (#_SetResLoad (not (zerop resload))))))))

; Returns a list of the resources that were already in the file with different contents
(defun copy-resource-list-to-file (rsrc-list to-file)
  (let ((hash (make-hash-table :test 'equalp))
        (not-found-rsrcs nil)
        (bad-rsrcs nil))
    (dolist (rsrc rsrc-list)
      (push rsrc (gethash (rsrc-file rsrc) hash)))
    (with-open-resource-file (to-refnum to-file :if-does-not-exist :create :perm $fsWrPerm)
      (maphash #'(lambda (file rsrcs)
                   (with-open-resource-file (from-refnum file :perm $fsRdPerm)
                     (dolist (rsrc rsrcs)
                       (use-resource-file from-refnum)
                       (let* ((type (rsrc-type rsrc))
                              (id (rsrc-ID rsrc))
                              (res (get-resource type id t))
                              old-state)
                         (if (not res)
                           (push rsrc not-found-rsrcs)
                           (progn
                             ;; Mark handle not purgeable (clear the bit), saving old state so
                             ;; it can be restored when we're done with it.
                             (setq old-state (let ((state (#_HGetState res)))
                                               (#_HSetState res (logandc2 state (ash 1 6))) ; purgeable
                                               (#_LoadResource res) ; paranoia
                                               (ccl::res-error)
                                               state))
                             (detach-resource res)
                             (use-resource-file to-refnum)
                             (let ((to-res (get-resource type id t)))
                               (if to-res
                                 (unwind-protect
                                   (unless
                                     (and (eql (rsrc-attributes rsrc) (#_GetResAttrs to-res))
                                          (equalp (rsrc-name rsrc) (get-resource-info to-res))
                                          (let ((size (#_GetHandleSize to-res)))
                                            (and (equalp size (#_GetHandleSize res))
                                                 (dotimes (i size t)
                                                   (unless (eql (%hget-byte res i) (%hget-byte to-res i))
                                                     (return nil))))))
                                     (push rsrc bad-rsrcs))
                                   (#_DisposeHandle res))
                                 (progn
                                   (with-pstrs ((ps (or (rsrc-name rsrc) "")))
                                     (#_AddResource res type id ps)
                                     (ccl::res-error))
                                   (let ((attrs (logior (logand (rsrc-attributes rsrc) rAttrMask)
                                                        (logandc2 (#_GetResAttrs res)
                                                                  rAttrMask))))
                                     (ccl::res-error)
                                     (#_SetResAttrs res attrs)
                                     (ccl::res-error))
                                   (ccl::write-resource res)
                                   ; see comment in get-file-resource-list
                                   #+no (release-resource res)
                                   (#_HSetState res old-state)
                                   )))))))))
               hash))
    (values (nreverse bad-rsrcs)
            (nreverse not-found-rsrcs))))

(defvar *types-to-ignore*
  '(:|vers| :|cfrg| :SIZE))

(defun merge-application-and-libraries (application-file library-files output-file &key
                                                         (if-exists :error)
                                                         (verbose nil))
  (let ((missing (mapcar #'(lambda (file) (unless (probe-file file) file))
                         (list* application-file library-files))))
    (unless (every #'null missing)
      (error "The following files are missing:~{~@[~&  ~S~]~}" missing)))
  (when verbose (format t "~&Copying application-file..."))
  (copy-file application-file output-file :if-exists if-exists)
  (with-open-resource-file (refnum output-file :perm $fsWrPerm)
    (let ((res (get-resource :|cfrg| 0 t)))
      (when res
        (remove-resource res))))
  (when verbose (format t "~&Parsing cfrg resources..."))
  (let* ((app-cfrgs (parse-cfrg-resource application-file))
         (cfrgs (copy-list app-cfrgs))
         bad-resources not-founds)
    (dolist (file library-files)
      (setq cfrgs (nconc cfrgs (parse-cfrg-resource file))))
    (when verbose (format t "~&Copying cfrgs..."))
    (create-cfm-file output-file cfrgs
                     :if-exists :append
                     :dont-copy app-cfrgs
                     :file-type (mac-file-type application-file)
                     :creator (mac-file-creator application-file))
    (when verbose (format t "~&Copying resources..."))
    (dolist (file library-files)
      (let ((rsrc-list (get-file-resource-list file *types-to-ignore*)))
        (when rsrc-list
          (multiple-value-bind (bad-ones nada-ones)
                               (copy-resource-list-to-file rsrc-list output-file)
            (setq bad-resources (nconc bad-resources bad-ones)
                  not-founds (nconc not-founds nada-ones))))))
    (list output-file bad-resources not-founds)))


#| Examples:

; A useful function for ensuring that the CFRG data made it.
(defun compare-data-forks (file1 file2 start2)
  (with-open-file (s1 file1)
    (with-open-file (s2 file2)
      (file-position s2 start2)
      (multiple-value-bind (r1 a1) (stream-reader s1)
        (multiple-value-bind (r2 a2) (stream-reader s2)
          (let ((i 0))
            (loop
              (let ((c1 (funcall r1 a1))
                    (c2 (funcall r2 a2)))
                (when (null c1) (return))
                (unless (eql c1 c2)
                  (print-db i c1 c2))
                (incf i)))))))))

; build a complete MCL 4.3 demo
(cfm-mover::merge-application-and-libraries
 "MCL 4.3 demo"
 '("pmcl-kernel-4.3"
   "pmcl-compiler-4.3"
   "pmcl-library-4.3")
 "MCL 4.3 complete"
 :if-exists :supersede
 :verbose t)

; same, but automatically finds the latest files
(cfm-mover::merge-application-and-libraries
 "ccl:MCL 4.1"
 `(,(let ((xsyms+maps (append (directory "ccl:pmcl-kernel-*.xsym")
                              (directory "ccl:pmcl-kernel-*.map"))))
      (find-if-not #'(lambda (path)
                       (member path xsyms+maps :test #'equal))
                   (directory "ccl:pmcl-kernel-*")
                   :from-end t))
   ,(car (last (directory "ccl:pmcl-compiler-*")))
   ,(car (last (directory "ccl:pmcl-library-*"))))
 "ccl:MCL 4.1 complete"
 :if-exists :supersede
 :verbose t)

|#