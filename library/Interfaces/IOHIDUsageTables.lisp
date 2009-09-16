(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHIDUsageTables.h"
; at Sunday July 2,2006 7:29:15 pm.
; 
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * Copyright (c) 1999-2003 Apple Computer, Inc.  All Rights Reserved.
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _IOHIDUSAGETABLES_H
; #define _IOHIDUSAGETABLES_H
;  ******************************************************************************************
;  * HID Usage Tables
;  *
;  * The following constants are from the USB 'HID Usage Tables' specification, revision 1.1rc3
;  * ****************************************************************************************** 
;  Usage Pages 

(defconstant $kHIDPage_Undefined 0)
(defconstant $kHIDPage_GenericDesktop 1)
(defconstant $kHIDPage_Simulation 2)
(defconstant $kHIDPage_VR 3)
(defconstant $kHIDPage_Sport 4)
(defconstant $kHIDPage_Game 5)                  ;  Reserved 0x06 

(defconstant $kHIDPage_KeyboardOrKeypad 7)      ;  USB Device Class Definition for Human Interface Devices (HID). Note: the usage type for all key codes is Selector (Sel). 

(defconstant $kHIDPage_LEDs 8)
(defconstant $kHIDPage_Button 9)
(defconstant $kHIDPage_Ordinal 10)
(defconstant $kHIDPage_Telephony 11)
(defconstant $kHIDPage_Consumer 12)
(defconstant $kHIDPage_Digitizer 13)            ;  Reserved 0x0E 

(defconstant $kHIDPage_PID 15)                  ;  USB Physical Interface Device definitions for force feedback and related devices. 

(defconstant $kHIDPage_Unicode 16)              ;  Reserved 0x11 - 0x13 

(defconstant $kHIDPage_AlphanumericDisplay 20)  ;  Reserved 0x15 - 0x7F 
;  Monitor 0x80 - 0x83	 USB Device Class Definition for Monitor Devices 
;  Power 0x84 - 0x87	 USB Device Class Definition for Power Devices 

(defconstant $kHIDPage_PowerDevice #x84)        ;  Power Device Page 

(defconstant $kHIDPage_BatterySystem #x85)      ;  Battery System Page 
;  Reserved 0x88 - 0x8B 

(defconstant $kHIDPage_BarCodeScanner #x8C)     ;  (Point of Sale) USB Device Class Definition for Bar Code Scanner Devices 

(defconstant $kHIDPage_Scale #x8D)              ;  (Point of Sale) USB Device Class Definition for Scale Devices 
;  ReservedPointofSalepages 0x8E - 0x8F 

(defconstant $kHIDPage_CameraControl #x90)      ;  USB Device Class Definition for Image Class Devices 

(defconstant $kHIDPage_Arcade #x91)             ;  OAAF Definitions for arcade and coinop related Devices 
;  Reserved 0x92 - 0xFEFF 
;  VendorDefined 0xFF00 - 0xFFFF 

(defconstant $kHIDPage_VendorDefinedStart #xFF00)
;  Undefined Usage for all usage pages 

(defconstant $kHIDUsage_Undefined 0)
;  GenericDesktop Page (0x01) 

(defconstant $kHIDUsage_GD_Pointer 1)           ;  Physical Collection 

(defconstant $kHIDUsage_GD_Mouse 2)             ;  Application Collection 
;  0x03 Reserved 

(defconstant $kHIDUsage_GD_Joystick 4)          ;  Application Collection 

(defconstant $kHIDUsage_GD_GamePad 5)           ;  Application Collection 

(defconstant $kHIDUsage_GD_Keyboard 6)          ;  Application Collection 

(defconstant $kHIDUsage_GD_Keypad 7)            ;  Application Collection 

(defconstant $kHIDUsage_GD_MultiAxisController 8);  Application Collection 
;  0x09 - 0x2F Reserved 

(defconstant $kHIDUsage_GD_X 48)                ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Y 49)                ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Z 50)                ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Rx 51)               ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Ry 52)               ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Rz 53)               ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Slider 54)           ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Dial 55)             ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Wheel 56)            ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Hatswitch 57)        ;  Dynamic Value 

(defconstant $kHIDUsage_GD_CountedBuffer 58)    ;  Logical Collection 

(defconstant $kHIDUsage_GD_ByteCount 59)        ;  Dynamic Value 

(defconstant $kHIDUsage_GD_MotionWakeup 60)     ;  One-Shot Control 

(defconstant $kHIDUsage_GD_Start 61)            ;  On/Off Control 

(defconstant $kHIDUsage_GD_Select 62)           ;  On/Off Control 
;  0x3F Reserved 

(defconstant $kHIDUsage_GD_Vx 64)               ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Vy 65)               ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Vz 66)               ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Vbrx 67)             ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Vbry 68)             ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Vbrz 69)             ;  Dynamic Value 

(defconstant $kHIDUsage_GD_Vno 70)              ;  Dynamic Value 
;  0x47 - 0x7F Reserved 

