(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSApplication.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
; 	NSApplication.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSResponder.h>

; #import <AppKit/AppKitDefines.h>
;  The version of the AppKit framework 
(def-mactype :NSAppKitVersionNumber (find-mactype ':double))
(defconstant $NSAppKitVersionNumber10_0 577)
; #define NSAppKitVersionNumber10_0 577

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
(defconstant $NSAppKitVersionNumber10_1 620)
; #define NSAppKitVersionNumber10_1 620

; #endif


; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
(defconstant $NSAppKitVersionNumber10_2 663)
; #define NSAppKitVersionNumber10_2 663
(defconstant $NSAppKitVersionNumber10_2_3 663.6)
; #define NSAppKitVersionNumber10_2_3 663.6

; #endif

;  Modes passed to NSRunLoop 
(def-mactype :NSModalPanelRunLoopMode (find-mactype '(:pointer :NSString)))
(def-mactype :NSEventTrackingRunLoopMode (find-mactype '(:pointer :NSString)))
;  Pre-defined return values for runModalFor: and runModalSession:. The system also reserves all values below these. 

(defconstant $NSRunStoppedResponse -1000)
(defconstant $NSRunAbortedResponse -1001)
(defconstant $NSRunContinuesResponse -1002)
;  used with NSRunLoop's performSelector:target:argument:order:modes: 

(defconstant $NSUpdateWindowsRunLoopOrdering #x7A120)
(def-mactype :NSApp (find-mactype ':id))
;  Information used by the system during modal sessions 

(def-mactype :NSModalSession (find-mactype '(:pointer :_NSModalSession)))
;  threading information

(def-mactype :_NSThreadPrivate (find-mactype ':NSThreadPrivate))
#| @INTERFACE 
NSApplication : NSResponder
{
    
    NSEvent            *_currentEvent;
    void     		*_windowList;
    id                  _keyWindow;
    id                  _mainWindow;
    id                  _delegate;
    id            	*_hiddenList;
    int                 _hiddenCount;
    void		*_context;
    id                  obsolete1;
    id			obsolete2;
    short               _unusedApp;
    short               _running;
    struct __appFlags {
	unsigned int        _hidden:1;
	unsigned int        _RESERVED1:1;
	unsigned int        _active:1;
	unsigned int        _hasBeenRun:1;
	unsigned int        _doingUnhide:1;
	unsigned int	    _delegateReturnsValidRequestor:1;
	unsigned int	    _deactPending:1;
	unsigned int        _invalidState:1;
	unsigned int        _invalidEvent:1;
	unsigned int        _postedWindowsNeedUpdateNote:1;
        unsigned int        _wantsToActivate:1;
        unsigned int        _doingHide:1;
	unsigned int	    _dontSendShouldTerminate:1;
        unsigned int        _skipWin32DelayedRestoreKeyWindowAfterHide:1;
        unsigned int        _finishedLaunching:1;
        unsigned int	    _hasEventDelegate:1;
        unsigned int        _appDying:1;
        unsigned int        _didNSOpenOrPrint:1;
        unsigned int	    _inDealloc:1;
        unsigned int	    _pendingDidFinish:1;
        unsigned int	    _hasKeyFocus:1;
        unsigned int	    _panelsNonactivating:1;
        unsigned int	    _hiddenOnLaunch:1;
	unsigned int        _reserved:9;
    }                   _appFlags;
    id                  _mainMenu;
    id                  _appIcon;
    id                  _nameTable;
    id                  _eventDelegate;
    _NSThreadPrivate     *_threadingSupport;
}

+ (NSApplication *)sharedApplication;
- (void)setDelegate:(id)anObject;
- (id)delegate;
- (NSGraphicsContext*)context;
- (void)hide:(id)sender;
- (void)unhide:(id)sender;
- (void)unhideWithoutActivation;
- (NSWindow *)windowWithWindowNumber:(int)windowNum;
- (NSWindow *)mainWindow;
- (NSWindow *)keyWindow;
- (BOOL)isActive;
- (BOOL)isHidden;
- (BOOL)isRunning;
- (void)deactivate;
- (void)activateIgnoringOtherApps:(BOOL)flag;

- (void)hideOtherApplications:(id)sender;
- (void)unhideAllApplications:(id)sender;

- (void)finishLaunching;
- (void)run;
- (int)runModalForWindow:(NSWindow *)theWindow;
- (void)stop:(id)sender;
- (void)stopModal;
- (void)stopModalWithCode:(int)returnCode;
- (void)abortModal;
- (NSWindow *)modalWindow;
- (NSModalSession)beginModalSessionForWindow:(NSWindow *)theWindow;
- (int)runModalSession:(NSModalSession)session;
- (void)endModalSession:(NSModalSession)session;
- (void)terminate:(id)sender;

typedef enum {
      NSCriticalRequest = 0,
      NSInformationalRequest = 10
} NSRequestUserAttentionType;

- (int)requestUserAttention:(NSRequestUserAttentionType)requestType;
- (void)cancelUserAttentionRequest:(int)request;


- (void)beginSheet:(NSWindow *)sheet modalForWindow:(NSWindow *)docWindow modalDelegate:(id)modalDelegate didEndSelector:(SEL)didEndSelector contextInfo:(void *)contextInfo;
- (void)endSheet:(NSWindow *)sheet;
- (void)endSheet:(NSWindow *)sheet returnCode:(int)returnCode;


- (int)runModalForWindow:(NSWindow *)theWindow relativeToWindow:(NSWindow *)docWindow;


- (NSModalSession)beginModalSessionForWindow:(NSWindow *)theWindow relativeToWindow:(NSWindow *)docWindow;
- (NSEvent *)nextEventMatchingMask:(unsigned int)mask untilDate:(NSDate *)expiration inMode:(NSString *)mode dequeue:(BOOL)deqFlag;
- (void)discardEventsMatchingMask:(unsigned int)mask beforeEvent:(NSEvent *)lastEvent;
- (void)postEvent:(NSEvent *)event atStart:(BOOL)flag;
- (NSEvent *)currentEvent;

- (void)sendEvent:(NSEvent *)theEvent;
- (void)preventWindowOrdering;
- (NSWindow *)makeWindowsPerform:(SEL)aSelector inOrder:(BOOL)flag;
- (NSArray *)windows;
- (void)setWindowsNeedUpdate:(BOOL)needUpdate;
- (void)updateWindows;

- (void)setMainMenu:(NSMenu *)aMenu;
- (NSMenu *)mainMenu;

- (void)setApplicationIconImage:(NSImage *)image;
- (NSImage *)applicationIconImage;

- (BOOL)sendAction:(SEL)theAction to:(id)theTarget from:(id)sender;
- (id)targetForAction:(SEL)theAction;
- (id)targetForAction:(SEL)theAction to:(id)theTarget from:(id)sender;
- (BOOL)tryToPerform:(SEL)anAction with:(id)anObject;
- (id)validRequestorForSendType:(NSString *)sendType returnType:(NSString *)returnType;

- (void)reportException:(NSException *)theException;
+ (void)detachDrawingThread:(SEL)selector toTarget:(id)target withObject:(id)argument;


- (void)replyToApplicationShouldTerminate:(BOOL)shouldTerminate;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

typedef enum NSApplicationDelegateReply {
    NSApplicationDelegateReplySuccess = 0,
    NSApplicationDelegateReplyCancel = 1,
    NSApplicationDelegateReplyFailure = 2
} NSApplicationDelegateReply;


- (void)replyToOpenOrPrint:(NSApplicationDelegateReply)reply;


- (void)orderFrontCharacterPalette:(id)sender;
#endif
|#
#| @INTERFACE 
NSApplication(NSWindowsMenu)
- (void)setWindowsMenu:(NSMenu *)aMenu;
- (NSMenu *)windowsMenu;
- (void)arrangeInFront:(id)sender;
- (void)removeWindowsItem:(NSWindow *)win;
- (void)addWindowsItem:(NSWindow *)win title:(NSString *)aString filename:(BOOL)isFilename;
- (void)changeWindowsItem:(NSWindow *)win title:(NSString *)aString filename:(BOOL)isFilename;
- (void)updateWindowsItem:(NSWindow *)win;
- (void)miniaturizeAll:(id)sender;
|#
#| @INTERFACE 
NSObject(NSApplicationNotifications)
- (void)applicationWillFinishLaunching:(NSNotification *)notification;
- (void)applicationDidFinishLaunching:(NSNotification *)notification;
- (void)applicationWillHide:(NSNotification *)notification;
- (void)applicationDidHide:(NSNotification *)notification;
- (void)applicationWillUnhide:(NSNotification *)notification;
- (void)applicationDidUnhide:(NSNotification *)notification;
- (void)applicationWillBecomeActive:(NSNotification *)notification;
- (void)applicationDidBecomeActive:(NSNotification *)notification;
- (void)applicationWillResignActive:(NSNotification *)notification;
- (void)applicationDidResignActive:(NSNotification *)notification;
- (void)applicationWillUpdate:(NSNotification *)notification;
- (void)applicationDidUpdate:(NSNotification *)notification;
- (void)applicationWillTerminate:(NSNotification *)notification;
- (void)applicationDidChangeScreenParameters:(NSNotification *)notification;
|#
;  return values for -applicationShouldTerminate:
(def-mactype :NSApplicationTerminateReply (find-mactype ':sint32))

(defconstant $NSTerminateCancel 0)
(defconstant $NSTerminateNow 1)
(defconstant $NSTerminateLater 2)
(def-mactype :NSApplicationTerminateReply (find-mactype ':SINT32))
#| @INTERFACE 
NSObject(NSApplicationDelegate)

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender;
- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames;
#endif
- (BOOL)application:(NSApplication *)sender openTempFile:(NSString *)filename;
- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender;
- (BOOL)applicationOpenUntitledFile:(NSApplication *)sender;
- (BOOL)application:(id)sender openFileWithoutUI:(NSString *)filename;
- (BOOL)application:(NSApplication *)sender printFile:(NSString *)filename;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)application:(NSApplication *)sender printFiles:(NSArray *)filenames;
#endif
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender;
- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag;
- (NSMenu *)applicationDockMenu:(NSApplication *)sender;
|#
#| @INTERFACE 
NSApplication(NSAppleMenu)
- (void)setAppleMenu:(NSMenu *)menu;
|#
#| @INTERFACE 
NSApplication(NSServicesMenu)
- (void)setServicesMenu:(NSMenu *)aMenu;
- (NSMenu *)servicesMenu;
- (void)registerServicesMenuSendTypes:(NSArray *)sendTypes returnTypes:(NSArray *)returnTypes;
|#
#| @INTERFACE 
NSObject(NSServicesRequests)
- (BOOL)writeSelectionToPasteboard:(NSPasteboard *)pboard types:(NSArray *)types;
- (BOOL)readSelectionFromPasteboard:(NSPasteboard *)pboard;
|#
#| @INTERFACE 
NSApplication(NSServicesHandling)
- (void)setServicesProvider:(id)provider;
- (id)servicesProvider;
|#
#| @INTERFACE 
NSApplication(NSStandardAboutPanel)
- (void)orderFrontStandardAboutPanel:(id)sender;
- (void)orderFrontStandardAboutPanelWithOptions:(NSDictionary *)optionsDictionary;




|#
; #ifdef WIN32
#| #|
@interface NSApplication (NSWindowsExtensions)
+ (void)setApplicationHandle:(void * )hInstance previousHandle:(void * )PrevInstance commandLine:(NSString *)cmdLine show:(int)cmdShow;
+ (void)useRunningCopyOfApplication;
- (void * )applicationHandle;
- (NSWindow *)windowWithWindowHandle:(void * )hWnd; @end
#endif
|#
 |#
;  An Application's startup function 

(deftrap-inline "_NSApplicationMain" 
   ((argc :signed-long)
    (argv (:pointer :char))
   )
   :signed-long
() )

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
;  The startup function to call for a Cocoa bundle 

(deftrap-inline "_NSApplicationLoad" 
   (
   )
   :Boolean
() )

; #endif

;  NSShowsServicesMenuItem() always returns YES. 

(deftrap-inline "_NSShowsServicesMenuItem" 
   ((itemName (:pointer :NSString))
   )
   :Boolean
() )
;  NSSetShowsServicesMenuItem() has no effect, and always returns 0. 

(deftrap-inline "_NSSetShowsServicesMenuItem" 
   ((itemName (:pointer :NSString))
    (enabled :Boolean)
   )
   :signed-long
() )
;  NSUpdateDynamicServices() causes the services information for the system to be updated.  This will only be necessary if your program adds dynamic services to the system (i.e. services not found in macho segments of executables).
; 

(deftrap-inline "_NSUpdateDynamicServices" 
   (
   )
   nil
() )

(deftrap-inline "_NSPerformService" 
   ((itemName (:pointer :NSString))
    (pboard (:pointer :nspasteboard))
   )
   :Boolean
() )

(deftrap-inline "_NSRegisterServicesProvider" 
   ((provider :UInt32)
    (name (:pointer :NSString))
   )
   nil
() )
;  apps should use -setServicesProvider

(deftrap-inline "_NSUnregisterServicesProvider" 
   ((name (:pointer :NSString))
   )
   nil
() )
;  Notifications 
(def-mactype :NSApplicationDidBecomeActiveNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationDidHideNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationDidFinishLaunchingNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationDidResignActiveNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationDidUnhideNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationDidUpdateNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationWillBecomeActiveNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationWillHideNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationWillFinishLaunchingNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationWillResignActiveNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationWillUnhideNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationWillUpdateNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationWillTerminateNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSApplicationDidChangeScreenParametersNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSApplication")