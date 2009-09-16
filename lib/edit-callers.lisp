; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  14 10/3/96 akh  pascal-funtion-p that works in 3.1
;;  12 9/13/96 akh  fix callers-interp for closure
;;  10 7/30/96 akh  dont error for (setf non-symbol)
;;  9 7/26/96  akh  symbolp check before call macro-function
;;  8 7/18/96  akh   bind *function-parent-table* so 2 processes can do callers.
;;                       fix global-function-p for macros. DO global closures.
;;                  def-fred-command here
;;  6 2/23/96  akh  fix callers-interp for ppc
;;  3 10/17/95 akh  no mo lap
;;  2 10/10/95 akh  no lap for ppc
;;  (do not edit before this line!!)

;; akh dont call macro-function on non-symbol
; edit-callers.lisp
; Copyright 1992-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.



(in-package :ccl)

; (edit-callers function)
; pop's up a dialog allowing you to choose from the callers of FUNCTION.
; Uses %MAP-LFUNS which may cease to exist in a future version
; of MCL.

;;;;;;;;;;;;;;;;;;;;;;;;; edit history
;
; callers - get from %pascal-functions% with closures too
; ------ 5.2b6
; callers - don't add trap name to shared-library-entry-points if it ain't already there
; ----- 5.2b1
; callers knows about macho-entry-points
; ------ 5.1 final
; 09/19/03 add an update button to recompute the callers, also recompute if window was already there
;     callers works for traps e.g. #_foo
; -------- 5.0 final
; 03/14/99 akh   ed-edit-callers - if option-key, close previous window if any and recompute
; 09/12/96 bill  global-function-p changes from a macro to a function.
;  9/06/96 slh   top-level-caller uses new pascal-function-p (from AlanR)
;; akh bind *function-parent-table* so 2 processes can do callers.
; -------------  4.0b1
; -------------  3.9
; akh bind *function-parent-table* so 2 processes can do callers.
;;<end of added text>
;      fix global-function-p for macros. DO global closures.
; 03/01/96 gb    no swappable functions
; 01/03/96 gb    #+ppc-target %map-lfimms: uvsize of lfv, not function.
; use edit-definition-spec vs edit-definition to get dialog if no source file info
; downcase name in dialog, if already got it use it
; dialog has another button: "Callers", dialog is of class callers-dialog
;-------
; 04/06/93 bill  use a pool instead of a pre-gc-hook to make *function-parent-table* gc away
;                full-gccount -> l1-aprims.lisp
; -------------- 3.0d8
; 05/05/93 alice NO message-dialog
; -------------- 2.1d6
; 03/23/93 bill  (defvar *pre-gc-hook* ...) -> (setq *pre-gc-hook* ...)
; 12/11/92 bill  (format t ...) -> (message-dialog (format nil ...))
; -------------- 2.1d5
; 11/14/92 alice use edit-anything-dialog
; shortcomings 
; doesn't find things in plists, hash tables, action-function slots etc...
; but if there ain't no name it won't have source file info anyway (unless user does special stuff)
; 12/17/92 bill  update %%nth-immediate for new lfun vectors
; 06/22/92 alice make initial hash table big enuf for CCL at least
; 06/17/92 alice fix for no callers, somewhat faster, fix fix for duplicate methods
;  control-c and on tools menu, callers (setf ...) should work
; 06/16/92 alice fix for encapsulated things, weed out duplicate methods
; 06/15/92 alice ; extended alan ruttenberg's version to deal with swapped functions,
;		 interpreted functions, and copying gc

