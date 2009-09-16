(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSMapTable.h"
; at Sunday July 2,2006 7:30:51 pm.
; 	NSMapTable.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSString.h>

; #import <Foundation/NSArray.h>
; ***************	Data structure	***************

(def-mactype :NSMapTable (find-mactype ':_NSMapTable))
(defrecord NSMapTableKeyCallBacks
   (hash (:pointer :callback))                  ;(UInt32 (NSMapTable * table , const void *))
   (isEqual (:pointer :callback))               ;(BOOL (NSMapTable * table , const void * , const void *))
   (retain (:pointer :callback))                ;(void (NSMapTable * table , const void *))
   (release (:pointer :callback))               ;(void (NSMapTable * table , void *))
   (describe (:pointer :callback))              ;(NSString * (NSMapTable * table , const void *))
   (notAKeyMarker :pointer)
)
; #define NSNotAnIntMapKey	((const void *)0x80000000)
; #define NSNotAPointerMapKey	((const void *)0xffffffff)
(defrecord NSMapTableValueCallBacks
   (retain (:pointer :callback))                ;(void (NSMapTable * table , const void *))
   (release (:pointer :callback))               ;(void (NSMapTable * table , void *))
   (describe (:pointer :callback))              ;(NSString * (NSMapTable * table , const void *))
)
(defrecord NSMapEnumerator
   (_pi :UInt32)
   (_si :UInt32)
   (_bs :pointer)
)
; ***************	Map table operations	***************

(deftrap-inline "_NSCreateMapTableWithZone" 
   ((keyCallBacks (:pointer :NSMAPTABLEKEYCALLBACKS))
    (valueCallBacks (:pointer :NSMAPTABLEVALUECALLBACKS))
    (capacity :UInt32)
    (zone (:pointer :nszone))
   )
   (:pointer :NSMAPTABLE)
() )

(deftrap-inline "_NSCreateMapTable" 
   ((keyCallBacks (:pointer :NSMAPTABLEKEYCALLBACKS))
    (valueCallBacks (:pointer :NSMAPTABLEVALUECALLBACKS))
    (capacity :UInt32)
   )
   (:pointer :NSMAPTABLE)
() )

(deftrap-inline "_NSFreeMapTable" 
   ((table (:pointer :NSMAPTABLE))
   )
   nil
() )

(deftrap-inline "_NSResetMapTable" 
   ((table (:pointer :NSMAPTABLE))
   )
   nil
() )

(deftrap-inline "_NSCompareMapTables" 
   ((table1 (:pointer :NSMAPTABLE))
    (table2 (:pointer :NSMAPTABLE))
   )
   :Boolean
() )

(deftrap-inline "_NSCopyMapTableWithZone" 
   ((table (:pointer :NSMAPTABLE))
    (zone (:pointer :nszone))
   )
   (:pointer :NSMAPTABLE)
() )

(deftrap-inline "_NSMapMember" 
   ((table (:pointer :NSMAPTABLE))
    (key :pointer)
    (originalKey :pointer)
    (value :pointer)
   )
   :Boolean
() )

(deftrap-inline "_NSMapGet" 
   ((table (:pointer :NSMAPTABLE))
    (key :pointer)
   )
   (:pointer :void)
() )

(deftrap-inline "_NSMapInsert" 
   ((table (:pointer :NSMAPTABLE))
    (key :pointer)
    (value :pointer)
   )
   nil
() )

(deftrap-inline "_NSMapInsertKnownAbsent" 
   ((table (:pointer :NSMAPTABLE))
    (key :pointer)
    (value :pointer)
   )
   nil
() )

(deftrap-inline "_NSMapInsertIfAbsent" 
   ((table (:pointer :NSMAPTABLE))
    (key :pointer)
    (value :pointer)
   )
   (:pointer :void)
() )

(deftrap-inline "_NSMapRemove" 
   ((table (:pointer :NSMAPTABLE))
    (key :pointer)
   )
   nil
() )

(deftrap-inline "_NSEnumerateMapTable" 
   ((returnArg (:pointer :NSMAPENUMERATOR))
    (table (:pointer :NSMAPTABLE))
   )
   nil
() )

(deftrap-inline "_NSNextMapEnumeratorPair" 
   ((enumerator (:pointer :NSMAPENUMERATOR))
    (key :pointer)
    (value :pointer)
   )
   :Boolean
() )

(deftrap-inline "_NSEndMapTableEnumeration" 
   ((enumerator (:pointer :NSMAPENUMERATOR))
   )
   nil
() )

(deftrap-inline "_NSCountMapTable" 
   ((table (:pointer :NSMAPTABLE))
   )
   :UInt32
() )

(deftrap-inline "_NSStringFromMapTable" 
   ((table (:pointer :NSMAPTABLE))
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSAllMapTableKeys" 
   ((table (:pointer :NSMAPTABLE))
   )
   (:pointer :nsarray)
() )

(deftrap-inline "_NSAllMapTableValues" 
   ((table (:pointer :NSMAPTABLE))
   )
   (:pointer :nsarray)
() )
; ***************	Common map table key callbacks	***************
(%define-record :NSIntMapKeyCallBacks (find-record-descriptor ':NSMapTableKeyCallBacks))
(%define-record :NSNonOwnedPointerMapKeyCallBacks (find-record-descriptor ':NSMapTableKeyCallBacks))
(%define-record :NSNonOwnedPointerOrNullMapKeyCallBacks (find-record-descriptor ':NSMapTableKeyCallBacks))
(%define-record :NSNonRetainedObjectMapKeyCallBacks (find-record-descriptor ':NSMapTableKeyCallBacks))
(%define-record :NSObjectMapKeyCallBacks (find-record-descriptor ':NSMapTableKeyCallBacks))
(%define-record :NSOwnedPointerMapKeyCallBacks (find-record-descriptor ':NSMapTableKeyCallBacks))
; ***************	Common map table value callbacks	***************
(%define-record :NSIntMapValueCallBacks (find-record-descriptor ':NSMapTableValueCallBacks))
(%define-record :NSNonOwnedPointerMapValueCallBacks (find-record-descriptor ':NSMapTableValueCallBacks))
(%define-record :NSObjectMapValueCallBacks (find-record-descriptor ':NSMapTableValueCallBacks))
(%define-record :NSNonRetainedObjectMapValueCallBacks (find-record-descriptor ':NSMapTableValueCallBacks))
(%define-record :NSOwnedPointerMapValueCallBacks (find-record-descriptor ':NSMapTableValueCallBacks))

(provide-interface "NSMapTable")