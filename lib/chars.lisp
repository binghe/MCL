; -*- Mode: Lisp; Package: CCL -*-
;; chars.lisp

;;	Change History (most recent first):
;;  2 10/5/97  akh  see below
;;  10 1/22/97 akh  optimizations for string and char comparisons
;;                  char< and friends back to just code compare
;;  8 6/7/96   akh  use scharcode in string-cmp
;;  7 3/27/96  akh  fix itlb resource things
;;  6 2/19/96  akh  fix char/=
;;  4 12/22/95 gb   Bill's fixes to %strup/%strdown
;;  3 10/17/95 akh  merge patches
;;  2 10/12/95 akh  no mo lap
;;  3 5/10/95  akh  tiny change in string-compare
;;  2 4/28/95  akh  fix string-compare for extended strings
;;  3 3/2/95   akh  say element-type 'base-character
;;  2 2/9/95   slh  new char-not-equal
;;  5 2/3/95   akh  merge leibniz patches
;;  4 2/2/95   akh  merge with leibniz patches for defstruct
;;  (do not edit before this line!!)

; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2006 Digitool, Inc.

(in-package :ccl)

;; Modification History
;; add *string-compare-non-literal* - if true allows e.g. (o-umlaut == o, umlaut)
;; char-code-compare-hairy - lose compare-localized
;; %strup-down faster 
;; ------- 5.2b6
;; #\newline => #\return
;; fix %strcap for ascii-p and test suites
;; unicode-string-compare - change when for-equal, fix %ascii-string-up for mu
;; fix crock in string-upcase and downcase when arg is symbol, #\space is graphic-char-p !
;; string-upcase and downcase - try harder not to copy string twice
;; %ascii-string-up don't for #xdf - #\§ = ess zed
;; unicode-string-compare takes advantage of result of latin1-string-compare
;; graphic-char-p more liberal
;; clean up string comparisons
;; build and use unicode-char-sort-table, unicode-char-equal-sort-table. Fix char-not-equal
;; callers of #_CFStringCompare do #$kCFCompareLocalized
;; unicode-string-compare fix use of starts, fiddle with destructive-p in %strup-down and callers to avoid copying twice
;; fix %strup-down for new length neq original length
;; change graphic-char-p again, char-lessp and friends - actually alpha sort order probably depends on language
;;    IIRC some dictionaries put Š long after a and some don't - #$kCFCompareLocalized?
;; remove some erroneous calls to convert-string
;; fix graphic-char-p
;; char-compare does unicode
;; string comparisons do unicode
;; alphanumericp does unicode vs scripts
;; ----- 5.1 final
;; string-not-equal, not-greaterp, not-lessp do encoded strings and start, end args
;; unicode-string-compare fns move here from pathnames.lisp. comparenonliteral seems busted on OS 9
;; string-equal, lessp, greaterp work with encoded strings and start or end args
;; --------- 5.1b2
;; string= and friends encoded-string aware
;; string-greaterp and string-lessp are encoded-string aware (the string-not... arent)
;; -------- 5.1b1
;; string-equal knows about encoded strings sort of
;; -------- 5.0 final
;; iumagpstring => comparetext
;; uppertext => uppercasetext etc
;08/14/99 akh fix alphanumericp for roman script, char-code > #xff
;--------- 4.3f1c1
;04/06/99 akh fix upper-case-p for chars > 128, fix alphanumericp
;------------------
;03/03/97 akh from slh in %strcap recognize quotes as part of a word (eg, "Joe's" not "Joe'S")
;09/02/97 akh char-name of code < space returns the ^ str
;01/30/96 bill  wtf is char-int? Common Lisp, that's wtf.
; 3/05/95 slh   char-not-equal fix
;02/09/95 slh   new char-not-equal
;------------- 3.0d17
;07/12/93 alice we forgot char-not-lessp/greaterp/equal
;07/09/03 alice string-upcase/downcase and char-equal/greaterp/lessp char>/</<=/>= use 	*string-compare-script*
;		(1500+ bytes bite the dust). 
;07/07/93 alice alpha-char-p and alphanumericp ok but slow if non roman
;07/01/93 alice string comparisons all use *string-compare-script*, as do lower-case-p and upper-case-p
;05/26/93 alice changed %strup, %strdown and %strcap - but they only make sense if roman
;05/17/03 alice added base-character-p and extended-character-p then moved them to l1-aprims
;05/16/93 alice char-name and character deal with extended characters, some cmp.b to cmp.w - not done yet
;		what about alpha-char-p etal for extended chars. alpha sorting is really another issue entirely
;05/04/93 alice copy-string-arg knows about extended-character
; ??      alice char> fix parens
;01/03/93 alice char< do unsigned compare please
;10/14/92 alice get rid of some lap
;11/20/92 gb   fix flaw in CHARACTER.
;------------- 2.0
;01/06/91 alice fix nstring-capitalize, string-capitalize
;01/02/91 gb  Graphic-char-p looks more aesthetic without #_Debugger.
;12/06/91 alphanumericp, upper-case-p and lower-case-p ‡ˆ‰ŠŒŽ‘’“”•–—˜™š›œžŸ €‚ƒ„…† and ËÌÍ
;	  also %%strup %%strdown, and string-capitalize. graphic-char-p from 128 to 255 (itsa Macintosh)
;------------- 2.0b4
;07/21/91 gb %badarg fixes, digit-char returns NIL for bad radices, &lap arglists.
;02/18/91 gb code-char, char-code eval-redef'ed elsewhere.
;05/13/91 bill string-lessp -> l1-aprims for bootstrapping l1-windows.
;09/03/90 gb  call %%deref-sym-char-or-string where appropriate.
;06/28/90 bill cs -> le in char<
;06/25/90 gb   alpha-char-p, lower-case-p to l1-aprims.
;06/23/90  gb  forget about $symbol-header.
; ----- 2.0a1
;06/07/90 bill %noforcestk doesn't work with &optional args in digit-char.
;06/02/90 gb  code-char error message.
;05/22/90 gb  no more symtagp.
;04/17/90 gb   char-lessp : LS vice CS (CS considered harmful); exorcise ghosts.
;04/14/90  gz  [n]string-studlify.
;01/14/89 Bill char-not-greaterp tested with HI instead of CS
;12-Nov-89 Mly graphic-char-p, not graphics-char-p
;04/07/89 gb  $sp8 -> $sp.
;3/16/89  gz mkchar no longer does a getint.
;03/13/89 gb digit-char-p: cmp -> sub.
;02/15/89 gb alpanumericp -> alphanumericp; char>= was missing.
;            So much for string-diag.lisp.
;11/19/88 gb passes string-diag.lisp .
;10/25/88 gb new file.


