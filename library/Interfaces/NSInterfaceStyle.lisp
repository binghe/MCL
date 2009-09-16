(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSInterfaceStyle.h"
; at Sunday July 2,2006 7:30:50 pm.
; 
;         NSInterfaceStyle.h
;         Application Kit
;         Copyright (c) 1995-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSResponder.h>

; #import <AppKit/AppKitDefines.h>

(defconstant $NSNoInterfaceStyle 0)             ;  Default value for a window's interfaceStyle

(defconstant $NSNextStepInterfaceStyle 1)
(defconstant $NSWindows95InterfaceStyle 2)
(defconstant $NSMacintoshInterfaceStyle 3)
(def-mactype :NSInterfaceStyle (find-mactype ':SINT32))

(deftrap-inline "_NSInterfaceStyleForKey" 
   ((key (:pointer :NSString))
    (responder (:pointer :nsresponder))
   )
   :SInt32
() )
;  Responders can use this function to parameterize their drawing and behavior.  If the responder has specific defaults to control various aspects of its interface individually, the keys for those special settings can be passed in, otherwise pass nil to get the global setting.  The responder should always be passed, but in situations where a responder is not available, pass nil.
#| @INTERFACE 
NSResponder (NSInterfaceStyle)
- (NSInterfaceStyle)interfaceStyle;
- (void)setInterfaceStyle:(NSInterfaceStyle)interfaceStyle;
|#
;  Default strings
(def-mactype :NSInterfaceStyleDefault (find-mactype '(:pointer :NSString)))

(provide-interface "NSInterfaceStyle")