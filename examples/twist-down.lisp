;-*- Mode: Lisp; Package: (twist-down) -*-

;;;; twist-down
;;;;
;;;; Displays a hierarchy in a manner similar to the traditional Finder's twist-down file browser.
;;;;
;;;; This code is provided free of charge.  No warranty, express or implied.
;;;; This code is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;;;  
;;; Version 3.01 (September 22, 2004) for MCL 4.3.1, 4.3.5, 5.0, 5.1 and up (hopefully ;-).
;;;
;;; Co-authors:
;;; Terje Norderhaug <terje@in-progress.com> on-going development
;;; Richard Lynch <ceo@l-i-e.com> initial 2.1 version (1995)
;;;
;;;;© MCMXCII Northwestern University Institute for the Learning Sciences
;;;;1890 Maple
;;;;Evanston, IL  60201

#| DOCUMENTATION (SORT OF):

A Twist Down view displays a hierarchy similar to the Finder's listing of files, as an 
outline or a single-column tree where the user can disclose lower levels in the hierarchy 
by clicking a triangle. 

EXAMPLES

See the bottom of this document for examples.

TWIST DOWN VS DATABROWSER

The functionality of Twist Down views overlaps considerably with the Carbon Databrowser. 
The DataBrowser is superb for Mac user interface compliant multi-column hierachical views. 
Use Twist Down views when you need customization beyond what is provided by the DataBrowser,
or to provide outlines or single-column hierachies. It is a goal that the Twist Down contrib
is highly compatible with the Databrowser so that you can easily migrate either way.

DISPLAYING A HIERARCHY

Make an instance of 'twist-down and add it as a subview to a window or view. Provide a 
:root with the object that contains the hierarchy of nodes. If the root is not a list of
lists, you should provide a :children-function that returns a list of the children of a node. 
The root will be the top node, with its children available by disclosing them.

MULTIPLE TOPLEVEL ITEMS

You can display the children of the root as multiple toplevel items. Provide a
:items-function when creating the twist-down, or NIL to use the :children-function
on the root to get the top level items.

LABEL AND ICON FOR A NODE

You may provide a :node-string-function that returns the label of the node as a string.
If you want nodes to have icons, provide a :node-icon-function that returns an optional icon
for the node.

CUSTOMIZING THE DRAWING OF A NODE

The twist-down-draw-node method can be specialized to customize the drawing of a node. This
method is called with the node, a rect containing the drawing rectangle, and a boolean
specifying whether the node is selected. A default drawing context has already been
initialized before twist-down-draw-node is called, and the area has been erased, so a
specialized method only have to set up its own context when deviating from the default.
The default method draws the icon (if any) and label for the node within the drawing rectangle.

IDEAS FOR FUTURE IMPROVEMENTS

- Should set-root be eliminated and (setf root) cover the same functionality?
- Rename root to data!
- Split the selected and down-paths now in set-root into a separate method?
- Should the separator be optional?
- Use proper value for pix depth.
- Methods to remove & add items.
- Consider to remove the watch-cursor as it is disturbing...
- Support keys for scrolling up/down/pageup/pagedown/home/end.
- Focus ring when keyboard focus.

|#

#| NOTE BY RICHARD FOR THE 2.1 VERSION:

Is your current grapher display of a hierarchy a little...gargantuan?

I have shamelessly plagiarized Apple's System 7 twist-down-triangle-folder
look-and-feel in a twist-down.

Credit must be given to Mike Engber who suggested I code it a l‡ Finder.

Kudos to whoever wrote scrollers.lisp in the Library folder.  It handles all
the grungy scrolling of the view, which I would have wasted weeks on, and
never gotten right.

Much improvement is seen from the original 1-day hack I wrote for this.
Drawing and selection are much faster and less flashy.
Unfortunately, making it backward-compatible was beyond me.
I sincerely believe the changes will not be too difficult for most users.

The biggest change is that editing of a heterarchy using standard
cut-and-paste is now supported!  However, this required that any path to a
node be stored as a unique branch.  This also allows quick redraw, so it is
worth it, IMO.

The second biggest change is that children and string representation are no
longer cached.  People complained that for large heterarchies this was too
memory intensive.  If you're data-access isn't fast enough, it's your own damn
fault.

The third biggest change is that several forms of multiple selection are now
supported.  Thus, selected returns a list, rather than a single value.  Sorry.

To this day, this code assumes that #'eq is a suitable test for node equality.
I no longer expect this assumption to change.
Altering to #'eql or #'equal would be trivial.
Any other test would be ugly--Good luck.


Coming soon to an archive near you:

Documentation for this monstrosity!

Drop-and-drag interface for editing!!!

Don't miss it.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	Change History (most recent first):

