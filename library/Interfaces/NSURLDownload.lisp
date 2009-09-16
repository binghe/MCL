(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSURLDownload.h"
; at Sunday July 2,2006 7:31:04 pm.
; 	
;     NSURLDownload.h
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
;     @class NSURLDownload
;     @discussion A NSURLDownload loads a request and saves the downloaded data to a file. The progress of the download
;     is reported via the NSURLDownloadDelegate protocol. Note: The word "download" is used to refer to the process
;     of loading data off a network, decoding the data if necessary and saving the data to a file.
; 
#| @INTERFACE 
NSURLDownload : NSObject
{
    private
    NSURLDownloadInternal *_internal;
}


- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate;


- (void)cancel;


- (void)setDestination:(NSString *)path allowOverwrite:(BOOL)allowOverwrite;


- (NSURLRequest *)request;

|#
; !
;     @protocol NSURLDownloadDelegate
;     @discussion The NSURLDownloadDelegate delegate is used to report the progress of the download.
; 
#| @INTERFACE 
NSObject (NSURLDownloadDelegate)


- (void)downloadDidBegin:(NSURLDownload *)download;


- (NSURLRequest *)download:(NSURLDownload *)download willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse;


- (void)download:(NSURLDownload *)download didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;


- (void)download:(NSURLDownload *)download didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;


- (void)download:(NSURLDownload *)download didReceiveResponse:(NSURLResponse *)response;


- (void)download:(NSURLDownload *)download didReceiveDataOfLength:(unsigned)length;


- (BOOL)download:(NSURLDownload *)download shouldDecodeSourceDataOfMIMEType:(NSString *)encodingType;


- (void)download:(NSURLDownload *)download decideDestinationWithSuggestedFilename:(NSString *)filename;


- (void)download:(NSURLDownload *)download didCreateDestination:(NSString *)path;


- (void)downloadDidFinish:(NSURLDownload *)download;


- (void)download:(NSURLDownload *)download didFailWithError:(NSError *)error;

|#

; #endif


(provide-interface "NSURLDownload")