(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSBitmapImageRep.h"
; at Sunday July 2,2006 7:30:35 pm.
; 
; 	NSBitmapImageRep.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <AppKit/NSImageRep.h>
(def-mactype :_NSTIFFCompression (find-mactype ':sint32))

(defconstant $NSTIFFCompressionNone 1)
(defconstant $NSTIFFCompressionCCITTFAX3 3)     ;  1 bps only 

(defconstant $NSTIFFCompressionCCITTFAX4 4)     ;  1 bps only 

(defconstant $NSTIFFCompressionLZW 5)
(defconstant $NSTIFFCompressionJPEG 6)          ;  No longer supported for input or output 

(defconstant $NSTIFFCompressionNEXT #x7FFE)     ;  Input only 

(defconstant $NSTIFFCompressionPackBits #x8005)
(defconstant $NSTIFFCompressionOldJPEG #x8061)  ;  No longer supported for input or output 

(def-mactype :NSTIFFCompression (find-mactype ':SINT32))
(def-mactype :_NSBitmapImageFileType (find-mactype ':sint32))

(defconstant $NSTIFFFileType 0)
(defconstant $NSBMPFileType 1)
(defconstant $NSGIFFileType 2)
(defconstant $NSJPEGFileType 3)
(defconstant $NSPNGFileType 4)
(def-mactype :NSBitmapImageFileType (find-mactype ':SINT32))

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2

(defconstant $NSImageRepLoadStatusUnknownType -1);  not enough data to determine image format. please feed me more data

(defconstant $NSImageRepLoadStatusReadingHeader -2);  image format known, reading header. not yet valid. more data needed

(defconstant $NSImageRepLoadStatusWillNeedAllData -3);  can't read incrementally. will wait for complete data to become avail.

(defconstant $NSImageRepLoadStatusInvalidData -4);  image decompression encountered error.

(defconstant $NSImageRepLoadStatusUnexpectedEOF -5);  ran out of data before full image was decompressed.
;  all is well, the full pixelsHigh image is valid.

(defconstant $NSImageRepLoadStatusCompleted -6)
(def-mactype :NSImageRepLoadStatus (find-mactype ':SINT32))

; #endif

(def-mactype :NSImageCompressionMethod (find-mactype '(:pointer :NSString)))
;  TIFF input/output (NSTIFFCompression in NSNumber)
(def-mactype :NSImageCompressionFactor (find-mactype '(:pointer :NSString)))
;  TIFF/JPEG input/output (float in NSNumber)
(def-mactype :NSImageDitherTransparency (find-mactype '(:pointer :NSString)))
;  GIF output (BOOL in NSNumber)
(def-mactype :NSImageRGBColorTable (find-mactype '(:pointer :NSString)))
;  GIF input/output (packed RGB in NSData)
(def-mactype :NSImageInterlaced (find-mactype '(:pointer :NSString)))
;  PNG output (BOOL in NSNumber)
(def-mactype :NSImageColorSyncProfileData (find-mactype '(:pointer :NSString)))
;  TIFF,GIF input/output (NSData)

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
(def-mactype :NSImageFrameCount (find-mactype '(:pointer :NSString)))
;  GIF input (int in NSNumber) (read-only)
(def-mactype :NSImageCurrentFrame (find-mactype '(:pointer :NSString)))
;  GIF input (int in NSNumber)
(def-mactype :NSImageCurrentFrameDuration (find-mactype '(:pointer :NSString)))
;  GIF input (float in NSNumber) (read-only)

; #endif


; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
(def-mactype :NSImageLoopCount (find-mactype '(:pointer :NSString)))
;  GIF input (int in NSNumber) (read-only)

; #endif

#| @INTERFACE 
NSBitmapImageRep : NSImageRep {
    
    struct __bitmapRepFlags {
        unsigned int bitsPerPixel:8;	
	unsigned int isPlanar:1;
	unsigned int explicitPlanes:1;
	unsigned int isUnpacked:1;
	unsigned int dataLoaded:1;
        unsigned int numColors:4;	
        unsigned int memory:2;
        unsigned int compressionFactor:14;
        unsigned int imageNumber:12;
	unsigned int compression:20;
    } _moreRepFlags;
    unsigned int _bytesPerRow;
    unsigned char *_data;
    NSData *_tiffData;
    id _properties;
}

- (id)initWithFocusedViewRect:(NSRect)rect;

- (id)initWithBitmapDataPlanes:(unsigned char **)planes pixelsWide:(int)width pixelsHigh:(int)height bitsPerSample:(int)bps samplesPerPixel:(int)spp hasAlpha:(BOOL)alpha isPlanar:(BOOL)isPlanar colorSpaceName:(NSString *)colorSpaceName bytesPerRow:(int)rBytes bitsPerPixel:(int)pBits; 

+ (NSArray *)imageRepsWithData:(NSData *)tiffData;	

+ (id)imageRepWithData:(NSData *)tiffData;	
- (id)initWithData:(NSData *)tiffData;

- (unsigned char *)bitmapData;
- (void)getBitmapDataPlanes:(unsigned char **)data;
- (BOOL)isPlanar;
- (int)samplesPerPixel;
- (int)bitsPerPixel;
- (int)bytesPerRow;
- (int)bytesPerPlane;
- (int)numberOfPlanes;

- (void)getCompression:(NSTIFFCompression *)compression factor:(float *)factor;
- (void)setCompression:(NSTIFFCompression)compression factor:(float)factor;

- (NSData *)TIFFRepresentation;
- (NSData *)TIFFRepresentationUsingCompression:(NSTIFFCompression)comp factor:(float)factor;

+ (NSData *)TIFFRepresentationOfImageRepsInArray:(NSArray *)array;
+ (NSData *)TIFFRepresentationOfImageRepsInArray:(NSArray *)array usingCompression:(NSTIFFCompression)comp factor:(float)factor;

+ (void)getTIFFCompressionTypes:(const NSTIFFCompression **)list count:(int *)numTypes;
+ (NSString *)localizedNameForTIFFCompressionType:(NSTIFFCompression)compression;
- (BOOL)canBeCompressedUsing:(NSTIFFCompression)compression;


- (void)colorizeByMappingGray:(float)midPoint toColor:(NSColor *)midPointColor blackMapping:(NSColor *)shadowColor whiteMapping:(NSColor *)lightColor;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (id)initForIncrementalLoad;
- (int)incrementalLoadFromData:(NSData*)data complete:(BOOL)complete;
#endif

|#
; #ifdef WIN32
#| #|

@interface NSBitmapImageRep (NSWindowsExtensions)
- (id)initWithIconHandle:(void * )icon;
- (id)initWithBitmapHandle:(void * )bitmap;
@end

#endif
|#
 |#
#| @INTERFACE 
NSBitmapImageRep (NSBitmapImageFileTypeExtensions)

+ (NSData *)representationOfImageRepsInArray:(NSArray *)imageReps usingType:(NSBitmapImageFileType)storageType properties:(NSDictionary *)properties;

- (NSData *)representationUsingType:(NSBitmapImageFileType)storageType properties:(NSDictionary *)properties;

- (void)setProperty:(NSString *)property withValue:(id)value;
- (id)valueForProperty:(NSString *)property;

|#

(provide-interface "NSBitmapImageRep")