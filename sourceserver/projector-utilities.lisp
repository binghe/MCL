
;;	Change History (most recent first):
;;  2 10/23/95 bill Remote download support
;;  9 3/22/95  akh  add-change - DONT mess with selection and scroll pos!
;;                   Fred preserves them for you correctly.
;;  8 1/25/95  akh  take the print out of add-change
;;  7 1/11/95  akh  put a blank line before comment header
;;  6 1/11/95  akh  get it right
;;  5 1/11/95  akh  dont put comments before the modeline please
;;  4 1/11/95  akh  comment uses ";;" and goes at front of file
;;  (do not edit before this line!!)
;;;; Projector-related utility functions.
;;;; These used to live in projector.lisp
;;;;
;; 10/23/95 bill  choose-and-merge-directories pops from & move-files-to-merge-directory
;;                pushes onto *last-root-dirs* & *last-merge-dirs*.
;;
;; 3/24/95 no more element-type 'character - use type of string input

(in-package :ccl)

;;;
;;; merging
;;;

(defvar *user-initials*)
(defvar *last-root-dir* "")
(defvar *last-merge-dir* "")
(defvar *last-root-dirs* nil)
(defvar *last-merge-dirs* nil)

(eval-when (:compile-toplevel :execute :load-toplevel)
  (defconstant *comment-prefix-length* 20))

