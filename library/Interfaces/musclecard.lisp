(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:musclecard.h"
; at Sunday July 2,2006 7:30:32 pm.
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
;             Title  : musclecard.h
;             Package: MuscleCard Framework
;             Author : David Corcoran
;             Date   : 11/28/01
;             License: Copyright (C) 2001 David Corcoran
;                      <corcoran@linuxnet.com>
;             Purpose: This abstracts the MUSCLE Card Edge Inteface
; 
; 	    You may not remove this header from this file
; 	    without prior permission from the author.
;  
; *******************************************************************
; #ifndef __musclecard_h__
; #define __musclecard_h__
; #ifdef __cplusplus
#| #|
extern "C"
{
#endif
|#
 |#
; #ifdef WIN32
#| #|
#include "PCSC.h"
#endif
|#
 |#
; #ifndef __APPLE__
#| #|
#include <mscdefines.h>
|#
 |#

; #else

(require-interface "PCSC/mscdefines")

; #endif

; ***************
;      * Return codes *
;      ***************
; * success 
(defconstant $MSC_SUCCESS 36864)
; #define MSC_SUCCESS                        0x9000
; * There have been memory problems on the card 
(defconstant $MSC_NO_MEMORY_LEFT 39937)
; #define MSC_NO_MEMORY_LEFT                 0x9C01
; * Entered PIN is not correct 
(defconstant $MSC_AUTH_FAILED 39938)
; #define MSC_AUTH_FAILED                    0x9C02
; * Required operation is not allowed in actual circumstances 
(defconstant $MSC_OPERATION_NOT_ALLOWED 39939)
; #define MSC_OPERATION_NOT_ALLOWED          0x9C03
; * Required operation is inconsistent with memory contents 
(defconstant $MSC_INCONSISTENT_STATUS 39940)
; #define MSC_INCONSISTENT_STATUS            0x9C04
; * Required feature is not (yet) supported 
(defconstant $MSC_UNSUPPORTED_FEATURE 39941)
; #define MSC_UNSUPPORTED_FEATURE            0x9C05
; * Required operation was not authorized because of a lack of privileges 
(defconstant $MSC_UNAUTHORIZED 39942)
; #define MSC_UNAUTHORIZED                   0x9C06
; * Required object is missing 
(defconstant $MSC_OBJECT_NOT_FOUND 39943)
; #define MSC_OBJECT_NOT_FOUND               0x9C07
; * New object ID already in use 
(defconstant $MSC_OBJECT_EXISTS 39944)
; #define MSC_OBJECT_EXISTS                  0x9C08
; * Algorithm specified is not correct 
(defconstant $MSC_INCORRECT_ALG 39945)
; #define MSC_INCORRECT_ALG                  0x9C09
; * Verify operation detected an invalid signature 
(defconstant $MSC_SIGNATURE_INVALID 39947)
; #define MSC_SIGNATURE_INVALID              0x9C0B
; * Operation has been blocked for security reason  
(defconstant $MSC_IDENTITY_BLOCKED 39948)
; #define MSC_IDENTITY_BLOCKED               0x9C0C
; * Unspecified error 
(defconstant $MSC_UNSPECIFIED_ERROR 39949)
; #define MSC_UNSPECIFIED_ERROR              0x9C0D
; * PCSC and driver transport errors 
(defconstant $MSC_TRANSPORT_ERROR 39950)
; #define MSC_TRANSPORT_ERROR                0x9C0E
; * Invalid parameter given 
(defconstant $MSC_INVALID_PARAMETER 39951)
; #define MSC_INVALID_PARAMETER              0x9C0F
; * Incorrect P1 parameter 
(defconstant $MSC_INCORRECT_P1 39952)
; #define MSC_INCORRECT_P1                   0x9C10
; * Incorrect P2 parameter 
(defconstant $MSC_INCORRECT_P2 39953)
; #define MSC_INCORRECT_P2                   0x9C11
; * End of sequence 
(defconstant $MSC_SEQUENCE_END 39954)
; #define MSC_SEQUENCE_END                   0x9C12
; * For debugging purposes 
(defconstant $MSC_INTERNAL_ERROR 40191)
; #define MSC_INTERNAL_ERROR                 0x9CFF
; *****************************************************
; 
; 	 * These returns are beyond the protocol specification 
; 	 
; 
; 	 * and only exist here to provide return codes for the 
; 	 
; 
; 	 * additional functions provided by the MuscleCard API 
; 	 
; 
; 	 * beyond the protocol specification.  
; 	 
; *****************************************************
; * A blocking event has been cancelled 
(defconstant $MSC_CANCELLED 40016)
; #define MSC_CANCELLED                      0x9C50
; 
; 	 * The buffer provided is too short 
; 	 
(defconstant $MSC_INSUFFICIENT_BUFFER 40017)
; #define MSC_INSUFFICIENT_BUFFER            0x9C51
; 
; 	 * The selected token is not recognized 
; 	 
(defconstant $MSC_UNRECOGNIZED_TOKEN 40018)
; #define MSC_UNRECOGNIZED_TOKEN             0x9C52
; 
; 	 * The PC/SC services is not available 
; 	 
(defconstant $MSC_SERVICE_UNRESPONSIVE 40019)
; #define MSC_SERVICE_UNRESPONSIVE           0x9C53
; 
; 	 * The action has timed out 
; 	 
(defconstant $MSC_TIMEOUT_OCCURRED 40020)
; #define MSC_TIMEOUT_OCCURRED               0x9C54
; 
; 	 * The token has been removed 
; 	 
(defconstant $MSC_TOKEN_REMOVED 40021)
; #define MSC_TOKEN_REMOVED                  0x9C55
; 
; 	 * The token has been reset 
; 	 
(defconstant $MSC_TOKEN_RESET 40022)
; #define MSC_TOKEN_RESET                    0x9C56
; 
; 	 * The token has been inserted 
; 	 
(defconstant $MSC_TOKEN_INSERTED 40023)
; #define MSC_TOKEN_INSERTED                 0x9C57
; 
; 	 * The token is unresponsive 
; 	 
(defconstant $MSC_TOKEN_UNRESPONSIVE 40024)
; #define MSC_TOKEN_UNRESPONSIVE             0x9C58
; 
; 	 * The handle is invalid 
; 	 
(defconstant $MSC_INVALID_HANDLE 40025)
; #define MSC_INVALID_HANDLE                 0x9C59
; 
; 	 * Invalid sharing 
; 	 
(defconstant $MSC_SHARING_VIOLATION 40032)
; #define MSC_SHARING_VIOLATION              0x9C60
(defconstant $MSC_BLOCKSTATUS_RESUME 0)
; #define MSC_BLOCKSTATUS_RESUME             0x0000
(defconstant $MSC_BLOCKSTATUS_BLOCKING 1)
; #define MSC_BLOCKSTATUS_BLOCKING           0x0001
(defconstant $MSC_BLOCKSTATUS_CANCELLING 2)
; #define MSC_BLOCKSTATUS_CANCELLING         0x0002
; 
; 	 * Some boundary defines 
; 	 
(defconstant $MSC_MAX_KEYS 16)
; #define MSC_MAX_KEYS                       16
(defconstant $MSC_MAX_PINS 8)
; #define MSC_MAX_PINS                        8
(defconstant $MSC_SIZEOF_KEYPACKET 200)
; #define MSC_SIZEOF_KEYPACKET              200
(defconstant $MSC_MAXSIZEOF_APDU_DATALEN 255)
; #define MSC_MAXSIZEOF_APDU_DATALEN        255
(defconstant $MSC_PERCENT_STEPSIZE 1000)
; #define MSC_PERCENT_STEPSIZE             1000
(defconstant $MSC_SINGLE_READ_PACKET 255)
; #define MSC_SINGLE_READ_PACKET            255
(defconstant $MSC_MAXSIZE_TOKENARRAY 255)
; #define MSC_MAXSIZE_TOKENARRAY            255
; 
; 	 * KeyPair Generation algorithms 
; 	 
(defconstant $MSC_GEN_ALG_RSA 0)
; #define MSC_GEN_ALG_RSA	        0x00
(defconstant $MSC_GEN_ALG_RSA_CRT 1)
; #define MSC_GEN_ALG_RSA_CRT	0x01
(defconstant $MSC_GEN_ALG_DSA 2)
; #define MSC_GEN_ALG_DSA	        0x02
(defconstant $MSC_GEN_ALG_DES 3)
; #define MSC_GEN_ALG_DES	        0x03
(defconstant $MSC_GEN_ALG_3DES 4)
; #define MSC_GEN_ALG_3DES	0x04
(defconstant $MSC_GEN_ALG_3DES3 5)
; #define MSC_GEN_ALG_3DES3	0x05
; 
; 	 * Blob encodings in KeyBlob structure 
; 	 
(defconstant $MSC_BLOB_ENC_PLAIN 0)
; #define MSC_BLOB_ENC_PLAIN	0x00
(defconstant $MSC_BLOB_ENC_CRYPT 1)
; #define MSC_BLOB_ENC_CRYPT	0x01
; 
; 	 * Key Type in Key Blobs 
; 	 
(defconstant $MSC_KEY_RSA_PUBLIC 1)
; #define MSC_KEY_RSA_PUBLIC       0x01
(defconstant $MSC_KEY_RSA_PRIVATE 2)
; #define MSC_KEY_RSA_PRIVATE      0x02
(defconstant $MSC_KEY_RSA_PRIVATE_CRT 3)
; #define MSC_KEY_RSA_PRIVATE_CRT  0x03
(defconstant $MSC_KEY_DSA_PUBLIC 4)
; #define MSC_KEY_DSA_PUBLIC       0x04
(defconstant $MSC_KEY_DSA_PRIVATE 5)
; #define MSC_KEY_DSA_PRIVATE      0x05
(defconstant $MSC_KEY_DES 6)
; #define MSC_KEY_DES              0x06
(defconstant $MSC_KEY_3DES 7)
; #define MSC_KEY_3DES             0x07
(defconstant $MSC_KEY_3DES3 8)
; #define MSC_KEY_3DES3            0x08
; 
; 	 * Key generation options TODO: add other 
; 	 
(defconstant $MSC_OPT_DEFAULT 0)
; #define MSC_OPT_DEFAULT		 0x00
(defconstant $MSC_OPT_RSA_PUB_EXP 1)
; #define MSC_OPT_RSA_PUB_EXP      0x01
(defconstant $MSC_OPT_DSA_GPQ 2)
; #define MSC_OPT_DSA_GPQ          0x02
; 
; 	 * Cipher operations in ComputeCrypt() 
; 	 
(defconstant $MSC_CIPHER_INIT 1)
; #define MSC_CIPHER_INIT	        0x01
(defconstant $MSC_CIPHER_PROCESS 2)
; #define MSC_CIPHER_PROCESS	0x02
(defconstant $MSC_CIPHER_FINAL 3)
; #define MSC_CIPHER_FINAL	0x03
; 
; 	 * Cipher modes in ComputeCrypt() 
; 	 
(defconstant $MSC_MODE_RSA_NOPAD 0)
; #define MSC_MODE_RSA_NOPAD	0x00
(defconstant $MSC_MODE_RSA_PAD_PKCS1 1)
; #define MSC_MODE_RSA_PAD_PKCS1	0x01
(defconstant $MSC_MODE_DSA_SHA 16)
; #define MSC_MODE_DSA_SHA	0x10
(defconstant $MSC_MODE_DES_CBC_NOPAD 32)
; #define MSC_MODE_DES_CBC_NOPAD	0x20
(defconstant $MSC_MODE_DES_ECB_NOPAD 33)
; #define MSC_MODE_DES_ECB_NOPAD	0x21
; 
; 	 * Cipher directions 
; 	 
(defconstant $MSC_DIR_SIGN 1)
; #define MSC_DIR_SIGN		0x01
(defconstant $MSC_DIR_VERIFY 2)
; #define MSC_DIR_VERIFY		0x02
(defconstant $MSC_DIR_ENCRYPT 3)
; #define MSC_DIR_ENCRYPT		0x03
(defconstant $MSC_DIR_DECRYPT 4)
; #define MSC_DIR_DECRYPT		0x04
; 
; 	 * Sequence options in ListXXX() 
; 	 
(defconstant $MSC_SEQUENCE_RESET 0)
; #define MSC_SEQUENCE_RESET	0x00
(defconstant $MSC_SEQUENCE_NEXT 1)
; #define MSC_SEQUENCE_NEXT	0x01
; 
; 	 * Zero flag in DeleteObject() 
; 	 
(defconstant $MSC_ZF_DEFAULT 0)
; #define MSC_ZF_DEFAULT	0x00
(defconstant $MSC_ZF_WRITE_ZERO 1)
; #define MSC_ZF_WRITE_ZERO	0x01
; 
; 	 * Some defines for ID's Bitmask 
; 	 
(defconstant $MSC_AUT_ALL 0)
; #define MSC_AUT_ALL       0x0000
(defconstant $MSC_AUT_NONE 65535)
; #define MSC_AUT_NONE      0xFFFF
(defconstant $MSC_AUT_PIN_0 1)
; #define MSC_AUT_PIN_0     0x0001
(defconstant $MSC_AUT_PIN_1 2)
; #define MSC_AUT_PIN_1     0x0002
(defconstant $MSC_AUT_PIN_2 4)
; #define MSC_AUT_PIN_2     0x0004
(defconstant $MSC_AUT_PIN_3 8)
; #define MSC_AUT_PIN_3     0x0008
(defconstant $MSC_AUT_PIN_4 16)
; #define MSC_AUT_PIN_4     0x0010
(defconstant $MSC_AUT_KEY_0 256)
; #define MSC_AUT_KEY_0     0x0100
(defconstant $MSC_AUT_KEY_1 512)
; #define MSC_AUT_KEY_1     0x0200
(defconstant $MSC_AUT_KEY_2 1024)
; #define MSC_AUT_KEY_2     0x0400
(defconstant $MSC_AUT_KEY_3 2048)
; #define MSC_AUT_KEY_3     0x0800
(defconstant $MSC_AUT_KEY_4 4096)
; #define MSC_AUT_KEY_4     0x1000
(defconstant $MSC_AUT_KEY_5 8192)
; #define MSC_AUT_KEY_5     0x2000
(defconstant $MSC_AUT_USR_0 16384)
; #define MSC_AUT_USR_0     0x4000
(defconstant $MSC_AUT_USR_1 32768)
; #define MSC_AUT_USR_1     0x8000
; 
; 	 * This structure allows you to customize your MuscleCard. It is used
; 	 * in MSCWriteFramework to specify attributes you may want to set in
; 	 * this 'personalization' routine and will be getting new values in
; 	 * future revisions of the API 
; 	 
(defconstant $MSC_INIT_DEFAULT_KEY 0)
; #define MSC_INIT_DEFAULT_KEY     0x00	/* Use card's default transport
(defconstant $MSC_INIT_IGNORE_KEY 1)
; #define MSC_INIT_IGNORE_KEY      0x01	/* Don't verify any key at all */
(defconstant $MSC_INIT_USE_KEY 2)
; #define MSC_INIT_USE_KEY         0x02	/* Use the key in this struct */
(defrecord MSCInitTokenParams   (transportKey (:array :UInt8 $MAX_BUFFER_SIZE))
   (transportKeyLen :UInt32)
   (transportBehavior :UInt8)
   (objectMemory :UInt32)
   (newTransportKey (:array :UInt8 $MAX_BUFFER_SIZE))
   (newTransportKeyLen :UInt32)
   (defaultCHV (:array :UInt8 $MAX_BUFFER_SIZE))
   (defaultCHVLen :UInt32)
   (defaultCHVTries :UInt8)
   (defaultCHVUnblock (:array :UInt8 $MAX_BUFFER_SIZE))
   (defaultCHVUnblockSize :UInt32)
   (defaultCHVUnblockTries :UInt8)
   (createObjectACL :UInt16)
   (createKeysACL :UInt16)
   (createPINsACL :UInt16)
   (maxNumberKeys :UInt8)
   (maxNumberPINs :UInt8)
   (maxNumberObjects :UInt16)
#|
 confused about , * MSCLPInitTokenParams
|#
)
; 
; 	 * Direction policy bitmasks for MSCKeyPolicy 
; 	 
(defconstant $MSC_KEYPOLICY_MODE_RSA_NOPAD 1)
; #define MSC_KEYPOLICY_MODE_RSA_NOPAD      0x0001
(defconstant $MSC_KEYPOLICY_MODE_RSA_PAD_PKCS1 2)
; #define MSC_KEYPOLICY_MODE_RSA_PAD_PKCS1  0x0002
(defconstant $MSC_KEYPOLICY_MODE_DSA_SHA 4)
; #define MSC_KEYPOLICY_MODE_DSA_SHA        0x0004
(defconstant $MSC_KEYPOLICY_MODE_DES_CBC_NOPAD 8)
; #define MSC_KEYPOLICY_MODE_DES_CBC_NOPAD  0x0008
(defconstant $MSC_KEYPOLICY_MODE_DES_ECB_NOPAD 16)
; #define MSC_KEYPOLICY_MODE_DES_ECB_NOPAD  0x0010
(defconstant $MSC_KEYPOLICY_DIR_SIGN 256)
; #define MSC_KEYPOLICY_DIR_SIGN            0x0100
(defconstant $MSC_KEYPOLICY_DIR_VERIFY 512)
; #define MSC_KEYPOLICY_DIR_VERIFY          0x0200
(defconstant $MSC_KEYPOLICY_DIR_ENCRYPT 1024)
; #define MSC_KEYPOLICY_DIR_ENCRYPT         0x0400
(defconstant $MSC_KEYPOLICY_DIR_DECRYPT 2048)
; #define MSC_KEYPOLICY_DIR_DECRYPT         0x0800
(defrecord MSCKeyPolicy
   (cipherMode :UInt16)
   (cipherDirection :UInt16)
#|
 confused about , * MSCLPKeyPolicy
|#
)
(defrecord MSCKeyACL
   (readPermission :UInt16)
   (writePermission :UInt16)
   (usePermission :UInt16)
#|
 confused about , * MSCLPKeyACL
|#
)
(defrecord MSCObjectACL
   (readPermission :UInt16)
   (writePermission :UInt16)
   (deletePermission :UInt16)
#|
 confused about , * MSCLPObjectACL #\, MSCCertACL #\, * MSCLPCertACL
|#
)
(defrecord MSCGenKeyParams
   (algoType :UInt8)
   (keySize :UInt16)
   (privateKeyACL :MSCKEYACL)
   (publicKeyACL :MSCKEYACL)
   (privateKeyPolicy :MSCKEYPOLICY)
   (publicKeyPolicy :MSCKEYPOLICY)
   (keyGenOptions :UInt8)
   (pOptParams (:pointer :UInt8))
   (optParamsSize :UInt32)
#|
 confused about , * MSCLPGenKeyParams
|#
)

(def-mactype :MSCLPKeyBlob (find-mactype ':MSCPUChar8))
(defrecord MSCKeyInfo
   (keyNum :UInt8)
   (keyType :UInt8)
   (keyPartner :UInt8)                          ;  Do not use (deprecated) 
   (keyMapping :UInt8)                          ;  Do not use (deprecated) 
   (keySize :UInt16)
   (keyPolicy :MSCKEYPOLICY)
   (keyACL :MSCKEYACL)
#|
 confused about , * MSCLPKeyInfo
|#
)
(defrecord MSCCryptInit
   (keyNum :UInt8)
   (cipherMode :UInt8)
   (cipherDirection :UInt8)
   (optParams (:pointer :UInt8))
   (optParamsSize :UInt16)
#|
 confused about , * MSCLPCryptInit
|#
)
; 
; 	 * Scope definitions for MSCListTokens 
; 	 
(defconstant $MSC_LIST_KNOWN 1)
; #define MSC_LIST_KNOWN     1	/* Lists known tokens only */
(defconstant $MSC_LIST_SLOTS 2)
; #define MSC_LIST_SLOTS     2	/* Lists all slots, with or without tokens 
(defconstant $MSC_LIST_ALL 3)
; #define MSC_LIST_ALL       3	/* Lists all tokens, known or not */
(defconstant $MSC_TOKEN_EMPTY_STR "Token Removed")
; #define MSC_TOKEN_EMPTY_STR    "Token Removed"
(defconstant $MSC_TOKEN_UNKNOWN_STR "Token Unknown")
; #define MSC_TOKEN_UNKNOWN_STR  "Token Unknown"
(defconstant $MSC_TOKEN_TYPE_REMOVED 1)
; #define MSC_TOKEN_TYPE_REMOVED   1	/* Token was removed at one point */
(defconstant $MSC_TOKEN_TYPE_UNKNOWN 2)
; #define MSC_TOKEN_TYPE_UNKNOWN   2	/* Token is unknown, state is fine */
(defconstant $MSC_TOKEN_TYPE_KNOWN 4)
; #define MSC_TOKEN_TYPE_KNOWN     4	/* Token is known, state is fine */
(defconstant $MSC_TOKEN_TYPE_RESET 8)
; #define MSC_TOKEN_TYPE_RESET     8	/* Token is known, was reset */
; 
; 	 * endAction definitions for MSCReleaseConnection 
; 	 
; #define MSC_LEAVE_TOKEN    SCARD_LEAVE_CARD
; #define MSC_RESET_TOKEN    SCARD_RESET_CARD
; #define MSC_EJECT_TOKEN    SCARD_EJECT_CARD
; 
; 	 * sharingMode for MSCEstablishConnection 
; 	 
; #define MSC_SHARE_SHARED     SCARD_SHARE_SHARED
; #define MSC_SHARE_EXCLUSIVE  SCARD_SHARE_EXCLUSIVE
; #define MSC_SHARE_DIRECT     SCARD_SHARE_DIRECT
; 
; 	 * tokenState for MSCWaitForTokenEvent 
; 	 
(defconstant $MSC_STATE_UNAWARE 16384)
; #define MSC_STATE_UNAWARE      0x4000
; #define MSC_STATE_CHANGED      SCARD_STATE_CHANGED
; #define MSC_STATE_UNKNOWN      SCARD_STATE_UNKNOWN
; #define MSC_STATE_UNAVAILABLE  SCARD_STATE_UNAVAILABLE
; #define MSC_STATE_EMPTY        SCARD_STATE_EMPTY
; #define MSC_STATE_PRESENT      SCARD_STATE_PRESENT
; #define MSC_STATE_EXCLUSIVE    SCARD_STATE_EXCLUSIVE
; #define MSC_STATE_INUSE        SCARD_STATE_INUSE
; #define MSC_STATE_MUTE         SCARD_STATE_MUTE
; #define MSC_NO_TIMEOUT         INFINITE
; ********************* TAGS for GetStatus *******************************
; 
; 	 * high level tags 
; 	 
(defconstant $MSC_TAG_SUPPORT_FUNCTIONS 101)
; #define MSC_TAG_SUPPORT_FUNCTIONS     101	/* Supported functions */
(defconstant $MSC_TAG_SUPPORT_CRYPTOALG 102)
; #define MSC_TAG_SUPPORT_CRYPTOALG     102	/* Supported crypto algorithms 
; 
; 	 * crypto related tags 
; 	 
(defconstant $MSC_TAG_CAPABLE_RSA 103)
; #define MSC_TAG_CAPABLE_RSA           103	/* RSA capabilities */
(defconstant $MSC_TAG_CAPABLE_DSA 104)
; #define MSC_TAG_CAPABLE_DSA           104	/* DSA capabilities */
(defconstant $MSC_TAG_CAPABLE_ECURVE 105)
; #define MSC_TAG_CAPABLE_ECURVE        105	/* Eliptic Curve capabilities */
(defconstant $MSC_TAG_CAPABLE_ELGAMAL 106)
; #define MSC_TAG_CAPABLE_ELGAMAL       106	/* El Gamal capabilities */
(defconstant $MSC_TAG_CAPABLE_KEY_AUTH 180)
; #define MSC_TAG_CAPABLE_KEY_AUTH      180	/* Key import/gen AUT needed */
(defconstant $MSC_TAG_CAPABLE_DES 201)
; #define MSC_TAG_CAPABLE_DES           201	/* DES capabilities */
(defconstant $MSC_TAG_CAPABLE_3DES 202)
; #define MSC_TAG_CAPABLE_3DES          202	/* Triple DES capabilities */
(defconstant $MSC_TAG_CAPABLE_IDEA 203)
; #define MSC_TAG_CAPABLE_IDEA          203	/* IDEA capabilities */
(defconstant $MSC_TAG_CAPABLE_AES 204)
; #define MSC_TAG_CAPABLE_AES           204	/* AES capabilities */
(defconstant $MSC_TAG_CAPABLE_BLOWFISH 205)
; #define MSC_TAG_CAPABLE_BLOWFISH      205	/* Blowfish capabilities */
(defconstant $MSC_TAG_CAPABLE_TWOFISH 206)
; #define MSC_TAG_CAPABLE_TWOFISH       206	/* Twofish capabilities */
(defconstant $MSC_TAG_CAPABLE_MD5 207)
; #define MSC_TAG_CAPABLE_MD5           207	/* MD5 capabilities */
(defconstant $MSC_TAG_CAPABLE_SHA1 208)
; #define MSC_TAG_CAPABLE_SHA1          208	/* SHA1 capabilities */
; 
; 	 * object related tags 
; 	 
(defconstant $MSC_TAG_CAPABLE_OBJ_ATTR 301)
; #define MSC_TAG_CAPABLE_OBJ_ATTR      301	/* returns general attributes */
(defconstant $MSC_TAG_CAPABLE_OBJ_IDSIZE 302)
; #define MSC_TAG_CAPABLE_OBJ_IDSIZE    302	/* returns size of object id */
(defconstant $MSC_TAG_CAPABLE_OBJ_AUTH 303)
; #define MSC_TAG_CAPABLE_OBJ_AUTH      303	/* return AUT needed for
(defconstant $MSC_TAG_CAPABLE_OBJ_MAXNUM 304)
; #define MSC_TAG_CAPABLE_OBJ_MAXNUM    304	/* maximum number of objects */
; 
; 	 * pin related tags 
; 	 
(defconstant $MSC_TAG_CAPABLE_PIN_ATTR 401)
; #define MSC_TAG_CAPABLE_PIN_ATTR      401	/* returns general attributes */
(defconstant $MSC_TAG_CAPABLE_PIN_MAXNUM 402)
; #define MSC_TAG_CAPABLE_PIN_MAXNUM    402	/* returns max number of pins */
(defconstant $MSC_TAG_CAPABLE_PIN_MINSIZE 403)
; #define MSC_TAG_CAPABLE_PIN_MINSIZE   403	/* returns minimum pin size */
(defconstant $MSC_TAG_CAPABLE_PIN_MAXSIZE 404)
; #define MSC_TAG_CAPABLE_PIN_MAXSIZE   404	/* returns maximum pin size */
(defconstant $MSC_TAG_CAPABLE_PIN_CHARSET 405)
; #define MSC_TAG_CAPABLE_PIN_CHARSET   405	/* char set supported
(defconstant $MSC_TAG_CAPABLE_PIN_POLICY 406)
; #define MSC_TAG_CAPABLE_PIN_POLICY    406	/* returns pin policy
(defconstant $MSC_TAG_CAPABLE_PIN_AUTH 407)
; #define MSC_TAG_CAPABLE_PIN_AUTH      407	/* return AUT needed for
(defconstant $MSC_TAG_CAPABLE_ID_STATE 501)
; #define MSC_TAG_CAPABLE_ID_STATE      501	/* returns state capability */
(defconstant $MSC_TAG_CAPABLE_RANDOM 600)
; #define MSC_TAG_CAPABLE_RANDOM        600	/* Random number capabilities */
(defconstant $MSC_TAG_CAPABLE_RANDOM_MAX 601)
; #define MSC_TAG_CAPABLE_RANDOM_MAX    601	/* Maximum random number */
(defconstant $MSC_TAG_CAPABLE_RANDOM_MIN 602)
; #define MSC_TAG_CAPABLE_RANDOM_MIN    602	/* Minimum random number */
; ********************************* END OF TAGS **************************
; 
; 	 * Bitmask for TAG MSC_TAG_SUPPORT_FUNCTIONS 
; 	 
(defconstant $MSC_SUPPORT_GENKEYS 1)
; #define MSC_SUPPORT_GENKEYS           0x00000001
(defconstant $MSC_SUPPORT_IMPORTKEY 2)
; #define MSC_SUPPORT_IMPORTKEY         0x00000002
(defconstant $MSC_SUPPORT_EXPORTKEY 4)
; #define MSC_SUPPORT_EXPORTKEY         0x00000004
(defconstant $MSC_SUPPORT_COMPUTECRYPT 8)
; #define MSC_SUPPORT_COMPUTECRYPT      0x00000008
(defconstant $MSC_SUPPORT_EXTAUTH 16)
; #define MSC_SUPPORT_EXTAUTH           0x00000010
(defconstant $MSC_SUPPORT_LISTKEYS 32)
; #define MSC_SUPPORT_LISTKEYS          0x00000020
(defconstant $MSC_SUPPORT_CREATEPIN 64)
; #define MSC_SUPPORT_CREATEPIN         0x00000040
(defconstant $MSC_SUPPORT_VERIFYPIN 128)
; #define MSC_SUPPORT_VERIFYPIN         0x00000080
(defconstant $MSC_SUPPORT_CHANGEPIN 256)
; #define MSC_SUPPORT_CHANGEPIN         0x00000100
(defconstant $MSC_SUPPORT_UNBLOCKPIN 512)
; #define MSC_SUPPORT_UNBLOCKPIN        0x00000200
(defconstant $MSC_SUPPORT_LISTPINS 1024)
; #define MSC_SUPPORT_LISTPINS          0x00000400
(defconstant $MSC_SUPPORT_CREATEOBJECT 2048)
; #define MSC_SUPPORT_CREATEOBJECT      0x00000800
(defconstant $MSC_SUPPORT_DELETEOBJECT 4096)
; #define MSC_SUPPORT_DELETEOBJECT      0x00001000
(defconstant $MSC_SUPPORT_WRITEOBJECT 8192)
; #define MSC_SUPPORT_WRITEOBJECT       0x00002000
(defconstant $MSC_SUPPORT_READOBJECT 16384)
; #define MSC_SUPPORT_READOBJECT        0x00004000
(defconstant $MSC_SUPPORT_LISTOBJECTS 32768)
; #define MSC_SUPPORT_LISTOBJECTS       0x00008000
(defconstant $MSC_SUPPORT_LOGOUTALL 65536)
; #define MSC_SUPPORT_LOGOUTALL         0x00010000
(defconstant $MSC_SUPPORT_GETCHALLENGE 131072)
; #define MSC_SUPPORT_GETCHALLENGE      0x00020000
; 
; 	 * Bitmask for MSC_TAG_SUPPORT_CRYPTOALG 
; 	 
(defconstant $MSC_SUPPORT_RSA 1)
; #define MSC_SUPPORT_RSA           0x00000001	/* Supports RSA */
(defconstant $MSC_SUPPORT_DSA 2)
; #define MSC_SUPPORT_DSA           0x00000002	/* Supports DSA */
(defconstant $MSC_SUPPORT_ECURVE 4)
; #define MSC_SUPPORT_ECURVE        0x00000004	/* Supports Eliptic Curve */
(defconstant $MSC_SUPPORT_ELGAMAL 8)
; #define MSC_SUPPORT_ELGAMAL       0x00000008	/* Supports El Gamal */
(defconstant $MSC_SUPPORT_DES 16)
; #define MSC_SUPPORT_DES           0x00000010	/* Supports DES */
(defconstant $MSC_SUPPORT_3DES 32)
; #define MSC_SUPPORT_3DES          0x00000020	/* Supports Triple DES */
(defconstant $MSC_SUPPORT_IDEA 64)
; #define MSC_SUPPORT_IDEA          0x00000040	/* Supports IDEA */
(defconstant $MSC_SUPPORT_AES 128)
; #define MSC_SUPPORT_AES           0x00000080	/* Supports AES */
(defconstant $MSC_SUPPORT_BLOWFISH 256)
; #define MSC_SUPPORT_BLOWFISH      0x00000100	/* Supports Blowfish */
(defconstant $MSC_SUPPORT_TWOFISH 512)
; #define MSC_SUPPORT_TWOFISH       0x00000200	/* Supports Twofish */
(defconstant $MSC_SUPPORT_SHA1 1024)
; #define MSC_SUPPORT_SHA1          0x00000400	/* Supports SHA1 */
(defconstant $MSC_SUPPORT_MD5 2048)
; #define MSC_SUPPORT_MD5           0x00000800	/* Supports MD5 */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_RSA 
; 	 
(defconstant $MSC_CAPABLE_RSA_512 1)
; #define MSC_CAPABLE_RSA_512       0x00000001	/* Supports 512 bit RSA */
(defconstant $MSC_CAPABLE_RSA_768 2)
; #define MSC_CAPABLE_RSA_768       0x00000002	/* Supports 768 bit RSA */
(defconstant $MSC_CAPABLE_RSA_1024 4)
; #define MSC_CAPABLE_RSA_1024      0x00000004	/* Supports 1024 bit RSA */
(defconstant $MSC_CAPABLE_RSA_2048 8)
; #define MSC_CAPABLE_RSA_2048      0x00000008	/* Supports 2048 bit RSA */
(defconstant $MSC_CAPABLE_RSA_4096 16)
; #define MSC_CAPABLE_RSA_4096      0x00000010	/* Supports 4096 bit RSA */
(defconstant $MSC_CAPABLE_RSA_KEYGEN 4096)
; #define MSC_CAPABLE_RSA_KEYGEN    0x00001000	/* Support RSA key-gen */
(defconstant $MSC_CAPABLE_RSA_NOPAD 8192)
; #define MSC_CAPABLE_RSA_NOPAD     0x00002000	/* Supports RSA NO PAD */
(defconstant $MSC_CAPABLE_RSA_PKCS1 16384)
; #define MSC_CAPABLE_RSA_PKCS1     0x00004000	/* Supports PKCS padding */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_DSA 
; 	 
(defconstant $MSC_CAPABLE_DSA_512 1)
; #define MSC_CAPABLE_DSA_512       0x00000001	/* Supports 512 bit DSA */
(defconstant $MSC_CAPABLE_DSA_768 2)
; #define MSC_CAPABLE_DSA_768       0x00000002	/* Supports 768 bit DSA */
(defconstant $MSC_CAPABLE_DSA_1024 4)
; #define MSC_CAPABLE_DSA_1024      0x00000004	/* Supports 1024 bit DSA */
(defconstant $MSC_CAPABLE_DSA_2048 8)
; #define MSC_CAPABLE_DSA_2048      0x00000008	/* Supports 2048 bit DSA */
(defconstant $MSC_CAPABLE_DSA_4096 16)
; #define MSC_CAPABLE_DSA_4096      0x00000010	/* Supports 4096 bit DSA */
(defconstant $MSC_CAPABLE_DSA_KEYGEN 4096)
; #define MSC_CAPABLE_DSA_KEYGEN    0x00001000	/* Supports DSA key-gen */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_DES 
; 	 
(defconstant $MSC_CAPABLE_DES_KEYGEN 4096)
; #define MSC_CAPABLE_DES_KEYGEN    0x00001000	/* Supports DES key-gen */
(defconstant $MSC_CAPABLE_DES_CBC 8192)
; #define MSC_CAPABLE_DES_CBC       0x00002000	/* Supports DES CBC mode */
(defconstant $MSC_CAPABLE_DES_EBC 16384)
; #define MSC_CAPABLE_DES_EBC       0x00004000	/* Supports DES EBC mode */
(defconstant $MSC_CAPABLE_DES_ECB 32768)
; #define MSC_CAPABLE_DES_ECB       0x00008000	/* Supports DES ECB mode */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_3DES 
; 	 
(defconstant $MSC_CAPABLE_3DES_KEYGEN 4096)
; #define MSC_CAPABLE_3DES_KEYGEN   0x00001000	/* Supports 3DES key-gen */
(defconstant $MSC_CAPABLE_3DES_3KEY 8192)
; #define MSC_CAPABLE_3DES_3KEY     0x00002000	/* Support 3 key 3DES */
(defconstant $MSC_CAPABLE_3DES_CBC 16384)
; #define MSC_CAPABLE_3DES_CBC      0x00004000	/* Supports 3DES CBC mode */
(defconstant $MSC_CAPABLE_3DES_EBC 32768)
; #define MSC_CAPABLE_3DES_EBC      0x00008000	/* Supports 3DES EBC mode */
(defconstant $MSC_CAPABLE_3DES_ECB 65536)
; #define MSC_CAPABLE_3DES_ECB      0x00010000	/* Supports 3DES ECB mode */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_IDEA 
; 	 
(defconstant $MSC_CAPABLE_IDEA_KEYGEN 4096)
; #define MSC_CAPABLE_IDEA_KEYGEN   0x00001000	/* Supports IDEA key-gen */
(defconstant $MSC_CAPABLE_IDEA_CBC 8192)
; #define MSC_CAPABLE_IDEA_CBC      0x00002000	/* Supports IDEA CBC mode */
(defconstant $MSC_CAPABLE_IDEA_ECB 32768)
; #define MSC_CAPABLE_IDEA_ECB      0x00008000	/* Supports IDEA ECB mode */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_AES 
; 	 
(defconstant $MSC_CAPABLE_AES_KEYGEN 4096)
; #define MSC_CAPABLE_AES_KEYGEN    0x00001000	/* Supports AES key-gen */
(defconstant $MSC_CAPABLE_AES_CBC 8192)
; #define MSC_CAPABLE_AES_CBC       0x00002000	/* Supports AES CBC mode */
(defconstant $MSC_CAPABLE_AES_ECB 32768)
; #define MSC_CAPABLE_AES_ECB       0x00008000	/* Supports AES ECB mode */
; **********************************
;      Bitmasks for other crypto algorithms 
;      will come in future releases 
;     ***********************************
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_OBJ_ATTR 
; 	 
(defconstant $MSC_CAPABLE_OBJ_ZERO 65536)
; #define MSC_CAPABLE_OBJ_ZERO      0x00010000	/* Supports zero on DEL */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_PIN_ATTR 
; 	 
(defconstant $MSC_CAPABLE_PIN_RESET 256)
; #define MSC_CAPABLE_PIN_RESET     0x00000100	/* Unblock reset's pin */
(defconstant $MSC_CAPABLE_PIN_LEAVE 512)
; #define MSC_CAPABLE_PIN_LEAVE     0x00000200	/* Unblock leaves pin */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_PIN_CHARSET 
; 	 
(defconstant $MSC_CAPABLE_PIN_A_Z 1)
; #define MSC_CAPABLE_PIN_A_Z       0x00000001	/* Supports uppercase A-Z */
(defconstant $MSC_CAPABLE_PIN_a_z 2)
; #define MSC_CAPABLE_PIN_a_z       0x00000002	/* Supports lowercase a-z */
(defconstant $MSC_CAPABLE_PIN_0_9 4)
; #define MSC_CAPABLE_PIN_0_9       0x00000004	/* Supports numbers 0-9 */
(defconstant $MSC_CAPABLE_PIN_SPACE 8)
; #define MSC_CAPABLE_PIN_SPACE     0x00000008	/* Supports spaces */
(defconstant $MSC_CAPABLE_PIN_CALC 16)
; #define MSC_CAPABLE_PIN_CALC      0x00000010	/* Supports + - / * % .= */
(defconstant $MSC_CAPABLE_PIN_NONALPHA 32)
; #define MSC_CAPABLE_PIN_NONALPHA  0x00000020	/* Supports all other
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_PIN_POLICY 
; 	 
(defconstant $MSC_CAPABLE_PIN_A_Z 1)
; #define MSC_CAPABLE_PIN_A_Z       0x00000001	/* Requires uppercase A-Z */
(defconstant $MSC_CAPABLE_PIN_a_z 2)
; #define MSC_CAPABLE_PIN_a_z       0x00000002	/* Requires lowercase a-z */
(defconstant $MSC_CAPABLE_PIN_0_9 4)
; #define MSC_CAPABLE_PIN_0_9       0x00000004	/* Requires numbers 0-9 */
(defconstant $MSC_CAPABLE_PIN_NONALPHA 32)
; #define MSC_CAPABLE_PIN_NONALPHA  0x00000020	/* Requires
(defconstant $MSC_CAPABLE_PIN_HISTORY 4096)
; #define MSC_CAPABLE_PIN_HISTORY   0x00001000	/* Checks pin history */
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_ID_STATE 
; 	 
(defconstant $MSC_CAPABLE_ID_STATE 1)
; #define MSC_CAPABLE_ID_STATE      0x00000001	/* maintains logged id
; 
; 	 * Bitmask for TAG MSC_TAG_CAPABLE_RANDOM 
; 	 
(defconstant $MSC_CAPABLE_RANDOM_SEED 1)
; #define MSC_CAPABLE_RANDOM_SEED   0x00000001	/* Uses supplied seed */
; 
; 	 * Structure used in MSCGetStatus to return status and capability
; 	 * information about the inserted token 
; 	 
(defrecord MSCStatusInfo
   (appVersion :UInt16)
                                                ;  Applet version number 
   (swVersion :UInt16)
                                                ;  Software version number 
   (freeMemory :UInt32)
                                                ;  Free memory for objects 
   (totalMemory :UInt32)
                                                ;  Total amount of memory 
   (usedPINs :UInt8)
                                                ;  Number of pins used 
   (usedKeys :UInt8)
                                                ;  Number of keys used 
   (loggedID :UInt16)
                                                ;  Bitmask of ID's verified 
#|
 confused about , * MSCLPStatusInfo
|#
)
(defrecord MSCObjectInfo   (objectID (:array :character 16))
   (objectSize :UInt32)
   (objectACL :MSCOBJECTACL)
#|
 confused about , * MSCLPObjectInfo
|#
)
; *****************************************************************
; 
; 	 * Connection oriented functions 
; 	 
; 
; 	 * These functions do not coorespond to internal library funcions 
; 	 
; 
; 	 * but serve to connect to tokens.  You can still use the internal 
; 	 
; 
; 	 * PC/SC calls to do this.  These provide an abstract means.  
; 	 
; *****************************************************************
; 
; 	 * Lists all known tokens on the system 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCListTokens" 
   ((listScope :UInt32)
                                                ;  defines the scope to
; 												 * return 
    (tokenArray :msclptokeninfo)
                                                ;  token struct array 
                                                ;  Length of array 
    (arrayLength (:pointer :UInt32))
   )
   :UInt32
() )
; 
; 	 * Establishes a connection to the specified token 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCEstablishConnection" 
   ((tokenStruct :msclptokeninfo)
                                                ;  The
; 																 * struct
; 																 * of
; 																 * token 
    (sharingMode :UInt32)
                                                ;  Mode of sharing 
    (applicationName (:pointer :UInt8))
                                                ;  The applet ID/Name 
    (nameSize :UInt32)
                                                ;  The ID/Name Size 
                                                ;  Returned connection 
    (pConnection :msclptokenconnection)
   )
   :UInt32
() )
; 
; 	 * Releases a connection to the specified token 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCReleaseConnection" 
   ((pConnection :msclptokenconnection)
                                                ;  Connection 
; 																	 * handle 
; 																	 
                                                ;  Action to perform 
    (endAction :UInt32)
   )
   :UInt32
() )
; 
; 	 * Blocks for an event to occur on a token 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCWaitForTokenEvent" 
   ((tokenArray :msclptokeninfo)
                                                ;  Array of
; 															 * token
; 															 * structs 
    (arraySize :UInt32)
                                                ;  Size of the array 
                                                ;  Timeout 
    (timeoutValue :UInt32)
   )
   :UInt32
() )
; 
; 	 * Cancels a pending MSCWaitForTokenEvent 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCCancelEventWait" 
                                                ;  No parameters 
   (
   )
   :UInt32
