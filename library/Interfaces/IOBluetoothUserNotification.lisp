(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOBluetoothUserNotification.h"
; at Sunday July 2,2006 7:28:35 pm.

; #import <Foundation/NSObject.h>
; !
;     @class IOBluetoothUserNotification
;     @abstract Represents a registered notification.
;     @discussion When registering for various notifications in the system, an IOBluetoothUserNotification
; 				object is returned.  To unregister from the notification, call -unregister on the
; 				IOBluetoothUserNotification object.  Once -unregister is called, the object will no
; 				longer be valid.
; 
#| @INTERFACE 
IOBluetoothUserNotification : NSObject
{
}



- (void)unregister;

|#

(provide-interface "IOBluetoothUserNotification")