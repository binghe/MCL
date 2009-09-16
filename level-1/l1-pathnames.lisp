;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  2 6/2/97   akh  see below
;;  13 9/13/96 akh  dont remember
;;  12 9/4/96  akh  maybe no change
;;  11 7/30/96 akh  fix find-str-pattern - dont run off end of string
;;  10 7/26/96 akh  remove support for old logical directories to fix some problems re back-translate-pathname
;;                  fix %path-str*=
;;  9 12/22/95 gb   bin;**;*.pfsl" maps to "ccl:binppc;**;*.pfsl
;;  7 11/15/95 akh  add to logical-pathname-translations for "CCL" so level-1;*.pfsl goes to l1-pfsls;
;;  4 10/11/95 akh  aargh
;;  5 2/21/95  slh  removed naughty word (file is public now)
;;  4 2/17/95  slh  added interface-tools, sourceserver modules
;;  (do not edit before this line!!)


;; L1-pathnames.lisp
; Copyright 1991-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;
;; remove some .pfsl things from "ccl" translations
;; ------ 5.2b5
;; clean up some encoded-string stuff - hopefully not used now anyway
;; maybe-make-encoded-string doesn't
;; ---- 5.1 final
;; trying to lose path-str-mumble things - check for encoded-string in a few places
;; ---------- 5.0final
;; 01/17/01 akh add compiler to *module-search-path* (for users)
;; ------ 4.3f1c1
; 04/02/99 akh trying to deal with :up/:relative creeping "up" into the host physical directory
; 03/19/99 akh full-pathname really obey the no-error argument
; 12/19/97 akh translate-logical-pathname - don't return a logical-pathname whose host is NIL - make it physical
; 11/16/95 bill "ccl:l1f;**;*.pfsl" -> "ccl:l1pf;**;*.pfsl"
; 2/16/95 slh   added interface tools, sourceserver to *module-search-path*
;---------------- 3.0d17
; %pathname-match-directory - do better with (null wild) 
;-------------------
;06/12/93 alice %path-str*= deals with fat strings
;09/30/92 alice translate component - source :unspecific, to "*" => result :unspecific
;05/19/92 alice translate-directory-2 - don't be so cavalier with to = **
;---------------- 2.0
;01/10/92 alice logical-pathname deal with :unspecific
;12/16/91 gb    string -> fixnum in signal-file-error call.
;---------------- 2.0b4
;10/06/91 alice add "ccl;" to translations - for top level
;---------------- 2.0b3
;07/21/91 gb    type-error -> signal-type-error.
;07/19/91 alice simpler better translate-directory2, fix recent bug in translate-component
;07/12/91 alice logical-pathname - make it work if host doesn't exist yet
;07/09/91 alice translate-pathname gets :reversible keyword (sp?)
;07/08/91 alice %split-ccdirectory had a bogus call to SET, translate-component deal with :wild
;06/10/91 alice  deal with :wild in directory lists (gaak)
;------------- 2.0b2
;05/20/91 gb    FILE-ERROR -> SIGNAL-FILE-ERROR.
;02/28/91 alice full-pathname - make no-error work if undefined logical host
;02/15/91 alice translations for e.g. lib;foo.fasl => bin;foo.fasl (add in boot too if we like it)
;02/13/91 alice added add-logical-pathname-translation 
;02/12/91 alice move tranlate-logical-pathname to end - add translations for ccl:
;02/07/91 alice - bunch of stuff moved from lib;pathnames

;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;ANSI CL logical pathnames

(in-package :ccl)


