(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFireWireLibIsoch.h"
; at Sunday July 2,2006 7:29:03 pm.
; 
;  * Copyright (c) 1998-2002 Apple Computer, Inc. All rights reserved.
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
; 
;  *  IOFireWireLibIsoch.h
;  *  IOFireWireFamily
;  *
;  *  Created on Mon Mar 19 2001.
;  *  Copyright (c) 2001-2002 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __IOFireWireLibIsoch_H__
; #define __IOFireWireLibIsoch_H__

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "IOKit/IOCFPlugIn")

(require-interface "IOKit/firewire/IOFireWireFamilyCommon")

(require-interface "IOKit/firewire/IOFireWireLib")
; 
;  local isoch port
; 
; 	uuid string: 541971C6-CE72-11D7-809D-000393C0B9D8
; #define kIOFireWireLocalIsochPortInterfaceID_v5 CFUUIDGetConstantUUIDWithBytes( kCFAllocatorDefault 											, 0x54, 0x19, 0x71, 0xC6, 0xCE, 0x72, 0x11, 0xD7											, 0x80, 0x9D, 0x00, 0x03, 0x93, 0xC0, 0xB9, 0xD8 )
; 	uuid string: FECAA2F6-4E84-11D7-B6FD-0003938BEB0A
; #define kIOFireWireLocalIsochPortInterfaceID_v4 CFUUIDGetConstantUUIDWithBytes( kCFAllocatorDefault 											,0xFE, 0xCA, 0xA2, 0xF6, 0x4E, 0x84, 0x11, 0xD7											,0xB6, 0xFD, 0x00, 0x03, 0x93, 0x8B, 0xEB, 0x0A )
;   uuid string: A0AD095E-6D2F-11D6-AC82-0003933F84F0
; #define kIOFireWireLocalIsochPortInterfaceID_v3 CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,											0xA0, 0xAD, 0x09, 0x5E, 0x6D, 0x2F, 0x11, 0xD6,											0xAC, 0x82, 0x00, 0x03, 0x93, 0x3F, 0x84, 0xF0 )
; 	Availability: Mac OS X "Jaguar" and later
;   uuid string: 73C76D09-6D2F-11D6-AF7F-0003933F84F0
; #define kIOFireWireLocalIsochPortInterfaceID_v2 CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,											0x73, 0xC7, 0x6D, 0x09, 0x6D, 0x2F, 0x11, 0xD6,											0xAF, 0x7F, 0x00, 0x03, 0x93, 0x3F, 0x84, 0xF0 )
;   uuid string: 0F5E33C8-1350-11D5-9BE7-003065AF75CC
; #define kIOFireWireLocalIsochPortInterfaceID CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,											0x0F, 0x5E, 0x33, 0xC8, 0x13, 0x50, 0x11, 0xD5,											0x9B, 0xE7, 0x00, 0x30, 0x65, 0xAF, 0x75, 0xCC)
; 
;  remote isoch port
; 
; 	uuid string: AAFDBDB0-489F-11D5-BC9B-003065423456
; #define kIOFireWireRemoteIsochPortInterfaceID CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,											0xAA, 0xFD, 0xBD, 0xB0, 0x48, 0x9F, 0x11, 0xD5,											0xBC, 0x9B, 0x00, 0x30, 0x65, 0x42, 0x34, 0x56)
; 
;  isoch channel
; 
;   uuid string: 2EC1E404-1350-11D5-89B5-003065AF75CC
; #define kIOFireWireIsochChannelInterfaceID CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,											0x2E, 0xC1, 0xE4, 0x04, 0x13, 0x50, 0x11, 0xD5,											0x89, 0xB5, 0x00, 0x30, 0x65, 0xAF, 0x75, 0xCC)
; 
;  DCL command pool
; 
;   uuid string: 4A4B1710-1350-11D5-9B12-003065AF75CC
; #define kIOFireWireDCLCommandPoolInterfaceID CFUUIDGetConstantUUIDWithBytes(kCFAllocatorDefault,											0x4A, 0x4B, 0x17, 0x10, 0x13, 0x50, 0x11, 0xD5,											0x9B, 0x12, 0x00, 0x30, 0x65, 0xAF, 0x75, 0xCC)
; 
;  NuDCL pool
; 
; 	uuid string: D3837670-4463-11D7-B79A-0003938BEB0A
; #define kIOFireWireNuDCLPoolInterfaceID CFUUIDGetConstantUUIDWithBytes( kCFAllocatorDefault,											0xD3, 0x83, 0x76, 0x70, 0x44, 0x63, 0x11, 0xD7,											0xB7, 0x9A, 0x00, 0x03, 0x93, 0x8B, 0xEB, 0x0A)

