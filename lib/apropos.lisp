;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  5 7/26/96  akh  faster %apropos-substring-p
;;  3 10/27/95 akh  merge apropos-aux patch
;;  2 10/12/95 akh  %apropos-substring-p for PPC
;;  2 4/24/95  akh  probably no change
;;  2 3/14/95  akh  add Dave Yosts fancy formatting
;;  (do not edit before this line!!)

;; Apropos.lisp
;; Copyright 1986-1987, Coral Software Corporation
;; Copyright 1988-1994, Apple Computer, Inc.
;; Copyright 1995-1999, Digitool, Inc.

; Modification History
;
; 01/18/05 apropos-substring-p - forget get-char-up-table
; -------- 5.1 final
; avoid duplicates in apropos-list-aux
; --------- 5.1b1
; 05/10/99 akh apropos-aux says Class if so.
;; ----------- MCL 4.3b1
; 01/26/96 bill fix %apropos-substring-p
; 3/24/95 slh   CL-compliant apropos-list back
;------------- 3.0d17
;06/19/93 alice %apropos-substring-p is fat string aware
;05/24/93 string< => string-lessp
;13/22/93 alice %apropos-substring-p returns something useful when true
;09/20/91 alice change sense of *apropos-case-...* in %apropos-substring-p
;------------- 2.0b3
;07/21/91 gb use DYNAMIC-EXTENT.
;02/04/91 bill apropos-list uses ALMS's algorithm for deleting duplicates.
;01/28/91 gb  %apropos-substring-p looks at *apropos-case-sensitive-p*.
;10/16/90 gb  no %str-length.
;06/14/90 bill fix font.
;12/27/89 gz removed a (put 'apropos 'version 2)
;09/11/89 gz no more %sym-fn-loc
;06/06/87 gb new lap lfun bits.
;04/07/87 gz made apropos know about macros.
;            changed %apropos-substring-p use lfentry, no frame ptr.
;02/05/87 gz %member -> memq
;01/29/87 gz %put -> put, %str-char -> schar.
;01/17/87 gz Recoded %apropos-substring-p in lap.
;01/14/87 gb %symbol-function, -value lose %.
;01/04/86 gz Packages.
;10/07/86 gz New strings, can't call munger.
; 8/09/86 gb New symbols : %symbol-fn-loc usage, etc.
; 5/26/86 gz Added a %put so can tell if loaded.
;            str-argp => string-argp (former is level-2...)
; 2/23/86 gb fixes in str-index, access "new" (4.12) hash table

(in-package :ccl)

(eval-when (:execute :compile-toplevel)
   (require :level-2)
   (require :lap)
   (require :lapmacros))