(def-fred-command (:control #\c) 'ed-edit-callers)
(def-fred-command (:control :meta #\c) 'ed-edit-callers)

(defmethod ed-edit-callers ((w fred-mixin) &optional pos)
  (let ((form (ignore-errors (ed-current-sexp w pos))))
    (cond ((not form)(edit-anything-dialog :callers))   ;(edit-callers-dialog))
          ((or (symbolp form)(and (consp form)(eq (car form) 'setf)(symbolp (cadr form))))
           (when (option-key-p)
             (let* ((window-title 
                     (let ((*print-case* :downcase))
                       (format nil "Callers of ~A" form)))
                    (w (find-window window-title 'callers-dialog)))
               (when  w (window-close w))))
           (edit-callers form))
          (t (ed-beep)))))

#|
(defparameter %edit-callers-string "")
(defvar *edit-callers-dialog* nil)

; we have 3 of these that are the same except for the names of the specials
; and the action
; maybe there should be just one that can choose among def, doc, callers

(defun edit-callers-dialog (&aux (initial-string %edit-callers-string))
  (let ((w (front-window)))
    (when (and w (typep w 'fred-window))
      (multiple-value-bind (b e)(selection-range w)
        (when (neq b e)
          (setq initial-string (buffer-substring (fred-buffer w) b e))))))
  (if (and *edit-callers-dialog*
           (wptr *edit-callers-dialog*))
    (let ((di (current-key-handler *edit-callers-dialog*)))
      (when di
        (set-dialog-item-text di initial-string)
        (setq %edit-callers-string initial-string)
        (set-selection-range di 0 (length initial-string)))
      (window-select *edit-callers-dialog*))                             
    (setq *edit-callers-dialog*
          (get-string-from-user
           "Enter the name of a symbol. The callers will be shown."
           :window-title "Edit Callers"
           :initial-string initial-string
           :modeless t
           :action-function
           #'(lambda (new-string)
               (let (sym)
                 (unless (equal new-string "")
                   (setq %edit-callers-string new-string)
                   (setq sym (read-from-string new-string)) ;might be a list like (setf boo)
                   (edit-callers sym))))))))

; in the right place?
(eval-when (:execute :load-toplevel)
  (let* ((menu *tools-menu*)
         (item (make-instance 'menu-item
                 :menu-item-title "Edit Callers…"
                 :menu-item-action #'(lambda () (edit-anything-dialog :callers))))
         (item-list (slot-value menu 'item-list))
         last)
    (apply #'remove-menu-items menu item-list)
    (when (not (dolist (i item-list)
                 (when (string= (slot-value i 'title) "Edit Callers…")
                   (return t))))
      (do ((l item-list (cdr l)))
          ((null l))
        ; we assume there is one and it isn't first
        (when (string= (slot-value (car l) 'title) "-")          
          (rplacd last (cons item l))
          (return))
        (setq last l)))
    (apply #'add-menu-items menu item-list)))

(defmacro loop-over-immediates ((var type function) &body body)
  `(let ((lfunv (%lfun-vector ,function)))
     (let ((nm (lfun-vector-name lfunv)))
       (dotimes (i (%count-immrefs lfunv))
         (declare (fixnum i))
         (let ((,var (%nth-immediate lfunv i)))
           (when (neq im nm)
           ,@body))))))
|#


(eval-when (:compile-toplevel :execute)
  (require :lapmacros)

  ; argument must be a variable
  (defmacro lfun-vector-attributes (lfunv)
    (if (ppc-target-p)
      0
    `(lap-inline () (:variable ,lfunv)
       (move.l (varg ,lfunv) atemp0)
       (move.w (atemp0 ($lfv_attrib)) acc)    
       (ext.l acc)
       (mkint acc))))

  ; arg is a variable
  (defmacro lfun-vector-bits (lfunv)
    (if (ppc-target-p)
      `(%svref ,lfunv (1- (uvsize ,lfunv)))
      `(lap-inline ()
         (:variable ,lfunv)
         (move.l (varg ,lfunv) atemp0)
         (move.w (atemp0 ($lfv_attrib)) db)
         (getvect atemp0 da)
         (add.l da atemp0)
         (if# (ne (btst ($ $lfatr-slfunv-bit) db))
           (sub.w ($ 4) atemp0))
         (move.l -@atemp0 acc)               
         (mkint acc))))
   
  
  )

(defun global-function-p (random &optional name)
  (let* ((thing random)
         (name (or name (function-name thing))))
    (and name
         (or (pascal-function-p thing) ;; << added
             (not (or (symbolp name)(and (consp name)(eq (car name) 'setf)))) ; maybe its (setf baz)
             (let ((fn  (fboundp name)))
               (and fn
                    (progn
                      #-ppc-target
                      (when (consp fn)(setq fn (car fn))) ; macro expanders!
                      ; maybe this is enough for both cases?
                      (or (eq thing fn)
                          (and (symbolp name)(eq thing (macro-function name))))))))
         name)))

(defvar *function-parent-table* nil)
(defvar *function-parent-pool* (%cons-pool))

(defun copying-gc-p () ; if nz copying gc is on
  #-ppc-target
  (neq 0 (lap-inline ()
           (move.l (a5 $Palt_dynamic_cons_area) acc)))
  #+ppc-target nil)

(defun lfun-closure-p (lfun)
  #+PPC-target
  (logbitp $lfbits-trampoline-bit (lfun-bits lfun))
  #-PPC-target
  (lap-inline () (:variable lfun)
              (move.l (varg lfun) atemp0)
              (move.w (atemp0 2) dy)
              (move.l nilreg acc)
              (if# (eq (cmp.w ($ $sp-funcall_cclosure) dy))
                (add.w ($ $t_val) acc))))

; make a macro ?
(defun puthash-parent (im fun)
  (when (functionp im) ; was (or (functionp im)(eq imtype $sym.fapply))
    (if (global-function-p fun)
      (setf (gethash im *function-parent-table*) fun)
      (let ((ht (gethash im *function-parent-table*)))
        (if (not ht)
          (setf (gethash im *function-parent-table*) fun)
          (unless (eq ht fun)
            (if (consp ht)
              (when (not (memq fun ht))(nconc ht (list fun)))
              (if (not (global-function-p ht))
                (setf (gethash im *function-parent-table*) (list ht fun))))))))))       

; all nil excludes swapped functions, default is include (can be very slow) (.739)
(defun callers (function &optional (all t) 
                         &aux cfun callers gccount retry loadp)
  ;(declare (special cfun function callers))
  (declare (optimize (speed 3)(safety 0)))

  (let ((*function-parent-table* nil))
  (if (and (symbolp function) (fboundp function))
    (setq cfun (symbol-function function)))
  (if (and (symbolp function)(eq (symbol-package function) (find-package :traps)))
    (progn ;(print 'cow)
           (let* ((trap-name (gethash function %trap-strings%))
                  (macho (if trap-name (gethash trap-name (macho-entry-points))))
                  (slep (if (and trap-name (not macho)) (car (gethash trap-name (shared-library-entry-points))))))
             (if macho (setq cfun macho)
             (when slep (setq cfun slep))))))
  (if (and (consp function)(eq (car function) 'setf))
    (let ((nm (cadr function)))
      (setq function  (or (%setf-method nm)
                          (and (symbolp nm)
                               (setq nm (setf-function-name nm))
                               (fboundp nm)
                               nm)
                          function))))  
  (when (copying-gc-p) (setq gccount (full-gccount)))
  (flet ((do-it (fun)
           ;(declare (special fun))
           (when (and gccount (neq gccount (full-gccount)))
             (throw 'losing :lost))
           (let ((lfunv (%lfun-vector fun loadp)))
             (when lfunv
               (let ((bits (lfun-vector-bits lfunv))) ;(lfun-bits fun)))
                 (declare (fixnum bits))
                 (unless (or (and (logbitp $lfbits-cm-bit bits)(not (logbitp $lfbits-method-bit bits)))  ; combined method
                             (and (logbitp $lfbits-trampoline-bit bits)(lfun-closure-p fun)
                                      (not (global-function-p fun))))   ; closure (interp or compiled)
                   (if (logbitp $lfbits-evaluated-bit bits)
                     (when (callers-interp fun function cfun)
                       (push fun callers))
                     (when #-ppc-target (or loadp  (not (logbitp  $lfatr-slfunv-bit (the fixnum (lfun-vector-attributes lfunv)))))
                           #+ppc-target t
                       (let* ((nm (lfun-vector-name lfunv))
                              (globalp (global-function-p fun nm)))
                         (flet ((do-imm (im)
                                  (when (and (or (eq function im)
                                                 (and cfun (eq cfun im)))
                                             (neq im nm))                             
                                    (push fun callers)) 
                                  (when (functionp im) ; was (or (functionp im)(eq imtype $sym.fapply))
                                    (if globalp
                                      (setf (gethash im *function-parent-table*) fun)
                                      (let ((ht (gethash im *function-parent-table*)))
                                        (if (not ht)
                                          (setf (gethash im *function-parent-table*) fun)
                                          (unless (eq ht fun)
                                            (if (consp ht)
                                              (when (not (memq fun ht))(nconc ht (list fun)))
                                              (if (not (global-function-p ht))
                                                (setf (gethash im *function-parent-table*) 
                                                      (list ht fun)))))))))))
                           (declare (dynamic-extent #'do-imm))                                
                           (%map-lfimms lfunv #'do-imm )))))))))))
    (declare (dynamic-extent #'do-it))
    (unwind-protect
      (progn
        (let* ((pool *function-parent-pool*)
               (tbl (pool.data pool)))
          (setf (pool.data pool) nil
                *function-parent-table*
                (if tbl
                  (clrhash tbl)
                  (make-hash-table :size 700 :test 'eq :weak :value))))
        (loop
          (cond ((eq :lost (catch 'losing      
                             (%map-lfuns #'do-it)))
                 (when retry (error "Callers is losing"))
                 (setq callers nil)
                 (setq retry t))
                (t (return))))
        (when all (setq loadp t)(map-swapped-lfuns #'do-it))                  
        ;(%map-static-lfuns #'do-it t)  ; there are only 4 of these - is it worth the trouble?
        ; Get rid of garbage methods - do we like this?
        ; what about generic flet?    
        (delete-if #'(lambda (thing)
                       (or (functionp thing)
                           (and (typep thing 'method)
                                (let ((gf (fboundp (method-name thing))))
                                  (not (and (typep gf 'standard-generic-function)
                                            (memq thing (%gf-methods gf))))))))
                   (delete-duplicates (mapcar 'top-level-caller callers))))
      (setf (pool.data *function-parent-pool*) *function-parent-table*
            *function-parent-table* nil)))))



(defun top-level-caller (function &optional the-list)
  (or (global-function-p function)
      ;(pascal-function-p function)  ;; global-function-p includes this now
      (let ((name (function-name function)))
        (and name (function-encapsulation name) name))
      (let ((caller function) next)
        (loop
          (setq next (gethash caller *function-parent-table*))
          (if  next           
            (cond ((consp next)
                   (when (null the-list)(push function the-list))
                   (return
                    (dolist (c next)
                      (when (not (memq c the-list))
                        (let ((res (top-level-caller c the-list)))
                          (when (and res (not (functionp res)))
                            (return res)))))))
                  (t (let ((res (global-function-p next)))
                       (when res (return res)))
                     (when (null the-list)(push function the-list))
                     (when (memq next the-list) (return))
                     (push next the-list)
                     (setq caller next)))
            (return caller))))
      function))

; in 3.x the function in pascal-functions calls the actual function
(defun pascal-function-p (function)
  (if (find function %pascal-functions%
            :test #'eq
            :key #'(lambda (elt)
                     (if (consp elt)
                       (let ((one (cdr elt)))
                         (when (and (eq (function-name one)(function-name function))
                                    (block blob
                                      (%map-lfimms (%lfun-vector one) #'(lambda (imm)
                                                                          (when (eq imm function)
                                                                            (return-from blob function))))))
                           function))
                       (if elt (aref elt 2)))))
    (function-name function)))

(defun edit-callers-print (thing &optional (stream t))
  (if (typep thing 'standard-method)
    (let ((qualifiers (method-qualifiers thing)))
      (format stream "<~s ~s ~s>" 
              (method-name thing)
              (case (length qualifiers)
                (0 :primary)
                (1 (car qualifiers))
                (t qualifiers))
              (uncanonicalize-specializers (method-specializers thing))))
    (format stream "~s" thing)))

(defclass callers-dialog (select-dialog)())  


(defun edit-callers (function &key
                              (include-swapped t)
                              (modelessp t)
                              (window-title 
                               (let ((*print-case* :downcase))
                                 (format nil "Callers of ~A" function)))
                              (default-button-text "Edit")
                              return-it
                              &aux w)
  (declare (dynamic-extent initargs))
  
  (if (and (not return-it)(setq w (find-window window-title 'callers-dialog)))
    (progn
      (let* ((table (find-subview-of-type w 'sequence-dialog-item))
             (callers (sort (callers function)  #'edit-definition-spec-lessp)))
        (set-table-sequence table callers))        
      (window-select w))
    (let ((callers (with-cursor *watch-cursor* (callers function include-swapped))))
      (setq callers (sort callers #'edit-definition-spec-lessp)) ; hmm sorts by specializers
      (if (not callers)
        (progn (format t "~&There are no callers of ~S." function)(ed-beep) nil)
        (if return-it
          callers
          (progn
            (setq w
                  (select-item-from-list
                   callers
                   :view-size #@(400 138)
                   :dialog-class 'callers-dialog
                   ;:view-position (edit-anything-result-pos 140)  ; was previously unspecified                         
                   :window-title window-title
                   :table-print-function #'edit-callers-print           
                   :modeless modelessp
                   :default-button-text default-button-text
                   :action-function
                   #'(lambda (list)
                       (if (option-key-p) (window-close w))
                       (edit-definition-spec (car list)))))
            (make-instance 'button-dialog-item
              :dialog-item-text "Callers"
              :view-position (let* ((p (view-position (default-button w))))
                               (make-point (- (point-h p) 74)(point-v p)))
              :dialog-item-action 
              #'(lambda (i)
                  (let* ((table (find-subview-of-type (view-window i) 'sequence-dialog-item))
                         (thing (selected-cell-contents table)))
                    (when thing                    
                      (edit-callers (if (typep thing 'method)(method-name thing) thing)))))
              :view-container w)
            (make-instance 'button-dialog-item
              :dialog-item-text "Update"
              :view-position (let* ((p (view-position (default-button w))))
                               (make-point (- (point-h p) 146)(point-v p)))
              :dialog-item-action 
              #'(lambda (i)
                  (let* ((table (find-subview-of-type (view-window i) 'sequence-dialog-item))
                         (callers (sort (callers function)  #'edit-definition-spec-lessp)))
                    (set-table-sequence table callers)))
              :view-container w)))))))
                  

#+PPC-target
(defun map-swapped-lfuns (function)
  (declare (ignore function)))

#-PPC-target
(defun map-swapped-lfuns (function)
  (setq function (coerce-to-function function))
  (let  ((p (%get-long (%currenta5) $slfuns_start))
         (q (%get-long (%currenta5) $slfuns_end)))
    (loop
      (when (eq p q)(return))        
      (funcall function (lap-inline (p) (jsr_subprim $sp-getulong)))
      (setq p (%i+ p 8)))))

#|
;Map function over all static lfuns
(defun %map-static-lfuns (function)
  (setq function (coerce-to-function function))
  (lap-inline ()
    (:variable function)
    (with-preserved-registers #(dsave0 asave0)
      (move.l (varg function 8) asave0)      
      (move.l (a5 $Pstatic_cons_area) atemp1)
      (move.l (atemp1 $cons-area.gspace-start) atemp0)
      (move.l (atemp1 $cons-area.gspace-end) dsave0)
      (prog#
       (move.l @atemp0 da)
       (if# (ne (cmp.b ($ $object-header) da))
         (add ($ 8) atemp0)
         elseif# (eq (cmp.w ($ $symbol-header) da))
         (lea (atemp0 $sym_size) atemp0)
         else#
         (if# (eq (cmp.w ($ $lfunv-header) da))
           (add.w ($ $t_vector) atemp0)
           (vpush atemp0)
           (move.l ($ (+ $v_data $t_lfun)) arg_z)
           (add.l atemp0 arg_z)
           (set_nargs 1)
           (jsr @asave0)
           (move.l (a5 $Pstatic_cons_area) atemp1) ; why
           (vpop atemp0)
           (sub.w ($ $t_vector) atemp0))
         (move.l ($ 15) da)
         (add.l (atemp0 (+ $t_vector $v_log)) da)
         (and.l ($ #x00FFFFF8) da)
         (add.l da atemp0))
       (until# (geu dsave0 atemp0)))))
  nil)
|#

(defun callers-interp (function target ctarget)
  (if (typep function 'interpreted-lexical-closure)
    (callers-interp (closure-function function) target ctarget)
    (let* ((lfunv (%lfun-vector function))
           (nimms (%count-immrefs lfunv))
           #-ppc-target
           (body (%nth-immediate lfunv 1 nimms)) ; might be 0 if $lfatr-noname-bit, or 2 if keys, or 3 if d.a.c.
           #+ppc-target
           (body (cddr (closure-def-expanded-form (evalenv-closure-def (%nth-immediate lfunv 0)))))
           calls-target)
      ; crock!!!!! - what is the right way to do this?
      (when (not (consp body))      
        (dotimes (i nimms)
          (let ((it (%nth-immediate lfunv i nimms)))
            (when (consp it)(setq body it)(return)))))
      (labels ((calls-in-progn (body)
                 (dolist (expr body)
                   (calls-in-expr expr)))
               (calls-in-expr (expr)
                 (when (consp expr)
                   (let ((car (car expr)))
                     (if (consp car)
                       (ecase (car car)
                         ; 34 special forms
                         ((block progn if tagbody progv locally unwind-protect
                                 multiple-value-list multiple-value-prog1
                                 without-interrupts)
                          (calls-in-progn (cdr expr)))
                         (catch (calls-in-progn (cddr expr)))
                         (multiple-value-call (calls-in-progn (cdr expr)))
                         ((the return-from throw) (calls-in-expr (third expr)))                       
                         ((%with-specials eval-when) (calls-in-progn (cddr expr)))
                         ((%local-ref %special-ref quote %special-declare go
                                      %closure-ref %special-bind))
                         (%local-fref
                          (puthash-parent (second car) function)
                          (calls-in-progn (cdr expr)))
                         (%init&bind (calls-in-expr (third expr)))
                         ((let let* compiler-let)
                          (let ((args (second expr)))
                            (dolist (a args)
                              (when (consp a) (calls-in-expr (second a))))
                            (calls-in-progn (cddr expr))))
                         ((flet labels macrolet symbol-macrolet)
                          (calls-in-progn (cddr expr)))
                         (setq
                          (do ((l (cdr expr)(cddr l)))
                              ((null l))
                            (calls-in-expr (second l))))
                         (function
                          (let ((fn (second expr)))
                            (if (symbolp fn)
                              (when (eq fn target)(setq calls-target t))
                              (progn
                                (when (eq target ctarget)(setq calls-target t))
                                (puthash-parent (second expr) function))))))
                       (case car
                         (%local-fref                        
                          (puthash-parent (second expr) function))
                         (quote)
                         (t
                          (when (eq car target)
                            (setq calls-target t))
                          (calls-in-progn (cdr expr)))))))))
        (calls-in-progn body)
        calls-target))))

; Calls function f with args (imm) on each immediate in lfv.
#+PPC-target
(defun %map-lfimms (lfv f)
  (let* ((n (- (uvsize lfv) 2)))
    (declare (fixnum n))
    (dotimes (i n)
      (funcall f (%svref lfv (%i+ 1 i))))))
         
    
#-PPC-target
(defun %map-lfimms (lfv f)
  (lap-inline (lfv f)
    (with-preserved-registers #(asave0 asave1 dsave0 dsave1 dsave2)
      (move.l arg_y asave0) ; vect
      (move.l arg_z asave1) ; fun
      (vsize asave0 dsave0)
      (lea (asave0 ($lfv_attrib)) atemp0)
      (move.w (atemp0) dx)
      (if# (ne (btst ($ $lfatr-immmap-bit) dx))
        (if# (ne (btst ($ $lfatr-slfunv-bit) dx))
          (sub.l ($ 4) dsave0))
        (moveq 0 dsave1)
        (moveq '0 dsave2)
        (until# (eq (progn (moveq 0 acc)
                           (lea (asave0 dsave0.l (- $v_data 4)) atemp1)
                           (sub.l ($ 1) dsave0)
                           (move.b -@atemp1 acc)))
                (if# (cs (add.b acc acc))
                  (ror.w ($ 8) acc)
                  (move.b -@atemp1 acc)
                  (sub.l ($ 1) dsave0)
                  (ror.w ($ 8) acc))
                (add.l acc dsave1)
                (moveq 0 arg_z)
                (move.l (asave0 dsave1.l $lfv_lfun) arg_y)
                (if# (ne (dtagp arg_y $t_symbol))
                  (move.l arg_y atemp0)
                  (if# (ne (tst.w -@atemp0))
                    (add.w ($ 8) arg_z)
                    (sub.w ($ 8) atemp0)
                    (if# (ne (tst.w @atemp0))
                      (add.w ($ 8) arg_z))))
                (sub.l arg_z arg_y)
                ;(mkint arg_z)
                (mkint dsave0)
                (mkint dsave1)
                (move.l arg_y arg_z)
                (add.l '1 dsave2)
                (set_nargs 1)
                (jsr @asave1)
                (getint dsave1)
                (getint dsave0)))))
  nil)

(provide :edit-callers)

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
