(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PPDLib.h"
; at Sunday July 2,2006 7:31:18 pm.
; 
;      File Name:  PPDLib.h
; 
;      Contains:   PPDLib Interfaces
;  
;      Version:    Technology: Mac OS X
;                  Release:    1.0
;  
;      Copyright:  © 2001-2002 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PPDLIB__
; #define __PPDLIB__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
#endif
|#
 |#
; #ifndef __PMTICKET__
#| #|
#include <PrintCorePMTicket.h>
#endif
|#
 |#
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=mac68k
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(push, 2)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack(2)
 |#

; #endif

; ** Constants **
(defconstant $kDoManual 4051)
; #define		kDoManual		4051

(defconstant $ppdErrForbidden -2)
(defconstant $ppdErrNotFound -1)
; 	The following constant, 'kPPDInvalidIndex' is returned from ppdGetMainIndex()
; 	and ppdGetOptionIndex() when a PPD string has no index. This means
; 	that the string does not appear in the PPD.
; 
(defconstant $kPPDInvalidIndex 0)
; #define kPPDInvalidIndex	0
; ** Variable Types **
; 	Index types.
;  *	 Each option keyword and each main keyword is given an index value when
;  *	 it is recognized. Some have fixed values, as defined in resources.
;  *	 Index values are always >=1. 0 indicates no index (or not found).
;  *	 The different index types are because the strings are stored in different tables.
;  

(def-mactype :Mindex (find-mactype ':SInt16))
;  main keyword index 

(def-mactype :Oindex (find-mactype ':SInt16))
;  option keyword index 

(def-mactype :Tindex (find-mactype ':SInt16))
;  translation string index 

(def-mactype :Pindex (find-mactype ':SInt16))
;  invocation string (Postscript) index 
; 	UI constraint structure 
(defrecord UIConstraint
   (mainKeyIndex :SInt16)
   (optionKeyIndex :SInt16)
   (invalMainKeyIndex :SInt16)
   (invalOptionKeyIndex :SInt16)
)

(def-mactype :UIConstraintP (find-mactype '(:POINTER :UIConstraint)))
(defrecord UIConstraintList
   (numConstraints :SInt16)
   (constraint (:array :UICONSTRAINT 1))
)

(def-mactype :UIConstraintListP (find-mactype '(:POINTER :UIConstraintList)))

(def-mactype :UIConstraintListH (find-mactype '(:POINTER (:POINTER :UIConstraintList))))
(defrecord PPDParseErr
   (msg (:string 255))
                                                ;  The error that occurred.
   (file (:string 255))
                                                ;  The file containing the error.
   (line :signed-long)
                                                ;  The line containing the error.
)

(def-mactype :PPDContext (find-mactype '(:pointer :PPDContextViel)))
(defrecord xUIHeader
                                                ;  The primary structure for most UI keys 
; #define kUIHeaderVersion (1)
   (version :signed-long)
                                                ;  in/out 
   (mainKeyIndex :SInt16)
                                                ;  out: main key 
   (mainKeyTranslation :SInt16)
                                                ;  out: translation for group 
   (groupKeyIndex :SInt16)
                                                ;  out: group identifier, if grouped 
   (queryInvocation :SInt16)
                                                ;  out: Query invocation code 
   (defaultOption :SInt16)
                                                ;  out: OptionKeyIndex of default option 
   (pickConstraint :SInt16)
                                                ;  out: OptionKeyIndex: PickOne, PickMany, Boolean 
   (numOptions :SInt16)
                                                ;  out: number of options 
)

(def-mactype :xUIHeaderP (find-mactype '(:POINTER :xUIHeader)))
(defrecord InvocationLocator
   (order :signed-long)
   (orderSection :SInt16)
                                                ;  OptionKeyIndex: ExitServer, Prolog, DocumentSetup, PageSetup, AnySetup 
   (invocationType :SInt16)
                                                ;  0:Pindex, -1:Oindex, >0:fileindex 
   (invocationLoc :signed-long)
                                                ;  index value or file offset 
   (invocationSize :signed-long)
                                                ;  number of bytes in invocation string 
)

;type name? (%define-record :InvocationLocator (find-record-descriptor ':InvocationLocator))
(defrecord xUIOption
                                                ;  Structure of one option of a UI 
; #define kUIOptionVersion (1)
   (version :signed-long)
                                                ;  in/out 
   (optionKeyIndex :SInt16)
                                                ;  out: fully qualified option 
   (optionTranslation :SInt16)
                                                ;  out: translation for option 
   (forbidden :Boolean)
                                                ;  out: Constraint handling 
   (chosen :Boolean)
                                                ;  out: true if option is chosen 
   (invocation :InvocationLocator)
                                                ;  out: identifies invocation code 
)

(def-mactype :xUIOptionP (find-mactype '(:POINTER :xUIOption)))

(def-mactype :recordOptionPairProc (find-mactype ':pointer)); (PPDContext ppdContext , Mindex mainKey , Oindex optionKey , long refCon)
(defrecord PPDFileSpec
   (fs :FSSpec)
   (refNum :SInt16)
   (lastModDate :signed-long)
   (volumeName (:string 63))
                                                ;  Poor Man's alias (used with System 6) 
   (alias (:Handle :AliasRecord))
)

;type name? (%define-record :PPDFileSpec (find-record-descriptor ':PPDFileSpec))
(defrecord StrList
   (numStrings :SInt16)
   (str (:array :UInt8 1))
                                                ;  start of first string in the list 
)

(def-mactype :StrListPtr (find-mactype '(:POINTER :StrList)))

(def-mactype :StrListHdl (find-mactype '(:POINTER (:POINTER :StrList))))
(defrecord PPDPrinterDesc
   (product (:pointer :UInt8))
   (version (:pointer :UInt8))
   (revision (:pointer :UInt8))
   (matchModel :Boolean)
)

;type name? (%define-record :PPDPrinterDesc (find-record-descriptor ':PPDPrinterDesc))
(defrecord PPDMatch
   (count :UInt16)
   (file (:array :FSSpec 1))
#|
 confused about , * PPDMatchPtr #\, ** PPDMatchHandle
|#
)
; 	The invocation for the *ImageableArea keyword is returned as an LAxis
; 	structure rather than as the text from the PPD. Similarly, the invocation
; 	for *PaperDimension is returned as a LPaper structure.
; 
(defrecord LAxis
   (llx :signed-long)
   (lly :signed-long)
   (urx :signed-long)
   (ury :signed-long)
)
(defrecord LPaper
   (width :signed-long)
   (height :signed-long)
)
; 	'PPDGetGenericPPDNameProc' is a function pointer suitable to call
; 	ppdGetGenericPPDName() through.
; 

(def-mactype :PPDGetGenericPPDNameProc (find-mactype ':pointer)); (StringPtr genericPPDName)

(def-mactype :InfoButtonProcPtr (find-mactype ':pointer)); (void * infoRefConP)

(def-mactype :WebSearchDlgFilter (find-mactype ':pointer)); (EventRecord * event , void * refcon)

(def-mactype :WebSearchProgressProc (find-mactype ':pointer)); (ConstStr255Param status , int percentDone , void * refcon)
; 	A PPDEventFilter function pointer can be passed to ppdNavSelectFile() so that the caller
; 	can receive update, idle, and other useful events while the Navigation Choose file is
; 	being displayed.
; 

(def-mactype :PPDEventFilter (find-mactype ':pointer)); (EventRecord * event , void * filterData)
; ** Prototypes **

; #if PRAGMA_IMPORT_SUPPORTED
#| ; #pragma import on
 |#

; #endif


(deftrap-inline "_ppdParseFile" 
   ((ppdFileSpec (:pointer :FSSpec))
    (compiledRef :SInt16)
    (compiledResFRef :SInt16)
    (errInfoP (:pointer :PPDPARSEERR))
   )
   :SInt16
() )
; 	Parse a PPD file, and all its includes.
; 	FSSpecPtr will be closed upon exit.
; 	The PPD is parsed into the open file with the file reference 'compiledRef'.
; 	If compiledResFRef is not -1, the resource fork of the ppd file is copied into it.
; 	If 'errInfoP' is not NULL, then any error information is returned in
; 	*'errInfoP'.
; 

(deftrap-inline "_ppdParseHandle" 
   ((ppdHandle :Handle)
    (compiledRef :SInt16)
    (compiledResFRef :SInt16)
    (errInfoP (:pointer :PPDPARSEERR))
   )
   :SInt16
() )
; 	Parse a PPD file, and all its includes.
; 	Parse from a resource Handle.  We will Release the handle when we are through.
; 	The PPD is parsed into the open file with the file reference 'compiledRef'.
; 	If compiledResFRef is not -1, the resource fork of the ppd file is copied into it.
; 	If 'errInfoP' is not NULL, then any error information is returned in
; 	*'errInfoP'.
; 
;  removed ppdOpen macro

(deftrap-inline "_ppdOpenContext" 
   ((compiledPPDRef :SInt16)
    (ppdContext (:pointer :PPDCONTEXT))
   )
   :SInt16
() )
; 	Prepare to reference the compiled PPD information in the
; 	open file with reference 'compiledPPDRef'. If this function
; 	doesn't return an error, then *'ppdContext' is filled in
; 	with a value that can be used in other ppd calls.
; 

(deftrap-inline "_ppdCloseContext" 
   ((ppdContext (:pointer :PPDContextViel))
   )
   :void
() )
; 	Free up the memory used to access the PPD file
; 	referenced by 'ppdContext' (returned from ppdOpen())
; 	After this call, 'ppdContext' is no longer valid.
; 

(deftrap-inline "_PPDAddFeatureEntries" 
   ((jobTicket (:pointer :OpaquePMTicketRef))
    (psContextDictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; 
;  Obsolete. Returns kPMNotImplemented.
; 

(deftrap-inline "_PPDAddFeatureEntriesFromPPDContext" 
   ((jobTicket (:pointer :OpaquePMTicketRef))
    (ppdContext (:pointer :PPDContextViel))
    (psContextDictRef (:pointer :__CFDictionary))
   )
   :SInt32
() )
; 
;     Obsolete. Returns kPMNotImplemented.
; 

(deftrap-inline "_ppdGetCompiledPPDData" 
   ((printerInfoTicket (:pointer :OpaquePMTicketRef))
    (ppdData (:pointer :CFDataRef))
   )
   :SInt32
() )
; 
; From the printerInfoTicket passed in, get the parsed PPD data. Upon return
; ppdData contains a reference to the PPD data.
; 
; BGMARK

(deftrap-inline "_ppdCreateInstallableOptionsData" 
   ((ppdSpec (:pointer :FSSpec))
    (data (:pointer :char))
    (optionKeyWords (:pointer :__CFArray))
   )
   :SInt32
() )

(deftrap-inline "_ppdOpenCompiledPPDFromTicket" 
   ((printerInfoTicket (:pointer :OpaquePMTicketRef))
    (ppdContextP (:pointer :PPDCONTEXT))
    (tempFSSpecP (:pointer :FSSpec))
   )
   :SInt32
() )
; 
; From the printerInfoTicket passed in, create a temp file containing the parsed PPD data and open that
; file, returning in *ppdContextP the PPDContext corresponding to the open, parsed PPD file. Upon return
; *tempFSSpecP contains the FSSpec of the temp file which needs to be passed in to ppdCloseCompiledPPDFromTicket
; in order to delete that temp file.
; 

(deftrap-inline "_ppdCloseCompiledPPDFromTicket" 
   ((ppdContext (:pointer :PPDContextViel))
    (tempPPDFileSpecP (:pointer :FSSpec))
   )
   :SInt32
() )
; 
; Call ppdClose for the ppdContext and delete the file corresponding to *tempPPDFileSpecP.
; 

(deftrap-inline "_ppdGetMainIndex" 
   ((ppdContext (:pointer :PPDContextViel))
    (keyword (:pointer :UInt8))
   )
   :SInt16
() )
; 	Given Pascal string reprentation of a PPD main keyword, 'keyword',
; 	this routine returns a main key index (Mindex) that can be passed to other PPD
; 	routines. A Mindex is an integer representation of a main keyword.
; 	The Mindex for a given keyword is not constant across PPDs; in other words,
; 	the Mindex to keyword mapping is not defined across compiled PPDs.
; 

(deftrap-inline "_ppdGetOptionIndex" 
   ((ppdContext (:pointer :PPDContextViel))
    (keyword (:pointer :UInt8))
   )
   :SInt16
() )
; 	Given a Pascal string reprentation of a PPD option keyword, 'keyword'
; 	this routine returns an option key index (Oindex) that can be passed to other PPD
; 	routines. An Oindex is an integer representation of an option keyword.
; 	The Oindex for a given keyword is not constant across PPDs; in other words,
; 	the Oindex to keyword mapping is not defined across compiled PPDs.
; 

(deftrap-inline "_ppdGetUIKeyType" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey :SInt16)
   )
   :SInt16
() )
; 	Once a Mindex has been found for a main keyword, the existence of the keyword
; 	in a compiled PPD can be checked with ppdGetUIkeyType (). If the keyword exists,
; 	ppdGetUIkeyType() will also indicate whether the keyword is a UI type keyword or not.
; 	UI keywords in the PPD file have the form:
; 		mainkey optionkey: "some PS code"
; 	If the keyword does not exist then 0 is returned. If the keyword exists and
; 	is a UI keyword, then 1 is returned. If the keyword exists but is not a UI
; 	key, then -1 is returned.
; 

(deftrap-inline "_ppdGetUIHeader" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey :SInt16)
    (p (:pointer :XUIHEADER))
   )
   :Boolean
() )
; 	Once a Mindex for a UI keyword has been found, ppdGetUIHeader() can be used
; 	to get information about the UI main keyword. The structure pointed to by the
; 	UIHeaderP parameter will be filled in with information about the main keywords
; 	group, its query code, its default option key, and the number of options.
; 

(deftrap-inline "_ppdGetUIOption" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey :SInt16)
    (optionkey :SInt16)
    (p (:pointer :XUIOPTION))
   )
   :Boolean
() )
; 	Given a Mindex and Oindex pair, a caller can use the function ppdGetUIOption()
; 	to get information about the pair. ppdGetUIOption() provides information about
; 	a main keyword, option keyword pair¹s translation string, constraints, and
; 	any invocation code.
; 

(deftrap-inline "_ppdCountUIHeaders" 
   ((ppdContext (:pointer :PPDContextViel))
   )
   :SInt16
() )
; 	Used with ppdGetIndUIHeader(), ppdCountUIHeaders () allows a caller to
; 	enumerate the list of UI main keywords in a compiled PPD.
; 

(deftrap-inline "_ppdGetIndUIHeader" 
   ((ppdContext (:pointer :PPDContextViel))
    (index :SInt16)
    (p (:pointer :XUIHEADER))
   )
   :Boolean
() )
; 	Once the number of UI headers has been found using  ppdCountUIHeaders (),
; 	the caller uses ppdGetIndUIHeader() to enumerate the UI main keywords.
; 

(deftrap-inline "_ppdCountUIOptions" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey :SInt16)
   )
   :SInt16
() )
; 	Used with the function ppdGetIndUIOption(), ppdCountUIOptions() can be
; 	used to enumerate the option keywords associated with a UI main keyword.
; 	ppdCountUIOptions() returns the number of option keywords associated with
; 	a UI main keyword.
; 

(deftrap-inline "_ppdGetIndUIOption" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainKey :SInt16)
    (index :SInt16)
    (p (:pointer :XUIOPTION))
   )
   :Boolean
() )
; 	After the caller uses ppdCountUIOptions() to find the number of option
; 	keywords for a given main keyword, ppdGetIndUIOption() can be used to
; 	enumerate the options.
; 

(deftrap-inline "_ppdSetSelection" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainKey :SInt16)
    (optionKey :SInt16)
    (setOrClear :Boolean)
   )
   :SInt16
() )
; 	The PPD code can help the caller track user selections and 
; 	certain selections are constrained by the PPD or not. The ppdSetSelection()
; 	function can be used by a caller to indicate that a user has selected or deselected
; 	a main keyword, option keyword pair.
; 

(deftrap-inline "_getUIConstraintListH" 
   ((ppdContext (:pointer :PPDContextViel))
   )
   (:pointer (:pointer :UICONSTRAINTLIST))
() )
; 	Returns the UIConstraintListH so that the user can determine whether
; 	certain selections are constrained by the PPD or not by searching the list.
; 

(deftrap-inline "_ppdClearOptions" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainKey :SInt16)
   )
   :void
() )
; 	When running a user interface, it is often useful to clear a users selections
; 	for a given main keyword. The function ppdClearOptions() does this.
; 

(deftrap-inline "_ppdSetDefaultOptions" 
   ((ppdContext (:pointer :PPDContextViel))
    (groupIndex :SInt16)
   )
   :void
() )
; 	To set all the main keyword, option keyword UI pairs of a particular
; 	group to their default settings use ppdSetDefaultOptions().
; 	This function is most useful when setting the installable options
; 	group of key pairs to their default settings.
; 

(deftrap-inline "_ppdGetAllOptions" 
   ((ppdContext (:pointer :PPDContextViel))
    (addPair :pointer)
    (refCon :signed-long)
   )
   :SInt16
() )
; 	When a user has finished running a user interface built upon the PPD code,
; 	the caller may desire to retrieve the user¹s final PPD selections.
; 	The function ppdGetAllOptions() will enumerate through the main keyword,
; 	option keyword selections of the user, and for each pair the function addPair
; 	will be invoked.
; 

(deftrap-inline "_ppdGetMainString" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey :SInt16)
    (buffer (:pointer :UInt8))
   )
   :Boolean
() )
; 	In order to get a string representation of a Mindex, use the function
; 	ppdGetMainString (). ppdGetMainString () is the inverse function of
; 	ppdMainIndexGet().
; 

(deftrap-inline "_ppdGetMainAlias" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey :SInt16)
    (buffer (:pointer :UInt8))
   )
   :Boolean
() )
; 	Similar to ppdGetMainString () except that it returns the translation string
; 	for a main keyword. If the keyword has no translation string then the Pascal
; 	string representation of the main keyword is returned.Use this function to
; 	build user interface strings.
; 

(deftrap-inline "_ppdGetOptionString" 
   ((ppdContext (:pointer :PPDContextViel))
    (optionkey :SInt16)
    (buffer (:pointer :UInt8))
   )
   :Boolean
() )
; 	In order to get a string representation of an Oindex, use the function
; 	ppdGetOptionString (). ppdGetOptionString () is the inverse function
; 	of ppdOptionIndexGet().
; 

(deftrap-inline "_ppdGetOptionAlias" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey :SInt16)
    (optionkey :SInt16)
    (buffer (:pointer :UInt8))
   )
   :Boolean
() )
; 	ppdGetOptionAlias() is similar to ppdGetOptionString () except that it
; 	returns the translation string for an option keyword. If the keyword
; 	has no translation string then the Pascal string representation of
; 	the option keyword is returned.Use this function to build user interface strings.
; 

(deftrap-inline "_ppdGetGroupAlias" 
   ((ppdContext (:pointer :PPDContextViel))
    (groupKeyIndex :SInt16)
    (buf (:pointer :Byte))
   )
   :Boolean
() )
; 	Returns the translation string for a group keyword. If the keyword
; 	has no translation string then the Pascal string representation of
; 	the group keyword is returned. Use this function to build user interface strings.
; 

(deftrap-inline "_ppdGetInvocationLocator" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey :SInt16)
    (optionkey :SInt16)
    (invocation (:pointer :InvocationLocator))
   )
   :SInt16
() )
; 	At some point after a user has selected a main key, option key pair, the
; 	caller may need to determine the PostScript invocation string associated with
; 	the user¹s choice. The function ppdGetInvocationLocator() provides information
; 	about the PostScript invocation string that can be used to call ppdGetInvocationString(),
; 	ppdGetInvocation(), ppdGetInvocationStruct(), or ppdGetInvocationFile().
; 

(deftrap-inline "_ppdGetInvocation" 
   ((ppdContext (:pointer :PPDContextViel))
    (invocation (:pointer :InvocationLocator))
    (offset (:pointer :long))
    (count (:pointer :long))
    (buffer :pointer)
   )
   :SInt16
() )
; 	ppdGetInvocation() is the most general routine for retrieving the PostScript
; 	invocation string. It can be used to retrieve invocations that are very large.
; 	ppdGetInvocation() fills a caller supplied buffer with as much of the invocation
; 	as possible. The user can make successive calls to ppdGetInvocation() to get
; 	the rest of the data if it does not fit in the caller¹s buffer.
; 

(deftrap-inline "_ppdGetInvocationString" 
   ((ppdContext (:pointer :PPDContextViel))
    (mindex :SInt16)
    (oindex :SInt16)
    (data (:pointer :UInt8))
    (maxLength :SInt16)
   )
   :SInt16
() )
; 	ppdGetInvocationString() will directly return the invocation string from a main key,
; 	option key pair as a Pascal style string. Because ppdGetInvocationString() is
; 	built upon ppdGetInvocation(), the same conversions as noted in the description
; 	of ppdGetInvocation() are performed here.
; 

(deftrap-inline "_ppdCheckConstraints" 
   ((ppdContext (:pointer :PPDContextViel))
    (mainkey1 (:pointer :Mindex))
    (optkey1 (:pointer :Oindex))
    (mainkey2 (:pointer :Mindex))
    (optkey2 (:pointer :Oindex))
   )
   :Boolean
() )
; 	ppdCheckConstraints() goes through its list of selected items
; 	and returns the first pair chosen that is illegal.
; 

(deftrap-inline "_ppdCheckDates" 
   ((ppdContext (:pointer :PPDContextViel))
   )
   :signed-long
() )
; 	Check mod dates on all PPD files that ppdContext is made up from.
; 	The purpose is to flag to the client that the PPD needs to be reparsed.
; 	Return:
; 		-1	if anyone is out of date.
; 		0	if resource is used (the Generic PPD)
; 		1	if all files are OK
; 	
; 	If ppdCheckDates() returns 0 the client has to make sure that the parsed
; 	Generic PPD is the parsed version of the current driver's Generic PPD.
; 

(deftrap-inline "_setInstallableOptions" 
   ((ppdContext (:pointer :PPDContextViel))
    (ticket (:pointer :OpaquePMTicketRef))
   )
   :SInt32
() )
; 	Overrides any matching default constraints in PPDContext with printer 
;         installed restraints.
; 
;  The following calls are not yet documented in the PPD library specs.
; 

(deftrap-inline "_ppdGetInvocationStruct" 
   ((ppdContext (:pointer :PPDContextViel))
    (mindex :SInt16)
    (oindex :SInt16)
    (data :pointer)
    (size :SInt16)
   )
   :SInt16
() )
; 	Specialized version of GetInvocationString for returning a struct
; 

(deftrap-inline "_ppdGetInvocationFile" 
   ((ppdContext (:pointer :PPDContextViel))
    (invocationType :SInt16)
    (theFile (:pointer :PPDFileSpec))
   )
   :SInt16
() )
; 	Return a File Spec for a remote invocation file.
; 	Returns fnfErr if we can't find the file data or if the file data block
; 	is zero, indicating an unused file.
; 

(deftrap-inline "_ppdApplyConstraints" 
   ((ppdContext (:pointer :PPDContextViel))
   )
   :Boolean
() )
; 	Check UI constraints and mark the UI entries to reflect the constraints.
; 	Returns true if some constraint is VIOLATED, false if everything is OK
; 

(deftrap-inline "_ppdGetMessageTranslateList" 
   ((ppdContext (:pointer :PPDContextViel))
   )
   (:pointer (:pointer :StrList))
() )
; 	Get a Handle to the status and error message translations
; 

(deftrap-inline "_ppdGetFolder" 
   ((ppdFolder (:pointer :FSSpec))
   )
   :SInt16
() )
; 	This routine fills *'ppdFolder' with the volume id and directory id
; 	of the PPD folder. 'ppdFolder->name' is not changed by this function.
; 	To open a PPD file, call this function so that it fills in the
; 	vRefNum and parID fields of the FSSpec and then put the PPD file's
; 	name into the name field.
; 

(deftrap-inline "_ppdGetParseFolder" 
   ((parseFolder (:pointer :FSSpec))
   )
   :SInt16
() )
; 	Fill in the FSSpec pointed to by 'parseFolder' with
; 	the 'vRefNum' and 'parID' of the parsed PPD folder.
; 	The client can place a parsed PPD file name into the
; 	FSSpec's 'name' field and then use the File Manager's
; 	Open call's to open a parsed PPD. Note that *parseFolder'
; 	is not the FSSpec of the parsed PPD folder.
; 

(deftrap-inline "_ppdFindFile" 
   ((base (:pointer :FSSpec))
    (name (:pointer :UInt8))
    (useBase :Boolean)
   )
   :SInt16
() )
; 	Find a PPD file. if 'useBase' is true, start searching in the directory
; 	referenced by *'base'.  If 'useBase' is false, or the ppd file is not
; 	found in the specified folder, search in other locations as follows until
; 	the ppd file is found.
; 	Search in the Printer Descriptions folder in the Extensions folder
; 	if the folder exists, then search directly in the Extensions folder.  Next
; 	search in the Printer Descriptions folder in the System folder if the
; 	folder exists, then search directly in the System folder.
; 

(deftrap-inline "_ppdMatchPrinter" 
   ((desc (:pointer :PPDPrinterDesc))
    (matchesP (:pointer :ppdmatchhandle))
   )
   :SInt16
() )
; 	This routine takes information about a given printer and attempts
; 	to find one or more PPDs that are appropriate for the described device.
; 	*'desc' is a pointer to a structure that contains pointers to three
; 	Pascal strings.  These strings are the product name, the version and
; 	the revision of a printer.  If one or more of these strings are NULL,
; 	then htat field is assumed to be a wildcard and it will match any given
; 	This routine places into *'matchesP' a handle to a list of FSSPec's
; 	that satisfy the conditions set by 'desc'.  The list begins with
; 	a count of the number of matching FSSpecs. It is the caller's
; 	responsibility to free this handle when it is no longer needed. If 
;     matchModel is true then the caller wants to match the model name of the
;     printer in the place of the product name.
; 

(deftrap-inline "_ppdGetGenericPPDName" 
   ((genericPPDName (:pointer :Str63))
   )
   :SInt16
() )
; 	This routine places the suggested name for the generic PPD into
; 	the buffer pointed to by 'genericPPDName'. New for 8.4.1.
; 

(deftrap-inline "_ppdOpenAndParsePPDAutoSetup" 
   ((prInfo (:pointer :OpaqueCollection))
    (ppdContextP (:pointer :PPDCONTEXT))
    (resFRefP (:pointer :short))
    (errInfoP (:pointer :PPDPARSEERR))
    (lastErr (:pointer :OSStatus))
   )
   :SInt32
() )
; 	Same as ppdOpenAndParsePPD with the addition of lastErr to track the 
; 	ppd error (if any) generated prior to falling back to the generic ppd. 
; 	This will allow the autosetup code to notify the user that the selected
; 	ppd failed to parse while still falling back to the generic ppd.
; 
; 

; #if PRAGMA_IMPORT_SUPPORTED
#| ; #pragma import off
 |#

; #endif


; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=reset
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(pop)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack()
 |#

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif	/* __PPDLIB__ */


(provide-interface "PPDLib")