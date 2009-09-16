(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRBurnSession.h"
; at Sunday July 2,2006 7:27:39 pm.
; 
;      File:       DiscRecordingUI/DRBurnSession.h
;  
;      Contains:   Carbon burn user interface for DiscRecording.
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
; #ifndef _H_DRBurnSession
; #define _H_DRBurnSession
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
; 	@typedef DRBurnSessionRef
; 	This is the type of a reference to DRBurnSession instances.
; 

(def-mactype :DRBurnSessionRef (find-mactype '(:pointer :__DRBurnSession)))
; !
; 	@function	DRBurnSessionGetTypeID
; 	@abstract	Returns the type identifier of all DRBurnSession instances.
; 	@result		A Core Foundation type ID.
; 

(deftrap-inline "_DRBurnSessionGetTypeID" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; !
; 	@function	DRBurnSessionCreate
; 	@abstract	Creates a new burn session.
; 	@result		A reference to a new DRBurnSession.
; 

(deftrap-inline "_DRBurnSessionCreate" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__DRBurnSession)
() )
; !
; 	@function	DRBurnSessionSetBurn
; 	@abstract	Sets the burn object for this session.
; 	@param		burnSession	The burn session. If this parameter is not a valid
; 							DRBurnSessionRef, the behavior is undefined. 
; 	@param		burn		The burn to use for the session. If this parameter is not a valid
; 							DRBurnRef, the behavior is undefined. 
; 

(deftrap-inline "_DRBurnSessionSetBurn" 
   ((burnSession (:pointer :__DRBurnSession))
    (burn (:pointer :__DRBurn))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; !
; 	@function	DRBurnSessionGetBurn
; 	@abstract	Returns the burn object for this session.
; 	@param		burnSession	The burn session. If this parameter is not a valid
; 							DRBurnSessionRef, the behavior is undefined. 
; 	@result		A reference to the burn object for the session. If the setup dialog has not been run or
; 				a burn object has not been set with DRBurnSessionSetBurn, this function returns NULL.
; 

(deftrap-inline "_DRBurnSessionGetBurn" 
   ((burnSession (:pointer :__DRBurnSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__DRBurn)
() )
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Dialog Result Codes
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		Burn Session Dialog Result Codes
; 	@discussion	Return codes for the burn session setup dialog.
; 	@constant	kDRBurnSessionOK		Value returned by the setup dialog when the user has confirmed the burn setup.
; 	@constant	kDRBurnSessionCancel	Value returned by the setup dialog when the user has canceled the burn setup.
; 

(defconstant $kDRBurnSessionOK 1)
(defconstant $kDRBurnSessionCancel 0)           ; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Setup Dialog Options
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		DRBurnSessionSetupDialogOptions struct version
; 

(defconstant $kBurnSessionSetupDialogOptionsCurrentVersion 1)
; !
; 	@enum		Burn Setup Dialog Option Flags
; 	@constant	kBurnSessionSetupDialogDefaultOptions	Use defaults for all the options
; 	@constant	kBurnSessionSetupDialogForceClosedDiscs	Force discs to be closed (not appendable)
; 	@constant	kBurnSessionSetupDialogDontHandleReservations	Session does not handle media reservations. Application handles them itself
; 	@constant	kBurnSessionSetupDialogAllowTestBurns Allow the user to perform a test burn
; 

(defconstant $kBurnSessionSetupDialogDefaultOptions 0);  use defaults for all the options 

(defconstant $kBurnSessionSetupDialogForceClosedDiscs 1);  Force discs to be closed (not appendable) 

(defconstant $kBurnSessionSetupDialogDontHandleReservations 2);  Don't handle media reservations. Application handles them itself 

(defconstant $kBurnSessionSetupDialogAllowTestBurns #x80000004);  Allow the user to perform a test burn 

; !
; 	@typedef 	DRBurnSessionSetupDialogOptionFlags
; 	@abstract	Specifies setup dialog configuration options.
; 

(def-mactype :DRBurnSessionSetupDialogOptionFlags (find-mactype ':UInt32))
; !
; 	@struct 	DRBurnSessionSetupDialogOptions
; 	@abstract	Options passed into the setup dialog to configure it.
; 	@field		version				Identifies the version of this structure.
; 	@field		dialogOptionFlags	One of several constants defined by the DRBurnSessionSetupDialogOptionFlags 
; 									data type as described in “Burn Setup Dialog Option Flags”.
; 	@field		defaultButtonTitle	A CFStringRef that defines a custom title to be used for the dialog's default button.
; 									If you do not provide this string (passing NULL), the normal button title is used.
; 
(defrecord DRBurnSessionSetupDialogOptions
   (version :UInt32)
   (dialogOptionFlags :UInt32)
                                                ;  option flags for affecting the dialog's behavior 
   (defaultButtonTitle (:pointer :__CFString))
                                                ;  title of default button 
)

;type name? (%define-record :DRBurnSessionSetupDialogOptions (find-record-descriptor ':DRBurnSessionSetupDialogOptions))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Setup Dialog Callbacks
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		DRBurnSessionSetupCallbacks struct version
; 

(defconstant $kDRBurnSessionSetupCallbacksCurrentVersion 1)
; !
; 	@typedef	DRBurnSessionDeviceCheckProcPtr
; 	@abstract	Callback used for checking the suitability of a device.
; 	@discussion This callback is called whenever a new device appears. It's purpose is to allow the
; 				application to filter out devices which do not support the operation to be performed. for
; 				example, a device may filter our CD-R/W's if it is a DVD creation appliacation.
; 	@param		burnSession	The burn session object.
; 	@param		device		The device to examine.
; 	@result		A Boolean value indicating the suitability of the device.
; 

(def-mactype :DRBurnSessionDeviceCheckProcPtr (find-mactype ':pointer)); (DRBurnSessionRef burnSession , DRDeviceRef device)
; !
; 	@typedef	DRBurnSessionMediaCheckProcPtr
; 	@abstract	Callback used for checking the suitability of media in a device.
; 	@discussion This callback is called whenever the state of the media has changed. It's purpose is to allow the
; 				application to determine if the media is suitable for the operation to be performed. For example,
; 				the application an check to see if there is enough space on the media for the data to be written.
; 	@param		burnSession	The burn session object.
; 	@param		device		The device containing the media to examine.
; 	@param		prompt		A pointer to a CFStringRef. An application may return a custom message to display in the 
; 							setup dialog.
; 	@result		A Boolean value indicating the suitability of the media.
; 

(def-mactype :DRBurnSessionMediaCheckProcPtr (find-mactype ':pointer)); (DRBurnSessionRef burnSession , DRDeviceRef device , CFStringRef * prompt)
; !
; 	@typedef	DRBurnSessionDeviceSelectionNotificationProcPtr
; 	@abstract	Callback used to notify the application of a new device selected.
; 	@param		burnSession	The burn session object.
; 	@param		device		The newly selected device.
; 

(def-mactype :DRBurnSessionDeviceSelectionNotificationProcPtr (find-mactype ':pointer)); (DRBurnSessionRef burnSession , DRDeviceRef device)
; !
; 	@struct		DRBurnSessionSetupCallbacks
; 	@abstract	Callback functions passed to the setup dialog.
; 	@field		version					Identifies the version of this structure.
; 	@field		deviceShouldBeTarget	Pointer to a DRBurnSessionDeviceCheckProcPtr. The value of this field may be NULL.
; 	@field		containsSuitableMedia	Pointer to a DRBurnSessionMediaCheckProcPtr. The value of this field may be NULL.
; 	@field		deviceSelectionChanged	Pointer to a DRBurnSessionDeviceSelectionNotificationProcPtr. The value of this field may be NULL.
; 
(defrecord DRBurnSessionSetupCallbacks
   (version :UInt32)
   (deviceShouldBeTarget :pointer)
   (containsSuitableMedia :pointer)
   (deviceSelectionChanged :pointer)
)

;type name? (%define-record :DRBurnSessionSetupCallbacks (find-record-descriptor ':DRBurnSessionSetupCallbacks))
; !
; 	@function	DRBurnSessionSetupDialog
; 	@abstract	Presents the setup interface as a modal dialog.
; 	@discussion	This function present the user with a modal dialog that allows them to configure a burn to their custom
; 				settings. These include: the device to use, whether or not to eject the media when finished, the burn speed
; 				and others. The function does not return until the user dismissed the dialog.
; 	@param		burnSession	The burn session object
; 	@param		options		A pointer to a structure of type DRBurnSessionSetupDialogOptions. 
; 							This pointer may be NULL if no custom configuration is required.
; 	@param		setupCallbacks	A pointer to a structure of type DRBurnSessionSetupCallbacks. 
; 								This pointer may be NULL if no custom behavior is desired.
; 	@param		resultCode	A pointer to a SInt8 to hold the result code for the setup dialog. 
; 							May be one of the constants defined by "Burn Session Dialog Result Codes".
; 

(deftrap-inline "_DRBurnSessionSetupDialog" 
   ((burnSession (:pointer :__DRBurnSession))
    (options (:pointer :DRBurnSessionSetupDialogOptions))
    (setupCallbacks (:pointer :DRBurnSessionSetupCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt8
() )
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Progress Dialog Callbacks
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		kDRBurnProgressSetupCallbacksCurrentVersion struct version
; 

(defconstant $kDRBurnProgressSetupCallbacksCurrentVersion 1)
; !
; 	@typedef	DRBurnSessionProgressBeginNotificationProcPtr
; 	@abstract	Callback notifying the application the burn progress is about to begin.
; 	@discussion	This callback is called when the burn progress is about to be displayed. This allows the application
; 				to do things such as disable the quit menu item, or the close menu for a document window.
; 	@param		burnSession	The burn session object.
; 

(def-mactype :DRBurnSessionProgressBeginNotificationProcPtr (find-mactype ':pointer)); (DRBurnSessionRef burnSession)
; !
; 	@typedef	DRBurnSessionProgressFinishNotificationProcPtr
; 	@abstract	Callback notifying the application the burn progress is has finished.
; 	@discussion	This callback is called when the burn progress has been removed from view. This allows the application
; 				to do things such as re-enable the quit menu item, or the close menu for a document window.
; 	@param		burnSession	The burn session object.
; 

(def-mactype :DRBurnSessionProgressFinishNotificationProcPtr (find-mactype ':pointer)); (DRBurnSessionRef burnSession)
; !
; 	@typedef	DRBurnSessionProgressFinishNotificationProcPtr
; 	@abstract	Callback notifying the application the burn progress is has finished.
; 	@discussion	This callback is called when the burn operation completes, either successfully or with an error.
; 				This function can be used by the application to present it's own custom end-of-burn handling. 
; 				Return a false return value to prevent the burn session from presenting it's own notification.
; 	@param		burnSession	The burn session object.
; 	@param		burn		The burn instance that just finished.
; 	@result		A Boolean value controlling the display of the burn session's error dialog.
; 

(def-mactype :DRBurnSessionBurnCompleteProcPtr (find-mactype ':pointer)); (DRBurnSessionRef burnSession , DRBurnRef burn)
; !
; 	@struct		DRBurnSessionProgressCallbacks
; 	@abstract	Callback functions passed to the progress dialog.
; 	@field		version					Identifies the version of this structure.
; 	@field		deviceShouldBeTarget	Pointer to a DRBurnSessionProgressBeginNotificationProcPtr. The value of this field may be NULL.
; 	@field		containsSuitableMedia	Pointer to a DRBurnSessionProgressFinishNotificationProcPtr. The value of this field may be NULL.
; 	@field		deviceSelectionChanged	Pointer to a DRBurnSessionBurnCompleteProcPtr. The value of this field may be NULL.
; 
(defrecord DRBurnSessionProgressCallbacks
   (version :UInt32)
   (progressWillBegin :pointer)
   (progressDidFinish :pointer)
   (burnDidFinish :pointer)
)

;type name? (%define-record :DRBurnSessionProgressCallbacks (find-record-descriptor ':DRBurnSessionProgressCallbacks))
; ——————————————————————————————————————————————————————————————————————————————————————————————————————
; 	• Progress Dialog Options
; /*——————————————————————————————————————————————————————————————————————————————————————————————————————
; !
; 	@enum		DRBurnSessionProgressDialogOptions struct version
; 

(defconstant $kBurnSessionProgressDialogOptionsCurrentVersion 1)
; !
; 	@enum		Burn Progress Dialog Option Flags
; 	@constant	kBurnSessionProgressDialogDefaultOptions	Use defaults for all the options
; 	@constant	kBurnSessionProgressDialogDisplayVerboseProgress	Report all status changes in detail
; 

(defconstant $kBurnSessionProgressDialogDefaultOptions 0);  use defaults for all the options 

(defconstant $kBurnSessionProgressDialogDisplayVerboseProgress 1);  Report all status changes in detail 

; !
; 	@typedef 	DRBurnSessionProgressDialogOptionFlags
; 	@abstract	Specifies progress dialog configuration options.
; 

(def-mactype :DRBurnSessionProgressDialogOptionFlags (find-mactype ':UInt32))
; !
; 	@struct 	DRBurnSessionProgressDialogOptions
; 	@abstract	Options passed into the progress dialog to configure it.
; 	@field		version				Identifies the version of this structure.
; 	@field		dialogOptionFlags	One of several constants defined by the DRBurnSessionProgressDialogOptionFlags 
; 									data type as described in “Burn Progress Dialog Option Flags”.
; 	@field		description			A CFStringRef that defines a custom description to be used for the dialog.
; 									If you do not provide this string (passing NULL), the normal description is used.
; 
(defrecord DRBurnSessionProgressDialogOptions
   (version :UInt32)
   (dialogOptionFlags :UInt32)
                                                ;  option flags for affecting the dialog's behavior 
   (description (:pointer :__CFString))
                                                ;  optional description of the burn 
)

;type name? (%define-record :DRBurnSessionProgressDialogOptions (find-record-descriptor ':DRBurnSessionProgressDialogOptions))
; !
; 	@function	DRBurnSessionBeginProgressDialog
; 	@abstract	Presents the progress interface as a non-modal dialog.
; 	@discussion	This function present the user with a non-modal dialog that shows the burn progress.
; 	@param		burnSession	The burn session object
; 	@param		layout		The track layout to be used for the burn.
; 	@param		options		A pointer to a structure of type DRBurnSessionSetupDialogOptions. 
; 	@param		progressCallbacks	A pointer to a structure of type DRBurnSessionProgressCallbacks. 
; 									This pointer may be NULL if no custom behavior is desired.
; 

(deftrap-inline "_DRBurnSessionBeginProgressDialog" 
   ((burnSession (:pointer :__DRBurnSession))
    (layout (:pointer :void))
    (options (:pointer :DRBurnSessionProgressDialogOptions))
    (progressCallbacks (:pointer :DRBurnSessionProgressCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DRBurnSession */


(provide-interface "DRBurnSession")