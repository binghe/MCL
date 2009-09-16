(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSHashTable.h"
; at Sunday July 2,2006 7:30:49 pm.
; 	NSHashTable.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSString.h>

; #import <Foundation/NSArray.h>
; ***************	Data structure	***************

(def-mactype :NSHashTable (find-mactype ':_NSHashTable))
(defrecord NSHashTableCallBacks
   (hash (:pointer :callback))                  ;(UInt32 (NSHashTable * table , const void *))
   (isEqual (:pointer :callback))               ;(BOOL (NSHashTable * table , const void * , const void *))
   (retain (:pointer :callback))                ;(void (NSHashTable * table , const void *))
   (release (:pointer :callback))               ;(void (NSHashTable * table , void *))
   (describe (:pointer :callback))              ;(NSString * (NSHashTable * table , const void *))
)
(defrecord NSHashEnumerator
   (_pi :UInt32)
   (_si :UInt32)
   (_bs :pointer)
)
; ***************	Hash table operations	***************

(deftrap-inline "_NSCreateHashTableWithZone" 
   ((callBacks (:pointer :NSHASHTABLECALLBACKS))
    (capacity :UInt32)
    (zone (:pointer :nszone))
   )
   (:pointer :NSHASHTABLE)
() )

(deftrap-inline "_NSCreateHashTable" 
   ((callBacks (:pointer :NSHASHTABLECALLBACKS))
    (capacity :UInt32)
   )
   (:pointer :NSHASHTABLE)
() )

(deftrap-inline "_NSFreeHashTable" 
   ((table (:pointer :NSHASHTABLE))
   )
   nil
() )

(deftrap-inline "_NSResetHashTable" 
   ((table (:pointer :NSHASHTABLE))
   )
   nil
() )

(deftrap-inline "_NSCompareHashTables" 
   ((table1 (:pointer :NSHASHTABLE))
    (table2 (:pointer :NSHASHTABLE))
   )
   :Boolean
() )

(deftrap-inline "_NSCopyHashTableWithZone" 
   ((table (:pointer :NSHASHTABLE))
    (zone (:pointer :nszone))
   )
   (:pointer :NSHASHTABLE)
() )

(deftrap-inline "_NSHashGet" 
   ((table (:pointer :NSHASHTABLE))
    (pointer :pointer)
   )
   (:pointer :void)
() )

(deftrap-inline "_NSHashInsert" 
   ((table (:pointer :NSHASHTABLE))
    (pointer :pointer)
   )
   nil
() )

(deftrap-inline "_NSHashInsertKnownAbsent" 
   ((table (:pointer :NSHASHTABLE))
    (pointer :pointer)
   )
   nil
() )

(deftrap-inline "_NSHashInsertIfAbsent" 
   ((table (:pointer :NSHASHTABLE))
    (pointer :pointer)
   )
   (:pointer :void)
() )

(deftrap-inline "_NSHashRemove" 
   ((table (:pointer :NSHASHTABLE))
    (pointer :pointer)
   )
   nil
() )

(deftrap-inline "_NSEnumerateHashTable" 
   ((returnArg (:pointer :NSHASHENUMERATOR))
    (table (:pointer :NSHASHTABLE))
   )
   nil
() )

(deftrap-inline "_NSNextHashEnumeratorItem" 
   ((enumerator (:pointer :NSHASHENUMERATOR))
   )
   (:pointer :void)
() )

(deftrap-inline "_NSEndHashTableEnumeration" 
   ((enumerator (:pointer :NSHASHENUMERATOR))
   )
   nil
() )

(deftrap-inline "_NSCountHashTable" 
   ((table (:pointer :NSHASHTABLE))
   )
   :UInt32
() )

(deftrap-inline "_NSStringFromHashTable" 
   ((table (:pointer :NSHASHTABLE))
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSAllHashTableObjects" 
   ((table (:pointer :NSHASHTABLE))
   )
   (:pointer :nsarray)
() )
; ***************	Common hash table callbacks	***************
(%define-record :NSIntHashCallBacks (find-record-descriptor ':NSHashTableCallBacks))
(%define-record :NSNonOwnedPointerHashCallBacks (find-record-descriptor ':NSHashTableCallBacks))
(%define-record :NSNonRetainedObjectHashCallBacks (find-record-descriptor ':NSHashTableCallBacks))
(%define-record :NSObjectHashCallBacks (find-record-descriptor ':NSHashTableCallBacks))
(%define-record :NSOwnedObjectIdentityHashCallBacks (find-record-descriptor ':NSHashTableCallBacks))
(%define-record :NSOwnedPointerHashCallBacks (find-record-descriptor ':NSHashTableCallBacks))
(%define-record :NSPointerToStructHashCallBacks (find-record-descriptor ':NSHashTableCallBacks))

(provide-interface "NSHashTable")