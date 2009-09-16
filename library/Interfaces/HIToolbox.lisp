(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:HIToolbox.h"
; at Sunday July 2,2006 7:24:46 pm.
; 
;      File:       HIToolbox/HIToolbox.h
;  
;      Contains:   Master include for HIToolbox private framework
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __HITOOLBOX__
; #define __HITOOLBOX__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __HIOBJECT__

(require-interface "HIToolbox/HIObject")

; #endif

; #ifndef __HITOOLBAR__

(require-interface "HIToolbox/HIToolbar")

; #endif

; #ifndef __HIVIEW__

(require-interface "HIToolbox/HIView")

; #endif

; #ifndef __HITEXTUTILS__

(require-interface "HIToolbox/HITextUtils")

; #endif

; #ifndef __HISHAPE__

(require-interface "HIToolbox/HIShape")

; #endif

; #ifndef __EVENTS__
#| #|
#include <HIToolboxEvents.h>
#endif
|#
 |#
; #ifndef __NOTIFICATION__

(require-interface "HIToolbox/Notification")

; #endif

; #ifndef __DRAG__
#| #|
#include <HIToolboxDrag.h>
#endif
|#
 |#
; #ifndef __CONTROLS__
#| #|
#include <HIToolboxControls.h>
#endif
|#
 |#
; #ifndef __APPEARANCE__
#| #|
#include <HIToolboxAppearance.h>
#endif
|#
 |#
; #ifndef __HITHEME__

(require-interface "HIToolbox/HITheme")

; #endif

; #ifndef __MACWINDOWS__
#| #|
#include <HIToolboxMacWindows.h>
#endif
|#
 |#
; #ifndef __TEXTEDIT__
#| #|
#include <HIToolboxTextEdit.h>
#endif
|#
 |#
; #ifndef __MENUS__
#| #|
#include <HIToolboxMenus.h>
#endif
|#
 |#
; #ifndef __DIALOGS__

(require-interface "HIToolbox/Dialogs")

; #endif

; #ifndef __LISTS__

(require-interface "HIToolbox/Lists")

; #endif

; #ifndef __CARBONEVENTSCORE__
#| #|
#include <HIToolboxCarbonEventsCore.h>
#endif
|#
 |#
; #ifndef __CARBONEVENTS__
#| #|
#include <HIToolboxCarbonEvents.h>
#endif
|#
 |#
; #ifndef __TEXTSERVICES__

(require-interface "HIToolbox/TextServices")

; #endif

; #ifndef __SCRAP__

(require-interface "HIToolbox/Scrap")

; #endif

; #ifndef __MACTEXTEDITOR__

(require-interface "HIToolbox/MacTextEditor")

; #endif

; #ifndef __MACHELP__

(require-interface "HIToolbox/MacHelp")

; #endif

; #ifndef __CONTROLDEFINITIONS__

(require-interface "HIToolbox/ControlDefinitions")

; #endif

; #ifndef __TSMTE__

(require-interface "HIToolbox/TSMTE")

; #endif

; #ifndef __TRANSLATIONEXTENSIONS__

(require-interface "HIToolbox/TranslationExtensions")

; #endif

; #ifndef __TRANSLATION__

(require-interface "HIToolbox/Translation")

; #endif

; #ifndef __AEINTERACTION__
#| #|
#include <HIToolboxAEInteraction.h>
#endif
|#
 |#
; #ifndef __TYPESELECT__

(require-interface "HIToolbox/TypeSelect")

; #endif

; #ifndef __MACAPPLICATION__

(require-interface "HIToolbox/MacApplication")

; #endif

; #ifndef __KEYBOARDS__

(require-interface "HIToolbox/Keyboards")

; #endif

; #ifndef __IBCARBONRUNTIME__

(require-interface "HIToolbox/IBCarbonRuntime")

; #endif

;   #include <Displays.i>  -- moved to QD.i 

; #endif /* __HITOOLBOX__ */


(provide-interface "HIToolbox")