(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOFireWireSBP2UserClientCommon.h"
; at Sunday July 2,2006 7:29:08 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
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
; #ifndef _IOKIT_IOFIREWIRESBP2USERCLIENTCOMMON_H_
; #define _IOKIT_IOFIREWIRESBP2USERCLIENTCOMMON_H_
(defconstant $kIOFireWireSBP2LibConnection 12)
; #define kIOFireWireSBP2LibConnection 12
(def-mactype :IOFWSBP2UserClientCommandCodes (find-mactype ':sint32))

(defconstant $kIOFWSBP2UserClientOpen 0)        ;  kIOUCScalarIScalarO 0,0

(defconstant $kIOFWSBP2UserClientClose 1)       ;  kIOUCScalarIScalarO 0,0

(defconstant $kIOFWSBP2UserClientCreateLogin 2) ;  kIOUCScalarIScalarO 0,1

(defconstant $kIOFWSBP2UserClientReleaseLogin 3);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSubmitLogin 4) ;  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSubmitLogout 5);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSetLoginFlags 6);  kIOUCScalarIScalarO 2,0

(defconstant $kIOFWSBP2UserClientGetMaxCommandBlockSize 7);  kIOUCScalarIScalarO 1,1

(defconstant $kIOFWSBP2UserClientGetLoginID 8)  ;  kIOUCScalarIScalarO 1,1

(defconstant $kIOFWSBP2UserClientSetReconnectTime 9);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSetMaxPayloadSize 10);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientCreateORB 11)  ;  kIOUCScalarIScalarO 0,1

(defconstant $kIOFWSBP2UserClientReleaseORB 12) ;  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSubmitORB 13)  ;  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSetCommandFlags 14);  kIOUCScalarIScalarO 2,0

(defconstant $kIOFWSBP2UserClientSetMaxORBPayloadSize 15);  kIOUCScalarIScalarO 2,0

(defconstant $kIOFWSBP2UserClientSetCommandTimeout 16);  kIOUCScalarIScalarO 2,0

(defconstant $kIOFWSBP2UserClientSetCommandGeneration 17);  kIOUCScalarIScalarO 2,0

(defconstant $kIOFWSBP2UserClientSetToDummy 18) ;  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSetCommandBuffersAsRanges 19);  kIOUCScalarIScalarO 6,0

(defconstant $kIOFWSBP2UserClientReleaseCommandBuffers 20);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSetCommandBlock 21);  kIOUCScalarIScalarO 3,0

(defconstant $kIOFWSBP2UserClientCreateMgmtORB 22);  kIOUCScalarIScalarO 0,1

(defconstant $kIOFWSBP2UserClientReleaseMgmtORB 23);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientSubmitMgmtORB 24);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientMgmtORBSetCommandFunction 25);  kIOUCScalarIScalarO 2,0

(defconstant $kIOFWSBP2UserClientMgmtORBSetManageeORB 26);  kIOUCScalarIScalarO 2,0

(defconstant $kIOFWSBP2UserClientMgmtORBSetManageeLogin 27);  kIOUCScalarIScalarO 2,0

(defconstant $kIOFWSBP2UserClientMgmtORBSetResponseBuffer 28);  kIOUCScalarIScalarO 3,0

(defconstant $kIOFWSBP2UserClientLSIWorkaroundSetCommandBuffersAsRanges 29);  kIOUCScalarIScalarO 6,0

(defconstant $kIOFWSBP2UserClientMgmtORBLSIWorkaroundSyncBuffersForOutput 30);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientMgmtORBLSIWorkaroundSyncBuffersForInput 31);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientOpenWithSessionRef 32);  kIOUCScalarIScalarO 1,0

(defconstant $kIOFWSBP2UserClientGetSessionRef 33);  kIOUCScalarIScalarO 0,1

(defconstant $kIOFWSBP2UserClientRingDoorbell 34);  kIOUCScalarIScalarO 1, 0

(defconstant $kIOFWSBP2UserClientEnableUnsolicitedStatus 35);  kIOUCScalarIScalarO 1, 0

(defconstant $kIOFWSBP2UserClientSetBusyTimeoutRegisterValue 36);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWSBP2UserClientSetORBRefCon 37);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWSBP2UserClientSetPassword 38);  kIOUCScalarIScalarO 3, 0

(defconstant $kIOFWSBP2UserClientNumCommands 39)
(def-mactype :IOCDBUserClientAsyncCommandCodes (find-mactype ':sint32))

(defconstant $kIOFWSBP2UserClientSetMessageCallback 0);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWSBP2UserClientSetLoginCallback 1);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWSBP2UserClientSetLogoutCallback 2);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWSBP2UserClientSetUnsolicitedStatusNotify 3);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWSBP2UserClientSetStatusNotify 4);  kIOUCScalarIScalarO 2, 0

(defconstant $kIOFWSBP2UserClientSetMgmtORBCallback 5);  kIOUCScalarIScalarO 3, 0

(defconstant $kIOFWSBP2UserClientSubmitFetchAgentReset 6);  kIOUCScalarIScalarO 3, 0

(defconstant $kIOFWSBP2UserClientSetFetchAgentWriteCompletion 7);  kIOUCScalarIScalaO 2, 0

(defconstant $kIOFWSBP2UserClientNumAsyncCommands 8)

; #endif


(provide-interface "IOFireWireSBP2UserClientCommon")