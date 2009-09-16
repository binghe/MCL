(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SecureTransport.h"
; at Sunday July 2,2006 7:31:47 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All Rights Reserved.
;  * 
;  * The contents of this file constitute Original Code as defined in and are
;  * subject to the Apple Public Source License Version 1.2 (the 'License').
;  * You may not use this file except in compliance with the License. Please obtain
;  * a copy of the License at http://www.apple.com/publicsource and read it before
;  * using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS
;  * OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES, INCLUDING WITHOUT
;  * LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
;  * PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. Please see the License for the
;  * specific language governing rights and limitations under the License.
;  
; 
; 	File:		SecureTransport.h
; 
; 	Contains:	Public API for Apple SSL/TLS Implementation
; 
; 	Copyright: (c) 1999-2002 by Apple Computer, Inc., all rights reserved.
; 
; 
; #ifndef _SECURITY_SECURETRANSPORT_H_
; #define _SECURITY_SECURETRANSPORT_H_
; 
;  * This file describes the public API for an implementation of the 
;  * Secure Socket Layer, V. 3.0, and Transport Layer Security, V. 1.0.
;  *
;  * There no transport layer dependencies in this library;
;  * it can be used with sockets, Open Transport, etc. Applications using
;  * this library provide callback functions which do the actual I/O
;  * on underlying network connections. Applications are also responsible
;  * for setting up raw network connections; the application passes in
;  * an opaque reference to the underlying (connected) entity at the 
;  * start of an SSL session in the form of an SSLConnectionRef.
;  *
;  * Some terminology:
;  *
;  * A "client" is the initiator of an SSL Session. The canonical example
;  * of a client is a web browser, when it's talking to an https URL. 
;  *
;  * A "server" is an entity which accepts requests for SSL sessions made
;  * by clients. E.g., a secure web server. 
;  
;  * An "SSL Session", or "session", is bounded by calls to SSLHandshake()
;  * and SSLClose(). An "Active session" is in some state between these
;  * two calls, inclusive.
;  * 
;  * An SSL Session Context, or SSLContextRef, is an opaque reference in this
;  * library to the state associated with one session. A SSLContextRef cannot
;  * be reused for multiple sessions.  
;  

(require-interface "CoreServices/../Frameworks/CarbonCore.framework/Headers/MacTypes")

(require-interface "CoreFoundation/CFArray")

(require-interface "Security/CipherSuite")

(require-interface "sys/types")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; **********************
;  *** Common typedefs ***
;  **********************
;  Opaque reference to an SSL session context 

(def-mactype :SSLContextRef (find-mactype '(:pointer :SSLContext)))
;  Opaque reference to an I/O conection (socket, Endpoint, etc.) 

(def-mactype :SSLConnectionRef (find-mactype '(:pointer :void)))
;  SSL Protocol version 

(defconstant $kSSLProtocolUnknown 0)            ;  no protocol negotiated/specified; use default 

(defconstant $kSSLProtocol2 1)                  ;  SSL 2.0 only 

(defconstant $kSSLProtocol3 2)                  ;  SSL 3.0 preferred, 2.0 OK if peer requires 

(defconstant $kSSLProtocol3Only 3)
;  use SSL 3.0 only, fail if peer tries to
; 								 * negotiate 2.0 

(defconstant $kTLSProtocol1 4)                  ;  TLS 1.0 preferred, lower versions OK 

(defconstant $kTLSProtocol1Only 5)              ;  TLS 1.0 only 
;  all supported versions 

(defconstant $kSSLProtocolAll 6)
(def-mactype :SSLProtocol (find-mactype ':SINT32))
;  State of an SSLSession 

(defconstant $kSSLIdle 0)                       ;  no I/O performed yet 

(defconstant $kSSLHandshake 1)                  ;  SSL handshake in progress 

(defconstant $kSSLConnected 2)                  ;  Handshake complete, ready for normal I/O 

(defconstant $kSSLClosed 3)                     ;  connection closed normally 
;  connection aborted 

(defconstant $kSSLAborted 4)
(def-mactype :SSLSessionState (find-mactype ':SINT32))
;  
;  * Status of client certificate exchange (which is optional
;  * for both server and client).
;  
;  Server hasn't asked for a cert. Client hasn't sent one. 

(defconstant $kSSLClientCertNone 0)             ;  Server has asked for a cert, but client didn't send it. 

(defconstant $kSSLClientCertRequested 1)
; 
; 	 * Server side: We asked for a cert, client sent one, we validated 
; 	 *				it OK. App can inspect the cert via 
; 	 *				SSLGetPeerCertificates().
; 	 * Client side: server asked for one, we sent it.
; 	 

(defconstant $kSSLClientCertSent 2)
; 
; 	 * Client sent a cert but failed validation. Server side only.
; 	 * Server app can inspect the cert via SSLGetPeerCertificates().
; 	 

(defconstant $kSSLClientCertRejected 3)
(def-mactype :SSLClientCertificateState (find-mactype ':SINT32))
;  
;  * R/W functions. The application using this library provides
;  * these functions via SSLSetIOFuncs().
;  *
;  * Data's memory is allocated by caller; on entry to these two functions
;  * the *length argument indicates both the size of the available data and the
;  * requested byte count. Number of bytes actually transferred is returned in 
;  * *length.
;  *
;  * The application may configure the underlying connection to operate
;  * in a non-blocking manner; in such a case, a read operation may
;  * well return errSSLWouldBlock, indicating "I transferred less data than
;  * you requested (maybe even zero bytes), nothing is wrong, except 
;  * requested I/O hasn't completed". This will be returned back up to 
;  * the application as a return from SSLRead(), SSLWrite(), SSLHandshake(),
;  * etc. 
;  
;  owned by 
; 							 									 * caller, data
; 							 									 * RETURNED 

(def-mactype :SSLReadFunc (find-mactype ':pointer)); (SSLConnectionRef connection , void * data , size_t * dataLength)
;  IN/OUT 

(def-mactype :SSLWriteFunc (find-mactype ':pointer)); (SSLConnectionRef connection , const void * data , size_t * dataLength)
;  IN/OUT 
; ************************************************
;  *** OSStatus values unique to SecureTransport ***
;  ************************************************
; 
;     Note: the comments that appear after these errors are used to create SecErrorMessages.strings.
;     The comments must not be multi-line, and should be in a form meaningful to an end user. If
;     a different or additional comment is needed, it can be put in the header doc format, or on a
;     line that does not start with errZZZ.
; 

(defconstant $errSSLProtocol -9800)             ;  SSL protocol error 

(defconstant $errSSLNegotiation -9801)          ;  Cipher Suite negotiation failure 

(defconstant $errSSLFatalAlert -9802)           ;  Fatal alert 

(defconstant $errSSLWouldBlock -9803)           ;  I/O would block (not fatal) 

(defconstant $errSSLSessionNotFound -9804)      ;  attempt to restore an unknown session 

(defconstant $errSSLClosedGraceful -9805)       ;  connection closed gracefully 

(defconstant $errSSLClosedAbort -9806)          ;  connection closed via error 

(defconstant $errSSLXCertChainInvalid -9807)    ;  Invalid certificate chain 

(defconstant $errSSLBadCert -9808)              ;  bad certificate format 

(defconstant $errSSLCrypto -9809)               ;  underlying cryptographic error 

(defconstant $errSSLInternal -9810)             ;  Internal error 

(defconstant $errSSLModuleAttach -9811)         ;  module attach failure 

(defconstant $errSSLUnknownRootCert -9812)      ;  valid cert chain, untrusted root 

(defconstant $errSSLNoRootCert -9813)           ;  cert chain not verified by root 

(defconstant $errSSLCertExpired -9814)          ;  chain had an expired cert 

(defconstant $errSSLCertNotYetValid -9815)      ;  chain had a cert not yet valid 

(defconstant $errSSLClosedNoNotify -9816)       ;  server closed session with no notification 

(defconstant $errSSLBufferOverflow -9817)       ;  insufficient buffer provided 

(defconstant $errSSLBadCipherSuite -9818)       ;  bad SSLCipherSuite 
;  fatal errors detected by peer 

(defconstant $errSSLPeerUnexpectedMsg -9819)    ;  unexpected message received 

(defconstant $errSSLPeerBadRecordMac -9820)     ;  bad MAC 

(defconstant $errSSLPeerDecryptionFail -9821)   ;  decryption failed 

(defconstant $errSSLPeerRecordOverflow -9822)   ;  record overflow 

(defconstant $errSSLPeerDecompressFail -9823)   ;  decompression failure 

(defconstant $errSSLPeerHandshakeFail -9824)    ;  handshake failure 

(defconstant $errSSLPeerBadCert -9825)          ;  misc. bad certificate 

(defconstant $errSSLPeerUnsupportedCert -9826)  ;  bad unsupported cert format 

(defconstant $errSSLPeerCertRevoked -9827)      ;  certificate revoked 

(defconstant $errSSLPeerCertExpired -9828)      ;  certificate expired 

(defconstant $errSSLPeerCertUnknown -9829)      ;  unknown certificate 

(defconstant $errSSLIllegalParam -9830)         ;  illegal parameter 

(defconstant $errSSLPeerUnknownCA -9831)        ;  unknown Cert Authority 

(defconstant $errSSLPeerAccessDenied -9832)     ;  access denied 

(defconstant $errSSLPeerDecodeError -9833)      ;  decoding error 

(defconstant $errSSLPeerDecryptError -9834)     ;  decryption error 

(defconstant $errSSLPeerExportRestriction -9835);  export restriction 

(defconstant $errSSLPeerProtocolVersion -9836)  ;  bad protocol version 

(defconstant $errSSLPeerInsufficientSecurity -9837);  insufficient security 

(defconstant $errSSLPeerInternalError -9838)    ;  internal error 

(defconstant $errSSLPeerUserCancelled -9839)    ;  user canceled 

(defconstant $errSSLPeerNoRenegotiation -9840)  ;  no renegotiation allowed 
;  more errors detected by us 

(defconstant $errSSLDecryptionFail -9845)       ;  decryption failure 

(defconstant $errSSLBadRecordMac -9846)         ;  bad MAC 

(defconstant $errSSLRecordOverflow -9847)       ;  Record Overflow 

(defconstant $errSSLBadConfiguration -9848)     ;  configuration error 
;  end of range, to be deleted 

(defconstant $errSSLLast -9849)
; *****************
;  *** Public API ***
;  *****************
;  
;  * Create a new session context.
;  

(deftrap-inline "_SSLNewContext" 
   ((isServer :Boolean)
    (contextPtr (:pointer :SSLCONTEXTREF))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Dispose of an SSLContextRef.
;  

(deftrap-inline "_SSLDisposeContext" 
   ((context (:pointer :SSLContext))
   )
   :SInt32
() )
; 
;  * Determine the state of an SSL session.
;  

(deftrap-inline "_SSLGetSessionState" 
   ((context (:pointer :SSLContext))
    (state (:pointer :SSLSessionState))
   )
   :SInt32
() )
;  RETURNED 
; *******************************************************************
;  *** Session context configuration, common to client and servers. ***
;  *******************************************************************
;  
;  * Specify functions which do the network I/O. Must be called prior
;  * to SSLHandshake(); subsequently can not be called while a session is
;  * active. 
;  

(deftrap-inline "_SSLSetIOFuncs" 
   ((context (:pointer :SSLContext))
    (read :pointer)
    (write :pointer)
   )
   :SInt32
() )
; 
;  * Set allowed SSL protocol versions. Optional. 
;  * Specifying kSSLProtocolAll for SSLSetProtocolVersionEnabled results in 
;  * specified 'enable' boolean to be applied to all supported protocols.
;  * The default is "all supported protocols are enabled". 
;  * This can only be called when no session is active.
;  *
;  * Legal values for protocol are :
;  *		kSSLProtocol2
;  *		kSSLProtocol3
;  * 		kTLSProtocol1
;  *		kSSLProtocolAll
;  

(deftrap-inline "_SSLSetProtocolVersionEnabled" 
   ((context (:pointer :SSLContext))
    (protocol :SInt32)
    (enable :Boolean)
   )
   :SInt32
() )
; 
;  * Obtain a value specified in SSLSetProtocolVersionEnabled.
;  

(deftrap-inline "_SSLGetProtocolVersionEnabled" 
   ((context (:pointer :SSLContext))
    (protocol :SInt32)
    (enable (:pointer :Boolean))
   )
   :SInt32
() )
;  RETURNED 
;  
;  * Get/set SSL protocol version; optional. Default is kSSLProtocolUnknown, 
;  * in which case the highest possible version (currently kTLSProtocol1) 
;  * is attempted, but a lower version is accepted if the peer requires it. 
;  *
;  * SSLSetProtocolVersion can not be called when a session is active. 
;  *
;  * This is deprecated in favor of SSLSetProtocolVersionEnabled.
;  

(deftrap-inline "_SSLSetProtocolVersion" 
   ((context (:pointer :SSLContext))
    (version :SInt32)
   )
   :SInt32
() )
; 
;  * Obtain the protocol version specified in SSLSetProtocolVersion.
;  * This is deprecated in favor of SSLGetProtocolVersionEnabled. 
;  * If SSLSetProtocolVersionEnabled() has been called for this session,
;  * SSLGetProtocolVersion() may return paramErr if the protocol enable
;  * state can not be represented by the SSLProtocol enums (e.g.,
;  * SSL2 and TLS1 enabled, SSL3 disabled). 
;  

(deftrap-inline "_SSLGetProtocolVersion" 
   ((context (:pointer :SSLContext))
    (protocol (:pointer :SSLProtocol))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Specify this connection's certificate(s). This is mandatory for
;  * server connections, optional for clients. Specifying a certificate
;  * for a client enables SSL client-side authentication. The end-entity
;  * cert is in certRefs[0]. Specifying a root cert is optional; if it's
;  * not specified, the root cert which verifies the cert chain specified
;  * here must be present in the system-wide set of trusted anchor certs.
;  *
;  * The certRefs argument is a CFArray containing SecCertificateRefs,
;  * except for certRefs[0], which is a SecIdentityRef.
;  *
;  * Can only be called when no session is active. 
;  *
;  * SecureTransport assumes the following:
;  *   
;  *	-- The certRef references remains valid for the lifetime of the 
;  *     session.
;  *  -- The specified certRefs[0] is capable of signing. 
;  *  -- The required capabilities of the certRef[0], and of the optional cert
;  *     specified in SSLSetEncryptionCertificate (see below), are highly
;  *     dependent on the application. For example, to work as a server with
;  *     Netscape clients, the cert specified here must be capable of both
;  *     signing and encrypting. 
;  

(deftrap-inline "_SSLSetCertificate" 
   ((context (:pointer :SSLContext))
    (certRefs (:pointer :__CFArray))
   )
   :SInt32
() )
; 
;  * Specify I/O connection - a socket, endpoint, etc., which is
;  * managed by caller. On the client side, it's assumed that communication
;  * has been established with the desired server on this connection.
;  * On the server side, it's assumed that an incoming client request
;  * has been established. 
;  *
;  * Must be called prior to SSLHandshake(); subsequently can only be
;  * called when no session is active.
;  

(deftrap-inline "_SSLSetConnection" 
   ((context (:pointer :SSLContext))
    (connection (:pointer :void))
   )
   :SInt32
() )

(deftrap-inline "_SSLGetConnection" 
   ((context (:pointer :SSLContext))
    (connection (:pointer :SSLCONNECTIONREF))
   )
   :SInt32
() )
;  
;  * Specify the fully qualified doman name of the peer, e.g., "store.apple.com."
;  * Optional; used to verify the common name field in peer's certificate. 
;  * Name is in the form of a C string; NULL termination optional, i.e., 
;  * peerName[peerNameLen[1] may or may not have a NULL. In any case peerNameLen
;  * is the number of bytes of the peer domain name.
;  

(deftrap-inline "_SSLSetPeerDomainName" 
   ((context (:pointer :SSLContext))
    (peerName (:pointer :char))
    (peerNameLen :unsigned-long)
   )
   :SInt32
() )
; 
;  * Determine the buffer size needed for SSLGetPeerDomainName().
;  

(deftrap-inline "_SSLGetPeerDomainNameLength" 
   ((context (:pointer :SSLContext))
    (peerNameLen (:pointer :size_t))
   )
   :SInt32
() )
;  RETURNED
; 
;  * Obtain the value specified in SSLSetPeerDomainName().
;  

(deftrap-inline "_SSLGetPeerDomainName" 
   ((context (:pointer :SSLContext))
    (peerName (:pointer :char))
                                                ;  returned here
    (peerNameLen (:pointer :size_t))
   )
   :SInt32
() )
;  IN/OUT
; 
;  * Obtain the actual negotiated protocol version of the active
;  * session, which may be different that the value specified in 
;  * SSLSetProtocolVersion(). Returns kSSLProtocolUnknown if no 
;  * SSL session is in progress.
;  

(deftrap-inline "_SSLGetNegotiatedProtocolVersion" 
   ((context (:pointer :SSLContext))
    (protocol (:pointer :SSLProtocol))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Determine number and values of all of the SSLCipherSuites we support.
;  * Caller allocates output buffer for SSLGetSupportedCiphers() and passes in
;  * its size in *numCiphers. If supplied buffer is too small, errSSLBufferOverflow
;  * will be returned. 
;  

(deftrap-inline "_SSLGetNumberSupportedCiphers" 
   ((context (:pointer :SSLContext))
    (numCiphers (:pointer :size_t))
   )
   :SInt32
() )

(deftrap-inline "_SSLGetSupportedCiphers" 
   ((context (:pointer :SSLContext))
    (ciphers (:pointer :SSLCIPHERSUITE))
                                                ;  RETURNED 
    (numCiphers (:pointer :size_t))
   )
   :SInt32
() )
;  IN/OUT 
; 
;  * Specify a (typically) restricted set of SSLCipherSuites to be enabled by
;  * the current SSLContext. Can only be called when no session is active. Default
;  * set of enabled SSLCipherSuites is the same as the complete set of supported 
;  * SSLCipherSuites as obtained by SSLGetSupportedCiphers().
;  

(deftrap-inline "_SSLSetEnabledCiphers" 
   ((context (:pointer :SSLContext))
    (ciphers (:pointer :SSLCIPHERSUITE))
    (numCiphers :unsigned-long)
   )
   :SInt32
() )
; 
;  * Determine number and values of all of the SSLCipherSuites currently enabled.
;  * Caller allocates output buffer for SSLGetEnabledCiphers() and passes in
;  * its size in *numCiphers. If supplied buffer is too small, errSSLBufferOverflow
;  * will be returned. 
;  

(deftrap-inline "_SSLGetNumberEnabledCiphers" 
   ((context (:pointer :SSLContext))
    (numCiphers (:pointer :size_t))
   )
   :SInt32
() )

(deftrap-inline "_SSLGetEnabledCiphers" 
   ((context (:pointer :SSLContext))
    (ciphers (:pointer :SSLCIPHERSUITE))
                                                ;  RETURNED 
    (numCiphers (:pointer :size_t))
   )
   :SInt32
() )
;  IN/OUT 
; 
;  * Enable/disable peer certificate chain validation. Default is enabled.
;  * If caller disables, it is the caller's responsibility to call 
;  * SSLGetPeerCertificates() upon successful completion of the handshake
;  * and then to perform external validation of the peer certificate
;  * chain before proceeding with data transfer.
;  

(deftrap-inline "_SSLSetEnableCertVerify" 
   ((context (:pointer :SSLContext))
    (enableVerify :Boolean)
   )
   :SInt32
() )

(deftrap-inline "_SSLGetEnableCertVerify" 
   ((context (:pointer :SSLContext))
    (enableVerify (:pointer :Boolean))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Specify the option of ignoring certificates' "expired" times. 
;  * This is a common failure in the real SSL world. Default for 
;  * this flag is false, meaning expired certs result in a
;  * errSSLCertExpired error.
;  

(deftrap-inline "_SSLSetAllowsExpiredCerts" 
   ((context (:pointer :SSLContext))
    (allowsExpired :Boolean)
   )
   :SInt32
() )
;  
;  * Obtain the current value of an SSLContext's "allowExpiredCerts" flag. 
;  

(deftrap-inline "_SSLGetAllowsExpiredCerts" 
   ((context (:pointer :SSLContext))
    (allowsExpired (:pointer :Boolean))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Similar to SSLSetAllowsExpiredCerts(), this function allows the 
;  * option of ignoring "expired" status for root certificates only.
;  * Default is false, i.e., expired root certs result in an 
;  * errSSLCertExpired error.
;  

(deftrap-inline "_SSLSetAllowsExpiredRoots" 
   ((context (:pointer :SSLContext))
    (allowsExpired :Boolean)
   )
   :SInt32
() )

(deftrap-inline "_SSLGetAllowsExpiredRoots" 
   ((context (:pointer :SSLContext))
    (allowsExpired (:pointer :Boolean))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Specify option of allowing for an unknown root cert, i.e., one which
;  * this software can not verify as one of a list of known good root certs. 
;  * Default for this flag is false, in which case one of the following two
;  * errors may occur:
;  *    -- The peer returns a cert chain with a root cert, and the chain 
;  *       verifies to that root, but the root is not one of our trusted
;  *       roots. This results in errSSLUnknownRootCert on handshake. 
;  *    -- The peer returns a cert chain which does not contain a root cert,
;  *       and we can't verify the chain to one of our trusted roots. This 
;  *       results in errSSLNoRootCert on handshake.
;  *
;  * Both of these error conditions are ignored when the AllowAnyRoot flag is true,
;  * allowing connection to a totally untrusted peer. 
;  

(deftrap-inline "_SSLSetAllowsAnyRoot" 
   ((context (:pointer :SSLContext))
    (anyRoot :Boolean)
   )
   :SInt32
() )
;  
;  * Obtain the current value of an SSLContext's "allow any root" flag. 
;  

(deftrap-inline "_SSLGetAllowsAnyRoot" 
   ((context (:pointer :SSLContext))
    (anyRoot (:pointer :Boolean))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Augment or replace the system's default trusted root certificate set
;  * for this session. If replaceExisting is true, the specified roots will
;  * be the only roots which are trusted during this session. If replaceExisting
;  * is false, the specified roots will be added to the current set of trusted
;  * root certs. If this function has never been called, the current trusted
;  * root set is the same as the system's default trusted root set.
;  * Successive calls with replaceExisting false result in accumulation
;  * of additional root certs.
;  *
;  * The trustedRoots array contains SecCertificateRefs.
;  

(deftrap-inline "_SSLSetTrustedRoots" 
   ((context (:pointer :SSLContext))
    (trustedRoots (:pointer :__CFArray))
    (replaceExisting :Boolean)
   )
   :SInt32
() )
; 
;  * Obtain an array of SecCertificateRefs representing the current
;  * set of trusted roots. If SSLSetTrustedRoots() has never been called
;  * for this session, this returns the system's default root set.
;  

(deftrap-inline "_SSLGetTrustedRoots" 
   ((context (:pointer :SSLContext))
    (trustedRoots (:pointer :CFArrayRef))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Request peer certificates. Valid anytime, subsequent to
;  * a handshake attempt.
;  *
;  * The certs argument is a CFArray containing SecCertificateRefs.
;  * The entire array is created by the SecureTransport library 
;  * and must be released by the caller. The cert at index 0 of 
;  * the returned array is the subject (end entity) cert; the 
;  * root cert (or the closest cert to it) is at the end of the 
;  * returned array. 
;  

(deftrap-inline "_SSLGetPeerCertificates" 
   ((context (:pointer :SSLContext))
    (certs (:pointer :CFArrayRef))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Specify some data, opaque to this library, which is sufficient
;  * to uniquely identify the peer of the current session. An example
;  * would be IP address and port, stored in some caller-private manner.
;  * To be optionally called prior to SSLHandshake for the current 
;  * session. This is mandatory if this session is to be resumable. 
;  *
;  * SecureTransport allocates its own copy of the incoming peerID. The 
;  * data provided in *peerID, while opaque to SecureTransport, is used
;  * in a byte-for-byte compare to other previous peerID values set by the 
;  * current application. Matching peerID blobs result in SecureTransport
;  * attempting to resume an SSL session with the same parameters as used
;  * in the previous session which specified the same peerID bytes. 
;  

(deftrap-inline "_SSLSetPeerID" 
   ((context (:pointer :SSLContext))
    (peerID :pointer)
    (peerIDLen :unsigned-long)
   )
   :SInt32
() )
; 
;  * Obtain current PeerID. Returns NULL pointer, zero length if
;  * SSLSetPeerID has not been called for this context.
;  

(deftrap-inline "_SSLGetPeerID" 
   ((context (:pointer :SSLContext))
    (peerID :pointer)
    (peerIDLen (:pointer :size_t))
   )
   :SInt32
() )
; 
;  * Obtain the SSLCipherSuite (e.g., SSL_RSA_WITH_DES_CBC_SHA) negotiated
;  * for this session. Only valid when a session is active.
;  

(deftrap-inline "_SSLGetNegotiatedCipher" 
   ((context (:pointer :SSLContext))
    (cipherSuite (:pointer :SSLCIPHERSUITE))
   )
   :SInt32
() )
; *******************************************************
;  *** Session context configuration, server side only. ***
;  *******************************************************
; 
;  * Specify this connection's encryption certificate(s). This is
;  * used in one of the following cases:
;  *
;  *	-- The end-entity certificate specified in SSLSetCertificate() is 
;  *	   not capable of encryption.  
;  *
;  *  -- The end-entity certificate specified in SSLSetCertificate() 
;  * 	   contains a key which is too large (i.e., too strong) for legal 
;  *	   encryption in this session. In this case a weaker cert is 
;  *     specified here and is used for server-initiated key exchange. 
;  *
;  * The certRefs argument is a CFArray containing SecCertificateRefs,
;  * except for certRefs[0], which is a SecIdentityRef.
;  *
;  * The following assumptions are made:
;  *
;  *	-- The certRefs references remains valid for the lifetime of the 
;  *     connection.
;  *  -- The specified certRefs[0] is capable of encryption. 
;  *
;  * Can only be called when no session is active. 
;  *
;  * Notes:
;  * ------
;  *
;  * -- SSL servers which enforce the SSL3 spec to the letter will
;  *    not accept encryption certs with key sizes larger than 512
;  *    bits for exportable ciphers. Apps which wish to use encryption 
;  *    certs with key sizes larger than 512 bits should disable the 
;  *    use of exportable ciphers via the SSLSetEnabledCiphers() call. 
;  

(deftrap-inline "_SSLSetEncryptionCertificate" 
   ((context (:pointer :SSLContext))
    (certRefs (:pointer :__CFArray))
   )
   :SInt32
() )
; 
;  * Specify requirements for client-side authentication.
;  * Optional; Default is kNeverAuthenticate.
;  *
;  * Can only be called when no session is active.  
;  

(defconstant $kNeverAuthenticate 0)             ;  skip client authentication 

(defconstant $kAlwaysAuthenticate 1)            ;  require it 
;  try to authenticate, but not an error
; 								 * if client doesn't have a cert 

(defconstant $kTryAuthenticate 2)
(def-mactype :SSLAuthenticate (find-mactype ':SINT32))

(deftrap-inline "_SSLSetClientSideAuthenticate" 
   ((context (:pointer :SSLContext))
    (auth :SInt32)
   )
   :SInt32
() )
; 
;  * Add a DER-encoded dinstiguished name to list of acceptable names
;  * to be specified in requests for client certificates. 
;  

(deftrap-inline "_SSLAddDistinguishedName" 
   ((context (:pointer :SSLContext))
    (derDN :pointer)
    (derDNLen :unsigned-long)
   )
   :SInt32
() )
; 
;  * Obtain client certificate exhange status. Can be called 
;  * any time. Reflects the *last* client certificate state change;
;  * subsequent to a renegotiation attempt by either peer, the state
;  * is reset to kSSLClientCertNone.
;  

(deftrap-inline "_SSLGetClientCertificateState" 
   ((context (:pointer :SSLContext))
    (clientState (:pointer :SSLClientCertificateState))
   )
   :SInt32
() )
; 
;  * Specify Diffie-Hellman parameters. Optional; if we are configured to allow
;  * for D-H ciphers and a D-H cipher is negotiated, and this function has not
;  * been called, a set of process-wide parameters will be calculated. However
;  * that can take a long time (30 seconds). 
;  

(deftrap-inline "_SSLSetDiffieHellmanParams" 
   ((context (:pointer :SSLContext))
    (dhParams :pointer)
    (dhParamsLen :unsigned-long)
   )
   :SInt32
() )
; 
;  * Return parameter block specified in SSLSetDiffieHellmanParams.
;  * Returned data is not copied and belongs to the SSLContextRef.
;  

(deftrap-inline "_SSLGetDiffieHellmanParams" 
   ((context (:pointer :SSLContext))
    (dhParams :pointer)
    (dhParamsLen (:pointer :size_t))
   )
   :SInt32
() )
; 
;  * Enable/Disable RSA blinding. This feature thwarts a known timing
;  * attack to which RSA keys are vulnerable; enabling it is a tradeoff
;  * between performance and security. The default for RSA blinding is
;  * enabled. 
;  

(deftrap-inline "_SSLSetRsaBlinding" 
   ((context (:pointer :SSLContext))
    (blinding :Boolean)
   )
   :SInt32
() )

(deftrap-inline "_SSLGetRsaBlinding" 
   ((context (:pointer :SSLContext))
    (blinding (:pointer :Boolean))
   )
   :SInt32
() )
; ******************************
;  ******** I/O Functions ********
;  ******************************
; 
;  * Note: depending on the configuration of the underlying I/O 
;  * connection, all SSL I/O functions can return errSSLWouldBlock,
;  * indicating "not complete, nothing is wrong, except required
;  * I/O hasn't completed". Caller may need to repeat I/Os as necessary
;  * if the underlying connection has been configured to behave in 
;  * a non-blocking manner.
;  
; 
;  * Perform the SSL handshake. On successful return, session is 
;  * ready for normal secure application I/O via SSLWrite and SSLRead.
;  *
;  * Interesting error returns:
;  *
;  *	errSSLUnknownRootCert: Peer had a valid cert chain, but the root of 
;  *		the chain is unknown. 
;  *
;  * 	errSSLNoRootCert: Peer had a cert chain which was not verifiable
;  *		to a root cert. Handshake was aborted; peer's cert chain
;  *		available via SSLGetPeerCertificates().
;  *
;  * 	errSSLCertExpired: Peer's cert chain had one or more expired certs.
;  *
;  *  errSSLXCertChainInvalid: Peer had an invalid cert chain (i.e.,
;  *		signature verification within the chain failed, or no certs
;  *		were found). 
;  *
;  *  In all of the above errors, the handshake was aborted; peer's 
;  *  cert chain available via SSLGetPeerCertificates().
;  *
;  * A return value of errSSLWouldBlock indicates that SSLHandshake has to be called
;  * again (and again and again until something else is returned).
;  

(deftrap-inline "_SSLHandshake" 
   ((context (:pointer :SSLContext))
   )
   :SInt32
() )
; 
;  * Normal application-level read/write. On both of these, a errSSLWouldBlock
;  * return and a partially completed transfer - or even zero bytes transferred -
;  * are NOT mutually exclusive. 
;  

(deftrap-inline "_SSLWrite" 
   ((context (:pointer :SSLContext))
    (data :pointer)
    (dataLength :unsigned-long)
    (processed (:pointer :size_t))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * data is mallocd by caller; available size specified in
;  * dataLength; actual number of bytes read returned in
;  * *processed.
;  

(deftrap-inline "_SSLRead" 
   ((context (:pointer :SSLContext))
    (data :pointer)
                                                ;  RETURNED 
    (dataLength :unsigned-long)
    (processed (:pointer :size_t))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Determine how much data the client can be guaranteed to 
;  * obtain via SSLRead() without blocking or causing any low-level 
;  * read operations to occur.
;  

(deftrap-inline "_SSLGetBufferedReadSize" 
   ((context (:pointer :SSLContext))
    (bufSize (:pointer :size_t))
   )
   :SInt32
() )
;  RETURNED 
; 
;  * Terminate current SSL session. 
;  

(deftrap-inline "_SSLClose" 
   ((context (:pointer :SSLContext))
   )
   :SInt32
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* !_SECURITY_SECURETRANSPORT_H_ */


(provide-interface "SecureTransport")