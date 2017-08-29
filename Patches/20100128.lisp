
(in-package :ccl)

;;; guard against eof in mid sequence

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

  (defmethod stream-read-sequence ((stream input-stream) (sequence vector)
                                   &key (start 0)(end (length sequence)))
    (if (null end) 
      (setq end (length sequence))
      (progn
        (setq end (require-type end (load-time-value `(integer 0 ,most-positive-fixnum))))
        (if (> end (length sequence)) (error "End ~s should be <= ~s" end (length sequence)))))
    (setq start (require-type start (load-time-value `(integer 0 ,most-positive-fixnum))))
    
    (let ((chars-read 0))
      (declare (fixnum chars-read))
      (multiple-value-bind (reader arg)(stream-reader stream)
        (multiple-value-bind (data offset)(array-data-and-offset sequence)
          (declare (fixnum offset))
          (let* ((start (+ start offset))
                 (end (+ end offset))
                 (element nil))
            (declare (fixnum start end))
            (do* ((i start (1+ i)))
                 ((or (%i>= i end)(stream-eofp stream)))
              (declare (fixnum i))
              ;; permit read to fail subsequent to the eofp test. eg. network failure
              (if (setf element (funcall reader arg))
                (setf (uvref data i) element)
                (return))
              (incf chars-read)))))
      (%i+ start chars-read)))
  )

