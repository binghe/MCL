(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSplitView.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
; 	NSSplitView.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSView.h>
#| @INTERFACE 
NSSplitView : NSView {
    
    void *_data;
}

- (void)setDelegate:(id)anObject;
- (id)delegate;
- (void)adjustSubviews;
- (float)dividerThickness;
- (void)drawDividerInRect:(NSRect)aRect;

- (void)setVertical:(BOOL)flag;	 
- (BOOL)isVertical;

- (void)setIsPaneSplitter:(BOOL)flag;  
- (BOOL)isPaneSplitter;

- (BOOL)isSubviewCollapsed:(NSView *)subview;

|#
#| @INTERFACE 
NSObject(NSSplitViewDelegate)
- (void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize:(NSSize)oldSize;
- (float)splitView:(NSSplitView *)sender constrainMinCoordinate:(float)proposedCoord ofSubviewAt:(int)offset;
- (float)splitView:(NSSplitView *)sender constrainMaxCoordinate:(float)proposedCoord ofSubviewAt:(int)offset;
- (void)splitViewWillResizeSubviews:(NSNotification *)notification;
- (void)splitViewDidResizeSubviews:(NSNotification *)notification;
- (BOOL)splitView:(NSSplitView *)sender canCollapseSubview:(NSView *)subview;
- (float)splitView:(NSSplitView *)splitView constrainSplitPosition:(float)proposedPosition ofSubviewAt:(int)index;
|#
;  Notifications 
(def-mactype :NSSplitViewDidResizeSubviewsNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSSplitViewWillResizeSubviewsNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSSplitView")