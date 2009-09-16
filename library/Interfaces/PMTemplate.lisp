(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMTemplate.h"
; at Sunday July 2,2006 7:31:14 pm.
; 
;      File:       PMTemplate.h
;  
;      Contains:   Mac OS X Printing Manager Job Template Interfaces.
;  
;      Version:    Technology: Mac OS X
;                  Release:    1.0
;  
;      Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PMTEMPLATE__
; #define __PMTEMPLATE__

(require-interface "ApplicationServices/ApplicationServices")

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "PrintCore/PMTicket")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  Constants
; 
; |* An enum to distinguish between different kinds of template entries. Each entry in a template 
;  has a specific type that allows us to determine what other fields and functions are available. 

(def-mactype :PMValueType (find-mactype ':SInt32))

(defconstant $kPMValueUndefined 0)              ;  Template Entry is unknown or undefined 

(defconstant $kPMValueBoolean 1)                ;  A CFBoolean of value true or false. 

(defconstant $kPMValueData 2)                   ;  A CFData, raw data converted to CFData. Has a default value, but no other constraints 

(defconstant $kPMValueString 3)                 ;  A CFString. Has a default value, but no other constraints 

(defconstant $kPMValueSInt32 4)                 ;  A CFNumber of long type. 

(defconstant $kPMValueSInt32Range 5)            ;  A pair of CFNumbers, SInt32s, defining a range. 

(defconstant $kPMValueUInt32 6)                 ;  A CFNumber of unsigned long type (which isn't actually defined) 

(defconstant $kPMValueUInt32Range 7)            ;  A pair of CFNumber, UInt32s, defining a range. 

(defconstant $kPMValueDouble 8)                 ;  A CFNumber of double type. 

(defconstant $kPMValueDoubleRange 9)            ;  A pair of CFNumbers, doubles, defining a range of values. 

(defconstant $kPMValuePMRect 10)                ;  A CFArray of 4 CFNumbers, all doubles. 

(defconstant $kPMValueDate 11)                  ;  A CFDate, holding date and time. 

(defconstant $kPMValueArray 12)                 ;  A CFArray, holding an array of values. No way to constrain these. 

(defconstant $kPMValueDict 13)                  ;  A CFDictionary, which has a default, but no constraints. 

(defconstant $kPMValueTicket 14)                ;  A PMTicket will require each key/value be identical - only works for list constraints. 


(def-mactype :PMConstraintType (find-mactype ':SInt32))

(defconstant $kPMConstraintUndefined 0)         ;  Undefined, no constraint checking required. 

(defconstant $kPMConstraintRange 1)             ;  Range has a CFArray of two values, both CFTypeRefs 

(defconstant $kPMConstraintList 2)              ;  List has an array CFTypeRefs, listing possible values. DefaultValues are CFNumberRef (zero-based index into the list) 

(defconstant $kPMConstraintPrivate 3)           ;  Private constraint, not checked by the system. 

;  Types 
;  A couple of keys are defined as special cases for the template code, only because it's 
;  a flat structure and the Job ticket is possibly a hierarchy of tickets. We need to be 
;  able to fetch the PaperInfo template information, but the Job Ticket has a separate 
;  ticket, so there is no key defined for fetching PaperInfo ticket from the Job Ticket. 
(defconstant $kPMTemplatePrelude "com.apple.print.TemplateSpecific.")
; #define kPMTemplatePrelude       "com.apple.print.TemplateSpecific."
; #define kPMPaperInfoListStr      kPMTemplatePrelude "PMTemplatePaperInfoTicket"
; #define kPMPaperInfoList         CFSTR( kPMPaperInfoListStr )                      /* Will fetch the default value and constraint list for valid papers. */
; #define kPMCustomPageWidthStr      kPMTemplatePrelude "CustomPaperWidth"
; #define kPMCustomPageWidthKey         CFSTR( kPMCustomPageWidthStr )                      /* Will fetch the max and min range constraint for custom page width. */
; #define kPMCustomPageHeightStr      kPMTemplatePrelude "CustomPaperHeight"
; #define kPMCustomPageHeightKey         CFSTR( kPMCustomPageHeightStr )                      /* Will fetch the max and min range constraint for custom page height. */
; #define kPMCustomPageMarginsStr      	    kPMTemplatePrelude "PMCustomPageMargins"
; #define kPMCustomPageMarginsKey        	    CFSTR( kPMCustomPageMarginsStr )            /* Will fetch the margin data for a custom page. */
;  kPMDefaultReverseOutputOrderKey specifies whether the default page stacking order for the Tioga based printer is reverse.
; 	If true, the default output stacking order without host intervention is N, N-1, ... 2, 1. 
; 	If false, the default output stacking order without host intervention is 1, 2, ... , N-1 , N
; 	If this key is not present the default value is true since the typical 
; 	    Tioga printer module based raster printer stacks pages in reverse order.
; 
; #define kPMDefaultReverseOutputOrderStr		kPMTemplatePrelude "PMDefaultReverseOutputOrder"
; #define kPMDefaultReverseOutputOrderKey        	CFSTR( kPMDefaultReverseOutputOrderStr ) 
;  Function Prototypes 
;  The PMTemplateRef is defined in PMTicket.h to avoid circular references, and  
;  included here just in case you do a search and can't find it. (you're welcome) 
;  It is supposed to be commented out because this header includes PMTicket.h 
;  Functions to create or delete a template 

(deftrap-inline "_PMTemplateCreate" 
   ((newTemplate (:pointer :PMTEMPLATEREF))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateDelete" 
   ((oldTemplate (:pointer :PMTEMPLATEREF))
   )
   :OSStatus
() )
;  Functions to send to and from XML. Also a function to tell us if the template is locked and 
;  can't be modified. 
; !
;  * @function	PMTemplateWriteXML
;  * @abstract	Write an XML description of the specified template to a file
;  *		stream.
;  

(deftrap-inline "_PMTemplateWriteXML" 
   ((srcTemplate (:pointer :OpaquePMTemplateRef))
    (file (:pointer :file))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateCreateXML" 
   ((srcTemplate (:pointer :OpaquePMTemplateRef))
    (xmlData (:pointer :CFDataRef))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateLoadFromXML" 
   ((srcData (:pointer :__CFData))
    (destTemplate (:pointer :PMTEMPLATEREF))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateIsLocked" 
   ((srcTemplate (:pointer :OpaquePMTemplateRef))
    (locked (:pointer :Boolean))
   )
   :OSStatus
() )
;  Functions to add entries in a template. Each entry describes a value type and constraint 
;  type as well as default and constraint values for a specific key. This key must match the 
;  key we wish to validate in a PMTicket. 

(deftrap-inline "_PMTemplateMakeFullEntry" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (valueType :SInt32)
    (constraintType :SInt32)
    (defaultValue (:pointer :void))
    (constraintValue (:pointer :void))
   )
   :OSStatus
() )
;  This function allows a caller to create the template entry in a series of calls, first to 
;  establish what type of entry it is and then later to set default and constraint values. This 
;  is especially useful for direct (non-cf) access to create template entries. There are various 
;  specialized functions for adding the default and cosntraint values with standard "C" types. 

(deftrap-inline "_PMTemplateMakeEntry" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (valueType :SInt32)
    (constraintType :SInt32)
   )
   :OSStatus
() )
;  The following functions update an already created entry. 

(deftrap-inline "_PMTemplateSetCFDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :void))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetSInt32DefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue :SInt32)
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetSInt32RangeDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min :SInt32)
    (max :SInt32)
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetBooleanDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue :Boolean)
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetDoubleDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue :double-float)
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetDoubleRangeDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min :double-float)
    (max :double-float)
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetCFDataDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :__CFData))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetPMRectDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :PMRect))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetPMTicketDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :OpaquePMTicketRef))
   )
   :OSStatus
