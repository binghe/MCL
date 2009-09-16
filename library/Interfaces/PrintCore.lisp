(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PrintCore.h"
; at Sunday July 2,2006 7:24:42 pm.
; 
;      File:       PrintCore/PrintCore.h
;  
;      Contains:   Printing functions that have no UI
;  
;      Version:    PrintingCore-129~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PRINTCORE__
; #define __PRINTCORE__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __COLORSYNC__
#| #|
#include <ColorSyncColorSync.h>
#endif
|#
 |#
; #ifndef __QD__
#| #|
#include <QDQD.h>
#endif
|#
 |#
; #ifndef __PMCORE__

(require-interface "PrintCore/PMCore")

; #endif

; #ifndef __PMDEFINITIONS__
#| #|
#include <PrintCorePMDefinitions.h>
#endif
|#
 |#
; #ifndef __PMPrintAETypes__

(require-interface "PrintCore/PMPrintAETypes")

; #endif


; #endif /* __PRINTCORE__ */


(provide-interface "PrintCore")