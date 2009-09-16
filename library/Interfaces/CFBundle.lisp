(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFBundle.h"
; at Sunday July 2,2006 7:23:00 pm.
; 	CFBundle.h
; 	Copyright (c) 1999-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFBUNDLE__)
(defconstant $__COREFOUNDATION_CFBUNDLE__ 1)
; #define __COREFOUNDATION_CFBUNDLE__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFURL")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFBundleRef (find-mactype '(:pointer :__CFBundle)))

(def-mactype :CFPlugInRef (find-mactype '(:pointer :__CFBundle)))
;  ===================== Standard Info.plist keys ===================== 
(def-mactype :kCFBundleInfoDictionaryVersionKey (find-mactype ':CFStringRef))
;  The version of the Info.plist format 
(def-mactype :kCFBundleExecutableKey (find-mactype ':CFStringRef))
;  The name of the executable in this bundle (if any) 
(def-mactype :kCFBundleIdentifierKey (find-mactype ':CFStringRef))
;  The bundle identifier (for CFBundleGetBundleWithIdentifier()) 
(def-mactype :kCFBundleVersionKey (find-mactype ':CFStringRef))
;  The version number of the bundle.  Clients should use CFBundleGetVersionNumber() instead of accessing this key directly
; since that function will properly convert a version number in string format into its interger representation. 
(def-mactype :kCFBundleDevelopmentRegionKey (find-mactype ':CFStringRef))
;  The name of the development language of the bundle. 
(def-mactype :kCFBundleNameKey (find-mactype ':CFStringRef))
;  The human-readable name of the bundle.  This key is often found in the InfoPlist.strings since it is usually localized. 

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
(def-mactype :kCFBundleLocalizationsKey (find-mactype ':CFStringRef))
;  Allows an unbundled application that handles localization itself to specify which localizations it has available. 

; #endif

;  ===================== Finding Bundles ===================== 

(deftrap-inline "_CFBundleGetMainBundle" 
   (
   )
   (:pointer :__CFBundle)
() )

(deftrap-inline "_CFBundleGetBundleWithIdentifier" 
   ((bundleID (:pointer :__CFString))
   )
   (:pointer :__CFBundle)
() )
;  A bundle can name itself by providing a key in the info dictionary. 
;  This facility is meant to allow bundle-writers to get hold of their 
;  bundle from their code without having to know where it was on the disk. 
;  This is meant to be a replacement mechanism for +bundleForClass: users. 
;  Note that this does not search for bundles on the disk; it will locate 
;  only bundles already loaded or otherwise known to the current process. 

(deftrap-inline "_CFBundleGetAllBundles" 
   (
   )
   (:pointer :__CFArray)
() )
;  This is potentially expensive.  Use with care. 
;  ===================== Creating Bundles ===================== 

(deftrap-inline "_CFBundleGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFBundleCreate" 
   ((allocator (:pointer :__CFAllocator))
    (bundleURL (:pointer :__CFURL))
   )
   (:pointer :__CFBundle)
() )
;  Might return an existing instance with the ref-count bumped. 

(deftrap-inline "_CFBundleCreateBundlesFromDirectory" 
   ((allocator (:pointer :__CFAllocator))
    (directoryURL (:pointer :__CFURL))
    (bundleType (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )
;  Create instances for all bundles in the given directory matching the given 
;  type (or all of them if bundleType is NULL) 
;  ==================== Basic Bundle Info ==================== 

(deftrap-inline "_CFBundleCopyBundleURL" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleGetValueForInfoDictionaryKey" 
   ((bundle (:pointer :__CFBundle))
    (key (:pointer :__CFString))
   )
   (:pointer :void)
() )
;  Returns a localized value if available, otherwise the global value. 
;  This is the recommended function for examining the info dictionary. 

(deftrap-inline "_CFBundleGetInfoDictionary" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFDictionary)
() )
;  This is the global info dictionary.  Note that CFBundle may add 
;  extra keys to the dictionary for its own use. 

(deftrap-inline "_CFBundleGetLocalInfoDictionary" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFDictionary)
() )
;  This is the localized info dictionary. 

(deftrap-inline "_CFBundleGetPackageInfo" 
   ((bundle (:pointer :__CFBundle))
    (packageType (:pointer :UInt32))
    (packageCreator (:pointer :UInt32))
   )
   nil
() )

(deftrap-inline "_CFBundleGetIdentifier" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFBundleGetVersionNumber" 
   ((bundle (:pointer :__CFBundle))
   )
   :UInt32
() )

(deftrap-inline "_CFBundleGetDevelopmentRegion" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFBundleCopySupportFilesDirectoryURL" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleCopyResourcesDirectoryURL" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleCopyPrivateFrameworksURL" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleCopySharedFrameworksURL" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleCopySharedSupportURL" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleCopyBuiltInPlugInsURL" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFURL)
() )
;  ------------- Basic Bundle Info without a CFBundle instance ------------- 
;  This API is provided to enable developers to retrieve basic information 
;  about a bundle without having to create an instance of CFBundle. 
;  Because of caching behavior when a CFBundle instance exists, it will be faster 
;  to actually create a CFBundle if you need to retrieve multiple pieces of info. 

(deftrap-inline "_CFBundleCopyInfoDictionaryInDirectory" 
   ((bundleURL (:pointer :__CFURL))
   )
   (:pointer :__CFDictionary)
() )

(deftrap-inline "_CFBundleGetPackageInfoInDirectory" 
   ((url (:pointer :__CFURL))
    (packageType (:pointer :UInt32))
    (packageCreator (:pointer :UInt32))
   )
   :Boolean
() )
;  ==================== Resource Handling API ==================== 

(deftrap-inline "_CFBundleCopyResourceURL" 
   ((bundle (:pointer :__CFBundle))
    (resourceName (:pointer :__CFString))
    (resourceType (:pointer :__CFString))
    (subDirName (:pointer :__CFString))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleCopyResourceURLsOfType" 
   ((bundle (:pointer :__CFBundle))
    (resourceType (:pointer :__CFString))
    (subDirName (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )

(deftrap-inline "_CFBundleCopyLocalizedString" 
   ((bundle (:pointer :__CFBundle))
    (key (:pointer :__CFString))
    (value (:pointer :__CFString))
    (tableName (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
; #define CFCopyLocalizedString(key, comment)             CFBundleCopyLocalizedString(CFBundleGetMainBundle(), (key), (key), NULL)
; #define CFCopyLocalizedStringFromTable(key, tbl, comment)             CFBundleCopyLocalizedString(CFBundleGetMainBundle(), (key), (key), (tbl))
; #define CFCopyLocalizedStringFromTableInBundle(key, tbl, bundle, comment)             CFBundleCopyLocalizedString((bundle), (key), (key), (tbl))
; #define CFCopyLocalizedStringWithDefaultValue(key, tbl, bundle, value, comment)             CFBundleCopyLocalizedString((bundle), (key), (value), (tbl))
;  ------------- Resource Handling without a CFBundle instance ------------- 
;  This API is provided to enable developers to use the CFBundle resource 
;  searching policy without having to create an instance of CFBundle. 
;  Because of caching behavior when a CFBundle instance exists, it will be faster 
;  to actually create a CFBundle if you need to access several resources. 

(deftrap-inline "_CFBundleCopyResourceURLInDirectory" 
   ((bundleURL (:pointer :__CFURL))
    (resourceName (:pointer :__CFString))
    (resourceType (:pointer :__CFString))
    (subDirName (:pointer :__CFString))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleCopyResourceURLsOfTypeInDirectory" 
   ((bundleURL (:pointer :__CFURL))
    (resourceType (:pointer :__CFString))
    (subDirName (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )
;  =========== Localization-specific Resource Handling API =========== 
;  This API allows finer-grained control over specific localizations,  
;  as distinguished from the above API, which always uses the user's   
;  preferred localizations for the bundle in the current app context.  

(deftrap-inline "_CFBundleCopyBundleLocalizations" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFArray)
() )
;  Lists the localizations that a bundle contains.  

(deftrap-inline "_CFBundleCopyPreferredLocalizationsFromArray" 
   ((locArray (:pointer :__CFArray))
   )
   (:pointer :__CFArray)
() )
;  Given an array of possible localizations, returns the one or more 
;  of them that CFBundle would use in the current application context. 
;  To determine the localizations that would be used for a particular 
;  bundle in the current application context, apply this function to the 
;  result of CFBundleCopyBundleLocalizations.  

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

(deftrap-inline "_CFBundleCopyLocalizationsForPreferences" 
   ((locArray (:pointer :__CFArray))
    (prefArray (:pointer :__CFArray))
   )
   (:pointer :__CFArray)
() )
;  Given an array of possible localizations, returns the one or more of 
;  them that CFBundle would use, without reference to the current application 
;  context, if the user's preferred localizations were given by prefArray. 
;  If prefArray is NULL, the current user's actual preferred localizations will 
;  be used. This is not the same as CFBundleCopyPreferredLocalizationsFromArray, 
;  because that function takes the current application context into account. 
;  To determine the localizations that another application would use, apply 
;  this function to the result of CFBundleCopyBundleLocalizations.  

; #endif


(deftrap-inline "_CFBundleCopyResourceURLForLocalization" 
   ((bundle (:pointer :__CFBundle))
    (resourceName (:pointer :__CFString))
    (resourceType (:pointer :__CFString))
    (subDirName (:pointer :__CFString))
    (localizationName (:pointer :__CFString))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleCopyResourceURLsOfTypeForLocalization" 
   ((bundle (:pointer :__CFBundle))
    (resourceType (:pointer :__CFString))
    (subDirName (:pointer :__CFString))
    (localizationName (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  =================== Unbundled application info ===================== 
;  This API is provided to enable developers to retrieve bundle-related 
;  information about an application that may be bundled or unbundled.   

(deftrap-inline "_CFBundleCopyInfoDictionaryForURL" 
   ((url (:pointer :__CFURL))
   )
   (:pointer :__CFDictionary)
() )
;  For a directory URL, this is equivalent to CFBundleCopyInfoDictionaryInDirectory. 
;  For a plain file URL representing an unbundled application, this will attempt to read 
;  an info dictionary either from the (__TEXT, __info_plist) section (for a Mach-o file) 
;  or from a 'plst' resource.  

(deftrap-inline "_CFBundleCopyLocalizationsForURL" 
   ((url (:pointer :__CFURL))
   )
   (:pointer :__CFArray)
() )
;  For a directory URL, this is equivalent to calling CFBundleCopyBundleLocalizations 
;  on the corresponding bundle.  For a plain file URL representing an unbundled application, 
;  this will attempt to determine its localizations using the CFBundleLocalizations and 
;  CFBundleDevelopmentRegion keys in the dictionary returned by CFBundleCopyInfoDictionaryForURL,
;  or a 'vers' resource if those are not present.  

; #endif

;  ==================== Primitive Code Loading API ==================== 
;  This API abstracts the various different executable formats supported on 
;  various platforms.  It can load DYLD, CFM, or DLL shared libraries (on their 
;  appropriate platforms) and gives a uniform API for looking up functions. 
;  Note that Cocoa-based bundles containing Objective-C or Java code must 
;  be loaded with NSBundle, not CFBundle.  Once they are loaded, however, 
;  either CFBundle or NSBundle can be used. 

(deftrap-inline "_CFBundleCopyExecutableURL" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFURL)
() )

(deftrap-inline "_CFBundleIsExecutableLoaded" 
   ((bundle (:pointer :__CFBundle))
   )
   :Boolean
() )

(deftrap-inline "_CFBundleLoadExecutable" 
   ((bundle (:pointer :__CFBundle))
   )
   :Boolean
() )

(deftrap-inline "_CFBundleUnloadExecutable" 
   ((bundle (:pointer :__CFBundle))
   )
   nil
() )

(deftrap-inline "_CFBundleGetFunctionPointerForName" 
   ((bundle (:pointer :__CFBundle))
    (functionName (:pointer :__CFString))
   )
   (:pointer :void)
() )

(deftrap-inline "_CFBundleGetFunctionPointersForNames" 
   ((bundle (:pointer :__CFBundle))
    (functionNames (:pointer :__CFArray))
    (ftbl :pointer)
   )
   nil
() )

(deftrap-inline "_CFBundleGetDataPointerForName" 
   ((bundle (:pointer :__CFBundle))
    (symbolName (:pointer :__CFString))
   )
   (:pointer :void)
() )

(deftrap-inline "_CFBundleGetDataPointersForNames" 
   ((bundle (:pointer :__CFBundle))
    (symbolNames (:pointer :__CFArray))
    (stbl :pointer)
   )
   nil
() )

(deftrap-inline "_CFBundleCopyAuxiliaryExecutableURL" 
   ((bundle (:pointer :__CFBundle))
    (executableName (:pointer :__CFString))
   )
   (:pointer :__CFURL)
() )
;  This function can be used to find executables other than your main 
;  executable.  This is useful, for instance, for applications that have 
;  some command line tool that is packaged with and used by the application. 
;  The tool can be packaged in the various platform executable directories 
;  in the bundle and can be located with this function.  This allows an 
;  app to ship versions of the tool for each platform as it does for the 
;  main app executable. 
;  ==================== Getting a bundle's plugIn ==================== 

(deftrap-inline "_CFBundleGetPlugIn" 
   ((bundle (:pointer :__CFBundle))
   )
   (:pointer :__CFBundle)
() )
;  ==================== Resource Manager-Related API ==================== 

(deftrap-inline "_CFBundleOpenBundleResourceMap" 
   ((bundle (:pointer :__CFBundle))
   )
   :SInt16
() )
;  This function opens the non-localized and the localized resource files 
;  (if any) for the bundle, creates and makes current a single read-only 
;  resource map combining both, and returns a reference number for it. 
;  If it is called multiple times, it opens the files multiple times, 
;  and returns distinct reference numbers.  

(deftrap-inline "_CFBundleOpenBundleResourceFiles" 
   ((bundle (:pointer :__CFBundle))
    (refNum (:pointer :short))
    (localizedRefNum (:pointer :short))
   )
   :SInt32
() )
;  Similar to CFBundleOpenBundleResourceMap, except that it creates two 
;  separate resource maps and returns reference numbers for both. 

(deftrap-inline "_CFBundleCloseBundleResourceMap" 
   ((bundle (:pointer :__CFBundle))
    (refNum :SInt16)
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFBUNDLE__ */


(provide-interface "CFBundle")