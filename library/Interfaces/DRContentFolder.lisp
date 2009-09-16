(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRContentFolder.h"
; at Sunday July 2,2006 7:27:37 pm.
; 
;      File:       DiscRecordingContent/DRContentFolder.h
;  
;      Contains:   Interface to folder objects used in filesystem creation.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _H_DRContentFolder
; #define _H_DRContentFolder

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef _H_DRContentObject

(require-interface "DiscRecordingContent/DRContentObject")

; #endif

; #ifndef __COREFOUNDATION_CFURL__
#| #|
#include <CoreFoundationCFURL.h>
#endif
|#
 |#
; #ifndef __AVAILABILITYMACROS__

(require-interface "AvailabilityMacros")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; !
; 	@function	DRFolderGetTypeID
; 	@abstract	Returns the type identifier of all DRFolder instances.
; 

(deftrap-inline "_DRFolderGetTypeID" 
   ((ARG2 (:nil :nil))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; !
; 	@function		DRFolderCreateReal
; 	@abstract		Creates a new real folder object corresponding to a given FSRef object.
; 	@discussion		A real folder object is a folder object corresponding to a real
; 					folder on disk.  The content of the folder object corresponds to the
; 					actual on-disk content of the folder.  Items cannot be programatically added
; 					to or removed from a real folder object without making it virtual first --
; 					see <tt>DRFolderConvertRealToVirtual</tt>.  
; 	@param	fsRef				A file-system reference to an on-disk folder.
; 	@result			Returns a reference to the newly-created folder object, or <tt>NULL</tt>.
; 

(deftrap-inline "_DRFolderCreateReal" 
   ((fsRef (:pointer :FSRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRFolder)
() )
; !
; 	@function	DRFolderCreateRealWithURL
; 	@abstract		Creates a new real folder object corresponding to a given file URL.
; 	@discussion		A real folder object is a folder object corresponding to a real
; 					folder on disk.  The contents of the folder object corresponds to the
; 					actual on-disk contents of the folder.  Items cannot be programatically added
; 					to or removed from a real folder object without making it virtual first --
; 					see <tt>DRFolderConvertRealToVirtual</tt>.    
; 	@param	urlRef	A URL reference to an on-disk folder.
; 	@result			Returns a reference to the newly-created folder object, or <tt>NULL</tt>.
; 

(deftrap-inline "_DRFolderCreateRealWithURL" 
   ((urlRef (:pointer :__CFURL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRFolder)
() )
; !
; 	@function	DRFolderCreateVirtual
; 	@abstract			Creates a new, empty virtual folder object.
; 	@discussion			A virtual folder object is a folder object which does not correspond
; 						to any real folder on disk, but represents a folder you want to appear 
; 						in the file structure of the disc you are burning. It is created and modified 
; 						using Disc Recording's 'content' functions -- see the documentation for 
; 						DRContentObject.h.
; 	@param	baseName	The base name to assign to the new virtual folder. For information on base
; 						names and how Disc Recording works with them, see <tt>DRFSObjectSetBaseName</tt>
; 						and <tt>DRFSObjectSetSpecificName</tt>.
; 	@result				Returns a reference to the newly-created virtual folder object, or <tt>NULL</tt>.
; 

(deftrap-inline "_DRFolderCreateVirtual" 
   ((baseName (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRFolder)
() )
; !
; 	@function	DRFolderConvertRealToVirtual
; 	@abstract			Converts a real folder to a virtual folder.  Conversion happens
; 						in-place so there is no need to release or reallocate any objects.
; 	@discussion			The virtual folder created in this way is a snapshot of the on-disk
; 						folder at the moment of the call.  The newly-created virtual folder
; 						will contain real folder and file objects corresponding to the
; 						on-disk children of the original on-disk folder.
; 				
; 						If the on-disk folder attributes change, or if children are added to 
; 						or removed from the on-disk tree during this call, the virtual folder 
; 						may or may not reflect the changes. It the on-disk attributes change
; 					 	after this call, the virtual folder will not reflect the changes.
; 
; 	@param	realFolder	A reference to the folder object to convert.  The caller should pass in
; 						a reference to a real folder.  On success it will have been converted
; 						to a virtual folder.
; 

(deftrap-inline "_DRFolderConvertRealToVirtual" 
   ((realFolder (:pointer :__DRFolder))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DRFolderAddChild
; 	@abstract			Adds a file or folder object reference as a child of a virtual folder 
; 						object.
; 	
; 						This function applies only to virtual folders.  Real folders
; 						are considered "leaf nodes" and cannot have children.
; 	@param	parent		A reference to the folder that will be the new parent.
; 	@param	newChild	A reference to the file or folder object that will be the new child.
; 

(deftrap-inline "_DRFolderAddChild" 
   ((parent (:pointer :__DRFolder))
    (newChild (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DRFolderRemoveChild
; 	@abstract			Removes a file or folder object reference so a file or folder is 
; 						no longer a child  of the specified folder object.
; 
; 						This function applies only to virtual folders.  Real folders
; 						are considered "leaf nodes" and cannot have children.
; 	@param		parent	A reference to the folder that will no longer be the parent of the
; 						child object.
; 	@param		child	A reference to the file or folder object that will no longer be
; 						a child of the parent object.
; 

(deftrap-inline "_DRFolderRemoveChild" 
   ((parent (:pointer :__DRFolder))
    (child (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DRFolderCountChildren
; 	@abstract			Obtains the number of children of a virtual folder.
; 	@discussion			This function applies only to virtual folders. Real folders
; 						are considered "leaf nodes" and should not be passed to this call.
; 	@param	folder		The folder reference to query.
; 	@result				Returns the number of children.
; 

(deftrap-inline "_DRFolderCountChildren" 
   ((folder (:pointer :__DRFolder))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; !
; 	@function	DRFolderCopyChildren
; 	@abstract			Obtains an array containing the children of a virtual folder.
; 	@discussion			The order of the children in the array is arbitrary; the various files 
; 						systems being generated for a burn may have different sorting 
; 						requirements, so there is no one definitive sort order. The ordering 
; 						will change only when children are added or removed.
; 						
; 						Your application should sort the children consistently and according to 
; 						the needs of your user interface.
; 				
; 						This function applies only to virtual folders.  Real folders
; 						are considered "leaf nodes" and should not be passed to this call.
; 	@param	folder		The folder reference to query.
; 	@result				Returns a CFArray object containing the virtual folder's children.
; 

(deftrap-inline "_DRFolderCopyChildren" 
   ((virtualFolder (:pointer :__DRFolder))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFArray)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DRContentFolder */


(provide-interface "DRContentFolder")