() )
; 
; 	 * Registers a callback function for event change 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCCallbackForTokenEvent" 
   ((tokenArray :msclptokeninfo)
                                                ;  Array
; 																 * of
; 																 * token
; 																 * structs 
; 																 
    (arraySize :UInt32)
                                                ;  Size of the array 
    (callBack :pointer)
                                                ;  Callback function 
                                                ;  Application data 
    (appData (:pointer :void))
   )
   :UInt32
() )
; 
; 	 * Cancels all callback registrations 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCCallbackCancelEvent" 
   ((ARG2 (:NIL :NIL))
   )
   :UInt32
() )
; 
; 	 * Locks a transaction to the token 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCBeginTransaction" 
                                                ;  Connection 
; 																 * handle 
   ((pConnection :msclptokenconnection)
   )
   :UInt32
() )
; 
; 	 * Releases a locked transaction to the token 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCEndTransaction" 
   ((pConnection :msclptokenconnection)
                                                ;  Connection 
; 																 * handle 
                                                ;  Action to perform on token 
    (endAction :UInt32)
   )
   :UInt32
() )
; 
; 	 * Selects applet - Not to be used by applications 
; 	 

(deftrap-inline "_MSCSelectAID" 
   ((pConnection :msclptokenconnection)
    (aidValue (:pointer :UInt8))
    (aidSize :UInt32)
   )
   :UInt32
() )
; 
; 	 * Pre-personalization function 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCWriteFramework" 
   ((pConnection :msclptokenconnection)
    (pInitParams :msclpinittokenparams)
   )
   :UInt32
