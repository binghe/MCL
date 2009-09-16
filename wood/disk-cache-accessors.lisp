;;;-*- Mode: Lisp; Package: ccl -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; disk-cache-accessors.lisp
;; low-level accessors for disk-cache's
;;
;; Copyright © 1996 Digitool, Inc.
;; Copyright © 1992-1995 Apple Computer, Inc.
;; All rights reserved.
;; Permission is given to use, copy, and modify this software provided
;; that Digitool is given credit in all derivative works.
;; This software is provided "as is". Digitool makes no warranty or
;; representation, either express or implied, with respect to this software,
;; its quality, accuracy, merchantability, or fitness for a particular
;; purpose.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;; some old lap constants ??
;;----------- MCL 5.1b1
;; ------------- 0.961
;; 09/19/96 bill The PPC version of %%load-pointer handles short floats now via %%load-short-float
;; 09/18/96 bill Fix brain-damage in PPC versions of read-double-float and (setf read-double-float)
;; ------------- 0.96
;; 06/14/96 bill AlanR's fix to read-double-float
;; ------------- 0.95
;; 03/20/96 bill Make work in MCL-PPC
;; ------------- 0.93
;; 05/25/95 bill more da -> da.l changes.
;; ------------- 0.9
;; 03/13/95 bill byte-array-p & ensure-byte-array-p move to "block-io-mcl.lisp"
;; 10/28/94 Moon Change without-interrupts to with-databases-locked.
;; 10/03/94 bill (setf wood::read-8-bits) no longer fails when writing
;;               less than 4 bytes from the end of the buffer.
;; 09/21/94 bill without-interrupts as necessary for interlocking
;; ------------- 0.8
;; 08/10/93 bill eval-when around requires of lapmacros & lispequ.
;; ------------- 0.6
;; 12/09/92 bill fill-long, fill-word, & fill-byte return right away if (<= count 0).
;; ------------- 0.5
;; 07/23/92 bill array-data-and-offset -> lenient-array-data-and-offset
;;               length -> uvector-bytes
;;               These make the code that saves and restores non-array
;;               ivectors (e.g. bignums, ratios, complex numbers)
;;               work correctly.
;; 07/20/92 bill da -> da.l where necessary.
;; ------------  0.1
;; 05/30/92 bill read-string & fill-xxx now skip $block-overhead
;; 03/16/92 bill New file.
;;

(in-package :ccl)                       ; So LAP works easily

;; from 5.0 lispequ - Lord knows
(eval-when (:compile-toplevel :load-toplevel :execute)
(defconstant $undefined #x07)  
(defconstant $illegal #x37)
(defconstant $t_imm_char #x27)
(defconstant $v_struct 36)
)


(export '(wood::read-long wood::read-unsigned-long
          wood::read-string wood::read-pointer
          wood::read-low-24-bits wood::read-8-bits
          wood::fill-long wood::fill-word wood::fill-byte)
        'wood)

(eval-when (:compile-toplevel :execute)
  #-ppc-target
  (require :lapmacros)
  (require :lispequ))

#+ppc-target
(progn

(declaim (inline %%load-long %%load-unsigned-long))

(defun %%load-long (array address)
  (declare (type (simple-array (unsigned-byte 16) (*)) array)
           (fixnum address)
           (optimize (speed 3) (safety 0)))
  (let* ((index (ash address -1))
         (high-word (aref array index))
         (low-word (aref array (the fixnum (1+ index)))))
    (declare (fixnum index high-word low-word))
    (if (logbitp 15 high-word)
      (progn
        (setq high-word (- high-word (expt 2 16)))
        (if (>= high-word (- (expt 2 (- 15 ppc::fixnum-shift))))
          (the fixnum
            (+ (the fixnum (ash high-word 16)) low-word))
          (+ (ash high-word 16) low-word)))
      (if (< high-word (expt 2 (- 15 ppc::fixnum-shift)))
        (the fixnum
          (+ (the fixnum (ash high-word 16)) low-word))
        (+ (ash high-word 16) low-word)))))

(defun %%load-unsigned-long (array address)
  (declare (type (simple-array (unsigned-byte 16) (*)) array)
           (fixnum address)
           (optimize (speed 3) (safety 0)))
  (let* ((index (ash address -1))
         (high-word (aref array index))
         (low-word (aref array (the fixnum (1+ index)))))
    (declare (fixnum index high-word low-word))
    (if (< high-word (expt 2 (- 15 ppc::fixnum-shift)))
      (the fixnum
        (+ (the fixnum (ash high-word 16)) low-word))
      (+ (ash high-word 16) low-word))))

)  ; end of #+ppc-target progn

(defun wood::read-long (disk-cache address)
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address)
     (declare (fixnum index count))
     (unless (and (>= count 4) (eql 0 (the fixnum (logand 1 index))))
       (error "Address odd or past eof: ~s" address))
     #-ppc-target
     (lap-inline ()
       (:variable array index)
       (move.l (varg array) atemp0)
       (move.l (varg index) da)
       (getint da)
       (move.l (atemp0 da.l $v_data) arg_z)
       (jsr_subprim $sp-mklong))
     #+ppc-target
     (%%load-long array index))))

