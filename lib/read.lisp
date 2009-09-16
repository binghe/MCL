;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  4 4/19/96  akh  Steve's fix to #=
;;  3 3/29/96  akh  remove the print call in #= reader
;;  (do not edit before this line!!)


;; Copyright 1987-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; simple-reader-error inherit from reader-error
; ------- 5.2b6
;03/02/2004 ss change circle-subst to reflect new index (1) of class wrappers
;------------ 5.1b1
;03/29/96 akh  remove print from #= reader
;03/12/96 bill ppc targetize the #= dispatch macro.
;11/16/93 bill parse-integer now handles NIL for the end arg
;-------- 3.0d13
;05/23/93 alice in #n= prevent looping in e.g. #1=(a  #2=(C #1# d) #2#)
;03/09/93 bill nuke read-file-to-list
;------------ 2.0
;07/01/91 gb   circle-subst doesn't descend instances.  Fixup error signalling.
;02/18/91 gb   %uvsize -> uvsize.
;12/04/90 gb  Made #= & ## use recursion and live to tell about it.
;11/11/90 gb  Made #= use recursion.
;05/01/90 gz  Made reader-error use error system.
;12/29/89 gz  deleted the commented-out old rubout handling stuff, now done
;             differently.
;12/28/89 gz  %defstructs% hash table.
;11/18/89 gz  No %print.
;09/25/89 gb  no objvar decls.
;09/16/89 bill Remove the last vestiges of object-lisp windows
;              i.e. converted stream-read for terminal-io.  It doesn't work, though.
;03/18/89 gz window-select -> window-object-select.
;02/03/89 gz commented out rubout handling pending new implementation.
;01/04/89 gz New buffer streams.
;01/03/89 gz ## and #=
;12/30/88 gz Mods for new buffers.
;12/11/88 gz mark-position -> buffer-position
; 9/2/88  gz no more list-nreverse.
; 8/26/88 gz no more read-structure-class-p.
; 8/18/88 gb shadow kernel functions at most once.
; 6/22/88 jaj&as kludged up read-with-rubout to do the right thing
; 6/21/88  as   support for read-with-rubout
;               read -> %kernel-read
; 12/23/87 cfry fixed #s to use read-structure-class-p insted of
;                              structure-class-p
; 8/03/87 gz  fix in parse-integer, #S obeys *read-suppress*
; 7/16/87 gz  new structure reader for new structures.
;             whitespace-char-p -> whitespacep.
; 6/08/87 gz  &aux constructor in make-structure.
; 5/04/87 cfry replaced symbol *%reader-eof* with *eof-value*
; 4/29/87 gz removed #+, #-, read-internal-suppressed, read-internal-unsuppressed.
; 4/6/87 gz removed read-char, unread-char.
;           use dynamic binding
;           converted ERROR calls to CL syntax

#+ignore
(defun reader-error (input-stream format-string &rest format-args)
  (error 'reader-error :stream input-stream
         :format-string format-string :format-arguments format-args))
#+ignore   ;;its signal-reader-error now
(defun reader-error (input-stream format-string &rest format-args)
  (error 'simple-reader-error :stream input-stream
         :format-string format-string :format-arguments format-args))


#| ; Can't see any reason to leave this in
(defun read-file-to-list (file &aux result)
   ;(print-db (setq file (prepend-default-dir file)))   
   (with-open-file (stream file :direction :input)
       (setq result (read-file-to-list-aux stream)))
   result)

(defun read-file-to-list-aux (stream)
   (if (eofp stream)
        nil
       (let ((form (read stream nil *eof-value* nil)))
            ;(%print "just read " form)
           (if (eq form *eof-value*)
                nil
               (cons form (read-file-to-list-aux stream))))))
|#

(defun read-internal (input-stream)
   (read input-stream t nil t))


