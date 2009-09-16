(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCNetworkConnection.h"
; at Sunday July 2,2006 7:31:30 pm.
; 
;  * Copyright (c) 2002-2003 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _SCNETWORKCONNECTION_H
; #define _SCNETWORKCONNECTION_H

(require-interface "sys/cdefs")

(require-interface "sys/types")

(require-interface "sys/socket")

(require-interface "AvailabilityMacros")

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "SystemConfiguration/SystemConfiguration")
; !
; 	@header SCNetworkConnection
; 	The SCNetworkConnectionXXX() APIs allow an application to
; 	control connection oriented services defined in the system.
; 
; 	This is a set of control APIs only. Using these APIs, an
; 	application will be able to control existing services.
; 	To create, change, or remove services, SCPreferences APIs
; 	must be used.
; 
; 	Note: Currently only PPP services can be controlled.
;  
; !
; 	@typedef SCNetworkConnectionRef
; 	@discussion This is the handle to manage a connection oriented service.
;  

(def-mactype :SCNetworkConnectionRef (find-mactype '(:pointer :__SCNetworkConnection))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@typedef SCNetworkConnectionContext
;  
(defrecord SCNetworkConnectionContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
                                                ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
)
; !
; 	@enum SCNetworkConnectionStatus
; 	@discussion Status of the network connection.
; 		This status is intended to be generic and high level.
; 		An extended status, specific to the type of network
; 		connection is also available for applications that
; 		need additonal information.
; 
; 	@constant kSCNetworkConnectionInvalid
; 		The network connection refers to an invalid service.
; 
; 	@constant kSCNetworkConnectionDisconnected
; 		The network connection is disconnected.
; 
; 	@constant kSCNetworkConnectionConnecting
; 		The network connection is connecting.
; 
; 	@constant kSCNetworkConnectionConnected
; 		The network connection is connected.
; 
; 	@constant kSCNetworkConnectionDisconnecting
; 		The network connection is disconnecting.
;  

(defconstant $kSCNetworkConnectionInvalid -1)
(defconstant $kSCNetworkConnectionDisconnected 0)
(defconstant $kSCNetworkConnectionConnecting 1)
(defconstant $kSCNetworkConnectionConnected 2)
(defconstant $kSCNetworkConnectionDisconnecting 3)

(def-mactype :SCNetworkConnectionStatus (find-mactype ':SInt32)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@enum SCNetworkConnectionPPPStatus
; 	@discussion PPP specific status of the network connection.
; 		This status is PPP specific and returned as part of the extended information
; 		for a PPP service.
; 		Note: additional status might be returned in the future, and the application should
; 		be prepared to receive an unknown value.
; 
; 	@constant kSCNetworkConnectionPPPDisconnected
; 		PPP is disconnected.
; 
; 	@constant kSCNetworkConnectionPPPInitializing
; 		PPP is initializing.
; 
; 	@constant kSCNetworkConnectionPPPConnectingLink
; 		PPP is connecting the lower connection layer (for example, the modem is dialing out).
; 
; 	@constant kSCNetworkConnectionPPPDialOnTraffic
; 		PPP is waiting for networking traffic to automatically establish the connection.
; 
; 	@constant kSCNetworkConnectionPPPNegotiatingLink
; 		PPP lower layer is connected and PPP is negotiating the link layer (LCP protocol).
; 
; 	@constant kSCNetworkConnectionPPPAuthenticating
; 		PPP is authenticating to the server (PAP, CHAP, MS-CHAP or EAP protocols).
; 
; 	@constant kSCNetworkConnectionPPPWaitingForCallBack
; 		PPP is waiting for server to call back.
; 
; 	@constant kSCNetworkConnectionPPPNegotiatingNetwork
; 		PPP is now authenticated and negotiating the networking layer (IPCP or IPv6CP protocols)
; 
; 	@constant kSCNetworkConnectionPPPConnected
; 		PPP is now fully connected for at least one of the networking layer.
; 		Additional networking protocol might still be negotiating.
; 
; 	@constant kSCNetworkConnectionPPPTerminating
; 		PPP networking and link protocols are terminating.
; 
; 	@constant kSCNetworkConnectionPPPDisconnectingLink
; 		PPP is disconnecting the lower level (for example, the modem is hanging up).
; 
; 	@constant kSCNetworkConnectionPPPHoldingLinkOff
; 		PPP is disconnected and maintaining the link temporarily off.
; 
; 	@constant kSCNetworkConnectionPPPSuspended
; 		PPP is suspended as a result of the suspend command (for example, when a V92 Modem is On Hold).
; 
; 	@constant kSCNetworkConnectionPPPWaitingForRedial
; 		PPP has found a busy server and is waiting for redial.
;  

(defconstant $kSCNetworkConnectionPPPDisconnected 0)
(defconstant $kSCNetworkConnectionPPPInitializing 1)
(defconstant $kSCNetworkConnectionPPPConnectingLink 2)
(defconstant $kSCNetworkConnectionPPPDialOnTraffic 3)
(defconstant $kSCNetworkConnectionPPPNegotiatingLink 4)
(defconstant $kSCNetworkConnectionPPPAuthenticating 5)
(defconstant $kSCNetworkConnectionPPPWaitingForCallBack 6)
(defconstant $kSCNetworkConnectionPPPNegotiatingNetwork 7)
(defconstant $kSCNetworkConnectionPPPConnected 8)
(defconstant $kSCNetworkConnectionPPPTerminating 9)
(defconstant $kSCNetworkConnectionPPPDisconnectingLink 10)
(defconstant $kSCNetworkConnectionPPPHoldingLinkOff 11)
(defconstant $kSCNetworkConnectionPPPSuspended 12)
(defconstant $kSCNetworkConnectionPPPWaitingForRedial 13)

(def-mactype :SCNetworkConnectionPPPStatus (find-mactype ':SInt32)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@typedef SCNetworkConnectionCallBack
; 	@discussion Type of the callback function used when a
; 		status event is delivered.
; 	@param status The connection status.
; 	@param connection The connection reference.
; 	@param info ....
;  

(def-mactype :SCNetworkConnectionCallBack (find-mactype ':pointer)); (SCNetworkConnectionRef connection , SCNetworkConnectionStatus status , void * info)
; 
;     Keys for the statistics dictionary
; 
; #define kSCNetworkConnectionBytesIn		CFSTR("BytesIn")		/* CFNumber */
; #define kSCNetworkConnectionBytesOut		CFSTR("BytesOut")		/* CFNumber */
; #define kSCNetworkConnectionPacketsIn		CFSTR("PacketsIn")		/* CFNumber */
; #define kSCNetworkConnectionPacketsOut		CFSTR("PacketsOut")		/* CFNumber */
; #define kSCNetworkConnectionErrorsIn		CFSTR("ErrorsIn")		/* CFNumber */
; #define kSCNetworkConnectionErrorsOut		CFSTR("ErrorsOut")		/* CFNumber */
; !
; 	@function SCDynamicStoreGetTypeID
; 	Returns the type identifier of all SCNetworkConnection instances.
;  

(deftrap-inline "_SCNetworkConnectionGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; !
;     @function SCNetworkConnectionCopyUserPreferences
; 	@discussion Provides the default serviceID and a userOptions dictionary for the connection.
; 		Applications can use the serviceID and userOptions returned to open a connection on the fly.
; 	@param selectionOptions Currently unimplemented. Pass NULL for this version.
; 	@param serviceID Reference to the default serviceID for starting connections,
; 		this value will be returned by the function.
; 	@param userOptions Reference to default userOptions for starting connections,
; 		this will be returned by the function.
; 	@result TRUE if there is a valid service to dial.
; 		FALSE if function was unable to retrieve a service to dial.
;  

(deftrap-inline "_SCNetworkConnectionCopyUserPreferences" 
   ((selectionOptions (:pointer :__CFDictionary))
    (serviceID (:pointer :CFStringRef))
    (userOptions (:pointer :CFDictionaryRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; !
; 	@function SCNetworkConnectionCreateWithServiceID
; 	@discussion Creates a new connection reference to use for getting the status,
; 		for connecting or for disconnecting the associated service.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the connection structure.
; 		This parameter may be NULL in which case the current
; 		default CFAllocator is used. If this reference is not
; 		a valid CFAllocator, the behavior is undefined.
; 	@param serviceID A string that defines the service identifier
; 		of the connection. Service identifiers uniquely identify
; 		services in the system configuration database.
; 	@param callout The function to be called when the status
; 		of the connection changes.
; 		If this parameter is NULL, the application will not receive
; 		change of status notifications and will need to poll for updates.
; 	@param context The SCNetworkConnectionContext associated with the callout.
; 	@result A reference to the new SCNetworkConnection.
;  

(deftrap-inline "_SCNetworkConnectionCreateWithServiceID" 
   ((allocator (:pointer :__CFAllocator))
    (serviceID (:pointer :__CFString))
    (callout :pointer)
    (context (:pointer :SCNETWORKCONNECTIONCONTEXT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SCNetworkConnection)
() )
; !
; 	@function SCNetworkConnectionCopyService
; 	@discussion Returns the service ID associated with the SCNetworkConnection.
; 	@param connection The SCNetworkConnection to obtained status from.
; 	Returns the service ID associated with the SCNetworkConnection.
;  

(deftrap-inline "_SCNetworkConnectionCopyServiceID" 
   ((connection (:pointer :__SCNetworkConnection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
; !
; 	@function SCNetworkConnectionGetStatus
; 	@discussion Returns the status of the SCNetworkConnection.
; 		A status is one of the following values :
; 		    kSCNetworkConnectionInvalid
; 		    kSCNetworkConnectionDisconnected
; 		    kSCNetworkConnectionConnecting
; 		    kSCNetworkConnectionDisconnecting
; 		    kSCNetworkConnectionConnected
; 
; 	@param connection The SCNetworkConnection to obtain status from.
; 	@result The status value.
; 

(deftrap-inline "_SCNetworkConnectionGetStatus" 
   ((connection (:pointer :__SCNetworkConnection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
; !
; 	@function SCNetworkConnectionCopyExtendedStatus
; 	@discussion Returns the extended status of the connection.
; 		An extended status dictionary contains specific dictionaries
; 		describing the status for each subcomponent of the service.
; 
; 		For example, a status dictionary will contain the following dictionaries:
; 
; 		IPv4:
; 		    IPaddress: IP address used.
; 
; 		PPP:
; 		    Status: PPP specific status of type SCNetworkConnectionPPPStatus.
; 		    LastCause: Available when status is Disconnected.
; 				Contains the last error of disconnection.
; 		    ConnectTime: time when the connection happened
; 		    MaxTime: maximum time for this connection
; 
; 		Modem:
; 		    ConnectionSpeed:   Speed of the modem connection in bits/s
; 
; 		Other dictionaries could be present for PPPoE, PPTP and L2TP.
; 
; 		The status dictionary can be extended as needed in the future
; 		to contain additional information.
; 
; 	@param connection The SCNetworkConnection to obtain status from.
; 	@result The status dictionary.
; 		If NULL is returned, the error can be retrieved with SCError().
;  

(deftrap-inline "_SCNetworkConnectionCopyExtendedStatus" 
   ((connection (:pointer :__SCNetworkConnection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFDictionary)
() )
; !
; 	@function SCNetworkConnectionCopyStatistics
; 	@discussion Returns the statistics of the SCNetworkConnection.
; 		A statistic dictionary contains specific dictionaries
; 		with statistics for each subcomponents of the service.
; 
; 		For example, a statistic dictionary will contain the following dictionaries:
; 
; 		PPP: {Bytes,Packets,Errors}{In,Out}:
; 		    Statistics at the Network level.
; 		    Contains the number of bytes, packets, and errors on the PPP interface.
; 		    For example, BytesIn contains the number of bytes going up
; 		    into the network stack, for any networking protocol,
; 		    without the PPP headers and trailers.
; 
; 		The statistic dictionary can be extended as needed in the future
; 		to contain additional information.
; 
; 	@param connection The SCNetworkConnection to obtained statistics from.
; 	@result The statistics dictionary.
; 		If NULL is returned, the error can be retrieved with SCError().
;  

(deftrap-inline "_SCNetworkConnectionCopyStatistics" 
   ((connection (:pointer :__SCNetworkConnection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFDictionary)
() )
; !
; 	@function SCNetworkConnectionStart
; 	@discussion Start the connection for the SCNetworkConnection.
; 		The connection process is asynchronous and the function will
; 		return immediately. The connection status can be obtain by polling or
; 		by callback.
; 		The connection is done with the default settings from the administrator.
; 		Some of the settings can be overridden for the duration of
; 		the connection. They are given in an option dictionary.
; 		The options dictionary is in the format of a Network Service
; 		as described in SystemConfiguration.
; 
; 		Note: Starting and stopping of connections is implicitely arbitrated.
; 		Calling Start on a connection already started will indicate
; 		that the application has interest in the connection and it shouldn't
; 		be stopped by anyone else.
; 
; 	@param connection The SCNetworkConnection to start.
; 	@param userOptions The options dictionary to start the connection with.
; 		If userOptions is NULL, the default settings will be used.
; 		If userOptions are specified, they must be in the SystemConfiguration format.
; 		The options will override the default settings defined for the service.
; 
; 		For security reasons, not all the options can be overridden, the appropriate merging
; 		of all the settings will be done before the connection is established,
; 		and inappropriate options will be ignored.
; 
; 	@param linger This parameter indicates whether or not the connection can stay around
; 		when the application no longer has interest in it.
; 		Typical application should pass FALSE, and the Stop function will
; 		automatically be called when the reference is released or if the application quits.
; 		If the application passes TRUE, the application can release the reference
; 		or exit and the Stop function will not be called.
; 
; 	@result TRUE if the connection was correctly started. The actual connection is not established yet,
; 		and the connection status needs to be periodically checked.
; 		FALSE if the connection request didn't start. Error must be taken
; 		from SCError().
;  

(deftrap-inline "_SCNetworkConnectionStart" 
   ((connection (:pointer :__SCNetworkConnection))
    (userOptions (:pointer :__CFDictionary))
    (linger :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; !
; 	@function SCNetworkConnectionStop
; 	@discussion Stop the connection for the SCNetworkConnection.
; 		The disconnection process is asynchronous and the function will
; 		return immediately. The connection status can be obtain by polling or
; 		by callback.
; 		This function performs an arbitrated stop of the connection.
; 		If several applications have marked their interest in the connection,
; 		by calling SCNetworkConnectionStart, the call will succeed but the the actual
; 		connection will be maintained until the last interested application calls stop.
; 
; 		In certain cases, you might want to stop the connection anyway, and
; 		SCNetworkConnectionStop with forceDisconnect argument can be used.
; 
; 	@param connection The SCNetworkConnection to stop.
; 	@result TRUE if the disconnection request succeeded.
; 		FALSE if the disconnection request failed. Error must be taken from SCError().
;  

(deftrap-inline "_SCNetworkConnectionStop" 
   ((connection (:pointer :__SCNetworkConnection))
    (forceDisconnect :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; !
; 	@function SCNetworkConnectionCopyCurrentOptions
; 	@discussion Copy the user options used to start the connection.
; 		This is a mechanism for a client to retrieve the user options
; 		previously passed to the SCNetworkConnectionStart function.
; 	@param connection The SCNetworkConnection to obtain options from.
; 	@result The service dictionary containing the connection options.
; 		The dictionary can be empty if no user options were used.
; 		If NULL is returned, the error can be retrieved with SCError().
;  

(deftrap-inline "_SCNetworkConnectionCopyUserOptions" 
   ((connection (:pointer :__SCNetworkConnection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFDictionary)
() )
; !
; 	@function SCNetworkConnectionScheduleWithRunLoop
; 	@discussion Schedule a connection with the Run Loop.
; 	@param connection The SCNetworkConnection to schedule.
; 	@param runLoop The runloop to schedule with.
; 	@param runLoopMode The runloop mode.
; 	@result TRUE if success.
; 		FALSE if failed. The error can be retrieved with SCError().
;  

(deftrap-inline "_SCNetworkConnectionScheduleWithRunLoop" 
   ((connection (:pointer :__SCNetworkConnection))
    (runLoop (:pointer :__CFRunLoop))
    (runLoopMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; !
; 	@function SCNetworkConnectionUnscheduleFromRunLoop
; 	@discussion Unschedule a connection from the Run Loop.
; 	@param connection The SCNetworkConnection to unschedule.
; 	@param runLoop The runloop to unschedule from.
; 	@param runLoopMode The runloop mode.
; 	@result TRUE if success.
; 		FALSE if failed. The error can be retrieved with SCError().
;  

(deftrap-inline "_SCNetworkConnectionUnscheduleFromRunLoop" 
   ((connection (:pointer :__SCNetworkConnection))
    (runLoop (:pointer :__CFRunLoop))
    (runLoopMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )

; #endif /* _SCNETWORKCONNECTION_H */


(provide-interface "SCNetworkConnection")