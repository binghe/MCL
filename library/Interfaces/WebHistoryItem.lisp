(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebHistoryItem.h"
; at Sunday July 2,2006 7:32:18 pm.
; 	
;     WebHistoryItem.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
; 
;     Public header file.
;  

; #import <Cocoa/Cocoa.h>
; 
;     @discussion Notification sent when history item is modified.
;     @constant WebHistoryItemChanged Posted from whenever the value of
;     either the item's title, alternate title, url strings, or last visited interval
;     changes.  The userInfo will be nil.
; 
(def-mactype :WebHistoryItemChangedNotification (find-mactype '(:pointer :NSString)))
; !
;     @class WebHistoryItem
;     @discussion  WebHistoryItems are created by WebKit to represent pages visited.
;     The WebBackForwardList and WebHistory classes both use WebHistoryItems to represent
;     pages visited.  With the exception of the displayTitle, the properties of 
;     WebHistoryItems are set by WebKit.  WebHistoryItems are normally never created directly.
; 
#| @INTERFACE 
WebHistoryItem : NSObject <NSCopying>
{
private
    WebHistoryItemPrivate *_private;
}


- (id)initWithURLString:(NSString *)URLString title:(NSString *)title lastVisitedTimeInterval:(NSTimeInterval)time;


- (NSString *)originalURLString;


- (NSString *)URLString;



- (NSString *)title;


- (NSTimeInterval)lastVisitedTimeInterval;


- (void)setAlternateTitle:(NSString *)alternateTitle;


- (NSString *)alternateTitle;


- (NSImage *)icon;

|#

(provide-interface "WebHistoryItem")