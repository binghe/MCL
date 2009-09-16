;;;-*-Mode: LISP; Package: CCL -*-

; xdump.Lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc. The 'tool rules!

; Modification History
;
;01/29/93 bill new nilreg sym: *%dynvlimit%*
;01/07/93 bill ($v_data) -> $v_data (e.g. remove Gary's bootstrapping)
;10/27/91  gb dump new stuff; more careful with vcells.
;------- 2.0b3
;12/31/90  gb add :d_timestamp, d_slfunvfilepos, d_slfunvfileend, d_dynamicheaderpos.

(defrecord dumpheader
  (:d_version :long)
  (:d_timestamp :long)
  (:d_flags :word)
  (:d_nrs_start :long)
  (:d_nrs_end :long)
  (:d_nrsdisp :long)
  (:d_vcells_start :long)	; lowvcell in saved image.
  (:d_vcells_end :long)	; end of vcells in saved image.
  (:d_vcells_disp :long)
  (:d_fcells_start :long)	; lowfcell in saved image.
  (:d_fcells_end :long)	; end of vcells in saved image.
  (:d_fcells_disp :long)
  (:d_slfuns_start :long)       ; start of swappable lfun table
  (:d_slfuns_end :long)	; end of swappable lfun table
  (:d_slfuns_disp :long)
  (:d_gapbase :long)
  (:d_curgap :long)
  (:d_dynamic_gspace_disp :long)
  (:d_gapend :long)
  (:d_pagelimit :long)
  (:d_dynamic_ispace_disp :long)
  (:d_static_gapbase :long)	; saved gapbase,
  (:d_static_curgap	:long)	; 	curgap,
  (:d_static_gspace_disp :long)
  (:d_static_gapend	:long)	; 	gapend,
  (:d_static_pagelimit :long)	;	pagelimit (from static space).
  (:d_static_ispace_disp :long)
  (:d_nrsfilepos :long)	; image file position of nilreg-relative symbols
  (:d_maxslfunlen :long)	; physical length of largest slfun vector.
  (:d_ifilepos :long)	; image file position of dumped ispace
  (:d_ifilelen :long)	; length of (uncompressed) ispace
  (:d_lzwifilelen :long)	; compressed ispace length
  (:d_gfilepos :long)	; image file position of dumped gspace
  (:d_gfilelen :long)	; length of (uncompressed) gspace
  (:d_lzwgfilelen :long)	; compressed gspace length
  (:d_sifilepos :long)	; image file position of dumped (static) ispace.
  (:d_sifilelen :long)	; length of (uncompressed) static ispace.
  (:d_lzwsifilelen :long)	; compressed static ispace length
  (:d_sgfilepos :long)	; image file position of dumped (static) gspace
  (:d_sgfilelen :long)	; length of (uncompressed) static gspace
  (:d_lzwsgfilelen :long)	; compressed static gspace length
  (:d_miscwfilepos :long)	; image file position of "miscellaneous a5 words"
  (:d_miscwfilenum :word)	; # misc a5 word blocks
  (:d_misclfilepos :long)	; image file position of "miscellaneous a5 longs"
  (:d_misclfilenum :word)	; # misc a5 long blocks
  (:d_nil :long)	; address of nil {t, nilsym}
  (:d_nil_disp :long)
  (:d_t	(:array :unsigned-byte 48))        ; two physical symbols, t and nilsym.
  (:d_vcellfilepos :long)	; address of (nilreg-relative) value cells
  (:d_fcellfilepos :long)	; address of (nilreg-relative) function cells
  (:d_fappunb :long)	; unbound fn, for symbol compression.
  (:d_slfunfilepos :long)	; address of swappable lfun table
  (:d_slfunvfilepos :long)	; start of slfunvs on disk
  (:d_slfunvfileend :long)	; end of slfunvs on disk
  (:d_dynamicheaderpos :long)	; where dynamic space header starts, if it's disjoint.
  (:d_packages (:array :long 7)))    ; symbol package table


(def-accessors uvref ; %svref
  scanned-object.tagged-address
  scanned-object.datum
  scanned-object.nrefs
)

(defvar *scanned-objects*)

(defmacro get-scanned-object (o)
  `(gethash ,o *scanned-objects*))

(defmacro make-scanned-object (tagged-address datum)
  `(vector ,tagged-address ,datum 1))

(defparameter *gspace-base-address* (ash 1 20))
(defparameter *ispace-base-address* (ash 1 28))
(defparameter *nil-address* (+ $t_cons (ash 1 19)))
(defparameter *nrs-base-address* (+ *nil-address* 
                                    (lap-inline () 
                                      (move.l (a5 $nrs_start) acc) (sub.l nilreg acc) (mkint acc))))
(defparameter *current-gspace-address* nil)
(defparameter *current-ispace-address* nil)
(defparameter *scan-stack* nil)
(defparameter *xdump-packages* nil)
(defparameter *xdump-roots* nil)
(defvar *xdump-image-file*)
(defvar *xdump-image-file-writer* nil)
(defvar *xdump-image-file-writer-arg* nil)
(defvar *xdump-trace-output* nil)
(defparameter *xdump-fcell-alist* nil)
(defparameter *xdump-vcell-alist* nil)

; Needs to match the list of DEFNRS's in constants.i
(defparameter *xdump-nilreg-relative-symbols*
  '(%err-disp cmain eval apply-evaluated-function error %defun %defvar %defconstant %macro %kernel-restart
    *package* *interrupt-level* :allow-other-keys %toplevel-catch% %toplevel-function% %pascal-functions% 
    *all-metered-functions* *%dynvfp%* *%dynvlimit%* %unbound-function% *foreground* *background-sleep-ticks* 
    *foreground-sleep-ticks* *window-update-wptr* *gc-event-status-bits* *pre-gc-hook* *post-gc-hook* %handlers% 
    %parse-string% %all-packages% *keyword-package* %saved-method-var% %finalization-alist% *current-stack-group*))

