;; Copyright (2004) Sandia Corporation. Under the terms of Contract DE-AC04-94AL85000 with
;; Sandia Corporation, the U.S. Government retains certain rights in this software.

;; Sandia National Laboratories grants you the rights to distribute
;; and use this software as governed by the terms
;; of the Lisp Lesser GNU Public License
;; (http://opensource.franz.com/preamble.html),
;; known as the LLGPL.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Lesser General Public License for more details.

;;; Databrowser.lisp
;;; Version 1.03

;;; Developed by Shannon Spires (svspire@sandia.gov) with the gracious assistance of Terje Norderhaug (terje@in-progress.com)
;;; and others in the MCL community.

;;; Latest Apple documentation is here:
;;;  http://developer.apple.com/documentation/Carbon/Conceptual/display_databrowser/index.html#//apple_ref/doc/uid/TP30000968

; to change to column view (sort of works. Likely to crash. not yet complete):
; (#_Setdatabrowserviewstyle handle #$kDataBrowserColumnView)

;;; HISTORY
;;; 03-feb-2010  Terje New redraw-column method.
;;; 03-feb-2010  Terje Released version 1.02 to MCL repository.
;;; 03-feb-2010  Terje ignore patch of ccl::set-view-font-codes for ccl-5.2.
;;; 03-feb-2010  Terje Notification proc ignores event 1001 (happens when clicking the header of a column).
;;; 03-feb-2010  Terje Databrowser has a min-row-height that controls the minimum height of the rows.
;;; July 6, 2009 Terje Changed defpascal to have :upp-creator in def instead of add-pascal-upp-alist (for compatability with cfm/macho)
;;; August 27, 2004 Version 1.02a6. 
;;; August 3, 2004 Version 1.02a1. Many suggestions and improvements from Terje.
;;; July 2004 Version 1.1. Initial limited release under LLGPL.


#|
scroll wheel support under OSX (this was a real bear and it's still not done in the politically-correct manner)
lots of new introspection functions on columns, rows, scrollbars
simplified and cleaned up the API
key handler behavior so arrow keys etc. work
rightarrow twists a container open, left closes it
option-rightarrow twists a container open recursively
:WITH-SECONDS option so times can show seconds
employee-browser example
databrowser-reveal-row is working
editing cells API is working (even on Classic)
|#

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :browser)
    (defpackage "DATABROWSER"
      (:nicknames :brw :browser)
      (:export "DATABROWSER-ITEM-CHILDREN"
               "DATABROWSER-ITEM-PARENT"
               "DATABROWSER-ITEM-CONTAINERP"
               "DATABROWSER-ROW-OBJECT"
               "DATABROWSER-OBJECT-ROW"
               "COLLECTION-DATABROWSER"
               "DATABROWSER-UPDATE"
               "DATABROWSER-REMOVE-ALL"
               "DATABROWSER-REMOVE-ITEMS"
               "DATABROWSER-REVEAL-ROW"
               "DATABROWSER-REVEAL-DATA"
               "DATABROWSER-ADD-ITEMS"
               "DATABROWSER-ALLOW-EDITS"
               "DATABROWSER-SELECTED-ROWS"
               "DATABROWSER-STATE"
               "DATABROWSER-ITEM-ADDED"
               "DATABROWSER-ITEM-REMOVED"
               "DATABROWSER-EDIT-STARTED" 
               "DATABROWSER-EDIT-STOPPED"
               "DATABROWSER-ITEM-SELECTED"
               "DATABROWSER-ITEM-DESELECTED"
               "DATABROWSER-ITEM-DOUBLE-CLICKED"
               "DATABROWSER-CONTAINER-OPENED"
               "DATABROWSER-CONTAINER-CLOSING"
               "DATABROWSER-CONTAINER-CLOSED"
               "DATABROWSER-CONTAINER-SORTING"
               "DATABROWSER-CONTAINER-SORTED"
               "DATABROWSER-TARGET-CHANGED"
               "DATABROWSER-USER-STATE-CHANGED"
               "DATABROWSER-SELECTION-SET-CHANGED" 
               "DATABROWSER-USER-TOGGLED-CONTAINER")
               (:use "CL" "CCL"))))

(in-package :brw)

