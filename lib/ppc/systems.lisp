;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;; $Log: systems.lisp,v $
;; Revision 1.6  2006/02/04 21:12:59  alice
;; ; lose l1-traps
;;
;; Revision 1.5  2004/12/20 22:22:22  alice
;; add two new files
;;
;; Revision 1.4  2003/12/08 08:16:02  gtbyers
;; Define l1-clos-boot.
;;
;;  3 2/25/97  akh  sysutils comes in two parts
;;  22 10/3/96 akh  add setf-runtime
;;  19 7/31/96 slh  
;;  17 7/18/96 akh  added fred-help, edit-definition, list-definitions, nx-basic
;;  14 5/20/96 akh  juggle around with number-macros, add number-case-macro
;;  9 12/22/95 gb   add nxenv; ppc-compiler (mostly) moved to bin
;;  7 12/12/95 akh  add ppc-init-ccl
;;  5 11/15/95 slh  
;;  2 10/13/95 bill ccl3.0x25
;;  13 5/7/95  slh  balloon help mods.
;;  11 4/28/95 akh  use lib;inspector not library;inspector
;;  8 3/2/95   akh  added mac-file-io by itself
;;  5 2/17/95  slh  library stuff
;;  4 2/15/95  slh  added mac-file-io (to lib)
;;  3 2/15/95  slh  added boyer-moore
;;  (do not edit before this line!!)

; Copyright 1986-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc.

