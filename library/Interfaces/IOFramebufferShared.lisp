(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFramebufferShared.h"
; at Sunday July 2,2006 7:28:49 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _IOKIT_IOFRAMEBUFFERSHARED_H
; #define _IOKIT_IOFRAMEBUFFERSHARED_H

(require-interface "IOKit/hidsystem/IOHIDTypes")

(require-interface "IOKit/graphics/IOGraphicsTypes")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; ! @header IOFramebufferShared
; The IOFramebufferShared.h header contains definitions of objects and types shared between a kernel level IOFrameBuffer service and a non-kernel window server. In Mac OS X this structure is used by the CoreGraphics server and IOGraphics Family, and is not available to other clients. IOFramebuffer subclasses and IOFramebuffer clients within the kernel should also not rely on this structure definition and constants. It is public only for use on Darwin based window servers. Cursor and window server state data is exchanged by kernel and non-kernel tasks through a slice of shared memory containing a StdFBShmem_t structure.<br>
; For a non-kernel task to get access to this slice of shared memory, a connection to an IOFramebuffer service must be made. A connection is made with the IOServiceOpen() function described in IOKitLib.h. A connection type of kIOFBServerConnectType or kIOFBSharedConnectType (for read-only access) should be specified. An io_connect_t handle is returned by IOServiceOpen(). This handle must be passed to IOFBCreateSharedCursor() to create the slice of shared memory. Then IOConnectMapMemory() may be called with a memory type of kIOFBCursorMemory to map the shared memory into the non-kernel task.
; 
; #ifdef KERNEL
#| #|

#define IOFB_ARBITRARY_SIZE_CURSOR
#define IOFB_ARBITRARY_FRAMES_CURSOR	1
#endif
|#
 |#
; #define IOFB_SUPPORTS_XOR_CURSOR
; #define IOFB_SUPPORTS_HW_SHIELD
; #define IOFB_SUPPORTS_ARBITRARY_FRAMES_CURSOR
; 
;  Cursor and Window Server state data, occupying a slice of shared memory
;  between the kernel and WindowServer.
; 
; ! @enum CursorParameters
;     @constant kIOFBNumCursorFrames The number of cursor images stored in the StdFBShmem_t structure.
;     @constant kIOFBNumCursorFramesShift Used with waiting cursors.
;     @constant kIOFBMaxCursorDepth The maximum cursor pixel depth.
; 

; #if IOFB_ARBITRARY_FRAMES_CURSOR
#| 
(defconstant $kIOFBMainCursorIndex 0)
(defconstant $kIOFBWaitCursorIndex 1)
(defconstant $kIOFBNumCursorIndex 4)
 |#

; #else

(defconstant $kIOFBNumCursorFrames 4)
(defconstant $kIOFBNumCursorFramesShift 2)
; #endif


(defconstant $kIOFBMaxCursorDepth 32)
; #ifndef IOFB_ARBITRARY_SIZE_CURSOR
; ! @defined CURSORWIDTH
;     @discussion The maximum width of the cursor image in pixels. This is only defined if IOFB_ARBITRARY_SIZE_CURSOR is not defined.
; 
(defconstant $CURSORWIDTH 16)
; #define CURSORWIDTH  16         /* width in pixels */
; ! @defined CURSORHEIGHT
;     @discussion The maximum height of the cursor image in pixels. This is only defined if IOFB_ARBITRARY_SIZE_CURSOR is not defined.
; 
(defconstant $CURSORHEIGHT 16)
; #define CURSORHEIGHT 16         /* height in pixels */
; ! @struct bm12Cursor
;     @abstract Cursor image for 1-bit cursor.
;     @discussion This structure stores 16 pixel x 16 pixel cursors to be used with 1-bit color depth. This structure is only defined if IOFB_ARBITRARY_SIZE_CURSOR is not defined.
;     @field image This array contains the cursor images.
;     @field mask This array contains the cursor mask.
;     @field save This array stores the pixel values of the region underneath the cursor in its last drawn position.
; 
(defrecord bm12Cursor
   (image (:array :UInt32 64))
   (mask (:array :UInt32 64))
   (save (:array :UInt32 16))
)
; ! @struct bm18Cursor
;     @abstract Cursor image for 8-bit cursor.
;     @discussion This structure stores 16 pixel x 16 pixel cursors to be used with 8-bit color depth. This structure is only defined if IOFB_ARBITRARY_SIZE_CURSOR is not defined.
;     @field image This array contains cursor color values, which are converted to displayed colors through the color table. The array is two dimensional and its first index is the cursor frame and the second index is the cursor pixel.
;     @field mask This array contains the cursor alpha mask. The array is two dimensional with the same indexing as the image. If an alpha mask pixel is 0 and the corresponding image pixel is set to white for the display, then this cursor pixel will invert pixels on the display.
;     @field save This array stores the color values of the region underneath the cursor in its last drawn position.
; 
(defrecord bm18Cursor
   (image (:array :UInt8 1024))
   (mask (:array :UInt8 1024))
   (save (:array :UInt8 256))
)
; ! @struct bm34Cursor
;     @abstract Cursor image for 15-bit cursor.
;     @discussion This structure stores 16 pixel x 16 pixel cursors to be used with 15-bit color depth. This structure is only defined if IOFB_ARBITRARY_SIZE_CURSOR is not defined.
;     @field image This array defines the cursor color values and transparency. The array is two dimensional and its first index is the cursor frame and the second index is the cursor pixel. A value of 0 means the pixel is transparent. Non-zero values are stored with the red, green, blue, and alpha values encoded with the following masks:<BR>
;     red mask = 0xF000<br>
;     blue mask 0x0F00<br>
;     green mask 0x00F0<br>
;     alpha mask = 0x000F<br>
; Note, only 4 bits are allocated for each color component.
;     @field save This array stores the color values of the region underneath the cursor in its last drawn position.
; 
(defrecord bm34Cursor
   (image (:array :UInt16 1024))
   (save (:array :UInt16 256))
)
; ! @struct bm38Cursor
;     @abstract Cursor image for 24-bit cursor.
;     @discussion This structure stores 16 pixel x 16 pixel cursors to be used with 24-bit color depth. This structure is only defined if IOFB_ARBITRARY_SIZE_CURSOR is not defined.
;     @field image This array defines the cursor color values and transparency. The array is two dimensional and its first index is the cursor frame and the second index is the cursor pixel. The lower 24 bits of a pixel's value contain the RGB color, while the upper 8 bits contain the alpha value.
;     @field save This array stores the color values of the region underneath the cursor in its last drawn position.
; 
(defrecord bm38Cursor
   (image (:array :UInt32 1024))
   (save (:array :UInt32 256))
)

; #endif /* IOFB_ARBITRARY_SIZE_CURSOR */


(defconstant $kIOFBCursorImageNew 1)
(defconstant $kIOFBCursorHWCapable 2)

(defconstant $kIOFBHardwareCursorActive 1)
(defconstant $kIOFBHardwareCursorInVRAM 2)
; ! @struct StdFBShmem_t
;     @discussion This structure contains cursor and window server state data and occupies a slice of shared memory between the kernel and window server. Several elements of this structure are only used in software cursor mode. Unless otherwise indicated, the coordinates in this structure are given in display space. Display space is the coordinate space that encompasses all the screens. The positions of the screens within display space indicate their location relative to each other as the cursor moves between them. If there is only one screen, the screen coordinates and display space coordinates will be the same.
;     @field cursorSema Semaphore lock for write access to the shared data in this structure.
;     @field frame The current cursor frame index.
;     @field cursorShow The cursor is displayed when cursorShow is 0.
;     @field cursorObscured If this is true, the cursor has been obscured and cursorShow should not be 0. The cursor will be shown again the next time it is moved.
;     @field shieldFlag When this is set to true the cursor will not be displayed in the region specified by shieldRect.
;     @field shielded True if the cursor has been hidden because it entered the shielded region.
;     @field saveRect The region that is saved underneath the cursor in software cursor mode.
;     @field shieldRect The region that the cursor will not be displayed in if shieldFlag is true.
;     @field cursorLoc The location of the cursor hot spot.
;     @field cursorRect The region that the cursor image currently occupies in software cursor mode.
;     @field oldCursorRect The region that the cursor image occupied the last time the cursor was drawn in software cursor mode.
;     @field screenBounds The region that the current screen occupies.
;     @field version Contains kIOFBCurrentShmemVersion so that a user client can ensure it is using the same version of this structure as the kernel.
;     @field structSize Contains the size of this structure.
;     @field vblTime The time of the most recent vertical blanking.
;     @field vblDelta The interval between the two most recent vertical blankings.
;     @field reservedC Reserved for future use.
;     @field hardwareCursorCapable True if the hardware is capable of using hardware cursor mode.
;     @field hardwareCursorActive True if currently using the hardware cursor mode.
;     @field reservedB Reserved for future use.
;     @field cursorSize This array contains the cursor sizes indexed by frame.
;     @field hotSpot This array contains the location of the cursor hot spots indexed by frame. The hot spots coordinates are given relative to the top left corner of the cursor image.
;     @field cursor A union of structures that define the cursor images. The structure used depends on the framebuffer's bit depth. These structures are defined above.
; 
(defrecord StdFBShmem_t
   (cursorSema :signed-long)
   (frame :signed-long)
   (cursorShow :character)
   (cursorObscured :character)
   (shieldFlag :character)
   (shielded :character)
   (saveRect :IOGBounds)
   (shieldRect :IOGBounds)
   (cursorLoc :IOGPoint)
   (cursorRect :IOGBounds)
   (oldCursorRect :IOGBounds)
   (screenBounds :IOGBounds)
   (version :signed-long)
   (structSize :signed-long)
   (vblTime :UnsignedWide)
   (vblDelta :UnsignedWide)

; #if IOFB_ARBITRARY_FRAMES_CURSOR
#|    (reservedC (:array :UInt32 30))
 |#

; #else
   (reservedC (:array :UInt32 29))
   (hardwareCursorFlags (:array :UInt8 4))

; #endif

   (hardwareCursorCapable :UInt8)
   (hardwareCursorActive :UInt8)
   (hardwareCursorShields :UInt8)
   (reservedB (:array :UInt8 1))

; #if IOFB_ARBITRARY_FRAMES_CURSOR
#|    (cursorSize (:array :IOGSize 4))
   (hotSpot (:array :IOGPoint 4))
 |#

; #else
   (cursorSize (:array :IOGSize 4))
   (hotSpot (:array :IOGPoint 4))

; #endif

; #ifndef IOFB_ARBITRARY_SIZE_CURSOR
   (:variant
   (
   (bw :BM12CURSOR)
   )
   (
   (bw8 :BM18CURSOR)
   )
   (
   (rgb :BM34CURSOR)
   )
   (
   (rgb24 :BM38CURSOR)
   )
   )
#| 
; #else  /* IOFB_ARBITRARY_SIZE_CURSOR */
   (cursor (:array :UInt8 0))
 |#

; #endif /* IOFB_ARBITRARY_SIZE_CURSOR */

)
; #ifndef __cplusplus

;type name? (%define-record :StdFBShmem_t (find-record-descriptor ':StdFBShmem_t))

; #endif

; ! @enum FramebufferConstants
;     @constant kIOFBCurrentShmemVersion The current version of the slice of shared memory that contains the cursor and window server state data in the StdFBShmem_t structure.
;     @constant kIOFBCursorMemory The memory type for IOConnectMapMemory() to get a slice of shared memory that contains the StdFBShmem_t structure.
;     @constant kIOFBVRAMMemory The memory type for IOConnectMapMemory() to get the VRAM memory. Use a memory type equal to the IOPixelAperture index to get a particular pixel aperture.
; 
;  version for IOFBCreateSharedCursor

(defconstant $kIOFBShmemVersionMask #xFF)
(defconstant $kIOFBTenPtOneShmemVersion 2)
(defconstant $kIOFBTenPtTwoShmemVersion 3)
(defconstant $kIOFBCurrentShmemVersion 2)       ;  number of frames in animating cursor (if > kIOFBTenPtTwoShmemVersion)

(defconstant $kIOFBShmemCursorNumFramesMask #xFF0000)
(defconstant $kIOFBShmemCursorNumFramesShift 16);  memory types for IOConnectMapMemory.
;  0..n are apertures

(defconstant $kIOFBCursorMemory 100)
(defconstant $kIOFBVRAMMemory 110)
; ! @defined IOFRAMEBUFFER_CONFORMSTO
;     @discussion The class name of the framebuffer service.
; 
(defconstant $IOFRAMEBUFFER_CONFORMSTO "IOFramebuffer")
; #define IOFRAMEBUFFER_CONFORMSTO	"IOFramebuffer"
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* ! _IOKIT_IOFRAMEBUFFERSHARED_H */


(provide-interface "IOFramebufferShared")