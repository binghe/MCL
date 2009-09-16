(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ev_keymap.h"
; at Sunday July 2,2006 7:27:46 pm.
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
;  *	ev_keymap.h
;  *	Defines the structure used for parsing keymappings.  These structures
;  *	and definitions are used by event sources in the kernel and by
;  *	applications and utilities which manipulate keymaps.
;  *	
;  * HISTORY
;  * 02-Jun-1992    Mike Paquette at NeXT
;  *      Created. 
;  
; #ifndef _DEV_EV_KEYMAP_H
; #define _DEV_EV_KEYMAP_H
(defconstant $NX_NUMKEYCODES 128)
; #define	NX_NUMKEYCODES	128	/* Highest key code is 0x7f */
(defconstant $NX_NUMSEQUENCES 128)
; #define NX_NUMSEQUENCES	128	/* Maximum possible number of sequences */
(defconstant $NX_NUMMODIFIERS 16)
; #define	NX_NUMMODIFIERS	16	/* Maximum number of modifier bits */
(defconstant $NX_BYTE_CODES 0)
; #define	NX_BYTE_CODES	0	/* If first short 0, all are bytes (else shorts) */
(defconstant $NX_WHICHMODMASK 15)
; #define	NX_WHICHMODMASK	0x0f 	/* bits out of keyBits for bucky bits */
(defconstant $NX_MODMASK 16)
; #define	NX_MODMASK	0x10	/* Bit out of keyBits indicates modifier bit */
(defconstant $NX_CHARGENMASK 32)
; #define	NX_CHARGENMASK	0x20	/* bit out of keyBits for char gen */
(defconstant $NX_SPECIALKEYMASK 64)
; #define	NX_SPECIALKEYMASK 0x40	/* bit out of keyBits for specialty key */
(defconstant $NX_KEYSTATEMASK 128)
; #define	NX_KEYSTATEMASK	0x80	/* OBSOLETE - DO NOT USE IN NEW DESIGNS */
; 
;  * Special keys currently known to and understood by the system.
;  * If new specialty keys are invented, extend this list as appropriate.
;  * The presence of these keys in a particular implementation is not
;  * guaranteed.
;  
(defconstant $NX_NOSPECIALKEY 65535)
; #define NX_NOSPECIALKEY			0xFFFF
(defconstant $NX_KEYTYPE_SOUND_UP 0)
; #define NX_KEYTYPE_SOUND_UP		0
(defconstant $NX_KEYTYPE_SOUND_DOWN 1)
; #define NX_KEYTYPE_SOUND_DOWN		1
(defconstant $NX_KEYTYPE_BRIGHTNESS_UP 2)
; #define NX_KEYTYPE_BRIGHTNESS_UP	2
(defconstant $NX_KEYTYPE_BRIGHTNESS_DOWN 3)
; #define NX_KEYTYPE_BRIGHTNESS_DOWN	3
(defconstant $NX_KEYTYPE_CAPS_LOCK 4)
; #define NX_KEYTYPE_CAPS_LOCK		4
(defconstant $NX_KEYTYPE_HELP 5)
; #define NX_KEYTYPE_HELP			5
(defconstant $NX_POWER_KEY 6)
; #define NX_POWER_KEY			6
(defconstant $NX_KEYTYPE_MUTE 7)
; #define	NX_KEYTYPE_MUTE			7
(defconstant $NX_UP_ARROW_KEY 8)
; #define NX_UP_ARROW_KEY			8
(defconstant $NX_DOWN_ARROW_KEY 9)
; #define NX_DOWN_ARROW_KEY		9
(defconstant $NX_KEYTYPE_NUM_LOCK 10)
; #define NX_KEYTYPE_NUM_LOCK		10
(defconstant $NX_KEYTYPE_CONTRAST_UP 11)
; #define NX_KEYTYPE_CONTRAST_UP		11
(defconstant $NX_KEYTYPE_CONTRAST_DOWN 12)
; #define NX_KEYTYPE_CONTRAST_DOWN	12
(defconstant $NX_KEYTYPE_LAUNCH_PANEL 13)
; #define NX_KEYTYPE_LAUNCH_PANEL		13
(defconstant $NX_KEYTYPE_EJECT 14)
; #define NX_KEYTYPE_EJECT		14
(defconstant $NX_KEYTYPE_VIDMIRROR 15)
; #define NX_KEYTYPE_VIDMIRROR		15
(defconstant $NX_KEYTYPE_PLAY 16)
; #define NX_KEYTYPE_PLAY			16
(defconstant $NX_KEYTYPE_NEXT 17)
; #define NX_KEYTYPE_NEXT			17
(defconstant $NX_KEYTYPE_PREVIOUS 18)
; #define NX_KEYTYPE_PREVIOUS		18
(defconstant $NX_KEYTYPE_FAST 19)
; #define NX_KEYTYPE_FAST			19
(defconstant $NX_KEYTYPE_REWIND 20)
; #define NX_KEYTYPE_REWIND		20
(defconstant $NX_KEYTYPE_ILLUMINATION_UP 21)
; #define NX_KEYTYPE_ILLUMINATION_UP	21
(defconstant $NX_KEYTYPE_ILLUMINATION_DOWN 22)
; #define NX_KEYTYPE_ILLUMINATION_DOWN	22
(defconstant $NX_KEYTYPE_ILLUMINATION_TOGGLE 23)
; #define NX_KEYTYPE_ILLUMINATION_TOGGLE	23
(defconstant $NX_NUMSPECIALKEYS 24)
; #define	NX_NUMSPECIALKEYS		24 /* Maximum number of special keys */
(defconstant $NX_NUM_SCANNED_SPECIALKEYS 24)
; #define NX_NUM_SCANNED_SPECIALKEYS	24 /* First 24 special keys are */
;  actively scanned in kernel 
;  Mask of special keys that are posted as events 
(defconstant $NX_SPECIALKEY_POST_MASK 16771279)
; #define NX_SPECIALKEY_POST_MASK		                                ((1 << NX_KEYTYPE_SOUND_UP) | (1 << NX_KEYTYPE_SOUND_DOWN) |                                 (1 << NX_POWER_KEY) | (1 << NX_KEYTYPE_MUTE) |                                 (1 << NX_KEYTYPE_BRIGHTNESS_UP) | (1 << NX_KEYTYPE_BRIGHTNESS_DOWN) |                                 (1 << NX_KEYTYPE_CONTRAST_UP) | (1 << NX_KEYTYPE_CONTRAST_UP) |                                 (1 << NX_KEYTYPE_LAUNCH_PANEL) | (1 << NX_KEYTYPE_EJECT) |                                 (1 << NX_KEYTYPE_VIDMIRROR) | (1 << NX_KEYTYPE_PLAY) |                                 (1 << NX_KEYTYPE_NEXT) | (1 << NX_KEYTYPE_PREVIOUS) |                                 (1 << NX_KEYTYPE_FAST) | (1 << NX_KEYTYPE_REWIND) |                                 (1 << NX_KEYTYPE_ILLUMINATION_UP) |                                 (1 << NX_KEYTYPE_ILLUMINATION_DOWN) |                                 (1 << NX_KEYTYPE_ILLUMINATION_TOGGLE) | 0)
;  Modifier key indices into modDefs[] 
(defconstant $NX_MODIFIERKEY_ALPHALOCK 0)
; #define NX_MODIFIERKEY_ALPHALOCK	0
(defconstant $NX_MODIFIERKEY_SHIFT 1)
; #define NX_MODIFIERKEY_SHIFT		1
(defconstant $NX_MODIFIERKEY_CONTROL 2)
; #define NX_MODIFIERKEY_CONTROL		2
(defconstant $NX_MODIFIERKEY_ALTERNATE 3)
; #define NX_MODIFIERKEY_ALTERNATE	3
(defconstant $NX_MODIFIERKEY_COMMAND 4)
; #define NX_MODIFIERKEY_COMMAND		4
(defconstant $NX_MODIFIERKEY_NUMERICPAD 5)
; #define NX_MODIFIERKEY_NUMERICPAD	5
(defconstant $NX_MODIFIERKEY_HELP 6)
; #define NX_MODIFIERKEY_HELP		6
(defconstant $NX_MODIFIERKEY_SECONDARYFN 7)
; #define NX_MODIFIERKEY_SECONDARYFN     	7
(defconstant $NX_MODIFIERKEY_NUMLOCK 8)
; #define NX_MODIFIERKEY_NUMLOCK		8
;  support for right hand modifier 
(defconstant $NX_MODIFIERKEY_RSHIFT 9)
; #define NX_MODIFIERKEY_RSHIFT		9
(defconstant $NX_MODIFIERKEY_RCONTROL 10)
; #define NX_MODIFIERKEY_RCONTROL		10
(defconstant $NX_MODIFIERKEY_RALTERNATE 11)
; #define NX_MODIFIERKEY_RALTERNATE	11
(defconstant $NX_MODIFIERKEY_RCOMMAND 12)
; #define NX_MODIFIERKEY_RCOMMAND		12
(defrecord _NXParsedKeyMapping_
                                                ;  If nonzero, all numbers are shorts; if zero, all numbers are bytes
   (shorts :SInt16)
                                                ; 
; 	 *  For each keycode, low order bit says if the key
; 	 *  generates characters.
; 	 *  High order bit says if the key is assigned to a modifier bit.
; 	 *  The second to low order bit gives the current state of the key.
; 	 
   (keyBits (:array :character 128))
                                                ;  Bit number of highest numbered modifier bit 
   (maxMod :signed-long)
                                                ;  Pointers to where the list of keys for each modifiers bit begins,
; 	 * or NULL.
; 	 
   (modDefs (:array :pointer 16))
                                                ;  Key code of highest key deinfed to generate characters 
   (numDefs :signed-long)
                                                ;  Pointer into the keyMapping where this key's definitions begin 
   (keyDefs (:array :pointer 128))
                                                ;  number of sequence definitions 
   (numSeqs :signed-long)
                                                ;  pointers to sequences 
   (seqDefs (:array :pointer 128))
                                                ;  Special key definitions 
   (numSpecialKeys :signed-long)
                                                ;  Special key values, or 0xFFFF if none 
   (specialKeys (:array :UInt16 24))
                                                ;  Pointer to the original keymapping string 
   (mapping (:pointer :UInt8))
                                                ;  Length of the original string 
   (mappingLen :signed-long)
)
(%define-record :NXParsedKeyMapping (find-record-descriptor :_NXPARSEDKEYMAPPING_))

; #endif /* !_DEV_EV_KEYMAP_H */


(provide-interface "ev_keymap")