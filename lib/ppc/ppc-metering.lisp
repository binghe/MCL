;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 5/20/96  akh  fix for samples exceed buckets
;;  1 4/17/96  akh  New file from gb
;;  (do not edit before this line!!)

#|
The externally-visible call is:

(ccl::meter form &key (buckets 5000) (interval 10))

:interval specifies the period - in milliseconds - of the pc sampling task.

:buckets specifies the size of the data structure used to hold the sampled
information.  The default values would thus hold 5000 sampled values sampled
at 10 millisecond intervals, or 50 seconds worth of information.  The
"buckets" data structure gets treated as a circular buffer: newer entries
overwrite old.

When metering is active, a Time Manager task crawls up the stack and tries
to identify the lisp function or subprimitive that was interrupted.  Sometimes
it's unable to do so; the misses are reported as "bogus subprims".

Metering adds some overhead (probably greater the shorter the interval);
a metered form will generally take longer than it would otherwise, but
the relative times reported should be pretty accurate.

As written, any compilation necessary to evaluate the form will be reported
as well; but the compiler's pretty quick.
|#

(in-package "CCL")

(declaim (special *all-metered-functions*))

; This assumes that the first word in any readonly-area
; is a code-vector header for the subprims code that follows.
(defppclapfunction %area-subprims-length  ((a arg_z))
  (lwz imm0 ppc::area.low a)
  (lwz imm0 0 imm0)
  (header-length arg_z imm0)
  (blr))

(defun %find-subprims-ranges ()
  (let* ((alist nil)
         (nwords 0))
    (do-consing-areas (a)
      (when (eql (%fixnum-ref a ppc::area.code) ppc::area-readonly)
        (setq nwords (1- (%area-subprims-length a)))
        (let* ((start (%fixnum-ref a ppc::area.low)))
          (push (cons (+ start 2) (+ start 2 nwords)) alist))))
    (let* ((dyn (%get-kernel-global 'subprims-base)))
      (cons (cons dyn (+ dyn nwords)) alist))))

(defloadvar *subprims-ranges* (%find-subprims-ranges))

(defun %init-subprims-buckets (n)
  (let* ((v (make-array n))
         (jtab (%get-kernel-global 'subprims-base)))
    ; Relative branch instructions in the subprims jump table look like fixnums
    (dotimes (i n)
      (setf (svref v i) (cons (+ i (ldb (byte 16 0) (%lisp-word-ref jtab i))) i)))
    (sort v #'< :key #'car)
    v))

(defparameter *num-metered-subprims* (length *ppc-subprims*))

(defloadvar *meter-subprims-buckets* (%init-subprims-buckets *num-metered-subprims*))


(defrecord metering-info
  (depth :long)
  (total-hits :long)
  (lisp-hits :long)
  (nbuckets :long)
  (interval :long))

(defppclapfunction %metering-info ((ptr arg_z))
  (ref-global imm0 metering-info)
  (stw imm0 ppc::macptr.address ptr)
  (blr))

(defun %enable-metering (nbuckets interval)
  (progn (setq *all-metered-functions* (make-array nbuckets))
         (zerop (the fixnum (ppc-ff-call (%kernel-import ppc::kernel-import-metering-control)
                                         :signed-fullword interval
                                         :signed-fullword)))))
(defun %disable-metering ()
  (zerop (the fixnum (ppc-ff-call (%kernel-import ppc::kernel-import-metering-control)
                                    :signed-fullword 0
                                    :signed-fullword))))

(defun meter-subprim-index (i)
  (if (< i *num-metered-subprims*)      ; jump table entry
    i                                   ; blame the target subprim
    (or (cdr (find i *meter-subprims-buckets* :key #'car :test #'>= :from-end t))
        -1)))

(defun normalize-metered-subprims (v n)
  (declare (fixnum n) (simple-vector v))
  (let* ((ranges *subprims-ranges*)
         (bad 0))
    (declare (fixnum bad))
    (dotimes (i (min n (uvsize v)) bad)
      (let* ((e (svref v i)))
        (when (typep e 'fixnum)
          (setf (svref v i)
                (dolist (pair ranges (progn (incf bad) -1))
                  (declare (cons pair))
                  (when (and (>= e (car pair))
                             (< e (cdr pair)))
                    (return (meter-subprim-index (- e (car pair))))))))))))

(defun meter-extract-subprims (v n)
  (declare (fixnum n) (simple-vector v))
  (let* ((alist nil))
    (dotimes (i (min n (uvsize v))  (sort alist #'> :key #'cdr))
      (let* ((e (svref v i)))
        (when (and (typep e 'fixnum) (>= e 0))
          (let* ((cell (assoc e alist :test #'eq)))
              (if cell
                (incf (cdr cell))
                (push (cons e 1) alist))))))))

(defun report-metering (form results)
  (let* ((n (length results))
         (s *debug-io*))
    (declare (fixnum n))
    (format s "~&~s returned ~d value~p:" form n n)
    (if (= n 1)
      (format s " ~s" (car results))
      (dotimes (i n)
        (format s "~&~d: ~s" i (pop results))))
    (let* ((v *all-metered-functions*)
           (nsubps 0)
           (alist ())
           (info (%metering-info (%null-ptr)))
           (totallisp (pref info :metering-info.lisp-hits))
           (total (pref info :metering-info.total-hits))
           (recorded (min totallisp (length v))))
      (dotimes (i recorded)
        (let* ((e (svref v i)))
          (if (fixnump e)
            (incf nsubps)
            (let* ((cell (assoc e alist :test #'eq)))
              (if cell
                (incf (cdr cell))
                (push (cons e 1) alist))))))
      (setq alist (sort alist #'> :key #'cdr))
      (format s "~& ~d total hits, ~d total lisp hits, " total totallisp)
      (format s "~d total recorded hits: ~& ~d hits in subprims" recorded nsubps)
      (format s " (of which ~d are bogus)" (normalize-metered-subprims v totallisp))
      (let* ((sp-alist (meter-extract-subprims v totallisp)))
        (format s "~&~% subprims hits:")
        (dolist (pair sp-alist) (format s "~& ~d : ~a" 
                                        (cdr pair) 
                                        (ppc-subprimitive-info-name (svref *ppc-subprims* (car pair))))))
      (format s "~&~% Lisp function hits:")
      (dolist (cell alist) (format s "~& ~d : ~s" (cdr cell) (car cell))))))

(defmacro meter (form &key (buckets 5000) (interval 10))
  `(report-metering ',form 
                    (multiple-value-list (unwind-protect
                                           (progn
                                             (%enable-metering ,buckets ,interval)
                                             ,form)
                                           (%disable-metering)))))




