;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  5 6/7/96   akh  dont remember
;;  4 5/20/96  akh  read-line-raw from Shannon Spires
;;  3 11/9/95  akh  fix read-line-raw again
;;  2 10/17/95 akh  merge patches
;;  2 4/28/95  akh  fix string-to-extended-string for non simple-string
;;  2 3/2/95   akh  string-output-stream will promote string to fat if necessary
;;  (do not edit before this line!!)

; streams.lisp
; Copyright 1986-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

(in-package :ccl)

; Modification History
;
; stream-close :after ((stream broadcast-stream)) - dont close dest streams - from Terje N. & X3J13
; read-line-raw uses char-eolp or buffer-forward-find-eol
;; ------- 5.1 final
; ss - default read-line-raw method now respects *linefeed-equals-newline*
; instance-initialize -> initialize-instance
; ------- 5.1b1
; stream-read-sequence for input-file-stream and unix files (ugh)
;--------- 5.0b3
; akh - do e.g. (require-type xxx (load-time-value `(integer 0 ,most-positive-fixnum))) vs consing or #.
; ------ 4.3.1b??
; 01/26/00 akh stream-write-string for file - don't lose column when *print-pretty* t - mucho expensive
; 12/14/99 akh read-byte does signal-eof-error vs signal-file-error
; 12/12/99 akh broadcast-stream wants output-streams and concatenated wants input-streams
;             two-way-stream wants one input and one output
; ---------- 4.3f1c1
; 06/17/99 akh stream-write-string for broadcast-stream from Terje N.
;-------- 4.3b2
; 05/12/99 akh stream-write-string for output-file-stream - check for negative start, had a bug re offset too.
; 04/05/99 akh stream-read/write-sequence methods for t to signal type-error vs no applicable method
;----------- 4.3b1
; 02/26/99 akh stream-clear-output for broadcast-stream from Terje N.
; 08/12/98 akh stream-write-byte for broadcast-stream from Terje N.
; 07/23/98 akh string-to-extended-string uses %copy-8-ivector-to-16-ivector for PPC
; 07/21/98 akh read-sequence, write-sequence and friends - use new opt arg to %fread/%fwrite when appropriate
; 07/13/98 akh read-line-raw from shannon spires - its a method now
; 07/04/98 akh read-sequence and write-sequence
; 03/10/97 bill Fix dribble-untyi
; ------------  4.0
; 4/27/95 slh   eof errors signal end-of-file
;06/21/93 alice truncating-string-stream element-type defaults to base-character
;04/27/93 bill indentation in read-line-raw
;11/20/92 gb   echo-stream/stream-tyi: don't echo NIL on EOF.
;------------- 2.0
;01/14/92 gb   READ-BYTE does eof processing; STREAM-READ-BYTE returns byte or NIL.
;              STREAM-WRITER is on output-binary-file-stream vice input-.
;12/10/91 alice %err-disp => signal-file-error !&!%*!!!!
;-------------- 2.0b4
;11/04/91 bill stream-reader & stream-writer for binary-file-stream's
;10/11/91 gb   changes for new l1-sysio.
;09/19/91 alice define stream-column for broadcast stream, synonym-stream, and two-way-stream 
;------------- 2.0b3
;07/21/91 gb   READ-BYTE isn't generic, STREAM-READ-BYTE is.
;06/12/91 bill GB's fix to DEFCLASS for input-binary-file-stream & output-binary-file-stream
;------------- 2.0b2
;05/31/91 gb   (mostly) generalize binary streams.
;03/13/91 bill input-binary-file-stream, output-binary-file-stream, io-binary-file-stream
;03/05/91 alice report-bad-arg gets 2 args 
;--------------- 2.0b1
;01/22/91 bill in read-line - downward-function
;              in read-line-raw - speed up with stream-reader & stream-writer
;12/06/90 bill string-input-stream inherits from string-stream
;10/31/90 bill slot-makunbound takes two args.
;09/12/90 bill maybe-default-stream-reader/writer
;09/08/90 bill add stream-reader and stream-writer methods
;08/18/90 bill (method stream-write-string (truncating-string-stream t t t))
;08/17/90 bill (method stream-position (string-input-stream))
;08/02/90 gb   (partially ?) fix binary io problems.
;07/06/90 bill Remove &allow-other-keys from instance-initialize
;03/20/90 bill initialize-instance => instance-initialize
;12/29/89 gz   Made read-line go thru stream-rubout-handler.
;              Added stream-filename method for synonym streams, so
;              pathname will work on them per x3j13/PATHNAME-STREAM.
;12/22/89 gb   prinX-to-string were (identically) defined in l1-io.lisp.
;12/21/89 gz   added some readers per STREAM-ACCESS issue.
;09/16/89 bill Remove the last vestiges of object-lisp windows
;09/15/89 bill remove object-lisp
;8/20/89  gb   typo in (initialize-instance :after ((stream binary-file-stream)) ...)
;03/10/89 gz   CLOSified somewhat.  assume tyi/tyo deal in chars.
;01/10/89 gb   Try a different approach in READ-CHAR. Flush INPUT-STREAM-ARG,
;              OUTPUT-STREAM-ARG.
;12/30/88 gz   Flushed stream-has-file-p.  See stream-pathname in l1-files.
;              macro -> defmacro. input-stream-arg is in level-1.
;11/24/88 gb   read-line assumes tream-tyi returns characters.
;11/08/88 gb   truncating-string-stream mods.
; 8/17/88 gz   libfasl -> require
; 6/22/88 jaj  check to make sure args are strings in make-broadcast-stream
;              read-byte works for weird byte sizes
; 6/01/88 as   truncating-string-streams throw to :truncate on overflow

; 3/02/88  gz  Lots of declarations.
; 2/16/88 jaj  define %draw-cell-string-stream here
; 2/01/88 as   truncating-string-streams fixed slightly
; 1/29/88 as   make-truncating-string-stream has optional re-use-string arg
; 1/25/88 cfry fixed (stream-untyi *string-input-stream*) to error correctly
; 12/17/87 cfry fixed read-from-string and (exist *string-input-stream*)
;               as per AS patch for defaultingand checking the END arg.
; 12/11/87 cfry fixed read-line, read-char, unread-char, peek-char,
;             read-char-no-hang for T and NIL input streams.
;             fixed finish-output and force-output for T and NIL output streams
; 8/05/87 jaj wrap objvar around reference to index in with-input-from-string.
; 8/04/87 gz made read-line, read-char, peek-char, read-char-no-hang ignore
;            recursive-p again, as per the ISI test suite and a more careful
;            reading of CLtL...
; 8/04/87 jaj added "-iv" to variables: byte-size, length, stream-element-type
; 8/03/87 jaj made all of these streams double-closable
; 7/31/87 gb  bounds-check start, end args in read-from-string.
; 7/18/87 gz  added *truncating-string-stream*
; 7/13/87 jaj init-lists use keywords
; 7/1/87  gz  new exist arg scheme. Use defobject.
; 6/30/87 gz  use recursive-p in read-line, read-char, peek-char, read-char-no-hang.
; 6/21/87 am  removed COPY-FILE FILE-WRITE-DATE. new defs in L1.
; 6/21/87 gb  moved streamp, string-output-stream functions to l1-streams.
; 6/19/87 gb  %have -> have.
; 6/17/87 cfry fixed stream-peek again. Did somebody change stream-untyi out
;              from under me?
; 6/09/87 gz  &aux bits-to-go, size in write-byte. put 'version.
; 6/8/87 cfry fixed stream-peek and peek-char
; 5/20/87 gz  init-list-extract -> getf
; 4/15/87 am stream-has-file-p has changed.
; 4/12/87  cfry fixed read-line bug with value returned upon eof
;               same bug in peek-char, read-char-no-hang
;04/09/87 am  removed inoperative write-to-string. Added stream-has-file-p.
;3/31/87   gz   added libfasl alltraps.
;               class -> class-name
;3/30/87   gz   made macros take an env arg, pass it to parse-body.
;03/24/87  gz   no libfasl makearray (in level-1 now)
;               %ilsl -> ash in file-write-date to avoid losing hi bits.
;03/13/87  jaj  he put in a fresh-line  for string-streams + the function 
;               column for string-streams, + a dummy column for *streams*

;;;General io-functions

(eval-when (:execute :compile-toplevel)
  (require :level-2)
  (require :streams)
  (require :backquote)
  
  (defmacro signal-eof-error (stream)
    `(error 'end-of-file :stream ,stream))  
  )

(defun read-line (&optional input-stream (eof-error-p t) eof-value recursive-p)
  (declare (ignore recursive-p))
  (let* ((temp #'(lambda (stream) (read-line-raw stream eof-error-p eof-value))))
    (declare (dynamic-extent temp))
    (stream-rubout-handler (cond ((null input-stream) *standard-input*)
                                 ((eq input-stream t) *terminal-io*)
                                 (t input-stream))
                           temp)))

; from Shannon Spires slightly modified - its a method now
(defmethod read-line-raw ((input-stream t) eof-error-p eof-value)
    "A faster way to do read-line-raw than that in streams.lisp. The speedup
     comes from avoiding with-output-to-string. Conses less too."
    (declare (optimize (speed 3) (safety 1)))
    (if (stream-eofp input-stream)
      (if eof-error-p
        (signal-eof-error input-stream)
        (values eof-value (or eof-value t)))
      (let ((char nil)
            (str (make-array 20
                             :element-type 'base-character
                             :adjustable t :fill-pointer 0)))
        (multiple-value-bind (reader reader-arg) (stream-reader input-stream)
          (while (and (setq char (funcall reader reader-arg))
                      (not (char-eolp char))) ;(neq char #\newline))
            (when (and (not (base-character-p char))(base-string-p str))
              (setq str (string-to-extended-string str)))
            (vector-push-extend char str)))
        (values str (null char)))))

;; another from more recent from Shannon Spires - red stuff again
(defmethod read-line-raw ((input-stream buffer-stream) eof-error-p eof-value)
  (declare (optimize (speed 3) (safety 1)))
  (if (stream-eofp input-stream)
    (if eof-error-p
      (signal-eof-error input-stream)
      (values eof-value (or eof-value t)))
    (let* (;(str (make-string 1 :initial-element #\newline))
           ;(buffer (fred-buffer input-stream))
           (mark (buffer-mark input-stream))
           (startpos (buffer-position mark))
           (nextpos (buffer-forward-find-eol mark startpos))
           )
      (if nextpos
        (multiple-value-prog1
          (values (buffer-substring mark (%i- nextpos 1)) nil)
          (%set-mark mark nextpos)
          )
        (multiple-value-prog1
          (values (buffer-substring mark t) t)
          (%set-mark mark (buffer-position mark t))
          )
        )
      )))

(defmethod read-line-raw ((input-stream fred-item) eof-error-p eof-value)
  (declare (optimize (speed 3) (safety 1)))
  (if (stream-eofp input-stream)
    (if eof-error-p
      (signal-eof-error input-stream)
      (values eof-value (or eof-value t)))
    (let* (;(str (make-string 1 :initial-element #\newline))
           (mark (fred-buffer input-stream))
           ;(mark (buffer-mark buffer))
           (startpos (buffer-position mark))
           (nextpos (buffer-forward-find-eol mark startpos))
           )
      (if nextpos
        (multiple-value-prog1
          (values (buffer-substring mark (%i- nextpos 1)) nil)
          (%set-mark mark nextpos)
          )
        (multiple-value-prog1
          (values (buffer-substring mark t) t)
          (%set-mark mark (buffer-position mark t))
          )
        )
      )))

(defmethod read-line-raw ((input-stream fred-delegation-mixin) eof-error-p eof-value)
  (read-line-raw (fred-item input-stream) eof-error-p eof-value))

(defun read-char (&optional input-stream (eof-error-p t) eof-value recursive-p)
  (declare (ignore recursive-p))
  (if input-stream
    (if (eq t input-stream) (setq input-stream *terminal-io*))
    (setq input-stream *standard-input*))
  (or (stream-tyi input-stream)
      (if eof-error-p
        (signal-eof-error input-stream)
        eof-value)))


(defun unread-char (char &optional input-stream)
  (if input-stream
    (if (eq t input-stream) (setq input-stream *terminal-io*))
    (setq input-stream *standard-input*))
  (stream-untyi input-stream char)
  nil)

(defun peek-char (&optional peek-type input-stream
                            (eof-error-p t) eof-value recursive-p &aux char)
  (declare (ignore recursive-p))
  (if input-stream
    (if (eq t input-stream) (setq input-stream *terminal-io*))
    (setq input-stream *standard-input*))
  (cond ((null peek-type)
         (or (stream-peek input-stream)
             (if eof-error-p
               (signal-eof-error input-stream)
               eof-value)))
        ((eq peek-type t)
         (while (and (setq char (stream-tyi input-stream)) (whitespacep char)))
         (if (null char)
           (if eof-error-p 
             (signal-eof-error input-stream)
             (return-from peek-char eof-value)))
         (stream-untyi input-stream char)
         char)
        ((characterp peek-type)
         (while (and (setq char (stream-tyi input-stream)) (neq char peek-type)))
         (if (null char)
           (if eof-error-p
             (signal-eof-error input-stream)
             (return-from peek-char eof-value)))
         (stream-untyi input-stream char)
         char)
        (t (report-bad-arg peek-type '(or character (member nil t))))))

(defun read-char-no-hang (&optional input-stream (eof-error-p t) eof-value recursive-p)
  (declare (ignore recursive-p))
  (if input-stream
    (if (eq t input-stream) (setq input-stream *terminal-io*))
    (setq input-stream *standard-input*))
  (if (stream-eofp input-stream)
    (if eof-error-p
      (signal-eof-error input-stream)
      (return-from read-char-no-hang eof-value)))
  (if (stream-listen input-stream) (stream-tyi input-stream)))


;;;;;;;;;;;; OUTPUT STREAMS

(defun clear-output (&optional stream)
  (if stream
    (if (eq stream t) (setq stream *terminal-io*))
    (setq stream *standard-output*))
  (stream-clear-output stream))

(defun finish-output (&optional stream)
  (if stream
    (if (eq stream t) (setq stream *terminal-io*))
    (setq stream *standard-output*))
  (stream-finish-output stream))

(defun column (&optional stream)
  (if stream
    (if (eq stream t) (setq stream *terminal-io*))
    (setq stream *standard-output*))
  (stream-column stream))

;;;Binary Streams

;This stuff needs work.  Also, I don't think the MOD is meant the way this
;takes it...

(defclass binary-stream (stream) ())

(defclass input-binary-stream (binary-stream input-stream) ())
(defclass output-binary-stream (binary-stream output-stream) ())
(defclass io-binary-stream (input-binary-stream output-binary-stream) ())


(defun read-byte (stream &optional (eof-error-p t) eof-value)
  (or (stream-read-byte stream)
      (if eof-error-p 
        (signal-eof-error stream) ;(signal-file-error $eoferr stream)
        eof-value)))

;Until we can specialize the second arg...
(defun write-byte (integer stream)
  (stream-write-byte stream integer)
  integer)


;;; Binary file streams.
(defclass binary-file-stream (binary-stream file-stream) ())
(defclass input-binary-file-stream (input-binary-stream input-file-stream) ())
(defclass output-binary-file-stream (output-binary-stream output-file-stream) ())
(defclass io-binary-file-stream (input-binary-file-stream output-binary-file-stream) ())

(defmethod stream-write-byte ((stream output-binary-file-stream) integer)
  (%fwrite-byte (slot-value stream 'fblock) integer))

(defmethod stream-read-byte ((stream input-binary-file-stream))
  (%fread-byte (slot-value stream 'fblock)))

(defvar *input-binary-file-stream-class* (find-class 'input-binary-file-stream))
(defvar *output-binary-file-stream-class* (find-class 'output-binary-file-stream))

(defmethod stream-reader ((stream input-binary-file-stream))
  (maybe-default-stream-binary-reader (stream *input-binary-file-stream-class*)
    (values #'%fread-byte (slot-value stream 'fblock))))

(defmethod stream-writer ((stream output-binary-file-stream))
  (maybe-default-stream-binary-writer (stream *output-binary-file-stream-class*)
    (values #'%fwrite-byte (slot-value stream 'fblock))))

;;;General stream functions
(defmethod stream-peek ((stream stream) &aux char)
  (when (setq char (stream-tyi stream))
    (stream-untyi stream char)
    char))

(defmethod stream-column ((stream stream)) 0)

(defmethod stream-clear-output ((stream output-stream)) ())

(defmethod stream-finish-output ((stream output-stream))
  (stream-force-output stream))


;;;String input streams

(defclass string-input-stream (string-stream input-stream)
  ((my-string :initarg :string)
   (index :initarg :start :initform nil)
   (end :initarg :end :initform nil)))

(defmethod initialize-instance :after ((stream string-input-stream) &key)
  (let* ((string (require-type (slot-value stream 'my-string) 'string))
         (index (or (slot-value stream 'index) 0))
         (end (or (slot-value stream 'end) (length string))))
    (unless (<= 0 end (length string)) (error "End ~S not between 0 and length ~S" end (length string)))
    (unless (<= 0 index end) (error "Index ~S not between 0 and end ~S" index end))
    (set-slot-value stream 'my-string string)
    (set-slot-value stream 'index index)
    (set-slot-value stream 'end end)))

(defmethod stream-tyi ((stream string-input-stream))
  (let ((idx (slot-value stream 'index)))
    (when (%i< idx (slot-value stream 'end))
      (set-slot-value stream 'index (%i+ idx 1))
      (elt (slot-value stream 'my-string) idx))))

(defmethod stream-untyi ((stream string-input-stream) char)
  (let ((index (1- (slot-value stream 'index))))
    (when (< index 0)
      (error "Attempt to unread past beginning of string stream."))
    (unless (eq char (aref (slot-value stream 'my-string) index))
      (error "Attempt to unread illegal char ~S" char))
    (set-slot-value stream 'index index)))

(defmethod stream-eofp ((stream string-input-stream))
  (eq (slot-value stream 'index) (slot-value stream 'end)))

(defmethod stream-close :after ((stream string-input-stream))
  (slot-makunbound stream 'my-string))

(defmethod stream-position ((stream string-input-stream) &optional new-position)
  (if new-position
    (setf (slot-value stream 'index) new-position)
    (slot-value stream 'index)))

(defun make-string-input-stream (string &optional start end)
  (make-instance 'string-input-stream :string string :start start :end end))

(defmacro with-input-from-string ((var string &rest args) &body body
                                  &environment env)
  (let (place skeys)
    (do ((keys args (cddr keys))) ((null keys))
      (when (null (cdr keys)) (signal-program-error "Odd number of args in ~S" args))
      (case (car keys)
        (:index (setq place (cadr keys)))
        ((:start :end) (setq skeys (list* (cadr keys) (car keys) skeys)))
        (t (signal-program-error "~S should be (member :index :start :end)" (car keys)))))
    (multiple-value-bind (forms decls) (parse-body body env nil)
      `(let ((,var (make-instance 'string-input-stream :string ,string
                                  ,@(nreverse skeys))))
         ,@decls
         (unwind-protect
           ,(if place
              `(prog1
                (progn ,@forms)
                (setf ,place (slot-value ,var 'index)))
              `(progn ,@forms))
           (close ,var))))))

;;

(defmacro with-open-stream ((var stream) &body body &aux (svar (gensym)))
  `(let (,svar)
     (unwind-protect
       (let ((,var (setq ,svar ,stream)))
         ,@body)
       (when ,svar (close ,svar)))))

(defun input-stream-p (thing)
  (and (streamp thing)
       (memq (stream-direction thing) '(:io :input))))

(defun output-stream-p (thing)
  (and (streamp thing)
       (memq (stream-direction thing) '(:io :output))))

; what is this for?
(defmethod stream-element-type ((stream stream)) 'base-character)

;;;synonym-streams

(defclass synonym-stream (stream)
  ((stream-symbol :initarg :symbol :reader synonym-stream-symbol)))

(defun make-synonym-stream (symbol)
  (make-instance 'synonym-stream :symbol symbol))

;we really need delegation for these puppies

(defmethod stream-direction ((stream synonym-stream))
  (stream-direction (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-column ((stream synonym-stream))
  (stream-column (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-element-type ((stream synonym-stream))
  (stream-element-type (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-tyo ((stream synonym-stream) char)
  (stream-tyo (symbol-value (synonym-stream-symbol stream)) char))

(defvar *synonym-stream-class* (find-class 'synonym-stream))

(defmethod stream-writer ((stream synonym-stream))
  (maybe-default-stream-writer (stream *synonym-stream-class*)
    (values #'(lambda (symbol char)
                (stream-tyo (symbol-value symbol) char))
            (synonym-stream-symbol stream))))

(defmethod stream-tyi ((stream synonym-stream))
  (stream-tyi (symbol-value (synonym-stream-symbol stream))))

(defmethod stream-reader ((stream synonym-stream))
  (maybe-default-stream-reader (stream *synonym-stream-class*)
    (values #'(lambda (symbol) (stream-tyi (symbol-value symbol)))
            (synonym-stream-symbol stream))))

(defmethod stream-untyi ((stream synonym-stream) char)
  (stream-untyi (symbol-value (slot-value stream 'stream-symbol)) char))

(defmethod stream-eofp ((stream synonym-stream))
  (stream-eofp (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-force-output ((stream synonym-stream))
  (stream-force-output (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-finish-output ((stream synonym-stream))
  (stream-finish-output (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-close :after ((stream synonym-stream))
  (when (slot-boundp stream 'stream-symbol)
    (stream-close (symbol-value (slot-value stream 'stream-symbol)))
    (slot-makunbound stream 'stream-symbol)))

(defmethod stream-fresh-line ((stream synonym-stream))
  (stream-fresh-line (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-clear-input ((stream synonym-stream))
  (stream-clear-input (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-listen ((stream synonym-stream))
  (stream-listen (symbol-value (slot-value stream 'stream-symbol))))

(defmethod stream-filename ((stream synonym-stream))
  (stream-filename (symbol-value (slot-value stream 'stream-symbol))))

;;;broadcast-streams

(defclass broadcast-stream (output-stream)
  ((streams :initarg :streams :reader broadcast-stream-streams)))

(defun make-broadcast-stream (&rest streams)
  (make-instance 'broadcast-stream :streams streams))

(defmethod initialize-instance :after ((stream broadcast-stream) &key)
  (dolist (stream (slot-value stream 'streams))
    (unless (output-stream-p stream)
      (signal-type-error stream 'output-stream))))

(defmethod stream-tyo ((stream broadcast-stream) char)
  (dolist (stream (slot-value stream 'streams))
    (stream-tyo stream char)))

(defmethod stream-write-byte ((stream broadcast-stream) integer)
  (dolist (stream (slot-value stream 'streams))
    (stream-write-byte stream integer)))

(defvar *broadcast-stream-class* (find-class 'broadcast-stream))

(defmethod stream-column ((stream broadcast-stream))
  (let ((streams (slot-value stream 'streams)))
    (if streams (stream-column (car streams)) 0)))

#|
(defmethod stream-writer ((stream broadcast-stream))
  (maybe-default-stream-writer (stream *broadcast-stream-class*)
    (values #'(lambda (streams char)
              (dolist (stream streams)
                (stream-tyo stream char)))
          (slot-value stream 'streams))))
|#
(defmethod stream-writer ((stream broadcast-stream))
  (call-next-method))


(defmethod stream-force-output ((stream broadcast-stream))
  (dolist (stream (slot-value stream 'streams))
    (stream-force-output stream)))

(defmethod stream-finish-output ((stream broadcast-stream))
  (dolist (stream (slot-value stream 'streams))
    (stream-finish-output stream)))

(defmethod stream-fresh-line ((stream broadcast-stream))
  (dolist (stream (slot-value stream 'streams))
    (stream-fresh-line stream)))

(defmethod stream-close :after ((stream broadcast-stream))
  (when (slot-boundp stream 'streams)
    ;(dolist (stream (slot-value stream 'streams)) (stream-close stream))
    (slot-makunbound stream 'streams)))

(defmethod stream-clear-output ((stream broadcast-stream))
  (dolist (stream (slot-value stream 'streams))
    (stream-clear-output stream)))

(defmethod stream-write-string ((stream broadcast-stream) string start end)
  (dolist (stream (slot-value stream 'streams))
    (stream-write-string stream string start end)))

;;;concatenated-streams

(defclass concatenated-stream (input-stream)
  ((streams :initarg :streams :reader concatenated-stream-streams)))

(defun make-concatenated-stream (&rest streams)
  (make-instance 'concatenated-stream :streams streams))

(defmethod initialize-instance :after ((stream concatenated-stream) &key)
  (dolist (stream (slot-value stream 'streams))
    (unless (input-stream-p stream)
      (signal-type-error stream 'input-stream))))

(defmethod stream-tyi ((stream concatenated-stream))
  (let ((streams (slot-value stream 'streams)))
    (when streams
      (or (stream-tyi (car streams))
          (progn
            (set-slot-value stream 'streams (%cdr streams))
            (stream-close (%car streams))
            (stream-tyi stream))))))

(defmethod stream-listen ((stream concatenated-stream))
  (let ((streams (slot-value stream 'streams)))
    (when streams
      (or (stream-listen (car streams))
          (and (stream-eofp (car streams))
               (progn
                 (set-slot-value stream 'streams (%cdr streams))
                 (stream-close (%car streams))
                 (stream-listen stream)))))))

(defmethod stream-untyi ((stream concatenated-stream) char)
  (stream-untyi (car (slot-value stream 'streams)) char))

(defmethod stream-eofp ((stream concatenated-stream))
  (let ((streams (slot-value stream 'streams)))
    (or (null streams) (every #'stream-eofp streams))))

(defmethod stream-close :after ((stream concatenated-stream))
  (when (slot-boundp stream 'streams)
    (stream-clear-input stream)
    (slot-makunbound stream 'streams)))

(defmethod stream-clear-input ((stream concatenated-stream))
  (let ((streams (slot-value stream 'streams)))
    (while streams
      (set-slot-value stream 'streams (cdr streams))
      (stream-close (pop streams)))))

;;

(defclass two-way-stream (input-stream output-stream)
  ((input-stream :initarg :input-stream :reader two-way-stream-input-stream)
   (output-stream :initarg :output-stream :reader two-way-stream-output-stream)))

(defun make-two-way-stream (input-stream output-stream)
  (make-instance 'two-way-stream
                 :input-stream input-stream :output-stream output-stream))

(defmethod initialize-instance :after ((stream two-way-stream) &key)
  (let ((in (two-way-stream-input-stream stream)))
    (when (not (input-stream-p in))
      (signal-type-error in 'input-stream)))
  (let ((out (two-way-stream-output-stream stream)))
    (when (not (output-stream-p out))
      (signal-type-error out 'output-stream))))
  

(defmethod stream-tyo ((stream two-way-stream) char)
  (stream-tyo (slot-value stream 'output-stream) char))

(defvar *two-way-stream-class* (find-class 'two-way-stream))

(defmethod stream-column ((stream two-way-stream))
  (stream-column (slot-value stream 'output-stream)))

(defmethod stream-writer ((stream two-way-stream))
  (maybe-default-stream-writer (stream *two-way-stream-class*)
    (stream-writer (slot-value stream 'output-stream))))

(defmethod stream-tyi ((stream two-way-stream))
  (stream-tyi (slot-value stream 'input-stream)))

(defmethod stream-reader ((stream two-way-stream))
  (maybe-default-stream-reader (stream *two-way-stream-class*)
    (stream-reader (slot-value stream 'input-stream))))

(defmethod stream-untyi ((stream two-way-stream) char)
  (stream-untyi (slot-value stream 'input-stream) char))

(defmethod stream-eofp ((stream two-way-stream))
  (stream-eofp (slot-value stream 'input-stream)))

(defmethod stream-force-output ((stream two-way-stream))
  (stream-force-output (slot-value stream 'output-stream)))

(defmethod stream-finish-output ((stream two-way-stream))
  (stream-finish-output (slot-value stream 'output-stream)))

(defmethod stream-close :after ((stream two-way-stream))
  (slot-makunbound stream 'input-stream)
  (slot-makunbound stream 'output-stream))

(defmethod stream-fresh-line ((stream two-way-stream))
  (stream-fresh-line (slot-value stream 'output-stream)))

(defmethod stream-clear-input ((stream two-way-stream))
  (stream-clear-input (slot-value stream 'input-stream)))

(defmethod stream-listen ((stream two-way-stream))
  (stream-listen (slot-value stream 'input-stream)))

;;;echo streams

(defclass echo-stream (two-way-stream)
  ((untyip :initform nil)))

(defmethod echo-stream-input-stream ((stream echo-stream))
  (slot-value stream 'input-stream))

(defmethod echo-stream-output-stream ((stream echo-stream))
  (slot-value stream 'output-stream))

(defun make-echo-stream (input-stream output-stream)
  (make-instance 'echo-stream
                 :input-stream input-stream :output-stream output-stream))

(defmethod stream-tyi ((stream echo-stream))
  (let ((char (stream-tyi (slot-value stream 'input-stream))))
    (if (slot-value stream 'untyip)
      (set-slot-value stream 'untyip nil)
      (if char
        (stream-tyo (slot-value stream 'output-stream) char)))
    char))

(defmethod stream-untyi ((stream echo-stream) char)
  (stream-untyi (slot-value stream 'input-stream) char)
  (set-slot-value stream 'untyip t))

(defmethod stream-clear-input :after ((stream echo-stream))
  (set-slot-value stream 'untyip nil))


;;; from i/o chapter of steele
;;; Ever notice that -much- of this code is from the i/o chapter
;;; of steele ?  Strange but true ...

(defun read-from-string (string &optional (eof-error-p t) eof-value
                                &key (start 0) end preserve-whitespace
                                &aux idx)
  (values
   (with-input-from-string (stream string :index idx :start start :end end)
     (if preserve-whitespace
       (read-preserving-whitespace stream eof-error-p eof-value)
       (read stream eof-error-p eof-value)))
   idx))

;;; Reusable truncating string stream.  Like string-output-stream but throws
;;; to :truncate rather than extending.

(defclass truncating-string-stream (string-output-stream) ())

(defun make-truncating-string-stream (length)
  (make-instance 'truncating-string-stream
                 :string (make-array length :element-type 'base-character :fill-pointer 0)))

; extend if need to
(defmethod stream-tyo ((stream truncating-string-stream) char)
  (when (and (extended-character-p char))
    (let ((output-string (string-output-stream-string stream)))
      (when (base-string-p output-string)
        (setq output-string (string-to-extended-string output-string))
        (setf (string-output-stream-string stream) output-string))))
  (unless (vector-push char (string-output-stream-string stream))
    (throw :truncate stream)))

#|
(setq x (make-string-output-stream))
(stream-tyo x #\444)  ; should promote the string to fat per below
(stream-tyo x #\445)
(setq s (get-output-stream-string x))
|#


#-ppc-target
(defun string-to-extended-string (string)
  (multiple-value-bind (array offset)(array-data-and-offset string)
    (let ((len (- (length array) offset)))
      (let ((new-string
             (make-array len :element-type 'extended-character                  
                         :fill-pointer (if (array-has-fill-pointer-p string) (length string))
                         :adjustable (adjustable-array-p string))))
        (multiple-value-bind (narray noffset)(array-data-and-offset new-string)
          (declare (type simple-extended-string narray)
                   (optimize (speed 3)(safety 0)))
          (dotimes (i (length string))
            (setf (schar narray (%i+ i noffset))(schar array (%i+ i offset))))
          new-string)))))


#+ppc-target 
(defun string-to-extended-string (string)
  (multiple-value-bind (array offset)(array-data-and-offset string)
    (let ((len (- (length array) offset)))
      (let ((new-string
             (make-array len :element-type 'extended-character                  
                         :fill-pointer (if (array-has-fill-pointer-p string) (length string))
                         :adjustable (adjustable-array-p string))))
        (multiple-value-bind (narray noffset)(array-data-and-offset new-string)
          (%copy-8-ivector-to-16-ivector array offset narray noffset (length string)))
        new-string))))




; had a bug - extended the wrong string
(defmethod stream-write-string ((stream truncating-string-stream) string start end)
  (let ((output-string (string-output-stream-string stream)))
    (multiple-value-bind (array offset) (array-data-and-offset string)
      (incf end offset)
      (do ((i (+ start offset) (1+ i)))
          ((>= i end))
        (let ((char (uvref array i)))
          (when (and (extended-character-p char)
                     (base-string-p output-string))
            (setq output-string (string-to-extended-string output-string))
            (setf (string-output-stream-string stream) output-string))
          (unless (vector-push char output-string)
            (throw :truncate stream))))))
  string)

(defparameter %draw-cell-string-stream (make-truncating-string-stream 255))

;;;File Stuff here

(defvar *dribble-untyiedp*)

(defun dribble (&optional filename)
  (if *dribble-stream* (close *dribble-stream*))
  (setq *dribble-stream* 
     (if filename
         (open filename :direction :output :if-exists :append 
                        :if-does-not-exist :create)))
  (setq *dribble-untyiedp* nil)
  *dribble-stream*)

(defun dribble-tyi (char)
  (if *dribble-untyiedp*
      (setq *dribble-untyiedp* nil)
      (stream-tyo *dribble-stream* char)))

(defun dribble-untyi ()
  (setq *dribble-untyiedp* t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; read/write sequence

(eval-when (:compile-toplevel :load-toplevel :execute)
  (intern "READ-SEQUENCE" :common-lisp)
  (intern "WRITE-SEQUENCE" :common-lisp)
  (export '(common-lisp::read-sequence common-lisp::write-sequence) :common-lisp))
  



(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(stream-write-sequence stream-read-sequence)
          :ccl))



(defun write-sequence (sequence stream &rest keys &key (start 0) end)
  (declare (dynamic-extent keys))
  (declare (ignore end start))
  (apply 'stream-write-sequence stream sequence keys))

(defun read-sequence (sequence stream &rest keys &key (start 0) end)
  (declare (dynamic-extent keys))
  (declare (ignore end start))
  (apply 'stream-read-sequence stream sequence keys))



(defmethod stream-write-sequence ((stream output-file-stream) (sequence base-string)
                                  &key (start 0)(end (length sequence)))
  (if (null end) 
    (setq end (length sequence))
    (progn
      (setq end (require-type end (load-time-value `(integer 0 ,most-positive-fixnum))))
      (if (> (the fixnum end) (the fixnum (length sequence))) (error "End ~s should be <= ~s" end (length sequence)))))
  (setq start (require-type start (load-time-value `(integer 0 ,most-positive-fixnum))))
  (locally (declare (fixnum start end))
    (if (> start end)(error "Start ~s should be <= end ~S" start end))
    (multiple-value-bind (data offset)(array-data-and-offset sequence)
      (declare (fixnum offset)(type simple-base-string data))
      (let ((stream-elt-type (stream-element-type stream)))
        ;; should this check the writer too? like stream-write-string does
        ;; Given its a base-string its really OK to blast it to a scripted file-stream but not to a binary stream
        (multiple-value-bind (writer arg)(stream-writer stream)          
          (if (and (or (eq writer #'file-stream-tyo)(eq writer #'script-file-stream-tyo))
                   (eq stream-elt-type 'base-character))         
            (progn
              (let ((column.fblock (column.fblock stream)))                
                ;; note we have lost track of column
                (%rplaca column.fblock nil)
                (%fwrite-from-vector (%cdr column.fblock) data 
                                     (the fixnum (+ offset start))  (the fixnum (- end start))
                                     t))) 
            ;; the writer should error if stream class is wrong.
            (let* ((start (+ start offset))
                   (end (+ end offset)))
              (declare (fixnum start end))
              (do* ((i start (1+ i)))
                   ((>= i end))
                (declare (fixnum i))
                (funcall writer arg (schar data i)))))))))
  sequence)





(defun 8-bit-typep (thing)
  (or (eq thing 'base-character)
      ;(eq thing 'character)  ;; not really right ya know
      (and  (consp thing)
            (case (car (the list thing))
              ((signed-byte unsigned-byte) t))
            (eql (cadr (the list thing)) 8))))

(defmethod stream-write-sequence ((stream output-binary-file-stream) (sequence vector)
                                  &key (start 0)(end (length sequence)))
  (if (null end) 
    (setq end (length sequence))
    (progn
      (setq end (require-type end (load-time-value `(integer 0 ,most-positive-fixnum))))
      (if (> (the fixnum end) (the fixnum (length sequence))) (error "End ~s should be <= ~s" end (length sequence)))))
  (setq start (require-type start (load-time-value `(integer 0 ,most-positive-fixnum))))
  (locally (declare (fixnum start end))
    (if (> start end)(error "Start ~s should be <= end ~S" start end))
    (multiple-value-bind (data offset)(array-data-and-offset sequence)
      (declare (fixnum offset))
      (setq start (+ start offset))
      (setq end (+ end offset))
      (let* ((elt-type (array-element-type sequence))
             (fblock (slot-value stream 'fblock)))
        ;; signed-byte 8 is OK too.
        (if (and (8-bit-typep elt-type)(equal (stream-element-type stream) elt-type))
          ;(= 8 (the fixnum (fblock.nbits-per-element fblock))))
          (%fwrite-from-vector fblock data start (the fixnum (- end start)))
          (multiple-value-bind (writer arg)(stream-writer stream)
            (do* ((i start (1+ i)))
                 ((%i>= i end))
              (declare (fixnum i))
              ;; %fwrite-byte will error if not number within limits
              (funcall writer arg  (uvref data i)))))))
  sequence))

(defmethod stream-write-sequence ((stream output-stream) (sequence string)
                                  &key (start 0)(end (length sequence)))
  (if (null end) 
    (setq end (length sequence)))  
  (stream-write-string stream sequence start end)
  sequence)

(defmethod stream-write-sequence ((stream output-stream) (sequence vector)
                                  &key (start 0)(end (length sequence)))
  (if (null end) 
    (setq end (length sequence))
    (progn
      (setq end (require-type end (load-time-value `(integer 0 ,most-positive-fixnum))))
      (if (> (the fixnum end) (the fixnum (length sequence))) (error "End ~s should be <= ~s" end (length sequence)))))  
  (setq start (require-type start (load-time-value `(integer 0 ,most-positive-fixnum))))
  (locally (declare (fixnum start end))
    (if (> start end)(error "Start ~s should be <= end ~S" start end))
    (multiple-value-bind (writer arg)(stream-writer stream)      
      (multiple-value-bind (data offset)(array-data-and-offset sequence)
        (declare (fixnum offset))
        (setq start (+ start offset))
        (setq end (+ end offset))
        ;; my goodness - stream-tyo doesn't care what the char is - weird huh - bug or feature?
        (do* ((i start (1+ i)))
             ((>= i end))
          (declare (fixnum i end))
          (funcall writer arg  (uvref data i)))))
    sequence))

(defmethod stream-write-sequence ((stream output-stream) (sequence list)
                                  &key (start 0) end)
  (setq start (require-type start (load-time-value `(integer 0 ,most-positive-fixnum))))
  (multiple-value-bind (writer arg)(stream-writer stream)
    (let ((tail (nthcdr start sequence)))
      (if end
        (progn
          (setq end (require-type end (load-time-value `(integer 0 ,most-positive-fixnum))))
          (dotimes (i (%i- end start))
            (declare (fixnum i))
            (funcall writer arg (pop tail))))
        (dolist (char tail)
          (funcall writer arg char)))))
  sequence)

(defmethod stream-write-sequence ((stream output-stream) thing
                                 &key (start 0) end)
  (declare (ignore start end))
  (sequence-type thing))

(defmethod stream-read-sequence ((stream input-script-file-stream) (sequence base-string) &key (start 0) (end (length sequence)))
  ;; punt
  (stream-read-string stream sequence start end nil))

(defmethod stream-read-sequence ((stream input-file-stream)(sequence base-string)
                                 &key (start 0)(end (length sequence)))
  (if (null end) 
    (setq end (length sequence))
    (progn
      (setq end (require-type end (load-time-value `(integer 0 ,most-positive-fixnum))))
      (if (> (the fixnum end) (the fixnum (length sequence))) (error "End ~s should be <=  ~s" end (length sequence)))))  
  (setq start (require-type start (load-time-value `(integer 0 ,most-positive-fixnum)))) 
  (locally (declare (fixnum start end))
    (let* ((chars-left (- (file-length stream)(file-position stream)))
           (chars-to-read (min chars-left (the fixnum (- end start)))))
      (declare (fixnum chars-left chars-to-read))
      (if (< chars-to-read 0)(error "Start ~s should be <= end ~S" start end))
      (setq end (min end chars-left))
      (multiple-value-bind (data offset)(array-data-and-offset sequence)
        (locally (declare (type simple-base-string data))            
          (if (neq (external-format stream) :unix)
            (let* ((fblock (slot-value stream 'fblock)))
              (%fread-to-vector fblock data (%i+ offset start) chars-to-read T))
            (multiple-value-bind (reader arg)(stream-reader stream)
              (let* ((start (+ start offset))
                     (end (+ start chars-to-read)))
                (declare (fixnum start end))
                (do* ((i start (1+ i)))
                     ((%i>= i end))
                  (declare (fixnum i))
                  (setf (%schar data i) (funcall reader arg))))))))                
      (%i+ start chars-to-read))))

(defmethod stream-read-sequence ((stream input-binary-file-stream) (sequence vector)
                                 &key (start 0)(end (length sequence)))
  (if (null end) 
    (setq end (length sequence))
    (progn
      (setq end (require-type end (load-time-value `(integer 0 ,most-positive-fixnum))))
      (if (> end (length sequence)) (error "End ~s should be <= ~s" end (length sequence)))))
  (setq start (require-type start (load-time-value `(integer 0 ,most-positive-fixnum))))
  (locally (declare (fixnum start end))
    (let* ((chars-left (- (file-length stream)(file-position stream)))
           (chars-to-read (min chars-left (the fixnum (- end start)))))
      (declare (fixnum chars-left chars-to-read))
      (if (< chars-to-read 0)(error "Start ~s should be <= end ~S" start end))
      (multiple-value-bind (data offset)(array-data-and-offset sequence)
        (declare (fixnum offset))
        (let* ((elt-type (array-element-type sequence))
               (fblock (slot-value stream 'fblock)))
          (if (and (8-bit-typep elt-type)(equal (stream-element-type stream) elt-type))
            (%fread-to-vector fblock data (+ offset start) chars-to-read)
            (multiple-value-bind (reader arg)(stream-reader stream)
              (let* ((start (+ start offset))
                     (end (+ start chars-to-read)))
                (declare (fixnum start end))
                (do* ((i start (1+ i)))
                     ((%i>= i end))
                  (declare (fixnum i))
                  ;; will get an error here if sequence is wrong type (e.g. string)
                  (setf (uvref data i) (funcall reader arg))))))))
    (%i+ start chars-to-read))))

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
               (end (+ end offset)))
          (declare (fixnum start end))
          (do* ((i start (1+ i)))
               ((or (%i>= i end)(stream-eofp stream)))
            (declare (fixnum i))
            (setf (uvref data i)(funcall reader arg))
            (incf chars-read)))))
    (%i+ start chars-read)))

(defmethod stream-read-sequence ((stream input-stream) (sequence list)
                                 &key (start 0) end)
  (if end (progn 
            (setq end (require-type end (load-time-value `(integer 0 ,most-positive-fixnum))))
            ;; is this check worth the trouble?? i.e. the call to length
            (if (> end (length sequence)) (error "End ~s should be <= ~s" end (length sequence)))))
  ;; we don't error if end provided and > length
  (setq start (require-type start (load-time-value `(integer 0 ,most-positive-fixnum))))
  (let ((chars-read 0)
        (chars-to-read (if end (- end start) most-positive-fixnum)))
    (declare (fixnum chars-read chars-to-read))
    (multiple-value-bind (reader arg)(stream-reader stream)
      (do* ((tail (nthcdr start sequence) (cdr tail)))
           ((or (if end (>= chars-read chars-to-read))(null tail)(stream-eofp stream)))
        (rplaca tail (funcall reader arg))
        (incf chars-read)))      
    (%i+ start chars-read)))

(defmethod stream-read-sequence ((stream input-stream) thing
                                 &key (start 0) end)
  (declare (ignore start end))
  ;; its an error
  (sequence-type thing))

(defmethod stream-read-sequence (stream thing &key start end)
  (declare (ignore start end thing))
  (report-bad-arg stream 'input-stream))

(defmethod stream-write-sequence (stream thing &key start end)
  (declare (ignore start end thing))
  (report-bad-arg stream 'output-stream))

(defmethod stream-write-string ((stream output-file-stream) string start end)
  (setq string (require-type string 'string))
  (setq start (require-type start 'fixnum))
  (setq end (require-type end 'fixnum))
  (let ((len (length string)))
    (declare (fixnum len))
    (locally (declare (fixnum start end))
      (unless (and (<= 0 start end)(<= end len))
        (error "Start ~s should be between 0 and end ~s, and end should be < length ~S" start end len))    
      (multiple-value-bind (str offset) (array-data-and-offset string)
        (declare (fixnum offset))
        (setq start (+ start offset))
        (setq end (+ end offset))
        (let ((base-p (simple-base-string-p str)))
          ;; make sure its not some subclass with a different writer (e.g output-script-file-stream
          (if (and base-p 
                   (not (or *print-pretty* *print-circle*))
                   (eq (stream-writer stream) #'file-stream-tyo)
                   (eq (stream-element-type stream) 'base-character))            
            (let ((column.fblock (column.fblock stream)))
              ;; note we have lost track of column
              (%rplaca column.fblock nil) ;; makes pretty-printing very slow
              (%fwrite-from-vector (%cdr column.fblock) str 
                                   start  (the fixnum (- end start))
                                   t))
            (simple-stream-write-string stream str start end)))))))

#|

(setq foo (make-array 20))
(setq fie (make-array 10 :displaced-to foo :displaced-index-offset 10))



(setq file "ccl:test.lisp")

(setf (aref fie 0) #\a)

(setf (aref fie 1) #\b)

(with-open-file (f file :direction :output :if-exists :supersede)
  (stream-write-sequence f fie :start 0 :end 2))

(with-open-file (f file :direction :input)
  (stream-read-sequence f fie :start 6 :end 10))

(setf (aref fie 4) 4)
(setf (aref fie 5) 5)

(with-open-file (f file :direction :output :if-exists :supersede :element-type '(unsigned-byte 8))
  (stream-write-sequence f fie :start 4 :end 6))

(with-open-file (f file :direction :input :element-type '(unsigned-byte 8))
  (stream-read-sequence f fie :start 4 :end 10))

(setq fee (make-string 20 :element-type 'base-character :initial-element #\z))
(setq fum (make-array 10 :displaced-to fee :displaced-index-offset 10))

(with-open-file (f file :direction :output :if-exists :supersede)
  (stream-write-sequence f fum :start 0 :end 2))

(setf (aref fum 2) #\o)
(setf (aref fum 3) #\p)

(with-open-file (f file :direction :input)
  (stream-read-sequence f fum :start 6 :end 10))

(setq uh-list (make-list 10))

(with-open-file (f file :direction :input)
  (stream-read-sequence f uh-list :start 6 :end 10))

(with-open-file (f file :direction :output :if-exists :supersede)
  (stream-write-sequence f uh-list :start 4 :end 6))







|#
