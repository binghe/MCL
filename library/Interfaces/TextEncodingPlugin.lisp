(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TextEncodingPlugin.h"
; at Sunday July 2,2006 7:23:31 pm.
; 
;      File:       CarbonCore/TextEncodingPlugin.h
;  
;      Contains:   Required interface for Text Encoding Converter-Plugins
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1996-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TEXTENCODINGPLUGIN__
; #define __TEXTENCODINGPLUGIN__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __TEXTCOMMON__
#| #|
#include <CarbonCoreTextCommon.h>
#endif
|#
 |#
; #ifndef __TEXTENCODINGCONVERTER__
#| #|
#include <CarbonCoreTextEncodingConverter.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
; 
;   ####################################################################################
;         Constants
;   ####################################################################################
; 
; 
;    This constant is needed for MacOS X development only. It is the name in which the
;    function to grab the plugin's dispatch table must go by. 
; 
(defconstant $kTECMacOSXDispatchTableNameString "ConverterPluginGetPluginDispatchTable")
; #define kTECMacOSXDispatchTableNameString   "ConverterPluginGetPluginDispatchTable"
;  These constant are needed for TEC plugins.

(defconstant $kTECAvailableEncodingsResType :|cven|)
(defconstant $kTECAvailableSniffersResType :|cvsf|)
(defconstant $kTECSubTextEncodingsResType :|cvsb|)
(defconstant $kTECConversionInfoResType :|cvif|)
(defconstant $kTECMailEncodingsResType :|cvml|)
(defconstant $kTECWebEncodingsResType :|cvwb|)
(defconstant $kTECInternetNamesResType :|cvmm|)

(defconstant $kTECPluginType :|ecpg|)
(defconstant $kTECPluginCreator :|encv|)
(defconstant $kTECPluginOneToOne :|otoo|)
(defconstant $kTECPluginOneToMany :|otom|)
(defconstant $kTECPluginManyToOne :|mtoo|)
(defconstant $kTECPluginSniffObj :|snif|)

(defconstant $verUnspecified #x7FFF)
(defconstant $kTECResourceID #x80)
; 
;   ####################################################################################
;         Structs
;   ####################################################################################
; 
;  These structs are needed for TEC plugins.
(defrecord TextEncodingRec
   (base :UInt32)
   (variant :UInt32)
   (format :UInt32)
)

;type name? (%define-record :TextEncodingRec (find-record-descriptor ':TextEncodingRec))
;  supported encodings & sniffers lists, type TECEncodingsListRec 
(defrecord TECEncodingsListRec
   (count :UInt32)
   (encodings :TextEncodingRec)                 ;  first of many
)

;type name? (%define-record :TECEncodingsListRec (find-record-descriptor ':TECEncodingsListRec))

(def-mactype :TECEncodingsListPtr (find-mactype '(:pointer :TECEncodingsListRec)))

(def-mactype :TECEncodingsListHandle (find-mactype '(:handle :TECEncodingsListRec)))
;  sub encodings list - type TECSubTextEncodingsRec 
(defrecord TECSubTextEncodingRec
   (offset :UInt32)                             ;  offset to next variable-length record
   (searchEncoding :TextEncodingRec)            ;  the encoding
   (count :UInt32)
   (subEncodings :TextEncodingRec)              ;  first of many sub encodings for searchEncoding
)

;type name? (%define-record :TECSubTextEncodingRec (find-record-descriptor ':TECSubTextEncodingRec))
(defrecord TECSubTextEncodingsRec
   (count :UInt32)
   (subTextEncodingRec :TECSubTextEncodingRec)  ;  first of many
)

;type name? (%define-record :TECSubTextEncodingsRec (find-record-descriptor ':TECSubTextEncodingsRec))

(def-mactype :TECSubTextEncodingsPtr (find-mactype '(:pointer :TECSubTextEncodingsRec)))

(def-mactype :TECSubTextEncodingsHandle (find-mactype '(:handle :TECSubTextEncodingsRec)))
;  conversions pairs list - type TECEncodingPairsRec 
(defrecord TECEncodingPairRec
   (source :TextEncodingRec)
   (dest :TextEncodingRec)
)

;type name? (%define-record :TECEncodingPairRec (find-record-descriptor ':TECEncodingPairRec))
(defrecord TECEncodingPairs
   (encodingPair :TECEncodingPairRec)
   (flags :UInt32)                              ;  'flags' name is not really used yet (JKC 9/5/97)
   (speed :UInt32)                              ;  'speed' name is not really used yet (JKC 9/5/97)
)

;type name? (%define-record :TECEncodingPairs (find-record-descriptor ':TECEncodingPairs))
(defrecord TECEncodingPairsRec
   (count :UInt32)
   (encodingPairs :TECEncodingPairs)
)

;type name? (%define-record :TECEncodingPairsRec (find-record-descriptor ':TECEncodingPairsRec))

(def-mactype :TECEncodingPairsPtr (find-mactype '(:pointer :TECEncodingPairsRec)))

(def-mactype :TECEncodingPairsHandle (find-mactype '(:handle :TECEncodingPairsRec)))
;  mail & web encodings lists - type TECLocaleToEncodingsListRec 
(defrecord TECLocaleListToEncodingListRec
   (offset :UInt32)                             ;  offset to next variable-length record
   (count :UInt32)
   (locales :SInt16)                            ;  first in list of locales
                                                ;  TECEncodingListRec encodingList;     // after local variable length array
)

;type name? (%define-record :TECLocaleListToEncodingListRec (find-record-descriptor ':TECLocaleListToEncodingListRec))

(def-mactype :TECLocaleListToEncodingListPtr (find-mactype '(:pointer :TECLocaleListToEncodingListRec)))
(defrecord TECLocaleToEncodingsListRec
   (count :UInt32)
   (localeListToEncodingList :TECLocaleListToEncodingListRec);  language of name
)

;type name? (%define-record :TECLocaleToEncodingsListRec (find-record-descriptor ':TECLocaleToEncodingsListRec))

(def-mactype :TECLocaleToEncodingsListPtr (find-mactype '(:pointer :TECLocaleToEncodingsListRec)))

(def-mactype :TECLocaleToEncodingsListHandle (find-mactype '(:handle :TECLocaleToEncodingsListRec)))
;  internet names list - type TECInternetNamesRec 
(defrecord TECInternetNameRec
   (offset :UInt32)                             ;  offset to next variable-length record
   (searchEncoding :TextEncodingRec)            ;  named encoding
   (encodingNameLength :UInt8)
   (encodingName (:array :UInt8 1))             ;  first byte of many 
)

;type name? (%define-record :TECInternetNameRec (find-record-descriptor ':TECInternetNameRec))
(defrecord TECInternetNamesRec
   (count :UInt32)
   (InternetNames :TECInternetNameRec)          ;  first of many
)

;type name? (%define-record :TECInternetNamesRec (find-record-descriptor ':TECInternetNamesRec))

(def-mactype :TECInternetNamesPtr (find-mactype '(:pointer :TECInternetNamesRec)))

(def-mactype :TECInternetNamesHandle (find-mactype '(:handle :TECInternetNamesRec)))
;  plugin context record 
(defrecord TECBufferContextRec
   (textInputBuffer (:pointer :UInt8))
   (textInputBufferEnd (:pointer :UInt8))
   (textOutputBuffer (:pointer :UInt8))
   (textOutputBufferEnd (:pointer :UInt8))
   (encodingInputBuffer (:pointer :TextEncodingRun))
   (encodingInputBufferEnd (:pointer :TextEncodingRun))
   (encodingOutputBuffer (:pointer :TextEncodingRun))
   (encodingOutputBufferEnd (:pointer :TextEncodingRun))
)

;type name? (%define-record :TECBufferContextRec (find-record-descriptor ':TECBufferContextRec))
(defrecord TECPluginStateRec
   (state1 :UInt8)
   (state2 :UInt8)
   (state3 :UInt8)
   (state4 :UInt8)
   (longState1 :UInt32)
   (longState2 :UInt32)
   (longState3 :UInt32)
   (longState4 :UInt32)
)

;type name? (%define-record :TECPluginStateRec (find-record-descriptor ':TECPluginStateRec))
(defrecord TECConverterContextRec
                                                ;  public - manipulated externally and by plugin
   (pluginRec :pointer)
   (sourceEncoding :UInt32)
   (destEncoding :UInt32)
   (reserved1 :UInt32)
   (reserved2 :UInt32)
   (bufferContext :TECBufferContextRec)
                                                ;  private - manipulated only within Plugin
   (contextRefCon :UInt32)
   (conversionProc :pointer)
   (flushProc :pointer)
   (clearContextInfoProc :pointer)
   (options1 :UInt32)
   (options2 :UInt32)
   (pluginState :TECPluginStateRec)
)

;type name? (%define-record :TECConverterContextRec (find-record-descriptor ':TECConverterContextRec))
(defrecord TECSnifferContextRec
                                                ;  public - manipulated externally
   (pluginRec :pointer)
   (encoding :UInt32)
   (maxErrors :UInt32)
   (maxFeatures :UInt32)
   (textInputBuffer (:pointer :UInt8))
   (textInputBufferEnd (:pointer :UInt8))
   (numFeatures :UInt32)
   (numErrors :UInt32)
                                                ;  private - manipulated only within Plugin
   (contextRefCon :UInt32)
   (sniffProc :pointer)
   (clearContextInfoProc :pointer)
   (pluginState :TECPluginStateRec)
)

;type name? (%define-record :TECSnifferContextRec (find-record-descriptor ':TECSnifferContextRec))
; 
;   ####################################################################################
;         Functional Messages
;   ####################################################################################
; 

(def-mactype :TECPluginNewEncodingConverterPtr (find-mactype ':pointer)); (TECObjectRef * newEncodingConverter , TECConverterContextRec * plugContext , TextEncoding inputEncoding , TextEncoding outputEncoding)

(def-mactype :TECPluginClearContextInfoPtr (find-mactype ':pointer)); (TECObjectRef encodingConverter , TECConverterContextRec * plugContext)

(def-mactype :TECPluginConvertTextEncodingPtr (find-mactype ':pointer)); (TECObjectRef encodingConverter , TECConverterContextRec * plugContext)

(def-mactype :TECPluginFlushConversionPtr (find-mactype ':pointer)); (TECObjectRef encodingConverter , TECConverterContextRec * plugContext)

(def-mactype :TECPluginDisposeEncodingConverterPtr (find-mactype ':pointer)); (TECObjectRef newEncodingConverter , TECConverterContextRec * plugContext)

(def-mactype :TECPluginNewEncodingSnifferPtr (find-mactype ':pointer)); (TECSnifferObjectRef * encodingSniffer , TECSnifferContextRec * snifContext , TextEncoding inputEncoding)

(def-mactype :TECPluginClearSnifferContextInfoPtr (find-mactype ':pointer)); (TECSnifferObjectRef encodingSniffer , TECSnifferContextRec * snifContext)

(def-mactype :TECPluginSniffTextEncodingPtr (find-mactype ':pointer)); (TECSnifferObjectRef encodingSniffer , TECSnifferContextRec * snifContext)

(def-mactype :TECPluginDisposeEncodingSnifferPtr (find-mactype ':pointer)); (TECSnifferObjectRef encodingSniffer , TECSnifferContextRec * snifContext)

(def-mactype :TECPluginGetCountAvailableTextEncodingsPtr (find-mactype ':pointer)); (TextEncoding * availableEncodings , ItemCount maxAvailableEncodings , ItemCount * actualAvailableEncodings)

(def-mactype :TECPluginGetCountAvailableTextEncodingPairsPtr (find-mactype ':pointer)); (TECConversionInfo * availableEncodings , ItemCount maxAvailableEncodings , ItemCount * actualAvailableEncodings)

(def-mactype :TECPluginGetCountDestinationTextEncodingsPtr (find-mactype ':pointer)); (TextEncoding inputEncoding , TextEncoding * destinationEncodings , ItemCount maxDestinationEncodings , ItemCount * actualDestinationEncodings)

(def-mactype :TECPluginGetCountSubTextEncodingsPtr (find-mactype ':pointer)); (TextEncoding inputEncoding , TextEncoding subEncodings [ ] , ItemCount maxSubEncodings , ItemCount * actualSubEncodings)

(def-mactype :TECPluginGetCountAvailableSniffersPtr (find-mactype ':pointer)); (TextEncoding * availableEncodings , ItemCount maxAvailableEncodings , ItemCount * actualAvailableEncodings)

(def-mactype :TECPluginGetTextEncodingInternetNamePtr (find-mactype ':pointer)); (TextEncoding textEncoding , Str255 encodingName)

(def-mactype :TECPluginGetTextEncodingFromInternetNamePtr (find-mactype ':pointer)); (TextEncoding * textEncoding , ConstStr255Param encodingName)

(def-mactype :TECPluginGetCountWebEncodingsPtr (find-mactype ':pointer)); (TextEncoding * availableEncodings , ItemCount maxAvailableEncodings , ItemCount * actualAvailableEncodings)

(def-mactype :TECPluginGetCountMailEncodingsPtr (find-mactype ':pointer)); (TextEncoding * availableEncodings , ItemCount maxAvailableEncodings , ItemCount * actualAvailableEncodings)
; 
;   ####################################################################################
;         Dispatch Table Definition
;   ####################################################################################
; 

(defconstant $kTECPluginDispatchTableVersion1 #x10000);  1.0 through 1.0.3 releases

(defconstant $kTECPluginDispatchTableVersion1_1 #x10001);  1.1 releases

(defconstant $kTECPluginDispatchTableVersion1_2 #x10002);  1.2 releases

(defconstant $kTECPluginDispatchTableCurrentVersion #x10002)
(defrecord TECPluginDispatchTable
   (version :UInt32)
   (compatibleVersion :UInt32)
   (PluginID :OSType)
   (PluginNewEncodingConverter :pointer)
   (PluginClearContextInfo :pointer)
   (PluginConvertTextEncoding :pointer)
   (PluginFlushConversion :pointer)
   (PluginDisposeEncodingConverter :pointer)
   (PluginNewEncodingSniffer :pointer)
   (PluginClearSnifferContextInfo :pointer)
   (PluginSniffTextEncoding :pointer)
   (PluginDisposeEncodingSniffer :pointer)
   (PluginGetCountAvailableTextEncodings :pointer)
   (PluginGetCountAvailableTextEncodingPairs :pointer)
   (PluginGetCountDestinationTextEncodings :pointer)
   (PluginGetCountSubTextEncodings :pointer)
   (PluginGetCountAvailableSniffers :pointer)
   (PluginGetCountWebTextEncodings :pointer)
   (PluginGetCountMailTextEncodings :pointer)
   (PluginGetTextEncodingInternetName :pointer)
   (PluginGetTextEncodingFromInternetName :pointer)
)

;type name? (%define-record :TECPluginDispatchTable (find-record-descriptor ':TECPluginDispatchTable))
; 
;    The last prototype here is for MacOS X plugins only. TEC Plugins in MacOS X need to export a
;    a function called ConverterPluginGetPluginDispatchTable with the following prototype:
;    extern TECPluginDispatchTable *ConverterPluginGetPluginDispatchTable( void )
;    This function will need to return a pointer to the plugin's function dispatch table 
;    when called. It is important that the function be called exactly 
;    "ConverterPluginGetPluginDispatchTable". TECPluginGetPluginDispatchTablePtr is a 
;    function pointer to this function.
; 

(def-mactype :TECPluginGetPluginDispatchTablePtr (find-mactype ':pointer)); (void)
; #pragma options align=reset

; #endif /* __TEXTENCODINGPLUGIN__ */


(provide-interface "TextEncodingPlugin")