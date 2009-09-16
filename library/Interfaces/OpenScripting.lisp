(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OpenScripting.h"
; at Sunday July 2,2006 7:25:08 pm.
; 
;      File:       OpenScripting/OpenScripting.h
;  
;      Contains:   Master include for OpenScripting private framework
;  
;      Version:    OSA-62~76
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __OPENSCRIPTING__
; #define __OPENSCRIPTING__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __HITOOLBOX__
#| #|
#include <HIToolboxHIToolbox.h>
#endif
|#
 |#
; #ifndef __OSA__

(require-interface "OpenScripting/OSA")

; #endif

; #ifndef __OSACOMP__

(require-interface "OpenScripting/OSAComp")

; #endif

; #ifndef __OSAGENERIC__

(require-interface "OpenScripting/OSAGeneric")

; #endif

; #ifndef __APPLESCRIPT__

(require-interface "OpenScripting/AppleScript")

; #endif

; #ifndef __ASDEBUGGING__

(require-interface "OpenScripting/ASDebugging")

; #endif

; #ifndef __ASREGISTRY__

(require-interface "OpenScripting/ASRegistry")

; #endif

; #ifndef __FINDERREGISTRY__

(require-interface "OpenScripting/FinderRegistry")

; #endif

; #ifndef __DIGITALHUBREGISTRY__

(require-interface "OpenScripting/DigitalHubRegistry")

; #endif


; #endif /* __OPENSCRIPTING__ */


(provide-interface "OpenScripting")