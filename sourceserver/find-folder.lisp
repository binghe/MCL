;; find-folder.lisp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 04-30-03 akh   find-folder calls findfolder
;; 04/23/96 bill  add an optional volume-number parameter (from Dylan)
;; -------------  MCL-PPC 3.9
;;

(in-package :ccl)

(export 'find-folder)

#+ignore
(eval-when (eval compile)
  (require 'sysequ))

(defun find-folder (folder-signature &optional
                                     (createp t)
                                     (volume-number-or-path #$kUserDomain))
  ;;folder types are documented in Inside Mac Volume VI, The Finder Interface
  (let* ((can-do? (gestalt "fold")))
    (when (and can-do?
               (plusp can-do?))
      (unless (integerp volume-number-or-path)
        (setq volume-number-or-path
              (volume-number (directory-namestring
                              (translate-logical-pathname 
                               volume-number-or-path)))))
      (when volume-number-or-path
        (findfolder volume-number-or-path folder-signature createp)))))

#|
	Change History (most recent last):
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	12/22/94	akh	none
|# ;(do not edit past this line!!)