() )
;  Functions to allow various constraints to be set up. 

(deftrap-inline "_PMTemplateSetCFArrayConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (constraintValue (:pointer :__CFArray))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetCFRangeConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min (:pointer :void))
    (max (:pointer :void))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetSInt32RangeConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min :SInt32)
    (max :SInt32)
   )
   :OSStatus
() )
;  Note - if the default value is a range, then the constraint should be a pair 
;  of ranges. 

(deftrap-inline "_PMTemplateSetSInt32RangesConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (minForMin :SInt32)
    (maxForMin :SInt32)
    (minForMax :SInt32)
    (maxForMax :SInt32)
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetDoubleRangeConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min :double-float)
    (max :double-float)
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateSetDoubleRangesConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (minForMin :double-float)
    (maxForMin :double-float)
    (minForMax :double-float)
    (maxForMax :double-float)
   )
   :OSStatus
() )
;  A List constraint could be a simple list of SInt32s. 

(deftrap-inline "_PMTemplateSetSInt32ListConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (listSize :signed-long)
    (sint32List (:pointer :SInt32))
   )
   :OSStatus
() )
;  Or a list of doubles. 

(deftrap-inline "_PMTemplateSetDoubleListConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (listSize :signed-long)
    (doubleList (:pointer :double))
   )
   :OSStatus
() )
;  A list of rectangles. 

(deftrap-inline "_PMTemplateSetPMRectListConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (listSize :signed-long)
    (rectList (:pointer :PMRect))
   )
   :OSStatus
() )
;  Or a ticket list. 

