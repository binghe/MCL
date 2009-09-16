;;;-*- Syntax: Ansi-Common-Lisp; Base: 10; Mode: lisp; Package: ccl -*-

;;	Change History (most recent first):
;;  6 10/5/97  akh  see below
;;  3 2/25/97  akh  more errno strings
;;  (do not edit before this line!!)


;;; OpenTransport.lisp
;;; Copyright 1996, 2000 Digitool, Inc. 

;;; Interface to OpenTransport.
;;; So far it supports only TCP streams.
;;; Attempts to be compatible with the old mactcp interface, but
;;; can not yet coexist with it.
;;; Load either this file or "ccl:library;mactcp.lisp", not both.

(in-package "CCL")


(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "IO-BUFFER"))



;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;; defconstant needs to be in eval-when
;; use cfm version of #_newotnotifyUPP
;;; fixes for new headers
;;; ------- 5.1 and 5.2b1
;;; - lose the sleep-wakeup thing
;;; -------5.0 final
;;; fix ot-new-inet-service from Brendan Burns
;;; ----------- 4.4b3
;;; 03/15/02 akh reorder subclasses in defclass opentransport-binary-tcp-stream - does this break anything?
;;; -------- 4.4b2 
;;; 11/13/01 akh opentransport-cleanup check that *opentransport-notifier* is non null
;;; 06/13/01 akh carbon-compat stuff re InContext - dunno if it works
;;; ----------- 4.4b1
;;;  akh add some more constants missing from new headers, slh's fix to print-object
;;; akh Call #_NewOTNotifyUPP if carbon, add "Apple;Carbon;Networking" to lib search path
;;; ---------- 4.3.1B1
;;; add otclientlib etal to shared library search path
;;; ------- 4.3f1c1
;;; 06/25/99 akh  delete provide at beginning of file, remove (declare (values ...))
;;; 05/28/99 jcma ot-conn-buffer-advance accepts required errorp arg. Callers of %io-buffer-advance updated.
;;;                           all process-waits vetted, and when appropriate converted to process-blocks for low latency.
;;; 05/13/99 jcma *tcp-read-timeout* is back for timeout in ot-conn-buffer-advance
;;; 05/03/99 kr     Added *ack-sends* to control send acking.
;;; 04/02/99 jcma   Default value set to T to increase stability
;;;                 Added DEFINE-VALUE-CACHE and WITH-VALUE-CACHED to support caching for TCP-ADDR-TO-STR
;;; 12/08/97 slh    *tcp-close-timeout* is back, useful regardless of :mactcp-compatibility feature
;;;                 defparameter -> defvar
;;; 11/02/97 akh   to make cl-http happy initialize-instance ((s opentransport-basic-tcp-stream) accepts and ignores :element-type
;;; 09/10/97 akh    fix open-tcp-stream - spell 'opentransport-binary-tcp-stream correctly, :writebufsize writebufsize (no colon in second)
;;;                 terje's fix to initialize-instance ((s opentransport-stream)
;;; 09/10/97 slh    (from Terje Norderhaug) pass rest args through to next method in
;;;                  <initialize-instance opentransport-stream>
;;;                 Alice's fixes to open-tcp-stream
;;; 08/01/97 jcma/cvince stream-close, initialize-instance, %ot-conn-closed-p, ot-conn-close
;;;                      recycle the io-buffer across connections.
;;; 03/13/97 gb     get-host-address, inet-host-name observe *use-resolver*.
;;;                 *use-resolver* independent of #+mactcp-compatibility, in case that changes.
;;;                 STREAM-CONNECTION-STATE-NAME maps :UNINIT to :RESET.  Require version 2.2
;;;                 or later of support library. 
;;; ------------    4.1b1
;;; 02/17/97 akh    more errno-strings
;;; 01/15/97 slh    from gb: add (setf (ot-conn-peer-address conn) nil) in ot-conn-passive-reconnect
;;; 01/13/97 gb     define & use :ot-context.client-call so notifier can assign peer address.
;;;                 bump *opentransportsupport-min-version* to match notifier that knows about this.
;;;                 ot-conn-active-connect checks for error returned from ot-wait-for-completion 
;;;                 the right way (unless -> when).
;;; 12/22/96 akh    *ot-recycle-endpoints* replaces *freelist-opentransport-endpoints-p*
;;;		    Ot-conn-release-connection nukes the endpoint if *ot-recycle-endpoints* is nil
;;; 		    but keeps conn, context, and buffers.
;;;                 Change one bindret to bindreq in consistency check in ot-tcp-proxy-bind.
;;;		    Added ot-stream-new-endpoint and ot-make-stream-endpoint.
;;;		    Ot-conn-passive-reconnect gets a new endpoint if ot-conn-endpoint is NIL.
;;;                 If endpoint not NIL check that it is :idle (?) - as initialize-http-stream used to do
;;;		    Ot-new-conn lets ot-new-context do clone-configuration iff it makes a new endpoint.
;;; 12/14/96 akh    ot-conn-get-wrqbuf checks for ot-conn-closed-p in its process-wait function
;;;                 ot-conn-disconnect passes a timeout to ot-wait-for-completion (it hung there once)
;;;                 ot-conn-active-connect checks for error returned from ot-wait-for-completion 
;;; 12/09/96 gb     Un-fix ot-conn-tcp-passive-connect (see comments.)
;;;                 One notifier (shared between proxy & clients)
;;;                 :ot-context.proxy-call -> :ot-context.request (private to
;;;                 notifier, mostly 'cause I don't want to define the record
;;;                 format here and 'cause it's only used at interrupt level.)
;;;                 Some small changes to disconnect, etc: still seem to need
;;;                 an arbitrary timeout.  Proxy qlen can now be > 1.
;;;                 Check for the right version of the support library in
;;;                 INIT-OPENTRANSPORT.
;;; 12/03/96 bill   Gary's fix to ot-conn-tcp-passive-connect.
;;;                 Add timeout to ot-conn-disconnect. Drain input before
;;;                 and after the #_OTSndOrderlyDisconnect.
;;;                 ot-conn-disconnect sets the ot-conn-peer-address to nil.
;;; 12/02/96 bill   Freelist endpoints if *freelist-opentransport-endpoints-p* is true.
;;;                 No without-interrupts in ot-conn-close.
;;;                 Instead, put without-interrupts around
;;;                 opentransport-add-endpoint-to-freelist and
;;;                 opentransport-alloc-endpoint-from-freelist.
;;;                 ot-conn-listen calls the ot-conn-advance-function.
;;;                 This ensures that an empty buffer gets deallocated.
;;;                 It also ensures that any patchers of the advance-function get called.
;;;                 ot-conn-disconnect sets the ot-context.closing
;;;                 flag and drains the input queue.
;;; 11/29/96 bill   ot-conn-release-connection
;;;                 stream-release-connection, stream-passive-reconnect.
;;;                 stream-close operates with-io-buffer-locked.
;;;                 ot-conn-passive-reconnect allows reconnection if the endpoint
;;;                 is #$t_idle or #$t_unbnd.
;;; ot-akh-12/01/96
;;; 12/01/96 akh    add-endpoint-to-freelist checks if already there (so far didn't catch anything)
;;;                 don't do add-endpoint-to-freelist for now.
;;;                 ot-conn-close is without-interrupts (kind of strange because it may process-wait)
;;;                 define stream-release-connection to be stream-close (probably wrong but it hasn't been called in practice)
;;; ot-bill-961128
;;; 11/28/96 bill   Increase the output buffer size.
;;;                 Give the user some control over it via the :writebufsize arg
;;;                 to open-tcp-stream and initarg to the opentransport-stream class.
;;;                 *ot-conn-outbuf-size* is the default size.
;;;                 *ot-conn-minimum-outbuf-size* & *ot-conn-maximum-outbuf-size*
;;;                 are the minimum and maximum sizes. I picked the default for
;;;                 the fastest transfers to a local browser. We should time them
;;;                 for remote browsers.
;;; 11/26/96 bill   Change some indentation.
;;; 11/26/96 gb     track sends, acks in context; REQUIRES CHANGED OpenTransportSupport library.
;;;                 Insist on OT 1.1.1 or later.
;;;                 Handle partial sends in ot-conn-flushbuf.
;;;                 Distinguish qbuf allocation class via qbuf.flags.
;;;                 Use protocol-string as alist key in endpoint freelist; use
;;;                 address as key in proxy alist.
;;;                 Dequeue listening contexts from proxy queue before closing.
;;;                 Clone configurations when opening.
;;;                 Wait for all send buffers to be returned before closing.
;;;                 Destroy configurations & close proxies before quitting.
;;;                 Sketch out reconnection scheme for passive streams.
;;;                 local-interface-ip-address looks for #$kDefaultInetInterface, which
;;;                 might someday be something other than the 0th interface ...
;;; 11/25/96 bill   local-interface-ip-address connects if necessary.
;;;                 tcp-connection-conflict & tcp-connection-does-not-exist
;;; 11/22/96 bill   Fix stream-connection-state-name
;;;                 ot-conn-flushbuf checks for peer closed before (< result 0).
;;; 11/21/96 bill   without-interrupts around the ot-new-proxy call in ot-tcp-proxy.
;;; 11/20/96 bill   ot-conn-get-wrqbuf initializes io-buffer-outptr.
;;;                 stream-close doesn't force-output unless connected.
;;;                 if => and in ot-conn-eofp.
;;;                 ot-conn-close sets the stream-io-buffer to nil.
;;; 11/19/96 bill   stream-close method does force-output
;;;                 In (method initialize-instance (opentransport-basic-tcp-stream)),
;;;                 reuse-local-port-p defaults to true.
;;;                 ot-conn-tcp-passive-connect checks for error if allow-reuse is nil.
;;; 11/18/96 bill   tcp-port => tcp-service-port-number
;;;                 tcp-maximum-number-of-connections and its setf function.
;;;                 tcp-use-name-resolver and its setf function.
;;;                 %tcp-getaddr, tcp-host-cname
;;;                 In (method initialize-instance (opentransport-basic-tcp-stream)),
;;;                 add and ignore commandtimeout & writebufsize init keywords
;;;                 for backward compatibility.
;;;                 Add binary-tcp-stream.
;;;                 tcp-invalid-data-structure, tcp-connection-state-timeout
;;;                 Gary's fix to ot-conn-eofp
;;;                 local-interface-ip-address returns 0 if it gets an error.
;;;                 It really should force a modem connection and then error if
;;;                 a real error happenned on the connection.
;;;                 Rename ot-conn-bind-local-address to ot-conn-bind-local-tcp-address and
;;;                 make it initialize the ot-conn-local-address slot.
;;;                 ot-conn-tcp-passive-connect & ot-conn-tcp-host-active-connect initialize ot-conn-peer-address
;;;                 stream-local-host and friends return NIL if the stream is closed.
;;;                 Make the process-wait's in ot-conn-tcp-passive-connect stop if the stream is closed.
;;; 11/15/96 bill   Unused definitions for backward compatibility of:
;;;                   *tcp-command-timeout*, *tcp-read-timeout*, *tcp-close-timeout*,
;;;                   *tcp-maximum-number-of-connections*, stream-read-timeout
;;;                 Gary's definitions for stream-local-host, stream-local-port,
;;;                   stream-remote-host, stream-remote-port
;;;                 opentransport-stream-connection-state and an attempt at
;;;                   a mactcp compatible stream-connection-state-name
;;; 11/14/96 alice  opentransport-stream-error, protocol-timeout and other conditions
;;;		    ot-wait-for-completetion checks for peerclosed too
;;;                 ot-active-connect distiguishes connection-refused from connection-terminated
;;;                 gary's change  to ot-conn-free-endpoint (? from awhile ago)
;;; 11/14/96  bill  Move buffered-character-io-stream-mixin from
;;;                 opentransport-tcp-stream to opentransport-stream.
;;;                 Rename some of the classes and insert in the class hierarchy,
;;;                 for compatibility's sake, classes with the same names as those
;;;                 defined in mactcp.lisp
;;;                 (method initialize-instance (opentransport-binary-tcp-stream)) checks
;;;                 the element-type for legality.
;;; 11/13/96  bill  Nuke (method stream-eofp (opentransport-stream)).
;;;                 The buffered-input-stream-mixin method is correct.
;;;                 Add (ignored) finish-p arg to ot-conn-flushbuf.
;;;                 ot-conn-free-endpoint process-wait's instead of
;;;                 busy waiting for the orederly disconnect.
;;; 11/12/96  gb    use IO-BUFFER.
;;; 11/11/96  alice condition stuff
;;; 11/06/96  gb  handle multiple "held" OTBuffers (represented as 0-length qbufs)
;;;               in OT-CONN-LISTEN.  ot-context.holdOTBuffer is currently unused,
;;;               but this may change someday.

; The condition hierarchy defined here is supposed to more-or-less
; match the one defined in "ccl:library;mactcp.lisp".  Some differences:
; 1) Many are STREAM-ERRORs, which means that anything signalling one
;    needs to be able to get ahold of a :STREAM argument when instantiating one.
; 2) There isn't a one-to-one correspondence between OpenTransport error
;    codes and OpenTransport errors (it's "many to one" when mapping from
;    the error number to the condition, which means that it's sometimes
;    necessary to use contextual information to select the most appropriate
;    condition.)
; 3) There isn't a one-to-one mapping between OpenTransport errors and MacTCP
;    errors either.  For instance, it's hard to know whether a response
;    of #$kOTNoDataErr to a TCP name-to-address query means "nameserver is 
;    unreachable" or "no A record found for specified domain name", or even 
;    something else; the response #$kOTBadNameErr to the same query might mean
;    "name is syntactically invalid" or "name unknown to nameserver(s) queried."
;
;    In general, it's fair to say that OpenTransport conditions are more
;    generic than MacTCP conditions are.  Some of this may be a result of
;    OpenTransport's protocol-independent orientation, but it's true for
;    protocol-specific things - like TCP DNR operations - as well.

;; When non-null, MCL's OT notifier handles acks to TCP sends.
;; When null, an ACK of the send is queued for OT to handle on its own.
;; What are the relative merits of these two approaches, apart from
;; by-passing a bug where a notification is lost? -- JCMa 5/15/1999.
;; Causes OpenTransport to use our buffers if T (notifying when done), or copy when NIL
(defvar *ack-sends* nil)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew :mactcp-compatibility *features*))

;; old interfaces specified library, new ones don't

