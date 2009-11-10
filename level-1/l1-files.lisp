;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 4/1/97   akh  see below
;;  21 9/13/96 akh  pathnamep returns conditionally, more checks for nonsense in directory namestrings
;;                  pathname-host-sstr may return :unspecific
;;  18 9/4/96  akh  put back pathnamep (from l0-pred)
;;  17 7/30/96 akh  pathname-host of string - same as (pathname-host (pathname string)) when no dir
;;  15 7/26/96 akh  remove support for old logical directories
;;  11 5/20/96 akh  open-res-file calls truename for alias resolution
;;  9 3/9/96   akh  fix create-file when type and creator are not default
;;  7 2/19/96  akh  remove :up's in %std-directory-component
;;  3 10/17/95 akh  merge patches
;;  2 10/12/95 akh  no more Lap for PPC
;;  17 6/8/95  slh  move choose-file-ddir
;;  12 5/23/95 akh  mac-file-write-date long
;;  10 5/22/95 akh  added mac-file-xx-date functions
;;  3 4/6/95   akh  set-choose-file-default-directory gets full name
;;  2 4/4/95   akh  no change
;;  10 3/20/95 akh  add Kalmans file size utilities
;;  6 3/2/95   akh  use application-file-creator
;;  5 2/21/95  slh  removed naughty word (file is public now)
;;  4 1/30/95  akh  fixes to make-pathname, merge-pathnames from patch,
;;                  and %path-getdirinfo from alias-file-patch
;;  (do not edit before this line!!)

;; L1-files.lisp - Object oriented file stuff
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2006 Digitool, Inc.

