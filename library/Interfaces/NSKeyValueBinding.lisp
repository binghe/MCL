(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSKeyValueBinding.h"
; at Sunday July 2,2006 7:30:51 pm.
; 
; 	NSKeyValueBinding.h
; 	Application Kit
; 	Copyright (c) 2002-2003, Apple Computer, Inc.
; 	All rights reserved.
;  

; #import <AppKit/AppKitDefines.h>

; #import <Foundation/NSObject.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
(def-mactype :NSMultipleValuesMarker (find-mactype ':id))
(def-mactype :NSNoSelectionMarker (find-mactype ':id))
(def-mactype :NSNotApplicableMarker (find-mactype ':id))

(deftrap-inline "_NSIsControllerMarker" 
   ((object :UInt32)
   )
   :Boolean
() )
#| @INTERFACE 
NSObject (NSKeyValueBindingCreation)

+ (void)exposeBinding:(NSString *)binding;    - (NSArray *)exposedBindings;   - (Class)valueClassForBinding:(NSString *)binding;    
- (void)bind:(NSString *)binding toObject:(id)observable withKeyPath:(NSString *)keyPath options:(NSDictionary *)options;    - (void)unbind:(NSString *)binding;

|#
#| @INTERFACE 
NSObject (NSPlaceholders)

+ (void)setDefaultPlaceholder:(id)placeholder forMarker:(id)marker withBinding:(NSString *)binding;    + (id)defaultPlaceholderForMarker:(id)marker withBinding:(NSString *)binding;    
|#
;  methods implemented by controllers (and potentially documents)
#| @INTERFACE 
NSObject (NSEditorRegistration)

- (void)objectDidBeginEditing:(id)editor;
- (void)objectDidEndEditing:(id)editor;

|#
;  methods implemented by controllers and user interface elements
#| @INTERFACE 
NSObject (NSEditor)

- (void)discardEditing;    - (BOOL)commitEditing;    
|#

; #endif


(provide-interface "NSKeyValueBinding")