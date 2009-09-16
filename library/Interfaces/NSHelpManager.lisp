(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSHelpManager.h"
; at Sunday July 2,2006 7:30:49 pm.
; 
; 	NSHelpManager.h
; 	Application Kit
; 	Copyright (c) 1995-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSMapTable.h>

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSBundle.h>

; #import <AppKit/AppKitDefines.h>

; #import <AppKit/NSApplication.h>
#| @INTERFACE 
NSHelpManager : NSObject
{
    
    NSMapTable		*_helpMapTable;
    NSMapTable		*_keyMapTable;
    NSMapTable		*_bundleMapTable;
    NSWindow		*_helpWindow;
    NSWindow		*_shadowWindow;
    NSWindow		*_evtWindow;
    NSBundle		*_helpBundle;
}

+ (NSHelpManager *)sharedHelpManager;
+ (void)setContextHelpModeActive:(BOOL)active;
+ (BOOL)isContextHelpModeActive;

- (void)setContextHelp:(NSAttributedString *)attrString forObject:(id)object;
- (void)removeContextHelpForObject:(id)object;
- (NSAttributedString *)contextHelpForObject:(id)object;

- (BOOL)showContextHelpForObject:(id)object locationHint:(NSPoint)pt;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)openHelpAnchor:(NSString *)anchor inBook:(NSString *)book;
- (void)findString:(NSString *)query inBook:(NSString *)book;
#endif

|#
; 
;  Notifications for the activation/deactivation of the context help mode
; 
(def-mactype :NSContextHelpModeDidActivateNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSContextHelpModeDidDeactivateNotification (find-mactype '(:pointer :NSString)))
; 
;   Conveniences for accessing Help.plist
; 
#| @INTERFACE 
NSBundle(NSBundleHelpExtension)
- (NSAttributedString *)contextHelpForKey:(NSString *)key;	
|#
; 
;   Convenience methods on NSApplication
; 
#| @INTERFACE 
NSApplication(NSApplicationHelpExtension)
- (void)activateContextHelpMode:(id)sender;
  - (void)showHelp:(id)sender;
|#

(provide-interface "NSHelpManager")