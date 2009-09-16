;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 12/1/95  akh  simplify pstr/cstr-segment-pointer
;;  (do not edit before this line!!)


; l0-aprims.lisp


 ; its also in l1-aprims
; from string to pointer - used by with-pstrs 
; only transmits fat chars as such if they make sense in script
; ignores the possibility of a base-string containing bytes that are
; start of 2 byte chars in script.  
(defun %pstr-pointer (string pointer &optional script)  
  (if (> (length string) 255) (error "String ~s too long for pascal string." string))
  (if (base-string-p string)
    (multiple-value-bind (s o n) (dereference-base-string string)
      (declare (fixnum o n))
      (let* ((limit (min n 255)))
        (declare (fixnum limit))
        (setf (%get-byte pointer 0) limit) ; set length byte
        (do* ((o o (1+ o))
              (i 0 (1+ i))
              (j 1 (1+ j)))
             ((= i limit))
          (declare (fixnum o i j))
          (setf (%get-byte pointer j) (%scharcode s o)))))
    (%put-string pointer string 0 255 script))
  nil)

; its also in l1-symhash
(defun dereference-base-string (s)
  (multiple-value-bind (vector offset) (array-data-and-offset s)
    (unless (typep vector 'simple-base-string) (report-bad-arg s 'base-string))
    (values vector offset (the fixnum (+ (the fixnum offset) (the fixnum (length s)))))))


; end
