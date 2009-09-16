(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSFileWrapper.h"
; at Sunday July 2,2006 7:30:48 pm.
; 
;         NSFileWrapper.h
;         Application Kit
;         Copyright (c) 1995-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSFileWrapper : NSObject <NSCoding> {
  
  private
    id _impl;
    NSString *_fileName;
    NSString *_preferredFileName;
    NSDictionary *_fileAttributes;
    NSImage *_image;
    id _subdocuments;
}


- (id)initDirectoryWithFileWrappers:(NSDictionary *)docs;
    
- (id)initRegularFileWithContents:(NSData *)data;
    
- (id)initSymbolicLinkWithDestination:(NSString *)path;
    
- (id)initWithPath:(NSString *)path;
    
- (id)initWithSerializedRepresentation:(NSData *)data;
    

- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)atomicFlag updateFilenames:(BOOL)updateFilenamesFlag;
    
- (NSData *)serializedRepresentation;
    
- (void)setFilename:(NSString *)filename;
- (NSString *)filename;
    
- (void)setPreferredFilename:(NSString *)filename;
- (NSString *)preferredFilename;
    
- (void)setFileAttributes:(NSDictionary *)attributes;
- (NSDictionary *)fileAttributes;
    
- (BOOL)isRegularFile;
- (BOOL)isDirectory;
- (BOOL)isSymbolicLink;
    
- (void)setIcon:(NSImage *)icon;
- (NSImage *)icon;
    
- (BOOL)needsToBeUpdatedFromPath:(NSString *)path;
- (BOOL)updateFromPath:(NSString *)path;
    


- (NSString *)addFileWrapper:(NSFileWrapper *)doc;
    
- (void)removeFileWrapper:(NSFileWrapper *)doc;
    
- (NSDictionary *)fileWrappers;
    
- (NSString *)keyForFileWrapper:(NSFileWrapper *)doc;
    
- (NSString *)addFileWithPath:(NSString *)path;
- (NSString *)addRegularFileWithContents:(NSData *)data preferredFilename:(NSString *)filename;
- (NSString *)addSymbolicLinkWithDestination:(NSString *)path preferredFilename:(NSString *)filename;
    


- (NSData *)regularFileContents;
    


- (NSString *)symbolicLinkDestination;
    
|#

(provide-interface "NSFileWrapper")