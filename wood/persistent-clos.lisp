;;;-*- Mode: Lisp; Package: (WOOD) -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; persistent-clos.lisp
;; Support for saving/restoring CLOS instances to/from Wood persistent heaps.
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
;; fix dc-shared-initialize for slots being list not vector
;; add p-make-instance from Terje N. with fixes so will compile in 5.1b2
;; --------- 5.1b2
;; MOP changes - now it compiles - who knows if it's right? usage of (%unbound-marker) ?? 
;; ------------ 5.1b1
;; 08/28/98 akh add dc-shared-initialize - fixes case of change class in memory, then write a slot-value to pheap
;;                left us with the class updated on disk but not the instance-slots with initforms
;; -------------  0.96
;; -------------  0.95
;; -------------  0.94
;; -------------  0.93
;; -------------  0.9
;; 11/02/94 bill  (method %p-store-object (t standard-object t)) no longer
;;                handles p-make-load-function-using-pheap. It has moved
;;                into %p-store-internal now.
;; 10/28/94 Moon  Change without-interrupts to with-databases-locked
;; 10/25/94 bill  p-load-instance calls wood-disk-resident-slot-names,
;;                a new GF that users can specialize.
;;                define-disk-resident-slot-names macro to aid generation
;;                of wood-disk-resident-slot-names methods and accessor
;;                methods that will swap disk resident slots in when
;;                necessary.
;; 09/21/94 bill  without-interrupts as necessary for interlocking
;; -------------- 0.8
;; 10/25/93 bill  initialize-persistent-instance
;; -------------- 0.6
;; 02/16/93 bill  p-load-instance now calls shared-initialize to initialize
;;                any new slots (slots that have been added since the instance
;;                was saved to the pheap file).
;; 11/16/92 bill  pheap-class-hash, p-class-instance-slot-names
;; 11/09/92 bill  Make it work correctly to create two instances, p-store them,
;;                redefine the class adding a slot, p-store the first instance,
;;                close and reopen the pheap, then p-load the second instance.
;;                chung@ils.nwu.edu found that this used to result in an instance all
;;                of whose slots were unbound.
;; 08/27/92 bill  in %p-store-object: call p-make-load-function
;; 08/13/92 bill  (setf p-slot-value) now does the right thing if instance
;;                is not a PPTR.
;; -------------- 0.5
;; 06/23/92 bill  New file
;;

(in-package :wood)

(defun pheap-class-hash (pheap)
  (let ((hash (dc-class-hash (pheap-disk-cache pheap))))
    (when hash
      (pptr pheap hash))))

(defun dc-class-hash (disk-cache &optional create?)
  (with-databases-locked
   (let ((res (dc-%svref disk-cache $root-vector $pheap.class-hash)))
     (if (eql res $pheap-nil)
       (if create?
         (setf (dc-%svref disk-cache $root-vector $pheap.class-hash)
               (dc-make-hash-table disk-cache)))
       res))))

(defun p-find-class (pheap name &optional (errorp t))
  (multiple-value-bind (pointer imm?) (%p-store-hash-key pheap name)
    (when pointer
      (let ((res (dc-find-class (pheap-disk-cache pheap) pointer imm? errorp)))
        (when res (pptr pheap res))))))

(defun dc-find-class (disk-cache pointer immediate? &optional (errorp t))
  (let ((hash (dc-class-hash disk-cache)))
    (or (and hash
             (dc-gethash disk-cache pointer immediate? hash))
        (when errorp
          (error "Class named ~s not found." 
                 (dc-pointer-load disk-cache pointer immediate?))))))

