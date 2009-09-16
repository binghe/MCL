(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CMTypes.h"
; at Sunday July 2,2006 7:24:22 pm.
; 
;      File:       ColorSync/CMTypes.h
;  
;      Contains:   ColorSync types
;  
;      Version:    ColorSync-118.2~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CMTYPES__
; #define __CMTYPES__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
;  Standard type for ColorSync and other system error codes 

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

(def-mactype :CMError (find-mactype ':signed-long))
;  Abstract data type for memory-based Profile 

(def-mactype :CMProfileRef (find-mactype '(:pointer :OpaqueCMProfileRef)))
;  Abstract data type for Profile search result 

(def-mactype :CMProfileSearchRef (find-mactype '(:pointer :OpaqueCMProfileSearchRef)))
;  Abstract data type for BeginMatching(É) reference 

(def-mactype :CMMatchRef (find-mactype '(:pointer :OpaqueCMMatchRef)))
;  Abstract data type for ColorWorld reference 

(def-mactype :CMWorldRef (find-mactype '(:pointer :OpaqueCMWorldRef)))
;  Data type for ColorSync DisplayID reference 
;  On 8 & 9 this is a AVIDType 
;  On X this is a CGSDisplayID 

(def-mactype :CMDisplayIDType (find-mactype ':UInt32))
;  Caller-supplied flatten function 

(def-mactype :CMFlattenProcPtr (find-mactype ':pointer)); (long command , long * size , void * data , void * refCon)
;  Caller-supplied progress function for Bitmap & PixMap matching routines 

(def-mactype :CMBitmapCallBackProcPtr (find-mactype ':pointer)); (long progress , void * refCon)
;  Caller-supplied progress function for NCMMConcatInit & NCMMNewLinkProfile routines 

(def-mactype :CMConcatCallBackProcPtr (find-mactype ':pointer)); (long progress , void * refCon)
;  Caller-supplied filter function for Profile search 

(def-mactype :CMProfileFilterProcPtr (find-mactype ':pointer)); (CMProfileRef prof , void * refCon)
;  Caller-supplied function for profile access 

(def-mactype :CMProfileAccessProcPtr (find-mactype ':pointer)); (long command , long offset , long * size , void * data , void * refCon)

(def-mactype :CMFlattenUPP (find-mactype '(:pointer :OpaqueCMFlattenProcPtr)))

(def-mactype :CMBitmapCallBackUPP (find-mactype '(:pointer :OpaqueCMBitmapCallBackProcPtr)))

(def-mactype :CMConcatCallBackUPP (find-mactype '(:pointer :OpaqueCMConcatCallBackProcPtr)))

(def-mactype :CMProfileFilterUPP (find-mactype '(:pointer :OpaqueCMProfileFilterProcPtr)))

(def-mactype :CMProfileAccessUPP (find-mactype '(:pointer :OpaqueCMProfileAccessProcPtr)))
; 
;  *  NewCMFlattenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCMFlattenUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCMFlattenProcPtr)
() )
; 
;  *  NewCMBitmapCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCMBitmapCallBackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCMBitmapCallBackProcPtr)
() )
; 
;  *  NewCMConcatCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCMConcatCallBackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCMConcatCallBackProcPtr)
() )
; 
;  *  NewCMProfileFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCMProfileFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCMProfileFilterProcPtr)
() )
; 
;  *  NewCMProfileAccessUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCMProfileAccessUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCMProfileAccessProcPtr)
() )
; 
;  *  DisposeCMFlattenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCMFlattenUPP" 
   ((userUPP (:pointer :OpaqueCMFlattenProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCMBitmapCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCMBitmapCallBackUPP" 
   ((userUPP (:pointer :OpaqueCMBitmapCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCMConcatCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCMConcatCallBackUPP" 
   ((userUPP (:pointer :OpaqueCMConcatCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCMProfileFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCMProfileFilterUPP" 
   ((userUPP (:pointer :OpaqueCMProfileFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCMProfileAccessUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCMProfileAccessUPP" 
   ((userUPP (:pointer :OpaqueCMProfileAccessProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeCMFlattenUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCMFlattenUPP" 
   ((command :signed-long)
    (size (:pointer :long))
    (data :pointer)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueCMFlattenProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeCMBitmapCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCMBitmapCallBackUPP" 
   ((progress :signed-long)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueCMBitmapCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeCMConcatCallBackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCMConcatCallBackUPP" 
   ((progress :signed-long)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueCMConcatCallBackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeCMProfileFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCMProfileFilterUPP" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueCMProfileFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeCMProfileAccessUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCMProfileAccessUPP" 
   ((command :signed-long)
    (offset :signed-long)
    (size (:pointer :long))
    (data :pointer)
    (refCon :pointer)
    (userUPP (:pointer :OpaqueCMProfileAccessProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CMTYPES__ */


(provide-interface "CMTypes")