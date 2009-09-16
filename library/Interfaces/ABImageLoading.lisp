(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ABImageLoading.h"
; at Sunday July 2,2006 7:23:06 pm.
; 
;   ABImageLoading.h
;   AddressBook
; 
;   Copyright (c) 2002-2003 Apple Computer. All rights reserved.
; 

; #import <AddressBook/AddressBook.h>
#| @PROTOCOL 
ABImageClient <NSObject>
- (void)consumeImageData:(NSData *)data forTag:(int)tag;
        
|#
#| @INTERFACE 
ABPerson (ABPersonImageAdditions)

- (BOOL)setImageData:(NSData *)data;
        
- (NSData *)imageData;
        
- (int)beginLoadingImageDataForClient:(id<ABImageClient>)client;
            
+ (void)cancelLoadingImageDataForTag:(int)tag;
    
|#

(provide-interface "ABImageLoading")