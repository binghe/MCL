(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QTML.h"
; at Sunday July 2,2006 7:31:20 pm.
; 
;      File:       QuickTime/QTML.h
;  
;      Contains:   QuickTime Cross-platform specific interfaces
;  
;      Version:    QuickTime_6
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QTML__
; #define __QTML__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
#endif
|#
 |#
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
; 
;  *  QTMLYieldCPU()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 3.0 and later
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMLYieldCPU" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  QTMLYieldCPUTime flags
;  ask for event handling during the yield

(defconstant $kQTMLHandlePortEvents 1)
; 
;  *  QTMLYieldCPUTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 3.0 and later
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMLYieldCPUTime" 
   ((milliSeconds :signed-long)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

(def-mactype :QTMLMutex (find-mactype '(:pointer :OpaqueQTMLMutex)))

(def-mactype :QTMLSyncVar (find-mactype '(:pointer :OpaqueQTMLSyncVar)))

(def-mactype :QTMLSyncVarPtr (find-mactype '(:handle :OpaqueQTMLSyncVar)))
;  InitializeQTML flags

(defconstant $kInitializeQTMLNoSoundFlag 1)     ;  flag for requesting no sound when calling InitializeQTML

(defconstant $kInitializeQTMLUseGDIFlag 2)      ;  flag for requesting GDI when calling InitializeQTML

(defconstant $kInitializeQTMLDisableDirectSound 4);  disables QTML's use of DirectSound

(defconstant $kInitializeQTMLUseExclusiveFullScreenModeFlag 8);  later than QTML 3.0: qtml starts up in exclusive full screen mode
;  flag for requesting QTML not to use DirectDraw clipper objects; QTML 5.0 and later

(defconstant $kInitializeQTMLDisableDDClippers 16)
; 
;  *  InitializeQTML()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  TerminateQTML()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
;  CreatePortAssociation flags
;  ask for a non-auto-idled port to be created

(defconstant $kQTMLNoIdleEvents 2)
; 
;  *  CreatePortAssociation()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  DestroyPortAssociation()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLGrabMutex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 3.0 and later
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMLGrabMutex" 
   ((mu (:pointer :OpaqueQTMLMutex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QTMLTryGrabMutex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 4.1 and later
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_QTMLTryGrabMutex" 
   ((mu (:pointer :OpaqueQTMLMutex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QTMLReturnMutex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 3.0 and later
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMLReturnMutex" 
   ((mu (:pointer :OpaqueQTMLMutex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QTMLCreateMutex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 3.0 and later
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMLCreateMutex" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTMLMutex)
() )
; 
;  *  QTMLDestroyMutex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 3.0 and later
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTMLDestroyMutex" 
   ((mu (:pointer :OpaqueQTMLMutex))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QTMLCreateSyncVar()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLDestroySyncVar()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLTestAndSetSyncVar()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLWaitAndSetSyncVar()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLResetSyncVar()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  InitializeQHdr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  TerminateQHdr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLAcquireWindowList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLReleaseWindowList()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;    These routines are here to support "interrupt level" code
;       These are dangerous routines, only use if you know what you are doing.
; 
; 
;  *  QTMLRegisterInterruptSafeThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLUnregisterInterruptSafeThread()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  NativeEventToMacEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

; #if TARGET_OS_WIN32
#| 
; 
;  *  WinEventToMacEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; #define WinEventToMacEvent  NativeEventToMacEvent
; 
;  *  IsTaskBarVisible()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  ShowHideTaskBar()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(defconstant $kDDSurfaceLocked 1)
(defconstant $kDDSurfaceStatic 2)
; 
;  *  QTGetDDObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTSetDDObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTSetDDPrimarySurface()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLGetVolumeRootPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLSetWindowWndProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTMLGetWindowWndProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
 |#

; #endif  /* TARGET_OS_WIN32 */

; 
;  *  QTMLGetCanonicalPathName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(defconstant $kFullNativePath 0)
(defconstant $kFileNameOnly 1)
(defconstant $kDirectoryPathOnly 2)
(defconstant $kUFSFullPathName 4)
(defconstant $kTryVDIMask 8)                    ;     Used in NativePathNameToFSSpec to specify to search VDI mountpoints
;     the passed in name is a fully qualified full path

(defconstant $kFullPathSpecifiedMask 16)
; 
;  *  FSSpecToNativePathName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(defconstant $kErrorIfFileNotFound #x80000000)
; 
;  *  NativePathNameToFSSpec()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  
; 
;  *  QTGetAliasInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QTML__ */


(provide-interface "QTML")