(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:afpClient.h"
; at Sunday July 2,2006 7:25:31 pm.
; 
; 	File:		afpClient.h
; 
; 	Contains:	Shared library interface to the AppleShare Client
; 
; 	Version:	AppleShare X
; 
; 	Copyright:	© 2000 by Apple Computer, Inc., all rights reserved.
; 
; 	Change History (most recent first):
; 
; 	 <RASC3>	 3/14/00	law		Add support for VolumePasswords and better support for the
; 									HLMount routines
; 	 <RASC2>	 2/25/00	law		Working on the public interface
; 		 <1>	  2/3/00	law		first checked in
; 
; #ifndef __AFPCLIENT__
; #define __AFPCLIENT__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
#endif
|#
 |#

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

;  used to be __cplusplus	

; #if __GNUG__		
#| 
; Gag EXTERN "C"  {
 |#

; #endif


; #if PRAGMA_IMPORT
#| ; #pragma import on
 |#

; #endif


; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=mac68k
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(push, 2)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack(2)
 |#

; #endif

;  Data Types 

(def-mactype :AFPSharedVolumesEnumeratorRef (find-mactype ':UInt32))

(def-mactype :ATEventCode (find-mactype ':UInt32))

(def-mactype :ATPortRef (find-mactype ':UInt32))

(def-mactype :OneBasedIndex (find-mactype ':UInt32))
;  error codes	

(defconstant $kNavigationAPIErrorBase 1)
(defconstant $kATEnumeratorBadIndexErr 1)
(defconstant $kATEnumeratorBadReferenceErr 2)
(defconstant $kATEnumeratorBadZoneErr 3)
(defconstant $kATEnumeratorBadPortErr 4)
(defconstant $kATAppleShareNotAvailableErr 5)
(defconstant $kATServerNotFoundErr 6)
(defconstant $kLastErrorCodeIndex 7)
(defconstant $kLastAndMeaningLessItemInEnum 8)

(def-mactype :AddressPtr (find-mactype '(:pointer :sockaddr)))
;  notifier events for ATNotifyProc	
;  Returned by the AppleShare volumes emnumerator

(defconstant $AT_SHAREDVOLUMES_COMPLETE :|vols|)
; ---------------------------------------------------------------------------
; 	Finding out if the library is present and getting its version			 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPLibraryVersion" 
   (
   )
   :UInt32
() )

(deftrap-inline "_AFPLibraryPresent" 
   (
   )
   :Boolean
() )
; #ifdef __cplusplus														
#| #|
inline	Boolean AFPLibraryPresent()										
{																		
	return AFPLibraryVersion != (void*)kUnresolvedCFragSymbolAddress;	
}																		
#endif
|#
 |#
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; 	AFP URL Support	had moved to "AppleShareClientCore/afpURL.h"														 
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; 	Enumerating shared volumes on AppleShare file servers					 
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; 	Event callback for the login dialogs									 
; ---------------------------------------------------------------------------

(def-mactype :AShareEventProcPtr (find-mactype ':pointer)); (EventRecord * theEvent , void * contextPtr)

(def-mactype :ATNotifyProcPtr (find-mactype ':pointer)); (void * contextPtr , ATEventCode code , OSStatus result , void * cookie)

(def-mactype :ATFilterProcPtr (find-mactype ':pointer)); (StringPtr name , void * data)

(def-mactype :ATNetworkEventNotifierProcPtr (find-mactype ':pointer)); (UInt32 eventCode , void * cookie)

(def-mactype :AShareEventUPP (find-mactype '(:pointer :OpaqueAShareEventProcPtr)))

(def-mactype :ATNotifyUPP (find-mactype '(:pointer :OpaqueATNotifyProcPtr)))

(def-mactype :ATFilterUPP (find-mactype '(:pointer :OpaqueATFilterProcPtr)))

(def-mactype :ATNetworkEventNotifierUPP (find-mactype '(:pointer :OpaqueATNetworkEventNotifierProcPtr)))

; #if OPAQUE_UPP_TYPES

(deftrap-inline "_NewAShareEventUPP" 
   ((userRoutine :pointer)
   )
   (:pointer :OpaqueAShareEventProcPtr)
() )

(deftrap-inline "_NewATNotifyUPP" 
   ((userRoutine :pointer)
   )
   (:pointer :OpaqueATNotifyProcPtr)
() )

(deftrap-inline "_NewATFilterUPP" 
   ((userRoutine :pointer)
   )
   (:pointer :OpaqueATFilterProcPtr)
() )

(deftrap-inline "_NewATNetworkEventNotifierUPP" 
   ((userRoutine :pointer)
   )
   (:pointer :OpaqueATNetworkEventNotifierProcPtr)
() )

(deftrap-inline "_DisposeAShareEventUPP" 
   ((userUPP (:pointer :OpaqueAShareEventProcPtr))
   )
   nil
() )

(deftrap-inline "_DisposeATNotifyUPP" 
   ((userUPP (:pointer :OpaqueATNotifyProcPtr))
   )
   nil
() )

(deftrap-inline "_DisposeATFilterUPP" 
   ((userUPP (:pointer :OpaqueATFilterProcPtr))
   )
   nil
() )

(deftrap-inline "_DisposeATNetworkEventNotifierUPP" 
   ((userUPP (:pointer :OpaqueATNetworkEventNotifierProcPtr))
   )
   nil
() )

(deftrap-inline "_InvokeAShareEventUPP" 
   ((theEvent (:pointer :EventRecord))
    (contextPtr :pointer)
    (userUPP (:pointer :OpaqueAShareEventProcPtr))
   )
   nil
() )

(deftrap-inline "_InvokeATNotifyUPP" 
   ((contextPtr :pointer)
    (code :UInt32)
    (result :SInt32)
    (cookie :pointer)
    (userUPP (:pointer :OpaqueATNotifyProcPtr))
   )
   nil
() )

(deftrap-inline "_InvokeATFilterUPP" 
   ((name (:pointer :UInt8))
    (data :pointer)
    (userUPP (:pointer :OpaqueATFilterProcPtr))
   )
   :Boolean
() )

(deftrap-inline "_InvokeATNetworkEventNotifierUPP" 
   ((eventCode :UInt32)
    (cookie :pointer)
    (userUPP (:pointer :OpaqueATNetworkEventNotifierProcPtr))
   )
   nil
() )
#| 
; #else

(defconstant $uppAShareEventProcInfo #x3C0)
;  pascal no_return_value Func(4_bytes, 4_bytes) 

(defconstant $uppATNotifyProcInfo #x3FC0)
;  pascal no_return_value Func(4_bytes, 4_bytes, 4_bytes, 4_bytes) 

(defconstant $uppATFilterProcInfo #x3D0)
;  pascal 1_byte Func(4_bytes, 4_bytes) 

(defconstant $uppATNetworkEventNotifierProcInfo #x3C0)
;  pascal no_return_value Func(4_bytes, 4_bytes) 
; #define NewAShareEventUPP(userRoutine) 							(AShareEventUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppAShareEventProcInfo, GetCurrentArchitecture())
; #define NewATNotifyUPP(userRoutine) 							(ATNotifyUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppATNotifyProcInfo, GetCurrentArchitecture())
; #define NewATFilterUPP(userRoutine) 							(ATFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppATFilterProcInfo, GetCurrentArchitecture())
; #define NewATNetworkEventNotifierUPP(userRoutine) 				(ATNetworkEventNotifierUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppATNetworkEventNotifierProcInfo, GetCurrentArchitecture())
; #define DisposeAShareEventUPP(userUPP) 							DisposeRoutineDescriptor(userUPP)
; #define DisposeATNotifyUPP(userUPP) 							DisposeRoutineDescriptor(userUPP)
; #define DisposeATFilterUPP(userUPP) 							DisposeRoutineDescriptor(userUPP)
; #define DisposeATNetworkEventNotifierUPP(userUPP) 				DisposeRoutineDescriptor(userUPP)
; #define InvokeAShareEventUPP(theEvent, contextPtr, userUPP) 	CALL_TWO_PARAMETER_UPP((userUPP), uppAShareEventProcInfo, (theEvent), (contextPtr))
; #define InvokeATNotifyUPP(contextPtr, code, result, cookie, userUPP)  CALL_FOUR_PARAMETER_UPP((userUPP), uppATNotifyProcInfo, (contextPtr), (code), (result), (cookie))
; #define InvokeATFilterUPP(name, data, userUPP) 					(Boolean)CALL_TWO_PARAMETER_UPP((userUPP), uppATFilterProcInfo, (name), (data))
; #define InvokeATNetworkEventNotifierUPP(eventCode, cookie, userUPP)  CALL_TWO_PARAMETER_UPP((userUPP), uppATNetworkEventNotifierProcInfo, (eventCode), (cookie))
 |#

; #endif

;  support for pre-Carbon UPP routines: NewXXXProc and CallXXXProc 
; #define NewAShareEventProc(userRoutine) 						NewAShareEventUPP(userRoutine)
; #define NewATNotifyProc(userRoutine) 							NewATNotifyUPP(userRoutine)
; #define NewATFilterProc(userRoutine) 							NewATFilterUPP(userRoutine)
; #define NewATNetworkEventNotifierProc(userRoutine) 				NewATNetworkEventNotifierUPP(userRoutine)
; #define CallAShareEventProc(userRoutine, theEvent, contextPtr)	InvokeAShareEventUPP(theEvent, contextPtr, userRoutine)
; #define CallATNotifyProc(userRoutine, contextPtr, code, result, cookie) InvokeATNotifyUPP(contextPtr, code, result, cookie, userRoutine)
; #define CallATFilterProc(userRoutine, name, data)				InvokeATFilterUPP(name, data, userRoutine)
; #define CallATNetworkEventNotifierProc(userRoutine, eventCode, cookie) InvokeATNetworkEventNotifierUPP(eventCode, cookie, userRoutine)
; ---------------------------------------------------------------------------
;  AFPCreateSharedVolumesEnumerator: creates an enumerator for the volumes 	 
;  on an AppleShare server.													 
; 																			 
;  Accepts an optional volume name filter to restrict the volumes matched.	 
;  Use the predefined filters or your own or pass NULL to match all volumes	 
;  Accepts an optional notifier to call when the list of volumes has been	 
;  found. 																	 
;  Pass NULL for polling mode												 
;  For connections over TCP/IP pass NULL for serverZone and the DNS name in	 
;  serverName.																 
;  These calls may put up UI, pass a UPP to a routine to handle events that	 
;  affect other windows in your application.								 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPCreateSharedVolumesEnumerator" 
   ((serverName (:pointer :UInt8))
    (serverZone (:pointer :UInt8))
    (uamName (:pointer :UInt8))
    (userName (:pointer :UInt8))
    (password (:pointer :UInt8))
    (callback (:pointer :OpaqueAShareEventProcPtr))
    (evtContext :pointer)
    (filter (:pointer :OpaqueATFilterProcPtr))
    (filterParam :pointer)
    (notifier (:pointer :OpaqueATNotifyProcPtr))
    (contextPtr :pointer)
    (ref (:pointer :AFPSHAREDVOLUMESENUMERATORREF))
   )
   :OSStatus
() )

(deftrap-inline "_AFPCreateSVEFromAddress" 
   ((serverAddress (:pointer :sockaddr))
    (uamName (:pointer :UInt8))
    (userName (:pointer :UInt8))
    (password (:pointer :UInt8))
    (ref (:pointer :AFPSHAREDVOLUMESENUMERATORREF))
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
; 	AFPGetSharedVolumesCount: returns the number of AppleShare volumes 		 
;   found so far. Indicates if all volumes have been found					 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPGetSharedVolumesCount" 
   ((ref :UInt32)
    (allFound (:pointer :Boolean))
    (count (:pointer :UInt32))
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
; 	AFPGetIndexedSharedVolume: returns the name of volumes by index			 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPGetIndexedSharedVolume" 
   ((ref :UInt32)
    (index :UInt32)
    (volumeName (:pointer :UInt8))
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
; 	AFPSortSharedVolumes: sorts the list of volumes by alphabetical order	 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPSortSharedVolumes" 
   ((ref :UInt32)
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
; 	AFPMountSharedVolume: mounts a volume by name, 							 
;  leave isMounted NULL if you don't care wether or not the volume was		 
;  already mounted															 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPMountSharedVolume" 
   ((ref :UInt32)
    (volumeName (:pointer :STR255))
    (volumeRefNum (:pointer :short))
    (isMounted (:pointer :Boolean))
   )
   :OSStatus
() )
; --------------------------------------------------------------------------
; 	AFPMountSharedVolume: mounts a volume by name, on the specified	     	
; 	 mount point with the given flags. inMountFlags & inAltFlags are the	
;  	same as	those passed to the Mount System Call 				     		
; --------------------------------------------------------------------------

(deftrap-inline "_AFPMountSharedVolumeOnMP" 
   ((ref :UInt32)
    (inVolumeName (:pointer :UInt8))
    (inVolPassword (:pointer :UInt8))
    (inMountPoint (:pointer :char))
    (inMountFlags :UInt32)
    (inAltFlags :UInt32)
    (inMakeUnique :Boolean)
    (inMaxPath :UInt32)
    (outMountPath (:pointer :char))
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
;  AFPGetMountAtStartup: returns the startup mounting state of the named 	 
;  volume;  																 
;   returns noErr if the volume is set to mount at startup					 
;   returns nsvErr if the volume is not set to mount at startup				 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPGetMountAtStartup" 
   ((ref (:pointer :AFPSHAREDVOLUMESENUMERATORREF))
    (volumeName (:pointer :UInt8))
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
;  AFPSetMountAtStartup: sets the startup mounting state of the named volume 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPSetMountAtStartup" 
   ((ref (:pointer :AFPSHAREDVOLUMESENUMERATORREF))
    (volumeName (:pointer :UInt8))
    (toMount :Boolean)
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
;  AFPDeleteSharedVolumesEnumerator: deletes the enumerator					 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPDeleteSharedVolumesEnumerator" 
   ((ref (:pointer :AFPSHAREDVOLUMESENUMERATORREF))
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
;  AFPGetLoginInformation: returns the login information (will change)		 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPGetLoginInformation" 
   ((ref :UInt32)
    (isGuest (:pointer :Boolean))
    (userName (:pointer :STR255))
    (password (:pointer :STR255))
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
;  AFPChangePassword: Changes the password from oldPassword to newPassword	 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPChangePassword" 
   ((ref (:pointer :AFPSHAREDVOLUMESENUMERATORREF))
    (oldPassword (:pointer :UInt8))
    (newPassword (:pointer :UInt8))
   )
   :OSStatus
() )

; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=reset
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(pop)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack()
 |#

; #endif

; #ifdef PRAGMA_IMPORT_OFF
#| #|
#pragma import off
|#
 |#

; #elif PRAGMA_IMPORT
#| ; #pragma import reset
 |#

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _AFPCLIENT__ */


(provide-interface "afpClient")