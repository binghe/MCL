;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 8/25/97  akh  add finder comment stuff
;;  17 9/13/96 akh  fix physical-pathname-p for nwo
;;  16 9/4/96  akh  dont remember
;;  13 7/30/96 akh  fix find-pstr-pattern - dont run off the end
;;  12 7/26/96 akh  fix %path-pstr*=
;;  10 5/20/96 akh  path-pstr*= fix for false alarm on match with *
;;  7 1/28/96  akh  back-translate-pathname takes optional allowable hosts arg
;;  3 11/17/95 akh  #_hxx => #_PBHxx
;;  2 10/11/95 akh  no lap if ppc
;;  7 9/14/95  akh  path-pstr*=  - firstbyte => singlebyte
;;  6 7/27/95  akh  merge patches - set-xtab-lfun and redefmethod
;;  5 6/8/95   slh  make load-all-patches really do that
;;  2 4/28/95  akh  fix path-pstr*= - aref char-byte-table (not svref)
;;  3 3/2/95   akh  say element-type 'base-character
;;  (do not edit before this line!!)

;;pathnames.lisp Pathnames for Coral Common LISP
;; Copyright 1987-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-1999 Digitool, Inc.

(in-package "CCL")

; Modification History:
;; add stuff for resources in data fork
;; simplify convert-string a little bit
;; ------ 5.2b6
;; use function remove-path-from-hashes
;; remove naughty nreverse in directory
;; back-translate-pathname-1 dont *use-namestring-caches*
;; add lock/unlock-file-fsref 
;; ------ 5.2b5
;; put application-pathname-to-window-title methods here
;; ----- 5.2b3
;; lose some deftrap-inlines - the things are in interfaces now
;; read-scriptruns - things are unsigned not signed
;; ---- 5.2b1
;; rename-directory - make it work when need to do #_fsmoveobject
;; fix get/set-finder-comment to compile - don't know if correct and these are os9 comments anyway
;; get rid of some nonsense re encoded-strings
;; %substr less likely to make-encoded-string
;; fix convert-string for macdingbats and macsymbol
;; unicode-char-code-upcase and downcase moved to l1-aprims
;; ---- 5.1 final
;; another fix to %files-in-directory2 to detect that something is really a directory 
;; tweaks to %files-in-directory2, more specific re "Volumes"
;; %files-in-directory2 - kludge that I do not understand
;; directory - deal with wild-volume finding same volume twice
;; copy-file - better error msgs given new path-to-fsref behavior
;; create-directory handles *default-pathname-defaults* differently, better.
;; unicode-string comparisions moved to chars.lisp
;; ------- 5.1b2
;; 04/04/04 rename-file and rename-directory maybe better re alias in destination
;; 03/29/04 rename-file may do copy, delete if both dir and name different
;; 03/13/04 fs-rename-last - use kTextEncodingUnknown for encoding hint - per carbon-dev mailing list
;; 03/06/04 string-string-equal -> string-equal
;; 02/26/04 load-patches don't bind *record-source-file* to NIL
;; ss - #'directoryp now behaves the same as MCL 5.0 except it doesn't assume the directory one level up
;;       if you name a file or leave off the last colon.
;; ss - #'directory pays attention to *alias-resolution-policy* when :resolve-aliases = t, so it can be made not to throw up
;;        a dialog box when it hits an offline alias
;; ss - stop #'directory from returning mid path aliases in certain cases when :resolve-aliases = t
;; 01/27/04 - fcomp-standard-source was brain dead
;; remove and then reinstate fasl-version check
;; 12/03/03 do-name-and-type-match-ustr fix so "foo" matches "foo.*"
;; rename-directory does rename-volume if need be
;; directory eliminates invisible files/folders ?? nah just provide a test arg if that's what you want - see is-path-invisible
;; get-fsref-array - fix to not error on some folder called .trash
;; font-to-encoding now works - 
;; add font-to-encoding
;; eject&unmount-disk - get truename before eject!
;; %newfasload - dont assume filename is a pathname, move string-from-hfsunistr-encoded-hairy to l1-files
;; eject&unmount-disk for jaguar
;; lose most of fcomp-standard-source
;; comment out some stuff and move some stuff to l1-files
;; convert-string is identity for from macroman, to unicode, on 7bit ascii string
;; remove escapes in path components before going to file system
;; tweaks in copy-file
;; directory2 is now directory, add unicode-string-compare
;; directory2 and friends cons somewhat less and somewhat faster
;; fix string-string-equal
;; function directory2 uses fsrefs - kind of slow and consarama
;; fix copy-file some more
;; copy-file does finder-info-p
;; fix volume-number for "", %substr handle encoded string
;; volume-number uses fsref, volume-free-space uses volume-number, drive-number
;; lots of stuff for fsrefs vs. iopb. rename-file, flush-volume ...
;; ----------- 5.0final
;;add unicode and utf8 to encoding-to-name
;; ------ 4.4b5
;; add convert-string for from-encoding to to-encoding, other stuff re scripts and fonts and encodings
; akh add new-cfrg-resource - used by save-application because of Jaguar caching crap - but breaks bootstrapping so lose for now
; ------- 4.4b4
; 03/16/02 load patches does resolve-aliases - from Terje N.
; ------- 4.4b2
; 07/16/01 fix rename-file (old bug)
; -------- 4.4b1
; no mo (#_GetVCBQHdr) if carbon see  volume-free-space
; no mo pbeject if carbon
; akh pbgetvinfo => pbhgetvinfo
; 01/20/00 ensure-directories-exist - second value (true or NIL) was backwards.
; 01/20/00 akh dirpath-to-filepath - make-pathname with :type :unspecific.
; --------- 4.3f1c1
; 06/30/99 akh volume-free-space from slh
; --------- 4.3b3
; 05/17/99 AKH load-all-patches loads source if no fasl/pfsl, rename-file gets path for error
;----------- 4.3b2
; 03/10/99 akh create-directory - do full-pathname first, weed type and maybe name if any out of pathname
; 03/03/99 akh volume-free-space from slh
; 08/01/98 akh create-directory errors if there is a file with the same name.
; 07/24/98 akh fix dirpath-to-filepath some more, :up is OK just get rid of it, a toplevel dir ought to exist if we say it exists.
; 07/23/98 akh create-directory and dirpath-to-filepath fixes from slh, ensure-directories-exist from kab

;; akh rename-file does copy, delete if different volumes
; akh - bill's set/get finder-comment with shannon spire's fix - added finder-comment-p arg to copy-file
; akh fix physical-pathname-p for nwo
; 08/05/96 bill (errchk (#_NewHandle ...)) => (#_NewHandle :errchk ...) in new-version-resource & patch-resource
;  7/31/96 slh  cond. out def-logical-directory (see comment)
; 04/25/96 bill load-patches says (make-pathname :name :wild :defaults *.fasl-pathname*)
;               instead of "*.fasl".
; 04/25/96 bill flush-volume resolves aliases.
; akh path-pstr*= fix for false alarm on match with *
; ------------- MCL-PPC 3.9
; 03/26/96  gb  lowmem accessors.
; 02/26/96 gb    #-ppc-target functions-match-p
; 12/05/95 slh   update trap names (a few more)
; 11/29/95 bill  New trap names to avoid emulator.
;                (#_PBxxx :errchk ...) -> (errchk (#_PBxxx ...))
; 11/30/95 slh   no patch-subprim for PPC
; 10/06/93 bill  register-patch, list-patches
; 10/04/93 bill  patch-resource can now lengthen the resource
; -------------- 3.0d13
; 07/13/93 alice rename-file, create-directory load-patches call full-pathname with no-error nil
; 06/16/93 alice fs-cons-pathname is no more, %dir-sub-file uses %std-name-and-type
; 06/12/93 alice %path-pstr*= deals with fat strings and assumes pstr is in system script.
; 04/13/93 bill  record-source-file in %redefmethod
; 02/09/93 bill  #_allocate -> #_SetEof. This makes Harold Haig's file server happy.
; 12/09/92 bill  #_allocate returns to %copy-fork
; 11/25/92 bill  patch-resource, patch-subprim
; 08/25/92 bill  in %copy-fork: use autoloaded records & constants, not sysequ.lisp constants
; 07/09/92 bill  added run-time for "ccl:lib;patchenv"
; 11/05/92 alice once again %directory, %one-wild, %all-directories - avoid indirect alias circles
;		while not avoiding good stuff (patch 2)
; 08/27/92 alice bigger block size in copy-file
; 04/29/92 alice %one-wild - dont resolve alias unless it matches
;		directory, %directory, %all-directories avoid indirect circles when resolving aliases
; 04/23/92 alice directory - fix (directory "*:abcd:" :directories t)
; 04/16/92 alice %file*= - ALWAYS put the length back (fixes a crock in directory)
; 02/28/92 alice directory dtrt when no directory provided
; 02/07/92 alice volume-number does something useful with 0
;--------------- 2.0
; 01/12/92 alice copy-file revert
; 12/16/91 alice eject-disk and friends allow volume-number too
; 12/12/91 gb    %err-disp -> signal-file-error, with fixnum args.
; 12/12/91 bill  #_LoadResource after #_Get1Resource
;--------------- 2.0b4
; 11/04/91 alice fs-cons-pathname quotes dots iff could be construed as having a version .0 or .newest
; 11/01/91 alice undo 09/12/91 - it is WRONG
; 10/10/91 alice rename-file use gen-file-name
; 10/21/91 gb    no more #_PB
; 09/24/91 alice fix load-logical-pathname-translations a) dont if already defined b) return T if loaded
; 09/20/91 alice another fix to rename-file 
; 09/12/91 alice files-in-directory if :directories t, also include dir if name is "*" - NO
; 09/12/91 alice create-directory failed to create intermediate dirs (result of alias mods)
; 09/11/91 alice copy-file obey :if-exists nil, rename-file was ill, create-directory recurse FULL PHYSICAL dir
;--------------- 2.0b3
; 08/29/91 alice %files-in-directory and %all-directories with no name or type heed directories argument
; 08/26/91 bill  copy-file reported some errors on wrong pathname
; 08/22/91 alice %copy-fork had another typo
; 08/21/91 bill  %copy-fork had a typo
; 08/21/91 alice forgot to pass along resolve-aliases in a few places.
; 08/01/91 alice adapt for aliases (to do:  rename-file, copy-file)
; 07/29/91 alice do dirids as 1 long
; 07/21/91 gb    use :clear option in %stack-block.  Use _Allocate when copying forks.
; 07/12/91 alice directory escape dots in name (so dont lose .0 etc)
; 07/09/91 alice simpler back-translate-pathname
; 07/03/91 alice fix bogosity in back-translate-pathname
; 06/28/91 alice make backtranslate-pathname do the old style logical dirs too.
; 06/10/91 alice backtranslate-pathname deal with :wild in directory list
; 06/07/91 alice new-version-resource read 'vers' from curaprefnum.
;------------ 2.0b2
; 06/04/91 alice add some more vars to load-patches
; 05/20/91 bill translate-logical-pathname in dirpath-to-filepath
; 05/16/91 bill add a :fork keyword to copy-file.
; 05/15/91 bill copy-file does _FlushVol.  %copy-fork clears the ioMisc field before open.
; 04/02/91 alice drive-name takes neg num to serve as volume-name
; 03/28/91 alice put load-patches here for lack of a better place
; 03/08/91 alice rename-file do directories too, deal with catmove + rename.
; 02/26/91 alice copy-file - dont create new before know old exists!
; 02/22/91 alice %err-disp => file-error
; 02/08/91 alice added back-translate-pathname
; 02/07/91 alice moved some stuff to l1-pathnames
; 02/06/91 alice %pathname-match-dir1 - logical match physical?
;---------- 2.0b1
; 02/06/91 alice load-logical-pathname-translations
; 01/30/91 alice dir etal don't call dir-path-from-iopb because GatorShare the Caymen/NFS thing doesnt
;          work right for protected dirs (can _getcatinfo via iofdirindex but not by ioDirID)
; 01/28/91 alice directory and friends use #files instead of waiting for fnferr
; 01/25/91 alice directory and friends - if unexpected error just quit/continue, dont error
; 01/25/91 alice set-logical-pathname-translations - fix so call to parse-namestring wont error
;----------------- 2.0a5
; 01/06/90 alice directory - do error if called upon undefined (ccl) logical directory
; 01/03/90 alice translate-component and %split-component
; 01/01/91 alice %component-match-p nothing matches **, %pathname-match-directory (abs vs. relative?)
; 01/01/90        translate-directory relative=>absolute is relative (??)
; 12/20/90 alice change call to %directory-list-namestring
; 12/13/90 alice fix %all-directories when ** matches nothing
; 12/11/90 alice change %some-specific
; 12/10/90 alice fix %logical-directory-component (then nuke it)
;   flush-volume and some others like eject-disk call make-pathname with host nil (or defaults nil)
;   verify-logical-host-name - check for defined logical host
;   deal with $afpAccessDenied errors in directory and friends
;--------------- 2.0a4
; 11/06/90 alice %pathname-match-dir0 fix to fix of 10/18/90 (so hd: matches hd:**:)
; 10/25/90 alice directory just call full-pathname instead of doing the same thing in line
; 10/23/90 alice create-directory just thought it was doing translate-logical-pathname
; 10/19/90 alice fix translate-directory for null source, %pathname-match-directory
;                let nil match **
; 10/18/90 alice %pathname-match-directory - dont match if one is longer - from alanr
; 10/16/90 gb   no more %str-length.
; 08/20/90 bill %%path*= per GZ
; 07/25/90 alice directory work for relative pathnames too
; 07/18/90 alice let create-directory create multiple sub-directories
; ---------- 2.0d48
; 07/12/90 alice make copy-file preserve creation and modification date
; 07/06/90 alice create-directory and directory call translate-logical-pathname
; 07/06/90 alice add eject&unmount-disk (name?? - useful ??)
; 07/01/90 alice The definitive and final version of directory
; 06/29/90 alice added volume-number
; 06/28/90 alice ever more fixes to directory
; 06/22/90 bill found the ugly bug in copy-file
; 06/21/90 alice fix directory **
; 06/19/90 alice make copy-file lots faster
; 06/11/90 alice pathname-match-p check logical host too
; 06/01/90 alice add translate-pathname (yuck) and logical-pathname
; 05/29/90 add pathname-match-p - fix kludge in file*=
;05/25/90 alice Added %all-directories - kludged a fix in %file*= for *.*
;05/21/90 bill Gails fix to %path-pstr*=
;5/7/90   gz  Logical pathnames, modulo a parser.  %path*= -> %path-pstr*=, add
;             %path-str*= for matching strings.
;04/14/90 gz  %substr now takes start/end args.
;             Logical-pathname -> logical-directory.
;             Structured directories.
;02/13/90 gz  Fix in rename-file:  _CatMove wants ioNewName null, not "".
;09/30/89 bill Fixed cache clearing in %one-directory
;09/27/89 gb simple-string -> ensure-simple-string.
;09/25/89 bill Added mode line.  Add use-cache-p arg to %path-from-iopb calls in
;              %one-directory.  Clear the cache at the beginning.
;01/05/89 gz Don't pass empty strings to traps.
;10/24/88 gz added def-logical-pathname, formerly in record-source(??)
;9/23/88 gb %path-[to,from]-pb -> %path-[to,from]-iopb.
;9/01/88 gz directory done except for "**" matching.
;8/30/88 gz new regime.  Directory not done yet.
;8/16/88 gz $ioNamePtr -> $ioFileName. %str= -> string=.
;9/29/87 jaj moved %do-files-in-directory and do-files-in-directory to l1-files
;------------------------------------Version 1.0-----------------------------
;8/21/87 gz  Made do-devices et. al. not expand into trap macros, so alltraps
;            isn't needed to use them.
;7/27/87 gz  Made file-locked-p return nil if file is not locked...
;7/26/87 am  lock-file unlock-file locked-filep now return their args.
;7/26/87 am  fixed directory to merge with *default-pathname-defaults*, and
;            use the mac-default directory if there is still no dir specified.
;7/24/87 gz  moved merge-pathnames and support to l1-files.
; 7/24/87 am pathnamep -> lisp-pathnamep
;7/22/87 am  modified pathname string-parsing per gz. made modules follow.
;            the global vars like *default-pathname-defaults* start with nil
;             made (pathname "foo") have nil directory component.
;             twidled some arguments to %filename-matcher and %str*=
; 7/18/87  gz try not to leave symbolic $constants in macroexpansions.
; 7/11/87  gz added find-module-pathnames (which is called by require),
;             *module-search-path*.
;             Made user-homedir-pathname return the "home;" dir, rather than
;             *working-directory*.
; 7/ 6/87  am user-home-dir-pathname return *working-directory* + tiny changes:
;             like hfs-volume-p -> %hfs-volume-p.
;             with-pstrs -> with-returned-pstrs in files/directories-in-directory
; 6/30/87  gz added some bccl conditionalizations.
; 06/21/87 am changed file immensely for new file-system. put file in lib.
; 06/21/87 gb moved pathmnamep, mac-pathnamep to l1-utils.  Made %pr-pathname
;             call CCL printer.
; 06/12/87 gb moved *pathname-escape-character* to level-2.  aux vars in
;             directory, %filename-matcher.
; 06/04/87 gb fixed pathnamep and mac-pathnamep when passed random uvectors.
; 87 05 24 cfry fixed pathnamep and mac-pathnamep when passed ""
;;87 05 16 am made directory-list look for ESCAPED semicolons.
;;87 05 06 am Made all components be strings, made pathnames be implemented as
;             structures. Moved %str-mem-bak %str-member-i 
;             toggle-case %str*= %str*=-aux %str-mem-esc %rem-unnecess-esc
;             %ins-esc to level-2. %parse-filename-str now returns multiple-values
;             instead of a list. + added many functions prefixed by mac- and %mac-
;             mac-to-lisp-namestring -> %mac-to-lisp-namestring
;;87 04 29 gb lexical variable name conflict in namestring.
;;87 04 27 am added %str-member-i and toggle-case. made %str*=-aux use them.
;;87 04 07 am fixed make-pathname and directory-namestring .
; 4/5/87   gz string-to-simple-string* -> simple-string. %member -> memq.
;;87 03 20 am expand-logical-pathnames -> expand-logical-namestring
;;87 03 17 am file-streamp -> stream-has-file-p
;;87 03 17 am string-to-simple-string* -> simple-string  #\¶ -> *pathname-escape-character*
;             %str-length -> length;  added file-streamp. Hacked truename again.
;;87 03 02 am Added a correct truename %truename defvared *working-directory*
;;87 02 26 am added printing and reading, escape-chars; changed merging and
;             expanding; no more downcasing.
;;87 02 25 am (based on gz's changes of 1/30/87) %str-char ->schar,
;             return -> return-from in %str*=,%str*=-aux,file-namestring,proper-dir-nam
;             truename -> %truename, %i-path-string-truename -> %truename,
;             am:truename -> truename.

;87 02 24 am changed much to make work in code-0. removed #'directory!
;87 02 23 am changed names for files-in-directory and directories-in-directory,
;            put in a differeent user-home-dir function and changed #'devices
;87 02 06 am added the fboundp cluase in the clause that defines truename.


(eval-when (eval compile)
  (require 'level-2)
  (require 'backquote)
  (require 'sysequ)
)
;(defconstant $accessDenied -5000) ; put this with other errnos
;(defconstant $afpAccessDenied -5000) ; which name to use?

;; fill an fsref array with nfrobs things contained in fsref - assume all args are symbols
(defmacro get-fsref-array (fsref nfrobs fsrefarray)
  (let ((crud (gensym)))
    `(when (> ,nfrobs 0) ;; doesn't like 0 - we check later
       (rlet ((actual :pointer)
              (container-changed :pointer)
              (iterator :pointer))
         (errchk (require-trap #_fsopeniterator ,fsref (require-trap-constant #$kFSIterateFlat) iterator))
         (progn (require-trap #_FSGetCataloginfobulk  ;; will error if actual aint nfrobs - happens for some .trash folder
                              (%get-ptr iterator) ;; iterator
                              ,nfrobs ;; max objects
                              actual ;; actualobjects
                              container-changed ;; I dont care
                              0  ;; which info in the cat infos???
                              (%null-ptr) ;; ;; catalog infos
                              ,fsrefarray ;; an array of fsrefs?
                              (%null-ptr) ;; fsspecs
                              (%null-ptr) ;; names
                              ))
         (errchk (require-trap #_fscloseiterator (%get-ptr iterator)))
         (let ((,crud (%get-unsigned-long actual)))           
           (when (not (= ,nfrobs ,crud))
             (if (< ,crud ,nfrobs)
               (setq ,nfrobs ,crud)
               (error "confused"))))))))   ; (error "confused")))))


#+no ; it's in a compatibility file now
(defun def-logical-directory (logical-name physical-pathname &aux pair len old)
   "Physical-pathname may be NIL to remove the definition.
    Returns old definition"
   (setq logical-name (string-arg logical-name)) ;coerces to simple-string
   (when (and (not (eql (setq len (length logical-name)) 0))
              (eq (schar logical-name (setq len (%i- len 1))) #\;)
              (not (%path-quoted-p logical-name len 0)))
     (setq logical-name (%substr logical-name 0 len)))
   (when physical-pathname
     (when (non-nil-symbol-p physical-pathname)
       (setq physical-pathname (symbol-name physical-pathname)))
     (if (stringp physical-pathname)
       (progn
         (setq physical-pathname (ensure-simple-string physical-pathname))
         (unless (or (eql (setq len (length physical-pathname)) 0)
                     (and (%str-member (schar physical-pathname (%i- len 1)) ":;")
                          (not (%path-quoted-p physical-pathname (%i- len 1) 0))))
           (setq physical-pathname (%str-cat physical-pathname ":"))))
       (setq physical-pathname (directory-namestring physical-pathname))))
   (setq pair (%str-assoc logical-name *logical-directory-alist*))
   (setq old (cdr pair))
   (if (null physical-pathname) ;remove
     (if pair (setq *logical-directory-alist*
                    (remove-from-alist (%car pair) *logical-directory-alist*)))
     (if pair (progn (%rplaca pair logical-name) ;In case new casification
                     (%rplacd pair physical-pathname))
         (push (cons logical-name physical-pathname)
               *logical-directory-alist*)))
   old)

;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;ANSI CL logical pathnames


(defvar *pathname-translations-pathname*
  (make-pathname :host "ccl" :type "pathname-translations"))

(defun load-logical-pathname-translations (host)
  ;(setq host (verify-logical-host-name host))
  (when (not (%str-assoc host %logical-host-translations%))
    (setf (logical-pathname-translations host)
          (with-open-file (file (merge-pathnames (make-pathname :name host :defaults nil)
                                                 *pathname-translations-pathname*)
                                :element-type 'base-character)
            (read file)))
    T))

(defun back-translate-pathname (path &optional hosts)
  (let ((newpath (back-translate-pathname-1 path hosts)))
    (cond (nil ;(equalp path newpath)  ;; what??
           (fcomp-standard-source path))
          (t newpath))))

; our old friend returns for awhile - WHAT???
(defun fcomp-standard-source (name)
  (if (pathnamep name)(setq name (namestring name)))
  #+ignore
  (let  ((len (length name)) str slen)
    (dolist (log.phys *logical-directory-alist*)  ;; this is NIL today
      (setq str (cdr log.phys) slen (string-length str))
      (when (and (%i<= slen len) (string-equal str name :end2 slen))
        (return-from fcomp-standard-source
          (maybe-encoded-strcat-many (car log.phys)
                    ";"
                    (%substr name slen len))))))
    name)

#|
; this only works for simple stuff!! wildcards at end only
(defun back-translate-pathname-1 (path)
  (dolist (host %logical-host-translations%)
    (dolist (trans (cdr host))
      (when (pathname-match-p path (cadr trans))
        (let* ((rhs (cadr trans))
               (path-dir (pathname-directory path))
               (lhs-dir (pathname-directory (car trans)))
               lhs-part
               newpath)
          (cond 
           ((and nil (logical-pathname-p path) ; this is may be totally bogus
                 (logical-pathname-p (cadr trans)))
            (setq newpath (translate-pathname path (cadr trans) (car trans) :reversible t)))
           (t   ; should probably skip translations containing e.g. foo*bar                
            (dolist (foo (cdr lhs-dir))
              (when (if (stringp foo)
                      (or (string= foo "**")
                          (string= foo "*"))
                      (memq  foo '(:wild-inferiors :wild)))
                (return))
              (push foo lhs-part))
            (setq lhs-part (nreverse lhs-part))            
            (when rhs
              (let ((rhs-dir (pathname-directory rhs))
                    (n 0))
                (dolist (foo (cdr rhs-dir))
                  (when (if (stringp foo)
                          (or (string= foo "**")
                              (string= foo "*"))
                          (memq  foo '(:wild-inferiors :wild)))
                    (return))
                  (setq n (+ n 1)))
                (setq newpath
                      (make-pathname :host (car host)
                                     :directory (cons (car path-dir)
                                                      (nconc lhs-part
                                                             (nthcdr n (cdr path-dir))))
                                     :name (pathname-name path)
                                     :type (pathname-type path)))))))
          (return-from back-translate-pathname-1 
            (if  (equalp path newpath) path (back-translate-pathname-1 newpath)))))))
  path)
|#

(defun back-translate-pathname-1 (path &optional hosts)
  (let ((*use-namestring-caches* nil))
    (dolist (host %logical-host-translations%)
      (when (or (null hosts) (member (car host) hosts :test 'string-equal))
        (dolist (trans (cdr host))
          (when (pathname-match-p path (cadr trans))
            (let* (newpath)          
              (setq newpath (translate-pathname path (cadr trans) (car trans) :reversible t))
              (return-from back-translate-pathname-1 
                (if  (equalp path newpath) path (back-translate-pathname-1 newpath hosts))))))))
    path))



; must be after back-translate-pathname
(defun physical-pathname-p (path)
  (let* ((path (pathname path))
         (dir (pathname-directory path)))
    (and dir
         (or (not (logical-pathname-p path))
             (not (null (memq (pathname-host path) '(nil :unspecific))))))))



;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;File or directory Manipulations

;This does a rename or a move as appropriate.  Doesn't handle a combination
;of the two, though it should.
; this can nuke a directory (should it?)
#+ignore
(defun rename-file (old-path new-path &key (if-exists :error)
                             &aux old-true-path new-true-path orig-new-path errno dirp)
  (setq dirp (directory-pathname-p old-path))
  (when (and (pathname-host new-path)) ;(not (pathname-host old-path)))
    (setq old-path (full-pathname old-path) new-path (full-pathname new-path)))  
  ;; added above 07/16/01 - else merge-pathnames below is nonsense if new-path has a host and old-path does not
  (setq orig-new-path (setq new-path (merge-pathnames new-path old-path)))   
  (when dirp
    (setq old-path (dirpath-to-filepath old-path))
    (when (not (directory-pathname-p new-path))
      (signal-file-error $xrenamedir new-path))
    (setq new-path (dirpath-to-filepath orig-new-path)))
  (%stack-iopb (npb nnp)
    (%stack-iopb (opb onp)
      (%path-to-iopb old-path opb :errchk)
      (when (neq (%ilogbitp $ioDirFlg (%get-byte opb $ioFlAttrib)) dirp)
        (signal-file-error $xdirnotfile old-path))
      ;(%put-word opb 0 $ioFDirIndex)
      ;(file-errchk (#_PBGetCatInfoSync old-path :a0 opb))
      (%put-long opb (%get-long opb $ioFlParID) $ioDirID)
      (setq old-true-path (%path-from-iopb opb)) ;; (%path-from-iopb opb :errchk)) - bogus call
      (when dirp (setq old-true-path (filepath-to-dirpath old-true-path)))
      (prog ()
        new-path 
        (%path-to-iopb new-path npb :errchk nil t) ; Bug was here
        (unless (eq (%get-word opb $ioVRefNum)(%get-word npb $ioVRefNum))
          ;;; used to be error
          (setq new-true-path (nth-value 2 (copy-file old-true-path new-path)))
          (delete-file old-true-path)
          (return-from rename-file (values orig-new-path old-true-path new-true-path)))
        (if (and (eql (%get-long opb $ioDirID) (%get-long npb $ioDirID)))
          (progn
            (%put-ptr opb nnp $ioNewName)
            (setq errno (#_PBHRenameSync opb))
            (cond ((eq errno $dupFNErr)
                   (unless (eq if-exists :supersede)
                     (unless (setq new-path (if-exists if-exists (%path-from-iopb npb)))
                       (return-from rename-file nil))
                     (setq if-exists :supersede)
                     (go new-path))
                   (setq errno (#_PBHDeleteSync npb))
                   (when (zerop errno)
                     (setq errno (#_PBHRenameSync opb)))
                   (unless (zerop errno)
                     (signal-file-error errno (%path-from-iopb npb))))
                  ((not (zerop errno))  ;; forgot to do this
                   (signal-file-error errno (%path-from-iopb npb)))))
          (let ((tem-path (probe-file new-path)))
            (when tem-path
              (cond 
               ((neq if-exists :supersede)
                (unless (setq new-path (if-exists if-exists tem-path))
                  (return-from rename-file nil))
                (setq if-exists :supersede)
                (go new-path))
               (t (file-errchk (#_PBHDeleteSync npb) new-path))))
            (%put-long opb (%get-long npb $ioDirID) $ioNewDirID)
            (%put-ptr opb (%null-ptr) $ioNewName)
            (setq errno (#_PBCatMoveSync opb))
            (cond 
             ((eq errno $dupFNErr) ; this happens if old name exists in new dir
              (setq tem-path (gen-file-name old-true-path))
              (rename-file old-true-path tem-path) ;give it a funny name in current dir
              (setq new-true-path (nth-value 2 (rename-file tem-path new-path)))
              (return))
             ((not (%izerop errno)) (signal-file-error errno new-path)))
            (when (not (string-equal (%get-string onp)(%get-string nnp)))
              (setq new-true-path
                    (nth-value 2 (rename-file (make-pathname 
                                               :directory (pathname-directory (full-pathname new-path :no-error nil))
                                               :name (pathname-name old-true-path)
                                               :type (pathname-type old-true-path)
                                               :defaults nil)
                                              new-path)))
              (return))))
        (%put-ptr npb nnp $ioFileName)
        (setq new-true-path (%path-from-iopb npb)))
      (when dirp (setq new-true-path (filepath-to-dirpath new-true-path)))
      (values orig-new-path old-true-path new-true-path))))




(defun rename-file (old-path new-path &key (if-exists :error))
  (let* ((old-true-path (truename old-path)) ;; it must exist and resolve aliases etc.
         (new-full-path (full-pathname new-path))
         (old-full-path (full-pathname old-path))
         (dirp (directory-pathname-p old-true-path))
         (orig-new-path new-path)
         new-true-path errno new-dirp new-dir same-dirp)
    (setq new-full-path (merge-pathnames new-full-path old-full-path))    
    (let ((maybe-new-true-path (probe-file new-full-path)))
      (cond (maybe-new-true-path             
             (cond ((memq if-exists '(:supersede :overwrite))
                    (setq new-dirp (directory-pathname-p maybe-new-true-path))
                    (if (neq dirp new-dirp) (error "Cant rename file to directory or vv."))
                    (delete-file-truename maybe-new-true-path)  ; some might wish this happened after more error checks
                    (setq new-full-path maybe-new-true-path))        
                   (t (setq maybe-new-true-path (if-exists if-exists maybe-new-true-path))
                      (when (null maybe-new-true-path) (return-from rename-file nil))
                      (setq new-full-path maybe-new-true-path)
                      (setq new-dirp (directory-pathname-p new-full-path)))))             
            (t  (setq new-dirp (directory-pathname-p new-full-path)))) 
      (if (neq dirp new-dirp) (error "Cant rename file to directory or vv.")))
    (when (not dirp)  ;; i.e. renaming a file
      (let ()
        (if (not (equalp (pathname-directory old-full-path) (pathname-directory new-full-path)))
          ;; does the new dir exist when the destination is a file in new-dir which ain't old dir?
          (progn                 ;; make sure new-dir exists
            (setq new-dir (truename (make-pathname :directory  (pathname-directory new-full-path) :defaults nil)))
            (setq new-full-path (merge-pathnames new-dir new-full-path)) 
            (setq same-dirp (equalp (pathname-directory old-full-path)(pathname-directory new-dir)))  ;; fix alias bug?
            )
          (progn
            (setq same-dirp t)
            ))))
    ;;3 cases 1. same dir new name 2. different dir and maybe different name  3. rename dir
    (cond 
     (same-dirp  ;; only true for files with names - may be missing some alias issues here
      (rlet ((fsref :fsref)
             (newref :fsref))
        (let ((what (make-fsref-from-path-simple old-true-path fsref)))
          (if (null what)(error "phooey")))
        (let ((name&type (file-namestring new-full-path)))
          (remove-path-from-hashes old-true-path)
          (fs-rename-last fsref newref name&type new-full-path)          
          (setq new-true-path (%path-from-fsref newref))
          (values orig-new-path old-true-path new-true-path))))
     ((and (not dirp)(not same-dirp))   ;; move a file to a different dir if name same, else do two renames or maybe copy and delete
      (let ((old-name&type (file-namestring old-true-path))
            (new-name&type (file-namestring new-full-path)))
        (when (not new-dir)(setq new-dir (make-pathname :directory  (pathname-directory new-full-path) :defaults nil)))
        (cond ((string-equal old-name&type new-name&type)
               (rlet ((fsref :fsref)
                      (dirref :fsref)
                      (newref :fsref))
                 (let ((what (make-fsref-from-path-simple old-true-path fsref)))
                   (if (null what)(error "phooey"))
                   (setq what (make-fsref-from-path-simple 
                               new-dir
                               dirref))
                   (if  (null what) (signal-file-error #$fnferr new-dir))  ;; dirnferr doesn't say the name
                   (remove-path-from-hashes old-true-path)                   
                   (setq errno (#_FSMoveObject fsref dirref newref))
                   (cond ((neq errno #$noerr) (signal-file-error errno new-dir)))
                   (setq new-true-path (%path-from-fsref newref)))))
              (t (let ((new-dir-old-name (merge-pathnames old-name&type new-dir)))
                   (cond ((probe-file new-dir-old-name)
                          (setq new-true-path (nth-value 2 (copy-file old-true-path new-full-path)))
                          (delete-file old-true-path))
                         (t (rename-file old-true-path new-dir-old-name) ;; move to new dir with old name
                            (rename-file new-dir-old-name new-full-path) ;; then put new name in new dir
                            (setq new-true-path new-full-path)))))))
        (values orig-new-path old-true-path new-true-path))
     ((and dirp new-dirp) (rename-directory old-true-path new-full-path orig-new-path))
     (t (error "Illegal args to rename-file ~s ~S" old-path orig-new-path)))))      



#| ;; or like this - what does case independence mean in unicode?? 
(defmethod string-string-equal ((x encoded-string)(y encoded-string))
  (equalp x y)) ;; (string-equal (the-string x)(the-string y)))
(defmethod string-string-equal ((x encoded-string) y)
  (string-equal (the-string x) (convert-string y #$kCFStringEncodingMacRoman (the-encoding x))))
(defmethod string-string-equal ((x t) (y encoded-string))
  (string-equal (convert-string x  #$kCFStringEncodingMacRoman (the-encoding y)) (the-string y)))
(defmethod string-string-equal ((x t)(y t))
  (string-equal x y))
|#



(defun directory-less-last (full-pathname)
  (let ((dir (pathname-directory full-pathname)))
    (if (<= (length dir) 2)
      nil
      (values (make-pathname :directory (butlast dir 1) :name nil :type nil :defaults nil)
              (car (last dir))))))


(defun rename-directory (old-true-path new-full-path orig-new-path)
  ;; we know old exists and new does not
  (multiple-value-bind (old-top old-last) (directory-less-last old-true-path)
    (declare (ignore-if-unused old-last))
    (multiple-value-bind (new-top new-last) (directory-less-last new-full-path)
      (when (and (null new-top)(null old-top))
        (return-from rename-directory (rename-volume old-true-path new-full-path orig-new-path)))
      (WHEN (OR (NULL NEW-TOp)(null old-top))
        (error "bad args to rename ~s ~s" old-true-path new-full-path))
      (setq new-top (truename new-top)) ;; assure exists and resolve aliases      
      (if (not (equalp (pathname-directory old-top) (pathname-directory new-top)))
        ;; need to do #_fsmoveobject of something
        (rlet ((srcref :fsref)
               (destref :fsref)
               (newref :fsref))
          (path-to-fsref old-true-path srcref)
          (path-to-fsref new-full-path destref)
          (errchk (#_fsmoveobject srcref destref newref))
          (values orig-new-path old-true-path (%path-from-fsref newref)))
        (let ()
          (rlet ((fsref :fsref)
                 (newref :fsref))
            (let ((what (make-fsref-from-path-simple old-true-path fsref)))
              (if (null what)(error "phooey")))
            (let (new-true-path)
              (remove-path-from-hashes old-true-path)
              (fs-rename-last fsref newref new-last new-full-path)
              (setq new-true-path (%path-from-fsref newref))
              (values orig-new-path old-true-path new-true-path))))))))

(defun fs-rename-last (fsref newref new-last new-full-path)   
  (let (tail errno)
    (setq new-last (%file-system-string new-last)) ;(%path-std-quotes new-last "" "") ;; ??
    (setq tail (get-unicode-string new-last))
    (let ((len (length tail)))
      (%stack-block ((ustr (+ len len)))
        (dotimes (i len)
          (%put-word ustr (%scharcode tail i) (+ i i)))                
        (setq errno (#_FSRenameUnicode fsref len ustr #$kTextEncodingUnknown newref)) ;; what is textencodinghint?
        (cond ;((eq errno $dupFNErr)(error "shouldn't"))
              ((neq errno #$noErr)(signal-file-error errno new-full-path))))))) 

;; beware renaming boot volume
(defun rename-volume (old new orig-new-path)
  (rlet ((fsref :fsref)
         (new-fsref :fsref))
    (let ((what (make-fsref-from-path-simple old fsref)))
      (if (null what)(error "phooey"))
      (let ()
        (fs-rename-last fsref new-fsref (second (pathname-directory new)) new)        
        (SETQ *GOT-BOOT-DIRECTORY* NIL)   ;; YECH - maybe recompute it
        (setq new (%path-from-fsref new-fsref))
        (values orig-new-path old new)))))
      
;#+ignore
(defrecord FSCatalogInfo 
   (nodeFlags :UInt16)    	           	;   node flags  
   (volume :Sint16)         	            	;   object's volume ref  
   (parentDirID :UInt32)	                ;   parent directory's ID  
   (nodeID :UInt32)      	                ;   file/directory ID  
   (sharingFlags :UInt8) 	                ;   kioFlAttribMountedBit and kioFlAttribSharePointBit  
   (userPrivileges :UInt8)	                ;   user's effective AFP privileges (same as ioACUser)  
   (reserved1 :UInt8)
   (reserved2 :UInt8)
   (createDate :utcdatetime)                    ;   date and time of creation  
   (contentModDate :utcdatetime)                ;   date and time of last fork modification  
   (attributeModDate :utcdatetime)              ;   date and time of last attribute modification  
   (accessDate :utcdatetime)                    ;   date and time of last access (for Mac OS X)  
   (backupDate :utcdatetime)                    ;   date and time of last backup  
   (permissions (:array :UInt32 4)) 	        ;   permissions (for Mac OS X)  
   (finderInfo :fileinfo)            ; was (:array :UInt8 16));   Finder information part 1 <<<<< 
   (extFinderInfo :extendedfileinfo) ; (:array :UInt8 16));   Finder information part 2  
   (dataLogicalSize :unsignedwide)              ;   files only  
   (dataPhysicalSize :unsignedwide)             ;   files only  
   (rsrcLogicalSize :unsignedwide)              ;   files only  
   (rsrcPhysicalSize :unsignedwide)             ;   files only  
   (valence :UInt32)                    	;   folders only  
   (textEncodingHint :Uint32)
   )
 

(defun copy-file (old-path new-path &key (if-exists :error) fork (blocksz 8192)
                           finder-comment-p
                           &aux true-new-path 
                           finder-info-p)
  
  (unless fork (setq fork :both))
  (unless (memq fork '(:both :data :resource))
    (report-bad-arg fork '(member :both :data :resource nil)))
  ;(setq both-forks-p (eq fork :both))
  (setq old-path (full-pathname old-path))
  (if (directory-pathname-p old-path) (signal-file-error $xnocopydir old-path))
  (setq new-path (merge-pathnames (translate-logical-pathname new-path) old-path))
  (rletz ((srcfsref :fsref)
          (dstfsref :fsref)
          (srccat :fscataloginfo)
          (dstcat :fscataloginfo))
    (multiple-value-bind (found-fsref dirflg is-alias)(path-to-fsref old-path srcfsref)
      (when (null found-fsref) (signal-file-error $fnferr old-path))
      (when dirflg 
        (if is-alias
          (signal-file-error $xnocopydir (%path-from-fsref found-fsref))
          ;; shouldn't happen?
          (signal-file-error #$fnferr old-path))))
    (fsref-get-cat-info srcfsref srccat (logior #$kFSCatInfoNodeFlags #$kFSCatInfoFinderInfo #$kFSCatInfoAllDates))
    (let ((file-type (pref srccat :FSCataloginfo.FinderInfo.filetype))
          (file-creator (pref srccat :FSCataloginfo.FinderInfo.filecreator))
          (write-date (pref srccat :FSCataloginfo.contentModDate))
          (create-date (pref srccat :FSCataloginfo.createDate))
          (bits (pref srccat :fscataloginfo.nodeflags)))
      (when (neq 0 (logand bits (logior #$kfsNodeLockedMask)))
                                        #|
                                        (if (eq fork :both)
                                          #$kfsNodeForkOpenMask  ;; open for reading should be OK - but writing bad??
                                          (if (eq fork :data)
                                            #$kFSNodeDataOpenMask
                                            #$kFSNodeResOpenMask))
                                            )))   ;; $kFSNodeCopyProtectMask ?
                                           |#
        (error "file ~S is locked" old-path))
      ;(setq new-path (merge-pathnames new-path old-path))
      (setq true-new-path 
            (or (and (neq fork :both) 
                     (probe-file new-path))
                (progn
                  (setq finder-info-p t)
                  (create-file new-path :if-exists if-exists :mac-file-type file-type :mac-file-creator file-creator))))
      #+ignore
      (if (neq fork :resource)
        (setq true-new-path (create-file new-path :if-exists if-exists :mac-file-type file-type :mac-file-creator file-creator))
        (when (not (setq true-new-path (probe-file new-path)))
          (setq true-new-path (create-file new-path :if-exists if-exists :mac-file-type file-type :mac-file-creator file-creator))))
      (path-to-fsref true-new-path dstfsref)
      (when (memq fork '(:data :both))
        (%copy-fork2 srcfsref dstfsref nil nil blocksz))
      (when (memq fork '(:resource :both))
        (%copy-fork2 srcfsref dstfsref t t blocksz))
      ;(fsref-get-catinfo dstfsref dstcat #$kFSCatGettableInfo)  ;; not needed ??
      (when finder-info-p
        (setf (pref dstcat :FSCataloginfo.FinderInfo.filetype) file-type)
        (setf (pref dstcat :FSCataloginfo.FinderInfo.filecreator) file-creator)
        (setf (pref dstcat :FSCataloginfo.contentModDate) write-date)
        (setf (pref dstcat :FSCataloginfo.createDate) create-date)
        (fsref-set-cat-info dstfsref dstcat (logior  #$kFSCatInfoFinderInfo #$kFSCatInfoContentMod  #$kFSCatInfoCreateDate)))
      (when finder-comment-p
        ;; note - won't work for non roman pathnames
        (set-finder-comment true-new-path (get-finder-comment old-path)))
      (flush-volume true-new-path)  ;; ?? need for the catinfo ?
      (values new-path old-path true-new-path))))

(defun %copy-fork2 (srcfsref dstfsref src-resflag dst-resflag blocksz)
  (let ((src-fname (if src-resflag (resource-fork-name) (data-fork-name)))
        (dst-fname (if dst-resflag (resource-fork-name) (data-fork-name)))
        source-opened dest-opened)
    (%stack-block ((buf blocksz))
      (rlet ((srcpb :FSForkIOParam)
             (dstpb :FSForkIOParam))
        (setf (pref srcpb :FSForkIOParam.buffer) buf
              (pref dstpb :FSForkIOParam.buffer) buf)
        (setf (pref srcpb :FSForkIOParam.ref) srcfsref
              (pref srcpb :FSForkIOParam.permissions) #$fsRdPerm)
        (setf (pref srcpb :FSForkIOParam.forkNameLength)  (pref src-fname :hfsunistr255.length) 
              (pref srcpb :FSForkIOParam.forkName)       (pref src-fname :hfsunistr255.unicode))
        (setf (pref dstpb :FSForkIOParam.ref) dstfsref
              (pref dstpb :FSForkIOParam.permissions) #$fsWrPerm)
        (setf (pref dstpb :FSForkIOParam.forkNameLength)  (pref dst-fname :hfsunistr255.length) 
              (pref dstpb :FSForkIOParam.forkName)       (pref dst-fname :hfsunistr255.unicode))
        ;(setf (pref dstpb :FSForkIOParam.positionmode) #$fsfromstart)
        (unwind-protect
          (progn
            (errchk (#_PBOpenForkSync srcpb))
            (setq source-opened t)
            (errchk (#_PBGetForkSizeSync srcpb))
            (errchk (#_PBOpenForkSync dstpb))
            (setq dest-opened t)            
            (let ((reslen (unsignedwide->integer (pref srcpb :FSForkIOParam.positionOffset))))
              (setf (pref dstpb :FSForkIOParam.positionOffset.hi) (ldb uw-hi reslen)
                    (pref dstpb :FSForkIOParam.positionOffset.lo) (ldb uw-lo reslen))
              (errchk (#_PBSetForkSizeSync dstpb))              
              (setf (pref srcpb :FSForkIOParam.positionOffset.hi) 0
                    (pref srcpb :FSForkIOParam.positionOffset.lo) 0
                    (pref dstpb :FSForkIOParam.positionOffset.hi) 0 
                    (pref dstpb :FSForkIOParam.positionOffset.lo) 0                    
                    (pref srcpb :FSForkIOParam.positionMode) #$fsFromStart
                    (pref dstpb :FSForkIOParam.positionMode) #$fsFromStart                    
                    (pref srcpb :FSForkIOParam.requestCount) blocksz
                    (pref dstpb :FSForkIOParam.requestCount) blocksz)
              (errchk (#_PBSetForkPositionSync srcpb)) ; Carbon is weird. You didn't have to do this before.
              (errchk (#_PBSetForkPositionSync dstpb)) ; Bottom line: positionOffset is not necessarily the same thing as position.
              (setf (pref srcpb :FSForkIOParam.positionMode) #$fsAtMark ; Ditto
                    (pref dstpb :FSForkIOParam.positionMode) #$fsAtMark)
              (let ()                
                (while (> reslen blocksz)
                  (errchk (#_PBReadForkSync srcpb))
                  (errchk (#_PBWriteForkSync dstpb))           
                  (setq reslen (- reslen blocksz)))
                (unless (zerop reslen)
                  (setf (pref srcpb :FSForkIOParam.requestCount) reslen)
                  (setf (pref dstpb :FSForkIOParam.requestCount) reslen)
                  (errchk (#_PBReadForkSync srcpb))
                  (errchk (#_PBWriteForkSync dstpb))))))
          (if source-opened (errchk (#_PBCloseForkSync srcpb)))
          (if dest-opened (errchk (#_PBCloseForkSync dstpb)))))    
      )))




; Return the Finder comment of a file or NIL if it doesn't have one.

#|
(defun get-finder-comment (path)
  #+interfaces-3 ;; need new headers
  (%stack-iopb (pb np)
    (when (zerop (%path-to-iopb path pb))
      (let ((vrefnum (pref pb :CInfoPBRec.dirinfo.ioVRefNum))
            (dirid (pref pb :CInfoPBRec.hfileinfo.ioDirID)))  ;; ??
        (rlet ((dtpb :DTPBRec
                     :ioNamePtr (%null-ptr)
                     :ioVRefnum vrefnum))
          (%stack-block ((comment 200))
            (when (eql 0 (#_PBDTGetPath dtpb))
              (setf (pref dtpb :DTPBRec.ioNamePtr) np
                    (pref dtpb :DTPBRec.ioDirID) dirid
                    (pref dtpb :DTPBRec.ioDTBuffer) comment
                    (pref dtpb :DTPBRec.ioDTReqCount) 200) ; SVS. Gotta do this.)
              (when (eql 0 (#_PBDTGetCommentSync dtpb))
                (%str-from-ptr comment (pref dtpb :DTPBRec.ioDTActCount))))))))))
|#

;; this gets the OS9 finder comment as does above - whoopee
;; no good if comment is Chinese - etc
(defun get-finder-comment (path) 
  (rlet ((fsref :fsref)
         (catinfo :fscataloginfo))
    (setq path (truename path))
    (let ((name (mac-file-namestring path)))
      (path-to-fsref path fsref)
      (fsref-get-cat-info fsref catinfo)
      (let ((vrefnum (pref catinfo :fscataloginfo.volume))
            (dirid (pref catinfo :fscataloginfo.parentdirid)))
        (with-pstrs ((np name))
          (rlet ((dtpb :DTPBRec
                       :ioNamePtr (%null-ptr)
                       :ioVRefnum vrefnum))
            (%stack-block ((comment 200))
              (when (eql 0 (#_PBDTGetPath dtpb))
                (setf (pref dtpb :DTPBRec.ioNamePtr) np
                      (pref dtpb :DTPBRec.ioDirID) dirid
                      (pref dtpb :DTPBRec.ioDTBuffer) comment
                      (pref dtpb :DTPBRec.ioDTReqCount) 200) ; SVS. Gotta do this.)
                (when (eql 0 (#_PBDTGetCommentSync dtpb))
                  (%str-from-ptr comment (pref dtpb :DTPBRec.ioDTActCount)))))))))))

; Set the finder comment of a file.
; If comment is NIL, remove the finder comment

#|
(defun set-finder-comment (path comment)
  #+interfaces-3 ;; need new headers
  (%stack-iopb (pb np)
    (when (zerop (%path-to-iopb path pb))
      (let ((vrefnum (pref pb :CInfoPBRec.dirinfo.ioVRefNum))
            (dirid (pref pb :CInfoPBRec.hfileinfo.ioDirID)))  ;; ??
        (rlet ((dtpb :DTPBRec
                     :ioNamePtr (%null-ptr)
                     :ioVRefnum vrefnum))
          (when (eql 0 (#_PBDTGetPath dtpb))
            (setf (pref dtpb :DTPBRec.ioNamePtr) np
                  (pref dtpb :DTPBRec.ioDirID) dirid)
            (if comment
              (with-cstrs ((comment-ptr comment))
                (setf (pref dtpb :DTPBRec.ioDTBuffer) comment-ptr
                      (pref dtpb :DTPBRec.ioDTReqCount) (length comment))
                (when (eql 0 (#_PBDTSetCommentSync dtpb))
                  comment))
              (eql 0 (#_PBDTRemoveCommentSync dtpb)))))))))
|#

(defun set-finder-comment (path comment)
  (rlet ((fsref :fsref)
         (catinfo :fscataloginfo))
    (setq path (truename path))
    (let ((name (mac-file-namestring path)))
      (path-to-fsref path fsref)
      (fsref-get-cat-info fsref catinfo)
      (let ((vrefnum (pref catinfo :fscataloginfo.volume))
            (dirid (pref catinfo :fscataloginfo.parentdirid)))
        (with-pstrs ((np name))
          (rlet ((dtpb :DTPBRec
                       :ioNamePtr (%null-ptr)
                       :ioVRefnum vrefnum))
            (when (eql 0 (#_PBDTGetPath dtpb))
              (setf (pref dtpb :DTPBRec.ioNamePtr) np
                    (pref dtpb :DTPBRec.ioDirID) dirid)
              (if comment
                (with-cstrs ((comment-ptr comment))
                  (setf (pref dtpb :DTPBRec.ioDTBuffer) comment-ptr
                        (pref dtpb :DTPBRec.ioDTReqCount) (length comment))
                  (when (eql 0 (#_PBDTSetCommentSync dtpb))
                    comment))
                (eql 0 (#_PBDTRemoveCommentSync dtpb))))))))))


  


;#+new-files
(progn
(defun lock-file (path)
  (when (directory-pathname-p path) (signal-file-error $err-no-file path))
  (rlet ((fsref :fsref))
    (multiple-value-bind (res dirflg)(path-to-fsref path fsref)
      (if (or (null res) dirflg) (signal-file-error $err-no-file path))
      ;; see fsref-node-bits
      (rlet ((cat-info :fscataloginfo))
        (fsref-get-cat-info fsref cat-info #$kFSCatInfoNodeFlags)
        (let ((poo (logior #$kFSNodeLockedMask (pref cat-info :fscataloginfo.nodeflags))))
          (setf (pref cat-info :fscataloginfo.nodeflags) poo)
          (fsref-set-cat-info fsref cat-info #$kFSCatInfoNodeFlags)))
      ;(%path-from-fsref fsref)  ;; nobody needs this today
      path
      )))

(defun unlock-file (path)
  (when (directory-pathname-p path) (signal-file-error $err-no-file path))
  (rlet ((fsref :fsref))
    (multiple-value-bind (res dirflg)(path-to-fsref path fsref)
      (if (or (null res) dirflg) (signal-file-error $err-no-file path))
      (unlock-file-fsref fsref)     
      ;(%path-from-fsref fsref)  ;; not needed
      path)))

(defun lock-file-fsref (fsref)
  (rlet ((cat-info :fscataloginfo))
    (fsref-get-cat-info fsref cat-info #$kFSCatInfoNodeFlags)
    (let ((poo (logior #$kFSNodeLockedMask (pref cat-info :fscataloginfo.nodeflags))))
      (setf (pref cat-info :fscataloginfo.nodeflags) poo)
      (fsref-set-cat-info fsref cat-info #$kFSCatInfoNodeFlags))))

(defun unlock-file-fsref (fsref)
  (rlet ((cat-info :fscataloginfo))
    (fsref-get-cat-info fsref cat-info #$kFSCatInfoNodeFlags)
    (let ((poo (bitclr  #$kFSNodeLockedBit (pref cat-info :fscataloginfo.nodeflags))))
      (setf (pref cat-info :fscataloginfo.nodeflags) poo)
      (fsref-set-cat-info fsref cat-info #$kFSCatInfoNodeFlags))))  
  

#|
;; this does not work
(defun close-file (path)
  (let ((fname (data-fork-name)))
    (rletz ((fsref :fsref)
            (paramblock :fsforkioparam))
      (multiple-value-bind (res dirflg)(path-to-fsref path fsref)
        (if (or (null res) dirflg) (signal-file-error $err-no-file path))
        (setf (pref paramblock :FSForkIOParam.ref) fsref
              (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)
              (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode))
        (let ((res (#_pbcloseforksync paramblock)))
          (unless (eql #$noerr res)
            (signal-file-error res path))
          (%path-from-fsref fsref))))))
|#
  

)





;#+new-files
(defun create-directory (path &key (if-exists :error) &aux errno full-path)
  ;; don't get name or type from defaults - from *default-pathname-defaults* haters anonymous
  (let* ((orig-defaults *default-pathname-defaults*)
         (*default-pathname-defaults* 
          (if (and orig-defaults (or (pathname-name orig-defaults)(pathname-type orig-defaults)))
            (make-pathname :type nil :name nil :defaults orig-defaults)
            orig-defaults)))
    (setq full-path (full-pathname path :no-error nil)))  
  (when (directory-pathname-p full-path)
    (let ((fp (dirpath-to-filepath full-path
                                   (or (null if-exists)
                                       (eq if-exists :no-error)))))
      (if (null fp) (return-from create-directory nil))      
      (setq full-path fp)))  
  (when (and (not (eq if-exists :error))  ; the if-exists :error case is caught elsewhere
             (not (directory-pathname-p path))
             (probe-file full-path))
    (error "~s is the name of a file. Can't create a directory of the same name." path))
  (let* ((parent-dir (make-pathname :directory (pathname-directory full-path) :defaults nil))
         (*default-pathname-defaults* nil)
         (parent-exists (probe-file parent-dir)))
      (when (not parent-exists)
        (setq parent-dir (create-directory parent-dir :if-exists if-exists))
        (when (not parent-dir) (error "Huh")))
      (rlet ((parentref :fsref)
             (newref :fsref)
             (newdirid :unsigned-long))
        (multiple-value-bind (RES IS-DIR)(path-to-fsref parent-dir parentref)        
          (cond ((null res)
                 (error "didnt we already do this?"))
                ((null is-dir) (error "phooey")))
          (let ((name&type (file-namestring full-path)))
            ;; remove escapes??
            (setq name&type (%file-system-string name&type)) ;(%path-std-quotes name&type "" ""))
            (setq name&type (get-unicode-string name&type))
            (let ((len (length name&type)))
              (%stack-block ((ustr (+ len len)))
                (dotimes (i len)
                  (%put-word ustr (%scharcode name&type i) (+ i i)))
                (prog ()
                  agin
                  (setq errno (#_fsCreateDirectoryUnicode parentref len ustr 0 (%null-ptr) newref (%null-ptr) newdirid))
                  (cond ((eq errno $dupFNErr)                     
                         (when (null if-exists)
                           (return-from create-directory nil))
                         (cond ((eq if-exists :supersede)
                                (delete-file full-path)
                                (go agin))
                               (t (let ((new-path (if-exists if-exists full-path "CreateÉ")))
                                    (if (null new-path)
                                      (return-from create-directory nil)
                                      (if (equalp new-path full-path)
                                        (progn (delete-file full-path)
                                               (go agin))
                                        (return-from create-directory (create-directory new-path :if-exists if-exists))))))))
                        ((neq errno #$noerr)
                         (signal-file-error errno path)))))
              (%path-from-fsref newref t)))))))
      





(defun dirpath-to-filepath (path &optional no-error)
  (let* ((path (translate-logical-pathname path))
         (dir (pathname-directory path))
         (super (butlast dir))
         (name (car (last dir))))
    (when (eq name ':up)
      (setq dir (remove-up (copy-list dir)))
      (setq super (butlast dir))
      (setq name (car (last dir))))
    (cond ((not (or (null super)
                    (and (eq (car super) ':absolute)
                         (null (%cdr super)))))
           (make-pathname :directory super :name name :TYPE :UNSPECIFIC :defaults nil))
          ((and no-error (probe-file (make-pathname :directory dir :name :unspecific :type :unspecific :defaults nil)))
           nil)
          (t (signal-file-error $xnocreate path)))))

; nobody seems to be calling this any more
(defun filepath-to-dirpath (path)
  (let* ((dir (pathname-directory path))         
         (rest (file-namestring path)))
    (make-pathname :directory (append dir (list rest)) :name :unspecific :type :unspecific :defaults nil)))


;; from kab - ANSI thing
(defun ensure-directories-exist (filespec &key verbose)
  (declare (ignore verbose))
  (values filespec
          ;; Ensure that the pathname being used contains a null name and
          ;; type, i.e. it is a directory path.  Do that after translation,
          ;; in case there are translations that map particular file names
          ;; or (more likely) types to specific locations and the filespec
          ;; matches one of those translations.
          (ccl:create-directory
                 (make-pathname :defaults (translate-logical-pathname filespec)
                                :name :unspecific
                                :type :unspecific)
                 :if-exists nil)))



  

;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;Volume manipulation

;Actually, puts dir name, unless too long.
(defun %put-volume-name (ptr path)
  (setq path (mac-directory-namestring path))
  (when (%i> (length path) 255)
    (setq path (%substr path 0 (1+ (%str-member #\: path))))
    (when (%i> (length path) 255) (signal-file-error $nsvErr path)))  
  (%put-string ptr path))

;; we hope nobody uses this
(defun hfs-volume-p (path)
  (%stack-iopb (pb np)
    (%put-volume-name np path)
    (%put-word pb (if (%izerop (%get-byte np)) 0 -1) $ioVolIndex)
    (%put-word pb 0 $ioVRefNum)
    (file-errchk (#_PBHGetVInfoSync pb) path)
    (eq (%get-word pb $ioVSigWord) #x4244)))

#|
(defun drive-number (path)
  (%stack-iopb (pb np)
    (%put-volume-name np path)
    (%put-word pb (if (%izerop (%get-byte np)) 0 -1) $ioVolIndex)
    (%put-word pb 0 $ioVRefNum)
    (file-errchk (#_PBHGetVInfoSync pb) path)
    (%get-signed-word pb $ioVDrvInfo)))
|#

(defun drive-number (path)
  (let ((vrefnum (volume-number path)))
    (rletZ ((vinfosub :fsvolumeinfo)
            (volinfo :fsvolumeinfoparam))
      (setf (pref volinfo :fsvolumeinfoparam.iovrefnum) vrefnum)
      (setf (pref volinfo :fsvolumeinfoparam.volumeindex) 0)
      (setf (pref volinfo :fsvolumeinfoparam.whichinfo) #$kFSVolInfoDriveinfo)
      (setf (pref volinfo :fsvolumeinfoparam.volumename) (%null-ptr))
      (setf (pref volinfo :fsvolumeinfoparam.volumeinfo) vinfosub)
      (file-errchk (#_PBGetVolumeInfoSync volinfo) path)
      (pref vinfosub :fsvolumeinfo.drivenumber))))
      

(defun old-volume-number (path-or-num)  
  (%stack-iopb (pb np)
    (etypecase path-or-num
      ((or pathname string)
       (when (directory-pathname-p path-or-num)
         (%put-volume-name np path-or-num)
         (%put-word pb (if (%izerop (%get-byte np)) 0 -1) $ioVolIndex)
         (%put-word pb 0 $ioVRefNum)
         (file-errchk (#_PBHGetVInfoSync pb) path-or-num)
         (%get-signed-word pb $ioVRefNum)))
      (fixnum
       (%put-word pb 0 $ioVolIndex)
       (%put-word pb path-or-num $ioVRefNum)
       (let ((errno (#_PBHGetVInfoSync pb)))
         (if (%izerop errno) path-or-num nil))))))


(defun volume-number (path-or-num)
  (cond 
   ((fixnump path-or-num)
    (old-volume-number path-or-num))
   ((directory-pathname-p path-or-num)  ;; true of "" - i.e. has no name or type
    (cond ((null (pathname-directory path-or-num))
           (old-volume-number path-or-num))
          (t 
           (let ((truename (truename path-or-num)))
             (rletZ ((fsref :fsref)
                     (cataloginfo :fscataloginfo))
               (make-fsref-from-path-simple truename fsref)
               (fsref-get-cat-info fsref cataloginfo #$kFSCatInfoVolume)
               (pref cataloginfo :FSCatalogInfo.volume))))))))
        


(export 'volume-free-space)

#+carbon-compat
;; there is a dohickey called fsvolumeinfo that has the right stuff
;; but I don't know how to get it
;; we have #_FSGetVolumeInfo which takes a pissload of arguments one of which is a ptr to fsvolumeinfo
;; ((volume :signed-integer)  ;; = vrefnum ?
;;       (volumeIndex :unsigned-long) 
;;       (actualVolume (:pointer :signed-integer)) 
;;       (whichInfo :unsigned-long) 
;;       (info (:pointer :fsvolumeinfo))
;;       (volumeName (:pointer :hfsunistr255)) 
;;       (rootDirectory (:pointer :fsref)))
;; we also have _PBGetVolumeInfoSync which takes one arg (:pointer :fsvolumeinfoparam)
;; which contains among other things a qlink which seems to be gonzo
;; this is likely more correct for HFS+ vols than the one below

(defun volume-free-space (path)
  "Returns the number of bytes free on the volume specified by PATH"
  (let ((volnum (volume-number path)))  
    (rlet ((vinfo :fsvolumeinfo))
      ;; seems to work
      (#_FSGetVolumeInfo 
       volnum  ;;  volume
       0       ;; volumeIndex
       (%null-ptr) ;; actualVolume
       #$kFSVolInfoSizes ;; whichinfo
       vinfo 
       (%null-ptr)
       (%null-ptr))
      ;; from the ridiculous to the sublime - initially 16 bits of blocks now 64 of totalbytes etal
      (values (unsignedwide->integer (pref vinfo :fsvolumeinfo.freebytes))
              (unsignedwide->integer (pref vinfo :fsvolumeinfo.totalbytes))))))
              


; allow negative numbers and this serves for volume-name as well
;; moved to l1-files
#|
(defun drive-name (number)
  (setq number (require-type number '(integer #x-8000 #x7fff)))
  (%stack-iopb (pb np)
    (%put-word pb 0 $ioVolIndex)
    (%put-word pb number $ioVRefNum)
    (errchk (#_PBHGetVInfoSync pb))
    (make-pathname :directory (%get-string np) :defaults nil)))
|#




(defun eject-disk (path-or-drive)
  (eject&unmount-disk path-or-drive))

(defun disk-ejected-p (path-or-drive)
  (%stack-iopb (pb np)
    (if (integerp path-or-drive)
      (progn
        ;(unless (< 0 path-or-drive #x8000) (report-bad-arg path-or-drive '(integer 1 #x7fff)))
        (%put-word pb 0 $ioVolIndex)
        (%put-word pb path-or-drive $ioVRefNum))
      (progn
        (%put-volume-name np path-or-drive)
        (%put-word pb (if (%izerop (%get-byte np)) 0 -1) $ioVolIndex)
        (%put-word pb 0 $ioVRefNum)))
    (errchk (#_PBHGetVInfoSync pb))
    (and (%izerop (%get-word pb $ioVDrvInfo))
         (%i< 0 (%get-signed-word pb $ioVDRefNum)))))


#|
;; jaguar only
(deftrap-inline "_FSUnmountVolumeSync"
  ((vrefnum :signed-integer) (flags :signed-integer) (dissenter :pointer))
  :osstatus
  ())
|#

#|
*  Discussion:
 *    This routine ejects the volume specified by vRefNum.  If the
 *    volume cannot be ejected the pid of the process which denied the
 *    unmount will be returned in the dissenter parameter.  This
 *    routine returns after the eject is complete.  Ejecting a volume
 *    will result in the unmounting of other volumes on the same device.


(deftrap-inline "_FSEjectVolumeSync"
  ((vrefnum :signed-integer) (flags :signed-integer) (dissenter :pointer))
  :osstatus
  ())
|#

#|
(defun eject&unmount-disk (path-or-drive)
  (%stack-iopb (pb np)
    (if (integerp path-or-drive)
      (progn
        ;(unless (< 0 path-or-drive #x8000) (report-bad-arg path-or-drive '(integer 1 #x7fff)))
        (%put-word pb 0 $ioVolIndex)
        (%put-word pb path-or-drive $ioVRefNum))
      (progn
        (%put-volume-name np path-or-drive)
        (%put-word pb (if (%izerop (%get-byte np)) 0 -1) $ioVolIndex)
        (%put-word pb 0 $ioVRefNum)))
    (errchk (#_PBHGetVInfoSync pb))      ; Just so we can report the truename...
    (prog1 (make-pathname  :directory (%get-string np) :defaults nil)
      #-CARBON-COMPAT ;; unmountvol does both in carbon
      (errchk (#_PBEject pb))
      (errchk (#_PBUnmountVol pb)))))
|#

(defun eject&unmount-disk (path-or-drive)
  (if (jaguar-p)
    (if (integerp path-or-drive)
      (prog1
        (drive-name path-or-drive)
        (errchk (#_fsejectvolumesync path-or-drive 0 (%null-ptr))))
      (let* ((truename (truename path-or-drive))
             (vnum (volume-number truename))) 
        (errchk (#_fsejectvolumesync vnum 0 (%null-ptr)))
        truename))
    (%stack-iopb (pb np)
      (if (integerp path-or-drive)
        (progn
          ;(unless (< 0 path-or-drive #x8000) (report-bad-arg path-or-drive '(integer 1 #x7fff)))
          (%put-word pb 0 $ioVolIndex)
          (%put-word pb path-or-drive $ioVRefNum))
        (progn
          (%put-volume-name np path-or-drive)
          (%put-word pb (if (%izerop (%get-byte np)) 0 -1) $ioVolIndex)
          (%put-word pb 0 $ioVRefNum)))
      (errchk (#_PBHGetVInfoSync pb))      ; Just so we can report the truename...
      (prog1 (make-pathname  :directory (%get-string np) :defaults nil)
        #-CARBON-COMPAT ;; unmountvol does both in carbon
        (errchk (#_PBEject pb))
        (errchk (#_PBUnmountVol pb))))))


  

#|
(defun flush-volume (path)
  (%stack-iopb (pb np)
    (%put-volume-name np (truename path))       ; truename resolves aliases
    (%put-word pb (if (%izerop (%get-byte np)) 0 -1) $ioVolIndex)
    (%put-word pb 0 $ioVRefNum)
    (errchk (#_PBHGetVInfoSync pb))     ; Just so we can report the truename...
    (errchk (#_PBFlushVolSync pb))
    #+ignore
    (when (bbox-p)  ;; this is horrible !!!  but seems to make a classic bug happen somewhat less frequently.
      (sleep 10))
    (%put-byte np (%i+ (%get-byte np) 1))   ; avoid a %str-cat later...
    (%put-byte np (%char-code #\:) (%get-byte np))
    (make-pathname :defaults  nil :directory (%get-string np))
    ))
|#

 ;; do this work?
(defun flush-volume (path)
  (setq path (truename path))
  (rlet ((fsref :fsref))
    (make-fsref-from-path-simple path fsref)
    (rlet ((vpb :VolumeParam))
      (let ((vnum (volume-from-fsref Fsref))) ; correct
        ;(break)
        (setf (pref vpb :VolumeParam.ioNamePtr) *null-ptr*
              (pref vpb :VolumeParam.ioVRefNum) vnum ; this works
              )
        (errchk (#_PBFlushVolSync vpb))))))


#|
(defun devices ()
  (%stack-iopb (pb np)
    (do ((index 1 (1+ index)) (result ()) errno)
        ((not (%izerop (setq errno (progn (%put-word pb index $ioVolIndex)
                                          (#_PBhGetVInfoSync pb)))))
         (if (eq errno $nsvErr) (nreverse result) (%err-disp errno)))
      (%put-byte np (%i+ (%get-byte np) 1))   ; avoid a %str-cat later...
      (%put-byte np (%char-code #\:) (%get-byte np))
      (push (make-pathname :directory (%get-string np)) result))))
|#

;Takes a pathname, returns the truename of the directory if the pathname
;names a directory, NIL if it names an ordinary file, error otherwise.
;E.g. (directoryp "ccl;:foo:baz") might return #P"hd:mumble:foo:baz:" if baz
;; we don;t use this
;is a dir. - should we doc this - its exported?

; This one behaves the same as MCL 5.0 except it never assumes the directory one level up
;   if you name a file or leave off the last colon.
(defun directoryp (path)
  (let ((fullname (translate-logical-pathname path )))
    (rlet ((fsref :fsref))
      (multiple-value-bind (out-fsref isdir) (path-to-fsref fullname fsref)
        (when isdir
          (%path-from-fsref out-fsref isdir)
          )))))

;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;Wildcards
(defun wild-pathname-p (pathname &optional field-key)
  (flet ((wild-p (name) (or (eq name :wild)
                            (eq name :wild-inferiors)
                            (and (stringp name) (%path-mem "*" name)))))
    (case field-key
      ((nil)
       (or (some #'wild-p (pathname-directory pathname))
           (wild-p (pathname-name pathname))
           (wild-p (pathname-type pathname))
           (wild-p (pathname-version pathname))))
      (:host nil)
      (:device nil)
      (:directory (some #'wild-p (pathname-directory pathname)))
      (:name (wild-p (pathname-name pathname)))
      (:type (wild-p (pathname-type pathname)))
      (:version (wild-p (pathname-version pathname)))
      (t (wild-pathname-p pathname
                          (require-type field-key 
                                        '(member nil :host :device 
                                          :directory :name :type :version)))))))


 
;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
;Directory Traversing

;Make a list of all files matching the pattern and satisfying the restrictions
;specified by the keyword args.  The :TEST arg is only called if all the
;other conditions are satisfied (so the more of these special keywords we
;have that can be detected from raw data, the fewer pathnames we have to cons
;up).
; known bug (directory "samson:" :directory-pathnames nil) gives
; (#1P"Samson:samson") - should probably be "samson:" - let them report it.

#| find other dirs in translations that match wild for e.g.
      (setf (logical-pathname-translations "barf")
            `(("barf:alice;**;*.*" "alice:**:*.*")
             ("barf:**;*.*" "zoe:**:*.*")))

|# 
#|
; big pile of horse doo doo
(defun other-wild-dirs (wild)
  (let* ((host (pathname-host wild)))
    (when (and host (neq host :unspecific))
      (let* ((trans (logical-pathname-translations host))
            (wilder (make-pathname :host host :directory (pathname-directory wild)
                                   :name :wild :type :wild))
            (full-wild (full-pathname wilder))
            res)
        (dolist (x trans res)
          (when (pathname-match-p (print (make-pathname :host host :directory (pathname-directory (car x))
                                                 :name :wild :type :wild))
                                  wilder)
            ; isnt right *.* doesn't match *.lisp
            ; now **; doesn't match nothing
            (print (list 3 (car x)))
            (when (not (pathname-match-p (full-pathname (cadr x)) full-wild))
              (push (cadr x) res))))))))

(defun other-wild-dirs (wild)
  (let* ((host (pathname-host wild)))
    (when (and host (neq host :unspecific))
      (let* ((trans (logical-pathname-translations host))            
            (full-wild (full-pathname wild))
            res)
        (dolist (x trans res)
          (when (pathname-match-p wild (car x))
            ; isnt right *.* doesn't match *.lisp
            ; now **; doesn't match nothing
            ;(print (list 3 (car x)))
            (when (not (pathname-match-p (full-pathname (cadr x)) full-wild))
              (push (cadr x) res))))))))
|#

(defun other-wild-dirs (wild)
  (declare (ignore wild)))

#| ;; moved to l1-files
(defmethod string-length ((x encoded-string))
  (length (the-string x)))
(defmethod string-length ((x t))
  (length x))
(defmethod string-schar ((x encoded-string) n)
  (schar (the-string x) n))
(defmethod string-schar ((x t) n)
  (schar x n))

(defmethod string-string= ((x encoded-string) (y encoded-string))
  (string= (the-string x)(the-string y)))
;; not really right but serves our purposes - assume y is 7bit ascii
(defmethod string-string= ((x encoded-string) y)
  (string= (the-string x) y))
(defmethod string-string= ((x t) y)
  (string= x y))
|#

#|
(defun directory-old (path &key (directories nil)
                       (files t)
                       (directory-pathnames t)
                       test resolve-aliases
                       &aux dir wild rest errno)
  (let* ((other-dirs (other-wild-dirs path))   ;; always nil this week    
         (more (when other-dirs (mapcan #'(lambda (dir)
                                            (directory dir :directories directories :files files
                                                       :directory-pathnames directory-pathnames
                                                       :test test :resolve-aliases resolve-aliases))
                                        other-dirs)))
         (path (full-pathname path :no-error nil))
         (*directories-done* nil)
         (dirlist (pathname-directory  path))); save parsing the string a million times
    (declare (special *directories-done* nil))
    (setq dir (if (null dirlist) ":"
                  (%directory-list-namestring dirlist)))
    ;dir is guaranteed to end in a ":".
    #-bccl (unless (eq (string-schar dir (1- (string-length dir))) #\:)
             (error "Bad dir format in ~S" path))
    (multiple-value-setq (dir wild rest) (%split-dir dir))
    (append
     (%stack-iopb (pb np)
       (nreverse
        (if dir
          (if (%izerop (setq errno (%path-GetDirInfo dir pb nil t)))           
            (let ((so-far (nreverse (cdr (pathname-directory (%path-from-iopb pb)))))) ; <<
              ;(print (list path so-far))
              (cond (wild
                     (cond ((string= wild "**")
                            (%all-directories pb rest path directories files
                                              directory-pathnames test so-far resolve-aliases))
                           (t (%one-wild pb wild rest path directories files
                                         directory-pathnames test so-far resolve-aliases))))
                    (t (%directory pb rest path directories files
                                   directory-pathnames test so-far resolve-aliases))))
            (when nil
              (unless (or (eq errno $fnfErr) (eq errno $nsvErr)(eq errno #$afpAccessDenied)
                          (eq errno $dirNFErr)(eq errno $paramERR)) ; Aufs again
                (%err-disp errno))))
          (let ((vol wild) more-p)                ; wild volume! 
            (if (string= vol "**")
              (setq vol "*"  wild "**")
              (multiple-value-setq (dir wild rest) (%split-dir rest))
              )
            (setq more-p (or (pathname-name path)(pathname-type path)))
            (do ((index 1 (1+ index)) (result ()))
                ((not (%izerop (setq errno (progn (%put-word pb index $ioVolIndex)
                                                  (#_PBHGetVInfoSync pb)))))
                 (if (eq errno $nsvErr) result (signal-file-error errno path)))
              (%put-long pb 2 $ioDirID) ; i dont get this? - dir of volume
              (when (%path-pstr*= vol np)
                (let ((so-far (list (%get-std-string np))))
                  (declare (dynamic-extent so-far))
                  (%put-word pb -1 $iofdirIndex)
                  (file-errchk (#_PBGetCatInfoSync pb) path) ; to get # files 
                  ;(print (list so-far more-p dir wild rest))
                  (setq result
                        (nconc
                         (cond (wild
                                (cond ((string= wild "**")
                                       (%all-directories pb rest path directories files
                                                         directory-pathnames test so-far resolve-aliases))
                                      (t (%one-wild pb wild rest path directories files
                                                    directory-pathnames test so-far resolve-aliases))))                              
                               ((and dir (not (string= dir ":")))
                                (%some-specific pb dir wild rest path directories
                                                files directory-pathnames test so-far resolve-aliases))
                               ((or more-p (and rest (not (string= rest ":"))))
                                (%directory pb rest path directories files
                                            directory-pathnames test so-far resolve-aliases))
                               (t ; ignore directory-pathnames option here - let them report the bug
                                (let ((sub (%cons-pathname (cons :absolute (copy-list so-far)) nil nil)))
                                  (when (and sub (or (null test)(funcall test sub)))
                                    (list sub)))))
                         result)))))))))
     more)))

|#

;; return tail of name and is-dir
#+UNUSED
(defun get-fsref-name-tail (fsref)
  (rletz ((catinfo :fscataloginfo)
          (outname :hfsunistr255))
    (#_fsgetcataloginfo fsref #$kFSCatInfoNodeFlags catinfo 
     outname *null-ptr* *null-ptr*)
    (let ((str (string-from-hfsunistr-with-quotes outname ";*"))) ;; e.g. "MCL-dev" or "pathnames.lisp" - should quote semicolons and *'s?
      (if (using-posix-paths-p)(%str-subst str #\/ #\:))
      (values (if (not (7bit-ascii-p str))
                (make-encoded-string str)
                str)
              (%ilogbitp #$kFSNodeIsDirectoryBit (pref catinfo :fscataloginfo.nodeflags))))))



(defun get-fsref-name-tail-ustr (fsref outname)
  (rletz ((catinfo :fscataloginfo))
    (#_fsgetcataloginfo fsref #$kFSCatInfoNodeFlags catinfo outname (%null-ptr)(%null-ptr))
    (if (using-posix-paths-p)(%ustr-subst outname #\/ #\:))
    (values outname
            (%ilogbitp #$kFSNodeIsDirectoryBit (pref catinfo :fscataloginfo.nodeflags)))))

(defun %ustr-subst (ustr out in)
  (let ((out-code (char-code out))
        (in-code (char-code in))
        (len (%get-word ustr 0)))
    (declare (fixnum len))
    (dotimes (i len)
      (when (eql (%get-unsigned-word ustr (%i+ i i 2)) in-code)
        (setf (%get-unsigned-word ustr (%i+ i i 2)) out-code)))
    ustr))


(defun quote-some-chars-in-hfsunistr (ustr &optional chars-to-quote)
  (if (not chars-to-quote) 
    ustr
    (LET* ((len (%get-word ustr))
           (newlen len))
      (declare (fixnum len newlen))
      (dotimes (i len)
        (when (%str-member (code-char (%get-unsigned-word ustr (%i+ i i 2))) chars-to-quote)
          (incf newlen)))
      (if (eq newlen len)
        ustr
        (progn 
          (when (> newlen 255) (error "phooey"))
          (rlet ((ustr-copy :hfsunistr255))
            (let ((delta 0))
              (declare (fixnum delta))
              (copy-record ustr :hfsunistr255 ustr-copy)
              (dotimes (i len)
                (let ((char-code (%get-unsigned-word ustr-copy (%i+ i i 2))))
                  (when t ;junk
                    (when (%str-member (code-char char-code) chars-to-quote)
                      (setf (%get-unsigned-word ustr (%i+ i i delta 2)) #.(char-code *pathname-escape-character-unicode*))
                      (setq  delta (%i+ 2 delta)))
                    (setf (%get-unsigned-word ustr (%i+ i i delta 2)) char-code))))
              (setf (%get-word ustr 0) newlen)
              ustr)))))))


;; this is much slower than before (* 2) and cons intensive (* 1.5) or worse
;; oddly this way is slightly faster than the old way on OSX  - consing still lousy of course
(defun directory (path &key (directories nil)
                       (files t)
                       (directory-pathnames t)
                       test resolve-aliases
                       &aux dir wild rest errno)
  (let* ((path (full-pathname path :no-error nil))
         (*directories-done* nil)
         (dirlist (pathname-directory  path))
         )
    (declare (special *directories-done* nil))
    (setq dir (if (null dirlist) ":"
                  (%directory-list-namestring dirlist)))
    ;dir is guaranteed to end in a ":".
    #-bccl (unless (eq (string-schar dir (1- (string-length dir))) #\:)
             (error "Bad dir format in ~S" path))
    (multiple-value-setq (dir wild rest) (%split-dir dir))
    (progn ;delete-if #'is-path-invisible
      (rletz ((fsref :fsref))
        (nreverse
         (if dir
           (multiple-value-bind (res is-dir)(if t ;resolve-aliases ; not saME as before
                                              (path-to-fsref dir fsref) ;; do resolve aliases
                                              (make-fsref-from-path-simple dir fsref)) ;; don't resolve aliases
             (if (and res is-dir)
               (let ((so-far (reverse (cdr (%pathname-directory (%path-from-fsref fsref t))))))  ;; dont nreverse please! 
                 (cond (wild
                        (cond ((string= wild "**")
                               (%all-directories2 fsref rest path directories files
                                                  directory-pathnames test so-far resolve-aliases))
                              (t (%one-wild2 fsref wild rest path directories files
                                             directory-pathnames test so-far resolve-aliases))))
                       (t (%directory2 fsref rest path directories files
                                       directory-pathnames test so-far resolve-aliases)))))
             )
           (let ((vol wild) more-p vol-name vol-names)                ; wild volume! 
             (if (string= vol "**")
               (setq vol "*"  wild "**")
               (multiple-value-setq (dir wild rest) (%split-dir rest))
               )
             (RLET ((unistr :hfsunistr255)
                    (fsref :fsref)
                    (actual-volume :signed-integer))
               (setq more-p (or (%pathname-name path)(%pathname-type path)))
               ;; how do we know how many volumes? proceed till nsvErr
               (do ((index 1 (1+ index)) (result ()))
                   ((eq #$nsvErr (setq errno (#_FSGetVolumeInfo 0 index actual-volume 0 (%null-ptr) unistr fsref)))
                    result) 
                 (when (eq errno #$noerr)
                   (setq  vol-name (string-from-hfsunistr unistr)) 
                   (when (not (member vol-name vol-names :test #'equalp)) ;; ugh we can get the same volume name twice?!? an OSX only "feature"
                     (push vol-name vol-names)
                     (when (does-pattern-match vol vol-name)
                       (let ((so-far (list vol-name)))
                         (declare (dynamic-extent so-far))                    
                         (setq result
                               (nconc
                                (cond (wild
                                       (cond ((string= wild "**")
                                              (%all-directories2 fsref rest path directories files
                                                                 directory-pathnames test so-far resolve-aliases))
                                             (t (%one-wild2 fsref wild rest path directories files
                                                            directory-pathnames test so-far resolve-aliases))))                              
                                      ((and dir (not (string= dir ":")))
                                       (%some-specific2 fsref dir wild rest path directories
                                                        files directory-pathnames test so-far resolve-aliases))
                                      ((or more-p (and rest (not (string= rest ":"))))
                                       (%directory2 fsref rest path directories files
                                                    directory-pathnames test so-far resolve-aliases))
                                      (t ; ignore directory-pathnames option here - let them report the bug
                                       (let ((sub (%cons-pathname (cons :absolute (copy-list so-far)) nil nil)))
                                         (when (and sub (or (null test)(funcall test sub)))
                                           (list sub)))))
                                result))))))))))))
      )))

(defun is-path-invisible (path)
  (rlet ((fsref :fsref)
         (catinfo :fscataloginfo))
    (or (not (path-to-fsref path fsref))  ;; happens for /.vol on OSX 
        (progn
          (fsref-get-cat-info fsref catinfo (logior #$kfscatinfofinderinfo ))
          (neq 0 (logand  #$kIsInvisible  (pref catinfo :fscataloginfo.finderinfo.finderflags)))))))

#|
(defun %directory (pb rest path directories files directory-pathnames test &optional so-far resolve-aliases)
  ;(print (%dir-path-from-iopb pb))
  (declare (special *directories-done*))
  (when resolve-aliases    
      (push so-far *directories-done*))
  (if (or (null rest)(string= rest ":"))
    (%files-in-directory pb path directories files directory-pathnames test so-far resolve-aliases)
    (multiple-value-bind (dir wild rest)(%split-dir rest)
      (if (or (null dir)(string= dir ":"))
         (cond (wild 
               (cond 
                ((string= wild "**")
                 (%all-directories pb rest path
                                   directories files 
                                   directory-pathnames test so-far resolve-aliases))
                (t (%one-wild pb wild rest path
                              directories files directory-pathnames test so-far resolve-aliases))))
               (t (if (and rest (not (string= rest ":")))(error "Shouldnt"))
                  (%files-in-directory pb path
                                       directories files
                                       directory-pathnames test so-far resolve-aliases)))
        (%some-specific pb dir wild rest path directories files directory-pathnames test so-far resolve-aliases)))))
|#

(defun %directory2 (fsref rest path directories files directory-pathnames test so-far resolve-aliases)
  ;(print (%dir-path-from-iopb pb))
  (declare (special *directories-done*))
  (when resolve-aliases    
      (push so-far *directories-done*))
  (if (or (null rest)(string= rest ":"))
    (%files-in-directory2 fsref path directories files directory-pathnames test so-far resolve-aliases)
    (multiple-value-bind (dir wild rest)(%split-dir rest)
      (if (or (null dir)(string= dir ":"))
         (cond (wild 
               (cond 
                ((string= wild "**")
                 (%all-directories2 fsref rest path
                                   directories files 
                                   directory-pathnames test so-far resolve-aliases))
                (t (%one-wild2 fsref wild rest path
                              directories files directory-pathnames test so-far resolve-aliases))))
               (t (if (and rest (not (string= rest ":")))(error "Shouldnt"))
                  (%files-in-directory2 fsref path
                                       directories files
                                       directory-pathnames test so-far resolve-aliases)))
        (%some-specific2 fsref dir wild rest path directories files directory-pathnames test so-far resolve-aliases)))))

; for a specific sub directory or directories
#|
(defun %some-specific (pb dir wild rest path directories files directory-pathnames test &optional so-far resolve-aliases)
  ;(setq %saved-ioVRefNum% nil)     ; clear cache for %path-from-iopb
  (when (%subdir-info dir pb resolve-aliases)
    (setq so-far (nconc (nreverse (cdr (%directory-string-list dir 0))) so-far))
    (cond (wild
           (cond ((string= wild "**")
                  (%all-directories pb rest path directories files
                                    directory-pathnames test so-far resolve-aliases))
                 (t (%one-wild pb wild rest path directories files
                               directory-pathnames test so-far resolve-aliases))))
          ((and rest (not (string= rest ":")))
           ; does this ever happen?
           (%some-specific rest nil nil path
                           directories files directory-pathnames test so-far resolve-aliases))
          (t (%directory pb rest path directories files directory-pathnames test so-far resolve-aliases)))))
|#

(defun %some-specific2 (fsref dir wild rest path directories files directory-pathnames test so-far resolve-aliases)
  ;(setq %saved-ioVRefNum% nil)     ; clear cache for %path-from-iopb
  (when (%subdir-info2 dir fsref resolve-aliases so-far)
    (setq so-far (nconc (nreverse (cdr (%directory-string-list dir 0))) so-far))
    (cond (wild
           (cond ((string= wild "**")
                  (%all-directories2 fsref rest path directories files
                                    directory-pathnames test so-far resolve-aliases))
                 (t (%one-wild2 fsref wild rest path directories files
                               directory-pathnames test so-far resolve-aliases))))
          ((and rest (not (string= rest ":")))
           ; does this ever happen? - likely not it was brain dead
           (%some-specific2 fsref rest nil nil path
                           directories files directory-pathnames test so-far resolve-aliases))
          (t (%directory2 fsref rest path directories files directory-pathnames test so-far resolve-aliases)))))

; for a * or *x*y
#|
(defun %one-wild (pb wild rest path directories files directory-pathnames test &optional so-far resolve-aliases)
  ;(setq %saved-ioVRefNum% nil)     ; clear cache for %path-from-iopb
  (declare (special *directories-done*))
  (with-macptrs ((np (%get-ptr pb $ioFileName)))
    (let ((nfiles (%get-word pb $ioDrNmFls)))
      (do ((index 1 (1+ index))
           (dirid (%get-long pb $ioDirID))
           (vrefnum (%get-word pb $iovrefnum))
           (is-alias nil nil)
           (so-far-alias nil nil)
           (orig nil nil)
           (result ()))
          ((> index nfiles) (when result (delete-duplicates result :test #'equal)))
        (when (%izerop (progn (%put-word pb index $ioFDirIndex)
                              (#_PBGetCatInfoSync pb)))          
          (when (and resolve-aliases (pb-alias-p pb)(%path-pstr*= wild np))
            (setq orig (%get-std-string np))
            (%put-long pb dirid $ioDirID)
            (setq is-alias t)
            (pb-resolve-alias pb)
            (when (neq resolve-aliases :show-alias)
              (setq so-far-alias (nreverse (cdr (pathname-directory (%x-path-from-iopb pb)))))))
          (if (%ilogbitp $ioDirFlg (%get-byte pb $ioFlAttrib))
            (when (or orig  (%path-pstr*= wild np)) ; are we consistent or what
              ; either show unresolved name which matches, or resolved name that doesnt
              (let ((so-far 
                     (if (and orig (eq resolve-aliases :show-alias))
                       (cons orig so-far)
                       (or so-far-alias (cons (%get-std-string np) so-far)))))
                (declare (dynamic-extent so-far))
                (when (not (and is-alias (member so-far *directories-done* :test #'equal)))
                  (setq result
                        (nconc (%directory pb rest path directories files 
                                         directory-pathnames test so-far resolve-aliases)
                             result)))))))
        (%put-word pb vrefnum $iovrefnum)
        (%put-long pb dirid $ioDirID)))))
|#


(defun maybe-resolve-alias (this-fsref resolve-aliases)
  (declare (special *alias-resolution-policy*))
  (when (and (neq *alias-resolution-policy* :none)
             resolve-aliases
             (neq resolve-aliases :show-alias) ; don't resolve in this case!
             (fsref-is-alias-p this-fsref)) ; this _does_ resolve in easy cases
    (multiple-value-bind (isfolder resolved)
                         (if (eq *alias-resolution-policy* :quiet)
                           (resolve-alias-from-fsref-quiet this-fsref)
                           (resolve-alias-from-fsref this-fsref))
      (values resolved isfolder); return true iff it was an alias and we resolved it
      )))

;; wild e.g. "lib*" rest e.g. ":" path what we are looking for
(defun %one-wild2 (fsref wild rest path directories files directory-pathnames test so-far resolve-aliases)
  ;(setq %saved-ioVRefNum% nil)     ; clear cache for %path-from-iopb
  (declare (special *directories-done*))
  (let ((so-far-alias nil)(result nil))
    (rletZ ((catinfo :fscataloginfo)
            (hfsustr :hfsunistr255))
      (fsref-get-cat-info fsref catinfo #$kFSCatInfoValence)  ;; how many frobs?  files and directories - 205 in "CCL:"
      (let ((nfrobs (pref catinfo :fscataloginfo.valence))) ;; what a weird term
        (%stack-block  ((fsrefarray (%i* nfrobs #.(record-length :fsref)) :clear t))
          (get-fsref-array fsref nfrobs fsrefarray)
          (dotimes (i nfrobs result)
            (let* ((this-fsref (%inc-ptr fsrefarray (%i* i #.(record-length :fsref))))
                   (is-alias nil)
                   orig)
              (declare (dynamic-extent this-fsref))
              (setq is-alias (maybe-resolve-alias this-fsref resolve-aliases))
              (multiple-value-bind (path-tail is-dir)(get-fsref-name-tail-ustr this-fsref hfsustr)
                (when is-dir
                  (let ()                  
                    (when (or orig (does-pattern-match-ustr  wild path-tail))
                      (let ((so-far 
                             (if (and orig (eq resolve-aliases :show-alias))
                               (cons orig so-far)
                               (or so-far-alias (cons (string-from-hfsunistr (quote-some-chars-in-hfsunistr path-tail ";*"))  so-far)))))
                        (declare (dynamic-extent so-far))
                        (when (not (and is-alias (member so-far *directories-done* :test #'equal)))
                          (setq result
                                (nconc (%directory2 this-fsref rest path directories files 
                                                    directory-pathnames test so-far resolve-aliases)
                                       result)))))))))))))))


; now for samson:**:*c*:**: we get samson:ccl:crap:barf: twice because
; it matches in two ways
; 1) **=ccl *c*=crap **=barf
; 2) **= nothing *c*=ccl **=crap:barf
; called to match a **
#|
(defun %all-directories (pb rest path directories files directory-pathnames test &optional so-far resolve-aliases)
  (declare (special *directories-done*))
  (when resolve-aliases
      (push so-far *directories-done*))    
  (let ((do-files nil)
        (do-dirs nil)
        (result nil)
        (name (pathname-name path))
        (type (pathname-type path))
        (nfiles (%get-word pb $ioDrNmFls))
        sub dir)
    (multiple-value-bind (next-dir next-wild next-rest)
                         (%split-dir rest)
      (when (and (or (null next-dir)(string= next-dir ":"))
                 next-wild
                 (string= next-wild "**")) ; i.e. some dummy said :**:**: which = :**:
        (setq rest next-rest)
        (multiple-value-setq (next-dir next-wild next-rest)
                             (%split-dir next-rest)))
      (cond ((or (null rest)(string= rest ":"))
             (cond ((or name type)
                    (when files (setq do-files t))
                    (when directories (setq do-dirs t)))
                   (t (when (null dir)
                        (setq dir (cons :absolute (nreverse (copy-list so-far)))))
                      (when directories
                        (setq sub (if directory-pathnames
                                    (%cons-pathname dir nil nil)
                                    (%cons-pathname (butlast dir)(car (last dir)) nil)))
                        (when (and sub (or (null test)(funcall test sub)))
                          (setq result (list sub)))))))
            (t ; first deal with ** matching nothing
             (let ((dirid (%get-long pb $ioDirID))
                   (vrefnum (%get-word pb $iovrefnum))) ; in case changed by alias
             (setq result                   
                   (cond 
                    ((and next-dir (not (string= next-dir ":"))) 
                     (%some-specific pb next-dir next-wild next-rest path
                                     directories files directory-pathnames
                                     test so-far resolve-aliases))
                    (next-wild
                     (%one-wild pb next-wild next-rest path
                                directories files directory-pathnames test so-far resolve-aliases))
                    (t (error "Shouldnt"))))
             ; back up to starting point
             (%put-word pb vrefnum $iovrefnum)
             (%put-long pb dirid $ioDirID)))))               
    ; now descend doing %all-dirs on dirs and collecting files & dirs if do-x is t
    (with-macptrs ((np (%get-ptr pb $ioFileName)))      
     (do ((index 1 (1+ index))
           (dirid (%get-long pb $ioDirID))
           (vrefnum (%get-word pb $iovrefnum))
           (is-alias nil nil)
           errno)
          ((> index nfiles)(when result (delete-duplicates result :test #'equal)))
       (let (orig resolved)
        (setq errno (progn (%put-word pb index $ioFDirIndex)
                           (#_PBGetCatInfoSync pb)))
        (when (%izerop errno)
          (when (and resolve-aliases (pb-alias-p pb))
            (setq orig (%get-std-string np))
            (%put-long pb dirid $ioDirID)
            (pb-resolve-alias pb)
            (setq is-alias t)
            (when (neq resolve-aliases :show-alias)
              (setq resolved (%x-path-from-iopb pb))))
          (let ()
            (if (%ilogbitp $ioDirFlg (%get-byte pb $ioFlAttrib))
              (progn                
                (when (and do-dirs (if orig
                                     (%path-str*= orig (file-namestring path))
                                     (%file*= name type np)))
                  (when (null dir)
                    (setq dir (cons :absolute (nreverse (copy-list so-far)))))
                  (setq sub (%dir-sub-dir np orig dir resolved directory-pathnames))
                  (when (and sub (or (null test)(funcall test sub)))
                    (push sub result)))                
                (let ((so-far 
                       (if (and orig (eq resolve-aliases :show-alias))
                         (cons orig so-far)
                         (if resolved 
                           (nreverse (cdr (pathname-directory resolved)))
                           (cons (%get-std-string np) so-far)))))
                  (declare (dynamic-extent so-far))
                  (when (not (and is-alias (member so-far *directories-done* :test #'equal)))
                    (setq result
                          (nconc (%all-directories pb rest path directories files
                                                   directory-pathnames test so-far resolve-aliases)
                                 result)))))
              (when (and do-files (if orig (%path-str*= orig (file-namestring path))(%file*= name type np)))                
                  (when (null dir)
                    (setq dir (cons :absolute (nreverse (copy-list so-far)))))
                  (setq sub (%dir-sub-file np orig dir resolved))
                  (when (and sub (or (null test) (funcall test sub)))
                    (push sub result))))))
        (%put-word pb vrefnum $iovrefnum)        
        (%put-long pb dirid $ioDirID))))))
|#

(defun %all-directories2 (fsref rest path directories files directory-pathnames test so-far resolve-aliases)
  (declare (special *directories-done*))
  (when resolve-aliases
    (push so-far *directories-done*))    
  (let ((do-files nil)
        (do-dirs nil)
        (result nil)
        (name (pathname-name path))
        (type (pathname-type path))
        ;(nfiles (%get-word pb $ioDrNmFls))
        (name&type (if directories (file-namestring path)))
        sub dir)    
    (multiple-value-bind (next-dir next-wild next-rest)
                         (%split-dir rest)
      (when (and (or (null next-dir)(string= next-dir ":"))
                 next-wild
                 (string= next-wild "**")) ; i.e. some dummy said :**:**: which = :**:
        (setq rest next-rest)
        (multiple-value-setq (next-dir next-wild next-rest)
          (%split-dir next-rest)))
      (cond ((or (null rest)(string= rest ":"))
             (cond ((or name type)
                    (when files (setq do-files t))
                    (when directories (setq do-dirs t)))
                   (t (when (null dir)
                        (setq dir (cons :absolute (reverse so-far))))
                      (when directories
                        (setq sub (if directory-pathnames
                                    (%cons-pathname dir nil nil)
                                    (%cons-pathname (butlast dir)(car (last dir)) nil)))
                        (when (and sub (or (null test)(funcall test sub)))
                          (setq result (list sub)))))))
            (t ; first deal with ** matching nothing
             (let (;(dirid (%get-long pb $ioDirID))
                   ;(vrefnum (%get-word pb $iovrefnum))
                   ) ; in case changed by alias
               (setq result                   
                     (cond 
                      ((and next-dir (not (string= next-dir ":"))) 
                       (%some-specific2 fsref next-dir next-wild next-rest path
                                        directories files directory-pathnames
                                        test so-far resolve-aliases))
                      (next-wild
                       (%one-wild2 fsref next-wild next-rest path
                                   directories files directory-pathnames test so-far resolve-aliases))
                      (t (error "Shouldnt"))))
               ; back up to starting point
               ;(path-to-fsref path fsref) ;;??
               ;(%put-word pb vrefnum $iovrefnum)
               ;(%put-long pb dirid $ioDirID)
               ))))               
    ; now descend doing %all-dirs on dirs and collecting files & dirs if do-x is t
    (rletZ ((catinfo :fscataloginfo)
            (hfsustr :hfsunistr255))
      (fsref-get-cat-info fsref catinfo #$kFSCatInfoValence)  ;; how many frobs?  files and directories - 205 in "CCL:"
      (let ((nfrobs (pref catinfo :fscataloginfo.valence)))
        (%stack-block  ((fsrefarray (%i* nfrobs #.(record-length :fsref)) :clear t))
          (get-fsref-array fsref nfrobs fsrefarray)
          (dotimes (i nfrobs result)
            (let* ((this-fsref (%inc-ptr fsrefarray (%i* i #.(record-length :fsref))))
                   (is-alias nil)
                   (resolved nil))
              (declare (dynamic-extent this-fsref))
              ;(print (%path-from-fsref this-fsref))
              (setq is-alias (maybe-resolve-alias this-fsref resolve-aliases))
              (multiple-value-bind (path-tail is-dir)(get-fsref-name-tail-ustr this-fsref hfsustr)
                (if is-dir
                  (progn
                    (when (and do-dirs (does-pattern-match-ustr name&type path-tail))
                      (if (not dir) (setq dir (cons :absolute (reverse so-far))))
                      (multiple-value-setq (sub resolved)
                        (%dir-sub-dir2 this-fsref path-tail dir is-alias directory-pathnames))
                      (when (and sub (or (null test) (funcall test sub)))
                        (pushnew sub result :test #'equal)))
                    (let ((so-far
                           ; gotta do this test otherwise #'directory can return mid path aliases when :resolve-aliases = t
                           (if resolved
                             (reverse (cdr (pathname-directory resolved))) ; mustn't use nreverse here
                             (cons (string-from-hfsunistr (quote-some-chars-in-hfsunistr path-tail ";*"))  so-far))))
                      (declare (dynamic-extent so-far))
                      (when (not (and is-alias (member so-far *directories-done* :test #'equal)))
                        (setq result 
                              (nconc (%all-directories2 this-fsref rest path directories files
                                                        directory-pathnames test so-far resolve-aliases)
                                     result)))))
                  (when (and do-files (do-name-and-type-match-ustr name type path-tail))
                    (if (not dir) (setq dir (cons :absolute (reverse so-far))))
                    (setq sub (%dir-sub-file2 this-fsref path-tail dir is-alias))
                    (when (and sub (or (null test) (funcall test sub)))
                      (pushnew sub result :test #'equal)))
                  )))))))))


  

(defun %dir-sub-dir2 (fsref path-tail dir aliasp directory-pathnames)
  (let ((resolved nil))
    (values ; Please don't write code like mine
     (cond ; aliases could point to completely different directories, thus we gotta resolve them
      (aliasp (setq resolved (%path-from-fsref fsref))
              (if directory-pathnames
                resolved
                (let ((dir (pathname-directory resolved)))
                  (%cons-pathname (butlast dir) (car (last dir)) nil))))
      (t (let ((last (string-from-hfsunistr (quote-some-chars-in-hfsunistr path-tail ";*"))))
           (if directory-pathnames
             (%cons-pathname (append dir (list last)) nil nil)
             (%cons-pathname dir last nil)))))
     resolved ; we sometimes need the pure resolved thing regardless of directory-pathnames parameter
     )))

(defun %dir-sub-file2 (fsref path-tail dir aliasp)
  (if aliasp ; aliases could point to completely different directories, thus we gotta resolve them
    (%path-from-fsref fsref)
    (let ((name&type (string-from-hfsunistr path-tail)))
      (multiple-value-bind (name type) (%std-name-and-type name&type)
      (%cons-pathname dir name type)))))
  

;; directories, files and directory-pathnames are booleans meaning want or not
;; so-far is the reverse of the directory  we have reached "so far"  
;; fsref is for a directory whose internals we wish to explore
#+ignore
(defun %files-in-directory2 (FSREF path directories files directory-pathnames test
                                   so-far resolve-aliases)
  (let ((name (pathname-name path))
        (type (pathname-type path))
        (name&type (if directories (file-namestring path)))
        (result ())
        ;so-far-path
        ;so-far-dir
        sub dir)
    (when nil ;so-far ;; incoming fsref was wrong when wild volume - below is a stupid fix  - i think fixed in %subdir-info2    
      ;(setq so-far-dir (cons :absolute (reverse so-far)))
      ;(setq so-far-path (make-pathname :directory so-far-dir :name nil :type nil :defaults nil))
      ;(make-fsref-from-path-simple so-far-path fsref)
      )
    
    (when (and directories (not type) (null name)) ;(string= name "*")(string= name "**")))
      (setq dir (cons :absolute (reverse so-far)))
      (setq sub (if directory-pathnames
                  (%cons-pathname dir nil nil)
                  (%cons-pathname (butlast dir)(car (last dir)) nil)))
      (when (and sub (or (null test)(funcall test sub)))
        (setq result (list sub))))
    (if (not (or name type))
      result
      (rletZ ((catinfo :fscataloginfo)
              (hfsustr :hfsunistr255))
        (fsref-get-cat-info fsref catinfo #$kFSCatInfoValence)  ;; how many frobs?  files and directories - 205 in "CCL:"
        (let ((nfrobs (pref catinfo :fscataloginfo.valence))) ;; what a weird term
          (%stack-block  ((fsrefarray (%i* nfrobs (record-length :fsref)) :clear t))
            (get-fsref-array fsref nfrobs fsrefarray)            
            (dotimes (i nfrobs result)
              (let* ((this-fsref (%inc-ptr fsrefarray (%i* i #.(record-length :fsref))))
                     (is-alias nil))
                (declare (dynamic-extent this-fsref))
                ;(print (%path-from-fsref this-fsref))
                (setq is-alias (maybe-resolve-alias this-fsref resolve-aliases))
                (multiple-value-bind (path-tail is-dir)(get-fsref-name-tail-ustr this-fsref hfsustr)
                  ;(if (not dir) (setq dir (cons :absolute (reverse so-far))))
                  (let ((sub nil))
                    (if is-dir
                      (when directories
                        ;; huh
                        (when (does-pattern-match-ustr name&type path-tail)
                          (if (not dir) (setq dir (cons :absolute (reverse so-far))))
                          (setq sub (%dir-sub-dir2 this-fsref path-tail dir is-alias directory-pathnames))
                          ))
                      (when files
                        (when (do-name-and-type-match-ustr name type path-tail)
                          (if (not dir) (setq dir (cons :absolute (reverse so-far))))
                          (setq sub (%dir-sub-file2 this-fsref path-tail dir is-alias))
                          )))
                    (when (and sub (or (null test)(funcall test sub)))
                      (pushnew sub result :test #'equal))                        
                    ))))))))))

;; don't ask me - run it through the mill again to get the right answer -if error ignore it
(defun is-fsref-really-dir (fsref)
  (let ((maxlen 1024))  ;; how big??
    (%stack-block ((sb maxlen))
      (errchk (#_fsrefmakepath fsref sb maxlen)) ;; sb is a utf8 cstring
      (rlet ((another-fsref :fsref)
             (is-dir :boolean))
        (let ((errno (#_fspathmakeref sb another-fsref is-dir)))
          (if (eq errno #$noerr) (pref is-dir :boolean)
              nil))))))

(defun %files-in-directory2 (FSREF path directories files directory-pathnames test
                                   so-far resolve-aliases)
  (let ((name (pathname-name path))
        (type (pathname-type path))
        (name&type (if directories (file-namestring path)))
        ;(says-volumes (member "Volumes" (cdr (pathname-directory path)) :test #'string-equal))
        (result ())
        ;so-far-path
        ;so-far-dir
        sub dir)    
    (when (and directories (not type) (null name)) ;(string= name "*")(string= name "**")))
      (setq dir (cons :absolute (reverse so-far)))
      (setq sub (if directory-pathnames
                  (%cons-pathname dir nil nil)
                  (%cons-pathname (butlast dir)(car (last dir)) nil)))
      (when (and sub (or (null test)(funcall test sub)))
        (setq result (list sub))))
    (if (not (or name type))
      result
      (rletZ ((catinfo :fscataloginfo)
              (hfsustr :hfsunistr255))
        (fsref-get-cat-info fsref catinfo #$kFSCatInfoValence)  ;; how many frobs?  files and directories - 205 in "CCL:"
        (let ((nfrobs (pref catinfo :fscataloginfo.valence))) ;; what a weird term
          (%stack-block  ((fsrefarray (%i* nfrobs (record-length :fsref)) :clear t))
            (get-fsref-array fsref nfrobs fsrefarray)            
            (dotimes (i nfrobs result)
              (let* ((this-fsref (%inc-ptr fsrefarray (%i* i #.(record-length :fsref))))
                     (is-alias nil))
                (declare (dynamic-extent this-fsref))
                (setq is-alias (maybe-resolve-alias this-fsref resolve-aliases))
                (multiple-value-bind (path-tail is-dir)(get-fsref-name-tail-ustr this-fsref hfsustr)
                  ;(if (not dir) (setq dir (cons :absolute (reverse so-far))))
                  (let ((sub nil))
                    (when (and (not is-dir)) ;(osx-p)) ; says-volumes)  ;; below doesn't dtrt on OS9
                      (when (or (and directories (does-pattern-match-ustr name&type path-tail))
                                (do-name-and-type-match-ustr name type path-tail))
                        (setq is-dir (is-fsref-really-dir this-fsref))))                    
                    (IF IS-DIR
                      (when directories
                        ;; huh
                        (when (does-pattern-match-ustr name&type path-tail)
                          (if (not dir) (setq dir (cons :absolute (reverse so-far))))
                          (setq sub (%dir-sub-dir2 this-fsref path-tail dir is-alias directory-pathnames))
                          ))
                      (when files
                        (when (do-name-and-type-match-ustr name type path-tail)
                          (if (not dir) (setq dir (cons :absolute (reverse so-far))))
                          (setq sub (%dir-sub-file2 this-fsref path-tail dir is-alias)))))
                    (when (and sub (or (null test)(funcall test sub)))
                      (pushnew sub result :test #'equal))                        
                    ))))))))))



;; this is a bit screwy
(defun do-name-and-type-match-ustr (name type ustr)
  ;; dont cons unless mixed encodings
  (let ((ustr-len (%get-word ustr 0)))    
    (when (encoded-stringp name)
      (let ((enc (the-encoding name)))
        (if (neq enc #$kcfstringencodingunicode)
          (setq name (convert-string (the-string name) enc #$kcfstringencodingunicode))
          (setq name (the-string name)))))
    (when (encoded-stringp type)
      (let ((enc (the-encoding type)))
        (if (neq enc #$kcfstringencodingunicode)
          (setq type (convert-string (the-string type) enc #$kcfstringencodingunicode))
          (setq type (the-string type)))))
    (let ((esc (char-code *pathname-escape-character*))
          (dot-pos (%ustr-mem-last #\. ustr)))
      ;; is this right for nil name or type?
      (if dot-pos
        (and (if (null name)(eq dot-pos 0) (does-pattern-match-sub name ustr 0 0 (length name) dot-pos esc))
             (if (null type) t (does-pattern-match-sub type ustr 0 (1+ dot-pos) (length type) ustr-len esc)))
        (and (or (null type) (string= type "*")) (does-pattern-match-sub name ustr 0 0 (length name) ustr-len esc))))))


(defun %ustr-mem-last (char ustr &optional (start 0))
  (let ((code (char-code char))
        (len (%get-word ustr 0))
        res)
    (declare (fixnum len))
    (while (%i< start len)
      (when (eq code (%get-word ustr (%i+ start start 2)))
        (setq res start))
      (setq start (%i+ start 1)))
    res))  

(defun %ustr-member (char ustr)
  (let ((code (char-code char))
        (ustr-len (%get-word ustr 0)))
    (declare (fixnum ustr-len))
    (dotimes (i ustr-len nil)
      (when (eql code (%get-word ustr (%i+ i i 2)))
        (return i)))))


  
(defun does-pattern-match-ustr (pattern ustr)
  (let* ((pat-str (if (encoded-stringp pattern)
                    (let ((enc (the-encoding pattern)))
                      (if (neq enc #$kcfstringencodingunicode)
                        (convert-string (the-string pattern) enc #$kcfstringencodingunicode)
                        (the-string pattern)))
                    pattern))
         (esc (char-code *pathname-escape-character*)))   
    (does-pattern-match-sub pat-str ustr 0 0 (length pat-str) (%get-word ustr 0) esc)))

 
;(defvar *path-mem-escape* nil)


(defun %split-dir (dir &aux pos)                 ; dir ends in a ":".
  ;"foo:bar::x*y:baz::z*t:"  ->  "foo:bar::" "x*y" ":baz::z*t:"
  (if (null (setq pos (%path-mem "*" dir)))
    (values dir nil nil)
    (let (epos (len (if (encoded-stringp dir)(length (the-string dir)) (length dir))))
      (setq pos (if (setq pos (%path-mem-last ":" dir 0 pos)) (%i+ pos 1) 0)
            epos (%path-mem ":" dir pos len))
      (values (unless (%izerop pos) (%path-mac-namestring (%substr dir 0 pos)))
              (%substr dir pos epos)
              (%substr dir epos len)))))

;; the one in l1-files is wrong for our usage today?? - actually fixed now
(defun %path-mem (chars sstr &optional (start 0) end)
  (let ((esc  *Pathname-escape-character*))
    (when (encoded-stringp sstr)
      (let ((enc (the-encoding sstr))) 
        (setq sstr 
              (if (eq enc #$kcfstringencodingunicode)
                (the-string sstr)
                (convert-string (the-string sstr) enc #$kcfstringencodingunicode)))))
    (When (not end) (setq end (length sstr)))
    (let ((one-char (when (eq (length chars) 1) (%schar chars 0))))
      (while (%i< start end)
        (let ((char (%schar sstr start)))
          (when (if one-char (eq char one-char)(%%str-member char chars))
            (return-from %path-mem start))
          (when (eq char esc)
            (setq start (%i+ start 1)))
          (setq start (%i+ start 1)))))))

;; redef of version in l1-aprims
(defun %substr (str start end)  
  (cond 
   ((encoded-stringp str)
    ;; doesn't make much sense if encoding not unicode   
    (let* ((string (%substr (the-string str) start end)))
      (if (eq (the-encoding str) #$kcfstringencodingunicode)
        string
        (make-encoded-string string (the-encoding str))))
    )
   (t 
    (require-type start 'fixnum)
    (require-type end 'fixnum)
    (require-type str 'string)
    (let ((len (length str)))
      (multiple-value-bind (str strb)(array-data-and-offset str)
        (let ((newlen (%i- end start)))
          (when (%i> end len)(error "End ~S exceeds length ~S." end len))
          (when (%i< start 0)(error "Negative start"))
          (let ((new (make-string newlen :element-type (array-element-type str))))
            (move-string-bytes str new (%i+ start strb) 0 newlen)
            new)))))))      

; true if macdir is a possibly multi component subdir of thing in pb
; oh foo - if multi component need to deal with aliases (will be slow)
#|
(defun %subdir-info (macdir pb resolve-aliases &aux errno dirid)
  (declare (ignore-if-unused errno))    ; refs to errno depessimized out.
  (or (string= macdir ":")
      (with-macptrs (np)
        (%setf-macptr np (%get-ptr pb $ioFileName))
        (%put-string np macdir)
        (%put-word pb 0 $ioFDirIndex)  ; means heed the name
        (setq dirid (%get-long pb $iodirid))
        (if (%izerop (setq errno (#_PBGetCatInfoSync pb)))
          (progn (when (and resolve-aliases (pb-alias-p pb))
                   (%put-long pb dirid $iodirid)
                   (pb-resolve-alias pb))
                 (%ilogbitp $ioDirFlg (%get-byte pb $ioFlAttrib)))
          (when nil ;(print errno)
            (unless (or (eq errno $fnfErr)
                        (eq errno $paramErr) ; AUFS returns this sometimes
                        (eq errno $nsvErr)
                        (eq errno $dirNFErr)
                        (eq errno $afpAccessDenied))
            (%err-disp errno)))))))
|#

(defun %subdir-info2 (macdir fsref resolve-aliases so-far)
  (or (string= macdir ":")
      (let* ((more-path (make-pathname :directory (nconc (cons :absolute (reverse so-far))(cdr (%directory-string-list macdir 0)))
                                       :name nil :type nil :defaults nil)))        
        (multiple-value-bind (res is-dir) (make-fsref-from-path-simple more-path fsref)
          (when res
            (multiple-value-bind (aliasp directoryp) (maybe-resolve-alias fsref resolve-aliases)
              (when aliasp (setq is-dir directoryp)))
            is-dir)))))


;;;;;;;;;;;;;;;;
;;; Patch loader 

(defvar patch-directory-prefix "Patches ")   ; Patch dir name is "Patches 2.0a5"
(defvar lisp-version-prefix "Version ")      ; version string is "Version 2.0a5"
(defvar *new-lisp-patch-version* nil)        ; a number

; i.e. 6
(defun lisp-patch-version-number ()
  (or (patch-file-version (lisp-implementation-short-version))
   -1))
; i.e. "2.0b1p6"
(defun lisp-implementation-short-version ()
  ; actually returns a string with
  (let ((vers (lisp-implementation-version)))
    (%substr vers (length lisp-version-prefix) (length vers))))

; i.e. "2.0b1"
(defun lisp-implementation-version-less-patch ()
  (nth-value 2 (patch-file-version (lisp-implementation-short-version))))


(defun new-version-resource ()
  (let ((version-string (application-version-string *application*)))
    (when version-string
      (let ((resh (%null-ptr))
            (curfile (#_CurResFile))
            oldsize)
        (unwind-protect
          (progn 
            (#_UseResFile (#_LMGetCurApRefNum))
            (%setf-macptr resh (#_Get1Resource :|vers| 1))
            (unless (%null-ptr-p resh)
	      (#_LoadResource resh)
              (setq oldsize (#_GetHandleSize resh))              
              (with-dereferenced-handles ((r resh))
                (let* ((len1 (%get-byte r 6))
                       (str1 version-string)
                       (str2 (%get-string r (+ 7 len1)))
                       (delta (- (length str1) len1)))
                  (setq str2 (%str-cat str1 (%substr str2 len1 (length str2))))
                  (let ((newres (#_NewHandle :errchk (+ oldsize delta delta))))
                    (with-dereferenced-handles ((p newres))
                      (dotimes (i 3)
                        (declare (fixnum i))
                        (%put-word p (%get-word r (+ i i)) (+ i i)))
                      (%put-string p str1  6)
                      (%put-string p str2 (+ 7 (length str1))))
                    (list newres :|vers| 1))))))
          (#_UseResFile curfile))))))

(eval-when (:compile-toplevel :load-toplevel :execute)  ;; from pef-file.lisp
  (when (not (fboundp 'create-cfrg-handle))

    (defmacro round-up (num size)
      "Rounds number up to be an integral multiple of size."
      (let ((size-var (gensym)))
        `(let ((,size-var ,size))
           (* ,size-var (ceiling ,num ,size-var)))))

    (defun create-cfrg-handle (component-name version &optional (is-app t))
      (let* ((cnamelen (length component-name))
             (prefix-size 32)
             (var-size (round-up (+ 42 1 cnamelen) 4))
             (hsize (+ prefix-size var-size))
             (h (#_NewHandleClear hsize)))
        (setf (ccl::%hget-long h 8) 1)      ; cfrg version
        (setf (ccl::%hget-long h 28) 1)     ; count
        (setf (ccl::%hget-ostype h (+ prefix-size 0)) "pwpc")
        (setf (ccl::%hget-long h (+ prefix-size 8))
              (setf (ccl::%hget-long h (+ prefix-size 12))
                    version))
        (when is-app
          (setf (ccl::%hget-byte h (+ prefix-size 22)) #$kApplicationCFrag))     ; #$kIsApp
        (setf (ccl::%hget-byte h (+ prefix-size 23)) #$kDataForkCFragLocator)     ; #$kOnDiskFlat
        (setf (ccl::%hget-word h (+ prefix-size 40)) var-size)
        (setf (ccl::%hget-byte h (+ prefix-size 42)) cnamelen)
        (dotimes (i cnamelen)
          (setf (ccl::%hget-byte h (+ prefix-size 43 i)) (char-code (schar component-name i))))
        h))))



(defun new-cfrg-resource ()
  (get-universal-time)
  (let* ((new-name (format nil "pmcl_application~X" (get-universal-time)))
         (handle (create-cfrg-handle new-name 0)))
    (list handle :|cfrg| 0)))
    


  


; load all fasl's in the patch dir whatever they are named     
(defun load-all-patches (&optional (source-dir (full-pathname "ccl:" :no-error nil)))
  (load-patches source-dir t)
  (setq *new-lisp-patch-version* nil))


; some startup procedure should always do this - perhaps with a query
; the ALL option loads every fasl in patch directory - does not set patch-version

#|
(defun load-patches (&optional (source-dir (full-pathname "ccl:" :no-error nil)) all)
  (let ((patch-vers (lisp-patch-version-number))
        patch-dir
        patch-files
        newpv)
    ;  "Version xxxx" -> "patches xxxx:"
    (setq patch-dir (%str-cat ":"
                              patch-directory-prefix 
                              (lisp-implementation-version-less-patch)
                              ":"))
    ; require that the dir name containing patches match
    ; implementation version - should the patch files themselves contain version?
    (setq patch-dir (merge-pathnames patch-dir source-dir)) 
    (when (probe-file patch-dir)
      (setq patch-files (directory (merge-pathnames patch-dir #.(make-pathname :name :wild
                                                                               :defaults *.fasl-pathname*))))
      (dolist (file patch-files)
        (multiple-value-bind (patch-n)
                             (patch-file-version (pathname-name file))
          (when all (setq patch-n (1+ patch-vers)))
          (when (and (numberp patch-n)(> patch-n patch-vers))
            (when (null newpv)(setq newpv -1))
            (when (> patch-n newpv)
              (setq newpv patch-n))
            (let ((*load-verbose* t)
                  (*record-source-file* nil)
                  (*warn-if-redefine* nil) ; - & various  other load vars
                  (*warn-if-redefine-kernel* nil))
              (load file)))))
      (when (and (null all) newpv) (setq *new-lisp-patch-version* newpv)))))
|#

(defun load-patches (&optional (source-dir (full-pathname "ccl:" :no-error nil)) all)
  (let ((patch-vers (lisp-patch-version-number))
        patch-dir
        patch-files
        patch-sources
        newpv)
    ;  "Version xxxx" -> "patches xxxx:"
    (setq patch-dir (%str-cat ":"
                              patch-directory-prefix 
                              (lisp-implementation-version-less-patch)
                              ":"))
    ; require that the dir name containing patches match
    ; implementation version - should the patch files themselves contain version?
    (setq patch-dir (merge-pathnames patch-dir source-dir)) 
    (when (probe-file patch-dir)
      (setq patch-files (directory (merge-pathnames patch-dir #.(make-pathname :name :wild
                                                                               :defaults *.fasl-pathname*))
                                   :resolve-aliases t))
      (when all
        (setq patch-sources (directory (merge-pathnames patch-dir #.(make-pathname :name :wild :type "lisp"))
                                       :resolve-aliases t)))
      (dolist (s patch-sources)
        (when (not (member (merge-pathnames  #.(make-pathname                                                                               
                                                :defaults *.fasl-pathname*)
                                             s)
                           patch-files :test #'equalp))
          (push s patch-files)))
      (dolist (file patch-files)
        (multiple-value-bind (patch-n)
                             (patch-file-version (pathname-name file))
          (when all (setq patch-n (1+ patch-vers)))
          (when (and (numberp patch-n)(> patch-n patch-vers))
            (when (null newpv)(setq newpv -1))
            (when (> patch-n newpv)
              (setq newpv patch-n))
            (let ((*load-verbose* t)
                  ;(*record-source-file* nil)
                  (*warn-if-redefine* nil) ; - & various  other load vars
                  (*warn-if-redefine-kernel* nil))
              (load file)))))
      (when (and (null all) newpv) (setq *new-lisp-patch-version* newpv)))))

(defun patch-file-version (name)
    ; look backwards for digits preceded by p
    ; return number, "pN" and  eg. "2.0b1"
    (let ((n (1- (length name)))
          dot)
      (when (>= n 1)
        (loop
          (let ((char (%schar name n)))
            (cond ((eq char #\.)  ; allow dots for eg p1.1 ??
                   (if dot (return) (setq dot t)))
                  ((digit-char-p char))
                  (t (return))))
          (if (= n 0) (return))
          (setq n (1- n)))
        (if (and (< n (1- (length name)))(>= n 0))
          (let ((char (%schar name n))) 
            (if (or (eq #\P char)(eq #\p char))
              (values (read-from-string name nil nil :start (1+ n))
                      (%substr name n (length name))
                      (%substr name 0 n))
              (values nil name name)))
          (values nil name name)))))

#|
; put on the front of a patch file
(eval-when (load)
  (when (or *warn-if-redefine* *warn-if-redefine-kernel*)
    (error "Use the function LOAD-PATCHES to load patches")))

; or
(eval-when (load)
  (when (or *warn-if-redefine* *warn-if-redefine-kernel* *record-source-file*)
    (let ((file *load-truename*) 
          (dir (car (last (pathname-directory file))))
          (patch-dir (%str-cat 
                              patch-directory-prefix 
                              (lisp-implementation-version-less-patch))))
      (cond ((string= dir patch-dir)
             (close file)
             (load-patches (make-pathname :directory (but-last (pathname-directory file)) :defaults nil))
             (throw ??))
            (t (error "~%Put this file in a directory named ~A and use the function LOAD-PATCHES~%
or if you really want to just load it without updating the patch version bind~%
*warn-if-redefine*, *warn-if-redefine-kernel* and *record-source-file* to NIL" patch-dir))))))

; or
(eval-when (load eval)
  (when (or *warn-if-redefine* *warn-if-redefine-kernel* *record-source-file*)
    (let* ((file *load-truename*) 
           (dir (car (last (pathname-directory file))))
           (patch-dir (%str-cat 
                              patch-directory-prefix 
                              (lisp-implementation-version-less-patch))))
      (cond ((string= dir patch-dir)
             (error "Use the function LOAD-PATCHES to load this file.
If you really want to load it without updating the patch
version bind *warn-if-redefine*, *warn-if-redefine-kernel* and
*record-source-file* to NIL"))
            (t (error "Put this file in a directory named ~S and use the
function LOAD-PATCHES. If you really want to load it without updating
the patch version bind *warn-if-redefine*, *warn-if-redefine-kernel*
and *record-source-file* to NIL" (%str-cat "ccl:" patch-dir ";"))))))

  (let ((who "2.0§3") (me (lisp-implementation-version-less-patch)))
    (when (not (string= (lisp-implementation-version-less-patch) who))
      (cerror "Patch will be loaded anyway." 
              (make-condition 'simple-condition
                              :format-string "This patch file is for MCL ~A. This is MCL ~A."
                              :format-arguments (list who me))))))


|#

; A very simple patch registry
(defvar *loaded-patches* nil)

(defun register-patch (name)
  (push name *loaded-patches*))

(defun list-patches ()
  (dolist (name (reverse *loaded-patches*))
    (format t "~&~a~%" name)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; This is the run-time required for "ccl:lib;patchenv"
;;;

(defloadvar *patched-slfunvs* nil)
(defloadvar *unswappable-patches* nil)
#-PPC-target
(progn
(defun swappable-immediate-p (imm offset)
  (lap-inline ((or offset 0) imm nil)
    (getint arg_x)
    (add.l arg_x arg_y)
    (move.l (a5 $Pstatic_cons_area) da)
    (if# ne
      (move.l da atemp0)
      (if# (or (and (cc (atemp0 $cons-area.gspace-start) arg_y)
                    (cs (atemp0 $cons-area.ispace-end) arg_y))
               (and (cc (a5 $vcells_start) arg_y)
                    (cs (a5 $slfuns_end) arg_y)))
        (add.w ($ $t_val) acc)))))


(defun could-be-slfun (lfun &optional old-lfun)
  (let ((lfunv (%lfun-vector lfun))
        (unswappable-imms nil)
        (could-be-slfun 0))             ; index of last used sub-function
    (declare (special could-be-slfun))          ; ugly, but saves a symbol
    (dotimes (i (%count-immrefs lfunv))
      (multiple-value-bind (imm offset) (%nth-immediate lfunv i)
        (unless (swappable-immediate-p imm offset)
          (multiple-value-bind (old-imm found?)
                               (find-swappable-imm imm offset old-lfun)
            (if found?
              (let ((imm-offset (%immediate-offset lfunv i)))
                (lap-inline (old-imm (or offset 0) imm-offset)
                  (:variable lfunv)
                  (move.l (varg lfunv) atemp0)
                  (lea (atemp0 $lfv_lfun) atemp0)
                  (getint arg_z)        ; imm-offset
                  (getint arg_y)        ; offset
                  (add.l arg_y arg_x)   ; (+ old-imm offset)
                  (move.l arg_x (atemp0 arg_z))))
              (push imm unswappable-imms))))))
    (if unswappable-imms
      (progn
        (when *unswappable-patches*
          (push (cons lfun unswappable-imms) *unswappable-patches*))
        nil)
      t)))



; Might want to make this look for a compatible lfun or list.
; Right now it just considers simple strings.
; Assumes that could-be-slfun is special-bound to an integer (as done by could-be-slfun above)
(defun find-swappable-imm (imm offset lfun)
  (declare (special could-be-slfun))
  (when lfun
    (let ((matcher (cond ((simple-string-p imm)
                          #'(lambda (imm lfun-imm)
                              (and (simple-string-p lfun-imm)
                                   (string= imm lfun-imm))))
                         ((listp imm) 'lists-matchp)
                         ((simple-vector-p imm)
                          ; This catches keyword vectors
                          #'(lambda (imm lfun-imm)
                              (and (simple-vector-p lfun-imm)
                                   (eql (length imm) (length lfun-imm))
                                   (dotimes (i (length imm) t)
                                     (unless (eq (svref imm i)
                                                 (svref lfun-imm i))
                                       (return nil))))))
                         ((functionp imm) 
                          #'(lambda (new-f old-f)
                              (when (and (%swappable-function-p old-f)
                                         (logbitp $lfatr-slfunv-bit (lfun-attributes old-f))
                                         (not (memq (%lfun-vector old-f) *patched-slfunvs*)))
                                (%set-xtab-lfun old-f new-f)
                                t))))))
      (when matcher
        (let ((lfunv (%lfun-vector lfun)))
          (dotimes (i (%count-immrefs lfunv))
            (let ((lfun-imm (%nth-immediate lfunv i)))
              (when (and (swappable-immediate-p lfun-imm offset)
                         (or (not (functionp lfun-imm))
                             (>= i could-be-slfun))
                         (funcall matcher imm lfun-imm))
                (if (functionp lfun-imm) (setq could-be-slfun i))
                (return (values lfun-imm t))))))))))
)  ; end #-PPC

#+PPC-target
(defun could-be-slfun (lfun &optional old-lfun)
  (declare (ignore lfun old-lfun))
  nil)

#-ppc-target
(defun lists-matchp (l1 l2)
  (or (eq l1 l2)
      (and (listp l1)
           (listp l2)
           (eql (list-length-and-final-cdr l1) (list-length-and-final-cdr l2))
           (labels ((match (l1 l2 hash skip-list-length?)
                      (cond ((listp l1)
                             (and (listp l2)
                                  (or skip-list-length?
                                      (eql (list-length-and-final-cdr l1)
                                           (list-length-and-final-cdr l2)))
                                  (or (eq l1 l2)
                                      (eq (gethash l1 hash t) l2)
                                      (progn
                                        (setf (gethash l1 hash) l2)
                                        (and (match (car l1) (car l2) hash nil)
                                             (match (cdr l1) (cdr l2) hash t))))))
                            ((listp l2) nil)
                            ((simple-string-p l1)
                             (and (simple-string-p l2)
                                  (string= l1 l2)))
                            (t (eq l1 l2)))))
             (match l1 l2 (make-hash-table :test 'eq) t)))))

#-ppc-target
(defun functions-matchp (new-f old-f)
  (when (and (functionp new-f) (%swappable-function-p old-f)
             (logbitp $lfatr-slfunv-bit (lfun-attributes old-f))
             (not (memq (%lfun-vector old-f) *patched-slfunvs*)))
    (%set-xtab-lfun old-f new-f)
    (logbitp $lfatr-slfunv-bit (lfun-attributes old-f))))

; slfun -must- be a swappable function jump-table entry.
; resident-lfun should be a non-swappable function with a compatible
; "signature".
#+PPC-target
(defun %set-xtab-lfun (slfun resident-lfun)
  (declare (ignore slfun resident-lfun)))           

#-PPC-target
(defun %set-xtab-lfun (slfun resident-lfun)
  (cond ((could-be-slfun resident-lfun slfun)
	 (without-interrupts
           (let* ((lfunv (%lfun-vector resident-lfun))
                  (len (uvsize lfunv))
                  (new (%make-uvector (+ len 2) $v_nlfunv)))
             (dotimes (i len) (setf (uvref new i) (uvref lfunv i)))
             (setf (uvref new len) 0) ; for disk address
             (setf (uvref new (1+ len)) 0) ; for disk address
             (setf (uvref new 0)  ; attributes moved from 2 to 0 
                   (%ilogior (ash 1 $lfatr-slfunv-bit) (uvref new 0)))
             (push new *patched-slfunvs*)
             (lap-inline (slfun new)
               (add.l ($ $lfv_lfun) arg_z)
               (move.l arg_y atemp0)   ; slfun 
               (move.w ($ #x4ef9) atemp0@+) ; jmp or something
               (move.l arg_z @atemp0)  ; 
               (jsr_subprim $sp-clrcache)))))
        (t (lap-inline (slfun resident-lfun)
             (move.l arg_y atemp0)
             (move.w ($ #x4ef9) atemp0@+)
             (move.l arg_z atemp0@+)
             (move.w ($ (ash 1 $lfatr-nopurge-bit)) @atemp0)  ; ??
             (jsr_subprim $sp-clrcache))))
  slfun)

#+PPC-target
(defun %swappable-function-p (f)
  (declare (ignore f))
  nil)

#-PPC-target
(defun %swappable-function-p (f)
  (and (functionp f)
       (lap-inline (f nil)
         (if# (and (cc (a5 $slfuns_start) arg_y)
                            (cs (a5 $slfuns_end) arg_y))
                    (add.w ($ $t_val) acc)))))



(defun re-store-setf-method (name fn &optional doc)
  (let ((old-fn (gethash name %setf-methods%)))
    (when (and old-fn (%swappable-function-p old-fn))
      (%set-xtab-lfun old-fn fn)
      (setq fn old-fn))
    (store-setf-method name fn doc)))


; A couple of functions to help with kernel patches.

#|
(defun patch-resource (type id offset old new &optional (patch-doc-string "patch"))
  (flet ((reserror ()
           (let ((code (#_ResError)))
             (unless (eql code 0)
               (%err-disp code)))))
    (declare (inline reserror))
    (let* ((copy (car (find-if #'(lambda (x)
                                   (and (equal (second x) type)
                                        (eql (third x) id)))
                               *patched-resources*)))
           (old-length (length old))
           (min-size (+ offset (* 2 (max old-length (length new)))))
           resource
           (already-patched? t))
      (macrolet ((not-patching-message (reason)
                   `(format t "~&Not adding ~a to resource '~a' ~s ~a.~%"
                            patch-doc-string type id ,reason)))
        (if copy
          (unless (>= (#_getHandleSize copy) min-size)
            (#_SetHandleSIze copy min-size)
            (unless (eql (#_GetHandleSize copy) min-size)
              (not-patching-message "because its size could not be increased.")
              (return-from patch-resource nil)))
          (progn
            (setq already-patched? nil)
            (setq resource (prog1 (#_GetResource type id) (reserror)))
            (when (%null-ptr-p resource)
              (error "There is no resource with type='a' and id=~s" type id))
            (when (%null-ptr-p (%get-ptr resource))
              (#_LoadResource resource))
            (let* ((size (#_getHandleSize resource)))
              (unless (>= size (min (+ offset old-length) min-size))
                (not-patching-message "because it is too short")
                (return-from patch-resource nil))
              (setq copy (#_NewHandle :errchk min-size))
              (when (%null-ptr-p (%get-ptr resource))
                (#_LoadResource resource))
              (#_BlockMove (%get-ptr resource) (%get-ptr copy) size))))
        (let ((offs offset))
          (dolist (word old)
            (unless (or (eql word (%hget-signed-word copy offs))
                        (eql word (%hget-unsigned-word copy offs)))
              (unless already-patched?
                (#_DisposeHandle copy))
              (not-patching-message "due to data mismatch")
              (return-from patch-resource nil))
            (incf offs 2))
          (setq offs offset)
          (dolist (word new)
            (when word
              (setf (%hget-word copy offs) word))
            (incf offs 2)))
        (unless already-patched?
          (push (list copy type id) *patched-resources*))
        copy))))
|#

#-ppc-target
(defun patch-subprim (a5-offset offset old new)
  (let ((p (%incf-ptr (%currenta5) a5-offset)))
    (when (eql #x4efa                   ; jmp pc-relative, 16-bit offset
               (%get-unsigned-word p))
      (%incf-ptr p (+ 2 (%get-signed-word p 2))))
    (let ((offs offset))
      (dolist (word old)
        (unless (or (eql word (%get-signed-word p offs))
                    (eql word (%get-unsigned-word p offs)))
          (format t "~&Not patching subprim ~s due to data mismatch.~%"
                  (let ((pair (find a5-offset *subprims8-alist* :key 'cadr)))
                    (if pair (car pair) a5-offset)))
          (return-from patch-subprim nil))
        (incf offs 2))
      (setq offs offset)
      (dolist (word new)
        (when word (setf (%get-word p offs) word))
        (incf offs 2)))
    p))

;;;;;;;;;;
;; Stuff for converting strings - moved from l1-aprims



(defun convert-string (string from-encoding to-encoding)    
  (if (or (eql from-encoding to-encoding)(and (or (eql from-encoding #$kCFStringencodingmacroman)(eql from-encoding #$kcfstringencodingutf8))
                                              (eql to-encoding #$KCFStringEncodingUnicode)
                                              (7bit-ascii-p string)))
    string
    (let ((in-len (length string))
          (strb 0))
      (multiple-value-setq (string strb)(array-data-and-offset string))
      (require-type string 'simple-string)
      (when (neq strb 0)(error "can't deal with offset string today"))      
      (let* ((from-buf-len (cond 
                            ((eql from-encoding #$kCFStringEncodingUnicode) (%i+ in-len in-len))
                            ((eql from-encoding #$kCFStringEncodingUTF8) in-len)
                            (t (byte-length string from-encoding strb (+ in-len strb)))))
             (loss-byte #xff) ;; ??
             outstring)
        (declare (fixnum in-len from-buf-len))        
        (%stack-block ((from-buf from-buf-len :clear t))
          ;; put chars in from-buf -- two-byte-script-p really means not single-byte
          (cond ((eql from-encoding #$kCFStringEncodingUnicode)
                 (if (extended-string-p string)  ;; pretty likely true
                   (%copy-ivector-to-ptr string 0 from-buf 0 from-buf-len)
                   (dotimes (i in-len)
                     (%put-word from-buf (%scharcode string i) (%i+ i i)))))
                ((not (two-byte-encoding-p from-encoding))
                 (if (base-string-p string)
                   (%copy-ivector-to-ptr string 0 from-buf 0 from-buf-len)
                   (dotimes (i in-len)
                     (%put-byte from-buf (%scharcode string i) i))))
                (t
                 (let ((buf-idx 0))
                   (dotimes (i in-len)
                     (let ((c (%scharcode string i)))
                       (cond ((%i> c #Xff)                            
                              (%put-word from-buf c buf-idx)
                              (setq buf-idx (%i+ 2 buf-idx)))
                             (t (%put-byte from-buf c buf-idx)
                                (setq buf-idx (%i+ 1 buf-idx)))))))))
          (with-macptrs ((cfstr (#_CFStringCreateWithBytes (%null-ptr) from-buf
                                 from-buf-len from-encoding nil)))
            ;; surely there is a better way to learn this!
            (when (%null-ptr-p cfstr)(error "From encoding ~S not valid in this installation." from-encoding)) ;; e.g. japanese when not installed
            (unwind-protect
              (let ((uni-len (#_CFStringGetLength cfstr))) ;; number of 16 bit unicode chars
                ;; get bytes from cfstr to to-buf to a string
                (cond 
                 ((eql to-encoding #$kCFStringEncodingUnicode)
                  (let* ((to-len (%i+ uni-len uni-len)))
                    (setq outstring (make-string uni-len :element-type 'extended-character))
                    (%stack-block ((to-buf to-len :clear t))                        
                      (CFStringGetCharacters cfstr 0 uni-len to-buf)
                      (%copy-ptr-to-ivector to-buf 0 outstring 0 to-len))))
                 (t 
                  (rlet ((used-len :signed-long)) ;; signed??
                    (CFStringGetBytes cfstr 0 uni-len to-encoding loss-byte nil *null-ptr* 0 used-len)
                    (let ((to-len (%get-signed-long used-len)))
                      (%stack-block ((to-buf to-len))
                        (CFStringGetBytes cfstr 0 uni-len to-encoding loss-byte nil to-buf to-len used-len)
                        (cond 
                         ((not (two-byte-encoding-p to-encoding))
                          ;; just make a string of 8 bit bytes                    
                          (setq outstring (make-string to-len :element-type 'base-character))
                          (%copy-ptr-to-ivector to-buf 0 outstring  0 to-len))
                         (t 
                          (let* ((to-script (encoding-to-script to-encoding))
                                 (chartable (get-char-byte-table to-script))
                                 (char-pos 0)
                                 first-byte)
                            (when (not chartable)(error "Convert-string confused re encoding ~s" to-encoding))
                            (setq outstring (make-string uni-len :element-type 'extended-character))  ;; length not always rignt
                            (dotimes (i to-len)
                              (let ((c (%get-unsigned-byte to-buf i)))
                                (cond ((not chartable) 
                                       (setf (%scharcode outstring char-pos) c)
                                       (incf char-pos))
                                      (first-byte 
                                       (setf (%scharcode outstring char-pos)
                                             (%ilogior (lsh first-byte 8) c))
                                       (incf char-pos)
                                       (setq first-byte nil))
                                      ((eq (aref chartable c) #$smSingleByte)
                                       (setf (%scharcode outstring char-pos) c)
                                       (incf char-pos))
                                      (t (setq first-byte c)))))
                            (when (neq char-pos uni-len) (error "convert-string failed"))))))))))
                outstring)
              (#_CFRelease cfstr))
            ))))))

;; fix it
(def-ccl-pointers fix-fred-word ()
  (if (base-string-p *fred-word-constituents*)
    (setq *fred-word-constituents* (convert-string *fred-word-constituents* #$kcfstringencodingmacroman #$kcfstringencodingunicode))))

;; fontname is  empty string unless weird like dingbats - thank you Marco Piovanelli 
(defun encoding-to-script-info (encoding)
  (rlet ((scriptid :signed-integer)
         (langid :signed-integer)
         (fontname :str255))
    (let ((err (#_RevertTextEncodingToScriptInfo encoding scriptid langid fontname)))
      (if (neq err #$Noerr)
        (values nil nil nil)  ;; or nil?
        (let ((fontname (if (eq 0 (%get-byte fontname)) nil (%get-string fontname)))
              (scriptval (%get-signed-word scriptid)))
            (values scriptval
                    (%get-signed-word langid)
                    ;; fontname returned is NIL unless weird like dingbats
                    fontname))))))

;; does not work for non-roman - paramerr - fixed now
#|
(defun font-to-encoding2 (fontid)
  (rlet ((fontname :str255)
         (encoding :ptr))
    (let ((script (#_fonttoscript fontid)))
      (#_getfontname fontid fontname) ;(print (%get-string fontname))
      (errchk (#_UpgradeScriptInfoToTextEncoding script 
             #$ktextlanguagedontcare
             #$ktextregiondontcare 
                fontname 
                encoding))
      ;; what is the high half about?
      (%get-unsigned-long encoding))))
|#

;; better
(defun font-to-encoding (fontid)
  (rlet ((fontname :str255)
         (encoding :ptr))
    (declare (ignore-if-unused fontname))
    (let () ;(script (#_fonttoscript fontid)))
      ;(#_fmgetfontfamilyname fontid fontname) (print (%get-string fontname))
      (errchk (#_FMGetFontFamilyTextEncoding FONTID ENCODING))
      ;; what is the high half about? #$kMacRomanEuroSignVariant
      (%get-unsigned-long encoding))))



#|
(deftrap-inline "_GetTextAndEncodingFromCFString" 
      ((inString :pointer) (outText (:pointer :unsigned-byte)) (inTextMaxLength :unsigned-long)
       (outTextLength (:pointer :unsigned-long)) (outEncoding (:pointer :unsigned-long))) 
  :osstatus
   () )
|#

#|  ;; unused
(defvar *bad-unicode* #xffff)
(defun unicode-to-char-and-encoding (ucharcode)
  (rlet ((out-len :unsigned-long)
         (out-encoding :unsigned-long))
    (%stack-block ((in-buf 4)(out-buf 4))
      (%put-word in-buf ucharcode 0)
      (with-macptrs ((cfstr (#_CFStringCreateWithCharacters (%null-ptr) in-buf 1)))
        (unwind-protect
          (let ((uni-len (#_CFStringGetLength cfstr) )) ;; number of 16 bit unicode chars
            (if (neq uni-len 1)(error "barf ~X" ucharcode))
            (rlet ()
              (let ((err (#_GetTextAndEncodingFromCFString cfstr out-buf 2 out-len out-encoding)))
                (if (eq err #$noerr)
                  (let* ((out-bytes (%get-unsigned-long out-len))
                         (out-encoding (%get-unsigned-long out-encoding)))
                    (multiple-value-bind (out-script langid fontname)
                                         (encoding-to-script-info out-encoding)
                      (declare (ignore langid))
                      (if (eq out-bytes 1)
                        (let ((out-byte (%get-byte out-buf 0)))
                          (if (and (eq #$smroman out-script)
                                   (eq out-byte #.(char-code #\?))
                                   (neq ucharcode out-byte))
                            (values *bad-unicode* #$smroman)
                            (values out-byte out-script fontname)))
                        (if (eq out-bytes 2)
                          (values (%get-word out-buf 0)
                                  out-script fontname)
                          (error "phooey ~X" out-bytes)))))
                  (%err-disp err)))))
          (#_cfrelease cfstr))))))
|#


;; if used for anything real do it efficiently
(defun char-and-encoding-to-unicode (charcode encoding)
  (let* ((str (string (code-char charcode)))
         (outstr (convert-string str encoding #$kcfstringencodingunicode)))
    (%scharcode outstr 0)))

#|
(unicode-to-char-and-encoding #x3601)  ;; should be korean - ain't
(unicode-to-char-and-encoding #x82a0)  ;; seems to be something ChineseTrad
(unicode-to-char-and-encoding #x3042)  ;; should be Hiragana = Japanese  res is 0x82a0?? 
(unicode-to-char-and-encoding #x2701)  ;; its dingbats

|#

(defparameter encoding-to-name-table 
  (make-array 42 :initial-contents 
              '("MacRoman" "MacJapanese" "MacChineseTrad" "MacKorean" "MacArabic" "MacHebrew"
                "MacGreek" "MacCyrillic" "Unknown" "MacDevanagari" "MacGurmukhi" "MacGujarati"
                "MacOriya" "MacBengali" "MacTamil" "MacTelugu" "MacKannada" "MacMalayalam"
                "MacSinhalese" "MacBurmese" "MacKhmer" "MacThai" "MacLaotian" "MacGeorgian"
                "MacArmenian" "MacChineseSimp" "MacTibetan" "MacMongolian" "MacEthiopic" "MacCentralEurRoman"
                
                "MacVietnamese" "MacExtArabic" "Unknown"
                ;;; The following use script code 0, smRoman
                "MacSymbol" "MacDingbats"
                "MacTurkish" "MacCroatian" "MacIcelandic" "MacRomanian" "MacCeltic" "MacGaelic"
                "MacKeyboardGlyphs")))

;; also sometimes suffices for script to name 
(defun encoding-to-name (encoding)
  (let ((it encoding)) ;(logand encoding #XFFFF))) ;; ??
    (IF (>= IT (length encoding-to-name-table))
      (case encoding
        (#.#$kCFStringEncodingUnicode "Unicode")
        (#.#$kCFStringEncodingUtf8 "UTF8")
        (#.#$kCFStringEncodingASCII "7bitASCII")
        (#.#$kcfstringencodingMacVT100 "VT100")
        (t (text-encoding-name encoding)))
      (aref encoding-to-name-table it))))

(defun text-encoding-name (text-encoding)
  "returns name of the text-encoding."
  (%stack-block ((text-ptr 64))
    (rlet ((outlen :uint32))
      (let ((err (#_GetTextEncodingName
                  text-encoding
                  #$kTextEncodingFullName
                  0
                  0
                  64
                  outlen
                  (%null-ptr)
                  (%null-ptr)
                  text-ptr)))
        (when (eq err #$noerr)
          (let* ((len (%get-long  outlen))
                 (string (make-string len :element-type 'base-char)))
            (declare (fixnum len))
            (%copy-ptr-to-ivector text-ptr 0 string 0 len)            
            string))))))

(defun script-to-font (script)
  (if (not (script-installed-p script))
    (error "Script ~s ScriptId ~s is not installed" (encoding-to-name script) script)
    (let ((poo (#_getscriptvariable script #$smScriptAppFond)))
      (%stack-block ((str 256))
        (#_getfontname poo str)
        (let ((name (%get-string str)))
          (values poo name))))))

;; older version in l1-streams - boot problem of some sort


;; older version allows boot on OS9 = this still errors on both OS9 and OSX - fixed I think
(defun read-scriptruns (truename)
  (let ((truename (truename truename))
        scriptruns fredp refnum)
    (rlet ((fsref :fsref))
      (make-fsref-from-path-simple truename fsref)      
      (unwind-protect 
        (unless (eq -1 (setq refnum (open-resource-file-from-fsref fsref #$fsrdperm)))
          (with-macptrs ((fred4 (#_Get1Resource :FRED 4))
                         (fred2 (#_Get1Resource :FRED 2)))
            (unless (%null-ptr-p fred2)
              (setq fredp t))             ; want to know if Fred wrote this file
            (unless (%null-ptr-p fred4)
              (#_LoadResource fred4)
              (let ((n (ash (#_GetHandleSize fred4) -2)))
                (declare (fixnum n))
                (setq scriptruns (make-array n :element-type '(unsigned-byte 32))) ; 5/26
                (dotimes (i n)
                  (setf (uvref scriptruns i) (%hget-unsigned-long fred4 (ash i 2))))))))
        (unless (eq refnum -1)
          (#_CloseResFile refnum)))
      ;; WHAT ?? - do things the easy way if all macroman
      (when (and scriptruns (eq (length scriptruns) 2)(eq 0 (uvref scriptruns 0)) (eq 0 *input-file-script*))
        (setq scriptruns nil))
      (values scriptruns fredp))))


            


    
#|
(setq foo (convert-string "abÄc" #$kcfstringencodingMacRoman #$kCFStringEncodingUnicode)) ; ok
(convert-string foo #$kCFStringEncodingUnicode #$kcfstringencodingUTF8) ;; OK
(convert-string foo #$kCFStringEncodingUnicode #$kcfstringencodingMacRoman) ;; ok


(setq bar (convert-string "abÄc" #$kcfstringencodingUnicode #$kcfstringencodingUTF8)) ;; ok
(convert-string bar #$kcfstringencodingUTF8 #$kcfstringencodingUnicode) ;; ok

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; redefine some bits of nfasload.lisp for fsref etc.


(eval-when (:compile-toplevel :execute)

(require "FASLENV" "ccl:xdump;faslenv")
;(require "PPC-LAPMACROS" "ccl:compiler;ppc;ppc-lapmacros")

)

;; seems to work
(defparameter *doing-new-fasload* nil)

(when (not (fboundp '%oldfasload))
  (setf (symbol-function '%oldfasload)(symbol-function '%fasload)))


(defun %fasl-read-buffer (s)
  (cond 
   (*doing-new-fasload*  (%newfasl-read-buffer s))
   (t (let* ((pb (faslstate.fasliopb s))
             (buffer (faslstate.iobuffer s))
             (bufptr (%get-ptr buffer)))
        (declare (dynamic-extent bufptr)
                 (type macptr buffer bufptr pb))
        (%setf-macptr bufptr (%inc-ptr buffer 4))
        (setf (%get-ptr buffer) bufptr)
        (setf (%get-long pb $iobytecount) $fasl-buf-len)
        (setf (%get-ptr pb $iobuffer) bufptr)
        (setf (%get-word pb $ioPosMode) $fsatmark)
        (PBReadSync  pb)
        (if (= (the fixnum (setf (faslstate.bufcount s)
                                 (%get-unsigned-long pb $ioNumDone)))
               0)
          (%err-disp (%get-signed-word pb $ioResult)))))))

(defun %newfasl-read-buffer (s)
  (let* ((pb (faslstate.fasliopb s))
         (buffer (faslstate.iobuffer s))
         (bufptr (%get-ptr buffer)))
    (declare (dynamic-extent bufptr)
             (type macptr buffer bufptr pb))
    (%setf-macptr bufptr (%inc-ptr buffer 4))
    (setf (%get-ptr buffer) bufptr)
    #|
    (setf (%get-long pb $iobytecount) $fasl-buf-len)
    (setf (%get-ptr pb $iobuffer) bufptr)
    (setf (%get-word pb $ioPosMode) $fsatmark)
    |#
    (setf (pref pB :fsforkioparam.buffer) bufptr
          (pref pb :FSForkIOParam.requestCount) $fasl-buf-len
          (pref pb :FSForkIOParam.positionMode) #$fsAtMark) 
    
    (let ((err (#_PBReadForkSync  pb)))
      (if (= (the fixnum (setf (faslstate.bufcount s)
                               (pref pb :fsforkioparam.actualcount)))
             0)
        (%err-disp err)))))

(defun %fasl-set-file-pos (s new)
  (cond 
   (*doing-new-fasload* (%newfasl-set-file-pos s new))
   (t 
    (let* ((pb (faslstate.fasliopb s))
           (posoffset (%get-long pb $ioposoffset)))
      (if (>= (decf posoffset new) 0)
        (let* ((count (faslstate.bufcount s)))
          (if (>= (decf count posoffset ) 0)
            (progn
              (setf (faslstate.bufcount s) posoffset)
              (incf (%get-long (faslstate.iobuffer s)) count)
              (return-from %fasl-set-file-pos nil)))))
      (progn
        (setf (%get-long pb $ioPosOffset) new
              (%get-word pb $ioPosMode) $fsFromStart)
        (setf (faslstate.bufcount s) 0)
        (let ((res (PBSetFPosSync pb)))
          (unless (eql res #$noerr)
            (error (format nil "~d" res)))))))))


(defun %newfasl-set-file-pos (s new)
  (let* ((pb (faslstate.fasliopb s))
         (posoffset (unsignedwide->integer (pref pb :fsforkioparam.positionoffset))))
    (if (>= (decf posoffset new) 0)
      (let* ((count (faslstate.bufcount s)))
        (if (>= (decf count posoffset ) 0)
          (progn
            (setf (faslstate.bufcount s) posoffset)
            (incf (%get-long (faslstate.iobuffer s)) count)
            (return-from %newfasl-set-file-pos nil)))))
    (progn
      (setf (pref pb :FSForkIOParam.positionOffset.hi) (ldb uw-hi new)
            (pref pb :FSForkIOParam.positionOffset.lo) (ldb uw-lo new)
            (pref pb :FSForkIOParam.positionMode) $fsFromStart)
      (setf (faslstate.bufcount s) 0)
      (let ((res (#_PBSetForkPositionSync pb)))
        (unless (eql res #$noerr)
          (error (format nil "~d" res)))))))

(defun %fasl-get-file-pos (s)
  (cond (*doing-new-fasload* (%newfasl-get-file-pos s))
        (t 
         (- (%get-long (faslstate.fasliopb s) $ioposoffset) (faslstate.bufcount s)))))

(defun %newfasl-get-file-pos (s)  ;; yuck
  (let ((pb (faslstate.fasliopb s)))
    (- (unsignedwide->integer (pref pb :fsforkioparam.positionoffset))  (faslstate.bufcount s))))

;; arg shouldn't be a string - should be a pathname for newfasload

(defun %fasload (string &optional (table *fasl-dispatch-table*)
                        start-faslops-function
                        stop-faslops-function)
  (cond 
   (*using-new-fasload* (%newfasload string table start-faslops-function
                                     stop-faslops-function))
   (t (%oldfasload string table start-faslops-function
                                     stop-faslops-function))))



(defun %newfasload (filename &optional (table *fasl-dispatch-table*)
                        start-faslops-function
                        stop-faslops-function)  
  (let ((fname (data-fork-name))
        (*doing-new-fasload* t))
    (let* ((s (%istruct
               'faslstate
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil)))
      (declare (dynamic-extent s))
      (setf (faslstate.faslfname s) filename)  ;; whats that for?
      (setf (faslstate.fasldispatch s) table)
      (setf (faslstate.faslversion s) 0)
      (setq filename (full-pathname filename)) ;; <<
      (rletZ ((pb :fsforkioparam)
              (fsref :fsref))
        (multiple-value-bind (resref is-dir)(make-fsref-from-path-simple filename fsref)  ;; I think filename will be truename
          (cond ((not resref) (%err-disp $fnferr filename))
                (is-dir (%err-disp $xdirnotfile filename))))
        (%stack-block ((buffer (+ 4 $fasl-buf-len)))
          (setf (faslstate.fasliopb s) pb
                (faslstate.iobuffer s) buffer)
          (let* ((old %parse-string%))
            (setq %parse-string% nil)    ;  mark as in use
            (setf (faslstate.oldfaslstr s) old
                  (faslstate.faslstr s) (or old (make-string 255 :element-type 'base-character)))
            
            (flet ((%fasl-open (s)
                     (let* ((ok nil)
                            (pb (faslstate.fasliopb s))
                            (err #$noErr))
                       (setf (pref pb :FSForkIOParam.ref) fsref
                             (pref pb :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)
                             (pref pb :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
                             (pref pb :FSForkIOParam.permissions) #$fsrdperm)
                       #|
                     (setf (%get-ptr pb $iofilename) name
                           (%get-long pb $ioCompletion) 0
                           (%get-byte pb $ioFileType) 0
                           (%get-word pb $ioVrefNum) 0
                           (%get-byte pb $ioPermssn) $fsrdperm
                           (%get-long pb $ioOwnBuf) 0)
                     |#
                       (if (and (eql #$noErr (setq err (#_PBOpenForkSync pb)))                              
                                (eql #$noErr (setq err (#_PBGetForkSizeSync pb))))
                         (let ((eof (unsignedwide->integer (pref pb :FSForkIOParam.positionOffset))))      
                           (if (< eof 4)
                             (setq err $xnotfasl)
                             (progn
                               (setf (faslstate.bufcount s) 0)
                               (let* ((signature (%fasl-read-word s)))
                                 (declare (fixnum signature))
                                 (if (= signature $fasl-file-id)
                                   (setq ok t)
                                   (if (= signature $fasl-file-id1)
                                     (progn
                                       (%fasl-set-file-pos s (%fasl-read-long s))
                                       (setq ok t))
                                     (setq err $xnotfasl)))))))
                         (unless (eql err #$noErr) (setf (faslstate.faslerr s) err)))
                         ok)))
              (unwind-protect
                (when (%fasl-open s)
                  (let* ((nblocks (%fasl-read-word s))
                         (*pfsl-library-base* nil)
                         (*pfsl-library* nil))
                    (declare (fixnum nblocks))
                    (declare (special *pfsl-library-base* *pfsl-library*))
                    (unless (= nblocks 0)
                      (let* ((pos (%fasl-get-file-pos s)))
                        (dotimes (i nblocks)
                          (%fasl-set-file-pos s pos)
                          (%fasl-set-file-pos s (%fasl-read-long s))
                          (incf pos 8)
                          (when start-faslops-function (funcall start-faslops-function s))
                          (let* ((version (%fasl-read-word s)))
                            (declare (fixnum version))
                            (if (or (> version (+ #xff00 $fasl-vers))
                                    (< version (+ #xff00 $fasl-min-vers)))
                              (%err-disp (if (>= version #xff00) $xfaslvers $xnotfasl))
                              (progn
                                (setf (faslstate.faslversion s) version)
                                (%fasl-read-word s) 
                                (%fasl-read-word s)       ; Ignore kernel version stuff
                                (setf (faslstate.faslevec s) nil
                                      (faslstate.faslecnt s) 0)
                                (do* ((op (%fasl-read-byte s) (%fasl-read-byte s)))
                                     ((= op $faslend))
                                  (declare (fixnum op))
                                  (%fasl-dispatch s op))
                                (when stop-faslops-function (funcall stop-faslops-function s))
                                ))))))))
                (setq %parse-string% (faslstate.oldfaslstr s))
                (#_PBCloseForkSync pb))
                   (let* ((err (faslstate.faslerr s)))
                     (if err
                       (values nil err)
                       (values t nil))))))))))




(setq *using-new-fasload* t)

(defmethod application-pathname-to-window-title ((app lisp-development-system)
                                                 (window fred-window)
                                                 pathname)
  (pathname-to-window-title pathname nil)  ;; include directory info
  )


(defmethod application-pathname-to-window-title ((app application)
                                                 (window window)
                                                 pathname)
  (pathname-to-window-title pathname t)  ;; omit directory info
  )

;;; stuff for resources in data fork

;;  copy resource fork of source
;; to data fork of dest

(defun copy-res-to-data (old-path new-path)
  (setq old-path (truename old-path))
  (setq new-path (full-pathname new-path))
  (rletz ((srcfsref :fsref)
          (dstfsref :fsref))
    (path-to-fsref old-path srcfsref)
    (if (not (probe-file new-path))
      (fscreate-res-file new-path t))
    (path-to-fsref new-path dstfsref)
    (%copy-fork2 srcfsref dstfsref T nil 8192)))





(provide "PATHNAMES")

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
