(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSMailDelivery.h"
; at Sunday July 2,2006 7:30:51 pm.
; 
;         NSMailDelivery.h
;         Message Framework
;         Copyright (c) 1997, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/Foundation.h>

; #import <Message/MessageExport.h>
#| @INTERFACE 
NSMailDelivery : NSObject
{
}

+ (BOOL)hasDeliveryClassBeenConfigured;
    
+ (BOOL)deliverMessage: (NSAttributedString *)messageBody headers: (NSDictionary *)messageHeaders format: (NSString *)messageFormat protocol: (NSString *)deliveryProtocol;
                                                    

+ (BOOL)deliverMessage:(NSString *)messageBody subject:(NSString *)messageSubject to:(NSString *)destinationAddress;
                            

|#
(def-mactype :NSMIMEMailFormat (find-mactype '(:pointer :NSString)))
(def-mactype :NSASCIIMailFormat (find-mactype '(:pointer :NSString)))
;  String constants used to specify the format in the
;  +deliverMessage:headers:format:protocol: method.
(def-mactype :NSSMTPDeliveryProtocol (find-mactype '(:pointer :NSString)))
;  String constants used to specify the delivery protocol
;  in the +deliverMessage:headers:format:protocol: method.
(def-mactype :NSSendmailDeliveryProtocol (find-mactype '(:pointer :NSString)))
;  Sendmail is no longer a supported sending protocol.  Invoking
;  deliveryMessage:headers:format:protocol: with this protocol
;  specified will immediately return NO and the message will
;  not be delivered.  

(provide-interface "NSMailDelivery")