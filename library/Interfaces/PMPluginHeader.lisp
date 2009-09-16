(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMPluginHeader.h"
; at Sunday July 2,2006 7:31:12 pm.
; 
;      File:       PMPluginHeader.h
;  
;      Contains:   Mac OS X Printing Manager Plugin Header Defintions.
;  
;      Version:    Technology: Mac OS X
;                  Release:    1.0
;  
;      Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
; 
; #ifndef __PMPLUGINHEADER__
; #define __PMPLUGINHEADER__

(require-interface "ApplicationServices/ApplicationServices")

(require-interface "CoreFoundation/CoreFoundation")

; #if COREFOUNDATION_CFPLUGINCOM_SEPARATE

(require-interface "CoreFoundation/CFPlugInCOM")

; #endif /* COREFOUNDATION_CFPLUGINCOM_SEPARATE */

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  API Version is used for plugin object API compatibility check. 
(defrecord PMPlugInAPIVersion
                                                ;  API build version. 
                                                ;  This is the API version this object was compiled with. 
   (buildVersionMajor :UInt32)
   (buildVersionMinor :UInt32)
                                                ;  Base API version this object is upward compatible with. 
                                                ;  The object guarantees to be a super-set of said API. 
   (baseVersionMajor :UInt32)
   (baseVersionMinor :UInt32)
)

;type name? (%define-record :PMPlugInAPIVersion (find-record-descriptor ':PMPlugInAPIVersion))
;  The plugin header interface, and its vtable. 
;  Plugin interface is an address of an object which contains a vtable pointer 
;  as its first member. Every plugin interface (except 'iunknown') must begin 
;  with PMPlugInHeader which must not change. 

;type name? (def-mactype :PMPlugInHeader (find-mactype ':PMPlugInHeader))

;type name? (def-mactype :PMPlugInHeaderInterface (find-mactype ':PMPlugInHeaderInterface))
(defrecord PMPlugInHeaderInterface
   (vtable (:pointer :PMPlugInHeader))
)
(defrecord PMPlugInHeader
                                                ;  ---- API 'IMMUTABLE' Begin: ---- 
                                                ;  Retain an object. 
   (Retain (:pointer :callback))                ;((OSStatus , Retain) (PMPlugInHeaderInterface * obj))
                                                ;  Release an object. When reference count goes down to zero object
;      * is deleted. The call clears caller's reference to the object. 
   (Release (:pointer :callback))               ;((OSStatus , Release) (PMPlugInHeaderInterface ** objPtr))
                                                ;  GetAPIVersion method is required with all plugin modules
;      * to be able to get object's API build and compatibility version.
;      * This version is used for plugin API compatibility check. 
   (GetAPIVersion (:pointer :callback))         ;((OSStatus , GetAPIVersion) (PMPlugInHeaderInterface * obj , PMPlugInAPIVersion * versionPtr))
)
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMPLUGINHEADER__ */


(provide-interface "PMPluginHeader")