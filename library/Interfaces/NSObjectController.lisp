(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSObjectController.h"
; at Sunday July 2,2006 7:30:54 pm.
; 
; 	NSObjectController.h
; 	Application Kit
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
;  

; #import <AppKit/NSController.h>

; #import <AppKit/NSMenu.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSObjectController : NSController {
private
	void *_reserved3;
	void *_reserved4;
    struct __objectControllerFlags {
        unsigned int _editable:1;
        unsigned int _automaticallyPreparesContent:1;
        unsigned int _hasLoadedData:1;
        unsigned int _explicitlyCannotAdd:1;
        unsigned int _explicitlyCannotRemove:1;
        unsigned int _reservedObjectController:27;
    } _objectControllerFlags;
    NSString *_objectClassName;
    Class _objectClass;
    NSArray *_contentObjectArray;
protected    	id _content;
    id _objectHandler;
}

- (id)initWithContent:(id)content;

- (void)setContent:(id)content;
- (id)content;

- (id)selection;    - (NSArray *)selectedObjects;    
- (void)setAutomaticallyPreparesContent:(BOOL)flag;    - (BOOL)automaticallyPreparesContent;
- (void)prepareContent;    
- (void)setObjectClass:(Class)objectClass;    - (Class)objectClass;
- (id)newObject;    - (void)addObject:(id)object;    - (void)removeObject:(id)object;    
- (void)setEditable:(BOOL)flag;    - (BOOL)isEditable;
- (void)add:(id)sender;    - (BOOL)canAdd;    - (void)remove:(id)sender;    - (BOOL)canRemove;    - (BOOL)validateMenuItem:(id <NSMenuItem>)menuItem;    
|#

; #endif


(provide-interface "NSObjectController")