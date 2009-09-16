(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NameRegistry.h"
; at Sunday July 2,2006 7:23:22 pm.
; 
;      File:       CarbonCore/NameRegistry.h
;  
;      Contains:   NameRegistry Interfaces
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1993-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __NAMEREGISTRY__
; #define __NAMEREGISTRY__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=power
; ******************************************************************************
;  * 
;  * Foundation Types
;  *
;  
;  Value of a property 

(def-mactype :RegPropertyValue (find-mactype '(:pointer :void)))
;  Length of property value 

(def-mactype :RegPropertyValueSize (find-mactype ':UInt32))
; ******************************************************************************
;  * 
;  * RegEntryID   :   The Global x-Namespace Entry Identifier
;  *
;  

(def-mactype :DeviceNodePtr (find-mactype '(:pointer :OpaqueDeviceNodePtr)))
(defrecord RegEntryID
   (es_ver :UInt16)
   (es_gen :UInt16)
   (es_devid (:pointer :OpaqueDeviceNodePtr))
   (es_spare1 :UInt32)
   (es_spare2 :UInt32)
)

;type name? (%define-record :RegEntryID (find-record-descriptor ':RegEntryID))

(def-mactype :RegEntryIDPtr (find-mactype '(:pointer :RegEntryID)))
;     
;     For Copland, RegEntryID was renamed RegEntryRef.  Add typedef in case
;     any source code switched to use the new name.
; 

(%define-record :RegEntryRef (find-record-descriptor ':RegEntryID))
; ******************************************************************************
;  *
;  * Root Entry Name Definitions  (Applies to all Names in the RootNameSpace)
;  *
;  *  ¥ Names are a colon-separated list of name components.  Name components
;  *    may not themselves contain colons.  
;  *  ¥ Names are presented as null-terminated ASCII character strings.
;  *  ¥ Names follow similar parsing rules to Apple file system absolute
;  *    and relative paths.  However the '::' parent directory syntax is
;  *    not currently supported.
;  
;  Max length of Entry Name 

(defconstant $kRegCStrMaxEntryNameLength 47)
;  Entry Names are single byte ASCII 

(def-mactype :RegCStrEntryName (find-mactype ':character))

(def-mactype :RegCStrEntryNamePtr (find-mactype '(:pointer :character)))
;  length of RegCStrEntryNameBuf =  kRegCStrMaxEntryNameLength+1
(defrecord RegCStrEntryNameBuf
   (contents (:array :character 48))
)
(def-mactype :RegCStrPathName (find-mactype ':character))

(def-mactype :RegPathNameSize (find-mactype ':UInt32))

(defconstant $kRegPathNameSeparator 58)         ;  0x3A 

(defconstant $kRegEntryNameTerminator 0)        ;  '\0' 

(defconstant $kRegPathNameTerminator 0)         ;  '\0' 

; ******************************************************************************
;  *
;  * Property Name and ID Definitions
;  *  (Applies to all Properties Regardless of NameSpace)
;  

(defconstant $kRegMaximumPropertyNameLength 31) ;  Max length of Property Name 

(defconstant $kRegPropertyNameTerminator 0)     ;  '\0' 

(defrecord RegPropertyNameBuf
   (contents (:array :character 32))
)
(def-mactype :RegPropertyName (find-mactype ':character))

(def-mactype :RegPropertyNamePtr (find-mactype '(:pointer :character)))

(defconstant $kRegMaxPropertyNameLength 31)
; ******************************************************************************
;  *
;  * Iteration Operations
;  *
;  *  These specify direction when traversing the name relationships
;  

(def-mactype :RegIterationOp (find-mactype ':UInt32))

(def-mactype :RegEntryIterationOp (find-mactype ':UInt32))
;  Absolute locations

(defconstant $kRegIterRoot 2)                   ;  "Upward" Relationships 

(defconstant $kRegIterParents 3)                ;  include all  parent(s) of entry 
;  "Downward" Relationships

(defconstant $kRegIterChildren 4)               ;  include all children 

(defconstant $kRegIterSubTrees 5)               ;  include all sub trees of entry 

(defconstant $kRegIterDescendants 5)            ;  include all descendants of entry 
;  "Horizontal" Relationships 

(defconstant $kRegIterSibling 6)                ;  include all siblings 
;  Keep doing the same thing

(defconstant $kRegIterContinue 1)
; ******************************************************************************
;  *
;  * Name Entry and Property Modifiers
;  *
;  *
;  *
;  * Modifiers describe special characteristics of names
;  * and properties.  Modifiers might be supported for
;  * some names and not others.
;  * 
;  * Device Drivers should not rely on functionality
;  * specified as a modifier.
;  

(def-mactype :RegModifiers (find-mactype ':UInt32))

(def-mactype :RegEntryModifiers (find-mactype ':UInt32))

(def-mactype :RegPropertyModifiers (find-mactype ':UInt32))

(defconstant $kRegNoModifiers 0)                ;  no entry modifiers in place 

(defconstant $kRegUniversalModifierMask #xFFFF) ;  mods to all entries 

(defconstant $kRegNameSpaceModifierMask #xFF0000);  mods to all entries within namespace 
;  mods to just this entry 

(defconstant $kRegModifierMask #xFF000000)
;  Universal Property Modifiers 

(defconstant $kRegPropertyValueIsSavedToNVRAM 32);  property is non-volatile (saved in NVRAM) 

(defconstant $kRegPropertyValueIsSavedToDisk 64);  property is non-volatile (saved on disk) 

;  NameRegistry version, Gestalt/PEF-style -- MUST BE KEPT IN SYNC WITH MAKEFILE !! 

(defconstant $LatestNR_PEFVersion #x1030000)    ;  latest NameRegistryLib version (Gestalt/PEF-style) 

;  ///////////////////////
; //
; // The Registry API
; //
; /////////////////////// 
;  NameRegistry dispatch indexes 

(defconstant $kSelectRegistryEntryIDInit 0)
(defconstant $kSelectRegistryEntryIDCompare 1)
(defconstant $kSelectRegistryEntryIDCopy 2)
(defconstant $kSelectRegistryEntryIDDispose 3)
(defconstant $kSelectRegistryCStrEntryCreate 4)
(defconstant $kSelectRegistryEntryDelete 5)
(defconstant $kSelectRegistryEntryCopy 6)
(defconstant $kSelectRegistryEntryIterateCreate 7)
(defconstant $kSelectRegistryEntryIterateDispose 8)
(defconstant $kSelectRegistryEntryIterateSet 9)
(defconstant $kSelectRegistryEntryIterate 10)
(defconstant $kSelectRegistryEntrySearch 11)
(defconstant $kSelectRegistryCStrEntryLookup 12)
(defconstant $kSelectRegistryEntryToPathSize 13)
(defconstant $kSelectRegistryCStrEntryToPath 14)
(defconstant $kSelectRegistryCStrEntryToName 15)
(defconstant $kSelectRegistryPropertyCreate 16)
(defconstant $kSelectRegistryPropertyDelete 17)
(defconstant $kSelectRegistryPropertyRename 18)
(defconstant $kSelectRegistryPropertyIterateCreate 19)
(defconstant $kSelectRegistryPropertyIterateDispose 20)
(defconstant $kSelectRegistryPropertyIterate 21)
(defconstant $kSelectRegistryPropertyGetSize 22)
(defconstant $kSelectRegistryPropertyGet 23)
(defconstant $kSelectRegistryPropertySet 24)
(defconstant $kSelectRegistryEntryGetMod 25)
(defconstant $kSelectRegistryEntrySetMod 26)
(defconstant $kSelectRegistryPropertyGetMod 27)
(defconstant $kSelectRegistryPropertySetMod 28)
(defconstant $kSelectRegistryEntryMod 29)
(defconstant $kSelectRegistryEntryPropertyMod 30);  if you add more selectors here, remember to change 'kSelectRegistryHighestSelector' below

(defconstant $kSelectRegistryHighestSelector 30)
;  ///////////////////////
; //
; // Entry Management
; //
; /////////////////////// 
; -------------------------------
;  * EntryID handling
;  
; 
;  * Initialize an EntryID to a known invalid state
;  *   note: invalid != uninitialized
;  
; 
;  *  RegistryEntryIDInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Compare EntryID's for equality or if invalid
;  *
;  * If a NULL value is given for either id1 or id2, the other id 
;  * is compared with an invalid ID.  If both are NULL, the id's 
;  * are consided equal (result = true). 
;  
; 
;  *  RegistryEntryIDCompare()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Copy an EntryID
;  
; 
;  *  RegistryEntryIDCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Free an ID so it can be reused.
;  
; 
;  *  RegistryEntryIDDispose()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; -------------------------------
;  * Adding and removing entries
;  *
;  * If (parentEntry) is NULL, the name is assumed
;  * to be a rooted path. It is rooted to an anonymous, unnamed root.
;  
; 
;  *  RegistryCStrEntryCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryEntryDelete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryEntryCopy()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; ---------------------------
;  * Traversing the namespace
;  *
;  * To support arbitrary namespace implementations in the future,
;  * I have hidden the form that the place pointer takes.  The previous
;  * interface exposed the place pointer by specifying it as a
;  * RegEntryID.
;  *
;  * I have also removed any notion of returning the entries
;  * in a particular order, because an implementation might
;  * return the names in semi-random order.  Many name service
;  * implementations will store the names in a hashed lookup
;  * table.
;  *
;  * Writing code to traverse some set of names consists of
;  * a call to begin the iteration, the iteration loop, and
;  * a call to end the iteration.  The begin call initializes
;  * the iteration cookie data structure.  The call to end the 
;  * iteration should be called even in the case of error so 
;  * that allocated data structures can be freed.
;  *
;  *  Create(...)
;  *  do {
;  *      Iterate(...);
;  *  } while (!done);
;  *  Dispose(...);
;  *
;  * This is the basic code structure for callers of the iteration
;  * interface.
;  

(def-mactype :RegEntryIter (find-mactype '(:pointer :OpaqueRegEntryIter)))
;  
;  * create/dispose the iterator structure
;  *   defaults to root with relationship = kRegIterDescendants
;  
; 
;  *  RegistryEntryIterateCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryEntryIterateDispose()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
;  
;  * set Entry Iterator to specified entry
;  
; 
;  *  RegistryEntryIterateSet()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Return each value of the iteration
;  *
;  * return entries related to the current entry
;  * with the specified relationship
;  
; 
;  *  RegistryEntryIterate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * return entries with the specified property
;  *
;  * A NULL RegPropertyValue pointer will return an
;  * entry with the property containing any value.
;  
; 
;  *  RegistryEntrySearch()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; --------------------------------
;  * Find a name in the namespace
;  *
;  * This is the fast lookup mechanism.
;  * NOTE:  A reverse lookup mechanism
;  *    has not been provided because
;  *        some name services may not
;  *        provide a fast, general reverse
;  *        lookup.
;  
; 
;  *  RegistryCStrEntryLookup()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; ---------------------------------------------
;  * Convert an entry to a rooted name string
;  *
;  * A utility routine to turn an Entry ID
;  * back into a name string.
;  
; 
;  *  RegistryEntryToPathSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryCStrEntryToPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Parse a path name.
;  *
;  * Retrieve the last component of the path, and
;  * return a spec for the parent.
;  
; 
;  *  RegistryCStrEntryToName()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
;  //////////////////////////////////////////////////////
; //
; // Property Management
; //
; ////////////////////////////////////////////////////// 
; -------------------------------
;  * Adding and removing properties
;  
; 
;  *  RegistryPropertyCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryPropertyDelete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryPropertyRename()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; ---------------------------
;  * Traversing the Properties of a name
;  *
;  

(def-mactype :RegPropertyIter (find-mactype '(:pointer :OpaqueRegPropertyIter)))
; 
;  *  RegistryPropertyIterateCreate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryPropertyIterateDispose()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryPropertyIterate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Get the value of the specified property for the specified entry.
;  *
;  
; 
;  *  RegistryPropertyGetSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * (*propertySize) is the maximum size of the value returned in the buffer
;  * pointed to by (propertyValue).  Upon return, (*propertySize) is the size of the
;  * value returned.
;  
; 
;  *  RegistryPropertyGet()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryPropertySet()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
;  //////////////////////////////////////////////////////
; //
; // Modifier Management
; //
; ////////////////////////////////////////////////////// 
; 
;  * Modifiers describe special characteristics of names
;  * and properties.  Modifiers might be supported for
;  * some names and not others.
;  * 
;  * Device Drivers should not rely on functionality
;  * specified as a modifier.  These interfaces
;  * are for use in writing Experts.
;  
; 
;  * Get and Set operators for entry modifiers
;  
; 
;  *  RegistryEntryGetMod()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryEntrySetMod()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Get and Set operators for property modifiers
;  
; 
;  *  RegistryPropertyGetMod()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  *  RegistryPropertySetMod()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Iterator operator for entry modifier search
;  
; 
;  *  RegistryEntryMod()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; 
;  * Iterator operator for entries with matching 
;  * property modifiers
;  
; 
;  *  RegistryEntryPropertyMod()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NameRegistryLib 1.0 and later
;  
; #pragma options align=reset

; #endif /* __NAMEREGISTRY__ */


(provide-interface "NameRegistry")