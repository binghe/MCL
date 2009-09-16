(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSTextContainer.h"
; at Sunday July 2,2006 7:31:02 pm.
; 
;         NSTextContainer.h
;         Application Kit
;         Copyright (c) 1994-2003, Apple Computer, Inc.
;         All rights reserved.
; 
;  An NSTextContainer defines a region in which to lay out text.  It's main responsibility is to calculate line fragments which fall within the region it represents.  Containers have a line fragment padding which is used by the typesetter to inset text from the edges of line fragments along the sweep direction.
;  The container can enforce any other geometric constraints as well.  When drawing the text that has been laid in a container, a NSTextView will clip to the interior of the container (it clips to the container's rectagular area only, however, not to the arbitrary shape the container may define for text flow).

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

(defconstant $NSLineSweepLeft 0)
(defconstant $NSLineSweepRight 1)
(defconstant $NSLineSweepDown 2)
(defconstant $NSLineSweepUp 3)
(def-mactype :NSLineSweepDirection (find-mactype ':SINT32))

(defconstant $NSLineDoesntMove 0)
(defconstant $NSLineMovesLeft 1)
(defconstant $NSLineMovesRight 2)
(defconstant $NSLineMovesDown 3)
(defconstant $NSLineMovesUp 4)
(def-mactype :NSLineMovementDirection (find-mactype ':SINT32))
#| @INTERFACE 
NSTextContainer : NSObject <NSCoding> {
    
  
    
  private
    NSLayoutManager *_layoutManager;
    NSTextView *_textView;
    NSSize _size;
    float _lineFragmentPadding;
    struct __tcFlags {
        unsigned short widthTracksTextView:1;
        unsigned short heightTracksTextView:1;
        unsigned short observingFrameChanges:1;
        unsigned short _reserved:13;
    } _tcFlags;
}



- (id)initWithContainerSize:(NSSize)size;



- (NSLayoutManager *)layoutManager;
- (void)setLayoutManager:(NSLayoutManager *)layoutManager;
    
- (void)replaceLayoutManager:(NSLayoutManager *)newLayoutManager;
    
- (NSTextView *)textView;
- (void)setTextView:(NSTextView *)textView;
    
- (void)setWidthTracksTextView:(BOOL)flag;
- (BOOL)widthTracksTextView;
- (void)setHeightTracksTextView:(BOOL)flag;
- (BOOL)heightTracksTextView;
    


- (void)setContainerSize:(NSSize)size;
- (NSSize)containerSize;
    
- (void)setLineFragmentPadding:(float)pad;
- (float)lineFragmentPadding;
    


- (NSRect)lineFragmentRectForProposedRect:(NSRect)proposedRect sweepDirection:(NSLineSweepDirection)sweepDirection movementDirection:(NSLineMovementDirection)movementDirection remainingRect:(NSRectPointer)remainingRect;
    
- (BOOL)isSimpleRectangularTextContainer;
    


- (BOOL)containsPoint:(NSPoint)point;
    
|#

(provide-interface "NSTextContainer")