(defconstant $kHIDUsage_GD_SystemControl #x80)  ;  Application Collection 

(defconstant $kHIDUsage_GD_SystemPowerDown #x81);  One-Shot Control 

(defconstant $kHIDUsage_GD_SystemSleep #x82)    ;  One-Shot Control 

(defconstant $kHIDUsage_GD_SystemWakeUp #x83)   ;  One-Shot Control 

(defconstant $kHIDUsage_GD_SystemContextMenu #x84);  One-Shot Control 

(defconstant $kHIDUsage_GD_SystemMainMenu #x85) ;  One-Shot Control 

(defconstant $kHIDUsage_GD_SystemAppMenu #x86)  ;  One-Shot Control 

(defconstant $kHIDUsage_GD_SystemMenuHelp #x87) ;  One-Shot Control 

(defconstant $kHIDUsage_GD_SystemMenuExit #x88) ;  One-Shot Control 

(defconstant $kHIDUsage_GD_SystemMenu #x89)     ;  Selector 

(defconstant $kHIDUsage_GD_SystemMenuRight #x8A);  Re-Trigger Control 

(defconstant $kHIDUsage_GD_SystemMenuLeft #x8B) ;  Re-Trigger Control 

(defconstant $kHIDUsage_GD_SystemMenuUp #x8C)   ;  Re-Trigger Control 

(defconstant $kHIDUsage_GD_SystemMenuDown #x8D) ;  Re-Trigger Control 
;  0x8E - 0x8F Reserved 

(defconstant $kHIDUsage_GD_DPadUp #x90)         ;  On/Off Control 

(defconstant $kHIDUsage_GD_DPadDown #x91)       ;  On/Off Control 

(defconstant $kHIDUsage_GD_DPadRight #x92)      ;  On/Off Control 

(defconstant $kHIDUsage_GD_DPadLeft #x93)       ;  On/Off Control 
;  0x94 - 0xFFFF Reserved 

(defconstant $kHIDUsage_GD_Reserved #xFFFF)
;  Simulation Page (0x02) 
;  This section provides detailed descriptions of the usages employed by simulation devices. 

(defconstant $kHIDUsage_Sim_FlightSimulationDevice 1);  Application Collection 

(defconstant $kHIDUsage_Sim_AutomobileSimulationDevice 2);  Application Collection 

(defconstant $kHIDUsage_Sim_TankSimulationDevice 3);  Application Collection 

(defconstant $kHIDUsage_Sim_SpaceshipSimulationDevice 4);  Application Collection 

(defconstant $kHIDUsage_Sim_SubmarineSimulationDevice 5);  Application Collection 

(defconstant $kHIDUsage_Sim_SailingSimulationDevice 6);  Application Collection 

(defconstant $kHIDUsage_Sim_MotorcycleSimulationDevice 7);  Application Collection 

(defconstant $kHIDUsage_Sim_SportsSimulationDevice 8);  Application Collection 

(defconstant $kHIDUsage_Sim_AirplaneSimulationDevice 9);  Application Collection 

(defconstant $kHIDUsage_Sim_HelicopterSimulationDevice 10);  Application Collection 

(defconstant $kHIDUsage_Sim_MagicCarpetSimulationDevice 11);  Application Collection 

(defconstant $kHIDUsage_Sim_BicycleSimulationDevice 12);  Application Collection 
;  0x0D - 0x1F Reserved 

(defconstant $kHIDUsage_Sim_FlightControlStick 32);  Application Collection 

(defconstant $kHIDUsage_Sim_FlightStick 33)     ;  Application Collection 

(defconstant $kHIDUsage_Sim_CyclicControl 34)   ;  Physical Collection 

(defconstant $kHIDUsage_Sim_CyclicTrim 35)      ;  Physical Collection 

(defconstant $kHIDUsage_Sim_FlightYoke 36)      ;  Application Collection 

(defconstant $kHIDUsage_Sim_TrackControl 37)    ;  Physical Collection 
;  0x26 - 0xAF Reserved 

(defconstant $kHIDUsage_Sim_Aileron #xB0)       ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_AileronTrim #xB1)   ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_AntiTorqueControl #xB2);  Dynamic Value 

(defconstant $kHIDUsage_Sim_AutopilotEnable #xB3);  On/Off Control 

(defconstant $kHIDUsage_Sim_ChaffRelease #xB4)  ;  One-Shot Control 

(defconstant $kHIDUsage_Sim_CollectiveControl #xB5);  Dynamic Value 

(defconstant $kHIDUsage_Sim_DiveBrake #xB6)     ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_ElectronicCountermeasures #xB7);  On/Off Control 

(defconstant $kHIDUsage_Sim_Elevator #xB8)      ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_ElevatorTrim #xB9)  ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Rudder #xBA)        ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Throttle #xBB)      ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_FlightCommunications #xBC);  On/Off Control 

(defconstant $kHIDUsage_Sim_FlareRelease #xBD)  ;  One-Shot Control 

(defconstant $kHIDUsage_Sim_LandingGear #xBE)   ;  On/Off Control 

(defconstant $kHIDUsage_Sim_ToeBrake #xBF)      ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Trigger #xC0)       ;  Momentary Control 

(defconstant $kHIDUsage_Sim_WeaponsArm #xC1)    ;  On/Off Control 

(defconstant $kHIDUsage_Sim_Weapons #xC2)       ;  Selector 

(defconstant $kHIDUsage_Sim_WingFlaps #xC3)     ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Accelerator #xC4)   ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Brake #xC5)         ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Clutch #xC6)        ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Shifter #xC7)       ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Steering #xC8)      ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_TurretDirection #xC9);  Dynamic Value 

(defconstant $kHIDUsage_Sim_BarrelElevation #xCA);  Dynamic Value 

(defconstant $kHIDUsage_Sim_DivePlane #xCB)     ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_Ballast #xCC)       ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_BicycleCrank #xCD)  ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_HandleBars #xCE)    ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_FrontBrake #xCF)    ;  Dynamic Value 

(defconstant $kHIDUsage_Sim_RearBrake #xD0)     ;  Dynamic Value 
;  0xD1 - 0xFFFF Reserved 

(defconstant $kHIDUsage_Sim_Reserved #xFFFF)
;  VR Page (0x03) 
;  Virtual Reality controls depend on designators to identify the individual controls. Most of the following are 
;  usages are applied to the collections of entities that comprise the actual device. 

(defconstant $kHIDUsage_VR_Belt 1)              ;  Application Collection 

(defconstant $kHIDUsage_VR_BodySuit 2)          ;  Application Collection 

(defconstant $kHIDUsage_VR_Flexor 3)            ;  Physical Collection 

(defconstant $kHIDUsage_VR_Glove 4)             ;  Application Collection 

(defconstant $kHIDUsage_VR_HeadTracker 5)       ;  Physical Collection 

(defconstant $kHIDUsage_VR_HeadMountedDisplay 6);  Application Collection 

(defconstant $kHIDUsage_VR_HandTracker 7)       ;  Application Collection 

(defconstant $kHIDUsage_VR_Oculometer 8)        ;  Application Collection 

(defconstant $kHIDUsage_VR_Vest 9)              ;  Application Collection 

(defconstant $kHIDUsage_VR_AnimatronicDevice 10);  Application Collection 
;  0x0B - 0x1F Reserved 

(defconstant $kHIDUsage_VR_StereoEnable 32)     ;  On/Off Control 

(defconstant $kHIDUsage_VR_DisplayEnable 33)    ;  On/Off Control 
;  0x22 - 0xFFFF Reserved 

(defconstant $kHIDUsage_VR_Reserved #xFFFF)
;  Sport Page (0x04) 

(defconstant $kHIDUsage_Sprt_BaseballBat 1)     ;  Application Collection 

(defconstant $kHIDUsage_Sprt_GolfClub 2)        ;  Application Collection 

(defconstant $kHIDUsage_Sprt_RowingMachine 3)   ;  Application Collection 

(defconstant $kHIDUsage_Sprt_Treadmill 4)       ;  Application Collection 
;  0x05 - 0x2F Reserved 

(defconstant $kHIDUsage_Sprt_Oar 48)            ;  Dynamic Value 

(defconstant $kHIDUsage_Sprt_Slope 49)          ;  Dynamic Value 

(defconstant $kHIDUsage_Sprt_Rate 50)           ;  Dynamic Value 

(defconstant $kHIDUsage_Sprt_StickSpeed 51)     ;  Dynamic Value 

(defconstant $kHIDUsage_Sprt_StickFaceAngle 52) ;  Dynamic Value 

(defconstant $kHIDUsage_Sprt_StickHeelOrToe 53) ;  Dynamic Value 

(defconstant $kHIDUsage_Sprt_StickFollowThrough 54);  Dynamic Value 

(defconstant $kHIDUsage_Sprt_StickTempo 55)     ;  Dynamic Value 

(defconstant $kHIDUsage_Sprt_StickType 56)      ;  Named Array 

(defconstant $kHIDUsage_Sprt_StickHeight 57)    ;  Dynamic Value 
;  0x3A - 0x4F Reserved 

(defconstant $kHIDUsage_Sprt_Putter 80)         ;  Selector 

(defconstant $kHIDUsage_Sprt_1Iron 81)          ;  Selector 

(defconstant $kHIDUsage_Sprt_2Iron 82)          ;  Selector 

(defconstant $kHIDUsage_Sprt_3Iron 83)          ;  Selector 

(defconstant $kHIDUsage_Sprt_4Iron 84)          ;  Selector 

(defconstant $kHIDUsage_Sprt_5Iron 85)          ;  Selector 

(defconstant $kHIDUsage_Sprt_6Iron 86)          ;  Selector 

(defconstant $kHIDUsage_Sprt_7Iron 87)          ;  Selector 

(defconstant $kHIDUsage_Sprt_8Iron 88)          ;  Selector 

(defconstant $kHIDUsage_Sprt_9Iron 89)          ;  Selector 

(defconstant $kHIDUsage_Sprt_10Iron 90)         ;  Selector 

(defconstant $kHIDUsage_Sprt_11Iron 91)         ;  Selector 

(defconstant $kHIDUsage_Sprt_SandWedge 92)      ;  Selector 

(defconstant $kHIDUsage_Sprt_LoftWedge 93)      ;  Selector 

(defconstant $kHIDUsage_Sprt_PowerWedge 94)     ;  Selector 

(defconstant $kHIDUsage_Sprt_1Wood 95)          ;  Selector 

(defconstant $kHIDUsage_Sprt_3Wood 96)          ;  Selector 

(defconstant $kHIDUsage_Sprt_5Wood 97)          ;  Selector 

(defconstant $kHIDUsage_Sprt_7Wood 98)          ;  Selector 

(defconstant $kHIDUsage_Sprt_9Wood 99)          ;  Selector 
;  0x64 - 0xFFFF Reserved 

(defconstant $kHIDUsage_Sprt_Reserved #xFFFF)
;  Game Page (0x05) 

(defconstant $kHIDUsage_Game_3DGameController 1);  Application Collection 

(defconstant $kHIDUsage_Game_PinballDevice 2)   ;  Application Collection 

(defconstant $kHIDUsage_Game_GunDevice 3)       ;  Application Collection 
;  0x04 - 0x1F Reserved 

(defconstant $kHIDUsage_Game_PointofView 32)    ;  Physical Collection 

(defconstant $kHIDUsage_Game_TurnRightOrLeft 33);  Dynamic Value 

(defconstant $kHIDUsage_Game_PitchUpOrDown 34)  ;  Dynamic Value 

(defconstant $kHIDUsage_Game_RollRightOrLeft 35);  Dynamic Value 

(defconstant $kHIDUsage_Game_MoveRightOrLeft 36);  Dynamic Value 

(defconstant $kHIDUsage_Game_MoveForwardOrBackward 37);  Dynamic Value 

(defconstant $kHIDUsage_Game_MoveUpOrDown 38)   ;  Dynamic Value 

(defconstant $kHIDUsage_Game_LeanRightOrLeft 39);  Dynamic Value 

(defconstant $kHIDUsage_Game_LeanForwardOrBackward 40);  Dynamic Value 

(defconstant $kHIDUsage_Game_HeightOfPOV 41)    ;  Dynamic Value 

(defconstant $kHIDUsage_Game_Flipper 42)        ;  Momentary Control 

(defconstant $kHIDUsage_Game_SecondaryFlipper 43);  Momentary Control 

(defconstant $kHIDUsage_Game_Bump 44)           ;  Momentary Control 

(defconstant $kHIDUsage_Game_NewGame 45)        ;  One-Shot Control 

(defconstant $kHIDUsage_Game_ShootBall 46)      ;  One-Shot Control 

(defconstant $kHIDUsage_Game_Player 47)         ;  One-Shot Control 

(defconstant $kHIDUsage_Game_GunBolt 48)        ;  On/Off Control 

(defconstant $kHIDUsage_Game_GunClip 49)        ;  On/Off Control 

(defconstant $kHIDUsage_Game_Gun 50)            ;  Selector 

(defconstant $kHIDUsage_Game_GunSingleShot 51)  ;  Selector 

(defconstant $kHIDUsage_Game_GunBurst 52)       ;  Selector 

(defconstant $kHIDUsage_Game_GunAutomatic 53)   ;  Selector 

(defconstant $kHIDUsage_Game_GunSafety 54)      ;  On/Off Control 

(defconstant $kHIDUsage_Game_GamepadFireOrJump 55);  Logical Collection 

(defconstant $kHIDUsage_Game_GamepadTrigger 57) ;  Logical Collection 
;  0x3A - 0xFFFF Reserved 

(defconstant $kHIDUsage_Game_Reserved #xFFFF)
;  KeyboardOrKeypad Page (0x07) 
;  This section is the Usage Page for key codes to be used in implementing a USB keyboard. A Boot Keyboard (84-, 101- or 104-key) should at a minimum support all associated usage codes as indicated in the “Boot” 
;  column below. 
;  The usage type of all key codes is Selectors (Sel), except for the modifier keys Keyboard Left Control (0x224) to Keyboard Right GUI (0x231) which are Dynamic Flags (DV). 
;  Note: A general note on Usages and languages: Due to the variation of keyboards from language to language, it is not feasible to specify exact key mappings for every language. Where this list is not specific for a key function in a language, the closest equivalent key position should be used, so that a keyboard may be modified for a different language by simply printing different keycaps. One example is the Y key on a North American keyboard. In Germany this is typically Z. Rather than changing the keyboard firmware to put the Z Usage into that place in the descriptor list, the vendor should use the Y Usage on both the North American and German keyboards. This continues to be the existing practice in the industry, in order to minimize the number of changes to the electronics to accommodate otherlanguages. 

(defconstant $kHIDUsage_KeyboardErrorRollOver 1);  ErrorRollOver 

(defconstant $kHIDUsage_KeyboardPOSTFail 2)     ;  POSTFail 

(defconstant $kHIDUsage_KeyboardErrorUndefined 3);  ErrorUndefined 

(defconstant $kHIDUsage_KeyboardA 4)            ;  a or A 

(defconstant $kHIDUsage_KeyboardB 5)            ;  b or B 

(defconstant $kHIDUsage_KeyboardC 6)            ;  c or C 

(defconstant $kHIDUsage_KeyboardD 7)            ;  d or D 

(defconstant $kHIDUsage_KeyboardE 8)            ;  e or E 

(defconstant $kHIDUsage_KeyboardF 9)            ;  f or F 

(defconstant $kHIDUsage_KeyboardG 10)           ;  g or G 

(defconstant $kHIDUsage_KeyboardH 11)           ;  h or H 

(defconstant $kHIDUsage_KeyboardI 12)           ;  i or I 

(defconstant $kHIDUsage_KeyboardJ 13)           ;  j or J 

(defconstant $kHIDUsage_KeyboardK 14)           ;  k or K 

(defconstant $kHIDUsage_KeyboardL 15)           ;  l or L 

(defconstant $kHIDUsage_KeyboardM 16)           ;  m or M 

(defconstant $kHIDUsage_KeyboardN 17)           ;  n or N 

(defconstant $kHIDUsage_KeyboardO 18)           ;  o or O 

(defconstant $kHIDUsage_KeyboardP 19)           ;  p or P 

(defconstant $kHIDUsage_KeyboardQ 20)           ;  q or Q 

(defconstant $kHIDUsage_KeyboardR 21)           ;  r or R 

(defconstant $kHIDUsage_KeyboardS 22)           ;  s or S 

(defconstant $kHIDUsage_KeyboardT 23)           ;  t or T 

(defconstant $kHIDUsage_KeyboardU 24)           ;  u or U 

(defconstant $kHIDUsage_KeyboardV 25)           ;  v or V 

(defconstant $kHIDUsage_KeyboardW 26)           ;  w or W 

(defconstant $kHIDUsage_KeyboardX 27)           ;  x or X 

(defconstant $kHIDUsage_KeyboardY 28)           ;  y or Y 

(defconstant $kHIDUsage_KeyboardZ 29)           ;  z or Z 

(defconstant $kHIDUsage_Keyboard1 30)           ;  1 or ! 

(defconstant $kHIDUsage_Keyboard2 31)           ;  2 or @ 

(defconstant $kHIDUsage_Keyboard3 32)           ;  3 or # 

(defconstant $kHIDUsage_Keyboard4 33)           ;  4 or $ 

(defconstant $kHIDUsage_Keyboard5 34)           ;  5 or % 

(defconstant $kHIDUsage_Keyboard6 35)           ;  6 or ^ 

(defconstant $kHIDUsage_Keyboard7 36)           ;  7 or & 

(defconstant $kHIDUsage_Keyboard8 37)           ;  8 or * 

(defconstant $kHIDUsage_Keyboard9 38)           ;  9 or ( 

(defconstant $kHIDUsage_Keyboard0 39)           ;  0 or ) 

(defconstant $kHIDUsage_KeyboardReturnOrEnter 40);  Return (Enter) 

(defconstant $kHIDUsage_KeyboardEscape 41)      ;  Escape 

(defconstant $kHIDUsage_KeyboardDeleteOrBackspace 42);  Delete (Backspace) 

(defconstant $kHIDUsage_KeyboardTab 43)         ;  Tab 

(defconstant $kHIDUsage_KeyboardSpacebar 44)    ;  Spacebar 

(defconstant $kHIDUsage_KeyboardHyphen 45)      ;  - or _ 

(defconstant $kHIDUsage_KeyboardEqualSign 46)   ;  = or + 

(defconstant $kHIDUsage_KeyboardOpenBracket 47) ;  [ or { 

(defconstant $kHIDUsage_KeyboardCloseBracket 48);  ] or } 

(defconstant $kHIDUsage_KeyboardBackslash 49)   ;  \ or | 

(defconstant $kHIDUsage_KeyboardNonUSPound 50)  ;  Non-US # or _ 

(defconstant $kHIDUsage_KeyboardSemicolon 51)   ;  ; or : 

(defconstant $kHIDUsage_KeyboardQuote 52)       ;  ' or " 

(defconstant $kHIDUsage_KeyboardGraveAccentAndTilde 53);  Grave Accent and Tilde 

(defconstant $kHIDUsage_KeyboardComma 54)       ;  , or < 

(defconstant $kHIDUsage_KeyboardPeriod 55)      ;  . or > 

(defconstant $kHIDUsage_KeyboardSlash 56)       ;  / or ? 

(defconstant $kHIDUsage_KeyboardCapsLock 57)    ;  Caps Lock 

(defconstant $kHIDUsage_KeyboardF1 58)          ;  F1 

(defconstant $kHIDUsage_KeyboardF2 59)          ;  F2 

(defconstant $kHIDUsage_KeyboardF3 60)          ;  F3 

(defconstant $kHIDUsage_KeyboardF4 61)          ;  F4 

(defconstant $kHIDUsage_KeyboardF5 62)          ;  F5 

(defconstant $kHIDUsage_KeyboardF6 63)          ;  F6 

(defconstant $kHIDUsage_KeyboardF7 64)          ;  F7 

(defconstant $kHIDUsage_KeyboardF8 65)          ;  F8 

(defconstant $kHIDUsage_KeyboardF9 66)          ;  F9 

(defconstant $kHIDUsage_KeyboardF10 67)         ;  F10 

(defconstant $kHIDUsage_KeyboardF11 68)         ;  F11 

(defconstant $kHIDUsage_KeyboardF12 69)         ;  F12 

(defconstant $kHIDUsage_KeyboardPrintScreen 70) ;  Print Screen 

(defconstant $kHIDUsage_KeyboardScrollLock 71)  ;  Scroll Lock 

(defconstant $kHIDUsage_KeyboardPause 72)       ;  Pause 

(defconstant $kHIDUsage_KeyboardInsert 73)      ;  Insert 

(defconstant $kHIDUsage_KeyboardHome 74)        ;  Home 

(defconstant $kHIDUsage_KeyboardPageUp 75)      ;  Page Up 

(defconstant $kHIDUsage_KeyboardDeleteForward 76);  Delete Forward 

(defconstant $kHIDUsage_KeyboardEnd 77)         ;  End 

(defconstant $kHIDUsage_KeyboardPageDown 78)    ;  Page Down 

(defconstant $kHIDUsage_KeyboardRightArrow 79)  ;  Right Arrow 

(defconstant $kHIDUsage_KeyboardLeftArrow 80)   ;  Left Arrow 

(defconstant $kHIDUsage_KeyboardDownArrow 81)   ;  Down Arrow 

(defconstant $kHIDUsage_KeyboardUpArrow 82)     ;  Up Arrow 

(defconstant $kHIDUsage_KeypadNumLock 83)       ;  Keypad NumLock or Clear 

(defconstant $kHIDUsage_KeypadSlash 84)         ;  Keypad / 

(defconstant $kHIDUsage_KeypadAsterisk 85)      ;  Keypad * 

(defconstant $kHIDUsage_KeypadHyphen 86)        ;  Keypad - 

(defconstant $kHIDUsage_KeypadPlus 87)          ;  Keypad + 

(defconstant $kHIDUsage_KeypadEnter 88)         ;  Keypad Enter 

(defconstant $kHIDUsage_Keypad1 89)             ;  Keypad 1 or End 

(defconstant $kHIDUsage_Keypad2 90)             ;  Keypad 2 or Down Arrow 

(defconstant $kHIDUsage_Keypad3 91)             ;  Keypad 3 or Page Down 

(defconstant $kHIDUsage_Keypad4 92)             ;  Keypad 4 or Left Arrow 

(defconstant $kHIDUsage_Keypad5 93)             ;  Keypad 5 

(defconstant $kHIDUsage_Keypad6 94)             ;  Keypad 6 or Right Arrow 

(defconstant $kHIDUsage_Keypad7 95)             ;  Keypad 7 or Home 

(defconstant $kHIDUsage_Keypad8 96)             ;  Keypad 8 or Up Arrow 

(defconstant $kHIDUsage_Keypad9 97)             ;  Keypad 9 or Page Up 

(defconstant $kHIDUsage_Keypad0 98)             ;  Keypad 0 or Insert 

(defconstant $kHIDUsage_KeypadPeriod 99)        ;  Keypad . or Delete 

(defconstant $kHIDUsage_KeyboardNonUSBackslash 100);  Non-US \ or | 

(defconstant $kHIDUsage_KeyboardApplication 101);  Application 

(defconstant $kHIDUsage_KeyboardPower 102)      ;  Power 

(defconstant $kHIDUsage_KeypadEqualSign 103)    ;  Keypad = 

(defconstant $kHIDUsage_KeyboardF13 104)        ;  F13 

(defconstant $kHIDUsage_KeyboardF14 105)        ;  F14 

(defconstant $kHIDUsage_KeyboardF15 106)        ;  F15 

(defconstant $kHIDUsage_KeyboardF16 107)        ;  F16 

(defconstant $kHIDUsage_KeyboardF17 108)        ;  F17 

(defconstant $kHIDUsage_KeyboardF18 109)        ;  F18 

(defconstant $kHIDUsage_KeyboardF19 110)        ;  F19 

(defconstant $kHIDUsage_KeyboardF20 111)        ;  F20 

(defconstant $kHIDUsage_KeyboardF21 112)        ;  F21 

(defconstant $kHIDUsage_KeyboardF22 113)        ;  F22 

(defconstant $kHIDUsage_KeyboardF23 114)        ;  F23 

(defconstant $kHIDUsage_KeyboardF24 115)        ;  F24 

(defconstant $kHIDUsage_KeyboardExecute 116)    ;  Execute 

(defconstant $kHIDUsage_KeyboardHelp 117)       ;  Help 

(defconstant $kHIDUsage_KeyboardMenu 118)       ;  Menu 

(defconstant $kHIDUsage_KeyboardSelect 119)     ;  Select 

(defconstant $kHIDUsage_KeyboardStop 120)       ;  Stop 

(defconstant $kHIDUsage_KeyboardAgain 121)      ;  Again 

(defconstant $kHIDUsage_KeyboardUndo 122)       ;  Undo 

(defconstant $kHIDUsage_KeyboardCut 123)        ;  Cut 

(defconstant $kHIDUsage_KeyboardCopy 124)       ;  Copy 

(defconstant $kHIDUsage_KeyboardPaste 125)      ;  Paste 

(defconstant $kHIDUsage_KeyboardFind 126)       ;  Find 

(defconstant $kHIDUsage_KeyboardMute 127)       ;  Mute 

(defconstant $kHIDUsage_KeyboardVolumeUp #x80)  ;  Volume Up 

(defconstant $kHIDUsage_KeyboardVolumeDown #x81);  Volume Down 

(defconstant $kHIDUsage_KeyboardLockingCapsLock #x82);  Locking Caps Lock 

(defconstant $kHIDUsage_KeyboardLockingNumLock #x83);  Locking Num Lock 

(defconstant $kHIDUsage_KeyboardLockingScrollLock #x84);  Locking Scroll Lock 

(defconstant $kHIDUsage_KeypadComma #x85)       ;  Keypad Comma 

(defconstant $kHIDUsage_KeypadEqualSignAS400 #x86);  Keypad Equal Sign for AS/400 

(defconstant $kHIDUsage_KeyboardInternational1 #x87);  International1 

(defconstant $kHIDUsage_KeyboardInternational2 #x88);  International2 

(defconstant $kHIDUsage_KeyboardInternational3 #x89);  International3 

(defconstant $kHIDUsage_KeyboardInternational4 #x8A);  International4 

(defconstant $kHIDUsage_KeyboardInternational5 #x8B);  International5 

(defconstant $kHIDUsage_KeyboardInternational6 #x8C);  International6 

(defconstant $kHIDUsage_KeyboardInternational7 #x8D);  International7 

(defconstant $kHIDUsage_KeyboardInternational8 #x8E);  International8 

(defconstant $kHIDUsage_KeyboardInternational9 #x8F);  International9 

(defconstant $kHIDUsage_KeyboardLANG1 #x90)     ;  LANG1 

(defconstant $kHIDUsage_KeyboardLANG2 #x91)     ;  LANG2 

(defconstant $kHIDUsage_KeyboardLANG3 #x92)     ;  LANG3 

(defconstant $kHIDUsage_KeyboardLANG4 #x93)     ;  LANG4 

(defconstant $kHIDUsage_KeyboardLANG5 #x94)     ;  LANG5 

(defconstant $kHIDUsage_KeyboardLANG6 #x95)     ;  LANG6 

(defconstant $kHIDUsage_KeyboardLANG7 #x96)     ;  LANG7 

(defconstant $kHIDUsage_KeyboardLANG8 #x97)     ;  LANG8 

(defconstant $kHIDUsage_KeyboardLANG9 #x98)     ;  LANG9 

(defconstant $kHIDUsage_KeyboardAlternateErase #x99);  AlternateErase 

(defconstant $kHIDUsage_KeyboardSysReqOrAttention #x9A);  SysReq/Attention 

(defconstant $kHIDUsage_KeyboardCancel #x9B)    ;  Cancel 

(defconstant $kHIDUsage_KeyboardClear #x9C)     ;  Clear 

(defconstant $kHIDUsage_KeyboardPrior #x9D)     ;  Prior 

(defconstant $kHIDUsage_KeyboardReturn #x9E)    ;  Return 

(defconstant $kHIDUsage_KeyboardSeparator #x9F) ;  Separator 

(defconstant $kHIDUsage_KeyboardOut #xA0)       ;  Out 

(defconstant $kHIDUsage_KeyboardOper #xA1)      ;  Oper 

(defconstant $kHIDUsage_KeyboardClearOrAgain #xA2);  Clear/Again 

(defconstant $kHIDUsage_KeyboardCrSelOrProps #xA3);  CrSel/Props 

(defconstant $kHIDUsage_KeyboardExSel #xA4)     ;  ExSel 
;  0xA5-0xDF Reserved 

(defconstant $kHIDUsage_KeyboardLeftControl #xE0);  Left Control 

(defconstant $kHIDUsage_KeyboardLeftShift #xE1) ;  Left Shift 

(defconstant $kHIDUsage_KeyboardLeftAlt #xE2)   ;  Left Alt 

(defconstant $kHIDUsage_KeyboardLeftGUI #xE3)   ;  Left GUI 

(defconstant $kHIDUsage_KeyboardRightControl #xE4);  Right Control 

(defconstant $kHIDUsage_KeyboardRightShift #xE5);  Right Shift 

(defconstant $kHIDUsage_KeyboardRightAlt #xE6)  ;  Right Alt 

(defconstant $kHIDUsage_KeyboardRightGUI #xE7)  ;  Right GUI 
;  0xE8-0xFFFF Reserved 

(defconstant $kHIDUsage_Keyboard_Reserved #xFFFF)
;  LEDs Page (0x08) 
;  An LED or indicator is implemented as an On/Off Control (OOF) using the “Single button toggle” mode, where a value of 1 will turn on the indicator, and a value of 0 will turn it off. The exceptions are described below. 

(defconstant $kHIDUsage_LED_NumLock 1)          ;  On/Off Control 

(defconstant $kHIDUsage_LED_CapsLock 2)         ;  On/Off Control 

(defconstant $kHIDUsage_LED_ScrollLock 3)       ;  On/Off Control 

(defconstant $kHIDUsage_LED_Compose 4)          ;  On/Off Control 

(defconstant $kHIDUsage_LED_Kana 5)             ;  On/Off Control 

(defconstant $kHIDUsage_LED_Power 6)            ;  On/Off Control 

(defconstant $kHIDUsage_LED_Shift 7)            ;  On/Off Control 

(defconstant $kHIDUsage_LED_DoNotDisturb 8)     ;  On/Off Control 

(defconstant $kHIDUsage_LED_Mute 9)             ;  On/Off Control 

(defconstant $kHIDUsage_LED_ToneEnable 10)      ;  On/Off Control 

(defconstant $kHIDUsage_LED_HighCutFilter 11)   ;  On/Off Control 

(defconstant $kHIDUsage_LED_LowCutFilter 12)    ;  On/Off Control 

(defconstant $kHIDUsage_LED_EqualizerEnable 13) ;  On/Off Control 

(defconstant $kHIDUsage_LED_SoundFieldOn 14)    ;  On/Off Control 

(defconstant $kHIDUsage_LED_SurroundOn 15)      ;  On/Off Control 

(defconstant $kHIDUsage_LED_Repeat 16)          ;  On/Off Control 

(defconstant $kHIDUsage_LED_Stereo 17)          ;  On/Off Control 

(defconstant $kHIDUsage_LED_SamplingRateDetect 18);  On/Off Control 

(defconstant $kHIDUsage_LED_Spinning 19)        ;  On/Off Control 

(defconstant $kHIDUsage_LED_CAV 20)             ;  On/Off Control 

(defconstant $kHIDUsage_LED_CLV 21)             ;  On/Off Control 

(defconstant $kHIDUsage_LED_RecordingFormatDetect 22);  On/Off Control 

(defconstant $kHIDUsage_LED_OffHook 23)         ;  On/Off Control 

(defconstant $kHIDUsage_LED_Ring 24)            ;  On/Off Control 

(defconstant $kHIDUsage_LED_MessageWaiting 25)  ;  On/Off Control 

(defconstant $kHIDUsage_LED_DataMode 26)        ;  On/Off Control 

(defconstant $kHIDUsage_LED_BatteryOperation 27);  On/Off Control 

(defconstant $kHIDUsage_LED_BatteryOK 28)       ;  On/Off Control 

(defconstant $kHIDUsage_LED_BatteryLow 29)      ;  On/Off Control 

(defconstant $kHIDUsage_LED_Speaker 30)         ;  On/Off Control 

(defconstant $kHIDUsage_LED_HeadSet 31)         ;  On/Off Control 

(defconstant $kHIDUsage_LED_Hold 32)            ;  On/Off Control 

(defconstant $kHIDUsage_LED_Microphone 33)      ;  On/Off Control 

(defconstant $kHIDUsage_LED_Coverage 34)        ;  On/Off Control 

(defconstant $kHIDUsage_LED_NightMode 35)       ;  On/Off Control 

(defconstant $kHIDUsage_LED_SendCalls 36)       ;  On/Off Control 

(defconstant $kHIDUsage_LED_CallPickup 37)      ;  On/Off Control 

(defconstant $kHIDUsage_LED_Conference 38)      ;  On/Off Control 

(defconstant $kHIDUsage_LED_StandBy 39)         ;  On/Off Control 

(defconstant $kHIDUsage_LED_CameraOn 40)        ;  On/Off Control 

(defconstant $kHIDUsage_LED_CameraOff 41)       ;  On/Off Control 

(defconstant $kHIDUsage_LED_OnLine 42)          ;  On/Off Control 

(defconstant $kHIDUsage_LED_OffLine 43)         ;  On/Off Control 

(defconstant $kHIDUsage_LED_Busy 44)            ;  On/Off Control 

(defconstant $kHIDUsage_LED_Ready 45)           ;  On/Off Control 

(defconstant $kHIDUsage_LED_PaperOut 46)        ;  On/Off Control 

(defconstant $kHIDUsage_LED_PaperJam 47)        ;  On/Off Control 

(defconstant $kHIDUsage_LED_Remote 48)          ;  On/Off Control 

(defconstant $kHIDUsage_LED_Forward 49)         ;  On/Off Control 

(defconstant $kHIDUsage_LED_Reverse 50)         ;  On/Off Control 

(defconstant $kHIDUsage_LED_Stop 51)            ;  On/Off Control 

(defconstant $kHIDUsage_LED_Rewind 52)          ;  On/Off Control 

(defconstant $kHIDUsage_LED_FastForward 53)     ;  On/Off Control 

(defconstant $kHIDUsage_LED_Play 54)            ;  On/Off Control 

(defconstant $kHIDUsage_LED_Pause 55)           ;  On/Off Control 

(defconstant $kHIDUsage_LED_Record 56)          ;  On/Off Control 

(defconstant $kHIDUsage_LED_Error 57)           ;  On/Off Control 

(defconstant $kHIDUsage_LED_Usage 58)           ;  Selector 

(defconstant $kHIDUsage_LED_UsageInUseIndicator 59);  Usage Switch 

(defconstant $kHIDUsage_LED_UsageMultiModeIndicator 60);  Usage Modifier 

(defconstant $kHIDUsage_LED_IndicatorOn 61)     ;  Selector 

(defconstant $kHIDUsage_LED_IndicatorFlash 62)  ;  Selector 

(defconstant $kHIDUsage_LED_IndicatorSlowBlink 63);  Selector 

(defconstant $kHIDUsage_LED_IndicatorFastBlink 64);  Selector 

(defconstant $kHIDUsage_LED_IndicatorOff 65)    ;  Selector 

(defconstant $kHIDUsage_LED_FlashOnTime 66)     ;  Dynamic Value 

(defconstant $kHIDUsage_LED_SlowBlinkOnTime 67) ;  Dynamic Value 

(defconstant $kHIDUsage_LED_SlowBlinkOffTime 68);  Dynamic Value 

(defconstant $kHIDUsage_LED_FastBlinkOnTime 69) ;  Dynamic Value 

(defconstant $kHIDUsage_LED_FastBlinkOffTime 70);  Dynamic Value 

(defconstant $kHIDUsage_LED_UsageIndicatorColor 71);  Usage Modifier 

(defconstant $kHIDUsage_LED_IndicatorRed 72)    ;  Selector 

(defconstant $kHIDUsage_LED_IndicatorGreen 73)  ;  Selector 

(defconstant $kHIDUsage_LED_IndicatorAmber 74)  ;  Selector 

(defconstant $kHIDUsage_LED_GenericIndicator 75);  On/Off Control 

(defconstant $kHIDUsage_LED_SystemSuspend 76)   ;  On/Off Control 

(defconstant $kHIDUsage_LED_ExternalPowerConnected 77);  On/Off Control 
;  0x4E - 0xFFFF Reserved 

(defconstant $kHIDUsage_LED_Reserved #xFFFF)
;  Button Page (0x09) 
;  The Button page is the first place an application should look for user selection controls. System graphical user interfaces typically employ a pointer and a set of hierarchical selectors to select, move and otherwise manipulate their environment. For these purposes the following assignment of significance can be applied to the Button usages: 
;  • Button 1, Primary Button. Used for object selecting, dragging, and double click activation. On MacOS, this is the only button. Microsoft operating systems call this a logical left button, because it 
;  is not necessarily physically located on the left of the pointing device. 
;  • Button 2, Secondary Button. Used by newer graphical user interfaces to browse object properties. Exposed by systems to applications that typically assign application-specific functionality. 
;  • Button 3, Tertiary Button. Optional control. Exposed to applications, but seldom assigned functionality due to prevalence of two- and one-button devices. 
;  • Buttons 4 -55. As the button number increases, its significance as a selector decreases. 
;  In many ways the assignment of button numbers is similar to the assignment of Effort in Physical descriptors. Button 1 would be used to define the button a finger rests on when the hand is in the “at rest” position, that is, virtually no effort is required by the user to activate the button. Button values increment as the finger has to stretch to reach a control. See Section 6.2.3, “Physical Descriptors,” in the HID Specification for methods of further qualifying buttons. 

(defconstant $kHIDUsage_Button_1 1)             ;  (primary/trigger) 

(defconstant $kHIDUsage_Button_2 2)             ;  (secondary) 

(defconstant $kHIDUsage_Button_3 3)             ;  (tertiary) 

(defconstant $kHIDUsage_Button_4 4)             ;  4th button 
;  ... 

(defconstant $kHIDUsage_Button_65535 #xFFFF)
;  Ordinal Page (0x0A) 
;  The Ordinal page allows multiple instances of a control or sets of controls to be declared without requiring individual enumeration in the native usage page. For example, it is not necessary to declare usages of Pointer 1, Pointer 2, and so forth on the Generic Desktop page. When parsed, the ordinal instance number is, in essence, concatenated to the usages attached to the encompassing collection to create Pointer 1, Pointer 2, and so forth. 
;  For an example, see Section A.5, “Multiple Instances of a Control,” in Appendix A, “Usage Examples.” By convention, an Ordinal collection is placed inside the collection for which it is declaring multiple instances. 
;  Instances do not have to be identical. 
;  0x00 Reserved 

(defconstant $kHIDUsage_Ord_Instance1 1)        ;  Usage Modifier 

(defconstant $kHIDUsage_Ord_Instance2 2)        ;  Usage Modifier 

(defconstant $kHIDUsage_Ord_Instance3 3)        ;  Usage Modifier 

(defconstant $kHIDUsage_Ord_Instance4 4)        ;  Usage Modifier 

(defconstant $kHIDUsage_Ord_Instance65535 #xFFFF);  Usage Modifier 
;  Telephony Page (0x0B) 
;  This usage page defines the keytop and control usages for telephony devices. 
;  Indicators on a phone are handled by wrapping them in LED: Usage In Use Indicator and LED: Usage Selected Indicator usages. For example, a message-indicator LED would be identified by a Telephony: Message usage declared as a Feature or Output in a LED: Usage In Use Indicator collection. 
;  See Section 14, “Consumer Page (0x0C),” for audio volume and tone controls. 

(defconstant $kHIDUsage_Tfon_Phone 1)           ;  Application Collection 

(defconstant $kHIDUsage_Tfon_AnsweringMachine 2);  Application Collection 

(defconstant $kHIDUsage_Tfon_MessageControls 3) ;  Logical Collection 

(defconstant $kHIDUsage_Tfon_Handset 4)         ;  Logical Collection 

(defconstant $kHIDUsage_Tfon_Headset 5)         ;  Logical Collection 

(defconstant $kHIDUsage_Tfon_TelephonyKeyPad 6) ;  Named Array 

(defconstant $kHIDUsage_Tfon_ProgrammableButton 7);  Named Array 
;  0x08 - 0x1F Reserved 

(defconstant $kHIDUsage_Tfon_HookSwitch 32)     ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_Flash 33)          ;  Momentary Control 

(defconstant $kHIDUsage_Tfon_Feature 34)        ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_Hold 35)           ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_Redial 36)         ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_Transfer 37)       ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_Drop 38)           ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_Park 39)           ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_ForwardCalls 40)   ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_AlternateFunction 41);  Momentary Control 

(defconstant $kHIDUsage_Tfon_Line 42)           ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_SpeakerPhone 43)   ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_Conference 44)     ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_RingEnable 45)     ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_Ring 46)           ;  Selector 

(defconstant $kHIDUsage_Tfon_PhoneMute 47)      ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_CallerID 48)       ;  Momentary Control 
;  0x31 - 0x4F Reserved 

(defconstant $kHIDUsage_Tfon_SpeedDial 80)      ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_StoreNumber 81)    ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_RecallNumber 82)   ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneDirectory 83) ;  On/Off Control 
;  0x54 - 0x6F Reserved 

(defconstant $kHIDUsage_Tfon_VoiceMail 112)     ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_ScreenCalls 113)   ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_DoNotDisturb 114)  ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_Message 115)       ;  One-Shot Control 

(defconstant $kHIDUsage_Tfon_AnswerOnOrOff 116) ;  On/Off Control 
;  0x75 - 0x8F Reserved 

(defconstant $kHIDUsage_Tfon_InsideDialTone #x90);  Momentary Control 

(defconstant $kHIDUsage_Tfon_OutsideDialTone #x91);  Momentary Control 

(defconstant $kHIDUsage_Tfon_InsideRingTone #x92);  Momentary Control 

(defconstant $kHIDUsage_Tfon_OutsideRingTone #x93);  Momentary Control 

(defconstant $kHIDUsage_Tfon_PriorityRingTone #x94);  Momentary Control 

(defconstant $kHIDUsage_Tfon_InsideRingback #x95);  Momentary Control 

(defconstant $kHIDUsage_Tfon_PriorityRingback #x96);  Momentary Control 

(defconstant $kHIDUsage_Tfon_LineBusyTone #x97) ;  Momentary Control 

(defconstant $kHIDUsage_Tfon_ReorderTone #x98)  ;  Momentary Control 

(defconstant $kHIDUsage_Tfon_CallWaitingTone #x99);  Momentary Control 

(defconstant $kHIDUsage_Tfon_ConfirmationTone1 #x9A);  Momentary Control 

(defconstant $kHIDUsage_Tfon_ConfirmationTone2 #x9B);  Momentary Control 

(defconstant $kHIDUsage_Tfon_TonesOff #x9C)     ;  On/Off Control 

(defconstant $kHIDUsage_Tfon_OutsideRingback #x9D);  Momentary Control 
;  0x9E - 0xAF Reserved 

(defconstant $kHIDUsage_Tfon_PhoneKey0 #xB0)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey1 #xB1)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey2 #xB2)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey3 #xB3)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey4 #xB4)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey5 #xB5)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey6 #xB6)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey7 #xB7)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey8 #xB8)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKey9 #xB9)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKeyStar #xBA) ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKeyPound #xBB);  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKeyA #xBC)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKeyB #xBD)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKeyC #xBE)    ;  Selector/One-Shot Control 

(defconstant $kHIDUsage_Tfon_PhoneKeyD #xBF)    ;  Selector/One-Shot Control 
;  0xC0 - 0xFFFF Reserved 

(defconstant $kHIDUsage_TFon_Reserved #xFFFF)
;  Consumer Page (0x0C) 
;  All controls on the Consumer page are application-specific. That is, they affect a specific device, not the system as a whole. 

(defconstant $kHIDUsage_Csmr_ConsumerControl 1) ;  Application Collection 

(defconstant $kHIDUsage_Csmr_NumericKeyPad 2)   ;  Named Array 

(defconstant $kHIDUsage_Csmr_ProgrammableButtons 3);  Named Array 
;  0x03 - 0x1F Reserved 

(defconstant $kHIDUsage_Csmr_Plus10 32)         ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Plus100 33)        ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_AMOrPM 34)         ;  One-Shot Control 
;  0x23 - 0x3F Reserved 

(defconstant $kHIDUsage_Csmr_Power 48)          ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_Reset 49)          ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Sleep 50)          ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_SleepAfter 51)     ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_SleepMode 52)      ;  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_Illumination 53)   ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_FunctionButtons 54);  Named Array 
;  0x37 - 0x3F Reserved 

(defconstant $kHIDUsage_Csmr_Menu 64)           ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_MenuPick 65)       ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_MenuUp 66)         ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_MenuDown 67)       ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_MenuLeft 68)       ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_MenuRight 69)      ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_MenuEscape 70)     ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_MenuValueIncrease 71);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_MenuValueDecrease 72);  One-Shot Control 
;  0x49 - 0x5F Reserved 

(defconstant $kHIDUsage_Csmr_DataOnScreen 96)   ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_ClosedCaption 97)  ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_ClosedCaptionSelect 98);  Selector 

(defconstant $kHIDUsage_Csmr_VCROrTV 99)        ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_BroadcastMode 100) ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Snapshot 101)      ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Still 102)         ;  One-Shot Control 
;  0x67 - 0x7F Reserved 

(defconstant $kHIDUsage_Csmr_Selection #x80)    ;  Named Array 

(defconstant $kHIDUsage_Csmr_Assign #x81)       ;  Selector 

(defconstant $kHIDUsage_Csmr_ModeStep #x82)     ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_RecallLast #x83)   ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_EnterChannel #x84) ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_OrderMovie #x85)   ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Channel #x86)      ;  Linear Control 

(defconstant $kHIDUsage_Csmr_MediaSelection #x87);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectComputer #x88);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectTV #x89);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectWWW #x8A);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectDVD #x8B);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectTelephone #x8C);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectProgramGuide #x8D);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectVideoPhone #x8E);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectGames #x8F);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectMessages #x90);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectCD #x91);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectVCR #x92);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectTuner #x93);  Selector 

(defconstant $kHIDUsage_Csmr_Quit #x94)         ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Help #x95)         ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_MediaSelectTape #x96);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectCable #x97);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectSatellite #x98);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectSecurity #x99);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectHome #x9A);  Selector 

(defconstant $kHIDUsage_Csmr_MediaSelectCall #x9B);  Selector 

(defconstant $kHIDUsage_Csmr_ChannelIncrement #x9C);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_ChannelDecrement #x9D);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Media #x9E)        ;  Selector 
;  0x9F Reserved 

(defconstant $kHIDUsage_Csmr_VCRPlus #xA0)      ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Once #xA1)         ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Daily #xA2)        ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Weekly #xA3)       ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Monthly #xA4)      ;  One-Shot Control 
;  0xA5 - 0xAF Reserved 

(defconstant $kHIDUsage_Csmr_Play #xB0)         ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_Pause #xB1)        ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_Record #xB2)       ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_FastForward #xB3)  ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_Rewind #xB4)       ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_ScanNextTrack #xB5);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_ScanPreviousTrack #xB6);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Stop #xB7)         ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Eject #xB8)        ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_RandomPlay #xB9)   ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_SelectDisc #xBA)   ;  Named Array 

(defconstant $kHIDUsage_Csmr_EnterDisc #xBB)    ;  Momentary Control 

(defconstant $kHIDUsage_Csmr_Repeat #xBC)       ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Tracking #xBD)     ;  Linear Control 

(defconstant $kHIDUsage_Csmr_TrackNormal #xBE)  ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_SlowTracking #xBF) ;  Linear Control 

(defconstant $kHIDUsage_Csmr_FrameForward #xC0) ;  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_FrameBack #xC1)    ;  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_Mark #xC2)         ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_ClearMark #xC3)    ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_RepeatFromMark #xC4);  On/Off Control 

(defconstant $kHIDUsage_Csmr_ReturnToMark #xC5) ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_SearchMarkForward #xC6);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_SearchMarkBackwards #xC7);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_CounterReset #xC8) ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_ShowCounter #xC9)  ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_TrackingIncrement #xCA);  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_TrackingDecrement #xCB);  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_StopOrEject #xCC)  ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_PlayOrPause #xCD)  ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_PlayOrSkip #xCE)   ;  One-Shot Control 
;  0xCF - 0xDF Reserved 

(defconstant $kHIDUsage_Csmr_Volume #xE0)       ;  Linear Control 

(defconstant $kHIDUsage_Csmr_Balance #xE1)      ;  Linear Control 

(defconstant $kHIDUsage_Csmr_Mute #xE2)         ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_Bass #xE3)         ;  Linear Control 

(defconstant $kHIDUsage_Csmr_Treble #xE4)       ;  Linear Control 

(defconstant $kHIDUsage_Csmr_BassBoost #xE5)    ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_SurroundMode #xE6) ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_Loudness #xE7)     ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_MPX #xE8)          ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_VolumeIncrement #xE9);  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_VolumeDecrement #xEA);  Re-Trigger Control 
;  0xEB - 0xEF Reserved 

(defconstant $kHIDUsage_Csmr_Speed #xF0)        ;  Selector 

(defconstant $kHIDUsage_Csmr_PlaybackSpeed #xF1);  Named Array 

(defconstant $kHIDUsage_Csmr_StandardPlay #xF2) ;  Selector 

(defconstant $kHIDUsage_Csmr_LongPlay #xF3)     ;  Selector 

(defconstant $kHIDUsage_Csmr_ExtendedPlay #xF4) ;  Selector 

(defconstant $kHIDUsage_Csmr_Slow #xF5)         ;  One-Shot Control 
;  0xF6 - 0xFF Reserved 

(defconstant $kHIDUsage_Csmr_FanEnable #x100)   ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_FanSpeed #x101)    ;  Linear Control 

(defconstant $kHIDUsage_Csmr_LightEnable #x102) ;  On/Off Control 

(defconstant $kHIDUsage_Csmr_LightIlluminationLevel #x103);  Linear Control 

(defconstant $kHIDUsage_Csmr_ClimateControlEnable #x104);  On/Off Control 

(defconstant $kHIDUsage_Csmr_RoomTemperature #x105);  Linear Control 

(defconstant $kHIDUsage_Csmr_SecurityEnable #x106);  On/Off Control 

(defconstant $kHIDUsage_Csmr_FireAlarm #x107)   ;  One-Shot Control 

(defconstant $kHIDUsage_Csmr_PoliceAlarm #x108) ;  One-Shot Control 
;  0x109 - 0x14F Reserved 

(defconstant $kHIDUsage_Csmr_BalanceRight #x150);  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_BalanceLeft #x151) ;  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_BassIncrement #x152);  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_BassDecrement #x153);  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_TrebleIncrement #x154);  Re-Trigger Control 

(defconstant $kHIDUsage_Csmr_TrebleDecrement #x155);  Re-Trigger Control 
;  0x156 - 0x15F Reserved 

(defconstant $kHIDUsage_Csmr_SpeakerSystem #x160);  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelLeft #x161) ;  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelRight #x162);  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelCenter #x163);  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelFront #x164);  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelCenterFront #x165);  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelSide #x166) ;  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelSurround #x167);  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelLowFrequencyEnhancement #x168);  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelTop #x169)  ;  Logical Collection 

(defconstant $kHIDUsage_Csmr_ChannelUnknown #x16A);  Logical Collection 
;  0x16B - 0x16F Reserved 

(defconstant $kHIDUsage_Csmr_SubChannel #x170)  ;  Linear Control 

(defconstant $kHIDUsage_Csmr_SubChannelIncrement #x171);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_SubChannelDecrement #x172);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_AlternateAudioIncrement #x173);  One-Shot Control 

(defconstant $kHIDUsage_Csmr_AlternateAudioDecrement #x174);  One-Shot Control 
;  0x175 - 0x17F Reserved 

(defconstant $kHIDUsage_Csmr_ApplicationLaunchButtons #x180);  Named Array 

(defconstant $kHIDUsage_Csmr_ALLaunchButtonConfigurationTool #x181);  Selector 

(defconstant $kHIDUsage_Csmr_ALProgrammableButtonConfiguration #x182);  Selector 

(defconstant $kHIDUsage_Csmr_ALConsumerControlConfiguration #x183);  Selector 

(defconstant $kHIDUsage_Csmr_ALWordProcessor #x184);  Selector 

(defconstant $kHIDUsage_Csmr_ALTextEditor #x185);  Selector 

(defconstant $kHIDUsage_Csmr_ALSpreadsheet #x186);  Selector 

(defconstant $kHIDUsage_Csmr_ALGraphicsEditor #x187);  Selector 

(defconstant $kHIDUsage_Csmr_ALPresentationApp #x188);  Selector 

(defconstant $kHIDUsage_Csmr_ALDatabaseApp #x189);  Selector 

(defconstant $kHIDUsage_Csmr_ALEmailReader #x18A);  Selector 

(defconstant $kHIDUsage_Csmr_ALNewsreader #x18B);  Selector 

(defconstant $kHIDUsage_Csmr_ALVoicemail #x18C) ;  Selector 

(defconstant $kHIDUsage_Csmr_ALContactsOrAddressBook #x18D);  Selector 

(defconstant $kHIDUsage_Csmr_ALCalendarOrSchedule #x18E);  Selector 

(defconstant $kHIDUsage_Csmr_ALTaskOrProjectManager #x18F);  Selector 

(defconstant $kHIDUsage_Csmr_ALLogOrJournalOrTimecard #x190);  Selector 

(defconstant $kHIDUsage_Csmr_ALCheckbookOrFinance #x191);  Selector 

(defconstant $kHIDUsage_Csmr_ALCalculator #x192);  Selector 

(defconstant $kHIDUsage_Csmr_ALAOrVCaptureOrPlayback #x193);  Selector 

(defconstant $kHIDUsage_Csmr_ALLocalMachineBrowser #x194);  Selector 

(defconstant $kHIDUsage_Csmr_ALLANOrWANBrowser #x195);  Selector 

(defconstant $kHIDUsage_Csmr_ALInternetBrowser #x196);  Selector 

(defconstant $kHIDUsage_Csmr_ALRemoteNetworkingOrISPConnect #x197);  Selector 

(defconstant $kHIDUsage_Csmr_ALNetworkConference #x198);  Selector 

(defconstant $kHIDUsage_Csmr_ALNetworkChat #x199);  Selector 

(defconstant $kHIDUsage_Csmr_ALTelephonyOrDialer #x19A);  Selector 

(defconstant $kHIDUsage_Csmr_ALLogon #x19B)     ;  Selector 

(defconstant $kHIDUsage_Csmr_ALLogoff #x19C)    ;  Selector 

(defconstant $kHIDUsage_Csmr_ALLogonOrLogoff #x19D);  Selector 

(defconstant $kHIDUsage_Csmr_ALTerminalLockOrScreensaver #x19E);  Selector 

(defconstant $kHIDUsage_Csmr_ALControlPanel #x19F);  Selector 

(defconstant $kHIDUsage_Csmr_ALCommandLineProcessorOrRun #x1A0);  Selector 

(defconstant $kHIDUsage_Csmr_ALProcessOrTaskManager #x1A1);  Selector 

(defconstant $kHIDUsage_Csmr_AL #x1A2)          ;  Selector 

(defconstant $kHIDUsage_Csmr_ALNextTaskOrApplication #x143);  Selector 

(defconstant $kHIDUsage_Csmr_ALPreviousTaskOrApplication #x1A4);  Selector 

(defconstant $kHIDUsage_Csmr_ALPreemptiveHaltTaskOrApplication #x1A5);  Selector 
;  0x1A6 - 0x1FF Reserved 

(defconstant $kHIDUsage_Csmr_GenericGUIApplicationControls #x200);  Named Array 

(defconstant $kHIDUsage_Csmr_ACNew #x201)       ;  Selector 

(defconstant $kHIDUsage_Csmr_ACOpen #x202)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACClose #x203)     ;  Selector 

(defconstant $kHIDUsage_Csmr_ACExit #x204)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACMaximize #x205)  ;  Selector 

(defconstant $kHIDUsage_Csmr_ACMinimize #x206)  ;  Selector 

(defconstant $kHIDUsage_Csmr_ACSave #x207)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACPrint #x208)     ;  Selector 

(defconstant $kHIDUsage_Csmr_ACProperties #x209);  Selector 

(defconstant $kHIDUsage_Csmr_ACUndo #x21A)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACCopy #x21B)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACCut #x21C)       ;  Selector 

(defconstant $kHIDUsage_Csmr_ACPaste #x21D)     ;  Selector 

(defconstant $kHIDUsage_Csmr_AC #x21E)          ;  Selector 

(defconstant $kHIDUsage_Csmr_ACFind #x21F)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACFindandReplace #x220);  Selector 

(defconstant $kHIDUsage_Csmr_ACSearch #x221)    ;  Selector 

(defconstant $kHIDUsage_Csmr_ACGoTo #x222)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACHome #x223)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACBack #x224)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACForward #x225)   ;  Selector 

(defconstant $kHIDUsage_Csmr_ACStop #x226)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACRefresh #x227)   ;  Selector 

(defconstant $kHIDUsage_Csmr_ACPreviousLink #x228);  Selector 

(defconstant $kHIDUsage_Csmr_ACNextLink #x229)  ;  Selector 

(defconstant $kHIDUsage_Csmr_ACBookmarks #x22A) ;  Selector 

(defconstant $kHIDUsage_Csmr_ACHistory #x22B)   ;  Selector 

(defconstant $kHIDUsage_Csmr_ACSubscriptions #x22C);  Selector 

(defconstant $kHIDUsage_Csmr_ACZoomIn #x22D)    ;  Selector 

(defconstant $kHIDUsage_Csmr_ACZoomOut #x22E)   ;  Selector 

(defconstant $kHIDUsage_Csmr_ACZoom #x22F)      ;  Selector 

(defconstant $kHIDUsage_Csmr_ACFullScreenView #x230);  Selector 

(defconstant $kHIDUsage_Csmr_ACNormalView #x231);  Selector 

(defconstant $kHIDUsage_Csmr_ACViewToggle #x232);  Selector 

(defconstant $kHIDUsage_Csmr_ACScrollUp #x233)  ;  Selector 

(defconstant $kHIDUsage_Csmr_ACScrollDown #x234);  Selector 

(defconstant $kHIDUsage_Csmr_ACScroll #x235)    ;  Selector 

(defconstant $kHIDUsage_Csmr_ACPanLeft #x236)   ;  Selector 

(defconstant $kHIDUsage_Csmr_ACPanRight #x237)  ;  Selector 

(defconstant $kHIDUsage_Csmr_ACPan #x238)       ;  Selector 

(defconstant $kHIDUsage_Csmr_ACNewWindow #x239) ;  Selector 

(defconstant $kHIDUsage_Csmr_ACTileHorizontally #x23A);  Selector 

(defconstant $kHIDUsage_Csmr_ACTileVertically #x23B);  Selector 

(defconstant $kHIDUsage_Csmr_ACFormat #x23C)    ;  Selector 
;  0x23D - 0xFFFF Reserved 

(defconstant $kHIDUsage_Csmr_Reserved #xFFFF)
;  Physical Interface Device Page (0x0F) 
;  This section provides detailed descriptions of the usages employed by Digitizer Devices. 

(defconstant $kHIDUsage_PID_PhysicalInterfaceDevice 1);  CA - A collection of PID usages 
;  0x02 - 0x1F Reserved 

(defconstant $kHIDUsage_PID_Normal 32)          ;  DV - A force applied perpendicular to the surface of an object 

(defconstant $kHIDUsage_PID_SetEffectReport 33) ;  XXX 

(defconstant $kHIDUsage_PID_EffectBlockIndex 34);  XXX 

(defconstant $kHIDUsage_PID_ParamBlockOffset 35);  XXX 

(defconstant $kHIDUsage_PID_ROM_Flag 36)        ;  XXX 

(defconstant $kHIDUsage_PID_EffectType 37)      ;  XXX 

(defconstant $kHIDUsage_PID_ET_ConstantForce 38);  XXX 

(defconstant $kHIDUsage_PID_ET_Ramp 39)         ;  XXX 

(defconstant $kHIDUsage_PID_ET_CustomForceData 40);  XXX 
;  0x29 - 0x2F Reserved 

(defconstant $kHIDUsage_PID_ET_Square 48)       ;  XXX 

(defconstant $kHIDUsage_PID_ET_Sine 49)         ;  XXX 

(defconstant $kHIDUsage_PID_ET_Triangle 50)     ;  XXX 

(defconstant $kHIDUsage_PID_ET_SawtoothUp 51)   ;  XXX 

(defconstant $kHIDUsage_PID_ET_SawtoothDown 52) ;  XXX 
;  0x35 - 0x3F Reserved 

(defconstant $kHIDUsage_PID_ET_Spring 64)       ;  XXX 

(defconstant $kHIDUsage_PID_ET_Damper 65)       ;  XXX 

(defconstant $kHIDUsage_PID_ET_Inertia 66)      ;  XXX 

(defconstant $kHIDUsage_PID_ET_Friction 67)     ;  XXX 
;  0x44 - 0x4F Reserved 

(defconstant $kHIDUsage_PID_Duration 80)        ;  XXX 

(defconstant $kHIDUsage_PID_SamplePeriod 81)    ;  XXX 

(defconstant $kHIDUsage_PID_Gain 82)            ;  XXX 

(defconstant $kHIDUsage_PID_TriggerButton 83)   ;  XXX 

(defconstant $kHIDUsage_PID_TriggerRepeatInterval 84);  XXX 

(defconstant $kHIDUsage_PID_AxesEnable 85)      ;  XXX 

(defconstant $kHIDUsage_PID_DirectionEnable 86) ;  XXX 

(defconstant $kHIDUsage_PID_Direction 87)       ;  XXX 

(defconstant $kHIDUsage_PID_TypeSpecificBlockOffset 88);  XXX 

(defconstant $kHIDUsage_PID_BlockType 89)       ;  XXX 

(defconstant $kHIDUsage_PID_SetEnvelopeReport 90);  XXX 

(defconstant $kHIDUsage_PID_AttackLevel 91)     ;  XXX 

(defconstant $kHIDUsage_PID_AttackTime 92)      ;  XXX 

(defconstant $kHIDUsage_PID_FadeLevel 93)       ;  XXX 

(defconstant $kHIDUsage_PID_FadeTime 94)        ;  XXX 

(defconstant $kHIDUsage_PID_SetConditionReport 95);  XXX 

(defconstant $kHIDUsage_PID_CP_Offset 96)       ;  XXX 

(defconstant $kHIDUsage_PID_PositiveCoefficient 97);  XXX 

(defconstant $kHIDUsage_PID_NegativeCoefficient 98);  XXX 

(defconstant $kHIDUsage_PID_PositiveSaturation 99);  XXX 

(defconstant $kHIDUsage_PID_NegativeSaturation 100);  XXX 

(defconstant $kHIDUsage_PID_DeadBand 101)       ;  XXX 

(defconstant $kHIDUsage_PID_DownloadForceSample 102);  XXX 

(defconstant $kHIDUsage_PID_IsochCustomForceEnable 103);  XXX 

(defconstant $kHIDUsage_PID_CustomForceDataReport 104);  XXX 

(defconstant $kHIDUsage_PID_CustomForceData 105);  XXX 

(defconstant $kHIDUsage_PID_CustomForceVendorDefinedData 106);  XXX 

(defconstant $kHIDUsage_PID_SetCustomForceReport 107);  XXX 

(defconstant $kHIDUsage_PID_CustomForceDataOffset 108);  XXX 

(defconstant $kHIDUsage_PID_SampleCount 109)    ;  XXX 

(defconstant $kHIDUsage_PID_SetPeriodicReport 110);  XXX 

(defconstant $kHIDUsage_PID_Offset 111)         ;  XXX 

(defconstant $kHIDUsage_PID_Magnitude 112)      ;  XXX 

(defconstant $kHIDUsage_PID_Phase 113)          ;  XXX 

(defconstant $kHIDUsage_PID_Period 114)         ;  XXX 

(defconstant $kHIDUsage_PID_SetConstantForceReport 115);  XXX 

(defconstant $kHIDUsage_PID_SetRampForceReport 116);  XXX 

(defconstant $kHIDUsage_PID_RampStart 117)      ;  XXX 

(defconstant $kHIDUsage_PID_RampEnd 118)        ;  XXX 

(defconstant $kHIDUsage_PID_EffectOperationReport 119);  XXX 

(defconstant $kHIDUsage_PID_EffectOperation 120);  XXX 

(defconstant $kHIDUsage_PID_OpEffectStart 121)  ;  XXX 

(defconstant $kHIDUsage_PID_OpEffectStartSolo 122);  XXX 

(defconstant $kHIDUsage_PID_OpEffectStop 123)   ;  XXX 

(defconstant $kHIDUsage_PID_LoopCount 124)      ;  XXX 

(defconstant $kHIDUsage_PID_DeviceGainReport 125);  XXX 

(defconstant $kHIDUsage_PID_DeviceGain 126)     ;  XXX 

(defconstant $kHIDUsage_PID_PoolReport 127)     ;  XXX 

(defconstant $kHIDUsage_PID_RAM_PoolSize #x80)  ;  XXX 

(defconstant $kHIDUsage_PID_ROM_PoolSize #x81)  ;  XXX 

(defconstant $kHIDUsage_PID_ROM_EffectBlockCount #x82);  XXX 

(defconstant $kHIDUsage_PID_SimultaneousEffectsMax #x83);  XXX 

(defconstant $kHIDUsage_PID_PoolAlignment #x84) ;  XXX 

(defconstant $kHIDUsage_PID_PoolMoveReport #x85);  XXX 

(defconstant $kHIDUsage_PID_MoveSource #x86)    ;  XXX 

(defconstant $kHIDUsage_PID_MoveDestination #x87);  XXX 

(defconstant $kHIDUsage_PID_MoveLength #x88)    ;  XXX 

(defconstant $kHIDUsage_PID_BlockLoadReport #x89);  XXX 
;  0x8A Reserved 

(defconstant $kHIDUsage_PID_BlockLoadStatus #x8B);  XXX 

(defconstant $kHIDUsage_PID_BlockLoadSuccess #x8C);  XXX 

(defconstant $kHIDUsage_PID_BlockLoadFull #x8D) ;  XXX 

(defconstant $kHIDUsage_PID_BlockLoadError #x8E);  XXX 

(defconstant $kHIDUsage_PID_BlockHandle #x8F)   ;  XXX 

(defconstant $kHIDUsage_PID_BlockFreeReport #x90);  XXX 

(defconstant $kHIDUsage_PID_TypeSpecificBlockHandle #x91);  XXX 

(defconstant $kHIDUsage_PID_StateReport #x92)   ;  XXX 
;  0x93 Reserved 

(defconstant $kHIDUsage_PID_EffectPlaying #x94) ;  XXX 

(defconstant $kHIDUsage_PID_DeviceControlReport #x95);  XXX 

(defconstant $kHIDUsage_PID_DeviceControl #x96) ;  XXX 

(defconstant $kHIDUsage_PID_DC_EnableActuators #x97);  XXX 

(defconstant $kHIDUsage_PID_DC_DisableActuators #x98);  XXX 

(defconstant $kHIDUsage_PID_DC_StopAllEffects #x99);  XXX 

(defconstant $kHIDUsage_PID_DC_DeviceReset #x9A);  XXX 

(defconstant $kHIDUsage_PID_DC_DevicePause #x9B);  XXX 

(defconstant $kHIDUsage_PID_DC_DeviceContinue #x9C);  XXX 
;  0x9d - 0x9E Reserved 

(defconstant $kHIDUsage_PID_DevicePaused #x9F)  ;  XXX 

(defconstant $kHIDUsage_PID_ActuatorsEnabled #xA0);  XXX 
;  0xA1 - 0xA3 Reserved 

(defconstant $kHIDUsage_PID_SafetySwitch #xA4)  ;  XXX 

(defconstant $kHIDUsage_PID_ActuatorOverrideSwitch #xA5);  XXX 

(defconstant $kHIDUsage_PID_ActuatorPower #xA6) ;  XXX 

(defconstant $kHIDUsage_PID_StartDelay #xA7)    ;  XXX 

(defconstant $kHIDUsage_PID_ParameterBlockSize #xA8);  XXX 

(defconstant $kHIDUsage_PID_DeviceManagedPool #xA9);  XXX 

(defconstant $kHIDUsage_PID_SharedParameterBlocks #xAA);  XXX 

(defconstant $kHIDUsage_PID_CreateNewEffectReport #xAB);  XXX 

(defconstant $kHIDUsage_PID_RAM_PoolAvailable #xAC);  XXX 
;  0xAD - 0xFFFF Reserved 

(defconstant $kHIDUsage_PID_Reserved #xFFFF)
;  Digitizer Page (0x0D) 
;  This section provides detailed descriptions of the usages employed by Digitizer Devices. 

(defconstant $kHIDUsage_Dig_Digitizer 1)        ;  Application Collection 

(defconstant $kHIDUsage_Dig_Pen 2)              ;  Application Collection 

(defconstant $kHIDUsage_Dig_LightPen 3)         ;  Application Collection 

(defconstant $kHIDUsage_Dig_TouchScreen 4)      ;  Application Collection 

(defconstant $kHIDUsage_Dig_TouchPad 5)         ;  Application Collection 

(defconstant $kHIDUsage_Dig_WhiteBoard 6)       ;  Application Collection 

(defconstant $kHIDUsage_Dig_CoordinateMeasuringMachine 7);  Application Collection 

(defconstant $kHIDUsage_Dig_3DDigitizer 8)      ;  Application Collection 

(defconstant $kHIDUsage_Dig_StereoPlotter 9)    ;  Application Collection 

(defconstant $kHIDUsage_Dig_ArticulatedArm 10)  ;  Application Collection 

(defconstant $kHIDUsage_Dig_Armature 11)        ;  Application Collection 

(defconstant $kHIDUsage_Dig_MultiplePointDigitizer 12);  Application Collection 

(defconstant $kHIDUsage_Dig_FreeSpaceWand 13)   ;  Application Collection 
;  0x0E - 0x1F Reserved 

(defconstant $kHIDUsage_Dig_Stylus 32)          ;  Logical Collection 

(defconstant $kHIDUsage_Dig_Puck 33)            ;  Logical Collection 

(defconstant $kHIDUsage_Dig_Finger 34)          ;  Logical Collection 
;  0x23 - 0x2F Reserved 

(defconstant $kHIDUsage_Dig_TipPressure 48)     ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_BarrelPressure 49)  ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_InRange 50)         ;  Momentary Control 

(defconstant $kHIDUsage_Dig_Touch 51)           ;  Momentary Control 

(defconstant $kHIDUsage_Dig_Untouch 52)         ;  One-Shot Control 

(defconstant $kHIDUsage_Dig_Tap 53)             ;  One-Shot Control 

(defconstant $kHIDUsage_Dig_Quality 54)         ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_DataValid 55)       ;  Momentary Control 

(defconstant $kHIDUsage_Dig_TransducerIndex 56) ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_TabletFunctionKeys 57);  Logical Collection 

(defconstant $kHIDUsage_Dig_ProgramChangeKeys 58);  Logical Collection 

(defconstant $kHIDUsage_Dig_BatteryStrength 59) ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_Invert 60)          ;  Momentary Control 

(defconstant $kHIDUsage_Dig_XTilt 61)           ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_YTilt 62)           ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_Azimuth 63)         ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_Altitude 64)        ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_Twist 65)           ;  Dynamic Value 

(defconstant $kHIDUsage_Dig_TipSwitch 66)       ;  Momentary Control 

(defconstant $kHIDUsage_Dig_SecondaryTipSwitch 67);  Momentary Control 

(defconstant $kHIDUsage_Dig_BarrelSwitch 68)    ;  Momentary Control 

(defconstant $kHIDUsage_Dig_Eraser 69)          ;  Momentary Control 

(defconstant $kHIDUsage_Dig_TabletPick 70)      ;  Momentary Control 
;  0x47 - 0xFFFF Reserved 

(defconstant $kHIDUsage_Dig_Reserved #xFFFF)
;  AlphanumericDisplay Page (0x14) 
;  The Alphanumeric Display page is intended for use by simple alphanumeric displays that are used on consumer devices. 

(defconstant $kHIDUsage_AD_AlphanumericDisplay 1);  Application Collection 
;  0x02 - 0x1F Reserved 

(defconstant $kHIDUsage_AD_DisplayAttributesReport 32);  Logical Collection 

(defconstant $kHIDUsage_AD_ASCIICharacterSet 33);  Static Flag 

(defconstant $kHIDUsage_AD_DataReadBack 34)     ;  Static Flag 

(defconstant $kHIDUsage_AD_FontReadBack 35)     ;  Static Flag 

(defconstant $kHIDUsage_AD_DisplayControlReport 36);  Logical Collection 

(defconstant $kHIDUsage_AD_ClearDisplay 37)     ;  Dynamic Flag 

(defconstant $kHIDUsage_AD_DisplayEnable 38)    ;  Dynamic Flag 

(defconstant $kHIDUsage_AD_ScreenSaverDelay 39) ;  Static Value 

(defconstant $kHIDUsage_AD_ScreenSaverEnable 40);  Dynamic Flag 

(defconstant $kHIDUsage_AD_VerticalScroll 41)   ;  Static Flag 

(defconstant $kHIDUsage_AD_HorizontalScroll 42) ;  Static Flag 

(defconstant $kHIDUsage_AD_CharacterReport 43)  ;  Logical Collection 

(defconstant $kHIDUsage_AD_DisplayData 44)      ;  Dynamic Value 

(defconstant $kHIDUsage_AD_DisplayStatus 45)    ;  Logical Collection 

(defconstant $kHIDUsage_AD_StatNotReady 46)     ;  Selector 

(defconstant $kHIDUsage_AD_StatReady 47)        ;  Selector 

(defconstant $kHIDUsage_AD_ErrNotaloadablecharacter 48);  Selector 

(defconstant $kHIDUsage_AD_ErrFontdatacannotberead 49);  Selector 

(defconstant $kHIDUsage_AD_CursorPositionReport 50);  Logical Collection 

(defconstant $kHIDUsage_AD_Row 51)              ;  Dynamic Value 

(defconstant $kHIDUsage_AD_Column 52)           ;  Dynamic Value 

(defconstant $kHIDUsage_AD_Rows 53)             ;  Static Value 

(defconstant $kHIDUsage_AD_Columns 54)          ;  Static Value 

(defconstant $kHIDUsage_AD_CursorPixelPositioning 55);  Static Flag 

(defconstant $kHIDUsage_AD_CursorMode 56)       ;  Dynamic Flag 

(defconstant $kHIDUsage_AD_CursorEnable 57)     ;  Dynamic Flag 

(defconstant $kHIDUsage_AD_CursorBlink 58)      ;  Dynamic Flag 

(defconstant $kHIDUsage_AD_FontReport 59)       ;  Logical Collection 

(defconstant $kHIDUsage_AD_FontData 60)         ;  Buffered Byte 

(defconstant $kHIDUsage_AD_CharacterWidth 61)   ;  Static Value 

(defconstant $kHIDUsage_AD_CharacterHeight 62)  ;  Static Value 

(defconstant $kHIDUsage_AD_CharacterSpacingHorizontal 63);  Static Value 

(defconstant $kHIDUsage_AD_CharacterSpacingVertical 64);  Static Value 

(defconstant $kHIDUsage_AD_UnicodeCharacterSet 65);  Static Flag 
;  0x42 - 0xFFFF Reserved 

(defconstant $kHIDUsage_AD_Reserved #xFFFF)
;  Power Device Page (0x84) 
;  This section provides detailed descriptions of the usages employed by Power Devices. 

(defconstant $kHIDUsage_PD_Undefined 0)         ;  Power Device Undefined Usage 

(defconstant $kHIDUsage_PD_iName 1)             ;  CL- Power Device Name Index 

(defconstant $kHIDUsage_PD_PresentStatus 2)     ;  CL- Power Device Present Status 

(defconstant $kHIDUsage_PD_ChangedStatus 3)     ;  CA- Power Device Changed Status 

(defconstant $kHIDUsage_PD_UPS 4)               ;  CA- Uninterruptible Power Supply 

(defconstant $kHIDUsage_PD_PowerSupply 5)       ;  CA- Power Supply 
;  Reserved 0x06 - 0x0F 

(defconstant $kHIDUsage_PD_BatterySystem 16)    ;  CP- Battery System power module 

(defconstant $kHIDUsage_PD_BatterySystemID 17)  ;  SV IF- Battery System ID 

(defconstant $kHIDUsage_PD_Battery 18)          ;  CP- Battery 

(defconstant $kHIDUsage_PD_BatteryID 19)        ;  SV IF- Battery ID 

(defconstant $kHIDUsage_PD_Charger 20)          ;  CP- Charger 

(defconstant $kHIDUsage_PD_ChargerID 21)        ;  SV IF- Charger ID 

(defconstant $kHIDUsage_PD_PowerConverter 22)   ;  CP- Power Converter power module 

(defconstant $kHIDUsage_PD_PowerConverterID 23) ;  SV IF- Power Converter ID 

(defconstant $kHIDUsage_PD_OutletSystem 24)     ;  CP- Outlet System power module 

(defconstant $kHIDUsage_PD_OutletSystemID 25)   ;  SV IF-Outlet System ID 

(defconstant $kHIDUsage_PD_Input 26)            ;  CP- Power Device Input 

(defconstant $kHIDUsage_PD_InputID 27)          ;  SV IF- Power Device Input ID 

(defconstant $kHIDUsage_PD_Output 28)           ;  CP- Power Device Output 

(defconstant $kHIDUsage_PD_OutputID 29)         ;  SV IF- Power Device Output ID 

(defconstant $kHIDUsage_PD_Flow 30)             ;  CP- Power Device Flow 

(defconstant $kHIDUsage_PD_FlowID 31)           ;  Item IF- Power Device Flow ID 

(defconstant $kHIDUsage_PD_Outlet 32)           ;  CP- Power Device Outlet 

(defconstant $kHIDUsage_PD_OutletID 33)         ;  SV IF- Power Device Outlet ID 

(defconstant $kHIDUsage_PD_Gang 34)             ;  CL/CP- Power Device Gang 

(defconstant $kHIDUsage_PD_GangID 35)           ;  SV IF- Power Device Gang ID 

(defconstant $kHIDUsage_PD_PowerSummary 36)     ;  CL/CP- Power Device Power Summary 

(defconstant $kHIDUsage_PD_PowerSummaryID 37)   ;  SV IF- Power Device Power Summary ID 
;  Reserved 0x26 - 0x2F 

(defconstant $kHIDUsage_PD_Voltage 48)          ;  DV IF- Power Device Voltage 

(defconstant $kHIDUsage_PD_Current 49)          ;  DV IF- Power Device Current 

(defconstant $kHIDUsage_PD_Frequency 50)        ;  DV IF- Power Device Frequency 

(defconstant $kHIDUsage_PD_ApparentPower 51)    ;  DV IF- Power Device Apparent Power 

(defconstant $kHIDUsage_PD_ActivePower 52)      ;  DV IF- Power Device RMS Power 

(defconstant $kHIDUsage_PD_PercentLoad 53)      ;  DV IF- Power Device Percent Load 

(defconstant $kHIDUsage_PD_Temperature 54)      ;  DV IF- Power Device Temperature 

(defconstant $kHIDUsage_PD_Humidity 55)         ;  DV IF- Power Device Humidity 

(defconstant $kHIDUsage_PD_BadCount 56)         ;  DV IF- Power Device Bad Condition Count 
;  Reserved 0x39 - 0x3F 

(defconstant $kHIDUsage_PD_ConfigVoltage 64)    ;  SV/DV F- Power Device Nominal Voltage 

(defconstant $kHIDUsage_PD_ConfigCurrent 65)    ;  SV/DV F- Power Device Nominal Current 

(defconstant $kHIDUsage_PD_ConfigFrequency 66)  ;  SV/DV F- Power Device Nominal Frequency 

(defconstant $kHIDUsage_PD_ConfigApparentPower 67);  SV/DV F- Power Device Nominal Apparent Power 

(defconstant $kHIDUsage_PD_ConfigActivePower 68);  SV/DV F- Power Device Nominal RMS Power 

(defconstant $kHIDUsage_PD_ConfigPercentLoad 69);  SV/DV F- Power Device Nominal Percent Load 

(defconstant $kHIDUsage_PD_ConfigTemperature 70);  SV/DV F- Power Device Nominal Temperature 

(defconstant $kHIDUsage_PD_ConfigHumidity 71)   ;  SV/DV F- Power Device Nominal Humidity 
;  Reserved 0x48 - 0x4F 

(defconstant $kHIDUsage_PD_SwitchOnControl 80)  ;  DV F- Power Device Switch On Control 

(defconstant $kHIDUsage_PD_SwitchOffControl 81) ;  DV F- Power Device Switch Off Control 

(defconstant $kHIDUsage_PD_ToggleControl 82)    ;  DV F- Power Device Toogle Sequence Control 

(defconstant $kHIDUsage_PD_LowVoltageTransfer 83);  DV F- Power Device Min Transfer Voltage 

(defconstant $kHIDUsage_PD_HighVoltageTransfer 84);  DV F- Power Device Max Transfer Voltage 

(defconstant $kHIDUsage_PD_DelayBeforeReboot 85);  DV F- Power Device Delay Before Reboot 

(defconstant $kHIDUsage_PD_DelayBeforeStartup 86);  DV F- Power Device Delay Before Startup 

(defconstant $kHIDUsage_PD_DelayBeforeShutdown 87);  DV F- Power Device Delay Before Shutdown 

(defconstant $kHIDUsage_PD_Test 88)             ;  DV F- Power Device Test Request/Result 

(defconstant $kHIDUsage_PD_ModuleReset 89)      ;  DV F- Power Device Reset Request/Result 

(defconstant $kHIDUsage_PD_AudibleAlarmControl 90);  DV F- Power Device Audible Alarm Control 
;  Reserved 0x5B - 0x5F 

(defconstant $kHIDUsage_PD_Present 96)          ;  DV IOF- Power Device Present 

(defconstant $kHIDUsage_PD_Good 97)             ;  DV IOF- Power Device Good 

(defconstant $kHIDUsage_PD_InternalFailure 98)  ;  DV IOF- Power Device Internal Failure 

(defconstant $kHIDUsage_PD_VoltageOutOfRange 99);  DV IOF- Power Device Voltage Out Of Range 

(defconstant $kHIDUsage_PD_FrequencyOutOfRange 100);  DV IOF- Power Device Frequency Out Of Range 

(defconstant $kHIDUsage_PD_Overload 101)        ;  DV IOF- Power Device Overload 

(defconstant $kHIDUsage_PD_OverCharged 102)     ;  DV IOF- Power Device Over Charged 

(defconstant $kHIDUsage_PD_OverTemperature 103) ;  DV IOF- Power Device Over Temperature 

(defconstant $kHIDUsage_PD_ShutdownRequested 104);  DV IOF- Power Device Shutdown Requested 

(defconstant $kHIDUsage_PD_ShutdownImminent 105);  DV IOF- Power Device Shutdown Imminent 
;  Reserved 0x6A 

(defconstant $kHIDUsage_PD_SwitchOnOff 107)     ;  DV IOF- Power Device On/Off Switch Status 

(defconstant $kHIDUsage_PD_Switchable 108)      ;  DV IOF- Power Device Switchable 

(defconstant $kHIDUsage_PD_Used 109)            ;  DV IOF- Power Device Used 

(defconstant $kHIDUsage_PD_Boost 110)           ;  DV IOF- Power Device Boosted 

(defconstant $kHIDUsage_PD_Buck 111)            ;  DV IOF- Power Device Bucked 

(defconstant $kHIDUsage_PD_Initialized 112)     ;  DV IOF- Power Device Initialized 

(defconstant $kHIDUsage_PD_Tested 113)          ;  DV IOF- Power Device Tested 

(defconstant $kHIDUsage_PD_AwaitingPower 114)   ;  DV IOF- Power Device Awaiting Power 

(defconstant $kHIDUsage_PD_CommunicationLost 115);  DV IOF- Power Device Communication Lost 
;  Reserved 0x74 - 0xFC 

(defconstant $kHIDUsage_PD_iManufacturer #xFD)  ;  SV F- Power Device Manufacturer String Index 

(defconstant $kHIDUsage_PD_iProduct #xFE)       ;  SV F- Power Device Product String Index 

(defconstant $kHIDUsage_PD_iserialNumber #xFF)  ;  SV F- Power Device Serial Number String Index 
;  Battery System Page (x85) 
;  This section provides detailed descriptions of the usages employed by Battery Systems. 

(defconstant $kHIDUsage_BS_Undefined 0)         ;  Battery System Undefined 

(defconstant $kHIDUsage_BS_SMBBatteryMode 1)    ;  CL - SMB Mode 

(defconstant $kHIDUsage_BS_SMBBatteryStatus 2)  ;  CL - SMB Status 

(defconstant $kHIDUsage_BS_SMBAlarmWarning 3)   ;  CL - SMB Alarm Warning 

(defconstant $kHIDUsage_BS_SMBChargerMode 4)    ;  CL - SMB Charger Mode 

(defconstant $kHIDUsage_BS_SMBChargerStatus 5)  ;  CL - SMB Charger Status 

(defconstant $kHIDUsage_BS_SMBChargerSpecInfo 6);  CL - SMB Charger Extended Status 

(defconstant $kHIDUsage_BS_SMBSelectorState 7)  ;  CL - SMB Selector State 

(defconstant $kHIDUsage_BS_SMBSelectorPresets 8);  CL - SMB Selector Presets 

(defconstant $kHIDUsage_BS_SMBSelectorInfo 9)   ;  CL - SMB Selector Info 
;  Reserved 0x0A - 0x0F 

(defconstant $kHIDUsage_BS_OptionalMfgFunction1 16);  DV F - Battery System Optional SMB Mfg Function 1 

(defconstant $kHIDUsage_BS_OptionalMfgFunction2 17);  DV F - Battery System Optional SMB Mfg Function 2 

(defconstant $kHIDUsage_BS_OptionalMfgFunction3 18);  DV F - Battery System Optional SMB Mfg Function 3 

(defconstant $kHIDUsage_BS_OptionalMfgFunction4 19);  DV F - Battery System Optional SMB Mfg Function 4 

(defconstant $kHIDUsage_BS_OptionalMfgFunction5 20);  DV F - Battery System Optional SMB Mfg Function 5 

(defconstant $kHIDUsage_BS_ConnectionToSMBus 21);  DF F - Battery System Connection To System Management Bus 

(defconstant $kHIDUsage_BS_OutputConnection 22) ;  DF F - Battery System Output Connection Status 

(defconstant $kHIDUsage_BS_ChargerConnection 23);  DF F - Battery System Charger Connection 

(defconstant $kHIDUsage_BS_BatteryInsertion 24) ;  DF F - Battery System Battery Insertion 

(defconstant $kHIDUsage_BS_Usenext 25)          ;  DF F - Battery System Use Next 

(defconstant $kHIDUsage_BS_OKToUse 26)          ;  DF F - Battery System OK To Use 

(defconstant $kHIDUsage_BS_BatterySupported 27) ;  DF F - Battery System Battery Supported 

(defconstant $kHIDUsage_BS_SelectorRevision 28) ;  DF F - Battery System Selector Revision 

(defconstant $kHIDUsage_BS_ChargingIndicator 29);  DF F - Battery System Charging Indicator 
;  Reserved 0x1E - 0x27 

(defconstant $kHIDUsage_BS_ManufacturerAccess 40);  DV F - Battery System Manufacturer Access 

(defconstant $kHIDUsage_BS_RemainingCapacityLimit 41);  DV F - Battery System Remaining Capacity Limit 

(defconstant $kHIDUsage_BS_RemainingTimeLimit 42);  DV F - Battery System Remaining Time Limit 

(defconstant $kHIDUsage_BS_AtRate 43)           ;  DV F - Battery System At Rate... 

(defconstant $kHIDUsage_BS_CapacityMode 44)     ;  DV F - Battery System Capacity Mode 

(defconstant $kHIDUsage_BS_BroadcastToCharger 45);  DV F - Battery System Broadcast To Charger 

(defconstant $kHIDUsage_BS_PrimaryBattery 46)   ;  DV F - Battery System Primary Battery 

(defconstant $kHIDUsage_BS_ChargeController 47) ;  DV F - Battery System Charge Controller 
;  Reserved 0x30 - 0x3F 

(defconstant $kHIDUsage_BS_TerminateCharge 64)  ;  DF IOF - Battery System Terminate Charge 

(defconstant $kHIDUsage_BS_TerminateDischarge 65);  DF IOF - Battery System Terminate Discharge 

(defconstant $kHIDUsage_BS_BelowRemainingCapacityLimit 66);  DF IOF - Battery System Below Remaining Capacity Limit 

(defconstant $kHIDUsage_BS_RemainingTimeLimitExpired 67);  DF IOF - Battery System Remaining Time Limit Expired 

(defconstant $kHIDUsage_BS_Charging 68)         ;  DF IOF - Battery System Charging 

(defconstant $kHIDUsage_BS_Discharging 69)      ;  DV IOF - Battery System Discharging 

(defconstant $kHIDUsage_BS_FullyCharged 70)     ;  DF IOF - Battery System Fully Charged 

(defconstant $kHIDUsage_BS_FullyDischarged 71)  ;  DV IOF - Battery System Fully Discharged 

(defconstant $kHIDUsage_BS_ConditioningFlag 72) ;  DV IOF - Battery System Conditioning Flag 

(defconstant $kHIDUsage_BS_AtRateOK 73)         ;  DV IOF - Battery System At Rate OK 

(defconstant $kHIDUsage_BS_SMBErrorCode 74)     ;  DF IOF - Battery System SMB Error Code 

(defconstant $kHIDUsage_BS_NeedReplacement 75)  ;  DF IOF - Battery System Need Replacement 
;  Reserved 0x4C - 0x5F 

(defconstant $kHIDUsage_BS_AtRateTimeToFull 96) ;  DV IF - Battery System At Rate Time To Full 

(defconstant $kHIDUsage_BS_AtRateTimeToEmpty 97);  DV IF - Battery System At Rate Time To Empty 

(defconstant $kHIDUsage_BS_AverageCurrent 98)   ;  DV IF - Battery System Average Current 

(defconstant $kHIDUsage_BS_Maxerror 99)         ;  DV IF - Battery System Max Error 

(defconstant $kHIDUsage_BS_RelativeStateOfCharge 100);  DV IF - Battery System Relative State Of Charge 

(defconstant $kHIDUsage_BS_AbsoluteStateOfCharge 101);  DV IF - Battery System Absolute State Of Charge 

(defconstant $kHIDUsage_BS_RemainingCapacity 102);  DV IF - Battery System Remaining Capacity 

(defconstant $kHIDUsage_BS_FullChargeCapacity 103);  DV IF - Battery System Full Charge Capacity 

(defconstant $kHIDUsage_BS_RunTimeToEmpty 104)  ;  DV IF - Battery System Run Time To Empty 

(defconstant $kHIDUsage_BS_AverageTimeToEmpty 105);  DV IF - Battery System Average Time To Empty 

(defconstant $kHIDUsage_BS_AverageTimeToFull 106);  DV IF - Battery System Average Time To Full 

(defconstant $kHIDUsage_BS_CycleCount 107)      ;  DV IF - Battery System Cycle Count 
;  Reserved 0x6C - 0x7F 

(defconstant $kHIDUsage_BS_BattPackModelLevel #x80);  SV F - Battery System Batt Pack Model Level 

(defconstant $kHIDUsage_BS_InternalChargeController #x81);  SF F - Battery System Internal Charge Controller 

(defconstant $kHIDUsage_BS_PrimaryBatterySupport #x82);  SF F - Battery System Primary Battery Support 

(defconstant $kHIDUsage_BS_DesignCapacity #x83) ;  SV F - Battery System Design Capacity 

(defconstant $kHIDUsage_BS_SpecificationInfo #x84);  SV F - Battery System Specification Info 

(defconstant $kHIDUsage_BS_ManufacturerDate #x85);  SV F - Battery System Manufacturer Date 

(defconstant $kHIDUsage_BS_SerialNumber #x86)   ;  SV F - Battery System Serial Number 

(defconstant $kHIDUsage_BS_iManufacturerName #x87);  SV F - Battery System Manufacturer Name Index 

(defconstant $kHIDUsage_BS_iDevicename #x88)    ;  SV F - Battery System Device Name Index 

(defconstant $kHIDUsage_BS_iDeviceChemistry #x89);  SV F - Battery System Device Chemistry Index 

(defconstant $kHIDUsage_BS_ManufacturerData #x8A);  SV F - Battery System Manufacturer Data 

(defconstant $kHIDUsage_BS_Rechargable #x8B)    ;  SV F - Battery System Rechargable 

(defconstant $kHIDUsage_BS_WarningCapacityLimit #x8C);  SV F - Battery System Warning Capacity Limit 

(defconstant $kHIDUsage_BS_CapacityGranularity1 #x8D);  SV F - Battery System Capacity Granularity 1 

(defconstant $kHIDUsage_BS_CapacityGranularity2 #x8E);  SV F - Battery System Capacity Granularity 2 

(defconstant $kHIDUsage_BS_iOEMInformation #x8F);  SV F - Battery System OEM Information Index 
;  Reserved 0x90 - 0xBF 

(defconstant $kHIDUsage_BS_InhibitCharge #xC0)  ;  DF IOF - Battery System Inhibit Charge 

(defconstant $kHIDUsage_BS_EnablePolling #xC1)  ;  DF IOF - Battery System Enable Polling 

(defconstant $kHIDUsage_BS_ResetToZero #xC2)    ;  DF IOF - Battery System Reset To Zero 
;  Reserved 0xC3 - 0xCF 

(defconstant $kHIDUsage_BS_ACPresent #xD0)      ;  DF IOF - Battery System AC Present 

(defconstant $kHIDUsage_BS_BatteryPresent #xD1) ;  DF IOF - Battery System Battery Present 

(defconstant $kHIDUsage_BS_PowerFail #xD2)      ;  DF IOF - Battery System Power Fail 

(defconstant $kHIDUsage_BS_AlarmInhibited #xD3) ;  DF IOF - Battery System Alarm Inhibited 

(defconstant $kHIDUsage_BS_ThermistorUnderRange #xD4);  DF IOF - Battery System Thermistor Under Range 

(defconstant $kHIDUsage_BS_ThermistorHot #xD5)  ;  DF IOF - Battery System Thermistor Hot 

(defconstant $kHIDUsage_BS_ThermistorCold #xD6) ;  DF IOF - Battery System Thermistor Cold 

(defconstant $kHIDUsage_BS_ThermistorOverRange #xD7);  DF IOF - Battery System Thermistor Over Range 

(defconstant $kHIDUsage_BS_VoltageOutOfRange #xD8);  DF IOF - Battery System Voltage Out Of Range 

(defconstant $kHIDUsage_BS_CurrentOutOfRange #xD9);  DF IOF - Battery System Current Out Of Range 

(defconstant $kHIDUsage_BS_CurrentNotRegulated #xDA);  DF IOF - Battery System Current Not Regulated 

(defconstant $kHIDUsage_BS_VoltageNotRegulated #xDB);  DF IOF - Battery System Voltage Not Regulated 

(defconstant $kHIDUsage_BS_MasterMode #xDC)     ;  DF IOF - Battery System Master Mode 
;  Reserved 0xDD - 0xEF 

(defconstant $kHIDUsage_BS_ChargerSelectorSupport #xF0);  SF F- Battery System Charger Support Selector 

(defconstant $kHIDUsage_BS_ChargerSpec #xF1)    ;  SF F- Battery System Charger Specification 

(defconstant $kHIDUsage_BS_Level2 #xF2)         ;  SF F- Battery System Charger Level 2 

(defconstant $kHIDUsage_BS_Level3 #xF3)         ;  SF F- Battery System Charger Level 3 
;  Reserved 0xF2 - 0xFF 


; #endif /* _IOHIDUSAGETABLES_H */


(provide-interface "IOHIDUsageTables")