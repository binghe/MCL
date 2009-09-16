(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AEUserTermTypes.h"
; at Sunday July 2,2006 7:24:27 pm.
; 
;      File:       AE/AEUserTermTypes.h
;  
;      Contains:   AppleEvents AEUT resource format Interfaces.
;  
;      Version:    AppleEvents-275~1
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AEUSERTERMTYPES__
; #define __AEUSERTERMTYPES__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k

(defconstant $kAEUserTerminology :|aeut|)       ;   0x61657574  

(defconstant $kAETerminologyExtension :|aete|)  ;   0x61657465  

(defconstant $kAEScriptingSizeResource :|scsz|) ;   0x7363737a  

(defconstant $kAEOSAXSizeResource :|osiz|)

(defconstant $kAEUTHasReturningParam 31)        ;  if event has a keyASReturning param 

(defconstant $kAEUTOptional 15)                 ;  if something is optional 

(defconstant $kAEUTlistOfItems 14)              ;  if property or reply is a list. 

(defconstant $kAEUTEnumerated 13)               ;  if property or reply is of an enumerated type. 

(defconstant $kAEUTReadWrite 12)                ;  if property is writable. 

(defconstant $kAEUTChangesState 12)             ;  if an event changes state. 

(defconstant $kAEUTTightBindingFunction 12)     ;  if this is a tight-binding precedence function. 
;  AppleScript 1.3: new bits for reply, direct parameter, parameter, and property flags 

(defconstant $kAEUTEnumsAreTypes 11)            ;  if the enumeration is a list of types, not constants 

(defconstant $kAEUTEnumListIsExclusive 10)      ;  if the list of enumerations is a proper set 

(defconstant $kAEUTReplyIsReference 9)          ;  if the reply is a reference, not a value 

(defconstant $kAEUTDirectParamIsReference 9)    ;  if the direct parameter is a reference, not a value 

(defconstant $kAEUTParamIsReference 9)          ;  if the parameter is a reference, not a value 

(defconstant $kAEUTPropertyIsReference 9)       ;  if the property is a reference, not a value 

(defconstant $kAEUTNotDirectParamIsTarget 8)    ;  if the direct parameter is not the target of the event 

(defconstant $kAEUTParamIsTarget 8)             ;  if the parameter is the target of the event 

(defconstant $kAEUTApostrophe 3)                ;  if a term contains an apostrophe. 

(defconstant $kAEUTFeminine 2)                  ;  if a term is feminine gender. 

(defconstant $kAEUTMasculine 1)                 ;  if a term is masculine gender. 

(defconstant $kAEUTPlural 0)                    ;  if a term is plural. 

(defrecord TScriptingSizeResource
   (scriptingSizeFlags :SInt16)
   (minStackSize :UInt32)
   (preferredStackSize :UInt32)
   (maxStackSize :UInt32)
   (minHeapSize :UInt32)
   (preferredHeapSize :UInt32)
   (maxHeapSize :UInt32)
)

;type name? (%define-record :TScriptingSizeResource (find-record-descriptor ':TScriptingSizeResource))

(defconstant $kLaunchToGetTerminology #x8000)   ;     If kLaunchToGetTerminology is 0, 'aete' is read directly from res file.  If set to 1, then launch and use 'gdut' to get terminology. 

(defconstant $kDontFindAppBySignature #x4000)   ;     If kDontFindAppBySignature is 0, then find app with signature if lost.  If 1, then don't 
;     If kAlwaysSendSubject 0, then send subject when appropriate. If 1, then every event has Subject Attribute 

(defconstant $kAlwaysSendSubject #x2000)
;  old names for above bits. 

(defconstant $kReadExtensionTermsMask #x8000)
;  AppleScript 1.3: Bit positions for osiz resource 
;  AppleScript 1.3: Bit masks for osiz resources 

(defconstant $kOSIZDontOpenResourceFile 15)     ;  If set, resource file is not opened when osax is loaded 

(defconstant $kOSIZdontAcceptRemoteEvents 14)   ;  If set, handler will not be called with events from remote machines 

(defconstant $kOSIZOpenWithReadPermission 13)   ;  If set, file will be opened with read permission only 

(defconstant $kOSIZCodeInSharedLibraries 11)    ;  If set, loader will look for handler in shared library, not osax resources 

; #pragma options align=reset

; #endif /* __AEUSERTERMTYPES__ */


(provide-interface "AEUserTermTypes")