(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MacErrors.h"
; at Sunday July 2,2006 7:23:09 pm.
; 
;      File:       CarbonCore/MacErrors.h
;  
;      Contains:   OSErr codes.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MACERRORS__
; #define __MACERRORS__
; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(defconstant $paramErr -50)                     ; error in user parameter list

(defconstant $noHardwareErr -200)               ; Sound Manager Error Returns

(defconstant $notEnoughHardwareErr -201)        ; Sound Manager Error Returns

(defconstant $userCanceledErr -128)
(defconstant $qErr -1)                          ; queue element not found during deletion

(defconstant $vTypErr -2)                       ; invalid queue element

(defconstant $corErr -3)                        ; core routine number out of range

(defconstant $unimpErr -4)                      ; unimplemented core routine

(defconstant $SlpTypeErr -5)                    ; invalid queue element

(defconstant $seNoDB -8)                        ; no debugger installed to handle debugger command

(defconstant $controlErr -17)                   ; I/O System Errors

(defconstant $statusErr -18)                    ; I/O System Errors

(defconstant $readErr -19)                      ; I/O System Errors

(defconstant $writErr -20)                      ; I/O System Errors

(defconstant $badUnitErr -21)                   ; I/O System Errors

(defconstant $unitEmptyErr -22)                 ; I/O System Errors

(defconstant $openErr -23)                      ; I/O System Errors

(defconstant $closErr -24)                      ; I/O System Errors

(defconstant $dRemovErr -25)                    ; tried to remove an open driver
; DrvrInstall couldn't find driver in resources

(defconstant $dInstErr -26)

(defconstant $abortErr -27)                     ; IO call aborted by KillIO

(defconstant $iIOAbortErr -27)                  ; IO abort error (Printing Manager)

(defconstant $notOpenErr -28)                   ; Couldn't rd/wr/ctl/sts cause driver not opened

(defconstant $unitTblFullErr -29)               ; unit table has no more entries

(defconstant $dceExtErr -30)                    ; dce extension error

(defconstant $slotNumErr -360)                  ; invalid slot # error

(defconstant $gcrOnMFMErr -400)                 ; gcr format on high density media error

(defconstant $dirFulErr -33)                    ; Directory full

(defconstant $dskFulErr -34)                    ; disk full

(defconstant $nsvErr -35)                       ; no such volume

(defconstant $ioErr -36)                        ; I/O error (bummers)

(defconstant $bdNamErr -37)                     ; there may be no bad names in the final system!

(defconstant $fnOpnErr -38)                     ; File not open

(defconstant $eofErr -39)                       ; End of file

(defconstant $posErr -40)                       ; tried to position to before start of file (r/w)

(defconstant $mFulErr -41)                      ; memory full (open) or file won't fit (load)

(defconstant $tmfoErr -42)                      ; too many files open

(defconstant $fnfErr -43)                       ; File not found

(defconstant $wPrErr -44)                       ; diskette is write protected.
; file is locked

(defconstant $fLckdErr -45)

(defconstant $vLckdErr -46)                     ; volume is locked

(defconstant $fBsyErr -47)                      ; File is busy (delete)

(defconstant $dupFNErr -48)                     ; duplicate filename (rename)

(defconstant $opWrErr -49)                      ; file already open with with write permission

(defconstant $rfNumErr -51)                     ; refnum error

(defconstant $gfpErr -52)                       ; get file position error

(defconstant $volOffLinErr -53)                 ; volume not on line error (was Ejected)

(defconstant $permErr -54)                      ; permissions error (on file open)

(defconstant $volOnLinErr -55)                  ; drive volume already on-line at MountVol

(defconstant $nsDrvErr -56)                     ; no such drive (tried to mount a bad drive num)

(defconstant $noMacDskErr -57)                  ; not a mac diskette (sig bytes are wrong)

(defconstant $extFSErr -58)                     ; volume in question belongs to an external fs

(defconstant $fsRnErr -59)                      ; file system internal error:during rename the old entry was deleted but could not be restored.

(defconstant $badMDBErr -60)                    ; bad master directory block

(defconstant $wrPermErr -61)                    ; write permissions error

(defconstant $dirNFErr -120)                    ; Directory not found

(defconstant $tmwdoErr -121)                    ; No free WDCB available

(defconstant $badMovErr -122)                   ; Move into offspring error

(defconstant $wrgVolTypErr -123)                ; Wrong volume type error [operation not supported for MFS]
; Server volume has been disconnected.

(defconstant $volGoneErr -124)

(defconstant $fidNotFound -1300)                ; no file thread exists.

(defconstant $fidExists -1301)                  ; file id already exists

(defconstant $notAFileErr -1302)                ; directory specified

(defconstant $diffVolErr -1303)                 ; files on different volumes

(defconstant $catChangedErr -1304)              ; the catalog has been modified

(defconstant $desktopDamagedErr -1305)          ; desktop database files are corrupted

(defconstant $sameFileErr -1306)                ; can't exchange a file with itself

(defconstant $badFidErr -1307)                  ; file id is dangling or doesn't match with the file number

(defconstant $notARemountErr -1308)             ; when _Mount allows only remounts and doesn't get one

(defconstant $fileBoundsErr -1309)              ; file's EOF, offset, mark or size is too big

(defconstant $fsDataTooBigErr -1310)            ; file or volume is too big for system

(defconstant $volVMBusyErr -1311)               ; can't eject because volume is in use by VM

(defconstant $badFCBErr -1327)                  ; FCBRecPtr is not valid

(defconstant $errFSUnknownCall -1400)           ;  selector is not recognized by this filesystem 

(defconstant $errFSBadFSRef -1401)              ;  FSRef parameter is bad 

(defconstant $errFSBadForkName -1402)           ;  Fork name parameter is bad 

(defconstant $errFSBadBuffer -1403)             ;  A buffer parameter was bad 

(defconstant $errFSBadForkRef -1404)            ;  A ForkRefNum parameter was bad 

(defconstant $errFSBadInfoBitmap -1405)         ;  A CatalogInfoBitmap or VolumeInfoBitmap has reserved or invalid bits set 

(defconstant $errFSMissingCatInfo -1406)        ;  A CatalogInfo parameter was NULL 

(defconstant $errFSNotAFolder -1407)            ;  Expected a folder, got a file 

(defconstant $errFSForkNotFound -1409)          ;  Named fork does not exist 

(defconstant $errFSNameTooLong -1410)           ;  File/fork name is too long to create/rename 

(defconstant $errFSMissingName -1411)           ;  A Unicode name parameter was NULL or nameLength parameter was zero 

(defconstant $errFSBadPosMode -1412)            ;  Newline bits set in positionMode 

(defconstant $errFSBadAllocFlags -1413)         ;  Invalid bits set in allocationFlags 

(defconstant $errFSNoMoreItems -1417)           ;  Iteration ran out of items to return 

(defconstant $errFSBadItemCount -1418)          ;  maximumItems was zero 

(defconstant $errFSBadSearchParams -1419)       ;  Something wrong with CatalogSearch searchParams 

(defconstant $errFSRefsDifferent -1420)         ;  FSCompareFSRefs; refs are for different objects 

(defconstant $errFSForkExists -1421)            ;  Named fork already exists. 

(defconstant $errFSBadIteratorFlags -1422)      ;  Flags passed to FSOpenIterator are bad 

(defconstant $errFSIteratorNotFound -1423)      ;  Passed FSIterator is not an open iterator 

(defconstant $errFSIteratorNotSupported -1424)  ;  The iterator's flags or container are not supported by this call 

(defconstant $errFSQuotaExceeded -1425)         ;  The user's quota of disk blocks has been exhausted. 

(defconstant $envNotPresent -5500)              ; returned by glue.

(defconstant $envBadVers -5501)                 ; Version non-positive

(defconstant $envVersTooBig -5502)              ; Version bigger than call can handle

(defconstant $fontDecError -64)                 ; error during font declaration

(defconstant $fontNotDeclared -65)              ; font not declared

(defconstant $fontSubErr -66)                   ; font substitution occurred

(defconstant $fontNotOutlineErr -32615)         ; bitmap font passed to routine that does outlines only

(defconstant $firstDskErr -84)                  ; I/O System Errors

(defconstant $lastDskErr -64)                   ; I/O System Errors

(defconstant $noDriveErr -64)                   ; drive not installed

(defconstant $offLinErr -65)                    ; r/w requested for an off-line drive
; couldn't find 5 nybbles in 200 tries

(defconstant $noNybErr -66)

(defconstant $noAdrMkErr -67)                   ; couldn't find valid addr mark

(defconstant $dataVerErr -68)                   ; read verify compare failed

(defconstant $badCksmErr -69)                   ; addr mark checksum didn't check

(defconstant $badBtSlpErr -70)                  ; bad addr mark bit slip nibbles

(defconstant $noDtaMkErr -71)                   ; couldn't find a data mark header

(defconstant $badDCksum -72)                    ; bad data mark checksum

(defconstant $badDBtSlp -73)                    ; bad data mark bit slip nibbles

(defconstant $wrUnderrun -74)                   ; write underrun occurred

(defconstant $cantStepErr -75)                  ; step handshake failed

(defconstant $tk0BadErr -76)                    ; track 0 detect doesn't change

(defconstant $initIWMErr -77)                   ; unable to initialize IWM

(defconstant $twoSideErr -78)                   ; tried to read 2nd side on a 1-sided drive

(defconstant $spdAdjErr -79)                    ; unable to correctly adjust disk speed

(defconstant $seekErr -80)                      ; track number wrong on address mark

(defconstant $sectNFErr -81)                    ; sector number never found on a track

(defconstant $fmt1Err -82)                      ; can't find sector 0 after track format

(defconstant $fmt2Err -83)                      ; can't get enough sync

(defconstant $verErr -84)                       ; track failed to verify

(defconstant $clkRdErr -85)                     ; unable to read same clock value twice

(defconstant $clkWrErr -86)                     ; time written did not verify

(defconstant $prWrErr -87)                      ; parameter ram written didn't read-verify

(defconstant $prInitErr -88)                    ; InitUtil found the parameter ram uninitialized

(defconstant $rcvrErr -89)                      ; SCC receiver error (framing; parity; OR)
; Break received (SCC)

(defconstant $breakRecd -90)
; Scrap Manager errors

(defconstant $noScrapErr -100)                  ; No scrap exists error
; No object of that type in scrap

(defconstant $noTypeErr -102)
;  ENET error codes 

(defconstant $eLenErr -92)                      ; Length error ddpLenErr
; Multicast address error ddpSktErr

(defconstant $eMultiErr -91)

(defconstant $ddpSktErr -91)                    ; error in soket number

(defconstant $ddpLenErr -92)                    ; data length too big

(defconstant $noBridgeErr -93)                  ; no network bridge for non-local send

(defconstant $lapProtErr -94)                   ; error in attaching/detaching protocol

(defconstant $excessCollsns -95)                ; excessive collisions on write

(defconstant $portNotPwr -96)                   ; serial port not currently powered

(defconstant $portInUse -97)                    ; driver Open error code (port is in use)
; driver Open error code (parameter RAM not configured for this connection)

(defconstant $portNotCf -98)
;  Memory Manager errors

(defconstant $memROZWarn -99)                   ; soft error in ROZ

(defconstant $memROZError -99)                  ; hard error in ROZ

(defconstant $memROZErr -99)                    ; hard error in ROZ

(defconstant $memFullErr -108)                  ; Not enough room in heap zone

(defconstant $nilHandleErr -109)                ; Master Pointer was NIL in HandleZone or other

(defconstant $memWZErr -111)                    ; WhichZone failed (applied to free block)

(defconstant $memPurErr -112)                   ; trying to purge a locked or non-purgeable block

(defconstant $memAdrErr -110)                   ; address was odd; or out of range

(defconstant $memAZErr -113)                    ; Address in zone check failed

(defconstant $memPCErr -114)                    ; Pointer Check failed

(defconstant $memBCErr -115)                    ; Block Check failed

(defconstant $memSCErr -116)                    ; Size Check failed
; trying to move a locked block (MoveHHi)

(defconstant $memLockedErr -117)
;  Printing Errors 

(defconstant $iMemFullErr -108)
(defconstant $iIOAbort -27)

(defconstant $resourceInMemory -188)            ; Resource already in memory

(defconstant $writingPastEnd -189)              ; Writing past end of file

(defconstant $inputOutOfBounds -190)            ; Offset of Count out of bounds

(defconstant $resNotFound -192)                 ; Resource not found

(defconstant $resFNotFound -193)                ; Resource file not found

(defconstant $addResFailed -194)                ; AddResource failed

(defconstant $addRefFailed -195)                ; AddReference failed

(defconstant $rmvResFailed -196)                ; RmveResource failed

(defconstant $rmvRefFailed -197)                ; RmveReference failed

(defconstant $resAttrErr -198)                  ; attribute inconsistent with operation

(defconstant $mapReadErr -199)                  ; map inconsistent with operation

(defconstant $CantDecompress -186)              ; resource bent ("the bends") - can't decompress a compressed resource

(defconstant $badExtResource -185)              ; extended resource has a bad format.

(defconstant $noMemForPictPlaybackErr -145)
(defconstant $rgnOverflowErr -147)
(defconstant $rgnTooBigError -147)
(defconstant $pixMapTooDeepErr -148)
(defconstant $insufficientStackErr -149)
(defconstant $nsStackErr -149)

(defconstant $evtNotEnb 1)                      ; event not enabled at PostEvent

;  OffScreen QuickDraw Errors 

(defconstant $cMatchErr -150)                   ; Color2Index failed to find an index

(defconstant $cTempMemErr -151)                 ; failed to allocate memory for temporary structures

(defconstant $cNoMemErr -152)                   ; failed to allocate memory for structure

(defconstant $cRangeErr -153)                   ; range error on colorTable request

(defconstant $cProtectErr -154)                 ; colorTable entry protection violation

(defconstant $cDevErr -155)                     ; invalid type of graphics device

(defconstant $cResErr -156)                     ; invalid resolution for MakeITable

(defconstant $cDepthErr -157)                   ; invalid pixel depth 

(defconstant $rgnTooBigErr -500)                ;  should have never been added! (cf. rgnTooBigError = 147) 

(defconstant $updPixMemErr -125)                ; insufficient memory to update a pixmap

(defconstant $pictInfoVersionErr -11000)        ; wrong version of the PictInfo structure

(defconstant $pictInfoIDErr -11001)             ; the internal consistancy check for the PictInfoID is wrong

(defconstant $pictInfoVerbErr -11002)           ; the passed verb was invalid

(defconstant $cantLoadPickMethodErr -11003)     ; unable to load the custom pick proc

(defconstant $colorsRequestedErr -11004)        ; the number of colors requested was illegal
; the picture data was invalid

(defconstant $pictureDataErr -11005)
;  ColorSync Result codes 
;  General Errors 

(defconstant $cmProfileError -170)
(defconstant $cmMethodError -171)
(defconstant $cmMethodNotFound -175)            ;  CMM not present 

(defconstant $cmProfileNotFound -176)           ;  Responder error 

(defconstant $cmProfilesIdentical -177)         ;  Profiles the same 

(defconstant $cmCantConcatenateError -178)      ;  Profile can't be concatenated 

(defconstant $cmCantXYZ -179)                   ;  CMM cant handle XYZ space 

(defconstant $cmCantDeleteProfile -180)         ;  Responder error 

(defconstant $cmUnsupportedDataType -181)       ;  Responder error 
;  Responder error 

(defconstant $cmNoCurrentProfile -182)
; Sound Manager errors

(defconstant $noHardware -200)                  ; obsolete spelling

(defconstant $notEnoughHardware -201)           ; obsolete spelling

(defconstant $queueFull -203)                   ; Sound Manager Error Returns

(defconstant $resProblem -204)                  ; Sound Manager Error Returns

(defconstant $badChannel -205)                  ; Sound Manager Error Returns

(defconstant $badFormat -206)                   ; Sound Manager Error Returns

(defconstant $notEnoughBufferSpace -207)        ; could not allocate enough memory

(defconstant $badFileFormat -208)               ; was not type AIFF or was of bad format,corrupt

(defconstant $channelBusy -209)                 ; the Channel is being used for a PFD already

(defconstant $buffersTooSmall -210)             ; can not operate in the memory allowed

(defconstant $channelNotBusy -211)
(defconstant $noMoreRealTime -212)              ; not enough CPU cycles left to add another task

(defconstant $siVBRCompressionNotSupported -213); vbr audio compression not supported for this operation

(defconstant $siNoSoundInHardware -220)         ; no Sound Input hardware

(defconstant $siBadSoundInDevice -221)          ; invalid index passed to SoundInGetIndexedDevice

(defconstant $siNoBufferSpecified -222)         ; returned by synchronous SPBRecord if nil buffer passed

(defconstant $siInvalidCompression -223)        ; invalid compression type

(defconstant $siHardDriveTooSlow -224)          ; hard drive too slow to record to disk

(defconstant $siInvalidSampleRate -225)         ; invalid sample rate

(defconstant $siInvalidSampleSize -226)         ; invalid sample size

(defconstant $siDeviceBusyErr -227)             ; input device already in use

(defconstant $siBadDeviceName -228)             ; input device could not be opened

(defconstant $siBadRefNum -229)                 ; invalid input device reference number

(defconstant $siInputDeviceErr -230)            ; input device hardware failure

(defconstant $siUnknownInfoType -231)           ; invalid info type selector (returned by driver)
; invalid quality selector (returned by driver)

(defconstant $siUnknownQuality -232)
; Speech Manager errors

(defconstant $noSynthFound -240)
(defconstant $synthOpenFailed -241)
(defconstant $synthNotReady -242)
(defconstant $bufTooSmall -243)
(defconstant $voiceNotFound -244)
(defconstant $incompatibleVoice -245)
(defconstant $badDictFormat -246)
(defconstant $badInputText -247)
;  Midi Manager Errors: 

(defconstant $midiNoClientErr -250)             ; no client with that ID found

(defconstant $midiNoPortErr -251)               ; no port with that ID found

(defconstant $midiTooManyPortsErr -252)         ; too many ports already installed in the system

(defconstant $midiTooManyConsErr -253)          ; too many connections made

(defconstant $midiVConnectErr -254)             ; pending virtual connection created

(defconstant $midiVConnectMade -255)            ; pending virtual connection resolved

(defconstant $midiVConnectRmvd -256)            ; pending virtual connection removed

(defconstant $midiNoConErr -257)                ; no connection exists between specified ports

(defconstant $midiWriteErr -258)                ; MIDIWritePacket couldn't write to all connected ports

(defconstant $midiNameLenErr -259)              ; name supplied is longer than 31 characters

(defconstant $midiDupIDErr -260)                ; duplicate client ID
; command not supported for port type

(defconstant $midiInvalidCmdErr -261)
; Notification Manager:wrong queue type

(defconstant $nmTypErr -299)

(defconstant $siInitSDTblErr 1)                 ; slot int dispatch table could not be initialized.

(defconstant $siInitVBLQsErr 2)                 ; VBLqueues for all slots could not be initialized.

(defconstant $siInitSPTblErr 3)                 ; slot priority table could not be initialized.

(defconstant $sdmJTInitErr 10)                  ; SDM Jump Table could not be initialized.

(defconstant $sdmInitErr 11)                    ; SDM could not be initialized.

(defconstant $sdmSRTInitErr 12)                 ; Slot Resource Table could not be initialized.

(defconstant $sdmPRAMInitErr 13)                ; Slot PRAM could not be initialized.

(defconstant $sdmPriInitErr 14)                 ; Cards could not be initialized.


(defconstant $smSDMInitErr -290)                ; Error; SDM could not be initialized.

(defconstant $smSRTInitErr -291)                ; Error; Slot Resource Table could not be initialized.

(defconstant $smPRAMInitErr -292)               ; Error; Slot Resource Table could not be initialized.

(defconstant $smPriInitErr -293)                ; Error; Cards could not be initialized.

(defconstant $smEmptySlot -300)                 ; No card in slot

(defconstant $smCRCFail -301)                   ; CRC check failed for declaration data

(defconstant $smFormatErr -302)                 ; FHeader Format is not Apple's

(defconstant $smRevisionErr -303)               ; Wrong revison level

(defconstant $smNoDir -304)                     ; Directory offset is Nil

(defconstant $smDisabledSlot -305)              ; This slot is disabled (-305 use to be smLWTstBad)
; No sInfoArray. Memory Mgr error.

(defconstant $smNosInfoArray -306)

(defconstant $smResrvErr -307)                  ; Fatal reserved error. Resreved field <> 0.

(defconstant $smUnExBusErr -308)                ; Unexpected BusError

(defconstant $smBLFieldBad -309)                ; ByteLanes field was bad.

(defconstant $smFHBlockRdErr -310)              ; Error occurred during _sGetFHeader.

(defconstant $smFHBlkDispErr -311)              ; Error occurred during _sDisposePtr (Dispose of FHeader block).

(defconstant $smDisposePErr -312)               ; _DisposePointer error

(defconstant $smNoBoardSRsrc -313)              ; No Board sResource.

(defconstant $smGetPRErr -314)                  ; Error occurred during _sGetPRAMRec (See SIMStatus).

(defconstant $smNoBoardId -315)                 ; No Board Id.

(defconstant $smInitStatVErr -316)              ; The InitStatusV field was negative after primary or secondary init.

(defconstant $smInitTblVErr -317)               ; An error occurred while trying to initialize the Slot Resource Table.

(defconstant $smNoJmpTbl -318)                  ; SDM jump table could not be created.

(defconstant $smReservedSlot -318)              ; slot is reserved, VM should not use this address space.

(defconstant $smBadBoardId -319)                ; BoardId was wrong; re-init the PRAM record.

(defconstant $smBusErrTO -320)                  ; BusError time out.
;  These errors are logged in the  vendor status field of the sInfo record. 

(defconstant $svTempDisable -32768)             ; Temporarily disable card but run primary init.

(defconstant $svDisabled -32640)                ; Reserve range -32640 to -32768 for Apple temp disables.

(defconstant $smBadRefId -330)                  ; Reference Id not found in List

(defconstant $smBadsList -331)                  ; Bad sList: Id1 < Id2 < Id3 ...format is not followed.

(defconstant $smReservedErr -332)               ; Reserved field not zero
; Code revision is wrong

(defconstant $smCodeRevErr -333)

(defconstant $smCPUErr -334)                    ; Code revision is wrong

(defconstant $smsPointerNil -335)               ; LPointer is nil From sOffsetData. If this error occurs; check sInfo rec for more information.

(defconstant $smNilsBlockErr -336)              ; Nil sBlock error (Don't allocate and try to use a nil sBlock)

(defconstant $smSlotOOBErr -337)                ; Slot out of bounds error

(defconstant $smSelOOBErr -338)                 ; Selector out of bounds error

(defconstant $smNewPErr -339)                   ; _NewPtr error

(defconstant $smBlkMoveErr -340)                ; _BlockMove error

(defconstant $smCkStatusErr -341)               ; Status of slot = fail.

(defconstant $smGetDrvrNamErr -342)             ; Error occurred during _sGetDrvrName.

(defconstant $smDisDrvrNamErr -343)             ; Error occurred during _sDisDrvrName.

(defconstant $smNoMoresRsrcs -344)              ; No more sResources

(defconstant $smsGetDrvrErr -345)               ; Error occurred during _sGetDriver.

(defconstant $smBadsPtrErr -346)                ; Bad pointer was passed to sCalcsPointer

(defconstant $smByteLanesErr -347)              ; NumByteLanes was determined to be zero.

(defconstant $smOffsetErr -348)                 ; Offset was too big (temporary error

(defconstant $smNoGoodOpens -349)               ; No opens were successfull in the loop.

(defconstant $smSRTOvrFlErr -350)               ; SRT over flow.
; Record not found in the SRT.

(defconstant $smRecNotFnd -351)
; Dictionary Manager errors

(defconstant $notBTree -410)                    ; The file is not a dictionary.

(defconstant $btNoSpace -413)                   ; Can't allocate disk space.

(defconstant $btDupRecErr -414)                 ; Record already exists.

(defconstant $btRecNotFnd -415)                 ; Record cannot be found.

(defconstant $btKeyLenErr -416)                 ; Maximum key length is too long or equal to zero.

(defconstant $btKeyAttrErr -417)                ; There is no such a key attribute.

(defconstant $unknownInsertModeErr -20000)      ; There is no such an insert mode.

(defconstant $recordDataTooBigErr -20001)       ; The record data is bigger than buffer size (1024 bytes).
; The recordIndex parameter is not valid.

(defconstant $invalidIndexErr -20002)
; 
;  * Error codes from FSM functions
;  

(defconstant $fsmFFSNotFoundErr -431)           ;  Foreign File system does not exist - new Pack2 could return this error too 

(defconstant $fsmBusyFFSErr -432)               ;  File system is busy, cannot be removed 

(defconstant $fsmBadFFSNameErr -433)            ;  Name length not 1 <= length <= 31 

(defconstant $fsmBadFSDLenErr -434)             ;  FSD size incompatible with current FSM vers 

(defconstant $fsmDuplicateFSIDErr -435)         ;  FSID already exists on InstallFS 

(defconstant $fsmBadFSDVersionErr -436)         ;  FSM version incompatible with FSD 

(defconstant $fsmNoAlternateStackErr -437)      ;  no alternate stack for HFS CI 
;  unknown message passed to FSM 

(defconstant $fsmUnknownFSMMessageErr -438)
;  Edition Mgr errors

(defconstant $editionMgrInitErr -450)           ; edition manager not inited by this app

(defconstant $badSectionErr -451)               ; not a valid SectionRecord

(defconstant $notRegisteredSectionErr -452)     ; not a registered SectionRecord

(defconstant $badEditionFileErr -453)           ; edition file is corrupt

(defconstant $badSubPartErr -454)               ; can not use sub parts in this release

(defconstant $multiplePublisherWrn -460)        ; A Publisher is already registered for that container

(defconstant $containerNotFoundWrn -461)        ; could not find editionContainer at this time

(defconstant $containerAlreadyOpenWrn -462)     ; container already opened by this section
; not the first registered publisher for that container

(defconstant $notThePublisherWrn -463)

(defconstant $teScrapSizeErr -501)              ; scrap item too big for text edit record

(defconstant $hwParamErr -502)                  ; bad selector for _HWPriv
; disk driver's hardware was disconnected

(defconstant $driverHardwareGoneErr -503)
; Process Manager errors

(defconstant $procNotFound -600)                ; no eligible process with specified descriptor

(defconstant $memFragErr -601)                  ; not enough room to launch app w/special requirements

(defconstant $appModeErr -602)                  ; memory mode is 32-bit, but app not 32-bit clean

(defconstant $protocolErr -603)                 ; app made module calls in improper order

(defconstant $hardwareConfigErr -604)           ; hardware configuration not correct for call

(defconstant $appMemFullErr -605)               ; application SIZE not big enough for launch

(defconstant $appIsDaemon -606)                 ; app is BG-only, and launch flags disallow this

(defconstant $bufferIsSmall -607)               ; error returns from Post and Accept 

(defconstant $noOutstandingHLE -608)
(defconstant $connectionInvalid -609)           ;  no user interaction allowed 

(defconstant $noUserInteractionAllowed -610)
;  More Process Manager errors 

(defconstant $wrongApplicationPlatform -875)    ;  The application could not launch because the required platform is not available    

(defconstant $appVersionTooOld -876)            ;  The application's creator and version are incompatible with the current version of Mac OS. 
;  This application won't or shouldn't run on Classic (Problem 2481058). 

(defconstant $notAppropriateForClassic -877)
;  Thread Manager Error Codes 

(defconstant $threadTooManyReqsErr -617)
(defconstant $threadNotFoundErr -618)
(defconstant $threadProtocolErr -619)

(defconstant $threadBadAppContextErr -616)
; MemoryDispatch errors

(defconstant $notEnoughMemoryErr -620)          ; insufficient physical memory

(defconstant $notHeldErr -621)                  ; specified range of memory is not held

(defconstant $cannotMakeContiguousErr -622)     ; cannot make specified range contiguous

(defconstant $notLockedErr -623)                ; specified range of memory is not locked

(defconstant $interruptsMaskedErr -624)         ; don’t call with interrupts masked

(defconstant $cannotDeferErr -625)              ; unable to defer additional functions
; no MMU present

(defconstant $noMMUErr -626)
;  Internal VM error codes returned in pVMGLobals (b78) if VM doesn't load 

(defconstant $vmMorePhysicalThanVirtualErr -628); VM could not start because there was more physical memory than virtual memory (bad setting in VM config resource)

(defconstant $vmKernelMMUInitErr -629)          ; VM could not start because VM_MMUInit kernel call failed

(defconstant $vmOffErr -630)                    ; VM was configured off, or command key was held down at boot

(defconstant $vmMemLckdErr -631)                ; VM could not start because of a lock table conflict (only on non-SuperMario ROMs)

(defconstant $vmBadDriver -632)                 ; VM could not start because the driver was incompatible
; VM could not start because the vector code could not load

(defconstant $vmNoVectorErr -633)
;  FileMapping errors 

(defconstant $vmInvalidBackingFileIDErr -640)   ;  invalid BackingFileID 

(defconstant $vmMappingPrivilegesErr -641)      ;  requested MappingPrivileges cannot be obtained 

(defconstant $vmBusyBackingFileErr -642)        ;  open views found on BackingFile 

(defconstant $vmNoMoreBackingFilesErr -643)     ;  no more BackingFiles were found 

(defconstant $vmInvalidFileViewIDErr -644)      ; invalid FileViewID 

(defconstant $vmFileViewAccessErr -645)         ;  requested FileViewAccess cannot be obtained 

(defconstant $vmNoMoreFileViewsErr -646)        ;  no more FileViews were found 

(defconstant $vmAddressNotInFileViewErr -647)   ;  address is not in a FileView 
;  current process does not own the BackingFileID or FileViewID 

(defconstant $vmInvalidOwningProcessErr -648)
;  Database access error codes 

(defconstant $rcDBNull -800)
(defconstant $rcDBValue -801)
(defconstant $rcDBError -802)
(defconstant $rcDBBadType -803)
(defconstant $rcDBBreak -804)
(defconstant $rcDBExec -805)
(defconstant $rcDBBadSessID -806)
(defconstant $rcDBBadSessNum -807)              ;  bad session number for DBGetConnInfo 

(defconstant $rcDBBadDDEV -808)                 ;  bad ddev specified on DBInit 

(defconstant $rcDBAsyncNotSupp -809)            ;  ddev does not support async calls 

(defconstant $rcDBBadAsyncPB -810)              ;  tried to kill a bad pb 

(defconstant $rcDBNoHandler -811)               ;  no app handler for specified data type 

(defconstant $rcDBWrongVersion -812)            ;  incompatible versions 
;  attempt to call other routine before InitDBPack 

(defconstant $rcDBPackNotInited -813)
; Help Mgr error range: -850 to -874

(defconstant $hmHelpDisabled -850)              ;  Show Balloons mode was off, call to routine ignored 

(defconstant $hmBalloonAborted -853)            ;  Returned if mouse was moving or mouse wasn't in window port rect 

(defconstant $hmSameAsLastBalloon -854)         ;  Returned from HMShowMenuBalloon if menu & item is same as last time 

(defconstant $hmHelpManagerNotInited -855)      ;  Returned from HMGetHelpMenuHandle if help menu not setup 

(defconstant $hmSkippedBalloon -857)            ;  Returned from calls if helpmsg specified a skip balloon 

(defconstant $hmWrongVersion -858)              ;  Returned if help mgr resource was the wrong version 

(defconstant $hmUnknownHelpType -859)           ;  Returned if help msg record contained a bad type 

(defconstant $hmOperationUnsupported -861)      ;  Returned from HMShowBalloon call if bad method passed to routine 

(defconstant $hmNoBalloonUp -862)               ;  Returned from HMRemoveBalloon if no balloon was visible when call was made 
;  Returned from HMRemoveBalloon if CloseView was active 

(defconstant $hmCloseViewActive -863)
; PPC errors

(defconstant $notInitErr -900)                  ; PPCToolBox not initialized

(defconstant $nameTypeErr -902)                 ; Invalid or inappropriate locationKindSelector in locationName

(defconstant $noPortErr -903)                   ; Unable to open port or bad portRefNum.  If you're calling 
;  AESend, this is because your application does not have 
;  the isHighLevelEventAware bit set in your SIZE resource. 

(defconstant $noGlobalsErr -904)                ; The system is hosed, better re-boot

(defconstant $localOnlyErr -905)                ; Network activity is currently disabled

(defconstant $destPortErr -906)                 ; Port does not exist at destination

(defconstant $sessTableErr -907)                ; Out of session tables, try again later

(defconstant $noSessionErr -908)                ; Invalid session reference number

(defconstant $badReqErr -909)                   ; bad parameter or invalid state for operation

(defconstant $portNameExistsErr -910)           ; port is already open (perhaps in another app)

(defconstant $noUserNameErr -911)               ; user name unknown on destination machine

(defconstant $userRejectErr -912)               ; Destination rejected the session request

(defconstant $noMachineNameErr -913)            ; user hasn't named his Macintosh in the Network Setup Control Panel

(defconstant $noToolboxNameErr -914)            ; A system resource is missing, not too likely

(defconstant $noResponseErr -915)               ; unable to contact destination

(defconstant $portClosedErr -916)               ; port was closed

(defconstant $sessClosedErr -917)               ; session was closed

(defconstant $badPortNameErr -919)              ; PPCPortRec malformed

(defconstant $noDefaultUserErr -922)            ; user hasn't typed in owners name in Network Setup Control Pannel

(defconstant $notLoggedInErr -923)              ; The default userRefNum does not yet exist

(defconstant $noUserRefErr -924)                ; unable to create a new userRefNum

(defconstant $networkErr -925)                  ; An error has occurred in the network, not too likely

(defconstant $noInformErr -926)                 ; PPCStart failed because destination did not have inform pending

(defconstant $authFailErr -927)                 ; unable to authenticate user at destination

(defconstant $noUserRecErr -928)                ; Invalid user reference number

(defconstant $badServiceMethodErr -930)         ; illegal service type, or not supported

(defconstant $badLocNameErr -931)               ; location name malformed
; destination port requires authentication

(defconstant $guestNotAllowedErr -932)
;  Font Mgr errors

(defconstant $kFMIterationCompleted -980)
(defconstant $kFMInvalidFontFamilyErr -981)
(defconstant $kFMInvalidFontErr -982)
(defconstant $kFMIterationScopeModifiedErr -983)
(defconstant $kFMFontTableAccessErr -984)
(defconstant $kFMFontContainerAccessErr -985)
; Icon Utilties Error

(defconstant $noMaskFoundErr -1000)

(defconstant $nbpBuffOvr -1024)                 ; Buffer overflow in LookupName

(defconstant $nbpNoConfirm -1025)
(defconstant $nbpConfDiff -1026)                ; Name confirmed at different socket

(defconstant $nbpDuplicate -1027)               ; Duplicate name exists already

(defconstant $nbpNotFound -1028)                ; Name not found on remove
; Error trying to open the NIS

(defconstant $nbpNISErr -1029)

(defconstant $aspBadVersNum -1066)              ; Server cannot support this ASP version

(defconstant $aspBufTooSmall -1067)             ; Buffer too small

(defconstant $aspNoMoreSess -1068)              ; No more sessions on server

(defconstant $aspNoServers -1069)               ; No servers at that address

(defconstant $aspParamErr -1070)                ; Parameter error

(defconstant $aspServerBusy -1071)              ; Server cannot open another session

(defconstant $aspSessClosed -1072)              ; Session closed

(defconstant $aspSizeErr -1073)                 ; Command block too big

(defconstant $aspTooMany -1074)                 ; Too many clients (server error)
; No ack on attention request (server err)

(defconstant $aspNoAck -1075)

(defconstant $reqFailed -1096)
(defconstant $tooManyReqs -1097)
(defconstant $tooManySkts -1098)
(defconstant $badATPSkt -1099)
(defconstant $badBuffNum -1100)
(defconstant $noRelErr -1101)
(defconstant $cbNotFound -1102)
(defconstant $noSendResp -1103)
(defconstant $noDataArea -1104)
(defconstant $reqAborted -1105)
;  ADSP Error Codes 
;  driver control ioResults 

(defconstant $errRefNum -1280)                  ;  bad connection refNum 

(defconstant $errAborted -1279)                 ;  control call was aborted 

(defconstant $errState -1278)                   ;  bad connection state for this operation 

(defconstant $errOpening -1277)                 ;  open connection request failed 

(defconstant $errAttention -1276)               ;  attention message too long 

(defconstant $errFwdReset -1275)                ;  read terminated by forward reset 

(defconstant $errDSPQueueSize -1274)            ;  DSP Read/Write Queue Too small 
;  open connection request was denied 

(defconstant $errOpenDenied -1273)
; --------------------------------------------------------------
;         Apple event manager error messages
; --------------------------------------------------------------

(defconstant $errAECoercionFail -1700)          ;  bad parameter data or unable to coerce the data supplied 

(defconstant $errAEDescNotFound -1701)
(defconstant $errAECorruptData -1702)
(defconstant $errAEWrongDataType -1703)
(defconstant $errAENotAEDesc -1704)
(defconstant $errAEBadListItem -1705)           ;  the specified list item does not exist 

(defconstant $errAENewerVersion -1706)          ;  need newer version of the AppleEvent manager 

(defconstant $errAENotAppleEvent -1707)         ;  the event is not in AppleEvent format 

(defconstant $errAEEventNotHandled -1708)       ;  the AppleEvent was not handled by any handler 

(defconstant $errAEReplyNotValid -1709)         ;  AEResetTimer was passed an invalid reply parameter 

(defconstant $errAEUnknownSendMode -1710)       ;  mode wasn't NoReply, WaitReply, or QueueReply or Interaction level is unknown 

(defconstant $errAEWaitCanceled -1711)          ;  in AESend, the user cancelled out of wait loop for reply or receipt 

(defconstant $errAETimeout -1712)               ;  the AppleEvent timed out 

(defconstant $errAENoUserInteraction -1713)     ;  no user interaction is allowed 

(defconstant $errAENotASpecialFunction -1714)   ;  there is no special function for/with this keyword 

(defconstant $errAEParamMissed -1715)           ;  a required parameter was not accessed 

(defconstant $errAEUnknownAddressType -1716)    ;  the target address type is not known 

(defconstant $errAEHandlerNotFound -1717)       ;  no handler in the dispatch tables fits the parameters to AEGetEventHandler or AEGetCoercionHandler 

(defconstant $errAEReplyNotArrived -1718)       ;  the contents of the reply you are accessing have not arrived yet 

(defconstant $errAEIllegalIndex -1719)          ;  index is out of range in a put operation 

(defconstant $errAEImpossibleRange -1720)       ;  A range like 3rd to 2nd, or 1st to all. 

(defconstant $errAEWrongNumberArgs -1721)       ;  Logical op kAENOT used with other than 1 term 

(defconstant $errAEAccessorNotFound -1723)      ;  Accessor proc matching wantClass and containerType or wildcards not found 

(defconstant $errAENoSuchLogical -1725)         ;  Something other than AND, OR, or NOT 

(defconstant $errAEBadTestKey -1726)            ;  Test is neither typeLogicalDescriptor nor typeCompDescriptor 

(defconstant $errAENotAnObjSpec -1727)          ;  Param to AEResolve not of type 'obj ' 

(defconstant $errAENoSuchObject -1728)          ;  e.g.,: specifier asked for the 3rd, but there are only 2. Basically, this indicates a run-time resolution error. 

(defconstant $errAENegativeCount -1729)         ;  CountProc returned negative value 

(defconstant $errAEEmptyListContainer -1730)    ;  Attempt to pass empty list as container to accessor 

(defconstant $errAEUnknownObjectType -1731)     ;  available only in version 1.0.1 or greater 

(defconstant $errAERecordingIsAlreadyOn -1732)  ;  available only in version 1.0.1 or greater 

(defconstant $errAEReceiveTerminate -1733)      ;  break out of all levels of AEReceive to the topmost (1.1 or greater) 

(defconstant $errAEReceiveEscapeCurrent -1734)  ;  break out of only lowest level of AEReceive (1.1 or greater) 

(defconstant $errAEEventFiltered -1735)         ;  event has been filtered, and should not be propogated (1.1 or greater) 

(defconstant $errAEDuplicateHandler -1736)      ;  attempt to install handler in table for identical class and id (1.1 or greater) 

(defconstant $errAEStreamBadNesting -1737)      ;  nesting violation while streaming 

(defconstant $errAEStreamAlreadyConverted -1738);  attempt to convert a stream that has already been converted 

(defconstant $errAEDescIsNull -1739)            ;  attempting to perform an invalid operation on a null descriptor 

(defconstant $errAEBuildSyntaxError -1740)      ;  AEBuildDesc and friends detected a syntax error 
;  buffer for AEFlattenDesc too small 

(defconstant $errAEBufferTooSmall -1741)

(defconstant $errOSASystemError -1750)
(defconstant $errOSAInvalidID -1751)
(defconstant $errOSABadStorageType -1752)
(defconstant $errOSAScriptError -1753)
(defconstant $errOSABadSelector -1754)
(defconstant $errOSASourceNotAvailable -1756)
(defconstant $errOSANoSuchDialect -1757)
(defconstant $errOSADataFormatObsolete -1758)
(defconstant $errOSADataFormatTooNew -1759)
(defconstant $errOSACorruptData -1702)
(defconstant $errOSARecordingIsAlreadyOn -1732)
(defconstant $errOSAComponentMismatch -1761)    ;  Parameters are from 2 different components 
;  Can't connect to scripting system with that ID 

(defconstant $errOSACantOpenComponent -1762)
;  AppleEvent error definitions 

(defconstant $errOffsetInvalid -1800)
(defconstant $errOffsetIsOutsideOfView -1801)
(defconstant $errTopOfDocument -1810)
(defconstant $errTopOfBody -1811)
(defconstant $errEndOfDocument -1812)
(defconstant $errEndOfBody -1813)
;  Drag Manager error codes 

(defconstant $badDragRefErr -1850)              ;  unknown drag reference 

(defconstant $badDragItemErr -1851)             ;  unknown drag item reference 

(defconstant $badDragFlavorErr -1852)           ;  unknown flavor type 

(defconstant $duplicateFlavorErr -1853)         ;  flavor type already exists 

(defconstant $cantGetFlavorErr -1854)           ;  error while trying to get flavor data 

(defconstant $duplicateHandlerErr -1855)        ;  handler already exists 

(defconstant $handlerNotFoundErr -1856)         ;  handler not found 

(defconstant $dragNotAcceptedErr -1857)         ;  drag was not accepted by receiver 

(defconstant $unsupportedForPlatformErr -1858)  ;  call is for PowerPC only 

(defconstant $noSuitableDisplaysErr -1859)      ;  no displays support translucency 

(defconstant $badImageRgnErr -1860)             ;  bad translucent image region 

(defconstant $badImageErr -1861)                ;  bad translucent image PixMap 
;  illegal attempt at originator only data 

(defconstant $nonDragOriginatorErr -1862)
; QuickTime errors

(defconstant $couldNotResolveDataRef -2000)
(defconstant $badImageDescription -2001)
(defconstant $badPublicMovieAtom -2002)
(defconstant $cantFindHandler -2003)
(defconstant $cantOpenHandler -2004)
(defconstant $badComponentType -2005)
(defconstant $noMediaHandler -2006)
(defconstant $noDataHandler -2007)
(defconstant $invalidMedia -2008)
(defconstant $invalidTrack -2009)
(defconstant $invalidMovie -2010)
(defconstant $invalidSampleTable -2011)
(defconstant $invalidDataRef -2012)
(defconstant $invalidHandler -2013)
(defconstant $invalidDuration -2014)
(defconstant $invalidTime -2015)
(defconstant $cantPutPublicMovieAtom -2016)
(defconstant $badEditList -2017)
(defconstant $mediaTypesDontMatch -2018)
(defconstant $progressProcAborted -2019)
(defconstant $movieToolboxUninitialized -2020)
(defconstant $noRecordOfApp -2020)              ;  replica 

(defconstant $wfFileNotFound -2021)
(defconstant $cantCreateSingleForkFile -2022)   ;  happens when file already exists 

(defconstant $invalidEditState -2023)
(defconstant $nonMatchingEditState -2024)
(defconstant $staleEditState -2025)
(defconstant $userDataItemNotFound -2026)
(defconstant $maxSizeToGrowTooSmall -2027)
(defconstant $badTrackIndex -2028)
(defconstant $trackIDNotFound -2029)
(defconstant $trackNotInMovie -2030)
(defconstant $timeNotInTrack -2031)
(defconstant $timeNotInMedia -2032)
(defconstant $badEditIndex -2033)
(defconstant $internalQuickTimeError -2034)
(defconstant $cantEnableTrack -2035)
(defconstant $invalidRect -2036)
(defconstant $invalidSampleNum -2037)
(defconstant $invalidChunkNum -2038)
(defconstant $invalidSampleDescIndex -2039)
(defconstant $invalidChunkCache -2040)
(defconstant $invalidSampleDescription -2041)
(defconstant $dataNotOpenForRead -2042)
(defconstant $dataNotOpenForWrite -2043)
(defconstant $dataAlreadyOpenForWrite -2044)
(defconstant $dataAlreadyClosed -2045)
(defconstant $endOfDataReached -2046)
(defconstant $dataNoDataRef -2047)
(defconstant $noMovieFound -2048)
(defconstant $invalidDataRefContainer -2049)
(defconstant $badDataRefIndex -2050)
(defconstant $noDefaultDataRef -2051)
(defconstant $couldNotUseAnExistingSample -2052)
(defconstant $featureUnsupported -2053)
(defconstant $noVideoTrackInMovieErr -2054)     ;  QT for Windows error 

(defconstant $noSoundTrackInMovieErr -2055)     ;  QT for Windows error 

(defconstant $soundSupportNotAvailableErr -2056);  QT for Windows error 

(defconstant $unsupportedAuxiliaryImportData -2057)
(defconstant $auxiliaryExportDataUnavailable -2058)
(defconstant $samplesAlreadyInMediaErr -2059)
(defconstant $noSourceTreeFoundErr -2060)
(defconstant $sourceNotFoundErr -2061)
(defconstant $movieTextNotFoundErr -2062)
(defconstant $missingRequiredParameterErr -2063)
(defconstant $invalidSpriteWorldPropertyErr -2064)
(defconstant $invalidSpritePropertyErr -2065)
(defconstant $gWorldsNotSameDepthAndSizeErr -2066)
(defconstant $invalidSpriteIndexErr -2067)
(defconstant $invalidImageIndexErr -2068)
(defconstant $invalidSpriteIDErr -2069)

(defconstant $internalComponentErr -2070)
(defconstant $notImplementedMusicOSErr -2071)
(defconstant $cantSendToSynthesizerOSErr -2072)
(defconstant $cantReceiveFromSynthesizerOSErr -2073)
(defconstant $illegalVoiceAllocationOSErr -2074)
(defconstant $illegalPartOSErr -2075)
(defconstant $illegalChannelOSErr -2076)
(defconstant $illegalKnobOSErr -2077)
(defconstant $illegalKnobValueOSErr -2078)
(defconstant $illegalInstrumentOSErr -2079)
(defconstant $illegalControllerOSErr -2080)
(defconstant $midiManagerAbsentOSErr -2081)
(defconstant $synthesizerNotRespondingOSErr -2082)
(defconstant $synthesizerOSErr -2083)
(defconstant $illegalNoteChannelOSErr -2084)
(defconstant $noteChannelNotAllocatedOSErr -2085)
(defconstant $tunePlayerFullOSErr -2086)
(defconstant $tuneParseOSErr -2087)
(defconstant $noExportProcAvailableErr -2089)
(defconstant $videoOutputInUseErr -2090)

(defconstant $componentDllLoadErr -2091)        ;  Windows specific errors (when component is loading)

(defconstant $componentDllEntryNotFoundErr -2092);  Windows specific errors (when component is loading)

(defconstant $qtmlDllLoadErr -2093)             ;  Windows specific errors (when qtml is loading)

(defconstant $qtmlDllEntryNotFoundErr -2094)    ;  Windows specific errors (when qtml is loading)

(defconstant $qtmlUninitialized -2095)
(defconstant $unsupportedOSErr -2096)
(defconstant $unsupportedProcessorErr -2097)    ;  component is not thread-safe

(defconstant $componentNotThreadSafeErr -2098)

(defconstant $cannotFindAtomErr -2101)
(defconstant $notLeafAtomErr -2102)
(defconstant $atomsNotOfSameTypeErr -2103)
(defconstant $atomIndexInvalidErr -2104)
(defconstant $duplicateAtomTypeAndIDErr -2105)
(defconstant $invalidAtomErr -2106)
(defconstant $invalidAtomContainerErr -2107)
(defconstant $invalidAtomTypeErr -2108)
(defconstant $cannotBeLeafAtomErr -2109)
(defconstant $pathTooLongErr -2110)
(defconstant $emptyPathErr -2111)
(defconstant $noPathMappingErr -2112)
(defconstant $pathNotVerifiedErr -2113)
(defconstant $unknownFormatErr -2114)
(defconstant $wackBadFileErr -2115)
(defconstant $wackForkNotFoundErr -2116)
(defconstant $wackBadMetaDataErr -2117)
(defconstant $qfcbNotFoundErr -2118)
(defconstant $qfcbNotCreatedErr -2119)
(defconstant $AAPNotCreatedErr -2120)
(defconstant $AAPNotFoundErr -2121)
(defconstant $ASDBadHeaderErr -2122)
(defconstant $ASDBadForkErr -2123)
(defconstant $ASDEntryNotFoundErr -2124)
(defconstant $fileOffsetTooBigErr -2125)
(defconstant $notAllowedToSaveMovieErr -2126)
(defconstant $qtNetworkAlreadyAllocatedErr -2127)
(defconstant $urlDataHHTTPProtocolErr -2129)
(defconstant $urlDataHHTTPNoNetDriverErr -2130)
(defconstant $urlDataHHTTPURLErr -2131)
(defconstant $urlDataHHTTPRedirectErr -2132)
(defconstant $urlDataHFTPProtocolErr -2133)
(defconstant $urlDataHFTPShutdownErr -2134)
(defconstant $urlDataHFTPBadUserErr -2135)
(defconstant $urlDataHFTPBadPasswordErr -2136)
(defconstant $urlDataHFTPServerErr -2137)
(defconstant $urlDataHFTPDataConnectionErr -2138)
(defconstant $urlDataHFTPNoDirectoryErr -2139)
(defconstant $urlDataHFTPQuotaErr -2140)
(defconstant $urlDataHFTPPermissionsErr -2141)
(defconstant $urlDataHFTPFilenameErr -2142)
(defconstant $urlDataHFTPNoNetDriverErr -2143)
(defconstant $urlDataHFTPBadNameListErr -2144)
(defconstant $urlDataHFTPNeedPasswordErr -2145)
(defconstant $urlDataHFTPNoPasswordErr -2146)
(defconstant $urlDataHFTPServerDisconnectedErr -2147)
(defconstant $urlDataHFTPURLErr -2148)
(defconstant $notEnoughDataErr -2149)
(defconstant $qtActionNotHandledErr -2157)
(defconstant $qtXMLParseErr -2158)
(defconstant $qtXMLApplicationErr -2159)

(defconstant $digiUnimpErr -2201)               ;  feature unimplemented 

(defconstant $qtParamErr -2202)                 ;  bad input parameter (out of range, etc) 

(defconstant $matrixErr -2203)                  ;  bad matrix, digitizer did nothing 

(defconstant $notExactMatrixErr -2204)          ;  warning of bad matrix, digitizer did its best 

(defconstant $noMoreKeyColorsErr -2205)         ;  all key indexes in use 

(defconstant $notExactSizeErr -2206)            ;  Can’t do exact size requested 

(defconstant $badDepthErr -2207)                ;  Can’t digitize into this depth 

(defconstant $noDMAErr -2208)                   ;  Can’t do DMA digitizing (i.e. can't go to requested dest 
;  Usually due to a status call being called prior to being setup first 

(defconstant $badCallOrderErr -2209)
;   Kernel Error Codes  

(defconstant $kernelIncompleteErr -2401)
(defconstant $kernelCanceledErr -2402)
(defconstant $kernelOptionsErr -2403)
(defconstant $kernelPrivilegeErr -2404)
(defconstant $kernelUnsupportedErr -2405)
(defconstant $kernelObjectExistsErr -2406)
(defconstant $kernelWritePermissionErr -2407)
(defconstant $kernelReadPermissionErr -2408)
(defconstant $kernelExecutePermissionErr -2409)
(defconstant $kernelDeletePermissionErr -2410)
(defconstant $kernelExecutionLevelErr -2411)
(defconstant $kernelAttributeErr -2412)
(defconstant $kernelAsyncSendLimitErr -2413)
(defconstant $kernelAsyncReceiveLimitErr -2414)
(defconstant $kernelTimeoutErr -2415)
(defconstant $kernelInUseErr -2416)
(defconstant $kernelTerminatedErr -2417)
(defconstant $kernelExceptionErr -2418)
(defconstant $kernelIDErr -2419)
(defconstant $kernelAlreadyFreeErr -2421)
(defconstant $kernelReturnValueErr -2422)
(defconstant $kernelUnrecoverableErr -2499)
;  Text Services Mgr error codes 

(defconstant $tsmComponentNoErr 0)              ;  component result = no error 

(defconstant $tsmUnsupScriptLanguageErr -2500)
(defconstant $tsmInputMethodNotFoundErr -2501)
(defconstant $tsmNotAnAppErr -2502)             ;  not an application error 

(defconstant $tsmAlreadyRegisteredErr -2503)    ;  want to register again error 

(defconstant $tsmNeverRegisteredErr -2504)      ;  app never registered error (not TSM aware) 

(defconstant $tsmInvalidDocIDErr -2505)         ;  invalid TSM documentation id 

(defconstant $tsmTSMDocBusyErr -2506)           ;  document is still active 

(defconstant $tsmDocNotActiveErr -2507)         ;  document is NOT active 

(defconstant $tsmNoOpenTSErr -2508)             ;  no open text service 

(defconstant $tsmCantOpenComponentErr -2509)    ;  can’t open the component 

(defconstant $tsmTextServiceNotFoundErr -2510)  ;  no text service found 

(defconstant $tsmDocumentOpenErr -2511)         ;  there are open documents 

(defconstant $tsmUseInputWindowErr -2512)       ;  not TSM aware because we are using input window 

(defconstant $tsmTSHasNoMenuErr -2513)          ;  the text service has no menu 

(defconstant $tsmTSNotOpenErr -2514)            ;  text service is not open 

(defconstant $tsmComponentAlreadyOpenErr -2515) ;  text service already opened for the document 

(defconstant $tsmInputMethodIsOldErr -2516)     ;  returned by GetDefaultInputMethod 

(defconstant $tsmScriptHasNoIMErr -2517)        ;  script has no imput method or is using old IM 

(defconstant $tsmUnsupportedTypeErr -2518)      ;  unSupported interface type error 

(defconstant $tsmUnknownErr -2519)              ;  any other errors 

(defconstant $tsmInvalidContext -2520)          ;  Invalid TSMContext specified in call 

(defconstant $tsmNoHandler -2521)               ;  No Callback Handler exists for callback 

(defconstant $tsmNoMoreTokens -2522)            ;  No more tokens are available for the source text 

(defconstant $tsmNoStem -2523)                  ;  No stem exists for the token 

(defconstant $tsmDefaultIsNotInputMethodErr -2524);  Current Input source is KCHR or uchr, not Input Method  (GetDefaultInputMethod) 

(defconstant $tsmDocPropertyNotFoundErr -2528)  ;  Requested TSM Document property not found 

(defconstant $tsmDocPropertyBufferTooSmallErr -2529);  Buffer passed in for property value is too small 

(defconstant $tsmCantChangeForcedClassStateErr -2530);  Enabled state of a TextService class has been forced and cannot be changed 

(defconstant $tsmComponentPropertyUnsupportedErr -2531);  Component property unsupported (or failed to be set) 

(defconstant $tsmComponentPropertyNotFoundErr -2532);  Component property not found 
;  Input Mode not changed 

(defconstant $tsmInputModeChangeFailedErr -2533)
;  Mixed Mode error codes 

(defconstant $mmInternalError -2526)
;  NameRegistry error codes 

(defconstant $nrLockedErr -2536)
(defconstant $nrNotEnoughMemoryErr -2537)
(defconstant $nrInvalidNodeErr -2538)
(defconstant $nrNotFoundErr -2539)
(defconstant $nrNotCreatedErr -2540)
(defconstant $nrNameErr -2541)
(defconstant $nrNotSlotDeviceErr -2542)
(defconstant $nrDataTruncatedErr -2543)
(defconstant $nrPowerErr -2544)
(defconstant $nrPowerSwitchAbortErr -2545)
(defconstant $nrTypeMismatchErr -2546)
(defconstant $nrNotModifiedErr -2547)
(defconstant $nrOverrunErr -2548)
(defconstant $nrResultCodeBase -2549)
(defconstant $nrPathNotFound -2550)             ;  a path component lookup failed 

(defconstant $nrPathBufferTooSmall -2551)       ;  buffer for path is too small 

(defconstant $nrInvalidEntryIterationOp -2552)  ;  invalid entry iteration operation 

(defconstant $nrPropertyAlreadyExists -2553)    ;  property already exists 

(defconstant $nrIterationDone -2554)            ;  iteration operation is done 

(defconstant $nrExitedIteratorScope -2555)      ;  outer scope of iterator was exited 

(defconstant $nrTransactionAborted -2556)       ;  transaction was aborted 
;  This call is not available or supported on this machine 

(defconstant $nrCallNotSupported -2557)
;  Icon Services error codes 

(defconstant $invalidIconRefErr -2580)          ;  The icon ref is not valid 

(defconstant $noSuchIconErr -2581)              ;  The requested icon could not be found 
;  The necessary icon data is not available 

(defconstant $noIconDataAvailableErr -2582)
;         
;     Dynamic AppleScript errors:
; 
;     These errors result from data-dependent conditions and are typically
;     signaled at runtime.
; 

(defconstant $errOSACantCoerce -1700)           ;  Signaled when a value can't be coerced to the desired type. 

(defconstant $errOSACantAccess -1728)           ;  Signaled when an object is not found in a container

(defconstant $errOSACantAssign -10006)          ;  Signaled when an object cannot be set in a container.

(defconstant $errOSAGeneralError -2700)         ;  Signaled by user scripts or applications when no actual error code is to be returned.

(defconstant $errOSADivideByZero -2701)         ;  Signaled when there is an attempt to divide by zero

(defconstant $errOSANumericOverflow -2702)      ;  Signaled when integer or real value is too large to be represented

(defconstant $errOSACantLaunch -2703)           ;  Signaled when application can't be launched or when it is remote and program linking is not enabled

(defconstant $errOSAAppNotHighLevelEventAware -2704);  Signaled when an application can't respond to AppleEvents

(defconstant $errOSACorruptTerminology -2705)   ;  Signaled when an application's terminology resource is not readable

(defconstant $errOSAStackOverflow -2706)        ;  Signaled when the runtime stack overflows

(defconstant $errOSAInternalTableOverflow -2707);  Signaled when a runtime internal data structure overflows

(defconstant $errOSADataBlockTooLarge -2708)    ;  Signaled when an intrinsic limitation is exceeded for the size of a value or data structure.

(defconstant $errOSACantGetTerminology -2709)
(defconstant $errOSACantCreate -2710)
;         
;     Component-specific dynamic script errors:
; 
;     The range -2720 thru -2739 is reserved for component-specific runtime errors.
;     (Note that error codes from different scripting components in this range will
;     overlap.)
; 
;         
;     Static AppleScript errors:
; 
;     These errors comprise what are commonly thought of as parse and compile-
;     time errors.  However, in a dynamic system (e.g. AppleScript) any or all
;     of these may also occur at runtime.
; 

(defconstant $errOSATypeError -1703)
(defconstant $OSAMessageNotUnderstood -1708)    ;  Signaled when a message was sent to an object that didn't handle it

(defconstant $OSAUndefinedHandler -1717)        ;  Signaled when a function to be returned doesn't exist. 

(defconstant $OSAIllegalAccess -1723)           ;  Signaled when a container can never have the requested object

(defconstant $OSAIllegalIndex -1719)            ;  Signaled when index was out of range. Specialization of errOSACantAccess

(defconstant $OSAIllegalRange -1720)            ;  Signaled when a range is screwy. Specialization of errOSACantAccess

(defconstant $OSAIllegalAssign -10003)          ;  Signaled when an object can never be set in a container

(defconstant $OSASyntaxError -2740)             ;  Signaled when a syntax error occurs. (e.g. "Syntax error" or "<this> can't go after <that>")

(defconstant $OSASyntaxTypeError -2741)         ;  Signaled when another form of syntax was expected. (e.g. "expected a <type> but found <this>")

(defconstant $OSATokenTooLong -2742)            ;  Signaled when a name or number is too long to be parsed

(defconstant $OSAMissingParameter -1701)        ;  Signaled when a parameter is missing for a function invocation

(defconstant $OSAParameterMismatch -1721)       ;  Signaled when function is called with the wrong number of parameters, or a parameter pattern cannot be matched

(defconstant $OSADuplicateParameter -2750)      ;  Signaled when a formal parameter, local variable, or instance variable is specified more than once

(defconstant $OSADuplicateProperty -2751)       ;  Signaled when a formal parameter, local variable, or instance variable is specified more than once.

(defconstant $OSADuplicateHandler -2752)        ;  Signaled when more than one handler is defined with the same name in a scope where the language doesn't allow it

(defconstant $OSAUndefinedVariable -2753)       ;  Signaled when a variable is accessed that has no value

(defconstant $OSAInconsistentDeclarations -2754);  Signaled when a variable is declared inconsistently in the same scope, such as both local and global
;  Signaled when illegal control flow occurs in an application (no catcher for throw, non-lexical loop exit, etc.)

(defconstant $OSAControlFlowError -2755)
;         
;     Component-specific AppleScript static errors:
; 
;     The range -2760 thru -2779 is reserved for component-specific parsing and
;     compile-time errors. (Note that error codes from different scripting
;     components in this range will overlap.)
; 
;         
;     Dialect-specific AppleScript errors:
; 
;     The range -2780 thru -2799 is reserved for dialect specific error codes for
;     scripting components that support dialects. (Note that error codes from
;     different scripting components in this range will overlap, as well as error
;     codes from different dialects in the same scripting component.)
; 
; *************************************************************************
;     Apple Script Error Codes
; *************************************************************************
;  Runtime errors: 

(defconstant $errASCantConsiderAndIgnore -2720)
(defconstant $errASCantCompareMoreThan32k -2721);  Parser/Compiler errors: 

(defconstant $errASTerminologyNestingTooDeep -2760)
(defconstant $errASIllegalFormalParameter -2761)
(defconstant $errASParameterNotForEvent -2762)
(defconstant $errASNoResultReturned -2763)      ;     The range -2780 thru -2799 is reserved for dialect specific error codes. (Error codes from different dialects may overlap.) 
;     English errors: 

(defconstant $errASInconsistentNames -2780)
;  The preferred spelling for Code Fragment Manager errors:

(defconstant $cfragFirstErrCode -2800)          ;  The first value in the range of CFM errors.

(defconstant $cfragContextIDErr -2800)          ;  The context ID was not valid.

(defconstant $cfragConnectionIDErr -2801)       ;  The connection ID was not valid.

(defconstant $cfragNoSymbolErr -2802)           ;  The specified symbol was not found.

(defconstant $cfragNoSectionErr -2803)          ;  The specified section was not found.

(defconstant $cfragNoLibraryErr -2804)          ;  The named library was not found.

(defconstant $cfragDupRegistrationErr -2805)    ;  The registration name was already in use.

(defconstant $cfragFragmentFormatErr -2806)     ;  A fragment's container format is unknown.

(defconstant $cfragUnresolvedErr -2807)         ;  A fragment had "hard" unresolved imports.

(defconstant $cfragNoPositionErr -2808)         ;  The registration insertion point was not found.

(defconstant $cfragNoPrivateMemErr -2809)       ;  Out of memory for internal bookkeeping.

(defconstant $cfragNoClientMemErr -2810)        ;  Out of memory for fragment mapping or section instances.

(defconstant $cfragNoIDsErr -2811)              ;  No more CFM IDs for contexts, connections, etc.

(defconstant $cfragInitOrderErr -2812)          ;  

(defconstant $cfragImportTooOldErr -2813)       ;  An import library was too old for a client.

(defconstant $cfragImportTooNewErr -2814)       ;  An import library was too new for a client.

(defconstant $cfragInitLoopErr -2815)           ;  Circularity in required initialization order.

(defconstant $cfragInitAtBootErr -2816)         ;  A boot library has an initialization function.  (System 7 only)

(defconstant $cfragLibConnErr -2817)            ;  

(defconstant $cfragCFMStartupErr -2818)         ;  Internal error during CFM initialization.

(defconstant $cfragCFMInternalErr -2819)        ;  An internal inconstistancy has been detected.

(defconstant $cfragFragmentCorruptErr -2820)    ;  A fragment's container was corrupt (known format).

(defconstant $cfragInitFunctionErr -2821)       ;  A fragment's initialization routine returned an error.

(defconstant $cfragNoApplicationErr -2822)      ;  No application member found in the cfrg resource.

(defconstant $cfragArchitectureErr -2823)       ;  A fragment has an unacceptable architecture.

(defconstant $cfragFragmentUsageErr -2824)      ;  A semantic error in usage of the fragment.

(defconstant $cfragFileSizeErr -2825)           ;  A file was too large to be mapped.

(defconstant $cfragNotClosureErr -2826)         ;  The closure ID was actually a connection ID.

(defconstant $cfragNoRegistrationErr -2827)     ;  The registration name was not found.

(defconstant $cfragContainerIDErr -2828)        ;  The fragment container ID was not valid.

(defconstant $cfragClosureIDErr -2829)          ;  The closure ID was not valid.

(defconstant $cfragAbortClosureErr -2830)       ;  Used by notification handlers to abort a closure.

(defconstant $cfragOutputLengthErr -2831)       ;  An output parameter is too small to hold the value.
;  The last value in the range of CFM errors.

(defconstant $cfragLastErrCode -2899)
;  Reserved values for internal "warnings".

(defconstant $cfragFirstReservedCode -2897)
(defconstant $cfragReservedCode_3 -2897)
(defconstant $cfragReservedCode_2 -2898)
(defconstant $cfragReservedCode_1 -2899)

; #if OLDROUTINENAMES
#|                                              ;  The old spelling for Code Fragment Manager errors, kept for compatibility:

(defconstant $fragContextNotFound -2800)
(defconstant $fragConnectionIDNotFound -2801)
(defconstant $fragSymbolNotFound -2802)
(defconstant $fragSectionNotFound -2803)
(defconstant $fragLibNotFound -2804)
(defconstant $fragDupRegLibName -2805)
(defconstant $fragFormatUnknown -2806)
(defconstant $fragHadUnresolveds -2807)
(defconstant $fragNoMem -2809)
(defconstant $fragNoAddrSpace -2810)
(defconstant $fragNoContextIDs -2811)
(defconstant $fragObjectInitSeqErr -2812)
(defconstant $fragImportTooOld -2813)
(defconstant $fragImportTooNew -2814)
(defconstant $fragInitLoop -2815)
(defconstant $fragInitRtnUsageErr -2816)
(defconstant $fragLibConnErr -2817)
(defconstant $fragMgrInitErr -2818)
(defconstant $fragConstErr -2819)
(defconstant $fragCorruptErr -2820)
(defconstant $fragUserInitProcErr -2821)
(defconstant $fragAppNotFound -2822)
(defconstant $fragArchError -2823)
(defconstant $fragInvalidFragmentUsage -2824)
(defconstant $fragLastErrCode -2899)
 |#

; #endif  /* OLDROUTINENAMES */

; Component Manager & component errors

(defconstant $invalidComponentID -3000)
(defconstant $validInstancesExist -3001)
(defconstant $componentNotCaptured -3002)
(defconstant $componentDontRegister -3003)
(defconstant $unresolvedComponentDLLErr -3004)
(defconstant $retryComponentRegistrationErr -3005)
; Translation manager & Translation components

(defconstant $invalidTranslationPathErr -3025)  ; Source type to destination type not a valid path

(defconstant $couldNotParseSourceFileErr -3026) ; Source document does not contain source type

(defconstant $noTranslationPathErr -3030)
(defconstant $badTranslationSpecErr -3031)
(defconstant $noPrefAppErr -3032)

(defconstant $buf2SmallErr -3101)
(defconstant $noMPPErr -3102)
(defconstant $ckSumErr -3103)
(defconstant $extractErr -3104)
(defconstant $readQErr -3105)
(defconstant $atpLenErr -3106)
(defconstant $atpBadRsp -3107)
(defconstant $recNotFnd -3108)
(defconstant $sktClosedErr -3109)
;  OpenTransport errors

(defconstant $kOTNoError 0)                     ;  No Error occurred                    

(defconstant $kOTOutOfMemoryErr -3211)          ;  OT ran out of memory, may be a temporary      

(defconstant $kOTNotFoundErr -3201)             ;  OT generic not found error               

(defconstant $kOTDuplicateFoundErr -3216)       ;  OT generic duplicate found error             

(defconstant $kOTBadAddressErr -3150)           ;  XTI2OSStatus(TBADADDR) A Bad address was specified          

(defconstant $kOTBadOptionErr -3151)            ;  XTI2OSStatus(TBADOPT) A Bad option was specified             

(defconstant $kOTAccessErr -3152)               ;  XTI2OSStatus(TACCES) Missing access permission           

(defconstant $kOTBadReferenceErr -3153)         ;  XTI2OSStatus(TBADF) Bad provider reference               

(defconstant $kOTNoAddressErr -3154)            ;  XTI2OSStatus(TNOADDR) No address was specified           

(defconstant $kOTOutStateErr -3155)             ;  XTI2OSStatus(TOUTSTATE) Call issued in wrong state           

(defconstant $kOTBadSequenceErr -3156)          ;  XTI2OSStatus(TBADSEQ) Sequence specified does not exist         

(defconstant $kOTSysErrorErr -3157)             ;  XTI2OSStatus(TSYSERR) A system error occurred            

(defconstant $kOTLookErr -3158)                 ;  XTI2OSStatus(TLOOK) An event occurred - call Look()         

(defconstant $kOTBadDataErr -3159)              ;  XTI2OSStatus(TBADDATA) An illegal amount of data was specified 

(defconstant $kOTBufferOverflowErr -3160)       ;  XTI2OSStatus(TBUFOVFLW) Passed buffer not big enough          

(defconstant $kOTFlowErr -3161)                 ;  XTI2OSStatus(TFLOW) Provider is flow-controlled          

(defconstant $kOTNoDataErr -3162)               ;  XTI2OSStatus(TNODATA) No data available for reading          

(defconstant $kOTNoDisconnectErr -3163)         ;  XTI2OSStatus(TNODIS) No disconnect indication available         

(defconstant $kOTNoUDErrErr -3164)              ;  XTI2OSStatus(TNOUDERR) No Unit Data Error indication available 

(defconstant $kOTBadFlagErr -3165)              ;  XTI2OSStatus(TBADFLAG) A Bad flag value was supplied          

(defconstant $kOTNoReleaseErr -3166)            ;  XTI2OSStatus(TNOREL) No orderly release indication available   

(defconstant $kOTNotSupportedErr -3167)         ;  XTI2OSStatus(TNOTSUPPORT) Command is not supported           

(defconstant $kOTStateChangeErr -3168)          ;  XTI2OSStatus(TSTATECHNG) State is changing - try again later     

(defconstant $kOTNoStructureTypeErr -3169)      ;  XTI2OSStatus(TNOSTRUCTYPE) Bad structure type requested for OTAlloc    

(defconstant $kOTBadNameErr -3170)              ;  XTI2OSStatus(TBADNAME) A bad endpoint name was supplied         

(defconstant $kOTBadQLenErr -3171)              ;  XTI2OSStatus(TBADQLEN) A Bind to an in-use addr with qlen > 0   

(defconstant $kOTAddressBusyErr -3172)          ;  XTI2OSStatus(TADDRBUSY) Address requested is already in use       

(defconstant $kOTIndOutErr -3173)               ;  XTI2OSStatus(TINDOUT) Accept failed because of pending listen  

(defconstant $kOTProviderMismatchErr -3174)     ;  XTI2OSStatus(TPROVMISMATCH) Tried to accept on incompatible endpoint   

(defconstant $kOTResQLenErr -3175)              ;  XTI2OSStatus(TRESQLEN)                            

(defconstant $kOTResAddressErr -3176)           ;  XTI2OSStatus(TRESADDR)                            

(defconstant $kOTQFullErr -3177)                ;  XTI2OSStatus(TQFULL)                          

(defconstant $kOTProtocolErr -3178)             ;  XTI2OSStatus(TPROTO) An unspecified provider error occurred       

(defconstant $kOTBadSyncErr -3179)              ;  XTI2OSStatus(TBADSYNC) A synchronous call at interrupt time       

(defconstant $kOTCanceledErr -3180)             ;  XTI2OSStatus(TCANCELED) The command was cancelled            

(defconstant $kEPERMErr -3200)                  ;  Permission denied            

(defconstant $kENOENTErr -3201)                 ;  No such file or directory       

(defconstant $kENORSRCErr -3202)                ;  No such resource               

(defconstant $kEINTRErr -3203)                  ;  Interrupted system service        

(defconstant $kEIOErr -3204)                    ;  I/O error                 

(defconstant $kENXIOErr -3205)                  ;  No such device or address       

(defconstant $kEBADFErr -3208)                  ;  Bad file number                 

(defconstant $kEAGAINErr -3210)                 ;  Try operation again later       

(defconstant $kENOMEMErr -3211)                 ;  Not enough space               

(defconstant $kEACCESErr -3212)                 ;  Permission denied            

(defconstant $kEFAULTErr -3213)                 ;  Bad address                   

(defconstant $kEBUSYErr -3215)                  ;  Device or resource busy          

(defconstant $kEEXISTErr -3216)                 ;  File exists                   

(defconstant $kENODEVErr -3218)                 ;  No such device               

(defconstant $kEINVALErr -3221)                 ;  Invalid argument               

(defconstant $kENOTTYErr -3224)                 ;  Not a character device          

(defconstant $kEPIPEErr -3231)                  ;  Broken pipe                   

(defconstant $kERANGEErr -3233)                 ;  Message size too large for STREAM  

(defconstant $kEWOULDBLOCKErr -3234)            ;  Call would block, so was aborted     

(defconstant $kEDEADLKErr -3234)                ;  or a deadlock would occur       

(defconstant $kEALREADYErr -3236)               ;                           

(defconstant $kENOTSOCKErr -3237)               ;  Socket operation on non-socket     

(defconstant $kEDESTADDRREQErr -3238)           ;  Destination address required      

(defconstant $kEMSGSIZEErr -3239)               ;  Message too long               

(defconstant $kEPROTOTYPEErr -3240)             ;  Protocol wrong type for socket     

(defconstant $kENOPROTOOPTErr -3241)            ;  Protocol not available          

(defconstant $kEPROTONOSUPPORTErr -3242)        ;  Protocol not supported          

(defconstant $kESOCKTNOSUPPORTErr -3243)        ;  Socket type not supported       

(defconstant $kEOPNOTSUPPErr -3244)             ;  Operation not supported on socket  

(defconstant $kEADDRINUSEErr -3247)             ;  Address already in use          

(defconstant $kEADDRNOTAVAILErr -3248)          ;  Can't assign requested address     

(defconstant $kENETDOWNErr -3249)               ;  Network is down                 

(defconstant $kENETUNREACHErr -3250)            ;  Network is unreachable          

(defconstant $kENETRESETErr -3251)              ;  Network dropped connection on reset    

(defconstant $kECONNABORTEDErr -3252)           ;  Software caused connection abort     

(defconstant $kECONNRESETErr -3253)             ;  Connection reset by peer          

(defconstant $kENOBUFSErr -3254)                ;  No buffer space available       

(defconstant $kEISCONNErr -3255)                ;  Socket is already connected         

(defconstant $kENOTCONNErr -3256)               ;  Socket is not connected          

(defconstant $kESHUTDOWNErr -3257)              ;  Can't send after socket shutdown     

(defconstant $kETOOMANYREFSErr -3258)           ;  Too many references: can't splice  

(defconstant $kETIMEDOUTErr -3259)              ;  Connection timed out             

(defconstant $kECONNREFUSEDErr -3260)           ;  Connection refused           

(defconstant $kEHOSTDOWNErr -3263)              ;  Host is down                

(defconstant $kEHOSTUNREACHErr -3264)           ;  No route to host               

(defconstant $kEPROTOErr -3269)                 ;  ••• fill out missing codes •••     

(defconstant $kETIMEErr -3270)                  ;                           

(defconstant $kENOSRErr -3271)                  ;                           

(defconstant $kEBADMSGErr -3272)                ;                           

(defconstant $kECANCELErr -3273)                ;                           

(defconstant $kENOSTRErr -3274)                 ;                           

(defconstant $kENODATAErr -3275)                ;                           

(defconstant $kEINPROGRESSErr -3276)            ;                           

(defconstant $kESRCHErr -3277)                  ;                           

(defconstant $kENOMSGErr -3278)                 ;                           

(defconstant $kOTClientNotInittedErr -3279)     ;                           

(defconstant $kOTPortHasDiedErr -3280)          ;                           

(defconstant $kOTPortWasEjectedErr -3281)       ;                           

(defconstant $kOTBadConfigurationErr -3282)     ;                           

(defconstant $kOTConfigurationChangedErr -3283) ;                           

(defconstant $kOTUserRequestedErr -3284)        ;                           
;                           

(defconstant $kOTPortLostConnection -3285)
;  Additional Quickdraw errors in the assigned range -3950 .. -3999

(defconstant $kQDNoPalette -3950)               ;  PaletteHandle is NULL

(defconstant $kQDNoColorHWCursorSupport -3951)  ;  CGSSystemSupportsColorHardwareCursors() returned false

(defconstant $kQDCursorAlreadyRegistered -3952) ;  can be returned from QDRegisterNamedPixMapCursor()

(defconstant $kQDCursorNotRegistered -3953)     ;  can be returned from QDSetNamedPixMapCursor()

(defconstant $kQDCorruptPICTDataErr -3954)
;  Color Picker errors

(defconstant $firstPickerError -4000)
(defconstant $invalidPickerType -4000)
(defconstant $requiredFlagsDontMatch -4001)
(defconstant $pickerResourceError -4002)
(defconstant $cantLoadPicker -4003)
(defconstant $cantCreatePickerWindow -4004)
(defconstant $cantLoadPackage -4005)
(defconstant $pickerCantLive -4006)
(defconstant $colorSyncNotInstalled -4007)
(defconstant $badProfileError -4008)
(defconstant $noHelpForItem -4009)
;  NSL error codes

(defconstant $kNSL68kContextNotSupported -4170) ;  no 68k allowed

(defconstant $kNSLSchedulerError -4171)         ;  A custom thread routine encountered an error

(defconstant $kNSLBadURLSyntax -4172)           ;  URL contains illegal characters

(defconstant $kNSLNoCarbonLib -4173)
(defconstant $kNSLUILibraryNotAvailable -4174)  ;  The NSL UI Library needs to be in the Extensions Folder

(defconstant $kNSLNotImplementedYet -4175)
(defconstant $kNSLErrNullPtrError -4176)
(defconstant $kNSLSomePluginsFailedToLoad -4177);  (one or more plugins failed to load, but at least one did load; this error isn't fatal)

(defconstant $kNSLNullNeighborhoodPtr -4178)    ;  (client passed a null neighborhood ptr)

(defconstant $kNSLNoPluginsForSearch -4179)     ;  (no plugins will respond to search request; bad protocol(s)?)

(defconstant $kNSLSearchAlreadyInProgress -4180);  (you can only have one ongoing search per clientRef)

(defconstant $kNSLNoPluginsFound -4181)         ;  (manager didn't find any valid plugins to load)

(defconstant $kNSLPluginLoadFailed -4182)       ;  (manager unable to load one of the plugins)

(defconstant $kNSLBadProtocolTypeErr -4183)     ;  (client is trying to add a null protocol type)

(defconstant $kNSLNullListPtr -4184)            ;  (client is trying to add items to a nil list)

(defconstant $kNSLBadClientInfoPtr -4185)       ;  (nil ClientAsyncInfoPtr; no reference available)

(defconstant $kNSLCannotContinueLookup -4186)   ;  (Can't continue lookup; error or bad state)

(defconstant $kNSLBufferTooSmallForData -4187)  ;  (Client buffer too small for data from plugin)

(defconstant $kNSLNoContextAvailable -4188)     ;  (ContinueLookup function ptr invalid)

(defconstant $kNSLRequestBufferAlreadyInList -4189)
(defconstant $kNSLInvalidPluginSpec -4190)
(defconstant $kNSLNoSupportForService -4191)
(defconstant $kNSLBadNetConnection -4192)
(defconstant $kNSLBadDataTypeErr -4193)
(defconstant $kNSLBadServiceTypeErr -4194)
(defconstant $kNSLBadReferenceErr -4195)
(defconstant $kNSLNoElementsInList -4196)
(defconstant $kNSLInsufficientOTVer -4197)
(defconstant $kNSLInsufficientSysVer -4198)
(defconstant $kNSLNotInitialized -4199)         ;  UNABLE TO INITIALIZE THE MANAGER!!!!! DO NOT CONTINUE!!!!

(defconstant $kNSLInitializationFailed -4200)
;  desktop printing error codes

(defconstant $kDTPHoldJobErr -4200)
(defconstant $kDTPStopQueueErr -4201)
(defconstant $kDTPTryAgainErr -4202)
(defconstant $kDTPAbortJobErr #x80)
;  ColorSync Result codes 
;  Profile Access Errors 

(defconstant $cmElementTagNotFound -4200)
(defconstant $cmIndexRangeErr -4201)            ;  Tag index out of range 

(defconstant $cmCantDeleteElement -4202)
(defconstant $cmFatalProfileErr -4203)
(defconstant $cmInvalidProfile -4204)           ;  A Profile must contain a 'cs1 ' tag to be valid 

(defconstant $cmInvalidProfileLocation -4205)   ;  Operation not supported for this profile location 

(defconstant $cmCantCopyModifiedV1Profile -4215);  Illegal to copy version 1 profiles that have been modified 
;  Profile Search Errors 

(defconstant $cmInvalidSearch -4206)            ;  Bad Search Handle 

(defconstant $cmSearchError -4207)
(defconstant $cmErrIncompatibleProfile -4208)   ;  Other ColorSync Errors 

(defconstant $cmInvalidColorSpace -4209)        ;  Profile colorspace does not match bitmap type 

(defconstant $cmInvalidSrcMap -4210)            ;  Source pix/bit map was invalid 

(defconstant $cmInvalidDstMap -4211)            ;  Destination pix/bit map was invalid 

(defconstant $cmNoGDevicesError -4212)          ;  Begin/End Matching -- no gdevices available 

(defconstant $cmInvalidProfileComment -4213)    ;  Bad Profile comment during drawpicture 

(defconstant $cmRangeOverFlow -4214)            ;  Color conversion warning that some output color values over/underflowed and were clipped 

(defconstant $cmNamedColorNotFound -4216)       ;  NamedColor not found 
;  Gammut checking not supported by this ColorWorld 

(defconstant $cmCantGamutCheckError -4217)
;  new Folder Manager error codes 

(defconstant $badFolderDescErr -4270)
(defconstant $duplicateFolderDescErr -4271)
(defconstant $noMoreFolderDescErr -4272)
(defconstant $invalidFolderTypeErr -4273)
(defconstant $duplicateRoutingErr -4274)
(defconstant $routingNotFoundErr -4275)
(defconstant $badRoutingSizeErr -4276)
;  Core Foundation errors

(defconstant $coreFoundationUnknownErr -4960)
;  ScrapMgr error codes (CarbonLib 1.0 and later)

(defconstant $internalScrapErr -4988)
(defconstant $duplicateScrapFlavorErr -4989)
(defconstant $badScrapRefErr -4990)
(defconstant $processStateIncorrectErr -4991)
(defconstant $scrapPromiseNotKeptErr -4992)
(defconstant $noScrapPromiseKeeperErr -4993)
(defconstant $nilScrapFlavorDataErr -4994)
(defconstant $scrapFlavorFlagsMismatchErr -4995)
(defconstant $scrapFlavorSizeMismatchErr -4996)
(defconstant $illegalScrapFlavorFlagsErr -4997)
(defconstant $illegalScrapFlavorTypeErr -4998)
(defconstant $illegalScrapFlavorSizeErr -4999)
(defconstant $scrapFlavorNotFoundErr -102)      ;  == noTypeErr
;  == noScrapErr

(defconstant $needClearScrapErr -100)
;   AFP Protocol Errors 

(defconstant $afpAccessDenied -5000)            ;  Insufficient access privileges for operation 

(defconstant $afpAuthContinue -5001)            ;  Further information required to complete AFPLogin call 

(defconstant $afpBadUAM -5002)                  ;  Unknown user authentication method specified 

(defconstant $afpBadVersNum -5003)              ;  Unknown AFP protocol version number specified 

(defconstant $afpBitmapErr -5004)               ;  Bitmap contained bits undefined for call 

(defconstant $afpCantMove -5005)                ;  Move destination is offspring of source, or root was specified 

(defconstant $afpDenyConflict -5006)            ;  Specified open/deny modes conflict with current open modes 

(defconstant $afpDirNotEmpty -5007)             ;  Cannot delete non-empty directory 

(defconstant $afpDiskFull -5008)                ;  Insufficient free space on volume for operation 

(defconstant $afpEofError -5009)                ;  Read beyond logical end-of-file 

(defconstant $afpFileBusy -5010)                ;  Cannot delete an open file 

(defconstant $afpFlatVol -5011)                 ;  Cannot create directory on specified volume 

(defconstant $afpItemNotFound -5012)            ;  Unknown UserName/UserID or missing comment/APPL entry 

(defconstant $afpLockErr -5013)                 ;  Some or all of requested range is locked by another user 

(defconstant $afpMiscErr -5014)                 ;  Unexpected error encountered during execution 

(defconstant $afpNoMoreLocks -5015)             ;  Maximum lock limit reached 

(defconstant $afpNoServer -5016)                ;  Server not responding 

(defconstant $afpObjectExists -5017)            ;  Specified destination file or directory already exists 

(defconstant $afpObjectNotFound -5018)          ;  Specified file or directory does not exist 

(defconstant $afpParmErr -5019)                 ;  A specified parameter was out of allowable range 

(defconstant $afpRangeNotLocked -5020)          ;  Tried to unlock range that was not locked by user 

(defconstant $afpRangeOverlap -5021)            ;  Some or all of range already locked by same user 

(defconstant $afpSessClosed -5022)              ;  Session closed

(defconstant $afpUserNotAuth -5023)             ;  No AFPLogin call has successfully been made for this session 

(defconstant $afpCallNotSupported -5024)        ;  Unsupported AFP call was made 

(defconstant $afpObjectTypeErr -5025)           ;  File/Directory specified where Directory/File expected 

(defconstant $afpTooManyFilesOpen -5026)        ;  Maximum open file count reached 

(defconstant $afpServerGoingDown -5027)         ;  Server is shutting down 

(defconstant $afpCantRename -5028)              ;  AFPRename cannot rename volume 

(defconstant $afpDirNotFound -5029)             ;  Unknown directory specified 

(defconstant $afpIconTypeError -5030)           ;  Icon size specified different from existing icon size 

(defconstant $afpVolLocked -5031)               ;  Volume is Read-Only 

(defconstant $afpObjectLocked -5032)            ;  Object is M/R/D/W inhibited

(defconstant $afpContainsSharedErr -5033)       ;  the folder being shared contains a shared folder

(defconstant $afpIDNotFound -5034)
(defconstant $afpIDExists -5035)
(defconstant $afpDiffVolErr -5036)
(defconstant $afpCatalogChanged -5037)
(defconstant $afpSameObjectErr -5038)
(defconstant $afpBadIDErr -5039)
(defconstant $afpPwdSameErr -5040)              ;  Someone tried to change their password to the same password on a mantadory password change 

(defconstant $afpPwdTooShortErr -5041)          ;  The password being set is too short: there is a minimum length that must be met or exceeded 

(defconstant $afpPwdExpiredErr -5042)           ;  The password being used is too old: this requires the user to change the password before log-in can continue 

(defconstant $afpInsideSharedErr -5043)         ;  The folder being shared is inside a shared folder OR the folder contains a shared folder and is being moved into a shared folder 
;  OR the folder contains a shared folder and is being moved into the descendent of a shared folder.

(defconstant $afpInsideTrashErr -5044)          ;  The folder being shared is inside the trash folder OR the shared folder is being moved into the trash folder 
;  OR the folder is being moved to the trash and it contains a shared folder 

(defconstant $afpPwdNeedsChangeErr -5045)       ;  The password needs to be changed

(defconstant $afpPwdPolicyErr -5046)            ;  Password does not conform to servers password policy 

(defconstant $afpAlreadyLoggedInErr -5047)      ;  User has been authenticated but is already logged in from another machine (and that's not allowed on this server) 
;  The server knows what you wanted to do, but won't let you do it just now 

(defconstant $afpCallNotAllowed -5048)
;   AppleShare Client Errors 

(defconstant $afpBadDirIDType -5060)
(defconstant $afpCantMountMoreSrvre -5061)      ;  The Maximum number of server connections has been reached 

(defconstant $afpAlreadyMounted -5062)          ;  The volume is already mounted 
;  An Attempt was made to connect to a file server running on the same machine 

(defconstant $afpSameNodeErr -5063)
; Text Engines, TSystemTextEngines, HIEditText error coded
;  NumberFormatting error codes

(defconstant $numberFormattingNotANumberErr -5200)
(defconstant $numberFormattingOverflowInDestinationErr -5201)
(defconstant $numberFormattingBadNumberFormattingObjectErr -5202)
(defconstant $numberFormattingSpuriousCharErr -5203)
(defconstant $numberFormattingLiteralMissingErr -5204)
(defconstant $numberFormattingDelimiterMissingErr -5205)
(defconstant $numberFormattingEmptyFormatErr -5206)
(defconstant $numberFormattingBadFormatErr -5207)
(defconstant $numberFormattingBadOptionsErr -5208)
(defconstant $numberFormattingBadTokenErr -5209)
(defconstant $numberFormattingUnOrderedCurrencyRangeErr -5210)
(defconstant $numberFormattingBadCurrencyPositionErr -5211)
(defconstant $numberFormattingNotADigitErr -5212);  deprecated misspelled versions:

(defconstant $numberFormattingUnOrdredCurrencyRangeErr -5210)
(defconstant $numberFortmattingNotADigitErr -5212)
;  TextParser error codes

(defconstant $textParserBadParamErr -5220)
(defconstant $textParserObjectNotFoundErr -5221)
(defconstant $textParserBadTokenValueErr -5222)
(defconstant $textParserBadParserObjectErr -5223)
(defconstant $textParserParamErr -5224)
(defconstant $textParserNoMoreTextErr -5225)
(defconstant $textParserBadTextLanguageErr -5226)
(defconstant $textParserBadTextEncodingErr -5227)
(defconstant $textParserNoSuchTokenFoundErr -5228)
(defconstant $textParserNoMoreTokensErr -5229)

(defconstant $errUnknownAttributeTag -5240)
(defconstant $errMarginWilllNotFit -5241)
(defconstant $errNotInImagingMode -5242)
(defconstant $errAlreadyInImagingMode -5243)
(defconstant $errEngineNotFound -5244)
(defconstant $errIteratorReachedEnd -5245)
(defconstant $errInvalidRange -5246)
(defconstant $errOffsetNotOnElementBounday -5247)
(defconstant $errNoHiliteText -5248)
(defconstant $errEmptyScrap -5249)
(defconstant $errReadOnlyText -5250)
(defconstant $errUnknownElement -5251)
(defconstant $errNonContiuousAttribute -5252)
(defconstant $errCannotUndo -5253)
;  HTMLRendering OSStaus codes

(defconstant $hrHTMLRenderingLibNotInstalledErr -5360)
(defconstant $hrMiscellaneousExceptionErr -5361)
(defconstant $hrUnableToResizeHandleErr -5362)
(defconstant $hrURLNotHandledErr -5363)
;  IAExtractor result codes 

(defconstant $errIANoErr 0)
(defconstant $errIAUnknownErr -5380)
(defconstant $errIAAllocationErr -5381)
(defconstant $errIAParamErr -5382)
(defconstant $errIANoMoreItems -5383)
(defconstant $errIABufferTooSmall -5384)
(defconstant $errIACanceled -5385)
(defconstant $errIAInvalidDocument -5386)
(defconstant $errIATextExtractionErr -5387)
(defconstant $errIAEndOfTextRun -5388)
;  QuickTime Streaming Errors 

(defconstant $qtsBadSelectorErr -5400)
(defconstant $qtsBadStateErr -5401)
(defconstant $qtsBadDataErr -5402)              ;  something is wrong with the data 

(defconstant $qtsUnsupportedDataTypeErr -5403)
(defconstant $qtsUnsupportedRateErr -5404)
(defconstant $qtsUnsupportedFeatureErr -5405)
(defconstant $qtsTooMuchDataErr -5406)
(defconstant $qtsUnknownValueErr -5407)
(defconstant $qtsTimeoutErr -5408)
(defconstant $qtsConnectionFailedErr -5420)
(defconstant $qtsAddressBusyErr -5421)
; Gestalt error codes

(defconstant $gestaltUnknownErr -5550)          ; value returned if Gestalt doesn't know the answer

(defconstant $gestaltUndefSelectorErr -5551)    ; undefined selector was passed to Gestalt

(defconstant $gestaltDupSelectorErr -5552)      ; tried to add an entry that already existed
; gestalt function ptr wasn't in sysheap

(defconstant $gestaltLocationErr -5553)
;  Menu Manager error codes

(defconstant $menuPropertyInvalidErr -5603)     ;  invalid property creator 

(defconstant $menuPropertyInvalid -5603)        ;  "menuPropertyInvalid" is deprecated 

(defconstant $menuPropertyNotFoundErr -5604)    ;  specified property wasn't found 

(defconstant $menuNotFoundErr -5620)            ;  specified menu or menu ID wasn't found 

(defconstant $menuUsesSystemDefErr -5621)       ;  GetMenuDefinition failed because the menu uses the system MDEF 

(defconstant $menuItemNotFoundErr -5622)        ;  specified menu item wasn't found
;  menu is invalid

(defconstant $menuInvalidErr -5623)
;  Window Manager error codes

(defconstant $errInvalidWindowPtr -5600)        ;  tried to pass a bad WindowRef argument

(defconstant $errInvalidWindowRef -5600)        ;  tried to pass a bad WindowRef argument

(defconstant $errUnsupportedWindowAttributesForClass -5601);  tried to create a window with WindowAttributes not supported by the WindowClass

(defconstant $errWindowDoesNotHaveProxy -5602)  ;  tried to do something requiring a proxy to a window which doesn’t have a proxy

(defconstant $errInvalidWindowProperty -5603)   ;  tried to access a property tag with private creator

(defconstant $errWindowPropertyNotFound -5604)  ;  tried to get a nonexistent property

(defconstant $errUnrecognizedWindowClass -5605) ;  tried to create a window with a bad WindowClass

(defconstant $errCorruptWindowDescription -5606);  tried to load a corrupt window description (size or version fields incorrect)

(defconstant $errUserWantsToDragWindow -5607)   ;  if returned from TrackWindowProxyDrag, you should call DragWindow on the window

(defconstant $errWindowsAlreadyInitialized -5608);  tried to call InitFloatingWindows twice, or called InitWindows and then floating windows

(defconstant $errFloatingWindowsNotInitialized -5609);  called HideFloatingWindows or ShowFloatingWindows without calling InitFloatingWindows

(defconstant $errWindowNotFound -5610)          ;  returned from FindWindowOfClass

(defconstant $errWindowDoesNotFitOnscreen -5611);  ConstrainWindowToScreen could not make the window fit onscreen

(defconstant $windowAttributeImmutableErr -5612);  tried to change attributes which can't be changed

(defconstant $windowAttributesConflictErr -5613);  passed some attributes that are mutually exclusive

(defconstant $windowManagerInternalErr -5614)   ;  something really weird happened inside the window manager

(defconstant $windowWrongStateErr -5615)        ;  window is not in a state that is valid for the current action

(defconstant $windowGroupInvalidErr -5616)      ;  WindowGroup is invalid

(defconstant $windowAppModalStateAlreadyExistsErr -5617);  we're already running this window modally

(defconstant $windowNoAppModalStateErr -5618)   ;  there's no app modal state for the window

(defconstant $errWindowDoesntSupportFocus -30583)
(defconstant $errWindowRegionCodeInvalid -30593)
;  Dialog Mgr error codes

(defconstant $dialogNoTimeoutErr -5640)
;  NavigationLib error codes

(defconstant $kNavWrongDialogStateErr -5694)
(defconstant $kNavWrongDialogClassErr -5695)
(defconstant $kNavInvalidSystemConfigErr -5696)
(defconstant $kNavCustomControlMessageFailedErr -5697)
(defconstant $kNavInvalidCustomControlMessageErr -5698)
(defconstant $kNavMissingKindStringErr -5699)
;  Collection Manager errors 

(defconstant $collectionItemLockedErr -5750)
(defconstant $collectionItemNotFoundErr -5751)
(defconstant $collectionIndexRangeErr -5752)
(defconstant $collectionVersionErr -5753)
;  QuickTime Streaming Server Errors 

(defconstant $kQTSSUnknownErr -6150)
;  Display Manager error codes (-6220...-6269)

(defconstant $kDMGenErr -6220)                  ; Unexpected Error
;  Mirroring-Specific Errors 

(defconstant $kDMMirroringOnAlready -6221)      ; Returned by all calls that need mirroring to be off to do their thing.

(defconstant $kDMWrongNumberOfDisplays -6222)   ; Can only handle 2 displays for now.

(defconstant $kDMMirroringBlocked -6223)        ; DMBlockMirroring() has been called.

(defconstant $kDMCantBlock -6224)               ; Mirroring is already on, can’t Block now (call DMUnMirror() first).

(defconstant $kDMMirroringNotOn -6225)          ; Returned by all calls that need mirroring to be on to do their thing.
;  Other Display Manager Errors 

(defconstant $kSysSWTooOld -6226)               ; Missing critical pieces of System Software.

(defconstant $kDMSWNotInitializedErr -6227)     ; Required software not initialized (eg windowmanager or display mgr).

(defconstant $kDMDriverNotDisplayMgrAwareErr -6228); Video Driver does not support display manager.

(defconstant $kDMDisplayNotFoundErr -6229)      ; Could not find item (will someday remove).

(defconstant $kDMNotFoundErr -6229)             ; Could not find item.

(defconstant $kDMDisplayAlreadyInstalledErr -6230); Attempt to add an already installed display.

(defconstant $kDMMainDisplayCannotMoveErr -6231); Trying to move main display (or a display mirrored to it) 

(defconstant $kDMNoDeviceTableclothErr -6231)   ; obsolete
; Did not proceed because we found an item

(defconstant $kDMFoundErr -6232)
; 
;     Language Analysis error codes
; 

(defconstant $laTooSmallBufferErr -6984)        ;  output buffer is too small to store any result 

(defconstant $laEnvironmentBusyErr -6985)       ;  specified environment is used 

(defconstant $laEnvironmentNotFoundErr -6986)   ;  can't fint the specified environment 

(defconstant $laEnvironmentExistErr -6987)      ;  same name environment is already exists 

(defconstant $laInvalidPathErr -6988)           ;  path is not correct 

(defconstant $laNoMoreMorphemeErr -6989)        ;  nothing to read

(defconstant $laFailAnalysisErr -6990)          ;  analysis failed

(defconstant $laTextOverFlowErr -6991)          ;  text is too long

(defconstant $laDictionaryNotOpenedErr -6992)   ;  the dictionary is not opened

(defconstant $laDictionaryUnknownErr -6993)     ;  can't use this dictionary with this environment

(defconstant $laDictionaryTooManyErr -6994)     ;  too many dictionaries

(defconstant $laPropertyValueErr -6995)         ;  Invalid property value

(defconstant $laPropertyUnknownErr -6996)       ;  the property is unknown to this environment

(defconstant $laPropertyIsReadOnlyErr -6997)    ;  the property is read only

(defconstant $laPropertyNotFoundErr -6998)      ;  can't find the property

(defconstant $laPropertyErr -6999)              ;  Error in properties
;  can't find the engine

(defconstant $laEngineNotFoundErr -7000)

(defconstant $kUSBNoErr 0)
(defconstant $kUSBNoTran 0)
(defconstant $kUSBNoDelay 0)
(defconstant $kUSBPending 1)
; 
;    
;    USB Hardware Errors 
;    Note pipe stalls are communication 
;    errors. The affected pipe can not 
;    be used until USBClearPipeStallByReference  
;    is used.
;    kUSBEndpointStallErr is returned in 
;    response to a stall handshake 
;    from a device. The device has to be 
;    cleared before a USBClearPipeStallByReference 
;    can be used.
; 

(defconstant $kUSBNotSent2Err -6901)            ;   Transaction not sent 

(defconstant $kUSBNotSent1Err -6902)            ;   Transaction not sent 

(defconstant $kUSBBufUnderRunErr -6903)         ;   Host hardware failure on data out, PCI busy? 

(defconstant $kUSBBufOvrRunErr -6904)           ;   Host hardware failure on data in, PCI busy? 

(defconstant $kUSBRes2Err -6905)
(defconstant $kUSBRes1Err -6906)
(defconstant $kUSBUnderRunErr -6907)            ;   Less data than buffer 

(defconstant $kUSBOverRunErr -6908)             ;   Packet too large or more data than buffer 

(defconstant $kUSBWrongPIDErr -6909)            ;   Pipe stall, Bad or wrong PID 

(defconstant $kUSBPIDCheckErr -6910)            ;   Pipe stall, PID CRC error 

(defconstant $kUSBNotRespondingErr -6911)       ;   Pipe stall, No device, device hung 

(defconstant $kUSBEndpointStallErr -6912)       ;   Device didn't understand 

(defconstant $kUSBDataToggleErr -6913)          ;   Pipe stall, Bad data toggle 

(defconstant $kUSBBitstufErr -6914)             ;   Pipe stall, bitstuffing 

(defconstant $kUSBCRCErr -6915)                 ;   Pipe stall, bad CRC 

(defconstant $kUSBLinkErr -6916)
; 
;    
;    USB Manager Errors 
; 

(defconstant $kUSBQueueFull -6948)              ;  Internal queue maxxed  

(defconstant $kUSBNotHandled -6987)             ;  Notification was not handled   (same as NotFound)

(defconstant $kUSBUnknownNotification -6949)    ;  Notification type not defined  
;  Improper driver dispatch table     

(defconstant $kUSBBadDispatchTable -6950)
; 
;    USB internal errors are in range -6960 to -6951
;    please do not use this range
;    
; 

(defconstant $kUSBInternalReserved10 -6951)
(defconstant $kUSBInternalReserved9 -6952)
(defconstant $kUSBInternalReserved8 -6953)
(defconstant $kUSBInternalReserved7 -6954)
(defconstant $kUSBInternalReserved6 -6955)
(defconstant $kUSBInternalReserved5 -6956)
(defconstant $kUSBInternalReserved4 -6957)
(defconstant $kUSBInternalReserved3 -6958)
(defconstant $kUSBInternalReserved2 -6959)      ;  reserved

(defconstant $kUSBInternalReserved1 -6960)
;  USB Services Errors 

(defconstant $kUSBPortDisabled -6969)           ;  The port you are attached to is disabled, use USBDeviceReset.

(defconstant $kUSBQueueAborted -6970)           ;  Pipe zero stall cleared.

(defconstant $kUSBTimedOut -6971)               ;  Transaction timed out. 

(defconstant $kUSBDeviceDisconnected -6972)     ;  Disconnected during suspend or reset 

(defconstant $kUSBDeviceNotSuspended -6973)     ;  device is not suspended for resume 

(defconstant $kUSBDeviceSuspended -6974)        ;  Device is suspended 

(defconstant $kUSBInvalidBuffer -6975)          ;  bad buffer, usually nil 

(defconstant $kUSBDevicePowerProblem -6976)     ;   Device has a power problem 

(defconstant $kUSBDeviceBusy -6977)             ;   Device is already being configured 

(defconstant $kUSBUnknownInterfaceErr -6978)    ;   Interface ref not recognised 

(defconstant $kUSBPipeStalledError -6979)       ;   Pipe has stalled, error needs to be cleared 

(defconstant $kUSBPipeIdleError -6980)          ;   Pipe is Idle, it will not accept transactions 

(defconstant $kUSBNoBandwidthError -6981)       ;   Not enough bandwidth available 

(defconstant $kUSBAbortedError -6982)           ;   Pipe aborted 

(defconstant $kUSBFlagsError -6983)             ;   Unused flags not zeroed 

(defconstant $kUSBCompletionError -6984)        ;   no completion routine specified 

(defconstant $kUSBPBLengthError -6985)          ;   pbLength too small 

(defconstant $kUSBPBVersionError -6986)         ;   Wrong pbVersion 

(defconstant $kUSBNotFound -6987)               ;   Not found 

(defconstant $kUSBOutOfMemoryErr -6988)         ;   Out of memory 

(defconstant $kUSBDeviceErr -6989)              ;   Device error 

(defconstant $kUSBNoDeviceErr -6990)            ;   No device

(defconstant $kUSBAlreadyOpenErr -6991)         ;   Already open 

(defconstant $kUSBTooManyTransactionsErr -6992) ;   Too many transactions 

(defconstant $kUSBUnknownRequestErr -6993)      ;   Unknown request 

(defconstant $kUSBRqErr -6994)                  ;   Request error 

(defconstant $kUSBIncorrectTypeErr -6995)       ;   Incorrect type 

(defconstant $kUSBTooManyPipesErr -6996)        ;   Too many pipes 

(defconstant $kUSBUnknownPipeErr -6997)         ;   Pipe ref not recognised 

(defconstant $kUSBUnknownDeviceErr -6998)       ;   device ref not recognised 
;  Internal error 

(defconstant $kUSBInternalErr -6999)
; 
;     DictionaryMgr error codes
; 

(defconstant $dcmParamErr -7100)                ;  bad parameter

(defconstant $dcmNotDictionaryErr -7101)        ;  not dictionary

(defconstant $dcmBadDictionaryErr -7102)        ;  invalid dictionary

(defconstant $dcmPermissionErr -7103)           ;  invalid permission

(defconstant $dcmDictionaryNotOpenErr -7104)    ;  dictionary not opened

(defconstant $dcmDictionaryBusyErr -7105)       ;  dictionary is busy

(defconstant $dcmBlockFullErr -7107)            ;  dictionary block full

(defconstant $dcmNoRecordErr -7108)             ;  no such record

(defconstant $dcmDupRecordErr -7109)            ;  same record already exist

(defconstant $dcmNecessaryFieldErr -7110)       ;  lack required/identify field

(defconstant $dcmBadFieldInfoErr -7111)         ;  incomplete information

(defconstant $dcmBadFieldTypeErr -7112)         ;  no such field type supported

(defconstant $dcmNoFieldErr -7113)              ;  no such field exist

(defconstant $dcmBadKeyErr -7115)               ;  bad key information

(defconstant $dcmTooManyKeyErr -7116)           ;  too many key field

(defconstant $dcmBadDataSizeErr -7117)          ;  too big data size

(defconstant $dcmBadFindMethodErr -7118)        ;  no such find method supported

(defconstant $dcmBadPropertyErr -7119)          ;  no such property exist

(defconstant $dcmProtectedErr -7121)            ;  need keyword to use dictionary

(defconstant $dcmNoAccessMethodErr -7122)       ;  no such AccessMethod

(defconstant $dcmBadFeatureErr -7124)           ;  invalid AccessMethod feature

(defconstant $dcmIterationCompleteErr -7126)    ;  no more item in iterator
;  data is larger than buffer size

(defconstant $dcmBufferOverflowErr -7127)
;  Apple Remote Access error codes

(defconstant $kRAInvalidParameter -7100)
(defconstant $kRAInvalidPort -7101)
(defconstant $kRAStartupFailed -7102)
(defconstant $kRAPortSetupFailed -7103)
(defconstant $kRAOutOfMemory -7104)
(defconstant $kRANotSupported -7105)
(defconstant $kRAMissingResources -7106)
(defconstant $kRAIncompatiblePrefs -7107)
(defconstant $kRANotConnected -7108)
(defconstant $kRAConnectionCanceled -7109)
(defconstant $kRAUnknownUser -7110)
(defconstant $kRAInvalidPassword -7111)
(defconstant $kRAInternalError -7112)
(defconstant $kRAInstallationDamaged -7113)
(defconstant $kRAPortBusy -7114)
(defconstant $kRAUnknownPortState -7115)
(defconstant $kRAInvalidPortState -7116)
(defconstant $kRAInvalidSerialProtocol -7117)
(defconstant $kRAUserLoginDisabled -7118)
(defconstant $kRAUserPwdChangeRequired -7119)
(defconstant $kRAUserPwdEntryRequired -7120)
(defconstant $kRAUserInteractionRequired -7121)
(defconstant $kRAInitOpenTransportFailed -7122)
(defconstant $kRARemoteAccessNotReady -7123)
(defconstant $kRATCPIPInactive -7124)           ;  TCP/IP inactive, cannot be loaded

(defconstant $kRATCPIPNotConfigured -7125)      ;  TCP/IP not configured, could be loaded

(defconstant $kRANotPrimaryInterface -7126)     ;  when IPCP is not primary TCP/IP intf.

(defconstant $kRAConfigurationDBInitErr -7127)
(defconstant $kRAPPPProtocolRejected -7128)
(defconstant $kRAPPPAuthenticationFailed -7129)
(defconstant $kRAPPPNegotiationFailed -7130)
(defconstant $kRAPPPUserDisconnected -7131)
(defconstant $kRAPPPPeerDisconnected -7132)
(defconstant $kRAPeerNotResponding -7133)
(defconstant $kRAATalkInactive -7134)
(defconstant $kRAExtAuthenticationFailed -7135)
(defconstant $kRANCPRejectedbyPeer -7136)
(defconstant $kRADuplicateIPAddr -7137)
(defconstant $kRACallBackFailed -7138)
(defconstant $kRANotEnabled -7139)
;  ATSUI Error Codes - Range 1 of 2

(defconstant $kATSUInvalidTextLayoutErr -8790)  ;     An attempt was made to use a ATSUTextLayout 
;     which hadn't been initialized or is otherwise 
;     in an invalid state. 

(defconstant $kATSUInvalidStyleErr -8791)       ;     An attempt was made to use a ATSUStyle which  
;     hadn't been properly allocated or is otherwise  
;     in an invalid state.  

(defconstant $kATSUInvalidTextRangeErr -8792)   ;     An attempt was made to extract information   
;     from or perform an operation on a ATSUTextLayout 
;     for a range of text not covered by the ATSUTextLayout.  

(defconstant $kATSUFontsMatched -8793)          ;     This is not an error code but is returned by    
;     ATSUMatchFontsToText() when changes need to    
;     be made to the fonts associated with the text.  

(defconstant $kATSUFontsNotMatched -8794)       ;     This value is returned by ATSUMatchFontsToText()    
;     when the text contains Unicode characters which    
;     cannot be represented by any installed font.  

(defconstant $kATSUNoCorrespondingFontErr -8795);     This value is retrned by font ID conversion 
;     routines ATSUFONDtoFontID() and ATSUFontIDtoFOND() 
;     to indicate that the input font ID is valid but 
;     there is no conversion possible.  For example, 
;     data-fork fonts can only be used with ATSUI not 
;     the FontManager, and so converting an ATSUIFontID 
;     for such a font will fail.   

(defconstant $kATSUInvalidFontErr -8796)        ;     Used when an attempt was made to use an invalid font ID.

(defconstant $kATSUInvalidAttributeValueErr -8797);     Used when an attempt was made to use an attribute with 
;     a bad or undefined value.  

(defconstant $kATSUInvalidAttributeSizeErr -8798);     Used when an attempt was made to use an attribute with a 
;     bad size.  

(defconstant $kATSUInvalidAttributeTagErr -8799);     Used when an attempt was made to use a tag value that
;     was not appropriate for the function call it was used.  

(defconstant $kATSUInvalidCacheErr -8800)       ;     Used when an attempt was made to read in style data 
;     from an invalid cache.  Either the format of the 
;     cached data doesn't match that used by Apple Type 
;     Services for Unicode™ Imaging, or the cached data 
;     is corrupt.  

(defconstant $kATSUNotSetErr -8801)             ;     Used when the client attempts to retrieve an attribute, 
;     font feature, or font variation from a style when it 
;     hadn't been set.  In such a case, the default value will
;     be returned for the attribute's value.

(defconstant $kATSUNoStyleRunsAssignedErr -8802);     Used when an attempt was made to measure, highlight or draw
;     a ATSUTextLayout object that has no styleRuns associated with it.

(defconstant $kATSUQuickDrawTextErr -8803)      ;     Used when QuickDraw Text encounters an error rendering or measuring
;     a line of ATSUI text.

(defconstant $kATSULowLevelErr -8804)           ;     Used when an error was encountered within the low level ATS 
;     mechanism performing an operation requested by ATSUI.

(defconstant $kATSUNoFontCmapAvailableErr -8805);     Used when no CMAP table can be accessed or synthesized for the 
;     font passed into a SetAttributes Font call.

(defconstant $kATSUNoFontScalerAvailableErr -8806);     Used when no font scaler is available for the font passed
;     into a SetAttributes Font call.

(defconstant $kATSUCoordinateOverflowErr -8807) ;     Used to indicate the coordinates provided to an ATSUI routine caused
;     a coordinate overflow (i.e. > 32K).

(defconstant $kATSULineBreakInWord -8808)       ;     This is not an error code but is returned by ATSUBreakLine to 
;     indicate that the returned offset is within a word since there was
;     only less than one word that could fit the requested width.
;     An ATSUI object is being used by another thread 

(defconstant $kATSUBusyObjectErr -8809)
; 
;    kATSUInvalidFontFallbacksErr, which had formerly occupied -8810 has been relocated to error code -8900. See
;    below in this range for additional error codes.
; 
;  Error & status codes for general text and text encoding conversion
;  general text errors

(defconstant $kTextUnsupportedEncodingErr -8738);  specified encoding not supported for this operation

(defconstant $kTextMalformedInputErr -8739)     ;  in DBCS, for example, high byte followed by invalid low byte

(defconstant $kTextUndefinedElementErr -8740)   ;  text conversion errors

(defconstant $kTECMissingTableErr -8745)
(defconstant $kTECTableChecksumErr -8746)
(defconstant $kTECTableFormatErr -8747)
(defconstant $kTECCorruptConverterErr -8748)    ;  invalid converter object reference

(defconstant $kTECNoConversionPathErr -8749)
(defconstant $kTECBufferBelowMinimumSizeErr -8750);  output buffer too small to allow processing of first input text element

(defconstant $kTECArrayFullErr -8751)           ;  supplied name buffer or TextRun, TextEncoding, or UnicodeMapping array is too small

(defconstant $kTECBadTextRunErr -8752)
(defconstant $kTECPartialCharErr -8753)         ;  input buffer ends in the middle of a multibyte character, conversion stopped

(defconstant $kTECUnmappableElementErr -8754)
(defconstant $kTECIncompleteElementErr -8755)   ;  text element may be incomplete or is too long for internal buffers

(defconstant $kTECDirectionErr -8756)           ;  direction stack overflow, etc.

(defconstant $kTECGlobalsUnavailableErr -8770)  ;  globals have already been deallocated (premature TERM)

(defconstant $kTECItemUnavailableErr -8771)     ;  item (e.g. name) not available for specified region (& encoding if relevant)
;  text conversion status codes

(defconstant $kTECUsedFallbacksStatus -8783)
(defconstant $kTECNeedFlushStatus -8784)
(defconstant $kTECOutputBufferFullStatus -8785) ;  output buffer has no room for conversion of next input text element (partial conversion)
;  deprecated error & status codes for low-level converter

(defconstant $unicodeChecksumErr -8769)
(defconstant $unicodeNoTableErr -8768)
(defconstant $unicodeVariantErr -8767)
(defconstant $unicodeFallbacksErr -8766)
(defconstant $unicodePartConvertErr -8765)
(defconstant $unicodeBufErr -8764)
(defconstant $unicodeCharErr -8763)
(defconstant $unicodeElementErr -8762)
(defconstant $unicodeNotFoundErr -8761)
(defconstant $unicodeTableFormatErr -8760)
(defconstant $unicodeDirectionErr -8759)
(defconstant $unicodeContextualErr -8758)
(defconstant $unicodeTextEncodingDataErr -8757)
;  UTCUtils Status Codes 

(defconstant $kUTCUnderflowErr -8850)
(defconstant $kUTCOverflowErr -8851)
(defconstant $kIllegalClockValueErr -8852)
;  ATSUI Error Codes - Range 2 of 2

(defconstant $kATSUInvalidFontFallbacksErr -8900);     An attempt was made to use a ATSUFontFallbacks which hadn't 
;     been initialized or is otherwise in an invalid state. 

(defconstant $kATSUUnsupportedStreamFormatErr -8901);     An attempt was made to use a ATSUFlattenedDataStreamFormat
;     which is invalid is not compatible with this version of ATSUI.

(defconstant $kATSUBadStreamErr -8902)          ;     An attempt was made to use a stream which is incorrectly
;     structured, contains bad or out of range values or is
;     missing required information.

(defconstant $kATSUOutputBufferTooSmallErr -8903);     An attempt was made to use an output buffer which was too small
;     for the requested operation.

(defconstant $kATSUInvalidCallInsideCallbackErr -8904);     A call was made within the context of a callback that could
;     potetially cause an infinite recursion

(defconstant $kATSUNoFontNameErr -8905)         ;     This error is returned when either ATSUFindFontName() or ATSUGetIndFontName() 
;     function cannot find a corresponding font name given the input parameters
;     The last ATSUI error code.

(defconstant $kATSULastErr -8959)
;  QuickTime errors (Image Compression Manager) 

(defconstant $codecErr -8960)
(defconstant $noCodecErr -8961)
(defconstant $codecUnimpErr -8962)
(defconstant $codecSizeErr -8963)
(defconstant $codecScreenBufErr -8964)
(defconstant $codecImageBufErr -8965)
(defconstant $codecSpoolErr -8966)
(defconstant $codecAbortErr -8967)
(defconstant $codecWouldOffscreenErr -8968)
(defconstant $codecBadDataErr -8969)
(defconstant $codecDataVersErr -8970)
(defconstant $codecExtensionNotFoundErr -8971)
(defconstant $scTypeNotFoundErr -8971)
(defconstant $codecConditionErr -8972)
(defconstant $codecOpenErr -8973)
(defconstant $codecCantWhenErr -8974)
(defconstant $codecCantQueueErr -8975)
(defconstant $codecNothingToBlitErr -8976)
(defconstant $codecNoMemoryPleaseWaitErr -8977)
(defconstant $codecDisabledErr -8978)           ;  codec disabled itself -- pass codecFlagReenable to reset

(defconstant $codecNeedToFlushChainErr -8979)
(defconstant $lockPortBitsBadSurfaceErr -8980)
(defconstant $lockPortBitsWindowMovedErr -8981)
(defconstant $lockPortBitsWindowResizedErr -8982)
(defconstant $lockPortBitsWindowClippedErr -8983)
(defconstant $lockPortBitsBadPortErr -8984)
(defconstant $lockPortBitsSurfaceLostErr -8985)
(defconstant $codecParameterDialogConfirm -8986)
(defconstant $codecNeedAccessKeyErr -8987)      ;  codec needs password in order to decompress

(defconstant $codecOffscreenFailedErr -8988)
(defconstant $codecDroppedFrameErr -8989)       ;  returned from ImageCodecDrawBand 

(defconstant $directXObjectAlreadyExists -8990)
(defconstant $lockPortBitsWrongGDeviceErr -8991)
(defconstant $codecOffscreenFailedPleaseRetryErr -8992)
(defconstant $badCodecCharacterizationErr -8993)
(defconstant $noThumbnailFoundErr -8994)
;  PCCard error codes 

(defconstant $kBadAdapterErr -9050)             ;  invalid adapter number

(defconstant $kBadAttributeErr -9051)           ;  specified attributes field value is invalid

(defconstant $kBadBaseErr -9052)                ;  specified base system memory address is invalid

(defconstant $kBadEDCErr -9053)                 ;  specified EDC generator specified is invalid

(defconstant $kBadIRQErr -9054)                 ;  specified IRQ level is invalid

(defconstant $kBadOffsetErr -9055)              ;  specified PC card memory array offset is invalid

(defconstant $kBadPageErr -9056)                ;  specified page is invalid

(defconstant $kBadSizeErr -9057)                ;  specified size is invalid

(defconstant $kBadSocketErr -9058)              ;  specified logical or physical socket number is invalid

(defconstant $kBadTypeErr -9059)                ;  specified window or interface type is invalid

(defconstant $kBadVccErr -9060)                 ;  specified Vcc power level index is invalid

(defconstant $kBadVppErr -9061)                 ;  specified Vpp1 or Vpp2 power level index is invalid

(defconstant $kBadWindowErr -9062)              ;  specified window is invalid

(defconstant $kBadArgLengthErr -9063)           ;  ArgLength argument is invalid

(defconstant $kBadArgsErr -9064)                ;  values in argument packet are invalid

(defconstant $kBadHandleErr -9065)              ;  clientHandle is invalid

(defconstant $kBadCISErr -9066)                 ;  CIS on card is invalid

(defconstant $kBadSpeedErr -9067)               ;  specified speed is unavailable

(defconstant $kReadFailureErr -9068)            ;  unable to complete read request

(defconstant $kWriteFailureErr -9069)           ;  unable to complete write request

(defconstant $kGeneralFailureErr -9070)         ;  an undefined error has occurred

(defconstant $kNoCardErr -9071)                 ;  no PC card in the socket

(defconstant $kUnsupportedFunctionErr -9072)    ;  function is not supported by this implementation

(defconstant $kUnsupportedModeErr -9073)        ;  mode is not supported

(defconstant $kBusyErr -9074)                   ;  unable to process request at this time - try later

(defconstant $kWriteProtectedErr -9075)         ;  media is write-protected

(defconstant $kConfigurationLockedErr -9076)    ;  a configuration has already been locked

(defconstant $kInUseErr -9077)                  ;  requested resource is being used by a client

(defconstant $kNoMoreItemsErr -9078)            ;  there are no more of the requested item

(defconstant $kOutOfResourceErr -9079)          ;  Card Services has exhausted the resource

(defconstant $kNoCardSevicesSocketsErr -9080)
(defconstant $kInvalidRegEntryErr -9081)
(defconstant $kBadLinkErr -9082)
(defconstant $kBadDeviceErr -9083)
(defconstant $k16BitCardErr -9084)
(defconstant $kCardBusCardErr -9085)
(defconstant $kPassCallToChainErr -9086)
(defconstant $kCantConfigureCardErr -9087)
(defconstant $kPostCardEventErr -9088)          ;  _PCCSLPostCardEvent failed and dropped an event 

(defconstant $kInvalidDeviceNumber -9089)
(defconstant $kUnsupportedVsErr -9090)          ;  Unsupported Voltage Sense 

(defconstant $kInvalidCSClientErr -9091)        ;  Card Services ClientID is not registered 

(defconstant $kBadTupleDataErr -9092)           ;  Data in tuple is invalid 

(defconstant $kBadCustomIFIDErr -9093)          ;  Custom interface ID is invalid 

(defconstant $kNoIOWindowRequestedErr -9094)    ;  Request I/O window before calling configuration 

(defconstant $kNoMoreTimerClientsErr -9095)     ;  All timer callbacks are in use 

(defconstant $kNoMoreInterruptSlotsErr -9096)   ;  All internal Interrupt slots are in use 

(defconstant $kNoClientTableErr -9097)          ;  The client table has not be initialized yet 

(defconstant $kUnsupportedCardErr -9098)        ;  Card not supported by generic enabler

(defconstant $kNoCardEnablersFoundErr -9099)    ;  No Enablers were found

(defconstant $kNoEnablerForCardErr -9100)       ;  No Enablers were found that can support the card

(defconstant $kNoCompatibleNameErr -9101)       ;  There is no compatible driver name for this device

(defconstant $kClientRequestDenied -9102)       ;  CS Clients should return this code inorder to 
;    deny a request-type CS Event                

(defconstant $kNotReadyErr -9103)               ;  PC Card failed to go ready 

(defconstant $kTooManyIOWindowsErr -9104)       ;  device requested more than one I/O window 

(defconstant $kAlreadySavedStateErr -9105)      ;  The state has been saved on previous call 

(defconstant $kAttemptDupCardEntryErr -9106)    ;  The Enabler was asked to create a duplicate card entry 

(defconstant $kCardPowerOffErr -9107)           ;  Power to the card has been turned off 

(defconstant $kNotZVCapableErr -9108)           ;  This socket does not support Zoomed Video 
;  No valid CIS exists for this CardBus card 

(defconstant $kNoCardBusCISErr -9109)

(defconstant $noDeviceForChannel -9400)
(defconstant $grabTimeComplete -9401)
(defconstant $cantDoThatInCurrentMode -9402)
(defconstant $notEnoughMemoryToGrab -9403)
(defconstant $notEnoughDiskSpaceToGrab -9404)
(defconstant $couldntGetRequiredComponent -9405)
(defconstant $badSGChannel -9406)
(defconstant $seqGrabInfoNotAvailable -9407)
(defconstant $deviceCantMeetRequest -9408)
(defconstant $badControllerHeight -9994)
(defconstant $editingNotAllowed -9995)
(defconstant $controllerBoundsNotExact -9996)
(defconstant $cannotSetWidthOfAttachedController -9997)
(defconstant $controllerHasFixedHeight -9998)
(defconstant $cannotMoveAttachedController -9999)
;  AERegistry Errors 

(defconstant $errAEBadKeyForm -10002)
(defconstant $errAECantHandleClass -10010)
(defconstant $errAECantSupplyType -10009)
(defconstant $errAECantUndo -10015)
(defconstant $errAEEventFailed -10000)
(defconstant $errAEIndexTooLarge -10007)
(defconstant $errAEInTransaction -10011)
(defconstant $errAELocalOnly -10016)
(defconstant $errAENoSuchTransaction -10012)
(defconstant $errAENotAnElement -10008)
(defconstant $errAENotASingleObject -10014)
(defconstant $errAENotModifiable -10003)
(defconstant $errAENoUserSelection -10013)
(defconstant $errAEPrivilegeError -10004)
(defconstant $errAEReadDenied -10005)
(defconstant $errAETypeError -10001)
(defconstant $errAEWriteDenied -10006)
(defconstant $errAENotAnEnumMember -10023)      ;  enumerated value in SetData is not allowed for this property 

(defconstant $errAECantPutThatThere -10024)     ;  in make new, duplicate, etc. class can't be an element of container 
;  illegal combination of properties settings for Set Data, make new, or duplicate 

(defconstant $errAEPropertiesClash -10025)
;  TELErr 

(defconstant $telGenericError -1)
(defconstant $telNoErr 0)
(defconstant $telNoTools 8)                     ;  no telephone tools found in extension folder 

(defconstant $telBadTermErr -10001)             ;  invalid TELHandle or handle not found

(defconstant $telBadDNErr -10002)               ;  TELDNHandle not found or invalid 

(defconstant $telBadCAErr -10003)               ;  TELCAHandle not found or invalid 

(defconstant $telBadHandErr -10004)             ;  bad handle specified 

(defconstant $telBadProcErr -10005)             ;  bad msgProc specified 

(defconstant $telCAUnavail -10006)              ;  a CA is not available 

(defconstant $telNoMemErr -10007)               ;  no memory to allocate handle 

(defconstant $telNoOpenErr -10008)              ;  unable to open terminal 

(defconstant $telBadHTypeErr -10010)            ;  bad hook type specified 

(defconstant $telHTypeNotSupp -10011)           ;  hook type not supported by this tool 

(defconstant $telBadLevelErr -10012)            ;  bad volume level setting 

(defconstant $telBadVTypeErr -10013)            ;  bad volume type error 

(defconstant $telVTypeNotSupp -10014)           ;  volume type not supported by this tool

(defconstant $telBadAPattErr -10015)            ;  bad alerting pattern specified 

(defconstant $telAPattNotSupp -10016)           ;  alerting pattern not supported by tool

(defconstant $telBadIndex -10017)               ;  bad index specified 

(defconstant $telIndexNotSupp -10018)           ;  index not supported by this tool 

(defconstant $telBadStateErr -10019)            ;  bad device state specified 

(defconstant $telStateNotSupp -10020)           ;  device state not supported by tool 

(defconstant $telBadIntExt -10021)              ;  bad internal external error 

(defconstant $telIntExtNotSupp -10022)          ;  internal external type not supported by this tool 

(defconstant $telBadDNDType -10023)             ;  bad DND type specified 

(defconstant $telDNDTypeNotSupp -10024)         ;  DND type is not supported by this tool 

(defconstant $telFeatNotSub -10030)             ;  feature not subscribed 

(defconstant $telFeatNotAvail -10031)           ;  feature subscribed but not available 

(defconstant $telFeatActive -10032)             ;  feature already active 

(defconstant $telFeatNotSupp -10033)            ;  feature program call not supported by this tool 

(defconstant $telConfLimitErr -10040)           ;  limit specified is too high for this configuration 

(defconstant $telConfNoLimit -10041)            ;  no limit was specified but required

(defconstant $telConfErr -10042)                ;  conference was not prepared 

(defconstant $telConfRej -10043)                ;  conference request was rejected 

(defconstant $telTransferErr -10044)            ;  transfer not prepared 

(defconstant $telTransferRej -10045)            ;  transfer request rejected 

(defconstant $telCBErr -10046)                  ;  call back feature not set previously 

(defconstant $telConfLimitExceeded -10047)      ;  attempt to exceed switch conference limits 

(defconstant $telBadDNType -10050)              ;  DN type invalid 

(defconstant $telBadPageID -10051)              ;  bad page ID specified

(defconstant $telBadIntercomID -10052)          ;  bad intercom ID specified 

(defconstant $telBadFeatureID -10053)           ;  bad feature ID specified 

(defconstant $telBadFwdType -10054)             ;  bad fwdType specified 

(defconstant $telBadPickupGroupID -10055)       ;  bad pickup group ID specified 

(defconstant $telBadParkID -10056)              ;  bad park id specified 

(defconstant $telBadSelect -10057)              ;  unable to select or deselect DN 

(defconstant $telBadBearerType -10058)          ;  bad bearerType specified 

(defconstant $telBadRate -10059)                ;  bad rate specified 

(defconstant $telDNTypeNotSupp -10060)          ;  DN type not supported by tool 

(defconstant $telFwdTypeNotSupp -10061)         ;  forward type not supported by tool 

(defconstant $telBadDisplayMode -10062)         ;  bad display mode specified 

(defconstant $telDisplayModeNotSupp -10063)     ;  display mode not supported by tool 

(defconstant $telNoCallbackRef -10064)          ;  no call back reference was specified, but is required 

(defconstant $telAlreadyOpen -10070)            ;  terminal already open 

(defconstant $telStillNeeded -10071)            ;  terminal driver still needed by someone else 

(defconstant $telTermNotOpen -10072)            ;  terminal not opened via TELOpenTerm 

(defconstant $telCANotAcceptable -10080)        ;  CA not "acceptable" 

(defconstant $telCANotRejectable -10081)        ;  CA not "rejectable" 

(defconstant $telCANotDeflectable -10082)       ;  CA not "deflectable" 

(defconstant $telPBErr -10090)                  ;  parameter block error, bad format 

(defconstant $telBadFunction -10091)            ;  bad msgCode specified 
;     telNoTools        = -10101,        unable to find any telephone tools 

(defconstant $telNoSuchTool -10102)             ;  unable to find tool with name specified 

(defconstant $telUnknownErr -10103)             ;  unable to set config 

(defconstant $telNoCommFolder -10106)           ;  Communications/Extensions ƒ not found 

(defconstant $telInitFailed -10107)             ;  initialization failed 

(defconstant $telBadCodeResource -10108)        ;  code resource not found 

(defconstant $telDeviceNotFound -10109)         ;  device not found 

(defconstant $telBadProcID -10110)              ;  invalid procID 

(defconstant $telValidateFailed -10111)         ;  telValidate failed 

(defconstant $telAutoAnsNotOn -10112)           ;  autoAnswer in not turned on 

(defconstant $telDetAlreadyOn -10113)           ;  detection is already turned on 

(defconstant $telBadSWErr -10114)               ;  Software not installed properly 

(defconstant $telBadSampleRate -10115)          ;  incompatible sample rate 
;  not enough real-time for allocation 

(defconstant $telNotEnoughdspBW -10116)
;  no task with that task id exists 

(defconstant $errTaskNotFound -10780)
;  Video driver Errorrs -10930 to -10959 
;  Defined in video.h. 
; Power Manager Errors

(defconstant $pmBusyErr -13000)                 ; Power Mgr never ready to start handshake

(defconstant $pmReplyTOErr -13001)              ; Timed out waiting for reply

(defconstant $pmSendStartErr -13002)            ; during send, pmgr did not start hs

(defconstant $pmSendEndErr -13003)              ; during send, pmgr did not finish hs

(defconstant $pmRecvStartErr -13004)            ; during receive, pmgr did not start hs
; during receive, pmgr did not finish hs configured for this connection

(defconstant $pmRecvEndErr -13005)
; Power Manager 2.0 Errors

(defconstant $kPowerHandlerExistsForDeviceErr -13006)
(defconstant $kPowerHandlerNotFoundForDeviceErr -13007)
(defconstant $kPowerHandlerNotFoundForProcErr -13008)
(defconstant $kPowerMgtMessageNotHandled -13009)
(defconstant $kPowerMgtRequestDenied -13010)
(defconstant $kCantReportProcessorTemperatureErr -13013)
(defconstant $kProcessorTempRoutineRequiresMPLib2 -13014)
(defconstant $kNoSuchPowerSource -13020)
(defconstant $kBridgeSoftwareRunningCantSleep -13038)
;  Debugging library errors 

(defconstant $debuggingExecutionContextErr -13880);  routine cannot be called at this time 

(defconstant $debuggingDuplicateSignatureErr -13881);  componentSignature already registered 

(defconstant $debuggingDuplicateOptionErr -13882);  optionSelectorNum already registered 

(defconstant $debuggingInvalidSignatureErr -13883);  componentSignature not registered 

(defconstant $debuggingInvalidOptionErr -13884) ;  optionSelectorNum is not registered 

(defconstant $debuggingInvalidNameErr -13885)   ;  componentName or optionName is invalid (NULL) 

(defconstant $debuggingNoCallbackErr -13886)    ;  debugging component has no callback 
;  debugging component or option not found at this index 

(defconstant $debuggingNoMatchErr -13887)
;  HID device driver error codes 

(defconstant $kHIDVersionIncompatibleErr -13909);  The device is still initializing, try again later

(defconstant $kHIDDeviceNotReady -13910)
;  HID error codes 

(defconstant $kHIDSuccess 0)
(defconstant $kHIDInvalidRangePageErr -13923)
(defconstant $kHIDReportIDZeroErr -13924)
(defconstant $kHIDReportCountZeroErr -13925)
(defconstant $kHIDReportSizeZeroErr -13926)
(defconstant $kHIDUnmatchedDesignatorRangeErr -13927)
(defconstant $kHIDUnmatchedStringRangeErr -13928)
(defconstant $kHIDInvertedUsageRangeErr -13929)
(defconstant $kHIDUnmatchedUsageRangeErr -13930)
(defconstant $kHIDInvertedPhysicalRangeErr -13931)
(defconstant $kHIDInvertedLogicalRangeErr -13932)
(defconstant $kHIDBadLogicalMaximumErr -13933)
(defconstant $kHIDBadLogicalMinimumErr -13934)
(defconstant $kHIDUsagePageZeroErr -13935)
(defconstant $kHIDEndOfDescriptorErr -13936)
(defconstant $kHIDNotEnoughMemoryErr -13937)
(defconstant $kHIDBadParameterErr -13938)
(defconstant $kHIDNullPointerErr -13939)
(defconstant $kHIDInvalidReportLengthErr -13940)
(defconstant $kHIDInvalidReportTypeErr -13941)
(defconstant $kHIDBadLogPhysValuesErr -13942)
(defconstant $kHIDIncompatibleReportErr -13943)
(defconstant $kHIDInvalidPreparsedDataErr -13944)
(defconstant $kHIDNotValueArrayErr -13945)
(defconstant $kHIDUsageNotFoundErr -13946)
(defconstant $kHIDValueOutOfRangeErr -13947)
(defconstant $kHIDBufferTooSmallErr -13948)
(defconstant $kHIDNullStateErr -13949)
(defconstant $kHIDBaseError -13950)
;  the OT modem module may return the following error codes:

(defconstant $kModemOutOfMemory -14000)
(defconstant $kModemPreferencesMissing -14001)
(defconstant $kModemScriptMissing -14002)
;  Multilingual Text Engine (MLTE) error codes 

(defconstant $kTXNEndIterationErr -22000)       ;  Function was not able to iterate through the data contained by a text object

(defconstant $kTXNCannotAddFrameErr -22001)     ;  Multiple frames are not currently supported in MLTE

(defconstant $kTXNInvalidFrameIDErr -22002)     ;  The frame ID is invalid

(defconstant $kTXNIllegalToCrossDataBoundariesErr -22003);  Offsets specify a range that crosses a data type boundary

(defconstant $kTXNUserCanceledOperationErr -22004);  A user canceled an operation before your application completed processing it

(defconstant $kTXNBadDefaultFileTypeWarning -22005);  The text file is not in the format you specified

(defconstant $kTXNCannotSetAutoIndentErr -22006);  Auto indentation is not available when word wrapping is enabled

(defconstant $kTXNRunIndexOutofBoundsErr -22007);  An index you supplied to a function is out of bounds

(defconstant $kTXNNoMatchErr -22008)            ;  Returned by TXNFind when a match is not found

(defconstant $kTXNAttributeTagInvalidForRunErr -22009);  Tag for a specific run is not valid (the tag's dataValue is set to this)

(defconstant $kTXNSomeOrAllTagsInvalidForRunErr -22010);  At least one of the tags given is invalid

(defconstant $kTXNInvalidRunIndex -22011)       ;  Index is out of range for that run

(defconstant $kTXNAlreadyInitializedErr -22012) ;  You already called the TXNInitTextension function

(defconstant $kTXNCannotTurnTSMOffWhenUsingUnicodeErr -22013);  Your application tried to turn off the Text Services Manager when using Unicode

(defconstant $kTXNCopyNotAllowedInEchoModeErr -22014);  Your application tried to copy text that was in echo mode

(defconstant $kTXNDataTypeNotAllowedErr -22015) ;  Your application specified a data type that MLTE does not allow

(defconstant $kTXNATSUIIsNotInstalledErr -22016);  Indicates that ATSUI is not installed on the system

(defconstant $kTXNOutsideOfLineErr -22017)      ;  Indicates a value that is beyond the length of the line
;  Indicates a value that is outside of the text object's frame

(defconstant $kTXNOutsideOfFrameErr -22018)
; Possible errors from the PrinterStatus bottleneck

(defconstant $printerStatusOpCodeNotSupportedErr -25280)
;  Keychain Manager error codes 

(defconstant $errKCNotAvailable -25291)
(defconstant $errKCReadOnly -25292)
(defconstant $errKCAuthFailed -25293)
(defconstant $errKCNoSuchKeychain -25294)
(defconstant $errKCInvalidKeychain -25295)
(defconstant $errKCDuplicateKeychain -25296)
(defconstant $errKCDuplicateCallback -25297)
(defconstant $errKCInvalidCallback -25298)
(defconstant $errKCDuplicateItem -25299)
(defconstant $errKCItemNotFound -25300)
(defconstant $errKCBufferTooSmall -25301)
(defconstant $errKCDataTooLarge -25302)
(defconstant $errKCNoSuchAttr -25303)
(defconstant $errKCInvalidItemRef -25304)
(defconstant $errKCInvalidSearchRef -25305)
(defconstant $errKCNoSuchClass -25306)
(defconstant $errKCNoDefaultKeychain -25307)
(defconstant $errKCInteractionNotAllowed -25308)
(defconstant $errKCReadOnlyAttr -25309)
(defconstant $errKCWrongKCVersion -25310)
(defconstant $errKCKeySizeNotAllowed -25311)
(defconstant $errKCNoStorageModule -25312)
(defconstant $errKCNoCertificateModule -25313)
(defconstant $errKCNoPolicyModule -25314)
(defconstant $errKCInteractionRequired -25315)
(defconstant $errKCDataNotAvailable -25316)
(defconstant $errKCDataNotModifiable -25317)
(defconstant $errKCCreateChainFailed -25318)
;  UnicodeUtilities error & status codes

(defconstant $kUCOutputBufferTooSmall -25340)   ;  Output buffer too small for Unicode string result
;  Unicode text break error

(defconstant $kUCTextBreakLocatorMissingType -25341)

(defconstant $kUCTSNoKeysAddedToObjectErr -25342)
(defconstant $kUCTSSearchListErr -25343)

(defconstant $kUCTokenizerIterationFinished -25344)
(defconstant $kUCTokenizerUnknownLang -25345)
(defconstant $kUCTokenNotFound -25346)
;  Multiprocessing API error codes

(defconstant $kMPIterationEndErr -29275)
(defconstant $kMPPrivilegedErr -29276)
(defconstant $kMPProcessCreatedErr -29288)
(defconstant $kMPProcessTerminatedErr -29289)
(defconstant $kMPTaskCreatedErr -29290)
(defconstant $kMPTaskBlockedErr -29291)
(defconstant $kMPTaskStoppedErr -29292)         ;  A convention used with MPThrowException.

(defconstant $kMPBlueBlockingErr -29293)
(defconstant $kMPDeletedErr -29295)
(defconstant $kMPTimeoutErr -29296)
(defconstant $kMPTaskAbortedErr -29297)
(defconstant $kMPInsufficientResourcesErr -29298)
(defconstant $kMPInvalidIDErr -29299)

(defconstant $kMPNanokernelNeedsMemoryErr -29294)
;  StringCompare error codes (in TextUtils range)

(defconstant $kCollateAttributesNotFoundErr -29500)
(defconstant $kCollateInvalidOptions -29501)
(defconstant $kCollateMissingUnicodeTableErr -29502)
(defconstant $kCollateUnicodeConvertFailedErr -29503)
(defconstant $kCollatePatternNotFoundErr -29504)
(defconstant $kCollateInvalidChar -29505)
(defconstant $kCollateBufferTooSmall -29506)
(defconstant $kCollateInvalidCollationRef -29507)
;  FontSync OSStatus Codes 

(defconstant $kFNSInvalidReferenceErr -29580)   ;  ref. was NULL or otherwise bad 

(defconstant $kFNSBadReferenceVersionErr -29581);  ref. version is out of known range 

(defconstant $kFNSInvalidProfileErr -29582)     ;  profile is NULL or otherwise bad 

(defconstant $kFNSBadProfileVersionErr -29583)  ;  profile version is out of known range 

(defconstant $kFNSDuplicateReferenceErr -29584) ;  the ref. being added is already in the profile 

(defconstant $kFNSMismatchErr -29585)           ;  reference didn't match or wasn't found in profile 

(defconstant $kFNSInsufficientDataErr -29586)   ;  insufficient data for the operation 

(defconstant $kFNSBadFlattenedSizeErr -29587)   ;  flattened size didn't match input or was too small 
;  The name with the requested paramters was not found 

(defconstant $kFNSNameNotFoundErr -29589)
;  MacLocales error codes

(defconstant $kLocalesBufferTooSmallErr -30001)
(defconstant $kLocalesTableFormatErr -30002)    ;  Requested display locale unavailable, used default

(defconstant $kLocalesDefaultDisplayStatus -30029)
;  Settings Manager (formerly known as Location Manager) Errors 

(defconstant $kALMInternalErr -30049)
(defconstant $kALMGroupNotFoundErr -30048)
(defconstant $kALMNoSuchModuleErr -30047)
(defconstant $kALMModuleCommunicationErr -30046)
(defconstant $kALMDuplicateModuleErr -30045)
(defconstant $kALMInstallationErr -30044)
(defconstant $kALMDeferSwitchErr -30043)
(defconstant $kALMRebootFlagsLevelErr -30042)

(defconstant $kALMLocationNotFoundErr -30048)   ;  Old name 

;  SoundSprocket Error Codes 

(defconstant $kSSpInternalErr -30340)
(defconstant $kSSpVersionErr -30341)
(defconstant $kSSpCantInstallErr -30342)
(defconstant $kSSpParallelUpVectorErr -30343)
(defconstant $kSSpScaleToZeroErr -30344)
;  NetSprocket Error Codes 

(defconstant $kNSpInitializationFailedErr -30360)
(defconstant $kNSpAlreadyInitializedErr -30361)
(defconstant $kNSpTopologyNotSupportedErr -30362)
(defconstant $kNSpPipeFullErr -30364)
(defconstant $kNSpHostFailedErr -30365)
(defconstant $kNSpProtocolNotAvailableErr -30366)
(defconstant $kNSpInvalidGameRefErr -30367)
(defconstant $kNSpInvalidParameterErr -30369)
(defconstant $kNSpOTNotPresentErr -30370)
(defconstant $kNSpOTVersionTooOldErr -30371)
(defconstant $kNSpMemAllocationErr -30373)
(defconstant $kNSpAlreadyAdvertisingErr -30374)
(defconstant $kNSpNotAdvertisingErr -30376)
(defconstant $kNSpInvalidAddressErr -30377)
(defconstant $kNSpFreeQExhaustedErr -30378)
(defconstant $kNSpRemovePlayerFailedErr -30379)
(defconstant $kNSpAddressInUseErr -30380)
(defconstant $kNSpFeatureNotImplementedErr -30381)
(defconstant $kNSpNameRequiredErr -30382)
(defconstant $kNSpInvalidPlayerIDErr -30383)
(defconstant $kNSpInvalidGroupIDErr -30384)
(defconstant $kNSpNoPlayersErr -30385)
(defconstant $kNSpNoGroupsErr -30386)
(defconstant $kNSpNoHostVolunteersErr -30387)
(defconstant $kNSpCreateGroupFailedErr -30388)
(defconstant $kNSpAddPlayerFailedErr -30389)
(defconstant $kNSpInvalidDefinitionErr -30390)
(defconstant $kNSpInvalidProtocolRefErr -30391)
(defconstant $kNSpInvalidProtocolListErr -30392)
(defconstant $kNSpTimeoutErr -30393)
(defconstant $kNSpGameTerminatedErr -30394)
(defconstant $kNSpConnectFailedErr -30395)
(defconstant $kNSpSendFailedErr -30396)
(defconstant $kNSpMessageTooBigErr -30397)
(defconstant $kNSpCantBlockErr -30398)
(defconstant $kNSpJoinFailedErr -30399)
;  InputSprockets error codes 

(defconstant $kISpInternalErr -30420)
(defconstant $kISpSystemListErr -30421)
(defconstant $kISpBufferToSmallErr -30422)
(defconstant $kISpElementInListErr -30423)
(defconstant $kISpElementNotInListErr -30424)
(defconstant $kISpSystemInactiveErr -30425)
(defconstant $kISpDeviceInactiveErr -30426)
(defconstant $kISpSystemActiveErr -30427)
(defconstant $kISpDeviceActiveErr -30428)
(defconstant $kISpListBusyErr -30429)
;  DrawSprockets error/warning codes 

(defconstant $kDSpNotInitializedErr -30440)
(defconstant $kDSpSystemSWTooOldErr -30441)
(defconstant $kDSpInvalidContextErr -30442)
(defconstant $kDSpInvalidAttributesErr -30443)
(defconstant $kDSpContextAlreadyReservedErr -30444)
(defconstant $kDSpContextNotReservedErr -30445)
(defconstant $kDSpContextNotFoundErr -30446)
(defconstant $kDSpFrameRateNotReadyErr -30447)
(defconstant $kDSpConfirmSwitchWarning -30448)
(defconstant $kDSpInternalErr -30449)
(defconstant $kDSpStereoContextErr -30450)
; 
;    ***************************************************************************
;    Find By Content errors are assigned in the range -30500 to -30539, inclusive.
;    ***************************************************************************
; 

(defconstant $kFBCvTwinExceptionErr -30500)     ; no telling what it was

(defconstant $kFBCnoIndexesFound -30501)
(defconstant $kFBCallocFailed -30502)           ; probably low memory

(defconstant $kFBCbadParam -30503)
(defconstant $kFBCfileNotIndexed -30504)
(defconstant $kFBCbadIndexFile -30505)          ; bad FSSpec, or bad data in file

(defconstant $kFBCcompactionFailed -30506)      ; V-Twin exception caught

(defconstant $kFBCvalidationFailed -30507)      ; V-Twin exception caught

(defconstant $kFBCindexingFailed -30508)        ; V-Twin exception caught

(defconstant $kFBCcommitFailed -30509)          ; V-Twin exception caught

(defconstant $kFBCdeletionFailed -30510)        ; V-Twin exception caught

(defconstant $kFBCmoveFailed -30511)            ; V-Twin exception caught

(defconstant $kFBCtokenizationFailed -30512)    ; couldn't read from document or query

(defconstant $kFBCmergingFailed -30513)         ; couldn't merge index files

(defconstant $kFBCindexCreationFailed -30514)   ; couldn't create index

(defconstant $kFBCaccessorStoreFailed -30515)
(defconstant $kFBCaddDocFailed -30516)
(defconstant $kFBCflushFailed -30517)
(defconstant $kFBCindexNotFound -30518)
(defconstant $kFBCnoSearchSession -30519)
(defconstant $kFBCindexingCanceled -30520)
(defconstant $kFBCaccessCanceled -30521)
(defconstant $kFBCindexFileDestroyed -30522)
(defconstant $kFBCindexNotAvailable -30523)
(defconstant $kFBCsearchFailed -30524)
(defconstant $kFBCsomeFilesNotIndexed -30525)
(defconstant $kFBCillegalSessionChange -30526)  ; tried to add/remove vols to a session
; that has hits

(defconstant $kFBCanalysisNotAvailable -30527)
(defconstant $kFBCbadIndexFileVersion -30528)
(defconstant $kFBCsummarizationCanceled -30529)
(defconstant $kFBCindexDiskIOFailed -30530)
(defconstant $kFBCbadSearchSession -30531)
(defconstant $kFBCnoSuchHit -30532)
;  QuickTime VR Errors 

(defconstant $notAQTVRMovieErr -30540)
(defconstant $constraintReachedErr -30541)
(defconstant $callNotSupportedByNodeErr -30542)
(defconstant $selectorNotSupportedByNodeErr -30543)
(defconstant $invalidNodeIDErr -30544)
(defconstant $invalidViewStateErr -30545)
(defconstant $timeNotInViewErr -30546)
(defconstant $propertyNotSupportedByNodeErr -30547)
(defconstant $settingNotSupportedByNodeErr -30548)
(defconstant $limitReachedErr -30549)
(defconstant $invalidNodeFormatErr -30550)
(defconstant $invalidHotSpotIDErr -30551)
(defconstant $noMemoryNodeFailedInitialize -30552)
(defconstant $streamingNodeNotReadyErr -30553)
(defconstant $qtvrLibraryLoadErr -30554)
(defconstant $qtvrUninitialized -30555)
;  Appearance Manager Error Codes 

(defconstant $themeInvalidBrushErr -30560)      ;  pattern index invalid 

(defconstant $themeProcessRegisteredErr -30561)
(defconstant $themeProcessNotRegisteredErr -30562)
(defconstant $themeBadTextColorErr -30563)
(defconstant $themeHasNoAccentsErr -30564)
(defconstant $themeBadCursorIndexErr -30565)
(defconstant $themeScriptFontNotFoundErr -30566);  theme font requested for uninstalled script system 

(defconstant $themeMonitorDepthNotSupportedErr -30567);  theme not supported at monitor depth 
;  theme brush has no corresponding theme text color 

(defconstant $themeNoAppropriateBrushErr -30568)
;  Control Manager Error Codes 

(defconstant $errMessageNotSupported -30580)
(defconstant $errDataNotSupported -30581)
(defconstant $errControlDoesntSupportFocus -30582)
(defconstant $errUnknownControl -30584)
(defconstant $errCouldntSetFocus -30585)
(defconstant $errNoRootControl -30586)
(defconstant $errRootAlreadyExists -30587)
(defconstant $errInvalidPartCode -30588)
(defconstant $errControlsAlreadyExist -30589)
(defconstant $errControlIsNotEmbedder -30590)
(defconstant $errDataSizeMismatch -30591)
(defconstant $errControlHiddenOrDisabled -30592)
(defconstant $errCantEmbedIntoSelf -30594)
(defconstant $errCantEmbedRoot -30595)
(defconstant $errItemNotControl -30596)
(defconstant $controlInvalidDataVersionErr -30597)
(defconstant $controlPropertyInvalid -5603)
(defconstant $controlPropertyNotFoundErr -5604)
(defconstant $controlHandleInvalidErr -30599)
;  URLAccess Error Codes 

(defconstant $kURLInvalidURLReferenceError -30770)
(defconstant $kURLProgressAlreadyDisplayedError -30771)
(defconstant $kURLDestinationExistsError -30772)
(defconstant $kURLInvalidURLError -30773)
(defconstant $kURLUnsupportedSchemeError -30774)
(defconstant $kURLServerBusyError -30775)
(defconstant $kURLAuthenticationError -30776)
(defconstant $kURLPropertyNotYetKnownError -30777)
(defconstant $kURLUnknownPropertyError -30778)
(defconstant $kURLPropertyBufferTooSmallError -30779)
(defconstant $kURLUnsettablePropertyError -30780)
(defconstant $kURLInvalidCallError -30781)
(defconstant $kURLFileEmptyError -30783)
(defconstant $kURLExtensionFailureError -30785)
(defconstant $kURLInvalidConfigurationError -30786)
(defconstant $kURLAccessNotAvailableError -30787)
(defconstant $kURL68kNotSupportedError -30788)
;  ComponentError codes

(defconstant $badComponentInstance #x80008001)  ;  when cast to an OSErr this is -32767
;  when cast to an OSErr this is -32766

(defconstant $badComponentSelector #x80008002)

(defconstant $dsBusError 1)                     ; bus error

(defconstant $dsAddressErr 2)                   ; address error

(defconstant $dsIllInstErr 3)                   ; illegal instruction error

(defconstant $dsZeroDivErr 4)                   ; zero divide error

(defconstant $dsChkErr 5)                       ; check trap error

(defconstant $dsOvflowErr 6)                    ; overflow trap error

(defconstant $dsPrivErr 7)                      ; privilege violation error

(defconstant $dsTraceErr 8)                     ; trace mode error

(defconstant $dsLineAErr 9)                     ; line 1010 trap error

(defconstant $dsLineFErr 10)                    ; line 1111 trap error

(defconstant $dsMiscErr 11)                     ; miscellaneous hardware exception error

(defconstant $dsCoreErr 12)                     ; unimplemented core routine error

(defconstant $dsIrqErr 13)                      ; uninstalled interrupt error

(defconstant $dsIOCoreErr 14)                   ; IO Core Error

(defconstant $dsLoadErr 15)                     ; Segment Loader Error

(defconstant $dsFPErr 16)                       ; Floating point error

(defconstant $dsNoPackErr 17)                   ; package 0 not present

(defconstant $dsNoPk1 18)                       ; package 1 not present

(defconstant $dsNoPk2 19)                       ; package 2 not present


(defconstant $dsNoPk3 20)                       ; package 3 not present

(defconstant $dsNoPk4 21)                       ; package 4 not present

(defconstant $dsNoPk5 22)                       ; package 5 not present

(defconstant $dsNoPk6 23)                       ; package 6 not present

(defconstant $dsNoPk7 24)                       ; package 7 not present

(defconstant $dsMemFullErr 25)                  ; out of memory!

(defconstant $dsBadLaunch 26)                   ; can't launch file

(defconstant $dsFSErr 27)                       ; file system map has been trashed

(defconstant $dsStknHeap 28)                    ; stack has moved into application heap

(defconstant $negZcbFreeErr 33)                 ; ZcbFree has gone negative

(defconstant $dsFinderErr 41)                   ; can't load the Finder error

(defconstant $dsBadSlotInt 51)                  ; unserviceable slot interrupt

(defconstant $dsBadSANEOpcode 81)               ; bad opcode given to SANE Pack4

(defconstant $dsBadPatchHeader 83)              ; SetTrapAddress saw the “come-from” header

(defconstant $menuPrgErr 84)                    ; happens when a menu is purged

(defconstant $dsMBarNFnd 85)                    ; Menu Manager Errors

(defconstant $dsHMenuFindErr 86)                ; Menu Manager Errors

(defconstant $dsWDEFNotFound 87)                ; could not load WDEF

(defconstant $dsCDEFNotFound 88)                ; could not load CDEF

(defconstant $dsMDEFNotFound 89)                ; could not load MDEF


(defconstant $dsNoFPU 90)                       ; an FPU instruction was executed and the machine doesn’t have one

(defconstant $dsNoPatch 98)                     ; Can't patch for particular Model Mac

(defconstant $dsBadPatch 99)                    ; Can't load patch resource

(defconstant $dsParityErr 101)                  ; memory parity error

(defconstant $dsOldSystem 102)                  ; System is too old for this ROM

(defconstant $ds32BitMode 103)                  ; booting in 32-bit on a 24-bit sys

(defconstant $dsNeedToWriteBootBlocks 104)      ; need to write new boot blocks

(defconstant $dsNotEnoughRAMToBoot 105)         ; must have at least 1.5MB of RAM to boot 7.0

(defconstant $dsBufPtrTooLow 106)               ; bufPtr moved too far during boot

(defconstant $dsVMDeferredFuncTableFull 112)    ; VM's DeferUserFn table is full

(defconstant $dsVMBadBackingStore 113)          ; Error occurred while reading or writing the VM backing-store file

(defconstant $dsCantHoldSystemHeap 114)         ; Unable to hold the system heap during boot

(defconstant $dsSystemRequiresPowerPC 116)      ; Startup disk requires PowerPC

(defconstant $dsGibblyMovedToDisabledFolder 117);  For debug builds only, signals that active gibbly was disabled during boot. 

(defconstant $dsUnBootableSystem 118)           ;  Active system file will not boot on this system because it was designed only to boot from a CD. 

(defconstant $dsMustUseFCBAccessors 119)        ;  FCBSPtr and FSFCBLen are invalid - must use FSM FCB accessor functions 

(defconstant $dsMacOSROMVersionTooOld 120)      ;  The version of the "Mac OS ROM" file is too old to be used with the installed version of system software 

(defconstant $dsLostConnectionToNetworkDisk 121);  Lost communication with Netboot server 

(defconstant $dsRAMDiskTooBig 122)              ;  The RAM disk is too big to boot safely; will be turned off 

(defconstant $dsWriteToSupervisorStackGuardPage #x80); the supervisor stack overflowed into its guard page 

(defconstant $dsReinsert 30)                    ; request user to reinsert off-line volume

(defconstant $shutDownAlert 42)                 ; handled like a shutdown error

(defconstant $dsShutDownOrRestart #x4E20)       ; user choice between ShutDown and Restart

(defconstant $dsSwitchOffOrRestart #x4E21)      ; user choice between switching off and Restart

(defconstant $dsForcedQuit #x4E22)              ; allow the user to ExitToShell, return if Cancel

(defconstant $dsRemoveDisk #x4E23)              ; request user to remove disk from manual eject drive

(defconstant $dsDirtyDisk #x4E24)               ; request user to return a manually-ejected dirty disk

(defconstant $dsShutDownOrResume #x4E8D)        ; allow user to return to Finder or ShutDown

(defconstant $dsSCSIWarn #x4E2A)                ; Portable SCSI adapter warning.

(defconstant $dsMBSysError #x7210)              ; Media Bay replace warning.

(defconstant $dsMBFlpySysError #x7211)          ; Media Bay, floppy replace warning.

(defconstant $dsMBATASysError #x7212)           ; Media Bay, ATA replace warning.

(defconstant $dsMBATAPISysError #x7213)         ; Media Bay, ATAPI replace warning...

(defconstant $dsMBExternFlpySysError #x7214)    ; Media Bay, external floppy drive reconnect warning

(defconstant $dsPCCardATASysError #x7215)       ; PCCard has been ejected while still in use. 

; 
;     System Errors that are used after MacsBug is loaded to put up dialogs since these should not 
;     cause MacsBug to stop, they must be in the range (30, 42, 16384-32767) negative numbers add 
;     to an existing dialog without putting up a whole new dialog 
; 

(defconstant $dsNoExtsMacsBug -1)               ; not a SysErr, just a placeholder 

(defconstant $dsNoExtsDisassembler -2)          ; not a SysErr, just a placeholder 

(defconstant $dsMacsBugInstalled -10)           ; say “MacsBug Installed”

(defconstant $dsDisassemblerInstalled -11)      ; say “Disassembler Installed”

(defconstant $dsExtensionsDisabled -13)         ; say “Extensions Disabled”

(defconstant $dsGreeting 40)                    ; welcome to Macintosh greeting

(defconstant $dsSysErr #x7FFF)                  ; general system error
; old names here for compatibility’s sake

(defconstant $WDEFNFnd 87)

(defconstant $CDEFNFnd 88)
(defconstant $dsNotThe1 31)                     ; not the disk I wanted

(defconstant $dsBadStartupDisk 42)              ; unable to mount boot volume (sad Mac only)

(defconstant $dsSystemFileErr 43)               ; can’t find System file to open (sad Mac only)

(defconstant $dsHD20Installed -12)              ; say “HD20 Startup”

(defconstant $mBarNFnd -126)                    ; system error code for MBDF not found

(defconstant $fsDSIntErr -127)                  ; non-hardware Internal file system error

(defconstant $hMenuFindErr -127)                ; could not find HMenu's parent in MenuKey (wrong error code - obsolete)

(defconstant $userBreak -490)                   ; user debugger break

(defconstant $strUserBreak -491)                ; user debugger break; display string on stack
; user debugger break; execute debugger commands on stack

(defconstant $exUserBreak -492)
;  DS Errors which are specific to the new runtime model introduced with PowerPC 

(defconstant $dsBadLibrary #x3F2)               ;  Bad shared library 

(defconstant $dsMixedModeFailure #x3F3)         ;  Internal Mixed Mode Failure 

; 
;  *  SysError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SysError" 
   ((errorCode :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MACERRORS__ */


(provide-interface "MacErrors")