() )
; ***************************************************************
; 
; 	 * Core Musclecard functions 
; 	 
; 
; 	 * These functions coorespond directly to internal library 
; 	 
; 
; 	 * functions.  
; 	 
; ***************************************************************
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCGetStatus" 
   ((pConnection :msclptokenconnection)
    (pStatusInfo :msclpstatusinfo)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCGetCapabilities" 
   ((pConnection :msclptokenconnection)
    (Tag :UInt32)
    (Value (:pointer :UInt8))
    (Length (:pointer :UInt32))
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCExtendedFeature" 
   ((pConnection :msclptokenconnection)
    (extFeature :UInt32)
    (outData (:pointer :UInt8))
    (outLength :UInt32)
    (inData (:pointer :UInt8))
    (inLength (:pointer :UInt32))
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCGenerateKeys" 
   ((pConnection :msclptokenconnection)
    (prvKeyNum :UInt8)
    (pubKeyNum :UInt8)
    (pParams :msclpgenkeyparams)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCImportKey" 
   ((pConnection :msclptokenconnection)
    (keyNum :UInt8)
    (pKeyACL :msclpkeyacl)
    (pKeyBlob (:pointer :UInt8))
    (keyBlobSize :UInt32)
    (keyPolicy :msclpkeypolicy)
    (pAddParams (:pointer :void))
    (addParamsSize :UInt8)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCExportKey" 
   ((pConnection :msclptokenconnection)
    (keyNum :UInt8)
    (pKeyBlob (:pointer :UInt8))
    (keyBlobSize (:pointer :UInt32))
    (pAddParams (:pointer :void))
    (addParamsSize :UInt8)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCComputeCrypt" 
   ((pConnection :msclptokenconnection)
    (cryptInit :msclpcryptinit)
    (pInputData (:pointer :UInt8))
    (inputDataSize :UInt32)
    (pOutputData (:pointer :UInt8))
    (outputDataSize (:pointer :UInt32))
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCExtAuthenticate" 
   ((pConnection :msclptokenconnection)
    (keyNum :UInt8)
    (cipherMode :UInt8)
    (cipherDirection :UInt8)
    (pData (:pointer :UInt8))
    (dataSize :UInt32)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCListKeys" 
   ((pConnection :msclptokenconnection)
    (seqOption :UInt8)
    (pKeyInfo :msclpkeyinfo)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCCreatePIN" 
   ((pConnection :msclptokenconnection)
    (pinNum :UInt8)
    (pinAttempts :UInt8)
    (pPinCode (:pointer :UInt8))
    (pinCodeSize :UInt32)
    (pUnblockCode (:pointer :UInt8))
    (unblockCodeSize :UInt8)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCVerifyPIN" 
   ((pConnection :msclptokenconnection)
    (pinNum :UInt8)
    (pPinCode (:pointer :UInt8))
    (pinCodeSize :UInt32)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCChangePIN" 
   ((pConnection :msclptokenconnection)
    (pinNum :UInt8)
    (pOldPinCode (:pointer :UInt8))
    (oldPinCodeSize :UInt8)
    (pNewPinCode (:pointer :UInt8))
    (newPinCodeSize :UInt8)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCUnblockPIN" 
   ((pConnection :msclptokenconnection)
    (pinNum :UInt8)
    (pUnblockCode (:pointer :UInt8))
    (unblockCodeSize :UInt32)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCListPINs" 
   ((pConnection :msclptokenconnection)
    (pPinBitMask (:pointer :UInt16))
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCCreateObject" 
   ((pConnection :msclptokenconnection)
    (objectID (:pointer :character))
    (objectSize :UInt32)
    (pObjectACL :msclpobjectacl)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCDeleteObject" 
   ((pConnection :msclptokenconnection)
    (objectID (:pointer :character))
    (zeroFlag :UInt8)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCWriteObject" 
   ((pConnection :msclptokenconnection)
    (objectID (:pointer :character))
    (offset :UInt32)
    (pInputData (:pointer :UInt8))
    (dataSize :UInt32)
    (rwCallback :pointer)
    (addParams (:pointer :void))
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCReadObject" 
   ((pConnection :msclptokenconnection)
    (objectID (:pointer :character))
    (offset :UInt32)
    (pOutputData (:pointer :UInt8))
    (dataSize :UInt32)
    (rwCallback :pointer)
    (addParams (:pointer :void))
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCReadAllocateObject" 
   ((pConnection :msclptokenconnection)
    (objectID (:pointer :character))
    (pOutputData (:pointer :MSCPUChar8))
    (dataSize (:pointer :UInt32))
    (rwCallback :pointer)
    (addParams (:pointer :void))
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCListObjects" 
   ((pConnection :msclptokenconnection)
    (seqOption :UInt8)
    (pObjectInfo :msclpobjectinfo)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCLogoutAll" 
   ((pConnection :msclptokenconnection)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCGetChallenge" 
   ((pConnection :msclptokenconnection)
    (pSeed (:pointer :UInt8))
    (seedSize :UInt16)
    (pRandomData (:pointer :UInt8))
    (randomDataSize :UInt16)
   )
   :UInt32
() )
; ***************************************************************
; 
; 	 * Extended Musclecard functions 
; 	 
; 
; 	 * These functions do not coorespond to internal library funcions 
; 	 
; 
; 	 * but rather use them to provide some extended functionality.  
; 	 
; ***************************************************************
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCGetKeyAttributes" 
   ((pConnection :msclptokenconnection)
    (keyNumber :UInt8)
    (pKeyInfo :msclpkeyinfo)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCGetObjectAttributes" 
   ((pConnection :msclptokenconnection)
    (objectID (:pointer :character))
    (pObjectInfo :msclpobjectinfo)
   )
   :UInt32
() )
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_msc_error" 
   ((errorCode :UInt32)
   )
   (:pointer :character)
() )
; 
; 	 * Was the token reset ? 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCIsTokenReset" 
   ((pConnection :msclptokenconnection)
   )
   :UInt8
() )
; 
; 	 * Clear the Reset state 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCClearReset" 
   ((pConnection :msclptokenconnection)
   )
   :UInt8
() )
; 
; 	 * Was the token moved (removed, removed/inserted) ? 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCIsTokenMoved" 
   ((pConnection :msclptokenconnection)
   )
   :UInt8
() )
; 
; 	 * Did any state change with the token ? 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCIsTokenChanged" 
   ((pConnection :msclptokenconnection)
   )
   :UInt8
() )
; 
; 	 * Is the token recognized ? 
; 	 
; #ifdef WIN32
#| #|
	PCSC_API
#endif
|#
 |#

(deftrap-inline "_MSCIsTokenKnown" 
   ((pConnection :msclptokenconnection)
   )
   :UInt8
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif							/* __musclecard_h__ */


(provide-interface "musclecard")