(defmacro check-byte-array-address (address size array)
  (let ((addr (gensym)))
    `(let ((,addr ,address))
       (unless (and (<= 0 ,addr)
                    ,(if (eql size 1)
                       `(< ,addr (length ,array))
                       `(<= (the fixnum (+ ,addr ,size)) (length ,array))))
         (error "Attempt to access outside of buffer bounds")))))

(defun wood::%load-long (array address)
  (ensure-byte-array array)
  (unless (fixnump address)
    (setq address (require-type address 'fixnum)))
  (locally (declare (fixnum address))
    (check-byte-array-address address 4 array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    #-ppc-target
    (lap-inline ()
      (:variable array address immediate?)
      (move.l (varg array) atemp0)
      (move.l (varg address) da)
      (getint da)
      (move.l (atemp0 da.l $v_data) arg_z)
      (jsr_subprim $sp-mklong))
    #+ppc-target
    (%%load-long array address)))

(defun wood::read-unsigned-long (disk-cache address)
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address)
     (declare (fixnum index count))
     (unless (and (>= count 4) (eql 0 (the fixnum (logand 1 index))))
       (error "Address odd or past eof: ~s" address))
     #-ppc-target
     (lap-inline ()
       (:variable array index)
       (move.l (varg array) atemp0)
       (move.l (varg index) da)
       (getint da)
       (move.l (atemp0 da.l $v_data) arg_z)
       (jsr_subprim $sp-mkulong))
     #+ppc-target
     (%%load-unsigned-long array index))))

(defun wood::%load-unsigned-long (array address)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address))
    (check-byte-array-address address 4 array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    #-ppc-target
    (lap-inline ()
      (:variable array address)
      (move.l (varg array) atemp0)
      (move.l (varg address) da)
      (getint da)
      (move.l (atemp0 da.l $v_data) arg_z)
      (jsr_subprim $sp-mkulong))
    #+ppc-target
    (%%load-unsigned-long array address)))

#+ppc-target
(progn

(declaim (inline %%store-long))

(defun %%store-long (value array address)
  (declare (type (simple-array (unsigned-byte 16) (*)) array)
           (fixnum address)
           (optimize (speed 3) (safety 0)))
  (let ((index (ash address -1))
        (low-word 0)
        (high-word 0))
    (if (fixnump value)
      (locally (declare (fixnum low-word high-word address))
        (setq low-word (logand value #xffff)
              high-word (ash value -16)))
      (setq low-word (logand value #xffff)
            high-word (ash value -16)))
    (setf (aref array index) high-word
          (aref array (the fixnum (1+ index))) low-word))
  value)

)  ; end of #+ppc-target progn

(defun (setf wood::read-long) (value disk-cache address)
  (unless (>= (wood::disk-cache-size disk-cache)
              (+ address 4))
    (wood::extend-disk-cache disk-cache (+ address 4)))
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address t)
     (declare (fixnum index count))
     (unless (and (>= count 4) (eql 0 (the fixnum (logand 1 index))))
       (error "Address odd or past eof: ~s" address))
     #-ppc-target
     (lap-inline ()
       (:variable array index value)
       (move.l (varg value) arg_z)
       (jsr_subprim $sp-getxlong)
       (move.l (varg array) atemp0)
       (move.l (varg index) da)
       (getint da)
       (move.l acc (atemp0 da.l $v_data)))
     #+ppc-target
     (%%store-long value array index)))
  value)

(defsetf wood::read-unsigned-long (disk-cache address) (value)
  `(setf (wood::read-long ,disk-cache ,address) ,value))

(defun wood::%store-long (value array address)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address))
    (check-byte-array-address address 4 array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    #-ppc-target
    (lap-inline ()
      (:variable array address value)
        (move.l (varg value) arg_z)
        (jsr_subprim $sp-getxlong)
        (move.l (varg array) atemp0)
        (move.l (varg address) da)
        (getint da)
        (move.l acc (atemp0 da.l $v_data)))
    #+ppc-target
    (%%store-long value array address))
  value)

(defun wood::read-word (disk-cache address)
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address)
     (declare (fixnum index count))
     (unless (and (>= count 2) (eql 0 (the fixnum (logand 1 index))))
       (error "Address odd or past eof: ~s" address))
     #-ppc-target
     (lap-inline ()
       (:variable array index)
       (move.l (varg array) atemp0)
       (move.l (varg index) da)
       (getint da)
       (move.w (atemp0 da.l $v_data) acc)
       (ext.l acc)
       (mkint acc))
     #+ppc-target
     (locally (declare (type (simple-array (signed-byte 16)  (*)) array)
                       (optimize (speed 3) (safety 0)))
       (setq index (ash index -1))
       (aref array index)))))

(defun wood::%load-word (array address)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address))
    (check-byte-array-address address 2 array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    #-ppc-target
    (lap-inline ()
      (:variable array address)
      (move.l (varg array) atemp0)
      (move.l (varg address) da)
      (getint da)
      (move.w (atemp0 da.l $v_data) acc)
      (ext.l acc)
      (mkint acc))
    #+ppc-target
    (locally (declare (type (simple-array (signed-byte 16)  (*)) array)
                       (optimize (speed 3) (safety 0)))
       (setq address (ash address -1))
       (aref array address))))

(defun wood::read-unsigned-word (disk-cache address)
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address)
     (declare (fixnum index count))
     (unless (and (>= count 2) (eql 0 (the fixnum (logand 1 index))))
       (error "Address odd or past eof: ~s" address))
     #-ppc-target
     (lap-inline ()
       (:variable array index)
       (move.l (varg array) atemp0)
       (move.l (varg index) da)
       (getint da)
       (move.l ($ 0) acc)
       (move.w (atemp0 da.l $v_data) acc)
       (mkint acc))
     #+ppc-target
     (locally (declare (type (simple-array (unsigned-byte 16)  (*)) array)
                       (optimize (speed 3) (safety 0)))
       (setq index (ash index -1))
       (aref array index)))))

(defun wood::%load-unsigned-word (array address)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address))
    (check-byte-array-address address 2 array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    #-ppc-target
    (lap-inline ()
      (:variable array address)
      (move.l (varg array) atemp0)
      (move.l (varg address) da)
      (getint da)
      (move.l ($ 0) acc)
      (move.w (atemp0 da.l $v_data) acc)
      (mkint acc))
    #+ppc-target
    (locally (declare (type (simple-array (unsigned-byte 16)  (*)) array)
                      (optimize (speed 3) (safety 0)))
      (setq address (ash address -1))
      (aref array address))))

(defun (setf wood::read-word) (value disk-cache address)
  (setq value (require-type value 'fixnum))
  (unless (>= (wood::disk-cache-size disk-cache)
              (+ address 4))
    (wood::extend-disk-cache disk-cache (+ address 4)))
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address t)
     (declare (fixnum index count))
     (unless (and (>= count 2) (eql 0 (the fixnum (logand 1 index))))
       (error "Odd address: ~s" address))
     #-ppc-target
     (lap-inline ()
       (:variable array index value)
       (move.l (varg value) acc)
       (getint acc)
       (move.l (varg array) atemp0)
       (move.l (varg index) da)
       (getint da)
       (move.w acc (atemp0 da.l $v_data))
       (mkint acc))
     #+ppc-target
     (locally (declare (type (simple-array (unsigned-byte 16)  (*)) array)
                       (optimize (speed 3) (safety 0)))
       (setq index (ash index -1))
       (setf (aref array index) value)))))

