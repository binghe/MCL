;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  5 10/26/95 akh  damage control
;;  4 10/26/95 gb   bad fencepost in encode-relative-relocations.  Use macros,
;;                  constants for relocation instructions.
;;  (do not edit before this line!!)

; Modification History
;
; write-pef-cfrg heeds *use-app-resources*
; ------ 5.2b6
; 07/02/05 defstruct pef-header say :element-type 'base-character
; ------ 5.1 final
; don't round up section sizes from gb
; ------ 4.4b5
; akh add 'carb' 0 resource, some requires
; ------- 4.4b2
;  5/15/96 slh   now: use _LMGetTime
; 02/20/96 gb    export some symbols, just to prove we can.
; 01/05/96 gb    set code section's "sharing kind" to "kPEFglobalshare".
; 01/03/96 bill  make the bits in the SIZE resource agree with those in CCL 3.0x
;                Most important here is setting the "Accept Suspend Events" bit.
; 12/05/95 slh   update trap names
; 08/16/95 gb    copy *SIOW-RESOURCE-PATHNAME*'s resource fork's contents to output file.

(in-package "CCL")

(eval-when (:compile-toplevel :execute)
  (require :xsym "ccl:xdump;xsym")
  (require :xppcfasload "ccl:xdump;xppcfasload")
  (defconstant DDAT-opcode 0)
  (defconstant DDAT-opcode-byte (byte 2 14))
  (defconstant DDAT-w-byte (byte 8 6))
  (defconstant DDAT-n-byte (byte 6 0))
  (defmacro make-DDAT (w n)
    `(dpb DDAT-OPCODE DDAT-opcode-byte (dpb ,w DDAT-w-byte (dpb ,n DDAT-n-byte 0))))

;
  (defconstant var2-opcode 2)
  (defconstant var2-opcode-byte (byte 3 13))
  (defconstant var2-subop-byte (byte 4 9))
  (defconstant var2-count-byte (byte 9 0))
  (defconstant CODE-opcode 0)
  (defconstant DATA-opcode 1)
  (defconstant DESC-opcode 2)
  (defconstant DSC2-opcode 3)
  (defconstant VTBL-opcode 4)
  (defconstant SYMR-opcode 5)
  (defmacro make-var2 (subop count)
    `(dpb var2-opcode var2-opcode-byte (dpb ,subop var2-subop-byte (dpb (1- ,count) var2-count-byte 0))))
  (defmacro make-CODE (count)
    `(make-var2 CODE-opcode ,count))
  (defmacro make-DATA (count)
    `(make-var2 DATA-opcode ,count))
  (defmacro make-DESC (count)
    `(make-var2 DESC-opcode ,count))
  (defmacro make-DSC2 (count)
    `(make-var2 DSC2-opcode ,count))
  (defmacro make-VTBL (count)
    `(make-var2 VTBL-opcode ,count))
  (defmacro make-SYMR (count)
    `(make-var2 SYMR-opcode ,count))
;
  (defconstant var3-opcode 3)
  (defconstant var3-opcode-byte (byte 3 13))
  (defconstant var3-subop-byte (byte 4 9))
  (defconstant var3-idx-byte (byte 9 0))
  (defconstant SYMB-opcode 0)
  (defconstant CDIS-opcode 1)
  (defconstant DTIS-opcode 2)
  (defconstant SECN-opcode 3)
  (defmacro make-var3 (subop idx)
    `(dpb var3-opcode var3-opcode-byte (dpb ,subop var3-subop-byte (dpb ,idx var3-idx-byte 0))))
  (defmacro make-SYMB (idx)
    `(make-var3 SYMB-opcode ,idx))
  (defmacro make-CDIS (idx)
    `(make-var3 CDIS-opcode ,idx))
  (defmacro make-DTIS (idx)
    `(make-var3 DTIS-opcode ,idx))
  (defmacro make-SECN (idx)
    `(make-var3 SECN-opcode ,idx))
;
  (defconstant DELTA-opcode 8)
  (defconstant DELTA-opcode-byte (byte 4 12))
  (defconstant DELTA-b-byte (byte 12 0))
  (defmacro make-DELTA (b)
    `(dpb DELTA-opcode DELTA-opcode-byte (dpb (1- ,b) DELTA-b-byte 0)))
;
  (defconstant RPT-opcode 9)
  (defconstant RPT-opcdode-byte (byte 4 12))
  (defconstant RPT-i-byte (byte 4 8))
  (defconstant RPT-cnt-byte (byte 8 0))
  (defmacro make-RPT (i cnt)
    `(dpb RPT-opcode RPT-opcode-byte (dpb (1- ,i) RPT-i-byte (dpb (1- ,cnt) RPT-cnt-byte 0))))
;
  (defconstant var10-opcode 10)
  (defconstant var10-opcode-byte (byte 4 12))
  (defconstant var10-opcode-subop-byte (byte 2 10))
  (defconstant var10-opcode-offset-high-byte (byte 10 0))
  (defconstant LABS-opcode 0)
  (defconstant LSYM-opcode 1)
  (defmacro make-var10 (subop offset-high-10)
    `(dpb var10-opcode var10-opcode-byte 
          (dpb ,subop var10-opcode-subop-byte 
               (dpb ,offset-high-10 var10-opcode-offset-high-byte 0))))
;
  (defconstant var11-opcode 11)
  (defconstant var11-opcode-byte (byte 4 12))
  (defconstant var11-subop-byte (byte 2 10))

)
    

  


