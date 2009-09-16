(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRBurn.h"
; at Sunday July 2,2006 7:27:41 pm.
; 
;      File:       DiscRecordingEngine/DRBurn.h
;  
;      Contains:   Handles burning and obtaining status about a burn.
;  
;      Version:    Technology: Mac OS X
;                  Release:    Mac OS X
;  
;      Copyright:  (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 

; #import <Foundation/Foundation.h>

; #import <DiscRecordingEngine/DRCoreBurn.h>

; #import <DiscRecordingEngine/DRDevice.h>

; #import <DiscRecordingEngine/DRTrack.h>

; #import <AvailabilityMacros.h>
; !
; 	@class			DRBurn
; 	@abstract		Handles the process of burning a CD or DVD disc.
; 	@discussion		Each time you want to burn to a disc, an instance of this class needs to be created. 
; 					
; 					When an instance is created, you pass in an instance of DRDevice to let the DRBurn object know 
; 					what device to use. This object is retained for the life of the DRBurn instance. Before burning, 
; 					you can set several options that control (1) the behavior of the burn, and (2) the handling 
; 					of the disc once the burn completes.
; 					
; 					A DRBurn object will send out notifications through the DRNotificationCenter mechanism to 
; 					broadcast the burn state to any interested observers. However, if for some reason you don't want
; 					to use notifications, you can poll the burn object at any time for the current status using
; 					<b>status</b>. This is not recommended in any application using a run loop, because it involves polling.
; 
; 					Here's an example that shows you how to use this class:
; 					
; 					<code>
; 					- (void) doBurn
; 					{
; 						DRDevice*       device;
; 						DRTrack*        track;
; 						DRBurn*         burn;
; 					
; 						<i>...determine correct device to burn to...</i>
; 						
; 						<i>...create track...</i>
; 						
; 						burn = [[DRBurn alloc] initWithDevice:device];
; 							
; 						<i>...set options appropriate to this burn...</i>
; 						
; 						// register to receive notification about the burn status.
; 						[[DRNotificationCenter currentRunLoopCenter] addObserver:self 
; 																		selector:&#x40;selector(burnNotification:) 
; 																			name:DRBurnStatusChangedNotification 
; 																		  object:burn];
; 						// start the burn
; 						[burn writeLayout:track];
; 					}
; 					
; 					- (void) burnNotification:(NSNotification*)notification
; 					{
; 						DRBurn*         burn = [notification object];
; 						NSDictionary*   status = [notification userInfo];
; 						
; 						<i>...do what you wish with the notification...</i>
; 					}
; 					</code>
; 
#| @INTERFACE 
DRBurn : NSObject 
{ 
private
	void*	_ref;
}


+ (DRBurn*) burnForDevice:(DRDevice*)device;


- (id) initWithDevice:(DRDevice*)device;


- (void) writeLayout:(id)layout;


- (NSDictionary*) status;


- (void) abort;


- (NSDictionary*) properties;


- (void) setProperties:(NSDictionary*)properties;


- (DRDevice*) device;

|#
#| @INTERFACE 
DRBurn (PropertyConvenienceMethods)


- (float) requestedBurnSpeed;


- (void) setRequestedBurnSpeed:(float)speed;


- (BOOL) appendable;


- (void) setAppendable:(BOOL)appendable;


- (BOOL) verifyDisc;


- (void) setVerifyDisc:(BOOL)verify;


- (NSString*) completionAction;


- (void) setCompletionAction:(NSString*)action;

|#
;  --------------------------------------- 
;  Burn properties 

; #if 0
#| ; #pragma mark Burn Properties
 |#

; #endif

; !
; 	@const          DRBurnRequestedSpeedKey         
; 	@discussion     The burn property whose value is an NSNumber containing the speed at
; 					which the burn should run, expressed as a float value of kilobytes per second.
; 					If this key is not present, the speed will default to DRDeviceBurnSpeedMax.
; 
(def-mactype :DRBurnRequestedSpeedKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const          DRBurnAppendableKey
; 	@discussion     The burn property whose value is a BOOL indicating if the disc will still be 
; 					appendable after the burn. If this key is not present, the burn will default 
; 					to a value of <i>NO</i> and the disc will be marked as not appendable.
; 
(def-mactype :DRBurnAppendableKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const          DRBurnOverwriteDiscKey
; 	@discussion     The burn property whose value is a BOOL indicating if the disc will be overwritten
; 					from block zero for the burn. If this key is not present, the burn will default 
; 					to a value of <i>NO</i> and the disc will be appended.
; 
(def-mactype :DRBurnOverwriteDiscKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const			DRBurnVerifyDiscKey
; 	@discussion     The burn property whose value is a BOOL indicating if the disc will be verified 
; 					after being burned. If this key is not present, the burn will default to a
; 					value of <i>YES</i> and the disc will be verified.
; 
(def-mactype :DRBurnVerifyDiscKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const          DRBurnCompletionActionKey
; 	@discussion     The burn property whose value is an NSString containing one of the
; 					completion actions possible for the disc handling. If this key is not present,
; 					the burn will default to a value of <i>DRBurnCompletionActionEject</i> and the
; 					disc will be ejected.
; 
(def-mactype :DRBurnCompletionActionKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const			DRBurnUnderrunProtectionKey
; 	@discussion		The burn property whose value is a BOOL indicating if burn underrun protection 
; 					will be on or off for devices which support it.
; 	
; 					For those devices which support it, burn underrun protection is enabled 
; 					by default.
; 		
; 					If the device supports burn underrun protection and this key is not present,
; 					the burn will default to a value of <i>YES</i> and burn underrun protection 
; 					will be enabled.
; 
(def-mactype :DRBurnUnderrunProtectionKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const			DRBurnTestingKey
; 	@discussion		The burn property whose value is a BOOL indicating if the burn will run 
; 					as a test burn.
; 
; 					When this is set and the burn object is sent <b>writeLayout:</b>,
; 					the entire burn process proceeds as if data would be 
; 					written to the disc, but the laser is not turned on to full power, so
; 					the physical disc is not modified.
; 
;                     If this key is not present or the selected burning device does not support test burning,
; 					the burn will default to a value of <tt>false</tt> and a normal burn will occur.
; 
(def-mactype :DRBurnTestingKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const			DRSynchronousBehaviorKey
; 	@discussion		The burn property whose value is a BOOL indicating if burn operations
; 					will behave synchronously.  If this key is not present, it will default
; 					to a value of <tt>false</tt> and burn operations will behave asynchronously.
; 					
; 					Synchronous operations do not post status notifications, and will not
; 					return until they are completed.  Status can still be queried at any time,
; 					and will remain valid even after the burn operation has finished.
; 
(def-mactype :DRSynchronousBehaviorKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const			DRBurnFailureActionKey
; 	@discussion		The burn property whose value is an NSString containing a one of the failure
; 					actions possible for the disc handling.
; 					
; 					If this key is not present, the burn will default to a value of
; 					<tt>DRBurnFailureActionEject</tt> and the disc will be ejected.
; 
(def-mactype :DRBurnFailureActionKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const			DRMediaCatalogNumberKey
; 	@discussion		The burn property whose value is an NSData containing exactly 13 bytes of
; 					data, which will be written to the disc as the Media Catalog Number.
; 					If this key is not present, it will default to all zeroes, indicating
; 					that a MCN is not supplied.
; 					
; 					This value is the UPC/EAN product number, and should conform to the
; 					specifications of the UCC and EAN.  See http://www.ean-int.org/ and
; 					http://www.uc-council.org/ for more details on the UPC/EAN standard.
; 
(def-mactype :DRMediaCatalogNumberKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const			DRBurnStrategyKey
; 	@discussion		The burn property whose value is an NSString, or NSArray or NSStrings,
; 					indicating the burn strategy or strategies that are suggested.  If this
; 					key is not present, the burn engine picks an appropriate burn strategy
; 					automatically. Most clients will not need to specify a specific burn
; 					strategy.
; 					
; 					When more than one strategy is suggested, the burn engine will attempt
; 					to use the first strategy in the list which is available. A burn strategy
; 					will never be used if it cannot write the required data: for example, TAO
; 					cannot be used to write CD-Text.
; 					
; 					The presence of this key by itself is just a suggestion, and if the burn
; 					engine cannot fulfill the request it will burn using whatever strategy is
; 					available.  To make the suggestion into a requirement, add
; 					DRBurnStrategyIsRequired with a value of YES.
; 
(def-mactype :DRBurnStrategyKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const			DRBurnStrategyIsRequiredKey
; 	@discussion		The burn property whose value is a BOOL indicating whether the burn
; 					strategy/strategies listed for kDRBurnStrategyKey are
; 					the only strategies allowed.  If this key is not present,
; 					the burn will default to a value of <tt>false</tt>.
; 					
; 					If this value is set to <tt>true</tt>, and the device does
; 					not support the type(s) of burn requested, the burn
; 					will fail with kDRDeviceBurnStrategyNotAvailableErr.
; 					
; 					If this value is set to <tt>false</tt>, and the device does
; 					not support the type(s) of burn requested, the engine
; 					will choose an alternate burn strategy automatically - one
; 					that will provide an equivalent disc.
; 
(def-mactype :DRBurnStrategyIsRequiredKey (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  --------------------------------------- 
;  Completion actions 
; !
; 	@const			DRBurnCompletionActionEject
; 	@discussion		An NSString value for DRBurnCompletionActionKey indicating that the burn
; 					object should eject the disc from the drive when the burn completes.
; 
(def-mactype :DRBurnCompletionActionEject (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
; !
; 	@const			DRBurnCompletionActionMount
; 	@discussion		An NSString value for DRBurnCompletionActionKey indicating that the burn
; 					object should mount the disc on the desktop when the burn completes.
; 
(def-mactype :DRBurnCompletionActionMount (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
;  ---------------------------------- 
;  Failure actions 
; ! 
; 	@const			DRBurnFailureActionEject	
; 	@discussion		An NSString value for DRBurnCompletionActionKey indicating that the burn
; 					object should eject the disc from the drive if the burn fails.
; 
(def-mactype :DRBurnFailureActionEject (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; ! 
; 	@const			DRBurnFailureActionNone	
; 	@discussion		An NSString value for DRBurnCompletionActionKey indicating that the burn
; 					object should do nothing with the disc if the burn fails.
; 
(def-mactype :DRBurnFailureActionNone (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  --------------------------------------- 
;  Burn strategies 
; !
; 	@const			DRBurnStrategyCDTAO
; 	@discussion		An NSString value for DRBurnStrategyKey representing the TAO (track-at-once)
; 					burn strategy for CD.
; 
(def-mactype :DRBurnStrategyCDTAO (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const			DRBurnStrategyCDSAO
; 	@discussion		An NSString value for DRBurnStrategyKey representing the SAO (session-at-once)
; 					burn strategy for CD.
; 
(def-mactype :DRBurnStrategyCDSAO (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const			DRBurnStrategyCDRaw
; 	@discussion		An NSString value for DRBurnStrategyKey representing the raw mode
; 					burn strategy for CD.  Raw mode is sometimes incorrectly called DAO (disc-at-once).
; 
(def-mactype :DRBurnStrategyCDRaw (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
; !
; 	@const			DRBurnStrategyDVDDAO
; 	@discussion		An NSString value for DRBurnStrategyKey representing the DAO (disc-at-once)
; 					burn strategy for DVD.  This strategy applies <b>only</b> to DVDs; it is
; 					invalid when burning to CD media.
; 
(def-mactype :DRBurnStrategyDVDDAO (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

; #if 0
#| ; #pragma mark Burn Notifications
 |#

; #endif

;  --------------------------------------- 
;  Notifications 
; !
; 	@const		DRBurnStatusChangedNotification 
; 	@discussion	Posted by a DRNotificationCenter when the status of the
; 				burn operation has changed. 
; 	
; 				The object associated with this notification
; 				is the burn object sending it and the userInfo contains a dictionary
; 				detailing the status. 
; 
(def-mactype :DRBurnStatusChangedNotification (find-mactype '(:pointer :NSString))); AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER

(provide-interface "DRBurn")