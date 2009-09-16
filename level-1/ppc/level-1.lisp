
;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: level-1.lisp,v $
;;  Revision 1.7  2006/02/03 20:07:49  alice
;;  ;; lose l1-traps
;;
;;  Revision 1.6  2005/07/04 23:49:18  alice
;;  fix boot problem
;;
;;  Revision 1.5  2003/12/08 08:32:24  gtbyers
;;  Load l1-clos-boot, and load some other files earlier.
;;
;;  2 2/13/97  akh  probably no change
;;  14 1/22/97 akh  probably no change
;;  13 5/20/96 akh  probably no change
;;  11 12/22/95 gb  muck with ccl:bin;*.pfsl translations
;;  9 11/19/95 gb   no change after all.  Never Mind.
;;  7 11/16/95 akh  %load-binary gets level-1 pfsl's from l1-pfsls;
;;  5 10/27/95 akh  damage control
;;  4 10/26/95 gb   hide file type behind %load-binary.  Toplevel-functions
;;                  don't loop forever (knock wood.)
;;  2 10/13/95 bill ccl3.0x25
;;  3/12/95 gb    no more %nilreg-mumble-symbols%.
;;  10 2/17/95 akh  no change
;;  8 2/3/95   slh  copyright thang
;;  7 2/2/95   akh  no change
;;  5 1/13/95  akh  none really
;;  (do not edit before this line!!)

; Level-1.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2000 Digitool, Inc.

;; **** There must be NO lisp package or nilreg-rel immediates in this file ****

#|
;; Modification History
;
;; lose l1-traps
;------ 5.1 final
; 04/23/97 bill  Move lisp package stuff to l1-cl-package.lisp
; -------------  4.1f1
; 04/16/97 bill  add l1-boot-2 & l1-boot-3
; -------------  4.1b2
; 12/08/95 bill  ppc-trap-support
; 11/14/95 bill  ppc-callback-support, ppc-stack-groups
; 10/12/95 bill  version
;  5/12/95 slh   l1-traps
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; -------------- 3.0d16
; 08/18/93 bill  add script-manager
; -------------- 3.0d12
; 03/15/93 alice load new-fred-window, views, dialogs, scroll-bar-di, and scrolling-fdi
; 01/29/93 bill add *%dynvlimit%* to value cells list
;--------- 2.1d1
; 11/20/92 gb   Change nilreg space initialization; new headers.  Load process &
;               stack-groups support.
;--------- 2.0
; 10/15/91 gb   sg vcell.
;--------- 2.0b3
; 08/24/91 gb   use new trap syntax.
; 07/21/91 gb   *break-on-warnings* to CCL.  Add IGNORABLE (premature ?),  redo
;               vcells and fcells.
; 05/20/91 gb   remove CHAR-FONT, SET-CHAR-BIT, STRING-CHAR[-P] from CL package.
; 01/15/91 bill add l1-dcode
; 02/07/91 alice add l1-pathnames
;--------- 2.0b1
; 12/8/90  joe  add l1-highlevel-events (removed temporarily due to crapness)
; 11/10/90 gb   new fasloader, package "subprims".
; 10/16/90 gb   remove COMMON[P], *MODULES* from CL package.
; 08/28/90 bill $vc.saved_method_var becomes anonymous.
; 08/10/90 gb   $sym.package -> $sym.package-plist.  *Pre- and *post-gc-hook*.
;               PROVIDE, REQUIRE, COMPILER-LET -> CCL package.
; 07/31/90 bill add ALLOCATE-INSTANCE
; 06/27/90 bill add *%SAVED-METHOD-VAR%*
; 06/08/90 gb  compiler-macroexpand & compiler-macroexpand-1 exported from ccl: .
; 06/06/90 bill compiler-macroexpand & compiler-macroexpand-1
; 05/30/90 gb  %cons-name% vcell.
; 04/30/90 gb  fascist vcells for gc-event-check. %kernel-restart fascism.
;              intern everything in *common-lisp-package*.
01/17/90 gz   Load readloop before events.
12/18/89 gz    %unbound-function%
12/06/89 bill add l1-sort.
 11/16/89 gz  No nilreg cell for equal.
 11/06/89 gb  *%dynvfp%* now a value cell.
 10/16/89 gz  flush %object-name%, %defobfun, :internal, :external, :inherited.
 09/28/89 gb  fascist value cell for *ALL-METERED-FUNCTIONS*.
 09/17/89 gb  no more *root-, *current-object*, or fsymuobj thing.
 9/13/89  gz  new nilreg space bounds convention.
              Flushed *lisp-fasl-file-version*, *lisp-init-file*.
 05/31/89 gz  Save promoted symbols in %nilreg-vcell/fcell-symbols%.
              Only 4 bytes per vcell.
