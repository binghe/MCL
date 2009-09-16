(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSearchField.h"
; at Sunday July 2,2006 7:30:59 pm.
; 
;     NSSearchField.h
;     Application Kit
;     Copyright (c) 2003, Apple Computer, Inc.
;     All rights reserved.
; 

; #import <AppKit/NSTextField.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSSearchField : NSTextField {
  private
    unsigned int _reserved1;
    unsigned int _reserved2;
    unsigned int _reserved3;
    unsigned int _reserved4;
}

- (void) setRecentSearches:(NSArray*)searches;
- (NSArray*) recentSearches;
    
- (void) setRecentsAutosaveName:(NSString*)string;
- (NSString*) recentsAutosaveName;
    
|#

; #endif


(provide-interface "NSSearchField")