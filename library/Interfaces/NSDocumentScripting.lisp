(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDocumentScripting.h"
; at Sunday July 2,2006 7:30:46 pm.
; 
;         NSDocumentScripting.h
;         AppKit Framework
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <AppKit/NSDocument.h>
#| @INTERFACE 
NSDocument (NSScripting)

- (NSString *)lastComponentOfFileName;
- (void)setLastComponentOfFileName:(NSString *)str;

- (id)handleSaveScriptCommand:(NSScriptCommand *)command;
- (id)handleCloseScriptCommand:(NSCloseCommand *)command;
- (id)handlePrintScriptCommand:(NSScriptCommand *)command;

- (NSScriptObjectSpecifier *)objectSpecifier;

|#

(provide-interface "NSDocumentScripting")