;05/03/89 gz  v215  promote fascist nilreg cells here.
;04/07/89 gb  $sp8 -> $sp.
03/23/89 gz  v214  exchanged l1-boot & level-1: Install lisp package symbols
                   then load level-1 components.
03/10/89 gz  v213  Toy clos.
03/02/89 gb  v212  sysio, symhash.
10/30/88 gz  v211  New editor. Load l1-streams before l1-files.
 8/29/88 gz  v203  new file sys.
 8/25/88 gz	   moved %fhave & %proclaim-special to l1-utils. Load l1-aprims
                   before l1-files.
 8/17/88 gz  v202  fasload l1-files.
 7/11/88 as        removed ccl-doc
 6/21/88 jaj v187  catch :error  -> catch-error, blc v1.2b3
 5/31/88 as  v186  %error -> :error, blc version 1.2b1
 5/19/88 as        punted *abort-char*

 3/29/88 gz  v200  New macptr scheme. Flushed pre-1.0 edit history.
 9/17/87 jaj v185  1.1d3 default-button flicker fix, removed alltraps
 9/16/87 jaj v184  conditionalize version for bccl. set-window-font merges
                   font-spec. apple-menu re-installs properly, load menu queues
                   up, break-loop prints continue with ~s
 8/20/87 gz  v183  fixes in pathnames, equalp. Made lisp-implementation-version
                   include kernel and level-1 versions again >> REMEMBER TO
                   CHANGE THAT FOR THE PRODUCTION VERSION <<
---------------------------------Version 1.0-----------------------------------
|#

(unless 
  #-ppc-target (%fasload *genapp-fsl*)         ; sets *lds* nil
  #+ppc-target nil
  (setq *lds* t))





(eval-when (:compile-toplevel)

(defmacro %load-binary (path)
  #+ignore ;#+ppc-target
  `(%fasload    
    ,(namestring (make-pathname :directory (subst #-carbon-compat "l1-pfsls"
                                                  #+carbon-compat "l1-cfsls" 
                                                  "l1-fasls"
                                                  (subst #-carbon-compat "binppc"
                                                         #+carbon-compat "bincarbon"
                                                         "bin"
                                                         (pathname-directory path) :test #'equalp)
                                                  :test #'equalp)
                     :name (pathname-name path)
                     :type #-carbon-compat (pathname-type *.pfsl-pathname*)
                            #+carbon-compat "cfsl")))
  #-ignore ;#-ppc-target
  `(%fasload
    ,(concatenate 'simple-base-string
                  path
                  "."
                  (pathname-type *.fasl-pathname*))))
)



(%load-binary ":L1-cfsls:L1-cl-package")
;(dbg 1)

