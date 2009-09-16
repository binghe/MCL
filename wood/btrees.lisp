;;;-*- Mode: Lisp; Package: WOOD -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; btrees.lisp
;;; B* trees with variable length keys for pheaps.
;;;
;;; Copyright © 1996-1997 Digitool, Inc.
;;; Copyright © 1992-1995 Apple Computer, Inc.
;;; All rights reserved.
;;; Permission is given to use, copy, and modify this software provided
;;; that Digitool is given credit in all derivative works.
;;; This software is provided "as is". Digitool makes no warranty or
;;; representation, either express or implied, with respect to this software,
;;; its quality, accuracy, merchantability, or fitness for a particular
;;; purpose.
;;;

;;; Key size is limited to 127 bytes with longer keys
;;; being stored as strings (and requiring an extra disk access).
;;; (longer strings are not yet implemented).

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; 03/26/97 bill  check-btree-consistency avoids divide by zero errors.
;;; -------------  0.96
;;; 08/27/96 bill  Wrap an eval-when around the definition of *enable-debug-break* as
;;;                suggested by Rainer Joswig.
;;; -------------  0.95
;;; 05/13/96 bill  mis-parenthesization of compare-string in %btree-search-node
;;; -------------  0.94 = MCL-PPC 3.9
;;; 03/26/96 bill  Don't use %schar in %btree-search-node, MCL-PPC type checks it.
;;; 03/21/96 bill  Specify element-type of base-character to make-string calls
;;;                Add an optional swap-space-in-k arg to time-btree-store & time-btree-read
;;; -------------  0.93
;;; 08/10/95 bill  p-do-btree macro is to a btree what dolist is to a list.
;;; 07/02/95 bill  Fix fencepost in computation of fill-count in %shift-node-left
;;;                Thanks to Horace Enea for providing the test case to track down this bug.
;;; 05/25/95 bill  New parameter: *max-btree-node-size*.
;;;                dc-cons-btree-node calls dc-allocate-new-btree-node instead of
;;;                %dc-allocate-new-memory.
;;;                New function: dc-allocate-new-btree-node, calls %dc-allocate-new-memory
;;;                as before if the page size is <= *max-btree-node-size*. Otherwise, carves
;;;                up a disk page into *max-btree-node-size* nodes, returns one of them, and
;;;                adds the rest to the btree node free list.
;;; 04/11/95 bill  new function: p-map-btree-keystrings.
;;;                dc-map-btree uses compare-strings-function instead of string<
;;;                for comparing with the TO arg.
;;; -------------  0.9
;;; 02/06/95 bill  Moon's idea to add binary search to %btree-search-node without
;;;                changing the disk representation. That and doing the comparisons
;;;                inline got speed improvement of a factor of 2.7 over the old linear
;;;                search code.
;;; 12/16/94 bill  Complete rewrite of the low-level insertion code.
;;;                This fixes a bug found by Paul.Meurer@mi.uib.no and
;;;                will make much easier the addition of binary search for nodes.
;;; 10/28/94 Moon  Change without-interrupts to with-databases-locked.
;;; 10/25/94 bill  (setf (p-btree-store ...) x) now returns x instead of its pptr.
;;; 09/21/94 bill  without-interrupts as necessary for interlocking
;;; -------------  0.8
;;; 07/31/93 bill  %btree-insert-in-inner-node now goes out of line to
;;;                %attempt-to-shift-left-inner-node & %attempt-to-shift-right-inner-node.
;;;                %attempt-to-shift-right-inner-node is new code. I thought
;;;                that I could get away with leaving it out, but I was wrong.
;;; 03/29/93 bill  *forwarded-btree* in btree-find-leaf-node & dc-map-btree
;;; 03/25/93 bill  %btree-split-inner-node - wrong page on one of the accessing-byte-array's
;;;                Also, neglected to update last-middle-size when the parent entry went at the
;;;                end of the new middle node. In this case, some of the copying was also extraneous. 
;;; -------------- 0.6
;;; -------------- 0.5
;;; 07/28/92 bill  make p-map-btree deal correctly with insertion or
;;;                deletion while mapping.
;;; 07/27/92 bill  p-clear-btree, p-map-btree
;;; 06/30/92 bill  little bug in %split-btree-root
;;; 06/26/92 bill  btree vector indices defs -> woodequ
;;; 06/23/92 bill  Don't ignore type in p-make-btree
;;; -------------- 0.1
;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; To do:
;;;
;;; 1) Maybe.
;;;    Replace the $btree_parent slot with $btree_mod-count for locking use.
;;;    Updating parents at shift or split time is too expensive.
;;;    Instead, pass around an ancestors list (stack-consed).
;;;
;;; 2) Implement keys longer than 127 bytes.

(in-package :wood)

(export '(p-make-btree p-make-string-equal-btree 
          p-btree-lookup p-btree-store p-btree-delete
          dc-make-btree dc-btree-lookup dc-btree-store dc-btree-delete))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; btree vector - subtype $v_btree
;;;
;;; This code belongs in woodequ.lisp
;;;

