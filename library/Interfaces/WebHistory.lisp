(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebHistory.h"
; at Sunday July 2,2006 7:32:18 pm.
; 	
;     WebHistory.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
;  

; #import <Foundation/Foundation.h>
; 
;     @discussion Notifications sent when history is modified. 
;     @constant WebHistoryItemsAddedNotification Posted from addItems:.  This 
;     notification comes with a userInfo dictionary that contains the array of
;     items added.  The key for the array is WebHistoryItemsKey.
;     @constant WebHistoryItemsRemovedNotification Posted from and removeItems:.  
;     This notification comes with a userInfo dictionary that contains the array of
;     items removed.  The key for the array is WebHistoryItemsKey.
;     @constant WebHistoryAllItemsRemovedNotification Posted from removeAllItems
;     @constant WebHistoryLoadedNotification Posted from loadHistory.
; 
(def-mactype :WebHistoryItemsAddedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :WebHistoryItemsRemovedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :WebHistoryAllItemsRemovedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :WebHistoryLoadedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :WebHistorySavedNotification (find-mactype '(:pointer :NSString)))
(def-mactype :WebHistoryItemsKey (find-mactype '(:pointer :NSString)))
; !
;     @class WebHistory
;     @discussion WebHistory is used to track pages that have been loaded
;     by WebKit.
; 
#| @INTERFACE 
WebHistory : NSObject {
private
    WebHistoryPrivate *_historyPrivate;
}


+ (WebHistory *)optionalSharedHistory;


+ (void)setOptionalSharedHistory:(WebHistory *)history;


- (BOOL)loadFromURL:(NSURL *)URL error:(NSError **)error;


- (BOOL)saveToURL:(NSURL *)URL error:(NSError **)error;


- (void)addItems:(NSArray *)newItems;


- (void)removeItems:(NSArray *)items;


- (void)removeAllItems;


- (NSArray *)orderedLastVisitedDays;


- (NSArray *)orderedItemsLastVisitedOnDay:(NSCalendarDate *)calendarDate;


- (WebHistoryItem *)itemForURL:(NSURL *)URL;

|#

(provide-interface "WebHistory")