(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSUndoManager.h"
; at Sunday July 2,2006 7:31:03 pm.
; 	NSUndoManager.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 
; 
;  NSUndoManager is a general-purpose undo stack where clients can register
;  callbacks to be invoked should an undo be requested.
; 

; #import <Foundation/NSObject.h>
;  used with NSRunLoop's performSelector:target:argument:order:modes:

(defconstant $NSUndoCloseGroupingRunLoopOrdering #x55730)
#| @INTERFACE 
NSUndoManager : NSObject
{
    private
    id 			_undoStack;
    id 			_redoStack;
    NSArray 		*_runLoopModes;
    int 		_disabled;
    struct {
        unsigned int undoing:1;
        unsigned int redoing:1;
        unsigned int registeredForCallback:1;
        unsigned int postingCheckpointNotification:1;
        unsigned int groupsByEvent:1;
        unsigned int reserved:27;
    } _flags;

    id 			_target;		
    void		*_NSUndoManagerReserved1;
    void		*_NSUndoManagerReserved2;
    void		*_NSUndoManagerReserved3;
}

        

- (void)beginUndoGrouping;
- (void)endUndoGrouping;
    
- (int)groupingLevel;
    
        

- (void)disableUndoRegistration;
- (void)enableUndoRegistration;
- (BOOL)isUndoRegistrationEnabled;

        

- (BOOL)groupsByEvent;
- (void)setGroupsByEvent:(BOOL)groupsByEvent;
            
        

- (void)setLevelsOfUndo:(unsigned)levels;
- (unsigned)levelsOfUndo;
            
        

- (void)setRunLoopModes:(NSArray *)runLoopModes;
- (NSArray *)runLoopModes;

        

- (void)undo;
            - (void)redo;
    
- (void)undoNestedGroup;
        
- (BOOL)canUndo;
- (BOOL)canRedo;
    
- (BOOL)isUndoing;
- (BOOL)isRedoing;
        
        

- (void)removeAllActions;

- (void)removeAllActionsWithTarget:(id)target;
        
        

- (void)registerUndoWithTarget:(id)target selector:(SEL)selector object:(id)anObject;

        

- (id)prepareWithInvocationTarget:(id)target;
            
- (void)forwardInvocation:(NSInvocation *)anInvocation;

    	

- (NSString *)undoActionName;
- (NSString *)redoActionName;
        
- (void)setActionName:(NSString *)actionName;
        
    	

- (NSString *)undoMenuItemTitle;
- (NSString *)redoMenuItemTitle;
            
    	

- (NSString *)undoMenuTitleForUndoActionName:(NSString *)actionName;
- (NSString *)redoMenuTitleForUndoActionName:(NSString *)actionName;
            
|#
(def-mactype :NSUndoManagerCheckpointNotification (find-mactype '(:pointer :NSString)))
;  This is called before an undo group is begun or ended so any
;  clients that need to lazily register undos can do so in the
;  correct group.
(def-mactype :NSUndoManagerWillUndoChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSUndoManagerWillRedoChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSUndoManagerDidUndoChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSUndoManagerDidRedoChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSUndoManagerDidOpenUndoGroupNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSUndoManagerWillCloseUndoGroupNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSUndoManager")