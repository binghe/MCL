

;;	Change History (most recent first):
;;  3 7/4/97   akh  see below
;;  2 6/2/97   akh  #@ does big points
;;  9 1/22/97  akh  probably no change
;;  6 4/12/96  bill 3.1d98
;;  4 2/19/96  akh  get-macro-character handles readtable nil
;;                  set-macro-character handles function nil
;;  3 2/19/96  akh  fix preserve whitespace option
;;  1 11/13/95 gb   split off from l1-readloop.lisp
;;  (do not edit before this line!!)
;;; READ and related functions.

;; simple-reader-error condition defined here - inherits from reader-error
;;  define and use function signal-reader-error
;; remove altcheckmark from *name-char-alist*
;; #\newline = linefeed - nope
;; fix dispatch-macro-character for #\: to allow #:|6|
;; ------- 5.2b6
;; %parse-token handles float overflow/underflow errors and does a reader-error - add 2 reader-error conditions
;; ----- 5.2b1
;; *name-char-alist* - #\return precedes #\newline
;; 10/16/O5 - unicode nbsp in %initial-readtable% (not E circumflex)
;; 12/11/04 eol stuff
;; ------ 5.1final
;; new #u-reader
;; fix casify-token when :invert - from Thomas Russ
;; --------- 5.0final
;; initial value of *linefeed-equals-newline* is NIL !
;; ------- 4.4b5
;; |;-reader| treat linefeed like newline if *linefeed-equals-newline* is true - the default
;; read-eval signals reader-error vs plain error: from Gary Warren King
;; -------- 4.4b4
;; %unreadable takes stream arg
;; -------- 4.3f1c1
;; 07/19/98 akh fix set-macro-character and set-dispatch-macro-charater etal for possible extended chars
;; 10/07/97 akh set-macro-character allows extended-character when fn is nil - useless actually
;; 06/17/97 akh #@ uses make-big-point to make big points
;; 05/01/97 akh add #f for readable float nans and infinities
;; 04/28/97 akh  #@ works for BIG points
;; -------------- 4.1
;; 05/24/96 bill merge "read-dispatch-patch":
;;               In read-dispatch, dispatch on subchar, not char.
;;               In %parse-expression: call the default function for a dispatch
;;               char, let it do the dispatch (see read-dispatch, it's usually
;;               installed for #/#)
;;               Comma before #'read-dispatch in %initial-readtable% initform.
;; 05/13/96 bill Fix brain-damage in set-macro-character
;; 04/12/96 bill Gary's fix to %collect-xtoken and its callers so that :|| will read correctly.
;; 03/04/96 bill set-macro-character accepts a symbol or a function for its second arg.
;;               %parse-expression funcalls any non-nil atom, not just functions.
;; 01/31/96  gb  Bill's fix to %collect-xtoken.

(eval-when (:compile-toplevel :execute)
  (defconstant readtable-case-keywords '((:upcase . 1) (:downcase . 2) (:preserve . 0)
                                         (:invert . -1) (:studly . -2)))
  (defmacro readtable-case-keywords () `',readtable-case-keywords))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *name-char-alist*
  '(("Null" . #\000) ("Nul" . #\000)
    ("Home" . #\001)
    ("Enter" . #\003)
    ("End" . #\004)
    ("Help" . #\005)
    ("Bell"  . #\007) ; ^G , used by Franz (and others with bells.)
    ("Delete" . #\010) ("Backspace" . #\010)("BS" . #\010)
    ("Tab" . #\011)
    ("PageUp" . #\013)
    ("Page" . #\014)("PageDown" . #\014)("Formfeed" . #\014) ("FF" . #\014)
    ("Newline" . #\015)   ;; ??
    ("Linefeed" . #\012) ("LF" . #\012)
    ("Return" . #\015) ("CR" . #\015)
    ("CommandMark" . #\021)  ;; these 4 are magic marks for menus
    ("CheckMark" . #\022)
    ("DiamondMark" . #\023)
    ("AppleMark" . #\024)
    ("ESC" .  #\033) ("Escape" . #\033) ("Clear" .  #\033)
       ("Altmode" .  #\033) ("ALT" .  #\033)
    ("BackArrow" . #\034) ("Backward-arrow" . #\034)
    ("ForwardArrow" . #\035) ("Forward-arrow" . #\035)
    ("UpArrow" . #\036) ("Up-arrow" . #\036)
    ("DownArrow" . #\037) ("Down-arrow" . #\037)
    ("Space" . #\040)
    ("Dot" . #.(code-char #x2022))  ;("Dot" . #\245)
    #|("altCheckMark" . #\303) |# ;; also magic mark for menu
    ("DEL" . #\177)("ForwardDelete" . #\177) ("Rubout" . #\177)
    ))

; Character names are stored in *NAME-CHAR-ALIST* which consists of
; (name . char) where name must be a simple string and char must be
; a character.

;(NAME-CHAR name)
;If name has an entry in the *NAME-CHAR-ALIST*, return first such entry.
;Otherwise, if it consists of one char, return it.
;Otherwise, if it consists of two chars, the first of which  is ^,
; return %code-char(c xor 64), where c is the uppercased second char.
;Otherwise, if it consists of octal digits, the digits are
; interpreted as the (mod 256) ascii code of a character.
;Otherwise return NIL.

(defun name-char (name)
  (if (characterp name)
    name
    (let* ((name (string name)))
      (let* ((namelen (length name)))
        (declare (fixnum namelen))
        (or (cdr (assoc name *name-char-alist* :test #'string-equal))
         (if (= namelen 1)
           (char name 0)
           (if (and (= namelen 2) (eq (char name 0) #\^))
             (code-char (the fixnum (logxor (the fixnum (char-code (char-upcase (char name 1)))) #x40)))
             (let* ((n 0))
               (dotimes (i namelen (code-char n))
                 (let* ((code (the fixnum (- (the fixnum (char-code (char name i)))
                                             (char-code #\0)))))
                   (declare (fixnum code))
                   (if (and (>= code 0)
                            (<= code 7))
                     (setq n (logior code (the fixnum (ash n 3))))
                     (return))))))))))))

(defun whitespacep (char)
  (when (fixnump char) (setq char (%code-char char)))
  (%str-member char #.wsp&cr))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;			Readtables					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Readtable = istructure with data [1] type-table and [2] macro-char-alist
; Type-table is a 256 byte ivector with a type byte for each char.
; macro-char-alist is a list of (char . defn).  The defn is either a
; cons of (#'read-dispatch . macro-char-alist) for
; dispatch macros, or it is a function or a symbol to call for simple macros.

(defun readtablep (object) (istruct-typep object 'readtable)) 

(defun readtable-arg (object)
  (if (null object) (setq object *readtable*))
  (unless (istruct-typep object 'readtable)
    (report-bad-arg object 'readtable))
  object)

(eval-when (:compile-toplevel :execute)
(def-accessors %svref
  token.string
  token.ipos
  token.opos
  token.len
  token.extendp                       ; Is token.string extended ?
)

(defmacro with-token-buffer ((name) &body body &environment env)
  (multiple-value-bind (body decls) (parse-body body env nil)
    `(let* ((,name (vector (%get-token-string 16) 0 0 16 nil)))
       (declare (dynamic-extent ,name))
       (unwind-protect
         (locally ,@decls ,@body)
         (%return-token-string ,name)))))
)