; Will overwrite an existing class
(defun p-make-class (pheap name slots)
  (unless (and (vectorp slots) (every 'symbolp slots))
    (error "~s is not a vector of slot names"))
  (multiple-value-bind (pointer imm?) (%p-store pheap name)
    (pptr pheap
          (dc-make-class (pheap-disk-cache pheap)
                         pointer
                         (%p-store pheap slots)
                         imm?
                         slots
                         pheap))))

(defun dc-make-class (disk-cache name slots &optional name-imm? slots-object pheap)
  (let* ((class (dc-make-uvector disk-cache $class-size $v_class))
         (hash (dc-class-hash disk-cache t))
         (wrapper (dc-make-class-wrapper disk-cache class slots slots-object pheap)))
    (dc-%svfill disk-cache class
      ($class.name name-imm?) name
      $class.own-wrapper wrapper)
    (dc-puthash disk-cache name name-imm? hash class)))

(defun dc-make-class-wrapper (disk-cache class slots &optional slots-object pheap)
  (let ((wrapper (dc-make-vector disk-cache $wrapper-size)))
    (dc-%svfill disk-cache wrapper
      $wrapper.class class
      $wrapper.slots slots)
    (when slots-object
      (setf (gethash slots-object
                     (wrapper-hash (or pheap (disk-cache-pheap disk-cache))))
            wrapper))
    wrapper))

; Access a (disk) class'es wrapper. Update it to agree with the
; class in memory, if there is one.
; Returns 2 value:
; 1) the (possibly new) wrapper
; 2) the in-memory class, or NIL if there isn't one.
; 3) the vector of slot names for the in-memory class, or NIL
; 4) true if the class'es was obsolete.
(defun dc-update-class-wrapper (disk-cache class &optional pheap memory-class dont-update)
  (unless pheap (setq pheap (disk-cache-pheap disk-cache)))
  (if (eq memory-class :none)
    (setq memory-class nil)
    (let* ((name (pointer-load pheap (dc-%svref disk-cache class $class.name) :default disk-cache)))
      (setq memory-class (find-class name nil))))
  (with-databases-locked
   (let ((wrapper (dc-%svref disk-cache class $class.own-wrapper))
         (obsolete? nil)
         slot-names)
     (when memory-class
       (let ((wrapper-hash (wrapper-hash pheap)))
         (setq slot-names (wood-slot-names-vector (class-prototype memory-class)))            
         (unless (eql wrapper (gethash slot-names wrapper-hash))
           (let ((old-slot-names (pointer-load pheap (dc-%svref disk-cache wrapper $wrapper.slots)
                                               :default disk-cache)))
             (if (equalp old-slot-names slot-names)
               (setf (gethash slot-names wrapper-hash) wrapper)
               (progn
                 (setq obsolete? t)
                 (unless dont-update
                   (setf wrapper (dc-make-class-wrapper
                                  disk-cache class
                                  (%p-store pheap slot-names) slot-names pheap)
                         (dc-%svref disk-cache class $class.own-wrapper) wrapper))))))))
     (values wrapper memory-class slot-names obsolete?))))


; This knows internals of MCL's CLOS implementation - tant pis
;; dunno ??
(defun class-slots-vector (class)
  (unless (ccl::class-finalized-p class)
    (ccl::finalize-inheritance class))
  (ccl::%wrapper-instance-slots (ccl::class-own-wrapper class)))

(defun dc-make-class-slots-vector (disk-cache class &optional
                                              (pheap (disk-cache-pheap disk-cache)))
  (%p-store pheap (wood-slot-names-vector (class-prototype class))))

(def-predicate ccl::classp (p disk-cache pointer)
  (dc-vector-subtype-p disk-cache pointer $v_class))

(def-accessor class-name (p) (disk-cache pointer)
  (require-satisfies dc-classp disk-cache pointer)
  (dc-%svref disk-cache pointer $class.name))

(defun (setf dc-class-name) (value disk-cache class &optional value-imm?)
  (require-satisfies dc-classp disk-cache class)
  (setf (dc-%svref disk-cache class $class.name value-imm?) value)
  (values value value-imm?))

#|
(def-accessor class-own-wrapper (p) (disk-cache pointer)
  (require-satisfies dc-classp disk-cache pointer)
  (dc-%svref disk-cache pointer $class.own-wrapper))
|#

;; ?? - shouldn't that be exported?? used to be, class-name is exported
(def-accessor ccl::class-own-wrapper (p) (disk-cache pointer)
  (require-satisfies dc-classp disk-cache pointer)
  (dc-%svref disk-cache pointer $class.own-wrapper))



(defun (setf dc-class-own-wrapper) (value disk-cache class &optional value-imm?)
  (require-satisfies dc-classp disk-cache class)
  (setf (dc-%svref disk-cache class $class.own-wrapper value-imm?) value)
  (values value value-imm?))

(defmacro dc-wrapper-class (disk-cache wrapper)
  `(dc-uvref ,disk-cache ,wrapper $wrapper.class))

(defmacro dc-wrapper-slots (disk-cache wrapper)
  `(dc-uvref ,disk-cache ,wrapper $wrapper.slots))

