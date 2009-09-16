(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDragging.h"
; at Sunday July 2,2006 7:30:46 pm.
; 
; 	NSDragging.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <limits.h>

(def-mactype :NSDragOperation (find-mactype ':UInt32))

(defconstant $NSDragOperationNone 0)
(defconstant $NSDragOperationCopy 1)
(defconstant $NSDragOperationLink 2)
(defconstant $NSDragOperationGeneric 4)
(defconstant $NSDragOperationPrivate 8)
(defconstant $NSDragOperationAll_Obsolete 15)
(defconstant $NSDragOperationMove 16)
(defconstant $NSDragOperationDelete 32)
(defconstant $NSDragOperationEvery $uint_max)
;  NSDragOperationAll is deprecated - please use NSDragOperationEvery
; #define NSDragOperationAll NSDragOperationAll_Obsolete
;  protocol for the sender argument of the messages sent to a drag destination.  The view or
;    window that registered dragging types sends these messages as dragging is
;    happening to find out details about that session of dragging.
;  
#| @PROTOCOL 
NSDraggingInfo
- (NSWindow *)draggingDestinationWindow;
- (NSDragOperation)draggingSourceOperationMask;
- (NSPoint)draggingLocation;
- (NSPoint)draggedImageLocation;
- (NSImage *)draggedImage;
- (NSPasteboard *)draggingPasteboard;
- (id)draggingSource;
- (int)draggingSequenceNumber;
- (void)slideDraggedImageTo:(NSPoint)screenPoint;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (NSArray *)namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination;
#endif
|#
;  Methods implemented by an object that receives dragged images.  The
;    destination view or window is sent these messages during dragging if it
;    responds to them.
;  
#| @INTERFACE 
NSObject(NSDraggingDestination)
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender;
- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender; 
- (void)draggingExited:(id <NSDraggingInfo>)sender;
- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender;
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender;
- (void)concludeDragOperation:(id <NSDraggingInfo>)sender;
- (void)draggingEnded:(id <NSDraggingInfo>)sender;
|#
;  Methods implemented by an object that initiates a drag session.  The
;    source app is sent these messages during dragging.  The first must be
;    implemented, the others are sent if the source responds to them.
;  
#| @INTERFACE 
NSObject(NSDraggingSource)
- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)flag;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (NSArray *)namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination;
#endif
- (void)draggedImage:(NSImage *)image beganAt:(NSPoint)screenPoint;
- (void)draggedImage:(NSImage *)image endedAt:(NSPoint)screenPoint operation:(NSDragOperation)operation;
- (void)draggedImage:(NSImage *)image movedTo:(NSPoint)screenPoint;
- (BOOL)ignoreModifierKeysWhileDragging;

- (void)draggedImage:(NSImage *)image endedAt:(NSPoint)screenPoint deposited:(BOOL)flag;
|#

(provide-interface "NSDragging")