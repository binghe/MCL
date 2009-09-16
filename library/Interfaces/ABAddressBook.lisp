(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABAddressBook.h"
; at Sunday July 2,2006 7:23:06 pm.
; 
;   ABAddressBook.h
;   AddressBook Framework
; 
;   Copyright (c) 2002-2003 Apple Computer. All rights reserved.
; 

; #import <AddressBook/ABTypedefs.h>

; #import <AddressBook/ABGlobals.h>
;  ================================================================
;       OpenURL support
;  ================================================================
;  An application can open the AddressBook app and select (and edit) a specific
;  person by using the -[NSWorkspace openURL:] API.
; 
;  To launch (or bring to front) the Address Book app and select a given person
; 
;  NSString *urlString = [NSString stringWithFormat:@"addressbook://%@", [aPerson uniqueId]];
;  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlString]];
; 
;  To launch (or bring to front) the Address Book app and edit a given person
; 
;  NSString *urlString = [NSString stringWithFormat:@"addressbook://%@?edit", [aPerson uniqueId]];
;  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlString]];
;  ================================================================
;       ABAddressBook
;  ================================================================
#| @INTERFACE 
ABAddressBook : NSObject
{
private
    id                   _personIndexer;
    NSMutableDictionary *_masterCache;

    NSMutableSet        *_insertedRecords;
    NSMutableSet        *_modifiedRecords;
    NSMutableSet        *_deletedRecords;
    NSMutableDictionary *_tableSchemas;
    NSMutableDictionary *_propertyTypes;
    void                *_converterPort;
    NSTimer             *_inactivityTimer;
    NSString            *_meUniqueId;

    unsigned int         _reserved1;

    struct __ABBookflags {
        unsigned int     hasUnsavedChanges:1;
        unsigned int     readOnly:1;
        unsigned int     importMe:1;
        unsigned int     needConversion:1;
        unsigned int     cleanedUp:1;
        unsigned int     importTips:1;
        unsigned int     _reserved:26;
    } _flags;
}

+ (ABAddressBook *)sharedAddressBook;
    
- (NSArray *)recordsMatchingSearchElement:(ABSearchElement *)search;
            
- (BOOL)save;
        
- (BOOL)hasUnsavedChanges;
        
- (ABPerson *)me;
        
- (void)setMe:(ABPerson *)moi;
        
- (ABRecord *)recordForUniqueId:(NSString *)uniqueId;
            
- (BOOL)addRecord:(ABRecord *)record;
            
- (BOOL)removeRecord:(ABRecord *)record;
            
- (NSArray *)people;
        
- (NSArray *)groups;
        
#if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (NSString *)recordClassFromUniqueId:(NSString *)uniqueId;
    
- (NSAttributedString *)formattedAddressFromDictionary:(NSDictionary *)address;
                
- (NSString *)defaultCountryCode;
    
- (int)defaultNameOrdering;
        
#endif
|#

(provide-interface "ABAddressBook")