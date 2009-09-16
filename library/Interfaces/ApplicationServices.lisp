(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ApplicationServices.h"
; at Sunday July 2,2006 7:23:44 pm.
; 
;      File:       ApplicationServices/ApplicationServices.h
;  
;      Contains:   Master include for ApplicationServices public framework
;  
;      Version:    ApplicationServices-19~376
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __APPLICATIONSERVICES__
; #define __APPLICATIONSERVICES__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __ATS__

(require-interface "ATS/ATS")

; #endif

; #ifndef __QD__

(require-interface "QD/QD")

; #endif

; #ifndef __AE__
#| #|
#include <AEAE.h>
#endif
|#
 |#
; #ifndef __HISERVICES__

(require-interface "HIServices/HIServices")

; #endif

; #ifndef __PRINTCORE__

(require-interface "PrintCore/PrintCore")

; #endif

; #ifndef __COREGRAPHICS__
#| #|
#include <CoreGraphicsCoreGraphics.h>
#endif
|#
 |#
; #ifndef __COLORSYNC__
#| #|
#include <ColorSyncColorSync.h>
#endif
|#
 |#
; #ifndef __FINDBYCONTENT__

(require-interface "FindByContent/FindByContent")

; #endif

; #ifndef __LANGANALYSIS__

(require-interface "LangAnalysis/LangAnalysis")

; #endif

; #ifndef __SPEECHSYNTHESIS__

(require-interface "SpeechSynthesis/SpeechSynthesis")

; #endif

; #ifndef __LAUNCHSERVICES__

(require-interface "LaunchServices/LaunchServices")

; #endif


; #endif /* __APPLICATIONSERVICES__ */


(provide-interface "ApplicationServices")