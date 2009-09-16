(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABPeoplePickerView.h"
; at Sunday July 2,2006 7:25:19 pm.
; 
;   ABPeoplePickerView.h
;   AddressBook Framework
; 
;   Copyright (c) 2003 Apple Computer. All rights reserved.
; 

; #import <Cocoa/Cocoa.h>

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $ABNoValueSelection 0)
(defconstant $ABSingleValueSelection 1)
(defconstant $ABMultipleValueSelection 2)
(def-mactype :ABPeoplePickerSelectionBehavior (find-mactype ':SINT32))
#| @INTERFACE 
ABPeoplePickerView : NSView
{
private
    id                  _accessoryView;
    id                  _loader;
    id                  _uiController;
    id                  _target;
    void               *_carbonDelegate;
    SEL                 _groupsDoubleAction;
    SEL                 _peopleDoubleAction;
    NSMutableArray     *_columns;
    NSString           *_autosaveName;
    void               *_flags;
}


- (void)setAccessoryView:(NSView *)accessory;
- (NSView *)accessoryView;


- (void)setValueSelectionBehavior:(ABPeoplePickerSelectionBehavior)behavior;
- (ABPeoplePickerSelectionBehavior)valueSelectionBehavior;

- (void)setAllowsGroupSelection:(BOOL)flag;
- (BOOL)allowsGroupSelection;

- (void)setAllowsMultipleSelection:(BOOL)flag;
- (BOOL)allowsMultipleSelection;



- (void)addProperty:(NSString *)property;
- (void)removeProperty:(NSString *)property;
- (NSArray *)properties;

- (void)setColumnTitle:(NSString *)title forProperty:(NSString *)property;
- (NSString *)columnTitleForProperty:(NSString *)property;

- (void)setDisplayedProperty:(NSString *)property;
- (NSString *)displayedProperty;



- (void)setAutosaveName:(NSString *)name;
- (NSString *)autosaveName;



- (NSArray *)selectedGroups;

- (NSArray *)selectedRecords;

- (NSArray *)selectedIdentifiersForPerson:(ABPerson*)person;

- (void)selectGroup:(ABGroup *)group byExtendingSelection:(BOOL)extend;
- (void)selectRecord:(ABRecord *)record byExtendingSelection:(BOOL)extend;
- (void)selectIdentifier:(NSString *)identifier forPerson:(ABPerson *)person byExtendingSelection:(BOOL)extend;

- (void)deselectGroup:(ABGroup *)group;
- (void)deselectRecord:(ABRecord *)record;
- (void)deselectIdentifier:(NSString *)identifier forPerson:(ABPerson *)person;

- (void)deselectAll:(id)sender;



- (void)clearSearchField:(id)sender;

- (void)setTarget:(id)target;
- (id)target;

- (void)setGroupDoubleAction:(SEL)action;
- (SEL)groupDoubleAction;

- (void)setNameDoubleAction:(SEL)action;
- (SEL)nameDoubleAction;

|#
; 
;  * Notifications
;  
(def-mactype :ABPeoplePickerGroupSelectionDidChangeNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :ABPeoplePickerNameSelectionDidChangeNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :ABPeoplePickerValueSelectionDidChangeNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :ABPeoplePickerDisplayedPropertyDidChangeNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
#| @INTERFACE 
ABPeoplePickerView (ABPeoplePickerConvenience)
- (NSArray *)selectedValues;

- (void)editInAddressBook:(id)sender;
- (void)selectInAddressBook:(id)sender;

|#

; #endif


(provide-interface "ABPeoplePickerView")