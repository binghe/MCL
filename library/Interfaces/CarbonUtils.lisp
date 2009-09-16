(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CarbonUtils.h"
; at Sunday July 2,2006 7:27:16 pm.
; 
;     CarbonUtils.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.
;     
;     Public header file.
; 
; #ifndef __HIWEBCARBONUTILS__
; #define __HIWEBCARBONUTILS__

; #import <Carbon/Carbon.h>

; #import <WebKit/WebKit.h>
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(deftrap-inline "_WebInitForCarbon" 
   (
   )
   nil
() )

(deftrap-inline "_WebConvertNSImageToCGImageRef" 
   ((inImage (:pointer :nsimage))
   )
   (:pointer :CGImage)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif // __HIWEBCARBONUTILS__


(provide-interface "CarbonUtils")