(deftrap-inline "_PMTemplateSetPMTicketListConstraint" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (listTicket (:pointer :OpaquePMTicketRef))
   )
   :OSStatus
() )
;  Boolean constraints don't need to be set - the constraint type is enough. 
;  Accessors for reaching specific template entry info based on the key passed in. 

(deftrap-inline "_PMTemplateGetValueType" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (valueType (:pointer :PMVALUETYPE))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetConstraintType" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (constraintType (:pointer :PMCONSTRAINTTYPE))
   )
   :OSStatus
() )
;  Fetch the various types of default values. 

(deftrap-inline "_PMTemplateGetCFDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :CFTypeRef))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetSInt32DefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :SInt32))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetSInt32RangeDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min (:pointer :SInt32))
    (max (:pointer :SInt32))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetBooleanDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :Boolean))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetDoubleDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :double))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetDoubleRangeDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min (:pointer :double))
    (max (:pointer :double))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetCFDataDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :CFDataRef))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetPMRectDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :PMRect))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetPMTicketDefaultValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (defaultValue (:pointer :PMTICKETREF))
   )
   :OSStatus
() )
;  Fetch the various flavors of constraint values. 

(deftrap-inline "_PMTemplateGetCFArrayConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (constraintValue (:pointer :CFArrayRef))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetCFRangeConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min (:pointer :CFTypeRef))
    (max (:pointer :CFTypeRef))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetSInt32RangeConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min (:pointer :SInt32))
    (max (:pointer :SInt32))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetSInt32RangesConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (minForMin (:pointer :SInt32))
    (maxForMin (:pointer :SInt32))
    (minForMax (:pointer :SInt32))
    (maxForMax (:pointer :SInt32))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetDoubleRangeConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (min (:pointer :double))
    (max (:pointer :double))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetDoubleRangesConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (minForMin (:pointer :double))
    (maxForMin (:pointer :double))
    (minForMax (:pointer :double))
    (maxForMax (:pointer :double))
   )
   :OSStatus
() )
;  The following functions need to be called twice, first to determine the length of 
;  the list and a second time, after allocating space, to actually fetch the list.

(deftrap-inline "_PMTemplateGetSInt32ListConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (listSize (:pointer :int))
    (sint32List (:pointer :SInt32))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetDoubleListConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (listSize (:pointer :int))
    (doubleList (:pointer :double))
   )
   :OSStatus
() )

(deftrap-inline "_PMTemplateGetPMRectListConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (listSize (:pointer :int))
    (rectList (:pointer :PMRect))
   )
   :OSStatus
() )
;  The Ticket APIs support a "List Ticket" that can hold numerous other tickets, so there is 
;  no need to allocate space for an array in this case. 
;  Always returns length and list at one time. 

(deftrap-inline "_PMTemplateGetListTicketConstraintValue" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (listTicket (:pointer :PMTICKETREF))
   )
   :OSStatus
() )
;  Remove an entry from our template. 

(deftrap-inline "_PMTemplateRemoveEntry" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
   )
   :OSStatus
() )
;  Validate a ticket item - passing in the key and the item data. 

(deftrap-inline "_PMTemplateValidateItem" 
   ((pmTemplate (:pointer :OpaquePMTemplateRef))
    (key (:pointer :__CFString))
    (item (:pointer :void))
    (validationResults (:pointer :Boolean))
   )
   :OSStatus
() )
;  Move a set of template entries from one template to another. Any entry in the destination 
;  template will be overwritten by an entry with the same key in the source template 

(deftrap-inline "_PMTemplateMergeTemplates" 
   ((sourceTemplate (:pointer :OpaquePMTemplateRef))
    (destTemplate (:pointer :OpaquePMTemplateRef))
   )
   :OSStatus
() )
;  NOTES:
;     
;     A few comments about some special template entry types:
;     
;     Rectangles - We assume a PMRect is four doubles. To verify a Rectangle, we allow the caller to 
;         define a list of rectangles, of which one must match exactly, or, planned for the future, a
;         range constraint that defines the min and max for horizontal and vertical, as well as the 
;         maximum width and height. For now, only a list of rectangles can be used to validate a rect.
;         
;     Tickets - To facilitate validating a PaperInfo ticket, we provide a mechanism to construct a 
;         list constraint for a ticket. A given ticket may then be validated by checking each key/value
;         pair to confirm that it holds exactly the same value as a ticket in the list. There won't be
;         any range checking for values within the ticket being validated, only a comparison with the
;         fixed values in the ticket list.
;     
;     For other tickets, such as Print Settings, or Page Format, we call the validate functions to
;         confirm that each entry complies with the proper constraint in the template. This allows
;         for range constraints to be built for some entries, and list constraints for other entries.
; 
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMTEMPLATE__ */


(provide-interface "PMTemplate")