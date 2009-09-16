(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Collections.h"
; at Sunday July 2,2006 7:23:12 pm.
; 
;      File:       CarbonCore/Collections.h
;  
;      Contains:   Collection Manager Interfaces
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1989-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __COLLECTIONS__
; #define __COLLECTIONS__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__

(require-interface "CarbonCore/MixedMode")

; #endif


(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; ***********
;  Constants 
; ***********
;  Convenience constants for functions which optionally return values 

(defconstant $kCollectionDontWantTag 0)
(defconstant $kCollectionDontWantId 0)
(defconstant $kCollectionDontWantSize 0)
(defconstant $kCollectionDontWantAttributes 0)
(defconstant $kCollectionDontWantIndex 0)
(defconstant $kCollectionDontWantData 0)
;  attributes bits 

(defconstant $kCollectionNoAttributes 0)        ;  no attributes bits set 

(defconstant $kCollectionAllAttributes #xFFFFFFFF);  all attributes bits set 

(defconstant $kCollectionUserAttributes #xFFFF) ;  user attributes bits 

(defconstant $kCollectionDefaultAttributes #x40000000);  default attributes - unlocked, persistent 

;  
;     Attribute bits 0 through 15 (entire low word) are reserved for use by the application.
;     Attribute bits 16 through 31 (entire high word) are reserved for use by the Collection Manager.
;     Only bits 31 (kCollectionLockBit) and 30 (kCollectionPersistenceBit) currently have meaning.
; 

(defconstant $kCollectionUser0Bit 0)
(defconstant $kCollectionUser1Bit 1)
(defconstant $kCollectionUser2Bit 2)
(defconstant $kCollectionUser3Bit 3)
(defconstant $kCollectionUser4Bit 4)
(defconstant $kCollectionUser5Bit 5)
(defconstant $kCollectionUser6Bit 6)
(defconstant $kCollectionUser7Bit 7)
(defconstant $kCollectionUser8Bit 8)
(defconstant $kCollectionUser9Bit 9)
(defconstant $kCollectionUser10Bit 10)
(defconstant $kCollectionUser11Bit 11)
(defconstant $kCollectionUser12Bit 12)
(defconstant $kCollectionUser13Bit 13)
(defconstant $kCollectionUser14Bit 14)
(defconstant $kCollectionUser15Bit 15)
(defconstant $kCollectionReserved0Bit 16)
(defconstant $kCollectionReserved1Bit 17)
(defconstant $kCollectionReserved2Bit 18)
(defconstant $kCollectionReserved3Bit 19)
(defconstant $kCollectionReserved4Bit 20)
(defconstant $kCollectionReserved5Bit 21)
(defconstant $kCollectionReserved6Bit 22)
(defconstant $kCollectionReserved7Bit 23)
(defconstant $kCollectionReserved8Bit 24)
(defconstant $kCollectionReserved9Bit 25)
(defconstant $kCollectionReserved10Bit 26)
(defconstant $kCollectionReserved11Bit 27)
(defconstant $kCollectionReserved12Bit 28)
(defconstant $kCollectionReserved13Bit 29)
(defconstant $kCollectionPersistenceBit 30)
(defconstant $kCollectionLockBit 31)
;  attribute masks 

(defconstant $kCollectionUser0Mask 1)
(defconstant $kCollectionUser1Mask 2)
(defconstant $kCollectionUser2Mask 4)
(defconstant $kCollectionUser3Mask 8)
(defconstant $kCollectionUser4Mask 16)
(defconstant $kCollectionUser5Mask 32)
(defconstant $kCollectionUser6Mask 64)
(defconstant $kCollectionUser7Mask #x80)
(defconstant $kCollectionUser8Mask #x100)
(defconstant $kCollectionUser9Mask #x200)
(defconstant $kCollectionUser10Mask #x400)
(defconstant $kCollectionUser11Mask #x800)
(defconstant $kCollectionUser12Mask #x1000)
(defconstant $kCollectionUser13Mask #x2000)
(defconstant $kCollectionUser14Mask #x4000)
(defconstant $kCollectionUser15Mask #x8000)
(defconstant $kCollectionReserved0Mask #x10000)
(defconstant $kCollectionReserved1Mask #x20000)
(defconstant $kCollectionReserved2Mask #x40000)
(defconstant $kCollectionReserved3Mask #x80000)
(defconstant $kCollectionReserved4Mask #x100000)
(defconstant $kCollectionReserved5Mask #x200000)
(defconstant $kCollectionReserved6Mask #x400000)
(defconstant $kCollectionReserved7Mask #x800000)
(defconstant $kCollectionReserved8Mask #x1000000)
(defconstant $kCollectionReserved9Mask #x2000000)
(defconstant $kCollectionReserved10Mask #x4000000)
(defconstant $kCollectionReserved11Mask #x8000000)
(defconstant $kCollectionReserved12Mask #x10000000)
(defconstant $kCollectionReserved13Mask #x20000000)
(defconstant $kCollectionPersistenceMask #x40000000)
(defconstant $kCollectionLockMask #x80000000)
; *********
;  Types   
; *********
;  abstract data type for a collection 

(def-mactype :Collection (find-mactype '(:pointer :OpaqueCollection)))
;  collection member 4 byte tag 

(def-mactype :CollectionTag (find-mactype ':FourCharCode))

(def-mactype :CollectionFlattenProcPtr (find-mactype ':pointer)); (SInt32 size , void * data , void * refCon)

(def-mactype :CollectionExceptionProcPtr (find-mactype ':pointer)); (Collection c , OSErr status)

(def-mactype :CollectionFlattenUPP (find-mactype '(:pointer :OpaqueCollectionFlattenProcPtr)))

(def-mactype :CollectionExceptionUPP (find-mactype '(:pointer :OpaqueCollectionExceptionProcPtr)))
; 
;  *  NewCollectionFlattenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCollectionFlattenUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCollectionFlattenProcPtr)
() )
; 
;  *  NewCollectionExceptionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCollectionExceptionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCollectionExceptionProcPtr)
() )
; 
;  *  DisposeCollectionFlattenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCollectionFlattenUPP" 
   ((userUPP (:pointer :OpaqueCollectionFlattenProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCollectionExceptionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCollectionExceptionUPP" 
   ((userUPP (:pointer :OpaqueCollectionExceptionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeCollectionFlattenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCollectionFlattenUPP" 
   ((size :SInt32)
    (data :pointer)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueCollectionFlattenProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeCollectionExceptionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCollectionExceptionUPP" 
   ((c (:pointer :OpaqueCollection))
    (status :SInt16)
    (userUPP (:pointer :OpaqueCollectionExceptionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; *******************************************
; ************ Public interfaces ************
; *******************************************
; 
;  *  NewCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_NewCollection" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCollection)
() )
; 
;  *  DisposeCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_DisposeCollection" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CloneCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_CloneCollection" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCollection)
() )
; 
;  *  CountCollectionOwners()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_CountCollectionOwners" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  RetainCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RetainCollection" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  ReleaseCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ReleaseCollection" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  GetCollectionRetainCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetCollectionRetainCount" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;  *  CopyCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_CopyCollection" 
   ((srcCollection (:pointer :OpaqueCollection))
    (dstCollection (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCollection)
() )
; 
;  *  GetCollectionDefaultAttributes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetCollectionDefaultAttributes" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetCollectionDefaultAttributes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_SetCollectionDefaultAttributes" 
   ((c (:pointer :OpaqueCollection))
    (whichAttributes :SInt32)
    (newAttributes :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CountCollectionItems()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_CountCollectionItems" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  AddCollectionItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_AddCollectionItem" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (id :SInt32)
    (itemSize :SInt32)
    (itemData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCollectionItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetCollectionItem" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (id :SInt32)
    (itemSize (:pointer :SInt32))
    (itemData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveCollectionItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_RemoveCollectionItem" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (id :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCollectionItemInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_SetCollectionItemInfo" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (id :SInt32)
    (whichAttributes :SInt32)
    (newAttributes :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCollectionItemInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetCollectionItemInfo" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (id :SInt32)
    (index (:pointer :SInt32))
    (itemSize (:pointer :SInt32))
    (attributes (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ReplaceIndexedCollectionItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_ReplaceIndexedCollectionItem" 
   ((c (:pointer :OpaqueCollection))
    (index :SInt32)
    (itemSize :SInt32)
    (itemData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIndexedCollectionItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetIndexedCollectionItem" 
   ((c (:pointer :OpaqueCollection))
    (index :SInt32)
    (itemSize (:pointer :SInt32))
    (itemData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveIndexedCollectionItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_RemoveIndexedCollectionItem" 
   ((c (:pointer :OpaqueCollection))
    (index :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetIndexedCollectionItemInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_SetIndexedCollectionItemInfo" 
   ((c (:pointer :OpaqueCollection))
    (index :SInt32)
    (whichAttributes :SInt32)
    (newAttributes :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIndexedCollectionItemInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetIndexedCollectionItemInfo" 
   ((c (:pointer :OpaqueCollection))
    (index :SInt32)
    (tag (:pointer :COLLECTIONTAG))
    (id (:pointer :SInt32))
    (itemSize (:pointer :SInt32))
    (attributes (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CollectionTagExists()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_CollectionTagExists" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  CountCollectionTags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_CountCollectionTags" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetIndexedCollectionTag()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetIndexedCollectionTag" 
   ((c (:pointer :OpaqueCollection))
    (tagIndex :SInt32)
    (tag (:pointer :COLLECTIONTAG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CountTaggedCollectionItems()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_CountTaggedCollectionItems" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetTaggedCollectionItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetTaggedCollectionItem" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (whichItem :SInt32)
    (itemSize (:pointer :SInt32))
    (itemData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetTaggedCollectionItemInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetTaggedCollectionItemInfo" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (whichItem :SInt32)
    (id (:pointer :SInt32))
    (index (:pointer :SInt32))
    (itemSize (:pointer :SInt32))
    (attributes (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PurgeCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_PurgeCollection" 
   ((c (:pointer :OpaqueCollection))
    (whichAttributes :SInt32)
    (matchingAttributes :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PurgeCollectionTag()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_PurgeCollectionTag" 
   ((c (:pointer :OpaqueCollection))
    (tag :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EmptyCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_EmptyCollection" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FlattenCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_FlattenCollection" 
   ((c (:pointer :OpaqueCollection))
    (flattenProc (:pointer :OpaqueCollectionFlattenProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FlattenPartialCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_FlattenPartialCollection" 
   ((c (:pointer :OpaqueCollection))
    (flattenProc (:pointer :OpaqueCollectionFlattenProcPtr))
    (refCon :pointer)
    (whichAttributes :SInt32)
    (matchingAttributes :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UnflattenCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_UnflattenCollection" 
   ((c (:pointer :OpaqueCollection))
    (flattenProc (:pointer :OpaqueCollectionFlattenProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCollectionExceptionProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetCollectionExceptionProc" 
   ((c (:pointer :OpaqueCollection))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCollectionExceptionProcPtr)
() )
; 
;  *  SetCollectionExceptionProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_SetCollectionExceptionProc" 
   ((c (:pointer :OpaqueCollection))
    (exceptionProc (:pointer :OpaqueCollectionExceptionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetNewCollection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetNewCollection" 
   ((collectionID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCollection)
() )
; ********************************************************************
; ************* Utility routines for handle-based access *************
; ********************************************************************
; 
;  *  AddCollectionItemHdl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_AddCollectionItemHdl" 
   ((aCollection (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (id :SInt32)
    (itemData :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetCollectionItemHdl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetCollectionItemHdl" 
   ((aCollection (:pointer :OpaqueCollection))
    (tag :FourCharCode)
    (id :SInt32)
    (itemData :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ReplaceIndexedCollectionItemHdl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_ReplaceIndexedCollectionItemHdl" 
   ((aCollection (:pointer :OpaqueCollection))
    (index :SInt32)
    (itemData :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIndexedCollectionItemHdl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_GetIndexedCollectionItemHdl" 
   ((aCollection (:pointer :OpaqueCollection))
    (index :SInt32)
    (itemData :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FlattenCollectionToHdl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_FlattenCollectionToHdl" 
   ((aCollection (:pointer :OpaqueCollection))
    (flattened :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UnflattenCollectionFromHdl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CollectionsLib 1.0 and later
;  

(deftrap-inline "_UnflattenCollectionFromHdl" 
   ((aCollection (:pointer :OpaqueCollection))
    (flattened :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

; #if OLDROUTINENAMES
#| 
(defconstant $dontWantTag 0)
(defconstant $dontWantId 0)
(defconstant $dontWantSize 0)
(defconstant $dontWantAttributes 0)
(defconstant $dontWantIndex 0)
(defconstant $dontWantData 0)

(defconstant $noCollectionAttributes 0)
(defconstant $allCollectionAttributes #xFFFFFFFF)
(defconstant $userCollectionAttributes #xFFFF)
(defconstant $defaultCollectionAttributes #x40000000)

(defconstant $collectionUser0Bit 0)
(defconstant $collectionUser1Bit 1)
(defconstant $collectionUser2Bit 2)
(defconstant $collectionUser3Bit 3)
(defconstant $collectionUser4Bit 4)
(defconstant $collectionUser5Bit 5)
(defconstant $collectionUser6Bit 6)
(defconstant $collectionUser7Bit 7)
(defconstant $collectionUser8Bit 8)
(defconstant $collectionUser9Bit 9)
(defconstant $collectionUser10Bit 10)
(defconstant $collectionUser11Bit 11)
(defconstant $collectionUser12Bit 12)
(defconstant $collectionUser13Bit 13)
(defconstant $collectionUser14Bit 14)
(defconstant $collectionUser15Bit 15)
(defconstant $collectionReserved0Bit 16)
(defconstant $collectionReserved1Bit 17)
(defconstant $collectionReserved2Bit 18)
(defconstant $collectionReserved3Bit 19)
(defconstant $collectionReserved4Bit 20)
(defconstant $collectionReserved5Bit 21)
(defconstant $collectionReserved6Bit 22)
(defconstant $collectionReserved7Bit 23)
(defconstant $collectionReserved8Bit 24)
(defconstant $collectionReserved9Bit 25)
(defconstant $collectionReserved10Bit 26)
(defconstant $collectionReserved11Bit 27)
(defconstant $collectionReserved12Bit 28)
(defconstant $collectionReserved13Bit 29)
(defconstant $collectionPersistenceBit 30)
(defconstant $collectionLockBit 31)

(defconstant $collectionUser0Mask 1)
(defconstant $collectionUser1Mask 2)
(defconstant $collectionUser2Mask 4)
(defconstant $collectionUser3Mask 8)
(defconstant $collectionUser4Mask 16)
(defconstant $collectionUser5Mask 32)
(defconstant $collectionUser6Mask 64)
(defconstant $collectionUser7Mask #x80)
(defconstant $collectionUser8Mask #x100)
(defconstant $collectionUser9Mask #x200)
(defconstant $collectionUser10Mask #x400)
(defconstant $collectionUser11Mask #x800)
(defconstant $collectionUser12Mask #x1000)
(defconstant $collectionUser13Mask #x2000)
(defconstant $collectionUser14Mask #x4000)
(defconstant $collectionUser15Mask #x8000)
(defconstant $collectionReserved0Mask #x10000)
(defconstant $collectionReserved1Mask #x20000)
(defconstant $collectionReserved2Mask #x40000)
(defconstant $collectionReserved3Mask #x80000)
(defconstant $collectionReserved4Mask #x100000)
(defconstant $collectionReserved5Mask #x200000)
(defconstant $collectionReserved6Mask #x400000)
(defconstant $collectionReserved7Mask #x800000)
(defconstant $collectionReserved8Mask #x1000000)
(defconstant $collectionReserved9Mask #x2000000)
(defconstant $collectionReserved10Mask #x4000000)
(defconstant $collectionReserved11Mask #x8000000)
(defconstant $collectionReserved12Mask #x10000000)
(defconstant $collectionReserved13Mask #x20000000)
(defconstant $collectionPersistenceMask #x40000000)
(defconstant $collectionLockMask #x80000000)
 |#

; #endif  /* OLDROUTINENAMES */

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __COLLECTIONS__ */


(provide-interface "Collections")