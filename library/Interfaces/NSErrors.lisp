(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSErrors.h"
; at Sunday July 2,2006 7:30:47 pm.
; 
; 	NSErrors.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/AppKitDefines.h>
;  The following strings are the names of exceptions the AppKit can raise
(def-mactype :NSTextLineTooLongException (find-mactype '(:pointer :NSString)))
(def-mactype :NSTextNoSelectionException (find-mactype '(:pointer :NSString)))
(def-mactype :NSWordTablesWriteException (find-mactype '(:pointer :NSString)))
(def-mactype :NSWordTablesReadException (find-mactype '(:pointer :NSString)))
(def-mactype :NSTextReadException (find-mactype '(:pointer :NSString)))
(def-mactype :NSTextWriteException (find-mactype '(:pointer :NSString)))
(def-mactype :NSPasteboardCommunicationException (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintingCommunicationException (find-mactype '(:pointer :NSString)))
(def-mactype :NSAbortModalException (find-mactype '(:pointer :NSString)))
(def-mactype :NSAbortPrintingException (find-mactype '(:pointer :NSString)))
(def-mactype :NSIllegalSelectorException (find-mactype '(:pointer :NSString)))
(def-mactype :NSAppKitVirtualMemoryException (find-mactype '(:pointer :NSString)))
(def-mactype :NSBadRTFDirectiveException (find-mactype '(:pointer :NSString)))
(def-mactype :NSBadRTFFontTableException (find-mactype '(:pointer :NSString)))
(def-mactype :NSBadRTFStyleSheetException (find-mactype '(:pointer :NSString)))
(def-mactype :NSTypedStreamVersionException (find-mactype '(:pointer :NSString)))
(def-mactype :NSTIFFException (find-mactype '(:pointer :NSString)))
(def-mactype :NSPrintPackageException (find-mactype '(:pointer :NSString)))
(def-mactype :NSBadRTFColorTableException (find-mactype '(:pointer :NSString)))
(def-mactype :NSDraggingException (find-mactype '(:pointer :NSString)))
(def-mactype :NSColorListIOException (find-mactype '(:pointer :NSString)))
(def-mactype :NSColorListNotEditableException (find-mactype '(:pointer :NSString)))
(def-mactype :NSBadBitmapParametersException (find-mactype '(:pointer :NSString)))
(def-mactype :NSWindowServerCommunicationException (find-mactype '(:pointer :NSString)))
(def-mactype :NSFontUnavailableException (find-mactype '(:pointer :NSString)))
(def-mactype :NSPPDIncludeNotFoundException (find-mactype '(:pointer :NSString)))
(def-mactype :NSPPDParseException (find-mactype '(:pointer :NSString)))
(def-mactype :NSPPDIncludeStackOverflowException (find-mactype '(:pointer :NSString)))
(def-mactype :NSPPDIncludeStackUnderflowException (find-mactype '(:pointer :NSString)))
(def-mactype :NSRTFPropertyStackOverflowException (find-mactype '(:pointer :NSString)))
(def-mactype :NSAppKitIgnoredException (find-mactype '(:pointer :NSString)))
(def-mactype :NSBadComparisonException (find-mactype '(:pointer :NSString)))
(def-mactype :NSImageCacheException (find-mactype '(:pointer :NSString)))
(def-mactype :NSNibLoadingException (find-mactype '(:pointer :NSString)))
(def-mactype :NSBrowserIllegalDelegateException (find-mactype '(:pointer :NSString)))
(def-mactype :NSAccessibilityException (find-mactype '(:pointer :NSString)))

(provide-interface "NSErrors")