(defun directory-path-with-suffix (pathname suffix)
  (let ((directory (pathname-directory (mac-namestring pathname))))
    (make-pathname :directory
                   (append (butlast directory)
                           (list
                            (concatenate 'string (first (last directory)) suffix))))))

(defun merge-dir-list (root &optional (partial-name " Merge"))
  (mapcar #'pathname (sort (mapcar #'mac-namestring
                                   (directory (directory-path-with-suffix
                                               root
                                               (concatenate 'string partial-name "*"))
                                              :directories t))
                           #'string>)))

(defun latest-merge-dir (root &optional (partial-name " Merge"))
  (first (merge-dir-list root partial-name)))

(defun new-merge-dir (root &optional (partial-name " Merge"))
  (let* ((latest (latest-merge-dir root partial-name))
         (new-dir
          (directory-path-with-suffix
           root
           (concatenate 'string partial-name
                        (princ-to-string
                         (if latest
                           (let ((leaf (first (last (pathname-directory latest)))))
                             (1+ (read-from-string leaf nil -1
                                                   :start (1+ (position-if-not #'digit-char-p leaf :from-end t)))))
                           0))))))
;    (create-directory new-dir)
    new-dir))

(defun find-corresponding-path (path source target)
  (let* ((path-dir (pathname-directory (mac-namestring path)))
         (source-dir (pathname-directory (mac-namestring source)))
         (target-dir (pathname-directory (mac-namestring target)))
         (path-length (length path-dir))
         (source-length (length source-dir)))
    (assert (and (>= path-length source-length)
                 ;; equalp because the directory names may have different case
                 (equalp (subseq path-dir 0 source-length) (subseq source-dir 0 source-length)))
            nil "~S is not in ~S" path source)
    (make-pathname :directory (append target-dir (subseq path-dir source-length)))))

(defun move-files-to-merge-directory (paths &optional (partial-name " Merge"))
  (setq paths (mapcar 'translate-logical-pathname paths))
  (let ((volume (and paths (second (pathname-directory (car paths))))))
    (dolist (path paths)
      (let ((dir (pathname-directory path)))
        (unless (and (eq :absolute (first dir))
                     (equalp volume (second dir)))
          (error "All pathnames must be absolute and on the same volume"))))
    (let* ((merge-dir (new-merge-dir (make-pathname :directory `(:absolute ,volume ,volume)
                                                    :defaults nil)
                                     partial-name))
           (root-dir (make-pathname :directory `(:absolute ,volume)
                                    :defaults nil)))
      (setq *last-merge-dirs* (nconc *last-merge-dirs* (list merge-dir))
            *last-root-dirs* (nconc *last-root-dirs* (list root-dir)))
      (labels ((path->merge-dir (path)
                 (let* ((local-dir (make-pathname :name nil :type nil :defaults path))
                        (merge-dir (find-corresponding-path local-dir root-dir merge-dir)))
                   (unless (probe-file merge-dir)
                     (create-file merge-dir))
                   merge-dir)))
        (dolist (path paths)
          (let ((new-path (merge-pathnames (path->merge-dir path) path)))
            (format t "Moving ~s~%    to ~s~&" path new-path)
            (rename-file path new-path)
            (remove-filename-from-projector-menu path))))
      (list (cons root-dir merge-dir)))))

;; Ought to let you choose from a list of merge directories.  Unfortunately,
;; we don't know which merge directory goes with which original.  We could write
;; a file into each merge directory that had the name of the original.  Also, we
;; could assume the toplevel project, in the case where there's only one.
(defun choose-and-merge-directories ()
  (declare (special *last-root-dir* *last-merge-dir*))
  (flet ((get-next-dirs ()
           (setq *last-root-dir* (or (pop *last-root-dirs*) "")
                 *last-merge-dir* (or (pop *last-merge-dirs*) ""))))
    (when (and (equal "" *last-root-dir*)
               (equal "" *last-merge-dir*))
      (get-next-dirs))
    (prog1
      (make-instance 'merge-directory-dialog
        :main-dir *last-root-dir*
        :merge-dir *last-merge-dir*)
      (get-next-dirs))))

;;;
;;; Comment logging
;;;
#|

(let* ((header-key "Change History (most recent last):")
       (pre-header (format nil "~%#|~%~a" #\tab))
       (post-header (format nil "~%|# ;(do not edit past this line!!)~%"))
       (header (concatenate 'string pre-header header-key post-header))
       (last-comment-indicator (format nil "~%~2~~a" #\tab)))

(defun add-change (window version comment check-in-p)
  (unless (boundp 'ccl::*user-initials*) (error "~s is not set" 'ccl::*user-initials*))
  (let* ((buf (fred-buffer window))
         (buf-size (buffer-size buf))
         (header-pos (buffer-string-pos buf header-key :end t :from-end t))    ; search for Change log from the end of the file
         ;(scroll-pos (buffer-position (fred-display-start-mark window)))
         )
    (progn ;multiple-value-bind (selection-start selection-end) (selection-range window) ; remember selection
      (unless header-pos
        (setq header-pos buf-size)
        (buffer-insert buf header buf-size))
      (let* ((comment-end-pos (- (buffer-size buf) (length post-header) -1))
             (comment-start-pos (or (and check-in-p
                                         (buffer-string-pos buf last-comment-indicator 
                                                            :start header-pos 
                                                            :end comment-end-pos
                                                            :from-end t))
                                    comment-end-pos)))
        (buffer-delete buf comment-start-pos comment-end-pos)
        (set-mark buf comment-start-pos)
        (multiple-value-bind (dummy dummy dummy day month year) (get-decoded-time)
          (declare (ignore dummy))
          (if check-in-p
            (format window "~&  ")
            (format window "~&~~~~"))                    
          (format window "~d~6T~d/~d/~d~15T~a~VT~a~%" version
                  month day (mod year 100)  ccl::*user-initials* 
                  *comment-prefix-length* (comment-format comment))))
      ;(set-selection-range window selection-start selection-end)
      ;(set-mark (fred-display-start-mark window) scroll-pos)
      (window-save-file fred (window-filename fred) :overwrite)
      )))
#|
(defun find-comment-from-file (path)
  (let* ((w (make-instance *default-editor-class* :filename path :window-show nil))
         (comment (find-comment-from-window w)))
    (window-close w)
    comment))
|#

(defun find-comment-from-window (window)
  (let* ((buf (fred-buffer window))
         (header-pos (buffer-string-pos buf header-key :end t :from-end t)))    ; search for Change log from the end of the file
    (if header-pos
      (let* ((comment-end-pos (- (buffer-size buf) (length post-header) -1))
             (comment-start-pos (buffer-string-pos buf last-comment-indicator 
                                                   :start header-pos 
                                                   :end comment-end-pos
                                                   :from-end t)))
        (if comment-start-pos
          (unformat-comment (buffer-substring buf (1+ comment-start-pos) comment-end-pos))
          ""))
      "")))
)
|#

(let* ((header-key "Change History (most recent first):")
       (pre-header (format nil "~%~%;;~a" #\tab))
       (post-header (format nil "~%;;  (do not edit before this line!!)~%"))
       (header (concatenate 'string pre-header header-key post-header))
       (last-comment-indicator "~~~~"))
  
  (defun add-change (window version comment check-in-p)
    (unless (boundp 'ccl::*user-initials*) (error "~s is not set" 'ccl::*user-initials*))
    (let* ((buf (fred-buffer window))
           (start (or (nth-value 1 (buffer-modeline-range buf)) 0))
           (fred (window-key-handler window))
           (header-pos (buffer-string-pos buf header-key :start start))  ; search for Change log from the start
           ;(scroll-pos (buffer-position (fred-display-start-mark window)))
           )
      (when (neq start 0)(setq start (buffer-line-end buf start)))
      ;(print start)
      (progn ;multiple-value-bind (selection-start selection-end) (selection-range window) ; remember selection
        (unless header-pos
          (buffer-insert buf header start)
          (setq header-pos (buffer-string-pos buf header-key :start start)))
        (let* ((post-header-pos (buffer-string-pos buf post-header :start header-pos))
               (comment-start-pos (+ header-pos (length header-key))))
          (when check-in-p
            (when (< (+ comment-start-pos 4) post-header-pos)
              (let ((comment-end-pos (buffer-string-pos buf last-comment-indicator
                                                        :start comment-start-pos ;(+ comment-start-pos 4)
                                                        :end post-header-pos)))
                (when comment-end-pos
                  (buffer-delete buf comment-start-pos (+ comment-end-pos 
                                                          (length last-comment-indicator)))))))
          (set-mark buf comment-start-pos)
          (multiple-value-bind (dummy dummy dummy day month year) (get-decoded-time)
            (declare (ignore dummy))
            (if check-in-p
              (format fred "~&;;  ")
              (format fred "~&;;~~~~"))                    
            (format fred "~d~6T~d/~d/~d~15T~a~VT~a" version
                    month day (mod year 100)  ccl::*user-initials* 
                    *comment-prefix-length* (comment-format comment)))
          (when (not check-in-p)
            (buffer-insert buf last-comment-indicator)))
        ;(set-selection-range window selection-start selection-end)
        ;(set-mark (fred-display-start-mark window) scroll-pos)
        )))
  #|
(defun new-find-comment-from-file (path)
  (let* ((w (make-instance *default-editor-class* :filename path :window-show nil))
         (comment (find-comment-from-window w)))
    (window-close w)
    comment))
|#
 
  (defun find-comment-from-window (window)
    (let* ((buf (fred-buffer window))
           (header-pos (buffer-string-pos buf header-key :start 0)))    ; search for Change log from the end of the file
      (if header-pos
        (let* ((comment-start-pos (+ header-pos (length header-key)))
               (post-header-pos (buffer-string-pos buf post-header :start header-pos))
               (comment-end-pos (buffer-string-pos buf last-comment-indicator
                                                        :start comment-start-pos
                                                        :end post-header-pos)))
          (if comment-end-pos
            (unformat-comment (buffer-substring buf (1+ comment-start-pos) comment-end-pos))
            ""))
        "")))
  )

;old one doesnt work now cause no tabs - so remove 20 chars from each line
(defun unformat-comment (comment)
  (string-trim '(#\Tab #\Space #\Return)               
               (let* ((first-return (position #\return comment))
                      (len (length comment))
                      (pl *comment-prefix-length*))
                 (if first-return
                   (let ((new-string (make-array len 
                                                 :element-type (array-element-type comment)
                                                 :adjustable t 
                                                 :fill-pointer 0))
                         (start 0))
                     (loop
                       (string-push-extend new-string comment (+ start pl) (1+ first-return))
                       (setq start (1+ first-return))
                       (when (not (setq first-return (position #\return comment :start start)))
                         (when (< (+ start pl)(length comment))
                           (string-push-extend new-string comment (+ start pl) len))
                         (return new-string))))
                   (if (> len pl)
                     (subseq comment pl len)
                     comment)))))
#|
(defun unformat-comment (comment)
  (string-trim '(#\Tab #\Space #\Return)
               (let* ((first-return (position #\return comment))
                      (start-tab (when first-return (position #\tab comment :end first-return :from-end t))))
                 (if start-tab
                   (delete #\tab (subseq comment (1+ start-tab)))
                   comment))))
|#
                       

;;; this will add 4 tab's after each <return> so that the comment is formatted nicely.
;;; Will also remove double quotes from beginning and end (if they are there)
;;; Could add something to delete trailing <returns>
#|
(defun comment-format (comment)
  (let* ((c1 (if (and (> (length comment) 0)
                      (eql (elt comment  0) #\"))
               (subseq comment 1)
               comment))
         (len-c1 (1- (length c1)))
         (c2 (if (and (> len-c1 0)
                      (eql (elt c1 len-c1 ) #\"))
               (subseq c1 0 len-c1)
               c1)))
               
  (string-right-trim ccl::wsp&cr (replace-char-with-string c2 #\newline #.(concatenate 'string
                                                      (string #\newline)
                                                      (string #\tab)
                                                      (string #\tab)
                                                      (string #\tab)
                                                      (string #\tab))))))
|#

(defun comment-format (comment)
  (let* ((c1 (if (and (> (length comment) 0)
                      (eql (elt comment  0) #\"))
               (subseq comment 1)
               comment))
         (len-c1 (1- (length c1)))
         (c2 (if (and (> len-c1 0)
                      (eql (elt c1 len-c1 ) #\"))
               (subseq c1 0 len-c1)
               c1)))
               
  (string-right-trim ccl::wsp&cr 
                     (replace-char-with-string c2 #\newline #.(concatenate 'string
                                                                           (string #\newline)
                                                                           (format nil ";;~VT" *comment-prefix-length*))))))
; str1 is dest 
(defun string-push-extend (str1 str2 &optional (start 0) (end (length str2)))
  (unless (array-has-fill-pointer-p str1)
    (error "First arg must have a fill pointer."))
  (let ((len1 (length str1))
        (size1 (array-dimension str1 0))
        (len2 (- end start)))
    (when (> (+ len1 len2) size1)
      (adjust-array str1 (+ len1 len2)))
    (setf (fill-pointer str1) (+ len1 len2))
    (replace str1 str2 :start1 len1 :start2 start :end2 end)
    str1))

;;; Change the char FROM to the string TO in the string STR
(defun replace-char-with-string (str from to)
  (let ((newstr (make-array 20 :element-type (array-element-type str) :adjustable t :fill-pointer 0)))
    (map nil #'(lambda (char)
                 (if (eql char from)
                   (string-push-extend newstr to)
                   (vector-push-extend char newstr)))
         str)
    newstr))

(defun open-pathname-comment-log-window-p (path)
  ;; second value = t if the window already existed
  ;; also makes sure only one window is open onto this file
  (let ((window (pathname-window path)))
    (if window
      (progn
        (do-pathname-windows (other path)
          (unless (eq other window)
            (window-close other)))
        (values window t))
      (and (eq (mac-file-type path) :TEXT)

           ;; Always add comment to a file when checking in and out. Hai Wang 7/7/93
           ;(y-or-n-dialog (format nil "Add comment to file: ~S?" (namestring path)))

           (values (make-instance *default-editor-class* :filename path :window-show nil)
                   nil)))))

(defun inc-projector-version (version)
  (if (find-if-not #'digit-char-p version)
    (error "Can't handle branches yet.")
    (princ-to-string (1+ (read-from-string version)))))

;;;
;;; Version hacking
;;;

(defun parse-version (version &optional (errorp t))
  (let ((major-rev 0)
        (minor-rev 0)
        (dev-stage 'f)
        (bug-rev 0)
        (internal-rev 0)
        (substage nil)
        (substage-rev 0)
        (pos 0))
    (flet ((next-piece (end-test)
             (if pos
               (let ((end-pos (position-if end-test version :start pos)))
                 (let ((*package* (find-package :projector)))
                   (prog1
                     (read-from-string version t nil :start pos :end end-pos)
                     (setq pos end-pos))))))
           (bad-version (&rest args)
             (if errorp
               (apply #'error args)
               (return-from parse-version (values nil nil nil nil nil nil)))))
      (let ((temp (next-piece #'(lambda (x) (eq #\. x)))))
        (if (numberp temp) 
          (setq major-rev temp)
          (bad-version "No major revision number in version: ~s" version)))
      (if pos (incf pos))
      (let ((temp (next-piece #'(lambda (x) (not (digit-char-p x))))))
        (if (numberp temp)
          (setq minor-rev temp)
          (bad-version "No minor revision number in version: ~s" version)))
      (when (and pos (eq #\. (schar version pos)))
        ;;bug fix version
        (incf pos)
        (let ((temp (next-piece #'(lambda (x) (not (digit-char-p x))))))
          (if (numberp temp)
            (setq bug-rev temp)
            (bad-version "Invalid bug fix revision number in version: ~s" version))))
      (when pos
        (let ((temp (next-piece #'digit-char-p)))
          (if (memq temp '(f b a d))
            (setq dev-stage temp)
            (bad-version "Invalid development stage in version: ~s" version))))
      (when pos
        (let ((temp (next-piece #'(lambda (x) (not (digit-char-p x))))))
          (if (numberp temp)
            (setq internal-rev temp)
            (bad-version "Invalid internal revision number in version: ~s" version))))
      (when pos
        (setq substage (next-piece #'digit-char-p)))
      (when pos
        (let ((temp (next-piece #'(lambda (x) (not (digit-char-p x))))))
          (if (numberp temp)
            (setq substage-rev temp)
            (bad-version "Invalid substage revision number in version: ~s" version))))
      (when pos
        (bad-version "Invalid version: ~s" version)))
    (values major-rev minor-rev bug-rev dev-stage internal-rev substage substage-rev)))

#|
(parse-version "1.0d23")
(parse-version "2.0d23")
(parse-version "1.1d23")
(parse-version "1.0")
(parse-version "1.0a1")
(parse-version "1.0b4")
(parse-version "1.0.1")
(parse-version "1.1")
(parse-version "1.0.2f3")
(parse-version "71.2f3c2")
|#

(defun version-lessp (version1 version2)
  (multiple-value-bind (major-rev1 minor-rev1 bug-rev1 stage1 internal-rev1 sub-stage1 sub-stage-rev1)
                       (parse-version version1)
    (multiple-value-bind (major-rev2 minor-rev2 bug-rev2 stage2 internal-rev2 sub-stage2 sub-stage-rev2)
                         (parse-version version2)
      (or (< major-rev1 major-rev2)
          (and (= major-rev1 major-rev2)
               (or (< minor-rev1 minor-rev2)
                   (and (= minor-rev1 minor-rev2)
                        (or (< bug-rev1 bug-rev2)
                            (and (= bug-rev1 bug-rev2)
                                 (or (< (position stage1 '(d a b f))
                                        (position stage2 '(d a b f)))
                                     (and (eq stage1 stage2)
                                          (or (< internal-rev1 internal-rev2)
                                              (and (= internal-rev1 internal-rev2)
                                                   (eq sub-stage1 sub-stage2)
                                                   (< sub-stage-rev1 sub-stage-rev2))))))))))))))

#|
(version-lessp "1.0d23" "2.0d23")
(version-lessp "1.0d23" "1.1d23")
(version-lessp "1.0d23" "1.0")
(version-lessp "1.0a1" "1.0")
(version-lessp "1.0b4" "1.0")
(version-lessp "1.0b4" "1.0.1")
(version-lessp "1.0" "1.0.1")
(version-lessp "1.0.1" "1.0.2")
(version-lessp "1.0" "1.1")
(version-lessp "1.0d2" "1.0a1")
(version-lessp "1.0d2" "1.0b1")
(version-lessp "1.0a2" "1.0b1")
(version-lessp "1.0d12" "1.0d13")
(version-lessp "1.0a2" "1.0.4")
(version-lessp "1.0f3c1" "1.0f3c2")

(version-lessp "2.0d23" "1.0d23")
(version-lessp "1.1d23" "1.0d23")
(version-lessp "1.0" "1.0d23")
(version-lessp "1.0" "1.0a1")
(version-lessp "1.0" "1.0b4")
(version-lessp "1.0.1" "1.0b4")
(version-lessp "1.0.1" "1.0")
(version-lessp "1.0.2" "1.0.1")
(version-lessp "1.1" "1.0")
(version-lessp "1.0a1" "1.0d2")
(version-lessp "1.0b1" "1.0d2")
(version-lessp "1.0b1" "1.0a2")
(version-lessp "1.0d13" "1.0d12")
(version-lessp "1.0.4" "1.0a2")
(version-lessp "1.0f3c2" "1.0f3c1")

|#

(defun make-version (&key (major-rev 1)
                          (minor-rev 0)
                          (bug-rev 0)
                          (stage 'f)
                          (internal-rev 0)
                          (substage nil)
                          (substage-rev 0))
  (unless (and (integerp major-rev) 
               (integerp minor-rev)
               (integerp bug-rev)
               (memq stage '(d a b f))
               (integerp internal-rev)
               (integerp substage-rev))
    (error "Incorrect arguments"))
  (with-output-to-string (ret)
    (format ret "~a.~a" major-rev minor-rev)
    (when (not (zerop bug-rev)) (format ret ".~a" bug-rev))
    (unless (and (eq stage 'f) (eq internal-rev 0) (null substage))
      (let ((*print-case* :downcase)) (format ret "~a~a" stage internal-rev))
      (when substage
        (format ret "~a~a" substage substage-rev)))))

(defun inc-version (version)
  (multiple-value-bind (major-rev minor-rev bug-rev stage internal-rev substage substage-rev)
                       (parse-version version)
    (cond (substage (incf substage-rev))
          ((neq internal-rev 0) (incf internal-rev))
          ((neq bug-rev 0) (incf bug-rev))
          (t (incf minor-rev)))
    (make-version :major-rev major-rev :minor-rev minor-rev :bug-rev bug-rev
                  :stage stage :internal-rev internal-rev :substage substage
                  :substage-rev substage-rev)))

#|
	Change History (most recent last):
	2	3/25/92	ows	fix a braino
	3	3/25/92	ows	projector comment ate my code
	2	3/27/92	ows	uncommented some fns that were prematurely commented out
	3	4/3/92	ows	moved check-out/in-all to projector-ui.lisp
				trim whitespace from comments that are read from the buffer
	4	4/3/92	ows	use the namestring in the pathname comment window
	5	4/22/92	kab	wrap with-standard-io-syntax around version output
	6	4/24/92	ows	make the assertion case-independent
	7	7/7/93	hw	always add comments to file when checking in and out.
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	12/29/94	akh	less white space in comments

|# ;(do not edit past this line!!)