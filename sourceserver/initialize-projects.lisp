; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  5 4/1/97   bill 4.1d22
;;  3 2/13/97  akh  examples subprojects
;;  2 2/9/97   akh  add inspector folder 68K and ppc
;;  10 10/12/96 akh put back tests
;;  9 7/31/96  slh  
;;  7 6/4/96   akh  patches 3.9
;;  4 10/24/95 bill Add documentation project
;;  2 10/6/95  gb   n/a
;;
;;  8 6/30/95  slh  added Patches 3.0
;;  7 6/23/95  slh  added AppGen
;;  5 5/25/95  slh  added new interface translator, removed old
;;  3 2/17/95  akh  added help-maker etc
;;  2 2/10/95  akh  added help-maker, swapping, tests pinterface
;;  1 2/10/95  akh  new file
;;  (do not edit before this line!!)

(in-package :ccl)

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; 04/01/97 bill  Add "library;interfaces" & "OpenTransportSupport Ä"
;;; -------------  4.1b1
;;; 10/30/96 bill  Added "Patches 4.0"
;;; -------------  MCL 4.0
;;;  7/31/96 slh   added ppc_dcmds
;;; 06/04/96 bill  Uncomment Wood
;;; -------------  MCL-PPC 3.9
;;;

;;;;;;;;;;;;;;;;
;;; CCL projects 
;;; change this for your projects

(setq *all-projects*        
  '(
;    "AppGen"
;    "AppGen;Examples"
     "Build"
     "Build;Asms"
    "Compiler"
    "Compiler;PPC"
    "compiler-68k"
    "Documentation"
    "Examples"
    "Examples;BinHex"
    "Examples;FF Examples"
    "Examples;NotInROM"
    "Examples;Series"
;    "FixedContribs"
    "Help-Maker"
    "Help-Maker;Fred Format"
    "Interface Tools"
;    "Interface Translator"
;    "interface translator;Cached"
;    "interface translator;Emeritus"
;    "interface translator;Legacies"
;    "interface translator;Patches"
;    "Interface Translator;Source"
;    "interface translator;Source;Debug"
;    "Interface Translator;Source;Inline"
;    "Interface Translator;Source;Runtime"
;    "interface translator;Translation Commentary"
    "Level-0"
    "Level-0;68K"
    "Level-0;PPC"
    "Level-1"
    "level-1;68K"
    "level-1;ppc"
    "Lib"
    "lib;68K"
    "lib;ppc"
    "Library"
    "Library;Inspector Folder"
    "library;inspector folder;68K"
    "library;inspector folder;ppc"
    "library;interfaces"
;    "library;interfaces;index"
     "LispDcmds"
     "OpenTransportSupport Ä"
;    "Patches 3.0"
;    "Patches 3.9"
;    "Patches 4.0"
    "pmcl"
    "pmcl;ndcmds;"
;    "pmcl;PPCTraceEnabler"
    "ppc_dcmds"
;    "PTable-Sources"
    "Sourceserver"
;    "Swapping"
   "Tests"
    "Wood"
;    "Wood;patches"
    "XDump"
    ))

(translate-to-my-projects *all-projects*)
(reset-projects)

; End of initialize-projects.lisp
