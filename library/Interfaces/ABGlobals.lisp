(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABGlobals.h"
; at Sunday July 2,2006 7:23:06 pm.
; 
;  *  ABGlobals.h
;  *  AddressBook Framework
;  *
;  *  Copyright (c) 2002-2003 Apple Computer. All rights reserved.
;  *
;  

; #import <Foundation/Foundation.h>
;  ================================================================
;       Global Table properties
;  ================================================================
;  ----- Properties common to all Records
(def-mactype :kABUIDProperty (find-mactype '(:pointer :NSString)))
;  The UID property - kABStringProperty
(def-mactype :kABCreationDateProperty (find-mactype '(:pointer :NSString)))
;  Creation Date (when first saved) - kABDateProperty
(def-mactype :kABModificationDateProperty (find-mactype '(:pointer :NSString)))
;  Last saved date - kABDateProperty
;  ----- Person specific properties
(def-mactype :kABFirstNameProperty (find-mactype '(:pointer :NSString)))
;  First name - kABStringProperty
(def-mactype :kABLastNameProperty (find-mactype '(:pointer :NSString)))
;  Last name - kABStringProperty
(def-mactype :kABFirstNamePhoneticProperty (find-mactype '(:pointer :NSString)))
;  First name Phonetic - kABStringProperty
(def-mactype :kABLastNamePhoneticProperty (find-mactype '(:pointer :NSString)))
;  Last name Phonetic - kABStringProperty
(def-mactype :kABNicknameProperty (find-mactype '(:pointer :NSString)))
;  kABStringProperty
(def-mactype :kABMaidenNameProperty (find-mactype '(:pointer :NSString)))
;  kABStringProperty
(def-mactype :kABBirthdayProperty (find-mactype '(:pointer :NSString)))
;  Birth date - kABDateProperty
(def-mactype :kABOrganizationProperty (find-mactype '(:pointer :NSString)))
;  Company name - kABStringProperty
(def-mactype :kABJobTitleProperty (find-mactype '(:pointer :NSString)))
;  Job Title - kABStringProperty
(def-mactype :kABHomePageProperty (find-mactype '(:pointer :NSString)))
;  Home Web page - kABStringProperty
(def-mactype :kABEmailProperty (find-mactype '(:pointer :NSString)))
;  Email(s) - kABMultiStringProperty
(def-mactype :kABEmailWorkLabel (find-mactype '(:pointer :NSString)))
;  Home email
(def-mactype :kABEmailHomeLabel (find-mactype '(:pointer :NSString)))
;  Work email
(def-mactype :kABAddressProperty (find-mactype '(:pointer :NSString)))
;  Street Addresses - kABMultiDictionaryProperty
(def-mactype :kABAddressStreetKey (find-mactype '(:pointer :NSString)))
;  Street
(def-mactype :kABAddressCityKey (find-mactype '(:pointer :NSString)))
;  City
(def-mactype :kABAddressStateKey (find-mactype '(:pointer :NSString)))
;  State
(def-mactype :kABAddressZIPKey (find-mactype '(:pointer :NSString)))
;  Zip
(def-mactype :kABAddressCountryKey (find-mactype '(:pointer :NSString)))
;  Country
(def-mactype :kABAddressCountryCodeKey (find-mactype '(:pointer :NSString)))
;  Country Code
(def-mactype :kABAddressHomeLabel (find-mactype '(:pointer :NSString)))
;  Home Address
(def-mactype :kABAddressWorkLabel (find-mactype '(:pointer :NSString)))
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
(def-mactype :kABOtherDatesProperty (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Dates associated with this person - kABMultiDateProperty - (Person)
(def-mactype :kABAnniversaryLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABRelatedNamesProperty (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  names - kABMultiStringProperty
(def-mactype :kABFatherLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABMotherLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABParentLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABBrotherLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABSisterLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABChildLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABFriendLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABSpouseLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABPartnerLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABAssistantLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABManagerLabel (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABDepartmentProperty (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Department name - (Person)
(def-mactype :kABPersonFlags (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  Various flags - kABIntegerProperty
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
(def-mactype :kABPhoneProperty (find-mactype '(:pointer :NSString)))
;  Generic phone number - kABMultiStringProperty
(def-mactype :kABPhoneWorkLabel (find-mactype '(:pointer :NSString)))
;  Work phone
(def-mactype :kABPhoneHomeLabel (find-mactype '(:pointer :NSString)))
;  Home phone
(def-mactype :kABPhoneMobileLabel (find-mactype '(:pointer :NSString)))
;  Cell phone
(def-mactype :kABPhoneMainLabel (find-mactype '(:pointer :NSString)))
;  Main phone
(def-mactype :kABPhoneHomeFAXLabel (find-mactype '(:pointer :NSString)))
;  FAX number
(def-mactype :kABPhoneWorkFAXLabel (find-mactype '(:pointer :NSString)))
;  FAX number
(def-mactype :kABPhonePagerLabel (find-mactype '(:pointer :NSString)))
;  Pager number
(def-mactype :kABAIMInstantProperty (find-mactype '(:pointer :NSString)))
;  AIM Instant Messaging - kABMultiStringProperty
(def-mactype :kABAIMWorkLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABAIMHomeLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABJabberInstantProperty (find-mactype '(:pointer :NSString)))
;  Jabber Instant Messaging - kABMultiStringProperty
(def-mactype :kABJabberWorkLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABJabberHomeLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABMSNInstantProperty (find-mactype '(:pointer :NSString)))
;  MSN Instant Messaging  - kABMultiStringProperty
(def-mactype :kABMSNWorkLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABMSNHomeLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABYahooInstantProperty (find-mactype '(:pointer :NSString)))
;  Yahoo Instant Messaging  - kABMultiStringProperty
(def-mactype :kABYahooWorkLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABYahooHomeLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABICQInstantProperty (find-mactype '(:pointer :NSString)))
;  ICQ Instant Messaging  - kABMultiStringProperty
(def-mactype :kABICQWorkLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABICQHomeLabel (find-mactype '(:pointer :NSString)))
(def-mactype :kABNoteProperty (find-mactype '(:pointer :NSString)))
;  Note - kABStringProperty
(def-mactype :kABMiddleNameProperty (find-mactype '(:pointer :NSString)))
;  kABStringProperty
(def-mactype :kABMiddleNamePhoneticProperty (find-mactype '(:pointer :NSString)))
;  kABStringProperty
(def-mactype :kABTitleProperty (find-mactype '(:pointer :NSString)))
;  kABStringProperty "Sir" "Duke" "General" "Lord"
(def-mactype :kABSuffixProperty (find-mactype '(:pointer :NSString)))
;  kABStringProperty "Sr." "Jr." "III"
;  ----- Group Specific Properties
(def-mactype :kABGroupNameProperty (find-mactype '(:pointer :NSString)))
;  Name of the group - kABStringProperty
;  ================================================================
;       Generic Labels
;  ================================================================
;  All kABXXXXWorkLabel are equivalent to this label
(def-mactype :kABWorkLabel (find-mactype '(:pointer :NSString)))
;  All kABXXXXHomeLabel are equivalent to this label
(def-mactype :kABHomeLabel (find-mactype '(:pointer :NSString)))
;  Can be use with any Mutli-value property
(def-mactype :kABOtherLabel (find-mactype '(:pointer :NSString)))
;  ================================================================
;       Notifications published when something changes
;  ================================================================
;  These notifications are not sent until [ABAddressBook sharedAddressBook]
;  has been called somewhere
;  This process has changed the DB
(def-mactype :kABDatabaseChangedNotification (find-mactype '(:pointer :NSString)))
;  Another process has changed the DB
(def-mactype :kABDatabaseChangedExternallyNotification (find-mactype '(:pointer :NSString)))
;  The user info (dictionary) in the above notification will contain
;  the following 3 keys. Value for each keys is an array of
;  uniqueId of the Inserted/Updated/Deleted Records.
;  If all three values are nil assume that everything has changed (could be the case
;  when restoring from backup)
(def-mactype :kABInsertedRecords (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABUpdatedRecords (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kABDeletedRecords (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ================================================================
;       Localization of property or label
;  ================================================================
;  Returns the localized version of built in properties, labels or keys
;  Returns propertyOrLabel if not found (e.g. if not built in)

(provide-interface "ABGlobals")