(def-accessor class-instance-slot-names (p) (disk-cache pointer)
  (require-satisfies dc-classp disk-cache pointer)
  (dc-wrapper-slots disk-cache (dc-class-own-wrapper disk-cache pointer)))

;; ?? replace class-own-wrapper
(defun class-instance-slot-names (class)
  (let ((wrapper (ccl::class-own-wrapper class)))
    (unless wrapper
      (class-prototype class)
      (setq wrapper (ccl::class-own-wrapper class))
      (unless wrapper (error "Can't find class-own-wrapper for ~s" class)))
    (ccl::%wrapper-instance-slots wrapper)))

(defun p-instance-class (instance)
  (if (pptr-p instance)
    (let* ((pheap (pptr-pheap instance))
           (disk-cache (pheap-disk-cache pheap))
           (pointer (pptr-pointer instance)))
      (pointer-load
       pheap
       (dc-wrapper-class disk-cache (dc-instance-class-wrapper disk-cache pointer))))
    (class-of instance)))

(defmethod %p-store-object (pheap (object standard-class) descend)
  (let* ((disk-cache (pheap-disk-cache pheap))
         (descend (eq descend t))
         name imm?
         (address (maybe-cached-address pheap object
                    (multiple-value-setq (name imm?)
                      (%p-store pheap (class-name object)))
                    (or (dc-find-class disk-cache name imm? nil)
                        (progn
                          (setq descend nil)
                          (dc-make-class disk-cache
                                         name
                                         (dc-make-class-slots-vector
                                          disk-cache object pheap)
                                         imm?))))))
    (when descend
      (unless name
        (multiple-value-setq (name imm?) (%p-store pheap (class-name object))))
      (setf (dc-class-name disk-cache address imm?) name)
      (setf (dc-wrapper-slots disk-cache (dc-class-own-wrapper disk-cache address))
            (dc-make-class-slots-vector disk-cache object pheap)))
    address))

