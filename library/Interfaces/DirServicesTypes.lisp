(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DirServicesTypes.h"
; at Sunday July 2,2006 7:27:32 pm.
; 
;  * Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
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
; !
;  * @header DirServicesTypes
;  
; #ifndef __DirServicesTypesH__
(defconstant $__DirServicesTypesH__ 1)
; #define	__DirServicesTypesH__	1
; #ifndef dsBool
; #define	dsBool	int

; #endif

; !
;  *	@enum tDirStatus
;  *	@discussion Error codes returned from the Directory Services API.
;  *	@constant eDSSchemaError The write operation failed because the result would conflict
;  *		with the server's schema. For example, trying to remove a required attribute would
;  *		return this error.
;  *	@constant eDSAttributeValueNotFound	When using dsSetAttributeValue, dsRemoveAttributeValue,
;  *		or dsGetAttributeValueByID the value with the specified ID was not found.
;  *	@constant eDSVersionMismatch A configuration file version is not compatible with this
;  *		version of Directory Services or the plug-in that loaded it.
;  *	@constant eDSAuthNewPasswordRequired The administrator set a flag to force a password
;  *		reset on the next login.
;  *	@constant eDSAuthPasswordExpired The password expiration date has passed so it must be
;  *		reset.
;  *	@constant eDSAuthPasswordQualityCheckFailed New password rejected because it did not meet
;  *		the password server’s quality requirements (for example, it was too short).
;  *		This error only comes back when changing or setting the password, not when
;  *		authenticating.
;  *	@constant eDSAuthPasswordTooShort New password rejected because it did not meet
;  *		the password server’s minimum length requirements. This error only comes back 
;  *		when changing or setting the password, not when authenticating.
;  *	@constant eDSAuthPasswordTooLong New password rejected because it exceeded
;  *		the password server’s maximum length limit. This error only comes back 
;  *		when changing or setting the password, not when authenticating.
;  *	@constant eDSAuthPasswordNeedsLetter New password rejected because it did not meet
;  *		the password server’s quality requirements (did not contain a letter).
;  *		This error only comes back when changing or setting the password, not when
;  *		authenticating.
;  *	@constant eDSAuthPasswordNeedsDigit New password rejected because it did not meet
;  *		the password server’s quality requirements (did not contain a digit).
;  *		This error only comes back when changing or setting the password, not when
;  *		authenticating.
;  *	@constant eDSAuthAccountDisabled The administrator set a flag to disable the account.
;  *	@constant eDSAuthAccountExpired The expiration date/time of the account passed so it is
;  *		automatically disabled.
;  *	@constant eDSAuthAccountInactive The account was unused for a preset amount of time so
;  *		it was automatically disabled.
;  

(defconstant $eDSNoErr 0)
(defconstant $eDSOpenFailed -14000)
(defconstant $eDSCloseFailed -14001)
(defconstant $eDSOpenNodeFailed -14002)
(defconstant $eDSBadDirRefences -14003)
(defconstant $eDSNullRecordReference -14004)
(defconstant $eDSMaxSessionsOpen -14005)
(defconstant $eDSCannotAccessSession -14006)
(defconstant $eDSDirSrvcNotOpened -14007)
(defconstant $eDSNodeNotFound -14008)
(defconstant $eDSUnknownNodeName -14009)
(defconstant $eDSRegisterCustomFailed -14010)
(defconstant $eDSGetCustomFailed -14011)
(defconstant $eDSUnRegisterFailed -14012)
(defconstant $eDSAllocationFailed -14050)
(defconstant $eDSDeAllocateFailed -14051)
(defconstant $eDSCustomBlockFailed -14052)
(defconstant $eDSCustomUnblockFailed -14053)
(defconstant $eDSCustomYieldFailed -14054)
(defconstant $eDSCorruptBuffer -14060)
(defconstant $eDSInvalidIndex -14061)
(defconstant $eDSIndexOutOfRange -14062)
(defconstant $eDSIndexNotFound -14063)
(defconstant $eDSCorruptRecEntryData -14065)
(defconstant $eDSRefSpaceFull -14069)
(defconstant $eDSRefTableAllocError -14070)
(defconstant $eDSInvalidReference -14071)
(defconstant $eDSInvalidRefType -14072)
(defconstant $eDSInvalidDirRef -14073)
(defconstant $eDSInvalidNodeRef -14074)
(defconstant $eDSInvalidRecordRef -14075)
(defconstant $eDSInvalidAttrListRef -14076)
(defconstant $eDSInvalidAttrValueRef -14077)
(defconstant $eDSInvalidContinueData -14078)
(defconstant $eDSInvalidBuffFormat -14079)
(defconstant $eDSInvalidPatternMatchType -14080)
(defconstant $eDSRefTableError -14081)
(defconstant $eDSRefTableNilError -14082)
(defconstant $eDSRefTableIndexOutOfBoundsError -14083)
(defconstant $eDSRefTableEntryNilError -14084)
(defconstant $eDSRefTableCSBPAllocError -14085)
(defconstant $eDSRefTableFWAllocError -14086)
(defconstant $eDSAuthFailed -14090)
(defconstant $eDSAuthMethodNotSupported -14091)
(defconstant $eDSAuthResponseBufTooSmall -14092)
(defconstant $eDSAuthParameterError -14093)
(defconstant $eDSAuthInBuffFormatError -14094)
(defconstant $eDSAuthNoSuchEntity -14095)
(defconstant $eDSAuthBadPassword -14096)
(defconstant $eDSAuthContinueDataBad -14097)
(defconstant $eDSAuthUnknownUser -14098)
(defconstant $eDSAuthInvalidUserName -14099)
(defconstant $eDSAuthCannotRecoverPasswd -14100)
(defconstant $eDSAuthFailedClearTextOnly -14101)
(defconstant $eDSAuthNoAuthServerFound -14102)
(defconstant $eDSAuthServerError -14103)
(defconstant $eDSInvalidContext -14104)
(defconstant $eDSBadContextData -14105)
(defconstant $eDSPermissionError -14120)
(defconstant $eDSReadOnly -14121)
(defconstant $eDSInvalidDomain -14122)
(defconstant $eNetInfoError -14123)
(defconstant $eDSInvalidRecordType -14130)
(defconstant $eDSInvalidAttributeType -14131)
(defconstant $eDSInvalidRecordName -14133)
(defconstant $eDSAttributeNotFound -14134)
(defconstant $eDSRecordAlreadyExists -14135)
(defconstant $eDSRecordNotFound -14136)
(defconstant $eDSAttributeDoesNotExist -14137)
(defconstant $eDSNoStdMappingAvailable -14140)
(defconstant $eDSInvalidNativeMapping -14141)
(defconstant $eDSSchemaError -14142)
(defconstant $eDSAttributeValueNotFound -14143)
(defconstant $eDSVersionMismatch -14149)
(defconstant $eDSPlugInConfigFileError -14150)
(defconstant $eDSInvalidPlugInConfigData -14151)
(defconstant $eDSAuthNewPasswordRequired -14161)
(defconstant $eDSAuthPasswordExpired -14162)
(defconstant $eDSAuthPasswordQualityCheckFailed -14165)
(defconstant $eDSAuthAccountDisabled -14167)
(defconstant $eDSAuthAccountExpired -14168)
(defconstant $eDSAuthAccountInactive -14169)
(defconstant $eDSAuthPasswordTooShort -14170)
(defconstant $eDSAuthPasswordTooLong -14171)
(defconstant $eDSAuthPasswordNeedsLetter -14172)
(defconstant $eDSAuthPasswordNeedsDigit -14173)
(defconstant $eDSAuthPasswordChangeTooSoon -14174)
(defconstant $eDSAuthInvalidLogonHours -14175)
(defconstant $eDSAuthInvalidComputer -14176)
(defconstant $eDSNullParameter -14200)
(defconstant $eDSNullDataBuff -14201)
(defconstant $eDSNullNodeName -14202)
(defconstant $eDSNullRecEntryPtr -14203)
(defconstant $eDSNullRecName -14204)
(defconstant $eDSNullRecNameList -14205)
(defconstant $eDSNullRecType -14206)
(defconstant $eDSNullRecTypeList -14207)
(defconstant $eDSNullAttribute -14208)
(defconstant $eDSNullAttributeAccess -14209)
(defconstant $eDSNullAttributeValue -14210)
(defconstant $eDSNullAttributeType -14211)
(defconstant $eDSNullAttributeTypeList -14212)
(defconstant $eDSNullAttributeControlPtr -14213)
(defconstant $eDSNullAttributeRequestList -14214)
(defconstant $eDSNullDataList -14215)
(defconstant $eDSNullDirNodeTypeList -14216)
(defconstant $eDSNullAutMethod -14217)
(defconstant $eDSNullAuthStepData -14218)
(defconstant $eDSNullAuthStepDataResp -14219)
(defconstant $eDSNullNodeInfoTypeList -14220)
(defconstant $eDSNullPatternMatch -14221)
(defconstant $eDSNullNodeNamePattern -14222)
(defconstant $eDSNullTargetArgument -14223)
(defconstant $eDSEmptyParameter -14230)
(defconstant $eDSEmptyBuffer -14231)
(defconstant $eDSEmptyNodeName -14232)
(defconstant $eDSEmptyRecordName -14233)
(defconstant $eDSEmptyRecordNameList -14234)
(defconstant $eDSEmptyRecordType -14235)
(defconstant $eDSEmptyRecordTypeList -14236)
(defconstant $eDSEmptyRecordEntry -14237)
(defconstant $eDSEmptyPatternMatch -14238)
(defconstant $eDSEmptyNodeNamePattern -14239)
(defconstant $eDSEmptyAttribute -14240)
(defconstant $eDSEmptyAttributeType -14241)
(defconstant $eDSEmptyAttributeTypeList -14242)
(defconstant $eDSEmptyAttributeValue -14243)
(defconstant $eDSEmptyAttributeRequestList -14244)
(defconstant $eDSEmptyDataList -14245)
(defconstant $eDSEmptyNodeInfoTypeList -14246)
(defconstant $eDSEmptyAuthMethod -14247)
(defconstant $eDSEmptyAuthStepData -14248)
(defconstant $eDSEmptyAuthStepDataResp -14249)
(defconstant $eDSEmptyPattern2Match -14250)
(defconstant $eDSBadDataNodeLength -14255)
(defconstant $eDSBadDataNodeFormat -14256)
(defconstant $eDSBadSourceDataNode -14257)
(defconstant $eDSBadTargetDataNode -14258)
(defconstant $eDSBufferTooSmall -14260)
(defconstant $eDSUnknownMatchType -14261)
(defconstant $eDSUnSupportedMatchType -14262)
(defconstant $eDSInvalDataList -14263)
(defconstant $eDSAttrListError -14264)
(defconstant $eServerNotRunning -14270)
(defconstant $eUnknownAPICall -14271)
(defconstant $eUnknownServerError -14272)
(defconstant $eUnknownPlugIn -14273)
(defconstant $ePlugInDataError -14274)
(defconstant $ePlugInNotFound -14275)
(defconstant $ePlugInError -14276)
(defconstant $ePlugInInitError -14277)
(defconstant $ePlugInNotActive -14278)
(defconstant $ePlugInFailedToInitialize -14279)
(defconstant $ePlugInCallTimedOut -14280)
(defconstant $eNoSearchNodesFound -14290)
(defconstant $eSearchPathNotDefined -14291)
(defconstant $eNotHandledByThisNode -14292)
(defconstant $eIPCSendError -14330)
(defconstant $eIPCReceiveError -14331)
(defconstant $eServerReplyError -14332)
(defconstant $eDSTCPSendError -14350)
(defconstant $eDSTCPReceiveError -14351)
(defconstant $eDSTCPVersionMismatch -14352)
(defconstant $eDSIPUnreachable -14353)
(defconstant $eDSUnknownHost -14354)
(defconstant $ePluginHandlerNotLoaded -14400)
(defconstant $eNoPluginsLoaded -14402)
(defconstant $ePluginAlreadyLoaded -14404)
(defconstant $ePluginVersionNotFound -14406)
(defconstant $ePluginNameNotFound -14408)
(defconstant $eNoPluginFactoriesFound -14410)
(defconstant $ePluginConfigAvailNotFound -14412)
(defconstant $ePluginConfigFileNotFound -14414)
(defconstant $eCFMGetFileSysRepErr -14450)
(defconstant $eCFPlugInGetBundleErr -14452)
(defconstant $eCFBndleGetInfoDictErr -14454)
(defconstant $eCFDictGetValueErr -14456)        ;  Authentication Errors

(defconstant $eDSServerTimeout -14470)
(defconstant $eDSContinue -14471)
(defconstant $eDSInvalidHandle -14472)
(defconstant $eDSSendFailed -14473)
(defconstant $eDSReceiveFailed -14474)
(defconstant $eDSBadPacket -14475)
(defconstant $eDSInvalidTag -14476)
(defconstant $eDSInvalidSession -14477)
(defconstant $eDSInvalidName -14478)
(defconstant $eDSUserUnknown -14479)
(defconstant $eDSUnrecoverablePassword -14480)
(defconstant $eDSAuthenticationFailed -14481)
(defconstant $eDSBogusServer -14482)
(defconstant $eDSOperationFailed -14483)
(defconstant $eDSNotAuthorized -14484)
(defconstant $eDSNetInfoError -14485)
(defconstant $eDSContactMaster -14486)
(defconstant $eDSServiceUnavailable -14487)
(defconstant $eFWGetDirNodeNameErr1 -14501)
(defconstant $eFWGetDirNodeNameErr2 -14502)
(defconstant $eFWGetDirNodeNameErr3 -14503)
(defconstant $eFWGetDirNodeNameErr4 -14504)     ;  Errors received in the range -14700 : -14780 denote specific server errors.
; 	Contact Directory Services Server support when these errors are encountered

(defconstant $eParameterSendError -14700)
(defconstant $eParameterReceiveError -14720)
(defconstant $eServerSendError -14740)
(defconstant $eServerReceiveError -14760)
(defconstant $eMemoryError -14900)
(defconstant $eMemoryAllocError -14901)
(defconstant $eServerError -14910)
(defconstant $eParameterError -14915)           ;  Server response errors
; 	These errors indicate that the plug-in or server did not return the
; 	required data

(defconstant $eDataReceiveErr_NoDirRef -14950)  ;  No tDirReference returned

(defconstant $eDataReceiveErr_NoRecRef -14951)  ;  No tRecordReference returned

(defconstant $eDataReceiveErr_NoAttrListRef -14952);  No tAttributeListRef returned

(defconstant $eDataReceiveErr_NoAttrValueListRef -14953);  No tAttributeValueListRef returned

(defconstant $eDataReceiveErr_NoAttrEntry -14954);  No tAttributeEntry returned

(defconstant $eDataReceiveErr_NoAttrValueEntry -14955);  No tAttributeValueEntry returned

(defconstant $eDataReceiveErr_NoNodeCount -14956);  No node Count returned

(defconstant $eDataReceiveErr_NoAttrCount -14957);  No attribute count returned

(defconstant $eDataReceiveErr_NoRecEntry -14958);  No tRecordEntry returned

(defconstant $eDataReceiveErr_NoRecEntryCount -14959);  No record entry count returned

(defconstant $eDataReceiveErr_NoRecMatchCount -14960);  No record match count returned

(defconstant $eDataReceiveErr_NoDataBuff -14961);  No tDataBuffer returned

(defconstant $eDataReceiveErr_NoContinueData -14962);  No continue data returned

(defconstant $eDataReceiveErr_NoNodeChangeToken -14963);  No node Change Token returned

(defconstant $eNoLongerSupported -14986)
(defconstant $eUndefinedError -14987)
(defconstant $eNotYetImplemented -14988)
(defconstant $eDSLastValue -14999)
(def-mactype :tDirStatus (find-mactype ':SINT32))

(defconstant $eDSNoMatch1 0)
(defconstant $eDSAnyMatch 1)
(defconstant $eDSBeginAppleReserve1 2)
(defconstant $eDSEndAppleReserve1 #x1FFF)
(defconstant $eDSExact #x2001)
(defconstant $eDSStartsWith #x2002)
(defconstant $eDSEndsWith #x2003)
(defconstant $eDSContains #x2004)
(defconstant $eDSLessThan #x2005)
(defconstant $eDSGreaterThan #x2006)
(defconstant $eDSLessEqual #x2007)
(defconstant $eDSGreaterEqual #x2008)           ;  Advanced Search Pattern Match Specifiers

(defconstant $eDSWildCardPattern #x2009)
(defconstant $eDSRegularExpression #x200A)
(defconstant $eDSCompoundExpression #x200B)     ;  The following Specifiers are identical to the ones above
;  however, the "i" notation following the "eDS" prefix
;  denoted a case-insensitive comparision has been requested.	

(defconstant $eDSiExact #x2101)
(defconstant $eDSiStartsWith #x2102)
(defconstant $eDSiEndsWith #x2103)
(defconstant $eDSiContains #x2104)
(defconstant $eDSiLessThan #x2105)
(defconstant $eDSiGreaterThan #x2106)
(defconstant $eDSiLessEqual #x2107)
(defconstant $eDSiGreaterEqual #x2108)          ;  Advanced Search Pattern Match Specifiers

(defconstant $eDSiWildCardPattern #x2109)
(defconstant $eDSiRegularExpression #x210A)
(defconstant $eDSiCompoundExpression #x210B)    ;  Specific Node Types

(defconstant $eDSLocalNodeNames #x2200)
(defconstant $eDSSearchNodeName #x2201)
(defconstant $eDSConfigNodeName #x2202)
(defconstant $eDSLocalHostedNodes #x2203)
(defconstant $eDSAuthenticationSearchNodeName #x2201); duplicate of eDSSearchNodeName

(defconstant $eDSContactsSearchNodeName #x2204)
(defconstant $eDSNetworkSearchNodeName #x2205)
(defconstant $eDSDefaultNetworkNodes #x2206)
(defconstant $dDSBeginPlugInCustom #x3000)
(defconstant $eDSEndPlugInCustom #x4FFF)
(defconstant $eDSBeginAppleReserve2 #x5000)
(defconstant $eDSEndAppleReserve2 #xFFFE)
(defconstant $eDSNoMatch2 #xFFFF)
(def-mactype :tDirPatternMatch (find-mactype ':SINT32))

(def-mactype :tDirReference (find-mactype ':UInt32))

(def-mactype :tDirNodeReference (find-mactype ':UInt32))

(def-mactype :tClientData (find-mactype '(:pointer :void)))

(def-mactype :tBuffer (find-mactype '(:pointer :void)))

(def-mactype :tContextData (find-mactype '(:pointer :void)))
; -----------------------------------------------
; -----------------------------------------------
; -----------------------------------------------
;  Data Node Routines
(defrecord tDataBuffer
   (fBufferSize :UInt32)
   (fBufferLength :UInt32)
   (fBufferData (:array :character 1))
)

(def-mactype :tDataBufferPtr (find-mactype '(:pointer :tDataBuffer)))

(%define-record :tDataNode (find-record-descriptor ':tDataBuffer))

(def-mactype :tDataNodePtr (find-mactype '(:pointer :tDataBuffer)))
(defrecord tDataList
   (fDataNodeCount :UInt32)
   (fDataListHead (:pointer :tDataBuffer))
)

(def-mactype :tDataListPtr (find-mactype '(:pointer :tDataList)))
; -----------------------------------------------
; -----------------------------------------------
; -----------------------------------------------
(defrecord tAccessControlEntry
   (fGuestAccessFlags :UInt32)
   (fDirMemberFlags :UInt32)
   (fDirNodeMemberFlags :UInt32)
   (fOwnerFlags :UInt32)
   (fAdministratorFlags :UInt32)
)

(def-mactype :tAccessControlEntryPtr (find-mactype '(:pointer :tAccessControlEntry)))
; -----------------------------------------------
; -----------------------------------------------
; -----------------------------------------------
(defrecord tAttributeValueEntry
   (fAttributeValueID :UInt32)
                                                ;  unique ID of this data value
   (fAttributeValueData :tDataBuffer)
                                                ;  the actual data contents of this value...
)

(def-mactype :tAttributeValueEntryPtr (find-mactype '(:pointer :tAttributeValueEntry)))

(def-mactype :tAttributeValueListRef (find-mactype ':UInt32))
; -----------------------------------------------
(defrecord tAttributeEntry
   (fReserved1 :UInt32)
   (fReserved2 :tAccessControlEntry)
   (fAttributeValueCount :UInt32)
                                                ;  number of values associated with this attribute..
   (fAttributeDataSize :UInt32)
                                                ;  total byte count of all attribute values...
   (fAttributeValueMaxSize :UInt32)
                                                ;  maximum size of a value of this attribute type
   (fAttributeSignature :tDataBuffer)
                                                ;  a Unique byte-sequence representing this attribute type
                                                ;  most likely a collection of Uni-code characters..
)

(def-mactype :tAttributeEntryPtr (find-mactype '(:pointer :tAttributeEntry)))

(def-mactype :tAttributeListRef (find-mactype ':UInt32))
; -----------------------------------------------
(defrecord tRecordEntry
   (fReserved1 :UInt32)
   (fReserved2 :tAccessControlEntry)
   (fRecordAttributeCount :UInt32)
   (fRecordNameAndType :tDataBuffer)
)

(def-mactype :tRecordEntryPtr (find-mactype '(:pointer :tRecordEntry)))

(def-mactype :tRecordReference (find-mactype ':UInt32))
; -----------------------------------------------
; -----------------------------------------------
; -----------------------------------------------
;  Directory Services Function Pointers
; #pragma mark Function Pointers
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  Function Pointers for allocation & deallocation routines...
;  these routines only need to be set if some reason the standard OS routines won't do..
;  otherwise standard OS routines will be used if nothing is registered...

(def-mactype :fpCustomAllocate (find-mactype ':pointer)); (tDirReference inDirReference , tClientData inClientData , unsigned long inAllocationRequest , tBuffer * outAllocationPtr)

(def-mactype :fpCustomDeAllocate (find-mactype ':pointer)); (tDirReference inDirReference , tClientData inClientData , tBuffer inAllocationPtr)
;  Function Pointers for thread block, unblock, and yield routines...
;  these routines only need to be set if some reason the standard OS routines won't do..
;  otherwise standard OS routines will be used if nothing is registered...

(def-mactype :fpCustomThreadBlock (find-mactype ':pointer)); (tDirReference inDirReference , tClientData inClientData)

(def-mactype :fpCustomThreadUnBlock (find-mactype ':pointer)); (tDirReference inDirReference , tClientData inClientData)

(def-mactype :fpCustomThreadYield (find-mactype ':pointer)); (tDirReference inDirReference , tClientData inClientData)
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "DirServicesTypes")