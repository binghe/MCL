(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSEvent.h"
; at Sunday July 2,2006 7:30:47 pm.
; 
; 	NSEvent.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSDate.h>

; #import <Foundation/NSGeometry.h>
(def-mactype :_NSEventType (find-mactype ':sint32))
;  various types of events 

(defconstant $NSLeftMouseDown 1)
(defconstant $NSLeftMouseUp 2)
(defconstant $NSRightMouseDown 3)
(defconstant $NSRightMouseUp 4)
(defconstant $NSMouseMoved 5)
(defconstant $NSLeftMouseDragged 6)
(defconstant $NSRightMouseDragged 7)
(defconstant $NSMouseEntered 8)
(defconstant $NSMouseExited 9)
(defconstant $NSKeyDown 10)
(defconstant $NSKeyUp 11)
(defconstant $NSFlagsChanged 12)
(defconstant $NSAppKitDefined 13)
(defconstant $NSSystemDefined 14)
(defconstant $NSApplicationDefined 15)
(defconstant $NSPeriodic 16)
(defconstant $NSCursorUpdate 17)
(defconstant $NSScrollWheel 22)
(defconstant $NSOtherMouseDown 25)
(defconstant $NSOtherMouseUp 26)
(defconstant $NSOtherMouseDragged 27)
(def-mactype :NSEventType (find-mactype ':SINT32))
;  masks for the types of events 

(defconstant $NSLeftMouseDownMask 2)
(defconstant $NSLeftMouseUpMask 4)
(defconstant $NSRightMouseDownMask 8)
(defconstant $NSRightMouseUpMask 16)
(defconstant $NSMouseMovedMask 32)
(defconstant $NSLeftMouseDraggedMask 64)
(defconstant $NSRightMouseDraggedMask #x80)
(defconstant $NSMouseEnteredMask #x100)
(defconstant $NSMouseExitedMask #x200)
(defconstant $NSKeyDownMask #x400)
(defconstant $NSKeyUpMask #x800)
(defconstant $NSFlagsChangedMask #x1000)
(defconstant $NSAppKitDefinedMask #x2000)
(defconstant $NSSystemDefinedMask #x4000)
(defconstant $NSApplicationDefinedMask #x8000)
(defconstant $NSPeriodicMask #x10000)
(defconstant $NSCursorUpdateMask #x20000)
(defconstant $NSScrollWheelMask #x400000)
(defconstant $NSOtherMouseDownMask #x2000000)
(defconstant $NSOtherMouseUpMask #x4000000)
(defconstant $NSOtherMouseDraggedMask #x8000000)
(defconstant $NSAnyEventMask #xFFFFFFFF)
#|
unsigned int NSEventMaskFromType(NSEventType type) { return (1 << type); 
|#
;  Device-independent bits found in event modifier flags 

(defconstant $NSAlphaShiftKeyMask #x10000)
(defconstant $NSShiftKeyMask #x20000)
(defconstant $NSControlKeyMask #x40000)
(defconstant $NSAlternateKeyMask #x80000)
(defconstant $NSCommandKeyMask #x100000)
(defconstant $NSNumericPadKeyMask #x200000)
(defconstant $NSHelpKeyMask #x400000)
(defconstant $NSFunctionKeyMask #x800000)
#| @INTERFACE 
NSEvent : NSObject <NSCopying, NSCoding> {
    
    NSEventType _type;
    NSPoint _location;
    unsigned int _modifierFlags;
    int _WSTimestamp;
    NSTimeInterval _timestamp;
    int _windowNumber;
    NSWindow *_window;
    NSGraphicsContext* _context;
    union {
	struct {
	    int eventNumber;
	    int	clickCount;
	    float pressure;
	} mouse;
	struct {
	    NSString *keys;
	    NSString *unmodKeys;
	    unsigned short keyCode;
	    BOOL isARepeat;
	} key;
	struct {
	    int eventNumber;
	    int	trackingNumber;
	    void *userData;
	} tracking;
        struct {
            float    deltaX;
            float    deltaY;
            float    deltaZ; 
        } scrollWheel;
 	struct {
	    int subtype;
	    int data1;
	    int data2;
	} misc;
    } _data;
    void *_eventRef;
}



- (NSEventType)type;
- (NSPoint)locationInWindow;
- (unsigned int)modifierFlags;
- (NSTimeInterval)timestamp;
- (NSWindow *)window;
- (int)windowNumber;
- (NSGraphicsContext*)context;


- (int)clickCount;
- (float)pressure;
- (int)buttonNumber;	
- (int)eventNumber;


- (float)deltaX;	
- (float)deltaY;	
- (float)deltaZ;	

- (NSString *)characters;
- (NSString *)charactersIgnoringModifiers;
  
- (BOOL)isARepeat;

- (unsigned short)keyCode;		


- (int)trackingNumber;
- (void *)userData;


- (short)subtype;
- (int)data1;
- (int)data2;


+ (void)startPeriodicEventsAfterDelay:(NSTimeInterval)delay withPeriod:(NSTimeInterval)period;
+ (void)stopPeriodicEvents;


+ (NSEvent *)mouseEventWithType:(NSEventType)type location:(NSPoint)location modifierFlags:(unsigned int)flags timestamp:(NSTimeInterval)time windowNumber:(int)wNum context:(NSGraphicsContext*)context eventNumber:(int)eNum clickCount:(int)cNum pressure:(float)pressure;
+ (NSEvent *)keyEventWithType:(NSEventType)type location:(NSPoint)location modifierFlags:(unsigned int)flags timestamp:(NSTimeInterval)time windowNumber:(int)wNum context:(NSGraphicsContext*)context characters:(NSString *)keys charactersIgnoringModifiers:(NSString *)ukeys isARepeat:(BOOL)flag keyCode:(unsigned short)code;
+ (NSEvent *)enterExitEventWithType:(NSEventType)type location:(NSPoint)location modifierFlags:(unsigned int)flags timestamp:(NSTimeInterval)time windowNumber:(int)wNum context:(NSGraphicsContext*)context eventNumber:(int)eNum trackingNumber:(int)tNum userData:(void *)data;
+ (NSEvent *)otherEventWithType:(NSEventType)type location:(NSPoint)location modifierFlags:(unsigned int)flags timestamp:(NSTimeInterval)time windowNumber:(int)wNum context:(NSGraphicsContext*)context subtype:(short)subtype data1:(int)d1 data2:(int)d2;

+ (NSPoint)mouseLocation;

|#
;  Unicodes we reserve for function keys on the keyboard,  OpenStep reserves the range 0xF700-0xF8FF for this purpose.  The availability of various keys will be system dependent. 

(defconstant $NSUpArrowFunctionKey #xF700)
(defconstant $NSDownArrowFunctionKey #xF701)
(defconstant $NSLeftArrowFunctionKey #xF702)
(defconstant $NSRightArrowFunctionKey #xF703)
(defconstant $NSF1FunctionKey #xF704)
(defconstant $NSF2FunctionKey #xF705)
(defconstant $NSF3FunctionKey #xF706)
(defconstant $NSF4FunctionKey #xF707)
(defconstant $NSF5FunctionKey #xF708)
(defconstant $NSF6FunctionKey #xF709)
(defconstant $NSF7FunctionKey #xF70A)
(defconstant $NSF8FunctionKey #xF70B)
(defconstant $NSF9FunctionKey #xF70C)
(defconstant $NSF10FunctionKey #xF70D)
(defconstant $NSF11FunctionKey #xF70E)
(defconstant $NSF12FunctionKey #xF70F)
(defconstant $NSF13FunctionKey #xF710)
(defconstant $NSF14FunctionKey #xF711)
(defconstant $NSF15FunctionKey #xF712)
(defconstant $NSF16FunctionKey #xF713)
(defconstant $NSF17FunctionKey #xF714)
(defconstant $NSF18FunctionKey #xF715)
(defconstant $NSF19FunctionKey #xF716)
(defconstant $NSF20FunctionKey #xF717)
(defconstant $NSF21FunctionKey #xF718)
(defconstant $NSF22FunctionKey #xF719)
(defconstant $NSF23FunctionKey #xF71A)
(defconstant $NSF24FunctionKey #xF71B)
(defconstant $NSF25FunctionKey #xF71C)
(defconstant $NSF26FunctionKey #xF71D)
(defconstant $NSF27FunctionKey #xF71E)
(defconstant $NSF28FunctionKey #xF71F)
(defconstant $NSF29FunctionKey #xF720)
(defconstant $NSF30FunctionKey #xF721)
(defconstant $NSF31FunctionKey #xF722)
(defconstant $NSF32FunctionKey #xF723)
(defconstant $NSF33FunctionKey #xF724)
(defconstant $NSF34FunctionKey #xF725)
(defconstant $NSF35FunctionKey #xF726)
(defconstant $NSInsertFunctionKey #xF727)
(defconstant $NSDeleteFunctionKey #xF728)
(defconstant $NSHomeFunctionKey #xF729)
(defconstant $NSBeginFunctionKey #xF72A)
(defconstant $NSEndFunctionKey #xF72B)
(defconstant $NSPageUpFunctionKey #xF72C)
(defconstant $NSPageDownFunctionKey #xF72D)
(defconstant $NSPrintScreenFunctionKey #xF72E)
(defconstant $NSScrollLockFunctionKey #xF72F)
(defconstant $NSPauseFunctionKey #xF730)
(defconstant $NSSysReqFunctionKey #xF731)
(defconstant $NSBreakFunctionKey #xF732)
(defconstant $NSResetFunctionKey #xF733)
(defconstant $NSStopFunctionKey #xF734)
(defconstant $NSMenuFunctionKey #xF735)
(defconstant $NSUserFunctionKey #xF736)
(defconstant $NSSystemFunctionKey #xF737)
(defconstant $NSPrintFunctionKey #xF738)
(defconstant $NSClearLineFunctionKey #xF739)
(defconstant $NSClearDisplayFunctionKey #xF73A)
(defconstant $NSInsertLineFunctionKey #xF73B)
(defconstant $NSDeleteLineFunctionKey #xF73C)
(defconstant $NSInsertCharFunctionKey #xF73D)
(defconstant $NSDeleteCharFunctionKey #xF73E)
(defconstant $NSPrevFunctionKey #xF73F)
(defconstant $NSNextFunctionKey #xF740)
(defconstant $NSSelectFunctionKey #xF741)
(defconstant $NSExecuteFunctionKey #xF742)
(defconstant $NSUndoFunctionKey #xF743)
(defconstant $NSRedoFunctionKey #xF744)
(defconstant $NSFindFunctionKey #xF745)
(defconstant $NSHelpFunctionKey #xF746)
(defconstant $NSModeSwitchFunctionKey #xF747)
;  event subtypes for NSAppKitDefined events 

(defconstant $NSWindowExposedEventType 0)
(defconstant $NSApplicationActivatedEventType 1)
(defconstant $NSApplicationDeactivatedEventType 2)
(defconstant $NSWindowMovedEventType 4)
(defconstant $NSScreenChangedEventType 8)
(defconstant $NSAWTEventType 16)
;  event subtypes for NSSystemDefined events 

(defconstant $NSPowerOffEventType 1)

(provide-interface "NSEvent")