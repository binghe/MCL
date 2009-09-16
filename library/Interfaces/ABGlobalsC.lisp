(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABGlobalsC.h"
; at Sunday July 2,2006 7:23:06 pm.
; 
;  *  ABGlobalsC.h
;  *  AddressBook Framework
;  *
;  *  Copyright (c) 2002-2003 Apple Computer. All rights reserved.
;  *
;  
; #ifndef __ABGLOBALSC__
; #define __ABGLOBALSC__
; #ifndef __OBJC__

(require-interface "CoreFoundation/CoreFoundation")
;  NOTE: This header is for C programmers. For Objective-C use ABGlobals.h
;  ================================================================
;       Global Table properties
;  ================================================================
;  ----- Properties common to all Records
(def-mactype :kABUIDProperty (find-mactype ':CFStringRef))
;  The UID property - kABStringProperty
(def-mactype :kABCreationDateProperty (find-mactype ':CFStringRef))
;  Creation Date (when first saved) - kABDateProperty
(def-mactype :kABModificationDateProperty (find-mactype ':CFStringRef))
;  Last saved date - kABDateProperty
;  ----- Person specific properties
(def-mactype :kABFirstNameProperty (find-mactype ':CFStringRef))
;  First name - kABStringProperty
(def-mactype :kABLastNameProperty (find-mactype ':CFStringRef))
;  Last name - kABStringProperty
(def-mactype :kABFirstNamePhoneticProperty (find-mactype ':CFStringRef))
;  First name Phonetic - kABStringProperty
(def-mactype :kABLastNamePhoneticProperty (find-mactype ':CFStringRef))
;  Last name Phonetic - kABStringProperty
(def-mactype :kABNicknameProperty (find-mactype ':CFStringRef))
;  kABStringProperty
(def-mactype :kABMaidenNameProperty (find-mactype ':CFStringRef))
;  kABStringProperty
(def-mactype :kABBirthdayProperty (find-mactype ':CFStringRef))
;  Birth date - kABDateProperty
(def-mactype :kABOrganizationProperty (find-mactype ':CFStringRef))
;  Company name - kABStringProperty
(def-mactype :kABJobTitleProperty (find-mactype ':CFStringRef))
;  Job Title - kABStringProperty
(def-mactype :kABHomePageProperty (find-mactype ':CFStringRef))
;  Home Web pag - kABStringProperty
(def-mactype :kABEmailProperty (find-mactype ':CFStringRef))
;  Email(s) - kABMultiStringProperty
(def-mactype :kABEmailWorkLabel (find-mactype ':CFStringRef))
;  Work email
(def-mactype :kABEmailHomeLabel (find-mactype ':CFStringRef))
;  Home email
(def-mactype :kABAddressProperty (find-mactype ':CFStringRef))
;  Street Addresses - kABMultiDictionaryProperty
(def-mactype :kABAddressStreetKey (find-mactype ':CFStringRef))
;  Street
(def-mactype :kABAddressCityKey (find-mactype ':CFStringRef))
;  City
(def-mactype :kABAddressStateKey (find-mactype ':CFStringRef))
;  State
(def-mactype :kABAddressZIPKey (find-mactype ':CFStringRef))
;  Zip
(def-mactype :kABAddressCountryKey (find-mactype ':CFStringRef))
;  Country
(def-mactype :kABAddressCountryCodeKey (find-mactype ':CFStringRef))
;  Country Code
(def-mactype :kABAddressHomeLabel (find-mactype ':CFStringRef))
;  Home Address
(def-mactype :kABAddressWorkLabel (find-mactype ':CFStringRef))
;  Work Address
; 
;  * kABAddressCountryCodeKey code must be one of the following:
;  * iso country codes
;  *
;  *    ar = Argentina
;  *    at = Austria
;  *    au = Australia
;  *    ba = Bosnia and Herzegovina
;  *    be = Belgium
;  *    bg = Bulgaria
;  *    bh = Bahrain
;  *    br = Brazil
;  *    ca = Canada
;  *    ch = Switzerland
;  *    cn = China
;  *    cs = Czech
;  *    de = Germany
;  *    dk = Denmark
;  *    eg = Egypt
;  *    es = Spain
;  *    fi = Finland
;  *    fr = France
;  *    gr = Greece
;  *    gl = Greenland
;  *    hk = Hong Kong
;  *    hr = Croatia
;  *    hu = Hungary
;  *    ie = Ireland
;  *    il = Israel
;  *    id = Indonesia
;  *    in = India
;  *    is = Iceland
;  *    it = Italy
;  *    ja = Japan
;  *    jo = Jordan
;  *    kr = South Korea
;  *    kw = Kuwait
;  *    lb = Lebanon
;  *    lu = Luxembourg
;  *    mk = Macedonia
;  *    mx = Mexico
;  *    nl = Netherlands
;  *    no = Norway
;  *    nz = New Zealand
;  *    om = Oman
;  *    pl = Poland
;  *    pt = Portugal
;  *    qa = Qatar
;  *    ro = Romania
;  *    ru = Russian Federation
;  *    sa = Saudi Arabia
;  *    se = Sweden
;  *    sg = Singapore
;  *    si = Slovenia
;  *    sk = Slovakia
;  *    sy = Syrian Arab Republic
;  *    tw = Taiwan
;  *    tr = Turkey
;  *    ua = Ukraine
;  *    uk = United Kingdom
;  *    us = United States
;  *    ye = Yemen
;  *    za = South Africa
;  *
;  
(def-mactype :kABOtherDatesProperty (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Dates associated with this person - kABMultiDateProperty - (Person)
(def-mactype :kABAnniversaryLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABRelatedNamesProperty (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  names - kABMultiStringProperty
(def-mactype :kABFatherLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABMotherLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABParentLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABBrotherLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABSisterLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABChildLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABFriendLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABSpouseLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABPartnerLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABAssistantLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABManagerLabel (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABDepartmentProperty (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Department name - kABStringProperty - (Person)
(def-mactype :kABPersonFlags (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Various flags - kABIntegerProperty - (Person)
(defconstant $kABShowAsMask 7)
; #define kABShowAsMask                           000007
(defconstant $kABShowAsPerson 0)
; #define kABShowAsPerson                         000000
(defconstant $kABShowAsCompany 1)
; #define kABShowAsCompany                        000001
(defconstant $kABNameOrderingMask 70)
; #define kABNameOrderingMask                     000070
(defconstant $kABDefaultNameOrdering 0)
; #define kABDefaultNameOrdering                  000000
(defconstant $kABFirstNameFirst 40)
; #define kABFirstNameFirst                       000040
(defconstant $kABLastNameFirst 20)
; #define kABLastNameFirst                        000020
(def-mactype :kABPhoneProperty (find-mactype ':CFStringRef))
;  Generic phone number - kABMultiStringProperty
(def-mactype :kABPhoneWorkLabel (find-mactype ':CFStringRef))
;  Work phone
(def-mactype :kABPhoneHomeLabel (find-mactype ':CFStringRef))
;  Home phone
(def-mactype :kABPhoneMobileLabel (find-mactype ':CFStringRef))
;  Cell phone
(def-mactype :kABPhoneMainLabel (find-mactype ':CFStringRef))
;  Main phone
(def-mactype :kABPhoneHomeFAXLabel (find-mactype ':CFStringRef))
;  FAX number
(def-mactype :kABPhoneWorkFAXLabel (find-mactype ':CFStringRef))
;  FAX number
(def-mactype :kABPhonePagerLabel (find-mactype ':CFStringRef))
;  Pager number
(def-mactype :kABAIMInstantProperty (find-mactype ':CFStringRef))
;  AIM Instant Messaging - kABMultiStringProperty
(def-mactype :kABAIMWorkLabel (find-mactype ':CFStringRef))
(def-mactype :kABAIMHomeLabel (find-mactype ':CFStringRef))
(def-mactype :kABJabberInstantProperty (find-mactype ':CFStringRef))
;  Jabber Instant Messaging - kABMultiStringProperty
(def-mactype :kABJabberWorkLabel (find-mactype ':CFStringRef))
(def-mactype :kABJabberHomeLabel (find-mactype ':CFStringRef))
(def-mactype :kABMSNInstantProperty (find-mactype ':CFStringRef))
;  MSN Instant Messaging - kABMultiStringProperty
(def-mactype :kABMSNWorkLabel (find-mactype ':CFStringRef))
(def-mactype :kABMSNHomeLabel (find-mactype ':CFStringRef))
(def-mactype :kABYahooInstantProperty (find-mactype ':CFStringRef))
;  Yahoo Instant Messaging - kABMultiStringProperty
(def-mactype :kABYahooWorkLabel (find-mactype ':CFStringRef))
(def-mactype :kABYahooHomeLabel (find-mactype ':CFStringRef))
(def-mactype :kABICQInstantProperty (find-mactype ':CFStringRef))
;  ICQ Instant Messaging - kABMultiStringProperty
(def-mactype :kABICQWorkLabel (find-mactype ':CFStringRef))
(def-mactype :kABICQHomeLabel (find-mactype ':CFStringRef))
(def-mactype :kABNoteProperty (find-mactype ':CFStringRef))
;  Note (string)
;  ----- Person Properties not Currently supported in the AddressBook UI
(def-mactype :kABMiddleNameProperty (find-mactype ':CFStringRef))
;  kABStringProperty
(def-mactype :kABMiddleNamePhoneticProperty (find-mactype ':CFStringRef))
;  kABStringProperty
(def-mactype :kABTitleProperty (find-mactype ':CFStringRef))
;  kABStringProperty "Sir" "Duke" "General" "Lord"
(def-mactype :kABSuffixProperty (find-mactype ':CFStringRef))
;  kABStringProperty "Sr." "Jr." "III"
;  ----- Group Specific Properties
(def-mactype :kABGroupNameProperty (find-mactype ':CFStringRef))
;  Name of the group - kABStringProperty
;  ================================================================
;       Generic Labels
;  ================================================================
;  All kABXXXXWorkLabel are equivalent to this label
(def-mactype :kABWorkLabel (find-mactype ':CFStringRef))
;  All kABXXXXHomeLabel are equivalent to this label
(def-mactype :kABHomeLabel (find-mactype ':CFStringRef))
;  Can be use with any Mutli-value property
(def-mactype :kABOtherLabel (find-mactype ':CFStringRef))
;  ================================================================
;       RecordTypes
;  ================================================================
;  Type of a ABPersonRef
(def-mactype :kABPersonRecordType (find-mactype ':CFStringRef))
;  Type of a ABGroupRef
(def-mactype :kABGroupRecordType (find-mactype ':CFStringRef))
;  ================================================================
;       Notifications published when something changes
;  ================================================================
;  These notifications are not sent until ABGetSharedAddressBook()
;  has been called somewhere
;  This process has changed the DB
(def-mactype :kABDatabaseChangedNotification (find-mactype ':CFStringRef))
;  Another process has changed the DB
(def-mactype :kABDatabaseChangedExternallyNotification (find-mactype ':CFStringRef))
;  The user info in the above notifications will contain
;  the following 3 keys, the values of the keys in the dictionary
;  will be the uniqueIds of the Inserted/Updated/Deleted Records
(def-mactype :kABInsertedRecords (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABUpdatedRecords (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABDeletedRecords (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

; #endif


; #endif


(provide-interface "ABGlobalsC")