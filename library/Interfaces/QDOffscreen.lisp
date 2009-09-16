(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QDOffscreen.h"
; at Sunday July 2,2006 7:24:30 pm.
; 
;      File:       QD/QDOffscreen.h
;  
;      Contains:   Quickdraw Offscreen GWorld Interfaces.
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QDOFFSCREEN__
; #define __QDOFFSCREEN__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __QUICKDRAW__
#| #|
#include <QDQuickdraw.h>
#endif
|#
 |#

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
;     NOTE:  With the exception of noNewDeviceBit and nativeEndianPixMapBit,
;            he following definitions for the GWorldFlags parameter in NewGWorld
;            are all obsolete on Mac OS X, and ignored.
; 

(defconstant $pixPurgeBit 0)
(defconstant $noNewDeviceBit 1)
(defconstant $useTempMemBit 2)
(defconstant $keepLocalBit 3)
(defconstant $useDistantHdwrMemBit 4)
(defconstant $useLocalHdwrMemBit 5)
(defconstant $pixelsPurgeableBit 6)
(defconstant $pixelsLockedBit 7)
(defconstant $nativeEndianPixMapBit 8)
(defconstant $mapPixBit 16)
(defconstant $newDepthBit 17)
(defconstant $alignPixBit 18)
(defconstant $newRowBytesBit 19)
(defconstant $reallocPixBit 20)
(defconstant $clipPixBit 28)
(defconstant $stretchPixBit 29)
(defconstant $ditherPixBit 30)
(defconstant $gwFlagErrBit 31)

(defconstant $pixPurge 1)
(defconstant $noNewDevice 2)
(defconstant $useTempMem 4)
(defconstant $keepLocal 8)
(defconstant $useDistantHdwrMem 16)
(defconstant $useLocalHdwrMem 32)
(defconstant $pixelsPurgeable 64)
(defconstant $pixelsLocked #x80)
(defconstant $kNativeEndianPixMap #x100)
(defconstant $kAllocDirectDrawSurface #x4000)
(defconstant $mapPix #x10000)
(defconstant $newDepth #x20000)
(defconstant $alignPix #x40000)
(defconstant $newRowBytes #x80000)
(defconstant $reallocPix #x100000)
(defconstant $clipPix #x10000000)
(defconstant $stretchPix #x20000000)
(defconstant $ditherPix #x40000000)
(defconstant $gwFlagErr #x80000000)

(def-mactype :GWorldFlags (find-mactype ':UInt32))
;  Type definition of a GWorldPtr 

(def-mactype :GWorldPtr (find-mactype ':CGrafPtr))
; 
;  *  NewGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewGWorld" 
   ((offscreenGWorld (:pointer :GWORLDPTR))
    (PixelDepth :SInt16)
    (boundsRect (:pointer :Rect))
    (cTable (:Handle :ColorTable))              ;  can be NULL 
    (aGDevice (:Handle :GDEVICE))               ;  can be NULL 
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  GDevice attribute bits for Carbon and QuickTime 3.0

(defconstant $deviceIsIndirect 1)
(defconstant $deviceNeedsLock 2)
(defconstant $deviceIsStatic 4)
(defconstant $deviceIsExternalBuffer 8)
(defconstant $deviceIsDDSurface 16)
(defconstant $deviceIsDCISurface 32)
(defconstant $deviceIsGDISurface 64)
(defconstant $deviceIsAScreen #x80)
(defconstant $deviceIsOverlaySurface #x100)

; #if TARGET_OS_WIN32
#| 
; 
;  *  GetGDeviceSurface()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  GetGDeviceAttributes()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
;  to allocate non-mac-rgb GWorlds use QTNewGWorld (ImageCompression.h) 
; 
;  *  NewGWorldFromHBITMAP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
 |#

; #endif  /* TARGET_OS_WIN32 */

; 
;  *  NewGWorldFromPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewGWorldFromPtr" 
   ((offscreenGWorld (:pointer :GWORLDPTR))
    (PixelFormat :UInt32)
    (boundsRect (:pointer :Rect))
    (cTable (:Handle :ColorTable))              ;  can be NULL 
    (aGDevice (:Handle :GDEVICE))               ;  can be NULL 
    (flags :UInt32)
    (newBuffer :pointer)
    (rowBytes :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  LockPixels()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LockPixels" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  UnlockPixels()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UnlockPixels" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  UpdateGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UpdateGWorld" 
   ((offscreenGWorld (:pointer :GWORLDPTR))
    (pixelDepth :SInt16)
    (boundsRect (:pointer :Rect))
    (cTable (:Handle :ColorTable))
    (aGDevice (:Handle :GDEVICE))               ;  can be NULL 
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  DisposeGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeGWorld" 
   ((offscreenGWorld (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetGWorld" 
   ((port (:pointer :CGrafPtr))
    (gdh (:pointer :GDHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetGWorld" 
   ((port (:pointer :OpaqueGrafPtr))
    (gdh (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CTabChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CTabChanged" 
   ((ctab (:Handle :ColorTable))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PixPatChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PixPatChanged" 
   ((ppat (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PortChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PortChanged" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GDeviceChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GDeviceChanged" 
   ((gdh (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AllowPurgePixels()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AllowPurgePixels" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NoPurgePixels()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NoPurgePixels" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPixelsState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPixelsState" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  SetPixelsState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetPixelsState" 
   ((pm (:Handle :PixMap))
    (state :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPixBaseAddr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPixBaseAddr" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :pointer
() )
; 
;  *  GetPixRowBytes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_GetPixRowBytes" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  NewScreenBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewScreenBuffer" 
   ((globalRect (:pointer :Rect))
    (purgeable :Boolean)
    (gdh (:pointer :GDHANDLE))
    (offscreenPixMap (:pointer :PIXMAPHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  DisposeScreenBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeScreenBuffer" 
   ((offscreenPixMap (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetGWorldDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetGWorldDevice" 
   ((offscreenGWorld (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  QDDone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_QDDone" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OffscreenVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OffscreenVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  NewTempScreenBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewTempScreenBuffer" 
   ((globalRect (:pointer :Rect))
    (purgeable :Boolean)
    (gdh (:pointer :GDHANDLE))
    (offscreenPixMap (:pointer :PIXMAPHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  PixMap32Bit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PixMap32Bit" 
   ((pmHandle (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetGWorldPixMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetGWorldPixMap" 
   ((offscreenGWorld (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixMap)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QDOFFSCREEN__ */


(provide-interface "QDOffscreen")