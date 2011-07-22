;;;-*-Mode: LISP; Package: CCL -*-
;;;
;;; Fixes an MCL flaw that may cause fatal crashes on errors or breaks.
;;;
;;; Terje Norderhaug <terje@in-progress.com> 
;;;
;;; This software is made available AS IS, and no warranty is made about the software or its performance. 

(in-package :ccl)

(let ((*warn-if-redefine-kernel* NIL)
      (*warn-if-redefine* nil))

(defun frame-vsp (frame &optional parent-vsp sg)
  (declare (ignore parent-vsp sg))
  (check-type frame fixnum "Not a valid stack frame")
  (%frame-savevsp frame))

(defun lookup-registers (parent sg grand-parent srv-out)
  (unless (or (and grand-parent (eql (frame-vsp grand-parent) 0))              
              (let ((gg-parent (parent-frame grand-parent sg)))
                (and gg-parent (eql (frame-vsp gg-parent) 0))))
    (multiple-value-bind (lfun pc) (cfp-lfun parent sg nil)
      (when lfun
        (multiple-value-bind (mask where) (registers-used-by lfun pc)
          (when mask
            (locally (declare (fixnum mask))
              (if (not where) 
                (setf (srv.unresolved srv-out) (%ilogior (srv.unresolved srv-out) mask))
                (multiple-value-bind (parent-vsp grand-parent-vsp)(vsp-limits parent sg)
                  (cond ((eql parent-vsp grand-parent-vsp)  ;; does this ever happen?
                         (setf (srv.unresolved srv-out) (%ilogior (srv.unresolved srv-out) mask)))
                        (t 
                         (let ((vsp (- grand-parent-vsp where 1))
                               (j *saved-register-count*))
                           (declare (fixnum j))
                           (dotimes (i j)
                             (declare (fixnum i))
                             (when (%ilogbitp (decf j) mask)
                               (setf (srv.register-n srv-out i) vsp
                                     vsp (1- vsp)
                                     (srv.unresolved srv-out)
                                     (%ilogand (srv.unresolved srv-out) (%ilognot (%ilsl j 1))))))))))))))))))

(defun frame-supplied-args (frame lfun pc child sg)
  (declare (ignore child))
  (multiple-value-bind (req opt restp keys allow-other-keys optinit lexprp ncells nclosed)
                       (function-args lfun)
    (declare (ignore allow-other-keys lexprp ncells))
    (let* ((parent (parent-frame frame sg))
           (vsp (if parent (1- (frame-vsp parent))))
           (child-vsp (1- (frame-vsp frame)))
           (frame-size (if parent (- vsp child-vsp) 0))
           (res nil)
           (types nil)
           (names nil))
      (flet ((push-type&name (cellno)
               (multiple-value-bind (type name) (find-local-name cellno lfun pc)
                 (push type types)
                 (push name names))))
        (declare (dynamic-extent #'push-type&name))
        (if (or #-ppc-target (logbitp ccl::$lfatr-novpushed-args-bit (ccl::lfun-attributes lfun))
                (<= frame-size 0))
          ; Can't parse the frame, but all but the last 3 args are on the stack
          (let* ((nargs (+ nclosed req))
                 (vstack-args (max 0 (min frame-size (- nargs 3)))))
            (dotimes (i vstack-args)
              (declare (fixnum i))
              (push (access-lisp-data vsp) res)
              (push-type&name i)
              (decf vsp))
            (values (nreconc res (make-list (- nargs vstack-args)))
                    (nreverse types)
                    (nreverse names)
                    vstack-args
                    nclosed))
          ; All args were vpushed.
          (let* ((might-be-rest (> frame-size (+ req opt)))
                 (rest (and restp might-be-rest (access-lisp-data (- vsp req opt))))
                 (cellno -1))
            (declare (fixnum cellno))
            (when (and keys might-be-rest (null rest))
              (let ((vsp (- vsp req opt))
                    (keyvect (lfun-keyvect lfun))
                    (res nil))
                (dotimes (i keys)
                  (declare (fixnum i))
                  (when (access-lisp-data (1- vsp))   ; key-supplied-p
                    (push (aref keyvect i) res)
                    (push (access-lisp-data vsp) res))
                  (decf vsp 2))
                (setq rest (nreverse res))))
            (dotimes (i nclosed)
              (declare (fixnum i))
              (when (<= vsp child-vsp) (return))
              (push (access-lisp-data vsp) res)
              (push-type&name (incf cellno))
              (decf vsp))
            (dotimes (i req)
              (declare (fixnum i))
              (when (<= vsp child-vsp) (return))
              (push (access-lisp-data vsp) res)
              (push-type&name (incf cellno))
              (decf vsp))
            (if rest
              (dotimes (i opt)              ; all optionals were specified
                (declare (fixnum i))
                (when (<= vsp child-vsp) (return))
                (push (access-lisp-data vsp) res)
                (push-type&name (incf cellno))
                (decf vsp))
              (let ((offset (+ opt (if restp 1 0) (if keys (+ keys keys) 0)))
                    (optionals nil))
                (dotimes (i opt)            ; some optionals may have been omitted
                  (declare (fixnum i))
                  (when (<= vsp child-vsp) (return))
                  (let ((value (access-lisp-data vsp)))
                    (if optinit
                      (if (access-lisp-data (- vsp offset))
                        (progn
                          (push value optionals)
                          (push-type&name (incf cellno))
                          (return)))
                      (progn (push value optionals)
                             (push-type&name (incf cellno))))
                    (decf vsp)))
                (unless optinit
                  ; assume that null optionals were not passed.
                  (while (and optionals (null (car optionals)))
                    (pop optionals)
                    (pop types)
                    (pop names)))
                (setq rest (nreconc optionals rest))))
            (values (nreconc res rest) (nreverse types) (nreverse names)
                    t nclosed)))))))


(defun cfp-lfun (p stack-group &optional child)
  (declare (ignore stack-group child))
  (cond
   ((fake-stack-frame-p p)
    (let ((fn (%fake-stack-frame.fn p))
          (lr (%fake-stack-frame.lr p)))
      (when (and (functionp fn) (fixnump lr))
        (values fn (%fake-stack-frame.lr p)))))
   ((fixnump p)
    (without-interrupts                   ; Can't GC while we have lr in our hand
     (let ((fn (%frame-savefn p))
           (lr (%frame-savelr p)))
       (declare (fixnum lr))
       (when (functionp fn)
         (let* ((function-vector (%svref fn 0))
                (pc-words (- lr (the fixnum (%uvector-data-fixnum function-vector)))))
           (declare (fixnum pc-words))
           (when (and (>= pc-words 0) (< pc-words (uvsize function-vector)))
             (values fn
                     (the fixnum (ash pc-words ppc::fixnum-shift)))))))))
   (T (error "~s is not a valid stack frame" p))))

) ; end redefine

