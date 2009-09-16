(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OSAtomic.h"
; at Sunday July 2,2006 7:31:09 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
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
;  * HISTORY
;  *
;  
; #ifndef _OS_OSATOMIC_H
; #define _OS_OSATOMIC_H

(require-interface "libkern/OSBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; ! @function OSCompareAndSwap
;     @abstract Compare and swap operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSCompareAndSwap function compares the value at the specified address with oldVal. The value of newValue is written to the address only if oldValue and the value at the address are equal. OSCompareAndSwap returns true if newValue is written to the address; otherwise, it returns false.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param oldValue The value to compare at address.
;     @param newValue The value to write to address if oldValue compares true.
;     @param address The 4-byte aligned address of the data to update atomically.
;     @result true if newValue was written to the address. 

(deftrap-inline "_OSCompareAndSwap" 
   ((oldValue :UInt32)
    (newValue :UInt32)
    (address (:pointer :UInt32))
   )
   :Boolean
() )
; ! @function OSAddAtomic
;     @abstract 32-bit add operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSAddAtomic function adds the specified amount to the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param amount The amount to add.
;     @param address The 4-byte aligned address of the value to update atomically.
;     @result The value before the addition 

(deftrap-inline "_OSAddAtomic" 
   ((amount :SInt32)
    (address (:pointer :SInt32))
   )
   :SInt32
() )
; ! @function OSAddAtomic16
;     @abstract 16-bit add operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSAddAtomic16 function adds the specified amount to the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param amount The amount to add.
;     @param address The 2-byte aligned address of the value to update atomically.
;     @result The value before the addition 

(deftrap-inline "_OSAddAtomic16" 
   ((amount :SInt32)
    (address (:pointer :SInt16))
   )
   :SInt16
() )
; ! @function OSAddAtomic8
;     @abstract 8-bit add operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSAddAtomic8 function adds the specified amount to the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param amount The amount to add.
;     @param address The address of the value to update atomically.
;     @result The value before the addition 

(deftrap-inline "_OSAddAtomic8" 
   ((amount :SInt32)
    (address (:pointer :SInt8))
   )
   :SInt8
() )
; ! @function OSIncrementAtomic
;     @abstract 32-bit increment operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSIncrementAtomic function increments the value at the specified address by one and returns the value as it was before the change.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param address The 4-byte aligned address of the value to update atomically.
;     @result The value before the increment. 

(deftrap-inline "_OSIncrementAtomic" 
   ((address (:pointer :SInt32))
   )
   :SInt32
() )
; ! @function OSIncrementAtomic16
;     @abstract 16-bit increment operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSIncrementAtomic16 function increments the value at the specified address by one and returns the value as it was before the change.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param address The 2-byte aligned address of the value to update atomically.
;     @result The value before the increment. 

(deftrap-inline "_OSIncrementAtomic16" 
   ((address (:pointer :SInt16))
   )
   :SInt16
() )
; ! @function OSIncrementAtomic8
;     @abstract 8-bit increment operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSIncrementAtomic8 function increments the value at the specified address by one and returns the value as it was before the change.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param address The address of the value to update atomically.
;     @result The value before the increment. 

(deftrap-inline "_OSIncrementAtomic8" 
   ((address (:pointer :SInt8))
   )
   :SInt8
() )
; ! @function OSDecrementAtomic
;     @abstract 32-bit decrement operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSDecrementAtomic function decrements the value at the specified address by one and returns the value as it was before the change.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param address The 4-byte aligned address of the value to update atomically.
;     @result The value before the decrement. 

(deftrap-inline "_OSDecrementAtomic" 
   ((address (:pointer :SInt32))
   )
   :SInt32
() )
; ! @function OSDecrementAtomic16
;     @abstract 16-bit decrement operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSDecrementAtomic16 function decrements the value at the specified address by one and returns the value as it was before the change.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param address The 2-byte aligned address of the value to update atomically.
;     @result The value before the decrement. 

(deftrap-inline "_OSDecrementAtomic16" 
   ((address (:pointer :SInt16))
   )
   :SInt16
() )
; ! @function OSDecrementAtomic8
;     @abstract 8-bit decrement operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSDecrementAtomic8 function decrements the value at the specified address by one and returns the value as it was before the change.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param address The address of the value to update atomically.
;     @result The value before the decrement. 

(deftrap-inline "_OSDecrementAtomic8" 
   ((address (:pointer :SInt8))
   )
   :SInt8
() )
; ! @function OSBitAndAtomic
;     @abstract 32-bit logical and operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSBitAndAtomic function logically ands the bits of the specified mask into the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param mask The mask to logically and with the value.
;     @param address The 4-byte aligned address of the value to update atomically.
;     @result The value before the bitwise operation 

(deftrap-inline "_OSBitAndAtomic" 
   ((mask :UInt32)
    (address (:pointer :UInt32))
   )
   :UInt32
() )
; ! @function OSBitAndAtomic16
;     @abstract 16-bit logical and operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSBitAndAtomic16 function logically ands the bits of the specified mask into the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param mask The mask to logically and with the value.
;     @param address The 2-byte aligned address of the value to update atomically.
;     @result The value before the bitwise operation. 

(deftrap-inline "_OSBitAndAtomic16" 
   ((mask :UInt32)
    (address (:pointer :UInt16))
   )
   :UInt16
() )
; ! @function OSBitAndAtomic8
;     @abstract 8-bit logical and operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSBitAndAtomic8 function logically ands the bits of the specified mask into the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param mask The mask to logically and with the value.
;     @param address The address of the value to update atomically.
;     @result The value before the bitwise operation. 

(deftrap-inline "_OSBitAndAtomic8" 
   ((mask :UInt32)
    (address (:pointer :UInt8))
   )
   :UInt8
() )
; ! @function OSBitOrAtomic
;     @abstract 32-bit logical or operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSBitOrAtomic function logically ors the bits of the specified mask into the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param mask The mask to logically or with the value.
;     @param address The 4-byte aligned address of the value to update atomically.
;     @result The value before the bitwise operation. 

(deftrap-inline "_OSBitOrAtomic" 
   ((mask :UInt32)
    (address (:pointer :UInt32))
   )
   :UInt32
() )
; ! @function OSBitOrAtomic16
;     @abstract 16-bit logical or operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSBitOrAtomic16 function logically ors the bits of the specified mask into the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param mask The mask to logically or with the value.
;     @param address The 2-byte aligned address of the value to update atomically.
;     @result The value before the bitwise operation. 

(deftrap-inline "_OSBitOrAtomic16" 
   ((mask :UInt32)
    (address (:pointer :UInt16))
   )
   :UInt16
() )
; ! @function OSBitOrAtomic8
;     @abstract 8-bit logical or operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @discussion The OSBitOrAtomic8 function logically ors the bits of the specified mask into the value at the specified address and returns the result.
;     @param mask The mask to logically or with the value.
;     @param address The address of the value to update atomically.
;     @result The value before the bitwise operation. 

(deftrap-inline "_OSBitOrAtomic8" 
   ((mask :UInt32)
    (address (:pointer :UInt8))
   )
   :UInt8
() )
; ! @function OSBitXorAtomic
;     @abstract 32-bit logical xor operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @discussion The OSBitXorAtomic function logically xors the bits of the specified mask into the value at the specified address and returns the result.
;     @param mask The mask to logically or with the value.
;     @param address The 4-byte aligned address of the value to update atomically.
;     @result The value before the bitwise operation. 

(deftrap-inline "_OSBitXorAtomic" 
   ((mask :UInt32)
    (address (:pointer :UInt32))
   )
   :UInt32
() )
; ! @function OSBitXorAtomic16
;     @abstract 16-bit logical xor operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSBitXorAtomic16 function logically xors the bits of the specified mask into the value at the specified address and returns the result.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param mask The mask to logically or with the value.
;     @param address The 2-byte aligned address of the value to update atomically.
;     @result The value before the bitwise operation. 

(deftrap-inline "_OSBitXorAtomic16" 
   ((mask :UInt32)
    (address (:pointer :UInt16))
   )
   :UInt16
() )
; ! @function OSBitXorAtomic8
;     @abstract 8-bit logical xor operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @discussion The OSBitXorAtomic8 function logically xors the bits of the specified mask into the value at the specified address and returns the result.
;     @param mask The mask to logically or with the value.
;     @param address The address of the value to update atomically.
;     @result The value before the bitwise operation. 

(deftrap-inline "_OSBitXorAtomic8" 
   ((mask :UInt32)
    (address (:pointer :UInt8))
   )
   :UInt8
() )
; ! @function OSTestAndSet
;     @abstract Bit test and set operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @discussion The OSTestAndSet function sets a single bit in a byte at a specified address. It returns true if the bit was already set, false otherwise.
;     @param bit The bit number in the range 0 through 7.
;     @param address The address of the byte to update atomically.
;     @result true if the bit was already set, false otherwise. 

(deftrap-inline "_OSTestAndSet" 
   ((bit :UInt32)
    (startAddress (:pointer :UInt8))
   )
   :Boolean
() )
; ! @function OSTestAndClear
;     @abstract Bit test and clear operation, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSTestAndClear function clears a single bit in a byte at a specified address. It returns true if the bit was already clear, false otherwise.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param bit The bit number in the range 0 through 7.
;     @param address The address of the byte to update atomically.
;     @result true if the bit was already clear, false otherwise. 

(deftrap-inline "_OSTestAndClear" 
   ((bit :UInt32)
    (startAddress (:pointer :UInt8))
   )
   :Boolean
() )
; ! @function OSEnqueueAtomic
;     @abstract Singly linked list head insertion, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSEnqueueAtomic function places an element at the head of a single linked list, which is specified with the address of a head pointer, listHead. The element structure has a next field whose offset is specified.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param listHead The address of a head pointer for the list .
;     @param element The list element to insert at the head of the list.
;     @param elementNextFieldOffset The byte offset into the element where a pointer to the next element in the list is stored. 

(deftrap-inline "_OSEnqueueAtomic" 
   ((listHead :pointer)
    (element :pointer)
    (elementNextFieldOffset :SInt32)
   )
   nil
() )
; ! @function OSDequeueAtomic
;     @abstract Singly linked list element head removal, performed atomically with respect to all devices that participate in the coherency architecture of the platform.
;     @discussion The OSDequeueAtomic function removes an element from the head of a single linked list, which is specified with the address of a head pointer, listHead. The element structure has a next field whose offset is specified.
; 
;     This function guarantees atomicity only with main system memory. It is specifically unsuitable for use on noncacheable memory such as that in devices; this function cannot guarantee atomicity, for example, on memory mapped from a PCI device.
;     @param listHead The address of a head pointer for the list .
;     @param elementNextFieldOffset The byte offset into the element where a pointer to the next element in the list is stored.
;     @result A removed element, or zero if the list is empty. 

(deftrap-inline "_OSDequeueAtomic" 
   ((listHead :pointer)
    (elementNextFieldOffset :SInt32)
   )
   (:pointer :void)
() )
; ! @function OSSynchronizeIO
;     @abstract The OSSynchronizeIO routine ensures orderly load and store operations to noncached memory mapped I/O devices.
;     @discussion The OSSynchronizeIO routine ensures orderly load and store operations to noncached memory mapped I/O devices. It executes the eieio instruction on PowerPC processors. 
#|
 confused about STATIC __inline__ void OSSynchronizeIO #\( void #\) #\{
; #if defined(__ppc__)
#|  __asm__ #\( "eieio" #\) #\;
 |#

; #endif

|#

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! _OS_OSATOMIC_H */


(provide-interface "OSAtomic")