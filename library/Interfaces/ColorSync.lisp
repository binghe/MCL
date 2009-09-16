(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ColorSync.h"
; at Sunday July 2,2006 7:24:21 pm.
; 
;      File:       ColorSync/ColorSync.h
;  
;      Contains:   Master include for ColorSync private framework
;  
;      Version:    ColorSync-118.2~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __COLORSYNC__
; #define __COLORSYNC__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __CMTYPES__

(require-interface "ColorSync/CMTypes")

; #endif

; #ifndef __CMAPPLICATION__

(require-interface "ColorSync/CMApplication")

; #endif

; #ifndef __CMICCPROFILE__
#| #|
#include <ColorSyncCMICCProfile.h>
#endif
|#
 |#
; #ifndef __CMDEVICEINTEGRATION__

(require-interface "ColorSync/CMDeviceIntegration")

; #endif

; #ifndef __CMMCOMPONENT__

(require-interface "ColorSync/CMMComponent")

; #endif

; #ifndef __CMSCRIPTINGPLUGIN__

(require-interface "ColorSync/CMScriptingPlugin")

; #endif


; #endif /* __COLORSYNC__ */


(provide-interface "ColorSync")