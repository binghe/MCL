(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:HIWebView.h"
; at Sunday July 2,2006 7:27:55 pm.
; 
;     HIWebView.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.
;     
;     Public header file.
; 
; #ifndef __HIWebView__
; #define __HIWebView__

(require-interface "WebKit/WebView")

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; 
;  *  HIWebViewCreate()
;  *  
;  *  Summary:
;  *    Creates a new web view.
;  *  
;  *  Parameters:
;  *    
;  *    outControl:
;  *      The new web view.
;  *  
;  *  Result:
;  *    An operating system status code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2.7 and later
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIWebViewCreate" 
   ((outControl (:pointer :HIVIEWREF))
   )
   :OSStatus
() )
; 
;  *  HIWebViewGetWebView()
;  *  
;  *  Summary:
;  *    Returns the WebKit WebView for a given HIWebView.
;  *  
;  *  Parameters:
;  *    
;  *    inView:
;  *      The view to inspect.
;  *  
;  *  Result:
;  *    A pointer to a web view object, or NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2.7 and later
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HIWebViewGetWebView" 
   ((inView (:pointer :OpaqueControlRef))
   )
   (:pointer :webview)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __HIWebView__ */


(provide-interface "HIWebView")