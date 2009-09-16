(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DREraseSession.h"
; at Sunday July 2,2006 7:27:40 pm.
; 
;      File:       DiscRecordingUI/DREraseSession.h
;  
;      Contains:   Carbon erase user interface for DiscRecording.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _H_DREraseSession
; #define _H_DREraseSession
; #ifndef _H_DiscRecording
#| #|
#import <DiscRecordingDiscRecording.h>
#endif
|#
 |#
; #ifndef __CARBON__
#| #|
#import <CarbonCarbon.h>
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
; !
; 	@typedef DREraseSessionRef
; 	This is the type of a reference to DREraseSession instances.
; 

(def-mactype :DREraseSessionRef (find-mactype '(:pointer :__DREraseSession)))
; !
; 	@function	DREraseSessionGetTypeID
; 	@abstract	Returns the type identifier of all DREraseSession instances.
; 	@result		A Core Foundation type ID.
; 

(deftrap-inline "_DREraseSessionGetTypeID" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; !
; 	@function	DREraseSessionCreate
; 	@abstract	Creates a new erase session.
; 	@result		A reference to a new DREraseSession.
; 

(deftrap-inline "_DREraseSessionCreate" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__DREraseSession)
() )
; !
; 	@function	DREraseSessionSetErase
; 	@abstract	Sets the erase object for this session.
; 	@param		eraseSession	The erase session. If this parameter is not a valid
; 								DREraseSessionRef, the behavior is undefined. 
; 	@param		erase			The erase to use for the session. If this parameter is not a valid
; 								DREraseRef, the behavior is undefined. 
; 

(deftrap-inline "_DREraseSessionSetErase" 
   ((eraseSession (:pointer :__DREraseSession))
    (erase (:pointer :__DRErase))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; !
; 	@function	DREraseSessionGetErase
; 	@abstract	Returns the erase object for this session.
; 	@param		eraseSession	The erase session. If this parameter is not a valid
; 								DREraseSessionRef, the behavior is undefined. 
; 	@result		A reference to the erase object for the session. If the setup dialog has not been run or
; 				a burn object has not been set with DREraseSessionSetErase, this function returns NULL.
; 

(deftrap-inline "_DREraseSessionGetErase" 
   ((eraseSession (:pointer :__DREraseSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__DRErase)
() )
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Dialog Result Codes
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		Erase Session Dialog Result Codes
; 	@discussion	Return codes for the erase session setup dialog.
; 	@constant	kDREraseSessionOK		Value returned by the setup dialog when the user has confirmed the erase setup.
; 	@constant	kDREraseSessionCancel	Value returned by the setup dialog when the user has canceled the erase setup.
; 

(defconstant $kDREraseSessionOK 1)
(defconstant $kDREraseSessionCancel 0)
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Setup Dialog Options
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		DREraseSessionSetupDialogOptions struct version
; 

(defconstant $kEraseSessionSetupDialogOptionsCurrentVersion 1)
; !
; 	@enum		Erase Setup Dialog Option Flags
; 	@constant	kEraseSessionSetupDialogDefaultOptions	Use defaults for all the options
; 	@constant	kEraseSessionSetupDialogDontHandleReservations	Session does not handle media reservations. Application handles them itself
; 

(defconstant $kEraseSessionSetupDialogDefaultOptions 0);  use defaults for all the options 

(defconstant $kEraseSessionSetupDialogDontHandleReservations 1);  Don't handle media reservations. Application handles them itself 
; !
; 	@typedef 	DREraseSessionSetupDialogOptionFlags
; 	@abstract	Specifies setup dialog configuration options.
; 

(def-mactype :DREraseSessionSetupDialogOptionFlags (find-mactype ':UInt32))
; !
; 	@struct 	DREraseSessionSetupDialogOptions
; 	@abstract	Options passed into the setup dialog to configure it.
; 	@field		version				Identifies the version of this structure.
; 	@field		dialogOptionFlags	One of several constants defined by the DREraseSessionSetupDialogOptionFlags 
; 									data type as described in “Erase Setup Dialog Option Flags”.
; 
(defrecord DREraseSessionSetupDialogOptions
   (version :UInt32)
   (dialogOptionFlags :UInt32)
                                                ;  option flags for affecting the dialog's behavior 
)

;type name? (%define-record :DREraseSessionSetupDialogOptions (find-record-descriptor ':DREraseSessionSetupDialogOptions))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Setup Dialog Callbacks
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		DREraseSessionSetupCallbacks struct version
; 

(defconstant $kDREraseSessionSetupCallbacksCurrentVersion 1)
; !
; 	@typedef	DREraseSessionDeviceCheckProcPtr
; 	@abstract	Callback used for checking the suitability of a device.
; 	@discussion This callback is called whenever a new device appears. It's purpose is to allow the
; 				application to filter out devices which do not support the operation to be performed. for
; 				example, a device may filter our CD-R/W's if it is a DVD creation appliacation.
; 	@param		eraseSession	The erase session object.
; 	@param		device			The device to examine.
; 	@result		A Boolean value indicating the suitability of the device.
; 

(def-mactype :DREraseSessionDeviceCheckProcPtr (find-mactype ':pointer)); (DREraseSessionRef eraseSession , DRDeviceRef device)
; !
; 	@typedef	DREraseSessionMediaCheckProcPtr
; 	@abstract	Callback used for checking the suitability of media in a device.
; 	@discussion This callback is called whenever the state of the media has changed. It's purpose is to allow the
; 				application to determine if the media is suitable for the operation to be performed. For example,
; 				the application an check to see if there is enough space on the media for the data to be written.
; 	@param		eraseSession	The erase session object.
; 	@param		device			The device containing the media to examine.
; 	@param		prompt			A pointer to a CFStringRef. An application may return a custom message to display in the 
; 								setup dialog.
; 	@result		A Boolean value indicating the suitability of the media.
; 

(def-mactype :DREraseSessionMediaCheckProcPtr (find-mactype ':pointer)); (DREraseSessionRef eraseSession , DRDeviceRef device , CFStringRef * prompt)
; !
; 	@typedef	DREraseSessionDeviceSelectionNotificationProcPtr
; 	@abstract	Callback used to notify the application of a new device selected.
; 	@param		eraseSession	The erase session object.
; 	@param		device			The newly selected device.
; 

(def-mactype :DREraseSessionDeviceSelectionNotificationProcPtr (find-mactype ':pointer)); (DREraseSessionRef eraseSession , DRDeviceRef selectedDevice)
; !
; 	@struct		DREraseSessionSetupCallbacks
; 	@abstract	Callback functions passed to the setup dialog.
; 	@field		version					Identifies the version of this structure.
; 	@field		deviceShouldBeTarget	Pointer to a DREraseSessionDeviceCheckProcPtr. The value of this field may be NULL.
; 	@field		containsSuitableMedia	Pointer to a DREraseSessionMediaCheckProcPtr. The value of this field may be NULL.
; 	@field		deviceSelectionChanged	Pointer to a DREraseSessionDeviceSelectionNotificationProcPtr. The value of this field may be NULL.
; 
(defrecord DREraseSessionSetupCallbacks
   (version :UInt32)
   (deviceShouldBeTarget :pointer)
   (containsSuitableMedia :pointer)
   (deviceSelectionChanged :pointer)
)

;type name? (%define-record :DREraseSessionSetupCallbacks (find-record-descriptor ':DREraseSessionSetupCallbacks))
; !
; 	@function	DREraseSessionSetupDialog
; 	@abstract	Presents the setup interface as a modal dialog.
; 	@discussion	This function present the user with a modal dialog that allows them to configure an erase to their custom
; 				settings. These include: the device to use and the type of erase to perform.
; 				and others. The function does not return until the user dismissed the dialog.
; 	@param		eraseSession	The erase session object
; 	@param		options			A pointer to a structure of type DREraseSessionSetupDialogOptions. 
; 								This pointer may be NULL if no custom configuration is required.
; 	@param		setupCallbacks	A pointer to a structure of type DREraseSessionSetupCallbacks. 
; 								This pointer may be NULL if no custom behavior is desired.
; 	@param		resultCode		A pointer to a SInt8 to hold the result code for the setup dialog.
; 								May be one of the constants defined by "Erase Session Dalog Result Codes".
; 	@result		An OSStatus.
; 

(deftrap-inline "_DREraseSessionSetupDialog" 
   ((eraseSession (:pointer :__DREraseSession))
    (options (:pointer :DREraseSessionSetupDialogOptions))
    (setupCallbacks (:pointer :DREraseSessionSetupCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt8
() )
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Progress Dialog Callbacks
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		kDREraseProgressSetupCallbacksCurrentVersion struct version
; 

(defconstant $kDREraseProgressSetupCallbacksCurrentVersion 1)
; !
; 	@typedef	DREraseSessionProgressBeginNotificationProcPtr
; 	@abstract	Callback notifying the application the erase progress is about to begin.
; 	@discussion	This callback is called when the erase progress is about to be displayed. This allows the application
; 				to do things such as disable the quit menu item, or the close menu for a document window.
; 	@param		eraseSession	The erase session object.
; 

(def-mactype :DREraseSessionProgressBeginNotificationProcPtr (find-mactype ':pointer)); (DREraseSessionRef eraseSession)
; !
; 	@typedef	DREraseSessionProgressFinishNotificationProcPtr
; 	@abstract	Callback notifying the application the erase progress is has finished.
; 	@discussion	This callback is called when the erase progress has been removed from view. This allows the application
; 				to do things such as re-enable the quit menu item, or the close menu for a document window.
; 	@param		eraseSession	The erase session object.
; 

(def-mactype :DREraseSessionProgressFinishNotificationProcPtr (find-mactype ':pointer)); (DREraseSessionRef eraseSession)
; !
; 	@typedef	DREraseSessionProgressFinishNotificationProcPtr
; 	@abstract	Callback notifying the application the erase progress is has finished.
; 	@discussion	This callback is called when the erase operation completes, either successfully or with an error.
; 				This function can be used by the application to present it's own custom end-of-erase handling. If the 
; 				application wants to present it's own end-of-erase notification, it can do so from this callback. If it
; 				does, it can return a false return value to prevent the erase session from presenting it's own notification.
; 	@param		eraseSession	The erase session object.
; 	@param		erase		The erase instance that just finished.
; 	@result		A Boolean value controlling the display of the erase session's error dialog.
; 

(def-mactype :DREraseSessionEraseCompleteProcPtr (find-mactype ':pointer)); (DREraseSessionRef eraseSession , DREraseRef erase)
; !
; 	@struct		DREraseSessionProgressCallbacks
; 	@abstract	Callback functions passed to the progress dialog.
; 	@field		version					Identifies the version of this structure.
; 	@field		deviceShouldBeTarget	Pointer to a DREraseSessionProgressBeginNotificationProcPtr. The value of this field may be NULL.
; 	@field		containsSuitableMedia	Pointer to a DREraseSessionProgressFinishNotificationProcPtr. The value of this field may be NULL.
; 	@field		deviceSelectionChanged	Pointer to a DREraseSessionEraseCompleteProcPtr. The value of this field may be NULL.
; 
(defrecord DREraseSessionProgressCallbacks
   (version :UInt32)
   (progressWillBegin :pointer)
   (progressDidFinish :pointer)
   (eraseDidFinish :pointer)
)

;type name? (%define-record :DREraseSessionProgressCallbacks (find-record-descriptor ':DREraseSessionProgressCallbacks))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Progress Dialog Options
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		DREraseSessionProgressDialogOptions struct version
; 

(defconstant $kEraseSessionProgressDialogOptionsCurrentVersion 1)
; !
; 	@enum		Erase Progress Dialog Option Flags
; 	@constant	kEraseSessionProgressDialogDefaultOptions	Use defaults for all the options
; 

(defconstant $kEraseSessionProgressDialogDefaultOptions 0);  use defaults for all the options 

; !
; 	@typedef 	DREraseSessionProgressDialogOptionFlags
; 	@abstract	Specifies progress dialog configuration options.
; 

(def-mactype :DREraseSessionProgressDialogOptionFlags (find-mactype ':UInt32))
; !
; 	@struct 	DREraseSessionProgressDialogOptions
; 	@abstract	Options passed into the progress dialog to configure it.
; 	@field		version				Identifies the version of this structure.
; 	@field		dialogOptionFlags	One of several constants defined by the DREraseSessionProgressDialogOptionFlags 
; 									data type as described in “Erase Progress Dialog Option Flags”.
; 	@field		description			A CFStringRef that defines a custom description to be used for the dialog.
; 									If you do not provide this string (passing NULL), the normal description is used.
; 
(defrecord DREraseSessionProgressDialogOptions
   (version :UInt32)
   (dialogOptionFlags :UInt32)
                                                ;  option flags for affecting the dialog's behavior 
   (description (:pointer :__CFString))
                                                ;  optional description of the erase 
)

;type name? (%define-record :DREraseSessionProgressDialogOptions (find-record-descriptor ':DREraseSessionProgressDialogOptions))
; !
; 	@function	DREraseSessionBeginProgressDialog
; 	@abstract	Presents the progress interface as a non-modal dialog.
; 	@discussion	This function present the user with a non-modal dialog that shows the erase progress.
; 	@param		eraseSession	The erase session object
; 	@param		options			A pointer to a structure of type DREraseSessionSetupDialogOptions. 
; 	@param		progressCallbacks	A pointer to a structure of type DREraseSessionProgressCallbacks. 
; 									This pointer may be NULL if no custom behavior is desired.
; 	@result		An OSStatus.
; 

(deftrap-inline "_DREraseSessionBeginProgressDialog" 
   ((eraseSession (:pointer :__DREraseSession))
    (options (:pointer :DREraseSessionProgressDialogOptions))
    (progressCallbacks (:pointer :DREraseSessionProgressCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DREraseSession */


(provide-interface "DREraseSession")