(defmacro round-up (num size)
  "Rounds number up to be an integral multiple of size."
  (let ((size-var (gensym)))
    `(let ((,size-var ,size))
       (* ,size-var (ceiling ,num ,size-var)))))

(defconstant kPEFContextShare 1)
(defconstant kPEFGlobalShare 4)

(defconstant kCodeSection 0)
(defconstant kDataSection 1)

; Using kPEFGlobalShare as the default is ultimately wrong, but
; the object file may load faster and require less memory.
(defparameter *pef-default-section-sharing-kind* kPEFContextShare)

(defun write-halfword (h f)
  (write-byte (ldb (byte 8 8) h) f)
  (write-byte (ldb (byte 8 0) h) f))

(defun write-fullword (w f)
  (write-halfword (ldb (byte 16 16) w) f)
  (write-halfword (ldb (byte 16 0) w) f))

(defun write-ostype (o f)
  (ccl:rlet ((tp :ostype))
    (setf (ccl::%get-ostype tp) o)
    (write-fullword (ccl::%get-unsigned-long tp) f)))

(defun displaced-string-index (s)
  (if s (nth-value 1 (ccl::array-data-and-offset s)) -1))

(defun required-argument ()
  (error "Missing argument. "))

(defstruct pef-header
  (file-stream (required-argument) :type stream)
  (magic :|Joy!|)
  (container-id :|peff|)
  (architecture-id :|pwpc|)
  (version 1)
  (timestamp 0 :type (unsigned-byte 32))
  (old-def-version 0 :type (unsigned-byte 32))
  (old-imp-version 0 :type (unsigned-byte 32))
  (current-version 0 :type (unsigned-byte 32))
  (loadsections nil :type list)
  (noloadsections nil :type list)
  (memory-address 0 :type (unsigned-byte 32))
  (loader-header nil)
  (global-string-table (make-array 256 :element-type 'base-character
                                   :fill-pointer 0
                                   :displaced-to (make-string 256 :element-type 'base-character :initial-element #\null)
                                   :displaced-index-offset 0
                                   :adjustable t))
  (loader-string-table (make-array 256 :element-type 'base-character
                                   :fill-pointer 0
                                   :displaced-to (make-string 256 :element-type 'base-character :initial-element #\null)
                                   :displaced-index-offset 0
                                   :adjustable t)))


(defun now ()
  (get-time-unsigned-long))
  
(defun write-pef-header (p)
  (let* ((f (pef-header-file-stream p)))
    (check-type p pef-header)
    (write-ostype (pef-header-magic p) f)
    (write-ostype (pef-header-container-id p) f)
    (write-ostype (pef-header-architecture-id p) f)
    (write-fullword (pef-header-version p) f)
    (write-fullword (pef-header-timestamp p) f)
    (write-fullword (pef-header-old-def-version p) f)
    (write-fullword (pef-header-old-imp-version p) f)  
    (write-fullword (pef-header-current-version p) f)
    (write-halfword (+ (length (pef-header-loadsections p))
                       (length (pef-header-noloadsections p))) f)
    (write-halfword (length (pef-header-loadsections p)) f)
    (write-fullword (pef-header-memory-address p) f)))

(defstruct (pef-section-header (:conc-name sect-))
  (pef-header nil :type pef-header)
  (section-number (required-argument) :type (signed-byte 32))
  (name nil :type (or null string))
  (address 0 :type (unsigned-byte 32))
  (exec-size 0 :type (unsigned-byte 32))
  (init-size 0 :type (unsigned-byte 32))
  (raw-size 0 :type (unsigned-byte 32))
  (container-offset 0 :type (unsigned-byte 32))
  (region-kind kDataSection :type (unsigned-byte 8))
  (sharing-kind *pef-default-section-sharing-kind* :type (unsigned-byte 8))
  (alignment 4 :type (unsigned-byte 8))
  (relocation-instructions nil :type (or null (array (unsigned-byte 16) (*))))
  (exports-from nil :type list)
  (nominal-start-address 0 :type (unsigned-byte 32))
  (nominal-end-address 0  :type (unsigned-byte 32))
  (data-vector (required-argument) :type (or (array (unsigned-byte 32) (*))
                                             (array (unsigned-byte 8) (*))))
  (ref-bits (required-argument) :type (OR NULL (simple-array bit (*))))
  (toc-words 0 :type (unsigned-byte 32))
  (toc-relocations nil :type list)
  (header-disk-address 0 :type (unsigned-byte 32)))

(defun write-pef-section-header (s)
  (let* ((f (pef-header-file-stream (sect-pef-header s))))
    ; Remember where we are so header can be rewritten when container offset known
    (if (zerop (sect-header-disk-address s))
      (setf (sect-header-disk-address s) (file-position f)))
    (let* ((name (sect-name s)))
      (write-fullword (if name (displaced-string-index name) -1) f))
    (write-fullword 0 f) ; vm address of section
    (write-fullword (sect-exec-size s) f)
    (write-fullword (sect-init-size s) f)
    (write-fullword (sect-raw-size s) f)
    (write-fullword (sect-container-offset s) f)
    (write-byte (sect-region-kind s) f)
    (write-byte (sect-sharing-kind s) f)
    (write-byte (sect-alignment s) f)
    (write-byte 0 f)))

(defun write-pef-global-string-table (p)
  (let* ((gst (pef-header-global-string-table p))
         (f (pef-header-file-stream p)))
    (dotimes (i (length gst))
      (write-byte (char-code (char gst i)) f))))

(defun align-file-to-section-constraints (f s)
  (let* ((curpos (file-position f))
         (newpos (round-up (file-position f) (ash 1 (sect-alignment s)))))
    (dotimes (i (- newpos curpos) (file-position f newpos)) (write-byte 0 f))))

(defun write-pef-section-contents (s)
  (let* ((f (pef-header-file-stream (sect-pef-header s))))
    (align-file-to-section-constraints f s)
    (setf (sect-container-offset s) (file-position f))
    (let* ((v (sect-data-vector s)))
      (if (typep v '(array (unsigned-byte 8) (*)))
        (let* ((v8 (ccl::array-data-and-offset v)))
          (ccl::write-from-vector f v8 :length (length v)))
        (ccl::write-from-vector f v :length (sect-raw-size s))))
    (let* ((curpos (file-position f)))
      (file-position f (sect-header-disk-address s))
      (write-pef-section-header s)
      (file-position f curpos))))

(defun add-global-string (string gst &optional null-term)
  (let* ((old-len (length gst))
         (str-len (length string)))
    (dotimes (i str-len)
      (vector-push-extend (char string i) gst))
    (if null-term
      (vector-push-extend #\null gst))
    (make-array str-len :element-type 'base-character
                :displaced-to gst
                :displaced-index-offset old-len)))

(defstruct (loader-header (:print-function print-loader-header))
  (pef-header nil :type (or null pef-header))
  (entry-section nil :type (or null pef-section-header))
  (entry-offset 0 :type (unsigned-byte 32))
  (init-section nil :type (or null pef-section-header))
  (init-offset 0 :type (unsigned-byte 32))
  (term-section nil :type (or null pef-section-header))
  (term-offset 0 :type (unsigned-byte 32))
  (import-files nil :type list)
  (hash-slots nil :type list)
  (hash-shift nil :type (or null (signed-byte 4)))
  (exports nil :type list))

(defun print-loader-header (lh stream depth)
  (declare (ignore depth))
  (print-unreadable-object (lh stream :type t)))

(defstruct (import-container)
  (loader-header nil :type (or null loader-header))
  (name nil :type string)
  (old-imp-version 0 :type (unsigned-byte 32))
  (current-imp-version 0 :type (unsigned-byte 32))
  (import-syms nil :type list)
  (init-flag 0 :type (unsigned-byte 8)))

(defstruct (import)
  (name (required-argument) :type string)
  (container (required-argument) :type import-container)
  (class (required-argument) :type symbol)
  (ordinal (required-argument) :type (unsigned-byte 32)))

(defparameter *pef-symbol-class-alist*
  '((:code . 0) (:data . 1) (:transfer-vector . 2) (:toc . 3) (:glue . 4)))

(defun encode-symbol-class (class-name)
  (or (cdr (assoc class-name *pef-symbol-class-alist*))
      (error "Unknown symbol class : ~s" class-name)))

; File position is properly aligned on entry
(defun write-section-data (s)
  (let* ((f (pef-header-file-stream (sect-pef-header s)))
         (data (sect-data-vector s)))
    (setf (sect-container-offset s) (file-position f))
    (dotimes (i (length data))
      (write-fullword (aref data i) f))))

(defun output-byte (b v)
  (vector-push-extend b v))

(defun output-halfword (h v)
  (output-byte (ldb (byte 8 8) h) v)
  (output-byte (ldb (byte 8 0) h) v))

(defun output-fullword (w v)
  (output-halfword (ldb (byte 16 16) w) v)
  (output-halfword (ldb (byte 16 0) w) v))

(defun backpatch-vector (v offset)
  (let* ((len (length v)))
    (setf (fill-pointer v) offset)
    (output-fullword len v)
    (setf (fill-pointer v) len)))

(defun output-import-file (ic v start-import)
  (output-fullword (displaced-string-index (import-container-name ic)) v)
  (output-fullword (import-container-old-imp-version ic) v)
  (output-fullword (import-container-current-imp-version ic) v)
  (let* ((num-imports (length (import-container-import-syms ic))))
    (output-fullword num-imports v)
    (output-fullword start-import v)
    (output-byte (import-container-init-flag ic) v)
    (dotimes (i 3) (output-byte 0 v))
    (+ start-import num-imports)))
  
(defstruct (export-symbol (:print-function print-export-symbol))
  (name (required-argument) :type string)
  (section (required-argument) :type pef-section-header)
  (class nil :type symbol)
  (hash-code 0 :type (unsigned-byte 32))
  (hash-slot-index 0 :type (unsigned-byte 32))
  (value (required-argument) :type (unsigned-byte 32)))

(defun create-loader-data (lh)
  (let* ((pef-header (loader-header-pef-header lh))
         (sections (pef-header-loadsections pef-header))
         (lst (pef-header-loader-string-table pef-header))
         (v (make-array 1024 
                        :element-type '(unsigned-byte 8) 
                        :initial-element 0
                        :adjustable t
                        :fill-pointer 0)))
    (flet ((maybe-section-number (section)
             (if section (sect-section-number section) -1)))
      (output-fullword (maybe-section-number (loader-header-entry-section lh)) v)
      (output-fullword (loader-header-entry-offset lh) v)
      (output-fullword (maybe-section-number (loader-header-init-section lh)) v)
      (output-fullword (loader-header-init-offset lh) v)
      (output-fullword (maybe-section-number (loader-header-term-section lh)) v)
      (output-fullword (loader-header-term-offset lh) v))
    (let* ((num-import-files 0)
           (num-imports 0))
      (dolist (import-file (loader-header-import-files lh))
        (incf num-import-files)
        (incf num-imports (length (import-container-import-syms import-file))))
      (output-fullword num-import-files v)
      (output-fullword num-imports v))
    (let* ((numrelocsections 0))
      (dolist (section sections)
        (when (> (length (sect-relocation-instructions section)) 0)
          (incf numrelocsections)))
      (output-fullword numrelocsections v))
    (output-fullword 0 v)             ; relocation table offset @36
    (output-fullword 0 v)             ; lst offset @40
    (output-fullword 0 v)             ; hash slot table offset @44
    (output-fullword (or (loader-header-hash-shift lh) 0) v)
    (output-fullword (length (loader-header-exports lh)) v)


    (let* ((start-import 0))
      (dolist (import-file (loader-header-import-files lh))
        (setq start-import (output-import-file import-file v start-import))))
    (dolist (import-file (loader-header-import-files lh))
      (dolist (import (reverse (import-container-import-syms import-file)))
        (output-fullword (dpb (encode-symbol-class (import-class import)) 
                             (byte 8 24) 
                             (displaced-string-index (import-name import))) 
                         v)))
    (let* ((start-reloc 0))
      (dolist (section sections)
        (let* ((numinst (length (sect-relocation-instructions section))))
          (when (> numinst 0)
          (output-halfword (sect-section-number section) v)
          (output-halfword 0 v)
            (output-fullword numinst v)
            (output-fullword (ash start-reloc 1) v)
            (incf start-reloc numinst)))))
    (backpatch-vector v 36)
    (dolist (section sections)
      (let* ((ri (sect-relocation-instructions section)))
        (dotimes (i (length ri))
            (output-halfword (aref ri i) v))))
    (backpatch-vector v 40)
    (let* ((len (length lst)))
      (dotimes (i len) (output-byte (char-code (char lst i)) v))
      (unless (= 0 (setq len (logand len 3)))
        (dotimes (i (- 4 len)) (output-byte 0 v))))
    (let* ((first 0)
           (exports (loader-header-exports lh)))
      (when t; exports
        (backpatch-vector v 44)
       (dotimes (i (ash 1 (or (loader-header-hash-shift lh) 0)))
          (let* ((count (count-if #'(lambda (e) (= i (export-symbol-hash-slot-index e))) exports)))
            (output-fullword (dpb count (byte 14 18) first) v)
            (incf first count)))
        (dolist (exp exports)             ; hash chain table
          (output-fullword (export-symbol-hash-code exp) v))
        (dolist (exp exports)
          (output-fullword (dpb (encode-symbol-class (export-symbol-class exp))
                                (byte 8 24)
                                (displaced-string-index (export-symbol-name exp)))
                           v)
          (output-fullword (export-symbol-value exp) v)
          (output-halfword (sect-section-number (export-symbol-section exp)) v))))
    v))


; Each "import-spec" is of the form:
; (<container-name> version version &rest <import-names>)
;  each <import-name> is of the form:
;  (<symbol-class> <symbol-name> &rest <reference-addresses>)

(defun initialize-loader-header (pef-header sections import-specs)
  (let* ((lh (make-loader-header :pef-header pef-header))
         (lst (pef-header-loader-string-table pef-header))
         (import-num -1))
    (setf (pef-header-loader-header pef-header) lh)
    (dolist (import import-specs)
      (destructuring-bind (container-name imp-version current-version &rest import-names) import
        (let* ((container (make-import-container :loader-header lh
                                                 :old-imp-version imp-version
                                                 :current-imp-version current-version
                                                 :name (add-global-string container-name lst t))))
          (dolist (importname import-names)
            (destructuring-bind (class  name &rest refaddrs) importname
              (push (make-import :name (add-global-string name lst t)
                                 :container container
                                 :class class
                                 :ordinal (incf import-num))
                    (import-container-import-syms container))
              (dolist (refaddr refaddrs)
                (multiple-value-bind (from-sect  from-offset) (find-address-reference refaddr sections)
                  (push (make-import-relocation :from-section from-sect
                                                :from-offset from-offset
                                                :to-import import-num)
                        (sect-toc-relocations from-sect))))))
          (push container (loader-header-import-files lh)))))
    lh))

(defun hash-code (string)
  (let* ((len (length string))
         (hash 0))
    (flet ((rotl (x)
             (if (logbitp 31 x)         ; force arithmetic shift: treat x as signed 32-bit int.
               (logand #xffffffff (- (ash x 1) (ash (- x (ash 1 32)) -16)))
               (- (ash x 1) (ash x (- 16))))))    
      (dotimes (i len (logior (ash len 16) (logand #xffff (logxor hash (ash hash -16)))))
        (setq hash (logand #xffffffff (logxor (char-code (char string i))
                                              (rotl hash))))))))

; (format t "~x" (hash-code "NIL"))

(defparameter *average-hash-chain-size* 10)

(defun hash-slot-shift (lh)
  (or (loader-header-hash-shift lh)
      (setf (loader-header-hash-shift lh)
            (let* ((numexports (length (loader-header-exports lh)))
                   (chain-size *average-hash-chain-size*))
              (dotimes (i 13 13)
                (if (< (floor numexports (ash 1 i)) chain-size) (return i)))))))

(defun code-slot (code lh)
  (let* ((htshift (hash-slot-shift lh))) 
    (logand (1- (ash 1 htshift)) (logxor code (ash code (- htshift))))))

(defun string-slot (string lh)
  (code-slot (hash-code string) lh))



(defun print-export-symbol (es stream depth)
  (declare (ignore depth))
  (print-unreadable-object (es stream :type t)
    (format stream "~s : ~s @ ~d:#x~x hash #x~x / ~d"
            (export-symbol-name es)
            (export-symbol-class es)
            (sect-section-number (export-symbol-section es))
            (export-symbol-value es)
            (export-symbol-hash-code es)
            (export-symbol-hash-slot-index es))))

(defun add-export (pef-header name class section value)
  (let* ((es (make-export-symbol :class class
                                 :name (add-global-string name (pef-header-loader-string-table pef-header))
                                 :section section
                                 :hash-code (hash-code name)
                                 :value value)))
    (push es (sect-exports-from section))
    es))


(defun compute-export-hash-slots (lh)
  (let* ((exports nil))
    (dolist (section (pef-header-loadsections (loader-header-pef-header lh)))
      (setq exports (append exports (sect-exports-from section))))
    (setf (loader-header-exports lh) exports)
    (dolist (export exports)
      (setf (export-symbol-hash-slot-index export)
            (code-slot (export-symbol-hash-code export) lh)))
    (setf (loader-header-exports lh)
          (sort exports
                #'(lambda (e0 e1)
                    (or (< (export-symbol-hash-slot-index e0)
                           (export-symbol-hash-slot-index e1))
                        (and (= (export-symbol-hash-slot-index e0)
                                (export-symbol-hash-slot-index e1))                                                      
                             (> (export-symbol-value e0)
                                (export-symbol-value e1)))))))
    nil))

(defun toc-prefix (toc-hash-table toc-exports)
  (let* ((real-count (+ (length toc-exports) (hash-table-count toc-hash-table)) )
         (round-count (round-up real-count 4))
         (vec (make-array round-count :element-type '(unsigned-byte 32) :initial-element 0)))
    (maphash #'(lambda (k v)
                 (let* ((index (+ round-count (ash (+ #xb k) -2))))
                   (setf (aref vec index)
                         (case (car v)
                           (:reference (cdr v))
                           (:import 0)))))

             toc-hash-table)
    vec))


(defun find-address-reference (address sections &optional no-error)
  (dolist (section sections (if no-error (values nil nil) (error "Can't find address #x~x" address)))
    (let* ((start (sect-nominal-start-address section)))
      (when (>= (sect-nominal-end-address section) address start)
        (return (values section (- address start)))))))

(defun validate-relocations (sections)
  (dolist (sect sections)
    (let* ((nwords (ash (sect-raw-size sect) (- 2)))
           (bits (sect-ref-bits sect))
           (data (sect-data-vector sect)))
      (declare (fixnum nwords))
      (when bits
        (dotimes (i nwords)
          (declare (fixnum i))
          (unless (= 0 (sbit bits i))
            (let* ((refaddr (aref data i)))
              (multiple-value-bind (to-sect to-offset)
                                   (find-address-reference refaddr sections t)
                (unless (and to-sect to-offset)
                  (break "Invalid relocation in section ~s, byte offset ~d : #x~x"
                         sect (ash i 2) refaddr))))))))))




(defun prepend-ref-bits (pv ref-bits words-used)
  (if pv
    (let* ((pvlen (length pv))
           (newlen (+ pvlen words-used)))
      (if (<= newlen (length ref-bits))
        (progn
          (replace ref-bits ref-bits :start1 pvlen :end1 newlen :start2 0 :end2 words-used)
          (fill ref-bits 0 :start 0 :end pvlen))
        (concatenate '(simple-array bit) (make-array pvlen :element-type 'bit :initial-element 0) ref-bits)))
    ref-bits))

; prefix-vector is prepadded so as to be properly aligned
(defun initialize-section (pef-header sectnum space &optional (ntoc 0))
  (let* ((start-address (xppc-space-vaddr space))
         (nwords (ash (xppc-space-lowptr space) -2))
         (total-size nwords)
         (end-address (+ start-address (* total-size 4)))
         (data-vector (xppc-space-data space))
         (ref-bits (xppc-space-ref-map space))
         (code-p (not (position 1 ref-bits)))
         (sect (make-pef-section-header :name (add-global-string (string (xppc-space-name space)) 
                                                                  (pef-header-global-string-table pef-header) 
                                                                  t)
                                         :pef-header pef-header
                                         :nominal-start-address start-address
                                         :section-number sectnum
                                         :raw-size (* 4 total-size)
                                         :nominal-end-address end-address
                                         :data-vector data-vector
                                         :toc-words ntoc
                                         :region-kind (if code-p kCodeSection kDataSection)
                                         :sharing-kind (if code-p kPEFGlobalShare kPEFContextShare)
                                         :relocation-instructions (make-array 16 
                                                                              :element-type '(unsigned-byte 16)
                                                                              :adjustable t
                                                                              :fill-pointer 0)
                                         :ref-bits REF-BITS)))
    (setf (xppc-space-data space) nil)
    sect))

(defstruct (relocation (:print-function %print-relocation))
  (type (required-argument) :type symbol)
  (from-section (required-argument) :type pef-section-header)
  (from-offset (required-argument) :type (unsigned-byte 32)))

(defstruct (reference-relocation (:include relocation (type :reference)))
  (to-section (required-argument) :type pef-section-header))

(defstruct (import-relocation (:include relocation (type :import)))
  (to-import (required-argument) :type (unsigned-byte 32)))

(defun %print-relocation (r s d)
  (declare (ignore d))
  (print-unreadable-object (r s :type t)
    (format s " @ ~d:#x~x" (sect-section-number (relocation-from-section r)) (relocation-from-offset r))))

(defun relocate-sections (sections relocation-alist)
  (dolist (pef-section sections)
    (let* ((data-vector (sect-data-vector pef-section)))
      (dolist (reloc-spec relocation-alist)
        (destructuring-bind (fromsect from-offset tosect to-offset) reloc-spec
          (when (eq fromsect pef-section)
            (when (logtest 3 from-offset) (break "Bogus alignment!"))
            (setf (aref data-vector (ash from-offset -2)) to-offset)
            (push (make-reference-relocation :from-section pef-section
                                             :from-offset from-offset
                                             :to-section tosect)
                  (sect-toc-relocations pef-section))))))))

(defun decode-relocations (v &optional (start 0))
  (let* ((len (length v)))
    (do* ((i start (1+ i)))
         ((>= i len))
      (format t "~&")
      (let* ((r (aref v i))
             (majorop (ldb (byte 4 12) r)))
        (declare (type (unsigned-byte 16) r))
        (apply #'format t 
               (case majorop
                 ((0 1 2 3) `("DDAT ~d,~d" ,(ldb (byte 8 6) r) ,(ldb (byte 6 0) r)))
                 ((4 5)
                  (let* ((subop4 (ldb (byte 4 9) r)))
                    `("~a ~d"
                      ,(case subop4
                        (0 "CODE")
                        (1 "DATA")
                        (2 "DESC")
                        (3 "DSC2")
                        (4 "VTBL")
                        (5 "SYMR")
                        (t (format nil "?? <#x~x [~d]> ??" r majorop)))
                      ,(1+ (ldb (byte 9 0) r)))))
                 ((6 7)
                  (let* ((subop4 (ldb (byte 4 9) r)))
                    `("~a ~d"
                      ,(case subop4
                        (0 "SYMB")
                        (1 "CDIS")
                        (2 "DTIS")
                        (3 "SECN")
                        (t (format nil "?? <#x~x [~d]> ??" r majorop)))
                      ,(ldb (byte 9 0) r))))
                 (8
                  `("DELTA ~d" ,(1+ (ldb (byte 12 0) r))))
                 (9
                  `("RPT ~d,~d" ,(1+ (ldb (byte 4 8) r)) ,(1+ (ldb (byte 8 0) r))))
                 (10
                  (let* ((next (aref v (incf i)))
                         (disp (1+ (dpb (ldb (byte 10 0) r) (byte 10 16) next))))
                    `("~a ~d"
                      ,(case (ldb (byte 2 10) r)
                         (0 "LABS")
                         (1 "LSYM")
                         (t (format nil "?? <#x~x [~d]> ??" r majorop)))
                      ,disp)))
                 (11
                  (let* ((next (aref v (incf i)))
                         (disp (1+ (dpb (ldb (byte 6 0) r) (byte 6 16) next)))
                         (cnt (ldb (byte 4 6) r)))
                    (case (ldb (byte 2 10) r)
                      (0
                       `("LRPT ~d,~d" ,(1+ cnt) ,disp))
                      (1
                       `("~a ~d"
                         ,(case cnt
                            (0 "LSECN")
                            (1 "LCDIS")
                            (2 "LDTIS")
                            (t (format nil "?? <#x~x [~d]> ??" r majorop)))
                         ,disp)))))
                 (t `("Reserved/unimp #x~x" r))))))))



