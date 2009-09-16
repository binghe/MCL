(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCNetworkReachability.h"
; at Sunday July 2,2006 7:31:36 pm.
; 
;  * Copyright (c) 2003 Apple Computer, Inc. All rights reserved.
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
; #ifndef _SCNETWORKREACHABILITY_H
; #define _SCNETWORKREACHABILITY_H

(require-interface "sys/cdefs")

(require-interface "sys/types")

(require-interface "sys/socket")

(require-interface "AvailabilityMacros")

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "SystemConfiguration/SCNetwork")
; !
; 	@header SCNetworkReachability
; 	The SCNetworkReachabilityXXX() APIs allow an application to determine the status
; 	of a system's current network configuration and the reachability
; 	of a target host.  In addition, the reachability can be monitored
; 	with a notification being provided when/if the status has changed.
; 
; 	The term "reachable" reflects whether a data packet, sent by
; 	an application into the network stack, can be sent to the
; 	the target host/address.  Please note that there is no
; 	guarantee that the data packet will actually be received by
; 	the host.
;  
; !
; 	@typedef SCNetworkReachabilityRef
; 	@discussion This is the handle to a network address/name.
;  

(def-mactype :SCNetworkReachabilityRef (find-mactype '(:pointer :__SCNetworkReachability))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@typedef SCNetworkReachabilityContext
;  
(defrecord SCNetworkReachabilityContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
                                                ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
)
; !
; 	@typedef SCNetworkReachabilityCallBack
; 	@discussion Type of the callback function used when the
; 		reachability of a network address/name changes.
; 	@param target The SCNetworkReachability reference being monitored for changes.
; 	@param flags The new SCNetworkConnectionFlags representing the
; 		reachability status of the network address/name.
; 	@param info ....
;  

(def-mactype :SCNetworkReachabilityCallBack (find-mactype ':pointer)); (SCNetworkReachabilityRef target , SCNetworkConnectionFlags flags , void * info)
; !
; 	@function SCNetworkReachabilityCreateWithAddress
; 	@discussion Creates a reference to the specified network
; 		address.  This reference can later be used to monitor
; 		the reachability of the target host.
; 	@param address The address of the desired host.
; 	@result A reference to the new immutable SCNetworkReachabilityRef.
; 
; 		 You must release the returned value.
;  

(deftrap-inline "_SCNetworkReachabilityCreateWithAddress" 
   ((allocator (:pointer :__CFAllocator))
    (address (:pointer :SOCKADDR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SCNetworkReachability)
() )
; !
; 	@function SCNetworkReachabilityCreateWithAddressPair
; 	@discussion Creates a reference to the specified network
; 		address.  This reference can later be used to monitor
; 		the reachability of the target host.
; 	@param localAddress The local address associated with a network
; 		connection.  If NULL, only the remote address is of interest.
; 	@param remoteAddress The remote address associated with a network
; 		connection.  If NULL, only the local address is of interest.
; 	@result A reference to the new immutable SCNetworkReachabilityRef.
; 
; 		 You must release the returned value.
;  

(deftrap-inline "_SCNetworkReachabilityCreateWithAddressPair" 
   ((allocator (:pointer :__CFAllocator))
    (localAddress (:pointer :SOCKADDR))
    (remoteAddress (:pointer :SOCKADDR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SCNetworkReachability)
() )
; !
; 	@function SCNetworkReachabilityCreateWithName
; 	@discussion Creates a reference to the specified network host/node
; 		name.  This reference can later be used to monitor the
; 		reachability of the target host.
; 	@param nodename The node name of the desired host. This name would
; 		be the same as that passed to gethostbyname() or getaddrinfo().
; 	@result A reference to the new immutable SCNetworkReachabilityRef.
; 
; 		You must release the returned value.
;  

(deftrap-inline "_SCNetworkReachabilityCreateWithName" 
   ((allocator (:pointer :__CFAllocator))
    (nodename (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__SCNetworkReachability)
() )
; !
; 	@function SCNetworkReachabilityGetTypeID
; 	Returns the type identifier of all SCNetworkReachability instances.
;  

(deftrap-inline "_SCNetworkReachabilityGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
; !
; 	@function SCNetworkReachabilityGetFlags
; 	@discussion Determines if the given target is reachable using the
; 		current network configuration.
; 	@param target The network reference associated with the address/name
; 		to be checked for reachability.
; 	@param flags A pointer to memory that will be filled with the
; 		SCNetworkConnectionFlags detailing the reachability
; 		of the specified target.
; 	@result TRUE if the network connection flags are valid; FALSE if the
; 		status could not be determined.
;  

(deftrap-inline "_SCNetworkReachabilityGetFlags" 
   ((target (:pointer :__SCNetworkReachability))
    (flags (:pointer :SCNETWORKCONNECTIONFLAGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; !
; 	@function SCNetworkReachabilitySetCallback
; 	@discussion Assigns a client to a target, which receives callbacks
; 		when the reachability of the target changes.
; 	@param target The network reference associated with the address/name
; 		to be checked for reachability.
; 	@param callout The function to be called when the reachability of
; 		target changes.  If NULL, the current client for the target
; 		is removed.
; 	@param context The SCNetworkReachabilityContext associated with
; 		the callout.
; 	@result TRUE if the notification client was successfully set.
;  

(deftrap-inline "_SCNetworkReachabilitySetCallback" 
   ((target (:pointer :__SCNetworkReachability))
    (callout :pointer)
    (context (:pointer :SCNETWORKREACHABILITYCONTEXT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; !
; 	@function SCNetworkReachabilityScheduleWithRunLoop
; 	@discussion Schedule the given target from the given run loop and mode.
; 	@param target The address/name which is set up for asynchronous mode.  Must be non-NULL.
; 	@param runLoop A reference to a runloop on which the target should be scheduled.  Must be non-NULL.
; 	@param runLoopMode The mode on which to schedule the target.  Must be non-NULL.
;  

(deftrap-inline "_SCNetworkReachabilityScheduleWithRunLoop" 
   ((target (:pointer :__SCNetworkReachability))
    (runLoop (:pointer :__CFRunLoop))
    (runLoopMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; !
; 	@function SCNetworkReachabilityUnscheduleFromRunLoop
; 	@discussion Unschedule the given target from the given run loop and mode.
; 	@param target The address/name which is set up for asynchronous mode.  Must be non-NULL.
; 	@param runLoop A reference to a runloop on which the target should be scheduled.  Must be non-NULL.
; 	@param runLoopMode The mode on which to schedule the target.  Must be non-NULL.
;  

(deftrap-inline "_SCNetworkReachabilityUnscheduleFromRunLoop" 
   ((target (:pointer :__SCNetworkReachability))
    (runLoop (:pointer :__CFRunLoop))
    (runLoopMode (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )

; #endif /* _SCNETWORKREACHABILITY_H */


(provide-interface "SCNetworkReachability")