; Modification History
;
; lose l1-traps
; ----- 5.1 final
; akh remove some obsolete ones
; 03/03/99 akh  add nav-services and color-dialog-items-os8-5
; 04/23/97 bill  rename l1-boot to l1-boot-1
;                Add l1-cl-package
; 04/16/97 bill  add l1-boot-2 & l1-boot-3
; -------------  4.1f1
; 02/17/97 bill  "ccl:lib;ppc;misc.lisp" -> "ccl:lib;misc.lisp"
; -------------  4.0
; 02/04/97 akh   change for moving some files to xxx;ppc; Lose .fasl - .fasl-pathname is merged in find-module
; 08/28/96 bill  mcl-extensions
; -------------  MCL 4.0b1
; 08/01/96 gb    less ff zeal.
; 07/19/96 bill  build-application fasl back to bin directory.
; 07/17/96 bill  search-files
;                build-application & ff-call-68k fasls move from lib to bin directory
; 07/11/96 bill  add font-menus
;  7/02/96 slh   ff-source (for PPC); appgen-defs, appgen-misc
; -------------  MCL-PPC 3.9
; 03/28/96 bill  add ff-call-68k
; 03/07/96 bill  Add loop
; 01/05/96 bill  boyer-moore fasl goes in bin instead of lib.
; 12/27/95 gb    nx2 -> bin.
; 12/08/95 bill  ppc-trap-support
; 11/14/95 bill  ppc-callback-support, ppc-stack-groups
; 11/15/95 slh   ppc-subprims before ppc-lap
; 11/13/95 gb    Sons of l1-readloop.
; 10/13/95 gb    add xsym.
; 10/12/95 bill  add version
; 10/12/95 bill  add PPC compiler modules
;  6/08/95 slh   l1-files depends on old/new-file-dialogs
;  6/06/95 slh   old/new-file-dialogs
;  5/12/95 slh   l1-traps, new-traps
;  5/07/95 slh   dialog-macros & dependencies
;  4/27/95 slh   mac-file-io -> library
;  4/14/95 slh   added swapping modules
;  4/11/95 slh   build-application module (part of Redistribution Kit)
;  4/06/95 slh   doc-window, arglist modules
;  3/30/95 slh   merge in base-app changes
;                new backtrace-lds.lisp
;--------------  3.0d18
; 3/23/95 slh   move fredenv up so it gets compiled earlier
; 2/18/95 slh   added :lib:boyer-moore, :lib:mac-file-io, :library:save-application-dialog,
;               also :library:hide-listener-support, :library:icon-dialog-item
;-------------- 3.0d17
;08/18/93 bill  add script-manager
;-------------- 3.0d12
;07/13/93 alice scrolling-fred-dialog-item -> scrolling-fred-view
;04/14/93 bill  fred-menu is no more.
;-------------- 2.1d5
; ??      alice added new-fred-window, scrolling-fdi, moved pop-up-menu and scroll-bar di
;08/10/92 bill  added resident-interfaces
;07/09/92 bill  added patchenv.
;-------------- 2.0
;12/04/91 alice move subprims-8 near end so compiler can call find-unencapsulated-definition
;--------- 2.0b4
;08/21/91 bill add interfaces
;08/14/91 gb   ff.lisp -> ff-source.lisp.
;07/05/91 bill  add resources & help-manager
;------------- 2.0b2
;02/07/91 alice change for logical host
;02/27/91 bill add method-combination
;02/15/91 bill add l1-dcode
;------------- 2.0b1
;01/18/91 bill no more distrib-lap. lap.fasl, lapmacros.fasl, lispequ.fasl => "library;"
;01/11/91 bill distrib-lap, lispequ -> "library;", lisp-package
;01/09/91 bill distrib-inits
;01/08/91 bill move records & traps sources to LIBRARY;  Add FF
;12/8/90  joe  add l1-highlevel-events
;10/22/90 bill "inspector-internals.lisp" -> "inspector-package.lisp"
;09/17/90 bill add inspector & inspector-objects
;08/23/90 joe  added mactypes and deftrap
;08/08/90 gb   add systems, compile-ccl.
;06/12/90 bill remove transform.lisp
;05/27/90 gb   Added encapsulate.
;04/30/90 gb   nx8 -> nx.
;01/18/90 gz   Added aplink-macros,aplink,aplink-dump.
;12/29/89 gz   Added disasm.
;01/05/89 bill Added windoids.
;12/29/89 bill Added views. Removed copmmented clos (the level-2 one).
;12/28/89 gz   Renamed disasm to disassemble.  Restore edhardcopy.
;12/06/89 bill Add l1-sort.  Remove clos (all moved into l1-clos)
;10/31/89 bill added CLOS: first pass at real CLOS.
;10/4/89  gz   no more l1-macros
;09/27/89 gb   comment-out eval & step for time being.
; 09/16/89 bill Remove clos-l1-windows & clos-l1-streams
; 09/09/89 bill add clos-l1-windows: temporary, will replace l1-windows when CLOS
;               conversion is complete.
; 8/24/89 gb   add nx2a.
;4/28/89   gz  no code;
;18-apr-89 as  color
;03/23/89 gz split off l1-utils, l1-boot, l1-init, l1-numbers.
; 03/09/89 gz  l1-clos.
; 03/02/89 gb  l1-sysio, l1-symhash.
; 02/08/89 gb  give up on edhardcopy.
; 12/30/88 gz  l1-edbuf. No more bufstream
; 11/26/88 gz  New display code, no more fred-execute
; 11/25/88 gz  No more record-source.
; 11/16/88 gz  No more edwin-utils.
; 11/09/88 gb  pprint after case-error.
; 10/30/88 gb  Added chars.
; 9/11/88 gz  Added meter
; 8/17/88 gz  Split l1-files from level-1.  hash, defstruct -> lib.
; 8/13/88 gz  Added fred-misc.
;	      fred-additions-* -> fred-additions.
;             setf-* -> setf.
;             format-* -> format.
;             sequences-* -> sequences.
; 8/11/88 gz  New scheme for lisp-8


