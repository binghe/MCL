(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOMacOSTypes.h"
; at Sunday July 2,2006 7:29:29 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
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
; 
;  * Copyright (c) 1997 Apple Computer, Inc.
;  *
;  *
;  * HISTORY
;  *
;  * sdouglas  22 Oct 97 - first checked in.
;  * sdouglas  21 July 98 - start IOKit
;  
; 
;     File:       Types.h
;  
;     Contains:   Basic Macintosh data types.
;  
;     Version:    Technology: PowerSurge 1.0.2.
;                 Package:    Universal Interfaces 2.1.2 on ETO #20
;  
;     Copyright:  © 1984-1995 by Apple Computer, Inc.
;                 All rights reserved.
;  
;     Bugs?:      If you find a problem with this file, use the Apple Bug Reporter
;                 stack.  Include the file and version information (from above)
;                 in the problem description and send to:
;                     Internet:   apple.bugs@applelink.apple.com
;                     AppleLink:  APPLE.BUGS
;  
; 
; #ifndef _IOKIT_IOMACOSTYPES_H
; #define _IOKIT_IOMACOSTYPES_H
; #ifndef __MACTYPES__
#| #|

#include <IOKitIOTypes.h>

#ifdef__cplusplus
extern "C" {
#endif
#pragma options align=mac68k

#ifndefNULL
#if!defined(__cplusplus) && (defined(__SC__) || defined(THINK_C))
#define NULL ((void *) 0)
#else#define NULL 0
#endif#endif
enum {
    noErr                       = 0
};

typedef unsigned long KernelProcessID;
typedef unsigned long AddressSpaceID;

#if0
#ifndef__cplusplus
enum { false, true };
#endif#endif
typedef unsigned char Byte;

typedef signed char SignedByte;

typedef UInt16 UniChar;

typedef char *Ptr;

typedef Ptr *Handle;

typedef long Fixed;

typedef Fixed *FixedPtr;

typedef long Fract;

typedef Fract *FractPtr;

struct _extended80 {
    short                           exp;
    short                           man[4];
};
struct _extended96 {
    short                           exp[2];
    short                           man[4];
};
typedef struct wide				*WidePtr;

typedef struct UnsignedWide		*UnsignedWidePtr;





typedef short OSErr;

typedef unsigned int FourCharCode;

typedef FourCharCode OSType;

typedef FourCharCode ResType;

typedef OSType *OSTypePtr;

typedef ResType *ResTypePtr;

struct Rect {
    short                           top;
    short                           left;
    short                           bottom;
    short                           right;
};
typedef struct Rect Rect;

typedef Rect *RectPtr;




enum {
    kVariableLengthArray        = 1
};


struct NumVersion {
    UInt8                           majorRev;                   
    UInt8                           minorAndBugRev;             
    UInt8                           stage;                      
    UInt8                           nonRelRev;                  
};
typedef struct NumVersion NumVersion;

typedef struct OpaqueRef *KernelID;

typedef UInt8 *BytePtr;

typedef UInt32 ByteCount;

typedef UInt32 ItemCount;

typedef void *LogicalAddress;

typedef void *PhysicalAddress;

typedef UInt32 PBVersion;

typedef SInt32 Duration;

#define kInvalidID 0

enum {
    kNilOptions                 = 0
};


typedef unsigned char Str31[32];





#define kPropertyName					"name"
#define kPropertyCompatible				"compatible"
#define kPropertyDriverPtr				"driver-ptr"
#define kPropertyDriverDesc				"driver-description"
#define kPropertyReg					"reg"
#define kPropertyAAPLAddress				"AAPL,address"
#define kPropertyMatching				"matching"



struct DriverType {
	Str31							nameInfoStr;				
	NumVersion						version;					
};
typedef struct DriverType			DriverType;
typedef DriverType *				DriverTypePtr;


typedef OptionBits RuntimeOptions;


enum {
	kDriverIsLoadedUponDiscovery = 0x00000001,					
	kDriverIsOpenedUponLoad		=  0x00000002,					
	kDriverIsUnderExpertControl	=  0x00000004,					
	kDriverIsConcurrent			=  0x00000008,					
	kDriverQueuesIOPB			=  0x00000010,					
	kDriverIsLoadedAtBoot		=  0x00000020,					
	kDriverIsForVirtualDevice	=  0x00000040,					 
	kDriverSupportDMSuspendAndResume = 0x00000080				
};

struct DriverOSRuntime {
	RuntimeOptions					driverRuntime;				
	Str31							driverName;					
	UInt32							driverDescReserved[8];		
};
typedef struct DriverOSRuntime		DriverOSRuntime;
typedef DriverOSRuntime *			DriverOSRuntimePtr;


typedef UInt32 ServiceCount;

struct DriverServiceInfo {
	OSType							serviceCategory;			
	OSType							serviceType;				
	NumVersion						serviceVersion;				
};
typedef struct DriverServiceInfo	DriverServiceInfo;
typedef DriverServiceInfo *			DriverServiceInfoPtr;

struct DriverOSService {
	ServiceCount					nServices;					
	DriverServiceInfo				service[1];					
};
typedef struct DriverOSService		DriverOSService;
typedef DriverOSService *			DriverOSServicePtr;



enum {
	kServiceCategoryDisplay			= 'disp',						
	kServiceCategoryOpenTransport 	= 'otan',						
	kServiceCategoryBlockStorage	= 'blok',						
	kServiceCategoryNdrvDriver		= 'ndrv',						
	kServiceCategoryScsiSIM			= 'scsi',						
	kServiceCategoryFileManager		= 'file',						
	kServiceCategoryIDE				= 'ide-',						
	kServiceCategoryADB				= 'adb-',						
	kServiceCategoryPCI				= 'pci-',						
																	
	kServiceCategoryDFM				= 'dfm-',						
	kServiceCategoryMotherBoard		= 'mrbd',						
	kServiceCategoryKeyboard		= 'kybd',						
	kServiceCategoryPointing		= 'poit',						
	kServiceCategoryRTC				= 'rtc-',						
	kServiceCategoryNVRAM			= 'nram',						
	kServiceCategorySound			= 'sond',						
	kServiceCategoryPowerMgt		= 'pgmt',						
	kServiceCategoryGeneric			= 'genr'						
};


enum {
	kNdrvTypeIsGeneric			= 'genr',						
	kNdrvTypeIsVideo			= 'vido',						
	kNdrvTypeIsBlockStorage		= 'blok',						
	kNdrvTypeIsNetworking		= 'netw',						
	kNdrvTypeIsSerial			= 'serl',						
	kNdrvTypeIsParallel			= 'parl',						
	kNdrvTypeIsSound			= 'sond',						
	kNdrvTypeIsBusBridge		= 'brdg'
};

typedef UInt32 DriverDescVersion;


enum {
	kInitialDriverDescriptor	= 0,
	kVersionOneDriverDescriptor	= 1
};

enum {
	kTheDescriptionSignature	= 'mtej',
	kDriverDescriptionSignature	= 'pdes'						
};


struct DriverDescription {
	OSType							driverDescSignature;		
	DriverDescVersion				driverDescVersion;			
	DriverType						driverType;					
	DriverOSRuntime					driverOSRuntimeInfo;		
	DriverOSService					driverServices;				
};
typedef struct DriverDescription	DriverDescription;
typedef DriverDescription *			DriverDescriptionPtr;


#pragma options align=reset

#ifdef__cplusplus
}
#endif
#endif
|#
 |#
;  __MACTYPES__ 
; #ifndef __QUICKDRAW__
#| #|

#ifdef__cplusplus
extern "C" {
#endif
#pragma options align=mac68k

struct RGBColor {
 unsigned short red;                
 unsigned short green;              
 unsigned short blue;               
};
typedef struct RGBColor     RGBColor;
typedef RGBColor            *RGBColorPtr;
typedef RGBColorPtr         *RGBColorHdl;

struct ColorSpec {
 short value;                       
 RGBColor rgb;                      
};

typedef struct ColorSpec    ColorSpec;
typedef ColorSpec           *ColorSpecPtr;

struct GammaTbl {
 short gVersion;                    
 short gType;                       
 short gFormulaSize;                
 short gChanCnt;                    
 short gDataCnt;                    
 short gDataWidth;                  
 short gFormulaData[1];             
};
typedef struct GammaTbl     GammaTbl;
typedef GammaTbl            *GammaTblPtr;

#pragma options align=reset

#ifdef__cplusplus
}
#endif
#endif
|#
 |#
;  __QUICKDRAW__ 

; #endif /* _IOKIT_IOMACOSTYPES_H */


(provide-interface "IOMacOSTypes")