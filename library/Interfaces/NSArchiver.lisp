(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSArchiver.h"
; at Sunday July 2,2006 7:30:35 pm.
; 	NSArchiver.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSCoder.h>
; ***********		Archiving: Writing	***************
#| @INTERFACE 
NSArchiver : NSCoder {
private
    void		*mdata;
    void		*pointerTable;
    void		*stringTable;
    void		*ids;
    void		*map;
    void		*replacementTable;
    void		*reserved;
}

- (id)initForWritingWithMutableData:(NSMutableData *)mdata;
    
- (NSMutableData *)archiverData;

- (void)encodeRootObject:(id)rootObject;
- (void)encodeConditionalObject:(id)object;

+ (NSData *)archivedDataWithRootObject:(id)rootObject;

+ (BOOL)archiveRootObject:(id)rootObject toFile:(NSString *)path;

- (void)encodeClassName:(NSString *)trueName intoClassName:(NSString *)inArchiveName;
- (NSString *)classNameEncodedForTrueClassName:(NSString *)trueName;

- (void)replaceObject:(id)object withObject:(id)newObject;

|#
; ***********		Archiving: Reading		***************
#| @INTERFACE 
NSUnarchiver : NSCoder {
private
    void *		datax;
    unsigned		cursor;
    NSZone		*objectZone;
    unsigned		systemVersion;
    signed char		streamerVersion;
    char		swap;
    char		unused1;
    char		unused2;
    void		*pointerTable;
    void		*stringTable;
    void		*classVersions;
    int			lastLabel;
    void		*map;
    void		*allUnarchivedObjects;
    void		*reserved;
}

- (id)initForReadingWithData:(NSData *)data;

- (void)setObjectZone:(NSZone *)zone;
- (NSZone *)objectZone;

- (BOOL)isAtEnd;

- (unsigned)systemVersion;

+ (id)unarchiveObjectWithData:(NSData *)data;
+ (id)unarchiveObjectWithFile:(NSString *)path;

+ (void)decodeClassName:(NSString *)inArchiveName asClassName:(NSString *)trueName;

- (void)decodeClassName:(NSString *)inArchiveName asClassName:(NSString *)trueName;

+ (NSString *)classNameDecodedForArchiveClassName:(NSString *)inArchiveName;
- (NSString *)classNameDecodedForArchiveClassName:(NSString *)inArchiveName;

- (void)replaceObject:(id)object withObject:(id)newObject;

|#
; ***********		Exceptions		***************
(def-mactype :NSInconsistentArchiveException (find-mactype '(:pointer :NSString)))
; ***********		Object call back		***************
#| @INTERFACE 
NSObject (NSArchiverCallback)

- (Class)classForArchiver;
- (id)replacementObjectForArchiver:(NSArchiver *)archiver;

|#

(provide-interface "NSArchiver")