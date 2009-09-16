(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSHFSFileTypes.h"
; at Sunday July 2,2006 7:30:49 pm.
; 
; 	NSHFSFileTypes.h
; 	Copyright (c) 2000-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObjCRuntime.h>

; #import <CoreFoundation/CFBase.h>
;  Given an HFS file type code, return a string that represents the file type.  The string will have been autoreleased.  The format of the string is a private implementation detail, but such strings are suitable for inclusion in arrays that also contain file name extension strings.  Several Cocoa API methods take such arrays.

(deftrap-inline "_NSFileTypeForHFSTypeCode" 
   ((hfsFileTypeCode :OSType)
   )
   (:pointer :NSString)
() )
;  Given a string of the sort encoded by NSFileTypeForHFSTypeCode(), return the corresponding HFS file type code.  Return zero otherwise.

(deftrap-inline "_NSHFSTypeCodeFromFileType" 
   ((fileTypeString (:pointer :NSString))
   )
   :OSType
() )
;  Given the full absolute path of a file, return a string that represents the file's HFS file type as described above, or nil if the operation is not successful.  The string will have been autoreleased.

(deftrap-inline "_NSHFSTypeOfFile" 
   ((fullFilePath (:pointer :NSString))
   )
   (:pointer :NSString)
() )

(provide-interface "NSHFSFileTypes")