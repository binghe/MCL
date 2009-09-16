(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDocumentController.h"
; at Sunday July 2,2006 7:30:46 pm.
; 
;  	NSDocumentController.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/NSNibDeclarations.h>

; #import <AppKit/NSUserInterfaceValidation.h>
;  ================================================================================
;  NSDocumentController
;  ================================================================================
#| @INTERFACE 
NSDocumentController : NSObject <NSCoding> {
    private
    id _documents;
    struct __controllerFlags {
        unsigned int shouldCreateUI:1;
        unsigned int notingRecentNSDocument:1;
        unsigned int RESERVED:30;
    } _controllerFlags;
    NSArray *_types;      NSMutableArray *_recents;
    int _recentsLimit;
}


+ (id)sharedDocumentController;
    
- (id)init;
    

- (NSArray *)documents;
    
- (id)currentDocument;
- (NSString *)currentDirectory;
        
- (id)documentForWindow:(NSWindow *)window;
- (id)documentForFileName:(NSString *)fileName;
    
- (void)addDocument:(NSDocument *)document;
- (void)removeDocument:(NSDocument *)document;
    

- (id)makeUntitledDocumentOfType:(NSString *)type;
- (id)makeDocumentWithContentsOfFile:(NSString *)fileName ofType:(NSString *)type;
- (id)makeDocumentWithContentsOfURL:(NSURL *)url ofType:(NSString *)type;
    
- (id)openUntitledDocumentOfType:(NSString*)type display:(BOOL)display;
- (id)openDocumentWithContentsOfFile:(NSString *)fileName display:(BOOL)display;
- (id)openDocumentWithContentsOfURL:(NSURL *)url display:(BOOL)display;
    
- (BOOL)shouldCreateUI;
- (void)setShouldCreateUI:(BOOL)flag;
    

- (IBAction)saveAllDocuments:(id)sender;
- (IBAction)openDocument:(id)sender;
- (IBAction)newDocument:(id)sender;
    
- (BOOL)validateUserInterfaceItem:(id <NSValidatedUserInterfaceItem>)anItem;
    
- (BOOL)validateMenuItem:(NSMenuItem *)anItem;
    

- (NSArray *)fileNamesFromRunningOpenPanel;
- (NSArray *)URLsFromRunningOpenPanel;
        
- (int)runModalOpenPanel:(NSOpenPanel *)openPanel forTypes:(NSArray *)openableFileExtensions;
    

- (BOOL)closeAllDocuments;
    
    
- (void)closeAllDocumentsWithDelegate:(id)delegate didCloseAllSelector:(SEL)didAllCloseSelector contextInfo:(void *)contextInfo;
            

- (BOOL)reviewUnsavedDocumentsWithAlertTitle:(NSString *)title cancellable:(BOOL)cancellable;
    
    
- (void)reviewUnsavedDocumentsWithAlertTitle:(NSString *)title cancellable:(BOOL)cancellable delegate:(id)delegate didReviewAllSelector:(SEL)didReviewAllSelector contextInfo:(void *)contextInfo;
            

- (BOOL)hasEditedDocuments;
    

- (NSString *)displayNameForType:(NSString *)documentTypeName;
- (NSString *)typeFromFileExtension:(NSString *)fileNameExtensionOrHFSFileType;
- (NSArray *)fileExtensionsFromType:(NSString *)documentTypeName;
- (Class)documentClassForType:(NSString *)documentTypeName;
    

- (NSArray *)recentDocumentURLs;
    
- (void)noteNewRecentDocumentURL:(NSURL *)url;
    - (void)noteNewRecentDocument:(NSDocument *)document;
    
- (IBAction)clearRecentDocuments:(id)sender;
    
|#

(provide-interface "NSDocumentController")