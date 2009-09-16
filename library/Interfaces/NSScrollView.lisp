(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSScrollView.h"
; at Sunday July 2,2006 7:30:59 pm.
; 
; 	NSScrollView.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSDate.h>

; #import <AppKit/NSView.h>
(defrecord __SFlags
; #ifdef __BIG_ENDIAN__
   (vScrollerRequired :UInt32)
   (hScrollerRequired :UInt32)
   (vScrollerStatus :UInt32)
   (hScrollerStatus :UInt32)
   (noDynamicScrolling :UInt32)
   (borderType :nsbordertype)
#|
; Warning: type-size: unknown type NSBORDERTYPE
|#
   (oldRulerInstalled :UInt32)
   (showRulers :UInt32)
   (hasHorizontalRuler :UInt32)
   (hasVerticalRuler :UInt32)
   (needsTile :UInt32)
   (doesNotDrawBackground :UInt32)
   (skipRemoveSuperviewCheck :UInt32)
   (focusRingNeedsRedisplay :UInt32)
   (hasCustomLineBorderColor :UInt32)
   (autohidesScrollers :UInt32)
   (RESERVED :UInt32)
#| 
; #else
   (RESERVED :UInt32)
   (autohidesScrollers :UInt32)
   (hasCustomLineBorderColor :UInt32)
   (focusRingNeedsRedisplay :UInt32)
   (skipRemoveSuperviewCheck :UInt32)
   (doesNotDrawBackground :UInt32)
   (needsTile :UInt32)
   (hasVerticalRuler :UInt32)
   (hasHorizontalRuler :UInt32)
   (showRulers :UInt32)
   (oldRulerInstalled :UInt32)
   (borderType :nsbordertype)
   (noDynamicScrolling :UInt32)
   (hScrollerStatus :UInt32)
   (vScrollerStatus :UInt32)
   (hScrollerRequired :UInt32)
   (vScrollerRequired :UInt32)
 |#

; #endif

)
(%define-record :_SFlags (find-record-descriptor :__SFLAGS))
#| @INTERFACE 
NSScrollView : NSView
{
    
    NSScroller *_vScroller;
    NSScroller *_hScroller;
    NSClipView *_contentView;
    NSClipView *_headerClipView;
    NSView *    _cornerView;
    id		_ruler;
    _SFlags     _sFlags;
    void *      _extraIvars;
    
        NSRulerView *_horizontalRuler;
    NSRulerView *_verticalRuler;
}

+ (NSSize)frameSizeForContentSize:(NSSize)cSize hasHorizontalScroller:(BOOL)hFlag hasVerticalScroller:(BOOL)vFlag borderType:(NSBorderType)aType;
+ (NSSize)contentSizeForFrameSize:(NSSize)fSize hasHorizontalScroller:(BOOL)hFlag hasVerticalScroller:(BOOL)vFlag borderType:(NSBorderType)aType;

- (NSRect)documentVisibleRect;
- (NSSize)contentSize;

- (void)setDocumentView:(NSView *)aView;
- (id)documentView;
- (void)setContentView:(NSClipView *)contentView;
- (NSClipView *)contentView;
- (void)setDocumentCursor:(NSCursor *)anObj;
- (NSCursor *)documentCursor;
- (void)setBorderType:(NSBorderType)aType;
- (NSBorderType)borderType;
- (void)setBackgroundColor:(NSColor *)color;
- (NSColor *)backgroundColor;
- (void)setDrawsBackground:(BOOL)flag;
- (BOOL)drawsBackground;
- (void)setHasVerticalScroller:(BOOL)flag;
- (BOOL)hasVerticalScroller;
- (void)setHasHorizontalScroller:(BOOL)flag;
- (BOOL)hasHorizontalScroller;
- (void)setVerticalScroller:(NSScroller *)anObject;
- (NSScroller *)verticalScroller;
- (void)setHorizontalScroller:(NSScroller *)anObject;
- (NSScroller *)horizontalScroller;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (BOOL)autohidesScrollers;
- (void)setAutohidesScrollers:(BOOL)flag;
#endif
- (void)setHorizontalLineScroll:(float)value;
- (void)setVerticalLineScroll:(float)value;
- (void)setLineScroll:(float)value;
- (float)horizontalLineScroll;
- (float)verticalLineScroll;
- (float)lineScroll;
- (void)setHorizontalPageScroll:(float)value;
- (void)setVerticalPageScroll:(float)value;
- (void)setPageScroll:(float)value;
- (float)horizontalPageScroll;
- (float)verticalPageScroll;
- (float)pageScroll;
- (void)setScrollsDynamically:(BOOL)flag;
- (BOOL)scrollsDynamically;
- (void)tile;
- (void)reflectScrolledClipView:(NSClipView *)cView;
- (void)scrollWheel:(NSEvent *)theEvent;
|#
#| @INTERFACE 
NSScrollView(NSRulerSupport)

+ (void)setRulerViewClass:(Class)rulerViewClass;
+ (Class)rulerViewClass;

- (void)setRulersVisible:(BOOL)flag;
- (BOOL)rulersVisible;

- (void)setHasHorizontalRuler:(BOOL)flag;
- (BOOL)hasHorizontalRuler;
- (void)setHasVerticalRuler:(BOOL)flag;
- (BOOL)hasVerticalRuler;

- (void)setHorizontalRulerView:(NSRulerView *)ruler;
- (NSRulerView *)horizontalRulerView;
- (void)setVerticalRulerView:(NSRulerView *)ruler;
- (NSRulerView *)verticalRulerView;

|#

(provide-interface "NSScrollView")