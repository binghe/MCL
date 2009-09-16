(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Carbon.h"
; at Sunday July 2,2006 7:23:07 pm.
; 
;      File:       Carbon/Carbon.h
;  
;      Contains:   Master include for all of Carbon
;  
;      Version:    Carbon-128~189
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CARBON__
; #define __CARBON__
; #ifndef __CORESERVICES__

(require-interface "CoreServices/CoreServices")

; #endif

; #ifndef __APPLICATIONSERVICES__

(require-interface "ApplicationServices/ApplicationServices")

; #endif

; #ifndef __HITOOLBOX__

(require-interface "HIToolbox/HIToolbox")

; #endif

; #ifndef __CARBONSOUND__

(require-interface "CarbonSound/CarbonSound")

; #endif

; #ifndef __OPENSCRIPTING__

(require-interface "OpenScripting/OpenScripting")

; #endif

; #ifndef __PRINT__

(require-interface "Print/Print")

; #endif

; #ifndef __NAVIGATIONSERVICES__

(require-interface "NavigationServices/NavigationServices")

; #endif

; #ifndef __COMMONPANELS__

(require-interface "CommonPanels/CommonPanels")

; #endif

; #ifndef __HTMLRENDERING__

(require-interface "HTMLRendering/HTMLRendering")

; #endif

; #ifndef __SPEECHRECOGNITION__

(require-interface "SpeechRecognition/SpeechRecognition")

; #endif

; #ifndef __SECURITYHI__

(require-interface "SecurityHI/SecurityHI")

; #endif

; #ifndef __INK__

(require-interface "Ink/Ink")

; #endif

; #ifndef __HELP__

(require-interface "Help/Help")

; #endif

; #ifndef __IMAGECAPTURE__

(require-interface "ImageCapture/ImageCapture")

; #endif


; #endif /* __CARBON__ */


(provide-interface "Carbon")