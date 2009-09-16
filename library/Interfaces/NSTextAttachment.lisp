(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTextAttachment.h"
; at Sunday July 2,2006 7:31:02 pm.
;  
; 	NSTextAttachment.h
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; 	Classes to represent text attachments.
; 
; 	NSTextAttachment is used to represent text attachments. When inline, text attachments appear as the value of the NSAttachmentAttributeName attached to the special character NSAttachmentCharacter.
; 
; 	NSTextAttachment uses an object obeying the NSTextAttachmentCell protocol to get input from the user and to display an image.
; 
;         NSTextAttachmentCell is a simple subclass of NSCell which provides the NSTextAttachment protocol.
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/NSCell.h>

; #import <AppKit/NSAttributedString.h>

(defconstant $NSAttachmentCharacter #xFFFC)     ;  To denote attachments. 

;  These are the only methods required of cells in text attachments... The default NSCell class implements most of these; the NSTextAttachmentCell class is a subclass which implements all and provides some additional functionality.
;  
#| @PROTOCOL 
NSTextAttachmentCell <NSObject>
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (BOOL)wantsToTrackMouse;
- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView;
- (BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)flag;
- (NSSize)cellSize;
- (NSPoint)cellBaselineOffset;
- (void)setAttachment:(NSTextAttachment *)anObject;
- (NSTextAttachment *)attachment;

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView characterIndex:(unsigned)charIndex;
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView characterIndex:(unsigned)charIndex layoutManager:(NSLayoutManager *)layoutManager;
- (BOOL)wantsToTrackMouseForEvent:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView atCharacterIndex:(unsigned)charIndex;
- (BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView atCharacterIndex:(unsigned)charIndex untilMouseUp:(BOOL)flag;
- (NSRect)cellFrameForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(NSRect)lineFrag glyphPosition:(NSPoint)position characterIndex:(unsigned)charIndex;
|#
;  Simple class to provide basic attachment cell functionality. By default this class causes NSTextView to send out delegate messages when the attachment is clicked on or dragged.
;  
#| @INTERFACE 
NSTextAttachmentCell : NSCell <NSTextAttachmentCell> {
    
    NSTextAttachment *_attachment;
}
|#
#| @INTERFACE 
NSTextAttachment : NSObject <NSCoding> {
    
    NSFileWrapper *_fileWrapper;
    id <NSTextAttachmentCell>_cell;
    struct {
        unsigned int cellWasExplicitlySet:1;
        unsigned int :31;
    } _flags;
}


- (id)initWithFileWrapper:(NSFileWrapper *)fileWrapper;


- (void)setFileWrapper:(NSFileWrapper *)fileWrapper;
- (NSFileWrapper *)fileWrapper;


- (id <NSTextAttachmentCell>)attachmentCell;
- (void)setAttachmentCell:(id <NSTextAttachmentCell>)cell;

|#
;  Convenience for creating an attributed string with an attachment.
;  
#| @INTERFACE 
NSAttributedString (NSAttributedStringAttachmentConveniences)

+ (NSAttributedString *)attributedStringWithAttachment:(NSTextAttachment *)attachment;

|#
#| @INTERFACE 
NSMutableAttributedString (NSMutableAttributedStringAttachmentConveniences)

- (void)updateAttachmentsFromPath:(NSString *)path;

|#

(provide-interface "NSTextAttachment")