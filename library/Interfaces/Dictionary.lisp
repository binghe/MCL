(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Dictionary.h"
; at Sunday July 2,2006 7:24:44 pm.
; 
;      File:       LangAnalysis/Dictionary.h
;  
;      Contains:   Dictionary Manager Interfaces
;  
;      Version:    LanguageAnalysis-124~1
;  
;      Copyright:  © 1992-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __DICTIONARY__
; #define __DICTIONARY__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __AEREGISTRY__
#| #|
#include <AEAERegistry.h>
#endif
|#
 |#

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
; #pragma options align=power
; 
; =============================================================================================
;  Modern Dictionary Manager
; =============================================================================================
; 
; 
;     Dictionary information
; 

(defconstant $kDictionaryFileType :|dict|)
(defconstant $kDCMDictionaryHeaderSignature :|dict|)
(defconstant $kDCMDictionaryHeaderVersion 2)

(defconstant $kDCMAnyFieldTag :|****|)
(defconstant $kDCMAnyFieldType :|****|)
; 
;     Contents of a Field Info Record (an AERecord)
; 

(defconstant $keyDCMFieldTag :|ftag|)           ;  typeEnumeration 

(defconstant $keyDCMFieldType :|ftyp|)          ;  typeEnumeration 

(defconstant $keyDCMMaxRecordSize :|mrsz|)      ;  typeMagnitude 

(defconstant $keyDCMFieldAttributes :|fatr|)
(defconstant $keyDCMFieldDefaultData :|fdef|)
(defconstant $keyDCMFieldName :|fnam|)          ;  typeChar 

(defconstant $keyDCMFieldFindMethods :|ffnd|)   ;  typeAEList of typeDCMFindMethod 

; 
;     Special types for fields of a Field Info Record
; 

(defconstant $typeDCMFieldAttributes :|fatr|)
(defconstant $typeDCMFindMethod :|fmth|)
; 
;     Field attributes
; 

(defconstant $kDCMIndexedFieldMask 1)
(defconstant $kDCMRequiredFieldMask 2)
(defconstant $kDCMIdentifyFieldMask 4)
(defconstant $kDCMFixedSizeFieldMask 8)
(defconstant $kDCMHiddenFieldMask #x80000000)

(def-mactype :DCMFieldAttributes (find-mactype ':UInt32))
; 
;     Standard dictionary properties
; 

(defconstant $pDCMAccessMethod :|amtd|)         ;  data type: typeChar ReadOnly 

(defconstant $pDCMPermission :|perm|)           ;  data type: typeUInt16 

(defconstant $pDCMListing :|list|)              ;  data type: typeUInt16 

(defconstant $pDCMMaintenance :|mtnc|)          ;  data type: typeUInt16 

(defconstant $pDCMLocale :|locl|)               ;  data type: typeUInt32.  Optional; default = kLocaleIdentifierWildCard 

(defconstant $pDCMClass :|pcls|)                ;  data type: typeUInt16 

(defconstant $pDCMCopyright :|info|)            ;  data type: typeChar 

; 
;     pDCMPermission property constants
; 

(defconstant $kDCMReadOnlyDictionary 0)
(defconstant $kDCMReadWriteDictionary 1)
; 
;     pDCMListing property constants
; 

(defconstant $kDCMAllowListing 0)
(defconstant $kDCMProhibitListing 1)
; 
;     pDCMClass property constants
; 

(defconstant $kDCMUserDictionaryClass 0)
(defconstant $kDCMSpecificDictionaryClass 1)
(defconstant $kDCMBasicDictionaryClass 2)
; 
;     Standard search method
; 

(defconstant $kDCMFindMethodExactMatch :|=   |)
(defconstant $kDCMFindMethodBeginningMatch :|bgwt|)
(defconstant $kDCMFindMethodContainsMatch :|cont|)
(defconstant $kDCMFindMethodEndingMatch :|ends|)
(defconstant $kDCMFindMethodForwardTrie :|ftri|);  used for morphological analysis

(defconstant $kDCMFindMethodBackwardTrie :|btri|);  used for morphological analysis


(def-mactype :DCMFindMethod (find-mactype ':OSType))
; 
;     AccessMethod features
; 

(defconstant $kDCMCanUseFileDictionaryMask 1)
(defconstant $kDCMCanUseMemoryDictionaryMask 2)
(defconstant $kDCMCanStreamDictionaryMask 4)
(defconstant $kDCMCanHaveMultipleIndexMask 8)
(defconstant $kDCMCanModifyDictionaryMask 16)
(defconstant $kDCMCanCreateDictionaryMask 32)
(defconstant $kDCMCanAddDictionaryFieldMask 64)
(defconstant $kDCMCanUseTransactionMask #x80)

(def-mactype :DCMAccessMethodFeature (find-mactype ':UInt32))

(def-mactype :DCMUniqueID (find-mactype ':UInt32))

(def-mactype :DCMObjectID (find-mactype '(:pointer :OpaqueDCMObjectID)))

(def-mactype :DCMAccessMethodID (find-mactype ':DCMObjectID))

(def-mactype :DCMDictionaryID (find-mactype ':DCMObjectID))
; #define kDCMInvalidObjectID ((DCMObjectID) kInvalidID)

(def-mactype :DCMObjectRef (find-mactype '(:pointer :OpaqueDCMObjectRef)))

(def-mactype :DCMDictionaryRef (find-mactype ':DCMObjectRef))

(def-mactype :DCMDictionaryStreamRef (find-mactype ':DCMObjectRef))
; #define kDCMInvalidObjectRef ((DCMObjectRef) kInvalidID)

(def-mactype :DCMObjectIterator (find-mactype '(:pointer :OpaqueDCMObjectIterator)))

(def-mactype :DCMAccessMethodIterator (find-mactype ':DCMObjectIterator))

(def-mactype :DCMDictionaryIterator (find-mactype ':DCMObjectIterator))

(def-mactype :DCMFoundRecordIterator (find-mactype '(:pointer :OpaqueDCMFoundRecordIterator)))
; 
;     Field specification declarations
; 

(def-mactype :DCMFieldTag (find-mactype ':FourCharCode))

(def-mactype :DCMFieldType (find-mactype ':FourCharCode))
; 
;     Dictionary header information
; 
(defrecord DCMDictionaryHeader
   (headerSignature :FourCharCode)
   (headerVersion :UInt32)
   (headerSize :UInt32)
   (accessMethod (:string 63))
)

;type name? (%define-record :DCMDictionaryHeader (find-record-descriptor ':DCMDictionaryHeader))
; 
;     Callback routines
; 

(def-mactype :DCMProgressFilterProcPtr (find-mactype ':pointer)); (Boolean determinateProcess , UInt16 percentageComplete , UInt32 callbackUD)

(def-mactype :DCMProgressFilterUPP (find-mactype '(:pointer :OpaqueDCMProgressFilterProcPtr)))
; 
;  *  NewDCMProgressFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeDCMProgressFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeDCMProgressFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;     Library version
; 
; 
;  *  DCMLibraryVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMLibraryVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;     Create/delete dictionary
; 
; 
;  *  DCMNewDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMNewDictionary" 
   ((accessMethodID (:pointer :OpaqueDCMObjectID))
    (newDictionaryFile (:pointer :FSSpec))
    (scriptTag :SInt16)
    (listOfFieldInfoRecords (:pointer :AEDesc))
    (invisible :Boolean)
    (recordCapacity :UInt32)
    (newDictionary (:pointer :DCMDICTIONARYID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMDeriveNewDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMDeriveNewDictionary" 
   ((srcDictionary (:pointer :OpaqueDCMObjectID))
    (newDictionaryFile (:pointer :FSSpec))
    (scriptTag :SInt16)
    (invisible :Boolean)
    (recordCapacity :UInt32)
    (newDictionary (:pointer :DCMDICTIONARYID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMDeleteDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMDeleteDictionary" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Register dictionary
; 
; 
;  *  DCMRegisterDictionaryFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMRegisterDictionaryFile" 
   ((dictionaryFile (:pointer :FSSpec))
    (dictionaryID (:pointer :DCMDICTIONARYID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMUnregisterDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMUnregisterDictionary" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Open dictionary
; 
; 
;  *  DCMOpenDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMOpenDictionary" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (protectKeySize :UInt32)
    (protectKey (:pointer :void))
    (dictionaryRef (:pointer :DCMDICTIONARYREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMCloseDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMCloseDictionary" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Change access privilege
; 
; 
;  *  DCMGetDictionaryWriteAccess()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetDictionaryWriteAccess" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (timeOutDuration :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMReleaseDictionaryWriteAccess()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMReleaseDictionaryWriteAccess" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (commitTransaction :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Find records
; 
; 
;  *  DCMFindRecords()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMFindRecords" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (keySize :UInt32)
    (keyData (:pointer :void))
    (findMethod :OSType)
    (preFetchedDataNum :UInt32)
    (preFetchedData (:pointer :DCMFIELDTAG))
    (skipCount :UInt32)
    (maxRecordCount :UInt32)
    (recordIterator (:pointer :DCMFOUNDRECORDITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMCountRecordIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMCountRecordIterator" 
   ((recordIterator (:pointer :OpaqueDCMFoundRecordIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  DCMIterateFoundRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMIterateFoundRecord" 
   ((recordIterator (:pointer :OpaqueDCMFoundRecordIterator))
    (maxKeySize :UInt32)
    (actualKeySize (:pointer :ByteCount))
    (keyData (:pointer :void))
    (uniqueID (:pointer :DCMUNIQUEID))
    (dataList (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMDisposeRecordIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMDisposeRecordIterator" 
   ((recordIterator (:pointer :OpaqueDCMFoundRecordIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Dump dictionary
; 
; 
;  *  DCMCountRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMCountRecord" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (count (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetRecordSequenceNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetRecordSequenceNumber" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (keySize :UInt32)
    (keyData (:pointer :void))
    (uniqueID :UInt32)
    (sequenceNum (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetNthRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetNthRecord" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (serialNum :UInt32)
    (maxKeySize :UInt32)
    (keySize (:pointer :ByteCount))
    (keyData (:pointer :void))
    (uniqueID (:pointer :DCMUNIQUEID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetNextRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetNextRecord" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (keySize :UInt32)
    (keyData (:pointer :void))
    (uniqueID :UInt32)
    (maxKeySize :UInt32)
    (nextKeySize (:pointer :ByteCount))
    (nextKeyData (:pointer :void))
    (nextUniqueID (:pointer :DCMUNIQUEID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetPrevRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetPrevRecord" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (keySize :UInt32)
    (keyData (:pointer :void))
    (uniqueID :UInt32)
    (maxKeySize :UInt32)
    (prevKeySize (:pointer :ByteCount))
    (prevKeyData (:pointer :void))
    (prevUniqueID (:pointer :DCMUNIQUEID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Get field data
; 
; 
;  *  DCMGetFieldData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetFieldData" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (keySize :UInt32)
    (keyData (:pointer :void))
    (uniqueID :UInt32)
    (numOfData :UInt32)
    (dataTag (:pointer :DCMFIELDTAG))
    (dataList (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMSetFieldData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMSetFieldData" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (keySize :UInt32)
    (keyData (:pointer :void))
    (uniqueID :UInt32)
    (dataList (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Add record
; 
; 
;  *  DCMAddRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMAddRecord" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (keySize :UInt32)
    (keyData (:pointer :void))
    (checkOnly :Boolean)
    (dataList (:pointer :AEDesc))
    (newUniqueID (:pointer :DCMUNIQUEID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMDeleteRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMDeleteRecord" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
    (keyFieldTag :FourCharCode)
    (keySize :UInt32)
    (keyData (:pointer :void))
    (uniqueID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Reorganize/compact dictionary
; 
; 
;  *  DCMReorganizeDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMReorganizeDictionary" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (extraCapacity :UInt32)
    (progressProc (:pointer :OpaqueDCMProgressFilterProcPtr))
    (userData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMCompactDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMCompactDictionary" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (progressProc (:pointer :OpaqueDCMProgressFilterProcPtr))
    (userData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     DictionaryID utilities
; 
; 
;  *  DCMGetFileFromDictionaryID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetFileFromDictionaryID" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (fileRef (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetDictionaryIDFromFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetDictionaryIDFromFile" 
   ((fileRef (:pointer :FSSpec))
    (dictionaryID (:pointer :DCMDICTIONARYID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetDictionaryIDFromRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetDictionaryIDFromRef" 
   ((dictionaryRef (:pointer :OpaqueDCMObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDCMObjectID)
() )
; 
;     Field information and manipulation
; 
; 
;  *  DCMGetDictionaryFieldInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetDictionaryFieldInfo" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (fieldTag :FourCharCode)
    (fieldInfoRecord (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Dictionary property
; 
; 
;  *  DCMGetDictionaryProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetDictionaryProperty" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (propertyTag :FourCharCode)
    (maxPropertySize :UInt32)
    (actualSize (:pointer :ByteCount))
    (propertyValue (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMSetDictionaryProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMSetDictionaryProperty" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (propertyTag :FourCharCode)
    (propertySize :UInt32)
    (propertyValue (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetDictionaryPropertyList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetDictionaryPropertyList" 
   ((dictionaryID (:pointer :OpaqueDCMObjectID))
    (maxPropertyNum :UInt32)
    (numProperties (:pointer :ItemCount))
    (propertyTag (:pointer :DCMFIELDTAG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Seaarch dictionary
; 
; 
;  *  DCMCreateDictionaryIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMCreateDictionaryIterator" 
   ((dictionaryIterator (:pointer :DCMDICTIONARYITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Search AccessMethod
; 
; 
;  *  DCMCreateAccessMethodIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMCreateAccessMethodIterator" 
   ((accessMethodIterator (:pointer :DCMACCESSMETHODITERATOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Iterator Operation
; 
; 
;  *  DCMCountObjectIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMCountObjectIterator" 
   ((iterator (:pointer :OpaqueDCMObjectIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  DCMIterateObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMIterateObject" 
   ((iterator (:pointer :OpaqueDCMObjectIterator))
    (objectID (:pointer :DCMObjectID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMResetObjectIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMResetObjectIterator" 
   ((iterator (:pointer :OpaqueDCMObjectIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMDisposeObjectIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMDisposeObjectIterator" 
   ((iterator (:pointer :OpaqueDCMObjectIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Get AccessMethod information
; 
; 
;  *  DCMGetAccessMethodIDFromName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetAccessMethodIDFromName" 
   ((accessMethodName (:pointer :UInt8))
    (accessMethodID (:pointer :DCMACCESSMETHODID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Field Info Record routines
; 
; 
;  *  DCMCreateFieldInfoRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMCreateFieldInfoRecord" 
   ((fieldTag :FourCharCode)
    (fieldType :FourCharCode)
    (maxRecordSize :UInt32)
    (fieldAttributes :UInt32)
    (fieldDefaultData (:pointer :AEDesc))
    (numberOfFindMethods :UInt32)
    (findMethods (:pointer :DCMFINDMETHOD))
    (fieldInfoRecord (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetFieldTagAndType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetFieldTagAndType" 
   ((fieldInfoRecord (:pointer :AEDesc))
    (fieldTag (:pointer :DCMFIELDTAG))
    (fieldType (:pointer :DCMFIELDTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetFieldMaxRecordSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetFieldMaxRecordSize" 
   ((fieldInfoRecord (:pointer :AEDesc))
    (maxRecordSize (:pointer :ByteCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetFieldAttributes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetFieldAttributes" 
   ((fieldInfoRecord (:pointer :AEDesc))
    (attributes (:pointer :DCMFIELDATTRIBUTES))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetFieldDefaultData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetFieldDefaultData" 
   ((fieldInfoRecord (:pointer :AEDesc))
    (desiredType :FourCharCode)
    (fieldDefaultData (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DCMGetFieldFindMethods()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DictionaryMgrLib 1.0 and later
;  

(deftrap-inline "_DCMGetFieldFindMethods" 
   ((fieldInfoRecord (:pointer :AEDesc))
    (findMethodsArrayMaxSize :UInt32)
    (findMethods (:pointer :DCMFINDMETHOD))
    (actualNumberOfFindMethods (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Check Dictionary Manager availability
; 

; #if TARGET_RT_MAC_CFM
; #ifdef __cplusplus
#| #|
    inline pascal Boolean DCMDictionaryManagerAvailable() { return (DCMLibraryVersion != (void*)kUnresolvedCFragSymbolAddress); }
|#
 |#

; #else
; #define DCMDictionaryManagerAvailable()     ((DCMLibraryVersion != (void*)kUnresolvedCFragSymbolAddress)

; #endif

#| 
; #elif TARGET_RT_MAC_MACHO
;  Dictionary Manager is always available on OS X 
; #ifdef __cplusplus
#|
    inline pascal Boolean DCMDictionaryManagerAvailable() { return true; }
|#

; #else
; #define DCMDictionaryManagerAvailable()     (true)

; #endif

 |#

; #endif  /*  */

; 
; =============================================================================================
;     Definitions for Japanese Analysis Module
; =============================================================================================
; 
; 
;     Default dictionary access method for Japanese analysis
; 
(defconstant $kAppleJapaneseDefaultAccessMethodName "\\pDAM:Apple Backward Trie Access Method")
; #define kAppleJapaneseDefaultAccessMethodName   "\pDAM:Apple Backward Trie Access Method"
; 
;     Data length limitations of Apple Japanese dictionaries
; 

(defconstant $kMaxYomiLengthInAppleJapaneseDictionary 40)
(defconstant $kMaxKanjiLengthInAppleJapaneseDictionary 64)
; 
;     Defined field tags of Apple Japanese dictionary
; 

(defconstant $kDCMJapaneseYomiTag :|yomi|)
(defconstant $kDCMJapaneseHyokiTag :|hyok|)
(defconstant $kDCMJapaneseHinshiTag :|hins|)
(defconstant $kDCMJapaneseWeightTag :|hind|)
(defconstant $kDCMJapanesePhoneticTag :|hton|)
(defconstant $kDCMJapaneseAccentTag :|acnt|)
(defconstant $kDCMJapaneseOnKunReadingTag :|OnKn|)
(defconstant $kDCMJapaneseFukugouInfoTag :|fuku|)

(defconstant $kDCMJapaneseYomiType :|utxt|)
(defconstant $kDCMJapaneseHyokiType :|utxt|)
(defconstant $kDCMJapaneseHinshiType :|hins|)
(defconstant $kDCMJapaneseWeightType :|shor|)
(defconstant $kDCMJapanesePhoneticType :|utxt|)
(defconstant $kDCMJapaneseAccentType :|byte|)
(defconstant $kDCMJapaneseOnKunReadingType :|utxt|)
(defconstant $kDCMJapaneseFukugouInfoType :|fuku|)
; 
; =============================================================================================
;  System 7 Dictionary Manager
; =============================================================================================
; 
; #pragma options align=reset
; #pragma options align=mac68k
;  Dictionary data insertion modes 

(defconstant $kInsert 0)                        ;  Only insert the input entry if there is nothing in the dictionary that matches the key. 

(defconstant $kReplace 1)                       ;  Only replace the entries which match the key with the input entry. 

(defconstant $kInsertOrReplace 2)               ;  Insert the entry if there is nothing in the dictionary which matches the key, otherwise replaces the existing matched entries with the input entry. 

;  This Was InsertMode 

(def-mactype :DictionaryDataInsertMode (find-mactype ':SInt16))
;  Key attribute constants 

(defconstant $kIsCaseSensitive 16)              ;  case sensitive = 16       

(defconstant $kIsNotDiacriticalSensitive 32)    ;  diac not sensitive = 32    

;  Registered attribute type constants.   

(defconstant $kNoun -1)
(defconstant $kVerb -2)
(defconstant $kAdjective -3)
(defconstant $kAdverb -4)
;  This Was AttributeType 

(def-mactype :DictionaryEntryAttribute (find-mactype ':SInt8))
;  Dictionary information record 
(defrecord DictionaryInformation
   (dictionaryFSSpec :FSSpec)
   (numberOfRecords :SInt32)
   (currentGarbageSize :SInt32)
   (script :SInt16)
   (maximumKeyLength :SInt16)
   (keyAttributes :SInt8)
)

;type name? (%define-record :DictionaryInformation (find-record-descriptor ':DictionaryInformation))
(defrecord DictionaryAttributeTable
   (datSize :UInt8)
   (datTable (:array :SInt8 1))
)

;type name? (%define-record :DictionaryAttributeTable (find-record-descriptor ':DictionaryAttributeTable))

(def-mactype :DictionaryAttributeTablePtr (find-mactype '(:pointer :DictionaryAttributeTable)))
; 
;  *  InitializeDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  OpenDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CloseDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  InsertRecordToDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  DeleteRecordFromDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FindRecordInDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FindRecordByIndexInDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetDictionaryInformation()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CompactDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DICTIONARY__ */


(provide-interface "Dictionary")