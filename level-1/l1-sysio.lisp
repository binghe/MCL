;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  19 1/22/97 akh  dont remember
;;  17 9/3/96  akh  fix %fopen :element-type 'character
;;  16 5/20/96 akh  dont remember
;;  11 12/1/95 akh  lose %scale-pointer again
;;  10 11/14/95 akh #-ppc-target => ;; end #-ppc-target as gb discovered
;;  9 11/9/95  akh  remove unused write-type-and-address
;;  8 10/31/95 akh  %fopen is platform neutral, 
;;                  %fread/write-byte for ppc call ppc-read/write-weird-byte for sizes other than 1 8 16 32.
;;                  The functions error when called and warn when compiled
;;  6 10/26/95 Alice Hartley %istruct/ make-uvecter stuff - ppc %make-heap-ivector - not done yet
;;  4 10/23/95 akh  %fpos from patch
;;  3 10/17/95 akh  merge patch to hairy-ftyi
;;  5 2/17/95  akh  no change - just wanted it to compile again
;;  4 2/17/95  akh  make bigger buffer stuff actually do something (untested!)
;;  3 1/31/95  akh  big-io-buffer patch
;;  2 1/30/95  akh  nothing really
;;  (do not edit before this line!!)

;Sysio.lisp - low-level input/output functions.
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

