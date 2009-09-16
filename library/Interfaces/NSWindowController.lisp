(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSWindowController.h"
; at Sunday July 2,2006 7:31:06 pm.
; 
; 	NSWindowController.h
; 	Application Kit
; 	Copyright (c) 1997-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSResponder.h>

; #import <AppKit/NSNibDeclarations.h>
#| @INTERFACE 
NSWindowController : NSResponder <NSCoding> {
    private
    NSWindow *_window;
    NSString *_windowNibName;
    NSDocument *_document;
    NSArray *_topLevelObjects;
    id _owner;
    struct __wcFlags {
        unsigned int shouldCloseDocument:1;
        unsigned int shouldCascade:1;
        unsigned int nibIsLoaded:1;
        unsigned int nibNameIsPath:1;
        unsigned int RESERVED:28;
    } _wcFlags;
    void *_reserved1;
    void *_reserved2;
}

- (id)initWithWindow:(NSWindow *)window;
    
- (id)initWithWindowNibName:(NSString *)windowNibName;	- (id)initWithWindowNibName:(NSString *)windowNibName owner:(id)owner;
- (id)initWithWindowNibPath:(NSString *)windowNibPath owner:(id)owner;
    

- (NSString *)windowNibName;
        
- (NSString *)windowNibPath;  
        
- (id)owner;
    
- (void)setWindowFrameAutosaveName:(NSString *)name;
- (NSString *)windowFrameAutosaveName;
    
- (void)setShouldCascadeWindows:(BOOL)flag;
- (BOOL)shouldCascadeWindows;
        

- (id)document;
        
- (void)setDocument:(NSDocument *)document;
    
- (void)setDocumentEdited:(BOOL)dirtyFlag;
    
- (void)setShouldCloseDocument:(BOOL)flag;
- (BOOL)shouldCloseDocument;
    

- (void)setWindow:(NSWindow *)window;
        
- (NSWindow *)window;
    
- (void)synchronizeWindowTitleWithDocumentName;
    
- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName;
    
- (void)close;
        
- (IBAction)showWindow:(id)sender;
    

- (BOOL)isWindowLoaded;
    
- (void)windowDidLoad;
- (void)windowWillLoad;
    
- (void)loadWindow;
    
|#

(provide-interface "NSWindowController")