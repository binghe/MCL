;;;-*- Mode: Lisp; Package: CL-USER -*-
;;;
;;; appearance-examples.lisp
;;;
;;; EXAMPLES OF NEW APPEARANCE MANAGER CONTROLS
;;;
;;; Copyright ©1997-1999
;;; Supportive Inquiry Based Learning Environments Project
;;; Learning Sciences Program
;;; School of Education & Social Policy
;;; Northwestern University
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice is included intact.
;;;
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Eric Russell <eric-r@nwu.edu>
;;;

(in-package :cl-user)

;;; lose pop-up-menu pane
;;; new-control-dialog-item precede appearance-activity-mixin
;;; don't require platinum-pop-up-menus

;;;----------------------------------------------------------------------
;;; Requirements & initialization«

;(setq ccl::*save-local-symbols* t)

(eval-when (:compile-toplevel :load-toplevel :execute)
(let* ((path (pathname *loading-file-source-file*))
       (dirpath (make-pathname :directory (pathname-directory path)
                               :host (pathname-host path)
                               :name nil
                               :type nil
                               :defaults nil)))
  (pushnew dirpath *module-search-path* :test #'equalp))
)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (REQUIRE :QUICKDRAW)
  (require :appearance-manager)
  (require :new-control-dialog-item)
  (require :appearance-activity-mixin)
  (require :bevel-button-dialog-item)
  (require :chasing-arrows-dialog-item)
  (require :clock-dialog-items)
  (require :little-arrows-dialog-item)
  (require :multi-pane-view)
  ;(require :platinum-pop-up-menus "ccl:examples;platinum-pop-up-menus")
  (require :progress-bar-dialog-item)
  (require :slider-dialog-item))

(init-appearance-manager)

(unless (appearance-available-p)
  (message-dialog
   "Sorry, you don't have the Appearance Manager installed. All the new controls will appear as gray rectangles."))

;;;----------------------------------------------------------------------
;;; Classes & such

(defclass example-static-text-item (static-text-dialog-item)
  ())

(defmethod slider-changed ((item example-static-text-item) slider)
  (let ((new-str (ccl::%integer-to-string (slider-setting slider))))
    (unless (string= new-str (dialog-item-text item))
      (set-dialog-item-text item new-str)
      (view-draw-contents item))))

(defmethod little-arrows-changed ((item example-static-text-item) arrows)
  (let ((new-str (ccl::%integer-to-string (little-arrows-setting arrows))))
    (unless (string= new-str (dialog-item-text item))
      (set-dialog-item-text item new-str)
      (view-draw-contents item))))

;;;----------------------------------------------------------------------
;;; The window

(defun make-example-window ()
  (let ((window (make-instance 'window
                  :view-size #@(410 300)
                  :window-type :document
                  :window-title "New Controls Examples"
                  :back-color ccl::+background-color+))
        (menu (make-instance 'pop-up-menu))
        (bevel-button-pane (make-instance 'view))
        (bevel-button (make-instance 'bevel-button-dialog-item
                        :view-position #@(125 30)
                        :view-size #@(130 48)
                        :view-font '("Geneva" 9 :bold)
                        :dialog-item-text "A Bevel Button"
                        :icon-suite-id #$genericApplicationIconResource
                        :text-placement :right
                        :text-alignment :right
                        :graphic-alignment :center))
                
        (clock-item (make-instance 'time-seconds-dialog-item
                      :view-position #@(140 201)
                      :view-size #@(100 24)
                      :view-font (system-font-spec)
                      :editable-p nil
                      :live-p nil))

        (little-arrows-pane (make-instance 'view))
        (little-arrows-box (make-instance 'example-static-text-item
                             :view-position #@(244 45)
                             :view-size #@(23 15)
                             :view-font (system-font-spec)
                             :dialog-item-text "0"))
        ;(pop-up-menu-pane (make-instance 'view))

        
        (progress-bar (make-instance 'progress-bar-dialog-item
                        :view-position #@(132 246)
                        :view-size #@(140 12)
                        :min 0
                        :max 100
                        :determinate-p t))
        (progress-process (make-process "Progress bar process"
                                        :background-p t))


        (slider-pane (make-instance 'view))
        (slider-box (make-instance 'example-static-text-item
                      :view-position #@(290 45)
                      :view-size #@(23 15)
                      :view-font (system-font-spec)
                      :dialog-item-text "1"))        
        (multi-pane-view (make-instance 'multi-pane-view
                           :view-position #@(16 10)
                           :view-size #@(377 130))))
    (flet ((run-progress-process ()
             (loop 
               (unless (wptr window)
                 (process-kill progress-process))
               (when (and (wptr progress-bar)
                          (progress-bar-determinate-p progress-bar))
                 (if (= (progress-bar-setting progress-bar)
                        (progress-bar-max progress-bar))
                   (set-progress-bar-setting
                    progress-bar
                    (progress-bar-min progress-bar))
                   (set-progress-bar-setting
                    progress-bar
                    (1+ (progress-bar-setting progress-bar)))))
               (sleep 0.1))))
      (process-preset progress-process #'(lambda () (run-progress-process)))
      (add-menu-items menu
                      (make-instance 'menu-item
                        :menu-item-title "Application"
                        :menu-item-action #'(lambda ()
                                              (set-bevel-button-icon-suite-id 
                                               bevel-button
                                               #$genericApplicationIconResource)))
                      (make-instance 'menu-item
                        :menu-item-title "Document"
                        :menu-item-action #'(lambda ()
                                              (set-bevel-button-icon-suite-id
                                               bevel-button
                                               #$genericDocumentIconResource)))
                      (make-instance 'menu-item
                        :menu-item-title "Folder"
                        :menu-item-action #'(lambda ()
                                              (set-bevel-button-icon-suite-id
                                               bevel-button
                                               #$genericFolderIconResource))))
      (setf (bevel-button-menu bevel-button) menu)
      (add-subviews bevel-button-pane bevel-button)
      
      (add-subviews little-arrows-pane
                    (make-instance 'static-text-dialog-item
                      :view-position #@(130 45)
                      :view-font (system-font-spec)
                      :dialog-item-text "Little Arrows:")
                    (make-instance 'little-arrows-dialog-item
                      :view-position #@(225 42)
                      :view-size  #@(14 23)
                      :min -10
                      :max +10
                      :setting 0
                      :adjustee little-arrows-box)
                    little-arrows-box)
      #+ignore
      (add-subviews pop-up-menu-pane
                    (make-instance 'pop-up-menu
                      :view-position #@(50 45)
                      :menu-font (system-font-spec)
                      :menu-colors `(:menu-body ,ccl::+background-color+)
                      :menu-title "New pop-up-menus:"
                      :menu-items (list (make-instance 'menu-item
                                          :menu-item-title "Item One")
                                        (make-instance 'menu-item
                                          :menu-item-title "Item Two")
                                        (make-instance 'menu-item
                                          :menu-item-title "Item Three"))))
      (add-subviews slider-pane
                    (make-instance 'static-text-dialog-item
                      :view-position #@(70 45)
                      :view-font (system-font-spec)
                      :dialog-item-text "Slider:")
                    (make-instance 'slider-dialog-item
                      :view-position #@(120 45)
                      :view-size #@(160 24)
                      :min 1
                      :max 10
                      :setting 1
                      :tick-count 10
                      :direction :horizontal
                      :thumb-direction :up
                      :adjustee slider-box)
                    slider-box)
      (add-pane multi-pane-view bevel-button-pane "Bevel Button")
      (add-pane multi-pane-view little-arrows-pane "Little Arrows")
      ;(add-pane multi-pane-view pop-up-menu-pane "Popup Menu")
      (add-pane multi-pane-view slider-pane "Slider")
      (add-subviews window
                    multi-pane-view
                    (make-instance 'static-text-dialog-item
                      :view-position #@(135 160)
                      :view-font (system-font-spec)
                      :dialog-item-text "Chasing Arrows:")
                    (make-instance 'chasing-arrows-dialog-item
                      :view-position #@(244 160)
                      :view-size #@(16 16))

                    (make-instance 'static-text-dialog-item
                      :view-position #@(90 205)
                      :view-font (system-font-spec)
                      :dialog-item-text "Clock:")
                    clock-item
                    (make-instance 'check-box-dialog-item
                      :view-position #@(245 196)
                      :view-size #@(62 16)
                      :view-font '("Geneva" 9 :bold)
                      :dialog-item-text "Editable"
                      :check-box-checked-p (editable-p clock-item)
                      :dialog-item-action #'(lambda (item)
                                              (setf (editable-p clock-item)
                                                    (check-box-checked-p item))))
                    (make-instance 'check-box-dialog-item
                      :view-position #@(245 213)
                      :view-size #@(43 16)
                      :view-font '("Geneva" 9 :bold)
                      :dialog-item-text "Live"
                      :check-box-checked-p (live-p clock-item)
                      :dialog-item-action #'(lambda (item)
                                              (setf (live-p clock-item)
                                                    (check-box-checked-p item))))

                    (make-instance 'static-text-dialog-item
                      :view-position #@(36 245)
                      :view-font (system-font-spec)
                      :dialog-item-text "Progress Bar:")
                    progress-bar
                    (make-instance 'check-box-dialog-item
                      :view-position #@(282 245)
                      :view-size #@(84 16)
                      :view-font '("Geneva" 9 :bold)
                      :dialog-item-text "Determinate"
                      :check-box-checked-p (progress-bar-determinate-p progress-bar)
                      :dialog-item-action #'(lambda (item)
                                              (set-progress-bar-determinate-p
                                               progress-bar
                                               (check-box-checked-p item))))


                    (make-instance 'static-text-dialog-item
                      :view-position    #@(10 280)
                      :view-font        '("Geneva" 9 :plain)
                      :dialog-item-text "Bring another window to the front to see the effects of the appearance-activity-mixin."))
      (window-show window)
      (process-enable progress-process))))

(progn (make-example-window) nil)

;;;----------------------------------------------------------------------