(set-dispatch-macro-character #\# #\*
 (qlfun |#*-reader| (input-stream sub-char int 
   &aux list list-length array array-length last-bit)
  (declare (ignore sub-char))
  (do* ((char (read-char input-stream nil (code-char 50) t) 
              (read-char input-stream nil (code-char 50) t))
        (number (- (char-code char) 48) (- (char-code char) 48)))
       ((not (<= 0 number 1))
        (if (not (= number 2)) ;not at eof
            (unread-char char input-stream)))
      (setq list (cons number list)))
  (setq last-bit (car list))
  (setq list (nreverse list))
  (setq list-length (list-length list))
  (cond ((and (integerp int) (> list-length int))
         (signal-reader-error input-stream "reader macro #* got an array length shorter than the list ~S ~S" int list))
        (*read-suppress* nil)
        (t (setq array-length (if int int list-length))
           (setq array (make-array array-length :element-type 'bit))
           (do ((i 0 (1+ i))
                (bit-list list (cdr bit-list)))
               ((>= i array-length))
              (aset array i (if bit-list
                                (car bit-list)
                                last-bit)))
           array))))

(set-dispatch-macro-character #\# #\A
 (qlfun |#A-reader| (stream ignore dimensions)
  (declare (ignore ignore))
  (cond (*read-suppress*
	        (read stream () () t)
	        nil)
        ((not dimensions)
         (signal-reader-error stream "reader macro #A used without a rank integer"))
        ((eql dimensions 0) ;0 dimensional array
         (make-array nil :initial-contents (read-internal stream)))
        ((and (integerp dimensions) (> dimensions 0)) 
	         (let* ((dlist (make-list dimensions))
		               (init-list (read-internal stream)))
		              (if (not (listp init-list))
                    (signal-reader-error stream "The form following a #A reader macro should have been a list, but it was: ~S" init-list))                  
	              (do ((dl dlist (cdr dl))
		                  (il init-list (car il)))
	                   	;; I think the nreverse is causing the problem.
		                 ((null dl))
	                  (if (listp il)
		                     (rplaca dl (list-length il))
		                     (error
			                     "Initial contents for #A is inconsistent with ~
			                     dimensions: #~SA~S" dimensions init-list)))
	              (make-array dlist :initial-contents init-list)))
	       (t (signal-reader-error stream 
             "Dimensions argument to #A not a non-negative integer: ~S" 
		           dimensions)))))

(set-dispatch-macro-character #\# #\S
  (qlfun |#S-reader| (input-stream sub-char int &aux list sd)
     (declare (ignore sub-char int))
     (setq list (read-internal input-stream))
     (unless *read-suppress*
       (unless (and (consp list)
                    (symbolp (%car list))
                    (setq sd (gethash (%car list) %defstructs%))
		    (setq sd (sd-constructor sd)))
         (error "Can't initialize structure from ~S." list))
       (let ((args ()) (plist (cdr list)))
         (unless (plistp plist) (report-bad-arg plist '(satisfies plistp)))
         (while plist
           (push (make-keyword (pop plist)) args)
           (push (pop plist) args))
         (apply sd (nreverse args))))))

;from slisp reader2.lisp.
(defun parse-integer (string &key (start 0) end
                      (radix 10) junk-allowed)
  (when (null end)
    (setq end (length string)))
  (let ((index (do ((i start (1+ i)))
                   ((= i end)
                    (if junk-allowed
                        (return-from parse-integer (values nil end))
                        (error "Not an integer string: ~S." string)))
                   (unless (whitespacep (char string i)) (return i))))
        (minusp nil)
        (found-digit nil)
        (result 0))
       (let ((char (char string index)))
            (cond ((char= char #\-)
                   (setq minusp t)
                   (setq index (1+ index)))
                  ((char= char #\+)
                    (setq index (1+ index))
                   )))
       (loop
        (when (= index end) (return nil))
        (let* ((char (char string index))
               (weight (digit-char-p char radix)))
              (cond (weight
                     (setq result (+ weight (* result radix))
                                  found-digit t))
                    (junk-allowed (return nil))
                    ((whitespacep char)
                     (until (eq (setq index (1+ index)) end)
                       (unless (whitespacep (char string index))
                         (error "Not an integer string: ~S." string)))
                     (return nil))
                    (t
                     (error "Not an integer string: ~S." string))))
         (setq index (1+ index)))
       (values
        (if found-digit
            (if minusp (- result) result)
            (if junk-allowed
                nil
                (error "Not an integer string: ~S." string)))
        index)))


(set-dispatch-macro-character #\# #\#
  #'(lambda (stream char arg)
      (declare (ignore stream))
      (if *read-suppress* 
        (values)
        (if arg
          (let ((pair (assoc arg %read-objects%))) ;Not assq, could be bignum!
            (if pair
              (cdr pair)
              (%err-disp $xnordlbl arg)))
          (%err-disp $xrdndarg char)))))

(set-dispatch-macro-character 
 #\# 
 #\=
 #'(lambda (stream char arg &aux lab form)
     (cond (*read-suppress* (values))
           ((null arg) (%err-disp $xrdndarg char))
           ((assoc arg %read-objects%)    ;Not assq, could be bignum!
            (%err-disp $xduprdlbl arg))
           (t (setq lab (cons arg nil))
              (push (%rplacd lab lab) %read-objects%)
              (setq form (read stream t nil t))
              (when (eq form lab)   ;#n= #n#.  No can do.
                (%err-disp $xnordlbl (%car lab)))
              (%rplacd lab form)
              (with-managed-allocation
                (let ((scanned nil))
                  (labels ((circle-subst (tree)
                             (if (memq tree %read-objects%)
                               (progn
                                 (unless (memq tree scanned)
                                   (setq scanned (%temp-cons tree scanned))
                                   (circle-subst (cdr tree)))
                                 (cdr tree))
                               (let ((gvectorp (and (gvectorp tree) #+ppc-target (not (or (symbolp tree) (functionp tree))))))
                                 (unless (or (and (atom tree) (not gvectorp)) (memq tree scanned))
                                   (setq scanned (%temp-cons tree scanned))
                                   (if gvectorp
                                     (let* ((subtype #-ppc-target (%vect-subtype tree)
                                                     #+ppc-target (ppc-typecode tree)))
                                       (dotimes (i (uvsize tree))
                                         (declare (fixnum i))
                                         (unless (and (eql i CCL::INSTANCE.CLASS-WRAPPER) (eql subtype 
                                                                     #-ppc-target $v_instance
                                                                     #+ppc-target ppc::subtag-instance))
                                           (setf (uvref tree i) (circle-subst (uvref tree i))))))
                                     (locally 
                                      (declare (type cons tree))
                                      (rplaca tree (circle-subst (car tree)))
                                      (rplacd tree (circle-subst (cdr tree))))))
                                 tree))))
                    (declare (dynamic-extent #'circle-subst))
                    (circle-subst form))))))))



#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
