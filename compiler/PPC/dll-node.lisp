;;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: dll-node.lisp,v $
;; Revision 1.2  2002/11/18 05:36:02  gtbyers
;; Add CVS log marker
;;
;;; 02/01/97 gb   insert-dll-node-before.
;;; -------- 4.0
;;;  9/20/96 slh  move require defstruct out to nx.lisp
;;; 01/10/96  gb  freelisting.

(in-package "CCL")


(defstruct (dll-node (:print-function print-dll-node))
  pred
  succ)

; Doubly-linked list header (just a distinguished type of node)
(defstruct (dll-header
            (:include dll-node)
            (:constructor %make-dll-header))
)

(defmacro dll-header-last (h) `(dll-header-pred ,h))
(defmacro dll-header-first (h) `(dll-header-succ ,h))


(defun make-dll-header ()
  (let* ((h (%make-dll-header)))
    (setf (dll-header-first h) h
          (dll-header-last h) h)))


; DLL-NODEs are sort of "abstract classes", so we should rarely
; (if ever) have to print one.  On the other hand, they're very
; circular abstract classes ...
(defun print-dll-node (n stream d)
  (declare (ignore d))
  (print-unreadable-object (n stream :type t :identity t)))

; Return NODE's list header, if it has one.
(defun dll-node-header (node)
  (do* ((n node (dll-node-succ node)))
       ((or (null n) (typep n 'dll-header)) n)))

; Make node be the last node in header's linked list
(defun append-dll-node (node header)
  (let* ((last (dll-header-last header)))
    (setf (dll-node-pred node) last
          (dll-header-last header) node
          (dll-node-succ node) header
          (dll-node-succ last) node)))

; Splice one or more nodes out of the containing doubly-linked list.
; Return the first and last nodes in the new chain.
(defun remove-dll-node (node &optional (count 1))
  (declare (fixnum count))
  (do* ((last node (dll-node-succ last))
        (i 1 (1+ i)))
       ((= i count)
        (let* ((prev (dll-node-pred node))
               (after (dll-node-succ last)))
          (setf (dll-node-pred after) prev
                (dll-node-succ prev) after
                (dll-node-pred node) nil
                (dll-node-succ last) nil)
          (values node last)))
    (declare (fixnum i))
    ; This check shouldn't cost much and keeps us from doing something
    ; really stupid.
    (when (typep last 'dll-header)
      (error "Can't remove header node ."))))

; Insert one or mode nodes after a specified node.
; To be sane, the "chainlast" argument must be "node" or a transitive successor
; of "node", (and "node" EQ to or a transitive predecessor of "chainlast", and no 
; list header should appear on the chain between "node" and "chainlast".
; The typical cases where this is used are to insert a freshly consed node into
; a list or to insert a chain of one or more freshly deleted nodes.  Both of these
; cases satisfy the sanity check, so it isn't performed here.
(defun insert-dll-node-after (node after &optional (chainlast node))
  (let* ((after-after (dll-node-succ after)))
    (setf (dll-node-pred node) after
          (dll-node-succ chainlast) after-after
          (dll-node-pred after-after) chainlast
          (dll-node-succ after) node)))

; More concise, somehow ...
(defun insert-dll-node-before (node before &optional (chainlast node))
  (insert-dll-node-after node (dll-node-pred before) chainlast))

(defun move-dll-nodes (node after &optional (count 1))
  (multiple-value-bind (first last) (remove-dll-node node count)
    (insert-dll-node-after first after last)))

; Return chain head and tail, or (values nil nil) if empty header.
(defun detach-dll-nodes (header)
  (let* ((first (dll-header-first header)))
    (if (eq first header)
      (values nil nil)
      (let* ((last (dll-header-last header)))
        (setf (dll-header-first header) header
              (dll-header-last header) header
              (dll-node-pred first) nil
              (dll-node-succ last) nil)
        (values first last)))))

(defun merge-dll-nodes (target &rest others)
  (declare (dynamic-extent others))
  (dolist (other others target)
    (multiple-value-bind (head tail) (detach-dll-nodes other)
      (when head
        (insert-dll-node-after head (dll-header-last target) tail)))))

; This definition doesn't work when the body unlinks "more than" the current node.
(defmacro do-dll-nodes ((valvar header &optional result) &body body)
  (let* ((headervar (make-symbol "HEADER"))
         (next (make-symbol "NEXT")))
    `(do* ((,headervar ,header)
           (,valvar (dll-header-first ,headervar) ,next)
           (,next (dll-node-succ ,valvar) (dll-node-succ ,valvar)))
          ((eq ,valvar ,headervar)
           ,result)         
       ,@body)))

(defun dll-header-length (header)
  (let* ((count 0))
    (declare (fixnum count))
    (do-dll-nodes (n header count)
      (incf count))))

(defun dll-node-position (node header)
  (let* ((pos 0))
    (declare (fixnum pos))
    (do-dll-nodes (n header)
      (if (eq n node)
        (return pos)
        (incf pos)))))

; dll-node freelisting ...

(defun make-dll-node-freelist ()
  (%cons-pool))

; header shouldn't be used after this is called
(defun return-dll-nodes (header freelist)
  (without-interrupts
   (let* ((pool-header (pool.data freelist)))
     (if (null pool-header)
       (setf (pool.data freelist) header)
       (multiple-value-bind (first last) (detach-dll-nodes header)
         (if first
           (insert-dll-node-after first (dll-header-last pool-header) last))))
     nil)))

; Pop a node off off the freelist; return NIL if the freelist is empty.
; Set the succ and pred slots of the node to NIL; other slots are undefined.
(defun alloc-dll-node (freelist)
  (without-interrupts
   (let* ((pool-header (pool.data freelist))
          (node (if pool-header (dll-header-first pool-header))))
     (if (and node (not (eq node pool-header)))
       (remove-dll-node node)))))

(defun free-dll-node (node freelist)
  (without-interrupts
   (let* ((pool-header (pool.data freelist)))
     (if (null pool-header)
       (progn
         (setq pool-header (make-dll-header))
         (setf (pool.data freelist) pool-header)))
     (append-dll-node node pool-header)
     nil)))

(defun remove-and-free-dll-node (node freelist)
  (remove-dll-node node)
  (free-dll-node node freelist))

(defmacro with-dll-node-freelist ((header-var freelist) &body body)
  (let* ((internal-header-name (gensym))
         (internal-freelist-name (gensym)))
    `(let* ((,internal-header-name (make-dll-header))
            (,internal-freelist-name ,freelist))
       (unwind-protect
         (let* ((,header-var ,internal-header-name))
           ,@body)
         (return-dll-nodes ,internal-header-name ,internal-freelist-name)))))

(ccl::provide "DLL-NODE")
