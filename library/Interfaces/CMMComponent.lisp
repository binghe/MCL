(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CMMComponent.h"
; at Sunday July 2,2006 7:24:24 pm.
; 
;      File:       ColorSync/CMMComponent.h
;  
;      Contains:   ColorSync CMM Component API
;  
;      Version:    ColorSync-118.2~1
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CMMCOMPONENT__
; #define __CMMCOMPONENT__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __CMAPPLICATION__
#| #|
#include <ColorSyncCMApplication.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

;  Component-based CMM interface version 

(defconstant $CMMInterfaceVersion 1)
;  Component-based CMM function selectors 
;  Required 

(defconstant $kCMMOpen -1)                      ;  kComponentOpenSelect,

(defconstant $kCMMClose -2)                     ;  kComponentCloseSelect,

(defconstant $kCMMGetInfo -4)                   ;  kComponentVersionSelect

(defconstant $kNCMMInit 6)
(defconstant $kCMMMatchColors 1)
(defconstant $kCMMCheckColors 2)                ;  Optional 

(defconstant $kCMMValidateProfile 8)
(defconstant $kCMMMatchBitmap 9)
(defconstant $kCMMCheckBitmap 10)
(defconstant $kCMMConcatenateProfiles 5)
(defconstant $kCMMConcatInit 7)
(defconstant $kCMMNewLinkProfile 16)
(defconstant $kNCMMConcatInit 18)
(defconstant $kNCMMNewLinkProfile 19)
(defconstant $kCMMGetPS2ColorSpace 11)
(defconstant $kCMMGetPS2ColorRenderingIntent 12)
(defconstant $kCMMGetPS2ColorRendering 13)
(defconstant $kCMMGetPS2ColorRenderingVMSize 17);  obsolete with ColorSync 2.5 

(defconstant $kCMMFlattenProfile 14)
(defconstant $kCMMUnflattenProfile 15)          ;  obsolete with ColorSync 2.6 

(defconstant $kCMMInit 0)
(defconstant $kCMMGetNamedColorInfo 70)
(defconstant $kCMMGetNamedColorValue 71)
(defconstant $kCMMGetIndNamedColorValue 72)
(defconstant $kCMMGetNamedColorIndex 73)
(defconstant $kCMMGetNamedColorName 74)         ;  obsolete with ColorSync 3.0 

(defconstant $kCMMMatchPixMap 3)
(defconstant $kCMMCheckPixMap 4)

; #if !TARGET_API_MAC_OS8
; 
;    The following declarations specify the calling conventions
;    for non-Component-based CMM entry-points.
; 
; 
;    On TARGET_API_MAC_OSX, cmmInstance is a CFBundleRef
;    On TARGET_OS_WIN32, cmmInstance is a HINSTANCE
; 
; 
;  *  CMMOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMClose()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  NCMMInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMMatchColors()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMCheckColors()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMValidateProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMMatchBitmap()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMCheckBitmap()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMConcatInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  NCMMConcatInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMNewLinkProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  NCMMNewLinkProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMGetPS2ColorSpace()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMGetPS2ColorRenderingIntent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMGetPS2ColorRendering()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CMMGetPS2ColorRenderingVMSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #endif  /* !TARGET_API_MAC_OS8 */


; #if TARGET_OS_WIN32
#| 
; 
;  *  CMMGetCMMInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
 |#

; #endif  /* TARGET_OS_WIN32 */


; #endif /* __CMMCOMPONENT__ */


(provide-interface "CMMComponent")