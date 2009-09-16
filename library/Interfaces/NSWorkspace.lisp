(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSWorkspace.h"
; at Sunday July 2,2006 7:31:06 pm.
; 
; 	NSWorkspace.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSAppleEventDescriptor.h>

; #import <AppKit/AppKitDefines.h>

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(def-mactype :NSWorkspaceLaunchOptions (find-mactype ':UInt32))

(defconstant $NSWorkspaceLaunchAndPrint 2)
(defconstant $NSWorkspaceLaunchInhibitingBackgroundOnly #x80)
(defconstant $NSWorkspaceLaunchWithoutAddingToRecents #x100)
(defconstant $NSWorkspaceLaunchWithoutActivation #x200)
(defconstant $NSWorkspaceLaunchAsync #x10000)
(defconstant $NSWorkspaceLaunchAllowingClassicStartup #x20000)
(defconstant $NSWorkspaceLaunchPreferringClassic #x40000)
(defconstant $NSWorkspaceLaunchNewInstance #x80000)
(defconstant $NSWorkspaceLaunchAndHide #x100000)
(defconstant $NSWorkspaceLaunchAndHideOthers #x200000);  NSWorkspaceLaunchAndDisplayFailures

(defconstant $NSWorkspaceLaunchDefault #x30000)

; #endif

#| @INTERFACE 
NSWorkspace : NSObject {
  
  private
    NSNotificationCenter *notificationCenter;
    int deviceStatusCount;
    int applicationStatusCount;
    void *_reservedWorkspace1;
}

+ (NSWorkspace *)sharedWorkspace;

- (NSNotificationCenter *)notificationCenter;

- (BOOL)openFile:(NSString *)fullPath;
- (BOOL)openFile:(NSString *)fullPath withApplication:(NSString *)appName;
- (BOOL)openFile:(NSString *)fullPath withApplication:(NSString *)appName andDeactivate:(BOOL)flag;

- (BOOL)openTempFile:(NSString *)fullPath;

- (BOOL)openFile:(NSString *)fullPath fromImage:(NSImage *)anImage at:(NSPoint)point inView:(NSView *)aView;

- (BOOL)openURL:(NSURL *)url;

- (BOOL)launchApplication:(NSString *)appName;
- (BOOL)launchApplication:(NSString *)appName showIcon:(BOOL)showIcon autolaunch:(BOOL)autolaunch;
- (NSString *)fullPathForApplication:(NSString *)appName;

- (BOOL)selectFile:(NSString *)fullPath inFileViewerRootedAtPath:(NSString *)rootFullpath;

- (void)findApplications;

- (void)noteFileSystemChanged;
- (void)noteFileSystemChanged:(NSString *)path;
- (BOOL)fileSystemChanged;
- (void)noteUserDefaultsChanged;
- (BOOL)userDefaultsChanged;

- (BOOL)getInfoForFile:(NSString *)fullPath application:(NSString **)appName type:(NSString **)type;
- (BOOL)isFilePackageAtPath:(NSString *)fullPath;

- (NSImage *)iconForFile:(NSString *)fullPath;
- (NSImage *)iconForFiles:(NSArray *)fullPaths;
- (NSImage *)iconForFileType:(NSString *)fileType;

- (BOOL)getFileSystemInfoForPath:(NSString *)fullPath isRemovable:(BOOL *)removableFlag isWritable:(BOOL *)writableFlag isUnmountable:(BOOL *)unmountableFlag description:(NSString **)description type:(NSString **)fileSystemType;

- (BOOL)performFileOperation:(NSString *)operation source:(NSString *)source destination:(NSString *)destination files:(NSArray *)files tag:(int *)tag;	

- (BOOL)unmountAndEjectDeviceAtPath:(NSString *)path;
- (int)extendPowerOffBy:(int)requested;

- (void)slideImage:(NSImage *)image from:(NSPoint)fromPoint to:(NSPoint)toPoint;

- (void)hideOtherApplications;

- (NSArray *)mountedLocalVolumePaths;
- (NSArray *)mountedRemovableMedia;
- (NSArray *)mountNewRemovableMedia;
- (void)checkForRemovableMedia;


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (NSString *)absolutePathForAppBundleWithIdentifier:(NSString *)bundleIdentifier; 
- (BOOL)launchAppWithBundleIdentifier:(NSString *)bundleIdentifier options:(NSWorkspaceLaunchOptions)options additionalEventParamDescriptor:(NSAppleEventDescriptor *)descriptor launchIdentifier:(NSNumber **)identifier;
- (BOOL)openURLs:(NSArray *)urls withAppBundleIdentifier:(NSString *)bundleIdentifier options:(NSWorkspaceLaunchOptions)options additionalEventParamDescriptor:(NSAppleEventDescriptor *)descriptor launchIdentifiers:(NSArray **)identifiers;
#endif

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2



- (NSArray *)launchedApplications;	
- (NSDictionary *)activeApplication;	

#endif

|#
;  Notifications (through the special notification center) 
; 
;  userInfo keys:
(def-mactype :NSWorkspaceDidLaunchApplicationNotification (find-mactype '(:pointer :NSString)))
; 	see above
(def-mactype :NSWorkspaceDidMountNotification (find-mactype '(:pointer :NSString)))
; 	@"NSDevicePath"
(def-mactype :NSWorkspaceDidPerformFileOperationNotification (find-mactype '(:pointer :NSString)))
; 	@"NSOperationNumber"
(def-mactype :NSWorkspaceDidTerminateApplicationNotification (find-mactype '(:pointer :NSString)))
; 	see above
(def-mactype :NSWorkspaceDidUnmountNotification (find-mactype '(:pointer :NSString)))
; 	@"NSDevicePath"
(def-mactype :NSWorkspaceWillLaunchApplicationNotification (find-mactype '(:pointer :NSString)))
; 	see above
(def-mactype :NSWorkspaceWillPowerOffNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceWillUnmountNotification (find-mactype '(:pointer :NSString)))
; 	@"NSDevicePath"
(def-mactype :NSWorkspaceWillSleepNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSWorkspaceDidWakeNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSWorkspaceSessionDidBecomeActiveNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :NSWorkspaceSessionDidResignActiveNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Return values for type in getInfoForFile: 
; 
(def-mactype :NSPlainFileType (find-mactype '(:pointer :NSString))); ,
(def-mactype :NSFilesystemFileType (find-mactype '(:pointer :NSString))); ,
;  Possible values for operation in performFileOperation:... 
; 
(def-mactype :NSWorkspaceMoveOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceCopyOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceLinkOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceCompressOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceDecompressOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceEncryptOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceDecryptOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceDestroyOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceRecycleOperation (find-mactype '(:pointer :NSString)))
(def-mactype :NSWorkspaceDuplicateOperation (find-mactype '(:pointer :NSString)))

(provide-interface "NSWorkspace")