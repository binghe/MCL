(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CMScriptingPlugin.h"
; at Sunday July 2,2006 7:24:24 pm.
; 
;      File:       ColorSync/CMScriptingPlugin.h
;  
;      Contains:   ColorSync Scripting Plugin API
;  
;      Version:    ColorSync-118.2~1
;  
;      Copyright:  © 1998-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CMSCRIPTINGPLUGIN__
; #define __CMSCRIPTINGPLUGIN__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __CMAPPLICATION__
#| #|
#include <ColorSyncCMApplication.h>
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
;  ColorSync Scripting AppleEvent Errors 

(defconstant $cmspInvalidImageFile -4220)       ;  Plugin cannot handle this image file type 

(defconstant $cmspInvalidImageSpace -4221)      ;  Plugin cannot create an image file of this colorspace 

(defconstant $cmspInvalidProfileEmbed -4222)    ;  Specific invalid profile errors 

(defconstant $cmspInvalidProfileSource -4223)
(defconstant $cmspInvalidProfileDest -4224)
(defconstant $cmspInvalidProfileProof -4225)
(defconstant $cmspInvalidProfileLink -4226)
; *** embedFlags field  ***
;  reserved for future use: currently 0 
; *** matchFlags field  ***

(defconstant $cmspFavorEmbeddedMask 1)          ;  if bit 0 is 0 then use srcProf profile, if 1 then use profile embedded in image if present

; *** scripting plugin entry points  ***

(def-mactype :ValidateImageProcPtr (find-mactype ':pointer)); (const FSSpec * spec)

(def-mactype :GetImageSpaceProcPtr (find-mactype ':pointer)); (const FSSpec * spec , OSType * space)

(def-mactype :ValidateSpaceProcPtr (find-mactype ':pointer)); (const FSSpec * spec , OSType * space)

(def-mactype :EmbedImageProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , CMProfileRef embedProf , UInt32 embedFlags)

(def-mactype :UnembedImageProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto)

(def-mactype :MatchImageProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , UInt32 qual , UInt32 srcIntent , CMProfileRef srcProf , CMProfileRef dstProf , CMProfileRef prfProf , UInt32 matchFlags)

(def-mactype :CountImageProfilesProcPtr (find-mactype ':pointer)); (const FSSpec * spec , UInt32 * count)

(def-mactype :GetIndImageProfileProcPtr (find-mactype ':pointer)); (const FSSpec * spec , UInt32 index , CMProfileRef * prof)

(def-mactype :SetIndImageProfileProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , UInt32 index , CMProfileRef prof , UInt32 embedFlags)
; *** CSScriptingLib entry points  ***

(def-mactype :CMValidImageProcPtr (find-mactype ':pointer)); (const FSSpec * spec)

(def-mactype :CMGetImageSpaceProcPtr (find-mactype ':pointer)); (const FSSpec * spec , OSType * space)

(def-mactype :CMEmbedImageProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , Boolean repl , CMProfileRef embProf)

(def-mactype :CMUnembedImageProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , Boolean repl)

(def-mactype :CMMatchImageProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , Boolean repl , UInt32 qual , CMProfileRef srcProf , UInt32 srcIntent , CMProfileRef dstProf)

(def-mactype :CMProofImageProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , Boolean repl , UInt32 qual , CMProfileRef srcProf , UInt32 srcIntent , CMProfileRef dstProf , CMProfileRef prfProf)

(def-mactype :CMLinkImageProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , Boolean repl , UInt32 qual , CMProfileRef lnkProf , UInt32 lnkIntent)

(def-mactype :CMCountImageProfilesProcPtr (find-mactype ':pointer)); (const FSSpec * spec , UInt32 * count)

(def-mactype :CMGetIndImageProfileProcPtr (find-mactype ':pointer)); (const FSSpec * spec , UInt32 index , CMProfileRef * prof)

(def-mactype :CMSetIndImageProfileProcPtr (find-mactype ':pointer)); (const FSSpec * specFrom , const FSSpec * specInto , Boolean repl , UInt32 index , CMProfileRef prof)
; *** CSScriptingLib API  ***
; 
;  *  CMValidImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMValidImage" 
   ((spec (:pointer :FSSpec))
   )
   :signed-long
() )
; 
;  *  CMGetImageSpace()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMGetImageSpace" 
   ((spec (:pointer :FSSpec))
    (space (:pointer :OSType))
   )
   :signed-long
() )
; 
;  *  CMEmbedImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMEmbedImage" 
   ((specFrom (:pointer :FSSpec))
    (specInto (:pointer :FSSpec))
    (repl :Boolean)
    (embProf (:pointer :OpaqueCMProfileRef))
   )
   :signed-long
() )
; 
;  *  CMUnembedImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMUnembedImage" 
   ((specFrom (:pointer :FSSpec))
    (specInto (:pointer :FSSpec))
    (repl :Boolean)
   )
   :signed-long
() )
; 
;  *  CMMatchImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMMatchImage" 
   ((specFrom (:pointer :FSSpec))
    (specInto (:pointer :FSSpec))
    (repl :Boolean)
    (qual :UInt32)
    (srcProf (:pointer :OpaqueCMProfileRef))
    (srcIntent :UInt32)
    (dstProf (:pointer :OpaqueCMProfileRef))
   )
   :signed-long
() )
; 
;  *  CMProofImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMProofImage" 
   ((specFrom (:pointer :FSSpec))
    (specInto (:pointer :FSSpec))
    (repl :Boolean)
    (qual :UInt32)
    (srcProf (:pointer :OpaqueCMProfileRef))
    (srcIntent :UInt32)
    (dstProf (:pointer :OpaqueCMProfileRef))
    (prfProf (:pointer :OpaqueCMProfileRef))
   )
   :signed-long
() )
; 
;  *  CMLinkImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMLinkImage" 
   ((specFrom (:pointer :FSSpec))
    (specInto (:pointer :FSSpec))
    (repl :Boolean)
    (qual :UInt32)
    (lnkProf (:pointer :OpaqueCMProfileRef))
    (lnkIntent :UInt32)
   )
   :signed-long
() )
; 
;  *  CMCountImageProfiles()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMCountImageProfiles" 
   ((spec (:pointer :FSSpec))
    (count (:pointer :UInt32))
   )
   :signed-long
() )
; 
;  *  CMGetIndImageProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMGetIndImageProfile" 
   ((spec (:pointer :FSSpec))
    (index :UInt32)
    (prof (:pointer :CMPROFILEREF))
   )
   :signed-long
() )
; 
;  *  CMSetIndImageProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in 3.0 and later
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CSScriptingLib 2.6 and later
;  

(deftrap-inline "_CMSetIndImageProfile" 
   ((specFrom (:pointer :FSSpec))
    (specInto (:pointer :FSSpec))
    (repl :Boolean)
    (index :UInt32)
    (prof (:pointer :OpaqueCMProfileRef))
   )
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CMSCRIPTINGPLUGIN__ */


(provide-interface "CMScriptingPlugin")