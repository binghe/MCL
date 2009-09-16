(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MacTypes.h"
; at Sunday July 2,2006 7:22:44 pm.
; 
;      File:       CarbonCore/MacTypes.h
;  
;      Contains:   Basic Macintosh data types.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MACTYPES__
; #define __MACTYPES__
; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#

(require-interface "stdbool")

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
; *******************************************************************************
; 
;     Special values
; 
;         NULL        The C standard for an null pointer constant
;         nil         In Objective-C, a null id defined in <objc/objc.h>
;                     In C, an alias for NULL
; 
; ********************************************************************************
; #ifndef NULL
; #define NULL 0

; #endif

; #ifndef nil
; #define nil 0

; #endif

; *******************************************************************************
; 
;     Base integer types for all target OS's and CPU's
;     
;         UInt8            8-bit unsigned integer 
;         SInt8            8-bit signed integer
;         UInt16          16-bit unsigned integer 
;         SInt16          16-bit signed integer           
;         UInt32          32-bit unsigned integer 
;         SInt32          32-bit signed integer   
;         UInt64          64-bit unsigned integer 
;         SInt64          64-bit signed integer   
; 
; ********************************************************************************

;type name? (def-mactype :UInt8 (find-mactype ':UInt8))

;type name? (def-mactype :SInt8 (find-mactype ':SInt8))

;type name? (def-mactype :UInt16 (find-mactype ':UInt16))

;type name? (def-mactype :SInt16 (find-mactype ':SInt16))

;type name? (def-mactype :UInt32 (find-mactype ':UInt32))

;type name? (def-mactype :SInt32 (find-mactype ':SInt32))
;  avoid redeclaration if libkern/OSTypes.h 
; #ifndef _OS_OSTYPES_H

; #if TARGET_RT_BIG_ENDIAN
(defrecord wide
   (hi :SInt32)
   (lo :UInt32)
)

;type name? (%define-record :wide (find-record-descriptor ':wide))
(defrecord UnsignedWide
   (hi :UInt32)
   (lo :UInt32)
)

;type name? (%define-record :UnsignedWide (find-record-descriptor ':UnsignedWide))
#| 
; #else
(defrecord wide
   (lo :UInt32)
   (hi :SInt32)
)

;type name? (%define-record :wide (find-record-descriptor ':wide))
(defrecord UnsignedWide
   (lo :UInt32)
   (hi :UInt32)
)

;type name? (%define-record :UnsignedWide (find-record-descriptor ':UnsignedWide))
 |#

; #endif  /* TARGET_RT_BIG_ENDIAN */


; #endif


; #if TYPE_LONGLONG
#| 
; 
;   Note:   wide and UnsignedWide must always be structs for source code
;            compatibility. On the other hand UInt64 and SInt64 can be
;           either a struct or a long long, depending on the compiler.
;          
;            If you use UInt64 and SInt64 you should do all operations on 
;           those data types through the functions/macros in Math64.h.  
;            This will assure that your code compiles with compilers that
;            support long long and those that don't.
;             
;            The MS Visual C/C++ compiler uses __int64 instead of long long. 
; 

; #if defined(_MSC_VER) && !defined(__MWERKS__) && defined(_M_IX86)

(def-mactype :__int64 (find-mactype ':SInt32))  ; SInt64

(def-mactype :__int64 (find-mactype ':UInt32))  ; UInt64

; #else

;type name? (def-mactype :long (find-mactype ':SInt32)); SInt64

;type name? (def-mactype :long (find-mactype ':UInt32)); UInt64

; #endif

 |#

; #else

;type name? (%define-record :SInt64 (find-record-descriptor ':wide))

;type name? (%define-record :UInt64 (find-record-descriptor ':UnsignedWide))

; #endif  /* TYPE_LONGLONG */

; *******************************************************************************
; 
;     Base fixed point types 
;     
;         Fixed           16-bit signed integer plus 16-bit fraction
;         UnsignedFixed   16-bit unsigned integer plus 16-bit fraction
;         Fract           2-bit signed integer plus 30-bit fraction
;         ShortFixed      8-bit signed integer plus 8-bit fraction
;         
; ********************************************************************************

(def-mactype :Fixed (find-mactype ':signed-long))

(def-mactype :FixedPtr (find-mactype '(:pointer :signed-long)))

(def-mactype :Fract (find-mactype ':signed-long))

(def-mactype :FractPtr (find-mactype '(:pointer :signed-long)))

(def-mactype :UnsignedFixed (find-mactype ':UInt32))

(def-mactype :UnsignedFixedPtr (find-mactype '(:pointer :UInt32)))

(def-mactype :ShortFixed (find-mactype ':SInt16))

(def-mactype :ShortFixedPtr (find-mactype '(:pointer :SInt16)))
; *******************************************************************************
; 
;     Base floating point types 
;     
;         Float32         32 bit IEEE float:  1 sign bit, 8 exponent bits, 23 fraction bits
;         Float64         64 bit IEEE float:  1 sign bit, 11 exponent bits, 52 fraction bits  
;         Float80         80 bit MacOS float: 1 sign bit, 15 exponent bits, 1 integer bit, 63 fraction bits
;         Float96         96 bit 68881 float: 1 sign bit, 15 exponent bits, 16 pad bits, 1 integer bit, 63 fraction bits
;         
;     Note: These are fixed size floating point types, useful when writing a floating
;           point value to disk.  If your compiler does not support a particular size 
;           float, a struct is used instead.
;           Use of of the NCEG types (e.g. double_t) or an ANSI C type (e.g. double) if
;           you want a floating point representation that is natural for any given
;           compiler, but might be a different size on different compilers.
; 
; ********************************************************************************

(def-mactype :Float32 (find-mactype ':single-float))

(def-mactype :Float64 (find-mactype ':double-float))
(defrecord Float80
   (exp :SInt16)
   (man (:array :UInt16 4))
)

;type name? (%define-record :Float80 (find-record-descriptor ':Float80))
(defrecord Float96
   (exp (:array :SInt16 2))                     ;  the second 16-bits are undefined 
   (man (:array :UInt16 4))
)

;type name? (%define-record :Float96 (find-record-descriptor ':Float96))
(defrecord Float32Point
   (x :single-float)
   (y :single-float)
)

;type name? (%define-record :Float32Point (find-record-descriptor ':Float32Point))
; *******************************************************************************
; 
;     MacOS Memory Manager types
;     
;         Ptr             Pointer to a non-relocatable block
;         Handle          Pointer to a master pointer to a relocatable block
;         Size            The number of bytes in a block (signed for historical reasons)
;         
; ********************************************************************************

;type name? (def-mactype :Ptr (find-mactype '(:pointer :character)))

;type name? (def-mactype :Handle (find-mactype '(:pointer :pointer)))

(def-mactype :Size (find-mactype ':signed-long))
; *******************************************************************************
; 
;     Higher level basic types
;     
;         OSErr                   16-bit result error code
;         OSStatus                32-bit result error code
;         LogicalAddress          Address in the clients virtual address space
;         ConstLogicalAddress     Address in the clients virtual address space that will only be read
;         PhysicalAddress         Real address as used on the hardware bus
;         BytePtr                 Pointer to an array of bytes
;         ByteCount               The size of an array of bytes
;         ByteOffset              An offset into an array of bytes
;         ItemCount               32-bit iteration count
;         OptionBits              Standard 32-bit set of bit flags
;         PBVersion               ?
;         Duration                32-bit millisecond timer for drivers
;         AbsoluteTime            64-bit clock
;         ScriptCode              A particular set of written characters (e.g. Roman vs Cyrillic) and their encoding
;         LangCode                A particular language (e.g. English), as represented using a particular ScriptCode
;         RegionCode              Designates a language as used in a particular region (e.g. British vs American
;                                 English) together with other region-dependent characteristics (e.g. date format)
;         FourCharCode            A 32-bit value made by packing four 1 byte characters together
;         OSType                  A FourCharCode used in the OS and file system (e.g. creator)
;         ResType                 A FourCharCode used to tag resources (e.g. 'DLOG')
;         
; ********************************************************************************

(def-mactype :OSErr (find-mactype ':SInt16))

(def-mactype :OSStatus (find-mactype ':SInt32))

(def-mactype :LogicalAddress (find-mactype '(:pointer :void)))

(def-mactype :ConstLogicalAddress (find-mactype '(:pointer :void)))

(def-mactype :PhysicalAddress (find-mactype '(:pointer :void)))

(def-mactype :BytePtr (find-mactype '(:pointer :UInt8)))

(def-mactype :ByteCount (find-mactype ':UInt32))

(def-mactype :ByteOffset (find-mactype ':UInt32))

(def-mactype :Duration (find-mactype ':SInt32))

(%define-record :AbsoluteTime (find-record-descriptor ':UnsignedWide))

(def-mactype :OptionBits (find-mactype ':UInt32))

(def-mactype :ItemCount (find-mactype ':UInt32))

(def-mactype :PBVersion (find-mactype ':UInt32))

(def-mactype :ScriptCode (find-mactype ':SInt16))

(def-mactype :LangCode (find-mactype ':SInt16))

(def-mactype :RegionCode (find-mactype ':SInt16))

;type name? (def-mactype :FourCharCode (find-mactype ':UInt32))

;type name? (def-mactype :OSType (find-mactype ':FourCharCode))

(def-mactype :ResType (find-mactype ':FourCharCode))

(def-mactype :OSTypePtr (find-mactype '(:pointer :OSType)))

(def-mactype :ResTypePtr (find-mactype '(:pointer :FourCharCode)))
; *******************************************************************************
; 
;     Boolean types and values
;     
;         Boolean         Mac OS historic type, sizeof(Boolean)==1
;         bool            Defined in stdbool.h, ISO C/C++ standard type
;         false           Now defined in stdbool.h
;         true            Now defined in stdbool.h
;         
; ********************************************************************************

;type name? (def-mactype :Boolean (find-mactype ':UInt8))
; *******************************************************************************
; 
;     Function Pointer Types
;     
;         ProcPtr                 Generic pointer to a function
;         Register68kProcPtr      Pointer to a 68K function that expects parameters in registers
;         UniversalProcPtr        Pointer to classic 68K code or a RoutineDescriptor
;         
;         ProcHandle              Pointer to a ProcPtr
;         UniversalProcHandle     Pointer to a UniversalProcPtr
;         
; ********************************************************************************

(def-mactype :ProcPtr (find-mactype ':pointer))

(def-mactype :Register68kProcPtr (find-mactype ':pointer))

; #if TARGET_RT_MAC_CFM
;   The RoutineDescriptor structure is defined in MixedMode.h 

(def-mactype :UniversalProcPtr (find-mactype '(:pointer :RoutineDescriptor)))
#| 
; #else

(def-mactype :UniversalProcPtr (find-mactype ':pointer))
 |#

; #endif  /* TARGET_RT_MAC_CFM */


(def-mactype :ProcHandle (find-mactype '(:pointer :pointer)))

(def-mactype :UniversalProcHandle (find-mactype '(:handle :RoutineDescriptor)))
; *******************************************************************************
; 
;     Common Constants
;     
;         noErr                   OSErr: function performed properly - no error
;         kNilOptions             OptionBits: all flags false
;         kInvalidID              KernelID: NULL is for pointers as kInvalidID is for ID's
;         kVariableLengthArray    array bounds: variable length array
; 
;     Note: kVariableLengthArray is used in array bounds to specify a variable length array.
;           It is ususally used in variable length structs when the last field is an array
;           of any size.  Before ANSI C, we used zero as the bounds of variable length 
;           array, but zero length array are illegal in ANSI C.  Example usage:
;     
;         struct FooList 
;         {
;             short   listLength;
;             Foo     elements[kVariableLengthArray];
;         };
;         
; ********************************************************************************

(defconstant $noErr 0)

(defconstant $kNilOptions 0)
(defconstant $kInvalidID 0)
; #define kInvalidID   0

(defconstant $kVariableLengthArray 1)

(defconstant $kUnknownType #x3F3F3F3F)          ;  "????" QuickTime 3.0: default unknown ResType or OSType 

; *******************************************************************************
; 
;     String Types and Unicode Types
;     
;         UnicodeScalarValue,     A complete Unicode character in UTF-32 format, with
;         UTF32Char               values from 0 through 0x10FFFF (excluding the surrogate
;                                 range 0xD800-0xDFFF and certain disallowed values).
; 
;         UniChar,                A 16-bit Unicode code value in the default UTF-16 format.
;         UTF16Char               UnicodeScalarValues 0-0xFFFF are expressed in UTF-16
;                                 format using a single UTF16Char with the same value.
;                                 UnicodeScalarValues 0x10000-0x10FFFF are expressed in
;                                 UTF-16 format using a pair of UTF16Chars - one in the
;                                 high surrogate range (0xD800-0xDBFF) followed by one in
;                                 the low surrogate range (0xDC00-0xDFFF). All of the
;                                 characters defined in Unicode versions through 3.0 are
;                                 in the range 0-0xFFFF and can be expressed using a single
;                                 UTF16Char, thus the term "Unicode character" generally
;                                 refers to a UniChar = UTF16Char.
; 
;         UTF8Char                An 8-bit code value in UTF-8 format. UnicodeScalarValues
;                                 0-0x7F are expressed in UTF-8 format using one UTF8Char
;                                 with the same value. UnicodeScalarValues above 0x7F are
;                                 expressed in UTF-8 format using 2-4 UTF8Chars, all with
;                                 values in the range 0x80-0xF4 (UnicodeScalarValues
;                                 0x100-0xFFFF use two or three UTF8Chars,
;                                 UnicodeScalarValues 0x10000-0x10FFFF use four UTF8Chars).
; 
;         UniCharCount            A count of UTF-16 code values in an array or buffer.
; 
;         StrNNN                  Pascal string holding up to NNN bytes
;         StringPtr               Pointer to a pascal string
;         StringHandle            Pointer to a StringPtr
;         ConstStringPtr          Pointer to a read-only pascal string
;         ConstStrNNNParam        For function parameters only - means string is const
;         
;         CStringPtr              Pointer to a C string           (in C:  char*)
;         ConstCStringPtr         Pointer to a read-only C string (in C:  const char*)
;         
;     Note: The length of a pascal string is stored as the first byte.
;           A pascal string does not have a termination byte.
;           A pascal string can hold at most 255 bytes of data.
;           The first character in a pascal string is offset one byte from the start of the string. 
;           
;           A C string is terminated with a byte of value zero.  
;           A C string has no length limitation.
;           The first character in a C string is the zeroth byte of the string. 
;           
;         
; ********************************************************************************

(def-mactype :UnicodeScalarValue (find-mactype ':UInt32))

(def-mactype :UTF32Char (find-mactype ':UInt32))

(def-mactype :UniChar (find-mactype ':UInt16))

(def-mactype :UTF16Char (find-mactype ':UInt16))

(def-mactype :UTF8Char (find-mactype ':UInt8))

(def-mactype :UniCharPtr (find-mactype '(:pointer :UInt16)))

(def-mactype :UniCharCount (find-mactype ':UInt32))

(def-mactype :UniCharCountPtr (find-mactype '(:pointer :UInt32)))
(defrecord Str255
   (length :UInt8)
   (contents (:array :UInt8 255))
)
(defrecord Str63
   (length :UInt8)
   (contents (:array :UInt8 63))
)
(defrecord Str32
   (length :UInt8)
   (contents (:array :UInt8 32))
)
(defrecord Str31
   (length :UInt8)
   (contents (:array :UInt8 31))
)
(defrecord Str27
   (length :UInt8)
   (contents (:array :UInt8 27))
)
(defrecord Str15
   (length :UInt8)
   (contents (:array :UInt8 15))
)
; 
;     The type Str32 is used in many AppleTalk based data structures.
;     It holds up to 32 one byte chars.  The problem is that with the
;     length byte it is 33 bytes long.  This can cause weird alignment
;     problems in structures.  To fix this the type "Str32Field" has
;     been created.  It should only be used to hold 32 chars, but
;     it is 34 bytes long so that there are no alignment problems.
; 
(defrecord Str32Field
   (length :UInt8)
   (contents (:array :UInt8 33))
)
; 
;     QuickTime 3.0:
;     The type StrFileName is used to make MacOS structs work 
;     cross-platform.  For example FSSpec or SFReply previously
;     contained a Str63 field.  They now contain a StrFileName
;     field which is the same when targeting the MacOS but is
;     a 256 char buffer for Win32 and unix, allowing them to
;     contain long file names.
; 

(%define-record :StrFileName (find-record-descriptor ':Str63))

(def-mactype :StringPtr (find-mactype '(:pointer :UInt8)))

(def-mactype :StringHandle (find-mactype '(:handle :UInt8)))

(def-mactype :ConstStringPtr (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstStr255Param (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstStr63Param (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstStr32Param (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstStr31Param (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstStr27Param (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstStr15Param (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstStrFileNameParam (find-mactype ':ConstStr63Param))
; #ifdef __cplusplus
#| #|
inline unsigned char StrLength(ConstStr255Param string) { return (*string); }
|#
 |#

; #else
; #define StrLength(string) (*(unsigned char *)(string))

; #endif  /* defined(__cplusplus) */


; #if OLDROUTINENAMES
#| 
; #define Length(string) StrLength(string)
 |#

; #endif  /* OLDROUTINENAMES */

; *******************************************************************************
; 
;     Quickdraw Types
;     
;         Point               2D Quickdraw coordinate, range: -32K to +32K
;         Rect                Rectangular Quickdraw area
;         Style               Quickdraw font rendering styles
;         StyleParameter      Style when used as a parameter (historical 68K convention)
;         StyleField          Style when used as a field (historical 68K convention)
;         CharParameter       Char when used as a parameter (historical 68K convention)
;         
;     Note:   The original Macintosh toolbox in 68K Pascal defined Style as a SET.  
;             Both Style and CHAR occupy 8-bits in packed records or 16-bits when 
;             used as fields in non-packed records or as parameters. 
;         
; ********************************************************************************
#|
(defrecord Point
   (v :SInt16)
   (h :SInt16)
)
|#
;type name? (def-mactype :Point (find-mactype ':Point))

(def-mactype :PointPtr (find-mactype '(:pointer :Point)))
#|
(defrecord Rect
   (top :SInt16)
   (left :SInt16)
   (bottom :SInt16)
   (right :SInt16)
)
|#
;type name? (%define-record :Rect (find-record-descriptor ':Rect))

(def-mactype :RectPtr (find-mactype '(:pointer :Rect)))
(defrecord FixedPoint
   (x :signed-long)
   (y :signed-long)
)

;type name? (%define-record :FixedPoint (find-record-descriptor ':FixedPoint))
(defrecord FixedRect
   (left :signed-long)
   (top :signed-long)
   (right :signed-long)
   (bottom :signed-long)
)

;type name? (%define-record :FixedRect (find-record-descriptor ':FixedRect))

(def-mactype :CharParameter (find-mactype ':SInt16))

(defconstant $normal 0)
(defconstant $bold 1)
(defconstant $italic 2)
(defconstant $underline 4)
(defconstant $outline 8)
(defconstant $shadow 16)
(defconstant $condense 32)
(defconstant $extend 64)

(def-mactype :Style (find-mactype ':UInt8))

(def-mactype :StyleParameter (find-mactype ':SInt16))

(def-mactype :StyleField (find-mactype ':UInt8))
; *******************************************************************************
; 
;     QuickTime TimeBase types (previously in Movies.h)
;     
;         TimeValue           Count of units
;         TimeScale           Units per second
;         CompTimeValue       64-bit count of units (always a struct) 
;         TimeValue64         64-bit count of units (long long or struct) 
;         TimeBase            An opaque reference to a time base
;         TimeRecord          Package of TimeBase, duration, and scale
;         
; ********************************************************************************

(def-mactype :TimeValue (find-mactype ':signed-long))

(def-mactype :TimeScale (find-mactype ':signed-long))

(%define-record :CompTimeValue (find-record-descriptor ':wide))

(%define-record :TimeValue64 (find-record-descriptor ':SInt64))

(def-mactype :TimeBase (find-mactype '(:pointer :TimeBaseRecord)))
(defrecord TimeRecord
   (value :wide)                                ;  units (duration or absolute) 
   (scale :signed-long)                         ;  units per second 
   (base (:pointer :TimeBaseRecord))            ;  refernce to the time base 
)

;type name? (%define-record :TimeRecord (find-record-descriptor ':TimeRecord))
; *******************************************************************************
; 
;     THINK C base objects
; 
;         HandleObject        Root class for handle based THINK C++ objects
;         PascalObject        Root class for pascal style objects in THINK C++ 
; 
; ********************************************************************************

; #if defined(__SC__) && !defined(__STDC__) && defined(__cplusplus)
#| 
#|class __machdl HandleObject {};
|#

; #if TARGET_CPU_68K

#|class __pasobj PascalObject {};
|#

; #endif

 |#

; #endif

; *******************************************************************************
; 
;     MacOS versioning structures
;     
;         VersRec                 Contents of a 'vers' resource
;         VersRecPtr              Pointer to a VersRecPtr
;         VersRecHndl             Resource Handle containing a VersRec
;         NumVersion              Packed BCD version representation (e.g. "4.2.1a3" is 0x04214003)
;         UniversalProcPtr        Pointer to classic 68K code or a RoutineDescriptor
;         
;         ProcHandle              Pointer to a ProcPtr
;         UniversalProcHandle     Pointer to a UniversalProcPtr
;         
; ********************************************************************************

; #if TARGET_RT_BIG_ENDIAN
(defrecord NumVersion
                                                ;  Numeric version part of 'vers' resource 
   (majorRev :UInt8)                            ; 1st part of version number in BCD
   (minorAndBugRev :UInt8)                      ; 2nd & 3rd part of version number share a byte
   (stage :UInt8)                               ; stage code: dev, alpha, beta, final
   (nonRelRev :UInt8)                           ; revision level of non-released version
)

;type name? (%define-record :NumVersion (find-record-descriptor ':NumVersion))
#| 
; #else
(defrecord NumVersion
                                                ;  Numeric version part of 'vers' resource accessable in little endian format 
   (nonRelRev :UInt8)                           ; revision level of non-released version
   (stage :UInt8)                               ; stage code: dev, alpha, beta, final
   (minorAndBugRev :UInt8)                      ; 2nd & 3rd part of version number share a byte
   (majorRev :UInt8)                            ; 1st part of version number in BCD
)

;type name? (%define-record :NumVersion (find-record-descriptor ':NumVersion))
 |#

; #endif  /* TARGET_RT_BIG_ENDIAN */

;  Version Release Stage Codes 

(defconstant $developStage 32)
(defconstant $alphaStage 64)
(defconstant $betaStage 96)
(defconstant $finalStage #x80)
(defrecord NumVersionVariant
   (:variant
                                                ;  NumVersionVariant is a wrapper so NumVersion can be accessed as a 32-bit value 
   (
   (parts :NumVersion)
   )
   (
   (whole :UInt32)
   )
   )
)

;type name? (%define-record :NumVersionVariant (find-record-descriptor ':NumVersionVariant))

(def-mactype :NumVersionVariantPtr (find-mactype '(:pointer :NumVersionVariant)))

(def-mactype :NumVersionVariantHandle (find-mactype '(:handle :NumVersionVariant)))
(defrecord (VersRec :handle)
                                                ;  'vers' resource format 
   (numericVersion :NumVersion)                 ; encoded version number
   (countryCode :SInt16)                        ; country code from intl utilities
   (shortVersion (:string 255))                 ; version number string - worst case
   (reserved (:string 255))                     ; longMessage string packed after shortVersion
)

;type name? (%define-record :VersRec (find-record-descriptor ':VersRec))

(def-mactype :VersRecPtr (find-mactype '(:pointer :VersRec)))

(def-mactype :VersRecHndl (find-mactype '(:handle :VersRec)))
; ********************************************************************************
; 
;     Old names for types
;         
; ********************************************************************************

;type name? (def-mactype :Byte (find-mactype ':UInt8))

(def-mactype :SignedByte (find-mactype ':SInt8))

(def-mactype :WidePtr (find-mactype '(:pointer :wide)))

(def-mactype :UnsignedWidePtr (find-mactype '(:pointer :UnsignedWide)))

(%define-record :extended80 (find-record-descriptor ':Float80))

(%define-record :extended96 (find-record-descriptor ':Float96))

(def-mactype :VHSelect (find-mactype ':SInt8))
; ********************************************************************************
; 
;     Debugger functions
;     
; ********************************************************************************
; 
;  *  Debugger()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Debugger" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DebugStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DebugStr" 
   ((debuggerMsg (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  debugstr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_CPU_PPC
;  Only for Mac OS native drivers 
; 
;  *  SysDebug()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  
; 
;  *  SysDebugStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
;  

; #endif  /* TARGET_CPU_PPC */

;  SADE break points 
; 
;  *  SysBreak()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SysBreak" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SysBreakStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SysBreakStr" 
   ((debuggerMsg (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SysBreakFunc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SysBreakFunc" 
   ((debuggerMsg (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  old names for Debugger and DebugStr 

; #if OLDROUTINENAMES && TARGET_CPU_68K
#| 
; #define Debugger68k()   Debugger()
; #define DebugStr68k(s)  DebugStr(s)
 |#

; #endif

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MACTYPES__ */


(provide-interface "MacTypes")