(defparameter *string-compare-non-literal* nil)
        

; If object is a character, it is returned.  If it is an integer, its INT-CHAR
; is returned. If it is a string of length 1, then the sole element of the
; string is returned.  If it is a symbol whose pname is of length 1, then
; the sole element of the pname is returned. Else error.

(defun character (arg)
  (if (typep arg 'character)
    arg
    (if (typep arg 'fixnum)
      (code-char arg)
      (if (and (typep arg 'string)
               (= (the fixnum (length arg)) 1))
        (char arg 0)
        (let* ((pname (if (typep arg 'symbol) (symbol-name arg))))
          (if (and pname (= (the fixnum (length pname)) 1))
            (char pname 0)
            (%err-disp $xcoerce arg 'character)))))))

(defun digit-char (weight &optional radix)
  (let* ((r (if radix (require-type radix 'integer) 10)))
    (if (and (typep (require-type weight 'integer) 'fixnum)
             (>= r 2)
             (<= r 36)
             (>= weight 0)
             (< weight r))
      (locally (declare (fixnum weight))
        (if (< weight 10)
          (code-char (the fixnum (+ weight (char-code #\0))))
          (code-char (the fixnum (+ weight (- (char-code #\A) 10)))))))))


;True for ascii codes 32-126 inclusive.
; and for guys >= 128. Its really a function of the font of the moment. - not so today
(defun graphic-char-p (c)
  (let* ((code (char-code c)))
    (declare (fixnum code))
    (unless (eq c #\rubout)
      (and (>= code (char-code #\space))
           (or (< code 128) 
               (and (<= code #xff)(>= code #xA1))
               (xwhitespace-p c)
               (not (or (xwhitespace-or-eol-p c)
                        (xcontrol-char-p c)
                        (xillegal-char-p c)))
               ;(xalphanumeric-p c)
               ;(xpunctuation-p c)               
               ;(eq code #x2202)  ;; one of our least favorites - ¶
               )))))


;True for ascii codes 13 and 32-126 inclusive.
(defun standard-char-p (c)
  (let* ((code (char-code c)))
    (or ;(eq c #\return)
        ;(eq c #\linefeed)
        (= code 13)   ;; aka #\return
        (and 
         (>= code (char-code #\space))
         (< code (char-code #\rubout))))))

(defun upper-case-p (c)
  (let* ((code (char-code c)))
    (declare (optimize (speed 3)(safety 0)))
    (if  (%i< code 128)
      (and (%i>= code #.(char-code #\A)) (%i<= code #.(char-code #\Z)))
      (xupper-case-p c))))


(defun lower-case-p (c)
  (let* ((code (char-code c)))
    (declare (optimize (speed 3)(safety 0)))
    (if (%i< code 128)
      (and (%i>= code #.(char-code #\a)) (%i<= code #.(char-code #\z)))
      (xlower-case-p c))))

; I assume nobody cares that this be blindingly fast
(defun both-case-p (c)
  (and (alpha-char-p c)
       (if (xupper-case-p c)
         (neq c (char-downcase c))
         (if (xlower-case-p c)
           (neq c (char-upcase c))))))

#+ignore ;; another way
(defun both-case-p (c)
  (and (alpha-char-p c)
       (if (xupper-case-p c)
         (multiple-value-bind (down str)(char-downcase c)
           (or (neq c down) str))
         (if (xlower-case-p c)
           (multiple-value-bind (up str)(char-upcase c)
             (or (neq c up) str))))))


(defun char= (ch &rest others)
  (declare (dynamic-extent others))
  (unless (typep ch 'character)
    (setq ch (require-type ch 'character)))
  (dolist (other others t)
    (unless (eq other ch)
      (unless (typep other 'character)
        (setq other (require-type other 'character)))
      (return))))

(defun char/= (ch &rest others)
  (declare (dynamic-extent others))
  (unless (typep ch 'character)
    (setq ch (require-type ch 'character)))
  (do* ((rest others (cdr rest)))
       ((null rest) t)
    (let ((other (car rest)))
      (if (eq other ch) (return))
      (unless (typep other 'character)
        (setq other (require-type other 'character)))
      (dolist (o2 (cdr rest))
        (if (eq o2 other)(return-from char/= nil))))))


(defun char-equal (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))
    (let* () 
      (dolist (c others t)
        (when (not (eql c char))
          (when (neq 0 (char-compare char c))
            (return)))))))

; is this right - was not
; Compares each char against all following chars, not just next one. Tries
; to be fast for one or two args.
(defun char-not-equal (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3) (safety 0)))
    (let* (;(script #$smroman)
           ;(table  (get-char-equal-sort-table script))
           (rest   (cdr others)))
      (cond ((and  rest (%i< (char-code char) #x100)
                  (dolist (x others t)
                    (when (%i> (char-code x) #xff) (return nil))))
             (let ((downtable char-downcase-vector))
               (while others
                 (when (member char others :test #'(lambda (c1 c2)
                                                     (eq (uvref downtable (%char-code c1))
                                                         (uvref downtable (%char-code c2)))))
                   (return-from char-not-equal nil))
                 (setq char   (car others)
                       others rest
                       rest   (cdr others)))
               t))
            (rest                       ; more than 2 args, not all latin1
             ;; test (char-not-equal #\a #\Ø #\b #\Ù) 
             (while others               
               (when (member char others
                             :test #'(lambda (c1 c2)
                                       (eq 0 (char-compare c1 c2))))
                 (return-from char-not-equal nil))
               (setq char   (car others)
                     others rest
                     rest   (cdr others)))
             t)
            (others                     ;  2 args
             (not (eq 0 (char-compare char (car others)))))
            (t t)))))

#| Old version. CLtL2 p. 378 says char comparisons are analogous to numeric comparisons;
   p. 293 says /= is true for "all different"; the following compares adjacent pairs only.
(defun char-not-equal (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))
    (let* ((script (string-compare-script))
           (table (get-char-equal-sort-table script)))         
      (cond (table
             (setq char (char-code char))
             (when (%i< char #x100)(setq char (aref table char)))
             (dolist (c others t)
               (let ((code (char-code c)))
                 (when (eq char
                           (setq char (if (%i> code #xff) code (aref table code))))
                   (return)))))
            (t (dolist (c others t)
                 (when (eq 0 (char-compare char (setq char c) script)) (return))))))))
|#

(defun char-lessp (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))    
    (dolist (c others t)
      (when (neq -1 (char-compare char (setq char c))) (return)))))

(defun char-not-lessp (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))    
    (dolist (c others t)
      (when (eq -1 (char-compare char (setq char c) )) (return)))))

(defun char-greaterp (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))    
    (dolist (c others t)
      (when (neq 1 (char-compare char (setq char c) )) (return)))))

(defun char-not-greaterp (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))
    (dolist (c others t)
      (when (eq 1 (char-compare char (setq char c) )) (return)))))


(defun char> (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))
    (let* ()      
      (setq char (char-code char))
      (dolist (c others t)
        (let ((code (char-code c)))
          (when (not (%i> char (setq char code)))
            (return)))))))

(defun char>= (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))
    (let* ()      
      (setq char (char-code char))
      (dolist (c others t)
        (let ((code (char-code c)))
          (when (not (%i>= char (setq char code)))
            (return)))))))


(defun char< (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))
    (let* ()      
      (setq char (char-code char))
      (dolist (c others t)
        (let ((code (char-code c)))
          (when (not (%i< char (setq char code)))
            (return)))))))

(defun char<= (char &rest others)
  (declare (dynamic-extent others))
  (locally (declare (optimize (speed 3)(safety 0)))
    (let* ()      
      (setq char (char-code char))
      (dolist (c others t)
        (let ((code (char-code c)))
          (when (not (%i<= char (setq char code)))
            (return)))))))

; This is Common Lisp
(defun char-int (c)
  (char-code c))


;If char has an entry in the *NAME-CHAR-ALIST*, return first such entry.
;Otherwise, if char is a graphics character, return NIL
;Otherwise, if char code is < 128, return "^C", otherwise "1nn"

(defun char-name (c)  
  (dolist (e *name-char-alist*)
    (declare (list e))    
    (when (eq c (cdr e))(return-from char-name (car e))))
  (let ((code (char-code c)))
    (declare (fixnum code))
    (cond ((< code #x7f)
           (when (< code (char-code #\space))
             (let ((str (make-string 2 :element-type 'base-character)))
               (declare (simple-base-string str))
               (setf (schar str 0) #\^)
               (setf (schar str 1)(code-char (%ilogxor code #x40)))
               str)))
          ((and (graphic-char-p c)) nil)
          (t (let* ((n (if (< code #o1000)
                                       3
                                       (if (< code #o10000)
                                         4
                                         (if (< code #o100000) 5 6))))
                    (str (make-string n :element-type 'base-character)))
               (declare (fixnum n)(simple-base-string str))
               (do ((i (1- n)(1- i)))
                   ((< i 0))
                 (declare (fixnum i))
                 (setf (schar str i)
                       (code-char (+ (char-code #\0)(%ilogand code 7))))
                 (setq code (lsh code -3)))
               str)))))

(defun string-downcase (string &key start end)
  (let ((copied nil))
    (if (not start) (setq start 0)(require-type start 'fixnum))
    (multiple-value-setq (string copied) (get-string-for-case string))
    (if (not end)(setq end (length string))(require-type end 'fixnum))       
    (or (%ascii-string-down string start end copied)
        (%strdown string start end copied))))

(defun %strdown (string start end &optional destructive)
  (%strup-down string start end :down destructive))


(defun copy-string-arg (string &aux (org 0) len)
  (etypecase string
    (string
     (setq len (length string))
     (multiple-value-setq (string org)(array-data-and-offset string)))
    (symbol
     (setq string (symbol-name string))
     (setq len (length string)))
    (character
     (return-from copy-string-arg
                    (make-string 1 :initial-element string :element-type (type-of string)))))
  (%substr string org (+ len org)))
 
(defun get-string-for-case (string)
  (etypecase string
    (simple-string string)
    (symbol (symbol-name string))
    (string (let ((org 0)
                  (len (length string)))
              (multiple-value-setq (string org)(array-data-and-offset string))
              (values (%substr string org (+ len org)) t)))
    ;; does anybody really use this??
    (character (values (string string) t))))

(defun string-upcase (string &key start end)
  (let ((copied))
    (if (not start) (setq start 0)(require-type start 'fixnum))
    (multiple-value-setq (string copied) (get-string-for-case string))
    (if (not end)(setq end (length string))(require-type end 'fixnum))       
    (or (%ascii-string-up string start end copied)
        (%strup string start end copied))))

(defun %strup (string start end &optional destructive)
  (%strup-down string start end :up destructive))


(defun %strup-down (string start end what destructive-p)
  (declare (fixnum start end))
  (let ((len (- end start))
        (copied nil)
        (strlen (length string)))
    (declare (fixnum len strlen))
    (setq string (ensure-simple-string string))
    (%stack-block ((the-thing (lsh  len 3)))
      (copy-string-to-ptr string start len the-thing)      
      (with-macptrs ((cfstr (#_CFStringCreateMutable (%null-ptr) 0)))
        (#_CFStringAppendCharacters cfstr the-thing len)
        (ecase what
          (:up (#_CFStringUpperCase cfstr (%null-ptr)))  ;; what if newlen neq len
          (:down (#_CFStringLowerCase cfstr (%null-ptr)))
          ((:capital :capitalize) (#_CFStringCapitalize cfstr (%null-ptr)) ))
        (let ((new-len (#_cfstringgetlength cfstr)))
          (%stack-block ((new-thing (%i+ new-len new-len)))
            (CFStringGetCharacters cfstr 0 new-len new-thing)
            (#_cfrelease cfstr)
            (when (and (base-string-p string)(eq new-len len))
              (when ;; ugh
                (dotimes (i len nil)
                  (declare (fixnum i))
                  (if (> (%get-word new-thing (%i+ i i)) #xff)
                    (return t)))
                (setq string (string-to-extended-string string))
                (setq copied t)))
            (when (not (eq new-len len)) ;; callers beware - may return a new string
              (let* (;(strlen (length string))
                     (len-delta (%i- new-len len))
                     (new-string (make-string (%i+ strlen len-delta) :element-type 'extended-character)))
                (setq copied t)
                (when (neq start 0)
                  (dotimes (i start)
                    (declare (fixnum i))
                    (setf (%scharcode new-string i)(%scharcode string i))))
                ;; and do the stuff between end and string length tooo
                (when (neq end strlen)
                  (dotimes (i (%i- strlen end))
                    (declare (fixnum i))
                    (setf (%scharcode new-string (%i+ i end len-delta))(%scharcode string (%i+ i end)))))
                (setq string new-string)))
            (when (and (not destructive-p)(not copied))
              (let (new-string)
                (if (base-string-p string)
                  (progn (setq new-string (make-string strlen :element-type 'base-character))
                         (%copy-ivector-to-ivector string 0 new-string 0 strlen))
                  (progn (setq new-string (make-string strlen :element-type 'extended-character))
                         (%copy-ivector-to-ivector string 0 new-string 0 (%i+ strlen strlen))))
                (setq string new-string)))
            (if (extended-string-p string)
              (%copy-ptr-to-ivector new-thing 0 string (%i+ start start) (%i+ new-len new-len))
              (dotimes (i new-len)  ;; bug if input is a base string and new stuff is extended? like upcase of y umlaut - fixed
                (declare (fixnum i))
                (setf (%scharcode string (%i+ i start)) (%get-word new-thing (%i+ i i)))))))))
    string))




(defun string-capitalize (string &key start end)
  (let ((copied nil))
    (multiple-value-setq (string copied) (get-string-for-case string))    
    (if (not start) (setq start 0)(require-type start 'fixnum))
    (if (not end)(setq end (length string))(require-type end 'fixnum))
    ;; fails paul dietz test for e.g. "a1a" - we get "A1A" he says "A1a" ?? - fixed now
    (%strcap string start end copied)))

;; destructive optional
(defun %strcap (string start end &optional destructive)
  (cond ((7bit-ascii-p string)
         (when (not destructive)(setq string (copy-string-arg string)))
         (%strcap-ascii string start end))
        (t (%strup-down string start end :capital destructive))))

(defun %strcap-ascii (string start end)
  (declare (fixnum start end))
  (let ((state :up)
        (i start))
    (declare (fixnum i))    
    (while (< i end)
      (let* ((c (%schar string i))
             (alphap (%strcap-alphanumericp c)))
        (if alphap
          (progn
            (setf (%schar string i)
                  (case state
                    (:up (char-upcase c))
                    (t (char-downcase c))))
            (setq state :down))
          (setq state :up)))
      (setq i (1+ i))))
  string)

; (new) recognize quotes as part of a word (eg, "Joe's" not "Joe'S")
(defun %strcap-alphanumericp (char)
  (or (alphanumericp char)
      (eql char #\')))


(defun string-studlify (string &key start end)
  (declare (ignore start end))
  string)



(defun nstring-downcase (string &key start end)
  (etypecase string
    (string     
       (if (not start) (setq start 0)(require-type start 'fixnum))
       (if (not end)(setq end (length string))(require-type end 'fixnum))
       (multiple-value-bind (sstring org) (array-data-and-offset string)
         (let ((new-sstr (or (%ascii-string-down sstring (%i+ start org)(%i+ end org) t)
                             (%strdown sstring (+ start org)(+ end org) t))))
           ;; maybe had to make a new string
           (if (eq new-sstr sstring)
             string
             (if (simple-string-p string)
               new-sstr
               (error "Hope this never happens"))))))))



(defun %ascii-string-down (string start end &optional destructive-p)
  (declare (fixnum start end))
  (when
    (dotimes (i (- end start) T)
      (declare (fixnum i))
      (let ((code (%scharcode string (%i+ i start))))
        (declare (fixnum code))
        (when (> code #xff) (return nil))
        (if destructive-p (setf (%scharcode string (%i+ i start))(uvref char-downcase-vector code)))))
    (if destructive-p 
      string
      (progn
        (setq string (copy-string-arg string))
        (dotimes (i (- end start) string)
          (declare (fixnum i))
          (let* ((code (%scharcode string (%i+ i start)))
                 (dcode (uvref char-downcase-vector code)))
            (when (neq dcode code)            
              (setf (%scharcode string (%i+ i start)) dcode))))))))

(defun nstring-upcase (string &key start end)
  (etypecase string
    (string     
     (if (not start) (setq start 0)(require-type start 'fixnum))
     (if (not end)(setq end (length string))(require-type end 'fixnum))
     (multiple-value-bind (sstring org) (array-data-and-offset string)
       (let ((new-sstr (or (%ascii-string-up sstring (%i+ start org)(%i+ end org) t)
                           (%strup sstring (%i+ start org)(%i+ end org) t))))
         ;; maybe had to make a new string
         (if (eq new-sstr sstring)
           string
           (if (simple-string-p string)
             new-sstr
             (error "couldn't"))))))))



(defun %ascii-string-up (string start end &optional destructive-p)
  (when
    (dotimes (i (- end start) T)
      (declare (fixnum i))
      (let ((code (%scharcode string (%i+ i start))))
        (declare (fixnum code))
        (when (or (eq code #xdf)(eq code #xb5)(> code #xfe)) (return nil)) ;; beware y umlaut & mu in case string is base-string, beware funny beta - ess zed - upcase is two chars wide
        (if destructive-p (setf (%scharcode string (%i+ i start))(uvref char-upcase-vector code)))))
    (if destructive-p
      string
      (progn
        (setq string (copy-string-arg string))
        (dotimes (i (- end start) string)
          (declare (fixnum i))
          (let* ((code (%scharcode string (%i+ i start)))
                 (ucode (uvref char-upcase-vector code)))      
            (when (neq ucode code)            
              (setf (%scharcode string (%i+ i start)) ucode))
            ))))))


(defun nstring-capitalize (string &key start end)
  (etypecase string
    (string     
       (if (not start) (setq start 0)(require-type start 'fixnum))
       (if (not end)(setq end (length string))(require-type end 'fixnum))
       (multiple-value-bind (sstring org) (array-data-and-offset string)
         (let ((new-sstr (%strcap sstring (+ start org)(+ end org) t)))
           ;; maybe had to make a new string
           (if (eq new-sstr sstring)
             string
             (if (simple-string-p string)
               new-sstr
               (error "couldn't"))))))))



(defun nstring-studlify (string &key start end)
  (declare (ignore start end))
  string)


(defvar unicode-char-sort-table nil)
(defvar unicode-char-equal-sort-table nil)


(defun char-code-compare-hairy (code1 code2 upcase-them)
  (%stack-block ((buf1 2)
                 (buf2 2))
    (%put-word buf1 code1 0)
    (%put-word buf2 code2 0)
    (with-macptrs ((cfstr1 (#_cfstringcreatewithcharacters (%null-ptr) buf1 1))
                   (cfstr2 (#_cfstringcreatewithcharacters (%null-ptr) buf2 1)))
      (unwind-protect
        (let ((res (#_cfstringcompare cfstr1 cfstr2 (logior (if upcase-them #$kCFCompareCaseInsensitive 0)
                                                            ;#$kcfcomparelocalized
                                                            (if nil #$kCFCompareNonliteral 0 ))))) ;  - nonliteral seems busted on OS-9
          RES)
        (#_cfrelease cfstr1)
        (#_cfrelease cfstr2)))))

#+ignore
(defun char-code-compare-hairy2 (code1 code2 upcase-them)
  (%stack-block ((buf1 2)
                 (buf2 2))
    (%put-word buf1 code1 0)
    (%put-word buf2 code2 0)
    (rlet ((equivalent :boolean)
           (order :sint32))
      ;; has a different view of whether upper case precedes or follows lower case - i think the other one is right
      (errchk (#_UCCompareTextDefault (if upcase-them  #$kUCCollateCaseInsensitiveMask 0)
               buf1
               1
               buf2
               1
               equivalent
               order))
      (if (pref equivalent :boolean)
        0
        (let ((onum (%get-signed-long order)))
          (if (%i< onum 0) -1 1))))))



(def-ccl-pointers make-sort-tables ()
  (setq unicode-char-sort-table (make-unicode-char-sort-table))
  (setq unicode-char-equal-sort-table (make-unicode-char-equal-sort-table)))

(defun char-compare (char1 char2 &optional script)
  (declare (ignore script))
  (let ((code1 (char-code char1))
        (code2 (char-code char2)))
    (declare (fixnum code1 code2))
    (if (eq code1 code2)
      0
      (if (and (< code1 256)(< code2 256))
        (let ((table unicode-char-equal-sort-table))  ;; don't much care for this
          (declare (optimize (speed 3)(safety 0)))           
          (let ((c1 (uvref table code1))
                (c2 (uvref table code2)))
            (declare (fixnum c1 c2))
            (if (eq c1 c2) 0 (if (< c1 c2) -1 1))))
        (char-code-compare-hairy code1 code2 t)))))


(defun latin1-string-compare (str1 start1 end1 str2 start2 end2)
  (let* ((len1 (%i- end1 start1))
         (len2 (%i- end2 start2))
         (table unicode-char-equal-sort-table)
         (limit (if *string-compare-non-literal* #x7f #xff)))
    (declare (fixnum len1 len2 limit))
    (dotimes (i (the fixnum (min len1 len2)) (if (eq len1 len2)
                                               (values t len1)
                                               (if (< len1 len2)
                                                 (values -1 len1)
                                                 (values 1 len2))))
      (declare (fixnum i))
      (let* ((c1 (%scharcode str1 (%i+ start1 i)))
             (c2 (%scharcode str2 (%i+ start2 i))))
        (declare (fixnum c1 c2))
        (unless (eq c1 c2)
          (when (or (> c1 limit)(> c2 limit))(return (values nil i)))
          (setq c1 (uvref table c1))
          (setq c2 (uvref table c2))
          (unless (eq c1 c2)
            (return (values (if (> c1 c2) 1 -1) i))))))))


(defun string-equal (string1 string2 &key start1 end1 start2 end2)      
  (string-compare2 string1 string2 start1 end1 start2 end2 #'unicode-string-equal))

(defun string-greaterp (string1 string2 &key start1 end1 start2 end2)  
  (string-compare2 string1 string2 start1 end1 start2 end2 #'unicode-string-greaterp))

(defun string-lessp (string1 string2 &key start1 end1 start2 end2)                 
  (string-compare2 string1 string2 start1 end1 start2 end2 #'unicode-string-lessp))

(defun string-not-greaterp (string1 string2 &key start1 end1 start2 end2)  
  (string-compare2 string1 string2 start1 end1 start2 end2 #'unicode-string-not-greaterp))

(defun string-not-equal (string1 string2 &key start1 end1 start2 end2)  
  (string-compare2 string1 string2 start1 end1 start2 end2 #'unicode-string-not-equal))

(defun string-not-lessp (string1 string2 &key start1 end1 start2 end2)  
  (string-compare2 string1 string2 start1 end1 start2 end2 #'unicode-string-not-lessp))



;; start and end args only make sense if nothing weird re combining chars or accented chars ....

(defun string-compare2 (string1 string2 start1 end1 start2 end2 fn)
  (if (or (symbolp string1)(characterp string1))
    (setq string1 (string string1))
    (when (encoded-stringp string1)
      (if (neq (the-encoding string1) #$kcfstringencodingunicode)(error "phooey"))
      (setq string1 (the-string string1))))
  (if (or (symbolp string2)(characterp string2))
    (setq string2 (string string2))  
    (when (encoded-stringp string2)
      (if (neq (the-encoding string2) #$kcfstringencodingunicode)(error "phooey"))
      (setq string2 (the-string string2)))) 
  (multiple-value-setq (string1 start1 end1)(string-start-end string1 start1 end1))  
  (multiple-value-setq (string2 start2 end2)(string-start-end string2 start2 end2))
  (funcall fn string1 string2 start1 end1 start2 end2))


(defun unicode-string-compare (str1 str2 start1 end1 start2 end2 &optional for-equal)
  (declare (ignore-if-unused for-equal))
  (let ((len1 (- end1 start1))
        (len2 (- end2 start2)))
    (declare (fixnum len1 len2))
    (when t ;(or (not for-equal)(eq len1 len2))  ;; it is possible to be equal if lengths not equal at least when non-literal
      (multiple-value-bind (val pos)                           
                           (latin1-string-compare str1 start1 end1 str2 start2 end2 )
        (if val
          (values val pos)
          (progn
            (when (not *string-compare-non-literal*)
              (when (and pos (neq pos 0))
                (setq start1 (%i+ start1 pos)
                      start2 (%i+ start2 pos))
                (setq len1 (%i- len1 pos)
                      len2 (%i- len2 pos))))
            (%stack-block ((buf1 (%i+ len1 len1))
                           (buf2 (%i+ len2 len2)))
              (copy-string-to-ptr str1 start1 len1 buf1)
              (copy-string-to-ptr str2 start2 len2 buf2)                    
              (with-macptrs ((cfstr1 (#_cfstringcreatewithcharacters (%null-ptr) buf1 len1))
                             (cfstr2 (#_cfstringcreatewithcharacters (%null-ptr) buf2 len2)))
                (unwind-protect
                  (let ((res (#_cfstringcompare cfstr1 cfstr2 (logior #$kCFCompareCaseInsensitive
                                                                      #$kcfcomparelocalized
                                                                      (if *string-compare-non-literal* #$kCFCompareNonliteral 0))))) ;  - Nonliteral seems to think a = Š
                    RES)
                  (#_cfrelease cfstr1)
                  (#_cfrelease cfstr2))))))))))

#+ignore
(defun unicode-string-compare2 (str1 str2 start1 end1 start2 end2 &optional for-equal)
  (declare (ignore-if-unused for-equal))
  (let ((len1 (- end1 start1))
        (len2 (- end2 start2)))
    (declare (fixnum len1 len2))
    (when t ;(or (not for-equal)(eq len1 len2))  ;; it is possible to be equal if lengths not equal at least when non-literal
      (multiple-value-bind (val pos)                           
                           (latin1-string-compare str1 start1 end1 str2 start2 end2 )
        (if val
          (values val pos)
          (progn
            (when (not *string-compare-non-literal*)
              (when (and pos (neq pos 0))
                (setq start1 (%i+ start1 pos)
                      start2 (%i+ start2 pos))
                (setq len1 (%i- len1 pos)
                      len2 (%i- len2 pos))))
            (%stack-block ((buf1 (%i+ len1 len1))
                           (buf2 (%i+ len2 len2)))
              (copy-string-to-ptr str1 start1 len1 buf1)
              (copy-string-to-ptr str2 start2 len2 buf2)
              (rlet ((equivalent :boolean)
                     (order :sint32)) 
                ;(print (list len1 len2))
                 ;; comparetextnolocale gets paramerr -  comparetextdefault seems to work - order -2 for less 2 for greater, equivalent T if equal 
                ;; seems to always be non-literal - is faster X 2
                (errchk (#_UCCompareTextDefault (logior #$kUCCollateCaseInsensitiveMask
                                                        (if *string-compare-non-literal*
                                                          (logior
                                                           #$kUCCollateDiacritInsensitiveMask
                                                           #$kUCCollateWidthInsensitiveMask
                                                           #$kUCCollateComposeInsensitiveMask)
                                                          0))
                                                   buf1
                                                   len1
                                                   buf2
                                                   len2
                                                   equivalent
                                                   order))
                (if (pref equivalent :boolean)
                  t
                  (let ((onum (%get-signed-long order)))
                    (if (minusp onum) -1 1)))))))))))



(defun unicode-string-equal (str1 str2 start1 end1 start2 end2)
  (multiple-value-bind (val pos) (unicode-string-compare str1 str2 start1 end1 start2 end2 t)
    (if (or (eq 0 val)(eq t val))(or pos t))))

(defun unicode-string-lessp (str1 str2 start1 end1 start2 end2)
  (multiple-value-bind (val pos) (unicode-string-compare str1 str2 start1 end1 start2 end2)
    (if (eq val -1)(or pos t))))
  

(defun unicode-string-greaterp (str1 str2 start1 end1 start2 end2)
  (multiple-value-bind (val pos) (unicode-string-compare str1 str2 start1 end1 start2 end2)
    (if (eq val 1)(or pos t))))

(defun unicode-string-not-greaterp (str1 str2 start1 end1 start2 end2)
  (multiple-value-bind (val pos) (unicode-string-compare str1 str2 start1 end1 start2 end2)
    (if (eq val 1) nil (or pos t))))

(defun unicode-string-not-lessp (str1 str2 start1 end1 start2 end2)
  (multiple-value-bind (val pos) (unicode-string-compare str1 str2 start1 end1 start2 end2)
    (if (eq val -1) nil (or pos t))))

(defun UNicode-string-not-equal (str1 str2 start1 end1 start2 end2)
  (multiple-value-bind (val pos) (unicode-string-compare str1 str2 start1 end1 start2 end2 t)
    (if (or (eq 0 val)(eq t val)) nil (or pos t))))                    
          

; forget script-manager - just do codes
(defun string-cmp (string1 start1 end1 string2 start2 end2)
  ;(multiple-value-setq (string1 string2) (get-maybe-encoded-strings string1 string2))
  (let ((istart1 (or start1 0)))
    (if (and (typep string1 'simple-string)(null start1)(null end1))
      (setq start1 0 end1 (length string1))
      (multiple-value-setq (string1 start1 end1)(string-start-end string1 start1 end1)))
    (if (and (typep string2 'simple-string)(null start2)(null end2))
      (setq start2 0 end2 (length string2))
      (multiple-value-setq (string2 start2 end2)(string-start-end string2 start2 end2)))
    (setq istart1 (%i- start1 istart1))        
    (let* ((val t))
      (declare (optimize (speed 3)(safety 0)))
      (do* ((i start1 (%i+ 1 i))
            (j start2 (%i+ 1 j)))
           ()
        (when (eq i end1)
          (when (neq j end2)(setq val -1))
          (return))
        (when (eq j end2)
          (setq end1 i)
          (setq val 1)(return))
        (let ((code1 (%scharcode string1 i))
              (code2 (%scharcode string2 j)))
          (declare (fixnum code1 code2))
          (unless (= code1 code2)            
            (setq val (if (%i< code1 code2) -1 1))
            (setq end1 i)
            (return))))
      (values val (%i- end1 istart1)))))

(defun string> (string1 string2 &key start1 end1 start2 end2)
  (multiple-value-bind (result pos) (string-cmp string1 start1 end1 string2 start2 end2)
    (if (eq result 1) pos nil)))

(defun string>= (string1 string2 &key start1 end1 start2 end2)
  (multiple-value-bind (result pos) (string-cmp string1 start1 end1 string2 start2 end2)
    (if (eq result -1) nil pos)))

(defun string< (string1 string2 &key start1 end1 start2 end2)
  (multiple-value-bind (result pos) (string-cmp string1 start1 end1 string2 start2 end2)
    (if (eq result -1) pos nil)))

(defun string<= (string1 string2 &key start1 end1 start2 end2)
  (multiple-value-bind (result pos) (string-cmp string1 start1 end1 string2 start2 end2)
    (if (eq result 1) nil pos)))

; this need not be so fancy?
(defun string/= (string1 string2 &key start1 end1 start2 end2)
  (multiple-value-bind (result pos) (string-cmp string1 start1 end1 string2 start2 end2)
    (if (eq result t) nil pos)))  



(provide 'chars)
