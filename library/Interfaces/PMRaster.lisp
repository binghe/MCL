(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMRaster.h"
; at Sunday July 2,2006 7:31:15 pm.
; 
;      File:       PMRaster.h
;  
;      Contains:   Mac OS X Printing Manager Raster Definitions.
;  
;      Version:    Technology: Mac OS X
;                  Release:    1.0
;  
;      Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PMRASTER__
; #define __PMRASTER__

(require-interface "ApplicationServices/ApplicationServices")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  MIME type for our raster format (will move to PMDefinitions.h) 
; #define kPMDataFormatRaster     CFSTR( "application/vnd.apple.printing-raster" )

(def-mactype :PMPixelLayout (find-mactype ':UInt32))

(defconstant $kPMDataPlanar 1)                  ;  One color for all pixels, followed by next color. 

(defconstant $kPMDataChunky 2)                  ;  All colors for each pixel before next pixel. 

(defconstant $kPMDataUnused #xFFFC)             ;  Remaining bits not used at this time. 

;  Pixel formats supported at this time: 

(def-mactype :PMPixelFormat (find-mactype ':UInt32))

(defconstant $kPMGray_1 1)                      ;  1 bit gray scale (B/W) data only (not implemented). 

(defconstant $kPMGray_8 2)                      ;  8 bit grayscale. 256 possible values, no color table assumed 

(defconstant $kPMRGB_16 4)                      ;  16 bit, 5-5-5 RGB data, with MSB unused. 

(defconstant $kPMRGB_24 8)                      ;  24 bit, 8-8-8 RGB data, no unused bits or bytes. 

(defconstant $kPMXRGB_32 16)                    ;  32 bit x-8-8-8 RGB data, first byte unused in each pixel. 

(defconstant $kPMRGBX_32 32)                    ;  32 bit 8-8-8-x RGB data, last byte unused in each pixel. 

(defconstant $kPMRGBX_32_Sep_Gray_8 64)         ;  Same as kPMRGBX_32 but with an extra plane of 8-bit K-separation. 

(defconstant $kPMCMYK_32 #x80)                  ;  32 bit 8-8-8-8 CMYK data. All bytes used. 

(defconstant $kPMUnused #xFF00)                 ;  Remaining bits are unused for now and should be clear. 


(def-mactype :PMBandOrder (find-mactype ':UInt32))

(defconstant $kPMFirstBand 0)                   ;  First band of the frame 

(defconstant $kPMMiddleBand 1)                  ;  Mid-pack band 

(defconstant $kPMLastBand 2)                    ;  Last band 

(defconstant $kPMLoneBand 3)                    ;  The only band (whole frame) 

;  PMRasterBand: 
(defrecord PMRasterBand
   (baseAddress :pointer)                       ;  ptr to where data is stored 
   (size :UInt32)                               ;  #bytes in band      
   (yOffset :UInt32)                            ;  Band position in the page.  
   (height :UInt32)                             ;  How many scanlines in this band. 
   (depth :UInt32)                              ;  How many bits per pixel for this band. 
   (order :UInt32)                              ;  band order in page: first, middle, last, lone. 
)

;type name? (%define-record :PMRasterBand (find-record-descriptor ':PMRasterBand))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMRASTER__ */


(provide-interface "PMRaster")