(eval-when (:compile-toplevel :load-toplevel :execute)
  (when (not (osx-p))
    (add-to-shared-library-search-path "OTClientLib")
    (add-to-shared-library-search-path "OTUtilityLib")
    (add-to-shared-library-search-path "OTClientUtilLib")
    (add-to-shared-library-search-path "OTInetClientLib"))
  (add-to-shared-library-search-path "OpenTransportSupport")
  #+carbon-compat
  (add-to-shared-library-search-path "Apple;Carbon;Networking" nil))


;; dunno where these used to come from or why we need it etc etc but it isn't there now in new interfaces

(eval-when (:compile-toplevel :load-toplevel :execute)
(defconstant TRAPS::$KTCPNAME "tcp") ; #define kTCPName      "tcp"
(defconstant traps::$kDNRName	"dnr")
(defconstant traps::$kUDPName	"udp")
(defconstant traps::$kRawIPName "rawip"))
  

#| ; oh my - we can get these too
(defconstant $EPERM 1)          ;  Permission denied					
(defconstant $ENOENT 2)         ;  No such file or directory			
(defconstant $ENORSRC 3)        ;  No such resource						
(defconstant $EINTR 4)          ;  Interrupted system service			
(defconstant $EIO 5)            ;  I/O error							
(defconstant $ENXIO 6)          ;  No such device or address			
(defconstant $EBADF 9)          ;  Bad file number						
(defconstant $EAGAIN 11)        ;  Try operation again later			
(defconstant $ENOMEM 12)        ;  Not enough space						
(defconstant $EACCES 13)        ;  Permission denied					
(defconstant $EFAULT 14)        ;  Bad address							
(defconstant $EBUSY 16)         ;  Device or resource busy				
(defconstant $EEXIST 17)        ;  File exists							
(defconstant $ENODEV 19)        ;  No such device						
(defconstant $EINVAL 22)        ;  Invalid argument						
(defconstant $ENOTTY 25)        ;  Not a character device				
(defconstant $EPIPE 32)         ;  Broken pipe							
(defconstant $ERANGE 34)        ;  Math result not representable		
(defconstant traps::$EDEADLK 35)       ;  Call would block so was aborted		
(defconstant $EWOULDBLOCK 35);  Or a deadlock would occur			
(defconstant $EALREADY 37)
(defconstant $ENOTSOCK 38)      ;  Socket operation on non-socket		
(defconstant $EDESTADDRREQ 39)  ;  Destination address required			
(defconstant $EMSGSIZE 40)      ;  Message too long						
(defconstant $EPROTOTYPE 41)    ;  Protocol wrong type for socket		
(defconstant $ENOPROTOOPT 42)   ;  Protocol not available				
(defconstant $EPROTONOSUPPORT 43);  Protocol not supported				
(defconstant $ESOCKTNOSUPPORT 44);  Socket type not supported			
(defconstant $EOPNOTSUPP 45)    ;  Operation not supported on socket	
(defconstant $EADDRINUSE 48)    ;  Address already in use				
(defconstant $EADDRNOTAVAIL 49) ;  Can't assign requested address		
(defconstant $ENETDOWN 50)      ;  Network is down						
(defconstant $ENETUNREACH 51)   ;  Network is unreachable				
(defconstant $ENETRESET 52)     ;  Network dropped connection on reset	
(defconstant $ECONNABORTED 53)  ;  Software caused connection abort		
(defconstant $ECONNRESET 54)    ;  Connection reset by peer				
(defconstant $ENOBUFS 55)       ;  No buffer space available			
(defconstant $EISCONN 56)       ;  Socket is already connected			
(defconstant $ENOTCONN 57)      ;  Socket is not connected				
(defconstant $ESHUTDOWN 58)     ;  Can't send after socket shutdown		
(defconstant $ETOOMANYREFS 59)  ;  Too many references: can't splice	
(defconstant $ETIMEDOUT 60)     ;  Connection timed out					
(defconstant $ECONNREFUSED 61)  ;  Connection refused					
(defconstant $EHOSTDOWN 64)     ;  Host is down							
(defconstant $EHOSTUNREACH 65)  ;  No route to host						
(defconstant $EPROTO 70)
(defconstant $ETIME 71)
(defconstant $ENOSR 72)
(defconstant $EBADMSG 73)
(defconstant $ECANCEL 74)
(defconstant $ENOSTR 75)
(defconstant $ENODATA 76)
(defconstant $EINPROGRESS 77)
(defconstant $ESRCH 78)
(defconstant $ENOMSG 79)
(defconstant $ELASTERRNO 79)
|#
;; MOST OF THE frobs named #$kOTxxxerr are equal to (- -3199 #$xxx)

