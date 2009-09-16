;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  5 10/26/95 Alice Hartley maybe no change
;;  (do not edit before this line!!)


;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; Modification History
;

; %start-with-package-iterator calls pkg-arg which now signals package-error vs error
; find-package - allow character as package-name - pkg-arg new-package-nickname new-package-name shadow-1 and rename-package ditto - dietz tests
; ------ 5.2b6
; akh %get-pkg-iter-inherited no longer crashes - I don't understand this package-iterator stuff!!!!
; ----- 5.0b3
;01/19/99 akh   define-package takes documentation arg
;02/03/97 bill  Duncan Smith's fix to nickname case sensitivity in %define-package.
;               Duncan Smith's fix to shadowed symbols in %use-package-conflict-check.
;-------------  4.0
;04/30/96 bill  Gary's fix for %find-package-symbol
;-------------  MCL-PPC 3.9
;11/16/95 slh   shadow: package -> (or package *package*)
;10/26/95 slh   %gvector -> %pkg
;10/20/95 slh   de-lapified: %%derefstring is now obsolete
;08/09/93 bill  %use-package-conflict-check now remembers to merge NIL & nilsym everywhere
;-------------- 3.0d12
;05/26/93 alice find-package handles fat strings (i hope), %%findpkg is history
;05/23/93 alice %%defrefstring error is 'base-string not 'string
;11/20/92  gb  extra arg to vsubtypep
;07/02/92 bill remove (dbg) from import-1
;------------- 2.0
;02/23/92  gb  Missing ~S in EXPORT's "missing symbols need to be imported first" CERROR format string.
;02/21/92  (gb from bootpatch0) Blessings upon UNEXPORT-1.
;-------- 2.0f2
;01/06/92  gb  allow symbols as package names again ...
;12/24/91  gb  Restarts for package-name conflicts.
;--------- 2.0b4
;10/27/91  gb  Check & signal conflicts in export; no more export-1, fasl-extern baggage.
;--------- 2.0b3
;07/21/91  gb  Fix some of the conflict checking, add some more.  Wtaerr fixes.  Declaim.
;02/01/91 bill with-package-iterator support
;              Fix the WHILE# loop in UNINTERN (crashed on uninterning a shadowing symbol)
;12/10/90  gb  %define-package doesn't :use anything on creation.
;              RENAME-PACKAGE might really work this time.
;12/05/90  gb  make rename-package actually do something.
;11/10/90  gb  use new package functions.
;10/16/90  gb  new-lap here and there.
;09/03/90  gb  define %%deref-sym-char-or-string, which conses.  Too bad.
;08/10/90  gb  new package cell accessors.  Bill's fix to RENAME-PACKAGE.
;07/24/90 bill fix find-all-symbols.
;06/20/90  gb  SHADOW allows strings as well as symbols.  DEFPACKAGE shadows in
;              package being defined.
; ----- 2.0a1
;06/10/90  gb  define & export *MAKE-PACKAGE-USE-DEFAULTS*, use it in MAKE-PACKAGE
;              and %DEFINE-PACKAGE.
;06/06/90  gb  pkg-arg-allow-deleted restartable error.
;05/22/90  gb  no more symtagp.
;05/14/90  gb  deprecate IN-PACKAGE with extreme prejudice.  Add set-package, %define-
;              package. Move %%derefstring & %%deref-sym-or-string here.
;04/30/90  gb  default make-package :USE arg to COMMON-LISP.
;12/29/89  gz  find-package allows package arg, per x3j13/PACKAGE-FUNCTION-CONSISTENCY.
;	       Added %pkgtab-count, %resize-package.
;12-Nov-89 Mly Make %%find-pkg-sym and callers conform to its documentation (caller should do getvect).
;             This fixes bugs in UNINTERN.  Why is this all in lap?
;10/16/89 gz  $sp-findsym no longer returns keywords.  $sp-exportcheck preserves
;	      da/db/dy. Braino in delete-package.
;10/3/89  gb  mis-parenthesization in use-package .
;9/27/89  gb  typo in delete-packge.
;9/3/89   gz  Package accessors here from l1-aprims.
;             DELETE-PACKAGE per x3j13.
;08/29/89 gb  (loop# ...) -> (prog# ...) in use-package .  Import takes pname
;             of symbol before calling $sp-findsym.
;08/01/89 gz  atemp0 -> atemp1 in unexport.
;04/07/89 gb  $sp8 -> $sp.
; 03/24/89  gz  error numbers are fixnums. $packagesP -> %all-packages%.
;               More stuff from kernel. $v_pkg.
; 03/03/89  gb  New file.

(declaim (special %all-packages%))
(declaim (list %all-package%))
(declaim (type package *package*))

(defun dereference-base-string (s)
  (multiple-value-bind (vector offset) (array-data-and-offset s)
    (unless (typep vector 'simple-base-string) (report-bad-arg s 'base-string))
    (values vector offset (the fixnum (+ (the fixnum offset) (the fixnum (length s)))))))

(defun dereference-base-string-or-symbol (s)
  (if (symbolp s)
    (dereference-base-string (symbol-name s))
    (dereference-base-string s)))

(defun dereference-base-string-or-symbol-or-char (s)
  (if (typep s 'character)
    (values (make-string 1 :element-type 'base-character :initial-element s) 0 1)
    (dereference-base-string-or-symbol s)))

#| obsolete
;Entry: acc=argument, error if not string (simple or otherwise) but today m.b.base.
;Exit:  Atemp0=simple string, Dtemp0=offset (unboxed), Dtemp1=length (unboxed)
(defun %%derefstring (&lap 0)
  (old-lap-inline ()
   (move.l arg_z atemp0)
   (if# (eq (ttagp ($ $t_vector) arg_z da))
     (move.l '0 dtemp0)
     (vsubtype atemp0 da)
     (if# (eq (cmp.b ($ $v_sstr) da))
       (vsize atemp0 dtemp1)
       (bra @done))
     (if# (and (eq (cmp.b ($ $v_arrayh) da))
               (eq (cmp.b ($ $v_sstr) (svref atemp0 arh.fixnum $arh_type)))
               (eq (cmp.w ($ $arh_one_dim) (svref atemp0 arh.fixnum $arh_rank4))))
       (move.l (svref atemp0 arh.fill) dtemp1)
       (getint dtemp1)
       (move.l atemp0 da)
       (prog#
        (add.l (svref atemp0 arh.offs) dtemp0)
        (btst ($ $arh_disp_bit) (svref atemp0 arh.fixnum $arh_bits))
        (move.l (svref atemp0 arh.vect) atemp0)
        (bne (top#)))
       (getint dtemp0)
       (vsize atemp0 da)
       (sub.l dtemp0 da)
       (if# (ge da dtemp1)
         (move.l da dtemp1))
       (bra @done)))
   (twtaerr atemp0 'base-string)
@done))
|#

(defun %string= (string1 string2 start1 end1)
  (declare (optimize (speed 3) (safety 0))
           (fixnum start1 end1))
  (when (eq (length string2) (%i- end1 start1))
    (do* ((i start1 (1+ i))
          (j 0 (1+ j)))
         ((>= i end1))
      (declare (fixnum i j))
      (when (not (eq (%scharcode string1 i)(%scharcode string2 j)))
        (return-from %string= nil)))
    t))

(defun symbol-or-string-arg (thing)
  (if (symbolp thing) 
    (symbol-name thing)
    (if (stringp thing)
      thing
      (report-bad-arg thing '(or string symbol)))))

(defun find-package (name)
  (if (packagep name) 
    name
    (%find-pkg (string name))))

(defun set-package (name &aux (pkg (find-package name)))
  (if pkg
    (setq *package* pkg)
    (set-package (%kernel-restart $xnopkg name))))

(defun export (sym-or-syms &optional (package *package*))
  (setq package (pkg-arg package))
  (if (atom sym-or-syms)
    (let* ((temp (cons sym-or-syms nil)))
      (declare (dynamic-extent temp))
      (export temp package))
    (progn
      (dolist (sym sym-or-syms)
        (unless (symbolp sym) (return (setq sym-or-syms  (mapcar #'(lambda (s) (require-type s 'symbol)) sym-or-syms)))))
      ; First, see if any packages used by the package being "exported from" already contain a
      ; distinct non-shadowing symbol that conflicts with one of those that we're trying to export.
      (let* ((conflicts (check-export-conflicts sym-or-syms package)))
        (if conflicts
          (progn 
            (resolve-export-conflicts conflicts package)
            (export sym-or-syms package))
          (let* ((missing nil) (need-import nil))
            (dolist (s sym-or-syms) 
              (multiple-value-bind (foundsym foundp) (%findsym (symbol-name s) package)
                (if (not (and foundp (eq s foundsym)))
                  (push s missing)
                  (if (eq foundp :inherited)
                    (push s need-import)))))
            (when missing
              (cerror "Import missing symbols before exporting them from ~S."
                      'export-requires-import
                      :package  package
                      :to-be-imported missing)
              (import missing package))
            (if need-import (import need-import package))
            ; Can't lose now: symbols are all directly present in package.
            ; Ensure that they're all external; do so with interrupts disabled
            (without-interrupts
             (let* ((etab (pkg.etab package))
                    (ivec (car (pkg.itab package))))
               (dolist (s sym-or-syms t)
                 (multiple-value-bind (foundsym foundp internal-offset)
                                      (%findsym (symbol-name s) package)
                   (when (eq foundp :internal)
                     (setf (%svref ivec internal-offset) (%unbound-marker-8))
                     (let* ((pname (symbol-name foundsym)))
                       (%htab-add-symbol foundsym etab (nth-value 2 (%get-htab-symbol pname (length pname) etab)))))))))))))))

(defun check-export-conflicts (symbols package)
  (let* ((conflicts nil))
    (dolist (user (pkg.used-by package) conflicts)
      (dolist (s symbols)
        (multiple-value-bind (foundsym foundp) (%findsym (symbol-name s) user)
          (if (and foundp (neq foundsym s) (not (memq foundsym (pkg.shadowed user))))
            (push (list (eq foundp :inherited) s user foundsym) conflicts)))))))
  


(defun keywordp (x)
  (and (symbolp x) (eq (symbol-package x) *keyword-package*)))

;No type/range checking.  For DO-SYMBOLS and friends.
(defun %htab-symbol (array index)
  (let* ((sym (%svref array index)))
    (if (and sym (neq sym (%unbound-marker-8)))
      (values (%symptr->symbol sym) t)
      (values nil nil))))

(defun find-all-symbols (name)
  (let* ((syms ())
         (pname (symbol-or-string-arg name))
         (len (length pname)))
    (dolist (p %all-packages% syms)
      (multiple-value-bind (sym foundp) (%find-package-symbol pname p len)
        (if foundp (pushnew sym syms :test #'eq))))))
      

(defun list-all-packages () (copy-list %all-packages%))

(defun rename-package (package new-name &optional new-nicknames)
  (setq package (pkg-arg package)
        new-name (ensure-simple-string (string new-name)))
  (let* ((names (pkg.names package)))
    (declare (type cons names))
    (rplaca names (new-package-name new-name package))
    (rplacd names nil))
  (%add-nicknames new-nicknames package))

; Someday, this should become LISP:IN-PACKAGE.
(defun old-in-package (name &key 
                        nicknames 
                        (use nil use-p) 
                        (internal-size 60)
                        (external-size 10))
  (let ((pkg (find-package (setq name (symbol-or-string-arg name)))))
    (if pkg
      (progn
        (use-package use pkg)
        (%add-nicknames nicknames pkg))
      (setq pkg
            (make-package name 
                          :nicknames nicknames
                          :use (if use-p use *make-package-use-defaults*)
                          :internal-size internal-size
                          :external-size external-size)))
    (setq *package* pkg)))


(defvar *make-package-use-defaults* '("COMMON-LISP" "CCL"))

; On principle, this should get exported here.  Unfortunately, we
; can't execute calls to export quite yet.
;(export '*make-package-use-defaults* )


(defun make-package (name &key
                          nicknames
                          (use *make-package-use-defaults*)
                          (internal-size 60)
                          (external-size 10))
  (setq internal-size (require-type internal-size 'fixnum)
        external-size (require-type external-size 'fixnum))
  (let ((pkg (gvector :package 
                      (%new-package-hashtable internal-size)
                      (%new-package-hashtable external-size)
                      nil
                      nil
                      (list (new-package-name name))
                      nil)))
      (use-package use pkg)
      (%add-nicknames nicknames pkg)
      (push pkg %all-packages%)
      pkg))

(defun new-package-name (name &optional package)
  (do* ((prompt "Enter package name to use instead of ~S ."))
       ((let* ((found (find-package (setq name (ensure-simple-string (string name))))))
          (or (not found)
              (eq package found)))
        name)
    (restart-case (%error "Package name ~S is already in use." (list name) (%get-frame-ptr))
      (new-name (new-name)
                :report (lambda (s) (format s prompt name))
                :interactive 
                (lambda () 
                  (list (block nil (catch-cancel (return (get-string-from-user
                                                          (format nil prompt name))))
                               nil)))
                (if new-name (setq name new-name))))))
       
(defun new-package-nickname (name package)
  (setq name (ensure-simple-string (string name)))
  (let* ((other (find-package name))
         (prompt "Enter package name to use instead of ~S ."))
    (if other
      (unless (eq other package)
        (let* ((conflict-with-proper-name (string= (package-name other) name))
               (condition (make-condition 'package-name-conflict-error
                                          :package package
                                          :format-arguments (list name other)
                                          :format-string (%str-cat "~S is already "
                                                                   (if conflict-with-proper-name
                                                                     "the "
                                                                     "a nick")
                                                                   "name of ~S."))))
          (restart-case (%error condition nil (%get-frame-ptr))
            (continue ()
                      :report (lambda (s) (format s "Don't make ~S a nickname for ~S" name package)))
            (new-name (new-name)
                      :report (lambda (s) (format s prompt name))
                      :interactive 
                      (lambda () 
                        (list (block nil (catch-cancel (return (get-string-from-user
                                                                (format nil prompt name))))
                                     nil)))
                      (if new-name (new-package-nickname new-name package)))
            (remove-conflicting-nickname ()
                                         :report (lambda (s)
                                                   (format s "Remove conflicting-nickname ~S from ~S." name other))
                                         :test (lambda (&rest ignore) (declare (ignore ignore)) (not conflict-with-proper-name))
                                         (rplacd (pkg.names other)
                                                 (delete name (cdr (pkg.names other)) :test #'string=))
                                         name))))
      name)))

(defun %add-nicknames (nicknames package)
  (let ((names (pkg.names package)))
    (dolist (name nicknames package)
      (let* ((ok-name (new-package-nickname name package)))
        (if ok-name (push ok-name (cdr names)))))))

;; redef of level-0;nfasload - boot problem re: string
(defun pkg-arg (thing &optional deleted-ok)
  (let* ((xthing (cond ((symbolp thing)(symbol-name thing))
                       ((typep thing 'character)
                        (string thing))
                       ((typep thing 'string)
                        (ensure-simple-string thing))
                       (t thing))))
    (let* ((typecode (ppc-typecode xthing)))
        (declare (fixnum typecode))
        (cond ((= typecode ppc::subtag-package)
               (if (or deleted-ok (pkg.names xthing))
                 xthing
                 (error "~S is a deleted package ." thing)))
              ((or (= typecode ppc::subtag-simple-base-string)
                   (= typecode ppc::subtag-simple-general-string))
               (or (%find-pkg xthing)
                   (error 'no-such-package :package xthing) 
                   ;(%kernel-restart $xnopkg xthing)
                   ))
              (t (report-bad-arg thing 'simple-string))))))

(defun find-symbol (string &optional package)
  (multiple-value-bind (sym flag)
                       (%findsym (ensure-simple-string string) (pkg-arg (or package *package*)))
    (values sym flag)))

; Somewhat saner interface to %find-symbol
(defun %findsym (string package)
  (%find-symbol string (length string) package))

(defun intern (str &optional (package *package*))
  (setq package (pkg-arg package))
  (setq str (ensure-simple-string str))
  (without-interrupts
   (multiple-value-bind (symbol where internal-offset external-offset) 
                        (%find-symbol str (length str) package)
     (if where
       (values symbol where)
       (values (%add-symbol str package internal-offset external-offset) nil)))))

(defun unintern (symbol &optional (package *package*))
  (setq package (pkg-arg package))
  (setq symbol (require-type symbol 'symbol))
  (multiple-value-bind (foundsym table index) (%find-package-symbol (symbol-name symbol) package)
    (when (and table (eq symbol foundsym))
      (when (memq symbol (pkg.shadowed package))
        ; A conflict is possible if more than one similarly-named external symbol 
        ; exists in the packages used by this one.
        ; Grovel around looking for such conflicts; if any are found, signal an
        ; error (via %kernel-restart) which offers to either shadowing-import one
        ; of the conflicting symbols into the current package or abandon the attempt
        ; to unintern in the first place.
        (let* ((first nil)
               (first-p nil)
               (name (symbol-name symbol))
               (len (length name))
               (others nil))
          (declare (dynamic-extent first))
          (without-interrupts
           (dolist (pkg (pkg.used package))
             (multiple-value-bind (found conflicting-sym) (%get-htab-symbol name len (pkg.etab pkg))
               (when found
                 (if first-p
                    (unless (or (eq conflicting-sym first)
                                  (memq conflicting-sym others))
                        (push conflicting-sym others))
                   (setq first-p t first conflicting-sym))))))
          (when others
            ; If this returns, it will have somehow fixed things.
            (return-from unintern (%kernel-restart $xunintc symbol package (cons first others)))))
        ; No conflicts found, but symbol was on shadowing-symbols list.  Remove it atomically.
        (do* ((head (cons nil (pkg.shadowed package)))
              (prev head next)
              (next (cdr prev) (cdr next)))
             ((null next))              ; Should never happen
          (declare (dynamic-extent head) 
                   (list head prev next)
                   (optimize (speed 3) (safety 0)))
          (when (eq (car next) symbol)
            (setf (cdr prev) (cdr next)
                  (pkg.shadowed package) (cdr head))
            (return))))
      ; Now remove the symbol from package; if package was its home package, set its package to NIL.
      ; If we get here, the "table" and "index" values returned above are still valid.
      (%svset (car table) index (%unbound-marker-8))
      (when (eq (symbol-package symbol) package)
        (%set-symbol-package symbol nil))
      t)))

(defun import-1 (package sym)
  (multiple-value-bind (conflicting-sym type internal-offset external-offset) (%findsym (symbol-name sym) package)
    (if (and type (neq conflicting-sym sym))
      (let* ((external-p (eq type :inherited))
             (condition (make-condition 'import-conflict-error 
                                        :package package
                                        :imported-sym sym
                                        :conflicting-sym conflicting-sym
                                        :conflict-external external-p)))
        (restart-case (error condition)
          (continue ()
                    :report (lambda (s) (format s "Ignore attempt to import ~S to ~S." sym package)))
          (resolve-conflict ()
                            :report (lambda (s)
                                      (let* ((package-name (package-name package)))
                                        (if external-p 
                                          (format s "~A ~s in package ~s ." 'shadowing-import sym package-name)
                                          (format s "~A ~s from package ~s ." 'unintern conflicting-sym package-name))))
                            (if external-p 
                              (shadowing-import-1 package sym)
                              (progn
                                (unintern conflicting-sym package)
                                (import-1 package sym))))))
      (unless (or (eq type :external) (eq type :internal))
        (%insert-symbol sym package internal-offset external-offset)))))


(defun import (sym-or-syms &optional package)
  (setq package (pkg-arg (or package *package*)))
  (if (listp sym-or-syms)
    (dolist (sym sym-or-syms)
      (import-1 package sym))
    (import-1 package sym-or-syms))
  t)

(defun shadow-1 (package sym)
  (let* ((pname (ensure-simple-string (string sym)))
         (len (length pname)))
    (without-interrupts
     (multiple-value-bind (symbol where internal-idx external-idx) (%find-symbol pname len package)
       (if (or (eq where :internal) (eq where :external))
         (pushnew symbol (pkg.shadowed package))
         (push (%add-symbol pname package internal-idx external-idx) (pkg.shadowed package)))))
    nil))

(defun shadow (sym-or-symbols-or-string-or-strings &optional package)
  (setq package (pkg-arg (or package *package*)))
  (if (listp sym-or-symbols-or-string-or-strings)
    (dolist (s sym-or-symbols-or-string-or-strings)
      (shadow-1 package s))
    (shadow-1 package sym-or-symbols-or-string-or-strings))
  t)

(defun unexport (sym-or-symbols &optional package)
  (setq package (pkg-arg (or package *package*)))
  (if (listp sym-or-symbols)
    (dolist (sym sym-or-symbols)
      (unexport-1 package sym))
    (unexport-1 package sym-or-symbols))
  t)

(defun unexport-1 (package sym)
  (when (eq package *keyword-package*)
    (error "Can't unexport ~S from ~S ." sym package))
  (multiple-value-bind (foundsym foundp internal-offset external-offset)
                       (%findsym (symbol-name sym) package)
    (unless foundp
      (error 'symbol-name-not-accessible
             :symbol-name (symbol-name sym)
             :package package))
    (when (eq foundp :external)
      (let* ((evec (car (pkg.etab package)))
             (itab (pkg.itab package))
             (ivec (car itab))
             (icount&limit (cdr itab)))
        (declare (type cons etab itab icount&limit))
        (setf (svref evec external-offset) (%unbound-marker-8))
        (setf (svref ivec internal-offset) (%symbol->symptr foundsym))
        (if (eql (setf (car icount&limit)
                       (the fixnum (1+ (the fixnum (car icount&limit)))))
                 (the fixnum (cdr icount&limit)))
          (%resize-htab itab)))))
  nil)

; Both args must be packages.
(defun %use-package-conflict-check (using-package package-to-use)
  (let ((already-used (pkg.used using-package)))
    (unless (or (eq using-package package-to-use)
                (memq package-to-use already-used))
      ; There are two types of conflict that can potentially occur:
      ;   1) An external symbol in the package being used conflicts
      ;        with a symbol present in the using package
      ;   2) An external symbol in the package being used conflicts
      ;        with an external symbol in some other package that's already used.
      (let* ((ext-ext-conflicts nil)
             (used-using-conflicts nil)
             (shadowed-in-using (pkg.shadowed using-package))
             (to-use-etab (pkg.etab package-to-use)))
        (without-interrupts
         (dolist (already already-used)
           (let ((user (if (memq package-to-use (pkg.used-by already))
                         package-to-use
                         (if (memq package-to-use (pkg.used already))
                           already))))
             (if user
               (let* ((used (if (eq user package-to-use) already package-to-use))
                      (user-etab (pkg.etab user))
                      (used-etab (pkg.etab used)))
                 (dolist (shadow (pkg.shadowed user))
                   (let ((sname (symbol-name shadow)))
                     (unless (member sname shadowed-in-using :test #'string=)
                       (let ((len (length sname)))
                         (when (%get-htab-symbol sname len user-etab)   ; external in user
                           (multiple-value-bind (external-in-used used-sym) (%get-htab-symbol sname len used-etab)
                             (when (and external-in-used (neq used-sym shadow))
                               (push (list shadow used-sym) ext-ext-conflicts)))))))))   ; Remember what we're doing here ?
               ; Neither of the two packages use the other.  Iterate over the external
               ; symbols in the package that has the fewest external symbols and note
               ; conflicts with external symbols in the other package.
               (let* ((smaller (if (%i< (%cadr to-use-etab) (%cadr (pkg.etab already)))
                                 package-to-use
                                 already))
                      (larger (if (eq smaller package-to-use) already package-to-use))
                      (larger-etab (pkg.etab larger))
                      (smaller-v (%car (pkg.etab smaller))))
                 (dotimes (i (uvsize smaller-v))
                   (declare (fixnum i))
                   (let ((symptr (%svref smaller-v i)))
                     (when (and symptr
                                (neq symptr (%unbound-marker-8)))
                       (let* ((sym (%symptr->symbol symptr))
                              (symname (symbol-name sym)))
                         (unless (member symname shadowed-in-using :test #'string=)
                           (multiple-value-bind (found-in-larger sym-in-larger)
                                                (%get-htab-symbol symname (length symname) larger-etab)
                             (when (and found-in-larger (neq sym-in-larger sym))
                               (push (list sym sym-in-larger) ext-ext-conflicts))))))))))))
         ; Now see if any non-shadowed, directly present symbols in the using package conflicts with
         ; an external symbol in the package being used.  There are two ways of doing this; one of
         ; them -may- be much faster than the other.
         (let* ((to-use-etab-size (%cadr to-use-etab))
                (present-symbols-size (%i+ (%cadr (pkg.itab using-package)) (%cadr (pkg.etab using-package)))))
           (unless (eql 0 present-symbols-size)
             (if (%i< present-symbols-size to-use-etab-size)
               ; Faster to look up each present symbol in to-use-etab.
               (let ((htabvs (list (%car (pkg.etab using-package)) (%car (pkg.itab using-package)))))
                 (declare (dynamic-extent htabvs))
                 (dolist (v htabvs)
                   (dotimes (i (the fixnum (uvsize v)))
                     (declare (fixnum i))
                     (let ((symptr (%svref v i)))
                       (when (and symptr (neq symptr (%unbound-marker-8)))
                         (let* ((sym (%symptr->symbol symptr)))
                           (unless (memq sym shadowed-in-using)
                             (let* ((name (symbol-name symptr)))
                               (multiple-value-bind (found-p to-use-sym) (%get-htab-symbol name (length name) to-use-etab)
                                 (when (and found-p (neq to-use-sym sym))
                                   (push (list sym to-use-sym) used-using-conflicts)))))))))))
               ; See if any external symbol present in the package being used conflicts with
               ;  any symbol present in the using package.
               (let ((v (%car to-use-etab)))
                 (dotimes (i (uvsize v))
                   (declare (fixnum i))
                   (let ((symptr (%svref v i)))
                     (when (and symptr (neq symptr (%unbound-marker-8)))
                       (let* ((sym (%symptr->symbol symptr)))
                         (multiple-value-bind (using-sym found-p) (%find-package-symbol (symbol-name sym) using-package)
                           (when (and found-p
                                      (neq sym using-sym)
                                      (not (memq using-sym shadowed-in-using)))
                             (push (list using-sym sym) used-using-conflicts))))))))))))
        (values ext-ext-conflicts used-using-conflicts)))))

(defun use-package-1 (using-package package-to-use)
  (if (eq (setq package-to-use (pkg-arg package-to-use))
          *keyword-package*)
    (error "~S can't use ~S." using-package package-to-use))
  (do* ((used-external-conflicts nil)
        (used-using-conflicts nil))
       ((and (null (multiple-value-setq (used-external-conflicts used-using-conflicts)
                     (%use-package-conflict-check using-package package-to-use)))
             (null used-using-conflicts)))
    (if used-external-conflicts
      (%kernel-restart $xusecX package-to-use using-package used-external-conflicts)
      (if used-using-conflicts
        (%kernel-restart $xusec package-to-use using-package used-using-conflicts))))
  (unless (memq using-package (pkg.used-by package-to-use))   ;  Not already used in break loop/restart, etc.
    (push using-package (pkg.used-by package-to-use))
    (push package-to-use (pkg.used using-package))))

(defun use-package (packages-to-use &optional package)
  (setq package (pkg-arg (or package *package*)))
  (if (listp packages-to-use)
    (dolist (to-use packages-to-use)
      (use-package-1 package to-use))
    (use-package-1 package packages-to-use))
  t)

(defun shadowing-import-1 (package sym)
  (let* ((pname (symbol-name sym))
         (len (length pname))
         (need-add t))
    (without-interrupts
     (multiple-value-bind (othersym htab offset) (%find-package-symbol pname package)
       (if htab
         (if (eq othersym sym)
           (setq need-add nil)
           (progn                       ; Delete conflicting symbol
             (if (eq (symbol-package othersym) package)
               (%set-symbol-package othersym nil))
             (setf (%svref (car htab) offset) (%unbound-marker-8))
             (setf (pkg.shadowed package) (delete othersym (pkg.shadowed package) :test #'eq)))))
       (if need-add                   ; No symbols with same pname; intern & shadow
         (multiple-value-bind (xsym foundp internal-offset external-offset) 
                              (%find-symbol pname len package)
           (declare (ignore xsym foundp))
           (%insert-symbol sym package internal-offset external-offset)))
       (pushnew sym (pkg.shadowed package))
       nil))))

(defun shadowing-import (sym-or-syms &optional (package *package*))
  (setq package (pkg-arg package))
  (if (listp sym-or-syms)
    (dolist (sym sym-or-syms)
      (shadowing-import-1 package sym))
    (shadowing-import-1 package sym-or-syms))
  t)

(defun unuse-package (packages-to-unuse &optional package)
  (let ((p (pkg-arg (or package *package*))))
    (flet ((unuse-one-package (unuse)
            (setq unuse (pkg-arg unuse))
            (setf (pkg.used p) (nremove unuse (pkg.used p))
                  (pkg.used-by unuse) (nremove p (pkg.used-by unuse)))))
      (declare (dynamic-extent #'unuse-one-package))
      (if (listp packages-to-unuse)
        (dolist (u packages-to-unuse) (unuse-one-package u))
        (unuse-one-package packages-to-unuse))
      t)))

(defun delete-package (package)
  (unless (packagep package)
    (setq package (or (find-package package)
                      (progn
                        (cerror "Do nothing" 'no-such-package  :package package)
                        (return-from delete-package nil)))))
  (unless (memq package %all-packages%)
    (return-from delete-package nil))
  (when (pkg.used-by package)
    (cerror "unuse ~S" 'package-is-used-by :package package
            :using-packages (pkg.used-by package)))
  (while (pkg.used-by package)
    (unuse-package package (car (pkg.used-by package))))
  (while (pkg.used package)
    (unuse-package (car (pkg.used package)) package))
  (setf (pkg.shadowed package) nil)
  (setq %all-packages% (nremove package %all-packages%))
  (setf (pkg.names package) nil)
  (let* ((ivec (car (pkg.itab package)))
         (evec (car (pkg.etab package)))
         (deleted (%unbound-marker-8)))
    (dotimes (i (the fixnum (length ivec)))
      (let* ((sym (%svref ivec i)))
        (setf (%svref ivec i) deleted)          ; in case it's in STATIC space
        (when (and sym (not (eq sym deleted)))
          (if (eq (symbol-package sym) package)
            (%set-symbol-package sym nil)))))
    (dotimes (i (the fixnum (length evec)))
      (let* ((sym (%svref evec i)))
        (setf (%svref evec i) deleted)          ; in case it's in STATIC space
        (when (and sym (not (eq sym deleted)))
          (if (eq (symbol-package sym) package)
            (%set-symbol-package sym nil))))))
  (let ((itab (pkg.itab package)) (etab (pkg.etab package)) (v '#(nil nil nil)))
    (%rplaca itab v) (%rplaca etab v)
    (%rplaca (%cdr itab) 0) (%rplaca (%cdr etab) 0)
    (%rplacd (%cdr itab) #x4000) (%rplacd (%cdr etab) #x4000))
  t)

(defun %find-package-symbol (string package &optional (len (length string)))
  (let* ((etab (pkg.etab package))
         (itab (pkg.itab package)))
    (multiple-value-bind (foundp sym offset) (%get-htab-symbol string len itab)
      (if foundp
        (values sym itab offset)
        (progn
          (multiple-value-setq (foundp sym offset)
          (%get-htab-symbol string len etab))
          (if foundp
            (values sym etab offset)
            (values nil nil nil)))))))

;For the inspector, number of symbols in pkg.
(defun %pkgtab-count (pkgtab &aux (n 0))
  (dovector (x (pkgtab-table pkgtab))
    (when (and x (neq x (%unbound-marker-8)))
      (setq n (%i+ n 1))))
  n)

(defun %resize-package (pkg)
  #-bccl (unless (packagep pkg) (report-bad-arg pkg 'package))
  (%resize-htab (pkg.itab pkg))
  (%resize-htab (pkg.etab pkg))
  pkg)

;These allow deleted packages, so can't use pkg-arg which doesn't.
;Of course, the wonderful world of optional arguments comes in handy.
(defun pkg-arg-allow-deleted (pkg)
  (pkg-arg pkg t))


(defun package-name (pkg) (%car (pkg.names (pkg-arg-allow-deleted pkg))))
;;>> Shouldn't these copy-list their result so that the user
;;>>  can't cause a crash through evil rplacding?
;Of course that would make rplacding less evil, and then how would they ever learn?
(defun package-nicknames (pkg) (%cdr (pkg.names (pkg-arg-allow-deleted pkg))))
(defun package-use-list (pkg) (pkg.used (pkg-arg-allow-deleted pkg)))
(defun package-used-by-list (pkg) (pkg.used-by (pkg-arg-allow-deleted pkg)))
(defun package-shadowing-symbols (pkg) (pkg.shadowed (pkg-arg-allow-deleted pkg)))

; This assumes that all symbol-names and package-names are strings.
(defun %define-package (name size 
                             external-size ; extension (may be nil.)
                             nicknames
                             shadow
                             shadowing-import-from-specs
                             use
                             import-from-specs
                             intern
                             export
                             &optional documentation)
  (if (eq use :default) (setq use *make-package-use-defaults*))
  (let* ((pkg (find-package name)))
    (if pkg
      ; Restarts could offer several ways of fixing this.
      (unless (string= (package-name pkg) name)
        (cerror "Redefine ~*~S"
                "~S is already a nickname for ~S" name pkg))
      (setq pkg (make-package name
                              :use nil
                              :internal-size (or size 60)
                              :external-size (or external-size
                                                 (max (length export) 1)))))
    (if (and documentation *save-doc-strings*) (setf (documentation pkg) documentation))
    (unuse-package (package-use-list pkg) pkg)
    (rename-package pkg name nicknames)
    (flet ((operation-on-all-specs (function speclist)
             (let ((to-do nil))
               (dolist (spec speclist)
                 (let ((from (pop spec)))
                   (dolist (str spec)
                     (multiple-value-bind (sym win) (find-symbol str from)
                       (if win
                         (push sym to-do)
                         ; This should (maybe) be a PACKAGE-ERROR.
                         (cerror "Ignore attempt to ~s ~s from package ~s"
                                 "Cannot ~s ~s from package ~s" function str from))))))
               (when to-do (funcall function to-do pkg)))))
      
      (dolist (sym shadow) (shadow sym pkg))
      (operation-on-all-specs 'shadowing-import shadowing-import-from-specs)
      (use-package use pkg)
      (operation-on-all-specs 'import import-from-specs)
      (dolist (str intern) (intern str pkg))
      (when export
        (let* ((syms nil))
          (dolist (str export)
            (multiple-value-bind (sym found) (find-symbol str pkg)
              (unless found (setq sym (intern str pkg)))
              (push sym syms)))
          (export syms pkg)))
      pkg)))

; The guts of with-package-iterator
(defun %start-with-package-iterator (p)
  (let ((pkgs (pkg-iter.pkgs p)))
    (setq pkgs (if (listp pkgs)
                 (mapcar #'pkg-arg pkgs)
                 (list (pkg-arg pkgs))))
    (setf (pkg-iter.pkgs p) pkgs))
  (%pkg-iter-next-package p))

(defun %pkg-iter-next-package (p)
  (setf (pkg-iter.state p) #'%pkg-iter-next-package)
  (let ((pkgs (pkg-iter.pkgs p))
        (types (pkg-iter.types p))
        pkg)
    (declare (fixnum types))
    (when pkgs
      (if (listp pkgs)
        (setq pkg (pop pkgs))
        (setq pkg pkgs
              pkgs nil))
      (setf (pkg-iter.pkg p) (setq pkg (find-package pkg))
            (pkg-iter.pkgs p) pkgs)
      (cond ((logbitp $pkg-iter-external types) (%start-pkg-iter-externals p))
            ((logbitp $pkg-iter-internal types) (%start-pkg-iter-internals p))
            ((logbitp $pkg-iter-inherited types) (%start-pkg-iter-inherited p))))))

(defun %start-pkg-iter-externals (p)
  (let ((tbl (car (uvref (pkg-iter.pkg p) pkg.etab))))
    (setf (pkg-iter.state p) #'%get-pkg-iter-external
          (pkg-iter.tbl p) tbl
          (pkg-iter.index p) (length tbl)))
  (%get-pkg-iter-external p))

(defun %start-pkg-iter-internals (p)
  (let ((tbl (car (uvref (pkg-iter.pkg p) pkg.itab))))
    (setf (pkg-iter.state p) #'%get-pkg-iter-internal
          (pkg-iter.tbl p) tbl
          (pkg-iter.index p) (length tbl)))
  (%get-pkg-iter-internal p))

(defun %start-pkg-iter-inherited (p)
  (let* ((pkgs (uvref (pkg-iter.pkg p) pkg.used))
         (pkg (pop pkgs))
         tbl)
    (if pkg
      (setf (pkg-iter.state p) #'%get-pkg-iter-inherited
            (pkg-iter.used p) pkgs
            (pkg-iter.tbl p) (setq tbl (car (uvref pkg pkg.etab)))
            (pkg-iter.index p) (length tbl))
      (setf (pkg-iter.state p) nil)))
  (%get-pkg-iter-inherited p))

(defun %next-pkg-iter-symbol (tbl index)
  (declare (fixnum index))
  (let (sym found)
    (loop
      (when (<= index 0)
        (return nil))
      (multiple-value-setq (sym found) (%htab-symbol tbl (decf index)))
      (when found
        (return (values sym index))))))

(defun %get-pkg-iter-external (p)
  (multiple-value-bind (sym index) 
                       (%next-pkg-iter-symbol
                        (pkg-iter.tbl p) (pkg-iter.index p))
    (if index
      (progn
        (setf (pkg-iter.index p) index)
        (values t sym :external (pkg-iter.pkg p)))
      (let ((types (pkg-iter.types p)))
        (declare (fixnum types))
        (cond ((logbitp $pkg-iter-internal types) (%start-pkg-iter-internals p))
              ((logbitp $pkg-iter-inherited types) (%start-pkg-iter-inherited p))
              (t (%pkg-iter-next-package p)))))))

(defun %get-pkg-iter-internal (p)
  (multiple-value-bind (sym index) 
                       (%next-pkg-iter-symbol
                        (pkg-iter.tbl p) (pkg-iter.index p))
    (if index
      (progn
        (setf (pkg-iter.index p) index)
        (values t sym :internal (pkg-iter.pkg p)))
      (let ((types (pkg-iter.types p)))
        (declare (fixnum types))
        (cond ((logbitp $pkg-iter-inherited types) (%start-pkg-iter-inherited p))
              (t (%pkg-iter-next-package p)))))))

(defun %get-pkg-iter-inherited (p)
  (let (pkg)
    ;; I have no idea why this happens but at least we do not crash
    (when (or (not (pkg-iter.index p))
              (not (pkg-iter.tbl p)))
      (return-from %get-pkg-iter-inherited nil))
    (Multiple-value-bind (sym index) 
                         (%next-pkg-iter-symbol (pkg-iter.tbl p) (pkg-iter.index p))
      (if index
        (progn
          (setf (pkg-iter.index p) index
                pkg (pkg-iter.pkg p))
          ; Note: this will be slow if there are a lot of shadowed symbols.
          ; The alternative is find-symbol, which is much slower in the normal
          ; case of few shadowed symbols.
          (if (and (pkg.shadowed pkg)
                   (%name-present-in-package-p (symbol-name sym) pkg))
            (%get-pkg-iter-inherited p)
            (values t sym :inherited pkg)))
        (progn
          (let ((pkgs (pkg-iter.used p))
                tbl)
            (if pkgs
              (progn
                (setf pkg (pop pkgs)
                      (pkg-iter.used p) pkgs
                      (pkg-iter.tbl p) (setq tbl (car (uvref pkg pkg.etab)))
                      (pkg-iter.index p) (length tbl))
                (%get-pkg-iter-inherited p))
              (%pkg-iter-next-package p))))))))

; For do-symbols and with-package-iterator
; string must be a simple string
; package must be a package
; Wouldn't it be nice if this distinguished "not found" from "found NIL" ?
(defun %name-present-in-package-p (string package)
  (values (%find-package-symbol string package)))

; This is supposed to be (somewhat) like the lisp machine's MAKE-PACKAGE.
; Accept and ignore some keyword arguments, accept and process some others.

(defun lispm-make-package (name &key 
                                (use *make-package-use-defaults*)
                                nicknames
                                ;prefix-name
                                ;invisible
                                (shadow nil shadow-p)
                                (export nil export-p)
                                (shadowing-import nil shadowing-import-p)
                                (import nil import-p)
                                (import-from nil import-from-p)
                                ;relative-names
                                ;relative-names-for-me
                                ;size
                                ;hash-inherited-symbols
                                ;external-only
                                ;include
                                ;new-symbol-function
                                ;colon-mode
                                ;prefix-intern-function
                                &allow-other-keys)
  ;  (declare (ignore prefix-name invisible relative-names relative-names-for-me
  ;                   size hash-inherited-symbols external-only include
  ;                   new-symbol-function colon-mode prefix-intern-function))
  (let ((pkg (make-package name :use NIL :nicknames nicknames)))
    (when shadow-p (shadow shadow pkg))
    (when shadowing-import-p (shadowing-import shadowing-import pkg))
    (use-package use pkg)
    (when import-from-p
      (let ((from-pkg (pop import-from)))
        (dolist (name import-from)
          (multiple-value-bind (sym win) (find-symbol (symbol-or-string-arg name) from-pkg)
            (when win (import-1 pkg sym))))))
    (when import-p (import import pkg))
    (when export-p
      (let* ((syms nil))
        (dolist (name export)
          (multiple-value-bind (sym win) (find-symbol (string name) pkg)
            (unless win (setq sym (intern (string name) pkg)))
            (push sym syms)))
        (export syms pkg)))
    pkg))

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
