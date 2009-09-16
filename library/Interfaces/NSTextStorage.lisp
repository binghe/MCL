(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTextStorage.h"
; at Sunday July 2,2006 7:31:02 pm.
;  
; 	NSTextStorage.h
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; NSTextStorage is a semi-abstract subclass of NSMutableAttributedString. It implements change management (beginEditing/endEditing), verification of attributes, delegate handling, and layout management notification. The one aspect it does not implement is the actual attributed string storage --- this is left up to the subclassers, which need to override the two NSMutableAttributedString primitives:
; 
;   - (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str;
;   - (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range;
; 
; These primitives should perform the change then call edited:range:changeInLength: to get everything else to happen.
;    
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/NSAttributedString.h>
;  These values are or'ed together in notifications to indicate what got changed.
; 

(defconstant $NSTextStorageEditedAttributes 1)
(defconstant $NSTextStorageEditedCharacters 2)
#| @INTERFACE 
NSTextStorage : NSMutableAttributedString {
    
    NSRange _editedRange;
    int _editedDelta;
    struct {
	unsigned int editedMask:8;
        unsigned int :8;
        unsigned int disabled:16;
    } _flags;
    NSMutableArray *_layoutManagers;
    void *_sideData;
}

   
- (void)addLayoutManager:(NSLayoutManager *)obj;     
- (void)removeLayoutManager:(NSLayoutManager *)obj;
- (NSArray *)layoutManagers;


- (void)edited:(unsigned)editedMask range:(NSRange)range changeInLength:(int)delta;


- (void)processEditing;


- (void)invalidateAttributesInRange:(NSRange)range;


- (void)ensureAttributesAreFixedInRange:(NSRange)range;



- (BOOL)fixesAttributesLazily;

       
- (unsigned)editedMask;
- (NSRange)editedRange;
- (int)changeInLength;


- (void)setDelegate:(id)delegate;
- (id)delegate;

|#
; ***  NSTextStorage delegate methods ***
#| @INTERFACE 
NSObject (NSTextStorageDelegate)


- (void)textStorageWillProcessEditing:(NSNotification *)notification;	
- (void)textStorageDidProcessEditing:(NSNotification *)notification;	

|#
; *** Notifications ***
(def-mactype :NSTextStorageWillProcessEditingNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSTextStorageDidProcessEditingNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSTextStorage")