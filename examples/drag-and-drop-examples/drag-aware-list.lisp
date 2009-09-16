;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Drag-Aware List
;;;
;;; Theory:  This example demonstrates a simple drag-aware list view and
;;;          perhaps a few other drag manager techniques.
;;;
;;;          The list view will accept text flavors and items from other
;;;          drag-aware list views.  It allows you to drop items into specific
;;;          places within the view, as shown by the drag insertion caret.
;;;          You may also move items within a list as well as copy them (by
;;;          holding down the Option key during the drag).
;;;
;;;          Note that list items are MCL objects that contain a unique ID
;;;          (the 'item-ref slot).  Using a such an ID to refer to items,
;;;          rather than a positional number, will save you a lot of headache
;;;          in the future, especially if view allows multiple items to be
;;;          dragged out of it or dropped into it.  For instance, imagine the
;;;          nightmare if you used a positional 'item-reference and then the
;;;          user dragged the items into the Finder Trash; since either drag
;;;          item is treated separately, how will you know which item to delete
;;;          after the first one?
;;;
;;;          Another reason for using objects as list items is flexibility.
;;;          Each item is accepts a string, which is stored in the object's
;;;          'item-string slot.  When the item is displayed in the list, the
;;;          text is automatically cropped to 255 characters if needed (the
;;;          limit on this type of view).
;;;
;;;          You'll see a lot of #'convert-coordinate calls in this example,
;;;          due mainly to the fact that coordinates involving
;;;          'sequence-dialog-item views need to be in its containing view's
;;;          coordinates, while the Drag Manager stuff uses either local or
;;;          window coordinates.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; do unicode texto
;; ---- 5.2b6

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :drag-and-drop)
  
  (export '(drag-aware-list))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Class Definitions
;;;

;; The flavor for items we pass around to other drag-aware views.
(defconstant $InternalCellFlavor :|LITM|)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Class Definitions
;;;

;; The usual initialization arguments.
(defclass drag-aware-sequence-view (sequence-dialog-item
                                    drag-view-mixin)
  ((insert-cell :initform nil :accessor insert-cell)
   (insert-offset :initform 0 :accessor insert-offset))
  (:default-initargs
    :drag-allow-copy-p t
    :drag-allow-move-p t
    :drag-auto-scroll-p t
    :drag-accepted-flavor-list (list $InternalCellFlavor
                                     :|TEXT|
                                     :|utxt|
                                     )
    )
  )

;; Each instance of this class will be a single item in a list view somewhere.
(defclass list-item-object ()
  ((item-ref :initform nil :accessor item-ref)
   (item-string :initform "" :accessor item-string)
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Some methods to manipulate 'list-item-objects within view
;;;

(defmethod %create-list-item ((view drag-aware-sequence-view) (new-string string))
  (let ((new-obj (make-instance 'list-item-object))
        (new-ref (random 65536)))
    (loop while (%find-list-item view new-ref)
          do (setf new-ref (random 65536)))
    (setf (item-ref new-obj) new-ref
          (item-string new-obj) new-string)
    new-obj))

(defmethod %find-list-item ((view drag-aware-sequence-view) (item-ref integer))
  (find item-ref (table-sequence view) :test #'eql :key #'item-ref))

(defmethod %list-item-position ((view drag-aware-sequence-view) (item-ref-or-obj integer))
  (position item-ref-or-obj (table-sequence view) :test #'eql :key #'item-ref))

(defmethod %list-item-position ((view drag-aware-sequence-view) (item-ref-or-obj list-item-object))
  (%list-item-position view (item-ref item-ref-or-obj)))

(defmethod %display-list-item ((item list-item-object))
  (subseq (item-string item) 0 (min (length (item-string item)) 255)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Other handy things
;;;

(defmethod select-all ((view drag-aware-sequence-view))
  (dotimes (x (length (table-sequence view)))
    (unless (cell-selected-p view 0 x)
      (cell-select view 0 x)))
  t)

(defmethod deselect-all ((view drag-aware-sequence-view))
  (dotimes (x (length (table-sequence view)))
    (if (cell-selected-p view 0 x)
      (cell-deselect view 0 x)))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; The drag methods
;;;

;; Initializes an internal slot that keeps track of moved & copied items during
;; a drop.  The value will be used to offset the 'insert-cell slot in the case
;; of multiple dropped items; it helps guarantee that they appear in the right
;; order.
(defmethod drag-receive-drop-setup ((view drag-aware-sequence-view))
  (deselect-all view)
  (setf (insert-offset view) 0))

;; If a cell is under the mouse and the cell is selected, we can drag it
;; (and the other selected cells)
(defmethod drag-selection-p ((view drag-aware-sequence-view) mouse-position)
  (let ((cell (point-to-cell view (convert-coordinates mouse-position
                                                       view
                                                       (view-container view)))))
    (and cell (cell-selected-p view cell))))

;; Add the internal drag flavor for the item, promise the text, then compute
;; a drag region for the cell.  The region computation could probably be done
;; easier with Toolbox calls.
(defmethod drag-add-drag-contents ((view drag-aware-sequence-view))
  (let* ((dimensions (table-dimensions view))
         (vis-dimensions (visible-dimensions view))
         (top-cell (scroll-position view))
         (bottom-cell (add-points vis-dimensions top-cell))
         (item-obj nil)
         (item-reference 0)
         (superview (view-container view)))
    (dotimes (cell-counter (1+ (point-v dimensions)))
      (when (cell-selected-p view 0 cell-counter)
        (setf item-obj (nth cell-counter (table-sequence view))
              item-reference (item-ref item-obj))
        (drag-promise-item-flavor item-reference :|utxt|)  ; :|TEXT|)
        (drag-add-mcl-object-flavor item-reference $InternalCellFlavor item-obj)
        (when (and (>= cell-counter (point-v top-cell))
                   (<= cell-counter (point-v bottom-cell)))
          (let* ((upper-left (convert-coordinates (cell-position view 0 cell-counter)
                                                  superview
                                                  view))
                 (lower-right (add-points upper-left (cell-size view)))
                 (cell-region (new-region)))
            (unwind-protect
              (progn
                (set-rect-region cell-region upper-left lower-right)
                (drag-create-item-bounds view item-reference cell-region))
              (dispose-region cell-region)))))))
  t)

;; Need to override the rectangle that would create the drag hilite region.
;; If we didn't, the hilite would include the vertical scroll bar.
(defmethod drag-make-drag-hilite-region ((view drag-aware-sequence-view)
                                         &optional
                                         (topleft nil) (bottomright nil))
  (declare (ignore topleft bottomright))
  (let* ((adjusted-size (subtract-points (view-size view)
                                         (make-point 15 0)))
         (new-top-corner (convert-coordinates (make-point 0 0) view (view-window view)))
         (new-bottom-corner (convert-coordinates adjusted-size view (view-window view))))
    (call-next-method view new-top-corner new-bottom-corner)))

;; Deliver text flavor to the destination application.
(defmethod drag-fulfill-promise ((view drag-aware-sequence-view)
                                 (item-reference integer) (flavor (eql :|TEXT|))
                                 (target-description t))
  (let ((item-obj (%find-list-item view item-reference)))
    (when item-obj
      (let ((cell-string (item-string item-obj)))
        (with-cstrs ((text-ptr cell-string))
          (drag-set-item-flavor item-reference flavor text-ptr (length cell-string))))
      (when (eql (car target-description) :finder-trash)
        (let* ((item-pos (%list-item-position view item-reference))
               (pre-list (subseq (table-sequence view) 0 item-pos))
               (post-list (subseq (table-sequence view) (1+ item-pos))))
          (set-table-sequence view (append pre-list post-list))))
      t)))

(defmethod drag-fulfill-promise ((view drag-aware-sequence-view)
                                 (item-reference integer) (flavor (eql :|utxt|))
                                 (target-description t))
  (let ((item-obj (%find-list-item view item-reference)))
    (when item-obj
      (let* ((cell-string (item-string item-obj))
             (len (length cell-string)))
        (%stack-block ((text-ptr (+ len len)))
          (copy-string-to-ptr cell-string 0 len text-ptr)        
          (drag-set-item-flavor item-reference flavor text-ptr (+ len len))))
      (when (eql (car target-description) :finder-trash)
        (let* ((item-pos (%list-item-position view item-reference))
               (pre-list (subseq (table-sequence view) 0 item-pos))
               (post-list (subseq (table-sequence view) (1+ item-pos))))
          (set-table-sequence view (append pre-list post-list))))
      t)))

;; Yep, we always want to draw the insertion caret.
(defmethod drag-draw-caret-p ((view drag-aware-sequence-view))
  t)

;; This method is very, very ugly.  But it seems to work.  It figures out where to
;; draw the drag insertion caret, and while that happens it stashes away a hint
;; to the cell that will be inserted during a drop; the 'insert-cell slot of the
;; view will either contain the cell that will _follow_ the new cell or be nil,
;; indicating that the new cell should go at the end.  This slot is used in the
;; two #'drag-receive-dropped-flavor calls.  Note that the mouse coordinates are
;; moved to always be 10 pixels from the left edge of the cell; this avoids a
;; problem with the user dragging something over a scroll bar.
(defmethod drag-caret-position-from-mouse ((view drag-aware-sequence-view)
                                           local-mouse-position)
  (let* ((local-mouse (make-point 10 (point-v local-mouse-position)))
         (super-mouse (convert-coordinates local-mouse
                                           view
                                           (view-container view)))
         (cell-v-size (point-v (cell-size view)))
         (cell (point-to-cell view super-mouse))
         (next-cell (point-to-cell view (add-points super-mouse
                                                    (make-point 0 (floor cell-v-size 2)))))
         (last-cell (make-point 0 (1- (length (table-sequence view)))))
         (last-cell-pos (cell-position view last-cell))
         (caret-position nil))
    (if cell
      (cond ((and (neq cell next-cell)
                  (not next-cell)
                  (not last-cell-pos))
             (setf caret-position (make-point (point-h (cell-position view cell))
                                              (+ (point-v (cell-position view cell))
                                                 cell-v-size))
                   (insert-cell view) cell))
            ((and (neq cell next-cell)
                  (not next-cell))
             (setf caret-position (make-point (point-h last-cell-pos)
                                              (+ (point-v last-cell-pos)
                                                 cell-v-size))
                   (insert-cell view) nil))
            ((neq cell next-cell)
             (setf caret-position (cell-position view next-cell)
                   (insert-cell view) next-cell))
            (t
             (setf caret-position (cell-position view cell)
                   (insert-cell view) cell)))
      (cond ((not (table-sequence view))
             (setf caret-position (make-point 2 2)
                   (insert-cell view) nil)
             (convert-coordinates caret-position view (view-container view)))
            (t
             (setf caret-position (make-point (point-h last-cell-pos)
                                              (+ (point-v last-cell-pos)
                                                 cell-v-size))
                   (insert-cell view) nil))))
    (convert-coordinates caret-position (view-container view) view)))

;; Actually drop the caret.  Make it four pixels wide so people can see it.
(defmethod drag-draw-caret ((view drag-aware-sequence-view) local-position shown-p)
  (declare (ignore shown-p))
  (with-pen-saved
    (pen-normal view)
    (set-pen-pattern view *gray-pattern*)
    (set-pen-mode view :notPatXor)
    (set-pen-size view 4 4)
    (move-to view local-position)
    (line-to view
             (- (+ (point-h local-position) (point-h (cell-size view))) 4)
             (point-v local-position))))

;; We ignore left- and right-scrolling.
(defmethod drag-scroll-view ((view drag-aware-sequence-view) (direction-or-point keyword))
  (when (and (table-sequence view)
             (> (length (table-sequence view))
                (point-v (visible-dimensions view))))
    (let ((top-cell-v (point-v (scroll-position view)))
          (scroll-delta 0))
      (case direction-or-point
        (:up
         (if (plusp top-cell-v)
           (setf scroll-delta -1)))
        (:down
         (if (< (+ top-cell-v (point-v (visible-dimensions view)))
                (length (table-sequence view)))
           (setf scroll-delta 1))))
      (unless (zerop scroll-delta)
        (with-saved-drag-hilite (view)
          (scroll-to-cell view 0 (+ top-cell-v scroll-delta)))))
    t))

;; Receiving text at the indicated location.
(defmethod drag-receive-dropped-flavor ((view drag-aware-sequence-view)
                                        (flavor (eql :|TEXT|))
                                        (data-ptr macptr)
                                        (data-size integer)
                                        (item-reference integer))
  (declare (ignore item-reference))
  (let ((string-to-insert nil)
        (new-item nil))
    #+ccl-3 (setf string-to-insert (%str-from-ptr-in-script data-ptr data-size))
    #-ccl-3 (progn
              (setf string-to-insert (make-string data-size))
              (without-interrupts
               (dotimes (counter data-size)
                 (setf (char string-to-insert counter) (code-char (%get-byte data-ptr counter))))))
    (setf new-item (%create-list-item view string-to-insert))
    (if (insert-cell view)
      (let* ((v-insert (+ (point-v (insert-cell view))
                          (insert-offset view)))
             (pre-list (subseq (table-sequence view) 0 v-insert))
             (post-list (subseq (table-sequence view) v-insert)))
        (set-table-sequence view (append pre-list
                                         (list new-item)
                                         post-list)))
      (set-table-sequence view (append (table-sequence view)
                                       (list new-item))))
    (incf (insert-offset view))
    (cell-select view 0 (%list-item-position view new-item)))
  t)

(defmethod drag-receive-dropped-flavor ((view drag-aware-sequence-view)
                                        (flavor (eql :|utxt|))
                                        (data-ptr macptr)
                                        (data-size integer)
                                        (item-reference integer))
  (declare (ignore item-reference))
  (let ((string-to-insert nil)
        (new-item nil))
    (setq string-to-insert (make-string (ash data-size -1) :element-type 'extended-character))
    (copy-ptr-to-string data-ptr string-to-insert 0 data-size)
    (setf new-item (%create-list-item view string-to-insert))
    (if (insert-cell view)
      (let* ((v-insert (+ (point-v (insert-cell view))
                          (insert-offset view)))
             (pre-list (subseq (table-sequence view) 0 v-insert))
             (post-list (subseq (table-sequence view) v-insert)))
        (set-table-sequence view (append pre-list
                                         (list new-item)
                                         post-list)))
      (set-table-sequence view (append (table-sequence view)
                                       (list new-item))))
    (incf (insert-offset view))
    (cell-select view 0 (%list-item-position view new-item)))
  t)

;; Receiving internal data at the indicated location.  Note that "moves" are actually
;; insertions and deletions.
(defmethod drag-receive-dropped-flavor ((view drag-aware-sequence-view)
                                        (flavor (eql $InternalCellFlavor))
                                        (data-ptr t)
                                        (data-size t)
                                        (item-reference integer))
  (declare (ignore data-size))
  (let* ((copy-p (drag-copy-requested-p))
         (item-obj data-ptr)
         (new-item (%create-list-item view (item-string item-obj)))
         (the-sequence (table-sequence view)))
    (if (insert-cell view)
      (let* ((v-insert (+ (point-v (insert-cell view))
                          (insert-offset view)))
             (pre-list (subseq the-sequence 0 v-insert))
             (post-list (subseq the-sequence v-insert)))
        (setf the-sequence (append pre-list
                                   (list new-item)
                                   post-list)))
      (setf the-sequence (append the-sequence
                                 (list new-item))))
    (incf (insert-offset view))
    (unless (or copy-p
                (not (drag-within-sender-view-p)))
      ; this must be a move operation, so delete the originals
      (let* ((old-pos (position (item-ref item-obj) the-sequence :test #'eql :key #'item-ref))
             (pre-list (subseq the-sequence 0 old-pos))
             (post-list (subseq the-sequence (1+ old-pos))))
        (setf the-sequence (append pre-list post-list))
      (if (and (insert-cell view)
               (> (point-v (insert-cell view)) old-pos))
        (setf (insert-cell view) (make-point 0 (1- (point-v (insert-cell view))))))))
    (set-table-sequence view the-sequence)
    (cell-select view 0 (%list-item-position view new-item)))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Show the window...
;;;
(defun drag-aware-list ()
  (make-instance 'color-dialog
    :window-type :document
    :window-title "Drag-Aware List"
    :view-position #@(6 44)
    :view-size  #@(377 337)
    :view-font '("Chicago" 12 :srcor :plain #+ccl-3 (:color-index 0)
                 )
    :view-subviews (list (make-dialog-item 'drag-aware-sequence-view
                          #@(5 41)
                          #@(367 290)
                          ""
                          'nil
                          :view-nick-name 'string-list
                          :cell-size #@(352 16)
                          :selection-type
                          :disjoint
                          :table-print-function #'(lambda (c s)
                                                    (format s (%display-list-item c)))
                          :table-hscrollp nil
                          :table-vscrollp t
                          :table-sequence nil
                          ))))