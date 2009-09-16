(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCSITask.h"
; at Sunday July 2,2006 7:29:48 pm.
; 
;  * Copyright (c) 1998-2002 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_SCSI_TASK_H_
; #define _IOKIT_SCSI_TASK_H_

; #if KERNEL
#| |#

(require-interface "IOKit/IOTypes")

#|
 |#

; #else

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 	Constants used inside the kernel and user space
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  The usage of these should be as follows:
;  - if the identifier can either be that of an initiator or a target,
; 	SCSIDeviceIdentifier should be used.
;  - if the identifier is for a target only and not an initiator, then
;  	SCSITargetIdentifier should be used.
;  - if the identifier is for an initiator only and not a target, then
; 	SCSIInitiatorIdentifier should be used.

(%define-record :SCSIDeviceIdentifier (find-record-descriptor ':UInt64))

(%define-record :SCSITargetIdentifier (find-record-descriptor ':SCSIDeviceIdentifier))

(%define-record :SCSIInitiatorIdentifier (find-record-descriptor ':SCSIDeviceIdentifier))

(%define-record :SCSILogicalUnitNumber (find-record-descriptor ':UInt64))
;  Tagged Task Identifier
;  * The Tagged Task Identifier is used when a Task has a Task Attribute other
;  * than SIMPLE.  The SCSI Application Layer client that controls the Logical
;  * Unit for which a Task is intended is required to guarantee that the Task
;  * Tag Identifier is unique.  Zero cannot be used a a Tag value as this is used
;  * to when a Tagged Task Identifier value is needed for a Task with a SIMPLE 
;  * attribute.
;  

(%define-record :SCSITaggedTaskIdentifier (find-record-descriptor ':UInt64))
;  Untagged Task Identifier
;  * The Untagged Task Identifier is used when asked a Tag value is required for
;  * a Task with a simple attribute.
;  

(defconstant $kSCSIUntaggedTaskIdentifier 0)
;  Task Attribute and constants
;  * The Task Attribute defines how this task should be managed
;  * when determing order for queueing and submission to the 
;  * appropriate device server.
;  *
;  * The Task Attribute is set by the SCSI Application Layer and cannot be
;  * modified by the SCSI Protocol Layer.
;  
(def-mactype :SCSITaskAttribute (find-mactype ':sint32))

(defconstant $kSCSITask_SIMPLE 0)
(defconstant $kSCSITask_ORDERED 1)
(defconstant $kSCSITask_HEAD_OF_QUEUE 2)
(defconstant $kSCSITask_ACA 3)
(def-mactype :SCSITaskAttribute (find-mactype ':SINT32))
;  Task State Constants
;  * The Task State represents the current state of the task.  The state is set
;  * to NEW_TASK when the task is created.  The SCSI Protocol Layer will then
;  * adjust the state as the task is queued and during execution.  The SCSI
;  * Application Layer can examine the state to monitor the progress of a task.
;  * 
;  * The Task State can only be modified by the SCSI Protocol Layer.  The SCSI
;  * Application Layer can only read the state.
;  
(def-mactype :SCSITaskState (find-mactype ':sint32))

(defconstant $kSCSITaskState_NEW_TASK 0)
(defconstant $kSCSITaskState_ENABLED 1)
(defconstant $kSCSITaskState_BLOCKED 2)
(defconstant $kSCSITaskState_DORMANT 3)
(defconstant $kSCSITaskState_ENDED 4)
(def-mactype :SCSITaskState (find-mactype ':SINT32))
;  Service Response
;  * The Service Response represents the execution status of a service request
;  * made to a Protocol Services Driver.  
;  
;  * The Service Response can only be modified by the SCSI Protocol Layer.  The 
;  * SCSI Application Layer can only read the state.
;  
(def-mactype :SCSIServiceResponse (find-mactype ':sint32))
;  This is not one of the standard service responses defined by
;  SAM, but is necessary for asynchronous commands that are not 
;  yet completed.

(defconstant $kSCSIServiceResponse_Request_In_Process 0);  General Service Response

(defconstant $kSCSIServiceResponse_SERVICE_DELIVERY_OR_TARGET_FAILURE 1);  Service Responses for Execute Command

(defconstant $kSCSIServiceResponse_TASK_COMPLETE 2)
(defconstant $kSCSIServiceResponse_LINK_COMMAND_COMPLETE 3);  Service Responses used for Task Management Functions

(defconstant $kSCSIServiceResponse_FUNCTION_COMPLETE 4)
(defconstant $kSCSIServiceResponse_FUNCTION_REJECTED 5)
(def-mactype :SCSIServiceResponse (find-mactype ':SINT32))
;  Task Status Constants
;  * The Task Status represents the completion status of the task which provides the 
;  * SCSI Application Layer with additional information about how to procede in 
;  * handling a completed task.
;  *
;  * The SCSI Architecture Model specification only defines task status values for when
;  * a task completes with a service response of either TASK_COMPLETED or LINK_COMMAND_COMPLETE.
;  * Since additional information will aid in error recovery when a task fails to be completed
;  * by a device due to a service response of kSCSIServiceResponse_SERVICE_DELIVERY_OR_TARGET_FAILURE,
;  * additional values have been defined that can be returned by the SCSI Protocol Layer to inform 
;  * the SCSI Application Layer of the cause of the delivery failure. 
;  * 
;  * The Task Status can only be modified by the SCSI Protocol Layer.  The SCSI
;  * Application Layer can only read the status.
;  
(def-mactype :SCSITaskStatus (find-mactype ':sint32))
;  These are the Task Status values as defined by the SCSI Architecture Model
;  specification and are returned only when task completes with a service response 
;  of either TASK_COMPLETED or LINK_COMMAND_COMPLETE.
;  Since these are well documented in the SAM specifications, that document should be
;  referenced for their meaning.

(defconstant $kSCSITaskStatus_GOOD 0)
(defconstant $kSCSITaskStatus_CHECK_CONDITION 2)
(defconstant $kSCSITaskStatus_CONDITION_MET 4)
(defconstant $kSCSITaskStatus_BUSY 8)
(defconstant $kSCSITaskStatus_INTERMEDIATE 16)
(defconstant $kSCSITaskStatus_INTERMEDIATE_CONDITION_MET 20)
(defconstant $kSCSITaskStatus_RESERVATION_CONFLICT 24)
(defconstant $kSCSITaskStatus_TASK_SET_FULL 40)
(defconstant $kSCSITaskStatus_ACA_ACTIVE 48)    ;  These are the Task Status values for use when a task fails to complete due to
;  a service response of SERVICE_DELIVERY_OR_TARGET_FAILURE.
;  These values are not defined in the SCSI specifications, but are here so that
;  the SCSI Protocol Layer objects can provide more information, if available, to 
;  the SCSI Application Layer as to the cause of the failure.
;  If a task is aborted by the SCSI Protocol Layer due to it exceeding the timeout
;  value specified by the task, the task status shall be set to
;  kSCSITaskStatus_TaskTimeoutOccurred.

(defconstant $kSCSITaskStatus_TaskTimeoutOccurred 1);  If a task is aborted by the SCSI Protocol Layer due to it exceeding a timeout
;  value specified by the support for the protocol or a related specification, 
;  the task status shall be set to kSCSITaskStatus_TaskTimeoutOccurred.

(defconstant $kSCSITaskStatus_ProtocolTimeoutOccurred 2);  If a task is unable to be delivered due to a failure of the device not
;  accepting the task or the device acknowledging the attempt to send it
;  the device the task status shall be set to kSCSITaskStatus_DeviceNotResponding.
;  This will allow the SCSI Application driver to perform the necessary steps 
;  to try to recover the device.  This shall only be reported after the 
;  SCSI Protocol Layer driver has attempted all protocol specific attempts to recover the device.

(defconstant $kSCSITaskStatus_DeviceNotResponding 3);  If the task is unable to be delivered because the device has been detached,
;  the task status shall be set to kSCSITaskStatus_DeviceNotPresent.  This will
;  allow the SCSI Application Layer to halt the sending of tasks to the device and, 
;  if supported, perform any device failover or system cleanup.

(defconstant $kSCSITaskStatus_DeviceNotPresent 4);  If the task is unable to be delivered to the device due to a failure in the SCSI 
;  Protocol Layer, such as a bus reset or communications error, but the device is
;  is known to be functioning properly, the task status shall be set to 
;  kSCSITaskStatus_DeliveryFailure.  This can also be reported if the task could not 
;  be delivered due to a protocol error that has since been corrected.

(defconstant $kSCSITaskStatus_DeliveryFailure 5);  This status is not defined by the SCSI specifications,
;  but is here to provide a status that can be returned in
;  cases where there is not status available from the device
;  or protocol, for example, when the service response is neither
;  TASK_COMPLETED nor LINK_COMMAND_COMPLETE or when the service response is
;  SERVICE_DELIVERY_OR_TARGET_FAILURE and the reason for failure could not be determined.

(defconstant $kSCSITaskStatus_No_Status #xFF)
(def-mactype :SCSITaskStatus (find-mactype ':SINT32))
;  Command Descriptor Block Size constants
;  This is the largest size a Command Descriptor
;  Block can be as specified in SPC-2

(defconstant $kSCSICDBSize_Maximum 16)
(defconstant $kSCSICDBSize_6Byte 6)
(defconstant $kSCSICDBSize_10Byte 10)
(defconstant $kSCSICDBSize_12Byte 12)
(defconstant $kSCSICDBSize_16Byte 16)
(defrecord SCSICommandDescriptorBlock
   (contents (:array :UInt8 16))
)                                               ;  Constants for the DataTransferDirection field

(defconstant $kSCSIDataTransfer_NoDataTransfer 0)
(defconstant $kSCSIDataTransfer_FromInitiatorToTarget 1)
(defconstant $kSCSIDataTransfer_FromTargetToInitiator 2)

; #if defined(KERNEL) && defined(__cplusplus)
#|                                              ; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 	Includes
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Libkern includes

(require-interface "libkern/c++/OSObject")
;  Generic IOKit related headers
|#

(require-interface "IOKit/IOCommand")

#||#

(require-interface "IOKit/IOReturn")

#||#

(require-interface "IOKit/IOMemoryDescriptor")

#|                                              ;  SCSI Architecture Model Family includes
|#

(require-interface "IOKit/scsi/SCSICmds_REQUEST_SENSE_Defs")

#|                                              ; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 	Constants used inside the kernel only
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  The SCSI Task mode is used by the SCSI Protocol Layer to 
;  * indicate what mode the task is executing, the command or
;  * the AutoSense command.
;  
(def-mactype :SCSITaskMode (find-mactype ':sint32))

(defconstant $kSCSITaskMode_CommandExecution 1)
(defconstant $kSCSITaskMode_Autosense 2)
(def-mactype :SCSITaskMode (find-mactype ':SINT32))
;  This is an opaque object that represents a task.  This is used
;  * so that driver for both the SCSI Protocol Layer and the SCSI 
;  * Application Layer cannot modify the SCSITask object directly but must
;  * instead use the inherited methods to do so.  This prevents changing
;  * of properties that are not allowed to be changed by a given layer.
;  

(def-mactype :SCSITaskIdentifier (find-mactype '(:pointer :OSObject)))

(def-mactype :SCSITaskCompletion (find-mactype ':pointer)); (SCSITaskIdentifier completedTask)
 |#

; #endif	/* defined(KERNEL) && defined(__cplusplus) */


; #endif /* _IOKIT_SCSI_TASK_H_ */


(provide-interface "SCSITask")