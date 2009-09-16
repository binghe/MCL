;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: compile-ccl.lisp,v $
;;  Revision 1.8  2006/02/04 04:22:01  alice
;;  ;;; lose l1-traps
;;
;;  Revision 1.7  2004/12/20 22:20:47  alice
;;  ;; add two new files
;;
;;  Revision 1.6  2003/12/08 08:14:32  gtbyers
;;  Add L1-CLOS-BOOT to *ppc-level-1-modules*.
;;
;;  Revision 1.5  2003/12/01 17:56:04  gtbyers
;;  recover pre-MOP changes
;;
;;  Revision 1.3  2002/11/22 10:17:44  gtbyers
;;  Don't try compiling INTERFACES or HELP-MANAGER when #+CARBON-COMPAT
;;
;;  28 7/18/96 akh  add the 4 new files
;;  25 5/20/96 akh  number-macros and number-case-macro
;;  24 4/24/96 akh  ppc-aux-modules get save-application-dialog and hide-listener
;;  21 2/19/96 akh  reinstate eval and step for ppc
;;  20 2/8/96  akh  take out x something from ppc-xcompile-ccl
;;  18 2/6/96  akh  ppc-xcompile-ccl - put back the xthings
;;  15 1/28/96 akh  ppc-xcompile-ccl does more
;;  11 12/22/95 gb  More jumbling for more compiling.
;;  9 12/12/95 akh  some jumbled up stuff for ppc compiling
;;  6 12/1/95  akh  add ppc-xcompile-ccl and ppc-load-ccl (need work)
;;  2 10/13/95 bill ccl3.0x25
;;  5 2/17/95  akh  add mac-file-io
;;  4 2/15/95  slh  added boyer-moore
;;  (do not edit before this line!!)

; Copyright 1986-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;(in-package :ccl)

