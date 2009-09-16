(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OBEX.h"
; at Sunday July 2,2006 7:31:06 pm.
; 
; 	File:		OBEX.h
; 	Contains:	Technology interfaces for OBEX.
; 	Copyright:	© 2002 by Apple Computer, Inc. All rights reserved.
; 
; #pragma once

; #import <stdio.h>

; #import <stdint.h>

; #import <Foundation/Foundation.h>
; ---------------------------------------------------------------------------------------------------------------------------
; !	@header		OBEX
; 	@abstract	Public OBEX technology interfaces.	
; 	@discussion	Contains generic OBEX constants, structs, and C API used for all OBEX communication over any transport.
; 				For specific transport API, see that transport's C API. For example, if you wanted to know more about the
; 				Bluetooth OBEX implementation, see OBEXBluetooth.h.
; 				
; 				The file also contains API that will assist in the construction and deconstruction of OBEX headers to
; 				and from raw bytes, as well as the creation of vCards and vEvents.
; 

; #if 0
#| ; #pragma mark ======= OBEX.h =======
 |#

; #endif

; #ifdef	__cplusplus
#| #|
	extern "C" {
#endif
|#
 |#
; ===========================================================================================================================
; 	OBEXErrorCodes
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ======= OBEXErrorCodes =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXErrorCodes
; 	@abstract	Codes for OBEX errors. If the return value was not in the following range, then it is most likely resulting
; 				from kernel code/IOKit, and you should consult IOReturn.h for those codes.
; 	@constant	kOBEXErrorRangeMin				Minimum value in OBEX error range.
; 	@constant	kOBEXErrorRangeMax				Maximum value in OBEX error range.
; 	
; 

(def-mactype :OBEXError (find-mactype ':SInt32))
(def-mactype :OBEXErrorCodes (find-mactype ':sint32))

(defconstant $kOBEXErrorRangeMin -21850)
(defconstant $kOBEXErrorRangeMax -21899)
(defconstant $kOBEXSuccess 0)                   ;  Success at whatever you were attempting.

(defconstant $kOBEXGeneralError -21850)         ;  Catch all for misc. errors.

(defconstant $kOBEXNoResourcesError -21851)     ;  An allocation failed, etc.

(defconstant $kOBEXUnsupportedError -21852)     ;  We don't currently handle whatever you are trying to do.

(defconstant $kOBEXInternalError -21853)        ;  A problem has occurred in our internal code.

(defconstant $kOBEXBadArgumentError -21854)     ;  A bad argument was passed to an OBEX function.

(defconstant $kOBEXSessionBusyError -21875)     ;  Session is busy with a command already.

(defconstant $kOBEXSessionNotConnectedError -21876);  Session does not have an open connection.

(defconstant $kOBEXSessionBadRequestError -21877);  Whatever you are trying to do is invalid (trying to send more data than the max packet size supports, e.g.).

(defconstant $kOBEXSessionBadResponseError -21878);  The OBEX Server/client you are talking to has sent us a bad response (e.g. when a Connect Command was sent, we got back "0xA0", which is not correct).

(defconstant $kOBEXSessionNoTransportError -21879);  The underlying transport (Bluetooth, etc.) is not open/available.

(defconstant $kOBEXSessionTransportDiedError -21880);  The underlying transport connection (Bluetooth, etc.) died.

(defconstant $kOBEXSessionTimeoutError -21881)  ;  Timeout occurred performing an operation.
;  Connection over OBEX already established (returned from OBEXConnect).

(defconstant $kOBEXSessionAlreadyConnectedError -21882)
; ===========================================================================================================================
; 	OBEXMacros
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ======= OBEXMacros =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; ! @defined		OBEX Convenience Macros.
; 	@abstract		Convenience Macros for working with OBEX Header Identifiers.
; 	@discussion		The API should shield you from using these, they are included here to completeness.
; 
; #define 	GET_HEADER_ID_IS_NULL_TERMINATED_UNICODE_TEXT( HEADER_ID )		( !(HEADER_ID & 0x3F) )
; #define 	GET_HEADER_ID_IS_BYTE_SEQUENCE( HEADER_ID )						( !(HEADER_ID & 0x40) )
; #define 	GET_HEADER_ID_IS_1_BYTE_QUANTITY( HEADER_ID )					( !(HEADER_ID & 0x80) )
; #define 	GET_HEADER_ID_IS_4_BYTE_QUANTITY( HEADER_ID )					( !(HEADER_ID & 0xC0) )
; #define 	SET_HEADER_ID_IS_NULL_TERMINATED_UNICODE_TEXT( HEADER_ID )		( (HEADER_ID & 0x3F) )
; #define 	SET_HEADER_ID_IS_BYTE_SEQUENCE( HEADER_ID )						( (HEADER_ID & 0x3F) & 0x40 )
; #define 	SET_HEADER_ID_IS_1_BYTE_QUANTITY( HEADER_ID )					( (HEADER_ID & 0x3F) & 0x80 )
; #define 	SET_HEADER_ID_IS_4_BYTE_QUANTITY( HEADER_ID )					( (HEADER_ID & 0x3F) & 0xC0 )
; #define 	IS_RESPONSE_CODE_FINAL_BIT_SET( RESPONSE_CODE )					( RESPONSE_CODE >> 7L )
; #define 	STRIP_RESPONSE_CODE_FINAL_BIT( RESPONSE_CODE )					( RESPONSE_CODE & 0x7F )
; ===========================================================================================================================
; 	OBEXHeaderIdentifiers
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ======= OBEXHeaderIdentifiers =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXHeaderIdentifiers
; 	@abstract	Identifiers for OBEX Headers.
; 	@constant	kOBEXHeaderIDName						Name of the object.  Null terminated unicode text.
; 	@constant	kOBEXHeaderIDDescription				Text description of the object. Null terminated unicode text.
; 	@constant	kOBEXHeaderIDReservedRangeStart			Range includes all combos of the upper 2 bits. Reserved.
; 	@constant	kOBEXHeaderIDReservedRangeEnd			Range includes all combos of the upper 2 bits. Reserved.
; 	@constant	kOBEXHeaderIDUserDefinedRangeStart		Range includes all combos of the upper 2 bits. User defined.
; 	@constant	kOBEXHeaderIDUserDefinedRangeEnd		Range includes all combos of the upper 2 bits. User defined.
; 	@constant	kOBEXHeaderIDType						Type of object - e.g. text, html, binary, etc. Null terminated ASCII text.
; 	@constant	kOBEXHeaderIDTimeISO					Date/time stamp - ISO8601 version of time. (YYYYMMDDTHHMMSSZ)
; 	@constant	kOBEXHeaderIDTarget						Name of service that operation is destined for.
; 	@constant	kOBEXHeaderIDHTTP						An HTTP 1.x header.
; 	@constant	kOBEXHeaderIDBody						A Chunk of the object body.
; 	@constant	kOBEXHeaderIDEndOfBody					The last checking of the object body.
; 	@constant	kOBEXHeaderIDWho						Identifies the OBEX applications, used to tell if talking to a peer.
; 	@constant	kOBEXHeaderIDAppParameters				Extended application request and resposnse info.
; 	@constant	kOBEXHeaderIDAuthorizationChallenge		Authentication digest-challenge.
; 	@constant	kOBEXHeaderIDAuthorizationResponse		Authentication digest-reponse.
; 	@constant	kOBEXHeaderIDObjectClass				OBEX Object - class of object.
; 	@constant	kOBEXHeaderIDCount						Number of objects (used in Connect command).
; 	@constant	kOBEXHeaderIDLength						The length of the object in bytes. 4 byte unsigned integer value.
; 	@constant	kOBEXHeaderIDTime4Byte					Date/time stamp - 4 byte version for compat. only. Seconds since Jan 1, 1970.
; 	@constant	kOBEXHeaderIDConnectionID				An identifier used for OBEX connection multiplexing.
; 
(def-mactype :OBEXHeaderIdentifiers (find-mactype ':sint32))

(defconstant $kOBEXHeaderIDName 1)
(defconstant $kOBEXHeaderIDDescription 5)
(defconstant $kOBEXHeaderIDReservedRangeStart 16)
(defconstant $kOBEXHeaderIDReservedRangeEnd 47)
(defconstant $kOBEXHeaderIDUserDefinedRangeStart 48)
(defconstant $kOBEXHeaderIDUserDefinedRangeEnd 63)
(defconstant $kOBEXHeaderIDType 66)
(defconstant $kOBEXHeaderIDTimeISO 68)
(defconstant $kOBEXHeaderIDTarget 70)
(defconstant $kOBEXHeaderIDHTTP 71)
(defconstant $kOBEXHeaderIDBody 72)
(defconstant $kOBEXHeaderIDEndOfBody 73)
(defconstant $kOBEXHeaderIDWho 74)
(defconstant $kOBEXHeaderIDAppParameters 76)
(defconstant $kOBEXHeaderIDAuthorizationChallenge 77)
(defconstant $kOBEXHeaderIDAuthorizationResponse 78)
(defconstant $kOBEXHeaderIDObjectClass 79)
(defconstant $kOBEXHeaderIDCount #xC0)
(defconstant $kOBEXHeaderIDLength #xC3)
(defconstant $kOBEXHeaderIDTime4Byte #xC4)
(defconstant $kOBEXHeaderIDConnectionID #xCB)   ; ===========================================================================================================================
; 	OBEXOpCodeResponseValues
; ===========================================================================================================================

; #if 0
#| ; #pragma mark ======= OBEXOpCodeCommandResponseValues =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXOpCodeResponseValues
; 	@abstract	Response opCode values.
; 
(def-mactype :OBEXOpCodeResponseValues (find-mactype ':sint32))

(defconstant $kOBEXResponseCodeReservedRangeStart 0)
(defconstant $kOBEXResponseCodeReservedRangeEnd 15)
(defconstant $kOBEXResponseCodeContinue 16)
(defconstant $kOBEXResponseCodeContinueWithFinalBit #x90)
(defconstant $kOBEXResponseCodeSuccess 32)
(defconstant $kOBEXResponseCodeSuccessWithFinalBit #xA0)
(defconstant $kOBEXResponseCodeCreated 33)
(defconstant $kOBEXResponseCodeCreatedWithFinalBit #xA1)
(defconstant $kOBEXResponseCodeAccepted 34)
(defconstant $kOBEXResponseCodeAcceptedWithFinalBit #xA2)
(defconstant $kOBEXResponseCodeNonAuthoritativeInfo 35)
(defconstant $kOBEXResponseCodeNonAuthoritativeInfoWithFinalBit #xA3)
(defconstant $kOBEXResponseCodeNoContent 36)
(defconstant $kOBEXResponseCodeNoContentWithFinalBit #xA4)
(defconstant $kOBEXResponseCodeResetContent 37)
(defconstant $kOBEXResponseCodeResetContentWithFinalBit #xA5)
(defconstant $kOBEXResponseCodePartialContent 38)
(defconstant $kOBEXResponseCodePartialContentWithFinalBit #xA6)
(defconstant $kOBEXResponseCodeMultipleChoices 48)
(defconstant $kOBEXResponseCodeMultipleChoicesWithFinalBit #xB0)
(defconstant $kOBEXResponseCodeMovedPermanently 49)
(defconstant $kOBEXResponseCodeMovedPermanentlyWithFinalBit #xB1)
(defconstant $kOBEXResponseCodeMovedTemporarily 50)
(defconstant $kOBEXResponseCodeMovedTemporarilyWithFinalBit #xB2)
(defconstant $kOBEXResponseCodeSeeOther 51)
(defconstant $kOBEXResponseCodeSeeOtherWithFinalBit #xB3)
(defconstant $kOBEXResponseCodeNotModified 52)
(defconstant $kOBEXResponseCodeNotModifiedWithFinalBit #xB4)
(defconstant $kOBEXResponseCodeUseProxy 53)
(defconstant $kOBEXResponseCodeUseProxyWithFinalBit #xB5)
(defconstant $kOBEXResponseCodeBadRequest 64)
(defconstant $kOBEXResponseCodeBadRequestWithFinalBit #xC0)
(defconstant $kOBEXResponseCodeUnauthorized 65)
(defconstant $kOBEXResponseCodeUnauthorizedWithFinalBit #xC1)
(defconstant $kOBEXResponseCodePaymentRequired 66)
(defconstant $kOBEXResponseCodePaymentRequiredWithFinalBit #xC2)
(defconstant $kOBEXResponseCodeForbidden 67)
(defconstant $kOBEXResponseCodeForbiddenWithFinalBit #xC3)
(defconstant $kOBEXResponseCodeNotFound 68)
(defconstant $kOBEXResponseCodeNotFoundWithFinalBit #xC4)
(defconstant $kOBEXResponseCodeMethodNotAllowed 69)
(defconstant $kOBEXResponseCodeMethodNotAllowedWithFinalBit #xC5)
(defconstant $kOBEXResponseCodeNotAcceptable 70)
(defconstant $kOBEXResponseCodeNotAcceptableWithFinalBit #xC6)
(defconstant $kOBEXResponseCodeProxyAuthenticationRequired 71)
(defconstant $kOBEXResponseCodeProxyAuthenticationRequiredWithFinalBit #xC7)
(defconstant $kOBEXResponseCodeRequestTimeOut 72)
(defconstant $kOBEXResponseCodeRequestTimeOutWithFinalBit #xC8)
(defconstant $kOBEXResponseCodeConflict 73)
(defconstant $kOBEXResponseCodeConflictWithFinalBit #xC9)
(defconstant $kOBEXResponseCodeGone 74)
(defconstant $kOBEXResponseCodeGoneWithFinalBit #xCA)
(defconstant $kOBEXResponseCodeLengthRequired 75)
(defconstant $kOBEXResponseCodeLengthRequiredFinalBit #xCB)
(defconstant $kOBEXResponseCodePreconditionFailed 76)
(defconstant $kOBEXResponseCodePreconditionFailedWithFinalBit #xCC)
(defconstant $kOBEXResponseCodeRequestedEntityTooLarge 77)
(defconstant $kOBEXResponseCodeRequestedEntityTooLargeWithFinalBit #xCD)
(defconstant $kOBEXResponseCodeRequestURLTooLarge 78)
(defconstant $kOBEXResponseCodeRequestURLTooLargeWithFinalBit #xCE)
(defconstant $kOBEXResponseCodeUnsupportedMediaType 79)
(defconstant $kOBEXResponseCodeUnsupportedMediaTypeWithFinalBit #xCF)
(defconstant $kOBEXResponseCodeInternalServerError 80)
(defconstant $kOBEXResponseCodeInternalServerErrorWithFinalBit #xD0)
(defconstant $kOBEXResponseCodeNotImplemented 81)
(defconstant $kOBEXResponseCodeNotImplementedWithFinalBit #xD1)
(defconstant $kOBEXResponseCodeBadGateway 82)
(defconstant $kOBEXResponseCodeBadGatewayWithFinalBit #xD2)
(defconstant $kOBEXResponseCodeServiceUnavailable 83)
(defconstant $kOBEXResponseCodeServiceUnavailableWithFinalBit #xD3)
(defconstant $kOBEXResponseCodeGatewayTimeout 84)
(defconstant $kOBEXResponseCodeGatewayTimeoutWithFinalBit #xD4)
(defconstant $kOBEXResponseCodeHTTPVersionNotSupported 85)
(defconstant $kOBEXResponseCodeHTTPVersionNotSupportedWithFinalBit #xD5)
(defconstant $kOBEXResponseCodeDatabaseFull 96)
(defconstant $kOBEXResponseCodeDatabaseFullWithFinalBit #xE0)
(defconstant $kOBEXResponseCodeDatabaseLocked 97)
(defconstant $kOBEXResponseCodeDatabaseLockedWithFinalBit #xE1); ===========================================================================================================================
; 	OBEXOpCodeCommandValues
; ===========================================================================================================================

; #if 0
#| ; #pragma mark ======= OBEXOpCodeCommandValues =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXOpCodeCommandValues
; 	@abstract	Operation OpCode values for commands.
; 
(def-mactype :OBEXOpCodeCommandValues (find-mactype ':sint32))

(defconstant $kOBEXOpCodeReserved 4)
(defconstant $kOBEXOpCodeConnect #x80)          ;  High bit always set.

(defconstant $kOBEXOpCodeDisconnect #x81)       ;  High bit always set.

(defconstant $kOBEXOpCodePut 2)
(defconstant $kOBEXOpCodePutWithHighBitSet #x82)
(defconstant $kOBEXOpCodeGet 3)
(defconstant $kOBEXOpCodeGetWithHighBitSet #x83)
(defconstant $kOBEXOpCodeReservedWithHighBitSet #x84)
(defconstant $kOBEXOpCodeSetPath #x85)          ;  High bit always set.

(defconstant $kOBEXOpCodeAbort #xFF)            ;  High bit always set.

(defconstant $kOBEXOpCodeReservedRangeStart 6)
(defconstant $kOBEXOpCodeReservedRangeEnd 15)
(defconstant $kOBEXOpCodeUserDefinedStart 16)
(defconstant $kOBEXOpCodeUserDefinedEnd 31)     ; ===========================================================================================================================
; 	OBEXConnectFlags
; ===========================================================================================================================

; #if 0
#| ; #pragma mark ======= OBEXConnectFlags =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXConnectFlags
; 	@abstract	Flags for Connect command.
; 
(def-mactype :OBEXConnectFlagValues (find-mactype ':sint32))

(defconstant $kOBEXConnectFlagNone 0)
(defconstant $kOBEXConnectFlagSupportMultipleItLMPConnections 1)
(defconstant $kOBEXConnectFlag1Reserved 2)
(defconstant $kOBEXConnectFlag2Reserved 4)
(defconstant $kOBEXConnectFlag3Reserved 8)
(defconstant $kOBEXConnectFlag4Reserved 16)
(defconstant $kOBEXConnectFlag5Reserved 32)
(defconstant $kOBEXConnectFlag6Reserved 64)
(defconstant $kOBEXConnectFlag7Reserved #x80)   ; ===========================================================================================================================
; 	OBEXPutFlags
; ===========================================================================================================================

; #if 0
#| ; #pragma mark ======= OBEXPutFlags =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXPutFlags
; 	@abstract	Flags for Put command.
; 
(def-mactype :OBEXPutFlagValues (find-mactype ':sint32))

(defconstant $kOBEXPutFlagNone 0)
(defconstant $kOBEXPutFlagGoToParentDirFirst 1)
(defconstant $kOBEXPutFlagDontCreateDirectory 2)
(defconstant $kOBEXPutFlag2Reserved 4)
(defconstant $kOBEXPutFlag3Reserved 8)
(defconstant $kOBEXPutFlag4Reserved 16)
(defconstant $kOBEXPutFlag5Reserved 32)
(defconstant $kOBEXPutFlag6Reserved 64)
(defconstant $kOBEXPutFlag7Reserved #x80)       ; ===========================================================================================================================
; 	OBEXNonceFlags
; ===========================================================================================================================

; #if 0
#| ; #pragma mark ======= OBEXNonceFlags =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXNonceFlags
; 	@abstract	Flags for Nonce command during digest challenge.
; 
(def-mactype :OBEXNonceFlagValues (find-mactype ':sint32))

(defconstant $kOBEXNonceFlagNone 0)
(defconstant $kOBEXNonceFlagSendUserIDInResponse 1)
(defconstant $kOBEXNonceFlagAccessModeReadOnly 2)
(defconstant $kOBEXNonceFlag2Reserved 4)
(defconstant $kOBEXNonceFlag3Reserved 8)
(defconstant $kOBEXNonceFlag4Reserved 16)
(defconstant $kOBEXNonceFlag5Reserved 32)
(defconstant $kOBEXNonceFlag6Reserved 64)
(defconstant $kOBEXNonceFlag7Reserved #x80)     ; ===========================================================================================================================
; 	OBEXRealmValues
; ===========================================================================================================================

; #if 0
#| ; #pragma mark ======= OBEXRealmValues =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXRealmValues
; 	@abstract	Values for Realm during digest response.
; 
(def-mactype :OBEXRealmValues (find-mactype ':sint32))

(defconstant $kOBEXRealmASCII 0)
(defconstant $kOBEXRealmISO88591 1)
(defconstant $kOBEXRealmISO88592 2)
(defconstant $kOBEXRealmISO88593 3)
(defconstant $kOBEXRealmISO88594 4)
(defconstant $kOBEXRealmISO88595 5)
(defconstant $kOBEXRealmISO88596 6)
(defconstant $kOBEXRealmISO88597 7)
(defconstant $kOBEXRealmISO88598 8)
(defconstant $kOBEXRealmISO88599 9)
(defconstant $kOBEXRealmUNICODE #xFF)           ; ===========================================================================================================================
; 	OBEXVersions
; ===========================================================================================================================

; #if 0
#| ; #pragma mark ======= OBEXVersions =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXVersions
; 	@abstract	The available/supported OBEX versions. Currently there is only one!
; 
(def-mactype :OBEXVersions (find-mactype ':sint32))

(defconstant $kOBEXVersion10 16)                ; ===========================================================================================================================
; 	OBEX Types
; ===========================================================================================================================

; #if 0
#| ; #pragma mark ======= OBEX Types =======
 |#

; #endif


(def-mactype :OBEXHeaderIdentifier (find-mactype ':UInt8))

(def-mactype :OBEXVersion (find-mactype ':UInt8))

(def-mactype :OBEXFlags (find-mactype ':UInt8))

(def-mactype :OBEXOpCode (find-mactype ':UInt8))

(def-mactype :OBEXConstants (find-mactype ':UInt8))

(def-mactype :OBEXMaxPacketLength (find-mactype ':UInt16))

(def-mactype :OBEXSessionRef (find-mactype '(:pointer :OpaqueOBEXSessionRef)))
; ===========================================================================================================================
; 	OBEX Session Types
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ======= Client Session Types =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXConnectCommandResponseData
; 	@discussion	Part of the OBEXSessionEvent structure. Is readable when the event is of type
; 				kOBEXSessionEventTypeConnectCommandResponseReceived (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXConnectCommandResponseData (find-mactype ':OBEXConnectCommandResponseData))
(defrecord OBEXConnectCommandResponseData
   (serverResponseOpCode :UInt8)
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
   (maxPacketSize :UInt16)
   (version :UInt8)
   (flags :UInt8)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXDisconnectCommandResponseData	Part of the OBEXSessionEvent structure. Is readable when the event is
; 													of type kOBEXSessionEventTypeDisconnectCommandResponseReceived (see
; 													OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXDisconnectCommandResponseData (find-mactype ':OBEXDisconnectCommandResponseData))
(defrecord OBEXDisconnectCommandResponseData
   (serverResponseOpCode :UInt8)
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXPutCommandResponseData	Part of the OBEXSessionEvent structure. Is readable when the event is
; 											of type kOBEXSessionEventTypePutCommandResponseReceived (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXPutCommandResponseData (find-mactype ':OBEXPutCommandResponseData))
(defrecord OBEXPutCommandResponseData
   (serverResponseOpCode :UInt8)
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXGetCommandResponseData	Part of the OBEXSessionEvent structure. Is readable when the event is
; 											of type kOBEXSessionEventTypeGetCommandResponseReceived (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXGetCommandResponseData (find-mactype ':OBEXGetCommandResponseData))
(defrecord OBEXGetCommandResponseData
   (serverResponseOpCode :UInt8)
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXSetPathCommandResponseData	Part of the OBEXSessionEvent structure. Is readable when the event is
; 												of type kOBEXSessionEventTypeSetPathCommandResponseReceived (see
; 												OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXSetPathCommandResponseData (find-mactype ':OBEXSetPathCommandResponseData))
(defrecord OBEXSetPathCommandResponseData
   (serverResponseOpCode :UInt8)
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
   (flags :UInt8)
   (constants :UInt8)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXAbortCommandResponseData	Part of the OBEXSessionEvent structure. Is readable when the event is
; 												of type kOBEXSessionEventTypeAbortCommandResponseReceived (see
; 												OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXAbortCommandResponseData (find-mactype ':OBEXAbortCommandResponseData))
(defrecord OBEXAbortCommandResponseData
   (serverResponseOpCode :UInt8)
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
)
; ===========================================================================================================================
; 	Server Session Types
; ===========================================================================================================================

; #if 0
#| ; #pragma mark -
; #pragma mark ======= Server Session Types =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXConnectCommandData	Part of the OBEXSessionEvent structure. Is readable when the event is
; 										of type kOBEXSessionEventTypeConnectCommandReceived (see
; 										OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXConnectCommandData (find-mactype ':OBEXConnectCommandData))
(defrecord OBEXConnectCommandData
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
   (maxPacketSize :UInt16)
   (version :UInt8)
   (flags :UInt8)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXDisconnectCommandData	Part of the OBEXSessionEvent structure. Is readable when the event is
; 											of type kOBEXSessionEventTypeDisconnectCommandReceived (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXDisconnectCommandData (find-mactype ':OBEXDisconnectCommandData))
(defrecord OBEXDisconnectCommandData
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXPutCommandData			Part of the OBEXSessionEvent structure. Is readable when the event is
; 											of type kOBEXSessionEventTypePutCommandReceived (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXPutCommandData (find-mactype ':OBEXPutCommandData))
(defrecord OBEXPutCommandData
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
   (bodyDataLeftToSend :unsigned-long)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXGetCommandData			Part of the OBEXSessionEvent structure. Is readable when the event is
; 											of type kOBEXSessionEventTypeGetCommandReceived (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXGetCommandData (find-mactype ':OBEXGetCommandData))
(defrecord OBEXGetCommandData
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXSetPathCommandData		Part of the OBEXSessionEvent structure. Is readable when the event is
; 											of type kOBEXSessionEventTypeSetPathCommandReceived (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXSetPathCommandData (find-mactype ':OBEXSetPathCommandData))
(defrecord OBEXSetPathCommandData
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
   (flags :UInt8)
   (constants :UInt8)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXAbortCommandData		Part of the OBEXSessionEvent structure. Is readable when the event is
; 											of type kOBEXSessionEventTypeAbortCommandReceived (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXAbortCommandData (find-mactype ':OBEXAbortCommandData))
(defrecord OBEXAbortCommandData
   (headerDataPtr :pointer)
   (headerDataLength :unsigned-long)
)
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXErrorData		Part of the OBEXSessionEvent structure. Is readable when the event is
; 									of type kOBEXSessionEventTypeError (see OBEXSessionEventTypes).
; 

;type name? (def-mactype :OBEXErrorData (find-mactype ':OBEXErrorData))
(defrecord OBEXErrorData
   (error :SInt32)
   (dataPtr :pointer)
                                                ;  If data was associated with the error, it will be included here if possible.
   (dataLength :unsigned-long)
                                                ;  Check the size to see if there is data to be examined.
)

; #if 0
#| ; #pragma mark -
; #pragma mark ======= OBEXSessionEventTypes =======
 |#

; #endif

; ---------------------------------------------------------------------------------------------------------------------------
; !	@enum		OBEXSessionEventTypes
; 	@abstract	When a new session event occurs, your selector (or C callback) will be given an OBEXSessionEvent pointer,
; 				and in it will be a 'type' field with one of the following types in it. Based on that type, you can then
; 				read the corresponding field in the union to get out interesting data for that event type. For example,
; 				if the type of an event is a 'kOBEXSessionEventTypeConnectCommandResponseReceived', you should look in
; 				the 'OBEXConnectCommandResponseData' part of the structure's union to find more information pased to you
; 				in the event. Note that some you will never see, depending on the type of session you are using - a client
; 				or server. If you are a client (most likely case), you will never see the "Command" events, but instead
; 				you will only receive the "CommandResponse" events since you will be the issuer oft he commands, not the
; 				receiver of them. Both types of sessions will receive error type events.
; 
(def-mactype :OBEXSessionEventTypes (find-mactype ':sint32))
;  Client event types.

(defconstant $kOBEXSessionEventTypeConnectCommandResponseReceived :|OCEC|)
(defconstant $kOBEXSessionEventTypeDisconnectCommandResponseReceived :|OCED|)
(defconstant $kOBEXSessionEventTypePutCommandResponseReceived :|OCEP|)
(defconstant $kOBEXSessionEventTypeGetCommandResponseReceived :|OCEG|)
(defconstant $kOBEXSessionEventTypeSetPathCommandResponseReceived :|OCES|)
(defconstant $kOBEXSessionEventTypeAbortCommandResponseReceived :|OCEA|);  Server event types.

(defconstant $kOBEXSessionEventTypeConnectCommandReceived :|OSEC|)
(defconstant $kOBEXSessionEventTypeDisconnectCommandReceived :|OSED|)
(defconstant $kOBEXSessionEventTypePutCommandReceived :|OSEP|)
(defconstant $kOBEXSessionEventTypeGetCommandReceived :|OSEG|)
(defconstant $kOBEXSessionEventTypeSetPathCommandReceived :|OSES|)
(defconstant $kOBEXSessionEventTypeAbortCommandReceived :|OSEA|);  Shared (Server/client) event types.

(defconstant $kOBEXSessionEventTypeError :|OGEE|)
(def-mactype :OBEXSessionEventType (find-mactype ':UInt32))
; ---------------------------------------------------------------------------------------------------------------------------
; !	@struct		OBEXSessionEvent
; 	@abstract	When a new session event occurs, your selector (or C callback) will be given an OBEXSessionEvent pointer,
; 				and in it will be information you might find interesting so that you can then reply back appropriately.
; 				For example, of you receive a kOBEXSessionEventTypeConnectCommandResponseReceived event, you can then
; 				parse out the information related to that event, and if all looks well to you, you could them send a
; 				"Get" command to get a file off of the OBEX server you just connected to.
; 

;type name? (def-mactype :OBEXSessionEvent (find-mactype ':OBEXSessionEvent))
(defrecord OBEXSessionEvent
   (type :UInt32)
   (session (:pointer :OpaqueOBEXSessionRef))
   (refCon :pointer)
   (isEndOfEventData :Boolean)
   (reserved1 :pointer)
   (reserved2 :pointer)
   (:variant
                                                ;  Client session events.
   (
   (connectCommandResponseData :OBEXCONNECTCOMMANDRESPONSEDATA)
   )
   (
   (disconnectCommandResponseData :OBEXDISCONNECTCOMMANDRESPONSEDATA)
   )
   (
   (putCommandResponseData :OBEXPUTCOMMANDRESPONSEDATA)
   )
   (
   (getCommandResponseData :OBEXGETCOMMANDRESPONSEDATA)
   )
   (
   (setPathCommandResponseData :OBEXSETPATHCOMMANDRESPONSEDATA)
   )
   (
   (abortCommandResponseData :OBEXABORTCOMMANDRESPONSEDATA)
   )
                                                ;  Server session events.
   (
   (connectCommandData :OBEXCONNECTCOMMANDDATA)
   )
   (
   (disconnectCommandData :OBEXDISCONNECTCOMMANDDATA)
   )
   (
   (putCommandData :OBEXPUTCOMMANDDATA)
   )
   (
   (getCommandData :OBEXGETCOMMANDDATA)
   )
   (
   (setPathCommandData :OBEXSETPATHCOMMANDDATA)
   )
   (
   (abortCommandData :OBEXABORTCOMMANDDATA)
   )
                                                ;  Client & Server Session events.
   (
   (errorData :OBEXERRORDATA)
   )
   )
)
;  C API OBEXSessionEvent callback.

(def-mactype :OBEXSessionEventCallback (find-mactype ':pointer)); (const OBEXSessionEvent * inEvent)

; #if 0
#| ; #pragma mark -
; #pragma mark ======= Session Destroyers/Accessors =======
 |#

; #endif

; ===========================================================================================================================
; 	Session Destroyers/Accessors
; ===========================================================================================================================
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionDelete
; 	@abstract	Destroy an OBEX session. If connections are open, they will (eventually) be terminated for you.
; 	@param		inSessionRef	A valid service reference.
; 	@result		An error code value. 0 if successful.
; 

(deftrap-inline "_OBEXSessionDelete" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionHasOpenOBEXConnection
; 	@abstract	Allows you to test the session for an open OBEX connection for a particular session.
; 	@param		inSessionRef	A valid session reference.
; 	@param		outIsConnected	A valid ptr to an OBEXSessionRef; will contain the newly created session if return
; 								value is kOBEXSuccess.
; 	@result		An error code value. 0 if successful.
; 	@discussion	This method will return true only if (a) you are transport-connected to another OBEX target and
; 				(b) an OBEX Connect command has been issued and received successfully.
; 

(deftrap-inline "_OBEXSessionHasOpenOBEXConnection" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (outIsConnected (:pointer :Boolean))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionGetMaxPacketLength
; 	@abstract	Gets current max packet length.
; 	@param		inSessionRef	A valid session reference.
; 	@param		outLength		Max packet length.
; 	@result		An error code value. 0 if successful.
; 	@discussion	This value *could* change before and after a connect command has been sent or a connect
; 				command response has been received, since the recipient could negotiate a lower max packet size.
; 

(deftrap-inline "_OBEXSessionGetMaxPacketLength" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (outLength (:pointer :OBEXMAXPACKETLENGTH))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionGetAvailableCommandPayloadLength
; 	@abstract	Gets space available for your data for a particular command you are trying to send.
; 	@param		inSessionRef	A valid session reference.
; 	@param		inOpCode		An opcode of what command you are trying to send.
; 	@param		outLength		Space available for your header data in the payload area for a particular command. 
; 	@result		An error code value. 0 if successful.
; 	@discussion	The OBEXSession takes care of packaging OBEX opcodes and other information into the proper packet format,
; 				allowing you to focus on sending the proper OBEX headers in your commands and command responses. This formatting
; 				and datas requires a small bit of information that varies depending on what command or response you are
; 				sending. Thus, you should call this function to find out how much space will be left for your headers
; 				before you send the command, allowing you to properly chop up your headers before sending them. This will
; 				guarantee that (a) you use up all the available space in a packet and (b) that you do not get an error
; 				trying to send too much information at once.
; 

(deftrap-inline "_OBEXSessionGetAvailableCommandPayloadLength" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inOpCode :UInt8)
    (outLength (:pointer :OBEXMAXPACKETLENGTH))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionGetAvailableCommandPayloadLength
; 	@abstract	Gets space available for your data for a particular command response you are trying to send.
; 	@param		inSessionRef	A valid session reference.
; 	@param		inOpCode		A command opcode that you are responding to. For example, if you receiving a Put command,
; 								and want to send back a "bad request" response, you should still pass in the Put command
; 								opcode for that response.
; 	@param		outLength		Space available for your header data in the payload area for a particular command. 
; 	@result		An error code value. 0 if successful.
; 	@discussion	The OBEXSession takes care of packaging OBEX opcodes and other information into the proper packet format,
; 				allowing you to focus on sending the proper OBEX headers in your commands and command responses. This formatting
; 				and datas requires a small bit of information that varies depending on what command or response you are
; 				sending. Thus, you should call this function to find out how much space will be left for your headers
; 				before you send the command, allowing you to properly chop up your headers before sending them. This will
; 				guarantee that (a) you use up all the available space in a packet and (b) that you do not get an error
; 				trying to send too much information at once.
; 

(deftrap-inline "_OBEXSessionGetAvailableCommandResponsePayloadLength" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inOpCode :UInt8)
    (outLength (:pointer :OBEXMAXPACKETLENGTH))
   )
   :SInt32
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ======= Client Session API =======
 |#

; #endif

; ===========================================================================================================================
; 	Client Session API
; ===========================================================================================================================
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionConnect
; 	@abstract	Establishes an OBEX connection to the target device for the session. If a transport connection is not
; 				open yet, it will be opened if possible.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inFlags					Flags, as defined in the OBEX spec for this command.
; 	@param		inMaxPacketLength		Maximum packet length you wish to allow. May be negiotiated with host to be less
; 										or more than you specify.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback parameter will
; 				result in an error. If you have already established an OBEX connection and you call this again you will
; 				get an 'kOBEXSessionAlreadyConnectedError' as a result.
; 

(deftrap-inline "_OBEXSessionConnect" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inFlags :UInt8)
    (inMaxPacketLength :UInt16)
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionDisconnect
; 	@abstract	Send a disconnect command to a remote OBEX server.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionDisconnect" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionPut
; 	@abstract	Send a put command to a remote OBEX server.
; 	@param		inSessionRef		A valid session reference.
; 	@param		inIsFinalChunk		TRUE or FALSE - is this the last chunk of header data for this PUT.
; 	@param		inHeadersData		Headers containing data to PUT. Don't include your body header data here.
; 	@param		inHeadersDataLength	Size of header data. Don't include your body header data here.
; 	@param		inBodyData			Data for the BODY header to PUT. DO NOT package your data in an actual BODY header,
; 									this will be done for you, based on the finalChunk flag you pass in above (since based on
; 									this flag the header ID will be either a BODY or ENDOFBODY header).
; 	@param		inBodyDataLength	Size of Data for the BODY header to PUT.
; 	@param		inCallback			A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon		Optional parameter; can contain anything you wish. Will be returned in your callback
; 									just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionPut" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inIsFinalChunk :Boolean)
    (inHeadersData :pointer)
    (inHeadersDataLength :unsigned-long)
    (inBodyData :pointer)
    (inBodyDataLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionGet
; 	@abstract	Send a get command to a remote OBEX server.
; 	@param		inSessionRef		A valid session reference.
; 	@param		inIsFinalChunk		TRUE or FALSE - is this the last chunk of header data for this GET.
; 	@param		inHeadersData		Headers containing data to GET.
; 	@param		inHeadersDataLength	Size of header data.
; 	@param		inCallback			A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon		Optional parameter; can contain anything you wish. Will be returned in your callback
; 								just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionGet" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inIsFinalChunk :Boolean)
    (inHeadersData :pointer)
    (inHeadersDataLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionAbort
; 	@abstract	Send an abort command to a remote OBEX server.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionAbort" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefcon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionSetPath
; 	@abstract	Send a set path command to a remote OBEX server.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inFlags					Flags, as defined in the OBEX spec for this command.
; 	@param		inConstants				Constants, as defined in the OBEX spec for this command.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionSetPath" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inFlags :UInt8)
    (inConstants :UInt8)
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefcon :pointer)
   )
   :SInt32
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ======= Server Session API =======
 |#

; #endif

; ===========================================================================================================================
; 	Server Session API
; ===========================================================================================================================
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionConnectResponse
; 	@abstract	Send a response to a connect command to the remote client.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inResponseOpCode		What response code you want to send to the remote client.
; 	@param		inFlags					Flags, as defined in the OBEX spec for this command.
; 	@param		inConstants				Constants, as defined in the OBEX spec for this command.
; 	@param		inMaxPacketLength		Max packet length you want to support. Must be smaller or equal to the max packet
; 										length specified by the remote client. 
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionConnectResponse" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inResponseOpCode :UInt8)
    (inFlags :UInt8)
    (inMaxPacketLength :UInt16)
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionDisconnectResponse
; 	@abstract	Send a response to a disconnect command to the remote client.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inResponseOpCode		What response code you want to send to the remote client.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionDisconnectResponse" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inResponseOpCode :UInt8)
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionGetResponse
; 	@abstract	Send a response to a get command to the remote client.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inResponseOpCode		What response code you want to send to the remote client.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionGetResponse" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inResponseOpCode :UInt8)
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionPutResponse
; 	@abstract	Send a response to a put command to the remote client.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inResponseOpCode		What response code you want to send to the remote client.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionPutResponse" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inResponseOpCode :UInt8)
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionAbortResponse
; 	@abstract	Send a response to a abort command to the remote client.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inResponseOpCode		What response code you want to send to the remote client.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionAbortResponse" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inResponseOpCode :UInt8)
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionSetPathResponse
; 	@abstract	Send a response to a set path command to the remote client.
; 	@param		inSessionRef			A valid session reference.
; 	@param		inResponseOpCode		What response code you want to send to the remote client.
; 	@param		inOptionalHeaders		Ptr to optional headers you can supply to the command. DO NOT dispose of this
; 										pointer until you callback is called with a success.
; 	@param		inOptionalHeadersLength	Size of data at the specified ptr.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	As all commands for OBEX sessions, this command is asynchronous only. A NULL callback paramter will
; 				result in an error.
; 

(deftrap-inline "_OBEXSessionSetPathResponse" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inResponseOpCode :UInt8)
    (inOptionalHeaders :pointer)
    (inOptionalHeadersLength :unsigned-long)
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXSessionSetServerCallback
; 	@param		inSessionRef			A valid session reference.
; 	@param		inCallback				A valid callback. Will be called for progress, errors and completion by server
; 										sessions only.
; 	@param		inUserRefCon			Optional parameter; can contain anything you wish. Will be returned in your
; 										callback just as you passed it.
; 	@result		An error code value. 0 if successful.
; 	@discussion	Sets callback to be used when an event occurs on an OBEXSession. This is important for OBEX servers, as you
; 				will need a way to be called back when the first command is sent to you. So, be sure to set yourself
; 				up to listen for events when you are ready to receive them.
; 

(deftrap-inline "_OBEXSessionSetServerCallback" 
   ((inSessionRef (:pointer :OpaqueOBEXSessionRef))
    (inCallback :pointer)
    (inUserRefCon :pointer)
   )
   :SInt32
() )

; #if 0
#| ; #pragma mark -
; #pragma mark ======= Utilities API =======
 |#

; #endif

;  vCard charsets
(defconstant $kCharsetStringISO88591 "CHARSET=ISO-8859-1")
; #define		kCharsetStringISO88591			"CHARSET=ISO-8859-1"
(defconstant $kCharsetStringUTF8 "UTF-8")
; #define		kCharsetStringUTF8				"UTF-8"
;  vEvent encodings
(defconstant $kEncodingStringQuotedPrintable "QUOTED-PRINTABLE")
; #define		kEncodingStringQuotedPrintable	"QUOTED-PRINTABLE"
(defconstant $kEncodingStringBase64 "BASE-64")
; #define		kEncodingStringBase64			"BASE-64"
(defconstant $kEncodingString8Bit "8BIT")
; #define		kEncodingString8Bit				"8BIT"
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXCreateVCard
; 	@abstract	Creates a formatted vCard, ready to be sent over OBEX or whatever.
; 	@param		inNameCharset					A pointer to the charset data used for the name. Pass in a #defined charset
; 												for ease of use.
; 	@param		inNameCharsetLength				Length of name charset assed in above.
; 	@param		inFirstName						Pointer to data with Person's first name.
; 	@param		inFirstNameLength				Length of Person's first name passed in above.
; 	@param		inLastName						Pointer to data with Person's last name.
; 	@param		inLastNameLength				Length of Person's last name passed in above.
; 	@param		inFriendlyName					Pointer to data with Person's Friendly name.
; 	@param		inFriendlyNameLength			Length of Person's Friendly name passed in above.
; 	@param		inHomePhone						Pointer to data with Person's Home phone number.
; 	@param		inHomePhoneLength				Length of Person's Home phone number passed in above.
; 	@param		inWorkPhone						Work phone number.
; 	@param		inWorkPhoneLength				Length of Person's Work phone number passed in above.
; 	@param		inCellPhone						Cell phone number.
; 	@param		inCellPhoneLength				Length of Person's Cell phone number passed in above.
; 	@param		inFaxPhone						Fax phone number.
; 	@param		inFaxPhoneLength				Length of Person's Fax phone number passed in above.
; 	@param		inEMailAddress					EMailAddress of person.
; 	@param		inEMailAddressLength			Length of Person's EMailAddress passed in above.
; 	@param		inEMailAddressCharset			Charset of EMailAddress of person.
; 	@param		inEMailAddressCharsetLength		Length of Person's EMailAddress charset passed in above.
; 	@param		inOrganization					Pointer to Organization/business data.
; 	@param		inOrganizationLength			Length of Organization/business data.
; 	@param		inOrganizationCharset			Pointer to the charset the Organization/business is in.
; 	@param		inOrganizationCharsetLength		Length of data for the Organization/business charset.
; 	@param		inTitle							Pointer to data with Title of person in biz/org.
; 	@param		inTitleLength					Length of Title of person in biz/org.
; 	@param		inOrganizationCharset			Pointer to the charset the Title is in.
; 	@param		inOrganizationCharsetLength		Length of data for the Title charset.
; 	@result		An NSData* containing the compiled data. nil if we failed.
; 	@discussion	All parameters are optional. The NSData returned to you is NOT retained. Retain it if you want to keep it.
; 
#|
 confused about NSDATA uint32_t inFirstNameLength #\, const void * inLastName #\, uint32_t inLastNameLength #\, const void * inFriendlyName #\, uint32_t inFriendlyNameLength #\, const void * inNameCharset #\, uint32_t inNameCharsetLength #\, const void * inHomePhone #\, uint32_t inHomePhoneLength #\, const void * inWorkPhone #\, uint32_t inWorkPhoneLength #\, const void * inCellPhone #\, uint32_t inCellPhoneLength #\, const void * inFaxPhone #\, uint32_t inFaxPhoneLength #\, const void * inEMailAddress #\, uint32_t inEMailAddressLength #\, const void * inEMailAddressCharset #\, uint32_t inEMailAddressCharsetLength #\, const void * inOrganization #\, uint32_t inOrganizationLength #\, const void * inOrganizationCharset #\, uint32_t inOrganizationCharsetLength #\, const void * inTitle #\, uint32_t inTitleLength #\, const void * inTitleCharset #\, uint32_t inTitleCharsetLength #\)
|#
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function	OBEXCreateVEvent
; 	@abstract	Creates a formatted vEvent, ready to be sent over OBEX or whatever. You probably will embed the output
; 				in a vCalendar event.
; 	@param		inCharset			The Charset the passed data is in. Pass in a #defined charset for ease of use.
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@param		inEncoding			The encoding of the summary and location fields.
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@param		inEventStartDate	Start of event date, in the (ISO8601) format: YYYYMMDDTHHMMSS. e.g. 19960415T083000 = 8:30 am on April 15, 1996. All time values should be in LOCAL time.
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@param		inEventEndDate		End of event date.
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@param		inAlarmDate			Date of Alarm for event, in the format: YYYYMMDDTHHMMSS.
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@param		inCategory			Category of event, such as "MEETING" or "PHONE CALL".
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@param		inSummary			Summary of event. Max length is 36 bytes. Longer will result in a bad argument error.
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@param		inLocation			Summary of event. Max length is 20 bytes. Longer will result in a bad argument error.
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@param		inXIRMCLUID			The IRMC Local Unique Identifier Label, max length 12 bytes. Longer will result in
; 									a bad argument error.
; 	@param		inCharsetLength		The length of the Charset passed data.
; 	@result		A valid NSData* - nil if we failed.
; 	@discussion	All parameters are optional. The NSData returned to you is NOT retained. Retain it if you want to keep it.
; 				Be aware that certain devices such as Ericsson phones MUST have certain fields, such as a start and end date.
; 
#|
 confused about NSDATA uint32_t inCharsetLength #\, const char * inEncoding #\, uint32_t inEncodingLength #\, const char * inEventStartDate #\, uint32_t inEventStartDateLength #\, const char * inEventEndDate #\, uint32_t inEventEndDateLength #\, const char * inAlarmDate #\, uint32_t inAlarmDateLength #\, const char * inCategory #\, uint32_t inCategoryLength #\, const char * inSummary #\, uint32_t inSummaryLength #\, const char * inLocation #\, uint32_t inLocationLength #\, const char * inXIRMCLUID #\, uint32_t inXIRMCLUIDLength #\)
|#
; #pragma mark -
; #pragma mark ======= Header Contruction Kit =======
; 
; 	Header Contruction Kit
; 	
; 	You can use the following functions to ease the burden of creating your properly formatted OBEX headers.
; 	Generally, the strategy is either you will have a ptr to some data full of headers, and you
; 	can use OBEXGetHeaders to get you a easily-accessed CFDictionary (or NSDictionary) full of headers and
; 	use the keys below to obtain the actual header values. Conversely, you can create a CFDictionary full
; 	of headers using the OBEXAddXXXXXHeader() functions, and then pass this to an OBEX command using the
; 	OBEXHeadersToBytes( headerDictionary ) function to get the raw bytes.
; 
; ---------------------------------------------------------------------------------------------------------------------------
; 
; 	These are defined keys to assist in locating headers in the dictionary of headers returned from the OBEXGetHeaders()
; 	function, described below.
; 
(def-mactype :kOBEXHeaderIDKeyName (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyType (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyDescription (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyTimeISO (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyTime4Byte (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyTarget (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyHTTP (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyBody (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyEndOfBody (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyWho (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyAppParameters (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyAuthorizationChallenge (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyAuthorizationResponse (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyObjectClass (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyCount (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyLength (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyConnectionID (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyByteSequence (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyUnknownUnicodeText (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyUnknownByteSequence (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyUnknown1ByteQuantity (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyUnknown4ByteQuantity (find-mactype ':CFStringRef))
(def-mactype :kOBEXHeaderIDKeyUserDefined (find-mactype ':CFStringRef))
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXGetHeaders
; 	@abstract		Take a data blob and looks for OBEX headers.
; 	@param			inData			The data chunk with the headers you are interested in.
; 	@param			inDataSize		The size of the buffer you are passing in.
; 	@result			A CFDictionary with the headers found in the data blob inside it.
; 	@discussion
; 	You should use this when your callback for PUTs, GETs, etc. give you a data chunk
; 	and a size. Pass these params to this function and you will receive a dictionary
; 	back full of the parse headers. You can use the CFDictionary calls to get objects
; 	out of it, based on the header keys defined above. You are responsible for releasing
; 	the CFDictionary returned to you.
; 	Example usage:
; 	<pre>
; 	CFDictionaryRef   dictionary = OBEXGetHeaders( data, dataLength );
; 	if( dictionary )
; 	{
; 		if( CFDictionaryGetCountOfKey( dictionary, kOBEXHeaderIDKeyName ) > 0 )
; 		{			
; 			CFStringRef theStringRef;
; 			
; 			theStringRef = (CFStringRef) CFDictionaryGetValue( dictionary, kOBEXHeaderIDKeyName );
; 			if( theStringRef )
; 			{				
; 				// Display it, use it as a filename, whatever.
; 			}
; 		}
; 		
; 		if( CFDictionaryGetCountOfKey( dictionary, kOBEXHeaderIDKeyConnectionID ) > 0 )
; 		{
; 			CFDataRef theDataRef;
; 			
; 			theDataRef = (CFDataRef) CFDictionaryGetValue( dictionary, kOBEXHeaderIDKeyConnectionID );
; 			if( theDataRef )
; 			{
; 				// now we have data representing the connection ID.
; 			}
; 		}
; 		
; 		CFRelease( dictionary );
; 	}
; 	</pre>
; 

(deftrap-inline "_OBEXGetHeaders" 
   ((inData :pointer)
    (inDataSize :unsigned-long)
   )
   (:pointer :__CFDictionary)
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXHeadersToBytes
; 	@abstract		Converts a dictionary of headers to a data pointer, from which you can extract as bytes and pass to
; 					the OBEX command/response functions.
; 	@param			dictionaryOfHeaders		dictionary that you have added headers to with the above OBEXAddXXXHeader functions.		
; 	@result			Mutable data ref containing the bytes of all headers.
; 	@discussion		Returns a CFMutableDataRef containing all the header data found in the dictionary, formatted according to
; 					the OBEX/IrMC spec. YOU MUST RELEASE IT when you are finished with it (ie. when the OBEX request is complete).
; 					All OBEX-specification defined headers are supported and should be returned to the dictionary. Use the
; 					keys defined above to get headers from dictionary. Example usage:
; 	<pre>
; 	Example usage:
; 
; 	CFMutableDictionaryRef	dictionary;
; 	CFMutableDataRef		mGetHeadersDataRef;
; 	uint8_t* 				headerDataPtr;
; 	uint32_t 				headerDataLength;
; 	
; 	dictionary = CFDictionaryCreateMutable( NULL, 1, NULL, NULL );
; 	
; 	// Package up desired headers.
; 
; 	OBEXAddTypeHeader( CFSTR( "text/x-vCard" ), dictionary ); 
; 
; 	mGetHeadersDataRef = OBEXHeadersToBytes( dictionary );
; 
; 	headerDataPtr = CFDataGetBytePtr( mGetHeadersDataRef );
; 	headerDataLength = CFDataGetLength( mGetHeadersDataRef );
; 	
; 	// From here I can pass it to any OBEX command, such as OBEXPut...
; 	</pre>
; 					
; 

(deftrap-inline "_OBEXHeadersToBytes" 
   ((dictionaryOfHeaders (:pointer :__CFDictionary))
   )
   (:pointer :__CFData)
() )
; #pragma mark -
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddNameHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			name		name you want to add to the OBEX header dictionary.			
; 	@param			dictRef		dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Name header - OBEX Spec, 2.2.2: (2-byte) Null terminated unicode string.
; 

(deftrap-inline "_OBEXAddNameHeader" 
   ((name (:pointer :__CFString))
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddDescriptionHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			description		Description you want to add to the OBEX header dictionary.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Description header - OBEX Spec, 2.2.6: (2-byte) Null terminated unicode string.
; 

(deftrap-inline "_OBEXAddDescriptionHeader" 
   ((description (:pointer :__CFString))
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddCountHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			count		Count value you want to add to the OBEX header dictionary.			
; 	@param			dictRef		dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Count header - OBEX Spec, 2.2.1: 4 byte unsigned integer
; 

(deftrap-inline "_OBEXAddCountHeader" 
   ((count :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddTime4ByteHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			time4Byte		4-byte time value you want to add to the OBEX header dictionary.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Time4Byte headers - OBEX Spec, 2.2.5: 4 Bytes
; 

(deftrap-inline "_OBEXAddTime4ByteHeader" 
   ((time4Byte :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddLengthHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			length			Value of Length header you want to add to the OBEX header dictionary.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Length header - OBEX Spec, 2.2.4: 4 byte unsigned integer
; 

(deftrap-inline "_OBEXAddLengthHeader" 
   ((length :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddTypeHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			description		Description containing the name you want to add to the OBEX header dictionary.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Type header - OBEX Spec, 2.2.3: 1-byte Null terminated ascii string.
; 

(deftrap-inline "_OBEXAddTypeHeader" 
   ((type (:pointer :__CFString))
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddTimeISOHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			inHeaderData		Target header data.			
; 	@param			inHeaderDataLength	Length of Target header data.
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		TimeISO header - OBEX Spec, 2.2.5: Byte Sequence
; 

(deftrap-inline "_OBEXAddTimeISOHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddTargetHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			inHeaderData		Target header data.			
; 	@param			inHeaderDataLength	Length of Target header data.
; 	@param			dictRef				dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Target header - OBEX Spec, 2.2.7: Byte Sequence
; 

(deftrap-inline "_OBEXAddTargetHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddHTTPHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			inHeaderData		HTTP header data.			
; 	@param			inHeaderDataLength	Length of HTTP header data.
; 	@param			dictRef				dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		HTTP header - OBEX Spec, 2.2.8: Byte Sequence
; 

(deftrap-inline "_OBEXAddHTTPHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddBodyHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			inHeaderData		Body header data.			
; 	@param			inHeaderDataLength	Length of Body header data.
; 	@param			isEndOfBody			Set this flag if you want an end of body header instead of a body header.
; 	@param			dictRef				dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Body,EndOfBody headers - OBEX Spec, 2.2.9: Byte Sequence
; 

(deftrap-inline "_OBEXAddBodyHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (isEndOfBody :Boolean)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddWhoHeader
; 	@abstract		Add a CFStringRef to a dictionary of OBEXheaders.
; 	@param			inHeaderData		Who header data.			
; 	@param			inHeaderDataLength	Length of Who header data.	
; 	@param			dictRef				dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Who headers - OBEX Spec, 2.2.10: Byte Sequence
; 

(deftrap-inline "_OBEXAddWhoHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddConnectionIDHeader
; 	@abstract		Add an bytes representing a connection ID to a dictionary of OBEX headers.
; 	@param			inHeaderData		Connection ID data. Should be 4 bytes in length only.
; 	@param			inHeaderDataLength	Length of Connection ID data. This should ONLY be set to equal 4.		
; 	@param			dictRef				dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		ConnectionID headers - OBEX Spec, 2.2.10: Byte Sequence
; 					
; 					*** IMPORTANT NOTE: In bluetooth 1.0, using this function will allow you to pass in any value.
; 										You should not pass more than 4 bytes ever. In later releases, if the length
; 										passed is not 4, a kOBEXBadArgumentError error will be returned. ***
; 

(deftrap-inline "_OBEXAddConnectionIDHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddApplicationParameterHeader
; 	@abstract		Add an bytes representing a connection ID to a dictionary of OBEX headers.
; 	@param			inHeaderData		Application parameter data - should be tag/length/value triplets.
; 	@param			inHeaderDataLength	Length of application parameter data.		
; 	@param			dictRef				dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Application Request/Response Parameter headers - OBEX Spec, 2.2.11: Byte Sequence
; 

(deftrap-inline "_OBEXAddApplicationParameterHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddByteSequenceHeader
; 	@abstract		Add an arbitrary byte sequence header to a dictionary of OBEXheaders.
; 	@param			inHeaderData		bytes you want to put in the byte sequence header.			
; 	@param			inHeaderDataLength	length of the bytes you want to put in the byte sequence header.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Byte Sequence header - OBEX Spec, 2.2.5: Byte sequence.
; 

(deftrap-inline "_OBEXAddByteSequenceHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddObjectClassHeader
; 	@abstract		Add an object class header to a dictionary of OBEXheaders.
; 	@param			inHeaderData		bytes you want to put in the object class header.			
; 	@param			inHeaderDataLength	length of the bytes you want to put in the object class header.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Object Class header - OBEX Spec, 2.2.15: Byte sequence.
; 

(deftrap-inline "_OBEXAddObjectClassHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddAuthorizationChallengeHeader
; 	@abstract		Add an authorization challenge header to a dictionary of OBEXheaders.
; 	@param			inHeaderData		bytes you want to put in the authorization challenge header.			
; 	@param			inHeaderDataLength	length of the bytes you want to put in authorization challenge header.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Authorization Challenge header - OBEX Spec, 2.2.13: Authorization Challenge.
; 

(deftrap-inline "_OBEXAddAuthorizationChallengeHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddAuthorizationResponseHeader
; 	@abstract		Add an authorization Response header to a dictionary of OBEXheaders.
; 	@param			inHeaderData		bytes you want to put in the authorization Response header.			
; 	@param			inHeaderDataLength	length of the bytes you want to put in authorization Response header.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		Authorization Response header - OBEX Spec, 2.2.14: Authorization Response.
; 

(deftrap-inline "_OBEXAddAuthorizationResponseHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; ---------------------------------------------------------------------------------------------------------------------------
; !	@function		OBEXAddUserDefinedHeader
; 	@abstract		Add a user-defined custom header to a dictionary of OBEXheaders.
; 	@param			inHeaderData		bytes you want to put in the user-defined header.			
; 	@param			inHeaderDataLength	length of the bytes you want to put in user-defined header.			
; 	@param			dictRef			dictionary you have allocated to hold the headers. Make sure it's mutable.		
; 	@result			Error code, kOBEXSuccess (0) if success.
; 	@discussion		User Defined header - OBEX Spec, 2.2.20: User Defined Headers.
; 

(deftrap-inline "_OBEXAddUserDefinedHeader" 
   ((inHeaderData :pointer)
    (inHeaderDataLength :UInt32)
    (dictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; #ifdef	__cplusplus
#| #|
	}
#endif
|#
 |#

(provide-interface "OBEX")