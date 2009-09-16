(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSInputServer.h"
; at Sunday July 2,2006 7:30:50 pm.
; 
; 	NSInputServer.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSRange.h>
;  These methods must be implemented by the delegate.
; 
#| @PROTOCOL 
NSInputServiceProvider

- (void) insertText:(id)aString client:(id)sender;
- (void) doCommandBySelector:(SEL)aSelector client:(id)sender;
- (void) markedTextAbandoned:(id)sender;
- (void) markedTextSelectionChanged:(NSRange)newSel client:(id)sender;
- (void) terminate:(id)sender;


- (BOOL) canBeDisabled;


- (BOOL) wantsToInterpretAllKeystrokes;


- (BOOL) wantsToHandleMouseEvents;


- (BOOL) wantsToDelayTextChangeNotifications;


- (void) inputClientBecomeActive:(id)sender;
- (void) inputClientResignActive:(id)sender;


- (void) inputClientEnabled:(id)sender;
- (void) inputClientDisabled:(id)sender;


- (void) activeConversationWillChange:(id)sender fromOldConversation:(long)oldConversation;
- (void) activeConversationChanged:(id)sender toNewConversation:(long)newConversation;

|#
;  These methods are sent to input servers that return YES to wantsToHandleMouseEvents.  thePoint is in screen coordinate.
; 
#| @PROTOCOL 
NSInputServerMouseTracker
- (BOOL) mouseDownOnCharacterIndex:(unsigned)theIndex atCoordinate:(NSPoint)thePoint withModifier:(unsigned int)theFlags client:(id)sender;
- (BOOL) mouseDraggedOnCharacterIndex:(unsigned)theIndex atCoordinate:(NSPoint)thePoint withModifier:(unsigned int)theFlags client:(id)sender;
- (void) mouseUpOnCharacterIndex:(unsigned)theIndex atCoordinate:(NSPoint)thePoint withModifier:(unsigned int)theFlags client:(id)sender;
|#
#| @INTERFACE 
NSInputServer : NSObject <NSInputServiceProvider, NSInputServerMouseTracker> {
    NSString *_name;
    id _delegate;
}

- initWithDelegate:(id)aDelegate name:(NSString *)name;
|#

(provide-interface "NSInputServer")