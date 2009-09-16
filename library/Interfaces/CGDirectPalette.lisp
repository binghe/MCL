(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGDirectPalette.h"
; at Sunday July 2,2006 7:24:00 pm.
; 
;  *  CGDirectPalette.h
;  *  CoreGraphics
;  *
;  *  Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __CGDIRECT_PALETTE_H__
(defconstant $__CGDIRECT_PALETTE_H__ 1)
; #define __CGDIRECT_PALETTE_H__ 1

(require-interface "CoreGraphics/CGDirectDisplay")

(def-mactype :CGPaletteBlendFraction (find-mactype ':single-float))
;  A value between 0.0 and 1.0 
; 
;  * Convenient device color representation
;  *
;  * Values should be in the range from 0.0 to 1.0, where 0.0 is black, and 1.0
;  * is full on for each channel.
;  
(defrecord _CGDeviceColor
   (red :single-float)
   (green :single-float)
   (blue :single-float)
)

(%define-record :CGDeviceColor (find-record-descriptor ':_CGDeviceColor))
(defrecord _CGDeviceByteColor
   (red :UInt8)
   (green :UInt8)
   (blue :UInt8)
)

(%define-record :CGDeviceByteColor (find-record-descriptor ':_CGDeviceByteColor))
; 
;  * Create a new palette object representing the default 8 bit color palette.
;  * Release the palette using CGPaletteRelease().
;  

(deftrap-inline "_CGPaletteCreateDefaultColorPalette" 
   (
   )
   (:pointer :_CGDirectPaletteRef)
() )
; 
;  * Create a copy of the display's current palette, if any.
;  * Returns NULL if the current display mode does not support a palette.
;  * Release the palette using CGPaletteRelease().
;  

(deftrap-inline "_CGPaletteCreateWithDisplay" 
   ((display (:pointer :_CGDirectDisplayID))
   )
   (:pointer :_CGDirectPaletteRef)
() )
; 
;  * Create a new palette with a capacity as specified.  Entries are initialized from
;  * the default color palette.  Release the palette using CGPaletteRelease().
;  

(deftrap-inline "_CGPaletteCreateWithCapacity" 
   ((capacity :UInt32)
   )
   (:pointer :_CGDirectPaletteRef)
() )
; 
;  * Create a new palette with a capacity and contents as specified.
;  * Release the palette using CGPaletteRelease().
;  

(deftrap-inline "_CGPaletteCreateWithSamples" 
   ((sampleTable (:pointer :CGDEVICECOLOR))
    (sampleCount :UInt32)
   )
   (:pointer :_CGDirectPaletteRef)
() )
; 
;  * Convenience function:
;  * Create a new palette with a capacity and contents as specified.
;  * Release the palette using CGPaletteRelease().
;  

(deftrap-inline "_CGPaletteCreateWithByteSamples" 
   ((sampleTable (:pointer :CGDEVICEBYTECOLOR))
    (sampleCount :UInt32)
   )
   (:pointer :_CGDirectPaletteRef)
() )
; 
;  * Release a palette
;  

(deftrap-inline "_CGPaletteRelease" 
   ((palette (:pointer :_CGDirectPaletteRef))
   )
   :void
() )
; 
;  * Get the color value at the specified index
;  

(deftrap-inline "_CGPaletteGetColorAtIndex" 
   ((returnArg (:pointer :_CGDeviceColor))
    (palette (:pointer :_CGDirectPaletteRef))
    (index :UInt32)
   )
   nil
() )
; 
;  * Get the index for the specified color value
;  * The index returned is for a palette color with the
;  * lowest RMS error to the specified color.
;  

(deftrap-inline "_CGPaletteGetIndexForColor" 
   ((palette (:pointer :_CGDirectPaletteRef))
    (red :single-float)
    (green :single-float)
    (blue :single-float)
   )
   :UInt32
() )
; 
;  * Get the number of samples in the palette
;  

(deftrap-inline "_CGPaletteGetNumberOfSamples" 
   ((palette (:pointer :_CGDirectPaletteRef))
   )
   :UInt32
() )
; 
;  * Set the color value at the specified index
;  

(deftrap-inline "_CGPaletteSetColorAtIndex" 
   ((palette (:pointer :_CGDirectPaletteRef))
    (red :single-float)
    (green :single-float)
    (blue :single-float)
    (index :UInt32)
   )
   :void
() )
; 
;  * Copy a palette
;  

(deftrap-inline "_CGPaletteCreateCopy" 
   ((palette (:pointer :_CGDirectPaletteRef))
   )
   (:pointer :_CGDirectPaletteRef)
() )
; 
;  * Compare two palettes
;  

(deftrap-inline "_CGPaletteIsEqualToPalette" 
   ((palette1 (:pointer :_CGDirectPaletteRef))
    (palette2 (:pointer :_CGDirectPaletteRef))
   )
   :Boolean
() )
; 
;  * Create a new palette blended with a fraction of a device color.
;  * Free the resulting palette with CGPaletteRelease()
;  

(deftrap-inline "_CGPaletteCreateFromPaletteBlendedWithColor" 
   ((palette (:pointer :_CGDirectPaletteRef))
    (fraction :single-float)
    (red :single-float)
    (green :single-float)
    (blue :single-float)
   )
   (:pointer :_CGDirectPaletteRef)
() )

; #endif /* __CGDIRECT_PALETTE_H__ */


(provide-interface "CGDirectPalette")