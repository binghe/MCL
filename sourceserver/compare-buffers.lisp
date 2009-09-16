

;;	Change History (most recent first):
;;  1 10/13/95 bill new file
;;  (do not edit before this line!!)
(in-package :ccl)

;;; 07/12/06 akh #\newline -> eol-string
;;; ------ MCL 5.2b5
;;; 10/12/95 bill  dummy with-shown-progress macro to make it work in vanilla CCL
;;; 11/18/92  gz   Completely new implementation, buffers-only.

;;; Description of algorithm (taken verbatim from MPW Compare facility)

;;; Both files are read and compared line for line.  As soon as a mismatch is found,
;;; the two mismatched lines are stored in two stacks, one for each file.  Lines are 
;;; then read alternately (starting from the next input line in file2) until a match 
;;; is found to put the files back in synchronization.  If such a match is found, 
;;; Compare writes the mismatched lines to standard output.

;;; Files are considered resynchronized when a certain number of lines in the two 
;;; stacks exactly match.  By default, the number of lines, called the grouping factor, 
;;; is defined by the formula (truncate (+ (* 2.0 (log M 10)) 2.0)) where M is the 
;;; number of lines saved in each stack so far.  This definition requires more lines 
;;; to be the same after larger mismatches.


(defmacro with-shown-progress ((task &rest ignore) &body body)
  (declare (ignore ignore))
  `(let ((,task nil)) ,@body))

(defun show-progress (&rest ignore)
  (declare (ignore ignore))
  nil)

(defvar *group-factor* nil
  "Can be an integer for a fixed group factor,
   a ratio or float to indicate fractor of unmatched lines,
   a function of one argument (the unmatched line count),
   or NIL for the standard group factor: (+ (* 2 (log line-count 10)) 2)")

(defun compare-buffers (buffer1 buffer2 &key (start1 0) (start2 0) (end1 t) (end2 t))
  (setq start1 (ccl:buffer-position buffer1 start1)
        end1 (ccl:buffer-position buffer1 end1)
        start2 (ccl:buffer-position buffer2 start2)
        end2 (ccl:buffer-position buffer2 end2))
  (unless (<= start1 end1)
    (error "START1 (~s) > END1 (~s)" start1 end1))
  (unless (<= start2 end2)
    (error "START2 (~s) > END2 (~s)" start2 end2))
  (ccl:with-cursor ccl:*watch-cursor*
    (with-shown-progress (task "Compare")
      (let ((mismatches nil)
            (note (make-array 100 :element-type 'character :fill-pointer 0)))
        (loop
          (do () ((or (eql start1 end1) (eql start2 end2)))
            (unless (eql (ccl:buffer-char buffer1 start1) (ccl:buffer-char buffer2 start2))
              (return))
            (incf start1)
            (incf start2))
          (when (and (eql start1 end1) (eql start2 end2))
            (return-from compare-buffers (nreverse mismatches)))
          (setq start1 (ccl:buffer-line-start buffer1 start1))
          (setq start2 (ccl:buffer-line-start buffer2 start2))
          (multiple-value-bind (rematch1 rematch2 matched-len)
                               (resynchronize-buffers buffer1 start1 end1
                                                      buffer2 start2 end2)
            (vector-push #\. note)
            (show-progress task :note note)
            (push (cons (cons start1 rematch1) (cons start2 rematch2)) mismatches)
            (setq start1 (+ rematch1 matched-len) start2 (+ rematch2 matched-len))))))))


(defun resynchronize-buffers (buffer1 start1 end1 buffer2 start2 end2)
  (let* ((limit1 (ccl::buffer-forward-find-char buffer1 eol-string start1 end1))
         (line-count1 1)
         (limit2 (ccl::buffer-forward-find-char buffer2 eol-string start2 end2))
         (line-count2 1))
    (loop
      (when limit1
        (multiple-value-bind (match-pos2 match-len)
                             (do-line-search line-count1 buffer1 limit1 end1
                                             buffer2 start2 limit2 end2)
          (when match-pos2
            (return (values limit1 match-pos2 match-len))))
        (setq limit1 (ccl::buffer-forward-find-char buffer1 eol-string limit1 end1))
        (incf line-count1))
      (when limit2
        (multiple-value-bind (match-pos1 match-len)
                             (do-line-search line-count2 buffer2 limit2 end2
                                             buffer1 start1 limit1 end1)
          (when match-pos1
            (return (values match-pos1 limit2 match-len))))
        (setq limit2 (ccl::buffer-forward-find-char buffer2 eol-string limit2 end2))
        (incf line-count2))
      (when (and (null limit1) (null limit2))
        (return (values end1 end2 0))))))

(defun standard-group-factor (line-count)
  (cond ((< line-count 4) 2)
        ((< line-count 10) 3)
        ((< line-count 32) 4)
        ((< line-count 100 ) 5)
        ((< line-count 317) 6)
        ((< line-count 1001) 7)
        ((< line-count 3163) 8)
        ((< line-count 10000) 9)
        ((< line-count 31623) 10)
        ( t 11)))

(defun compute-group-factor (line-count)
  (let ((gf (cond ((null *group-factor*)
                     (standard-group-factor line-count))
                  ((typep *group-factor* 'integer)
                   *group-factor*)
                  ((typep *group-factor* 'real)
                   (truncate (* line-count *group-factor*)))
                  (t (truncate (funcall *group-factor* line-count))))))
    (if (< gf 1) 1 gf)))

(defun read-buffer-lines (line-count buffer start end)
  (multiple-value-bind (pos left)
                       (ccl:buffer-line-start buffer start (1- (compute-group-factor line-count)))
    (when (and (null left) (<= pos end))
      (ccl:buffer-substring buffer (1- start) (min end (ccl:buffer-line-end buffer pos))))))

(defun do-line-search (line-count src-buf src-start src-end buffer start limit end)
  (let ((str (read-buffer-lines line-count src-buf src-start src-end)))
    (when str
      (let* ((str-len (length str))
             (data-len (1- str-len))
             (search-end (if limit (min (+ (1- limit) data-len) end) end))
             (search-start start))
        (unless (or (eql search-end end)
                    (char-eolp (ccl:buffer-char buffer search-end)))
          (setq search-end (ccl:buffer-line-end buffer search-end -1))
          (when (< search-end start) (setq search-end start)))
        (loop
          (let ((pos (and (<= (+ search-start data-len) search-end)
                          (if (eql search-start 0)
                            data-len
                            (ccl::buffer-forward-search buffer str (1- search-start) search-end)))))
            (when (null pos) (return nil))
            (when (or (eql pos search-end) (char-eolp (ccl:buffer-char buffer pos)))
              (setq pos (- pos data-len))
              ;;Search is case-insensitive, we want case-sensitive, so double-check.
              (do ((p pos (1+ p)) (i 1 (1+ i)))
                  ((eql i str-len) (return-from do-line-search (values pos data-len)))
                (unless (eql (ccl:buffer-char buffer p) (char str i)) (return nil))))
            (setq search-start (ccl::buffer-forward-find-char buffer eol-string pos search-end))
            (when (null search-start) (return nil))))))))

#|
	Change History (most recent last):
	2	6/23/92	ows	test
	3	10/12/92	jh	Precompute the group-factor
~~	4	11/18/92	gz	New compare implementation
~~	5	11/18/92	gz	Support Generate Difs Window
|# ;(do not edit past this line!!)
