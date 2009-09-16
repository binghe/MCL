(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScriptExecutionContext.h"
; at Sunday July 2,2006 7:30:58 pm.
; 	NSScriptExecutionContext.h
; 	Copyright (c) 1997-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
#| @INTERFACE 
NSScriptExecutionContext : NSObject {
    private
    id _topLevelObject;
    id _objectBeingTested;
    id _rangeContainerObject;

    NSConnection *_connection;
}

+ (NSScriptExecutionContext *)sharedScriptExecutionContext;

- (id)topLevelObject;
- (void)setTopLevelObject:(id)obj;

- (id)objectBeingTested;
- (void)setObjectBeingTested:(id)obj;

- (id)rangeContainerObject;
- (void)setRangeContainerObject:(id)obj;

|#

(provide-interface "NSScriptExecutionContext")