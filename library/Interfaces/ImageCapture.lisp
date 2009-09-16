(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ImageCapture.h"
; at Sunday July 2,2006 7:25:17 pm.
; 
;      File:       ImageCapture/ImageCapture.h
;  
;      Contains:   Image Capture Architecture header
;  
;      Version:    ImageCapture-181~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __IMAGECAPTURE__
; #define __IMAGECAPTURE__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __ICAAPPLICATION__

(require-interface "ImageCapture/ICAApplication")

; #endif

; #ifndef __ICADEVICE__

(require-interface "ImageCapture/ICADevice")

; #endif

; #ifndef __ICACAMERA__

(require-interface "ImageCapture/ICACamera")

; #endif


; #endif /* __IMAGECAPTURE__ */


(provide-interface "ImageCapture")