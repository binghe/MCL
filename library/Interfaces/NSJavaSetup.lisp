(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSJavaSetup.h"
; at Sunday July 2,2006 7:30:50 pm.
; 	NSJavaSetup.h
; 	Copyright (c) 1997-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
(def-mactype :NSJavaClasses (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaRoot (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaPath (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaUserPath (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaLibraryPath (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaOwnVirtualMachine (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaPathSeparator (find-mactype '(:pointer :NSString)))

(deftrap-inline "_NSJavaNeedsVirtualMachine" 
   ((plist (:pointer :nsdictionary))
   )
   :Boolean
() )

(deftrap-inline "_NSJavaProvidesClasses" 
   ((plist (:pointer :nsdictionary))
   )
   :Boolean
() )

(deftrap-inline "_NSJavaNeedsToLoadClasses" 
   ((plist (:pointer :nsdictionary))
   )
   :Boolean
() )
(def-mactype :NSJavaWillSetupVirtualMachineNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaDidSetupVirtualMachineNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaWillCreateVirtualMachineNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSJavaDidCreateVirtualMachineNotification (find-mactype '(:pointer :NSString)))

(deftrap-inline "_NSJavaSetup" 
   ((plist (:pointer :nsdictionary))
   )
   :UInt32
() )
;  Setup if needed.

(deftrap-inline "_NSJavaSetupVirtualMachine" 
   (
   )
   :UInt32
() )
;  Setup in any case.

(deftrap-inline "_NSJavaObjectNamedInPath" 
   ((name (:pointer :NSString))
    (path (:pointer :nsarray))
   )
   :UInt32
() )

(deftrap-inline "_NSJavaClassesFromPath" 
   ((path (:pointer :nsarray))
    (wanted (:pointer :nsarray))
    (usesyscl :Boolean)
    (vm (:pointer :ID))
   )
   (:pointer :nsarray)
() )

(deftrap-inline "_NSJavaClassesForBundle" 
   ((bundle (:pointer :nsbundle))
    (usesyscl :Boolean)
    (vm (:pointer :ID))
   )
   (:pointer :nsarray)
() )
;  These functions are obsolete now...

(deftrap-inline "_NSJavaBundleSetup" 
   ((bundle (:pointer :nsbundle))
    (plist (:pointer :nsdictionary))
   )
   :UInt32
() )

(deftrap-inline "_NSJavaBundleCleanup" 
   ((bundle (:pointer :nsbundle))
    (plist (:pointer :nsdictionary))
   )
   nil
() )

(provide-interface "NSJavaSetup")