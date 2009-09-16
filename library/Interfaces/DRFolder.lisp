(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRFolder.h"
; at Sunday July 2,2006 7:27:42 pm.
; 
;      File:       DiscRecordingContent/DRFolder.h
;  
;      Contains:   ObjC interface to folder objects used in filesystem creation.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Foundation/Foundation.h>

; #import <DiscRecordingContent/DRFSObject.h>
; !
; 	@class		DRFolder
; 	@abstract	represents a folder to be created on the disc.
; 	@discussion	DRFolders can be either a pointer to a real folder on disk or can be a "virtual" folder. 
; 				A DRFolder pointing to a real folder cannot have it's contents changed - only
; 				those files/folders which are children of the actual folder on disk will 
; 				be included on the resulting disc. "Virtual" folders are entirely created 
; 				programatically and any virtual folder structure can exist and be burned 
; 				to disc.
; 
#| @INTERFACE 
DRFolder : DRFSObject
{ }


+ (DRFolder*) folderWithPath:(NSString*)path;


- (id) initWithPath:(NSString*)path;

|#
#| @INTERFACE 
DRFolder (VirtualFolders)


+ (DRFolder*) virtualFolderWithName:(NSString*)name;


- (id) initWithName:(NSString*)name;


- (void) makeVirtual;


- (void) addChild:(DRFSObject*)child;


- (void) removeChild:(DRFSObject*)child;


- (uint32_t) count;


- (NSArray*) children;

|#

(provide-interface "DRFolder")