(defun p-load-class (pheap disk-cache pointer depth subtype)
  (declare (ignore depth subtype))
  (maybe-cached-value pheap pointer
    (multiple-value-bind (name-pointer imm?) (dc-class-name disk-cache pointer)
      (let ((name (dc-pointer-load disk-cache name-pointer imm? pheap)))
        (or (find-class name nil)
            (let ((slots (pointer-load pheap
                                       (dc-wrapper-slots
                                        disk-cache
                                        (dc-class-own-wrapper disk-cache pointer))
                                       :default
                                       disk-cache)))
              ;; this is wrong - lose initargs, initforms
              (eval `(defclass ,name () ,(coerce slots 'list)))))))))    

(defmethod p-allocate-instance (pheap (class symbol))
  (p-allocate-instance pheap (or (p-find-class pheap class nil)
                                 (p-store pheap (find-class class)))))

(defmethod p-allocate-instance (pheap (class standard-class))
  (p-%allocate-instance pheap (p-store pheap class) class))

(defmethod p-allocate-instance (pheap (class pptr))
  (require-satisfies p-classp class)
  (p-%allocate-instance pheap class nil))

(defun p-%allocate-instance (pheap class memory-class)
  (pptr pheap (dc-%allocate-instance (pheap-disk-cache pheap) (pptr-pointer class) memory-class)))

(defun dc-%allocate-instance (disk-cache class &optional memory-class)
  (let* ((wrapper (dc-update-class-wrapper disk-cache class nil memory-class))
         (slots (dc-make-vector
                 disk-cache
                 (dc-length disk-cache (dc-wrapper-slots disk-cache wrapper))
                 nil (%unbound-marker) t))
         (res (dc-make-uvector disk-cache $instance-size $v_instance)))
    (dc-%svfill disk-cache res
      $instance.wrapper wrapper
      $instance.slots slots)
    res))

(def-predicate ccl::standard-instance-p (p disk-cache pointer)
  (dc-vector-subtype-p disk-cache pointer $v_instance))

(def-accessor ccl::instance-class-wrapper (p) (disk-cache pointer)
  (require-satisfies dc-standard-instance-p disk-cache pointer)
  (dc-%svref disk-cache pointer $instance.wrapper))

; This is the wrong name. Check the MOP
(def-accessor instance-access (p index) (disk-cache pointer)
  (require-satisfies dc-standard-instance-p disk-cache pointer)
  (dc-uvref disk-cache (dc-%svref disk-cache pointer $instance.slots) index))

(defun (setf p-instance-access) (value p index)
  (setq index (require-type index 'fixnum))
  (if (pptr-p p)
    (let ((pheap (pptr-pheap p)))
      (multiple-value-bind (v imm?) (%p-store pheap value)
        (setf (dc-instance-access
               (pheap-disk-cache pheap) (pptr-pointer p) index imm?)
              v)
        (if imm? v (pptr pheap v))))
    (error "~s is defined only for Wood instances" '(setf p-instance-access))))

(defun (setf dc-instance-access) (value disk-cache pointer index value-imm?)
  (require-satisfies dc-standard-instance-p disk-cache pointer)
  (setf (dc-uvref disk-cache (dc-%svref disk-cache pointer $instance.slots)
                  index value-imm?)
        value))

(defun instance-access (thing index)
  (declare (ignore thing index))
  (error "~s is defined only for Wood instances" 'instance-access))

; Instance is an on-disk address.
; class is an in-memory class or NIL.
; Returns three values:
; 1) The slots vector on disk
; 2) The slot names vector in memory.
; 3) slot-names vector if the instance was obsolete.
;    This will be different from the second value if the
;    dont-update arg is true.
;
; This is hairy because it has to deal with a lot of possibilities:
;
; 1) Class exists in memory, but hasn't been associated with PHEAP yet.
; 2) Class exists in memeory and has been associated with PHEAP.
; 3) Class does not exist in memory.
; 4) 1 or 2 and the class has been redefined since the instance was stored in the PHEAP.
(defun dc-updated-instance-slots (disk-cache instance memory-class pheap &optional
                                             dont-update)
  (with-databases-locked
   (let ((old-wrapper (dc-%svref disk-cache instance $instance.wrapper))
         (instance-slots (dc-%svref disk-cache instance $instance.slots))
         class wrapper slot-names old-slot-names obsolete?)
     (if memory-class
       (progn
         (setq slot-names (wood-slot-names-vector (class-prototype memory-class)))
         (setq wrapper (gethash slot-names (wrapper-hash pheap))))
       (progn
         (setq class (dc-%svref disk-cache old-wrapper $wrapper.class))
         (multiple-value-setq (wrapper memory-class slot-names obsolete?)
           (dc-update-class-wrapper disk-cache class pheap nil dont-update))
         (unless slot-names
           (setq slot-names (pointer-load pheap (dc-%svref disk-cache old-wrapper $wrapper.slots)
                                          :default disk-cache)
                 wrapper old-wrapper))))
     (if (if (and wrapper (not obsolete?))
           (eql wrapper old-wrapper)
           (when (equalp slot-names
                         (setq old-slot-names
                               (pointer-load pheap (dc-%svref disk-cache old-wrapper $wrapper.slots)
                                             :default disk-cache)))
             (setq wrapper (setf (gethash slot-names (wrapper-hash pheap)) old-wrapper))))
       ; Wrapper is current
       (values instance-slots slot-names)
       ; Wrapper needs updating.
       (progn
         (unless old-slot-names
           (setq old-slot-names (pointer-load 
                                 pheap
                                 (dc-%svref disk-cache old-wrapper $wrapper.slots)
                                 :default disk-cache)))
         (if dont-update
           (values instance-slots old-slot-names slot-names)
           (let* ((slot-count (length slot-names))
                  (slot-values (make-array slot-count))
                  (slot-imms (make-array slot-count)))
             (declare (fixnum slot-count))
                      ;(dynamic-extent slot-values slot-imms))
             (unless wrapper
               (let ((class (dc-%svref disk-cache old-wrapper $wrapper.class)))
                 (setq wrapper (dc-update-class-wrapper disk-cache class pheap memory-class dont-update))))
             (dotimes (i slot-count)
               (let ((index (position (svref slot-names i) old-slot-names :test 'eq)))
                 (if index
                   (multiple-value-bind (value imm?) (dc-uvref disk-cache instance-slots index)
                     (setf (svref slot-values i) value
                           (svref slot-imms i) imm?))
                   (setf (svref slot-values i) (%unbound-marker)
                         (svref slot-imms i) t))))
             (let* ((old-instance-length (dc-length disk-cache instance-slots))
                    (new-instance-slots (if (>= old-instance-length slot-count)
                                          (let ((index slot-count))
                                            (dotimes (i (- old-instance-length slot-count))
                                              (setf (dc-uvref disk-cache instance-slots index t)
                                                    (%unbound-marker)))
                                            instance-slots)
                                          (dc-make-vector
                                           disk-cache slot-count
                                           (dc-area disk-cache instance-slots)
                                           (%unbound-marker) t))))
               (dotimes (i slot-count)
                 (let ((value (svref slot-values i))
                       (imm? (svref slot-imms i)))
                   (unless (and imm? (eq value (%unbound-marker)))
                     (setf (dc-%svref disk-cache new-instance-slots i imm?) value))))
               (dc-shared-initialize disk-cache pheap slot-values new-instance-slots memory-class)
               (setf (dc-%svref disk-cache instance $instance.wrapper) wrapper
                     (dc-%svref disk-cache instance $instance.slots) new-instance-slots)
               (values new-instance-slots slot-names)))))))))


;; %class-instance-slotds -> effective-instance-and-class-slotds ??
(defun dc-shared-initialize (disk-cache pheap slot-values new-instance-slots class &optional (slot-names t))
  ;; I don't know how to find all this stuff in the disk version - I don't think it's there.
  ;; copied from %shared-initialize
  (when class
    (let ((class-instance-slots (ccl::class-instance-slots class)))
      (dotimes (i (length class-instance-slots)) ;; its a list  ;(ccl::%class-instance-slotds class)))
        (declare (fixnum i))
        (let* ((slotd (elt class-instance-slots i))
               (index i)
               (initform (ccl::%slot-definition-initform slotd)))
          (when (and initform
                     (eq (svref slot-values index) (%unbound-marker))
                     (or (eq slot-names t) (memq (ccl::%slot-definition-name slotd) slot-names)))
            (let ((value
                   (if (listp initform) ;(value)
                     (car initform)
                     (funcall initform))))
              (multiple-value-bind (v imm?) (%p-store pheap value)
                (setf (dc-%svref disk-cache new-instance-slots index imm?) v)))))))))

    

(def-predicate ccl::standard-instance-p (p disk-cache pointer)
  (and (dc-uvectorp disk-cache pointer)
       (eq (dc-%vector-subtype disk-cache pointer) $v_instance)))

(def-accessor slot-value (p slot-name) (disk-cache pointer)
  (require-satisfies dc-standard-instance-p disk-cache pointer)
  (multiple-value-bind (value imm?)
                       (dc-%slot-value disk-cache pointer slot-name)
    (if (and imm? (eq value (%unbound-marker)))
      (dc-slot-unbound disk-cache pointer slot-name)
      (values value imm?))))

(defun dc-%slot-value (disk-cache pointer slot-name)
  (multiple-value-bind (slots index)
                       (dc-%slot-vector-and-index disk-cache pointer slot-name t)
    (if slots
      (if (eq slots (%unbound-marker))
        (values slots t)
        (dc-%svref disk-cache slots index))
      (dc-slot-missing disk-cache pointer slot-name 'slot-value))))

(defun dc-slot-missing (disk-cache pointer slot-name operation &optional new-value)
  (declare (ignore operation new-value))
  (error "~s has no slot named ~s" 
         (pptr (disk-cache-pheap disk-cache) pointer) slot-name))

(defun dc-slot-unbound (disk-cache pointer slot-name)
  (error "Slot ~s is unbound in ~s"
         slot-name (pptr (disk-cache-pheap disk-cache) pointer)))

; Returns two values:
; 1) disk-cache vector of slots
; 2) index in the vector
;
; If the slot doesn't exist, returns NIL.
; If the slot exists, but only after the instance is updated and dont-update
; is true, returns (%unbound-marker).
(defun dc-%slot-vector-and-index (disk-cache pointer slot-name &optional dont-update)
  (let* ((pheap (disk-cache-pheap disk-cache))
         (wrapper (dc-%svref disk-cache pointer $instance.wrapper))
         (memory-class (pointer-load
                        pheap
                        (dc-%svref disk-cache
                                   (dc-%svref disk-cache wrapper $wrapper.class)
                                   $class.name)
                        :default disk-cache)))
    (multiple-value-bind (slots slot-names real-slot-names)
                         (dc-updated-instance-slots
                          disk-cache pointer
                          (find-class
                           memory-class
                           nil)
                          pheap
                          dont-update)
      (let ((index (position slot-name slot-names :test 'eq))
            (real-index (and dont-update
                             real-slot-names
                             (position slot-name real-slot-names))))
        (if (and index (or (not dont-update) (not real-slot-names) real-index))
          (values slots index)
          (if real-index
            (%unbound-marker)
            nil))))))

(defun (setf p-slot-value) (value p slot-name)
  (if (pptr-p p)
    (let* ((pheap (pptr-pheap p))
           (disk-cache (pheap-disk-cache pheap))
           (pointer (pptr-pointer p)))
      (multiple-value-bind (slots index)
                           (dc-%slot-vector-and-index disk-cache pointer slot-name)
        (unless slots
          (dc-slot-missing disk-cache pointer slot-name '(setf p-slot-value)))
        (multiple-value-bind (v imm?) (%p-store pheap value)
          (setf (dc-%svref disk-cache slots index imm?) v)
          (if imm?
            v
            (pptr pheap v)))))
    (setf (slot-value p slot-name) value)))

(def-accessor slot-boundp (p slot-name) (disk-cache pointer)
  (values (not (eq (dc-%slot-value disk-cache pointer slot-name)
                   (%unbound-marker)))
          t))

(def-accessor slot-makunbound (p slot-name) (disk-cache pointer)
  (multiple-value-bind (slots index)
                       (dc-%slot-vector-and-index disk-cache pointer slot-name t)
    (unless slots
      (dc-slot-missing disk-cache pointer slot-name 'p-slot-makunbound))
    (unless (eq slots (%unbound-marker))
      (setf (dc-%svref disk-cache slots index t) (%unbound-marker)))
    pointer))

(defmethod %p-store-object (pheap (object ccl::funcallable-standard-object) descend)
  (declare (ignore pheap descend))
  (error "Can't save generic functions yet. Maybe never."))

; this will do the wrong thing if anyone redefines the class
; of the object while it is running.
(defmethod %p-store-object (pheap (object standard-object) descend)
  (let* ((class (class-of object))
         (consed? nil))
    (%p-store-object-body (pheap object descend disk-cache address)
      (progn
        (setq consed? t)
        (dc-%allocate-instance disk-cache (%p-store pheap class)))
      (progn
        (unless consed?
          ; Ensure that p-make-load-function-using-pheap method didn't change too much to handle
          (require-satisfies dc-vector-subtype-p disk-cache address $v_instance))
        (multiple-value-bind (slots slot-names)
                             (dc-updated-instance-slots disk-cache address class pheap)
          (dotimes (i (length slot-names))
            (let ((slot-name (svref slot-names i)))
              (multiple-value-bind (value imm?)
                                   (if (slot-boundp object slot-name)
                                     (%p-store pheap (wood-slot-value object slot-name) descend)
                                     (values (%unbound-marker) t))
                (setf (dc-uvref disk-cache slots i imm?) value)))))))))

; New functions
; Allows a p-make-load-function-using-pheap method to save slots for an object
; and do something else as well.

(defmacro sd-slots (sd)
  `(ccl::%svref ,sd 1))

(defmethod instance-slot-names ((instance structure-object))
  (let ((sd (gethash (car (ccl::%svref instance 0)) ccl::%defstructs%))
        (res nil))
    (dolist (slot (sd-slots sd))
      (let ((name (car slot)))
        (when (symbolp name)
          (push name res))))
    (nreverse res)))

(defmethod instance-slot-names ((instance standard-object))
  (mapcar 'slot-definition-name (class-instance-slots (class-of instance))))

(defmethod p-make-load-function-saving-slots ((object standard-object) &optional (slots nil slots-p))
  (%p-make-load-function-saving-slots object slots slots-p))

(defmethod p-make-load-function-saving-slots ((object structure-object) &optional (slots nil slots-p))
  (%p-make-load-function-saving-slots object slots slots-p))

(defun %p-make-load-function-saving-slots (object slots slots-p)
  (let* ((slot-names (if slots-p slots (instance-slot-names object)))
         (mapper #'(lambda (slot)
                     (if (slot-boundp object slot)
                       (slot-value object slot)
                       (ccl::%unbound-marker-8))))
         (slot-values (mapcar mapper slot-names)))
    (declare (dynamic-extent mapper))
    (values `(allocate-instance-of-class ,(class-name (class-of object)))
            (when slot-names
              `(ccl::%set-slot-values ,slot-names ,slot-values)))))

(defun allocate-instance-of-class (class-name)
  (allocate-instance (find-class class-name)))

(defun progn-load-functions (&rest load-functions)
  (declare (dynamic-extent load-functions))
  (when load-functions
    (do* ((this load-functions next)
          (next (cdr this) (cdr this)))
         ((null next) (apply 'funcall (car this)))
      (apply 'funcall (car this)))))

(defun progn-init-functions (object &rest init-functions)
  (declare (dynamic-extent init-functions))
  (dolist (f.args init-functions)
    (apply (car f.args) object (cdr f.args))))

(defun p-load-instance (pheap disk-cache pointer depth subtype)
  (declare (ignore subtype))
  (let* ((cached? t)
         class
         (instance (maybe-cached-value pheap pointer
                     (setq cached? nil)
                     (if (null depth)
                       (return-from p-load-instance (pptr pheap pointer)))
                     (setq class (pointer-load pheap
                                               (dc-%svref disk-cache
                                                          (dc-instance-class-wrapper
                                                           disk-cache pointer)
                                                          $wrapper.class)
                                               :default
                                               disk-cache))
                     (allocate-instance class))))
    (when (or (not cached?)
              (and (eq depth t)
                   (let ((p-load-hash (p-load-hash pheap)))
                     (unless (gethash instance p-load-hash)
                       (setf (gethash instance p-load-hash) instance)))))
      (let ((next-level-depth (cond ((or (eq depth :single) (fixnump depth)) nil)
                                    (t depth)))
            (disk-resident-slots (wood-disk-resident-slot-names instance)))
        (multiple-value-bind (slot-vector slot-names real-slot-names)
                             (dc-updated-instance-slots
                              disk-cache pointer class pheap t)
          (dotimes (i (length slot-names))
            (let ((slot-name (svref slot-names i)))
              (when (or (null real-slot-names) (position slot-name real-slot-names))
                (multiple-value-bind (pointer immediate?)
                                     (dc-%svref disk-cache slot-vector i)
                  (if immediate?
                    (if (eq pointer (%unbound-marker))
                      (slot-makunbound instance slot-name)
                      (setf (wood-slot-value instance slot-name) pointer))
                    (setf (wood-slot-value instance slot-name)
                          (if (member slot-name disk-resident-slots :test #'eq)
                            (pptr pheap pointer)
                            (pointer-load pheap pointer next-level-depth disk-cache))))))))
          (when real-slot-names
            (let (new-slot-names)
              (dotimes (i (length real-slot-names))
                (let ((slot-name (svref real-slot-names i)))
                  (unless (position slot-name slot-names)
                    (push slot-name new-slot-names))))
              (when new-slot-names
                (shared-initialize instance new-slot-names))))))
      (unless cached?
        (initialize-persistent-instance instance)))
    instance))

; These methods allow users to specialize the way that CLOS instances are saved.

; Return a vector of the names of the slots to be saved for an instance.
; The instance saving code assumes that multiple calls to this
; method will return the same (EQ) vector unless the class has been redefined.
; May be called with a CLASS-PROTOTYPE, so don't expect any of the slots
; to contain useful information.
(defmethod wood-slot-names-vector ((object standard-object))
  (class-slots-vector (class-of object)))

; These allow specialization of slot-value.
; Some slots may want to be saved in a different format,
; or interned on the way back in.
(defmethod wood-slot-value ((object standard-object) slot-name)
  (slot-value object slot-name))

(defmethod (setf wood-slot-value) (value (object standard-object) slot-name)
  (setf (slot-value object slot-name) value))
  

; This generic function is called on a newly loaded CLOS instance
(defmethod initialize-persistent-instance (instance)
  (declare (ignore instance))
  nil)


; This generic function is called when an instance is p-load'ed to
; determine which slots should remain disk resident and have pptr's
; put in the instance.
(defgeneric wood-disk-resident-slot-names (instance)
  (:method ((instance t))
    nil))

(declaim (inline default-slot-value-processor))

(defun default-slot-value-processor (instance slot-name value sticky p-loader pass-instance-to-p-loader)
  (if (pptr-p value)
    (let ((loaded-value
           (if pass-instance-to-p-loader
             (funcall p-loader instance value)
             (funcall p-loader value))))
      (when sticky
        (setf (slot-value instance slot-name) loaded-value))
      loaded-value)
    value))

; An easy way to define a wood-disk-resident-slot-names method
; and some :around methods on slot accessors to swap the slots
; in on demand.
(defmacro define-disk-resident-slots ((class-name &key 
                                                       sticky
                                                       (p-loader ''p-load)
                                                       pass-instance-to-p-loader
                                                       (slot-value-processor '#'default-slot-value-processor))
                                           &body slots-and-accessors)
  (let* ((sticky-p #'(lambda (slot-and-accessor)
                       (let ((cell (and (listp slot-and-accessor) (cddr slot-and-accessor))))
                         (if cell (car cell) sticky))))
         (slots (mapcar #'(lambda (x) (if (listp x) (first x) x)) slots-and-accessors))
         (accessors (mapcar #'(lambda (x) (if (listp x) (second x) x)) slots-and-accessors))
         (stickies (mapcar sticky-p slots-and-accessors))
         (class (find-class class-name nil))
         (instance (make-symbol (symbol-name class-name))))
    (declare (dynamic-extent sticky-p))
    (flet ((require-symbol (x) (require-type x 'symbol)))
      (mapc #'require-symbol slots)
      (mapc #'require-symbol accessors))
    (when class
      (let* ((class-slots (mapcar 'slot-definition-name (ccl:class-instance-slots class))))
        (flet ((require-slot (slot)
                 (unless (member slot class-slots :test 'eq)
                   (warn "~s is not an instance slot of ~s" slot class))))
          (declare (dynamic-extent #'require-slot))
          (mapc #'require-slot slots))))
    `(progn
       ,@(loop for slot in slots
               for accessor in accessors
               for sticky in stickies
               collect
               `(defmethod ,accessor :around ((,instance ,class-name))
                  (funcall ,slot-value-processor
                           ,instance
                           ',slot
                           (call-next-method)
                           ,(not (null sticky))
                           ,p-loader
                           ,(not (null pass-instance-to-p-loader)))))
       (defmethod wood-disk-resident-slot-names ((,class-name ,class-name))
         ',slots)
       (record-source-file ',class-name :disk-resident-slots)
       ',class-name))) 

(defun p-make-instance (pheap class &rest arglist)
   "Makes an instance of the class on the pheap, returning a pptr to the object"
   (declare (dynamic-extent arglist))
   (pptr pheap (%p-make-instance pheap class arglist)))

(defun %p-make-instance (pheap class arglist)
   (declare (dynamic-extent arglist))
   (let* ((disk-cache (pheap-disk-cache pheap))
          (class (if (symbolp class) (find-class class) class))
          ;; This is where most of the time goes:
          (instance (dc-%allocate-instance disk-cache (%p-store pheap class) class))
          (class-instance-slots (ccl::class-instance-slots class)) ; class-instance-slots conses - tant pis
          (slots (dc-%svref disk-cache instance $instance.slots)))
     (dotimes (i (length class-instance-slots) instance) ;; its a list today
       (declare (fixnum i))
       (loop
         with args = arglist
         with slot = (elt class-instance-slots i)  ;; its a list today
         with keys = (ccl::slot-definition-initargs slot)
         while args
         for key = (pop args)
         for value = (if args (pop args) (error "Missing value for key argument ~A" key))
         for match = (memq key keys)
         until match
         finally
           (unless match
             (let ((initform (ccl::slot-definition-initform slot)))
               (setq value
                 (etypecase initform
                   (null (return))
                   (list (car initform))
                   (function (funcall initform))))))
         ;; The first key argument should be the one to take effect (as in make-instance):
         finally
           (multiple-value-bind (pointer imm?)
             (if value
               (%p-store pheap value :default)
               $pheap-nil)
             (setf (dc-%svref disk-cache slots i imm?) pointer))))))




;;;    1   3/10/94  bill         1.8d247
;;;    2   7/26/94  Derek        1.9d027
;;;    3  10/04/94  bill         1.9d071
;;;    4  11/01/94  Derek        1.9d085 Bill's Saving Library Task
;;;    5  11/03/94  Moon         1.9d086
;;;    6  11/05/94  kab          1.9d087
;;;    2   3/23/95  bill         1.11d010
