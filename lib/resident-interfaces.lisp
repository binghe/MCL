; -*- Mode:Lisp; Package:CCL; -*-

; resident-interfaces.lisp
;
; Functions moved from "ccl:library;interfaces.lisp"
; because they are referenced by some of the autoloaded traps.

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;;;;;;;;;;;;
;;
;; Modification History
;;
;; comment out most of it - this file should go away
;; ----- 5.1 final
;; 08/10/92 bill  New file
;;

(in-package :traps)

#|
(defun gopmag (selector pstr0 pstr1)
  (let* ((len0 (ccl:%get-unsigned-byte pstr0))
         (len1 (ccl:%get-unsigned-byte pstr1)))
    (ccl:stack-trap #xa9ed 
                    :ptr (ccl:%inc-ptr pstr0) 
                    :ptr (ccl:%inc-ptr pstr1) 
                    :word len0 
                    :word len1
                    :word selector
                    :word)))

(defun gopmagp (selector pstr0 pstr1 intl2)
  (let* ((len (logior (ash 16 (ccl:%get-unsigned-byte pstr0)) (ccl:%get-unsigned-byte pstr1))))
    (ccl:stack-trap #xa9ed 
                    :ptr (ccl:%inc-ptr pstr0) 
                    :ptr (ccl:%inc-ptr pstr1)
                    :ptr intl2
                    :word len
                    :word selector
                    :word)))
|#

; Make a cstring into a pstring in place.
(defun c2pstr (cstr)
  (unless (ccl::%null-ptr-p cstr)
    (let* ((b0 0)
           (b1 0)
           (len 0))
      (declare (fixnum b0 b1 len))
      (unless (eql 0 (setq b0 (%get-byte cstr)))
        (loop
          (incf len)
          (setq b1 (%get-byte cstr len))
          (%put-byte cstr b0 (1- len))
          (when (eql 0 (setq b0 b1))
            (%put-byte cstr (max len 255))
            (return cstr)))))))

(setf (symbol-function 'c2pstrproc) #'c2pstr)

; Make a pstring into a cstring in place.
(defun p2cstr (pstr)
  (unless (ccl::%null-ptr-p pstr)
    (let* ((len (ccl::%get-unsigned-byte pstr)))
      (declare (fixnum len))
      (dotimes (i len)
        (%put-byte pstr (%get-byte pstr (1+ i)) i))
      (%put-byte pstr 0 len)
      pstr)))
      
(setf (symbol-function 'p2cstrproc) #'p2cstr)

#|
(defun pb-control-0 (pb refnum code async)
  (setf (ccl:rref pb :paramblockrec.iorefnum) refnum
        (ccl:rref pb :paramblockrec.cscode) code)
  (if (not (eql 0 async))
    (ccl:register-trap #xA404 :a0 pb (:signed-integer :d0))
    (ccl:register-trap #xA004 :a0 pb (:signed-integer :d0))))

(defun pb-control-1 (pb refnum code param async)
  (setf (ccl:rref pb :paramblockrec.iorefnum) refnum
          (ccl:rref pb :paramblockrec.cscode) code
          (ccl:rref pb (:paramblockrec.csparam 0)) param)
  (if (not (eql 0 async))
    (ccl:register-trap #xA404 :a0 pb (:signed-integer :d0))
    (ccl:register-trap #xA004 :a0 pb (:signed-integer :d0))))
|#
