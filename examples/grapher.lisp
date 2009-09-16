;;-*- Mode: Lisp; Package: (GRAPHER (COMMON-LISP CCL)) -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Grapher.Lisp
;;
;; Copyright 1989-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;;
;;  This file implements the base functionality for nodes and grapher-windows
;;  In order to use it, specific types of nodes must be defined.
;;  The commented out code at the bottom of this file is an example.
;;  Nodes should follow the node protocol by defining the the following functions:
;;    node-children --  returns a list of the node's children nodes
;;    node-parent   --  returns a list of the node's parent nodes
;;    node-draw     --  does the work of drawing a node.  usual-node-draw
;;                      should be called.
;;    node-size     --  returns a point: the size of the node.  Default: #@(150 20)
;;
;;  The redrawing could be sped up by caching the rectangles
;;  for all the nodes and lines in a quad-tree.  This would, however,
;;  consume a lot more space for a graph.
;;

;; Mod History
;; fixes for opaque grafport
;; ------ 5.2b6
;; #_drawstring -> grafport-write-string
;; ------- 5.2b4
;; 08/18/93 bill with-clip-rect-intersect -> "level-2.lisp"
;; ------------- 3.0d12
;; 02/23/93 bill Add window-type initarg to grapher-window class
;; 01/14/93 bill Henry Lieberman's fix to layout-y so that nodes of unequal
;;               sizes will not overlap.
;; ------------- 2.0
;; 10/30/91 bill remove "-iv" on the end of slot names
;; 09/03/91 bill add defgeneric for node-children & node-parents
;; 05/01/91 bill control-meta-click does edit-definition in example code
;;               (mc's idea).
;; 03/20/91 bill add view-click-event-handler translated by Doug Currie.
;;

(defpackage :grapher (:use :common-lisp :ccl))
(in-package :grapher)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :scrolling-windows)
  (require :quickdraw)
  )


(declaim (ftype (function (&rest t) t) ccl::my-scroller))

;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; variables
;;

(defparameter *last-y* 0)
(defparameter *x-spacing* 30)
(defparameter *y-spacing* 10)

(defparameter *grapher-window-size* *window-default-size*)

;;;;;;;;;;;;;;;
;;
;;  some utilities
;;

(defun point-max (a b)
  (make-point (max (point-h a) (point-h b))
              (max (point-v a) (point-v b))))

(defun point-min (a b)
  (make-point (min (point-h a) (point-h b))
              (min (point-v a) (point-v b))))

(defun halve-point (point)
  (make-point (truncate (point-h point) 2)
              (truncate (point-v point) 2)))


;;;;;;;;;;;;;;;;;;;
;;;
;;; node objects
;;;

