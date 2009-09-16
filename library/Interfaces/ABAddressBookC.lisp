(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABAddressBookC.h"
; at Sunday July 2,2006 7:22:42 pm.
; 
;   ABAddressBookC.h
;   AddressBook Framework
; 
;   Copyright (c) 2002-2003 Apple Computer. All rights reserved.
; 
; #ifndef __ADDRESSBOOKC__
; #define __ADDRESSBOOKC__

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "AddressBook/ABTypedefs")

(require-interface "AddressBook/ABGlobalsC")

(def-mactype :ABRecordRef (find-mactype '(:pointer :void)))

(def-mactype :ABPersonRef (find-mactype '(:pointer :__ABPerson)))

(def-mactype :ABGroupRef (find-mactype '(:pointer :__ABGroup)))

(def-mactype :ABSearchElementRef (find-mactype '(:pointer :__ABSearchElementRef)))

(def-mactype :ABAddressBookRef (find-mactype '(:pointer :__ABAddressBookRef)))

(def-mactype :ABMultiValueRef (find-mactype '(:pointer :__ABMultiValue)))

(def-mactype :ABMutableMultiValueRef (find-mactype '(:pointer :__ABMultiValue)))
;  --------------------------------------------------------------------------------
; 	LSOpenCFURLRef support
;  --------------------------------------------------------------------------------
;  An application can open the AddressBook app and select (and edit) a specific
;  person by using the LSOpenCFURLRef API.
; 
;  To launch (or bring to front) the Address Book app and select a given person
; 
;  CFStringRef uniqueId = ABRecordCopyUniqueId(aPerson);
;  CFStringRef urlString = CFStringCreateWithFormat(NULL, CFSTR(addressbook://%@), uniqueId);
;  CFURLRef urlRef = CFURLCreateWithString(NULL, urlString, NULL);
;  LSOpenCFURLRef(urlRef, NULL);
;  CFRelease(uniqueId);
;  CFRelease(urlRef);
;  CFRelease(urlString);
; 
;  To launch (or bring to front) the Address Book app and edit a given person
; 
;  CFStringRef uniqueId = ABRecordCopyUniqueId(aPerson);
;  CFStringRef urlString = CFStringCreateWithFormat(NULL, CFSTR(addressbook://%@?edit), uniqueId);
;  CFURLRef urlRef = CFURLCreateWithString(NULL, urlString, NULL);
;  LSOpenCFURLRef(urlRef, NULL);
;  CFRelease(uniqueId);
;  CFRelease(urlRef);
;  CFRelease(urlString);
;  --------------------------------------------------------------------------------
;       AddressBook
;  --------------------------------------------------------------------------------
;  --- There is only one Address Book

(deftrap-inline "_ABGetSharedAddressBook" 
   (
   )
   (:pointer :__ABAddressBookRef)
() )
;  --- Searching

(deftrap-inline "_ABCopyArrayOfMatchingRecords" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (search (:pointer :__ABSearchElementRef))
   )
   (:pointer :__CFArray)
() )
;  --- Saving

(deftrap-inline "_ABSave" 
   ((addressBook (:pointer :__ABAddressBookRef))
   )
   :Boolean
() )

(deftrap-inline "_ABHasUnsavedChanges" 
   ((addressBook (:pointer :__ABAddressBookRef))
   )
   :Boolean
() )
;  --- Me

(deftrap-inline "_ABGetMe" 
   ((addressBook (:pointer :__ABAddressBookRef))
   )
   (:pointer :__ABPerson)
() )
;  Not retain???

(deftrap-inline "_ABSetMe" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (moi (:pointer :__ABPerson))
   )
   nil
() )
;  Returns the record class Name for a particular uniqueId

(deftrap-inline "_ABCopyRecordTypeFromUniqueId" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (uniqueId (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
;  --- Properties
;  Property names must be unique for a record type

(deftrap-inline "_ABAddPropertiesAndTypes" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (recordType (:pointer :__CFString))
    (propertiesAnTypes (:pointer :__CFDictionary))
   )
   :signed-long
() )

(deftrap-inline "_ABRemoveProperties" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (recordType (:pointer :__CFString))
    (properties (:pointer :__CFArray))
   )
   :signed-long
() )

(deftrap-inline "_ABCopyArrayOfPropertiesForRecordType" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (recordType (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )

(deftrap-inline "_ABTypeOfProperty" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (recordType (:pointer :__CFString))
    (property (:pointer :__CFString))
   )
   :SInt32
() )
;  --- Records (Person, Group)

(deftrap-inline "_ABCopyRecordForUniqueId" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (uniqueId (:pointer :__CFString))
   )
   (:pointer :void)
() )

(deftrap-inline "_ABAddRecord" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (record (:pointer :void))
   )
   :Boolean
() )

(deftrap-inline "_ABRemoveRecord" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (record (:pointer :void))
   )
   :Boolean
() )
;  --- People

(deftrap-inline "_ABCopyArrayOfAllPeople" 
   ((addressBook (:pointer :__ABAddressBookRef))
   )
   (:pointer :__CFArray)
() )
;  Array of ABPerson
;  --- Groups

(deftrap-inline "_ABCopyArrayOfAllGroups" 
   ((addressBook (:pointer :__ABAddressBookRef))
   )
   (:pointer :__CFArray)
() )
;  Array of ABGroup
;  --------------------------------------------------------------------------------
;       ABRecord
;  --------------------------------------------------------------------------------

(deftrap-inline "_ABRecordCopyRecordType" 
   ((record (:pointer :void))
   )
   (:pointer :__CFString)
() )
;  --- Property value

(deftrap-inline "_ABRecordCopyValue" 
   ((record (:pointer :void))
    (property (:pointer :__CFString))
   )
   (:pointer :void)
() )
;  returns a CFDictionary for multi-value properties

(deftrap-inline "_ABRecordSetValue" 
   ((record (:pointer :void))
    (property (:pointer :__CFString))
    (value (:pointer :void))
   )
   :Boolean
() )
;  takes a CFDictionary for multi-value properties

(deftrap-inline "_ABRecordRemoveValue" 
   ((record (:pointer :void))
    (property (:pointer :__CFString))
   )
   :Boolean
() )
;  ---- Unique ID access convenience

(deftrap-inline "_ABRecordCopyUniqueId" 
   ((record (:pointer :void))
   )
   (:pointer :__CFString)
() )
;  --------------------------------------------------------------------------------
;       ABPerson
;  --------------------------------------------------------------------------------

(deftrap-inline "_ABPersonCreate" 
   (
   )
   (:pointer :__ABPerson)
() )

(deftrap-inline "_ABPersonCreateWithVCardRepresentation" 
   ((vCard (:pointer :__CFData))
   )
   (:pointer :__ABPerson)
() )

(deftrap-inline "_ABPersonCopyVCardRepresentation" 
   ((person (:pointer :__ABPerson))
   )
   (:pointer :__CFData)
() )

(deftrap-inline "_ABPersonCopyParentGroups" 
   ((person (:pointer :__ABPerson))
   )
   (:pointer :__CFArray)
() )
;  Groups this person belongs to
;  --- Search elements

(deftrap-inline "_ABPersonCreateSearchElement" 
   ((property (:pointer :__CFString))
    (label (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value (:pointer :void))
    (comparison :SInt32)
   )
   (:pointer :__ABSearchElementRef)
() )
;  --------------------------------------------------------------------------------
;       ABGroups
;  --------------------------------------------------------------------------------

(deftrap-inline "_ABGroupCreate" 
   (
   )
   (:pointer :__ABGroup)
() )
;  --- Dealing with Persons

(deftrap-inline "_ABGroupCopyArrayOfAllMembers" 
   ((group (:pointer :__ABGroup))
   )
   (:pointer :__CFArray)
() )

(deftrap-inline "_ABGroupAddMember" 
   ((group (:pointer :__ABGroup))
    (personToAdd (:pointer :__ABPerson))
   )
   :Boolean
() )

(deftrap-inline "_ABGroupRemoveMember" 
   ((group (:pointer :__ABGroup))
    (personToRemove (:pointer :__ABPerson))
   )
   :Boolean
() )
;  --- Dealing with Groups

(deftrap-inline "_ABGroupCopyArrayOfAllSubgroups" 
   ((group (:pointer :__ABGroup))
   )
   (:pointer :__CFArray)
() )

(deftrap-inline "_ABGroupAddGroup" 
   ((group (:pointer :__ABGroup))
    (groupToAdd (:pointer :__ABGroup))
   )
   :Boolean
() )

(deftrap-inline "_ABGroupRemoveGroup" 
   ((group (:pointer :__ABGroup))
    (groupToRemove (:pointer :__ABGroup))
   )
   :Boolean
() )
;  --- Dealong with Parents

(deftrap-inline "_ABGroupCopyParentGroups" 
   ((group (:pointer :__ABGroup))
   )
   (:pointer :__CFArray)
() )
;  --- Distribution list

(deftrap-inline "_ABGroupSetDistributionIdentifier" 
   ((group (:pointer :__ABGroup))
    (person (:pointer :__ABPerson))
    (property (:pointer :__CFString))
    (identifier (:pointer :__CFString))
   )
   :Boolean
() )

(deftrap-inline "_ABGroupCopyDistributionIdentifier" 
   ((group (:pointer :__ABGroup))
    (person (:pointer :__ABPerson))
    (property (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
;  --- Search elements

(deftrap-inline "_ABGroupCreateSearchElement" 
   ((property (:pointer :__CFString))
    (label (:pointer :__CFString))
    (key (:pointer :__CFString))
    (value (:pointer :void))
    (comparison :SInt32)
   )
   (:pointer :__ABSearchElementRef)
() )
;  --------------------------------------------------------------------------------
;       ABSearchElement
;  --------------------------------------------------------------------------------

(deftrap-inline "_ABSearchElementCreateWithConjunction" 
   ((conjunction :SInt32)
    (childrenSearchElement (:pointer :__CFArray))
   )
   (:pointer :__ABSearchElementRef)
() )

(deftrap-inline "_ABSearchElementMatchesRecord" 
   ((searchElement (:pointer :__ABSearchElementRef))
    (record (:pointer :void))
   )
   :Boolean
() )
;  --------------------------------------------------------------------------------
;       ABMultiValue
;  --------------------------------------------------------------------------------

(deftrap-inline "_ABMultiValueCreate" 
   (
   )
   (:pointer :__ABMultiValue)
() )

(deftrap-inline "_ABMultiValueCount" 
   ((multiValue (:pointer :__ABMultiValue))
   )
   :UInt32
() )

(deftrap-inline "_ABMultiValueCopyValueAtIndex" 
   ((multiValue (:pointer :__ABMultiValue))
    (index :signed-long)
   )
   (:pointer :void)
() )

(deftrap-inline "_ABMultiValueCopyLabelAtIndex" 
   ((multiValue (:pointer :__ABMultiValue))
    (index :signed-long)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_ABMultiValueCopyPrimaryIdentifier" 
   ((multiValue (:pointer :__ABMultiValue))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_ABMultiValueIndexForIdentifier" 
   ((multiValue (:pointer :__ABMultiValue))
    (identifier (:pointer :__CFString))
   )
   :signed-long
() )

(deftrap-inline "_ABMultiValueCopyIdentifierAtIndex" 
   ((multiValue (:pointer :__ABMultiValue))
    (index :signed-long)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_ABMultiValuePropertyType" 
   ((multiValue (:pointer :__ABMultiValue))
   )
   :SInt32
() )

(deftrap-inline "_ABMultiValueCreateCopy" 
   ((multiValue (:pointer :__ABMultiValue))
   )
   (:pointer :__ABMultiValue)
() )
;  --------------------------------------------------------------------------------
;       ABMutableMultiValue
;  --------------------------------------------------------------------------------

(deftrap-inline "_ABMultiValueCreateMutable" 
   (
   )
   (:pointer :__ABMultiValue)
() )

(deftrap-inline "_ABMultiValueAdd" 
   ((multiValue (:pointer :__ABMultiValue))
    (value (:pointer :void))
    (label (:pointer :__CFString))
    (outIdentifier (:pointer :CFSTRINGREF))
   )
   :Boolean
() )

(deftrap-inline "_ABMultiValueInsert" 
   ((multiValue (:pointer :__ABMultiValue))
    (value (:pointer :void))
    (label (:pointer :__CFString))
    (index :signed-long)
    (outIdentifier (:pointer :CFSTRINGREF))
   )
   :Boolean
() )

(deftrap-inline "_ABMultiValueRemove" 
   ((multiValue (:pointer :__ABMultiValue))
    (index :signed-long)
   )
   :Boolean
() )

(deftrap-inline "_ABMultiValueReplaceValue" 
   ((multiValue (:pointer :__ABMultiValue))
    (value (:pointer :void))
    (index :signed-long)
   )
   :Boolean
() )

(deftrap-inline "_ABMultiValueReplaceLabel" 
   ((multiValue (:pointer :__ABMultiValue))
    (label (:pointer :__CFString))
    (index :signed-long)
   )
   :Boolean
() )

(deftrap-inline "_ABMultiValueSetPrimaryIdentifier" 
   ((multiValue (:pointer :__ABMultiValue))
    (identifier (:pointer :__CFString))
   )
   :Boolean
() )

(deftrap-inline "_ABMultiValueCreateMutableCopy" 
   ((multiValue (:pointer :__ABMultiValue))
   )
   (:pointer :__ABMultiValue)
() )
;  --------------------------------------------------------------------------------
;       Localization of properties or labels
;  --------------------------------------------------------------------------------

(deftrap-inline "_ABCopyLocalizedPropertyOrLabel" 
   ((labelOrProperty (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
;  --- Address formatting

(deftrap-inline "_ABCreateFormattedAddressFromDictionary" 
   ((addressBook (:pointer :__ABAddressBookRef))
    (address (:pointer :__CFDictionary))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )

(deftrap-inline "_ABCopyDefaultCountryCode" 
   ((addressBook (:pointer :__ABAddressBookRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
;  --------------------------------------------------------------------------------
;       Person Image Loading
;  --------------------------------------------------------------------------------

(deftrap-inline "_ABPersonSetImageData" 
   ((person (:pointer :__ABPerson))
    (imageData (:pointer :__CFData))
   )
   :Boolean
() )

(deftrap-inline "_ABPersonCopyImageData" 
   ((person (:pointer :__ABPerson))
   )
   (:pointer :__CFData)
() )

(def-mactype :ABImageClientCallback (find-mactype ':pointer)); (CFDataRef imageData , int tag , void * refcon)

(deftrap-inline "_ABBeginLoadingImageDataForClient" 
   ((person (:pointer :__ABPerson))
    (callback :pointer)
    (refcon :pointer)
   )
   :signed-long
() )

(deftrap-inline "_ABCancelLoadingImageDataForTag" 
   ((tag :signed-long)
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif


(provide-interface "ABAddressBookC")