; So this will work as a patch file
(eval-when (:compile-toplevel :execute :load-toplevel)

(unless (boundp '$btree.max-key-size)

(makunbound '$btree-size)

; Defined here so that this file can be distributed as a patch
; Real definition is in "woodequ.lisp"
(def-indices
  $btree.root                           ; the root node
  $btree.count                          ; number of leaf entries
  $btree.depth                          ; 0 means only the root exists
  $btree.nodes                          ; total number of nodes
  $btree.first-leaf                     ; first leaf node. A constant
  $btree.type                           ; type bits
  $btree.max-key-size                   ; maximum size of a key
  $btree-size                           ; length of a $v_btree vector
  )

)) ; End unless & compile-when

; This file is being distributed before the with-databases-locked macro
; is defined in "block-io-mcl.lisp"
(eval-when (:compile-toplevel :execute :load-toplevel)

(unless (fboundp 'with-databases-locked)
  (defmacro with-databases-locked (&body body)
    `(progn ,@body)))

)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Node layout - subtype $v_btree-node
;;;
;;;  -------------------
;;; | $vector-header    |
;;; | subtype length    |
;;; |-------------------|
;;; | link              |
;;; | parent            |
;;; | used free         |
;;; | count flags       |
;;; | pointer[0]        |
;;; | len[0] key[0] ... |
;;; | pointer[1]        |
;;; | len[1] key[1] ... |
;;; |        ...        |
;;; | pointer[m]        |
;;; | len[m] key[m] ... |
;;; | pointer[m+1]      |
;;;  -------------------

;;; $vector-header is the standard vector header marker
;;; subtype is one byte, it's value is $v_btree-node
;;; length is the total length of the data portion of the block in bytes
;;; link is used by the GC so that it can walk btree nodes last.
;;; parent points at the parent node of this one, or at the btree
;;;   uvector for the root.
;;; used is 16 bits: the number of bytes that are in use at $btree_data
;;; free is 16 bits: the number of free bytes at the end of the block.
;;; count is 16 bits: the number of entries in this node
;;; flags is 16 bits of flags.
;;;   Bit 0 is set for a leaf page.
;;;   Bit 1 is set for the root page.
;;; pointer[i] is 4 bytes aligned on a 4-byte boundary.
;;;   For a leaf node, it points at the indexed data.
;;;   For a non-leaf node, it points at another node in the tree
;;;     This node is the branch of the tree containing all entries whose
;;;     keys are <= key[i].
;;;   pointer[m+1] for a leaf node points to the next leaf node.
;;;     This makes a linked list of all the leaf nodes,
;;;     which is useful for mapping over the entries.
;;;   pointer[m+1] for a non-leaf node points at the branch of the tree
;;;     containing entries whose keys are > key[m]
;;; len[i] is a byte giving the length of key[i]
;;;   if len[i] is 255, then there are three unused bytes followed
;;;   by a four byte pointer to a string containing the key.
;;;   otherwise, len[i] will always be < 128
;;;   (keys longer than 127 bytes are not yet implemented)
;;; key[i] is len[i] bytes of characters for the key followed
;;;   by enough padding bytes to get to the next 4-byte boundary.

(defconstant $btree_link $v_data)
(defconstant $btree_parent (+ $btree_link 4))
(defconstant $btree_used (+ $btree_parent 4))
(defconstant $btree_free (+ $btree_used 2))
(defconstant $btree_count (+ $btree_free 2))
(defconstant $btree_flags (+ $btree_count 2))
(defconstant $btree_data (+ $btree_flags 2))

(defconstant $btree_flags.leaf-bit 0)
(defconstant $btree_flags.root-bit 1)

(defmacro with-simple-string ((var string) &body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda (,var) ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-simple-string ,string ,thunk))))

(defun funcall-with-simple-string (string thunk)
  (if (simple-string-p string)
    (funcall thunk string)
    (let* ((len (length string))
           (simple-string (make-string len :element-type 'base-character)))
      (declare (dynamic-extent simple-string))
      (multiple-value-bind (str offset) (ccl::array-data-and-offset string)
        (wood::%load-string str offset len simple-string))
      (funcall thunk simple-string))))

; Bound by the garbage collector. We won't type-check this
; btree as it's subtype has been overwritten with a forwarding pointer.
(defvar *forwarded-btree* nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; The documented interface
;;;

(defun p-make-btree (pheap &key area type)
  (pptr pheap
        (dc-make-btree (pheap-disk-cache pheap)
                       (and area (pheap-pptr-pointer area pheap))
                       (and type (require-type type 'fixnum)))))

(defun p-make-string-equal-btree (pheap &key area)
  (p-make-btree pheap :area area :type $btree-type_string-equal))

(defun p-btree-lookup (btree key-string &optional default)
  (let ((pheap (pptr-pheap btree)))
    (multiple-value-bind (pointer immediate? found?)
                         (dc-btree-lookup
                          (pheap-disk-cache pheap)
                          (pptr-pointer btree)
                          (if (stringp key-string)
                            key-string
                            (p-load key-string)))
      (if found?
        (values
         (if immediate?
           pointer
           (pptr pheap pointer))
         t)
        default))))

(defun p-btree-store (btree key-string default &optional (value default))
  (let ((pheap (pptr-pheap btree)))
    (multiple-value-bind (pointer immediate?)
                         (%p-store pheap value)
    (dc-btree-store
     (pheap-disk-cache pheap)
     (pptr-pointer btree)
     (if (stringp key-string)
       key-string
       (p-load key-string))
     pointer
     immediate?)
    (if immediate?
      pointer
      (pptr pheap pointer)))))

(defun setf-p-btree-lookup (btree key-string default &optional (value default))
  (p-btree-store btree key-string default value)
  value)

(defsetf p-btree-lookup setf-p-btree-lookup)

(defun p-btree-delete (btree key-string)
  (dc-btree-delete
   (pptr-disk-cache btree)
   (pptr-pointer btree)
   (if (stringp key-string)
     key-string
     (p-load key-string))))

(defun p-clear-btree (btree)
  (dc-clear-btree (pptr-disk-cache btree)
                  (pptr-pointer btree))
  btree)

(defmacro p-do-btree ((key value) (btree &optional from to) &body body)
  (let ((mapper (gensym)))
    `(let ((,mapper #'(lambda (,key ,value) ,@body)))
       (declare (dynamic-extent ,mapper))
       ,(if (or from to)
          `(p-map-btree ,btree ,mapper ,from ,to)
          `(p-map-btree ,btree ,mapper)))))

(defun p-map-btree (btree function &optional from to)
  (let* ((pheap (pptr-pheap btree))
         (f #'(lambda (disk-cache key value imm?)
                (declare (ignore disk-cache))
                (funcall function key (if imm? value (pptr pheap value))))))
    (declare (dynamic-extent f))
    (dc-map-btree (pheap-disk-cache pheap)
                  (pptr-pointer btree)
                  f
                  (if (or (null from) (stringp from))
                    from
                    (p-load from))
                  (if (or (null to) (stringp to))
                    to
                    (p-load to)))))

(defun p-map-btree-keystrings (btree function &optional from to)
  (let* ((pheap (pptr-pheap btree))
         (f #'(lambda (disk-cache key value imm?)
                (declare (ignore disk-cache value imm?))
                (funcall function key))))
    (declare (dynamic-extent f))
    (dc-map-btree (pheap-disk-cache pheap)
                  (pptr-pointer btree)
                  f
                  (if (or (null from) (stringp from))
                    from
                    (p-load from))
                  (if (or (null to) (stringp to))
                    to
                    (p-load to)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; disk-cache versions of the documented interface
;;;

(defun dc-make-btree (disk-cache &optional area type)
  (with-databases-locked
   (let* ((btree (dc-make-uvector disk-cache $btree-size $v_btree area 0 t))
          (root (dc-cons-btree-node
                 disk-cache btree btree
                 (logior (ash 1 $btree_flags.leaf-bit) (ash 1 $btree_flags.root-bit)))))
     (accessing-disk-cache (disk-cache)
       (svset.p btree $btree.root root)
       (svset.p btree $btree.first-leaf root)
       (when type
         (svset.p btree $btree.type (require-type type 'fixnum) t))
       (svset.p btree $btree.max-key-size 0))
     btree)))

(defun dc-btree-lookup (disk-cache btree key-string)
  (with-databases-locked
   (with-simple-string (key-string key-string)
     (multiple-value-bind (node offset eq)
                          (btree-find-leaf-node disk-cache btree key-string)
       (when eq
         (multiple-value-bind (pointer immediate?)
                              (read-pointer disk-cache (+ node offset))
           (values pointer immediate? t)))))))

(defun dc-btree-store (disk-cache btree key-string value &optional
                                       value-imm?)
  (with-databases-locked
   (with-simple-string (key-string key-string)
     (if (> (length key-string) 127)
       (error "Keys longer than 127 bytes not supported yet."))
     (multiple-value-bind (node offset eq)
                          (btree-find-leaf-node disk-cache btree key-string)
       (if eq
         (setf (read-pointer disk-cache (+ node offset) value-imm?)
               value)
         (progn
           (%btree-insert-in-node
            disk-cache btree node offset key-string value value-imm?)
           (accessing-disk-cache (disk-cache)
             (svset.p btree $btree.count (1+ (svref.p btree $btree.count)) t))
           (values value value-imm?)))))))

(defun dc-btree-delete (disk-cache btree key-string)
  (with-databases-locked
   (with-simple-string (key-string key-string)
     (if (> (length key-string) 127)
       (error "Keys longer than 127 bytes not supported yet."))
     (multiple-value-bind (node offset eq)
                          (btree-find-leaf-node disk-cache btree key-string)
       (when eq
         (%btree-delete-from-node disk-cache btree node offset t)
         (accessing-disk-cache (disk-cache)
           (svset.p btree $btree.count (1- (svref.p btree $btree.count)) t))
         t)))))

(defun dc-clear-btree (disk-cache btree)
  (require-satisfies dc-vector-subtype-p disk-cache btree $v_btree)
  (let (root-node first-leaf)
    (with-databases-locked
     (setq root-node (dc-%svref disk-cache btree $btree.root)
           first-leaf (dc-%svref disk-cache btree $btree.first-leaf))
     (accessing-disk-cache (disk-cache first-leaf)
       (multiple-value-bind (node used free) (init-btree-node disk-cache first-leaf)
         (declare (ignore node))
         (fill.b (+ $btree_data used) 0 free))
       (store.l btree $btree_parent)
       (store.w (logior (ash 1 $btree_flags.root-bit)
                        (ash 1 $btree_flags.leaf-bit)
                        (load.w $btree_flags))
             $btree_flags))
     (dc-%svfill disk-cache btree
       $btree.root first-leaf
       ($btree.count t) 0
       ($btree.count t) 0
       ($btree.nodes t) 1)
     (when (> (dc-uvsize disk-cache btree) $btree.max-key-size)         ; backward compatibility
       (setf (dc-%svref disk-cache btree $btree.max-key-size t) 0)))
    ; Eventually, rewrite dc-%clear-node to occasionally allow interrupts.
    (with-databases-locked
     (dc-%clear-node disk-cache root-node first-leaf)))
  btree)

(defun dc-%clear-node (disk-cache node first-leaf)
  (require-satisfies dc-vector-subtype-p disk-cache node $v_btree-node)
  (unless (eql node first-leaf)
    (with-locked-page (disk-cache node nil buf offset)
      (accessing-byte-array (buf offset)
        (unless (logbitp $btree_flags.leaf-bit (load.w $btree_flags))
          (let ((p $btree_data))
            (declare (fixnum p))
            (dotimes (i (load.w $btree_count))
              (dc-%clear-node disk-cache (load.l p) first-leaf)
              (incf p 4)
              (incf p (normalize-size (1+ (load.b p)) 4)))
            (dc-%clear-node disk-cache (load.l p) first-leaf)))
        (dc-free-btree-node disk-cache nil node)))))

; This assumes that actions at event-processing level don't change the
; B-tree (i.e. the may read the database but not write it), so we can
; release the database lock around the call to the user function.
; Otherwise the database would have to be locked across the entire operation.
; with-databases-locked is required around btree-find-leaf-node, because that
; function doesn't call with-databases-locked itself, and also because the
; with-locked-page below has a timing hazard (buf could be reused before
; the page has been locked) unless it is called inside with-databases-locked.
(defun dc-map-btree (disk-cache btree function &optional from to)
  (if (null from)
    (unless (eql btree *forwarded-btree*)
      (require-satisfies dc-vector-subtype-p disk-cache btree $v_btree))
    (unless (stringp from)
      (setq from (require-type from '(or null string)))))
  (unless (or (null to) (stringp to))
    (setq to (require-type to '(or null string))))
  (with-databases-locked
   (multiple-value-bind (node p)
                        (if from
                          (btree-find-leaf-node disk-cache btree from)
                          (values (dc-%svref disk-cache btree $btree.first-leaf)
                                  $btree_data))
     (declare (fixnum p))
     (let ((string-equal-function (string-equal-function disk-cache btree))
           (compare-strings-function (and to (compare-strings-function disk-cache btree))))
       (loop
         (block once-per-node
           (with-locked-page (disk-cache node nil buf buf-offset)
             (accessing-byte-array (buf buf-offset)
               (let ((max-p (+ $btree_data (load.w $btree_used) -4)))
                 (declare (fixnum max-p))
                 (loop
                   (when (>= p max-p)
                     (when (> p max-p)
                       (error "Inconsistency: pointer off end of btree node"))
                     (return))
                   (multiple-value-bind (value imm?) (load.p p)
                     (let* ((len (load.b (incf p 4)))
                            (key (make-string len :element-type 'base-character)))
                       (declare (fixnum len)
                                (dynamic-extent key))
                       (load.string (the fixnum (1+ p)) len key)
                       (when (and to (< (the fixnum (funcall compare-strings-function to key)) 0))
                         (return-from dc-map-btree nil))
                       (with-databases-unlocked
                         (funcall function disk-cache key value imm?))
                       (let ((newlen (load.b p)))
                         (declare (fixnum newlen))
                         (unless (and (eql newlen len)
                                      (let ((new-key (make-string newlen :element-type 'base-character)))
                                        (declare (dynamic-extent new-key))
                                        (load.string (the fixnum (1+ p)) newlen new-key)
                                        (funcall string-equal-function key new-key)))
                           ; The user inserted or deleted something that caused
                           ; the key to move. Need to find it again.
                           (let (eq)
                             (multiple-value-setq (node p eq)
                               (btree-find-leaf-node disk-cache btree key))
                             (when eq
                               (incf p (normalize-size (1+ len) 4)))
                             (return-from once-per-node))))
                       (incf p (normalize-size (1+ len) 4))))))
               (setq node (load.l p)
                     p $btree_data)
               (when (eql node $pheap-nil)
                 (return nil))))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Grungy internal details
;;; First, some generally useful utility functions
;;; 

(defparameter *max-btree-node-size* 512)

(defun dc-cons-btree-node (disk-cache btree parent flags)
  (let ((node (or (with-locked-page (disk-cache (+ $root-vector $v_data
                                                   (* 4 $pheap.btree-free-list)))
                    (accessing-disk-cache (disk-cache)
                      (let ((free-list (svref.p $root-vector $pheap.btree-free-list)))
                        (unless (eql $pheap-nil free-list)
                          (svset.p $root-vector $pheap.btree-free-list
                                   (accessing-disk-cache (disk-cache free-list)
                                     (load.l $btree_parent)))
                          free-list))))
                  (dc-allocate-new-btree-node disk-cache))))
    (accessing-disk-cache (disk-cache node)
      (store.l parent $btree_parent)
      (store.w flags $btree_flags))
    (with-locked-page (disk-cache (+ btree $v_data (* 4 $btree.nodes)) t)
      (accessing-disk-cache (disk-cache)
        (svset.p btree $btree.nodes (1+ (svref.p btree $btree.nodes)) t)))
    node))

; This takes care of chopping up a disk block into btree nodes.
; This is necessary if the page size is bigger than the *max-btree-node-size*.
; Otherwise, we just use one disk page.
(defun dc-allocate-new-btree-node (disk-cache)
  (let ((node (if (>= *max-btree-node-size* (disk-cache-page-size disk-cache))
                (%dc-allocate-new-memory disk-cache 1 $v_btree-node 0 t)
                ; Could do most of this size computation at pheap open time and cache the
                ; results, but it's in the noise compared to everything else.
                (let* ((segment (%dc-allocate-new-memory disk-cache 1 $v_segment nil))
                       (segment-size (dc-%vector-size disk-cache segment))
                       (segment-header-bytes (* 4 $segment-header-size))
                       (bytes (- segment-size segment-header-bytes))
                       (bytes-per-node *max-btree-node-size*)
                       (count (ceiling bytes bytes-per-node))
                       (size-per-node (- bytes-per-node $vector-header-size))
                       (first-node-bytes (- bytes (* (1- count) bytes-per-node)))
                       (first-node-size (- first-node-bytes $vector-header-size))
                       (ptr (+ segment $v_data segment-header-bytes))
                       res)
                  (dc-%svfill disk-cache segment
                    $segment.area $pheap-nil
                    $segment.header $pheap-nil)
                  (dotimes (i count)
                    (if (eql i 0)
                      (progn
                        (setq res (initialize-vector-storage
                                   disk-cache ptr first-node-size $v_btree-node 1 0 t))
                        (incf ptr first-node-bytes))
                      (progn
                        (dc-free-btree-node
                         disk-cache nil
                         (initialize-vector-storage
                          disk-cache ptr size-per-node $v_btree-node 1 nil))
                        (incf ptr bytes-per-node))))
                  (unless (eql (+ segment $v_data segment-size) ptr)
                    (error "ptr not at segment end"))
                  res))))
      (init-btree-node disk-cache node)))

(defun dc-free-btree-node (disk-cache btree node)
  (multiple-value-bind (node used free) (init-btree-node disk-cache node)
    (accessing-disk-cache (disk-cache node)
      (fill.b (+ $btree_data used) 0 free)))
  (with-locked-page (disk-cache $root-vector t)
    (accessing-disk-cache (disk-cache)
      (let ((free-list (svref.p $root-vector $pheap.btree-free-list)))
        (accessing-disk-cache (disk-cache node)
          (store.l free-list $btree_parent)))
      (svset.p $root-vector $pheap.btree-free-list node)))
  (when btree
    (with-locked-page (disk-cache (+ btree $v_data (* 4 $btree.nodes)) t)
      (accessing-disk-cache (disk-cache)
        (svset.p btree $btree.nodes (1- (svref.p btree $btree.nodes)) t)))))

(defun init-btree-node (disk-cache node)
  (accessing-disk-cache (disk-cache node)
    (let* ((vector-size (%vector-size.p node))
           (data-size (- vector-size (- $btree_data $v_data)))
           (used 4)
           (free (- data-size used)))
      (store.l $pheap-nil $btree_link)
      (store.w used $btree_used)
      (store.w free $btree_free)
      (store.w 0 $btree_count)
      (store.l $pheap-nil $btree_data)
      (values node used free))))

(defun %btree-leaf-node-p (disk-cache node)
  (accessing-disk-cache (disk-cache node)
    (logbitp $btree_flags.leaf-bit (load.w $btree_flags))))

(defun %btree-root-node-p (disk-cache node)
  (accessing-disk-cache (disk-cache node)
    (logbitp $btree_flags.root-bit (load.w $btree_flags))))

(defun compare-strings-function (disk-cache btree)
  (if (logbitp $btree-type_string-equal-bit
               (dc-%svref disk-cache btree $btree.type))
    #'compare-strings-case-insensitive
    #'compare-strings))

; New function
(defun compare-strings-case-insensitive (str1 str2)
  (cond ((string-lessp str1 str2) -1)
        ((string-equal str1 str2) 0)
        (t 1)))

; New function
(defun string-equal-function (disk-cache btree)
  (if (logbitp $btree-type_string-equal-bit
               (dc-%svref disk-cache btree $btree.type))
    #'string-equal
    #'string=))

; Returns two values:
; 1) offset - from node for the place where key-string goes
; 2) eq     - True if the key at this offset is key-string
(defun btree-find-leaf-node (disk-cache btree key-string)
  (unless (eql btree *forwarded-btree*)
    (require-satisfies dc-vector-subtype-p disk-cache btree $v_btree))
  (let ((node (dc-%svref disk-cache btree $btree.root))
        (case-sensitive? (not (logbitp $btree-type_string-equal-bit
                                       (dc-%svref disk-cache btree $btree.type)))))
    (loop
      (multiple-value-bind (offset eq)
                           (%btree-search-node
                            disk-cache node key-string case-sensitive?)
        (when (%btree-leaf-node-p disk-cache node)
          (return (values node offset eq)))
        (setq node (read-long disk-cache (+ node offset)))
        (require-satisfies dc-vector-subtype-p
                           disk-cache node $v_btree-node)))))

; This one calls the disk-cache code directly and accesses the
; page vector itself so that it can be reasonably fast.
; Returns same two values as btree-find-leaf-node
; plus a third value which is the offset to the node just to the left of the found one.


#| ; old linear search code
(defun %btree-search-node (disk-cache node key-string case-sensitive?)
  (let ((compare-strings-function (if case-sensitive? #'compare-strings #'compare-strings-case-insensitive)))
    (with-locked-page (disk-cache node nil vec offset bytes)
      (declare (fixnum offset bytes))
      (accessing-byte-array (vec offset)
        (let* ((end (+ offset $btree_data (load.uw $btree_used)))
               (ptr (+ offset $btree_data 4))
               (last-ptr nil))
          (declare (fixnum end ptr))
          (declare (fixnum offset bytes))
          (unless (>= (the fixnum (+ offset bytes)) end)
            (error "End of btree node is past end of disk page"))
          (loop
            (if (>= ptr end)
              (return (values (- ptr offset 4)
                              nil
                              (if last-ptr (- last-ptr offset 4)))))
            (let* ((len (aref vec ptr))
                   (str (make-string len :element-type 'base-character)))
              (declare (dynamic-extent str))
              (%copy-byte-array-portion vec (the fixnum (1+ ptr)) len str 0)
              ; Here's where we'll eventually use part of the
              ; $btree_flags to select a sorting predicate.
              (let ((compare (funcall compare-strings-function key-string str)))
                (declare (fixnum compare))
                (when (<= compare 0)
                  (return (values (- ptr offset 4) 
                                  (eql compare 0)
                                  (if last-ptr (- last-ptr offset 4))))))
              (setq last-ptr ptr)
              (incf ptr (normalize-size (+ 5 len) 4)))))))))
|#

; New binary search code: Moon's idea.
(defun %btree-search-node (disk-cache node key-string case-sensitive?)
  (with-locked-page (disk-cache node nil vec offset)
    (declare (fixnum offset)
             (type (simple-array (unsigned-byte 8) (*)) vec))
    (accessing-byte-array (vec)
      (let* ((count (load.uw (+ $btree_count offset)))
             (min 0)                    ; inclusive lower bound
             (max count)                ; exclusive upper bound
             (ptrs (make-array count))
             (lens (make-array count))
             (fill-pointer 0)           ; unlike Common Lisp, this is an inclusive upper bound
             (key-len (length key-string))
             (offset+4 (+ offset 4))
             (offset+5 (+ offset 5)))
        (declare (fixnum count min max fill-pointer offset+4 offset+5)
                 (dynamic-extent ptrs lens)
                 (simple-vector ptrs lens)
                 (optimize (speed 3) (safety 0)))
        (when (eql count 0)
          (return-from %btree-search-node $btree_data))
        (setf (svref ptrs 0) $btree_data
              (svref lens 0) (aref vec (the fixnum (+ $btree_data offset+4))))  ; (load.b (+ $btree_data offset 4))
        (flet ((get-ptr (index)
                 (declare (fixnum index))
                 (if (<= index fill-pointer)
                   (values (svref ptrs index) (svref lens index))
                   (let ((p (svref ptrs fill-pointer))
                         (len (svref lens fill-pointer)))
                     (declare (fixnum p len))
                     (loop
                         (incf p (the fixnum (normalize-size (the fixnum (+ 5 len)) 4)))
                         (setq len (aref vec (the fixnum (+ p offset+4))))     ;  (load.b (+ p 4 offset))
                         (setf (svref ptrs (incf fill-pointer)) p)
                         (setf (svref lens fill-pointer) len)
                         (when (eql fill-pointer index)
                           (return (values p len)))))))
               (compare-strings (s1 i1 end1 s2 i2 end2 case-sensitive?)
                 (declare (fixnum i1 end1 i2 end2)
                          (type (simple-array (unsigned-byte 8) (*)) s1 s2)
                          (optimize (speed 3) (safety 0)))
                 ; s1 is a simple string and s2 is a (simple-array (unsigned-byte 8) (*))
                 ; Since these are stored the same way in memory, we can assume
                 ; That both are (unsigned-byte 8) or both are simple strings and
                 ; the inline code will work.
                 ; (Unfortunatedly, PPC MCL does not inline %schar, so we need to use aref
                 ; instead).
                 (if case-sensitive?
                   (loop
                     (when (>= i1 end1)
                       (return (if (eql i2 end2) 0 -1)))
                     (when (>= i2 end2) (return 1))
                     (let ((c1 (aref s1 i1))
                           (c2 (aref s2 i2)))
                       (declare (fixnum c1 c2))
                       (if (<= c1 c2)
                         (if (< c1 c2)
                           (return -1))
                         (return 1)))
                     (incf i1)
                     (incf i2))
                   (loop
                     (when (>= i1 end1)
                       (return (if (eql i2 end2) 0 -1)))
                     (when (>= i2 end2) (return 1))
                     (let ((c1 (ccl::%char-code (char-upcase (ccl::%code-char (aref s1 i1)))))
                           (c2 (ccl::%char-code (char-upcase (ccl::%code-char (aref s2 i2))))))
                       (declare (fixnum c1 c2))
                       (if (<= c1 c2)
                         (if (< c1 c2)
                           (return -1))
                         (return 1)))
                     (incf i1)
                     (incf i2)))))
          (declare (inline get-ptr compare-strings))
          (loop
            (let ((index (ash (the fixnum (+ min max)) -1)))
              (declare (fixnum index))
              (multiple-value-bind (ptr len) (get-ptr index)
                (declare (fixnum ptr len))
                (let* ((vec-idx (+ ptr (the fixnum offset+5)))
                       (vec-end (+ vec-idx len))
                       (compare (compare-strings key-string 0 key-len vec vec-idx vec-end case-sensitive?)))
                  (declare (fixnum vec-idx vec-end compare))
                  (if (<= compare 0)
                    (progn
                      (setq max index)
                      (when (or (eql compare 0) (eql min max))
                        (return (values ptr
                                        (eql compare 0)
                                        (unless (eql index 0)
                                          (svref ptrs (the fixnum (1- index))))))))
                    (progn
                      (setq min (1+ index))
                      (when (eql min max)
                        (return (values (the fixnum (+ ptr (normalize-size (the fixnum (+ 5 len)) 4)))
                                        nil
                                        ptr))))))))))))))

(defun compare-strings (str1 str2)
  (cond ((string< str1 str2) -1)
        ((string= str1 str2) 0)
        (t 1)))

; Search a node for a pointer to a subnode.
; Return two values, the offset for the subnode, and the offset
; for the subnode just before it.
; If right-node-p is true, return a third value, the offset of the subnode
; just after subnode.
(defun %btree-search-for-subnode (disk-cache node subnode &optional right-node-p)
  (with-locked-page (disk-cache node nil vec offset bytes)
    (declare (fixnum offset bytes))
    (accessing-byte-array (vec offset)
      (let* ((end (+ offset $btree_data (load.uw $btree_used)))
             (ptr (+ offset $btree_data))
             (last-ptr nil))
        (declare (fixnum end ptr))
        (declare (fixnum offset bytes))
        (unless (>= (the fixnum (+ offset bytes)) end)
          (error "End of btree node is past end of disk page"))
        (accessing-byte-array (vec)
          (loop
            (when (eql subnode (load.p ptr))
              (return (values (- ptr offset)
                              (if last-ptr (- last-ptr offset))
                              (when right-node-p
                                (let ((right-ptr (+ ptr 4)))
                                  (declare (fixnum right-ptr))
                                  (unless (>= right-ptr end)
                                    (incf right-ptr (normalize-size (1+ (load.b right-ptr)) 4))
                                    (- right-ptr offset)))))))
            (setq last-ptr ptr)
            (incf ptr 4)
            (if (>= ptr end)
              (return nil))
            (incf ptr (normalize-size (1+ (load.b ptr)) 4))))))))

; Fill the SIZES array with the sizes of the entries in NODE.
; If one of the entries is at INSERT-OFFSET, put INSERT-SIZE
; into SIZES at that index, and return the index.
; Otherwise, return NIL.
(defun %lookup-node-sizes (disk-cache node sizes count &optional insert-offset insert-size
                                      (start 0))
  (accessing-disk-cache (disk-cache node)
    (unless count
      (setq count (load.uw $btree_count)))
    (when insert-offset (incf count))
    (let ((p (+ $btree_data 4))
          (p-at-offset (and insert-offset (+ insert-offset 4)))
          insert-index
          (index (require-type start 'fixnum)))
      (declare (fixnum p))
      (dotimes (i count)
        (if (eql p p-at-offset)
          (setf (aref sizes index) insert-size
                insert-index index
                p-at-offset nil)
          (incf p (setf (aref sizes index) (normalize-size (+ 5 (load.b p)) 4))))
        (incf index))
      (when (and insert-offset (null insert-index))
        (error "Inconsistency: didn't find insert-offset"))
      (unless (eql p (+ $btree_data (load.uw $btree_used)))
        (error "Inconsistency: walking node's entries didn't end up at end"))
      insert-index)))

; When we move entries around in a non-leaf nodes, the parent pointers
; need to be updated.
; This will go away if I eliminate the parent pointers and replace
; them with passing around the ancestor list.
; Doing this will make insertion and deletion slightly faster
; at the expense of making it hard to click around in a btree
; in the inspector.
(defun %btree-update-childrens-parents (disk-cache node &optional start-ptr end-ptr)
  (with-locked-page (disk-cache node nil node-buf node-buf-offset)
    (accessing-byte-array (node-buf)
      (let* ((used (load.uw (+ node-buf-offset $btree_used)))
             (p (or start-ptr (+ node-buf-offset $btree_data)))
             (max-p (or end-ptr (+ node-buf-offset $btree_data used)))
             child)
        (declare (fixnum p max-p))
        (loop
          (setq child (load.p p))
          (require-satisfies dc-vector-subtype-p disk-cache child $v_btree-node)
          (accessing-disk-cache (disk-cache child)
            (store.p node $btree_parent))
          (incf p 4)
          (when (>= p max-p)
            (unless (eql p max-p)
              (error "Inconsistency. Node scan went past expected end."))
            (return))
          (incf p (normalize-size (+ 1 (load.b p)) 4)))))))

; Update and return the maximum key size
(defun dc-btree-max-key-size (disk-cache btree &optional new-size)
  (when new-size
    (setq new-size (require-type new-size 'fixnum)))
  (if (<= (dc-uvsize disk-cache btree) $btree.max-key-size)
    132                                 ; old btrees don't track max key size
    (let ((size (dc-%svref-fixnum disk-cache btree $btree.max-key-size "$btree.max-key-size")))
      (if (and new-size (> new-size size))
        (setf (dc-%svref disk-cache btree $btree.max-key-size t) new-size)
        size))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Here's where the guts of an insert happens.
;; We know that the key-string belongs at offset from node.
;; Insert it there if it fits.
;; Otherwise split this node into two after creating room in each
;; node in the access path.
;;

(defun %btree-insert-in-node (disk-cache btree node offset key-string value
                                             &optional value-imm? (key-length (length key-string)))
  (accessing-disk-cache (disk-cache node)
    (let* ((free (load.uw $btree_free))
           (used (load.uw $btree_used))
           (size (normalize-size (+ 5 key-length) 4))
           (max-key-size (dc-btree-max-key-size disk-cache btree size)))        ; update & get max key size
      (declare (fixnum free used size))
      (if (> key-length 127)
        (error "Keys longer than 127 not supported yet."))
      (when (<= size free)
        ; Will fit in this node
        (with-locked-page (disk-cache node t node-buf node-buf-offset nil node-page)
          (let* ((bytes-to-move (- used (- offset $btree_data)))
                 (p (+ node-buf-offset offset)))
            (declare (fixnum bytes-to-move p))
            (%copy-byte-array-portion node-buf p bytes-to-move
                                      node-buf (+ p size) node-page)
            (%store-btree-entry
             node-buf p node-page
             key-string key-length value value-imm? size)
            (accessing-byte-array (node-buf node-buf-offset node-page)
              (store.w (1+ (load.uw $btree_count)) $btree_count)
              (store.w (+ used size) $btree_used)
              (store.w (- free size) $btree_free))))
        (return-from %btree-insert-in-node nil))
      ; Won't fit. Split the node
      (unless (%btree-leaf-node-p disk-cache node)
        (error "Wasn't room to insert in non-leaf node"))
      (%create-insertion-path disk-cache btree key-string max-key-size)
      (%split-node disk-cache btree node free used
                   t offset key-string value value-imm? key-length size)
      ; This slightly increases non-leaf node space utilization, but
      ; at a 10% time penalty, so I've nuked it.
      ;(%sew-up-insertion-path disk-cache btree node t)
      )))

(eval-when (:load-toplevel :compile-toplevel :execute)

(defvar *enable-debug-break* nil)

)  ; end of eval-when

(defmacro debug-break (format-string &rest format-args)
  (when *enable-debug-break*
    `(%debug-break ,format-string ,@format-args)))

(defun %debug-break (format-string &rest format-args)
  (when *enable-debug-break*
    (let ((*print-base* 16.))
      (apply 'cerror "Continue" format-string format-args))))

; There is an important difference between the leaf and non-leaf nodes.
; When entries are shifted between leaf nodes, the parent node does not
; need to be referenced except to update it with the last key in the
; left-hand leaf node. When non-leaf nodes are shifted, the shifting needs
; to go through the parent node, i.e. the key in the parent that is between
; the keys in the left child and the right child does not appear in either child
; and needs to move to one of them. After we're done, the parent will have
; a new key that used to be in one of its children but isn't any more.

(defun %split-node (disk-cache btree node free used leaf-p &optional
                      offset key-string value value-imm? key-length (size 0))
  (when (%shift-node-left disk-cache btree node free used leaf-p
                          offset key-string value value-imm? key-length size)
    (return-from %split-node :shift-left))
  (when (%shift-node-right disk-cache btree node free used leaf-p
                          offset key-string value value-imm? key-length size)
    (return-from %split-node :shift-right))
  (with-locked-page (disk-cache node t node-buf node-buf-offset nil node-page)
    (accessing-byte-array (node-buf node-buf-offset node-page)
      (let* ((parent (load.p $btree_parent))
             (old-count (load.uw $btree_count))
             (count (if offset (1+ old-count) old-count))
             (sizes (make-array count))
             (insert-index (%lookup-node-sizes disk-cache node sizes old-count offset size))
             (new-used (+ used size))
             (last-new-used 0)
             (new-count 0)
             (last-size 0)
             (right-node (dc-cons-btree-node 
                          disk-cache btree parent (if leaf-p (ash 1 $btree_flags.leaf-bit) 0)))
             (right-used 4)
             (last-right-used 0)
             (right-count 0)
             (last-last-size 0))
        (declare (fixnum old-count count new-used new-count last-size right-used right-count
                         last-new-used last-right-used last-last-size)
                 (dynamic-extent sizes))
        (loop for i from (1- count) downto 0
              finally (error "Didn't find a split point")
              do
              (setq last-new-used new-used
                    last-right-used right-used
                    last-last-size last-size)
              (if leaf-p
                (progn
                  (incf right-used (setq last-size (aref sizes i)))
                  (decf new-used last-size))
                (progn
                  (incf right-used last-last-size)
                  (decf new-used (setq last-size (aref sizes i)))))
              (when (>= right-used new-used)
                (setq new-count i)
                (let ((diff (- right-used new-used))
                      (old-diff (- last-new-used last-right-used)))
                  (when (> diff old-diff)
                    (setq new-used last-new-used
                          right-used last-right-used
                          new-count (1+ i))))
                (setq last-size (aref sizes (1- new-count)))
                (return)))
        (debug-break "after figuring where to put split")
        (with-locked-page (disk-cache right-node t right-buf right-offset nil right-page)
          (setq right-count (- count new-count (if leaf-p 0 1)))
          (let* ((insert-middle (if leaf-p
                                  (eql insert-index (1- new-count))
                                  (eql insert-index new-count)))
                 (insert-left (and insert-index (< insert-index new-count)))
                 (insert-not-right (or (not insert-index) insert-middle insert-left))
                 (end-ptr (+ node-buf-offset $btree_data new-used))
                 (node-ptr (- end-ptr
                              (if insert-left size 0)
                              (if leaf-p last-size 0)))
                 (last-string-length (if insert-middle
                                       key-length
                                       (accessing-byte-array (node-buf) (load.b node-ptr))))
                 (last-string (make-string last-string-length :element-type 'base-character)))
            (declare (fixnum end-ptr node-ptr last-string-length)
                     (dynamic-extent last-string))
            (debug-break "About to fill last-string")
            (if insert-middle
              (setq last-string key-string)
              (%copy-byte-array-portion node-buf (1+ node-ptr) last-string-length
                                        last-string 0))
            (if insert-not-right
              ; New entry goes in node or there is no new entry & this is a non-leaf node
              (let ((bytes-to-shift 0))
                (declare (fixnum bytes-to-shift))
                (setq node-ptr (- (+ node-buf-offset $btree_data used) right-used))
                (debug-break "Before first copy-byte-array-portion")
                (%copy-byte-array-portion
                 node-buf node-ptr right-used right-buf (+ right-offset $btree_data) right-page)
                (when insert-left
                  (setq node-ptr (+ node-buf-offset offset)
                        bytes-to-shift (- new-used (- offset $btree_data) size))
                  (debug-break "About to open up node")
                  (%copy-byte-array-portion
                   node-buf node-ptr bytes-to-shift node-buf (+ node-ptr size))
                  (%store-btree-entry node-buf node-ptr node-page
                                      key-string key-length value value-imm? size)))
              ; New entry goes in right-node. leaf-p is true.
              (let* ((bytes-to-copy (- right-used size))
                     (bytes-before-offset (- offset $btree_data (- new-used 4)))
                     (bytes-after-offset (- bytes-to-copy bytes-before-offset))
                     (right-ptr (+ right-offset $btree_data)))
                (declare (fixnum bytes-to-copy bytes-before-offset bytes-after-offset right-ptr))
                (setq node-ptr (- (+ node-buf-offset $btree_data used) bytes-to-copy))
                (debug-break "Before first copy-byte-array-portion when insert goes right")
                (%copy-byte-array-portion
                 node-buf node-ptr bytes-before-offset right-buf right-ptr right-page)
                (incf node-ptr bytes-before-offset)
                (incf right-ptr bytes-before-offset)
                (%store-btree-entry right-buf right-ptr right-page
                                    key-string key-length value value-imm? size)
                (incf right-ptr size)
                (%copy-byte-array-portion
                 node-buf node-ptr bytes-after-offset right-buf right-ptr right-page)))
          (accessing-byte-array (node-buf nil node-page)
            (let ((parent-offset (%btree-search-for-subnode disk-cache parent node)))
              (unless parent-offset
                (error "Couldn't find node ~s in parent node ~s" node parent))
              (setq node-ptr (+ node-buf-offset $btree_data new-used -4))
              (debug-break "About to fix up node")
              (if leaf-p
                (store.p right-node node-ptr)
                (when insert-middle
                  (store.p value node-ptr value-imm?)))
              (incf node-ptr 4)
              (accessing-disk-cache (disk-cache parent)
                (store.p right-node parent-offset))
              (fill.b node-ptr 0 (- used new-used))
              (debug-break "About to insert in parent node")
              (%btree-insert-in-node
               disk-cache btree parent parent-offset last-string node nil last-string-length))))
          (accessing-byte-array (node-buf node-buf-offset node-page)
            (store.w new-count $btree_count)
            (store.w (- (+ free used) new-used) $btree_free)
            (store.w new-used $btree_used))
          (accessing-byte-array (right-buf right-offset right-page)
            (store.w right-count $btree_count)
            (let ((total (+ (load.uw $btree_used) (load.uw $btree_free))))
              (store.w (- total right-used) $btree_free)
              (store.w right-used $btree_used)))
          (unless leaf-p
            (%btree-update-childrens-parents disk-cache right-node))
          (debug-break "Done with %split-node")))
      :split)))

; Attempt to shift the node left enough to make room for the new key-string
; Works for non-leaf-nodes as well
; Non-leaf nodes are harder since the shifting has to go through the parent.
; This function exists because without it the space utilization is only 51%.
; There is guaranteed (due to %create-insertion-path) to be enough room in the parent.
; Returns true if it succeeded.
; Otherwise, makes no changes and returns nil.
(defun %shift-node-left (disk-cache btree node free used leaf-p
                                       offset key-string value value-imm? key-length size)
  ;(let ((*enable-debug-break* (not leaf-p)))
  (unless offset
    ; If we're not inserting, we need to make room for the maximum node size
    (setq size (dc-btree-max-key-size disk-cache btree)))
  (unless (%btree-root-node-p disk-cache node)
    (with-locked-page (disk-cache node t node-buf node-buf-offset nil node-page)
      (declare (fixnum node-buf-offset))
      (accessing-byte-array (node-buf node-buf-offset node-page)
        (let* ((parent (load.p $btree_parent)))
          (multiple-value-bind (node-offset left-offset)
                               (%btree-search-for-subnode disk-cache parent node)
            (when left-offset
              (let* ((left-node (accessing-disk-cache (disk-cache parent) (load.p left-offset)))
                     (left-free (accessing-disk-cache (disk-cache left-node) (load.uw $btree_free)))
                     (new-left-free left-free)
                     (left-used (accessing-disk-cache (disk-cache left-node) (load.uw $btree_used)))
                     (new-left-used left-used)
                     (new-free free)
                     (new-used used)
                     (count (load.uw $btree_count))
                     (sizes (make-array (the fixnum (1+ count))))
                     (bytes-moved 0)
                     (bytes-received 0)
                     (bytes-needed (- size free))
                     (bytes-to-offset (if offset (- offset $btree_data) most-positive-fixnum))
                     (count-diff 0)
                     (last-shifted-entry-size 0)
                     (initial-parent-size (- node-offset left-offset))
                     (parent-size initial-parent-size)
                     (new-parent-size (if leaf-p 0 parent-size)))
                (declare (fixnum left-free new-left-free left-used new-left-used
                                 free new-free used new-used count
                                 bytes-moved bytes-needed bytes-to-offset
                                 count-diff last-shifted-entry-size
                                 initial-parent-size parent-size new-parent-size)
                         (dynamic-extent sizes))
                (%lookup-node-sizes disk-cache node sizes count)
                (with-locked-page (disk-cache left-node t left-buf left-buf-offset nil left-page)
                  (declare (fixnum left-buf-offset))
                  (with-locked-page (disk-cache parent t parent-buf parent-buf-offset nil parent-page)
                    (declare (fixnum parent-buf-offset))
                    (labels ((shift-left (new-entry-in-node)
                               (decf new-used bytes-moved)
                               (incf new-free bytes-moved)
                               (incf new-left-used bytes-received)
                               (decf new-left-free bytes-received)
                               (let* ((node-ptr (+ node-buf-offset $btree_data))
                                      (left-ptr (+ left-buf-offset $btree_data left-used -4))
                                      (bytes-to-last-string (+ (- bytes-moved last-shifted-entry-size) 4))
                                      (bytes-to-copy (if (or leaf-p (not new-entry-in-node))
                                                       bytes-moved
                                                       bytes-to-last-string)))
                                 (declare (fixnum node-ptr left-ptr bytes-to-last-string bytes-to-copy))
                                 (debug-break "About to copy bytes left")
                                 (unless leaf-p
                                   (let ((parent-ptr (+ left-offset parent-buf-offset 4))
                                         (parent-bytes (- parent-size 4)))
                                     (declare (fixnum parent-ptr parent-bytes))
                                     (incf left-ptr 4)
                                     (%copy-byte-array-portion parent-buf parent-ptr parent-bytes
                                                               left-buf left-ptr left-page)
                                     (incf left-ptr parent-bytes)))
                                 (%copy-byte-array-portion node-buf node-ptr bytes-to-copy
                                                           left-buf left-ptr left-page)
                                 (incf left-ptr bytes-to-copy)
                                 (when leaf-p
                                   (accessing-byte-array (left-buf nil left-page)
                                     (store.p node left-ptr)))
                                 (if new-entry-in-node
                                   (let ((node-ptr (+ node-ptr bytes-to-last-string))
                                         (parent-ptr (open-parent last-shifted-entry-size)))
                                     (declare (fixnum node-ptr parent-ptr))
                                     (debug-break "About to copy node to parent")
                                     (%copy-byte-array-portion node-buf node-ptr (- last-shifted-entry-size 4)
                                                               parent-buf parent-ptr parent-page))
                                   (let* ((parent-ptr (open-parent size))
                                          (key-size (1+ key-length))
                                          (fill-count (- (normalize-size key-size 4) key-size)))
                                     (declare (fixnum parent-ptr key-size fill-count))
                                     (debug-break "About to enter key-string in parent")
                                     (accessing-byte-array (parent-buf 0 parent-page)
                                       (store.b key-length parent-ptr))
                                     (incf parent-ptr)
                                     (%copy-byte-array-portion key-string 0 key-length
                                                               parent-buf parent-ptr  parent-page)
                                     (incf parent-ptr key-length)
                                     (unless (eql 0 fill-count)
                                       (accessing-byte-array (parent-buf 0 parent-page)
                                         (fill.b parent-ptr 0 fill-count)))))
                                 (debug-break "About to shift node contents left")
                                 (%copy-byte-array-portion node-buf (+ node-ptr bytes-moved) new-used
                                                           node-buf node-ptr node-page)
                                 (incf node-ptr new-used)
                                 (accessing-byte-array (node-buf nil node-page)
                                   (fill.b node-ptr 0 bytes-moved))
                                 (debug-break "Exiting shift-left")
                                 ))
                             (update-free-and-used ()
                               (accessing-byte-array (node-buf node-buf-offset node-page)
                                 (store.w new-used $btree_used)
                                 (store.w new-free $btree_free)
                                 (store.w (- (load.uw $btree_count) count-diff) $btree_count))
                               (accessing-byte-array (left-buf left-buf-offset left-page)
                                 (store.w new-left-used $btree_used)
                                 (store.w new-left-free $btree_free)
                                 (store.w (+ (load.uw $btree_count) count-diff) $btree_count))
                               (unless leaf-p
                                 (%btree-update-childrens-parents
                                  disk-cache left-node (+ left-buf-offset $btree_data left-used initial-parent-size -4)))
                               (debug-break "Free and used updated")
                               )
                             (open-parent (size)
                               (accessing-byte-array (parent-buf parent-buf-offset parent-page)
                                 (let* ((old-size (- node-offset left-offset))
                                        (size-diff (- old-size size))
                                        (parent-used (load.uw $btree_used))
                                        (parent-free (load.uw $btree_free))
                                        (ptr (+ parent-buf-offset node-offset))
                                        (bytes-to-move (- parent-used (- node-offset $btree_data))))
                                   (declare (fixnum old-size size-diff parent-used parent-free
                                                    ptr bytes-to-move))
                                   (unless (eql size-diff 0)
                                     (debug-break "About to shift parent tail")
                                     (%copy-byte-array-portion
                                      parent-buf ptr bytes-to-move
                                      parent-buf (- ptr size-diff) parent-page)
                                     (when (> size-diff 0)
                                       (incf ptr (- bytes-to-move size-diff))
                                       (accessing-byte-array (parent-buf nil parent-page)
                                         (fill.b ptr 0 size-diff)))
                                     (store.w (- parent-used size-diff) $btree_used)
                                     (store.w (+ parent-free size-diff) $btree_free))
                                   (+ parent-buf-offset left-offset 4)))))
                      (declare (dynamic-extent #'shift-left #'update-free-and-used
                                               #'open-parent))
                      (dotimes (i count (error "Didn't run over offset"))
                        (when (>= bytes-received left-free)
                          ; Ran out of room in left node
                          (return nil))
                        (when (>= bytes-moved bytes-needed)
                          ; The new entry now fits in node
                          (setq count-diff i)
                          (shift-left t)
                          (update-free-and-used)
                          (when offset
                            (%btree-insert-in-node disk-cache btree node (- offset bytes-moved)
                                                   key-string value value-imm? key-length))
                          (debug-break "Done with insertion in node")
                          ;                       #+bill (check-btree-consistency disk-cache btree)
                          (return t))
                        (when (>= bytes-moved bytes-to-offset)
                          (unless (eql bytes-moved bytes-to-offset)
                            (error "Inconsistency: offset was not at an entry boundary"))
                          (unless (or (not leaf-p) (>= new-left-free (+ size bytes-received)))
                            (debug-break "Couldn't shift left")
                            (return nil))
                          ; The new entry fits at the end of left-node
                          (setq count-diff i)
                          (shift-left nil)
                          (when leaf-p
                            (let ((left-ptr (+ left-buf-offset $btree_data new-left-used -4)))
                              (declare (fixnum left-ptr))
                              (debug-break "Storing new entry in left neighbor")
                              (%store-btree-entry left-buf left-ptr left-page
                                                  key-string key-length value value-imm? size)
                              (incf left-ptr size)
                              (accessing-byte-array (left-buf)
                                (store.p node left-ptr))
                              (incf new-left-used size)
                              (decf new-left-free size)
                              (accessing-byte-array (left-buf left-buf-offset)
                                (store.w (1+ (load.uw $btree_count)) $btree_count))))
                          (update-free-and-used)
                          (debug-break "Done with insertion in left neighbor")
                          ;#+bill (check-btree-consistency disk-cache btree)
                          (return t))
                        (setq last-shifted-entry-size (aref sizes i))
                        (if leaf-p
                          (progn
                            (incf bytes-moved last-shifted-entry-size)
                            (incf bytes-received last-shifted-entry-size))
                          (progn
                            (incf bytes-moved last-shifted-entry-size)
                            (incf bytes-received new-parent-size)
                            (setq new-parent-size last-shifted-entry-size)))))))))))))))


; Attempt to shift the node right enough to make room for the new key-string
; This is necessary because inserting in reverse order foils %shift-node-left
; This doesn't handle the non-leaf case yet. It's hardly worth it.
(defun %shift-node-right (disk-cache btree node free used leaf-p
                             offset key-string value value-imm? key-length size)
  (declare (fixnum free used offset key-length))
  ;(return-from %shift-node-right nil)   ; not yet debugged.
  (when (and leaf-p (not (%btree-root-node-p disk-cache node)))
    (with-locked-page (disk-cache node t node-buf node-buf-offset nil node-page)
      (accessing-byte-array (node-buf node-buf-offset node-page)
        (let* ((parent (load.p $btree_parent)))
          (multiple-value-bind (node-offset left-offset right-offset)
                               (%btree-search-for-subnode disk-cache parent node t)
            (declare (ignore left-offset))
            (when right-offset
              (let* ((right-node (accessing-disk-cache (disk-cache parent) (load.p right-offset)))
                     (right-free (accessing-disk-cache (disk-cache right-node) (load.uw $btree_free)))
                     (new-right-free right-free)
                     (right-used (accessing-disk-cache (disk-cache right-node) (load.uw $btree_used)))
                     (new-right-used right-used)
                     (new-free free)
                     (new-used used)
                     (count (load.uw $btree_count))
                     (sizes (make-array (the fixnum (1+ count))))
                     (bytes-moved 0)
                     (bytes-needed (- size free))
                     (bytes-to-offset (- used (- offset $btree_data) 4))
                     (count-diff 0))
                (declare (fixnum right-length right-offset right-free new-right-free
                                 right-used new-right-used new-free new-used count
                                 bytes-moved bytes-needed bytes-to-offset
                                 count-diff last-shifted-entry-size)
                         (dynamic-extent sizes))
                (%lookup-node-sizes disk-cache node sizes count)
                (with-locked-page (disk-cache right-node t right-buf right-buf-offset nil right-page)
                  (flet ((shift-right (&optional (new-entry-size 0))
                           (decf new-used bytes-moved)
                           (incf new-free bytes-moved)
                           (incf new-right-used bytes-moved)
                           (decf new-right-free bytes-moved)
                           (let ((node-ptr (+ node-buf-offset $btree_data new-used -4))
                                 (right-ptr (+ right-buf-offset $btree_data)))
                             (declare (fixnum node-ptr right-ptr))
                             (debug-break "About to copy bytes right")
                             (%copy-byte-array-portion right-buf right-ptr right-used
                                                       right-buf
                                                       (+ right-ptr new-entry-size bytes-moved)
                                                       right-page)
                             (incf right-ptr new-entry-size)
                             (%copy-byte-array-portion node-buf node-ptr bytes-moved
                                                       right-buf right-ptr right-page)
                             (accessing-byte-array (node-buf nil node-page)
                               (store.p right-node node-ptr))
                             (incf node-ptr 4)
                             (accessing-byte-array (node-buf nil node-page)
                               (fill.b node-ptr 0 bytes-moved))
                             (debug-break "Exiting shift-right")
                             ))
                         (update-free-and-used ()
                           (accessing-byte-array (node-buf node-buf-offset node-page)
                             (store.w new-used $btree_used)
                             (store.w new-free $btree_free)
                             (store.w (- (load.uw $btree_count) count-diff) $btree_count))
                           (accessing-byte-array (right-buf right-buf-offset right-page)
                             (store.w new-right-used $btree_used)
                             (store.w new-right-free $btree_free)
                             (store.w (+ (load.uw $btree_count) count-diff) $btree_count))
                           (debug-break "Free and used updated")
                           )
                         (replace-parent-entry (i &optional string (size (aref sizes i)))
                           (declare (fixnum size))
                           (with-locked-page (disk-cache parent t parent-buf parent-buf-offset nil parent-page)
                             (accessing-byte-array (parent-buf parent-buf-offset parent-page)
                               (let* ((last-entry-ptr (+ node-buf-offset $btree_data 
                                                         (- new-used size)))
                                      (length (if string
                                                (length string)
                                                (accessing-byte-array (node-buf)
                                                  (load.b last-entry-ptr))))
                                      (temp-string (make-string length :element-type 'base-character)))
                                 (declare (fixnum last-entry-ptr length)
                                          (dynamic-extent temp-string))
                                 (unless string
                                   (debug-break "Filling string")
                                   (setq string temp-string)
                                   (%copy-byte-array-portion node-buf (1+ last-entry-ptr) length
                                                             string 0))
                                 (let* ((old-size (- right-offset node-offset))
                                        (size-diff (- old-size size))
                                        (ptr (+ parent-buf-offset right-offset)))
                                   (declare (fixnum old-size size-diff ptr))
                                   (unless (eql size-diff 0)
                                     (let* ((parent-used (load.uw $btree_used))
                                            (parent-free (load.uw $btree_free))
                                            (bytes-to-move (- parent-used (- right-offset $btree_data))))
                                       (declare (fixnum parent-used parent-free bytes-to-move))
                                       (debug-break "About to shift parent tail")
                                       (%copy-byte-array-portion
                                        parent-buf ptr bytes-to-move
                                        parent-buf (- ptr size-diff) parent-page)
                                       (when (> size-diff 0)
                                         (incf ptr (- bytes-to-move size-diff))
                                         (accessing-byte-array (parent-buf nil parent-page)
                                           (fill.b ptr 0 size-diff)))
                                       (store.w (- parent-used size-diff) $btree_used)
                                       (store.w (+ parent-free size-diff) $btree_free)))
                                   (setq ptr (+ parent-buf-offset node-offset))
                                   (debug-break "About to enter node string in parent")
                                   (%store-btree-entry parent-buf ptr parent-page
                                                       string length (load.p node-offset) nil size)))))))
                    (declare (dynamic-extent #'shift-right #'update-free-and-used
                                             #'replace-parent-entry))
                    (loop for i from (1- count) downto 0 do
                          (when (>= bytes-moved right-free)
                            ; Ran out of room in right node
                            (return nil))
                          (when (>= bytes-moved bytes-needed)
                            ; The new entry now fits in node
                            (setq count-diff (- count i 1))
                            (shift-right)
                            (update-free-and-used)
                            (if (eql (- offset $btree_data) (- new-used 4))
                              (replace-parent-entry i key-string size)
                              (replace-parent-entry i))
                            (%btree-insert-in-node disk-cache btree node offset
                                                   key-string value value-imm? key-length)
                            (debug-break "Done with insertion in node")
                            ;                            #+bill (check-btree-consistency disk-cache btree)
                            (return t))
                          (when (>= bytes-moved bytes-to-offset)
                            (unless (eql bytes-moved bytes-to-offset)
                              (error "Inconsistency: offset was not at an entry boundary"))
                            (unless (>= new-right-free (+ size bytes-moved))
                              (debug-break "Couldn't shift right")
                              (return nil))
                            ; The new entry fits at the beginning of right-node
                            (setq count-diff (- count i 1))
                            (shift-right size)
                            (let ((right-ptr (+ right-buf-offset $btree_data)))
                              (declare (fixnum right-ptr))
                              (debug-break "Storing new entry in right neighbor")
                              (%store-btree-entry right-buf right-ptr right-page
                                                  key-string key-length value value-imm? size)
                              (incf new-right-used size)
                              (decf new-right-free size)
                              (update-free-and-used)
                              (accessing-byte-array (right-buf right-buf-offset)
                                (store.w (1+ (load.uw $btree_count)) $btree_count))
                              (replace-parent-entry i)
                              (debug-break "Done with insertion in right neighbor")
                              ;                          #+bill (check-btree-consistency disk-cache btree)
                              (return t)))
                          (incf bytes-moved (aref sizes i)))))))))))))

; Much like btree-find-leaf-node, but it makes sure there's room
; for an entry of max-key-size in every node on the way to the leaf.
; This is simpler than letting node splits "bubble up" and it also
; works better in a multi-processing environment (this code does
; not yet work in a multi-processing environment, but using this
; algorithm will allow multiple processes to access a single btree
; at the same time).
(defun %create-insertion-path (disk-cache btree key-string max-key-size)
  (let ((node (dc-%svref disk-cache btree $btree.root))
        (case-sensitive? (not (logbitp $btree-type_string-equal-bit
                                       (dc-%svref disk-cache btree $btree.type)))))
    (loop
      (accessing-disk-cache (disk-cache node)
        (let* ((offset (%btree-search-node
                        disk-cache node key-string case-sensitive?))
               (flags (load.w $btree_flags))
               (leaf-p (logbitp $btree_flags.leaf-bit flags))
               (root-p (logbitp $btree_flags.root-bit flags)))
          (when leaf-p
            (when root-p
              (%make-new-root-node disk-cache btree node))
            (return t))
          (let ((free (load.uw $btree_free)))
            (if (>= free max-key-size)
              (setq node (read-long disk-cache (+ node offset)))
              (progn
                (when root-p
                  (%make-new-root-node disk-cache btree node))
                (%split-node disk-cache btree node free (load.uw $btree_used) nil)
                (setq node (load.p $btree_parent))))))     ; may have moved to new right neighbor
        (require-satisfies dc-vector-subtype-p
                           disk-cache node $v_btree-node)))))

; node is the current root node. Creates a new root node
; with node as its only child.
(defun %make-new-root-node (disk-cache btree node)
  (let ((root (dc-cons-btree-node disk-cache btree btree (ash 1 $btree_flags.root-bit))))
    (accessing-disk-cache (disk-cache root)
      (store.p node $btree_data))
    (setf (dc-%svref disk-cache btree $btree.root) root)
    (setf (dc-%svref disk-cache btree $btree.depth t) 
          (1+ (dc-%svref disk-cache btree $btree.depth)))
    (accessing-disk-cache (disk-cache node)
      (store.p root $btree_parent)
      (store.w (logandc1 (ash 1 $btree_flags.root-bit) (load.w $btree_flags))
               $btree_flags))))

; This will only ever do anything if you have large keys
; Maybe it's not worth the effort, but it doesn't happen very often
; (unless there are large keys, and then it's worth it)
(defun %sew-up-insertion-path (disk-cache btree node leaf-p)
  (accessing-disk-cache (disk-cache node)
    (let* ((free (load.uw $btree_free))
           (used (load.uw $btree_used))
           (count (load.uw $btree_count))
           (unmerged-node (%btree-merge-with-neighbors
                           disk-cache btree node free used count leaf-p)))
      (when unmerged-node
        (accessing-disk-cache (disk-cache unmerged-node)
          (%sew-up-insertion-path disk-cache btree (load.p $btree_parent) nil))))))

;; Store a single entry into a buffer.
(defun %store-btree-entry (buf offset page string string-length value value-imm? &optional size)
  (declare (fixnum offset string-length))
  (let ((p offset))
    (declare (fixnum p))
    (accessing-byte-array (buf nil page)
      (store.p value p value-imm?)
      (store.b string-length (incf p 4))
      (store.string string (incf p 1) string-length)
      (incf p string-length)
      (let* ((bytes (+ 5 string-length))
             (filler (- (or size (setq size (normalize-size bytes 4)))
                        bytes)))
        (declare (fixnum bytes filler))
        (when (> filler 0)
          ; This is for us poor humans.
          (fill.b p 0 filler)))))
  size)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Code to support deletion
;;

(defun %btree-delete-from-node (disk-cache btree node offset leaf-p)
  (declare (fixnum offset))
  (with-locked-page (disk-cache node t node-buf node-buf-offset nil node-page)
    (accessing-byte-array (node-buf node-buf-offset node-page)
      (let* ((size (normalize-size (+ 5 (load.b (+ offset 4))) 4))
             (free (load.uw $btree_free))
             (new-free (+ free size))
             (used (load.uw $btree_used))
             (new-used (- used size))
             (count (load.uw $btree_count))
             (new-count (1- count))
             (p (+ node-buf-offset offset))
             (bytes-to-copy (- used size (- offset $btree_data))))
        (declare (fixnum size free new-free used new-used count new-count p bytes-to-copy))
        (debug-break "About to delete from node")
        (%copy-byte-array-portion node-buf (+ p size) bytes-to-copy
                                  node-buf p node-page)
        (fill.b (+ $btree_data new-used) 0 size)
        (store.w new-free $btree_free)
        (store.w new-used $btree_used)
        (store.w new-count $btree_count)
        (debug-break "Deleted from node")
        (%btree-merge-with-neighbors
         disk-cache btree node new-free new-used new-count leaf-p)))))

; Returns the last node on the way up the parent chain that could not be
; merged with either neighbor, or NIL if it got all the way to the root.

(defun %btree-merge-with-neighbors (disk-cache btree node free used count leaf-p)
  (if (%btree-root-node-p disk-cache node)
    (when (eql 0 count)
      ; delete the root node, unless it is also the leaf node
      (unless (%btree-leaf-node-p disk-cache node)
        (accessing-disk-cache (disk-cache node)
          (unless (eql 4 (load.uw $btree_used))
            (error "Inconsistency: root should be empty, but isn't"))
          (let ((new-root (load.p $btree_data)))
            (debug-break "About to install new root")
            (setf (dc-%svref disk-cache btree $btree.root) new-root)
            (setf (dc-%svref disk-cache btree $btree.depth t)
                  (1- (dc-%svref disk-cache btree $btree.depth)))
            (accessing-disk-cache (disk-cache new-root)
              (store.p btree $btree_parent)
              (store.w (logior (ash 1 $btree_flags.root-bit)
                               (load.uw $btree_flags))
                       $btree_flags))
            (debug-break "Installed new root")
            (dc-free-btree-node disk-cache btree node)
            nil))))
    (let ((parent (accessing-disk-cache (disk-cache node) (load.p $btree_parent))))
      (multiple-value-bind (node-offset left-offset) (%btree-search-for-subnode disk-cache parent node)
        (unless node-offset
          (error "Inconsistency: didn't find node: ~s in parent: ~s" node parent))
        (accessing-disk-cache (disk-cache parent)
          (when left-offset
            (let ((left-node (load.p left-offset))
                  ; Initializes parent size to -4 if leaf-p, which is correct since
                  ; when merging two nodes, the pointer from the left node to the
                  ; right node is eliminated, making the data take 4 bytes less.
                  (parent-size (- (if leaf-p 0 (- node-offset left-offset)) 4)))
              (declare (fixnum parent-size))
              (accessing-disk-cache (disk-cache left-node)
                (let ((left-free (load.uw $btree_free)))
                  (declare (fixnum left-free))
                  (when (>= left-free (+ used parent-size))
                    (debug-break "About to merge with left neighbor")
                    (return-from %btree-merge-with-neighbors
                      (%btree-merge-nodes
                       disk-cache btree left-node node parent left-offset node-offset leaf-p)))))))
          (let ((end-offset (+ $btree_data -4 (load.uw $btree_used))))
            (declare (fixnum end-offset))
            (when (< node-offset end-offset)
              (let* ((right-length (load.b (+ node-offset 4)))
                     (right-offset (+ node-offset (normalize-size (+ 5 right-length) 4)))
                     (right-node (load.p right-offset))
                     (parent-size (- (if leaf-p 0 (- right-offset node-offset)) 4)))
                (declare (fixnum right-offset parent-size))
                (accessing-disk-cache (disk-cache right-node)
                  (let ((right-used (load.uw $btree_used)))
                    (when (>= free (+ right-used parent-size))
                      (debug-break "About to merge with right neighbor")
                      (return-from %btree-merge-with-neighbors
                        (%btree-merge-nodes
                         disk-cache btree node right-node parent node-offset right-offset leaf-p))))))))
          node)))))

; We know that there's room to merge the nodes. Do it.
; It's important that this code merges into the LEFT node as that ensures that the
; first leaf node remains constant (the btree points at it and p-map-btree relies on that fact).
; (You could instead update $btree.first-leaf as necessary).
(defun %btree-merge-nodes (disk-cache btree left-node right-node parent left-offset right-offset leaf-p)
  (declare (fixnum left-offset right-offset))
  (with-locked-page (disk-cache parent nil parent-buf parent-buf-offset)
    (with-locked-page (disk-cache left-node t left-buf left-buf-offset nil left-page)
      (with-locked-page (disk-cache right-node nil right-buf right-buf-offset)
        (accessing-byte-array (left-buf left-buf-offset)
          (let* ((p (+ left-buf-offset $btree_data (load.uw $btree_used)))
                 (right-used (accessing-byte-array (right-buf right-buf-offset)
                               (load.uw $btree_used)))
                 (count-inc (accessing-byte-array (right-buf right-buf-offset)
                              (load.uw $btree_count)))
                 (used-inc right-used))
            (declare (fixnum p right-used count-inc used-inc))
            (if leaf-p
              (progn
                (decf p 4)
                (decf used-inc 4))
              (let ((size (- right-offset left-offset 4)))
                (declare (fixnum size))
                (debug-break "About to copy parent info")
                (%copy-byte-array-portion parent-buf (+ parent-buf-offset left-offset 4) size
                                          left-buf p left-page)
                (incf used-inc size)
                (incf count-inc)
                (incf p size)))
            (debug-break "About to copy right-buf info")
            (%copy-byte-array-portion right-buf (+ right-buf-offset $btree_data) right-used
                                      left-buf p left-page)
            (store.w (+ (load.uw $btree_used) used-inc) $btree_used)
            (store.w (- (load.uw $btree_free) used-inc) $btree_free)
            (store.w (+ (load.uw $btree_count) count-inc) $btree_count)
            (dc-free-btree-node disk-cache btree right-node)
            (accessing-byte-array (parent-buf parent-buf-offset)
              (store.p left-node right-offset))
            (unless leaf-p
              (%btree-update-childrens-parents disk-cache left-node p))
            (debug-break "Nodes merged")
            (%btree-delete-from-node disk-cache btree parent left-offset nil)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Consistency checking and statistics gathering
;;;

(defun check-btree (btree)
  (check-btree-consistency (pheap-disk-cache (pptr-pheap btree)) (pptr-pointer btree)))

; Checks consistency and returns how full the btree is.
(defun check-btree-consistency (disk-cache btree &optional check-nodes-and-count?)
  (let ((root (accessing-disk-cache (disk-cache)
                (svref.p btree $btree.root))))
    (multiple-value-bind (free used nodes count leaf-free leaf-used leaf-nodes non-leaf-free non-leaf-used non-leaf-nodes)
                         (check-btree-node-consistency disk-cache root btree)
      (when check-nodes-and-count?
        (let ((missing-nodes (- (accessing-disk-cache (disk-cache)
                                  (svref.p btree $btree.nodes))
                                nodes)))
          (unless (eql missing-nodes 0)
            (cerror "Continue" "~d. missing nodes" missing-nodes)))
        (let ((missing-entries (- (accessing-disk-cache (disk-cache)
                                    (svref.p btree $btree.count))
                                  count)))
          (unless (eql 0 missing-entries)
            (cerror "Continue" "~d. missing entries" missing-entries))))
      (values (if (eql used 0) 0 (/ used (float (+ free used))))
              nodes
              count
              (if (eql leaf-used 0) 0 (/ leaf-used (float (+ leaf-free leaf-used))))
              leaf-nodes
              (if (eql non-leaf-used 0) 0 (/ non-leaf-used (float (+ non-leaf-free non-leaf-used))))
              non-leaf-nodes))))

(defun check-btree-node-consistency (disk-cache node parent)
  (require-satisfies dc-vector-subtype-p disk-cache node $v_btree-node)
  (accessing-disk-cache (disk-cache node)
    (let* ((vector-size (%vector-size.p node))
           (free (load.uw $btree_free))
           (used (load.uw $btree_used))
           (count (load.uw $btree_count))
           (nodes 1)
           (sizes (make-array (the fixnum (1+ count))))
           (leaf? (%btree-leaf-node-p disk-cache node))
           (total-count (if leaf? count 0))
           (p $btree_data)
           (leaf-free 0)
           (leaf-used 0)
           (leaf-nodes 0)
           (non-leaf-free 0)
           (non-leaf-used 0)
           (non-leaf-nodes 0))
      (declare (fixnum free used count p leaf-free leaf-used leaf-nodes non-leaf-free non-leaf-used non-leaf-nodes)
               (dynamic-extent sizes))
      (if leaf?
        (setq leaf-free free leaf-used used leaf-nodes 1)
        (setq non-leaf-free free non-leaf-used used non-leaf-nodes 1))
      (unless (eql parent (load.l $btree_parent))
        (error "parent should be: #x~x, was: #x~x" parent (load.l $btree_parent)))
      (unless (eql (- vector-size (- $btree_data $v_data)) (+ free used))
        (cerror "Continue."
                "~&(+ free used) is wrong. Node: #x~x, free: #x~x, used: #x~x~%"
                node free used))
      (%lookup-node-sizes disk-cache node sizes count)
      (setf (aref sizes count) 0)
      (unless leaf?
        (dotimes (i (1+ count))
          (multiple-value-bind (c-free c-used c-nodes c-count 
                                       c-leaf-free c-leaf-used c-leaf-nodes
                                       c-non-leaf-free c-non-leaf-used c-non-leaf-nodes)
                               (check-btree-node-consistency disk-cache (load.l p) node)
            (incf free c-free)
            (incf used c-used)
            (incf leaf-free c-leaf-free)
            (incf leaf-used c-leaf-used)
            (incf leaf-nodes c-leaf-nodes)
            (incf non-leaf-free c-non-leaf-free)
            (incf non-leaf-used c-non-leaf-used)
            (incf nodes c-nodes)
            (incf non-leaf-nodes c-non-leaf-nodes)
            (incf total-count c-count))
          (incf p (aref sizes i))))
      (values free used nodes total-count leaf-free leaf-used leaf-nodes non-leaf-free non-leaf-used non-leaf-nodes))))


#|
; Test code. Stores symbols in a btree.
(defun init-temp-btree ()
  (declare (special pheap dc b))
  (when (boundp 'pheap)
    (close-pheap pheap))
  (delete-file "temp.pheap")
  (create-pheap "temp.pheap")
  (setq pheap (open-pheap "temp.pheap")
        dc (pheap-disk-cache pheap))
  (dolist (w (windows :class 'inspector::inspector-window))
    (window-close w))
  (setq b (dc-make-btree dc))
  #+ignore
  (let ((w (inspect dc)))
    (set-view-size w #@(413 384))
    (scroll-to-address (inspector::inspector-view w) (dc-%svref dc b $btree.root))))

(defvar *symbols* nil)
(defvar *value-offset* 0)

(defun *symbols* ()
  (let ((syms *symbols*))
    (unless syms
      (let ((hash (make-hash-table :test 'equal)))
        (do-symbols (s)
          (unless (gethash (symbol-name s) hash)
            (setf (gethash (symbol-name s) hash) t)
            (push s syms))))
      (setq *symbols* syms
            *value-offset* 0))
    syms))

(defun store-symbols (&optional (step-sym 0) check? (check-sym 0))
  (declare (special dc b))
  (let ((syms (*symbols*))
        (check-check-sym? nil)
        (i 0))
    (dolist (s syms)
      (let ((string (symbol-name s))
            (value (+ i *value-offset*)))
        (if (eq s step-sym)
          (step
           (dc-btree-store dc b string (require-type value 'fixnum) t))
          (dc-btree-store dc b string (require-type value 'fixnum) t))
        (when (eql s check-sym) (setq check-check-sym? i))
        (incf i)
        (when check-check-sym?
          (unless (eql check-check-sym? (dc-btree-lookup dc b (symbol-name check-sym)))
            (cerror "Continue" "Can't find ~s" check-sym)))
        (when (and check? (or (not (fixnump check?))
                              (eql 0 (mod i check?))))
          (format t "~&Checking ~d..." i)
          (check-symbols s)
          (terpri))))
    i))

(defun check-symbols (&optional (upto-and-including 0))
  (declare (special dc b))
  (let ((i 0))
    (dolist (s (*symbols*))
      (let ((was (dc-btree-lookup dc b (symbol-name s)))
            (value (+ i *value-offset*)))
        (unless (eql was value)
          (cerror "Continue"
                  "Sym: ~s, was: ~s, sb: ~s" s was value))
        (incf i)
        (when (eq s upto-and-including)
          (return))))
    i))

(defun delete-symbols (&optional (count nil) (check-period nil))
  (declare (special dc b))
  (let ((check-count (or check-period most-positive-fixnum)))
    (dotimes (i (or count (length *symbols*)))
      (when (null *symbols*) (return))
      (incf *value-offset*)
      (dc-btree-delete dc b (symbol-name (pop *symbols*)))
      (when (<= (decf check-count) 0)
        (setq check-count check-period)
        (format t "~&Checking ~d..." i)
        (check-symbols)
        (terpri)))))

(defun sort-syms-upto (sym)
  (let ((first-n (let ((res nil))
                   (dolist (s *symbols* (error "Not found"))
                     (push s res)
                     (when (eq s sym) (return res))))))
    (sort first-n #'string<)))

(defun btree-test (&optional (step-sym 0))
  (init-temp-btree)
  (store-symbols step-sym))

(defun clear-disk-cache ()
  (unwind-protect
    (with-open-file (s "temp.temp" :direction :output :if-exists :overwrite)
      (file-length s (* 256 1024))
      (dotimes (i 512)
        (file-position s (* i 512))
        (tyo #\f s)))
    (delete-file "temp.temp")))

(defun time-btree-store (&optional (swap-space-in-k 20))
  (let* ((syms (*symbols*))
         (syms-count (length syms))
         (index 0))
    (declare (fixnum index))
    (clear-disk-cache)
    (gc)
    (let ((time (get-internal-real-time)))
      (with-open-pheap (p "temp.pheap"
                          :if-exists :supersede
                          :if-does-not-exist :create
                          :swapping-space (* swap-space-in-k 1024)
                          :page-size 512)
        (let ((b (p-make-btree p)))
          (setf (root-object p) b)
          (dolist (s syms)
            (setf (p-btree-lookup b (symbol-name s)) (incf index))))
        (let ((total-time (/ (float (- (get-internal-real-time) time))
                             internal-time-units-per-second))
              (file-length (with-open-file (s "temp.pheap") (file-length s))))
          (format t "~&Total time: ~d~%Elements: ~d~%time/element: ~d~%file length: ~d"
                  total-time
                  syms-count
                  (/ total-time syms-count)
                  file-length))))))

(defun time-btree-read (&optional (swap-space-in-k 20))
  (let* ((syms (*symbols*))
         (syms-count (length syms)))
    (clear-disk-cache)
    (gc)
    (let ((time (get-internal-real-time)))
      (with-open-pheap (p "temp.pheap"
                          :swapping-space (* swap-space-in-k 1024))
        (let ((b (root-object p)))
          (dolist (s syms)
            (p-btree-lookup b (symbol-name s)))))
      (let ((total-time (/ (float (- (get-internal-real-time) time))
                           internal-time-units-per-second))
            (file-length (with-open-file (s "temp.pheap") (file-length s))))
        (format t "~&Total time: ~d~%Elements: ~d~%time/element: ~d~%file length: ~d"
                total-time
                syms-count
                (/ total-time syms-count)
                file-length)))))


|#

#|
; Code to trace functions that were hard to debug.
(advise %btree-insert-in-node
        (destructuring-bind (dc b node offset key-string value &optional value-imm? (key-length (length key-string))) arglist
          (declare (ignore offset value value-imm?))
          (if (or (%btree-leaf-node-p dc node)
                  (<= (normalize-size (+ 5 key-length))
                      (accessing-disk-cache (dc node) (load.uw $btree_free))))
            (:do-it)
            (step (:do-it))))
        :when :around)

(advise %balance-inner-node-after-deletion
        (step (:do-it))
        :when :around)
|#
;;;    1   3/10/94  bill         1.8d247
;;;    2   7/26/94  Derek        1.9d027
;;;    3  10/04/94  bill         1.9d071
;;;    4  11/01/94  Derek        1.9d085 Bill's Saving Library Task
;;;    5  11/03/94  Moon         1.9d086
;;;    2   2/18/95  RŽti         1.10d019
;;;    3   3/23/95  bill         1.11d010
;;;    4   4/19/95  bill         1.11d021
;;;    5   6/02/95  bill         1.11d040
