(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPrintOperation.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
; 	NSPrintOperation.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <AppKit/AppKitDefines.h>
(def-mactype :_NSPrintingPageOrder (find-mactype ':sint32))

(defconstant $NSDescendingPageOrder -1)
(defconstant $NSSpecialPageOrder 0)             ;  Tells spooler to not rearrange

(defconstant $NSAscendingPageOrder 1)
(defconstant $NSUnknownPageOrder 2)             ;  No page order written out

(def-mactype :NSPrintingPageOrder (find-mactype ':SINT32))
; **** Exceptions ****
(def-mactype :NSPrintOperationExistsException (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSPrintOperation : NSObject
{
}

+ (NSPrintOperation *)printOperationWithView:(NSView *)aView;
+ (NSPrintOperation *)printOperationWithView:(NSView *)aView printInfo:(NSPrintInfo *)aPrintInfo;

+ (NSPrintOperation *)EPSOperationWithView:(NSView *)aView insideRect:(NSRect)rect toData:(NSMutableData *)data;
+ (NSPrintOperation *)EPSOperationWithView:(NSView *)aView insideRect:(NSRect)rect toData:(NSMutableData *)data printInfo:(NSPrintInfo *)aPrintInfo;
+ (NSPrintOperation *)EPSOperationWithView:(NSView *)aView insideRect:(NSRect)rect toPath:(NSString *)path printInfo:(NSPrintInfo *)aPrintInfo;

+ (NSPrintOperation *)PDFOperationWithView:(NSView *)aView insideRect:(NSRect)rect toData:(NSMutableData *)data;
+ (NSPrintOperation *)PDFOperationWithView:(NSView *)aView insideRect:(NSRect)rect toData:(NSMutableData *)data printInfo:(NSPrintInfo *)aPrintInfo;
+ (NSPrintOperation *)PDFOperationWithView:(NSView *)aView insideRect:(NSRect)rect toPath:(NSString *)path printInfo:(NSPrintInfo *)aPrintInfo;


+ (NSPrintOperation *)currentOperation;
+ (void)setCurrentOperation:(NSPrintOperation *)operation;


- (BOOL)isCopyingOperation;


- (BOOL)runOperation;


- (void)runOperationModalForWindow:(NSWindow *)docWindow delegate:(id)delegate didRunSelector:(SEL)didRunSelector contextInfo:(void *)contextInfo;


- (void)setCanSpawnSeparateThread:(BOOL)canSpawnSeparateThread;
- (BOOL)canSpawnSeparateThread;


- (void)setShowPanels:(BOOL)flag;
- (BOOL)showPanels;


- (void)setPrintPanel:(NSPrintPanel *)panel;
- (NSPrintPanel *)printPanel;


- (void)setAccessoryView:(NSView *)aView;
- (NSView *)accessoryView;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

- (void)setJobStyleHint:(NSString *)hint;
- (NSString *)jobStyleHint;

#endif


- (void)setPrintInfo:(NSPrintInfo *)aPrintInfo;
- (NSPrintInfo *)printInfo;


- (NSView *)view;


- (int)currentPage;


- (void)setPageOrder:(NSPrintingPageOrder)order;
- (NSPrintingPageOrder)pageOrder;


- (NSGraphicsContext *)context;


- (NSGraphicsContext *)createContext;


- (void)destroyContext;


- (BOOL)deliverResult;


- (void)cleanUpOperation;


|#

(provide-interface "NSPrintOperation")