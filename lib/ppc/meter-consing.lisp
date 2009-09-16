;;;-*- Mode: Lisp; Package: CCL -*-

(in-package "CCL")

(defun analyze-objects (f)
  (let* ((nconses 0)
         (imm-totals (make-array 32 :initial-element 0))
         (imm-sizes (make-array 32 :initial-element 0))
         (node-totals (make-array 32 :initial-element 0))
         (node-sizes (make-array 32 :initial-element 0)))
    (flet ((classify-object (o)
             (if (consp o)
               (incf nconses)
               (let* ((typecode (ppc-typecode o))
                      (typecode-tag (logand typecode ppc::fulltagmask))
                      (node-p (= typecode-tag ppc::fulltag-nodeheader))
                      (totals (if node-p node-totals imm-totals))
                      (sizes (if node-p node-sizes imm-sizes)))
                 (declare (fixnum typecode typecode-tag))
                 (if (or node-p (= typecode-tag ppc::fulltag-immheader))
                   (let* ((idx (ash typecode (- ppc::ntagbits)))
                          (size (uvsize o))
                          (logsize  (if node-p
                                      (ash size 2)
                                      (ppc-subtag-bytes typecode size)))
                          (physsize (logand (lognot 7)
                                            (the fixnum (+ logsize (+ 4 7))))))
                     (declare (fixnum idx size logsize physsize))
                     (incf (svref totals idx))
                     (incf (svref sizes idx) physsize))
                   (warn "~& strange object in heap at #x~x" (%address-of o)))))))
      (declare (dynamic-extent classify-object))
      (funcall f #'classify-object)
      (values nconses imm-totals imm-sizes node-totals node-sizes))))

(defun analyze-heap (maxcode mincode)
  (flet ((mapper (f) (%map-areas f maxcode mincode)))
    (declare (dynamic-extent mapper))
    (analyze-objects #'mapper)))

(defparameter *immheader-type-names*
  #(bignum
    short-float
    double-float
    macptr
    dead-macptr
    code-vector
    nil                                 ; 6
    nil
    nil
    nil
    nil
    nil                                 ; 11
    nil
    nil
    nil
    nil
    nil
    nil
    nil
    nil
    nil
    short-float-vector                 ; 21
    u32-vector
    s32-vector
    u8-vector
    s8-vector
    simple-base-string
    simple-general-string
    u16-vector
    s16-vector
    double-float-vector
    bit-vector))

(defparameter *nodeheader-type-names*
  #(nil                                 ; 0
    ratio
    nil
    complex
    catch-frame
    function
    sgbuf
    symbol
    lock
    hash-vector
    pool
    weak
    package
    mark
    instance
    struct
    istruct
    value-cell                          ; 17
    nil
    nil
    array-header
    vector-header
    simple-vector                       ; 22
    nil
    nil
    nil
    nil
    nil
    nil
    nil
    nil
    nil                                 ; 31
    ))

(defun summarize-heap (verbose nconses immtotals immsizes nodetotals nodesizes)
  (when (or verbose (not (zerop nconses)))
    (format t "~&Cons cells~32t: ~8,' d~44t~8,' d" nconses (ash nconses 3)))
  (flet ((summarize-type (names totals sizes tag)
           (dotimes (i 32)
             (let* ((name (svref names i))
                    (total (svref totals i)))           
               (when (or (and verbose name) (not (zerop total)))
                 (format t "~&~s (#x~x) ~32t: ~8,' d~44t~8,' d"
                         name
                         (logior (ash i ppc::ntagbits) tag)
                         total
                         (svref sizes i)))))
           (format t "~&  Total~32t: ~8,' d~44t~8,' d"
                   (reduce #'+ totals)
                   (reduce #'+ sizes))))
    (format t "~%~%Immediate objects")
    (summarize-type *immheader-type-names* immtotals immsizes ppc::fulltag-immheader)
    (format t "~%~%Node objects")
    (summarize-type *nodeheader-type-names* nodetotals nodesizes ppc::fulltag-nodeheader)))

(defun %summarize-areas (maxcode mincode)
  (multiple-value-call #'summarize-heap t (analyze-heap maxcode mincode)))

(defun summarize-static-areas ()
  (%summarize-areas ppc::area-static ppc::area-staticlib))

(defun summarize-readonly-areas ()
  (%summarize-areas ppc::area-readonly ppc::area-readonly))

(defun summarize-dynamic-areas ()
  (%summarize-areas ppc::area-dynamic ppc::area-dynamic))

(defun summarize-all-areas ()
  (%summarize-areas ppc::area-dynamic ppc::area-readonly))


(defun object-size-in-bytes (o)
  (if (consp o)
    8
    (let* ((typecode (ppc-typecode o))
           (typecode-tag (logand typecode ppc::fulltagmask))
           (logsize (if (= typecode-tag ppc::fulltag-nodeheader) 
                      (ash (the fixnum (uvsize o)) 2)
                      (if (= typecode-tag ppc::fulltag-immheader)
                        (ppc-subtag-bytes typecode (uvsize o))
                        0))))
      (declare (fixnum typecode typecode-tag logsize))
      (logand (lognot 7) (the fixnum (+ logsize (+ 4 7)))))))
      
      
(defppclapfunction next-object-in-heap ((o arg_y) (osize arg_z))
  (clrrwi initptr o ppc::ntagbits)
  (unbox-fixnum imm0 osize)
  (add initptr initptr imm0)
  (lwz imm0 0 initptr)
  (clrlwi imm0 imm0 (- 32 ppc::ntagbits))
  (cmpwi cr0 imm0 ppc::fulltag-immheader)
  (cmpwi cr1 imm0 ppc::fulltag-nodeheader)
  (li imm0 ppc::fulltag-misc)
  (beq cr0 @misc)
  (beq cr1 @misc)
  (li imm0 ppc::fulltag-cons)
  @misc
  (add arg_z initptr imm0)
  (mr initptr freeptr)
  (blr))

(defun next-object-after (o)
  (next-object-in-heap o (object-size-in-bytes o)))

(defun %map-range (f first last)
  (do* ((prev first next)
        (next (next-object-after first) (next-object-after next)))
       ((eq next last))
    (if (bogus-thing-p next) (dbg prev))
    (funcall f next)))

(defun analyze-range (first last)
  (flet ((mapper (f) (%map-range f first last)))
    (declare (dynamic-extent mapper))
    (analyze-objects #'mapper)))

(defun %summarize-range (first last)
  (multiple-value-call #'summarize-heap nil (analyze-range first last)))

(defvar *start-tba* nil)
(defvar *start-gccount* nil)
(defvar *start-mark* nil)

(defun %start-meter-consing ()
  (setq *start-tba* (total-bytes-allocated))
  (setq *start-gccount* (gccounts))
  (setq *start-mark* (cons nil nil)))

(defun %report-consing-so-far ()
  (let ((end-mark (cons nil nil))
        (end-gccount (gccounts))
        (end-tba (- (total-bytes-allocated) 8)))
    (format t "~%~% ~d total bytes allocated, ~d GC invocations.~%~%" 
            (- end-tba *start-tba*) (- end-gccount *start-gccount*))
     (%summarize-range *start-mark* end-mark)))
  
  

(defun %report-consing (form thunk)
  (let* ((start-tba (total-bytes-allocated))
         (start-gccount (gccounts))
         (start-mark (cons nil nil))
         (results (multiple-value-list (funcall thunk)))
         (end-mark (cons nil nil))
         (end-gccount (gccounts))
         (end-tba (- (total-bytes-allocated) 16)) ; account for start-mark/end-mark
         (nresults (length results)))
    (declare (dynamic-extent results))
    (format t "~& ~s returned ~d value~p: " form nresults nresults)
    (if (= nresults 1)
      (format t "~s" (car results))
      (dolist (r results) (format t "~&~s" r)))
    (format t "~%~% ~d total bytes allocated, ~d GC invocations.~%~%" 
            (- end-tba start-tba) (- end-gccount start-gccount))
    (%summarize-range start-mark end-mark)))

(defmacro meter-consing (form)
  `(%report-consing ',form #'(lambda () ,form)))

#|
(defun foo (x n)
  (dotimes (i n x) (push nil x)))

(meter-consing (foo nil 20))
|#



   
  