(defvar *opentransport-errno-strings*
  `((,#$kOTOutOfMemoryErr . "Open transport out of memory")
    (,#$kOTNotFoundErr . "Not found")  ; what is not found
    (,#$kOTDuplicateFoundErr . "Duplicate found.")  ; same as file exists    
    (,#$kOTBadAddressErr . "A Bad address was specified")				
    (,#$kOTBadOptionErr .  "A Bad option was specified")				
    (,#$kOTAccessErr . "Missing access permission")				
    (,#$kOTBadReferenceErr . "Bad provider referencE")
    (,#$kOTNoAddressErr  . "No address was specified")					
    (,#$kOTOutStateErr . "Call issued in wrong state")				
    (,#$kOTBadSequenceErr . "Sequence specified does not exist")		
    (,#$kOTSysErrorErr . "A system error occurred")					
    (,#$kOTLookErr . "An event occurred - call Look()")			
    (,#$kOTBadDataErr . "An illegal amount of data was specified")
    (,#$kOTBufferOverflowErr . " Passed buffer not big enough")				
    (,#$kOTFlowErr . " Provider is flow-controlled")				
    (,#$kOTNoDataErr . " No data available for reading")			
    (,#$kOTNoDisconnectErr . " No disconnect indication available")		
    (,#$kOTNoUDErrErr . " No Unit Data Error indication available")	
    (,#$kOTBadFlagErr . " A Bad flag value was supplied")			
    (,#$kOTNoReleaseErr . " No orderly release indication available")	
    (,#$kOTNotSupportedErr . " Command is not supported")					
    (,#$kOTStateChangeErr . " State is changing - try again later")		
    (,#$kOTNoStructureTypeErr . " Bad structure type requested for OTAlloc")	
    (,#$kOTBadNameErr . " A bad endpoint name was supplied")			
    (,#$kOTBadQLenErr . " A Bind to an in-use addr with qlen > 0")	
    (,#$kOTAddressBusyErr . " Address requested is already in use")		
    (,#$kOTIndOutErr . " Accept failed because of pending listen")	
    (,#$kOTProviderMismatchErr . " Tried to accept on incompatible endpoint")	
    (,#$kOTResQLenErr )
    (,#$kOTResAddressErr)
    (,#$kOTQFullErr)
    (,#$kOTProtocolErr . " An unspecified provider error occurred")	
    (,#$kOTBadSyncErr . " A synchronous call at interrupt time")		
    (,#$kOTCanceledErr . " The command was cancelled")				
    ; 
    ; 			 * Remapped StdCLib error codes. %%% Remove ones we don't actually return.
    ;  ;; some of this may be horse you know what
    
    (,#$kEPERMErr . " Permission denied")					
    ;(,#$kENOENTErr . " No such file or directory")  ; same as kotnotfounderr			
    (,#$kENORSRCErr . " No such resource")						
    (,#$kEINTRErr . " Interrupted system service")			
    (,#$kEIOErr . " error")							
    (,#$kENXIOErr . " No such device or address")			
    (,#$kEBADFErr . " Bad file number")						
    (,#$kEAGAINErr . " Try operation again later")			
    ;(,#$kENOMEMErr . " Not enough space")  ; same as kotoutofmemoryerr						
    (,#$kEACCESErr . " Permission denied")					
    (,#$kEFAULTErr . " Bad address")							
    (,#$kEBUSYErr . " Device or resource busy")				
    ;(,#$kEEXISTErr . " File exists") ; same as duplicate found							
    (,#$kENODEVErr . " No such device")						
    (,#$kEINVALErr . " Invalid argument")						
    (,#$kENOTTYErr . " Not a character device")				
    (,#$kEPIPEErr . " Broken pipe")							
    (,#$kERANGEErr . " Message size too large for STREAM")	
    (,#$kEWOULDBLOCKErr . " Call would block, so was aborted") ; huh		
    ;(,#$kEDEADLKErr . " or a deadlock would occur")  ; these are the same value			
    (,#$kEALREADYErr )
    (,#$kENOTSOCKErr . " Socket operation on non-socket")		
    (,#$kEDESTADDRREQErr . " Destination address required")			
    (,#$kEMSGSIZEErr . " Message too long")						
    (,#$kEPROTOTYPEErr . " Protocol wrong type for socket")		
    (,#$kENOPROTOOPTErr . " Protocol not available")				
    (,#$kEPROTONOSUPPORTErr . " Protocol not supported")				
    (,#$kESOCKTNOSUPPORTErr . " Socket type not supported")			
    (,#$kEOPNOTSUPPErr . " Operation not supported on socket")	
    (,#$kEADDRINUSEErr . " Address already in use")				
    (,#$kEADDRNOTAVAILErr . " Can't assign requested address")		
    (,#$kENETDOWNErr . " Network is down")						
    (,#$kENETUNREACHErr . " Network is unreachable")				
    (,#$kENETRESETErr . " Network dropped connection on reset")	
    (,#$kECONNABORTEDErr . " Software caused connection abort")		
    (,#$kECONNRESETErr . " Connection reset by peer")				
    (,#$kENOBUFSErr . " No buffer space available")			
    (,#$kEISCONNErr . " Socket is already connected")			
    (,#$kENOTCONNErr . " Socket is not connected")				
    (,#$kESHUTDOWNErr . " Can't send after socket shutdown")		
    (,#$kETOOMANYREFSErr . " Too many references: can't splice")	
    (,#$kETIMEDOUTErr . " Connection timed out")					
    (,#$kECONNREFUSEDErr . " Connection refused")					
    (,#$kEHOSTDOWNErr . " Host is down")							
    (,#$kEHOSTUNREACHErr . " No route to host")						
    (,#$kEPROTOErr )
    (,#$kETIMEErr )
    (,#$kENOSRErr )
    (,#$kEBADMSGErr )
    (,#$kECANCELErr )
    (,#$kENOSTRErr )
    (,#$kENODATAErr )
    (,#$kEINPROGRESSErr )
    (,#$kESRCHErr )
    (,#$kENOMSGErr )
    (,#$kOTClientNotInittedErr )
    (,#$kOTPortHasDiedErr )
    (,#$kOTPortWasEjectedErr )
    (,#$kOTBadConfigurationErr )
    (,#$kOTConfigurationChangedErr )
    (,#$kOTUserRequestedErr )
    (,#$kOTPortLostConnection . "Connection lost")
    (,#$EPERM . "Permission denied")					
    (,#$ENOENT . "No such file or directory")			
    (,#$ENORSRC . "No such resource")						
    (,#$EINTR . "Interrupted system service")			
    (,#$EIO . "I/O error")							
    (,#$ENXIO . "No such device or address")			
    (,#$EBADF . "Bad file number")						
    (,#$EAGAIN . "Try operation again later")			
    (,#$ENOMEM . "Not enough space")						
    (,#$EACCES . "Permission denied")					
    (,#$EFAULT . "Bad address")							
    (,#$EBUSY .  "Device or resource busy")				
    (,#$EEXIST . "File exists")							
    (,#$ENODEV . "No such device")						
    (,#$EINVAL . "Invalid argument")						
    (,#$ENOTTY . "Not a character device")				
    (,#$EPIPE .         "Broken pipe")							
    ;(,#$ERANGE .        "Math result not representable")		
    ;(,#$EDEADLK .       "Call would block so was aborted")
    (,#$ENOTSOCK .       "Socket operation on non-socket")		
    (,#$EDESTADDRREQ .  "Destination address required	")		
    (,#$EMSGSIZE .     "Message too long")						
    (,#$EPROTOTYPE .    "Protocol wrong type for socket")
    (,#$ENOPROTOOPT .   "Protocol not available")				
    (,#$EPROTONOSUPPORT . "Protocol not supported")				
    (,#$ESOCKTNOSUPPORT . "Socket type not supported")			
    (,#$EOPNOTSUPP .    "Operation not supported on socket")	
    (,#$EADDRINUSE .    "Address already in use")				
    (,#$EADDRNOTAVAIL  . "Can't assign requested address")		
    (,#$ENETDOWN .     "Network is down")						
    (,#$ENETUNREACH .   "Network is unreachable")				
    (,#$ENETRESET .    "Network dropped connection on reset")	
    (,#$ECONNABORTED .  "Software caused connection abort")		
    (,#$ECONNRESET .   "Connection reset by peer")				
    (,#$ENOBUFS .       "No buffer space available")			
    (,#$EISCONN .       "Socket is already connected")			
    (,#$ENOTCONN .      "Socket is not connected")				
    (,#$ESHUTDOWN .     "Can't send after socket shutdown")		
    (,#$ETOOMANYREFS .  "Too many references: can't splice")	
    (,#$ETIMEDOUT .     "Connection timed out")					
    (,#$ECONNREFUSED .  "Connection refused")					
    (,#$EHOSTDOWN .     "Host is down")						
    (,#$EHOSTUNREACH . "No route to host")))


;;;------------------------------------------------------------------- 
;;;
;;; CONDITIONS FOR MACTCP COMPATIBILITY
;;;

#+mactcp-compatibility
(progn
  
  (define-condition network-error (simple-condition error))
  
  ; These are required by some CL-HTTP clients.
  ; They are not signalled by the OpenTransport code.
  (define-condition tcp-connection-conflict (simple-condition error))
  (define-condition tcp-connection-does-not-exist (simple-condition error))
  
  )

;;;------------------------------------------------------------------- 
;;;
;;; CONDITIONS
;;;

(define-condition opentransport-error #-mactcp-compatibility (simple-condition error)
  #+mactcp-compatibility (network-error)
  ((error-message :initarg :error-message :initform "Generic OpenTransport error" :reader opentransport-error-message )
   ; add these for now 
   (error-number :initarg :error-number :initform nil :reader opentransport-error-number)
   (error-context :initarg :error-context :initform nil :reader opentransport-error-context)
   (stream :initarg :stream)) 
  ;; accept stream because sometimes callers of ot-error dont know whether we will get a stream-error
  ;; or e.g. an internal error
  (:report report-opentransport-error))

(define-condition mactcp-error (opentransport-error)) ; mactcp-compatibility

(define-condition tcp-error (mactcp-error))


; these "shouldn't happen" if we do our part right
(define-condition opentransport-internal-error (opentransport-error)
                  ((error-message :initform "Open Transport internal error")))

(define-condition opentransport-stream-error (opentransport-error stream-error)
                  ((error-message :initform "Open Transport stream error")
                   (stream :initform nil :initarg :stream :reader stream-error-stream)))

(define-condition opentransport-tcp-stream-error (tcp-error opentransport-stream-error)) ; yuck. 

(define-condition opentransport-stream-closed (opentransport-stream-error)
                  ((error-message :initform "Open Transport stream closed")))

; vanilla out of memory
(define-condition opentransport-out-of-memory-error (opentransport-error)
                  ((error-message :initform "System doesn't have enough memory")))

;; open transport internal memory
(define-condition opentransport-internal-memory-error (opentransport-out-of-memory-error)
                  ((error-message :initform "Open Transport doesn't have enough internal memory 
                             to perform the requested operation" )))


;; trying to allocate some bogus thing
(define-condition opentransport-allocation-error (opentransport-error)
                  ((error-message :initform "Open Transport allocation error")))

(define-condition domain-error (tcp-error))

(define-condition domain-resolver-error (domain-error)
                  ((error-message :initform "Domain resolver error")))

; we are guessing here
(define-condition tcp-domain-server-not-found (domain-error)
                  ((error-message :initform "Tcp domain server not found")))

#+mactcp-compatibility
(progn
  
  (define-condition unknown-host-name (opentransport-error)) ; fer mactcp compatibility
  (define-condition tcp-invalid-data-structure (opentransport-error)) ; fer mactcp compatibility
  (define-condition tcp-connection-state-timeout (opentransport-error)) ; fer mactcp compatibility
  
  )  ; progn

(define-condition tcp-unknown-domain-name (domain-error #+mactcp-compatibility unknown-host-name)
                  ((error-message :initform "Unknown host name")))

(define-condition tcp-no-response-from-domain-server (domain-error)
                  ((error-message :initform "No response from domain server")))

(define-condition tcp-bad-ip-address (tcp-error)
                  ((error-message :initform "Tcp bad ip address")))

(define-condition unauthorized-client-access (opentransport-error)
                  ((error-message :initform "Unauthorized client access")))

(define-condition remote-network-error (opentransport-error) ())

(define-condition local-network-error (opentransport-error) ())

(define-condition binding-local-tcp-address-error (local-network-error tcp-error)
                  ((error-message :initform "Error binding local tcp address")))

(define-condition host-not-responding (remote-network-error)
                  ((error-message :initform "Host not responding")))  

(define-condition bad-connection-state (opentransport-stream-error remote-network-error) ())

(define-condition host-stopped-responding (host-not-responding bad-connection-state)
                  ((error-message :initform "Host stopped responding")))

(define-condition protocol-timeout (opentransport-error))

(define-condition connection-closed (bad-connection-state)
                  ((error-message :initform "Connection closed")))

(define-condition connection-lost (bad-connection-state)
                  ((error-message :initform "Connection lost")))

(define-condition connection-reset (connection-lost)
                  ((error-message :initform "Connection reset")))

(define-condition connection-timed-out (protocol-timeout bad-connection-state) ; or is it command-timed-out?
                  ((error-message :initform "Connection timed out")))

(define-condition opentransport-self-closed (connection-closed)
                  ((error-message :initform "Self closed connection")))

(define-condition opentransport-peer-closed (connection-closed)
                  ((error-message :initform "Peer closed connection")))

(define-condition connection-error (remote-network-error) ())

(define-condition Connection-refused (connection-error)
                  ((error-message :initform "Connection refused")))

(define-condition unknown-tcp-port (tcp-error)
                  ((port :initarg :port :reader port))
  (:report (lambda (c s)
             (format s "Unknown tcp port ~s." (port c)))))

#+mactcp-compatibility
(define-condition error-loading-mactcp (opentransport-error))

(define-condition opentransport-initialization-error (#+mactcp-compatibility error-loading-mactcp opentransport-error)
                  ((error-message :initform "Error initializing Open Transport")))

(define-condition opentransport-invalid-data-structure ( opentransport-internal-error)
                  ((error-message :initform "Invalid data structure")))

(define-condition write-buffer-protocol-error (opentransport-internal-error)
                  ((ot-conn :initarg :ot-conn :reader ot-conn))
  (:report (lambda (c s) (format s "Write buffer protocol error using ~s" (ot-conn c)))))

(define-condition opentransport-protocol-error (remote-network-error)
                  ((error-message :initform "Protocol error")))

(define-condition opentransport-command-cancelled (opentransport-error)
                  ((error-message :initform "Command cancelled")))

(define-condition opentransport-state-changing (opentransport-stream-error)
                  ((error-message :initform "State is changing")))


(defmethod report-opentransport-error ((error opentransport-error) stream)
  (format stream "~A: ~A." (type-of error) (opentransport-error-message error))
  (let ((errno (opentransport-error-number error)))
    (if errno
      (let ((str (find-opentransport-errno-string errno)))
        (if str (format stream "~&~30t ~a." str)(format stream " ~d ." errno))))))

(defmethod report-opentransport-error ((error opentransport-stream-error) stream)
  (call-next-method)
  (if (stream-error-stream error)
    (format stream "~&~30t on  ~S."  (stream-error-stream error))))

(defmethod report-opentransport-error ((error opentransport-internal-memory-error) stream)
  (format stream "~A: ~A." (type-of error) (opentransport-error-message error)))

(defmethod report-opentransport-error ((error tcp-domain-server-not-found) stream)
  (format stream "~A: ~A." (type-of error) (opentransport-error-message error)))

;; should all these names end in -error or at least the ones that aren't trying to be compatible
(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(#+mactcp-compatibility network-error #+mactcp-compatibility mactcp-error
            opentransport-error tcp-error
            opentransport-stream-error
            opentransport-out-of-memory-error ; mac heap
            opentransport-internal-memory-error  ; more specifically ot internal memory
            opentransport-internal-error
            opentransport-stream-error
            opentransport-allocation-error
            domain-error
            tcp-domain-server-not-found
            #+mactcp-compatibility unknown-host-name
            tcp-unknown-domain-name
            tcp-no-response-from-domain-server
            tcp-bad-ip-address
            unauthorized-client-access
            remote-network-error
            host-not-responding
            host-stopped-responding
            bad-connection-state
            connection-closed
            connection-timed-out
            connection-lost
            connection-reset
            opentransport-self-closed ; ?
            opentransport-peer-closed
            connection-error
            connection-refused
            unknown-tcp-port
            error-loading-mactcp
            protocol-timeout
            opentransport-initialization-error
            opentransport-invalid-data-structure
            write-buffer-protocol-error
            opentransport-protocol-error
            opentransport-command-cancelled
            opentransport-state-changing
            local-network-error
            binding-local-tcp-address-error
            )
          :ccl)
  )


(defun find-opentransport-errno-string (errno)
  (cdr (assq errno *opentransport-errno-strings*)))

;; order matters
(defvar *opentransport-error-conditions*
  `((,#$kOTOutOfMemoryErr  opentransport-internal-memory-error)
    ((,#$kOTNoAddressErr  ,#$kOTSysErrorErr
      ,#$kOTBufferOverflowErr ,#$kOTBadFlagErr
      ,#$kOTBadQLenErr ,#$kOTProviderMismatchErr
      ,#$kENOTSOCKErr ,#$kEDESTADDRREQErr)
     opentransport-internal-error)
    (,#$kOTNoStructureTypeErr opentransport-invalid-data-structure)
    ; guessing here - probably wrong
    (,#$kOTNotFoundErr tcp-domain-server-not-found :opening-internetServices)
    (,#$kOTNoDataErr tcp-no-response-from-domain-server :dnr)
    (,#$kOTBadNameErr tcp-unknown-domain-name :dnr)
    (,#$kOTBadAddressErr tcp-bad-ip-address)
    ((,#$kOTAccessErr ,#$kEPERMErr ,#$kEACCESErr ,#$EPERM ,#$EACCES) unauthorized-client-access)
    ((,#$kEHOSTDOWNErr ,#$EHOSTDOWN) host-stopped-responding) ; but maybe it never started
    ((,#$kENETResetErr ,#$ENETRESET) connection-lost) ; network dropped on reset
    ((,#$kECONNABORTEDErr ,#$ECONNABORTED) connection-closed) ; software connection abort
    ((,#$kECONNRESETErr ,#$ECONNRESET) opentransport-peer-closed) ; connection reset by peer (reset==closed?)
    ((,#$kETIMEDOUTErr ,#$ETIMEDOUT) connection-timed-out) ; connection timed out
    ((,#$kECONNREFUSEDErr ,#$ECONNREFUSED) connection-refused) ; connection refused 
    (,#$kOTOutStateErr connection-lost :send)  
    (,#$kOTPortLostConnection connection-lost)
    (,#$kOTCanceledErr opentransport-command-cancelled)
    (,#$kOTStateChangeErr opentransport-state-changing)
    ((,#$kOTProtocolErr ,#$kEPROTOTYPEErr ,#$kENOPROTOOPTErr ,#$kEPROTONOSUPPORTErr
      ,#$kEPROTOErr ,#$EPROTONOSUPPORT ,#$ENOPROTOOPT ,#$EPROTOTYPE) opentransport-protocol-error)
    (nil connection-refused :connection-rejected)
    (nil connection-lost :connection-terminated)  ; terminated/lost/reset?
    (nil binding-local-tcp-address-error :binding-local-tcp-address)
    (nil opentransport-out-of-memory-error :out-of-memory)
    (nil tcp-unknown-domain-name :getting-host-name) ; address to name failed. Could be nameserver went lala too
    (nil domain-resolver-error :dnr)
    (nil opentransport-allocation-error :alloc ) ; want the internal-memory error more specific
    (nil opentransport-initialization-error :initopentransport)))  

; descriptor is (error number or numbers, error class, context (nil means any))
(defun find-opentransport-condition (errno &optional context)
  (dolist (desc *opentransport-error-conditions*)
    (let ((errnums (car desc))
          (contexts (caddr desc)))
      (and (if (null context)
             (null contexts)
             (if (consp contexts)
               (memq context contexts)
               (or (null contexts)(eq context contexts))))
           (if (or (null errnums)
                   (and (consp errnums)
                        (member errno errnums :test #'eql))
                   (eql errno errnums))
             (return (cadr desc)))))))

;;;------------------------------------------------------------------- 
;;;
;;; VALUE CACHING
;;;

(eval-when (:execute :compile-toplevel :load-toplevel)
  
  (defun value-cache-variable (name)
    (or (get name :value-cache-variable)
        (setf (get name :value-cache-variable)
              (intern (format nil "*~A*" (string-upcase (symbol-name name)))
                      (symbol-package name)))))
  
  (defun value-cache-max-size (name)
    (get (value-cache-variable name) :max-size))
  
  ;; List of special variables holding tables used to cache values.
  (defvar *value-cache-tables* nil)
  
  (defmacro define-value-cache (name (&key (max-size 300)) &rest table-args)
    (let ((var (value-cache-variable name)))
      `(progn
         (pushnew ',var *value-cache-tables*)
         (setf (get ',var :max-size) ',max-size)
         (defvar ,var (make-hash-table ,@table-args)))))
  
  (defmacro with-value-cached ((key table-name &key (recompute-p nil recompute-supplied-p)) &body value-form) 
    ;(declare (values retrieved-from-cache-p))
    (let* ((table (value-cache-variable table-name))
           (max-size (value-cache-max-size table-name))
           (form `(let ((val (gethash ,key ,table :+not-found+)))
                    (case val
                      (:+not-found+
                       ,@(when max-size
                           `((when (> (hash-table-count ,table) ,max-size)
                               (clrhash ,table)))) 
                       (setf (gethash ,key ,table) (progn  . ,value-form)))
                      (t (values val t))))))      
      (cond (recompute-supplied-p
             `(cond (,recompute-p
                     (setf (gethash ,key ,table) (progn . ,value-form)))
                    (t ,form)))
            (t form))))
  )

(defun map-value-cache-tables (function)
  (flet ((appy-fctn (item)
           (let ((table (symbol-value item)))
             (when table
               (funcall function table)))))
    (declare (dynamic-extent #'appy-fctn))
    (dolist (sym *value-cache-tables*)
      (let ((table (symbol-value sym)))
        (when table
          (funcall function table))))))

(defun clear-value-cache-tables ()
  (map-value-cache-tables #'clrhash)) 


;;;------------------------------------------------------------------- 
;;;
;;; 
;;;

(defvar *support-library-name* "OpenTransportSupport")
(defvar *default-notifier-name* "ot_stream_notifier")

(defloadvar *open-opentransport-streams* ())
(defloadvar *opentransport-class-endpoint-freelists* ())
(defloadvar *opentransport-class-proxies* ())
(defloadvar *opentransport-config-alist* ())
(defloadvar *opentransportsupport-version* 0)
(defvar *opentransportsupport-min-version* #x2200000)



; ot-contexts are now #_EnQueue-able.
(defrecord ot-context
  (ref :endpointref)
  (completed :boolean)                   ; for asynchronous calls
  (peerclosed :boolean)
  (selfclosed :boolean)
  (closing :boolean)
  (flags :unsigned-word)
  (synch :boolean)                      ; gone into synch mode
  (pad :boolean)
  (cookie :pointer)                     ; For asynchronous calls
  (code :oteventcode)
  (result :otresult)
  (wrQ (:pointer :qhdr))
  (rdQ (:pointer :qhdr))
  (request :pointer)                    ; Opaque; used in notifier.
  (qlink (:pointer :QElem))
  (qtype :word)
  (pad0 :word)
  (sendcount :unsigned-long)            ; number of calls to #_OTSnd with #_OTAckSends in effect
  (ackcount :unsigned-long)             ; notifier counts number of T_MEMORYRELEASED events.
  (client-call (:pointer :tcall))       ; a passive client's TCALL structure, where the notifier can find it.
  )

#|
typedef struct qbuf {
  QElemPtr qLink;
  short qType;
  short flags;
  unsigned  bufcount;
  char bufdata[1];
} qbuf;
|#

(defrecord qbuf
  (qlink (:pointer :QElem))
  (qtype :word)
  (flags :word)
  (bufcount :unsigned-long)
  (bufdata (:array :unsigned-byte 1)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant qbuf-flags-alloc-mask #x3)
  (defconstant qbuf-flags-alloc-shared 0)         ; this qbuf is part of some other structure.
  (defconstant qbuf-flags-alloc-otalloc 1)        ; this qbuf was created by #_OTAllocMem
  (defconstant qbuf-flags-alloc-newptr 2)         ; this qbuf was created by #_NewPtr
  )

(defstruct (ot-conn (:include io-buffer))
  context                               ; pointer to an ot-context
  endpoint                              ; a copy of the ot-context's endpoint
  call                                  ; a preallocated TCALL structure
  bindreq                               ; a couple of preallocated TBIND 
  bindret                               ;  structures
  options                               ; a preallocated TOptMgmt structure
  local-address                         ; protocol-specific, lispy ...
  peer-address                          ;  something like (:tcp #x8090a001 25)
  passive-p                             ; true if opened "passively"
  ) 

;; Used to recycle io-buffers -- JCMa 8/1/1997.
(defun ot-conn-reset (conn)
  (setf (ot-conn-call conn) nil 
        (ot-conn-bindreq conn) nil 
        (ot-conn-bindret conn) nil
        (ot-conn-options conn) nil
        (ot-conn-local-address conn) nil
        (ot-conn-peer-address conn) nil
        (ot-conn-passive-p conn) nil)) 

;; flag bits in ot-context.flags:
(defconstant ot-flag-data-pending-bit 0)        ; not used anymore outside of notifier
(defconstant ot-flag-proxy-context-bit 1)
(defconstant ot-flag-debug-notifier-bit 15)
(defconstant ot-flag-incoming-connection-bit 14)

; True when a passive connection has a proxy listening on its behalf.
(defconstant ot-flag-incoming-connection-allowed-bit 13)       

; When true at ot-context creation, sets the ot-flag-debug-notifier-bit.
; The notifier will report incoming events in a low-level debugger (e.g., MacsBug)
; when that bit is set.
(defvar *opentransport-debug-notifier* nil)

; Guess what this means.
(defvar *opentransport-initialized* nil)

; A macptr to the async notifier routine we use
(defvar *opentransport-notifier* nil)

; Should address->name and name->address lookups query a
; resolver and/or hosts file ?
(defvar *use-resolver* t)

; These aren't used yet. They're included for backward compatibility.
; Some clients may set them.
#+mactcp-compatibility
(progn
  
  (defvar *tcp-command-timeout* 30        ;  in seconds, timeouts at the TCP command level
    "Controls how many seconds TCP waits for for acknowledgements  at the TCP level from the other end of a connection.") 
  
  (defvar *tcp-maximum-number-of-connections* 20)   ; maximum supported by mactcp is 64
  
  
  (defun tcp-maximum-number-of-connections ()
    *tcp-maximum-number-of-connections*)
  
  ; New function
  (defun (setf tcp-maximum-number-of-connections) (max)
    (setq *tcp-maximum-number-of-connections*
          (require-type max '(integer 1))))
  
  (defun tcp-use-name-resolver ()
    *use-resolver*)
  
  ; New function
  (defun (setf tcp-use-name-resolver) (flag)
    (setq *use-resolver* (not (null flag))))
  
  (defun %tcp-getaddr ()
    (local-interface-ip-address))
  
  (defun tcp-host-cname (host)
    (inet-host-name host))
  
  )  ; progn

(defvar *tcp-close-timeout* 10    ; in seconds, the time to wait before aborting a slow closing connection
  "The seconds to wait for a connection to close.")

(defvar *tcp-read-timeout* (* 60 2)         ;  in seconds, the time to wait for replys from the other end
  "Controls how many seconds TCP waits for replys from the other end of a connection.") 

(defun ot-error (errnum &optional context stream-or-conn &rest args) ; context was string - now keyword
  ; Make this a lot better ... errnum can be nil
  (let ((condition-class (find-opentransport-condition errnum context))
        (fn #'error))
    (if (not condition-class)(setq condition-class 'opentransport-error))
    (when (typep stream-or-conn 'ot-conn)
      (setq stream-or-conn (ot-conn-stream stream-or-conn)))
    (apply fn
           (if stream-or-conn
             (make-condition condition-class :error-number errnum :error-context context
                             :stream stream-or-conn)
             (make-condition condition-class :error-number errnum :error-context context))
           args)))

(defvar our-context (make-record (:ot-context :clear t)))

(def-ccl-pointers context ()
  (setq our-context (make-record (:ot-context :clear t))))

(defun init-opentransport ()
  "Call #_InitOpenTransport and locate the notifier function in 
   the \"support\" library.  This needs to be called once per
   MCL session; it should be called as needed by the OpenTransport
   stream functions."
  (or (and *opentransport-initialized* *opentransport-notifier*)
      ; Some utility functions - notably #_InitOpenTransport -
      ; aren't in the shared libraries that Apple distributes.  - is now #_initopentransportinContext
      ; They -are- in the "OpenTransportSupport" library that
      ; we distribute; ensure that that library exists on the
      ; CFM search path before doing much else.
      (let* ((ot-present (gestalt #$gestaltOpenTpt))
             (ot-version (or (gestalt #$gestaltOpenTptVersions) 0)))
        (unless ot-present (error "OpenTransport is not installed on this system."))
        (unless (>= ot-version #x1110000)
          (error "This software requires OpenTransport 1.1.1 or later.")))
      (let* ((err nil))
        (multiple-value-bind (conn mainaddr error-number error-frag)
                             (get-shared-library "OpenTransportSupport"
                                                 :error-p nil)
          (declare (ignore mainaddr))
          (if (and conn (eql (setq err (#_InitOpentransportInContext #$kInitOTForApplicationMask (%null-ptr))) ;our-context))
                             #$kOTNoError))
            (let* ((notifier (get-frag-symbol conn *default-notifier-name* nil))
                   (version (%int-to-ptr (ash (or (get-frag-symbol conn "OpenTransportSupportVersion" nil) 0)
                                              ppc::fixnumshift))))
              ;; why is this shifting?? - should really be using #_newotnotifyupp - is the address actually that of a transfer-vector?              
              (setq *opentransport-notifier* (%int-to-ptr (ash (or notifier 0) ppc::fixnumshift)))
              #+carbon-compat ;; ??? - its just identity today - need newest interfaces for correct return type
              (compiler-let ((*dont-use-cfm* nil))  ;; is this needed ??
                (setq *opentransport-notifier* (#_NewOTNotifyUPP *opentransport-notifier*)))              
              (unless (%null-ptr-p version)
                (setq *opentransportsupport-version* (%get-unsigned-long version))) 
              (unless (>= *opentransportsupport-version* *opentransportsupport-min-version*)
                (error "You need to install a newer version of the \"OpenTransportSupport\" library."))                          
              (setq *opentransport-initialized* t))
            (if conn
              (ot-error err :InitOpenTransport) ; lord knows
              ;(ot-error err "in #_InitOpenTransport")
              (error "Can't find shared library ~s: error = ~d on fragment ~s"
                     "OpenTransportSupport" error-number error-frag)))))))

(defun ot-%get-endpoint-state (endpoint)
  (let* ((state 0))
    (declare (fixnum state))
    (when endpoint
      (do* ()
           ((not (= (setq state (#_OTGetEndpointState endpoint)) #$kOTStateChangeErr)) state)))))

(defvar *opentransport-endpoint-states*
  #(:uninit :unbnd :idle :outcon :incon :dataxfer :outrel :inrel))

(defun ot-conn-get-endpoint-state (conn)
  (let* ((state (ot-%get-endpoint-state (ot-conn-endpoint conn))))
    (values
     (if (null state)
       :closed
       (if (or (< state 0) (>= state (length *opentransport-endpoint-states*)))
         :error
         (svref *opentransport-endpoint-states* state)))
     state)))


(defun opentransport-alloc-endpoint-from-freelist (stream)
  (without-interrupts
   (let* ((cell (assoc (opentransport-stream-protocol-string stream)  *opentransport-class-endpoint-freelists* :test #'equal)))
     (when cell
       (let ((cons (cdr cell)))
         (when cons
           (prog1 (car cons)
             (setf (cdr cell) (cdr cons))
             (free-cons cons))))))))

(defun opentransport-add-endpoint-to-freelist (endpoint stream)
  (without-interrupts
   (let* ((string (opentransport-stream-protocol-string stream))
          (cell (assoc string  *opentransport-class-endpoint-freelists* :test #'equal)))
     (if cell
       (progn
         (if (memq endpoint (cdr cell))
           (cerror "Continue" "Endpoint already in free list")
           (setf (cdr cell) (cheap-cons endpoint (cdr cell)))))
       (push (cons string (cheap-list endpoint)) *opentransport-class-endpoint-freelists*))
     nil)))

(defun ot-set-endpoint-asynch (endpoint notifier context)
  (#_OTRemoveNotifier endpoint)         ; ignoring errors, just in case another notifier is installed
  (#_OTSetAsynchronous endpoint)
  (#_OTInstallNotifier endpoint notifier context))

(defvar *ot-conn-minimum-outbuf-size* 512)        ; less than this is ridiculous
(defvar *ot-conn-maximum-outbuf-size* 4096)       ; more than this radically slows down local connections
(defvar *ot-conn-outbuf-size* 4096)       ; fastest for local connections

; Allocate the context record, the read- and write-queue headers,
; and 2 1K write buffers from the same gcable pointer.
; Enqueue both write buffers.

(defun ot-make-endpoint-context (endpoint &optional notifier minimal)
  (let* ((logical-size (min *ot-conn-maximum-outbuf-size*
                            (max *ot-conn-minimum-outbuf-size*
                                 *ot-conn-outbuf-size*)))       ; this is bound by the initialize-instance method
         (total-size (+ (record-length :ot-context)
                        (* 2 (record-length :qhdr))
                        (if minimal 0 (* 2 (+ logical-size (get-field-offset :qbuf.bufdata))))))
         (context (%new-gcable-ptr total-size t)))
    (setf (pref context :ot-context.ref) endpoint
          (pref context :ot-context.wrQ) (%inc-ptr context (record-length :ot-context))
          (pref context :ot-context.rdQ) (%inc-ptr context (+ (record-length :ot-context) (record-length :qhdr))))
    (unless minimal
      (let* ((wrbuf0 (%inc-ptr context (+ (record-length :ot-context) (* 2 (record-length :qhdr)))))
             (wrbuf1 (%inc-ptr wrbuf0 (+ logical-size (get-field-offset :qbuf.bufdata))))
             (wrq (%inc-ptr context (record-length :ot-context))))
        (declare (dynamic-extent wrbuf0 wrbuf1 wrq)
                 (type macptr wrbuf0 wrbuf1 wrq))
        (setf (pref wrbuf0 :qbuf.bufcount) logical-size
              (pref wrbuf1 :qbuf.bufcount) logical-size)
        (#_Enqueue wrbuf0 wrq)
        (#_Enqueue wrbuf1 wrq)))
    (when notifier
      (ot-set-endpoint-asynch endpoint notifier context)
      (when *ack-sends*
        (#_OTAckSends endpoint))
      (when *opentransport-debug-notifier*
        (setf (pref context :ot-context.flags) (ash 1 ot-flag-debug-notifier-bit))))
    context))

(defun ot-new-context (stream configptr notifier &optional minimal)
  (let* ((endpoint (ot-make-stream-endpoint stream configptr)))    
    (values (ot-make-endpoint-context endpoint notifier minimal) endpoint)))

; for stream-passive-reconnect - get a new endpoint for existing conn and context.
; what about ot-conn-call etal which are function of ENDPOINT? - hmmm

(defun ot-stream-new-endpoint (stream)  ; <<
  (let* ((endpoint (ot-make-stream-endpoint stream))
         (conn (stream-io-buffer stream))
         (context (ot-conn-context conn)))
    (setf (pref context :ot-context.ref) endpoint)
    (let ((notifier *opentransport-notifier*))
      (ot-set-endpoint-asynch endpoint notifier context)
      (when *ack-sends*
        (#_OTAckSends endpoint))
      (when *opentransport-debug-notifier*
        (setf (pref context :ot-context.flags) (ash 1 ot-flag-debug-notifier-bit))))    
    (setf (ot-conn-endpoint conn) endpoint)))

; Get a new endpoint, possibly from freelist.
; Stream can be nil in which case configptr should not be nil.

(defun ot-make-stream-endpoint (stream &optional configptr) ; <<  
  (let* ((endpoint (if stream (opentransport-alloc-endpoint-from-freelist stream)))
         (err #$kOTNoError))
    (when (null endpoint)
      (if (and (null configptr) stream)
        (setq configptr (ot-cloned-configuration (opentransport-stream-protocol-string stream))))
      (rlet ((errP :osstatus))
        (setq endpoint #+carbon-compat (#_OTOpenEndpointInContext configptr 0 (%null-ptr) errP *null-ptr*)
                       #-carbon-compat (#_OTOpenEndpoint configptr 0 (%null-ptr) errP)
              err (pref errP :osstatus))))
    (unless (eql err #$kOTNoError)
      (ot-error err :create))
    endpoint))


(defun ot-cloned-configuration (string)
  (let* ((conf (cdr (assoc string *opentransport-config-alist* :test #'string=))))
    (if (null conf)
      (with-cstrs ((confname string))
        (push (cons string (setq conf (#_OTCreateConfiguration confname)))
              *opentransport-config-alist*)))
    (#_OTCloneConfiguration conf)))

;; Recycle the io-buffer structure when present on the stream. -- JCMa 8/1/1997. 
(defun ot-new-conn (stream)
  (flet ((initialize-conn (context endpoint stream)
           ;; Check for unbound io-buffer slot. OT-NEW-CONN is being RJoswig
           (let ((conn  (and (slot-boundp stream 'io-buffer) (%stream-io-buffer stream))))
             (cond (conn
                    (setf (ot-conn-context conn) context
                          (ot-conn-endpoint conn) endpoint
                          (ot-conn-stream conn) stream)        ; redundant
                    conn)
                   (t (make-ot-conn :context context 
                                    :endpoint endpoint 
                                    :stream stream))))))
    (declare (inline initialize-conn))
    (rlet ((errP :osstatus))
      (init-opentransport)
      (multiple-value-bind (context endpoint) 
                           (ot-new-context stream 
                                           nil ; let ot-new-context do config if necessary - (ot-cloned-configuration (opentransport-stream-protocol-string stream))
                                           *opentransport-notifier*)
        (let* ((err #$kOTNoError)
               (conn (initialize-conn context endpoint stream)))
          (macrolet ((check-ot-error-return (error-context)
                       `(unless (eql (setq err (pref errP :osstatus)) #$kOTNoError)
                          (values (ot-error err ,error-context)))))
            (setf (ot-conn-call conn) 
                  #-carbon-compat (#_OTAlloc endpoint #$T_CALL #$T_ADDR errP)
                  #+carbon-compat (#_OTAllocInContext endpoint #$T_CALL #$T_ADDR errP *null-ptr*) ;; or null?
                  )
            (check-ot-error-return :alloc)
            (setf (ot-conn-bindreq conn) 
                  #-carbon-compat (#_OTAlloc endpoint #$T_BIND #$T_ADDR errP)
                  #+carbon-compat (#_OTAllocInContext endpoint #$T_BIND #$T_ADDR errP *null-ptr*)
                  )
            (check-ot-error-return :alloc)
            (setf (ot-conn-bindret conn) 
                  #-carbon-compat (#_OTAlloc endpoint #$T_BIND #$T_ADDR errP)
                  #+carbon-compat (#_OTAllocInContext endpoint #$T_BIND #$T_ADDR errP *null-ptr*)
                  )
            (check-ot-error-return :alloc)
            (setf (ot-conn-options conn) 
                  #-carbon-compat (#_OTAlloc endpoint #$T_OPTMGMT #$T_OPT errP)
                  #+carbon-compat (#_OTAllocInContext endpoint #$T_OPTMGMT #$T_OPT errP *null-ptr*)
                  )
            (check-ot-error-return :alloc)
            conn)))))) 

; Need to free any enqueued, unread qbufs on the rdQ.
; DON'T EVER free anthing on the wrQ (write buffers are
; allocated from the same pointer as the stream context is.)
(defun ot-free-conn (conn)
  (let* ((call (ot-conn-call conn))
         (bindreq (ot-conn-bindreq conn))
         (bindret (ot-conn-bindret conn))
         (options (ot-conn-options conn))
         (inbuf (io-buffer-inbuf conn)))
    (when call
      (setf (ot-conn-call conn) nil)
      (#_OTFree call #$T_CALL))
    (when bindreq
      (setf (ot-conn-bindreq conn) nil)
      (#_OTFree bindreq #$T_BIND))
    (when bindret
      (setf (ot-conn-bindret conn) nil)
      (#_OTFree bindret #$T_BIND))
    (when options
      (setf (ot-conn-options conn) nil)
      (#_OTFree options #$T_OPTMGMT))
    (when inbuf
      (unless (%null-ptr-p inbuf)
        (let ((qbuf (%inc-ptr inbuf (- (get-field-offset :qbuf.bufdata)))))
          (declare (dynamic-extent qbuf))
          (ot-free-read-buffer qbuf))
        (%setf-macptr inbuf (%null-ptr)))
      (with-macptrs ((rdq (pref (ot-conn-context conn) :ot-context.rdQ))
                     (qbuf))
        (do* ()
             ((not (%dequeue rdq qbuf)))
          (ot-free-read-buffer qbuf))))))

(defvar *read-buffers-freed* 0)

(defun ot-free-read-buffer (qbuf)
  (incf *read-buffers-freed*)
  (case (logand qbuf-flags-alloc-mask (the fixnum (pref qbuf :qbuf.flags)))
    (#. qbuf-flags-alloc-newptr (#_DisposePtr qbuf))
    (#. qbuf-flags-alloc-otalloc (#_OTFreeMem qbuf))))


(defun ot-conn-disconnect (conn ep)
  ; If currently in :dataxfer state, disconnect and return T if successful.
  ; Else return nil.
  (let* ((context (ot-conn-context conn))
         (stream (io-buffer-stream conn)))
    ; Tell notifier to consume incoming data
    (setf (pref context :ot-context.closing) t)
    (flet ((drain-input ()
             ; Drain the incoming data queue
             (loop
               (unless (ot-conn-buffer-advance stream conn nil nil)
                 (return)))))
      (drain-input)
      (prog1
        (let ((result t))
          (when (>= (the fixnum (ot-%get-endpoint-state ep)) #$T_DATAXFER)
            (unless (pref context :ot-context.selfclosed)
              (setf (pref context :ot-context.selfclosed) t)
              (when (eql #$kOTNoError (#_OTSndOrderlyDisconnect ep))
                (process-poll-with-timeout
                 "Disconnect"
                 (* 60 (the fixnum *tcp-close-timeout*))
                 #'(lambda (context) 
                     (pref context :ot-context.peerclosed)) 
                 context)))
            (unless (pref context :ot-context.peerclosed)
              (setf (pref context :ot-context.completed) nil)
              (#_OTSndDisconnect ep (%null-ptr))
              (ot-poll-for-completion context "Disconnect" (* 60 (the fixnum *tcp-close-timeout*)))
              (when (not (pref context :ot-context.completed))
                (setq result nil))); i.e. it timed out
            result))
        (setf (ot-conn-peer-address conn) nil)
        (drain-input)))))

; Get the endpoint into a state where it's
; a) disconnected
; b) not bound to any addresses
; c) in synchronous, non-blocking mode with no notifier installed.
; d) back on the stream's class freelist.

;(defvar *freelist-opentransport-endpoints-p* t)

;; shorter name, more generic.
;; If nil endpoints wont be freelisted and release-connection will nuke the endpoint while
;; retaining context and buffers.

(defvar *ot-recycle-endpoints* t)  

(defun ot-free-endpoint (ep context &optional conn)
  ; If connected (in the #$T_DATAXFER state), disconnect.
  (when conn (ot-conn-disconnect conn ep))
  ; If awaiting an active or passive connection, abort the connection attempt.
  (let* ((state (ot-%get-endpoint-state ep)))
    (declare (fixnum state))
    (when (or (= state #$T_OUTCON) (= state #$T_INCON))
      (#_OTSndDisconnect ep (%null-ptr))))
  ; If the endpoint is bound to local/remote addresses, unbind it.
  (when (= (the fixnum (ot-%get-endpoint-state ep)) #$T_IDLE)
    (setf (pref context :ot-context.completed) nil)
    (when (eql #$kOTNoError (#_OTUnbind ep))
      (ot-poll-for-completion context "OpenTransport: Unbind")))
  ; Remove the notifier and put the endpoint in synch mode.
  ; If it's now in the #$T_UNBND state, put it on the stream class's freelist;
  ; otherwise, nuke it.
  (let* ()
    (declare (fixnum state))
    ; Wait until sends have been acknowledged.  This may become more critical
    ; if/when buffers are allocated independently of the allocation of the
    ; context record.
    ; It's not clear what'll happen if OT tries to call a notifier that's
    ; not installed and active, but I don't want to find out.
    (when conn
      (process-poll "Buffer Return" #'(lambda (c) (= (pref c :ot-context.sendcount)
                                                     (pref c :ot-context.ackcount)))
                    context))
    (ot-set-endpoint-synch ep context)
    (#_OTRemoveNotifier ep)
    ; OT 1.1.1 can recycle active connections properly.
    (without-interrupts ;  <<
     (if (and conn (eql (ot-%get-endpoint-state ep) #$T_UNBND) *ot-recycle-endpoints*)
       (opentransport-add-endpoint-to-freelist ep (ot-conn-stream conn))
       (#_OTCloseProvider ep))
     (setf (pref context :ot-context.ref)(%null-ptr))
     (when conn (setf (ot-conn-endpoint conn) nil)))))

(defun ot-conn-free-endpoint (conn)
  (let* ((ep (ot-conn-endpoint conn))
         (context (ot-conn-context conn)))
    (when ep
      (setf (ot-conn-endpoint conn) nil)
      ;(setf (pref context :ot-context.ref) (%null-ptr)) ; ot-free-endpoint does that
      (ot-free-endpoint ep context conn)))) 

(defun ot-set-endpoint-synch (endpoint context)
  (setf (pref context :ot-context.synch) t)
  (unless (#_OTIsSynchronous endpoint)
    (#_OTSetSynchronous endpoint))) 

(defmacro  %ot-wait-for-completion (context whostate poll-p timeout)
  `(if (,(if poll-p 'process-poll-with-timeout 'process-wait-with-timeout) 
        ,whostate 
        ,timeout 
        #'(lambda (context) 
            (or (pref context :ot-context.synch)
                (pref context :ot-context.completed))) ,context)
     ;; Check for successful completion
     (cond ((pref ,context :ot-context.synch) #$kOTCanceledErr)
           ((pref ,context :ot-context.completed) (pref ,context :ot-context.result))
           (t (error "Implementation Error: This should never happen.")))
     ;; timed out
     #$kETIMEDOUTErr))

(defun ot-wait-for-completion (context whostate &optional timeout)
  (%ot-wait-for-completion context whostate nil timeout))

(defun ot-poll-for-completion (context whostate &optional timeout)
  (%ot-wait-for-completion context whostate t timeout))

; This assumes that we're operating in async mode
(defun ot-conn-bind-local-address (conn req)
  (let* ((endpoint (ot-conn-endpoint conn))
         (context (ot-conn-context conn))
         (err #$kOTNoError))
    (setf (pref context :ot-context.completed) nil)
    (setq err (#_OTBind endpoint (or req (%null-ptr)) (ot-conn-bindret conn)))
    (when (eql err #$kOTNoError)
      (setq err (ot-poll-for-completion context "Bind Local Address"))
      (when (> (pref (ot-conn-bindret conn) :tbind.qlen) 0)
        (break "Qlen !")))        ; what's this debugging code doing here? -- JCMa 5/28/1999.
    err))

(defun ot-context-negotiate-4-byte-option (context level name val)
  (let* ((endpoint (pref context :ot-context.ref))        
         (err #$kOTNoError))
    (declare (dynamic-extent context))
    (%stack-block ((buf #$kOTFourByteOptionSize))
      (rlet ((req TOptMgmt))
        (let* ((opt buf))
          (setf (pref opt :toption.level) level
                (pref opt :toption.name) name  ;; toption.optname variant is gonzo
                (pref opt :toption.status) 0
                (pref opt :toption.len) #$kOTFourByteOptionSize
                (%get-unsigned-long opt (get-field-offset :toption.value)) val)
          (let* ((reqopt (pref req :toptmgmt.opt)))
            (declare (dynamic-extent reqopt))
            (setf (pref reqopt :tnetbuf.buf) buf
                  (pref reqopt :tnetbuf.len) #$kOTFourByteOptionSize
                  (pref reqopt :tnetbuf.maxlen) #$kOTFourByteOptionSize
                  (pref req :toptmgmt.flags) #$T_NEGOTIATE
                  (pref context :ot-context.completed) nil))
          (setq err (#_OTOptionManagement endpoint req req))
          (when (eql err #$kOTNoError)
            (setq err (ot-poll-for-completion context "OpenTransport: Option Negotiate")))     ; check to see if polling really necessary -- JCMa 5/28/1999.
          (when (eql err #$kOTNoError)
            (let* ((status (pref opt :toption.status)))
              (unless (eql status #$T_SUCCESS)
                (setq err status)))))))
    err))

; Somebody's initialized the remote address info in the "call" field of the ot-conn.

(defun ot-conn-active-connect (conn timeout)
  (let* ((endpoint (ot-conn-endpoint conn))
         (context (ot-conn-context conn))
         (err #$kOTNoError))
    (setf (pref context :ot-context.completed) nil)
    (setq err (#_OTConnect endpoint (ot-conn-call conn) (%null-ptr)))
    (when (or (eql err #$kOTNoError) (eql err #$kOTNoDataErr))
      (setq err (ot-wait-for-completion context "Connect" timeout))
      (when (eql err #$kOTNoError)
        (let* ((code (pref context :ot-context.code)))
          (if (eql code #$T_CONNECT)
            (setq err (#_OTRcvConnect endpoint (%null-ptr)))
            (if (eql code #$T_DISCONNECT)         ; notifier has done #_OTRcvDisconnect, and set context.result to reason
              (let ((err (pref context :ot-context.result)))
                (if (%null-ptr-p (pref context :ot-context.cookie))
                  (ot-error err :connection-terminated)
                  (ot-error err :connection-rejected)))
              (setq err code))))))
    (unless (eql err #$kOTNoError)
      ;(ot-error err "while attempting active connection.")
      (ot-error err :active-connect)
      )))

(defun ot-conn-tcp-host-active-connect (conn host port timeout)
  (let* ((call (ot-conn-call conn))
         (addr (pref call :tcall.addr)))        ; tnetbuf: peer address
    (declare (dynamic-extent addr))
    (let* ((err (ot-conn-bind-local-address conn nil)))
      (unless (eql err #$kOTNoError)
        (ot-error err :binding-local-tcp-address))
      (with-macptrs ((addr (pref (pref (ot-conn-bindret conn) :tbind.addr) :tnetbuf.buf)))
        (setf (ot-conn-local-address conn) (ot-parse-inetaddress addr)))
      (setf (ot-conn-peer-address conn) `(:tcp ,host ,port))
      (#_OTInitInetAddress (pref addr :tnetbuf.buf) port host)
      (setf (pref addr :tnetbuf.len)
            (record-length :inetaddress))
      (ot-conn-active-connect conn timeout))))

(defun ot-proxy-bind (context bindreq)
  (rlet ((errP :osstatus))
    (let* ((endpoint (pref context :ot-context.ref))
           (bindret #-carbon-compat (#_OTAlloc endpoint #$T_BIND #$T_ADDR errP)
                    #+carbon-compat (#_OTAllocInContext endpoint #$T_BIND #$T_ADDR errP *null-ptr*)
                    )
           (status (pref errP :osstatus)))
      (declare (dynamic-extent endpoint))
      (when (eq status #$kOTNoError)
        (setf (pref context :ot-context.completed) nil)
        (setf (pref context :ot-context.code) 0)
        (unwind-protect
          (progn
            (setq status (#_OTBind endpoint bindreq bindret))
            (when (eql status #$kOTNoError)
              (setq status (ot-poll-for-completion context "Bind Local Address")))
            (#_OTFree bindret #$T_BIND))))
      status))) 

(defun ot-tcp-proxy-bind (context endpoint host port reuse-p)    
  (rlet ((errP :osstatus))
    (let* ((bindreq #-carbon-compat (#_OTAlloc endpoint #$T_BIND #$T_ADDR errP)
                    #+carbon-compat (#_OTAllocInContext endpoint #$T_BIND #$T_ADDR errP *null-ptr*)
                    )
           (bindret #-carbon-compat (#_OTAlloc endpoint #$T_BIND #$T_ADDR errP)
                    #+carbon-compat (#_OTAllocInContext endpoint #$T_BIND #$T_ADDR errP *null-ptr*)
                    )
           (status (pref errP :osstatus)))
      (declare (fixnum status) (dynamic-extent bindreq bindret))
      (when (= status #$kOTNoError)
        (unwind-protect
          (progn
            (ot-context-negotiate-4-byte-option context #$inet_ip #$kip_reuseaddr (if reuse-p #$T_YES #$T_NO))  ;; #ip -> #$kip
            (let* ((netbuf (pref bindreq :tbind.addr)))
              (declare (dynamic-extent netbuf))
              (setf (pref netbuf :tnetbuf.len) (record-length :inetaddress)
                    (pref bindreq :tbind.qlen) 5)       ; arbitrary qlen
              (#_OTInitInetAddress (pref netbuf :tnetbuf.buf) port host)
              (setf (pref context :ot-context.completed) nil)
              (when (= (setq status (#_OTBind endpoint bindreq bindret)) #$kOTNoError)
                (setq status (ot-poll-for-completion context "Proxy Bind"))
                (when (and (= status #$kOTNoError)
                           (not (eql (pref bindreq :tbind.qlen) ; << was bindret
                                     (pref bindret :tbind.qlen))))
                  (break "Bind qlen differs from requested length!")))))
          (progn
            (unless (%null-ptr-p bindreq) (#_OTFree bindreq #$T_BIND))
            (unless (%null-ptr-p bindret) (#_OTFree bindret #$T_BIND)))))
      status)))

(defun ot-new-proxy (config-name bindfunction &rest bind-args)
  (declare (dynamic-extent bind-args))
  (rlet ((errP :osstatus))
    (with-cstrs ((conf config-name))
      (init-opentransport)
      (multiple-value-bind (context endpoint) 
                           (ot-new-context nil (#_OTCreateConfiguration conf) *opentransport-notifier* :proxy)
        (setf (pref context :ot-context.flags) 
              (logior (pref context :ot-context.flags) (ash 1 OT-FLAG-PROXY-CONTEXT-BIT)))
        (let* ((err (pref errP :osstatus)))
          (declare (fixnum err))
          (setq err (apply bindfunction context endpoint bind-args))
          (unless (= err #$kOTNoError)
            (ot-error err :create))
          context)))))

(defun ot-find-proxy (address)
  (cdr (assoc address *opentransport-class-proxies* :test #'equal)))

(defun ot-tcp-proxy (address allow-reuse)
  (or
   (ot-find-proxy address)
   (without-interrupts
    (destructuring-bind (host port) (cdr address)
      (let* ((context (ot-new-proxy #$ktcpname #'ot-tcp-proxy-bind host port allow-reuse)))
        (push (cons address context) *opentransport-class-proxies*)
        context)))))


#|
(defun ot-print-proxy-endpoints (&optional (address `(:TCP ,(local-interface-ip-address) 80)))
   (let* ((proxy-context (ot-find-proxy address))
             (qhdr (pref proxy-context ot-context.wrq)))
      (do* ((head (pref qhdr :qhdr.qhead) (pref head :qelem.qlink)))
              ((%null-ptr-p head))
         (let* ((context (%inc-ptr head (- (get-field-offset :ot-context.qlink)))))      
            (print (pref context :ot-context.ref))))))

(defun ot-proxy-endpoints (&optional (address `(:TCP ,(local-interface-ip-address) 80)))
   (let* ((proxy-context (ot-find-proxy address))
             (qhdr (pref proxy-context ot-context.wrq))
             (endpoints ()))
      (do* ((head (pref qhdr :qhdr.qhead) (pref head :qelem.qlink)))
              ((%null-ptr-p head) (nreverse endpoints))
         (push (pref (%inc-ptr head (- (get-field-offset :ot-context.qlink)))
                           :ot-context.ref) endpoints))))

; In general, these guys should all be T_UNBND .  If they're bound 
; and T_IDLE, #_OTAccept will sometimes think that they're bound to
; the wrong address.
(mapcar #'ot-%get-endpoint-state (ot-proxy-endpoints))

|#

(defun ot-enqueue-client (proxy-context client-context)
  (when (ot-dequeue-client proxy-context client-context)
    (break "Client already enqueued!"))
  (setf (pref client-context :ot-context.flags) 
        (logior
         (pref client-context :ot-context.flags)        ; preserve debug bit, etc.
         (ash 1 ot-flag-incoming-connection-allowed-bit)))
  (let* ((ep (pref client-context :ot-context.ref)))
    (declare (dynamic-extent ep))
    (when (= (the fixnum (ot-%get-endpoint-state ep)) #$T_IDLE)
      (setf (pref client-context :ot-context.completed) nil)
      (when (eql #$kOTNoError (#_OTUnbind ep))
        (ot-wait-for-completion client-context "OpenTransport: Unbind"))))
  (with-macptrs ((q (%inc-ptr client-context (get-field-offset :ot-context.qLink))))
    (#_Enqueue q (pref proxy-context :ot-context.wrQ))))

; Returns T if client was on queue.
(defun ot-dequeue-client (proxy-context client-context)
  (with-macptrs ((q (%inc-ptr client-context (get-field-offset :ot-context.qLink))))
    (prog1
      (eql #$noErr (#_Dequeue q (pref proxy-context :ot-context.wrQ)))
      (setf (pref client-context :ot-context.flags) 
            (logand (pref client-context :ot-context.flags)
                    (lognot (ash 1 ot-flag-incoming-connection-allowed-bit)))))))

;;; Don't bind the passive client to the same address as the proxy,
;;; instead leaving it unbound & letting #_OTAccept bind it to
;;; the same address as the proxy.
(defun ot-conn-tcp-passive-connect (conn port &optional (allow-reuse t))
  (let* ((context (ot-conn-context conn))
         (localhost (local-interface-ip-address))
         (localaddress `(:tcp ,localhost ,port))
         (proxy (ot-tcp-proxy localaddress allow-reuse)))
    (setf (ot-conn-passive-p conn) t)
    ; A week ago, I was absolutely convinced that this was necessary.
    ; Now, I'm absolutely convinced that OpenTransport sometimes complains
    ; that a "handoff" endpoint is in "the wrong state" on completion of
    ; an #_OTAccept call.  It doesn't complain when the endpoint's unbound,
    ; so I can only assume that it thinks that a bound endpoint has a different
    ; address than the proxy.  It doesn't, but The Right Thing happens when
    ; the handoff endpoint's unbound (why was it failing last week ?), so
    ; it's as easy as anything to skip the #_OTBind-ing here.
    ; Note that OT-ENQUEUE-CLIENT will unbind the client anyhow, so this
    ; is just saving itself some work.
    ; Supposedly, #_OTBind is allowed to bind to an address other than the
    ; one requested, and it's the caller's job to check that.  -Maybe- it's
    ; sometimes deciding to pick a random address, and that's why the #_OTAccept
    ; later fails.
    #+never
    (let* ((bindreq (ot-conn-bindreq conn)))
      (#_OTInitInetAddress (pref (pref bindreq :tbind.addr) :tnetbuf.buf) 
       port localhost)
      (setf (pref bindreq :tbind.qlen) 0)
      (ot-context-negotiate-4-byte-option context #$inet_ip #$ip_reuseaddr 
                                          (if allow-reuse #$T_YES #$T_NO))
      (let* ((err (ot-conn-bind-local-address conn bindreq)))
        (unless (eql err #$kOTNoError)
          (ot-error err :binding-local-tcp-address))))
    (setf (ot-conn-local-address conn) localaddress)
    ; Put the client's preallocated TCALL where the notifier can find it.
    (setf (pref context :ot-context.client-call) (ot-conn-call conn))
    (ot-enqueue-client proxy context)))

; This is the low-level mechanism; a higher-level caller would have to
; somehow ensure that there weren't any outstanding process-waits on
; this conn or its context, etc.
; Somebody should also presumably grab the lock on the conn while this
; is going on.
(defun ot-conn-passive-reconnect (conn)
  (when (ot-conn-passive-p conn)
    (let* ((endpoint (ot-conn-endpoint conn))
           (context (ot-conn-context conn))
           (address (ot-conn-local-address conn))
           (proxy (ot-find-proxy address))
           (old-endpoint endpoint))
      (when (or (null endpoint)(memq  (ot-conn-get-endpoint-state conn) '(:unbnd :idle))) ; ?? initialize-http-stream used to check this
        (if endpoint  ; <<
          (progn
            (ot-conn-disconnect conn endpoint)
            (when (not (memq  (ot-conn-get-endpoint-state conn) '(:unbnd :idle)))  ; ??????
              (let ((*ot-recycle-endpoints* nil))
                (ot-conn-free-endpoint conn)
                (setq old-endpoint nil)
                (setq endpoint (ot-stream-new-endpoint (ot-conn-stream conn))))))
          (setq endpoint (ot-stream-new-endpoint (ot-conn-stream conn))))
        (when (and endpoint proxy)
          (ot-dequeue-client proxy context)
          (let ((state (ot-%get-endpoint-state endpoint)))
            (when (or (null old-endpoint)
                      (eql state #$t_idle)
                      (eql state #$t_unbnd))
              (setf (pref context :ot-context.completed) nil
                    (pref context :ot-context.peerclosed) nil
                    (pref context :ot-context.selfclosed) nil
                    (pref context :ot-context.closing) nil)
              (setf (ot-conn-peer-address conn) nil)
              (ot-enqueue-client proxy context)
              t)))))))

; Do just the disconnect part of ot-conn-passive-reconnect.
; This allows the higher level to "close" a stream while leaving
; it in a state that is quick to reconnect.
; if not recycling endpoints, free the endpoint else disconnect it.
; So we hang onto context and buffers in either case.

(defun ot-conn-release-connection (conn)
  (let* ((endpoint (ot-conn-endpoint conn))
         (context (ot-conn-context conn))
         (address (ot-conn-local-address conn))
         (proxy (ot-find-proxy address)))
    (when endpoint
      (when proxy
        (ot-dequeue-client proxy context))
      (if *ot-recycle-endpoints*  ; <<
        (progn
          (ot-conn-disconnect conn endpoint)
          (when (not (memq  (ot-conn-get-endpoint-state conn) '(:unbnd :idle))) ; ??????
            (let ((*ot-recycle-endpoints* nil))
              (ot-conn-free-endpoint conn))))
        (ot-conn-free-endpoint conn))
      t)))


;; we need some signalling infrastructure here so we don't believe we received all the input. -- JCMa 5/13/1999.
(defun ot-conn-buffer-advance (s conn readp errorp)
  (declare (ignore s errorp))
  (let* ((buf (io-buffer-inbuf conn)))
    (unless (%null-ptr-p buf)           ; Can that happen ?
      (let* ((qbuf (%inc-ptr buf (- (get-field-offset :qbuf.bufdata)))))
        (declare (dynamic-extent qbuf))
        (ot-free-read-buffer qbuf))
      (%setf-macptr buf (%null-ptr))
      (%setf-macptr (io-buffer-inptr conn) (%null-ptr))
      (setf (io-buffer-incount conn) 0))
    (or (ot-conn-next-buffer conn)
        (when readp
          ; Wait until buffer available or stream closed.
          (process-poll-with-timeout "Net Input"
                                     (* 60 (the fixnum *tcp-read-timeout*))
                                     #'(lambda (conn)
                                         (or (ot-conn-next-buffer conn)
                                             (pref (ot-conn-context conn) :ot-context.peerclosed)))
                                     conn)
          ; Return T if not EOF
          (not (= (the fixnum (io-buffer-incount conn)) 0))))))

(defun ot-conn-listen (s conn)
  (funcall (io-buffer-advance-function conn) s conn nil nil))

(defun %dequeue (qheader ptr)
  (without-interrupts
   (unless (%null-ptr-p (%setf-macptr ptr (pref qheader :qhdr.qHead)))
     (eql #$noErr (#_Dequeue ptr qheader)))))

; Dequeue a write buffer.  We may have to PROCESS-WAIT until
; the notifier enqueues one.
(defun ot-conn-get-wrqbuf (conn)
  (let* ((context (ot-conn-context conn))
         (wrbuf (io-buffer-outbuf conn))
         (wrptr (io-buffer-outptr conn)))
    (%setf-macptr wrbuf (%null-ptr))
    (%setf-macptr wrptr wrbuf)
    (with-macptrs ((wrq)
                   (qbuf))
      (%setf-macptr wrq (pref context :ot-context.wrQ))
      (or (%dequeue wrq qbuf)
          (process-poll "Send Ack" #'(lambda (wrq qbuf context) (or (%dequeue wrq qbuf)(pref context :ot-context.peerclosed))) wrq qbuf context))
      (if (and (%null-ptr-p qbuf)(pref context :ot-context.peerclosed))
        (progn (error 'opentransport-peer-closed :stream (ot-conn-stream conn))) 
        (if (%null-ptr-p wrbuf)
          (progn
            (%setf-macptr wrbuf (%inc-ptr qbuf (get-field-offset :qbuf.bufdata)))
            (%setf-macptr wrptr wrbuf)
            (setf (io-buffer-outcount conn) (pref qbuf :qbuf.bufcount)))          
          (error 'write-buffer-protocol-error :ot-conn conn))))))

(defun ot-conn-flushbuf (s conn count finish-p)
  (declare (ignore s finish-p) (fixnum count))
  (let* ((buf (io-buffer-outbuf conn))
         (needbuf (%null-ptr-p buf))    ; we need a new buffer if this one's empty or we send something.
         (endpoint (ot-conn-endpoint conn))
         (context (ot-conn-context conn)))
    (declare (fixnum remaining sofar))
    (do* ()
         ((<= count 0))
      (let* ((result (#_OTSnd endpoint buf count 0)))
        (declare (fixnum result))
        (cond ((= result count)
               ; Wrote all of the data in the buffer
               (incf (pref context :ot-context.sendcount))
               (setq needbuf t)
               (unless *ack-sends*
                 (let ((queue-buf (%inc-ptr buf (- (get-field-offset :qbuf.bufdata)))))
                   (without-interrupts
                    ;;do what notifier would have
                    (incf (pref context :ot-context.ackcount))
                    (with-macptrs ((wrq))
                      (%setf-macptr wrq (pref context :ot-context.wrQ))
                      (#_Enqueue queue-buf wrq)))))
               (return))
              ((> result 0) 
               ; Wrote some of the data; copy the rest into a new buffer 
               ; & continue.
               (incf (pref context :ot-context.sendcount))
               (decf count result)
               (with-macptrs ((lastsent buf))
                 (ot-conn-get-wrqbuf conn)
                 (#_BlockMoveData (%inc-ptr lastsent result) buf count)))
              ((= result #$kOTFlowErr))         ; try again
              ((pref context :ot-context.peerclosed)
               (error 'opentransport-peer-closed :stream (ot-conn-stream conn)))
              ((< result 0)  (ot-error result :send conn)))))
    (when needbuf (ot-conn-get-wrqbuf conn))))

(defvar *read-buffers-obtained* 0)

; This assumes that the last recv buffer has been freed and that
; (ot-conn-rdbuf conn) is %null-ptr-p.
(defun ot-conn-next-buffer (conn)
  (let* ((context (ot-conn-context conn)))
    (with-macptrs ((rdq (pref context :ot-context.rdq))
                   (qbuf))
      (when (%dequeue rdq qbuf)
        ; If qbuf.bufcount is 0, qbuf.bufdata is an OTBuffer that
        ; the notifier couldn't read from.
        (if (eql (pref qbuf :qbuf.bufcount) 0)
          (without-interrupts
           (let* ((OTBuffer (%get-ptr qbuf (get-field-offset :qbuf.bufdata)))
                  (length (#_OTBufferDataSize OTBuffer)))
             (#_OTFreeMem qbuf)         ; notifier allocated it.
             (setq qbuf (ot-allocate-qbuf length))
             (with-macptrs ((qbuf-data (pref qbuf :qbuf.bufdata)))
               (rlet ((buffer-info OTBufferinfo)
                      (lenptr :long))
                 (%put-long lenptr length 0)
                 ;(#_OTInitBufferInfo buffer-info OTBuffer) - its below
                 (setf (pref buffer-info :OTBufferinfo.fbuffer) otbuffer)
                 (setf (pref buffer-info  :OTBufferinfo.fpad)
                       (pref otbuffer :otbuffer.fpad1))
                 (setf (pref buffer-info :OTBufferinfo.foffset) 0)
                 (#_OTReadBuffer buffer-info qbuf-data lenptr)
                 (#_OTReleaseBuffer OTBuffer))))))
        (without-interrupts (incf *read-buffers-obtained*))       ; keep the count accurate
        (%setf-macptr (io-buffer-inbuf conn) (%inc-ptr qbuf (get-field-offset :qbuf.bufdata)))
        (%setf-macptr (io-buffer-inptr conn) (io-buffer-inbuf conn))
        (setf (io-buffer-incount conn) (pref qbuf :qbuf.bufcount))
        t))))

(defun ot-allocate-qbuf (length) 
  ; if we do this then shouldn't OTfree these read buffers either.
  (let ((qbuf (#_newptrClear  (+ length (get-field-offset :qbuf.bufdata)))))
    (when (%null-ptr-p qbuf)(ot-error nil :out-of-memory))
    (setf (pref qbuf :qbuf.bufcount) length
          (pref qbuf :qbuf.flags) qbuf-flags-alloc-newptr)
    ;(print length)
    qbuf))

(declaim (inline %ot-conn-closed-p))

(defun %ot-conn-closed-p (conn)
  (null (ot-conn-endpoint conn)))

(defun ot-conn-closed-p (conn)
  (let* ((endpoint (ot-conn-endpoint conn)))
    (or (null endpoint)
        (and (< (the fixnum (ot-%get-endpoint-state endpoint)) #$T_DATAXFER)
             (not (logbitp ot-flag-incoming-connection-allowed-bit 
                           (the fixnum (pref (ot-conn-context conn) :ot-context.flags))))))))
#|
(defun ot-conn-eofp (s conn)
  (declare (ignore s))
  (and (null (%io-buffer-advance conn nil nil))
       (ot-conn-closed-p conn)))
|#

; from Terje N.
(defun ot-conn-eofp (s conn)
   (declare (ignore s))
   (and (null (%io-buffer-advance conn nil nil))
        (or (ot-conn-closed-p conn)
            (pref (ccl::ot-conn-context conn)
                  :ot-context.peerclosed))))
 

;; Don't lose the io-buffer when closing the conn -- JCMa 8/1/1997.
(defun ot-conn-close (conn)
  (unless (%ot-conn-closed-p conn)
    ; If we don't know that the peer's closed
    ; and don't "know that we've closed", send a disconnect.
    ; Then close the endpoint.
    (let* ((proxy (ot-find-proxy (ot-conn-local-address conn))))
      (when proxy (ot-dequeue-client proxy (ot-conn-context conn))))
    (ot-conn-free-endpoint conn)
    (ot-free-conn conn)
    (ot-conn-reset conn)))

(defun ot-conn-get-protaddr (conn peer-bind local-bind)
  (let* ((endpoint (ot-conn-endpoint conn))
         (context (ot-conn-context conn)))
    (setf (pref (pref peer-bind :tbind.addr) :tnetbuf.len) 0
          (pref (pref local-bind :tbind.addr) :tnetbuf.len) 0
          (pref context :ot-context.completed) nil)
    (if (eql #$kOTNoError (#_OTGetProtAddress endpoint local-bind peer-bind))
      (ot-wait-for-completion context "Protocol Address"))))

(defun ot-conn-tcp-get-addresses (conn)
  (rlet ((local-ip :inetaddress)
         (peer-ip :inetaddress)
         (local-buf :tnetbuf)
         (peer-buf :tnetbuf)
         (local-bind :tbind)
         (peer-bind :tbind))
    (setf (pref local-buf :tnetbuf.maxlen) (record-length :inetaddress)
          (pref peer-buf :tnetbuf.maxlen) (record-length :inetaddress)
          (pref local-buf :tnetbuf.buf) local-ip
          (pref peer-buf :tnetbuf.buf) peer-ip
          (pref local-bind :tbind.addr) local-buf
          (pref peer-bind :tbind.addr) peer-buf)
    (ot-conn-get-protaddr conn peer-bind local-bind)
    (values 
     (unless (eql (pref local-buf :tnetbuf.len) 0)
       (let* ((localhost (pref local-ip :inetaddress.fhost)))
         `(:tcp 
           ,(if (eql localhost #$kOTAnyInetAddress)
              (local-interface-ip-address)
              localhost)
           ,(pref local-ip :inetaddress.fport))))
     (unless (eql (pref peer-buf :tnetbuf.len) 0)
       `(:tcp ,(pref peer-ip :inetaddress.fhost) ,(pref peer-ip :inetaddress.fport))))))

; There may someday be more than one configured interface.
; Note also that if TCP is "load-on-call" and hasn't been loaded,
; the #_OTInetGetInterfaceInfo call will fail with a #$kOToNotFoundErr.
(defun local-interface-ip-address (&optional (interface #$kDefaultInetInterface))
  (rlet ((info :inetinterfaceinfo))
    (let* ((err (#_OTInetGetInterfaceInfo info interface)))
      (when (eql err #$kOTNotFoundErr)         ; need to open the interface
        ; This dials the modem if TCP is over a PPP connection.
        (ot-close-inet-service (ot-new-inet-service))
        (setq err (#_OTInetGetInterfaceInfo info interface)))
      (if (eql err #$kOTNoError)
        (pref info :InetInterfaceInfo.fAddress)
        (ot-error err)))))

#|
(defun ot-conn-get-endpoint-options (conn level protoname)
   (let* ((endpoint (ot-conn-endpoint conn))
             (context (ot-conn-context conn))
             (ret (ot-conn-options conn)))
      (rlet ((req :TOptMgmt)
                (option :TOptionHeader))
         (setf (pref option :TOptionHeader.len) #$kOTOptionHeaderSize
                  (pref option :TOptionHeader.level) level
                  (pref option :TOptionHeader.optname) #$T_ALLOPT
                  (pref (pref req :TOptMgmt.opt) :TNetBuf.buf) option
                  (pref (pref req :TOptMgmt.opt) :TNetBuf.len) #$kOTOptionHeaderSize
                  (pref req :TOptMgmt.flags) #$T_CURRENT
                  (pref context :ot-context.completed) nil)
         (let* ((error (#_OTOptionManagement endpoint req ret))
                   (phase 0))
            (when (eql error #$kOTNoError)
                (setq phase 1 error (ot-poll-for-completion context "OpenTransport: Option Query")))
            (if (eql error #$kOTNoError)
               (%stack-block ((string 512))
                    (with-cstrs ((pname protoname))
                        (setq phase 2)
                        (let* ((opt (pref (pref ret :TOptMgmt.opt) :TNetBuf.buf))
                                  (optlen (pref (pref ret :TOptMgmt.opt) :TNetBuf.len)))
                           (rlet ((popt :pointer))
                              (setf (%get-ptr popt) opt)
                              (if (eql (setq error (#_OTCreateOptionString pname popt (%inc-ptr opt optlen) string 512))
                                          #$kOTNoError) 
                                 (return-from ot-conn-get-endpoint-options (%get-cstring string))
                                 (progn
                                    (inspect string)
                                    (break))))))))
            (break "Error = ~d, phase = ~d" error phase)))))

(defun stream-ip-options (s)
   (ot-conn-get-endpoint-options (stream-io-buffer s) #$inet_ip #$krawipname))

(defun stream-tcp-options (s)
   (ot-conn-get-endpoint-options (stream-io-buffer s) #$inet_tcp #$ktcpname))
  
|#

(eval-when (:compile-toplevel :load-toplevel :execute)
(defconstant traps::$kDefaultInternetServicesPath -3)  ;; got neglected in new headers ; #define kDefaultInternetServicesPath        ((OTConfigurationRef)-3L)
)

(defun ot-new-inet-service ()
  (init-opentransport)
  (rlet ((errp :oSerr))
    (let* ((endpoint 
            #+carbon-compat (#_OTOpenInternetServicesInContext (%int-to-ptr (logand #xffffffff #$kDefaultInternetServicesPath)) 0 errp (%null-ptr))
            #-carbon-compat (#_OTOpenInternetServices (%int-to-ptr (logand #xffffffff #$kDefaultInternetServicesPath)) 0 errp)
            )
           (err (%get-long errP)))
      (if (eql #$kOTNoError err)
        (ot-make-endpoint-context endpoint *opentransport-notifier* t)
        ;(ot-error err "while opening OpenTransport InternetServices.")
        (ot-error err :opening-InternetServices)))))

(defun ot-close-inet-service (context)
  (let* ((endpoint (pref context :ot-context.ref)))
    (declare (dynamic-extent endpoint) (type macptr endpoint))
    (unless (%null-ptr-p endpoint)
      (setf (pref context :ot-context.ref) (%null-ptr))
      (#_OTCloseProvider endpoint))))

(defun get-host-address (string &optional (i 0))
  (multiple-value-bind (valid-p host) (%tcp-ip-string-p string)
    (if valid-p
      host
      (if (zerop (length string))
        (local-interface-ip-address)
        (if *use-resolver*
          (let* ((s (ot-new-inet-service)))
            (rlet ((hinfo :inethostinfo))
              (with-cstrs ((cs string))
                (let* ((err (#_OTInetStringToAddress (pref s :ot-context.ref) cs hinfo)))
                  (unwind-protect
                    (when (eql err #$kOTNoError)
                      (process-wait "DNS Reverse Lookup" #'(lambda (s) (pref s :ot-context.completed)) s)
                      (setq err (pref s :ot-context.result)))
                    (ot-close-inet-service s)
                    (#_DisposePtr s)
                    (%setf-macptr s (%null-ptr)))
                  (if (eql err #$kOTNoError)
                    (raref hinfo :inethostinfo.addrs i)
                    (ot-error err :dnr))))))
          ; If a nameserver error falls in the forest, and the nameserver is disabled,
          ; is it still a resolver error ?
          (error "Can't resolve hostname ~s" string))))))

(defun inet-host-name (host)
  (if (eql host 0)
    (setq host (local-interface-ip-address))
    (check-type host (unsigned-byte 32)))
  (if *use-resolver*
    (let* ((s (ot-new-inet-service)))
      (rlet ((name :inetdomainname))
        (let* ((err (#_OTInetAddressToName (pref s :ot-context.ref) host name)))
          (unwind-protect
            (when (eql err #$kOTNoError)
              (process-wait "DNS Lookup" #'(lambda (s) (pref s :ot-context.completed)) s)
              (setq err (pref s :ot-context.result)))
            (ot-close-inet-service s)
            (#_DisposePtr s)
            (%setf-macptr s (%null-ptr)))
          (if (eql err #$kOTNoError)
            (let* ((len (#_OTStrLength name)))
              (declare (fixnum len))
              (if (and (> len 1) (eql (char-code #\.) (%get-byte name (the fixnum (1- len)))))
                (decf len))
              (values (%str-from-ptr name len)))
            (ot-error  err :getting-host-name)))))
    (tcp-addr-to-str host)))

(defun tcp-host-address (host)
  (etypecase host
    ((unsigned-byte 32) host)
    (string (get-host-address host)))) 

(defun %tcp-ip-string-p (string)
  (with-cstrs ((s string))
    (rlet ((host :inethost))
      (setf (pref host :inethost) 0)
      (values (eql #$kOTNoError (#_OTInetStringToHost s host)) (pref host :inethost)))))

(defvar *service-name-number-alist*
  '(("echo" . 7)
    ("discard" . 9)                     ; sink null
    ("systat" . 11)
    ("daytime" . 13)
    ("netstat"	. 15)
    ("ftp-data" . 20)
    ("ftp" . 21)
    ("telnet" . 23)
    ("smtp" . 25)
    ("time" . 37)
    ("name" . 32)                       ; (udp only)
    ("whois" . 43)                      ; usually to sri-nic
    ("domain" . 53)
    ("rje" . 77)
    ("finger" . 79)
    ("http" . 80)
    ("link" . 87)                       ; ttylink
    ("supdup" . 95)
    ("iso-tsap" . 102)
    ;("x400" . 103)                      ; # ISO Mail
    ("dictionary" . 103)
    ("hostnames" . 101)                 ; usually to sri-nic
    ("x400-snd" . 104)
    ("csnet-ns" . 105)
    ("pop" . 109)
    ("sunrpc" . 111)
    ("uucp-path" . 117)
    ("nntp" . 119)
    ("ntp" . 123)
    ("NeWS" . 144)
    ; UNIX specific services
    ;these are NOT officially assigned
    ("exec" . 512)
    ("login" . 513)
    ("shell" . 514)
    ("printer" . 515)                   ; spooler	# experimental
    ("courier" . 530)                   ; rpc		# experimental
    ("ingreslock" . 1524)
    ("imap" . 143)))

(defun tcp-service-port-number (port)
  (etypecase port
    ((unsigned-byte 16) port)
    ((or string symbol) (or (cdr (assoc port *service-name-number-alist* :test #'string-equal))
                            (error 'unknown-tcp-port :port port)))))

(defun tcp-addr-to-str (address)
  (format nil "~d.~d.~d.~d"
          (ldb (byte 8 24) address)
          (ldb (byte 8 16) address)
          (ldb (byte 8 8) address)
          (ldb (byte 8 0) address)))

(eval-when (:execute :compile-toplevel :load-toplevel)
  ;; Cache size is 300 individual addresses before clearing and starting again.
  (define-value-cache tcp-addr-to-str-cache (:max-size 300) :test #'equal :size 300)
  )         

;; caches mapping from address fixnum to IP address string
(defun tcp-addr-to-str (address &optional buffer)
  (flet ((write-address (addr stream)
           (format stream"~D.~D.~D.~D"
                   (ldb (byte 8 24) addr)
                   (ldb (byte 8 16) addr)
                   (ldb (byte 8  8) addr)
                   (ldb (byte 8  0) addr))))
    (declare (inline write-address))
    (if buffer
      (write-address address buffer)
      (with-value-cached (address tcp-addr-to-str-cache)
        (write-address address buffer)))))

(defun tcp-service-name (portnum)
  (or (car (rassoc portnum *service-name-number-alist*))
      portnum))

;  OpenTransport streams
(defclass opentransport-stream (buffered-character-io-stream-mixin)
  ((protocol-string :initform "unspecified" :allocation :class :accessor opentransport-stream-protocol-string)))

(defclass opentransport-basic-tcp-stream (opentransport-stream)
  ((protocol-string :initform #$ktcpname :allocation :class)
   (stream-read-timeout :initform *tcp-read-timeout*
                        :accessor stream-read-timeout
                        :initarg :read-timeout)))

#+:mactcp-compatibility
(defclass basic-tcp-stream (opentransport-basic-tcp-stream)
  ())

;; This class should eventually support CR-LF translation in both directions.-- JCMa 4/18/1996.
(defclass opentransport-tcp-stream (#-:mactcp-compatibility opentransport-basic-tcp-stream
                                    #+:mactcp-compatibility basic-tcp-stream)
  ())

#+:mactcp-compatibility
(defclass tcp-stream (opentransport-tcp-stream)
  ())

(defclass opentransport-binary-tcp-stream (buffered-binary-io-stream-mixin  ;; <<  put the mixin first, not last
                                           #-:mactcp-compatibility opentransport-tcp-stream
                                           #+:mactcp-compatibility tcp-stream
                                           )
  ())


#+:mactcp-compatibility
(defclass binary-tcp-stream (opentransport-binary-tcp-stream) ;; << was opentransport-tcp-stream
  ())

(defmethod initialize-instance ((s opentransport-stream) &rest rest &key writebufsize)
  (declare (dynamic-extent rest))
  (let ((*ot-conn-outbuf-size* *ot-conn-outbuf-size*))
    (when writebufsize
      (setq *ot-conn-outbuf-size* (require-type writebufsize 'fixnum)))
    (setf (stream-io-buffer s) (ot-new-conn s)))
  (apply #'call-next-method s
         :advance-function #'ot-conn-buffer-advance
         :eofp-function #'ot-conn-eofp
         :listen-function #'ot-conn-listen
         :force-output-function #'ot-conn-flushbuf
         rest)
  s)


(defmethod initialize-instance ((s opentransport-basic-tcp-stream) &key
                                host port (reuse-local-port-p t) connect-timeout
                                commandtimeout writebufsize element-type)
  (declare (ignore commandtimeout writebufsize element-type))
  (call-next-method)
  (when host
    (setq host (tcp-host-address host)))
  (setq port (tcp-service-port-number port))
  (let* ((conn (stream-io-buffer s))
         (success nil))
    (unwind-protect
      (progn
        (if host
          (ot-conn-tcp-host-active-connect conn host port connect-timeout)
          (ot-conn-tcp-passive-connect conn port reuse-local-port-p))
        (setq success t)
        (without-interrupts
         (pushnew s *open-opentransport-streams*))
        s)
      (unless success 
        (when conn (ot-conn-close conn))))))

(defmethod initialize-instance ((s opentransport-binary-tcp-stream) &key
                                (element-type '(unsigned-byte 8) element-type-p) &allow-other-keys)
  (unless (or (not element-type-p)
              (eq element-type 'unsigned-byte)          ; Shorthand ...
              (and (subtypep element-type '(unsigned-byte 8))
                   (subtypep '(unsigned-byte 8) element-type)))
    (error "element-type ~S not supported." element-type))
  (call-next-method))

(defmethod stream-close ((s opentransport-stream))
  (let* ((conn (stream-io-buffer s nil)))
    (when (and conn (not (%ot-conn-closed-p conn)))
      (with-io-buffer-locked (conn)
        (when (eq :dataxfer (opentransport-stream-connection-state s))
          (handler-case
            (force-output s)
            (opentransport-peer-closed ())))
        (ot-conn-close conn)
        (setq *open-opentransport-streams* (delete s *open-opentransport-streams* :test #'eq))
        t))))

; Returns true if it succeeds.
; If it returns NIL, you should CLOSE the stream
(defmethod stream-release-connection ((s opentransport-stream))
  (let ((conn (stream-io-buffer s nil)))
    (when (and conn (not (%ot-conn-closed-p conn)))
      (with-io-buffer-locked (conn)
        (when (eq :dataxfer (opentransport-stream-connection-state s))
          (handler-case
            (force-output s)
            (opentransport-peer-closed ())))
        (ot-conn-release-connection conn)))))

; Returns true if it succeeds.
(defmethod stream-passive-reconnect ((s opentransport-stream)) 
  (let ((conn (stream-io-buffer s nil)))
    (when conn
      (with-io-buffer-locked (conn)
        (macrolet ((clear-buffer (buf-fun ptr-fun count-fun)
                     `(let ((buf (,buf-fun conn))
                            (ptr (,ptr-fun conn)))
                        (without-interrupts
                         (if (%null-ptr-p buf)
                           (progn
                             (%setf-macptr ptr buf)
                             (setf (,count-fun conn) 0))
                           (progn
                             (incf (,count-fun conn) (%ptr-difference ptr buf))
                             (%setf-macptr ptr buf)))))))
          (clear-buffer io-buffer-inbuf io-buffer-inptr io-buffer-incount)
          (setf (io-buffer-untyi-char conn) nil)
          (clear-buffer io-buffer-outbuf io-buffer-outptr io-buffer-outcount))
        (ot-conn-passive-reconnect conn)))))

(defun open-tcp-stream (host port &key
                             (reuse-local-port-p t)
                             (element-type 'base-character)
                             (readbufsize 1024)
                             (writebufsize *ot-conn-outbuf-size*)
                             connect-timeout)
  (declare (ignorable readbufsize))
  (if (subtypep element-type 'base-character)
    (make-instance 'opentransport-tcp-stream
      :host host :port port :connect-timeout connect-timeout
      :reuse-local-port-p reuse-local-port-p :writebufsize writebufsize)
    (make-instance 'opentransport-binary-tcp-stream
      :element-type element-type
      :host host :port port  :connect-timeout connect-timeout
      :reuse-local-port-p reuse-local-port-p
      :writebufsize writebufsize)))

(defun ot-parse-inetaddress (buf)
  (let* ((host (pref buf :inetaddress.fhost))
         (port (pref buf :inetaddress.fport)))
    (declare (integer host) (fixnum port))
    `(:tcp ,(if (zerop host) (or (local-interface-ip-address) 0) host) ,port)))


(defmethod stream-closed-p ((s opentransport-tcp-stream))
  (let ((conn (stream-io-buffer s)))
    (or (null conn)
        (ot-conn-closed-p conn))))

(defmethod print-object ((s opentransport-tcp-stream) stream)
  (print-unreadable-object (s stream :type t :identity t)
    (if (not (slot-boundp s 'io-buffer))
      (write-string "(uninited)" stream)
      (let* ((conn (stream-io-buffer s nil)))
        (if (or (null conn) (ot-conn-closed-p conn))
          (format stream "~S" (if (and conn (eq (ot-conn-get-endpoint-state conn) :uninit))
                                :reset
                                :closed))
          
          (multiple-value-bind (state-name state) (ot-conn-get-endpoint-state conn)
            (if (logbitp ot-flag-incoming-connection-allowed-bit (pref (ot-conn-context conn) :ot-context.flags))
              (format stream "~S @~a" :listen (tcp-service-name (third (ot-conn-local-address conn))))
              (let* ((local-address (ot-conn-local-address conn))
                     (peer-address (ot-conn-peer-address conn)))
                (format stream "~S" state-name)
                (when (> state #$T_UNBND)
                  (let* ((local-port (third local-address)))
                    (if (ot-conn-passive-p conn)
                      (progn
                        (unless peer-address
                          (with-macptrs ((addr (pref (pref (ot-conn-call conn) :tcall.addr) :tnetbuf.buf)))
                            (setq peer-address  (ot-parse-inetaddress addr))
                            (setf (ot-conn-peer-address conn) peer-address)))
                        (format stream " ~a <- ~a" (tcp-service-name local-port) (tcp-addr-to-str (cadr peer-address))))
                      (destructuring-bind (peer-ip peer-port) (cdr peer-address)
                        (format stream " ->~a:~a" (tcp-addr-to-str peer-ip) (tcp-service-name peer-port))))))))))))))


(defun ot-conn-tcp-addresses (conn)
  (let* ((local-address (ot-conn-local-address conn))
         (peer-address (ot-conn-peer-address conn)))
    (if (and (null peer-address)
             (ot-conn-passive-p conn))
      (with-macptrs ((addr (pref (pref (ot-conn-call conn) :tcall.addr) :tnetbuf.buf)))
        (setq peer-address  (ot-parse-inetaddress addr))
        (setf (ot-conn-peer-address conn) peer-address)))
    (values (cadr local-address)  ; local host
            (caddr local-address) ; local port
            (cadr peer-address)   ; remote host
            (caddr peer-address)))) ; remote port

(defmethod stream-local-host ((s opentransport-tcp-stream))
  (let ((io-buffer (stream-io-buffer s nil)))
    (and io-buffer
         (nth-value 0 (ot-conn-tcp-addresses io-buffer)))))

(defmethod stream-local-port ((s opentransport-tcp-stream))
  (let ((io-buffer (stream-io-buffer s nil)))
    (and io-buffer
         (nth-value 1 (ot-conn-tcp-addresses io-buffer)))))

(defmethod stream-remote-host ((s opentransport-tcp-stream))
  (let ((io-buffer (stream-io-buffer s nil)))
    (and io-buffer
         (nth-value 2 (ot-conn-tcp-addresses io-buffer)))))

(defmethod stream-remote-port ((s opentransport-tcp-stream))
  (let ((io-buffer (stream-io-buffer s nil)))
    (and io-buffer
         (nth-value 3 (ot-conn-tcp-addresses io-buffer)))))


;;Useful little functions: read & write CRLF-terminated lines from a "clear text" 
;; connection.
(defun telnet-read-line (stream)
  "Read a CRLF-terminated line"
  (unless (stream-eofp stream)
    (let ((line (Make-Array 10 :Element-Type 'base-Character :Adjustable T :Fill-Pointer 0))
          (char nil))
      (do () ((or (null (setq char (stream-tyi stream)))
                  (and (eq char #\CR) (eq (stream-peek stream) #\LF)))
              (when char (stream-tyi stream))
              (values line (null char)))
        (vector-push-extend char line)))))

; The mactcp states are:
; #(:closed :listen :syn-received :syn-sent :established :fin-wait-1
;   :fin-wait-2 :close-wait :closing :closing-last-ack :closing-time-ack)
; endpoint-states are :uninit :unbnd :idle :outcon :incon :dataxfer :outrel :inrel 

#+mactcp-compatibility
(defmethod stream-connection-state-name ((stream opentransport-tcp-stream))
  ; I have no idea if these are right -Bill
  (let* ((plist '(:closed :closed
                  :uninit :reset ;:uninit
                  :unbnd  :closed ;:unbnd
                  :idle :idle     ; mactcp doesn't have :idle?
                  :outcon :syn-sent
                  :incon :listen
                  :dataxfer :established
                  :outrel :closing
                  :inrel :closing))
         (conn (stream-io-buffer stream nil)))
    (cond ((null conn) :closed)
          ((null (ot-conn-endpoint conn)) :idle)
          ((logbitp ot-flag-incoming-connection-allowed-bit
                    (pref (ot-conn-context conn) :ot-context.flags))
           :listen)
          (t (let ((state (ot-conn-get-endpoint-state conn)))
               (getf plist state :unknown))))))

(defmethod opentransport-stream-connection-state ((stream opentransport-tcp-stream))
  (let ((conn (stream-io-buffer stream nil)))
    (if (and conn (not (%ot-conn-closed-p conn)))
      (ot-conn-get-endpoint-state conn)
      :closed)))

(defun telnet-write-line (stream string &rest args)
  "Write a CRLF-terminated line"
  (declare (dynamic-extent args))
  (apply #'format stream string args)
  (write-char #\CR stream)
  (write-char #\LF stream)
  (force-output stream))


(defun opentransport-cleanup () 
  (do* ()
       ((null *open-opentransport-streams*))
    (close (pop *open-opentransport-streams*)))
  ; Close any freelisted endpoints.
  (do* ()
       ((null *opentransport-class-endpoint-freelists*))
    (let* ((cell (pop *opentransport-class-endpoint-freelists*)))
      (dolist (ep (cdr cell))
        (#_OTCloseProvider ep))))
  (do* ()
       ((null *opentransport-class-proxies*))
    (let* ((proxy-context (cdr (pop *opentransport-class-proxies*))))
      (with-macptrs ((ep (pref proxy-context :ot-context.ref)))
        (ot-free-endpoint ep proxy-context nil))))
  (do* ()
       ((null *opentransport-config-alist*))
    (#_OTDestroyConfiguration (cdr (pop *opentransport-config-alist*))))
  (setq *opentransport-initialized* nil)
  #+carbon-compat
  (when *opentransport-notifier*
    (#_DisposeOTNotifyUPP *opentransport-notifier*))
  (setq *opentransport-notifier* nil))

(pushnew #'opentransport-cleanup *lisp-cleanup-functions* :key #'function-name :test #'eq) 

;; ??
#+ignore ;; evil
(when (boundp '*sleep-wakeup-functions*)
  (pushnew 'opentransport-cleanup *sleep-wakeup-functions*))

(provide "OPENTRANSPORT")



#|
(let* ((s (open-tcp-stream "fakir.gse.com" "smtp")))
   (format t "~&~s" (telnet-read-line s))
   (telnet-write-line s "HELO")
   (format t "~&~s" (telnet-read-line s))
   (telnet-write-line s "QUIT")
   (format t "~&~s" (telnet-read-line s))
   (close s))

(let* ((s (open-tcp-stream "digitool.com" "FTP")))
   (format t "~&~s" (telnet-read-line s))
   (close s))

|#
