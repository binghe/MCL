(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRStatus.h"
; at Sunday July 2,2006 7:27:43 pm.
; 
;      File:       DiscRecordingEngine/DRStatus.h
;  
;      Contains:   Status dictionary content keys.
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

; #import <Foundation/Foundation.h>

; #import <AvailabilityMacros.h>

; #if 0
#| ; #pragma mark Common status dictionary keys
 |#

; #endif

; !
; 	@const DRStatusStateKey
; 	@discussion	A key for the status dictionaries. The value of this key is a CFString indicating 
; 				the current state of the operation.
; 
(def-mactype :DRStatusStateKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusPercentCompleteKey
; 	@discussion	A key for the status dictionaries. The value of this key is 
; 				a CFNumber containing the precent complete of the operation expressed as
; 				a foating point number from 0 to 1.
; 
(def-mactype :DRStatusPercentCompleteKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

; #if 0
#| ; #pragma mark Burn status dictionary keys
 |#

; #endif

; !
; 	@const DRStatusCurrentSessionKey
; 	@discussion	A key for the burn status dictionary. The value of this key is 
; 				a CFNumber indicating the current session being burned.
; 
(def-mactype :DRStatusCurrentSessionKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusCurrentTrackKey
; 	@discussion	A key for the status dictionaries. The value of this key is 
; 				a CFNumber indicating the current track being burned.
; 
(def-mactype :DRStatusCurrentTrackKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusTotalSessionsKey
; 	@discussion	A key for the status dictionaries. The value of this key is 
; 				a CFNumber indicating the total number of sessions being burned.
; 
(def-mactype :DRStatusTotalSessionsKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusTotalTracksKey
; 	@discussion	A key for the status dictionaries. The value of this key is 
; 				a CFNumber indicating the total number of tracks in the current session being burned.
; 
(def-mactype :DRStatusTotalTracksKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusCurrentSpeedKey
; 	@discussion	A key for the burn status dictionary. The value of this key is 
; 				an NSNumber indicating the current burn speed.
; 
(def-mactype :DRStatusCurrentSpeedKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

; #if 0
#| ; #pragma mark Erase status dictionary keys
 |#

; #endif

; !
; 	@const DRStatusEraseTypeKey
; 	@discussion	A key for the erase status dictionary. The value of this key is 
; 				a CFString indicating the type of erase operation.
; 
(def-mactype :DRStatusEraseTypeKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

; #if 0
#| ; #pragma mark Common values for DRStatusStateKey
 |#

; #endif

; !
; 	@const DRStatusStateNone
; 	@discussion	One possible value for DRStatusStateKey. Indicates the
; 				operation has not yet begun.
; 
(def-mactype :DRStatusStateNone (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStatePreparingKey
; 	@discussion	One possible value for DRStatusStateKey. Indicates the
; 				operation is preparing to begin.
; 
(def-mactype :DRStatusStatePreparing (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStateVerifying
; 	@discussion	One possible value for DRStatusStateKey. Indicates the
; 				operation is verifying what it did.
; 
(def-mactype :DRStatusStateVerifying (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStateDoneKey
; 	@discussion	One possible value for DRStatusStateKey. Indicates the
; 				operation is finished and it succeeded.
; 
(def-mactype :DRStatusStateDone (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStateFailedKey
; 	@discussion	One possible value for DRStatusStateKey. Indicates the
; 				operation is finished and it failed.
; 
(def-mactype :DRStatusStateFailed (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

; #if 0
#| ; #pragma mark Burn dictionary values for DRStatusStateKey
 |#

; #endif

; !
; 	@const DRStatusStateSessionOpen
; 	@discussion	One possible value for DRStatusStateKey in the burn status dictionary. 
; 				Indicates the burn is opening a session on disc. The exact session being opened
; 				is contained in DRStatusCurrentSessionKey.
; 
(def-mactype :DRStatusStateSessionOpen (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStateTrackOpen
; 	@discussion	One possible value for DRStatusStateKey in the burn status dictionary. 
; 				Indicates the burn is opening a track on disc. The exact track being opened
; 				is contained in DRStatusCurrentTrackKey.
; 
(def-mactype :DRStatusStateTrackOpen (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStateTrackWrite
; 	@discussion	One possible value for DRStatusStateKey in the burn status dictionary. 
; 				Indicates the burn is writing a track on disc. The exact track being written
; 				is contained in DRStatusCurrentTrackKey.
; 
(def-mactype :DRStatusStateTrackWrite (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStateTrackClose
; 	@discussion	One possible value for DRStatusStateKey in the burn status dictionary. 
; 				Indicates the burn is closing a track on disc. The exact track being closed
; 				is contained in DRStatusCurrentTrackKey.
; 
(def-mactype :DRStatusStateTrackClose (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStateSessionOpen
; 	@discussion	One possible value for DRStatusStateKey in the burn status dictionary. 
; 				Indicates the burn is closing a session on disc. The exact session being closing
; 				is contained in DRStatusCurrentSessionKey.
; 
(def-mactype :DRStatusStateSessionClose (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const DRStatusStateFinishing
; 	@discussion	One possible value for DRStatusStateKey in the burn status dictionary. 
; 				Indicates the burn is finishing up (closing the last session, writing the TOC, etc).
; 
(def-mactype :DRStatusStateFinishing (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

; #if 0
#| ; #pragma mark Erase dictionary values for DRStatusStateKey
 |#

; #endif

; !
; 	@const DRStatusStateErasingKey
; 	@discussion	One possible value for DRStatusStateKey in the erase status dictionary. 
; 				Indicates the erase is currently in progress.
; 
(def-mactype :DRStatusStateErasing (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

; #if 0
#| ; #pragma mark Status dictionary error keys
 |#

; #endif

; !
; 	@const		DRErrorStatusKey
; 	@discussion	The key in the status dictionary for the error dictionary.
; 
(def-mactype :DRErrorStatusKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRErrorStatusErrorKey
; 	@discussion	An NSNumber containing the OS error code for the error.
; 
(def-mactype :DRErrorStatusErrorKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRErrorStatusErrorStringKey
; 	@discussion	An NSString describing the error in a user appropriate manner.
; 
(def-mactype :DRErrorStatusErrorStringKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRErrorStatusSenseKey
; 	@discussion	An NSData object containing the raw RBC sense information structure reported by the device.
; 				If no sense is reported, this key will not be present.
; 
(def-mactype :DRErrorStatusSenseKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRErrorStatusSenseCodeStringKey
; 	@discussion	An NSString describing the RBC sense code returned by the device.
; 				If no sense is reported, this key will not be present.
; 
(def-mactype :DRErrorStatusSenseCodeStringKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const		DRErrorStatusAdditionalSenseStringKey
; 	@discussion	An NSString describing the RBC additional sense code and additional 
; 				sense code qualifier pair returned by the device.
; 				If no sense is reported, this key will not be present.
; 
(def-mactype :DRErrorStatusAdditionalSenseStringKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

(provide-interface "DRStatus")