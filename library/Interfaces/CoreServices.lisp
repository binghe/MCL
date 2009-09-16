(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CoreServices.h"
; at Sunday July 2,2006 7:23:07 pm.
; 
;      File:       CoreServices/CoreServices.h
;  
;      Contains:   Master include for CoreServices (non-UI toolbox)
;  
;      Version:    CoreServices-16~158
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CORESERVICES__
; #define __CORESERVICES__
; #ifndef __CARBONCORE__

(require-interface "CarbonCore/CarbonCore")

; #endif

; #ifndef __OSSERVICES__

(require-interface "OSServices/OSServices")

; #endif

; #ifndef __COREFOUNDATION__

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; #ifndef __CFNETWORK__

(require-interface "CFNetwork/CFNetwork")

; #endif

; #ifndef __WEBSERVICESCORE__

(require-interface "WebServicesCore/WebServicesCore")

; #endif

; #ifndef __SEARCHKIT__

(require-interface "SearchKit/SearchKit")

; #endif


; #endif /* __CORESERVICES__ */


(provide-interface "CoreServices")