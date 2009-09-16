;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-streams.lisp,v $
;;  Revision 1.17  2006/02/03 03:08:23  alice
;;  ;; dont remember
;;
;;  Revision 1.16  2005/12/02 21:04:11  alice
;;  ;; open-internal - if utf-something-p - if :utf-16 fblock is extended-character, set stream-external-format
;;
;;  Revision 1.15  2005/11/12 21:03:49  alice
;;  ; gen-file-name - precede with "." keeps Spotlight away? - nope
;;
;;  Revision 1.14  2005/02/01 05:02:33  alice
;;  ;; 12/10/04 eol stuff
;;
;;  Revision 1.13  2004/08/22 00:53:56  alice
;;  ; delete temporary file passes :temporary-file-p
;;
;;  Revision 1.12  2004/05/02 01:23:56  alice
;;  ;; 04/30/04 farewell to instance-initialize-mixin
;;
;;  Revision 1.11  2004/04/26 04:01:48  alice
;;  ;; 04/25/04 some instance-initialize -> initialize-instance
;;
;;  Revision 1.10  2004/04/02 16:43:06  svspire
;;  commented out probe-file-x. It's in l1-files now.
;;
;;  Revision 1.9  2004/03/26 00:02:11  alice
;;  ; 03/25/04 instance-initialize -> *clos-initialization-functions*
;;
;;  Revision 1.8  2004/03/25 03:04:24  alice
;;  no chenge
;;
;;  Revision 1.7  2003/12/08 08:40:31  gtbyers
;;  WITH-SLOTS, not WITH-SLOT-VALUES.  INITIALIZE-INSTANCE on
;;  INITIALIZE-INSTANCE-MIXIN allows-other-keys, making the whole concept
;;  kind of questionable.  At least get rid of DEF-AUX-INIT-FUNCTIONS.
;;
;;  4 8/25/97  akh  with-output-string-stream element-type
;;  3 7/4/97   akh  see below
;;  2 6/2/97   akh  see below
;;  11 1/22/97 akh  read-scriptruns here - returns 2 vals scriptruns and fred 2 resource exists or no
;;  10 7/31/96 slh  
;;  9 6/7/96   akh  fix file-string-length some more
;;  8 5/20/96  akh  file-string-length, open takes output-file-script arg, add class output-script-file-stream
;;  6 4/19/96  akh  open no longer uses *default-character-type*, character is equiv to base-character
;;  2 10/17/95 akh  merge patches
;;    05/01/95 gb   make stream-position method for file-streams extend the file when
;;                   new position > length.
;;  7 5/23/95  akh  gen-file-name use mac-file-write-date
;;  6 4/26/95  akh  increase *elements-per-buffer*
;;  5 4/26/95  akh  moved some stuff back from l1-listener - maybe didnt need to
;;  7 3/2/95   akh  open use application-file-creater, *default-character-type*
;;  6 2/17/95  akh  elements-per-buffer defaults to *elements-per-buffer*
;;  5 1/31/95  akh  incorporate bill's big-io-buffer patch
;;  4 1/11/95  akh  move modeline
;;  3 1/11/95  akh  change *standard-output* and *trace-output* to front-listener-terminal-io (I like it better)
;;  (do not edit before this line!!)

;; L1-streams.lisp - Object oriented streams
; Copyright 1986-1987 Coral Software Corp.
; Copyright 1988-1994 Apple Computer, Inc.
; Copyright 1995-2007 Digitool, Inc.