(defsetf wood::read-unsigned-word (disk-cache address) (value)
  `(setf (wood::read-word ,disk-cache ,address) ,value))

(defun wood::%store-word (value array address)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address))
    (check-byte-array-address address 2 array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Address not word aligned: ~s" address))
    #-ppc-target
    (lap-inline ()
      (:variable value array address)
      (move.l (varg array) atemp0)
      (move.l (varg address) da)
      (getint da)
      (move.l (varg value) acc)
      (getint acc)
      (move.w acc (atemp0 da.l $v_data))
      (mkint acc))
    #+ppc-target
    (locally (declare (type (simple-array (unsigned-byte 16)  (*)) array)
                      (optimize (speed 3) (safety 0)))
      (setq address (ash address -1))
      (setf (aref array address) value))))


(declaim (inline wood::%%load-pointer wood::%%store-pointer))

; same as %load-pointer, but does no type checking
#-ppc-target
(defun wood::%%load-pointer (array address)
  (let (immediate?)
    (values
     (lap-inline ()
       (:variable array address immediate?)
       (move.l (varg array) atemp0)
       (move.l (varg address) da)
       (getint da)
       (move.l (atemp0 da.l $v_data) arg_z)
       (if# (ne (dtagp arg_z $t_fixnum $t_imm $t_sfloat))
         (movereg arg_z acc)
         (move.l '1 (varg immediate?))
         else#
         (jsr_subprim $sp-mkulong)))
     immediate?)))

; Same as %store-pointer, but doesn't type check
#-ppc-target
(defun wood::%%store-pointer (value array address &optional immediate?)
  (lap-inline ()
    (:variable array address value immediate?)
    (move.l (varg value) arg_z)
    (if# (eq (cmp.l (varg immediate?) nilreg))
      (jsr_subprim $sp-getxlong))
    (move.l (varg array) atemp0)
    (move.l (varg address) da)
    (getint da)
    (move.l acc (atemp0 da.l $v_data))))

#+ppc-target
(progn

; Load a Wood fixnum returning a lisp fixnum
(defppclapfunction wood::%%load-fixnum ((array arg_y) (address arg_z))
  (unbox-fixnum imm0 address)
  (la imm0 ppc::misc-data-offset imm0)
  (lwzx imm0 imm0 array)
  (srawi imm0 imm0 3)
  (box-fixnum arg_z imm0)
  (blr))

(defppclapfunction wood::%%store-fixnum ((value arg_x) (array arg_y) (address arg_z))
  (unbox-fixnum imm0 address)
  (la imm0 ppc::misc-data-offset imm0)
  (slwi imm1 value (- 3 ppc::fixnum-shift))
  (stwx imm1 imm0 array)
  (mr arg_z arg_x)
  (blr))

; Load a Wood character returning a lisp character
(defppclapfunction wood::%%load-character ((array arg_y) (address arg_z))
  (unbox-fixnum imm0 address)
  (la imm0 ppc::misc-data-offset imm0)
  (lwzx imm0 imm0 array)
  (li arg_z ppc::subtag-character)
  (rlwimi arg_z imm0 0 0 15)
  (blr))

(defppclapfunction wood::%%store-character ((value arg_x) (array arg_y) (address arg_z))
  (unbox-fixnum imm0 address)
  (la imm0 ppc::misc-data-offset imm0)
  (li imm1 $t_imm_char)
  (rlwimi imm1 value 0 0 15)
  (stwx imm1 imm0 array)
  (mr arg_z arg_x)
  (blr))

(defun wood::%%load-pointer (array address)
  (declare (optimize (speed 3) (safety 0))
           (fixnum address))
  (let* ((tag-byte
          (locally (declare (type (simple-array (unsigned-byte 8) (*)) array)
                            (optimize (speed 3) (safety 0)))
            (aref array (the fixnum (+ address 3)))))
         (tag (logand tag-byte 7)))
    (declare (fixnum tag-byte tag))
    (case tag
      (#.wood::$t_fixnum
       (values (wood::%%load-fixnum array address) t))
      (#.wood::$t_imm
       (values 
        (ecase tag-byte
          (#.$undefined (%unbound-marker-8))
          (#.$illegal (%illegal-marker))
          (#.$t_imm_char (wood::%%load-character array address)))
        t))
      (#.wood::$t_sfloat
       (values (wood::%%load-short-float array address) t))
      (t (%%load-unsigned-long array address)))))

(defun wood::%%load-short-float (array address)
  (declare (fixnum address)
           (type (simple-array (unsigned-byte 8) (*)) array)
           (optimize (speed 3) (safety 0)))
  (let* ((tag-byte (aref array (the fixnum (+ address 3))))
         (expt-byte (aref array address))
         (expt-bits (ash expt-byte -3))    ; 5 bits of exponent
         (expt (+ expt-bits
                  (the fixnum
                    (if (logbitp 4 expt-bits)
                      (- (ash 3 5) #x7f)
                      (- (ash 4 5) #x7f)))))
         (normalized-expt (+ expt #x3ff))
         (byte-1 (aref array (the fixnum (+ address 1))))
         (byte-2 (aref array (the fixnum (+ address 2))))
         (mantissa (+ (the fixnum (ash tag-byte -4))
                      (the fixnum (ash byte-2 4))
                      (the fixnum (ash byte-1 12))
                      (the fixnum (ash (the fixnum (logand expt-byte 7)) 20))))
         (negative (logbitp 3 tag-byte))
         (word-0 (+ (the fixnum (ash normalized-expt 4))
                    (the fixnum (ash mantissa -19))))
         (word-1 (logand (the fixnum (ash mantissa -3)) #xffff))
         (word-2 (ash (logand mantissa 7) 13))
         (res (%copy-float 0.0)))
    (declare (type fixnum tag-byte expt-byte expt-bits expt normalized-expt byte-1 byte-2 mantissa
                   word-0 word-1 word-2)
             (type (simple-array (unsigned-byte 16) (*)) res)       ; lie
             )
    (when negative
      (incf word-0 #x8000))
    ;(print-db word-0 word-1 word-2)
    (setf (aref res 2) word-0
          (aref res 3) word-1
          (aref res 4) word-2
          (aref res 5) 0)
    res))

(defun wood::%%store-pointer (value array address &optional imm?)
  (cond ((not imm?)
         (%%store-long value array address))
        ((fixnump value) (wood::%%store-fixnum value array address))
        ((characterp value) (wood::%%store-character value array address))
        ((eq value (%unbound-marker-8))
         (%%store-long $undefined array address))
        ((eq value (%illegal-marker))
         (%%store-long $illegal array address))
        (t (error "~s is not a valid immediate" value)))
  value)

)  ; end of #+ppc-target progn

; Avoid consing bignums by not boxing immediate data from the file.
; Second value is true if the result was immediate.
(defun wood::read-pointer (disk-cache address)
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address)
     (declare (fixnum index count))
     (unless (and (>= count 4) (eql 0 (the fixnum (logand 1 index))))
       (error "Address odd or past eof: ~s" address))
     (wood::%%load-pointer array index))))

; load directly from a byte array.
(defun wood::%load-pointer (array address)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address))
    (check-byte-array-address address 4 array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    (wood::%%load-pointer array address)))

(defun (setf wood::read-pointer) (value disk-cache address &optional immediate?)
  (unless (>= (wood::disk-cache-size disk-cache)
              (+ address 4))
    (wood::extend-disk-cache disk-cache (+ address 4)))
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address t)
     (declare (fixnum index count))
     (unless (and (>= count 4) (eql 0 (the fixnum (logand 1 index))))
       (error "Address odd or past eof: ~s" address))
     (wood::%%store-pointer value array index immediate?)))
  value)

(defun wood::%store-pointer (value array address &optional immediate?)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address))
    (check-byte-array-address address 4 array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    (wood::%%store-pointer value array address immediate?))
  value)

(declaim (inline wood::%%load-low-24-bits %%store-low-24-bits))

(defun wood::%%load-low-24-bits (array index)
  (declare (optimize (speed 3) (safety 0))
           (fixnum index))
  (let* ((word-index (ash index -1))
         (low-word
          (locally (declare (type (simple-array (unsigned-byte 16) (*)) array))
            (aref array (the fixnum (1+ word-index)))))
         (high-word
          (locally (declare (type (simple-array (unsigned-byte 8) (*)) array))
            (aref array (the fixnum (1+ index))))))
    (declare (fixnum word-index low-word high-word))
    (the fixnum
      (+ (the fixnum (ash high-word 16)) low-word))))

(defun wood::%%store-low-24-bits (value array index)
  (declare (optimize (speed 3) (safety 0))
           (fixnum value index))
  (let* ((word-index (ash index -1))
         (low-word (logand value #xffff))
         (high-word (ash value -16)))
    (declare (fixnum word-index low-word high-word))
    (locally (declare (type (simple-array (unsigned-byte 16) (*)) array))
      (setf (aref array (the fixnum (1+ word-index))) low-word))
    (locally (declare (type (simple-array (unsigned-byte 8) (*)) array))
      (setf (aref array (the fixnum (1+ index))) high-word)))
  value)

(defun wood::read-low-24-bits (disk-cache address)
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address)
     (declare (fixnum index count))
     (unless (>= count 4)
       (error "Address past eof or not longword aligned: ~s" address))
     (wood::%%load-low-24-bits array index))))

(defun (setf wood::read-low-24-bits) (value disk-cache address)
  (unless (fixnump value)
    (setq value (require-type value 'fixnum)))
  (unless (>= (wood::disk-cache-size disk-cache)
              (+ address 4))
    (wood::extend-disk-cache disk-cache (+ address 4)))
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address t)
     (declare (fixnum index count))
     (unless (>= count 4)
       (error "Address not longword aligned: ~s" address))
     (wood::%%store-low-24-bits value array index)))
  value)

; Read an unsigned byte. Can't call it read-byte as Common Lisp
; already exports that symbol
(defun wood::read-8-bits (disk-cache address)
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address)
     (declare (fixnum index count)
              (type (simple-array (unsigned-byte 8) (*)) array)
              (optimize (speed 3) (safety 0)))
     (unless (>= count 1)
       (error "Address past eof"))
     (aref array index))))

(defun wood::read-8-bits-signed (disk-cache address)
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address)
     (declare (fixnum index count)
              (type (simple-array (signed-byte 8) (*)) array)
              (optimize (speed 3) (safety 0)))
     (unless (>= count 1)
       (error "Address past eof"))
     (aref array index))))

(defun wood::%load-8-bits (array address)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address)
                    (type (simple-array (unsigned-byte 8) (*)) array)
                    (optimize (speed 3) (safety 0)))
    (check-byte-array-address address 1 array)
    (aref array address)))

(defun (setf wood::read-8-bits) (value disk-cache address)
  (unless (>= (wood::disk-cache-size disk-cache)
              (+ address 4))
    (wood::extend-disk-cache disk-cache (+ address 4)))
  (wood::with-databases-locked
   (multiple-value-bind (array index count)
                        (wood::get-disk-page disk-cache address t)
     (declare (fixnum index count)
              (type (simple-array (unsigned-byte 8) (*)) array)
              (optimize (speed 3) (safety 0)))
     (unless (>= count 1)
       (error "Address past eof"))
     (setf (aref array index) value))))

(defsetf wood::read-8-bits-signed (disk-cache address) (value)
  `(setf (wood::read-8-bits ,disk-cache ,address) ,value))