; Modification History
;
;; fblock gets external-format slot. used by %ftyi for :utf8 - now we can load and compile :utf8 files
;; say pref not rref
;; %ftyi and %hairy-ftyi return unicode chars
;; ------ 5.1 final
;04/10/99 akh change to %fclose from Terje N.
;07/21/98 akh %fread-to-vector and %fwrite-from-vector get optional check-untyi arg.
;01/16/97 bill  ppc-read-weird-byte does fixnum math if element size is less
;               than (- ppc::nbits-in-word ppc::fixnum-shift), not ppc::fixnum-shift.
;10/28/96 bill  Alice's fixes to %ftyo, %fwrite-byte, %fbReadAhead0
;-------------  4.0
;03/26/96 bill  Fix bugs in %fsize & %fbflush (fblock.filepos is an 8-bit index)
;03/25/96 bill  slh's fix to with-paramblock
;               ppc-read-weird-byte & ppc-write-weird-byte
;12/06/95 bill  Remove comments from %%make-disposable.
;12/06/95 slh   Bill's fudge-heap-pointer fix
;11/29/95 bill  New trap names to avoid emulator.
;               (#_PBxxx :errchk ...) -> (errchk (#_PBxxx ..))
;10/20/95 slh   started de-lapifying; see ??? tokens to finish
;06/03/93 alice %hairy-ftyi for file with scriptruns
;06/02/93 alice fblock has 5 more slots for files with scriptruns
;05/04/93 alice %fopen element-type defaults to base-character and may be extended-character
;02/16/93 bill %feofp now works correctly when the number of bits per element is not 8
;11/20/92 gb   Get binary positioning right (in late 2.0 patch ?); new vector headers.
;06/18/92 bill finish-output for flush-only parameter to %fclose does
;              #_FlushVol as well as #_FlushFile.
;05/04/92 bill add type to def-accessors form for inspector
;              Remember writing past EOF then positioning earlier.
;------------  2.0
;03/06/92 bill %fsize no longer conses a macptr
;03/03/92 gb's fix to detect errors in %fbflush
;------------  2.0f3
;01/13/92 gb   more hysteria in %FOPEN, to ensure that pb.vrefnum can be flushvol'ed
;              by %FCLOSE.
;01/08/92 gb   less hysteria in %FOPEN.
;12/10/91 alice err-disp => signal-file-error
;--------- 2.0b4
;10/11/91 gb   rewritten.
;------------ 2.0b3
;08/24/91 gb   use new trap syntax.
;07/21/91 gb   two-arg wtaerrs, such as they are.
;04/26/91 bill fencepost in %%fbPosInBuf
;02/14/91 bill _FlushVol in %fclose had no VRefNum.  Initialize it in %fopen.
;              Do a _FlushFile vice _FlushVol when %fclose is called for
;              flush-only.
;------------ 2.0b1
;01/28/91 bill add flush-only optional parameter to %fclose
;10/16/90 gb   new lap syntax.
;04/30/90 gb   new lap control structures.
;02/15/90 bill In %fsize: eliminate bogus first block in newly opened files.
;01/05/89 bill Added proper defaults for %fopen.
;12/19/89 bill Rewritten.  No longer tries to read past EOF (this fixes the
;              AUFS fasl-file problem).  %fpos to other than the current block
;              switches out of serial-mode (stops read-ahead).  Two serial-mode
;              block reads after that switches back to serial-mode.
;04/07/89 gb  $sp8 -> $sp.
; 03/02/89 gb   typos.
; 11/11/88 gb   lap.

(eval-when (eval compile)
  #-ppc-target
  (require 'lapmacros)
  (require 'sysequ)

;structure of fblock

(def-accessors (fblock) %svref
  nil                                   ; 'fblock
  fblock.pb                             ; a parameter block; nil if closed.
  fblock.lastchar                       ; untyi char or nil
  fblock.dirty                          ; non-nil when dirty
  fblock.buffer                         ; macptr to buffer; nil when closed
  fblock.bufvec                         ; buffer vector; nil when closed
  fblock.bufsize                        ; size (in 8-bit bytes) of buffer
  fblock.bufidx                         ; index of next element to read/write
  fblock.bufcount                       ; # of elements in buffer
  fblock.filepos                        ; 8-bit position at last read/write
  fblock.fileeof                        ; file's logical eof.
  fblock.stream                         ; backptr to file stream
  fblock.element-type                   ; typespec
  fblock.nbits-per-element              ; # of bits per element
  fblock.elements-per-buffer            ; 512 or whatever
  fblock.minval                         ; minimum value of element type or nil: < 0 
  fblock.maxval                         ; maximum value or nil
  fblock.element-bit-offset             ; for non-arefable n-bit elements
  fblock.scriptruns			; goo for files containing fat scripts
  fblock.charpos			; character position as opposed to byte position
  fblock.endrun				; end of current run (beware untyi!)
  fblock.scriptidx			; current index into scriptruns
  fblock.chartable			; char-byte-table of current script
  fblock.external-format                ; maybe :utf8
)

)

; Could lapify ...
(defun %octets-to-elements (n element-size)
  (if (eql 8 element-size)
    n
    (values (floor (* n 8) element-size))))

; Could lapify.
(defun %elements-to-octets (n element-size)
  (if (eql 8 element-size)
    n
    (values (ceiling (* n element-size) 8))))

#+ppc-target
(progn


#| ; gonzo again - wrong besides
; gary nuked this- but its used in l1-edbuf if ppc.
(defppclapfunction %scale-pointer ((ptr arg_y) (offset arg_z))
; adds the unboxed fixnum (someday integer - someday wont come) offset to ptr, returning
; a new, probably invalid, pointer.
  (srwi imm0 arg_z ppc::fixnum-shift)
  (add arg_z imm0 arg_y)
  (blr))
|#


(defppclapfunction %vect-data-to-macptr ((vect arg_y) (ptr arg_z))
  ; put address of vect data in macptr
  (addi arg_y arg_y ppc::misc-data-offset)
  (stw arg_y ppc::macptr.address arg_z)
  (blr))



(defun %make-heap-ivector (subtype size-in-bytes &optional size-in-elts)
  (if (not (fixnump size-in-elts))(error "Need size in elts = fixnum")) ; not really optional, is smaller than fixnum
  (with-macptrs ((ptr (#_NewPtr :errchk (+ size-in-bytes (+ 4 2 7))))) ; 4 for header, 2 for delta, 7 for round up
    (let ((vect (fudge-heap-pointer ptr subtype size-in-elts))
          (p (%null-ptr)))
      (%vect-data-to-macptr vect p)
      (values vect p))))

(defppclapfunction fudge-heap-pointer ((ptr arg_x) (subtype arg_y) (len arg_z))
  (check-nargs 3)
  (macptr-ptr imm1 ptr) ; address in macptr
  (addi imm0 imm1 9)     ; 2 for delta + 7 for alignment
  (rlwinm imm0 imm0 0 0 28)   ; Clear low three bits to align
  (subf imm1 imm1 imm0)  ; imm1 = delta
  (sth imm1 -2 imm0)     ; save delta halfword
  (unbox-fixnum imm1 subtype)  ; subtype at low end of imm1
  (rlwimi imm1 len (- ppc::num-subtag-bits ppc::fixnum-shift) 0 (- 31 ppc::num-subtag-bits))
  (stw imm1 0 imm0)       ; store subtype & length
  (addi arg_z imm0 ppc::fulltag-misc) ; tag it, return it
  (blr))

(defun %dispose-heap-ivector (v)
  (if  (uvectorp v) ;(%heap-ivector-p v)
    (with-macptrs (p)
      (%%make-disposable p v)
      (#_DisposePtr p))))

(defppclapfunction %%make-disposable ((ptr arg_y) (vector arg_z))
  (check-nargs 2)
  (subi imm0 vector ppc::fulltag-misc) ; imm0 is addr = vect less tag
  (lhz imm1 -2 imm0)   ; get delta
  (sub imm0 imm0 imm1)  ; vector addr (less tag)  - delta is orig addr
  (stw imm0 ppc::macptr.address ptr) 
  (blr))

)
    
#-ppc-target
(progn

(defun %make-heap-ivector (subtype size-in-bytes)
  (with-macptrs ((ptr (#_NewPtr :errchk (+ size-in-bytes (+ 4 2 7)))))        ; 4 for header, 7 for alignment, 2 for disp
    (lap-inline (ptr subtype size-in-bytes)
      (move.l arg_x atemp0)
      (move.l (atemp0 $macptr.ptr) atemp0) ; data
      (move.l atemp0 arg_x)
      (moveq 7 da)
      (add.l da arg_x)
      (add.l ($ 2) arg_x)
      (not.w da)
      (and.w da arg_x)
      (move.l arg_x da)
      (sub.l atemp0 da)
      (move.l arg_x atemp0)
      (add.w ($ $t_vector) da)
      (move.w da (atemp0 -2))
      (lsl.l ($ (- $header-vector-length-shift $fixnumshift)) arg_z)
      (lsl.w ($ (- $header-subtype-shift $fixnumshift)) arg_y)
      (add ($ 1) arg_y)
      (or.w arg_y arg_z)
      (move.l arg_z @atemp0)
      (moveq $t_vector acc)
      (add.l atemp0 acc))))

(defun %dispose-heap-ivector (v)
  (if (%heap-ivector-p v)
    (with-macptrs (p)
      (lap-inline (p v)
        (move.l arg_z atemp0)
        (sub.w (atemp0 (- (+ $t_vector 2))) atemp0)
        (exg arg_y atemp0)
        (move.l arg_y (atemp0 $macptr.ptr)))
      (#_DisposePtr :errchk p)
      t)))

(defun %heap-ivector-p (v)
  (lap-inline (v)
    (if# (ne (dtagp arg_z $t_vector))
      (move.l arg_z atemp0)
      (moveq $header-nibble-mask da)
      (and.w (atemp0 $vec.header_low) da)
      (sub.w ($ 1) da))
    (setpred eq da)))

) ;;; end #-ppc-target


; Open the file identified by NAME string & VREFNUM.
; PERMISSION is $fsRdPerm (read permission) or $fsRdWrPerm (read/write permission)
; RESOURCE is non-NIL to open the resource fork instead of the data fork
#+ignore
(defun %fopen (name &optional 
                    (vrefnum 0) 
                    (permission $fsRdWrPerm) 
                    resource
                    stream
                    (element-type 'base-character)
                    (elements-per-buffer *elements-per-buffer*)
                    scriptruns)
  (let* ((eof nil)
         (subtype nil)
         (element-size nil)
         (min nil)
         (max nil)
         (bit-offset nil)
         (buffer-octet-size  elements-per-buffer))
    ; need ppc types here too. ok.
    (let ((maybe-subtype (element-type-subtype element-type)))
      (if (eq element-type 'extended-character)
        (setq element-size 16 subtype maybe-subtype) ;$v_xstr)
        (if (subtypep element-type 'character)  ; not really cltl2 but what the foo. Nobody wants 16 bit char files.
          (setq element-size 8 subtype (element-type-subtype 'base-character)) ; $v_sstr)
          (let* ((signed (list 'signed-byte 0))
                 (unsigned (list 'unsigned-byte 0)))
            (declare (dynamic-extent signed unsigned))
            (dotimes (i 32 (report-bad-arg element-type '(or character (signed-byte 32) (unsigned-byte 32))))
              (let* ((j (1+ i)))
                (declare (fixnum j))
                (rplaca (cdr signed) j)
                (unless (= j 1)
                  (if (subtypep element-type signed)
                    (setq element-size j
                          subtype (if (memq j '(8 16 32)) maybe-subtype))))
                (rplaca (cdr unsigned) j)
                (if (subtypep element-type unsigned)
                  (setq element-size j
                        min 0
                        subtype (if (memq j '(1 8 16 32)) maybe-subtype))))
              (if element-size (return)))
            (if min                         ; was unsigned
              (setq max (1- (ash 1 element-size)))
              (setq min (- (ash 1 (1- element-size)))
                    max (1- (ash 1 (1- element-size)))))
            (do* ((m (ash elements-per-buffer 3) (+ m 8)))
                 ((eq element-size (gcd m element-size)) (setq buffer-octet-size (ash m -3)))
              (declare (fixnum m)))
            (unless subtype (setq bit-offset 0))))))
    (setq elements-per-buffer (%octets-to-elements buffer-octet-size element-size))
    ;(print (list elements-per-buffer buffer-octet-size))    
    (with-pstrs ((pname name))
      (%stack-block ((paramBlock 52 :clear t))
        (setf (rref paramblock :hparamblockrec.ioNamePtr) pname
              (rref paramblock :hparamblockrec.ioVrefNum) vrefnum
              (rref paramblock :hparamblockrec.ioversnum) 0
              (rref paramblock :hparamblockrec.ioPermssn) permission
              (rref paramblock :hparamblockrec.ioMisc) (%null-ptr))
        (let ((res (if resource
                     (#_PBHOpenRFSync paramBlock)
                     (#_PBHOpenSync paramBlock))))
          (unless (eql #$noErr res)
            (signal-file-error res name)))
        (#_PBGetEOFSync paramBlock)
        (setq eof (%get-long paramBlock $ioLEOF))
        (let* ((bufvector nil)
               (buffer nil))
          (if subtype
            (progn
              #-ppc-target
              (setq bufvector (%make-heap-ivector
                               subtype 
                               (if (eql subtype $v_bitv) (1+ buffer-octet-size) buffer-octet-size))
                    buffer (lap-inline ((if (eql subtype $v_bitv) (1+ $v_data) $v_data) bufvector)
                             (getint arg_y)
                             (add.l arg_y arg_z) 
                             (move.l arg_z atemp0)
                             (jsr_subprim $sp-consmacptr)))
              #+ppc-target
              (multiple-value-setq (bufvector buffer)
                (%make-heap-ivector subtype
                                    buffer-octet-size
                                    elements-per-buffer)))
            (setq buffer (#_NewPtr buffer-octet-size)))
          (let* ((pb (make-record (:hparamblockrec :clear t)))
                 (fblock (%istruct
                                   'fblock
                                   pb
                                   nil
                                   nil
                                   buffer
                                   bufvector
                                   buffer-octet-size
                                   0
                                   0
                                   0
                                   (%octets-to-elements eof element-size)
                                   stream
                                   element-type
                                   element-size
                                   elements-per-buffer
                                   min
                                   max
                                   bit-offset
                                   scriptruns
                                   0
                                   0 
                                   -1
                                   nil)))
            ;(unless (eql 0 vrefnum)
            (setf (rref pb :hparamblockrec.ioVrefNum) 
                  (%stack-iopb (vpb np)
                    (setf (rref vpb :hparamblockrec.iovrefnum) vrefnum
                          (rref vpb :hparamblockrec.ionameptr) pname
                          (rref vpb :hparamblockrec.iovolindex) -1)
                    (#_PBHGetVInfoSync vpb)
                    (rref vpb :hparamblockrec.iovrefnum))
                  (rref pb :hparamblockrec.iocompletion) (%null-ptr)
                  (rref pb :hparamblockrec.iorefnum) (rref paramBlock :hparamblockrec.ioRefnum)
                  (rref pb :hparamblockrec.ioresult) #$noErr
                  (rref pb :hparamblockrec.ioposmode) #$fsFromStart
                 ;(rref pb :hparamblockrec.ioreqcount) buffer-octet-size
                  (rref pb :hparamblockrec.iobuffer) buffer
                  (rref pb :hparamblockrec.ioactcount) 0)
            (when (> eof 0)
              (%fbRead fblock 0))
            fblock))))))

(defun %fblock.pb (f &optional ok-if-closed)
  (or (fblock.pb f) ok-if-closed (error "~s is closed" (fblock.stream f))))

(eval-when (:execute :compile-toplevel)
  (defmacro with-paramBlock ((fblock pb1 &optional ignore-if-closed) &body body)
    `(let* ((,pb1 (%fblock.pb  ,fblock ,ignore-if-closed)))
       (when (macptrp ,pb1)
         (locally
           (declare (type macptr ,pb1))
           ,@body)))))

(defconstant uw-hi (byte 32 32))
(defconstant uw-lo (byte 32 0))
;; from shannon - I have similar thingies but slightly different
(defvar *resource-fork-name-ptr2* nil "Cached pointer to resource fork name.")
(defvar *data-fork-name-ptr2* nil "Cached pointer to data fork name.")

(def-ccl-pointers resource-name-stuff3 ()
  (setq *resource-fork-name-ptr2* nil
        *data-fork-name-ptr2* nil))

;(defvar *nocache-copies* t "True if you don't want memory caches used by copy-file. Somewhat faster this way.")

;; ---- Some utility functions

(defun data-fork-name ()
  (or *data-fork-name-ptr2*
      (prog1
        (setf *data-fork-name-ptr2* (#_NewPtr (record-length :hfsunistr255)))
        (#_FSGetDataForkName *data-fork-name-ptr2*)
        )))

(defun resource-fork-name ()
  (or *resource-fork-name-ptr2*
      (prog1
        (setf *resource-fork-name-ptr2* (#_NewPtr (record-length :hfsunistr255)))
        (#_FSGetResourceForkName *resource-fork-name-ptr2*)
        )))

; try again - from shannon
(defun volume-from-fsref (fsref)
  "Given an fsref, return the volume reference number for the volume it's on."
  (rlet ((catalogInfo :FSCatalogInfo))
    (errchk (#_FSGetCatalogInfo fsref #$kFSCatInfoVolume catalogInfo (%null-ptr) (%null-ptr) (%null-ptr)))
    (pref cataloginfo :FSCatalogInfo.volume)))


;; from shannon
;#-ignore
(defun %fopen (name &optional 
                         (vrefnum 0) 
                         (permission $fsRdWrPerm) 
                         resource
                         stream
                         (element-type 'base-character)
                         (elements-per-buffer *elements-per-buffer*)                         
                         scriptruns
                         external-format)
  (declare (ignore vrefnum)) ; nobody's using this any more
  (let* ((eof nil)
         (subtype nil)
         (element-size nil)
         (min nil)
         (max nil)
         (bit-offset nil)
         (buffer-octet-size  elements-per-buffer))
    ; need ppc types here too. ok.
    (let ((maybe-subtype (element-type-subtype element-type)))
      (if (eq element-type 'extended-character)
        (setq element-size 16 subtype maybe-subtype) ;$v_xstr)
        (if (subtypep element-type 'character)  ; not really cltl2 but what the foo. Nobody wants 16 bit char files.
          (setq element-size 8 subtype (element-type-subtype 'base-character)) ; $v_sstr)
          (let* ((signed (list 'signed-byte 0))
                 (unsigned (list 'unsigned-byte 0)))
            (declare (dynamic-extent signed unsigned))
            (dotimes (i 32 (report-bad-arg element-type '(or character (signed-byte 32) (unsigned-byte 32))))
              (let* ((j (1+ i)))
                (declare (fixnum j))
                (rplaca (cdr signed) j)
                (unless (= j 1)
                  (if (subtypep element-type signed)
                    (setq element-size j
                          subtype (if (memq j '(8 16 32)) maybe-subtype))))
                (rplaca (cdr unsigned) j)
                (if (subtypep element-type unsigned)
                  (setq element-size j
                        min 0
                        subtype (if (memq j '(1 8 16 32)) maybe-subtype))))
              (if element-size (return)))
            (if min                         ; was unsigned
              (setq max (1- (ash 1 element-size)))
              (setq min (- (ash 1 (1- element-size)))
                    max (1- (ash 1 (1- element-size)))))
            (do* ((m (ash elements-per-buffer 3) (+ m 8)))
                 ((eq element-size (gcd m element-size)) (setq buffer-octet-size (ash m -3)))
              (declare (fixnum m)))
            (unless subtype (setq bit-offset 0))))))
    (setq elements-per-buffer (%octets-to-elements buffer-octet-size element-size))
    ;(print (list elements-per-buffer buffer-octet-size))    
    ;;(with-pstrs ((pname name))
    ;(rlet ((fsref :fsref)) ; nope
    (let ((fsref (make-record (:FSRef :clear t)))) ; gotta keep this thing around, safe and sound
      ;;(fname :hfsunistr255))
      (let ((fname (if resource (resource-fork-name) (data-fork-name))))
        ;;(#_FSGetResourceForkName fname)
        ;;(#_FSGetDataForkName fname))
        ;(path-to-fsref name fsref nil t)
        (path-to-fsref name fsref)  ; use my version - but don't-resolve is a good idea
        ;;(%stack-block ((paramBlock 52 :clear t))
        (rlet ((paramBlock :FSForkIOParam))
          ;;(setf (rref paramblock :hparamblockrec.ioNamePtr) pname
          ;;      (rref paramblock :hparamblockrec.ioVrefNum) vrefnum
          ;;      (rref paramblock :hparamblockrec.ioversnum) 0
          ;;      (rref paramblock :hparamblockrec.ioPermssn) permission
          ;;      (rref paramblock :hparamblockrec.ioMisc) (%null-ptr))
          (setf (pref paramblock :FSForkIOParam.ref) fsref
                (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)
                (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
                (pref paramblock :FSForkIOParam.permissions) permission)
          (let ((res
                 (#_PBOpenForkSync paramblock)
                 ))
            (unless (eql #$noErr res)
              (signal-file-error res name)))
          ;;(#_PBGetEOFSync paramBlock)
          (#_PBGetForkSizeSync paramblock)
          ; unsignedwide->integer would be a bit faster here.
          ;(setf eof (+ (ash (pref paramblock :FSForkIOParam.positionOffset.hi) 32)
          ;             (pref paramblock :FSForkIOParam.positionOffset.lo)))
          (setf eof (unsignedwide->integer (pref paramblock :FSForkIOParam.positionOffset)))
          ;;(setq eof (%get-long paramBlock $ioLEOF))
          (let* ((bufvector nil)
                 (buffer nil))
            (if subtype
              (progn
                (multiple-value-setq (bufvector buffer)
                  (%make-heap-ivector subtype
                                      buffer-octet-size
                                      elements-per-buffer)))
              (setq buffer (#_NewPtr buffer-octet-size)))
            (let* ((pb (make-record (:FSForkIOParam :clear t)))
                   (fblock (%istruct
                            'fblock
                            pb
                            nil
                            nil
                            buffer
                            bufvector
                            buffer-octet-size
                            0
                            0
                            0
                            (%octets-to-elements eof element-size)
                            stream
                            element-type
                            element-size
                            elements-per-buffer
                            min
                            max
                            bit-offset
                            scriptruns
                            0
                            0 
                            -1
                            nil
                            external-format)))
              ;(unless (eql 0 vrefnum)
              (setf 
               ;;(rref pb :hparamblockrec.ioVrefNum) ;; hope we don't need this anymore
               ;;(%stack-iopb (vpb np)
               ;;  (setf (rref vpb :hparamblockrec.iovrefnum) vrefnum
               ;;        (rref vpb :hparamblockrec.ionameptr) pname
               ;;        (rref vpb :hparamblockrec.iovolindex) -1)
               ;;  (#_PBHGetVInfoSync vpb)
               ;;  (rref vpb :hparamblockrec.iovrefnum))
               ;;(rref pb :hparamblockrec.iocompletion) (%null-ptr)
               (pref pb :FSForkIOParam.iocompletion) (%null-ptr)
               
               ;;(rref pb :hparamblockrec.iorefnum) (pref paramBlock :hparamblockrec.ioRefnum)
               (pref pb :FSForkIOParam.forkRefNum) (pref paramBlock :FSForkIOParam.forkRefNum)
               
               (pref pb :FSForkIOParam.ref) fsref ; or (pref paramBlock :FSForkIOParam.ref) ; the fsref
               
               ;;(rref pb :hparamblockrec.ioresult) #$noErr
               (pref pb :FSForkIOParam.ioresult) #$noErr
               
               ;;(rref pb :hparamblockrec.ioposmode) #$fsFromStart
               (pref pb :FSForkIOParam.positionMode) #$fsFromStart
               
               ;(rref pb :hparamblockrec.ioreqcount) buffer-octet-size
               ;;(rref pb :hparamblockrec.iobuffer) buffer
               (pref pb :FSForkIOParam.buffer) buffer
               
               ;;(rref pb :hparamblockrec.ioactcount) 0)
               (pref pb :FSForkIOParam.actualCount) 0)
              ;(print (filename-from-fsref (pref pb :FSForkIOParam.ref)))
              (when (> eof 0)
                (%fbRead fblock 0))
              fblock)))))))

; This may be dangerous. The parameter block for 64-bit files is a :FSForkIOParam, which
;   is NOT what #_PBFlushVolSync is expecting. But it may be similar enough that the
;   "reserved" fields in a :FSForkIOParam are what #_PBFlushVolSync expects.
; Let's not take the chance. Best I can tell, the proper reserved field of a :FSForkIOParam
;   [where ioVRefNum used to be] always contains 0. So let's be sure by calling volume-from-fsref
;   instead and use a separate pb.
;#-ignore
(defun %fclose (fblock &optional flush-only)
  (with-paramblock (fblock pb1 t)
    ;(print (filename-from-fsref (pref pb1 :FSForkIOParam.ref)))
    (rlet ((vpb :VolumeParam))
      (let ((vnum ;(volume-from-forkref (pref pb1 :FSForkIOParam.forkrefnum)) ; broken
             (volume-from-fsref (pref pb1 :FSForkIOParam.ref))
             ))
        (setf (pref vpb :VolumeParam.ioNamePtr) (%null-ptr)
              (pref vpb :VolumeParam.ioVRefNum) vnum)
        (unwind-protect
          (%fbFlush fblock)  ;; may fail if disk full
          (unless flush-only
            (errchk (#_PBCloseForkSync pb1)))
          ; http://developer.apple.com/techpubs/macosx/Carbon/Files/FileManager/File_Manager/DataTypes/FSRef.html
          ; says "There is no need to call the File Manager to dispose an FSRef." So it's probably okay.
          ;(when (macptrp (rref pb1 :FSForkIOParam.ref))
          ;  (#_DisposePtr (rref pb1 :FSForkIOParam.ref))) ; dump the fsref
          (if flush-only
            (progn
              (errchk (#_PBFlushForkSync pb1))
              (if (eq flush-only 'finish-output)
                (errchk (#_PBFlushVolSync vpb))))
            (progn
              (errchk (#_PBFlushVolSync vpb))
              (#_DisposePtr pb1)
              (setf (fblock.pb fblock) nil)
              (let* ((bufvector (fblock.bufvec fblock)))
                (if bufvector
                  (%dispose-heap-ivector bufvector)
                  (#_DisposePtr (fblock.buffer fblock))))
              (setf (fblock.buffer fblock) nil
                    (fblock.bufvec fblock) nil)))
          nil)))))

;#-ignore
(defun %fbRead (fblock base)
  (let* ((element-size (fblock.nbits-per-element fblock))
         (pb (%fblock.pb fblock)))
    (declare (type macptr pb))
    
    (setf (fblock.filepos fblock) base)         ; 8-bit
    (setf (pref pb :FSForkIOParam.positionOffset.hi) (ldb uw-hi base)
          (pref pb :FSForkIOParam.positionOffset.lo) (ldb uw-lo base)
          (pref pb :FSForkIOParam.requestCount) (fblock.bufsize fblock)
          (pref pb :FSForkIOParam.positionMode) #$fsFromStart)
    (let* ((err (#_PBReadForkSync pb)))
      (unless (eql #$noErr err)
        (unless (eql #$eofErr err)
          (signal-file-error err))))
    (setf (fblock.bufidx fblock) 0)
    (unless (fblock.bufvec fblock)
      (setf (fblock.element-bit-offset fblock) 0))
    (setf (fblock.bufcount fblock) (%octets-to-elements (pref pb :FSForkIOParam.actualCount) element-size))))

;#-ignore
(defun %fbFlush (fblock)
  (when (fblock.dirty fblock)
    (setf (fblock.dirty fblock) nil)
    (let* ((element-size (fblock.nbits-per-element fblock))
           (pb (%fblock.pb fblock))
           (8-bit-filepos (fblock.filepos fblock))
           (filepos (%octets-to-elements 8-bit-filepos (fblock.nbits-per-element fblock)))
           (elements-written (fblock.bufidx fblock))
           (elements-read (fblock.bufcount fblock))
           (new-eof (+ filepos (max elements-written elements-read))))
      (declare (type macptr pb))
      (setf (pref pb :FSForkIOParam.positionOffset.hi) (ldb uw-hi 8-bit-filepos)
            (pref pb :FSForkIOParam.positionOffset.lo) (ldb uw-lo 8-bit-filepos)
            (pref pb :FSForkIOParam.positionMode) #$fsFromStart
            (pref pb :FSForkIOParam.requestCount) (%elements-to-octets (max elements-written elements-read) element-size)) 
      (when (> new-eof (fblock.fileeof fblock))
        (setf (fblock.fileeof fblock) new-eof))
      (errchk (#_PBWriteForkSync pb)))))




;(%fclose fblock);
;Returns nil
;Close file referenced by fblock
#+ignore
(defun %fclose (fblock &optional flush-only)
  (with-paramblock (fblock pb1 t)
    (unwind-protect
      (%fbFlush fblock)  ;; may fail if disk full
      (unless flush-only
        (errchk (#_PBCloseSync pb1)))
      (setf (rref pb1 :hparamblockrec.ionameptr) (%null-ptr))
      (if flush-only
        (progn
          (errchk (#_PBFlushFileSync pb1))
          (if (eq flush-only 'finish-output)
            (errchk (#_PBFlushVolSync pb1))))
        (progn
          (errchk (#_PBFlushVolSync pb1))
          (#_DisposePtr pb1)
          (setf (fblock.pb fblock) nil)
          (let* ((bufvector (fblock.bufvec fblock)))
            (if bufvector
              (%dispose-heap-ivector bufvector)
              (#_DisposePtr (fblock.buffer fblock))))
          (setf (fblock.buffer fblock) nil
                (fblock.bufvec fblock) nil)))
      nil)))


;(%funtyi fblock char)
;returns nil
; unread char for file referenced by fblock

(defun %funtyi (fblock char)
  (setf (fblock.lastchar fblock) (if (characterp char) char (%code-char char)))
  nil)


;(%feofp fblock)
;returns T if file referenced by fblock is at end of file
;otherwise returns nil

(defun %feofp (fblock)
  (eql (%fsize fblock) (%fpos fblock)))

;(%fpos fblock &optional position)
;returns element position in file.
;if position is supplied, it sets the element position to position and
;returns new position.

; from patch 2 - add truncate arg
(defun %fpos (fblock &optional position truncate)
  (let* ((current8bitbase (fblock.filepos fblock))
         (element-size (fblock.nbits-per-element fblock))
         (logicalpos (+ (%octets-to-elements current8bitbase element-size) (fblock.bufidx fblock))))
    (if (not position)
      (- logicalpos (if (fblock.lastchar fblock) 1 0))
      (let* ((newidx (mod position (fblock.elements-per-buffer fblock)))
             (new8bitbase (%elements-to-octets (- position newidx) element-size))
             eof)
        (setf (fblock.lastchar fblock) nil)
        (setq eof (%fsize fblock))
        (when (> eof (fblock.fileeof fblock))
          (%fsize fblock eof))
        (unless (and (= current8bitbase new8bitbase)
                     (< newidx (fblock.bufcount fblock)))
          (let* ((size (%fsize fblock)))
            (if (> position size)
              (setq position size newidx (mod size (fblock.elements-per-buffer fblock)))))
          (%fbflush fblock)
          (%fbread fblock new8bitbase))
        (setf (fblock.bufidx fblock) newidx)
        (when truncate (setf (fblock.bufcount fblock) newidx))  ; << 6/20/95
        (unless (fblock.bufvec fblock)
          (setf (fblock.element-bit-offset fblock) (* element-size newidx)))
        position))))

;(%fsize fblock &optional new-size)
;returns element size of file referenced by fblock.
;if new-pos is supplied, it sets the file size and returns new-pos.
;if size is set to less than the current file position the file is
;truncated and THE CALLER sets the position to the new size.
;(This is how things have behaved for the last N years, despite
; what the comments might have said...)
#+ignore
(defun %fsize (fblock &optional new-pos)
  (if (null new-pos)
    (let* ((eof (fblock.fileeof fblock))
           (eof1 (if (fblock.dirty fblock)
                   (+ (%octets-to-elements (fblock.filepos fblock) (fblock.nbits-per-element fblock))
                      (max (fblock.bufcount fblock)
                           (fblock.bufidx fblock)))
                   0)))
      (when (fblock.lastchar fblock)
        (decf eof1))
      (max eof eof1))
    (let* ((pb (%fblock.pb fblock))
           (nbits-per-element (fblock.nbits-per-element fblock))
           (offset (- new-pos (%octets-to-elements (fblock.filepos fblock) nbits-per-element))))
      (if (and (>= offset 0) (< offset (fblock.bufsize fblock)))
        (setf (fblock.bufcount fblock) offset))
      (rset pb :hparamblockrec.iomisc
            (%int-to-ptr
             (%elements-to-octets new-pos nbits-per-element)))
      (setf (fblock.fileeof fblock) new-pos)
      (#_PBSetEOFSync pb)
      new-pos)))

;#-ignore
(defun %fsize (fblock &optional new-size)
  (if (null new-size)
    (let* ((eof (fblock.fileeof fblock))
           (eof1 (if (fblock.dirty fblock)
                   (+ (%octets-to-elements (fblock.filepos fblock) (fblock.nbits-per-element fblock))
                      (max (fblock.bufcount fblock)
                           (fblock.bufidx fblock)))
                   0)))
      (when (fblock.lastchar fblock)
        (decf eof1))
      (max eof eof1))
    (let* ((pb (%fblock.pb fblock))
           (nbits-per-element (fblock.nbits-per-element fblock))
           (offset (- new-size (%octets-to-elements (fblock.filepos fblock) nbits-per-element)))
           (8-bit-size (%elements-to-octets new-size nbits-per-element)))
      (if (and (>= offset 0) (< offset (fblock.bufsize fblock)))
        (setf (fblock.bufcount fblock) offset))
      ; Note: even though we're messing with positionOffset here -- it's necessary for #_PBSetForkSizeSync --
      ;    it won't hurt anything because positionOffset gets reset to the current file position
      ;    in %fbread and %fbflush.
      (setf (pref pb :FSForkIOParam.positionOffset.hi) (ldb uw-hi 8-bit-size)
            (pref pb :FSForkIOParam.positionOffset.lo) (ldb uw-lo 8-bit-size))
      (setf (fblock.fileeof fblock) new-size)
      ; assumes positionMode has already been set to #$fsfromstart
      ;(errchk (#_PBAllocateForkSync pb)) ; errors (of course) when there's no allocation necessary!
      (errchk (#_PBSetForkSizeSync pb))
      new-size)))




;(%ftyi fblock)
;returns next character from file referenced by fblock.
;if eof, returns nil.

#|
(defun %ftyi (fblock)
  (let* ((ch (fblock.lastchar fblock)))
    (if ch
      (setf (fblock.lastchar fblock) nil)
      (let* ((idx (fblock.bufidx fblock))
             (count (fblock.bufcount fblock))
             (vector (fblock.bufvec fblock)))
        (declare (fixnum idx count))
        (when (< idx count)
          (when vector
            (setq ch (%schar vector idx))
            (setf (fblock.bufidx fblock) (incf idx))
            (if (= idx count)
              (%fbReadAhead0 fblock nil))))))
    ch))
|#

#|
(defun %ftyi (fblock)
  (let* ((ch (fblock.lastchar fblock)))
    (if ch  ;; from untyi
      (setf (fblock.lastchar fblock) nil)
      (let* ((idx (fblock.bufidx fblock))
             (count (fblock.bufcount fblock))
             (vector (fblock.bufvec fblock)))
        (declare (fixnum idx count))
        ;(cerror "a" "b")
        (when (< idx count)
          (when vector
            (setq ch (%schar vector idx))
            (when (%i> (char-code ch) #x7f)              
              (if (eq (fblock.external-format fblock) :utf8)  ;; don't do hairy-ftyi for utf8 files!
                (progn (setf (fblock.bufidx fblock) (incf idx))
                       (if (= idx count)
                         (%fbReadAhead0 fblock nil))
                       (return-from %ftyi (do-utf8-convert ch fblock)))
                ;; happens if not utf8 or utf16 and no scriptruns
                (if (not (eq (fblock.element-type fblock) 'extended-character))  ;; or something 
                  (setq ch (convert-char-to-unicode ch #$kcfstringencodingmacroman)))))
            (setf (fblock.bufidx fblock) (incf idx))
            (if (= idx count)
              (%fbReadAhead0 fblock nil))))))
    ch))
|#

(defun %ftyi (fblock)
  (let* ((ch (fblock.lastchar fblock)))
    (if ch  ;; from untyi
      (progn (setf (fblock.lastchar fblock) nil)
             ch)
      (let* ((idx (fblock.bufidx fblock))
             (count (fblock.bufcount fblock))
             (vector (fblock.bufvec fblock)))
        (declare (fixnum idx count))
        (when (< idx count)
          (when vector
            (setq ch (%schar vector idx))
            (setf (fblock.bufidx fblock) (incf idx))
            (if (= idx count)
              (%fbReadAhead0 fblock nil))
            (if (%i> (%char-code ch) #x7f)              
              (if (eq (fblock.external-format fblock) :utf8)  ;; don't do hairy-ftyi for utf8 files! 
                (setq ch (do-utf8-convert ch fblock))
                ;; happens if not utf8 or utf16 and no scriptruns
                (if (not (eq (fblock.element-type fblock) 'extended-character))  ;; or something 
                  (setq ch (convert-char-to-unicode ch #$kcfstringencodingmacroman)))))
            ch))))))

;; clunky - do a buffer at a time if used a lot
(defun do-utf8-convert (char fblock)
  (%stack-block ((buf 6))
    (%put-byte buf (%char-code char) 0)
    (let ((fudge 0))
      (declare (fixnum fudge))
      (with-macptrs ((cfstr))
        (loop          
          (%setf-macptr cfstr (#_cfstringcreatewithbytes (%null-ptr)
                               buf (%i+ 1 fudge)
                               #$kcfstringencodingutf8 nil))
          (if (%null-ptr-p cfstr) 
            (incf fudge) 
            (return))
          (if (> fudge 6)(error "confused in UTF8"))
          (let ((next-ch (%ftyi-sub fblock)))
            (%put-byte buf (%char-code next-ch) fudge)))        
        (let ((uni-len (#_CFStringGetLength cfstr)))
          (%stack-block ((outbuf (+ uni-len uni-len)))
            (cfstringgetcharacters cfstr 0 uni-len outbuf)
            (#_cfrelease cfstr)
            (if (> uni-len 1)(error "confused"))  ;; can it be two ?
            (code-char (%get-word outbuf 0))))))))

(defun %ftyi-sub (fblock)
  (let* ((idx (fblock.bufidx fblock))
         (count (fblock.bufcount fblock))
         (vector (fblock.bufvec fblock))
         ch)
    (declare (fixnum idx count))
    (when (< idx count)
      (when vector
        (setq ch (%schar vector idx))            
        (setf (fblock.bufidx fblock) (incf idx))
        (if (= idx count)
          (%fbReadAhead0 fblock nil))))
    ch))
  

#| 
(defun %hairy-ftyi (fblock)
  (let* ((ch (fblock.lastchar fblock)))
    (if ch
      (setf (fblock.lastchar fblock) nil)
      (let* ((idx (fblock.bufidx fblock))
             (count (fblock.bufcount fblock))
             (vector (fblock.bufvec fblock))
             (charpos (fblock.charpos fblock))
             (scriptruns (fblock.scriptruns fblock)))
        (declare (fixnum idx count charpos))
        (when (< idx count)
          (when (= charpos (the fixnum (fblock.endrun fblock)))
            (if (fixnump scriptruns) ; all one script
              (progn 
                (setf (fblock.endrun fblock) most-positive-fixnum)  ; <<
                (setf (fblock.chartable fblock)(get-char-byte-table scriptruns)))
              (let ((sidx (1+ (fblock.scriptidx fblock))))
                (setf (fblock.scriptidx fblock) sidx)
                (let ()
                  (setf (fblock.endrun fblock) (fontruns-pos scriptruns (1+ sidx)))
                  (setf (fblock.chartable fblock)(get-char-byte-table (fontruns-font scriptruns sidx)))))))
          (let ((table (fblock.chartable fblock))) 
            (when vector
              (setq ch (%schar vector idx))
              (when table
                (let ((code (%char-code ch)))
                  (when (neq #$smSingleByte (aref table code))
                    (setf (fblock.bufidx fblock) (incf idx))
                    (when (= idx count)
                      (%fbReadAhead0 fblock nil)
                      (setq idx (fblock.bufidx fblock)
                            count (fblock.bufcount fblock)))
                    (setq ch (%code-char (%ilogior (ash code 8) (%scharcode vector idx)))))))
              (setf (fblock.bufidx fblock) (incf idx))
              (setf (fblock.charpos fblock)(1+ charpos))           
              (if (= idx count)
                (%fbReadAhead0 fblock nil)))))))
    ch))
|#

(defun %hairy-ftyi (fblock)
  (cond 
   ((eq (fblock.element-type fblock) 'extended-character)
    (%ftyi fblock))
   ((eq (fblock.external-format fblock) :utf8)
    (%ftyi fblock))
   (t    
    (let* ((ch (fblock.lastchar fblock)))
      (if ch
        (setf (fblock.lastchar fblock) nil)
        (let* ((idx (fblock.bufidx fblock))
               (count (fblock.bufcount fblock))
               (vector (fblock.bufvec fblock))
               (charpos (fblock.charpos fblock))
               (scriptruns (fblock.scriptruns fblock))
               )
          (declare (fixnum idx count charpos))
          ;(cerror "a" "b")
          (when (< idx count)
            (when (= charpos (the fixnum (fblock.endrun fblock)))
              (if (fixnump scriptruns) ; all one script
                (progn 
                  (setf (fblock.endrun fblock) most-positive-fixnum)  ; <<
                  (setf (fblock.chartable fblock)(get-char-byte-table scriptruns)))
                (let ((sidx (1+ (fblock.scriptidx fblock))))
                  (setf (fblock.scriptidx fblock) sidx)
                  (let ()
                    (setf (fblock.endrun fblock) (fontruns-pos scriptruns (1+ sidx)))
                    (setf (fblock.chartable fblock)(get-char-byte-table (fontruns-font scriptruns sidx)))))))
            (let ((table (fblock.chartable fblock)))
              (when vector
                (setq ch (%schar vector idx))
                (when table
                  (let ((code (%char-code ch)))
                    (when (neq #$smSingleByte (aref table code))
                      (setf (fblock.bufidx fblock) (incf idx))
                      (when (= idx count)
                        (%fbReadAhead0 fblock nil)
                        (setq idx (fblock.bufidx fblock)
                              count (fblock.bufcount fblock)))
                      (setq ch (%code-char (%ilogior (ash code 8) (%scharcode vector idx)))))))
                (let ((encoding (if (fixnump scriptruns) scriptruns (fontruns-font scriptruns (fblock.scriptidx fblock)))))
                  (if (or (> (char-code ch) #x7f)
                          (memq encoding '(#.#$kcfstringencodingmacsymbol #.#$kcfstringencodingmacdingbats)))
                    (setq ch (convert-char-to-unicode ch encoding))))
                (setf (fblock.bufidx fblock) (incf idx))
                (setf (fblock.charpos fblock)(1+ charpos))           
                (if (= idx count)
                  (%fbReadAhead0 fblock nil)))))))
      ch))))
  

(defun %fread-byte (fblock)
  (let* ((vector (fblock.bufvec fblock))
         (idx (fblock.bufidx fblock))
         (count (fblock.bufcount fblock)))
    (declare (fixnum idx count))
    (when (< idx count)
      (let* ((byte (if vector (uvref vector idx))))
        (unless byte
          (let* ((bit-offset (fblock.element-bit-offset fblock))
                 (element-size (fblock.nbits-per-element fblock))
                 (unsigned (eql 0 (fblock.minval fblock)))
                 (buffer (fblock.buffer fblock)))
            (declare (fixnum bit-offset element-size))
            (when buffer
              ; here for weird sizes presumably less than 32
              (setf (fblock.element-bit-offset fblock) (the fixnum (+ bit-offset element-size)))
              #-ppc-target
              (lap-inline ()
                (:variable bit-offset element-size buffer unsigned byte)
                (move.l (varg buffer) atemp0)
                (move.l (atemp0 $macptr.ptr) atemp0)
                (move.l (varg bit-offset) da)
                (getint da)
                (move.l (varg element-size) db)
                (getint db)
                (cmp.l (varg unsigned) nilreg)
                (if# ne
                  (bfextu (atemp0) da db arg_z)
                  (jsr_subprim $sp-mkulong)
                  else#
                  (bfexts (atemp0) da db arg_z)
                  (jsr_subprim $sp-mklong))
                (move.l acc (varg byte)))
              #+ppc-target
              (setq byte (ppc-read-weird-byte bit-offset element-size buffer unsigned)))))
        (setf (fblock.bufidx fblock) (incf idx))
        (if (= idx count)
          (%fbReadAheaD0 fblock nil))
        byte))))

#+ppc-target
(progn

; It's awfully tempting to convert these to LAP...
; Makes you appreciate the 68K bit field instructions.
(defun ppc-read-weird-byte (bit-offset element-size buffer unsigned)
  (declare (fixnum bit-offset element-size)
           (type macptr buffer))
  (multiple-value-bind (byte-offset bit-offset-in-byte) (%fixnum-truncate bit-offset 8)
    (declare (fixnum byte-offset bit-offset-in-byte))
    (let* ((initial-bits (- 8 bit-offset-in-byte))
           (initial-mask (1- (the fixnum (%ilsl initial-bits 1))))
           (bits-remaining (- element-size initial-bits))
           (res (the fixnum (logand (the fixnum (%get-unsigned-byte buffer byte-offset)) initial-mask))))
      (declare (fixnum initial-bits initial-mask bits-remaining))
      (if (< bits-remaining 0)
        (%ilsr (the fixnum (- bits-remaining)) res)
        (macrolet ((loop-body (fixnum?)
                     (flet ((left-shift (num bits)
                              (if fixnum?
                                `(%ilsl ,bits ,num)
                                `(ash ,num ,bits))))
                       (let ((type (if fixnum? 'fixnum 'integer)))
                         `(locally (declare (type ,type res))
                            (loop
                              (when (eql bits-remaining 0) (return))
                              (incf byte-offset)
                              (when (< bits-remaining 8)
                                (let ((final-shift (- 8 bits-remaining)))
                                  (declare (fixnum final-shift))
                                  (setq res (+ (the ,type ,(left-shift 'res 'bits-remaining))
                                               (the fixnum (%ilsr final-shift (%get-unsigned-byte buffer byte-offset))))))
                                (return))
                              (setq res (+ (the ,type ,(left-shift 'res 8))
                                           (the fixnum (%get-byte buffer byte-offset))))
                              (decf bits-remaining 8))
                            (if unsigned
                              res
                              (if (,(if fixnum? '%ilogbitp 'logbitp) (the fixnum (1- element-size)) res)
                                (the ,type (- res (the ,type ,(left-shift 1 'element-size))))
                                res)))))))
          (if (< element-size (- ppc::nbits-in-word ppc::fixnum-shift))
            (loop-body t)                 ; guaranteed fixnum result
            (loop-body nil)))))))

; This writes the bits from lsb to msb in byte, the opposite of ppc-read-weird-byte
(defun ppc-write-weird-byte (bit-offset element-size buffer byte)
  (let ((fixnum-byte (fixnump byte)))
    (multiple-value-bind (byte-offset initial-bits)
                         (%fixnum-truncate (the fixnum (+ bit-offset element-size)) 8)
      (declare (fixnum byte-offset initial-bits))
      (let ((bits-left (- element-size initial-bits)))
        (declare (fixnum bits-left))
        (unless (eql 0 initial-bits)
          (let* ((left-shift (- 8 initial-bits))
                 (mask (1- (the fixnum (%ilsl initial-bits 1))))
                 (read-mask (1- (the fixnum (%ilsl left-shift 1))))
                 (bits (%ilsl left-shift
                              (if fixnum-byte
                                (logand (the fixnum byte) mask)
                                (logand byte mask))))
                 (read-bits (%get-unsigned-byte buffer byte-offset)))
            (declare (fixnum left-shift mask read-mask bits read-bits))
            (when (< bits-left 0)
              (let* ((bits-left (- bits-left))
                     (high-mask (%ilsl (the fixnum (- 8 bits-left))
                                       (the fixnum (1- (%ilsl bits-left 1)))))
                     (read-mask (logior read-mask high-mask))
                     (mask (lognot read-mask)))
                (declare (fixnum shift high-mask read-mask mask))
                (setf (%get-unsigned-byte buffer byte-offset)
                      (logior (the fixnum (logand mask bits))
                              (the fixnum (logand read-bits read-mask)))))
              (return-from ppc-write-weird-byte nil))
            (setf (%get-unsigned-byte buffer byte-offset)
                  (logior bits (the fixnum (logand  read-bits read-mask))))
            (setq byte
                  (if fixnum-byte
                    (%ilsr initial-bits byte)
                    (prog1 (ash byte (the fixnum (- initial-bits)))
                      (when (fixnump byte) (setq fixnum-byte t)))))))
        (loop
          (when (eql bits-left 0) (return))
          (decf byte-offset)
          (when (< bits-left 8)
            (let* ((mask (1- (the fixnum (%ilsl bits-left 1))))
                   (read-mask (%ilsl bits-left
                                     (the fixnum
                                       (1- (the fixnum
                                             (%ilsl (the fixnum (- 8 bits-left)) 1))))))
                   (bits (if fixnum-byte
                           (logand (the fixnum byte) mask)
                           (logand byte mask)))
                   (read-bits (logand (the fixnum (%get-unsigned-byte buffer byte-offset)) read-mask)))
              (declare (fixnum mask read-mask bits read-bits))
              (setf (%get-unsigned-byte buffer byte-offset)
                    (the fixnum (+ bits read-bits))))
            (return))
          (let ((bits (if fixnum-byte
                        (prog1 (logand (the fixnum byte) #xff)
                          (setq byte (%ilsr 8 byte)))
                        (prog1 (logand byte #xff)
                          (when (fixnump (setq byte (ash byte -8)))
                            (setq fixnum-byte t))))))
            (setf (%get-unsigned-byte buffer byte-offset) bits))
          (decf bits-left 8))))))

)

(defun %fbReadAhead0 (fblock writing?)
  (let* ((element-count (fblock.bufsize fblock))
         (nextbase (+ (fblock.filepos fblock) element-count))
         (eof (%elements-to-octets (fblock.fileeof fblock) (fblock.nbits-per-element fblock)))
         (before-eof? (> eof nextbase)))
    (%fbflush fblock)
    (when (or writing? before-eof?)
      (if before-eof?
        (%fbread fblock nextbase)
        (progn (setf (fblock.filepos fblock) nextbase   ; writing past eof.
                     (fblock.bufcount fblock) 0
                     (fblock.bufidx fblock) 0) 
               (unless (fblock.bufvec fblock)
                 (setf (fblock.element-bit-offset fblock) 0)))))))
                   
;(%ftyo fblock char)
;returns nil
;writes char to file referenced by fblock

(defun %ftyo (fblock char)
  (let* ((index (fblock.bufidx fblock))
         (bufsize (fblock.bufsize fblock)))
    (declare (fixnum index bufsize))
    (when (fblock.lastchar fblock)
      (setf (fblock.lastchar fblock) nil)
      (when (< (decf index) 0)
        (%fpos fblock (+ (fblock.filepos fblock) index))
        (setq index (fblock.bufidx fblock))))
    (when (<= bufsize index)
      ; this happens if we just READ the last elt in the buffer and file
      (setf (fblock.bufidx fblock) (setq index 0))
      (incf (fblock.filepos fblock) bufsize)
      (if (<= (fblock.filepos fblock)(fblock.fileeof fblock)) ; <<< 
        (setf (fblock.bufcount fblock) 0)
        (error "Shouldn't in %ftyo. We ought to read the next block first?")))
    (setf (%schar (fblock.bufvec fblock) index) char
          (fblock.bufidx fblock) (incf index)
          (fblock.dirty fblock) t)
    (if (eql index bufsize)
      (%fbreadAHead0 fblock t))
    nil))

#|
; at the end stream-position and file-length should be the same
; This used to fail.
(defun foop ()
  (with-open-file (s "ccl:foo" :direction :io :if-exists :supersede)
    (let ((fblock (slot-value s 'fblock)))
      (dotimes (i 4096)(stream-tyo s #\a))
      (pr-fblock fblock)
      (stream-position s (1- (stream-position s)))
      (pr-fblock fblock)
      (stream-tyi s)
      (format t "~&len ~s" (file-length s))
      (pr-fblock fblock)
      (stream-tyo s #\newline)
      (pr-fblock fblock) ; count was 2048 pos 4096 - wrong
      (format t "~&len ~s" (file-length s))
      (stream-position s))))

(defun pr-fblock (fblock)
  (format t "~&count ~s idx ~s eof ~s pos ~s ~s"
          (fblock.bufcount fblock)
          (fblock.bufidx fblock)
          (fblock.fileeof fblock)
          (fblock.filepos fblock)
          (fblock.dirty fblock)))
|#

(defun %fwrite-byte (fblock byte)
  (let* ((index (fblock.bufidx fblock))
         (bufsize (fblock.elements-per-buffer fblock))
         (min (fblock.minval fblock))
         (max (fblock.maxval fblock)))
    (declare (fixnum index bufsize))
    (unless (and (>= byte min) (<= byte max))
      (report-bad-arg byte `(integer ,min ,max)))
    (when (<= bufsize index)
      ; this happens if we just READ the last elt in the buffer and file
      (setf (fblock.bufidx fblock) (setq index 0))
      (incf (fblock.filepos fblock) bufsize)
      (if (<= (fblock.filepos fblock)(fblock.fileeof fblock)) ; <<< 
        (setf (fblock.bufcount fblock) 0)
        (error "Shouldn't in %fwrite-byte. We ought to read the next block first?")))    
    (let* ((vector (fblock.bufvec fblock)))
      (if vector 
        (setf (uvref vector index) byte)
        (let* ((bit-offset (fblock.element-bit-offset fblock))
               (element-size (fblock.nbits-per-element fblock))
               (buffer (fblock.buffer fblock)))
          (declare (fixnum bit-offset element-size))
          (when buffer
            (setf (fblock.element-bit-offset fblock) (the fixnum (+ bit-offset element-size)))
            #-ppc-target
            (lap-inline ()
              (:variable bit-offset element-size buffer min byte)
              (move.l (varg buffer) atemp0)
              (move.l (atemp0 $macptr.ptr) atemp0)
              (move.l (varg element-size) db)
              (getint db)
              (move.l (varg byte) arg_z)
              (move.l (varg min) arg_x)
              (if# eq 
                (jsr_subprim $sp-getulong)
                else#
                (jsr_subprim $sp-getlong))
              (move.l (varg bit-offset) da)
              (getint da)
              (bfins acc da db @atemp0))
            #+ppc-target
            (ppc-write-weird-byte bit-offset element-size buffer byte)))))
    (setf (fblock.bufidx fblock) (incf index)
          (fblock.dirty fblock) t)
    (if (eql index bufsize)
      (%fbreadAHead0 fblock t))))



(defun %fwrite-from-vector (fblock vector start length &optional check-untyi)
    (unless (= 8 (the fixnum (fblock.nbits-per-element fblock)))
      (error "Can't write vector to file ~s" (fblock.stream fblock)))
    (when check-untyi
      (when (fblock.lastchar fblock)
                  ;; let %ftyo worry about it - itsa pain
        (%ftyo fblock (schar vector start))
        (incf start)
        (decf length)))
    (let* ((written 0)
           (bufsize (fblock.elements-per-buffer fblock))
           (buffer (fblock.buffer fblock)))
      (declare (fixnum written bufsize))
      (do* ((pos start (+ pos written))
            (left length (- left written)))
           ((= left 0) length)
        (declare (fixnum pos left))
        (setf (fblock.dirty fblock) t)
         (let* ((index (fblock.bufidx fblock))
                (avail (- bufsize index)))
          (declare (fixnum avail index))
          (cond 
           ((= (setq written avail) 0)
            (%fbreadahead0 fblock t))
           (t 
            (if (> written left)
              (setq written left))
            (%copy-ivector-to-ptr vector pos buffer index written)            
            (if (= (setf (fblock.bufidx fblock) (+ index written)) bufsize)
              (%fbreadahead0 fblock t))))))))



(defun %fread-to-vector (fblock vector start length &optional check-untyi)
  (unless (= 8 (the fixnum (fblock.nbits-per-element fblock)))
    (error "Can't read vector from file ~s" (fblock.stream fblock)))
  (let ((orig-length length))
    (when check-untyi
      (when (fblock.lastchar fblock)
        (setf (schar vector start) (%ftyi fblock))
        (incf start)
        (decf length)))
    (if (= (fblock.bufcount fblock) (fblock.bufidx fblock))
      (%fbreadahead0 fblock nil))
    (let* ((nread 0)
           (bufsize (fblock.bufcount fblock))
           (buffer (fblock.buffer fblock)))
      (declare (fixnum nread bufsize))
      (do* ((pos start (+ pos nread))
            (left length (- left nread)))
           ((= left 0) (values vector orig-length))
        (declare (fixnum pos left))
        (let* ((index (fblock.bufidx fblock))
               (avail (- bufsize index)))
          (declare (fixnum avail index))
          (if (zerop (setq nread avail))
            (return (values vector (- orig-length left))))
          (if (> nread left)
            (setq nread left))
          (%copy-ptr-to-ivector buffer index vector pos nread)        
          (when (= (setf (fblock.bufidx fblock) (+ index nread)) bufsize)
            (%fbreadahead0 fblock nil)
            (setq bufsize (fblock.bufcount fblock))))))))

; Do read of a block from BASE address
; Assumes all I/O is done on PB
; Since all of it happens synchronously, that's a pretty safe assumption.
#+ignore
(defun %fbRead (fblock base)
  (let* ((element-size (fblock.nbits-per-element fblock))
         (pb (%fblock.pb fblock)))
    (declare (type macptr pb))

    (setf (fblock.filepos fblock) base)         ; 8-bit
    (setf (rref pb :hparamblockrec.ioposoffset) base
          (rref pb :hparamblockrec.ioreqcount) (fblock.bufsize fblock)
          (rref pb :hparamblockrec.ioposmode) #$fsFromStart)
    (let* ((err (#_PBReadSync pb)))
      (unless (eql #$noErr err)
        (unless (eql #$eofErr err)
          (signal-file-error err))))
    (setf (fblock.bufidx fblock) 0)
    (unless (fblock.bufvec fblock)
      (setf (fblock.element-bit-offset fblock) 0))
    (setf (fblock.bufcount fblock) (%octets-to-elements (rref pb :hparamblockrec.ioactcount) element-size))))

; Flush buffer if it's dirty.
#+ignore
(defun %fbFlush (fblock)
  (when (fblock.dirty fblock)
    (setf (fblock.dirty fblock) nil)
    (let* ((element-size (fblock.nbits-per-element fblock))
           (pb (%fblock.pb fblock))
           (8-bit-filepos (fblock.filepos fblock))
           (filepos (%octets-to-elements 8-bit-filepos (fblock.nbits-per-element fblock)))
           (elements-written (fblock.bufidx fblock))
           (elements-read (fblock.bufcount fblock))
           (new-eof (+ filepos (max elements-written elements-read))))
      (declare (type macptr pb))
      (setf (rref pb :hparamblockrec.ioposoffset) 8-bit-filepos
            (rref pb :hparamblockrec.ioposmode) #$fsFromStart
            (rref pb :hparamblockrec.ioreqcount) (%elements-to-octets (max elements-written elements-read) element-size)) 
      (when (> new-eof (fblock.fileeof fblock))
        (setf (fblock.fileeof fblock) new-eof))
      (errchk (#_PBWriteSync pb)))))

#| Test routines

(defun fopen (file &optional (perm $fsRdWrPerm))
  (%fopen file 0 perm))

(defun pf (fblock &optional max &aux char (count 0))
  (while (setq char (%ftyi fblock))
    (tyo char)
    (incf count)
    (if (and max (>= count max))
      (return-from pf count)))
  count)

(defun fcopy (from to &aux char (count 0))
  (while (setq char (%ftyi from))
    (%ftyo to char)
    (incf count))
  count)

(defun freverse (f)
  (let* ((size (%fsize f))
         (p 0)
         (p2 (1- size))
         c c2)
    (while (> p2 p)
      (%fpos f p)
      (setq c (%ftyi f))
      (%fpos f p2)
      (setq c2 (%ftyi f))
      (%fpos f p2)
      (%ftyo f c)
      (%fpos f p)
      (%ftyo f c2)
      (incf p)
      (decf p2))
    (%fpos f 0)
    (%fsize f)))

; I used different names during development
(defun install-new-sysio ()
  (setf (symbol-function '%fopen) #'%nfopen)
  (setf (symbol-function '%fclose) #'%nfclose)
  (setf (symbol-function '%feofp) #'%nfeofp)
  (setf (symbol-function '%ftyi) #'%nftyi)
  (setf (symbol-function '%ftyo) #'%nftyo)
  (setf (symbol-function '%fpos) #'%nfpos)
  (setf (symbol-function '%fsize) #'%nfsize))

(defun c (&optional (file "l1;new-l1-sysio"))
  (time
   (compile-file file
                 :output-file (concatenate 'string "l1f;" (pathname-name file)))))

|#
