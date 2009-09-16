;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Netscape Information
;;;
;;; Theory:  This example displays a small text dialog item that accepts
;;;          only Netscape links and bookmarks, then displays some information
;;;          about what was dragged into it.
;;;
;;;          Note the back-handed manner in which the example determines that
;;;          the source of the drag is Netscape.  Normally, there is no way
;;;          to get this information; you have to infer it, based upon the
;;;          number and types of drag items.  Obviously, this doesn't work all
;;;          the time.  If Netscape had chosen different drag flavors, and
;;;          implemented what they had in a more consistent manner, this code
;;;          would be a lot easier.  Get DragPeeker and check out the data
;;;          that comes from Netscape; you'll see.
;;;
;;;          As an added bonus, if you hold down the Command key while dragging
;;;          a link, the example will ask Netscape to download the associated
;;;          HTML file to your desktop.  The files generated from Bookmark items
;;;          are virtually empty; the contain only the URL.  The Drag Manager
;;;          won't give Netscape the time to actually download a file, so there
;;;          isn't any way to bring up the file within MCL within a single pass;
;;;          you would have to tell Netscape to download, setup a "watcher
;;;          process" that watches the destination folder for the new file,
;;;          then open that file (or whatever) once it appears.  Leave it as an
;;;          excercise for the reader....
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :drag-and-drop)
  
  (export '(netscape-info))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Constants & such
;;;

(defconstant $NetscapeLinkFlavor	:|URLD|)
(defconstant $NetscapeLinkHFSFlavor	:|urlF|)
(defconstant $NetscapeBookmarkFlavor	:|TEXT|)
(defconstant $NetscapePromisedFlavor	#$flavorTypePromiseHFS)
(defconstant $NetscapeBookmarkHFSFlavor	:|URL |)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Class Definitions for drag & drop
;;;

;; We don't need to define a value for :drag-accepted-flavor-list because we're
;; overriding #'drag-received-dropped-item -- the init arg is never checked.
(defclass drop-aware-edit-text (editable-text-dialog-item
                                drag-view-mixin)
  ()
  (:default-initargs
    :drag-allow-copy-p nil
    :drag-allow-move-p nil
    :drag-auto-scroll-p nil
    :drag-accepted-flavor-list nil
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Drag & Drop methods
;;;
;;; Note the complete absence of any kind of outbound-dragging methods.  We
;;; just don't allow them in this view.
;;;

;; Return true if each drag item contains either a $NetscapeLinkFlavor (meaning
;; that it's a link dragged from an HTML document) or both a promised HFS
;; flavor and a Netscape Bookmark HFS flavor.  This kind of test helps us
;; determine that it's really Netscape that is performing the drag.
(defmethod drag-allow-drop-p ((view drop-aware-edit-text))
  (let ((drop-accepted-p t))
    (with-each-drag-item (item-reference)
      (setf drop-accepted-p
            (and drop-accepted-p
                 (or (drag-flavor-exists-p item-reference $NetscapeLinkFlavor)
                     (and (drag-flavor-exists-p item-reference $NetscapePromisedFlavor)
                          (drag-flavor-exists-p item-reference $NetscapeBookmarkHFSFlavor))))))
    drop-accepted-p))

;; Clear the view before processing the rest of the data.
(defmethod drag-receive-drop ((view drop-aware-edit-text))
  (set-dialog-item-text view (format nil "Number of items in drag: ~D" (drag-count-items)))
  (call-next-method))

;; Assume the right flavors are there, since they were tested in #'drag-allow-drop-p.
;; This is an example of what you have to do if you override this method rather
;; than allowing the MCL handlers to call #'drag-receive-dropped-flavor.
;; A lot of this code is working around "interesting" data layouts coming from
;; Netscape.
(defmethod drag-receive-dropped-item ((view drop-aware-edit-text)
                                      (item-reference integer))
  (let ((received-p nil)
        (cmd-key-p (drag-command-key-p)))
    (with-cursor *watch-cursor*
      (cond ((drag-flavor-exists-p item-reference $NetscapeLinkFlavor)
             (with-drag-flavor (item-reference $NetscapeLinkFlavor data-ptr data-size)
               (when (plusp data-size)
                 (multiple-value-bind (url name)
                                      (%parse-netscape-link data-ptr data-size)
                   (when (and url name)
                     (setf received-p t)
                     (%append-dialog-text view (format nil "~%~%Link URL:  ~A" url))
                     (%append-dialog-text view (format nil "~%Link Name: ~A" name))
                     (if (and cmd-key-p
                              (drag-flavor-exists-p item-reference $NetscapeLinkHFSFlavor))
                       (%get-netscape-file item-reference $NetscapeLinkHFSFlavor)))))))
            ((drag-flavor-exists-p item-reference $NetscapeBookmarkFlavor)
             (with-drag-flavor (item-reference $NetscapeBookmarkFlavor data-ptr data-size)
               (when (plusp data-size)
                 (setf received-p t)
                 (let ((bookmark-name-list (%parse-netscape-bookmarks data-ptr data-size)))
                   (%append-dialog-text view (format nil "~%"))
                   (dolist (bookmark bookmark-name-list)
                     (%append-dialog-text view (format nil "~%~A" bookmark))))
                 (if (and cmd-key-p
                          (drag-flavor-exists-p item-reference $NetscapeBookmarkHFSFlavor))
                   (%get-netscape-file item-reference $NetscapeBookmarkHFSFlavor))
                 )))
            ((drag-flavor-exists-p item-reference $NetscapeBookmarkHFSFlavor)
             (setf received-p t)
             (if cmd-key-p
               (%get-netscape-file item-reference $NetscapeBookmarkHFSFlavor)))
            ))
    received-p))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Low-level thingies
;;;
(defun %append-dialog-text (view new-text)
  (let ((old-text (dialog-item-text view)))
    (if (and old-text
             (not (equalp old-text "")))
      (setf old-text (format nil "~A " old-text)))
    (set-dialog-item-text view (format nil "~A ~A" old-text new-text))))

;; Links are in the format "<URL>#\Return<Title>"
(defun %parse-netscape-link (data-ptr data-size)
  (let ((link-string nil)
        (delim-pos 0))
    #+ccl-3 (setf link-string (%str-from-ptr-in-script data-ptr data-size))
    #-ccl-3 (progn
              (setf link-string (make-string data-size))
              (without-interrupts
               (dotimes (counter data-size)
                 (setf (char link-string counter)
                       (code-char (%get-byte data-ptr counter))))))
    (setf delim-pos (position #\Return link-string))
    (if delim-pos
      (values (subseq link-string 0 delim-pos)
              (subseq link-string (1+ delim-pos) (length link-string))))))

;; Bookmarks contain only URLs.  Bookmark data is always a list, with each
;; element terminated by an ASCII 10 character (a UNIX newline).  There is
;; a NULL character at the end of the list, but it's not used here.
(defun %parse-netscape-bookmarks (data-ptr data-size)
  (let ((bookmark-list nil)
        (bookmark-string nil)
        (delim (code-char 10))
        (parse-pos 0)
        (end-pos 0))
    #+ccl-3 (setf bookmark-string (%str-from-ptr-in-script data-ptr data-size))
    #-ccl-3 (progn
              (setf bookmark-string (make-string data-size))
              (without-interrupts
               (dotimes (counter data-size)
                 (setf (char bookmark-string counter)
                       (code-char (%get-byte data-ptr counter))))))
    (setf end-pos (position delim bookmark-string))
    (loop while end-pos
          do (push (subseq bookmark-string parse-pos end-pos) bookmark-list)
          do (setf parse-pos (1+ end-pos))
          do (setf end-pos (position delim bookmark-string :start parse-pos)))
    (reverse bookmark-list)))

;; Get the path to the desktop file, set the drop location there, then ask
;; Netscape to deliver the HFS flavor.  We wrap the call inside #'ignore-errors
;; because Netscape doesn't provide all the right information up-front and we'll
;; error trying to check it.  This call does prompt Netscape into actually
;; downloading the file, though.
(defun %get-netscape-file (drag-item-ref hfs-flavor)
  (let ((temporary-items-path (ccl::%special-folder-path :desktopfolder)))
    (when temporary-items-path
      (drag-set-drop-location-from-path temporary-items-path)
      (ignore-errors (drag-get-hfs-flavor drag-item-ref hfs-flavor))
      t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Display the sample window…
;;;
(defun netscape-info ()
  (make-instance 'color-dialog
    :window-type :document
    :window-title "Netscape Info"
    :view-position #@(25 60)
    :view-size #@(600 200)
    :view-font '("Chicago" 12 :srcor :plain #+ccl-3 (:color-index 0)
                 )
    :view-subviews
    (list (make-dialog-item 'drop-aware-edit-text
                            #@(7 30)
                            #@(586 158)
                            "Drag Netscape Links and Bookmarks Here…"
                            'nil
                            :wrap-p t
                            :view-nick-name 'netscape-drop
                            :view-font '("Monaco" 9 :srcor :plain #+ccl-3 (:color-index 0)
                                         )
                            :allow-returns t))))