;; Modification History
;; terminator-predicate handles eol
;; ----- 5.2b6
;; with-slots is silly
;; stream-abort hits it with a hammer if delete-file fails to do the job - now delete-file uses hammer
;; -------- 5.2b5
;; dont try to use exchange-files - doesn't work on remote servers and why bother anyway 
;; ------- 5.2b4
;; forget the "." in gen-file-name - doesn't help and if delete fails, then better if not invisible
;; open-internal - if utf-something-p - if :utf-16 fblock is extended-character, set stream-external-format
;; gen-file-name - precede with "." keeps Spotlight away? - nope
;; 12/10/04 eol stuff
;; ------- 5.1 final
;; delete temporary file passes :temporary-file-p
;; 04/30/04 farewell to instance-initialize-mixin
;; 04/25/04 some instance-initialize -> initialize-instance
; 03/25/04 instance-initialize -> *clos-initialization-functions*
; ----- 5.1b1
; read-scriptruns uses fsref
;; --------- 5.0 final
; stuff for external-format = unix
;--------- 5.0b3
; 12-13-2002 ss stream-position on file-stream: typep --> (subtypep (stream-element-type stream) 'character)
;               to avoid silly failure when trying to extend a character file 
; 03/20/00 akh fix open-internal for base-char from shannon spires
; -------- 4.3.1
; 11/24/99 akh gen-file-name - fix because of namestring-hashes
; 08/24/99 akh tweak need-default-xxx-writer
; -------- 4.3f1c1
; 07/08/99 akh string-output-stream only extends if really necessary and element type not provided
;              errors if input is really extended, output is base, and element-type was provided 
; ---------- 4.3b3
; o4/12/99 akh open-internal save a few bytes re if-exists
;---------------- 4.3b1
; 03/03/99 akh read-scriptruns from slh - uses #_hopenresfile
; 02/02/99 akh stream-position returns ≤ position vs t
; 09/23/98 akh stream-binary-writer stuff, fix stream-writer for possible second arg specializers
; 07/22/98 akh blockmove-stream-write-string uses %copy-8-ivector-to-16-ivector for PPC
; 07/20/98 akh more stuff from Shannon Spires re shuffling strings
; 07/01/98 akh added read-sequence and write-sequence (moved to streams.lisp), optimize stream-write-string if stream is an 8 bit output file 
; 08/14/97 akh with-output-to-string - don't quote element-type
; 04/12/97 akh stream-clear-input defined for stream vs. input-stream so we can bind
;              *debug-io* to a fred-item in order to print-call-history to a fred-window
; 12/07/96 akh  read-scriptruns here - returns 2 vals scriptruns and fred 2 resource exists or no
;                open-internal calls it
;  7/31/96 slh   scriptruns-p here from l1-edbuf.lisp
; fix file-string-length, open takes output-file-script arg, add class output-script-file-stream
; 03/25/96 bill  open-internal once again does the right thing for an element-type of
;                signed-byte or unsigned-byte.
; 03/25/96 bill  remove the fred-update from (method stream-tyi (terminal-io-rubout-handler))
; 01/24/96 bill  Add a "Retry opening ..." restart to OPEN.
; 11/08/95 bill  #_font2script -> #_FontToScript
;  4/21/95 slh   stream-listen nil for funniness when closing windows
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
;11/10/93 bill  Duncan Smith's patch making (method stream-listen (terminal-io)) call
;               stream-listen-no-linemode instead of stream-listen
;06/21/93 alice string-output-stream makes string extended when necessary. Changed
;		stream-tyo, stream-writer. Also don't ignore element-type in
;		make-string-output-stream etal.		
;06/03/93 alice instance-initialize file-stream takes scriptruns arg to pass to %fopen
;		open makes an input-script-file-stream if scriptruns exist in fred 4 rsrc
;		stream-tyi (input-script-file-stream) calls %hairy-ftyi
;05/28/93 alice character -> base-character
;--------------- 3.0d10
;06/03/93 bill  optional arg to current-listener, stream-current-listener, front-listener-terminal-io,
;               *front-listener-terminal-io*
;-------------  3.0d8
;04/29/93 bill  current-process -> *current-process*
;04/21/93 bill  no args to event-dispatch - new *idle* handling
;-------------- 2.1d4
;01/12/93 alice indenting-string-output-stream gets stream-write-string and prefix-char can be string
; 03/24/93 bill  cheap-copy-list, cheap-list, cheap-free-list
; 12/30/92 bill  allocate-resource no longer leaves the returned instance
;                in the pool.data list
; 12/16/92 bill  cheap-cons & friends move here from l1-highlevel-events.
;                make-resource, allocate-resource, free-resource, with-string-output-stream
; 11/20/92  gb   new CURRENT-LISTENER semantics.  Flush (stream-rubout-handler (terminal-io); (??)
; 06/25/92 bill  stream-fresh-line now works correctly on output-file-stream's
;                and when DRIBBLE is enabled.
; 06/18/91 bill  (method stream-finish-output (output-file-stream))
; -------------  2.0
; 03/10/92 bill  OPEN now changes the mac file type only for :if-exists :overwrite
;--------------- 2.0f3
; 02/22/92 (bill from "post 2.0f2c5:terminal-io-patch")
;                Define stream-untyi & stream-listen for terminal-io-rubout-handler
;--------------- 2.0f2c5
; 01/16/92 alice gen-file-name type is "tem" not type of original which can be tooo long.
; 01/11/92 alice open seemed to think that :overwrite meant the file had to exist!
; 12/29/91 alice open :probe don't error if directory
; 12/10/91 alice exchange-files may not work on foreign file systems, brain death in gen-file-name
; 11/25/91 alice OPEN & supersede: do create the durn file when no alias manager
;--------------- 2.0b4c4
; 11/20/91 bill  don't pop-up *debug-io*
; 11/06/91 bill  (method stream-close (file-stream)) regains its slot-makunbound of column.fblock
; 10/23/91 alice open has a mac-file-creator argument to pass to create-file
; 10/21/91 alice :supersede - put the real filename in the my-filename slot, use *alias-manager-present*
; 10/15/91 alice open :supersede - get file type right, error if output & busy or locked 
; 10/09/91 alice gen-file-name eschew defaults
; 10/11/91 gb    changes for new l1-sysio.
; 10/09/91 bill  gen-file-name needed to (make-pathname ... :defaults nil)
; 10/06/91 alice make stream-column survive setting file position
; 10/03/91 alice file-stream gets an orig file slot, change open, stream-close, stream-abort 
;----------------- 2.0b3
; 07/11/91 bill  Handle :probe direction correctly when initializing a file-stream
; 07/21/91 gb   STREAMP returns boolean vice cpl tail.
; 06/24/91 alice stream-write-string gets pop-up-terminal-io method,
;                *query-io* and *debug-io* are pop-up-terminal-io
;--------------- 2.0b2
; 05/20/91 gb    stream-write-entire-string.  Barely worth it: how about
;               making STREAM-WRITE-STRING default start, length args ?
; 05/15/91 bill add :SHARED as a :DIRECTION type for OPEN
; 05/06/91 bill add :FORK keyword to OPEN
; 04/26/91 alice tweak fix to open
; 04/17/91 alice open set file type if-exists and different
; 03/13/91 bill input-file-stream, output-file-stream, io-file-stream
;               This costs more space but no extra time.
; 02/12/91 bill BUFFER-STREAM does USE-BUFFER when created and UNUSE-BUFFER
;               when closed vice SET-FRED-SAVE-BUFFER-P kluge.
;03/22/91 alice stream-tyo (file-stream) - check direction (I dont like this)
;03/05/91 alice remove usage of an unmentionable error function
;-------------- 2.0b1
; 01/28/91 bill (method stream-force-output (file-stream))
; 12/6/90 bill string-stream
; 11/30/90 bill add optional reader/arg args to stream-skip-past-terminator.
;               change it from a method to a function.
; 11/09/90 bill open-stream-p (it's common-lisp)
; 10/03/90 bill %class-cpl -> %inited-class-cpl
; 09/12/90 bill maybe-default-stream-reader/writer
; 09/08/90 bill (safe)-stream-reader, (safe)-stream-writer.
; 08/18/90 bill (method stream-write-string (string-output-stream t t t))
; 08/16/90 bill set-string-output-string
; 08/03/90 bill :parent -> :class
; 07/24/90 bill stream-eofp missing arg to cleanup-fred-item
; 07/05/90 bill keyword args to front-window
; 07/03/90 bill Fix to eval-buffer then close window crashing the machine.
; 06/25/90 bill add key :IGNORE to (method initialize-instance (instance-initialize-mixin))
; 06/22/90 bill def-aux-init-functions for instance-initialize class.
; 06/12/90 bill window-update -> fred-update
; 05/30/90 gz  have file-position call stream-position.
;              Make stream-position methods accept :start/:end args.
; 06/05/90 gb  Try making (stream-clear-input terminal-io) do what ^G does.
; 05/30/90 gb  Use print-unreadable-object.
; 04/30/90 gb  file-string-length, somewhat bogus stream-external-format.
;              use :external-format arg to specify mac file type in OPEN,
;              somewhat halfheartedly.  Indenting-string-output-streams.
;              Accept & ignore :element-type arg to make-string-output-stream.
;03/20/90 bill instance-initialize-mixin, initialize-instance => instance-initialize.
;02/22/90 bill current-listener checks for existing windows.
;01/20/90 gz Added interactive-stream-p, per x3j13/STREAM-CAPABILITIES.
;01/13/90 gz Pass idle arg to event-dispatch in terminal-io-rubout-handler stream-tyi.
;12/29/89 gz fix in terminal-io-rubout-handler stream-tyi.
;            Try again at streamp.
;12/15/89 bill (method initialize-instance :after (file-stream)):
;              Open for read/write for both :output and :io (the low-level
;              block i/o routines always read).
;10/4/89  gz new improved streamp.  Don't default direction in file streams.
;09/27/89 gb simple-string -> ensure-simple-string.
;09/16/89 bill Removed the last vestiges of object-lisp windows.
;09/14/89 bill Convert to CLOS
;09/05/89 gz fix in OPEN - make sure to always create file first.
;09/04/89 gz very primitive rubout handling support.
;08/27/89 gz added default stream-write-string method.
;03/18/89 gz window-select -> window-object-select.
;03/11/89 gz CLOSified somewhat.
;01/01/89 gz Added stream-filename.  Put streamp back here. Added buffer streams,
;            changed selection streams, no more selection queue in terminal-io.
;12/30/88 gz No more kill-mark.
;12/11/88 gz mark-position -> buffer-position
; 11/28/88 gz added exist fn for selection streams.
; 11/16/88 gz allow non-adjustable strings in string output streams
; 11/6/88  gb string-output-stream mods.
; 8/30/88  gz Moved *file-stream* here from l1-files.
; 8/23/88  gz No more async compiler warnings.
; 6/21/88 jaj repeatedly call print-listener-prompt while idling
; 6/10/88 jaj no longer busy when re-reading
; 6/9/88  jaj when idle, print-listener-prompt
; 5/20/88 as  stream-close for selection stream maybe prints "done" to mini-buffer
; 5/10/88 jaj get-next-form sets idle/busy in listener
; 4/8/88  gz  New macptr scheme.
; 3/2/88  gz   Eliminate compiler warnings
;12/17/87 cfry added (stream-line-length *stream*), 
;                    (stream-line-length *terminal-io*)
;10/13/87 jaj removed (get-next-form *selection-stream*) to re-do window/package
;             screws
;------------------------------Version 1.0-------------------------------
;8/03/87 jaj made streams double-closable, added stream-abort
;8/01/87 jaj dribble bug fix
;7/26/87 gz  new move-mark syntax. Support for buffer packages.
;7/26/87 jaj task-dispatch -> event-dispatch
;7/22/87 jaj support for *read-level* and eval-enqueue
;7/18/87 gz string output streams:fixes in fresh-line, column, added clear-output
;7/13/87 jaj init-lists use keywords
;7/1/87  gz new exist arg scheme. Use defobject.
;6/21/87 gb moved streamp, string-output stream functions here from lib;streams.
;6/16/87 gz ignore decls
;4/6/87  gz converted ERROR calls.
;           made get-next-form for *terminal-io* catch %re-read and do so...
;4/1/87  gz made get-next-form return source-name if present.
;           fix to terminal-io stream-untyi.
;3/25/87  gz  mods for fred listeners/terminal-io.
;3/22/87  jaj terminal-io stream-tyi always reads from listener
;3/20/87  jaj fixed TE selection stream bug introduced by dribble hook
;3/18/87  jaj added hooks for dribble-streams
;3/17/87  jaj terminal-io eofp always returns nil. removed handle and sink streams
;3/14/87  gz  default stream-fresh-line does the terpri to SELF.
;3/4/87   jaj fixed terminal-io clear-input
;02/22/87 jaj added not to stream-listen
;01/23/86 jaj adapted from oows-streams.lisp

; Turns initialize-instance into instance-initialize so that users can
; call-next-method with args and get the args to :before & :after methods.

(defvar *elements-per-buffer* 2048)  ; default buffer size for file io
#|
(defclass instance-initialize-mixin () ())


(defmethod initialize-instance ((v instance-initialize-mixin) &rest initargs
                                &key &allow-other-keys)
  (declare (dynamic-extent initargs))
  (call-next-method)
  (apply #'instance-initialize v initargs))

; Make sure a primary method exists.
(defmethod instance-initialize ((v instance-initialize-mixin) &key))

;;;(def-aux-init-functions instance-initialize-mixin #'instance-initialize)

;; where to put this?? once done by def-aux-init-functions
(pushnew #'instance-initialize *clos-initialization-functions*)
|# 


;; no more instance-initialize-mixin here
(defclass stream ()
  ((direction :initarg :direction :initform nil :reader stream-direction)))

(defparameter *stream-class* (find-class 'stream))

(defun streamp (thing)
  (not (null (memq *stream-class* (%inited-class-cpl (class-of thing))))))

(defclass input-stream (stream) ())
(defclass output-stream (stream) ())

(defmethod initialize-instance :after ((stream input-stream) &key)
  (let ((direction (slot-value stream 'direction)))
    (if (null direction)
      (set-slot-value stream 'direction :input)
      (if (eq direction :output)
        (set-slot-value stream 'direction :io)))))

;(defmethod instance-initialize :after ((stream output-stream) &key))
(defmethod initialize-instance :after ((stream output-stream) &key)
  (let ((direction (slot-value stream 'direction)))
    (if (null direction)
      (set-slot-value stream 'direction :output)
      (if (eq direction :input)
        (set-slot-value stream 'direction :io)))))

(defmethod stream-tyo ((stream stream) char)
  ;(declare (ignore char))
  (if (not (typep stream 'output-stream))
    (error "stream ~S is not capable of output" stream)
    (error "stream ~s is not able to output ~s" stream char)))

(defun safe-stream-writer (stream)
  (multiple-value-bind (writer arg) (stream-writer stream)
    (if (functionp writer)
      (values writer arg)
      (let (f)
        (if (and (symbolp writer) (setq f (fboundp writer)))
          (values f arg)
          (values #'stream-tyo stream))))))

#|
(defmethod stream-writer ((stream stream))
  (values (find-1st-arg-combined-method #'stream-tyo stream)
          stream))
|#


(defmethod stream-writer ((stream stream))
  (let ((meth (find-1st-arg-combined-method-2 #'stream-tyo stream)))
    (values (or meth #'stream-tyo)
            stream)))

#| ;; old one
(defun need-default-stream-writer (stream class)
  (let ((default (find-1st-arg-combined-method #'stream-tyo stream)))
    (unless (eq default (find-1st-arg-combined-method
                         #'stream-tyo (class-prototype class)))
      default)))
|#


(defun need-default-stream-writer (stream class)
  (let ((default (find-1st-arg-combined-method-2 #'stream-tyo stream)))
    (if (null default)  ;; dont think this happens now
      #'stream-tyo
      (unless (eq default (find-1st-arg-combined-method-2
                           #'stream-tyo (class-prototype class)))
        default))))

(defun need-default-stream-binary-writer (stream class)
  (let ((default (find-1st-arg-combined-method-2 #'stream-write-byte stream)))
    (if (null default)
      #'stream-write-byte
      (unless (eq default (find-1st-arg-combined-method-2
                           #'stream-write-byte (class-prototype class)))
        default))))

(defmacro maybe-default-stream-writer ((stream class) &body body)
  (let* ((default (gensym))
         (stream-var (make-symbol "STREAM")))
    `(let* ((,stream-var ,stream)
            (,default (need-default-stream-writer ,stream-var ,class)))
       (if ,default
         (values ,default ,stream-var)
         (progn ,@body)))))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defmacro maybe-default-stream-binary-writer ((stream class) &body body)
  (let* ((default (gensym))
         (stream-var (make-symbol "STREAM")))
    `(let* ((,stream-var ,stream)
            (,default (need-default-stream-binary-writer ,stream-var ,class)))
       (if ,default
         (values ,default ,stream-var)
         (progn ,@body)))))
)

#|
(defun default-stream-writer (stream)
  (values (find-1st-arg-combined-method #'stream-tyo stream)
          stream))
|#

(defun stream-write-entire-string (stream string)
  (stream-write-string stream string 0 (length string)))

(defmethod stream-write-string ((stream stream) string start end)  
  (multiple-value-bind (str offset) (array-data-and-offset string)
    (declare (fixnum offset))
    (setq start (require-type (+ start offset) 'fixnum))
    (setq end (require-type (+ end offset) 'fixnum))
    (setq str (require-type str 'simple-string))
    (locally (declare (fixnum start end))
      (if (> start end)(error "Start ~s should be <= end ~S" start end))
      (let ((base-p (simple-base-string-p str)))
        (multiple-value-bind (writer arg)(stream-writer stream)
          (if base-p
            (locally (declare (type simple-base-string str)) 
              (while (%i< start end)
                (funcall writer arg (schar str start))
                (setq start (%i+ start 1))))
            (locally (declare (type simple-extended-string str)) 
              (while (%i< start end)
                (funcall writer arg (schar str start))
                (setq start (%i+ start 1))))))))))

(defmethod stream-tyi (stream)
  (error "~s is not capable of input" stream))

(defun safe-stream-reader (stream)
  (multiple-value-bind (reader arg) (stream-reader stream)
    (if (functionp reader)
      (values reader arg)
      (let (f)
        (if (and (symbolp reader) (setq f (fboundp reader)))
          (values f arg)
          (values #'stream-tyi stream))))))

(defmethod stream-reader ((stream stream))
  (values (find-1st-arg-combined-method #'stream-tyi stream) stream))

(defun need-default-stream-reader (stream class)
  (let ((default (find-1st-arg-combined-method #'stream-tyi stream)))
    (unless (eq default (find-1st-arg-combined-method
                         #'stream-tyi (class-prototype class)))
      default)))

(defun need-default-stream-binary-reader (stream class)
  (let ((default (find-1st-arg-combined-method #'stream-read-byte stream)))
    (unless (eq default (find-1st-arg-combined-method
                         #'stream-read-byte (class-prototype class)))
      default)))

(defmacro maybe-default-stream-reader ((stream class) &body body)
  (let ((default (gensym))
        (stream-var (make-symbol "STREAM")))
    `(let* ((,stream-var ,stream)
            (,default (need-default-stream-reader ,stream-var ,class)))
       (if ,default
         (values ,default ,stream-var)
         (progn ,@body)))))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defmacro maybe-default-stream-binary-reader ((stream class) &body body)
  (let ((default (gensym))
        (stream-var (make-symbol "STREAM")))
    `(let* ((,stream-var ,stream)
            (,default (need-default-stream-binary-reader ,stream-var ,class)))
       (if ,default
         (values ,default ,stream-var)
         (progn ,@body)))))
)

#|
(defun default-stream-reader (stream)
  (values (find-1st-arg-combined-method #'stream-tyi stream) stream))
|#

(defmethod stream-untyi ((stream stream) char)
  (declare (ignore char))
  (error "stream ~S is not capable of input" stream))

(defun char-eolp+ (char &optional other)
  (declare (ignore other))
  (char-eolp char))
           

(defun terminator-predicate (terminator)
  (cond ((characterp terminator)
         (if (char-eolp terminator)
           #'char-eolp+
           #'eq))
        ((stringp terminator)
         #'%str-member)
        ((functionp terminator)
         #'(lambda (char terminator) (funcall terminator char)))))

(defmethod stream-read-string ((stream stream) string start end terminator)
  (setq start (require-type start 'fixnum))
  (setq end (require-type end 'fixnum))
  (let ((pred (terminator-predicate terminator))
        (start start)
        (end end))
    (declare (fixnum start end))
    (multiple-value-bind (reader arg) (stream-reader stream)
      (while (< start end)
        (let ((char (funcall reader arg)))
          (when (and pred (funcall pred char terminator))
            (stream-untyi stream char)
            (return-from stream-read-string start))
          (setf (schar string start) char)
          (incf start)))))
  end)

(defun stream-skip-past-terminator (stream terminator &optional reader arg)
  (let ((pred (terminator-predicate terminator)))
    (unless reader
      (multiple-value-setq (reader arg) (stream-reader stream)))
    (loop
      (let ((char (funcall reader arg)))
        (when (or (null char) (funcall pred char terminator))
          (return char))))))

(defmethod stream-eofp ((stream stream))
  (error "stream ~S is not capable of input" stream))

(defmethod stream-force-output ((stream output-stream)) nil)

(defmethod stream-close ((stream stream))
  (set-slot-value stream 'direction :closed)
  t)

(defun open-stream-p (stream)
  (setq stream (require-type stream 'stream))
  (neq (stream-direction stream) :closed))

(defmethod stream-fresh-line ((stream output-stream))
  (terpri stream)
  t)

;; used by pprint - nothing else I think
(defmethod stream-line-length ((stream stream))
  "This is meant to be shadowed by particular kinds of streams,
   esp those associated with windows."
  80)

(defmethod interactive-stream-p ((stream stream)) nil)

(defmethod stream-clear-input ((stream stream)) nil)

(defmethod stream-listen ((stream input-stream))
  (not (stream-eofp stream)))

(defmethod stream-abort ((stream stream))
  (set-slot-value stream 'direction :closed))

(defmethod stream-filename ((stream stream)) nil)

(defmethod stream-rubout-handler ((stream stream) reader)
  (funcall reader stream))

;;;The Terminal Stream

(defun current-listener (&optional stream)
  (stream-current-listener stream))


(defmethod stream-current-listener ((stream t))
  (let* ((l (or *top-listener*
                ;(setq *top-listener* (front-window :class *default-listener-class*))
                (setq *top-listener* (make-instance *default-listener-class* :process *current-process*)))))
    ;(process-lock (slot-value l 'lock))
    l))


(defclass terminal-io (input-stream output-stream) ())

(defclass front-listener-terminal-io (terminal-io) ())

(defmethod stream-current-listener ((stream front-listener-terminal-io))
  (or *top-listener*
      (front-window :class *default-listener-class*)
      (call-next-method)))

(defvar *front-listener-terminal-io* (make-instance 'front-listener-terminal-io))

(defmethod stream-tyo ((stream terminal-io) char)
  (stream-tyo (current-listener stream) char)
  (if *dribble-stream* (stream-tyo *dribble-stream* char)))

(defmethod stream-write-string ((stream terminal-io) string start end)
  (stream-write-string (current-listener stream) string start end)
  (if *dribble-stream* (stream-write-string *dribble-stream* string start end)))

(defmethod stream-fresh-line ((stream terminal-io))
  (when (stream-fresh-line (current-listener stream))
    (if *dribble-stream* (stream-fresh-line *dribble-stream*))
    t))

(defmethod stream-force-output ((stream terminal-io))
  (when *top-listener* (stream-force-output *top-listener*)))

(defmethod stream-column ((stream terminal-io))
  (stream-column (current-listener stream)))

(defmethod stream-line-length ((stream terminal-io))
  (stream-line-length (current-listener stream)))

(defmethod stream-clear-input ((stream terminal-io))
  (let ((w *top-listener*))
    (when w
      (set-mark (listener-read-mark stream) t)
      (frec-set-sel (slot-value w 'frec) t t))))
#| was:
  (when *top-listener* (reset-input *top-listener*)))
|#

(defmethod stream-tyi ((stream terminal-io))
  (stream-tyi-no-linemode (current-listener stream)))

(defvar *terminal-io-class* (find-class 'terminal-io))

(defmethod stream-reader ((stream terminal-io))
  (maybe-default-stream-reader (stream *terminal-io-class*)
    (values
     #'(lambda (ignore)
         (declare (ignore ignore))
         (stream-tyi-no-linemode (current-listener stream)))
     nil)))

(defmethod stream-untyi ((stream terminal-io) char)
  (stream-untyi (current-listener stream) char))

(defmethod stream-eofp ((stream terminal-io)) nil)

(defmethod stream-listen ((stream terminal-io))
  (when *top-listener* (stream-listen-no-linemode *top-listener*)))

(defmethod interactive-stream-p ((stream terminal-io)) t)

(defclass terminal-io-rubout-handler (stream)
  ((start-mark :initform nil)
   (buffer-modcnt :initform nil)))

(defmethod stream-tyi ((stream terminal-io-rubout-handler))
  (let ((buffer-modcnt (slot-value stream 'buffer-modcnt)))
    (loop
      (let* ((listener (current-listener stream))
             (start-mark (listener-start-mark listener))
             (read-mark (listener-read-mark listener))
             (eof-mark (listener-eof-mark listener)))
        (progn
          ;This could really use some cooperation from ed-self-insert so
          ;that typing at end of buffer shouldn't cause reparsing...
          (unless (and (same-buffer-p start-mark read-mark)
                       (eql buffer-modcnt (buffer-modcnt start-mark)))
            (throw start-mark nil))      ;re-read
          (unless (buffer-end-p read-mark)
            (return
             (without-interrupts
              (when (mark-equal-p read-mark eof-mark)
                (move-mark eof-mark 1))
              (stream-tyi listener))))
          ; This causes the cursor to blink rapidly
          ;(fred-update listener)
          (event-dispatch))))))

(defmethod stream-eofp ((stream terminal-io-rubout-handler)) nil)

(defmethod stream-untyi ((stream terminal-io-rubout-handler) char)
  (stream-untyi (current-listener stream) char))

(defmethod stream-listen ((stream terminal-io-rubout-handler)) t)




;;;Pop-up terminal io stream

(defclass pop-up-terminal-io (terminal-io) ())

(defmethod stream-tyo :before ((stream pop-up-terminal-io) char)
  (declare (ignore char))
  (let* ((listener (current-listener stream)))
    (unless (eq listener *selected-window*)
      (window-select listener))))

(defmethod stream-write-string :before ((stream pop-up-terminal-io) string start end)
  (declare (ignore string start end))
  (let* ((listener (current-listener stream)))
    (unless (eq listener *selected-window*)
      (window-select listener))))


;;;Buffer streams

(defclass buffer-stream (input-stream output-stream)
  ((buffer-stream-state :accessor buffer-stream-state)))

(defmethod initialize-instance :after ((stream buffer-stream)
                                       &key fred-item buffer start end)
  (when fred-item
    (setq buffer (fred-buffer fred-item)))
  (use-buffer buffer)
  ;Should take current slot contents into account...
  (let ((buffer-mark (make-mark buffer start))
        (eof-mark (if end
                    (make-mark buffer end t)
                    (make-mark buffer t))))
    (setf (buffer-stream-state stream) (list buffer-mark eof-mark))))

(defmethod buffer-mark ((stream buffer-stream))
  (car (buffer-stream-state stream)))

(defmethod stream-tyi ((stream buffer-stream))
  (buffer-stream-tyi (buffer-stream-state stream)))

(defvar *buffer-stream-class* (find-class 'buffer-stream))

(defmethod stream-reader ((stream buffer-stream))
  (maybe-default-stream-reader (stream *buffer-stream-class*)
    (values #'buffer-stream-tyi (buffer-stream-state stream))))

(defun buffer-stream-tyi (state)
  (let ((buffer-mark (car state))
        (eof-mark (cadr state)))
    (when (%i< (buffer-position buffer-mark)
             (buffer-position eof-mark))
      (buffer-read-char buffer-mark))))

(defmethod stream-eofp ((stream buffer-stream))
  (let ((state (buffer-stream-state stream)))
    (%i>= (buffer-position (car state))
          (buffer-position (cadr state)))))

(defmethod stream-untyi ((stream buffer-stream) char)
  (declare (ignore char))
  (move-mark (buffer-mark stream) -1))

(defmethod stream-tyo ((stream buffer-stream) char)
  (buffer-insert (buffer-mark stream) char))

(defmethod stream-writer ((stream buffer-stream))
  (maybe-default-stream-writer (stream *buffer-stream-class*)
    (values #'buffer-insert (buffer-mark stream))))

(defmethod stream-write-string ((stream buffer-stream) string start end)
  (buffer-insert-substring (buffer-mark stream) string start end))

(defmethod stream-fresh-line ((stream buffer-stream))
  (let* ((buffer-mark (buffer-mark stream))
         (pos (buffer-position buffer-mark)))
    (when (and (not (%izerop pos))
               (not (char-eolp (buffer-char buffer-mark (%i- pos 1)))))
      (stream-tyo stream (or *preferred-eol-character* #\return))
      t)))

(defmethod stream-position ((stream buffer-stream) &optional newpos)
  (when newpos
    (set-mark (buffer-mark stream)
              (cond ((eq newpos :start) 0)
                    ((eq newpos :end) t)
                    (t newpos))))
  (buffer-position (buffer-mark stream)))

(defmethod stream-close :after ((stream buffer-stream))
  (let ((state (buffer-stream-state stream)))
    (setf (buffer-stream-state stream) nil)
    (when state
      (unuse-buffer (car state)))))

;;;Selection Streams

(defclass selection-stream (buffer-stream)
  ((my-file-name :initarg :filename :initform nil :reader stream-filename)
   (read-package :initarg :package :initform nil)
   (reader.arg :initform (cons nil nil) :accessor reader.arg)))

(defmethod stream-read ((stream selection-stream) eof-error-p eof-value)
  (declare (ignore eof-error-p eof-value))
  (let ((read-package (slot-value stream 'read-package)))
    (if read-package
      (let ((*package* (pkg-arg read-package)))
        (call-next-method))
      (call-next-method))))

(defmethod stream-close :after ((stream selection-stream))
  (slot-makunbound stream 'my-file-name)
  (slot-makunbound stream 'read-package))

(defmethod stream-tyi ((stream selection-stream))
  (let ((char (call-next-method)))
    (if *dribble-stream* (dribble-tyi char))
    char))

(defvar *selection-stream-class* (find-class 'selection-stream))

(defmethod stream-reader ((stream selection-stream))
  (maybe-default-stream-reader (stream *selection-stream-class*)
    (let ((reader.arg (reader.arg stream))
          (reader #'buffer-stream-tyi)
          (arg (buffer-stream-state stream)))
      (setf (car reader.arg) reader
            (cdr reader.arg) arg)
      (values #'(lambda (reader.arg)
                  (let ((char (funcall (car reader.arg) (cdr reader.arg))))
                    (if *dribble-stream* (dribble-tyi char))
                    char))
              reader.arg))))

;Is this ever used?
(defmethod stream-tyi-no-linemode ((stream selection-stream))
  (let ((char (call-next-method)))
    (if *dribble-stream* (dribble-tyi char))
    char))

(defmethod stream-untyi :after ((stream selection-stream) char)
  (declare (ignore char))
  (if *dribble-stream* (dribble-untyi)))

;;;String output streams

; Required by CL
(defclass string-stream (stream) ())

(defclass string-output-stream (string-stream output-stream)
  ((my-string :initarg :string :reader string-output-stream-string)
   (element-type-provided-p :initform nil :initarg :element-type-provided-p :accessor element-type-provided-p)))

(defun make-string-output-stream (&key (element-type *default-character-type* elt-type-p))
  ;(declare (ignore element-type))
  (if elt-type-p
    (make-instance 'string-output-stream :element-type element-type)
    (make-instance 'string-output-stream)))

(defmacro with-output-to-string ((var &optional string &key element-type)
                                 &body body 
                                 &environment env)
  ;(declare (ignore element-type)) ; maybe should ensure (subtypep element-type 'character)
  (multiple-value-bind (forms decls) (parse-body body env nil)
    `(let ((,var ,(if string
                    `(make-instance 'string-output-stream :string ,string)
                    (if element-type
                      `(make-instance 'string-output-stream :element-type ,element-type)
                      `(make-instance 'string-output-stream)))))
       ,@decls
       (unwind-protect
         (progn
           ,@forms
           ,@(if string () `((get-output-stream-string ,var))))
         (close ,var)))))

; It might make sense to accept non-adjustable and/or simple
; strings and displace the instance variable to them, if necessary.
(defmethod initialize-instance :after ((stream string-output-stream) &key string element-type)
  (when (not string)
    (setq string (make-array 10 :element-type (or element-type *default-character-type*) 
                             :adjustable t :fill-pointer 0)))
  (when element-type (setf (element-type-provided-p stream) t))
  (setf (string-output-stream-string stream) string))

(defmethod (setf string-output-stream-string) (string (stream string-output-stream))
  (unless string
    (setq string  (make-array 10
                              :element-type *default-character-type*
                              :adjustable t
                              :fill-pointer 0)))
  (unless (and (stringp string)(array-has-fill-pointer-p string))
    (error "String: ~a must be a string with a fill-pointer" string))
  (setf (slot-value stream 'my-string) string))    

(defmethod stream-tyo ((stream string-output-stream) char)
  (string-stream-tyo stream char))

; cause its a stream-writer
(defun string-stream-tyo (stream char)
  (let ((string (string-output-stream-string stream)))
    (when (and (extended-character-p char)(base-string-p string))
      ;(print  (list 'cow2 (element-type-provided-p stream) char string))
      (if (element-type-provided-p stream)
        (error "Type of character ~s does not match element-type of ~s" char stream)
        (progn (setq string (string-to-extended-string string))
               (setf (string-output-stream-string stream) string))))
    (vector-push-extend char string)))

(defvar *string-output-stream-class* (find-class 'string-output-stream))

(defmethod stream-writer ((stream string-output-stream))
  (maybe-default-stream-writer (stream *string-output-stream-class*)
    (values #'string-stream-tyo stream)))

(defmethod stream-element-type ((stream string-output-stream))
  (array-element-type (string-output-stream-string stream)))
    

(defmethod stream-clear-output ((stream string-output-stream))
  (setf (fill-pointer (slot-value stream 'my-string)) 0))

(defmethod stream-close :after ((stream string-output-stream))
  (slot-makunbound stream 'my-string))

(defmethod stream-fresh-line ((stream string-output-stream))
  (let ((string (slot-value stream 'my-string)) pos)
    (when (or (%izerop (setq pos (fill-pointer string)))
              (not (char-eolp (elt string (%i- pos 1)))))
      (stream-tyo stream (or *preferred-eol-character* #\return))
      t)))

(defmethod stream-column ((stream string-output-stream))
  (let ((string (slot-value stream 'my-string)))
    (do* ((pos (fill-pointer string)) (i pos (%i- i 1)))
         ((eql 0 i) pos)
      (when (char-eolp (elt string (%i- i 1)))
        (return (%i- pos i))))))

(defmethod get-output-stream-string ((stream string-output-stream))
  (let* ((str (slot-value stream 'my-string))
         (res (ensure-simple-string str)))
    (setf (fill-pointer str) 0)
    res))

(export 'stream-position :ccl)
(defmethod stream-position ((stream string-output-stream) &optional newpos)
  (if newpos
    (set-fill-pointer (slot-value stream 'my-string)
                      (cond ((eq newpos :start) 0)
                            ((eq newpos :end) t)
                            (t newpos)))
    (fill-pointer (slot-value stream 'my-string))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; from Shannon Spires faster stream-write-string for string-output-streams - all the red ones


#+:PPC-TARGET
(defun fast-adjust-array (tostring new-size)
  (unless (logbitp $arh_adjp_bit (the fixnum
                                   (%svref tostring ppc::arrayH.flags-cell)))
    (%err-disp $XMALADJUST tostring))
  (multiple-value-bind (data offset) (array-data-and-offset tostring)
    (let ((new-vector (%extend-vector offset data new-size)))
      (setf (%svref tostring ppc::vectorH.data-vector-cell) new-vector
            (%svref tostring ppc::vectorH.displacement-cell) 0
            (%svref tostring ppc::vectorH.physsize-cell) new-size)))
  )

#-:PPC-TARGET
(defun fast-adjust-array (tostring new-size)
  "I dunno how to do this in 68K MCL."
  (adjust-array tostring new-size))

#+ppc-target
(eval-when (:load-toplevel :execute)
  ;; this is defined in ppc-misc but I'm too lazy to rebuild ppc-boot today
  (when (not (fboundp '%copy-8-ivector-to-16-ivector))
    (defppclapfunction %copy-8-ivector-to-16-ivector ((src 4) 
                                                      (src-byte-offset 0)
                                                      (dest arg_x)
                                                      (dest-byte-offset arg_y)  ;; its really a half-word offset
                                                      (nbytes arg_z))
      (lwz temp0 src vsp)
      (cmpwi cr0 nbytes 0)
      (lwz imm0 src-byte-offset vsp)
      (unbox-fixnum imm0 imm0)
      (la imm0 ppc::misc-data-offset imm0)
      (unbox-fixnum imm1  dest-byte-offset)
      (add imm1 imm1 imm1)
      (la imm1 ppc::misc-data-offset imm1)
      (b @test)
      @loop
      (subi nbytes nbytes '1)
      (cmpwi cr0 nbytes 0)
      (lbzx imm3 temp0 imm0)
      (addi imm0 imm0 1)
      (sthx imm3 dest imm1)
      (addi imm1 imm1 2)
      @test
      (bne cr0 @loop)
      (mr arg_z dest)
      (la vsp 8 vsp)
      (blr)))
)

(defmethod blockmove-stream-write-string ((stream string-output-stream) fromstring start end)
  (when (%i< start end)
    (let ((tostring (string-output-stream-string stream)))
      (when (and (extended-string-p fromstring)(base-string-p tostring))
        (if (real-xstring-p fromstring)
          (if (element-type-provided-p stream)
            (error "Type of string ~S does not match element-type of ~s" (type-of fromstring) stream)
            (progn
              (setq tostring (string-to-extended-string tostring))
              (setf (string-output-stream-string stream) tostring)))
          ;; do this case the slower but non-consing way - it happens from write-pname => write-perverted-string
          (return-from blockmove-stream-write-string (simple-stream-write-string stream fromstring start end))))
      ; at this point if fromstring is extended then so is tostring      
      ; since we're calling %copy-ivector-to-ivector, I think this next step
      ;   is necessary. But it might be better just to not call
      ;   blockmove-stream-write-string in this case and do it the old way. ?
      #-:ppc-target           ;; no 68K version of %copy-8-ivector-to-16-ivector
      (when (and (extended-string-p tostring) (base-string-p fromstring))  ; waste some space in this case
        (setq fromstring (string-to-extended-string fromstring))        
        )
      
      (let* ((nchars (- end start))
             (fill (fill-pointer tostring))
             (total-size (array-total-size tostring))
             (new-fill (%i+ fill nchars))
             (new-size nil))
        (when (> new-fill total-size)
          ; Adjust to 150% or big enough to hold new data, whichever is greater
          (setq new-size (%imax (1+ new-fill)
                                        (+ total-size
                                           (the fixnum (1+ (ash (the fixnum total-size)
                                                                -1))))))
          ;(adjust-array tostring new-size) ; for testing only. This version is slow.
          (fast-adjust-array tostring new-size) ; much faster
          )
        (multiple-value-bind (vector displacement)
                             (array-data-and-offset tostring)
          ;; at this point for PPC fromstring can be extended or base, but if is extended then so is tostring
          ;; if fromstring is base then tostring can be either
          (if (base-string-p fromstring)
            (if (base-string-p tostring)
              (ccl::%copy-ivector-to-ivector fromstring start vector (%i+ displacement fill) nchars)
              #+ppc-target
              (ccl::%copy-8-ivector-to-16-ivector fromstring start vector (%i+ displacement fill) nchars)
              #-ppc-target (error "shouldn't happen.")
              )
            (ccl::%copy-ivector-to-ivector fromstring (%i* 2 start) vector
                                           (%i* 2 (%i+ displacement fill))
                                           (%i* 2 nchars))
            )
          (setf (fill-pointer tostring) new-fill)))
      )))

;;; assume we already did the type tests - and the array-data-and-offset?
(defun simple-stream-write-string (stream str start end) 
  (when (%i< start end)
    (let ((base-p (simple-base-string-p str)))
      (multiple-value-bind (writer arg) (stream-writer stream)
        (if base-p
          (locally (declare (type simple-base-string str)) 
            (while (%i< start end)
              (funcall writer arg (schar str start))
              (setq start (%i+ start 1))))
          (locally (declare (type simple-extended-string str)) 
            (while (%i< start end)
              (funcall writer arg (schar str start))
              (setq start (%i+ start 1)))))))))

(defvar *stream-write-string-threshold* 0
   "The cutover point for using simple-stream-write-string vs. blockmove-stream-write-string.
    Source strings shorter than this value will use the simple method,
    longer strings will use the blockmove method. (Using blockmove on very short strings
    could actually slow things down because of its initial overhead.)
    This number should be tuned for a given microprocessor and lisp implementation.
    Set this variable to nil to always use the simple (old) method.
    Set it to 0 or less to always use the blockmove method.")


(defmethod stream-write-string ((stream string-output-stream) string start end)
  (declare (optimize (debug 0))) ; force a tail jump
  (multiple-value-bind (str offset) (array-data-and-offset string)
    (setq start (require-type (+ start offset) 'fixnum))
    (setq end (require-type (+ end offset) 'fixnum))
    (setq str (require-type str 'simple-string))
    (let ((len (length str)))
      (declare (fixnum len))
      (locally (declare (fixnum start end))
        (unless (and (<= 0 start end)(<= end len))
          (error "Start ~s should be between 0 and end ~s, and end should be < length ~S" start end len))    
        (if (and (fixnump *stream-write-string-threshold*)
                 (%i> (- end start) *stream-write-string-threshold*))
          (blockmove-stream-write-string stream str start end)
          (simple-stream-write-string stream str start end)
          )))))

#| ; a test

(with-output-to-string (s nil :element-type 'character)
  (stream-write-string s "assdf" 0 5))
|#


; Some simple explicit storage management for cons cells
(defvar *cons-pool* (%cons-pool nil))

(defun cheap-cons (car cdr)
  (let* ((pool *cons-pool*)
         (cons (pool.data pool)))
    (if cons
      (locally (declare (type cons cons))
        (setf (pool.data pool) (cdr cons)
              (car cons) car
              (cdr cons) cdr)
        cons)
      (cons car cdr))))

(defun free-cons (cons)
  (when (consp cons)
    (locally (declare (type cons cons))
      (setf (car cons) nil
            (cdr cons) nil)
      (let* ((pool *cons-pool*)
             (freelist (pool.data pool)))
        (setf (pool.data pool) cons
              (cdr cons) freelist)))))

(defun cheap-copy-list (list)
  (let ((l list)
        res)
    (loop
      (when (atom l)
        (return (nreconc res l)))
      (setq res (cheap-cons (pop l) res)))))

(defun cheap-list (&rest args)
  (declare (dynamic-extent args))
  (cheap-copy-list args))

; Works for dotted lists
(defun cheap-free-list (list)
  (let ((l list)
        next-l)
    (loop
      (setq next-l (cdr l))
      (free-cons l)
      (when (atom (setq l next-l))
        (return)))))

(defmacro pop-and-free (place)
  (setq place (require-type place 'symbol))     ; all I need for now.
  (let ((list (gensym))
        (cdr (gensym)))
    `(let* ((,list ,place)
            (,cdr (cdr ,list)))
       (prog1
         (car ,list)
         (setf ,place ,cdr)
         (free-cons ,list)))))

; Support for defresource & using-resource macros
(defun make-resource (constructor &key destructor initializer)
  (%cons-resource constructor destructor initializer))

(defun allocate-resource (resource)
  (setq resource (require-type resource 'resource))
  (let ((pool (resource.pool resource))
        res)
    (without-interrupts
     (let ((data (pool.data pool)))
       (when data
         (setf res (car data)
               (pool.data pool) (cdr (the cons data)))
         (free-cons data))))
    (if res
      (let ((initializer (resource.initializer resource)))
        (when initializer
          (funcall initializer res)))
      (setq res (funcall (resource.constructor resource))))
    res))

(defun free-resource (resource instance)
  (setq resource (require-type resource 'resource))
  (let ((pool (resource.pool resource))
        (destructor (resource.destructor resource)))
    (when destructor
      (funcall destructor instance))
    (without-interrupts
     (setf (pool.data pool)
           (cheap-cons instance (pool.data pool)))))
  resource)      

(defresource *string-output-stream-pool*
  :constructor (make-instance 'string-output-stream)
  :initializer 'stream-clear-output)

(defmacro with-string-output-stream ((stream) &body body)
  `(using-resource (,stream *string-output-stream-pool*)
     ,@body))

;;;One way to indent on newlines:
(defclass indenting-string-output-stream (string-output-stream)
  ((indent :initarg :indent :initform nil)
   (indent-prefix :initarg :indent-prefix :initform nil)
   (writer.arg :initform (cons nil nil) :reader writer.arg)))

(defmethod stream-tyo ((stream indenting-string-output-stream) char)
  (call-next-method)
  (let ((indent (slot-value stream 'indent))
        (indent-prefix (slot-value stream 'indent-prefix)))
    (when  (char-eolp  char)
      (when indent-prefix
        (if (stringp indent-prefix)
          (stream-write-string  stream indent-prefix 0 (length indent-prefix))
          (call-next-method stream indent-prefix))
        (when indent (setq indent (%i- indent 1))))
      (when indent
        (dotimes (i indent)
          (declare (fixnum i))
          (call-next-method stream #\space))))))

(defun string-eol-position (string &optional start end)
  (if (encoded-stringp string)(setq string (the-string string)))
  (multiple-value-bind (string start end)(string-start-end string start end)  
    (dotimes (i (- end start))
      (when (char-code-eolp (%scharcode string (%i+ start i)))
        (return (+ i start))))))

(defmethod stream-write-string ((stream indenting-string-output-stream) string start end)
  (if (not (string-eol-position string start end))
    (call-next-method)    
    (do ((i start (1+ i)))
        ((= i end))
      (stream-tyo stream (char string i)))))

;;;File streams.

; The idea that EXTERNAL-FORMAT has anything to do with mac file types is, er, um,
; "not well developed."
(defun open (filename &key (direction :input)
                      (element-type 'base-character)
                      (if-exists :error)
                      (if-does-not-exist (if (or (eq direction :input)
                                                 ;(eq if-exists :overwrite)
                                                 (eq if-exists :append))
                                           :error :create))
                      (external-format :default ef-supplied)
                      (fork :data)
                      (output-file-script-p nil)
                      (input-file-script *input-file-script*)
                      (elements-per-buffer *elements-per-buffer*)		          
                      (mac-file-creator (application-file-creator *application*)))
  
  (loop
    (restart-case
      (return (open-internal filename direction element-type if-exists if-does-not-exist
                             external-format ef-supplied fork 
                             elements-per-buffer mac-file-creator output-file-script-p input-file-script))
      (retry-open ()
                  :report (lambda (stream) (format stream "Retry opening ~s" filename))
                  nil))))

;; used by find-bm-tables-in-file
(defun scriptruns-p (truename)
  (let (refnum)
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple truename fsref)
      (unwind-protect 
        (unless (eq -1 (setq refnum (open-resource-file-from-fsref fsref #$fsrdperm))) ;(setq refnum (with-pstrs ((np (mac-namestring truename))) (#_HOpenResFile 0 0 np #$fsrdperm))))
          (with-macptrs ((fred4 (#_Get1Resource :FRED 4))
                         (fred2 (#_get1resource :FRED 2)))
            (values (not (%null-ptr-p fred4))(not (%null-ptr-p fred2)))))
        (unless (eq refnum -1)
          (#_CloseResFile refnum))))))

;; redefined in pathnames.lisp
(defun read-scriptruns (truename)
  (let (scriptruns
        fredp)
    (when (not (typep (namestring truename) 'encoded-string)) ;; ugh
      (let (refnum)
        (unwind-protect 
          (unless (eq -1 (setq refnum (with-pstrs ((np (mac-namestring truename))) (#_HOpenResFile 0 0 np #$fsrdperm))))
            (with-macptrs ((fred4 (#_Get1Resource :FRED 4))
                           (fred2 (#_get1resource :fred 2)))
              (unless (%null-ptr-p fred2)(setq fredp t))  ; want to know if fred wrote this file
              (unless (%null-ptr-p fred4)
                (#_LoadResource fred4)
                (let ((n (ash (#_gethandlesize fred4) -2)))
                  (declare (fixnum n))
                  (setq scriptruns (make-array n :ELEMENT-TYPE '(UNSIGNED-BYTE 32))) ; 5/26
                  (dotimes (i n)
                    (setf (uvref scriptruns i)(%hget-long fred4 (ash i 2))))))))
          (unless (eq refnum -1)
            (#_CloseResFile refnum)))))
    (values scriptruns fredp)))




;; will detect whether this or another application has it open for writing?? - seems to
(defun open-for-write-test (name &optional no-error)  
  (rletz ((fsref :fsref))    
    (path-to-fsref name fsref)
    (open-for-write-test2 fsref no-error)))

(defun open-for-write-test2 (fsref &optional no-error) ;; no-error is always T?
  (let ((fname (data-fork-name)))
    (rletZ ((paramBlock :FSForkIOParam))
      (setf (pref paramblock :FSForkIOParam.ref) fsref
            (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)
            (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
            (pref paramblock :FSForkIOParam.permissions) #$fsrdwrperm)
      (let ((res (#_PBOpenForkSync paramblock)))
        (if (eql res #$noerr)
          (#_PBCloseForkSync paramblock)        
          (unless no-error
            (signal-file-error res (%path-from-fsref fsref))))          
        res))))
  

#|
(defun set-path-node-open-bit (truename)
  (rlet ((fsref :fsref))
    (make-fsref-from-path truename fsref)
    (set-fsref-node-open-bit fsref)))

(defun set-fsref-node-open-bit (fsref)  
  (rlet ((cat-info :fscataloginfo))
    (fsref-get-cat-info fsref cat-info #$kFSCatInfoNodeFlags)
    (let ((poo (logior #$kFSNodeForkOpenMask (pref cat-info :fscataloginfo.nodeflags))))
      (setf (pref cat-info :fscataloginfo.nodeflags) poo)
      (fsref-set-cat-info fsref cat-info #$kFSCatInfoNodeFlags))))
|#

(defun open-internal (filename direction element-type if-exists if-does-not-exist
                               external-format ef-supplied fork elements-per-buffer
                               mac-file-creator output-file-script-p input-file-script
                               &aux fstream truename (ostype external-format)
                               (resource-fork-p (eq fork :resource))
		               tem-file bits)
  (block open
    (unless (or (eq fork :data) (eq fork :resource))
      (%badarg fork '(member :data :resource)))
    (if (or (memq element-type '(:default character base-character))
            (subtypep element-type 'character))
      (progn
        (if (eq element-type :default)(setq element-type 'base-character))      ; will have to be changed when base-character ≠ character
        (if (memq external-format '(:default :unix))
          (setq ostype :TEXT)))           ; should character output be prohibited to non-TEXT files?  if so, why ?
      (progn
        (setq element-type (type-expand element-type))
        (cond ((equal element-type '#.(type-expand 'signed-byte))
               (setq element-type '(signed-byte 8)))
              ((equal element-type '#.(type-expand 'unsigned-byte))
               (setq element-type '(unsigned-byte 8))))))
    (if (eq ostype :default)
      (setq ostype :????))
    (case direction
      (:probe (setq if-exists :ignored if-does-not-exist nil))
      (:input (setq if-exists :ignored))
      ((:io :output :shared) nil)
      (t (report-bad-arg direction '(member :input :output :io :probe :shared))))
    (multiple-value-setq (truename bits)(probe-file-x filename))
    (if truename
      (if (%ilogbitp $ioDirFlg bits)
        (if (eq direction :probe)
          (return-from open nil)
          (signal-file-error $xdirnotfile truename))
        (if (setq filename (if-exists if-exists truename "Open…"))
          (progn
            (if (neq filename truename)(multiple-value-setq (truename bits) (probe-file-x filename))) ;; <<
            (cond 
             ((not truename)
              (setq truename (create-file filename :mac-file-type ostype 
                                          :mac-file-creator mac-file-creator)))
             ((memq direction '(:output :io :shared))                        
              ; this prevents us from writing a file that is open for anything - not quite true            
              ; but does not protect against reading a file that is open for :output
              (when (and bits (eq direction :output))
                (when (neq 0 (logand bits #x81))
                  (signal-file-error $xfilebusy truename)))
              (when (eq if-exists :supersede)
                (setq tem-file (gen-file-name truename))
                (cond (nil ;*alias-manager-present*                   
                       (create-file tem-file :mac-file-type ostype :mac-file-creator mac-file-creator)
                       (when (not (zerop (exchange-files tem-file truename nil)))
                         (rename-file truename tem-file :if-exists :supersede)
                         (create-file truename :mac-file-type ostype :mac-file-creator mac-file-creator)))
                      (t (rename-file truename tem-file)
                         (create-file truename :mac-file-type ostype :mac-file-creator mac-file-creator)))
                (lock-file tem-file))
              (when (and ef-supplied (eq if-exists :overwrite))
                (set-mac-file-type truename ostype)))))
          (return-from open nil)))
      (if (setq filename (if-does-not-exist if-does-not-exist filename))
        (setq truename (create-file filename :mac-file-type ostype :mac-file-creator mac-file-creator))
        (return-from open nil)))
    (setq fstream (if ;(memq element-type '(character base-character extended-character standard-char)) ;
                    (subtypep element-type 'character)
                    (let (scriptruns fredp)
                      (when (or (eq direction :input)(and (eq direction :io)(neq if-exists :overwrite)))
                        (let ((utfp (and (fboundp 'fsopen)(utf-something-p truename))))
                          (when (and utfp (eq external-format :default))
                            (if (eq utfp :utf-8)
                              (setq external-format :utf8)
                              (if (eq utfp :utf-16)
                                (progn (setq external-format :|utxt|)
                                       (setq element-type 'extended-character)))))
                          (multiple-value-setq (scriptruns fredp)(read-scriptruns truename))
                          ;; ??
                          (when (and (not fredp)(not utfp)) (setq scriptruns input-file-script))))
                      ; if has fred 2 resource assume fred knows best.
                      (make-instance (if (and (eq direction :input) scriptruns)
                                       'input-script-file-stream
                                       (if (and (eq direction :output)
                                                output-file-script-p) ; or *input-file-script*? nah
                                         'output-script-file-stream
                                         (getf '(:input input-file-stream
                                                 :output output-file-stream
                                                 :io io-file-stream
                                                 :shared io-file-stream
                                                 :probe file-stream)
                                               direction)))
                        :filename truename
                        :scriptruns scriptruns ; <<
                        :element-type element-type
                        :direction direction
                        :resource-fork-p resource-fork-p
                        :elements-per-buffer elements-per-buffer
                        :orig-filename tem-file
                        :external-format external-format))
                    (make-instance (getf '(:input input-binary-file-stream
                                           :output output-binary-file-stream
                                           :io io-binary-file-stream
                                           :shared io-binary-file-stream
                                           :probe binary-file-stream)
                                         direction)
                      :filename truename
                      :direction direction
                      :external-format external-format
                      :element-type element-type
                      :resource-fork-p resource-fork-p
                      :elements-per-buffer elements-per-buffer
                      :orig-filename tem-file)))
    (cond ((eq if-exists :append)
           (file-position fstream :end))
          ((and (memq direction '(:io :output :shared)) (neq if-exists :overwrite))
           (file-length fstream 0)))
    #|  (unless (eq (stream-external-format fstream) ostype)
    (warn "Stream-external-type of ~s is not ~s ." fstream ostype))
|#
    fstream))

#|
(defun gen-file-name (path)
  (let* ((date (mac-file-write-date path))
         (tem-path (merge-pathnames (make-pathname :name (%integer-to-string date) :type "tem" :defaults nil) path)))
    (loop
      (when (not (probe-file tem-path)) (return tem-path))
      ;; no can do cause of namestring-hash
      (setf (%pathname-name tem-path) (%integer-to-string (setq date (1+ date)))))))
|#

(defun gen-file-name (path)
  (let* ((date (mac-file-write-date path))
         tem-path)
    (loop
      (setq tem-path (make-pathname :name #|(%str-cat "." (%integer-to-string date))|# (%integer-to-string date) ;; "." keeps Spotlight away? - no such luck
                                    :type "tem" :defaults path))
      (when (not (probe-file tem-path)) (return tem-path))      
      (setq date (1+ date))
      )))


(defclass file-stream (stream)
  ((my-file-name :initarg :filename :reader stream-filename)
   (column.fblock :initform (cons 0 nil) :reader column.fblock)
   (fblock)
   (element-type :initform 'base-character :initarg :element-type)
   (orig-file-name :initarg :orig-filename)
   ;; below not to be confused with stream-external-format !
   (external-format :initarg :external-format :initform :macintosh :reader external-format)))

(defclass input-file-stream (file-stream input-stream) ())
(defclass input-script-file-stream (input-file-stream) ())

(defvar *input-script-file-stream-class* (find-class 'input-script-file-stream))

(defclass output-file-stream (file-stream output-stream) ())
(defclass output-script-file-stream (output-file-stream) ())

(defvar *output-script-file-stream-class* (find-class 'output-script-file-stream))

(defclass io-file-stream (input-file-stream output-file-stream) ())

(defmethod print-object ((stream file-stream) output-stream)
  (print-unreadable-object (stream output-stream)
    (format output-stream "~A ~S to ~S"
            (or (stream-direction stream) :probe)
            (class-name (class-of stream))
            (namestring (stream-filename stream)))))

(defmethod initialize-instance :after ((stream file-stream) &key 
                                       direction resource-fork-p
                                       scriptruns
                                       (elements-per-buffer *elements-per-buffer*)
                                       (element-type 'base-character)
                                       external-format)
  (setf (slot-value stream 'direction) direction)
  (when direction
    (let* ((filename (slot-value stream 'my-file-name))
           (fblock (%fopen (truename filename)
                           0
                           (case direction
                             ((:input :probe) $fsRdPerm)
                             (:output $fsRdWrPerm)
                             (:io $fsRdWrPerm)
                             (:shared $fsRdWrShPerm))
                           resource-fork-p
                           stream
                           element-type
                           elements-per-buffer
                           scriptruns
                           external-format)))
      (set-slot-value stream 'fblock fblock)
      (setf (cdr (column.fblock stream)) fblock)
      (push stream *open-file-streams*))))

(defmethod stream-element-type ((stream file-stream))
  (slot-value stream 'element-type))

(defmethod stream-tyi ((stream input-file-stream))
  (let ((it (%ftyi (slot-value stream 'fblock))))
    (if (eq it #\linefeed)
      (if (eq (external-format stream) :unix) (or *preferred-eol-character* #\return) it)
      it)))

(defmethod stream-tyi ((stream input-script-file-stream))
  (%hairy-ftyi (slot-value stream 'fblock)))

(defvar *input-file-stream-class* (find-class 'input-file-stream))


(defmethod stream-reader ((stream input-file-stream))
  (maybe-default-stream-reader (stream *input-file-stream-class*)
    (values (if (eq (external-format stream) :unix) #'%ftyi-unix #'%ftyi) (slot-value stream 'fblock))))

;; from streams.lisp - move it there
#+ignore
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

(defun %ftyi-unix (fblock)
  (let ((it (%ftyi fblock)))
    (if (eq it #\linefeed) (or *preferred-eol-character* #\return) it)))

(defmethod stream-reader ((stream input-script-file-stream))
  (maybe-default-stream-reader (stream *input-script-file-stream-class*)
    (values #'%hairy-ftyi (slot-value stream 'fblock))))

(defmethod stream-untyi ((stream input-file-stream) char)
  (%funtyi (slot-value stream 'fblock) char))

(defmethod stream-eofp ((stream input-file-stream))
  (%feofp (slot-value stream 'fblock)))

(defmethod stream-close :after ((stream file-stream))
  (when (slot-boundp stream 'fblock)
    (let ((fblock (slot-value stream 'fblock)))
      (when fblock (%fclose fblock))
      (setq *open-file-streams* (nremove stream *open-file-streams*))
      (let ((tem (slot-value stream 'orig-file-name))) ; orig-file-name s.b. called orig-contents 
        (when tem (unlock-file tem)(delete-file tem :temporary-file-p t)))
      (slot-makunbound stream 'fblock)
      (slot-makunbound stream 'column.fblock)
      t)))

(defmethod stream-abort ((stream file-stream))
  (when (slot-boundp stream 'fblock)
    (let ((fblock (slot-value stream 'fblock)))
      (when fblock (%fclose fblock))
      (setq *open-file-streams* (nremove stream *open-file-streams*))
      (let ((tem (slot-value stream 'orig-file-name)))
        (when tem          
          (let ((new (slot-value stream 'my-file-name)))
            (unlock-file tem) ; without interrupts ?
            (delete-file new :temporary-file-p t)                          
            (rename-file tem new))))
      (slot-makunbound stream 'fblock)
      t)))

(defmethod stream-tyo ((stream output-file-stream) char)
  (file-stream-tyo (column.fblock stream) char))

(defmethod stream-fresh-line ((stream output-file-stream))
  (unless (eql 0 (stream-column stream))
    (stream-tyo stream (or *preferred-eol-character* #\return))
    t))

(defvar *output-file-stream-class* (find-class 'output-file-stream))

(defmethod stream-writer ((stream output-file-stream))
  (maybe-default-stream-writer (stream *output-file-stream-class*)
    (values #'file-stream-tyo (column.fblock stream))))

(defmethod stream-tyo ((stream output-script-file-stream) char)
 (script-file-stream-tyo (column.fblock stream) char))

(defmethod stream-writer ((stream output-script-file-stream))
  (maybe-default-stream-writer (stream *output-script-file-stream-class*)
    (values #'script-file-stream-tyo (column.fblock stream))))



(defun file-stream-tyo (column.fblock char)
  (let ((col (car column.fblock)))
    (%rplaca column.fblock
          (if (char-eolp char)
            0
            (if col (1+ col))))
    (%ftyo (%cdr column.fblock) char)))

(defun script-file-stream-tyo (column.fblock char)
  (let ((col (car column.fblock)))
    (%rplaca column.fblock
             (if (char-eolp char)
               0
               (if col (1+ col))))
    (let ((code (char-code char)))
      (if (%i> code #xff)
        (progn 
          (%ftyo (%cdr column.fblock)(%code-char (ash code -8)))
          (%ftyo (%cdr column.fblock)(%code-char (%ilogand code #xff))))
        (%ftyo (%cdr column.fblock) char)))))



(defmethod stream-column ((stream file-stream))
  (let* ((column.fblock (column.fblock stream))
         (direction (slot-value stream 'direction))
         column)
    (if (and (eq direction :output)
             (setq column (car column.fblock)))
      column
      (let* ((fblock (cdr column.fblock))
             (old-pos (%fpos fblock nil)))
        (unwind-protect
          (setq column
                (do* ((pos (1- old-pos) (1- pos)))
                     ((<= pos 0) old-pos)
                  (%fpos fblock pos)
                  (if (char-eolp (%ftyi fblock))
                    (return (- old-pos pos 1)))))
          (%fpos fblock old-pos))
        (if (eq direction :output)
          (setf (car column.fblock) column))))))

(defmethod file-length ((stream file-stream) &optional new-length)
  (let* ((block (slot-value stream 'fblock))
         (old-size (%fsize block)))
    (when (and new-length (< new-length old-size))
      (%fpos block new-length t))
    (when new-length (%fsize block new-length))
    (or new-length old-size)))

(defun file-position (stream &optional position)
  (stream-position stream position))

(defmethod stream-position ((stream file-stream) &optional position)
  (let* ((column.fblock (column.fblock stream))
         (fblock (cdr column.fblock)))
    (when (null position)
      (return-from stream-position (%fpos fblock nil)))
    (let ((length (file-length stream)))
      (setq position (cond ((eq position :start) 0)
                           ((eq position :end) length)
                           (t (require-type position 'integer))))
      (when (> position length)
        (if (typep stream 'output-file-stream)
          ; Why not do something useful?
          (let* ((diff (- position length)))
            (file-length stream position)
            (file-position stream length)
            (if (subtypep (stream-element-type stream) 'character)
              (dotimes (i diff) (write-char #\null stream))
              (dotimes (i diff) (write-byte 0 stream))))
          (error "~s is beyond the length of the file, which is currently ~s"
                 position length))))
    (when (eq (slot-value stream 'direction) :output)
      ; below says I dunno what the column is
      (setf (car column.fblock)(if (eq 0 position) 0 nil)))
    (%fpos fblock position)
    position))

(defmethod stream-force-output ((stream output-file-stream))
  (%fclose (slot-value stream 'fblock) t))

(defmethod stream-finish-output ((stream output-file-stream))
  (%fclose (slot-value stream 'fblock) 'finish-output))

; If there get to be EXTENDED-CHARs, and strings of 'em, this has to do 
; something appropriate. Unused but is documented.

(defmethod file-string-length ((stream file-stream) object)
  (when (subtypep (stream-element-type stream) 'character)
    (cond ((extended-character-p object) 2)
          ((base-character-p object) 1)
          ((stringp object)
           (if (or (typep stream 'input-script-file-stream)  ; who knows
                   (typep stream 'output-script-file-stream))
             (byte-length object)
             (length object)))
          (t (file-string-length stream (require-type object '(or string character)))))))

(defmethod stream-external-format ((stream file-stream))
  (mac-file-type (stream-pathname stream)))

(defun font-script-installed-p (font)
  (without-interrupts
   (let* ((script (#_FontToScript font)) 
          (flag (#_getscriptmanagervariable #$smdefault)))
     (when (eq flag 0) script) ; flag false if installed
     )))

(defun script-installed-p (script)
  (memq script *script-list*))  

(defun ff-script-installed-p (ff)
  (let* ((f (point-v ff)))
    (font-script-installed-p f)))

#| moved to l1-windows merge with thing that gets *font-list*
(def-ccl-pointers scripts2 ()
  (let (fonts scripts)
    (unwind-protect
      (%stack-block ((ip 2) (tp 4) (np 256))
        (#_SetResLoad nil)
        (do* ((index (#_CountResources "FOND") (1- index))
              (ret nil))
             ((eq index 0) ret)
          (#_getresinfo (#_GetIndResource "FOND" index) ip tp np)
          (let ()
            (pushnew (%get-word ip) fonts))))
      (#_SetResLoad t))
    (dolist (f fonts)
      (let* ((script (font-script-installed-p f)))
        (when script (pushnew script scripts))))
    (setq *script-list* scripts)))
|#



;; Kindler Gentler World section

(defmethod stream-listen (stream)
  (declare (ignore stream))
  nil)


;;; Initialize the global streams

; These are defparameters because they replace the ones that were in l1-init
; while bootstrapping.

(defparameter *terminal-io* (make-instance 'terminal-io))

(defparameter *pop-up-terminal-io* (make-instance 'pop-up-terminal-io))

(defparameter *debug-io* *terminal-io*)

(defparameter *query-io* *pop-up-terminal-io*)
(defparameter *error-output* *pop-up-terminal-io*)

(proclaim '(special *standard-input* *standard-output* *trace-output*))
(setq *standard-input*
  (setq *standard-output*
        ; was *terminal-io* - i like this better.
     (setq *trace-output* *front-listener-terminal-io*)))

(proclaim '(stream 
          *query-io* *debug-io* *error-output* *standard-input* 
          *standard-output* *trace-output*))
      








; end of L1-streams.lisp

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
