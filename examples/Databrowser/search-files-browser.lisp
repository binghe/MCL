;; Copyright (2004) Sandia Corporation. Under the terms of Contract DE-AC04-94AL85000 with
;; Sandia Corporation, the U.S. Government retains certain rights in this software.

;; This software is governed by the terms
;; of the Lisp Lesser GNU Public License
;; (http://opensource.franz.com/preamble.html),
;; known as the LLGPL.

;; This software is available at
;; http://aisl.sandia.gov/source/

;;; search-files-browser.lisp

;;; Uses databrowser to show multi-file search results. The next time you do "Search Files",
;;;  you'll see the difference.
;;; Shows three columns:
;;;  filename, number of hits and last modified date. Hits is how many times the
;;;  search string occurred in the file, with your 'search comments' choice taken into account.
;;; Also shows a 'files found' item at the bottom of the dialog that shows how many files
;;;  contained the string, followed by a slash, followed by a count of the total number of files searched.

;;; You can re-sort the items by clicking the column headers, change the width of the columns
;;;   by dragging them, and even drag entire columns around. Note what happens if you
;;;   widen the 'Last Modified' column--it shows more information.

;;; I think it's safe to assume Boyer-Moore.lisp is loaded now, so we don't check for it herein.

;;; HISTORY;;; 2010-feb-11 Terje  Increased window width of the search window to accomodate the databrowser.;;;                    Truncate the text of the displayed search path in the middle instead of at the end. ;;; 2010-feb-03 Terje  Auto resize the databrowser to match the window size. ;;; 2010-feb-03 Terje  Provide a minimum row height for the databrowser. 
;;; July 1, 2004 SVS use the directory function as an iterator (generator) such that
;;;         we can begin searching immediately, without waiting for the entire list of files
;;;         to be generated, and we won't have to contain a potentially huge list of files in memory either.
;;;         Assumes *search-files-iterator* has been defined and is used in #'extended-search-files-dialog.
;;;         Otherwise, the old non-iterator method is used.
;;;         Also added "/~D" to the "Files found" output item so you can see how many total files were looked at.

;;; BUGS:
;;; Hits column sometimes gets "..." instead of actual hits. This usually happens when its
;;; column starts out too small. Don't know how to fix it.

(in-package :ccl)
(require :databrowser)
(require :autosize)
(defclass brw::file-collection-databrowser (brw:collection-databrowser auto-resizable-view-mixin)
  ())(defmethod auto-resize-view ((view brw::file-collection-databrowser) (container simple-view))  (let ((delta (subtract-points (view-size container) (previous-container-size view))))    (set-view-size view (add-points (view-size view) delta)))  (brw::auto-size-columns view))
(defclass db-item-selection-dialog-with-stop (item-selection-dialog-with-stop)
  ())

(defmethod add-dialog-items ((dialog db-item-selection-dialog-with-stop)
                             &rest args &key the-list selection-type action-function
                             default-button-text stop-button-text column-descriptors)
  (declare (ignore args the-list))
  (flet ((act-on-items (item)
           (declare (ignore item))
           (let ((db-item (view-named 'sequence-dialog-item dialog)))
             (funcall action-function
                      (mapcar #'(lambda (rowid) (brw:databrowser-row-object db-item rowid))
                              (brw:databrowser-selected-rows db-item))))))
    
    (let ((button-width (if (osx-p) 60 58))
          (button-height 20)
          (state-width 60)
          (text-height 12)
          (spacing-a 13)
          (border 3)
          (size (view-size dialog)))
      (add-subviews dialog
                    (make-instance 'static-text-dialog-item-ar
                      :dialog-item-text ""
                      :view-position (make-point (+ spacing-a border)
                                                 (+ (floor (- button-height text-height) 2)
                                                    (- spacing-a border)))
                      :view-size (make-point state-width text-height)
                      :view-font '("Geneva" 9 :bold)
                      :view-nick-name 'state)
                    (make-instance 'ellipsized-text-dialog-item 
                      :dialog-item-text ""
                      :view-position (make-point (+ spacing-a border border state-width)
                                                 (+ (floor (- button-height text-height) 2)
                                                    (- spacing-a border)))
                      :view-size (make-point (- (point-h size) 
                                                (+ (+ spacing-a border) border state-width)
                                                border
                                                button-width (- spacing-a border) spacing-a)     ; button left
                                             text-height)
                      :view-font '("Geneva" 9 :italic)
                      :view-nick-name 'detailed-state                      :text-truncation :middle
                      :compress-text nil)       ; avoid bug where compressing switches to non-italics
                    (make-instance 'button-dialog-item
                      :dialog-item-text stop-button-text
                      :view-position (make-point (- (point-h size) (- spacing-a border) spacing-a button-width)
                                                 (- spacing-a border))
                      :view-size (make-point button-width button-height)
                      :view-nick-name 'stop-button
                      :dialog-item-action
                      #'(lambda (item)
                          (declare (ignore item))
                          (when (stop-action dialog)
                            (funcall (stop-action dialog) dialog))))
                    (make-instance
                      'brw::file-collection-databrowser
                      :view-position (make-point spacing-a 
                                                 (+ (- spacing-a border) button-height spacing-a))
                      :view-size (make-point (- (point-h size)                                                spacing-a     ; left
                                                (- spacing-a border) spacing-a)          ; right
                                             (- (point-v size)
                                                (- spacing-a border) button-height spacing-a     ; top
                                                spacing-a button-height spacing-a))     ; bottom
                      :VIEW-FONT ;'("Monaco" 9 :extend) ; seems to be a bug here--need :extend or it condenses the text
                       '(11)                      :min-row-height 15
                      :selection-type selection-type
                      :view-nick-name 'sequence-dialog-item ; keep the same old name as before
                      :vscrollp t
                      :hscrollp nil
                      :column-descriptors column-descriptors
                      :triangle-space nil                      :focus-ring T
                      )                    
                    (MAKE-DIALOG-ITEM
                     'STATIC-TEXT-dialog-item-AR
                     (make-point 20 (- (point-v (view-size dialog)) 30))
                     #@(98 16)
                     "Files found:"
                     'NIL
                     :VIEW-NICK-NAME
                     'FILES-FOUND
                     :VIEW-FONT
                     '("Geneva" 9 :SRCOR :BOLD (:COLOR-INDEX 0)))
                    (MAKE-DIALOG-ITEM
                     'STATIC-TEXT-dialog-item-AR
                     (make-point 82 (- (point-v (view-size dialog)) 30))
                     #@(54 16)
                     "0"
                     'NIL
                     :VIEW-NICK-NAME
                     'file-COUNT
                     :VIEW-FONT
                     '("Geneva" 9 :SRCOR :PLAIN (:COLOR-INDEX 0)))
                    (make-instance 
                      'default-button-dialog-item
                      :dialog-item-enabled-p nil ; until something is selected
                      :dialog-item-text default-button-text
                      :view-position (make-point (- (point-h size) (- spacing-a border) spacing-a button-width)
                                                 (- (point-v size) spacing-a button-height))
                      :view-size (make-point button-width button-height)
                      :view-nick-name 'locate-button
                      :dialog-item-action
                      #'act-on-items)))
    nil))

(defun db-select-items-from-list-with-stop (the-list &key (window-title "Select an Item")
                                                     (selection-type :single)
                                                     (action-function #'identity)
                                                     (stop-button-text "Stop")
                                                     (stop-action nil)
                                                     (default-button-text "Find It")
                                                     (window-position-variable nil)
                                                     (window-size-variable nil)
                                                     (column-descriptors (list 'identity))
                                                     )
  "Displays the elements of a list, and returns the item chosen by the user"
  #+ccl-3
  (when stop-action
    (let ((process *current-process*)
          (user-stop-action stop-action))
      (setq stop-action
            #'(lambda (dialog)
                (process-interrupt process user-stop-action dialog)))))
  (let ((dialog (make-instance
                  'db-item-selection-dialog-with-stop
                  :stop-action stop-action
                  :back-color *tool-back-color*
                  :content-color *tool-back-color*
                  :theme-background t
                  :window-show t
                  :window-position-variable window-position-variable
                  :window-size-variable window-size-variable
                  :window-title window-title
                  :view-size (or (and window-size-variable (symbol-value window-size-variable))
                                 #@(600 180))
                  :view-position  (or (and window-position-variable (symbol-value window-position-variable))
                                      (make-point (%ilsr 1 (- *screen-width* 400))
                                                  90))
                  )))
    (add-dialog-items dialog
                      :the-list the-list
                      :selection-type selection-type
                      :action-function action-function
                      :stop-button-text stop-button-text
                      :default-button-text default-button-text
                      :column-descriptors column-descriptors)
    (brw::auto-size-columns (view-named 'sequence-dialog-item dialog))
    ; Squeeze the row height down a little bit. Use a trap because I haven't bothered to make a 
    ;   high-level interface for this yet.
    (#_SetDataBrowserTableViewRowHeight (dialog-item-handle (view-named 'sequence-dialog-item dialog)) 12)    
    (window-show dialog)))

(defclass file-result-object ()
  ((pathname :initarg :pathname :initform nil :accessor get-pathname)
   (mod-date :initarg :mod-date :initform nil :accessor mod-date)
   (hits :initarg :hits :initform 0 :accessor hits
         :documentation "How may occurrences of the given string were in the file.")))

(defun db-searching-files-selection-dialog (string)
  (db-select-items-from-list-with-stop nil
                                       :window-title (format nil "Files Containing: ~A" string)
                                       :window-position-variable '*search-files-dialog-position*
                                       :window-size-variable '*search-files-dialog-size*
                                       :stop-action
                                       #'(lambda (dialog)
                                           (dialog-item-disable (view-named 'stop-button dialog))
                                           (set-dialog-item-text (view-named 'detailed-state dialog) "Aborted.")
                                           (abort))
                                       :action-function
                                       #'(lambda (list)
                                           (using-binder-editor
                                             (maybe-start-isearch (ed (get-pathname (car list))) string)))
                                       :column-descriptors (vector
                                                            (list                                                              (lambda (item comparing-p browser rowID)
                                                               (declare (ignore browser rowID comparing-p))
                                                               (file-namestring (get-pathname item)))
                                                             :title "Filename" :minwidth 120 :justification :left :more-function-parameters t)                                                            (list                                                             (lambda (item comparing-p browser rowID)
                                                               (declare (ignore browser rowID comparing-p))
                                                               (posix-dir-string (pathname-directory (get-pathname item))))
                                                             :title "Path" :minwidth 120 :maxwidth 1800 :justification :left :more-function-parameters t)
                                                            '(hits :title "Hits" :minwidth 70 :maxwidth 120)
                                                            '(mod-date :title "Last Modified" :property-type :time :minwidth 100)
                                                            )
                                       ))
(defun db-searching-files-dialog-with-iterator (string pathname text-only-p search-comments-p)
  (let* ((dialog (db-searching-files-selection-dialog string))
         (db (view-named 'sequence-dialog-item dialog))
         (state (view-named 'state dialog))
         (detailed-state (view-named 'detailed-state dialog))
         (complete? nil)
         (current-file nil)
         (filecount 0)
         (initialized-buffer nil)
         (scratch-buffer nil)
         (atleastonefile nil)
         (bm (compute-bm-tables string))
         (totalfiles 0))
    (set-dialog-item-text state "Searching:")
    ;(set-dialog-item-text detailed-state "Collecting File List…") ; Gone!
    (unwind-protect
      (labels ((start-file-search (file)
                 (when (null (wptr dialog))
                   (return-from db-searching-files-dialog-with-iterator))
                 (incf totalfiles)
                 (set-dialog-item-text detailed-state (format nil "~A" file)))
               
               (search-successful (file)
                 (cond (current-file
                        (incf (hits current-file)))
                       (t ; no current-file yet
                        (setf current-file (make-instance 'file-result-object
                                             :pathname file
                                             :mod-date (file-write-date file)
                                             :hits 1))
                        (brw:databrowser-add-items db (list current-file))
                        (set-dialog-item-text (view-named 'file-count dialog) (format nil "~D/~D" (incf filecount) totalfiles)))))
               
               (ensure-buffer (file)
                 (or initialized-buffer
                     (progn
                       (setf initialized-buffer (or scratch-buffer (setq scratch-buffer (make-buffer))))
                       (%buffer-insert-file initialized-buffer file 0)
                       initialized-buffer)))
               (process-file (file)
                 ; This function is the :test fn parameter to #'directory. It'll be
                 ;   called on every file #'directory finds. Here, we're using it
                 ;   as a continuation processor rather than a test per se. Isn't it
                 ;   lucky that #'directory was designed with this parameter in the first place?
                 (setf atleastonefile t)
                 (flet ((f (pos)
                          (if pos ;Found, but may be in a comment.
                            (progn
                              (when (or search-comments-p
                                        (not (buffer-point-in-comment? (ensure-buffer file) pos 0 (buffer-size (ensure-buffer file))))
                                        )
                                (search-successful file))
                              t) ; keep searching in this file
                            (progn ; pos was nil so we're done with this file
                              (when current-file
                                (brw:databrowser-update db (brw:databrowser-object-row db current-file)) ; so hits will be updated
                                (setf current-file nil))
                              (when scratch-buffer (buffer-delete scratch-buffer 0 t))
                              (setf initialized-buffer nil))
                            )))
                   (declare (dynamic-extent #'f))
                   (start-file-search file)
                   (find-bm-tables-in-file bm file #'f))
                 
                 nil ; must return nil to convince #'directory not to cons the found files up as a giant
                 ; returned list, since that's part of the whole point
                 ))
        
        (declare (dynamic-extent #'start-file-search #'search-successful #'ensure-buffer #'process-file))
        
        ; All the work now happens in #'directory as a side-effect
        (if text-only-p
          (directory pathname :test #'(lambda (f)
                                        (ignore-errors
                                         (when (eq (mac-file-type f) :TEXT)
                                           (process-file f)))))
          (directory pathname :test #'(lambda (f)
                                        (ignore-errors
                                         (process-file f)))))
        
        (unless atleastonefile 
          (message-dialog
           (format nil "No~:[~; text~] files correspond to ~s"
                   text-only-p pathname)
           :title "Search Files")
          (window-close dialog)
          (return-from db-searching-files-dialog-with-iterator))
        
        (setq complete? t))
      (ignore-errors
       (brw:databrowser-update db t) ; update the whole thing
       (dialog-item-disable (view-named 'stop-button dialog))
       (set-dialog-item-text (view-named 'file-count dialog) (format nil "~D/~D" filecount totalfiles))
       (set-dialog-item-text detailed-state (if complete? 
                                              (format nil "Completed searching “~A”." pathname)
                                              "Canceled."))))
    ))

(defun db-searching-files-dialog (string files-function pathname search-comments-p)
  (let* ((dialog (db-searching-files-selection-dialog string))
         (db (view-named 'sequence-dialog-item dialog))
         (state (view-named 'state dialog))
         (detailed-state (view-named 'detailed-state dialog))
         (complete? nil)
         (files nil)
         (current-file nil)
         (filecount 0)
         (initialized-buffer nil)
         (scratch-buffer nil)
         (totalfiles 0))
    (set-dialog-item-text state "Searching:")
    (set-dialog-item-text detailed-state "Collecting File List…")
    (setq files (funcall files-function))
    (setf totalfiles (length files))
    (set-dialog-item-text (view-named 'file-count dialog) (format nil "~D/~D" filecount totalfiles))
    (unless files 
      (window-close dialog)
      (return-from db-searching-files-dialog))

    (unwind-protect
      (flet ((start-file-search (file)
               (when (null (wptr dialog))
                 (return-from db-searching-files-dialog))
               (set-dialog-item-text detailed-state (format nil "~A" file))
               )
             (search-successful (file)
               (cond (current-file
                      (incf (hits current-file)))
                     (t ; no current-file yet
                      (setf current-file (make-instance 'file-result-object
                                           :pathname file
                                           :mod-date (file-write-date file)
                                           :hits 1))
                      (brw:databrowser-add-items db (list current-file))
                      (set-dialog-item-text (view-named 'file-count dialog) (format nil "~D/~D" (incf filecount) totalfiles))
                      ))
               )
             (ensure-buffer (file)
               (or initialized-buffer
                   (progn
                     (setf initialized-buffer (or scratch-buffer (setq scratch-buffer (make-buffer))))
                     (%buffer-insert-file initialized-buffer file 0)
                     initialized-buffer)))
             )
        
        (declare (dynamic-extent #'start-file-search #'search-successful #'ensure-buffer))
        (flet ((f (file pos)
                 (when file
                   (cond ((eq pos t) (start-file-search file))
                         (pos ;Found, but may be in a comment.
                          (when (or search-comments-p
                                    (not (buffer-point-in-comment? (ensure-buffer file) pos 0 (buffer-size (ensure-buffer file))))
                                    )
                            (search-successful file))
                          t ; keep searching in this file
                          )
                         (t ; pos was nil so we're done with this file
                          (when current-file
                            (brw:databrowser-update db (brw:databrowser-object-row db current-file)) ; so hits will be updated
                            (setf current-file nil))
                          (when scratch-buffer (buffer-delete scratch-buffer 0 t))
                          (setf initialized-buffer nil)
                          )
                         ))))
          (declare (dynamic-extent #'f))
          (bm-find-string-in-files string files #'f))
        
        (setq complete? t))
      (ignore-errors
       (brw:databrowser-update db t) ; update the whole thing
       (dialog-item-disable (view-named 'stop-button dialog))
       (set-dialog-item-text detailed-state (if complete? 
                                              (format nil "Completed searching “~A”." pathname)
                                              "Canceled."))))
    ))

; Handle double clicks
(defmethod brw:databrowser-item-double-clicked ((browser brw::file-collection-databrowser) rowID)
  (declare (ignore rowID))
  (let ((default-button (default-button (view-container browser))))
    (when (dialog-item-enabled-p default-button)
      (dialog-item-action default-button))))

(defmethod brw:databrowser-item-selected ((browser brw::file-collection-databrowser) rowID)
  (declare (ignore rowID))
  (dialog-item-enable (default-button (view-container browser))))

; Doesn't seem to be any easy way to deselect all rows, so we don't worry about disabling default button

; Handle <return> key
(defmethod view-key-event-handler ((browser brw::file-collection-databrowser) char)
  (case char
    ((#\newline)
     (let ((selected-items (brw:databrowser-selected-rows browser)))
       (brw:databrowser-item-double-clicked browser (car selected-items))
       ))
    (t
     (call-next-method) ; handle arrow keys etc.
     )))

(defvar *old-searching-files-dialog* (fdefinition 'searching-files-dialog))
(defvar *old-searching-files-dialog-with-iterator* (when (fboundp 'searching-files-dialog-with-iterator)
                                                     (fdefinition 'searching-files-dialog-with-iterator)))

(eval-when (:load-toplevel :execute)
  (let ((*warn-if-redefine-kernel* nil))
    (setf (fdefinition 'searching-files-dialog) #'(lambda (&rest args) (apply 'db-searching-files-dialog args)))
    (when (fboundp 'searching-files-dialog-with-iterator)
      (setf (fdefinition 'searching-files-dialog-with-iterator) #'(lambda (&rest args) (apply 'db-searching-files-dialog-with-iterator args))))))

; to restore the old dialog
#|
(let ((*warn-if-redefine-kernel* nil))
  (setf (fdefinition 'searching-files-dialog) *old-searching-files-dialog*)
  (setf (fdefinition 'searching-files-dialog-with-iterator) *old-searching-files-dialog-with-iterator*))
|#

#|
(CCL::SEARCHING-FILES-DIALOG-WITH-ITERATOR "foo" "ccl:**;*.lisp" T T)
and
(CCL::SEARCHING-FILES-DIALOG "foo" (lambda ()(directory "ccl:**;*.lisp")) T T)
No BM, no databrowser, no iterator: 30 seconds
Above with BM: 20 seconds
Add iterator: 20 seconds
Add databrowser: 5 seconds [I think adding an item to the databrowser is a lot faster than set-table-sequence]

(time (CCL::SEARCHING-FILES-DIALOG-WITH-ITERATOR "foo234" "ccl:**;*.lisp" T T)) ; without browser, with BM
7.7 seconds
(time (CCL::SEARCHING-FILES-DIALOG-WITH-ITERATOR "foo234" "ccl:**;*.lisp" T T)) ; with browser, with BM
2.7 seconds

So even when the browser is not doing any work (because nothing is found), it's faster. Curious.
|#