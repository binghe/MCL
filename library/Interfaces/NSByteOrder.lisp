(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSByteOrder.h"
; at Sunday July 2,2006 7:30:37 pm.
; 	NSByteOrder.h
; 	Copyright (c) 1995-2003, Apple, Inc. All rights reserved.
; 

; #import <Foundation/NSObjCRuntime.h>

; #import <CoreFoundation/CFByteOrder.h>
(def-mactype :_NSByteOrder (find-mactype ':sint32))

(defconstant $NS_UnknownByteOrder 0)
(defconstant $NS_LittleEndian 1)
(defconstant $NS_BigEndian 2)
#|
unsigned NSHostByteOrder(void) {
    return CFByteOrderGetCurrent();
|#
#|
unsigned short NSSwapShort(unsigned short inv) {
    return CFSwapInt16(inv);
|#
#|
unsigned int NSSwapInt(unsigned int inv) {
    return CFSwapInt32(inv);
|#
#|
unsigned long NSSwapLong(unsigned long inv) {
    return CFSwapInt32(inv);
|#
#|
unsigned long long NSSwapLongLong(unsigned long long inv) {
    return CFSwapInt64(inv);
|#
#|
unsigned short NSSwapBigShortToHost(unsigned short x) {
    return CFSwapInt16BigToHost(x);
|#
#|
unsigned int NSSwapBigIntToHost(unsigned int x) {
    return CFSwapInt32BigToHost(x);
|#
#|
unsigned long NSSwapBigLongToHost(unsigned long x) {
    return CFSwapInt32BigToHost(x);
|#
#|
unsigned long long NSSwapBigLongLongToHost(unsigned long long x) {
    return CFSwapInt64BigToHost(x);
|#
#|
unsigned short NSSwapHostShortToBig(unsigned short x) {
    return CFSwapInt16HostToBig(x);
|#
#|
unsigned int NSSwapHostIntToBig(unsigned int x) {
    return CFSwapInt32HostToBig(x);
|#
#|
unsigned long NSSwapHostLongToBig(unsigned long x) {
    return CFSwapInt32HostToBig(x);
|#
#|
unsigned long long NSSwapHostLongLongToBig(unsigned long long x) {
    return CFSwapInt64HostToBig(x);
|#
#|
unsigned short NSSwapLittleShortToHost(unsigned short x) {
    return CFSwapInt16LittleToHost(x);
|#
#|
unsigned int NSSwapLittleIntToHost(unsigned int x) {
    return CFSwapInt32LittleToHost(x);
|#
#|
unsigned long NSSwapLittleLongToHost(unsigned long x) {
    return CFSwapInt32LittleToHost(x);
|#
#|
unsigned long long NSSwapLittleLongLongToHost(unsigned long long x) {
    return CFSwapInt64LittleToHost(x);
|#
#|
unsigned short NSSwapHostShortToLittle(unsigned short x) {
    return CFSwapInt16HostToLittle(x);
|#
#|
unsigned int NSSwapHostIntToLittle(unsigned int x) {
    return CFSwapInt32HostToLittle(x);
|#
#|
unsigned long NSSwapHostLongToLittle(unsigned long x) {
    return CFSwapInt32HostToLittle(x);
|#
#|
unsigned long long NSSwapHostLongLongToLittle(unsigned long long x) {
    return CFSwapInt64HostToLittle(x);
|#
(defrecord NSSwappedFloat
   (v :UInt32)
)
(defrecord NSSwappedDouble
   (long (:pointer :callback))                  ;(UInt32 v)
)
#|
NSSwappedFloat NSConvertHostFloatToSwapped(float x) {
    union fconv {
	float number;
	NSSwappedFloat sf;
    };
    return ((union fconv *)&x)->sf;
|#
#|
float NSConvertSwappedFloatToHost(NSSwappedFloat x) {
    union fconv {
	float number;
	NSSwappedFloat sf;
    };
    return ((union fconv *)&x)->number;
|#
#|
NSSwappedDouble NSConvertHostDoubleToSwapped(double x) {
    union dconv {
	double number;
	NSSwappedDouble sd;
    };
    return ((union dconv *)&x)->sd;
|#
#|
double NSConvertSwappedDoubleToHost(NSSwappedDouble x) {
    union dconv {
	double number;
	NSSwappedDouble sd;
    };
    return ((union dconv *)&x)->number;
|#
#|
NSSwappedFloat NSSwapFloat(NSSwappedFloat x) {
    x.v = NSSwapLong(x.v);
    return x;
|#
#|
NSSwappedDouble NSSwapDouble(NSSwappedDouble x) {
    x.v = NSSwapLongLong(x.v);
    return x;
|#

; #if defined(__BIG_ENDIAN__)
#|
double NSSwapBigDoubleToHost(NSSwappedDouble x) {
    return NSConvertSwappedDoubleToHost(x);
|#
#|
float NSSwapBigFloatToHost(NSSwappedFloat x) {
    return NSConvertSwappedFloatToHost(x);
|#
#|
NSSwappedDouble NSSwapHostDoubleToBig(double x) {
    return NSConvertHostDoubleToSwapped(x);
|#
#|
NSSwappedFloat NSSwapHostFloatToBig(float x) {
    return NSConvertHostFloatToSwapped(x);
|#
#|
double NSSwapLittleDoubleToHost(NSSwappedDouble x) {
    return NSConvertSwappedDoubleToHost(NSSwapDouble(x));
|#
#|
float NSSwapLittleFloatToHost(NSSwappedFloat x) {
    return NSConvertSwappedFloatToHost(NSSwapFloat(x));
|#
#|
NSSwappedDouble NSSwapHostDoubleToLittle(double x) {
    return NSSwapDouble(NSConvertHostDoubleToSwapped(x));
|#
#|
NSSwappedFloat NSSwapHostFloatToLittle(float x) {
    return NSSwapFloat(NSConvertHostFloatToSwapped(x));
|#
#| 
; #elif defined(__LITTLE_ENDIAN__)
#|
double NSSwapBigDoubleToHost(NSSwappedDouble x) {
    return NSConvertSwappedDoubleToHost(NSSwapDouble(x));
|#
#|
float NSSwapBigFloatToHost(NSSwappedFloat x) {
    return NSConvertSwappedFloatToHost(NSSwapFloat(x));
|#
#|
NSSwappedDouble NSSwapHostDoubleToBig(double x) {
    return NSSwapDouble(NSConvertHostDoubleToSwapped(x));
|#
#|
NSSwappedFloat NSSwapHostFloatToBig(float x) {
    return NSSwapFloat(NSConvertHostFloatToSwapped(x));
|#
#|
double NSSwapLittleDoubleToHost(NSSwappedDouble x) {
    return NSConvertSwappedDoubleToHost(x);
|#
#|
float NSSwapLittleFloatToHost(NSSwappedFloat x) {
    return NSConvertSwappedFloatToHost(x);
|#
#|
NSSwappedDouble NSSwapHostDoubleToLittle(double x) {
    return NSConvertHostDoubleToSwapped(x);
|#
#|
NSSwappedFloat NSSwapHostFloatToLittle(float x) {
    return NSConvertHostFloatToSwapped(x);
|#
 |#

; #else

; #error Do not know the endianess of this architecture

; #endif


(provide-interface "NSByteOrder")