; module-name      binary                          (source . files-depends-on)
; -----------      ------                          ---------------------------
(defparameter *ccl-system* '(
 (level-1          "ccl:level-1"              ("ccl:l1;ppc;level-1.lisp"))
 ;(level-1-test     "ccl:level-1-test"         ("ccl:l1;level-1-test.lisp"))
 (l1-cl-package    "ccl:l1F;l1-cl-package"    ("ccl:l1;l1-cl-package.lisp"))
 (l1-utils         "ccl:L1F;l1-utils"         ("ccl:l1;ppc;l1-utils-ppc.lisp"
                                               "ccl:l1;l1-utils.lisp"))
 (l1-numbers       "ccl:L1F;l1-numbers"       ("ccl:l1;ppc;l1-numbers.lisp"))
 (l1-init          "ccl:L1F;l1-init"          ("ccl:l1;l1-init.lisp"))
 (version          "ccl:L1f;version"          ("ccl:l1;version.lisp"))
 (l1-boot-1        "ccl:L1F;l1-boot-1"        ("ccl:l1;l1-boot-1.lisp"))
 (l1-boot-2        "ccl:L1F;l1-boot-2"        ("ccl:l1;l1-boot-2.lisp"))
 (l1-boot-3        "ccl:L1F;l1-boot-3"        ("ccl:l1;l1-boot-3.lisp"))
 (l1-boot-lds      "ccl:L1F;l1-boot-lds"      ("ccl:l1;l1-boot-lds.lisp"))
 
 (l1-files         "ccl:L1F;l1-files"         ("ccl:l1;l1-files.lisp"
                                                    #|"ccl:library;old-file-dialogs.lisp"|#
                                                    #-carbon-compat "ccl:library;new-file-dialogs.lisp"))
 (l1-sort          "ccl:L1F;l1-sort"          ("ccl:l1;ppc;l1-sort.lisp"))
 (l1-dcode         "ccl:L1F;l1-dcode"         ("ccl:l1;ppc;l1-dcode.lisp"))
 (l1-clos          "ccl:L1F;l1-clos"          ("ccl:l1;ppc;l1-clos.lisp"))
 (l1-clos-boot     "ccl:L1F;l1-clos-boot"     ("ccl:l1;ppc;l1-clos-boot.lisp"))
 (l1-io            "ccl:L1F;l1-io"            ("ccl:l1;ppc;l1-io.lisp"))
 (l1-menus         "ccl:L1F;l1-menus"         ("ccl:l1;l1-menus.lisp"))
 (l1-streams       "ccl:L1F;l1-streams"       ("ccl:l1;l1-streams.lisp"))
 (l1-windows       "ccl:L1F;l1-windows"       ("ccl:l1;l1-windows.lisp"))
 (fredenv          "ccl:bin;fredenv"          ("ccl:lib;fredenv.lisp"))
 (L1-edwin         "ccl:L1F;L1-edwin"         ("ccl:l1;l1-edwin.lisp"
                                                    "ccl:lib;fredenv.lisp"))
 (L1-ed-lds        "ccl:L1F;L1-ed-lds"        ("ccl:l1;l1-ed-lds.lisp"
                                                "ccl:lib;fredenv.lisp"))
 (L1-edcmd         "ccl:L1F;L1-edcmd"         ("ccl:l1;l1-edcmd.lisp"
                                                "ccl:lib;fredenv.lisp"))
 (script-manager   "ccl:L1F;script-manager"   ("ccl:l1;script-manager.lisp"))
 (L1-edfrec        "ccl:L1F;l1-edfrec"        ("ccl:l1;l1-edfrec.lisp"
                                                "ccl:lib;fredenv.lisp"))
 (l1-unicode-to-mac "ccl:L1F;l1-unicode-to-mac" ("ccl:l1;l1-unicode-to-mac.lisp"))
 (l1-tec          "ccl:L1F;l1-tec"              ("ccl:l1;l1-tec.lisp"))
 
 (L1-edbuf         "ccl:L1F;L1-edbuf"         ("ccl:l1;l1-edbuf.lisp"
                                                "ccl:lib;fredenv.lisp"))
 (L1-listener      "ccl:L1F;L1-listener"      ("ccl:l1;l1-listener.lisp"
                                                "ccl:lib;fredenv.lisp"))
 (L1-events        "ccl:L1F;L1-events"        ("ccl:l1;l1-events.lisp"))
 (ppc-trap-support "ccl:L1F;ppc-trap-support" ("ccl:l1;ppc;ppc-trap-support.lisp"))
 (L1-highlevel-events
                   "ccl:L1F;L1-highlevel-events"
                                                   ("ccl:l1;l1-highlevel-events.lisp"))
 (L1-format        "ccl:L1F;L1-format"        ("ccl:l1;ppc;l1-format.lisp"))
 (L1-readloop      "ccl:L1F;L1-readloop"      ("ccl:l1;ppc;l1-readloop.lisp"))
 (L1-readloop-lds  "ccl:L1F;L1-readloop-lds"  ("ccl:l1;l1-readloop-lds.lisp"))
 (L1-reader        "ccl:L1F;L1-reader"        ("ccl:l1;ppc;l1-reader.lisp"))
 (L1-error-system  "ccl:L1F;L1-error-system"  ("ccl:l1;ppc;l1-error-system.lisp"))
 (L1-error-signal  "ccl:L1F;L1-error-signal"  ("ccl:l1;ppc;l1-error-signal.lisp"))
 (appgen-defs      "ccl:lib;appgen-defs"      ("ccl:lib;appgen-defs.lisp"))
 (L1-base-app      "ccl:L1F;L1-base-app"      ("ccl:l1;l1-base-app.lisp"
                                                    "ccl:lib;appgen-defs.lisp"))
 (L1-initmenus     "ccl:L1F;L1-initmenus"     ("ccl:l1;l1-initmenus.lisp"))
 (L1-initmenus-lds "ccl:L1F;L1-initmenus-lds" ("ccl:l1;l1-initmenus-lds.lisp"))
 (L1-aprims        "ccl:L1F;L1-aprims"        ("ccl:l1;l1-aprims.lisp"))
 (PPC-callback-support "ccl:L1F;PPC-callback-support" ("ccl:l1;ppc;PPC-callback-support.lisp"))
 (l1-sysio         "ccl:L1F;L1-sysio"         ("ccl:l1;l1-sysio.lisp"))
 (l1-symhash       "ccl:L1F;L1-symhash"       ("ccl:l1;ppc;l1-symhash.lisp"))
 (l1-pathnames     "ccl:L1F;L1-pathnames"     ("ccl:l1;l1-pathnames.lisp"))
 (new-fred-window  "ccl:l1f;new-fred-window"  ("ccl:l1;new-fred-window.lisp"))
 (l1-stack-groups  "ccl:L1F;L1-stack-groups"  ("ccl:l1;ppc;l1-stack-groups.lisp"))
 (PPC-stack-groups "ccl:L1F;PPC-stack-groups" ("ccl:l1;ppc;PPC-stack-groups.lisp"))
 (l1-processes     "ccl:L1F;L1-processes"     ("ccl:l1;l1-processes.lisp"))
 #+interfaces-2
 ;(l1-traps         "ccl:L1F;L1-traps"         ("ccl:l1;l1-traps.lisp"))
 (l1-typesys       "ccl:L1F;L1-typesys"       ("ccl:l1;ppc;l1-typesys.lisp"))
 (sysutils         "ccl:L1F;sysutils"         ("ccl:l1;ppc;sysutils.lisp"
                                               "ccl:l1;sysutils.lisp"))
 (nx               "ccl:L1F;nx"               ("ccl:compiler;nx.lisp"
                                                    "ccl:compiler;nx0.lisp"
                                                    "ccl:compiler;lambda-list.lisp"
                                                    "ccl:compiler;nx-basic.lisp"
                                                    "ccl:compiler;nx1.lisp"))
 (nxenv            "ccl:bin;nxenv"            ("ccl:compiler;nxenv.lisp"))
 (nx2              "ccl:bin;nx2"              ("ccl:compiler;nx2.lisp"
                                                    "ccl:compiler;nx2a.lisp"))
 (nx-base-app      "ccl:L1F;nx-base-app"      ("ccl:compiler;nx-base-app.lisp"
                                                    "ccl:compiler;lambda-list.lisp"))
 ; PPC compiler
 (dll-node         "ccl:bin;dll-node"         ("ccl:compiler;ppc;dll-node.lisp"))
 (ppc-arch         "ccl:bin;ppc-arch"         ("ccl:compiler;ppc;ppc-arch.lisp"))
 (ppcenv           "ccl:bin;ppcenv"           ("ccl:compiler;ppc;ppcenv.lisp"))
 (vreg             "ccl:bin;vreg"             ("ccl:compiler;ppc;vreg.lisp"))
 (ppc-asm          "ccl:bin;ppc-asm"          ("ccl:compiler;ppc;ppc-asm.lisp"))
 (vinsn            "ccl:bin;vinsn"            ("ccl:compiler;ppc;vinsn.lisp"))
 (ppc-vinsns       "ccl:bin;ppc-vinsns"       ("ccl:compiler;ppc;ppc-vinsns.lisp"))
 (ppc-reg          "ccl:bin;ppc-reg"          ("ccl:compiler;ppc;ppc-reg.lisp"))
 (ppc-subprims     "ccl:bin;ppc-subprims"     ("ccl:compiler;ppc;ppc-subprims.lisp"))
 (ppc-lap          "ccl:bin;ppc-lap"          ("ccl:compiler;ppc;ppc-lap.lisp"))
 (ppc-optimizers   "ccl:bin;ppc-optimizers"   ("ccl:compiler;ppc;ppc-optimizers.lisp"))
 (ppc2             "ccl:bin;ppc2"             ("ccl:compiler;ppc;ppc2.lisp"))

 (ppc-lapmacros    "ccl:bin;ppc-lapmacros"    ("ccl:compiler;ppc;ppc-lapmacros.lisp"))
 (ppc-disassemble  "ccl:bin;ppc-disassemble"  ("ccl:compiler;ppc;ppc-disassemble.lisp"))
 (xppcfasload      "ccl:xdump;xppcfasload"    ("ccl:xdump;xppcfasload.lisp"))
 (pef-file         "ccl:xdump;pef-file"       ("ccl:xdump;pef-file.lisp"))
 (xsym             "ccl:xdump;xsym"           ("ccl:xdump;xsym.lisp"))
 (number-macros "ccl:bin;number-macros"    ("ccl:compiler;ppc;number-macros.lisp"))
 (number-case-macro  "ccl:bin;number-case-macro" ("ccl:compiler;ppc;number-case-macro.lisp"))

 (optimizers       "ccl:bin;optimizers"       ("ccl:compiler;optimizers.lisp")) 
 (backquote        "ccl:bin;backquote"        ("ccl:lib;backquote.lisp"))
 (lispequ          "ccl:library;lispequ"      ("ccl:library;lispequ.lisp"))
 (sysequ           "ccl:bin;sysequ"           ("ccl:lib;sysequ.lisp"))
 (toolequ          "ccl:bin;toolequ"          ("ccl:lib;toolequ.lisp"))
 (level-2          "ccl:bin;level-2"          ("ccl:lib;level-2.lisp"))
 (trap-support     "ccl:bin;trap-support"     ("ccl:lib;trap-support.lisp"))
 ;(traps            "ccl:bin;traps"            ("ccl:library;traps.lisp"))
 (defstruct-macros "ccl:bin;defstruct-macros" ("ccl:lib;defstruct-macros.lisp"))
 (mactypes         "ccl:bin;mactypes"         ("ccl:lib;mactypes.lisp"))
 (defrecord        "ccl:bin;defrecord"        ("ccl:lib;defrecord.lisp"))
 (records          "ccl:bin;records"          ("ccl:library;records.lisp"))
 (simple-db        "ccl:bin;simple-db"        ("ccl:lib;simple-db.lisp"))
 (deftrap          "ccl:bin;deftrap"          ("ccl:lib;deftrap.lisp"))
 #+interfaces-2
 (new-traps        "ccl:bin;new-traps"        ("ccl:lib;new-traps.lisp"))
 ;(lap              "ccl:library;lap"          ("ccl:lib;lap.lisp"))  ; should really be in lib;68K;
 ;(lapmacros        "ccl:library;lapmacros"    ("ccl:lib;lapmacros.lisp"))
 ;(aplink-macros    "ccl:bin;aplink-macros"    ("ccl:lib;aplink-macros.lisp"))
 (scroll-bar-dialog-items
  		    "ccl:library;scroll-bar-dialog-items"
						   ("ccl:library;scroll-bar-dialog-items.lisp"))
 (pop-up-menu	   "ccl:library;pop-up-menu"  ("ccl:library;pop-up-menu.lisp"))

 (hash             "ccl:bin;hash"             ("ccl:lib;hash.lisp"))
 (nfcomp           "ccl:bin;nfcomp"           ("ccl:lib;ppc;nfcomp.lisp"))
 (lists            "ccl:bin;lists"            ("ccl:lib;lists.lisp"))
 (chars            "ccl:bin;chars"            ("ccl:lib;chars.lisp"))
 (color            "ccl:bin;color"            ("ccl:lib;color.lisp"))
 (dialogs          "ccl:bin;dialogs"          ("ccl:lib;dialogs.lisp"))
 (fred-misc        "ccl:bin;fred-misc"        ("ccl:lib;fred-misc.lisp"))
 (streams          "ccl:bin;streams"          ("ccl:lib;streams.lisp"))
 (pathnames        "ccl:bin;pathnames"        ("ccl:lib;pathnames.lisp"))
 (inspector        "ccl:bin;inspector"        ("ccl:lib;inspector.lisp"
                                                ;"ccl:library;scroll-bar-dialog-items.lisp"
                                                ;"ccl:library;pop-up-menu.lisp"
                                                "ccl:library;inspector folder;inspector-package.lisp"
                                                "ccl:library;inspector folder;inspector-class.lisp"
                                                "ccl:library;inspector folder;inspector-window.lisp"))
 (inspector-objects
                   "ccl:bin;inspector-objects"
                                                   ("ccl:lib;inspector-objects.lisp"
                                                  "ccl:library;inspector folder;ppc;new-backtrace.lisp"
                                                  "ccl:library;inspector folder;inspector-objects.lisp"))
 (backtrace        "ccl:bin;backtrace"        ("ccl:lib;ppc;backtrace.lisp"))
 (backtrace-lds    "ccl:bin;backtrace-lds"    ("ccl:lib;ppc;backtrace-lds.lisp"))
 (edhardcopy       "ccl:bin;edhardcopy"       ("ccl:lib;edhardcopy.lisp"))
 ;(sanetraps        "ccl:bin;sanetraps"        ("ccl:lib;sanetraps.lisp"))
 (apropos          "ccl:bin;apropos"          ("ccl:lib;apropos.lisp"))
 (mac-file-io      "ccl:library;mac-file-io"  ("ccl:library;mac-file-io.lisp"))
 (boyer-moore      "ccl:bin;boyer-moore"      ("ccl:lib;boyer-moore.lisp"
                                                    "ccl:library;mac-file-io.lisp"))
 (icon-dialog-item "ccl:library;icon-dialog-item"
                                                   ("ccl:library;icon-dialog-item.lisp"))
 (hide-listener-support
                   "ccl:library;hide-listener-support"
                                                   ("ccl:library;hide-listener-support.lisp"
                                                    "ccl:library;icon-dialog-item.lisp"))
 (save-application-dialog
                   "ccl:library;save-application-dialog"
                                                   ("ccl:library;save-application-dialog.lisp"
                                                    "ccl:library;hide-listener-support.lisp"))
 (appgen-misc      "ccl:lib;appgen-misc"      ("ccl:lib;appgen-misc.lisp"))
 (build-application "ccl:lib;build-application" ("ccl:lib;build-application.lisp"
                                                      "ccl:lib;appgen-misc.lisp"))
 (numbers          "ccl:bin;numbers"          ("ccl:lib;ppc;numbers.lisp"))
 (dumplisp         "ccl:bin;dumplisp"         ("ccl:lib;dumplisp.lisp"))
 ;(aplink           "ccl:bin;aplink"           ("ccl:lib;aplink.lisp"
 ;                                               "ccl:lib;aplink-macros.lisp"))
 ;(aplink-dump      "ccl:bin;aplink-dump"      ("ccl:lib;aplink-dump.lisp"
 ;                                               "ccl:lib;aplink-macros.lisp"))
 (disasm           "ccl:bin;disasm"           ("ccl:lib;disasm.lisp"))
 (defstruct        "ccl:bin;defstruct"        ("ccl:lib;defstruct.lisp"
                                                    "ccl:lib;defstruct-macros.lisp"))
 (defstruct-lds    "ccl:bin;defstruct-lds"    ("ccl:lib;defstruct-lds.lisp"
                                                    "ccl:lib;defstruct-macros.lisp"))
 (method-combination
                   "ccl:bin;method-combination"
                                                   ("ccl:lib;method-combination.lisp"))
 (meter            "ccl:bin;meter"            ("ccl:lib;meter.lisp"))
 (encapsulate      "ccl:bin;encapsulate"      ("ccl:lib;encapsulate.lisp"))
 (read             "ccl:bin;read"           ("ccl:lib;read.lisp"))
 (misc             "ccl:bin;misc"           ("ccl:lib;misc.lisp"))
 (doc-window       "ccl:bin;doc-window"       ("ccl:lib;doc-window.lisp"))
 (arrays-fry       "ccl:bin;arrays-fry"     ("ccl:lib;arrays-fry.lisp"))
 (sequences        "ccl:bin;sequences"      ("ccl:lib;sequences.lisp"))
 (sort             "ccl:bin;sort"           ("ccl:lib;ppc;sort.lisp"))
 (setf             "ccl:bin;setf"           ("ccl:lib;setf.lisp"
                                                  "ccl:lib;setf-runtime.lisp"))
 (format           "ccl:bin;format"         ("ccl:lib;format.lisp"))
 (case-error       "ccl:bin;case-error"     ("ccl:lib;case-error.lisp"))
 (pprint           "ccl:bin;pprint"         ("ccl:lib;pprint.lisp"))
 (time             "ccl:bin;time"           ("ccl:lib;time.lisp"))
 (print-db         "ccl:bin;print-db"       ("ccl:lib;print-db.lisp"))
 (eval             "ccl:bin;eval"           ("ccl:lib;eval.lisp"))
 (fred-additions   "ccl:bin;fred-additions" ("ccl:lib;fred-additions.lisp"))
 (fred-help        "ccl:bin;fred-help"      ("ccl:lib;fred-help.lisp"))
 (edit-definition  "ccl:bin;edit-definition" ("ccl:lib;edit-definition.lisp"))
 (list-definitions "ccl:bin;list-definitions" ("ccl:lib;list-definitions.lisp"))

 (arglist          "ccl:bin;arglist"          ("ccl:lib;arglist.lisp"))
 (dialog-macros    "ccl:library;dialog-macros"("ccl:library;dialog-macros.lisp"))
 (ccl-menus        "ccl:bin;ccl-menus"        ("ccl:lib;ccl-menus.lisp"))
 (ccl-menus-lds    "ccl:bin;ccl-menus-lds"    ("ccl:lib;ccl-menus-lds.lisp"
                                                    "ccl:library;dialog-macros.lisp"))
 (inspect          "ccl:bin;inspect"          ("ccl:lib;inspect.lisp"))
 (apropos-dialog   "ccl:bin;apropos-dialog"   ("ccl:lib;apropos-dialog.lisp"
                                                    "ccl:library;dialog-macros.lisp"))
 (views            "ccl:bin;views"          ("ccl:lib;views.lisp"))
 (windoids         "ccl:bin;windoids"       ("ccl:lib;windoids.lisp"))
 (scrolling-fred-view
  		   "ccl:library;scrolling-fred-view"
						 ("ccl:library;scrolling-fred-view.lisp"))
 (edit-callers	   "ccl:bin;edit-callers"   ("ccl:lib;edit-callers.lisp"))
 (step             "ccl:bin;step"           ("ccl:lib;step.lisp"))
 (step-window      "ccl:bin;step-window"    ("ccl:lib;step-window.lisp"))
 (disassemble      "ccl:bin;disassemble"      ("ccl:lib;disassemble.lisp"
                                                "ccl:compiler;subprims8.lisp"))
 (subprims8        ()                          	("ccl:compiler;subprims8.lisp"))
 (ccl-export-syms  "ccl:bin;ccl-export-syms"  ("ccl:lib;ccl-export-syms.lisp"))
 (systems          "ccl:bin;systems"        ("ccl:lib;ppc;systems.lisp"))
 (compile-ccl      "ccl:bin;compile-ccl"    ("ccl:lib;ppc;compile-ccl.lisp"))
 (compile-ccl-carbon      "ccl:bin;compile-ccl-carbon"    ("ccl:lib;ppc;compile-ccl-carbon.lisp"))
 
 (ppc-init-ccl     "ccl:bin;ppc-init-ccl"   ("ccl:lib;ppc;ppc-init-ccl.lisp"))
 (init-ccl-carbon  "ccl:bin;init-ccl-carbon" ("ccl:lib;init-ccl-carbon.lisp"))
 (ppc-init-ccl-carbon "ccl:bin;ppc-init-ccl-carbon"   ("ccl:lib;ppc;ppc-init-ccl-carbon.lisp"))
 
 (merge-ccl-update "ccl:bin;merge-ccl-update" ("ccl:lib;merge-ccl-update.lisp"))
 (ff               "ccl:library;ff"         ("ccl:lib;ff-source.lisp"))
 (distrib-inits    "ccl:bin;distrib-inits"  ("ccl:lib;distrib-inits.lisp"))
 (lisp-package     "ccl:library;lisp-package" ("ccl:library;lisp-package.lisp"))
 (help-manager     "ccl:library;help-manager" ("ccl:library;help-manager.lisp"))
 (resources        "ccl:library;resources"  ("ccl:library;resources.lisp"))
 (interfaces       "ccl:library;interfaces" ("ccl:library;interfaces.lisp"))
 (patchenv         "ccl:bin;patchenv"       ("ccl:lib;patchenv.lisp"))
 (resident-interfaces
                   "ccl:bin;resident-interfaces"
                                                   ("ccl:lib;resident-interfaces.lisp"))
 (old-file-dialogs "ccl:library;old-file-dialogs"
                                                   ("ccl:library;old-file-dialogs.lisp"))
 (new-file-dialogs "ccl:library;new-file-dialogs"
                                                   ("ccl:library;new-file-dialogs.lisp"))
 (nav-services     "ccl:library;nav-services"      ("ccl:library;nav-services.lisp"))
 (color-dialog-items-os8-5 "ccl:library;color-dialog-items-os8-5" ("ccl:library;color-dialog-items-os8-5.lisp"))
 (ansi-make-load-form "ccl:library;ansi-make-load-form" ("ccl:library;ansi-make-load-form.lisp"))
                   
 ; need to add swapping, xdump to CCL's *module-search-path*
 ;(boot-init        "ccl:swapping;boot-init"   ("ccl:swapping;boot-init.lisp"))
 ;(save             "ccl:swapping;save"        ("ccl:swapping;save.lisp"))
 ;(make-functions-resident
 ;                  "ccl:swapping;make-functions-resident"
 ;                                                  ("ccl:swapping;make-functions-resident.lisp"))
 (xdump            "ccl:xdump;xdump"          ("ccl:xdump;xdump.lisp"))
 (fasload          "ccl:xdump;fasload"        ("ccl:xdump;fasload.lisp"))
 (loop             "ccl:library;loop"         ("ccl:library;loop.lisp"))
 (ff-call-68k      "ccl:bin;ff-call-68k"      ("ccl:lib;ff-call-68k.lisp"))
 (font-menus       "ccl:library;font-menus"   ("ccl:library;font-menus.lisp"))
 (search-files     "ccl:bin;search-files"     ("ccl:lib;search-files.lisp"))
 (mcl-extensions   "ccl:bin;mcl-extensions"   ("ccl:lib;mcl-extensions.lisp"))
 ))

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
