(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ATSUnicode.h"
; at Sunday July 2,2006 7:24:34 pm.
; 
;      File:       QD/ATSUnicode.h
;  
;      Contains:   Public interfaces for Apple Type Services for Unicode Imaging
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ATSUNICODE__
; #define __ATSUNICODE__
; #ifndef __ATSUNICODETYPES__

(require-interface "QD/ATSUnicodeTypes")

; #endif

; #ifndef __ATSUNICODEOBJECTS__

(require-interface "QD/ATSUnicodeObjects")

; #endif

; #ifndef __ATSUNICODEDRAWING__

(require-interface "QD/ATSUnicodeDrawing")

; #endif

; #ifndef __ATSUNICODEFONTS__

(require-interface "QD/ATSUnicodeFonts")

; #endif

; #ifndef __ATSUNICODEGLYPHS__

(require-interface "QD/ATSUnicodeGlyphs")

; #endif

; #ifndef __ATSUNICODEFLATTENING__

(require-interface "QD/ATSUnicodeFlattening")

; #endif

; #ifndef __ATSUNICODEDIRECTACCESS__

(require-interface "QD/ATSUnicodeDirectAccess")

; #endif


; #endif /* __ATSUNICODE__ */


(provide-interface "ATSUnicode")