(defun encode-relative-relocations (s sections)
  (let* ((data (sect-data-vector s))
         (refs (sect-ref-bits s))
         (v (sect-relocation-instructions s))
         (last-section -1)
         (run-length 0)
         (run-length-limit 0)
         (raddr (ash (sect-toc-words s) 2))
         (last-reloc (1- (sect-toc-words s))))
    (flet ((push-inst (i)
             (vector-push-extend i v)))
      (do* ((rpos (position 1 refs :start (1+ last-reloc)) (position 1 refs :start (1+ rpos))))
           ((null rpos))
        (let* ((from-offset (ash rpos 2))
               (delta-bytes (- from-offset raddr))
               (delta-words (ash delta-bytes (- 2))))
          (multiple-value-bind (to-section to-offset) (find-address-reference (aref data rpos) sections)
            (setf (aref data rpos) to-offset)
            (let* ((to-snum (sect-section-number to-section)))
              (if (and (= to-snum last-section)
                       (= delta-bytes 0)
                       (< (incf run-length) run-length-limit))
                (incf (aref v (1- (length v))))
                (progn
                  (if (and (= to-snum 1)
                           (>= 255 delta-words 1))
                    (progn
                      (push-inst (make-DDAT delta-words 1))
                      (setq run-length-limit 64))
                    (progn
                      (unless (= delta-bytes 0)
                        (dotimes (i (ash delta-bytes -12))
                          (push-inst (make-DELTA 4096)))
                        (unless (= 0 (setq delta-bytes (logand 4095 delta-bytes)))
                          (push-inst (make-DELTA delta-bytes))))
                      (push-inst                       
                       (case to-snum
                         (0 (setq run-length-limit 512) (make-CODE 1))
                         (1 (setq run-length-limit 512) (make-DATA 1))
                         (t (setq run-length-limit 0) (make-SECN to-snum))))))
                  (setq last-section to-snum
                         run-length 1)))))
          (setq raddr (+ from-offset 4)))))))

                 
