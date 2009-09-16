;;; -*- Syntax: Zetalisp; Base: 8; Patch-file: Yes; Mode: Lisp; Package: CCL -*-
;;; (c) Copyright 1985, Jim Salem, Thinking Machines Corporation, Inc.
;;; Feel free to copy this and send interesting changes back to Jim as long as you include this 
;;; copyright notice in its entirety.
;;; Creation Date: Wednesday, January 23, 1985 at 1:45:42 AM

;;; This was inspired by Brewster's version.

;;; Modified to run on the macintosh by Alan Ruttenberg, MIT Media Laboratory
;;; Escape on the MAC 2 or Clear on the mac
;;;      repeatedly pressing this will insert other possible completions
;;; For debugging purposes (ALL-COMPLETIONS) lists all of the completions

;;; Completions are stored on the plist of symbols with the same first three letters as the completion

;;; Modified for the macintosh. We will use event handler, so that all characters
;;; which are used in this file will be integers. Too tedious to all of this,
;;; So I am destructively modifying the file. -alanr


;;; ****************** CHANGE LOG ******************
;;;
;;; #_drawstring -> grafport-write-string
;;;  ----- 5.2b4
;;; more carbon-compat in display-mini-buffer-completion
;;; ------- 4.4b3
;;; carbon-compat 
;;; --------- 4.3.1
;;; 9/17/96 bill  Fix view-insertion-font.
;;; 9/06/96 slh   com-complete-word: use :bold for listeners (from AlanR)
;;; 3/06/87 14:05:03 Barmar:  Changed completion.  Fixed it to not
;;; lose when it is passed a mouse-character.
;;; 
;;; 3/23/87 19:57:15 Barmar:  Changed completion-intern.  Fixed it to return NIL when
;;; the word contains a non-string-char (such as a blip character).
;;; 
;;; 5/22/87 17:14:08 Barmar:  Added *select-buffer-comtab* and advised
;;; read-buffer-name to *mini-ie-comtab* to it, so that C-Return would
;;; work.
;;; 
;;; feb 7 /88 Macintosh changes: alanr
;;;   Changed so that most dealings with characterss are changed to integers.
;;;   changed defconst to defparameter
;;; april 15/88 Alanr: macintosh killed the file, so this is a rewrite.
;;; Monday May 23,1988 10:01:12pm alanr:  added dependency to advise
;;; 
;;; Wednesday August 17,1988 6:51:24pm alanr:  removed dependance on who-line, to use allegro 
;;;  1.2 minibuffer instead
;;; 
;;; Wednesday August 24,1988 6:05:51pm alanr:  in allegro 1.2.1 function key have codes greater
;;; than 1023, so I modified end-of-word-p
;;; 
;;; Wednesday October 12,1988 2:04:07pm alanr:  fixed event keystroke so that ) and other
;;;  terminators would register new word , instead of only space. Added #\" as a word delimiter
;;; 
;;; Thursday June 28,1990 11:53:am alanr; brought up to date on MACL 2.0
;;;
;;; 8/3/90 bill - require loop
;;; Friday October 5,1990 11:21am alanr. Made it work in all fred mixin views.
;;; 1/7/91 bill - Convert to new traps package.
;;; 1/22/91 bill - remove (proclaim '(ignore ignore))
;;; 7/22/91 bill - Fix compare-suffix which is never called since no suffix completions
;;;                are ever stored.  Maybe they should be.
;;; 02/23/92 gb - Use "ANSI" loop syntax in UPPER-LOWER-P.
;;; ------------- 2.0
;;; 04/15/93 bill keystroke-code can now return integers up to 8192.
;;;               view-mini-buffer-p -> view-mini-buffer
;;; 04/19/93 bill display-mini-buffer-completion works in new mini-buffer order.
;;; ------------- MCL-PPC 3.9
;;; 07/22/96 bill (method view-key-event-handler :around (fred-mixin t)) calls
;;;               end-of-word-p instead of just comparing with #\space.
;;;               Thanx to Arthur Ogus for pointing out this bug.
;;; *************** END OF CHANGE LOG ***************

(in-package :ccl)


(eval-when (:execute :compile-toplevel :load-toplevel)
  (export '(write-completions-to-disk read-completions-from-disk *fraction-of-uses-to-be-saved*
          *completion* *completion-characters* ))
  (require 'loop))

;;; Set this to nil to turn completion off.
(defvar *completion* t)

;; which keys are supposed to complete

;; for macs
(defvar *completion-characters* '(#\clear (:meta #\`) (:control #\`)))
(defvar *completion-keys* (mapcar #'keystroke-code *completion-characters*))

;;; This is the minimum length required before the completer checks for completions.
;;; Changing this to one would likely make for noticible delays. Two might be okay 
;;; Recompile *prefix-word* (below) when changed

(defparameter *prefix-length* 3)

;;; This is the minimum length a word must be to be stored as a possible completion
(defparameter *min-word-length* 6.)

;;; Maximum length of a completion word
(defparameter *max-word-length* 200.)

;;; Fraction of a completion's uses that is saved to disk
(defparameter *fraction-of-uses-to-be-saved* .90)

;;; Times a completion must be used during a session for it to be saved
(defvar *completion-min-uses* 2)

;;; Number of backup completion files to keep (excess ones are deleted)
(defparameter *number-of-extra-completion-files-to-keep* 3) 

(defvar *completion-package* (defpackage completion))


;;;***************************************************************************
;;; Displaying the completion
;;;***************************************************************************

;(defvar *completion-who-line-field* 
;  (oneof who-line-field :position 200 :from-end? t :length 200))
(defvar *last-completion-word-displayed* (make-array 200 :element-type 'character :fill-pointer 0))

(defun display-completion (word)
  (when (not (string= *last-completion-word-displayed* (setq word (or word ""))))
    (completion-copy-string word *last-completion-word-displayed*)
    (display-mini-buffer-completion (front-window))))

(defmethod display-mini-buffer-completion ((w t) &aux wptr)
  (when (setq wptr (wptr w))
    (let ((mini-buffer (view-mini-buffer w)))
      (when mini-buffer
        (without-interrupts
         (with-focused-view mini-buffer
           (multiple-value-bind (ff ms) (font-codes *mini-buffer-font-spec*)
             #+carbon-compat
             (set-wptr-font-codes wptr ff ms)
             #-carbon-compat
             (progn
               (%put-long wptr ff 68)
               (%put-long wptr ms 72)))
           (multiple-value-bind (a d) (font-info)
             (let* ((size (view-size mini-buffer))
                    (top 0)
                    (bottom (min (+ a d) (point-v size)))
                    (right (point-h size))
                    (left (max 0 (- right 200))))
               (declare (fixnum top left right bottom))
               (rlet ((r :rect :top top :left left :bottom bottom :right right))
                 #-carbon-compat (#_ValidRect r)
                 #+carbon-compat (valid-window-rect wptr r)
                 (#_EraseRect r)
                 (when #-carbon-compat (rref wptr windowRecord.hilited)
                       #+carbon-compat (#_iswindowhilited wptr)
                   (#_MoveTo (+ left 10) a)
                   #+ignore
                   (with-pstrs ((completion *last-completion-word-displayed*))                   
                     (#_DrawString completion))
                   #-ignore
                   (let ((complete  *last-completion-word-displayed*))
                     (grafport-write-string complete 0 (length complete)))
                   ))))))))))



;;;***************************************************************************
;;; Routines to (quickly) check for END-OF-WORD, PRINTING-CHARS, ALPHANUMERICS,
;;; UPPER/LOWER CASE, and VALID PREFIX CHARS.
;;;***************************************************************************

;;; These all count as end of word chars.



(defparameter *completion-end-of-word-table*
	  (let ((init (list #\space #\( #\) #\' #\` #\"
			    #\' #\, #\. #\? #\return #\linefeed ;#\!
			    '(:control #\return)
                            '(:control #\linefeed)
                            '(:meta #\return) '(:meta :control #\return)
                            '(:meta #\linefeed) '(:meta :control #\linefeed)
                            #\page #\tab 
                            '(:meta #\tab) '(:meta :control #\tab) 
                            '(:control #\tab)
			    #\[ #\] #\{ #\}
			    '(:control #\F) '(:control #\B)
                            '(:control #\N) '(:control #\P)
                            '(:control #\A) '(:control #\E) 
                            '(:meta #\P) '(:meta #\N) ;; I use m-P & m-N
			    '(:meta #\V) '(:control #\V)
                            '(:control #\<) '(:control #\>) '(:Meta #\B)
                            '(:meta #\F) '(:control :meta #\F) 
                            '(:control :meta #\B)
                            '(:control #\f) '(:control #\b)
                            '(:control #\n) '(:control #\p)
                            '(:control #\a) '(:control #\e) 
                            '(:meta #\p) '(:meta #\n) ;; i use m-p & m-n
			    '(:meta #\v) '(:control #\v)
                            '(:control #\<) '(:control #\>) '(:meta #\b)
                            '(:meta #\f) '(:control :meta #\f) 
                            '(:control :meta #\b)
                            #\rubout))
		(TABLE (make-array 8192 ;possible characters with control-meta bits
				      :element-type 'bit
				      :initial-element 0)))
	    (loop for character in init
                  for code = (keystroke-code  character)
		  do (when (< code 8192) (setf (aref table code) 1)))
	    table))

(defun end-of-word-p (char)
  "taken from expand-p in word abbrev mode"
  (and (< char 8192)
       (not (zerop (aref *completion-end-of-word-table* char)))))

(defun printing-char-p(char-code)
  (and (< char-code 127)
       (> char-code 31)))

(defun string-search-alphanumeric (string &optional (pos 0) (limit (length string)))
  (loop for i from pos below limit
	for char = (aref string i)
	when (alphanumericp char)
	  return i))

(defun string-search-not-alphanumeric
       (string &optional (pos 0) (limit (length string)))
  (loop for i from pos below limit
	for char = (aref string i)
	when (not (alphanumericp char))
	  return i))

(defun upper-lower-p (word)
  "Returns :UPPER :LOWER or :MIXED depending on the alphabetic case of WORD"
  (loop with upper-p = nil
	with lower-p = nil
	as char across word
	when (alpha-char-p char)
	  do (setq upper-p (or upper-p (upper-case-p char)))
	     (setq lower-p (or lower-p (lower-case-p char)))
	when (and upper-p lower-p) return :MIXED
	finally (return (if upper-p :UPPER :LOWER))))


(defun completion-copy-string (from-word to-word &optional (from-start 0)
			       (from-limit (length from-word))
			       (to-start 0) (case :MIXED))
  (case case
    (:MIXED
     (loop for i from from-start below from-limit
	   for j from to-start below *max-word-length*
	   do (setf (aref to-word j) (aref from-word i))))
    (:LOWER
     (loop for i from from-start below from-limit
	   for j from to-start below *max-word-length*
	   do (setf (aref to-word j) (char-downcase (aref from-word i)))))
    (:UPPER
     (loop for i from from-start below from-limit
	   for j from to-start below *max-word-length*
	   do (setf (aref to-word j) (char-upcase (aref from-word i)))))
    (otherwise (error "Bad CASE : ~A; Should have been :MIXED, :LOWER, or :UPPER" case)))

  (if (array-has-fill-pointer-p to-word)
      (setf (fill-pointer to-word)
	    (max 0 (min *max-word-length*
			(+ to-start (- from-limit from-start)))))))

(defun num-chars-to-trim (chars string)
  "LAST-OKAY-CHAR-POS (returned) is last non-trimmed char. of string.  = -1 for null string"
  (let* ((start 0) (len (length string)) (end (1- len)))
    (loop until (or (>= start len)
		    (null (dolist (char chars)
			    (when (char-equal (aref string start) char) (return t)))))
	  do (incf start))
    (loop until (or (< end 0)
		    (null (dolist (char chars)
			    (when (char-equal (aref string end) char) (return t)))))
	  do (decf end))
    (values start (- len end 1) end)))

(defun nstring-trim (chars string)
  (multiple-value-bind (start ignore end) (num-chars-to-trim chars string)
    (declare (ignore ignore))
    (cond ((>= start end) ;; null string
	   (setf (fill-pointer string) 0))
	  ((zerop start)
	   (setf (fill-pointer string) (1+ end)))
	  (t (completion-copy-string string string start (1+ end)))))
  string)

(defvar *output-word* (make-array *max-word-length*
				     :element-type 'character
				     :fill-pointer 0))

(defun add-in-missing-chars (chars saved-string original-string)
  (multiple-value-bind (before after) (num-chars-to-trim chars original-string)
    (completion-copy-string original-string *output-word* 0 before)

    (completion-copy-string
      saved-string *output-word* 0 (length saved-string) before
      (if (eq :MIXED (upper-lower-p original-string))
	  :MIXED (upper-lower-p original-string)))

    (let ((original-length (length original-string)))
      (completion-copy-string original-string *output-word*
			      (- original-length after) original-length
			      (length *output-word*)))
    ))

;;;***************************************************************************
;;; Copy the results of the following two functions before permanently saving their results
;;; only GET-COMPLETION and SAVE-COMPLETION should use these

(defvar *input-word* (make-array *max-word-length*
				    :element-type 'character
				    :fill-pointer 0))

(defun INITIALIZE-COMPLETION-WORD (word)
  "copys to *INPUT-WORD* and removes leading and trailing quotes"
  (if (neq word *input-word*) (completion-copy-string word *input-word*))
  (nstring-trim `(#\' #\.) *input-word*)
  *input-word*
  )

(defun INITIALIZE-REPLACEMENT-WORD (saved-string current-string)
  "Picks a good case and adds in quotes missing in SAVED-STRING"
  (add-in-missing-chars `(#\' #\.) saved-string current-string)
  *output-word*)


;;;***************************************************************************
;;; Given a string, returns a symbol interned in the COMPLETION: package
;;; The symbol name is *PREFIX-LENGTH* chars. long.  If the string is not long 
;;; enough or contains non-internable chars., NIL is returned
;;;***************************************************************************

(defvar *prefix-word* (make-array *prefix-length*
				     :element-type 'character))

(defun completion-intern (word-to-intern from limit)
  (loop for i from from below limit
	for j from 0
	do (setf (aref *prefix-word* j) (char-upcase (aref word-to-intern i))))
  (or (find-symbol *prefix-word* *completion-package*)
      (intern (princ-to-string *prefix-word*) *completion-package*)))

(defun get-prefix (word)
  "Call inside inhibit scheduling.  WORD should have special chars. removed"
  (and (>= (length word) *prefix-length*)
       (completion-intern word 0 *prefix-length*)))

(defun get-suffix (word)
  "Call inside inhibit scheduling.  WORD should have special chars. removed"
  (let ((len (length word)))
    (and (>= len *prefix-length*)
	 (completion-intern word (- len *prefix-length*) len))))

(defun get-initials (word)
  "Call inside inhibit scheduling.  WORD should have special chars. removed"
  (loop for pptr from 0 below *prefix-length*
        for wptr = 0 then (string-search-not-alphanumeric word wptr)
        when (null wptr) return nil
        do (setq wptr (string-search-alphanumeric word wptr))
        (if (null wptr) (return nil))
        (setf (aref *prefix-word* pptr)
              (char-upcase (aref word wptr)))
        finally (return (or (find-symbol *prefix-word* *completion-package*)
                            (intern (princ-to-string *prefix-word*) *completion-package*)))))

;;;***************************************************************************
;;; GETTING and SAVING the completion
;;;***************************************************************************

;;; The completion words are stored on the plist of the symbol named with the first three
;;; chars. of the completion word.
;;; Form is ( <word> . <times it's been used>)
;;; <times ...> is incremented each time save-completion is called

(defmacro completion-word (completion) `(car ,completion))
(defmacro completion-times-used (completion) `(cdr ,completion))

(defmacro make-completion (word &optional (times 0))
  `(cons ,word ,times ))

(defun SAVE-COMPLETION (word &optional number-of-uses &aux completion-cell)
  (without-interrupts
   (let* ((completion-word (initialize-completion-word word))
          (prefix (get-prefix completion-word)))
     (when prefix
       (setq completion-cell
             (put-completion-on-plist completion-word prefix 'prefix-completions))
       ;;put back in because peter and salem wanted it.  We need science. --brewster
       (let ((initials (get-initials completion-word)))
         (when initials
           (put-completion-on-plist completion-word
                                    initials 'initial-completions
                                    completion-cell)))
       (unless (eq T (completion-times-used completion-cell))
         (if number-of-uses
           (setf (completion-times-used completion-cell) number-of-uses)
           (incf (completion-times-used completion-cell))))))))

(defun put-completion-on-plist (word symbol property &optional completion-object)
  "Call inside inhibit scheduling"
  (let* ((plist (get symbol property))
	 (posn (loop for old-completion in plist
		     for count from 0
		     do (if completion-object
			    (if (eq completion-object old-completion) (return count))
			    (if (string-equal (completion-word old-completion) word)
				(return count)))))
	 (new-completion-object (or completion-object
				    (and posn (nth posn plist))
				    ;;; copy before saving
				    (make-completion (subseq word 0)))))

    (unless (string= word (completion-word new-completion-object))
      ;; update string unless it matches exactly 
      (completion-copy-string word (completion-word new-completion-object)))

    (case posn
      ((nil) (setf (get symbol property)
                 (cons new-completion-object plist)))
      (0 ) ;;; already in right place
      (otherwise (rplacd (nthcdr (1- posn) plist) (nthcdr (+ posn 1) plist))
                 (setf (get symbol property)
                       (cons new-completion-object plist)
                       )))
    new-completion-object))

(defvar *possibilities* nil)
(defvar *last-possibility-word* (make-array *max-word-length*
					       :element-type 'character
					       :fill-pointer 0))

;;; cleared only by non-printing/non-end-of-word char. typed at editor (i.e. M-X)

;;; OLD-LEN >= NEW-LEN guaranteed
(defun compare-prefix (new new-len old ignore)
  (declare (ignore ignore))
  (string-equal old new :start1 0 :start2 0 :end1 new-len))

(defun compare-suffix (new new-len old old-len)
  (let ((len-diff (- old-len new-len)))
    (and (not (eql len-diff 0))
         ;; since if the match is exact the prefix completion would've gotten it
         (string-equal old new
                       :start1 (if (> len-diff 0) len-diff 0)
                       :start2 (if (< len-diff 0) 0 len-diff))
         )))

(defun compare-initials (new new-len old old-len)
  (loop for i from 0 below new-len
	for j = 0 then (string-search-not-alphanumeric old j)
	when (or (null j) (= old-len (1+ j))) return nil
	do (setq j (string-search-alphanumeric old j))
	   (if (or (null j) (not (char-equal (aref new i) (aref old j))))
	       (return nil))
        finally (return T)))

(defun GET-COMPLETION (word &optional (index 0))
  (when word
    (without-interrupts
     (let* ((word-to-complete (initialize-completion-word word))
            (prefix (get-prefix word-to-complete))
            completion-type ;; (Rose)
            completion-word )
       (when prefix
         ;;; Prefix
         (multiple-value-setq (completion-word index)
               (get-completion-from-plist word-to-complete prefix
                                          (setq completion-type 'prefix-completions)
                                          index #'compare-prefix))

         (when (not completion-word)
           ;;; SUFFIX
           (multiple-value-setq (completion-word index)
               (get-completion-from-plist word-to-complete (get-suffix word-to-complete)
                                          (setq completion-type 'suffix-completions)
                                          index #'compare-suffix)))
         
         (when (not completion-word)
           ;;; INITIALS [mvb  -- multiple-value-bind]
           (multiple-value-setq (completion-word index)
               (get-completion-from-plist word-to-complete prefix
                                          (setq completion-type 'initial-completions)
                                          index #'compare-initials))))
    (when completion-word
      (values
	(initialize-replacement-word completion-word word)
	completion-type))))
     ))

(defun get-completion-from-plist (word symbol property index string-compare-function)
  (let ((plist (get symbol property))
	(len (length word))
	complete)
    (setq complete
	  (loop for old-completion in plist
		for old-word = (completion-word old-completion)
		for old-len  = (length old-word)
		when (and (<= len old-len)
			  (funcall string-compare-function word len old-word old-len))
		  do (decf index)
		when (minusp index) return old-word))

    (values complete index)))

(defun COUNT-COMPLETIONS (word &aux (completions-count 0))
  (when word
    (without-interrupts
     (let* ((word-to-complete (initialize-completion-word word))
            (prefix (get-prefix word-to-complete)))
       (when prefix
         ;;; Prefix
         (setq completions-count
               (+ (count-completions-in-plist word prefix 'prefix-completions #'compare-prefix)
                  (count-completions-in-plist
                   word (get-suffix word) 'suffix-completions #'compare-suffix)
                  (count-completions-in-plist
                   word prefix 'initial-completions #'compare-initials))))))
     )
  completions-count)

(defun count-completions-in-plist (word symbol property string-compare-function)
  (let ((plist (get symbol property))
	(len (length word)))
    (loop for old-completion in plist
	  for old-word = (completion-word old-completion)
	  for old-len  = (length old-word)
	  when (and (<= len old-len)
		    (funcall string-compare-function word len old-word old-len))
	    count T)))

(defun REMOVE-COMPLETION (word)
  (let ((prefix (get-prefix word))
	(suffix (get-suffix word))
	(initial (get-initials word)))
    (setf (get prefix 'prefix-completions)
	  (remove word (get prefix 'prefix-completions)
		     :test #'string-equal :key #'car))
    (setf (get suffix 'suffix-completions)
	  (remove word (get suffix 'suffix-completions)
		     :test #'string-equal :key #'car))
    (setf (get initial 'initial-completions)
	  (remove word (get initial 'initial-completions)
		     :test #'string-equal :key #'car))
    ))

(defun INCF-COMPLETION (word &optional (amount 1))
  ;;; This works because the same cell is used for all of the property lists storing
  ;;; the completion, so we only need to update one of them
  (let* ((prefix (get-prefix word))
	 complete)
    (when prefix
      (setq complete
	    (loop for old-word in (get prefix 'prefix-completions)
		  when (string-equal word (completion-word old-word))
		  return old-word))
      (when (and complete (not (eq T (completion-times-used complete))))
	(incf (completion-times-used complete) amount)))))

(defun completion-stats ()
  (let ((word-count 0) (use-count 0) (words-with-number-of-uses 0))
    (loop for complete in (all-completions)
	  do (incf word-count)
	  when (neq T (completion-times-used complete))
	    do (incf words-with-number-of-uses)
	       (incf use-count (completion-times-used complete)))
    (values word-count use-count words-with-number-of-uses)))

;;;***************************************************************************
;;; The word before or under the point
;;;***************************************************************************

(defparameter *completion-word-boundary-characters* 
  (concatenate 'string ":;().,#|`' \"" (string #\return) (string #\tab)))

(defun last-partial-word (view point &optional entire-word-under-point)
  (let ((buffer (fred-buffer view))
        (here point))
    (let ((start (buffer-char-pos buffer *completion-word-boundary-characters* 
                                  :end here
                                  :from-end t))
          (end (buffer-char-pos buffer *completion-word-boundary-characters* 
                                  :start here)))
      (let ((start (if start (1+ start) (buffer-line-start buffer here)))
            (end (if entire-word-under-point
                   (or end (buffer-line-end buffer here))
                   here)))
        (values
         (buffer-substring buffer start end) start end)))))

;;;***************************************************************************
;;; every time a key is pressed
;;;***************************************************************************

(defun buffer-last-point (place)
  (let* ((plist (buffer-plist place))
         (last-point (getf plist 'last-point)))
    (or last-point (make-mark place))))

(defun set-buffer-last-point(position)
  (set-mark (buffer-last-point position) position))

(defvar *last-command-was-complete-p* nil)
(defvar *C-X-flag* nil)

(defvar *control-return* (keystroke-code '(:control #\return)))
(defvar *control-x* (keystroke-code '(:control #\x)))

(defun was-the-completion-character? (ch)
  (member ch *completion-keys* :test #'=))

(defun completion (char view) ;; called after every character
  ;; first test if we are done with the word and should add it to our list
  (when (not (was-the-completion-character? char))
    (setq *last-command-was-complete-p* nil)
    (when *completion*
      (let ((point (fred-buffer view)))
        (cond ((and (end-of-word-p char) (not *c-x-flag*))
               (let ((word (last-partial-word view (buffer-last-point point) t)))
                 (if (>= (length word) *min-word-length*)
                   (save-completion word)))
               (display-completion
                (get-completion (last-partial-word view point) 0))
               (set-buffer-last-point point))
              ((printing-char-p char)
               (let ((completion (get-completion (last-partial-word view point) 0)))
                 (display-completion completion)
                 (set-buffer-last-point point)))
              ((= char *control-x*) (setq *c-x-flag* t))  ;; ignore next char.
              (t (display-completion
                  (get-completion (last-partial-word view point) 0))
                 (set-buffer-last-point point)))))
    (setq *c-x-flag* nil)))

;;;***************************************************************************
;;; completing a word
;;;***************************************************************************

(defvar *completion-index* 0)
(defvar *first-point-of-completing-string* nil)
(defvar *completing-string* "")
(defvar *control-u-flag*)
(defvar *point-after*)

(defmethod view-insertion-font ((w simple-view))
  (let ((w (view-window w)))
    (and w
         (view-insertion-font (view-window w)))))

; A method that is always applicable.
(defmethod view-insertion-font ((w t))
  nil)

; No special insertion font for normal windows
(defmethod view-insertion-font ((w window))
  nil)

(when (find-class 'listener)
  (defmethod view-insertion-font ((w listener))
    '(:bold)))

(defun com-complete-word (view)
  "Tries to complete the word currently behind the point."
  (let* ((this-buffer (fred-buffer view))
         (point (fred-buffer view)))

      ;;; I check this rather than *LAST-COMMAND-TYPE* since I set
      ;;; *LAST-COMMAND-TYPE* to 'YANK to get c-W to work right
    (unless (eq *last-command-was-complete-p* view)
      (multiple-value-setq (*completing-string* *first-point-of-completing-string* *point-after*)
                           (last-partial-word view point))
      (setq *completion-index* -1))

    (cond ((and *completing-string* *first-point-of-completing-string*)
           (setq *last-command-was-complete-p* view)
           ;;; get the word
           (let ((completion-string
                  (or (get-completion *completing-string* (incf *completion-index*))
                      (get-completion *completing-string* (setq *completion-index* 0)))))
             (cond (completion-string
                    (let ((font (buffer-char-font-index
                                 this-buffer *first-point-of-completing-string*)))
                      (buffer-delete this-buffer
                                     *first-point-of-completing-string*
                                     *point-after*)
                      ;                    (when (mark-backward-p point)
                      ;                      (reverse-mark point))
                      (buffer-insert this-buffer completion-string *point-after*
                                     (or (view-insertion-font view)
                                         font)))
                    (when *completion*
                      (display-completion
                       (or (get-completion *completing-string* (1+ *completion-index*))
                           (and (not (zerop *completion-index*))
                                (get-completion *completing-string* 0))))))
                   (t (display-completion nil)))))
          (t (display-completion nil)))))

(defun clear-all-completions ()
  (do-symbols (prefix *completion-package*)
    (remprop prefix 'prefix-completions)
    (remprop prefix 'suffix-completions)
    (remprop prefix 'initial-completions)))

(defun set-all-t-completions-to-one ()
  "Changes all completions that have a T number of uses to 1."
  (do-symbols (prefix *completion-package*)
    (mapcar #'(lambda (cell)
                (when (eq (cdr cell) t)
                  (setf (cdr cell) 1)))
            (get prefix 'prefix-completions))))


;; for testing
(defun all-completions ( &aux all)
  (do-symbols (prefix *completion-package*) 
    (setq all (append all (get prefix 'prefix-completions))))
  all)

(defun print-all-completions (&rest plists)
  (if (null plists)
      (setq plists '(prefix-completions suffix-completions initial-completions)))
  (loop for prop in plists
	do (format t "~2%PLIST -- ~A:" prop)
        (do-symbols (prefix *completion-package*)
          (let ((list (get prefix prop)))
            (when list (format t "~%~A  ~A" prefix list))))))
  

;;;***************************************************************************
;;;installing completion in the world
;;;***************************************************************************

;; define the completion keys
(loop for key in *completion-keys* do 
      (comtab-set-key *comtab* key 'com-complete-word nil))

;; add a edit menu item to turn it on and off

(defvar *completion-edit-menu-item* 
  (let ((it (make-instance 'menu-item
                           :menu-item-title "Completion"
                           :menu-item-action 'completion-toggle)))
    (add-menu-items *edit-menu*
                    (make-instance 'menu-item :menu-item-title "-" :disabled t) 
                    it)
    (set-menu-item-check-mark it *completion*)
    it))

(defun completion-toggle ()
  (setq *completion* (not *completion*))
  (set-menu-item-check-mark *completion-edit-menu-item* *completion*))


(defmethod view-key-event-handler :around ((w fred-mixin) *current-character*)
  (let* ((*current-keystroke* (event-keystroke (rref *current-event* eventRecord.Message)
                                               (rref *current-event* eventRecord.Modifiers))))
    (if (end-of-word-p *current-keystroke*)
      (progn
        (when *completion*
          (completion *current-keystroke* w))
        (call-next-method))
      (progn
        (call-next-method)
        (when *completion*
          (completion *current-keystroke* w)
          )))))

(defmethod view-click-event-handler :after  ((w fred-mixin) ignore)
  (declare (ignore ignore))
  (completion #.(keystroke-code '(:control #\f)) w))


;;;***************************************************************************
;;; Saving completions to disk
;;***************************************************************************

(defun date-string (universal-time)
  (multiple-value-bind (second minute hour date month year day-of-week) 
                       (decode-universal-time universal-time)
    (let ((months '(January February March April May June 
                    July August September October November December))
          (days '(monday tuesday wednesday thursday friday saturday sunday)))
      (format nil "~A ~A ~A,~A ~A:~2,'0D:~2,'0D ~A" 
              (string-capitalize (string (nth day-of-week days)))
              (string-capitalize (string (nth (- month 1) months)))
              date year (mod hour 12) minute second
              (if (plusp (- hour 12)) "pm" "am")))))
    
(defun compute-min-uses-from-uses ()
  (multiple-value-bind (total num-uses num-words-with-uses)
      (completion-stats)
    total ;; not used
    (if (zerop num-words-with-uses)
      0
      (floor (* *fraction-of-uses-to-be-saved* (/ (float num-uses) num-words-with-uses))))))


(defun WRITE-COMPLETIONS-TO-DISK (filename &optional (min-uses *completion-min-uses*))
  (let ((completions-list nil))
    (do-symbols (sym *completion-package*)
      (let ((plist (get sym 'prefix-completions)))
        (loop for completion in plist
              when (or (eq T (completion-times-used completion))
                       (<= min-uses (completion-times-used completion)))
              do (progn (push completion completions-list)
                        (and (neq T (completion-times-used completion))
                             (setf (completion-times-used completion)
                                   (floor (* (completion-times-used completion)
                                             *fraction-of-uses-to-be-saved*)))))
              else do (setf (completion-times-used completion) 0))))
    (output-completion-list-to-path filename completions-list)))

(defun READ-COMPLETIONS-FROM-DISK (filename)
  (set-all-t-completions-to-one) ;; change everything with T to things with 1 (sorry this comment sucks)
  (let ((new-list (input-completion-list-from-path filename)))
    (loop for completion in new-list
          do (save-completion (completion-word completion)
                              (completion-times-used completion)))))

;;; Form is
;;; A series of cons one per completion
;;; either ("xyzcompletion" . number-of-uses) or ("xyzcompletion") which is the same as




;;; ("xyzcompletion" . T)  [= infinite number of uses]

(defparameter *completion-file-header*
	  ";;;-*- Syntax: Common-lisp; Mode: Lisp; Base: 10. -*-
;;; This is a series of completions saved to disk and generated by
;;; the completion system
;;;
")

(defun output-completion-list-to-path (path list)
  (unless (directoryp (make-pathname :directory (pathname-directory path)))
    (message-dialog 
     (format nil "Can't save completions to ~S since the directory doesn't exist" path))
    (return-from output-completion-list-to-path))
  (when (probe-file path) (delete-file path))
  (let ((*print-base* 10.))
    (when *load-verbose*
      (format t ";Writing Completions to ~S...~%" path))
    (with-open-file (stream path :direction :output :if-does-not-exist :create)
      (format stream "~A" *completion-file-header*)
      (format stream "~%;;; Created: ~A" (date-string (get-universal-time)))
      (format stream "~%~%")
      (loop for completion in list
            do (format stream "~S~%" completion)))))

(defun input-completion-list-from-path (path)
  (let ((*read-base* 10.))
    (when (probe-file path)
      (when *load-verbose*
        (format t ";Reading Completions from ~S...~%" path))
      (with-open-file (stream path :direction :input)
        (loop for completion = (read stream nil :eof)
              until (eq completion :eof)
              collect (case (type-of completion)
                        (symbol  (cons (string completion) T))
                        (string (cons completion T))
                        (list   completion)
                        (cons completion)
                        (otherwise (error "Bad completion read ~A" completion))))))))




(provide 'completion)
