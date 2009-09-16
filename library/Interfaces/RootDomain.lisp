(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:RootDomain.h"
; at Sunday July 2,2006 7:28:32 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _IOKIT_ROOTDOMAIN_H
; #define _IOKIT_ROOTDOMAIN_H

(require-interface "IOKit/IOService")

(require-interface "IOKit/pwr_mgt/IOPM")

#|class IOPMPowerStateQueue;
|#

#|class RootDomainUserClient;
|#
(defconstant $kRootDomainSupportedFeatures "Supported Features")
; #define kRootDomainSupportedFeatures "Supported Features"

(defconstant $kRootDomainSleepNotSupported 0)
(defconstant $kRootDomainSleepSupported 1)
(defconstant $kFrameBufferDeepSleepSupported 2)
(defconstant $kPCICantSleep 4)
; Gag EXTERN "C" 

(deftrap-inline "_acknowledgeSleepWakeNotification" 
   ((ARGH :pointer)
   )
   :signed-long
() )

(deftrap-inline "_vetoSleepWakeNotification" 
   ((PMrefcon :pointer)
   )
   :signed-long
() )

(deftrap-inline "_rootDomainRestart" 
   (
   )
   :signed-long
() )

(deftrap-inline "_rootDomainShutdown" 
   (
   )
   :signed-long
() )
(defconstant $IOPM_ROOTDOMAIN_REV 2)
; #define IOPM_ROOTDOMAIN_REV		2
#|
 confused about CLASS IOPMrootDomain #\: public IOService #\{ OSDeclareDefaultStructors #\( IOPMrootDomain #\) public #\: class IOService * wrangler #\;;  we tickle the wrangler on button presses, etc
 static IOPMrootDomain * construct #\( void #\) #\; virtual bool start #\( IOService * provider #\) #\; virtual IOReturn setAggressiveness #\( unsigned long #\, unsigned long #\) #\; virtual IOReturn youAreRoot #\( void #\) #\; virtual IOReturn sleepSystem #\( void #\) #\; virtual IOReturn setProperties #\( OSObject * #\) #\; IOReturn shutdownSystem #\( void #\) #\; IOReturn restartSystem #\( void #\) #\; virtual IOReturn receivePowerNotification #\( UInt32 msg #\) #\; virtual void setSleepSupported #\( IOOptionBits flags #\) #\; virtual IOOptionBits getSleepSupported #\( #\) #\; virtual IOReturn requestPowerDomainState #\( IOPMPowerFlags #\, IOPowerConnection * #\, unsigned long #\) #\; virtual void handleSleepTimerExpiration #\( void #\) #\; void stopIgnoringClamshellEventsDuringWakeup #\( void #\) #\; void wakeFromDoze #\( void #\) #\; void broadcast_it #\( unsigned long #\, unsigned long #\) #\; void publishFeature #\( const char * feature #\) #\; void unIdleDevice #\( IOService * #\, unsigned long #\) #\; void announcePowerSourceChange #\( void #\) #\;;  Override of these methods for logging purposes.
 virtual IOReturn changePowerStateTo #\( unsigned long ordinal #\) #\; virtual IOReturn changePowerStateToPriv #\( unsigned long ordinal #\) #\; private #\: class IORootParent * patriarch #\;;  points to our parent
 long sleepSlider #\;                           ;  pref: idle time before idle sleep
 long longestNonSleepSlider #\;                 ;  pref: longest of other idle times
 long extraSleepDelay #\;                       ;  sleepSlider - longestNonSleepSlider
 thread_call_t extraSleepTimer #\;              ;  used to wait between say display idle and system idle
 thread_call_t clamshellWakeupIgnore #\;        ;  Used to ignore clamshell close events while we're waking from sleep
 virtual void powerChangeDone #\( unsigned long #\) #\; virtual void command_received #\( void * #\, void * #\, void * #\, void * #\) #\; virtual bool tellChangeDown #\( unsigned long stateNum #\) #\; virtual bool askChangeDown #\( unsigned long stateNum #\) #\; virtual void tellChangeUp #\( unsigned long #\) #\; virtual void tellNoChangeDown #\( unsigned long #\) #\; void reportUserInput #\( void #\) #\; static IOReturn sysPowerDownHandler #\( void * target #\, void * refCon #\, UInt32 messageType #\, IOService * service #\, void * messageArgument #\, vm_size_t argSize #\) #\; static IOReturn displayWranglerNotification #\( void * target #\, void * refCon #\, UInt32 messageType #\, IOService * service #\, void * messageArgument #\, vm_size_t argSize #\) #\; static bool displayWranglerPublished #\( void * target #\, void * refCon #\, IOService * newService #\) #\; void setQuickSpinDownTimeout #\( void #\) #\; void adjustPowerState #\( void #\) #\; void restoreUserSpinDownTimeout #\( void #\) #\; IOPMPowerStateQueue * pmPowerStateQueue #\; unsigned int user_spindown #\;;  User's selected disk spindown value
 unsigned int systemBooting #\: 1 #\; unsigned int ignoringClamshell #\: 1 #\; unsigned int allowSleep #\: 1 #\; unsigned int sleepIsSupported #\: 1 #\; unsigned int canSleep #\: 1 #\; unsigned int idleSleepPending #\: 1 #\; unsigned int sleepASAP #\: 1 #\; unsigned int desktopMode #\: 1 #\; unsigned int acAdaptorConnect #\: 1 #\; unsigned int ignoringClamshellDuringWakeup #\: 1 #\; unsigned int reservedA #\: 6 #\; unsigned char reservedB #\[ 3 #\] #\; thread_call_t diskSyncCalloutEntry #\; IOOptionBits platformSleepSupport #\;
|#
#|
 confused about CLASS IORootParent #\: public IOService #\{ OSDeclareDefaultStructors #\( IORootParent #\) private #\: unsigned long mostRecentChange #\; public #\: bool start #\( IOService * nub #\) #\; void shutDownSystem #\( void #\) #\; void restartSystem #\( void #\) #\; void sleepSystem #\( void #\) #\; void dozeSystem #\( void #\) #\; void sleepToDoze #\( void #\) #\; void wakeSystem #\( void #\) #\;
|#

; #endif /*  _IOKIT_ROOTDOMAIN_H */


(provide-interface "RootDomain")