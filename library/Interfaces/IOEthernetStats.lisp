(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOEthernetStats.h"
; at Sunday July 2,2006 7:28:54 pm.
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
; 
;  * Copyright (c) 1999 Apple Computer, Inc.  All rights reserved. 
;  *
;  * IOEthernetStats.h - Ethernet MIB statistics definitions.
;  *
;  * HISTORY
;  
; #ifndef _IOETHERNETSTATS_H
; #define _IOETHERNETSTATS_H
; ! @header IOEthernetStats.h
;     @discussion Ethernet statistics. 
; ---------------------------------------------------------------------------
;  Ethernet-like statistics group.
; ! @typedef IODot3StatsEntry
;     @discussion Ethernet MIB statistics structure.
;     @field alignmentErrors            dot3StatsAlignmentErrors.
;     @field fcsErrors                  dot3StatsFCSErrors.
;     @field singleCollisionFrames      dot3StatsSingleCollisionFrames.
;     @field multipleCollisionFrames    dot3StatsMultipleCollisionFrames.
;     @field sqeTestErrors              dot3StatsSQETestErrors.
;     @field deferredTransmissions      dot3StatsDeferredTransmissions.
;     @field lateCollisions             dot3StatsLateCollisions.
;     @field excessiveCollisions        dot3StatsExcessiveCollisions.
;     @field internalMacTransmitErrors  dot3StatsInternalMacTransmitErrors.
;     @field carrierSenseErrors         dot3StatsCarrierSenseErrors.
;     @field frameTooLongs              dot3StatsFrameTooLongs.
;     @field internalMacReceiveErrors   dot3StatsInternalMacReceiveErrors.
;     @field etherChipSet               dot3StatsEtherChipSet.
;     @field missedFrames               dot3StatsMissedFrames (not in RFC1650).
;     
(defrecord IODot3StatsEntry
   (alignmentErrors :UInt32)
   (fcsErrors :UInt32)
   (singleCollisionFrames :UInt32)
   (multipleCollisionFrames :UInt32)
   (sqeTestErrors :UInt32)
   (deferredTransmissions :UInt32)
   (lateCollisions :UInt32)
   (excessiveCollisions :UInt32)
   (internalMacTransmitErrors :UInt32)
   (carrierSenseErrors :UInt32)
   (frameTooLongs :UInt32)
   (internalMacReceiveErrors :UInt32)
   (etherChipSet :UInt32)
   (missedFrames :UInt32)
)
; ---------------------------------------------------------------------------
;  Ethernet-like collision statistics group (optional).
; ! @typedef IODot3CollEntry
;     @discussion Collision statistics structure.
;     @field collFrequencies            dot3StatsCollFrequencies. 
(defrecord IODot3CollEntry   (collFrequencies (:array :UInt32 16))
)
; ---------------------------------------------------------------------------
;  Receiver extra statistics group (not defined by RFC 1650).
; ! @typedef IODot3RxExtraEntry
;     @discussion Extra receiver statistics not defined by RFC1650.
;     @field overruns            receiver overruns.
;     @field watchdogTimeouts    watchdog timer expirations.
;     @field frameTooShorts      runt frames.
;     @field collisionErrors     frames damages by late collision.
;     @field phyErrors           PHY receive errors.
;     @field timeouts            receiver timeouts.
;     @field interrupts          receiver interrupts.
;     @field resets              receiver resets.
;     @field resourceErrors      receiver resource shortages.
;     
(defrecord IODot3RxExtraEntry
   (overruns :UInt32)
   (watchdogTimeouts :UInt32)
   (frameTooShorts :UInt32)
   (collisionErrors :UInt32)
   (phyErrors :UInt32)
   (timeouts :UInt32)
   (interrupts :UInt32)
   (resets :UInt32)
   (resourceErrors :UInt32)
   (reserved (:array :UInt32 4))
)
; ---------------------------------------------------------------------------
;  Transmitter extra statistics group (not defined by RFC 1650).
; ! @typedef IODot3TxExtraEntry
;     @discussion Extra transmitter statistics not defined by RFC1650.
;     @field underruns           transmit underruns.
;     @field jabbers             jabber events.
;     @field phyErrors           PHY transmit errors.
;     @field timeouts            transmitter timeouts.
;     @field interrupts          transmitter interrupts.
;     @field resets              transmitter resets.
;     @field resourceErrors      transmitter resource shortages.
;     
(defrecord IODot3TxExtraEntry
   (underruns :UInt32)
   (jabbers :UInt32)
   (phyErrors :UInt32)
   (timeouts :UInt32)
   (interrupts :UInt32)
   (resets :UInt32)
   (resourceErrors :UInt32)
   (reserved (:array :UInt32 4))
)
; ---------------------------------------------------------------------------
;  Aggregate Ethernet statistics.
; ! @typedef IOEthernetStats
;     @discussion Aggregate Ethernet statistics structure.
;     @field dot3StatsEntry      IODot3StatsEntry statistics group.
;     @field dot3CollEntry       IODot3CollEntry statistics group.
;     @field dot3RxExtraEntry    IODot3RxExtraEntry statistics group.
;     @field dot3TxExtraEntry    IODot3TxExtraEntry statistics group.
;     
(defrecord IOEthernetStats
   (dot3StatsEntry :IODOT3STATSENTRY)
   (dot3CollEntry :IODOT3COLLENTRY)
   (dot3RxExtraEntry :IODOT3RXEXTRAENTRY)
   (dot3TxExtraEntry :IODOT3TXEXTRAENTRY)
)
; ! @defined kIOEthernetStatsKey
;     @discussion Defines the name of an IONetworkData that contains
;     an IOEthernetStats. 
(defconstant $kIOEthernetStatsKey "IOEthernetStatsKey")
; #define kIOEthernetStatsKey             "IOEthernetStatsKey"

; #endif /* !_IOETHERNETSTATS_H */


(provide-interface "IOEthernetStats")