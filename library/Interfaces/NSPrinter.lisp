(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSPrinter.h"
; at Sunday July 2,2006 7:30:56 pm.
; 
; 	NSPrinter.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSGeometry.h>

; #import <Foundation/NSObject.h>
;  Valid return values for -[NSPrinter statusForTable:].

(defconstant $NSPrinterTableOK 0)
(defconstant $NSPrinterTableNotFound 1)
(defconstant $NSPrinterTableError 2)
(def-mactype :NSPrinterTableStatus (find-mactype ':SINT32))
#| @INTERFACE 
NSPrinter: NSObject<NSCopying, NSCoding> {
    private
    unsigned char _44BytesOfPrivateData[44];
}

+ (NSArray *)printerNames;

+ (NSArray *)printerTypes;

+ (NSPrinter *)printerWithName:(NSString *)name;

+ (NSPrinter *)printerWithType:(NSString *)type;

- (NSString *)name;

- (NSString *)type;

- (int)languageLevel;

- (NSSize)pageSizeForPaper:(NSString *)paperName;

- (NSPrinterTableStatus)statusForTable:(NSString *)tableName;

- (BOOL)isKey:(NSString *)key inTable:(NSString *)table;
- (BOOL)booleanForKey:(NSString *)key inTable:(NSString *)table;
- (float)floatForKey:(NSString *)key inTable:(NSString *)table;
- (int)intForKey:(NSString *)key inTable:(NSString *)table;
- (NSRect)rectForKey:(NSString *)key inTable:(NSString *)table;
- (NSSize)sizeForKey:(NSString *)key inTable:(NSString *)table;
- (NSString *)stringForKey:(NSString *)key inTable:(NSString *)table;
- (NSArray *)stringListForKey:(NSString *)key inTable:(NSString *)table;

- (NSDictionary *)deviceDescription;

- (NSRect)imageRectForPaper:(NSString *)paperName;

- (BOOL)acceptsBinary;
- (BOOL)isColor;
- (BOOL)isFontAvailable:(NSString *)faceName;
- (BOOL)isOutputStackInReverseOrder;

+ (NSPrinter *)printerWithName:(NSString *)name domain:(NSString *)domain includeUnavailable:(BOOL)flag;
- (NSString *)domain;
- (NSString *)host;
- (NSString *)note;

|#

(provide-interface "NSPrinter")