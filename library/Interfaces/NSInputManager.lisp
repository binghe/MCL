(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSInputManager.h"
; at Sunday July 2,2006 7:30:50 pm.
; 
; 	NSInputManager.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
;  

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSRange.h>
#| @PROTOCOL 
NSTextInput

- (void) insertText:(id)aString; - (void) doCommandBySelector:(SEL)aSelector;
	- (void) setMarkedText:(id)aString selectedRange:(NSRange)selRange;

- (void) unmarkText;
- (BOOL) hasMarkedText;
- (long) conversationIdentifier;


- (NSAttributedString *) attributedSubstringFromRange:(NSRange)theRange;


- (NSRange) markedRange;


- (NSRange) selectedRange;


- (NSRect) firstRectForCharacterRange:(NSRange)theRange;


- (unsigned int)characterIndexForPoint:(NSPoint)thePoint;


- (NSArray*) validAttributesForMarkedText;

|#
#| @INTERFACE 
NSInputManager : NSObject <NSTextInput> {

private
    id _currentClient;
    id _server;			    id _bundleObj;		    id _keybindings;		    NSString *_trueName;	    NSString *_connectionName;	    NSString *_hostName;	    NSString *_procToExec;	    NSString *_visibleName;	    NSString *_bundleName;	    NSString *_language;		    NSImage *_image;		    unsigned int _flags;
    NSString *_keyBindingsName;	    int _reservedInputManager2;
}


+ (NSInputManager *) currentInputManager;


+ (void)cycleToNextInputLanguage:(id)sender;
+ (void)cycleToNextInputServerInLanguage:(id)sender;

- (NSInputManager *) initWithName:(NSString *)inputServerName host:(NSString *)hostName;

- (NSString *) localizedInputManagerName;

 

- (void) markedTextAbandoned:(id)cli; 
- (void) markedTextSelectionChanged:(NSRange)newSel client:(id)cli; 


- (BOOL) wantsToInterpretAllKeystrokes;

- (NSString*) language;

- (NSImage *) image;

- (NSInputServer*) server;


- (BOOL) wantsToHandleMouseEvents;

- (BOOL) handleMouseEvent:(NSEvent*)theMouseEvent;


- (BOOL) wantsToDelayTextChangeNotifications;
|#

(provide-interface "NSInputManager")