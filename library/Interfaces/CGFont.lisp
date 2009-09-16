(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGFont.h"
; at Sunday July 2,2006 7:23:51 pm.
;  CoreGraphics - CGFont.h
;  * Copyright (c) 1999-2002 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGFONT_H_
; #define CGFONT_H_

(def-mactype :CGFontRef (find-mactype '(:pointer :CGFont)))

(def-mactype :CGFontIndex (find-mactype ':UInt16))

(def-mactype :CGGlyph (find-mactype ':UInt16))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreFoundation/CFBase")

(require-interface "limits")

(require-interface "stdbool")

(require-interface "stddef")

(defconstant $kCGFontIndexMax #xFFFE)           ;  Always <= USHRT_MAX - 1 

(defconstant $kCGFontIndexInvalid #xFFFF)       ;  Always <= USHRT_MAX 

(defconstant $kCGGlyphMax #xFFFE)
;  Return the CFTypeID for CGFontRefs. 

(deftrap-inline "_CGFontGetTypeID" 
   (
   )
   :UInt32
() )
;  Create a CGFont using `platformFontReference', a pointer to a
;  * platform-specific font reference.  For MacOS X, `platformFontReference'
;  * should be a pointer to an ATSFontRef. 

(deftrap-inline "_CGFontCreateWithPlatformFont" 
   ((platformFontReference :pointer)
   )
   (:pointer :CGFont)
() )
;  Equivalent to `CFRetain(font)'. 

(deftrap-inline "_CGFontRetain" 
   ((font (:pointer :CGFont))
   )
   (:pointer :CGFont)
() )
;  Equivalent to `CFRelease(font)'. 

(deftrap-inline "_CGFontRelease" 
   ((font (:pointer :CGFont))
   )
   nil
() )
;  Obsolete; don't use these. 

(defconstant $CGGlyphMin 0)
(defconstant $CGGlyphMax #xFFFE)

; #endif	/* CGFONT_H_ */


(provide-interface "CGFont")