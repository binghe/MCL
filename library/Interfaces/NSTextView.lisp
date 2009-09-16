(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTextView.h"
; at Sunday July 2,2006 7:31:02 pm.
; 
;         NSTextView.h
;         Application Kit
;         Copyright (c) 1994-2003, Apple Computer, Inc.
;         All rights reserved.
; 
;  NSTextView is a NSText subclass that displays the glyphs laid out in one NSTextContainer.

; #import <AppKit/NSText.h>

; #import <AppKit/NSInputManager.h>

; #import <AppKit/NSTextAttachment.h>

; #import <AppKit/AppKitDefines.h>

; #import <AppKit/NSDragging.h>

; #import <AppKit/NSUserInterfaceValidation.h>
(def-mactype :_NSSelectionGranularity (find-mactype ':sint32))

(defconstant $NSSelectByCharacter 0)
(defconstant $NSSelectByWord 1)
(defconstant $NSSelectByParagraph 2)
(def-mactype :NSSelectionGranularity (find-mactype ':SINT32))
(def-mactype :_NSSelectionAffinity (find-mactype ':sint32))

(defconstant $NSSelectionAffinityUpstream 0)
(defconstant $NSSelectionAffinityDownstream 1)
(def-mactype :NSSelectionAffinity (find-mactype ':SINT32))

(defconstant $NSFindPanelActionShowFindPanel 1)
(defconstant $NSFindPanelActionNext 2)
(defconstant $NSFindPanelActionPrevious 3)
(defconstant $NSFindPanelActionReplaceAll 4)
(defconstant $NSFindPanelActionReplace 5)
(defconstant $NSFindPanelActionReplaceAndFind 6)
(defconstant $NSFindPanelActionSetFindString 7)
(defconstant $NSFindPanelActionReplaceAllInSelection 8)
(def-mactype :NSFindPanelAction (find-mactype ':SINT32))
#| @INTERFACE 
NSTextView : NSText <NSTextInput, NSUserInterfaceValidations> {
}



- (id)initWithFrame:(NSRect)frameRect textContainer:(NSTextContainer *)container;
    
- (id)initWithFrame:(NSRect)frameRect;
    


- (NSTextContainer *)textContainer;
- (void)setTextContainer:(NSTextContainer *)container;
    
- (void)replaceTextContainer:(NSTextContainer *)newContainer;
    
- (void)setTextContainerInset:(NSSize)inset;
- (NSSize)textContainerInset;
    
- (NSPoint)textContainerOrigin;
- (void)invalidateTextContainerOrigin;
    
- (NSLayoutManager *)layoutManager;
- (NSTextStorage *)textStorage;
    


- (void)insertText:(id)insertString;
    


- (void)setConstrainedFrameSize:(NSSize)desiredSize;
    


- (void)setAlignment:(NSTextAlignment)alignment range:(NSRange)range;
    


- (void)turnOffKerning:(id)sender;
- (void)tightenKerning:(id)sender;
- (void)loosenKerning:(id)sender;
- (void)useStandardKerning:(id)sender;
- (void)turnOffLigatures:(id)sender;
- (void)useStandardLigatures:(id)sender;
- (void)useAllLigatures:(id)sender;
- (void)raiseBaseline:(id)sender;
- (void)lowerBaseline:(id)sender;
- (void)toggleTraditionalCharacterShape:(id)sender;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)outline:(id)sender;
#endif



#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)performFindPanelAction:(id)sender;	#endif



- (void)alignJustified:(id)sender;
- (void)changeColor:(id)sender;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)changeAttributes:(id)sender;
- (void)changeDocumentBackgroundColor:(id)sender;
- (void)toggleBaseWritingDirection:(id)sender;
#endif



- (void)rulerView:(NSRulerView *)ruler didMoveMarker:(NSRulerMarker *)marker;
- (void)rulerView:(NSRulerView *)ruler didRemoveMarker:(NSRulerMarker *)marker;
- (void)rulerView:(NSRulerView *)ruler didAddMarker:(NSRulerMarker *)marker;
- (BOOL)rulerView:(NSRulerView *)ruler shouldMoveMarker:(NSRulerMarker *)marker;
- (BOOL)rulerView:(NSRulerView *)ruler shouldAddMarker:(NSRulerMarker *)marker;
- (float)rulerView:(NSRulerView *)ruler willMoveMarker:(NSRulerMarker *)marker toLocation:(float)location;
- (BOOL)rulerView:(NSRulerView *)ruler shouldRemoveMarker:(NSRulerMarker *)marker;
- (float)rulerView:(NSRulerView *)ruler willAddMarker:(NSRulerMarker *)marker atLocation:(float)location;
- (void)rulerView:(NSRulerView *)ruler handleMouseDown:(NSEvent *)event;



- (void)setNeedsDisplayInRect:(NSRect)rect avoidAdditionalLayout:(BOOL)flag;

- (BOOL)shouldDrawInsertionPoint;
- (void)drawInsertionPointInRect:(NSRect)rect color:(NSColor *)color turnedOn:(BOOL)flag;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)drawViewBackgroundInRect:(NSRect)rect;
#endif



- (void)updateRuler;
- (void)updateFontPanel;

- (void)updateDragTypeRegistration;

- (NSRange)selectionRangeForProposedRange:(NSRange)proposedCharRange granularity:(NSSelectionGranularity)granularity;



- (void)clickedOnLink:(id)link atIndex:(unsigned)charIndex;
    


- (void)startSpeaking:(id)sender;
- (void)stopSpeaking:(id)sender;

|#

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSTextView (NSCompletion)



- (void)complete:(id)sender;
        
- (NSRange)rangeForUserCompletion;
        
- (NSArray *)completionsForPartialWordRange:(NSRange)charRange indexOfSelectedItem:(int *)index;
    
- (void)insertCompletion:(NSString *)word forPartialWordRange:(NSRange)charRange movement:(int)movement isFinal:(BOOL)flag;
    
|#

; #endif

#| @INTERFACE 
NSTextView (NSPasteboard)







- (NSArray *)writablePasteboardTypes;
    
- (BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard type:(NSString *)type;
    
- (BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard types:(NSArray *)types;
    

- (NSArray *)readablePasteboardTypes;
    
- (NSString *)preferredPasteboardTypeFromArray:(NSArray *)availableTypes restrictedToTypesFromArray:(NSArray *)allowedTypes;
    
- (BOOL)readSelectionFromPasteboard:(NSPasteboard *)pboard type:(NSString *)type;
    
- (BOOL)readSelectionFromPasteboard:(NSPasteboard *)pboard;
    
+ (void)registerForServices;
    
- (id)validRequestorForSendType:(NSString *)sendType returnType:(NSString *)returnType;
    
- (void)pasteAsPlainText:(id)sender;
- (void)pasteAsRichText:(id)sender;
    
|#
#| @INTERFACE 
NSTextView (NSDragging)

- (BOOL)dragSelectionWithEvent:(NSEvent *)event offset:(NSSize)mouseOffset slideBack:(BOOL)slideBack;
    
- (NSImage *)dragImageForSelectionWithEvent:(NSEvent *)event origin:(NSPointPointer)origin;
    
- (NSArray *)acceptableDragTypes;
    
- (unsigned int)dragOperationForDraggingInfo:(id <NSDraggingInfo>)dragInfo type:(NSString *)type;
        
- (void)cleanUpAfterDragOperation;
    


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (BOOL)acceptsGlyphInfo;
- (void)setAcceptsGlyphInfo:(BOOL)flag;
#endif
|#
#| @INTERFACE 
NSTextView (NSSharing)




- (void)setSelectedRange:(NSRange)charRange affinity:(NSSelectionAffinity)affinity stillSelecting:(BOOL)stillSelectingFlag;
- (NSSelectionAffinity)selectionAffinity;
- (NSSelectionGranularity)selectionGranularity;
- (void)setSelectionGranularity:(NSSelectionGranularity)granularity;

- (void)setSelectedTextAttributes:(NSDictionary *)attributeDictionary;
- (NSDictionary *)selectedTextAttributes;

- (void)setInsertionPointColor:(NSColor *)color;
- (NSColor *)insertionPointColor;

- (void)updateInsertionPointStateAndRestartTimer:(BOOL)restartFlag;

- (void)setMarkedTextAttributes:(NSDictionary *)attributeDictionary;
- (NSDictionary *)markedTextAttributes;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setLinkTextAttributes:(NSDictionary *)attributeDictionary;
- (NSDictionary *)linkTextAttributes;
#endif



- (void)setRulerVisible:(BOOL)flag;
- (BOOL)usesRuler;
- (void)setUsesRuler:(BOOL)flag;

- (void)setContinuousSpellCheckingEnabled:(BOOL)flag;
- (BOOL)isContinuousSpellCheckingEnabled;
- (void)toggleContinuousSpellChecking:(id)sender;

- (int)spellCheckerDocumentTag;

- (NSDictionary *)typingAttributes;
- (void)setTypingAttributes:(NSDictionary *)attrs;

- (BOOL)shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString;
- (void)didChangeText;

- (NSRange)rangeForUserTextChange;
- (NSRange)rangeForUserCharacterAttributeChange;
- (NSRange)rangeForUserParagraphAttributeChange;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setUsesFindPanel:(BOOL)flag;
- (BOOL)usesFindPanel;

- (void)setAllowsDocumentBackgroundColorChange:(BOOL)flag;
- (BOOL)allowsDocumentBackgroundColorChange;

- (void)setDefaultParagraphStyle:(NSParagraphStyle *)paragraphStyle;
- (NSParagraphStyle *)defaultParagraphStyle;
#endif



- (BOOL)isSelectable;
- (void)setSelectable:(BOOL)flag;
- (BOOL)isEditable;
- (void)setEditable:(BOOL)flag;
- (BOOL)isRichText;
- (void)setRichText:(BOOL)flag;
- (BOOL)importsGraphics;
- (void)setImportsGraphics:(BOOL)flag;
- (id)delegate;
- (void)setDelegate:(id)anObject;
- (BOOL)isFieldEditor;
- (void)setFieldEditor:(BOOL)flag;
- (BOOL)usesFontPanel;
- (void)setUsesFontPanel:(BOOL)flag;
- (BOOL)isRulerVisible;
- (void)setBackgroundColor:(NSColor *)color;
- (NSColor *)backgroundColor;
- (void)setDrawsBackground:(BOOL)flag;
- (BOOL)drawsBackground;

- (void)setSelectedRange:(NSRange)charRange;

- (BOOL)allowsUndo;
- (void)setAllowsUndo:(BOOL)flag;



- (BOOL)resignFirstResponder;
- (BOOL)becomeFirstResponder;



- (BOOL)smartInsertDeleteEnabled;
- (void)setSmartInsertDeleteEnabled:(BOOL)flag;
- (NSRange)smartDeleteRangeForProposedRange:(NSRange)proposedCharRange;

- (void)smartInsertForString:(NSString *)pasteString replacingRange:(NSRange)charRangeToReplace beforeString:(NSString **)beforeString afterString:(NSString **)afterString;
- (NSString *)smartInsertBeforeStringForString:(NSString *)pasteString replacingRange:(NSRange)charRangeToReplace;
- (NSString *)smartInsertAfterStringForString:(NSString *)pasteString replacingRange:(NSRange)charRangeToReplace;
    
|#
;  Note that all delegation messages come from the first textView
#| @INTERFACE 
NSObject (NSTextViewDelegate)

- (BOOL)textView:(NSTextView *)textView clickedOnLink:(id)link atIndex:(unsigned)charIndex;	
- (void)textView:(NSTextView *)textView clickedOnCell:(id <NSTextAttachmentCell>)cell inRect:(NSRect)cellFrame atIndex:(unsigned)charIndex;	
- (void)textView:(NSTextView *)textView doubleClickedOnCell:(id <NSTextAttachmentCell>)cell inRect:(NSRect)cellFrame atIndex:(unsigned)charIndex;
    
- (void)textView:(NSTextView *)view draggedCell:(id <NSTextAttachmentCell>)cell inRect:(NSRect)rect event:(NSEvent *)event atIndex:(unsigned)charIndex;	
- (NSArray *)textView:(NSTextView *)view writablePasteboardTypesForCell:(id <NSTextAttachmentCell>)cell atIndex:(unsigned)charIndex;	
- (BOOL)textView:(NSTextView *)view writeCell:(id <NSTextAttachmentCell>)cell atIndex:(unsigned)charIndex toPasteboard:(NSPasteboard *)pboard type:(NSString *)type ;	
- (NSRange)textView:(NSTextView *)textView willChangeSelectionFromCharacterRange:(NSRange)oldSelectedCharRange toCharacterRange:(NSRange)newSelectedCharRange;
    
- (void)textViewDidChangeSelection:(NSNotification *)notification;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)textViewDidChangeTypingAttributes:(NSNotification *)notification;

- (NSString *)textView:(NSTextView *)textView willDisplayToolTip:(NSString *)tooltip forCharacterAtIndex:(unsigned)characterIndex;
    
- (NSArray *)textView:(NSTextView *)textView completions:(NSArray *)words forPartialWordRange:(NSRange)charRange indexOfSelectedItem:(int *)index;
    #endif

- (BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString;
    
- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector;

- (BOOL)textView:(NSTextView *)textView clickedOnLink:(id)link;	
- (void)textView:(NSTextView *)textView clickedOnCell:(id <NSTextAttachmentCell>)cell inRect:(NSRect)cellFrame;	
- (void)textView:(NSTextView *)textView doubleClickedOnCell:(id <NSTextAttachmentCell>)cell inRect:(NSRect)cellFrame;      
- (void)textView:(NSTextView *)view draggedCell:(id <NSTextAttachmentCell>)cell inRect:(NSRect)rect event:(NSEvent *)event;	
- (NSUndoManager *)undoManagerForTextView:(NSTextView *)view; 
|#
(def-mactype :NSTextViewWillChangeNotifyingTextViewNotification (find-mactype '(:pointer :NSString)))
;  NSOldNotifyingTextView -> the old view, NSNewNotifyingTextView -> the new view.  The text view delegate is not automatically registered to receive this notification because the text machinery will automatically switch over the delegate to observe the new first text view as the first text view changes.
(def-mactype :NSTextViewDidChangeSelectionNotification (find-mactype '(:pointer :NSString)))
;  NSOldSelectedCharacterRange -> NSValue with old range.
(def-mactype :NSTextViewDidChangeTypingAttributesNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

(provide-interface "NSTextView")