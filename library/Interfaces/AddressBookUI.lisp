(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AddressBookUI.h"
; at Sunday July 2,2006 7:25:30 pm.
; 
;   AddressBookUI.h
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

; #import <AddressBook/ABPeoplePickerView.h>

; #import <AddressBook/ABActions.h>

; #if defined(__cplusplus)
#|
}
#endif
|#
 |#

; #else

(require-interface "AddressBook/ABPeoplePickerC")

(require-interface "AddressBook/ABActionsC")

; #endif


(provide-interface "AddressBookUI")