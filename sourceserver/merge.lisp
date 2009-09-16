

;;	Change History (most recent first):
;; cancel button says thats what it is
;; ------ 5.1b2
;; akh minor tweak to the compare/merge menu-item
;; --- 5.0b3
;;  6 1/22/97  akh  add variable *merge-modro-only* (initially T) so only modro files are merge candidates.
;;  5 10/23/95 akh  dont save window-positions on close
;;  4 10/23/95 bill Remote download support
;;  2 10/13/95 bill ccl3.0x25
;;  2 5/7/95   slh  balloon help mods.
;;  7 1/30/95  akh  probably none
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Merge.lisp
;;;    Origins unknown
;;;
;;; 10/19/95 bill  make-sized-fred-window now makes the window if
;;;                dont-whine is true.
;;; 10/12/95 bill  use compare-buffers instead of get-file-difs
;;; 12/22/94 remove vs delete in finished-merging-file
;;;  10/18/91 better directory merge, file merge, and merge central default positions
;;;  Modified 5-23-91 by Vrhel.T to include merge-stream-and-file, buffer-streams, etc.
;;;      This file provides the compare/merge menu item in the CCL Tools menu
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :ccl)

(defparameter *merge-window-1-position* #@(5 50))
(defparameter *merge-window-2-position* (make-point (truncate (- *screen-width* 10) 2) 50))
(defparameter *merge-window-1-size* (make-point (truncate (- *screen-width* 10) 2)
                                                (truncate (- *screen-height* 180) 2)))
(defparameter *merge-window-2-size* *merge-window-1-size*)
(defparameter *merge-central-position* (list :top (- *screen-height* 128)))
(defparameter *merge-directory-window-position* *window-default-position*)
(defparameter *merge-prefs-loaded* nil)

(defclass merge-central (dialog)
  ((window1 :accessor window1 :initarg :window1)
   (window2 :accessor window2 :initarg :window2)
   ;(transient-window :accessor transient-window :initarg :transient-window)
   (difs :accessor difs :initarg :difs)
   (remaining-difs :accessor remaining-difs :initarg :remaining-difs)
   (current-dif :accessor current-dif :initform ())
   (finish-action :reader finish-action :initarg :finish-action
                  :initform #'(lambda ())))
  (:default-initargs
    :view-size #@(359 127)
    :window-type :document
    :view-position *merge-central-position*
    :window-title "Merge Central"
    :modifiable1 t
    :transient-window nil))

(defmethod initialize-instance ((dialog merge-central) &key modifiable1 &allow-other-keys)
  (call-next-method)
  (let ((button-size #@(158 16)))
    (add-subviews
     dialog
     (make-dialog-item 'button-dialog-item
                       #@(10 14) button-size "Next Difference"
                       'goto-next-merge-difference
                       :view-nick-name 'next-button)
     (make-dialog-item 'button-dialog-item
                       #@(10 40) button-size "Previous Difference"
                       'goto-previous-merge-difference
                       :view-nick-name 'previous-button)
     (make-dialog-item 'button-dialog-item
                       #@(10 66) button-size "Done - Close"
                       'announce-merge-completion
                       :view-nick-name 'complete-button)
     (make-dialog-item 'button-dialog-item
                       #@(190 92) button-size "Cancel"
                       'cancel-merge
                       :cancel-button t
                       :view-nick-name 'cancel-button)
     (make-dialog-item 'button-dialog-item
                       #@(190 14) button-size ">> Replace >>"
                       'copy-to-right
                       :dialog-item-enabled-p modifiable1
                       :view-nick-name 'source-1-button)
     (make-dialog-item 'button-dialog-item
                       #@(190 40) button-size "Forget Difference"
                       'forget-difference
                       :view-nick-name 'source-2-button)
     (make-dialog-item 'button-dialog-item
                       #@(190 66) button-size ">> Use Both Versions >>"
                       'use-both-versions
                       :dialog-item-enabled-p modifiable1
                       :view-nick-name 'both-button)
     (make-dialog-item 'button-dialog-item
                       #@(10 92) button-size "Done - Keep Open"
                       'announce-merge-completion-open
                       :view-nick-name 'complete-open-button))))

(defmethod announce-merge-completion ((item button-dialog-item))
  (announce-merge-completion (view-window item)))

(defmethod announce-merge-completion-open ((item button-dialog-item))
  (announce-merge-completion-open (view-window item)))

(defmethod announce-merge-completion ((controller merge-central))
    (let* ((finish-action (finish-action controller)))
        (when finish-action
             (funcall finish-action)))
    (update-merge-preference-file controller)
    (let ((*save-fred-window-positions* nil))
      (window-close (window1 controller))
      (window-close (window2 controller)))
    (window-close controller))

(defmethod announce-merge-completion-open ((controller merge-central))
    (let* ((finish-action (finish-action controller)))
        (when finish-action
             (funcall finish-action)))
    (update-merge-preference-file controller)
    (window-close controller))

(defmethod cancel-merge ((item button-dialog-item))
  (cancel-merge (view-window item)))

(defmethod cancel-merge ((controller merge-central))
  (window-close (window2 controller))
  (window-close controller)
  (cancel))

(defmethod pop-dif ((window merge-central))
  (when (null (remaining-difs window))
    (setf (remaining-difs window) (difs window)))
  (setf (current-dif window) (pop (remaining-difs window))))

(defmethod goto-next-merge-difference ((item button-dialog-item))
  (goto-next-merge-difference (view-window item)))

(defmethod goto-next-merge-difference ((controller merge-central))
  (let* ((window1 (window1 controller))
         (window2 (window2 controller))
         (dif (pop-dif controller)))
    (if dif
      (scroll-windows-to-dif window1 window2 dif)
      (progn
        (dialog-item-disable (view-named 'next-button controller))
        (dialog-item-disable (view-named 'previous-button controller))))))

(defmethod goto-previous-merge-difference ((item button-dialog-item))
  (goto-previous-merge-difference (view-window item)))

(defmethod goto-previous-merge-difference ((controller merge-central))
  (let* ((window1 (window1 controller))
         (window2 (window2 controller))
         (dif (unpop-dif controller)))
    (when dif
      (scroll-windows-to-dif window1 window2 dif))))

(defmethod unpop-dif ((window merge-central))
  (let* ((all-difs (difs window))
         (current-pos (position (current-dif window) all-difs)))
    (setf (remaining-difs window)
          (nthcdr (1- (if (zerop current-pos)
                        (length all-difs)
                        current-pos))
                  all-difs))
    (pop-dif window)))

(defmethod forget-difference ((item button-dialog-item))  ;; use old version
  (let* ((controller (view-window item)) )
    (remove-current-dif controller)))

(defmethod copy-to-right ((item button-dialog-item))  ;; use old version
  (let* ((controller (view-window item)) )
      (clear (window2 controller))
    (copy (window1 controller))
    (multiple-value-bind (start end) (selection-range (window1 controller))
        (if (not (eql start end))
    (paste (window2 controller)))) 
    (remove-current-dif controller)))

(defmethod use-source-2 ((item button-dialog-item))  ;; use old version
  (let* ((controller (view-window item)) )
      (clear (window1 controller))
    (copy (window2 controller))
    (multiple-value-bind (start end) (selection-range (window2 controller))
        (if (not (eql start end))
    (paste (window1 controller)))) 
    (remove-current-dif controller)))(defmethod use-source-1 ((item button-dialog-item)) ;; use new version
  (remove-current-dif (view-window item)))

(defmethod use-both-versions ((item button-dialog-item))
  (let* ((controller (view-window item))
         (window2 (window2 controller))
         (buffer (fred-buffer window2)))
    (multiple-value-bind (start end) (selection-range window2)
      (let* ((start-mark (make-mark buffer start))
             (end-mark (make-mark buffer end)))
        (collapse-selection window2 t)
        (buffer-insert buffer ";;<start of retained text>
" start-mark)
        (buffer-insert buffer ";;<start of added text>
" end-mark)
        (set-mark buffer end-mark)
        (copy (window1 controller))
        (paste window2)
        (buffer-insert buffer ";;<end of added text>
")
))
    (remove-current-dif controller)))

(defun scroll-windows-to-dif (window1 window2 difs)
  (let ((front-window (front-window)))
    (flet ((scroll-1 (window dif)
             (when (> (window-layer window) 2)
               (set-window-layer window 1))
             (let* ((buffer (fred-buffer window))
                    (start (car dif)))
               (set-selection-range window
                                    start
                                    (+ (buffer-position buffer start) (cdr dif)))
               (ccl::window-show-selection window))))
      (scroll-1 window1 (car difs))
      (scroll-1 window2 (cdr difs)))
    (window-select front-window)))

;;; test this - foo

(defmethod remove-current-dif ((win merge-central))
  (setf (difs win) (delete (current-dif win) (difs win)))
  (if (difs win)
    (goto-next-merge-difference win)
    (all-difs-merged win)))

(defmethod all-difs-merged ((win merge-central))
  (dialog-item-disable (view-named 'next-button win))
  (dialog-item-disable (view-named 'previous-button win))
  (dialog-item-disable (view-named 'source-1-button win))
  (dialog-item-disable (view-named 'source-2-button win))
  (dialog-item-disable (view-named 'both-button win))
  ;unfortunately, can't set the default button in a windoid
  ;because windoids don't get keystrokes
  ;(set-default-button win (view-named 'complete-button win))
  (collapse-selection (window1 win) t)
  (fred-update (window1 win))
  (collapse-selection (window2 win) t)
  (fred-update (window2 win)))


(defun merge-files (file1 file2 &optional difs? finish-action no-whine)
  (when (not *merge-prefs-loaded*)
    (load-merge-preferences)
    (setq *merge-prefs-loaded* t))
  (let* ((win1 (make-sized-fred-window file1
                                       *merge-window-1-position*
                                       *merge-window-1-size*
                                       no-whine))
         (buf1 (fred-buffer win1))
         (win2 (make-sized-fred-window file2
                                       *merge-window-2-position*
                                       *merge-window-2-size*
                                       no-whine))
         (buf2 (fred-buffer win2))
         (difs (compare-buffers buf1 buf2))
         (modifiable (and difs
                          (let* ((path (pathname file2))
                                 (project (pathname-project-p path))
                                 (state (and project (project-file-local-state project path))))
                            (or (neq state :checked-in)
                                (file-checkout-or-modro path))))))
    (when difs?
      (generate-difs-window win1 win2 difs (and (typep difs? 'window) difs?)))
    (do ((difs difs (cdr difs))) ((null difs))
      (let ((dif (car difs)))
        (let ((cell1 (car dif)) (cell2 (cdr dif)))
          (decf (cdr cell1) (car cell1)) ;end position -> length
          (setf (car cell1) (make-mark buf1 (car cell1))) ;start position -> mark
          (decf (cdr cell2) (car cell2)) ;end position -> length
          (setf (car cell2) (make-mark buf2 (car cell2)))))) ;start position -> mark
    (goto-next-merge-difference
     (make-instance 'merge-central
       :window-title (mac-namestring (pathname-name file1))
       :window1 win1
       :window2 win2
       :difs difs
       :remaining-difs difs
       :finish-action finish-action
       :modifiable1 modifiable))))

(defun generate-difs-window (win1 win2 difs &optional window)
  (let ((path1 (window-filename win1))
        (path2 (window-filename win2)))
    (when (null window)
      (let* ((name1 (and path1 (file-namestring path1)))
             (name2 (and path2 (file-namestring path2))))
        (setq window
              (make-instance *default-editor-class*
                :window-title (cond ((or (null name1) (null name2))
                                     "Differences")
                                    ((string-equal name1 name2)
                                     (format nil "~a difs" name1))
                                    (t (format nil "~a & ~a difs" name1 name2)))
                :scratch-p t))))
    (format window "~&~%;;; *** File 1: ~s~%;;; *** File 2: ~s~%"
            (or path1 (window-title win1))
            (or path2 (window-title win2))))
  (if (and (null difs) (not *show-matched-text*))
    (format window "~%;;;Files match.~%")
    (flet ((cp (output-stream buf start end)
             (do ((pos start (1+ pos))) ((eql pos end))
               (write-char (buffer-char buf pos) output-stream))))
      (let* ((buf1 (fred-buffer win1)) (buf2 (fred-buffer win2)) (match1 0))
        (do () ((null difs))
          (let* ((dif (pop difs))
                 (cell1 (car dif))
                 (cell2 (cdr dif)))
            (when *show-matched-text*
              (cp window buf1 match1 (car cell1)))
            (format window ";;; *** Start of text from File 1 ***~%")
            (cp window buf1 (car cell1) (cdr cell1))
            (format window "~&;;; *** Start of text from File 2 ***~%")
            (cp window buf2 (car cell2) (cdr cell2))
            (format window "~&;;; *** End of difference ***~%")
            (setq match1 (cdr cell1))))
        (when *show-matched-text*
          (cp window buf1 match1 (buffer-size buf1))))))
  (force-output window))

#+test
(merge-files (choose-file-dialog) (choose-file-dialog))

(defun make-sized-fred-window (file position size &optional dont-whine)
  (let ((w (ccl::pathname-to-window  file)))
     (unless (and w 
                  (not dont-whine)
                  (standard-alert-dialog 
                   (format nil "Select old window to ~s or open a new window?"
                           (mac-file-namestring file))
                   :yes-text "Old"
                   :no-text "New"
                   :position :main-screen))
      (setq w (make-instance 'fred-window  :filename file  :window-show nil)))
    (set-view-position w position)
    (set-view-size w size)
    (window-select w)
    w))


;;;;;;;;;;;;;;;
;;
;; stuff for the preferences folder
;;

(defparameter *merge-preferences-filename* "merge-files prefs")

(eval-when (eval compile)
  (require 'sysequ))


#+test
(find-preferences-folder)

(defun update-merge-preference-file (controller)
  (let* ((pathname (merge-pathnames
                    (find-preferences-folder) *merge-preferences-filename*)))
    (with-open-file (file pathname :direction :output
                                   :if-exists :supersede
                                   :if-does-not-exist :create)
      (let ((window1 (window1 controller))
            (window2 (window2 controller)))
        (format file
                "(setq *merge-window-1-position* ~s
      *merge-window-2-position* ~s
      *merge-window-1-size* ~s
      *merge-window-2-size* ~s
      *merge-central-position* ~s
      *merge-directory-window-position* ~s)"
                (setq *merge-window-1-position* (view-position window1))
                (setq *merge-window-2-position* (view-position window2))
                (setq *merge-window-1-size* (view-size window1))
                (setq *merge-window-2-size* (view-size window2))
                (setq *merge-central-position* (view-position controller))
                (let ((win (front-window :class 'merge-directory-dialog)))
                  (if win
                    (view-position win)
                    *merge-central-position*)))))))

(defun load-merge-preferences ()
  (let* ((pathname (merge-pathnames
                    (find-preferences-folder) *merge-preferences-filename*)))
    (when (probe-file pathname)
      (load pathname))))

; no no
;(load-merge-preferences)


#+sample-code
(merge-files (choose-file-dialog :directory "lamont:old-level-1:l1-boot.lisp")
             (choose-file-dialog :directory "lamont:new-level-1:l1-boot.lisp"))
#+sample-code
(merge-files "lamont:old-level-1:l1-boot.lisp"
             "lamont:new-level-1:l1-boot.lisp")

(defclass merge-directory-dialog (dialog)
  ((merge-dir :accessor merge-dir :initarg :merge-dir)
   (main-dir :accessor main-dir :initarg :main-dir))
  (:default-initargs
    :window-type :document-with-grow
    :window-title "Files To Merge"
    :view-position *merge-directory-window-position*
    :view-size #@(509 262)
    :view-subviews (list
                    (make-dialog-item 'static-text-dialog-item
                      #@(20 6) #@(67 16) "Main Dir:" nil)
                    (make-dialog-item 'static-text-dialog-item
                      #@(10 34) #@(77 16) "Merge Dir:" nil)
                    (make-dialog-item 'editable-text-dialog-item
                      #@(90 6) #@(321 17) "" nil
                      :view-nick-name 'main-dir-text)
                    (make-dialog-item 'editable-text-dialog-item
                      #@(90 34) #@(321 17) "" nil
                      :view-nick-name 'merge-dir-text)
                    (make-dialog-item 'check-box-dialog-item
                      #@(229 72) #@(168 16) "Generate Difs Window" nil
                      :view-nick-name 'difs-window?)
                    (make-dialog-item 'button-dialog-item
                      #@(16 72) #@(90 16) "List Files"
                      'generate-file-list
                      :default-button t)
                    (make-dialog-item 'button-dialog-item
                      #@(125 72) #@(90 16) "Merge File"
                      'merge-selected-files
                      :view-nick-name 'merge-button
                      :dialog-item-enabled-p nil)
                    (make-dialog-item 'sequence-dialog-item
                      #@(0 98) #@(509 150) ""
                      #'(lambda (item)
                          (when (double-click-p)
                            (merge-selected-files item)))
                      :table-hscrollp nil
                      :table-vscrollp t
                      :table-sequence ()
                      :view-font *fred-default-font-spec*
                      :view-nick-name 'the-table))))

(defmethod initialize-instance ((w merge-directory-dialog) &rest rest)
  (declare (ignore rest))
  (call-next-method)
  (set-dialog-item-text (view-named 'merge-dir-text w)
                        (namestring (merge-dir w)))
  (set-dialog-item-text (view-named 'main-dir-text w)
                        (namestring (main-dir w))))

(defmethod generate-difs? ((w merge-directory-dialog))
  (check-box-checked-p (view-named 'difs-window? w)))

(defmethod set-view-size ((w merge-directory-dialog) h &optional v)
  (call-next-method)
  (let* ((size (make-point h v)))
    (set-view-size (view-named 'the-table w)
                   (subtract-points size #@(0 106)))))

(defmethod merge-selected-files ((d dialog-item))
  (merge-selected-files (view-window d)))

(defmethod merge-selected-files ((w merge-directory-dialog))
  (let* ((table (view-named 'the-table w))
         (cell (ccl::first-selected-cell table))
         (difs? (generate-difs? w)))
    (if cell
      (let* ((short-file (cell-contents table cell))
             (merge-dir (pathname (merge-dir w)))
             (main-dir (pathname (main-dir w)))
             (from-file (merge-pathnames short-file merge-dir))
             (to-file (merge-pathnames short-file main-dir)))
        (when (pathname-directory short-file)  ; short-file is always physical
          (let ((log-main (logical-pathname-p main-dir))
                (log-merge (logical-pathname-p merge-dir)))
            (if log-main (setq to-file (merge-pathnames short-file (full-pathname main-dir))))
            (if log-merge (setq from-file (merge-pathnames short-file (full-pathname merge-dir))))))
        (eval-enqueue `(merge-files ,from-file ,to-file
                                    ,difs?
                                    ,#'(lambda ()
                                        (finished-merging-file w short-file)))))
      (ed-beep))))

(defmethod finished-merging-file ((w merge-directory-dialog) file)
    (let* ((the-table (view-named 'the-table w)))
        (set-table-sequence the-table (remove file (table-sequence the-table)))))

(defmethod generate-file-list ((item button-dialog-item))
  (generate-file-list (view-window item)))

(defvar *merge-modro-only* t)

(defmethod generate-file-list ((w merge-directory-dialog))
  (with-cursor *watch-cursor*
    (let* ((merge-dir (dialog-item-text (view-named 'merge-dir-text w)))
           (dir-len (length (pathname-directory (full-pathname merge-dir))))
           (file-list (mapcan #'(lambda (pathname)
                                  (when (and (eq (mac-file-type pathname) :text)
                                             (or (null *merge-modro-only*)
                                                 (file-is-modifiable-p pathname)))
                                    (list
                                     (namestring
                                      (make-pathname 
                                       :host nil
                                       :directory (cons :relative 
                                                        (nthcdr dir-len (pathname-directory pathname)))                                                  
                                       :name (pathname-name pathname)
                                       :type (pathname-type pathname)
                                       :defaults nil)))))
                              (directory                               
                               (merge-pathnames (if (physical-pathname-p merge-dir)
                                                  ":**:*.*"
                                                  ";**;*.*")
                                                merge-dir))))
           (merge-button (view-named 'merge-button w)))
      (setf (merge-dir w) merge-dir
            (main-dir w) (dialog-item-text (view-named 'main-dir-text w)))
      (set-table-sequence (view-named 'the-table w) file-list)
      (dialog-item-enable merge-button)
      (set-default-button w merge-button))))

(defun merge-directories (merge-dir main-dir)
  (make-instance 'merge-directory-dialog
    :merge-dir merge-dir
    :main-dir main-dir))

#+test
(merge-directories "ccl:leibniz 1.0d36 update;" "ccl:leibniz;")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Now let's make it usable
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Buffer streams are not a published feature of MacL - in fact, the manual
;;;  says that they are output-only. Not true.
;;;
;;; The following function makes a buffer-stream (see file cl-streams in 
;;;  level-1) and returns it. This stream supports all the normal stream
;;;  operations, and is an IO stream.
;;;

(defun make-buffer-stream (window)
  (let* ((current-buffer (fred-buffer window))
         (entire-buffer (set-mark current-buffer 0))
         (buffer-stream (make-instance 'buffer-stream 
                                       :buffer entire-buffer)))
  buffer-stream))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; The following body of code provides the merge functionality. At a high level, it takes
;;;   a stream and a file, and allows the user to merge the outputs. Most of the changes from 
;;;   the functions in merge-files.lisp deal with using a buffer stream and a file, and being
;;;   a little smarter about how the windows are laid out....
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; The following function does some smart window layouts, based upon the screen size of the
;;;   current monitor.
;;;
        
;;; Now this will take some explaining -
;;;
;;;   Layout-windows takes two arguments, the first a point giving the area to be used, the second
;;;     a nested list of either view-sizes or T. T is used as a placeholder to indicate that
;;;     the size for the corresponding view is to be calculated by the routine.
;;;
;;;  The nesting of the list in the argument is important, as follows:
;;;    Top-level items indicate vertical bands across the screen. Sub-lists indicate that there 
;;;     are multiple panes in the horizontal direction. At the current time, sub-sublists are not
;;;     supported (kiss). Therefore, a structure like '((T T) #@(359 95)) would indicate that
;;;     there are two be two windows, side by side, above a single window of size 359 x 95. 
;;;
;;;  The function returns a list of the same structure, where each item is a pair of points. 
;;;    The car of the pair is the position, the  cdr the size. Thus, for a two page display with
;;;     the arguments:
;;;
;;;     the return value will be:
;;;

(defun layout-windows (layout-size layout-list &optional (start-point (make-point 0 40)))
  (let* ((gap-size 2)
         (screen-height ( - (point-v layout-size) (point-v start-point)))
         (screen-width (- (point-h layout-size) (point-h start-point)))
         (height-list (mapcar #'(lambda (sublist-or-pt)
                                  (cond ((listp sublist-or-pt)
                                         (or (get-max-height-of-list sublist-or-pt)
                                             T))
                                        ((typep sublist-or-pt 'fixnum)
                                         (point-v sublist-or-pt))
                                        (T 0)))
                              layout-list))
         (committed-height (+ (reduce #'+ (remove-if #'symbolp height-list))
                              (* gap-size (length height-list))))
         (final-height-list (substitute (ceiling (/ (ceiling (- screen-height committed-height))
                                                    (max (count 0 height-list) 1)))
                                        0 height-list))
         (width-list (mapcar #'(lambda  (sublist-or-pt)
                                 (cond ((listp sublist-or-pt)
                                        (mapcar #'(lambda (item)
                                                    (cond ((typep item 'fixnum)
                                                           (point-h item))
                                                          (T T)))
                                                sublist-or-pt))
                                       ((typep sublist-or-pt 'fixnum)
                                        (point-h sublist-or-pt))
                                       (T T)))
                             layout-list))
         (committed-width-list
          (mapcar #'(lambda  (sublist-or-wd)
                      (cond ((listp sublist-or-wd)
                             (get-total-width-of-list sublist-or-wd))
                            ((typep sublist-or-wd 'fixnum)
                             (point-h sublist-or-wd))
                            (T 0)))
                  width-list))
         size-list)
    (setf size-list
          (mapcar 
           #'(lambda (widths height committed-width)
               (cond ((listp widths)
                      (mapcar #'(lambda (wd) (make-point wd height))
                              (substitute (truncate (/ (truncate 
                                                        (- screen-width 
                                                           (+ committed-width
                                                              (* gap-size (length widths)))))
                                                       (max (count T widths) 1)))
                                          T widths)))
                     ((typep widths 'fixnum)
                      (make-point widths height))
                     (T (make-point (- screen-width 2) height))))
           width-list
           final-height-list
           committed-width-list))
    (let ((cur-ht-pos (+ (point-v start-point) gap-size))
          (cur-wd-pos (+ (point-h start-point) gap-size)))
      (mapcar #'(lambda (list-or-pt)
                  (setf cur-wd-pos gap-size)
                  (prog1 
                    (cond ((listp list-or-pt)
                           (prog1 (mapcar 
                                   #'(lambda (size-pt)
                                       (prog1 (cons (make-point cur-wd-pos cur-ht-pos)
                                                    size-pt)
                                         (incf cur-wd-pos (+ (point-h size-pt) gap-size))))
                                   list-or-pt)
                             (incf cur-ht-pos (+ (point-v (car list-or-pt)) gap-size))))
                          (T (prog1 (cons (make-point 
                                           (+ cur-wd-pos 
                                              (truncate (/ (- screen-width (point-h list-or-pt))
                                                           2)))
                                           cur-ht-pos)
                                          list-or-pt)
                               (incf cur-ht-pos (+ (point-v list-or-pt) gap-size)))))))
              size-list))))


;;; These are support functions for layout-windows
;;;


(defun get-max-height-of-list (list-of-Ts-or-hts)
    (let* ((clean-list (remove-if-not #'numberp list-of-Ts-or-hts)))
        (cond ((< (length clean-list) 2)
                    (or (car clean-list) 0))
                  (T (reduce #'max clean-list)))))

(defun get-total-width-of-list (list-of-Ts-or-wds)
    (let* ((clean-list (remove-if-not #'numberp list-of-Ts-or-wds)))
        (cond ((< (length clean-list) 2)
                    (or (car clean-list) 0))
                  (T (reduce #'+ clean-list)))))


;;; Now we need a little describer fxn for testing the layout code
;;;
(defun d-pts (x)
    (cond ((null x)
                nil)
              ((numberp x)
                (point-string x))
              (T (cons (d-pts (car x))(d-pts (cdr x))))))

;;;  Make-sized-fred-window assumes that each window corresponds to a file - here, we must
;;;   make a new version which checks for streams
;;;

(defun make-sized-fred-file-or-stream-window (file-or-stream position size &optional window)
    (let* ((w (cond ((typep file-or-stream 'buffer-stream)
                                  ;;(set-window-title window (concatenate 'string "New-> "
                                   ;;                                                                 (window-title window)))
                                  window)
                                (T (ccl::pathname-to-window file-or-stream)))))
        (cond ((typep file-or-stream 'buffer-stream))
                  (T (unless  window 
                           (setq w (make-instance 'fred-window :filename  file-or-stream :window-show nil))
                           ;;(set-window-title w (concatenate 'string "Old -> " (window-title w)))
                           )))
        (set-view-position w position)
        (set-view-size w size)
        (window-select w)
        w))

;;; The following function takes a stream and a file, and otherwise provides essentially the 
;;;   same functionality as merge-files in merge-files.lisp
;;;

#| ; not converted
(defun merge-stream-and-file (stream file difs? finish-action
                                     &key (compare-only-p nil) 
                                     (projector-revision-p nil))
  (let* ((front-window (front-window :class 'fred-window)))
    (multiple-value-bind (difs1 difs2)
                         (get-stream-and-file-difs stream file difs? front-window)
      (if difs1
        (let* ((small-screen-p (< *screen-width* 500))  ;; too arbitrary, should be user-config'd
               (control-panel-size (make-point 359 127))
               (layout-list (layout-windows 
                             (make-point *screen-width* *screen-height*)
                             (cond (small-screen-p
                                    `(T T ,control-panel-size))   ; stacked vertical layout
                                   (T `((T T) ,control-panel-size))))) ;; side-by-side for files
               (win1-data (cond (small-screen-p (car layout-list))
                                (T (caar layout-list))))
               (win2-data (cond (small-screen-p (cadr layout-list))
                                (T (cadar layout-list))))
               (win1 (make-sized-fred-file-or-stream-window stream
                                                            (car win1-data)
                                                            (cdr win1-data)
                                                            front-window))
               (win2 (make-sized-fred-file-or-stream-window file
                                                            (car win2-data)
                                                            (cdr win2-data))))
          ;;(print "difs1, 2") (print difs1) (print difs2)
          (labels ((markify (buffer dif-list last-mark last-line-count)
                     (let* ((cell (car dif-list))
                            (line-count (car cell))
                            (the-rest (cdr dif-list))
                            (mark (make-mark buffer
                                             (buffer-line-start 
                                              buffer
                                              last-mark
                                              (- line-count last-line-count)))))
                       ;;(format T "buffer dif last-mark last-line = ~A ~A ~A ~A~%"
                       ;;              buffer dif-list last-mark last-line-count)
                       ;;(format T "cell line-count the-rest mark = ~A ~A ~A ~A~%"
                       ;;             cell line-count the-rest mark )
                       (setf (car cell) mark)
                       (when the-rest
                         (markify buffer the-rest mark line-count)))))
            (when difs1
              (markify (fred-buffer win1) difs1 0 0)
              (markify (fred-buffer win2) difs2 0 0))
            (cond (compare-only-p
                   (goto-next-compare-difference
                    (make-instance (cond (compare-only-p 'compare-central)
                                         (projector-revision-p 'projector-merge-central)
                                         (T 'merge-central))
                      :window-title (slot-value front-window 'object-name)
                      :window1 win1
                      :window2 win2
                      :view-position (caar (last layout-list))
                      :difs1 difs1
                      :difs2 difs2
                      :remaining-difs1 difs1
                      :remaining-difs2 difs2
                      :finish-action finish-action)))
                  (T (goto-next-merge-difference
                      (make-instance (cond (compare-only-p 'compare-central)
                                           (projector-revision-p 'projector-merge-central)
                                           (T 'merge-central))
                        :window-title (slot-value front-window 'object-name)
                        :window1 win1
                        :window2 win2
                        :difs1 difs1
                        :difs2 difs2
                        :remaining-difs1 difs1
                        :remaining-difs2 difs2
                        :finish-action finish-action))))))
        (progn (message-dialog "The files match." :title "Notice")
               (when finish-action
                 (funcall finish-action))
               )))))
|#

;;; The next function takes a stream and a file (suitable for with-open-file)
;;;   and performs a compare upon them. Note two optional arguments -
;;;   if the difs-window is not specified, the returned values are two lists. The
;;;   input-window parameter is used to derive the name for purposes of output.
;;;
;;;  This function is a modified version of the function get-file-difs from compare.lisp
;;;
                           
(defun get-stream-and-file-difs (stream file &optional difs-window? input-window)
  (let ((buffer-stream (if difs-window? 
                         (make-buffer-stream difs-window?))))
    (with-open-file (s2 file)
      (let ((output (make-instance 'difference-output-stream
                      :window difs-window?)))
        (format t "~&Finding Differences")
        (if buffer-stream (format buffer-stream "~&Finding Differences~%"))
        (print-legend output 
                      (if input-window 
                        (slot-value input-window 'object-name)
                        stream)
                      file)
        (if (eql (with-cursor *watch-cursor*
                   (compare stream s2 output)) 0) ; this is how the routine says no diffs!
          (and buffer-stream 
               (progn (format buffer-stream "~%No differences! ~%")
                      T)
               (window-close difs-window?)))
        (values (nreverse (first-file-difs output))
                (nreverse (second-file-difs output)))))))

;;; (compare-active-window-and-file) ;;;test code
;;; this used to do merge-stream-and-file - which either doesnt work or is steenking slow
;;; assume front fred-window has a filename

(defun merge-active-lisp-window-and-file ()
  (let* ((front-window (front-window :class 'fred-window))
         (file1 (window-filename front-window))
         (file2 (choose-file-dialog :button-string "Merge" :mac-file-type :text)))
    (merge-files file1 file2 nil nil t)))

#| ; well its not actually that much slower today??
(defun merge-active-lisp-window-and-file ()
  (let* ((front-window (front-window :class 'fred-window))
         (buffer-stream (make-buffer-stream front-window))
         (file (choose-file-dialog :button-string "Merge" :mac-file-type :text))
         )
    (merge-stream-and-file buffer-stream file nil nil)))
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  Now let's put the good stuff in a menu - for lispers, the Tools menu
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Now here's a hack - to get the items where we want them (under Search Files), we
;;;   have to remove the last 8 items and then stick them in again
;;;



(defun dissect-and-repair-menu (menu-name item-to-insert-after &rest new-items)
  (let* ((the-menu (find-menu menu-name))
         (menu-items (menu-items the-menu))
         (temp-store
          (do ((l menu-items (cdr l)))
              ((null l))
            (when (string-equal (menu-item-title (car l)) item-to-insert-after)
              (return l)))))
    (apply #'remove-menu-items the-menu temp-store)
    (apply #'add-menu-items the-menu new-items)
    (apply #'add-menu-items the-menu temp-store)))

#-:merge-pkg
(eval-when (:execute :load-toplevel)
  (dissect-and-repair-menu 
   "Tools" "Search FilesÉ"
   (MAKE-INSTANCE 'MENU-ITEM
     :MENU-ITEM-TITLE "Compare/Merge to FileÉ"
     :MENU-ITEM-ACTION #'(lambda ()(eval-enqueue '(Merge-ACTIVE-lisp-WINDOW-AND-FILE)))
     :help-spec 1421))
  (pushnew :merge-pkg *features*))


#|
	Change History (most recent last):
	2	6/4/91	tv 	cleanup for package change
				
	4	6/14/91	tv 	adding changes for projector menu additions, removing CKID resources when copying
	7	6/25/91	tv 	fixing for ralph files
	8	8/23/91 jaj    don't try to effect projector menus in announce-merge-completion fns
        9       8/29/91 alms compare/merge only shows text files
	3	10/18/91	jaj	test checkout, in
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	12/22/94	akh	none
	3	12/22/94	akh	comment out call to dissect.. something about menu-item-title doesnt work in 3.0
	4	12/23/94	akh	fix dissect-and-repair-menu - maybe we should lose this
	5	12/23/94	akh	in merge-files - dont modro unless there are diffs
	5	12/23/94	akh	in merge-files - dont modro if files are equal
	6	12/29/94	akh	huh
|# ;(do not edit past this line!!)