; Modification History
;; lose logical-pathname-translations "ccl" - the one in l1-pathnames should suffice
;; ----- 5.2b5
;; lose l1-traps
;; add two new files
;; --- 5.1 final
; lose ff if carbon
; lose help-manager if carbon
; ------ 4.4b5
; add ansi-make-load-form
; ------ 4.4b3
; 03/03/99 akh add nav-services (PPC only) and color-dialog-items-os8-5 (both)
; 04/23/97 bill  l1-boot => l1-boot-1
;                Add l1-cl-package
; 04/16/97 bill  add l1-boot-2 & l1-boot-3
; -------------  4.1f1
; 03/06/97 gb    move ppc-init-ccl to *ppc-aux-modules*, so (compile-ccl t) won't
;                try to require-update it.
; -------------  4.0
; 08/28/96 bill  add mcl-extensions to *code-modules* and *ppc-code-modules*
; -------------  4.0b1
; 08/01/96 gb    less ff zeal.
; akh add fred-help, edit-definition, list-definitions
; 07/17/96 bill  add search-files to *code-modules* & *ppc-code-modules*
; 07/11/96 bill  add font-menus to *code-modules* & *ppc-code-modules*
; 07/02/96 slh   added icon-dialog-item, reordered (new pfsl format caused problems)
;                use ff-source for PPC; appgen-defs, appgen-misc
; -------------  MCL-PPC 3.9
; 04/23/96 akh   add patchenv save-application-dialog build-application to *ppc-aux-modules*
; 03/28/96 bill  add ff-call-68k to *ppc-env-modules*
; 03/07/96 bill  add loop to *aux-modules* and *ppc-aux-modules*
; 02/07/96 bill  autoloading version of xload-level-0
; 01/19/96 bill  ppc-update-modules, ppc-require-update-modules, ppc-compile-ccl,
;                *ppc-env-modules*, *ppc-other-lib-modules*.
;                All the old names do the new thing on the PPC.
; 01/24/96 gb    conditionalize out some non-ppc things that I keep calling.
; 01/19/96 gb    ppc-compile-ccl, ppc-update-modules.
; 01/03/96 gb    edit-callers
; 01/05/96 bill  apropos returns to *ppc-lib-modules*.
;                compile-ccl updates *68k-compiler-modules*.
; 12/27/95 gb    more jumbled.
; 12/14/95 gb    Of course, we aren't necessarily compiling on a PPC and
;                won't likely be until we use *.pfsl-pathname* when cross-
;                compiling.
; 12/14/95 slh   use *.fasl-pathname*, it's defined and correct for PPC
; 12/08/95 bill  ppc-trap-support
; 11/14/95 bill  ppc-callback-support, ppc-stack-groups,
;                integrate "xcompile-level-1.lisp"
; 11/13/95 gb    split l1-readloop into l1-readloop, l1-reader,
;                  l1-error-system, l1-error-signal.
; 10/13/95 gb    add xsym to *ppc-compiler-modules*.
; 10/12/95 bill  add version
; 10/11/95 bill  add *ppc-compiler-modules*
;  6/07/95 slh   new-file-dialogs
;  5/12/95 slh   new-traps
;  4/26/95 slh   old-file-dialogs
;  4/14/95 slh   added boot-init save make-functions-resident
;  4/11/95 slh   build-application module
;  4/06/95 slh   doc-window module
;  4/05/95 slh   backtrace is not optional, backtrace-lds is
;  3/30/95 slh   merge in base-app changes
;                added backtrace-lds module
;--------------  3.0d18
; 2/15/95 slh  added boyer-moore to lib
;------------- 3.0d17
;12/26/94 alice lets not load scrolling-fred-view twice
;08/18/93 bill add script-manager
;07/14/93 bill skip-copy restart in merge-ccl-update
;------------- 3.0d12
;07/13/93 alice scrolling-fred-dialog-item => scrolling-fred-view
;06/02/93 bill time-delta arg to merge-ccl-update
;------------- 2.1d6
;05/04/93 bill start-file keyword to merge-ccl-update
;04/14/93 bill fred-menu is no more. catch-cancel around eval in merge-ccl-update.
;04/13/93 bill yes-mode in merge-ccl-update. require-update-modules & xcompile-ccl
;              reverted.
;04/07/93 bill merge-ccl-update now just updates the write date instead of copying
;              when two files compare as identical and copy-identical-files is true.
;------------- 2.1d5
;03/??/93 alice move add some modules for new-fred-window
;02/23/93 bill "~&" added to one of the format strings in merge-ccl-update.
;12/10/92 bill merge-ccl-update: abort restart around the eval, copy-identical-files keyword arg
;12/05/92 bill speed up same-file-write-date-and-length-p
;08/10/92 bill add resident-interfaces to *other-lib-modules*
;07/09/92 bill add patchenv to *aux-modules*
;------------- 2.0
; 01/07/92 gb  don't require RECORDS.
;------------- 2.0b4
;11/13/91 bill delete-ccl-system-source-fasls handles a null fasl file.
;              Add INTERFACES to *aux-modules*
;11/07/91 bill remove INTERFACES: users will have to load this themselves
;08/26/91 bill move INTERFACES to *code-modules*
;08/21/91 bill add INTERFACES
;07/05/91 bill add records & help-manager to *aux-modules*
;05/29/91 bill delete-ccl-system-source-fasls
;------------- 2.0b2
;05/16/91 bill process *eval-queue* while waiting for compare to be over in merge-ccl-update
;05/07/91 bill little pathname change in merge-ccl-update.
;04/05/91 bill merge-ccl-update needed a translate-logical-pathname, also
;              back-translate-pathname for printing.
;02/27/91 bill add method-combination
;02/15/91 bill add l1-dcode
;02/07/91 alice l1-pathnames, ccl; => ccl:
;---- 2.0b1
;02/04/91 bill mac-namestring -> namestring to preserve escapes.
;01/22/91 bill add merge-ccl-update
;01/18/91 bill no more distrib-lap
;01/11/91 bill add distrib-lap, lisp-package
;01/09/91 bill add ff & distrib-inits to *aux-modules*
;12/26/90 joe  added deftrap and simple-db to *env-modules* in preparation for converting
;              lisp to the new trap interface.
;12/8/90  joe  add l1-highlevel-events
;11/21/90 gb   zap aplink*, meter.
;09/17/90 bill added inspector, inspector-objects, deftrap, simple-db
;              Removed inspect
;09/07/90 bill Moved defstruct into *env-modules*: mactypes uses it.
;              eliminated *load-modules*
;08/23/90 joe added *load-modules* - independent module load variable
;08/08/90 gb  *aux-modules*.
;07/??/90 (joe) setf before records.
;05/27/90 gb  Added encapsulate.
;04/30/90 gb  nx8 -> nx.
;2/14/90 gz   Added aplink-macros, aplink, aplink-dump.
;01/03/89 gz  Added edhardcopy to bccl-modules.
;12/29/89 gz  added disasm.  Added trap-support to bccl-modules.
;01/05/89 bill Added windoids.
;12/29/89 bill Added views.
;12/27/89 gz  rename disasm -> disassemble.  EdHardcopy rides again.
;12/6/89 bill Add l1-sort.  Remove clos (moved into l1-clos).
;11/20/89 gz   Reorder *env-modules* slightly (fredenv needs lap).
;13-Nov-89 Mly Bind *package*
;10/4/89  gz   no more l1-macros.
;09/27/89 gb   comment-out eval & step for time being.
;09/15/89 bill Remove clos-l1-streams & clos-l1-windows.  Time to boot in CLOS
;09/14/89 bill clos-l1-windows back to *level-1-modules* where it belongs
;              Add clos-l1-streams ti *level-1-modules*
;09/09/89 bill Moved setf to *env-modules*. dialogs needs it for its setf methods.
;09/08/89 bill Add clos-l1-windows to *env-modules*.  This is temporary.
;              l1-windows will be replaced by clos-l1-windows as soon as I convert
;              Fred to CLOS.  There are some bootstrapping problems here, I think.
;08/24/89 gb Just say no to hardcopy, yes to chars.
;            add nx2a.
;18-apr-89 as color
;03/23/89 gz split off l1-utils, l1-boot, l1-init, l1-numbers.
;03/10/89 gz l1-clos.
; 03/02/89 gb  l1-sysio, l1-symhash.
;12/30/88 gz l1-edbuf.  No more bufstream.  added xcompile-ccl.
;11/26/88 gz New display code, no more fred-execute.
;11/25/88 gz no more record-source.
;11/16/88 gz No more edwin-utils
;9/11/88 gz added meter to other-lib-modules.
;8/17/88 gz added l1-files. hash, defstruct -> lib.
;8/11/88 gz new scheme.
;8/2/88  gb require lap, lapmacros.
;7/30/88 gz Lisp-8
;5/3/88 jaj new for ccl