(defclass node () 
  ((node-position :reader node-position  :initform #@(0 0))
   (node-size  :reader node-size  :initform #@(150 150))
   (node-center  :reader node-center  :initform nil))
   )

(defmethod set-node-position ((self node) h &optional v)
  (setf (slot-value self 'node-position) (make-point h v)
        (slot-value self 'node-center) nil))

(defmethod set-node-size ((self node) h &optional v)
    (setf (slot-value self 'node-size) (make-point h v)
        (slot-value self  'node-center) nil))

(defmethod node-center ((self node))
  (or (slot-value self 'node-center)
      (setf (slot-value self 'node-center)
            (add-points (node-position self)
                        (halve-point (node-size self))))))



(defmethod node-field-size ((self node) limit)
  (setq limit (point-max limit
                         (add-points (node-position self)
                                     (node-size self))))
  (dolist (child (node-children self) limit)
    (setq limit (node-field-size child limit))))

(defmethod node-click-event-handler ((self node) where)
  (declare (ignore where)))

(defun layout (root-node)
  (graph-init root-node)
  (set-node-position root-node (make-point *x-spacing*
                                           (point-v (node-position root-node))))
  (setq *last-y* 0)
  (layout-y root-node)
  (leaf-funcall #'layout-x root-node))

(defun graph-init (node)
  "Zeros the coordinates of a node and all of its subnodes"
    (set-node-position node #@(0 0))
    (setf (slot-value node 'node-center) nil)
    (mapc #'graph-init (node-children node)))

(defun layout-y (node)
    (when (zerop (point-v (node-position node)))
      (let ((children (node-children node)))
        (if (dolist (child children)
              (if (zerop (point-v (node-position child)))
                (return t)))
          (progn
            (mapc #'layout-y children)
            (set-node-position node
             (make-point (point-h (node-position node))
                         (ceiling 
                          (reduce #'(lambda (a b) (+ a (point-v (node-position b))))
                                  children 
                                  :initial-value 0)
                          (length children)))))
          (let ((new-y (+ *last-y* *y-spacing*)))
            (set-node-position node
                               (make-point (point-h (node-position node))
                                           new-y))
            (setf *last-y* (+ new-y (point-v (node-size node)))))))))

(defun layout-x (node &aux parents)
  (let* ((pos (node-position node)))
    (when (and (zerop (point-h pos))
               (setq parents (node-parents node)))
      (dolist (parent parents)
        (layout-x parent))
      (set-node-position node
                         (make-point (+ *x-spacing*
                                        (apply #'max (mapcar #'(lambda (node)
                                                                 (point-h
                                                                  (add-points (node-position node)
                                                                              (node-size node))))
                                                             parents)))
                                     (point-v pos))))))

(defun leaf-funcall (fn node &aux (children (node-children node)))
  "Calls fn on all the leaves of the graph starting at node"
  (if children
    (dolist (child children)
      (leaf-funcall fn child))
    (funcall fn node)))

(defmethod node-draw-links ((self node) &aux (children (node-children self)))
  (when children
    (let* ((center (node-center self)))
      (dolist (child children)
          (let ((child-center (node-center child)))
            (#_MoveTo :long center)
            (#_LineTo :long child-center))))))

(defmethod node-draw ((self node))
  (let* ((children (node-children self))
         (vis? (node-visible-p self))
         (draw-links? (and (or vis? (node-on-right-p self))
                           (some #'(lambda (kid)
                                    (node-on-left-p kid))
                                 children)))
         (do-kids? (or draw-links? (some #'(lambda (kid)
                                             (node-on-right-p kid))
                                         children))))
    (when draw-links?
      (node-draw-links self))
    (when do-kids?
      (dolist (child children)
       (node-draw child)))
    vis?))

(defmethod node-on-right-p ((self node))
  #|(< (point-h (node-center self))
     (rref (ccl::%getport) :grafport.portrect.right))|#
  (rlet ((rect :rect))
    (ccl::with-port-macptr port
      (#_getportbounds port rect)
      (< (point-h (node-center self))
         (pref rect :rect.right)))))

 
(defmethod node-on-left-p ((self node))
  #|(> (point-h (node-center self)) (rref (ccl::%getport) :grafport.portrect.left))|#
  (rlet ((rect :rect))
    (ccl::with-port-macptr port
      (#_getportbounds port rect)
      (> (point-h (node-center self))
         (pref rect :rect.left)))))

(defmethod node-visible-p ((self node))
  (let ((pos (node-position self)))
    (rlet ((grafrect :rect))
      (ccl::with-port-macptr port
        (#_getportbounds port grafrect)
        (rlet ((noderect :rect
                         :topleft pos
                         :bottomright (add-points pos (node-size self))))
          (#_SectRect grafrect noderect noderect))))))


(defun find-node-containing-point (node point &aux ret)
    (let* ((pos (node-position node)))
      (rlet ((r :rect 
                :topleft pos
                :bottomright (add-points pos (node-size node))))
        (if (#_PtInRect point r)
          node
          (dolist (child (node-children node))
            (if (setq ret (find-node-containing-point child point))
              (return ret)))))))

; You must define methods for these
(defgeneric node-children (node))
(defgeneric node-parents (node))

;;;;;;;;;;;;;;;;;;;;;;
;;
;; grapher window
;;

(defclass grapher-window (ccl::scrolling-window) ((root-node :initarg :root-node)))

(defmethod initialize-instance ((self grapher-window) &rest rest
                                &key (window-title "Untitled Grapher")
                                (view-font "geneva") root-node
                                window-type)
  (declare (dynamic-extent rest))
  (unless root-node (error "A root-node must be specified"))
  (setf (slot-value self 'root-node) root-node)
  (multiple-value-bind (ff ms) (font-codes view-font)
    (with-font-codes ff ms              ; make string-width work right.
      (layout root-node)))
  (let ((field-size (add-points (make-point *x-spacing* *y-spacing*)
                                (node-field-size root-node 0))))
    (without-interrupts
     (apply #'call-next-method
            self
            :view-font view-font
            :view-size (point-min field-size *grapher-window-size*)
            :window-title window-title
            :window-type (or window-type :document-with-zoom)
            :field-size field-size
            rest
            )))
  (set-view-font self :patcopy))

(defmethod view-draw-contents ((self grapher-window))
  (call-next-method)
  (with-focused-view (slot-value self  'ccl::my-scroller)
    (node-draw (slot-value self 'root-node))))

(defmethod view-click-event-handler ((self grapher-window) where)
  (let ((scroller (ccl::my-scroller self))
        (point-view (find-view-containing-point self where)))
    (if (eq point-view scroller)
      (let ((node (find-node-containing-point
                   (slot-value self 'root-node)
                   (convert-coordinates where self scroller))))
        (when node
          (node-click-event-handler node where)))
      (call-next-method))))

(provide :grapher)


#|

(defclass object-node (node) 
  ((my-object  :initarg :object :accessor my-object :initform (find-class 'stream))
   (my-parents  :initarg :parents :accessor node-parents :initform nil)
   (my-children :accessor node-children)))

(defmethod initialize-instance ((self object-node) &key)
  (call-next-method)
  (setf (node-children self) (mapcar #'(lambda(object)
                                       (make-instance 'object-node
                                                      :object object
                                                      :parents (list self)))
                                   (class-direct-subclasses (my-object self)))))


(defmethod node-draw ((self object-node))
  (when (call-next-method)
    (let* ((topleft (node-position self))
           (left (point-h topleft))
           (bottomright (add-points topleft (node-size self)))
           (bottom (point-v bottomright)))
      (rlet ((r :rect
                :topleft topleft
                :bottomright bottomright))
        (#_eraserect r)
        (#_framerect r)
        (#_moveto (+ left 3) (- bottom 5))
        (#_insetrect :ptr r :long #@(2 2))
        (without-interrupts
         (with-clip-rect-intersect r
           #+ignore
           (with-pstrs ((str (object-name-string self)))
             (#_drawstring str))
           #-ignore
           (let ((str (object-name-string self)))
             (grafport-write-string str 0 (length str)))
           ))))))

(defmethod object-name-string ((self object-node))
        (string (class-name (my-object self))))

(defmethod node-click-event-handler ((object-node object-node) where)
  (declare (ignore where))
  (if (and (option-key-p)
           (or (control-key-p) (command-key-p)))
    (edit-definition (class-name (my-object object-node)))
    (when (double-click-p)
      (inspect (my-object object-node)))))

(defmethod node-size ((self object-node))
  (make-point (+ 10 (string-width (object-name-string self)))
              20))

(make-instance 'grapher-window
       :root-node (make-instance 'object-node)
       :window-title "Object Graph")
              


|#

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
