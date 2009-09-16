; SysEqu.lisp
; Lisp Transliteration of the File: SysEqu.a

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; 08/24/91 alice $iodestdirid $iodestnameptr
; 12/13/90 bill  kHighLevelEvent
; 03/12/90 bill  Added GDevice attribute definitions

(in-package :ccl)

(eval-when (eval compile)

(setq *internal-sysequ-defs () *internal-sysequ-names ())

(let ((*warn-if-redefine* nil))
  (defmacro defextconst (name value)
    (list 'progn
          (list 'push (list 'quote (list 'define-constant (list 'quote name) value))
                '*internal-sysequ-defs)
	    (list 'push (list 'quote name) '*internal-sysequ-names)))
  )
(defmacro internal-sysequ-defs ()
  (declare (special *internal-sysequ-defs))
  (list* 'eval-when '(eval load) *internal-sysequ-defs))
(defmacro internal-sysequ-names ()
  (declare (special *internal-sysequ-names))
  (list 'quote *internal-sysequ-names))

; File: SysEqu.a
;
; Copyright Apple Computer, Inc. 1986-1987
; All Rights Reserved
;
; System Equates -- This file defines the low-level equates for the
;	Macintosh software.  This is divided into two pieces for
;	assembly space and speed considerations.  The wholeSystem flag is used
;	to include the less common equates which realizes a complete set.  The
;	comments marked with ";+" denote categories or managers.	Record
;	stuctures may have additional private equates which are defined by and
;	reserved for use by Apple Computer, Inc.
;
;___________________________________________________________________________


(defextconst $PCDeskPat	#x20B)			; desktop pat, top bit only! others are in use
(defextconst $HiKeyLast	#x216)			; Same as KbdVars
(defextconst $KbdLast	#x218)			; Same as KbdVars+2

(defextconst $ExpandMem	#x2B6)			; pointer to expanded memory block
(defextconst $expandSize	64)				; size of expanded memory block

; Test Manager EQU's
(defextconst $videoMagic	#x5A932BC7)		; When VideoInfoOk contains this value, the video card is ok (CritErr).


; Unit table size constants (Used in startInit.a)
(defextconst $unitEntries	64)			; default # of entries in unit table
(defextconst $maxUTEntries	128)		; Set Max higher so the table can grow.

(defextconst $bgnSlotUnit	48)			; default start unit number for slots.
(defextconst $bgnSlotRef		-49)		; default start RefNum for slots.



; Start Boot state constants.
(defextconst $sbState0	0)					;StartBoot code is at state-0.
(defextconst $sbState1	1)					;StartBoot code is at state-1.


; The Alarm Clock

(defextconst $alrmFlEnable	0)				; 1 => alarm clock mechanism is triggered

; start of new low mem

(defextconst $SCSIBase	#x0C00)			; (long) base address for SCSI chip read
(defextconst $SCSIDMA	#x0C04)			; (long) base address for SCSI DMA
(defextconst $SCSIHsk	#x0C08)			; (long) base address for SCSI handshake
(defextconst $SCSIGlobals	#x0C0C)			; (long) ptr for SCSI mgr locals

(defextconst $RGBBlack	#x0C10)			; (6 bytes) the black field for color
(defextconst $RGBWhite	#x0C16)			; (6 bytes) the white field for color

(defextconst $RowBits	#x0C20)			; (word) screen horizontal pixels
(defextconst $ColLines	#x0C22)			; (word) screen vertical pixels

(defextconst $ScreenBytes	#x0C24)			; (long) total screen bytes

; $0C28 unused (was SlotDT)

(defextconst $NMIFlag	#x0C2C)			; (byte) flag for NMI debounce
(defextconst $VidType	#x0C2D)			; (byte) video board type ID
(defextconst $VidMode	#x0C2E)			; (byte) video mode (4=4bit color)

(defextconst $SCSIPoll	#x0C2F)			; (byte) poll for device zero only once.
										; (init to $FFFF, by default)

(defextconst $SEVarBase	#x0C30)			; ($0C30-0CB0) 128 bytes for sys err data
										; note!!! - if changed, need to change also in hwequ file

(defextconst $MMUFlags	#x0CB0)			; (byte) cleared to zero (reserved for future use)
(defextconst $MMUType	#x0CB1)			; (byte) kind of MMU present
(defextconst $MMU32bit	#x0CB2)			; (byte) boolean reflecting current machine MMU mode
(defextconst $MMUFluff	#x0CB3)			; (byte) fluff byte forced by reducing MMUMode to MMU32bit.
(defextconst $MMUTbl	#x0CB4)			; (long) pointer to MMU Mapping table
(defextconst $MMUTblSize	#x0CB8)			; (long) size of the MMU mapping table
(defextconst $SInfoPtr	#x0CBC)			; (long) pointer to Slot manager information

(defextconst $ASCBase	#x0CC0)			; (long) pointer to Sound Chip
(defextconst $SMGlobals	#x0CC4)			; (long) pointer to Sound Manager Globals

(defextconst $TheGDevice	#x0CC8)			; (long) the current graphics device
(defextconst $CQDGlobals	#x0CCC)			; (long) quickDraw global extensions

; GDevice attributes
(defextconst $gdDevType 0)              ; 0 = mono, 1 = color
(defextconst $ramInit 10)               ; set if device has been initialized from RAM
(defextconst $mainScreen 11)            ; set if device is the main screen
(defextconst $allInit 12)               ; set if devices were inited from a 'scrn' resource
(defextconst $screenDevice 13)          ; set if device is a screen device
(defextconst $noDriver 14)              ; set if device has no driver
(defextconst $screenActive 15)          ; set if device is active


; TEMPORARY EQUATES

(defextconst $DeskCPat	#x0CD8)		;[PixPatHandle] Handle to desk pixPat
(defextconst $DeskPatDisable	#x0CDC)		;[byte/boolean] if 0, then use deskCPat

(defextconst $ADBBase	#x0CF8)			; (long) pointer to Front Desk Buss Variables

(defextconst $WarmStart	#x0CFC)			; (long) flag to indicate it is a warm start
(defextconst $wmStConst	#x574C5343)		; warm start constant

(defextconst $TimeDBRA	#x0D00)			; (word) number of iterations of DBRA per millisecond
(defextconst $TimeSCCDB	#x0D02)			; (word) number of iter's of SCC access & DBRA.

(defextconst $SlotQDT	#x0D04)			; ptr to slot queue table
(defextconst $SlotPrTbl	#x0D08)			; ptr to slot priority table
(defextconst $SlotVBLQ	#x0D0C)			; ptr to slot VBL queue table
(defextconst $ScrnVBLPtr	#x0D10)			; save for ptr to main screen VBL queue
(defextconst $SlotTICKS	#x0D14)			; ptr to slot tickcount table

;4appletalk	EQU		$0D1C				; (long) pointer to appletalk globals

(defextconst $TableSeed	#x0D20)			; (long) seed value for color table ID's

(defextconst $SRsrcTblPtr	#x0D24)			; (long) pointer to slot resource table.

(defextconst $JVBLTask	#x0D28)			; vector to slot VBL task interrupt handler

(defextconst $WMgrCPort	#x0D2C)			; window manager color port	

(defextconst $VertRRate	#x0D30)			; (word) Vertical refresh rate for start manager.	

; Unused $0D43-0D53

(defextconst $ChunkyDepth	#x0D60)			; depth of the pixels
(defextconst $CrsrPtr	#x0D62)			; pointer to cursor save area
(defextconst $PortList	#x0D66)			; list of grafports<C14X>

(defextconst $MickeyBytes	#x0D6A)			; long pointer to cursor stuff

(defextconst $QDErr	#x0D6E)			; QuickDraw error code [word]

(defextconst $VIA2DT	#x0D70)			; 32 bytes for VIA2 dispatch table for NuMac
										; uses $0D70 - $0D8F


(defextconst $SInitFlags	#x0D90)			; StartInit.a flags [word]

(defextconst $DTQueue	#x0D92)			; (10 bytes) deferred task queue header
(defextconst $DTQFlags	#x0D92)			; flag word for DTQueue
(defextconst $DTskQHdr	#x0D94)			; ptr to head of queue
(defextconst $DTskQTail	#x0D98)			; ptr to tail of queue
(defextconst $JDTInstall	#x0D9C)			; (long) ptr to deferred task install routine

(defextconst $HiliteRGB	#x0DA0)			; 6 bytes:  rgb of hilite color

(defextconst $TimeSCSIDB	#x0DA6)			; (word) number of iter's of SCSI access & DBRA

(defextconst $DSCtrAdj	#x0DA8)			; (long) Center adjust for DS rect.

(defextconst $IconTLAddr	#x0DAC)			; (long) pointer to where start icons are to be put.

(defextconst $VideoInfoOK	#x0DB0)		; (long) Signals to CritErr that the Video card is ok

(defextconst $EndSRTPtr	#x0DB4)		; (long) Pointer to the end of the Slot Resource Table (Not the SRT buffer).

(defextconst $SDMJmpTblPtr	#x0DB8)		; (long) Pointer to the SDM jump table

(defextconst $JSwapMMU	#x0DBC)		; (long) jump vector to SwapMMU routine

(defextconst $SdmBusErr	#x0DC0)		; (long) Pointer to the SDM busErr handler
(defextconst $LastTxGDevice	#x0DC4)		; (long) copy of TheGDevice set up for fast text measure

; Unused $0DC8-...						; PLEASE MAINTAIN THIS POINTER TO UNUSED

; CRSRSAVE $88C-8CB is no longer used
; *** RESERVED FOR USE BY QUICKDRAW ***

(defextconst $NewCrsrJTbl	#x88C)			; location of new crsr jump vectors
(defextconst $NewCrsrJCnt	1)				; 2 new vectors
(defextconst $JAllocCrsr	#x88C)			; (long) vector to routine that allocates cursor
(defextconst $JSetCCrsr	#x890)			; (long) vector to routine that sets color cursor
(defextconst $JOpcodeProc	#x894)			; (long) vector to process new picture opcodes
(defextconst $CRSRBASE	#x898)			; (long) scrnBase for cursor
(defextconst $CrsrDevice	#x89C)			; (long) current cursor device
(defextconst $SrcDevice	#x8A0)			; (LONG) Src device for Stretchbits
(defextconst $MainDevice	#x8A4)			; (long) the main screen device
(defextconst $DeviceList	#x8A8)			; (long) list of display devices
(defextconst $CRSRROW	#x8AC)			; (word) rowbytes for current cursor screen
(defextconst $QDColors	#x8B0)			; (long) handle to default colors

; QuickDraw

(defextconst $HiliteMode	#x938)			; used for color highlighting


; Exception vectors

(defextconst $BusErrVct	#x08)				; bus error vector


;-------------
; MMU Equates		
;-------------

; MMU Mode bits		
;
; type MMU_Mode = (true32b,false32b)

(defextconst $false32b	0)					;modified
(defextconst $true32b	1)

;+ System Error Handler

(defextconst $RestProc	#xA8C) ; Resume procedure f  InitDialogs [pointer]

; equates for new queue elements

(defextconst $sIQType	6)		; slot interrupt queue element ID		<C409>

;Default Startup

;DefaultRec offsets for set/get default startup

(defextconst $drDriveNum	0)	;[INTEGER]
(defextconst $drRefNum	2)	;[INTEGER]

; Deferred Task Queue Element

(defextconst $dtQType	7)		; deferred task queue element ID
(defextconst $inDTQ	6) 		; bit index for "in deferred task" flag

(defextconst $dtLink	0) 		; Link to next element [pointer]
(defextconst $dtType	4) 		; Unique ID for validity [word]
(defextconst $dtFlags	6)		; optional flags [word]
(defextconst $dtAddr	8) 		; service routine [pointer]
(defextconst $dtParm	#xC) 		; optional A1 parameter [long]
(defextconst $dtResrvd	#x10) 		; reserved [long]

(defextconst $dtQElSize	20)		; length of DT queue element in bytes


;+ ROM Equates

(defextconst $ROM85	#x28E) ; (word) actually high bit - 0 for ROM vers $75 (sic) and later
(defextconst $ROMMapHndl	#xB06) ; (long) handle of ROM resource map

;+ Screen Equates

(defextconst $ScrVRes	#x102) ; screen vertical dots/inch [word]
(defextconst $ScrHRes	#x104) ; screen horizontal dots/inch [word]
(defextconst $ScrnBase	#x824) ; Screen Base [pointer]
(defextconst $ScreenRow	#x106) ; rowBytes of screen [word]


; Mouse/Keyboard

(defextconst $MBTicks	#x16E) ; tick count @ last mouse button [long]
(defextconst $JKybdTask	#x21A) ; keyboard VBL task hook [pointer]
(defextconst $KeyLast	#x184) ; ASCII for last valid keycode [word]
(defextconst $KeyTime	#x186) ; tickcount when KEYLAST was rec'd [long]
(defextconst $KeyRepTime	#x18A) ; tickcount when key was last repeated [long]

;+ Parameter RAM (a twenty byte copy of the real parameter ram).

(defextconst $SPConfig	#x1FB) ; config bits: 4-7 A, 0-3 B (see use type below)
(defextconst $SPPortA	#x1FC) ; SCC port A configuration [word]
(defextconst $SPPortB	#x1FE) ; SCC port B configuration [word]

; SCC Serial Chip Addresses

(defextconst $SCCRd	#x1D8) ; SCC base read address [pointer]
(defextconst $SCCWr	#x1DC) ; SCC base write address [pointer]

; Serial port use type

(defextconst $useFree	0) ; Use undefined
(defextconst $useATalk	1) ; AppleTalk
(defextconst $useAsync	2) ; Async
(defextconst $useExtClk	3) ; externally clocked

; Unpacked, user versions of parameter ram

(defextconst $DoubleTime	#x2F0) ; double click ticks [long]
(defextconst $CaretTime	#x2F4) ; caret blink ticks [long]
(defextconst $KeyThresh	#x18E) ; threshold for key repeat [word]
(defextconst $KeyRepThresh	#x190) ; key repeat speed [word]
(defextconst $SdVolume	#x260) ; Global volume(sound) control [byte]


;+ System Clocks

(defextconst $Ticks	#x16A) ; Tick count, time since boot [long]
(defextconst $Time	#x20C) ; clock time (extrapolated) [long]


;+ Cursor

(defextconst $iBeamCursor	1) ; text selection cursor
(defextconst $crossCursor	2) ; for structured selection
(defextconst $plusCursor	3) ; for drawing graphics
(defextconst $watchCursor	4) ; for indicating a long delay


; result codes for Relstring call

(defextconst $sortsBefore	-1); str1 < str2
(defextconst $sortsEqual	0); str1 = str2
(defextconst $sortsAfter	1); str1 > str2

;+ Queue Package

(defextconst $qInUse	7) ; queue-in-use flag bit

; Header Record

(defextconst $qHeadSize	#xA) ; queue header size
(defextconst $qFlags	0) ; miscellaneous flags [word]
(defextconst $qHead	2) ; first element in queue [pointer]
(defextconst $qTail	6) ; last element in queue [pointer]

; General Purpose Queue Element Definition

(defextconst $qLink	0) ; link to next queue element [pointer]
(defextconst $qType	4) ; queue element type [word]


;+ Event Manager

(defextconst $evType	4) ; event queue element is type 4

; Event Type Numbers (in EvtNum)

(defextconst $everyEvent	-1)
(defextconst $nullEvt	0) ; event 0 is the null event
(defextconst $mButDwnEvt	1) ; mouse button down is event 1
(defextconst $mButUpEvt	2) ; mouse button up is event 2
(defextconst $keyDwnEvt	3) ; key down is event 3
(defextconst $keyUpEvt	4) ; key up is event 4
(defextconst $autoKeyEvt	5) ; auto-repeated key is event 5
(defextconst $updatEvt	6) ; update event
(defextconst $diskInsertEvt	7) ; disk-inserted event
(defextconst $activateEvt	8) ; activate/deactive event
(defextconst $netWorkEvt	#xA) ; network event
(defextconst $ioDrvrEvt	#xB) ; driver-defined event
(defextconst $app1Evt	#xC) ; application defined events
(defextconst $app2Evt	#xD)
(defextconst $app3Evt	#xE)
(defextconst $app4Evt	#xF)
(defextconst $kHighLevelEvent 23)       ; high-level event (AppleEvent)

; Modifier bits in event record
; (same constant names are masks rather than
; bit numbers in higher level languages.)

(defextconst $activeFlag	#x0) ; activate?
(defextconst $btnState	#x7) ; state of button?
(defextconst $cmdKey	#x8) ; command key down?
(defextconst $shiftKey	#x9) ; shift key down?
(defextconst $alphaLock	#xA) ; alpha lock down?
(defextconst $optionKey	#xB) ; option key down?
(defextconst $controlKey	#xC) ; control key on new keyboard?

; following four values are from interface file events.lisp:
(defextconst $cmdKeyMask #$cmdkey)
(defextconst $shiftKeyMask #$shiftkey)
(defextconst $optionKeyMask #$optionkey)
(defextconst $controlKeyMask #$controlkey)

; to decipher event message for keyDown events
(defextconst $charCodeMask	#x000000FF)
(defextconst $keyCodeMask	#x0000FF00)
(defextconst $adbAddrMask	#x00FF0000)


; Event Record Definition

(defextconst $evtNum	0) ; event code [word]
(defextconst $evtMessage	2) ; event message [long]
(defextconst $evtTicks	6) ; ticks since startup [long]
(defextconst $evtMouse	#xA) ; mouse location [long]
(defextconst $evtMeta	#xE) ; state of modifier keys [byte]
(defextconst $evtMBut	#xF) ; state of mouse button [byte]
(defextconst $evtBlkSize	#x10) ; size in bytes of the event record

(defextconst $MonkeyLives	#x100) ; monkey lives if >= 0 [word]
(defextconst $SEvtEnb	#x15C) ; enable SysEvent calls from GNE [byte]
(defextconst $JournalFlag	#x8DE) ; journaling state [word]
(defextconst $JournalRef	#x8E8) ; Journalling driver's refnum [word]


;+ Memory Manager

; Master pointer bits for handles - USE _HLock, _HPurge, etc. for portability

(defextconst $lock	7) ; lock bit in a master pointer
(defextconst $purge	6) ; bit for purgeable/unpurgeable
(defextconst $resource	5) ; bit to flag a resource handle


(defextconst $BufPtr	#x10C) ; top of application memory [pointer]
(defextconst $StkLowPt	#x110) ; Lowest stack as measured in VBL task [pointer]
(defextconst $TheZone	#x118) ; current heap zone [pointer]
(defextconst $ApplLimit	#x130) ; application limit [pointer]
(defextconst $SysZone	#x2A6) ; system heap zone [pointer]
(defextconst $ApplZone	#x2AA) ; application heap zone [pointer]
(defextconst $HeapEnd	#x114) ; end of heap [pointer]
(defextconst $HiHeapMark	#xBAE) ; (long) highest address used by a zone below sp<01Nov85 JTC>

(defextconst $MemErr	#x220) ; last memory manager error [word]

(defextconst $maxSize	#x800000)  ; outrageously large memory mgr request
(defextconst $dfltStackSize	#x00002000); 8K size for stack
(defextconst $mnStackSize	#x00000400); 1K minimum size for stack

; _InitZone argument table.

(defextconst $startPtr	0) ; Start address for zone [pointer]
(defextconst $limitPtr	4) ; Limit address for zone [pointer]
(defextconst $cMoreMasters	8) ; Number of masters to allocate at time [word]
(defextconst $pGrowZone	10) ; growZone procedure [pointer]

; Control/Status Call Codes

(defextconst $killCode	1) ; KillIO code
(defextconst $drvStsCode	8) ; status call code for drive status
(defextconst $ejectCode	7) ; control call eject code
(defextconst $tgBuffCode	8) ; set tag buffer code

; Driver flags, (Bit definitions for DCtlFlags byte)

(defextconst $dReadEnable	0) ; enabled for read operations
(defextconst $dWritEnable	1) ; enabled for writing
(defextconst $dCtlEnable	2) ; enabled for control operations
(defextconst $dStatEnable	3) ; enabled for status operations
(defextconst $dNeedGoodBye	4) ; needs a "goodbye kiss"
(defextconst $dNeedTime	5) ; needs "main thread" time
(defextconst $dNeedLock	6) ; needs to be accessed at interrupt level

; Run-Time flags, (Bit definitions for DCtlFlags+1 byte)

(defextconst $dOpened	5) ; bit to mark driver 'Open'
(defextconst $dRAMBased	6) ; 1=RAM-based Driver, 0=ROM-based
(defextconst $drvrActive	7) ; bit to mark the driver active

; Drive queue element offsets

(defextconst $dQDrive	#x6) ; drive number [word]
(defextconst $dQRefNum	#x8) ; driver refnum [word]
(defextconst $dQFSID	#xA) ; file system handling this drive [word]
(defextconst $dQDrvSz	#xC) ; number of blocks this drive [word]
(defextconst $dQDrvSz2	#xE) ; if qType = 1, high word of drive size

; Queue Element Type Definitions

(defextconst $ioQType	2) ; I/O queue element is type 2
(defextconst $drvQType	3) ; timer queue element is type 3
(defextconst $fsQType	5) ; File System VCB element

; Device Control Entry Definition
;dCtlEntrySize	used to be only 40 bytes!

(defextconst $dCtlEntrySize	#x34) ; length of a DCE [52 bytes]
(defextconst $dCtlDriver	0)	 ; driver [handle]
(defextconst $dCtlFlags	4)	 ; flags [word]
(defextconst $dCtlQueue	6)	 ; queue header
(defextconst $dCtlQHead	8)	 ; queue first-element [pointer]
(defextconst $dCtlQTail	#xC)	 ; queue last-element [pointer]
(defextconst $dCtlPosition	#x10) ; position [long]
(defextconst $dCtlStorage	#x14) ; driver's private storage [handle]
(defextconst $dCtlRefNum	#x18) ; refNum of this driver [word]
(defextconst $dCtlCurTicks	#x1A) ; counter for timing systemTask calls [long]
(defextconst $dCtlWindow	#x1E) ; driver's window (if any) [pointer]
(defextconst $dCtlDelay	#x22) ; number of ticks between sysTask calls [word]
(defextconst $dCtlEMask	#x24) ; desk accessory event mask [word]
(defextconst $dCtlMenu	#x26) ; menu ID associated with driver [word]
(defextconst $dCtlSlot	#x28) ; device slot Number [byte]
(defextconst $dCtlSlotId	#x29) ; device Id within slot [byte]
(defextconst $dCtlDevBase	#x2A) ; driver scratch ptr/offset from base to device [long]
(defextconst $dCtlOwner	#x2E) ; ptr to task control block(ownership) [Ptr]
(defextconst $dctlExtDev	#x32) ; Id of external device [byte]


; Driver Globals

(defextconst $UTableBase	#x11C) ; unit I/O table [pointer]
(defextconst $UnitNtryCnt	#x1D2) ; count of entries in unit table [word]

(defextconst $JFetch	#x8F4) ; fetch a byte routine for drivers [pointer]
(defextconst $JStash	#x8F8) ; stash a byte routine for drivers [pointer]
(defextconst $JIODone	#x8FC) ; IODone entry location [pointer]

;Chooser

(defextconst $chooserID	1) ; caller value for the chooser

;+ I/O System

; File positioning modes for ioPosMode field of I/O record

(defextconst $fsAtMark	0) ; at current position of mark
(defextconst $fsFromStart	1) ; offset relative to beginning of file
(defextconst $fsFromLEOF	2) ; offset relative to logical end-of-file
(defextconst $fsFromMark	3) ; offset relative to current mark
(defextconst $rdVerify	#x40) ; read verify mode

; Permission values for ioPermssn field of I/O record

(defextconst $fsCurPerm	0) ; whatever is currently allowed
(defextconst $fsRdPerm	1) ; request to read only
(defextconst $fsWrPerm	2) ; request to write only
(defextconst $fsRdWrPerm	3) ; request to read and write
(defextconst $fsRdWrShPerm	4) ; request for shared read and write

; I/O record (general fields with trap-specific ones listed below)

(defextconst $ioQElSize	#x32) ; length of I/O parameter block [50 bytes]

(defextconst $ioLink	#x0) ; queue link in header [pointer]
(defextconst $ioType	#x4) ; type for safety check [byte]
(defextconst $ioTrap	#x6) ; the trap [word]
(defextconst $ioCmdAddr	#x8) ; address to dispatch to [pointer]

(defextconst $ioCompletion	#xC) ; completion routine [pointer]
(defextconst $ioResult	#x10) ; I/O result code [word]
(defextconst $ioFileName	#x12) ; file name pointer [pointer]
(defextconst $ioVRefNum	#x16) ; volume refnum [word]
(defextconst $ioDrvNum	#x16) ; drive number [word]
(defextconst $ioRefNum	#x18) ; file reference number [word]

(defextconst $ioFileType	#x1A) ; specified along with FileName [byte]

; specific fields for _Read, _Write

(defextconst $ioBuffer	#x20) ; data buffer [pointer]
(defextconst $ioByteCount	#x24) ; requested byte count [long]
(defextconst $ioNumDone	#x28) ; actual byte count completed [long]

(defextconst $ioPosMode	#x2C) ; initial file positioning mode/eol char [word]
(defextconst $ioPosOffset	#x2E) ; file position offset [long]

; specific fields for _Allocate

(defextconst $ioReqCount	#x24) ; requested new size [long]
(defextconst $ioActCount	#x28) ; actual byte count allocated [long]

; specific fields for _Open

(defextconst $ioPermssn	#x1B) ; permissions [byte]
(defextconst $ioOwnBuf	#x1C) ; "private" 522-byte buffer [pointer]

; specific fields for _ReName

(defextconst $ioNewName	#x1C) ; new name pointer [pointer]

; specific fields for  _GetFileInfo, _SetFileInfo

(defextconst $ioFQElSize	#x50) ; File command parameter length [80 bytes]

(defextconst $ioFDirIndex	#x1C) ; directory index of file [word]
(defextconst $ioFlAttrib	#x1E) ; in-use bit=7, lock bit=0 [byte]
(defextconst $ioFFlType	#x1F) ; file type [byte]
(defextconst $ioFlUsrWds	#x20) ; finder info [16 bytes]
(defextconst $ioFFlNum	#x30) ; file number [long]
(defextconst $ioDirID	#x30) ; directory ID
(defextconst $ioDestNamePtr 28) ; dest name for exchangefiles
(defextconst $ioDestDirid 36)   ; dest dirid for ditto

(defextconst $ioFlStBlk	#x34) ; start file block (0000 if none) [word]
(defextconst $ioFlLgLen	#x36) ; logical length (EOF) [long]
(defextconst $ioFlPyLen	#x3A) ; physical length in bytes [long]
(defextconst $ioFlRStBlk	#x3E) ; resource fork's start file block [word]
(defextconst $ioFlRLgLen	#x40) ; resource fork's logical length (EOF) [long]
(defextconst $ioFlRPyLen	#x44) ; resource fork's physical length [long]

(defextconst $ioFlCrDat	#x48) ; creation date & time [long]
(defextconst $ioFlMdDat	#x4C) ; last modification date & time [long]

; Specific fields for _GetEOF, _SetEOF

(defextconst $ioLEOF	#x1C) ; logical end-of-file [long]

; Specific fields for _SetFileType

(defextconst $ioNewType	#x1C) ; new type byte [byte]

; Specific fields for _GetVolInfo, _GetVolume, _SetVolume, _MountVol, _UnmountVol,
; _Eject.  Note that these traps have a bigger record size.

(defextconst $ioVQElSize	#x40) ; Volume command parameter length [64 bytes]
(defextconst $ioVDrvNum	#x16) ; drive or volume number [word]
(defextconst $ioVNPtr	#x12) ; name buffer (or zero) [pointer]
(defextconst $ioVolIndex	#x1C) ; volume index number [word]

(defextconst $ioVCrDate	#x1E) ; creation date & time [long]
(defextconst $ioVLsBkUp	#x22) ; last backup date & time [long]
(defextconst $ioVAtrb	#x26) ; Volume attributes [word]
(defextconst $ioVNmFls	#x28) ; # files in directory [word]
(defextconst $ioVDirSt	#x2A) ; start block of file dir [word]
(defextconst $ioVBlLn	#x2C) ; length of dir in blocks [word]
(defextconst $ioVNmAlBlks	#x2E) ; num blks (of alloc size) this dev [word]
(defextconst $ioVAlBlkSiz	#x30) ; alloc blk byte size [long]
(defextconst $ioVClpSiz	#x34) ; bytes to try to allocate at a time [long]
(defextconst $ioAlBlSt	#x38) ; starting block in block map [word]
(defextconst $ioVNxtFNum	#x3A) ; next free file number [long]
(defextconst $ioVFrBlk	#x3E) ; # free alloc blks for this vol [word]

;--- New File System Equates  ---
;
; Catalog structure equates:

(defextconst $fsRtParID	1)			; DirID of parent's root
(defextconst $fsRtDirID	2)			; Root DirID
(defextconst $fsXTCNID	3)			; Extent B*-Tree file ID
(defextconst $fsCTCNID	4)			; Catalog B*-Tree file ID
(defextconst $fsUsrCNID	#x10)			; First assignable user CNode ID

; Additional equates for catalog information return:

(defextconst $ioFlBkDat	#x50)			; File's last backup date
(defextconst $ioFlxFndrInfo	#x54)			; File's additional finder info bytes
(defextconst $ioFlParID	#x64)			; File's parent directory ID
(defextconst $ioFlClpSiz	#x68)			; File's clump size, in bytes

; Additional equates for directory information return:

(defextconst $ioDirFlg	4)			; Bit in ioFlAttrb set to indicate directory
(defextconst $ioDrUsrWds	#x20)			; Directory's user info bytes
(defextconst $ioDrDirID	#x30)			; Directory ID
(defextconst $ioDrNmFls	#x34)			; Number of files in a directory
(defextconst $ioDrCrDat	#x48)			; Directory creation date
(defextconst $ioDrMdDat	#x4C)			; Directory modification date
(defextconst $ioDrBkDat	#x50)			; Directory backup date
(defextconst $ioDrFndrInfo	#x54)			; Directory finder info bytes
(defextconst $ioDrParID	#x64)			; Directory's parent directory ID

(defextconst $ioHFQElSiz	#x6C)			; Size of a Hierarchical File Queue Element

; Additional equates for _TFGetVolInfo:

(defextconst $ioVLsMod	#x22)			; Last modification date
(defextconst $ioVSigWord	#x40)			; Volume signature
(defextconst $ioVCBVBMst	#x2A)
(defextconst $ioVNxtCNID	#x3A)
(defextconst $ioVDrvInfo	#x42)			; Drive number (0 if volume is offline)
(defextconst $ioVDRefNum	#x44)			; Driver refNum
(defextconst $ioVFSID	#x46)			; ID of file system handling this volume
(defextconst $ioVBkup	#x48)			; Last backup date (0 if never backed up)
(defextconst $ioVSeqNum	#x4C)			; Sequence number of this volume in volume set
(defextconst $ioVWrCnt	#x4E)			; Volume write count
(defextconst $ioVFilCnt	#x52)			; Total number of files on volume
(defextconst $ioVDirCnt	#x56)			; Total number of directories on the volume
(defextconst $ioVFndrInfo	#x5A)			; Finder information for volume

(defextconst $ioHVQElSize	#x7A)			; Length of Hierarchical Volume information PB

; New fields for _GetFCBInfo:

(defextconst $ioFCBIndx	#x1C)	 ; FCB index for _GetFCBInfo
(defextconst $ioFCBFiller1	#x1E) 	 ; filler
(defextconst $ioFCBFlNm	#x20)	 ; File number
(defextconst $ioFCBFlags	#x24)	 ; FCB flags
(defextconst $ioFCBStBlk	#x26)	 ; File start block
(defextconst $ioFCBEOF	#x28)	 ; Logical end-of-file
(defextconst $ioFCBPLen	#x2C)	 ; Physical end-of-file
(defextconst $ioFCBCrPs	#x30)	 ; Current file position
(defextconst $ioFCBVRefNum	#x34)	 ; Volume refNum
(defextconst $ioFCBClpSiz	#x36)	 ; File clump size
(defextconst $ioFCBParID	#x3A)	 ; Parent directory ID

(defextconst $ioFCBQElSize	#x3E)	 ; extended size of FCBPBRec

; New fields for _GetWDInfo:

(defextconst $ioWDIndex	#x1A)			; Working Directory index for _GetWDInfo
(defextconst $ioWDProcID	#x1C)			; WD's ProcID (long)
(defextconst $ioWDVRefNum	#x20)			; WD's Volume RefNum (word)
(defextconst $ioWDDirID	#x30)			; WD's DirID (long)

; New fields for _FSControl call:

(defextconst $ioFSVrsn	#x20)			; File system version

; New field for CatMove

(defextconst $ioNewDirID	#x24)			;destination directory for CatMove

;
;--- End of New File System Equates ---

; Specific fields for device _Open

(defextconst $ioMix	#x1C)			; General purpose field imported by driver[long]
(defextconst $ioFlags	#x20)			; General purpose flags [word]
(defextconst $ioSlot	#x22)			; Slot [byte]
(defextconst $ioId	#x23)			; Id [byte]

(defextconst $ioSEBlkPtr	#x22)			; Pointer to the seBlock [long]

; ioFlags: 
(defextconst $fMulti	#x00)				; b0 = fMulti: ioSEBlkPtr is valid (ioSlot, ioId are invalid)

; Specific fields for _Control, _Status

(defextconst $csCode	#x1A) ; control/status code [word]
(defextconst $csParam	#x1C) ; operation-defined parameters [22 bytes]

; FInfo (Finder Information) record layout

(defextconst $fdType	#x20) ; type of file [long]
(defextconst $fdCreator	#x24) ; file's creator [long]
(defextconst $fdFlags	#x28) ; flags [word]
(defextconst $fdLocation	#x2A) ; file's location [point]
(defextconst $fdFldr	#x2E) ; file's window [word]

; added for HFS

; FXInfo record layout

(defextconst $fdIconID	#x54) ; Icon ID [word]
(defextconst $fdUnused	#x56) ; unused but reserved [4 words]
(defextconst $fdComment	#x5E) ; Comment ID [word]
(defextconst $fdPutAway	#x60) ; Home Dir ID [2 words]

; DInfo record layout

(defextconst $frRect	#x20) ; Folder Rect [4 words]
(defextconst $frFlags	#x28) ; Flags [word]
(defextconst $frLocation	#x2A) ; Location [2 words]
(defextconst $frView	#x2E) ; Folder view [word]

; DXInfo record layout

(defextconst $frScroll	#x54) ; scroll position [2 words]
(defextconst $frOpenChain	#x58) ; dirID chain of open folders [2 words]
(defextconst $frUnused	#x5C) ; unused but reserved [word]
(defextconst $frComment	#x5E) ; comment [word]
(defextconst $frPutAway	#x60) ; Dir ID [2 words]

;end of addition

; Masks for fdFlags field of FInfo record defined above

(defextconst $fOnDesk	1)
(defextconst $fHasBundle	8192) ; set if file has a bundle
(defextconst $fInvisible	16384) ; set if file's icon is invisible
(defextconst $fTrash	-3)	 ; file is in Trash window
(defextconst $fDeskTop	-2)	 ; file is on desktop
(defextconst $fDisk	0)	 ; file is in disk window

; File System Globals

(defextconst $DrvQHdr	#x308) ; queue header of drives in system [10 bytes]
(defextconst $BootDrive	#x210) ; drive number of boot drive [word]
(defextconst $EjectNotify	#x338) ; eject notify procedure [pointer]
(defextconst $IAZNotify	#x33C) ; world swaps notify procedure [pointer]
(defextconst $SFSaveDisk	#x214) ; last vRefNum seen by standard file [word]
(defextconst $CurDirStor	#x398) ; save dir across calls to Standard File [long]


;+ Date-Time record (for use with _Secs2Date, and _Date2Secs)


(defextconst $dtYear	#x0) ; year (1904..) [word]
(defextconst $dtMonth	#x2) ; month (1..12) [word]
(defextconst $dtDay	#x4) ; day (1..31) [word]
(defextconst $dtHour	#x6) ; hour (0..23) [word]
(defextconst $dtMinute	#x8) ; minute (0..59) [word]
(defextconst $dtSecond	#xA) ; second (0..59) [word]
(defextconst $dtDayOfWeek	#xC) ; day of week, sunday..saturday (1..7) [word]


;+ Miscellaneous stuff

(defextconst $OneOne	#xA02) ; constant $00010001 [long]
(defextconst $MinusOne	#xA06) ; constant $FFFFFFFF [long]
(defextconst $Lo3Bytes	#x31A) ; constant $00FFFFFF [long]

(defextconst $ROMBase	#x2AE) ; ROM base address [pointer]
(defextconst $RAMBase	#x2B2) ; RAM base address [pointer]
(defextconst $SysVersion	#x15A) ; version # of RAM-based system [word]
(defextconst $RndSeed	#x156) ; random seed/number [long]

; New fields for _GetDefaultStartup:	[DefStartRec]
				; SlotDev:
(defextconst $sdExtDevID	#x0)	 ; [byte]
(defextconst $sdPartition	#x1)	 ; [byte]
(defextconst $sdSlotNum	#x2)	 ; [byte]
(defextconst $sdSRsrcID	#x3)	 ; [byte]
				; SCSIDev:
(defextconst $sdReserved1	#x0)	 ; [byte]
(defextconst $sdReserved2	#x1)	 ; [byte]
(defextconst $sdRefNum	#x2)	 ; [word]

; New fields for _GetVideoDefault:	[DefVideoRec]

(defextconst $sdSlot	#x0)	 ; [byte]
(defextconst $sdSResource	#x1)	 ; [byte]

; New fields for _GetOSDefault:	[DefOSRec]

(defextconst $sdReserved	#x0)	 ; [byte]
(defextconst $sdOSType	#x1)	 ; [byte]

;+ SysEnvirons info
#|  ;In records.lisp
SysEnvRec		RECORD	0
environsVersion	DS.W	1
machineType		DS.W	1
systemVersion	DS.W	1
processor		DS.W	1
hasFPU			DS.B	1
hasColorQD		DS.B	1
keyBoardType	DS.W	1
atDrvrVersNum	DS.W	1
sysVRefNum		DS.W	1
				ALIGN	2
sysEnv1Size		EQU	*-SysEnvRec 	; size for version 1
				ENDR
|#
(defextconst $sysEnv1Size 16)

(defextconst $envMachUnknown	0)
(defextconst $env512KE	1)
(defextconst $envMacPlus	2)
(defextconst $envSE	3)
(defextconst $envMacII	4)
(defextconst $envMac	-1)	; for the glue (sigh)
(defextconst $envXL	-2)		; for the glue (double sigh)

(defextconst $envCPUUnknown	0)	; CPU types
(defextconst $env68000	1)
(defextconst $env68010	2)
(defextconst $env68020	3)

(defextconst $envUnknownKbd	0)	; Keyboard types
(defextconst $envMacKbd	1)
(defextconst $envMacAndPad	2)
(defextconst $envMacPlusKbd	3)
(defextconst $envAExtendKbd	4)
(defextconst $envStandADBKbd	5)


;+ Scratch Areas

(defextconst $scratch20	#x1E4) ; scratch [20 bytes]
(defextconst $scratch8	#x9FA) ; scratch [8 bytes]


;+ Scrap Manager

(defextconst $ScrapSize	#x960) ; scrap length [long]
(defextconst $ScrapHandle	#x964) ; memory scrap [handle]
(defextconst $ScrapCount	#x968) ; validation byte [word]
(defextconst $ScrapState	#x96A) ; scrap state [word]
(defextconst $ScrapName	#x96C) ; pointer to scrap name [pointer]


;+ Desk Accessories


; Message Definitions (in CSCode of control call)

(defextconst $accEvent	#x40) ; event message from SystemEvent
(defextconst $accRun	#x41) ; run message from SystemTask
(defextconst $accCursor	#x42) ; cursor message from SystemTask
(defextconst $accMenu	#x43) ; menu message from SystemMenu
(defextconst $accUndo	#x44) ; undo message from SystemEdit
(defextconst $accCut	#x46) ; cut message from SystemEdit
(defextconst $accCopy	#x47) ; copy message from SystemEdit
(defextconst $accPaste	#x48) ; paste message from SystemEdit
(defextconst $accClear	#x49) ; clear message from SystemEdit

(defextconst $goodBye	-1)	 ; goodbye message


;International stuff

(defextconst $IntlSpec	#xBA0)		; (long) - ptr to extra Intl data		

;Switcher

(defextconst $SwitcherTPtr	#x286)		; Switcher's switch table           

; Trap bits for memory manager

(defextconst $tSysOrCurZone	10) ; bit set implies System Zone
								 ; bit clear implies Current Zone
(defextconst $clearBit	9) ; bit set means clear allocated memory.


; Peripheral chips and Magic Hardware addresses

(defextconst $CPUFlag	#x12F)		; $00=68000, $01=68010, $02=68020 (old ROM inits to $00)
										; (this is old DskWr11 flag . . .)

; VIA (6522) interface chip

(defextconst $VIA	#x1D4) ; VIA base address [pointer]

; Disk Address

(defextconst $IWM	#x1E0) ; IWM base address [pointer]


; Interrupt secondary vectors

(defextconst $Lvl1DT	#x192) ; Interrupt level 1 dispatch table [32 bytes]
(defextconst $Lvl2DT	#x1B2) ; Interrupt level 2 dispatch table [32 bytes]
(defextconst $ExtStsDT	#x2BE) ; SCC ext/sts secondary dispatch table [16 bytes]



; Parameter Ram

(defextconst $SPValid	#x1F8) ; validation field ($A7) [byte]
(defextconst $SPATalkA	#x1F9) ; AppleTalk node number hint for port A
(defextconst $SPATalkB	#x1FA) ; AppleTalk node number hint for port B
(defextconst $SPAlarm	#x200) ; alarm time [long]
(defextconst $SPFont	#x204) ; default application font number minus 1 [word]
(defextconst $SPKbd	#x206) ; kbd repeat thresh in 4/60ths [2 4-bit]

(defextconst $SPPrint	#x207) ; print stuff [byte]
(defextconst $SPVolCtl	#x208) ; volume control [byte]
(defextconst $SPClikCaret	#x209) ; double click/caret time in 4/60ths[2 4-bit]

(defextconst $SPMisc1	#x20A) ; miscellaneous [1 byte]
(defextconst $SPMisc2	#x20B) ; miscellaneous [1 byte]

(defextconst $GetParam	#x1E4) ; system parameter scratch [20 bytes]
(defextconst $SysParam	#x1F8) ; system parameter memory [20 bytes]

; Cursor

(defextconst $CrsrThresh	#x8EC) ; delta threshold for mouse scaling [word]
(defextconst $JCrsrTask	#x8EE) ; address of CrsrVBLTask [long]
(defextconst $MTemp	#x828) ; Low-level interrupt mouse location [long]
(defextconst $RawMouse	#x82C) ; un-jerked mouse coordinates [long]
(defextconst $CrsrRect	#x83C) ; Cursor hit rectangle [8 bytes]
(defextconst $TheCrsr	#x844) ; Cursor data, mask & hotspot [68 bytes]
(defextconst $CrsrAddr	#x888) ; Address of data under cursor [long]
(defextconst $CrsrSave	#x88C) ; data under the cursor [64 bytes]
(defextconst $CrsrVis	#x8CC) ; Cursor visible? [byte]
(defextconst $CrsrBusy	#x8CD) ; Cursor locked out? [byte]
(defextconst $CrsrNew	#x8CE) ; Cursor changed? [byte]
(defextconst $CrsrState	#x8D0) ; Cursor nesting level [word]
(defextconst $CrsrObscure	#x8D2) ; Cursor obscure semaphore [byte]

; Mouse/Keyboard

(defextconst $KbdVars	#x216) ; Keyboard manager variables [4 bytes]
(defextconst $KbdType	#x21E) ; keyboard model number [byte]
(defextconst $MBState	#x172) ; current mouse button state [byte]
(defextconst $KeyMap	#x174) ; bitmap of the keyboard [2 longs]
(defextconst $KeypadMap	#x17C) ; bitmap for numeric pad-18bits [long]
(defextconst $Key1Trans	#x29E) ; keyboard translator procedure [pointer]
(defextconst $Key2Trans	#x2A2) ; numeric keypad translator procedure [pointer]
(defextconst $JGNEFilter	#x29A) ; GetNextEvent filter proc [pointer]
(defextconst $KeyMVars	#xB04) ; (word) for ROM KEYM proc state

(defextconst $Mouse	#x830) ; processed mouse coordinate [long]
(defextconst $CrsrPin	#x834) ; cursor pinning rectangle [8 bytes]
(defextconst $CrsrCouple	#x8CF) ; cursor coupled to mouse? [byte]
(defextconst $CrsrScale	#x8D3) ; cursor scaled? [byte]
(defextconst $MouseMask	#x8D6) ; V-H mask for ANDing with mouse [long]
(defextconst $MouseOffset	#x8DA) ; V-H offset for adding after ANDing [long]

; System Clocks

(defextconst $AlarmState	#x21F) ; Bit7=parity, Bit6=beeped, Bit0=enable [byte]


;+ Vertical Blanking Interrupt Handler

; VBL Block Queue Element

(defextconst $vType	1) ; VBL queue element is type 1
(defextconst $inVbl	6) ; bit index for "in VBL" flag

(defextconst $vblink	0) ; Link to next element [pointer]
(defextconst $vblType	4) ; Unique ID for validity [word]
(defextconst $vblAddr	6) ; service routine [pointer]
(defextconst $vblCount	#xA) ; timeout count [word]
(defextconst $vblPhase	#xC) ; phase count [word]

(defextconst $VBLQueue	#x160) ; VBL queue header [10 bytes]

; Event manager

(defextconst $jPlayCtl	16) ; playBack call
(defextconst $jRecordCtl	17) ; record call
(defextconst $jcTickCount	0) ; journal code for TickCount
(defextconst $jcGetMouse	1) ; journal code for GetMouse
(defextconst $jcButton	2) ; journal code for Button
(defextconst $jcGetKeys	3) ; journal code for GetKeys
(defextconst $jcEvent	4) ; journal code for GetNextEvent(Avail)

(defextconst $SysEvtMask	#x144) ; system event mask [word]
(defextconst $SysEvtBuf	#x146) ; system event queue element buffer [pointer]
(defextconst $EventQueue	#x14A) ; event queue header [10 bytes]
(defextconst $EvtBufCnt	#x154) ; max number of events in SysEvtBuf - 1 [word]

; Event Queue Element Data Stucture

(defextconst $evtQWhat	6) ; event code [word]
(defextconst $evtQMessage	8) ; event message [long]
(defextconst $evtQWhen	#xC) ; ticks since startup [long]
(defextconst $evtQWhere	#x10) ; mouse location [long]
(defextconst $evtQMeta	#x14) ; state of modifier keys [byte]
(defextconst $evtQMBut	#x15) ; state of mouse button [byte]
(defextconst $evtQBlkSize	#x16) ; size of event record counting queue info

; flags in flags field in heapzone header

(defextconst $fOnCheck	0) ; Turn On Checking
(defextconst $fChecking	1) ; Checking on
(defextconst $fNSelCompct	4) ; Use non-selective compact algorithm when 1.
(defextconst $fNoRvrAlloc	5) ; Don't use rover allocation scheme when 1.
(defextconst $fNSelPurge	6) ; Use non-selective purge algorithm when 1.
(defextconst $fRelAtEnd	7) ; MakeBk packs rels at end of free bk when 1.

(defextconst $ROZ	#x0) ; bit in flags field of MemMgr zone header

; Block Types

(defextconst $tybkMask	3) ; Mask for block type
(defextconst $tybkFree	0) ; Free Block
(defextconst $tybkNRel	1) ; Non-Relocatable
(defextconst $tybkRel	2) ; Relocatable

; Block Offsets

(defextconst $tagBC	0) ; Tag and Byte Count field [long]
(defextconst $handle	4) ; back pointer to master pointer [pointer]
(defextconst $blkData	8) ; data starts here

; Heap Zone header

(defextconst $bkLim	#x0) ; last block in zone [pointer]
(defextconst $purgePtr	#x4) ; roving purge placeholder [pointer]
(defextconst $hFstFree	#x8) ; first free handle [pointer]
(defextconst $zcbFree	#xC) ; # of free bytes in zone [long]
(defextconst $gzProc	#x10) ; grow zone procedure [pointer]
(defextconst $mAllocCnt	#x14) ; # of master ptrs to allocate [word]
(defextconst $flags	#x16) ; Flags [word]
(defextconst $cntRel	#x18) ; # of allocated relocatable blocks [word]
(defextconst $maxRel	#x1A) ; max # of allocated rel. blocks [word]
(defextconst $cntNRel	#x1C) ; # of allocated non-rel. blocks [word]
(defextconst $maxNRel	#x1E) ; max # of allocated non-rel. blocks [word]
(defextconst $cntEmpty	#x20) ; # of empty handles [word]
(defextconst $cntHandles	#x22) ; total # of handles [word]
(defextconst $minCBFree	#x24) ; min # of bytes free [long]
(defextconst $purgeProc	#x28) ; purge warning procedure [pointer]
(defextconst $allocPtr	#x30) ; roving allocator [pointer]
(defextconst $heapData	#x34) ; start of heap zone data



(defextconst $GZRootHnd	#x328) ; root handle for GrowZone [handle]
(defextconst $GZRootPtr	#x32C) ; root pointer for GrowZone [pointer]
(defextconst $GZMoveHnd	#x330) ; moving handle for GrowZone [handle]
(defextconst $MemTop	#x108) ; top of memory [pointer]
(defextconst $MmInOK	#x12E) ; initial memory mgr checks ok? [byte]
(defextconst $HpChk	#x316) ; heap check RAM code [pointer]
(defextconst $MaskBC	#x31A) ; Memory Manager Byte Count Mask [long]
(defextconst $MaskHandle	#x31A) ; Memory Manager Handle Mask [long]
(defextconst $MaskPtr	#x31A) ; Memory Manager Pointer Mask [long]
(defextconst $MinStack	#x31E) ; min stack size used in InitApplZone [long]
(defextconst $DefltStack	#x322) ; default size of stack [long]
(defextconst $MMDefFlags	#x326) ; default zone flags [word]

;+ System Error Handler

(defextconst $DSAlertTab	#x2BA) ; system error alerts [pointer]
(defextconst $DSAlertRect	#x3F8) ; rectangle for disk-switch alert [8 bytes]
(defextconst $DSDrawProc	#x334) ; alternate syserror draw procedure [pointer]
(defextconst $DSWndUpdate	#x15D) ; GNE not to paintBehind DS AlertRect? [byte]
(defextconst $WWExist	#x8F2) ; window manager initialized? [byte]
(defextconst $QDExist	#x8F3) ; quickdraw is initialized [byte]
(defextconst $ResumeProc	#xA8C) ; Resume procedure from InitDialogs [pointer]
(defextconst $DSErrCode	#xAF0) ; last system error alert ID

;+ Drivers

(defextconst $dskRfN	#xFFFB) ; 3.5" disk reference number
(defextconst $IntFlag	#x15F) ; reduce interrupt disable time when bit 7 = 0

; Serial I/O Driver

(defextconst $SerialVars	#x2D0) ; async driver variables [16 bytes]

(defextconst $PortAUse	#x290) ; bit 7: 1 = not in use, 0 = in use
								 ; bits 0-3: current use of port (see use type)
								 ; bits 4-6: user specific
(defextconst $PortBUse	#x291) ; port B use, same format as PortAUse
(defextconst $SCCASts	#x2CE) ; SCC read reg 0 last ext/sts rupt - A [byte]
(defextconst $SCCBSts	#x2CF) ; SCC read reg 0 last ext/sts rupt - B [byte]

; Serial handshake record definition

(defextconst $shFXOn	#x0) ; XOn/XOff output control flags [byte]
(defextconst $shFCTS	#x1) ; CTS hardware handshake flag [byte]
(defextconst $shXOn	#x2) ; XOn character [byte]
(defextconst $shXOff	#x3) ; XOff character [byte]
(defextconst $shErrs	#x4) ; errors that cause abort [byte]
(defextconst $shEvts	#x5) ; status changes that cause events [byte]
(defextconst $shFInX	#x6) ; XOn/XOff input flow control flag [byte]
(defextconst $shNull	#x7) ; not used [byte]

; Serial status record definition

(defextconst $ssCumErrs	#x0) ; cumulative errors [byte]
(defextconst $ssXOffSent	#x1) ; XOff sent as input control flag [byte]
(defextconst $ssRdPend	#x2) ; read pending flag [byte]
(defextconst $ssWrPend	#x3) ; write pending flag [byte]
(defextconst $ssCTSHold	#x4) ; CTS flow control hold flag [byte]
(defextconst $ssXOffHold	#x5) ; XOff received as output flow control [byte]

; Disk Driver

; Driver Code Header (for I/O drivers, desk accessories)

(defextconst $drvrFlags	#x0) ; various flags and permissions [word]
(defextconst $drvrDelay	#x2) ; # of ticks between systask calls [word]
(defextconst $drvrEMask	#x4) ; event mask [word]
(defextconst $drvrMenu	#x6) ; driver menu ID [word]
(defextconst $drvrOpen	#x8) ; open routine offset [word]
(defextconst $drvrPrime	#xA) ; prime routine offset [word]
(defextconst $drvrCtl	#xC) ; control routine offset [word]
(defextconst $drvrStatus	#xE) ; status routine offset [word]
(defextconst $drvrClose	#x10); warmstart reset routine offset [word]
(defextconst $drvrName	#x12); length byte and name of driver [string]
;(defextconst $drvrVersion	???)	 ; Driver w/ highest version # installed [word]
;	This field's offset varies depending upon the length
; of the Name field preceding it. It must be word aligned!

; Driver Status record definition

(defextconst $dsTrack	#x0) ; current track [word]
(defextconst $dsWriteProt	#x2) ; bit 7=1 if volume locked [byte]
(defextconst $dsDiskInPlace	#x3) ; disk in place [byte]
(defextconst $dsInstalled	#x4) ; drive installed [byte]
(defextconst $dsSides	#x5) ; bit 7=0 if single-sided drive [byte]
(defextconst $dsQLink	#x6) ; next queue entry [pointer]
(defextconst $dsDQVers	#xA) ; 1 for HD20 [word]
(defextconst $dsDQDrive	#xC) ; drive number [word]
(defextconst $dsDQRefNum	#xE) ; driver reference number [word]
(defextconst $dsDQFSID	#x10) ; file-system identifier [word]
(defextconst $dsTwoSideFmt	#x12) ; -1 if two-sided disk [byte]
(defextconst $dsDiskErrs	#x14) ; error count [word]

(defextconst $dsDrvSize	#x12)	;drive block size low word [word]
(defextconst $dsDrvS1	#x14)	;drive block size high word [word]
(defextconst $dsDrvType	#x16)	;1 for HD20 [word]
(defextconst $dsDrvManf	#x18)	;1 for Apple Computer, Inc [word]
(defextconst $dsDrvChar	#x1A)	;230 ($E6) for HD20 [word]
(defextconst $dsDrvMisc	#x1C)	;0 -- reserved [byte]


(defextconst $DskErr	#x142) ; disk routine result code [word]
(defextconst $PWMBuf2	#x312) ; PWM buffer 1 (or 2 if sound) [pointer]

; Drive command codes

(defextconst $dcRead	0)
(defextconst $dcWrite	1)
(defextconst $dcStatus	3)
(defextconst $dcInit	25)
(defextconst $dcScan	26)

; Sound Stuff

(defextconst $SoundPtr	#x262) ; 4VE sound definition table [pointer]
(defextconst $SoundBase	#x266) ; sound bitMap [pointer]
(defextconst $SoundVBL	#x26A) ; vertical retrace control element [16 bytes]
(defextconst $SoundDCE	#x27A) ; sound driver DCE [pointer]
(defextconst $SoundActive	#x27E) ; sound is active? [byte]
(defextconst $SoundLevel	#x27F) ; current level in buffer [byte]
(defextconst $CurPitch	#x280) ; current pitch value [word]

;  I/O System

(defextconst $noQueueBit	#x9) ; tells I/O system not to queue the request
(defextconst $asyncTrpBit	#xA) ; bit in high byte of trap specifying async

(defextconst $toExtFS	#x3F2)	; hook for external file systems

; File System Globals

(defextconst $DskVerify	#x12C) ; used by 3.5 disk driver for read/verify [byte]
(defextconst $TagData	#x2FA) ; sector tag info for disk drivers [14 bytes]
(defextconst $BufTgFNum	#x2FC) ; file number [long]
(defextconst $BufTgFFlg	#x300) ; flags [word]
(defextconst $BufTgFBkNum	#x302) ; logical block number [word]
(defextconst $BufTgDate	#x304) ; time stamp [word]

; I/O Command Equates for I/O Queue Elements (match trap numbers)

(defextconst $aRdCmd	2) ; read command
(defextconst $aWrCmd	3) ; write command
(defextconst $aCtlCmd	4) ; control command
(defextconst $aStsCmd	5) ; status command

; New fields for _SetPMSP call: PMSP = "Poor Man's Search Path"

(defextconst $ioPMSPFlg	#x1A)			; Flag whether to enable the PMSP
(defextconst $ioPMSPHook	#x1C)			; Pointer to PMSP hook proc

; Print variables

(defextconst $ScrDmpEnb	#x2F8) ; screen dump enabled? [byte]
(defextconst $ScrDmpType	#x2F9) ; FF dumps screen, FE dumps front window [byte]

; Scrap Variables

(defextconst $ScrapVars	#x960) ; scrap manager variables [32 bytes]
(defextconst $ScrapInfo	#x960) ; scrap length [long]
(defextconst $ScrapEnd	#x980) ; end of scrap vars
(defextconst $ScrapTag	#x970) ; scrap file name [STRING[15]]

; Segment Loader

(defextconst $LaunchFlag	#x902) ; from launch or chain [byte]
(defextconst $SaveSegHandle	#x930) ; seg 0 handle [handle]
(defextconst $CurJTOffset	#x934) ; current jump table offset [word]
(defextconst $CurPageOption	#x936) ; current page 2 configuration [word]
(defextconst $LoaderPBlock	#x93A) ; param block for ExitToShell [10 bytes]
(defextconst $CurApRefNum	#x900) ; refNum of application's resFile [word]
(defextconst $CurrentA5	#x904) ; current value of A5 [pointer]
(defextconst $CurStackBase	#x908) ; current stack base [pointer]
(defextconst $CurApName	#x910) ; name of application [STRING[31]]
(defextconst $LoadTrap	#x12D) ; trap before launch? [byte]

(defextconst $SegHiEnable	#xBB2)		; (byte) 0 to disable MoveHHi in LoadSeg

;device manager - Chooser message values

(defextconst $newSelMsg	12)		;a new selection has been made
(defextconst $fillListMsg	13)	;fill the list with choices to be made
(defextconst $getSelMsg	14)		;mark one or more choices as selcted
(defextconst $selectMsg	15)		;a choice has actually been made
(defextconst $deselectMsg	16)	;a choice has been canceled
(defextconst $terminateMsg	17)	;lets device package clean up
(defextconst $buttonMsg	19)		;a button has been clicked

(defextconst $psAlert	6)	;page setup alert bit in HiliteMode

(defextconst $theChooser	1)

; cdev message types
(defextconst $initDev	0)		; Time for cdev to initialize itself
(defextconst $hitDev	1)		; Hit on one of my items
(defextconst $closeDev	2)		; Close yourself
(defextconst $nulDev	3)		; Null event
(defextconst $updateDev	4)		; Update event
(defextconst $activDev	5)		; Activate event
(defextconst $deactivDev	6)		; Deactivate event
(defextconst $keyEvtDev	7)		; Key down/auto key
(defextconst $macDev	8)		; Decide whether or not to show up

; cdev error codes
(defextconst $cdevGenErr	-1)		; General error; gray cdev w/o alert
(defextconst $cdevMemErr	0)		; Memory shortfall; alert user please
(defextconst $cdevResErr	1)		; Couldn't get a needed resource; alert
(defextconst $cdevUnset	3)			; cdevValue is initialized to this


; Expanded Memory record
(defextconst $emVersion 0)			; version of expanded memory
(defextconst $emSize 2)				; length of em
(defextconst $emIntlGlobals 6)		; international globals pointer
(defextconst $emKeyDeadState 10)		; Key1Trans, Key2Trans dead state
(defextconst $emKeyCache 14)		; KCHR keyboard cache
(defextconst $emCurVersion	#x0101)	; version 1.1

) ;eval-when (eval compile)

(export (internal-sysequ-names))
(internal-sysequ-defs)

(provide "SYSEQU")

(eval-when (eval compile)
  (setq *internal-sysequ-defs () *internal-sysequ-names ()))
