(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFPlugInCOM.h"
; at Sunday July 2,2006 7:26:50 pm.
; 	CFPlugInCOM.h
; 	Copyright (c) 1999-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFPLUGINCOM__)
(defconstant $__COREFOUNDATION_CFPLUGINCOM__ 1)
; #define __COREFOUNDATION_CFPLUGINCOM__ 1

(require-interface "CoreFoundation/CFPlugIn")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
;  ================= IUnknown definition (C struct) ================= 
;  All interface structs must have an IUnknownStruct at the beginning. 
;  The _reserved field is part of the Microsoft COM binary standard on Macintosh. 
;  You can declare new C struct interfaces by defining a new struct that includes "IUNKNOWN_C_GUTS;" before the first field of the struct. 

(def-mactype :HRESULT (find-mactype ':SInt32))

(def-mactype :ULONG (find-mactype ':UInt32))

(def-mactype :LPVOID (find-mactype '(:pointer :void)))

(%define-record :REFIID (find-record-descriptor ':CFUUIDBytes))
; #define SUCCEEDED(Status) ((HRESULT)(Status) >= 0)
; #define FAILED(Status) ((HRESULT)(Status)<0)
;  Macros for more detailed HRESULT analysis 
; #define IS_ERROR(Status) ((unsigned long)(Status) >> 31 == SEVERITY_ERROR)
; #define HRESULT_CODE(hr) ((hr) & 0xFFFF)
; #define HRESULT_FACILITY(hr) (((hr) >> 16) & 0x1fff)
; #define HRESULT_SEVERITY(hr) (((hr) >> 31) & 0x1)
(defconstant $SEVERITY_SUCCESS 0)
; #define SEVERITY_SUCCESS 0
(defconstant $SEVERITY_ERROR 1)
; #define SEVERITY_ERROR 1
;  Creating an HRESULT from its component pieces 
; #define MAKE_HRESULT(sev,fac,code) ((HRESULT) (((unsigned long)(sev)<<31) | ((unsigned long)(fac)<<16) | ((unsigned long)(code))) )
;  Pre-defined success HRESULTS 
(defconstant $S_OK 0)
; #define S_OK ((HRESULT)0x00000000L)
(defconstant $S_FALSE 1)
; #define S_FALSE ((HRESULT)0x00000001L)
;  Common error HRESULTS 
(defconstant $E_UNEXPECTED 2147549183)
; #define E_UNEXPECTED ((HRESULT)0x8000FFFFL)
(defconstant $E_NOTIMPL 2147483649)
; #define E_NOTIMPL ((HRESULT)0x80000001L)
(defconstant $E_OUTOFMEMORY 2147483650)
; #define E_OUTOFMEMORY ((HRESULT)0x80000002L)
(defconstant $E_INVALIDARG 2147483651)
; #define E_INVALIDARG ((HRESULT)0x80000003L)
(defconstant $E_NOINTERFACE 2147483652)
; #define E_NOINTERFACE ((HRESULT)0x80000004L)
(defconstant $E_POINTER 2147483653)
; #define E_POINTER ((HRESULT)0x80000005L)
(defconstant $E_HANDLE 2147483654)
; #define E_HANDLE ((HRESULT)0x80000006L)
(defconstant $E_ABORT 2147483655)
; #define E_ABORT ((HRESULT)0x80000007L)
(defconstant $E_FAIL 2147483656)
; #define E_FAIL ((HRESULT)0x80000008L)
(defconstant $E_ACCESSDENIED 2147483657)
; #define E_ACCESSDENIED ((HRESULT)0x80000009L)
;  This macro should be used when defining all interface functions (as it is for the IUnknown functions below). 
; #define STDMETHODCALLTYPE
;  The __RPC_FAR macro is for COM source compatibility only. This macro is used a lot in COM interface definitions.  If your CFPlugIn interfaces need to be COM interfaces as well, you can use this macro to get better source compatibility.  It is not used in the IUnknown definition below, because when doing COM, you will be using the Microsoft supplied IUnknown interface anyway. 
; #define __RPC_FAR
;  The IUnknown interface 
; #define IUnknownUUID CFUUIDGetConstantUUIDWithBytes(NULL, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46)
; #define IUNKNOWN_C_GUTS     void *_reserved;     HRESULT (STDMETHODCALLTYPE *QueryInterface)(void *thisPointer, REFIID iid, LPVOID *ppv);     ULONG (STDMETHODCALLTYPE *AddRef)(void *thisPointer);     ULONG (STDMETHODCALLTYPE *Release)(void *thisPointer)
(defrecord IUnknownVTbl
#|
   (NIL :iunknown_c_guts)|#
)
;  End of extern "C" stuff 

; #if defined(__cplusplus)
#|
}
#endif
|#
;  C++ specific stuff 

; #if defined(__cplusplus)
#|




class IUnknown
#ifdefined(__MWERKS__) && !defined(__MACH__)
 : __comobject
#endif{
    public:
    virtual HRESULT STDMETHODCALLTYPE QueryInterface(REFIID iid, LPVOID *ppv) = 0;
    virtual ULONG STDMETHODCALLTYPE AddRef(void) = 0;
    virtual ULONG STDMETHODCALLTYPE Release(void) = 0;
};

#endif
|#

; #endif /* ! __COREFOUNDATION_CFPLUGINCOM__ */


(provide-interface "CFPlugInCOM")