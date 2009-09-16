(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OBEXSession.h"
; at Sunday July 2,2006 7:31:07 pm.
; 
; 	File:		OBEXSession.h
; 	Contains:	OBEX session object.
;     Copyright:	й 2002 by Apple Computer, Inc. All rights reserved.
; 

; #import <IOKit/IOKitLib.h>

; #import <IOBluetooth/OBEX.h>
; #pragma mark еее Types еее

(def-mactype :PrivOBEXSessionDataRef (find-mactype '(:pointer :OpaquePrivOBEXSessionData)))
; ---------------------------------------------------------------------------------------------------------------------------
; !	@class			OBEXSession
; 	@abstract		Object representing an OBEX connection to a remote target.
; 	@discussion		You will have no need for a obtaining/using a raw OBEXSession, since it requires an underlying
; 					transport to do anything useful. However, once you have an object that is a subclass of this
; 					class, you can use the functions herein to manipulate that OBEXSession. First off, you will want
; 					to use OBEXConnect (if you are a client session) to actually cause the transport to open a
; 					connection to a remote target and establish an OBEX connection over it. From there you can issue
; 					more commands based on the responses from a server.
; 					
; 					If you are a server session, the first thing you should receive is an OBEXConnect command packet,
; 					and you will want to issue an OBEXConnectResponse packet, with your reesponse to that command
; 					(success, denied, bad request, etc.).
; 					
; 					You can use the session accessors to access certain information, such as the negotiated max
; 					packet length.
; 					
; 					If you wish to implement your own OBEXSession over a transport such as ethernet, you will need to
; 					see the end of the file to determine which functions to override, and what to pass to those
; 					functions.
; 					
; 					No timeout mechanism has been implemented so far for an OBEXSessions. If you need timeouts, you
; 					will need to implement them yourself. This is being explored for a future revision. However, be aware
; 					that the OBEX Specification does not explicitly require timeouts, so be sure you allow ample time
; 					for commands to complete, as some devices may be slow when sending large amounts of data.
; 
; #pragma mark -
; #pragma mark еее OBEXSession Interface еее
#| @INTERFACE 
OBEXSession : NSObject
{	
	
	
	BOOL							mHasOBEXConnection;						BOOL							mIsServer;								OBEXMaxPacketLength				mMaxPacketLength;						uint8_t*						mReceivePacketBuffer;					size_t							mResponsePacketDataLengthExpected;		size_t							mResponsePacketDataLengthSoFar;			OBEXOpCode						mIncompletePacketResponseCode;			PrivOBEXSessionDataRef			mPrivateOBEXSessionData;				OBEXMaxPacketLength				mTheirMaxPacketLength;					OBEXMaxPacketLength				mOurMaxPacketLength;				}

#if 0
#pragma mark -
#pragma mark """ Client Commands """
#endif



-(OBEXError)OBEXConnect:(OBEXFlags)inFlags
				maxPacketLength:(OBEXMaxPacketLength)inMaxPacketLength
				optionalHeaders:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;



-(OBEXError)OBEXDisconnect:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;
				


-(OBEXError)OBEXPut:(Boolean)isFinalChunk
				headersData:(void*)inHeadersData
				headersDataLength:(size_t)inHeadersDataLength
				bodyData:(void*)inBodyData
				bodyDataLength:(size_t)inBodyDataLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;



-(OBEXError)OBEXGet:(Boolean)isFinalChunk
				headers:(void*)inHeaders
				headersLength:(size_t)inHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;


			 		
-(OBEXError)OBEXAbort:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;



-(OBEXError)OBEXSetPath:(OBEXFlags)inFlags
				constants:(OBEXConstants)inConstants
				optionalHeaders:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;

#if 0
#pragma mark -
#pragma mark """ Server Command Responses """
#endif



-(OBEXError)OBEXConnectResponse:(OBEXOpCode)inResponseOpCode
				flags:(OBEXFlags)inFlags
				maxPacketLength:(OBEXMaxPacketLength)inMaxPacketLength
				optionalHeaders:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;



-(OBEXError)OBEXDisconnectResponse:(OBEXOpCode)inResponseOpCode
				optionalHeaders:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;



-(OBEXError)OBEXPutResponse:(OBEXOpCode)inResponseOpCode
				optionalHeaders:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;



-(OBEXError)OBEXGetResponse:(OBEXOpCode)inResponseOpCode
				optionalHeaders:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;



-(OBEXError)OBEXAbortResponse:(OBEXOpCode)inResponseOpCode
				optionalHeaders:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;



-(OBEXError)OBEXSetPathResponse:(OBEXOpCode)inResponseOpCode
				optionalHeaders:(void*)inOptionalHeaders
				optionalHeadersLength:(size_t)inOptionalHeadersLength
				eventSelector:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;

#if 0
#pragma mark -
#pragma mark """ Session Accessors """
#endif



-(OBEXMaxPacketLength)getAvailableCommandPayloadLength:(OBEXOpCode)inOpCode;



-(OBEXMaxPacketLength)getAvailableCommandResponsePayloadLength:(OBEXOpCode)inOpCode;



-(OBEXMaxPacketLength)getMaxPacketLength;



-(BOOL)hasOpenOBEXConnection;



-(void)setEventCallback:(OBEXSessionEventCallback)inEventCallback;



-(void)setEventRefCon:(void*)inRefCon;



-(void)setEventSelector:(SEL)inEventSelector
			target:(id)inEventSelectorTarget
			refCon:(id)inUserRefCon;
	
#if 0
#pragma mark -
#pragma mark """ Transport Subclassing """
#endif



typedef uint32_t	OBEXTransportEventType;
enum OBEXTransportEventTypes
{
	kOBEXTransportEventTypeDataReceived		= 'DatA',
	kOBEXTransportEventTypeStatus			= 'StaT'
};



typedef struct OBEXTransportEvent	OBEXTransportEvent;
struct OBEXTransportEvent
{	
	OBEXTransportEventType	type;
	OBEXError				status;	
	void *					dataPtr;
	size_t					dataLength;
};
	



-(void) serverHandleIncomingData:(OBEXTransportEvent*)event;




-(void) clientHandleIncomingData:(OBEXTransportEvent*)event;




-(OBEXError)sendDataToTransport:(void *)inDataToSend
			dataLength:(size_t)inDataLength;



-(OBEXError)openTransportConnection:(SEL)inSelector
				selectorTarget:(id)inTarget
				refCon:(void *)inUserRefCon;
				


-(Boolean)hasOpenTransportConnection;



-(OBEXError)closeTransportConnection;

|#

(provide-interface "OBEXSession")