; This is pretty naive wrt repetition, etc.
; Should nuke the whole concept and introduce "external" pseudo-sections.
(defun encode-toc-relocations (s relocs)
  (let* ((v (sect-relocation-instructions s))
         (raddr 0))
    (flet ((push-inst (i) 
             (vector-push-extend i v)))
      (do* ((relocs relocs (cdr relocs))
            (r (car relocs) (car relocs)))
           ((null r) 
            (let* ((delta-bytes (- (ash (sect-toc-words s) 2) raddr)))
              (unless (= delta-bytes 0)
                (break "Need delta of ~d bytes after TOC." delta-bytes)
                (if (< delta-bytes 0)
                  (error "In fact, need NEGATIVE delta. Bug.")
                  (progn
                    (dotimes (i (ash delta-bytes -12))
                      (push-inst (make-DELTA 4096)))
                    (unless (= 0 (setq delta-bytes (logand 4095 delta-bytes)))
                      (push-inst (make-DELTA delta-bytes))))))

              v))
        (let* ((from-offset (relocation-from-offset r))
               (delta-bytes (- from-offset raddr)))
          (etypecase r
            (import-relocation
             (unless (= delta-bytes 0)
               (dotimes (i (ash delta-bytes -12))
                 (push-inst (make-DELTA 4096)))
               (unless (= 0 (setq delta-bytes (logand 4095 delta-bytes)))
                 (push-inst (make-DELTA delta-bytes))))
             (push-inst (make-SYMB (import-relocation-to-import r)))))
          (setq raddr (+ from-offset 4)))))))

(defun generate-relocation-instructions (sections)
  (dolist (s sections)
    (setf (sect-init-size s) (sect-raw-size s))        
    (when (sect-toc-relocations s)
      (encode-toc-relocations s (sort (sect-toc-relocations s) #'< :key #'relocation-from-offset)))
    (encode-relative-relocations s sections)))

; each descriptor is either of the form
; ("NAME" (section-number . offset))
(defun process-relative-exports (pef-header descriptors)
  (let* ((sections (pef-header-loadsections pef-header)))
    (dolist (desc descriptors)
      (destructuring-bind (name relative-section . offset) desc
        (add-export pef-header name (if (zerop relative-section) :code :data) (nth relative-section sections) offset)))))

(defparameter *pef-data-import-names*
  '())

(defun classify-import (name)
  (if (member name *pef-data-import-names* :test #'string=)
    :data
    :transfer-vector))

#|
; If we import from containers other than "pmcl-kernel", something will have to tell us what and where.

(defun process-toc-entries (toc-hash-table prefix-word-length sections)
  (let* ((toc-section (nth 1 sections))
         (data-vector (sect-data-vector toc-section))
         (nil-address (+ (ash prefix-word-length 2) #xb))
         (import-specs nil))
    (maphash #'(lambda (k v)
                 (let* ((from-offset (+ nil-address k))
                        (from-index (ash from-offset (- 2))))
                   (case (car v)
                     (:reference        ; not yet "normalized"
                      (multiple-value-bind (to-sect to-offset) (find-address-reference (aref data-vector from-index) sections)
                        (setf (aref data-vector from-index) to-offset)
                        (push (make-reference-relocation :from-section toc-section
                                                         :from-offset from-offset
                                                         :to-section to-sect)
                              (sect-toc-relocations toc-section))))
                     (:import
                      ; So far, a symbol is imported at most once (into the TOC.)
                      (push (list (classify-import (cdr v)) (cdr v) (cons toc-section from-offset)) import-specs)))))
             toc-hash-table)
    (cons "pmcl-kernel" import-specs)))
|#

(defun write-file-from-header (p)
  (write-pef-header p)
  (dolist (section (pef-header-loadsections p)) (write-pef-section-header section))
  (dolist (section (pef-header-noloadsections p)) (write-pef-section-header section))
  (write-pef-global-string-table p)
  (dolist (section (pef-header-noloadsections p)) (write-pef-section-contents section))
  (dolist (section (pef-header-loadsections p)) (write-pef-section-contents section)))

(defun create-cfrg-handle (component-name version &optional (is-app t))
  (let* ((cnamelen (length component-name))
         (prefix-size 32)
         (var-size (round-up (+ 42 1 cnamelen) 4))
         (hsize (+ prefix-size var-size))
         (h (#_NewHandleClear hsize)))
    (setf (ccl::%hget-long h 8) 1)      ; cfrg version
    (setf (ccl::%hget-long h 28) 1)     ; count
    (setf (ccl::%hget-ostype h (+ prefix-size 0)) "pwpc")
    (setf (ccl::%hget-long h (+ prefix-size 8))
          (setf (ccl::%hget-long h (+ prefix-size 12))
                version))
    (when is-app
      (setf (ccl::%hget-byte h (+ prefix-size 22)) 1))     ; kIsApp
    (setf (ccl::%hget-byte h (+ prefix-size 23)) 1)     ; kOnDiskFlat
    (setf (ccl::%hget-word h (+ prefix-size 40)) var-size)
    (setf (ccl::%hget-byte h (+ prefix-size 42)) cnamelen)
    (dotimes (i cnamelen)
      (setf (ccl::%hget-byte h (+ prefix-size 43 i)) (char-code (schar component-name i))))
    h))

;; this sucker contains icns, strs and plst from pmcl.r
(defparameter *siow-resource-pathname* "ccl:pmcl;siow_resources")

; This overwrites the files's resource fork.
; First, it copies the contents of *SIOW-RESOURCE-PATHNAME*'s resource fork.
(defun create-pef-cfrg (filename component-name version)
  (let* ((h (create-cfrg-handle component-name version))
         (sizeR (#_NewHandleClear 10)))
    (setf (%hget-word sizeR 0) #xd8e0)
    (setf (%hget-long sizeR 2) (ash 8 20))
    (setf (%hget-long sizeR 6) (ash 8 20))
    (let* ((namestring (namestring (truename filename))))
      (ccl::with-pstrs ((name namestring))
        (let* ((siow-file (probe-file *siow-resource-pathname*)))
          (if (and siow-file *use-app-resources*)
            (copy-file *siow-resource-pathname* namestring
                       :if-exists :supersede
                       :fork :resource)
            (#_HCreateResFile 0 0 name)))      
        (let* ((refnum (#_HOpenResFile 0 0 name #$fsrdwrperm)))
          (if (< refnum 0)
            (let* ((err (#_ResError)))
              (error "Can't open resource file ~s: error = ~d" filename err)))
          (let* ((oldh (#_Get1Resource "cfrg" 0)))
            (unless (ccl:%null-ptr-p oldh)
              (#_RemoveResource oldh)
              (#_DisposeHandle oldh)))
          (ccl::with-pstrs ((resname ""))
            (#_AddResource h "cfrg" 0 resname)
            #+carbon-compat
            (#_AddResource (#_newhandle 0) "carb" 0 resname)
            (#_AddResource sizeR "SIZE" -1 resname))
          (#_CloseResfile refnum))))))

(defparameter *pef-write-xsym-file* t)


(defmethod write-from-vector ((f output-file-stream) vector &key (start 0) (length (length vector)))
  (%fwrite-from-vector (slot-value f 'fblock) vector start length))


(defun pef-write-xsym-file (pef-name now sections unit&module-info)
  (let* ((xsym-path (merge-pathnames pef-name (make-pathname :type "xSYM"))))
    (with-open-file (f xsym-path 
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create
                       :element-type '(unsigned-byte 8))
      (let* ((xsym (make-xsym xsym-path f now :pef-filename (pathname-name pef-name) :pef-filetype "shlb" :pef-creator "????")))
        (xsym-new-rte xsym "CODE" 1 (sect-name (car sections)) (sect-exec-size (car sections)))
        (xsym-new-rte xsym "DATA" 1 (sect-name (cadr sections)) (sect-exec-size (cadr sections)))
        (let* ((unit-name-alist (mapcar #'list (mapcar #'car unit&module-info)))
               (allmods nil))
          (dolist (mods unit&module-info)
            (setq allmods (append allmods (cdr mods))))
          (setq allmods (sort (copy-list allmods) #'< :key #'cadr))
          (let* ((prog (xsym-new-program xsym (pathname-name pef-name))))
            (dolist (ucons unit-name-alist)
              (setf (cdr ucons) (xsym-new-unit xsym prog (car ucons)))))
          (let* ((mod-offset-pairs ()))
            (flet ((find-unit (m)
                     (let* ((uname (dolist (umod unit&module-info)
                                     (when (member m (cdr umod)) (return (car umod))))))
                       (if uname 
                         (cdr (assoc uname unit-name-alist :test #'eq))))))
              (dolist (mod allmods)
                (destructuring-bind (mod-name start length) mod
                  (multiple-value-bind (section offset) (find-address-reference start sections)
                    (push (cons (xsym-new-module xsym (find-unit mod) mod-name (1+ (sect-section-number section)) offset length)
                                0)
                          mod-offset-pairs)))))
            (xsym-new-file xsym "´´´ fasl files ´´´" now (reverse mod-offset-pairs)))
          (write-xsym-file xsym))))))



(defun write-pef-file (filename
                       component-name
                       version
                       read-only-space
                       dynamic-space
                       entrypoint
                       imports
                       &optional unit-info)
  (with-open-file (f filename
                     :direction :output
                     :if-does-not-exist :create
                     :if-exists :supersede
                     :element-type '(unsigned-byte 8) )
    (ccl::set-mac-file-type filename *pef-image-file-type*)
    (ccl::set-mac-file-creator filename "????")
    (let* ((now (now))
           (pef-header (make-pef-header :file-stream f :current-version version :timestamp now))
           (read-only-section (initialize-section pef-header 0 read-only-space))
           (dynamic-section (initialize-section pef-header 1 dynamic-space 2))
           (sections (list read-only-section dynamic-section )))
      (setf (pef-header-loadsections pef-header) sections)
      (validate-relocations sections)

      (setf (sect-exec-size read-only-section) (sect-raw-size read-only-section))
      (setf (sect-exec-size dynamic-section) (sect-raw-size dynamic-section))
      (when (and unit-info *pef-write-xsym-file*)
        (pef-write-xsym-file filename now sections unit-info))
      (process-relative-exports pef-header '(("code0" 0 . 0) ("data1" 1 . 0)))
      (let* ((lh (initialize-loader-header pef-header sections imports)))
        (when entrypoint
          (multiple-value-bind (entry-section entry-offset) (find-address-reference entrypoint sections)
            (setf (loader-header-entry-section lh) entry-section
                  (loader-header-entry-offset lh) entry-offset)))
        (compute-export-hash-slots lh)
        (generate-relocation-instructions sections)
        (let* ((load-data (create-loader-data lh)))
          (push (make-pef-section-header :name nil 
                                         :section-number 2 
                                         :alignment 4
                                         :pef-header pef-header
                                         :region-kind 4
                                         :sharing-kind 4
                                         :raw-size (length load-data)
                                         :ref-bits (make-array 0 :element-type 'bit)
                                         :data-vector load-data)
              (pef-header-noloadsections pef-header)))
        (write-file-from-header pef-header)
        (create-pef-cfrg filename component-name version)))))
