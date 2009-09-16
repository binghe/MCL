(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSNetServices.h"
; at Sunday July 2,2006 7:30:53 pm.
; 	NSNetServices.h
;         Copyright 2002-2003, Apple, Inc. All rights reserved.
; 

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

; #import <Foundation/NSObject.h>
(def-mactype :NSNetServicesErrorCode (find-mactype '(:pointer :NSString)))
(def-mactype :NSNetServicesErrorDomain (find-mactype '(:pointer :NSString)))

(defconstant $NSNetServicesUnknownError -72000)
(defconstant $NSNetServicesCollisionError -72001)
(defconstant $NSNetServicesNotFoundError -72002)
(defconstant $NSNetServicesActivityInProgress -72003)
(defconstant $NSNetServicesBadArgumentError -72004)
(defconstant $NSNetServicesCancelledError -72005)
(defconstant $NSNetServicesInvalidError -72006)
(def-mactype :NSNetServicesError (find-mactype ':SINT32))
#| @INTERFACE 
NSNetService : NSObject {
private
    void * _netService;
    id _delegate;
    void * _reserved;
}

- (id)initWithDomain:(NSString *)domain type:(NSString *)type name:(NSString *)name port:(int)port;

- (id)initWithDomain:(NSString *)domain type:(NSString *)type name:(NSString *)name;

- (id)delegate;
- (void)setDelegate:(id)delegate;

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;
- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;

- (NSString *)domain;
- (NSString *)type;
- (NSString *)name;

- (NSString *)protocolSpecificInformation;
- (void)setProtocolSpecificInformation:(NSString *)specificInformation;

- (NSArray *)addresses;

- (void)publish;

- (void)resolve;

- (void)stop;
|#
#| @INTERFACE 
NSNetServiceBrowser : NSObject {
private
    void * _netServiceBrowser;
    id _delegate;
    void * _reserved;
}

- (id)init;

- (id)delegate;
- (void)setDelegate:(id)delegate;

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;
- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode;

- (void)searchForAllDomains;

- (void)searchForRegistrationDomains;

- (void)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domainString;

- (void)stop;
|#
#| @INTERFACE 
NSObject (NSNetServiceDelegateMethods)
- (void)netServiceWillPublish:(NSNetService *)sender;

- (void)netServiceWillResolve:(NSNetService *)sender;

- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary *)errorDict;

- (void)netServiceDidResolveAddress:(NSNetService *)sender;

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict;

- (void)netServiceDidStop:(NSNetService *)sender;
|#
#| @INTERFACE 
NSObject (NSNetServiceBrowserDelegateMethods)
- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)aNetServiceBrowser;

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindDomain:(NSString *)domainString moreComing:(BOOL)moreComing;

 - (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing;

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didNotSearch:(NSDictionary *)errorDict;

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)aNetServiceBrowser;

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveDomain:(NSString *)domainString moreComing:(BOOL)moreComing;

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing;
|#

; #endif


(provide-interface "NSNetServices")