(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AddressBook.h"
; at Sunday July 2,2006 7:25:30 pm.
; 
;   AddressBook.h
;   AddressBook Framework
; 
;   Copyright (c) 2002-2003 Apple Computer. All rights reserved.
; 

; #if __OBJC__
#| 
; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

; #import <AddressBook/ABTypedefs.h>

; #import <AddressBook/ABGlobals.h>

; #import <AddressBook/ABAddressBook.h>

; #import <AddressBook/ABRecord.h>

; #import <AddressBook/ABGroup.h>

; #import <AddressBook/ABPerson.h>

; #import <AddressBook/ABImageLoading.h>

; #import <AddressBook/ABSearchElement.h>

; #import <AddressBook/ABMultiValue.h>

; #if defined(__cplusplus)
#|
}
#endif
|#
 |#

; #else

(require-interface "AddressBook/ABTypedefs")

(require-interface "AddressBook/ABGlobalsC")

(require-interface "AddressBook/ABAddressBookC")

; #endif


(provide-interface "AddressBook")