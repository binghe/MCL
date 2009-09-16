(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFStream.h"
; at Sunday July 2,2006 7:22:50 pm.
; 	CFStream.h
; 	Copyright (c) 2000-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFSTREAM__)
(defconstant $__COREFOUNDATION_CFSTREAM__ 1)
; #define __COREFOUNDATION_CFSTREAM__ 1

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFURL")

(require-interface "CoreFoundation/CFRunLoop")

(require-interface "CoreFoundation/CFSocket")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(defconstant $kCFStreamStatusNotOpen 0)
(defconstant $kCFStreamStatusOpening 1)         ;  open is in-progress 

(defconstant $kCFStreamStatusOpen 2)
(defconstant $kCFStreamStatusReading 3)
(defconstant $kCFStreamStatusWriting 4)
(defconstant $kCFStreamStatusAtEnd 5)           ;  no further bytes can be read/written 

(defconstant $kCFStreamStatusClosed 6)
(defconstant $kCFStreamStatusError 7)
(def-mactype :CFStreamStatus (find-mactype ':SINT32))

(defconstant $kCFStreamErrorDomainCustom -1)    ;  custom to the kind of stream in question 

(defconstant $kCFStreamErrorDomainPOSIX 1)      ;  POSIX errno; interpret using <sys/errno.h> 
;  OSStatus type from Carbon APIs; interpret using <MacTypes.h> 

(defconstant $kCFStreamErrorDomainMacOSStatus 2)
(def-mactype :CFStreamErrorDomain (find-mactype ':SINT32))
(defrecord CFStreamError
   (domain :SInt32)
   (error :SInt32)
)

(defconstant $kCFStreamEventNone 0)
(defconstant $kCFStreamEventOpenCompleted 1)
(defconstant $kCFStreamEventHasBytesAvailable 2)
(defconstant $kCFStreamEventCanAcceptBytes 4)
(defconstant $kCFStreamEventErrorOccurred 8)
(defconstant $kCFStreamEventEndEncountered 16)
(def-mactype :CFStreamEventType (find-mactype ':SINT32))
(defrecord CFStreamClientContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (void * info))
   (release (:pointer :callback))               ;(void (void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (void * info))
)

(def-mactype :CFReadStreamRef (find-mactype '(:pointer :__CFReadStream)))

(def-mactype :CFWriteStreamRef (find-mactype '(:pointer :__CFWriteStream)))

(def-mactype :CFReadStreamClientCallBack (find-mactype ':pointer)); (CFReadStreamRef stream , CFStreamEventType type , void * clientCallBackInfo)

(def-mactype :CFWriteStreamClientCallBack (find-mactype ':pointer)); (CFWriteStreamRef stream , CFStreamEventType type , void * clientCallBackInfo)

(deftrap-inline "_CFReadStreamGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFWriteStreamGetTypeID" 
   (
   )
   :UInt32
() )
;  Memory streams 
;  Value will be a CFData containing all bytes thusfar written; used to recover the data written to a memory write stream. 
(def-mactype :kCFStreamPropertyDataWritten (find-mactype ':CFStringRef))
;  Pass kCFAllocatorNull for bytesDeallocator to prevent CFReadStream from deallocating bytes; otherwise, CFReadStream will deallocate bytes when the stream is destroyed 

(deftrap-inline "_CFReadStreamCreateWithBytesNoCopy" 
   ((alloc (:pointer :__CFAllocator))
    (bytes (:pointer :UInt8))
    (length :SInt32)
    (bytesDeallocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFReadStream)
() )
;  The stream writes into the buffer given; when bufferCapacity is exhausted, the stream is exhausted (status becomes kCFStreamStatusAtEnd) 

(deftrap-inline "_CFWriteStreamCreateWithBuffer" 
   ((alloc (:pointer :__CFAllocator))
    (buffer (:pointer :UInt8))
    (bufferCapacity :SInt32)
   )
   (:pointer :__CFWriteStream)
() )
;  New buffers are allocated from bufferAllocator as bytes are written to the stream.  At any point, you can recover the bytes thusfar written by asking for the property kCFStreamPropertyDataWritten, above 

(deftrap-inline "_CFWriteStreamCreateWithAllocatedBuffers" 
   ((alloc (:pointer :__CFAllocator))
    (bufferAllocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFWriteStream)
() )
;  File streams 

(deftrap-inline "_CFReadStreamCreateWithFile" 
   ((alloc (:pointer :__CFAllocator))
    (fileURL (:pointer :__CFURL))
   )
   (:pointer :__CFReadStream)
() )

(deftrap-inline "_CFWriteStreamCreateWithFile" 
   ((alloc (:pointer :__CFAllocator))
    (fileURL (:pointer :__CFURL))
   )
   (:pointer :__CFWriteStream)
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  Property for file write streams; value should be a CFBoolean.  Set to TRUE to append to a file, rather than to replace its contents 
(def-mactype :kCFStreamPropertyAppendToFile (find-mactype ':CFStringRef))

; #endif


; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
(def-mactype :kCFStreamPropertyFileCurrentOffset (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Value is a CFNumber

; #endif

;  Socket stream properties 
;  Value will be a CFData containing the native handle 
(def-mactype :kCFStreamPropertySocketNativeHandle (find-mactype ':CFStringRef))
;  Value will be a CFString, or NULL if unknown 
(def-mactype :kCFStreamPropertySocketRemoteHostName (find-mactype ':CFStringRef))
;  Value will be a CFNumber, or NULL if unknown 
(def-mactype :kCFStreamPropertySocketRemotePortNumber (find-mactype ':CFStringRef))
;  Socket streams; the returned streams are paired such that they use the same socket; pass NULL if you want only the read stream or the write stream 

(deftrap-inline "_CFStreamCreatePairWithSocket" 
   ((alloc (:pointer :__CFAllocator))
    (sock :signed-long)
    (readStream (:pointer :CFREADSTREAMREF))
    (writeStream (:pointer :CFWRITESTREAMREF))
   )
   nil
() )

(deftrap-inline "_CFStreamCreatePairWithSocketToHost" 
   ((alloc (:pointer :__CFAllocator))
    (host (:pointer :__CFString))
    (port :UInt32)
    (readStream (:pointer :CFREADSTREAMREF))
    (writeStream (:pointer :CFWRITESTREAMREF))
   )
   nil
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

(deftrap-inline "_CFStreamCreatePairWithPeerSocketSignature" 
   ((alloc (:pointer :__CFAllocator))
    (signature (:pointer :CFSOCKETSIGNATURE))
    (readStream (:pointer :CFREADSTREAMREF))
    (writeStream (:pointer :CFWRITESTREAMREF))
   )
   nil
() )

; #endif

;  Returns the current state of the stream 

(deftrap-inline "_CFReadStreamGetStatus" 
   ((stream (:pointer :__CFReadStream))
   )
   :SInt32
() )

(deftrap-inline "_CFWriteStreamGetStatus" 
   ((stream (:pointer :__CFWriteStream))
   )
   :SInt32
() )
;  0 is returned if no error has occurred.  errorDomain specifies the domain
;    in which the error code should be interpretted; pass NULL if you are not 
;    interested. 

(deftrap-inline "_CFReadStreamGetError" 
   ((returnArg (:pointer :CFSTREAMERROR))
    (stream (:pointer :__CFReadStream))
   )
   nil
() )

(deftrap-inline "_CFWriteStreamGetError" 
   ((returnArg (:pointer :CFSTREAMERROR))
    (stream (:pointer :__CFWriteStream))
   )
   nil
() )
;  Returns success/failure.  Opening a stream causes it to reserve all the system
;    resources it requires.  If the stream can open non-blocking, this will always 
;    return TRUE; listen to the run loop source to find out when the open completes
;    and whether it was successful, or poll using CFRead/WriteStreamGetStatus(), waiting 
;    for a status of kCFStreamStatusOpen or kCFStreamStatusError.  

(deftrap-inline "_CFReadStreamOpen" 
   ((stream (:pointer :__CFReadStream))
   )
   :Boolean
() )

(deftrap-inline "_CFWriteStreamOpen" 
   ((stream (:pointer :__CFWriteStream))
   )
   :Boolean
() )
;  Terminates the flow of bytes; releases any system resources required by the 
;    stream.  The stream may not fail to close.  You may call CFStreamClose() to 
;    effectively abort a stream. 

(deftrap-inline "_CFReadStreamClose" 
   ((stream (:pointer :__CFReadStream))
   )
   nil
() )

(deftrap-inline "_CFWriteStreamClose" 
   ((stream (:pointer :__CFWriteStream))
   )
   nil
() )
;  Whether there is data currently available for reading; returns TRUE if it's 
;    impossible to tell without trying 

(deftrap-inline "_CFReadStreamHasBytesAvailable" 
   ((stream (:pointer :__CFReadStream))
   )
   :Boolean
() )
;  Returns the number of bytes read, or -1 if an error occurs preventing any 
;    bytes from being read, or 0 if the stream's end was encountered.  
;    It is an error to try and read from a stream that hasn't been opened first.  
;    This call will block until at least one byte is available; it will NOT block
;    until the entire buffer can be filled.  To avoid blocking, either poll using
;    CFReadStreamHasBytesAvailable() or use the run loop and listen for the 
;    kCFStreamCanRead event for notification of data available. 

(deftrap-inline "_CFReadStreamRead" 
   ((stream (:pointer :__CFReadStream))
    (buffer (:pointer :UInt8))
    (bufferLength :SInt32)
   )
   :SInt32
() )
;  Returns a pointer to an internal buffer if possible (setting *numBytesRead
;    to the length of the returned buffer), otherwise returns NULL; guaranteed 
;    to return in O(1).  Bytes returned in the buffer are considered read from 
;    the stream; if maxBytesToRead is greater than 0, not more than maxBytesToRead
;    will be returned.  If maxBytesToRead is less than or equal to zero, as many bytes
;    as are readily available will be returned.  The returned buffer is good only 
;    until the next stream operation called on the stream.  Caller should neither 
;    change the contents of the returned buffer nor attempt to deallocate the buffer;
;    it is still owned by the stream. 

(deftrap-inline "_CFReadStreamGetBuffer" 
   ((stream (:pointer :__CFReadStream))
    (maxBytesToRead :SInt32)
    (numBytesRead (:pointer :CFIndex))
   )
   (:pointer :UInt8)
() )
;  Whether the stream can currently be written to without blocking;
;    returns TRUE if it's impossible to tell without trying 

(deftrap-inline "_CFWriteStreamCanAcceptBytes" 
   ((stream (:pointer :__CFWriteStream))
   )
   :Boolean
() )
;  Returns the number of bytes successfully written, -1 if an error has
;    occurred, or 0 if the stream has been filled to capacity (for fixed-length
;    streams).  If the stream is not full, this call will block until at least
;    one byte is written.  To avoid blocking, either poll via CFWriteStreamCanAcceptBytes
;    or use the run loop and listen for the kCFStreamCanWrite event. 

(deftrap-inline "_CFWriteStreamWrite" 
   ((stream (:pointer :__CFWriteStream))
    (buffer (:pointer :UInt8))
    (bufferLength :SInt32)
   )
   :SInt32
() )
;  Particular streams can name properties and assign meanings to them; you
;    access these properties through the following calls.  A property is any interesting
;    information about the stream other than the data being transmitted itself.
;    Examples include the headers from an HTTP transmission, or the expected 
;    number of bytes, or permission information, etc.  Properties that can be set
;    configure the behavior of the stream, and may only be settable at particular times
;    (like before the stream has been opened).  See the documentation for particular 
;    properties to determine their get- and set-ability. 

(deftrap-inline "_CFReadStreamCopyProperty" 
   ((stream (:pointer :__CFReadStream))
    (propertyName (:pointer :__CFString))
   )
   (:pointer :void)
() )

(deftrap-inline "_CFWriteStreamCopyProperty" 
   ((stream (:pointer :__CFWriteStream))
    (propertyName (:pointer :__CFString))
   )
   (:pointer :void)
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  Returns TRUE if the stream recognizes and accepts the given property-value pair; 
;    FALSE otherwise. 

(deftrap-inline "_CFReadStreamSetProperty" 
   ((stream (:pointer :__CFReadStream))
    (propertyName (:pointer :__CFString))
    (propertyValue (:pointer :void))
   )
   :Boolean
() )

(deftrap-inline "_CFWriteStreamSetProperty" 
   ((stream (:pointer :__CFWriteStream))
    (propertyName (:pointer :__CFString))
    (propertyValue (:pointer :void))
   )
   :Boolean
() )

; #endif

;  Asynchronous processing - If you wish to neither poll nor block, you may register 
;    a client to hear about interesting events that occur on a stream.  Only one client
;    per stream is allowed; registering a new client replaces the previous one.
; 
;    Once you have set a client, you need to schedule a run loop on which that client
;    can be notified.  You may schedule multiple run loops (for instance, if you are 
;    using a thread pool).  The client callback will be triggered via one of the scheduled
;    run loops; It is the caller's responsibility to ensure that at least one of the 
;    scheduled run loops is being run.
; 
;    NOTE: not all streams provide these notifications.  If a stream does not support
;    asynchronous notification, CFStreamSetClient() will return NO; typically, such
;    streams will never block for device I/O (e.g. a stream on memory)
; 

(deftrap-inline "_CFReadStreamSetClient" 
   ((stream (:pointer :__CFReadStream))
    (streamEvents :UInt32)
    (clientCB :pointer)
    (clientContext (:pointer :CFSTREAMCLIENTCONTEXT))
   )
   :Boolean
() )

(deftrap-inline "_CFWriteStreamSetClient" 
   ((stream (:pointer :__CFWriteStream))
    (streamEvents :UInt32)
    (clientCB :pointer)
    (clientContext (:pointer :CFSTREAMCLIENTCONTEXT))
   )
   :Boolean
() )

(deftrap-inline "_CFReadStreamScheduleWithRunLoop" 
   ((stream (:pointer :__CFReadStream))
    (runLoop (:pointer :__CFRunLoop))
    (runLoopMode (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFWriteStreamScheduleWithRunLoop" 
   ((stream (:pointer :__CFWriteStream))
    (runLoop (:pointer :__CFRunLoop))
    (runLoopMode (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFReadStreamUnscheduleFromRunLoop" 
   ((stream (:pointer :__CFReadStream))
    (runLoop (:pointer :__CFRunLoop))
    (runLoopMode (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFWriteStreamUnscheduleFromRunLoop" 
   ((stream (:pointer :__CFWriteStream))
    (runLoop (:pointer :__CFRunLoop))
    (runLoopMode (:pointer :__CFString))
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFSTREAM__ */


(provide-interface "CFStream")