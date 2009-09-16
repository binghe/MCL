(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHIDShared.h"
; at Sunday July 2,2006 7:29:20 pm.
; 
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * Copyright (c) 1999-2003 Apple Computer, Inc.  All Rights Reserved.
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; *****************************************************************************
; 
;     evio.h
;     Ioctl calls for the events driver
;     Leovitch 02Jan88
;     
;     Copyright 1988 NeXT, Inc.
;     
; 	CAUTION: Developers should stick to the API exported in
; 		<drivers/event_status_driver.h> to guarantee
; 		binary compatability of their applications in future
; 		releases.
; 
;     Modified:
;     
;     09Dec88 Leo  Broken out from evsio.h
;     24Aug89 Ted  ANSI function prototyping.
;     19Feb90 Ted  Major revision for multiple driver support.
;     26Feb90 Ted  New evioScreen structure and EVIOST ioctl.
;     12Mar90 Ted  New ev_unregister_screen function, SCREENTOKEN constant.
;     06May90 Ted  Added AALastEventSent and AALastEventConsumed to EvVars.
;     22May90 Trey More wait cursor vars in EvVars.
;     13Jun90 Ted  NXCursorData structure.
;     18Jun90 Ted  Default wait cursor constants.
;     26Sep90 Ted  Enhanced cursor system to support intelligent drivers.
;     26Nov90 Ted  Removed NXSaveCursor and NXCursorData structures
;     28Nov90 Ted  Remove EvVars, rolled into EventGlobals
;     28Nov90 Ted  Renamed EventGlobals -> EvGlobals, eventGlobals -> evg
;     05May92 Mike Reworked for NRW driver architecture.
; 
; *****************************************************************************
; #ifndef _DEV_EVIO_H
; #define _DEV_EVIO_H

(require-interface "sys/cdefs")

; #if KERNEL
#| |#

(require-interface "IOKit/system")

#|
 |#

; #else /* !KERNEL */

(require-interface "mach/message")

(require-interface "IOKit/IOKitLib")

; #endif /* KERNEL */


(require-interface "IOKit/IOReturn")

(require-interface "IOKit/graphics/IOGraphicsTypes")

(require-interface "IOKit/hidsystem/IOHIDTypes")

(require-interface "IOKit/hidsystem/IOLLEvent")
; 
;  * Identify this driver as one that uses the new driverkit and messaging API
;  
; #ifndef _NeXT_MACH_EVENT_DRIVER_
#| #|
#define _NeXT_MACH_EVENT_DRIVER_	(1)
#endif
|#
 |#
;  _NeXT_MACH_EVENT_DRIVER_ 
;  Pressure Constants 
; #define MINPRESSURE EV_MINPRESSURE
; #define MAXPRESSURE EV_MAXPRESSURE
(defconstant $LLEQSIZE 240)
; #define	LLEQSIZE 240	/* Entries in low-level event queue */
(defrecord _NXEQElStruct
   (next :signed-long)
                                                ;  Slot of lleq for next event 
   (sema :signed-long)                          ;  Is high-level code reading this event now? 
   (event :nxevent)
#|
; Warning: type-size: unknown type NXEVENT
|#
                                                ;  The event itself 
)
(%define-record :NXEQElement (find-record-descriptor :_NXEQELSTRUCT))
; *****************************************************************************
;     SHARED MEMORY OVERVIEW
;     
;     PERSPECTIVE
;     The ev driver and PostScript share at least one page of wired memory.
;     This memory contains the low-level event queue which ev deposits events
;     into and PostScript reads events from. Also, this memory contains other
;     important data such as wait cursor state and some general cursor state.
;     This memory is critical for speed.  That is, we avoid having to make
;     system calls for common operations.
;     
;     SHARED MEMORY REGIONS
;     There are currently three "regions" or "zones" delineated within this
;     shared memory.  The first zone is the EvOffsets structure. This structure
;     contains two offsets from the beginning of shared memory. The first offset
;     is to the second zone, EvGlobals. The second offset is to the third
;     zone, private shmem for drivers.
;     
;     INITIALIZATION OF SHARED MEMORY
;     When the WindowServer starts up, it finds all screens that will be active.
;     It then opens the ev driver and calls the EVIOSSCR ioctl repeatedly for
;     each screen in use. This lets the ev driver set up the evScreen array
;     and fill in each element. This ioctl also returns to PostScript a running
;     total shared memory size with which to allocate. PostScript then allocates
;     a region of memory this size and calls evmmap to "map in" this shared
;     region.  Evmmap initializes and fills in the EvOffsets and EvGlobals.
;     Next the WindowServer calls each screen in turn to register itself with
;     the ev driver in the same sequence as presented to EVIOSSCR.  Each screen
;     driver calls ev_register_screen() which among other things allocates a
;     part of the private shmem (of the third shared memory zone) for the driver.
;     
;     DEBUGGING NOTES
;     You can easily display and set this shared memory from kgdb, but usually
;     cannot do so from within PostScript.  Gdb (or some weird interaction
;     between gdb and the os) chokes on this shmem.  So if you read or write
;     this area of memory, copy-on-write will occur and you'll get a completely
;     new page for PostScript.  This will render the shared memory scheme
;     useless and you will have to restart PostScript.  It was my understanding
;     that before, we were able to "read" this area from PS, but not write to
;     it (the idea behind copy-on-WRITE).  However, this seems to be broken
;     in 2.0.  We think this is a kernel bug.
; *****************************************************************************
(defrecord _evOffsets
   (evGlobalsOffset :signed-long)
                                                ;  Offset to EvGlobals structure 
   (evShmemOffset :signed-long)
                                                ;  Offset to private shmem regions 
)
(%define-record :EvOffsets (find-record-descriptor :_EVOFFSETS))
; *****************************************************************************
;     EvGlobals
;     This structures defines the portion of the events driver data structure
;     that is exported to the PostScript server. It contains the event queue
;     which is in memory shared between the driver and the PostScript server.
;     All the variables necessary to read and process events from the queue are
;     contained here.
; *****************************************************************************
(defrecord _evGlobals
   (cursorSema :signed-long)
                                                ;  set to disable periodic code 
   (LLEHead :signed-long)
                                                ;  The next event to be read 
   (LLETail :signed-long)
                                                ;  Where the next event will go 
   (LLELast :signed-long)
                                                ;  The last event entered 
   (eNum :signed-long)
                                                ;  Unique id for mouse events 
   (buttons :signed-long)
                                                ;  State of the mouse buttons 1==down, 0==up 
   (eventFlags :signed-long)
                                                ;  The current value of event.flags 
   (VertRetraceClock :signed-long)
                                                ;  The current value of event.time 
   (cursorLoc :IOGPoint)
                                                ;  The current location of the cursor 
   (frame :signed-long)
                                                ;  current cursor frame 
   (workBounds :IOGBounds)
                                                ;  bounding box of all screens 
   (mouseRect :IOGBounds)
                                                ;  Rect for mouse-exited events 
   (version :signed-long)
                                                ;  for run time checks 
   (structSize :signed-long)
                                                ;  for run time checks 
   (lastFrame :signed-long)
   (reservedA (:array :UInt32 31))
   (reserved (:pointer :callback))              ;(UInt32 colon13)
   (wantPressure (:pointer :callback))          ;(UInt32 colon1)
                                                ;  pressure in current mouseRect? 
   (wantPrecision (:pointer :callback))         ;(UInt32 colon12)
                                                ;  precise coordinates in current mouseRect? 
   (dontWantCoalesce (:pointer :callback))      ;(UInt32 colon3)
                                                ;  coalesce within the current mouseRect? 
   (dontCoalesce (:pointer :callback))          ;(UInt32 colon15)
                                                ;  actual flag which determines coalescing 
   (mouseRectValid (:pointer :callback))        ;(UInt32 colon14)
                                                ;  If nonzero, post a mouse-exited
; 				   whenever mouse outside mouseRect. 
   (movedMask :signed-long)
                                                ;  This contains an event mask for the
; 				   three events MOUSEMOVED,
; 				   LMOUSEDRAGGED,  and RMOUSEDRAGGED.
; 				   It says whether driver should
; 				   generate those events. 
   (AALastEventSent :signed-long)
                                                ;  timestamp for wait cursor 
   (AALastEventConsumed :signed-long)
                                                ;  timestamp for wait cursor 
   (waitCursorSema :signed-long)                ;  protects wait cursor fields 
   (waitCursorUp :signed-long)
                                                ;  Is wait cursor up? 
   (ctxtTimedOut :character)
                                                ;  Has wait cursor timer expired? 
   (waitCursorEnabled :character)
                                                ;  Play wait cursor game (per ctxt)? 
   (globalWaitCursorEnabled :character)         ;  Play wait cursor game (global)? 
   (waitThreshold :signed-long)
                                                ;  time before wait cursor appears 
   (lleq (:array :_NXEQELSTRUCT 240))
                                                ;  The event queue itself 
)
(%define-record :EvGlobals (find-record-descriptor :_EVGLOBALS))
;  These evio structs are used in various calls supported by the ev driver. 
(defrecord evioLLEvent
   (setCursor :signed-long)
   (type :signed-long)
   (location :IOGPoint)
   (data :nxeventdata)
#|
; Warning: type-size: unknown type NXEVENTDATA
|#
   (setFlags :signed-long)
   (flags :signed-long)
)

(%define-record :_NXLLEvent (find-record-descriptor ':evioLLEvent))
; #ifdef mach3xxx
#| #|



struct evioSpecialKeyMsg
{
	msg_header_t Head;
	msg_type_t keyType;
	int key;			msg_type_t directionType;
	int direction;			msg_type_t flagsType;
	int flags;			msg_type_t levelType;
	int level;		};
|#
 |#

; #else
(defrecord evioSpecialKeyMsg
   (Head :MACH_MSG_HEADER_T)
   (key :signed-long)
                                                ;  special key number, from bsd/dev/ev_keymap.h
   (direction :signed-long)
                                                ;  NX_KEYDOWN, NX_KEYUP from event.h
   (flags :signed-long)
                                                ;  device independant flags from event.h
   (level :signed-long)
                                                ;  EV_AUDIO_MIN_VOLUME to EV_AUDIO_MAX_VOLUME
)

; #endif

; #define EV_SPECIAL_KEY_MSG_ID	(('S'<<24) | ('k'<<16) | ('e'<<8) | ('y'))

(def-mactype :evioSpecialKeyMsg_t (find-mactype '(:pointer :evioSpecialKeyMsg)))
; 
;  * Volume ranges
;  
(defconstant $EV_AUDIO_MIN_VOLUME 0)
; #define EV_AUDIO_MIN_VOLUME	0
(defconstant $EV_AUDIO_MAX_VOLUME 64)
; #define EV_AUDIO_MAX_VOLUME	64
(defconstant $kIOHIDSystemClass "IOHIDSystem")
; #define kIOHIDSystemClass	"IOHIDSystem"
(defconstant $kIOHIKeyboardClass "IOHIKeyboard")
; #define kIOHIKeyboardClass	"IOHIKeyboard"
(defconstant $kIOHIPointingClass "IOHIPointing")
; #define kIOHIPointingClass	"IOHIPointing"
; #define IOHIDSYSTEM_CONFORMSTO	kIOHIDSystemClass

(defconstant $kIOHIDCurrentShmemVersion 3)
(defconstant $kIOHIDServerConnectType 0)
(defconstant $kIOHIDParamConnectType 1)
(defconstant $kIOHIDGlobalMemory 0)
(defconstant $kIOHIDEventNotification 0)
; #ifdef KERNEL
#| #|
typedef UInt16 (*MasterVolumeUpdate)(void);
typedef bool (*MasterMuteUpdate)(void);

typedef struct {
    MasterVolumeUpdate incrementMasterVolume;
    MasterVolumeUpdate decrementMasterVolume;
    MasterMuteUpdate toggleMasterMute;
} MasterAudioFunctions;

extern MasterAudioFunctions *masterAudioFunctions;
#endif
|#
 |#
; #ifndef KERNEL
; #ifndef _IOKIT_IOHIDLIB_H

(require-interface "IOKit/hidsystem/IOHIDLib")

; #endif


; #endif /* !KERNEL */


; #endif /* !_DEV_EVIO_H */


(provide-interface "IOHIDShared")