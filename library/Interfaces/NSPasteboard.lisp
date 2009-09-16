(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPasteboard.h"
; at Sunday July 2,2006 7:30:55 pm.
; 
; 	NSPasteboard.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSURL.h>

; #import <AppKit/AppKitDefines.h>
;  standard Pasteboard types 
(def-mactype :NSStringPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSFilenamesPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSPostScriptPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSTIFFPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSRTFPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSTabularTextPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSFontPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSRulerPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSFileContentsPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSColorPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSRTFDPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSHTMLPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSPICTPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSURLPboardType (find-mactype '(:pointer :NSString)))
(def-mactype :NSPDFPboardType (find-mactype '(:pointer :NSString)))

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
(def-mactype :NSVCardPboardType (find-mactype '(:pointer :NSString)))
;  HFS Promise type for dragging only
(def-mactype :NSFilesPromisePboardType (find-mactype '(:pointer :NSString)))

; #endif

;  standard Pasteboard names 
(def-mactype :NSGeneralPboard (find-mactype '(:pointer :NSString)))
(def-mactype :NSFontPboard (find-mactype '(:pointer :NSString)))
(def-mactype :NSRulerPboard (find-mactype '(:pointer :NSString)))
(def-mactype :NSFindPboard (find-mactype '(:pointer :NSString)))
(def-mactype :NSDragPboard (find-mactype '(:pointer :NSString)))

(deftrap-inline "_NSCreateFilenamePboardType" 
   ((fileType (:pointer :NSString))
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSCreateFileContentsPboardType" 
   ((fileType (:pointer :NSString))
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSGetFileType" 
   ((pboardType (:pointer :NSString))
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSGetFileTypes" 
   ((pboardTypes (:pointer :nsarray))
   )
   (:pointer :nsarray)
() )
#| @INTERFACE 
NSPasteboard : NSObject
{
    private
    void *		_pboard;
    int			_gen;
    void *		_owners;
    void *		_reserved[8];
}

+ (NSPasteboard *)generalPasteboard;
+ (NSPasteboard *)pasteboardWithName:(NSString *)name;
+ (NSPasteboard *)pasteboardWithUniqueName;

+ (NSArray *)typesFilterableTo:(NSString *)type;

+ (NSPasteboard *)pasteboardByFilteringFile:(NSString *)filename;
+ (NSPasteboard *)pasteboardByFilteringData:(NSData *)data ofType:(NSString *)type;
+ (NSPasteboard *)pasteboardByFilteringTypesInPasteboard:(NSPasteboard *)pboard;

- (NSString *)name;

- (void)releaseGlobally;

- (int)declareTypes:(NSArray *)newTypes owner:(id)newOwner;
- (int)addTypes:(NSArray *)newTypes owner:(id)newOwner;
- (int)changeCount;

- (NSArray *)types;
- (NSString *)availableTypeFromArray:(NSArray *)types;

- (BOOL)setData:(NSData *)data forType:(NSString *)dataType;
- (NSData *)dataForType:(NSString *)dataType;

- (BOOL)setPropertyList:(id)plist forType:(NSString *)dataType;
- (id)propertyListForType:(NSString *)dataType;

- (BOOL)setString:(NSString *)string forType:(NSString *)dataType;
- (NSString *)stringForType:(NSString *)dataType;

|#
#| @INTERFACE 
NSPasteboard(NSFileContents)
- (BOOL)writeFileContents:(NSString *)filename;
- (NSString *)readFileContentsType:(NSString *)type toFile:(NSString *)filename;

- (BOOL)writeFileWrapper:(NSFileWrapper *)wrapper;
- (NSFileWrapper *)readFileWrapper;

|#
#| @INTERFACE 
NSURL(NSPasteboardSupport)
+ (NSURL *)URLFromPasteboard:(NSPasteboard *)pasteBoard;
- (void)writeToPasteboard:(NSPasteboard *)pasteBoard;
|#
#| @INTERFACE 
NSObject(NSPasteboardOwner)
- (void)pasteboard:(NSPasteboard *)sender provideDataForType:(NSString *)type;
- (void)pasteboardChangedOwner:(NSPasteboard *)sender;
|#

(provide-interface "NSPasteboard")