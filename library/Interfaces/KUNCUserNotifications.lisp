(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:KUNCUserNotifications.h"
; at Sunday July 2,2006 7:30:16 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  *
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  *
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  *
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef __USERNOTIFICATION_KUNCUSERNOTIFICATIONS_H
; #define __USERNOTIFICATION_KUNCUSERNOTIFICATIONS_H

(require-interface "sys/cdefs")

(require-interface "mach/message")

(require-interface "mach/kern_return")

(require-interface "UserNotification/UNDTypes")
; 
;  * non blocking notice call.
;  

(deftrap-inline "_KUNCUserNotificationDisplayNotice" 
   ((timeout :signed-long)
    (flags :UInt32)
    (iconPath (:pointer :char))
    (soundPath (:pointer :char))
    (localizationPath (:pointer :char))
    (alertHeader (:pointer :char))
    (alertMessage (:pointer :char))
    (defaultButtonTitle (:pointer :char))
   )
   :signed-long
() )
; 
;  * ***BLOCKING*** alert call, returned int value corresponds to the
;  * pressed button, spin this off in a thread only, or expect your kext to block.
;  

(deftrap-inline "_KUNCUserNotificationDisplayAlert" 
   ((timeout :signed-long)
    (flags :UInt32)
    (iconPath (:pointer :char))
    (soundPath (:pointer :char))
    (localizationPath (:pointer :char))
    (alertHeader (:pointer :char))
    (alertMessage (:pointer :char))
    (defaultButtonTitle (:pointer :char))
    (alternateButtonTitle (:pointer :char))
    (otherButtonTitle (:pointer :char))
    (responseFlags (:pointer :UInt32))
   )
   :signed-long
() )
; 
;  * Execute a userland executable with the given path, user and type
;  
(defconstant $kOpenApplicationPath 0)
; #define kOpenApplicationPath 	0	/* essentially executes the path */
(defconstant $kOpenPreferencePanel 1)
; #define kOpenPreferencePanel    1	/* runs the preferences with the foo.preference opened.  foo.preference must exist in /System/Library/Preferences */
(defconstant $kOpenApplication 2)
; #define kOpenApplication	2	/* essentially runs /usr/bin/open on the passed in application name */
(defconstant $kOpenAppAsRoot 0)
; #define kOpenAppAsRoot		0
(defconstant $kOpenAppAsConsoleUser 1)
; #define kOpenAppAsConsoleUser	1 

(deftrap-inline "_KUNCExecute" 
   ((executionPath (:pointer :char))
    (openAsUser :signed-long)
    (pathExecutionType :signed-long)
   )
   :signed-long
() )
;  KUNC User Notification XML Keys
;  *
;  * These are the keys used in the xml plist file passed in to the
;  * KUNCUserNotitificationDisplayFrom* calls
;  *
;  * KUNC Notifications are completely dependent on CFUserNotifications in
;  * user land.  The same restrictions apply, including the number of text fields,
;  * types of information displayable, etc.
;  *
;  *  Key			Type
;  * Header			string (header displayed on dialog)
;  * Icon URL			string (url of the icon to display)
;  * Sound URL			string (url of the sound to play on display)
;  * Localization URL		string (url of bundle to retrieve localization
;  *				info from, using Localizable.strings files)
;  * Message			string (text of the message, can contain %@'s
;  *				which are filled from tokenString passed in) 
;  * OK Button Title 		string (title of the "main" button)
;  * Alternate Button Title 	string (title of the "alternate" button -
;  *				usually cancel)
;  * Other Button Title	 	string (title of the "other" button)
;  * Timeout			string (numeric, int - seconds until the dialog
;  *				goes away on it's own)
;  * Alert Level			string (Stop, Notice, Alert, 
;  * Blocking Message		string (numeric, 1 or 0 - if 1, the dialog will
;  *				have no buttons)
;  * Text Field Strings		array of strings (each becomes a text field)
;  * Password Fields		array of strings (numeric - each indicates a
;  *				pwd field)
;  * Popup Button Strings		array of strings (each entry becomes a popup
;  *				button string)
;  * Radio Button Strings		array of strings (each becomes a radio button)
;  * Check Box Strings		array of strings (each becomes a check box)
;  * Selected Radio		string (numeric - which radio is selected)
;  * Checked Boxes		array of strings (numeric - each indicates a
;  *				checked field)
;  * Selected Popup		string (numeric - which popup entry is selected)
;  
; 
;  * Bundle Calls
;  *
;  *	Arguments
;  *
;  *	bundleIdentifier
;  *		path to the actual bundle (not inside of it)
;  *	        (i.e. "/System/Library/Extensions/Foo.kext")
;  *		***NOTE***
;  *		This WILL change soon to expect the CFBundleIdentifier instead of a bundle path
;  *	fileName
;  *		filename in bundle to retrive the xml from (i.e. "Messages")
;  *	fileExtension 
;  *		if fileName has an extension, it goes here (i.e., "dict");
;  *	messageKey
;  *		name of the xml key in the dictionary in the file to retrieve
;  *		the info from (i.e., "Error Message")
;  *	tokenString
;  *		a string in the form of "foo@bar" where each element is
;  *		seperated by the @ character.  This string can be used to
;  *		replace values of the form %@ in the message key in the provided
;  *		dictionary in the xml plist
;  *	specialKey
;  *		user specified key for notification, use this to match return
;  *		values with your requested notification, this value is passed
;  *		back to the client in the callback pararmeter contextKey
;  

(def-mactype :KUNCUserNotificationID (find-mactype ':signed-long))
; 
;  * Reponse value checking & default setting
;  *
;  * The reponse value returned in the response Flags of the
;  * KUNCUserNotificationCallBack can be tested against the following
;  * enum and 2 defines to determine the state.
;  

(defconstant $kKUNCDefaultResponse 0)
(defconstant $kKUNCAlternateResponse 1)
(defconstant $kKUNCOtherResponse 2)
(defconstant $kKUNCCancelResponse 3)
; #define KUNCCheckBoxChecked(i)	(1 << (8 + i))   /* can be used for radio's too */
; #define KUNCPopUpSelection(n)	(n << 24)
; 
;  * Callback function for KUNCNotifications
;  

(def-mactype :KUNCUserNotificationCallBack (find-mactype ':pointer)); (int contextKey , int responseFlags , void * xmlData)
; 
;  * Get a notification ID
;  

(deftrap-inline "_KUNCGetNotificationID" 
   ((ARG2 (:NIL :NIL))
   )
   :signed-long
() )
;  This function currently requires a bundle path, which kexts cannot currently get.  In the future, the CFBundleIdentiofier of the kext will be pass in in place of the bundlePath. 

(deftrap-inline "_KUNCUserNotificationDisplayFromBundle" 
   ((notificationID :signed-long)
    (bundleIdentifier (:pointer :char))
    (fileName (:pointer :char))
    (fileExtension (:pointer :char))
    (messageKey (:pointer :char))
    (tokenString (:pointer :char))
    (callback :pointer)
    (contextKey :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_KUNCUserNotificationCancel" 
   ((notification :signed-long)
   )
   :signed-long
() )

; #endif  /* __USERNOTIFICATION_KUNCUSERNOTIFICATIONS_H */


(provide-interface "KUNCUserNotifications")