(def-mactype :IOFireWireIsochChannelForceStopHandler (find-mactype ':pointer)); (IOFireWireLibIsochChannelRef interface , UInt32 stopCondition)

(def-mactype :IOFireWireLibIsochPortCallback (find-mactype ':pointer)); (IOFireWireLibIsochPortRef interface)

(def-mactype :IOFireWireLibIsochPortAllocateCallback (find-mactype ':pointer)); (IOFireWireLibIsochPortRef interface , IOFWSpeed maxSpeed , UInt32 channel)

(def-mactype :IOFireWireLibIsochPortGetSupportedCallback (find-mactype ':pointer)); (IOFireWireLibIsochPortRef interface , IOFWSpeed * outMaxSpeed , UInt64 * outChanSupported)

(def-mactype :IOFireWireLibIsochPortFinalizeCallback (find-mactype ':pointer)); (void * refcon)
;  ============================================================
; 
;  IOFireWireIsochPort
; 
;  ============================================================
; #define IOFIREWIRELIBISOCHPORT_C_GUTS		IOReturn	(*GetSupported)	( IOFireWireLibIsochPortRef self, IOFWSpeed* maxSpeed, UInt64* chanSupported ) ;		IOReturn	(*AllocatePort)	( IOFireWireLibIsochPortRef self, IOFWSpeed speed, UInt32 chan ) ;		IOReturn 	(*ReleasePort)	( IOFireWireLibIsochPortRef self ) ;		IOReturn	(*Start)		( IOFireWireLibIsochPortRef self ) ;		IOReturn	(*Stop)			( IOFireWireLibIsochPortRef self ) ;		void 		(*SetRefCon)	( IOFireWireLibIsochPortRef self, void* inRefCon) ;		void*		(*GetRefCon)	( IOFireWireLibIsochPortRef self)

; #if HEADERDOC_COMMENT_ONLY
#|                                              ;  this class declaration is for headerdoc purposes only...
;  these methods are actually specified in a macro inserted into port subclass
;  COM interface structs
; !	@class IOFireWireIsochPortInterface
; 		@abstract FireWire user client isochronous port interface
; 		@discussion Isochronous ports represent talkers or listeners on an
; 			FireWire isochronous channel. This is a base class containing all
; 			isochronous port functionality not specific to any type of port.
; 			Ports are added to channel interfaces
; 			(IOFireWireIsochChannelInterface) which coordinate the start and
; 			stop of isochronous traffic on a FireWire bus isochronous channel.
; 			
#|
 confused about CLASS IOFireWireIsochPortInterface #\{
; !	@function GetSupported
; 		@abstract The method is called to determine which FireWire isochronous
; 			channels and speed this port supports.
; 		@discussion This method is called by the channel object to which a port
; 			has been added. Subclasses of IOFireWireIsochPortInterface override
; 			this method to support specific hardware. Do not call this method
; 			directly.
; 		@param self The isoch port interface to use.
; 		@param maxSpeed A pointer to an IOFWSpeed which should be filled with
; 			the maximum speed this port can talk or listen.
; 		@param chanSupported A pointer to a UInt64 which should be filled with
; 			a bitmask representing the FireWire bus isochonous channels on
; 			which the port can talk or listen. Set '1' for supported, '0' for
; 			unsupported.
; 		@result Return kIOReturnSuccess on success, other return any other
; 			IOReturn error code.
 IOReturn #\( * GetSupported #\) #\( IOFireWireLibIsochPortRef self #\, IOFWSpeed * maxSpeed #\, UInt64 * chanSupported #\) #\;
; !	@function AllocatePort
; 		@abstract The method is called when the port should configure its
; 			associated hardware to prepare to send or receive isochronous data
; 			on the channel number and at the speed specified.
; 		@discussion This method is called by the channel object to which a port
; 			has been added. Subclasses of IOFireWireIsochPortInterface override
; 			this method to support specific hardware. Do not call this method
; 			directly.
; 		@param self The isoch port interface to use.
; 		@param speed Channel speed
; 		@param chan Channel number (0-63)
; 		@result Return kIOReturnSuccess on success, other return any other
; 			IOReturn error code.
 IOReturn #\( * AllocatePort #\) #\( IOFireWireLibIsochPortRef self #\, IOFWSpeed speed #\, UInt32 chan #\) #\;
; !	@function ReleasePort
; 		@abstract The method is called to release the hardware after the
; 			channel has been stopped.
; 		@discussion This method is called by the channel object to which a port
; 			has been added. Subclasses of IOFireWireIsochPortInterface override
; 			this method to support specific hardware. Do not call this method
; 			directly.
; 		@param self The isoch port interface to use.
; 		@result Return kIOReturnSuccess on success, other return any other IOReturn error code.
 IOReturn #\( * ReleasePort #\) #\( IOFireWireLibIsochPortRef self #\) #\;
; !	@function Start
; 		@abstract The method is called when the port is to begin talking or listening.
; 		@discussion This method is called by the channel object to which a port
; 			has been added. Subclasses of IOFireWireIsochPortInterface override
; 			this method to support specific hardware. Do not call this method
; 			directly.
; 		@param self The isoch port interface to use.
; 		@result Return kIOReturnSuccess on success, other return any other IOReturn error code.
 IOReturn #\( * Start #\) #\( IOFireWireLibIsochPortRef self #\) #\;
; !	@function Stop
; 		@abstract The method is called when the port is to stop talking or listening.
; 		@discussion This method is called by the channel object to which a port
; 			has been added. Subclasses of IOFireWireIsochPortInterface override
; 			this method to support specific hardware. Do not call this method
; 			directly.
; 		@param self The isoch port interface to use.
; 		@result Return kIOReturnSuccess on success, other return any
; 			other IOReturn error code.
 IOReturn #\( * Stop #\) #\( IOFireWireLibIsochPortRef self #\) #\;
; !	@function SetRefCon
; 		@abstract Set reference value associated with this port.
; 		@discussion Retrieve the reference value with GetRefCon()
; 		@param self The isoch port interface to use.
; 		@param inRefCon The new reference value.
 void #\( * SetRefCon #\) #\( IOFireWireLibIsochPortRef self #\, void * inRefCon #\) #\;
; !	@function GetRefCon
; 		@abstract Get reference value associated with this port.
; 		@discussion Set the reference value with SetRefCon()
; 		@param self The isoch port interface to use.
; 		@result The port refcon value.
 void * #\( * GetRefCon #\) #\( IOFireWireLibIsochPortRef self #\)
|#
 |#

; #endif

(defrecord IOFireWireIsochPortInterface_t
#|
   (NIL :iunknown_c_guts)|#
   (revision :UInt32)
   (version :UInt32)#|
   (NIL :iofirewirelibisochport_c_guts)|#
)
(%define-record :IOFireWireIsochPortInterface (find-record-descriptor :IOFIREWIREISOCHPORTINTERFACE_T))
(defrecord IOFireWireRemoteIsochPortInterface_t
#|
   (NIL :iunknown_c_guts)|#
   (revision :UInt32)
   (version :UInt32)#|
   (NIL :iofirewirelibisochport_c_guts)|#
   (SetGetSupportedHandler (:pointer :callback));(IOFireWireLibIsochPortGetSupportedCallback (IOFireWireLibRemoteIsochPortRef self , IOFireWireLibIsochPortGetSupportedCallback inHandler))
   (SetAllocatePortHandler (:pointer :callback));(IOFireWireLibIsochPortAllocateCallback (IOFireWireLibRemoteIsochPortRef self , IOFireWireLibIsochPortAllocateCallback inHandler))
   (SetReleasePortHandler (:pointer :callback)) ;(IOFireWireLibIsochPortCallback (IOFireWireLibRemoteIsochPortRef self , IOFireWireLibIsochPortCallback inHandler))
   (SetStartHandler (:pointer :callback))       ;(IOFireWireLibIsochPortCallback (IOFireWireLibRemoteIsochPortRef self , IOFireWireLibIsochPortCallback inHandler))
   (SetStopHandler (:pointer :callback))        ;(IOFireWireLibIsochPortCallback (IOFireWireLibRemoteIsochPortRef self , IOFireWireLibIsochPortCallback inHandler))
)
(%define-record :IOFireWireRemoteIsochPortInterface (find-record-descriptor :IOFIREWIREREMOTEISOCHPORTINTERFACE_T))
(defrecord IOFireWireLocalIsochPortInterface_t
                                                ; !	@class IOFireWireLocalIsochPortInterface
; 	@abstract FireWire user client local isochronous port object.
; 	@discussion Represents a FireWire isochronous talker or listener
; 		within the local machine. Isochronous transfer is controlled by
; 		an associated DCL (Data Stream Control Language) program, which
; 		is similar to a hardware DMA program but is hardware agnostic.
; 		DCL programs can be written using the
; 		IOFireWireDCLCommandPoolInterface object.
; 
; 	This interface contains all methods of IOFireWireIsochPortInterface
; 		and IOFireWireLocalIsochPortInterface. This interface will
; 		contain all v2 methods of IOFireWireLocalIsochPortInterface when
; 		instantiated as v2 or newer. 
                                                ;  headerdoc parse workaround	
; class IOFireWireLocalIsochPortInterface {
; public:
; 
#|
   (NIL :iunknown_c_guts)|#
   (revision :UInt32)
   (version :UInt32)#|
   (NIL :iofirewirelibisochport_c_guts)|#
                                                ; !	@function ModifyJumpDCL
; 		@abstract Change the jump target label of a jump DCL.
; 		@discussion Use this function to change the flow of a DCL
; 			program. Works whether the DCL program is currently running
; 			or not.
; 		@param self The local isoch port interface to use.
; 		@param inJump The jump DCL to modify.
; 		@param inLabel The label to jump to.
; 		@result kIOReturnSuccess on success. Will return an error if 'inJump'
; 			does not point to a valid jump DCL or 'inLabel' does not point to a
; 			valid label DCL.
   (ModifyJumpDCL (:pointer :callback))         ;(IOReturn (IOFireWireLibLocalIsochPortRef self , DCLJump * inJump , DCLLabel * inLabel))
                                                ;  --- utility functions ----------
                                                ; !	@function PrintDCLProgram
; 		@abstract Display the contents of a DCL program.
; 		@param self The local isoch port interface to use.
; 		@param inProgram A pointer to the first DCL of the program to display.
; 		@param inLength The length (in DCLs) of the program.
   (PrintDCLProgram (:pointer :callback))       ;(void (IOFireWireLibLocalIsochPortRef self , const DCLCommand * inProgram , UInt32 inLength))
                                                ; 
                                                ;  --- v2
                                                ; 
                                                ; !	@function ModifyTransferPacketDCLSize
; 		@abstract Modify the transfer size of a transfer packet DCL (send or
; 			receive)
; 		@discussion Allows you to modify transfer packet DCLs after they have
; 			been compiled and while the DCL program is still running. The
; 			transfer size can be set to any size less than or equal to the size
; 			set when the DCL program was compiled (including 0).
; 
; 		Availability: IOFireWireLocalIsochPortInterface_v2 and newer.
; 
; 		@param self The local isoch port interface to use.
; 		@param inDCL A pointer to the DCL to modify.
; 		@param size The new size of data to be transferred.
; 		@result Returns kIOReturnSuccess on success. Will return an
; 			error if 'size' is too large for this program.
   (ModifyTransferPacketDCLSize (:pointer :callback));(IOReturn (IOFireWireLibLocalIsochPortRef self , DCLTransferPacket * inDCL , IOByteCount size))
                                                ; 
                                                ;  --- v3
                                                ; 
                                                ; !	@function ModifyTransferPacketDCLBuffer
; 		@abstract NOT IMPLEMENTED. Modify the transfer size of a
; 			transfer packet DCL (send or receive)
; 		@discussion NOT IMPLEMENTED. Allows you to modify transfer packet DCLs
; 			after they have been compiled and while the DCL program is still
; 			running. The buffer can be set to be any location within the range
; 			of buffers specified when the DCL program was compiled (including
; 			0).
; 
; 		Availability: IOFireWireLocalIsochPortInterface_v3 and newer.
; 
; 		@param self The local isoch port interface to use.
; 		@param inDCL A pointer to the DCL to modify.
; 		@param buffer The new buffer to or from data will be transferred.
; 		@result Returns kIOReturnSuccess on success. Will return an
; 			error if the range specified by [buffer, buffer+size] is not
; 			in the range of memory locked down for this program.
   (ModifyTransferPacketDCLBuffer (:pointer :callback));(IOReturn (IOFireWireLibLocalIsochPortRef self , DCLTransferPacket * inDCL , void * buffer))
                                                ; !	@function ModifyTransferPacketDCL
; 		@abstract Modify the transfer size of a transfer packet DCL (send or receive)
; 		@discussion Allows you to modify transfer packet DCLs after they
; 			have been compiled and while the DCL program is still
; 			running. The transfer size can be set to any size less than
; 			or equal to the size set when the DCL program was compiled
; 			(including 0).
; 			
; 			Availability: IOFireWireLocalIsochPortInterface_v3 and newer.
; 			
; 		@param self The local isoch port interface to use.
; 		@param inDCL A pointer to the DCL to modify.
; 		@param buffer The new buffer to or from data will be transferred.
; 		@param size The new size of data to be transferred.
; 		@result Returns kIOReturnSuccess on success. Will return an
; 			error if 'size' is too large or 'inDCL' does not point to a
; 			valid transfer packet DCL, or the range specified by
; 			[buffer, buffer+size] is not in the range of memory locked
; 			down for this program.
   (ModifyTransferPacketDCL (:pointer :callback));(IOReturn (IOFireWireLibLocalIsochPortRef self , DCLTransferPacket * inDCL , void * buffer , IOByteCount size))
                                                ; 
                                                ;  v4
                                                ;  
                                                ; !	@function SetFinalizeCallback
; 		@abstract Set the finalize callback for a local isoch port
; 		@discussion When Stop() is called on a LocalIsochPortInterface, there may or
; 			may not be isoch callbacks still pending for this isoch port. The port must be allowed
; 			to handle any pending callbacks, so the isoch runloop should not be stopped until a port 
; 			has handled all pending callbacks. The finalize callback is called after the final 
; 			callback has been made on the isoch runloop. After this callback is sent, it is safe
; 			to stop the isoch runloop.
; 			
; 			You should not access the isoch port after the finalize callback has been made; it may
; 			be released immediately after this callback is sent.
; 						
; 			Availability: IOFireWireLocalIsochPortInterface_v4 and newer.
; 			
; 		@param self The local isoch port interface to use.
; 		@param finalizeCalback The finalize callback.
; 		@result Returns true if this isoch port has no more pending callbacks and does not
; 			need any more runloop time.
   (SetFinalizeCallback (:pointer :callback))   ;(IOReturn (IOFireWireLibLocalIsochPortRef self , IOFireWireLibIsochPortFinalizeCallback finalizeCallback))
                                                ; 
                                                ;  v5
                                                ; 
   (SetResourceUsageFlags (:pointer :callback)) ;(IOReturn (IOFireWireLibLocalIsochPortRef self , IOFWIsochResourceFlags flags))
   (Notify (:pointer :callback))                ;(IOReturn (IOFireWireLibLocalIsochPortRef self , IOFWDCLNotificationType notificationType , void ** inDCLList , UInt32 numDCLs))
)
(%define-record :IOFireWireLocalIsochPortInterface (find-record-descriptor :IOFIREWIRELOCALISOCHPORTINTERFACE_T))
;  ============================================================
; 
;  IOFireWireIsochChannelInterface
; 
;  ============================================================
(defrecord IOFireWireIsochChannelInterface_t
                                                ; !	@class IOFireWireIsochChannelInterface
; 		@abstract FireWire user client isochronous channel object.
; 		@discussion IOFireWireIsochChannelInterface is an abstract
; 			representataion of a FireWire bus isochronous channel. This
; 			interface coordinates starting and stopping traffic on a
; 			FireWire bus isochronous channel and can optionally
; 			communicate with the IRM to automatically allocate bandwidth
; 			and channel numbers. When using automatic IRM allocation,
; 			the channel interface reallocates its bandwidth and channel
; 			reservation after each bus reset.
; 
; 		Isochronous port interfaces representing FireWire isochronous talkers
; 			and listeners must be added to the channel using SetTalker() and
; 			AddListener()
; 	
                                                ;  headerdoc parse workaround	
; class IOFireWireLocalIsochPortInterface: public IUnknown {
; public:
; 
#|
   (NIL :iunknown_c_guts)|#
   (revision :UInt32)
   (version :UInt32)                            ; !	@function SetTalker
; 		@abstract Set the talker port for this channel.
; 		@param self The isoch channel interface to use.
; 		@param talker The new talker.
; 		@result Returns an IOReturn error code. 
   (SetTalker (:pointer :callback))             ;(IOReturn (IOFireWireLibIsochChannelRef self , IOFireWireLibIsochPortRef talker))
                                                ; !	@function AddListener
; 		@abstract Modify the transfer size of a transfer packet DCL (send or receive)
; 		@discussion Allows you to modify transfer packet DCLs after they have
; 			been compiled and while the DCL program is still running. The
; 			transfer size can be set to any size less than or equal to the size
; 			set when the DCL program was compiled (including 0).
; 
; 		Availability: IOFireWireLocalIsochPortInterface_v3 and newer.
; 
; 		@param self The isoch channel interface to use.
; 		@param listener The listener to add.
; 		@result Returns an IOReturn error code. 
   (AddListener (:pointer :callback))           ;(IOReturn (IOFireWireLibIsochChannelRef self , IOFireWireLibIsochPortRef listener))
                                                ; !	@function AllocateChannel
; 		@abstract Prepare all hardware to begin sending or receiving isochronous data.
; 		@discussion Calling this function will result in all listener and talker ports on this 
; 			isochronous channel having their AllocatePort method called.
; 		@param self The isoch channel interface to use.
; 		@result Returns an IOReturn error code. 
   (AllocateChannel (:pointer :callback))       ;(IOReturn (IOFireWireLibIsochChannelRef self))
                                                ; !	@function ReleaseChannel
; 		@abstract Release all hardware after stopping the isochronous channel.
; 		@discussion Calling this function will result in all listener and talker ports on this 
; 			isochronous channel having their ReleasePort method called.
; 		@param self The isoch channel interface to use.
; 		@result Returns an IOReturn error code. 
   (ReleaseChannel (:pointer :callback))        ;(IOReturn (IOFireWireLibIsochChannelRef self))
                                                ; !	@function Start
; 		@abstract Start the channel.
; 		@discussion Calling this function will result in all listener and talker ports on this 
; 			isochronous channel having their Start method called.
; 		@param self The isoch channel interface to use.
; 		@result Returns an IOReturn error code. 
   (Start (:pointer :callback))                 ;(IOReturn (IOFireWireLibIsochChannelRef self))
                                                ; !	@function Stop
; 		@abstract Stop the channel.
; 		@discussion Calling this function will result in all listener and talker ports on this 
; 			isochronous channel having their Stop method called.
; 		@param self The isoch channel interface to use.
; 		@result Returns an IOReturn error code. 
   (Stop (:pointer :callback))                  ;(IOReturn (IOFireWireLibIsochChannelRef self))
                                                ;  --- notification
                                                ; !	@function SetChannelForceStopHandler
; 		@abstract Set the channel force stop handler.
; 		@discussion The specified callback is called when the channel is stopped and cannot be 
; 			restarted automatically.
; 		@param self The isoch channel interface to use.
; 		@param stopProc The handler to set.
; 		@result Returns the previously set handler or NULL is no handler was set.
   (SetChannelForceStopHandler (:pointer :callback));(IOFireWireIsochChannelForceStopHandler (IOFireWireLibIsochChannelRef self , IOFireWireIsochChannelForceStopHandler stopProc))
                                                ; !	@function SetRefCon
; 		@abstract Set reference value associated with this channel.
; 		@discussion Retrieve the reference value with GetRefCon()
; 		@param self The isoch channel interface to use.
; 		@param inRefCon The new reference value.
   (SetRefCon (:pointer :callback))             ;(void (IOFireWireLibIsochChannelRef self , void * stopProcRefCon))
                                                ; !	@function GetRefCon
; 		@abstract Set reference value associated with this channel.
; 		@discussion Retrieve the reference value with SetRefCon()
; 		@param self The isoch channel interface to use.
; 		@param inRefCon The new reference value.
   (GetRefCon (:pointer :callback))             ;(void * (IOFireWireLibIsochChannelRef self))
   (NotificationIsOn (:pointer :callback))      ;(Boolean (IOFireWireLibIsochChannelRef self))
   (TurnOnNotification (:pointer :callback))    ;(Boolean (IOFireWireLibIsochChannelRef self))
   (TurnOffNotification (:pointer :callback))   ;(void (IOFireWireLibIsochChannelRef self))
   (ClientCommandIsComplete (:pointer :callback));(void (IOFireWireLibIsochChannelRef self , FWClientCommandID commandID , IOReturn status))
)
(%define-record :IOFireWireIsochChannelInterface (find-record-descriptor :IOFIREWIREISOCHCHANNELINTERFACE_T))
;  ============================================================
; 
;  IOFireWireDCLCommandPoolInterface
; 
;  ============================================================
(defrecord IOFireWireDCLCommandPoolInterface_t
                                                ; !	@class IOFireWireDCLCommandPoolInterface
; 
                                                ;  headerdoc parse workaround	
; class IOFireWireDCLCommandPoolInterface {
; public:
; 
#|
   (NIL :iunknown_c_guts)|#
   (revision :UInt32)
   (version :UInt32)
   (Allocate (:pointer :callback))              ;(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , IOByteCount inSize))
   (AllocateWithOpcode (:pointer :callback))    ;(IOReturn (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , DCLCommand ** outDCL , UInt32 opcode , ...))
   (AllocateTransferPacketDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , UInt32 inOpcode , void * inBuffer , IOByteCount inSize))
   (AllocateTransferBufferDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , UInt32 inOpcode , void * inBuffer , IOByteCount inSize , IOByteCount inPacketSize , UInt32 inBufferOffset))
   (AllocateSendPacketStartDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , void * inBuffer , IOByteCount inSize))
   (AllocateSendPacketWithHeaderStartDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , void * inBuffer , IOByteCount inSize))
   (AllocateSendBufferDCL (:pointer :callback)) ;(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , void * inBuffer , IOByteCount inSize , IOByteCount inPacketSize , UInt32 inBufferOffset))
   (AllocateSendPacketDCL (:pointer :callback)) ;(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , void * inBuffer , IOByteCount inSize))
   (AllocateReceivePacketStartDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , void * inBuffer , IOByteCount inSize))
   (AllocateReceivePacketDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , void * inBuffer , IOByteCount inSize))
   (AllocateReceiveBufferDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , void * inBuffer , IOByteCount inSize , IOByteCount inPacketSize , UInt32 inBufferOffset))
   (AllocateCallProcDCL (:pointer :callback))   ;(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , DCLCallCommandProc * inProc , UInt32 inProcData))
   (AllocateLabelDCL (:pointer :callback))      ;(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL))
   (AllocateJumpDCL (:pointer :callback))       ;(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , DCLLabel * pInJumpDCLLabel))
   (AllocateSetTagSyncBitsDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , UInt16 inTagBits , UInt16 inSyncBits))
   (AllocateUpdateDCLListDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , DCLCommand ** inDCLCommandList , UInt32 inNumCommands))
   (AllocatePtrTimeStampDCL (:pointer :callback));(DCLCommand * (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL , UInt32 * inTimeStampPtr))
   (Free (:pointer :callback))                  ;(void (IOFireWireLibDCLCommandPoolRef self , DCLCommand * inDCL))
   (GetSize (:pointer :callback))               ;(IOByteCount (IOFireWireLibDCLCommandPoolRef self))
   (SetSize (:pointer :callback))               ;(Boolean (IOFireWireLibDCLCommandPoolRef self , IOByteCount inSize))
   (GetBytesRemaining (:pointer :callback))     ;(IOByteCount (IOFireWireLibDCLCommandPoolRef self))
)
(%define-record :IOFireWireDCLCommandPoolInterface (find-record-descriptor :IOFIREWIREDCLCOMMANDPOOLINTERFACE_T))
(defrecord IOFireWireNuDCLPoolInterface_t
                                                ; !	@class IOFireWireNuDCLPoolInterface
; 	@discussion
; 
                                                ;  headerdoc parse workaround	
; class IOFireWireNuDCLPoolInterface {
; public:
; 
#|
   (NIL :iunknown_c_guts)|#
   (revision :UInt32)
   (version :UInt32)                            ;  Command pool management:
                                                ; !	@function GetProgram
; 		@abstract Finds the first DCL in the pool not preceeded by any other DCL.
; 		@discussion The specified callback is called when the channel is stopped and cannot be 
; 			restarted automatically.
; 		@param self The NuDCL pool to use.
; 		@param stopProc The handler to set.
; 		@result Returns the previously set handler or NULL is no handler was set.
   (GetProgram (:pointer :callback))            ;(DCLCommand * (IOFireWireLibNuDCLPoolRef self))
   (GetDCLs (:pointer :callback))               ;(CFArrayRef (IOFireWireLibNuDCLPoolRef self))
   (PrintProgram (:pointer :callback))          ;(void (IOFireWireLibNuDCLPoolRef self))
   (PrintDCL (:pointer :callback))              ;(void (NuDCLRef dcl))
                                                ;  Allocating transmit NuDCLs:
                                                ; !	@function SetCurrentTagAndSync
; 		@abstract Set current tag and sync bits
; 		@discussion
; 		@param self The NuDCL pool to use.
; 		@param numBuffers The number of virtual ranges in 'buffers'. Can be no greater than 6.
; 		@param buffers An array of virtual memory ranges containing the packet contents. The array will be copied
; 			into the DCL when it is created.
; 		@result Returns an NuDCLSendPacketRef on success or 0 on failure. 
   (SetCurrentTagAndSync (:pointer :callback))  ;(void (IOFireWireLibNuDCLPoolRef self , UInt8 tag , UInt8 sync))
                                                ; !	@function AllocateSendPacket
; 		@abstract Allocate a SendPacket NuDCL
; 		@discussion The SendPacket DCL sends an isochronous packet on the bus. 
; 			When transmitting, one SendPacket DCL will be executed per FireWire bus cycle. The isochronous header 
; 			for this DCL is specified by the closest preceeding SetHeader NuDCL. If there is no current header,
; 			the sync and tag fields of the isochronous header will be set to 0.			
; 		@param self The NuDCL pool to use.
; 		@param numBuffers The number of virtual ranges in 'buffers'. Can be no greater than 6.
; 		@param buffers An array of virtual memory ranges containing the packet contents. The array will be copied
; 			into the DCL when it is created.
; 		@param saveBag The allocated DCL can be added to a CFBag for easily setting DCL update lists. Pass a CFMutableSetRef to add the allocated
; 			DCL to a CFBag; pass NULL to ignore. SaveBag is unmodified on failure.
; 		@result Returns an NuDCLSendPacketRef on success or 0 on failure. 
   (AllocateSendPacket (:pointer :callback))    ;(NuDCLSendPacketRef (IOFireWireLibNuDCLPoolRef self , CFMutableSetRef saveBag , UInt32 numBuffers , IOVirtualRange * buffers))
   (AllocateSendPacket_v (:pointer :callback))  ;(NuDCLSendPacketRef (IOFireWireLibNuDCLPoolRef self , CFMutableSetRef saveBag , IOVirtualRange * firstRange , ...))
                                                ; !	@function AllocateSkipCycle
; 		@abstract Allocate a SkipCycle NuCDL
; 		@discussion The SkipCycle "sends" an empty cycle on the bus.
; 		@param self The NuDCL pool to use.
; 		@result Returns an NuDCLSkipCycleRef on success or 0 on failure. 
   (AllocateSkipCycle (:pointer :callback))     ;(NuDCLSkipCycleRef (IOFireWireLibNuDCLPoolRef self))
                                                ;  Allocating receive NuDCLs:
                                                ; !	@function AllocateReceivePacket
; 		@abstract Allocate a ReceivePacket NuDCL.
; 		@discussion The ReceivePacket DCL is used to receive an isochronous packet. One ReceivePacket DCL can
; 			be executed per FireWire bus cycle.
; 		@param self The NuDCL pool to use.
; 		@param wantHeader Set to true to store packet isochronous header with the received data.
; 		@param saveBag The allocated DCL can be added to a CFBag for easily setting DCL update lists. Pass a CFMutableSetRef to add the allocated
; 			DCL to a CFBag; pass NULL to ignore. SaveBag is unmodified on failure.
; 		@result Returns an NuDCLReceivePacketRef on success or 0 on failure. 
   (AllocateReceivePacket (:pointer :callback)) ;(NuDCLReceivePacketRef (IOFireWireLibNuDCLPoolRef self , CFMutableSetRef saveBag , UInt8 headerBytes , UInt32 numBuffers , IOVirtualRange * buffers))
   (AllocateReceivePacket_v (:pointer :callback));(NuDCLReceivePacketRef (IOFireWireLibNuDCLPoolRef self , CFMutableSetRef saveBag , UInt8 headerBytes , IOVirtualRange * firstRange , ...))
                                                ;  NuDCL configuration
                                                ; !	@function GetDCLNextDCL
; 		@abstract Get the next pointer for a NuDCL
; 		@discussion Applies: Any NuDCLRef
; 
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLSkipCycleRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 		@param dcl The dcl whose next pointer will be returned
; 		@result Returns the DCL immediately following this DCL in program order (ignoring branches) or 0 for none.
   (FindDCLNextDCL (:pointer :callback))        ;(NuDCLRef (IOFireWireLibNuDCLPoolRef self , NuDCLRef dcl))
                                                ; !	@function SetDCLBranch
; 		@abstract Set the branch pointer for a NuDCL
; 		@discussion Program execution will jump to the DCL pointed to by 'branchDCL', when set. 
; 		
; 			This change will apply immediately to a non-running DCL program. To apply the change to a running program
; 			use IOFireWireLibIsochPortInterface->ModifyNuDCLs()
; 			restarted automatically.
; 
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLSkipCycleRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 		@param stopProc The handler to set.
; 		@result Returns an IOReturn error code.
   (SetDCLBranch (:pointer :callback))          ;(IOReturn (NuDCLRef dcl , NuDCLRef branchDCL))
                                                ; !	@function GetDCLBranch
; 		@abstract Get the branch pointer for a NuDCL
; 		@param dcl The dcl whose branch pointer will be returned.
; 		@result Returns the branch pointer of 'dcl' or 0 for none is set.
   (GetDCLBranch (:pointer :callback))          ;(NuDCLRef (NuDCLRef dcl))
                                                ; !	@function SetDCLTimeStampPtr
; 		@abstract Set the time stamp pointer for a NuDCL
; 		@discussion Setting a the time stamp pointer for a NuDCL causes a time stamp to be recorded when a DCL executes. 
; 			You must run an update NuDCL on this DCL to copy the written timestamp to the proper location.
; 
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLSkipCycleRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 
; 		@param dcl The DCL for which time stamp pointer will be set
; 		@param timeStampPtr A pointer to a quadlet which will hold the timestamp after 'dcl' is updated.
; 		@result Returns an IOReturn error code.
   (SetDCLTimeStampPtr (:pointer :callback))    ;(IOReturn (NuDCLRef dcl , UInt32 * timeStampPtr))
                                                ; !	@function GetDCLTimeStampPtr
; 		@abstract Get the time stamp pointer for a NuDCL.
; 		@discussion The specified callback is called when the channel is stopped and cannot be 
; 			restarted automatically.
; 
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLSkipCycleRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 
; 		@param dcl The DCL to modify
; 		@result Returns a UInt32 time stamp pointer.
   (GetDCLTimeStampPtr (:pointer :callback))    ;(UInt32 * (NuDCLRef dcl))
   (SetDCLStatusPtr (:pointer :callback))       ;(IOReturn (NuDCLRef dcl , UInt32 * statusPtr))
   (GetDCLStatusPtr (:pointer :callback))       ;(UInt32 * (NuDCLRef dcl))
                                                ; !	@function AddDCLRange
; 		@abstract Add a memory range to the scatter gather list of a NuDCL
; 		@discussion
; 		
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 
; 		@param dcl The DCL to modify
; 		@param range A IOVirtualRange to add to this DCL buffer list. Do not pass NULL.
; 		@result Returns an IOReturn error code.
   (AppendDCLRanges (:pointer :callback))       ;(IOReturn (NuDCLRef dcl , UInt32 numRanges , IOVirtualRange * range))
                                                ; !	@function SetDCLRanges
; 		@abstract Set the scatter gather list for a NuDCL
; 		@discussion
; 
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 
; 		@param dcl The DCL to modify
; 		@param numRanges number of ranges in 'ranges'. Must be less than 7
; 		@param ranges An array of virtual ranges
; 		@result Returns an IOReturn error code.
   (SetDCLRanges (:pointer :callback))          ;(IOReturn (NuDCLRef dcl , UInt32 numRanges , IOVirtualRange * ranges))
   (SetDCLRanges_v (:pointer :callback))        ;(IOReturn (NuDCLRef dcl , IOVirtualRange * firstRange , ...))
                                                ; !	@function GetDCLRanges
; 		@abstract Get the scatter-gather list for a NuDCL
; 		@discussion 
; 
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 
; 		@param dcl The DCL to query
; 		@param stopProc The handler to set.
; 		@result Returns the previously set handler or NULL is no handler was set.
   (GetDCLRanges (:pointer :callback))          ;(UInt32 (NuDCLRef dcl , UInt32 maxRanges , IOVirtualRange * outRanges))
   (CountDCLRanges (:pointer :callback))        ;(UInt32 (NuDCLRef dcl))
   (GetDCLSpan (:pointer :callback))            ;(IOReturn (NuDCLRef dcl , IOVirtualRange * spanRange))
   (GetDCLSize (:pointer :callback))            ;(IOByteCount (NuDCLRef dcl))
                                                ; !	@function SetDCLCallback
; 		@abstract Set the callback for a NuDCL
; 		@discussion A callback can be called each time a NuDCL is run. Use SetDCLCallback() to set the
; 			callback for a NuDCL. If the update option is also set, the callback will be called after the update
; 			has run.
; 
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 		
; 		@param dcl The DCL to modify
; 		@param callback The callback function.
; 		@result Returns an IOReturn error code.
   (SetDCLCallback (:pointer :callback))        ;(IOReturn (NuDCLRef dcl , NuDCLCallback callback))
                                                ; !	@function Get callback for a NuDCL
; 		@abstract Returns the callback function for a DCL
; 		@discussion
; 
; 			Applies: NuDCLSendPacketRef, NuDCLSendPacketWithHeaderRef, NuDCLReceivePacket, NuDCLReceivePacketWithHeader
; 		@param dcl The DCL to query
; 		@result Returns the DCLs callback function or NULL is none.
   (GetDCLCallback (:pointer :callback))        ;(NuDCLCallback (NuDCLRef dcl))
   (SetDCLUserHeaderPtr (:pointer :callback))   ;(IOReturn (NuDCLRef dcl , UInt32 * headerPtr , UInt32 * mask))
   (GetDCLUserHeaderPtr (:pointer :callback))   ;(UInt32 * (NuDCLRef dcl))
   (GetUserHeaderMaskPtr (:pointer :callback))  ;(UInt32 * (NuDCLRef dcl))
   (SetDCLRefcon (:pointer :callback))          ;(void (NuDCLRef dcl , void * refcon))
   (GetDCLRefcon (:pointer :callback))          ;(void * (NuDCLRef dcl))
   (AppendDCLUpdateList (:pointer :callback))   ;(IOReturn (NuDCLRef dcl , NuDCLRef updateDCL))
                                                ;  consumes a reference on dclList..
   (SetDCLUpdateList (:pointer :callback))      ;(IOReturn (NuDCLRef dcl , CFSetRef dclList))
   (CopyDCLUpdateList (:pointer :callback))     ;(CFSetRef (NuDCLRef dcl))
   (RemoveDCLUpdateList (:pointer :callback))   ;(IOReturn (NuDCLRef dcl))
   (SetDCLWaitControl (:pointer :callback))     ;(IOReturn (NuDCLRef dcl , Boolean wait))
   (SetDCLFlags (:pointer :callback))           ;(void (NuDCLRef dcl , UInt32 flags))
   (GetDCLFlags (:pointer :callback))           ;(UInt32 (NuDCLRef dcl))
   (SetDCLSkipBranch (:pointer :callback))      ;(IOReturn (NuDCLRef dcl , NuDCLRef skipCycleDCL))
   (GetDCLSkipBranch (:pointer :callback))      ;(NuDCLRef (NuDCLRef dcl))
   (SetDCLSkipCallback (:pointer :callback))    ;(IOReturn (NuDCLRef dcl , NuDCLCallback callback))
   (GetDCLSkipCallback (:pointer :callback))    ;(NuDCLCallback (NuDCLRef dcl))
   (SetDCLSkipRefcon (:pointer :callback))      ;(IOReturn (NuDCLRef dcl , void * refcon))
   (GetDCLSkipRefcon (:pointer :callback))      ;(void * (NuDCLRef dcl))
   (SetDCLSyncBits (:pointer :callback))        ;(IOReturn (NuDCLRef dcl , UInt8 syncBits))
   (GetDCLSyncBits (:pointer :callback))        ;(UInt8 (NuDCLRef dcl))
   (SetDCLTagBits (:pointer :callback))         ;(IOReturn (NuDCLRef dcl , UInt8 tagBits))
   (GetDCLTagBits (:pointer :callback))         ;(UInt8 (NuDCLRef dcl))
)
(%define-record :IOFireWireNuDCLPoolInterface (find-record-descriptor :IOFIREWIRENUDCLPOOLINTERFACE_T))

; #endif //__IOFireWireLibIsoch_H__


(provide-interface "IOFireWireLibIsoch")