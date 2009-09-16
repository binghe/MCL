(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRCoreErase.h"
; at Sunday July 2,2006 7:27:36 pm.
; 
;      File:       DiscRecordingEngine/DRCoreErase.h
;  
;      Contains:   Erase object interfaces for Disc Recording.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _H_DRCoreErase
; #define _H_DRCoreErase

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef _H_DRCoreObject
#| #|
#include <DiscRecordingEngineDRCoreObject.h>
#endif
|#
 |#
; #ifndef _H_DRCoreDevice
#| #|
#include <DiscRecordingEngineDRCoreDevice.h>
#endif
|#
 |#
; #ifndef __AVAILABILITYMACROS__

(require-interface "AvailabilityMacros")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; !
; 	@typedef DREraseRef
; 	This is the type of a reference to DRErases.
; 

(def-mactype :DREraseRef (find-mactype '(:pointer :__DRErase)))
; !
; 	@function	DREraseGetTypeID
; 	@abstract	Obtains the type identifier of all DRErase instances.
; 

(deftrap-inline "_DREraseGetTypeID" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; !
; 	@function	DREraseCreate
; 	@abstract	Creates a new eraser.
; 	@param		device		A reference to the device to erase. If this parameter is not a 
; 							valid DRDevice, the behavior is undefined.
; 	@result		Returns a reference to a new DRErase opaque type.
; 

(deftrap-inline "_DREraseCreate" 
   ((device (:pointer :__DRDevice))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRErase)
() )
; !
; 	@function	DREraseStart
; 	@abstract	Begin the erase process.
; 	@param		erase		The eraser object that should be started. If this parameter 
; 							is not a valid DRErase oject, the behavior is undefined.
; 

(deftrap-inline "_DREraseStart" 
   ((erase (:pointer :__DRErase))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; !
; 	@function	DREraseCopyStatus
; 	@abstract	Obtains the status of the erase process.
; 	@discussion	This function obtains a reference to a CFDictionary object containing the status of the erase process, including the 
; 				percentage complete and any errors reported. The reference is implicitly retained 
; 				by the caller. This is the same dictionary sent to observers of kDREraseStatusChangedNotification.
; 	@result		Returns a reference to a CFDictionary object. 
; 

(deftrap-inline "_DREraseCopyStatus" 
   ((erase (:pointer :__DRErase))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFDictionary)
() )
; !
; 	@const kDREraseStatusChangedNotification
; 	@discussion	The notification sent when a DRErase object has updated status.
; 
(def-mactype :kDREraseStatusChangedNotification (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@function	DREraseGetDevice
; 	@abstract	Obtains a reference to the device containing the disc to erase.
; 	@param		erase	The eraser containing a reference to the device. If this parameter 
; 						is not a valid DRErase object, the behavior is undefined. 
; 	@result		Returns reference to the device containing the disc to erase.
; 

(deftrap-inline "_DREraseGetDevice" 
   ((erase (:pointer :__DRErase))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRDevice)
() )
; !
; 	@function	DREraseSetProperties
; 	@abstract	Sets the properties of the erase process.
; 	@param		erase		The erase process to set the properties of. If this parameter 
; 							is not a valid DRErase object, the behavior is undefined. 
; 	@param		properties	A CFDictionary object containing the erase properties. If this
; 							parameter is not a valid CFDictionary object the behavior is undefined.
; 

(deftrap-inline "_DREraseSetProperties" 
   ((erase (:pointer :__DRErase))
    (properties (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DREraseGetProperties
; 	@abstract	Returns properties of the erase.
; 	@param		erase		The erase process to get the properties of. If this parameter 
; 							is not a valid DRErase object, the behavior is undefined. 
; 	@result		Returns a CFDictionary object containing the erase properties.
; 

(deftrap-inline "_DREraseGetProperties" 
   ((erase (:pointer :__DRErase))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFDictionary)
() )
; #pragma mark Erase Properties
; !
; 	@const kDREraseTypeKey
; 	@discussion	This key points to a CFString object describing the type of erase to be performed.
; 				If this key is not present, a kDREraseTypeQuick erase type is assumed.
; 
(def-mactype :kDREraseTypeKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDREraseTypeQuick
; 	@discussion	A CFString object indicating the erase operation should do the minimal amount of
; 				work to make the disc appear blank. This operation typically takes only a
; 				minute or two.
; 
(def-mactype :kDREraseTypeQuick (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const kDREraseTypeComplete
; 	@discussion	A CFString object indicating the erase operation should erase every byte on the
; 				disc. This operation is slow, taking on the order of 30 minutes.
; 
(def-mactype :kDREraseTypeComplete (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DRCoreErase */


(provide-interface "DRCoreErase")