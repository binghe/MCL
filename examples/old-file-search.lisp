;;;-*-Mode: LISP; Package: CCL -*-
;;; old-file-search.lisp

(in-package "CCL")

; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc. The 'tool rules!

;; Modification History
;
; 2/15/95 slh   new file of code obsoleted by boyer-moore


(defun do-dialog-file-search (pathname string &aux files)
  (setq files (directory pathname :resolve-aliases t))
  (if (not files)
    (progn (ed-beep)
           (warn (format nil "No files correspond to the pathname ~s ." 
                         pathname)))
    (progn
      (format t "~&;Searching ~s for ~s ..."
              pathname
              string)
      (setq files (files-containing-string string files))
      (if files
        (file-selection-dialog files string)
        (progn (ed-beep)(format t "~&;~S is not in ~S" string pathname))))))

(defclass file-select-dialog (select-dialog) ())

(defun file-selection-dialog (files string)
  (select-item-from-list files :window-title
                         (format nil "Files containing ~A" string)
                         :modeless T
                         :default-button-text "Find it"
                         :dialog-class 'file-select-dialog
                         :action-function
                         #'(lambda (list)
                             (when list
                               (let ((*gonna-change-pos-and-sel* t))
                                 (declare (special *gonna-change-pos-and-sel*))
                                 (maybe-start-isearch (ed (car list)) string))))))

(defun files-containing-string (string files &aux (scratch (make-buffer))
                                       old-window)
  (mapcan #'(lambda (a-file)
              (let ((real-file (probe-file a-file)))
                (if real-file
                  (when (eq (mac-file-type a-file) :text)
                    (when
                      (if (setq old-window (pathname-to-window a-file))
                        (buffer-string-pos (fred-buffer old-window)
                                           string :start 0 :end t)
                        (progn
                          (buffer-delete scratch 0 t)
                          (%buffer-insert-file scratch a-file 0)
                          (buffer-string-pos scratch string
                                             :start 0 :end t)))
                      (list a-file)))
                  (warn "File ~a not found." a-file))))
          files))

; End of old-file-search.lisp
