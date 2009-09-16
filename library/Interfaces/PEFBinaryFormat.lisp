(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PEFBinaryFormat.h"
; at Sunday July 2,2006 7:23:29 pm.
; 
;      File:       CarbonCore/PEFBinaryFormat.h
;  
;      Contains:   PEF Types and Macros
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1993-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PEFBINARYFORMAT__
; #define __PEFBINARYFORMAT__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
;  -------------------------------------------------------------------------------------------- 
;  Almost all types are padded for natural alignment.  However the PEFExportedSymbol type is    
;  10 bytes long, containing two 32 bit fields and one 16 bit field.  Arrays of it must be      
;  packed, so it requires "68K" alignment.  Setting this globally to 68K should also help       
;  ensure consistent treatment across compilers.                                                
;  ======================================================================================== 
;  Overall Structure 
;  ================= 
;  -------------------------------------------------------------------------------------------- 
;  This header contains a complete set of types and macros for dealing with the PEF executable  
;  format.  While some description is provided, this header is not meant as a primary source    
;  of documentation on PEF.  An excellent specification of PEF can be found in the Macintosh    
;  Runtime Architectures book.  This header is primarily a physical format description.  Thus   
;  it depends on as few other headers as possible and structure fields have obvious sizes.      
;                                                                                               
;  The physical storage for a PEF executable is known as a "container".  This refers to just    
;  the executable itself, not the file etc.  E.g. if five DLLs are packaged in a single file's  
;  data fork, that one data fork has five containers within it.                                 
;                                                                                               
;  A PEF container consists of an overall header, followed by one or more section headers,      
;  followed by the section name table, followed by the contents for the sections.  Some kinds   
;  of sections have specific internal representation.  The "loader" section is the most common  
;  of these special sections.  It contains information on the exports, imports, and runtime     
;  relocations required to prepare the executable.  PEF containers are self contained, all      
;  portions are located via relative offsets.                                                   
;                                                                                               
;                                                                                               
;           +-------------------------------+                                                   
;           |       Container Header        |   40 bytes                                        
;           +-------------------------------+                                                   
;           |       Section 0 header        |   28 bytes each                                   
;           |...............................|                                                   
;           |           - - - -             |                                                   
;           |...............................|                                                   
;           |       Section n-1 header      |                                                   
;           +-------------------------------+                                                   
;           |       Section Name Table      |                                                   
;           +-------------------------------+                                                   
;           |       Section x raw data      |                                                   
;           +-------------------------------+                                                   
;           |           - - - -             |                                                   
;           +-------------------------------+                                                   
;           |       Section y raw data      |                                                   
;           +-------------------------------+                                                   
;                                                                                               
;                                                                                               
;  The sections are implicitly numbered from 0 to n according to the order of their headers.    
;  The headers of the instantiated sections must precede those of the non-instantiated          
;  sections.  The ordering of the raw data is independent of the section header ordering.       
;  Each section header contains the offset for that section's raw data.                         
;  =========================================================================================== 
;  Container Header 
;  ================ 
(defrecord PEFContainerHeader
   (tag1 :OSType)                               ;  Must contain 'Joy!'.
   (tag2 :OSType)                               ;  Must contain 'peff'.  (Yes, with two 'f's.)
   (architecture :OSType)                       ;  The ISA for code sections.  Constants in CodeFragments.h.
   (formatVersion :UInt32)                      ;  The physical format version.
   (dateTimeStamp :UInt32)                      ;  Macintosh format creation/modification stamp.
   (oldDefVersion :UInt32)                      ;  Old definition version number for the code fragment.
   (oldImpVersion :UInt32)                      ;  Old implementation version number for the code fragment.
   (currentVersion :UInt32)                     ;  Current version number for the code fragment.
   (sectionCount :UInt16)                       ;  Total number of section headers that follow.
   (instSectionCount :UInt16)                   ;  Number of instantiated sections.
   (reservedA :UInt32)                          ;  Reserved, must be written as zero.
)

;type name? (%define-record :PEFContainerHeader (find-record-descriptor ':PEFContainerHeader))

(defconstant $kPEFTag1 :|Joy!|)                 ;  For non-Apple compilers: 0x4A6F7921.

(defconstant $kPEFTag2 :|peff|)                 ;  For non-Apple compilers: 0x70656666.

(defconstant $kPEFVersion 1)

(defconstant $kPEFFirstSectionHeaderOffset 40)
; #define PEFFirstSectionNameOffset(container)                ( kPEFFirstSectionHeaderOffset + ((container)->sectionCount * sizeof ( PEFSectionHeader )) )
;  =========================================================================================== 
;  Section Headers 
;  =============== 
(defrecord PEFSectionHeader
   (nameOffset :SInt32)                         ;  Offset of name within the section name table, -1 => none.
   (defaultAddress :UInt32)                     ;  Default address, affects relocations.
   (totalLength :UInt32)                        ;  Fully expanded size in bytes of the section contents.
   (unpackedLength :UInt32)                     ;  Size in bytes of the "initialized" part of the contents.
   (containerLength :UInt32)                    ;  Size in bytes of the raw data in the container.
   (containerOffset :UInt32)                    ;  Offset of section's raw data.
   (sectionKind :UInt8)                         ;  Kind of section contents/usage.
   (shareKind :UInt8)                           ;  Sharing level, if a writeable section.
   (alignment :UInt8)                           ;  Preferred alignment, expressed as log 2.
   (reservedA :UInt8)                           ;  Reserved, must be zero.
)

;type name? (%define-record :PEFSectionHeader (find-record-descriptor ':PEFSectionHeader))
;  Values for the sectionKind field.
;     Section kind values for instantiated sections.

(defconstant $kPEFCodeSection 0)                ;  Code, presumed pure & position independent.

(defconstant $kPEFUnpackedDataSection 1)        ;  Unpacked writeable data.

(defconstant $kPEFPackedDataSection 2)          ;  Packed writeable data.

(defconstant $kPEFConstantSection 3)            ;  Read-only data.

(defconstant $kPEFExecDataSection 6)            ;  Intermixed code and writeable data.
;  Section kind values for non-instantiated sections.

(defconstant $kPEFLoaderSection 4)              ;  Loader tables.

(defconstant $kPEFDebugSection 5)               ;  Reserved for future use.

(defconstant $kPEFExceptionSection 7)           ;  Reserved for future use.

(defconstant $kPEFTracebackSection 8)           ;  Reserved for future use.

;  Values for the shareKind field.

(defconstant $kPEFProcessShare 1)               ;  Shared within a single process.

(defconstant $kPEFGlobalShare 4)                ;  Shared across the entire system.

(defconstant $kPEFProtectedShare 5)             ;  Readable across the entire system, writeable only to privileged code.

;  =========================================================================================== 
;  Packed Data Contents 
;  ==================== 
;  -------------------------------------------------------------------------------------------- 
;  The raw contents of a packed data section are a sequence of byte codes.  The basic format    
;  has a 3 bit opcode followed by a 5 bit count.  Additional bytes might be used to contain     
;  counts larger than 31, and to contain a second or third count.  Further additional bytes     
;  contain actual data values to transfer.                                                      
;                                                                                               
;  All counts are represented in a variable length manner.  A zero in the initial 5 bit count   
;  indicates the actual value follows.  In this case, and for the second and third counts, the  
;  count is represented as a variable length sequence of bytes.  The bytes are stored in big    
;  endian manner, most significant part first.  The high order bit is set in all but the last   
;  byte.  The value is accumulated by shifting the current value up 7 bits and adding in the    
;  low order 7 bits of the next byte.                                                           
;  The packed data opcodes.

(defconstant $kPEFPkDataZero 0)                 ;  Zero fill "count" bytes.

(defconstant $kPEFPkDataBlock 1)                ;  Block copy "count" bytes.

(defconstant $kPEFPkDataRepeat 2)               ;  Repeat "count" bytes "count2"+1 times.

(defconstant $kPEFPkDataRepeatBlock 3)          ;  Interleaved repeated and unique data.

(defconstant $kPEFPkDataRepeatZero 4)           ;  Interleaved zero and unique data.


(defconstant $kPEFPkDataOpcodeShift 5)
(defconstant $kPEFPkDataCount5Mask 31)
(defconstant $kPEFPkDataMaxCount5 31)
(defconstant $kPEFPkDataVCountShift 7)
(defconstant $kPEFPkDataVCountMask 127)
(defconstant $kPEFPkDataVCountEndMask #x80)
; #define PEFPkDataOpcode(byte) ( ((UInt8)(byte)) >> kPEFPkDataOpcodeShift )
; #define PEFPkDataCount5(byte) ( ((UInt8)(byte)) & kPEFPkDataCount5Mask )
; #define PEFPkDataComposeInstr(opcode,count5)                    ( (((UInt8)(opcode)) << kPEFPkDataOpcodeShift) | ((UInt8)(count5)) )
;  -------------------------------------------------------------------------------------------- 
;  The following code snippet can be used to input a variable length count.                     
;                                                                                               
;       count = 0;                                                                              
;       do {                                                                                    
;           byte = *bytePtr++;                                                                  
;           count = (count << kPEFPkDataVCountShift) | (byte & kPEFPkDataVCountMask);           
;       } while ( (byte & kPEFPkDataVCountEndMask) != 0 );                                      
;                                                                                               
;  The following code snippet can be used to output a variable length count to a byte array.    
;  This is more complex than the input code because the chunks are output in big endian order.  
;  Think about handling values like 0 or 0x030000.                                              
;                                                                                               
;       count = 1;.                                                                             
;       tempValue = value >> kPEFPkDataCountShift;                                              
;       while ( tempValue != 0 ) {                                                              
;           count += 1;                                                                         
;           tempValue = tempValue >> kPEFPkDataCountShift;                                      
;       }                                                                                       
;                                                                                               
;       bytePtr += count;                                                                       
;       tempPtr = bytePtr - 1;                                                                  
;       *tempPtr-- = value;     // ! No need to mask, only the low order byte is stored.        
;       for ( count -= 1; count != 0; count -= 1 ) {                                            
;           value = value >> kPEFPkDataCountShift;                                              
;           *tempPtr-- = value | kPEFPkDataCountEndMask;                                        
;       }                                                                                       
;  =========================================================================================== 
;  Loader Section 
;  ============== 
;  -------------------------------------------------------------------------------------------- 
;  The loader section contains information needed to prepare the code fragment for execution.   
;  This includes this fragment's exports, the import libraries and the imported symbols from    
;  each library, and the relocations for the writeable sections.                                
;                                                                                               
;           +-----------------------------------+               <-- containerOffset --------+   
;           |       Loader Info Header          |   56 bytes                                |   
;           |-----------------------------------|                                           |   
;           |       Imported Library 0          |   24 bytes each                           |   
;           |...................................|                                           |   
;           |           - - -                   |                                           |   
;           |...................................|                                           |   
;           |       Imported Library l-1        |                                           |   
;           |-----------------------------------|                                           |   
;           |       Imported Symbol 0           |   4 bytes each                            |   
;           |...................................|                                           |   
;           |           - - -                   |                                           |   
;           |...................................|                                           |   
;           |       Imported Symbol i-1         |                                           |   
;           |-----------------------------------|                                           |   
;           |       Relocation Header 0         |   12 bytes each                           |   
;           |...................................|                                           |   
;           |           - - -                   |                                           |   
;           |...................................|                                           |   
;           |       Relocation Header r-1       |                                           |   
;           |-----------------------------------|               <-- + relocInstrOffset -----|   
;           |       Relocation Instructions     |                                           |   
;           |-----------------------------------|               <-- + loaderStringsOffset --|   
;           |       Loader String Table         |                                           |   
;           |-----------------------------------|               <-- + exportHashOffset -----+   
;           |       Export Hash Slot 0          |   4 bytes each                                
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Export Hash Slot h-1        |                                               
;           |-----------------------------------|                                               
;           |       Export Symbol Key 0         |   4 bytes each                                
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Export Symbol Key e-1       |                                               
;           |-----------------------------------|                                               
;           |       Export Symbol 0             |   10 bytes each                               
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Export Symbol e-1           |                                               
;           +-----------------------------------+                                               
(defrecord PEFLoaderInfoHeader
   (mainSection :SInt32)                        ;  Section containing the main symbol, -1 => none.
   (mainOffset :UInt32)                         ;  Offset of main symbol.
   (initSection :SInt32)                        ;  Section containing the init routine's TVector, -1 => none.
   (initOffset :UInt32)                         ;  Offset of the init routine's TVector.
   (termSection :SInt32)                        ;  Section containing the term routine's TVector, -1 => none.
   (termOffset :UInt32)                         ;  Offset of the term routine's TVector.
   (importedLibraryCount :UInt32)               ;  Number of imported libraries.  ('l')
   (totalImportedSymbolCount :UInt32)           ;  Total number of imported symbols.  ('i')
   (relocSectionCount :UInt32)                  ;  Number of sections with relocations.  ('r')
   (relocInstrOffset :UInt32)                   ;  Offset of the relocation instructions.
   (loaderStringsOffset :UInt32)                ;  Offset of the loader string table.
   (exportHashOffset :UInt32)                   ;  Offset of the export hash table.
   (exportHashTablePower :UInt32)               ;  Export hash table size as log 2.  (Log2('h'))
   (exportedSymbolCount :UInt32)                ;  Number of exported symbols.  ('e')
)

;type name? (%define-record :PEFLoaderInfoHeader (find-record-descriptor ':PEFLoaderInfoHeader))
;  =========================================================================================== 
;  Imported Libraries 
;  ------------------ 
(defrecord PEFImportedLibrary
   (nameOffset :UInt32)                         ;  Loader string table offset of library's name.
   (oldImpVersion :UInt32)                      ;  Oldest compatible implementation version.
   (currentVersion :UInt32)                     ;  Current version at build time.
   (importedSymbolCount :UInt32)                ;  Imported symbol count for this library.
   (firstImportedSymbol :UInt32)                ;  Index of first imported symbol from this library.
   (options :UInt8)                             ;  Option bits for this library.
   (reservedA :UInt8)                           ;  Reserved, must be zero.
   (reservedB :UInt16)                          ;  Reserved, must be zero.
)

;type name? (%define-record :PEFImportedLibrary (find-record-descriptor ':PEFImportedLibrary))
;  Bits for the PEFImportedLibrary options field.

(defconstant $kPEFWeakImportLibMask 64)         ;  The imported library is allowed to be missing.

(defconstant $kPEFInitLibBeforeMask #x80)       ;  The imported library must be initialized first.

;  =========================================================================================== 
;  Imported Symbols 
;  ---------------- 
;  -------------------------------------------------------------------------------------------- 
;  The PEFImportedSymbol type has the following bit field layout.                               
;                                                                                               
;                                                                      3                        
;        0             7 8                                             1                        
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                       
;       | symbol class  | offset of symbol name in loader string table  |                       
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                       
;       |<-- 8 bits --->|<-- 24 bits ---------------------------------->|                       
(defrecord PEFImportedSymbol
   (classAndName :UInt32)
)

;type name? (%define-record :PEFImportedSymbol (find-record-descriptor ':PEFImportedSymbol))

(defconstant $kPEFImpSymClassShift 24)
(defconstant $kPEFImpSymNameOffsetMask #xFFFFFF)
(defconstant $kPEFImpSymMaxNameOffset #xFFFFFF) ;  16,777,215

; #define PEFImportedSymbolClass(classAndName)        ((UInt8) ((classAndName) >> kPEFImpSymClassShift))
; #define PEFImportedSymbolNameOffset(classAndName)   ((classAndName) & kPEFImpSymNameOffsetMask)
; #define PEFComposeImportedSymbol(class,nameOffset)                  ( ( ((UInt32)(class)) << kPEFImpSymClassShift ) | ( (UInt32)(nameOffset) ) )
;  Imported and exported symbol classes.

(defconstant $kPEFCodeSymbol 0)
(defconstant $kPEFDataSymbol 1)
(defconstant $kPEFTVectorSymbol 2)
(defconstant $kPEFTOCSymbol 3)
(defconstant $kPEFGlueSymbol 4)
(defconstant $kPEFUndefinedSymbol 15)
(defconstant $kPEFWeakImportSymMask #x80)
;  =========================================================================================== 
;  Exported Symbol Hash Table 
;  -------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  Exported symbols are described in four parts, optimized for speed of lookup.  These parts    
;  are the "export hash table", the "export key table", the "export symbol table", and the      
;  "export name table".  Overall they contain a flattened representation of a fairly normal     
;  hashed symbol table.                                                                         
;                                                                                               
;  The export hash table is an array of small fixed size elements.  The number of elements is   
;  a power of 2.  A 32 bit hash word for a symbol is converted into an index into this array.   
;  Each hash slot contains a count of the number of exported symbols that map to this slot and  
;  the index of the first of those symbols in the key and symbol tables.  Of course some hash   
;  slots will have a zero count.                                                                
;                                                                                               
;  The key and symbol tables are also arrays of fixed size elements, one for each exported      
;  symbol.  Their entries are grouped by hash slot, those elements mapping to the same hash     
;  slot are contiguous.  The key table contains just the full 32 bit hash word for each         
;  exported symbol.  The symbol table contains the offset of the symbol's name in the string    
;  table and other information about the exported symbol.                                       
;                                                                                               
;  To look up an export you take the hashword and compute the hash slot index.  You then scan   
;  the indicated portion of the key table for matching hashwords.  If a hashword matches, you   
;  look at the corresponding symbol table entry to find the full symbol name.  If the names     
;  match the symbol is found.                                                                   
;  -------------------------------------------------------------------------------------------- 
;  The following function may be used to compute the hash table size.  Signed values are used   
;  just to avoid potential code generation overhead for unsigned division.                      
;                                                                                               
;       UInt8   PEFComputeHashTableExponent ( SInt32    exportCount )                           
;       {                                                                                       
;           SInt32  exponent;                                                                   
;                                                                                               
;           const SInt32    kExponentLimit      = 16;   // Arbitrary, but must not exceed 30.   
;           const SInt32    kAverageChainLimit  = 10;   // Arbitrary, for space/time tradeoff.  
;                                                                                               
;           for ( exponent = 0; exponent < kExponentLimit; exponent += 1 ) {                    
;               if ( (exportCount / (1 << exponent)) < kAverageChainLimit ) break;              
;           }                                                                                   
;                                                                                               
;           return exponent;                                                                    
;                                                                                               
;       }   // PEFComputeHashTableExponent ()                                                   
;  -------------------------------------------------------------------------------------------- 
;  The PEFExportedSymbolHashSlot type has the following bit field layout.                       
;                                                                                               
;                                  1 1                                 3                        
;        0                         3 4                                 1                        
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                       
;       | symbol count              | index of first export key         |                       
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                       
;       |<-- 14 bits -------------->|<-- 18 bits ---------------------->|                       
(defrecord PEFExportedSymbolHashSlot
   (countAndStart :UInt32)
)

;type name? (%define-record :PEFExportedSymbolHashSlot (find-record-descriptor ':PEFExportedSymbolHashSlot))

(defconstant $kPEFHashSlotSymCountShift 18)
(defconstant $kPEFHashSlotFirstKeyMask #x3FFFF)
(defconstant $kPEFHashSlotMaxSymbolCount #x3FFF);   16,383

(defconstant $kPEFHashSlotMaxKeyIndex #x3FFFF)  ;  262,143

; #define PEFHashTableIndex(fullHashWord,hashTablePower)              ( ( (fullHashWord) ^ ((fullHashWord) >> (hashTablePower)) ) & ((1 << (hashTablePower)) - 1) )
; #define PEFHashSlotSymbolCount(countAndStart)   ((UInt32) ((countAndStart) >> kPEFHashSlotSymCountShift))
; #define PEFHashSlotFirstKey(countAndStart)      ((countAndStart) & kPEFHashSlotFirstKeyMask)
; #define PEFComposeExportedSymbolHashSlot(symbolCount,firstKey)              ( ( ((UInt32)(symbolCount)) << kPEFHashSlotSymCountShift ) | ( (UInt32)(firstKey) ) )
;  =========================================================================================== 
;  Exported Symbol Hash Key 
;  ------------------------ 
(defrecord PEFSplitHashWord
   (nameLength :UInt16)
   (hashValue :UInt16)
)

;type name? (%define-record :PEFSplitHashWord (find-record-descriptor ':PEFSplitHashWord))
(defrecord PEFExportedSymbolKey
   (:variant
   (
   (fullHashWord :UInt32)
   )
   (
   (splitHashWord :PEFSplitHashWord)
   )
   )
)

;type name? (%define-record :PEFExportedSymbolKey (find-record-descriptor ':PEFExportedSymbolKey))

(defconstant $kPEFHashLengthShift 16)
(defconstant $kPEFHashValueMask #xFFFF)
(defconstant $kPEFHashMaxLength #xFFFF)         ;  65,535

; #define PEFHashNameLength(fullHashWord) ((UInt32) ((fullHashWord) >> kPEFHashLengthShift))
; #define PEFHashValue(fullHashWord)  ((fullHashWord) & kPEFHashValueMask)
; #define PEFComposeFullHashWord(nameLength,hashValue)                ( ( ((UInt32)(nameLength)) << kPEFHashLengthShift ) | ( (UInt32)(hashValue) ) )
;  ---------------------------------------------------------------------------------------------------- 
;  The following function computes the full 32 bit hash word.                                           
;                                                                                                       
;       UInt32  PEFComputeHashWord  ( BytePtr   nameText,       // ! First "letter", not length byte.   
;                                     UInt32    nameLength )    // ! The text may be zero terminated.   
;       {                                                                                               
;           BytePtr charPtr     = nameText;                                                             
;           SInt32  hashValue   = 0;        // ! Signed to match old published algorithm.               
;           UInt32  length      = 0;                                                                    
;           UInt32  limit;                                                                              
;           UInt32  result;                                                                             
;           UInt8   currChar;                                                                           
;                                                                                                       
;           #define PseudoRotate(x)  ( ( (x) << 1 ) - ( (x) >> 16 ) )                                   
;                                                                                                       
;           for ( limit = nameLength; limit > 0; limit -= 1 ) {                                         
;               currChar = *charPtr++;                                                                  
;               if ( currChar == NULL ) break;                                                          
;               length += 1;                                                                            
;               hashValue = PseudoRotate ( hashValue ) ^ currChar;                                      
;           }                                                                                           
;                                                                                                       
;           result  = (length << kPEFHashLengthShift) |                                                 
;                     ((UInt16) ((hashValue ^ (hashValue >> 16)) & kPEFHashValueMask));                 
;                                                                                                       
;           return result;                                                                              
;                                                                                                       
;       }   // PEFComputeHashWord ()                                                                    
;  =========================================================================================== 
;  Exported Symbols 
;  ---------------- 
(defrecord PEFExportedSymbol
                                                ;  ! This structure is 10 bytes long and arrays are packed.
   (classAndName :UInt32)                       ;  A combination of class and name offset.
   (symbolValue :UInt32)                        ;  Typically the symbol's offset within a section.
   (sectionIndex :SInt16)                       ;  The index of the section, or pseudo-section, for the symbol.
)

;type name? (%define-record :PEFExportedSymbol (find-record-descriptor ':PEFExportedSymbol))
;  -------------------------------------------------------------------------------------------- 
;  The classAndName field of the PEFExportedSymbol type has the following bit field layout.     
;                                                                                               
;                                                                      3                        
;        0             7 8                                             1                        
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                       
;       | symbol class  | offset of symbol name in loader string table  |                       
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                       
;       |<-- 8 bits --->|<-- 24 bits ---------------------------------->|                       

(defconstant $kPEFExpSymClassShift 24)
(defconstant $kPEFExpSymNameOffsetMask #xFFFFFF)
(defconstant $kPEFExpSymMaxNameOffset #xFFFFFF) ;  16,777,215

; #define PEFExportedSymbolClass(classAndName)        ((UInt8) ((classAndName) >> kPEFExpSymClassShift))
; #define PEFExportedSymbolNameOffset(classAndName)   ((classAndName) & kPEFExpSymNameOffsetMask)
; #define PEFComposeExportedSymbol(class,nameOffset)                  ( ( ((UInt32)(class)) << kPEFExpSymClassShift ) | ( (UInt32)(nameOffset) ) )
;  Negative section indices indicate pseudo-sections.

(defconstant $kPEFAbsoluteExport -2)            ;  The symbol value is an absolute address.
;  The symbol value is the index of a reexported import.

(defconstant $kPEFReexportedImport -3)
;  =========================================================================================== 
;  Loader Relocations 
;  ================== 
;  -------------------------------------------------------------------------------------------- 
;  The relocations for a section are defined by a sequence of instructions for an abstract      
;  machine that is specifically geared to performing relocations commonly needed for the "CFM"  
;  code generation model.  These instructions occur in 16 bit chunks.  Most instructions have   
;  just a single chunk.  Instructions that are larger than 16 bits have an opcode and some of   
;  the operands in the first chunk, with other operands in following chunks.                    
;                                                                                               
;  ! Note that the multi-chunk relocations have separate "Compose" macros for each chunk.  The  
;  ! macros have the same basic name with a positional suffix of "_1st", "_2nd", etc.           

(def-mactype :PEFRelocChunk (find-mactype ':UInt16))
(defrecord PEFLoaderRelocationHeader
   (sectionIndex :UInt16)                       ;  Index of the section to be fixed up.
   (reservedA :UInt16)                          ;  Reserved, must be zero.
   (relocCount :UInt32)                         ;  Number of 16 bit relocation chunks.
   (firstRelocOffset :UInt32)                   ;  Offset of first relocation instruction.
)

;type name? (%define-record :PEFLoaderRelocationHeader (find-record-descriptor ':PEFLoaderRelocationHeader))
;  -------------------------------------------------------------------------------------------- 
;  ! Note that the relocCount field is the number of 16 bit relocation chunks, i.e. 1/2 the     
;  ! total number of bytes of relocation instructions.  While most relocation instructions are  
;  ! 16 bits long, some are longer so the number of complete relocation instructions may be     
;  ! less than the relocCount value.                                                            
;  ------------------------------------------------------------------------------------ 
;  The PEFRelocField macro is a utility for extracting relocation instruction fields.   
; #define PEFRFShift(offset,length)   (16 - ((offset) + (length)))
; #define PEFRFMask(length)           ((1 << (length)) - 1)
; #define PEFRelocField(chunk,offset,length)              ( ( (chunk) >> (16 - ((offset) + (length))) ) & ((1 << (length)) - 1) )
;  =========================================================================================== 
;  Basic Relocation Opcodes 
;  ------------------------ 
;  -------------------------------------------------------------------------------------------- 
;  The number of opcode bits varies from 2 to 7.  The enumeration and switch table given here   
;  are defined in terms of the most significant 7 bits of the first instruction chunk.  An      
;  instruction is decoded by using the most significant 7 bits as an index into the opcode      
;  table, which in turn contains appropriately masked forms of the most significant 7 bits.     
;  The macro PEFRelocBasicOpcode assumes a declaration of the form.                             
;                                                                                               
;       UInt8 kPEFRelocBasicOpcodes [kPEFRelocBasicOpcodeRange] = { PEFMaskedBasicOpcodes };    

(defconstant $kPEFRelocBasicOpcodeRange #x80)
; #define PEFRelocBasicOpcode(firstChunk) (kPEFRelocBasicOpcodes[(firstChunk)>>9])
;  -------------------------------------------------------------------------------------------- 
;  The relocation opcodes, clustered by major and minor groups.  The instructions within a      
;  cluster all have the same bit field layout.  The enumeration values use the high order 7     
;  bits of the relocation instruction.  Unused low order bits are set to zero.                  

(defconstant $kPEFRelocBySectDWithSkip 0)       ;  Binary: 00x_xxxx

(defconstant $kPEFRelocBySectC 32)              ;  Binary: 010_0000, group is "RelocRun"

(defconstant $kPEFRelocBySectD 33)              ;  Binary: 010_0001

(defconstant $kPEFRelocTVector12 34)            ;  Binary: 010_0010

(defconstant $kPEFRelocTVector8 35)             ;  Binary: 010_0011

(defconstant $kPEFRelocVTable8 36)              ;  Binary: 010_0100

(defconstant $kPEFRelocImportRun 37)            ;  Binary: 010_0101

(defconstant $kPEFRelocSmByImport 48)           ;  Binary: 011_0000, group is "RelocSmIndex"

(defconstant $kPEFRelocSmSetSectC 49)           ;  Binary: 011_0001

(defconstant $kPEFRelocSmSetSectD 50)           ;  Binary: 011_0010

(defconstant $kPEFRelocSmBySection 51)          ;  Binary: 011_0011

(defconstant $kPEFRelocIncrPosition 64)         ;  Binary: 100_0xxx

(defconstant $kPEFRelocSmRepeat 72)             ;  Binary: 100_1xxx

(defconstant $kPEFRelocSetPosition 80)          ;  Binary: 101_000x

(defconstant $kPEFRelocLgByImport 82)           ;  Binary: 101_001x

(defconstant $kPEFRelocLgRepeat 88)             ;  Binary: 101_100x

(defconstant $kPEFRelocLgSetOrBySection 90)     ;  Binary: 101_101x

(defconstant $kPEFRelocUndefinedOpcode #xFF)    ;  Used in masking table for all undefined values.

;  ---------------------------------------------------------------------------- 
;  The RelocLgSetOrBySection instruction has an additional 4 bits of subopcode  
;  beyond the 7 used by the dispatch table.  To be precise it has 6 plus 4 but  
;  the dispatch table ignores the 7th bit, so the subdispatch is on all 4 extra 
;  subopcode bits.                                                              

(defconstant $kPEFRelocLgBySectionSubopcode 0)  ;  Binary: 0000

(defconstant $kPEFRelocLgSetSectCSubopcode 1)   ;  Binary: 0001

(defconstant $kPEFRelocLgSetSectDSubopcode 2)   ;  Binary: 0010

; #define PEFRelocLgSetOrBySubopcode(chunk) (((chunk) >> 6) & 0x0F)
;  -------------------------------------------------------------------------------------------- 
;  The initial values for the opcode "masking" table.  This has the enumeration values from     
;  above with appropriate replications for "don't care" bits.  It is almost certainly shorter   
;  and faster to look up the masked value in a table than to use a branch tree.                 
; #define PEFMaskedBasicOpcodes                                                                                                                                                                                                                                                                               kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   /* 0x00 .. 0x03 */              kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   /* 0x04 .. 0x07 */              kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   /* 0x08 .. 0x0B */              kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   /* 0x0C .. 0x0F */                                                                                                                                                              kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   /* 0x10 .. 0x13 */              kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   /* 0x14 .. 0x17 */              kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   /* 0x18 .. 0x1B */              kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   kPEFRelocBySectDWithSkip,   /* 0x1C .. 0x1F */                                                                                                                                                              kPEFRelocBySectC,           kPEFRelocBySectD,           kPEFRelocTVector12,         kPEFRelocTVector8,          /* 0x20 .. 0x23 */              kPEFRelocVTable8,           kPEFRelocImportRun,         kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x24 .. 0x27 */                                                                                                                                                              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x28 .. 0x2B */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x2C .. 0x2F */                                                                                                                                                              kPEFRelocSmByImport,        kPEFRelocSmSetSectC,        kPEFRelocSmSetSectD,        kPEFRelocSmBySection,       /* 0x30 .. 0x33 */                                                                                                                                                              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x34 .. 0x37 */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x38 .. 0x3B */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x3C .. 0x3F */                                                                                                                                                              kPEFRelocIncrPosition,      kPEFRelocIncrPosition,      kPEFRelocIncrPosition,      kPEFRelocIncrPosition,      /* 0x40 .. 0x43 */              kPEFRelocIncrPosition,      kPEFRelocIncrPosition,      kPEFRelocIncrPosition,      kPEFRelocIncrPosition,      /* 0x44 .. 0x47 */                                                                                                                                                              kPEFRelocSmRepeat,          kPEFRelocSmRepeat,          kPEFRelocSmRepeat,          kPEFRelocSmRepeat,          /* 0x48 .. 0x4B */              kPEFRelocSmRepeat,          kPEFRelocSmRepeat,          kPEFRelocSmRepeat,          kPEFRelocSmRepeat,          /* 0x4C .. 0x4F */                                                                                                                                                              kPEFRelocSetPosition,       kPEFRelocSetPosition,       kPEFRelocLgByImport,        kPEFRelocLgByImport,        /* 0x50 .. 0x53 */                                                                                                                                                              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x54 .. 0x57 */                                                                                                                                                              kPEFRelocLgRepeat,          kPEFRelocLgRepeat,          kPEFRelocLgSetOrBySection,  kPEFRelocLgSetOrBySection,  /* 0x58 .. 0x5B */                                                                                                                                                              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x5C .. 0x5F */                                                                                                                                                              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x60 .. 0x63 */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x64 .. 0x67 */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x68 .. 0x6B */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x6C .. 0x6F */                                                                                                                                                              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x70 .. 0x73 */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x74 .. 0x77 */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   /* 0x78 .. 0x7B */              kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode,   kPEFRelocUndefinedOpcode    /* 0x7C .. 0x7F */
;  =========================================================================================== 
;  RelocBySectDWithSkip Instruction (DDAT) 
;  --------------------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocBySectDWithSkip" (DDAT) instruction has the following bit field layout.            
;                                                                                               
;                            1         1                                                        
;        0 1 2             9 0         5                                                        
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |0 0| skip count    | rel count |                                                       
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       | 2 |<-- 8 bits --->|<--  6 --->|                                                       
;                                                                                               
;  ! Note that the stored skip count and reloc count are the actual values!                     

(defconstant $kPEFRelocWithSkipMaxSkipCount #xFF)
(defconstant $kPEFRelocWithSkipMaxRelocCount 63)
; #define PEFRelocWithSkipSkipCount(chunk)    PEFRelocField ( (chunk), 2, 8 )
; #define PEFRelocWithSkipRelocCount(chunk)   PEFRelocField ( (chunk), 10, 6 )
; #define PEFRelocComposeWithSkip(skipCount,relocCount)               ( 0x0000 | (((UInt16)(skipCount)) << 6) | ((UInt16)(relocCount)) )
;  =========================================================================================== 
;  RelocRun Group (CODE, DATA, DESC, DSC2, VTBL, SYMR) 
;  --------------------------------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocRun" group includes the "RelocBySectC" (CODE), "RelocBySectD" (DATA),              
;  "RelocTVector12" (DESC), "RelocTVector8" (DSC2), "RelocVTable8" (VTBL), and                  
;  "RelocImportRun" (SYMR) instructions.  This group has the following bit field layout.        
;                                                                                               
;                                      1                                                        
;        0   2 3     6 7               5                                                        
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |0 1 0| subop.| run length      |                                                       
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |  3  |<- 4 ->|<-- 9 bits ----->|                                                       
;                                                                                               
;  ! Note that the stored run length is the actual value minus 1, but the macros deal with the  
;  ! actual value!                                                                              

(defconstant $kPEFRelocRunMaxRunLength #x200)
; #define PEFRelocRunSubopcode(chunk) PEFRelocField ( (chunk), 3, 4 )
; #define PEFRelocRunRunLength(chunk) (PEFRelocField ( (chunk), 7, 9 ) + 1)
; #define PEFRelocComposeRun(subopcode,runLength)             ( 0x4000 | (((UInt16)(subopcode)) << 9) | ((UInt16)((runLength)-1)) )
; #define PEFRelocComposeBySectC(runLength)       PEFRelocComposeRun ( 0, (runLength) )
; #define PEFRelocComposeBySectD(runLength)       PEFRelocComposeRun ( 1, (runLength) )
; #define PEFRelocComposeTVector12(runLength)     PEFRelocComposeRun ( 2, (runLength) )
; #define PEFRelocComposeTVector8(runLength)      PEFRelocComposeRun ( 3, (runLength) )
; #define PEFRelocComposeVTable8(runLength)       PEFRelocComposeRun ( 4, (runLength) )
; #define PEFRelocComposeImportRun(runLength)     PEFRelocComposeRun ( 5, (runLength) )
;  =========================================================================================== 
;  RelocSmIndex Group (SYMB, CDIS, DTIS, SECN) 
;  ------------------------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocSmIndex" group includes the "RelocSmByImport" (SYMB), "RelocSmSetSectC" (CDIS),    
;  "RelocSmSetSectD" (DTIS) and "RelocSmBySection" (SECN) instructions.  This group has the     
;  following bit field layout.                                                                  
;                                                                                               
;                                      1                                                        
;        0   2 3     6 7               5                                                        
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |0 1 1| subop.| index           |                                                       
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |  3  |<- 4 ->|<-- 9 bits ----->|                                                       
;                                                                                               
;  ! Note that the stored index is the actual value!                                            

(defconstant $kPEFRelocSmIndexMaxIndex #x1FF)
; #define PEFRelocSmIndexSubopcode(chunk) PEFRelocField ( (chunk), 3, 4 )
; #define PEFRelocSmIndexIndex(chunk)     PEFRelocField ( (chunk), 7, 9 )
; #define PEFRelocComposeSmIndex(subopcode,index)             ( 0x6000 | (((UInt16)(subopcode)) << 9) | ((UInt16)(index)) )
; #define PEFRelocComposeSmByImport(index)    PEFRelocComposeSmIndex ( 0, (index) )
; #define PEFRelocComposeSmSetSectC(index)    PEFRelocComposeSmIndex ( 1, (index) )
; #define PEFRelocComposeSmSetSectD(index)    PEFRelocComposeSmIndex ( 2, (index) )
; #define PEFRelocComposeSmBySection(index)   PEFRelocComposeSmIndex ( 3, (index) )
;  =========================================================================================== 
;  RelocIncrPosition Instruction (DELT) 
;  ------------------------------------ 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocIncrPosition" (DELT) instruction has the following bit field layout.               
;                                                                                               
;                                      1                                                        
;        0     3 4                     5                                                        
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |1 0 0 0| offset                |                                                       
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |<- 4 ->|<-- 12 bits ---------->|                                                       
;                                                                                               
;  ! Note that the stored offset is the actual value minus 1, but the macros deal with the      
;  ! actual value!                                                                              

(defconstant $kPEFRelocIncrPositionMaxOffset #x1000)
; #define PEFRelocIncrPositionOffset(chunk)   (PEFRelocField ( (chunk), 4, 12 ) + 1)
; #define PEFRelocComposeIncrPosition(offset)             ( 0x8000 | ((UInt16)((offset)-1)) )
;  =========================================================================================== 
;  RelocSmRepeat Instruction (RPT) 
;  ------------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocSmRepeat" (RPT) instruction has the following bit field layout.                    
;                                                                                               
;                                      1                                                        
;        0     3 4     7 8             5                                                        
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |1 0 0 1| chnks | repeat count  |                                                       
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                                                       
;       |<- 4 ->|<- 4 ->|<-- 8 bits --->|                                                       
;                                                                                               
;  ! Note that the stored chunk count and repeat count are the actual values minus 1, but the   
;  ! macros deal with the actual values!                                                        

(defconstant $kPEFRelocSmRepeatMaxChunkCount 16)
(defconstant $kPEFRelocSmRepeatMaxRepeatCount #x100)
; #define PEFRelocSmRepeatChunkCount(chunk)   (PEFRelocField ( (chunk), 4, 4 ) + 1)
; #define PEFRelocSmRepeatRepeatCount(chunk)  (PEFRelocField ( (chunk), 8, 8 ) + 1)
; #define PEFRelocComposeSmRepeat(chunkCount,repeatCount)             ( 0x9000 | ((((UInt16)(chunkCount))-1) << 8) | (((UInt16)(repeatCount))-1) )
;  =========================================================================================== 
;  RelocSetPosition Instruction (LABS) 
;  ----------------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocSetPosition" (LABS) instruction has the following bit field layout.                
;                                                                                               
;                                      1                                   1                    
;        0         5 6                 5     0                             5                    
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                   
;       |1 0 1 0 0 0| offset (high)     |   | offset (low)                  |                   
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                   
;       |<-- 6 ---->|<-- 10 bits ------>|   |<-- 16 bits ------------------>|                   
;                                                                                               
;  ! Note that the stored offset is the actual value!                                           

(defconstant $kPEFRelocSetPosMaxOffset #x3FFFFFF);  67,108,863

; #define PEFRelocSetPosOffsetHigh(chunk) PEFRelocField ( (chunk), 6, 10 )
; #define PEFRelocSetPosFullOffset(firstChunk,secondChunk)                ( ((((UInt32)(firstChunk)) & 0x03FF) << 16) | ((UInt32)(secondChunk)) )
; #define PEFRelocComposeSetPosition_1st(fullOffset)              ( 0xA000 | ((UInt16) (((UInt32)(fullOffset)) >> 16) ) )
; #define PEFRelocComposeSetPosition_2nd(fullOffset)              ( (UInt16) ((UInt32)(fullOffset) & 0xFFFF) )
;  =========================================================================================== 
;  RelocLgByImport Instruction (LSYM) 
;  ---------------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocLgByImport" (LSYM) instruction has the following bit field layout.                 
;                                                                                               
;                                      1                                   1                    
;        0         5 6                 5     0                             5                    
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                   
;       |1 0 1 0 0 1| index (high)      |   | index (low)                   |                   
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                   
;       |<-- 6 ---->|<-- 10 bits ------>|   |<-- 16 bits ------------------>|                   
;                                                                                               
;  ! Note that the stored offset is the actual value!                                           

(defconstant $kPEFRelocLgByImportMaxIndex #x3FFFFFF);  67,108,863

; #define PEFRelocLgByImportIndexHigh(chunk)  PEFRelocField ( (chunk), 6, 10 )
; #define PEFRelocLgByImportFullIndex(firstChunk,secondChunk)             ( ((((UInt32)(firstChunk)) & 0x03FF) << 16) | ((UInt32)(secondChunk)) )
; #define PEFRelocComposeLgByImport_1st(fullIndex)                ( 0xA400 | ((UInt16) (((UInt32)(fullIndex)) >> 16) ) )
; #define PEFRelocComposeLgByImport_2nd(fullIndex)                ( (UInt16) ((UInt32)(fullIndex) & 0xFFFF) )
;  =========================================================================================== 
;  RelocLgRepeat Instruction (LRPT) 
;  -------------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocLgRepeat" (LRPT) instruction has the following bit field layout.                   
;                                                                                               
;                            1         1                                   1                    
;        0         5 6     9 0         5     0                             5                    
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                   
;       |1 0 1 1 0 0| chnks | rpt (high)|   | repeat count (low)            |                   
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                   
;       |<--  6 --->|<- 4 ->|<--  6 --->|   |<-- 16 bits ------------------>|                   
;                                                                                               
;  ! Note that the stored chunk count is the actual value minus 1, but the macros deal with     
;  ! the actual value!  The stored repeat count is the actual value!                            

(defconstant $kPEFRelocLgRepeatMaxChunkCount 16)
(defconstant $kPEFRelocLgRepeatMaxRepeatCount #x3FFFFF);  4,194,303

; #define PEFRelocLgRepeatChunkCount(chunk)       (PEFRelocField ( (chunk), 6, 4 ) + 1)
; #define PEFRelocLgRepeatRepeatCountHigh(chunk)  PEFRelocField ( (chunk), 10, 6 )
; #define PEFRelocLgRepeatFullRepeatCount(firstChunk,secondChunk)             ( ((((UInt32)(firstChunk)) & 0x003F) << 16) | ((UInt32)(secondChunk)) )
; #define PEFRelocComposeLgRepeat_1st(chunkCount,fullRepeatCount)             ( 0xB000 | ((((UInt16)(chunkCount))-1) << 6) | ((UInt16) (((UInt32)(fullRepeatCount)) >>16 ) ) )
; #define PEFRelocComposeLgRepeat_2nd(chunkCount,fullRepeatCount)             ( (UInt16) ((UInt32)(fullRepeatCount) & 0xFFFF) )
;  =========================================================================================== 
;  RelocLgSetOrBySection Group (LSEC) 
;  ---------------------------------- 
;  -------------------------------------------------------------------------------------------- 
;  The "RelocLgSetOrBySection" (LSEC) instruction is a group including the "RelocLgBySection",  
;  "RelocLgSetSectC" and "RelocLgSetSectD" instructions.  This group has the following bit      
;  field layout.                                                                                
;                                                                                               
;                            1         1                                   1                    
;        0         5 6     9 0         5     0                             5                    
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                   
;       |1 0 1 1 0 1| subop | idx (high)|   | index (low)                   |                   
;       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+                   
;       |<--  6 --->|<- 4 ->|<--  6 --->|   |<-- 16 bits ------------------>|                   
;                                                                                               
;  ! Note that the stored index is the actual value!                                            

(defconstant $kPEFRelocLgSetOrBySectionMaxIndex #x3FFFFF);  4,194,303

; #define PEFRelocLgSetOrBySectionSubopcode(chunk)    PEFRelocField ( (chunk), 6, 4 )
; #define PEFRelocLgSetOrBySectionIndexHigh(chunk)    PEFRelocField ( (chunk), 10, 6 )
; #define PEFRelocLgSetOrBySectionFullIndex(firstChunk,secondChunk)               ( ((((UInt32)(firstChunk)) & 0x003F) << 16) | ((UInt32)(secondChunk)) )
; #define PEFRelocComposeLgSetOrBySection_1st(subopcode,fullIndex)                ( 0xB400 | (((UInt16)(subopcode)) << 6) | ((UInt16) (((UInt32)(fullIndex)) >> 16) ) )
; #define PEFRelocComposeLgSetOrBySection_2nd(subopcode,fullIndex)                ( (UInt16) ((UInt32)(fullIndex) & 0xFFFF) )
; #define PEFRelocComposeLgBySection(fullIndex)   PEFRelocComposeLgSetOrBySection ( 0x00, (fullIndex) )
; #define PEFRelocComposeLgSetSectC(fullIndex)    PEFRelocComposeLgSetOrBySection ( 0x01, (fullIndex) )
; #define PEFRelocComposeLgSetSectD(fullIndex)    PEFRelocComposeLgSetOrBySection ( 0x02, (fullIndex) )
;  ======================================================================================== 
;  ======================================================================================== 
;  ======================================================================================== 
;  Vector Library Declarations 
;  =========================== 
;  -------------------------------------------------------------------------------------------- 
;  Mac OS X has special "vector" and "bridge" libraries to allow CFM managed clients to import  
;  from the dyld managed implementation libraries.  The vector libraries are typically embedded 
;  within their respective implementation libraries.  Even if standalone, the vector libraries  
;  are themselves normal dyld managed libraries.  The vector libraries contain an export symbol 
;  table and pointers to the actual implementations.  For functions, these pointers serve as    
;  the PMacCG TVectors.  Because the dyld libraries are not part of the CFM search, we need a   
;  separate library for CFM to find that then indicates where the vector library is.  These are 
;  the bridge libraries.  They are tiny, just the container header and container strings parts. 
;                                                                                               
;  Since the vector library is embedded in a Mach-O dylib, we use dyld services to obtain the   
;  base address for the main portion and the exported symbol portion.  The binding pointers are 
;  found through offsets in the exported symbol records.                                        
;                                                                                               
;       +-----------------------------------+           <-- containerOrigin ------------+       
;       |       Container Header            |   76 bytes                                |       
;       |-----------------------------------|           <-- + containerStringsOffset ---|       
;       |       Container Strings           |                                           |       
;       |-----------------------------------|           <-- + exportHashOffset ---------+       
;       |       Export Hash Slot 0          |   4 bytes each                            |       
;       |...................................|                                           |       
;       |           - - -                   |                                           |       
;       |...................................|                                           |       
;       |       Export Hash Slot h-1        |                                           |       
;       |-----------------------------------|           <-- + exportKeyOffset ----------+       
;       |       Export Symbol Key 0         |   4 bytes each                            |       
;       |...................................|   Order must match the exported symbols   |       
;       |           - - -                   |                                           |       
;       |...................................|                                           |       
;       |       Export Symbol Key e-1       |                                           |       
;       |-----------------------------------|           <-- + exportNamesOffset --------+       
;       |       Export Names                |                                           |       
;       |-----------------------------------|                                           |       
;                                               (Disjoint parts)                        |       
;       |-----------------------------------|           <-- + exportSymbolOffset -------+       
;       |       Export Symbol 0             |   8 bytes each                                    
;       |...................................|   Order must match the export keys                
;       |           - - -                   |                                                   
;       |...................................|                                                   
;       |       Export Symbol e-1           |                                                   
;       +-----------------------------------+                                                   
;                                               (Disjoint parts)                                
;       |-----------------------------------|                                                   
;       |       Binding Pointer 0           |   4 bytes each                                    
;       |-----------------------------------|   Possibly disjoint, order does not matter        
;       |           - - -                   |                                                   
;       |-----------------------------------|                                                   
;       |       Binding Pointer e-1         |                                                   
;       +-----------------------------------+                                                   
(defrecord XLibContainerHeader
                                                ;  Structural description fields:
   (tag1 :OSType)                               ;  Must contain 'ðMac'.
   (tag2 :OSType)                               ;  Must contain 'vLib' or 'bLib'.
   (currentFormat :UInt32)                      ;  The version of XLib types used to create this container.
   (containerStringsOffset :UInt32)             ;  Container offset of the container string table.
   (exportHashOffset :UInt32)                   ;  Offset of the export hash table.
   (exportKeyOffset :UInt32)                    ;  Offset of the export key table.
   (exportSymbolOffset :UInt32)                 ;  Offset of the export symbol table.
   (exportNamesOffset :UInt32)                  ;  Offset of the export names.
   (exportHashTablePower :UInt32)               ;  Export hash table size as log 2.  (Log2('h'))
   (exportedSymbolCount :UInt32)                ;  Number of exported symbols.  ('e')
                                                ;  Fragment description fields:
   (fragNameOffset :UInt32)                     ;  The offset of the fragment name in the container string table.
   (fragNameLength :UInt32)                     ;  The length of the fragment name in the container string table.
   (dylibPathOffset :UInt32)                    ;  The offset of the dyld "install name" in the container string table.
   (dylibPathLength :UInt32)                    ;  The length of the dyld "install name" in the container string table.
   (cpuFamily :OSType)                          ;  The ISA for code sections.  Constants in CodeFragments.h.
   (cpuModel :OSType)                           ;  Specific CPU model if applicable.
   (dateTimeStamp :UInt32)                      ;  Mac format creation stamp.
   (currentVersion :UInt32)                     ;  Current version number for the code fragment.
   (oldDefVersion :UInt32)                      ;  Old definition version number for the code fragment.
   (oldImpVersion :UInt32)                      ;  Old implementation version number for the code fragment.
)

;type name? (%define-record :XLibContainerHeader (find-record-descriptor ':XLibContainerHeader))
; 'ðMac' 

(defconstant $kXLibTag1 #xF04D6163)             ;  For non-Apple compilers: 0xF04D6163.

(defconstant $kVLibTag2 :|VLib|)                ;  For non-Apple compilers: 0x564C6962.

(defconstant $kBLibTag2 :|BLib|)                ;  For non-Apple compilers: 0x424C6962.

(defconstant $kXLibVersion 1)

(%define-record :XLibExportedSymbolHashSlot (find-record-descriptor ':PEFExportedSymbolHashSlot))

(%define-record :XLibExportedSymbolKey (find-record-descriptor ':PEFExportedSymbolKey))
(defrecord XLibExportedSymbol
   (classAndName :UInt32)                       ;  A combination of class and name offset.
   (bpOffset :UInt32)                           ;  Container offset of the export's dyld binding pointer.
)

;type name? (%define-record :XLibExportedSymbol (find-record-descriptor ':XLibExportedSymbol))
;  =========================================================================================== 
; #ifndef IncludePEF2Declarations
(defconstant $IncludePEF2Declarations 0)
; #define IncludePEF2Declarations 0

; #endif  /* !defined(IncludePEF2Declarations) */


; #if IncludePEF2Declarations
#|                                              ;  ======================================================================================== 
;  ======================================================================================== 
;  ======================================================================================== 
;  PEF2 Declarations 
;  ================= 
;  -------------------------------------------------------------------------------------------- 
;  PEF2 is a follow-on to the original PEF, incorporating changes that would break backward     
;  compatibility.  The primary motivations for PEF2 are to incorporate new features cleanly, to 
;  relax some physical limitations, and to provide a more explicit path for future growth.      
;                                                                                               
;  PEF2 is very similar to PEF, it is possible for any PEF container to be mechanically         
;  converted to PEF2.  The converse is not necessarily true, containers that use new features   
;  of PEF2 might not be convertable to PEF.                                                     
;                                                                                               
;  One difference from PEF is that PEF2 has no implicit ordering, e.g. the section headers do   
;  not necessarily immediately follow the container header.  Explicit offsets and lengths are   
;  provided for all portions of the container so that tools can continue to parse PEF2 as new   
;  versions of it are produced in the future.  The following overall layout is suggested for    
;  locality of reference in typical usage with a packed data image:                             
;                                                                                               
;           +-----------------------------------+                                               
;           |       Container Header            |                                               
;           +-----------------------------------+                                               
;           |       Section 0 header            |                                               
;           |...................................|                                               
;           |           - - - -                 |                                               
;           |...................................|                                               
;           |       Section n-1 header          |                                               
;           +-----------------------------------+                                               
;           |       Container String Table      |                                               
;           +-----------------------------------+                                               
;           |       Loader section contents     |                                               
;           +-----------------------------------+                                               
;           |       Packed data contents        |                                               
;           +-----------------------------------+                                               
;           |       Code section contents       |                                               
;           +-----------------------------------+                                               
;                                                                                               
;  If unpacked data is used for prebinding with copy-on-write mapping, the unpacked data should 
;  follow the code section.                                                                     
;                                                                                               
;  Note that the rule regarding instantiated sections preceeding noninstantiated sections only  
;  applies to the section headers, not the section contents.  Thus it is perfectly fine for the 
;  loader section contents to be first.                                                         
;                                                                                               
;  The container string table holds the name of the fragment and the names of the sections.     
;  The first 4 bytes of the container string table must be zero and always present.  An offset  
;  of zero into the container string table is considered a null name.  Actual names are stored  
;  as a PEF-style 32 bit hashword followed by the text of the name.  The encoding of the text   
;  is given by the stringEncoding field of the container header.  The hashword is computed from 
;  the encoded name as a string of bytes.  The length in the hashword is the number of bytes in 
;  the encoded name, not the number of logical characters.                                      
;  =========================================================================================== 
;  Container Header 
;  ================ 
(defrecord PEF2ContainerHeader
                                                ;  Structural fields:
   (tag1 :OSType)                               ;  Must contain 'Joy!'.
   (tag2 :OSType)                               ;  Must contain 'PEF '.
   (currentFormat :UInt32)                      ;  The version of PEF2 used to create this container.
   (oldestFormat :UInt32)                       ;  Oldest compatible container handler.
   (containerHeaderSize :UInt32)                ;  The size of this header in bytes.
   (containerLength :UInt32)                    ;  The total length of the container in bytes.
   (checksum :UInt32)                           ;  A checksum for the entire container.
   (sectionHeadersOffset :UInt32)               ;  Container offset of the first section header.
   (sectionHeaderSize :UInt32)                  ;  The size in bytes of each section header.
   (totalSectionCount :UInt32)                  ;  Total number of section headers.
   (instSectionCount :UInt32)                   ;  Number of instantiated sections.
   (loaderSectionIndex :UInt32)                 ;  Index of the section containing runtime loader tables.
   (containerStringsOffset :UInt32)             ;  Container offset of the container string table.
   (containerStringsLength :UInt32)             ;  Length in bytes of the container string table.
   (options :UInt32)                            ;  Array of 32 option bits.
   (preferredAddress :UInt32)                   ;  Preferred container address, 0xFFFFFFFF indicates no preference.
   (alignment :UInt8)                           ;  Required container alignment as LOG 2.
   (stringEncoding :UInt8)                      ;  The encoding for all strings in the container.
   (reservedA :UInt16)                          ;  Reserved, must be written as zero.
   (reservedB :UInt32)                          ;  Reserved, must be written as zero.
   (reservedC :UInt32)                          ;  Reserved, must be written as zero.
                                                ;  Fragment description fields:
   (nameOffset :UInt32)                         ;  The offset of the name in the container string table.
   (architecture :OSType)                       ;  The ISA for code sections.  Constants in CodeFragments.h.
   (dateTimeStamp :UInt32)                      ;  Macintosh format creation/modification stamp.
   (currentVersion :UInt32)                     ;  Current version number for the code fragment.
   (oldDefVersion :UInt32)                      ;  Old definition version number for the code fragment.
   (oldImpVersion :UInt32)                      ;  Old implementation version number for the code fragment.
   (reservedD :UInt32)                          ;  Reserved, must be written as zero.
   (reservedE :UInt32)                          ;  Reserved, must be written as zero.
)

;type name? (def-mactype :PEF2ContainerHeader (find-mactype ':PEF2ContainerHeader))

(defconstant $kPEF2Tag1 :|Joy!|)
(defconstant $kPEF2Tag2 :|PEF |)                ;  For non-Apple compilers: 0x50656620.

(defconstant $kPEF2CurrentFormat 2)             ;  ! There is no version 0 or 1.

(defconstant $kPEF2OldestHandler 2)
;  Values for the options field.

(defconstant $kPEF2IsReexportLibraryMask 1)     ;  This fragment does nothing but reexport imports.

(defconstant $kPEF2IsGlueLibraryMask 2)         ;  A special form of import library that provides a glue layer.

;  Values for the stringEncoding field.

(defconstant $kPEF2StringsAreASCII 0)
(defconstant $kPEF2StringsAreUnicode 1)
;  =========================================================================================== 
;  Section Headers 
;  =============== 
(defrecord PEF2SectionHeader
   (nameOffset :UInt32)                         ;  Offset of the name within the container string table.
   (presumedAddress :UInt32)                    ;  Presumed address, affects relocations.
   (totalLength :UInt32)                        ;  Fully expanded size in bytes of the section contents.
   (unpackedLength :UInt32)                     ;  Size in bytes of the "initialized" part of the contents.
   (containerLength :UInt32)                    ;  Size in bytes of the raw data in the container.
   (containerOffset :UInt32)                    ;  Offset of section's raw data within the container.
   (options :UInt32)                            ;  Array of 32 option bits.
   (shareKind :UInt8)                           ;  Sharing level, if a writeable section.
   (alignment :UInt8)                           ;  Required alignment, expressed as log 2.
   (reservedA :UInt16)                          ;  Reserved, must be written as zero.
   (reservedB :UInt32)                          ;  Reserved, must be written as zero.
   (reservedC :UInt32)                          ;  Reserved, must be written as zero.
)

;type name? (def-mactype :PEF2SectionHeader (find-mactype ':PEF2SectionHeader))
;  Masks for instantiated section options.
;  Bits that define the preparation and usage of the section's contents.

(defconstant $kPEF2SectionHasCodeMask 1)        ;  Affects cache flushing operations.

(defconstant $kPEF2SectionIsWriteableMask 2)    ;  Affects MMU access.

(defconstant $kPEF2SectionHasRelocationsMask 4) ;  The section has runtime relocations.

(defconstant $kPEF2SectionContentsArePackedMask #x100);  The raw data is compressed.

(defconstant $kPEF2SectionNoZeroFillMask #x200) ;  "Uninit" part is not zero filled.

(defconstant $kPEF2SectionResidentMask #x400)   ;  The section should be RAM resident.
;  Bits that describe higher level semantics.

(defconstant $kPEF2SectionFollowsPriorMask #x10000);  Raw data is related to prior section.

(defconstant $kPEF2SectionPrecedesNextMask #x20000);  Raw data is related to next section.

(defconstant $kPEF2SectionHasLoaderTablesMask #x1000000)
(defconstant $kPEF2SectionHasDebugTablesMask #x2000000)
(defconstant $kPEF2SectionHasExceptionTablesMask #x4000000)
(defconstant $kPEF2SectionHasTracebackTablesMask #x8000000)
;  Values for the shareKind field.

(defconstant $kPEF2PrivateShare 0)              ;  Shared only within a "private" closure.

(defconstant $kPEF2ProcessShare 1)              ;  Shared within a single process.

(defconstant $kPEF2GlobalShare 4)               ;  Shared across the entire system.

(defconstant $kPEF2ProtectedShare 5)            ;  Readable across the entire system, writeable only to privileged code.

;  =========================================================================================== 
;  Loader Section 
;  ============== 
;  -------------------------------------------------------------------------------------------- 
;  The PEF2 loader section is very similar to that of PEF.  The following overall layout is     
;  not required, but suggested for typical locality of reference.  The loader header contains   
;  explicit offsets and sizes for each of the subsections.                                      
;                                                                                               
;           +-----------------------------------+                                               
;           |       Loader Info Header          |                                               
;           |-----------------------------------|                                               
;           |       Imported Library 0          |                                               
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Imported Library l-1        |                                               
;           |-----------------------------------|                                               
;           |       Imported Symbol 0           |                                               
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Imported Symbol i-1         |                                               
;           |-----------------------------------|                                               
;           |       Loader Name Table           |                                               
;           |-----------------------------------|                                               
;           |       Export Hash Slot 0          |                                               
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Export Hash Slot h-1        |                                               
;           |-----------------------------------|                                               
;           |       Exported Symbol Key 0       |                                               
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Exported Symbol Key e-1     |                                               
;           |-----------------------------------|                                               
;           |       Exported Symbol 0           |                                               
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Exported Symbol e-1         |                                               
;           |-----------------------------------|                                               
;           |       Relocation Header 0         |                                               
;           |...................................|                                               
;           |           - - -                   |                                               
;           |...................................|                                               
;           |       Relocation Header r-1       |                                               
;           |-----------------------------------|                                               
;           |       Relocation Instructions     |                                               
;           +-----------------------------------+                                               
(defrecord PEF2LoaderInfoHeader
   (headerSize :UInt32)                         ;  Size in bytes of the loader info header.
   (options :UInt32)                            ;  An array of 32 option bits.
   (mainSection :SInt32)                        ;  Section containing the main symbol, -1 => none.
   (mainOffset :UInt32)                         ;  Offset of main symbol.
   (initSection :SInt32)                        ;  Section containing the init routine's TVector, -1 => none.
   (initOffset :UInt32)                         ;  Offset of the init routine's TVector.
   (termSection :SInt32)                        ;  Section containing the term routine's TVector, -1 => none.
   (termOffset :UInt32)                         ;  Offset of the term routine's TVector.
   (notifySection :SInt32)                      ;  Section containing the notification routine's TVector, -1 => none.
   (notifyOffset :UInt32)                       ;  Offset of the notification routine's TVector.
   (importedLibrariesOffset :UInt32)            ;  Offset of the imported library table.
   (importedLibrarySize :UInt32)                ;  The size in bytes of an imported library entry.
   (importedLibraryCount :UInt32)               ;  Number of imported libraries. ('l')
   (importedSymbolsOffset :UInt32)              ;  Offset of the imported symbol table.
   (importedSymbolSize :UInt32)                 ;  The size in bytes of an imported symbol entry.
   (totalImportedSymbolCount :UInt32)           ;  Total number of imported symbols.  ('s')
   (loaderNamesOffset :UInt32)                  ;  Offset of the loader name table.
   (loaderNamesLength :UInt32)                  ;  Total number of bytes in the loader name table.
   (exportHashTableOffset :UInt32)              ;  Offset of the export hash slot table.
   (exportHashTablePower :UInt8)                ;  Hash slot count as log 2.
   (reservedA :UInt8)                           ;  Reserved, must be zero.
   (reservedB :UInt16)                          ;  Reserved, must be zero.
   (exportedKeysOffset :UInt32)                 ;  Offset of the exported symbol key table.
   (exportedSymbolsOffset :UInt32)              ;  Offset of the exported symbol table.
   (exportedSymbolSize :UInt32)                 ;  The size in bytes of an exported symbol entry.
   (exportedSymbolCount :UInt32)                ;  Number of exported symbols. ('e')
   (relocHeadersOffset :UInt32)                 ;  Offset of the relocation headers.
   (relocHeaderCount :UInt32)                   ;  Number of sections with relocations.
   (relocInstrOffset :UInt32)                   ;  Offset of the relocation instructions.
   (relocInstrLength :UInt32)                   ;  Total number of bytes of relocation instructions.
   (reservedC :UInt32)                          ;  Reserved, must be zero.
   (reservedD :UInt32)                          ;  Reserved, must be zero.
)

;type name? (def-mactype :PEF2LoaderInfoHeader (find-mactype ':PEF2LoaderInfoHeader))
;  Masks for the option bits.

(defconstant $kPEF2LdrInfoLargeImpSymMask 1)    ;  Selects large imported symbol entries.

(defconstant $kPEF2LdrInfoLargeExpSymMask 2)    ;  Selects large exported symbol entries.

(defconstant $kPEF2LdrInfoLargeExpHashMask 4)   ;  Selects large export hash table entries.

;  =========================================================================================== 
;  Imports and Exports 
;  ------------------- 
;  -------------------------------------------------------------------------------------------- 
;  Imports and exports in PEF2 have both small and large representations.  The small form is    
;  identical to original PEF.  The large form removes count limitations by having full 32 bit   
;  offsets.  The import and export name tables have the same representation as the container    
;  string table, four bytes of zero at the start followed by pairs of 32 bit hashwords and      
;  the names in the appropriate encoding.                                                       
(defrecord PEF2ImportedLibrary
   (nameOffset :UInt32)                         ;  Imported name table offset of library's name.
   (oldImpVersion :UInt32)                      ;  Oldest compatible implementation version.
   (currentVersion :UInt32)                     ;  Current version at build time.
   (importedSymbolCount :UInt32)                ;  Imported symbol count for this library.
   (firstImportedSymbol :UInt32)                ;  Index of first imported symbol from this library.
   (options :UInt32)                            ;  Option bits for this library.
   (reservedA :UInt32)                          ;  Reserved, must be zero.
)

;type name? (def-mactype :PEF2ImportedLibrary (find-mactype ':PEF2ImportedLibrary))
;  Bits for the PEF2ImportedLibrary options field.

(defconstant $kPEF2WeakImportLibMask 64)        ;  The imported library is allowed to be missing.

(defconstant $kPEF2InitLibBeforeMask #x80)      ;  The imported library must be initialized first.


(%define-record :PEF2SmImportedSymbol (find-record-descriptor ':PEFImportedSymbol))
; #define PEF2ComposeSmImportedSymbol PEFComposeImportedSymbol
(defrecord PEF2LgImportedSymbol
   (symClass :UInt8)
   (flags :UInt8)
   (reservedA :UInt16)
   (nameOffset :UInt32)
   (versionPair :UInt32)
   (reservedB :UInt32)
)

;type name? (def-mactype :PEF2LgImportedSymbol (find-mactype ':PEF2LgImportedSymbol))

(%define-record :PEF2SmExportedSymbolHashSlot (find-record-descriptor ':PEFExportedSymbolHashSlot))

(%define-record :PEF2ExportedSymbolKey (find-record-descriptor ':PEFExportedSymbolKey))

(%define-record :PEF2SmExportedSymbol (find-record-descriptor ':PEFExportedSymbol))
; #define PEF2ComposeSmExportedSymbol PEFComposeExportedSymbol
(defrecord PEF2LgExportedSymbolHashSlot
   (chainCount :UInt32)
   (chainOffset :UInt32)
)

;type name? (def-mactype :PEF2LgExportedSymbolHashSlot (find-mactype ':PEF2LgExportedSymbolHashSlot))
(defrecord PEF2LgExportedSymbol
   (symClass :UInt8)
   (flags :UInt8)
   (reservedA :UInt16)
   (nameOffset :UInt32)
   (versionPair :UInt32)
   (sectionIndex :SInt32)
   (sectionOffset :UInt32)
   (reservedB :UInt32)
)

;type name? (def-mactype :PEF2LgExportedSymbol (find-mactype ':PEF2LgExportedSymbol))
;  =========================================================================================== 
;  Loader Relocations 
;  ================== 
;  -------------------------------------------------------------------------------------------- 
;  The relocation header differs slightly in PEF2.  The relocation instructions identical.      
(defrecord PEF2LoaderRelocationHeader
   (sectionIndex :UInt32)                       ;  Index of the section to be fixed up.
   (relocLength :UInt32)                        ;  Number of bytes of relocation items.
   (firstRelocOffset :UInt32)                   ;  Byte offset of first relocation instruction.
   (reservedA :UInt32)                          ;  Reserved, must be zero.
)

;type name? (def-mactype :PEF2LoaderRelocationHeader (find-mactype ':PEF2LoaderRelocationHeader))
;  =========================================================================================== 
 |#

; #endif  /* IncludePEF2Declarations */

; #pragma options align=reset

; #endif /* __PEFBINARYFORMAT__ */


(provide-interface "PEFBinaryFormat")