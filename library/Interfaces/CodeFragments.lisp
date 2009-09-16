(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CodeFragments.h"
; at Sunday July 2,2006 7:23:19 pm.
; 
;      File:       CarbonCore/CodeFragments.h
;  
;      Contains:   Public Code Fragment Manager Interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1992-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; 
;    ¥
;    ===========================================================================================
;    The Code Fragment Manager API
;    =============================
; 
; #ifndef __CODEFRAGMENTS__
; #define __CODEFRAGMENTS__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __CFBUNDLE__

(require-interface "CoreFoundation/CFBundle")

; #endif

; #ifndef __FILES__
#| #|
#include <CarbonCoreFiles.h>
#endif
|#
 |#
; #ifndef __MULTIPROCESSING__

(require-interface "CarbonCore/Multiprocessing")

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
; #pragma options align=mac68k
; 
;    ¤
;    ===========================================================================================
;    General Types and Constants
;    ===========================
; 

(defconstant $kCFragResourceType :|cfrg|)
(defconstant $kCFragResourceID 0)
(defconstant $kCFragLibraryFileType :|shlb|)
(defconstant $kCFragAllFileTypes #xFFFFFFFF)

(def-mactype :CFragArchitecture (find-mactype ':OSType))
;  Values for type CFragArchitecture.

(defconstant $kPowerPCCFragArch :|pwpc|)
(defconstant $kMotorola68KCFragArch :|m68k|)
(defconstant $kAnyCFragArch #x3F3F3F3F)

; #if TARGET_CPU_PPC

(defconstant $kCompiledCFragArch :|pwpc|)

; #endif  /* TARGET_CPU_PPC */


; #if TARGET_CPU_X86
#| 
(defconstant $kCompiledCFragArch :|none|)
 |#

; #endif  /* TARGET_CPU_X86 */


(def-mactype :CFragVersionNumber (find-mactype ':UInt32))

(defconstant $kNullCFragVersion 0)
(defconstant $kWildcardCFragVersion #xFFFFFFFF)

(def-mactype :CFragUsage (find-mactype ':UInt8))
;  Values for type CFragUsage.

(defconstant $kImportLibraryCFrag 0)            ;  Standard CFM import library.

(defconstant $kApplicationCFrag 1)              ;  MacOS application.

(defconstant $kDropInAdditionCFrag 2)           ;  Application or library private extension/plug-in

(defconstant $kStubLibraryCFrag 3)              ;  Import library used for linking only

(defconstant $kWeakStubLibraryCFrag 4)          ;  Import library used for linking only and will be automatically weak linked


(defconstant $kIsCompleteCFrag 0)               ;  A "base" fragment, not an update.

(defconstant $kFirstCFragUpdate 1)              ;  The first update, others are numbered 2, 3, ...


(defconstant $kCFragGoesToEOF 0)

(def-mactype :CFragLocatorKind (find-mactype ':UInt8))
;  Values for type CFragLocatorKind.

(defconstant $kMemoryCFragLocator 0)            ;  Container is in memory.

(defconstant $kDataForkCFragLocator 1)          ;  Container is in a file's data fork.

(defconstant $kResourceCFragLocator 2)          ;  Container is in a file's resource fork.

(defconstant $kNamedFragmentCFragLocator 4)     ;  ! Reserved for possible future use!

(defconstant $kCFBundleCFragLocator 5)          ;  Container is in the executable of a CFBundle

(defconstant $kCFBundlePreCFragLocator 6)       ;  passed to init routines in lieu of kCFBundleCFragLocator

; 
;    --------------------------------------------------------------------------------------
;    A 'cfrg' resource consists of a header followed by a sequence of variable length
;    members.  The constant kDefaultCFragNameLen only provides for a legal ANSI declaration
;    and for a reasonable display in a debugger.  The actual name field is cut to fit.
;    There may be "extensions" after the name, the memberSize field includes them.  The
;    general form of an extension is a 16 bit type code followed by a 16 bit size in bytes.
;    Only one standard extension type is defined at present, it is used by SOM's searching
;    mechanism.
; 
(defrecord CFragUsage1Union
   (:variant
                                                ;  ! Meaning differs depending on value of "usage".
   (
   (appStackSize :UInt32)
   )
                                                ;  If the fragment is an application. (Not used by CFM!)
   )
)

;type name? (%define-record :CFragUsage1Union (find-record-descriptor ':CFragUsage1Union))
(defrecord CFragUsage2Union
   (:variant
                                                ;  ! Meaning differs depending on value of "usage".
   (
   (appSubdirID :SInt16)
   )
                                                ;  If the fragment is an application.
   (
   (libFlags :UInt16)
   )
                                                ;  If the fragment is an import library.
   )
)

;type name? (%define-record :CFragUsage2Union (find-record-descriptor ':CFragUsage2Union))
;  Bit masks for the CFragUsage2Union libFlags variant.

(defconstant $kCFragLibUsageMapPrivatelyMask 1) ;  Put container in app heap if necessary.

(defrecord CFragWhere1Union
   (:variant
                                                ;  ! Meaning differs depending on value of "where".
   (
   (spaceID :UInt32)
   )
                                                ;  If the fragment is in memory.  (Actually an AddressSpaceID.)
   )
)

;type name? (%define-record :CFragWhere1Union (find-record-descriptor ':CFragWhere1Union))
(defrecord CFragWhere2Union
   (:variant
                                                ;  ! Meaning differs depending on value of "where".
   (
   (reserved :UInt16)
   )
   )
)

;type name? (%define-record :CFragWhere2Union (find-record-descriptor ':CFragWhere2Union))

(defconstant $kDefaultCFragNameLen 16)
(defrecord CFragResourceMember
   (architecture :OSType)
   (reservedA :UInt16)                          ;  ! Must be zero!
   (reservedB :UInt8)                           ;  ! Must be zero!
   (updateLevel :UInt8)
   (currentVersion :UInt32)
   (oldDefVersion :UInt32)
   (uUsage1 :CFragUsage1Union)
   (uUsage2 :CFragUsage2Union)
   (usage :UInt8)
   (where :UInt8)
   (offset :UInt32)
   (length :UInt32)
   (uWhere1 :CFragWhere1Union)
   (uWhere2 :CFragWhere2Union)
   (extensionCount :UInt16)                     ;  The number of extensions beyond the name.
   (memberSize :UInt16)                         ;  Size in bytes, includes all extensions.
   (name (:array :UInt8 16))                    ;  ! Actually a sized PString.
)

;type name? (%define-record :CFragResourceMember (find-record-descriptor ':CFragResourceMember))

(def-mactype :CFragResourceMemberPtr (find-mactype '(:pointer :CFragResourceMember)))
(defrecord CFragResourceExtensionHeader
   (extensionKind :UInt16)
   (extensionSize :UInt16)
)

;type name? (%define-record :CFragResourceExtensionHeader (find-record-descriptor ':CFragResourceExtensionHeader))

(def-mactype :CFragResourceExtensionHeaderPtr (find-mactype '(:pointer :CFragResourceExtensionHeader)))
(defrecord CFragResourceSearchExtension
   (header :CFragResourceExtensionHeader)
   (libKind :OSType)
   (qualifiers (:array :UInt8 1))               ;  ! Actually four PStrings.
)

;type name? (%define-record :CFragResourceSearchExtension (find-record-descriptor ':CFragResourceSearchExtension))

(def-mactype :CFragResourceSearchExtensionPtr (find-mactype '(:pointer :CFragResourceSearchExtension)))

(defconstant $kCFragResourceSearchExtensionKind #x30EE)
(defrecord CFragResource
   (reservedA :UInt32)                          ;  ! Must be zero!
   (reservedB :UInt32)                          ;  ! Must be zero!
   (reservedC :UInt16)                          ;  ! Must be zero!
   (version :UInt16)
   (reservedD :UInt32)                          ;  ! Must be zero!
   (reservedE :UInt32)                          ;  ! Must be zero!
   (reservedF :UInt32)                          ;  ! Must be zero!
   (reservedG :UInt32)                          ;  ! Must be zero!
   (reservedH :UInt16)                          ;  ! Must be zero!
   (memberCount :UInt16)
   (firstMember :CFragResourceMember)
)

;type name? (%define-record :CFragResource (find-record-descriptor ':CFragResource))

(def-mactype :CFragResourcePtr (find-mactype '(:pointer :CFragResource)))

(def-mactype :CFragResourceHandle (find-mactype '(:handle :CFragResource)))

(defconstant $kCurrCFragResourceVersion 1)
; #define AlignToFour(aValue) (((aValue) + 3) & ~3)
; #define CFMOffsetOf(structure,field) ((UInt32)&((structure *) 0)->field)
; #define kBaseCFragResourceMemberSize    (CFMOffsetOf ( CFragResourceMember, name ) )
; #define kBaseCFragResourceSize          (CFMOffsetOf ( CFragResource, firstMember.name ) )
; #define NextCFragResourceMemberPtr(aMemberPtr)          ((CFragResourceMemberPtr) ((BytePtr)aMemberPtr + aMemberPtr->memberSize))
; #define FirstCFragResourceExtensionPtr(aMemberPtr)                                                  ((CFragResourceExtensionHeaderPtr) ((BytePtr)aMemberPtr +                                                                       AlignToFour ( kBaseCFragResourceMemberSize +                                                              aMemberPtr->name[0] + 1 ) ))
; #define NextCFragResourceExtensionPtr(anExtensionPtr)                           ((CFragResourceExtensionHeaderPtr) ((BytePtr)anExtensionPtr +                                               ((CFragResourceExtensionHeaderPtr)anExtensionPtr)->extensionSize ))
; #define FirstCFragResourceSearchQualifier(searchExtensionPtr)                           ((StringPtr) ((BytePtr)searchExtensionPtr +                                                   CFMOffsetOf ( CFragResourceSearchExtension, qualifiers ) ))
; #define NextCFragResourceSearchQualifier(searchQualifierPtr)            ((StringPtr) ((BytePtr)searchQualifierPtr + searchQualifierPtr[0] + 1))

(def-mactype :CFragContextID (find-mactype ':MPProcessID))

(def-mactype :CFragConnectionID (find-mactype '(:pointer :OpaqueCFragConnectionID)))

(def-mactype :CFragClosureID (find-mactype '(:pointer :OpaqueCFragClosureID)))

(def-mactype :CFragContainerID (find-mactype '(:pointer :OpaqueCFragContainerID)))

(def-mactype :CFragLoadOptions (find-mactype ':UInt32))
;  Values for type CFragLoadOptions.

(defconstant $kReferenceCFrag 1)                ;  Try to use existing copy, increment reference counts.

(defconstant $kFindCFrag 2)                     ;  Try find an existing copy, do not increment reference counts.

(defconstant $kPrivateCFragCopy 5)              ;  Prepare a new private copy.  (kReferenceCFrag | 0x0004)


(defconstant $kUnresolvedCFragSymbolAddress 0)

(def-mactype :CFragSymbolClass (find-mactype ':UInt8))
;  Values for type CFragSymbolClass.

(defconstant $kCodeCFragSymbol 0)
(defconstant $kDataCFragSymbol 1)
(defconstant $kTVectorCFragSymbol 2)
(defconstant $kTOCCFragSymbol 3)
(defconstant $kGlueCFragSymbol 4)
; 
;    ¤
;    ===========================================================================================
;    Macros and Functions
;    ====================
; 
; #define CFragHasFileLocation(where)         ( ((where) == kDataForkCFragLocator) || ((where) == kResourceCFragLocator) )
; 
;  *  GetSharedLibrary()
;  *  
;  *  Discussion:
;  *    The connID, mainAddr, and errMessage parameters may be NULL with
;  *    MacOS 8.5 and later. Passing NULL as those parameters when
;  *    running Mac OS 8.1 and earlier systems will corrupt low-memory.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CFragManager 1.0 and later
;  

(deftrap-inline "_GetSharedLibrary" 
   ((libName (:pointer :UInt8))
    (archType :OSType)
    (options :UInt32)
    (connID (:pointer :CFRAGCONNECTIONID))
    (mainAddr (:pointer :Ptr))
    (errMessage (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetDiskFragment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CFragManager 1.0 and later
;  

(deftrap-inline "_GetDiskFragment" 
   ((fileSpec (:pointer :FSSpec))
    (offset :UInt32)
    (length :UInt32)
    (fragName (:pointer :UInt8))                ;  can be NULL 
    (options :UInt32)
    (connID (:pointer :CFRAGCONNECTIONID))      ;  can be NULL 
    (mainAddr (:pointer :Ptr))                  ;  can be NULL 
    (errMessage (:pointer :STR255))             ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetMemFragment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CFragManager 1.0 and later
;  

(deftrap-inline "_GetMemFragment" 
   ((memAddr :pointer)
    (length :UInt32)
    (fragName (:pointer :UInt8))                ;  can be NULL 
    (options :UInt32)
    (connID (:pointer :CFRAGCONNECTIONID))      ;  can be NULL 
    (mainAddr (:pointer :Ptr))                  ;  can be NULL 
    (errMessage (:pointer :STR255))             ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CloseConnection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CFragManager 1.0 and later
;  

(deftrap-inline "_CloseConnection" 
   ((connID (:pointer :CFRAGCONNECTIONID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FindSymbol()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CFragManager 1.0 and later
;  

(deftrap-inline "_FindSymbol" 
   ((connID (:pointer :OpaqueCFragConnectionID))
    (symName (:pointer :STR255))
    (symAddr (:pointer :Ptr))                   ;  can be NULL 
    (symClass (:pointer :CFRAGSYMBOLCLASS))     ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CountSymbols()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CFragManager 1.0 and later
;  

(deftrap-inline "_CountSymbols" 
   ((connID (:pointer :OpaqueCFragConnectionID))
    (symCount (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetIndSymbol()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CFragManager 1.0 and later
;  

(deftrap-inline "_GetIndSymbol" 
   ((connID (:pointer :OpaqueCFragConnectionID))
    (symIndex :signed-long)
    (symName (:pointer :STR255))                ;  can be NULL 
    (symAddr (:pointer :Ptr))                   ;  can be NULL 
    (symClass (:pointer :CFRAGSYMBOLCLASS))     ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;    ¤
;    ===========================================================================================
;    Initialization & Termination Routines
;    =====================================
; 
; 
;    -----------------------------------------------------------------------------------------
;    A fragment's initialization and termination routines are called when a new incarnation of
;    the fragment is created or destroyed, respectively.  Exactly when this occurs depends on
;    what kinds of section sharing the fragment has and how the fragment is prepared.  Import
;    libraries have at most one incarnation per process.  Fragments prepared with option
;    kPrivateCFragCopy may have many incarnations per process.
;    The initialization function is passed a pointer to an initialization information structure
;    and returns an OSErr.  If an initialization function returns a non-zero value the entire
;    closure of which it is a part fails.  The C prototype for an initialization function is:
;         OSErr   CFragInitFunction   ( const CFragInitBlock *    initBlock );
;    The termination procedure takes no parameters and returns nothing.  The C prototype for a
;    termination procedure is:
;         void    CFragTermProcedure  ( void );
;    Note that since the initialization and termination routines are themselves "CFM"-style
;    routines whether or not they have the "pascal" keyword is irrelevant.
; 
; 
;    -----------------------------------------------------------------------------------------
;    ! Note:
;    ! The "System7" portion of these type names was introduced during the evolution towards
;    ! the now defunct Copland version of Mac OS.  Copland was to be called System 8 and there
;    ! were slightly different types for System 7 and System 8.  The "generic" type names were
;    ! conditionally defined for the desired target system.
;    ! Always use the generic types, e.g. CFragInitBlock!  The "System7" names have been kept
;    ! only to avoid perturbing code that (improperly) used the target specific type.
; 
(defrecord CFragSystem7MemoryLocator
   (address (:pointer :void))
   (length :UInt32)
   (inPlace :Boolean)
   (reservedA :UInt8)                           ;  ! Must be zero!
   (reservedB :UInt16)                          ;  ! Must be zero!
)

;type name? (%define-record :CFragSystem7MemoryLocator (find-record-descriptor ':CFragSystem7MemoryLocator))
(defrecord CFragSystem7DiskFlatLocator
   (fileSpec (:pointer :FSSpec))
   (offset :UInt32)
   (length :UInt32)
)

;type name? (%define-record :CFragSystem7DiskFlatLocator (find-record-descriptor ':CFragSystem7DiskFlatLocator))
;  ! This must have a file specification at the same offset as a disk flat locator!
(defrecord CFragSystem7SegmentedLocator
   (fileSpec (:pointer :FSSpec))
   (rsrcType :OSType)
   (rsrcID :SInt16)
   (reservedA :UInt16)                          ;  ! Must be zero!
)

;type name? (%define-record :CFragSystem7SegmentedLocator (find-record-descriptor ':CFragSystem7SegmentedLocator))
; 
;    The offset and length for a "Bundle" locator refers to the offset in
;    the CFM executable contained by the bundle.
; 
(defrecord CFragCFBundleLocator
   (fragmentBundle (:pointer :__CFBundle))      ;  Do not call CFRelease on this bundle!
   (offset :UInt32)
   (length :UInt32)
)

;type name? (%define-record :CFragCFBundleLocator (find-record-descriptor ':CFragCFBundleLocator))
(defrecord CFragSystem7Locator
   (where :SInt32)
   (:variant
   (
   (onDisk :CFragSystem7DiskFlatLocator)
   )
   (
   (inMem :CFragSystem7MemoryLocator)
   )
   (
   (inSegs :CFragSystem7SegmentedLocator)
   )
   (
   (inBundle :CFragCFBundleLocator)
   )
   )
)

;type name? (%define-record :CFragSystem7Locator (find-record-descriptor ':CFragSystem7Locator))

(def-mactype :CFragSystem7LocatorPtr (find-mactype '(:pointer :CFragSystem7Locator)))
(defrecord CFragSystem7InitBlock
   (contextID (:pointer :OpaqueMPProcessID))
   (closureID (:pointer :OpaqueCFragClosureID))
   (connectionID (:pointer :OpaqueCFragConnectionID))
   (fragLocator :CFragSystem7Locator)
   (libName (:pointer :UInt8))
   (reservedA :UInt32)                          ;  ! Must be zero!
)

;type name? (%define-record :CFragSystem7InitBlock (find-record-descriptor ':CFragSystem7InitBlock))

(def-mactype :CFragSystem7InitBlockPtr (find-mactype '(:pointer :CFragSystem7InitBlock)))

(%define-record :CFragInitBlock (find-record-descriptor ':CFragSystem7InitBlock))

(def-mactype :CFragInitBlockPtr (find-mactype ':CFragSystem7InitBlockPtr))
;  These init/term routine types are only of value to CFM itself.

(def-mactype :CFragInitFunction (find-mactype ':pointer)); (const CFragInitBlock * initBlock)

(def-mactype :CFragTermProcedure (find-mactype ':pointer)); (void)
;  For use by init routines. If you get a BundlePreLocator, convert it to a CFBundleLocator with this
; 
;  *  ConvertBundlePreLocator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ConvertBundlePreLocator" 
   ((initBlockLocator (:pointer :CFragSystem7Locator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;    ¤
;    ===========================================================================================
;    Old Name Spellings
;    ==================
; 
; 
;    -------------------------------------------------------------------------------------------
;    We've tried to reduce the risk of name collisions in the future by introducing the phrase
;    "CFrag" into constant and type names.  The old names are defined below in terms of the new.
; 

(defconstant $kLoadCFrag 1)

; #if OLDROUTINENAMES
#| 
; #define IsFileLocation      CFragHasFileLocation

(def-mactype :ConnectionID (find-mactype ':CFragConnectionID))

(def-mactype :LoadFlags (find-mactype ':UInt32))

(def-mactype :SymClass (find-mactype ':UInt8))

(%define-record :InitBlock (find-record-descriptor ':CFragSystem7InitBlock))

(def-mactype :InitBlockPtr (find-mactype ':CFragInitBlockPtr))

(%define-record :MemFragment (find-record-descriptor ':CFragSystem7MemoryLocator))

(%define-record :DiskFragment (find-record-descriptor ':CFragSystem7DiskFlatLocator))

(%define-record :SegmentedFragment (find-record-descriptor ':CFragSystem7SegmentedLocator))

(%define-record :FragmentLocator (find-record-descriptor ':CFragSystem7Locator))

(def-mactype :FragmentLocatorPtr (find-mactype ':CFragSystem7LocatorPtr))

(%define-record :CFragHFSMemoryLocator (find-record-descriptor ':CFragSystem7MemoryLocator))

(%define-record :CFragHFSDiskFlatLocator (find-record-descriptor ':CFragSystem7DiskFlatLocator))

(%define-record :CFragHFSSegmentedLocator (find-record-descriptor ':CFragSystem7SegmentedLocator))

(%define-record :CFragHFSLocator (find-record-descriptor ':CFragSystem7Locator))

(def-mactype :CFragHFSLocatorPtr (find-mactype ':CFragSystem7LocatorPtr))

(defconstant $kPowerPCArch :|pwpc|)
(defconstant $kMotorola68KArch :|m68k|)
(defconstant $kAnyArchType #x3F3F3F3F)
(defconstant $kNoLibName 0)
(defconstant $kNoConnectionID 0)
(defconstant $kLoadLib 1)
(defconstant $kFindLib 2)
(defconstant $kNewCFragCopy 5)
(defconstant $kLoadNewCopy 5)
(defconstant $kUseInPlace #x80)
(defconstant $kCodeSym 0)
(defconstant $kDataSym 1)
(defconstant $kTVectSym 2)
(defconstant $kTOCSym 3)
(defconstant $kGlueSym 4)
(defconstant $kInMem 0)
(defconstant $kOnDiskFlat 1)
(defconstant $kOnDiskSegmented 2)
(defconstant $kIsLib 0)
(defconstant $kIsApp 1)
(defconstant $kIsDropIn 2)
(defconstant $kFullLib 0)
(defconstant $kUpdateLib 1)
(defconstant $kWholeFork 0)
(defconstant $kCFMRsrcType :|cfrg|)
(defconstant $kCFMRsrcID 0)
(defconstant $kSHLBFileType :|shlb|)
(defconstant $kUnresolvedSymbolAddress 0)

(defconstant $kPowerPC :|pwpc|)
(defconstant $kMotorola68K :|m68k|)
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CODEFRAGMENTS__ */


(provide-interface "CodeFragments")