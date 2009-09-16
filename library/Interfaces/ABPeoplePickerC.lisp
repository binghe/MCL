(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABPeoplePickerC.h"
; at Sunday July 2,2006 7:23:06 pm.
; 
;   ABPeoplePickerC.h
;   AddressBook Framework
; 
;   Copyright (c) 2003 Apple Computer. All rights reserved.
; 
; #ifndef __PEOPLEPICKERC__
; #define __PEOPLEPICKERC__

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "AddressBook/ABAddressBookC")

(require-interface "Carbon/Carbon")

(def-mactype :ABPickerRef (find-mactype '(:pointer :OpaqueABPicker)))
; 
;  * Picker creation and manipulation
;  
;  Creates an ABPickerRef. Release with CFRelease(). The window is created hidden. Call
;  ABPickerSetVisibility() to show it.

(deftrap-inline "_ABPickerCreate" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueABPicker)
() )
;  Change the structural frame of the window.

(deftrap-inline "_ABPickerSetFrame" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inFrame (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerGetFrame" 
   ((inPicker (:pointer :OpaqueABPicker))
    (outFrame (:pointer :HIRECT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerSetVisibility" 
   ((inPicker (:pointer :OpaqueABPicker))
    (visible :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerIsVisible" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
; 
;  * Look and Feel
;  
;  Choose the selection behavior for the value column. If multiple behaviors are selected,
;  the most restrictive behavior will be used. Defaults to kABPickerSingleValueSelection set
;  to TRUE.

(defconstant $kABPickerSingleValueSelection 1)  ;  Allow user to choose a single value for a person.

(defconstant $kABPickerMultipleValueSelection 2);  Allow user to choose multiple values for a person.
;  Allow the user to select entire groups in the group column. If false, at least one
;  person in the group will be selected. Defaults to FALSE.

(defconstant $kABPickerAllowGroupSelection 4)   ;  Allow the user to select more than one group/record at a time. Defaults to TRUE.

(defconstant $kABPickerAllowMultipleSelection 8)

(def-mactype :ABPickerAttributes (find-mactype ':UInt32))

(deftrap-inline "_ABPickerGetAttributes" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )

(deftrap-inline "_ABPickerChangeAttributes" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inAttributesToSet :UInt32)
    (inAttributesToClear :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  * Value column
;  
;  These methods control what data (if any) is shown in the values column. The column will only
;  display if an AB property is added. A popup button in the column header will be used if more
;  than one property is added. Titles for built in properties will localized automatically. A
;  list of AB properties can be found in <AddressBook/ABGlobals.h>.

(deftrap-inline "_ABPickerAddProperty" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inProperty (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerRemoveProperty" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inProperty (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Returns an array of AB Properties as CFStringRefs.

(deftrap-inline "_ABPickerCopyProperties" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
;  Localized titles for third party properties should be set with these methods.

(deftrap-inline "_ABPickerSetColumnTitle" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inTitle (:pointer :__CFString))
    (inProperty (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerCopyColumnTitle" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inProperty (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
;  Display one of the properties added above in the values column.

(deftrap-inline "_ABPickerSetDisplayedProperty" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inProperty (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerCopyDisplayedProperty" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
; 
;  * Selection
;  
;  Returns group column selection as an array of ABGroupRef objects.

(deftrap-inline "_ABPickerCopySelectedGroups" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
;  Returns names column selection as an array of ABGroupRef or ABPersonRef objects.

(deftrap-inline "_ABPickerCopySelectedRecords" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
;  This method returns an array of selected multi-value identifiers. Returns nil if the displayed
;  property is a single value type.

(deftrap-inline "_ABPickerCopySelectedIdentifiers" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inPerson (:pointer :__ABPerson))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
;  Returns an array containing CFStringRefs for each item selected in the values column.

(deftrap-inline "_ABPickerCopySelectedValues" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFArray)
() )
;  Select group/name/value programatically.

(deftrap-inline "_ABPickerSelectGroup" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inGroup (:pointer :__ABGroup))
    (inExtendSelection :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerSelectRecord" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inRecord (:pointer :void))
    (inExtendSelection :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Individual values contained within an multi-value property can be selected with this method.

(deftrap-inline "_ABPickerSelectIdentifier" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inPerson (:pointer :__ABPerson))
    (inIdentifier (:pointer :__CFString))
    (inExtendSelection :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Remove selection

(deftrap-inline "_ABPickerDeselectGroup" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inGroup (:pointer :__ABGroup))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerDeselectRecord" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inRecord (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerDeselectIdentifier" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inPerson (:pointer :__ABPerson))
    (inIdentifier (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerDeselectAll" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
; 
;  * Events and Actions
;  *
;  * Your delegate will be notified when the user changes the selection or displayed property of the picker.
;  * Picker events have an event class of kEventClassABPeoplePicker and one of the kinds listed below. Picker
;  * events contain an event parameter which contains the ABPickerRef. To obtain this:
;  *
;  * GetEventParameter(inEvent, kEventParamABPickerRef,
;  *                   typeCFTypeRef, NULL, sizeof(ABPickerRef),
;  *                   NULL, &outPickerRef);
;  *
;  
;  Carbon Event class for People Picker

(defconstant $kEventClassABPeoplePicker :|abpp|)
;  Carbon Event kinds for People Picker

(defconstant $kEventABPeoplePickerGroupSelectionChanged 1)
(defconstant $kEventABPeoplePickerNameSelectionChanged 2)
(defconstant $kEventABPeoplePickerValueSelectionChanged 3)
(defconstant $kEventABPeoplePickerDisplayedPropertyChanged 4)
(defconstant $kEventABPeoplePickerGroupDoubleClicked 5)
(defconstant $kEventABPeoplePickerNameDoubleClicked 6)
;  Carbon Event parameter name

(defconstant $kEventParamABPickerRef :|abpp|)
;  Set the event handler for People Picker events.

(deftrap-inline "_ABPickerSetDelegate" 
   ((inPicker (:pointer :OpaqueABPicker))
    (inDelegate (:pointer :OpaqueHIObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerGetDelegate" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :OpaqueHIObjectRef)
() )
;  Clear the search field and reset the list of displayed names.

(deftrap-inline "_ABPickerClearSearchField" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Launch AddressBook and edit the current selection

(deftrap-inline "_ABPickerEditInAddressBook" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_ABPickerSelectInAddressBook" 
   ((inPicker (:pointer :OpaqueABPicker))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif


(provide-interface "ABPeoplePickerC")