(defun xdump-defined-symbol-p (s)
  (memq s *xdump-roots*))

(defun adjust-scanned-ref-count (o)
  (if o
    (incf (scanned-object.nrefs o))))

(defun enqueue-object (o)
  (when (and o
             (not (dtagp o (logior (ash 1 $t_fixnum) (ash 1 $t_imm))))
             (not (get-scanned-object o)))
       (push o *scan-stack*))
    o)

(defun scan-cons (c)
  (let ((info (get-scanned-object c)))
    (unless info
      (let ((addr (+ *current-gspace-address* $t_cons)))
        (setq *current-gspace-address* (+ addr (- 8 $t_cons)))
        (setq info (setf (get-scanned-object c) (make-scanned-object addr c))))
      (enqueue-object (cdr c))
      (enqueue-object (car c)))
    info))

(defun scan-gvector (v)
  (or (get-scanned-object v)
      (let* ((info (setf (get-scanned-object v) (make-scanned-object 
                                                 (+ *current-gspace-address* $t_vector) v))))
        (incf *current-gspace-address* (aligned-vector-size v))
        (dovector (e v) (enqueue-object e))
        info)))

(defun scan-ivector (v)
  (or (get-scanned-object v)
      (progn
        (decf *current-ispace-address* (aligned-vector-size v))
        (setf (get-scanned-object v) (make-scanned-object 
                                      (+ *current-ispace-address* $t_vector) v)))))

(defun scan-lfun-vector (v)
  (or (get-scanned-object v)
      (let* ((info (setf (get-scanned-object v) (make-scanned-object 
                                                 (+ *current-gspace-address* $t_vector) v))))
        (incf *current-gspace-address* (aligned-vector-size v))
        (dotimes (i (%count-immrefs v))
          (enqueue-object (%nth-immediate v i)))
        info)))

(defun scan-float (f)
  (or (get-scanned-object f)
      (progn
        (decf *current-ispace-address* 8)
        (setf (get-scanned-object f) (make-scanned-object 
                                      (+ *current-ispace-address* $t_dfloat) f)))))

(defun xdump-htab-intern (htab pname sym)
  (lap-inline ()
    (:variable pname sym htab)
    (move.l (varg pname) atemp0)
    (vsize atemp0 da)
    (move.l (varg htab) acc)
    (jsr #'%%getsym)
    (if# ne
      (move.l dy db)
      (move.l (varg sym) arg_z)
      (move.l (varg htab) atemp1)
      (jsr #'%%HAdd)))
  sym)

(defun scan-symbol (s)
  (or (get-scanned-object s)
      (let* ((pname (symbol-name s))
             (nilreg-relative (position s *xdump-nilreg-relative-symbols*))
             (s0 (unless (xdump-defined-symbol-p s)
                   (lap-inline ((symbol-package s) (make-symbol pname))
                     (move.l arg_z atemp0)
                     (move.l arg_y (atemp0 $sym.package-plist)))))
             (sym (or s0 s))
             (info (setf (get-scanned-object s) (make-scanned-object 
                                                 (+ (if nilreg-relative
                                                      (+ *nrs-base-address* (* nilreg-relative $sym_size))
                                                      *current-gspace-address*)
                                                    $t_symbol) 
                                                 sym))))
        (when (and (keywordp s) s0) (format t "~& defining ~S as constant ~s" s0 s) (define-constant s0 s))
        (let* ((pair (assq s *xdump-vcell-alist*)))
          (if (and pair s0) (set s0 (cdr pair))))
        (unless nilreg-relative
          (incf *current-gspace-address* $sym_size))
        (dolist (p *xdump-packages*)
          (multiple-value-bind (sym found)
                               (find-symbol pname (car p))
            (when (eq sym s)
              (let ((htab (if (eq found :external) 
                            (pkg.etab (cdr p)) 
                            (if (eq found :internal) 
                              (pkg.itab (cdr p))))))
                (if htab
                  (xdump-htab-intern htab pname sym))))))
        (enqueue-object pname)
        (enqueue-object (global-value-of sym))
        (let* ((def (assq sym *xdump-fcell-alist*)))
          (if def (enqueue-object (cdr def))
              (enqueue-object (fboundp sym))))
        (enqueue-object (lap-inline () 
                          (:variable sym) 
                          (move.l (varg sym) atemp0)
                          (move.l (atemp0 $sym.package-plist) acc)))
                          
        info)))

; How many bytes does v occupy in -this- image ?
(defun aligned-vector-size (v)
  (logand (lognot 7) (+ 11 (%vect-byte-size v))))

(defun copy-package (p)
  (%gvector $v_pkg 
            (cons (make-array (length (car (uvref p 0)))) (cons 0 (cddr (uvref p 0))))   ; itab
            (cons (make-array (length (car (uvref p 1)))) (cons 0 (cddr (uvref p 1))))   ; etab
            nil                         ; used
            nil                         ; used-by
            (copy-list (uvref p 4))     ; names
            nil))                       ; shadowed

(defun scan-package (p)
  (or (get-scanned-object p)
      (error "Didn't expect to see reference to package ~S" p)))

(defun scan-object (o)
  (loop
    (when o
      ;(format t "~& scanning ~s" o)
      (adjust-scanned-ref-count
       (cond ((consp o) (scan-cons o))
             ((symbolp o) (scan-symbol o))
             ((floatp o) (scan-float o))
             ((functionp o) (scan-lfun-vector (%lfun-vector o t)))
             ((%lfun-vector-p o) (scan-lfun-vector o))
             ((packagep o) (scan-package o))
             ((uvectorp o) (if (%ilogbitp $vnodebit (%vect-subtype o))
                             (scan-gvector o)
                             (scan-ivector o))))))
    (unless (setq o (pop *scan-stack*)) (return))))


(defun xdump (filename packages *xdump-vcell-alist* &rest args)
  (declare (special *gc-event-status-bits*))
  (setq packages (mapcar #'pkg-arg packages))
  (let* ((*current-gspace-address* *gspace-base-address*)
         (*current-ispace-address* *ispace-base-address*)
         (*scanned-objects* (make-hash-table :test #'eq))
         (*xdump-packages* (mapcar #'(lambda (p)
                                       (let ((q (copy-package p)))
                                         (setf (get-scanned-object p)
                                               (make-scanned-object (+ *current-gspace-address* $t_vector) q))
                                         (incf *current-gspace-address* (aligned-vector-size q))
                                         (cons p q)))
                                   packages))
         (*xdump-roots* args)
         (*scan-stack* nil))
    (dolist (p packages)
      (dolist (used-by (pkg.used-by p))
        (when (memq used-by packages)

          (push used-by (pkg.used-by (scanned-object.datum (get-scanned-object p))))
          (push p (pkg.used (scanned-object.datum (get-scanned-object used-by)))))))
    (dolist (p packages)
      (let ((q (scanned-object.datum (get-scanned-object p))))
        (dotimes (i (uvsize q)) (scan-object (uvref q i)))))
    (let* ((pname (symbol-name t))
           (temp (make-symbol pname))
           (htab (pkg.etab (cdr (assq *common-lisp-package* *xdump-packages*)))))
      (define-constant temp t)
      (lap-inline (*common-lisp-package* temp) (move.l arg_z atemp0) (move.l arg_y (atemp0 $sym.package-plist)))
      (xdump-htab-intern htab pname t)
      (setf (get-scanned-object t) (make-scanned-object (+ $t_val *nil-address*) temp))
      (scan-object pname)
      (setq pname (symbol-name nil) temp (make-symbol pname))
      (define-constant temp nil)
      (lap-inline (*common-lisp-package* temp) (move.l arg_z atemp0) (move.l arg_y (atemp0 $sym.package-plist)))
      (xdump-htab-intern htab pname (lap-inline () (move.l (a5 $nilsym) acc)))
      (setf (get-scanned-object (lap-inline () (move.l (a5 $nilsym) acc)))
            (make-scanned-object (+ $nil_val *nil-address*) temp))
      (scan-object pname))
    (dolist (a args) (scan-object a))
    (dolist (s *xdump-nilreg-relative-symbols*) (scan-object s))
    ; %nilreg-vcell-symbols%.  Should have a better way of doing this.
    (let ((ispace nil)
            (gspace nil))
        (maphash #'(lambda (k v)
                     (declare (ignore k))
                     (let ((addr (scanned-object.tagged-address v)))
                       (if (> *ispace-base-address* addr *current-ispace-address*)
                         (push v ispace)
                         (if (< *gspace-base-address* addr *current-gspace-address*)
                           (push v gspace)))))
                 *scanned-objects*)
        (flet ((addr< (x y)
                (< (scanned-object.tagged-address x)
                   (scanned-object.tagged-address y))))
          (setq ispace (sort ispace #'addr<)
                gspace (sort gspace #'addr<)))
        (xdump-image filename ispace gspace))))


(defun xdump-byte (b)
  (funcall *xdump-image-file-writer* *xdump-image-file-writer-arg* (logand #xff b))
  (when *xdump-trace-output*
    (setq b (logand #xff b))
    (format t "~2,'0x" b)))

(defun xdump-word (w)
  (xdump-byte (ash w -8))
  (xdump-byte w))

(defun xdump-long (l)
  (xdump-word (ash l -16))
  (xdump-word l))

(defun xdump-zeroes (n)
  (multiple-value-bind (longs bytes) (floor n 4)
    (dotimes (i longs) (xdump-long 0))
    (dotimes (i bytes) (xdump-byte 0))))
                       
(defun vect-byte-ref (ivector i)
  (unless (and (uvectorp ivector)
               (not (%ilogbitp $vnodebit (%vect-subtype ivector))))
    (report-bad-arg ivector 'ivector))
  (unless (and (fixnump i)
               (< -1 i (%vect-byte-size ivector)))
    (error "Bogus byte index for ~S : ~S" ivector i))
  (lap-inline ()
    (:variable ivector i)
    (move.l '0 acc)
    (move.l (varg ivector) atemp0)
    (move.l (varg i) da)
    (getint da)
    (move.b (atemp0 da.l $v_data) acc)
    (mkint acc)))

(defun xdump-ivector (v)
  (xdump-long (lap-inline (v) (move.l arg_z atemp0) (move.l (atemp0 $vec.header) arg_z) (jsr_subprim $sp-mklong)))
  (let* ((size (%vect-byte-size v))
         (psize (aligned-vector-size v)))
    (dotimes (i size) (xdump-byte (vect-byte-ref v i)))
    (xdump-zeroes (- psize (+ size 4)))
    psize))

(defun xdump-float (n)
  (dotimes (i 4 8)
    (xdump-word (lap-inline () 
                  (:variable n i)
                  (move.l (varg n) atemp0)
                  (move.l (varg i) da)
                  (getint da)
                  (add.l da da)
                  (moveq '0 acc)
                  (move.w (atemp0 da.l (- $t_dfloat)) acc)
                  (mkint acc)))))
    
(defun xdump-ispace (ilist)
  (let ((addr *current-ispace-address*))
    (dolist (scanned-obj ilist (unless (= addr *ispace-base-address*) (error "lost synch writing ispace")))
      (unless (= (logand (lognot 7) (scanned-object.tagged-address scanned-obj)) addr)
        (error "Lost synch dumping ispace"))
      (let ((datum (scanned-object.datum scanned-obj)))
        (when *xdump-trace-output*
          (format t "~&addr = #x~8,'0x, datum = ~s~&  :" addr datum))
        (setq addr (+ addr (if (floatp datum) (xdump-float datum) (xdump-ivector datum))))))))

(defun xdump-objref (ref &optional (offset 0))
  (if ref
      (let ((tag (%ttag ref)))
        (if (eq tag $t_fixnum)
          (xdump-long (ash ref $fixnumshift))
          (if (eq tag $t_imm)
            (xdump-long (%address-of ref))
            (progn
              (if (eq tag $t_lfun) (setq ref (%lfun-vector ref t) offset (+ offset 2 $v_data)))
              (let ((scanned-object (get-scanned-object ref)))
                (unless scanned-object (error "Missed ~S in scan." ref))
                (xdump-long (+ offset (scanned-object.tagged-address scanned-object))))))))
      (let* ((*xdump-trace-output* nil))
        (xdump-long *nil-address*))))

(defun xdump-cons (c)
  (xdump-objref (cdr c))
  (xdump-objref (car c))
  8)

(defun xdump-gvector (g)
  (xdump-long (lap-inline (g) (move.l arg_z atemp0) (move.l (atemp0 $vec.header) arg_z) (jsr_subprim $sp-mklong)))
  (let ((bsize (%vect-byte-size g))
        (psize (aligned-vector-size g)))
     (dotimes (i (uvsize g)) (xdump-objref (uvref g i)))
     (xdump-zeroes (- psize (+ bsize 4)))
     psize))

(defun xdump-symbol (s)
  (xdump-long $symbol-header)
  (let ((bits (%symbol-bits s)))
    (declare (fixnum bits))
    (if (neq 0 (logand bits (logior (ash  1 $sym_vbit_indirect) (ash 1 $sym_fbit_indirect))))
      (error "Symbol ~S had indirect bits set; blew it." s))
    (xdump-word bits))
  (xdump-objref (symbol-name s))
  (xdump-objref (%sym-value s))
  (xdump-objref (lap-inline () 
                  (:variable s) 
                  (move.l (varg s) atemp0) 
                  (move.l (atemp0 $sym.package-plist) acc)))
  (xdump-word (lap-inline () 
                (:variable s) 
                (move.l (varg s) atemp0) 
                (moveq '0 acc) 
                (move.w (atemp0 $sym.fapply) acc)
                (mkint acc)))
  (xdump-objref (or (let* ((def (assq s *xdump-fcell-alist*)))
                      (if def (cdr def)))
                    (fboundp s) 
                    %unbound-function%))
  $sym_size)
  
(defun xdump-lfunv (l)
  (let ((bsize (%vect-byte-size l))
        (psize (aligned-vector-size l))
        (immno -1)
        (immbytes 0))
    (declare (fixnum bsize psize))
    (xdump-long (lap-inline (l) (move.l arg_z atemp0) (move.l (atemp0 $vec.header) arg_z) (jsr_subprim $sp-mklong)))
    (do* ((i 0 (1+ i)))
         ((= i bsize))
      (declare (fixnum i))
      (if (neq immbytes 0)
        (setq immbytes (1- immbytes))
        (if (and (>= i 2)
                 (evenp i)
                 (%immref-p (ash (- i 2) -1) l))
          (multiple-value-bind (imm offset) (%nth-immediate l (setq immno (%i+ immno 1)))
            (xdump-objref imm (or offset 0))
            (setq immbytes (1- 4)))
          (xdump-byte (vect-byte-ref l i)))))
    (xdump-zeroes (- psize (+ bsize 4)))
    psize))

(defun xdump-gspace (glist)
  (let ((addr *gspace-base-address*))
    (dolist (scanned-ref glist (unless (eq addr *current-gspace-address*) (error "Lost synch dumping gspace.")))
      (unless (eq addr (logand (lognot 7) (scanned-object.tagged-address scanned-ref)))
        (error "Out of synch dumping gspace."))
      (let ((datum (scanned-object.datum scanned-ref)))
        (when *xdump-trace-output*
          (let* ((*print-length* 10))
            (format t "~&addr = #x~8,'0x, datum = ~s~&  :" addr datum)))
        (setq addr (+ addr 
                      (if (consp datum) 
                        (xdump-cons datum)
                        (if (symbolp datum) 
                          (xdump-symbol datum)
                          (if (%lfun-vector-p datum) 
                            (xdump-lfunv datum) 
                            (xdump-gvector datum))))))))))

(defun xdump-image (filename ispace gspace)
  (with-open-file (*xdump-image-file*  filename
                                       :element-type '(unsigned-byte 8) ; see how slow this is.
                                       :direction :output
                                       :if-does-not-exist :create
                                       :if-exists :overwrite)
    (multiple-value-bind (*xdump-image-file-writer* *xdump-image-file-writer-arg*) (stream-writer *xdump-image-file*)
      (let* ((header (make-record (:dumpheader :clear t))))
        (xdump-zeroes 18)                   ; file header
        (rset header :dumpheader.d_version -1)  ;(%get-long (%currentA5) $verslong))
        (rset header :dumpheader.d_flags 1)   ; (ash 1 $d_swap_image)
        (rset header :dumpheader.d_curgap *current-gspace-address*)
        (rset header :dumpheader.d_gapbase *gspace-base-address*)
        (rset header :dumpheader.d_gapend *current-ispace-address*)
        (rset header :dumpheader.d_pagelimit *ispace-base-address*)
        (rset header :dumpheader.d_nil *nil-address*)
        (rset header :dumpheader.d_nrs_start *nrs-base-address*)
        (rset header :dumpheader.d_nrs_end (+ *nrs-base-address* (* $sym_size (length *xdump-nilreg-relative-symbols*))))
        (rset header :dumpheader.d_fappunb (scanned-object.tagged-address (get-scanned-object %unbound-function%)))
        (let ((headerpos (file-position *xdump-image-file*)))
          (xdump-zeroes (record-length :dumpheader))
          (let ((ifilepos (file-position *xdump-image-file*)))
            (rset header :dumpheader.d_ifilepos ifilepos)
            (xdump-ispace ispace)
            (let ((gfilepos (file-position *xdump-image-file*)))
              (rset header :dumpheader.d_ifilelen (- gfilepos ifilepos))
              (rset header :dumpheader.d_gfilepos gfilepos)
              (xdump-gspace gspace)
              (let ((vcellfilepos (file-position *xdump-image-file*)))
                (rset header :dumpheader.d_gfilelen (- vcellfilepos gfilepos))
                (rset header :dumpheader.d_vcellfilepos vcellfilepos)
                (rset header :dumpheader.d_vcells_start (+ *nil-address* -4))
                (rset header :dumpheader.d_vcells_end (+ *nil-address* -4))
                (rset header :dumpheader.d_fcellfilepos (file-position *xdump-image-file*))
                (rset header :dumpheader.d_fcells_start (+ (- (%get-long (%currentA5) $fcells_start) (%address-of nil)) 
                                                           *nil-address*))
                (rset header :dumpheader.d_fcells_end (+ (- (%get-long (%currentA5) $fcells_start) (%address-of nil)) 
                                                           *nil-address*))
                (rset header :dumpheader.d_nrsfilepos (file-position *xdump-image-file*))
                (dolist (s *xdump-nilreg-relative-symbols*) (xdump-symbol (scanned-object.datum (get-scanned-object s)))))))
          (with-macptrs ((p (%inc-ptr header (get-field-offset :dumpheader.d_t))))
            (%put-long p $symbol-header)
            (%put-word p (logior (ash 1 $sym_vbit_const) (ash 1 $sym_vbit_special)) 4)
            (%put-long p (scanned-object.tagged-address (get-scanned-object (symbol-name t))) 6)
            (%put-long p (+ $t_val *nil-address*) 10)
            (%put-long p (scanned-object.tagged-address (get-scanned-object *common-lisp-package*)) 14)
            (%put-word p $jsr_absl 18)
            (%put-long p (scanned-object.tagged-address (get-scanned-object %unbound-function%)) 20)
            (%incf-ptr p $sym_size)
            (%put-long p $symbol-header)
            (%put-word p (logior (ash 1 $sym_vbit_const) (ash 1 $sym_vbit_special)) 4)
            (%put-long p (scanned-object.tagged-address (get-scanned-object (symbol-name nil))) 6)
            (%put-long p *nil-address* 10)
            (%put-long p (scanned-object.tagged-address (get-scanned-object *common-lisp-package*)) 14)
            (%put-word p $jsr_absl 18)
            (%put-long p (scanned-object.tagged-address (get-scanned-object %unbound-function%)) 20))
          (file-position *xdump-image-file* headerpos)
          (dotimes (i (record-length :dumpheader))
            (xdump-byte (%get-byte header i)))
          (file-position *xdump-image-file* 0)
          (xdump-long #xABBADABB)
          (xdump-word #xAD00)
          (xdump-long (- (rref header :dumpheader.d_vcells_end) (rref header :dumpheader.d_vcells_start)))
          (xdump-long (- (rref header :dumpheader.d_nrs_end) (rref header :dumpheader.d_fcells_start)))
          (xdump-long headerpos))))))
 
(defun global-value-of (symbol)
  (if (setq symbol (require-type symbol 'symbol))
    (lap-inline (symbol)
      (move.l arg_z atemp0)
      (btst ($ $sym_bit_indirect) (atemp0 $sym.vbits))
      (add ($ $sym.gvalue) atemp0)
      (if# ne (move.l @atemp0 atemp0))
      (move.l @atemp0 acc)
      (move.l (a5 $db_link) da)
      (until# eq
        (move.l da atemp1)
        (if# (eq (atemp1 4) atemp0)
          (move.l (atemp1 8) acc))
        (move.l @atemp1 da)))))

(defun dump-boot ()
  (xdump "ccl:boot"
         '(ccl cl keyword)
         `((*package* . ,*ccl-package*)
           (*interrupt-level* . -1)
           (%toplevel-catch . :toplevel)
           (%toplevel-function% . ,#'(lambda () (%fasload ":level-1.fasl")))
           (%pascal-functions%)
           (*all-metered-functions)
           (*%dynvfp%* . 0)
           (*%dynvlimit%* . 0)
           (%unbound-function% . ,%unbound-function%)
           (*foreground* . t)
           (*background-sleep-ticks*)
           (*foreground-sleep-ticks*)
           (*window-update-wptr*)
           (*gc-event-status-bits* . ,(logand (lognot 3) *gc-event-status-bits*))
           (*pre-gc-hook*)
           (*post-gc-hook*)
           (%handlers%)
           (%parse-string% . ,(make-string 255))
           (%all-packages% . ,(mapcar #'find-package '("CCL" "CL" "KEYWORD")))
           (*keyword-package* . ,(find-package "KEYWORD"))
           (%saved-method-var%)
           (%finalization-alist%)
           (*current-stack-group*))
         '%fasload '%%newhash '%%init-htab '%%hresize '%%ktrans-da-dbdy
         '%%getsym '%%gethashedsym '%%findsym '%%addsym '%%insertsym
         '%%Hadd '%%find-pkg 'pkg-arg))


(defmacro xdefun (name args &body body &environment env)
  (require-type name 'symbol)
  (multiple-value-bind (forms decls) (parse-body body env t)
    `(progn
       (setf (cdr (or (assq ',name *xdump-fcell-alist*) (car (push (cons ',name nil) *xdump-fcell-alist*))))
             (nfunction ,name (lambda ,args 
                                (declare (global-function-name ,name))
                                ,@decls (block ,name ,@forms ))))
       ',name)))

  
#|
(time
 (dump-boot)
)
|#
