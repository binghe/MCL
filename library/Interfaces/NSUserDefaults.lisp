(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSUserDefaults.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	NSUserDefaults.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObject.h>
(def-mactype :NSGlobalDomain (find-mactype '(:pointer :NSString)))
(def-mactype :NSArgumentDomain (find-mactype '(:pointer :NSString)))
(def-mactype :NSRegistrationDomain (find-mactype '(:pointer :NSString)))
#| @INTERFACE 
NSUserDefaults : NSObject {
private
    void *_preferences;
    NSMutableDictionary *_temp;
    NSString *_reserved;
    void *_reserved2;
    void *_reserved3;
}

+ (NSUserDefaults *)standardUserDefaults;
+ (void)resetStandardUserDefaults;

- (id)init;
- (id)initWithUser:(NSString *)username;

- (id)objectForKey:(NSString *)defaultName;
- (void)setObject:(id)value forKey:(NSString *)defaultName;
- (void)removeObjectForKey:(NSString *)defaultName;

- (NSString *)stringForKey:(NSString *)defaultName;
- (NSArray *)arrayForKey:(NSString *)defaultName;
- (NSDictionary *)dictionaryForKey:(NSString *)defaultName;
- (NSData *)dataForKey:(NSString *)defaultName;
- (NSArray *)stringArrayForKey:(NSString *)defaultName;
- (int)integerForKey:(NSString *)defaultName; 
- (float)floatForKey:(NSString *)defaultName; 
- (BOOL)boolForKey:(NSString *)defaultName;  

- (void)setInteger:(int)value forKey:(NSString *)defaultName;
- (void)setFloat:(float)value forKey:(NSString *)defaultName;
- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

- (void)registerDefaults:(NSDictionary *)registrationDictionary;

- (void)addSuiteNamed:(NSString *)suiteName;
- (void)removeSuiteNamed:(NSString *)suiteName;

- (NSDictionary *)dictionaryRepresentation;

- (NSArray *)volatileDomainNames;
- (NSDictionary *)volatileDomainForName:(NSString *)domainName;
- (void)setVolatileDomain:(NSDictionary *)domain forName:(NSString *)domainName;
- (void)removeVolatileDomainForName:(NSString *)domainName;

- (NSArray *)persistentDomainNames;
- (NSDictionary *)persistentDomainForName:(NSString *)domainName;
- (void)setPersistentDomain:(NSDictionary *)domain forName:(NSString *)domainName;
- (void)removePersistentDomainForName:(NSString *)domainName;

- (BOOL)synchronize;

#if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
- (BOOL)objectIsForcedForKey:(NSString *)key;
- (BOOL)objectIsForcedForKey:(NSString *)key inDomain:(NSString *)domain;
#endif


|#
(def-mactype :NSUserDefaultsDidChangeNotification (find-mactype '(:pointer :NSString)))
(def-mactype :NSWeekDayNameArray (find-mactype '(:pointer :NSString)))
(def-mactype :NSShortWeekDayNameArray (find-mactype '(:pointer :NSString)))
(def-mactype :NSMonthNameArray (find-mactype '(:pointer :NSString)))
(def-mactype :NSShortMonthNameArray (find-mactype '(:pointer :NSString)))
(def-mactype :NSTimeFormatString (find-mactype '(:pointer :NSString)))
(def-mactype :NSDateFormatString (find-mactype '(:pointer :NSString)))
(def-mactype :NSTimeDateFormatString (find-mactype '(:pointer :NSString)))
(def-mactype :NSShortTimeDateFormatString (find-mactype '(:pointer :NSString)))
(def-mactype :NSCurrencySymbol (find-mactype '(:pointer :NSString)))
(def-mactype :NSDecimalSeparator (find-mactype '(:pointer :NSString)))
(def-mactype :NSThousandsSeparator (find-mactype '(:pointer :NSString)))
(def-mactype :NSDecimalDigits (find-mactype '(:pointer :NSString)))
(def-mactype :NSAMPMDesignation (find-mactype '(:pointer :NSString)))
(def-mactype :NSHourNameDesignations (find-mactype '(:pointer :NSString)))
(def-mactype :NSYearMonthWeekDesignations (find-mactype '(:pointer :NSString)))
(def-mactype :NSEarlierTimeDesignations (find-mactype '(:pointer :NSString)))
(def-mactype :NSLaterTimeDesignations (find-mactype '(:pointer :NSString)))
(def-mactype :NSThisDayDesignations (find-mactype '(:pointer :NSString)))
(def-mactype :NSNextDayDesignations (find-mactype '(:pointer :NSString)))
(def-mactype :NSNextNextDayDesignations (find-mactype '(:pointer :NSString)))
(def-mactype :NSPriorDayDesignations (find-mactype '(:pointer :NSString)))
(def-mactype :NSDateTimeOrdering (find-mactype '(:pointer :NSString)))
(def-mactype :NSInternationalCurrencyString (find-mactype '(:pointer :NSString)))
(def-mactype :NSShortDateFormatString (find-mactype '(:pointer :NSString)))
(def-mactype :NSPositiveCurrencyFormatString (find-mactype '(:pointer :NSString)))
(def-mactype :NSNegativeCurrencyFormatString (find-mactype '(:pointer :NSString)))

(provide-interface "NSUserDefaults")