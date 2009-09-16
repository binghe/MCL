(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSResponder.h"
; at Sunday July 2,2006 7:30:57 pm.
; 
;         NSResponder.h
;         Application Kit
;         Copyright (c) 1994-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSResponder : NSObject <NSCoding>
{
    
    id _nextResponder;
}

- (NSResponder *)nextResponder;
- (void)setNextResponder:(NSResponder *)aResponder;
- (BOOL)tryToPerform:(SEL)anAction with:(id)anObject;
- (BOOL)performKeyEquivalent:(NSEvent *)theEvent;
- (id)validRequestorForSendType:(NSString *)sendType returnType:(NSString *)returnType;
- (void)mouseDown:(NSEvent *)theEvent;
- (void)rightMouseDown:(NSEvent *)theEvent;
- (void)otherMouseDown:(NSEvent *)theEvent;
- (void)mouseUp:(NSEvent *)theEvent;
- (void)rightMouseUp:(NSEvent *)theEvent;
- (void)otherMouseUp:(NSEvent *)theEvent;
- (void)mouseMoved:(NSEvent *)theEvent;
- (void)mouseDragged:(NSEvent *)theEvent;
- (void)scrollWheel:(NSEvent *)theEvent;
- (void)rightMouseDragged:(NSEvent *)theEvent;
- (void)otherMouseDragged:(NSEvent *)theEvent;
- (void)mouseEntered:(NSEvent *)theEvent;
- (void)mouseExited:(NSEvent *)theEvent;
- (void)keyDown:(NSEvent *)theEvent;
- (void)keyUp:(NSEvent *)theEvent;
- (void)flagsChanged:(NSEvent *)theEvent;
- (void)noResponderFor:(SEL)eventSelector;
- (BOOL)acceptsFirstResponder;
- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;

- (void)interpretKeyEvents:(NSArray *)eventArray;
- (void)flushBufferedKeyEvents;

- (void)setMenu:(NSMenu *)menu;
- (NSMenu *)menu;

- (void)showContextHelp:(id)sender;

- (void)helpRequested:(NSEvent *)eventPtr;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (BOOL)shouldBeTreatedAsInkEvent:(NSEvent *)theEvent;
#endif
|#
#| @INTERFACE 
NSResponder(NSKeyboardUI)
- (BOOL)performMnemonic:(NSString *)theString;
|#
#| @INTERFACE 
NSResponder (NSStandardKeyBindingMethods)




- (void)insertText:(id)insertString;
    
- (void)doCommandBySelector:(SEL)aSelector;
    


    

- (void)moveForward:(id)sender;
- (void)moveRight:(id)sender;
- (void)moveBackward:(id)sender;
- (void)moveLeft:(id)sender;
- (void)moveUp:(id)sender;
- (void)moveDown:(id)sender;
- (void)moveWordForward:(id)sender;
- (void)moveWordBackward:(id)sender;
- (void)moveToBeginningOfLine:(id)sender;
- (void)moveToEndOfLine:(id)sender;
- (void)moveToBeginningOfParagraph:(id)sender;
- (void)moveToEndOfParagraph:(id)sender;
- (void)moveToEndOfDocument:(id)sender;
- (void)moveToBeginningOfDocument:(id)sender;
- (void)pageDown:(id)sender;
- (void)pageUp:(id)sender;
- (void)centerSelectionInVisibleArea:(id)sender;

- (void)moveBackwardAndModifySelection:(id)sender;
- (void)moveForwardAndModifySelection:(id)sender;
- (void)moveWordForwardAndModifySelection:(id)sender;
- (void)moveWordBackwardAndModifySelection:(id)sender;
- (void)moveUpAndModifySelection:(id)sender;
- (void)moveDownAndModifySelection:(id)sender;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)moveWordRight:(id)sender;
- (void)moveWordLeft:(id)sender;
- (void)moveRightAndModifySelection:(id)sender;
- (void)moveLeftAndModifySelection:(id)sender;
- (void)moveWordRightAndModifySelection:(id)sender;
- (void)moveWordLeftAndModifySelection:(id)sender;
#endif

- (void)scrollPageUp:(id)sender;
- (void)scrollPageDown:(id)sender;
- (void)scrollLineUp:(id)sender;
- (void)scrollLineDown:(id)sender;

    

- (void)transpose:(id)sender;
- (void)transposeWords:(id)sender;

    

- (void)selectAll:(id)sender;
- (void)selectParagraph:(id)sender;
- (void)selectLine:(id)sender;
- (void)selectWord:(id)sender;

    

- (void)indent:(id)sender;
- (void)insertTab:(id)sender;
- (void)insertBacktab:(id)sender;
- (void)insertNewline:(id)sender;
- (void)insertParagraphSeparator:(id)sender;
- (void)insertNewlineIgnoringFieldEditor:(id)sender;
- (void)insertTabIgnoringFieldEditor:(id)sender;

    

- (void)changeCaseOfLetter:(id)sender;
- (void)uppercaseWord:(id)sender;
- (void)lowercaseWord:(id)sender;
- (void)capitalizeWord:(id)sender;

    

- (void)deleteForward:(id)sender;
- (void)deleteBackward:(id)sender;
#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (void)deleteBackwardByDecomposingPreviousCharacter:(id)sender;
#endif 
- (void)deleteWordForward:(id)sender;
- (void)deleteWordBackward:(id)sender;
- (void)deleteToBeginningOfLine:(id)sender;
- (void)deleteToEndOfLine:(id)sender;
- (void)deleteToBeginningOfParagraph:(id)sender;
- (void)deleteToEndOfParagraph:(id)sender;

- (void)yank:(id)sender;

    

- (void)complete:(id)sender;

    

- (void)setMark:(id)sender;
- (void)deleteToMark:(id)sender;
- (void)selectToMark:(id)sender;
- (void)swapWithMark:(id)sender;

    

#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (void)cancelOperation:(id)sender;
#endif 
|#
#| @INTERFACE 
NSResponder(NSUndoSupport)
- (NSUndoManager *)undoManager;
|#

(provide-interface "NSResponder")