;;; 2004-Sep-15 Terje Released version 3.0
;;; -----------------
;;; 2004-09-09 Terje Eliminated random stray bits below the first line in OSX reported by Toomas Altosaar:
;;;                   The twist-down-draw-node no longer subtract -1 from rect.top in OSX.
;;; 2004-09-09 Terje Fixed so clicking triangle doesn't use all CPU (reported by Toomas Altosaar):
;;;                   Uses wait-mouse-up-or-moved in view-click-event-handler in MCL 5.1.
;;; 2004-09-06 Terje An icon is any object with a method ICONREF that aquires an iconref.
;;; 2004-09-06 Terje Triangles can no longer be icon suite resources in Carbon.
;;; 2004-06-15 Terje Major changes too numerous to document for the history ;-)
;;; 2004-04-30 Terje Draws Carbon/Aqua triangle.
;;; 1999-03-21 Terje Recovers if load-triangles fails during loading of module
;;; 1999-03-19 Terje Changed errors to warnings in load-ics to allow recovery
;;; 1999-01-28 Terje clicking in the position of the triangle selects the line for leaves.
;;; 1999-01-28 Terje line-select and line-deselect invalidates the line instead of just the node.
;;; 1999-01-11 Terje redefined the load-ics macro into a function.
;;; 1999-01-10 Terje draw-node uses 0 rather than root-indent as left for the rect.
;;; 08/22/97 terje  triangle-height-min constant
;;; 08/22/97 terje  triangle-height-min used in method line-height to allow small fonts
;;; 07/22/97 terje  invalidate-triangle and invalidate-line-node eliminates gray color
;;; 07/22/97 terje  view-draw-contents also draw lines without node or branch
;;; 07/22/97 terje  draw-node has background color when no node or branch
;;; 07/22/97 terje  node-back-color use the dialog background color as default
;;; 07/22/97 terje  expand-branch is split to facilitate patching and editing
;;; 07/22/97 terje  new set-root method so root can be set afterwards
;;; 07/22/97 terje  scroll-bar-limits has been compacted using library function
;;; 07/09/97 terje  view-visible-lines method
;;; 07/09/97 terje  view-draw-contents only draw visible lines
;;; 06/18/97 terje  Several changes to make as independent module and allow
;;;                 customizability in sizes and colors: 
;;;  - Made into package (draw-triangle conflict in name with a method in the pop-up-menu module)
;;;  - No longer require :ll-init as this isn't strictly needed
;;;  - No longer require :oou-init
;;;  - No longer run oou-dependencies to make as stand-alone module
;;;  - Added a with-back-color to draw-triangle so it doesn't leave grey area when 
;;;    dialog has non-default background.
;;;  - Changed the draw-triangle method so the size of the triangle is static 16 instead 
;;;    of line height (avoids cropping).
;;;  - Changed the order of writing node vs triangle in view-draw-contents
;;;  - Modified body of draw-node to use the background color for the view for empty cells.
;;;  - Added a root-indent method to more easily patch the twist-down to not have a root.
;;;  - Added a load-ics macro to eliminate redundancy in load-triangles
;;;  - Load triangles uses load-ics and takes an optional resource file as argument.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;This let will add the path of this window to *module-search-path* so that
;anything in the same folder will be found when a require is done.
#-carbon-compat
(let* ((win (front-window :class 'fred-window))
       (file (when win (window-filename win)))
      )
  (when file
    (pushnew (make-pathname :directory (pathname-directory file))
             *module-search-path*
             :test #'equalp
) ) )

(defpackage "TWIST-DOWN"
  (:export
    twist-down
    editable-twist-down))

(in-package :twist-down)

(require :scrollers)
; (require :ll-init #4P"ccl:Lynch Lib;ll-init")
#-carbon-compat
(require :font-info)
#-ccl-4.3.1
(require :icons-sys7-tn306)
; (require :oou-init #4P"ccl:oodles-of-utils;oou-init")
; (oou-dependencies :droppable-svm :quickdraw-u :simple-view-ce)

(defconstant *td* :|TD  | "OSType for the editable-twist-down scrap-handler.")

(defparameter *twist-down-source-file* #.*loading-file-source-file*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PRE CARBON TRIANGLES

#-carbon-compat
(defparameter *right-triangle* nil "IconSuite Handle of default right triangle.")

#-carbon-compat
(defparameter *down-triangle* nil "IconSuite Handle of default down triangle.")

#-carbon-compat
(defun load-triangles (&optional (resource-file *twist-down-source-file*) &key (right 3060)(down 3061))
  "Loads in the triangles from the resource fork."
  (let* ((resfile (if resource-file
                    (mac-namestring resource-file)
                    (ccl::get-app-pathname)))
         (OldResFile (#_CurResFile)))
    (unwind-protect ; consider use-resource-file, if at all needed!
      (with-open-resource-file (refnum resfile
                                       :If-does-not-exist nil
                                       :direction :input)
        (labels ((load-ics (var ics r)
                   (let (temp err)
                     (setq temp (#_GetResource ics r))
                     (setq err (#_ResError))
                     (assert (zerop err) () "Error ~A loading ~A ~A" err r ics)
                     (#_DetachResource temp)
                     (setq err (#_ResError))
                     (unless (zerop err)
                       (warn "Error ~A detaching ~A ~A" err r ics))
                     (setq err (#_AddIconToSuite temp var ics))
                     (or (zerop err)
                         (warn "Error ~A AddIconToSuite [~A]" err r)
                         err)))
                 (load-icsn (suite id)
                   (load-ics suite "ics#" id)
                   (load-ics suite "ics4" id)
                   (when
                     (load-ics suite "ics8" id)
                     suite))
                 (load-icon-suite (id)
                   (rlet ((ptr :ptr))
                     (ccl::errchk (#_NewIconSuite ptr))
                     (let ((suite (%get-ptr ptr)))
                       (load-icsn suite id)))))
           (setq *right-triangle* (load-icon-suite right)) 
           (setq *down-triangle* (load-icon-suite down))
           (and *right-triangle* *down-triangle* T)))
      (when OldResFile
        (#_UseResFile OldResFile)))))

#-carbon-compat
(defun dispose-triangles ()
  "Destroys the *right-triangle* and *down-triangle* handles."
  (when (handlep *right-triangle*) (#_DisposeIconSuite *right-triangle* t))
  (setq *right-triangle* NIL)
  (when (handlep *down-triangle*) (#_DisposeIconSuite *down-triangle* t))
  (setq *down-triangle* NIL))

#-carbon-compat
(defun init-triangles (&optional resource-file &rest args)
  "Execute before saving an application or image to prepare triangles"
  (flet ((load-triangles ()
           (handler-case
             (apply #'load-triangles resource-file args) 
             (error (condition)
                    (warn "Failed to load triangles (~A)" condition)))))
    (setf *lisp-startup-functions*
          (nconc *lisp-startup-functions* (list #'load-triangles)))
    (push #'dispose-triangles *save-exit-functions*)))

#-carbon-compat
(eval-when (:load-toplevel :execute)
  (init-triangles)
  (load-triangles))

; (load-triangles nil)
; (dispose-triangles)
; *right-triangle*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+carbon-compat
(defclass twist-down-box-dialog-item (ccl::box-dialog-item)
  ((container)))

#+carbon-compat
(defmethod view-draw-contents ((self twist-down-box-dialog-item))
  (let* ((pos (add-points (view-position self) #@(0 0)))
         (end (subtract-points 
               (add-points pos (view-size self)) 
                #@(0 0);(ccl::scroll-bar-correction (slot-value self 'container))
               )))
    (rlet ((r :rect
              :topleft pos
              :bottomright end))
      (unless (osx-p)
        (#_insetRect r 1 1))
      (#_DrawThemeListBoxFrame r 
       (if (window-active-p (view-window (slot-value self 'container))) #$kThemeStateActive #$kThemeStateInactive)))))

(defclass twist-down-scroller (ccl::scroller)
  ()
  (:default-initargs
    :view-position #@(4 4)
  )
)

#+carbon-compat
(defmethod view-corners ((self twist-down-scroller))
  ; ensures that the box is drawn...
  (multiple-value-call #'inset-corners #@(-3 -3) (call-next-method)))

#+carbon-compat
(defmethod initialize-instance :after ((self twist-down-scroller) &rest initargs)
  (declare (ignore initargs))
  (when (ccl::scroller-outline self)
    (change-class (ccl::scroller-outline self) (find-class 'twist-down-box-dialog-item))
    (setf (slot-value (ccl::scroller-outline self) 'container) self)))

(defmethod ccl::scroll-bar-limits ((view twist-down-scroller))
  (normal-scroll-bar-limits view (max-h-drawn view)(max-v-drawn view)))

(defclass twist-down (twist-down-scroller dialog-item)
  ((root
     :documentation "Root of heterarchy to display."
     :accessor root
     :initarg :root
     :initform nil)
   (items-function
    :documentation "Function to return the top level items of the root"
    :accessor items-function
    :initarg :items-function
    :initform #'list
    :type (or null function))
   (children-function
     :documentation "Function to return the children of a given node."
     :accessor children-function
     :initarg :children-function
     :initform #'(lambda (node)(when (listp node) node)) ; #'false in 2.1 version
     :type function)
   (parents-function
     :documentation "Function to return the parents of a given node."
     :accessor parents-function
     :initarg :parents-function
     :initform #'false
     :type function)
   (node-string-function
     :documentation "Function that returns a string for a given node."
     :accessor node-string-function
     :initarg :node-string-function
     :initform #'(lambda (n) (format nil "~A" n))
     :type function)
   (node-icon-function
    :documentation "Function that returns an icon for a given node."
    :accessor node-icon-function
    :initarg :node-icon-function
    :initform NIL
    :type (or null function))
   (indent
     :documentation "Number of pixels to indent per level."
     :accessor indent
     :initarg :indent
     :initform 20
     :type fixnum
   )
   (selection-type
     :documentation "Type of selection allowed."
     :accessor selection-type
     :initarg :selection-type
     :initform :single
     :type (satisfies #.#'(lambda (x) (member x '(:single :leaves :children :multiple))))
   )
   (branch-cache
     :documentation "Cache of branches already created."
     :accessor branch-cache
     :initarg :branch-cache
     :initform (make-hash-table :test #'equal)
     :type hash-table
   )
   (branches
     :documentation "Array of visible branches."
     :accessor branches
     :initarg :branches
     :initform (make-array 0 :adjustable t :fill-pointer 0)
     :type (array branch)
   )
   (selected-lines
     :documentation "Line numbers of selected branches."
     :accessor selected-lines
     :initarg :selected-lines
     :initform nil
     :type (or list fixnum)
     ;Note that Apple's coordinate system won't allow pixels > fixnum size.
   )
   (max-h-drawn
     :documentation "Maximum coordinate drawn in the h direction."
     :accessor max-h-drawn
     :initarg :max-h-drawn
     :initform 0
     :type fixnum
   )
   (max-v-drawn
     :documentation "Maximum coordinate drawn in the v direction."
     :accessor max-v-drawn
     :initarg :max-v-drawn
     :initform 0
     :type fixnum
   )
   (triangle-indent-p
     :documentation "Flag to determine triangle placement."
     :accessor triangle-indent-p
     :initarg :triangle-indent-p
     :initform nil
     :type boolean)
   (draggedp
     :documentation "Flagged to determine whether dragging occured."
     :accessor draggedp
     :initarg :draggedp
     :initform nil
     :type boolean))
  (:documentation "Displays a hierarchy similar to Finder's twist down files.")
  (:default-initargs
    :view-size #@(100 256)
    :track-thumb-p t) )

;mod 7/9/93
(defmethod (setf root) :after (root (twist-down twist-down))
  (setf (branch-cache twist-down) (make-hash-table :test #'equal))
  (setf (branches twist-down) (make-array 0 :adjustable t :fill-pointer 0))
  (when root
    (dolist (node (funcall 
                   (or (items-function twist-down)
                       (children-function twist-down))
                   root))
      (vector-push-extend ; ## also call register-branch?
       (make-instance 'branch :node node :id (list node))
       (branches twist-down)
       )))
  (update-max-v-drawn twist-down)
  (deselect-all twist-down)
  (invalidate-view twist-down)
)

(defmethod update-max-v-drawn ((view twist-down))
  (setf (max-v-drawn view) 
        (-
         (* (length (branches view)) 
            (+ (line-height view)
               (point-v (separator-size view))))
         (point-v (separator-size view)))))

(defmethod initialize-instance ((view twist-down) &key root selected down-paths)
  (call-next-method)
  (let* ((font (view-font view))
         (v (line-height view))
         (h (nth-value 2 (font-info font)))
         (h-scroller (ccl::h-scroller view))
         (v-scroller (ccl::v-scroller view))
        )
    (set-root view root :selected selected :down-paths down-paths)
    (when h-scroller (setf (scroll-bar-scroll-size h-scroller) h))
    (when v-scroller (setf (scroll-bar-scroll-size v-scroller) 
                           (+ v (point-v (separator-size view)))))
    #+ignore
    (setf (max-v-drawn view) v)))

(defmethod view-activate-event-handler :before ((view twist-down))
  (invalidate-view view))

(defmethod view-deactivate-event-handler :before ((view twist-down))
  (invalidate-view view))

;; merge into setf root?
(defmethod set-root ((view twist-down) root &key selected down-paths)
  (setf (slot-value view 'root) root)
  (setf (twist-down::branch-cache view) (make-hash-table :test #'equal))
  (setf (twist-down::branches view) (make-array 0 :adjustable t :fill-pointer 0))
  (when root
    (dolist (node (funcall (or (items-function view) 
                               (children-function view)) 
                           root)) ;; ## isn't this part covered by setf on root??
      (let ((branch (make-instance 'branch :node node :id (list node))))
        (setf (id branch) (list node)) ;; # did that when making the instance, no?
        (register-branch view branch)
        (vector-push-extend branch (branches view)))))
  (let ((good-paths nil))
    ;Expand paths, ensuring termination in root.
    (dolist (path down-paths)
      (push nil good-paths)
      (do* ((rest-path path (cdr rest-path))
            (node (car rest-path)
                  (car (or rest-path (funcall (parents-function view) node)))
            )
           )
           ((or (eq node root) (null node))
            (if node
              (push node (car good-paths))
              (error "~S petered out without reaching root." path)
            )
           )
        (push node (car good-paths))
    ) )
    (setq good-paths (mapcar #'nreverse good-paths))
    ;Expand branches as needed.
    (dolist (path good-paths)
      (let ((len (length path)))
        (do ((i (1- len) (1- i)))
            ((zerop i))
          (let ((branch (get-branch view (subseq path i len) nil)))
            (unless (downp branch)
              (expand-branch view branch t)
              (setf (downp branch) t)
      ) ) ) )
      ;Handle selection, if needed.
      (when (member (car path) selected :test #'eq)
        (line-select view (branch-line view (get-branch view path nil))))))
  (update-max-v-drawn view)
  (redo-scroll-bars view))

(defmethod line-select ((view twist-down) line-number)
  (unless (find line-number (selected-lines view) :test #'=)
    (push line-number (selected-lines view))
    (invalidate-line view line-number)
) )

(defmethod line-deselect ((view twist-down) line-number)
  (let ((selected (selected-lines view)))
    (when (find line-number selected :test #'=)
      (setf (selected-lines view)
            (delete line-number selected :test #'= :count 1)
      )
      (invalidate-line view line-number)
) ) )

;mod 7/9/93
(defmethod deselect-all ((twist-down twist-down))
#|
  (loop for line :in (selected-lines twist-down)
        :do (line-deselect twist-down line)))
|#
  (dolist (line (selected-lines twist-down))
    (line-deselect twist-down line)
) )

(defmethod line-selected-p ((view twist-down) line-number)
  (find line-number (selected-lines view) :test #'=)
)

(defmethod selected ((view twist-down))
  (mapcar #'(lambda (l) (node (aref (branches view) l)))
          (selected-lines view)
) )

(defmethod invalidate-line ((view twist-down) line-number)
  #+ignore
  (invalidate-triangle view line-number)
  #+ignore
  (invalidate-line-node view line-number)
  (multiple-value-bind (topleft bottomright)
                       (line-corners view line-number)
    (invalidate-corners view topleft bottomright))
)

(defmethod invalidate-triangle ((view twist-down) line-number)
  #+ignore
  (let* ((size (line-height view))
         (left 0)
         (top (* line-number size))
         (right size)
         (bottom (+ top size)))
    (invalidate-corners view (make-point left top) (make-point right bottom)))
  (let ((branch (line-branch view line-number)))
    (multiple-value-bind (topleft bottomright)
                         (triangle-corners view line-number (if branch (level branch) 0))
      (invalidate-corners view topleft bottomright))))

; no longer used in 3.0, so consider to remove it!
(defmethod invalidate-line-node ((view twist-down) line-number)
  (let* ((size (line-height view))
         (left size)
         (top (* line-number size))
         (right (max (max-h-drawn view) (point-h (view-size view))))
         (bottom (+ top size)))
    (invalidate-corners view (make-point left top) (make-point right bottom))))

(defmethod invalidate-node ((view twist-down) node)
  (with-cursor *watch-cursor*
    (do* ((i 0 (1+ i))) ; use dotimes? or does the length of branches change?
         ((>= i (length (branches view))))
      (let ((branch (line-branch view i)))
        (when (and (downp branch) (eq node (node branch)))
;          (setf (downp branch) nil)
          (expand-branch view branch nil)
;          (setf (downp branch) t)
          (expand-branch view branch t)
          (invalidate-line view i)
) ) ) ) )

(defmethod branch-line ((view twist-down) branch)
  (position branch (branches view) :test #'eq)
)

(defmethod line-branch ((view twist-down) line)
  (aref (branches view) line)
)

(defmethod separator-size ((view twist-down))
  #-carbon-compat
  #@(1 1)
  #+carbon-compat
  (with-fore-color *red-color* ; with-pen-saved does not work for theme pen until MCL 5.1!
    (#_setThemePen #$kThemeBrushListViewSeparator 32 t) ;; needs correct values!
    (rlet ((pport (:pointer :grafport))
           (pensize :point))
      (#_GetPort pport)
      (%get-point (#_getportpensize (%get-ptr pport) pensize)))))

(defmethod line-height ((view twist-down))
  (max (font-line-height (view-font view)) 
       (point-v (triangle-size view))))

(defmethod triangle-size ((view twist-down))
  "The preferred size for the triangle (i.e. actual size of the icon)"
   #-carbon-compat
   (if (or *right-triangle* *down-triangle*) #@(16 16) #@(0 0))
   #+carbon-compat
   (rlet ((href :signed-long)
          (wref :signed-long))
     (#_getThemeMetric #$kThemeMetricDisclosureTriangleHeight href)
     (#_getThemeMetric #$kThemeMetricDisclosureTriangleWidth wref)
     (make-point
      (pref href :signed-long)
      (pref wref :signed-long))))

(defmethod line-corners ((view twist-down) line)
  "Returns the topleft and bottomright corners of the drawing rectangle for the assumed line"
  ; An eventual separator is not part of the line!
  (declare (fixnum line))
  (let* ((height (line-height view))
         (separator-height (point-v (separator-size view)))
         (top (* (+ height separator-height) line))
         (right (max (max-h-drawn view) (point-h (view-size view))))
         (bottom (+ top height)))
    (values
     (make-point 0 top)
     (make-point right bottom))))

(defmethod triangle-corners ((view twist-down) line level)
  "Returns the topleft and bottomright corners of the drawing rectangle for the twist down triangle of the assumed line"
  (multiple-value-bind (topleft bottomright)
                       (line-corners view line)
    (let* ((left (+ (point-h topleft)
                    (if (triangle-indent-p view)
                      (* (indent view) level)
                      0)
                    1))
           (line-height (- (point-v bottomright)(point-v topleft)))
           (triangle-size 
            (triangle-size view))
           (clearing (max 0 (floor (- line-height (point-v triangle-size)) 2)))
           (remainder (- line-height (point-v triangle-size) clearing clearing)) ; same as returned as second value from floor...
           )
      (values
       (make-point 
        left
        (+ (point-v topleft) clearing remainder))
       (make-point 
        (+ left (point-h triangle-size))
        (- (point-v bottomright) clearing))))))

(defmethod line-containing-point ((view twist-down) where)
  "Returns the visible line that contains the point, if any"
  (when (< (point-v where) (max-v-drawn view))
    (do ((max (length (branches view)))
         (line 0 (1+ line)))
        ((>= line max))
      (multiple-value-bind (topleft bottomright)
                           (line-corners view line)
        (rlet ((rect :rect :topleft topleft :bottomright bottomright))
          (cond
           ((#_PtInRect where rect)
            (return line))
           ((> (point-v bottomright)
               (point-v where))
            (return NIL))))))))

(defmethod line-width ((view twist-down) line-number)
  (let* ((branch (line-branch view line-number))
         (node (node branch))
         (string (funcall (node-string-function view) node))
         (font (branch-font view branch))
         (level (level branch))
         (indent (indent view))
        )
    ;       triangle     +   indentation  +    string-width
    (+ (line-height view) (* level indent) (string-width string font))
) )

(defmethod twist-down-children ((view twist-down) node)
  (funcall (children-function view) node))

;; Specialize this if you want speed:

(defmethod twist-down-children-p ((view twist-down) node)
  (when (twist-down-children view node)
    T))

(defmethod view-visible-lines ((view twist-down))
  "Returns the first and last line visible in the dialog item"
  (let* ((v-scroller (ccl::v-scroller view))
         (scroll-bar-setting (scroll-bar-setting v-scroller))
         (size (view-size view))
         (height (+ (line-height view)(point-v (separator-size view))))
         (top-line (floor scroll-bar-setting height))
         (bottom-line (floor (+ scroll-bar-setting (point-v size)) height)))
    (values top-line bottom-line)))

(defmethod separator-visible-p ((view twist-down))
  T)

(defmethod view-draw-contents ((view twist-down))
  (call-next-method)
  (multiple-value-bind (start end)
    (view-visible-lines view)
    (with-font-focused-view view
      (do ((max (min (1- (length (branches view))) end))
           (line start (1+ line)))
          ((> line max)
           (multiple-value-bind (topleft bottomright)
                                (line-corners view line)
             (declare (ignore bottomright))
             (with-back-color (or (part-color view :body) ccl::*lighter-gray-color*)
               #+carbon-compat
               (unless (part-color view :body)
                 ;; should use a proper value for pix depth!
                 (#_SetThemeBackground #$kThemeBrushListViewBackground 32 t))
               (rlet ((rect :rect :topleft topleft :bottomright (add-points (view-position view)(view-size view))))
                 (#_eraseRect rect)))))
        (draw-node view line)
        (draw-triangle view line)
        (when (separator-visible-p view)
          (multiple-value-bind (topleft bottomright)
                               (line-corners view line)
            (with-fore-color (or #|(separator-color view)|# *white-color*)
              #+carbon-compat
              (unless nil ; separator-color
                (#_setThemePen #$kThemeBrushListViewSeparator 32 t)) ;; need to fix depth!
              (#_MoveTo (point-h topleft) (point-v bottomright))
              (#_LineTo (point-h bottomright) (point-v bottomright)))))))))

(defmethod draw-triangle ((view twist-down) line)
 (multiple-value-bind (topleft bottomright)
                      (line-corners view line)
  (let* ((branches (branches view))
         (branch (when (< line (length branches)) (line-branch view line)))
         (node (when branch (node branch)))
         (children (when node (twist-down-children-p view node))) 
         ; (line-height (line-height view))
         (level (if branch (level branch) 0))
         (draw-active-p (window-active-p (view-window view))))
    (multiple-value-bind (icon-topleft icon-bottomright)
                        (triangle-corners view line level)
    (rlet ((clip-rect :rect 
                      :left (point-h icon-topleft) 
                      :top (point-v topleft) 
                      :right (point-h icon-bottomright)
                      :bottom (point-v bottomright))
           (icon-rect :rect :topleft icon-topleft :bottomright icon-bottomright))
      (with-back-color (or (part-color view :body) ccl::*lighter-gray-color*)
        #+carbon-compat
        (cond
         ((line-selected-p view line)
          ;; should use a proper value for pix depth!
          ;; see "Table View Highlighting Styles" at apple's developer connection for further improvements in osx 10.3
          (#_SetThemeBackground
           (if draw-active-p
             #-ignore -3 #+ignore #$kThemeBrushPrimaryHighlightColor 
             #-ignore -4 #+ignore #$kThemeBrushSecondaryHighlightColor)
           32 t))
          ((not (part-color view :body))
          ;; should use a proper value for pix depth!
          (#_SetThemeBackground #$kThemeBrushListViewBackground 32 t)))
        (#_EraseRect clip-rect)
        (when (and node children)
          (with-clip-rect clip-rect
            (let* ((downp (downp branch))
                   #-carbon-compat
                   (icon (if downp *down-triangle* *right-triangle*)))
              #-carbon-compat
              (when icon
                (#_PlotIconSuite
                 icon-rect
                 (+ #$atVerticalCenter #$atHorizontalCenter)
                 #-carbon-compat
                 (if (line-selected-p view line)
                   (if draw-active-p #$ttSelected #$ttSelectedDisabled)
                   (if draw-active-p #$ttNone #$ttDisabled)) 
                 #+carbon-compat 
                 (if (line-selected-p view line) 
                   (if draw-active-p #$kTransformSelected #$kTransformSelectedDisabled)
                   (if draw-active-p #$kTransformNone #$kTransformDisabled)) 
                 icon))
              #+carbon-compat ; Available with Appearance 1.1 and later!
              (rlet ((info :themebuttondrawinfo 
                           :state (if draw-active-p #$kThemeStateActive #$kThemeStateInactive)
                           :value (if downp #$kThemeDisclosureDown #$kThemeDisclosureRight) 
                           :adornment #$kThemeAdornmentDefault))
                (#_DrawThemeButton icon-rect #$kThemeDisclosureButton info (drawinfo branch) (%null-ptr) (%null-ptr) 0)
                (copy-record info :themebuttondrawinfo (drawinfo branch))))))
        #-carbon-compat
        (when (line-selected-p view line)
          (ccl::with-hilite-mode 
            (#_InvertRect clip-rect)))
) ) ) )))

(defmethod twist-down-draw-node ((view twist-down) node rect selected-p)
  "Draw the node within the boundaries"
  (let* ((topleft (rref rect :rect.topleft))
         (bottomright (rref rect :rect.bottomright))
         (string (when node (funcall (node-string-function view) node)))
         (icon-function (node-icon-function view))
         (top (point-v topleft))
         (height (- (point-v bottomright) top))
         #-carbon-compat
         (baseline (+ top -1 (floor (+ height (font-height)) 2)))
         (left (point-h topleft))
         (right (point-h bottomright))
         (bottom (point-v bottomright))
         (draw-active-p (window-active-p (view-window view))))
    (when icon-function
      (let ((icon (when icon-function (funcall icon-function node)))
            (adjust (floor (- height 16) 2)))
        (when icon
          (unless (eql icon T) ; icon is T means no icon but empty space
            (rlet ((clip-rect :rect
                              :left left
                              :top top 
                              :right (+ left 16 1) 
                              :bottom bottom)
                   (icon-rect :rect
                              :left left
                              :top (- bottom adjust 16) 
                              :right (+ left 16 1) 
                              :bottom (- bottom adjust)))
              (with-clip-rect clip-rect
                (if (handlep icon)
                  (#_PlotIconSuite
                   icon-rect
                   #$atAbsoluteCenter
                   #-carbon-compat
                   (if selected-p
                     (if draw-active-p #$ttSelected #$ttSelectedDisabled)
                     (if draw-active-p #$ttNone #$ttDisabled)) 
                   #+carbon-compat 
                   (if selected-p 
                     (if draw-active-p #$kTransformSelected #$kTransformSelectedDisabled)
                     (if draw-active-p #$kTransformNone #$kTransformDisabled)) 
                   icon)
                  #-carbon-compat
                  (warn "Invalid icon representation ~A" icon)
                  #+carbon-compat
                  (locally
                    (declare (ftype (function (t) t) ccl::iconref)) 
                    (when (method-exists-p 'ccl::iconref icon)
                      (let ((ref (ccl::iconref icon)))
                        (declare (dynamic-extent ref)
                                 (type (or macptr null) ref))
                        (when ref
                          (unwind-protect
                            (#_PlotIconRef icon-rect 
                             #$kAlignAbsoluteCenter 
                             (if selected-p 
                               (if draw-active-p #$kTransformSelected #$kTransformSelectedDisabled)
                               (if draw-active-p #$kTransformNone #$kTransformDisabled))
                             #$kIconServicesNormalUsageFlag 
                             ref)
                            (#_releaseIconref ref))))))))))
          (incf left 20))))
    (when string
        #-carbon-compat
        (with-pstrs ((str string))
          (#_MoveTo left baseline)
          (#_DrawString str))
        #+carbon-compat
        (with-cfstrs ((cftext string))
            (let* ((font-height (rlet ((size :point)
                                       (baseline :signed-word))
                                  (#_GetThemeTextDimensions cftext 
                                   #$kThemeCurrentPortFont
                                   (if draw-active-p #$kThemeStateActive #$kThemeStateInactive)
                                   NIL
                                   size
                                                      baseline)
                                               (point-v (pref size :point))))
                   (clearing (max 0 (floor (- height font-height) 2))))
              (rlet ((rect :rect 
                           :left left 
                           :top (+ top clearing) 
                           :right right 
                           :bottom (- bottom clearing)))
                (#_Drawthemetextbox cftext #$kThemeCurrentPortFont 
                 (if draw-active-p #$kThemeStateActive #$kThemeStateInactive)
                 t rect #$tejustleft (%null-ptr))))))))

(defmethod draw-node ((view twist-down) line)
  (multiple-value-bind (topleft bottomright)
                       (line-corners view line)
   (let* ((branches (branches view))
          (valid-line (< line (length branches)))
          (branch (when valid-line (line-branch view line)))
          (node (when branch (node branch)))
          (font (if branch (branch-font view branch) (view-font view)))
          (top (point-v topleft))
          #-carbon-compat
          (height (- (point-v bottomright) top))
          ;         (baseline (+ top (font-height font)))
          #-carbon-compat
          (baseline (+ top -1 (floor (+ height (font-height font)) 2)))
          (root-indent 17) 
          (left (+ root-indent (* (indent view) (if branch (level branch) 0))))
          (right (point-h bottomright))
          (bottom (point-v bottomright))
          (fore-color (when branch (branch-fore-color view branch)))
          (back-color (if branch (or (branch-back-color view branch) (part-color view :body))
                          (part-color view :body)))
          (draw-active-p (window-active-p (view-window view))))
     (rlet ((rect :rect :topleft topleft :bottomright bottomright))
       (with-back-color (or back-color ccl::*lighter-gray-color*)
         #+carbon-compat
         (cond
          ((line-selected-p view line)
           ;; should use a proper value for pix depth!
           ;; see "Table View Highlighting Styles" at apple's developer connection for further improvements in osx 10.3
           (#_SetThemeBackground
            (if draw-active-p
              #-ignore -3 #+ignore #$kThemeBrushPrimaryHighlightColor 
              #-ignore -4 #+ignore #$kThemeBrushSecondaryHighlightColor) 
            32 t))
          ((not back-color)
           ;; should use a proper value for pix depth!
           (#_SetThemeBackground #$kThemeBrushListViewBackground 32 t)))
         (#_EraseRect rect)
         (with-font-codes (font-codes font)
           (with-fore-color (or fore-color (if draw-active-p *black-color* *gray-color*))
             (if fore-color
               (unless draw-active-p
                 (#_TextMode #$grayishTextOr))
               ;; should use a proper value for pix depth!
               #+carbon-compat
               (#_SetThemeTextColor 
                (if draw-active-p #$kThemeTextColorListView #$kThemeTextColorDialogInactive) 
                32 t))
             (rlet ((rect :rect :top top :left left :bottom bottom :right right))
               (twist-down-draw-node view node rect (line-selected-p view line) ))
             #-carbon-compat
             (when (line-selected-p view line)
             (ccl::with-hilite-mode 
                  (#_InvertRect rect))))))))))

(defmethod line-node ((view twist-down) (line fixnum))
  (let* ((branches (branches view))
         (len (length branches))
        )
    (when (and (> line -1) (< line len)) (node (line-branch view line)))
) )

(defmethod line-level ((view twist-down) (line fixnum))
  (let* ((branches (branches view))
         (len (length branches))
        )
    (when (and (> line -1) (< line len)) (level (line-branch view line)))
) )

(defmethod line-downp ((view twist-down) (line fixnum))
  (let* ((branches (branches view))
         (len (length branches))
        )
    (when (and (> line -1) (< line len)) (downp (line-branch view line)))
) )

(defmethod branch-fore-color ((view twist-down) branch)
  (node-fore-color view (node branch) branch)
)

(defmethod node-fore-color ((view twist-down) node branch)
  (declare (ignore node branch))
  NIL ;*black-color*
)

(defmethod branch-back-color ((view twist-down) branch)
  (node-back-color view (node branch) branch)
)

(defmethod node-back-color ((view twist-down) node branch) 
  (declare (ignore node branch))
  NIL ; (or (part-color view :body) *white-color*)
)

(defmethod branch-font ((view twist-down) branch)
  (node-font view (node branch) (parent branch))
)

(defmethod node-font ((view twist-down) node parent)
  (declare (ignore node parent))
  (or (view-font view) (view-font (view-window view)))
)

(defmethod view-click-event-handler ((view twist-down) where)
  (let ((line (line-containing-point view where)))
    (if (not line)
      (call-next-method)
      (let* ((branch (line-branch view line))
             (level (if branch (level branch) 0))
             orig-downp)
        (multiple-value-bind (topleft bottomright)
                             (triangle-corners view line level)
          (rlet ((rect :rect :topleft topleft :bottomright bottomright))
            (cond
             ;Triangle 
             ((#_PtInRect where rect)
              (when (twist-down-children-p view (node branch))
                (with-focused-view view
                  (setf orig-downp (downp branch)
                        (downp branch) (not (downp branch))
                        )
                  (#_EraseRect rect)
                  (draw-triangle view line)
                  (#+ccl-5.1 ccl::with-timer #-ccl-5.1 progn
                   #+ignore ;; potential if wait-mouse-up-or-moved of MCL 5.1 gets a test!
                    (loop
                      (let ((inside (neq (downp branch) orig-downp)))
                        (labels ((crossed (pos)
                                   (if (#_PtInRect pos rect) (not inside) inside))
                                 #-ccl-5.1 ; mouse-kept-down-and-moved
                                 (wait-mouse-up-or-moved (test)
                                   (when (new-mouse-down-p)
                                     (or
                                      (funcall test (get-mouse-position))
                                      (wait-mouse-up-or-moved test)))))
                          (declare (dynamic-extent (function crossed)))
                          (if (wait-mouse-up-or-moved #'crossed)
                            (progn
                              (setf (downp branch) (not (downp branch)))
                              (#_EraseRect rect)
                              (draw-triangle view line)) 
                            (when inside
                              (expand-branch view branch (downp branch))
                              (return))))))
                   (do* ((now-where (view-mouse-position view) (view-mouse-position view))
                         (was-inp t inp)
                         (inp t (#_PtInRect now-where rect))
                         )
                        ((not #+ccl-5.1 (wait-mouse-up-or-moved) #-ccl-5.1 (mouse-down-p))
                         (when (neq orig-downp (downp branch))
                           ; (with-cursor *watch-cursor*
                             (expand-branch view branch (downp branch))
                             ) ;)
                         )
                     (when (neq was-inp inp)
                       (setf (downp branch) (not (downp branch)))
                       (#_EraseRect rect)
                       (draw-triangle view line)
                       ) ) ) )))
             (t (call-next-method))
             ) ) ) ))))

(defmethod view-click-event-handler :after ((view twist-down) where)
  (let* (;(h (point-h where))
         ;(v (point-v where))
         ;(height (line-height view))
         (line (line-containing-point view where))
         (branch (when line (line-branch view line)))
        )
    ;Rule out clicks in triangles, beyond bottom, or dragging.
    (when (and ; (< v (max-v-drawn view))
               branch
               (not (draggedp view))
               (or 
                (not (twist-down-children-p view (node branch)))
                (multiple-value-bind (topleft bottomright)
                                     (triangle-corners view line (level branch))
                  (rlet ((rect :rect :topleft topleft :bottomright bottomright))
                    (not (#_PtInRect where rect))))))
      (cond
        ((or (eq (selection-type view) :single) (not (shift-key-p)))
         (dolist (s (selected-lines view))
           (line-deselect view s)
           (invalidate-line view s)
         )
         (unless (and (eq (selection-type view) :leaves)
                      (twist-down-children-p view (node branch))
                 )
           (line-select view line)
        ))
        ((and (command-key-p) (shift-key-p))
         (ecase (selection-type view)
           (:leaves
             (let* ((branch (line-branch view line))
                    (parent (parent branch))
                    (node (node branch))
                    (children (twist-down-children-p view node))
                    (level (level branch))
                    (selected-1 (car (selected-lines view)))
                    (branch-1 (when selected-1 (line-branch view selected-1)))
                    (level-1 (when branch-1 (level branch-1)))
                    (parent-1 (when branch-1 (parent branch-1)))
                   )
               (unless children
                 (if level-1
                   (when (and (= level level-1) (eq parent parent-1))
                     (if (line-selected-p view line)
                       (line-deselect view line)
                       (line-select view line)
                   ) )
                   (line-select view line)
           ) ) ) )
           (:children
             (let* ((branch (line-branch view line))
                    (parent (parent branch))
                    (level (level branch))
                    (selected-1 (car (selected-lines view)))
                    (branch-1 (when selected-1 (line-branch view selected-1)))
                    (level-1 (when branch-1 (level branch-1)))
                    (parent-1 (when branch-1 (parent branch-1)))
                   )
               (if level-1
                 (when (and (= level level-1) (eq parent parent-1))
                   (if (line-selected-p view line)
                     (line-deselect view line)
                     (line-select view line)
                 ) )
                 (line-select view line)
           ) ) )
           (:multiple
             (if (line-selected-p view line)
               (line-deselect view line)
               (line-select view line)
           ) )
         )
        )
        ((shift-key-p)
         (if (selected-lines view)
           (ecase (selection-type view)
             (:leaves
               (let* ((selected-lines (selected-lines view))
                      (level (level (line-branch view (car selected-lines))))
                      (branch-1 (line-branch view (car selected-lines)))
                      branch
                      start-sel
                      end-sel
                     )
                 (setq selected-lines (sort selected-lines #'<))
                 (if (<= line (car selected-lines))
                   (setq start-sel line
                         end-sel (car (last selected-lines))
                   )
                   (setq start-sel (car selected-lines)
                         end-sel line
                 ) )
                 (do* ((l start-sel (1+ l)))
                     ((> l end-sel))
                   (setq branch (line-branch view l))
                   (when (and (= level (level branch))
                              (not (twist-down-children-p view (node branch)))
                              (branch-siblings-p branch branch-1)
                         )
                     (line-select view l)
             ) ) ) )
             (:children
               (let* ((selected-lines (selected-lines view))
                      (level (level (line-branch view (car selected-lines))))
                      (branch-1 (line-branch view (car selected-lines)))
                      branch
                      start-sel
                      end-sel
                     )
                 (setq selected-lines (sort selected-lines #'<))
                 (if (<= line (car selected-lines))
                   (setq start-sel line
                         end-sel (car (last selected-lines))
                   )
                   (setq start-sel (car selected-lines)
                         end-sel line
                 ) )
                 (do* ((l start-sel (1+ l)))
                     ((> l end-sel))
                   (setq branch (line-branch view l))
                   (when (and
                           (= level (level branch))
                           (branch-siblings-p branch
                                              branch-1
                         ) )
                     (line-select view l)
             ) ) ) )
             (:multiple
               (let* ((selected-lines (selected-lines view))
                      start-sel
                      end-sel
                     )
                 (setq selected-lines (sort selected-lines #'<))
                 (if (<= line (car selected-lines))
                   (setq start-sel line
                         end-sel (car (last selected-lines))
                   )
                   (setq start-sel (car selected-lines)
                         end-sel line
                 ) )
                 (do ((i start-sel (1+ i)))
                     ((> i end-sel))
                   (line-select view i)
             ) ) )
           )
           (line-select view line)
         )
        )
  ) ) )
  ;I love it when they don't call-next-method.  :-(
  #+ignore ; covered by MCL 5.1 (if not before)
  (let ((fn (dialog-item-action-function view)))
    (when fn (funcall fn view))
) )

(defclass branch ()
  ((node
     :documentation "The node represented at this branch."
     :accessor node
     :initarg :node
     :initform nil
   )
   (parent
     :documentation "The parent represented at this branch."
     :accessor parent
     :initarg :parent
     :initform nil
   )
   (downp
     :documentation "Flag to indicate if this branch is down."
     :accessor downp
     :initarg :downp
     :initform nil
     :type boolean)
   #+carbon-compat
   (drawinfo
    :documentation "Most recent drawinfo, for transition effects when drawing the triangle"
    :reader drawinfo
    :initform (make-record :themebuttondrawinfo :state 0 :value 0 :adornment 0))
   (level
     :documentation "A fixnum representing the indentation level."
     :accessor level
     :initarg :level
     :initform 0
     :type fixnum
   )
   (id
     :documentation "A list of the unique path used to reach this branch."
     :accessor id
     :initarg :id
     :initform nil
     :type list
   )
  )
  (:documentation "Representation of one branch in a twist-down.")
)

(defmethod register-branch ((view twist-down) branch)
  (setf (gethash (id branch) (branch-cache view)) branch)
)

(defmethod get-branch ((view twist-down) (key list) node)
  (declare (ignore node))
  (or
    (gethash key (branch-cache view))
    (register-branch
      view
      (make-instance 'branch
        :node (car key)
        :id key
        :parent (cadr key)
        :level (1+ (level (get-branch view (cdr key) nil)))
) ) ) )

(defmethod get-branch ((view twist-down) (parent-branch branch) node)
  (let ((key (cons node (id parent-branch)))
        (cache (branch-cache view))
       )
    (or
      (gethash key cache)
      (register-branch
        view
        (make-instance 'branch
          :node node
          :id key
          :parent (node parent-branch)
          :level (1+ (level parent-branch))
) ) ) ) )

(defmethod branch-siblings-p ((branch1 branch) (branch2 branch))
  (equal (cdr (id branch1)) (cdr (id branch2)))
)

(defmethod expand-branch :before ((view twist-down) (branch branch) expandp)
  (declare (ignore view))
  (setf (downp branch) expandp))

(defmethod expand-branch ((view twist-down) (branch branch) (expandp null))
  "Collapse the branch"
    (let* ((branch-pos (branch-line view branch))
           (lines (branches view))
           (test #'(lambda (x) (<= x (level branch))))
           (key #'level)
           (end-pos (position-if test lines :start (1+ branch-pos) :key key))
           (end-pos (if end-pos (1- end-pos) (1- (length lines))))
           (subtracted-length (- end-pos branch-pos))
           (original-length (length lines))
           (new-length (- original-length subtracted-length))
           (max-h (max-h-drawn view))
           (new-max-h-p nil)
          )
      ;See if max-h will change and remember
      (do ((i (1+ branch-pos) (1+ i)))
          ((or (= i (1+ end-pos)) new-max-h-p))
        (when (= max-h (line-width view i))
          (setq new-max-h-p t)
      ) )
      (do ((i (1+ branch-pos) (1+ i)))
          ((>= i new-length)
           (invalidate-corners view (line-corners view i) (nth-value 1 (line-corners view original-length)))
           #+ignore
           (do ((j i (1+ j)))
               ((= j original-length))
             (invalidate-line view j)
           )
          )
        (setf (aref lines i) (aref lines (+ i subtracted-length)))
        (when (line-selected-p view i) (line-deselect view i))
        (when (line-selected-p view (+ i subtracted-length))
          (line-deselect view (+ i subtracted-length))
          (line-select view i)
        )
        (invalidate-line view i)
      )
      (dolist (l (selected-lines view))
        (when (>= l new-length) (line-deselect view l))
      )
      (adjust-array lines new-length :fill-pointer new-length)
;      (setf (fill-pointer lines) new-length)
      ;Search for new max-h among remaining lines, when needed
      (when new-max-h-p
        (setf (max-h-drawn view) 0)
        (dotimes (i new-length)
          (setf (max-h-drawn view)
                (max (max-h-drawn view) (line-width view i))
          )
      ) )
    ))

(defmethod expand-branch ((view twist-down) (branch branch) expandp)
  "Normal expansion of a branch"
  (assert expandp)
    (let* ((branch-pos (branch-line view branch))
           (node (node branch))
           (children (twist-down-children view node))
           (added-length (length children))
           (lines (branches view))
           (original-length (length lines))
           (new-length (+ original-length added-length))
           (level (1+ (level branch)))
          )
      (adjust-array lines new-length :fill-pointer new-length)
      (do* ((i (1- new-length) (1- i)))
           ((= (- i added-length) branch-pos))
        (setf (aref lines i) (aref lines (- i added-length)))
        (when (line-selected-p view (- i added-length))
          (line-deselect view (- i added-length))
          (line-select view i)
        )
        #+ignore
        (invalidate-line view i)
      )
     (invalidate-triangle view branch-pos)
      (dolist (child children)
        (incf branch-pos)
        (setf (aref lines branch-pos) (get-branch view branch child)
              (level (get-branch view branch child)) level
              ;recalc max-h for child, still needed?
              (max-h-drawn view)
              (max (max-h-drawn view) (line-width view branch-pos))
              )
        #+ignore
        (invalidate-line view branch-pos)
        )
      (dolist (child children)
        (let ((branch (get-branch view branch child)))
          (when (downp branch)
            (expand-branch view branch t)
      ) ) )
      (invalidate-corners view 
                          (line-corners view (branch-line view branch))
                          ;(+ (scroll-bar-setting (ccl::v-scroller view))
                          ;   (point-v (view-size view))))
                          (add-points (view-origin view)
                                      (add-points (view-position view)
                                                  (view-size view))))
                          ;(make-point (max-h-drawn view) (max-v-drawn view)))
;                          (nth-value 1 (line-corners view (+ branch-pos added-length))))
      #+ignore
      (do ((i (1+ branch-pos) (1+ i)))
          ((>= i (+ branch-pos added-length)))
        (invalidate-line view i)
      )
    )
  )

(defmethod expand-branch :after ((view twist-down) (branch branch) expandp)
  "Calculate the new max-v"
  (declare (ignore expandp))
  (declare (ignore branch))
  (update-max-v-drawn view)
  (redo-scroll-bars view)
)

(defmethod set-view-size :after ((view twist-down) h &optional v)
  (declare (ignore h v))
  (redo-scroll-bars view)
)

(defmethod redo-scroll-bars ((view twist-down))
  (ccl::update-scroll-bars view :length t)
  (let* ((h-scroll (ccl::h-scroller view))
         (h-setting (if h-scroll (scroll-bar-setting h-scroll) 0))
         (h-max (if h-scroll (scroll-bar-max h-scroll) 0))
         (v-scroll (ccl::v-scroller view))
         (v-setting (if v-scroll (scroll-bar-setting v-scroll) 0))
         (v-max (if v-scroll (scroll-bar-max v-scroll) 0))
        )
    ;Correct for when visible becomes < than view-size, but is off-screen.
    (when (or (> h-setting h-max) (> v-setting v-max))
      (setq h-setting (min h-setting h-max))
      (setq v-setting (min v-setting v-max))
      (set-view-scroll-position view h-setting v-setting)
    )
) )

; This is perhaps no longer always correct in the 3.0 version?

(defmethod complete-rebuild ((view twist-down))
  (with-cursor *watch-cursor*
    (let* ((branches (branches view))
           (root-branch (aref branches 0))
          )
      (adjust-array branches 1 :fill-pointer 1)
;      (setf (fill-pointer branches) 1)
      (expand-branch view root-branch (downp root-branch))
) ) )

;;;;editable-twist-down
(defclass editable-twist-down (#|droppable-svm|# key-handler-mixin twist-down)
  ((cut-function
     :documentation "Function to break parent-child link."
     :accessor cut-function
     :initarg :cut-function
     :initform #'false
     :type function)
   (paste-function
     :documentation "Function to forge parent-child link."
     :accessor paste-function
     :initarg :paste-function
     :initform #'false
     :type function)
   (ancestorp-function
     :documentation "Predicate for a given node and potential ancestor."
     :accessor ancestorp-function
     :initarg :ancestorp-function
     :initform #'false
     :type function)
   (orphan-warning-p
     :documentation
     "Flag for whether or not to warn when user cut creates an orphan."
     :accessor orphan-warning-p
     :initarg :orphan-warning-p
     :initform t
     :type boolean)
   (scrapper
     :documentation "OSType of scrap-handler to use."
     :accessor scrapper
     :initarg :scrapper
     :initform *td*
     :type keyword))
  (:documentation "Allows editing of a heterarchy displayed by a twist-down."))

(defmethod initialize-instance :after ((view editable-twist-down) &key selection-type)
  (when (eq selection-type :multiple)
    (error "Editable-twist-down does not support selection-type :multiple.")
) )

(defmethod cut ((view editable-twist-down))
  (with-cursor *watch-cursor*
    ;Non-local exit at attempt to cut root.
    (when (and (find 0 (selected-lines view))
               (eq (line-node view 0) (root view)))
      (cut-root view)
      (return-from cut)
    )
    ;Non-local exit at user discretion.
    (when (and (orphan-warning-p view)
               (find 1 (selected view)
                     :key
                     #'(lambda (n)
                         (length (funcall (parents-function view) n)))))
      (ed-beep)
      (unless (eq t
                  (catch-cancel
                    (y-or-n-dialog
                     "Data will be lost unless you paste.  Continue?"
                     :cancel-text nil)))
        (return-from cut)
    ) )
    (let* ((selected (copy-list (selected-lines view)))
           (selected (sort selected #'<))
           (first-line (car selected))
           (branches (branches view))
           (first-branch (aref branches first-line))
           (parent-id (cdr (id first-branch)))
           (parent-branch (gethash parent-id (branch-cache view)))
           (parent-line (position parent-branch branches :test #'eq))
           (cut (cut-function view))
           (cutees (selected view))
           (parent (node parent-branch))
           (len (length branches))
           (holes 0)
           goner
           goner-level
           keeper
          )
      (put-scrap (scrapper view) cutees nil)
      (dolist (cutee cutees) (funcall cut parent cutee))
      ;Deselect
      (dolist (l selected) (line-deselect view l))
      ;Delete selected and visible descendents from display.
      (do ((i first-line (1+ i)))
          ((>= (+ i holes) len))
        (when (and selected (= i (car selected)))
          (setq goner (pop selected))
          (setq goner-level (level (line-branch view goner)))
          ;Search for next element that's a keeper.
          (setq keeper nil)
          (do* ((k (1+ goner) (1+ k)))
               ((or (>= k len) keeper))
            ;Right level means it's a keeper...
            (when (<= (level (aref branches k)) goner-level)
              (setq keeper k)
            )
            ;Unless it is also cut, of course.
            (when (and selected (= k (car selected)))
              (pop selected)
              (setq keeper nil)
          ) )
          (if keeper
            (incf holes (- keeper goner))
            (incf holes (- len goner))
          )
        )
        (unless (>= (+ i holes) len)
          (setf (aref branches i) (aref branches (+ i holes)))
        )
        (invalidate-line view i)
      )
      ;Shrink it
      (setf (fill-pointer branches) (- len holes))
      ;Invalidate the new blanks
      (do ((i (- len holes) (1+ i)))
          ((>= i len))
        (invalidate-line view i)
      )
      ;Select parent so paste is undo.
      (line-select view parent-line)
      ;Update other paths to parent.
      (invalidate-node view parent)
) ) )

(defmethod cut-root ((view editable-twist-down))
  (ed-beep)
  (message-dialog "You cannot cut the root.")
)

(defmethod copy ((view editable-twist-down))
  (put-scrap (scrapper view) (selected view) nil)
)

(defmethod paste ((view editable-twist-down))
  ;Multiple paste is irreversible.
  (when (> (length (selected-lines view)) 1)
    (ed-beep)
    (unless (eq t
              (y-or-n-dialog
               "Paste under multiple parents is irreversible.  Continue?"
               :cancel-text nil))
      (return-from paste)
  ) )
  (with-cursor *watch-cursor*
    (let* ((paste (paste-function view))
           (pastees (get-scrap (scrapper view)))
           (selected (selected-lines view))
           (parent-line (car selected))
           (parent-branch (aref (branches view) parent-line))
           (parent (node parent-branch))
           (reversiblep (= (length selected) 1))
           (parent-level (level parent-branch))
           (paste-level (1+ parent-level))
           branches
           len
           pos
          )
      (dolist (l selected) (line-deselect view l) (invalidate-line view l))
      (expand-branch view parent-branch nil)
      (dolist (pastee pastees)
        (funcall paste parent pastee)
      )
      (expand-branch view parent-branch t)
      (setf (downp parent-branch) t)
      (setq branches (branches view))
      (setq len (length branches))
      (when reversiblep
        (dolist (pastee pastees)
          ;Search only among those of the correct level and reasonable line#.
          (setq pos nil)
          (do ((i (1+ parent-line) (1+ i)))
              ((or (= i len) pos (< (level (aref branches i)) paste-level)))
            (let* ((branch (aref branches i))
                   (level (level branch))
                   (node (node branch))
                  )
              (when (and (= level paste-level) (eq node pastee))
                (setq pos i)
                (line-select view i)
) ) ) ) ) ) ) )

(defmethod clear ((view editable-twist-down))
  (with-cursor *watch-cursor*
    ;Non-local exit at attempt to cut root.
    (when (find 0 (selected-lines view))
      (clear-root view)
      (return-from clear)
    )
    ;Non-local exit at user discretion.
    (when (and (orphan-warning-p view)
               (find 1 (selected view)
                     :key
                     #'(lambda (n)
                         (length (funcall (parents-function view) n)))))
      (ed-beep)
      (unless (eq t
                  (catch-cancel
                    (y-or-n-dialog
                     "Data will be lost permanently.  Continue?"
                     :cancel-text nil)))
        (return-from clear)
    ) )
    (let* ((selected (copy-list (selected-lines view)))
           (selected (sort selected #'<))
           (first-line (car selected))
           (branches (branches view))
           (first-branch (aref branches first-line))
           (parent-id (cdr (id first-branch)))
           (parent-branch (gethash parent-id (branch-cache view)))
           (parent-line (position parent-branch branches :test #'eq))
           (cut (cut-function view))
           (cutees (selected view))
           (parent (node parent-branch))
           (len (length branches))
           (holes 0)
           goner
           goner-level
           keeper
          )
      (dolist (cutee cutees) (funcall cut parent cutee))
      ;Deselect
      (dolist (l selected) (line-deselect view l))
      ;Delete selected and visible descendents from display.
      (do ((i first-line (1+ i)))
          ((>= (+ i holes) len))
        (when (and selected (= i (car selected)))
          (setq goner (pop selected))
          (setq goner-level (level (line-branch view goner)))
          ;Remove cached branch if it clearing.
          (unless (funcall (parents-function view)
                           (node (line-branch view goner)))
            (remhash (id (line-branch view goner)) (branch-cache view))
          )
          ;Search for next element that's a keeper.
          (setq keeper nil)
          (do* ((k (1+ goner) (1+ k)))
               ((or (= k len) keeper))
            ;Right level means it's a keeper...
            (when (<= (level (aref branches k)) goner-level)
              (setq keeper k)
            )
            ;Unless it is also cut, of course.
            (when (and selected (= k (car selected)))
              (pop selected)
              (setq keeper nil)
          ) )
          (if keeper
            (incf holes (- keeper goner))
            (incf holes (- len goner))
          )
        )
        (unless (>= (+ i holes) len)
          (setf (aref branches i) (aref branches (+ i holes)))
        )
        (invalidate-line view i)
      )
      ;Shrink it
      (setf (fill-pointer branches) (- len holes))
      ;Invalidate the new blanks
      (do ((i (- len holes) (1+ i)))
          ((= i len))
        (invalidate-line view i)
      )
      ;Select parent so paste is undo.
      (line-select view parent-line)
      ;Update other paths to parent.
      (invalidate-node view parent)
) ) )

(defmethod clear-root ((view editable-twist-down))
  (ed-beep)
  (message-dialog "You cannot cut the root.")
)

(defmethod view-key-event-handler ((view editable-twist-down) char)
  (when (or (char-equal char #\Delete) (char-equal char #\DEL))
    (clear view)
) )

(defmethod window-can-do-operation ((view editable-twist-down) action &optional menu)
  (declare (ignore menu))
  (case action
    ((cut clear copy) (selected-lines view))
    (select-all
      (and (selected-lines view)
           (not (equal '(0) (selected-lines view)))
           (member (selection-type view) '(:leaves :children))
    ) )
    (paste
      (and
        (selected-lines view)
        (multiple-value-bind (scrap scrapp) (get-scrap (scrapper view))
          (declare (ignore scrap))
          scrapp
) ) ) ) )

(defmethod line-select :after ((view editable-twist-down) line)
  (declare (ignore view line))
  (menu-update *edit-menu*)
)

(defmethod line-deselect :after ((view editable-twist-down) line)
  (declare (ignore view line))
  (menu-update *edit-menu*)
)

(defmethod select-all ((view editable-twist-down))
  (let* ((selected-line (car (selected-lines view)))
         (branches (branches view))
         (selected-branch (aref branches selected-line))
         (selected-level (level selected-branch))
         (parent-level (1- selected-level))
         (parent-line
           (position parent-level branches
                 :from-end t :test #'= :end selected-line :key #'level
         ) )
         (len (length branches))
        )
    (do ((i (1+ parent-line) (1+ i))
         (done nil)
        )
        ((or (= i len) done))
      (let ((level (level (aref branches i))))
        (if (= level selected-level)
          (line-select view i)
          (if (< level selected-level)
            (setq done t)
) ) ) ) ) )


;;;;When will the MCL team realize that things other than text can be edited?
(defmethod view-cursor ((view editable-twist-down) where)
  (declare (ignore where))
  *arrow-cursor*
)


;;;;Perhaps the easiest scrap-handler ever...steal MCL's!
(defclass td-scrap-handler (ccl::lisp-scrap-handler) ())

(push (cons *td* (make-instance 'td-scrap-handler)) *scrap-handler-alist*)

#|

(in-package :twist-down)

;;; MINIMALISTIC DEMO

(add-subviews
  (make-instance 'window :view-size #@(120 275))
  (make-instance 'twist-down :root '(a (b c) ((d e) f))))



;;; A FAMILY AFFAIR

(defparameter *children* (make-hash-table :test #'eq))
(defparameter *parents* (make-hash-table :test #'eq))

(defun beget (parent child)
  (push child (gethash parent *children*))
  (push parent (gethash child *parents*))
)

(defun disown (parent child)
  (setf
    (gethash parent *children*) (delete child (gethash parent *children*))
    (gethash child *parents*) (delete parent (gethash child *parents*))
) )

(defun child-parents (child)
  (gethash child *parents*))

(defun ancestorp (parent child)
  (let ((parents (child-parents child)))
    (dolist (p parents)
       (when (or (eq p parent)
                 (ancestorp parent p))
         (return T)))))

(beget '|Animal| '|Dog|)
(beget '|Animal| '|Cat|)
(beget '|Animal| '|Human|)
(beget '|Dog| '|Werewolf|)
(beget '|Cat| '|Patience Phillips|)
(beget '|Dog| '|Snoopy|)
(beget '|Dog| '|Odie|)
(beget '|Cat| '|Garfield|)
(beget '|Cat| '|Felix|)
(beget '|Human| '|Patience Phillips|)
(beget '|Human| '|Werewolf|)
(beget '|Human| '|Mike|)
(beget '|Human| '|Martha|)
(beget '|Human| '|Me|)
(beget '|Human| '|You|)
(beget '|Me| '|None that I know of :-)|)
(beget '|You| '|How should I know?!!!|)
(beget '|Mike| '|Ariela|)
(beget '|Martha| '|Ariela|)

#+carbon-compat
(defmethod ccl::iconref ((icon (eql 'person-icon)))
  (rlet ((iconref :iconref))
    (ccl::errchk (#_getIconRef #$kOnSystemDisk #$kSystemIconsCreator #$kUserIcon iconref))
    (pref iconref :iconref)))

(defun sample ()
  (make-instance 'editable-twist-down
    :root '|Animal|
    :children-function #'(lambda (node) (gethash node *children*))
    :view-position #@(0 30)
    :view-size #@(235 255)
    :node-string-function #'string
    :node-icon-function 
      #+carbon-compat (lambda (node) 
                        (when (ancestorp '|Human| node)  
                          'person-icon)) 
      #-carbon-compat NIL
    :part-color-list `(:body ,*light-blue-color*)
    :cut-function #'disown
    :paste-function #'beget 
    :parents-function #'child-parents
    :selection-type :children
    :view-nick-name 'sample
    :down-paths '((|Odie| |Dog| |Animal|) (|Me|))
    :selected '(|Me|)
    :dialog-item-action
    #'(lambda (item)
        (if (= 1 (length (selected-lines item)))
          (dialog-item-enable (view-named 'new (view-window item)))
          (dialog-item-disable (view-named 'new (view-window item)))
      ) )
) )

(defclass sample-dialog (dialog)
  ()
  (:default-initargs
   :back-color *light-gray-color*
   :theme-background T
))

(defmethod set-view-size :after ((view sample-dialog) h &optional v)
  (let* ((size (make-point h v))
         (h (point-h size))
         (v (point-v size))
        )
    (set-view-size (view-named 'sample view) (- h 15) (- v 45))
) )

(add-subviews
  (make-instance 'sample-dialog
    :window-title "We Can Change The World!"
    :view-size #@(250 300)
    :color-p t
    :grow-icon-p t)
  (sample)
  (make-instance 'button-dialog-item
    :view-nick-name 'new
    :dialog-item-text "New"
    :dialog-item-enabled-p NIL
    :view-position #@(2 2)
    :view-size #@(50 18)
    :dialog-item-action
    #'(lambda (item)
        (let* ((child (get-string-from-user "Enter New Object:"))
               (child (intern child :cl-user))
               (td (view-named 'sample (view-window item)))
               (line (car (selected-lines td)))
               (branch (aref (branches td) line))
               (parent (node branch))
              )
          (beget parent child)
          (expand-branch td branch nil)
          (expand-branch td branch t)
          (setf (downp branch) t)
          (line-deselect td line)
          (line-select td (1+ line))
      ) )
) )

;;;;Something a little more...real.  :-]

(defun sample-click-handler (td)
  "twist-down
Allows you to view any branch of the CLOS hierarchy."
  (if (double-click-p)
    (dolist (node (selected td))
      (make-instance 'sample2-dialog
        :window-title (string-capitalize (class-name node))
        :view-position :centered
        :view-size #@(315 271)
        :color-p t
        :grow-icon-p t
        :view-subviews
        (list
          (make-instance 'twist-down
            :view-nick-name 'clos
            :root node
            :items-function NIL
            :children-function
            #'(lambda (class)
                (sort (copy-list (class-direct-subclasses class))
                      #'string-lessp
                      :key #'(lambda (class) (string (class-name class)))
              ) )
            :view-position #@(0 0)
            :view-size #@(300 256)
            :dialog-item-action 'sample-click-handler
            :node-string-function
            #'(lambda (class) (string-capitalize (class-name class)))
) ) ) ) ) )

(defparameter *sample-2*
  (make-instance 'twist-down
    :view-nick-name 'clos
    :root (find-class 't)
    :triangle-indent-p t
    :items-function nil
    :children-function
    #'(lambda (class)
        (sort (copy-list (class-direct-subclasses class))
              #'string-lessp
              :key #'(lambda (class) (string (class-name class)))
      ) )
    :view-position #@(0 0)
    :view-size #@(300 256)
    :dialog-item-action #'sample-click-handler
    :node-string-function
    #'(lambda (class) (string-capitalize (class-name class)))
) )


(defclass sample2-dialog (dialog)
  ()
  (:default-initargs
    :auto-position :STAGGERPARENTWINDOW
    :grow-icon-p t 
    :color-p t
    :window-type :document-with-zoom
  )
)

(defmethod set-view-size :after ((view sample2-dialog) h &optional v)
  (let* ((size (make-point h v))
         (real-h (point-h size))
         (real-v (point-v size))
        )
    (set-view-size (view-named 'clos view) (- real-h 15) (- real-v 15))
) )

(application-name *application*)
(lisp-implementation-version)

(add-subviews
  (make-instance 'sample2-dialog
    :window-title (lisp-implementation-type)
    :view-position :centered
    :view-size #@(315 271)
  )
  *sample-2*
)

|#
