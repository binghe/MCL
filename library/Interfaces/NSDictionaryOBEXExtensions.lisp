(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSDictionaryOBEXExtensions.h"
; at Sunday July 2,2006 7:30:46 pm.
; 
; 	Contains:	
; 
; 	Version:	xxx put version here xxx
; 
; 	Copyright:	(C) 2002-2003 by Apple Computer, Inc., all rights reserved.
; 

; #import <IOKit/IOKitLib.h>

; #import <stdlib.h>

; #import <IOBluetooth/OBEX.h>
#| @INTERFACE 
NSMutableDictionary (NSDictionaryOBEXExtensions)



+(NSDictionary*)withOBEXHeadersData:(const void*)inHeadersData headersDataSize:(size_t)inDataSize;



-(NSMutableData *)getHeaderBytes;



-(OBEXError)addTargetHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addHTTPHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addBodyHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength endOfBody:(BOOL)isEndOfBody;
-(OBEXError)addWhoHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addConnectionIDHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addApplicationParameterHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addByteSequenceHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addObjectClassHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addAuthorizationChallengeHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addAuthorizationResponseHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addTimeISOHeader:(const void*)inHeaderData	length:(uint32_t)inHeaderDataLength;
-(OBEXError)addTypeHeader:(NSString*)type;
-(OBEXError)addLengthHeader:(uint32_t)length;
-(OBEXError)addTime4ByteHeader:(uint32_t)time4Byte;
-(OBEXError)addCountHeader:(uint32_t)inCount;
-(OBEXError)addDescriptionHeader:(NSString*)inDescriptionString;
-(OBEXError)addNameHeader:(NSString*)inNameString;


|#

(provide-interface "NSDictionaryOBEXExtensions")