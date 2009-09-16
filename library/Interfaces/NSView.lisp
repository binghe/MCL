(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSView.h"
; at Sunday July 2,2006 7:31:05 pm.
; 
; 	NSView.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSResponder.h>

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSRange.h>

; #import <AppKit/AppKitDefines.h>

; #import <AppKit/NSGraphics.h>

(defconstant $NSViewNotSizable 0)
(defconstant $NSViewMinXMargin 1)
(defconstant $NSViewWidthSizable 2)
(defconstant $NSViewMaxXMargin 4)
(defconstant $NSViewMinYMargin 8)
(defconstant $NSViewHeightSizable 16)
(defconstant $NSViewMaxYMargin 32)
(def-mactype :_NSBorderType (find-mactype ':sint32))

(defconstant $NSNoBorder 0)
(defconstant $NSLineBorder 1)
(defconstant $NSBezelBorder 2)
(defconstant $NSGrooveBorder 3)
(def-mactype :NSBorderType (find-mactype ':SINT32))
(defrecord __VFlags
; #ifdef __BIG_ENDIAN__
   (rotatedFromBase :UInt32)
   (rotatedOrScaledFromBase :UInt32)
   (autosizing :UInt32)
   (autoresizeSubviews :UInt32)
   (wantsGState :UInt32)
   (needsDisplay :UInt32)
   (validGState :UInt32)
   (newGState :UInt32)
   (noVerticalAutosizing :UInt32)
   (frameChangeNotesSuspended :UInt32)
   (needsFrameChangeNote :UInt32)
   (focusChangeNotesSuspended :UInt32)
   (boundsChangeNotesSuspended :UInt32)
   (needsBoundsChangeNote :UInt32)
   (removingWithoutInvalidation :UInt32)
   (interfaceStyle0 :UInt32)
   (needsDisplayForBounds :UInt32)
   (specialArchiving :UInt32)
   (interfaceStyle1 :UInt32)
   (retainCount :UInt32)
   (retainCountOverMax :UInt32)
   (aboutToResize :UInt32)
#| 
; #else
   (aboutToResize :UInt32)
   (retainCountOverMax :UInt32)
   (retainCount :UInt32)
   (interfaceStyle1 :UInt32)
   (specialArchiving :UInt32)
   (needsDisplayForBounds :UInt32)
   (interfaceStyle0 :UInt32)
   (removingWithoutInvalidation :UInt32)
   (needsBoundsChangeNote :UInt32)
   (boundsChangeNotesSuspended :UInt32)
   (focusChangeNotesSuspended :UInt32)
   (needsFrameChangeNote :UInt32)
   (frameChangeNotesSuspended :UInt32)
   (noVerticalAutosizing :UInt32)
   (newGState :UInt32)
   (validGState :UInt32)
   (needsDisplay :UInt32)
   (wantsGState :UInt32)
   (autoresizeSubviews :UInt32)
   (autosizing :UInt32)
   (rotatedOrScaledFromBase :UInt32)
   (rotatedFromBase :UInt32)
 |#

; #endif

)
(%define-record :_VFlags (find-record-descriptor :__VFLAGS))

(def-mactype :NSTrackingRectTag (find-mactype ':signed-long))

(def-mactype :NSToolTipTag (find-mactype ':signed-long))

(def-mactype :_NSViewAuxiliary (find-mactype ':__NSViewAuxiliary))
#| @INTERFACE 
NSView : NSResponder
{
    
    NSRect              _frame;
    NSRect              _bounds;
    id                  _superview;
    id			_subviews;
    NSWindow            *_window;
    int                 _gState;
    id                  _frameMatrix;
    id			_drawMatrix;
    id			_dragTypes;
    _NSViewAuxiliary	*_viewAuxiliary;
    _VFlags		_vFlags;
    struct __VFlags2 {
	unsigned int	nextKeyViewRefCount:14;
	unsigned int	previousKeyViewRefCount:14;
	unsigned int	isVisibleRect:1;
	unsigned int	hasToolTip:1;
	unsigned int	needsRealLockFocus:1;
	unsigned int	menuWasSet:1;
    } _vFlags2;
}


- (id)initWithFrame:(NSRect)frameRect;

- (NSWindow *)window;
- (NSView *)superview;
- (NSArray *)subviews;
- (BOOL)isDescendantOf:(NSView *)aView;
- (NSView *)ancestorSharedWithView:(NSView *)aView;
- (NSView *)opaqueAncestor;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setHidden:(BOOL)flag;
- (BOOL)isHidden;
- (BOOL)isHiddenOrHasHiddenAncestor;

- (void)getRectsBeingDrawn:(const NSRect **)rects count:(int *)count;
- (BOOL)needsToDrawRect:(NSRect)aRect;
- (BOOL)wantsDefaultClipping;
#endif
- (void)addSubview:(NSView *)aView;
- (void)addSubview:(NSView *)aView positioned:(NSWindowOrderingMode)place relativeTo:(NSView *)otherView;
- (void)sortSubviewsUsingFunction:(int (*)(id, id, void *))compare context:(void *)context;
- (void)viewWillMoveToWindow:(NSWindow *)newWindow;
- (void)viewDidMoveToWindow;
- (void)viewWillMoveToSuperview:(NSView *)newSuperview;
- (void)viewDidMoveToSuperview;
- (void)didAddSubview:(NSView *)subview;
- (void)willRemoveSubview:(NSView *)subview;
- (void)removeFromSuperview;
- (void)replaceSubview:(NSView *)oldView with:(NSView *)newView;
- (void)removeFromSuperviewWithoutNeedingDisplay;

- (void)setPostsFrameChangedNotifications:(BOOL)flag;
- (BOOL)postsFrameChangedNotifications;
- (void)resizeSubviewsWithOldSize:(NSSize)oldSize;
- (void)resizeWithOldSuperviewSize:(NSSize)oldSize;
- (void)setAutoresizesSubviews:(BOOL)flag;
- (BOOL)autoresizesSubviews;
- (void)setAutoresizingMask:(unsigned int)mask;
- (unsigned int)autoresizingMask;

- (void)setFrameOrigin:(NSPoint)newOrigin;
- (void)setFrameSize:(NSSize)newSize;
- (void)setFrame:(NSRect)frameRect;
- (NSRect)frame;
- (void)setFrameRotation:(float)angle;
- (float)frameRotation;

- (void)setBoundsOrigin:(NSPoint)newOrigin;
- (void)setBoundsSize:(NSSize)newSize;
- (void)setBoundsRotation:(float)angle;
- (float)boundsRotation;
- (void)translateOriginToPoint:(NSPoint)translation;
- (void)scaleUnitSquareToSize:(NSSize)newUnitSize;
- (void)rotateByAngle:(float)angle;
- (void)setBounds:(NSRect)aRect;
- (NSRect)bounds;

- (BOOL)isFlipped;
- (BOOL)isRotatedFromBase;
- (BOOL)isRotatedOrScaledFromBase;
- (BOOL)isOpaque;

- (NSPoint)convertPoint:(NSPoint)aPoint fromView:(NSView *)aView;
- (NSPoint)convertPoint:(NSPoint)aPoint toView:(NSView *)aView;
- (NSSize)convertSize:(NSSize)aSize fromView:(NSView *)aView;
- (NSSize)convertSize:(NSSize)aSize toView:(NSView *)aView;
- (NSRect)convertRect:(NSRect)aRect fromView:(NSView *)aView;
- (NSRect)convertRect:(NSRect)aRect toView:(NSView *)aView;
- (NSRect)centerScanRect:(NSRect)aRect;

- (BOOL)canDraw;
- (void)setNeedsDisplay:(BOOL)flag;
- (void)setNeedsDisplayInRect:(NSRect)invalidRect;
- (BOOL)needsDisplay;
- (void)lockFocus;
- (void)unlockFocus;
- (BOOL)lockFocusIfCanDraw;
+ (NSView *)focusView;
- (NSRect)visibleRect;

- (void)display;
- (void)displayIfNeeded;
- (void)displayIfNeededIgnoringOpacity;
- (void)displayRect:(NSRect)rect;
- (void)displayIfNeededInRect:(NSRect)rect;
- (void)displayRectIgnoringOpacity:(NSRect)rect;
- (void)displayIfNeededInRectIgnoringOpacity:(NSRect)rect;
- (void)drawRect:(NSRect)rect;

- (int)gState;
- (void)allocateGState;
- (void)releaseGState;
- (void)setUpGState;
- (void)renewGState;

- (void)scrollPoint:(NSPoint)aPoint;
- (BOOL)scrollRectToVisible:(NSRect)aRect;
- (BOOL)autoscroll:(NSEvent *)theEvent;
- (NSRect)adjustScroll:(NSRect)newVisible;
- (void)scrollRect:(NSRect)aRect by:(NSSize)delta;

- (NSView *)hitTest:(NSPoint)aPoint;
- (BOOL)mouse:(NSPoint)aPoint inRect:(NSRect)aRect;
- (id)viewWithTag:(int)aTag;
- (int)tag;
- (BOOL)performKeyEquivalent:(NSEvent *)theEvent;
- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent;
- (BOOL)shouldDelayWindowOrderingForEvent:(NSEvent *)theEvent;
- (BOOL)needsPanelToBecomeKey;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (BOOL)mouseDownCanMoveWindow;
#endif

- (void)addCursorRect:(NSRect)aRect cursor:(NSCursor *)anObj;
- (void)removeCursorRect:(NSRect)aRect cursor:(NSCursor *)anObj;
- (void)discardCursorRects;
- (void)resetCursorRects;

- (NSTrackingRectTag)addTrackingRect:(NSRect)aRect owner:(id)anObject userData:(void *)data assumeInside:(BOOL)flag;
- (void)removeTrackingRect:(NSTrackingRectTag)tag;

- (BOOL)shouldDrawColor;

- (void)setPostsBoundsChangedNotifications:(BOOL)flag;
- (BOOL)postsBoundsChangedNotifications;

- (NSScrollView *)enclosingScrollView;

- (NSMenu *)menuForEvent:(NSEvent *)event;
+ (NSMenu *)defaultMenu;

- (void)setToolTip:(NSString *)string;
- (NSString *)toolTip;
- (NSToolTipTag)addToolTipRect:(NSRect)aRect owner:(id)anObject userData:(void *)data;
- (void)removeToolTip:(NSToolTipTag)tag;
- (void)removeAllToolTips;


- (void)viewWillStartLiveResize;
- (void)viewDidEndLiveResize;
- (BOOL)inLiveResize;
|#
#| @INTERFACE 
NSObject(NSToolTipOwner)
- (NSString *)view:(NSView *)view stringForToolTip:(NSToolTipTag)tag point:(NSPoint)point userData:(void *)data;
|#
#| @INTERFACE 
NSView(NSKeyboardUI)
- (BOOL)performMnemonic:(NSString *)theString;
- (void)setNextKeyView:(NSView *)next;
- (NSView *)nextKeyView;
- (NSView *)previousKeyView;
- (NSView *)nextValidKeyView;
- (NSView *)previousValidKeyView;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (BOOL)canBecomeKeyView;
#endif

- (void)setKeyboardFocusRingNeedsDisplayInRect:(NSRect)rect;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setFocusRingType:(NSFocusRingType)focusRingType;
- (NSFocusRingType)focusRingType;
+ (NSFocusRingType)defaultFocusRingType;
#endif
|#
#| @INTERFACE 
NSView(NSPrinting)


- (void)writeEPSInsideRect:(NSRect)rect toPasteboard:(NSPasteboard *)pasteboard;
- (NSData *)dataWithEPSInsideRect:(NSRect)rect;
- (void)writePDFInsideRect:(NSRect)rect toPasteboard:(NSPasteboard *)pasteboard;
- (NSData *)dataWithPDFInsideRect:(NSRect)rect;


- (void)print:(id)sender;


- (BOOL)knowsPageRange:(NSRangePointer)range;
- (float)heightAdjustLimit;
- (float)widthAdjustLimit;
- (void)adjustPageWidthNew:(float *)newRight left:(float)oldLeft right:(float)oldRight limit:(float)rightLimit;
- (void)adjustPageHeightNew:(float *)newBottom top:(float)oldTop bottom:(float)oldBottom limit:(float)bottomLimit;
- (NSRect)rectForPage:(int)page;
- (NSPoint)locationOfPrintRect:(NSRect)aRect;
- (void)drawPageBorderWithSize:(NSSize)borderSize;


- (void)drawSheetBorderWithSize:(NSSize)borderSize;



- (NSString *)printJobTitle;
- (void)beginDocument;
- (void)endDocument;

- (void)beginPageInRect:(NSRect)aRect atPlacement:(NSPoint)location;
- (void)endPage;
|#
#| @INTERFACE 
NSView(NSDrag)
- (void)dragImage:(NSImage *)anImage at:(NSPoint)viewLocation offset:(NSSize)initialOffset event:(NSEvent *)event pasteboard:(NSPasteboard *)pboard source:(id)sourceObj slideBack:(BOOL)slideFlag;

- (void)registerForDraggedTypes:(NSArray *)newTypes;
- (void)unregisterDraggedTypes;

- (BOOL)dragFile:(NSString *)filename fromRect:(NSRect)rect slideBack:(BOOL)aFlag event:(NSEvent *)event;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (BOOL)dragPromisedFilesOfTypes:(NSArray *)typeArray fromRect:(NSRect)rect source:(id)sourceObject slideBack:(BOOL)aFlag event:(NSEvent *)event;
#endif
|#
;  Notifications 
(def-mactype :NSViewFrameDidChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSViewFocusDidChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSViewBoundsDidChangeNotification (find-mactype '(:pointer :NSString)))
;  This notification is sent whenever the views bounds change and the frame does not.  That is, it is sent whenever the view's bounds are translated, scaled or rotated, but NOT when the bounds change as a result of, for example, setFrameSize:.
(def-mactype :NSViewGlobalFrameDidChangeNotification (find-mactype '(:pointer :NSString)))
;  This notification is sent whenever an NSView that has an attached NSSurface changes size or changes screens (thus potentially changing graphics hardware drivers.)

(provide-interface "NSView")