(defun wood::%store-8-bits (value array address)
  (ensure-byte-array array)
  (setq address (require-type address 'fixnum))
  (locally (declare (fixnum address)
                    (type (simple-array (unsigned-byte 8) (*)) array)
                    (optimize (speed 3) (safety 0)))
    (check-byte-array-address address 1 array)
    (setf (aref array address) value)))

; These will get less ugly when we can stack cons float vectors
#-ppc-target
(defun wood::read-double-float (disk-cache address)
  (let ((vector (make-array 2 :element-type '(signed-byte 32))))
    (declare (dynamic-extent vector))
    (wood::load-byte-array disk-cache address 8 vector 0 t)
    (ccl::%typed-uvref ccl::$v_floatv vector 0)))

#+ppc-target
(defun wood::read-double-float (disk-cache address)
  (let ((float (%copy-float 0.0)))
    (wood::load-byte-array disk-cache address 8 float 4 t)
    float))

#-ppc-target
(defun (setf wood::read-double-float) (value disk-cache address)
  (let ((vector (make-array 2 :element-type '(signed-byte 32))))
    (declare (dynamic-extent vector))
    (ccl::%typed-uvset ccl::$v_floatv vector 0 value)
    (wood::store-byte-array vector disk-cache address 8 0 t))
  value)

#+ppc-target
(defun (setf wood::read-double-float) (value disk-cache address)
  (unless (typep value 'double-float)
    (setq value (require-type value 'double-float)))
  (wood::store-byte-array value disk-cache address 8 4 t)
  value)

(defun wood::read-string (disk-cache address length &optional string)
  (setq length (require-type length 'fixnum))
  (locally (declare (fixnum length))
    (when (> (+ address length) (wood::disk-cache-size disk-cache))
      (error "Attempt to read past EOF"))
    (let ((offset 0)
          inner-string)
      (declare (fixnum offset))
      (cond ((and string
                  (progn
                    (setq string (require-type string 'string))
                    (array-has-fill-pointer-p string)))
             (if (> length (array-total-size string))
               (setq string (adjust-array string length))
               (setf (fill-pointer string) length))
             (multiple-value-setq (inner-string offset)
               (array-data-and-offset string)))
            (string
             (unless (>= (length string) length)
               (error "~s is < ~s characters long" string length))
             (multiple-value-setq (inner-string offset)
               (array-data-and-offset string)))
            (t (setq inner-string
                     (setq string (make-string length :element-type 'base-character)))))
      (loop
        (wood::with-databases-locked
         (multiple-value-bind (array index count)
                              (wood::get-disk-page disk-cache address)
           (declare (fixnum count index))
           #-ppc-target
           (lap-inline ()
             (:variable array index count length inner-string offset)
             (move.l (varg array) atemp0)
             (move.l (varg index) da)
             (getint da)
             (lea (atemp0 da.l $v_data) atemp0)
             (move.l (varg inner-string) atemp1)
             (move.l (varg offset) da)
             (getint da)
             (lea (atemp1 da.l $v_data) atemp1)
             (move.l (varg length) da)
             (if# (gt (cmp.l (varg count) da))
               (move.l (varg count) da))
             (getint da)
             (dbfloop.l da
                     (move.b atemp0@+ atemp1@+)))
           #+ppc-target
           (%copy-ivector-to-ivector
            array index inner-string offset
            (if (< count length) count length))
           (when (<= (decf length count) 0)
             (return))
           (incf address (the fixnum (+ count wood::$block-overhead)))
           (incf offset count))))))
  string)

; Same as array-data-and-offset but works for
; non-array uvectors.
(defun lenient-array-data-and-offset (array)
  (if #-ppc-target (eql $v_arrayh (%vect-subtype array))
      #+ppc-target (let ((typecode (ppc-typecode array)))
                     (declare (fixnum typecode))
                     (or (eql typecode ppc::subtag-arrayh)
                         (eql typecode ppc::subtag-vectorh)))
    (array-data-and-offset array)
    (values array 0)))

#-ppc-target
(defun uvector-bytes (uvector)
  (lap-inline (uvector)
    (if# (eq (dtagp arg_z $t_vector))
      (wtaerr arg_z 'uvector))
    (move.l arg_z atemp0)
    (vsize atemp0 arg_z)
    (mkint arg_z)))

#+ppc-target
(defun uvector-bytes (uvector)
  (let* ((typecode (ppc-typecode uvector))
         (typecode-tag (logand typecode ppc::fulltagmask))
         (length (uvsize uvector)))
    (declare (fixnum typecode t typecode-tag))
    (if (eql typecode-tag ppc::fulltag-immheader)
       (ppc-subtag-bytes typecode length)
       (ash length 2))))

(defun wood::load-byte-array (disk-cache address length byte-array &optional
                                         (start 0) trust-me?)
  (setq length (require-type length 'fixnum))
  (setq start (require-type start 'fixnum))
  (locally (declare (fixnum length))
    (when (> (+ address length) (wood::disk-cache-size disk-cache))
      (error "Attempt to read past EOF"))
    (multiple-value-bind (inner-array offset)
                         (lenient-array-data-and-offset byte-array)
      (unless trust-me?                 ; for p-load-ivector
        (ensure-byte-array byte-array)
        (if (> (+ start length) (uvector-bytes byte-array))
          (error "(~s ~s) < ~s" 'uvector-bytes byte-array (+ start length))))
      (incf offset start)
      (loop
        (wood::with-databases-locked
         (multiple-value-bind (array index count)
                              (wood::get-disk-page disk-cache address)
           (declare (fixnum count index))
           #-ppc-target
           (lap-inline ()
             (:variable array index count length inner-array offset)
             (move.l (varg array) atemp0)
             (move.l (varg index) da)
             (getint da)
             (lea (atemp0 da.l $v_data) atemp0)
             (move.l (varg inner-array) atemp1)
             (move.l (varg offset) da)
             (getint da)
             (lea (atemp1 da.l $v_data) atemp1)
             (move.l (varg length) da)
             (if# (gt (cmp.l (varg count) da))
               (move.l (varg count) da))
             (getint da)
             (dbfloop.l da
                     (move.b atemp0@+ atemp1@+)))
           #+ppc-target
           (%copy-ivector-to-ivector
            array index inner-array offset
            (if (< count length) count length))
           (when (<= (decf length count) 0)
             (return))
           (incf address (the fixnum (+ count wood::$block-overhead)))
           (incf offset count))))))
  byte-array)

; Copy length bytes from from at from-index to to at to-index.
; from-index, length, and to-index must be fixnums
; if (eq from to), the copying will be done in the correct order.
; If either array is not a byte array or string, you will likely crash
; sometime in the future.
(defun wood::%copy-byte-array-portion (from from-index length to to-index &optional to-page)
  (declare (ignore to-page))            ; for logging/recovery
  (setq from-index (require-type from-index 'fixnum))
  (setq length (require-type length 'fixnum))
  (setq to-index (require-type to-index 'fixnum))
  (locally (declare (fixnum from-index length to-index))
    (when (> length 0)
      (unless (and (>= from-index 0)
                   (<= (the fixnum (+ from-index length)) (uvector-bytes from))
                   (>= to-index 0)
                   (<= (the fixnum (+ to-index length)) (uvector-bytes to)))
        (error "Attempt to index off end of one of the arrays"))
      (multiple-value-bind (from off) (lenient-array-data-and-offset from)
        (incf from-index off)
        (multiple-value-bind (to off) (lenient-array-data-and-offset to)
          (incf to-index off)
          (ensure-byte-array from)
          (ensure-byte-array to)
          #-ppc-target
          (lap-inline ()
            (:variable from from-index length to to-index)
            (move.l (varg from) atemp0)
            (move.l atemp0 arg_x)             ; arg_x = from
            (move.l (varg from-index) da)
            (getint da)
            (move.l da arg_y)                 ; arg_y = from-index
            (lea (atemp0 da.l $v_data) atemp0)
            (move.l (varg to) atemp1)
            (move.l atemp1 arg_z)             ; arg_z = to
            (move.l (varg to-index) da)
            (getint da)
            (move.l da db)                    ; db = to-index
            (lea (atemp1 da.l $v_data) atemp1)
            (move.l (varg length) da)
            (getint da)
            ; _BlockMove is slower for small moves
            (if# (gt (cmp.l ($ 128) da))
              (move.l da acc)
              (dc.w #_BlockMove)
              else#
              (if# (and (eq (cmp.l arg_x arg_z))
                        (gt (cmp.l arg_y db)))
                (add.l da atemp0)
                (add.l da atemp1)
                (dbfloop.l da
                        (move.b -@atemp0 -@atemp1))
                else#
                (dbfloop.l da
                        (move.b atemp0@+ atemp1@+)))))
          #+ppc-target
          (%copy-ivector-to-ivector
           from from-index to to-index length)))))
  to)

(defun wood::%load-string (array index length &optional string)
  (unless string
    (setq string (make-string length :element-type 'base-character)))
  (wood::%copy-byte-array-portion array index length string 0))

(defun wood::%store-string (string array index &optional (length (length string)))
  (wood::%copy-byte-array-portion string 0 length array index)
  string)
  
(defun (setf wood::read-string) (string disk-cache address &optional length)
  (if length
    (when (> (setq length (require-type length 'fixnum)) (length string))
      (error "~s > the length of the string." 'length))
    (setq length (length string)))
  (unless (>= (wood::disk-cache-size disk-cache)
              (+ address length))
    (wood::extend-disk-cache disk-cache (+ address length)))
  (multiple-value-bind (string offset) (array-data-and-offset string)
    (declare (fixnum offset))
    (loop
      (wood::with-databases-locked
       (multiple-value-bind (array index count)
                            (wood::get-disk-page disk-cache address t)
         (declare (fixnum count index))
         #-ppc-target
         (lap-inline ()
           (:variable array index count length string offset)
           (move.l (varg array) atemp0)
           (move.l (varg index) da)
           (getint da)
           (lea (atemp0 da.l $v_data) atemp0)
           (move.l (varg string) atemp1)
           (move.l (varg offset) da)
           (getint da)
           (lea (atemp1 da.l $v_data) atemp1)
           (move.l (varg length) da)
           (if# (gt (cmp.l (varg count) da))
             (move.l (varg count) da))
           (getint da)
           (dbfloop.l da
                   (move.b atemp1@+ atemp0@+)))
         #+ppc-target
         (%copy-ivector-to-ivector
          string offset array index
          (if (< count length) count length))
         (when (<= (decf length count) 0)
           (return))
         (incf address (the fixnum (+ count wood::$block-overhead)))
         (incf offset count)))))
  string)

(defun wood::store-byte-array (byte-array disk-cache address length &optional
                                          (start 0) trust-me?)
  (setq length (require-type length 'fixnum))
  (setq start (require-type start 'fixnum))
  (locally (declare (fixnum length))
    (when (> (+ address length) (wood::disk-cache-size disk-cache))
      (error "Attempt to read past EOF"))
    (multiple-value-bind (inner-array offset) (lenient-array-data-and-offset byte-array)
      (unless trust-me?                 ; for p-load-ivector
        (ensure-byte-array byte-array)
        (if (> (+ start length) (uvector-bytes byte-array))
          (error "(~s ~s) < ~s" 'uvector-bytes byte-array (+ start length))))
      (incf offset start)
      (loop
        (wood::with-databases-locked
         (multiple-value-bind (array index count)
                              (wood::get-disk-page disk-cache address t)
           (declare (fixnum count index))
           #-ppc-target
           (lap-inline ()
             (:variable array index count length inner-array offset)
             (move.l (varg array) atemp0)
             (move.l (varg index) da)
             (getint da)
             (lea (atemp0 da.l $v_data) atemp0)
             (move.l (varg inner-array) atemp1)
             (move.l (varg offset) da)
             (getint da)
             (lea (atemp1 da.l $v_data) atemp1)
             (move.l (varg length) da)
             (if# (gt (cmp.l (varg count) da))
               (move.l (varg count) da))
             (getint da)
             (dbfloop.l da
                     (move.b atemp1@+ atemp0@+)))
           #+ppc-target
           (%copy-ivector-to-ivector
            inner-array offset array index
            (if (< count length) count length))
           (when (<= (decf length count) 0)
             (return))
           (incf address (the fixnum (+ count wood::$block-overhead)))
           (incf offset count))))))
  byte-array)

(defun wood::fill-long (disk-cache address value count &optional immediate?)
  (let ((count (require-type count 'fixnum)))
    (declare (fixnum count))
    (unless (eql 0 (logand 1 address))
      (error "Odd address: ~s" address))
    (when (<= count 0) (return-from wood::fill-long) nil)
    (let ((min-size (+ address (ash count 2))))
      (when (< (wood::disk-cache-size disk-cache) min-size)
        (wood::extend-disk-cache disk-cache min-size)))
    (loop
      (wood::with-databases-locked
       (multiple-value-bind (vector offset size)
                            (wood::get-disk-page disk-cache address t)
         (declare (fixnum offset size))
         (when (<= size 0)
           (error "attempt to write past end of ~s" disk-cache))
         (let ((words (ash size -2)))
           (declare (fixnum words))
           (if (< count words) (setq words count))
           #-ppc-target
           (lap-inline ()
             (:variable vector offset words value immediate?)
             (move.l (varg value) arg_z)
             (if# (eq (cmp.l (varg immediate?) nilreg))
               (jsr_subprim $sp-getxlong)
               else#
               (movereg arg_z acc))
             (move.l (varg vector) atemp0)
             (move.l (varg offset) da)
             (getint da)
             (lea (atemp0 da.l $v_data) atemp0)
             (move.l (varg words) da)
             (getint da)
             (dbfloop.l da (move.l acc atemp0@+)))
           #+ppc-target
           (if immediate?
             (dotimes (i words)
               (wood::%%store-pointer value vector offset t)
               (incf offset 4))
             (dotimes (i words)
               (%%store-long value vector offset)
               (incf offset 4)))
           (if (<= (decf count words) 0) (return)))
         (incf address (the fixnum (+ size wood::$block-overhead))))))))

(defun wood::fill-word (disk-cache address value count &optional immediate?)
  (declare (ignore immediate?))
  (let ((count (require-type count 'fixnum))
        (address address)
        (value (require-type value 'fixnum)))
    (declare (fixnum count))
    (unless (eql 0 (logand 1 address))
      (error "Odd address: ~s" address))
    (when (<= count 0) (return-from wood::fill-word) nil)
    (let ((min-size (+ address (ash count 1))))
      (when (< (wood::disk-cache-size disk-cache) min-size)
        (wood::extend-disk-cache disk-cache min-size)))
    (loop
      (wood::with-databases-locked
       (multiple-value-bind (vector offset size)
                            (wood::get-disk-page disk-cache address t)
         (declare (fixnum offset size))
         (when (<= size 0)
           (error "attempt to write past end of ~s" disk-cache))
         (let ((words (ash size -1)))
           (declare (fixnum words))
           (if (< count words) (setq words count))
           #-ppc-target
           (lap-inline ()
             (:variable vector offset words value)
             (move.l (varg vector) atemp0)
             (move.l (varg offset) da)
             (getint da)
             (lea (atemp0 da.l $v_data) atemp0)
             (move.l (varg words) da)
             (getint da)
             (move.l (varg value) acc)
             (getint acc)
             (dbfloop.l da (move.w acc atemp0@+)))
           #+ppc-target
           (locally (declare (type (simple-array (unsigned-byte 16) (*)) vector)
                             (optimize (speed 3) (safety 0)))
             (let ((word-offset (ash offset -1)))
               (declare (fixnum word-offset))
               (dotimes (i words)
                 (setf (aref vector word-offset) value)
                 (incf word-offset))))
           (if (<= (decf count words) 0) (return)))
         (incf address (the fixnum (+ size wood::$block-overhead))))))))

(defun wood::fill-byte (disk-cache address value count &optional immediate?)
  (declare (ignore immediate?))
  (let ((count (require-type count 'fixnum))
        (address address)
        (value (require-type value 'fixnum)))
    (declare (fixnum count))
    (when (<= count 0) (return-from wood::fill-byte) nil)
    (let ((min-size (+ address count)))
      (when (< (wood::disk-cache-size disk-cache) min-size)
        (wood::extend-disk-cache disk-cache min-size)))
    (loop
      (wood::with-databases-locked
       (multiple-value-bind (vector offset size)
                            (wood::get-disk-page disk-cache address t)
         (declare (fixnum offset size))
         (when (<= size 0)
           (error "attempt to write past end of ~s" disk-cache))
         (if (< count size) (setq size count))
         #-ppc-target
         (lap-inline ()
           (:variable vector offset size value)
           (move.l (varg vector) atemp0)
           (move.l (varg offset) da)
           (getint da)
           (lea (atemp0 da.l $v_data) atemp0)
           (move.l (varg size) da)
           (getint da)
           (move.l (varg value) acc)
           (getint acc)
           (dbfloop.l da (move.b acc atemp0@+)))
         #+ppc-target
         (locally (declare (type (simple-array (unsigned-byte 8) (*)) vector)
                           (optimize (speed 3) (safety 0)))
           (dotimes (i size)
             (setf (aref vector offset) value)
             (incf offset)))
         (if (<= (decf count size) 0) (return))
         (incf address (the fixnum (+ size wood::$block-overhead))))))))

(defun wood::array-fill-long (array address value count &optional immediate?)
  (ensure-byte-array array)
  (let ((count (require-type count 'fixnum))
        (address (require-type address 'fixnum))
        (value (require-type value 'fixnum)))
    (declare (fixnum count address))
    (check-byte-array-address address (* 4 count) array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    #-ppc-target
    (lap-inline ()
      (:variable array address value count immediate?)
      (move.l (varg array) atemp0)
      (move.l (varg value) acc)
      (if# (eq (cmp.l (varg immediate?) nilreg))
        (movereg acc arg_z)
        (jsr_subprim $sp-getxlong))
      (move.l (varg address) da)
      (getint da)
      (lea (atemp0 da.l $v_data) atemp0)
      (move.l (varg count) da)
      (dbfloop.l da (move.l acc atemp0@+)))
    #+ppc-target
    (let ((offset address))
      (declare (fixnum offset))
      (if immediate?
        (dotimes (i count)
          (wood::%%store-pointer value array offset t)
          (incf offset 4))
        (dotimes (i count)
          (%%store-long value array offset)
          (incf offset 4)))))
  nil)

(defun wood::array-fill-word (array address value count)
  (ensure-byte-array array)
  (let ((count (require-type count 'fixnum))
        (address (require-type address 'fixnum))
        (value (require-type value 'fixnum)))
    (declare (fixnum count address))
    (check-byte-array-address address (* 2 count) array)
    (unless (eql 0 (the fixnum (logand 1 address)))
      (error "Odd address: ~s" address))
    #-ppc-target
    (lap-inline ()
      (:variable array address value count)
      (move.l (varg array) atemp0)
      (move.l (varg value) acc)
      (getint acc)
      (move.l (varg address) da)
      (getint da)
      (lea (atemp0 da.l $v_data) atemp0)
      (move.l (varg count) da)
      (dbfloop.l da (move.w acc atemp0@+)))
    #+ppc-target
    (let ((index (ash address -1)))
      (declare (fixnum offset)
               (type (simple-array (unsigned-byte 16) (*)) array)
               (optimize (speed 3) (safety 0)))
      (dotimes (i count)
        (setf (aref array index) value)
        (incf index))))
  nil)

(defun wood::array-fill-byte (array address value count)
  (ensure-byte-array array)
  (let ((count (require-type count 'fixnum))
        (address (require-type address 'fixnum))
        (value (require-type value 'fixnum)))
    (declare (fixnum count address))
    (check-byte-array-address address count array)
    #-ppc-target
    (lap-inline ()
      (:variable array address value count)
      (move.l (varg array) atemp0)
      (move.l (varg value) acc)
      (getint acc)
      (move.l (varg address) da)
      (getint da)
      (lea (atemp0 da.l $v_data) atemp0)
      (move.l (varg count) da)
      (getint da)
      (dbfloop.l da (move.b acc atemp0@+)))
    #+ppc-target
    (let ((offset address))
      (declare (fixnum offset)
               (type (simple-array (unsigned-byte 8) (*)) array)
               (optimize (speed 3) (safety 0)))
      (dotimes (i count)
        (setf (aref array offset) value)
        (incf offset))))
  nil)
  

; some macros to make using this take less typing.

(in-package :wood)

(export '(accessing-disk-cache))

(defmacro accessing-disk-cache ((disk-cache &optional base) &body body)
  (let* ((b (gensym)))
    `(let ((-*dc*- ,disk-cache)
           ,@(when base
               `((,b ,base))))
       (macrolet ((-*addr*- (address)
                    (if ',base
                      `(+ ,',b ,address)
                      address))
                  (-*select*- (operation disk-cache-code array-code)
                    (declare (ignore array-code))
                    (if (eq disk-cache-code :error)
                      (error "~s not supported for disk-cache's" operation))
                    disk-cache-code))
         ,@body))))

(defmacro accessing-byte-array ((byte-array &optional base disk-page) &body body)
  (let* ((b (gensym)))
    `(let ((-*dc*- ,byte-array)
           ,@(when base
               `((,b ,base))))
       (macrolet ((-*addr*- (address)
                    (if ',base
                      `(+ ,',b ,address)
                      address))
                  (-*select*- (operation disk-cache-code array-code)
                    (declare (ignore disk-cache-code))
                    (if (eq array-code :error)
                      (error "~s not supported for arrays" operation))
                    array-code))
         ,disk-page
         ,@body))))

(defun ensure-accessing-disk-cache (accessor env)
  (unless (and (eq :lexical (variable-information '-*dc*- env))
               (eq :macro (function-information '-*addr*- env))
               (eq :macro (function-information '-*select*- env)))
    (error "~s called ouside of ~s environment"
           accessor 'accessing-disk-cache)))

(defmacro load.l (address &environment env)
  (ensure-accessing-disk-cache 'load.l env)
  `(-*select*-
    load.l
    (read-long -*dc*- (-*addr*- ,address))
    (%load-long -*dc*- (-*addr*- ,address))))

(defmacro load.ul (address &environment env)
  (ensure-accessing-disk-cache 'load.ul env)
  `(-*select*-
    load.ul
    (read-unsigned-long -*dc*- (-*addr*- ,address))
    (%load-unsigned-long -*dc*- (-*addr*- ,address))))

(defmacro load.p (address &environment env)
  (ensure-accessing-disk-cache 'load.ul env)
  `(-*select*-
    load.p
    (read-pointer -*dc*- (-*addr*- ,address))
    (%load-pointer -*dc*- (-*addr*- ,address))))

(defmacro load.w (address &environment env)
  (ensure-accessing-disk-cache 'load.w env)
  `(the fixnum
        (-*select*-
         load.w
         (read-word -*dc*- (-*addr*- ,address))
         (%load-word -*dc*- (-*addr*- ,address)))))

(defmacro load.uw (address &environment env)
  (ensure-accessing-disk-cache 'load.uw env)
  `(the fixnum
        (-*select*-
         load.uw
         (read-unsigned-word -*dc*- (-*addr*- ,address))
         (%load-unsigned-word -*dc*- (-*addr*- ,address)))))

(defmacro load.b (address &environment env)
  (ensure-accessing-disk-cache 'load.b env)
  `(the fixnum
        (-*select*-
         load.b
         (read-8-bits -*dc*- (-*addr*- ,address))
         (%load-8-bits -*dc*- (-*addr*- ,address)))))

(defmacro load.string (address length &optional string &environment env)
  (ensure-accessing-disk-cache 'load.string env)
  `(-*select*-
    load.string
    (read-string -*dc*- (-*addr*- ,address) ,length
                 ,@(if string `(,string)))
    (%load-string -*dc*- (-*addr*- ,address) ,length
                 ,@(if string `(,string)))))

(defmacro store.l (value address &environment env)
  (ensure-accessing-disk-cache 'store.l env)
  `(-*select*-
    store.l
    (let ((-*temp*- ,value))
      (setf (read-long -*dc*- (-*addr*- ,address)) -*temp*-))
    (%store-long ,value -*dc*- (-*addr*- ,address))))

(defmacro store.p (value address &optional value-imm? &environment env)
  (ensure-accessing-disk-cache 'store.p env)
  `(-*select*-
    store.p
    (let ((-*temp*- ,value))
      (setf (read-pointer -*dc*- (-*addr*- ,address)
                          ,@(if value-imm? `(,value-imm?)))
            -*temp*-))
    (%store-pointer ,value -*dc*- (-*addr*- ,address)
                    ,@(if value-imm? `(,value-imm?)))))

(defmacro store.w (value address &environment env)
  (ensure-accessing-disk-cache 'store.w env)
  `(-*select*-
    store.w
    (let ((-*temp*- ,value))
      (setf (read-word -*dc*- (-*addr*- ,address)) -*temp*-))
    (%store-word ,value -*dc*- (-*addr*- ,address))))

(defmacro store.b (value address &environment env)
  (ensure-accessing-disk-cache 'store.b env)
  `(-*select*-
    store.b
    (let ((-*temp*- ,value))
      (setf (read-8-bits -*dc*- (-*addr*- ,address)) -*temp*-))
    (%store-8-bits ,value -*dc*- (-*addr*- ,address))))

(defmacro store.string (string address &optional length &environment env)
  (ensure-accessing-disk-cache 'store.string env)
  `(-*select*-
    store.string
    (funcall #'(setf read-string)
             ,string -*dc*- (-*addr*- ,address)
             ,@(if length `(,length)))
    (%store-string ,string -*dc*- (-*addr*- ,address)
             ,@(if length `(,length)))))

(defmacro fill.l (address value count &optional imm? &environment env)
  (ensure-accessing-disk-cache 'fill.l env)
  `(-*select*-
    fill.l
    (fill-long -*dc*- (-*addr*- ,address) ,value ,count ,imm?)
    (array-fill-long -*dc*- (-*addr*- ,address) ,value ,count ,imm?)))

(defmacro fill.w (address value count &environment env)
  (ensure-accessing-disk-cache 'fill.w env)
  `(-*select*-
    fill.w
    (fill-word -*dc*- (-*addr*- ,address) ,value ,count)
    (array-fill-word -*dc*- (-*addr*- ,address) ,value ,count)))

(defmacro fill.b (address value count &environment env)
  (ensure-accessing-disk-cache 'fill.b env)
  `(-*select*-
    fill.b
    (fill-byte -*dc*- (-*addr*- ,address) ,value ,count)
    (array-fill-byte -*dc*- (-*addr*- ,address) ,value ,count)))

(defmacro svref.p (vector index &environment env)
  (ensure-accessing-disk-cache 'svref.p env)
  `(-*select*-
    svref.p
    (dc-%svref -*dc*- ,vector ,index)
    :error))

(defmacro svset.p (vector index value &optional immediate? &environment env)
  (ensure-accessing-disk-cache 'svset.p env)
  `(-*select*-
    svset.p
    (setf (dc-%svref -*dc*- ,vector ,index ,@(if immediate? `(,immediate?)))
          ,value)
    :error))

(defmacro %vector-size.p (vector &environment env)
  (ensure-accessing-disk-cache '%vector-size.p env)
  `(-*select*-
    %vector-size.p
    (dc-%vector-size -*dc*- ,vector)
    :error))
                  

#|
(setq wood::dc (wood::open-disk-cache "temp.dc" 
                                      :if-exists :overwrite
                                      :if-does-not-exist :create))

(defun wood::wi (&optional (count 100000))
  (declare (special wood::dc))
  (let ((index 0))
    (declare (fixnum index))
    (dotimes (i count)
      (setf (wood::read-long wood::dc index) i)
      (incf index 4))))

(defun wood::ri (&optional (count 100000))
  (declare (special wood::dc))
  (let ((index 0))
    (declare (fixnum index))
    (dotimes (i count)
      (let ((was (wood::read-long wood::dc index)))
        (incf index 4)
        (unless (eql i was)
          (cerror "continue" "SB: ~d, Was: ~d" i was))))))

#-ppc-target
(progn

(require :lapmacros)

(defun wood::time-moves (&optional (count 100))
  (setq count (require-type count 'fixnum))
  (macrolet ((moves (count)
               `(lap-inline (,count)
                  (getint arg_z)
                  (move.l ($ 0) atemp0)
                  (dbfloop arg_z
                           ,@(make-list 1000 
                                        :initial-element
                                        '(move.l atemp0@+ da))))))
    (moves count)
    (* count 1000)))

)
            

; Timing on a mac IIfx running System 7.0.
;
; (wi) first time:   2080 usec/long  (file allocation)
; (wi) second time:   372 usec/long  (read every block. write half of them)
; (ri) first time:    200 usec/long  (read every block. write half of them)
; (ri) second time:   144 usec/long  (read every block)
; (ri 20000) 2nd time: 66 usec/long  (no disk I/O)
; (time-moves):       270 nanoseconds/long

(defun wood::ws (&optional (count most-positive-fixnum) (package :ccl))
  (declare (special wood::dc))
  (let ((address 0))
    (do-symbols (sym package)
      (let* ((name (symbol-name sym))
             (length (length name))
             (rounded-length (logand -4 (+ length 3))))
        (setf (wood::read-long wood::dc address) (length name))
        (incf address 4)
        (setf (wood::read-string wood::dc address) name)
        (incf address rounded-length)
        (if (<= (decf count) 0) (return))))
    (setf (wood::read-long wood::dc address) 0)
    address))

(defun wood::rs ()
  (declare (special wood::dc))
  (let ((address 0)
        (string (make-array 50 :fill-pointer t :adjustable t
                            :element-type 'base-character)))
    (loop
      (let ((length (wood::read-long wood::dc address)))
        (if (eql length 0) (return))
        (incf address 4)
        (print (wood::read-string wood::dc address length string))
        (incf address (logand -4 (+ length 3)))))))
    
  
|#
;;;    1   3/10/94  bill         1.8d247
;;;    2  10/04/94  bill         1.9d071
;;;    3  11/01/94  Derek        1.9d085 Bill's Saving Library Task
;;;    4  11/03/94  Moon         1.9d086
;;;    2   3/23/95  bill         1.11d010
;;;    3   6/02/95  bill         1.11d040
