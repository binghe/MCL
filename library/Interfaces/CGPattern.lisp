(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGPattern.h"
; at Sunday July 2,2006 7:23:51 pm.
;  CoreGraphics - CGPattern.h
;  * Copyright (c) 2000-2002 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGPATTERN_H_
; #define CGPATTERN_H_

(def-mactype :CGPatternRef (find-mactype '(:pointer :CGPattern)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreGraphics/CGContext")

(require-interface "CoreFoundation/CFBase")
;  kCGPatternTilingNoDistortion: The pattern cell is not distorted when
;  * painted, however the spacing between pattern cells may vary by as much
;  * as 1 device pixel.
;  *
;  * kCGPatternTilingConstantSpacingMinimalDistortion: Pattern cells are
;  * spaced consistently, however the pattern cell may be distorted by as
;  * much as 1 device pixel when the pattern is painted.
;  *
;  * kCGPatternTilingConstantSpacing: Pattern cells are spaced consistently
;  * as with kCGPatternTilingConstantSpacingMinimalDistortion, however the
;  * pattern cell may be distorted additionally to permit a more efficient
;  * implementation. 
(def-mactype :CGPatternTiling (find-mactype ':sint32))

(defconstant $kCGPatternTilingNoDistortion 0)
(defconstant $kCGPatternTilingConstantSpacingMinimalDistortion 1)
(defconstant $kCGPatternTilingConstantSpacing 2)

;type name? (def-mactype :CGPatternTiling (find-mactype ':CGPatternTiling))
;  The drawing of the pattern is delegated to the callbacks.  The callbacks
;  * may be called one or many times to draw the pattern.
;  *
;  * `version' is the version number of the structure passed in as a
;  * parameter to the CGPattern creation functions. The structure defined
;  * below is version 0.
;  *
;  * `drawPattern' should draw the pattern in the context `c'. `info' is the
;  * parameter originally passed to the CGPattern creation functions.
;  *
;  * `releaseInfo' is called when the pattern is deallocated. 

(def-mactype :CGPatternDrawPatternCallback (find-mactype ':pointer)); (void * info , CGContextRef c)

(def-mactype :CGPatternReleaseInfoCallback (find-mactype ':pointer)); (void * info)
(defrecord CGPatternCallbacks
   (version :UInt32)
   (drawPattern :pointer)
   (releaseInfo :pointer)
)

;type name? (%define-record :CGPatternCallbacks (find-record-descriptor ':CGPatternCallbacks))
;  Return the CFTypeID for CGPatternRefs. 

(deftrap-inline "_CGPatternGetTypeID" 
   (
   )
   :UInt32
() )
;  Create a pattern. 

(deftrap-inline "_CGPatternCreate" 
   ((info :pointer)
      ;  :cgpoint
    (x :single-float)
    (y :single-float)  ;  :cgsize
    (width :single-float)
    (height :single-float)
    (a :single-float)
    (b :single-float)
    (c :single-float)
    (d :single-float)
    (tx :single-float)
    (ty :single-float)
    (xStep :single-float)
    (yStep :single-float)
    (tiling :CGPatternTiling)
    (isColored :Boolean)
    (callbacks (:pointer :CGPatternCallbacks))
   )
   (:pointer :CGPattern)
() )
;  Equivalent to `CFRetain(pattern)', except it doesn't crash (as CF does)
;  * if `pattern' is NULL. 

(deftrap-inline "_CGPatternRetain" 
   ((pattern (:pointer :CGPattern))
   )
   (:pointer :CGPattern)
() )
;  Equivalent to `CFRelease(pattern)', except it doesn't crash (as CF does)
;  * if `pattern' is NULL. 

(deftrap-inline "_CGPatternRelease" 
   ((pattern (:pointer :CGPattern))
   )
   nil
() )

; #endif	/* CGPATTERN_H_ */


(provide-interface "CGPattern")