(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebBackForwardList.h"
; at Sunday July 2,2006 7:32:17 pm.
; 
;     WebBackForwardList.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 

; #import <Foundation/Foundation.h>
; !
;     @class WebBackForwardList
;     WebBackForwardList holds an ordered list of WebHistoryItems that comprises the back and
;     forward lists.
;     
;     Note that the methods which modify instances of this class do not cause
;     navigation to happen in other layers of the stack;  they are only for maintaining this data
;     structure.
; 
#| @INTERFACE 
WebBackForwardList : NSObject {
private
    WebBackForwardListPrivate *_private;
}

    
- (void)addItem:(WebHistoryItem *)item;


- (void)goBack;


- (void)goForward;


- (void)goToItem:(WebHistoryItem *)item;


- (WebHistoryItem *)backItem;


- (WebHistoryItem *)currentItem;


- (WebHistoryItem *)forwardItem;


- (NSArray *)backListWithLimit:(int)limit;


- (NSArray *)forwardListWithLimit:(int)limit;


- (int)capacity;


- (void)setCapacity:(int)size;


- (int)backListCount;


- (int)forwardListCount;


- (BOOL)containsItem:(WebHistoryItem *)item;


- (WebHistoryItem *)itemAtIndex:(int)index;


- (void)setPageCacheSize:(unsigned)size;


- (unsigned)pageCacheSize;

|#

(provide-interface "WebBackForwardList")