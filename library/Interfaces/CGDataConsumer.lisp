(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CGDataConsumer.h"
; at Sunday July 2,2006 7:23:58 pm.
;  CoreGraphics - CGDataConsumer.h
;  * Copyright (c) 1999-2000 Apple Computer, Inc.
;  * All rights reserved.
;  
; #ifndef CGDATACONSUMER_H_
; #define CGDATACONSUMER_H_

(def-mactype :CGDataConsumerRef (find-mactype '(:pointer :CGDataConsumer)))

(require-interface "CoreGraphics/CGBase")

(require-interface "CoreFoundation/CFURL")

(require-interface "stddef")
;  Callbacks for accessing data.
;  * `putBytes' copies `count' bytes from `buffer' to the consumer, and
;  * returns the number of bytes copied.  It should return 0 if no more data
;  * can be written to the consumer.
;  * `releaseConsumer', if non-NULL, is called when the consumer is freed. 
(defrecord CGDataConsumerCallbacks
   (putBytes (:pointer :callback))              ;(size_t (void * info , const void * buffer , size_t count))
   (releaseConsumer (:pointer :callback))       ;(void (void * info))
)

;type name? (%define-record :CGDataConsumerCallbacks (find-record-descriptor ':CGDataConsumerCallbacks))
;  Return the CFTypeID for CGDataConsumerRefs. 

(deftrap-inline "_CGDataConsumerGetTypeID" 
   (
   )
   :UInt32
() )
;  Create a data consumer using `callbacks' to handle the data.  `info' is
;  * passed to each of the callback functions. 

(deftrap-inline "_CGDataConsumerCreate" 
   ((info :pointer)
    (callbacks (:pointer :CGDataConsumerCallbacks))
   )
   (:pointer :CGDataConsumer)
() )
;  Create a data consumer which writes data to `url'. 

(deftrap-inline "_CGDataConsumerCreateWithURL" 
   ((url (:pointer :__CFURL))
   )
   (:pointer :CGDataConsumer)
() )
;  Equivalent to `CFRetain(consumer)'. 

(deftrap-inline "_CGDataConsumerRetain" 
   ((consumer (:pointer :CGDataConsumer))
   )
   (:pointer :CGDataConsumer)
() )
;  Equivalent to `CFRelease(consumer)'. 

(deftrap-inline "_CGDataConsumerRelease" 
   ((consumer (:pointer :CGDataConsumer))
   )
   nil
() )

; #endif	/* CGDATACONSUMER_H_ */


(provide-interface "CGDataConsumer")