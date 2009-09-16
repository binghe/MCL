(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHIDDescriptorParser.h"
; at Sunday July 2,2006 7:29:15 pm.
; 
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * Copyright (c) 1999-2003 Apple Computer, Inc.  All Rights Reserved.
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef __IOHIDDescriptorParser__
; #define __IOHIDDescriptorParser__

(require-interface "IOKit/IOTypes")

(require-interface "IOKit/hidsystem/IOHIDUsageTables")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  Types and enums required by these functions but not in IOTypes.h 

;type name? (def-mactype :Byte (find-mactype ':UInt8))

(def-mactype :SignedByte (find-mactype ':SInt8))

;type name? (def-mactype :FourCharCode (find-mactype ':UInt32))

;type name? (def-mactype :OSType (find-mactype ':FourCharCode))

(def-mactype :ByteCount (find-mactype ':UInt32))

(defconstant $noErr 0)
;  End missing types and enums 

(defconstant $kHIDSuccess 0)                    ;  HID assigned error numbers are -13949 .. -13900 

(defconstant $kHIDBaseError -13950)
(defconstant $kHIDNullStateErr -13949)
(defconstant $kHIDBufferTooSmallErr -13948)
(defconstant $kHIDValueOutOfRangeErr -13947)
(defconstant $kHIDUsageNotFoundErr -13946)
(defconstant $kHIDNotValueArrayErr -13945)
(defconstant $kHIDInvalidPreparsedDataErr -13944)
(defconstant $kHIDIncompatibleReportErr -13943)
(defconstant $kHIDBadLogPhysValuesErr -13942)
(defconstant $kHIDInvalidReportTypeErr -13941)
(defconstant $kHIDInvalidReportLengthErr -13940)
(defconstant $kHIDNullPointerErr -13939)
(defconstant $kHIDBadParameterErr -13938)
(defconstant $kHIDNotEnoughMemoryErr -13937)
(defconstant $kHIDEndOfDescriptorErr -13936)
(defconstant $kHIDUsagePageZeroErr -13935)
(defconstant $kHIDBadLogicalMinimumErr -13934)
(defconstant $kHIDBadLogicalMaximumErr -13933)
(defconstant $kHIDInvertedLogicalRangeErr -13932)
(defconstant $kHIDInvertedPhysicalRangeErr -13931)
(defconstant $kHIDUnmatchedUsageRangeErr -13930)
(defconstant $kHIDInvertedUsageRangeErr -13929)
(defconstant $kHIDUnmatchedStringRangeErr -13928)
(defconstant $kHIDUnmatchedDesignatorRangeErr -13927)
(defconstant $kHIDReportSizeZeroErr -13926)
(defconstant $kHIDReportCountZeroErr -13925)
(defconstant $kHIDReportIDZeroErr -13924)
(defconstant $kHIDInvalidRangePageErr -13923)   ;  
;  HID device driver errors 
; 

(defconstant $kHIDDeviceNotReady -13910)        ;  The device is still initializing, try again later

(defconstant $kHIDVersionIncompatibleErr -13909);  types of HID reports (input, output, feature)

(defconstant $kHIDInputReport 1)
(defconstant $kHIDOutputReport 2)
(defconstant $kHIDFeatureReport 3)
(defconstant $kHIDUnknownReport #xFF)
;  flags passed to HIDOpenReportDescriptor

(defconstant $kHIDFlag_StrictErrorChecking 1)

(def-mactype :HIDReportType (find-mactype ':UInt32))

(def-mactype :HIDUsage (find-mactype ':UInt32))

(def-mactype :HIDPreparsedDataRef (find-mactype '(:pointer :void)))
; !
;   @typedef HIDUsageAndPage
;   @abstract The HIDUsageAndPage data structure is used by HID clients when obtaining status of buttons to hold the usage page and usage of a button that is down.
;   @discussion Clients use the HIDUSageAndPage structure with the HIDGetButtonsEx function to obtain both the usage page and usage identifiers of each button that is down.
;   @field usage Specifies the usage identifier within the usage page specified by usagePage of a button that is down.
;   @field usagePage Specifies the usage page identifier of a button that is down.
;  
(defrecord HIDUsageAndPage
   (usage :UInt32)
   (usagePage :UInt32)
)

(def-mactype :HIDUsageAndPagePtr (find-mactype '(:POINTER :HIDUsageAndPage)))
; !
;   @typedef HIDCaps
;   @abstract The HIDCaps data structure is used by HID clients to hold the capabilities of a HID device.
;   @discussion This structure holds the parsed capabilities and data maximums returned for a device by the HIDGetCaps function.
;   @field usage Specifies the specific class of functionality that this device provides.  This value is dependent and specific to the value provided in the usagePage field.  For example, a keyboard could have a usagePage of kHIDUsagePage_Generic and a usage of kHIDUsage_Generic_Keyboard.
;   @field usagePage Specifies the usage page identifier for this top level collection.
;   @field inputReportByteLength Specifies the maximum length, in bytes, of an input report for this device, including the report ID which is unilaterally prepended to the device data.
;   @field outputReportByteLength Specifies the maximum length, in bytes, of an output report for this device, including the report ID which is unilaterally prepended to the device data.
;   @field featureReportByteLength Specifies the maximum length, in bytes, of a feature report for this device, including the report ID which is unilaterally prepended to the device data.
;   @field numberCollectionNodes Specifies the number of HIDCollectionNode structures that are returned for this top level collection by the HIDGetConnectionNodes function.
;   @field numberInputButtonCaps Specifies the number of input buttons.
;   @field numberInputValueCaps Specifies the number of input values.
;   @field numberOutputButtonCaps Specifies the number of output buttons.
;   @field numberOutputValueCaps Specifies the number of output values
;   @field numberFeatureButtonCaps Specifies the number of feature buttons.
;   @field numberFeatureValueCaps Specifies the number of feature values.
;  
(defrecord HIDCaps
   (usage :UInt32)
   (usagePage :UInt32)
   (inputReportByteLength :UInt32)
   (outputReportByteLength :UInt32)
   (featureReportByteLength :UInt32)
   (numberCollectionNodes :UInt32)
   (numberInputButtonCaps :UInt32)
   (numberInputValueCaps :UInt32)
   (numberOutputButtonCaps :UInt32)
   (numberOutputValueCaps :UInt32)
   (numberFeatureButtonCaps :UInt32)
   (numberFeatureValueCaps :UInt32)
)

(def-mactype :HIDCapsPtr (find-mactype '(:POINTER :HIDCaps)))
(defrecord HIDCapabilities
   (usage :UInt32)
   (usagePage :UInt32)
   (inputReportByteLength :UInt32)
   (outputReportByteLength :UInt32)
   (featureReportByteLength :UInt32)
   (numberCollectionNodes :UInt32)
   (numberInputButtonCaps :UInt32)
   (numberInputValueCaps :UInt32)
   (numberOutputButtonCaps :UInt32)
   (numberOutputValueCaps :UInt32)
   (numberFeatureButtonCaps :UInt32)
   (numberFeatureValueCaps :UInt32)
)

(def-mactype :HIDCapabilitiesPtr (find-mactype '(:POINTER :HIDCapabilities)))
(defrecord HIDCollectionNode
   (collectionUsage :UInt32)
   (collectionUsagePage :UInt32)
   (parent :UInt32)
   (numberOfChildren :UInt32)
   (nextSibling :UInt32)
   (firstChild :UInt32)
)

(def-mactype :HIDCollectionNodePtr (find-mactype '(:POINTER :HIDCollectionNode)))
(defrecord HIDButtonCaps
   (usagePage :UInt32)
   (reportID :UInt32)
   (bitField :UInt32)
   (collection :UInt32)
   (collectionUsage :UInt32)
   (collectionUsagePage :UInt32)
   (isRange :Boolean)
   (isStringRange :Boolean)
   (isDesignatorRange :Boolean)
   (isAbsolute :Boolean)
   (startBit :SInt32)
                                                ;  Added esb 9-29-99
   (:variant
   (
   (usageMin :UInt32)
   (usageMax :UInt32)
   (stringMin :UInt32)
   (stringMax :UInt32)
   (designatorMin :UInt32)
   (designatorMax :UInt32)
   )
   (
   (usage :UInt32)
   (reserved1 :UInt32)
   (stringIndex :UInt32)
   (reserved2 :UInt32)
   (designatorIndex :UInt32)
   (reserved3 :UInt32)
   )
   )
)

(def-mactype :HIDButtonCapsPtr (find-mactype '(:POINTER :HIDButtonCaps)))
(defrecord HIDButtonCapabilities
   (usagePage :UInt32)
   (reportID :UInt32)
   (bitField :UInt32)
   (collection :UInt32)
   (collectionUsage :UInt32)
   (collectionUsagePage :UInt32)
   (isRange :Boolean)
   (isStringRange :Boolean)
   (isDesignatorRange :Boolean)
   (isAbsolute :Boolean)
   (unitExponent :SInt32)
                                                ;  Added KH 1/25/01
   (units :SInt32)
                                                ;  Added KH 1/25/01
                                                ;     UInt32                          reserved;		// Not added KH 1/25/01
   (startBit :SInt32)
                                                ;  Added esb 9-29-99
   (pbVersion :UInt32)
                                                ;  Added KH 1/25/01
   (:variant
   (
   (usageMin :UInt32)
   (usageMax :UInt32)
   (stringMin :UInt32)
   (stringMax :UInt32)
   (designatorMin :UInt32)
   (designatorMax :UInt32)
   )
   (
   (usage :UInt32)
   (reserved1 :UInt32)
   (stringIndex :UInt32)
   (reserved2 :UInt32)
   (designatorIndex :UInt32)
   (reserved3 :UInt32)
   )
   )
)

(def-mactype :HIDButtonCapabilitiesPtr (find-mactype '(:POINTER :HIDButtonCapabilities)))
(defrecord HIDValueCaps
   (usagePage :UInt32)
   (reportID :UInt32)
   (bitField :UInt32)
   (collection :UInt32)
   (collectionUsage :UInt32)
   (collectionUsagePage :UInt32)
   (isRange :Boolean)
   (isStringRange :Boolean)
   (isDesignatorRange :Boolean)
   (isAbsolute :Boolean)
   (startBit :UInt32)
                                                ;  Added by esb 9-28-99
   (bitSize :UInt32)
   (reportCount :UInt32)
   (logicalMin :SInt32)
   (logicalMax :SInt32)
   (physicalMin :SInt32)
   (physicalMax :SInt32)
   (:variant
   (
   (usageMin :UInt32)
   (usageMax :UInt32)
   (stringMin :UInt32)
   (stringMax :UInt32)
   (designatorMin :UInt32)
   (designatorMax :UInt32)
   )
   (
   (usage :UInt32)
   (reserved1 :UInt32)
   (stringIndex :UInt32)
   (reserved2 :UInt32)
   (designatorIndex :UInt32)
   (reserved3 :UInt32)
   )
   )
)

(def-mactype :HIDValueCapsPtr (find-mactype '(:POINTER :HIDValueCaps)))
(defrecord HIDValueCapabilities
   (usagePage :UInt32)
   (reportID :UInt32)
   (bitField :UInt32)
   (collection :UInt32)
   (collectionUsage :UInt32)
   (collectionUsagePage :UInt32)
   (isRange :Boolean)
   (isStringRange :Boolean)
   (isDesignatorRange :Boolean)
   (isAbsolute :Boolean)
   (bitSize :UInt32)
   (reportCount :UInt32)
   (logicalMin :SInt32)
   (logicalMax :SInt32)
   (physicalMin :SInt32)
   (physicalMax :SInt32)
   (unitExponent :SInt32)
                                                ;  Added KH 1/25/01
   (units :SInt32)
                                                ;  Added KH 1/25/01
                                                ;     UInt32                          reserved;		// Not added KH 1/25/01
   (startBit :SInt32)
                                                ;  Added esb 9-29-99	// Moved here KH 1/25/01
   (pbVersion :UInt32)
                                                ;  Added KH 1/25/01
   (:variant
   (
   (usageMin :UInt32)
   (usageMax :UInt32)
   (stringMin :UInt32)
   (stringMax :UInt32)
   (designatorMin :UInt32)
   (designatorMax :UInt32)
   )
   (
   (usage :UInt32)
   (reserved1 :UInt32)
   (stringIndex :UInt32)
   (reserved2 :UInt32)
   (designatorIndex :UInt32)
   (reserved3 :UInt32)
   )
   )
)

(def-mactype :HIDValueCapabilitiesPtr (find-mactype '(:POINTER :HIDValueCapabilities)))
; !
;   @function HIDOpenReportDescriptor
;   @abstract The HIDOpenReportDescriptor function allocates the memory the parser needs to handle the given report descriptor, and then parses the report descriptor.
;   @discussion When the parsed information is no longer needed, clients should call the HIDCloseReportDescriptor function.
;   @param hidReportDescriptor Contains a pointer to the actual HID report descriptor from the USB device's firmware
;   @param descriptorLength The length of the HID report descriptor
;   @param preparsedDataRef Preparsed data reference to be used for subsequent function calls
;   @param flags Flags for this runction are kHIDFlag_StrictErrorChecking = 0x00000001
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDOpenReportDescriptor" 
   ((hidReportDescriptor :pointer)
    (descriptorLength :UInt32)
    (preparsedDataRef (:pointer :HIDPREPARSEDDATAREF))
    (flags :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDCloseReportDescriptor
;   @abstract Disposes of the memory the parser allocated for the HIDOpenReportDescriptor function.
;   @param hidReportDescriptor Contains a pointer to the actual HID report descriptor from the USB device's firmware
;   @param preparsedDataRef Preparsed data reference for the report that is returned by the HIDOpenReportDescriptor function.  After making a call to the HIDCloseReportDescriptor function, the preparsedDataRef is invalid and should not be used.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDCloseReportDescriptor" 
   ((preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetButtonCaps
;   @abstract Returns the button capabilities structures for a HID device based on the given preparsed data.
;  @param reportType Specifies the type of report for which to retrieve the scaled value.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport
;   @param buttonCaps Points to a caller-allocated buffer that will contain, on return, an array of HIDButtonCaps structures.  The structures contain information for all buttons that meet the search criteria
;   @param buttonCapsSize Contains the size of the buttonCaps array passed in to the function and is set to the number of elements actually placed in the array after the call completes.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetButtonCaps" 
   ((reportType :UInt32)
    (buttonCaps (:pointer :HIDBUTTONCAPS))
    (buttonCapsSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetButtonCapabilities
;   @abstract Returns the button capabilities structures for a HID device based on the given preparsed data.
;  @param reportType Specifies the type of report for which to retrieve the scaled value.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport
;   @param buttonCaps Points to a caller-allocated buffer that will contain, on return, an array of HIDButtonCapabilities structures.  The structures contain information for all buttons that meet the search criteria
;   @param buttonCapsSize Contains the size of the buttonCaps array passed in to the function and is set to the number of elements actually placed in the array after the call completes.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetButtonCapabilities" 
   ((reportType :UInt32)
    (buttonCaps (:pointer :HIDBUTTONCAPABILITIES))
    (buttonCapsSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetCaps
;   @abstract Returns the capabilities of a HID device based on the given preparsed data.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param capabilities Points to a caller allocated buffer, that upon return contains the parsed capability information for this HID device.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetCaps" 
   ((preparsedDataRef (:pointer :void))
    (capabilities (:pointer :HIDCAPS))
   )
   :OSStatus
() )
; !
;   @function HIDGetCapabilities
;   @abstract Returns the capabilities of a HID device based on the given preparsed data.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param capabilities Points to a caller allocated buffer, that upon return contains the parsed capability information for this HID device.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetCapabilities" 
   ((preparsedDataRef (:pointer :void))
    (capabilities (:pointer :HIDCAPABILITIES))
   )
   :OSStatus
() )
; !
;   @function HIDGetCollectionNodes
;   @abstract Returns an array of HIDCollectionNode structures that describe the relationships and layout of the link collections within this top level collection.
;   @discussion The length of the buffer required, in array elements, for an entire collection node array is found in the HIDCaps structure member numberCollectionNodes.  You obtain the HIDCaps information by calling the HIDGetCaps function.  For information on the relationships of link collections described by the data returned from this routine, see the descripton of the HIDCollectionNode structure.
;   @param collectionNodes Points to a caller-allocated array of HIDCollectionNode structures in which this routine returns an entry for each collection within the top level collection.  A collection is a group of corresponding HID descriptors containing input, output, and feature items that have some common relationship to one another.  For example, a pointer collection contains items for x and y position data, and button data.
;   @param collectionNodesSize On input, specifies the length in array elements of the buffer provided at collectionNodes.  On output, this parameter is set to the number of entries in the collectionNodes array that were initialized.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetCollectionNodes" 
   ((collectionNodes (:pointer :HIDCOLLECTIONNODE))
    (collectionNodesSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetScaledUsageValue
;   @abstract The HIDGetScaledUsageValue function returns the capabilities for all buttons for a given top level collection.
;   @discussion Clients who which to obtain all capabilities for a usage that contains multiple data items for a single usage that corresponds to a HID byte array, must call the HIDGetUsageValueArray function.
;   @param reportType Specifies the type of report for which to retrieve the scaled value.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies the usage page of the value to be retrieved.
;   @param collection Optionally specifies the link collection identifier of the value to be retrieved.
;   @param usage Specifies the usage of the scaled value to be retrieved.
;   @param usageValue Points to a variable, that on return from this routine holds the scaled value retrieved from the device report.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data
;   @param reportLength Specifies the length, in bytes, of the report data provided at report
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetScaledUsageValue" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (usageValue (:pointer :SInt32))
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDGetSpecificButtonCaps
;   @abstract Retrieves the capabilities for all buttons in a specific type of report that meet the search criteria.
;   @discussion The HIDGetSpecificButtonCaps function retrieves capability data for buttons that meet a given search criteria, as opposed to the HIDGetButtonCaps function which returns the capability data for all buttons on the device.  Calling this routine specifying zero for usagePage, usage and collection is equivalent to calling the HIDGetButtonCaps function.
;   @param reportType Specifies the type of report for which to retrieve the button capabilities.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies a usage page identifier to use as a search criteria.  If this parameter is non-zero, then only buttons that specify this usage page will be retrieved.
;   @param collection Specifies a link collection identifier to use as a search criteria.  If this parameter is non-zero, then only buttons that are part of the specified link collection are retrieved.
;   @param usage Specifies a usage identifier to use as a search criteria.  If this parameter is non-zero, then only buttons that match the value specified are retrieved.
;   @param buttonCaps Points to a caller-allocated buffer that will contain, on return, an array of HIDButtonCaps structures.  The structures contain information for all buttons that meet the search criteria.
;   @param buttonCapsLength On input, specifies the length, in array elements, of the buffer provided in the buttonCaps parameter.  On output, this parameter is set to the actual number of elements that were returned by the function call, in the buffer provided in the buttonCaps parameter, if the routine completed without error.  The correct length necessary to retrieve the button capabilities can be found in the capability data returned for the device by the HIDGetCaps function.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetSpecificButtonCaps" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (buttonCaps (:pointer :HIDBUTTONCAPS))
    (buttonCapsSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetSpecificButtonCapabilities
;   @abstract Retrieves the capabilities for all buttons in a specific type of report that meet the search criteria.
;   @discussion The HIDGetSpecificButtonCapabilities function retrieves capability data for buttons that meet a given search criteria, as opposed to the HIDGetButtonCapabilities function which returns the capability data for all buttons on the device.  Calling this routine specifying zero for usagePage, usage and collection is equivalent to calling the HIDGetButtonCapabilities function.
;   @param reportType Specifies the type of report for which to retrieve the button capabilities.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies a usage page identifier to use as a search criteria.  If this parameter is non-zero, then only buttons that specify this usage page will be retrieved.
;   @param collection Specifies a link collection identifier to use as a search criteria.  If this parameter is non-zero, then only buttons that are part of the specified link collection are retrieved.
;   @param usage Specifies a usage identifier to use as a search criteria.  If this parameter is non-zero, then only buttons that match the value specified are retrieved.
;   @param buttonCaps Points to a caller-allocated buffer that will contain, on return, an array of HIDButtonCapabilities structures.  The structures contain information for all buttons that meet the search criteria.
;   @param buttonCapsLength On input, specifies the length, in array elements, of the buffer provided in the buttonCaps parameter.  On output, this parameter is set to the actual number of elements that were returned by the function call, in the buffer provided in the buttonCaps parameter, if the routine completed without error.  The correct length necessary to retrieve the button capabilities can be found in the capability data returned for the device by the HIDGetCaps function.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetSpecificButtonCapabilities" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (buttonCaps (:pointer :HIDBUTTONCAPABILITIES))
    (buttonCapsSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetSpecificValueCaps
;   @abstract Retrieves the capabilities for all values in a specific type of report that meet the search criteria.
;   @discussion The HIDGetSpecificValueCaps function retrieves capability data for values that meet given search criteria, as opposed to the HIDGetValueCaps function, which returns the capability data for all values on the device.  Calling this routine with a value of zero for usagePage, usage and collection parameters is equivalent to calling the HIDGetValueCaps function.
;   @param reportType Specifies the type of report for which to retrieve the value capabilities.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport or kHIDFeatureReport.
;   @param usagePage Specifies a usage page identifier to use as a search criteria.  If this parameter is non-zero, then only values that specify this usage page will be retrieved.
;   @param collection Specifies a link collection identifier to use as a search criteria.  If this parameter is non-zero, then only values that are part of this link collection will be retrieved.
;   @param usage Specifies a usage identifier to use as a search criteria.  If this parameter is non-zero, then only values that specify this usage will be retrieved.
;   @param valueCaps Points to a caller-allocated buffer that will contain, on return, an array of HIDValueCaps structures that contain information for all values that meet the search criteria.
;   @param valueCapsSize Specifies the length on input, in array elements, of the buffer provided in the valueCaps parameter.  On output, this parameter is set to the actual number of elements that were returned by this function call, in the buffer provided in the valueCaps parameter, if the routine completed without error.  The correct length necessary to retrieve the value capabilities can be found in the capability data returned for the device from the HIDGetCaps function.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetSpecificValueCaps" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (valueCaps (:pointer :HIDVALUECAPS))
    (valueCapsSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetSpecificValueCapabilities
;   @abstract Retrieves the capabilities for all values in a specific type of report that meet the search criteria.
;   @discussion The HIDGetSpecificValueCapabilities function retrieves capability data for values that meet given search criteria, as opposed to the HIDGetValueCapabilities function, which returns the capability data for all values on the device.  Calling this routine with a value of zero for usagePage, usage and collection parameters is equivalent to calling the HIDGetValueCapabilities function.
;   @param reportType Specifies the type of report for which to retrieve the value capabilities.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport or kHIDFeatureReport.
;   @param usagePage Specifies a usage page identifier to use as a search criteria.  If this parameter is non-zero, then only values that specify this usage page will be retrieved.
;   @param collection Specifies a link collection identifier to use as a search criteria.  If this parameter is non-zero, then only values that are part of this link collection will be retrieved.
;   @param usage Specifies a usage identifier to use as a search criteria.  If this parameter is non-zero, then only values that specify this usage will be retrieved.
;   @param valueCaps Points to a caller-allocated buffer that will contain, on return, an array of HIDValueCapabilities structures that contain information for all values that meet the search criteria.
;   @param valueCapsSize Specifies the length on input, in array elements, of the buffer provided in the valueCaps parameter.  On output, this parameter is set to the actual number of elements that were returned by this function call, in the buffer provided in the valueCaps parameter, if the routine completed without error.  The correct length necessary to retrieve the value capabilities can be found in the capability data returned for the device from the HIDGetCaps function.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetSpecificValueCapabilities" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (valueCaps (:pointer :HIDVALUECAPABILITIES))
    (valueCapsSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetButtonsOnPage
;   @abstract Retrieves the button stat information for buttons on a specified usage page.
;   @param reportType Specifies the type of report, provided in the report parameter, from which to retrieve the buttons.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport or kHIDFeatureReport.
;   @param usagePage Specifies the usage page of the buttons for which to retrieve the current state.
;   @param collection Optionally specifies the link collection identifier used to retrieve only specific button states.  If this value is non-zero, only the buttons that are part of the given collection are returned.
;   @param usageList On return, points to a caller-allocated buffer that contains the usages of all the buttons that are perssed and belong to the usage page specified in the usagePage parameter.
;   @param usageListSize Is the size, in array elements, of the buffer provided in the usageList parameter.  On return, this parameter contains the number of button states that were set by this routine.  If the error kHIDBufferTooSmallErr was returned, this parameter contains the number of array elements required to hold all button data requested.  The maximum number of buttons that can ever be returned for a given type of report can be obtained by calling the HIDMaxUsageListLength function.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data
;   @param reportLength Specifies the size, in bytes, of the report data provided in the report parameter
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetButtonsOnPage" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usageList (:pointer :HIDUSAGE))
    (usageListSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDGetButtons
;   @abstract The HIDGetButtons function takes a report from a HID device and gets the current state of the buttons in that report.
;   @param reportType Specifies the type of report, provided in the report parameter, from which to retrieve the buttons.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport or kHIDFeatureReport
;   @param collection Optionally specifies the link collection identifier used to retrieve only specific button states.  If this value is non-zero, only the buttons that are part of the given collection are returned.
;   @param usageList On return, points to a caller-allocated buffer that contains the usages of all the buttons that are pressed.
;   @param usageListSize Is the size, in array elements, of the buffer provided in the usageList parameter.  On return, this parameter contains the number of button states that were set by this routine.  If the error kHIDBufferToSmallErr was returned, this parameter contains the number of array elements required to hold all button data requested.  The maximum number of buttons that can ever be returned for a given type of report can be obtained by calling the HIDMaxUsageListLength function.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data.
;   @param reportLength Specifies the length, in bytes, of the report data provided in the report parameter.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetButtons" 
   ((reportType :UInt32)
    (collection :UInt32)
    (usageList (:pointer :HIDUSAGEANDPAGE))
    (usageListSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )

(deftrap-inline "_HIDGetNextButtonInfo" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (usage :UInt32)
    (collection (:pointer :UInt32))
    (reportID (:pointer :UInt8))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )

(deftrap-inline "_HIDGetNextUsageValueInfo" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (usage :UInt32)
    (collection (:pointer :UInt32))
    (reportID (:pointer :UInt8))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )

(deftrap-inline "_HIDGetReportLength" 
   ((reportType :UInt32)
    (reportID :UInt8)
    (reportLength (:pointer :BYTECOUNT))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetUsageValue
;   @abstract The HIDGetUsageValue function returns a value from a device data report given a selected search criteria.
;   @discussion The HIDGetUsageValue function does not sign the value.  To have the sign bit automatically applied, use the HIDGetScaledUsageValue function instead.  For manually assigning the sign bit, the position of the sign bit can be found in the HIDValueCaps structure for this value.  Clients who wish to obtain all data for a usage that contains multiple data items for a single usage, corresponding to a HID byte array, must call the HIDGetUsageValueArray function instead.
;   @param reportType Specifies the type of report, provided in report, from which to retrieve the value.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies the usage page of the value to retrieve.
;   @param collection Optionally specifies the link collection identifier of the value to be retrieved.
;   @param usage Specifies the usage of the value to be retrieved.
;   @param usageValue Points to a variable, that on return from this routine holds the value retrieved from the device report.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data.
;   @param reportLength Specifies the size, in bytes, of the report data provided in the report parameter.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetUsageValue" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (usageValue (:pointer :SInt32))
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDGetUsageValueArray
;   @abstract The HIDGetUsageValueArray function returns a value from a device data report given a selected search criteria.
;   @discussion When the HIDGetUsageValueArray function retrieves the data, it fills in the buffer in little-endian order beginning with the least significant bit of the data for this usage.  The data is filled in without regard to byte alignment and is shifted such that the least significant bit is placed as the 1st bit of the given buffer.
;   @param reportType Specifies the type of report, provided in report, from which to retrieve the value.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies the usage page of the data to be retrieved.
;   @param collection Optionally specifies the link collection identifier of the data to be retrieved.
;   @param usage Specifies the usage identifier of the value to be retrieved.
;   @param usageValueBuffer Points to a caller-allocated buffer that contains, on output, the data from the device.  The correct length for this buffer can be found by multiplying the reportCount and bitSize fields of the HIDValueCaps structure for the value and rounding the resulting value up to the nearest byte.
;   @param usageValueBufferSize Specifies the size, in bytes, of the buffer in the usageValueBuffer parameter.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data.
;   @param reportLength Specifies the size, in bytes, of the report data provided in report.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetUsageValueArray" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (usageValueBuffer (:pointer :Byte))
    (usageValueBufferSize :UInt32)
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDGetValueCaps
;   @abstract The HIDGetValueCaps function retrieves the capabilities for all values for a specified top level collection.
;   @discussion The HIDGetValueCaps function retrieves the capability data for all values in a top level collection without regard for the usage, usage page or collection of the value.  To retrieve value capabilities for a specific usage, usage page or collection, use the HIDGetSpecificValueCaps function.
;   @param reportType Specifies the type of report for which to retrieve the value capabilities.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param valueCaps On return, points to a caller-allocated buffer that contains an array of HIDValueCaps structures containing information for all values in the top level collection.
;   @param valueCapsSize On input, specifies the size in array elements of the buffer provided in the valueCaps parameter.  On output, this parameter is set to the actual number of elements that were returned in the buffer provided in the valueCaps parameter, if the function completed without error.  The correct length necessary to retrieve the value capabilities can be found in the capability data returned for the device by the HIDGetCaps function.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetValueCaps" 
   ((reportType :UInt32)
    (valueCaps (:pointer :HIDVALUECAPS))
    (valueCapsSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )
; !
;   @function HIDGetValueCapabilities
;   @abstract The HIDGetValueCapabilities function retrieves the capabilities for all values for a specified top level collection.
;   @discussion The HIDGetValueCapabilities function retrieves the capability data for all values in a top level collection without regard for the usage, usage page or collection of the value.  To retrieve value capabilities for a specific usage, usage page or collection, use the HIDGetSpecificValueCapabilities function.
;   @param reportType Specifies the type of report for which to retrieve the value capabilities.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param valueCaps On return, points to a caller-allocated buffer that contains an array of HIDValueCapabilities structures containing information for all values in the top level collection.
;   @param valueCapsSize On input, specifies the size in array elements of the buffer provided in the valueCaps parameter.  On output, this parameter is set to the actual number of elements that were returned in the buffer provided in the valueCaps parameter, if the function completed without error.  The correct length necessary to retrieve the value capabilities can be found in the capability data returned for the device by the HIDGetCapabilities function.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDGetValueCapabilities" 
   ((reportType :UInt32)
    (valueCaps (:pointer :HIDVALUECAPABILITIES))
    (valueCapsSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
   )
   :OSStatus
() )

(deftrap-inline "_HIDInitReport" 
   ((reportType :UInt32)
    (reportID :UInt8)
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDMaxUsageListLength
;   @abstract The HIDMaxUsageListLength function returns the maximum number of buttons that can be returned from a given report type for the top level collection.
;   @param reportType Specifies the type of report for which to get a maximum usage count.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Optionally specifies the usage page identifier to use as a search criteria.  If this parameter is zero, the function returns the number of buttons for the entire top-level collection regardless of the actual value of the usage page.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDMaxUsageListLength" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (preparsedDataRef (:pointer :void))
   )
   :UInt32
() )
; !
;   @function HIDSetScaledUsageValue
;   @abstract The HIDSetScaledUsageValue function takes a signed physical (scaled) number and converts it to the logical, or device representation and inserts it in a given report.
;   @discussion The HIDSetScaledUsageValue function automatically handles the setting of the signed bit in the data to be sent to the device.
;   @param reportType Specifies the type of report.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies the usage page identifier of the value to be set in the report.
;   @param collection Optionally specifies the link collection identifier to distinguish between values that have the same usage page and usage identifiers.  If this parameter is zero, it will be ignored.
;   @param usage Specifies the usage identifier of the value to be set in the report.
;   @param usageValue Specifies the physical, or scaled, value to be set in the value for the given report.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data.
;   @param Specifies the length, in bytes of the report data specified in the report parameter.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDSetScaledUsageValue" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (usageValue :SInt32)
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDSetButtons
;   @abstract The HIDSetButtons function takes a report from a HID device and returns the current state of the buttons in that report.
;   @param reportType Specifies the type of repor.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies the usage page identifier of the value to be set in the report.
;   @param collection Optionally specifies the link collection identifier to distinguish between buttons.  If this parameter is zero, it is ignored.
;   @param usageList Points to a caller-allocated buffer that contains an array of button data to be set in the report in the report parameter.
;   @param usageListSize Specifies the size, in array elements, of the buffer provided in the usageList parameter.  If an error is returned by a call to this function, the usageListLength parameter contains the location in the array provided in the usageList parameter where the error was encountered.  All array entries encountered prior to the error location were successfully set in the report provided in the report parameter.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data.
;   @param reportLength Specifies the size, in bytes, of the report data provided in the report parameter.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDSetButtons" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usageList (:pointer :HIDUSAGE))
    (usageListSize (:pointer :UInt32))
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDSetUsageValue
;   @abstract The HIDSetUsageValue function sets a value in a give report.
;   @discussion The HIDSetUsageVlaue function does not automatically handle the sign bit.  Clients must either manually set the sign bit, at the position provided in the HIDValueCaps structure for this value, or call the HIDSetScaledUsageValue function.
;   @param reportType Specifies the type of report.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies the usage page identifier of the value to be set in the report.
;   @param collection Optionally specifies the link collection identifier to distinguish between values that have the same usage page and usage identifiers.  If this parameter is zero, it is ignored.
;   @param usage Specifies the usage identifier of the value to be set in the report.
;   @param usageValue Specifies the data that is to be set in the value for the given report.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data.
;   @param reportLength Specifies the size, in bytes, of the report data provided in the report parameter.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDSetUsageValue" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (usageValue :SInt32)
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDSetUsageValueArray
;   @abstract The HIDSetUsageValueArray function sets an array of values in a given report.
;   @discussion The HIDSetUsageValue function does not automatically handle the sign bit.  Clients must either manually set the sign bit, at the position provided in the HIDValueCaps structure for this value, or call the HIDSetScaledUsageValue function.
;   @param reportType Specifies the type of report.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies the usage page identifier of the value to be set in the report.
;   @param collection Optionally specifies the link collection identifier to distinguish between values that have the same usage page and usage identifiers.  If this parameter is zero, it is ignored.
;   @param usage Specifies the usage identifier of the value to be set in the report.
;   @param usageValueBuffer Points to a caller-allocated buffer that contains, on output, the data from the device.  The correct length for this buffer can be found by multiplying the reportCount and bitSize fields of the HIDValueCaps structure for this value and rounding the resulting value up to the nearest byte.
;   @param usageValueBufferLength Specifies the size, in bytes, of the buffer in the usageValueBuffer parameter.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data.
;   @param reportLength Specifies the size, in bytes, of the report data provided in the report parameter.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDSetUsageValueArray" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (usageValueBuffer (:pointer :Byte))
    (usageValueBufferLength :UInt32)
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDUsageListDifference
;   @abstract The HIDUsageListDifference function compares and provides the differences between two lists of buttons.
;   @param previousUsageList Points to the older button list to be used for comparison.
;   @param currentUsageList Points to the newer button list to be used for comparison.
;   @param breakUsageList On return, points to a caller-allocated buffer that contains the buttons set in the older list, specified in the previousUsageList parameter, but not set in the new list, specified in the currentUsageList parameter.
;   @param makeUsageList On return, points to a caller-allocated buffer that contains the buttons set in the new list, specified in the currentUsageList parameter, but not set in the old list, specified in the previousUsageList parameter.
;   @param usageListsLength Specifies the length, in array elements, of the buffers provided in the currentUsageList and previousUssageList parameters.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDUsageListDifference" 
   ((previousUsageList (:pointer :HIDUSAGE))
    (currentUsageList (:pointer :HIDUSAGE))
    (breakUsageList (:pointer :HIDUSAGE))
    (makeUsageList (:pointer :HIDUSAGE))
    (usageListsSize :UInt32)
   )
   :OSStatus
() )
; !
;   @function HIDSetButton
;   @abstract The HIDSetButton function takes a report from a HID device and sets the current state of the specified button in that report.
;   @param reportType Specifies the type of report.  This parameter must be one of the following: kHIDInputReport, kHIDOutputReport, or kHIDFeatureReport.
;   @param usagePage Specifies the usage page identifier of the value to be set in the report.
;   @param collection Optionally specifies the link collection identifier to distinguish between buttons.  If this parameter is zero, it is ignored.
;   @param usage Points to a caller-allocated buffer that contains the button data to be set in the report in the report parameter.
;   @param preparsedDataRef Preparsed data reference for the report that is retuned by the HIDOpenReportDescriptor function
;   @param report Points to the caller-allocated buffer that contains the device report data.
;   @param reportLength Specifies the size, in bytes, of the report data provided in the report parameter.
;   @result OSStatus Returns an error code if an error was encountered or noErr on success.
;  

(deftrap-inline "_HIDSetButton" 
   ((reportType :UInt32)
    (usagePage :UInt32)
    (collection :UInt32)
    (usage :UInt32)
    (preparsedDataRef (:pointer :void))
    (report :pointer)
    (reportLength :UInt32)
   )
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif


(provide-interface "IOHIDDescriptorParser")