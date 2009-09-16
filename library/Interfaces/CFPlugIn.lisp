(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFPlugIn.h"
; at Sunday July 2,2006 7:23:01 pm.
; 	CFPlugIn.h
; 	Copyright (c) 1999-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFPLUGIN__)
(defconstant $__COREFOUNDATION_CFPLUGIN__ 1)
; #define __COREFOUNDATION_CFPLUGIN__ 1

; #if !defined(COREFOUNDATION_CFPLUGINCOM_SEPARATE)
(defconstant $COREFOUNDATION_CFPLUGINCOM_SEPARATE 1)
; #define COREFOUNDATION_CFPLUGINCOM_SEPARATE 1

; #endif


(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFBundle")

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFURL")

(require-interface "CoreFoundation/CFUUID")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
;  ================ Standard Info.plist keys for plugIns ================ 
(def-mactype :kCFPlugInDynamicRegistrationKey (find-mactype ':CFStringRef))
(def-mactype :kCFPlugInDynamicRegisterFunctionKey (find-mactype ':CFStringRef))
(def-mactype :kCFPlugInUnloadFunctionKey (find-mactype ':CFStringRef))
(def-mactype :kCFPlugInFactoriesKey (find-mactype ':CFStringRef))
(def-mactype :kCFPlugInTypesKey (find-mactype ':CFStringRef))
;  ================= Function prototypes for various callbacks ================= 
;  Function types that plugIn authors can implement for various purposes. 

(def-mactype :CFPlugInDynamicRegisterFunction (find-mactype ':pointer)); (CFPlugInRef plugIn)

(def-mactype :CFPlugInUnloadFunction (find-mactype ':pointer)); (CFPlugInRef plugIn)

(def-mactype :CFPlugInFactoryFunction (find-mactype ':pointer)); (CFAllocatorRef allocator , CFUUIDRef typeUUID)
;  ================= Creating PlugIns ================= 

(deftrap-inline "_CFPlugInGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFPlugInCreate" 
   ((allocator (:pointer :__CFAllocator))
    (plugInURL (:pointer :__CFURL))
   )
   (:pointer :__CFBundle)
() )
;  Might return an existing instance with the ref-count bumped. 

(deftrap-inline "_CFPlugInGetBundle" 
   ((plugIn (:pointer :__CFBundle))
   )
   (:pointer :__CFBundle)
() )
;  ================= Controlling load on demand ================= 
;  For plugIns. 
;  PlugIns that do static registration are load on demand by default. 
;  PlugIns that do dynamic registration are not load on demand by default. 
;  A dynamic registration function can call CFPlugInSetLoadOnDemand(). 

(deftrap-inline "_CFPlugInSetLoadOnDemand" 
   ((plugIn (:pointer :__CFBundle))
    (flag :Boolean)
   )
   nil
() )

(deftrap-inline "_CFPlugInIsLoadOnDemand" 
   ((plugIn (:pointer :__CFBundle))
   )
   :Boolean
() )
;  ================= Finding factories and creating instances ================= 
;  For plugIn hosts. 
;  Functions for finding factories to create specific types and actually creating instances of a type. 

(deftrap-inline "_CFPlugInFindFactoriesForPlugInType" 
   ((typeUUID (:pointer :__CFUUID))
   )
   (:pointer :__CFArray)
() )
;  This function finds all the factories from any plugin for the given type.  Returns an array that the caller must release. 

(deftrap-inline "_CFPlugInFindFactoriesForPlugInTypeInPlugIn" 
   ((typeUUID (:pointer :__CFUUID))
    (plugIn (:pointer :__CFBundle))
   )
   (:pointer :__CFArray)
() )
;  This function restricts the result to factories from the given plug-in that can create the given type.  Returns an array that the caller must release. 

(deftrap-inline "_CFPlugInInstanceCreate" 
   ((allocator (:pointer :__CFAllocator))
    (factoryUUID (:pointer :__CFUUID))
    (typeUUID (:pointer :__CFUUID))
   )
   (:pointer :void)
() )
;  This function returns the IUnknown interface for the new instance. 
;  ================= Registering factories and types ================= 
;  For plugIn writers who must dynamically register things. 
;  Functions to register factory functions and to associate factories with types. 

(deftrap-inline "_CFPlugInRegisterFactoryFunction" 
   ((factoryUUID (:pointer :__CFUUID))
    (func :pointer)
   )
   :Boolean
() )

(deftrap-inline "_CFPlugInRegisterFactoryFunctionByName" 
   ((factoryUUID (:pointer :__CFUUID))
    (plugIn (:pointer :__CFBundle))
    (functionName (:pointer :__CFString))
   )
   :Boolean
() )

(deftrap-inline "_CFPlugInUnregisterFactory" 
   ((factoryUUID (:pointer :__CFUUID))
   )
   :Boolean
() )

(deftrap-inline "_CFPlugInRegisterPlugInType" 
   ((factoryUUID (:pointer :__CFUUID))
    (typeUUID (:pointer :__CFUUID))
   )
   :Boolean
() )

(deftrap-inline "_CFPlugInUnregisterPlugInType" 
   ((factoryUUID (:pointer :__CFUUID))
    (typeUUID (:pointer :__CFUUID))
   )
   :Boolean
() )
;  ================= Registering instances ================= 
;  When a new instance of a type is created, the instance is responsible for registering itself with the factory that created it and unregistering when it deallocates. 
;  This means that an instance must keep track of the CFUUIDRef of the factory that created it so it can unregister when it goes away. 

(deftrap-inline "_CFPlugInAddInstanceForFactory" 
   ((factoryID (:pointer :__CFUUID))
   )
   nil
() )

(deftrap-inline "_CFPlugInRemoveInstanceForFactory" 
   ((factoryID (:pointer :__CFUUID))
   )
   nil
() )
;  Obsolete API 

(def-mactype :CFPlugInInstanceRef (find-mactype '(:pointer :__CFPlugInInstance)))

(def-mactype :CFPlugInInstanceGetInterfaceFunction (find-mactype ':pointer)); (CFPlugInInstanceRef instance , CFStringRef interfaceName , void ** ftbl)

(def-mactype :CFPlugInInstanceDeallocateInstanceDataFunction (find-mactype ':pointer)); (void * instanceData)

(deftrap-inline "_CFPlugInInstanceGetInterfaceFunctionTable" 
   ((instance (:pointer :__CFPlugInInstance))
    (interfaceName (:pointer :__CFString))
    (ftbl :pointer)
   )
   :Boolean
() )

(deftrap-inline "_CFPlugInInstanceGetFactoryName" 
   ((instance (:pointer :__CFPlugInInstance))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFPlugInInstanceGetInstanceData" 
   ((instance (:pointer :__CFPlugInInstance))
   )
   (:pointer :void)
() )

(deftrap-inline "_CFPlugInInstanceGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFPlugInInstanceCreateWithInstanceDataSize" 
   ((allocator (:pointer :__CFAllocator))
    (instanceDataSize :SInt32)
    (deallocateInstanceFunction :pointer)
    (factoryName (:pointer :__CFString))
    (getInterfaceFunction :pointer)
   )
   (:pointer :__CFPlugInInstance)
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #if !COREFOUNDATION_CFPLUGINCOM_SEPARATE
#| |#

(require-interface "CoreFoundation/CFPlugInCOM")

#|
 |#

; #endif


; #endif /* ! __COREFOUNDATION_CFPLUGIN__ */


(provide-interface "CFPlugIn")