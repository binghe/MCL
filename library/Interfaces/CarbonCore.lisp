(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CarbonCore.h"
; at Sunday July 2,2006 7:23:07 pm.
; 
;      File:       CarbonCore/CarbonCore.h
;  
;      Contains:   Master include for CarbonCore private framework
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CARBONCORE__
; #define __CARBONCORE__
; #ifndef __COREFOUNDATION__

(require-interface "CoreFoundation/CoreFoundation")

; #endif

; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __FINDER__

(require-interface "CarbonCore/Finder")

; #endif

; #ifndef __FIXMATH__

(require-interface "CarbonCore/FixMath")

; #endif

; #ifndef __SCRIPT__

(require-interface "CarbonCore/Script")

; #endif

; #ifndef __UTCUTILS__

(require-interface "CarbonCore/UTCUtils")

; #endif

; #ifndef __TEXTCOMMON__

(require-interface "CarbonCore/TextCommon")

; #endif

; #ifndef __COLLECTIONS__

(require-interface "CarbonCore/Collections")

; #endif

; #ifndef __ENDIAN__
#| #|
#include <CarbonCoreEndian.h>
#endif
|#
 |#
; #ifndef __PATCHES__

(require-interface "CarbonCore/Patches")

; #endif

; #ifndef __GESTALT__

(require-interface "CarbonCore/Gestalt")

; #endif

; #ifndef __MACMEMORY__

(require-interface "CarbonCore/MacMemory")

; #endif

; #ifndef __MATH64__

(require-interface "CarbonCore/Math64")

; #endif

; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
#endif
|#
 |#
; #ifndef __MACERRORS__
#| #|
#include <CarbonCoreMacErrors.h>
#endif
|#
 |#
; #ifndef __COMPONENTS__

(require-interface "CarbonCore/Components")

; #endif

; #ifndef __OSUTILS__
#| #|
#include <CarbonCoreOSUtils.h>
#endif
|#
 |#
; #ifndef __FILES__
#| #|
#include <CarbonCoreFiles.h>
#endif
|#
 |#
; #ifndef __RESOURCES__

(require-interface "CarbonCore/Resources")

; #endif

; #ifndef __CODEFRAGMENTS__

(require-interface "CarbonCore/CodeFragments")

; #endif

; #ifndef __ALIASES__

(require-interface "CarbonCore/Aliases")

; #endif

; #ifndef __MACLOCALES__

(require-interface "CarbonCore/MacLocales")

; #endif

; #ifndef __DEBUGGING__

(require-interface "CarbonCore/Debugging")

; #endif

; #ifndef __PLSTRINGFUNCS__

(require-interface "CarbonCore/PLStringFuncs")

; #endif

; #ifndef __DRIVERSYNCHRONIZATION__

(require-interface "CarbonCore/DriverSynchronization")

; #endif

; #ifndef __DEVICES__

(require-interface "CarbonCore/Devices")

; #endif

; #ifndef __DRIVERSERVICES__

(require-interface "CarbonCore/DriverServices")

; #endif

; #ifndef __INTLRESOURCES__
#| #|
#include <CarbonCoreIntlResources.h>
#endif
|#
 |#
; #ifndef __NUMBERFORMATTING__

(require-interface "CarbonCore/NumberFormatting")

; #endif

; #ifndef __DATETIMEUTILS__
#| #|
#include <CarbonCoreDateTimeUtils.h>
#endif
|#
 |#
; #ifndef __STRINGCOMPARE__

(require-interface "CarbonCore/StringCompare")

; #endif

; #ifndef __TEXTUTILS__

(require-interface "CarbonCore/TextUtils")

; #endif

; #ifndef __TOOLUTILS__

(require-interface "CarbonCore/ToolUtils")

; #endif

; #ifndef __NAMEREGISTRY__
#| #|
#include <CarbonCoreNameRegistry.h>
#endif
|#
 |#
; #ifndef __UNICODEUTILITIES__

(require-interface "CarbonCore/UnicodeUtilities")

; #endif

; #ifndef __FP__

(require-interface "CarbonCore/fp")

; #endif


(require-interface "fenv")
; #ifndef __TEXTENCODINGCONVERTER__

(require-interface "CarbonCore/TextEncodingConverter")

; #endif

; #ifndef __UNICODECONVERTER__

(require-interface "CarbonCore/UnicodeConverter")

; #endif

; #ifndef __THREADS__

(require-interface "CarbonCore/Threads")

; #endif

; #ifndef __FOLDERS__

(require-interface "CarbonCore/Folders")

; #endif

; #ifndef __TIMER__

(require-interface "CarbonCore/Timer")

; #endif

; #ifndef __MULTIPROCESSINGINFO__

(require-interface "CarbonCore/MultiprocessingInfo")

; #endif

; #ifndef __MULTIPROCESSING__
#| #|
#include <CarbonCoreMultiprocessing.h>
#endif
|#
 |#
; #ifndef __MACHINEEXCEPTIONS__
#| #|
#include <CarbonCoreMachineExceptions.h>
#endif
|#
 |#
; #ifndef __LOWMEM__

(require-interface "CarbonCore/LowMem")

; #endif

; #ifndef __AVLTREE__

(require-interface "CarbonCore/AVLTree")

; #endif

; #ifndef __PEFBINARYFORMAT__

(require-interface "CarbonCore/PEFBinaryFormat")

; #endif

; #ifndef __HFSVOLUMES__

(require-interface "CarbonCore/HFSVolumes")

; #endif

; #ifndef __AIFF__

(require-interface "CarbonCore/AIFF")

; #endif

; #ifndef __TEXTENCODINGPLUGIN__

(require-interface "CarbonCore/TextEncodingPlugin")

; #endif


; #endif /* __CARBONCORE__ */


(provide-interface "CarbonCore")