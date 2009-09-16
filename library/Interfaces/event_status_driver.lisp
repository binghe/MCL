(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:event_status_driver.h"
; at Sunday July 2,2006 7:27:49 pm.
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
; *****************************************************************************
; 	event_status_driver.h
; 	API for the events status driver.
; 	This file contains public API.
; 	mpaque 11Oct91
; 	
; 	Copyright 1991 NeXT Computer, Inc.
; 	
; 	Modified:
; 	
; *****************************************************************************
; #ifndef _DRIVERS_EVENT_STATUS_DRIVER_
; #define _DRIVERS_EVENT_STATUS_DRIVER_
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "mach/port")

(require-interface "IOKit/hidsystem/IOLLEvent")

(require-interface "IOKit/hidsystem/IOHIDTypes")
; 
;  * Event System Handle:
;  *
;  * Information used by the system between calls to NXOpenEventSystem and
;  * NXCloseEventSystem.  The application should not
;  * access any of the elements of this structure.
;  

(def-mactype :NXEventHandle (find-mactype ':pointer))
;  Open and Close 

(deftrap-inline "_NXOpenEventStatus" 
   (
   )
   :pointer
() )

(deftrap-inline "_NXCloseEventStatus" 
   ((handle :pointer)
   )
   :void
() )
;  Status 

(deftrap-inline "_NXEventSystemInfo" 
   ((handle :pointer)
    (flavor (:pointer :char))
    (evs_info (:pointer :int))
    (evs_info_cnt (:pointer :UInt32))
   )
   (:pointer :signed-long)
() )
;  Keyboard 

(deftrap-inline "_NXSetKeyRepeatInterval" 
   ((handle :pointer)
    (seconds :double-float)
   )
   nil
() )

(deftrap-inline "_NXKeyRepeatInterval" 
   ((handle :pointer)
   )
   :double-float
() )

(deftrap-inline "_NXSetKeyRepeatThreshold" 
   ((handle :pointer)
    (threshold :double-float)
   )
   nil
() )

(deftrap-inline "_NXKeyRepeatThreshold" 
   ((handle :pointer)
   )
   :double-float
() )

(deftrap-inline "_NXSetKeyMapping" 
   ((h :pointer)
    (keymap (:pointer :NXKEYMAPPING))
   )
   (:pointer :EVSIOKEYMAPPING)
() )

(deftrap-inline "_NXKeyMappingLength" 
   ((handle :pointer)
   )
   :signed-long
() )

(deftrap-inline "_NXGetKeyMapping" 
   ((h :pointer)
    (keymap (:pointer :NXKEYMAPPING))
   )
   (:pointer :EVSIOKEYMAPPING)
() )

(deftrap-inline "_NXResetKeyboard" 
   ((handle :pointer)
   )
   nil
() )
;  Mouse 

(deftrap-inline "_NXSetClickTime" 
   ((handle :pointer)
    (seconds :double-float)
   )
   nil
() )

(deftrap-inline "_NXClickTime" 
   ((handle :pointer)
   )
   :double-float
() )

(deftrap-inline "_NXSetClickSpace" 
   ((handle :pointer)
    (area (:pointer :_nxsize_))
   )
   nil
() )

(deftrap-inline "_NXGetClickSpace" 
   ((handle :pointer)
    (area (:pointer :_nxsize_))
   )
   nil
() )

(deftrap-inline "_NXSetMouseScaling" 
   ((handle :pointer)
    (scaling (:pointer :NXMOUSESCALING))
   )
   nil
() )

(deftrap-inline "_NXGetMouseScaling" 
   ((handle :pointer)
    (scaling (:pointer :NXMOUSESCALING))
   )
   nil
() )
; #ifdef _undef
#| #|
extern void NXEnableMouseButton(NXEventHandle handle, NXMouseButton button);
extern NXMouseButton NXMouseButtonEnabled(NXEventHandle handle);
#endif
|#
 |#

(deftrap-inline "_NXResetMouse" 
   ((handle :pointer)
   )
   nil
() )
;  Screen Brightness and Auto-dimming 

(deftrap-inline "_NXSetAutoDimThreshold" 
   ((handle :pointer)
    (seconds :double-float)
   )
   nil
() )

(deftrap-inline "_NXAutoDimThreshold" 
   ((handle :pointer)
   )
   :double-float
() )

(deftrap-inline "_NXAutoDimTime" 
   ((handle :pointer)
   )
   :double-float
() )

(deftrap-inline "_NXIdleTime" 
   ((handle :pointer)
   )
   :double-float
() )

(deftrap-inline "_NXSetAutoDimState" 
   ((handle :pointer)
    (dimmed :signed-long)
   )
   nil
() )

(deftrap-inline "_NXAutoDimState" 
   ((handle :pointer)
   )
   :signed-long
() )

(deftrap-inline "_NXSetAutoDimBrightness" 
   ((handle :pointer)
    (level :double-float)
   )
   nil
() )

(deftrap-inline "_NXAutoDimBrightness" 
   ((handle :pointer)
   )
   :double-float
() )

(deftrap-inline "_NXSetScreenBrightness" 
   ((handle :pointer)
    (level :double-float)
   )
   nil
() )

(deftrap-inline "_NXScreenBrightness" 
   ((handle :pointer)
   )
   :double-float
() )
;  Speaker Volume 
; #ifdef _undef
#| #|
extern void NXSetCurrentVolume(NXEventHandle handle, double volume);
extern double NXCurrentVolume(NXEventHandle handle);
#endif
|#
 |#
;  Wait Cursor 
; #ifdef _undef
#| #|
extern void NXSetWaitCursorThreshold(NXEventHandle handle, double seconds);
extern double NXWaitCursorThreshold(NXEventHandle handle);
extern void NXSetWaitCursorSustain(NXEventHandle handle, double seconds);
extern double NXWaitCursorSustain(NXEventHandle handle);
extern void NXSetWaitCursorFrameInterval(NXEventHandle handle, double seconds);
extern double NXWaitCursorFrameInterval(NXEventHandle handle);
#endif
|#
 |#
; 
;  * Generic calls.  Argument values are device and architecture dependent.
;  * This API is provided for the convenience of special device users.  Code
;  * which is intended to be portable across multiple platforms and architectures
;  * should not use the following functions.
;  
; #ifdef _undef
#| #|
extern int NXEvSetParameterInt(NXEventHandle handle,
			char *parameterName,
			unsigned int *parameterArray,
			unsigned int count);

extern int NXEvSetParameterChar(NXEventHandle handle,
			char *parameterName,
			unsigned char *parameterArray,
			unsigned int count);

extern int NXEvGetParameterInt(NXEventHandle handle,
			char *parameterName,
			unsigned int maxCount,
			unsigned int *parameterArray,
			unsigned int *returnedCount);

extern int NXEvGetParameterChar(NXEventHandle handle,
			char *parameterName,
			unsigned int maxCount,
			unsigned char *parameterArray,
			unsigned int *returnedCount);
#endif
|#
 |#
; #ifdef __cplusplus
#| #|
} 
#endif
|#
 |#

; #endif /*_DRIVERS_EVENT_STATUS_DRIVER_ */


(provide-interface "event_status_driver")