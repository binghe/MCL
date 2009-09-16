(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSL.h"
; at Sunday July 2,2006 7:25:14 pm.
; 
;      File:       CommonPanels/NSL.h
;  
;      Contains:   Interface to API for using the NSL User Interface
;  
;      Version:    CommonPanels-70~11
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __NSL__
; #define __NSL__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __EVENTS__
#| #|
#include <HIToolboxEvents.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #pragma options align=mac68k

(def-mactype :NSLDialogOptionFlags (find-mactype ':UInt32))

(defconstant $kNSLDefaultNSLDlogOptions 0)      ;  use defaults for all the options 

(defconstant $kNSLNoURLTEField 1)               ;  don't show url text field for manual entry 

(defconstant $kNSLAddServiceTypes 2)            ;  add the service type if a user enters an incomplete URL 

(defconstant $kNSLClientHandlesRecents 4)       ;  Stops NSLStandardGetURL from adding the selection to the recent items folder 

(defrecord NSLDialogOptions
   (version :UInt16)
   (dialogOptionFlags :UInt32)                  ;  option flags for affecting the dialog's behavior 
   (windowTitle (:string 255))
   (actionButtonLabel (:string 255))            ;  label of the default button (or null string for default) 
   (cancelButtonLabel (:string 255))            ;  label of the cancel button (or null string for default) 
   (message (:string 255))                      ;  custom message prompt (or null string for default) 
)

;type name? (%define-record :NSLDialogOptions (find-record-descriptor ':NSLDialogOptions))

(def-mactype :NSLURLFilterProcPtr (find-mactype ':pointer)); (char * url , Str255 displayString)
;  you can provide for calls to NSLStandardGetURL

(def-mactype :NSLEventProcPtr (find-mactype ':pointer)); (EventRecord * newEvent , void * userContext)

(def-mactype :NSLURLFilterUPP (find-mactype '(:pointer :OpaqueNSLURLFilterProcPtr)))

(def-mactype :NSLEventUPP (find-mactype '(:pointer :OpaqueNSLEventProcPtr)))
; 
;  *  NewNSLURLFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNSLURLFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNSLURLFilterProcPtr)
() )
; 
;  *  NewNSLEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNSLEventUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNSLEventProcPtr)
() )
; 
;  *  DisposeNSLURLFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNSLURLFilterUPP" 
   ((userUPP (:pointer :OpaqueNSLURLFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeNSLEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNSLEventUPP" 
   ((userUPP (:pointer :OpaqueNSLEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeNSLURLFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNSLURLFilterUPP" 
   ((url (:pointer :char))
    (displayString (:pointer :STR255))
    (userUPP (:pointer :OpaqueNSLURLFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeNSLEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNSLEventUPP" 
   ((newEvent (:pointer :EventRecord))
    (userContext :pointer)
    (userUPP (:pointer :OpaqueNSLEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  <--- function returns OSStatus of the operation.  noErr will be returned if valid, kNSLUserCanceled will be returned if the user cancels 
;  ---> dialogOptions 
;  ---> eventProc 
;  ---> eventProcContextPtr 
;  ---> filterProc 
;  ---> serviceTypeList 
;  <--- userSelectedURL 
;  NSLDialogOptions* dialogOptions 
; 
;    dialogOptions is a user defined structure defining the look, feel and operation of NSLStandardGetURL dialog
;    default behavior can be achieved by passing in a pointer to a structure that has been filled out by a previous
;    call to NSLGetDefaultDialogOptions or by passing in NULL.
; 
;  NSLEventUPP eventProc 
; 
;    the eventProc is a callback NSLURLFilterUPP that will
;    get called with Events that the dialog doesn't handle.  If you pass in nil,
;    you won't get update events while the NSLStandardGetURL dialog is open.
; 
;  void* eventProcContextPtr 
;  you can provide a pointer to some contextual data that you want to have sent to your eventProc filter
;  NSLURLFilterProcPtr filterProc 
; 
;    the filter param is a callback NSLURLFilterUPP that
;    will get called (if not nil) for each url that is going to be displayed in
;    the dialog's result list.  A result of false will not include the url for the
;    user to select from.  You also have the option of handling the way the url looks
;    in the dialog listing by copying the preferred name into the displayString
;    parameter.  (If left alone, NSLStandardGetURL dialog will strip the service type
;    portion off the url).
; 
;  char* serviceTypeList 
; 
;    the serviceTypeList parameter is a null terminated string that will 
;    directly affect the contents of the services popup in the dialog.
;    The structure of this string is a set of tuples as follows:
;    Name of ServiceType as to be represented in the popup followed by
;    a comma delimted list of service descriptors (ie http,https) that will
;    used in the search of that type.  Each comma delimited tuple is delimited
;    by semi-colons.
; 
; 
;    For example:
;    If you want to search for services of type http (web), https (secure web),
;    and ftp, you could pass in the string "Web Servers,http,https;FTP Servers,ftp".
;    This would result in a popup list with two items ("Web Servers" and "FTP Servers")
;    and searches performed on them will provide results of type http and https for the
;    first, and ftp for the second.
; 
; 
;    Results list Icons:
;    NSLStandardGetURL provides icons in its listings for the following types:
;    "http", "https", "ftp", "afp", "lpr", "LaserWriter", "AFPServer"
;    any other types will get a generic icon.  However, you can provide icons
;    if you wish by including an '#ics8' resource id at the end of your comma
;    delimited list.  The dialog will then use that icon if found in its results
;    list.  This icon will be used for all types in a tuple.
;    For example:
;    The param "Web Servers,http,https;Telnet Servers,telnet;NFS Servers,nfs,129"
;    would result in lists of http and https services to be shown with their default
;    icons, telnet servers would be shown with the default misc. icon and nfs
;    servers would be shown with your icon at resource id 129.
; 
;  char** url 
; 
;    pass in the address of a char* and it will point to the resulting url.  If the user
;    cancels (the function returns false), the pointer will be set to nil.  If the function
;    returns true (user selected a url), then you must call NSLFreeURL on the pointer when
;    you are done with it.
; 
; 
;    Call this to have the user select a url based service from a dialog.
;    Function takes on input an optional filter proc, a serviceTypeList, and an address to a Ptr.
;    Function sets the value of the Ptr to a newly created c-style null terminated string
;    containing the user's choice of URL.
; 
; 
;  *  NSLStandardGetURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLStandardGetURL" 
   ((dialogOptions (:pointer :NSLDialogOptions));  can be NULL 
    (eventProc (:pointer :OpaqueNSLEventProcPtr));  can be NULL 
    (eventProcContextPtr :pointer)              ;  can be NULL 
    (filterProc (:pointer :OpaqueNSLURLFilterProcPtr));  can be NULL 
    (serviceTypeList (:pointer :char))
    (userSelectedURL (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NSLGetDefaultDialogOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLGetDefaultDialogOptions" 
   ((dialogOptions (:pointer :NSLDialogOptions))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  <--- function returns null (useful for setting variable at same time as freeing it 
;  ---> url is memory created by a call to NSLStandardGetURL 
; 
;  *  NSLFreeURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLFreeURL" 
   ((url (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :character)
() )
;  <--- function returns kNSLErrNullPtrError, file mgr errors, or resource mgr errors 
;  ---> folderSelectorType is one of the well-known folders defined in Folders.h 
;  ---> url is any valid url 
;  ---> userFriendlyName is used for the file name and the display name (in the UI) 
; 
;  *  NSLSaveURLAliasToFolder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in NSLPPCLib 1.1 and later
;  

(deftrap-inline "_NSLSaveURLAliasToFolder" 
   ((folderSelectorType :OSType)
    (url (:pointer :char))
    (userFriendlyName (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __NSL__ */


(provide-interface "NSL")