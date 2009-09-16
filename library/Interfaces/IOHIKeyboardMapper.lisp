(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHIKeyboardMapper.h"
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
; #ifndef _IOHIKEYBOARDMAPPER_H
; #define _IOHIKEYBOARDMAPPER_H

(require-interface "IOKit/hidsystem/ev_keymap")

(require-interface "IOKit/IOTimerEventSource")

(require-interface "IOKit/IOInterruptEventSource")

#|class IOHIKeyboard;
|#

#|class IOHIDSystem;
|#
; 
;  * Key ip/down state is tracked in a bit list.  Bits are set
;  * for key-down, and cleared for key-up.  The bit vector and macros
;  * for it's manipulation are defined here.
;  

(def-mactype :kbdBitVector (find-mactype '(:pointer :UInt32)))
(defconstant $EVK_BITS_PER_UNIT 32)
; #define EVK_BITS_PER_UNIT	32
(defconstant $EVK_BITS_MASK 31)
; #define EVK_BITS_MASK		31
(defconstant $EVK_BITS_SHIFT 5)
; #define EVK_BITS_SHIFT		5	// 1<<5 == 32, for cheap divide
; #define EVK_KEYDOWN(n, bits) 	(bits)[((n)>>EVK_BITS_SHIFT)] |= (1 << ((n) & EVK_BITS_MASK))
; #define EVK_KEYUP(n, bits) 	(bits)[((n)>>EVK_BITS_SHIFT)] &= ~(1 << ((n) & EVK_BITS_MASK))
; #define EVK_IS_KEYDOWN(n, bits) 	(((bits)[((n)>>EVK_BITS_SHIFT)] & (1 << ((n) & EVK_BITS_MASK))) != 0)
;  the maximum number of modifier keys sticky keys can hold at once 
(defconstant $kMAX_MODIFIERS 5)
; #define kMAX_MODIFIERS					5
;  the number of shift keys in a row that must be depressed to toggle state 
(defconstant $kNUM_SHIFTS_TO_ACTIVATE 5)
; #define kNUM_SHIFTS_TO_ACTIVATE			5
;  the number of milliseconds all the shifts must be pressed in - 30 seconds (30000 mS)
(defconstant $kDEFAULT_SHIFTEXPIREINTERVAL 30000)
; #define kDEFAULT_SHIFTEXPIREINTERVAL	30000
;  sticky keys state flags

(defconstant $kState_Disabled_Flag 1)           ;  disabled and will do nothing until this is changed

(defconstant $kState_ShiftActivates_Flag 2)     ;  the 'on' gesture (5 shifts) will activate

(defconstant $kState_On 4)                      ;  currently on, will hold down modifiers when pressed

(defconstant $kState_On_ModifiersDown 8)        ;  one or more modifiers being held down

(defconstant $kState_Mask #xFF)                 ;  mask for all states
(defrecord _stickyKeys_ToggleInfo
                                                ;  size of this allocation
   (size :UInt32)
                                                ;  which modifier key we are tracking (using NX_WHICHMODMASK)
   (toggleModifier :UInt32)
                                                ;  the number of times the modifier must be pressed to toggle
   (repetitionsToToggle :UInt32)
                                                ;  how long the user has to press the modifier repetitionsToToggle times
                                                ;  the default is 30 seconds
   (expireInterval :UnsignedWide)
                                                ;  the number of times the modifier used within the alloted time
   (currentCount :UInt32)
                                                ;  the times that the last shift must occer for this one to be used
                                                ;  this array will actually be of size repetitionsToToggle
   (deadlines (:array :UnsignedWide 1))
)
(%define-record :StickyKeys_ToggleInfo (find-record-descriptor :_STICKYKEYS_TOGGLEINFO))
;  Flags for each sticky key modifier
;  This will allow for chording of keys
;  and for key locking

(defconstant $kModifier_DidPerformModifiy 1)
(defconstant $kModifier_DidKeyUp 2)
(defconstant $kModifier_Locked 4)
(defrecord _stickyKeys_ModifierInfo
   (key :UInt8)
                                                ;  Key code of the sticky modifier
   (state :UInt8)
                                                ;  The state of the sticky modifier
   (leftModBit :UInt8)
                                                ;  System Mod bit of the sticky modifier
)
(%define-record :StickyKeys_ModifierInfo (find-record-descriptor :_STICKYKEYS_MODIFIERINFO))

#|class IOHIDKeyboardDevice;
|#
#|
 confused about CLASS IOHIKeyboardMapper #\: public OSObject #\{ OSDeclareDefaultStructors #\( IOHIKeyboardMapper #\) #\; private #\: IOHIKeyboard * _delegate #\;;  KeyMap delegate
 bool _mappingShouldBeFreed #\;                 ;  true if map can be IOFree'd
 NXParsedKeyMapping _parsedMapping #\;          ;  current system-wide keymap
 IOHIDSystem * _hidSystem #\;                   ;  target of IOHIKeyboard (should be IOHIDSystem)
;  binary compatibility padding
 struct ExpansionData #\{                       ;  This is for F12 eject
 UInt16 f12Eject_State #\; UInt32 eject_Delay_MS #\; IOTimerEventSource * ejectTimerEventSource #\;;  This is for sticky keys
 kbdBitVector stickyKeys_Modifier_KeyBits #\; StickyKeys_ModifierInfo stickyKeys_StuckModifiers #\[ kMAX_MODIFIERS #\] #\; IOInterruptEventSource * stickyKeysMouseClickEventSource #\; IOInterruptEventSource * stickyKeysSetFnStateEventSource #\;;  The following should really be statics, but placing here 
;  to match design by predecesor.
 OSDictionary * offFnParamDict #\; OSDictionary * onFnParamDict #\;;  This is for SlowKeys
 UInt16 slowKeys_State #\; UInt32 slowKeys_Delay_MS #\; IOTimerEventSource * slowKeysTimerEventSource #\;;  stored for slowKeysPostProcess
 UInt8 slowKeys_Aborted_Key #\; UInt8 slowKeys_Current_Key #\; kbdBitVector slowKeys_Current_KeyBits #\; UInt32 swapKeyState #\; UInt32 specialKeyModifierFlags #\; bool supportsF12Eject #\; #\} #\; ExpansionData * _reserved #\;;  Reserved for future use.  (Internal use only)
 public #\: static IOHIKeyboardMapper * keyboardMapper #\( IOHIKeyboard * delegate #\, const UInt8 * mapping #\, UInt32 mappingLength #\, bool mappingShouldBeFreed #\) #\; virtual bool init #\( IOHIKeyboard * delegate #\, const UInt8 * mapping #\, UInt32 mappingLength #\, bool mappingShouldBeFreed #\) #\; virtual void free #\( #\) #\; virtual const UInt8 * mapping #\( #\) #\; virtual UInt32 mappingLength #\( #\) #\; virtual bool serialize #\( OSSerialize * s #\) const #\; virtual void translateKeyCode #\( UInt8 key #\, bool keyDown #\, kbdBitVector keyBits #\) #\; virtual UInt8 getParsedSpecialKey #\( UInt8 logical #\) #\;; retrieve a key from _parsedMapping
 virtual void setKeyboardTarget #\( IOService * keyboardTarget #\) #\; virtual bool updateProperties #\( void #\) #\; virtual IOReturn setParamProperties #\( OSDictionary * dict #\) #\;;  keyEventPostProcess is called while a lock is not held, so a recursive
;  call back into HIKeyboard is possible
 virtual void keyEventPostProcess #\( void #\) #\; private #\: static void makeNumberParamProperty #\( OSDictionary * dict #\, const char * key #\, unsigned long long number #\, unsigned int bits #\) #\; virtual bool parseKeyMapping #\( const UInt8 * mapping #\, UInt32 mappingLength #\, NXParsedKeyMapping * parsedMapping #\) const #\; virtual void calcModBit #\( int bit #\, kbdBitVector keyBits #\) #\; virtual void doModCalc #\( int key #\, kbdBitVector keyBits #\) #\; virtual void doCharGen #\( int keyCode #\, bool down #\) #\;;  sticky keys functionality 
 private #\:                                    ;  original translateKeyCode
 void rawTranslateKeyCode #\( UInt8 key #\, bool keyDown #\, kbdBitVector keyBits #\) #\; void calcModSwap #\( UInt8 * key #\) #\;;  the current state of stickyKeys
 UInt32 _stickyKeys_State #\;                   ;  the number of modifiers being held down by stickyKeys
 int _stickyKeys_NumModifiersDown #\;           ; ////////////////////////////////////////////////////////////
;  THE FOLLOWING CLASS VARIABLE HAS BEEN DEPRECATED
; 
;  PLEASE USE _stickyKeys_StuckModifiers
; 
 UInt8 _stickyKeys_Modifiers #\[ kMAX_MODIFIERS #\] #\;; ////////////////////////////////////////////////////////////
;  contains the info needed to keep track of shift repetitions
 StickyKeys_ToggleInfo * _stickyKeys_ShiftToggle #\;;  contains the info needed to keep track of option repetitions
 StickyKeys_ToggleInfo * _stickyKeys_OptionToggle #\;;  dictionaries with cached on and off states, used to set params when state changes
 bool _stateDirty #\; OSDictionary * _onParamDict #\; OSDictionary * _offParamDict #\;;  init/free vars
 bool stickyKeysinit #\( void #\) #\; void stickyKeysfree #\( void #\) #\;;  allocate/free a StickyKeys_ToggleInfo struct
 static StickyKeys_ToggleInfo * stickyKeysAllocToggleInfo #\( unsigned maxCount #\) #\; static void stickyKeysFreeToggleInfo #\( StickyKeys_ToggleInfo * toggleInfo #\) #\;;  create on/off dicts as part of init
 bool createParamDicts #\( void #\) #\;         ;  post special keyboard events thru the event system
 void postKeyboardSpecialEvent #\( unsigned subtype #\) #\;;  check any modifier to see if it is pressed 5 times
;  based on StickyKeys_ToggleInfo
 bool stickyKeysModifierToggleCheck #\( StickyKeys_ToggleInfo * toggleInfo #\, UInt8 key #\, bool keyDown #\, kbdBitVector keyBits #\, bool mouseClick = false #\) #\;;  non-modifier key pressed
 void stickyKeysNonModifierKey #\( UInt8 key #\, bool keyDown #\, kbdBitVector keyBits #\, bool mouseClick = false #\) #\;;  modifier key pressed (shift, command, option, control)
 bool stickyKeysModifierKey #\( UInt8 key #\, bool keyDown #\, kbdBitVector keyBits #\) #\;;  main entry point, called for all keys (returns true if key handled)
 bool stickyKeysFilterKey #\( UInt8 key #\, bool keyDown #\, kbdBitVector keyBits #\, bool mouseClick = false #\) #\;;  called by interrupt event source to inform sticky keys of mouse down event
 static void stickyKeysMouseDown #\( IOHIKeyboardMapper * owner #\, IOEventSource * sender #\) #\;;  called by interrupt event source to restore prior fn state
 static void stickyKeysSetFnState #\( IOHIKeyboardMapper * owner #\, IOEventSource * sender #\) #\;;  F12 Eject Functionality 
 private #\:                                    ;  Determining f12 eject key press
;  Returns true if f12 held down for a predetermined period of time.
 bool f12EjectFilterKey #\( UInt8 key #\, bool keyDown #\, kbdBitVector keyBits #\) #\;;  Timer function for eject
 static void performF12Eject #\( IOHIKeyboardMapper * owner #\, IOTimerEventSource * sender #\) #\;;  SlowKeys Functionality 
 private #\:                                    ;  Slow keys methods
 bool slowKeysFilterKey #\( UInt8 key #\, bool keyDown #\, kbdBitVector keyBits #\) #\; static void slowKeysPostProcess #\( IOHIKeyboardMapper * owner #\, IOTimerEventSource * sender #\) #\; public #\: OSMetaClassDeclareReservedUsed #\( IOHIKeyboardMapper #\, 0 #\) #\; virtual IOReturn message #\( UInt32 type #\, IOService * provider #\, void * argument = 0 #\) #\;;  binary compatibility padding
 OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 1 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 2 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 3 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 4 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 5 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 6 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 7 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 8 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 9 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 10 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 11 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 12 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 13 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 14 #\) #\; OSMetaClassDeclareReservedUnused #\( IOHIKeyboardMapper #\, 15 #\) #\;
|#

; #endif _IOHIKEYBOARDMAPPER_H

; 
;  * HISTORICAL NOTE:
;  *   The "delegate" object had to respond to the following protocol;
;  *   this protocol has since been merged into the IOHIKeyboard class.
;  *
;  * @protocol KeyMapDelegate
;  *
;  * - keyboardEvent	:(unsigned)eventType
;  * 	flags	:(unsigned)flags
;  *	keyCode	:(unsigned)keyCode
;  *	charCode:(unsigned)charCode
;  *	charSet	:(unsigned)charSet
;  *	originalCharCode:(unsigned)origCharCode
;  *	originalCharSet:(unsigned)origCharSet;
;  * 
;  * - keyboardSpecialEvent:(unsigned)eventType
;  *	flags	 :(unsigned)flags
;  *	keyCode	:(unsigned)keyCode
;  *	specialty:(unsigned)flavor;
;  *
;  * - updateEventFlags:(unsigned)flags;	// Does not generate events
;  *
;  * - (unsigned)eventFlags;		// Global event flags
;  * - (unsigned)deviceFlags;		// per-device event flags
;  * - setDeviceFlags:(unsigned)flags;	// Set device event flags
;  * - (bool)alphaLock;			// current alpha-lock state
;  * - setAlphaLock:(bool)val;		// Set current alpha-lock state
;  * - (bool)charKeyActive;		// Is a character gen. key down?
;  * - setCharKeyActive:(bool)val;	// Note that a char gen key is down.
;  *
;  * @end
;  

(provide-interface "IOHIKeyboardMapper")