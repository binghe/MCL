(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSNib.h"
; at Sunday July 2,2006 7:30:53 pm.
; 
; 	NSNib.h
; 	Application Kit
; 	Copyright (c) 2003, Apple Computer, Inc.
; 	All rights reserved.
; 
; NSNib serves as a wrapper around a single InterfaceBuilder nib.  When an NSNib instance is created from a nib file, all of the data needed to instantiate the nib (the object graph as well as images and sounds that might be in the nib bundle) are read from the disk, however the nib is not instantiated until you call one of the instantiation methods.
; 
; As such, a nib that is used repeatedly can be loaded from the disk only once, and can then perform countless instantiations, thereby reducing hits to the disk (at the expense of added memory for keeping the unarchived nib data around).
; 
; NSNib implemenents NSCoding protocol.  For example, using NSNib, the entire contents of a nib can be archived and sent to another system for unarchiving.  The target system need not save the nib locally to open it (a shortcoming of the current NSBundle nib loading API).  NSNib's implementation encodes all sound and image resources contained locally within the nib bundle.  Note, it DOES NOT encode resources that are referenced outside of the nib bundle.
; 
; As are all NSObjects, instantiated nib objects are allocated in a memory zone (NSZone).  If an NSNibOwner is provided for instantiation, then the objects will be allocated in the owner's zone.  If no NSNibOwner is provided, the resulting objects will be allocated in the default zone.
; 

; #import <Foundation/Foundation.h>

; #import <AppKit/AppKitDefines.h>
;  NSNib is a post Jaguar feature

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSNib : NSObject <NSCoding> {
   private
    NSData *_data;
    NSArray *_images;
    NSArray *_sounds;
    NSBundle *_bundle;
    struct _NSNibFlags {
        unsigned int _isKeyed:1;
        unsigned int _reserved:31;
    } _flags;
    id reserved1;
    id reserved2;

}

- (id)initWithContentsOfURL:(NSURL *)nibFileURL;

- (id)initWithNibNamed:(NSString *)nibName bundle:(NSBundle *)bundle;

- (BOOL)instantiateNibWithExternalNameTable:(NSDictionary *)externalNameTable;

- (BOOL)instantiateNibWithOwner:(id)owner topLevelObjects:(NSArray **)topLevelObjects;

|#
;  ** External Name Table Keys **
;  Note: the actual values of these defines match the
;  older NSBundle nib loading values for backward compatibility.
;  This should specify the nib file's owner (required)
(def-mactype :NSNibOwner (find-mactype '(:pointer :NSString)))
;  This should be an NSMutableArray that will be filled with the top level objects
;  of the newly instantiated nib (opional)
(def-mactype :NSNibTopLevelObjects (find-mactype '(:pointer :NSString)))

; #endif


(provide-interface "NSNib")