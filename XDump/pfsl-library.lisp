;;;-*- Mode: Lisp; Package: CCL -*-

; pfsl-library.lisp
; Copyright 1997 Digitool, Inc. The 'tool rules!

; Convert a list of pfsl files into a shared library.
; The start of the library's data fork is a pfsl file.
; The rest is a shared library containing the code vectors.

(in-package :ccl)

(export '(make-pfsl-library))

(provide "PFSL-LIBRARY")

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; 04/01/97 bill  New file
;;;

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; To do
;;;
;;; Eliminate consing from pfsl-library-process-ivec
;;;
;;; Make it work to pass a pfsl-library as one of the pfsl files to make-pfsl-library
;;; Make fasl-concatenate handle pfsl-libraries.
;;;
;;; The save-application kernel code needs to use a bitmap to copying-gc each
;;; pfsl-library's code area. It can either use a bitmap for each code area, and
;;; mark once, or a single bitmap big enough for any area and mark once for
;;; each code area.
;;;
;;; A top-level define-component or some such to register the libraries.
;;; Maybe this should interact with a defsystem, which describes the files
;;; that make up a library.
;;;
;;; Move cfm-mover:parse-cfrg & the cfrg structure to the CCL package
;;; and make them part of MCL. Import these symbols into the cfm-mover
;;; package in "ccl:examples;cfm-mover.lisp" for backward compatibility.
;;;

#|

; Ideas for a library separation for MCL itself.

  kernel
  level-0           ; the initial heap containing the fasloader
  compiler          ; as in the current pmcl-compiler library
  macros            ; Stuff needed at compile and eval time
                    ; but usually not at application run time
  evaluator/stepper
  inspector/backtrace
  Fred
    Basic Fred editing
    Lispy Fred editing
  listener
  Tools (the tools menu)
  everything else

|#

(eval-when (:compile-toplevel :execute :load-toplevel)
  ; This defines the CFM-MOVER package, so need it at compile time
  (require "CFM-MOVER")                   ; make-cfrg, create-cfrg-resource

  ; The run-time support
  (unless (fboundp 'open-pfsl-shared-library)
    (compile-load "ccl:xdump;ppc;ppc-pfsl-library"))

  ; Knows how to write pef headers.
  ; Need structs & constants at compile time.
  (require-modules 'pef-file)
  )


(eval-when (:compile-toplevel :execute)

(require "PFSL-LIBRARY-ENV" "ccl:xdump;pfsl-library-env")

)

(defparameter *pfsl-library-dispatch-table*
  (make-array (length *fasl-dispatch-table*)
              :initial-element #'%bad-fasl))

(defvar *pfsl-library-read-only-strings-p* t)

(defun make-pfsl-library (library-pathname
                          pfsl-pathnames
                          &key
                          (if-exists :error)
                          (library-name (pathname-name library-pathname))
                          (current-version 0)
                          (oldest-definition-version 0)
                          (oldest-implementation-version 0)
                          (verbose *load-verbose*)
                          (read-only-strings-p t)
                          (provide-modules-p nil))
  (with-open-file (library-stream library-pathname
                                  :direction :output
                                  :if-exists if-exists
                                  :mac-file-creator :ccl2
                                  :external-format :pfsl)
    (let* ((library-truename (truename library-pathname))
           (temp-path (gen-file-name library-truename))
           (*load-verbose* verbose)
           (*pfsl-library-read-only-strings-p* read-only-strings-p)
           (done nil))
      (unwind-protect
        (with-open-file (code-vectors-stream temp-path 
                                             :direction :io
                                             :if-does-not-exist :create
                                             :if-exists :error)
          (let ((code-offset (parse-pfsls-to-library-streams
                              pfsl-pathnames
                              library-stream
                              code-vectors-stream
                              (ensure-simple-string library-name)
                              provide-modules-p)))
            (file-position code-vectors-stream 0)
            (let* ((pos (file-position library-stream))
                   (rounded-up-pos (* 32 (ceiling pos 32))))
              (dotimes (i (- rounded-up-pos pos))
                (write-char #\null library-stream))
              ; This closes and reopens the library-stream
              (setq library-stream
                    (copy-code-vectors-stream-to-pfsl-library-stream
                     code-vectors-stream library-stream code-offset
                     current-version oldest-definition-version oldest-implementation-version))
              (write-pfsl-library-cfrg-resource
               library-truename library-name current-version oldest-definition-version
               rounded-up-pos (file-position library-stream))
              (setq done t))))
        (close library-stream :abort (not done))
        (delete-file temp-path))
      library-truename)))

(defun write-pfsl-library-cfrg-resource (library-truename library-name current-version oldest-definition-version
                                                          start-pos end-pos)
  (let ((cfrg (cfm-mover::make-cfrg
               :name library-name
               :code-type #$kPowerPC
               :update-level :kFullLib
               :current-version current-version
               :oldest-definition-version oldest-definition-version
               :application-stack-size 0
               :application-library-directory 0
               :fragment-type :kIsLib
               :fragment-location :kOnDiskFlat
               :fragment-offset start-pos
               :fragment-length (- end-pos start-pos))))
    (let ((handle (cfm-mover::create-cfrg-handle (list cfrg))))
      (with-open-resource-file (refnum library-truename :if-does-not-exist :create :perm $fsWrPerm)
        (add-resource handle :|cfrg| 0)))))

(defconstant kLoaderSection 4)

; Append a PEF container with the code in code-vectors-stream to library-stream.
; As a side affect, close library-stream.
(defun copy-code-vectors-stream-to-pfsl-library-stream (code-vectors-stream library-stream code-offset
                                                        current-version oldest-definition-version oldest-implementation-version)
  (let ((library-path (pathname library-stream))
        (done nil)
        (pef-position (file-length library-stream)))
    (close library-stream)
    (unwind-protect
      (progn
        (setq library-stream
              (open library-path
                    :element-type '(unsigned-byte 8)
                    :direction :output
                    :if-exists :overwrite))
        (file-position library-stream pef-position)
        (file-position code-vectors-stream 0)
        (multiple-value-bind (reader reader-arg) (stream-reader code-vectors-stream)
          (multiple-value-bind (writer writer-arg) (stream-writer library-stream)
            ; PEF format is documented in "ccl:pmcl;pef.h".
            ; We use some of the code in "ccl:xdump;pef-file.lisp".
            ; Need to write:
            ;   PEF Header
            ;   Code section header
            ;   loader section header
            ;   empty global string table
            ;   Code section
            ;   loader section
            ; It's possible that we can't get away with putting the main address in
            ; the code section. Might need a data section containing a single
            ; transition vector which is relocated to the code section.
            (let* ((pef-header (make-pef-header :file-stream library-stream
                                                :timestamp (now)
                                                :old-def-version oldest-definition-version
                                                :old-imp-version oldest-implementation-version
                                                :current-version current-version))
                   (code-size (file-length code-vectors-stream))
                   (dummy-data-vector (make-array 0 :element-type '(unsigned-byte 8)))
                   (dummy-ref-bits (make-array 0 :element-type 'bit))
                   (code-section-header (make-pef-section-header
                                         :pef-header pef-header
                                         :section-number 0
                                         :exec-size code-size
                                         :init-size code-size
                                         :raw-size code-size
                                         :region-kind kCodeSection
                                         :sharing-kind kPEFGlobalShare
                                         :alignment 4   ; align to (expt 2 4) = 16 bytes
                                         :data-vector dummy-data-vector
                                         :ref-bits dummy-ref-bits))
                   (load-sections (list code-section-header))
                   (loader-header (initialize-loader-header pef-header load-sections nil))
                   (loader-section-header (make-pef-section-header
                                           :pef-header pef-header
                                           :section-number 1
                                           :region-kind kLoaderSection
                                           :data-vector dummy-data-vector
                                           :ref-bits dummy-ref-bits)))
              (setf (pef-header-loadsections pef-header) load-sections
                    (pef-header-noloadsections pef-header) (list loader-section-header))
              (setf (loader-header-entry-section loader-header) code-section-header
                    (loader-header-entry-offset loader-header) code-offset)
              (let* ((loader-data (create-loader-data loader-header))
                     (size (length loader-data)))
                (setf (sect-exec-size loader-section-header) size
                      (sect-init-size loader-section-header) size
                      (sect-raw-size loader-section-header) size
                      (sect-data-vector loader-section-header) loader-data))
              (flet ((rewrite-section-header (section-header)
                       (let* ((curpos (file-position library-stream)))
                         (file-position library-stream (sect-header-disk-address section-header))
                         (write-pef-section-header section-header)
                         (file-position library-stream curpos))))
                (write-pef-header pef-header)
                (write-pef-section-header code-section-header)
                (write-pef-section-header loader-section-header)
                (write-pef-global-string-table pef-header)
                (write-pef-section-contents code-section-header)
                (loop
                  (let ((c (funcall reader reader-arg)))
                    (unless c (return))
                    (funcall writer writer-arg (%char-code c))))
                ; pef code assumes container at beginning of file.
                (decf (sect-container-offset code-section-header) pef-position)
                (rewrite-section-header code-section-header)
                (write-pef-section-contents loader-section-header)
                (decf (sect-container-offset loader-section-header) pef-position)
                (rewrite-section-header loader-section-header)))))
        (setq done t)
        library-stream)
      ; unwind-protect cleanup
      (unless done
        (close library-stream)))))

(defvar *pfsl-library-stream*)
(defvar *pfsl-library-code-vectors-stream*)
(defvar *pfsl-library-code-vectors-writer*)
(defvar *pfsl-library-code-vectors-arg*)
(defvar *copy-fasl-input-to-pfsl-library-stream-p* nil)

(defmacro copying-fasl-input-to-pfsl-library-stream (&body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (funcall-copying-fasl-input-to-pfsl-library-stream ,thunk))))

(defvar *fasl-read-byte* #'%fasl-read-byte)

(defvar *fasl-input-copiers-count* 0)

(defun %fasl-read-byte-and-copy-to-pfsl-library-stream (s)
  (let ((byte (funcall *fasl-read-byte* s)))
    (when *copy-fasl-input-to-pfsl-library-stream-p*
      (fasl-out-byte byte))
    byte))

(defun funcall-copying-fasl-input-to-pfsl-library-stream (thunk)
  (let ((*copy-fasl-input-to-pfsl-library-stream-p* t)
        count)
    (without-interrupts
     (setq count *fasl-input-copiers-count*
           *fasl-input-copiers-count* (1+ count))
     (when (eql count 0)
       (setf (symbol-function '%fasl-read-byte) #'%fasl-read-byte-and-copy-to-pfsl-library-stream)))
    (unwind-protect
      (funcall thunk)
      (without-interrupts
       (when (eql 0 (decf *fasl-input-copiers-count*))
         (setf (symbol-function '%fasl-read-byte) *fasl-read-byte*))))))

(defun count-pfsl-segments (pathname)
  (with-open-file (s pathname :direction :input :element-type '(unsigned-byte 16))
    (let ((id (read-byte s)))
      (cond ((eql id $fasl-file-id))
            ((eql id $fasl-file-id1)
             (let ((pos (+ (ash (read-byte s) 16) (read-byte s))))
               (file-position s pos)))
            (t (error "~s is not a pfsl file" pathname))))
    (read-byte s)))

(defmacro with-fasdump-output ((stream &optional writer writer-arg) &body body)
  `(let ((*copy-fasl-input-to-pfsl-library-stream-p* nil))
     ,(if (and writer writer-arg)
        `(progn
           ,stream
           (let ((*fasdump-writer* ,writer)
                 (*fasdump-writer-arg* ,writer-arg))
             ,@body))
        `(multiple-value-bind (*fasdump-writer* *fasdump-writer-arg*) (stream-writer ,stream)
           ,writer ,writer-arg
           ,@body))))

; This was patterned after xppc-fasload
(defun parse-pfsls-to-library-streams (pfsl-pathnames *pfsl-library-stream* *pfsl-library-code-vectors-stream* library-name
                                                      provide-modules-p)
  (with-fasdump-output (*pfsl-library-stream*)
    (multiple-value-bind (*pfsl-library-code-vectors-writer* *pfsl-library-code-vectors-arg*)
                         (stream-writer *pfsl-library-code-vectors-stream*)
      (let ((pfsl-segments (+ 2 (reduce '+ (mapcar 'count-pfsl-segments pfsl-pathnames))))
            (pfsl-file-count (length pfsl-pathnames))
            (initial-segment t)
            (final-segment nil)
            segment-pointer start-pos entry-point-pos)
        (fasl-out-word $fasl-file-id)
        (fasl-out-word pfsl-segments)
        (setq segment-pointer (file-position *pfsl-library-stream*))
        (dotimes (i pfsl-segments)
          (fasl-out-long 0)             ; address of i'th block
          (fasl-out-long 0))            ; length of i'th block
        ; The jump table goes first in the code section so that disassemble will do subprims correctly.
        (write-pfsl-library-jump-table *pfsl-library-code-vectors-stream*)
        ; The two words after the jump table are:
        ;    offset-of-this-word in the code section
        ;    code-section-size
        ; The code-section-size is use to initialize the size of the area structure when the library is loaded.
        (setq entry-point-pos (file-position *pfsl-library-code-vectors-stream*))
        (with-fasdump-output (nil *pfsl-library-code-vectors-writer* *pfsl-library-code-vectors-arg*)
          ; These are written over later
          (fasl-out-long 0)
          (fasl-out-long 0))
        (labels ((start-faslops (s)
                   (setq *copy-fasl-input-to-pfsl-library-stream-p* t)
                   (setq start-pos (file-position *pfsl-library-stream*))
                   (file-position *pfsl-library-stream* segment-pointer)
                   (fasl-out-long start-pos)
                   (file-position *pfsl-library-stream* start-pos)
                   (incf segment-pointer 8)
                   (when initial-segment
                     ; Emit fasl ops to open the library
                     (fasl-out-word (+ #xff00 $fasl-vers))
                     (fasl-out-long 0)          ; kernel version, ignored in pfsl files.
                     (fasl-out-byte $fasl-library-pointer)
                     (fasl-out-long 0)
                     ; This is pretty disgusting, going inside the file compiler this way.
                     (let ((*fasdump-epush* nil))
                       (fasl-dump-dispatch library-name))
                     (fasl-out-byte $faslend)
                     (end-faslops s)
                     (setq initial-segment nil)
                     (start-faslops s)))
                 (end-faslops (s)
                   (when (and provide-modules-p (not initial-segment))
                     (file-position *pfsl-library-stream* (1- (file-position *pfsl-library-stream*)))
                     (fasl-out-byte $fasl-provide)
                     ; My disgust grows
                     (let ((*fasdump-epush* nil))
                       (fasl-dump-dispatch (string-upcase (pathname-name *loading-file-source-file*))))
                     (fasl-out-byte $faslend))
                   (setq *copy-fasl-input-to-pfsl-library-stream-p* nil)
                   (let ((pos (file-position *pfsl-library-stream*)))
                     (file-position *pfsl-library-stream* (- segment-pointer 4))
                     (fasl-out-long (- pos start-pos))
                     (file-position *pfsl-library-stream* pos))
                   (when (and final-segment (not initial-segment))
                     ; Write a $fasl-library-pointer op to insert the pfsl-library.end cons
                     (setq final-segment nil)
                     (start-faslops s)
                     (fasl-out-word (+ #xff00 $fasl-vers))
                     (fasl-out-long 0)          ; kernel version, ignored in pfsl files.
                     (fasl-out-byte $fasl-library-pointer)
                     (fasl-out-long 1)
                     (fasl-out-byte $faslend)
                     (setq initial-segment t)
                     (end-faslops s)
                     (setq initial-segment nil))))
          (dolist (path pfsl-pathnames)
            (multiple-value-bind (*load-pathname* *load-truename* source-file) (find-load-file (merge-pathnames path))
              (unless *load-truename*
                (return (signal-file-error $err-no-file path)))
              (setq path *load-truename*)
              (unless (eq (mac-file-type path) :pfsl)
                (error "~S is not a PPC FASL file ." path))
              (let* ((*readtable* *readtable*)
                     (*package* *package*)   ; maybe just *package*
                     (*loading-files* (cons path *loading-files*))
                     (*loading-file-source-file* (namestring source-file)))
                (when *load-verbose*
                  (format t "~&;Loading ~S..." *load-pathname*)
                  (force-output))
                (copying-fasl-input-to-pfsl-library-stream
                  (setq *copy-fasl-input-to-pfsl-library-stream-p* nil)     ; don't copy headers
                  (when (eql 0 (decf pfsl-file-count))
                    (setq final-segment t))
                  (multiple-value-bind (winp err)
                                       (%fasload (mac-namestring path)
                                                 *pfsl-library-dispatch-table*
                                                 #'start-faslops
                                                 #'end-faslops)
                    (if (not winp) (%err-disp err))))))))
        ; Write the code-section-size word to the first longword in the *pfsl-code-vectors-stream*
        (let* ((stream *pfsl-library-code-vectors-stream*)
               (pos (file-position stream)))
          (with-fasdump-output (nil  *pfsl-library-code-vectors-writer* *pfsl-library-code-vectors-arg*)
            (file-position stream entry-point-pos)
            (fasl-out-long entry-point-pos)
            (fasl-out-long pos)
            (file-position stream pos)))
        entry-point-pos))))

; Eventually, we can save the extra branch in the kernel jump table
; by making a table of subprim addresses and referencing that instead.
; Then again, that may be no faster, since it's the same number of memory references
; and is more pressure on the cache.
; This code assumes that imm4 is not a parameter to any subprim.
(defparameter *jump-table-function*
  (let (jump-table code)
    (push '(nop) jump-table)
    (dotimes (i 256)                    ; should be enough subprims for the foreseeable future.
      (let ((label (intern (format nil "@~d" i) 'ccl)))
        (push `(b ,label) jump-table)
        (push label code)
        (push '(ref-global imm4 subprims-base) code)
        (push `(la imm4 ,(* 4 i) imm4) code)
        (push '(mtctr imm4) code)
        (push '(bctr) code)))
    (compile nil `(lambda (&lap 0)
                    (ppc-lap-function nil ()
                     ,@(nreverse jump-table)
                     ,@(nreverse code))))))

; Write the jump table.
; This jump table trampolines to the copy in the system heap.
(defun write-pfsl-library-jump-table (stream)
  (with-fasdump-output (stream)
    (let* ((code-vector (uvref *jump-table-function* 0))
           (code-vector-size (uvsize code-vector))
           (header (ppc::make-vheader code-vector-size ppc::subtag-code-vector)))
      (fasl-out-long header)
      (dotimes (i code-vector-size)
        (fasl-out-long (uvref code-vector i)))
      ; double-word align
      (when (evenp code-vector-size)
        (fasl-out-long 0)))))

; Here's where the real work happens of replacing code vectors
; with a pointer to the shared library.
; For now, we write out all code vectors to the *pfsl-library-code-vectors-stream*.
; Later, that file will be copied to a pef container in the shared library file.
#+ppc-target
(def-pfsl-library-faslop $fasl-ivec (s)
  (pfsl-library-process-ivec s))

(defun pfsl-library-process-ivec (s)
  (let* ((out-pos (stream-position *pfsl-library-stream*))
         (subtag (%fasl-read-byte s))
         (element-count (%fasl-read-size s))
         (size-in-bytes (ppc-subtag-bytes subtag element-count)))
    (declare (fixnum subtag element-count size-in-bytes))
    (%epushval s nil)
    (if (not (or (= subtag ppc::subtag-code-vector)
                 (and *pfsl-library-read-only-strings-p*
                      (= subtag ppc::subtag-simple-base-string))))
      (dotimes (i size-in-bytes) (%fasl-read-byte s))
      (let ((header (ppc::make-vheader element-count subtag))
            (pointer (+ (stream-position *pfsl-library-code-vectors-stream*) ppc::fulltag-misc))
            (*copy-fasl-input-to-pfsl-library-stream-p* nil))
        (with-fasdump-output (nil *pfsl-library-code-vectors-writer* *pfsl-library-code-vectors-arg*)
          (fasl-out-long header)
          (if (= subtag ppc::subtag-code-vector)
            ; For code vectors, this needs to change ba to b and bla to bl and change
            ; the absolute jump table offsets to pc relative offsets to the library's jump table.
            ; The bx instruction is of the form:
            ;    ---------------------------------------
            ;   | 010010 |           LI           |AA|LK|
            ;    ---------------------------------------
            ; Where LI is the absolute target address if the AA bit is set,
            ; or a PC-relative offset otherwise.
            ; If the LK bit is set, its a branch & link instruction,
            ; otherwise just a branch.
            ; Should rewrite this eventually so that it doesn't cons.
            (let ((traceback-p nil)
                  (ba-mask #xfc000002)
                  (ba-value #x48000002)
                  (li-mask #x03fffffc))
              (dotimes (i element-count)
                (let ((opcode (%fasl-read-long s)))
                  (when (eql 0 opcode) (setq traceback-p t))
                  (if (or traceback-p
                          (not (eql ba-value (logand opcode ba-mask))))
                    (fasl-out-long opcode)
                    (let* ((jump-table-offset (- (file-position *pfsl-library-code-vectors-stream*) 8))  ; code-vector header + nop
                           (new-li (- (logand opcode li-mask) jump-table-offset))
                           (new-opcode (bitclr 1        ; AA bit
                                               (logior (logand opcode (lognot li-mask)) (logand new-li li-mask)))))
                      (fasl-out-long new-opcode))))))
            (dotimes (i size-in-bytes)
              (fasl-out-byte (%fasl-read-byte s))))
          ; double-word align
          (let ((overflow (mod (+ 4 size-in-bytes) 8)))
            (declare (fixnum overflow))
            (unless (eql overflow 0)
              (dotimes (i (- 8 overflow))
                (declare (fixnum i))
                (fasl-out-byte 0)))))
        ; Write a $fasl-library-pointer op
        (stream-position *pfsl-library-stream* (1- out-pos))    ; back over $fasl-ivec opcode
        (fasl-out-byte $fasl-library-pointer)
        (fasl-out-long pointer)))))

(copy-pfsl-library-faslop $fasl-noop)

(copy-pfsl-library-faslop $fasl-etab-alloc)

#+ppc-target
(copy-pfsl-library-faslop $fasl-arch)

(copy-pfsl-library-faslop $fasl-eref)

(def-pfsl-library-faslop $fasl-lfuncall (s)
  (%fasl-expr-preserve-epush s)
  (%epushval s nil))

(def-pfsl-library-faslop $fasl-globals (s)
  (%fasl-expr s))

(copy-pfsl-library-faslop $fasl-char)

(copy-pfsl-library-faslop $fasl-fixnum)

(def-pfsl-library-faslop $fasl-float (s)
  (%fasl-read-long s)
  (%fasl-read-long s)
  (%epushval s nil))

(def-pfsl-library-faslop $fasl-str (s)
  (let* ((n (%fasl-read-size s)))
    (%epushval s nil)
    (dotimes (i n) (%fasl-read-byte s))))

(copy-pfsl-library-faslop $fasl-word-fixnum)

(def-pfsl-library-faslop $fasl-mksym (s)
  (%pfsl-library-readstr s)
  (%epushval s nil))

(defun %pfsl-library-readstr (s)
  (let ((n (%fasl-read-size s)))
    (dotimes (i n) (%fasl-read-byte s))))

(def-pfsl-library-faslop $fasl-intern (s)
  (%pfsl-library-intern s *package*))

(defun %pfsl-library-intern (s pkg)
  (declare (ignore pkg))
  (%pfsl-library-readstr s)
  (%epushval s nil))

(def-pfsl-library-faslop $fasl-pkg-intern (s)
  (let* ((pkg (%fasl-expr-preserve-epush s)))
    (%pfsl-library-intern s pkg)))

(def-pfsl-library-faslop $fasl-pkg (s)
  (%pfsl-library-package s))

(defun %pfsl-library-package (s)
  (%pfsl-library-readstr s)
  (%epushval s nil))

(def-pfsl-library-faslop $fasl-cons (s)
  (%epushval s nil)
  (%fasl-expr s)                        ; car
  (%fasl-expr s)                        ; cdr
  )

(def-pfsl-library-faslop $fasl-list (s)
  (%pfsl-library-listX s nil))

(def-pfsl-library-faslop $fasl-list* (s)
  (%pfsl-library-listX s t))

(defun %pfsl-library-listX (s dotp)
  (let* ((len (%fasl-read-word s)))
    (declare (fixnum len))
    (%epushval s nil)
    (%fasl-expr s)
    (dotimes (i len)
      (%fasl-expr s))
    (when dotp
      (%fasl-expr s))))

(copy-pfsl-library-faslop $fasl-nil)

(copy-pfsl-library-faslop $fasl-timm)

; N/A on PPC
#-ppc-target
(def-pfsl-library-faslop $fasl-lfun (s)
  (%epushval s nil)
  (%fasl-expr s))

; N/A on PPC
#-ppc-target
(def-pfsl-library-faslop $fasl-eref-lfun (s)
  (%fasl-read-word s)
  (%epushval s nil))

(def-pfsl-library-faslop $fasl-symfn (s)
  (%epushval s (%fasl-expr-preserve-epush s)))
    
(def-pfsl-library-faslop $fasl-eval (s)
  (%epushval s (%fasl-expr-preserve-epush s)))

(def-pfsl-library-faslop $fasl-gvec (s)
  (let* ((subtype (%fasl-read-byte s))
         (n (%fasl-read-size s)))
    (declare (ignore subtype))
    (%epushval s nil)
    (dotimes (i n)
      (%fasl-expr s))))

#-ppc-target    
(def-pfsl-library-faslop $fasl-nlfvec (s)
  (let* ((size-in-bytes (%fasl-read-size s)))
    (%epushval s nil)
    (dotimes (i size-in-bytes) (%fasl-read-byte s))))
          
(copy-pfsl-library-faslop $fasl-xchar)
    
(def-pfsl-library-faslop $fasl-mkxsym (s)
  (%pfsl-library-readstr s)
  (%epushval s nil))

(def-pfsl-library-faslop $fasl-defun (s)
  (%cant-epush s)
  (progn (%fasl-expr s) (%fasl-expr s)))

(def-pfsl-library-faslop $fasl-macro (s)
  (%cant-epush s)
  (progn (%fasl-expr s) (%fasl-expr s)))

(def-pfsl-library-faslop $fasl-defconstant (s)
  (%cant-epush s)
  (progn (%fasl-expr s) (%fasl-expr s) (%fasl-expr s)))

(def-pfsl-library-faslop $fasl-defparameter (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore sym val doc))
    nil))

; (defvar var)
(def-pfsl-library-faslop $fasl-defvar (s)
  (%cant-epush s)
  (progn (%fasl-expr s)))

; (defvar var initfom doc)
(def-pfsl-library-faslop $fasl-defvar-init (s)
  (%cant-epush s)
  (let* ((sym (%fasl-expr s))
         (val (%fasl-expr s))
         (doc (%fasl-expr s)))
    (declare (ignore sym val doc))
    nil))

(copy-pfsl-library-faslop $fasl-skip)

(copy-pfsl-library-faslop $fasl-prog1)

(def-pfsl-library-faslop $fasl-xintern (s)
  (%pfsl-library-intern s *package*))

(def-pfsl-library-faslop $fasl-pkg-xintern (s)
  (let* ((pkg (%fasl-expr-preserve-epush s)))
    (%pfsl-library-intern s pkg)))

(def-pfsl-library-faslop $fasl-xpkg (s)
  (%pfsl-library-package s))

(def-pfsl-library-faslop $fasl-src (s)
  (%cant-epush s)
  (let* ((source-file (%fasl-expr s)))
    (declare (ignore source-file)))
  nil)

; We don't yet support including a pfsl-library in another one.
; When we do, remove the error below.
(def-pfsl-library-faslop $fasl-library-pointer (s)
  (error "Found a ~s op" '$fasl-library-pointer)
  (let ((offset (%fasl-read-long s)))
    (when (eql offset 0)
      (%fasl-expr s))))

#|

(defun file-vect (file)
  (with-open-file (s file :element-type '(unsigned-byte 8))
    (let* ((size (file-length s))
           (vect (make-array size :element-type '(unsigned-byte 8))))
      (dotimes (i size)
        (setf (aref vect i) (read-byte s)))
      vect)))

|#