(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLConnection.h"
; at Sunday July 2,2006 7:31:03 pm.
; 	
;     NSURLConnection.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 
;  Note: To use the APIs described in these headers, you must perform
;  a runtime check for Foundation-462.1 or later.

; #import <AvailabilityMacros.h>

; #if defined(MAC_OS_X_VERSION_10_2) && (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2)

; #import <Foundation/NSObject.h>
; !
;     @class NSURLConnection
;     
;     @abstract An NSURLConnection object provides support to perform
;     asynchronous loads of a URL request.
;     
;     @discussion The interface for NSURLConnection is very sparse,
;     providing only the controls to start and cancel asynchronous loads
;     of a URL request. Many times, as is the case in the
;     NSURLConnectionDelegate protocol, NSURLConnection instances are used
;     as tokens that uniquely identifies a particular load of a request
;     that have the same request and delegate, but actually are different.
;     <p>To load a URL request synchronously, see the
;     NSURLConnectionSynchronousLoading category on NSURLConnection.
; 
#| @INTERFACE 
NSURLConnection : NSObject
{
    private
    NSURLConnectionInternal *_internal;
}


+ (BOOL)canHandleRequest:(NSURLRequest *)request;


+ (NSURLConnection *)connectionWithRequest:(NSURLRequest *)request delegate:(id)delegate;


- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate;



- (void)cancel;

|#
; !
;     @category NSObject(NSURLConnectionDelegate)
; 
;     The NSURLConnectionDelegate category on NSObject defines
;     NSURLConnection delegate methods that can be implemented by
;     objects to receive informational callbacks about the asynchronous
;     load of a URL request. Other delegate methods provide hooks that
;     allow the delegate to customize the process of performing an
;     asynchronous URL load.
; 
;     <p>Note that all these will be called on the thread that started
;     the asynchronous load operation on the associated NSURLConnection
;     object.
;     <p>The following contract governs the delivery of the callbacks
;     defined in this interface:
;     <ul>
;     <li>Zero or more <tt>-connection:willSendRequest:redirectResponse:</tt> 
;     messages will be sent to the delegate before any other messages in this
;     list are sent.
;     <li>Before receiving a response or processing a redirect,
;     <tt>connection:didReceiveAuthenticationChallenge:</tt> may be
;     received if authentication is required.
;     <li>Zero or more <tt>connection:didReceiveResponse:</tt> messages
;     will be sent to the delegate before receiving a
;     <tt>-connection:didReceiveData:</tt> message. In rare cases, as will
;     occur in an HTTP load where the content type of the load data is
;     multipart/x-mixed-replace, the delegate will receive more than one
;     <tt>connection:didReceiveResponse:</tt> message. In the event this
;     occurs, delegates should discard all data previously delivered by
;     way of the <tt>-connection:didReceiveData:</tt>, and should be
;     prepared to handle the, potentially different, MIME type reported by
;     the NSURLResponse. Note that the only case where a response is not
;     sent to a delegate is when the protocol implemenation encounters an
;     error before a response could be created.
;     <li>Zero or more <tt>connection:didReceiveData:</tt> messages will
;     be sent before and of the following messages are sent to the
;     delegate:
;         <ul>
;         <li><tt>connection:willCacheResponse:</tt>
;         <li><tt>-connectionDidFinishLoading:</tt>
;         <li><tt>-connection:didFailWithError:</tt>
;         </ul>
;     <li>Zero or one <tt>connection:willCacheResponse:</tt> messages will
;     be sent to the delegate after <tt>connection:didReceiveData:</tt>
;     are sent but before a <tt>-connectionDidFinishLoading:</tt> message
;     is sent.
;     <li>Unless a NSURLConnection receives a <tt>-cancel</tt> message,
;     the delegate will receive one and only one of
;     <tt>-connectionDidFinishLoading:</tt>, or
;     <tt>-connection:didFailWithError:</tt> message, but never
;     both. In addition, once either of these callbacks is sent, the
;     delegate will receive no further callbacks of any kind for the
;     given NSURLConnection. 
;     </ul>
; 
#| @INTERFACE 
NSObject (NSURLConnectionDelegate)


- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response;


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;


- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;


- (void)connectionDidFinishLoading:(NSURLConnection *)connection;


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;


- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse;

|#
; !
;     @category NSURLConnection(NSURLConnectionSynchronousLoading)
;     The NSURLConnectionSynchronousLoading category on NSURLConnection
;     provides the interface to perform synchronous loading of URL
;     requests.
; 
#| @INTERFACE 
NSURLConnection (NSURLConnectionSynchronousLoading)


+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error;

|#

; #endif


(provide-interface "NSURLConnection")