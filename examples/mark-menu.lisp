;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mark-menu.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;;
;;  Add a menu of marks much like MPW's.
;;  Unlink MPW, the marks are not saved with the file.
;;
;;
(in-package :ccl)

(defparameter *mark-menu* (make-instance 'menu
                                         :menu-title "Marks"))

(defparameter *mark-list* ())

(defmethod menu-update ((m (eql *mark-menu*)))
  (apply #'remove-menu-items
         m
         (cdddr (menu-items m)))
  (apply #'add-menu-items
         m (current-window-marks)))

(defclass mark-menu-item (menu-item)
  ((mark :initarg :mark
        :accessor menu-item-mark)
  (window :initarg :window
          :accessor menu-item-window)))

(defmethod menu-item-action ((m mark-menu-item))
  (let ((w (menu-item-window m))
        (pos (buffer-position (menu-item-mark m))))
    (set-selection-range w pos pos)
    (window-show-selection w)))

(defun add-mark-menu-item ()
  (purge-mark-list)
  (if (typep (front-window) 'fred-window)
    (push (make-instance 'mark-menu-item
                         :menu-item-title
                         (get-string-from-user "Name the Mark"
                                               :initial-string (selection-or-random))
                         :mark (make-mark (fred-buffer (front-window)))
                         :window (front-window))
          *mark-list*)
    (ed-beep)))

(defun selection-or-random ()
  (let ((f (front-window)))
    (multiple-value-bind (start end)
                         (selection-range f)
      (if (= start end)
        "Unnamed Mark"
        (buffer-substring (fred-buffer f)
                          (min end
                               (buffer-line-end (fred-buffer f) start))
                          start)))))

(defun purge-mark-list ()
  (setq *mark-list*
        (delete-if #'(lambda (item)
                       (null (wptr (menu-item-window item))))
                   *mark-list*)))

(defun current-window-marks ()
  (let ((front-window (front-window)))
    (sort (remove-if-not #'(lambda (item)
                             (eq front-window
                                 (menu-item-window item)))
                         *mark-list*)
          #'string-lessp
          :key #'menu-item-title)))

(defun remove-mark-from-menu ()
  (let ((gone-items (select-item-from-list (current-window-marks)
                                           :window-title "select items to remove:"
                                           :selection-type :disjoint)))
    (setq *mark-list*
          (delete-if #'(lambda (item)
                         (member item gone-items))
                     *mark-list*))))

(add-menu-items *mark-menu*
               (make-instance 'menu-item
                              :menu-item-action 'add-mark-menu-item
                              :menu-item-title "Add Mark…")
               (make-instance 'menu-item
                              :menu-item-action 'remove-mark-from-menu
                              :menu-item-title "Remove Mark…")
               (make-instance 'menu-item
                              :menu-item-title "-"))

(menu-install *mark-menu*)

