(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:loader.h"
; at Sunday July 2,2006 7:30:18 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _MACHO_LOADER_H_
; #define _MACHO_LOADER_H_
; 
;  * This file describes the format of mach object files.
;  
; 
;  * <mach/machine.h> is needed here for the cpu_type_t and cpu_subtype_t types
;  * and contains the constants for the possible values of these types.
;  

(require-interface "mach/machine")
; 
;  * <mach/vm_prot.h> is needed here for the vm_prot_t type and contains the 
;  * constants that are or'ed together for the possible values of this type.
;  

(require-interface "mach/vm_prot")
; 
;  * <machine/thread_status.h> is expected to define the flavors of the thread
;  * states and the structures of those flavors for each machine.
;  

(require-interface "mach/machine/thread_status")

(require-interface "architecture/byte_order")
; 
;  * The mach header appears at the very beginning of the object file.
;  
(defrecord mach_header
   (magic :UInt32)
                                                ;  mach magic number identifier 
   (cputype :signed-long)
                                                ;  cpu specifier 
   (cpusubtype :signed-long)
                                                ;  machine specifier 
   (filetype :UInt32)
                                                ;  type of file 
   (ncmds :UInt32)
                                                ;  number of load commands 
   (sizeofcmds :UInt32)
                                                ;  the size of all the load commands 
   (flags :UInt32)
                                                ;  flags 
)
;  Constant for the magic field of the mach_header 
(defconstant $MH_MAGIC 4277009102)
; #define	MH_MAGIC	0xfeedface	/* the mach magic number */
; #define MH_CIGAM	NXSwapInt(MH_MAGIC)
; 
;  * The layout of the file depends on the filetype.  For all but the MH_OBJECT
;  * file type the segments are padded out and aligned on a segment alignment
;  * boundary for efficient demand pageing.  The MH_EXECUTE, MH_FVMLIB, MH_DYLIB,
;  * MH_DYLINKER and MH_BUNDLE file types also have the headers included as part
;  * of their first segment.
;  * 
;  * The file type MH_OBJECT is a compact format intended as output of the
;  * assembler and input (and possibly output) of the link editor (the .o
;  * format).  All sections are in one unnamed segment with no segment padding. 
;  * This format is used as an executable format when the file is so small the
;  * segment padding greatly increases it's size.
;  *
;  * The file type MH_PRELOAD is an executable format intended for things that
;  * not executed under the kernel (proms, stand alones, kernels, etc).  The
;  * format can be executed under the kernel but may demand paged it and not
;  * preload it before execution.
;  *
;  * A core file is in MH_CORE format and can be any in an arbritray legal
;  * Mach-O file.
;  *
;  * Constants for the filetype field of the mach_header
;  
(defconstant $MH_OBJECT 1)
; #define	MH_OBJECT	0x1		/* relocatable object file */
(defconstant $MH_EXECUTE 2)
; #define	MH_EXECUTE	0x2		/* demand paged executable file */
(defconstant $MH_FVMLIB 3)
; #define	MH_FVMLIB	0x3		/* fixed VM shared library file */
(defconstant $MH_CORE 4)
; #define	MH_CORE		0x4		/* core file */
(defconstant $MH_PRELOAD 5)
; #define	MH_PRELOAD	0x5		/* preloaded executable file */
(defconstant $MH_DYLIB 6)
; #define	MH_DYLIB	0x6		/* dynamicly bound shared library file*/
(defconstant $MH_DYLINKER 7)
; #define	MH_DYLINKER	0x7		/* dynamic link editor */
(defconstant $MH_BUNDLE 8)
; #define	MH_BUNDLE	0x8		/* dynamicly bound bundle file */
;  Constants for the flags field of the mach_header 
(defconstant $MH_NOUNDEFS 1)
; #define	MH_NOUNDEFS	0x1		/* the object file has no undefined
(defconstant $MH_INCRLINK 2)
; #define	MH_INCRLINK	0x2		/* the object file is the output of an
(defconstant $MH_DYLDLINK 4)
; #define MH_DYLDLINK	0x4		/* the object file is input for the
(defconstant $MH_BINDATLOAD 8)
; #define MH_BINDATLOAD	0x8		/* the object file's undefined
(defconstant $MH_PREBOUND 16)
; #define MH_PREBOUND	0x10		/* the file has it's dynamic undefined
; 
;  * The load commands directly follow the mach_header.  The total size of all
;  * of the commands is given by the sizeofcmds field in the mach_header.  All
;  * load commands must have as their first two fields cmd and cmdsize.  The cmd
;  * field is filled in with a constant for that command type.  Each command type
;  * has a structure specifically for it.  The cmdsize field is the size in bytes
;  * of the particular load command structure plus anything that follows it that
;  * is a part of the load command (i.e. section structures, strings, etc.).  To
;  * advance to the next load command the cmdsize can be added to the offset or
;  * pointer of the current load command.  The cmdsize MUST be a multiple of
;  * sizeof(long) (this is forever the maximum alignment of any load commands).
;  * The padded bytes must be zero.  All tables in the object file must also
;  * follow these rules so the file can be memory mapped.  Otherwise the pointers
;  * to these tables will not work well or at all on some machines.  With all
;  * padding zeroed like objects will compare byte for byte.
;  
(defrecord load_command
   (cmd :UInt32)
                                                ;  type of load command 
   (cmdsize :UInt32)
                                                ;  total size of command in bytes 
)
;  Constants for the cmd field of all load commands, the type 
(defconstant $LC_SEGMENT 1)
; #define	LC_SEGMENT	0x1	/* segment of this file to be mapped */
(defconstant $LC_SYMTAB 2)
; #define	LC_SYMTAB	0x2	/* link-edit stab symbol table info */
(defconstant $LC_SYMSEG 3)
; #define	LC_SYMSEG	0x3	/* link-edit gdb symbol table info (obsolete) */
(defconstant $LC_THREAD 4)
; #define	LC_THREAD	0x4	/* thread */
(defconstant $LC_UNIXTHREAD 5)
; #define	LC_UNIXTHREAD	0x5	/* unix thread (includes a stack) */
(defconstant $LC_LOADFVMLIB 6)
; #define	LC_LOADFVMLIB	0x6	/* load a specified fixed VM shared library */
(defconstant $LC_IDFVMLIB 7)
; #define	LC_IDFVMLIB	0x7	/* fixed VM shared library identification */
(defconstant $LC_IDENT 8)
; #define	LC_IDENT	0x8	/* object identification info (obsolete) */
(defconstant $LC_FVMFILE 9)
; #define LC_FVMFILE	0x9	/* fixed VM file inclusion (internal use) */
(defconstant $LC_PREPAGE 10)
; #define LC_PREPAGE      0xa     /* prepage command (internal use) */
(defconstant $LC_DYSYMTAB 11)
; #define	LC_DYSYMTAB	0xb	/* dynamic link-edit symbol table info */
(defconstant $LC_LOAD_DYLIB 12)
; #define	LC_LOAD_DYLIB	0xc	/* load a dynamicly linked shared library */
(defconstant $LC_ID_DYLIB 13)
; #define	LC_ID_DYLIB	0xd	/* dynamicly linked shared lib identification */
(defconstant $LC_LOAD_DYLINKER 14)
; #define LC_LOAD_DYLINKER 0xe	/* load a dynamic linker */
(defconstant $LC_ID_DYLINKER 15)
; #define LC_ID_DYLINKER	0xf	/* dynamic linker identification */
(defconstant $LC_PREBOUND_DYLIB 16)
; #define	LC_PREBOUND_DYLIB 0x10	/* modules prebound for a dynamicly */
;   linked shared library 
; 
;  * A variable length string in a load command is represented by an lc_str
;  * union.  The strings are stored just after the load command structure and
;  * the offset is from the start of the load command structure.  The size
;  * of the string is reflected in the cmdsize field of the load command.
;  * Once again any padded bytes to bring the cmdsize field to a multiple
;  * of sizeof(long) must be zero.
;  
(defrecord lc_str
   (:variant
   (
   (offset :UInt32)
   )
                                                ;  offset to the string 
   (
   (ptr (:pointer :char))
   )
                                                ;  pointer to the string 
   )
)
; 
;  * The segment load command indicates that a part of this file is to be
;  * mapped into the task's address space.  The size of this segment in memory,
;  * vmsize, maybe equal to or larger than the amount to map from this file,
;  * filesize.  The file is mapped starting at fileoff to the beginning of
;  * the segment in memory, vmaddr.  The rest of the memory of the segment,
;  * if any, is allocated zero fill on demand.  The segment's maximum virtual
;  * memory protection and initial virtual memory protection are specified
;  * by the maxprot and initprot fields.  If the segment has sections then the
;  * section structures directly follow the segment command and their size is
;  * reflected in cmdsize.
;  
(defrecord segment_command
   (cmd :UInt32)
                                                ;  LC_SEGMENT 
   (cmdsize :UInt32)
                                                ;  includes sizeof section structs 
   (segname (:array :character 16))
                                                ;  segment name 
   (vmaddr :UInt32)
                                                ;  memory address of this segment 
   (vmsize :UInt32)
                                                ;  memory size of this segment 
   (fileoff :UInt32)
                                                ;  file offset of this segment 
   (filesize :UInt32)
                                                ;  amount to map from the file 
   (maxprot :signed-long)
                                                ;  maximum VM protection 
   (initprot :signed-long)
                                                ;  initial VM protection 
   (nsects :UInt32)
                                                ;  number of sections in segment 
   (flags :UInt32)
                                                ;  flags 
)
;  Constants for the flags field of the segment_command 
(defconstant $SG_HIGHVM 1)
; #define	SG_HIGHVM	0x1	/* the file contents for this segment is for
(defconstant $SG_FVMLIB 2)
; #define	SG_FVMLIB	0x2	/* this segment is the VM that is allocated by
(defconstant $SG_NORELOC 4)
; #define	SG_NORELOC	0x4	/* this segment has nothing that was relocated
; 
;  * A segment is made up of zero or more sections.  Non-MH_OBJECT files have
;  * all of their segments with the proper sections in each, and padded to the
;  * specified segment alignment when produced by the link editor.  The first
;  * segment of a MH_EXECUTE and MH_FVMLIB format file contains the mach_header
;  * and load commands of the object file before it's first section.  The zero
;  * fill sections are always last in their segment (in all formats).  This
;  * allows the zeroed segment padding to be mapped into memory where zero fill
;  * sections might be.
;  *
;  * The MH_OBJECT format has all of it's sections in one segment for
;  * compactness.  There is no padding to a specified segment boundary and the
;  * mach_header and load commands are not part of the segment.
;  *
;  * Sections with the same section name, sectname, going into the same segment,
;  * segname, are combined by the link editor.  The resulting section is aligned
;  * to the maximum alignment of the combined sections and is the new section's
;  * alignment.  The combined sections are aligned to their original alignment in
;  * the combined section.  Any padded bytes to get the specified alignment are
;  * zeroed.
;  *
;  * The format of the relocation entries referenced by the reloff and nreloc
;  * fields of the section structure for mach object files is described in the
;  * header file <reloc.h>.
;  
(defrecord section
   (sectname (:array :character 16))
                                                ;  name of this section 
   (segname (:array :character 16))
                                                ;  segment this section goes in 
   (addr :UInt32)
                                                ;  memory address of this section 
   (size :UInt32)
                                                ;  size in bytes of this section 
   (offset :UInt32)
                                                ;  file offset of this section 
   (align :UInt32)
                                                ;  section alignment (power of 2) 
   (reloff :UInt32)
                                                ;  file offset of relocation entries 
   (nreloc :UInt32)
                                                ;  number of relocation entries 
   (flags :UInt32)
                                                ;  flags (section type and attributes)
   (reserved1 :UInt32)
                                                ;  reserved 
   (reserved2 :UInt32)
                                                ;  reserved 
)
; 
;  * The flags field of a section structure is separated into two parts a section
;  * type and section attributes.  The section types are mutually exclusive (it
;  * can only have one type) but the section attributes are not (it may have more
;  * than one attribute).
;  
(defconstant $SECTION_TYPE 255)
; #define SECTION_TYPE		 0x000000ff	/* 256 section types */
(defconstant $SECTION_ATTRIBUTES 4294967040)
; #define SECTION_ATTRIBUTES	 0xffffff00	/*  24 section attributes */
;  Constants for the type of a section 
(defconstant $S_REGULAR 0)
; #define	S_REGULAR		0x0	/* regular section */
(defconstant $S_ZEROFILL 1)
; #define	S_ZEROFILL		0x1	/* zero fill on demand section */
(defconstant $S_CSTRING_LITERALS 2)
; #define	S_CSTRING_LITERALS	0x2	/* section with only literal C strings*/
(defconstant $S_4BYTE_LITERALS 3)
; #define	S_4BYTE_LITERALS	0x3	/* section with only 4 byte literals */
(defconstant $S_8BYTE_LITERALS 4)
; #define	S_8BYTE_LITERALS	0x4	/* section with only 8 byte literals */
(defconstant $S_LITERAL_POINTERS 5)
; #define	S_LITERAL_POINTERS	0x5	/* section with only pointers to */
;   literals 
; 
;  * For the two types of symbol pointers sections and the symbol stubs section
;  * they have indirect symbol table entries.  For each of the entries in the
;  * section the indirect symbol table entries, in corresponding order in the
;  * indirect symbol table, start at the index stored in the reserved1 field
;  * of the section structure.  Since the indirect symbol table entries
;  * correspond to the entries in the section the number of indirect symbol table
;  * entries is inferred from the size of the section divided by the size of the
;  * entries in the section.  For symbol pointers sections the size of the entries
;  * in the section is 4 bytes and for symbol stubs sections the byte size of the
;  * stubs is stored in the reserved2 field of the section structure.
;  
(defconstant $S_NON_LAZY_SYMBOL_POINTERS 6)
; #define	S_NON_LAZY_SYMBOL_POINTERS	0x6	/* section with only non-lazy
(defconstant $S_LAZY_SYMBOL_POINTERS 7)
; #define	S_LAZY_SYMBOL_POINTERS		0x7	/* section with only lazy symbol
(defconstant $S_SYMBOL_STUBS 8)
; #define	S_SYMBOL_STUBS			0x8	/* section with only symbol
(defconstant $S_MOD_INIT_FUNC_POINTERS 9)
; #define	S_MOD_INIT_FUNC_POINTERS	0x9	/* section with only function
; 
;  * Constants for the section attributes part of the flags field of a section
;  * structure.
;  
(defconstant $SECTION_ATTRIBUTES_USR 4278190080)
; #define SECTION_ATTRIBUTES_USR	 0xff000000	/* User setable attributes */
(defconstant $S_ATTR_PURE_INSTRUCTIONS 2147483648)
; #define S_ATTR_PURE_INSTRUCTIONS 0x80000000	/* section contains only true
(defconstant $SECTION_ATTRIBUTES_SYS 16776960)
; #define SECTION_ATTRIBUTES_SYS	 0x00ffff00	/* system setable attributes */
(defconstant $S_ATTR_SOME_INSTRUCTIONS 1024)
; #define S_ATTR_SOME_INSTRUCTIONS 0x00000400	/* section contains some
(defconstant $S_ATTR_EXT_RELOC 512)
; #define S_ATTR_EXT_RELOC	 0x00000200	/* section has external
(defconstant $S_ATTR_LOC_RELOC 256)
; #define S_ATTR_LOC_RELOC	 0x00000100	/* section has local
; 
;  * The names of segments and sections in them are mostly meaningless to the
;  * link-editor.  But there are few things to support traditional UNIX
;  * executables that require the link-editor and assembler to use some names
;  * agreed upon by convention.
;  *
;  * The initial protection of the "__TEXT" segment has write protection turned
;  * off (not writeable).
;  *
;  * The link-editor will allocate common symbols at the end of the "__common"
;  * section in the "__DATA" segment.  It will create the section and segment
;  * if needed.
;  
;  The currently known segment names and the section names in those segments 
(defconstant $SEG_PAGEZERO "__PAGEZERO")
; #define	SEG_PAGEZERO	"__PAGEZERO"	/* the pagezero segment which has no */
;  protections and catches NULL 
;  references for MH_EXECUTE files 
(defconstant $SEG_TEXT "__TEXT")
; #define	SEG_TEXT	"__TEXT"	/* the tradition UNIX text segment */
(defconstant $SECT_TEXT "__text")
; #define	SECT_TEXT	"__text"	/* the real text part of the text */
;  section no headers, and no padding 
(defconstant $SECT_FVMLIB_INIT0 "__fvmlib_init0")
; #define SECT_FVMLIB_INIT0 "__fvmlib_init0"	/* the fvmlib initialization */
;   section 
(defconstant $SECT_FVMLIB_INIT1 "__fvmlib_init1")
; #define SECT_FVMLIB_INIT1 "__fvmlib_init1"	/* the section following the */
;   fvmlib initialization 
;   section 
(defconstant $SEG_DATA "__DATA")
; #define	SEG_DATA	"__DATA"	/* the tradition UNIX data segment */
(defconstant $SECT_DATA "__data")
; #define	SECT_DATA	"__data"	/* the real initialized data section */
;  no padding, no bss overlap 
(defconstant $SECT_BSS "__bss")
; #define	SECT_BSS	"__bss"		/* the real uninitialized data section*/
;  no padding 
(defconstant $SECT_COMMON "__common")
; #define SECT_COMMON	"__common"	/* the section common symbols are */
;  allocated in by the link editor 
(defconstant $SEG_OBJC "__OBJC")
; #define	SEG_OBJC	"__OBJC"	/* objective-C runtime segment */
(defconstant $SECT_OBJC_SYMBOLS "__symbol_table")
; #define SECT_OBJC_SYMBOLS "__symbol_table"	/* symbol table */
(defconstant $SECT_OBJC_MODULES "__module_info")
; #define SECT_OBJC_MODULES "__module_info"	/* module information */
(defconstant $SECT_OBJC_STRINGS "__selector_strs")
; #define SECT_OBJC_STRINGS "__selector_strs"	/* string table */
(defconstant $SECT_OBJC_REFS "__selector_refs")
; #define SECT_OBJC_REFS "__selector_refs"	/* string table */
(defconstant $SEG_ICON "__ICON")
; #define	SEG_ICON	 "__ICON"	/* the NeXT icon segment */
(defconstant $SECT_ICON_HEADER "__header")
; #define	SECT_ICON_HEADER "__header"	/* the icon headers */
(defconstant $SECT_ICON_TIFF "__tiff")
; #define	SECT_ICON_TIFF   "__tiff"	/* the icons in tiff format */
(defconstant $SEG_LINKEDIT "__LINKEDIT")
; #define	SEG_LINKEDIT	"__LINKEDIT"	/* the segment containing all structs */
;  created and maintained by the link 
;  editor.  Created with -seglinkedit 
;  option to ld(1) for MH_EXECUTE and 
;  FVMLIB file types only 
(defconstant $SEG_UNIXSTACK "__UNIXSTACK")
; #define SEG_UNIXSTACK	"__UNIXSTACK"	/* the unix stack segment */
; 
;  * Fixed virtual memory shared libraries are identified by two things.  The
;  * target pathname (the name of the library as found for execution), and the
;  * minor version number.  The address of where the headers are loaded is in
;  * header_addr.
;  
(defrecord fvmlib
   (:variant
   (
   (name :LC_STR)
   )
   )
                                                ;  library's target pathname 
   (minor_version :UInt32)
                                                ;  library's minor version number 
   (header_addr :UInt32)
                                                ;  library's header address 
)
; 
;  * A fixed virtual shared library (filetype == MH_FVMLIB in the mach header)
;  * contains a fvmlib_command (cmd == LC_IDFVMLIB) to identify the library.
;  * An object that uses a fixed virtual shared library also contains a
;  * fvmlib_command (cmd == LC_LOADFVMLIB) for each library it uses.
;  
(defrecord fvmlib_command
   (cmd :UInt32)
                                                ;  LC_IDFVMLIB or LC_LOADFVMLIB 
   (cmdsize :UInt32)
                                                ;  includes pathname string 
   (fvmlib :FVMLIB)
                                                ;  the library identification 
)
; 
;  * Dynamicly linked shared libraries are identified by two things.  The
;  * pathname (the name of the library as found for execution), and the
;  * compatibility version number.  The pathname must match and the compatibility
;  * number in the user of the library must be greater than or equal to the
;  * library being used.  The time stamp is used to record the time a library was
;  * built and copied into user so it can be use to determined if the library used
;  * at runtime is exactly the same as used to built the program.
;  
(defrecord dylib
   (:variant
   (
   (name :LC_STR)
   )
   )
                                                ;  library's path name 
   (timestamp :UInt32)
                                                ;  library's build time stamp 
   (current_version :UInt32)
                                                ;  library's current version number 
   (compatibility_version :UInt32)              ;  library's compatibility vers number
)
; 
;  * A dynamicly linked shared library (filetype == MH_DYLIB in the mach header)
;  * contains a dylib_command (cmd == LC_ID_DYLIB) to identify the library.
;  * An object that uses a dynamicly linked shared library also contains a
;  * dylib_command (cmd == LC_LOAD_DYLIB) for each library it uses.
;  
(defrecord dylib_command
   (cmd :UInt32)
                                                ;  LC_ID_DYLIB or LC_LOAD_DYLIB 
   (cmdsize :UInt32)
                                                ;  includes pathname string 
   (dylib :DYLIB)
                                                ;  the library identification 
)
; 
;  * A program (filetype == MH_EXECUTE) or bundle (filetype == MH_BUNDLE) that is
;  * prebound to it's dynamic libraries has one of these for each library that
;  * the static linker used in prebinding.  It contains a bit vector for the
;  * modules in the library.  The bits indicate which modules are bound (1) and
;  * which are not (0) from the library.  The bit for module 0 is the low bit
;  * of the first byte.  So the bit for the Nth module is:
;  * (linked_modules[N/8] >> N%8) & 1
;  
(defrecord prebound_dylib_command
   (cmd :UInt32)
                                                ;  LC_PREBOUND_DYLIB 
   (cmdsize :UInt32)
                                                ;  includes strings 
   (:variant
   (
   (name :LC_STR)
   )
   )
                                                ;  library's path name 
   (nmodules :UInt32)
                                                ;  number of modules in library 
   (:variant
   (
   (linked_modules :LC_STR)
   )
   )
                                                ;  bit vector of linked modules 
)
; 
;  * A program that uses a dynamic linker contains a dylinker_command to identify
;  * the name of the dynamic linker (LC_LOAD_DYLINKER).  And a dynamic linker
;  * contains a dylinker_command to identify the dynamic linker (LC_ID_DYLINKER).
;  * A file can have at most one of these.
;  
(defrecord dylinker_command
   (cmd :UInt32)
                                                ;  LC_ID_DYLINKER or LC_LOAD_DYLINKER 
   (cmdsize :UInt32)
                                                ;  includes pathname string 
   (:variant
   (
   (name :LC_STR)
   )
   )
                                                ;  dynamic linker's path name 
)
; 
;  * Thread commands contain machine-specific data structures suitable for
;  * use in the thread state primitives.  The machine specific data structures
;  * follow the struct thread_command as follows.
;  * Each flavor of machine specific data structure is preceded by an unsigned
;  * long constant for the flavor of that data structure, an unsigned long
;  * that is the count of longs of the size of the state data structure and then
;  * the state data structure follows.  This triple may be repeated for many
;  * flavors.  The constants for the flavors, counts and state data structure
;  * definitions are expected to be in the header file <machine/thread_status.h>.
;  * These machine specific data structures sizes must be multiples of
;  * sizeof(long).  The cmdsize reflects the total size of the thread_command
;  * and all of the sizes of the constants for the flavors, counts and state
;  * data structures.
;  *
;  * For executable objects that are unix processes there will be one
;  * thread_command (cmd == LC_UNIXTHREAD) created for it by the link-editor.
;  * This is the same as a LC_THREAD, except that a stack is automatically
;  * created (based on the shell's limit for the stack size).  Command arguments
;  * and environment variables are copied onto that stack.
;  
(defrecord thread_command
   (cmd :UInt32)
                                                ;  LC_THREAD or  LC_UNIXTHREAD 
   (cmdsize :UInt32)
                                                ;  total size of this command 
                                                ;  unsigned long flavor		   flavor of thread state 
                                                ;  unsigned long count		   count of longs in thread state 
                                                ;  struct XXX_thread_state state   thread state for this flavor 
                                                ;  ... 
)
; 
;  * The symtab_command contains the offsets and sizes of the link-edit 4.3BSD
;  * "stab" style symbol table information as described in the header files
;  * <nlist.h> and <stab.h>.
;  
(defrecord symtab_command
   (cmd :UInt32)
                                                ;  LC_SYMTAB 
   (cmdsize :UInt32)
                                                ;  sizeof(struct symtab_command) 
   (symoff :UInt32)
                                                ;  symbol table offset 
   (nsyms :UInt32)
                                                ;  number of symbol table entries 
   (stroff :UInt32)
                                                ;  string table offset 
   (strsize :UInt32)
                                                ;  string table size in bytes 
)
; 
;  * This is the second set of the symbolic information which is used to support
;  * the data structures for the dynamicly link editor.
;  *
;  * The original set of symbolic information in the symtab_command which contains
;  * the symbol and string tables must also be present when this load command is
;  * present.  When this load command is present the symbol table is organized
;  * into three groups of symbols:
;  *	local symbols (static and debugging symbols) - grouped by module
;  *	defined external symbols - grouped by module (sorted by name if not lib)
;  *	undefined external symbols (sorted by name)
;  * In this load command there are offsets and counts to each of the three groups
;  * of symbols.
;  *
;  * This load command contains a the offsets and sizes of the following new
;  * symbolic information tables:
;  *	table of contents
;  *	module table
;  *	reference symbol table
;  *	indirect symbol table
;  * The first three tables above (the table of contents, module table and
;  * reference symbol table) are only present if the file is a dynamicly linked
;  * shared library.  For executable and object modules, which are files
;  * containing only one module, the information that would be in these three
;  * tables is determined as follows:
;  * 	table of contents - the defined external symbols are sorted by name
;  *	module table - the file contains only one module so everything in the
;  *		       file is part of the module.
;  *	reference symbol table - is the defined and undefined external symbols
;  *
;  * For dynamicly linked shared library files this load command also contains
;  * offsets and sizes to the pool of relocation entries for all sections
;  * separated into two groups:
;  *	external relocation entries
;  *	local relocation entries
;  * For executable and object modules the relocation entries continue to hang
;  * off the section structures.
;  
(defrecord dysymtab_command
   (cmd :UInt32)
                                                ;  LC_DYSYMTAB 
   (cmdsize :UInt32)
                                                ;  sizeof(struct dysymtab_command) 
                                                ; 
;      * The symbols indicated by symoff and nsyms of the LC_SYMTAB load command
;      * are grouped into the following three groups:
;      *    local symbols (further grouped by the module they are from)
;      *    defined external symbols (further grouped by the module they are from)
;      *    undefined symbols
;      *
;      * The local symbols are used only for debugging.  The dynamic binding
;      * process may have to use them to indicate to the debugger the local
;      * symbols for a module that is being bound.
;      *
;      * The last two groups are used by the dynamic binding process to do the
;      * binding (indirectly through the module table and the reference symbol
;      * table when this is a dynamicly linked shared library file).
;      
   (ilocalsym :UInt32)
                                                ;  index to local symbols 
   (nlocalsym :UInt32)
                                                ;  number of local symbols 
   (iextdefsym :UInt32)
                                                ;  index to externally defined symbols 
   (nextdefsym :UInt32)
                                                ;  number of externally defined symbols 
   (iundefsym :UInt32)
                                                ;  index to undefined symbols 
   (nundefsym :UInt32)
                                                ;  number of undefined symbols 
                                                ; 
;      * For the for the dynamic binding process to find which module a symbol
;      * is defined in the table of contents is used (analogous to the ranlib
;      * structure in an archive) which maps defined external symbols to modules
;      * they are defined in.  This exists only in a dynamicly linked shared
;      * library file.  For executable and object modules the defined external
;      * symbols are sorted by name and is use as the table of contents.
;      
   (tocoff :UInt32)
                                                ;  file offset to table of contents 
   (ntoc :UInt32)
                                                ;  number of entries in table of contents 
                                                ; 
;      * To support dynamic binding of "modules" (whole object files) the symbol
;      * table must reflect the modules that the file was created from.  This is
;      * done by having a module table that has indexes and counts into the merged
;      * tables for each module.  The module structure that these two entries
;      * refer to is described below.  This exists only in a dynamicly linked
;      * shared library file.  For executable and object modules the file only
;      * contains one module so everything in the file belongs to the module.
;      
   (modtaboff :UInt32)
                                                ;  file offset to module table 
   (nmodtab :UInt32)
                                                ;  number of module table entries 
                                                ; 
;      * To support dynamic module binding the module structure for each module
;      * indicates the external references (defined and undefined) each module
;      * makes.  For each module there is an offset and a count into the
;      * reference symbol table for the symbols that the module references.
;      * This exists only in a dynamicly linked shared library file.  For
;      * executable and object modules the defined external symbols and the
;      * undefined external symbols indicates the external references.
;      
   (extrefsymoff :UInt32)                       ;  offset to referenced symbol table 
   (nextrefsyms :UInt32)
                                                ;  number of referenced symbol table entries 
                                                ; 
;      * The sections that contain "symbol pointers" and "routine stubs" have
;      * indexes and (implied counts based on the size of the section and fixed
;      * size of the entry) into the "indirect symbol" table for each pointer
;      * and stub.  For every section of these two types the index into the
;      * indirect symbol table is stored in the section header in the field
;      * reserved1.  An indirect symbol table entry is simply a 32bit index into
;      * the symbol table to the symbol that the pointer or stub is referring to.
;      * The indirect symbol table is ordered to match the entries in the section.
;      
   (indirectsymoff :UInt32)                     ;  file offset to the indirect symbol table 
   (nindirectsyms :UInt32)                      ;  number of indirect symbol table entries 
                                                ; 
;      * To support relocating an individual module in a library file quickly the
;      * external relocation entries for each module in the library need to be
;      * accessed efficiently.  Since the relocation entries can't be accessed
;      * through the section headers for a library file they are separated into
;      * groups of local and external entries further grouped by module.  In this
;      * case the presents of this load command who's extreloff, nextrel,
;      * locreloff and nlocrel fields are non-zero indicates that the relocation
;      * entries of non-merged sections are not referenced through the section
;      * structures (and the reloff and nreloc fields in the section headers are
;      * set to zero).
;      *
;      * Since the relocation entries are not accessed through the section headers
;      * this requires the r_address field to be something other than a section
;      * offset to identify the item to be relocated.  In this case r_address is
;      * set to the offset from the vmaddr of the first LC_SEGMENT command.
;      *
;      * The relocation entries are grouped by module and the module table
;      * entries have indexes and counts into them for the group of external
;      * relocation entries for that the module.
;      *
;      * For sections that are merged across modules there must not be any
;      * remaining external relocation entries for them (for merged sections
;      * remaining relocation entries must be local).
;      
   (extreloff :UInt32)
                                                ;  offset to external relocation entries 
   (nextrel :UInt32)
                                                ;  number of external relocation entries 
                                                ; 
;      * All the local relocation entries are grouped together (they are not
;      * grouped by their module since they are only used if the object is moved
;      * from it staticly link edited address).
;      
   (locreloff :UInt32)
                                                ;  offset to local relocation entries 
   (nlocrel :UInt32)
                                                ;  number of local relocation entries 
)
; 
;  * An indirect symbol table entry is simply a 32bit index into the symbol table 
;  * to the symbol that the pointer or stub is refering to.  Unless it is for a
;  * non-lazy symbol pointer section for a defined symbol which strip(1) as 
;  * removed.  In which case it has the value INDIRECT_SYMBOL_LOCAL.  If the
;  * symbol was also absolute INDIRECT_SYMBOL_ABS is or'ed with that.
;  
(defconstant $INDIRECT_SYMBOL_LOCAL 2147483648)
; #define INDIRECT_SYMBOL_LOCAL	0x80000000
(defconstant $INDIRECT_SYMBOL_ABS 1073741824)
; #define INDIRECT_SYMBOL_ABS	0x40000000
;  a table of contents entry 
(defrecord dylib_table_of_contents
   (symbol_index :UInt32)
                                                ;  the defined external symbol
; 				   (index into the symbol table) 
   (module_index :UInt32)
                                                ;  index into the module table this symbol
; 				   is defined in 
)
;  a module table entry 
(defrecord dylib_module
   (module_name :UInt32)
                                                ;  the module name (index into string table) 
   (iextdefsym :UInt32)
                                                ;  index into externally defined symbols 
   (nextdefsym :UInt32)
                                                ;  number of externally defined symbols 
   (irefsym :UInt32)
                                                ;  index into reference symbol table 
   (nrefsym :UInt32)
                                                ;  number of reference symbol table entries 
   (ilocalsym :UInt32)
                                                ;  index into symbols for local symbols 
   (nlocalsym :UInt32)
                                                ;  number of local symbols 
   (iextrel :UInt32)
                                                ;  index into external relocation entries 
   (nextrel :UInt32)
                                                ;  number of external relocation entries 
   (iinit :UInt32)
                                                ;  index into the init section 
   (ninit :UInt32)
                                                ;  number of init section entries 
                                                ;  for this module address of the start of 
   (objc_module_info_addr :UInt32)              ;   the (__OBJC,__module_info) section 
                                                ;  for this module size of 
   (objc_module_info_size :UInt32)
                                                ;   the (__OBJC,__module_info) section 
)
;  
;  * The entries in the reference symbol table are used when loading the module
;  * (both by the static and dynamic link editors) and if the module is unloaded
;  * or replaced.  Therefore all external symbols (defined and undefined) are
;  * listed in the module's reference table.  The flags describe the type of
;  * reference that is being made.  The constants for the flags are defined in
;  * <mach-o/nlist.h> as they are also used for symbol table entries.
;  
(defrecord dylib_reference
   (isym :UInt32)                               ;(: 24)
                                                ;  index into the symbol table 
                                                ;(flags : 8)
                                                ;  flags to indicate the type of reference 
)
; 
;  * The symseg_command contains the offset and size of the GNU style
;  * symbol table information as described in the header file <symseg.h>.
;  * The symbol roots of the symbol segments must also be aligned properly
;  * in the file.  So the requirement of keeping the offsets aligned to a
;  * multiple of a sizeof(long) translates to the length field of the symbol
;  * roots also being a multiple of a long.  Also the padding must again be
;  * zeroed. (THIS IS OBSOLETE and no longer supported).
;  
(defrecord symseg_command
   (cmd :UInt32)
                                                ;  LC_SYMSEG 
   (cmdsize :UInt32)
                                                ;  sizeof(struct symseg_command) 
   (offset :UInt32)
                                                ;  symbol segment offset 
   (size :UInt32)
                                                ;  symbol segment size in bytes 
)
; 
;  * The ident_command contains a free format string table following the
;  * ident_command structure.  The strings are null terminated and the size of
;  * the command is padded out with zero bytes to a multiple of sizeof(long).
;  * (THIS IS OBSOLETE and no longer supported).
;  
(defrecord ident_command
   (cmd :UInt32)
                                                ;  LC_IDENT 
   (cmdsize :UInt32)
                                                ;  strings that follow this command 
)
; 
;  * The fvmfile_command contains a reference to a file to be loaded at the
;  * specified virtual address.  (Presently, this command is reserved for NeXT
;  * internal use.  The kernel ignores this command when loading a program into
;  * memory).
;  
(defrecord fvmfile_command
   (cmd :UInt32)
                                                ;  LC_FVMFILE 
   (cmdsize :UInt32)
                                                ;  includes pathname string 
   (:variant
   (
   (name :LC_STR)
   )
   )
                                                ;  files pathname 
   (header_addr :UInt32)
                                                ;  files virtual address 
)

; #endif /* _MACHO_LOADER_H_ */


(provide-interface "loader")