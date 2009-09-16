(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MachineExceptions.h"
; at Sunday July 2,2006 7:23:23 pm.
; 
;      File:       CarbonCore/MachineExceptions.h
;  
;      Contains:   Processor Exception Handling Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1993-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MACHINEEXCEPTIONS__
; #define __MACHINEEXCEPTIONS__
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
; #pragma options align=power
;  Some basic declarations used throughout the kernel 

(def-mactype :AreaID (find-mactype '(:pointer :OpaqueAreaID)))
;  Machine Dependent types for PowerPC: 
(defrecord MachineInformationPowerPC
   (CTR :UnsignedWide)
   (LR :UnsignedWide)
   (PC :UnsignedWide)
   (CR :UInt32)
   (XER :UInt32)
   (MSR :UInt32)
   (MQ :UInt32)
   (ExceptKind :UInt32)
   (DSISR :UInt32)
   (DAR :UnsignedWide)
   (Reserved :UnsignedWide)
)

;type name? (%define-record :MachineInformationPowerPC (find-record-descriptor ':MachineInformationPowerPC))
(defrecord RegisterInformationPowerPC
   (R0 :UnsignedWide)
   (R1 :UnsignedWide)
   (R2 :UnsignedWide)
   (R3 :UnsignedWide)
   (R4 :UnsignedWide)
   (R5 :UnsignedWide)
   (R6 :UnsignedWide)
   (R7 :UnsignedWide)
   (R8 :UnsignedWide)
   (R9 :UnsignedWide)
   (R10 :UnsignedWide)
   (R11 :UnsignedWide)
   (R12 :UnsignedWide)
   (R13 :UnsignedWide)
   (R14 :UnsignedWide)
   (R15 :UnsignedWide)
   (R16 :UnsignedWide)
   (R17 :UnsignedWide)
   (R18 :UnsignedWide)
   (R19 :UnsignedWide)
   (R20 :UnsignedWide)
   (R21 :UnsignedWide)
   (R22 :UnsignedWide)
   (R23 :UnsignedWide)
   (R24 :UnsignedWide)
   (R25 :UnsignedWide)
   (R26 :UnsignedWide)
   (R27 :UnsignedWide)
   (R28 :UnsignedWide)
   (R29 :UnsignedWide)
   (R30 :UnsignedWide)
   (R31 :UnsignedWide)
)

;type name? (%define-record :RegisterInformationPowerPC (find-record-descriptor ':RegisterInformationPowerPC))
(defrecord FPUInformationPowerPC
   (Registers (:array :UnsignedWide 32))
   (FPSCR :UInt32)
   (Reserved :UInt32)
)

;type name? (%define-record :FPUInformationPowerPC (find-record-descriptor ':FPUInformationPowerPC))
(defrecord Vector128
   (:variant
; #ifdef __VEC__
#| #|
 vector unsigned int         v;
#endif
|#
 |#
   (
   (l (:array :UInt32 4))
   )
   (
   (s (:array :UInt16 8))
   )
   (
   (c (:array :UInt8 16))
   )
   )
)

;type name? (%define-record :Vector128 (find-record-descriptor ':Vector128))
(defrecord VectorInformationPowerPC
   (Registers (:array :Vector128 32))
   (VSCR :Vector128)
   (VRsave :UInt32)
)

;type name? (%define-record :VectorInformationPowerPC (find-record-descriptor ':VectorInformationPowerPC))
;  Exception related declarations 

(defconstant $kWriteReference 0)
(defconstant $kReadReference 1)
(defconstant $kFetchReference 2)
(defconstant $writeReference 0)                 ;  Obsolete name

(defconstant $readReference 1)                  ;  Obsolete name

(defconstant $fetchReference 2)                 ;  Obsolete name


(def-mactype :MemoryReferenceKind (find-mactype ':UInt32))
(defrecord MemoryExceptionInformation
   (theArea (:pointer :OpaqueAreaID))           ;  The area related to the execption, same as MPAreaID.
   (theAddress (:pointer :void))                ;  The 32-bit address of the exception.
   (theError :SInt32)                           ;  See enum below.
   (theReference :UInt32)                       ;  read, write, instruction fetch.
)

;type name? (%define-record :MemoryExceptionInformation (find-record-descriptor ':MemoryExceptionInformation))

(defconstant $kUnknownException 0)
(defconstant $kIllegalInstructionException 1)
(defconstant $kTrapException 2)
(defconstant $kAccessException 3)
(defconstant $kUnmappedMemoryException 4)
(defconstant $kExcludedMemoryException 5)
(defconstant $kReadOnlyMemoryException 6)
(defconstant $kUnresolvablePageFaultException 7)
(defconstant $kPrivilegeViolationException 8)
(defconstant $kTraceException 9)
(defconstant $kInstructionBreakpointException 10);  Optional

(defconstant $kDataBreakpointException 11)      ;  Optional

(defconstant $kIntegerException 12)
(defconstant $kFloatingPointException 13)
(defconstant $kStackOverflowException 14)       ;  Optional, may be implemented as kAccessException on some systems.

(defconstant $kTaskTerminationException 15)     ;  Obsolete

(defconstant $kTaskCreationException 16)        ;  Obsolete

(defconstant $kDataAlignmentException 17)       ;  May occur when a task is in little endian mode or created with kMPTaskTakesAllExceptions.


; #if OLDROUTINENAMES
#| 
(defconstant $unknownException 0)               ;  Obsolete name

(defconstant $illegalInstructionException 1)    ;  Obsolete name

(defconstant $trapException 2)                  ;  Obsolete name

(defconstant $accessException 3)                ;  Obsolete name

(defconstant $unmappedMemoryException 4)        ;  Obsolete name

(defconstant $excludedMemoryException 5)        ;  Obsolete name

(defconstant $readOnlyMemoryException 6)        ;  Obsolete name

(defconstant $unresolvablePageFaultException 7) ;  Obsolete name

(defconstant $privilegeViolationException 8)    ;  Obsolete name

(defconstant $traceException 9)                 ;  Obsolete name

(defconstant $instructionBreakpointException 10);  Obsolete name

(defconstant $dataBreakpointException 11)       ;  Obsolete name

(defconstant $integerException 12)              ;  Obsolete name

(defconstant $floatingPointException 13)        ;  Obsolete name

(defconstant $stackOverflowException 14)        ;  Obsolete name

(defconstant $terminationException 15)          ;  Obsolete name

(defconstant $kTerminationException 15)         ;  Obsolete name

 |#

; #endif  /* OLDROUTINENAMES */


(def-mactype :ExceptionKind (find-mactype ':UInt32))
(defrecord ExceptionInfo
   (:variant
   (
   (memoryInfo (:pointer :MemoryExceptionInformation))
   )
   )
)

;type name? (%define-record :ExceptionInfo (find-record-descriptor ':ExceptionInfo))
(defrecord ExceptionInformationPowerPC
   (theKind :UInt32)
   (machineState (:pointer :MachineInformationPowerPC))
   (registerImage (:pointer :RegisterInformationPowerPC))
   (FPUImage (:pointer :FPUInformationPowerPC))
   (info :ExceptionInfo)
   (vectorImage (:pointer :VectorInformationPowerPC))
)

;type name? (%define-record :ExceptionInformationPowerPC (find-record-descriptor ':ExceptionInformationPowerPC))

; #if TARGET_CPU_PPC

(%define-record :ExceptionInformation (find-record-descriptor ':ExceptionInformationPowerPC))

(%define-record :MachineInformation (find-record-descriptor ':MachineInformationPowerPC))

(%define-record :RegisterInformation (find-record-descriptor ':RegisterInformationPowerPC))

(%define-record :FPUInformation (find-record-descriptor ':FPUInformationPowerPC))

(%define-record :VectorInformation (find-record-descriptor ':VectorInformationPowerPC))

; #endif  /* TARGET_CPU_PPC */


; #if TARGET_CPU_X86
#| 
(defrecord MachineInformationIntel
   (CS :UInt16)
   (DS :UInt16)
   (SS :UInt16)
   (ES :UInt16)
   (FS :UInt16)
   (GS :UInt16)
   (EFLAGS :UInt32)
   (EIP :UInt32)
)

;type name? (def-mactype :MachineInformationIntel (find-mactype ':MachineInformationIntel))
(defrecord RegisterInformationIntel
   (EAX :UInt32)
   (EBX :UInt32)
   (ECX :UInt32)
   (EDX :UInt32)
   (ESI :UInt32)
   (EDI :UInt32)
   (EBP :UInt32)
   (ESP :UInt32)
)

;type name? (def-mactype :RegisterInformationIntel (find-mactype ':RegisterInformationIntel))
(defrecord FPRegIntel
   (contents (:array :UInt8 10))
)
(defrecord FPUInformationIntel
   (Registers (:array :fpregintel 8))
   (Control :UInt16)
   (Status :UInt16)
   (Tag :UInt16)
   (Opcode :UInt16)
   (EIP :UInt32)
   (DP :UInt32)
   (DS :UInt32)
)

;type name? (def-mactype :FPUInformationIntel (find-mactype ':FPUInformationIntel))
(defrecord VectorInformationIntel
   (Registers (:array :UnsignedWide 8))
)

;type name? (def-mactype :VectorInformationIntel (find-mactype ':VectorInformationIntel))

(def-mactype :MachineInformation (find-mactype ':MachineInformationIntel))

(def-mactype :RegisterInformation (find-mactype ':RegisterInformationIntel))

(def-mactype :FPUInformation (find-mactype ':FPUInformationIntel))

(def-mactype :VectorInformation (find-mactype ':VectorInformationIntel))
(defrecord ExceptionInformation
   (theKind :UInt32)
   (machineState (:pointer :MachineInformation))
   (registerImage (:pointer :RegisterInformation))
   (FPUImage (:pointer :FPUInformation))
   (info :ExceptionInfo)
   (vectorImage (:pointer :VectorInformation))
)

;type name? (%define-record :ExceptionInformation (find-record-descriptor ':ExceptionInformationPowerPC))
 |#

; #endif  /* TARGET_CPU_X86 */

;  
;     Note:   An ExceptionHandler is NOT a UniversalProcPtr, except in Carbon.
;             It must be a PowerPC function pointer with NO routine descriptor, 
;             except on Carbon, where it must be a UniversalProcPtr (TPP actually)
;             to allow the interface to work from both CFM and Mach-O.
; 

(def-mactype :ExceptionHandlerProcPtr (find-mactype ':pointer)); (ExceptionInformation * theException)

(def-mactype :ExceptionHandlerUPP (find-mactype '(:pointer :OpaqueExceptionHandlerProcPtr)))
; 
;  *  NewExceptionHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewExceptionHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueExceptionHandlerProcPtr)
() )
; 
;  *  DisposeExceptionHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeExceptionHandlerUPP" 
   ((userUPP (:pointer :OpaqueExceptionHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeExceptionHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeExceptionHandlerUPP" 
   ((theException (:pointer :ExceptionInformation))
    (userUPP (:pointer :OpaqueExceptionHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    ExceptionHandler function pointers (TPP):
;    on classic PowerPC, use raw function pointers
;    on classic PowerPC with OPAQUE_UPP_TYPES=1, use UPP's
;    on Carbon, use UPP's
; 
;  use UPP's

(def-mactype :ExceptionHandlerTPP (find-mactype ':ExceptionHandlerUPP))

(def-mactype :ExceptionHandler (find-mactype ':ExceptionHandlerTPP))
;  Routine for installing per-process exception handlers 
; 
;  *  InstallExceptionHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InstallExceptionHandler" 
   ((theHandler (:pointer :OpaqueExceptionHandlerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueExceptionHandlerProcPtr)
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MACHINEEXCEPTIONS__ */


(provide-interface "MachineExceptions")