(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mscdefines.h"
; at Sunday July 2,2006 7:30:31 pm.
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
; *****************************************************************
; 
;         MUSCLE SmartCard Development ( http://www.linuxnet.com )
;             Title  : mscdefines.h
;             Package: MuscleCard Framework
;             Author : David Corcoran
;             Date   : 10/02/01
;             License: Copyright (C) 2001-2002 David Corcoran
;                      <corcoran@linuxnet.com>
;             Purpose: This provides high level definitions for
;                      data types, structures.
; 
; 	    You may not remove this header from this file
; 	    without prior permission from the author.
;    
; *******************************************************************
; #ifndef __mscdefines_h__
; #define __mscdefines_h__
; #ifdef __cplusplus
#| #|
extern "C"
{
#endif
|#
 |#
; #ifdef WIN32
#| #|
#include "..win32win32_pcsclite.h"
#endif
|#
 |#
; #ifndef __APPLE__
#| #|
#include <winscard.h>
|#
 |#

; #else

(require-interface "PCSC/winscard")

; #endif

; #ifdef MSC_ARCH_WIN32
#| #|
#define MAX_BUFFER_SIZE		265
#endif
|#
 |#
; 
; 	 * Some type defines used in MuscleCard 
; 	 

(def-mactype :MSC_RV (find-mactype ':UInt32))

(def-mactype :MSCChar8 (find-mactype ':character))

(def-mactype :MSCPUChar8 (find-mactype '(:pointer :UInt8)))

(def-mactype :MSCPCUChar8 (find-mactype '(:pointer :UInt8)))

(def-mactype :MSCUChar8 (find-mactype ':UInt8))

(def-mactype :MSCPUShort16 (find-mactype '(:pointer :UInt16)))

(def-mactype :MSCUShort16 (find-mactype ':UInt16))

(def-mactype :MSCPShort16 (find-mactype '(:pointer :SInt16)))

(def-mactype :MSCShort16 (find-mactype ':SInt16))

(def-mactype :MSCPULong32 (find-mactype '(:pointer :UInt32)))

(def-mactype :MSCULong32 (find-mactype ':UInt32))

(def-mactype :MSCPLong32 (find-mactype '(:pointer :signed-long)))

(def-mactype :MSCLong32 (find-mactype ':signed-long))

(def-mactype :MSCPCVoid32 (find-mactype '(:pointer :void)))

(def-mactype :MSCPVoid32 (find-mactype '(:pointer :void)))

(def-mactype :MSCCString (find-mactype '(:pointer :character)))

(def-mactype :MSCString (find-mactype '(:pointer :character)))
(defrecord CFDyLibPointers
   (pvfWriteFramework (:pointer :void))
   (pvfInitializePlugin (:pointer :void))
   (pvfIdentifyToken (:pointer :void))
   (pvfFinalizePlugin (:pointer :void))
   (pvfGetStatus (:pointer :void))
   (pvfGetCapabilities (:pointer :void))
   (pvfExtendedFeature (:pointer :void))
   (pvfGenerateKeys (:pointer :void))
   (pvfImportKey (:pointer :void))
   (pvfExportKey (:pointer :void))
   (pvfComputeCrypt (:pointer :void))
   (pvfExtAuthenticate (:pointer :void))
   (pvfListKeys (:pointer :void))
   (pvfCreatePIN (:pointer :void))
   (pvfVerifyPIN (:pointer :void))
   (pvfChangePIN (:pointer :void))
   (pvfUnblockPIN (:pointer :void))
   (pvfListPINs (:pointer :void))
   (pvfCreateObject (:pointer :void))
   (pvfDeleteObject (:pointer :void))
   (pvfWriteObject (:pointer :void))
   (pvfReadObject (:pointer :void))
   (pvfListObjects (:pointer :void))
   (pvfLogoutAll (:pointer :void))
   (pvfGetChallenge (:pointer :void))
#|
 confused about , * LPCFDyLibPointers
|#
)
(defconstant $MSC_MAXSIZE_TOKENAME 150)
; #define MSC_MAXSIZE_TOKENAME      150
(defconstant $MSC_MAXSIZE_SVCPROV 200)
; #define MSC_MAXSIZE_SVCPROV       200
(defconstant $MSC_MAXSIZE_OBJID 16)
; #define MSC_MAXSIZE_OBJID          16
(defconstant $MSC_MAXSIZE_AID 64)
; #define MSC_MAXSIZE_AID            64
(defconstant $MSC_MAXSIZE_MAC 128)
; #define MSC_MAXSIZE_MAC           128
(defconstant $MSC_MAXSIZE_LABEL 32)
; #define MSC_MAXSIZE_LABEL          32
(defconstant $MSC_MAXSIZE_CERT_ISSUER 512)
; #define MSC_MAXSIZE_CERT_ISSUER    512
(defconstant $MSC_MAXSIZE_CERT_SUBJECT 512)
; #define MSC_MAXSIZE_CERT_SUBJECT   512
(defconstant $MSC_MAXSIZE_CERT_SERIAL 512)
; #define MSC_MAXSIZE_CERT_SERIAL    512
; #define MSC_MAXSIZE_BUFFER     MAX_BUFFER_SIZE
(defrecord MSCTokenInfo   (tokenName (:array :character 150))          ;  Token name 
   (slotName (:array :character $MAX_READERNAME))
                                                ;  Slot/reader name 
   (svProvider (:array :character 200))         ;  Library 
   (tokenId (:array :UInt8 $MAX_ATR_SIZE))      ;  Token ID (ATR) 
   (tokenApp (:array :UInt8 64))                ;  Default app ID 
   (tokenAppLen :UInt32)
                                                ;  Default AID Length 
   (tokenIdLength :UInt32)                      ;  ID Length (ATR Length) 
   (tokenState :UInt32)
                                                ;  State (dwEventState) 
   (tokenType :UInt32)
                                                ;  Type - RFU 
   (addParams (:pointer :void))
                                                ;  Additional Data 
   (addParamsSize :UInt32)                      ;  Size of additional data 
#|
 confused about , * MSCLPTokenInfo
|#
)
; 
; 	 * Callback function definitions 
; 	 

(def-mactype :MSCCallBack (find-mactype ':pointer)); (MSCLPTokenInfo , MSCULong32 , MSCPVoid32)
#|
; Warning: type-size: unknown type MSCLPTOKENINFO
|#
(defrecord MSCEventWaitInfo
   (arraySize :UInt32)
   (tokenArray :msclptokeninfo)
   (appData (:pointer :void))
   (callBack :pointer)
#|
 confused about , * MSCLPEventWaitInfo
|#
)

(def-mactype :LPRWEventCallback (find-mactype ':pointer)); (MSCPVoid32 , int)
#|
; Warning: type-size: unknown type LPSCARD_IO_REQUEST
|#
(defrecord MSCTokenConnection
   (hContext :signed-long)
                                                ;  Handle to resource manager 
   (hCard :signed-long)
                                                ;  Handle to the connection 
   (ioType :lpscard_io_request)                 ;  Type of protocol 
   (pMac (:array :UInt8 128))                   ;  MAC code 
   (macSize :UInt32)
                                                ;  Size of the MAC code 
   (tokenLibHandle (:pointer :void))            ;  Handle to token library 
   (libPointers :CFDYLIBPOINTERS)               ;  Function pointers 
   (tokenInfo :MSCTOKENINFO)
                                                ;  token information 
   (loggedIDs :UInt8)
                                                ;  Verification bit mask 
   (shareMode :UInt32)
                                                ;  Sharing mode for this 
   (rwCallback :pointer)
                                                ;  Registered callback 
#|
 confused about , * MSCLPTokenConnection
|#
)
; #define MSC_OK MSC_SUCCESS
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif							/* __mscdefines_h__ */


(provide-interface "mscdefines")