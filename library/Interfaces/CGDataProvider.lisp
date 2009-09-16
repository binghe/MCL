(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGDataProvider.h"
; at Sunday July 2,2006 7:23:50 pm.
;  CoreGraphics - CGDataProvider.h
;  * Copyright (c) 1999-2000 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGDATAPROVIDER_H_
; #define CGDATAPROVIDER_H_

(def-mactype :CGDataProviderRef (find-mactype '(:pointer :CGDataProvider)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreFoundation/CFURL")

(require-interface "stddef")
;  This callback is called to copy `count' bytes from the sequential data
;  * stream to `buffer'. 

(def-mactype :CGDataProviderGetBytesCallback (find-mactype ':pointer)); (void * info , void * buffer , size_t count)
;  This callback is called to skip `count' bytes forward in the sequential
;  * data stream. 

(def-mactype :CGDataProviderSkipBytesCallback (find-mactype ':pointer)); (void * info , size_t count)
;  This callback is called to rewind to the beginning of sequential data
;  * stream. 

(def-mactype :CGDataProviderRewindCallback (find-mactype ':pointer)); (void * info)
;  This callback is called to release the `info' pointer when the data
;  * provider is freed. 

(def-mactype :CGDataProviderReleaseInfoCallback (find-mactype ':pointer)); (void * info)
;  Callbacks for sequentially accessing data.
;  * `getBytes' is called to copy `count' bytes from the sequential data
;  *   stream to `buffer'.  It should return the number of bytes copied, or 0
;  *   if there's no more data.
;  * `skipBytes' is called to skip ahead in the sequential data stream by
;  *   `count' bytes.
;  * `rewind' is called to rewind the sequential data stream to the beginning
;  *   of the data.
;  * `releaseProvider', if non-NULL, is called to release the `info' pointer
;  *   when the provider is freed. 
(defrecord CGDataProviderCallbacks
   (getBytes :pointer)
   (skipBytes :pointer)
   (rewind :pointer)
   (releaseProvider :pointer)
)

;type name? (%define-record :CGDataProviderCallbacks (find-record-descriptor ':CGDataProviderCallbacks))
;  This callback is called to get a pointer to the entire block of data. 

(def-mactype :CGDataProviderGetBytePointerCallback (find-mactype ':pointer)); (void * info)
;  This callback is called to release the pointer to entire block of
;  * data. 

(def-mactype :CGDataProviderReleaseBytePointerCallback (find-mactype ':pointer)); (void * info , const void * pointer)
;  This callback is called to copy `count' bytes at byte offset `offset'
;  * into `buffer'. 

(def-mactype :CGDataProviderGetBytesAtOffsetCallback (find-mactype ':pointer)); (void * info , void * buffer , size_t offset , size_t count)
;  Callbacks for directly accessing data.
;  * `getBytePointer', if non-NULL, is called to return a pointer to the
;  *   provider's entire block of data.
;  * `releaseBytePointer', if non-NULL, is called to release a pointer to
;  *   the provider's entire block of data.
;  * `getBytes', if non-NULL, is called to copy `count' bytes at offset
;  * `offset' from the provider's data to `buffer'.  It should return the
;  *   number of bytes copied, or 0 if there's no more data.
;  * `releaseProvider', if non-NULL, is called when the provider is freed.
;  *
;  * At least one of `getBytePointer' or `getBytes' must be non-NULL.  
(defrecord CGDataProviderDirectAccessCallbacks
   (getBytePointer :pointer)
   (releaseBytePointer :pointer)
   (getBytes :pointer)
   (releaseProvider :pointer)
)

;type name? (%define-record :CGDataProviderDirectAccessCallbacks (find-record-descriptor ':CGDataProviderDirectAccessCallbacks))
;  Return the CFTypeID for CGDataProviderRefs. 

(deftrap-inline "_CGDataProviderGetTypeID" 
   (
   )
   :UInt32
() )
;  Create a sequential-access data provider using `callbacks' to provide
;  * the data.  `info' is passed to each of the callback functions. 

(deftrap-inline "_CGDataProviderCreate" 
   ((info :pointer)
    (callbacks (:pointer :CGDataProviderCallbacks))
   )
   (:pointer :CGDataProvider)
() )
;  Create a direct-access data provider using `callbacks' to supply `size'
;  * bytes of data. `info' is passed to each of the callback functions. 

(deftrap-inline "_CGDataProviderCreateDirectAccess" 
   ((info :pointer)
    (size :unsigned-long)
    (callbacks (:pointer :CGDataProviderDirectAccessCallbacks))
   )
   (:pointer :CGDataProvider)
() )
;  Create a direct-access data provider using `data', an array of `size'
;  * bytes.  `releaseData' is called when the data provider is freed, and is
;  * passed `info' as its first argument. 

(deftrap-inline "_CGDataProviderCreateWithData" 
   ((info :pointer)
    (data :pointer)
    (size :unsigned-long)
    (releaseData (:pointer :callback))          ;(void (void * info , const void * data , size_t size))

   )
   (:pointer :CGDataProvider)
() )
;  Create a data provider using `url'. 

(deftrap-inline "_CGDataProviderCreateWithURL" 
   ((url (:pointer :__CFURL))
   )
   (:pointer :CGDataProvider)
() )
;  Equivalent to `CFRetain(provider)'. 

(deftrap-inline "_CGDataProviderRetain" 
   ((provider (:pointer :CGDataProvider))
   )
   (:pointer :CGDataProvider)
() )
;  Equivalent to `CFRelease(provider)'. 

(deftrap-inline "_CGDataProviderRelease" 
   ((provider (:pointer :CGDataProvider))
   )
   nil
() )
; * DEPRECATED FUNCTIONS *
;  Don't use this function; use CFDataProviderCreateWithURL instead. 

(deftrap-inline "_CGDataProviderCreateWithFilename" 
   ((filename (:pointer :char))
   )
   (:pointer :CGDataProvider)
() )

; #endif	/* CGDATAPROVIDER_H_ */


(provide-interface "CGDataProvider")