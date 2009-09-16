(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OSUtils.h"
; at Sunday July 2,2006 7:23:15 pm.
; 
;      File:       CarbonCore/OSUtils.h
;  
;      Contains:   OS Utilities Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __OSUTILS__
; #define __OSUTILS__
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
;   HandToHand and other memory utilties were moved to MacMemory.h 
; #ifndef __MACMEMORY__
#| #|
#include <CarbonCoreMacMemory.h>
#endif
|#
 |#
;   GetTrapAddress and other trap table utilties were moved to Patches.h 
; #ifndef __PATCHES__
#| #|
#include <CarbonCorePatches.h>
#endif
|#
 |#
;   Date and Time utilties were moved to DateTimeUtils.h 
; #ifndef __DATETIMEUTILS__

(require-interface "CarbonCore/DateTimeUtils")

; #endif

; #ifndef __CFSTRING__

(require-interface "CoreFoundation/CFString")

; #endif


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

(defconstant $useFree 0)
(defconstant $useATalk 1)
(defconstant $useAsync 2)
(defconstant $useExtClk 3)                      ; Externally clocked

(defconstant $useMIDI 4)

(defconstant $false32b 0)                       ; 24 bit addressing error

(defconstant $true32b 1)                        ; 32 bit addressing error

;  result types for RelString Call 

(defconstant $sortsBefore -1)                   ; first string < second string

(defconstant $sortsEqual 0)                     ; first string = second string

(defconstant $sortsAfter 1)                     ; first string > second string


(defconstant $dummyType 0)
(defconstant $vType 1)
(defconstant $ioQType 2)
(defconstant $drvQType 3)
(defconstant $evType 4)
(defconstant $fsQType 5)
(defconstant $sIQType 6)
(defconstant $dtQType 7)
(defconstant $nmType 8)

(def-mactype :QTypes (find-mactype ':SInt8))
(defrecord SysParmType
   (valid :UInt8)
   (aTalkA :UInt8)
   (aTalkB :UInt8)
   (config :UInt8)
   (portA :SInt16)
   (portB :SInt16)
   (alarm :signed-long)
   (font :SInt16)
   (kbdPrint :SInt16)
   (volClik :SInt16)
   (misc :SInt16)
)

;type name? (%define-record :SysParmType (find-record-descriptor ':SysParmType))

(def-mactype :SysPPtr (find-mactype '(:pointer :SysParmType)))
(defrecord QElem
   (qLink (:pointer :qelem))
   (qType :SInt16)
   (qData (:array :SInt16 1))
)

;type name? (%define-record :QElem (find-record-descriptor ':QElem))

(def-mactype :QElemPtr (find-mactype '(:pointer :QElem)))
(defrecord QHdr
   (qFlags :SInt16)
   (qHead (:pointer :QElem))
   (qTail (:pointer :QElem))
)

;type name? (%define-record :QHdr (find-record-descriptor ':QHdr))

(def-mactype :QHdrPtr (find-mactype '(:pointer :QHdr)))

(def-mactype :DeferredTaskProcPtr (find-mactype ':pointer)); (long dtParam)

(def-mactype :DeferredTaskUPP (find-mactype '(:pointer :OpaqueDeferredTaskProcPtr)))
; 
;  *  NewDeferredTaskUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDeferredTaskUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDeferredTaskProcPtr)
() )
; 
;  *  DisposeDeferredTaskUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDeferredTaskUPP" 
   ((userUPP (:pointer :OpaqueDeferredTaskProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDeferredTaskUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDeferredTaskUPP" 
   ((dtParam :signed-long)
    (userUPP (:pointer :OpaqueDeferredTaskProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
(defrecord DeferredTask
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (dtFlags :SInt16)
   (dtAddr (:pointer :OpaqueDeferredTaskProcPtr))
   (dtParam :signed-long)
   (dtReserved :signed-long)
)

;type name? (%define-record :DeferredTask (find-record-descriptor ':DeferredTask))

(def-mactype :DeferredTaskPtr (find-mactype '(:pointer :DeferredTask)))
;  
;     In order for MachineLocation to be endian-safe, a new member 
;     has been added to the 'u' union in the structure. You are 
;     encouraged to use the new member instead of the old one.
;     
;     If your code looked like this:
;     
;         MachineLocation.u.dlsDelta = isDLS? 0x80: 0x00;
;     
;     you should change it to this:
;     
;         MachineLocation.u.dls.Delta = isDLS? 0x80: 0x00;
;     
;     to be endian safe. The gmtDelta remains the same; the low 24-bits
;     are used. Remember that order of assignment DOES matter:
;     
;     This will overwrite results:
;     
;         MachineLocation.u.dls.Delta = 0xAA;         // u = 0xAAGGGGGG; G=Garbage
;         MachineLocation.u.gmtDelta = 0xBBBBBB;      // u = 0x00BBBBBB;
;     
;     when in fact reversing the assignment would have preserved the values:
; 
;         MachineLocation.u.gmtDelta = 0xBBBBBB;      // u = 0x00BBBBBB;  
;         MachineLocation.u.dls.Delta = 0xAA;         // u = 0xAABBBBBB;
;         
;     NOTE:   The information regarding dlsDelta in Inside Mac is INCORRECT.
;             It's always 0x80 for daylight-saving time or 0x00 for standard time.
; 
(defrecord MachineLocation
   (latitude :signed-long)
   (longitude :signed-long)
   (:variant

; #if TARGET_RT_BIG_ENDIAN
   (
   (dlsDelta :SInt8)
   )

; #endif

   (
   (gmtDelta :signed-long)
   )
                                                ;  use low 24-bits only 
   (

; #if TARGET_RT_LITTLE_ENDIAN
#|    (pad (:array :SInt8 3))
 |#

; #endif

   (Delta :SInt8)                               ;  signed byte; daylight savings delta 
   )
   )
)

;type name? (%define-record :MachineLocation (find-record-descriptor ':MachineLocation))
; 
;  *  IsMetric()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IsMetric" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetSysPPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetSysPPtr" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :SysParmType)
() )
; 
;     NOTE: SysBeep() has been moved to Sound.h.  
;           We could not automatically #include Sound.h in this file
;           because Sound.h indirectly #include's OSUtils.h which
;           would make a circular include.
; 
; 
;  *  DTInstall()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DTInstall" 
   ((dtTaskPtr (:pointer :DeferredTask))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

; #if TARGET_CPU_PPC || !TARGET_OS_MAC
; #define GetMMUMode() ((SInt8)true32b)
; #define SwapMMUMode(x) (*(SInt8*)(x) = true32b)
#| 
; #else
; 
;  *  GetMMUMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  SwapMMUMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
 |#

; #endif

; 
;  *  Delay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Delay" 
   ((numTicks :UInt32)
    (finalTicks (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  WriteParam()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_WriteParam" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  Enqueue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Enqueue" 
   ((qElement (:pointer :QElem))
    (qHeader (:pointer :QHdr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Dequeue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Dequeue" 
   ((qElement (:pointer :QElem))
    (qHeader (:pointer :QHdr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCurrentA5()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetCurrentA5" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetA5()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetA5" 
   ((newA5 :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  InitUtil()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InitUtil" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MakeDataExecutable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_MakeDataExecutable" 
   ((baseAddress :pointer)
    (length :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FlushCodeCacheRange()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  
; 
;  *  ReadLocation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ReadLocation" 
   ((loc (:pointer :MachineLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  WriteLocation()   *** DEPRECATED ***
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.0
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_WriteLocation" 
   ((loc (:pointer :MachineLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED
   nil
() )
; 
;  *  TickCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TickCount" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  CSCopyUserName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CSCopyUserName" 
   ((useShortName :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  CSCopyMachineName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CSCopyMachineName" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :__CFString)
() )

; #if OLDROUTINENAMES
#| 
; #define IUMetric() IsMetric()
 |#

; #endif  /* OLDROUTINENAMES */

; 
;     NOTE: SysEnvirons is obsolete.  You should be using Gestalt.
; 
;  Environs Equates 

(defconstant $curSysEnvVers 2)                  ; Updated to equal latest SysEnvirons version

(defrecord SysEnvRec
   (environsVersion :SInt16)
   (machineType :SInt16)
   (systemVersion :SInt16)
   (processor :SInt16)
   (hasFPU :Boolean)
   (hasColorQD :Boolean)
   (keyBoardType :SInt16)
   (atDrvrVersNum :SInt16)
   (sysVRefNum :SInt16)
)

;type name? (%define-record :SysEnvRec (find-record-descriptor ':SysEnvRec))
;  Machine Types 

(defconstant $envMac -1)
(defconstant $envXL -2)
(defconstant $envMachUnknown 0)
(defconstant $env512KE 1)
(defconstant $envMacPlus 2)
(defconstant $envSE 3)
(defconstant $envMacII 4)
(defconstant $envMacIIx 5)
(defconstant $envMacIIcx 6)
(defconstant $envSE30 7)
(defconstant $envPortable 8)
(defconstant $envMacIIci 9)
(defconstant $envMacIIfx 11)
;  CPU types 

(defconstant $envCPUUnknown 0)
(defconstant $env68000 1)
(defconstant $env68010 2)
(defconstant $env68020 3)
(defconstant $env68030 4)
(defconstant $env68040 5)
;  Keyboard types 

(defconstant $envUnknownKbd 0)
(defconstant $envMacKbd 1)
(defconstant $envMacAndPad 2)
(defconstant $envMacPlusKbd 3)
(defconstant $envAExtendKbd 4)
(defconstant $envStandADBKbd 5)
(defconstant $envPrtblADBKbd 6)
(defconstant $envPrtblISOKbd 7)
(defconstant $envStdISOADBKbd 8)
(defconstant $envExtISOADBKbd 9)
; 
;  *  SysEnvirons()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __OSUTILS__ */


(provide-interface "OSUtils")