(defun read-dispatch (stream char)
  (let* ((info (cdr (assq char (rdtab.alist *readtable*)))))
    (with-token-buffer (tb)
      (multiple-value-bind (fn arg) (stream-reader stream)
        (let* ((subchar nil)
               (numarg nil))
          (loop
            (if (digit-char-p (setq subchar (%read-char-no-eof stream fn arg)))
              (%add-char-to-token subchar tb)
              (return (setq subchar (char-upcase subchar) 
                            numarg (%token-to-number tb 10)))))
          (let* ((dispfun (cdr (assq subchar (cdr info)))))     ; <== WAS char
            (if dispfun
              (funcall dispfun stream subchar numarg)
              (signal-reader-error stream 
                                   "Undefined character ~S in a ~S dispatch macro."
                                   subchar char))))))))

; This -really- gets initialized later in the file
(defvar %initial-readtable%
  (let* ((ttab (make-array 256 :element-type '(signed-byte 8)))
         (wspc `(#\Null #\Tab #\Linefeed #\Page #\Return #\Space ,(code-char #xa0))) ;$CA=non-break space nope
         (macs `((#\# . (,#'read-dispatch))))
         (case :upcase))
    (dotimes (i 256) (declare (fixnum i))(uvset ttab i $cht_cnst))
    (dolist (ch wspc) (uvset ttab (%char-code ch) $cht_wsp))
    (uvset ttab (char-code #\\) $cht_sesc)
    (uvset ttab (char-code #\|) $cht_mesc)
    (uvset ttab (char-code #\#) $cht_ntmac)
    (%istruct 'readtable ttab macs case)))

(defparameter *readtable* %initial-readtable%)
(queue-fixup (setq %initial-readtable% (copy-readtable *readtable*)))

(defun copy-readtable (&optional (from *readtable*) to)
  (setq from (if from (readtable-arg from)  %initial-readtable%))
  (let* ((fttab (rdtab.ttab from))
         (ftsize (uvsize fttab)))
    (when to
      (setq to (readtable-arg to))
      (let* ((tttab (rdtab.ttab to))
             (ttsize (uvsize tttab)))
        (if (not (eql ftsize ttsize))
          (setf (rdtab.ttab to)(make-array ftsize :element-type '(signed-byte 8))))))
    (when (not to)
      (setq to 
            (%istruct 'readtable
                      (make-array ftsize :element-type '(signed-byte 8))
                      nil (rdtab.case from))))
    (setf (rdtab.alist to) (copy-tree (rdtab.alist from)))
    (setf (rdtab.case to) (rdtab.case from))
    (let* ((tttab (rdtab.ttab to)))
      (dotimes (i ftsize to)
        (setf (uvref tttab i) (uvref fttab i))))))

(declaim (inline %character-attribute))

; This is supposed to hide the fact that all extended characters are
; implicitly and permanently $cht_cnst - no longer always true, pretty likely though
(defun %character-attribute (char attrtab)
  (declare (character char)
           (type (simple-array (signed-byte 8) (*)) attrtab)
           (optimize (speed 3) (safety 0)))
  (let* ((code (char-code char)))
    (declare (fixnum code))
    (if (>= code (uvsize attrtab)) $cht_cnst (aref attrtab code))))

; returns: (values attrib <aux-info>), where
;           <aux-info> = (char . fn), if terminating macro
;                      = (char . (fn . dispatch-alist)), if dispatching macro
;                      = nil otherwise


(defun %get-readtable-char (char &optional (readtable *readtable*))
  (setq char (require-type char 'character))
  (let* ((attr (%character-attribute char (rdtab.ttab readtable))))
    (declare (fixnum attr))
    (values attr (if (logbitp $cht_macbit attr) (assoc char (rdtab.alist readtable))))))


(defun set-syntax-from-char (to-char from-char &optional to-readtable from-readtable)
  (setq to-char (require-type to-char 'character))
  (setq from-char (require-type from-char 'character))
  (setq to-readtable (readtable-arg to-readtable))
  (setq from-readtable (readtable-arg (or from-readtable %initial-readtable%)))
  (if (typep to-char 'extended-character)
    (maybe-extend-readtable to-readtable))
  (multiple-value-bind (from-attr from-info) (%get-readtable-char from-char from-readtable)
    (let* ((new-tree (copy-tree (cdr from-info)))
           (old-to-info (nth-value 1 (%get-readtable-char to-char to-readtable))))
      (without-interrupts
       (if from-info
         (if old-to-info
           (setf (cdr old-to-info) new-tree)
           (push (cons to-char new-tree) (rdtab.alist to-readtable)))
         (if old-to-info
           (setf (rdtab.alist to-readtable) (delq old-to-info (rdtab.alist to-readtable)))))
       (setf (uvref (rdtab.ttab to-readtable) (char-code to-char)) from-attr))
      t)))

(defun get-macro-character (char &optional readtable)  
  (setq readtable (readtable-arg readtable))
  (multiple-value-bind (attr info) (%get-readtable-char char readtable)
    (declare (fixnum attr) (list info))
    (let* ((def (cdr info)))
      (values (if (consp def) (car def) def)
              (= attr $cht_ntmac)))))

(defun set-macro-character (char fn &optional non-terminating-p readtable)
  (setq char (require-type char 'character))
  (setq readtable (readtable-arg readtable))
  (when (typep char 'extended-character)
    (maybe-extend-readtable readtable))
  (when fn
    (unless (or (symbolp fn) (functionp fn))
      (setq fn (require-type fn '(or symbol function)))))
  (let* ((info (nth-value 1 (%get-readtable-char char readtable))))
    (declare (list info))
    (without-interrupts
     (setf (uvref (rdtab.ttab readtable) (char-code char))
           (if (null fn) $cht_cnst (if non-terminating-p $cht_ntmac $cht_tmac)))
     (if (and (null fn) info)
       (setf (rdtab.alist readtable) (delete info (rdtab.alist readtable) :test #'eq)) 
       (if (null info)
         (push (cons char fn) (rdtab.alist readtable))
         (let* ((def (cdr info)))
           (if (atom def)
             (setf (cdr info) fn)         ; Non-dispatching
             (setf (car def) fn))))))     ; Dispatching
    t))

#+ppc-target
;; ya get what ya ask for
(defun maybe-extend-readtable (readtable)
  (let* ((tab (rdtab.ttab readtable))
         (old-size (uvsize tab)))
    (declare (fixnum old-size))
    (if (< old-size (1+ char-code-limit))
      (let ((newtab (%extend-vector 0 tab (1+ char-code-limit))))  ;; 68K ??
        (dotimes (i (- (1+ char-code-limit) old-size))
          (declare (fixnum i))
          (setf (uvref newtab (the fixnum (+ i old-size))) $cht_cnst))
        (setf (rdtab.ttab readtable) newtab)))))

#-ppc-target ;; this file is ppc only anyway so this is a noop
(defun maybe-extend-readtable (readtable)  
  (let* ((tab (rdtab.ttab readtable))
         (old-size (uvsize tab)))
    (declare (fixnum old-size))
    (if (< old-size (1+ char-code-limit))
      (let ((newtab (make-array (1+ char-code-limit) :element-type '(unsigned-byte 8)
                                :initial-element $cht_cnst)))
        (dotimes (i old-size)
          (setf (uvref newtab i) (uvref tab i)))))))

(defun readtable-case (readtable)
  (let* ((case (rdtab.case (readtable-arg readtable))))
    (if (symbolp case)
      case
      (%car (rassoc case (readtable-case-keywords) :test #'eq)))))

(defun %set-readtable-case (readtable case)
  (check-type case (member :upcase :downcase :preserve :invert))
  (setf (rdtab.case (readtable-arg readtable)) case))
  
(defsetf readtable-case %set-readtable-case)

(defun make-dispatch-macro-character (char &optional non-terminating-p readtable)
  (setq readtable (readtable-arg readtable))
  (setq char (require-type char 'character))
  (if (typep char 'extended-character)
    (maybe-extend-readtable readtable))
  (let* ((info (nth-value 1 (%get-readtable-char char readtable))))
    (declare (list info))
    (without-interrupts
     (setf (uvref (rdtab.ttab readtable) (char-code char))
           (if non-terminating-p $cht_ntmac $cht_tmac))
     (if info
       (rplacd (cdr info) nil)
       (push (cons char (cons #'read-dispatch nil)) (rdtab.alist readtable)))))
  t)

(defun get-dispatch-macro-character (disp-ch sub-ch &optional (readtable *readtable*))
  (setq readtable (readtable-arg (or readtable %initial-readtable%)))
  (setq disp-ch (require-type disp-ch 'character))
  (setq sub-ch (char-upcase (require-type sub-ch 'character)))
  (unless (digit-char-p sub-ch 10)
    (let* ((def (cdr (nth-value 1 (%get-readtable-char disp-ch readtable)))))
      (if (consp (cdr def))
        (cdr (assq sub-ch (cdr def)))
        (error "~A is not a dispatching macro character in ~s ." disp-ch readtable)))))

(defun set-dispatch-macro-character (disp-ch sub-ch fn &optional readtable)
  (setq readtable (readtable-arg readtable))
  (setq disp-ch (require-type disp-ch 'character))
  (if (typep disp-ch 'extended-character) (maybe-extend-readtable readtable))
  (setq sub-ch (char-upcase (require-type sub-ch 'character)))  ;; was base-character
  (when (digit-char-p sub-ch 10)
    (error "subchar can't be a decimal digit - ~a ." sub-ch))
  (let* ((info (nth-value 1 (%get-readtable-char disp-ch readtable)))
         (def (cdr info)))
    (declare (list info))
    (unless (consp def)
      (error "~A is not a dispatching macro character in ~s ." disp-ch readtable))
    (let* ((alist (cdr def))
           (pair (assq sub-ch alist)))
      (if pair
        (setf (cdr pair) fn)
        (push (cons sub-ch fn) (cdr def))))
    t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;				Reader					;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *read-eval* t "When nil, #. signals an error.")
(defvar %read-objects% nil)
(defvar %keep-whitespace% nil)
(defglobal %parse-string% (make-string 256 :element-type 'base-character))



(defglobal %token-strings%  (%cons-pool nil))
(defglobal %token-xstrings% (%cons-pool nil))

(defun %return-token-string (token)
  (let* ((str (token.string token))
         (pool (if (token.extendp token) %token-xstrings% %token-strings%)))
    (setf (token.string token) nil)
    (without-interrupts
     (setf (pool.data pool)
           (cheap-cons str (pool.data pool))))))

;Look for an exact match, else create a simple-string.
(defun %get-token-string (len &optional extendp)
  (declare (fixnum len))
  (without-interrupts
   (do* ((pool (if extendp %token-xstrings% %token-strings%))
         (head (cons nil (pool.data pool)))
         (prev head next)
         (next (cdr prev) (cdr next)))
        ((null next)
         (if extendp
           (make-string len :element-type 'extended-character)
           (make-string len :element-type 'base-character)))
     (declare (dynamic-extent head)
              (list head prev next))
     (let* ((s (car next)))
       (when (= len (length s))
         (rplacd prev (cdr next))
         (setf (pool.data pool) (cdr head))
         (free-cons next)
         (return s))))))

(defun %extend-token-string (token)
  (let* ((old-string (token.string token))
         (old-length (token.len token)))
    (declare (fixnum old-length))
    (let* ((new-length (the fixnum (ash old-length 1)))
           (new-string (%get-token-string new-length (token.extendp token))))
      (dotimes (i old-length)
        (setf (%scharcode new-string i)
              (%scharcode old-string i)))
      (%return-token-string token)
      (setf (token.string token) new-string
            (token.len token) new-length)
      token)))

(defun %add-char-to-token (char token)
  (let* ((len (token.len token))
         (opos (token.opos token)))
    (declare (fixnum len opos))
    (when (and (typep char 'extended-character)
               (not (token.extendp token)))
      (let* ((old (token.string token))
             (new (%get-token-string len t)))
        (dotimes (i len)
          (setf (%scharcode new i) (%scharcode old i)))
        (%return-token-string token)
        (setf (token.extendp token) t)  ; <<
        (setf (token.string token) new)))
    (when (= opos len)
      (%extend-token-string token))
    (setf (token.opos token) (the fixnum (1+ opos))
          (%schar (token.string token) opos) char)))

(defun %string-from-token (token)
  (let* ((opos (token.opos token))
         (ipos (token.ipos token))
         (tstr (token.string token))
         (len (the fixnum (- opos ipos)))
         (string (if (token.extendp token)
                   (make-string len :element-type 'extended-character)
                   (make-string len :element-type 'base-character))))
    (do* ((k 0 (1+ k))
          (i ipos (1+ i)))
         ((= i opos) string)
      (declare (fixnum i k))
      (setf (%scharcode string k) (%scharcode tstr i)))))

(defun %next-token-char (token)
  (let* ((ipos (token.ipos token)))
    (declare (fixnum ipos))
    (when (< ipos (the fixnum (token.opos token)))
      (setf (token.ipos token) (the fixnum (1+ ipos)))
      (%schar (token.string token) ipos))))

      
(defun input-stream-arg (stream)
  (cond ((null stream) *standard-input*)
        ((eq stream t) *terminal-io*)
        ;Otherwise, let ASK complain...
        (t stream)))




(defun %read-char-no-eof (stream fn arg)
  (or (funcall fn arg)
      (error 'end-of-file :stream stream)))

(defun %next-char-and-attr (stream fn arg &optional (attrtab (rdtab.ttab *readtable*)))
  (declare (ignore stream))
  (let* ((ch (funcall fn arg)))
    (values ch (if ch (%character-attribute ch attrtab)))))

(defun %next-non-whitespace-char-and-attr (stream fn arg)
  (let* ((attrtab (rdtab.ttab *readtable*)))
    (loop
      (multiple-value-bind (ch attr) (%next-char-and-attr stream fn arg attrtab)
        (if (null ch)
          (return (values nil nil))
          (unless (eql attr $cht_wsp)
            (return (values ch attr))))))))

(defun %next-char-and-attr-no-eof (stream fn arg &optional (attrtab (rdtab.ttab *readtable*)))
  (let* ((ch (%read-char-no-eof stream fn arg)))
    (values ch (%character-attribute ch attrtab))))

(defun %next-non-whitespace-char-and-attr-no-eof (stream fn arg)
  (let* ((attrtab (rdtab.ttab *readtable*)))
    (loop
      (multiple-value-bind (ch attr) (%next-char-and-attr-no-eof stream fn arg attrtab)
        (declare (fixnum attr))
        (unless (= attr $cht_wsp)
          (return (values ch attr)))))))

; "escapes" is a list of escaped character positions, in reverse order
#|
(defun %casify-token (token escapes)
  (let* ((case (readtable-case *readtable*))
         (opos (token.opos token))
         (string (token.string token)))
    (declare (fixnum opos))
    (if (and (null escapes) (eq case :upcase))          ; Most common case, pardon the pun
      ; %strup is faster - boot probs tho
      (dotimes (i opos)
        (setf (%schar string i) (char-upcase (%schar string i))))
      (unless (eq case :preserve)
        (when (eq case :invert)
          (let* ((all-lower t)
                 (some-either nil))
            (do* ((i (1- opos) (1- i))
                  (esclist escapes)
                  (nextesc (if esclist (pop esclist) -1)))
                 ((< i 0) (if some-either (setq case (if all-lower :upcase :downcase))))
              (declare (fixnum i nextesc))
              (if (= nextesc i)
                (setq nextesc (if esclist (pop esclist) -1))
                (let* ((ch (%schar string i)))
                  (if (upper-case-p ch)
                    (setq some-either t all-lower nil)
                    (if (lower-case-p ch)
                      (setq some-either t))))))))
        (if (eq case :upcase)
          (do* ((i (1- opos) (1- i))
                  (nextesc (if escapes (pop escapes) -1)))
               ((< i 0))
            (declare (fixnum i nextesc))
            (if (= nextesc i)
                (setq nextesc (if escapes (pop escapes) -1))
                (setf (%schar string i) (char-upcase (%schar string i)))))
          (if (eq case :downcase)
            (do* ((i (1- opos) (1- i))
                  (nextesc (if escapes (pop escapes) -1)))
               ((< i 0))
            (declare (fixnum i nextesc))
            (if (= nextesc i)
                (setq nextesc (if escapes (pop escapes) -1))
                (setf (%schar string i) (char-downcase (%schar string i)))))))))))
|#

;; from Thomas Russ
(defun %casify-token (token escapes)
  (let* ((case (readtable-case *readtable*))
         (opos (token.opos token))
         (string (token.string token)))
    (declare (fixnum opos))
    (if (and (null escapes) (eq case :upcase))          ; Most common case, pardon the pun
      ; %strup is faster - boot probs tho
      (dotimes (i opos)
        (setf (%schar string i) (char-upcase (%schar string i))))
      (unless (eq case :preserve)
        (when (eq case :invert)
          (let* ((lower-seen nil)
                 (upper-seen nil))
            (do* ((i (1- opos) (1- i))
                  (esclist escapes)
                  (nextesc (if esclist (pop esclist) -1)))
                 ((< i 0) (if upper-seen (unless lower-seen (setq case :downcase))
                                         (when lower-seen (setq case :upcase))))
              (declare (fixnum i nextesc))
              (if (= nextesc i)
                (setq nextesc (if esclist (pop esclist) -1))
                (let* ((ch (%schar string i)))
                  (if (upper-case-p ch)
                    (setq upper-seen t)
                    (if (lower-case-p ch)
                      (setq lower-seen t))))))))
        (if (eq case :upcase)
          (do* ((i (1- opos) (1- i))
                  (nextesc (if escapes (pop escapes) -1)))
               ((< i 0))
            (declare (fixnum i nextesc))
            (if (= nextesc i)
                (setq nextesc (if escapes (pop escapes) -1))
                (setf (%schar string i) (char-upcase (%schar string i)))))
          (if (eq case :downcase)
            (do* ((i (1- opos) (1- i))
                  (nextesc (if escapes (pop escapes) -1)))
               ((< i 0))
            (declare (fixnum i nextesc))
            (if (= nextesc i)
                (setq nextesc (if escapes (pop escapes) -1))
                (setf (%schar string i) (char-downcase (%schar string i)))))))))))

; MCL's reader has historically treated ||:foo as a reference to the symbol FOO in the 
; package which has the null string as its name.  Some other implementations treat it
; as a keyword.  This takes an argument indicating whether or not something was "seen"
; before the first colon was read, even if that thing caused no characters to be
; added to the token.

(defun %token-package (token colonpos seenbeforecolon)
  (if colonpos
    (if (and (eql colonpos 0) (not seenbeforecolon))
      *keyword-package*
      (let* ((string (token.string token)))
        (or (%find-pkg string colonpos)
            (%kernel-restart $XNOPKG (subseq string 0 colonpos)))))
    *package*))

;; Returns 3 values: reversed list of escaped character positions, explicit package
;; (if unescaped ":" or "::") or nil, t iff any non-dot, non-escaped chars in token,
;; and t if either no explicit package or "::"

(defun %collect-xtoken (token stream 1stchar)
  (multiple-value-bind (fn arg) (stream-reader stream)
    (let* ((escapes ())
           (nondots nil)
           (explicit-package *read-suppress*)
           (double-colon t)
           (multi-escaped nil))
      (do* ((attrtab (rdtab.ttab *readtable*))
            (char 1stchar (funcall fn arg)))
           ((null char))                ; EOF
        (flet ((add-note-escape-pos (char token escapes)
                 (push (token.opos token) escapes)
                 (%add-char-to-token char token)
                 escapes))
          (let* ((attr (%character-attribute char attrtab)))
            (declare (fixnum attr))
            (when (or (= attr $cht_tmac)
                      (= attr $cht_wsp))
              (when (or (not (= attr $cht_wsp)) %keep-whitespace%)
                (stream-untyi stream char))
              (return ))
            (if (= attr $cht_ill)
              (signal-reader-error stream "Illegal character ~S." char)
              (if (= attr $cht_sesc)
                (setq nondots t 
                      escapes (add-note-escape-pos (%read-char-no-eof stream fn arg) token escapes))
                (if (= attr $cht_mesc)
                  (progn 
                    (setq nondots t)
                    (loop
                      (multiple-value-bind (nextchar nextattr) (%next-char-and-attr-no-eof stream fn arg attrtab)
                        (declare (fixnum nextattr))
                        (if (= nextattr $cht_mesc) 
                          (return (setq multi-escaped t))
                          (if (= nextattr $cht_sesc)
                            (setq escapes (add-note-escape-pos (%read-char-no-eof stream fn arg) token escapes))
                            (setq escapes (add-note-escape-pos nextchar token escapes)))))))
                  (let* ((opos (token.opos token)))         ; Add char to token, note 1st colonpos
                    (declare (fixnum opos))
                    (if (and (eq char #\:)       ; (package-delimiter-p char ?)
                             (not explicit-package))
                      (let* ((nextch (%read-char-no-eof stream fn arg)))
                        (if (eq nextch #\:)
                          (setq double-colon t)
                          (progn
                            (stream-untyi stream nextch)
                            (setq double-colon nil)))
                        (%casify-token token escapes)
                        (setq explicit-package (%token-package token opos nondots)
                              nondots t
                              escapes nil)
                        (setf (token.opos token) 0))
                      (progn
                        (unless (eq char #\.) (setq nondots t))
                        (%add-char-to-token char token))))))))))
        (values (or escapes multi-escaped) (if *read-suppress* nil explicit-package) nondots double-colon))))
          
(defun %validate-radix (radix)
  (if (and (typep radix 'fixnum)
           (>= (the fixnum radix) 2)
           (<= (the fixnum radix) 36))
    radix
    (progn
      (check-type radix (integer 2 36))
      radix)))

(defun %token-to-number (token radix &optional no-rat)
  (new-numtoken (token.string token) (token.ipos token) (token.opos token) radix no-rat))

;; these probably belong elsewhere

(define-condition simple-reader-error (reader-error simple-error) ()
  (:report (lambda (c output-stream)
             (format output-stream "Reader error on stream ~S:~%~?"
                     (stream-error-stream c)
                     (simple-condition-format-string c)
                     (simple-condition-format-arguments c)))))

(define-condition float-overflow-in-read (simple-reader-error) ()  ;; Lisp reader errors 
  (:report (lambda (c output-stream)
             (format output-stream "Reading stream ~S:~%~a ~S"
                     (stream-error-stream c)
                     "float overflow reading"
                     (simple-condition-format-arguments c)))))

(define-condition float-underflow-in-read (simple-reader-error) ()  ;; Lisp reader errors 
  (:report (lambda (c output-stream)
             (format output-stream "Reading stream ~S:~%~a ~S"
                     (stream-error-stream c)
                     "float underflow reading"
                     (simple-condition-format-arguments c)))))

(defun signal-reader-error (input-stream format-string &rest format-args)
  (error 'simple-reader-error :stream input-stream
         :format-control format-string :format-arguments format-args))


; If we're allowed to have a single "." in this context, DOT-OK is some distinguished
; value that's returned to the caller when exactly one dot is present.


(defun %parse-token (stream firstchar dot-ok)
  (with-token-buffer (tb)
    (multiple-value-bind (escapes explicit-package nondots double-colon) (%collect-xtoken tb stream firstchar)
      (unless *read-suppress* 
        (let* ((string (token.string tb))
               (len (token.opos tb)))
          (declare (fixnum len ndots nondots))
          (if (not nondots)
            (if (= len 1)
              (or dot-ok (signal-reader-error stream "Dot context error."))
              (signal-reader-error stream "Illegal symbol syntax."))
            ; Something other than a buffer full of dots.  Thank god.
            (let* ((num (if (null escapes) 
                          (handler-case
                            (%token-to-number tb (%validate-radix *read-base*))
                            (floating-point-underflow (c)
                                (declare (ignore c))                                
                                (error 'float-underflow-in-read :stream stream
                                       :format-arguments (%string-from-token tb)))
                            (floating-point-overflow (c)
                              (declare (ignore c))
                              (error 'float-overflow-in-read :stream stream 
                                     :format-arguments (%string-from-token tb)))))))                            
              (if num
                (if explicit-package
                  (%err-disp $XBADSYM stream)          ; a "potential number" with package qualifier is bad
                  num)
                (if (and (zerop len) (null escapes))
                  (%err-disp $XBADSYM stream)
                  (progn                  ; Muck with readtable case of extended token.
                    (%casify-token tb (unless (atom escapes) escapes))
                    (let* ((pkg (or explicit-package *package*)))
                      (if (or double-colon (eq pkg *keyword-package*))
                        (without-interrupts
                         (multiple-value-bind (symbol access internal-offset external-offset)
                                              (%find-symbol string len pkg)
                           (if access
                             symbol
                             (%add-symbol (%string-from-token tb) pkg internal-offset external-offset))))
                        (multiple-value-bind (found symbol) (%get-htab-symbol string len (pkg.etab pkg))
                          (if found
                            symbol
                            (%err-disp $XNOESYM stream (%string-from-token tb) pkg)))))))))))))))
                    
#|
(defun %parse-token-test (string &key dot-ok (case (readtable-case *readtable*)))
  (let* ((stream (make-string-input-stream string))
         (oldcase (readtable-case *readtable*)))
    (unwind-protect
      (progn
        (setf (readtable-case *readtable*) case) 
        (%parse-token stream (read-char stream t) dot-ok))
      (setf (readtable-case *readtable*) oldcase))))

(%parse-token-test "ABC")
(%parse-token-test "TRAPS::_DEBUGGER")
(%parse-token-test "3.14159")
(ignore-errors (%parse-token-test "BAD-PACKAGE:WORSE-SYMBOL"))
(ignore-errors (%parse-token-test "CCL::"))
(%parse-token-test "TRAPS::_debugger" :case :preserve)
(%parse-token-test ":foo")
(read-from-string "#:|6|")
|#

; firstchar must not be whitespace.
; People who think that there's so much overhead in all of
; this (multiple-value-list, etc.) should probably consider
; rewriting those parts of the CLOS and I/O code that make
; using things like READ-CHAR impractical ...
(defun %parse-expression (stream firstchar dot-ok)
  (let* ((readtable *readtable*)
         (attrtab (rdtab.ttab readtable)))
    (let* ((attr (%character-attribute firstchar attrtab)))
      (declare (fixnum attr))
      (if (= attr $cht_ill) (signal-reader-error stream "Illegal character ~S." firstchar))
      (let* ((vals (multiple-value-list 
                    (if (not (logbitp $cht_macbit attr))
                      (%parse-token stream firstchar dot-ok)
                      (let* ((def (cdr (assq firstchar (rdtab.alist readtable)))))
                        (cond ((null def))
                              ((atom def)
                               (funcall def stream firstchar))
                              #+no ; include if %initial-readtable% broken (see above)
                              ((and (consp (car def))
                                    (eq (caar def) 'function))
                               (funcall (cadar def) stream firstchar))
                              ((functionp (car def))
                               (funcall (car def) stream firstchar))
                              (t (break "Bogus default dispatch fn: ~S" (car def)) nil)))))))
        (declare (dynamic-extent vals)
                 (list vals))
        (if (null vals)
            (values nil nil)
            (values (car vals) t))))))


#|
(defun %parse-expression-test (string)
  (let* ((stream (make-string-input-stream string)))
    (%parse-expression stream (read-char stream t) nil)))

(%parse-expression-test ";hello")
(%parse-expression-test "#'cdr")
(%parse-expression-test "#+foo 1 2")

|#

(defun %read-list-expression (stream dot-ok &optional (termch #\)))
  (multiple-value-bind (fn arg) (stream-reader stream)
    (loop
      (let* ((firstch (%next-non-whitespace-char-and-attr-no-eof stream fn arg)))
        (if (eq firstch termch)
          (return (values nil nil))
          (multiple-value-bind (val val-p) (%parse-expression stream firstch dot-ok)
            (if val-p
              (return (values val t)))))))))


(defun read-list (stream &optional nodots (termch #\)))
  (let* ((dot-ok (cons nil nil))
         (head (cons nil nil))
         (tail head))
    (declare (dynamic-extent dot-ok head)
             (list head tail))
    (if nodots (setq dot-ok nil))
    (loop
      (multiple-value-bind (form form-p) (%read-list-expression stream dot-ok termch)
        (if (not form-p) (return))
        (if (and dot-ok (eq form dot-ok))            ; just read a dot
          (if (and tail
                   (multiple-value-bind (lastform lastform-p) (%read-list-expression stream nil termch)
                     (and lastform-p
                          (progn (rplacd tail lastform) 
                                 (not (nth-value 1 (%read-list-expression stream nil termch)))))))
            (return)
            (signal-reader-error stream "Dot context error."))
           (rplacd tail (setq tail (cons form nil))))))
    (cdr head)))

#|
(defun read-list-test (string &optional nodots)
  (read-list (make-string-input-stream string) nodots))

(read-list-test ")")
(read-list-test "a b c)" t)
(read-list-test "a b ;hello
c)" t)

|#

(set-macro-character
 #\(
 #'(lambda (stream ignore)
     (declare (ignore ignore))
     (read-list stream nil #\))))

(set-macro-character 
 #\' 
 (nfunction |'-reader| 
            (lambda (stream ignore)
              (declare (ignore ignore))
              `(quote ,(read stream t nil t)))))

(defparameter *linefeed-equals-newline* nil)
(set-macro-character
 #\;
 (nfunction |;-reader|
            (lambda (stream ignore)
              (declare (ignore ignore))
              (multiple-value-bind (fn arg) (stream-reader stream)
                (let* ((ch nil))
                  (loop 
                    (if (or (null (setq ch (funcall fn arg)))
                            (char-eolp ch ))
                      (return (values)))))))))

(defun read-string (stream termch)
  (multiple-value-bind (fn arg) (stream-reader stream)
    (with-token-buffer (tb)
      (do* ((attrs (rdtab.ttab *readtable*))
            (ch (%read-char-no-eof stream fn arg)
                (%read-char-no-eof stream fn arg)))
           ((eq ch termch)
            (%string-from-token tb))
        (if (= (the fixnum (%character-attribute ch attrs)) $CHT_SESC)
          (setq ch (%read-char-no-eof stream fn arg)))
        (%add-char-to-token ch tb)))))

(set-macro-character #\" #'read-string)

(defparameter *ignore-extra-close-parenthesis* t)

(set-macro-character 
 #\)
 #'(lambda (stream ch)
     (let* ((pos (if (typep stream 'file-stream)
                     (file-position stream))))
       (if *ignore-extra-close-parenthesis*
           (warn "Ignoring extra \"~c\" ~@[near position ~d~] on ~s ." ch pos stream)
           (signal-reader-error stream "Unmatched ')' ~@[near position ~d~]." pos)))))




(eval-when (:load-toplevel)             ; But not when mousing around!
  (make-dispatch-macro-character #\# t))


  
(set-dispatch-macro-character
 #\#
 #\(
 (nfunction 
  |#(-reader| 
  (lambda (stream subchar numarg)
    (declare (ignore subchar))
    (if (null numarg)
      (let* ((lst (read-list stream t))
             (len (length lst))
             (vec (make-array len)))
        (declare (list lst) (fixnum len) (simple-vector vec))
        (dotimes (i len vec)
          (setf (svref vec i) (pop lst))))
      (locally
        (declare (fixnum numarg))
        (do* ((vec (make-array numarg))
              (lastform)
              (i 0 (1+ i)))
             ((multiple-value-bind (form form-p) (%read-list-expression stream nil)
                (if form-p
                  (setq lastform form)
                  (unless (= i numarg)
                      (if (= i 0) 
                        (%err-disp $XARROOB  -1 vec)
                        (do* ((j i (1+ j)))
                             ((= j numarg))
                          (declare (fixnum j))
                          (setf (svref vec j) lastform)))))
                (not form-p))
              vec)
          (declare (fixnum i))
          (setf (svref vec i) lastform)))))))

(defun %read-rational (stream subchar radix)
  (declare (ignore subchar))
  (with-token-buffer (tb)
    (multiple-value-bind (fn arg) (stream-reader stream)
      (multiple-value-bind (escapes xpackage)
                           (%collect-xtoken tb stream (%next-non-whitespace-char-and-attr-no-eof stream fn arg))
        (unless *read-suppress*
          (let* ((val (%token-to-number tb radix)))
          (or (and (null escapes)
                   (null xpackage)
                   (typep val 'rational)
                   val)
              (%err-disp $xbadnum stream))))))))

(defun require-numarg (subchar numarg)
  (or numarg *read-suppress*
      (error "Numeric argument required for #~A reader macro ." subchar)))

(defun require-no-numarg (subchar numarg)
  (if (and numarg (not *read-suppress*))
      (error "Spurious numeric argument in #~D~A reader macro ." numarg subchar)))

#|
(defun read-eval (stream subchar numarg)
  (require-no-numarg subchar numarg)
  (if *read-eval*
    (let* ((exp (%read-list-expression stream nil)))
      (unless *read-suppress*
        (eval exp)))
    (error '"#. reader macro invoked when ~S is false ." '*read-eval*)))
|#

(defun read-eval (stream subchar numarg)
  (require-no-numarg subchar numarg)
  (if *read-eval*
    (let* ((exp (%read-list-expression stream nil)))
      (unless *read-suppress*
        (eval exp)))
    (signal-reader-error stream "#. reader macro invoked when ~S is false ."
                         '*read-eval*)))

(set-dispatch-macro-character 
 #\# 
 #\C
 #'(lambda (stream char arg &aux form)
     (require-no-numarg char arg )
     (setq form (read stream t nil t))
     (unless *read-suppress* (apply #'complex form))))

(set-dispatch-macro-character 
 #\#
 #\.
 #'read-eval)

; This has been deprecated.  Why not nuke it ?
(set-dispatch-macro-character
 #\#
 #\,
 #'(lambda (stream subchar numarg)
     (let* ((sharp-comma-token *reading-for-cfasl*))
       (if (or *read-suppress* (not *compiling-file*) (not sharp-comma-token))
         (read-eval stream subchar numarg)
         (progn
           (require-no-numarg subchar numarg)
           (list sharp-comma-token (read stream t nil t)))))))

(set-dispatch-macro-character
 #\#
 #\:
 #'(lambda (stream subchar numarg)
     (require-no-numarg subchar numarg)
     (if (not *read-suppress*)
       (multiple-value-bind (fn arg) (safe-stream-reader stream)
         (multiple-value-bind (firstch attr) (%next-non-whitespace-char-and-attr-no-eof stream fn arg)
           (declare (fixnum attr))
           (with-token-buffer (tb)
             (if (or (= attr $CHT_ILL)
                     (logbitp $cht_macbit attr)
                     (multiple-value-bind (escapes explicit-package nondots) (%collect-xtoken tb stream firstch)
                       (declare (ignore nondots))
                       (%casify-token tb (unless (atom escapes) escapes))
                       (or explicit-package
                           (and (not escapes)
                                (%token-to-number tb (%validate-radix *read-base*))))))
               (%err-disp $XBADSYM stream)
               (make-symbol (%string-from-token tb))))))
         (progn
           (%read-list-expression stream nil)
           nil))))

(set-dispatch-macro-character 
 #\# 
 #\b
 #'(lambda (stream subchar numarg)
     (require-no-numarg subchar numarg)
     (%read-rational stream subchar 2)))

(set-dispatch-macro-character 
 #\# 
 #\o
 #'(lambda (stream subchar numarg)
     (require-no-numarg subchar numarg)
     (%read-rational stream subchar 8)))

(set-dispatch-macro-character 
 #\# 
 #\x
 #'(lambda (stream subchar numarg)
     (require-no-numarg subchar numarg)
     (%read-rational stream subchar 16)))

(set-dispatch-macro-character 
 #\# 
 #\r
 #'(lambda (stream subchar numarg)
     (require-numarg subchar numarg)
     (check-type numarg (integer 2 36))
     (%read-rational stream subchar numarg)))

(set-dispatch-macro-character
 #\#
 #\'
 (nfunction |#'-reader| 
            (lambda (stream subchar numarg)
              (require-no-numarg subchar numarg)
              `(function ,(read stream t nil t)))))

(set-dispatch-macro-character
 #\#
 #\|
 (nfunction |#\|-reader| 
            (lambda (stream subchar numarg)
              (require-no-numarg subchar numarg)
              (multiple-value-bind (fn arg) (stream-reader stream)
                (do* ((lastch nil ch)
                      (ch )
                      (level 1))
                     ((= level 0) (values))
                  (declare (fixnum level))
                  (setq ch (%read-char-no-eof stream fn arg))
                  (if (and (eq ch #\|)
                           (eq lastch #\#))
                    (progn 
                      (setq ch nil)
                      (incf level))
                    (if (and (eq ch #\#)
                             (eq lastch #\|))
                      (progn 
                      (setq ch nil)
                      (decf level)))))))))



(defun %unreadable (stream description)
  (signal-reader-error stream "~S encountered." stream description))

(set-dispatch-macro-character
 #\#
 #\<
 #'(lambda (stream &rest ignore) (declare (ignore ignore)) (%unreadable  stream "#<")))

(dolist (ch `(#\null #\tab #\linefeed #\page #\return #\space ,(code-char #xa0)))
  (set-dispatch-macro-character
   #\#
   ch
   #'(lambda (stream &rest ignore) (declare (ignore ignore)) (%unreadable stream "#<whitespace>"))))

(set-dispatch-macro-character
 #\#
 #\)
 #'(lambda (stream &rest ignore) (declare (ignore ignore)) (%unreadable stream "#)")))

(set-dispatch-macro-character
 #\#
 #\\
 #'(lambda (stream subchar numarg)
     (require-no-numarg subchar numarg)
     (with-token-buffer (tb)
       (%collect-xtoken tb stream #\\)
       (unless *read-suppress*
         (let* ((str (%string-from-token tb)))
           (or (name-char str)
               (error "Unknown character name - \"~a\" ." str)))))))


     
;Since some built-in read macros used to use internal reader entry points
;for efficiency, we couldn't reliably offer a protocol for stream-dependent
;recursive reading.  So recursive reads always get done via tyi's, and streams
;only get to intercept toplevel reads.

(defun read (&optional stream (eof-error-p t) eof-value recursive-p)
  (declare (resident))
  (setq stream (input-stream-arg stream))
  (if recursive-p
    (%read-form stream 0 nil)
    (let* ((temp #'(lambda (stream)
                     (let ((%read-objects% nil) (%keep-whitespace% nil))
                       (stream-read stream eof-error-p eof-value)))))
      (declare (dynamic-extent temp))
      (stream-rubout-handler stream temp))))

(defun read-preserving-whitespace (&optional stream (eof-error-p t) eof-value recursive-p)
  (setq stream (input-stream-arg stream))
  (if recursive-p
    (%read-form stream 0 nil)
    (let ((%read-objects% nil) (%keep-whitespace% t))
      (stream-read stream eof-error-p eof-value))))

(defmethod stream-read ((stream stream) eof-error-p eof-val)
  (%read-form stream (if eof-error-p 0) eof-val))

(defun read-delimited-list (char &optional stream recursive-p)
  (setq char (require-type char 'character))
  (setq stream (input-stream-arg stream))
  (let ((%keep-whitespace% nil))
    (if recursive-p
      (%read-form stream char nil)
      (let ((%read-objects% nil))
        (%read-form stream char nil)))))

(defun read-conditional (stream subchar int)
  (declare (ignore int))
  (cond (*read-suppress* (read stream t nil t) (values))
        ((eq subchar (read-feature stream)) (read stream t nil t))
        (t (let* ((*read-suppress* t))
             (read stream t nil t)
             (values)))))

(defun read-feature (stream)
  (let* ((f (let* ((*package* *keyword-package*))
              (read stream t nil t))))
    (labels ((eval-feature (form)
               (cond ((atom form) 
                      (member form *features*))
                     ((eq (car form) :not) 
                      (not (eval-feature (cadr form))))
                     ((eq (car form) :and) 
                      (dolist (subform (cdr form) t)
                        (unless (eval-feature subform) (return))))
                     ((eq (car form) :or) 
                      (dolist (subform (cdr form) nil)
                        (when (eval-feature subform) (return t))))
                     (t (%err-disp $XRDFEATURE stream form)))))
      (if (eval-feature f) #\+ #\-))))

(set-dispatch-macro-character #\# #\+ #'read-conditional)
(set-dispatch-macro-character #\# #\- #'read-conditional)


(defresource *parse-string-resource*
  :constructor (make-string 255 :element-type 'base-character))

;arg=0 : read form, error if eof
;arg=nil : read form, eof-val if eof.
;arg=char : read delimited list
(defun %read-form (stream arg eof-val)
  (declare (resident))
  (check-type *readtable* readtable)
  (check-type *package* package)
  (multiple-value-bind (reader-fn reader-arg) (safe-stream-reader stream)
    (if (and arg (not (eq arg 0)))
      (read-list stream nil arg)
      (loop
        (let* ((ch (%next-non-whitespace-char-and-attr stream reader-fn reader-arg)))
          (if (null ch)
            (if arg 
              (error 'end-of-file :stream stream)
              (return eof-val))
            (multiple-value-bind (form form-p) (%parse-expression stream ch nil)
              (if form-p
                 (return form)))))))))



(defun thin-to-fat-string (string)
  (let* ((len (length string))
         (new (make-string len :element-type 'extended-character)))
    (move-string-bytes string new 0 0 len)
    new))

(defun %read-extend-str (str xstr &optional len)
  (when (not len)(setq len (length str)))
  (let* ((type (array-element-type str)))
    (if  (not xstr)
      (progn (setq xstr (make-string len :element-type type))
             (move-string-bytes str xstr 0 0 len)
             xstr)
      (%str-cat xstr (if (eq len (length str)) str (%substr str 0 len))))))



;Until load backquote...
(set-macro-character #\`
  #'(lambda (stream char) (declare (ignore stream)) (%err-disp $xbadmac char)))
(set-macro-character #\, (get-macro-character #\`))



;for reading #@(h v) as points
(set-dispatch-macro-character #\# #\@ 
   (qlfun |#@-reader| (stream char arg)
      (require-no-numarg char arg)
      (let ((list (read stream t nil t)))
        (unless *read-suppress*
          (let ((point (apply #'make-big-point list)))
            (if (consp point)
              `(make-big-point ,(%car point) ,(%cdr point))
              point))))))

; for reading #F(blah blah ...) as nan or infinity
; list is :infinity/:nan :short/:double ieee-mantissa sign (-1 or 1) 
; the 68k version won't output #f and reading back something in #f format  won't work there
; for shorts because there are no 68K short nans but this file is currently ppc specific.
(set-dispatch-macro-character #\# #\f
                              (qlfun |#F-reader| (stream char arg)
      (require-no-numarg char arg)
      (let ((list (read stream t nil t)))
        (unless *read-suppress*
          (let ((what (car list))
                (type (cadr list)))
            (if (not (memq what '(:nan :infinity)))
              (error "#f expects :nan or :infinity"))
            (ecase type 
              (:double (let ((mant (third list)))
                         (make-float-from-fixnums (ash mant -28)
                                                  (logand mant #xfffffff)
                                                  (1+ IEEE-double-float-normal-exponent-max)
                                                  (fourth list))))
              (:short (make-short-float-from-fixnums 
                       (third list)
                       (1+ IEEE-single-float-normal-exponent-max)
                       (fourth list)))))))))
            

(set-dispatch-macro-character #\# #\P
 (qlfun |#P-reader| (stream char flags &aux path (invalid-string "Invalid flags (~S) for pathname ~S"))
   (declare (ignore char))
   (when (null flags) (setq flags 0))
   (unless (memq flags '(0 1 2 3 4))
     (unless *read-suppress* (report-bad-arg flags '(integer 0 4))))
   (setq path (read stream t nil t))
   (unless *read-suppress*
     (unless (or (stringp path)(typep path 'encoded-string)) (report-bad-arg path 'string))
     (setq path (pathname path))
     (when (%ilogbitp 0 flags)
       (when (%pathname-type path) (error invalid-string flags path))
       (setf (%pathname-type path) :unspecific))
     (when (%ilogbitp 1 flags)
       (when (%pathname-name path) (error invalid-string flags path))
       (setf (%pathname-name path) ""))
     path)))

(set-dispatch-macro-character #\# #\_
  (qlfun |#_-reader| (stream char arg)
    (declare (special *traps-package*))
    (when arg (unless *read-suppress* (%err-disp stream char)))
    (unless *read-suppress*
      (require :defrecord)
      (require :deftrap))
    (stream-untyi stream #\_)
    (let* ((sym (let ((*package* *traps-package*)) (read stream t nil t))))
      (unless *read-suppress*
        (unless (and sym (symbolp sym)) (report-bad-arg sym 'symbol))
        (load-trap sym stream)))))

(set-dispatch-macro-character 
 #\# #\$
 (qlfun |#$-reader| (stream char arg)
   (declare (special *traps-package*))
   (declare (ignore char))
   (unless *read-suppress*
     (require :defrecord)
     (require :deftrap))
   (stream-untyi stream #\$)
   (let* ((sym (let ((*package* *traps-package*)) (read stream t nil t))))
     (unless *read-suppress*
       (unless arg (setq arg 0))
       (ecase arg
         (0
          (unless (boundp sym)
            (load-trap-constant sym stream)))
         (1 (makunbound sym) (load-trap-constant sym stream)))
       sym))))
#|
(set-dispatch-macro-character #\# #\"
 #'(lambda (stream char arg)
     (declare (ignore arg))
     (unless *read-suppress*
       (let ((pos0 (stream-position stream)))
       (stream-untyi stream char)
       (let* ((string (read stream t nil t))
              (scriptruns (stream-script-runs stream pos0 (1- (stream-position stream)))))
         (if scriptruns
           (make-instance 'scripted-string string scriptruns)
           string))))))

; if we do this need a print-object - define stream-script-runs for input-script-file-stream
; buffer-stream and what else? can a scripted string be used for an output-string-stream
; Need to be able to pass these things to buffer-insert
; stream-write-string????? - doesn't fit very well - would be fine if unicode files existed
; Seems like styled-string would be the natural next request #S"asdf" ?
; from buffers - buffer-substring generalizes to buffer-scripted-substring and buffer-styled-substring
; from fred-dialog-items ditto - just a delegation - use for searches?
; Use styled string where we now use a cons of string and style.

(defmethod stream-script-runs (stream bpos epos)
  (declare (ignore stream bpos epos)))
|#

#+ignore
(set-dispatch-macro-character
 #\# #\U
 (qlfun |#U-reader| (stream char arg)
   (require-no-numarg char arg)
   (let ((list (read stream t nil t)))
     (unless *read-suppress*
       (let* ((len (length list))
              (str (make-string len :element-type 'extended-character))
              (i 0))
         (dolist (x list)
           (setf (%scharcode  str i) (if (characterp x) (char-code x) x))
           (incf i))
         (make-encoded-string str))))))
;; silly
(set-dispatch-macro-character
 #\# #\U
 (qlfun |#U-reader| (stream char arg)
   (require-no-numarg char arg)
   (let ((list (read stream t nil t)))
     (unless *read-suppress*
       (let* (;(len (length list))
              (outlen 0))
         (dolist (x list)
           (cond ((stringp x)(incf outlen (length x)))
                 ((characterp x) (incf outlen 1))
                 (t (incf outlen 1))))
         (let ((str (make-string outlen :element-type 'extended-character))
               (i 0))
           (dolist (x list)
             (cond ((stringp x)
                    (dotimes (j (length x))
                      (setf (%scharcode str i) (%scharcode x j))
                      (setq i (1+ i))))
                   ((characterp x)(setf (%scharcode str i)(char-code x))
                    (incf i))
                   (t (setf (%scharcode str i) x)
                      (incf i))))
           (make-encoded-string str)))))))