;These are used by make-pathname - not true
(defun %verify-logical-component (name type)
  (when (and name (neq name :unspecific))
    (when (encoded-stringp name)
      (let ((enc (the-encoding name)))
        (if (neq enc #$kcfstringencodingunicode)
          (setq name (convert-string (the-string name) enc #$kcfstringencodingunicode))
          (setq name (the-string name)))))
    (setq name (ensure-simple-string name))
    (when (or (eql 0 (length name))
              (%str-member *pathname-escape-character* name)
              (%path-mem ":;" name))
      (error "Illegal logical pathname ~A component ~S" type name)))
  name)


(defun verify-logical-host-name (host)
  (or (and host (%verify-logical-component host "host")
       (%str-assoc host %logical-host-translations%)
       host)
      (host-error host)))

(defun %logical-version-component (version)
  (if (or (eq 0 version)
          (stringp version)
          (memq version '(nil :wild :newest :unspecific)))
    version
    (require-type version '(or (integer 0 0) string (member nil :wild :newest :unspecific)))))

(defun logical-pathname-translations (host)
  (setq host (verify-logical-host-name host))
  (let ((translations (%str-assoc host %logical-host-translations%)))
    (unless translations (host-error host))
    (%cdr translations)))

(defun logical-host-p (host)
  (%str-assoc host %logical-host-translations%))

(defun host-error (host) ; supposed to be a type-error
  (signal-type-error host  '(satisfies logical-host-p) "~S is not a defined logical host"))

(defun set-logical-pathname-translations (host list)
  (setq host (%verify-logical-component  host "host"))
  (let ((old (%str-assoc host %logical-host-translations%))
        new)
    (let ((%logical-host-translations% %logical-host-translations%))
      (cond ((null old) ; waste a cons to save some code - so we wont error cause of as yet undefined host
             (push (list host) %logical-host-translations%))
            ; not too cool if error in parse-namestring
            (t (rplacd old nil)))
      (setq new (mapcar #'(lambda (trans)
                            (debind (from to &rest ignored) trans
                              (declare (ignore ignored))
                              (list (parse-namestring from host) (pathname to))))
                        list)))
    (dolist (e new)  ; ???
        (when (eq  (pathname-host (car e)) :unspecific)
          (error "~s is a physical pathname" (car e))))
    (if old
      (progn (%rplaca old host) 
             (%rplacd old new))
      (push (cons host new) %logical-host-translations%)))
  list)

(defsetf logical-pathname-translations set-logical-pathname-translations)

; doest check if already there - adds at front 
(defun add-logical-pathname-translation (host translation)
  (let ((trans (%str-assoc host  %logical-host-translations%)))
    (if (not trans)
      (set-logical-pathname-translations host (list translation))
      (let ((new (debind (from to &rest ignored) translation
                        (declare (ignore ignored))
                        (list (parse-namestring from host) (pathname to)))))
        (rplacd trans (cons new (cdr trans)))
        (cdr trans)))))

; efficiency be damned - the caller above has already checked for match
(defun translate-pathname (source from-wildname to-wildname &key reversible)
  (when (not (pathnamep source))(setq source (pathname source)))
  (flet ((foo-error (source from)
                    (error "Source ~S and from-wildname ~S do not match" source from)))
    (let (r-host r-device r-directory r-name r-type r-version s-host f-host t-host)
      (setq s-host (pathname-host source))
      (setq f-host (pathname-host from-wildname))
      (setq t-host (pathname-host to-wildname))
      (if (not (%component-match-p s-host f-host))(foo-error source from-wildname))
      (setq r-host (translate-component s-host f-host t-host reversible))
      (let ((s-dir (%std-directory-component (pathname-directory source) s-host))
            (f-dir (%std-directory-component (pathname-directory from-wildname) f-host))
            (t-dir (%std-directory-component (pathname-directory to-wildname) t-host)))
        (let ((match (%pathname-match-directory s-dir f-dir)))
          (if (not match)(foo-error source from-wildname))
          (setq r-directory  (translate-directory s-dir f-dir t-dir reversible t-host))))
      (let ((s-name (pathname-name source))
            (f-name (pathname-name from-wildname))
            (t-name (pathname-name to-wildname)))
        (if (not (%component-match-p s-name f-name))(foo-error source from-wildname))        
        (setq r-name (translate-component s-name f-name t-name reversible)))
      (let ((s-type (pathname-type source))
            (f-type (pathname-type from-wildname))
            (t-type (pathname-type to-wildname)))
        (if (not (%component-match-p s-type f-type))(foo-error source from-wildname))
        (setq r-type (translate-component s-type f-type t-type reversible)))
      (let ((s-version (pathname-version source))
            (f-version (pathname-version from-wildname))
            (t-version (pathname-version to-wildname)))
        (if (not (%component-match-p s-version f-version))(foo-error source from-wildname))
        (setq r-version (translate-component s-version f-version t-version reversible))
        ;(if (eq r-version :unspecific)(setq r-version nil))
        )
      (make-pathname :device r-device :host r-host :directory r-directory
                     :name r-name :type r-type :version r-version :defaults nil)
      )))

#|
(defun translate-directory (source from to reversible)
  (let ((result (translate-directory2 (cdr source)(cdr from)(cdr to) reversible)))
    (cond ((eq result (cdr source)) source)
          ((eq result (cdr to)) to)
          (t (cons (car (or source from)) result)))))
|#

(defun translate-directory (source from to reversible &optional thost)
  (flet ((string-test (x y)(and (or (stringp x)(encoded-stringp x))(or (stringp y)(encoded-stringp y))(string-string= x y))))
    (let* ((result (translate-directory2 (cdr source)(cdr from)(cdr to) reversible))
           (relative-p (eq (car source) :relative)))
      (cond ((and (not relative-p)(eq result (cdr source))) source)
            ((and (not relative-p)(eq result (cdr to))) to)
            (t (setq result (cons (car (or source from)) result))
               (if (and relative-p (or (null thost)(eq thost :unspecific))) ;; <<<  kludge that works for e.g. "ccl:;foo;"            
                 (let ((thing (cadr source)))
                   (if thing
                     (let ((pos (position thing result :test (if (stringp thing) #'string-test #'eq))))
                       (when pos
                         (setq result (copy-list result))
                         (rplacd (nthcdr (1- pos) result)(cons :up (nthcdr pos result)))
                         (rplaca result :absolute)))
                     (when (> (length result) 1)
                       (setq result (butlast result))(rplaca result :absolute)))))
               result)))))


;; oh oh, directory components can be (:logical "bar")
(defun translate-directory2 (source from to reversible)
  ; we already know it matches
  (let (result srest match tfirst trest twild twild-logical) ; twild-logical should never be true today (unless compat loaded)   
    (flet ((logical-result (thing)
                           (mapcar #'(lambda (e)
                                       (cond ((consp e)
                                              (cond (twild-logical e)
                                                    (t (cadr e))))
                                             (twild-logical (list :logical e))
                                             (t e)))
                                   thing)))
      (declare (dynamic-extent #'logical-result))
      (multiple-value-setq (tfirst trest twild twild-logical)
                           (%split-ccdirectory to))
      (cond ((and to (not twild))
             (return-from translate-directory2 to))
            (nil ;(and (not reversible) (null tfirst)(null trest))   ; ie "**"
             (return-from translate-directory2 (logical-result source))))                           
      (multiple-value-bind (ffirst frest fwild fwild-logical)
                           (%split-ccdirectory from)
        (setq srest (nthcdr (length ffirst) source))
        (cond ((eq fwild '**)
               (setq match (nth-value 1 (%pathname-match-dir1 srest frest t)))               
               (when fwild-logical (setq match (logical-result match)))
               (cond ((eq twild '**)
                      (setq result (nconc tfirst match))
                      (setq srest (nthcdr (length match) srest)))
                     (t (return-from translate-directory2
                          (translate-directory2 source (nconc ffirst match frest)
                                                to reversible)))))
              ((eq twild '**)
               (let ((length (length tfirst)))
                 (setq srest (nthcdr length source))
                 (setq frest (nthcdr length from))
                 (setq  match (nth-value 1 (%pathname-match-dir1 srest trest t)))
                 (cond ((null  match)
                        (setq result tfirst))
                       (t (setq srest (nthcdr (setq length (length match)) srest))
                          (setq frest (nthcdr length frest))
                          (when twild-logical (setq match (logical-result match)))
                          (setq result (nconc tfirst match))))))
              (t
               (cond ((null fwild)
                      ; to has a wild component e.g. *abc, from is not wild
                      ; by defintion source is also not wild
                      ; which random source component gets plugged in here??
                      (setq srest (nthcdr (length tfirst) source))
                      (setq frest (nthcdr (length tfirst) source))))
               (let ((part (translate-component
                                  (car srest) (car frest)(car trest) reversible)))
                 (if (null part)(setq result tfirst)
                     (progn
                       (setq part (list part))
                       (setq result (nconc tfirst (if twild-logical (logical-result part) part))))))
               (setq srest (cdr srest) frest (cdr frest) trest (cdr trest))))
        (when trest 
          (let ((foo (translate-directory2 srest frest trest reversible)))
            (when foo (setq result (nconc result foo))))))
      result)))

; cc stands for cdr canonical
; ("abc" "**" "def" => ("abc") ("def")
; ("abc" "*de") => ("abc") ("*de")
(defun %split-ccdirectory (dir)
  (let ((pos 0) (wildp nil)(rest dir)(logical nil))
    (dolist (e dir)
      (when (consp e) (error "Shouldn't") (setq logical t)(setq e (cadr e))) ; 7/96
      (case e
        (:wild (setq wildp '*))
        (:wild-inferiors 
         (setq wildp '**)
         (setq rest (cdr rest)))
        (t 
         (when (%path-mem "*" e)
           (cond ((string-string= e "**")
                  (setq rest (cdr rest))
                  (setq wildp '**))
                 ((eql 1 (string-length e))
                  (setq wildp '*))
                 (t (setq wildp t))))))
      (when wildp (return))
      (setq rest (cdr rest))
      (setq pos (%i+ 1 pos)))
    (cond ((not wildp)
           (values dir))
          (t (let (first)
               (when rest (setq rest (copy-list rest)))
               (dotimes (i pos)
                 (declare (fixnum i))
                 (push (car dir) first)
                 (setq dir (cdr dir)))
               (values (nreverse first) rest wildp (if wildp logical)))))))

; could avoid calling component-match-p by checking here maybe
; if "gazonk" "gaz*" "h*" => "honk"
; then "gazonk" "gaz*" "*" => "onk" or is it "gazonk" (per pg 625)
; I believe in symbolics land "gazonk" is a regular translation
; and "onk" is a reversible translation (achieved by not doing pg 625) AHH
; similarly is "a:" "a:**:" "**"  Nil or "a:" 
(defun translate-component (source from to &optional reversible)                   
  (let ((orig-to to))
    (cond 
     ((and (consp source)(consp from)) ; source and from both logical 
      (setq source (cadr source) from (cadr from)))
     ((or (consp source)(consp from)) ;  or neither
      #-bccl (error "Something non-kosher in translate pathname")
      ))
    (when (memq from '(:wild :wild-inferiors)) (setq from "*"))
    (when (memq source '(:wild :wild-inferiors))(setq source "*"))
    (when (memq to '(:wild :wild-inferiors))(setq to "*"))
    (cond ((consp to)(setq to (cadr to))))  ;??
    (cond ((and (stringp to)(not (%path-mem "*" to)))
           to)
          ((and (or (not reversible)(not (or (stringp source)(encoded-stringp source)))) ; <<
                (or (null to)
                    (and (or (stringp to)(encoded-stringp to))(or (string-string= to "**")(string-string= to "*")))))
           source)
          ((eq to :unspecific) to)  ; here we interpret :unspecific to mean don't want it
          ((not (or (stringp source)(encoded-stringp source))) to)
          (t 
           (let ((slen (string-length source)) srest match spos result (f2 nil) snextpos)
             (multiple-value-bind (tfirst trest twild)
                                  (%split-component to)
               (cond ((and to (not twild))(return-from translate-component to)))
               (multiple-value-bind (ffirst frest fwild)
                                    (%split-component from)          
                 (cond (fwild
                        (setq spos (if ffirst (string-length ffirst) 0))       ; start of source hunk
                        (if frest (setq f2 (%split-component frest)))
                        (setq snextpos (if f2 (%path-member f2 source spos) slen))
                        (setq match (%substr source spos snextpos))
                        (if frest (setq srest (%substr source snextpos slen)))
                        (setq result (if tfirst (maybe-encoded-strcat tfirst match) match))
                        (when frest 
                          (let ((foo (translate-component srest frest trest reversible)))
                            (when foo (setq result (maybe-encoded-strcat result foo))))))
                       (t  ; to is wild, from and source are not
                        (setq result (if tfirst (maybe-encoded-strcat tfirst source) source))
                        (when trest (setq result (maybe-encoded-strcat result trest))))))
               (if (consp orig-to)(progn (error "shouldnt")(list :logical result)) result) ; 7/96
               ))))))


(defun %path-member (small big &optional (start 0))
  (let ((escape *pathname-escape-character*))
  (cond ((encoded-stringp big)
         (if (neq (the-encoding big) #$kcfstringencodingunicode)
           (setq big (convert-string (the-string big)(the-encoding big) #$kcfstringencodingunicode))
           (setq big (the-string big)))))
  (cond ((encoded-stringp small)
         (if (neq (the-encoding small) #$kcfstringencodingunicode)
           (setq small (convert-string (the-string small)(the-encoding small) #$kcfstringencodingunicode))
           (setq small (the-string small)))))
  (let* ((end (length big))
         (s-end (length small))
         (s-start 1)
         (c1 (%schar small 0))
         (pstart start))
    (if (%i> s-end end)(return-from %path-member nil))
    (when (eql c1 escape)
      (setq c1 (%schar small 1))
      (setq s-start 2))      
    (while (and (progn (if (eql (%schar big pstart) escape)
                         (setq pstart (%i+ pstart 1)))
                       T)
                (%i< pstart end)
                (neq (%schar big pstart) c1))
      (setq pstart (%i+ pstart 1)))
    (if (neq c1 (%schar big pstart))(return-from %path-member nil))
    (setq start (%i+ pstart 1))
    (while (and (progn (if (eql (%schar big start) escape)
                         (setq start (%i+ 1 start)))
                       (if (eql (%schar small s-start) escape)
                         (setq s-start (%i+ 1 s-start)))
                       T)
                (%i< start end)
                (%i< s-start s-end)
                (eql (%schar big start)(%schar small s-start)))
      (setq start (%i+ start 1) s-start (%i+ s-start 1)))
    (cond ((= (the fixnum s-start) (the fixnum s-end))
            pstart)
          ((%i< start end)
           ;(when encoding (setq big (maybe-make-encoded-string big) small (maybe-make-encoded-string small)))
            (%path-member small big (%i+ 1 pstart)))
          (T nil)))))

(defun maybe-make-encoded-string (string)
  string
  #+ignore
  (if (7bit-ascii-p string) string
      (make-encoded-string string)))


(defun %split-component (thing &aux pos)
  ;"ab*cd*"  ->  "ab" "cd*"  
  (if (or (null thing)(eq thing :unspecific)(null (setq pos (%path-mem "*" thing))))
    (values thing nil nil)
    (let* ((len (string-length thing)))
      (declare (fixnum len))
      (values (if (%izerop pos) nil (%substr thing 0 pos))
              (cond ((eql len (%i+ pos 1)) nil)
                    (t 
                     (when (eq (string-schar thing (+ pos 1)) #\*)
                       (setq pos (+ pos 1)))
                     (cond ((eql len (%i+ pos 1)) nil)
                           (t (%substr thing (%i+ pos 1) len)))))
              T))))


(defun logical-pathname (path)
  (let* (host
         (result
          (typecase path
            (logical-pathname path)
            (stream (%path-from-stream path))
            (string 
             (setq host (pathname-host-sstr path 0 (length path) t)))
            (encoded-string
             (let ((enc (the-encoding path))
                   ;(*pathname-escape-character* *pathname-escape-character-unicode*)
                   )               
               (setq host (pathname-host-sstr (the-string path) 0 (length (the-string path)) t))
               (if host (setq host (make-encoded-string host enc))))))))
    (if (and host (neq host :unspecific) (null (%str-assoc host %logical-host-translations%)))
      (setf (logical-pathname-translations host) nil))  ;; what is this all about?
    (typecase result
      (logical-pathname result)
      (string (pathname path))
      (encoded-string (pathname path))
      (t (report-bad-arg path 'logical-pathname))))) ; huh? - a tautology


; added - efficiency overlooked for now

(defun pathname-match-p (pathname wildname)
  (let ((path-host (pathname-host pathname))
        (wild-host (pathname-host wildname)))
    (and
     (%component-match-p path-host wild-host)
     (%component-match-p (pathname-device pathname)(pathname-device wildname))
     (%pathname-match-directory
      (%std-directory-component (pathname-directory pathname) path-host)
      (%std-directory-component (pathname-directory wildname) wild-host))
     (%component-match-p (pathname-name pathname)(pathname-name wildname))
     (%component-match-p (pathname-type pathname)(pathname-type wildname))
     (%component-match-p (pathname-version pathname)(pathname-version wildname)))))


(defun %component-match-p (name wild) 
  (if (or (eq name :unspecific)
          (and (or (stringp name)(encoded-stringp name)) (or  (string-string= name "*")(string-string= name "**"))))
    (setq name nil))  
  (if (or (eq wild :unspecific)(and (or (stringp wild)(encoded-stringp wild)) (or (string-string= wild "*")(string-string= wild "**"))))
    (setq wild nil))
  (cond ((null name) 
         (null wild))
        ((null wild)
         t)
        (t (%path-str*= name wild))))


; expects canonicalized directory - how bout absolute vs. relative?
(defun %pathname-match-directory (path wild)  
  (cond ((equal path wild) t)
        ;((and (consp path)(consp wild)(neq (car path) (car wild)))
        ;   nil)  ; one absolute & one relative ??
        ((or (and (null wild)
                  (let ((dir (cadr path)))
                    (if (stringp dir)
                      (string= dir "**")
                      (if (encoded-stringp dir)
                        (string-string= dir "**")
                        (eq dir :wild-inferiors)))))
             (and (null (cddr wild))
                  (let ((dir (cadr wild)))
                    (when (consp dir) (setq dir (cadr dir)))
                    (if (stringp dir)
                      (string= dir "**")
                      (if (encoded-stringp dir)
                        (string-string= dir "**")
                        (eq dir :wild-inferiors)))))))
        (t (%pathname-match-dir0 (cdr path)(cdr wild)))))

; munch on tails path and wild 
#|
(defun %pathname-match-dir0 (path wild)
  (flet ((only-wild (dir)
                    (when (null (cdr dir))
                      (setq dir (car dir))
                      (when (consp dir) (setq dir (cadr dir)))
                      (if (stringp dir)(string= dir "**")(eq dir :wild-inferiors)))))
    (cond ((eq path wild) t)
          ((only-wild wild)
           t)
          (t (let ((result t))
               (block nil 
                 (while (and path wild)
                   (let ((pathstr (car path))
                         (wildstr (car wild)))                     
                     ; allow logical to match physical today
                     ; because one of these days these logical things will disappear!
                     (when (consp pathstr)(setq pathstr (cadr pathstr)))
                     (when (consp wildstr)(setq wildstr (cadr wildstr)))
                     (case wildstr
                       (:wild (setq wildstr "*"))
                       (:wild-inferiors (setq wildstr "**")))
                     (case pathstr
                       (:wild (setq pathstr "*"))
                       (:wild-inferiors (setq pathstr "**")))
                     (when (not 
                            (cond ((string= wildstr "**")
                                   (setq result (%pathname-match-dir1 path (cdr wild)))
                                   (return-from nil))
                                  ((%path-str*= pathstr wildstr))))
                       (setq result nil)
                       (return-from nil))
                     (setq wild (cdr wild) path (cdr path))))
                 (when (and (or path wild)(not (only-wild wild)))
                   (setq result nil)))
               result)))))
|#


(defun %pathname-match-dir0 (path wild)
  (flet ((only-wild (dir)
                    (when (null (cdr dir))
                      (setq dir (car dir))
                      (when (consp dir) (setq dir (cadr dir)))
                      (if (stringp dir)
                        (string= dir "**")
                        (if (encoded-stringp dir)
                          (string-string= dir "**") 
                          (eq dir :wild-inferiors))))))
    (cond ((eq path wild) t)
          ((only-wild wild)
           t)
          (t (let ((result t))
               (block nil 
                 (while (and path wild)
                   (let ((pathstr (car path))
                         (wildstr (car wild)))                     
                     ; allow logical to match physical today
                     ; because one of these days these logical things will disappear!
                     (when (consp pathstr)(setq pathstr (cadr pathstr)))
                     (when (consp wildstr)(setq wildstr (cadr wildstr)))
                     (case wildstr
                       (:wild (setq wildstr "*"))
                       (:wild-inferiors (setq wildstr "**")))
                     (case pathstr
                       (:wild (setq pathstr "*"))
                       (:wild-inferiors (setq pathstr "**")))
                     (if (or (memq wildstr '(:up :back))(memq pathstr '(:up :back))) ;; ????? <<<<
                       (when (neq pathstr wildstr)(setq result nil) (return-from nil))
                       (when (not 
                              (cond ((string-string= wildstr "**")
                                     (setq result (%pathname-match-dir1 path (cdr wild)))
                                     (return-from nil))
                                    ((%path-str*= pathstr wildstr))))
                         (setq result nil)
                         (return-from nil)))
                     (setq wild (cdr wild) path (cdr path))))
                 (when (and (or path wild)(not (only-wild wild)))
                   (setq result nil)))
               result)))))



; wild is stuff after a "**" - looking for what matches the **  in (path)
(defun %pathname-match-dir1 (path wild &optional cons-result)
  (let ((match nil) pathstr wildstr)
    (cond ((null wild)
           (values T (if cons-result (mapcar #'(lambda (e)
                                            (if (consp e)(cadr e) e))
                                        path))))
          ((%pathname-match-dir0 path wild))   ; ie ** matches nothing
          (t 
           (prog nil
             AGN
               (setq pathstr (car path) wildstr (car wild))
               (when (consp pathstr)(setq pathstr (cadr pathstr)))
               (when (consp wildstr)(setq wildstr (cadr wildstr)))
               (case wildstr
                 (:wild (setq wildstr "*"))
                 (:wild-inferiors (setq wildstr "**")))
               (case pathstr
                 (:wild (setq pathstr "*"))
                 (:wild-inferiors (setq pathstr "**")))
               (until (or (not (consp path))
                          (%path-str*= pathstr wildstr))
                 (when cons-result (push pathstr match))
                 (setq path (cdr path))
                 (setq pathstr (car path))
                 (when (consp pathstr)(setq pathstr (cadr pathstr))))
               ;; either got a match - w and path both have the thing we looked for
               ;; or path is empty
               (when (null path)(return nil))
               (let ((path1 (cdr path))(wild (cdr wild)))
                 (when (and (null path1)(null wild))
                   (return (values t (when match (nreverse match)))))
                 (cond ((%pathname-match-dir0 path1 wild)  ; is the rest happy too?
                        (return (values t (nreverse match))))
                       (t (when cons-result (push pathstr match)) ; nope, let ** eat more
                          (setq path (cdr path))
                          (go AGN)))))))))
#+gonzo
(defun %path-str*= (string pattern)  
  (cond 
   ((and nil (simple-base-string-p string)(simple-base-string-p pattern))
    (%%path-str*= string pattern))
   (t           
    (require-type string 'simple-string)
    (require-type pattern 'simple-string)
    (let ((p-start 0)
          (p-end (length pattern))
          (s-start 0)
          (s-end (length string))
          (esc (char-code *pathname-escape-character*)))
      (declare (optimize (speed 3)(safety 0)))
      (declare (fixnum p-start p-end s-start s-end))
      (loop
        (when (eq p-start p-end)(return-from %path-str*= (eq s-start s-end)))
        (let ((p (%scharcode pattern p-start)))
          (cond 
           ((eq p (char-code #\*))
            (loop          
              (setq p-start (%i+ 1 p-start))
              (when (eq p-start p-end)(return-from %path-str*= t))
              (unless (eq (setq p (%scharcode pattern p-start)) (char-code #\*))
                (return)))
            (loop ; looking for the char after *
              (when (eq s-start s-end)(return-from %path-str*= nil))
              (let ((s (%scharcode string s-start)))
                (when (eq s esc)(setq s (%scharcode string (setq s-start (%i+ s-start 1)))))
                (setq s-start (%i+ 1 s-start))
                (when (or (eq p s)
                          (and (progn (setq s (%ilogxor s 32))
                                      (eq p s))
                               (progn (setq s (%ilogior s 32))
                                      (>= s (char-code #\a)))
                               (%i<= s (char-code #\z))))
                  (setq p-start (%i+ 1 p-start))
                  (return)))))
           (t
            (when (eq p esc)
              (setq p (%scharcode pattern(setq p-start (1+ p-start)))))
            (when (eq s-start s-end)(return-from %path-str*= nil))
            (let ((s (%scharcode string s-start)))
              (when (eq s esc)(setq s (%scharcode string (setq s-start (%i+ s-start 1)))))
              (when (not (or (eq p s)
                             (and (progn (setq p (%ilogxor p 32))
                                         (eq p s))
                                  (progn (setq p (%ilogior p 32))
                                         (>= p (char-code #\a)))
                                  (%i<= p (char-code #\z)))))
                (return-from %path-str*= nil)))
            (setq p-start (1+ p-start))
            (setq s-start (1+ s-start))))))))))

; bootstrapping - this is right but won't boot - well maybe not right
; (require :stuff) loops forever says "binppc" = "bin"

  

; three times bigger and 3 times slower - does it matter?
#|
(defun %path-str*= (string pattern)
  (cond 
   (#-PPC-target (and (simple-base-string-p string)(simple-base-string-p pattern))
    #+PPC-target nil
    (%%path-str*= string pattern))
   (t           
    (require-type string 'simple-string)
    (require-type pattern 'simple-string)
    (let* ((p-end (length pattern))
           (s-end (length string)))
      (declare (optimize (speed 3)(safety 0)))
      (path-str-sub pattern string 0 0 p-end s-end)))))
|#

(defun %path-str*= (string pattern)
  (cond 
   (#-PPC-target (and (simple-base-string-p string)(simple-base-string-p pattern))
    #+PPC-target nil
    (%%path-str*= string pattern))
   (t           
    ;(require-type string 'simple-string)
    ;(require-type pattern 'simple-string)
    (does-pattern-match pattern string))))

;; maybe aint used any more
#|
(defun path-str-sub (pattern str p-start s-start p-end s-end)
  (declare (fixnum p-start s-start p-end s-end))
  (declare (optimize (speed 3)(safety 0)))
  (let ((p (%scharcode pattern p-start))
        (esc (char-code *pathname-escape-character*)))    
    (cond 
     ((eq p (char-code #\*))
      ; starts with a * find what we looking for unless * is last in which case done
      (when (eq (%i+ 1 p-start)  p-end)
        (return-from path-str-sub t))
      (let* ((next* (%path-mem "*" pattern  (%i+ 1 p-start)))
             (len (- (or next* p-end) (%i+ 1 p-start)))) 
        (loop
          (when (> (%i+ s-start len) s-end)(return nil))
          (let ((res (find-str-pattern pattern str (%i+ 1 p-start) s-start (or next* p-end) s-end)))
            (if (null res)
              (return nil)
              (if (null next*)
                (if (eq res s-end)
                  (return t))
                (return (path-str-sub pattern str next* (+ s-start len) p-end s-end)))))
          (setq s-start (1+ s-start)))))
     (t (when (eq p esc)
          (setq p-start (1+ p-start))
          (setq p (%scharcode pattern p-start)))
        (let* ((next* (%path-mem "*" pattern (if (eq p (char-code #\*))(%i+ 1 p-start) p-start)))
               (this-s-end (if next* (+ s-start (- next* p-start)) s-end)))
          (if (> this-s-end s-end)
            nil
            (if  (path-str-match-p pattern str p-start s-start (or next* p-end) this-s-end)
              (if (null next*)
                t
                (path-str-sub pattern str next* this-s-end p-end s-end)))))))))
|#

#|
(defun find-str-pattern (pattern str p-start s-start p-end s-end)
  (declare (fixnum p-start s-start p-end s-end))
  (declare (optimize (speed 3)(safety 0)))
  ;(macrolet ((%scharcode (a b) `(char-code (schar ,a ,b))))
  (let* ((first-p (%scharcode pattern p-start))
         (esc (char-code *pathname-escape-character*)))
    (when (eq  first-p esc)
      (setq first-p (%scharcode pattern (setq p-start (1+ p-start)))))
    (do* ((i s-start (1+ i))
          (last-i (%i- s-end (%i- p-end p-start)))) 
         ((> i last-i) nil)
      (declare (fixnum i last-i))
      (let ((s (%scharcode str i)))        
        (when (or (eq first-p s)
                  (and (eq first-p (%ilogxor s 32))
                       (progn (setq s (%ilogior s 32))
                              (%i>= s (char-code #\a)))
                       (%i<= s (char-code #\z))))
          (do* ((j (1+ i) (1+ j))
                (k (1+ p-start)(1+ k)))
               ((>= k p-end) (progn (return-from find-str-pattern j)))
            (declare (fixnum j k))
            (let* ((p (%scharcode pattern k))
                   (s (%scharcode str j)))
              (when (eq  p esc)
                (setq p (%scharcode pattern (setq k (1+ k)))))
              (when (not (or (eq p s)
                             (and (eq (%ilogxor p 32) s)
                                  (progn (setq p (%ilogior p 32))
                                         (%i>= p (char-code #\a)))
                                  (%i<= p (char-code #\z)))))
                (return)))))))))
|#

#|
(defun path-str-match-p (pattern str p-start s-start p-end s-end)
  (declare (fixnum p-start s-start p-end s-end))
  (declare (optimize (speed 3)(safety 0)))
  ;(macrolet ((%scharcode (a b) `(char-code (schar ,a ,b))))
  ;; does pattern match pstr between p-start p-end
  (let ((esc (char-code *pathname-escape-character*)))
    (loop      
      (when (eq p-start p-end)
        (return (eq s-start s-end)))
      (WHEN (>= S-START S-END)(RETURN NIL))
      (let ((p (%scharcode pattern p-start)))
        (when (eq p esc)
          (setq p (%scharcode pattern (setq p-start (1+ p-start)))))
        ;(when (eq p #\*)(return p-start))
        (when (eq p-start p-end)
          (return T))
        (let ((s (%scharcode str s-start)))
          (when (not (or (eq p s)
                         (and (eq (%ilogxor p 32) s)
                              (progn (setq p (%ilogior p 32))
                                     (%i>= p (char-code #\a)))
                              (%i<= p (char-code #\z)))))
            (return nil))
          (setq p-start (1+ p-start))
          (setq s-start (1+ s-start)))))))
|#
      
             
#-ppc-target
(progn

(defun %%path-str*= (string pattern)  
  (old-lap-inline ()
    (move.l arg_y atemp0)
    (jsr_subprim $sp-check-string-atemp0)   ; preserves argregs
    (exg arg_z atemp0)
    (jsr_subprim $sp-check-string-atemp0)   ; preserves argregs
    (move.l arg_z atemp1)

    (getvect atemp0 arg_z)
    (getvect atemp1 arg_y)
    (moveq -1 arg_x)
    (jsr #'%%path*=)))


;atemp0/arg_z = pattern pointer and length
;atemp1/arg_y = string pointer and length
;arg_x = -1 if string has escapes, 0 if doesn't.
;Returns acc=NILREG if no match, acc non-NIL if match.
(defun %%path*= (&lap 0)
  (old-lap
    (defreg PATTERN atemp0 STRING atemp1 PATEND arg_z STREND arg_y ESC arg_x)
    (add.l PATTERN PATEND)
    (add.l STRING STREND)
    (move.l (special *pathname-escape-character*) da)
    (swap da)
    (move.b da ESC)
    ;(bsr path*=)
    ;(rts)

    path*=
    (progn
      (until# (eq (cmp.l PATTERN PATEND))
        (move.b (@+ PATTERN) da)
        (if# (eq (cmp.b ($ #\*) da))
          (prog#
            (bif (eq (cmp.l PATTERN PATEND)) @WIN)
            (until# (ne (cmp.b ($ #\*) (@+ PATTERN)))))
          (move.b (PATTERN -1) da)
          (if# (eq (cmp.b da ESC)) (move.b (@+ PATTERN) da))   ;Guaranteed not to end in ESC
          (prog#
            (bif (eq (cmp.l STRING STREND)) @LOSE)
            (move.b (@+ STRING) db)
            (if# (and (eq (cmp.b db ESC)) (mi (tst.w ESC))) (move.b (@+ STRING) db))   ;Guaranteed not to end in ESC
            (until# (and (or (eq (cmp.b da db))
                             (and (eq (progn (eor.b ($ 32) db) (cmp.b da db)))
                                  (ge (progn (or.b ($ 32) db) (cmp.b ($ #\a) db)))
                                  (le (cmp.b ($ #\z) db))))
                         (eq (progn
                               (movem.l #(PATTERN STRING da acc) -@sp)
                               (bsr path*=)
                               (movem.l sp@+ #(PATTERN STRING da acc)))))))
          @WIN
          (move.l '0 acc)
          (rts))
        
        (if# (eq (cmp.b da ESC)) (move.b (@+ PATTERN) da))   ; Guaranteed not to end in ESC
        (bif (eq (cmp.l STRING STREND)) @LOSE)
        (move.b (@+ STRING) db)
        (bif (and (ne (cmp.b da db))
                  (or (ne (progn (eor.b ($ 32) db) (cmp.b da db)))
                      (lt (progn (or.b ($ 32) db) (cmp.b ($ #\a) db)))
                      (gt (cmp.b ($ #\z) db)))) @LOSE))
      (bif (eq (cmp.l STRING STREND)) @WIN)
      @LOSE
      (move.l nilreg acc)
      (rts))))

) ; #-ppc-target



(setf (logical-pathname-translations "home")
          `(("**;*.*" ,(merge-pathnames ":**:*.*" (mac-default-directory)))))



(setf (logical-pathname-translations "ccl")
          `(("interfaces;**;*.*" "ccl:library;interfaces;**;*.*")
            ("inspector;**;*.*" "ccl:library;inspector folder;**;*.*")
            ("lib;**;*.cfsl" "ccl:bincarbon;*.cfsl")
            ("l1;**;*.cfsl" "ccl:l1cf;*.cfsl")
            ("l1;**;*.*" "ccl:level-1;**;*.*")
            ("l1f;**;*.cfsl" "ccl:l1cf;**;*.cfsl")
            ("bin;**;*.cfsl" "ccl:bincarbon;**;*.cfsl")
            ("l1cf;**;*.*" "ccl:l1-cfsls;**;*.*")
            ("ccl;*.*" ,(merge-pathnames ":*.*" (mac-default-directory)))
            ("**;*.*" ,(merge-pathnames ":**:*.*" (mac-default-directory)))))




; these two fns are last for bootstrapping (record-source-file)
(defun translate-logical-pathname (pathname &key)
  (setq pathname (pathname pathname))
  (let ((host (pathname-host pathname)))
    (if (or (null host) (eq host :unspecific))
      (if (logical-pathname-p pathname)
        (%cons-pathname (pathname-directory pathname)(pathname-name pathname) (pathname-type pathname))
        pathname)
      (let ((rule (assoc pathname (logical-pathname-translations host)
                         :test #'pathname-match-p)))  ; how can they match if hosts neq??
        (if rule
          (translate-logical-pathname
           (translate-pathname pathname (car rule) (cadr rule)))
          (signal-file-error $xnotranslation pathname))))))


;This function should be changed to standardize the name more than it does.
;It should eliminate non-leading instances of "::" etc at least.  We might also
;want it to always return an absolute pathname (i.e. fill in the default mac
;directory), so as to make it a sort of harmless truename (which is how I think
;it's mainly used).  Unfortunately that would make it go to the file system,
;but it might be worth it.
;This function used to also remove quoting so as to make the name suitable for
;passing to rom.  It doesn't anymore. Use mac-namestring for that.
; does anybody use this??
; DO - merge in default if relative, and do the :: stuff
; perhaps call it expand-pathname or expanded-pathname


(defun full-pathname (path &key (no-error t))
  (let ((orig-path path))
    (cond (no-error
           ; note that ignore-errors wont work until var %handlers% is defined (in l1-init)
           (setq path (ignore-errors
                       (translate-logical-pathname (merge-pathnames path))))
           (when (null path) (return-from full-pathname nil)))
          (t (setq path (translate-logical-pathname (merge-pathnames path)))))
    (let* ((ihost (pathname-host orig-path))
           (dir (%pathname-directory path)))
      (when (and no-error (not dir) (%pathname-directory path)) ; WHAT is  that noop - since 3.0??
        (return-from full-pathname nil))
      (when (and ihost (neq ihost :unspecific))  ; << this is new. is it right?
        (if (eq (car dir) :relative)  ; don't make relative to mac-default-dir if had a host???
          (setq dir (cons :absolute (cdr dir)))))
      (setq dir (absolute-directory-list dir))      
      (unless (eq dir (%pathname-directory path))
        (setq path (cons-pathname dir (%pathname-name path) (%pathname-type path)
                                  (pathname-host path) (pathname-version path))))
      path)))



(defparameter *user-homedir-pathname* (cons-pathname nil nil nil "home"))

(defun user-homedir-pathname (&optional host)
  (if host 
    (make-pathname :host host)
    (pathname *user-homedir-pathname*)))

(defparameter *module-search-path* (list
                                    (cons-pathname '(:absolute "bincarbon") nil nil "ccl")                                    
                                    *user-homedir-pathname*
                                    (cons-pathname  nil nil nil "ccl")
                                    (cons-pathname '(:absolute "lib") nil nil "ccl")
                                    (cons-pathname '(:absolute "lib" "ppc") nil nil "ccl")                                    
                                    (cons-pathname '(:absolute "library") nil nil "ccl")
                                    (cons-pathname '(:absolute "interface tools") nil nil "ccl")
                                    (cons-pathname '(:absolute "sourceserver") nil nil "ccl")
                                    (cons-pathname '(:absolute "examples") nil nil "ccl")
                                    (cons-pathname '(:absolute "compiler") nil nil "ccl")
                                    (cons-pathname '(:absolute "compiler" "PPC") nil nil "ccl"))
  "Holds a list of pathnames to search for the file that has same name
   as a module somebody is looking for.")



#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/2/95	akh	actually no change
|# ;(do not edit past this line!!)