;This file will load into a bare level-1 (no level-2 or nuthin').

(declaim (special *level-1-modules* *compiler-modules* *env-modules*
                    *other-lib-modules* *lib-modules* *code-modules* *load-modules*
            *ccl-system*  *aux-modules*
            *68k-compiler-modules*
            *lds-modules*
            *ppc-compiler-modules*
            *ppc-level-1-modules*
            *ppc-env-modules*
            *ppc-other-lib-modules*
            *ppc-lib-modules*
            *ppc-code-modules*
            *ppc-aux-modules*
            *ppc-xload-modules*
            *ppc-xdev-modules*))

(require 'systems)

(setq *level-1-modules*
      '(level-1
        ;level-1-test ; for testing
        #|version|#
        l1-cl-package
        l1-boot-1 l1-boot-2 l1-boot-3
        l1-utils l1-init l1-symhash l1-numbers l1-aprims ppc-callback-support
	  l1-sort l1-dcode l1-clos-boot l1-clos
        l1-streams l1-files l1-io l1-menus
        l1-windows l1-edbuf l1-edcmd
        script-manager l1-edfrec l1-edwin
        l1-unicode-to-mac l1-tec
        scroll-bar-dialog-items scrolling-fred-view new-fred-window
        l1-events ppc-trap-support l1-highlevel-events l1-format l1-readloop l1-reader
        l1-initmenus l1-sysio l1-pathnames
        l1-listener
        l1-boot-lds #|l1-base-app|# l1-initmenus-lds l1-ed-lds l1-readloop-lds
        l1-stack-groups ppc-stack-groups l1-processes
        l1-typesys sysutils l1-error-system
        l1-error-signal
        ;;#+interfaces-2 l1-traps
        ))

(setq *compiler-modules*
      '(nx optimizers))

(setq *68k-compiler-modules* '(nx2))

;
(setq *ppc-compiler-modules*
      '(dll-node
        ppc-arch
        ppcenv
        vreg
        ppc-asm
        vinsn
        ppc-subprims
        ppc-vinsns
        ppc-reg
        ppc-lap
        ppc2
        ppc-optimizers
))

;(setq *68k-xload-modules* '(xfasload))

; Needed to cross-dump a PPC image
(setq *ppc-xload-modules* '(xppcfasload pef-file xsym))

(unless (fboundp 'xload-level-0)
  (%fhave 'xload-level-0
          #'(lambda (&rest rest)
              (require-modules *ppc-xload-modules*)
              (apply 'xload-level-0 rest))))

(unless (fboundp 'xload-level-0-carbon)
  (%fhave 'xload-level-0-carbon
          #'(lambda (&rest rest)
              (require-modules *ppc-xload-modules*)
              (apply 'xload-level-0-carbon rest))))



; Handy for cross-development
(setq *ppc-xdev-modules* '(ppc2 ppc-lapmacros ppc-disassemble nxenv ))

(setq *env-modules*
      '(hash
        backquote
        lispequ
        sysequ
        ;toolequ
        level-2
        trap-support
        lap
        lapmacros
        fredenv
        defstruct-macros 
        lists chars
        setf
        defstruct defstruct-lds
        mactypes
        simple-db
        deftrap
        defrecord
        #|records|#
        dialogs color
        nfcomp
        #|aplink-macros|#
        subprims8
        views windoids))

(setq *other-lib-modules*
      '(fred-misc streams pathnames
        backtrace
        edhardcopy
        sanetraps
        apropos
        numbers dumplisp
        disasm
        disassemble
        resident-interfaces mac-file-io boyer-moore
        #|meter aplink-dump aplink|#))

(setq *lib-modules*
      (append *env-modules* *other-lib-modules*))

(setq *code-modules*
      '(encapsulate
        #+interfaces-2 new-traps        ; after encapsulate
        read
        misc doc-window
        arrays-fry sequences sort method-combination
        case-error
        pprint
        format time
        print-db
        eval
        fred-additions arglist
        pop-up-menu
        #|scroll-bar-dialog-items|#
        ccl-menus ccl-menus-lds font-menus mcl-extensions search-files
        inspector
        inspector-objects
        apropos-dialog
        step
        step-window
        #|scrolling-fred-view|#
        edit-callers
        backtrace-lds
        ccl-export-syms
        color-dialog-items-os8-5
        ))

; Not part of system, but need to be compiled to load it and/or save image/application.
(setq *aux-modules* '(systems compile-ccl ff distrib-inits lisp-package
                      resources #-carbon-compat help-manager #-carbon-compat interfaces #|patchenv|#
                      save-application-dialog build-application
                      boot-init save make-functions-resident ; resident-functions
                      #|old-file-dialogs|# #-carbon-compat new-file-dialogs loop))

; tools
;  debugging (backtrace-lds)
;  environment (apropos, boyer-moore, etc.)
; compile-time (backquote, subprims, etc.)
; low-level (sanetraps, etc.)
; optional (pprint, eval, windoids)


(defun find-module (module &aux data fasl sources)
  (if (setq data (assoc module *ccl-system*))
    (progn
      (setq fasl (cadr data) sources (caddr data))      
      (setq fasl (merge-pathnames *.fasl-pathname* fasl))
      (values fasl (if (listp sources) sources (list sources))))
    (error "Module ~S not defined" module)))

(defun require-module (module force-load)
  (multiple-value-bind (fasl source) (find-module module)
      (setq source (car source))
      (if (if fasl (probe-file fasl))
        (if force-load
          (progn
            (load fasl)
            (provide module))
          (require module fasl))
        (if (probe-file source)
          (progn
            (if fasl (format t "~&Can't find ~S so requiring ~S instead"
                             fasl source))
            (if force-load
              (progn
                (load source)
                (provide module))
              (require module source)))
          (error "Can't find ~S or ~S" fasl source)))))

(defun require-modules (modules &optional force-load)
  (if (not (listp modules)) (setq modules (list modules)))
  (let ((*package* (find-package :ccl)))
    (dolist (m (if (listp modules) modules (list modules)) t)
      (require-module m force-load))))

(defun needs-compile-p (fasl sources force-compile)
  (if fasl
    (if (eq force-compile t) t
        (if (not (probe-file fasl)) t
            (let ((fasldate (file-write-date fasl)))
              (if (if (integerp force-compile) (> force-compile fasldate)) t
                  (tagbody loop
                    (if (null sources)
                      (return-from needs-compile-p nil))
                    (if (> (file-write-date (car sources)) fasldate)
                      (return-from needs-compile-p t))
                    (setq sources (cdr sources))
                    (go loop))))))))

;compile if needed.
(defun compile-modules (modules &optional force-compile)
  (if (not (listp modules)) (setq modules (list modules)))
  (let ((*package* (find-package :ccl)))
   (tagbody loop
    (if (null modules) (return-from compile-modules t))
    (multiple-value-bind (fasl sources) (find-module (car modules))
      (if (needs-compile-p fasl sources force-compile)
        (progn
          (require'nfcomp)
          (compile-file (car sources) :output-file fasl :verbose t))))
    (setq modules (cdr modules))
    (go loop))))

;compile if needed, load if recompiled.
(defun update-modules (modules &optional force-compile)
  (if (not (listp modules)) (setq modules (list modules)))
  (let ((*package* (find-package :ccl)))
   (tagbody loop
    (if (null modules) (return-from update-modules t))
    (multiple-value-bind (fasl sources) (find-module (car modules))
      (if (needs-compile-p fasl sources force-compile)
        (progn
          (require'nfcomp)
          (let* ((*warn-if-redefine* nil))
            (compile-file (car sources) :output-file fasl :verbose t :load t))
          (provide (car modules)))))
    (setq modules (cdr modules))
    (go loop))))

;load, then update!
(defun require-update-modules (modules &optional force-compile)
  (if (not (listp modules)) (setq modules (list modules)))
  (let ((*package* (find-package :ccl)))
   (tagbody loop
    (if (null modules) (return-from require-update-modules t))
    (require-modules (car modules))
    (update-modules (car modules) force-compile)
    (setq modules (cdr modules))
    (go loop))))

;; Get the feeling that 
;;  a) "modules" shouldn't have platform-specific binary file types
;;     in them
;;  b) we could nuke most of the duplication if the cross-compiling
;;     stuff just knew what the host and target were.
;;  ?

#+ppc-target
(progn
(defun ppc-update-modules (modules &optional force-compile)
  (if (not (listp modules)) (setq modules (list modules)))
  (let ((*package* (find-package :ccl)))
    (dolist (module modules)
      (multiple-value-bind (fasl sources) (find-ppc-module module)
        (if (needs-compile-p fasl sources force-compile)
          (progn
            (require'nfcomp)
            (let* ((*warn-if-redefine* nil))
              (compile-file (car sources) :output-file fasl :verbose t :load t))
            (provide module)))))))

(defun ppc-compile-ccl (&optional force-compile)
  (ppc-compile-modules 'nxenv force-compile)
  (ppc-update-modules *compiler-modules* force-compile)
  (ppc-update-modules *ppc-compiler-modules* force-compile)
  (ppc-update-modules (cdr *ppc-xdev-modules*) force-compile)
  (ppc-update-modules *ppc-xload-modules* force-compile)
  (ppc-require-modules *ppc-env-modules*)
  (ppc-update-modules *ppc-env-modules* force-compile)
  (ppc-compile-modules *ppc-level-1-modules* force-compile)
  (ppc-update-modules *ppc-other-lib-modules* force-compile)
  (ppc-require-modules *ppc-other-lib-modules*)
  (ppc-require-update-modules *ppc-code-modules* force-compile)
  (ppc-compile-modules *ppc-aux-modules* force-compile))

)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
(defun require-env (&optional force-load)
  (require-modules *env-modules* force-load))

(defun compile-level-1 (&optional force-compile)
  (require-env)
  (compile-modules *level-1-modules* force-compile))
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun require-env (&optional force-load)
  (require-modules #-ppc-target *env-modules*
                   #+ppc-target *ppc-env-modules*
                   force-load))

(defun compile-level-1 (&optional force-compile)
  (require-env)
  (compile-modules #-ppc-target *level-1-modules*
                   #+ppc-target *ppc-level-1-modules*
                   force-compile))

#-ppc-target
(defun compile-compiler (&optional force-compile)
  (compile-modules *compiler-modules* force-compile)
  (compile-modules 'nx-base-app force-compile)
  (compile-modules *68k-compiler-modules* force-compile)
  (compile-modules *ppc-compiler-modules* force-compile))

#+ppc-target
(defun compile-compiler (&optional force-compile)
  (ppc-compile-compiler force-compile))

(defun compile-lib (&optional force-compile)
  (compile-modules #-ppc-target *lib-modules*
                   #+ppc-target *ppc-lib-modules*
                   force-compile))

(defun compile-code (&optional force-compile)
  (compile-modules #-ppc-target *code-modules*
                   #+ppc-target *ppc-code-modules*
                   force-compile))

#-ppc-target
(defun load-ccl ()
  (require-modules *compiler-modules*)
  (require-modules *lib-modules*)
  (require-modules *code-modules*)
  (require-modules *ppc-compiler-modules*)
  (require-modules *ppc-xdev-modules*)
  (require-modules *ppc-xload-modules*))

#+ppc-target
(defun load-ccl ()
  (ppc-load-ccl))

#-ppc-target
(defun compile-ccl (&optional force-compile)
  (update-modules *compiler-modules* force-compile)
  (update-modules *68k-compiler-modules* force-compile)
  (update-modules *ppc-compiler-modules* force-compile)
  (update-modules *ppc-xdev-modules* force-compile)
  (update-modules *ppc-xload-modules* force-compile)
  (require-modules *env-modules*)
  (update-modules *env-modules* force-compile)
  (compile-modules *level-1-modules* force-compile)
  (update-modules *other-lib-modules* force-compile)
  (require-modules *other-lib-modules*)
  (require-update-modules *code-modules* force-compile)
  (compile-modules *aux-modules* force-compile))

#+ppc-target
(defun compile-ccl (&optional force-compile)
  (ppc-compile-ccl force-compile))

;Compile but don't load
#-ppc-target
(defun xcompile-ccl (&optional force)
  (compile-compiler force)
  (compile-modules *level-1-modules* force)
  (compile-modules *lib-modules* force)
  (compile-modules *aux-modules* force)
  (compile-modules *code-modules* force))

#+ppc-target
(defun xcompile-ccl (&optional force)
  (ppc-xcompile-ccl force))

;; also in l1-pathnames
#|
(setf (logical-pathname-translations "ccl")
          `(("interfaces;**;*.*" "ccl:library;interfaces;**;*.*")
            ("inspector;**;*.*" "ccl:library;inspector folder;**;*.*")
            ;("lib;**;*.fasl" "ccl:bin;*.fasl")
            ;("lib;**;*.pfsl" "ccl:binppc;*.pfsl")
            ("lib;**;*.cfsl" "ccl:bincarbon;*.cfsl")
            ;("bin;*.lisp" "ccl:lib;*.lisp")  ; maybe
            ;("l1;**;*.fasl" "ccl:l1f;*.fasl")
            ;("l1;**;*.pfsl" "ccl:l1pf;*.pfsl")
            ("l1;**;*.cfsl" "ccl:l1cf;*.cfsl")
            ("l1;**;*.*" "ccl:level-1;**;*.*")
            ;("l1f;*.lisp" "ccl:level-1;*.lisp") ; maybe
            ;("l1f;**;*.pfsl" "ccl:l1pf;**;*.pfsl")
            ("l1f;**;*.cfsl" "ccl:l1cf;**;*.cfsl")
            ("bin;**;*.cfsl" "ccl:bincarbon;**;*.cfsl")
            ;("bin;**;*.pfsl" "ccl:binppc;**;*.pfsl")
            ;("l1pf;**;*.*" "ccl:l1-pfsls;**;*.*")
            ("l1cf;**;*.*" "ccl:l1-cfsls;**;*.*")
            ;("l1f;**;*.*" "ccl:l1-fasls;**;*.*")
            ("ccl;*.*" ,(merge-pathnames ":*.*" (mac-default-directory)))
            ("**;*.*" ,(merge-pathnames ":**:*.*" (mac-default-directory)))))
|#

#+ppc-target
(defun xcompile-ccl-carbon (&optional force)
  (pushnew :carbon-compat *features*)
  (setq *.fasl-pathname* (pathname ".cfsl")) ; leave it?
  (setq *.pfsl-pathname* (pathname ".cfsl")) 
  ;(setq *compile-verbose* t)
  (ppc-xcompile-ccl force))


; Interim PPC support
; sequences is here since l1-typesys REQUIREs it
(setq *ppc-level-1-modules*
      '(level-1 #|level-1-test|#
        #|version|#
        l1-cl-package
        l1-boot-1 l1-boot-2 l1-boot-3
        
        l1-utils l1-init l1-symhash l1-numbers l1-aprims ppc-callback-support
          l1-sort l1-dcode l1-clos l1-clos-boot
        l1-streams l1-files l1-io l1-menus
        l1-windows l1-edbuf l1-edcmd
        script-manager l1-edfrec l1-edwin l1-unicode-to-mac l1-tec
        scroll-bar-dialog-items scrolling-fred-view new-fred-window
        
        l1-events ppc-trap-support l1-highlevel-events l1-format l1-readloop l1-reader
        
        l1-initmenus l1-sysio l1-pathnames
        l1-listener
        l1-boot-lds #|l1-base-app|# l1-initmenus-lds l1-ed-lds l1-readloop-lds
        l1-stack-groups ppc-stack-groups l1-processes
        l1-typesys sysutils l1-error-system
        l1-error-signal
        ;l1-traps
         ))

(defun find-ppc-module (module)
  (find-module module))

(defun ppc-compile-modules (modules &optional force-compile)
  (if (not (listp modules)) (setq modules (list modules)))
  (let ((*package* (find-package :ccl)))
    (dolist (module modules t)
      (multiple-value-bind (fasl sources) (find-ppc-module module)
        (if (needs-compile-p fasl sources force-compile)
          (progn
            (require 'nfcomp)
            (compile-file (car sources) :output-file fasl :verbose t :target :ppc)))))))

(defun ppc-require-update-modules (modules &optional force-compile)
  (if (not (listp modules)) (setq modules (list modules)))
  (let ((*package* (find-package :ccl)))
   (tagbody loop
    (if (null modules) (return-from ppc-require-update-modules t))
    (ppc-require-modules (car modules))
    (ppc-update-modules (car modules) force-compile)
    (setq modules (cdr modules))
    (go loop))))

(defun ppc-compile-level-1 (&optional force-compile)
  (ppc-compile-modules *ppc-level-1-modules* force-compile))

(setq *ppc-env-modules*
      '(hash backquote lispequ sysequ toolequ level-2 trap-support
         ppc-lapmacros
        fredenv  ; why is this here?
        defstruct-macros lists chars setf 
        defstruct defstruct-lds 
        mactypes
        simple-db 
        deftrap
        defrecord
        new-traps
        dialogs color nfcomp 
        #|subprims8|#
        views windoids #-carbon-compat ff-call-68k))

(setq *ppc-other-lib-modules*
      '(fred-misc streams pathnames backtrace edhardcopy #|sanetraps|#
        apropos
        numbers 
        dumplisp ppc-disassemble
        resident-interfaces mac-file-io boyer-moore ))

(setq *ppc-lib-modules*
      (append *ppc-env-modules* *ppc-other-lib-modules*))

(setq *ppc-code-modules*
      '(encapsulate #|new-traps|# ; no compile cause of loop
        read misc doc-window arrays-fry
        sequences sort 
        method-combination ; doesnt work anyway - and gets error
        case-error pprint 
        format time print-db 
        eval
        fred-additions edit-definition fred-help list-definitions arglist
        pop-up-menu ccl-menus ccl-menus-lds font-menus mcl-extensions search-files
        inspector inspector-objects
        apropos-dialog 
        step step-window edit-callers
        backtrace-lds  ;ccl-export-syms
        nav-services
        color-dialog-items-os8-5
        ansi-make-load-form
        ccl-export-syms))

(setq *ppc-aux-modules*
      '(systems compile-ccl ppc-init-ccl ppc-init-ccl-carbon
        #-carbon-compat ff
        distrib-inits  ; what is that anyway - some inspector thing
        lisp-package resources #-carbon-compat help-manager #-carbon-compat interfaces
        number-macros number-case-macro
        #|patchenv|#
        icon-dialog-item
        hide-listener-support
        #|appgen-defs|#
        #|appgen-misc|#
        #| nmactypes |#
        save-application-dialog
        #|build-application|#
        #|boot-init save make-functions-resident|#  ; swapping stuff
        #|old-file-dialogs|#
        #-carbon-compat new-file-dialogs
        loop
        ppc-disassemble
        ppc-lapmacros
        ))

;;?? do we need optimizers and ppc-optimizers - YES??

#| ; some of this stays - some goes?
; def of NX
("ccl:compiler;nx.lisp"
    "ccl:compiler;nx0.lisp"
    "ccl:compiler;lambda-list.lisp"
    "ccl:compiler;nx1.lisp"
    "ccl:compiler;nx2.lisp"  ; out?
    "ccl:compiler;nx2a.lisp" ; out
    "ccl:compiler;nxenv.lisp"))
|#

(defun ppc-compile-compiler (&optional force-compile)
  (ppc-compile-modules 'nxenv force-compile)
  (ppc-compile-modules 'nx-base-app force-compile) ; for appgen
  (ppc-compile-modules *compiler-modules* force-compile)
  (ppc-compile-modules *ppc-compiler-modules* force-compile))

(defun ppc-xcompile-ccl (&optional force)
  (ppc-compile-compiler force) ; ??
  ;(ppc-compile-modules *ppc-xdev-modules* force)
  ; These won't compile correctly unless they're loaded 
  (ppc-update-modules *ppc-xload-modules* force)
  (ppc-compile-modules *ppc-level-1-modules* force)
  (ppc-compile-modules *ppc-lib-modules* force)
  (ppc-compile-modules *ppc-aux-modules* force)
  (ppc-compile-modules *ppc-code-modules* force)
  )


(defun ppc-load-ccl-carbon ()

 (ppc-require-modules *ppc-compiler-modules*)
  (ppc-require-modules *ppc-lib-modules*)
  (ppc-require-modules *ppc-code-modules*)
  ;(ppc-require-modules *ppc-xload-modules*)
  )
  

(defun ppc-load-ccl ()
  (ppc-require-modules *ppc-compiler-modules*)
  (ppc-require-modules *ppc-lib-modules*)
  (ppc-require-modules *ppc-code-modules*)
  ;(ppc-require-modules *ppc-xload-modules*)
  )

(defun ppc-require-module (module force-load)
  (multiple-value-bind (fasl source) (find-ppc-module module)
      (setq source (car source))
      (if (if fasl (probe-file fasl))
        (if force-load
          (progn
            (load fasl)
            (provide module))
          (require module fasl))
        (if (probe-file source)
          (progn
            (if fasl (format t "~&Can't find ~S so requiring ~S instead"
                             fasl source))
            (if force-load
              (progn
                (load source)
                (provide module))
              (require module source)))
          (error "Can't find ~S or ~S" fasl source)))))

(defun ppc-require-modules (modules &optional force-load)
  (if (not (listp modules)) (setq modules (list modules)))
  (let ((*package* (find-package :ccl)))
    (dolist (m (if (listp modules) modules (list modules)) t)
      ;(if (eq m 'step)(cerror "foo" "fie"))
      (ppc-require-module m force-load))))


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/2/95	akh	dont do scroll-bar-dialog-items twice
|# ;(do not edit past this line!!)
