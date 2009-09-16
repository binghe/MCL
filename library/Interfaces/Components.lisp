(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Components.h"
; at Sunday July 2,2006 7:23:15 pm.
; 
;      File:       CarbonCore/Components.h
;  
;      Contains:   Component Manager Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __COMPONENTS__
; #define __COMPONENTS__
; #ifndef __MACERRORS__
#| #|
#include <CarbonCoreMacErrors.h>
#endif
|#
 |#
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
; #ifndef __FILES__

(require-interface "CarbonCore/Files")

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

(defconstant $kAppleManufacturer :|appl|)       ;  Apple supplied components 

(defconstant $kComponentResourceType :|thng|)   ;  a components resource type 

(defconstant $kComponentAliasResourceType :|thga|);  component alias resource type 


(defconstant $kAnyComponentType 0)
(defconstant $kAnyComponentSubType 0)
(defconstant $kAnyComponentManufacturer 0)
(defconstant $kAnyComponentFlagsMask 0)

(defconstant $cmpThreadSafe #x10000000)         ;  component is thread-safe 

(defconstant $cmpIsMissing #x20000000)
(defconstant $cmpWantsRegisterMessage #x80000000)

(defconstant $kComponentOpenSelect -1)          ;  ComponentInstance for this open 

(defconstant $kComponentCloseSelect -2)         ;  ComponentInstance for this close 

(defconstant $kComponentCanDoSelect -3)         ;  selector # being queried 

(defconstant $kComponentVersionSelect -4)       ;  no params 

(defconstant $kComponentRegisterSelect -5)      ;  no params 

(defconstant $kComponentTargetSelect -6)        ;  ComponentInstance for top of call chain 

(defconstant $kComponentUnregisterSelect -7)    ;  no params 

(defconstant $kComponentGetMPWorkFunctionSelect -8);  some params 

(defconstant $kComponentExecuteWiredActionSelect -9);  QTAtomContainer actionContainer, QTAtom actionAtom, QTCustomActionTargetPtr target, QTEventRecordPtr event 
;  OSType resourceType, short resourceId, Handle *resource 

(defconstant $kComponentGetPublicResourceSelect -10)
;  Component Resource Extension flags 

(defconstant $componentDoAutoVersion 1)
(defconstant $componentWantsUnregister 2)
(defconstant $componentAutoVersionIncludeFlags 4)
(defconstant $componentHasMultiplePlatforms 8)
(defconstant $componentLoadResident 16)
;  Set Default Component flags 

(defconstant $defaultComponentIdentical 0)
(defconstant $defaultComponentAnyFlags 1)
(defconstant $defaultComponentAnyManufacturer 2)
(defconstant $defaultComponentAnySubType 4)
(defconstant $defaultComponentAnyFlagsAnyManufacturer 3)
(defconstant $defaultComponentAnyFlagsAnyManufacturerAnySubType 7)
;  RegisterComponentResource flags 

(defconstant $registerComponentGlobal 1)
(defconstant $registerComponentNoDuplicates 2)
(defconstant $registerComponentAfterExisting 4)
(defconstant $registerComponentAliasesOnly 8)
(defrecord ComponentDescription
   (componentType :OSType)                      ;  A unique 4-byte code indentifying the command set 
   (componentSubType :OSType)                   ;  Particular flavor of this instance 
   (componentManufacturer :OSType)              ;  Vendor indentification 
   (componentFlags :UInt32)                     ;  8 each for Component,Type,SubType,Manuf/revision 
   (componentFlagsMask :UInt32)                 ;  Mask for specifying which flags to consider in search, zero during registration 
)

;type name? (%define-record :ComponentDescription (find-record-descriptor ':ComponentDescription))
(defrecord ResourceSpec
   (resType :OSType)                            ;  4-byte code    
   (resID :SInt16)                              ;          
)

;type name? (%define-record :ResourceSpec (find-record-descriptor ':ResourceSpec))
(defrecord (ComponentResource :handle)
   (cd :ComponentDescription)                   ;  Registration parameters 
   (component :ResourceSpec)                    ;  resource where Component code is found 
   (componentName :ResourceSpec)                ;  name string resource 
   (componentInfo :ResourceSpec)                ;  info string resource 
   (componentIcon :ResourceSpec)                ;  icon resource 
)

;type name? (%define-record :ComponentResource (find-record-descriptor ':ComponentResource))

(def-mactype :ComponentResourcePtr (find-mactype '(:pointer :ComponentResource)))

(def-mactype :ComponentResourceHandle (find-mactype '(:handle :ComponentResource)))
(defrecord ComponentPlatformInfo
   (componentFlags :signed-long)                ;  flags of Component 
   (component :ResourceSpec)                    ;  resource where Component code is found 
   (platformType :SInt16)                       ;  gestaltSysArchitecture result 
)

;type name? (%define-record :ComponentPlatformInfo (find-record-descriptor ':ComponentPlatformInfo))
(defrecord ComponentResourceExtension
   (componentVersion :signed-long)              ;  version of Component 
   (componentRegisterFlags :signed-long)        ;  flags for registration 
   (componentIconFamily :SInt16)                ;  resource id of Icon Family 
)

;type name? (%define-record :ComponentResourceExtension (find-record-descriptor ':ComponentResourceExtension))
(defrecord ComponentPlatformInfoArray
   (count :signed-long)
   (platformArray (:array :ComponentPlatformInfo 1))
)

;type name? (%define-record :ComponentPlatformInfoArray (find-record-descriptor ':ComponentPlatformInfoArray))
(defrecord ExtComponentResource
   (cd :ComponentDescription)                   ;  registration parameters 
   (component :ResourceSpec)                    ;  resource where Component code is found 
   (componentName :ResourceSpec)                ;  name string resource 
   (componentInfo :ResourceSpec)                ;  info string resource 
   (componentIcon :ResourceSpec)                ;  icon resource 
   (componentVersion :signed-long)              ;  version of Component 
   (componentRegisterFlags :signed-long)        ;  flags for registration 
   (componentIconFamily :SInt16)                ;  resource id of Icon Family 
   (count :signed-long)                         ;  elements in platformArray 
   (platformArray (:array :ComponentPlatformInfo 1))
)

;type name? (%define-record :ExtComponentResource (find-record-descriptor ':ExtComponentResource))

(def-mactype :ExtComponentResourcePtr (find-mactype '(:pointer :ExtComponentResource)))

(def-mactype :ExtComponentResourceHandle (find-mactype '(:handle :ExtComponentResource)))
(defrecord ComponentAliasResource
   (cr :ComponentResource)                      ;  Registration parameters 
   (aliasCD :ComponentDescription)              ;  component alias description 
)

;type name? (%define-record :ComponentAliasResource (find-record-descriptor ':ComponentAliasResource))
;   Structure received by Component:        
(defrecord ComponentParameters
   (flags :UInt8)                               ;  call modifiers: sync/async, deferred, immed, etc 
   (paramSize :UInt8)                           ;  size in bytes of actual parameters passed to this call 
   (what :SInt16)                               ;  routine selector, negative for Component management calls 
   (params (:array :signed-long 1))             ;  actual parameters for the indicated routine 
)

;type name? (%define-record :ComponentParameters (find-record-descriptor ':ComponentParameters))
(defrecord ComponentRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :ComponentRecord (find-record-descriptor ':ComponentRecord))

(def-mactype :Component (find-mactype '(:pointer :ComponentRecord)))
(defrecord ComponentInstanceRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :ComponentInstanceRecord (find-record-descriptor ':ComponentInstanceRecord))

(def-mactype :ComponentInstance (find-mactype '(:pointer :ComponentInstanceRecord)))
(defrecord RegisteredComponentRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :RegisteredComponentRecord (find-record-descriptor ':RegisteredComponentRecord))

(def-mactype :RegisteredComponentRecordPtr (find-mactype '(:pointer :RegisteredComponentRecord)))
(defrecord RegisteredComponentInstanceRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :RegisteredComponentInstanceRecord (find-record-descriptor ':RegisteredComponentInstanceRecord))

(def-mactype :RegisteredComponentInstanceRecordPtr (find-mactype '(:pointer :RegisteredComponentInstanceRecord)))

(def-mactype :ComponentResult (find-mactype ':signed-long))

(defconstant $platform68k 1)                    ;  platform type (response from gestaltComponentPlatform) 

(defconstant $platformPowerPC 2)                ;  (when gestaltComponentPlatform is not implemented, use 

(defconstant $platformInterpreted 3)            ;  gestaltSysArchitecture) 

(defconstant $platformWin32 4)
(defconstant $platformPowerPCNativeEntryPoint 5)
(defconstant $platformIA32NativeEntryPoint 6)

(defconstant $platformIRIXmips #x3E8)
(defconstant $platformSunOSsparc #x44C)
(defconstant $platformSunOSintel #x44D)
(defconstant $platformLinuxppc #x4B0)
(defconstant $platformLinuxintel #x4B1)
(defconstant $platformAIXppc #x514)
(defconstant $platformNeXTIntel #x578)
(defconstant $platformNeXTppc #x579)
(defconstant $platformNeXTsparc #x57A)
(defconstant $platformNeXT68k #x57B)
(defconstant $platformMacOSx86 #x5DC)

(defconstant $mpWorkFlagDoWork 1)
(defconstant $mpWorkFlagDoCompletion 2)
(defconstant $mpWorkFlagCopyWorkBlock 4)
(defconstant $mpWorkFlagDontBlock 8)
(defconstant $mpWorkFlagGetProcessorCount 16)
(defconstant $mpWorkFlagGetIsRunning 64)

(defconstant $cmpAliasNoFlags 0)
(defconstant $cmpAliasOnlyThisFile 1)

(def-mactype :CSComponentsThreadMode (find-mactype ':UInt32))

(defconstant $kCSAcceptAllComponentsMode 0)
(defconstant $kCSAcceptThreadSafeComponentsOnlyMode 1)
; 
;  *  CSSetComponentsThreadMode()
;  *  
;  *  Summary:
;  *    Set whether or not using thread-unsafe components is allowed on
;  *    the current thread.
;  *  
;  *  Discussion:
;  *    When set to kCSAcceptThreadSafeComponentsOnlyMode, the current
;  *    thread can only make thread-safe calls. Applications and other
;  *    high-level code that wants to call QuickTime (and other) APIs
;  *    from preemptive threads should call  SetComponentsThreadMode(
;  *    kCSAcceptThreadSafeComponentsOnlyMode );  from their thread
;  *    beforehand. The safeguard flag should only be left
;  *    kCSAcceptAllComponentsMode for the main thread and other threads
;  *    that participate in cooperative locking with it (such as the
;  *    Carbon Thread Manager-style cooperative threads and application 
;  *    threads that perform private locking).
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Parameters:
;  *    
;  *    mode:
;  *      The thread-safety mode in current thread.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CSSetComponentsThreadMode" 
   ((mode :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  *  CSGetComponentsThreadMode()
;  *  
;  *  Summary:
;  *    Get the current thread's thread-safety mode.
;  *  
;  *  Discussion:
;  *    Returns kCSAcceptThreadSafeComponentsOnlyMode if only thread-safe
;  *    components are allowed in current thread and
;  *    kCSAcceptAllComponentsMode if all components are accepted
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.3
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CSGetComponentsThreadMode" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
(defrecord ComponentMPWorkFunctionHeaderRecord
   (headerSize :UInt32)
   (recordSize :UInt32)
   (workFlags :UInt32)
   (processorCount :UInt16)
   (unused :UInt8)
   (isRunning :UInt8)
)

;type name? (%define-record :ComponentMPWorkFunctionHeaderRecord (find-record-descriptor ':ComponentMPWorkFunctionHeaderRecord))

(def-mactype :ComponentMPWorkFunctionHeaderRecordPtr (find-mactype '(:pointer :ComponentMPWorkFunctionHeaderRecord)))

(def-mactype :ComponentMPWorkFunctionProcPtr (find-mactype ':pointer)); (void * globalRefCon , ComponentMPWorkFunctionHeaderRecordPtr header)

(def-mactype :ComponentRoutineProcPtr (find-mactype ':pointer)); (ComponentParameters * cp , Handle componentStorage)

(def-mactype :GetMissingComponentResourceProcPtr (find-mactype ':pointer)); (Component c , OSType resType , short resID , void * refCon , Handle * resource)

(def-mactype :ComponentMPWorkFunctionUPP (find-mactype '(:pointer :OpaqueComponentMPWorkFunctionProcPtr)))

(def-mactype :ComponentRoutineUPP (find-mactype '(:pointer :OpaqueComponentRoutineProcPtr)))

(def-mactype :GetMissingComponentResourceUPP (find-mactype '(:pointer :OpaqueGetMissingComponentResourceProcPtr)))
; 
;     The parameter list for each ComponentFunction is unique. It is
;     therefore up to users to create the appropriate procInfo for their
;     own ComponentFunctions where necessary.
; 

(def-mactype :ComponentFunctionUPP (find-mactype ':UniversalProcPtr))
; 
;  *  NewComponentFunctionUPP()
;  *  
;  *  Discussion:
;  *    For use in writing a Carbon compliant Component.  It is used to
;  *    create a ComponentFunctionUPP needed to call
;  *    CallComponentFunction in the Components dispatch routine.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewComponentFunctionUPP" 
   ((userRoutine :pointer)
    (procInfo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :RoutineDescriptor)
() )
; 
;  *  DisposeComponentFunctionUPP()
;  *  
;  *  Discussion:
;  *    For use in writing a Carbon compliant Component.  It is used to
;  *    dispose of a ComponentFunctionUPP created by
;  *    NewComponentFunctionUPP.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeComponentFunctionUPP" 
   ((userUPP (:pointer :RoutineDescriptor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #if TARGET_RT_MAC_CFM
;  
;     CallComponentUPP is a global variable exported from InterfaceLib.
;     It is the ProcPtr passed to CallUniversalProc to manually call a component function.
; 
; 
;  *  CallComponentUPP
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
(def-mactype :CallComponentUPP (find-mactype ':UniversalProcPtr))

; #endif

; #define ComponentCallNow( callNumber, paramSize )     FIVEWORDINLINE( 0x2F3C,paramSize,callNumber,0x7000,0xA82A )
; *******************************************************
; *                                                       *
; *               APPLICATION LEVEL CALLS                 *
; *                                                       *
; *******************************************************
; *******************************************************
; * Component Database Add, Delete, and Query Routines
; *******************************************************
; 
;  *  RegisterComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RegisterComponent" 
   ((cd (:pointer :ComponentDescription))
    (componentEntryPoint (:pointer :OpaqueComponentRoutineProcPtr))
    (global :SInt16)
    (componentName :Handle)
    (componentInfo :Handle)
    (componentIcon :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentRecord)
() )
; 
;  *  RegisterComponentResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RegisterComponentResource" 
   ((cr (:Handle :ComponentResource))
    (global :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentRecord)
() )
; 
;  *  UnregisterComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_UnregisterComponent" 
   ((aComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FindNextComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_FindNextComponent" 
   ((aComponent (:pointer :ComponentRecord))
    (looking (:pointer :ComponentDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentRecord)
() )
; 
;  *  CountComponents()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CountComponents" 
   ((looking (:pointer :ComponentDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetComponentInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentInfo" 
   ((aComponent (:pointer :ComponentRecord))
    (cd (:pointer :ComponentDescription))
    (componentName :Handle)
    (componentInfo :Handle)
    (componentIcon :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetComponentListModSeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentListModSeed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetComponentTypeModSeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentTypeModSeed" 
   ((componentType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; *******************************************************
; * Component Instance Allocation and dispatch routines
; *******************************************************
; 
;  *  OpenAComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_OpenAComponent" 
   ((aComponent (:pointer :ComponentRecord))
    (ci (:pointer :COMPONENTINSTANCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  OpenComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_OpenComponent" 
   ((aComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentInstanceRecord)
() )
; 
;  *  CloseComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CloseComponent" 
   ((aComponentInstance (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetComponentInstanceError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentInstanceError" 
   ((aComponentInstance (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *******************************************************
; * Component aliases
; *******************************************************
; 
;  *  ResolveComponentAlias()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ResolveComponentAlias" 
   ((aComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentRecord)
() )
; *******************************************************
; * Component public resources and public string lists
; *******************************************************
;  Note: GetComponentPublicResource returns a Handle, not a resource.  The caller must dispose it with DisposeHandle. 
; 
;  *  GetComponentPublicResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 4.0 and later
;  

(deftrap-inline "_GetComponentPublicResource" 
   ((aComponent (:pointer :ComponentRecord))
    (resourceType :OSType)
    (resourceID :SInt16)
    (theResource (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetComponentPublicResourceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 4.0 and later
;  

(deftrap-inline "_GetComponentPublicResourceList" 
   ((resourceType :OSType)
    (resourceID :SInt16)
    (flags :signed-long)
    (cd (:pointer :ComponentDescription))
    (missingProc (:pointer :OpaqueGetMissingComponentResourceProcPtr))
    (refCon :pointer)
    (atomContainerPtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetComponentPublicIndString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 4.0 and later
;  

(deftrap-inline "_GetComponentPublicIndString" 
   ((aComponent (:pointer :ComponentRecord))
    (theString (:pointer :STR255))
    (strListID :SInt16)
    (index :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *******************************************************
; *                                                       *
; *                   CALLS MADE BY COMPONENTS            *
; *                                                       *
; *******************************************************
; *******************************************************
; * Component Management routines
; *******************************************************
; 
;  *  SetComponentInstanceError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetComponentInstanceError" 
   ((aComponentInstance (:pointer :ComponentInstanceRecord))
    (theError :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetComponentRefcon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentRefcon" 
   ((aComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetComponentRefcon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetComponentRefcon" 
   ((aComponent (:pointer :ComponentRecord))
    (theRefcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OpenComponentResFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_OpenComponentResFile" 
   ((aComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  OpenAComponentResFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_OpenAComponentResFile" 
   ((aComponent (:pointer :ComponentRecord))
    (resRef (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CloseComponentResFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CloseComponentResFile" 
   ((refnum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Note: GetComponentResource returns a Handle, not a resource.  The caller must dispose it with DisposeHandle. 
; 
;  *  GetComponentResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentResource" 
   ((aComponent (:pointer :ComponentRecord))
    (resType :OSType)
    (resID :SInt16)
    (theResource (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetComponentIndString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentIndString" 
   ((aComponent (:pointer :ComponentRecord))
    (theString (:pointer :STR255))
    (strListID :SInt16)
    (index :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *******************************************************
; * Component Instance Management routines
; *******************************************************
; 
;  *  GetComponentInstanceStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentInstanceStorage" 
   ((aComponentInstance (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  SetComponentInstanceStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetComponentInstanceStorage" 
   ((aComponentInstance (:pointer :ComponentInstanceRecord))
    (theStorage :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetComponentInstanceA5()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  SetComponentInstanceA5()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  CountComponentInstances()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CountComponentInstances" 
   ((aComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
;  useful helper routines for convenient method dispatching 
; 
;  *  CallComponentFunction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CallComponentFunction" 
   ((params (:pointer :ComponentParameters))
    (func (:pointer :RoutineDescriptor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  CallComponentFunctionWithStorage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentFunctionWithStorage" 
   ((storage :Handle)
    (params (:pointer :ComponentParameters))
    (func (:pointer :RoutineDescriptor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  CallComponentFunctionWithStorageProcInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  

(deftrap-inline "_CallComponentFunctionWithStorageProcInfo" 
   ((storage :Handle)
    (params (:pointer :ComponentParameters))
    (func :pointer)
    (funcProcInfo :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  DelegateComponentCall()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DelegateComponentCall" 
   ((originalParams (:pointer :ComponentParameters))
    (ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetDefaultComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SetDefaultComponent" 
   ((aComponent (:pointer :ComponentRecord))
    (flags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  OpenDefaultComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_OpenDefaultComponent" 
   ((componentType :OSType)
    (componentSubType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentInstanceRecord)
() )
; 
;  *  OpenADefaultComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_OpenADefaultComponent" 
   ((componentType :OSType)
    (componentSubType :OSType)
    (ci (:pointer :COMPONENTINSTANCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CaptureComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CaptureComponent" 
   ((capturedComponent (:pointer :ComponentRecord))
    (capturingComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentRecord)
() )
; 
;  *  UncaptureComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_UncaptureComponent" 
   ((aComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RegisterComponentResourceFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_RegisterComponentResourceFile" 
   ((resRefNum :SInt16)
    (global :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetComponentIconSuite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentIconSuite" 
   ((aComponent (:pointer :ComponentRecord))
    (iconSuite (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  * These calls allow you to register a file system entity.  The
;  * Component Manager will "do the right thing" with the entity,
;  * whether it is a standard resource fork based CFM component, CFM
;  * bundle, mach-o bundle, or packaged bundle.  
;  *
;  * The *Entries calls allow you to specify a component description
;  * which will be used to register selective components.  (Passing
;  * NULL, 0 means to register all components.  
;  
; 
;  *  RegisterComponentFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RegisterComponentFile" 
   ((spec (:pointer :FSSpec))
    (global :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RegisterComponentFileEntries()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RegisterComponentFileEntries" 
   ((spec (:pointer :FSSpec))
    (global :SInt16)
    (toRegister (:pointer :ComponentDescription));  can be NULL 
    (registerCount :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RegisterComponentFileRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RegisterComponentFileRef" 
   ((ref (:pointer :FSRef))
    (global :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RegisterComponentFileRefEntries()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RegisterComponentFileRefEntries" 
   ((ref (:pointer :FSRef))
    (global :SInt16)
    (toRegister (:pointer :ComponentDescription));  can be NULL 
    (registerCount :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *******************************************************
; *                                                       *
; *           Direct calls to the Components              *
; *                                                       *
; *******************************************************
;  Old style names
; 
;  *  ComponentFunctionImplemented()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ComponentFunctionImplemented" 
   ((ci (:pointer :ComponentInstanceRecord))
    (ftnNumber :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetComponentVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GetComponentVersion" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  ComponentSetTarget()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ComponentSetTarget" 
   ((ci (:pointer :ComponentInstanceRecord))
    (target (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
;  New style names
; 
;  *  CallComponentOpen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentOpen" 
   ((ci (:pointer :ComponentInstanceRecord))
    (self (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CallComponentClose()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentClose" 
   ((ci (:pointer :ComponentInstanceRecord))
    (self (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CallComponentCanDo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentCanDo" 
   ((ci (:pointer :ComponentInstanceRecord))
    (ftnNumber :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CallComponentVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentVersion" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CallComponentRegister()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentRegister" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CallComponentTarget()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentTarget" 
   ((ci (:pointer :ComponentInstanceRecord))
    (target (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CallComponentUnregister()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentUnregister" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CallComponentGetMPWorkFunction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CallComponentGetMPWorkFunction" 
   ((ci (:pointer :ComponentInstanceRecord))
    (workFunction (:pointer :COMPONENTMPWORKFUNCTIONUPP))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CallComponentGetPublicResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in InterfaceLib via QuickTime 4.0 and later
;  

(deftrap-inline "_CallComponentGetPublicResource" 
   ((ci (:pointer :ComponentInstanceRecord))
    (resourceType :OSType)
    (resourceID :SInt16)
    (resource (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     CallComponentDispatch is a CarbonLib routine that replaces CallComponent inline glue
;     to call a component function.
;  
; 
;  *  CallComponentDispatch()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CallComponentDispatch" 
   ((cp (:pointer :ComponentParameters))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  UPP call backs 
; 
;  *  NewComponentMPWorkFunctionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewComponentMPWorkFunctionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueComponentMPWorkFunctionProcPtr)
() )
; 
;  *  NewComponentRoutineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewComponentRoutineUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueComponentRoutineProcPtr)
() )
; 
;  *  NewGetMissingComponentResourceUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewGetMissingComponentResourceUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueGetMissingComponentResourceProcPtr)
() )
; 
;  *  DisposeComponentMPWorkFunctionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeComponentMPWorkFunctionUPP" 
   ((userUPP (:pointer :OpaqueComponentMPWorkFunctionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeComponentRoutineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeComponentRoutineUPP" 
   ((userUPP (:pointer :OpaqueComponentRoutineProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeGetMissingComponentResourceUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeGetMissingComponentResourceUPP" 
   ((userUPP (:pointer :OpaqueGetMissingComponentResourceProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeComponentMPWorkFunctionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeComponentMPWorkFunctionUPP" 
   ((globalRefCon :pointer)
    (header (:pointer :ComponentMPWorkFunctionHeaderRecord))
    (userUPP (:pointer :OpaqueComponentMPWorkFunctionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeComponentRoutineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeComponentRoutineUPP" 
   ((cp (:pointer :ComponentParameters))
    (componentStorage :Handle)
    (userUPP (:pointer :OpaqueComponentRoutineProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeGetMissingComponentResourceUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeGetMissingComponentResourceUPP" 
   ((c (:pointer :ComponentRecord))
    (resType :OSType)
    (resID :SInt16)
    (refCon :pointer)
    (resource (:pointer :Handle))
    (userUPP (:pointer :OpaqueGetMissingComponentResourceProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  ProcInfos 
;  MixedMode ProcInfo constants for component calls 

(defconstant $uppComponentFunctionImplementedProcInfo #x2F0)
(defconstant $uppGetComponentVersionProcInfo #xF0)
(defconstant $uppComponentSetTargetProcInfo #x3F0)
(defconstant $uppCallComponentOpenProcInfo #x3F0)
(defconstant $uppCallComponentCloseProcInfo #x3F0)
(defconstant $uppCallComponentCanDoProcInfo #x2F0)
(defconstant $uppCallComponentVersionProcInfo #xF0)
(defconstant $uppCallComponentRegisterProcInfo #xF0)
(defconstant $uppCallComponentTargetProcInfo #x3F0)
(defconstant $uppCallComponentUnregisterProcInfo #xF0)
(defconstant $uppCallComponentGetMPWorkFunctionProcInfo #xFF0)
(defconstant $uppCallComponentGetPublicResourceProcInfo #x3BF0)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __COMPONENTS__ */


(provide-interface "Components")