; Modification History
;; pathname errors not parse-error
;; open-resource-file-from-fsref, %open-res-file2, fscreate-res-file get optional data-fork-p arg
;; full-pathname-++ - cons less
;; find-all-the-volumes2 - continue rather than error when encounter error other than #$nsverr
;; comment out some os9 code
;; require call  choose-file-dialog with :button-string "Load"
;; ------ 5.2b6
;; mac-default-directory just call startup-directory - no more fsspec
;; add and use function remove-path-from-hashes
;; delete-file returns second value - T if moved to trash
;; delete-file - fix the move to trash call !!, better version of move-fsref-to-trash
;; my-fsref-make-path more politically correct, delete some commented out code
;; %path-from-fsref - only use cache for files not directories - maybe fixed now
;; print-object of pathname - don't use cache
;; %path-from-fsref - use a hash table namestring-path-hash - key posix-namestring, val pathname - try to make case match file system
;; fix find-all-the-volumes2, full-pathname-++
;; move-fsref-to-trash tries sleepticks, #_fsdeleteobject agin before doing move to trash, delete-file tries to handle failure of move-fsref-to-trash
;; %path-std-quotes - fix for ∂∂
;; remove warning about "file moved to trash because delete-file failed"
;; ---- 5.2b5
;; remove obsolete stuff from pathname function
;; ---- 5.2b3
;; %load handles :utf8
;; move-fsref-to-trash works harder
;; define and use functions cfstringgetbytes/characters rather than redefining traps
;; move-fsref-to-trash does #_fnnotify
;; add a startup function to add or remove :interfaces-3 from *features*
;; don't say :errchk to pbhsetvolsync
;; parse-namestring - no error if stream has no pathname??
;; 07/03/05 %directory-list-namestring less eager to make extended-string
;; get rid of calls to maybe-make-encoded-string
;; get rid of use of *pathname-escape-character-unicode* - it is  = *pathname-escape-character*
;; new version of get-cfstr
;; make-encoded-string doesn't if type is unicode
;; lose some macroman and encoded-string stuff
;; get-cfstr doesn't try for macroman and doesn't make-encoded-string, print-object of encoded-string don't do #U business
;; fix load of utf files (utf-16 only).
;; if delete-file of a temporary-file fails, move it to trash
;; ------- 5.1final
;; add :temporary-file-p arg to delete-file for Norton Anti Virus crap.
;; fix probe-file-x because path-to-fsref is not what we expected
;; path-to-fsref returns a third value, is-alias - probe-file heeds it
;; probe-file fix to return nil if input is not a dir and path-to-fsref returns a dir and vv
;; "/volumes/" => "/Volumes/" for superstitious reasons
;; full-pathname-++ conses a little less, delete some old unused code
;; fix for volume names case dependent on osx - see full-pathname-++ (this sucks), fix create-file re errno something other than dupfnerr
;; ----- 5.1b2
;; 05/12/04 delete-file also tries desktop if no dir provided
;; 05/06/04 get/set file dates do probe-file - ret nil if file no exist, exchange-files does truename vs full-pathname
;; 05/05/04 fix mac-file-type-or-creator  and set-... to do truename, delete-file uses mac-default-directory if no dir, can delete alias to a volume
;; 04/14/04 file-x-date returns nil vs error if file does not exist
;; 04/08/04 %load passes external-format to recursive calls
;; 03/21/04 probe-file-x plugs in default-dir if none provided
;; 03/06/04 string-string-equal -> string-equal
;; 02/20/04 make-pathname - don't behave merge-pathnames wise when directory provided
;; resolve-alias-from-fsref-quiet and *alias-resolution-policy* to provide mechanism for quiet alias resolution
;; make-fsref-from-path-resolve-dir-aliases2 - deal with mid path aliases correctly (or at least better)
;; make probe-file return the same thing on weird cases like offline pgp volumes that it did in 5.0
;; Don't use pascal-true and deal with pointers to booleans right
;; mac-namestring - put back translate-logical-pathname but still omit merge-pathnames
;; get-cfstr - don't error if macroman length not what one might expect it to be
;; define encoded-compare, use it in string-string-equal
;; -------- 5.1b1
;; 12/04/03 probe-file plugs in default-dir if none provided
;; simplify findfolder
;; reorder so some stuff is defined before use - so one can load the file in the 5.0 release
;; new print-object of encoded-string
;; some junk to avoid  *default-pathname-defaults* when not appropriate - not fond of *default-pathname-defaults*  
;; add get-mangled-pathname for mac-namestring of long name  or encoded/unicode name on OS9
;; small tweak in %path-from-fsref
;; move 7bit-ascii-p-ustr here too
;; move some hfsunistr functions here from pathnames.lisp
;; use %str-member vs position in %path-from-fsref - boot-probs
;; add %str-cat-maybe-encoded
;; parse-namestring knows about encoded strings
;; %directory-string-list knows about encoded-strings, also %std-directory-component
;; fix maybe-encoded-strcat when mixed types
;; exchange-files obeys its errchk arg 
;; remove escapes before going to file system in a bunch of places
;; fix delete-file to delete alias vice target, delete directories too
;; file-info less pessimal, also mac-file-creator etal
;; use hash table for posix-namestring and posix-dir-string
;; fix in resolve-dir-aliases-forward, fix os9 %path-from-fsref, %std-name-and-type know about encoded-strings
;; %open-res-file2 finally manages to create a res fork if no exist
;; fix alias-path-p for volume alias, probe-file a little faster when aliases
;; boot-directory computed once
;; define *pathname-escape-character-unicode*
;; set-mac-file-creator had a bug
;; findfolder gets createp arg
;; alias-path-p uses fsref
;; the new version of create-file was/is fukt - fixed
;; findfolder uses fsref
;; akh mac-default-directory uses fsref - is it the same as before? - not really
;; bunch of changes for Unicode pathnames, encoded-strings, fsrefs  etc.
;; -------- 5.0final
;; ss    alias-path-p now resolves to correct pathname when called on a folder alias without
;;       a trailing colon. Previously, the last element in the path was repeated.
;; ----- 5.0b7
;; maybe *do-unix-hack* in %load
;; ----- 5.0b3
;; fix typo in error message in %directory-string-list
;; akh %load accepts files of type :???? which may be or may not be fasl's
;; --------- 4.4b5
; akh ad hoc crock in create-file
; akh fix call to findfolder in %path-getdirinfo for OSX
; akh load tolerates 0 mac-file-type - gag
;; --------- 4.4b3
; 11/25/01 akh clear-namestring-caches -> startup-functions as well as cleanup-functions
; 07/05/01 export alias-path-p
; 06/25/01 akh lose special case "0" in pathname-version-sstr 
; -------- 4.4b1
; 12/23/99 akh find-module-pathnames returns logical vs physical??
; 12/12/99 akh %path-from-stream - signal-type-error
;---------- 4.3f1c1
;06/06/99 akh clear-namestring-caches - don't if locked
;----------- 4.3b2
; 05/06/99 akh parse-error
; 04/28/99 akh %load gets directory included in *loading-file-source-file*
; 04/19/99 akh some caching for namestrings - presumes nobody bashes pathname fields - *use-namestring-caches* nil to shut it off
;;           ?? is there a problem with aliases ?? mebbe not.
; 04/19/99 akh merge-pathnames works if defaults is nil
; 04/12/99 akh alias-path-p gets its dont-resolve arg back
; 03/19/99 akh remove-up again, also most callers do copy-list
; 03/15/99 akh probe-file checks (directory-pathname-p *default-pathname-defaults*) for dirp
;;           create-file checks directory-pathname-p of full-path vs path.
;;------------ 4.3b1
; 03/03/99 akh from Richard Billington allow pathname-name :unspecific
; 02/28/99 akh alias-path-p returns 2 values, the second value tells if the target is or isn't there
; 02/15/99 akh choose-new-directory-dialog has a more sensible button-string
; 02/14/99 akh require and load deal with possible list from choose-file-dialog
; 12/18/98 akh pb-resolve-alias - remove dirflg from pb if resolve fails
; 10/10/98 akh  remove-up
; 03/11/97 bill %file-size & file-info error if the "file" is a directory.
; ------------- 4.0
; 9/24/96 slh   overwrite-dialog: fix the message text some more
; 09/24/96 bill overwrite-dialog now reports the file name instead of "filename".
;               Thanks to John Wiseman.
; ------------- 4.0b2
; 9/11/96 slh   find-load-file: recognize pathname-type :unspecific, merge with
;               file types before doing probe-file
;09/07/96 gb    put pathnamep back in l0-pred.
;07/29/96 bill  In initializing semi-pos, pathname-host-sstr ensures that pos is non-NIL before
;               blindly %schar'ing.
;07/01/96 bill  findfolder passes NIL, not (%null-ptr) for the create arg to #_FindFolder
; 6/06/96 slh   parse-namestring fix from patch
;05/24/96 bill  %path-from-params special cases the desktop folder.
;05/06/96 bill  slh's fix to require. It now looks for mac-file-type of :pfsl, not :fasl
;               on ppc-target.
;-------------  MCL-PPC 3.9
;04/03/96 bill  compile-load uses *.lisp-pathname* instead of ".lisp".
;04/26/96 bill  %directory-string-list no longer accesses off the end of the string.
;03/26/96  gb   lowmem accessors.
;02/11/96 bill  James Anderson's fix to the "Load other file..." restart in LOAD
;11/29/95 bill  #_PBxxx -> #_PBxxxSync to avoid trap emulator
;11/12/95 gb    #_H* -> #_PBH* to avoid confusion with interfaces' definitions.
;11/08/95 bill  #_PBExchangeFiles -> #_PBExchangeFilesSync
;               #_PBSetCatInfo -> #_PBSetCatInfoSync
; 6/09/95 slh   Kalman's load patches
; 6/07/95 slh   move CFDs to new-file-dialogs, include old-file-dialogs due
;               to bugs in CustomGetFile (thanks DTS for verifying our fears!)
; 6/01/95 slh   set-choose-file-default-directory: no-error optional argument
;               should really have CFD callers specify whether to do logical xlations
; 5/26/95 slh   alternates for :str255/63
; 5/22/95 slh   %file-date: return nil if error
; 5/19/95 slh   use string-equal on module strings, not string=
; 5/17/95 slh   %file-date: errchk optional, for menu updating niceness
; 4/26/95 slh   use old-file-dialogs module if necessary
; 4/13/95 slh   sf-choose-file-hook: don't set name field - it sets the
;               selection to the end of the list
; 4/11/95 slh   overwrite-dialog: folded in application method
; 3/24/95 slh   choose-file-dialog, choose-directory-dialog: handle :directory "vol:dir",
;               "vol:dir:", and "vol:dir:file"
; 3/11/95 slh   all new choose file/dir functions
; 3/01/95 slh   new Choose Directory dialog - oh oh, may require System 7
; 2/28/95 slh   %path-get-long-dir-info reports real error
; 2/27/95 slh   sf-choose-directory-hook: new item numbers for select, cancel
;-------------- 3.0d17
;    ?    alice
; incorporate alias-file-patch in %path-getdirinfo
; fix make-pathname removing double inclusion of relative default
; kalmans fix to merge-pathnames
; find desktop folder the PC way, added function findfolder (vrefnum ostype)
;--------
;07/29/93 bill  alias-path-p now takes an optional dont-resolve arg.
;06/26/93 bill  put-external-scrap in choose-new-file-dialog
;-------------- 3.0d11
;07/13/93 alice find-load-file - call full-pathname with no-errorp nil
;06/16/93 alice %path-quoted-p and %directory-list-namestring are fat string aware
;06/16/93 alice %path-from-iopb calls %std-name-and-type to parse and quote name and type
;06/15/93 alice %path-std-quotes - removing optimization makes him fat string aware
;		could also leave it in when everyone is base.
;06/15/93 alice %path-from-iopb is fat-string aware and has no more lap at expense of consing an extra string,
;06/14/93 alice %reverse-component-case is fat string aware (dreadfully important).
;06/11/93 alice %%str-member is fat string aware
;03/01/93 alice mid-path-aliases needed to tell %path-getdirinfo that dir is already unquoted
;10/16/92 alice remove-up failed for more than one, directory-string-list forgot about ; and :UP
;08/06/92 alice find-load-file defend against full-pathname returning nil.
;06/08/92 alice probe-file work for both "foo:bar alias:" and "foo:bar alias" 
;06/05/92 alice %path-getdirinfo - look in desktop folder of all vols for aliases
;		pb-resolve-alias - hacked to work for aliases on remote vols
;05/20/92 alice find-load-file - fix for type specified and, untyped file exists
;05/01/92 alice nuke *working-directory*
; 08/04/92 bill  in compile-load: The :fasl-file, :ignore-compiler-warnings,  &
;                :force-compile keywords are no longer passed along to compile-file  or load.
; 07/22/92 bill  dummy definition for %path-get-long-dir-info
; 07/06/92 bill  *last-choose-file-directory*: DEFVAR -> DEFLOADVAR
;--------------  2.0
; 03/20/92 bill  EXCHANGE-FILES exchanges the type, creator, & creation date.
;                Maybe it should exchange some of the other finder info stuff.
; 02/21/92 (alice from bootpatch0) don't die if "home:" gets renamed in 
;                choose-file-default-directory
;---------------- 2.0f2
; 01/07/92 gb    don't require RECORDS.
; 12/19/91 bill  :defaults NIL for make-pathname in find-module-pathnames
; 12/16/91 alice choose-...-dialog remember directory if cancelled
; 12/14/91 alice %load if verbose print *load-pathname* not *loading-file-source-file*
; 12/11/91 gb    signal-file-error a macro, wants a fixnum as first argument.
; 12/10/91 alice exchange-files gets optional errchk argument
; 12/04/91 alice choose-directory-dialog erroneously said pathname-directory, make him set default also
;---------------- 2.0b4
; 11/17/91 alice fix find-load-file again - appear to have misplaced a change
; 10/16/91 bill  %run-masked-periodic-tasks during #_SFGetFile
; 10/24/91 alice directory :wild is '(:absolute :wild-inferiors)
; 10/23/91 alice directory-namestring instead of pathname-directory in choose-file-dialog
; 10/10/91 alice pathname-version had a really dumb bug
; 10/10/91 alice %std-directory-part dtrt and use it for more
; 10/21/91 gb    no more #_PB
; 10/06/91 alice choose-new-file mumble don't lose the name, fix choose-directory-dialog
; 10/03/91 alice directory-pathname-p t if name "" and type :unspecific
; 10/01/91 alice %path-from-iopb if both name and type are absent make em nil
;                instead of "" and :unspecific (what will this break?)
; 10/01/91 alice pb-resolve-alias still botched the dir, %path-getdirinfo recurse right
; 10/01/91 alice %load and find-load-file - try to get the source file right
; 09/23/91 alice %std-directory doesn't transform '(:absolute) to nil ?
; 09/20/91 alice %path-to-iopb and pb-resolve-alias botched the dirid
; 09/11/91 alice create-file call create-directory with the FULL physical directory
;----------------- 2.0b3
; 09/06/91 alice signal-file-error takes args
; 09/09/91 bill  error on attempt to invoke choose-file-dialog when not in *foreground*
; 08/23/91 alice delete-file behave as before - if not there, no error. Add exchange-files
; 08/24/91 gb   use new trap syntax.
; 07/31/91 bill Jeremy's new choose-directory-dialog
; 08/01/91 alice resolve aliases, changes %path-to-iopb a bit. (to do: create-file)
; 07/29/91 alice get-long iodirid
; 07/21/91 gb   error signalling.  Mac-file-thing resolves aliases; should probably happen
;               in TRUENAME or somesuch.
; 07/19/91 alice %std-directory-part handle :wild, choose-file-default-directory aware of *last...
; 07/15/91 alice set-choose-file-default-directory set *last-...-directory* too.
; 06/12/91 bill make the :button-string to choose-new-file-dialog more persistent in sf-hook
; 06/08/91 bill provide no longer puts duplicates on *module-file-alist*
; 06/06/91 bill ALMS's patch to find-load-file to reduce consing.
; 06/26/91 alice enough-namestring return relative directory if possible
; 06/24/91 alice delete-file work for directories as foo:baz:
; 06/13/91 alice merge-pathnames heeds version (do we really care)
; 06/12/91 alice namestring was bogus for host & version "*",
;		 change file-namestring to include version & pathname (PATCH) 
;		(Now files can't be named a.b.* a.b.0 or a.b.newest because both
;		pathname and make-pathname toss the "version" if no host.
;		Pathname, pathname-name, pathname-type all parse strings the same)
; 06/10/91 alice %directory-list-namestring :wild => * &  %std-directory-component no :wild => *
;		%directory-string-list * => :wild
;------------- 2.0b2
; 05/20/91 gb   #'file-error -> #'signal-file-error.
; 05/07/91 bill return :unspecific vice NIL from pathname-version
; 05/03/91 bill namestring includes version,
;               pathname & pathname-version-sstr parse it (more) correctly.
; 05/10/91 alice choose-file-dialog  & choose-new-file-dialog - remember directory so gsb won't complain.
; 04/16/91 alice pathname-type-sstr - If lonely dot, type is "". Fix pathname-version-sstr and pathname-name for trailing dots. (patch?)
; 04/04/91 alice choose-file-dialog  & choose-new-file-dialog closeWD 
; 03/15/91 alice fix recently introduce bug in pathname-host-sstr
; 02/22/91 alice error and %err-disp =>file-error where appropriate, give report-bad-arg a required type in some cases
; 02/15/91 alice merge-pathnames - remove :up if merging relative, nuke (:logical "foo") if logical host 
; 02/15/91 alice %directory-list-namestring - use ; for :up if logical host (patch ?)
; 02/12/91 alice move full-pathname to l1-pathnames for boot reasons
; 02/12/91 alice find-load-file return truename and untranslated name, %load bind *load-pathname* and *load-truename* correctly
; 02/08/91 alice full-pathname with no-errors t,  return nil if got an error in %expand-logical-directories (PATCH!)
;          no-error arg default to t again (doc says so)
;-------------- 2.0b1
; 02/06/91 alice %directory-string-list for host
; 01/25/91 alice pathname-host-sstr - error if undefined host
; 01/25/91 alice per gb's suggestion %path-from-iopb quit at root, full-pathname do error if undefined MCL logical dir 
; 01/25/91 alice parse-namestring do return a logical pathname when a host is provided
; 01/25/91 alice merge-pathnames (re host) said dir when it meant path-dir
; 01/24/91 alice create-file create missing directories (needed this for write-floppies)
;--------------------------2.0a5
; 01/03/90 alice %directory-list-namestring use ";" if we have a logical host. directory-namestring
;          funny quote if no host. %directory-string-list & pathname-directory-sstr take optional host arg too. 
; 01/03/90 alice make-pathname merge dir with defaults a la merge-pathnames
; 01/01/91 alice make-pathname don't do pathname-directory of NIL
; 12/28/90 bill  error in choose-directory-dialog (which still doesn't do anything useful)
; 12/20/90 alice %directory-string-list - log:;foo; directory is relative (pg 629)
;          %directory-list-namestring take optional host arg (used for relative pathnames)
; 12/10/90 alice mods to make-pathname, merge-pathnames ,  merge-pathnames with
;  defaults in mac-directory-namestring
; --------------------------2.0a4
; 11/10/90 gb    new fasloader.  Autoload ff-load.
; 10/27/90 alice probe-file failed for top level non-local dirs
; 10/25/90 alice allow ∂: in directory namestring first component, full-pathname dont return nil
; 10/18/90 alice change pathname-host to return only a defined logical host & make pathname-directory agree
;                parse-namestring dont ignore host, defaults
; 10/16/90 gb    no more %str-length.
; 09/07/90 alice namestring include host (fix all callers)
; 08/23/90 alice probe-file dont give back a dir unless dir pathname provided
; 08/09/90 alice stop making believe we have versions
; 09/16/90 bill  Add errorp arg to %open-res-file
; 09/13/90 bill  compile-load,
;                remove "library;interfaces:" from *module-search-path*: use require-interface
; 09/11/90 bill  Finally restarts for LOAD
; 09/08/90 bill  Remove the trailing newline from LOAD's verbose message and
;                add a force-output so that output can be to a mini-buffer.
; 09/07/90 bill  "ccl;library" -> "ccl;library:", "interfaces" logical directory
; 09/06/90 bill  Joe added "library;interfaces:" to *module-search-path*
; 08/09/90 alice stop making believe we have versions
; 08/03/90 bill add examples & library to *logical-directory-alist*
; 07/27/90 alice make file-author do what the documentation says it does.
; 07/19/90 alice fix set-file-write-date to not bash other info
; 07/06/90 alice gary's fix for bogus forward reference warns with included files
; 07/06/90 alice bind *load-truename* and *load-pathname* in load (issue 112)
; 07/06/90 alice fix full-pathname to merge default-directory, remove up's where possible
;                and obey the no-error arg
; 06/19/90 alice fix (pathname ":") and (make-pathname :directory '(:relative))
; 06/18/90 alice fix enough-namestring, defvar (not defparameter) *logical-directory-alist*
; 06/15/90 alice let probe-file work for directories too!!!
; 06/14/90 alice pathname faster, less garbage
; 06/13/90 alice print-object (pathname) obey *print-readably*
; ------ 2.0d46
; 06/12/90 alice disallow symbols in pathname args, allow version :newest
;06/11/90  gb   bind *readtable* in load.
; 06/08/90 alice make merge-pathnames deal with logical hosts
; ------ 2.0d45
; 06/02/90 alice %directory-string-list  - allow multiple logical directories
; 06/01/90 alice fix pathname-host, pathname and pathname-directory for logical host
;06/04/90 bill in choose-**-dialog: default -> directory (that's what the doc says)
;              add "ccl;examples:" to *module-search-path*.
;06/04/90 gb   Use with-compilation-unit in load-from-stream.
;5/7/90   gz   Pathname component case.
;              Structured directories.
;              Logical pathnames in pathname component accessors & make-pathname.
;04/30/90 gb   hoist a few decls, string-char -> base-character.
;04/23/90 bill add "ccl;library:" to *module-search-path*
;04/14/90 gz   %substr now takes start/end args.
;04/02/90 gz   write-a-pathname -> print-object.
;02/29/90 bill Add directory-exists-p
;12/27/89  gz  Remove obsolete #-bccl conditionals. Init *logical-pathname-alist*
;              here.  Obey *load-print* in LOAD.
;12/21/89  gz  Implement cleanup issue PATHNAME-UNSPECIFIC-COMPONENT...
;29-Nov-89 Mly in write-a-pathnaem: Don't use hairy format in l1.
;              princ just writes namestring.
;11/23/89 gz  define *logical-pathname-alist* here.
;12-Nov-89 Mly *write-istruct-alist*
;10/30/89 bill Rename pr-%print-pathname to write-a-pathname and add stream arg.
;09/27/89 gb simple-string -> ensure-simple-string.
#|
 09/25/89 bill Add modeline - Add one-level cache to %path-from-iopb. This speeds
               up directory by over an order of magnitude.
;07/01/89 bill in delete-file (case .. (nil ..) ..) => (case .. ((nil) ..) ..)
;04/07/89 gb  $sp8 -> $sp.
 04/01/89 gz New defpascal syntax.
 3/22/89  gz Added %fasload, %faslopen.
 7-apr-89 as %str-cat takes rest arg
 02/26/89 gz fix in %path-std-quotes
 02/23/89 gb File creator = CCL2; Time to define *default-file-creator*.
 01/05/89 gz Don't pass 0-length strings to traps.
 01/03/89 gz Moved #P to l1-readloop.
 12/28/88 gz Use istruct-typep.  Lapify bottlenecks. streamp back to l1-streams.
             Added stream-pathname.  full-namestring -> full-pathname.
             Terminate loop on $dirnfErr in %path-from-iopb.
 12/21/88 gz  Added %open-res-file...
 11/3/88  jaj put in support for button-string in choose-**-dialog
 10/18/88 gz Don't allow nil as namestring.
  9/20/88 gb Ignore 0-length ioFileName in %path-GetDirInfo.
  8/31/88 gz Standardize logical name expansions in %expand-logical-names,
             since *logical-pathname-alist* is user-mungable.
             Didn't need mac-directory-namestring-p after all...
  8/30/88 gz New regime.  Also moved *file-stream* stuff to l1-streams,
             wildcard stuff and less-used file fns to lib.
  8/20/88 gz	added fasls; to *module-search-path*.  Declarations.
                flushed %open. Don't call page-type to check structure types.
  8/14/88 gb   $iofversnum-> $iofiletype. $iomisc -> $ionewname.
  8/3/88  gz	include is not exactly the same as load...
  7/27/88 gz	added string matching fns from level-2.
  6/27/88  gb  Don't say the mpf word.

  6/24/88 as  added dummy def of file-locked-p for the sake of buffer-write-file
  6/23/88 jaj file-length works with weird byte sizes
  6/22/88 jaj overwrite-dialog returns multiple-values (and thereby so does copy-file)
              fix to file-namestring for version, merge-pathnames takes :newest
              stream-eofp works for weird byte sizes
              really bind *loading-file-source-file* for fasls in load
  6/21/88 jaj use catch/throw-cancel macros
  6/6/88  jaj include and %include are synonyms for load
  5/31/88 as  ::cancel -> :cancel
              (throw :cancel nil) -> (throw :cancel :cancel)
  5/26/88 as  yet another get-string-from-user syntax
  5/20/88 as  new get-string-from-user calling sequence
  5/20/88 jaj fns dealing with time use mac-to-universal-time and
              universal-to-mac-time.  copy-file returns values in
              correct order. mac-directory-p works with complex strings
  5/12/88 jaj  for delete-file :error-if-no-exist defaults to nil
  2/26/88 jaj  library-entry-points -> library-entry-names in load

  3/30/88  gz  New macptr scheme.  Flush pre-1.0 edit history.
  3/1/88   gz  Eliminate compiler warnings.
  2/8/88  jaj  enlarged pb for %mac-default-directory
 12/22/87 gz   Franz foreign function hooks in LOAD.
  12/15/87 cfry from patch of Jaj's to fix the format ~T bug:
          mods to (exist *file-stream*) (stream-column *file-stream*)
                   (stream-tyo *file-stream*) file-position
 10/23/87 jaj  changed %mac-filename, %mac-directory to %uvrefs
 10/22/87 jaj  moved with-file-or-dir out of eval-when
 10/15/87 jaj  added stream-column for *file-stream*
 10/13/87 cfry added INCREMENT-PATHNAME-VERSION & RENAME-FOR-OPEN
           extended rename-file to work for directories.
          %probe-file - fixed by Jaj.
 10/12/87 cfry fixed copy-file to not create target file if source doesn't exist.
          renamed *open-files* to *open-file-streams* casue that's what it is.
          fixed (exist *file-streams*) to set the above global as it should have.
          removed open-file-streams, an iv of *file-streams* not used now.
 removed the fn (defun FileStreams ()
                           (ask *file-stream* open-file-streams))
           which isn't called anywhere in CCL lisp files, and isn't documented.
          
 10/11/87 jaj added internal to *module-search-path*
  9/29/87 jaj moved %do-files-in-directory and do-files-in-directory here from
              pathnames.lisp
  9/29/87 as  find-load-file uses version without explicit type if it exists,
              rather than always merging with .lisp and .fasl
-----------------------------------Version 1.0---------------------------------
|#

;(dbg 64)
;(defconstant $afpAccessDenied -5000)

(defconstant $paramErr -50)   ; put this with the rest when we find the rest

(defconstant pathname-case-type '(member :common :local :studly))
(defconstant pathname-arg-type '(or string encoded-string pathname stream))


#+ppc-target (defparameter new-namestring-hash (Make-hash-table  :test 'equal))  ;; path -> mcl namestrings, also string -> mcl namestrings
#+ppc-target (defparameter new-mac-namestring-hash (make-hash-table  :test 'equal))  ;; path -> posix-namestring (utf8) and dir list -> posix-dir-string 
#-ppc-target (defparameter new-namestring-hash nil)
#-ppc-target (defparameter new-mac-namestring-hash nil)
#+ppc-target (defvar *use-namestring-caches* t)
#-ppc-target (defvar *use-namestring-caches* nil)  ;; 68k boot problem

(defparameter  namestring-path-hash (make-hash-table :test 'equalp))  ;; posix-namestring (utf16) -> (cons key path)

(export 'alias-path-p)


;#-interfaces-3
(defun CFStringGetCharacters (cfstr start len buffer)
  (#_cfstringgetcharacters cfstr start len buffer))


;#-interfaces-3
(defun CFStringGetBytes (cfstr start len encoding lossbyte isExternalRepresentation buffer maxBuflen usedBuflen)
  (#_CFStringGetBytes cfstr start len encoding lossbyte isExternalRepresentation buffer maxBuflen usedBuflen))



(setq *pathname-escape-character* #\21002)
;(defvar *pathname-escape-character-unicode* #.(convert-char-to-unicode *pathname-escape-character*))
(defvar *pathname-escape-character-unicode* #\21002)  ;; assuming ctrl-q option-d (code-char #x2202)



;; don't clear if locked.
(defun clear-namestring-caches ()
  (without-interrupts
   (if (neq (hash-table-test namestring-path-hash) 'equalp)  ;; why does the test get changed to 'equal
     (setq namestring-path-hash (make-hash-table :test 'equalp))
     (clrhash namestring-path-hash))
   (when t ;(eq 0 (nhash.lock new-mac-namestring-hash)) ;; clrhash now fixed to deal with this
     (clrhash new-mac-namestring-hash))
   (when t ; (eq 0 (nhash.lock new-namestring-hash)) 
     (clrhash new-namestring-hash))))


(queue-fixup (add-gc-hook 'clear-namestring-caches
                          :post-gc))  ;; :pre-gc doesn't seem to work - too bad

(pushnew 'clear-namestring-caches *lisp-startup-functions*)
(pushnew 'clear-namestring-caches *lisp-cleanup-functions*) 

;; move here before called
(defmethod string-length ((x t))
  (length x))       


; dunno if this is what we want to do
(defmacro file-errchk (trap path)
  `(let ((errno ,trap))
     (unless (%izerop errno)
       (signal-file-error errno ,path))))


(defmacro signal-file-error (err-num &optional pathname &rest args)
  `(%err-disp (logior (ash 2 16) (the fixnum (logand #xffff (the fixnum ,err-num))))
              ,@(if pathname (list pathname))
              ,@(if args args)))


(defvar %logical-host-translations% '())
(defvar *load-pathname* nil)
(defvar *load-truename* nil)
(defvar *alias-resolution-policy* nil ":quiet for resolution that won't try to mount currently-offline volumes.
                                       :none to see aliases as aliases.
                                       nil or anything else to get complete (noisy) resolution like MCL used to always do.")


(defparameter *default-pathname-defaults* (%cons-pathname nil nil nil))

;Right now, the only way it's used is that an explicit ";" expands into it.
;Used to merge with it before going to ROM.  Might be worth to bring that back,
;it doesn't hurt anything if you don't set it.
;(defparameter *working-directory* (%cons-pathname nil nil nil))

;These come in useful...  We should use them consistently and then document them,
;thereby earning the eternal gratitude of any users who find themselves with a
;ton of "foo.CL" files...
(defparameter *.fasl-pathname* #-carbon-compat (%cons-pathname nil nil #-ppc-target "fasl" #+ppc-target "pfsl")
                               #+carbon-compat (%cons-pathname nil nil  "cfsl"))
(defparameter *.lisp-pathname* (%cons-pathname nil nil "lisp"))



(defun new-file-size (path what &optional is-truename)
  (rlet ((FSREF :FSREF)
         (cataloginfo :fscataloginfo))
    (let (res is-dir)
      (if (not is-truename)
        (multiple-value-setq (res is-dir)(path-to-fsref path fsref))        
        (multiple-value-setq (res is-dir)(make-fsref-from-path-simple path fsref)))
      (if (not res) (signal-file-error $err-no-file path))
      (if is-dir (error "~s is a directory" path)))        
    (fsref-get-cat-info fsref cataloginfo (logior #$kFSCatInfoDataSizes  #$kFSCatInfoRsrcSizes))
    (unsignedwide->integer
     (ecase what
       (:data-allocated-size (pref cataloginfo :FSCataloginfo.dataPhysicalSize))
       (:data-size (pref cataloginfo :FSCataloginfo.dataLogicalSize))
       (:resource-size (pref cataloginfo :FSCataloginfo.rsrcLogicalSize))
       (:resource-allocated-size (pref cataloginfo :FSCataloginfo.rsrcPhysicalSize))))))

  


(defun file-resource-size (path) (new-file-size path :resource-size))
(defun file-data-size (path) (new-file-size path :data-size))
(defun file-allocated-resource-size (path) (new-file-size path :resource-allocated-size))
(defun file-allocated-data-size (path) (new-file-size path :data-allocated-size))





;; shannon has a faster version but nobody calls it and I dont care - well this is better
(defun file-info (path)
  (setq path (full-pathname path))
  (rletz ((fsref :fsref)
          (catinfo  :fscataloginfo))
    (multiple-value-bind (exists is-dir)(path-to-fsref path fsref)
      (if (not exists) (signal-file-error $err-no-file path))
      (if is-dir (signal-file-error $xdirnotfile path)))
    (fsref-get-cat-info fsref catinfo 
                        (logior #$kFSCatInfoDataSizes #$kFSCatInfoRsrcSizes #$kFSCatInfoCreateDate #$kFSCatInfoContentMod))
    (values
     (utcseconds (pref catinfo :FSCataloginfo.createDate))
     (utcseconds (pref catinfo :FSCataloginfo.contentModDate))
     (unsignedwide->integer (pref catinfo :FSCataloginfo.rsrcLogicalSize))
     (unsignedwide->integer (pref catinfo :FSCataloginfo.dataLogicalSize))
     (unsignedwide->integer (pref catinfo :FSCataloginfo.rsrcPhysicalSize))
     (unsignedwide->integer (pref catinfo :FSCataloginfo.dataPhysicalSize)))))

  

(defun overwrite-dialog (filename &optional (prompt "Create…"))
  (while (standard-alert-dialog (%str-cat "File \"" (princ-to-string filename) "\" already exists.
Replace it or choose a new name?" )
                        :yes-text "New..."
                        :no-text "Replace")
    (catch-cancel
      (return-from overwrite-dialog
        (choose-new-file-dialog :directory filename :prompt prompt))))
  filename)

(defun if-exists (if-exists filename &optional (prompt "Create…"))
  (case if-exists
    (:error (signal-file-error $xfileexists filename))
    ((:dialog :new-version :rename) (overwrite-dialog filename prompt))
    ((nil) nil)
    ((:ignored :overwrite :append :supersede :rename-and-delete) filename)
    (t (report-bad-arg if-exists '(member :error :dialog nil :ignored :overwrite :append :supersede :rename-and-delete)))))

(defun if-does-not-exist (if-does-not-exist filename)
  (case if-does-not-exist 
    (:error (signal-file-error $err-no-file filename)) ; (%err-disp $err-no-file filename))
    (:create filename)
    ((nil) (return-from if-does-not-exist nil))
    (t (report-bad-arg if-does-not-exist '(member :error :create nil)))))

;Like (or (probe-file path) error) except that does directories as directories:
; (probe-file "hd:ccl:") -> nil - not so - probe-file now does directories
; (truename "hd:ccl:") -> #P"hd:ccl:"
#|
(defun truename (path)
  (%stack-iopb (pb np)
    (%path-to-iopb path pb :errchk)
    (if (directory-pathname-p path)
      (%put-ptr pb (%null-ptr) $ioFileName)
      (progn
        (%put-word pb 0 $ioFDirIndex)
        (file-errchk (#_PBGetCatInfoSync  pb) path)
        (%put-long pb (%get-long pb $ioFlParID) $ioDirID)))
    (%path-from-iopb pb)))
|#

(defun truename (path)
  (or (probe-file path) ; probe-file gets aliases right 
      (signal-file-error $err-no-file path)))

;; possible bug - what if 2 volumes, one named "April" and one named "april"?

#|
(defun find-all-the-volumes2 ()
  (let (errno)
    (RLET ((unistr :hfsunistr255)
           (actual-volume :signed-integer))
      ;; how do we know how many volumes? proceed till error
      (do ((index 1 (1+ index)) (result ()))
          ((not (%izerop (setq errno (#_FSGetVolumeInfo 0 index actual-volume 0 (%null-ptr) unistr (%null-ptr)))))
           (if (eq errno $nsvErr) result (signal-file-error errno "phoo")))
        (let ((vol-name (string-from-hfsunistr unistr))) ;(print vol-name)
          (unless (or (null vol-name)(eq vol-name t))(push vol-name result)))))))
|#

"When indexing through the list of mounted volumes, you may encounter  
an error with a particular volume. The terminating error code for  
full traversal of this list is nsvErr. In order to completely  
traverse the entire list, you may have to bump the index count when  
encountering other errors (for example, ioErr)."

#|
(defun find-all-the-volumes2 ()
  (let (errno)
    (RLET ((unistr :hfsunistr255)
           (actual-volume :signed-integer))
      ;; how do we know how many volumes? proceed till nsvErr - ignore other errors
      (do ((index 1 (1+ index)) (result ()))
          ((eq #$nsvErr (setq errno (#_FSGetVolumeInfo 0 index actual-volume 0 (%null-ptr) unistr (%null-ptr))))
           result)
        (if (eq errno #$noerr)
          (let ((vol-name (string-from-hfsunistr unistr))) ;(print vol-name)
            (unless (or (null vol-name)(eq vol-name t))(push vol-name result))))))))
|#

(defun spell-vol-name (my-vname)
  "Return correct spelling/case or nil if OK"
  (let (errno
        (bootnum (#_LMGetBootDrive)))
    (RLET ((unistr :hfsunistr255)
           (actual-volume :signed-integer))
      ;; how do we know how many volumes? proceed till nsvErr - ignore other errors
      (do ((index 1 (1+ index)))
          ((eq #$nsvErr (setq errno (#_FSGetVolumeInfo 0 index actual-volume 0 (%null-ptr) unistr (%null-ptr))))
           nil)
        (when (and (eq errno #$noerr)(neq (%get-signed-word actual-volume) bootnum))  ;; already checked boot          
          (let ((vol-name (string-from-hfsunistr unistr))) ;(print vol-name)
            (when (string-equal my-vname vol-name)
              (if (not (string= my-vname vol-name))
                (return-from spell-vol-name vol-name)
                (return-from spell-vol-name nil)))))))
    nil))

;; used in make-fsref-from-path and path-simple
;; make sure volume is "spelled" right
(defun full-pathname-++ (full-path)
  (let* ((boot-dir (%pathname-directory (boot-directory)))
         (full-dir (%pathname-directory full-path))
         (boot-name (second boot-dir))
         (v-name (second full-dir)))
    (if (string-equal boot-name v-name)
      (if (string= boot-name v-name)
        full-path
        (let ((new-dir (list* :absolute boot-name (cddr full-dir))))          
          (make-pathname :host :unspecific :directory new-dir :defaults full-path)))
      (let ((the-respell (spell-vol-name v-name)))
        (if the-respell
          (let ((new-dir (list* :absolute the-respell (cddr full-dir))))
            (make-pathname :host :unspecific :directory new-dir :defaults full-path))            
          full-path)))))

;; alias foo to a dir
;; I ask for foo: gimme the dir
;; I ask for foo gimme the dir

;; alias foo to a file
;; I ask for foo: ret nil
;; I ask for foo gimme the resolved alias


;; does this do mid path aliases? probably not

(defun fsref-is-alias-p (fsref) ;(print (%path-from-fsref fsref))
  ; This will never return T T because of how _fsIsAliasFile works--it never
  ;   digs into aliases, so it won't tell you whether an alias points to a folder
  ;   or not. Aliases themselves are never folders. Apple says this is a feature not a bug.
  ; _fsIsAliasFile also apparently resolves the fsref in 'easy' cases. Something else
  ;   Apple doesn't document and probably thinks is a feature. At least it doesn't try to mount anything.
  (rlet ((isaliasp :boolean)
         (folderflagp :boolean))
    (#_fsIsAliasFile fsref isaliasp folderflagp)
    ;(print (%path-from-fsref fsref))
    (values (not (eq 0 (%get-byte isaliasp)))
            (not (eq 0 (%get-byte folderflagp))))))
 

(defun resolve-alias-from-fsref (fsref)
  "Returns a second value resolved which will be true if it was a resolvable alias
   or if it's a non-alias. Either implies the outgoing fsref is good."
  (rlet ((targetisfolder :boolean)
         (wasaliased :boolean))
    (let ((errno (#_FSResolveAliasFile fsref t targetisfolder wasaliased)))
      ;(print errno)
      ; errno will be nonzero if alias was unresolvable for some reason. Will be 0 if a non-alias.
      (values (pref targetisfolder :boolean)
              (= errno 0)))))

; could easily combine this functionality with original routine but it seems cleaner this way
(defun resolve-alias-from-fsref-quiet (fsref)
  "Like resolve-alias-from-fsref except it won't attempt to mount offline volumes in
   the resolution attempt so 'please login' dialogs won't get thrown up. But even in
   cases where no dialog would be needed--like a .dmg volume--this won't mount a volume.
   Returns a second value resolved which will be true if it was a quietly resolvable alias
   or if it's a non-alias. Either implies the outgoing fsref is good."
  (rlet ((targetisfolder :boolean)
         (wasaliased :boolean))
    (let ((errno (#_FSResolveAliasFileWithMountFlags fsref t targetisfolder wasaliased #$kResolveAliasFileNoUI)))
      ; errno will be -35 if the volume was offline and alias couldn't be resolved
      (values (pref targetisfolder :boolean)
              (= errno 0)))))

;; care about is-dir, is open or locked #x81 
(defun fsref-get-cat-info (fsref catinfo &optional (whichinfo #$kFSCatInfoGettableInfo))
  (rlet ()
    (errchk (#_FSGetCatalogInfo fsref whichinfo catinfo (%null-ptr) (%null-ptr) (%null-ptr)))))

(defun fsref-set-cat-info (fsref catinfo &optional (whichinfo #$kFSCatInfoSettableInfo))
  (errchk (#_FSsetcataloginfo fsref whichinfo catinfo)))

(defun fsref-node-bits (fsref)
  (rlet ((cat-info :fscataloginfo))
    (fsref-get-cat-info fsref cat-info #$kFSCatInfoNodeFlags)
    (pref cat-info :fscataloginfo.nodeflags)))

(defvar *using-posix-paths-p* nil)

(defun using-posix-paths-p ()
  *using-posix-paths-p*)

(def-ccl-pointers posixa ()
  (setq *using-posix-paths-p* (logbitp #$gestaltFSUsesPOSIXPathsForConversion (gestalt #$gestaltFSAttr))))
               
          
(defun make-fsref-from-path (path &optional in-fsref (errorp t))
  (let* ((fsref (or in-fsref (make-record :fsref)))
         (full-pathname (full-pathname-++ (full-pathname path)))  ;; or assume path is full-path    
         (namestring (if (and #|(osx-p)|# (using-posix-paths-p))
                       (posix-namestring full-pathname)   ;; assumes full-path
                       (mac-namestring full-pathname)     ;; doesn't assume full-path - now does
                       )))
      (with-cstrs ((cpath namestring))
        (rlet ((is-dir :boolean))
          (let ((errno (#_FSPathMakeRef cpath fsref is-dir)))
            (cond ((not (eq errno #$noerr))
                   (if (not in-fsref)(#_disposeptr fsref))
                   (if errorp (signal-file-error errno path)))
                  ;; need to remember is-dir if want to go the other way using %path-from-fsref
                  (t (values fsref (pref is-dir :boolean)))))))))




(defun path-to-fsref (path fsref &optional no-vol-flag)
  (let* ((*default-pathname-defaults* nil) ;; or assume callers provide full-pathname?
         (full-path (full-pathname path))
         (dirp (directory-pathname-p full-path)))    
    ;; make-fsref-from-path doesn't do mid path aliases nor ccl:foo alias; but ccl:bin alias does work where alias is to dir
    (multiple-value-bind (res dir-result) (make-fsref-from-path full-path fsref nil)
      ;; try for mid-path aliases
      (When (and (null res)(pathname-directory full-path))
        ;; oops - loops forever if first dir no exist - fixed
        (multiple-value-bind (subdir)(make-fsref-from-path-resolve-dir-aliases2 full-path fsref no-vol-flag)
          (when (null subdir) (return-from path-to-fsref nil))
          (let ((new-path (make-pathname :directory (pathname-directory subdir) :name (%pathname-name full-path) :type (%pathname-type full-path) :defaults nil)))
            (if (not (equalp new-path full-path))
              (return-from path-to-fsref (path-to-fsref new-path fsref)))
            ;; nothing changed in dir and it wasn't there before
            (return-from path-to-fsref nil))))
      (when (null res) (return-from path-to-fsref nil))      
      (if (eq :none *alias-resolution-policy*)
        (values fsref dir-result) ; fsref-is-alias-p actually resolves (!) aliases in easy cases, so we must bail before calling it
        (multiple-value-bind (is-alias folder-flag)(fsref-is-alias-p fsref)
          (declare (ignore-if-unused folder-flag))
          (cond
           (is-alias
            (multiple-value-bind (got-folder resolved)
                                 (if (eq :quiet *alias-resolution-policy*)
                                   (resolve-alias-from-fsref-quiet fsref)
                                   (resolve-alias-from-fsref fsref))
              (if (or got-folder (eq got-folder dirp)) ;??
                (values (and resolved fsref) got-folder is-alias))))
           (t ;(when (eq dir-result dirp)  ;; << put this back ?? - path-to-fsref is a low level probe-file and a file ain't a directory nor vv
                (values fsref dir-result))))))))


#|
(setq p "Macintosh-HD:hd3:MCL-cvs-local-dir:MCL-dev:asdfasdfasdfasdfasdfasdfasdfasdfasdf")
(setq q "Macintosh-HD:hd3:MCL-cvs-local-dir:MCL-dev:qwertqwertqwertqwertqwertqwertqwert:")
(probe-file p)
|#
(defun probe-file (path &optional no-vol-flag)  
  (rlet ((fsref :fsref))
    (let ((full-path (full-pathname path)))      
      (when (not (pathname-directory full-path))
        (setq full-path (merge-pathnames (mac-default-directory) full-path)))
      (multiple-value-bind (res dir-result is-alias) (path-to-fsref full-path fsref no-vol-flag)
        (when res 
          (if (and (not is-alias)(neq (directory-pathname-p full-path) dir-result))
            nil
            (%path-from-fsref fsref dir-result)))))))

(defun fs-length (string)   ;; don't count option-d if any
  (length (%file-system-string string)))

;; this stuff is pretty inefficient but ...
#|
(defun check-os9-mangled-path (pathname)  ;; itsa full-pathname
  (if nil ;(and (not (osx-p)))
    (progn
      (cond ((any-unicode-or-long-components pathname) 
             (get-mangled-unicode-pathname pathname))
            (t pathname)))
    pathname))
|#





#|
(defun get-mangled-pathname (fullpath)
  (rletz ((parentref :fsref)
          (newref :fsref))
    (let*  ((dirpath (make-pathname :directory (pathname-directory fullpath) :name nil :type nil :defaults nil))
            (namestring (file-namestring fullpath))
            (dir-res (path-to-fsref dirpath parentref t)) ;; won't work if any directory component is long
            namelen)
      (when dir-res
        (setq namestring (%file-system-string namestring)) ;(%path-std-quotes namestring "" "")) ;; remove escapes ??
        (SETQ NAMESTRING (GET-UNICODE-STRING NAMESTRING))      
        (setq namelen (length namestring))
        (%stack-block ((uniname (%i+ namelen namelen)))
          (if (extended-string-p namestring)
            (%copy-ivector-to-ptr namestring 0 uniname 0 (%i+ namelen namelen))
            (dotimes (i namelen)
              (setf (%get-word uniname (%i+ i i))(%scharcode namestring i))))          
          (let ((errno (#_fsmakefsrefunicode
                        parentref
                        namelen ; namelen
                        uniname ; unicode name
                        #$kcfstringencodingmacroman ;; encoding hint aka 0
                        newref)))
            
            (if (eq 0 errno)
              (if (eq :none *alias-resolution-policy*)
                (%path-from-fsref newref) ; fsref-is-alias-p actually resolves (!) aliases in easy cases, so we must bail before calling it
                (let ((is-alias  (fsref-is-alias-p newref)))
                  (if is-alias 
                    (if (eq :quiet *alias-resolution-policy*)
                      (resolve-alias-from-fsref-quiet newref)
                      (resolve-alias-from-fsref newref)))
                  (%path-from-fsref newref))))))))))
|#


(defun probe-file-x (path)
  (rlet ((fsref :fsref))
    (let ((full-path (full-pathname path)))
      (when (not (pathname-directory full-path))
        (setq full-path (merge-pathnames (mac-default-directory) full-path)))
      (multiple-value-bind (res is-dir is-alias)(path-to-fsref full-path fsref)
        (if (not res)
          (values nil nil)
          (if (and (not is-alias)(neq (directory-pathname-p full-path) is-dir))
            (values nil nil)
            (let ((bits (fsref-node-bits fsref))) 
              (when t ;(osx-p) ;; nodebits lie on OSX - we do get locked bit
                (let ((what (open-for-write-test2 fsref t)))                  
                  (when (neq what #$noerr) 
                    (setq bits (logior bits #$kioFlAttribFileOpenMask)))))  ;; say its busy aka open #x80 !! please - only happens if open for writing
              (values (%path-from-fsref fsref is-dir)
                      bits))))))))
    

(defun make-fsref-from-path-simple (Full-pathname fsref)
  (let* ((full-pathname (full-pathname-++ full-pathname))    
         (namestring (if (and #|(osx-p)|# (using-posix-paths-p))
                       (posix-namestring full-pathname)
                       (mac-namestring full-pathname))))
    (with-cstrs ((cpath namestring))
      (rlet ((is-dir :boolean))
        (let ((errno (#_FSPathMakeRef cpath fsref is-dir)))
          (cond ((not (eq errno #$noerr))
                 nil)
                ;; need to remember is-dir if want to go the other way using %path-from-fsref - no longer true
                (t (values fsref (pref is-dir :boolean)))))))))



(defun maybe-alias-volume-from-dir (dir)  ; is this right? dir is eg '(:absolute "foo")
  (when (not (equal dir (%pathname-directory (boot-directory)))) 
    (let ((desktop (findfolder #$kuserdomain "desk")))  ;;  -1 to kuserdomain for OSX
      (when desktop ;; paranoia
        (let* ((ddir (pathname-directory desktop))
               ;(ddir2 (append ddir (list (second dir))))  ;; namestring hashes?
               (foo (make-pathname :directory ddir :name (second dir) :defaults nil)))
          (rletZ ((fsref :fsref))
            (multiple-value-bind (found is-dir)(make-fsref-from-path-simple foo fsref)
              (declare (ignore is-dir))
              (when found
                (when (neq :none *alias-resolution-policy*)
                  (when (fsref-is-alias-p fsref)
                    (let ((is-folder (if (eq :quiet *alias-resolution-policy*)
                                       (resolve-alias-from-fsref-quiet fsref)
                                       (resolve-alias-from-fsref fsref))))
                      (when is-folder (pathname-directory (%path-from-fsref fsref t))))))))))))))



#|
;; go from right to left rather than left to right
(defun make-fsref-from-path-resolve-dir-aliases2 (Path fsref &optional no-vol-flag)
  ;; just does the directory stuff - high price to pay when no aliases - slower and conses more (X 3) than old way
  (progn ;multiple-value-bind (res dir-result) (values nil nil) ;(make-fsref-from-path path fsref nil)  ;; maybe assume we already know this is false
    (cond ;(res (values fsref dir-result))
     (t (let* ((full-pathname (full-pathname path))
               (directory (%pathname-directory full-pathname))
               (len (length directory))
               (ndirs (%i- len 2))
               ;(subdir (list :absolute (second directory)))
               )
          (declare (fixnum len ndirs))
          (let (subpath)
            (dotimes (i ndirs)
              (setq subpath (make-pathname :directory (subseq directory 0 (%i- len i 1)) :name (nth (%i- len i 1) directory) :defaults nil))
              (multiple-value-bind (res is-dir)(make-fsref-from-path-simple subpath fsref)
                (declare (ignore is-dir))
                (cond 
                 ((not res)(setq subpath nil))
                 (t 
                  (multiple-value-bind (is-alias folder-flag)(fsref-is-alias-p fsref)
                    (declare (ignore folder-flag))
                    (cond (is-alias 
                           (let ((is-folder (resolve-alias-from-fsref fsref)))
                             (cond ((not is-folder)
                                    (return-from make-fsref-from-path-resolve-dir-aliases2 nil))
                                   (t (setq subpath (%path-from-fsref fsref t )) (return)))))
                          (t (return))))))))
            ;;  so now subpath is something that exists
            ;(print (list 'cow subpath))
            (cond (subpath 
                   (if (%pathname-name subpath) 
                     (setq subpath (make-pathname :directory (append (%pathname-directory subpath) (list (%pathname-name subpath)))
                                                  :defaults nil)))
                   (let* ((subdir (%pathname-directory subpath))
                          (sublen (length subdir)))                     
                     (if (or no-vol-flag (eq sublen len))
                       subpath
                       (make-fsref-from-path-resolve-dir-aliases2 
                        (make-pathname :directory (append subdir (nthcdr sublen directory))
                                       :defaults nil)
                        fsref))))
                  ((not no-vol-flag)
                   (let* ((subdir (list :absolute (second directory)))
                          (alias-volume (maybe-alias-volume-from-dir subdir)))
                     (when alias-volume 
                       (if (eq ndirs 0)
                         (make-pathname :directory alias-volume :defaults nil)
                         (make-fsref-from-path-resolve-dir-aliases2 
                          (make-pathname :directory (append alias-volume (nthcdr 2 directory)) :defaults nil)
                          fsref
                          t))))))))))))
|#

;; why called during boot??
(if (not (fboundp 'subseq))
  (defun subseq (sequence start &optional (end (length sequence)))
    (declare (ignore-if-unused start))
    (let ((x (copy-list sequence)))
      (if (< end (length sequence))
        (rplacd (nthcdr (1- end) x) nil))
      x)))

(defun make-fsref-from-path-resolve-dir-aliases2 (Path fsref &optional no-vol-flag)
  ;; just does the directory stuff - high price to pay when no aliases - slower and conses more (X 3) than old way
  (progn ;multiple-value-bind (res dir-result) (values nil nil) ;(make-fsref-from-path path fsref nil)  ;; maybe assume we already know this is false
    (cond ;(res (values fsref dir-result))
     (t (let* ((full-pathname path) ;(full-pathname path))  ;; isn;t it already full-path?
               (directory (%pathname-directory full-pathname))
               (len (length directory))
               (ndirs (%i- len 2))
               (imax nil)
               ;(subdir (list :absolute (second directory)))
               )
          (declare (fixnum len ndirs))
          (let (subpath)
            (dotimes (i ndirs)
              (setf imax i)
              (setq subpath (make-pathname :directory (subseq directory 0 (%i- len i 1)) :name (nth (%i- len i 1) directory) :defaults nil))
              (multiple-value-bind (res is-dir)(make-fsref-from-path-simple subpath fsref)
                (declare (ignore is-dir))
                (cond 
                 ((not res)(setq subpath nil))
                 (t 
                  (if (eq :none *alias-resolution-policy*)
                    (return)
                    (multiple-value-bind (is-alias folder-flag)(fsref-is-alias-p fsref)
                      (declare (ignore folder-flag))
                      (cond (is-alias
                             (let ((is-folder (if (eq :quiet *alias-resolution-policy*)
                                                (resolve-alias-from-fsref-quiet fsref)
                                                (resolve-alias-from-fsref fsref))))
                               (cond ((not is-folder)
                                      (return-from make-fsref-from-path-resolve-dir-aliases2 nil))
                                     (t (setq subpath (%path-from-fsref fsref t )) (return)))))
                            (t (return)))))))))
            ;;  so now subpath is something that exists
            ;(print (list 'cow subpath))
            (cond (subpath 
                   (if (%pathname-name subpath) 
                     (setq subpath (make-pathname :directory (append (%pathname-directory subpath) (list (%pathname-name subpath)))
                                                  :defaults nil)))
                   ;(print (list 'cow2 subpath))
                   (let* (;(subdir (%pathname-directory subpath))
                          ;(sublen (length subdir))
                          )                     
                     (if (or no-vol-flag (eq ; sublen Huh? length of [resolved] subpath has nada to do with length of directory
                                          (%i- len imax)
                                          len))
                       subpath
                       (make-fsref-from-path-resolve-dir-aliases-forward subpath
                                                                         (nthcdr
                                                                          (%i- len imax) ; sublen (see above comment)
                                                                          directory)))))
                  ((not no-vol-flag)
                   (let* ((subdir (list :absolute (second directory)))
                          (alias-volume (maybe-alias-volume-from-dir subdir)))
                     (when alias-volume 
                       (if (eq ndirs 0)
                         (make-pathname :directory alias-volume :defaults nil)
                         (make-fsref-from-path-resolve-dir-aliases-forward
                          (make-pathname :directory alias-volume :defaults nil)
                          (nthcdr 2 directory)))))))))))))

(defun make-fsref-from-path-resolve-dir-aliases-forward (exists-path rest-dir)
  (rletz ((fsref :fsref))
    (let (subpath)
      (dotimes (i (length rest-dir))
        (setq subpath (make-pathname :directory (pathname-directory exists-path) :name (car rest-dir) :defaults nil))
        (multiple-value-bind (res is-dir)(make-fsref-from-path-simple subpath fsref)
          ;(declare (ignore is-dir))
          (cond ((not res) (return-from make-fsref-from-path-resolve-dir-aliases-forward nil))
                ((and (neq :none *alias-resolution-policy*) (fsref-is-alias-p fsref))
                 (let ((is-folder (if (eq :quiet *alias-resolution-policy*)
                                    (resolve-alias-from-fsref-quiet fsref)
                                    (resolve-alias-from-fsref fsref))))
                   (cond ((not is-folder) (return-from make-fsref-from-path-resolve-dir-aliases-forward nil))
                         (t (setq exists-path (%path-from-fsref fsref t)
                                  rest-dir (cdr rest-dir))))))
                (is-dir (setq exists-path (make-pathname :directory (append (pathname-directory exists-path) (list (car rest-dir)))
                                                         :name nil :defaults nil)
                              rest-dir (cdr rest-dir)))
                (t (return-from make-fsref-from-path-resolve-dir-aliases-forward nil))))))
    exists-path))


(defun move-fsref-to-trash (fsref full-path)  ;; path not optional
  (rlet ((catinfo :fscataloginfo)
         (trash-ref :fsref)
         (new-ref :fsref))
    (sleepticks 10)
    (cond 
     ((eq #$noerr (#_fsdeleteobject fsref)))  ;; maybe delete succeeds now
     (t      
      (errchk (#_fsgetcataloginfo fsref #$kfscatinfovolume catinfo
               (%null-ptr) (%null-ptr) (%null-ptr)))
      (errchk (#_fsfindfolder (pref catinfo :fscataloginfo.volume)
               #$kTrashFolderType t trash-ref))
      (let ((errno (#_fsmoveobject fsref trash-ref new-ref))  ;;  sometimes fails
            (tries 0))        
        (when (neq #$noerr errno)
          (cond
           ((eq errno #$dupFNErr)  ; item of same name already in trash = can the fsref be clobbered if the move failed?
            (loop
              (make-fsref-from-path-simple full-path fsref)  ;; assume so
              (let* ((another-name (%str-cat (%integer-to-string (+ tries (get-time-unsigned-long))) ".tem"))  ;; or + (random 10)
                     (len (length another-name)))
                (%stack-block ((Ustr (+ len len)))
                  (dotimes (i len)
                    (%put-word ustr (%scharcode another-name i) (+ i i)))
                  (setq errno (#_FSRenameUnicode fsref len ustr #$kTextEncodingUnknown new-ref))  ;; rename to nnnn.tem in same dir = do some errchk here
                  (cond ((eq errno #$dupfnerr) ;; fudge another-name and try again                  
                         (incf tries)
                         (if (> tries 4) (error "path ~S can't be renamed" full-path)))
                        ((eq errno #$noerr)  ;; rename succeeded
                         (setq errno (#_fsmoveobject new-ref trash-ref new-ref))   ;; errchk this too 
                         (if (eq errno #$noerr )
                           (return))
                         ;; well at least it has a new name in original folder - but didn't make it to trash
                         (return))
                        ;; error other than dupfnerr
                        (t (error "error deleting file ~S" full-path))))))) 
           (t (error "error deleting file ~S" full-path)))))
      (if t ;(osx-p) ;; seems to be needed so empty trash menu item is activated - ??
        (#_fnnotify trash-ref #$kFNDirectoryModifiedMessage #$kniloptions))))))

#|
(defun remove-path-from-hashes (truename)
  (let ((foo (get-hashed-path-thing truename new-namestring-hash 'namestring)))
    (when foo
      (remhash foo namestring-path-hash))
    (remhash truename new-namestring-hash)
    (remhash truename new-mac-namestring-hash)))
|#

(defun remove-path-from-hashes (full-path)
  (let ((foo (get-hashed-path-thing full-path new-mac-namestring-hash 'posix-namestring)))
    (when foo
      (when (not (7bit-ascii-p foo))(setq foo (convert-string foo #$kcfstringencodingutf8 #$kcfstringencodingunicode)))
      (remhash foo namestring-path-hash))
    (remhash full-path new-namestring-hash)  ;; keys in that hash likely to be strings not pathnames
    (remhash full-path new-mac-namestring-hash)))

(defun delete-file-truename (truename) ;; we  know it exists and is alias resolved
  (rlet ((fsref :fsref))
    (let ((found (make-fsref-from-path-simple truename fsref)))
      (if (not found)
        #$fnferr
        (progn
          (remove-path-from-hashes truename)        
          (#_FSDeleteObject fsref))))))


;; makes a lotta pathnames
(defun delete-file (path &key (if-does-not-exist nil) (temporary-file-p nil))
  (rlet ((fsref :fsref))
    (let* ((full-path (full-pathname path))
           (moved-to-trash nil)
           errno)
      (when (not (pathname-directory full-path))
        (let ((maybe (merge-pathnames (mac-default-directory) full-path)))
          (when (not (probe-file maybe))
            (let* ((desktop (findfolder #$kuserdomain "desk"))
                   (dname (make-pathname :directory (%pathname-directory desktop) :name (%pathname-name full-path) :type (%pathname-type full-path)
                                         :defaults nil)))
              (when (let ((*alias-resolution-policy* :none))
                      (probe-file dname))
                (delete-file dname)
                (notify-finder-re-folder desktop)
                (return-from delete-file dname))
              (setq full-path maybe)))
          (setq full-path maybe)))
      (when (directory-pathname-p full-path) ;;  can delete dirs too - beware top level dir
        (let ((maybe-full-path (dirpath-to-filepath full-path t)))
          (if (not maybe-full-path)
            (progn  ;; is top level dir/volume
              (let ((foo (maybe-alias-volume-from-dir (%pathname-directory full-path))))
                (if foo
                  ;; ok it's an alias - now what?? - delete the alias
                  (let* ((desktop (findfolder #$kuserdomain "desk"))
                         (dname (make-pathname :directory (%pathname-directory desktop) :name (second (%pathname-directory full-path)) :defaults nil)))
                    ;(cerror "g" "H")
                    (delete-file dname :if-does-not-exist if-does-not-exist)
                    (notify-finder-re-folder desktop)
                    (return-from delete-file dname))
                  (error "Can't delete volume ~s" full-path))))
            (setq full-path maybe-full-path))))
      (let* ((dir-path (make-pathname :directory (%pathname-directory full-path) :name nil :type nil :defaults nil))
             (dir-exists (path-to-fsref dir-path fsref))) ;; or do we mean make-fsref-from-path - want to resolve all alias except the last?        
        (cond ((null dir-exists) (setq errno #$dirnfErr))
              (t (let* ((resolved-dir (%path-from-fsref fsref))
                        (full-path2 (make-pathname :directory (%pathname-directory resolved-dir) :name (%pathname-name full-path)
                                                   :type (%pathname-type full-path) :defaults nil)))
                   (setq full-path full-path2)
                   (setq errno (delete-file-truename full-path)))))
        (when (or (eq errno #$fnfErr)(eq errno #$dirnferr))
          (case if-does-not-exist
            (:error (signal-file-error $err-no-file path))
            ((nil) (return-from delete-file nil))
            (t (report-bad-arg if-does-not-exist '(member :error nil)))))
        (unless (%izerop errno) 
          (if temporary-file-p
            (progn 
              ;(warn "Temporary file ~s moved to trash because delete-file failed." path)
              (make-fsref-from-path-simple full-path fsref)  ;; OOPS fsref contained dir at this point!
              ;(cerror "c" "d")
              (move-fsref-to-trash fsref full-path)
              (setq moved-to-trash t))
            (signal-file-error errno path)))
        (values full-path moved-to-trash)))))

(defun notify-finder-re-folder (folder) ;; requires carbonlib 1.5 - seems to only make a difference on OSX anyway
  (when t ;(osx-p)
    (rletz ((fsref :fsref))
      (let ()
        (make-fsref-from-path-simple folder fsref)
        (#_fnnotify fsref #$kFNDirectoryModifiedMessage #$kniloptions))))) 



;; the unicode string may be longer than the equivalent macroman if accented chars therein

(defun get-cfstr (cfstr)
  (let ((uni-len (#_CFStringGetLength cfstr)))  ;; num of unicode chars
    (declare (fixnum uni-len))        
    (let* ((byte-len (+ uni-len uni-len))
           (outstring))
      (declare (fixnum uni-len byte-len))
      (%stack-block ((to-buf byte-len))                        
        (CFStringGetCharacters cfstr 0 uni-len to-buf)
        ;; waste some time to maybe save some space?
        (if (dotimes (i uni-len nil)
              (declare (fixnum i))
              (if (%i> (%get-word to-buf (%i+ i i)) #xff) (return t)))
          (progn (setq outstring (make-string uni-len :element-type 'extended-character))
                 (%copy-ptr-to-ivector to-buf 0 outstring 0 byte-len))
          (progn (setq outstring (make-string uni-len :element-type 'base-character))
                 (dotimes (i uni-len)
                   (declare (fixnum i))
                   (setf (%scharcode outstring i)(%get-word to-buf (%i+ i i)))))))
      outstring)))

;; get/make raw string - not encoded
(defun get-unicode-string (string)
  (if (encoded-stringp string)
    (let ((enc (the-encoding string))
          (str (the-string string)))
      (if (eql enc #$kCFStringEncodingUnicode) 
        str
        ;; or error?
        (convert-string str enc #$kCFStringEncodingUnicode)))
    string))

#|
? (probe-file2 "osx alias:")
#P"OSX:"
? (probe-file2 "osx alias:applications")
NIL
? (probe-file2 "osx alias:applications:")
#P"OSX:Applications:"
? (probe-file2 "ccl:boot alias")
#P"hd3:CCL3and4-fromzoe-new-int-c4:boot"
? (probe-file2 "ccl:lib alias")
#P"hd3:CCL3and4-fromzoe-new-int-c4:Lib:"
? (probe-file2 "ccl:lib alias:")
NIL
? (probe-file2 "ccl:lib alias;")
#P"hd3:CCL3and4-fromzoe-new-int-c4:Lib:"
? (probe-file2 "ccl:lib alias;pathnames.lisp")
#P"hd3:CCL3and4-fromzoe-new-int-c4:Lib:pathnames.lisp"
? (probe-file2 "hd3:")
#P"hd3:"
? (probe-file2 "osx:")
#P"OSX:"
|#

(defun fork-names ()
  (let (dfname rfname)
    (rlet  ((uname :hfsunistr255))
      (errchk (#_fsgetdataforkname uname))
      (setq dfname (string-from-hfsunistr uname)) ; gaak its ""
      (errchk (#_fsgetresourceforkname uname))
      (setq rfname (string-from-hfsunistr uname)) ; "RESOURCE_FORK"
      (values  dfname rfname))))

#|
(defun string-from-hfsunistr (ustr)
  (let* ((len (pref ustr :hfsunistr255.length))
         (res (make-string len :element-type (if (7bit-ascii-p-ustr ustr) 'base-character 'extended-character))))
    (declare (fixnum len))
    (dotimes (i len)
      (setf (%scharcode res i)(pref ustr (:hfsunistr255.unicode i))))
    res))
|#

(defun string-from-hfsunistr (ustr)
  (let* ((len (pref ustr :hfsunistr255.length))
         (base-p (latin1-ustr-p ustr))
         (res (if base-p (make-string len :element-type 'base-character)
                  (make-string len :element-type 'extended-character))))
    (declare (fixnum len))
    (if base-p
      (dotimes (i len)
        (setf (%scharcode res i)
              (%get-unsigned-word ustr (%i+ #.(get-field-offset :hfsunistr255.unicode) i i))))
      (%copy-ptr-to-ivector ustr #.(get-field-offset :hfsunistr255.unicode) res 0 (%i+ len len)))
    res))


;; don't make encoded today
#+ignore
(defun string-from-hfsunistr-encoded (ustr)
  (string-from-hfsunistr ustr))

;; moved from pathnames.lisp
(defun 7bit-ascii-p-ustr (ustr)
  (dotimes (i (pref ustr :hfsunistr255.length) t)
    (declare (fixnum i))
    (when (%i> (pref ustr (:hfsunistr255.unicode i)) #x7f)(return nil))))

(defun latin1-ustr-p (ustr)
  (dotimes (i (pref ustr :hfsunistr255.length) t)
    (declare (fixnum i))
    (when (%i> (%get-unsigned-word ustr (%i+ #.(get-field-offset :hfsunistr255.unicode) i i)) #xff)
      (return nil))))
  


(Defun string-to-hfsunistr (string ustr)
  (let* ((len (length string)))
    (declare (fixnum len))
    (setf (pref ustr :hfsunistr255.length) len)
    (dotimes (i len)
      (setf (pref ustr (:hfsunistr255.unicode i)) (%scharcode string i)))
    string))

(defvar *resource-fork-name* (nth-value 1 (fork-names)))
(defvar *resource-fork-name-ptr* nil)

(def-ccl-pointers resource-name-stuff2 ()
  (setq *resource-fork-name* (nth-value 1 (fork-names)))
  (let ((len (length *resource-fork-name*)))
    (setq *resource-fork-name-ptr* (#_newptr (+ len len)))
    (dotimes (i len)
      (%put-word *resource-fork-name-ptr* (%scharcode *resource-fork-name* i) (+ i i)))))


(defun open-resource-file-from-fsref (fsref perms &optional data-fork)
  (let* ((name-ptr (if data-fork *null-ptr* *resource-fork-name-ptr*))
         (len (if data-fork 0 (length *resource-fork-name*))))
    (rlet ((refnum :signed-integer))
      (let ((err (#_FSOpenResourceFile fsref len name-ptr perms refnum)))
        ;(PRINT (LIST ERR (%GET-SIGNED-WORD REFNUM)))
        (if (eq err #$noerr)
          (%get-signed-word refnum)
          (values -1 err))))))

;; put this somewhere ?
(defmacro with-fsref-truename ((fsref truename) &body body)
  `(rlet ((,fsref :fsref))
    (make-fsref-from-path-simple ,truename ,fsref)
    ,@body))


;; create if not exist
#|
(defun %open-res-file2 (name &optional (perms $fsrdwrperm) data-fork-p )
  (let ((truename (truename name))
        (refnum))
    (rletZ ((fsref :fsref))
      (make-fsref-from-path-simple truename fsref)
      (setq refnum (open-resource-file-from-fsref fsref perms data-fork-p))
      (when (eq refnum -1)
        (fscreate-res-file truename data-fork-p)        
        (setq refnum (open-resource-file-from-fsref fsref perms data-fork-p)))
    (And (neq refnum -1) refnum)
   )))
|#

(defun %open-res-file2 (name &optional (perms $fsrdwrperm) data-fork-p )
  (let ((truename (full-pathname name))
        (refnum))
    (when (not (probe-file truename))
      (fscreate-res-file truename data-fork-p))
    (when (not (setq truename (probe-file truename)))
      (error "confused"))
    (rletZ ((fsref :fsref))
      (make-fsref-from-path-simple truename fsref)
      (setq refnum (open-resource-file-from-fsref fsref perms data-fork-p))
      (when (eq refnum -1)
        (fscreate-res-file truename data-fork-p)        
        (setq refnum (open-resource-file-from-fsref fsref perms data-fork-p)))
    (And (neq refnum -1) refnum)
   )))


;; this seems to work - twas a PITA getting here
(defun fscreate-res-file (truename  &optional data-fork-p)
  (rletz ((parentref :fsref))
    (let*  ((dirpath (make-pathname :directory (pathname-directory truename) :name nil :type nil :defaults nil))
            (namestring (file-namestring truename))
            (forknamelen (if data-fork-p 0 (length *resource-fork-name*)))
            (forkname (if data-fork-p *null-ptr* *resource-fork-name-ptr*))
            namelen)
      (setq namestring (%file-system-string namestring)) ;(%path-std-quotes namestring "" "")) ;; remove escapes ??
      (SETQ NAMESTRING (GET-UNICODE-STRING NAMESTRING))      
      (setq namelen (length namestring))
      (%stack-block ((uniname (%i+ namelen namelen)))
        (copy-string-to-ptr namestring 0 namelen uniname)        
        (path-to-fsref dirpath parentref t)
        (errchk (#_fscreateresourcefile parentref
                                        namelen ; namelen
                                        uniname ; unicode name
                                        0 ; whichinfo
                                        (%null-ptr) ; catinfo
                                        forknamelen
                                        forkname
                                        (%null-ptr) ; newref
                                        (%null-ptr) ; newspec
                           ))))))
      


;; not used
(defun close-res-file (refnum)
  (#_CloseResFile refnum))



;Should have an option to create all directories in the path, it's not that
;hard... (could call it :if-does-not-exist, except then couldn't pass it through
;from open...)
; this is iffy re aliases
#+ignore
(defun create-file (path &key (if-exists :error)
                              (mac-file-type "TEXT")
                              (mac-file-creator (application-file-creator *application*))
                              &aux errno (full-path (full-pathname path :no-error nil)))
  (when (directory-pathname-p full-path)
    (return-from create-file (create-directory full-path :if-exists if-exists)))
  (%stack-iopb (pb np)
    (setq errno (%path-to-iopb full-path pb nil nil T)) ; tell it not to check file
    (when (not (zerop errno))
      (cond ((or (eq errno $dirnferr)(eq errno $fnferr)
                 (eq errno #$paramerr))  ; dir not found
             ;  some fs's may not distinguish dirnf from fnf
             (create-directory (directory-namestring full-path))
             #-ignore
             (let ((errno (%path-to-iopb full-path pb nil nil T)))
               (when (not (zerop errno))
                 ;; ad hoc crock - sometimes happens on remote volumes with deep dirs
                 (unless (and (eq errno #$paramerr)(> (length (pathname-directory full-path)) 8))
                   (signal-file-error errno full-path))))
             #+ignore
             (%path-to-iopb full-path pb :errchk nil t)   ;; this one failed
             )))
             
    (setq errno (#_PBHCreateSync pb ))
    (when (eq errno $dupFNErr)
      (let ((newpath (if-exists if-exists (%path-from-iopb pb) "Create…")))
        (or newpath
            (return-from create-file nil))
        (when (not (equalp full-path (full-pathname newpath :no-error nil)))
          (return-from create-file (create-file newpath :if-exists :supersede
                                                :mac-file-type mac-file-type
                                                :mac-file-creator mac-file-creator))))
      (setq errno (#_PBHDeleteSync pb))
      (when (%izerop errno)(setq errno (#_PBHCreateSync pb))))
    (unless (%izerop errno) (signal-file-error errno path))
    (%path-to-iopb path pb :errchk)
    (%put-ostype pb mac-file-type $fdType)
    (%put-ostype pb mac-file-creator $fdCreator)
    (file-errchk (#_PBHSetFInfoSync pb) path)
    (%path-from-iopb pb)))


;; if no dir in path should use mac-default-directory which should be more sensible
#-ignore
(defun create-file (path &key (if-exists :error)
                          (mac-file-type "TEXT")
                          (mac-file-creator (application-file-creator *application*))
                          &aux errno (full-path (full-pathname path :no-error nil)))
  (let ()
    (when (directory-pathname-p full-path)
      (return-from create-file (create-directory full-path :if-exists if-exists)))
    (when (not (pathname-directory full-path))
      (setq full-path (merge-pathnames (mac-default-directory) full-path)))
    (rletZ ((parentref :fsref)
            (newref :fsref)
            (catinfo :fscataloginfo))
      (let* ((*default-pathname-defaults* nil)  ;; so path-to-fsref doesn't get confused
             (dirpath (make-pathname :directory (pathname-directory full-path) :name nil :type nil :defaults nil)))
        (multiple-value-bind (RES IS-DIR)(path-to-fsref dirpath parentref)        
          (cond ((null res)
                 (create-directory dirpath :if-exists :error)
                 (return-from create-file (create-file full-path :if-exists if-exists
                                                       :mac-file-type mac-file-type
                                                       :mac-file-creator mac-file-creator)))
                ((null is-dir) (error "phooey")))          
          (setf (pref catinfo :fscataloginfo.finderinfo.filetype) mac-file-type)
          (setf (pref catinfo :fscataloginfo.finderinfo.filecreator) mac-file-creator)
          ;; maybe this fixes the probs
          (setf (pref catinfo :fscataloginfo.finderinfo.finderflags) 0) ;; ?
          (setf (pref catinfo :fscataloginfo.finderinfo.location) 0)          
          (let ((name&type (file-namestring full-path)))
            (setq name&type (%file-system-string name&type)) ;(%path-std-quotes name&type "" "")) ;; ??
            (setq name&type (get-unicode-string name&type))
            (let ((len (length name&type)))
              (%stack-block ((ustr (+ len len)))
                (dotimes (i len)
                  (%put-word ustr (%scharcode name&type i) (+ i i)))
                (prog ()
                  agin
                  (setq errno (#_fscreateFileUnicode parentref len ustr #$kFSCatInfoFinderInfo catinfo newref (%null-ptr)))
                  ;(print (list 'puke errno))  ;; error is -61 #$wrpermerr = write-permissions error - itsa CD
                  (cond ((eq errno $dupFNErr)
                         (cond 
                          ((eq if-exists :supersede)
                           (delete-file full-path)
                           (go agin))
                          (t (let ((newpath (if-exists if-exists full-path "Create…")))
                               (or newpath
                                   (return-from create-file nil))
                               (when (not (equalp full-path (full-pathname newpath :no-error nil)))
                                 (return-from create-file (create-file newpath :if-exists :supersede
                                                                       :mac-file-type mac-file-type
                                                                       :mac-file-creator mac-file-creator)))
                               (delete-file full-path)
                               (go agin)))))
                        ((neq 0 errno)(signal-file-error errno full-path)))))))
          (%path-from-fsref newref))))))

;; remove escapes and error if contains a ":"
(defun %file-system-string (name)
  (when (%path-mem-last-quoted ":" name)
    (signal-file-error $xbadfilenamechar name #\:))
  (%path-std-quotes name "" ""))



;#+new-files
;; not used
(defun exchange-files (old new &optional (errchk t) &aux (errno #$noerr) bad-file)
  (let ((full-old (truename old))
        (full-new (truename new)))
    (rlet ((oldfsref :fsref)
           (newfsref :fsref))
      (multiple-value-bind (oldres olddir)(make-fsref-from-path-simple full-old oldfsref)
        (cond 
         ((not oldres) 
          (setq errno  $err-no-file bad-file full-old)) ;; already know exists
         (olddir (setq errno  $xdirnotfile bad-file full-old))
         (t 
          (multiple-value-bind (newres newdir) (make-fsref-from-path-simple full-new newfsref)          
            (cond 
             ((not newres) 
              (setq errno $err-no-file bad-file full-new))
             (newdir
              (setq errno  $xdirnotfile bad-file full-new))
             (t 
              ;; does this do all the stuff?? seems to do the dates anyway
              (setq errno (#_fsexchangeobjects oldfsref newfsref))))))) 
        (when (and errchk (neq errno #$noerr)) (signal-file-error errno (or bad-file full-old)))
        errno))))

#|
(exchange-files2 "ccl:00alex-cfm.lisp" "ccl:00alex2.lisp")
(exchange-files2 "ccl:00alex2.lisp" "ccl:00alex-cfm.lisp")
|#
    
      


; what does this mean regarding aliases - hmm maybe it means the alias,
; or maybe it means both - I chose the alias cause deleting the file
; before the alias makes the alias useless which would mean that the
; alias should be deleted too. But one might want to delete an alias
; without deleting the target. Besides, the target might not be deleteable
;  -maybe an optional arg?

#|
(defun delete-file-old (path &key (if-does-not-exist nil) &aux errno)
  (%stack-iopb (pb np)
    (when (directory-pathname-p path)(setq path (dirpath-to-filepath path)))
    ; is this the right thing to do?
    (%path-to-iopb path pb :errchk :no-alias t)
    (setq errno (#_PBHDeleteSync pb))
    (when (eq errno $fnfErr)
      (case if-does-not-exist
        (:error (signal-file-error $err-no-file path))
        ((nil) (return-from delete-file-old nil))
        (t (report-bad-arg if-does-not-exist '(member :error nil)))))
    (unless (%izerop errno) (signal-file-error errno path))
    path))
|#


#+ignore
(defun mac-default-directory ()
  (%stack-iopb (pb np)
    (#_PBHGetVolSync :errchk pb)
    (%dir-path-from-iopb pb)))

;; moved from l1-boot-1
(defun get-app-pathname ()
  (rlet ((psn  :ProcessSerialNumber
               :highLongOfPSN 0
               :lowLongOfPSN  #$kCurrentProcess)
         (fsref :fsref))
    (#_getprocessbundleLocation psn fsref)
    (%path-from-fsref fsref)))

#-ignore ;; is this the same  or similar enuf?? - do we care??
;; cache this ??
(defun mac-default-directory ()
  (make-pathname :directory (%pathname-directory (get-app-pathname))))

(defun get-app-directory ()
  (make-pathname :directory (%pathname-directory (get-app-pathname))))

    
  

;The filename components are allowed to be present and will be ignored.
;That's a feature, not a bug.  Hope this doesn't show up in a Franz test suite.
;; hope nobody uses this
#|
(defun set-mac-default-directory (path)
  (cerror "ok" "please tell us why you are doing this")
  ;; do something with #$kFSVolFlagDefaultVolumeBit in FSVolumeInfo
  (%stack-iopb (pb np)
    (%path-GetDirInfo path pb :errchk)  ;; no longer defined
    (%put-ptr pb (%null-ptr) $ioFileName)
    (errchk (#_PBHSetVolSync  pb))
    (errchk (#_PBHGetVolSync  pb))
    (%dir-path-from-iopb pb)))
|#




 ;; see below
(defun mac-file-type (path)
  (mac-file-type-or-creator path :type))
(defun mac-file-creator (path)
  (mac-file-type-or-creator path :creator))

(defun mac-file-type-or-creator (path what &optional is-fullpath)
  (when (not is-fullpath)
    (setq path (truename path)))
  (rlet ((fsref :fsref)
         (catinfo :FSCataloginfo))
    (let (exists is-dir)      
      (multiple-value-setq (exists is-dir)(make-fsref-from-path-simple path fsref))
      (when (or (not exists) is-dir)(signal-file-error $err-no-file path)))
    (fsref-get-cat-info fsref catinfo #$kFSCatInfoFinderInfo)
    (ecase what
      (:type (pref catinfo :FSCataloginfo.FinderInfo.filetype))
      (:creator (pref catinfo :FSCataloginfo.FinderInfo.filecreator)))))


 ;; appears fukt - i thought it worked - did on 04-14, 04-15
(defun set-mac-file-type (path mac-file-type)
  (set-mac-file-type-and-creator path  mac-file-type nil)
  mac-file-type)

(defun set-mac-file-creator (path mac-file-creator)
  (set-mac-file-type-and-creator path nil mac-file-creator)
  mac-file-creator)

(defun set-mac-file-type-and-creator (path type creator &optional is-fullpath)
  (when (not is-fullpath)
    (setq path (truename path)))
  (rlet ((fsref :fsref)
         (catinfo :FSCataloginfo))
    (let (exists is-dir)      
      (multiple-value-setq (exists is-dir)(make-fsref-from-path-simple path fsref))
      (when (or (not exists) is-dir)(signal-file-error $err-no-file path)))      
    (fsref-get-cat-info fsref catinfo #$kFSCatInfoFinderInfo)
    (when type (setf (pref catinfo :FSCataloginfo.FinderInfo.filetype) type))
    (when creator (setf (pref catinfo :FSCataloginfo.FinderInfo.filecreator) creator))
    (fsref-set-cat-info fsref catinfo #$kFSCatInfoFinderInfo)
    nil))

(defun set-mac-file-type-or-creator (path what newval &optional is-fullpath)
  (ecase what
    (:type (set-mac-file-type-and-creator path newval nil is-fullpath))
    (:creator (set-mac-file-type-and-creator path nil newval is-fullpath)))
  newval)


(defun file-locked-p (path)
  (let ((bits (nth-value 1 (probe-file-x path))))
    (logbitp #$kFSNodeLockedBit bits)))


(defun file-author (path)
  (probe-file path)
  "")


;; from big-file-patch
(defun utcseconds (utcptr)
  "Returns bignum seconds from a Mac :UTCDateTime pointer."
  (+ ccl::$mac-time-offset ; Because the Mac thinks Universal time starts in 1904, and Lisp thinks it starts in 1900
     (ash (pref utcptr :UTCDateTime.highSeconds) 16)
     (pref utcptr :UTCDateTime.lowSeconds)))

(defun file-create-date (path &optional is-fullpath)
  (file-x-date path #$kFSCatInfoCreateDate is-fullpath))
(defun file-write-date (path &optional is-fullpath)
  (file-x-date path #$kFSCatInfoContentMod is-fullpath))

(defun file-x-date (path what &optional is-fullpath)
  (when (not is-fullpath) ;; nil if no exist
    (setq path (probe-file path))
    (if (not path) (return-from file-x-date nil)))
  (rlet ((fsref :fsref)
         (catinfo :FSCataloginfo))
    (if nil ;(not is-fullpath)
      (multiple-value-bind (exists is-dir)(path-to-fsref (full-pathname path) fsref)
        (declare (ignore is-dir))
        (when (not exists) (return-from file-x-date nil)))
      (make-fsref-from-path-simple path fsref))
    (fsref-get-cat-info fsref catinfo what)
    (utcseconds
     (case what
       (#.#$kFSCatInfoCreateDate (pref catinfo :FSCataloginfo.createDate))
       (#.#$kFSCatInfoContentMod (pref catinfo :FSCataloginfo.contentModDate))))))

;; kind of pessimal now
(defun mac-file-write-date (path)
  (let ((date (file-x-date path #$kFSCatInfoContentMod)))
    (if date (universal-to-mac-time date))))

(defun mac-file-create-date (path)
  (let ((date (file-x-date path #$kFSCatInfoCreateDate)))
    (if date (universal-to-mac-time date))))



(defun set-mac-file-create-date (path time)
  (set-file-x-date path (mac-to-universal-time time) #$kFSCatInfoCreateDate))
(defun set-mac-file-write-date (path time)
  (set-file-x-date path (mac-to-universal-time time) #$kFSCatInfoContentMod))

(defun set-file-create-date (path time) (set-file-x-date path time #$kFSCatInfoCreateDate))
(defun set-file-write-date (path time) (set-file-x-date path time #$kFSCatInfoContentMod))

(defun set-file-x-date (path time what &optional is-fullpath)
  (when (not is-fullpath) ;; error if no exist
    (setq path (truename path)))
  (rlet ((fsref :fsref)
         (catinfo :FSCataloginfo))
    (if nil ;(not is-fullpath)
      (multiple-value-bind (exists is-dir)(path-to-fsref path fsref)
        (declare (ignore is-dir))
        (if (not exists)(signal-file-error $err-no-file path)))
      (make-fsref-from-path-simple path fsref))
    (fsref-get-cat-info fsref catinfo what)
    (let ((ptr (case what
                 (#.#$kFSCatInfoCreateDate (pref catinfo :FSCataloginfo.createDate))
                 (#.#$kFSCatInfoContentMod (pref catinfo :FSCataloginfo.contentModDate))))
          (time-adj (- time ccl::$mac-time-offset)))
      (setf (pref ptr :UTCDateTime.highSeconds) (ash time-adj -32))
      (setf (pref ptr :UTCDateTime.lowSeconds)(logand time-adj #xffffffff))
      (setf (pref ptr :UTCDateTime.fraction) 0))
    (fsref-set-cat-info fsref catinfo what)))      



  

;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

(defun directory-exists-p (path)
  (if (directory-pathname-p path)
    (probe-file path)
    (progn (setq path (directory-namestring path))
           (probe-file path))))

(defloadvar *last-choose-file-directory* nil)

;New functions!  Maybe if we document these, people will be less confused...
(defun choose-file-default-directory ()
  (or (let ((dir *last-choose-file-directory*))
        (and dir (probe-file dir) dir))
      (let ((dir (full-pathname "home:")))
        (and dir (probe-file dir) (directory-namestring dir)))
      (directory-namestring (mac-default-directory))))

(defvar *custom-getfile-present* nil)
(def-ccl-pointers *custom-getfile-present* ()
  (setq *custom-getfile-present* (gestalt #$gestaltStandardFileAttr #$gestaltStandardFile58)))

(defun error-not-available (what)
  (error "~A is not available with your System Software version" what))

(defun load-alternate (module fn args)
  ;(error-not-available 'choose-file-dialog)
  (let ((*warn-if-redefine* nil)
        (*warn-if-redefine-kernel* nil))
    (require module))
  (apply fn args))

(defvar *ddir-vrefnum* 0)
(defvar *ddir-dirid*   0)
(defvar *ddir-name*    nil)

#-carbon-compat
(defun set-choose-dir-from-pb (pb)
  (let ((pathname (%dir-path-from-iopb pb)))
    (setq *last-choose-file-directory* (directory-namestring pathname))
    pathname))

#-carbon-compat
(defun set-choose-file-default-directory (path &optional no-error)
  (unless (and no-error
               (not (directory-exists-p path)))
    (%stack-iopb (pb np)
      (%path-GetDirInfo path pb :errchk)
      (setq *ddir-vrefnum* (%get-signed-word pb $ioVRefNum)
            *ddir-dirid*   (%get-signed-long pb $ioDirID)
            *ddir-name*    (mac-file-namestring path))  ; <<
      (#_LMSetSFSaveDisk (- *ddir-vrefnum*))
      (#_LMSetCurDirStore *ddir-dirid*) 
      (set-choose-dir-from-pb pb))))

#| ; moved to old/new
(defun choose-file-ddir ()
  (%stack-block ((pb $ioPBSize))
    (%put-word pb *ddir-vrefnum* $ioVRefNum)
    (%put-long pb *ddir-dirid*   $ioDirID)
    (set-choose-dir-from-pb pb)))
|#

; choose-file-dialog
; choose-new-file-dialog
; choose-directory-dialog



(defun choose-new-directory-dialog (&key directory
                                         (prompt "New Directory Name...")
                                         (button-string "Create"))
  (let ((file (choose-new-file-dialog :directory directory
                                      :prompt prompt
                                      :button-string button-string)))
    (make-pathname :directory (namestring file))))

;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

;; Cache values for %path-from-iopb
(defvar %saved-ioVRefnum% nil)
(defvar %saved-ioDirID% nil)
(defvar %saved-directory-path% nil)

;Get a pathname from $ioFileName, $ioVRefnum and $ioDirID fields of a pb.
;if ioFileName is null, returns a pathname with name and type null.
;Otherwise returns a fully qualified pathname (no null components).
;This is the basic File Manager -> Pathnames function.
; note that the quoting of dot and * here is not the same as in fs-cons-pathname
; fs-cons-pathname is more sensible re dots, and this guy quotes * which is correct.


 
(defun %std-name-and-type (str &optional (start 0))
  (if (encoded-stringp str)
    (let () ;(*pathname-escape-character* *pathname-escape-character-unicode*)) ;; these are the same today
      (multiple-value-bind (name type)(%std-name-and-type (the-string str)  start)
        (values name ;(if (stringp name)(maybe-make-encoded-string name) name)
                type ;(if (stringp type)(maybe-make-encoded-string type) type)
                )))
    (let ((lastpos start)
          (len (length str))
          dotpos)
      (setq lastpos (%path-mem-last ":" str))
      (setq lastpos (if lastpos (1+ lastpos) start))
      (setq dotpos (%path-mem-last "." str lastpos))
      (values (%path-std-quotes (if (or dotpos (neq lastpos 0))
                                  (%substr str lastpos (or dotpos len))
                                  str)
                                nil ".:;*")
              (if dotpos 
                (%path-std-quotes (%substr str (1+ dotpos) len) nil ".:;*")
                :unspecific)))))



(when (not (fboundp 'merge-pathnames))
  (defun translate-logical-pathname (path) (pathname path)) ;redefined later
  (defun merge-pathnames (path) path)   ; ditto 
  )


(defun alias-path-p (pathname &optional dont-resolve)
  (let* ((full-path (full-pathname pathname))
         (sub (alias-path-p-sub full-path)))
    (if dont-resolve
      sub
      (if (not sub)
        (values nil t)
        (let ((res (probe-file full-path)))
          (values pathname res))))))        


(defun alias-path-p-sub (fullpath)
  ;; just is there an alias anywhere in sight?
  ;; cons your brains out - 
  (let () ;(fullpath (full-pathname pathname)))
    (rletZ ((fsref :fsref))
      (multiple-value-bind (res) (make-fsref-from-path fullpath fsref nil)
        (cond ((and res (fsref-is-alias-p fsref))
               t)
              ((and (null res) (or (pathname-name fullpath) (pathname-type fullpath)))
               (alias-path-p-sub (make-pathname :directory (pathname-directory fullpath) :defaults nil)))
              ((null res)
               (let ((dir (pathname-directory fullpath)))
                 (if (and dir (> (length dir) 2))
                   (alias-path-p-sub (make-pathname :directory (subseq dir 0 (1- (length dir))) :name (car (last dir)) :defaults nil))
                   (if (and dir (cadr dir))
                     (not (null (maybe-alias-volume-from-dir dir))) ;(alias-path-p-sub (cadr dir))
                     nil))))
              (t nil))))))


(defun findfolder (vrefnum ostype &optional createp)
  (rlet ((fsref :fsref))
    (let ((errno (#_FSFindFolder vrefnum ostype createp fsref)))
      (when (zerop errno)
        (%path-from-fsref fsref t)))))



(defun mac-file-namestring (path)
  (mac-file-namestring-1 (translate-logical-pathname (merge-pathnames path))))

#|
(defun mac-file-namestring-1 (path)
  (%path-mac-namestring (file-namestring path)))
|#

; I think someone else should be calling translate-logical-pathname?
(defun mac-directory-namestring (path)
  (mac-directory-namestring-1 (translate-logical-pathname (merge-pathnames path))))

#|
(defun mac-directory-namestring-1 (path)
  (%path-mac-namestring   
   (%directory-list-namestring (pathname-directory path))))
|#

(defun get-hashed-path-thing (path hash thing)
  (when *use-namestring-caches*
    (let ((plist (gethash path hash)))
      (getf plist thing)))) 

(defun set-hashed-path-thing (path hash thing value)
  (when (and *use-namestring-caches*) ; (pathnamep path))  ;; don't set for string key??
    (let ((plist (gethash path hash)))
      (if (not plist)
        (setf (gethash path hash) (list thing value))
        (or (getf plist thing)
            (nconc plist (list thing value))))))
    value)

#|
(defun mac-namestring (path)  
  (let* ((path (translate-logical-pathname (merge-pathnames path))))
    (or (get-hashed-path-thing path new-mac-namestring-hash 'namestring)
        (let ((result(%str-cat (mac-directory-namestring-1 path) (mac-file-namestring-1 path))))
          (set-hashed-path-thing path new-mac-namestring-hash 'namestring result)
          ;(setf (gethash path mac-namestring-hash) result)
          result))))
|#

(defun mac-namestring (path)  
  (let* ((path (translate-logical-pathname path))) ;(merge-pathnames path)))) ;; not any more??
    (or (get-hashed-path-thing path new-mac-namestring-hash 'namestring)
        (let* ((mangled-path path) ;(check-os9-mangled-path path))
               (result (%str-cat  (mac-directory-namestring-1 mangled-path) 
                                             (mac-file-namestring-1 mangled-path))))            
            (set-hashed-path-thing path new-mac-namestring-hash 'namestring result)
            ;(setf (gethash path mac-namestring-hash) result)
            result))))




(defun mac-file-namestring-1 (path)
  (or (get-hashed-path-thing path new-mac-namestring-hash 'file-namestring)
      (let ((result (%path-mac-namestring (file-namestring path))))
        (set-hashed-path-thing path new-mac-namestring-hash 'file-namestring result)
        ;(setf (gethash path mac-file-namestring-hash) result)
        result)))
        

; I think someone else should be calling translate-logical-pathname?
(defun mac-directory-namestring (path)
  (mac-directory-namestring-1 (translate-logical-pathname (merge-pathnames path))))

(defun mac-directory-namestring-1 (path)
  (or (get-hashed-path-thing path new-mac-namestring-hash 'directory-namestring)
      (let ((result (%path-mac-namestring   
                     (%directory-list-namestring (pathname-directory path)))))
        (set-hashed-path-thing path new-mac-namestring-hash 'directory-namestring result)
        ;(setf (gethash path mac-directory-namestring-hash) result)
        result)))

;Prepare name for passing to ROM.  Verify that no wildcards or quoted colons,
;then remove all quoting.
(defun %path-mac-namestring (name)
  (when (%path-mem-last-quoted ":" name)
    (signal-file-error $xbadfilenamechar name #\:))
  (when (%path-mem-last "*" name)
    (signal-file-error $xillwild name))
  (%path-std-quotes name "" ""))

;;;;;;;;;;;;;;;;;;;;;;;;;;;  Pathnames ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;In case you were wondering, the fundamental functions now are pathname-xxxx,
;(not the pathname function itself, the way it used to be).


(defun logical-pathname-p (thing) (istruct-typep thing 'logical-pathname))

(when (not (fboundp 'pathname-host))
  (defun pathname-host (thing)  ; redefined later in this file
    (declare (ignore thing))
    :unspecific))

(when (not (fboundp 'pathname-version))
  (defun pathname-version (thing)  ; redefined later in this file
    (declare (ignore thing))
    :unspecific))


;; actually like this better? - but it ain't stringp

(def-accessors (encoded-string) %svref
  ()                                    ; 'encoded-string
  the-string
  the-encoding)

(make-built-in-class 'encoded-string *istruct-class*)  ;; so we can have a print-object method

(defun make-encoded-string (string &optional (type #$kcfstringencodingUnicode))
  (if (eql type #$kcfstringencodingUnicode)
    string
    (%istruct 'encoded-string string type)))

(defun encoded-stringp (thing)
  (istruct-typep thing 'encoded-string))





(defmethod print-object ((estring encoded-string) stream)
  (let ((encoding (the-encoding estring))
        (string (the-string estring)))
    (if (not (eql encoding #$kCFStringEncodingUnicode))
      (setq string (convert-string string encoding #$kCFStringEncodingUnicode)))
    (print-object string stream)))


(defun namestring-no-cache (path)
  (let ((*use-namestring-caches* nil))(namestring path)))
  

(defmethod print-object ((pathname pathname) stream)
  (let ((flags (if (logical-pathname-p pathname) 4
                   (%i+ (if (eq (%pathname-type pathname) ':unspecific) 1 0)
                        (if (equal (%pathname-name pathname) "") 2 0))))
        (name (namestring-no-cache pathname)))
    (if (and (not *print-readably*) (not *print-escape*))
      (if (stringp name)
        (write-string name stream)
        (progn (print-object name stream)))
      (progn
        (format stream (if (eql flags 0) "#P" "#~DP") flags)
        (if (stringp name)
          (write-escaped-string name stream #\")
          (print-object name stream))))))




; I thought I wanted to call this from elsewhere but perhaps not
(defun absolute-directory-list (dirlist)
  ; just make relative absolute and remove ups where possible
  (when (eq (car dirlist) :relative)
    (let ((default (mac-default-directory)) default-dir)
      (when default
        (setq default-dir (%pathname-directory default))
        (when default-dir
          (setq dirlist (append default-dir (cdr dirlist)))))))
  (when (memq :up dirlist)
    (setq dirlist (copy-list dirlist))
    (setq dirlist (remove-up dirlist)))
  dirlist)

; ? is (:absolute "a" :up "b") = (:absolute "b") - seems reasonable
; destructively mungs dir
#|
(defun remove-up-1 (dir)
  (let ((n 0)(sub (cdr dir))(last nil))
    (loop
      (cond ((eq (car sub) :up)
             (cond ((or (eq n 0)(and (stringp last)(string= last "**")))
                    (return (when (memq :up (cdr sub))
                              (remove-up sub))))
                   (t (rplacd (nthcdr (1- n) dir) (cdr sub))
                      (setq n (- n 2))))))
      (setq last (car sub) n (1+ n) sub (cdr sub))
      (if (null sub)(return nil)))
    dir))
|#
#|
(defun remove-up (dir)
  (let ((n 0)
        (last nil)
        sub)
    ;; from %std-directory-component we get dir with :relative/:absolute stripped 
    (if  (memq (car dir) '(:up :relative :absolute))
      (progn (setq sub (cdr dir))
             (if (eq (car dir) :up) (setq dir (cdr dir))))
      (setq sub dir))
    (loop
      (cond ((eq (car sub) :up)
             (cond ((or (eq n 0)(and (stringp last)(string= last "**")))
                    (return (when (memq :up (cdr sub))
                              (remove-up sub))))
                   (t (rplacd (nthcdr (1- n) dir) (cdr sub))
                      (setq n (- n 2))))))
      (setq last (car sub) n (1+ n) sub (cdr sub))
      (if (null sub)(return nil)))
    dir))
|#

(defun remove-up (dir)
  (let ((n 0)
        (last nil)
        (sub dir)
        has-abs kept-up)
    ;; from %std-directory-component we get dir with :relative/:absolute stripped
    (if (memq :up dir)
      (progn
        (when (memq (car dir) '(:relative :absolute))
          (setq sub (cdr dir) n 1 has-abs t))        
        (loop
          (cond ((eq (car sub) :up)
                 (cond ((or (eq n 0)(and (stringp last)(string= last "**"))(eq last :wild-inferiors) kept-up
                            (and has-abs (eq n 1)))
                        ;; up after "**" stays, initial :up stays, how bout 2 :ups
                        (setq kept-up t)
                        )
                       ((eq n 1)(setq dir (cddr dir) kept-up nil n -1))                        
                       (t (rplacd (nthcdr (- n 2) dir) (cdr sub))
                          (setq n (- n 2) kept-up nil))))
                (t (setq kept-up nil)))
          (setq last (car sub)
                n (1+ n) 
                sub (cdr sub))
          (if (null sub)(return nil)))
        dir)
      dir)))
             
#|
(defun namestring (path)
  (let ((host (pathname-host path)))
    (setq host (if (and host (neq host :unspecific))(%str-cat host ":") ""))
    (%str-cat host (directory-namestring path) (file-namestring path))))
|#

#|
(defun make-encoded-string (string &optional (encoding #$kcfstringencodingunicode))
  (when (not (stringp string)) (setq string (require-type string 'string)))
  (make-instance 'encoded-string :the-string string :the-encoding encoding))
|#

;; from l1-boot-1
;; this is only called by us on OSX for posix path nonsense


(defvar *got-boot-directory* nil)  ;; will fail if the user renames the boot-drive
#-ignore
(defun boot-directory ()
  (or *got-boot-directory*
      (setq *got-boot-directory*
            (drive-name (#_LMGetBootDrive)))))

;; fram pathnames - hope it isn't Japanese
#|
(defun drive-name (number)
  (cond 
   ((osx-p) (drive-name2 number))
   (t 
    (setq number (require-type number '(integer #x-8000 #x7fff)))
    (%stack-iopb (pb np)
      (%put-word pb 0 $ioVolIndex)
      (%put-word pb number $ioVRefNum)
      (errchk (#_PBHGetVInfoSync pb))
      (make-pathname :directory (%get-string np) :defaults nil)))))
|#

;; PBGetVolumeInfoSync of a FSVolumeInfoParam

;; On os9 -1 works, Lmgetbootdrive -32733 doesn't - but on OSX lmgetbootdrive is -100 which does work
(defun drive-name (number)
  (rletZ ((volinfo :fsvolumeinfoparam)
          (vname :hfsunistr255))
    ;(%clear-block volinfo (record-length :fsvolumeinfoparam)) ;; why needed? else the world gets very fouled up - use rletZ 
    (setf (pref volinfo :fsvolumeinfoparam.iovrefnum) number)
    (setf (pref volinfo :fsvolumeinfoparam.volumeindex) 0)
    (setf (pref volinfo :fsvolumeinfoparam.whichinfo) 0)
    (setf (pref volinfo :fsvolumeinfoparam.volumename) vname)
    (setf (pref volinfo :fsvolumeinfoparam.volumeinfo) (%null-ptr))
    (when (eq 0 (#_PBGetVolumeInfoSync volinfo))
      (let ((str (string-from-hfsunistr vname)))
        (make-pathname :directory str :defaults nil)))))

(def-ccl-pointers got-boot-dir ()
  (setq *got-boot-directory* nil))



 ;; is this more politically correct ? slightly slower
(defun my-fsref-make-path-string (fsref &optional (errorp t))
  (with-macptrs ((cfurl (#_CFURLCreateFromFSRef (%null-ptr) fsref)))
    (if (%null-ptr-p cfurl)
      (if errorp (error "Failed to create URL") nil)  ;; or "" ??
      (with-macptrs ((cfstr (#_CFURLCopyFileSystemPath cfurl #$kCFURLPOSIXPathStyle)))
        (#_cfrelease cfurl)
        (if (%null-ptr-p cfstr)
          (if errorp (error "phooey") nil)
          (unwind-protect 
            (get-cfstr cfstr)
            (#_cfrelease cfstr)))))))


(defun 7bit-ascii-p (string &optional (start 0)(end (length string)))  
  (declare (fixnum start end))
  (multiple-value-bind (string strb)(array-data-and-offset string)
    (declare (fixnum strb))
    (let ((org (%i+ strb start)))
      (declare (fixnum org))
      (dotimes (i (%i- end start) t)
        (declare (fixnum i))
        (when (%i> (%scharcode string (%i+ i org)) #x7f) (return nil))))))

(defun latin1-p (string &optional (start 0)(end (length string)))  
  (declare (fixnum start end))
  (multiple-value-bind (string strb)(array-data-and-offset string)
    (declare (fixnum strb))
    (let ((org (%i+ strb start)))
      (declare (fixnum org))
      (dotimes (i (%i- end start) t)
        (declare (fixnum i))
        (when (%i> (%scharcode string (%i+ i org)) #xFF) (return nil))))))

#|
(defun %volume-from-posix-path (whole-path)
  (let ((start 0))    
    (if (and (>= (string-length whole-path) 9)
             (string-equal "/Volumes/" whole-path :start2 0 :end2 9)) ;(%substr whole-path 0 9)))
      (setq start 9)
      ;; or volume is missing if boot-volume
      (progn (return-from %volume-from-posix-path t)))            
    (let ((slash-pos (string-length whole-path))) ;(%str-member #\/ whole-path start)))
      (cond (slash-pos 
             (LET ((sub (%substr whole-path start slash-pos)))                     
               (%str-subst sub #\/ #\:)
               (%path-std-quotes sub nil ";*")))
            (t nil)))))
  

;; return t for boot-vol, else string or encoded-string, or nil if no volume (is that possible?)
(defun %volume-from-fsref (fsrefptr)
  (let ((whole-path (my-fsref-make-path Fsrefptr)))
    (if (and (osx-p)(using-posix-paths-p))
      (Progn
        ;(setq want-dir (%ilogbitp #$kFSNodeIsDirectoryBit (fsref-node-bits fsrefptr))) 
        ;"/Volumes/hd3/CCL3and4-fromzoe-new-int-c4/asdfasdfasdfasdfasdfasdfasdfasdfasdf")
        (if (typep whole-path 'encoded-string)
          ;; beware of option-d?
          (let* ((encoded-whole-path whole-path)
                 (whole-path (the-string encoded-whole-path))                 
                 ;(*pathname-escape-character* *pathname-escape-character-unicode*)  ;; they are the same
                 ) ;; tell subfns we are working with raw unicode ??
            (let ((it (%volume-from-posix-path whole-path)))
              it))
              ;(if (stringp it)(maybe-make-encoded-string it) it)))         
          (%volume-from-posix-path whole-path)))
      (error "shouldn't"))))
|#


(defun %path-from-fsref (fsrefptr &optional want-dir) ;; want-dir no longer needed - we find the truth
  (let ((whole-string (my-fsref-make-path-string Fsrefptr))
        (use-cache *use-namestring-caches*)
        hash-val)
    (if (and  (using-posix-paths-p))
      (Progn        
        (cond 
         ((and use-cache (setq hash-val (gethash whole-string namestring-path-hash)))
          ;; too bad gethash can't return the found key
          (let ((the-spelling (car hash-val))
                (the-path (cdr hash-val)))
            (cond ((string= the-spelling whole-string)
                   the-path)
                  ;; its there but spelled "wrong" - so lose all knowledge
                  (t (remhash whole-string namestring-path-hash)
                     (remhash the-path new-namestring-hash)
                     (remhash the-path new-mac-namestring-hash)
                     (when (fboundp 'back-translate-pathname)
                       (let ((bt (back-translate-pathname the-path)))  ;; double ugh
                         (when (neq bt the-path)
                           (remhash bt new-namestring-hash))
                         ;(remhash bt new-mac-namestring-hash)
                         ))
                     (%path-from-fsref fsrefptr)))))
         (t 
          ;"/Volumes/hd3/CCL3and4-fromzoe-new-int-c4/asdfasdfasdfasdfasdfasdfasdfasdfasdf")
          (setq want-dir (%ilogbitp #$kFSNodeIsDirectoryBit (fsref-node-bits fsrefptr)))
          (let ((start 0)
                (dir nil))
            (if (and (>= (length whole-string) 9)
                     (string-equal "/volumes/" whole-string :start2 0 :end2 9)) ;(%substr whole-path 0 9)))
              (setq start 9)
              ;; or volume is missing if boot-volume
              (progn (setq dir (cons (second (%pathname-directory (boot-directory))) nil))
                     (setq start 1)))
            (loop
              (let ((slash-pos (%str-member #\/ whole-string start)))
                (cond (slash-pos 
                       (LET ((sub (%substr whole-string start slash-pos)))                     
                         (%str-subst sub #\/ #\:)
                         (setq dir (cons (%path-std-quotes sub nil ";*") dir))
                         (setq start (1+ slash-pos))))
                      (t (return)))))
            (setq dir (if dir (cons ':absolute (nreverse dir))))
            (let ((sub (%str-subst (%substr whole-string start (length whole-string)) #\/ #\:))
                  the-path)
              (if want-dir
                (progn
                  (when (neq start (length whole-string))
                    (let* ((last (%path-std-quotes sub nil ";*")))
                      (setq dir (if dir (nconc dir (list last))
                                    (list  ':absolute last))))) 
                  (setq the-path (%cons-pathname dir nil nil)))            
                (multiple-value-bind (name type)(%std-name-and-type sub)
                  ;; above might give us type :unspecific vs nil
                  (setq the-path (%cons-pathname dir name type))))
               ;(if want-dir (push (list dir (copy-list dir)) horse))  ;; something clobbers the dir - maybe fixed
              (when (and  use-cache #+ignore (not want-dir))
                (setf (gethash whole-string namestring-path-hash)(cons whole-string the-path)))
              the-path)))))
      (let ()          
        ;(pathname (%path-std-quotes whole-path nil ";*"))
        (simple-pathname whole-string)                  
        ))))


                     


(defun simple-pathname (whole-path)
  (let* ((dir-len (1+ (%path-mem-last ":" whole-path)))
         (len (length whole-path))
         (dir (simple-directory-string-list (%path-std-quotes (if (eq dir-len len) whole-path (%substr whole-path 0 dir-len)) nil ";*"))))
    (cond ((neq dir-len len)
           (multiple-value-bind (name type)(%std-name-and-type whole-path dir-len)
             (%cons-pathname dir name type)))
          (t (%cons-pathname dir nil nil)))))

(defun simple-directory-string-list (string)
  (let ((so-far nil)
        (last-pos 0)
        pos)
    (while (setq pos (%str-member #\: string last-pos))
      (push (%substr string last-pos pos) so-far)
      (setq last-pos (1+ pos)))
    (cons :absolute (nreverse so-far))))

#+PPC-target
(defun %path-quoted-p (sstr pos start &optional (esc *pathname-escape-character*) &aux (q nil))
  (while (and (%i> pos start) (eq (%schar sstr (setq pos (%i- pos 1))) esc))
    (setq q (not q)))
  q)
  
  

(defun maybe-encoded-strcat (s1 s2)
  (when (and (typep s1 'encoded-string)
             (typep s2 'encoded-string))
    (if (not (eql (the-encoding s1) (the-encoding s2)))
      (error "Can't strcat")))
  (let (encoding)
    (if (encoded-stringp  s1)
      (progn
        (setq encoding (the-encoding s1))
        (setq s1 (the-string s1))
        (if (not (encoded-stringp s2))
          (setq s2 (convert-string s2 #$kCFStringEncodingUnicode encoding))
          (setq s2 (the-string s2))))
      (if (encoded-stringp s2)
        (progn
          (setq encoding (the-encoding s2))
          (setq s2 (the-string s2))
          (setq s1 (convert-string s1 #$kCFStringEncodingUnicode encoding)))))
    (let ((string (%str-cat S1 s2)))
      (if (and encoding (neq encoding #$kCFStringEncodingUnicode))
        (make-encoded-string string encoding)
        string))))



(eval-when (:compile-toplevel :load-toplevel :execute)
(defmacro maybe-encoded-strcat-many (s1 s2 &rest args)
  (if args `(maybe-encoded-strcat ,s1 (maybe-encoded-strcat-many ,s2 ,@args))
     `(maybe-encoded-strcat ,s1 ,s2)))
)


(defun %str-cat-maybe-encoded (s1 s2 &rest more)
  (declare (dynamic-extent more))
  (if (not more)
    (maybe-encoded-strcat s1 s2)
    (if (or (encoded-stringp s1)(encoded-stringp s2)
            (dolist (x more nil)
              (if (encoded-stringp x)(return  t))))    
      (progn 
        (let ((res (maybe-encoded-strcat s1 s2)))
          (dolist (x more)
            (setq res (maybe-encoded-strcat res x)))
          res))
      (apply '%str-cat s1 s2 more))))


(defun namestring (path)
  (or (get-hashed-path-thing path new-namestring-hash 'namestring)
      (let ((host (pathname-host path)) result)
        (setq host (if (and host (neq host :unspecific))(%str-cat host ":") ""))
        (setq result (%str-cat host (directory-namestring path) (file-namestring path)))
        (set-hashed-path-thing path new-namestring-hash 'namestring result)
        ;(setf (gethash path namestring-hash) result)
        result)))

   

(defun host-namestring (path)
  (let ((host (pathname-host path)))
    (if (and host (neq host :unspecific)) host  "")))


(defun directory-namestring (path)
  (or (get-hashed-path-thing path new-namestring-hash 'directory-namestring)      
      (let* ((dirlist (pathname-directory path))
             (host (pathname-host path))
             ; what if its a logical-pathname whose host is explicitly :unspecific?? - beats me - shouldn't happen?
             (result (%directory-list-namestring dirlist (or  host (logical-pathname-p path))))) ; << 7/96
        (cond ((and (not host)   ; put in a quote if it is not logical but might appear to be
                    (consp dirlist) 
                    (eq (car dirlist) :absolute)
                    (stringp (cadr dirlist))
                    (null (cddr dirlist))
                    (%str-assoc  (cadr dirlist) %logical-host-translations%))
               ;; this ain't right for encoded-string result components
               (let ((pos (%path-mem ":" result)))
                 (setq result
                       (%str-cat  (%substr result 0  pos) "∂" 
                                                   (%substr result pos (length result))))))
              (t result))
        (set-hashed-path-thing path new-namestring-hash 'directory-namestring result)
        result)))    
               

;This assumes that :'s and ;'s in components are escaped (otherwise would have to
;pre-scan for escapes, yuck).


;; N.B. ∂ IS NOT 7bit ascii - is #xb6 in macroman - is #x2202 in unicode - I wonder what #x2202 is in MacJapanese
(defun %directory-list-namestring (list &optional host)
  (when (eq host :unspecific) (setq host nil))
  (if (null list)
    ""      
    (let ((len (if (eq (car list) :relative) 1 0))
          (type 'base-character)
          result)
      (declare (fixnum len)(optimize (speed 3)(safety 0)))
      (dolist (s (%cdr list))
        (when (consp s)(setq s (cadr s)))
        (case s
          (:wild (setq len (+ len 2)))
          (:wild-inferiors (setq len (+ len 3)))
          (:up (setq len (+ len 1)))
          (t (setq len (+ len 1 (if (typep s 'encoded-string)(length (the-string s))(length s))))
             (if (or (extended-string-p s)(typep s 'encoded-string))
               (setq type 'extended-character)))))
      (setq result (make-string len :element-type type))
      (let ((i 0)
            (sep (if host (char-code #\;)(char-code #\:))))
        (declare (fixnum i))
        (when (eq (%car list) :relative)
          (setf (%scharcode result 0) sep)
          (setq i 1))
        (dolist (s (%cdr list))
          (let ((sep sep))
            (when (consp s)
              (setq s (cadr s))
              (setq sep (char-code #\;)))
            (case s
              (:wild (setq s "*"))
              (:wild-inferiors (setq s "**"))
              (:up (setq s nil)))
            (when s
              (cond ((typep s 'encoded-string)
                     (let ((enc (the-encoding s)))
                       (setq s (the-string s))
                       (if (neq enc #$kcfstringencodingunicode)
                         (setq s (convert-string s enc #$kcfstringencodingunicode))))))
              (let ((len (length s)))
                (declare (fixnum len))
                (move-string-bytes s result 0 i len)
                (setq i (+ i len))))
            (setf (%scharcode result i) sep)
            (setq i (1+ i)))))
      result))) 


(defun file-namestring (path)
  (or (get-hashed-path-thing path new-namestring-hash 'file-namestring)
      (let* ((name (pathname-name path))
             (type (pathname-type path))
             (version (pathname-version path))
             result)
        (case version
          (:newest (setq version ".newest"))
          (:wild (setq version ".*"))
          ((nil :unspecific) (setq version nil))
          (t (setq version (if (fixnump version)
                             (%str-cat "." (%integer-to-string version))
                             (%str-cat "." version)))))
        (if (eq name :unspecific) (setq name nil))
        (setq result
              (if (and type (neq type :unspecific))
                (if (null name)
                  (%str-cat  "."  type (or version ""))
                  (%str-cat name "."  type (or version "")))
                (if version ; version no type
                  (if (null name)
                    (%str-cat "." version)
                    (%str-cat name  "." version))
                  (or name
                      ""))))
        (set-hashed-path-thing path new-namestring-hash 'file-namestring result)
        result)))

; not used -  is CL
(defun enough-namestring (path &optional (defaults *default-pathname-defaults*))
  (if (null defaults)(namestring path)
      (let* ((path (pathname path))
             (dir (pathname-directory path))
             (nam (pathname-name path))
             (typ (pathname-type path))
             (host (pathname-host path))
             (default-dir (pathname-directory defaults))
             (real-host host))
        (when (equalp host (pathname-host defaults))
          (setq host nil))
        (setq host (if (and host (neq host :unspecific))
                     (%str-cat-maybe-encoded host ":")
                     ""))
        (cond ((equalp dir default-dir)
               (setq dir nil))
              ((and dir default-dir
                    (eq (car dir) :absolute)(eq (car default-dir) :absolute))
               (let (res) ; maybe make it relative to defaults
                 (do ((p1 (cdr dir) (cdr p1))
                      (p2 (cdr default-dir) (cdr p2)))
                     nil 
                   (cond ((null p1) (return nil))
                         ((null p2)
                          (when res
                            (setq dir (cons :relative p1)))
                          (return))
                         ((not (equalp (car p1)(car p2)))
                          (return nil))
                         (t (setq res t)))))))
        (when (equalp typ (pathname-type defaults))
          (setq typ nil))
        (when (and (null typ) (equalp nam (pathname-name defaults)))
          (setq nam nil))
        (when (and typ (neq typ :unspecific))
          (setq nam (if (null nam) (%str-cat-maybe-encoded "." typ) (%str-cat-maybe-encoded nam "." typ))))
        (cond (dir
               ; what if its a logical-pathname whose host is explicitly :unspecific?? ok
               (setq dir (%directory-list-namestring dir (or real-host (logical-pathname-p path)))) ; 7/96
               (if nam (%str-cat host dir nam)(%str-cat-maybe-encoded  host dir)))
              ((neq (length host) 0)
               (if nam (%str-cat-maybe-encoded host ";" nam)(%str-cat-maybe-encoded host ";")))
              (t (or nam ""))))))

(defun cons-pathname (dir name type &optional host version)
  (if (and host (neq host :unspecific))
    (%cons-logical-pathname dir name type host version)
    (%cons-pathname dir name type)))

; Question of the day - what is (pathname ":foo;")
; is it host "" directory (:absolute (:logical "foo"))  (get this on 06/19/90)
; or is it host :unspecific directory (:relative (:logical "foo")) (get this on 06/20/90)
; note that (make-pathname :directory '(:relative (:logical "foo"))) is #P":foo;"

(defun pathname (path)
  (when (streamp path) (setq path (%path-from-stream path)))
  (if (pathnamep path)
    path
    (progn
      (when (typep path 'encoded-string)
        (let ((encoding (the-encoding path)))          
          (setq path (the-string path))           
          (when (not (eql encoding #$kcfstringencodingunicode))
              (setq path (convert-string path encoding #$kcfstringencodingunicode)))))      
      (multiple-value-bind (sstr start end) (get-sstring path)
        (let (directory name type host version pos semi-pos)
          (multiple-value-setq (host pos semi-pos)(pathname-host-sstr sstr start end))
          (when pos (setq start pos))
          (multiple-value-setq (directory pos)(pathname-directory-sstr sstr start end host))
          (when directory (setq start pos))
          (multiple-value-setq (version pos)(pathname-version-sstr sstr start end))
          ; version is :unspecific :newest or "*" or 0
          (when pos (setq end pos))
          (multiple-value-setq (type pos)(pathname-type-sstr sstr start end))
          ; type-sstr should return beginning of type field
          (when pos (setq end pos))
          ; now everything else is the name
          (unless (eq start end)
            (setq name (%std-name-component (%substr sstr start end))))
          (if semi-pos ; << 7/96
            ; the fact that we make a logical pathname is the ONLY clue that dir contained ;'s
            (%cons-logical-pathname directory name type host version)
            (cons-pathname directory
                           name
                           type
                           host
                           version)))))))


(defun %path-from-stream (stream)
  (or (stream-filename stream)
      (signal-type-error stream 'file-stream "Can't determine pathname of ~S .")))      ; ???

;Like (pathname stream) except returns NIL rather than error when there's no
;filename associated with the stream.
(defun stream-pathname (stream &aux (path (stream-filename stream)))
  (when path (pathname path)))

; this is currently only called by set-logical-pathname-translations
; in fact things would be simpler parse-namestring really did the parsing
; and pathname called it instead of vice versa 

(defun parse-namestring (thing &optional host (defaults *default-pathname-defaults*)
                               &key (start 0) end junk-allowed)
  (declare (ignore junk-allowed))
  (cond 
   ((pathnamep thing)
    (values thing start))
   ((streamp thing)  ;; don't error if no pathname??
    (values (or (stream-pathname thing) (parse-namestring ""))
            start))
   (t    
    (cond ((null host)  (setq host (pathname-host defaults)))
          (t (verify-logical-host-name host)))
    (when (null end) (setq end (string-length thing)))
    (when (> start end) (error "~S ~S is more than ~S ~S" :start start :end end))
    (unless (and (eq start 0) (eq end (string-length thing)))
      (if (stringp thing)
        (multiple-value-bind (sstr start end) (get-sstring thing start end)
          (setq thing (%substr sstr start end)))
        (setq thing (%substr thing start end))))
    (when (and host (neq host :unspecific))
      (let ((thing-host (pathname-host thing)))
        (cond ((and thing-host (neq thing-host :unspecific))
               (when (not (string-equal host thing-host))
                 (signal-type-error thing-host host "Host ~S does not match default host ~S")))
              ; here require no colons in thing - obey junk-allowed  ?
              (t (when (not (%path-mem ":" thing))
                   ; it is not clear that we are obligated or even permitted to glom on the host
                   ; so below is questionable
                   (setq thing (%str-cat host ":" thing)))
                 ))))
    (values (pathname thing) end))))

(defun make-pathname (&key (host nil host-p) 
                           device
                           (directory nil directory-p)
                           (name nil name-p)
                           (type nil type-p)
                           (version nil version-p)
                           (defaults nil defaults-p) case
                           &aux path default-dir)
  (declare (ignore device defaults-p))
  (when case (setq case (require-type case pathname-case-type)))
  (when (null host-p)
    (if defaults (setq host (pathname-host defaults))))
  (if directory-p 
    (setq directory (%std-directory-component directory host)))
  (if defaults
    (setq default-dir (pathname-directory defaults)))
  (cond ((null directory)(setq directory default-dir))
        #+ignore
        ((and default-dir (eq (car directory) ':relative))
         (setq directory (append default-dir (cdr directory)))
         (when (memq :up directory)(setq directory (remove-up (copy-list directory)))))) 
  (setq name
        (if name-p
             (%std-name-component name)
             (and defaults (pathname-name defaults))))
  (setq type
        (if type-p
             (%std-type-component type)
             (and defaults (pathname-type defaults))))
  (setq version (if version-p
                  (%logical-version-component version)
                  (and defaults (pathname-version defaults))))  
  (setq path
        (if (or (eq host :unspecific)  ; 7/96
                (and (not host-p)
                     (or (null defaults) (physical-pathname-p (pathname defaults)))))
          (%cons-pathname directory name type)
          (%cons-logical-pathname directory name type host version)))
  (when (and case (neq case :local))
    (setf (%pathname-directory path) (%reverse-component-case (%pathname-directory path) case)
          (%pathname-name path) (%reverse-component-case (%pathname-name path) case)
          (%pathname-type path) (%reverse-component-case (%pathname-type path) case)))
  path)

;  In portable CL, if the :directory argument to make pathname is a string, it should
;  be the name of a top-level directory and should not contain any punctuation characters
;  such as ":" or ";".  In MCL a string :directory argument with colons or semicolons
;  will be parsed as a directory in the obvious way.
(defun %std-directory-component (directory &optional host)
  ;; host not really used
  (cond ((null directory) nil)
        ((eq directory :wild) '(:absolute :wild-inferiors)) ; or :wild-inferiors? - yes
        ((stringp directory) (%directory-string-list directory 0 (length directory) host))
        ((encoded-stringp directory) (%directory-string-list directory 0))
        ((listp directory)         
         ;Standardize the directory list, taking care not to cons if nothing
         ;needs to be changed.
         (let ((names (%cdr directory)) (new-names ()))           
           (do ((nn names (%cdr nn)))
               ((null nn) (setq new-names (if new-names (nreverse new-names) names)))
             (let* ((name (car nn))
                    (new-name (cond ((consp name)(error "Shouldnt"))
                                    (t (%std-directory-part name)))))
               (unless (eq name new-name)
                 (unless new-names
                   (do ((new-nn names (%cdr new-nn)))
                       ((eq new-nn nn))
                     (push (%car new-nn) new-names))))
               (when (or new-names (neq name new-name))
                 (push new-name new-names))))
           (when (memq :up (or new-names names))
             (setq new-names (remove-up (copy-list (or new-names names)))))
           (ecase (%car directory)
             (:relative           
                  (cond (new-names         ; Just (:relative) is the same as NIL. - no it isnt
                         (if (eq new-names names)
                           directory
                           (cons ':relative new-names)))
                        (t directory)))
             (:absolute
                  (cond ((null new-names) directory)  ; But just (:absolute) IS the same as NIL
                        ((eq (%car new-names) ':up)
                         (report-bad-arg (%car new-names)'(not (member :up))))
                        ((eq new-names names) directory)
                        (t (cons ':absolute new-names)))))))
        (t (report-bad-arg directory '(or string list encoded-string (member :wild))))))

(defun %std-directory-part (name)
  (case name
    ((:wild :wild-inferiors :up) name)
    (:back :up)
    (t (cond ((encoded-stringp name) 
              (let ((my-string (the-string name)))
                (cond ((string= my-string "*") :wild)
                      ((string= my-string "**") :wild-inferiors)
                      (t (%path-std-quotes name ":;*" ":;")))))
             ((string= name "*") :wild)
             ((string= name "**") :wild-inferiors)
             (t (%path-std-quotes name ":;*" ":;"))))))

; this will allow creation of garbage pathname "foo:bar;bas:" do we care?
(defun merge-pathnames (path &optional (defaults *default-pathname-defaults*)
                                       default-version)
  ;(declare (ignore default-version))
  (when (not (pathnamep path))(setq path (pathname path)))
  (when (and defaults (not (pathnamep defaults)))(setq defaults (pathname defaults)))
  (let* ((path-dir (pathname-directory path))
         (path-host (pathname-host path))
         (path-name (pathname-name path))
         (default-dir (and defaults (pathname-directory defaults)))
         (default-host (and defaults (pathname-host defaults)))
         ; take host from defaults iff path-dir is logical or absent - huh? 
         ; we used to turn "foo;bar" into (:absolute (:logical foo)) no mo
         (host (cond ((or (null path-host)  ; added 7/96
                          (and (memq path-host '(nil :unspecific))
                               (or (null path-dir)
                                   (null (cdr path-dir))
                                   (consp (cadr path-dir)) ; not relevant now
                                   (and (eq :relative (car path-dir))
                                        (not (memq default-host '(nil :unspecific)))))))
                          
                      default-host)
                     (t  path-host)))
         (dir (cond ((null path-dir) default-dir)
                    ((null default-dir) path-dir)
                    ((eq (car path-dir) ':relative)
                     (let ((the-dir (append default-dir (%cdr path-dir))))
                       (when (memq ':up the-dir)(setq the-dir (remove-up (copy-list the-dir))))
                       the-dir))
                    (t path-dir)))
         (nam (or path-name
                  (and defaults (pathname-name defaults))))
         (typ (or (pathname-type path)
                  (and defaults (pathname-type defaults))))
         (version (cond ((and (not path-name) defaults)(pathname-version defaults))
                        (t (pathname-version path)))))
    (when (and default-version (or (null version)(eq version :unspecific)))
      (setq version default-version))
    (if (and (pathnamep path)
             (eq dir (%pathname-directory path))
             (eq nam path-name)
             (eq typ (%pathname-type path))
             (eq host path-host)
             (eq version (pathname-version path)))
      path 
      (cons-pathname dir nam typ host version))))

(defun directory-pathname-p (path)  (let ((name (pathname-name path))(type (pathname-type path)))    (and (or (null name) (eq name :unspecific) (%izerop (length name)))              (or (null type) (eq type :unspecific)))))
(defun pathname-version (path)
  (when (streamp path) (setq path (%path-from-stream path)))
  (typecase path
    (logical-pathname (%logical-pathname-version path))
    (pathname :unspecific)
    (string
     (multiple-value-bind (sstr start end) (get-sstring path)
       (pathname-version-sstr sstr start end )))
    (encoded-string
     (let* ((sstr (the-string path)))
       (let ((res (pathname-version-sstr sstr 0 (length sstr))))
         (if (stringp res) (make-encoded-string res (the-encoding path)) res))))
    (t (report-bad-arg path pathname-arg-type))))

;; 7/96 this gives inconsistent results 
;; (pathname-version (pathname "foo.0")) is :unspecific
;; but (pathname-version "foo.0") is nil
;; was always that way and no one complained so leave it for now.
;; there is not much hope of making sense of versions anyway
(defun pathname-version-sstr (sstr start end)
  (declare (fixnum start end))
  (let ((pos (%path-mem-last ":;" sstr start end)))
    (when pos (setq start (%i+ 1 pos)))
    (setq pos (%path-mem "." sstr start end))
    (when pos
      (setq pos (%path-mem-last "." sstr (%i+ pos 1) end))
      (when pos
        (setq start (%i+ pos 1))
        (if (= start end)
          (values :unspecific end) ;(%i- end 1))  ; lonely dot
          (let ((v (%substr sstr start end)))
            (setq start (%i- start 1))      ; back up to exclude dot
            (cond ((string=  v "*")
                   (values v start))
                  ((string-equal v "newest")
                   (values :newest start))
                  (nil ;(string= v "0")
                   (values 0 start))
                  (t (values :unspecific end)))))))))

;In CCL, a pathname is logical if and only if pathname-host is not :unspecific.
(defun pathname-host (thing &key case)
  (when (streamp thing)(setq thing (%path-from-stream thing)))
  (when case (setq case (require-type case pathname-case-type)))
  (let ((name
         (typecase thing    
           (logical-pathname (%logical-pathname-host thing))
           (pathname :unspecific)
           (string (multiple-value-bind (sstr start end) (get-sstring thing) 
                     (pathname-host-sstr sstr start end)))
           (encoded-string
            (let* ((sstr (the-string thing))
                   ;(*pathname-escape-character* *pathname-escape-character-unicode*)
                   res)
              (setq res (pathname-host-sstr sstr 0 (length sstr)))
              (if (stringp res)
                (if (7bit-ascii-p res) res (make-encoded-string res (the-encoding thing)))
                res)))
           (t (report-bad-arg thing pathname-arg-type)))))
    (if (and case (neq case :local))
      (%reverse-component-case name case)
      name)))


; thing is logical-host if it starts with foo: which is a defined logical host
; and it contains no other unquoted colons
; So if one has a disk with the same name as a defined logical host
; either rename the disk or access it via (make-pathname :directory "foo" )

; this week if string contains colons (and not defined host) then return host :unspecific
; else host is nil

(defun pathname-host-sstr (sstr start end &optional no-check)
  (when (not (%path-one-quoted-p ":" sstr start end))
    (let* ((pos (%path-mem ":;" sstr start end))
           (pos-char (and pos (%schar sstr pos)))
           (host
            (when (and pos 
                       (neq pos start)   ; leading : doesnt specify a host
                       (eql pos-char #\:) ; a colon
                       (not (%path-mem ":" sstr (%i+ 1 pos) end))) ; the only colon
              (%substr sstr start pos)))
           (semi-pos (if (eq pos-char #\;)
                       pos
                       (%path-mem ";" sstr (or pos start) end)))) ; << 7/96
      (cond ((and host (or no-check (%str-assoc host %logical-host-translations%)))
             (values host (%i+ pos 1) semi-pos))
            (host 
             ; there was exactly one non-leading colon and its not a defined host
             (if semi-pos
               (error "~S is not a defined logical host" host)
               (values :unspecific nil nil)))  ; gaak
            ((and pos
                  (or (and (eql pos-char #\:)
                           semi-pos)
                      (and (eql pos-char #\;)
                           (%path-mem ":" sstr (%i+ pos 1) end))))
             (pathname-parse-error "~S is not a valid namestring."  sstr))              
            (t (if (and (eq pos-char #\:)(null semi-pos))
                 (values :unspecific nil nil)
                 (values nil nil semi-pos)))))))
  


; huh??
(defun pathname-device (thing &key case)
  (declare (ignore case thing))
  ;(pathname thing)
  :unspecific)

(defun pathname-directory-sstr (sstr start end &optional host)
  (let (pos (other-str (%path-unquote-one-quoted ":" sstr start end)))
    (when other-str (setq sstr other-str))
    (setq pos (%path-mem-last ":;" sstr start end))
    (when pos
      (setq pos (%i+ pos 1))
      (values 
       (%directory-string-list sstr start pos host)
       (if other-str (1+ pos) pos)))))

;A directory is either NIL or a (possibly wildcarded) string ending in ":" or ";"
;Quoted :'s are allowed at this stage, though will get an error when go to the
;filesystem. 

(defun pathname-directory (path &key case)
  (when (streamp path) (setq path (%path-from-stream path)))
  (when case (setq case (require-type case pathname-case-type)))
  (let ((names (typecase path
                 (pathname (%pathname-directory path))
                 (string
                  (multiple-value-bind (sstr start end) (get-sstring path)
                    (multiple-value-bind (host pos2)(pathname-host-sstr sstr start end)
                      (pathname-directory-sstr sstr (or pos2 start) end host))))
                 (encoded-string
                  (let* ((sstr (the-string path))
                         (start 0)
                         (end (length sstr))
                         ;(*pathname-escape-character* *pathname-escape-character-unicode*)
                         res)
                    (multiple-value-bind (host pos2)(pathname-host-sstr sstr start end)
                      (setq res (pathname-directory-sstr sstr (or pos2 start) end host))
                      (if (7bit-ascii-p res) res
                          (make-encoded-string res (the-encoding path))))))                    
                 (t (report-bad-arg path pathname-arg-type)))))
    (if (and case (neq case :local))
      (%reverse-component-case names case)
      names)))

(defun pathname-parse-error (format-string &rest args)
  (error (make-condition 'pathname-parse-error :format-string format-string :format-arguments args))) 

(defun %directory-string-list (sstr start &optional end host)
  (declare (ignore host))
  ;This must cons up a fresh list, %expand-logical-directory rplacd's it.
  ;(when (eq host :unspecific)(setq host nil))  ;; what is that for? - not used
  (let (enc)
    (when  (encoded-stringp sstr)
      (setq enc (the-encoding sstr))
      (setq sstr (the-string sstr)))
    (if (null end)(setq end (length sstr)))
    (labels ((std-part (sstr start end)
               (let ((part (if (and (eq start 0) (eq end (length sstr)))
                             sstr 
                             (%substr sstr start end))))
                 (%std-directory-part (if (and enc (not (7bit-ascii-p part)))
                                        (make-encoded-string part enc)
                                        part))))
             (split (sstr start end)
               (unless (eql start end)
                 (if (memq (%schar sstr start) '(#\: #\;))
                   (cons :up (split sstr (%i+ start 1) end))
                   (let* ((pos (or (%path-mem ":;" sstr start end) end))
                          (part (std-part sstr start pos)))
                     (cons part
                           (unless (eq end pos)
                             (split sstr (%i+ pos 1) end))))))))
      (unless (eq start end)
        (let* ((pos (%path-mem ":;" sstr start end)))
          (when (and pos  (< pos (1- end))) ;; << gaak
            (let ((char (schar sstr pos)))
              ; this never did anything sensible but did not signal an error
              (if (or (and (eq char #\:)(%path-mem ";" sstr (1+ pos) end))
                      (and (eq char #\;)(%path-mem ":" sstr (1+ pos) end)))
                (pathname-parse-error "Illegal directory string ~s." sstr))))              
          (cond ((null pos)
                 (list :absolute (std-part sstr start end)))
                ((eq start pos)
                 (let ((rest (split sstr (%i+ pos 1) end)))
                   (cons ':relative rest)))              
                (t  (list* :absolute (std-part sstr start pos) (split sstr (%i+ pos 1) end)))))))))


;Namestring name/type parsing:
;  "a.b" ->	name = "a", type = "b"
;  "a"   ->	name = "a", type = nil
;  "a."  ->	name = "a", type = :unspecific
;  ".b"  ->	name = nil, type = "b"
;  "."   ->	name = nil, type = :unspecific
;  ""    ->	name = nil, type = nil

;A name is either NIL or a (possibly wildcarded, possibly empty) string.
;Quoted :'s are allowed at this stage, though will get an error if go to the
;filesystem.
(defun pathname-name (path &key case)
  (when (streamp path) (setq path (%path-from-stream path)))
  (when case (setq case (require-type case pathname-case-type)))
  (let ((name (typecase path
                (pathname (%pathname-name path))
                (string
                 (multiple-value-bind (sstr start end) (get-sstring path)
                   (let ((pos  (%path-mem-last ":;" sstr start end)))
                     (when pos (setq start (%i+ pos 1))))
                   (let ((newend (nth-value 1 (pathname-version-sstr sstr start end))))
                     (when newend (setq end newend))
                     (setq end (or (nth-value 1 (pathname-type-sstr sstr start end)) end))                     
                     (unless (eq start end)
                       (%std-name-component (%substr sstr start end))))))
                (encoded-string
                 (let* ((sstr (the-string path))
                        (start 0)
                        (end (length sstr))
                        ;(*pathname-escape-character* *pathname-escape-character-unicode*)
                        res)
                   (let ((pos  (%path-mem-last ":;" sstr start end)))
                     (when pos (setq start (%i+ pos 1))))
                   (let ((newend (nth-value 1 (pathname-version-sstr sstr start end))))
                     (when newend (setq end newend))
                     (setq end (or (nth-value 1 (pathname-type-sstr sstr start end)) end))                     
                     (unless (eq start end)
                       (setq res (%substr sstr start end))))
                   (when res
                     (%std-name-component (if (7bit-ascii-p res) res
                                              (make-encoded-string res (the-encoding path)))))))
                   
                (t (report-bad-arg path pathname-arg-type)))))
    (if (and case (neq case :local))
      (%reverse-component-case name case)
      name)))


(defun %std-name-component (name)
  (cond ((or (null name) (eq name :unspecific)) name)
        ((eq name :wild) "*")
        (t (%path-std-quotes name ".:;*" ".:;"))))

;A type is either NIL or a (possibly wildcarded, possibly empty) string.
;Quoted :'s are allowed at this stage, though will get an error if go to the
;filesystem.
(defun pathname-type (path &key case)
  (when (streamp path) (setq path (%path-from-stream path)))
  (when case (setq case (require-type case pathname-case-type)))
  (let ((name (typecase path
                (pathname (%pathname-type path))
                (string
                 (multiple-value-bind (sstr start end) (get-sstring path)
                   (let ((vpos (nth-value 1 (pathname-version-sstr sstr start end))))
                     (when vpos (setq end vpos)))
                   (pathname-type-sstr sstr start end)))
                (encoded-string
                 (let* ((sstr (the-string path))
                        (start 0)
                        (end (length sstr))
                        ;(*pathname-escape-character* *pathname-escape-character-unicode*)
                        res)
                   (let ((vpos (nth-value 1 (pathname-version-sstr sstr start end))))
                     (when vpos (setq end vpos)))
                   (setq res (pathname-type-sstr sstr start end))
                   (when res (if (7bit-ascii-p res) res (make-encoded-string res (the-encoding path))))))
                       
                (t (report-bad-arg path pathname-arg-type)))))
    (if (and case (neq case :local))
      (%reverse-component-case name case)
      name)))

; assumes version if any has been stripped away (i.e. is past end)
(defun pathname-type-sstr (sstr start end)
  (let ((pos (%path-mem-last ":;" sstr start end)))
    (if pos (setq start (%i+ 1 pos)))    
    (setq pos (%path-mem-last "." sstr start end))
    (when pos
      (cond ((= (%i+ 1 pos) end)  ; a lonely dot - or is it unspecific if no dot?
             (values "" (%i- end 1)))
            (t (setq start (%i+ 1 pos))
               (values (%std-type-component (%substr sstr start end))
                       (%i- start 1)))))))

(defun %std-type-component (type)
  (cond ((or (null type) (eq type :unspecific)) type)
        ((eq type :wild) "*")
        ;((encoded-stringp type) type) ;; doesn't do std-quotes
        (t (%path-std-quotes type ".:;*" ".:;"))))

#|
(defun %expand-logical-directory (directory &optional no-error)
    (let ((cadr (%cadr directory)))
      (if (and (eq (%car directory) ':absolute) cadr (listp cadr))
        (let* ((name (%cadr cadr))
               (sub (assoc name *logical-directory-alist* :test #'string-equal)))
          (unless sub
            (if no-error
              (return-from %expand-logical-directory nil)
              (error "Undefined logical directory name ~S in ~S" name directory)))
          (multiple-value-bind (sstr start end) (get-sstring (%cdr sub))
            (let* ((sub-dir (%expand-logical-directory
                             (%directory-string-list sstr start end) no-error))         ; guaranteed freshly consed
                   (cddr (%cddr directory)))
              (if sub-dir
                (nconc sub-dir cddr)
                (if cddr
                  (cons ':relative cddr))))))
        directory)))
|#


;; pile of horse pucky that aint implemented for hairy stuff
(defun %reverse-component-case (name case)
  (cond ((not (stringp name))
         (if (listp name)
           (mapcar #'(lambda (name) (%reverse-component-case name case))  name)
           name))
        ((eq case :studly) (string-studlify name))
        (t ; like %read-idiocy but non-destructive - need it be?
         (let ((which nil)
               (len (length name)))
           (dotimes (i len)
             (let ((c (%schar name i)))
               (if (alpha-char-p c)
                 (if (upper-case-p c)
                   (progn
                     (when (eq which :lower)(return-from %reverse-component-case name))
                     (setq which :upper))
                   (progn
                     (when (eq which :upper)(return-from %reverse-component-case name))
                     (setq which :lower))))))
           (case which
             (:lower (string-upcase name))
             (:upper (string-downcase name))
             (t name))))))

;;;;;;; String-with-quotes utilities
(defun %path-mem-last-quoted (chars sstr &optional (start 0) end)
  (let ((esc *pathname-escape-character*))
    (when (typep sstr 'encoded-string)
      (setq sstr (the-string sstr))
      ;(setq esc *pathname-escape-character-unicode*)
      )
    (when (not end) (setq end (length sstr)))
    (while (%i< start end)
      (when (and (%%str-member (%schar sstr (setq end (%i- end 1))) chars)
                 (%path-quoted-p sstr end start esc))
        (return-from %path-mem-last-quoted end)))))

(defun %path-mem-last (chars sstr &optional (start 0) end)
  (let ((esc *pathname-escape-character*))
    (When (typep sstr 'encoded-string)
      (setq sstr (the-string sstr))
      ;(setq esc *pathname-escape-character-unicode*)
      )
    (when (not end) (setq end (length sstr)))
    (while (%i< start end)
      (when (and (%%str-member (%schar sstr (setq end (%i- end 1))) chars)
                 (not (%path-quoted-p sstr end start esc)))
        (return-from %path-mem-last end)))))

(defun %path-mem (chars sstr &optional (start 0) end)
  (let ((esc *pathname-escape-character*))
    (when (encoded-stringp sstr)
      (setq sstr (the-string sstr))
      ;(setq esc *pathname-escape-character-unicode*)
      (when (not (7bit-ascii-p chars)) (error "chars ~s not legal here" chars)))
    (When (not end) (setq end (length sstr)))
    (let ((one-char (when (eq (length chars) 1) (%schar chars 0))))
      (while (%i< start end)
        (let ((char (%schar sstr start)))
          (when (if one-char (eq char one-char)(%%str-member char chars))
            (return-from %path-mem start))
          (when (eq char esc)
            (setq start (%i+ start 1)))
          (setq start (%i+ start 1)))))))

; these for ∂:  meaning this aint a logical host. Only legal for top level dir
 
(defun %path-unquote-one-quoted (chars sstr &optional (start 0)(end (length sstr)))
  (let ((pos (%path-mem-last-quoted chars sstr start end)))
    (when (and pos (neq pos 1))
      (cond ((or (%path-mem chars sstr start (1- pos))
                 (%path-mem-last-quoted chars sstr start (1- pos)))
             nil)
            (t (%str-cat (%substr sstr start (1- pos))(%substr sstr  pos end)))))))

(defun %path-one-quoted-p (chars sstr &optional (start 0)(end (length sstr)))
  (let ((pos (%path-mem-last-quoted chars sstr start end)))
    (when (and pos (neq pos 1))
      (not (or (%path-mem-last-quoted chars sstr start (1- pos))
               (%path-mem chars sstr start (1- pos)))))))
 




;Standardize pathname quoting, so can do EQUAL.

(defun %path-std-quotes (arg keep-quoted make-quoted)
  (when (symbolp arg)
    (error "Invalid pathname component ~S" arg))  
  (let* ((encoding (if (typep arg 'encoded-string) (the-encoding arg)))
         (str (if encoding (the-string arg) arg))
         (esc *pathname-escape-character*)
         (len (length str))
         end res-str to-filesys char)
    (if (and (or (null make-quoted) (eq 0 (length make-quoted)))
             (or (null keep-quoted) (eq 0 (length keep-quoted))))
      (setq to-filesys t))
    (multiple-value-bind (sstr start)(array-data-and-offset str)
      (setq end (+ start len))
      (let ((i start))
        (until (eq i end)
          (setq char (%schar sstr i))
          (cond ((or (%%str-member char make-quoted)
                     (and (null keep-quoted) (eq char esc)))
                 (unless res-str
                   (setq res-str (make-array len
                                             :element-type 'extended-character
                                             :adjustable t :fill-pointer i
                                             :initial-contents str)))
                 (vector-push-extend esc res-str))
                ((neq char esc) nil)
                ((eq (setq i (%i+ i 1)) end)
                 (pathname-parse-error "Malformed pathname component string ~S." str))
                ((eq (setq char (%schar sstr i)) esc)  ;; ∂∂
                 (if (not to-filesys)  ;; keep or output two deltas when from filesys or within our world
                   (when res-str (vector-push-extend esc res-str))
                   (unless res-str ;; two deltas to one delta when going to file system - i,e.  %file-system-string and %path-mac-namestring
                     (setq res-str (make-array len
                                               :element-type 'extended-character
                                               :adjustable t :fill-pointer (%i- i 1)
                                               :initial-contents str)))))                
                ((%%str-member char keep-quoted)
                 (when res-str (vector-push-extend esc res-str)))
                (t
                 (unless res-str
                   (setq res-str (make-array len
                                             :element-type 'extended-character
                                             :adjustable t :fill-pointer (%i- i 1)
                                             :initial-contents str)))))
          (when res-str (vector-push-extend char res-str))
          (setq i (%i+ i 1)))
        (ensure-simple-string (or res-str str))))))



#+PPC-target
(defun %%str-member (char string)
  (locally (declare (optimize (speed 3)(safety 0)))
    (dotimes (i (the fixnum (length string)))
      (when (eq (%schar string i) char)
        (return i)))))

; need to keep these until world is recompiled with different fcomp-standard-source

(defvar *logical-directory-alist* nil)
#|
  `(("CCL" . ":")                       ; reset in l1-boot
    ("HOME" . ":")                      ; ditto.
))

    ("L1" . "ccl;level-1:")
    ("L1F" . "ccl;L1-fasls:")
    ("LIB" . "ccl;lib:")
    ("BIN" . "ccl;bin:"))
    ("CODE" . "ccl;lib:")
    ("FASLS"   . "ccl;bin:")
    ("COMPILER" . "ccl;compiler:")
    ("EXAMPLES" . "ccl;examples:")
    ("LIBRARY" . "ccl;library:")
    ("INTERFACES" . "library;interfaces:")
    ))
|# ; why do we crash if this is nil

;; from l1-highlevel-events

(defun posix-namestring (full-path)
  (or (get-hashed-path-thing full-path new-mac-namestring-hash 'posix-namestring)
      (let* ((posix-dir-string (posix-dir-string (%pathname-directory full-path)))
             (path-name (%pathname-name full-path))
             (path-type (%pathname-type full-path))
             res)
        (if (and path-name (neq path-name :unspecific))(setq path-name (%file-system-string path-name))) ;; remove escapes
        (if (and path-type (neq path-type :unspecific))(setq path-type (%file-system-string path-type))) ;;(%path-std-quotes path-type "" "")))
        (setq res
              (cond 
               ((or path-name path-type)
                (let ((posix-name (if (and path-name (neq path-name :unspecific))(maybe-encoded-str-subst-copy path-name #\: #\/) ""))
                      (posix-type (if (and path-type (neq path-type :unspecific))
                                    (maybe-encoded-str-subst-copy path-type #\: #\/)
                                    nil)))
                  (if posix-type
                    (%str-cat-maybe-encoded posix-dir-string posix-name "." posix-type)
                    (%str-cat-maybe-encoded posix-dir-string posix-name))))                 
               (t posix-dir-string)))
        (setq res
              (if (typep res 'encoded-string)
                (convert-string (the-string res) (the-encoding res) #$kCFStringEncodingUTF8)
                (if (7bit-ascii-p res) 
                  res
                  (convert-string res #$kCFStringEncodingUnicode #$kCFStringEncodingUTF8))))
        (set-hashed-path-thing full-path new-mac-namestring-hash 'posix-namestring res) 
        res
        )))

;; does this need to copy? - not unless changed

(defun maybe-encoded-str-subst-copy (str out in)
  (let ((encoding nil)
        (orig str))
    (if (typep str 'encoded-string)(setq encoding (the-encoding str)
                                         str (the-string str)))
    (if (and encoding (neq encoding #$kcfstringencodingunicode))(error "bad encoding"))
    (if (not (%str-member in str))
      orig
      (let ((new-str (make-array (length str) :element-type (if (extended-character-p out) 'extended-character (array-element-type str)))))
        (dotimes (i (length str))
          (let ((in-char (%schar str i)))
            (if (eql in-char in)
              (setf (%schar new-str i) out)
              (setf (%schar new-str i) in-char))))
        (if nil ;encoding
          (make-encoded-string new-str encoding)
          new-str)))))

;; beware mismatch types ??
(defun %str-subst (str out in)
  (dotimes (i (length str))
    (when (eql (%schar str i) in)
      (setf (%schar str i) out)))
  str)


(defun %str-subst-copy (str out in)
  (let ((new-str (make-array (length str) :element-type (if (extended-character-p out) 'extended-character (array-element-type str)))))
    (dotimes (i (length str))
      (let ((in-char (%schar str i)))
        (if (eql in-char in)
          (setf (%schar new-str i) out)
          (setf (%schar new-str i) in-char))))
    new-str))


(defun posix-dir-string (directory)
  (or (get-hashed-path-thing directory new-mac-namestring-hash 'posix-dir-string)
      (let ((dir directory))        
        (let ((boot-dir (second (%pathname-directory (boot-directory))))
              (second-dir (second dir)) 
              res the-cdr)
          (if (string-equal second-dir boot-dir) 
            (setq res "/" the-cdr (cddr dir))
            (setq res "/Volumes/" the-cdr (cdr dir)))
          (dolist (sub the-cdr)
            (setq sub (%file-system-string sub)) ;(%path-std-quotes sub "" ""))  ;; remove escapes
            (setq res (%str-cat-maybe-encoded
                       res 
                       (maybe-encoded-str-subst-copy sub  #\: #\/) 
                       "/")))
          (set-hashed-path-thing directory new-mac-namestring-hash 'posix-dir-string res)
          res))))

;-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
; load, require, provide

(defun find-load-file (file-name)
  (let ((full-name (full-pathname file-name :no-error nil)))
    (when full-name
      (let ((file-type (pathname-type full-name)))
        (if (and file-type (neq file-type :unspecific))
          (values (probe-file full-name) file-name file-name)
          (let* ((source (merge-pathnames file-name *.lisp-pathname*))
                 (fasl   (merge-pathnames file-name *.fasl-pathname*))
                 (true-source (probe-file source))
                 (true-fasl   (probe-file fasl)))
            (cond (true-source
                   (if (and true-fasl
                            (> (file-write-date true-fasl)
                               (file-write-date true-source)))
                     (values true-fasl fasl source)
                     (values true-source source source)))
                  (true-fasl
                   (values true-fasl fasl fasl))
                  ((setq full-name (probe-file full-name))
                   (values full-name file-name file-name)))))))))



(defun compile-load (file-name &rest options &key
                               fasl-file force-compile ignore-compiler-warnings
                               &allow-other-keys)
  (declare (dynamic-extent options))
  (remf options :fasl-file)
  (remf options :force-compile)
  (remf options :ignore-compiler-warnings)
  (let* ((file (merge-pathnames file-name *.lisp-pathname*))
         (fasl (merge-pathnames (if fasl-file (merge-pathnames fasl-file *.fasl-pathname*) *.fasl-pathname*)
                                file)))
    (when (probe-file file)
      (when (or force-compile
                (not (probe-file fasl))
                (< (file-write-date fasl) (file-write-date file)))
        (multiple-value-bind (compiled ignore bad-warnings)
                             (apply #'compile-file file :output-file fasl options)
          (declare (ignore ignore))
          (unless compiled              ; skip compile to compiler error
            (return-from compile-load nil))
          (unless (or ignore-compiler-warnings (not bad-warnings))
            (restart-case
              (error "Compiling ~s produced warnings." file)
              (retry-compile ()
                     :report (lambda (s) (format s "Retry compiling ~s" file))
                     (return-from compile-load (apply #'compile-load file-name options)))
              (load-anyway ()
                     :report (lambda (s) (format s "Load ~s despite compiler warnings" fasl)))
              (skip-load ()
                     :report (lambda (s) (format s "Skip loading ~s" fasl))
                     (return-from compile-load nil)))))))
    (if (probe-file fasl)
      (restart-case
        (apply #'load fasl options)
        (retry-compile ()
               :report (lambda (s) (format s "Retry compiling ~s" file))
               (apply #'compile-load file-name options))
        (skip-load ()
               :report (lambda (s) (format s "Skip loading ~s" fasl))
               nil))
      (restart-case
        (signal-file-error $err-no-file file)
        (retry-compile ()
               :report (lambda (s) (format s "Retry compiling ~s" file))
               (apply #'compile-load file-name options))))))

(defvar *loading-external-format* nil)

(defun load (file-name &key (verbose *load-verbose*)
                       (print *load-print*)
                       (if-does-not-exist :error)
                       external-format
                       ;Franz foreign function keywords.
                       foreign-files system-libraries unreferenced-lib-names)
  "Extension: :PRINT :SOURCE means print source as well as value"
  (loop
    (restart-case
      (return (%load file-name verbose print if-does-not-exist external-format
                     foreign-files system-libraries unreferenced-lib-names))
      (retry-load ()
                  :report (lambda (stream) (format stream "Retry loading ~s" file-name)))
      (skip-load ()
                 :report (lambda (stream) (format stream "Skip loading ~s" file-name))
                 (return nil))
      (load-other ()
                  :report (lambda (stream) (format stream "Load other file instead of ~s" file-name))
                  (return
                   (let ((result (choose-file-dialog :button-string "Load")))
                     (if (consp result)(setq result (car result))) ;; ?? or load all of them?
                     (load result
                           :verbose verbose
                           :print print
                           :if-does-not-exist if-does-not-exist
                           :external-format external-format
                           :foreign-files foreign-files
                           :system-libraries system-libraries
                           :unreferenced-lib-names unreferenced-lib-names)))))))

(declaim (notinline ff-load))
(defun ff-load (&rest args)
  (declare (ignore args))
  (if t ;(osx-p) 
    (error "FF-LOAD does not work on osx")
    (progn (require "FF")
           (apply #'ff-load args))))

(defparameter *using-new-fasload* nil)

(defun %load (file-name verbose print if-does-not-exist external-format
                        foreign-files system-libraries
                        unreferenced-lib-names
                        &aux type)
  (let ((*load-pathname* file-name)
        (*load-truename* file-name)
        (*loading-external-format* external-format)
        (source-file file-name)
        constructed-source-file)
    (declare (special *load-pathname* *load-truename*))
    (unless (streamp file-name)
      (multiple-value-setq (*load-truename* *load-pathname* source-file)
        (find-load-file (merge-pathnames file-name)))
      (when (not *load-truename*)
        (return-from %load (if if-does-not-exist
                             (signal-file-error $err-no-file file-name))))
      (setq file-name *load-truename*)
      (setq type (mac-file-type file-name))
      (when (and (or foreign-files
                     system-libraries
                     unreferenced-lib-names
                     (eq type :|OBJ |))
                 (fboundp 'ff-load))
        (when t #|(osx-p)|# (error "Foreign-files etal arguments to Load not supported on OSX."))
        (when (equal file-name "") (setq file-name nil))
        (return-from %load
          (ff-load (if (listp file-name)
                     (append file-name foreign-files)
                     (cons file-name foreign-files))
                   :libraries system-libraries
                   :library-entry-names unreferenced-lib-names))))
    (when (setq foreign-files (if foreign-files :foreign-files
                                  (if system-libraries :system-libraries
                                      (if unreferenced-lib-names :unreferenced-lib-names))))
      (error "Inappropriate options in ~S ." foreign-files))
    (let* ((*package* *package*)
           (*readtable* *readtable*)
           (*loading-files* (cons file-name (specialv *loading-files*)))
           (*loading-file-source-file* (or ;(probe-file source-file) ;; 68K boot prob?
                                           *load-truename*))) ;reset by fasload to logical name stored in the file? ?? was file-name
      (declare (special *loading-files* *loading-file-source-file*))
      (unwind-protect
        (progn
          (when verbose
            (format t "~&;Loading ~S..." *load-pathname*)
            (force-output))
          (cond ((or (eq type #-ppc-target :FASL #+ppc-target :PFSL) 
                     (and (or (eq type :????)
                              (eq type #.(ff-long-to-ostype 0)))
                          (equalp (pathname-type file-name) (pathname-type *.PFSL-PATHNAME*))))
                 (flet ((attempt-load (file-name)
                          (multiple-value-bind (winp err) (%fasload (if *using-new-fasload* file-name (mac-namestring file-name)))
                            (if (not winp) 
                              (%err-disp err)))))
                   (let ((*fasload-print* print))
                     (declare (special *fasload-print*))
                     (setq constructed-source-file (make-pathname :defaults file-name :type (pathname-type *.lisp-pathname*)))
                     (when (equalp source-file *load-truename*)
                       (when (probe-file constructed-source-file)
                         (setq source-file constructed-source-file)))
                     (if (and source-file
                              (not (equalp source-file file-name))
                              (probe-file source-file))
                       ;;really need restart-case-if instead of duplicating code below
                       (restart-case
                         (attempt-load file-name)
                         #+ignore
                         (load-other () :report (lambda (x) (format s "load other file"))
                                     (return-from
                                       %load
                                       (%load (choose-file-dialog) verbose print if-does-not-exist external-format
                                              foreign-files system-libraries unreferenced-lib-names)))
                         (load-source 
                          ()
                          :report (lambda (s) 
                                    (format s "Attempt to load ~s instead of ~s" 
                                            source-file *load-pathname*))
                          (return-from 
                            %load
                            (%load source-file verbose print if-does-not-exist external-format
                                   foreign-files system-libraries unreferenced-lib-names))))
                       ;;duplicated code
                       (attempt-load file-name)))))
                ((or (eq type :TEXT)
                     (eq type :|utxt|)
                     (eq type #.(ff-long-to-ostype 0))
                     (eq type :????))
                 (if t ;(eq type :text)
                   (progn
                     (when (and (fboundp 'utf-something-p)(fboundp 'fsopen))  ;; open-internal does this too if external-format not provided
                       (let ((utf-p (utf-something-p file-name)))  ;; boot issues
                         (if (eq utf-p :utf-16)
                           (setq external-format :|utxt|)
                           (if (eq utf-p :utf-8)
                             (setq external-format :utf8)))))
                     (with-open-file (stream file-name :element-type (if (eq external-format :|utxt|) 'extended-character 'base-character) :external-format external-format)
                       ;; could make open do this ?
                       (cond ((or (eq type :|utxt|)(eq external-format :|utxt|))  ;; assume has bom and skip it
                              (let ((first-char (stream-tyi stream)))
                                (if (neq (char-code first-char) #xFEFF)  ;; well if not BOM don't skip it - probably silly precaution
                                  (stream-untyi stream first-char))))                             
                             ((eq external-format :utf8)
                              (dotimes (i 3)(%ftyi-sub (slot-value stream 'fblock)))))
                       (load-from-stream stream print)))
                   (let ((*linefeed-equals-newline* (if *do-unix-hack* t *linefeed-equals-newline*)))
                     (with-open-file (stream file-name :element-type 'base-character :external-format external-format)
                       
                       (load-from-stream stream print)))))
                     
                ((null type)  ;; what??
                 (load-from-stream file-name print))
                (t (signal-file-error $xnotfaslortext file-name)))))))
  file-name)

(defun load-from-stream (stream print &aux (eof-val (list ())) val)
  (with-compilation-unit (:override nil) ; try this for included files
    (let ((env (new-lexical-environment (new-definition-environment 'eval))))
      (%rplacd (defenv.type (lexenv.parent-env env)) *outstanding-deferred-warnings*)
      (while (neq eof-val (setq val (read stream nil eof-val)))
        (when (eq print :source) (format t "~&Source: ~S~%" val))
        (setq val (cheap-eval-in-environment val env))
        (when print
          (format t "~&~A~S~%" (if (eq print :source) "Value: " "") val))))))

(defun include (filename)  
  (load
   (if (null *loading-files*)
     filename     
     (merge-pathnames filename (directory-namestring (car *loading-files*))))
   :external-format *loading-external-format*))

(%fhave '%include #'include)

(defun provide (module &aux (str (string module)))
  (when (null module) (report-bad-arg module '(not (member nil))))
  (setq *modules* (adjoin str *modules* :test #'string-equal))
  (let* ((cell (assoc str *module-file-alist* :test #'string-equal))
         (path *loading-file-source-file*))
    (if cell
      (setf (cdr cell) path)
      (push (cons str path) *module-file-alist*)))
  str)

(defparameter *loading-modules* () "Internal. Prevents circularity")

(defun require (module &optional pathname &aux (str (string module)))
  (when (null module) (report-bad-arg module '(not null)))  
  (when (and (not (member str *modules* :test #'string-equal))
             (not (member str *loading-modules* :test #'string-equal))
             (or pathname
                 (setq pathname (find-module-pathnames str))
                 (progn
                   (cerror "If ~S still hasn't been provided,
you will be asked to choose a file."
                           "The module ~S was required while loading ~S.
No file could be found for that module."
                           str *loading-file-source-file*)
                   (unless (member str *modules* :test #'string-equal)
                     (catch-cancel
                       (let ((result (choose-file-dialog :button-string "Load"
                                      :mac-file-type '(#-ppc-target :fasl
                                                       #+ppc-target :pfsl
                                                       :text))))
                         (setq pathname (if (consp result)(car result) result)))))
                   pathname)))
    (let ((*loading-modules* (cons str *loading-modules*)))
      (if (consp pathname)
        (dolist (path pathname) (load path))
        (load pathname)))
    (setq *modules* (adjoin str *modules* :test #'string-equal)))
  str)

(defun find-module-pathnames (module)
  "Returns the file or list of files making up the module"
  (or (cdr (assoc module *module-file-alist* :test #'string-equal))
      (let ((mod-path (make-pathname :name module :defaults nil)))
        (dolist (path-cand *module-search-path* nil)
          (multiple-value-bind (truepath path)(find-load-file (merge-pathnames mod-path path-cand))
            (when truepath (return path)))))))

;; slight change to version in level-0;ppc;ppc-pred
(defun hairy-equal (x y)
  (declare (optimize (speed 3)))
  ; X and Y are not EQL, and are both of tag ppc::fulltag-misc.
  (let* ((x-type (ppc-typecode x))
                 (y-type (ppc-typecode y)))
            (declare (fixnum x-type y-type))
            (if (and (>= x-type ppc::subtag-vectorH)
                     (>= y-type ppc::subtag-vectorH))
              (let* ((x-simple (if (= x-type ppc::subtag-vectorH)
                                 (ldb ppc::arrayH.flags-cell-subtag-byte 
                                      (the fixnum (%svref x ppc::arrayH.flags-cell)))
                                 x-type))
                     (y-simple (if (= y-type ppc::subtag-vectorH)
                                 (ldb ppc::arrayH.flags-cell-subtag-byte 
                                      (the fixnum (%svref y ppc::arrayH.flags-cell)))
                                 y-type)))
                (declare (fixnum x-simple y-simple))
                (if (or (= x-simple ppc::subtag-simple-base-string)
                        (= x-simple ppc::subtag-simple-general-string))
                  (if (or (= y-simple ppc::subtag-simple-base-string)
                          (= y-simple ppc::subtag-simple-general-string))
                    (locally
                      (declare (optimize (speed 3) (safety 0)))
                      (let* ((x-len (if (= x-type ppc::subtag-vectorH) 
                                      (%svref x ppc::vectorH.logsize-cell)
                                      (uvsize x)))
                             (x-pos 0)
                             (y-len (if (= y-type ppc::subtag-vectorH) 
                                      (%svref y ppc::vectorH.logsize-cell)
                                      (uvsize y)))
                             (y-pos 0))
                        (declare (fixnum x-len x-pos y-len y-pos))
                        (when (= x-type ppc::subtag-vectorH)
                          (multiple-value-setq (x x-pos) (array-data-and-offset x)))
                        (when (= y-type ppc::subtag-vectorH)
                          (multiple-value-setq (y y-pos) (array-data-and-offset y)))
                        (%simple-string= x y x-pos y-pos (the fixnum (+ x-pos x-len)) (the fixnum (+ y-pos y-len))))))
                  ; Bit-vector case or fail.
                  (and (= x-simple ppc::subtag-bit-vector)
                       (= y-simple ppc::subtag-bit-vector)
                       (locally
                         (declare (optimize (speed 3) (safety 0)))
                         (let* ((x-len (if (= x-type ppc::subtag-vectorH) 
                                         (%svref x ppc::vectorH.logsize-cell)
                                         (uvsize x)))
                                (x-pos 0)
                                (y-len (if (= y-type ppc::subtag-vectorH) 
                                         (%svref y ppc::vectorH.logsize-cell)
                                         (uvsize y)))
                                (y-pos 0))
                           (declare (fixnum x-len x-pos y-len y-pos))
                           (when (= x-len y-len)
                             (when (= x-type ppc::subtag-vectorH)
                               (multiple-value-setq (x x-pos) (array-data-and-offset x)))
                             (when (= y-type ppc::subtag-vectorH)
                               (multiple-value-setq (y y-pos) (array-data-and-offset y)))
                             (do* ((i 0 (1+ i)))
                                  ((= i x-len) t)
                               (declare (fixnum i))
                               (unless (= (the bit (sbit x x-pos)) (the bit (sbit y y-pos)))
                                 (return))
                               (incf x-pos)
                               (incf y-pos))))))))
              (if (= x-type y-type)
                (if (= x-type ppc::subtag-istruct)
                  (and (let* ((structname (%svref x 0)))
                         (and (eq structname (%svref y 0))
                              (or (eq structname 'pathname)
                                  (eq structname 'logical-pathname)
                                  (eq structname 'encoded-string))))
                       (locally
                         (declare (optimize (speed 3) (safety 0)))
                         (let* ((x-size (uvsize x)))
                           (declare (fixnum x-size))
                           (if (= x-size (the fixnum (uvsize y)))
                             (do* ((i 1 (1+ i)))
                                  ((= i x-size) t)
                               (declare (fixnum i))
                               (unless (equalp (%svref x i) (%svref y i))
                                 (return))))))))))))

;; ------------------  bunch of stuff moved from pathnames.lisp

(defmethod string-length ((x encoded-string))
  (length (the-string x)))
(defmethod string-length ((x t))
  (length x))
(defmethod string-schar ((x encoded-string) n)
  (schar (the-string x) n))
(defmethod string-schar ((x t) n)
  (schar x n))

(defmethod string-string= ((x encoded-string) (y encoded-string))
  (let ((enc1 (the-encoding x))
        (enc2 (the-encoding y)))
    (if (eql enc1 enc2)
      (string= (the-string x)(the-string y))
      (let ((str1 (the-string x))
            (str2 (the-string y)))
        (setq str1 (convert-string str1 enc1 #$kcfstringencodingunicode))
        (setq str2 (convert-string str2 enc2 #$kcfstringencodingunicode))
        (string= str1 str2)))))                  

(defmethod string-string= ((x encoded-string) y)
  (let ((enc (the-encoding x))
        (x (the-string x)))
    (if (neq enc #$kcfStringencodingunicode)
      (setq x (convert-string x enc #$kcfstringencodingunicode)))
    (string= x y)))

(defmethod string-string= (x (y encoded-string))
  (string-string= y x))

(defmethod string-string= (x y)
  (string= x y))

(defun does-pattern-match (pattern thing)
  (let* ( ;(encoded-p nil)
         (pat-str (if (encoded-stringp pattern)
                    (let ((enc (the-encoding pattern)))
                      (if (neq enc #$kcfstringencodingunicode)
                        (convert-string (the-string pattern) enc #$kcfstringencodingunicode)
                        (the-string pattern)))
                    pattern))
         (thing-str (if (encoded-stringp thing)
                    (let ((enc (the-encoding thing)))
                      (if (neq enc #$kcfstringencodingunicode)
                        (convert-string (the-string thing) enc #$kcfstringencodingunicode)
                        (the-string thing)))
                    thing))
         (esc (char-code *pathname-escape-character*))) ;(if encoded-p *pathname-escape-character-unicode* *pathname-escape-character*))))
    (does-pattern-match-sub pat-str thing-str 0 0 (length pat-str) (length thing-str) esc)))

;; like path-pstr-sub - also much like path-str-sub
(defun does-pattern-match-sub (pattern thing p-start s-start p-end s-end esc)
  (declare (fixnum p-start s-start p-end s-end))
  (declare (optimize (speed 3)(safety 0)))
  ;(when (or (>= p-start p-end)(> s-start s-end)) (error "a"))
  ;(print (list p-start p-end s-start s-end))
  (let ((*pathname-escape-character* (code-char esc)) ;; tell %path-mem what we are using
        (p (%scharcode pattern p-start)))
    (cond 
     ((eq p (char-code #\*))
      ; starts with a * find what we looking for unless * is last in which case done
      (loop ; lots of *'s same as one
        (when (eq (%i+ 1 p-start)  p-end)
          (return-from does-pattern-match-sub t))
        (if (or (eq (%schar pattern (%i+ 1 p-start)) #\*)
                (eq (%schar pattern (%i+ 1 p-start)) #\.))
          (setq p-start (1+ p-start))
          (return)))
      (let* ((next* (%path-mem "*" pattern (%i+ 1 p-start)))
             (len (- (or next* p-end) (%i+ 1 p-start)))) 
        
        (loop
          (when (> (+ s-start len) s-end)(return nil))
          (let ((res (find-thing-pattern pattern thing (%i+ 1 p-start) s-start (or next* p-end) s-end esc))) 
            (if (null res)
              (return nil)
              (if (null next*)
                (if (eq res s-end)
                  (return t))                  
                (return (does-pattern-match-sub pattern thing next* (+ s-start len) p-end s-end esc)))))
          (setq s-start (1+ s-start)))))
     (t (when (or (eq p esc))
          (setq p-start (1+ p-start))
          (setq p (%scharcode pattern p-start)))
        (let* ((next* (%path-mem "*" pattern (if (eq p (char-code #\*))(%i+ 1 p-start) p-start)))
               (this-s-end (if next* (+ s-start (- next* p-start)) s-end)))
          (if (> this-s-end s-end)
            nil
            (if  (path-thing-match-p pattern thing p-start s-start (or next* p-end) this-s-end esc)
              (if (null next*)
                t                  
                (does-pattern-match-sub pattern thing next* this-s-end p-end s-end esc)))))))))

;; like find-pstr-pattern or find-str-pattern
(defun find-thing-pattern (pattern thing p-start s-start p-end s-end esc)
  (declare (fixnum p-start s-start p-end s-end))
  (declare (optimize (speed 3)(safety 0)))
  ;(when (or (>= p-start p-end)(>= s-start s-end)) (error "a"))
  (let* ((is-stringp (stringp thing)) ;; may be a string or macptr to an hfsunistr255
         (first-p (%scharcode pattern p-start)))
    (when (eq  first-p esc)
      (setq first-p (%scharcode pattern (setq p-start (1+ p-start)))))
    (do* ((i s-start (1+ i))
          (last-i (%i- s-end (%i- p-end p-start))))
         ((> i last-i) nil)
      (declare (fixnum i))
      (let ((s (if is-stringp (%scharcode thing i)(%get-unsigned-word thing (%i+ 2 i i)))))        
        (when (or (eq first-p s)
                  (and (eq first-p (%ilogxor s 32))  ;; cheap case independent crap
                       (progn (setq s (%ilogior s 32))
                                (%i>= s (char-code #\a)))
                         (%i<= s (char-code #\z))))
          (do* ((j (1+ i) (1+ j))
                (k (1+ p-start)(1+ k)))
               ((>= k p-end) (progn (return-from find-thing-pattern j)))
            (declare (fixnum j k))
            (let* ((p (%scharcode pattern k))
                   (s (if is-stringp (%scharcode thing j) (%get-unsigned-word thing (%i+ 2 j j)))))              
              (when (eq  p esc)
                (setq p (%scharcode pattern (setq k (1+ k)))))
              (when (not (or (eq p s)
                             (and (eq (%ilogxor p 32) s)
                                  (progn (setq p (%ilogior p 32))
                                         (%i>= p (char-code #\a)))
                                  (%i<= p (char-code #\z)))))
                (return)))))))))

;; like path-pstr-match-p and path-str-match-p - oh cripes
(defun path-thing-match-p (pattern thing p-start s-start p-end s-end esc)
  (declare (fixnum p-start s-start p-end s-end))
  (declare (optimize (speed 3)(safety 0)))
  ;; does pattern match pstr between p-start p-end
  ;(when (or (>= p-start p-end)(>= s-start s-end)) (error "a"))
  (let ((is-stringp (stringp thing)))
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
        (let ((s (if is-stringp (%scharcode thing s-start)(%get-unsigned-word thing (%i+ 2 s-start s-start)))))          
          (when (not (or (eq p s)
                         (and (eq (%ilogxor p 32) s)  ;; cheap case independent crap - also wrong
                              (progn (setq p (%ilogior p 32))
                                     (%i>= p (char-code #\a)))
                              (%i<= p (char-code #\z)))))
            (return nil))
          (setq p-start (1+ p-start))
          (setq s-start (1+ s-start)))))))

(defun set-interfaces-feature ()
  (if (probe-file "ccl:interfaces;ABActions.lisp")  ;; something present in new, absent in old
    (pushnew :interfaces-3 *features*)
    (setq *features* (remove :interfaces-3 *features*))))

(pushnew 'set-interfaces-feature *lisp-startup-functions*)





#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
