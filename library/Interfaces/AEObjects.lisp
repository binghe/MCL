(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AEObjects.h"
; at Sunday July 2,2006 7:24:26 pm.
; 
;      File:       AE/AEObjects.h
;  
;      Contains:   Object Support Library Interfaces.
;  
;      Version:    AppleEvents-275~1
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AEOBJECTS__
; #define __AEOBJECTS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __APPLEEVENTS__
#| #|
#include <AEAppleEvents.h>
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
; #pragma options align=mac68k
; *** LOGICAL OPERATOR CONSTANTS  ***

(defconstant $kAEAND :|AND |)                   ;   0x414e4420  

(defconstant $kAEOR :|OR  |)                    ;   0x4f522020  

(defconstant $kAENOT :|NOT |)                   ;   0x4e4f5420  
; *** ABSOLUTE ORDINAL CONSTANTS  ***

(defconstant $kAEFirst :|firs|)                 ;   0x66697273  

(defconstant $kAELast :|last|)                  ;   0x6c617374  

(defconstant $kAEMiddle :|midd|)                ;   0x6d696464  

(defconstant $kAEAny :|any |)                   ;   0x616e7920  

(defconstant $kAEAll :|all |)                   ;   0x616c6c20  
; *** RELATIVE ORDINAL CONSTANTS  ***

(defconstant $kAENext :|next|)                  ;   0x6e657874  

(defconstant $kAEPrevious :|prev|)              ;   0x70726576  
; *** KEYWORD CONSTANT    ***

(defconstant $keyAECompOperator :|relo|)        ;   0x72656c6f  

(defconstant $keyAELogicalTerms :|term|)        ;   0x7465726d  

(defconstant $keyAELogicalOperator :|logc|)     ;   0x6c6f6763  

(defconstant $keyAEObject1 :|obj1|)             ;   0x6f626a31  

(defconstant $keyAEObject2 :|obj2|)             ;   0x6f626a32  
;     ... for Keywords for getting fields out of object specifier records. 

(defconstant $keyAEDesiredClass :|want|)        ;   0x77616e74  

(defconstant $keyAEContainer :|from|)           ;   0x66726f6d  

(defconstant $keyAEKeyForm :|form|)             ;   0x666f726d  

(defconstant $keyAEKeyData :|seld|)             ;   0x73656c64  

;     ... for Keywords for getting fields out of Range specifier records. 

(defconstant $keyAERangeStart :|star|)          ;   0x73746172  

(defconstant $keyAERangeStop :|stop|)           ;   0x73746f70  
;     ... special handler selectors for OSL Callbacks. 

(defconstant $keyDisposeTokenProc :|xtok|)      ;   0x78746f6b  

(defconstant $keyAECompareProc :|cmpr|)         ;   0x636d7072  

(defconstant $keyAECountProc :|cont|)           ;   0x636f6e74  

(defconstant $keyAEMarkTokenProc :|mkid|)       ;   0x6d6b6964  

(defconstant $keyAEMarkProc :|mark|)            ;   0x6d61726b  

(defconstant $keyAEAdjustMarksProc :|adjm|)     ;   0x61646a6d  

(defconstant $keyAEGetErrDescProc :|indc|)      ;   0x696e6463  

; ***   VALUE and TYPE CONSTANTS    ***
;     ... possible values for the keyAEKeyForm field of an object specifier. 

(defconstant $formAbsolutePosition :|indx|)     ;   0x696e6478  

(defconstant $formRelativePosition :|rele|)     ;   0x72656c65  

(defconstant $formTest :|test|)                 ;   0x74657374  

(defconstant $formRange :|rang|)                ;   0x72616e67  

(defconstant $formPropertyID :|prop|)           ;   0x70726f70  

(defconstant $formName :|name|)                 ;   0x6e616d65  
;     ... relevant types (some of these are often pared with forms above). 

(defconstant $typeObjectSpecifier :|obj |)      ;   0x6f626a20  

(defconstant $typeObjectBeingExamined :|exmn|)  ;   0x65786d6e  

(defconstant $typeCurrentContainer :|ccnt|)     ;   0x63636e74  

(defconstant $typeToken :|toke|)                ;   0x746f6b65  

(defconstant $typeRelativeDescriptor :|rel |)   ;   0x72656c20  

(defconstant $typeAbsoluteOrdinal :|abso|)      ;   0x6162736f  

(defconstant $typeIndexDescriptor :|inde|)      ;   0x696e6465  

(defconstant $typeRangeDescriptor :|rang|)      ;   0x72616e67  

(defconstant $typeLogicalDescriptor :|logi|)    ;   0x6c6f6769  

(defconstant $typeCompDescriptor :|cmpd|)       ;   0x636d7064  

(defconstant $typeOSLTokenList :|ostl|)         ;   0x6F73746C  

;  Possible values for flags parameter to AEResolve.  They're additive 

(defconstant $kAEIDoMinimum 0)
(defconstant $kAEIDoWhose 1)
(defconstant $kAEIDoMarking 4)
(defconstant $kAEPassSubDescs 8)
(defconstant $kAEResolveNestedLists 16)
(defconstant $kAEHandleSimpleRanges 32)
(defconstant $kAEUseRelativeIterators 64)
; *** SPECIAL CONSTANTS FOR CUSTOM WHOSE-CLAUSE RESOLUTION 

(defconstant $typeWhoseDescriptor :|whos|)      ;   0x77686f73  

(defconstant $formWhose :|whos|)                ;   0x77686f73  

(defconstant $typeWhoseRange :|wrng|)           ;   0x77726e67  

(defconstant $keyAEWhoseRangeStart :|wstr|)     ;   0x77737472  

(defconstant $keyAEWhoseRangeStop :|wstp|)      ;   0x77737470  

(defconstant $keyAEIndex :|kidx|)               ;   0x6b696478  

(defconstant $keyAETest :|ktst|)                ;   0x6b747374  

; 
;     used for rewriting tokens in place of 'ccnt' descriptors
;     This record is only of interest to those who, when they...
;     ...get ranges as key data in their accessor procs, choose
;     ...to resolve them manually rather than call AEResolve again.
; 
(defrecord ccntTokenRecord
   (tokenClass :FourCharCode)
   (token :AEDesc)
)

;type name? (%define-record :ccntTokenRecord (find-record-descriptor ':ccntTokenRecord))

(def-mactype :ccntTokenRecPtr (find-mactype '(:pointer :ccntTokenRecord)))

(def-mactype :ccntTokenRecHandle (find-mactype '(:handle :ccntTokenRecord)))

; #if OLDROUTINENAMES
#| 
(def-mactype :DescPtr (find-mactype '(:pointer :AEDesc)))

(def-mactype :DescHandle (find-mactype '(:pointer :DescPtr)))
 |#

; #endif  /* OLDROUTINENAMES */

;  typedefs providing type checking for procedure pointers 

(def-mactype :OSLAccessorProcPtr (find-mactype ':pointer)); (DescType desiredClass , const AEDesc * container , DescType containerClass , DescType form , const AEDesc * selectionData , AEDesc * value , long accessorRefcon)

(def-mactype :OSLCompareProcPtr (find-mactype ':pointer)); (DescType oper , const AEDesc * obj1 , const AEDesc * obj2 , Boolean * result)

(def-mactype :OSLCountProcPtr (find-mactype ':pointer)); (DescType desiredType , DescType containerClass , const AEDesc * container , long * result)

(def-mactype :OSLDisposeTokenProcPtr (find-mactype ':pointer)); (AEDesc * unneededToken)

(def-mactype :OSLGetMarkTokenProcPtr (find-mactype ':pointer)); (const AEDesc * dContainerToken , DescType containerClass , AEDesc * result)

(def-mactype :OSLGetErrDescProcPtr (find-mactype ':pointer)); (AEDesc ** appDescPtr)

(def-mactype :OSLMarkProcPtr (find-mactype ':pointer)); (const AEDesc * dToken , const AEDesc * markToken , long index)

(def-mactype :OSLAdjustMarksProcPtr (find-mactype ':pointer)); (long newStart , long newStop , const AEDesc * markToken)

(def-mactype :OSLAccessorUPP (find-mactype '(:pointer :OpaqueOSLAccessorProcPtr)))

(def-mactype :OSLCompareUPP (find-mactype '(:pointer :OpaqueOSLCompareProcPtr)))

(def-mactype :OSLCountUPP (find-mactype '(:pointer :OpaqueOSLCountProcPtr)))

(def-mactype :OSLDisposeTokenUPP (find-mactype '(:pointer :OpaqueOSLDisposeTokenProcPtr)))

(def-mactype :OSLGetMarkTokenUPP (find-mactype '(:pointer :OpaqueOSLGetMarkTokenProcPtr)))

(def-mactype :OSLGetErrDescUPP (find-mactype '(:pointer :OpaqueOSLGetErrDescProcPtr)))

(def-mactype :OSLMarkUPP (find-mactype '(:pointer :OpaqueOSLMarkProcPtr)))

(def-mactype :OSLAdjustMarksUPP (find-mactype '(:pointer :OpaqueOSLAdjustMarksProcPtr)))
; 
;  *  NewOSLAccessorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOSLAccessorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOSLAccessorProcPtr)
() )
; 
;  *  NewOSLCompareUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOSLCompareUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOSLCompareProcPtr)
() )
; 
;  *  NewOSLCountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOSLCountUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOSLCountProcPtr)
() )
; 
;  *  NewOSLDisposeTokenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOSLDisposeTokenUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOSLDisposeTokenProcPtr)
() )
; 
;  *  NewOSLGetMarkTokenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOSLGetMarkTokenUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOSLGetMarkTokenProcPtr)
() )
; 
;  *  NewOSLGetErrDescUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOSLGetErrDescUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOSLGetErrDescProcPtr)
() )
; 
;  *  NewOSLMarkUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOSLMarkUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOSLMarkProcPtr)
() )
; 
;  *  NewOSLAdjustMarksUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewOSLAdjustMarksUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueOSLAdjustMarksProcPtr)
() )
; 
;  *  DisposeOSLAccessorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOSLAccessorUPP" 
   ((userUPP (:pointer :OpaqueOSLAccessorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeOSLCompareUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOSLCompareUPP" 
   ((userUPP (:pointer :OpaqueOSLCompareProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeOSLCountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOSLCountUPP" 
   ((userUPP (:pointer :OpaqueOSLCountProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeOSLDisposeTokenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOSLDisposeTokenUPP" 
   ((userUPP (:pointer :OpaqueOSLDisposeTokenProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeOSLGetMarkTokenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOSLGetMarkTokenUPP" 
   ((userUPP (:pointer :OpaqueOSLGetMarkTokenProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeOSLGetErrDescUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOSLGetErrDescUPP" 
   ((userUPP (:pointer :OpaqueOSLGetErrDescProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeOSLMarkUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOSLMarkUPP" 
   ((userUPP (:pointer :OpaqueOSLMarkProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeOSLAdjustMarksUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeOSLAdjustMarksUPP" 
   ((userUPP (:pointer :OpaqueOSLAdjustMarksProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeOSLAccessorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOSLAccessorUPP" 
   ((desiredClass :FourCharCode)
    (container (:pointer :AEDesc))
    (containerClass :FourCharCode)
    (form :FourCharCode)
    (selectionData (:pointer :AEDesc))
    (value (:pointer :AEDesc))
    (accessorRefcon :signed-long)
    (userUPP (:pointer :OpaqueOSLAccessorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeOSLCompareUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOSLCompareUPP" 
   ((oper :FourCharCode)
    (obj1 (:pointer :AEDesc))
    (obj2 (:pointer :AEDesc))
    (result (:pointer :Boolean))
    (userUPP (:pointer :OpaqueOSLCompareProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeOSLCountUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOSLCountUPP" 
   ((desiredType :FourCharCode)
    (containerClass :FourCharCode)
    (container (:pointer :AEDesc))
    (result (:pointer :long))
    (userUPP (:pointer :OpaqueOSLCountProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeOSLDisposeTokenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOSLDisposeTokenUPP" 
   ((unneededToken (:pointer :AEDesc))
    (userUPP (:pointer :OpaqueOSLDisposeTokenProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeOSLGetMarkTokenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOSLGetMarkTokenUPP" 
   ((dContainerToken (:pointer :AEDesc))
    (containerClass :FourCharCode)
    (result (:pointer :AEDesc))
    (userUPP (:pointer :OpaqueOSLGetMarkTokenProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeOSLGetErrDescUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOSLGetErrDescUPP" 
   ((appDescPtr (:pointer :AEDesc))
    (userUPP (:pointer :OpaqueOSLGetErrDescProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeOSLMarkUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOSLMarkUPP" 
   ((dToken (:pointer :AEDesc))
    (markToken (:pointer :AEDesc))
    (index :signed-long)
    (userUPP (:pointer :OpaqueOSLMarkProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeOSLAdjustMarksUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeOSLAdjustMarksUPP" 
   ((newStart :signed-long)
    (newStop :signed-long)
    (markToken (:pointer :AEDesc))
    (userUPP (:pointer :OpaqueOSLAdjustMarksProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEObjectInit()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_AEObjectInit" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Not done by inline, but by direct linking into code.  It sets up the pack
;   such that further calls can be via inline 
; 
;  *  AESetObjectCallbacks()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_AESetObjectCallbacks" 
   ((myCompareProc (:pointer :OpaqueOSLCompareProcPtr))
    (myCountProc (:pointer :OpaqueOSLCountProcPtr))
    (myDisposeTokenProc (:pointer :OpaqueOSLDisposeTokenProcPtr))
    (myGetMarkTokenProc (:pointer :OpaqueOSLGetMarkTokenProcPtr))
    (myMarkProc (:pointer :OpaqueOSLMarkProcPtr))
    (myAdjustMarksProc (:pointer :OpaqueOSLAdjustMarksProcPtr))
    (myGetErrDescProcPtr (:pointer :OpaqueOSLGetErrDescProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEResolve()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_AEResolve" 
   ((objectSpecifier (:pointer :AEDesc))
    (callbackFlags :SInt16)
    (theToken (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEInstallObjectAccessor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_AEInstallObjectAccessor" 
   ((desiredClass :FourCharCode)
    (containerType :FourCharCode)
    (theAccessor (:pointer :OpaqueOSLAccessorProcPtr))
    (accessorRefcon :signed-long)
    (isSysHandler :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AERemoveObjectAccessor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_AERemoveObjectAccessor" 
   ((desiredClass :FourCharCode)
    (containerType :FourCharCode)
    (theAccessor (:pointer :OpaqueOSLAccessorProcPtr))
    (isSysHandler :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEGetObjectAccessor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_AEGetObjectAccessor" 
   ((desiredClass :FourCharCode)
    (containerType :FourCharCode)
    (accessor (:pointer :OSLACCESSORUPP))
    (accessorRefcon (:pointer :long))
    (isSysHandler :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AEDisposeToken()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_AEDisposeToken" 
   ((theToken (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AECallObjectAccessor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_AECallObjectAccessor" 
   ((desiredClass :FourCharCode)
    (containerToken (:pointer :AEDesc))
    (containerClass :FourCharCode)
    (keyForm :FourCharCode)
    (keyData (:pointer :AEDesc))
    (token (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __AEOBJECTS__ */


(provide-interface "AEObjects")