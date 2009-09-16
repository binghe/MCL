(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Gestalt.h"
; at Sunday July 2,2006 7:23:13 pm.
; 
;      File:       CarbonCore/Gestalt.h
;  
;      Contains:   Gestalt Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1988-2003 by Apple Computer, Inc.  All rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __GESTALT__
; #define __GESTALT__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
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

(def-mactype :SelectorFunctionProcPtr (find-mactype ':pointer)); (OSType selector , long * response)

(def-mactype :SelectorFunctionUPP (find-mactype '(:pointer :OpaqueSelectorFunctionProcPtr)))
; 
;  *  Gestalt()
;  *  
;  *  Summary:
;  *    Gestalt returns information about the operating environment.
;  *  
;  *  Discussion:
;  *    The Gestalt function places the information requested by the
;  *    selector parameter in the variable parameter response . Note that
;  *    Gestalt returns the response from all selectors in a long word,
;  *    which occupies 4 bytes. When not all 4 bytes are needed, the
;  *    significant information appears in the low-order byte or bytes.
;  *    Although the response parameter is declared as a variable
;  *    parameter, you cannot use it to pass information to Gestalt or to
;  *    a Gestalt selector function. Gestalt interprets the response
;  *    parameter as an address at which it is to place the result
;  *    returned by the selector function specified by the selector
;  *    parameter. Gestalt ignores any information already at that
;  *    address.
;  *    
;  *    The Apple-defined selector codes fall into two categories:
;  *    environmental selectors, which supply specific environmental
;  *    information you can use to control the behavior of your
;  *    application, and informational selectors, which supply
;  *    information you can't use to determine what hardware or software
;  *    features are available. You can use one of the selector codes
;  *    defined by Apple (listed in the "Constants" section beginning on
;  *    page 1-14 ) or a selector code defined by a third-party
;  *    product.
;  *    
;  *    The meaning of the value that Gestalt returns in the response
;  *    parameter depends on the selector code with which it was called.
;  *    For example, if you call Gestalt using the gestaltTimeMgrVersion
;  *    selector, it returns a version code in the response parameter. In
;  *    this case, a returned value of 3 indicates that the extended Time
;  *    Manager is available.
;  *    
;  *    In most cases, the last few characters in the selector's symbolic
;  *    name form a suffix that indicates what type of value you can
;  *    expect Gestalt to place in the response parameter. For example,
;  *    if the suffix in a Gestalt selector is Size , then Gestalt
;  *    returns a size in the response parameter.
;  *    
;  *    Attr:  A range of 32 bits, the meanings of which are defined by a
;  *    list of constants. Bit 0 is the least significant bit of the long
;  *    word.
;  *    Count: A number indicating how many of the indicated type of item
;  *    exist.
;  *    Size: A size, usually in bytes.
;  *    Table: The base address of a table.
;  *    Type: An index to a list of feature descriptions.
;  *    Version: A version number, which can be either a constant with a
;  *    defined meaning or an actual version number, usually stored as
;  *    four hexadecimal digits in the low-order word of the return
;  *    value. Implied decimal points may separate digits. The value
;  *    $0701, for example, returned in response to the
;  *    gestaltSystemVersion selector, represents system software version
;  *    7.0.1.
;  *    
;  *    Selectors that have the suffix Attr deserve special attention.
;  *    They cause Gestalt to return a bit field that your application
;  *    must interpret to determine whether a desired feature is present.
;  *    For example, the application-defined sample function
;  *    MyGetSoundAttr , defined in Listing 1-2 on page 1-6 , returns a
;  *    LongInt that contains the Sound Manager attributes field
;  *    retrieved from Gestalt . To determine whether a particular
;  *    feature is available, you need to look at the designated bit.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    selector:
;  *      The selector to return information for
;  *    
;  *    response:
;  *      On exit, the requested information whose format depends on the
;  *      selector specified.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Gestalt" 
   ((selector :OSType)
    (response (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ReplaceGestalt()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use NewGestaltValue instead wherever possible.
;  *  
;  *  Summary:
;  *    Replaces the gestalt function associated with a selector.
;  *  
;  *  Discussion:
;  *    The ReplaceGestalt function replaces the selector function
;  *    associated with an existing selector code.
;  *    
;  *    So that your function can call the function previously associated
;  *    with the selector, ReplaceGestalt places the address of the old
;  *    selector function in the oldGestaltFunction parameter. If
;  *    ReplaceGestalt returns an error of any type, then the value of
;  *    oldGestaltFunction is undefined.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    selector:
;  *      the selector to replace
;  *    
;  *    gestaltFunction:
;  *      a UPP for the new selector function
;  *    
;  *    oldGestaltFunction:
;  *      on exit, a pointer to the UPP of the previously associated with
;  *      the specified selector
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ReplaceGestalt" 
   ((selector :OSType)
    (gestaltFunction (:pointer :OpaqueSelectorFunctionProcPtr))
    (oldGestaltFunction (:pointer :SELECTORFUNCTIONUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  NewGestalt()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use NewGestaltValue instead wherever possible.
;  *  
;  *  Summary:
;  *    Adds a selector code to those already recognized by Gestalt.
;  *  
;  *  Discussion:
;  *    The NewGestalt function registers a specified selector code with
;  *    the Gestalt Manager so that when the Gestalt function is called
;  *    with that selector code, the specified selector function is
;  *    executed. Before calling NewGestalt, you must define a selector
;  *    function callback. See SelectorFunctionProcPtr for a description
;  *    of how to define your selector function.
;  *    
;  *    Registering with the Gestalt Manager is a way for software such
;  *    as system extensions to make their presence known to potential
;  *    users of their services.
;  *    
;  *    In Mac OS X, the selector and replacement value are on a
;  *    per-context basis. That means they are available only to the
;  *    application or other code that installs them. You cannot use this
;  *    function to make information available to another process.
;  *     
;  *    A Gestalt selector registered with NewGestalt() can not be
;  *    deleted.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    selector:
;  *      the selector to create
;  *    
;  *    gestaltFunction:
;  *      a UPP for the new selector function, which Gestalt executes
;  *      when it receives the new selector code. See
;  *      SelectorFunctionProcPtr for more information on the callback
;  *      you need to provide.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.3
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewGestalt" 
   ((selector :OSType)
    (gestaltFunction (:pointer :OpaqueSelectorFunctionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_3
   :OSErr
() )
; 
;  *  NewGestaltValue()
;  *  
;  *  Summary:
;  *    Adds a selector code to those already recognized by Gestalt.
;  *  
;  *  Discussion:
;  *    The NewGestalt function registers a specified selector code with
;  *    the Gestalt Manager so that when the Gestalt function is called
;  *    with that selector code, the specified selector function is
;  *    executed. Before calling NewGestalt, you must define a selector
;  *    function callback. See SelectorFunctionProcPtr for a description
;  *    of how to define your selector function.
;  *    
;  *    Registering with the Gestalt Manager is a way for software such
;  *    as system extensions to make their presence known to potential
;  *    users of their services.
;  *    
;  *    In Mac OS X, the selector and replacement value are on a
;  *    per-context basis. That means they are available only to the
;  *    application or other code that installs them. You cannot use this
;  *    function to make information available to another process.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    selector:
;  *      the selector to create
;  *    
;  *    newValue:
;  *      the value to return for the new selector code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_NewGestaltValue" 
   ((selector :OSType)
    (newValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ReplaceGestaltValue()
;  *  
;  *  Summary:
;  *    Replaces the value that the function Gestalt returns for a
;  *    specified selector code with the value provided to the function.
;  *  
;  *  Discussion:
;  *    You use the function ReplaceGestaltValue to replace an existing
;  *    value. You should not call this function to introduce a value
;  *    that doesn't already exist; instead call the function
;  *    NewGestaltValue.
;  *    
;  *    In Mac OS X, the selector and replacement value are on a
;  *    per-context basis. That means they are available only to the
;  *    application or other code that installs them. You cannot use this
;  *    function to make information available to another process.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    selector:
;  *      the selector to create
;  *    
;  *    replacementValue:
;  *      the new value to return for the new selector code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_ReplaceGestaltValue" 
   ((selector :OSType)
    (replacementValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetGestaltValue()
;  *  
;  *  Summary:
;  *    Sets the value the function Gestalt will return for a specified
;  *    selector code, installing the selector if it was not already
;  *    installed.
;  *  
;  *  Discussion:
;  *    You use SetGestaltValue to establish a value for a selector,
;  *    without regard to whether the selector was already installed.
;  *     
;  *    In Mac OS X, the selector and replacement value are on a
;  *    per-context basis. That means they are available only to the
;  *    application or other code that installs them. You cannot use this
;  *    function to make information available to another process.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    selector:
;  *      the selector to create
;  *    
;  *    newValue:
;  *      the new value to return for the new selector code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_SetGestaltValue" 
   ((selector :OSType)
    (newValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DeleteGestaltValue()
;  *  
;  *  Summary:
;  *    Deletes a Gestalt selector code so that it is no longer
;  *    recognized by Gestalt.
;  *  
;  *  Discussion:
;  *    After calling this function, subsequent query or replacement
;  *    calls for the selector code will fail as if the selector had
;  *    never been installed 
;  *    
;  *    In Mac OS X, the selector and replacement value are on a
;  *    per-context basis. That means they are available only to the
;  *    application or other code that installs them.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    selector:
;  *      the selector to delete
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_DeleteGestaltValue" 
   ((selector :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewSelectorFunctionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSelectorFunctionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSelectorFunctionProcPtr)
() )
; 
;  *  DisposeSelectorFunctionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSelectorFunctionUPP" 
   ((userUPP (:pointer :OpaqueSelectorFunctionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSelectorFunctionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSelectorFunctionUPP" 
   ((selector :OSType)
    (response (:pointer :long))
    (userUPP (:pointer :OpaqueSelectorFunctionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Environment Selectors 

(defconstant $gestaltAddressingModeAttr :|addr|);  addressing mode attributes 

(defconstant $gestalt32BitAddressing 0)         ;  using 32-bit addressing mode 

(defconstant $gestalt32BitSysZone 1)            ;  32-bit compatible system zone 

(defconstant $gestalt32BitCapable 2)            ;  Machine is 32-bit capable 


(defconstant $gestaltAFPClient :|afps|)
(defconstant $gestaltAFPClientVersionMask #xFFFF);  low word of long is the 
;  client version 0x0001 -> 0x0007

(defconstant $gestaltAFPClient3_5 1)
(defconstant $gestaltAFPClient3_6 2)
(defconstant $gestaltAFPClient3_6_1 3)
(defconstant $gestaltAFPClient3_6_2 4)
(defconstant $gestaltAFPClient3_6_3 5)          ;  including 3.6.4, 3.6.5

(defconstant $gestaltAFPClient3_7 6)            ;  including 3.7.1

(defconstant $gestaltAFPClient3_7_2 7)          ;  including 3.7.3, 3.7.4

(defconstant $gestaltAFPClient3_8 8)
(defconstant $gestaltAFPClient3_8_1 9)          ;  including 3.8.2 

(defconstant $gestaltAFPClient3_8_3 10)
(defconstant $gestaltAFPClient3_8_4 11)         ;  including 3.8.5, 3.8.6 

(defconstant $gestaltAFPClientAttributeMask #xFFFF0000);  high word of long is a 
;  set of attribute bits

(defconstant $gestaltAFPClientCfgRsrc 16)       ;  Client uses config resources

(defconstant $gestaltAFPClientSupportsIP 29)    ;  Client supports AFP over TCP/IP

(defconstant $gestaltAFPClientVMUI 30)          ;  Client can put up UI from the PBVolMount trap

(defconstant $gestaltAFPClientMultiReq 31)      ;  Client supports multiple outstanding requests


(defconstant $gestaltAliasMgrAttr :|alis|)      ;  Alias Mgr Attributes 

(defconstant $gestaltAliasMgrPresent 0)         ;  True if the Alias Mgr is present 

(defconstant $gestaltAliasMgrSupportsRemoteAppletalk 1);  True if the Alias Mgr knows about Remote Appletalk 

(defconstant $gestaltAliasMgrSupportsAOCEKeychain 2);  True if the Alias Mgr knows about the AOCE Keychain 

(defconstant $gestaltAliasMgrResolveAliasFileWithMountOptions 3);  True if the Alias Mgr implements gestaltAliasMgrResolveAliasFileWithMountOptions() and IsAliasFile() 

(defconstant $gestaltAliasMgrFollowsAliasesWhenResolving 4)
(defconstant $gestaltAliasMgrSupportsExtendedCalls 5)
(defconstant $gestaltAliasMgrSupportsFSCalls 6) ;  true if Alias Mgr supports HFS+ Calls 

(defconstant $gestaltAliasMgrPrefersPath 7)     ;  True if the Alias Mgr prioritizes the path over file id during resolution by default 

;  Gestalt selector and values for the Appearance Manager 

(defconstant $gestaltAppearanceAttr :|appr|)
(defconstant $gestaltAppearanceExists 0)
(defconstant $gestaltAppearanceCompatMode 1)
;  Gestalt selector for determining Appearance Manager version   
;  If this selector does not exist, but gestaltAppearanceAttr    
;  does, it indicates that the 1.0 version is installed. This    
;  gestalt returns a BCD number representing the version of the  
;  Appearance Manager that is currently running, e.g. 0x0101 for 
;  version 1.0.1.                                                

(defconstant $gestaltAppearanceVersion :|apvr|)

(defconstant $gestaltArbitorAttr :|arb |)
(defconstant $gestaltSerialArbitrationExists 0) ;  this bit if the serial port arbitrator exists


(defconstant $gestaltAppleScriptVersion :|ascv|);  AppleScript version


(defconstant $gestaltAppleScriptAttr :|ascr|)   ;  AppleScript attributes

(defconstant $gestaltAppleScriptPresent 0)
(defconstant $gestaltAppleScriptPowerPCSupport 1)

(defconstant $gestaltATAAttr :|ata |)           ;  ATA is the driver to support IDE hard disks 

(defconstant $gestaltATAPresent 0)              ;  if set, ATA Manager is present 


(defconstant $gestaltATalkVersion :|atkv|)      ;  Detailed AppleTalk version; see comment above for format 


(defconstant $gestaltAppleTalkVersion :|atlk|)  ;  appletalk version 

; 
;     FORMAT OF gestaltATalkVersion RESPONSE
;     --------------------------------------
;     The version is stored in the high three bytes of the response value.  Let us number
;     the bytes in the response value from 0 to 3, where 0 is the least-significant byte.
; 
;         Byte#:     3 2 1 0
;         Value:  0xMMNNRR00
; 
;     Byte 3 (MM) contains the major revision number, byte 2 (NN) contains the minor
;     revision number, and byte 1 (RR) contains a constant that represents the release
;     stage.  Byte 0 always contains 0x00.  The constants for the release stages are:
; 
;         development = 0x20
;         alpha       = 0x40
;         beta        = 0x60
;         final       = 0x80
;         release     = 0x80
; 
;     For example, if you call Gestalt with the 'atkv' selector when AppleTalk version 57
;     is loaded, you receive the long integer response value 0x39008000.
; 

(defconstant $gestaltAUXVersion :|a/ux|)        ;  a/ux version, if present 


(defconstant $gestaltMacOSCompatibilityBoxAttr :|bbox|);  Classic presence and features 

(defconstant $gestaltMacOSCompatibilityBoxPresent 0);  True if running under the Classic 

(defconstant $gestaltMacOSCompatibilityBoxHasSerial 1);  True if Classic serial support is implemented. 

(defconstant $gestaltMacOSCompatibilityBoxless 2);  True if we're Boxless (screen shared with Carbon/Cocoa) 


(defconstant $gestaltBusClkSpeed :|bclk|)       ;  main I/O bus clock speed in hertz 


(defconstant $gestaltCloseViewAttr :|BSDa|)     ;  CloseView attributes 

(defconstant $gestaltCloseViewEnabled 0)        ;  Closeview enabled (dynamic bit - returns current state) 

(defconstant $gestaltCloseViewDisplayMgrFriendly 1);  Closeview compatible with Display Manager (FUTURE) 


(defconstant $gestaltCarbonVersion :|cbon|)     ;  version of Carbon API present in system 


(defconstant $gestaltCFMAttr :|cfrg|)           ;  Selector for information about the Code Fragment Manager 

(defconstant $gestaltCFMPresent 0)              ;  True if the Code Fragment Manager is present 

(defconstant $gestaltCFMPresentMask 1)
(defconstant $gestaltCFM99Present 2)            ;  True if the CFM-99 features are present. 

(defconstant $gestaltCFM99PresentMask 4)

(defconstant $gestaltProcessorCacheLineSize :|csiz|);  The size, in bytes, of the processor cache line. 


(defconstant $gestaltCollectionMgrVersion :|cltn|);  Collection Manager version 


(defconstant $gestaltColorMatchingAttr :|cmta|) ;  ColorSync attributes 

(defconstant $gestaltHighLevelMatching 0)
(defconstant $gestaltColorMatchingLibLoaded 1)

(defconstant $gestaltColorMatchingVersion :|cmtc|)
(defconstant $gestaltColorSync10 #x100)         ;  0x0100 & 0x0110 _Gestalt versions for 1.0-1.0.3 product 

(defconstant $gestaltColorSync11 #x110)         ;    0x0100 == low-level matching only 

(defconstant $gestaltColorSync104 #x104)        ;  Real version, by popular demand 

(defconstant $gestaltColorSync105 #x105)
(defconstant $gestaltColorSync20 #x200)         ;  ColorSync 2.0 

(defconstant $gestaltColorSync21 #x210)
(defconstant $gestaltColorSync211 #x211)
(defconstant $gestaltColorSync212 #x212)
(defconstant $gestaltColorSync213 #x213)
(defconstant $gestaltColorSync25 #x250)
(defconstant $gestaltColorSync26 #x260)
(defconstant $gestaltColorSync261 #x261)
(defconstant $gestaltColorSync30 #x300)

(defconstant $gestaltControlMgrVersion :|cmvr|) ;  NOTE: The first version we return is 3.0.1, on Mac OS X plus update 2


(defconstant $gestaltControlMgrAttr :|cntl|)    ;  Control Mgr

(defconstant $gestaltControlMgrPresent 1)       ;  NOTE: this is a bit mask, whereas all other Gestalt constants of
;  this type are bit index values.   Universal Interfaces 3.2 slipped
;  out the door with this mistake.

(defconstant $gestaltControlMgrPresentBit 0)    ;  bit number

(defconstant $gestaltControlMsgPresentMask 1)

(defconstant $gestaltConnMgrAttr :|conn|)       ;  connection mgr attributes    

(defconstant $gestaltConnMgrPresent 0)
(defconstant $gestaltConnMgrCMSearchFix 1)      ;  Fix to CMAddSearch?     

(defconstant $gestaltConnMgrErrorString 2)      ;  has CMGetErrorString() 

(defconstant $gestaltConnMgrMultiAsyncIO 3)     ;  CMNewIOPB, CMDisposeIOPB, CMPBRead, CMPBWrite, CMPBIOKill 


(defconstant $gestaltColorPickerVersion :|cpkr|);  returns version of ColorPicker 

(defconstant $gestaltColorPicker :|cpkr|)       ;  gestaltColorPicker is old name for gestaltColorPickerVersion 


(defconstant $gestaltComponentMgr :|cpnt|)      ;  Component Mgr version 

(defconstant $gestaltComponentPlatform :|copl|) ;  Component Platform number 

; 
;     The gestaltNativeCPUtype ('cput') selector can be used to determine the
;     native CPU type for all Macs running System 7.5 or later.
; 
;     However, the use of these selectors for pretty much anything is discouraged.
;     If you are trying to determine if you can use a particular processor or
;     operating system feature, it would be much better to check directly for that
;     feature using one of the apis for doing so -- like, sysctl() or sysctlbyname().
;     Those apis return information directly from the operating system and kernel.  By
;     using those apis you may be able to avoid linking against Frameworks which you
;     otherwise don't need, and may lessen the memory and code footprint of your
;     applications.
;     
;     The gestaltNativeCPUfamily ('cpuf') selector can be used to determine the
;     general family the native CPU is in.
; 
;     gestaltNativeCPUfamily uses the same results as gestaltNativeCPUtype, but
;     will only return certain CPU values.
;     
;     IMPORTANT NOTE: gestaltNativeCPUFamily may no longer be updated for any new
;                     processor families introduced after the 970.  If there are
;                     processor specific features you need to be checking for in
;                     your code, use one of the appropriate apis to get for those
;                     exact features instead of assuming that all members of a given
;                     cpu family exhibit the same behaviour.  The most appropriate api
;                     to look at is sysctl() and sysctlbyname(), which return information
;                     direct from the kernel about the system.
; 

(defconstant $gestaltNativeCPUtype :|cput|)     ;  Native CPU type                          

(defconstant $gestaltNativeCPUfamily :|cpuf|)   ;  Native CPU family                      

(defconstant $gestaltCPU68000 0)                ;  Various 68k CPUs...    

(defconstant $gestaltCPU68010 1)
(defconstant $gestaltCPU68020 2)
(defconstant $gestaltCPU68030 3)
(defconstant $gestaltCPU68040 4)
(defconstant $gestaltCPU601 #x101)              ;  IBM 601                               

(defconstant $gestaltCPU603 #x103)
(defconstant $gestaltCPU604 #x104)
(defconstant $gestaltCPU603e #x106)
(defconstant $gestaltCPU603ev #x107)
(defconstant $gestaltCPU750 #x108)              ;  Also 740 - "G3" 

(defconstant $gestaltCPU604e #x109)
(defconstant $gestaltCPU604ev #x10A)            ;  Mach 5, 250Mhz and up 

(defconstant $gestaltCPUG4 #x10C)               ;  Max 

(defconstant $gestaltCPUG47450 #x110)           ;  Vger , Altivec 


(defconstant $gestaltCPUApollo #x111)           ;  Apollo , Altivec, G4 7455 

(defconstant $gestaltCPUG47447 #x112)
(defconstant $gestaltCPU750FX #x120)            ;  Sahara,G3 like thing 

(defconstant $gestaltCPU970 #x139)
;  x86 CPUs all start with 'i' in the high nybble 

(defconstant $gestaltCPU486 :|i486|)
(defconstant $gestaltCPUPentium :|i586|)
(defconstant $gestaltCPUPentiumPro :|i5pr|)
(defconstant $gestaltCPUPentiumII :|i5ii|)
(defconstant $gestaltCPUX86 :|ixxx|)

(defconstant $gestaltCRMAttr :|crm |)           ;  comm resource mgr attributes 

(defconstant $gestaltCRMPresent 0)
(defconstant $gestaltCRMPersistentFix 1)        ;  fix for persistent tools 

(defconstant $gestaltCRMToolRsrcCalls 2)        ;  has CRMGetToolResource/ReleaseToolResource 


(defconstant $gestaltControlStripVersion :|csvr|);  Control Strip version (was 'sdvr') 


(defconstant $gestaltCTBVersion :|ctbv|)        ;  CommToolbox version 


(defconstant $gestaltDBAccessMgrAttr :|dbac|)   ;  Database Access Mgr attributes 

(defconstant $gestaltDBAccessMgrPresent 0)      ;  True if Database Access Mgr present 


(defconstant $gestaltDiskCacheSize :|dcsz|)     ;  Size of disk cache's buffers, in bytes 


(defconstant $gestaltSDPFindVersion :|dfnd|)    ;  OCE Standard Directory Panel


(defconstant $gestaltDictionaryMgrAttr :|dict|) ;  Dictionary Manager attributes 

(defconstant $gestaltDictionaryMgrPresent 0)    ;  Dictionary Manager attributes 


(defconstant $gestaltDITLExtAttr :|ditl|)       ;  AppenDITL, etc. calls from CTB 

(defconstant $gestaltDITLExtPresent 0)          ;  True if calls are present 

(defconstant $gestaltDITLExtSupportsIctb 1)     ;  True if AppendDITL, ShortenDITL support 'ictb's 


(defconstant $gestaltDialogMgrAttr :|dlog|)     ;  Dialog Mgr

(defconstant $gestaltDialogMgrPresent 1)        ;  NOTE: this is a bit mask, whereas all other Gestalt constants of
;  this type are bit index values.   Universal Interfaces 3.2 slipped
;  out the door with this mistake.

(defconstant $gestaltDialogMgrPresentBit 0)     ;  bit number

(defconstant $gestaltDialogMgrHasAquaAlertBit 2);  bit number

(defconstant $gestaltDialogMgrPresentMask 1)
(defconstant $gestaltDialogMgrHasAquaAlertMask 4)
(defconstant $gestaltDialogMsgPresentMask 1)    ;  compatibility mask


(defconstant $gestaltDesktopPicturesAttr :|dkpx|);  Desktop Pictures attributes 

(defconstant $gestaltDesktopPicturesInstalled 0);  True if control panel is installed 

(defconstant $gestaltDesktopPicturesDisplayed 1);  True if a picture is currently displayed 


(defconstant $gestaltDisplayMgrVers :|dplv|)    ;  Display Manager version 


(defconstant $gestaltDisplayMgrAttr :|dply|)    ;  Display Manager attributes 

(defconstant $gestaltDisplayMgrPresent 0)       ;  True if Display Mgr is present 

(defconstant $gestaltDisplayMgrCanSwitchMirrored 2);  True if Display Mgr can switch modes on mirrored displays 

(defconstant $gestaltDisplayMgrSetDepthNotifies 3);  True SetDepth generates displays mgr notification 

(defconstant $gestaltDisplayMgrCanConfirm 4)    ;  True Display Manager supports DMConfirmConfiguration 

(defconstant $gestaltDisplayMgrColorSyncAware 5);  True if Display Manager supports profiles for displays 

(defconstant $gestaltDisplayMgrGeneratesProfiles 6);  True if Display Manager will automatically generate profiles for displays 

(defconstant $gestaltDisplayMgrSleepNotifies 7) ;  True if Display Mgr generates "displayWillSleep", "displayDidWake" notifications 


(defconstant $gestaltDragMgrAttr :|drag|)       ;  Drag Manager attributes 

(defconstant $gestaltDragMgrPresent 0)          ;  Drag Manager is present 

(defconstant $gestaltDragMgrFloatingWind 1)     ;  Drag Manager supports floating windows 

(defconstant $gestaltPPCDragLibPresent 2)       ;  Drag Manager PPC DragLib is present 

(defconstant $gestaltDragMgrHasImageSupport 3)  ;  Drag Manager allows SetDragImage call 

(defconstant $gestaltCanStartDragInFloatWindow 4);  Drag Manager supports starting a drag in a floating window 

(defconstant $gestaltSetDragImageUpdates 5)     ;  Drag Manager supports drag image updating via SetDragImage 


(defconstant $gestaltDrawSprocketVersion :|dspv|);  Draw Sprocket version (as a NumVersion) 


(defconstant $gestaltDigitalSignatureVersion :|dsig|);  returns Digital Signature Toolbox version in low-order word

; 
;    Desktop Printing Feature Gestalt
;    Use this gestalt to check if third-party printer driver support is available
; 

(defconstant $gestaltDTPFeatures :|dtpf|)
(defconstant $kDTPThirdPartySupported 4)        ;  mask for checking if third-party drivers are supported

; 
;    Desktop Printer Info Gestalt
;    Use this gestalt to get a hold of information for all of the active desktop printers
; 

(defconstant $gestaltDTPInfo :|dtpx|)           ;  returns GestaltDTPInfoHdle


(defconstant $gestaltEasyAccessAttr :|easy|)    ;  Easy Access attributes 

(defconstant $gestaltEasyAccessOff 0)           ;  if Easy Access present, but off (no icon) 

(defconstant $gestaltEasyAccessOn 1)            ;  if Easy Access "On" 

(defconstant $gestaltEasyAccessSticky 2)        ;  if Easy Access "Sticky" 

(defconstant $gestaltEasyAccessLocked 3)        ;  if Easy Access "Locked" 


(defconstant $gestaltEditionMgrAttr :|edtn|)    ;  Edition Mgr attributes 

(defconstant $gestaltEditionMgrPresent 0)       ;  True if Edition Mgr present 

(defconstant $gestaltEditionMgrTranslationAware 1);  True if edition manager is translation manager aware 


(defconstant $gestaltAppleEventsAttr :|evnt|)   ;  Apple Events attributes 

(defconstant $gestaltAppleEventsPresent 0)      ;  True if Apple Events present 

(defconstant $gestaltScriptingSupport 1)
(defconstant $gestaltOSLInSystem 2)             ;  OSL is in system so donÕt use the one linked in to app 

(defconstant $gestaltSupportsApplicationURL 4)  ;  Supports the typeApplicationURL addressing mode 


(defconstant $gestaltExtensionTableVersion :|etbl|);  ExtensionTable version 


(defconstant $gestaltFBCIndexingState :|fbci|)  ;  Find By Content indexing state

(defconstant $gestaltFBCindexingSafe 0)         ;  any search will result in synchronous wait

(defconstant $gestaltFBCindexingCritical 1)     ;  any search will execute immediately


(defconstant $gestaltFBCVersion :|fbcv|)        ;  Find By Content version

(defconstant $gestaltFBCCurrentVersion 17)      ;  First release for OS 8/9

(defconstant $gestaltOSXFBCCurrentVersion #x100);  First release for OS X


(defconstant $gestaltFileMappingAttr :|flmp|)   ;  File mapping attributes

(defconstant $gestaltFileMappingPresent 0)      ;  bit is set if file mapping APIs are present

(defconstant $gestaltFileMappingMultipleFilesFix 1);  bit is set if multiple files per volume can be mapped


(defconstant $gestaltFloppyAttr :|flpy|)        ;  Floppy disk drive/driver attributes 

(defconstant $gestaltFloppyIsMFMOnly 0)         ;  Floppy driver only supports MFM disk formats 

(defconstant $gestaltFloppyIsManualEject 1)     ;  Floppy drive, driver, and file system are in manual-eject mode 

(defconstant $gestaltFloppyUsesDiskInPlace 2)   ;  Floppy drive must have special DISK-IN-PLACE output; standard DISK-CHANGED not used 


(defconstant $gestaltFinderAttr :|fndr|)        ;  Finder attributes 

(defconstant $gestaltFinderDropEvent 0)         ;  Finder recognizes drop event 

(defconstant $gestaltFinderMagicPlacement 1)    ;  Finder supports magic icon placement 

(defconstant $gestaltFinderCallsAEProcess 2)    ;  Finder calls AEProcessAppleEvent 

(defconstant $gestaltOSLCompliantFinder 3)      ;  Finder is scriptable and recordable 

(defconstant $gestaltFinderSupports4GBVolumes 4);  Finder correctly handles 4GB volumes 

(defconstant $gestaltFinderHasClippings 6)      ;  Finder supports Drag Manager clipping files 

(defconstant $gestaltFinderFullDragManagerSupport 7);  Finder accepts 'hfs ' flavors properly 

(defconstant $gestaltFinderFloppyRootComments 8);  in MacOS 8 and later, will be set if Finder ever supports comments on Floppy icons 

(defconstant $gestaltFinderLargeAndNotSavedFlavorsOK 9);  in MacOS 8 and later, this bit is set if drags with >1024-byte flavors and flavorNotSaved flavors work reliably 

(defconstant $gestaltFinderUsesExtensibleFolderManager 10);  Finder uses Extensible Folder Manager (for example, for Magic Routing) 

(defconstant $gestaltFinderUnderstandsRedirectedDesktopFolder 11);  Finder deals with startup disk's desktop folder residing on another disk 


(defconstant $gestaltFindFolderAttr :|fold|)    ;  Folder Mgr attributes 

(defconstant $gestaltFindFolderPresent 0)       ;  True if Folder Mgr present 

(defconstant $gestaltFolderDescSupport 1)       ;  True if Folder Mgr has FolderDesc calls 

(defconstant $gestaltFolderMgrFollowsAliasesWhenResolving 2);  True if Folder Mgr follows folder aliases 

(defconstant $gestaltFolderMgrSupportsExtendedCalls 3);  True if Folder Mgr supports the Extended calls 

(defconstant $gestaltFolderMgrSupportsDomains 4);  True if Folder Mgr supports domains for the first parameter to FindFolder 

(defconstant $gestaltFolderMgrSupportsFSCalls 5);  True if FOlder manager supports __FindFolderFSRef & __FindFolderExtendedFSRef 


(defconstant $gestaltFindFolderRedirectionAttr :|fole|)

(defconstant $gestaltFontMgrAttr :|font|)       ;  Font Mgr attributes 

(defconstant $gestaltOutlineFonts 0)            ;  True if Outline Fonts supported 


(defconstant $gestaltFPUType :|fpu |)           ;  fpu type 

(defconstant $gestaltNoFPU 0)                   ;  no FPU 

(defconstant $gestalt68881 1)                   ;  68881 FPU 

(defconstant $gestalt68882 2)                   ;  68882 FPU 

(defconstant $gestalt68040FPU 3)                ;  68040 built-in FPU 


(defconstant $gestaltFSAttr :|fs  |)            ;  file system attributes 

(defconstant $gestaltFullExtFSDispatching 0)    ;  has really cool new HFSDispatch dispatcher 

(defconstant $gestaltHasFSSpecCalls 1)          ;  has FSSpec calls 

(defconstant $gestaltHasFileSystemManager 2)    ;  has a file system manager 

(defconstant $gestaltFSMDoesDynamicLoad 3)      ;  file system manager supports dynamic loading 

(defconstant $gestaltFSSupports4GBVols 4)       ;  file system supports 4 gigabyte volumes 

(defconstant $gestaltFSSupports2TBVols 5)       ;  file system supports 2 terabyte volumes 

(defconstant $gestaltHasExtendedDiskInit 6)     ;  has extended Disk Initialization calls 

(defconstant $gestaltDTMgrSupportsFSM 7)        ;  Desktop Manager support FSM-based foreign file systems 

(defconstant $gestaltFSNoMFSVols 8)             ;  file system doesn't supports MFS volumes 

(defconstant $gestaltFSSupportsHFSPlusVols 9)   ;  file system supports HFS Plus volumes 

(defconstant $gestaltFSIncompatibleDFA82 10)    ;  VCB and FCB structures changed; DFA 8.2 is incompatible 


(defconstant $gestaltFSSupportsDirectIO 11)     ;  file system supports DirectIO 


(defconstant $gestaltHasHFSPlusAPIs 12)         ;  file system supports HFS Plus APIs 

(defconstant $gestaltMustUseFCBAccessors 13)    ;  FCBSPtr and FSFCBLen are invalid - must use FSM FCB accessor functions

(defconstant $gestaltFSUsesPOSIXPathsForConversion 14);  The path interchange routines operate on POSIX paths instead of HFS paths 

(defconstant $gestaltFSSupportsExclusiveLocks 15);  File system uses POSIX O_EXLOCK for opens 

(defconstant $gestaltFSSupportsHardLinkDetection 16);  File system returns if an item is a hard link 


(defconstant $gestaltAdminFeaturesFlagsAttr :|fred|);  a set of admin flags, mostly useful internally. 

(defconstant $gestaltFinderUsesSpecialOpenFoldersFile 0);  the Finder uses a special file to store the list of open folders 


(defconstant $gestaltFSMVersion :|fsm |)        ;  returns version of HFS External File Systems Manager (FSM) 


(defconstant $gestaltFXfrMgrAttr :|fxfr|)       ;  file transfer manager attributes 

(defconstant $gestaltFXfrMgrPresent 0)
(defconstant $gestaltFXfrMgrMultiFile 1)        ;  supports FTSend and FTReceive 

(defconstant $gestaltFXfrMgrErrorString 2)      ;  supports FTGetErrorString 

(defconstant $gestaltFXfrMgrAsync 3)            ; supports FTSendAsync, FTReceiveAsync, FTCompletionAsync


(defconstant $gestaltGraphicsAttr :|gfxa|)      ;  Quickdraw GX attributes selector 

(defconstant $gestaltGraphicsIsDebugging 1)
(defconstant $gestaltGraphicsIsLoaded 2)
(defconstant $gestaltGraphicsIsPowerPC 4)

(defconstant $gestaltGraphicsVersion :|grfx|)   ;  Quickdraw GX version selector 

(defconstant $gestaltCurrentGraphicsVersion #x10200);  the version described in this set of headers 


(defconstant $gestaltHardwareAttr :|hdwr|)      ;  hardware attributes 

(defconstant $gestaltHasVIA1 0)                 ;  VIA1 exists 

(defconstant $gestaltHasVIA2 1)                 ;  VIA2 exists 

(defconstant $gestaltHasASC 3)                  ;  Apple Sound Chip exists 

(defconstant $gestaltHasSCC 4)                  ;  SCC exists 

(defconstant $gestaltHasSCSI 7)                 ;  SCSI exists 

(defconstant $gestaltHasSoftPowerOff 19)        ;  Capable of software power off 

(defconstant $gestaltHasSCSI961 21)             ;  53C96 SCSI controller on internal bus 

(defconstant $gestaltHasSCSI962 22)             ;  53C96 SCSI controller on external bus 

(defconstant $gestaltHasUniversalROM 24)        ;  Do we have a Universal ROM? 

(defconstant $gestaltHasEnhancedLtalk 30)       ;  Do we have Enhanced LocalTalk? 


(defconstant $gestaltHelpMgrAttr :|help|)       ;  Help Mgr Attributes 

(defconstant $gestaltHelpMgrPresent 0)          ;  true if help mgr is present 

(defconstant $gestaltHelpMgrExtensions 1)       ;  true if help mgr extensions are installed 

(defconstant $gestaltAppleGuideIsDebug 30)
(defconstant $gestaltAppleGuidePresent 31)      ;  true if AppleGuide is installed 


(defconstant $gestaltHardwareVendorCode :|hrad|);  Returns hardware vendor information 

(defconstant $gestaltHardwareVendorApple :|Appl|);  Hardware built by Apple 


(defconstant $gestaltCompressionMgr :|icmp|)    ;  returns version of the Image Compression Manager 


(defconstant $gestaltIconUtilitiesAttr :|icon|) ;  Icon Utilities attributes  (Note: available in System 7.0, despite gestalt) 

(defconstant $gestaltIconUtilitiesPresent 0)    ;  true if icon utilities are present 

(defconstant $gestaltIconUtilitiesHas48PixelIcons 1);  true if 48x48 icons are supported by IconUtilities 

(defconstant $gestaltIconUtilitiesHas32BitIcons 2);  true if 32-bit deep icons are supported 

(defconstant $gestaltIconUtilitiesHas8BitDeepMasks 3);  true if 8-bit deep masks are supported 

(defconstant $gestaltIconUtilitiesHasIconServices 4);  true if IconServices is present 


(defconstant $gestaltInternalDisplay :|idsp|)   ;  slot number of internal display location 

; 
;     To obtain information about the connected keyboard(s), one should
;     use the ADB Manager API.  See Technical Note OV16 for details.
; 

(defconstant $gestaltKeyboardType :|kbd |)      ;  keyboard type 

(defconstant $gestaltMacKbd 1)
(defconstant $gestaltMacAndPad 2)
(defconstant $gestaltMacPlusKbd 3)
(defconstant $gestaltExtADBKbd 4)
(defconstant $gestaltStdADBKbd 5)
(defconstant $gestaltPrtblADBKbd 6)
(defconstant $gestaltPrtblISOKbd 7)
(defconstant $gestaltStdISOADBKbd 8)
(defconstant $gestaltExtISOADBKbd 9)
(defconstant $gestaltADBKbdII 10)
(defconstant $gestaltADBISOKbdII 11)
(defconstant $gestaltPwrBookADBKbd 12)
(defconstant $gestaltPwrBookISOADBKbd 13)
(defconstant $gestaltAppleAdjustKeypad 14)
(defconstant $gestaltAppleAdjustADBKbd 15)
(defconstant $gestaltAppleAdjustISOKbd 16)
(defconstant $gestaltJapanAdjustADBKbd 17)      ;  Japan Adjustable Keyboard 

(defconstant $gestaltPwrBkExtISOKbd 20)         ;  PowerBook Extended International Keyboard with function keys 

(defconstant $gestaltPwrBkExtJISKbd 21)         ;  PowerBook Extended Japanese Keyboard with function keys      

(defconstant $gestaltPwrBkExtADBKbd 24)         ;  PowerBook Extended Domestic Keyboard with function keys      

(defconstant $gestaltPS2Keyboard 27)            ;  PS2 keyboard 

(defconstant $gestaltPwrBkSubDomKbd 28)         ;  PowerBook Subnote Domestic Keyboard with function keys w/  inverted T  

(defconstant $gestaltPwrBkSubISOKbd 29)         ;  PowerBook Subnote International Keyboard with function keys w/  inverted T     

(defconstant $gestaltPwrBkSubJISKbd 30)         ;  PowerBook Subnote Japanese Keyboard with function keys w/ inverted T    

(defconstant $gestaltPwrBkEKDomKbd #xC3)        ;  (0xC3) PowerBook Domestic Keyboard with Embedded Keypad, function keys & inverted T    

(defconstant $gestaltPwrBkEKISOKbd #xC4)        ;  (0xC4) PowerBook International Keyboard with Embedded Keypad, function keys & inverted T   

(defconstant $gestaltPwrBkEKJISKbd #xC5)        ;  (0xC5) PowerBook Japanese Keyboard with Embedded Keypad, function keys & inverted T      

(defconstant $gestaltUSBCosmoANSIKbd #xC6)      ;  (0xC6) original USB Domestic (ANSI) Keyboard 

(defconstant $gestaltUSBCosmoISOKbd #xC7)       ;  (0xC7) original USB International (ISO) Keyboard 

(defconstant $gestaltUSBCosmoJISKbd #xC8)       ;  (0xC8) original USB Japanese (JIS) Keyboard 

(defconstant $gestaltPwrBk99JISKbd #xC9)        ;  (0xC9) '99 PowerBook JIS Keyboard with Embedded Keypad, function keys & inverted T               

(defconstant $gestaltUSBAndyANSIKbd #xCC)       ;  (0xCC) USB Pro Keyboard Domestic (ANSI) Keyboard                                 

(defconstant $gestaltUSBAndyISOKbd #xCD)        ;  (0xCD) USB Pro Keyboard International (ISO) Keyboard                               

(defconstant $gestaltUSBAndyJISKbd #xCE)        ;  (0xCE) USB Pro Keyboard Japanese (JIS) Keyboard                                    


(defconstant $gestaltPortable2001ANSIKbd #xCA)  ;  (0xCA) PowerBook and iBook Domestic (ANSI) Keyboard with 2nd cmd key right & function key moves.     

(defconstant $gestaltPortable2001ISOKbd #xCB)   ;  (0xCB) PowerBook and iBook International (ISO) Keyboard with 2nd cmd key right & function key moves.   

(defconstant $gestaltPortable2001JISKbd #xCF)   ;  (0xCF) PowerBook and iBook Japanese (JIS) Keyboard with function key moves.                   


(defconstant $gestaltUSBProF16ANSIKbd 34)       ;  (0x22) USB Pro Keyboard w/ F16 key Domestic (ANSI) Keyboard 

(defconstant $gestaltUSBProF16ISOKbd 35)        ;  (0x23) USB Pro Keyboard w/ F16 key International (ISO) Keyboard 

(defconstant $gestaltUSBProF16JISKbd 36)        ;  (0x24) USB Pro Keyboard w/ F16 key Japanese (JIS) Keyboard 

(defconstant $gestaltProF16ANSIKbd 31)          ;  (0x1F) Pro Keyboard w/F16 key Domestic (ANSI) Keyboard 

(defconstant $gestaltProF16ISOKbd 32)           ;  (0x20) Pro Keyboard w/F16 key International (ISO) Keyboard 

(defconstant $gestaltProF16JISKbd 33)           ;  (0x21) Pro Keyboard w/F16 key Japanese (JIS) Keyboard 

; 
;     This gestalt indicates the highest UDF version that the active UDF implementation supports.
;     The value should be assembled from a read version (upper word) and a write version (lower word)
; 

(defconstant $gestaltUDFSupport :|kudf|)        ;     Used for communication between UDF implementations


(defconstant $gestaltLowMemorySize :|lmem|)     ;  size of low memory area 


(defconstant $gestaltLogicalRAMSize :|lram|)    ;  logical ram size 

; 
;     MACHINE TYPE CONSTANTS NAMING CONVENTION
; 
;         All future machine type constant names take the following form:
; 
;             gestalt<lineName><modelNumber>
; 
;     Line Names
; 
;         The following table contains the lines currently produced by Apple and the
;         lineName substrings associated with them:
; 
;             Line                        lineName
;             -------------------------   ------------
;             Macintosh LC                "MacLC"
;             Macintosh Performa          "Performa"
;             Macintosh PowerBook         "PowerBook"
;             Macintosh PowerBook Duo     "PowerBookDuo"
;             Power Macintosh             "PowerMac"
;             Apple Workgroup Server      "AWS"
; 
;         The following table contains lineNames for some discontinued lines:
; 
;             Line                        lineName
;             -------------------------   ------------
;             Macintosh Quadra            "MacQuadra" (preferred)
;                                         "Quadra" (also used, but not preferred)
;             Macintosh Centris           "MacCentris"
; 
;     Model Numbers
; 
;         The modelNumber is a string representing the specific model of the machine
;         within its particular line.  For example, for the Power Macintosh 8100/80,
;         the modelNumber is "8100".
; 
;         Some Performa & LC model numbers contain variations in the rightmost 1 or 2
;         digits to indicate different RAM and Hard Disk configurations.  A single
;         machine type is assigned for all variations of a specific model number.  In
;         this case, the modelNumber string consists of the constant leftmost part
;         of the model number with 0s for the variant digits.  For example, the
;         Performa 6115 and Performa 6116 are both return the same machine type
;         constant:  gestaltPerforma6100.
; 
; 
;     OLD NAMING CONVENTIONS
; 
;     The "Underscore Speed" suffix
; 
;         In the past, Apple differentiated between machines that had the same model
;         number but different speeds.  For example, the Power Macintosh 8100/80 and
;         Power Macintosh 8100/100 return different machine type constants.  This is
;         why some existing machine type constant names take the form:
; 
;             gestalt<lineName><modelNumber>_<speed>
; 
;         e.g.
; 
;             gestaltPowerMac8100_110
;             gestaltPowerMac7100_80
;             gestaltPowerMac7100_66
; 
;         It is no longer necessary to use the "underscore speed" suffix.  Starting with
;         the Power Surge machines (Power Macintosh 7200, 7500, 8500 and 9500), speed is
;         no longer used to differentiate between machine types.  This is why a Power
;         Macintosh 7200/75 and a Power Macintosh 7200/90 return the same machine type
;         constant:  gestaltPowerMac7200.
; 
;     The "Screen Type" suffix
; 
;         All PowerBook models prior to the PowerBook 190, and all PowerBook Duo models
;         before the PowerBook Duo 2300 take the form:
; 
;             gestalt<lineName><modelNumber><screenType>
; 
;         Where <screenType> is "c" or the empty string.
; 
;         e.g.
; 
;             gestaltPowerBook100
;             gestaltPowerBookDuo280
;             gestaltPowerBookDuo280c
;             gestaltPowerBook180
;             gestaltPowerBook180c
; 
;         Starting with the PowerBook 190 series and the PowerBook Duo 2300 series, machine
;         types are no longer differentiated based on screen type.  This is why a PowerBook
;         5300cs/100 and a PowerBook 5300c/100 both return the same machine type constant:
;         gestaltPowerBook5300.
; 
;         Macintosh LC 630                gestaltMacLC630
;         Macintosh Performa 6200         gestaltPerforma6200
;         Macintosh Quadra 700            gestaltQuadra700
;         Macintosh PowerBook 5300        gestaltPowerBook5300
;         Macintosh PowerBook Duo 2300    gestaltPowerBookDuo2300
;         Power Macintosh 8500            gestaltPowerMac8500
; 

(defconstant $gestaltMachineType :|mach|)       ;  machine type 

(defconstant $gestaltClassic 1)
(defconstant $gestaltMacXL 2)
(defconstant $gestaltMac512KE 3)
(defconstant $gestaltMacPlus 4)
(defconstant $gestaltMacSE 5)
(defconstant $gestaltMacII 6)
(defconstant $gestaltMacIIx 7)
(defconstant $gestaltMacIIcx 8)
(defconstant $gestaltMacSE030 9)
(defconstant $gestaltPortable 10)
(defconstant $gestaltMacIIci 11)
(defconstant $gestaltPowerMac8100_120 12)
(defconstant $gestaltMacIIfx 13)
(defconstant $gestaltMacClassic 17)
(defconstant $gestaltMacIIsi 18)
(defconstant $gestaltMacLC 19)
(defconstant $gestaltMacQuadra900 20)
(defconstant $gestaltPowerBook170 21)
(defconstant $gestaltMacQuadra700 22)
(defconstant $gestaltClassicII 23)
(defconstant $gestaltPowerBook100 24)
(defconstant $gestaltPowerBook140 25)
(defconstant $gestaltMacQuadra950 26)
(defconstant $gestaltMacLCIII 27)
(defconstant $gestaltPerforma450 27)
(defconstant $gestaltPowerBookDuo210 29)
(defconstant $gestaltMacCentris650 30)
(defconstant $gestaltPowerBookDuo230 32)
(defconstant $gestaltPowerBook180 33)
(defconstant $gestaltPowerBook160 34)
(defconstant $gestaltMacQuadra800 35)
(defconstant $gestaltMacQuadra650 36)
(defconstant $gestaltMacLCII 37)
(defconstant $gestaltPowerBookDuo250 38)
(defconstant $gestaltAWS9150_80 39)
(defconstant $gestaltPowerMac8100_110 40)
(defconstant $gestaltAWS8150_110 40)
(defconstant $gestaltPowerMac5200 41)
(defconstant $gestaltPowerMac5260 41)
(defconstant $gestaltPerforma5300 41)
(defconstant $gestaltPowerMac6200 42)
(defconstant $gestaltPerforma6300 42)
(defconstant $gestaltMacIIvi 44)
(defconstant $gestaltMacIIvm 45)
(defconstant $gestaltPerforma600 45)
(defconstant $gestaltPowerMac7100_80 47)
(defconstant $gestaltMacIIvx 48)
(defconstant $gestaltMacColorClassic 49)
(defconstant $gestaltPerforma250 49)
(defconstant $gestaltPowerBook165c 50)
(defconstant $gestaltMacCentris610 52)
(defconstant $gestaltMacQuadra610 53)
(defconstant $gestaltPowerBook145 54)
(defconstant $gestaltPowerMac8100_100 55)
(defconstant $gestaltMacLC520 56)
(defconstant $gestaltAWS9150_120 57)
(defconstant $gestaltPowerMac6400 58)
(defconstant $gestaltPerforma6400 58)
(defconstant $gestaltPerforma6360 58)
(defconstant $gestaltMacCentris660AV 60)
(defconstant $gestaltMacQuadra660AV 60)
(defconstant $gestaltPerforma46x 62)
(defconstant $gestaltPowerMac8100_80 65)
(defconstant $gestaltAWS8150_80 65)
(defconstant $gestaltPowerMac9500 67)
(defconstant $gestaltPowerMac9600 67)
(defconstant $gestaltPowerMac7500 68)
(defconstant $gestaltPowerMac7600 68)
(defconstant $gestaltPowerMac8500 69)
(defconstant $gestaltPowerMac8600 69)
(defconstant $gestaltAWS8550 68)
(defconstant $gestaltPowerBook180c 71)
(defconstant $gestaltPowerBook520 72)
(defconstant $gestaltPowerBook520c 72)
(defconstant $gestaltPowerBook540 72)
(defconstant $gestaltPowerBook540c 72)
(defconstant $gestaltPowerMac5400 74)
(defconstant $gestaltPowerMac6100_60 75)
(defconstant $gestaltAWS6150_60 75)
(defconstant $gestaltPowerBookDuo270c 77)
(defconstant $gestaltMacQuadra840AV 78)
(defconstant $gestaltPerforma550 80)
(defconstant $gestaltPowerBook165 84)
(defconstant $gestaltPowerBook190 85)
(defconstant $gestaltMacTV 88)
(defconstant $gestaltMacLC475 89)
(defconstant $gestaltPerforma47x 89)
(defconstant $gestaltMacLC575 92)
(defconstant $gestaltMacQuadra605 94)
(defconstant $gestaltMacQuadra630 98)
(defconstant $gestaltMacLC580 99)
(defconstant $gestaltPerforma580 99)
(defconstant $gestaltPowerMac6100_66 100)
(defconstant $gestaltAWS6150_66 100)
(defconstant $gestaltPowerBookDuo280 102)
(defconstant $gestaltPowerBookDuo280c 103)
(defconstant $gestaltPowerMacLC475 104)         ;  Mac LC 475 & PPC Processor Upgrade Card

(defconstant $gestaltPowerMacPerforma47x 104)
(defconstant $gestaltPowerMacLC575 105)         ;  Mac LC 575 & PPC Processor Upgrade Card 

(defconstant $gestaltPowerMacPerforma57x 105)
(defconstant $gestaltPowerMacQuadra630 106)     ;  Quadra 630 & PPC Processor Upgrade Card

(defconstant $gestaltPowerMacLC630 106)         ;  Mac LC 630 & PPC Processor Upgrade Card

(defconstant $gestaltPowerMacPerforma63x 106)   ;  Performa 63x & PPC Processor Upgrade Card

(defconstant $gestaltPowerMac7200 108)
(defconstant $gestaltPowerMac7300 109)
(defconstant $gestaltPowerMac7100_66 112)
(defconstant $gestaltPowerBook150 115)
(defconstant $gestaltPowerMacQuadra700 116)     ;  Quadra 700 & Power PC Upgrade Card

(defconstant $gestaltPowerMacQuadra900 117)     ;  Quadra 900 & Power PC Upgrade Card 

(defconstant $gestaltPowerMacQuadra950 118)     ;  Quadra 950 & Power PC Upgrade Card 

(defconstant $gestaltPowerMacCentris610 119)    ;  Centris 610 & Power PC Upgrade Card 

(defconstant $gestaltPowerMacCentris650 120)    ;  Centris 650 & Power PC Upgrade Card 

(defconstant $gestaltPowerMacQuadra610 121)     ;  Quadra 610 & Power PC Upgrade Card 

(defconstant $gestaltPowerMacQuadra650 122)     ;  Quadra 650 & Power PC Upgrade Card 

(defconstant $gestaltPowerMacQuadra800 123)     ;  Quadra 800 & Power PC Upgrade Card 

(defconstant $gestaltPowerBookDuo2300 124)
(defconstant $gestaltPowerBook500PPCUpgrade 126)
(defconstant $gestaltPowerBook5300 #x80)
(defconstant $gestaltPowerBook1400 #x136)
(defconstant $gestaltPowerBook3400 #x132)
(defconstant $gestaltPowerBook2400 #x133)
(defconstant $gestaltPowerBookG3Series #x138)
(defconstant $gestaltPowerBookG3 #x139)
(defconstant $gestaltPowerBookG3Series2 #x13A)
(defconstant $gestaltPowerMacNewWorld #x196)    ;  All NewWorld architecture Macs (iMac, blue G3, etc.)

(defconstant $gestaltPowerMacG3 #x1FE)
(defconstant $gestaltPowerMac5500 #x200)
(defconstant $gestalt20thAnniversary #x200)
(defconstant $gestaltPowerMac6500 #x201)
(defconstant $gestaltPowerMac4400_160 #x202)    ;  slower machine has different machine ID

(defconstant $gestaltPowerMac4400 #x203)
(defconstant $gestaltMacOSCompatibility #x4B6)  ;     Mac OS Compatibility on Mac OS X (Classic)


(defconstant $gestaltQuadra605 94)
(defconstant $gestaltQuadra610 53)
(defconstant $gestaltQuadra630 98)
(defconstant $gestaltQuadra650 36)
(defconstant $gestaltQuadra660AV 60)
(defconstant $gestaltQuadra700 22)
(defconstant $gestaltQuadra800 35)
(defconstant $gestaltQuadra840AV 78)
(defconstant $gestaltQuadra900 20)
(defconstant $gestaltQuadra950 26)

(defconstant $kMachineNameStrID -16395)

(defconstant $gestaltSMPMailerVersion :|malr|)  ;  OCE StandardMail


(defconstant $gestaltMediaBay :|mbeh|)          ;  media bay driver type 

(defconstant $gestaltMBLegacy 0)                ;  media bay support in PCCard 2.0 

(defconstant $gestaltMBSingleBay 1)             ;  single bay media bay driver 

(defconstant $gestaltMBMultipleBays 2)          ;  multi-bay media bay driver 


(defconstant $gestaltMessageMgrVersion :|mess|) ;  GX Printing Message Manager Gestalt Selector 

;   Menu Manager Gestalt (Mac OS 8.5 and later)

(defconstant $gestaltMenuMgrAttr :|menu|)       ;  If this Gestalt exists, the Mac OS 8.5 Menu Manager is installed 

(defconstant $gestaltMenuMgrPresent 1)          ;  NOTE: this is a bit mask, whereas all other Gestalt constants of this nature 
;  are bit index values. 3.2 interfaces slipped out with this mistake unnoticed. 
;  Sincere apologies for any inconvenience.

(defconstant $gestaltMenuMgrPresentBit 0)       ;  bit number 

(defconstant $gestaltMenuMgrAquaLayoutBit 1)    ;  menus have the Aqua 1.0 layout

(defconstant $gestaltMenuMgrMultipleItemsWithCommandIDBit 2);  CountMenuItemsWithCommandID/GetIndMenuItemWithCommandID support multiple items with the same command ID

(defconstant $gestaltMenuMgrRetainsIconRefBit 3);  SetMenuItemIconHandle, when passed an IconRef, calls AcquireIconRef

(defconstant $gestaltMenuMgrSendsMenuBoundsToDefProcBit 4);  kMenuSizeMsg and kMenuPopUpMsg have menu bounding rect information

(defconstant $gestaltMenuMgrMoreThanFiveMenusDeepBit 5);  the Menu Manager supports hierarchical menus more than five deep

(defconstant $gestaltMenuMgrCGImageMenuTitleBit 6);  SetMenuTitleIcon supports CGImageRefs
;  masks for the above bits

(defconstant $gestaltMenuMgrPresentMask 1)
(defconstant $gestaltMenuMgrAquaLayoutMask 2)
(defconstant $gestaltMenuMgrMultipleItemsWithCommandIDMask 4)
(defconstant $gestaltMenuMgrRetainsIconRefMask 8)
(defconstant $gestaltMenuMgrSendsMenuBoundsToDefProcMask 16)
(defconstant $gestaltMenuMgrMoreThanFiveMenusDeepMask 32)
(defconstant $gestaltMenuMgrCGImageMenuTitleMask 64)

(defconstant $gestaltMultipleUsersState :|mfdr|);  Gestalt selector returns MultiUserGestaltHandle (in Folders.h)


(defconstant $gestaltMachineIcon :|micn|)       ;  machine icon 


(defconstant $gestaltMiscAttr :|misc|)          ;  miscellaneous attributes 

(defconstant $gestaltScrollingThrottle 0)       ;  true if scrolling throttle on 

(defconstant $gestaltSquareMenuBar 2)           ;  true if menu bar is square 

; 
;     The name gestaltMixedModeVersion for the 'mixd' selector is semantically incorrect.
;     The same selector has been renamed gestaltMixedModeAttr to properly reflect the
;     Inside Mac: PowerPC System Software documentation.  The gestaltMixedModeVersion
;     symbol has been preserved only for backwards compatibility.
; 
;     Developers are forewarned that gestaltMixedModeVersion has a limited lifespan and
;     will be removed in a future release of the Interfaces.
; 
;     For the first version of Mixed Mode, both meanings of the 'mixd' selector are
;     functionally identical.  They both return 0x00000001.  In subsequent versions
;     of Mixed Mode, however, the 'mixd' selector will not respond with an increasing
;     version number, but rather, with 32 attribute bits with various meanings.
; 

(defconstant $gestaltMixedModeVersion :|mixd|)  ;  returns version of Mixed Mode 


(defconstant $gestaltMixedModeAttr :|mixd|)     ;  returns Mixed Mode attributes 

(defconstant $gestaltMixedModePowerPC 0)        ;  true if Mixed Mode supports PowerPC ABI calling conventions 

(defconstant $gestaltPowerPCAware 0)            ;  old name for gestaltMixedModePowerPC 

(defconstant $gestaltMixedModeCFM68K 1)         ;  true if Mixed Mode supports CFM-68K calling conventions 

(defconstant $gestaltMixedModeCFM68KHasTrap 2)  ;  true if CFM-68K Mixed Mode implements _MixedModeDispatch (versions 1.0.1 and prior did not) 

(defconstant $gestaltMixedModeCFM68KHasState 3) ;  true if CFM-68K Mixed Mode exports Save/RestoreMixedModeState 


(defconstant $gestaltQuickTimeConferencing :|mtlk|);  returns QuickTime Conferencing version 


(defconstant $gestaltMemoryMapAttr :|mmap|)     ;  Memory map type 

(defconstant $gestaltMemoryMapSparse 0)         ;  Sparse memory is on 


(defconstant $gestaltMMUType :|mmu |)           ;  mmu type 

(defconstant $gestaltNoMMU 0)                   ;  no MMU 

(defconstant $gestaltAMU 1)                     ;  address management unit 

(defconstant $gestalt68851 2)                   ;  68851 PMMU 

(defconstant $gestalt68030MMU 3)                ;  68030 built-in MMU 

(defconstant $gestalt68040MMU 4)                ;  68040 built-in MMU 

(defconstant $gestaltEMMU1 5)                   ;  Emulated MMU type 1  


(defconstant $gestaltUserVisibleMachineName :|mnam|);  Coerce response into a StringPtr to get a user visible machine name 


(defconstant $gestaltMPCallableAPIsAttr :|mpsc|);  Bitmap of toolbox/OS managers that can be called from MPLibrary MPTasks 

(defconstant $gestaltMPFileManager 0)           ;  True if File Manager calls can be made from MPTasks 

(defconstant $gestaltMPDeviceManager 1)         ;  True if synchronous Device Manager calls can be made from MPTasks 

(defconstant $gestaltMPTrapCalls 2)             ;  True if most trap-based calls can be made from MPTasks 


(defconstant $gestaltStdNBPAttr :|nlup|)        ;  standard nbp attributes 

(defconstant $gestaltStdNBPPresent 0)
(defconstant $gestaltStdNBPSupportsAutoPosition 1);  StandardNBP takes (-1,-1) to mean alert position main screen 


(defconstant $gestaltNotificationMgrAttr :|nmgr|);  notification manager attributes 

(defconstant $gestaltNotificationPresent 0)     ;  notification manager exists 


(defconstant $gestaltNameRegistryVersion :|nreg|);  NameRegistryLib version number, for System 7.5.2+ usage 


(defconstant $gestaltNuBusSlotCount :|nubs|)    ;  count of logical NuBus slots present 


(defconstant $gestaltOCEToolboxVersion :|ocet|) ;  OCE Toolbox version 

(defconstant $gestaltOCETB #x102)               ;  OCE Toolbox version 1.02 

(defconstant $gestaltSFServer #x100)            ;  S&F Server version 1.0 


(defconstant $gestaltOCEToolboxAttr :|oceu|)    ;  OCE Toolbox attributes 

(defconstant $gestaltOCETBPresent 1)            ;  OCE toolbox is present, not running 

(defconstant $gestaltOCETBAvailable 2)          ;  OCE toolbox is running and available 

(defconstant $gestaltOCESFServerAvailable 4)    ;  S&F Server is running and available 

(defconstant $gestaltOCETBNativeGlueAvailable 16);  Native PowerPC Glue routines are availible 


(defconstant $gestaltOpenFirmwareInfo :|opfw|)  ;  Open Firmware info 


(defconstant $gestaltOSAttr :|os  |)            ;  o/s attributes 

(defconstant $gestaltSysZoneGrowable 0)         ;  system heap is growable 

(defconstant $gestaltLaunchCanReturn 1)         ;  can return from launch 

(defconstant $gestaltLaunchFullFileSpec 2)      ;  can launch from full file spec 

(defconstant $gestaltLaunchControl 3)           ;  launch control support available 

(defconstant $gestaltTempMemSupport 4)          ;  temp memory support 

(defconstant $gestaltRealTempMemory 5)          ;  temp memory handles are real 

(defconstant $gestaltTempMemTracked 6)          ;  temporary memory handles are tracked 

(defconstant $gestaltIPCSupport 7)              ;  IPC support is present 

(defconstant $gestaltSysDebuggerSupport 8)      ;  system debugger support is present 

(defconstant $gestaltNativeProcessMgrBit 19)    ;  the process manager itself is native 

(defconstant $gestaltAltivecRegistersSwappedCorrectlyBit 20);  Altivec registers are saved correctly on process switches 


(defconstant $gestaltOSTable :|ostt|)           ;   OS trap table base  

; ******************************************************************************
; *   Gestalt Selectors for Open Transport Network Setup
; *
; *   Note: possible values for the version "stage" byte are:
; *   development = 0x20, alpha = 0x40, beta = 0x60, final & release = 0x80
; *******************************************************************************

(defconstant $gestaltOpenTptNetworkSetup :|otcf|)
(defconstant $gestaltOpenTptNetworkSetupLegacyImport 0)
(defconstant $gestaltOpenTptNetworkSetupLegacyExport 1)
(defconstant $gestaltOpenTptNetworkSetupSupportsMultihoming 2)

(defconstant $gestaltOpenTptNetworkSetupVersion :|otcv|)
; ******************************************************************************
; *   Gestalt Selectors for Open Transport-based Remote Access/PPP
; *
; *   Note: possible values for the version "stage" byte are:
; *   development = 0x20, alpha = 0x40, beta = 0x60, final & release = 0x80
; *******************************************************************************

(defconstant $gestaltOpenTptRemoteAccess :|otra|)
(defconstant $gestaltOpenTptRemoteAccessPresent 0)
(defconstant $gestaltOpenTptRemoteAccessLoaded 1)
(defconstant $gestaltOpenTptRemoteAccessClientOnly 2)
(defconstant $gestaltOpenTptRemoteAccessPServer 3)
(defconstant $gestaltOpenTptRemoteAccessMPServer 4)
(defconstant $gestaltOpenTptPPPPresent 5)
(defconstant $gestaltOpenTptARAPPresent 6)

(defconstant $gestaltOpenTptRemoteAccessVersion :|otrv|)
;  ***** Open Transport Gestalt *****

(defconstant $gestaltOpenTptVersions :|otvr|)   ;  Defined by OT 1.1 and higher, response is NumVersion.


(defconstant $gestaltOpenTpt :|otan|)           ;  Defined by all versions, response is defined below.

(defconstant $gestaltOpenTptPresentMask 1)
(defconstant $gestaltOpenTptLoadedMask 2)
(defconstant $gestaltOpenTptAppleTalkPresentMask 4)
(defconstant $gestaltOpenTptAppleTalkLoadedMask 8)
(defconstant $gestaltOpenTptTCPPresentMask 16)
(defconstant $gestaltOpenTptTCPLoadedMask 32)
(defconstant $gestaltOpenTptIPXSPXPresentMask 64)
(defconstant $gestaltOpenTptIPXSPXLoadedMask #x80)
(defconstant $gestaltOpenTptPresentBit 0)
(defconstant $gestaltOpenTptLoadedBit 1)
(defconstant $gestaltOpenTptAppleTalkPresentBit 2)
(defconstant $gestaltOpenTptAppleTalkLoadedBit 3)
(defconstant $gestaltOpenTptTCPPresentBit 4)
(defconstant $gestaltOpenTptTCPLoadedBit 5)
(defconstant $gestaltOpenTptIPXSPXPresentBit 6)
(defconstant $gestaltOpenTptIPXSPXLoadedBit 7)

(defconstant $gestaltPCCard :|pccd|)            ;     PC Card attributes

(defconstant $gestaltCardServicesPresent 0)     ;     PC Card 2.0 (68K) API is present

(defconstant $gestaltPCCardFamilyPresent 1)     ;     PC Card 3.x (PowerPC) API is present

(defconstant $gestaltPCCardHasPowerControl 2)   ;     PCCardSetPowerLevel is supported

(defconstant $gestaltPCCardSupportsCardBus 3)   ;     CardBus is supported


(defconstant $gestaltProcClkSpeed :|pclk|)      ;  processor clock speed in hertz (an unsigned long) 


(defconstant $gestaltProcClkSpeedMHz :|mclk|)   ;  processor clock speed in megahertz (an unsigned long) 


(defconstant $gestaltPCXAttr :|pcxg|)           ;  PC Exchange attributes 

(defconstant $gestaltPCXHas8and16BitFAT 0)      ;  PC Exchange supports both 8 and 16 bit FATs 

(defconstant $gestaltPCXHasProDOS 1)            ;  PC Exchange supports ProDOS 

(defconstant $gestaltPCXNewUI 2)
(defconstant $gestaltPCXUseICMapping 3)         ;  PC Exchange uses InternetConfig for file mappings 


(defconstant $gestaltLogicalPageSize :|pgsz|)   ;  logical page size 

;     System 7.6 and later.  If gestaltScreenCaptureMain is not implemented,
;     PictWhap proceeds with screen capture in the usual way.
; 
;     The high word of gestaltScreenCaptureMain is reserved (use 0).
; 
;     To disable screen capture to disk, put zero in the low word.  To
;     specify a folder for captured pictures, put the vRefNum in the
;     low word of gestaltScreenCaptureMain, and put the directory ID in
;     gestaltScreenCaptureDir.
; 

(defconstant $gestaltScreenCaptureMain :|pic1|) ;  Zero, or vRefNum of disk to hold picture 

(defconstant $gestaltScreenCaptureDir :|pic2|)  ;  Directory ID of folder to hold picture 


(defconstant $gestaltGXPrintingMgrVersion :|pmgr|);  QuickDraw GX Printing Manager Version


(defconstant $gestaltPopupAttr :|pop!|)         ;  popup cdef attributes 

(defconstant $gestaltPopupPresent 0)

(defconstant $gestaltPowerMgrAttr :|powr|)      ;  power manager attributes 

(defconstant $gestaltPMgrExists 0)
(defconstant $gestaltPMgrCPUIdle 1)
(defconstant $gestaltPMgrSCC 2)
(defconstant $gestaltPMgrSound 3)
(defconstant $gestaltPMgrDispatchExists 4)
(defconstant $gestaltPMgrSupportsAVPowerStateAtSleepWake 5)

(defconstant $gestaltPowerMgrVers :|pwrv|)      ;  power manager version 

; 
;  * PPC will return the combination of following bit fields.
;  * e.g. gestaltPPCSupportsRealTime +gestaltPPCSupportsIncoming + gestaltPPCSupportsOutGoing
;  * indicates PPC is cuurently is only supports real time delivery
;  * and both incoming and outgoing network sessions are allowed.
;  * By default local real time delivery is supported as long as PPCInit has been called.

(defconstant $gestaltPPCToolboxAttr :|ppc |)    ;  PPC toolbox attributes 

(defconstant $gestaltPPCToolboxPresent 0)       ;  PPC Toolbox is present  Requires PPCInit to be called 

(defconstant $gestaltPPCSupportsRealTime #x1000);  PPC Supports real-time delivery 

(defconstant $gestaltPPCSupportsIncoming 1)     ;  PPC will allow incoming network requests 

(defconstant $gestaltPPCSupportsOutGoing 2)     ;  PPC will allow outgoing network requests 

(defconstant $gestaltPPCSupportsTCP_IP 4)       ;  PPC supports TCP/IP transport  

(defconstant $gestaltPPCSupportsIncomingAppleTalk 16)
(defconstant $gestaltPPCSupportsIncomingTCP_IP 32)
(defconstant $gestaltPPCSupportsOutgoingAppleTalk #x100)
(defconstant $gestaltPPCSupportsOutgoingTCP_IP #x200)
; 
;     Programs which need to know information about particular features of the processor should
;     migrate to using sysctl() and sysctlbyname() to get this kind of information.  No new
;     information will be added to the 'ppcf' selector going forward.
; 

(defconstant $gestaltPowerPCProcessorFeatures :|ppcf|);  Optional PowerPC processor features 

(defconstant $gestaltPowerPCHasGraphicsInstructions 0);  has fres, frsqrte, and fsel instructions 

(defconstant $gestaltPowerPCHasSTFIWXInstruction 1);  has stfiwx instruction 

(defconstant $gestaltPowerPCHasSquareRootInstructions 2);  has fsqrt and fsqrts instructions 

(defconstant $gestaltPowerPCHasDCBAInstruction 3);  has dcba instruction 

(defconstant $gestaltPowerPCHasVectorInstructions 4);  has vector instructions 

(defconstant $gestaltPowerPCHasDataStreams 5)   ;  has dst, dstt, dstst, dss, and dssall instructions 

(defconstant $gestaltPowerPCHas64BitSupport 6)  ;  double word LSU/ALU, etc. 

(defconstant $gestaltPowerPCHasDCBTStreams 7)   ;  TH field of DCBT recognized 

(defconstant $gestaltPowerPCASArchitecture 8)   ;  chip uses new 'A/S' architecture 

(defconstant $gestaltPowerPCIgnoresDCBST 9)     ;  


(defconstant $gestaltProcessorType :|proc|)     ;  processor type 

(defconstant $gestalt68000 1)
(defconstant $gestalt68010 2)
(defconstant $gestalt68020 3)
(defconstant $gestalt68030 4)
(defconstant $gestalt68040 5)

(defconstant $gestaltSDPPromptVersion :|prpv|)  ;  OCE Standard Directory Panel


(defconstant $gestaltParityAttr :|prty|)        ;  parity attributes 

(defconstant $gestaltHasParityCapability 0)     ;  has ability to check parity 

(defconstant $gestaltParityEnabled 1)           ;  parity checking enabled 


(defconstant $gestaltQD3DVersion :|q3v |)       ;  Quickdraw 3D version in pack BCD


(defconstant $gestaltQD3DViewer :|q3vc|)        ;  Quickdraw 3D viewer attributes

(defconstant $gestaltQD3DViewerPresent 0)       ;  bit 0 set if QD3D Viewer is available


; #if OLDROUTINENAMES
#| 
(defconstant $gestaltQD3DViewerNotPresent 0)
(defconstant $gestaltQD3DViewerAvailable 1)
 |#

; #endif  /* OLDROUTINENAMES */


(defconstant $gestaltQuickdrawVersion :|qd  |)  ;  quickdraw version 

(defconstant $gestaltOriginalQD 0)              ;  original 1-bit QD 

(defconstant $gestalt8BitQD #x100)              ;  8-bit color QD 

(defconstant $gestalt32BitQD #x200)             ;  32-bit color QD 

(defconstant $gestalt32BitQD11 #x201)           ;  32-bit color QDv1.1 

(defconstant $gestalt32BitQD12 #x220)           ;  32-bit color QDv1.2 

(defconstant $gestalt32BitQD13 #x230)           ;  32-bit color QDv1.3 

(defconstant $gestaltAllegroQD #x250)           ;  Allegro QD OS 8.5 

(defconstant $gestaltMacOSXQD #x300)            ;  0x310, 0x320 etc. for 10.x.y 


(defconstant $gestaltQD3D :|qd3d|)              ;  Quickdraw 3D attributes

(defconstant $gestaltQD3DPresent 0)             ;  bit 0 set if QD3D available


; #if OLDROUTINENAMES
#| 
(defconstant $gestaltQD3DNotPresent 0)
(defconstant $gestaltQD3DAvailable 1)
 |#

; #endif  /* OLDROUTINENAMES */


(defconstant $gestaltGXVersion :|qdgx|)         ;  Overall QuickDraw GX Version


(defconstant $gestaltQuickdrawFeatures :|qdrw|) ;  quickdraw features 

(defconstant $gestaltHasColor 0)                ;  color quickdraw present 

(defconstant $gestaltHasDeepGWorlds 1)          ;  GWorlds can be deeper than 1-bit 

(defconstant $gestaltHasDirectPixMaps 2)        ;  PixMaps can be direct (16 or 32 bit) 

(defconstant $gestaltHasGrayishTextOr 3)        ;  supports text mode grayishTextOr 

(defconstant $gestaltSupportsMirroring 4)       ;  Supports video mirroring via the Display Manager. 

(defconstant $gestaltQDHasLongRowBytes 5)       ;  Long rowBytes supported in GWorlds 


(defconstant $gestaltQDTextVersion :|qdtx|)     ;  QuickdrawText version 

(defconstant $gestaltOriginalQDText 0)          ;  up to and including 8.1 

(defconstant $gestaltAllegroQDText #x100)       ;  starting with 8.5 

(defconstant $gestaltMacOSXQDText #x200)        ;  we are in Mac OS X 


(defconstant $gestaltQDTextFeatures :|qdtf|)    ;  QuickdrawText features 

(defconstant $gestaltWSIISupport 0)             ;  bit 0: WSII support included 

(defconstant $gestaltSbitFontSupport 1)         ;  sbit-only fonts supported 

(defconstant $gestaltAntiAliasedTextAvailable 2);  capable of antialiased text 

(defconstant $gestaltOFA2available 3)           ;  OFA2 available 

(defconstant $gestaltCreatesAliasFontRsrc 4)    ;  "real" datafork font support 

(defconstant $gestaltNativeType1FontSupport 5)  ;  we have scaler for Type1 fonts 

(defconstant $gestaltCanUseCGTextRendering 6)

(defconstant $gestaltQuickTimeConferencingInfo :|qtci|);  returns pointer to QuickTime Conferencing information 


(defconstant $gestaltQuickTimeVersion :|qtim|)  ;  returns version of QuickTime 

(defconstant $gestaltQuickTime :|qtim|)         ;  gestaltQuickTime is old name for gestaltQuickTimeVersion 


(defconstant $gestaltQuickTimeFeatures :|qtrs|)
(defconstant $gestaltPPCQuickTimeLibPresent 0)  ;  PowerPC QuickTime glue library is present 


(defconstant $gestaltQuickTimeStreamingFeatures :|qtsf|)

(defconstant $gestaltQuickTimeStreamingVersion :|qtst|)

(defconstant $gestaltQuickTimeThreadSafeFeaturesAttr :|qtth|);  Quicktime thread safety attributes 

(defconstant $gestaltQuickTimeThreadSafeICM 0)
(defconstant $gestaltQuickTimeThreadSafeMovieToolbox 1)
(defconstant $gestaltQuickTimeThreadSafeMovieImport 2)
(defconstant $gestaltQuickTimeThreadSafeMovieExport 3)
(defconstant $gestaltQuickTimeThreadSafeGraphicsImport 4)
(defconstant $gestaltQuickTimeThreadSafeGraphicsExport 5)
(defconstant $gestaltQuickTimeThreadSafeMoviePlayback 6)

(defconstant $gestaltQTVRMgrAttr :|qtvr|)       ;  QuickTime VR attributes                               

(defconstant $gestaltQTVRMgrPresent 0)          ;  QTVR API is present                                   

(defconstant $gestaltQTVRObjMoviesPresent 1)    ;  QTVR runtime knows about object movies                

(defconstant $gestaltQTVRCylinderPanosPresent 2);  QTVR runtime knows about cylindrical panoramic movies 

(defconstant $gestaltQTVRCubicPanosPresent 3)   ;  QTVR runtime knows about cubic panoramic movies       


(defconstant $gestaltQTVRMgrVers :|qtvv|)       ;  QuickTime VR version                                  

;     
;     Because some PowerPC machines now support very large physical memory capacities, including
;     some above the maximum value which can held in a 32 bit quantity, there is now a new selector,
;     gestaltPhysicalRAMSizeInMegabytes, which returns the size of physical memory scaled
;     in megabytes.  It is recommended that code transition to using this new selector if
;     it wants to get a useful value for the amount of physical memory on the system.  Code can
;     also use the sysctl() and sysctlbyname() BSD calls to get these kinds of values.
;     
;     For compatability with code which assumed that the value in returned by the
;     gestaltPhysicalRAMSize selector would be a signed quantity of bytes, this selector will
;     now return 2 gigabytes-1 ( LONG_MAX ) if the system has 2 gigabytes of physical memory or more.
; 

(defconstant $gestaltPhysicalRAMSize :|ram |)   ;  physical RAM size, in bytes 


(defconstant $gestaltPhysicalRAMSizeInMegabytes :|ramm|);  physical RAM size, scaled in megabytes 


(defconstant $gestaltRBVAddr :|rbv |)           ;  RBV base address  


(defconstant $gestaltROMSize :|rom |)           ;  rom size 


(defconstant $gestaltROMVersion :|romv|)        ;  rom version 


(defconstant $gestaltResourceMgrAttr :|rsrc|)   ;  Resource Mgr attributes 

(defconstant $gestaltPartialRsrcs 0)            ;  True if partial resources exist 

(defconstant $gestaltHasResourceOverrides 1)    ;  Appears in the ROM; so put it here. 


(defconstant $gestaltResourceMgrBugFixesAttrs :|rmbg|);  Resource Mgr bug fixes 

(defconstant $gestaltRMForceSysHeapRolledIn 0)
(defconstant $gestaltRMFakeAppleMenuItemsRolledIn 1)
(defconstant $gestaltSanityCheckResourceFiles 2);  Resource manager does sanity checking on resource files before opening them 

(defconstant $gestaltSupportsFSpResourceFileAlreadyOpenBit 3);  The resource manager supports GetResFileRefNum and FSpGetResFileRefNum and FSpResourceFileAlreadyOpen 

(defconstant $gestaltRMSupportsFSCalls 4)       ;  The resource manager supports OpenResFileFSRef, CreateResFileFSRef and  ResourceFileAlreadyOpenFSRef 

(defconstant $gestaltRMTypeIndexOrderingReverse 8);  GetIndType() calls return resource types in opposite order to original 68k resource manager 


(defconstant $gestaltRealtimeMgrAttr :|rtmr|)   ;  Realtime manager attributes         

(defconstant $gestaltRealtimeMgrPresent 0)      ;  true if the Realtime manager is present    


(defconstant $gestaltSafeOFAttr :|safe|)
(defconstant $gestaltVMZerosPagesBit 0)
(defconstant $gestaltInitHeapZerosOutHeapsBit 1)
(defconstant $gestaltNewHandleReturnsZeroedMemoryBit 2)
(defconstant $gestaltNewPtrReturnsZeroedMemoryBit 3)
(defconstant $gestaltFileAllocationZeroedBlocksBit 4)

(defconstant $gestaltSCCReadAddr :|sccr|)       ;  scc read base address  


(defconstant $gestaltSCCWriteAddr :|sccw|)      ;  scc read base address  


(defconstant $gestaltScrapMgrAttr :|scra|)      ;  Scrap Manager attributes 

(defconstant $gestaltScrapMgrTranslationAware 0);  True if scrap manager is translation aware 


(defconstant $gestaltScriptMgrVersion :|scri|)  ;  Script Manager version number     


(defconstant $gestaltScriptCount :|scr#|)       ;  number of active script systems   


(defconstant $gestaltSCSI :|scsi|)              ;  SCSI Manager attributes 

(defconstant $gestaltAsyncSCSI 0)               ;  Supports Asynchronous SCSI 

(defconstant $gestaltAsyncSCSIINROM 1)          ;  Async scsi is in ROM (available for booting) 

(defconstant $gestaltSCSISlotBoot 2)            ;  ROM supports Slot-style PRAM for SCSI boots (PDM and later) 

(defconstant $gestaltSCSIPollSIH 3)             ;  SCSI Manager will poll for interrupts if Secondary Interrupts are busy. 


(defconstant $gestaltControlStripAttr :|sdev|)  ;  Control Strip attributes 

(defconstant $gestaltControlStripExists 0)      ;  Control Strip is installed 

(defconstant $gestaltControlStripVersionFixed 1);  Control Strip version Gestalt selector was fixed 

(defconstant $gestaltControlStripUserFont 2)    ;  supports user-selectable font/size 

(defconstant $gestaltControlStripUserHotKey 3)  ;  support user-selectable hot key to show/hide the window 


(defconstant $gestaltSDPStandardDirectoryVersion :|sdvr|);  OCE Standard Directory Panel


(defconstant $gestaltSerialAttr :|ser |)        ;  Serial attributes 

(defconstant $gestaltHasGPIaToDCDa 0)           ;  GPIa connected to DCDa

(defconstant $gestaltHasGPIaToRTxCa 1)          ;  GPIa connected to RTxCa clock input

(defconstant $gestaltHasGPIbToDCDb 2)           ;  GPIb connected to DCDb 

(defconstant $gestaltHidePortA 3)               ;  Modem port (A) should be hidden from users 

(defconstant $gestaltHidePortB 4)               ;  Printer port (B) should be hidden from users 

(defconstant $gestaltPortADisabled 5)           ;  Modem port (A) disabled and should not be used by SW 

(defconstant $gestaltPortBDisabled 6)           ;  Printer port (B) disabled and should not be used by SW 


(defconstant $gestaltShutdownAttributes :|shut|);  ShutDown Manager Attributes 

(defconstant $gestaltShutdownHassdOnBootVolUnmount 0);  True if ShutDown Manager unmounts boot & VM volume at shutdown time. 


(defconstant $gestaltNuBusConnectors :|sltc|)   ;  bitmap of NuBus connectors


(defconstant $gestaltSlotAttr :|slot|)          ;  slot attributes  

(defconstant $gestaltSlotMgrExists 0)           ;  true is slot mgr exists  

(defconstant $gestaltNuBusPresent 1)            ;  NuBus slots are present  

(defconstant $gestaltSESlotPresent 2)           ;  SE PDS slot present  

(defconstant $gestaltSE30SlotPresent 3)         ;  SE/30 slot present  

(defconstant $gestaltPortableSlotPresent 4)     ;  PortableÕs slot present  


(defconstant $gestaltFirstSlotNumber :|slt1|)   ;  returns first physical slot 


(defconstant $gestaltSoundAttr :|snd |)         ;  sound attributes 

(defconstant $gestaltStereoCapability 0)        ;  sound hardware has stereo capability 

(defconstant $gestaltStereoMixing 1)            ;  stereo mixing on external speaker 

(defconstant $gestaltSoundIOMgrPresent 3)       ;  The Sound I/O Manager is present 

(defconstant $gestaltBuiltInSoundInput 4)       ;  built-in Sound Input hardware is present 

(defconstant $gestaltHasSoundInputDevice 5)     ;  Sound Input device available 

(defconstant $gestaltPlayAndRecord 6)           ;  built-in hardware can play and record simultaneously 

(defconstant $gestalt16BitSoundIO 7)            ;  sound hardware can play and record 16-bit samples 

(defconstant $gestaltStereoInput 8)             ;  sound hardware can record stereo 

(defconstant $gestaltLineLevelInput 9)          ;  sound input port requires line level 
;  the following bits are not defined prior to Sound Mgr 3.0 

(defconstant $gestaltSndPlayDoubleBuffer 10)    ;  SndPlayDoubleBuffer available, set by Sound Mgr 3.0 and later 

(defconstant $gestaltMultiChannels 11)          ;  multiple channel support, set by Sound Mgr 3.0 and later 

(defconstant $gestalt16BitAudioSupport 12)      ;  16 bit audio data supported, set by Sound Mgr 3.0 and later 


(defconstant $gestaltSplitOSAttr :|spos|)
(defconstant $gestaltSplitOSBootDriveIsNetworkVolume 0);  the boot disk is a network 'disk', from the .LANDisk drive. 

(defconstant $gestaltSplitOSAware 1)            ;  the system includes the code to deal with a split os situation. 

(defconstant $gestaltSplitOSEnablerVolumeIsDifferentFromBootVolume 2);  the active enabler is on a different volume than the system file. 

(defconstant $gestaltSplitOSMachineNameSetToNetworkNameTemp 3);  The machine name was set to the value given us from the BootP server 

(defconstant $gestaltSplitOSMachineNameStartupDiskIsNonPersistent 5);  The startup disk ( vRefNum == -1 ) is non-persistent, meaning changes won't persist across a restart. 


(defconstant $gestaltSMPSPSendLetterVersion :|spsl|);  OCE StandardMail


(defconstant $gestaltSpeechRecognitionAttr :|srta|);  speech recognition attributes 

(defconstant $gestaltDesktopSpeechRecognition 1);  recognition thru the desktop microphone is available 

(defconstant $gestaltTelephoneSpeechRecognition 2);  recognition thru the telephone is available 


(defconstant $gestaltSpeechRecognitionVersion :|srtb|);  speech recognition version (0x0150 is the first version that fully supports the API) 


(defconstant $gestaltSoftwareVendorCode :|srad|);  Returns system software vendor information 

(defconstant $gestaltSoftwareVendorApple :|Appl|);  System software sold by Apple 

(defconstant $gestaltSoftwareVendorLicensee :|Lcns|);  System software sold by licensee 


(defconstant $gestaltStandardFileAttr :|stdf|)  ;  Standard File attributes 

(defconstant $gestaltStandardFile58 0)          ;  True if selectors 5-8 (StandardPutFile-CustomGetFile) are supported 

(defconstant $gestaltStandardFileTranslationAware 1);  True if standard file is translation manager aware 

(defconstant $gestaltStandardFileHasColorIcons 2);  True if standard file has 16x16 color icons 

(defconstant $gestaltStandardFileUseGenericIcons 3);  Standard file LDEF to use only the system generic icons if true 

(defconstant $gestaltStandardFileHasDynamicVolumeAllocation 4);  True if standard file supports more than 20 volumes 


(defconstant $gestaltSysArchitecture :|sysa|)   ;  Native System Architecture 

(defconstant $gestalt68k 1)                     ;  Motorola MC68k architecture 

(defconstant $gestaltPowerPC 2)                 ;  IBM PowerPC architecture 

(defconstant $gestaltIntel 10)                  ;  Intel x86 architecture 


(defconstant $gestaltSystemUpdateVersion :|sysu|);  System Update version 


(defconstant $gestaltSystemVersion :|sysv|)     ;  system version


(defconstant $gestaltToolboxTable :|tbtt|)      ;   OS trap table base  


(defconstant $gestaltTextEditVersion :|te  |)   ;  TextEdit version number 

(defconstant $gestaltTE1 1)                     ;  TextEdit in MacIIci ROM 

(defconstant $gestaltTE2 2)                     ;  TextEdit with 6.0.4 Script Systems on MacIIci (Script bug fixes for MacIIci) 

(defconstant $gestaltTE3 3)                     ;  TextEdit with 6.0.4 Script Systems all but MacIIci 

(defconstant $gestaltTE4 4)                     ;  TextEdit in System 7.0 

(defconstant $gestaltTE5 5)                     ;  TextWidthHook available in TextEdit 


(defconstant $gestaltTE6 6)                     ;  TextEdit with integrated TSMTE and improved UI 


(defconstant $gestaltTEAttr :|teat|)            ;  TextEdit attributes 

(defconstant $gestaltTEHasGetHiliteRgn 0)       ;  TextEdit has TEGetHiliteRgn 

(defconstant $gestaltTESupportsInlineInput 1)   ;  TextEdit does Inline Input 

(defconstant $gestaltTESupportsTextObjects 2)   ;  TextEdit does Text Objects 

(defconstant $gestaltTEHasWhiteBackground 3)    ;  TextEdit supports overriding the TERec's background to white 


(defconstant $gestaltTeleMgrAttr :|tele|)       ;  Telephone manager attributes 

(defconstant $gestaltTeleMgrPresent 0)
(defconstant $gestaltTeleMgrPowerPCSupport 1)
(defconstant $gestaltTeleMgrSoundStreams 2)
(defconstant $gestaltTeleMgrAutoAnswer 3)
(defconstant $gestaltTeleMgrIndHandset 4)
(defconstant $gestaltTeleMgrSilenceDetect 5)
(defconstant $gestaltTeleMgrNewTELNewSupport 6)

(defconstant $gestaltTermMgrAttr :|term|)       ;  terminal mgr attributes 

(defconstant $gestaltTermMgrPresent 0)
(defconstant $gestaltTermMgrErrorString 2)

(defconstant $gestaltThreadMgrAttr :|thds|)     ;  Thread Manager attributes 

(defconstant $gestaltThreadMgrPresent 0)        ;  bit true if Thread Mgr is present 

(defconstant $gestaltSpecificMatchSupport 1)    ;  bit true if Thread Mgr supports exact match creation option 

(defconstant $gestaltThreadsLibraryPresent 2)   ;  bit true if Thread Mgr shared library is present 


(defconstant $gestaltTimeMgrVersion :|tmgr|)    ;  time mgr version 

(defconstant $gestaltStandardTimeMgr 1)         ;  standard time mgr is present 

(defconstant $gestaltRevisedTimeMgr 2)          ;  revised time mgr is present 

(defconstant $gestaltExtendedTimeMgr 3)         ;  extended time mgr is present 

(defconstant $gestaltNativeTimeMgr 4)           ;  PowerPC native TimeMgr is present 


(defconstant $gestaltTSMTEVersion :|tmTV|)
(defconstant $gestaltTSMTE1 #x100)              ;  Original version of TSMTE 

(defconstant $gestaltTSMTE15 #x150)             ;  System 8.0 

(defconstant $gestaltTSMTE152 #x152)            ;  System 8.2 


(defconstant $gestaltTSMTEAttr :|tmTE|)
(defconstant $gestaltTSMTEPresent 0)
(defconstant $gestaltTSMTE 0)                   ;  gestaltTSMTE is old name for gestaltTSMTEPresent 


(defconstant $gestaltAVLTreeAttr :|tree|)       ;  AVLTree utility routines attributes. 

(defconstant $gestaltAVLTreePresentBit 0)       ;  if set, then the AVL Tree routines are available. 

(defconstant $gestaltAVLTreeSupportsHandleBasedTreeBit 1);  if set, then the AVL Tree routines can store tree data in a single handle 

(defconstant $gestaltAVLTreeSupportsTreeLockingBit 2);  if set, the AVLLockTree() and AVLUnlockTree() routines are available. 


(defconstant $gestaltALMAttr :|trip|)           ;  Settings Manager attributes (see also gestaltALMVers) 

(defconstant $gestaltALMPresent 0)              ;  bit true if ALM is available 

(defconstant $gestaltALMHasSFGroup 1)           ;  bit true if Put/Get/Merge Group calls are implmented 

(defconstant $gestaltALMHasCFMSupport 2)        ;  bit true if CFM-based modules are supported 

(defconstant $gestaltALMHasRescanNotifiers 3)   ;  bit true if Rescan notifications/events will be sent to clients 


(defconstant $gestaltALMHasSFLocation 1)

(defconstant $gestaltTSMgrVersion :|tsmv|)      ;  Text Services Mgr version, if present 

(defconstant $gestaltTSMgr15 #x150)
(defconstant $gestaltTSMgr20 #x200)
(defconstant $gestaltTSMgr22 #x220)

(defconstant $gestaltTSMgrAttr :|tsma|)         ;  Text Services Mgr attributes, if present 

(defconstant $gestaltTSMDisplayMgrAwareBit 0)   ;  TSM knows about display manager 

(defconstant $gestaltTSMdoesTSMTEBit 1)         ;  TSM has integrated TSMTE 


(defconstant $gestaltSpeechAttr :|ttsc|)        ;  Speech Manager attributes 

(defconstant $gestaltSpeechMgrPresent 0)        ;  bit set indicates that Speech Manager exists 

(defconstant $gestaltSpeechHasPPCGlue 1)        ;  bit set indicates that native PPC glue for Speech Manager API exists 


(defconstant $gestaltTVAttr :|tv  |)            ;  TV version 

(defconstant $gestaltHasTVTuner 0)              ;  supports Philips FL1236F video tuner 

(defconstant $gestaltHasSoundFader 1)           ;  supports Philips TEA6330 Sound Fader chip 

(defconstant $gestaltHasHWClosedCaptioning 2)   ;  supports Philips SAA5252 Closed Captioning 

(defconstant $gestaltHasIRRemote 3)             ;  supports CyclopsII Infra Red Remote control 

(defconstant $gestaltHasVidDecoderScaler 4)     ;  supports Philips SAA7194 Video Decoder/Scaler 

(defconstant $gestaltHasStereoDecoder 5)        ;  supports Sony SBX1637A-01 stereo decoder 

(defconstant $gestaltHasSerialFader 6)          ;  has fader audio in serial with system audio 

(defconstant $gestaltHasFMTuner 7)              ;  has FM Tuner from donnybrook card 

(defconstant $gestaltHasSystemIRFunction 8)     ;  Infra Red button function is set up by system and not by Video Startup 

(defconstant $gestaltIRDisabled 9)              ;  Infra Red remote is not disabled. 

(defconstant $gestaltINeedIRPowerOffConfirm 10) ;  Need IR power off confirm dialog. 

(defconstant $gestaltHasZoomedVideo 11)         ;  Has Zoomed Video PC Card video input. 


(defconstant $gestaltATSUVersion :|uisv|)
(defconstant $gestaltOriginalATSUVersion #x10000);  ATSUI version 1.0 

(defconstant $gestaltATSUUpdate1 #x20000)       ;  ATSUI version 1.1 

(defconstant $gestaltATSUUpdate2 #x30000)       ;  ATSUI version 1.2 

(defconstant $gestaltATSUUpdate3 #x40000)       ;  ATSUI version 2.0 

(defconstant $gestaltATSUUpdate4 #x50000)       ;  ATSUI version in Mac OS X - SoftwareUpdate 1-4 for Mac OS 10.0.1 - 10.0.4 

(defconstant $gestaltATSUUpdate5 #x60000)       ;  ATSUI version 2.3 in MacOS 10.1 

(defconstant $gestaltATSUUpdate6 #x70000)       ;  ATSUI version 2.4 in MacOS 10.2 
;  ATSUI version 2.5 in MacOS 10.3 

(defconstant $gestaltATSUUpdate7 #x80000)

(defconstant $gestaltATSUFeatures :|uisf|)
(defconstant $gestaltATSUTrackingFeature 1)     ;  feature introduced in ATSUI version 1.1 

(defconstant $gestaltATSUMemoryFeature 1)       ;  feature introduced in ATSUI version 1.1 

(defconstant $gestaltATSUFallbacksFeature 1)    ;  feature introduced in ATSUI version 1.1 

(defconstant $gestaltATSUGlyphBoundsFeature 1)  ;  feature introduced in ATSUI version 1.1 

(defconstant $gestaltATSULineControlFeature 1)  ;  feature introduced in ATSUI version 1.1 

(defconstant $gestaltATSULayoutCreateAndCopyFeature 1);  feature introduced in ATSUI version 1.1 

(defconstant $gestaltATSULayoutCacheClearFeature 1);  feature introduced in ATSUI version 1.1 

(defconstant $gestaltATSUTextLocatorUsageFeature 2);  feature introduced in ATSUI version 1.2 

(defconstant $gestaltATSULowLevelOrigFeatures 4);  first low-level features introduced in ATSUI version 2.0 

(defconstant $gestaltATSUFallbacksObjFeatures 8);  feature introduced - ATSUFontFallbacks objects introduced in ATSUI version 2.3 

(defconstant $gestaltATSUIgnoreLeadingFeature 8);  feature introduced - kATSLineIgnoreFontLeading LineLayoutOption introduced in ATSUI version 2.3 

(defconstant $gestaltATSUByCharacterClusterFeature 16);  ATSUCursorMovementTypes introduced in ATSUI version 2.4 

(defconstant $gestaltATSUAscentDescentControlsFeature 16);  attributes introduced in ATSUI version 2.4 

(defconstant $gestaltATSUHighlightInactiveTextFeature 16);  feature introduced in ATSUI version 2.4 

(defconstant $gestaltATSUPositionToCursorFeature 16);  features introduced in ATSUI version 2.4 

(defconstant $gestaltATSUBatchBreakLinesFeature 16);  feature introduced in ATSUI version 2.4 

(defconstant $gestaltATSUTabSupportFeature 16)  ;  features introduced in ATSUI version 2.4 

(defconstant $gestaltATSUDirectAccess 16)       ;  features introduced in ATSUI version 2.4 

(defconstant $gestaltATSUDecimalTabFeature 32)  ;  feature introduced in ATSUI version 2.5 

(defconstant $gestaltATSUBiDiCursorPositionFeature 32);  feature introduced in ATSUI version 2.5 

(defconstant $gestaltATSUNearestCharLineBreakFeature 32);  feature introduced in ATSUI version 2.5 

(defconstant $gestaltATSUHighlightColorControlFeature 32);  feature introduced in ATSUI version 2.5 

(defconstant $gestaltATSUUnderlineOptionsStyleFeature 32);  feature introduced in ATSUI version 2.5 

(defconstant $gestaltATSUStrikeThroughStyleFeature 32);  feature introduced in ATSUI version 2.5 

(defconstant $gestaltATSUDropShadowStyleFeature 32);  feature introduced in ATSUI version 2.5 


(defconstant $gestaltUSBAttr :|usb |)           ;  USB Attributes 

(defconstant $gestaltUSBPresent 0)              ;  USB Support available 

(defconstant $gestaltUSBHasIsoch 1)             ;  USB Isochronous features available 


(defconstant $gestaltUSBVersion :|usbv|)        ;  USB version 


(defconstant $gestaltVersion :|vers|)           ;  gestalt version 

(defconstant $gestaltValueImplementedVers 5)    ;  version of gestalt where gestaltValue is implemented. 


(defconstant $gestaltVIA1Addr :|via1|)          ;  via 1 base address  


(defconstant $gestaltVIA2Addr :|via2|)          ;  via 2 base address  


(defconstant $gestaltVMAttr :|vm  |)            ;  virtual memory attributes 

(defconstant $gestaltVMPresent 0)               ;  true if virtual memory is present 

(defconstant $gestaltVMHasLockMemoryForOutput 1);  true if LockMemoryForOutput is available 

(defconstant $gestaltVMFilemappingOn 3)         ;  true if filemapping is available 

(defconstant $gestaltVMHasPagingControl 4)      ;  true if MakeMemoryResident, MakeMemoryNonResident, FlushMemory, and ReleaseMemoryData are available 


(defconstant $gestaltVMInfoType :|vmin|)        ;  Indicates how the Finder should display information about VM in 
;  the Finder about box. 

(defconstant $gestaltVMInfoSizeStorageType 0)   ;  Display VM on/off, backing store size and name 

(defconstant $gestaltVMInfoSizeType 1)          ;  Display whether VM is on or off and the size of the backing store 

(defconstant $gestaltVMInfoSimpleType 2)        ;  Display whether VM is on or off 

(defconstant $gestaltVMInfoNoneType 3)          ;  Display no VM information 


(defconstant $gestaltVMBackingStoreFileRefNum :|vmbs|);  file refNum of virtual memory's main backing store file (returned in low word of result) 


(defconstant $gestaltALMVers :|walk|)           ;  Settings Manager version (see also gestaltALMAttr) 


(defconstant $gestaltWindowMgrAttr :|wind|)     ;  If this Gestalt exists, the Mac OS 8.5 Window Manager is installed

(defconstant $gestaltWindowMgrPresent 1)        ;  NOTE: this is a bit mask, whereas all other Gestalt constants of
;  this type are bit index values.   Universal Interfaces 3.2 slipped
;  out the door with this mistake.

(defconstant $gestaltWindowMgrPresentBit 0)     ;  bit number

(defconstant $gestaltExtendedWindowAttributes 1);  Has ChangeWindowAttributes; GetWindowAttributes works for all windows

(defconstant $gestaltExtendedWindowAttributesBit 1);  Has ChangeWindowAttributes; GetWindowAttributes works for all windows

(defconstant $gestaltHasFloatingWindows 2)      ;  Floating window APIs work

(defconstant $gestaltHasFloatingWindowsBit 2)   ;  Floating window APIs work

(defconstant $gestaltHasWindowBuffering 3)      ;  This system has buffering available

(defconstant $gestaltHasWindowBufferingBit 3)   ;  This system has buffering available

(defconstant $gestaltWindowLiveResizeBit 4)     ;  live resizing of windows is available

(defconstant $gestaltWindowMinimizeToDockBit 5) ;  windows minimize to the dock and do not windowshade (Mac OS X)

(defconstant $gestaltHasWindowShadowsBit 6)     ;  windows have shadows

(defconstant $gestaltSheetsAreWindowModalBit 7) ;  sheet windows are modal only to their parent window

(defconstant $gestaltFrontWindowMayBeHiddenBit 8);  FrontWindow and related APIs will return the front window even when the app is hidden
;  masks for the above bits

(defconstant $gestaltWindowMgrPresentMask 1)
(defconstant $gestaltExtendedWindowAttributesMask 2)
(defconstant $gestaltHasFloatingWindowsMask 4)
(defconstant $gestaltHasWindowBufferingMask 8)
(defconstant $gestaltWindowLiveResizeMask 16)
(defconstant $gestaltWindowMinimizeToDockMask 32)
(defconstant $gestaltHasWindowShadowsMask 64)
(defconstant $gestaltSheetsAreWindowModalMask #x80)
(defconstant $gestaltFrontWindowMayBeHiddenMask #x100)

(defconstant $gestaltHasSingleWindowModeBit 8)  ;  This system supports single window mode

(defconstant $gestaltHasSingleWindowModeMask #x100)
;  gestaltX86VectorUnit returns the vector unit type (if any)
;    available and supported by both the current processor and operating
;    system 

(defconstant $gestaltX86VectorUnit :|x86v|)
(defconstant $gestaltX86VectorUnitNone 0)
(defconstant $gestaltX86VectorUnitSSE2 4)
(defconstant $gestaltX86VectorUnitSSE 3)
(defconstant $gestaltX86VectorUnitMMX 2)
;  gestaltX86Features is a convenience for 'cpuid' instruction.  Note
;    that even though the processor may support a specific feature, the
;    OS may not support all of these features.  These bitfields
;    correspond directly to the bits returned by cpuid 

(defconstant $gestaltX86Features :|x86f|)
(defconstant $gestaltX86HasFPU 0)               ;  has an FPU that supports the 387 instructions

(defconstant $gestaltX86HasVME 1)               ;  supports Virtual-8086 Mode Extensions

(defconstant $gestaltX86HasDE 2)                ;  supports I/O breakpoints (Debug Extensions)

(defconstant $gestaltX86HasPSE 3)               ;  supports 4-Mbyte pages (Page Size Extension)

(defconstant $gestaltX86HasTSC 4)               ;  supports RTDSC instruction (Time Stamp Counter)

(defconstant $gestaltX86HasMSR 5)               ;  supports Model Specific Registers

(defconstant $gestaltX86HasPAE 6)               ;  supports physical addresses > 32 bits (Physical Address Extension)

(defconstant $gestaltX86HasMCE 7)               ;  supports Machine Check Exception

(defconstant $gestaltX86HasCX8 8)               ;  supports CMPXCHG8 instructions (Compare Exchange 8 bytes)

(defconstant $gestaltX86HasAPIC 9)              ;  contains local APIC

(defconstant $gestaltX86HasSEP 11)              ;  supports fast system call (SysEnter Present)

(defconstant $gestaltX86HasMTRR 12)             ;  supports Memory Type Range Registers

(defconstant $gestaltX86HasPGE 13)              ;  supports Page Global Enable

(defconstant $gestaltX86HasMCA 14)              ;  supports Machine Check Architecture

(defconstant $gestaltX86HasCMOV 15)             ;  supports CMOVcc instruction (Conditional Move).
;  If FPU bit is also set, supports FCMOVcc and FCOMI, too

(defconstant $gestaltX86HasPAT 16)              ;  supports Page Attribute Table

(defconstant $gestaltX86HasPSE36 17)            ;  supports 36-bit Page Size Extension

(defconstant $gestaltX86HasPSN 18)              ;  Processor Serial Number

(defconstant $gestaltX86HasCLFSH 19)            ;  CLFLUSH Instruction supported

(defconstant $gestaltX86Serviced20 20)          ;  do not count on this bit value

(defconstant $gestaltX86HasDS 21)               ;  Debug Store

(defconstant $gestaltX86ResACPI 22)             ;  Thermal Monitor, SW-controlled clock

(defconstant $gestaltX86HasMMX 23)              ;  supports MMX instructions

(defconstant $gestaltX86HasFXSR 24)             ;  Supports FXSAVE and FXRSTOR instructions (fast FP save/restore)

(defconstant $gestaltX86HasSSE 25)              ;  Streaming SIMD extensions

(defconstant $gestaltX86HasSSE2 26)             ;  Streaming SIMD extensions 2

(defconstant $gestaltX86HasSS 27)               ;  Self-Snoop

(defconstant $gestaltX86HasHTT 28)              ;  Hyper-Threading Technology

(defconstant $gestaltX86HasTM 29)               ;  Thermal Monitor


(defconstant $gestaltTranslationAttr :|xlat|)   ;  Translation Manager attributes 

(defconstant $gestaltTranslationMgrExists 0)    ;  True if translation manager exists 

(defconstant $gestaltTranslationMgrHintOrder 1) ;  True if hint order reversal in effect 

(defconstant $gestaltTranslationPPCAvail 2)
(defconstant $gestaltTranslationGetPathAPIAvail 3)

(defconstant $gestaltExtToolboxTable :|xttt|)   ;  Extended Toolbox trap table base 


(defconstant $gestaltUSBPrinterSharingVersion :|zak |);  USB Printer Sharing Version

(defconstant $gestaltUSBPrinterSharingVersionMask #xFFFF);  mask for bits in version

(defconstant $gestaltUSBPrinterSharingAttr :|zak |);  USB Printer Sharing Attributes

(defconstant $gestaltUSBPrinterSharingAttrMask #xFFFF0000);   mask for attribute bits

(defconstant $gestaltUSBPrinterSharingAttrRunning #x80000000);  printer sharing is running

(defconstant $gestaltUSBPrinterSharingAttrBooted #x40000000);  printer sharing was installed at boot time

; WorldScript settings;

(defconstant $gestaltWorldScriptIIVersion :|doub|)
(defconstant $gestaltWorldScriptIIAttr :|wsat|)
(defconstant $gestaltWSIICanPrintWithoutPrGeneralBit 0);  bit 0 is on if WS II knows about PrinterStatus callback 

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __GESTALT__ */


(provide-interface "Gestalt")