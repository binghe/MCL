(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:afpURL.h"
; at Sunday July 2,2006 7:25:31 pm.
; 
;  *  afpURL.h
;  *  AppleShareClientLib
;  *
;  
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

;  used to be __cplusplus	

; #if __GNUG__		
#| 
; Gag EXTERN "C"  {
 |#

; #endif

; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
; 	AFP URL Support															 
; ---------------------------------------------------------------------------
; ---------------------------------------------------------------------------
;  Building and disposing of an AFP URL										 
; ---------------------------------------------------------------------------

(deftrap-inline "_NewAFPURL" 
   ((protocolName (:pointer :UInt8))
    (serverNameOrHost (:pointer :UInt8))
    (zoneNameOrNULL (:pointer :UInt8))
    (uamName (:pointer :UInt8))
    (userName (:pointer :UInt8))
    (password (:pointer :UInt8))
    (volume (:pointer :UInt8))
    (path (:pointer :UInt8))
   )
   :character
() )

(deftrap-inline "_DisposeAFPURL" 
   ((url (:pointer :char))
   )
   nil
() )
; ---------------------------------------------------------------------------
;  Parsing an AFP URL: IsAFPURL simply tests the scheme						 
; ---------------------------------------------------------------------------

(deftrap-inline "_IsAFPURL" 
   ((url (:pointer :char))
   )
   :Boolean
() )
; ---------------------------------------------------------------------------
;  ParseAFPURL parses all the fields of the URL. Any StringPtr can be NULL,	 
;  If provided the StringPtr must point to a string large enough to 		 
;  accomodate maximum length value (Str255)									 
; ---------------------------------------------------------------------------

(deftrap-inline "_ParseAFPURL" 
   ((url (:pointer :char))
    (protocolName (:pointer :UInt8))
    (serverNameOrHost (:pointer :UInt8))
    (zoneNameOr (:pointer :UInt8))
    (uamName (:pointer :UInt8))
    (userName (:pointer :UInt8))
    (password (:pointer :UInt8))
    (volume (:pointer :UInt8))
    (path (:pointer :UInt8))
   )
   :OSStatus
() )
; ---------------------------------------------------------------------------
;  AFPMountURL mounts a volume given an afp URL, the mount flags are the 	 
;  same as the flags used by the mount system call. errno is set on error	 
;  NOTE: inMountPoint must exist. This call will not bring up HI.			 
; ---------------------------------------------------------------------------

(deftrap-inline "_AFPMountURL" 
   ((inURL (:pointer :char))
    (inMountPoint (:pointer :char))
    (inMountFlags :UInt32)
    (inAltFlags :UInt32)
   )
   :OSStatus
() )
;  used to be __cplusplus	

; #if __GNUG__		
#| 
 |#

; #endif


(provide-interface "afpURL")