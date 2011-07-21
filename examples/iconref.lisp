;;;-*-Mode: LISP; Package: CCL -*-
;;;
;;;  Iconref.lisp
;;;
;;;  UNIFIED SUPPORT FOR CARBON ICONS IN MCL
;;;
;;; Copyright ©2004-2011 Terje Norderhaug / in¥Progress
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice and the author's name are included intact in this file or the
;;; source code of any derivative work. Let me know if you need another license.
;;; 
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Terje Norderhaug <terje@in-progress.com>

(in-package :ccl)

(export '(iconref))

#|
This code simplifies support of icons in MCL by unifying the interface to icons thereby making it easier to use icons as well as allowing new developer defined representations of icons.

BACKGROUND: Carbon Icon Services provides an IconRef datatype that identifies various forms of cached icon data. Many of the icon related functions in Carbon returns or takes an IconRef. Icon suites, built-in icons, icon resources and files can be referenced using an IconRef.

MCL could represent icons by IconRefs instead of using today's more primitive mix of MacPtr icon handles, number constants for built-in icons and lists of type & ID for resources. However, it would be preferable to allow other representations including encapsulation of icons as CLOS class objects.

SUGGESTION: Assume that an icon is *any* object that has a method ICONREF, which return a Mac IconRef for the icon. Wherever MCL supports icons, it should call ICONREF to get the IconRef for the icon object.

CONSEQUENCE: Parts of today's MCL core that implements icons can be simplified by eliminating complex code to handle icons. Contributors and developers should take advantage of the iconrefs when supporting icons and define custom representations of icons using the ICONREF method.

Digitool can optionally implement ICONREF methods for the representations of icons used in MCL. Developers and contributors are free to implement and use new representations of icons without any changes to the MCL core.

Please see Apple's documentation of Icon Services for more on what you can do with iconrefs:
http://developer.apple.com/documentation/Carbon/Reference/IconServices/index.html

QUESTIONS:
* Should there be a default method for ICONREF that returns NIL, or should only valid icons have an ICONREF method?

HISTORY
2010-Jan-22  New define-icon macro
2007-Jun-15  Version 1.0 Released (announced on Info-MCL mailing list)
|#

(defgeneric iconref (icon)
  (:documentation "Returns an acquired iconref for the icon, or NIL"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEFINING ICONS

(defmacro define-icon (name type &rest args)
  `(eval-when (:load-toplevel :execute)
     (defvar ,name NIL)
     (def-load-pointers ,name ()
       (setf ,name (make-instance ,type ,@args)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; REFERENCE COUNTING

(defun acquire-iconref (iconref)
  "Returns the iconref after incrementing its reference count"
  (errchk (#_AcquireIconRef iconref))
  iconref)

(defun release-iconref (iconref)
  "Decrements the reference count for the IconRef, eventually disposing the memory used for the icon"
  (#_ReleaseIconRef iconref)
  NIL)

(defun iconref-owners (iconref)
  "The reference count of the iconref"
  (rlet ((owners :unsigned-integer))
    (errchk (#_GetIconRefOwners iconref owners))
    (pref owners :unsigned-integer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MCL menu items support the icons:

(defmethod set-menu-item-icon ((item menu-item) icon &optional item-num)
  (let* ((owner (menu-item-owner item))
         (mh (and owner (menu-handle owner)))
         (item-num (or item-num (menu-item-number item))))
    (when mh
      (#_SetMenuItemIconHandle mh item-num #$kMenuIconRefType (iconref icon)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Windows can have a proxy icon:

(defmethod set-window-proxy-icon ((w window) icon)
  (#_SetWindowProxyIcon (wptr w) (iconref icon)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic Icon Types (could be in a separate module)

(defclass system-icon ()
  ((type :initarg :icon-type :initform NIL)))

(defmethod iconref ((icon system-icon))
  (with-slots (type) icon
    (when type
      (rlet ((iconref :iconref))
        (ccl::errchk 
         (#_getIconRef #$kOnSystemDisk #$kSystemIconsCreator type iconref))
        (let ((ref (pref iconref :iconref)))
            (ccl::terminate-when-unreachable ref #'release-iconref)
          ref)))))

(defclass file-icon ()
  ((pathname :initarg :pathname))
  (:documentation "Icons for files and folders"))

(defmethod iconref ((icon file-icon))
  (rlet ((fsspec :fsspec)
         (iconref :iconref)
         (label :sint16))
    (let ((present (probe-file (slot-value icon 'pathname))))
      (when present
        (with-pstrs ((name (mac-namestring present)))
          (#_FSMakeFSSpec 0 0 name fsspec))  
        (errchk (#_GetIconRefFromFile fsspec iconref label))
        (let ((ref (pref iconref :pointer)))
          (ccl::terminate-when-unreachable ref #'release-iconref)
          ref)))))

(defclass resource-icon ()
  ((type :initarg :type)
   (id :initarg :id)))

(defmethod iconref ((icon resource-icon))
  (rlet ((iconref (:pointer :iconref))
         (psn :ProcessSerialNumber
              :highLongOfPSN #$kNoProcess
              :lowLongOfPSN #$kCurrentProcess)
         (fss :fsspec)
         (inforec :ProcessInfoRec
                  :processName (%null-ptr)
                  :processAppSpec fss
                  :ProcessInfoLength #.(record-field-length :processinforec)))
     (errchk (#_GetProcessInformation psn inforec))
     (with-slots (type id) icon
       (errchk (#_RegisterIconRefFromResource :CCL2 type fss id iconref))
       (let ((ref (pref iconref :pointer)))
           (ccl::terminate-when-unreachable ref #'release-iconref)
          ref))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#| EXAMPLES

(defparameter *icon* (make-instance 'system-icon :icon-type #$kUserIcon))
(defparameter *icon* (make-instance 'file-icon :pathname *loading-file-source-file*))
(defparameter *icon* (make-instance 'resource-icon :type "ics8" :id 130))

;; Add a proxy icon to the window:

(set-window-proxy-icon (front-window) *icon*)

;; Add the icon to the Save item of the File menu:

(set-menu-item-icon (find-menu-item (find-menu "File") "Save") *icon*)

; Displays the icon in a pop up menu's menu:

(let ((menu-item (make-instance 'menu-item
                   :menu-item-title "test")))
  (make-instance 'window
    :view-subviews
    (list
     (make-instance 'pop-up-menu
       :menu-items (list menu-item))))
  (set-menu-item-icon menu-item *icon*))

;; A view (similar to icon-dialog-item) with an icon:

(defclass icon-view (view)
  ((icon :initarg :icon :reader icon-view-icon)))

(defmethod view-draw-contents ((view icon-view))
  (with-item-rect (rect view)
    (flet ((plot-icon (iconref)
             (#_PlotIconRef rect #$kAlignVerticalCenter 
            (if (window-active-p (view-window view)) #$kTransformNone #$kTransformDisabled)
            #$kIconServicesNormalUsageFlag iconref)))
      (plot-icon (iconref (icon-view-icon view))))))

(defmethod view-activate-event-handler :before ((item icon-view))
  (invalidate-view item))

(defmethod view-deactivate-event-handler :before ((item icon-view))
  (invalidate-view item))

(make-instance 'window
  :view-subviews
  (list 
   (make-instance 'icon-view :icon *icon* :view-size #@(32 32))))

;; Note that icons can be represented by anything having an iconref method. For example:

(defmethod iconref ((icon (eql :guest-user-icon)))
  "An icon represented by the keyword :guest-user-icon"
  (rlet ((iconref :iconref))
    (errchk (#_getIconRef #$kOnSystemDisk #$kSystemIconsCreator #$kGuestUserIcon iconref))
       (let ((ref (pref iconref :iconref)))
           (ccl::terminate-when-unreachable ref #'release-iconref)
          ref)))

(defparameter *icon* :guest-user-icon)

;; Test reference count:

(iconref-owners (iconref *icon*))
(gc)

|#

;;;;;;;;;;;;;;;;;;;;;;;
;; Do not edit beyond this line.

(provide :iconref)
