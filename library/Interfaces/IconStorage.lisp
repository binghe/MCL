(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IconStorage.h"
; at Sunday July 2,2006 7:23:32 pm.
; 
;      File:       OSServices/IconStorage.h
;  
;      Contains:   Services to load and share icon family data.
;  
;      Version:    OSServices-62.7~16
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ICONSTORAGE__
; #define __ICONSTORAGE__
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

; #pragma options align=mac68k
;  The following icon types can only be used as an icon element 
;  inside a 'icns' icon family 

(defconstant $kThumbnail32BitData :|it32|)
(defconstant $kThumbnail8BitMask :|t8mk|)

(defconstant $kHuge1BitMask :|ich#|)
(defconstant $kHuge4BitData :|ich4|)
(defconstant $kHuge8BitData :|ich8|)
(defconstant $kHuge32BitData :|ih32|)
(defconstant $kHuge8BitMask :|h8mk|)
;  The following icon types can be used as a resource type 
;  or as an icon element type inside a 'icns' icon family 

(defconstant $kLarge1BitMask :|ICN#|)
(defconstant $kLarge4BitData :|icl4|)
(defconstant $kLarge8BitData :|icl8|)
(defconstant $kLarge32BitData :|il32|)
(defconstant $kLarge8BitMask :|l8mk|)
(defconstant $kSmall1BitMask :|ics#|)
(defconstant $kSmall4BitData :|ics4|)
(defconstant $kSmall8BitData :|ics8|)
(defconstant $kSmall32BitData :|is32|)
(defconstant $kSmall8BitMask :|s8mk|)
(defconstant $kMini1BitMask :|icm#|)
(defconstant $kMini4BitData :|icm4|)
(defconstant $kMini8BitData :|icm8|)
;  Obsolete. Use names defined above. 

(defconstant $large1BitMask :|ICN#|)
(defconstant $large4BitData :|icl4|)
(defconstant $large8BitData :|icl8|)
(defconstant $small1BitMask :|ics#|)
(defconstant $small4BitData :|ics4|)
(defconstant $small8BitData :|ics8|)
(defconstant $mini1BitMask :|icm#|)
(defconstant $mini4BitData :|icm4|)
(defconstant $mini8BitData :|icm8|)
; 
;     IconFamily 'icns' resources contain an entire IconFamily (all sizes and depths).  
;    For custom icons, icns IconFamily resources of the custom icon resource ID are fetched first before
;    the classic custom icons (individual 'ics#, ICN#, etc) are fetched.  If the fetch of the icns resource
;    succeeds then the icns is looked at exclusively for the icon data.
;    For custom icons, new icon features such as 32-bit deep icons are only fetched from the icns resource.
;    This is to avoid incompatibilities with cut & paste of new style icons with an older version of the
;    MacOS Finder.
;    DriverGestalt is called with code kdgMediaIconSuite by IconServices after calling FSM to determine a
;    driver icon for a particular device.  The result of the kdgMediaIconSuite call to DriverGestalt should
;    be a pointer an an IconFamily.  In this manner driver vendors can provide rich, detailed drive icons
;    instead of the 1-bit variety previously supported.
; 

(defconstant $kIconFamilyType :|icns|)
(defrecord IconFamilyElement
   (elementType :OSType)                        ;  'ICN#', 'icl8', etc...
   (elementSize :signed-long)                   ;  Size of this element
   (elementData (:array :UInt8 1))
)

;type name? (%define-record :IconFamilyElement (find-record-descriptor ':IconFamilyElement))
(defrecord IconFamilyResource
   (resourceType :OSType)                       ;  Always 'icns'
   (resourceSize :signed-long)                  ;  Total size of this resource
   (elements (:array :IconFamilyElement 1))
)

;type name? (%define-record :IconFamilyResource (find-record-descriptor ':IconFamilyResource))

(def-mactype :IconFamilyPtr (find-mactype '(:pointer :IconFamilyResource)))

(def-mactype :IconFamilyHandle (find-mactype '(:handle :IconFamilyResource)))
;   Icon Variants 
;  These can be used as an element of an 'icns' icon family 
;  or as a parameter to GetIconRefVariant 

(defconstant $kTileIconVariant :|tile|)
(defconstant $kRolloverIconVariant :|over|)
(defconstant $kDropIconVariant :|drop|)
(defconstant $kOpenIconVariant :|open|)
(defconstant $kOpenDropIconVariant :|odrp|)
; #pragma options align=reset

; #endif /* __ICONSTORAGE__ */


(provide-interface "IconStorage")