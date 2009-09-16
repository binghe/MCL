(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDocument.h"
; at Sunday July 2,2006 7:30:46 pm.
; 
;         NSDocument.h
;         Application Kit
;         Copyright (c) 1997-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <AppKit/NSNibDeclarations.h>

; #import <AppKit/NSUserInterfaceValidation.h>
;  ================================================================================
;  Document enumerated types
;  ================================================================================
(def-mactype :_NSDocumentChangeType (find-mactype ':sint32))

(defconstant $NSChangeDone 0)
(defconstant $NSChangeUndone 1)
(defconstant $NSChangeCleared 2)
(def-mactype :NSDocumentChangeType (find-mactype ':SINT32))
(def-mactype :_NSSaveOperationType (find-mactype ':sint32))

(defconstant $NSSaveOperation 0)
(defconstant $NSSaveAsOperation 1)
(defconstant $NSSaveToOperation 2)
(def-mactype :NSSaveOperationType (find-mactype ':SINT32))
;  ================================================================================
;  NSDocument
;  ================================================================================
#| @INTERFACE 
NSDocument : NSObject {
    private
    NSWindow *_window;
    id _windowControllers;
    NSString *_fileName;
    NSString *_fileType;
    NSPrintInfo *_printInfo;
    long _changeCount;
    NSView *savePanelAccessory;
    id _displayName;
    void *_privateData;
    NSUndoManager *_undoManager;
    struct __docFlags {
        unsigned int inClose:1;
        unsigned int hasUndoManager:1;
        unsigned int isShowingPageLayout:1;
        unsigned int isRunningPrintOperation:1;
        unsigned int savePanelNameExtensionHidden:1;
        unsigned int reconciledToFileName:1;
        unsigned int checkingDisplayName:1;
        unsigned int RESERVED:25;
    } _docFlags;
    NSString *_savePanelSaveType;
}

- (id)init;
        
- (id)initWithContentsOfFile:(NSString *)fileName ofType:(NSString *)fileType;
- (id)initWithContentsOfURL:(NSURL *)url ofType:(NSString *)fileType;
    

- (NSArray *)windowControllers;
    
- (void)addWindowController:(NSWindowController *)windowController;
    
- (void)removeWindowController:(NSWindowController *)windowController;
    
- (NSString *)windowNibName;
        
- (void)makeWindowControllers;
    
- (void)showWindows;
    
- (BOOL)shouldCloseWindowController:(NSWindowController *)windowController;
    
    
- (void)shouldCloseWindowController:(NSWindowController *)windowController delegate:(id)delegate shouldCloseSelector:(SEL)callback contextInfo:(void *)contextInfo;
        
- (void)setWindow:(NSWindow *)window;
    
- (void)windowControllerWillLoadNib:(NSWindowController *)windowController;
- (void)windowControllerDidLoadNib:(NSWindowController *)windowController;
    
#if MAC_OS_X_VERSION_10_1 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (NSWindow *)windowForSheet;

#endif


- (BOOL)isDocumentEdited;
    
- (void)updateChangeCount:(NSDocumentChangeType)change;
        
- (BOOL)canCloseDocument;
    
    
- (void)canCloseDocumentWithDelegate:(id)delegate shouldCloseSelector:(SEL)shouldCloseSelector contextInfo:(void *)contextInfo;
            
- (void)close;
    
- (NSUndoManager *)undoManager;
- (void)setUndoManager:(NSUndoManager *)undoManager;
- (BOOL)hasUndoManager;
- (void)setHasUndoManager:(BOOL)flag;
    

- (NSString *)fileName;
- (void)setFileName:(NSString *)fileName;
    
- (NSString *)fileType;
- (void)setFileType:(NSString *)type;
    
- (NSString *)displayName;
    


- (NSData *)dataRepresentationOfType:(NSString *)type;
- (BOOL)loadDataRepresentation:(NSData *)data ofType:(NSString *)type;
    
- (NSFileWrapper *)fileWrapperRepresentationOfType:(NSString *)type;
- (BOOL)loadFileWrapperRepresentation:(NSFileWrapper *)wrapper ofType:(NSString *)type;
    
- (BOOL)writeToFile:(NSString *)fileName ofType:(NSString *)type;
- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)type;
- (BOOL)readFromFile:(NSString *)fileName ofType:(NSString *)type;
- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)type;
    

- (BOOL)keepBackupFile;
    
- (BOOL)writeWithBackupToFile:(NSString *)fullDocumentPath ofType:(NSString *)documentTypeName saveOperation:(NSSaveOperationType)saveOperationType;
    
- (BOOL)writeToFile:(NSString *)fullDocumentPath ofType:(NSString *)documentTypeName originalFile:(NSString *)fullOriginalDocumentPath saveOperation:(NSSaveOperationType)saveOperationType;
    
- (NSDictionary *)fileAttributesToWriteToFile:(NSString *)fullDocumentPath ofType:(NSString *)documentTypeName saveOperation:(NSSaveOperationType)saveOperationType;
    
- (BOOL)revertToSavedFromFile:(NSString *)fileName ofType:(NSString *)type;
- (BOOL)revertToSavedFromURL:(NSURL *)url ofType:(NSString *)type;
    


- (IBAction)saveDocument:(id)sender;
- (IBAction)saveDocumentAs:(id)sender;
- (IBAction)saveDocumentTo:(id)sender;
- (IBAction)revertDocumentToSaved:(id)sender;
    


- (NSString *)fileNameFromRunningSavePanelForSaveOperation:(NSSaveOperationType)saveOperation;
    
    
- (void)saveDocumentWithDelegate:(id)delegate didSaveSelector:(SEL)didSaveSelector contextInfo:(void *)contextInfo;
            
- (void)saveToFile:(NSString *)fileName saveOperation:(NSSaveOperationType)saveOperation delegate:(id)delegate didSaveSelector:(SEL)didSaveSelector contextInfo:(void *)contextInfo;
            

- (NSString *)fileTypeFromLastRunSavePanel;
    
- (BOOL)fileNameExtensionWasHiddenInLastRunSavePanel;
    
- (BOOL)shouldRunSavePanelWithAccessoryView;
    
- (int)runModalSavePanel:(NSSavePanel *)savePanel withAccessoryView:(NSView *)accessoryView;
    
    
- (void)runModalSavePanelForSaveOperation:(NSSaveOperationType)saveOperation delegate:(id)delegate didSaveSelector:(SEL)didSaveSelector contextInfo:(void *)contextInfo;
            
- (BOOL)prepareSavePanel:(NSSavePanel *)savePanel;
    

- (NSPrintInfo *)printInfo;
- (void)setPrintInfo:(NSPrintInfo *)printInfo;
        
- (int)runModalPageLayoutWithPrintInfo:(NSPrintInfo *)printInfo;
    
- (void)runModalPageLayoutWithPrintInfo:(NSPrintInfo *)printInfo delegate:(id)delegate didRunSelector:(SEL)didRunSelector contextInfo:(void *)contextInfo;
            
- (BOOL)shouldChangePrintInfo:(NSPrintInfo *)newPrintInfo;
    
- (IBAction)runPageLayout:(id)sender;
    
- (BOOL)preparePageLayout:(NSPageLayout *)pageLayout;
    
- (void)runModalPrintOperation:(NSPrintOperation *)printOperation delegate:(id)delegate didRunSelector:(SEL)didRunSelector contextInfo:(void *)contextInfo;
            
- (void)printShowingPrintPanel:(BOOL)flag;
        
- (IBAction)printDocument:(id)sender;
    

- (BOOL)validateUserInterfaceItem:(id <NSValidatedUserInterfaceItem>)anItem;
    - (BOOL)validateMenuItem:(NSMenuItem *)anItem;
    

+ (NSArray *)readableTypes;
        
+ (NSArray *)writableTypes;
        
+ (BOOL)isNativeType:(NSString *)type;
        
|#

(provide-interface "NSDocument")