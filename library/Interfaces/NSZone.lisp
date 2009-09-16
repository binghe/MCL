(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSZone.h"
; at Sunday July 2,2006 7:31:06 pm.
; 	NSZone.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObjCRuntime.h>

(def-mactype :NSZone (find-mactype ':_NSZone))

(deftrap-inline "_NSDefaultMallocZone" 
   (
   )
   (:pointer :NSZONE)
() )

(deftrap-inline "_NSCreateZone" 
   ((startSize :UInt32)
    (granularity :UInt32)
    (canFree :Boolean)
   )
   (:pointer :NSZONE)
() )

(deftrap-inline "_NSRecycleZone" 
   ((zone (:pointer :NSZONE))
   )
   nil
() )

(deftrap-inline "_NSSetZoneName" 
   ((zone (:pointer :NSZONE))
    (name (:pointer :NSString))
   )
   nil
() )

(deftrap-inline "_NSZoneName" 
   ((zone (:pointer :NSZONE))
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSZoneFromPointer" 
   ((ptr :pointer)
   )
   (:pointer :NSZONE)
() )

(deftrap-inline "_NSZoneMalloc" 
   ((zone (:pointer :NSZONE))
    (size :UInt32)
   )
   (:pointer :void)
() )

(deftrap-inline "_NSZoneCalloc" 
   ((zone (:pointer :NSZONE))
    (numElems :UInt32)
    (byteSize :UInt32)
   )
   (:pointer :void)
() )

(deftrap-inline "_NSZoneRealloc" 
   ((zone (:pointer :NSZONE))
    (ptr :pointer)
    (size :UInt32)
   )
   (:pointer :void)
() )

(deftrap-inline "_NSZoneFree" 
   ((zone (:pointer :NSZONE))
    (ptr :pointer)
   )
   nil
() )

(deftrap-inline "_NSPageSize" 
   (
   )
   :UInt32
() )

(deftrap-inline "_NSLogPageSize" 
   (
   )
   :UInt32
() )

(deftrap-inline "_NSRoundUpToMultipleOfPageSize" 
   ((bytes :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_NSRoundDownToMultipleOfPageSize" 
   ((bytes :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_NSAllocateMemoryPages" 
   ((bytes :UInt32)
   )
   (:pointer :void)
() )

(deftrap-inline "_NSDeallocateMemoryPages" 
   ((ptr :pointer)
    (bytes :UInt32)
   )
   nil
() )

(deftrap-inline "_NSCopyMemoryPages" 
   ((source :pointer)
    (dest :pointer)
    (bytes :UInt32)
   )
   nil
() )

(deftrap-inline "_NSRealMemoryAvailable" 
   (
   )
   :UInt32
() )

(provide-interface "NSZone")