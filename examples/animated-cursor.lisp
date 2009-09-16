;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;      animated-cursor.lisp
;;
;;      23/mar/07 akh - use #_SetAnimatedThemeCursor - no more resources
;;      10/09/96 slh   move export to inside eval-when
;;      03/14/96 bill  Conditionalize LAP out for ppc-target
;;      3/9/93 Derek White
;;

;;
;;      with-animated-cursor type-or-object       &body           [macro]
;;      This form automatically spins the cursor according to type-or-object.
;;      (Use this like with-cursor).
;;      Cursor spins when update-cursor is called and null-event-handlers
;;      call update-cursor.  This happens a little slowly, so you may want
;;      call (update-cursor) or event-dispatch yourself.
;;
;;      
;;      make-animated-cursor type                 [function]
;;      type      A keyword specifying the type of the theme-cursor 
;;                to use. - see *theme-cursor-alist*
;;
;;    types that can animate - :watch-cursor, :counting-up-hand-cursor, :counting-down-hand-cursor,
;;    :counting-up-and-down-hand-cursor, :spinning-cursor


(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (export '( with-animated-cursor
             make-animated-cursor
             )))


(defparameter *rotate-delay* 20)

(defclass animated-cursor ()
  ((count :reader animated-cursor-count :initarg :count :initform 200)
   (rotate-delay :reader animated-cursor-rotate-delay :initarg :rotate-delay :initform *rotate-delay*)
   (stamp :accessor animated-cursor-stamp :initform (get-tick-count))
   (index :accessor animated-cursor-index :initarg :index :initform 0)
   (cursor-type :accessor cursor-type :initarg :type)))

(defun make-animated-cursor (type &key (rotate-delay *rotate-delay*) (count 400))
  (let ((real-type (if (fixnump type) type (cdr (assq type *theme-cursor-alist*)))))
    ;; is there a simple way to test if can be animated
    (if (or (not real-type) (and (fixnump type) (null (rassoc type *theme-cursor-alist*))))
      (error "Type ~s is not a theme cursor" type)) 
    (make-instance 'animated-cursor
      :type real-type
      :rotate-delay rotate-delay      
      :count count)))

(defmethod init-animated-cursor ((cursor animated-cursor))
  (setf (animated-cursor-stamp cursor)(get-tick-count))
  (setf (animated-cursor-index cursor) 0))

(defmethod rotate-animated-cursor ((cursor animated-cursor))
  (without-interrupts
   (let ((new-stamp (get-tick-count)))
     (when (<= (animated-cursor-rotate-delay cursor)
               (%tick-difference new-stamp (animated-cursor-stamp cursor)))
       (setf (animated-cursor-stamp cursor) new-stamp)
       (let ((index (+ 1 (animated-cursor-index cursor))))
         (when (>= index (animated-cursor-count cursor))
           (setf index 0))
         (setf (animated-cursor-index cursor) index)
         (let ((err(#_SetAnimatedThemeCursor (cursor-type cursor) index)))
           (if (neq err #$noErr) (#_SetThemeCursor (cursor-type cursor) ))))))))

(defmacro with-animated-cursor (kwd-or-object &body body)  
  (let ((var (gensym)))
    `(let ((,var ,kwd-or-object))
       (if (or (keywordp ,var)(fixnump ,var))
         (setf ,var (make-animated-cursor ,var))
         (init-animated-cursor ,var))
       (with-cursor #'(lambda ()
                        (rotate-animated-cursor ,var))
         ,@body))))

#| - tests:

(with-animated-cursor :counting-up-and-down-hand-cursor (sleep 10))

(with-animated-cursor :watch-cursor (sleep 10))

(defparameter *spinner* (make-animated-cursor :spinning-cursor :rotate-delay 10))
(with-animated-cursor *spinner* (sleep 10))
|#

#| ;; old version

;;      'acur' resources specify a sequence of cursors to cycle through
;;      to get spinning ball cursors, etc.
;;      'acur' resources are documented in the MPW manuals (they are 
;;      essentially a count followed by an array of 'CURS' resource ids)
;;      The 'acur' reource and the 'CURS' resources it refers to must exist
;;      in an open resource file.
;;
;;      The finder seems to use 'acur' #6500, so you could copy it to your
;;      resource file.

(defrecord (acur :handle)
  (count :integer)
  (pad :integer)
  ; Array is [id-0, pad, id-1, pad,...], so multiply n by 2 to get the nth id.
  (array (array :integer 40))) ; the array is actually variable.



(defclass animated-cursor ()
  ((count :reader animated-cursor-count :initarg :count)
   (stamp :accessor animated-cursor-stamp :initform (get-tick-count))
   (index :accessor animated-cursor-index :initarg :index)
   (ids :reader animated-cursor-ids :initarg :ids)))

(defun make-animated-cursor (acur-id)
  ; Make an animated-cursor corresponding to the 'acur' resource.
  ; This gets and releases the resource.
  (let ((acur-hdl nil))
    (check-type acur-id integer)
    (unwind-protect
      (progn
        (setf acur-hdl (#_GetResource :|acur| acur-id))
        (let ((err (#_ResError)))
          (unless (eql 0 err)
            (%err-disp err)))
        (when (%null-ptr-p acur-hdl)
          (error "'acur' resource #~d does not exist." acur-id))
        (let* ((count (href acur-hdl :acur.count))
               (ids (make-array count :element-type 'integer)))
          (dotimes (n count)
            (setf (svref ids n) (href acur-hdl (acur.array (* n 2)))))
          (make-instance 'animated-cursor
            :count count
            :ids ids
            :index (aref ids 0))))
      (when (and acur-hdl (not (%null-ptr-p acur-hdl)))
        (#_ReleaseResource acur-hdl)))))

(defconstant $rotate-delay (floor 60 8))

(defun rotate-animated-cursor (animated-cursor)
  (without-interrupts
   (let ((new-stamp (get-tick-count)))
     (when (<= $rotate-delay
               (%tick-difference
                new-stamp (animated-cursor-stamp animated-cursor)))
       (setf (animated-cursor-stamp animated-cursor) new-stamp)
       (let ((index (+ 1 (animated-cursor-index animated-cursor))))
         (when (>= index (animated-cursor-count animated-cursor))
           (setf index 0))
         (setf (animated-cursor-index animated-cursor) index)
         (set-cursor (aref (animated-cursor-ids animated-cursor) index)))))))

(defmacro with-animated-cursor (id-or-object &body body)
  ; id-or-object is usually the 'acur' resource id to use,
  ; but it can be an animated-cursor object. 
  ; During the execution of body, the cursor will cycle through the 
  ; cursors specified by the 'acur' resource.
  (let ((var (gensym)))
    `(let ((,var ,id-or-object))
       (when (integerp ,var)
         (setf ,var (make-animated-cursor ,var)))
       (with-cursor #'(lambda ()
                        (rotate-animated-cursor ,var))
         ,@body))))
|#


