(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:LaunchServices.h"
; at Sunday July 2,2006 7:24:45 pm.
; 
;      File:       LaunchServices/LaunchServices.h
;  
;      Contains:   Public interfaces for LaunchServices.framework
;  
;      Version:    LaunchServices-98~1
;  
;      Copyright:  © 2001-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __LAUNCHSERVICES__
; #define __LAUNCHSERVICES__
; #ifndef __LSINFO__

(require-interface "LaunchServices/LSInfo")

; #endif

; #ifndef __LSOPEN__

(require-interface "LaunchServices/LSOpen")

; #endif

; #ifndef __UTTYPE__

(require-interface "LaunchServices/UTType")

; #endif


; #endif /* __LAUNCHSERVICES__ */


(provide-interface "LaunchServices")