(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CommonPanels.h"
; at Sunday July 2,2006 7:25:13 pm.
; 
;      File:       CommonPanels/CommonPanels.h
;  
;      Contains:   Master include for CommonPanels framework
;  
;      Version:    CommonPanels-70~11
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __COMMONPANELS__
; #define __COMMONPANELS__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __HITOOLBOX__
#| #|
#include <HIToolboxHIToolbox.h>
#endif
|#
 |#
; 
; Color Picker
; 
; #ifndef __COLORPICKER__

(require-interface "CommonPanels/ColorPicker")

; #endif

; #ifndef __CMCALIBRATOR__

(require-interface "CommonPanels/CMCalibrator")

; #endif

; #ifndef __NSL__

(require-interface "CommonPanels/NSL")

; #endif

; 
; Font Panel
; 
; #ifndef __FONTPANEL__

(require-interface "CommonPanels/FontPanel")

; #endif


; #endif /* __COMMONPANELS__ */


(provide-interface "CommonPanels")