(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFireWireAVCUserClientCommon.h"
; at Sunday July 2,2006 7:29:01 pm.
; 
;  * Copyright (c) 1998-2001 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_IOFIREWIREAVCUSERCLIENTCOMMON_H_
; #define _IOKIT_IOFIREWIREAVCUSERCLIENTCOMMON_H_

(require-interface "IOKit/avc/IOFireWireAVCConsts")
(defconstant $kIOFireWireAVCLibConnection 13)
; #define kIOFireWireAVCLibConnection 13
(def-mactype :IOFWAVCUserClientCommandCodes (find-mactype ':sint32))

(defconstant $kIOFWAVCUserClientOpen 0)         ;  kIOUCScalarIScalarO 0,0

(defconstant $kIOFWAVCUserClientClose 1)        ;  kIOUCScalarIScalarO 0,0

(defconstant $kIOFWAVCUserClientOpenWithSessionRef 2);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWAVCUserClientGetSessionRef 3);  kIOUCScalarIScalarO 0,1

(defconstant $kIOFWAVCUserClientAVCCommand 4)   ;  kIOUCStructIStructO -1,-1

(defconstant $kIOFWAVCUserClientAVCCommandInGen 5);  kIOUCStructIStructO -1,-1

(defconstant $kIOFWAVCUserClientUpdateAVCCommandTimeout 6);  kIOUCScalarIScalarO 0,0

(defconstant $kIOFWAVCUserClientMakeP2PInputConnection 7);  KIOUCScalarIScalarO 1, 0

(defconstant $kIOFWAVCUserClientBreakP2PInputConnection 8);  KIOUCScalarIScalarO 1, 0

(defconstant $kIOFWAVCUserClientMakeP2POutputConnection 9);  KIOUCScalarIScalarO 1, 0

(defconstant $kIOFWAVCUserClientBreakP2POutputConnection 10);  KIOUCScalarIScalarO 1, 0

(defconstant $kIOFWAVCUserClientNumCommands 11)
(def-mactype :IOFWAVCProtocolUserClientCommandCodes (find-mactype ':sint32))

(defconstant $kIOFWAVCProtocolUserClientSendAVCResponse 0);  kIOUCScalarIStructI 2, -1

(defconstant $kIOFWAVCProtocolUserClientFreeInputPlug 1);  kIOUCScalarIScalarO 1, 0

(defconstant $kIOFWAVCProtocolUserClientReadInputPlug 2);  kIOUCScalarIScalarO 1, 1

(defconstant $kIOFWAVCProtocolUserClientUpdateInputPlug 3);  kIOUCScalarIScalarO 3, 0

(defconstant $kIOFWAVCProtocolUserClientFreeOutputPlug 4);  kIOUCScalarIScalarO 1, 0

(defconstant $kIOFWAVCProtocolUserClientReadOutputPlug 5);  kIOUCScalarIScalarO 1, 1

(defconstant $kIOFWAVCProtocolUserClientUpdateOutputPlug 6);  kIOUCScalarIScalarO 3, 0

(defconstant $kIOFWAVCProtocolUserClientReadOutputMasterPlug 7);  kIOUCScalarIScalarO 0, 1

(defconstant $kIOFWAVCProtocolUserClientUpdateOutputMasterPlug 8);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWAVCProtocolUserClientReadInputMasterPlug 9);  kIOUCScalarIScalarO 0, 1

(defconstant $kIOFWAVCProtocolUserClientUpdateInputMasterPlug 10);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWAVCProtocolUserClientPublishAVCUnitDirectory 11);  kIOUCScalarIScalarO 0, 0

(defconstant $kIOFWAVCProtocolUserClientSetSubunitPlugSignalFormat 12);  kIOUCScalarIScalarO 4, 0

(defconstant $kIOFWAVCProtocolUserClientGetSubunitPlugSignalFormat 13);  kIOUCScalarIScalarO 3, 1

(defconstant $kIOFWAVCProtocolUserClientConnectTargetPlugs 14);  kIOUCStructIStructO

(defconstant $kIOFWAVCProtocolUserClientDisconnectTargetPlugs 15);  kIOUCScalarIScalarO 6, 0

(defconstant $kIOFWAVCProtocolUserClientGetTargetPlugConnection 16);  kIOUCStructIStructO

(defconstant $kIOFWAVCProtocolUserClientAVCRequestNotHandled 17);  kIOUCScalarIStructI 4, -1

(defconstant $kIOFWAVCProtocolUserClientNumCommands 18)
(def-mactype :IOFWAVCProtocolUserClientAsyncCommandCodes (find-mactype ':sint32))

(defconstant $kIOFWAVCProtocolUserClientSetAVCRequestCallback 0);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWAVCProtocolUserClientAllocateInputPlug 1);  kIOUCScalarIScalarO 1, 1

(defconstant $kIOFWAVCProtocolUserClientAllocateOutputPlug 2);  kIOUCScalarIScalarO 1, 1

(defconstant $kIOFWAVCProtocolUserClientInstallAVCCommandHandler 3);  kIOUCScalarIScalarO 4, 0

(defconstant $kIOFWAVCProtocolUserClientAddSubunit 4);  kIOUCScalarIScalarO 5, 1

(defconstant $kIOFWAVCProtocolUserClientNumAsyncCommands 5)
(defrecord _AVCConnectTargetPlugsInParams
   (sourceSubunitTypeAndID :UInt32)
   (sourcePlugType :SInt32)
   (sourcePlugNum :UInt32)
   (destSubunitTypeAndID :UInt32)
   (destPlugType :SInt32)
   (destPlugNum :UInt32)
   (lockConnection :Boolean)
   (permConnection :Boolean)
)
(%define-record :AVCConnectTargetPlugsInParams (find-record-descriptor :_AVCCONNECTTARGETPLUGSINPARAMS))
(defrecord _AVCConnectTargetPlugsOutParams
   (sourcePlugNum :UInt32)
   (destPlugNum :UInt32)
)
(%define-record :AVCConnectTargetPlugsOutParams (find-record-descriptor :_AVCCONNECTTARGETPLUGSOUTPARAMS))
(defrecord _AVCGetTargetPlugConnectionInParams
   (subunitTypeAndID :UInt32)
   (plugType :SInt32)
   (plugNum :UInt32)
)
(%define-record :AVCGetTargetPlugConnectionInParams (find-record-descriptor :_AVCGETTARGETPLUGCONNECTIONINPARAMS))
(defrecord _AVCGetTargetPlugConnectionOutParams
   (connectedSubunitTypeAndID :UInt32)
   (connectedPlugType :SInt32)
   (connectedPlugNum :UInt32)
   (lockConnection :Boolean)
   (permConnection :Boolean)
)
(%define-record :AVCGetTargetPlugConnectionOutParams (find-record-descriptor :_AVCGETTARGETPLUGCONNECTIONOUTPARAMS))

; #endif // _IOKIT_IOFIREWIREAVCUSERCLIENTCOMMON_H_


(provide-interface "IOFireWireAVCUserClientCommon")