(defun apropos-list (string &optional package &aux list)
  (setq string (string-arg string))
  (if package
    (do-symbols (sym package)
      (when (%apropos-substring-p string (symbol-name sym))
        (push sym list)))
    (do-all-symbols (sym)
      (when (%apropos-substring-p string (symbol-name sym))
        (push sym list))))
  (let* ((last 0)                      ; not a symbol
         (junk #'(lambda (item)
                   (declare (debugging-function-name nil))
                   (or (eq item last) (progn (setq last item) nil)))))
    (declare (dynamic-extent junk))
    (setq list (delete-if junk (sort list #'string-lessp))))
  list)

(defvar *apropos-indent-to-search-string* nil)
(defun apropos-list-aux (theString package indent-to-search-string &aux theList)
  (setq theString (string-arg theString))
  (if package
    (do-symbols (sym package)
      (when (%apropos-substring-p theString (symbol-name sym))
        (push sym theList)))
    (do-all-symbols (sym)
      (when (%apropos-substring-p theString (symbol-name sym))
        ;; some syms are external in both CCL and MCL-MOP 
        (push sym theList))))
  (let* ((last 0)                      ; not a symbol
         (junk #'(lambda (item)
                   (declare (debugging-function-name nil))
                   (or (eq item last) (progn (setq last item) nil)))))
    (declare (dynamic-extent junk))
    ;; duh the delete-if doesn't work unless the list is sorted!
    (delete-if junk (sort-symbol-list theList (if indent-to-search-string
                                                theString
                                                nil)))))
  
(defun apropos-string-indented (symTuple indent)
    (let ((pr-string     (prin1-to-string (aref symTuple 0)))
          (displayOffset (aref symTuple 3)))
      (format nil "~v@a~a"
              indent
              (subseq pr-string 0 displayOffset)
              (subseq pr-string displayOffset))))
  
#| sorry, not CL
(defun apropos-list (theString &optional package)
  (multiple-value-bind (symVector indent) (apropos-list-aux theString package *apropos-indent-to-search-string*)
    (loop for symTuple across symVector
          collect (aref symTuple 0))))
|#

(defun apropos-aux (theString symtuple indent)
  (declare (ignore theString))
  (let ((sym (aref symtuple 0))
        val)
    (format t "~a" (apropos-string-indented symtuple indent))
    (when (setq val (fboundp sym))
      (cond ((functionp val)
             (princ ", Def: ")
             (prin1 (type-of val)))
            ((setq val (macro-function sym))
             (princ ", Def: MACRO ")
             (prin1 (type-of val)))
            (t (princ ", Special form"))))
    (when (boundp sym)
      (princ ",  Value: ")
      (prin1 (symbol-value sym)))
    (when (find-class sym nil) (princ ", Class"))
    (terpri)))

  
(defun apropos (theString &optional package)
    (multiple-value-bind (symVector indent) (apropos-list-aux theString package *apropos-indent-to-search-string*)
      (loop for symtuple across symVector
        do (apropos-aux theString symtuple indent))
      (values)))
  
#|
(defun apropos (string &optional package)
  (setq string (string-arg string))
  (if package
    (do-symbols (sym package) (apropos-aux string sym))
    (do-all-symbols (sym) (apropos-aux string sym)))
  (values))

(defun apropos-aux (string sym &aux val)
  (when (%apropos-substring-p string (symbol-name sym))
    (prin1 sym)
    (when (setq val (fboundp sym))
      (cond ((functionp val)
             (princ ", Def: ")
             (prin1 (type-of val)))
            ((setq val (macro-function sym))
             (princ ", Def: MACRO ")
             (prin1 (type-of val)))
            (t (princ ", Special form"))))
    (when (boundp sym)
       (princ ",  Value: ")
       (prin1 (symbol-value sym)))
    (terpri)))
|#

; (%apropos-substring-p a b)
; Returns true iff a is a substring (case-sensitive) of b.
; Internal subroutine of apropos, does no type-checking. 


; used by fred-help, list-definitions-dialog, preferences dialog
; is A a substring of B
(defun %apropos-substring-p (a b)
  (let ((charA0 (%schar a 0))
        (alen (length a))
        (blen (length b)))
    (declare (fixnum alen blen) (optimize (speed 3)(safety 0)))
    (if *apropos-case-sensitive-p*
      (dotimes (i (the fixnum (%imin blen (%i+ 1 (%i- blen alen)))))
        (declare (fixnum i))
        (when (eq (%schar b i) chara0)
          (when
            (do ((j 1 (1+ j)))
                ((>= j alen) t)
              (declare (fixnum j))
              (when (neq (%schar a j)(%schar b (%i+ j i)))
                (return nil)))
            (return  (%i- blen i alen)))))
      (let* ()
        (setq chara0 (char-upcase chara0))
        (dotimes (i (the fixnum (%imin blen (%i+ 1 (%i- blen alen)))))
          (declare (fixnum i))
          (when (eq chara0 (char-upcase (%schar b i)))
            (when
              (do ((j 1 (1+ j)))
                  ((>= j alen) t)
                (declare (fixnum j))
                (when (neq (char-upcase (%schar a j))
                           (char-upcase (%schar b (%i+ j i))))
                  (return nil)))
              (return  (%i- blen i alen)))))))))
      
    

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; from Dave Yost
(defun find-sym-alpha-part (sym)
  (let* ((str (prin1-to-string sym))
         (sortOffset (let ((sym-start (if (find #\: str)
                                      (loop for ind from (1- (length str)) downto 0
                                            when (eql #\: (char str ind))
                                            return (1+ ind))
                                      0)))
                     (+ sym-start (find-alpha-char (subseq str sym-start))))))
    (values str sortOffset sortOffset)))

(defun find-str-in-sym (str sym)
  (let* ((symStr (string-arg (prin1-to-string sym)))
         (sortOffset (let ((sym-start (if (find #\: str)
                                      (loop for ind from (1- (length str)) downto 0
                                            when (eql #\: (char str ind))
                                            return (1+ ind))
                                      0)))
                     (+ sym-start (find-alpha-char (subseq str sym-start)))))
         (displayOffset (let ((sym-start (if (find #\: symStr)
                                       (or (loop for ind from (1- (length symStr)) downto 0
                                             when (eql #\| (schar symStr ind))
                                             do (setf ind (loop for ind2 from (1- ind) downto 0
                                                                when (eql #\| (schar symStr ind2))
                                                                return ind2))
                                             when (eql #\: (char symStr ind))
                                             return (1+ ind))
                                           0)
                                       0)))
                      (+ sym-start (search (string-upcase str) (string-upcase (subseq symStr sym-start)))))))
    (values symStr sortOffset displayOffset)))

(defun find-alpha-char (str)
  "returns the character position of the first
alphabetic character in str, or the length of str
if it contains no alphabetic characters."
  (setq str (string-arg str))
  (dotimes (ind (length str)  ind)
    (when (alpha-char-p (schar str ind))
       (return ind))))

(defun sort-symbol-list (theList search-string)
  ;;; First precompute the stylized string form of the symbols as they will be compared
  ;;; and calculate the maximum indent
  (multiple-value-bind (tmpVector indentation)
                       (let (sortOffset
                             displayOffset
                             str)
                         (loop for x in thelist do
                           (multiple-value-setq (str sortOffset displayOffset)
                                    (if search-string
                                      (find-str-in-sym search-string x)
                                      (find-sym-alpha-part           x)))
                           
                           
                               maximize displayOffset into indentation1
                               collect `#(,x ,(string-arg (subseq str sortOffset)) ,sortOffset ,displayOffset) into tmpList1
                               finally (return (values `#(,@tmpList1) indentation1))))
    (sort tmpVector #'(lambda (symPair1 symPair2)
                       (string-lessp (aref symPair1 1) (aref symPair2 1))))
    (values tmpVector ; each element is a vector of `#(,sym sortable-string-for-sym)
            indentation)))


#|
(defun %apropos-substring-p (a b &aux (alen (length a))
                                     (xlen (%i- (length b) alen)))
  (if (%iminusp xlen) nil
    (if (eq alen 0) alen
      (let ((a0 (schar a 0)) (i 0) j)
        (tagbody loop
          (when (eq (schar b i) a0)
            (setq j 1)
            (tagbody subloop
              (when (eq j alen) (return-from %apropos-substring-p i))
              (when (eq (schar b (%i+ i j)) (schar a j))
                 (setq j (%i+ j 1))
                 (go subloop))))
          (unless (eq i xlen)
            (setq i (%i+ i 1))
            (go loop)))
        nil))))
|#