(%load-binary ":L1-cfsls:L1-utils")
;(dbg 2)
(%load-binary ":L1-cfsls:L1-init")
;(dbg 3)
(%load-binary ":L1-cfsls:L1-symhash")
(%load-binary ":L1-cfsls:L1-numbers")
;(dbg 3)
(%load-binary ":L1-cfsls:L1-aprims")
;(dbg 4)
(%load-binary ":L1-cfsls:PPC-callback-support")
(%load-binary ":L1-cfsls:L1-sort")
(%load-binary ":Bincarbon:lists")
(%load-binary ":Bincarbon:sequences")
(%load-binary ":L1-cfsls:L1-dcode")
(%load-binary ":L1-cfsls:L1-clos-boot")
;(%load-binary ":Bincarbon:hash")
(%load-binary ":L1-cfsls:L1-clos")
;(dbg 3)
(%load-binary ":L1-cfsls:L1-streams")
;(dbg 4)
;(%load-binary ":L1-cfsls:L1-traps")    ; must go before any ff-call trap is called
(%load-binary ":L1-cfsls:L1-files")
(%load-binary ":L1-cfsls:L1-stack-groups")
(%load-binary ":L1-cfsls:PPC-stack-groups")
(%load-binary ":L1-cfsls:L1-processes")
(%load-binary ":L1-cfsls:L1-io")
(%load-binary ":L1-cfsls:L1-menus")
;(dbg 5)
(%load-binary ":L1-cfsls:L1-windows")
;(dbg 6)
(%load-binary ":L1-cfsls:L1-edbuf")
(%load-binary ":L1-cfsls:L1-edcmd")
(%load-binary ":L1-cfsls:script-manager")
(%load-binary ":L1-cfsls:L1-edfrec")
(%load-binary ":L1-cfsls:L1-edwin")
;(dbg 10)
(%load-binary ":L1-cfsls:L1-unicode-to-mac")
(%load-binary ":L1-cfsls:L1-tec")
;(dbg 11)
 
(lds (%load-binary ":L1-cfsls:L1-ed-lds"))
(%load-binary ":Bincarbon:dialogs")
(%load-binary ":Bincarbon:views")
(%load-binary ":library:scroll-bar-dialog-items")
(%load-binary ":library:scrolling-fred-view")
(%load-binary ":L1-cfsls:new-fred-window")
(lds (%load-binary ":L1-cfsls:L1-listener"))
(%load-binary ":L1-cfsls:L1-reader")
(%load-binary ":L1-cfsls:L1-readloop")
(lds (%load-binary ":L1-cfsls:L1-readloop-lds")
     (%load-binary ":L1-cfsls:L1-base-app"))
(%load-binary ":L1-cfsls:L1-error-system")
(provide "SEQUENCES")
(provide "LISTS")




; handy when we dont do windows yet
(defun %error (condition args error-pointer)
  (setq condition (condition-arg condition args 'simple-error))
  (with-pstrs ((str (format nil "error-ppp: ~a" condition))) (#_DebugStr str))  
  (signal condition)
  (with-pstrs ((str (format nil "error: ~a" condition))) (#_DebugStr str))
  (application-error *application* condition error-pointer)
  (application-error
   *application*
   (condition-arg "~s returned. It shouldn't.~%If it returns again, I'll throw to toplevel."
                  '(application-error) 'simple-error)
   error-pointer)
  (toplevel))
;

(%load-binary ":L1-cfsls:L1-events")
(%load-binary ":L1-cfsls:ppc-trap-support")
; (%load-binary ":L1-cfsls:L1-highlevel-events")
(%load-binary ":L1-cfsls:L1-format")
(%load-binary ":L1-cfsls:L1-initmenus")
(lds (%load-binary ":L1-cfsls:L1-initmenus-lds"))
(%load-binary ":L1-cfsls:L1-sysio")
(%load-binary ":L1-cfsls:L1-pathnames")
(%load-binary ":L1-cfsls:version")

(lds (%load-binary ":L1-cfsls:L1-boot-lds")) ; load before l1-boot

(%load-binary ":L1-cfsls:L1-boot-1")
(%load-binary ":L1-cfsls:L1-boot-2")
(%load-binary ":L1-cfsls:L1-boot-3")



;; once level-1 is happy we say (require :init-ccl) to load rest


#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
	3	1/2/95	akh	actually no change
  4   1/6/95   akh   no change
|# ;(do not edit past this line!!)
