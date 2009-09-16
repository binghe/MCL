(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABTypedefs.h"
; at Sunday July 2,2006 7:23:05 pm.
; 
;  *  ABTypedefs.h
;  *  AddressBook Framework
;  *
;  *  Copyright (c) 2002-2003 Apple Computer. All rights reserved.
;  *
;  
; #ifndef __ABTYPEDEFS__
; #define __ABTYPEDEFS__
;  ================================================================
;       Property Type
;  ================================================================
(defconstant $kABMultiValueMask 256)
; #define kABMultiValueMask        0x100
(def-mactype :_ABPropertyType (find-mactype ':sint32))

(defconstant $kABErrorInProperty 0)
(defconstant $kABStringProperty 1)
(defconstant $kABIntegerProperty 2)
(defconstant $kABRealProperty 3)
(defconstant $kABDateProperty 4)
(defconstant $kABArrayProperty 5)
(defconstant $kABDictionaryProperty 6)
(defconstant $kABDataProperty 7)
(defconstant $kABMultiStringProperty #x101)
(defconstant $kABMultiIntegerProperty #x102)
(defconstant $kABMultiRealProperty #x103)
(defconstant $kABMultiDateProperty #x104)
(defconstant $kABMultiArrayProperty #x105)
(defconstant $kABMultiDictionaryProperty #x106)
(defconstant $kABMultiDataProperty #x107)
(def-mactype :ABPropertyType (find-mactype ':SINT32))
;  ================================================================
;       Search APIs
;  ================================================================
(def-mactype :_ABSearchComparison (find-mactype ':sint32))

(defconstant $kABEqual 0)
(defconstant $kABNotEqual 1)
(defconstant $kABLessThan 2)
(defconstant $kABLessThanOrEqual 3)
(defconstant $kABGreaterThan 4)
(defconstant $kABGreaterThanOrEqual 5)
(defconstant $kABEqualCaseInsensitive 6)
(defconstant $kABContainsSubString 7)
(defconstant $kABContainsSubStringCaseInsensitive 8)
(defconstant $kABPrefixMatch 9)
(defconstant $kABPrefixMatchCaseInsensitive 10)
; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

; #endif


(defconstant $kABBitsInBitFieldMatch 11)
(def-mactype :ABSearchComparison (find-mactype ':SINT32))
(def-mactype :_ABSearchConjunction (find-mactype ':sint32))

(defconstant $kABSearchAnd 0)
(defconstant $kABSearchOr 1)
(def-mactype :ABSearchConjunction (find-mactype ':SINT32))

; #endif


(provide-interface "ABTypedefs")