(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPanel.h"
; at Sunday July 2,2006 7:30:55 pm.
; 
; 	NSPanel.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSWindow.h>
; 
;  * In the following two functions, msg may be a printf-like message with
;  * the arguments tacked onto the end.  Thus, to get a '%' in your message,
;  * you must use '%%'
;  

(deftrap-inline "_NSRunAlertPanel" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )

(deftrap-inline "_NSRunInformationalAlertPanel" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )

(deftrap-inline "_NSRunCriticalAlertPanel" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )
; 
; ** The NSRunAlertPanelRelativeToWindow variants are deprecated.  
; ** Please use the corresponding NSBeginAlertSheet() function instead.
; 

(deftrap-inline "_NSRunAlertPanelRelativeToWindow" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
    (docWindow (:pointer :nswindow))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )

(deftrap-inline "_NSRunInformationalAlertPanelRelativeToWindow" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
    (docWindow (:pointer :nswindow))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )

(deftrap-inline "_NSRunCriticalAlertPanelRelativeToWindow" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
    (docWindow (:pointer :nswindow))
#| |...|  ;; What should this do?
    |#
   )
   :signed-long
() )
; 
; **  Present a sheet alert on the given window.  When the modal session is ended, but before the sheet is dismissed,
; ** the didEndSelector will be invoked in the modalDelegate.  After the sheet
; ** is dismissed, the didDismissSelector will be invoked. Typically, you will want to implement the didEndSelector but you may
; ** pass NULL for the didDismissSelector.
; ** The methods should have the following signatures:
; ** - (void)sheetDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo;
; ** - (void)sheetDidDismiss:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo;
; **
; 

(deftrap-inline "_NSBeginAlertSheet" 
   ((title (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
    (docWindow (:pointer :nswindow))
    (modalDelegate :UInt32)
    (didEndSelector (:pointer :SEL))
    (didDismissSelector (:pointer :SEL))
    (contextInfo :pointer)
    (msg (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   nil
() )

(deftrap-inline "_NSBeginInformationalAlertSheet" 
   ((title (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
    (docWindow (:pointer :nswindow))
    (modalDelegate :UInt32)
    (didEndSelector (:pointer :SEL))
    (didDismissSelector (:pointer :SEL))
    (contextInfo :pointer)
    (msg (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   nil
() )

(deftrap-inline "_NSBeginCriticalAlertSheet" 
   ((title (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
    (docWindow (:pointer :nswindow))
    (modalDelegate :UInt32)
    (didEndSelector (:pointer :SEL))
    (didDismissSelector (:pointer :SEL))
    (contextInfo :pointer)
    (msg (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   nil
() )

(deftrap-inline "_NSGetAlertPanel" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   :UInt32
() )

(deftrap-inline "_NSGetInformationalAlertPanel" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   :UInt32
() )

(deftrap-inline "_NSGetCriticalAlertPanel" 
   ((title (:pointer :NSString))
    (msg (:pointer :NSString))
    (defaultButton (:pointer :NSString))
    (alternateButton (:pointer :NSString))
    (otherButton (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   :UInt32
() )

(deftrap-inline "_NSReleaseAlertPanel" 
   ((panel :UInt32)
   )
   nil
() )
; 
;  * NSRunAlertPanel() return values (also returned by runModalSession: when
;  * the modal session is run with a panel returned by NSGetAlertPanel()).
;  

(defconstant $NSAlertDefaultReturn 1)
(defconstant $NSAlertAlternateReturn 0)
(defconstant $NSAlertOtherReturn -1)
(defconstant $NSAlertErrorReturn -2)

(defconstant $NSOKButton 1)
(defconstant $NSCancelButton 0)
;  Panel specific styleMask

(defconstant $NSUtilityWindowMask 16)
(defconstant $NSDocModalWindowMask 64)

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
;  specify a panel that does not activate owning application

(defconstant $NSNonactivatingPanelMask #x80)

; #endif

#| @INTERFACE 
NSPanel : NSWindow
{

}

- (BOOL)isFloatingPanel;
- (void)setFloatingPanel:(BOOL)flag;
- (BOOL)becomesKeyOnlyIfNeeded;
- (void)setBecomesKeyOnlyIfNeeded:(BOOL)flag;
- (BOOL)worksWhenModal;
- (void)setWorksWhenModal:(BOOL)flag;

|#

(provide-interface "NSPanel")