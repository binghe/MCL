(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHIKeyboard.h"
; at Sunday July 2,2006 7:29:24 pm.
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
;  	Copyright (c) 1992 NeXT Computer, Inc.  All rights reserved. 
;  *
;  * EventSrcPCKeyboard.h - PC Keyboard EventSrc subclass definition
;  *
;  * HISTORY
;  * 28 Aug 1992    Joe Pasqua
;  *      Created. 
;  
; #ifndef _IOHIKEYBOARD_H
; #define _IOHIKEYBOARD_H

(require-interface "IOKit/hidsystem/IOHIDevice")

(require-interface "IOKit/hidsystem/IOHIKeyboardMapper")
;  Start Action Definitions 
; 
;  * HISTORICAL NOTE:
;  *   The following entry points were part of the IOHIKeyboardEvents
;  *   protocol.
;  
;  eventFlags  
;  flags 
;  keyCode 
;  charCode 
;  charSet 
;  originalCharCode 
;  originalCharSet 
;  keyboardType 
;  repeat 
;  atTime 

(def-mactype :KeyboardEventAction (find-mactype ':pointer)); (OSObject * target , unsigned eventType , unsigned flags , unsigned key , unsigned charCode , unsigned charSet , unsigned origCharCode , unsigned origCharSet , unsigned keyboardType , bool repeat , AbsoluteTime ts)
;  eventType 
;  flags 
;  keyCode 
;  specialty 
;  source id 
;  repeat 
;  atTime 

(def-mactype :KeyboardSpecialEventAction (find-mactype ':pointer)); (OSObject * target , unsigned eventType , unsigned flags , unsigned key , unsigned flavor , UInt64 guid , bool repeat , AbsoluteTime ts)
;  flags 

(def-mactype :UpdateEventFlagsAction (find-mactype ':pointer)); (OSObject * target , unsigned flags)
;  Event Callback Definitions 
;  target 
;  eventFlags  
;  flags 
;  keyCode 
;  charCode 
;  charSet 
;  originalCharCode 
;  originalCharSet 
;  keyboardType 
;  repeat 
;  atTime 
;  sender 
;  refcon 

(def-mactype :KeyboardEventCallback (find-mactype ':pointer)); (OSObject * target , unsigned eventType , unsigned flags , unsigned key , unsigned charCode , unsigned charSet , unsigned origCharCode , unsigned origCharSet , unsigned keyboardType , bool repeat , AbsoluteTime ts , OSObject * sender , void * refcon)
;  target 
;  eventType 
;  flags 
;  keyCode 
;  specialty 
;  source id 
;  repeat 
;  atTime 
;  sender 
;  refcon 

(def-mactype :KeyboardSpecialEventCallback (find-mactype ':pointer)); (OSObject * target , unsigned eventType , unsigned flags , unsigned key , unsigned flavor , UInt64 guid , bool repeat , AbsoluteTime ts , OSObject * sender , void * refcon)
;  target 
;  flags 
;  sender 
;  refcon 

(def-mactype :UpdateEventFlagsCallback (find-mactype ':pointer)); (OSObject * target , unsigned flags , OSObject * sender , void * refcon)
;  End Action Definitions 
;  Default key repeat parameters 
; #define EV_DEFAULTINITIALREPEAT 500000000ULL    // 1/2 sec in nanoseconds
; #define EV_DEFAULTKEYREPEAT     83333333ULL     // 1/12 sec in nanoseconds
; #define EV_MINKEYREPEAT         16700000ULL     // 1/60 sec
#|
 confused about CLASS IOHIKeyboard #\: public IOHIDevice #\{ OSDeclareDefaultStructors #\( IOHIKeyboard #\) #\; friend class IOHIDKeyboardDevice #\; protected #\: IOLock * _deviceLock #\;;  Lock for all device access
 IOHIKeyboardMapper * _keyMap #\;               ;  KeyMap instance
;  The following fields describe the kind of keyboard
 UInt32 _interfaceType #\; UInt32 _deviceType #\;;  The following fields describe the state of the keyboard
 UInt32 * _keyState #\;                         ;  kbdBitVector
 IOByteCount _keyStateSize #\;                  ;  kbdBitVector allocated size
 unsigned _eventFlags #\;                       ;  Current eventFlags
 bool _alphaLock #\;                            ;  true means alpha lock is on
 bool _numLock #\;                              ;  true means num lock is on
 bool _charKeyActive #\;                        ;  true means char gen. key active
;  The following fields are used in performing key repeats
 bool _isRepeat #\;                             ;  true means we're generating repeat
 unsigned _codeToRepeat #\;                     ;  What we are repeating
 bool _calloutPending #\;                       ;  true means we've sched. a callout
 AbsoluteTime _lastEventTime #\;                ;  Time last event was dispatched
 AbsoluteTime _downRepeatTime #\;               ;  Time when we should next repeat
 AbsoluteTime _keyRepeat #\;                    ;  Delay between key repeats
 AbsoluteTime _initialKeyRepeat #\;             ;  Delay before initial key repeat
 UInt64 _guid #\; OSObject * _keyboardEventTarget #\; KeyboardEventAction _keyboardEventAction #\; OSObject * _keyboardSpecialEventTarget #\; KeyboardSpecialEventAction _keyboardSpecialEventAction #\; OSObject * _updateEventFlagsTarget #\; UpdateEventFlagsAction _updateEventFlagsAction #\; protected #\: virtual void dispatchKeyboardEvent #\( unsigned int keyCode #\,;  direction 
 bool goingDown #\,                             ;  timeStamp 
 AbsoluteTime time #\) #\; public #\: virtual bool init #\( OSDictionary * properties = 0 #\) #\; virtual bool start #\( IOService * provider #\) #\; virtual void stop #\( IOService * provider #\) #\; virtual void free #\( #\) #\; virtual bool open #\( IOService * client #\, IOOptionBits options #\, KeyboardEventAction keAction #\, KeyboardSpecialEventAction kseAction #\, UpdateEventFlagsAction uefAction #\) #\; bool open #\( IOService * client #\, IOOptionBits options #\, void * #\, KeyboardEventCallback keCallback #\, KeyboardSpecialEventCallback kseCallback #\, UpdateEventFlagsCallback uefCallback #\) #\; virtual void close #\( IOService * client #\, IOOptionBits #\) #\; virtual IOReturn message #\( UInt32 type #\, IOService * provider #\, void * argument = 0 #\) #\; virtual IOHIDKind hidKind #\( #\) #\; virtual bool updateProperties #\( void #\) #\; virtual IOReturn setParamProperties #\( OSDictionary * dict #\) #\; inline bool isRepeat #\( #\) #\{ return _isRepeat #\; #\} protected #\:;  for subclasses to implement
 virtual const unsigned char * defaultKeymapOfLength #\( UInt32 * length #\) #\; virtual void setAlphaLockFeedback #\( bool val #\) #\; virtual void setNumLockFeedback #\( bool val #\) #\; virtual UInt32 maxKeyCodes #\( #\) #\; private #\: virtual bool resetKeyboard #\( #\) #\; virtual void scheduleAutoRepeat #\( #\) #\; static void _autoRepeat #\( void * arg #\, void * #\) #\; virtual void autoRepeat #\( #\) #\; virtual void setRepeat #\( unsigned eventType #\, unsigned keyCode #\) #\;
; 
;  * HISTORICAL NOTE:
;  *   The following methods were part of the KeyMapDelegate protocol;
;  *   the declarations have now been merged directly into this class.
;  
 public #\: virtual void keyboardEvent #\( unsigned eventType #\,;  flags 
 unsigned flags #\,                             ;  keyCode 
 unsigned keyCode #\,                           ;  charCode 
 unsigned charCode #\,                          ;  charSet 
 unsigned charSet #\,                           ;  originalCharCode 
 unsigned origCharCode #\,                      ;  originalCharSet 
 unsigned origCharSet #\) #\; virtual void keyboardSpecialEvent #\( unsigned eventType #\,;  flags 
 unsigned flags #\,                             ;  keyCode 
 unsigned keyCode #\,                           ;  specialty 
 unsigned flavor #\) #\; virtual void updateEventFlags #\( unsigned flags #\) #\;;  Does not generate events
 virtual unsigned eventFlags #\( #\) #\;        ;  Global event flags
 virtual unsigned deviceFlags #\( #\) #\;       ;  per-device event flags
 virtual void setDeviceFlags #\( unsigned flags #\) #\;;  Set device event flags
 virtual bool alphaLock #\( #\) #\;             ;  current alpha-lock state
 virtual void setAlphaLock #\( bool val #\) #\; ;  Set current alpha-lock state
 virtual bool numLock #\( #\) #\; virtual void setNumLock #\( bool val #\) #\; virtual bool charKeyActive #\( #\) #\;;  Is a character gen. key down?
 virtual void setCharKeyActive #\( bool val #\) #\;;  Note that a char gen key is down.
 virtual bool doesKeyLock #\( unsigned key #\) #\;; does key lock physically
 virtual unsigned getLEDStatus #\( #\) #\;      ; check hardware for LED status
 private #\: static void _keyboardEvent #\( IOHIKeyboard * self #\, unsigned eventType #\,;  flags 
 unsigned flags #\,                             ;  keyCode 
 unsigned key #\,                               ;  charCode 
 unsigned charCode #\,                          ;  charSet 
 unsigned charSet #\,                           ;  originalCharCode 
 unsigned origCharCode #\,                      ;  originalCharSet 
 unsigned origCharSet #\,                       ;  keyboardType 
 unsigned keyboardType #\,                      ;  repeat 
 bool repeat #\,                                ;  atTime 
 AbsoluteTime ts #\) #\; static void _keyboardSpecialEvent #\( IOHIKeyboard * self #\, unsigned eventType #\,;  flags 
 unsigned flags #\,                             ;  keyCode  
 unsigned key #\,                               ;  specialty 
 unsigned flavor #\,                            ;  guid 
 UInt64 guid #\,                                ;  repeat 
 bool repeat #\,                                ;  atTime 
 AbsoluteTime ts #\) #\; static void _updateEventFlags #\( IOHIKeyboard * self #\, unsigned flags #\) #\;;  Does not generate events 
|#

; #endif /* !_IOHIKEYBOARD_H */


(provide-interface "IOHIKeyboard")