; Put event-handler-patch.lisp in your Examples folder if this chokes.
#-ccl-5.2
(eval-when (:load-toplevel :execute)
  (unless (fboundp 'ccl::scroll-wheel-handler)
    (require "EVENT-HANDLER-PATCH")))

(in-package :databrowser)

(defparameter *log-browser-errors* t "True if you want errors that occur during browser callbacks logged.")

(defparameter *browser-log-stream* *error-output* "Where to log browser errors that occur during callbacks,
     as well as nonfatal messages if any. Set to nil for no logging whatsoever.")

(defvar *debug* t "True if you want interactive debugging features of the databrowser enabled.")

; Improvements needed:
; Documentation
; Change employee-browser to use CLOS so automatic setf accessor mechanism will work.
; Drag callbacks
; Get discontiguous multiple selections working with command key. DONE.
; Move #'find-thing-with-string to here from file-browser and make it general-purpose.
; 
; Colored text in cells. See GrabBag example for how to use a custom drawing proc to do this:
;   http://developer.apple.com/samplecode/Sample_Code/Human_Interface_Toolbox/Mac_OS_High_Level_Toolbox/GrabBag.htm
; Italic and bold text in cells.
; Cmd-A to select all.
; Other :PROPERTY-TYPEs like :PROGRESS-BARs, :POPUP, etc.
; Anything else the Carbon databrowser supports that we're not supporting now.
; Column view API (probably not until Apple documents it for Carbon). IN PROGRESS.
; Add a self-identifying Row ID that optionally shows up in the table.

(require :appearance-manager "ccl:examples;appearance-manager-folder;appearance-manager.lisp")
(require :new-control-dialog-item)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DATABROWSER

(defclass databrowser (key-handler-mixin ccl::new-control-dialog-item)
  ((display-nil-as-blank :initarg :display-nil-as-blank :initform t :accessor display-nil-as-blank
                         :documentation "True if you want to display NIL values returned
                   from lookup-browser-data as blank strings. Generally, this is what
                   you want unless you're building some kind of Lisp inspector. If
                   false, NILs are displayed as the string 'NIL'.")
   (draggable-columns :initarg :draggable-columns :initform t :accessor draggable-columns
                      :documentation "True if you want the browser's columns to be reorderable by dragging.")
   (selection-type :initarg :selection-type :initform nil :accessor
                    selection-type
                    :type (member nil :single :contiguous :disjoint)
                    :documentation "One of (nil :single :contiguous :disjoint). nil is the default
                    case, which seems to be the same as :disjoint.")
   (allow-edits :initarg :allow-edits :initform t :accessor databrowser-allow-edits
                :documentation "Global editing control disabler for the browser. If this is nil, editability
                                of all items in the browser is shut off, even for columns that are created to be editable.
                                Won't stop an edit if one is currently under way.")
   (vscrollp :initarg :vscrollp :initform t :accessor vscrollp
             :documentation "True if you want a vertical scrollbar initially.")
   (hscrollp :initarg :hscrollp :initform t :accessor hscrollp
             :documentation "True if you want a horizontal scrollbar initially.")
   (focus-ring :initarg :focus-ring :initform nil :accessor focus-ring
               :documentation "True if you want a focus ring to appear around the browser widget as a whole,
                  to indicate when it has focus. Usually this should be nil when the browser is the only widget
                  in the window.")
   (min-row-height :initarg :min-row-height :initform nil :accessor min-row-height
                   :type (or null fixnum)
                   :documentation "An optional minimum height in pixels for the rows.")
   (children-function 
    :reader children-function 
    :initarg :children-function 
    :initform NIL :type (or function null)
    :documentation "Function that provides the children of an item")
   (parent-function 
    :reader parent-function 
    :initarg :parenten-function 
    :initform NIL :type (or function null)
    :documentation "Function that provides the parent of an item")
   ))

(defmethod finish-initializing ((browser databrowser))
  (with-slots (selection-type vscrollp hscrollp) browser
    (#_SetDataBrowserHasScrollBars (dialog-item-handle browser) hscrollp vscrollp) ; can do this anytime so we might as well do it here
    (let ((handle (dialog-item-handle browser)))
      (case selection-type
        (:single (#_SetDataBrowserSelectionFlags handle #$kDataBrowserSelectOnlyOne))
        (:contiguous (#_SetDataBrowserSelectionFlags handle #$kDataBrowserNoDisjointSelection))
        
        ; Following seems to be the default case with the databrowser if you don't do anything.
        (:disjoint (#_SetDataBrowserSelectionFlags handle (logior #$kDataBrowserCmdTogglesSelection #$kDataBrowserDragSelect))))
      )))

;;; FIXES:

; The Databrowser (at least in Classic and OSX 10.2.8) should not have a back color as it will fill the parent window (possibly an OS bug).

(defmethod back-color ((item databrowser))
  #+ignore
  (unless (osx-p)
    (call-next-method)))

#-ccl-5.2
(defmethod ccl::set-view-font-codes ((item ccl::new-control-dialog-item) 
                                ff ms
                                &optional
                                ff-mask 
                                ms-mask)
  (when (ccl::installed-item-p item)
   (let ((bgcolor (or (back-color item)
                      (unless (and #+ignore (osx-p) 
                                   #+ccl-5.0 (ccl::theme-background-p item)
                                   #-ccl-5.0 (view-get (view-window item) 'ccl::theme-background))
                        (get-back-color (view-window item))))))
    (rlet ((fore-color :RGBColor)
           (back-color :RGBColor)
           (style-rec 
            :ControlFontStyleRec
            :flags     (+ (if (and ff-mask (zerop (logand ff-mask ccl::+font-only-ff-mask+)))
                            0
                            #$kControlUseFontMask)
                          (if (and ff-mask (zerop (logand ff-mask ccl::+face-only-ff-mask+)))
                            0
                            #$kControlUseFaceMask)
                          (if (and ff-mask (zerop (logand ff-mask ccl::+color-only-ff-mask+)))
                            0
                            #$kControlUseForeColorMask)
                          (if (and ms-mask (zerop (logand ms-mask ccl::+mode-only-ms-mask+)))
                            0
                            #$kControlUseModeMask)
                          (if (and ms-mask (zerop (logand ms-mask ccl::+size-only-ms-mask+)))
                            0
                            #$kControlUseSizeMask)
                          (if bgcolor #$kControlUseBackColorMask 0)
                          #$kControlUseJustMask)
            :font       (ccl::font-codes-font-number ff ms)
            :size       (ccl::font-codes-size ff ms)
            :style      (ccl::font-codes-style-number ff ms)
            :mode       (ccl::font-codes-mode ff ms)
            :just       (ccl::alignment-arg (slot-value item 'text-justification))
            :foreColor  (ccl::color-to-rgb (ccl::font-codes-color ff ms) fore-color)
            :backColor  (ccl::color-to-rgb (or bgcolor *red-color*) back-color)))
      (#_SetControlFontStyle (dialog-item-handle item) style-rec))))
  (call-next-method))

#| Without the back-color method above, the following window ends up with a blue background instead of a proper theme background:
(make-instance 'window
    :view-size #@(500 300)
    :theme-background T
    :view-subviews
    (list
     (make-instance 'databrowser::databrowser
       :back-color *blue-color* ; if removing this, the window get a white background even if it is a theme background!
       :view-position #@(10 10)
       :view-size #@(300 100))))
|#

(defmethod install-view-in-window :around ((item databrowser) dialog)
  (declare (ignore dialog))
  (call-next-method)
  (when (appearance-available-p)
    (let ((handle (dialog-item-handle item))
          (topLeft (abs (view-origin item)))
          #+ignore
          (size (view-size item)))
      (#_MoveControl handle (point-h topLeft) (point-v topLeft))
      #+ignore
      (#_SizeControl handle (point-h size) (point-v size)))))

#| Without the install-view-in-window, the databrowser fails to draw in the correct position when within another subview. 
Evaluate this to see how the databrowser is misplaced:

(make-instance 'window
  :view-size #@(500 300)
  :theme-background T
  :view-subviews
  (list 
   (make-instance 'view
     :view-position #@(100 100)
     :view-size #@(400 200)
     :view-subviews
     (list
      (make-instance 'databrowser
        :back-color *blue-color*
        :view-position #@(10 10)
        :view-size #@(300 100))))))
|#

#+ignore
(defmethod ccl::auto-resize-view ((view databrowser) (container simple-view))
  (when (slot-exists-p view 'ccl::previous-container-size)
    (let ((delta (subtract-points (view-size container) (funcall 'ccl::previous-container-size view))))
      (set-view-size view (add-points (view-size view) delta)))))

(defmethod view-key-event-handler ((browser databrowser) char &aux part)
  (when (ccl::installed-item-p browser)
    (with-focused-dialog-item (browser)
      (let ((handle (dialog-item-handle browser))
            (modifiers (ccl::get-modifiers)))
        (declare (dynamic-extent handle)
                 (type macptr handle))
        (when handle
          (setq part (#_HandleControlKey handle (char-code char) (char-code char) modifiers))) ; let the databrowser handle the key
        ))))

;--- BROWSER SCROLL BAR FUNCTIONS

(defmethod databrowser-hscrollp ((browser databrowser))
  (rlet ((h :boolean)
         (v :boolean))
    (#_GetDataBrowserHasScrollBars (dialog-item-handle browser) h v)
    (pref h :boolean)))

(defmethod databrowser-vscrollp ((browser databrowser))
  (rlet ((h :boolean)
         (v :boolean))
    (#_GetDataBrowserHasScrollBars (dialog-item-handle browser) h v)
    (pref v :boolean)))

(defmethod (setf databrowser-hscrollp) (value (browser databrowser))
"Give this a value indicating whether to enable horizontal scroll bars on this browser.
   This is dynamic so you can change it on the fly on an extant databrowser.
   This function WILL affect future calls to #'databrowser-hscrollp."
  (rlet ((h :boolean)
         (v :boolean))
    (#_GetDataBrowserHasScrollBars (dialog-item-handle browser) h v)
    (#_SetDataBrowserHasScrollBars (dialog-item-handle browser) value (pref v :boolean))))

(defmethod (setf databrowser-vscrollp) (value (browser databrowser))
  "Give this a value indicating whether to enable vertical scroll bars on this browser.
   This is dynamic so you can change it on the fly on an extant databrowser.
   This function WILL affect future calls to #'databrowser-vscrollp."
  (rlet ((h :boolean)
         (v :boolean))
    (#_GetDataBrowserHasScrollBars (dialog-item-handle browser) h v)
    (#_SetDataBrowserHasScrollBars (dialog-item-handle browser) (pref h :boolean) value)))

(defmethod auto-size-columns ((browser databrowser))
  "Resize all columns to fill available horizontal space. Only works
   if horizontal scroll bar is disabled."
  (when (not (databrowser-hscrollp browser))
    (#_AutoSizeDataBrowserListViewColumns (dialog-item-handle browser))))

(defmethod scroll-bars-active-p ((browser databrowser))
  "Here's how you can tell whether there's a scroll bar that's both enabled AND has a visible thumb.
   For each scroll bar, returns either NIL (meaning no active scroll bar) or an integer representing
     the maximum setting of that scroll bar."
  (let ((h-enabled (databrowser-hscrollp browser))
        (v-enabled (databrowser-vscrollp browser)))
    (multiple-value-bind (v-max h-max) (get-scroll-max browser)
      ; These will be zero if scroll bar is enabled but has an invisible thumb
      (values (and v-enabled (not (zerop v-max)) v-max)
              (and h-enabled (not (zerop h-max)) h-max)))))
      
(defmethod view-scroll-position ((browser databrowser)) ; originally get-scroll-position 
  "Returns current vertical and horizontal scrolling positions of the browser as a big point."
  (rlet ((top :unsigned-long)
         (left :unsigned-long))
    (#_GetDataBrowserScrollPosition (dialog-item-handle browser) top left)
    (values (ccl::make-big-point (pref left :unsigned-long) (pref top :unsigned-long))
            (pref left :unsigned-long)
            (pref top :unsigned-long))))
 
#+ignore
(defmethod set-scroll-position ((browser databrowser) top left)
    (#_SetDataBrowserScrollPosition (dialog-item-handle browser) top left))

(defmethod set-view-scroll-position ((browser databrowser) h &optional v (scroll-visibly t))
  (ccl::normalize-h&v h v) 
  (#_SetDataBrowserScrollPosition (dialog-item-handle browser) v h)
  (when scroll-visibly
    (let ((henabled (databrowser-hscrollp browser))
          (venabled (databrowser-vscrollp browser)))
      ; This sucks. Why does Apple make this necessary after setting scroll position?
      ; PANTHER FIXED THIS. But leave the workaround here for Jaguar users.
      (when (or henabled venabled)
        (#_SetDataBrowserHasScrollBars (dialog-item-handle browser) nil nil)
        (#_SetDataBrowserHasScrollBars (dialog-item-handle browser) henabled venabled)
        ;(databrowser-update browser t) ; this doesn't do the trick
        ))))

(defmethod get-scroll-max ((browser databrowser))
  "Returns current vertical and horizontal scrolling maxima of the browser.
   (0 is always the minimum, so we don't provide a function called get-scroll-min.)
   Note that this may return a nonzero value even if scroll bar is not enabled, so you
   also have to check whether it's enabled to determine if this value is meaningful.

   Astonishingly, the databrowser API provides no mechanism for getting this, which
   means it's very difficult to support wheel mice.
   (If you don't pay attention to these limits, you can easily scroll the browser
   such that its content is about a mile above your screen. No error is given.)
   This is borne out by the
   fact that most of Apple's databrowser demo code doesn't support wheel mice. But
   of course the Finder supports wheel mice in its use of the databrowser, so there
   had to be a way. There is. This is it. Scalpel!"
  (let ((browser-handle (dialog-item-handle browser))
        (swap nil)
        (hmax 0)
        (vmax 0))
    (rlet ((SubControl :pointer))
      (flet ((getit (index)
               (rlet ((bounds :rect))
                 (#_GetIndexedSubControl browser-handle index SubControl)
                 (if (handlep (%get-ptr SubControl))
                   (prog1
                     (logand (#_GetControl32BitMaximum (%get-ptr SubControl))
                             #x7FFFFFFF) ; bit 31 is set. Damnifiknow why. It ain't negative.
                     (#_GetControlBounds (%get-ptr SubControl) bounds)
                     ;(format t "Index ~D: top=~D, left=~D, bottom=~D, right=~D~%"
                     ;        index 
                     ;        (pref bounds :rect.top)
                     ;        (pref bounds :rect.left)
                     ;        (pref bounds :rect.bottom)
                     ;        (pref bounds :rect.right))
                     
                     ; DAMN this is a silly, stupid, error-prone PITA! How come there's no
                     ;   easy way to figure out which scroll bar is the freakin' VERTICAL one?!?
                     (case index
                       (2 (when (> (- (pref bounds :rect.bottom) (pref bounds :rect.top))
                                   (- (pref bounds :rect.right)  (pref bounds :rect.left)))
                            (setf swap t)))
                       (1 (when (> (- (pref bounds :rect.right)  (pref bounds :rect.left))
                                   (- (pref bounds :rect.bottom) (pref bounds :rect.top)))
                            (setf swap t))))
                     )
                   (progn
                     ; following does happen, for unknown reasons, with the search-files-browser
                     ; Stops when you click on a column to re-sort.
                     ; And no, programmatically setting the sort column or sort order doesn't fix it.
                     ; Eventually this code will go away when we figure out how to pass the scroll event
                     ; directly to the databrowser. Until then, ignore it.
                     ;(format t "~%Databrowser: Index ~D is bad" index)
                     0)) ; return 0 in pathological case. I've never seen this happen.
                 ; even if scrollbar thumbs are not there, system returns 0 anyway.
                 )))

        ; This makes little difference. There's often two valid control handles even
        ;   if one of the scrollbars is disabled.
     ;   (let ((h-enabled (databrowser-hscrollp browser))
     ;         (v-enabled (databrowser-vscrollp browser)))

        (setf vmax (getit 1)) ; assume 1 is vertical until proven otherwise
        (setf hmax (getit 2))
        (if swap (rotatef vmax hmax))
        (values vmax hmax)))))

;;; Provide scroll wheel behavior for the databrowser.
;;; It's not as smooth as scrolling in Fred windows but that's probably because the databrowser
;;;   takes longer to refresh.

;;; There may be a way to just bypass all this and send the event directly to the databrowser,
;;;   where the event might be handled automatically, but I haven't found it yet.
;;;   And since most of Apple's own sample code for the databrowser doesn't support mouse wheel
;;;   scrolling, it seems a pretty good bet we'll have to do it manually.

(defmethod ccl::scroll-wheel-handler ((browser databrowser) delta direction wherep)
  (declare (ignore wherep))
  (if (> 10 (abs delta) 1) (setf delta (round delta 2))) ; heuristic to slow the wheel down a little
#|  (let ((henabled (databrowser-hscrollp browser))
        (venabled (databrowser-vscrollp browser)))
    (flet ((update-thumb ()
             ; This sucks. Why does Apple make this necessary after setting scroll position?
             ; PANTHER FIXED THIS. But leave the workaround here for Jaguar users.
             (when (or henabled venabled)
               (#_SetDataBrowserHasScrollBars (dialog-item-handle browser) nil nil)
               (#_SetDataBrowserHasScrollBars (dialog-item-handle browser) henabled venabled)
               ;(databrowser-update browser t) ; this doesn't do the trick
               ))) |#
      (when t ;(or venabled henabled) ; Hey! It seems pretty useful to be able to use the wheel
        ;  even when scrollbars are disabled! Let's leave it like this.
        (multiple-value-bind (vmax hmax) (get-scroll-max browser)
          (if (eq direction :vertical)
            (when (and ;venabled
                   (not (zerop vmax))) ; zero if enabled but thumb invisible
              (rlet ((rowheightptr :unsigned-word))
                (#_GetDataBrowserTableViewRowHeight (dialog-item-handle browser) rowheightptr)
                (let ((rowheight (pref rowheightptr :unsigned-word))
                      (pos (view-scroll-position browser)))
                    (set-view-scroll-position browser (point-h pos) (min vmax (max 0 (- (point-v pos) (* rowheight delta))))))
                  #+ignore
                  (update-thumb)))
            ; direction is :horizontal (user used shift key with scroll wheel)
            (when (and ;henabled
                   (not (zerop hmax))) ; zero if enabled but thumb invisible
              (let ((pos (view-scroll-position browser)))
                (set-view-scroll-position browser 
                                          (min hmax (max 0 (- (point-h pos)
                                                              (* (ccl::adjust-horizontal-wheel-speed browser delta)))))
                                          (point-v pos)))
              #+ignore
              (update-thumb)))))
  #$noerr)

;--- BROWSER ROW AND COLUMN UTILITY FUNCTIONS

(defmethod get-column-count ((browser databrowser))
  "Returns the total number of columns in given browser."
  (rlet ((countptr :unsigned-long))
    (#_GetDataBrowserTableViewColumnCount (dialog-item-handle browser) countptr)
    (pref countptr :unsigned-long)))

; This doesn't seem to work right. I can't get it to tell me the actual number of displayed
;   rows, regardless of whether some of the rows are contained within others (twist-downs) or not. Seems flaky.
(defmethod get-row-count ((browser databrowser))
  "Returns the current total number of rows in given browser."
  (rlet ((countptr :unsigned-long))
    (#_GetDataBrowserItemCount (dialog-item-handle browser) #$kDataBrowserNoItem t 0 countptr)
    (pref countptr :unsigned-long)))

(defmethod get-column-ID ((browser databrowser) column-index)
  "Given a column index, where 0 is the current leftmost column, return the columnID for that column.
   Returns $kDataBrowserItemNoProperty if given index is out of range."
  (rlet ((columnIDptr :unsigned-long))
    (#_GetDataBrowserTableViewColumnProperty (dialog-item-handle browser) column-index columnIDptr)
    (pref columnIDptr :unsigned-long)))

(defmethod get-column-index ((browser databrowser) columnID)
  "Given a columnID return the column-index for that column. 0 is the column-index of the current leftmost column."
  (rlet ((indexptr :unsigned-long))
    (#_GetDataBrowserTableViewColumnPosition (dialog-item-handle browser) columnID indexptr)
    (pref indexptr :unsigned-long)))

(defmethod get-row-ID ((browser databrowser) row-index)
  "Given a row index, where 0 is the current topmost row, return the rowID for that row.
   Given that get-row-count is flaky w.r.t. twist-downs, this may be too."
  (rlet ((rowIDptr :unsigned-long))
    (#_GetDataBrowserTableViewItemID (dialog-item-handle browser) row-index rowIDptr)
    (pref rowIDptr :unsigned-long)))

(defmethod get-row-index ((browser databrowser) rowID)
  "Given a rowID return the row-index for that row. 0 is the row-index of the current topmost row.
   Given that get-row-count is flaky w.r.t. twist-downs, this may be too."
  (rlet ((indexptr :unsigned-long))
    (#_GetDataBrowserTableViewItemRow  (dialog-item-handle browser) rowID indexptr)
    (pref indexptr :unsigned-long)))


;--- MAIN LOWLEVEL API

; Specialize only if you invent a new kind of browser
(defmethod (setf lookup-browser-data) (data (browser databrowser) rowID columnID)
  "Specialize this."
  (format t "Setting ~S, ~S to ~S" rowID columnID data)
  data
  )

; Specialize only if you invent a new kind of browser
(defmethod lookup-browser-data ((browser databrowser) rowID columnID &optional (comparing-p nil))
  "Return a Lisp datum that is to be displayed at rowID, columID. Both
   will be 32-bit unsigned integers. Default
   method just returns a string '(rowID,columnID)'. Customize as needed for your application.
   Datum will automatically be converted to a string before display, if in fact
   a string is needed. If a checkbox is to be affected by this datum, the normal
   Lisp true and false values are appropriate, or return the special value :MIXED
   to ensure the checkbox is drawn in mixed style."
  (declare (ignore comparing-p))
  (format nil "(~D,~D)" rowID columnID))

(defmethod stringify-browser-data ((datum t))
  "Final step to ensure that datum is formatted as a string for display in browser, for
   cells that require strings. Customize if needed, but this should suffice for most purposes."
  (handler-case
    (string datum) ; deal with symbols quickly
    (error () (format nil "~A" datum))))

(defmethod stringify-browser-data ((datum string))
  "Deal with strings quickly."
  datum)

(defmethod stringify-browser-data ((datum integer))
  (format nil "~D" datum))

(defmethod %databrowser-item-data ((browser databrowser) rowID (property (eql #$kDataBrowserItemIsEditableProperty)) item-data set?)
  "Called by the databrowser to determine if the given rowID is editable. Behavior here works pretty well for text
   cells, but not for checkboxes."
  (declare (ignore rowID set?))
  (#_SetDataBrowserItemDataBooleanValue item-Data (databrowser-allow-edits browser))
  ; assume for now that any element that has the #$kDataBrowserPropertyIsEditable property
  ;  is in fact editable. (Any element that does not have this property will never invoke this method.)
  ;  Setting true here just gives you an outline around the thing you want to edit. If you do
  ;  (#_SetDataBrowserItemDataBooleanValue item-Data nil) instead, you won't even get the outline.
  ; The databrowser-allow-edits check above doesn't really need to be here with collection-databrowsers, because
  ;   the :after method on (setf databrowser-allow-edits) prevents this method from ever being called.
  ;   Plus this doesn't prevent edits of checkboxes, at least visually, while the :after method does.
  ;   But of course, the :after method is per-column, while this method is per-row. So there's the tradeoff.
  nil)

; no longer used!
(defmethod lookup-property-type ((browser databrowser) columnID)
  (declare (ignore columnID))
  "Only option for basic databrowser, which should never be instantiated anyway."
  :TEXT)

(defmethod set-sort-column ((browser databrowser) columnID)
  "Programmatically set the sort column for the browser. Most of the time, you should let the user select this
   by clicking on column headers."
  (#_SetDataBrowserSortProperty (dialog-item-handle browser) columnID))

(defmethod set-sort-order ((browser databrowser) order)
  "Order can be :increasing or :decreasing"
  (case order
    (:increasing (#_SetDataBrowserSortOrder (dialog-item-handle browser)
                  #$kDataBrowserOrderIncreasing))
    (:decreasing (#_SetDataBrowserSortOrder (dialog-item-handle browser)
                  #$kDataBrowserOrderDecreasing))))

(defmethod get-sort-column ((browser databrowser))
  "Retrieve the current columnID being sorted for the browser."
  (rlet ((ptr :unsigned-long))
    (#_GetDataBrowserSortProperty (dialog-item-handle browser) ptr)
    (pref ptr :unsigned-long)))

; Specialize only if absolutely necessary.
(defmethod %databrowser-item-data ((browser databrowser) rowID columnID cell-buffer set?)
  "This method is called by the browser and should return a datum to be displayed where
   (columnID,rowID) is an (x,y) location. This function is only called for display, not
   for comparison. The returned datum should be a Lisp datum, but its specific Lisp type
   depends on the browser's property-type for this column."
  
  (when (> columnID 1023) ; because the rest are reserved by Apple
    (if set?
      (update-column-item-value (get-databrowser-column browser columnID) rowID cell-buffer)
      (update-column-row-value (get-databrowser-column browser columnID) rowID cell-buffer))      
    nil
    ;;(#_SetDataBrowserItemDataDrawState item-Data #$kThemeStateActive) ; this doesn't help
    ))

(defmethod databrowser-compare ((browser databrowser) id1 id2 sortProperty)
  "Customize this if needed, but this method will usually suffice."
  (when (> sortProperty 1023) ; because the rest are reserved by Apple
    (let ((item1 (lookup-browser-data browser id1 sortProperty t))
          (item2 (lookup-browser-data browser id2 sortProperty t)))
      (labels ((compareit (item1 item2)
                 (cond ((and (stringp item1)
                             (stringp item2))
                        (string-lessp item1 item2))
                       ((and (numberp item1)
                             (numberp item2))
                        (< item1 item2))
                       ((null item1) t) ; consider nil less than true
                       ((null item2) nil)
                       (t ; as a last resort, compare the stringified versions of the data
                        (let ((sitem1 (stringify-browser-data item1))
                              (sitem2 (stringify-browser-data item2)))
                          (compareit sitem1 sitem2))))))
        (compareit item1 item2)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CALLBACKS

#+ignore
(ccl::add-pascal-upp-alist 'databrowser-item-data-proc  #'(lambda (procptr) (#_NewDataBrowserItemDataUPP procptr)))
#+ignore
(ccl::add-pascal-upp-alist 'databrowser-Item-notification-proc  #'(lambda (procptr) (#_NewDataBrowserItemNotificationUPP procptr)))
#+ignore
(ccl::add-pascal-upp-alist 'databrowser-item-compare-proc    #'(lambda (procptr) (#_NewDataBrowserItemCompareUPP procptr)))
; add more here as needed like the drag handlers, contextual menu, and help callbacks

(defmethod maybe-log-browser-message (format-control-string &rest args)
  "Like format except conditional and specialized for browser use."
  (when *browser-log-stream*
    (apply 'format *browser-log-stream* format-control-string args)))

(defmethod log-browser-error (browser routine-name error &rest parms)
  "Deal with Lisp errors that occur during browser callbacks. Specialize if needed."
  (when *browser-log-stream*
    (progn (format *browser-log-stream* "Error in browser ~S, call = (~S~{ ~S~}).~%"
                   browser routine-name parms)
           (ccl::report-condition error *browser-log-stream*)
           nil)))

(defun maybe-log-browser-ref-error (browser-ref routine-name error &rest parms)
  "Low-level recorder for browser errors that occur during browser callbacks. Shouldn't need specialization."
     (when *log-browser-errors*
       (let ((browser (ignore-errors (handle.databrowser browser-ref))))
          (apply #'log-browser-error browser routine-name error parms))))

(defpascal databrowser-item-data-proc (:upp-creator #_NewDataBrowserItemDataUPP
                                                    :controlref browser 
                                                    :DataBrowserItemID item ; row
                                                    :DataBrowserPropertyID property ; column
                                                    :DataBrowserItemDataRef item-data
                                                    :boolean set-value
                                                    ;:without-interrupts nil ; this doesn't seem to do anything, t or nil
                                                    :osstatus) 
  (or (handler-case
        (%databrowser-item-data (handle.databrowser browser) item property item-data set-value)
        (error (c) (maybe-log-browser-ref-error browser '%databrowser-item-data c item property item-data set-value)))
      #$noErr))

(defpascal databrowser-Item-notification-proc (:upp-creator #_NewDataBrowserItemNotificationUPP
                                                            :controlref browser
                                                            :DataBrowserItemID item
                                                            :DataBrowserItemNotification message
                                                            :void)
  (let ((bb (handle.databrowser browser))
        (fn nil))
    (setf fn 
          (case message
            (#.#$kDataBrowserItemAdded ;1          ;   The specified item has been added to the browser
             'databrowser-item-added)
            (#.#$kDataBrowserItemRemoved ;2          ;   The specified item has been removed from the browser
             'databrowser-item-removed)
            (#.#$kDataBrowserEditStarted ;3        ;   Starting an EditText session for specified item
             'databrowser-edit-started)
            (#.#$kDataBrowserEditStopped ;4        ;   Stopping an EditText session for specified item
             'databrowser-edit-stopped)
            (#.#$kDataBrowserItemSelected ;5       ;   Item has just been added to the selection set
             'databrowser-item-selected)
            (#.#$kDataBrowserItemDeselected ;6     ;   Item has just been removed from the selection set
             'databrowser-item-deselected)
            (#.#$kDataBrowserItemDoubleClicked ;7
             'databrowser-item-double-clicked)
            (#.#$kDataBrowserContainerOpened ;8    ;   Container is open  
             'databrowser-container-opened)
            (#.#$kDataBrowserContainerClosing ;9   ;   Container is about to close (and will real soon now, y'all)  
             'databrowser-container-closing)
            (#.#$kDataBrowserContainerClosed ;10   ;   Container is closed (y'all come back now!)  
             'databrowser-container-closed)
            (#.#$kDataBrowserContainerSorting ;11  ;   Container is about to be sorted (lock any volatile properties)  
             'databrowser-container-sorting)
            (#.#$kDataBrowserContainerSorted ;12   ;   Container has been sorted (you may release any property locks)  
             'databrowser-container-sorted)
            (#.#$kDataBrowserTargetChanged ;15     ;   The target has changed to the specified item  
             'databrowser-target-changed)
            (#.#$kDataBrowserUserStateChanged ;13  ;   The user has reformatted the view for the target  
             'databrowser-user-state-changed)
            (#.#$kDataBrowserSelectionSetChanged ;14;   The selection set has been modified (net result may be the same)  
             'databrowser-selection-set-changed)
            (#.#$kDataBrowserUserToggledContainer ; 16 ; _User_ requested container open/close state to be toggled
             'databrowser-user-toggled-container)
            (1001 NIL)
            (T (when *browser-log-stream*
                 (format *browser-log-stream* "~%Unknown message ~S for item ~S" message item))
               nil)))
    (when fn
     (handler-case
       (funcall fn bb item)
      (error (c) (maybe-log-browser-ref-error browser fn c bb item))))))

; This works--TN
(defpascal databrowser-item-compare-proc (:upp-creator #_NewDataBrowserItemCompareUPP
                                                       :controlref browser
                                                       :DataBrowserItemID itemOne
                                                       :DataBrowserItemID itemTwo
                                                       :DataBrowserPropertyID sortProperty
                                                       :long)
  (if
    (handler-case
      (databrowser-compare (handle.databrowser browser) itemOne itemTwo sortProperty)
      (error (c) (maybe-log-browser-ref-error browser 'databrowser-compare c itemOne itemTwo sortProperty)))
    #xFFFFFFF
    0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOTIFICATION CALLBACK METHODS. BROWSER WILL CALL THESE WHEN EVENTS HAPPEN. SPECIALIZE AS NEEDED.

(defmethod databrowser-item-added            ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-item-removed          ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-edit-started          ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-edit-stopped          ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-item-selected         ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-item-deselected       ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-item-double-clicked   ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-container-opened      ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-container-closing     ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-container-closed      ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-container-sorting     ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-container-sorted      ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-target-changed        ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-user-state-changed    ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-selection-set-changed ((browser databrowser) rowID)
  (declare (ignore rowID)))
(defmethod databrowser-user-toggled-container ((browser databrowser) rowID)
  (declare (ignore rowID)))

(defmethod databrowser-state ((browser databrowser) rowID)
  "Call this to discover the current state of item at rowID."
  (rlet ((state :DataBrowserItemState))
    (#_GetDataBrowserItemState
     (dialog-item-handle browser)
     rowID
     state)
    (let ((result (pref state :DataBrowserItemState)))
      (if (= result #$kDataBrowserItemNoState)
        nil
        (values ; pretty self-explanatory
         (logtest #$kDataBrowserItemIsSelected result)
         (logtest #$kDataBrowserContainerIsOpen result)
         (logtest #$kDataBrowserItemIsDragTarget result))))))

(defmethod databrowser-items ((browser databrowser) state)
  "Returns a list of rowIDs for the rows that match state, followed by a count
   of items found (which should equal the length of the first list). State
   should be one of #$kDataBrowserItemIsSelected,  $kDataBrowserContainerIsOpen,
   or $kDataBrowserItemIsDragTarget.
   Note that if you frequently need just the count of items that match state, there's
   a faster way to do it (#_GetDataBrowserItemCount) that I haven't bothered to write an API for
   (at least, not a comprehensive one)."
  (let ((%discovered-items (#_NewHandle 0))
        (discovered-items nil)
        (discovered-count nil))
    (#_GetDataBrowserItems (dialog-item-handle browser)
     #$kDataBrowserNoItem
     t
     state
     %discovered-items)
    (setf discovered-count (truncate (#_GetHandleSize %discovered-items) #.(record-length :DataBrowserItemID)))
    (ccl::with-dereferenced-handle (ptr %discovered-items)
      (setf discovered-items (loop for i from 0 below discovered-count
                                 collect (%get-unsigned-long ; Inelegant, because this assumes
                                          ; #.(record-length :DataBrowserItemID)
                                          ; is 4. But that's probably a safe assumption.
                                          ptr (* i #.(record-length :DataBrowserItemID))))))
    (#_DisposeHandle %discovered-items)
    (values discovered-items discovered-count)))

(defmethod databrowser-selected-rows ((browser databrowser))
  "Returns a list of rowIDs of the rows that are selected. Any rows that are owned
    by turned down containers are returned in the flattened list as well. Order of 
    returned rowIDs is sort of random. It's not necessarily top-to-bottom or bottom-
    to-top in the browser. The presence of selected items in turned-down containers
    seems to mess up the ordering."
  (multiple-value-bind (items count) (databrowser-items browser #$kDataBrowserItemIsSelected)
    (values (nreverse items) count)))

(defmethod (setf databrowser-selected-rows) (rowids (browser databrowser))
  "Sets selected rows to be those in the rowids list or array. Any others
   currently selected will be deselected."
  (let ((offset 0)
        (len (length rowids)))
    (unless (zerop len)
      (%stack-block ((ids (* 4 len) :clear t))
        (map nil #'(lambda (rowid) (%put-long ids rowid offset) (incf offset 4)) rowids)
        (ccl::errchk
         (#_SetDataBrowserSelectedItems (dialog-item-handle browser) len ids #$kDataBrowserItemsAssign))))))

(defmethod first-selected-row ((browser databrowser))
  "Emulate behavior from table-dialog-items. Except this returns
   row IDs rather than points representing cells."
  (first (databrowser-selected-rows browser)))

(defmethod window-can-do-operation ((browser databrowser) op &optional item)
  (declare (ignore op item))
  nil)

(defmethod databrowser-update ((browser databrowser) rowID)
  "Redraw given row. Pass t for rowID to redraw all rows."
  (if (eq rowID t)
    (setf rowID nil))
  (rlet ((items :DataBrowserItemID (or rowID #$kDataBrowserNoItem)))
    (#_UpdateDataBrowserItems 
     (dialog-item-handle browser)
     #$kDataBrowserNoItem ; container ?? Do I really have to care about this?? Seems like not.
     1 ; just deal with one item (or all of them) at a time for now
     items
     #$kDataBrowserItemNoProperty ; wimp out on the pre-sort. Make the browser do the work.
     #$kDataBrowserNoItem ; all properties. (Could do just one, but we didn't make an API for that).
     )))

(defmethod ccl::control-dialog-item-procid ((item databrowser))
  "Dummy for databrowser, but it has to be something. Nil won't work."
  8)

(defmethod install-view-in-window :after ((browser databrowser) dialog)
  ; I don't like the fact that the browser's columns are made draggable by setting a property
  ;   of the window the browser is in, but whaddya gonna do?
  (#_SetAutomaticControlDragTrackingEnabledForWindow (wptr dialog) (draggable-columns browser))
  #+ignore
  (unless (osx-p) ; not necessary in OSX, but necessary in OS9 and classic (thanks Terje!)
    (with-rgb (forecolor *black-color*)
      (with-rgb (backcolor *white-color*)
        (rlet ((desc :ControlFontStyleRec
                     :font #$kControlFontViewSystemFont
                     :flags (logior #$kControlUseFontMask ;#$kControlUseModeMask #$kControlUseAllMask #$kControlAddToMetaFontMask
                                    #$kControlUseFaceMask #$kControlUseJustMask)
                     ;(logior #$kControlAddToMetaFontMask ; without this, you can't apply italics or boldface to #$kControlFontViewSystemFont
                     ;        #$kControlUseAllMask 
                     ;        )
                     :just #$teCenter
                     :style 0
                     :ForeColor forecolor
                     :BackColor backcolor))
          (#_SetControlFontStyle (dialog-item-handle browser) desc)))))
  ; (add-key-handler browser dialog) ; needed if databrowser does not inherit from key-handler-mixin
  (finish-initializing browser) ; can't be done until browser is in a window
  )

#| Methods needed if databrowser does not inherit from key-handler-mixin
(defmethod key-handler-p ((item databrowser))
  t)

(defmethod set-selection-range ((item databrowser) &optional pos curpos)
  (declare (ignore pos curpos))
  0)

(defmethod enter-key-handler ((item databrowser) last-key-handler)
  (declare (ignore last-key-handler))
  nil)

(defmethod exit-key-handler ((item databrowser) next-key-handler)
  (declare (ignore next-key-handler))
  t)
|#

(defmethod allow-returns-p ((item databrowser))
  "This must be true to allow editing items in the browser after hitting <return>."
  t)

(defmethod allow-tabs-p ((item databrowser))
  nil)

(defmethod ccl::make-control-handle ((control databrowser) wptr)
  (ccl::with-item-rect (rect control)
    (rlet ((hhandle (:pointer (:handle :controlrecord)))
           (callbacks :DataBrowserCallbacks))
      (ccl::errchk (#_CreateDataBrowserControl ;; ## remember to dispose of this after use!
                    wptr
                    rect 
                    #$kDataBrowserListView
                    hhandle))
      (let ((handle (%get-ptr hhandle)))
        (setf (rref callbacks :DataBrowserCallbacks.version) #$kDataBrowserLatestCallbacks)
        (ccl::errchk (#_InitDataBrowserCallbacks callbacks))
        (setf (rref callbacks :DataBrowserCallbacks.itemDataCallback) ; this should be the correct syntax for the variant in Lisp
              databrowser-item-data-proc)
        ; (#_NewDataBrowserItemDataUPP MyGetSetItemData))
        (setf (rref callbacks :DataBrowserCallbacks.itemNotificationCallback)
              databrowser-Item-notification-proc)
        
        (setf (rref callbacks :DataBrowserCallbacks.itemCompareCallback)
              databrowser-item-compare-proc)
        
        (ccl::errchk (#_SetDataBrowserCallbacks handle callbacks))
        (setf (handle.databrowser handle)
              control)
        (setf (dialog-item-handle control)
              handle)
        ;(ccl::errchk (#_SetDataBrowserTarget handle 502)) ; this doesn't do anything, but they do it in the C version
        (ccl::errchk (#_SetDataBrowserActiveItems handle t)) ; doesn't seem to be necessary
        
        (rlet ((ptr :boolean (focus-ring control)))
          (ccl::errchk (#_SetControlData handle #$kControlNoPart #$kControlDataBrowserIncludesFrameAndFocusTag 1 ptr))
          ;                                                                 1! Whoda thunk it?          -------^
          )
                 
        (#_SetDataBrowserTableViewHiliteStyle handle
         #$kDataBrowserTableViewFillHilite
         ;#$kDataBrowserTableViewMinimalHilite  ; just highlights individual cells, not whole rows
         )
        ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MAP BETWEEN DATABROWSER HANDLE AND OBJECT

(defvar *databrowsers* (make-hash-table :test 'eql :weak :value))

(defun (setf handle.databrowser) (databrowser handle)
;  (ccl::errchk (#_SetControlProperty handle 1 1 4 databrowser))
  (setf (gethash handle *databrowsers*) databrowser))

(defun handle.databrowser (handle)
  (gethash handle *databrowsers*))

;; COLUMNS

(defvar %last-property-id% 1025)

(defun get-unused-property-id ()
  ;; ## need to be improved to safeguard against too large ids!
  (incf %last-property-id%))

; Note: #_GetDataBrowserItemDataProperty seems to return property flags if you need them later.

; make this pay attention to a full font-spec eventually
(defmethod databrowser-add-listview-column ((browser databrowser) &key property-id
                                                  (property-type :TEXT)
                                                  (fontstyle :normal)
                                                  (fontsize 12)
                                                  (minwidth 10) ; make minwidth and maxwidth different if you want columns resizable
                                                  (maxwidth 200)
                                                  (title "Untitled")
                                                  (with-seconds nil) ; true if you want :TIME property-type to display seconds
                                                  (justification :center)
                                                  (order :increasing)
                                                  (editable nil) ; true if items in this column can be edited
                                                  (position #$kDataBrowserListViewAppendColumn))
  (setf property-id (or property-id (get-unused-property-id)))
  (let ((flags ;;#$kDataBrowserDefaultPropertyFlags)) ; don't use this one. Doesn't work.
         (logior #$kDataBrowserListViewDefaultColumnFlags #$kDataBrowserListViewSelectionColumn))
        (handle (dialog-item-handle browser)))
    (ccl::with-cfstrs ((titlestring title))
      (with-rgb (forecolor *red-color*) ; do-nothing. It's always black regardless of what you put here.
        (with-rgb (backcolor *white-color*)
          (rlet ((desc :DataBrowserListViewColumnDesc
                       :propertydesc.propertyId property-id
                       :propertydesc.propertyType
                       (etypecase property-type
                         (number property-type)
                         ((eql :TEXT) #$kDataBrowserTextType)
                         ((eql :CHECKBOX) #$kDataBrowserCheckboxType)
                         ((eql :TIME) #$kDataBrowserDateTimeType) ; we'll leave the flags alone, no provision for relative date/time herein
                         ; rest of these aren't really supported by this code yet
                         ((eql :ICON) #$kDataBrowserIconType)
                         ((eql :PROGRESS-BAR) #$kDataBrowserProgressBarType)
                         ((eql :RELEVANCE) #$kDataBrowserRelevanceRankType)
                         ; (:SLIDER #$kDataBrowserSliderType) ; I think the documentation's wrong on this one. Seems to not be in Carbon.
                         ((eql :POPUP) #$kDataBrowserpopupMenuType)
                         ((eql :ICONANDTEXT) #$kDataBrowserIconAndTextType)
                         )
                       :propertydesc.propertyFlags (logior flags
                                                           (if editable #$kDataBrowserPropertyIsEditable 0)
                                                           (if (and (eq property-type :TIME)
                                                                    with-seconds) #$kDataBrowserDateTimeSecondsToo 0))
                       :headerbtndesc.version #$kDataBrowserListViewLatestHeaderDesc 
                       :headerbtndesc.initialorder (ecase order
                                                     ;((NIL) #$kDataBrowserOrderUndefined) ; Not supported. Assume Increasing.
                                                     (:increasing #$kDataBrowserOrderIncreasing)
                                                     (:decreasing #$kDataBrowserOrderDecreasing))
                       :headerbtndesc.minimumWidth (or minwidth maxwidth 100)
                       :headerbtndesc.maximumWidth (or maxwidth minwidth 100)
                       :headerbtndesc.btnContentInfo.contentType #$kControlContentTextOnly ; for now, no icons in headers
                       :headerbtndesc.btnFontStyle.font #$kControlFontViewSystemFont
                       :headerBtnDesc.btnFontStyle.flags (logior #$kControlAddToMetaFontMask ; without this, you can't apply italics or boldface to #$kControlFontViewSystemFont
                                                                 ; #$kControlAddFontSizeMask
                                                                 ; #$kControlUseAllMask ; TN says this is bad in OS9
                                                                 (logior #$kControlUseFontMask #$kControlUseJustMask #$kControlUseFaceMask)
                                                                 )
                       :headerBtnDesc.btnFontStyle.just (case justification
                                                          (:center #$teCenter)
                                                          (:left #$teFlushLeft)
                                                          (:right #$teFlushRight))
                       :headerbtndesc.btnFontStyle.style
                       (ecase fontstyle
                         (:normal 0)
                         (:bold 1)
                         (:italic 2)
                         (:bold-italic 3))
                       
                       :headerbtndesc.btnFontStyle.size fontsize
                       :headerbtndesc.btnFontStyle.mode #$srcOr
                       
                       :headerbtndesc.btnFontStyle.forecolor forecolor
                       
                       :headerbtndesc.btnFontStyle.backColor backcolor
                       
                       :headerbtndesc.titleOffset 0
                       :headerBtnDesc.titleString titlestring
                       ))
            (ccl::errchk (#_AddDataBrowserListViewColumn handle desc position))
            ))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defgeneric databrowser-add-items (databrowser items &optional parent sortproperty)
  (:documentation "Pass a sequence of items in items parameter. If parent is given, it must
   be the dataID of an item of the same type as items, and which will be the parent of the list of items.
   That is, parent should be an item that has a twist-down triangle next to it and this routine
   would be called as a result of the user twisting it down. Normally, the programmer will never call this
   directly with parentID non-nil; that call typically only happens automatically when the user
   twists down a triangle."))

(defmethod databrowser-add-items ((browser databrowser) items &optional parent sortproperty)
  "A silly do-nothing method since databrowser is not really designed for direct instantiation."
  (declare (ignore parent sortproperty))
  (ccl::errchk (#_AddDataBrowserItems
           (dialog-item-handle browser)
           #$kDataBrowserNoItem ; no container (twist-down) in this demo
           (length items)
           (%null-ptr) ; let it generate its own DataIDs
           #$kDataBrowserItemNoProperty)))

(defgeneric databrowser-remove-all (databrowser &optional propertyID sortorder)
  (:documentation "Removes all rows from the databrowser. Call this if you need to completely change the list
   of items displayed. You can also pass propertyID and sortorder to pre-set the browser
   if you're about to add a list of pre-sorted items."))

(defmethod databrowser-remove-all ((browser databrowser) &optional propertyID sortorder)
  (#_RemoveDataBrowserItems (dialog-item-handle browser) #$kDataBrowserNoItem 0 (%null-ptr) #$kDataBrowserItemNoProperty)
  (when (and propertyID sortorder) ; let caller pre-set column to be sorted when items are added again
    (#_SetDataBrowserSortProperty (dialog-item-handle browser) propertyID)
    (#_SetDataBrowserSortOrder (dialog-item-handle browser)
     (case sortorder
       (:increasing #$kDataBrowserOrderIncreasing)
       (t #$kDataBrowserOrderDecreasing)))))

(defmethod databrowser-reveal-data ((browser databrowser) rowID columnID &optional (also-select? t))
  "Reveal the given rowID, columnID in the browser. By default, also selects it."
  (#_RevealDataBrowserItem (dialog-item-handle browser) rowID columnID
   (if also-select? #$kDataBrowserRevealAndCenterInView #$kDataBrowserRevealWithoutSelecting))
    ;#$kDataBrowserRevealOnly is available too, but doesn't seem too useful
  )

(defmethod databrowser-reveal-row ((browser databrowser) rowID &optional (also-select? t))
  "Reveal the given rowID in the browser. By default, also selects it."
  (when rowID
    (databrowser-reveal-data browser rowID #$kDataBrowserItemNoProperty also-select?)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COLUMN


(defclass column ()
  ((browser
    :reader column-browser
    :initform NIL
    :documentation "The databrowser that contains the column, if any")
   (function 
    :accessor column-function
    :initarg :function
    :initarg :reader
    :initform nil 
    :documentation "Function (lambda) or symbolic name of a function to run against
             the row object to return value for this column.
             This should [usually] be a function of one parameter:
             the item in that row. Unless more-function-parameters is true, in which
             case 3 additional parameters are passed for a total of 4.")
   (setter 
    :accessor column-setter
    :initarg :setter 
    :initarg :writer
    :initform nil 
    :Documentation "Function used to set a value after value was edited in an editable databrowser cell.
           [setter is ignored for non-editable columns because it isn't needed].
           Called with 2 args: (newvalue item). If setter is non-nil, and this column is editable, and
           the user edits a value, then when the user is done editing the value the setter will be called.
           It will be given newvalue which is the value the user entered. If setter is not provided in
           the descriptor-specification, we'll try to find a function named (setf column-function) and use that
           for the setter, where column-function is of course the slot immediately preceding this one.")
   (editable 
    :accessor column-editable
    :initarg :editable 
    :initform nil 
    :documentation "True if this column is editable. This attribute is overridable globally by
             the allow-edits slot of the databrowser.")
   (more-function-parameters 
    :accessor more-function-parameters
    :initarg :more-function-parameters 
    :initform nil 
    :documentation "True if the given function (the function slot) is a function of 4 parameters,
                   (item comparing-p browser rowID), rather than just the usual one.
                   First is just as described in the documentation for the function slot.
                   comparing-p will be true if the function is being called for comparison purposes;
                      false if it's just being called for display purposes. Thus this gives you a way
                      to return a different value depending on what the value will be used for.
                   browser is the current browser
                   rowID is the current rowID. 

                   The last two parameters give you the ability to make the appearance of the 
                   item dependent on the browser's visual state. Sometimes you care whether the
                   element is currently selected or whether it's a container that's opened, for
                   example.")
   (title 
    :accessor column-title
    :initarg :title 
    :initform nil)
   (property-id 
    :accessor property-id
    :initarg :property-id 
    :initform nil 
    :documentation "Used internally by the databrowser")
   (property-type 
    :accessor column-property-type
    :initarg :property-type 
    :initform :TEXT
    :type (or keyword number)
    :documentation "The code for the property type, or a keyword for one of the common types")
   (fontstyle 
    :reader column-fontstyle
    :initarg :fontstyle
    :initform :normal)
   (fontsize
    :reader column-fontsize
    :initarg :fontsize
    :initform 12)
   (justification
    :reader column-justification
    :initarg :justification
    :initform :center)
   (order
    :reader column-order
    :initarg :order
    :initform :increasing)
   (minwidth
    :reader column-minwidth
    :initarg :minwidth
    :initform 10)
   (maxwidth
    :reader column-maxwidth
    :initarg :maxwidth
    :initform 200)))

(defmethod shared-initialize :after ((column column) slot-names &rest initargs)
  (declare (ignore slot-names initargs))
  (let ((fname nil))
    (when (column-editable column)
      (when (and (not (column-setter column))
                 (setf fname (function-name (column-function column))))
        (when (ignore-errors (fdefinition (list 'setf fname)))
          (setf (column-setter column) (list 'setf fname)))))))

(defmethod column-other-attributes (column)
  (declare (ignore column))
  NIL)

(defmethod column-other-attributes ((column column))
  (list* :fontstyle (column-fontstyle column) 
         :fontsize (column-fontsize column) 
         :order (column-order column)
         :justification (column-justification column)
         :minwidth (column-minwidth column)
         :maxwidth (column-maxwidth column)
         (call-next-method)))

(defgeneric update-column-item-value (column rowID cell-buffer)
  (:documentation "Callback to set the value of the item in the row from the value in the cell"))

(defmethod update-column-item-value ((column column) rowID item-data)
  (declare (ignore item-data rowID))
  NIL)

(defmethod column-item-value ((column column) rowID) ;; ## Better if this was called FROM lookup-browser-data...
  (with-slots (browser property-id) column
    (lookup-browser-data browser rowID property-id)))

(defmethod (setf column-item-value) (value (column column) rowID) ;; ## Better if this was called FROM (setf lookup-browser-data)...
  (with-slots (browser property-id) column
    (setf (lookup-browser-data browser rowID property-id) value)))

(defgeneric update-column-row-value (column rowID cell-buffer)
  (:documentation "Callback to set the value displayed in the cell of the column/row from the item of the row"))

(defmethod update-column-row-value ((column column) rowID cell-buffer)
  (declare (ignore cell-buffer rowID))
  NIL)

(defgeneric column-row-value (column item-data)
  (:documentation "Get the value displayed in the cell of the column/row"))

(defmethod (setf column-allow-edits) (value (column column))
  "Allow an editable column to be edited. Can turn off editability of columns defined to be editable,
   but doesn't turn on editability of columns defined not to be."
  (let* ((propertyID (property-ID column))
         (handle (dialog-item-handle (slot-value column 'browser)))
         (oldflags (rlet ((oldflagsptr  :unsigned-long))
                     (#_GetDataBrowserPropertyFlags handle propertyID oldflagsptr)
                     (pref oldflagsptr :unsigned-long))))
    (if value
      (when (column-editable column) ; only turn on columns that were originally defined to be editable
        (#_SetDataBrowserPropertyFlags handle propertyID (logior oldflags #$kDataBrowserPropertyIsEditable)))
      (#_SetDataBrowserPropertyFlags handle propertyID (logand oldflags (lognot #$kDataBrowserPropertyIsEditable))))))

(defmethod redraw-column ((column column))
  "Redraws the column"
  (rlet ((items :unsigned-long #$kDataBrowserNoItem))
    (#_UpdateDataBrowserItems 
     (dialog-item-handle (column-browser column))
     #$kDataBrowserNoItem
     1 ; just deal with one item (or all of them) at a time for now
     items
     #$kDataBrowserItemNoProperty
     (property-id column))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TEXT COLUMN

(defclass text-column (column)
  ()
  (:default-initargs
   :property-type :TEXT))

(defun %set-item-data-text (browser buffer value) ;; ## why not eliminate the browser arg...?
  (let ((string (if value
                  (let ((string (stringify-browser-data value)))
                    (if (zerop (length string))
                      "    " ; 4 spaces (see below)
                      string))
                  (if (display-nil-as-blank browser)
                    "    " ; 4 spaces so we'll have something to edit if editable.
                    ; This is a kludge but it's extremely difficult to select the item
                    ;   for editing if there isn't at least 1 character present
                    (stringify-browser-data value) ; shows "NIL"
                    ))
                )) ; ensure it's a string
    (declare (dynamic-extent string)) ; likely no benefit, but it's the truth!
    (ccl::with-cfstrs ((theData string))
      (#_SetDataBrowserItemDataText buffer theData))))

(defmethod update-column-row-value ((column text-column) rowID cell-buffer)
  "Callback to set the value displayed in the cell of the column/row"
  (with-slots (browser) column
    (let ((text (column-item-value column rowID)))
      (%set-item-data-text browser cell-buffer text))))

(defun %databrowser-item-data-string (cell-buffer)
  "Get the string in the cell"
  (rlet ((theCFptr :pointer))
    (#_GetDataBrowserItemDataText cell-buffer theCFptr)
    (unwind-protect
      #+ccl-5.0
      (ccl::%get-cfstring (%get-ptr theCFptr))
      #-ccl-5.0
      (%stack-block ((sb 512))
        (#_CFStringGetCString (%get-ptr theCFptr) sb 512 #$kCFStringEncodingMacRoman)
        (%get-cstring sb))
      (#_CFRelease (%get-ptr theCFptr)))))

(defmethod update-column-item-value ((column text-column) rowID cell-buffer)
  "Callback to set the value of the item displayed in the cell of the column/row"
  (let ((newstring (%databrowser-item-data-string cell-buffer)))
    (setf (column-item-value column rowID) newstring)))

;; CHECKBOX COLUMN

(defclass checkbox-column (column)
  ()
  (:default-initargs
   :property-type :CHECKBOX))

(defmethod update-column-row-value ((column checkbox-column) rowID cell-buffer)
  (multiple-value-bind (application-data)
                       (column-item-value column rowID)
    (#_SetDataBrowserItemDataButtonValue cell-buffer (if application-data
                                                       (if (eq application-data :MIXED) ; kludge. Need true, false, and mixed
                                                         #$kThemeButtonMixed
                                                         #$kThemeButtonOn)
                                                       #$kThemeButtonOff))))

(defmethod update-column-item-value ((column checkbox-column) rowID buffer) 
  ; grab checkbox value and stash it
  (with-slots (browser) column
    (rlet ((bval :ThemeButtonValue))
      (#_GetDataBrowserItemDataButtonValue buffer bval)
      (let ((button-value (pref bval :ThemeButtonValue)))
        ;(format t "~%button-value = ~S" button-value)
        (when (databrowser-allow-edits browser) ; this clause is really a kludge that's unnecessary with collection-databrowsers
          (case button-value        ;   because there, the :after method on (setf databrowser-allow-edits) prevents set? being true here
            (#.#$kThemeButtonOn  (setf (column-item-value column rowID) t))
            (#.#$kThemeButtonOff (setf (column-item-value column rowID) nil))
            (t (setf (column-item-value column rowID) :MIXED))))))))

;; POPUP COLUMN

(defclass popup-column (column)
  ((key :type function :initarg :key :initform #'identity)
   (test :type function :initarg :test :initform #'equal)
   (options :type (or list function) :initarg :options :initform nil))
  (:default-initargs
    :property-type :POPUP))

;      (:POPUP #$kDataBrowserpopupMenuType) ; this could be changed by the user

(defmethod update-column-row-value ((column popup-column) rowID cell-buffer)
  (multiple-value-bind (selection)
                       (column-item-value column rowID)
    (with-slots (options key test menu) column
      (let* ((items (etypecase options
                      (list options)
                      (function
                       (with-slots (browser) column
                         (funcall options (databrowser-row-object browser rowID))))))
             (pos (or (when selection
                        (or (position selection items :test test)
                            (position selection items :key key :test test)))
                      0))
             (menu (make-instance 'pop-up-menu 
                     :menu-items 
                     (mapcar 
                      (lambda (item)
                        (typecase item
                          (menu-item item)
                          (otherwise
                           (make-instance 'menu-item
                             :menu-item-title (funcall key item)))))
                      items))))
       (when items
         (unless (menu-installed-p menu)
           (menu-install menu))
         (with-slots (ccl::menu-handle) menu
           (when ccl::menu-handle
             (#_SetDataBrowserItemDataMenuRef cell-buffer ccl::menu-handle) 
             (#_SetDataBrowserItemDataValue cell-buffer (1+ pos))
             (set-pop-up-menu-default-item menu (1+ pos)))))))))

(defmethod update-column-item-value ((column popup-column) rowID buffer)
  (rlet ((&val :SInt32))
    (ccl::errchk (#_GetDataBrowserItemDataValue buffer &val))
    (with-slots (key options) column
      (let* ((value (pref &val :SInt32))
             (items (etypecase options
                      (list options)
                      (function
                       (with-slots (browser) column
                         (funcall options (databrowser-row-object browser rowID))))))
             (item (nth (1- value) items)))      
        (setf (column-item-value column rowID)
              item
              #+ignore
              (funcall key item))))))

;; ICON COLUMN

(defclass icon-column (column)
  ()
  (:default-initargs
    :property-type :ICON))

(defun %set-item-data-icon (buffer value)
  (declare (ftype (function (t) t) ccl::iconref)) 
  (when (and value (method-exists-p 'ccl::iconref value))
    (let ((ref (ccl::iconref value)))
      (declare (dynamic-extent ref)
               (type (or macptr null) ref))
      (when ref
        (unwind-protect
          (ccl::errchk (#_SetDataBrowserItemDataIcon buffer ref))
           #+ignore ; covered by gc
          (#_releaseIconref ref))))))

#+ignore
(eval-when (:load-toplevel :execute) 
  (unless (fboundp 'ccl::get-iconref)
    (warn "Lack of the iconref functions will not prevent the databrowser from operating. It just prevents icons from being shown.")))

(defmethod update-column-row-value ((column icon-column) rowID cell-buffer)
  "Callback to set the value displayed in the cell of the column/row"
  (multiple-value-bind (application-data)
                       (column-item-value column rowID)
    (%set-item-data-icon cell-buffer application-data)))

;; ICON AND TEXT COLUMN

(defclass icon&text-column (column)
  ()
  (:default-initargs
    :property-type :ICONANDTEXT))

;      (:ICONANDTEXT #$kDataBrowserIconAndTextType) ; and I suppose this could too

(defmethod update-column-row-value ((column icon&text-column) rowID cell-buffer)
  (multiple-value-bind (icon text)
                       (column-item-value column rowID)
    (%set-item-data-icon cell-buffer icon)
    (with-slots (browser) column
      (%set-item-data-text browser cell-buffer text))))

;; TIME COLUMN

(defclass time-column (column)
  ((with-seconds 
     :reader column-with-seconds 
     :initarg :with-seconds 
     :initform NIL
     :type boolean
     :documentation "Whether to display seconds"))
  (:default-initargs
    :property-type :TIME))

(defmethod column-other-attributes ((column time-column))
  (list* :with-seconds (column-with-seconds column) 
         (call-next-method)))

(defmethod update-column-row-value ((column time-column) rowID buffer)
  "Callback to set the value displayed in the cell of the column/row"
  (multiple-value-bind (application-data)
                       (column-item-value column rowID)
    (rlet ((dt :LongDateCvt :lHigh 0 :lLow 0))
      (if (numberp application-data) ; if it's an integer, assume it's a Lisp universal-time. Otherwise just display current time.
        ; If you want to display time in other than the browser's default display format, format
        ;   it yourself in a :TEXT column
        (unless (integerp application-data)
          (maybe-log-browser-message "Date ~S was truncated to integer.~%" application-data)
          (setf application-data (truncate application-data)))
        (if (null application-data)
          (setf application-data 0) ; this seems to be what the Finder does for files that don't have dates
          (progn
            (maybe-log-browser-message "Date ~S was not a number. Today's date will be used instead.~%" application-data)
            (setf application-data (get-universal-time)))))
      (setf application-data (ccl::universal-to-mac-time application-data)) ; because Mac time is 1904-based and Lisp is 1900
      (if (< application-data 0) (setf application-data 0)) ; because it could become negative. That would be bad.
      (setf application-data (truncate application-data))
      (let ((time-hi (logand #xFFFFFFFF00000000 application-data))
            (time-lo (logand #xFFFFFFFF application-data)))
        (%put-long dt time-hi 0)
        (%put-long dt time-lo 4)
        (#_SetDataBrowserItemDataLongDateTime buffer dt)
        ; or  (#_SetDataBrowserItemDataDateTime buffer (get-time-unsigned-long) ; this is the Mac time. 1904 based.
        ;    but this will roll over in 2036 or 2040, depending on whose base you use
        ))))

;; OTHER COLUMNS

(defclass progress-bar-column (column)
  ()
  (:default-initargs
    :property-type :PROGRESS-BAR))

(defclass relevance-column (column)
  ()
  (:default-initargs
    :property-type :RELEVANCE))

(defclass slider-column (column)
  ()
  (:default-initargs 
    :property-type :SLIDER))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COLUMN DESCRIPTIONS

(defparameter *column-type->class* 
  '((:TEXT . text-column)
    (:CHECKBOX . checkbox-column)
    (:POPUP . popup-column)
    (:ICON . icon-column)
    (:ICONANDTEXT . icon&text-column)
    (:TIME . time-column)
    (:PROGRESS-BAR . progress-bar-column)
    (:RELEVANCE . relevance-column)
    (:SLIDER . slider-column)
    (:POPUP . popup-column)))

(defgeneric make-databrowser-column (databrowser descriptor &rest args)
  (:documentation "Makes a databrowser column from a description"))

(defmethod make-databrowser-column ((databrowser databrowser) descriptor &rest args)
  (declare (dynamic-extent args))
  (error "Invalid column description ~S ~S" descriptor args))

(defmethod make-databrowser-column ((databrowser databrowser) (descriptor symbol) &rest args 
                                    &key (function descriptor) reader
                                         (title (ignore-errors ; in case it's a lambda, car won't be stringable
                                                 ;; ## Consider using string-capitalize!
                                                 (string descriptor)))
                                    &allow-other-keys)
  (declare (dynamic-extent args))
  (let* ((ptype (getf args :PROPERTY-TYPE))
         (column-class (if ptype
                         (or (cdr (assoc ptype *column-type->class*))
                             (error "Invalid column property type ~S" ptype))
                         'text-column)))
    (apply #'make-instance column-class 
           :reader (or reader function) 
           :title title 
           (ccl::remove-keywords args '(:PROPERTY-TYPE)))))

(defmethod make-databrowser-column ((databrowser databrowser) (descriptor function) &rest args &key (title "Untitled") &allow-other-keys)
  (declare (dynamic-extent rest))
  (apply #'make-instance 'text-column :function descriptor :title title args))

#+ignore
(defun parse-column-descriptor (descriptor-specification)
  (let* ((ptype (when (consp descriptor-specification) 
                  (getf (cdr descriptor-specification) :PROPERTY-TYPE)))
         (descriptor (apply #'make-instance (if ptype 
                                              (cdr (assoc ptype *column-type->class*))
                                              'text-column)
                            (ccl::remove-keywords (cdr descriptor-specification)
                                                  '(:TITLE :EDITABLE :MORE-FUNCTION-PARAMETERS :PROPERTY-TYPE :FUNCTION :SETTER)))))
    (cond ((consp descriptor-specification)
           (setf (column-function descriptor) (car descriptor-specification))
           (setf (more-function-parameters  descriptor) (getf (cdr descriptor-specification) :MORE-FUNCTION-PARAMETERS))
           (setf (column-title    descriptor) (or (getf (cdr descriptor-specification)   :TITLE)
                                                  (ignore-errors ; in case it's a lambda, car won't be stringable
                                                   (string (car descriptor-specification)))))
           ;(when ptype
           ;  (setf (column-property-type descriptor) ptype)) ; defaults to :TEXT
           (setf (column-editable     descriptor) (getf (cdr descriptor-specification) :EDITABLE))
           (setf (column-setter        descriptor) (getf (cdr descriptor-specification) :SETTER))
           #+ignore
           (setf (column-other-attributes descriptor)
                 (ccl::remove-keywords (cdr descriptor-specification)
                                  '(:TITLE :EDITABLE :MORE-FUNCTION-PARAMETERS :PROPERTY-TYPE :FUNCTION :SETTER))))
          ((symbolp descriptor-specification)
           (setf (column-function descriptor) descriptor-specification)
           (setf (column-title    descriptor) (string descriptor-specification)))
          ((functionp descriptor-specification)
           (setf (column-function descriptor) descriptor-specification)
           (setf (column-title    descriptor) "Untitled"))
          (t (error "Invalid column descriptor specification ~S" descriptor-specification)))
     descriptor))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COLLECTION DATABROWSER - The main high-level API.

(defvar *first-row-id* 2 "ID of first row in browser. Zero is not allowed.")
(defvar *first-column-id* 1025 "ID of first column in browser. First 1024 are reserved by Apple.")

(defclass two-way-table ()
  ((forward-table :initarg :forward-table :initform (make-hash-table) :accessor forward-table)
   (reverse-table :initarg :reverse-table :initform (make-hash-table :test 'equal) :accessor reverse-table)
   (next-id :initarg :next-id :initform *first-row-id* :accessor next-id)))

(defmethod clear-two-way-table ((table two-way-table))
  "Clear the table and reset its identifier to beginning."
  (clrhash (forward-table table))
  (clrhash (reverse-table table))
  (setf (next-id table) *first-row-id*))

(defclass collection-databrowser (databrowser)
  ((column-descriptors 
    :accessor column-descriptors
    :initarg :column-descriptors 
    :initarg :columns ;; preferable!
    :initform nil 
    :documentation "A sequence (use a vector for best speed) of column descriptors. See documentation.")
   (first-column-id :initarg :first-column-id :initform *first-column-id* :accessor
                     first-column-id
                     :documentation "ID of leftmost column")
   (object-table :initarg :object-table :initform (make-instance 'two-way-table) :accessor object-table)
   (triangle-space :initarg :triangle-space :initform t :accessor triangle-space
              :documentation "True if you want to allocate space for disclosure triangles in leftmost column.
                              (For now, the leftmost column is the only place they can go, although the underlying
                               API allows them to go in any column.)
                              You still have to ensure that #'databrowser-item-containerp returns true for your row before
                              a triangle will actually appear."))
  (:documentation "Databrowser specialized for displaying a collection of objects, one per row, where
    columns represent attributes of the objects."))

; This is necessary so you can use arrow keys to move around in databrowser, when there is some
;   other kind of view in the same window that can also be a key handler. Without this method,
;   key control doesn't revert to the browser when you click in it.
(defmethod view-click-event-handler :after ((item databrowser) where)
  (declare (ignore where))
  (let ((my-dialog (view-window item)))
    (when my-dialog
      (if (neq item (current-key-handler my-dialog))
        (set-current-key-handler my-dialog item nil)))))

(defmethod get-databrowser-column ((browser collection-databrowser) columnID)
  "Returns the column object identified with the ID"
  (with-slots (column-descriptors) browser
    (elt column-descriptors (- columnID (first-column-id browser)))))

; don't use!
(defmethod lookup-property-type ((browser collection-databrowser) columnID)
  (column-property-type (get-databrowser-column browser columnID)))

(defmethod (setf databrowser-allow-edits) :after (value (browser collection-databrowser))
  "Globally turn off/on editability of everything in the browser. Can turn off editability
   of columns defined to be editable, but doesn't turn on editability of columns defined not
   to be."
  (map nil (lambda (column)
             (setf (column-allow-edits column) value))
       (column-descriptors browser)))

(defmethod window-can-do-operation ((browser collection-databrowser) op &optional item)
  (declare (ignore item))
  (and (eq op 'copy) (databrowser-selected-rows browser)))

(defmethod copy ((browser collection-databrowser))
  "Default method just grabs a list of the objects in the selected rows."
  (let ((rows (databrowser-selected-rows browser)))
    (when rows
      (put-scrap :LISP 
                 (mapcar #'(lambda (rowid) (databrowser-row-object browser rowid))
                          rows)))))

(defmethod databrowser-add-items ((browser collection-databrowser) items &optional parentID sortPropertyID)
  (let ((offset 0)
        (len (length items))
        )
    (unless (zerop len)
      (let ((height (min-row-height browser)))
        (when height
          ; The default row height has to be updated before adding rows, no effect if set when creating browser!
          (#_setDataBrowserTableViewRowHeight (dialog-item-handle browser) height)))
      (with-slots (forward-table reverse-table) (object-table browser)
        (%stack-block ((ids (* 4 len) :clear t)) ; God help us all
          (flet ((add-item (item)
                   (let ((numeric-id (gethash item reverse-table)))
                     (unless numeric-id ; maintain numeric-ids for items even if triangles open, close, and open again
                       (setf numeric-id (incf (next-id (object-table browser))))
                       (setf (gethash item reverse-table) numeric-id)
                       (setf (gethash numeric-id forward-table) item))
                     (%put-long ids numeric-id offset)
                     (incf offset 4))))
            (map nil #'add-item items)
            (ccl::errchk (#_AddDataBrowserItems
                          (dialog-item-handle browser)
                          (or parentID #$kDataBrowserNoItem)
                          len
                          ids
                          (or sortPropertyID #$kDataBrowserItemNoProperty)))))))))

(defmethod databrowser-remove-all :before ((browser collection-databrowser) &optional propertyID sortorder)
  (declare (ignore propertyID sortorder))
  (clear-two-way-table (object-table browser)))

(defmethod databrowser-remove-items ((browser collection-databrowser) items &optional parentID sortpropertyID)
  (let ((offset 0)
        (len (length items)))
    (unless (zerop len)
      (with-slots (forward-table reverse-table) (object-table browser)
        (%stack-block ((ids (* 4 len) :clear t))
          (flet ((remove-item (item)
                   (let ((numeric-id (gethash item reverse-table)))
                     (assert numeric-id () "Attempted to remove a non-existing item ~A from ~A" item browser)
                     (remhash item reverse-table)
                     (remhash numeric-id forward-table)
                     (%put-long ids numeric-id offset)
                     (incf offset 4))))
            (if (listp items)
              (dolist (item items)
                (remove-item item))
              (dotimes (i len)
                (remove-item (elt items i))))
            (ccl::errchk (#_RemoveDataBrowserItems
                          (dialog-item-handle browser)
                          (or parentID #$kDataBrowserNoItem)
                          len
                          ids
                          (or sortPropertyID 
                              #$kDataBrowserItemNoProperty)))))))))

(defmethod finish-initializing ((browser collection-databrowser))
  "Try to deduce a setter function if we weren't given one. Note that this won't work for 'macro-style'
    setf forms like (setf car) and friends. It only works for user-defined setf functions and CLOS accessor
    methods."
  (call-next-method)
  (let ((columnID (first-column-id browser))
        (descriptor nil))
    (with-slots (column-descriptors) browser
      (setf column-descriptors
            (map 'vector ; might as well always use a vector
                 #'(lambda (description)
                     (typecase description
                       (column description)
                       (cons
                        (apply #'make-databrowser-column browser description))
                       (otherwise
                        (make-databrowser-column browser description))))
                 column-descriptors))
      
      (dotimes (i (length column-descriptors))
        (setf descriptor (elt column-descriptors i))
        (setf (property-id descriptor) columnID) ; for future reference
        ;; ## Make install-column-in-databrowser method for this? a la install-view-in-window...
        (setf (slot-value descriptor 'browser) browser)
        (apply 'databrowser-add-listview-column
         browser
         :property-id columnID
         :property-type (column-property-type descriptor)
         :title (column-title descriptor)
         :editable (column-editable descriptor)
         (column-other-attributes descriptor)
         )
        (incf columnID))
      (when (and (triangle-space browser)
                 (> (length column-descriptors) 0))
        (#_SetDataBrowserListViewDisclosureColumn (dialog-item-handle browser) (first-column-id browser)  nil)
        )
      )))

; Specialize these only if you invent a new kind of browser
(defmethod databrowser-row-object ((browser collection-databrowser) rowID)
  "Returns the object on the given rowID."
  (gethash rowID (forward-table (object-table browser))))

(defmethod databrowser-object-row ((browser collection-databrowser) object)
  "Returns the rowID for an object given an object in the browser."
  (gethash object (reverse-table (object-table browser))))

(defmethod %databrowser-item-data ((browser collection-databrowser) rowID (property (eql #$kDataBrowserItemIsContainerProperty)) item-data set?)
  "This method is called automatically by the browser when it wants to know if an item is a container."
  (declare (ignore set?))
  (#_SetDataBrowserItemDataBooleanValue item-Data (databrowser-item-containerp browser (databrowser-row-object browser rowID)))
  nil)

; for column view
(defmethod %databrowser-item-data ((browser collection-databrowser) rowID (property (eql #$kDataBrowserItemParentContainerProperty)) item-data set?)
  "This method is called automatically by the browser when it wants to know if an item is a container."
  (declare (ignore set?))
  ;(#_SetDataBrowserItemDataBooleanValue item-Data (databrowser-item-containerp browser (databrowser-row-object browser rowID)))
  ;(print "#$kDataBrowserItemParentContainerProperty !")
  (let ((parent (databrowser-item-parent browser (databrowser-row-object browser rowID)))
        (parentID 0))
    (when parent
      (setf parentID (databrowser-object-row browser parent))
      (unless parentID ; might not be there
        (with-slots (forward-table reverse-table) (object-table browser)
          (setf parentID (incf (next-id (object-table browser))))
          (setf (gethash parent reverse-table) parentID)
          (setf (gethash parentID forward-table) parent))))
    (#_SetDataBrowserItemDataItemID item-data parentID)
    nil))

; for column view
(defmethod %databrowser-item-data ((browser collection-databrowser) rowID (property (eql #$kDataBrowserItemSelfIdentityProperty )) item-data set?)
  "This method is called automatically by the browser when it wants to know if an item is a container."
  (%databrowser-item-data browser rowID (first-column-id browser) item-data set?)
  ;(print "#$kDataBrowserItemSelfIdentityProperty !")
  nil)

(defmethod lookup-browser-data ((browser collection-databrowser) rowID columnID &optional (comparing-p nil))
  (let ((rowitem (databrowser-row-object browser rowID))
        (column (get-databrowser-column browser columnID)))
    (ignore-errors
     (if (more-function-parameters column)
       (funcall (column-function column) rowitem comparing-p browser rowID)
       (funcall (column-function column) rowitem)))))

; Specialize only if you invent a new kind of browser
(defmethod (setf lookup-browser-data) (data (browser collection-databrowser) rowID columnID)
  (let* ((rowitem (databrowser-row-object browser rowID))
         (column (get-databrowser-column browser columnID))
         (column-setter (when column (column-setter column))))
    (when column-setter ; no edits can be permanent without this
      (funcall column-setter data rowitem))))

; Specialize for your application
(defmethod databrowser-item-selected         ((browser collection-databrowser) rowID)
  (declare (ignore rowID))
  ; (databrowser-update browser rowID) ; uncomment this if you have column functions that
  ;    change what they display based on selection status
  ;(format t "~%You selected ~S" (databrowser-row-object browser rowID))
  )

; This one is handy for debugging. Gotta do cmd-option in actuality right now.
;   Don't use control because we'll eventually use that for contextual menus.
;   Can't use just command because, well, it doesn't work. It tries to make
;    a disjoint selection.
(defmethod databrowser-item-selected :around ((browser collection-databrowser) rowID)
  (when *debug*
    (let ((object (databrowser-row-object browser rowID)))
      (when (and (option-key-p) (command-key-p)) ; quick way to inspect the object
        (inspect object))))
  (call-next-method))

; Specialize for your application if needed.
(defmethod databrowser-item-deselected         ((browser collection-databrowser) rowID)
  (declare (ignore rowID))
  ; (databrowser-update browser rowID) ; uncomment this if you have column functions that
  ;    change what they display based on selection status
  ;(format t "~%You deselected ~S" (databrowser-row-object browser rowID))
  )

; Specialize for your application. This default method will work if you
;   specialize databrowser-item-children instead, but since this method
;   is called _a lot_, it may make your code faster to also specialize
;   databrowser-item-containerp.
(defmethod databrowser-item-containerp ((browser t) (item t))
  "Specialize for your application. Item should be one of your row objects.
   Return true if you want this object to appear with a twist-down triangle."
  (when (databrowser-item-children browser item) t))

;;  #'databrowser-item-containerp is a separate generic function from #'databrowser-item-children because it's conceivable that
;;  #'databrowser-item-containerp could be much cheaper to call than #'databrowser-item-children, and the former
;;  is called by the databrowser quite frequently, while the latter is called
;;  only when the user clicks on a triangle.

; Specialize for your application
(defmethod databrowser-item-children ((browser t) (item t))
  "Specialize for your application. Should return a sequence of subitems for this item,
   or just nil if there aren't any. It only makes sense for this to return non-nil
   if (databrowser-item-containerp browser item) is also true."
  (with-slots (children-function) browser
    (when children-function
      (funcall children-function item))))

(defmethod databrowser-item-parent ((browser t) (item t))
  "Specialize for your application. Should return the parent item of this one, or nil if none.
   Only needed for column view, which is not yet supported."
  (with-slots (parent-function) browser
    (when parent-function
      (funcall parent-function item))))

; Specialize for your application only if default method is insufficient.
(defmethod databrowser-container-opened ((browser collection-databrowser) rowID)
  "Called when user twists down a container's triangle.
   This default method should work for most purposes. Specialize if necessary, 
   but you should mostly specialize #'databrowser-item-children."
  ;(format t "Opened row ~D" rowID)
  (let ((parent-thing (databrowser-row-object browser rowID)))
    (databrowser-add-items
     browser
     (databrowser-item-children browser parent-thing)
     rowID)
    (databrowser-update browser rowID) ; only necessary to assist column functions that
        ; change the displayed string depending on whether triangle is open or closed.
        ; These are always column functions that are specified with :more-function-parameters.
        ; Anyway, these functions will have no effect unless we call databrowser-update
        ;   here, because the browser caches its cell values aggressively.
    ))

; Probably no need to specialize this.
(defmethod databrowser-container-closing ((browser collection-databrowser) rowID)
  "Apparently you don't really have to do anything here to cause proper display,
   except call databrowser-update.
   And I'm only doing _that_ because it's necessary in the few cases where 
   some column function displays one value when a triangle is open vs. when it's closed.
   (See documentation for databrowser-container-opened.) 
   Customize for side-effects if needed."
  ;(format t "Closing row ~D" rowID)
  (databrowser-update browser rowID)
  )

(eval-when (:load-toplevel :compile-toplevel :execute) 
  (pushnew (make-pathname :host (pathname-host (or *load-truename* *loading-file-source-file*))
                          :directory (append (pathname-directory (or *load-truename* *loading-file-source-file*))
                                             '("databrowser-examples")))
           ccl::*module-search-path*)) ; so require <databrowser-example> will work

(provide "DATABROWSER")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; EXAMPLE. See better examples in individual example files like
; file-browser.lisp
; search-files-browser.lisp
; employee-browser.lisp
; etc.
#|
;====Example 1: Basic raw browser. This uses the lowest-level API which should never be used in real programs.
(defun test-raw-browser ()
  (let ((databrowser (MAKE-INSTANCE
                       'databrowser
                       :allow-edits t ; change this after browser is created to see the effect
                       :VIEW-SIZE
                       #@(341 224)
                       :VIEW-POSITION
                       #@(91 58))))
    (MAKE-INSTANCE
      'COLOR-DIALOG
      :WINDOW-TYPE
      :DOCUMENT-WITH-GROW
      :VIEW-POSITION
      #@(105 74)
      :VIEW-SIZE
      #@(536 355)
      :back-color ccl::*green-color*
      :VIEW-SUBVIEWS
      (LIST (MAKE-DIALOG-ITEM 'ccl::STATIC-TEXT-DIALOG-ITEM #@(337 300) #@(54 16) "Example" 'NIL)
            databrowser))
  (databrowser-add-listview-column databrowser :fontstyle :bold :editable t)
  (databrowser-add-items databrowser nil)
  databrowser
  ))

(test-raw-browser)

|#

 