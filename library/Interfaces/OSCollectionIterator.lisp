(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OSCollectionIterator.h"
; at Sunday July 2,2006 7:28:36 pm.
;  fake summary of /c++/OSCollectionIterator.h  
(defrecord OSCollectionIterator
   (collection (:pointer :oscollection))
   (collIterator :pointer)
   (initialUpdateStamp :UInt32)
   (valid :Boolean)
)

(provide-interface "OSCollectionIterator")