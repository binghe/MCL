(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Keyboards.h"
; at Sunday July 2,2006 7:25:07 pm.
; 
;      File:       HIToolbox/Keyboards.h
;  
;      Contains:   Keyboard API.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __KEYBOARDS__
; #define __KEYBOARDS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
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
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   OBSOLETE                                                                        
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  These are obsolete.  Carbon does not support these. 
;  Keyboard API Trap Number. Should be moved to Traps.i 

(defconstant $_KeyboardDispatch #xAA7A)
;  Gestalt selector and values for the Keyboard API 

(defconstant $gestaltKeyboardsAttr :|kbds|)
(defconstant $gestaltKBPS2Keyboards 1)
(defconstant $gestaltKBPS2SetIDToAny 2)
(defconstant $gestaltKBPS2SetTranslationTable 4)
;  Keyboard API Error Codes 
; 
;    I stole the range blow from the empty space in the Allocation project but should
;    be updated to the officially registered range.
; 

(defconstant $errKBPS2KeyboardNotAvailable -30850)
(defconstant $errKBIlligalParameters -30851)
(defconstant $errKBFailSettingID -30852)
(defconstant $errKBFailSettingTranslationTable -30853)
(defconstant $errKBFailWritePreference -30854)
; 
;  *  KBInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; 
;  *  KBSetupPS2Keyboard()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; 
;  *  KBGetPS2KeyboardID()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; 
;  *  KBIsPS2KeyboardConnected()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; 
;  *  KBIsPS2KeyboardEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; 
;  *  KBGetPS2KeyboardAttributes()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; 
;  *  KBSetKCAPForPS2Keyboard()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; 
;  *  KBSetupPS2KeyboardFromLayoutType()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; 
;  *  KBGetPS2KeyboardLayoutType()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Keyboard API constants                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  PhysicalKeyboardLayoutType
;  *  
;  *  Summary:
;  *    Physical keyboard layout types indicate the physical keyboard
;  *    layout. They are returned by the KBGetLayoutType API.
;  

(def-mactype :PhysicalKeyboardLayoutType (find-mactype ':UInt32))
; 
;    * A JIS keyboard layout type.
;    

(defconstant $kKeyboardJIS :|JIS |)
; 
;    * An ANSI keyboard layout type.
;    

(defconstant $kKeyboardANSI :|ANSI|)
; 
;    * An ISO keyboard layout type.
;    

(defconstant $kKeyboardISO :|ISO |)
; 
;    * An unknown physical keyboard layout type.
;    

(defconstant $kKeyboardUnknown #x3F3F3F3F)      ;  '????'

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Keyboard API types                                                               
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  KeyboardLayoutRef
;  *  
;  *  Summary:
;  *    The opaque keyboard layout contains information about a keyboard
;  *    layout. It is used with the keyboard layout APIs.
;  *  
;  *  Discussion:
;  *    KeyboardLayoutRef APIs follow CoreFoundation function naming
;  *    convention. You mustn't release any references you get from APIs
;  *    named "Get."
;  

(def-mactype :KeyboardLayoutRef (find-mactype '(:pointer :OpaqueKeyboardLayoutRef)))
; 
;  *  KeyboardLayoutPropertyTag
;  *  
;  *  Summary:
;  *    Keyboard layout property tags specify the value you want to
;  *    retrieve. They are used with the KLGetKeyboardLayoutProperty API.
;  

(def-mactype :KeyboardLayoutPropertyTag (find-mactype ':UInt32))
; 
;    * The keyboard layout data (const void *).  It is used with the
;    * KeyTranslate API.
;    

(defconstant $kKLKCHRData 0)
; 
;    * The keyboard layout data (const void *).  It is used with the
;    * UCKeyTranslate API.
;    

(defconstant $kKLuchrData 1)
; 
;    * The keyboard layout identifier (KeyboardLayoutIdentifier).
;    

(defconstant $kKLIdentifier 2)
; 
;    * The keyboard layout icon (IconRef).
;    

(defconstant $kKLIcon 3)
; 
;    * The localized keyboard layout name (CFStringRef).
;    

(defconstant $kKLLocalizedName 4)
; 
;    * The keyboard layout name (CFStringRef).
;    

(defconstant $kKLName 5)
; 
;    * The keyboard layout group identifier (SInt32).
;    

(defconstant $kKLGroupIdentifier 6)
; 
;    * The keyboard layout kind (KeyboardLayoutKind).
;    

(defconstant $kKLKind 7)
; 
;  *  KeyboardLayoutKind
;  *  
;  *  Summary:
;  *    Keyboard layout kinds indicate available keyboard layout formats.
;  

(def-mactype :KeyboardLayoutKind (find-mactype ':SInt32))
; 
;    * Both KCHR and uchr formats are available.
;    

(defconstant $kKLKCHRuchrKind 0)
; 
;    * Only KCHR format is avaiable.
;    

(defconstant $kKLKCHRKind 1)
; 
;    * Only uchr format is available.
;    

(defconstant $kKLuchrKind 2)
; 
;  *  KeyboardLayoutIdentifier
;  *  
;  *  Summary:
;  *    Keyboard layout identifiers specify particular keyboard layouts.
;  

(def-mactype :KeyboardLayoutIdentifier (find-mactype ':SInt32))

(defconstant $kKLUSKeyboard 0)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Keyboard API routines                                                            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  KBGetLayoutType()
;  *  
;  *  Summary:
;  *    Returns the physical keyboard layout type.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    iKeyboardType:
;  *      The keyboard type ID.  LMGetKbdType().
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   in KeyboardsLib 1.0 and later
;  

(deftrap-inline "_KBGetLayoutType" 
   ((iKeyboardType :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  iterate keyboard layouts
; 
;  *  KLGetKeyboardLayoutCount()
;  *  
;  *  Summary:
;  *    Returns the number of keyboard layouts.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    oCount:
;  *      On exit, the number of keyboard layouts
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_KLGetKeyboardLayoutCount" 
   ((oCount (:pointer :CFIndex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  KLGetKeyboardLayoutAtIndex()
;  *  
;  *  Summary:
;  *    Retrieves the keyboard layout at the given index.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    iIndex:
;  *      The index of the keyboard layout to retrieve. If the index is
;  *      outside the index space of the keyboard layouts (0 to N-1
;  *      inclusive, where N is the count of the keyboard layouts), the
;  *      behavior is undefined.
;  *    
;  *    oKeyboardLayout:
;  *      On exit, the keyboard layout with the given index.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_KLGetKeyboardLayoutAtIndex" 
   ((iIndex :SInt32)
    (oKeyboardLayout (:pointer :KEYBOARDLAYOUTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;    *** deprecated. ***
;    NOTE: "Indexed" is a wrong name, please use "AtIndex"...
;    OSStatus KLGetIndexedKeyboardLayout(
;                 CFIndex                     iIndex,
;                 KeyboardLayoutRef           *oKeyboardLayout    );
; 
;  get keyboard layout info
; 
;  *  KLGetKeyboardLayoutProperty()
;  *  
;  *  Summary:
;  *    Retrives property value for the given keyboard layout and tag.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    iKeyboardLayout:
;  *      The keyboard layout to be queried. If this parameter is not a
;  *      valid KeyboardLayoutRef, the behavior is undefined.
;  *    
;  *    iPropertyTag:
;  *      The property tag.
;  *    
;  *    oValue:
;  *      On exit, the property value for the given keyboard layout and
;  *      tag.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_KLGetKeyboardLayoutProperty" 
   ((iKeyboardLayout (:pointer :OpaqueKeyboardLayoutRef))
    (iPropertyTag :UInt32)
    (oValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
;  get keyboard layout with identifier or name
; 
;  *  KLGetKeyboardLayoutWithIdentifier()
;  *  
;  *  Summary:
;  *    Retrieves the keyboard layout with the given identifier.
;  *  
;  *  Discussion:
;  *    For now, the identifier is in the range of SInt16 which is
;  *    compatible with the Resource Manager resource ID. However, it
;  *    will become an arbitrary SInt32 value at some point, so do not
;  *    assume it is in SInt16 range or falls into the "script range" of
;  *    the resource IDs.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    iIdentifier:
;  *      The keyboard layout identifier.
;  *    
;  *    oKeyboardLayout:
;  *      On exit, the keyboard layout with the given identifier.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_KLGetKeyboardLayoutWithIdentifier" 
   ((iIdentifier :SInt32)
    (oKeyboardLayout (:pointer :KEYBOARDLAYOUTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  KLGetKeyboardLayoutWithName()
;  *  
;  *  Summary:
;  *    Retrieves the keyboard layout with the given name.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    iName:
;  *      The keyboard layout name.
;  *    
;  *    oKeyboardLayout:
;  *      On exit, the keyboard layout with the given name.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_KLGetKeyboardLayoutWithName" 
   ((iName (:pointer :__CFString))
    (oKeyboardLayout (:pointer :KEYBOARDLAYOUTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
;  get/set current keyboard layout of the current group identifier
; 
;  *  KLGetCurrentKeyboardLayout()
;  *  
;  *  Summary:
;  *    Retrieves the current keyboard layout.
;  *  
;  *  Discussion:
;  *    Retrieves the current keyboard layout for the current keyboard
;  *    script.  To retrive the current keyboard script for Roman
;  *    keyboard script, you need to call KeyScript( smRoman |
;  *    smKeyForceKeyScriptMask ) then call KLGetCurrentKeyboardLayout().
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    oKeyboardLayout:
;  *      On exit, the current keyboard layout.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_KLGetCurrentKeyboardLayout" 
   ((oKeyboardLayout (:pointer :KEYBOARDLAYOUTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  KLSetCurrentKeyboardLayout()
;  *  
;  *  Summary:
;  *    Sets the current keyboard layout.
;  *  
;  *  Discussion:
;  *    Sets the current keyboard layout for the current keyboard script.
;  *     Returns "paramErr" when the current keyboard layout is not
;  *    Unicode and the specified keyboard layout belongs to Unicode
;  *    group.  To set Roman keyboard script's current keyboard layout to
;  *    "U.S." for example, you need to call KeyScript( smRoman |
;  *    smKeyForceKeyScriptMask ) then call KLSetCurrentKeyboardLayout(
;  *    theUSKeyboardLayoutRef ).
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    iKeyboardLayout:
;  *      The keyboard layout.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_KLSetCurrentKeyboardLayout" 
   ((iKeyboardLayout (:pointer :OpaqueKeyboardLayoutRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __KEYBOARDS__ */


(provide-interface "Keyboards")