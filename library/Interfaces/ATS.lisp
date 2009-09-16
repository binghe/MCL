(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ATS.h"
; at Sunday July 2,2006 7:23:45 pm.
; 
;      File:       ATS/ATS.h
;  
;      Contains:   Master include for ATS private framework
;  
;      Version:    ATS-135~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ATS__
; #define __ATS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __ATSLAYOUTTYPES__

(require-interface "ATS/ATSLayoutTypes")

; #endif

; #ifndef __ATSFONT__

(require-interface "ATS/ATSFont")

; #endif

; #ifndef __ATSTYPES__
#| #|
#include <ATSATSTypes.h>
#endif
|#
 |#
; #ifndef __SCALERSTREAMTYPES__

(require-interface "ATS/ScalerStreamTypes")

; #endif

; #ifndef __SFNTLAYOUTTYPES__
#| #|
#include <ATSSFNTLayoutTypes.h>
#endif
|#
 |#
; #ifndef __SFNTTYPES__
#| #|
#include <ATSSFNTTypes.h>
#endif
|#
 |#

; #endif /* __ATS__ */


(provide-interface "ATS")