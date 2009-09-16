; -*- Mode:Lisp; Package:CCL; -*-

; ToolEqu.lisp
; Lisp Transliteration of the files ToolEqu.a and SysErr.a

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

(in-package :ccl)

(eval-when (eval compile)

(setq *internal-toolequ-defs () *internal-toolequ-names ())

(let ((*warn-if-redefine* nil))
  (defmacro defextconst (name value)
    (list 'progn
          (list 'push (list 'quote (list 'define-constant (list 'quote name) value))
                '*internal-toolequ-defs)
          (list 'push (list 'quote name) '*internal-toolequ-names)))
  )
(defmacro internal-toolequ-defs ()
  (declare (special *internal-toolequ-defs))
  (list* 'eval-when '(eval load) *internal-toolequ-defs))
(defmacro internal-toolequ-names ()
  (declare (special *internal-toolequ-names))
  (list 'quote *internal-toolequ-names))

;
; File: ToolEqu.a
;
; Copyright Apple Computer, Inc.	1984-1987
; All Rights Reserved
;
; Toolbox Equates -- This file defines the high-level equates for the
;	Macintosh toolbox software.  This is divided into two pieces for assembly
;	space and speed considerations.  The wholeTools flag is used to include
;	the less common equates which realizes a complete set.	The comments
;	marked with ";+" denote managers.
;
;___________________________________________________________________________


;+ Resource Manager

; Resource attributes

(defextconst $resSysRef 7)	 ; reference to system/local reference
(defextconst $resSysHeap 6)	 ; In system/in application heap
(defextconst $resPurgeable 5)	 ; Purgeable/not purgeable
(defextconst $resLocked 4)	 ; Locked/not locked
(defextconst $resProtected 3)	 ; Protected/not protected
(defextconst $resPreload 2)	 ; Read in at OpenResource?
(defextconst $resChanged 1)	 ; Existing resource changed since last update

(defextconst $rcbMask #xFD)	 ; Must preserve ResChanged over _ResAttrs

; Map attributes

(defextconst $mapReadOnly 7)	 ; is this file read-only?
(defextconst $mapCompact 6)	 ; Is a compact necessary?
(defextconst $mapChanged 5)	 ; Is it necessary to write map?

; Resource Manager Globals

(defextconst $TopMapHndl #xA50)	 ; topmost map in list [handle]
(defextconst $SysMapHndl #xA54)	 ; system map [handle]
(defextconst $SysMap #xA58)	 ; reference number of system map [word]
(defextconst $CurMap #xA5A)	 ; reference number of current map [word]
(defextconst $ResReadOnly #xA5C)	 ; Read only flag [word]
(defextconst $ResLoad #xA5E)	 ; Auto-load feature [word]
(defextconst $ResErr #xA60)	 ; Resource error code [word]
(defextconst $ResErrProc #xAF2)	 ; Resource error procedure [pointer]
(defextconst $SysResName #xAD8)	 ; Name of system resource file [STRING[19]]

;new Resource Manager stuff

(defextconst $RomMapInsert #xB9E) 		; (byte) determines if we should link in map
(defextconst $TmpResLoad #xB9F) 		; second byte is temporary ResLoad value.	

; the following word values are to be placed into the
; word located at RomMapInsert

(defextconst $MapTrue #xFFFF)		; link in ROM map with resload true 	
(defextconst $MapFalse #xFF00)		; link in ROM map with resload false		

;+ Font Manager


; Standard font ID's

(defextconst $sysFont 0)	 ; system font ID
(defextconst $applFont 1)	 ; application font ID

(defextconst $newYork 2)	 ; standard release fonts
(defextconst $geneva 3)
(defextconst $monaco 4)
(defextconst $venice 5)
(defextconst $london 6)
(defextconst $athens 7)
(defextconst $sanFran 8)
(defextconst $toronto 9)
(defextconst $cairo 11)
(defextconst $losAngeles 12)
(defextconst $times 20)
(defextconst $helvetica 21)
(defextconst $courier 22)
(defextconst $symbol 23)
(defextconst $mobile 24)

; Font Manager Globals

(defextconst $ApFontID #x984)	 ; resource ID of application font [word]
(defextconst $FMDefaultSize #x987)	 ; default size [byte]
(defextconst $CurFMInput #x988)	 ; quickdraw FMInput Record [pointer]
(defextconst $FMgrOutRec #x998)	 ; quickdraw FontOutput Record [pointer]
(defextconst $FScaleDisable #xA63)	 ; disable font scaling? [byte]

;new FONT manager stuff

(defextconst $WidthListHand #x8E4) 		; list of extra width tables, or nil.	
(defextconst $WidthPtr #xB10) 		; (long) Font Mgr global
(defextconst $WidthTabHandle #xB2A) 		; Font width table handle for measure	
(defextconst $LastSPExtra #xB4C) 		; (long) most recent value of space extra	
(defextconst $SysFontFam #xBA6) 		; (word) System font family ID or zero		
(defextconst $SysFontSize #xBA8) 		; (word) System font size (or zero for 12 pt)
(defextconst $FDevDisable #xBB3) 		; (byte) $FF to disable device-defined style extra
(defextconst $LastFOND #xBC2) 		; (long) handle of last font def record
(defextconst $FONDID #xBC6) 		; (word) ID of last font def record
(defextconst $FractEnable #xBF4) 		; (byte) flag for fractional font widths	
(defextconst $UsedFWidths #xBF5) 		; (byte) flag saying if we used fract widths
(defextconst $FScaleHFact #xBF6) 		; (long) horz. font scale factor		
(defextconst $FScaleVFact #xBFA) 		; (long) vertical font scale factor 	

;+ Window Manager

								 ; system windows have negative kinds
(defextconst $dialogKind 2)	 ; dialog windows
(defextconst $userKind 8)	 ; this and above numbers are for user

; Values returned by window definition function's hit routine

(defextconst $wNoHit 0)	 ; not in window at all
(defextconst $wInContent 1)	 ; in content area
(defextconst $wInDrag 2)	 ; in drag area
(defextconst $wInGrow 3)	 ; in grow area
(defextconst $wInGoAway 4)	 ; in go away area
(defextconst $wInZoomIn 5)	 ; in zoom in
(defextconst $wInZoomOut 6)	 ; in zoom out

; FindWindow Return Codes

(defextconst $inDesk 0)	 ; not in any window
(defextconst $inMenuBar 1)	 ; in the menu bar
(defextconst $inSysWindow 2)	 ; in a system window
(defextconst $inContent 3)	 ; in content area of user window
(defextconst $inDrag 4)	 ; in drag area of user window
(defextconst $inGrow 5)	 ; in grow area of user window
(defextconst $inGoAway 6)	 ; in go away area of user window
(defextconst $inZoomIn 7)	 ; in zoom in part code
(defextconst $inZoomOut 8)	 ; in zoom out part code

; Resource ID's for windows

(defextconst $deskPatID 16)  ; desk pattern PAT ID

(defextconst $documentProc 0)	 ; standard document WDEF ID
(defextconst $dBoxProc 1)	 ; dialog box (document without titleBar) WDEF ID
(defextconst $plainDBox 2)	 ; no border WDEF ID
(defextconst $altDBoxProc 3)	 ; no shadow or title WDEF ID
(defextconst $noGrowDocProc 4)	 ; no grow area WDEF ID
(defextconst $zoomDocProc 8)	 ; with zoom box WDEF ID
(defextconst $zoomNoGrow 12)	 ; zoom with no grow box WDEF ID
(defextconst $rDocProc 16)	 ; document with rounded corners WDEF ID

; Window Data Structure Definition

(defextconst $windowPort 0)	 ; grafPort [108 bytes]
(defextconst $windowKind #x6C)	 ; type of window [word]
(defextconst $wVisible #x6E)	 ; visible flag [byte]
(defextconst $wHilited #x6F)	 ; select (hilite) flag [byte]
(defextconst $wGoAway #x70)	 ; has go away button [byte]
(defextconst $wZoom #x71)	 ; has zoom box [byte]
(defextconst $structRgn #x72)	 ; structure region of window [Handle]
(defextconst $contRgn #x76)	 ; content region of window [Handle]
(defextconst $updateRgn #x7A)	 ; update region of window [Handle]
(defextconst $windowDef #x7E)	 ; window definition procedure [Handle]
(defextconst $wDataHandle #x82)	 ; window proc-defined data [Handle]
(defextconst $wTitleHandle #x86)	 ; title string [Handle]
(defextconst $wTitleWidth #x8A)	 ; width in pixels of title string [word]
(defextconst $wControlList #x8C)	 ; control list of this window [handle]
(defextconst $nextWindow #x90)	 ; next window in z-ordered list [pointer]
(defextconst $windowPic #x94)	 ; picture handle for updates [handle]
(defextconst $wRefCon #x98)	 ; application use [long]
(defextconst $windowSize #x9C)	 ; size of window data structure

#|
WStateData 		RECORD	0
userState		DS.L	2		;Rect
stdState		DS.L	2		;Rect
				ENDR
|#

; Window Manager Globals

(defextconst $WindowList #x9D6)	 ; Z-ordered linked list of windows [pointer]
(defextconst $PaintWhite #x9DC)	 ; erase newly drawn windows? [word]
(defextconst $WMgrPort #x9DE)	 ; window manager's grafport [pointer]
(defextconst $GrayRgn #x9EE)	 ; rounded gray desk region [handle]
(defextconst $CurActivate #xA64)	 ; window slated for activate event [pointer]
(defextconst $CurDeactive #xA68)	 ; window slated for deactivate event [pointer]

(defextconst $DragHook #x9F6)	 ; user hook during dragging [pointer]
(defextconst $DeskPattern #xA3C)	 ; desk pattern [8 bytes]
(defextconst $DeskHook #xA6C)	 ; hook for painting the desk [pointer]
(defextconst $GhostWindow #xA84)	 ; window hidden from FrontWindow [pointer]



;+ Menu Manager

;  "ASCII" marks for menu characters

(defextconst $noMark 0)
(defextconst $commandMark #x11)	 ; command fan (cloverleaf)
(defextconst $checkMark #x12)	 ; check mark for menus
(defextconst $diamondMark #x13)	 ; diamond mark for menus
(defextconst $appleMark #x14)	 ; desk ornament menu title

; MenuList Data Structure Definition -- one per menuBar
						
						 ; 6 Byte header
(defextconst $lastMenu 0)	 ; number of bytes in this menuList [word]
(defextconst $lastRight 2)	 ; h coordinate of 1st free point in menuBar [word]
								 ; one of the following per menu
(defextconst $menuoH 0)	 ; menu handle [handle]
(defextconst $menuLeft 4)	 ; coordinate of left edge of menu [word]

; MenuInfo Data Structure -- one per menu

(defextconst $menuID 0)	 ; unique ID for each menuBar [word]
(defextconst $menuWidth 2)	 ; menu width [word]
(defextconst $menuHeight 4)	 ; menu height [word]
(defextconst $menuDefHandle 6)	 ; menu definition proc [handle]
(defextconst $menuEnable #xA)  ; enable flags, one bit/item [long]
(defextconst $menuData #xE)  ; menu item string [STRING]
(defextconst $menuBlkSize #xE)  ; size of a menu block plus dataString

; MenuString Data Structure -- one per menu item

(defextconst $itemIcon 0)	 ; icon byte
(defextconst $itemCmd 1)	 ; apple (command key) byte
(defextconst $itemMark 2)	 ; checkmark character byte
(defextconst $itemStyle 3)	 ; style byte

; Menu Manager Globals

(defextconst $MenuList #xA1C)	 ; current menuBar list structure [handle]
(defextconst $MenuFlash #xA24)	 ; flash feedback count [word]
(defextconst $MenuHook #xA30)	 ; user hook during menuSelect [pointer]
(defextconst $MBarEnable #xA20)	 ; menuBar enable for desk accessories[word]
(defextconst $MBarHook #xA2C)	 ; user hook during menuSelect [pointer]

;new Menu Manager stuff

(defextconst $MBarHeight #xBAA) 		; (word) height of menu bar (usually 20)

;+ Control Manager

; Part Codes

(defextconst $inButton 10)  ; in a push button
(defextconst $inCheckBox 11)  ; in a checkBox button
(defextconst $inUpButton 20)  ; in up button area of a dial
(defextconst $inDownButton 21)  ; in down button area of a dial
(defextconst $inPageUp 22)  ; in page up (gray) area of a dial
(defextconst $inPageDown 23)  ; in page down (gray) area of a dial
(defextconst $inThumb 129)	 ; in thumb area of a dial

; Constants for axis parameter of DragGrayRgn and DragControl

(defextconst $noConstraint 0)	 ; free form dragging
(defextconst $hAxisOnly 1)	 ; horizontally only
(defextconst $vAxisOnly 2)	 ; vertically only

; Resource ID's for controls

(defextconst $pushButProc 0)	 ; rounded-corner pushButtons CDEF ID
(defextconst $checkBoxProc 1)	 ; check-box type buttons CDEF ID
(defextconst $radioButProc 2)	 ; radio buttons  CDEF ID
(defextconst $scrollBarProc 16)  ; scrollBar CDEF ID
(defextconst $useWFont 8)	 ; add this to get window font CDEF ID

(defextconst $sBarPatID 17)  ; scrollBar pattern ID

; Control Template

(defextconst $nextControl #x0)  ; next control in the list [handle]
(defextconst $contrlOwner #x4)  ; owning window [pointer]
(defextconst $contrlRect #x8)  ; bounding rectangle [8 bytes]
(defextconst $contrlVis #x10)	 ; visible state [byte]
(defextconst $contrlHilite #x11)	 ; hilite state [byte]
(defextconst $contrlValue #x12)	 ; current value of control [word]
(defextconst $contrlMin #x14)	 ; minimum value of control [word]
(defextconst $contrlMax #x16)	 ; maximum value of control [word]
(defextconst $contrlDefHandle #x18)	 ; control definition procedure [handle]
(defextconst $contrlData #x1C)	 ; data for definition proc [handle]
(defextconst $contrlAction #x20)	 ; local actionProc [pointer]
(defextconst $contrlRFcon #x24)	 ; refcon defined by application [long]
(defextconst $contrlTitle #x28)	 ; title string [STRING]
(defextconst $contrlSize #x28)	 ; size of control data structure less title

; Control Manager Globals

(defextconst $DragPattern #xA34)	 ; DragTheRgn pattern [8 bytes]
(defextconst $DragFlag #xA44)	 ; implicit parameter to DragControl [word]
(defextconst $CurDragAction #xA46)	 ; implicit actionProc for dragControl [pointer]


;+ Text Edit


; Justification styles

(defextconst $teJustLeft 0)	 ; left justified text
(defextconst $teJustRight -1)	 ; right justified text
(defextconst $teJustCenter 1)	 ; center justified text
(defextconst $teForceLeft -2)	 ; for Arabic fonts, force left justification

; Text Edit Record

(defextconst $teDestRect #x0)  ; destination rectangle  [8 bytes]
(defextconst $teViewRect #x8)  ; view rectangle rectangle [8 bytes]

(defextconst $teSelRect #x10)	 ; select rectangle [8 bytes]
(defextconst $teLineHite #x18)	 ; lineheight [word]
(defextconst $teAscent #x1A)	 ; first baseline offset [word]
(defextconst $teSelPoint #x1C)	 ; selection point [long]

(defextconst $teSelStart #x20)	 ; selection start [word]
(defextconst $teSelEnd #x22)	 ; selection end [word]

(defextconst $teActive #x24)	 ; active [byte]

(defextconst $teWordBreak #x26)	 ; word break routine [pointer]
(defextconst $teClikProc #x2A)	 ; click loop routine [pointer]

(defextconst $teClikTime #x2E)	 ; time of last click [long]
(defextconst $teClikLoc #x32)	 ; location of double click [long]

(defextconst $teCarTime #x34)	 ; time for next caret toggle [long]
(defextconst $teCarOn #x38)	 ; is caret on? [byte]
(defextconst $teCarAct #x39)	 ; is caret active? [byte]
(defextconst $teJust #x3A)	 ; fill style [word]

(defextconst $teLength #x3C)	 ; length of text below [word]
(defextconst $teTextH #x3E)	 ; text [handle]

(defextconst $teRecBack #x42)	 ; unused [word]
(defextconst $teRecLine #x44)	 ; unused [word]
(defextconst $teLftClick #x46)	 ; click was to left? [byte]
(defextconst $teLftCaret #x47)	 ; caret was to left? [byte]

(defextconst $teCROnly #x48)	 ; <CR> only for line breaks? [byte]

(defextconst $teFontStuff #x4A)	 ; space for font specifier [8 bytes]
(defextconst $teFont #x4A)	 ; text font [word]
(defextconst $teFace #x4C)	 ; text face [word]
(defextconst $teMode #x4E)	 ; text mode [word]
(defextconst $teSize #x50)	 ; text size [word]
(defextconst $teGrafPort #x52)	 ; grafport for editting [pointer]

(defextconst $teHiHook #x56)	 ; hook for hilite routine [pointer]
(defextconst $teCarHook #x5A)	 ; hook for hilite routine [pointer]

(defextconst $teNLines #x5E)	 ; number of lines [word]
(defextconst $teLines #x60)	 ; line starts [words...]

(defextconst $teRecSize #x68)	 ; base size of a record w/o lines

; Text Edit Globals

(defextconst $TEScrpLength #xAB0)	 ; textEdit Scrap Length [word]
(defextconst $TEScrpHandle #xAB4)	 ; textEdit Scrap [handle]
(defextconst $TEWdBreak #xAF6)	 ; default word break routine [pointer]

;new TE stuff

(defextconst $WordRedraw #xBA5) 		; (byte) - used by TextEdit RecalDraw		
(defextconst $TESysJust #xBAC) 		; (word) system justification (intl. textEdit)
(defextconst $TEFlags  #x42)	; turn whole byte into bit flags
(defextconst $teFAutoPos 6)			; set this bit for auto position/scroll

;+ Dialog Manager

; Item codes in item list

(defextconst $userItem 0)	 ; application-defined (dialog only)
(defextconst $ctrlItem 4)	 ; must be added to following four items
(defextconst $btnCtrl 0)	 ; standard button
(defextconst $chkCtrl 1)	 ; standard check box
(defextconst $radCtrl 2)	 ; standard radio button
(defextconst $resCtrl 3)	 ; control defined in resource file
(defextconst $statText 8)	 ; static text
(defextconst $editText 16)  ; editable text (dialog only)
(defextconst $iconItem 32)  ; icon
(defextconst $picItem 64)  ; quickdraw picture
(defextconst $itemDisable 128)	 ; add to any of above to disable


; Generic buttons

(defextconst $okButton 1)	 ; OK button
(defextconst $cancelButton 2)	 ; Cancel button

; Alert/Dialog Resource ID's

(defextconst $stopIcon 0)	 ; stop icon ID
(defextconst $noteIcon 1)	 ; note icon ID
(defextconst $cautionIcon 2)	 ; caution icon ID

; Dialog Template

(defextconst $dBounds #x0) 	; dialog bounds rectangle
(defextconst $dWindProc #x8) 	; window proc ID
(defextconst $dVisible #xA) 	; visible flag
(defextconst $dGoAway #xC) 	; go away flag
(defextconst $dRefCon #xE) 	; reference constant
(defextconst $dItems #x12)	; item list ID and handle
(defextconst $dTitle #x14)	; dialog window title

; Alert Template

(defextconst $aBounds #x0) 	; alert box height and width
(defextconst $aItems #x8) 	; item list ID
(defextconst $aStages #xA) 	; stages word

; Dialog/Alert Window Record

(defextconst $dWindow #x0) 	 ; window record
(defextconst $items #x9C)	 ; Item list [handle]
(defextconst $teHandle #xA0)	 ; textEdit object [handle]
(defextconst $editField #xA4)	 ; current field being edited [word]
(defextconst $editOpen #xA6)	 ; is editting open? [word]
(defextconst $aDefItem #xA8)	 ; default item for alerts [word]
(defextconst $dWindLen #xAA)	 ; dialog record length

; In each item

(defextconst $itmHndl 0)	 ; handle to the item
(defextconst $itmRect #x4)  ; bounding rect of item
(defextconst $itmType #xC)  ; item type
(defextconst $itmData #xD)  ; item string, must be even length

; Dialog Manager Globals

(defextconst $ANumber #xA98)	 ; active alert ID [word]
(defextconst $ACount #xA9A)	 ; # times this alert called [word]
(defextconst $DABeeper #xA9C)	 ; beep routine [pointer]
(defextconst $DAStrings #xAA0)	 ; paramText substutution strings [4 handles]
(defextconst $DlgFont #xAFA)	 ; default dialog font ID [word]


;+ Package Globals


(defextconst $AppPacks #xAB8)	 ; packages' code [8 handles]


;+ Finder related Globals


(defextconst $FinderName #x2E0)	 ; "Finder" name [STRING[15]]
(defextconst $AppParmHandle #xAEC)	 ; handle to hold application parameters


;+ Miscellaneous Globals


(defextconst $ApplScratch #xA78)	 ; application scratch area [12 Bytes]
(defextconst $ToolScratch #x9CE)	 ; scratch area [8 bytes]
(defextconst $TempRect #x9FA)	 ; scratch rectangle [8 bytes]

; System Patterns

(defextconst $sysPatListID 0)		 ; ID of PAT# which contains 38 patterns

; Resource Manager

(defextconst $mCCMask #x60)	 ; mapCompact + mapChanged
(defextconst $mChMask #x20)	 ; mapChanged
(defextconst $mCoMask #x40)	 ; mapCompact

; Font Manager

; Font header values

(defextconst $propFont #x9000)	 ; proportional font type
(defextconst $prpFntH #x9001)	 ; with height table
(defextconst $prpFntW #x9002)	 ; with width table
(defextconst $prpFntHW #x9003)	 ; with height & width table

(defextconst $fixedFont #xB000)	 ; fixed-pitch font type
(defextconst $fxdFntH #xB001)	 ; with height table
(defextconst $fxdFntW #xB002)	 ; with width table
(defextconst $fxdFntHW #xB003)	 ; with height & width table

(defextconst $fontWid #xACB0)	 ; width-only font type

; control/status codes for linkage w/font manager

(defextconst $fMgrCtl1 8)	 ; printer drivers

; Font Header Data Record

(defextconst $fFontType 0)	 ; font type [word]
(defextconst $fFirstChar 2)	 ; ASCII code of first char [word]
(defextconst $fLastChar 4)	 ; ASCII code of last char [word]
(defextconst $fWidMax 6)	 ; maximum width of any char in pixels [word]
(defextconst $fKernMax 8)	 ; Negative of maximum character kern [word]
(defextconst $fNDescent 10)  ; negative of descent [word]
(defextconst $fFRectWidth 12)  ; width of font rectangle [word]
(defextconst $fFRectHeight 14)  ; height of font rectangle [word]
(defextconst $fOWTLoc 16)  ; offset to offset/width table [word]
(defextconst $fAscent 18)  ; ascent above baseline in pixels [word]
(defextconst $fDescent 20)  ; descent below baseline in pixels [word]
(defextconst $fLeading 22)  ; space between lines in pixels [word]
(defextconst $fRowWords 24)  ; row width of bit image / 2 [word]

; Font Manager Input Record (CurFMInput)

(defextconst $fmInFamily 0)	 ; family [word]
(defextconst $fmInSize 2)	 ; size [word]
(defextconst $fmInFace 4)	 ; face [word]
(defextconst $fmInNeedBits 5)	 ; needBits [byte]
(defextconst $fmInDevice 6)	 ; device number [byte]
(defextconst $fmInNumer 8)	 ; numerator of scale [fixed]
(defextconst $fmInDenom 12)  ; denominator of scale [fixed]


; Font Manager Output record (FMgrOutRec)

(defextconst $fmOutError 0)	 ; error code [word]
(defextconst $fmOutFontH 2)	 ; the actual font [handle]
(defextconst $fmOutBold 6)	 ; bolding factor [byte]
(defextconst $fmOutItalic 7)	 ; italic factor [byte]
(defextconst $fmOutULOffset 8)	 ; underline offset [byte]
(defextconst $fmOutULShadow 9)	 ; underline halo [byte]
(defextconst $fmOutULThick 10)  ; underline thickness [byte]
(defextconst $fmOutShadow 11)  ; shadow factor [byte]
(defextconst $fmOutExtra 12)  ; extra horizontal width [byte]
(defextconst $fmOutAscent 13)  ; height above baseline [byte]
(defextconst $fmOutDescent 14)  ; height below baseline [byte]
(defextconst $fmOutWidMax 15)  ; maximum width of character [byte]
(defextconst $fmOutLeading 16)  ; space between lines [byte]
(defextconst $fmOutNumer 18)  ; point for numerators of scale factor [long]
(defextconst $fmOutDenom 22)  ; point for denominators of scale factor [long]


;WidthTable data structure

(defextconst $widTabData 0)	   ;ARRAY[1..256] OF LONGINT character widths
(defextconst $widTabFont 1024)  ;Handle	font record used to build table
(defextconst $widthSExtra 1028)  ;LONGINT space extra used for table
(defextconst $widthStyle 1032)  ;LONGINT extra due to style
(defextconst $widthFID 1036)  ;INTEGER font family ID
(defextconst $widthFSize 1038)  ;INTEGER font size request
(defextconst $widthFace 1040)  ;INTEGER style (face) request
(defextconst $widthDevice 1042)  ;INTEGER device requested
(defextconst $widthVInScale 1044)  ;FIXED scale factors requested
(defextconst $widthHInScale 1048)  ;FIXED scale factors requested
(defextconst $widthAFID 1052)  ;INTEGER actual font family ID for table
(defextconst $widthFHand 1054)  ;Handle family record used to build up table
(defextconst $widthUsedFam 1058)  ;BOOLEAN used fixed point family widths
(defextconst $widthAFace 1059)  ;BYTE actual face produced
(defextconst $widthVOutput 1060)  ;INTEGER vertical scale output value
(defextconst $widthHOutput 1062)  ;INTEGER horizontal scale output value
(defextconst $widthVFactor 1064)  ;INTEGER vertical scale output value
(defextconst $widthHFactor 1066)  ;INTEGER horizontal scale output value
(defextconst $widthASize 1068)  ;INTEGER actual size of actual font used
(defextconst $widTabSize 1070)  ;INTEGER total size of table

; Font Family Definition

(defextconst $ffFlags 0)	 ; flags for family (word)
(defextconst $ffFamID 2)	 ; family ID number (word)
(defextconst $ffFirst 4)	 ; ASCII code of first character (word)
(defextconst $ffLast 6)	 ; ASCII code of last character (word)
(defextconst $ffAscent 8)	 ; maximum ascent expressed for 1 pt (word)
(defextconst $ffDescent 10)  ; maximum descent expressed for 1 pt (word)
(defextconst $ffLeading 12)  ; maximum leading expressed for 1 pt (word)
(defextconst $ffWidMax 14)  ; maximum widMax expressed for 1 pt (word)
(defextconst $ffWTabOff 16)  ; offset to width table (long)
(defextconst $ffKernOff 20)  ; offset to kerning table (long)
(defextconst $ffStylOff 24)  ; offset to style mapping table (long)
(defextconst $ffProperty 28)  ; style property info (12 words)
(defextconst $ffIntl 52)  ; reserved for international use (2 words)
(defextconst $ffVersion 56)  ; FOND version number

; Font Characterization Table

(defextconst $dpiVert 0)	 ; vertical dots per inch [word]
(defextconst $dpiHoriz 2)	 ; horizontal dots per inch [word]
(defextconst $boldChr 4)	 ; bold characteristics [3 bytes]
(defextconst $italChr 7)	 ; italic characteristics [3 bytes]
								 ; unused [3 bytes]
(defextconst $outlineChr 13)  ; outline characteristics [3 bytes]
(defextconst $shadowChr 16)  ; shadow characteristics [3 bytes]
(defextconst $condChr 19)  ; condensed characteristics [3 bytes]
(defextconst $extendChr 22)  ; extended characteristics [3 bytes]
(defextconst $underChr 25)  ; underline characteristics [3 bytes]

; Globals

(defextconst $CurFMFamily #x988)	 ; current font family
(defextconst $CurFMSize #x98A)	 ; current font size
(defextconst $CurFMFace #x98C)	 ; current font face
(defextconst $CurFMNeedBits #x98D)	 ; boolean specifying whether it needs strike
(defextconst $CurFMDevice #x98E)	 ; current font device
(defextconst $CurFMNumer #x990)	 ; current numerator of scale factor
(defextconst $CurFMDenom #x994)	 ; current denominator of scale factor

(defextconst $FOutRec #x998)	 ; Font Manager output record

(defextconst $FMDotsPerInch #x9B2)	 ; h,v dotsPerInch of current device
(defextconst $FMStyleTab #x9B6)	 ; style heuristic table supplied by device

(defextconst $RomFont0 #x980)	 ; system font [handle]
(defextconst $GotStrike #x986)	 ; Do we have the strike? [byte]


; Window Manager

; Window Definition Procedure Messages

(defextconst $wDrawMsg 0)	 ; draw yourself
(defextconst $wHitMsg 1)	 ; hit test
(defextconst $wCalcRgnMsg 2)	 ; recalculate your regions
(defextconst $wInitMsg 3)	 ; initialize yourself
(defextconst $wDisposeMsg 4)	 ; dispose any private data
(defextconst $wGrowMsg 5)	 ; drag out grow outline
(defextconst $wGIconMsg 6)	 ; draw the grow icon

(defextconst $OldStructure #x9E6)	 ; saved structure region [handle]
(defextconst $OldContent #x9EA)	 ; saved content region [handle]
(defextconst $SaveVisRgn #x9F2)	 ; temporarily saved visRegion [handle]
(defextconst $CurDeKind #xA22)	 ; window kind of deactivated window [word]
(defextconst $SaveUpdate #x9DA)	 ; Enable update accumulation? [word]

; Menu Manager

; Menu Definition Procedure Messages

(defextconst $mDrawMsg 0)	 ; draw yourself
(defextconst $mChooseMsg 1)	 ; select an item
(defextconst $mSizeMsg 2)	 ; calculate your size

; Menu Resource IDs

(defextconst $textMenuProc 0)	 ; standard text menu MDEF ID

(defextconst $TheMenu #xA26)	 ; ID of hilited menu [word]
(defextconst $SavedHandle #xA28)	 ; saved bits under a menu [handle]

;misc Menu stuff

(defextconst $MrMacHook #xA2C)	 ; Mr. Macintosh hook [pointer]

; Control manager

; Control Definition Procedure Messages

(defextconst $drawCtlMsg 0)	 ; draw message
(defextconst $hitCtlMsg 1)	 ; hit test message
(defextconst $calcCtlMsg 2)	 ; calc region message
(defextconst $newCtlMsg 3)	 ; init message
(defextconst $dispCtlMsg 4)	 ; dispose any private data message
(defextconst $posCtlMsg 5)	 ; adjust indicator position message
(defextconst $thumbCtlMsg 6)	 ; calculate rectangles for thumb dragging
(defextconst $dragCtlMsg 7)	 ; custom drag message
(defextconst $trackCtlMsg 8)	 ; track yourself message


; Text Edit

(defextconst $TEDoText #xA70)	 ; textEdit doText proc hook [pointer]
(defextconst $TERecal #xA74)	 ; textEdit recalText proc hook [pointer]

;stage definition--packed 2 to a byte, 4 stages in a word

(defextconst $volBits 3)	 ; number of beeps
(defextconst $alBit 4)	 ; alert bit (put up box this time?)
(defextconst $okDismissal 8)	 ; bit for OK/Cancel default in each stage

; DialogList Data Structure Definitions

(defextconst $dlgMaxIndex 0)	 ; maximum index (=items-1) stored here


(defextconst $SaveProc #xA90)	 ; address of Save failsafe procedure
(defextconst $SaveSP #xA94)	 ; Safe SP for restart or save

; Package Manager

(defextconst $FPState #xA4A)	 ; floating point state [6 bytes]
(defextconst $App2Packs #xBC8) 		; $BC8-$BE7 eight more package handles

; Resource Manager

(defextconst $RMGRPerm #xBA4) 	 ; (byte) - permission byte for OpenResFile

; Miscellaneous Constants

(defextconst $screenRadius #x00100010) ; rounded corners for desk area

; Miscellaneous Globals

(defextconst $IconBitmap #xA0E)	 ; bitmap used for plotting things
(defextconst $TaskLock #xA62)	 ; re-entering SystemTask [byte]
(defextconst $CloseOrnHook #xA88)	 ; hook for closing desk ornaments

;new MacApp stuff

(defextconst $MAErrProc #xBE8) 		; (long) MacApp error proc address
(defextconst $MASuperTab #xBEC) 		; (long) handle to MacApp superclass table


;**************** NEW TOOL EQUATES ************

; Font Manager

; addition to FMgrOutRec (was unused)

(defextconst $fmOutCurStyle 17)			;style algorthmically applied by QuickDraw

;___________________________________________________________________________
;
; Window Manager

; auxWinRec structure

(defextconst $awNext #x0)			;next in chain	[Handle]
(defextconst $awOwner #x4)			;owner ID		[WindowPtr]
(defextconst $awCTable #x8)			;color table	[CTabHandle]
(defextconst $dialogCTable #xC)          ;handle to dialog manager structures    [handle]
(defextconst $awFlags #x10)         ;handle for Ernie   [handle]
(defextconst $awResrv #x14)			;for expansion	[longint]
(defextconst $awRefCon #x18)			;user constant	[longint]
(defextconst $auxWinSize #x1C)			;size of record

(defextconst $AuxWinHead #x0CD0)		;[handle] Window Aux List head  

; Window Part Identifiers which correlate color table entries with window elements

(defextconst $wContentColor 0)
(defextconst $wFrameColor 1)
(defextconst $wTextColor 2)
(defextconst $wHiliteColor 3)
(defextconst $wTitleBarColor 4)


;___________________________________________________________________________
;
; Control Manager

; auxCtlRec structure

(defextconst $acNext #x0)			;next in chain	[AuxCtlHndl]
(defextconst $acOwner #x4)			;owner ID		[ControlHandle]
(defextconst $acCTable #x8)			;color table	[CCTabHandle]
(defextconst $acFlags #xC)			;misc flag byte	[word]
(defextconst $acReserved #xE)			;for expansion	[LONGINT]
(defextconst $acRefCon #x12)			;user constant	[LONGINT]
(defextconst $acSize #x16)			;size of record

(defextconst $AuxCtlHead #x0CD4)		;[handle] Control Aux List head

;  Here are some equates for the colors of control parts

(defextconst $cFrameColor 0)
(defextconst $cBodyColor 1)
(defextconst $cTextColor 2)
(defextconst $cThumbColor 3)

;___________________________________________________________________________
;
; Menu Manager

(defextconst $MenuDisable #x0B54)				; menuID and Item when disabled item selected
(defextconst $MBDFHndl #x0B58)				; handle to current menu bar defproc
(defextconst $MBSaveLoc #x0B5C)				; handle to the mbarproc private data
(defextconst $MenuCInfo #x0D50)				; hanel to menu color information table

; The following two equates have never been defined in an equate file, they were in 
; the mdefproc.  The locations $B26 and $B26 were orginally used, and built in to
; the MacPlus and Alladdin Roms, but since scrolling had to work on 64K ROM machines
; $A0A and $A0C were chosen for that.  Hence forth the following values will be used.

(defextconst $TopMenuItem #xA0A)			; pixel value of top of scrollable menu
(defextconst $AtMenuBottom #xA0C)			; pixel value of bottom of scrollable menu

;
; color menu table equates (mct = menu color table)
;
(defextconst $mctID #x0)
(defextconst $mctItem #x2)
(defextconst $mctRGB1 #x4)
(defextconst $mctRGB2 #xA)
(defextconst $mctRGB3 #x10)
(defextconst $mctRGB4 #x16)
(defextconst $mctReserved #x1C)
(defextconst $mctEntrySize #x1E)

;
; miscellaneous equates for hierarchical menus
;

(defextconst $hMenuCmd #x1B)	; itemCmd == $1B ==> hierarchical menu for this 
(defextconst $hierMenu -1)	; InsertMenu(handle, hierMenu), when beforeID ==
							; hierMenu, the handle is inserted in the
							; hierarchical menuList
(defextconst $mPopUpMsg 3)	; menu defProc messages - place yourself

;
; miscellaneous menubar equates
;
(defextconst $mbMenu1Loc #xA)	; first menu is 10 pixels from left side of screen

;
; color menu table search (and destroy) messages (mct = menu color table)
;
(defextconst $mctAllItems -98)	; search for all Items for the given ID
(defextconst $mctLastIDIndic -99)	; last entry in color table has this in ID field

;___________________________________________________________________________
;
; Text Edit

; Set/Replace style modes

(defextconst $fontBit 0)					; set font
(defextconst $faceBit 1)					; set face
(defextconst $sizeBit 2)					; set size
(defextconst $clrBit 3)					; set color
(defextconst $addSizeBit 4)					; add size mode

; handle to style record
	
(defextconst $teStylesH #x4A)				; replaces teFont/teFace

; offsets into TEStyleRec

(defextconst $nRuns #x0)					; [INTEGER] # of entries in styleStarts array
(defextconst $nStyles #x2)					; [INTEGER] # of distinct styles
(defextconst $styleTab #x4)					; [STHandle] handle to distinct styles
(defextconst $lhTab #x8)					; [LHHandle] handle to line heights
(defextconst $teRefCon #xC)					; [LONGINT] reserved
(defextconst $nullStyle #x10)					; [NullStHandle] to style set at null selection
(defextconst $runs #x14)					; array of styles

; offsets into NullStRec

(defextconst $teReserved 0)					; [LONGINT]	reserved for future expansion
(defextconst $nullScrap 4)					; [StScrpHandle] handle to scrap style table.

; offsets into StyleRun array

(defextconst $startChar 0)					; [INTEGER] offset into text to start of style
(defextconst $styleIndex 2)					; [INTEGER] style index

(defextconst $stStartSize 4)					; size of a styleStarts entry

; offsets into STElement

(defextconst $stCount 0)					; [INTEGER] # of times this style is used
(defextconst $stHeight 2)					; [INTEGER] line height
(defextconst $stAscent 4)					; [INTEGER] ascent
(defextconst $stFont 6)					; [INTEGER] font
(defextconst $stFace 8)					; [Style] face
(defextconst $stSize 10)					; [INTEGER] size
(defextconst $stColor 12)					; [RGBColor] color

(defextconst $stRecSize 18)					; size of a teStylesRec

; offsets into TextStyle

(defextconst $tsFont 0)					; [INTEGER] font
(defextconst $tsFace 2)					; [Style] face
(defextconst $tsSize 4)					; [INTEGER] size
(defextconst $tsColor 6)					; [RGBColor] color

(defextconst $styleSize 12)					; size of a StylRec

; offsets into StScrpRec

(defextconst $scrpNStyles 0)					; [INTEGER] # of styles in scrap
(defextconst $scrpStyleTab 2)					; [ScrpSTTable] start of scrap styles array

; offsets into scrpSTElement

(defextconst $scrpStartChar 0)					; [LONGINT] char where this style starts
(defextconst $scrpHeight 4)					; [INTEGER] line height
(defextconst $scrpAscent 6)					; [INTEGER] ascent
(defextconst $scrpFont 8)					; [INTEGER] font
(defextconst $scrpFace 10)					; [Style] face
(defextconst $scrpSize 12)					; [INTEGER] size
(defextconst $scrpColor 14)					; [RGBColor] color

(defextconst $scrpRecSize 20)					; size of a scrap record		

; File:SysErr.a
;
; Copyright Apple Computer, Inc.  1984-1987
; All Rights Reserved
;
; System Error Equates -- This file defines the equates for the Macintosh
;	return error codes	This is divided into two pieces for assembly
;	space and speed considerations.  The wholeErrors flag is used to include
;	the less common equates which realizes a complete set.
;___________________________________________________________________________

; General System Errors (VBL Mgr, Queueing, Etc.)

(defextconst $noErr 0)		 ; 0 for success
(defextconst $qErr -1) 	 	; queue element not found during deletion
(defextconst $vTypErr -2) 	 ; invalid queue element
(defextconst $corErr -3) 	 ; core routine number out of range
(defextconst $unimpErr -4) 	 ; unimplemented core routine
(defextconst $seNoDB -8) 	 ; no debugger installed to handle debugger command

; I/O System Errors

(defextconst $controlErr -17)
(defextconst $statusErr -18)
(defextconst $readErr -19)
(defextconst $writErr -20)
(defextconst $badUnitErr -21)
(defextconst $unitEmptyErr -22)
(defextconst $openErr -23)
(defextconst $closErr -24)
(defextconst $dRemovErr -25)	 ; tried to remove an open driver
(defextconst $dInstErr -26)	 ; DrvrInstall couldn't find driver in resources
(defextconst $abortErr -27)	 ; IO call aborted by KillIO
(defextconst $iIOAbortErr -27)	 ; IO abort error (Printing Manager)
(defextconst $notOpenErr -28)	 ; Couldn't rd/wr/ctl/sts cause driver not opened

;  File System error codes:

(defextconst $dirFulErr -33)	 ; Directory full
(defextconst $dskFulErr -34)	 ; disk full
(defextconst $nsvErr -35)	 ; no such volume
(defextconst $ioErr -36)	 ; I/O error (bummers)
(defextconst $bdNamErr -37)	 ; there may be no bad names in the final system!
(defextconst $fnOpnErr -38)	 ; File not open
(defextconst $eofErr -39)	 ; End of file
(defextconst $posErr -40)	 ; tried to position to before start of file (r/w)
(defextconst $mFulErr -41)	 ; memory full (open) or file won't fit (load)
(defextconst $tmfoErr -42)	 ; too many files open
(defextconst $fnfErr -43)	 ; File not found

(defextconst $wPrErr -44)	 ; diskette is write protected
(defextconst $fLckdErr -45)	 ; file is locked
(defextconst $vLckdErr -46)	 ; volume is locked
(defextconst $fBsyErr -47)	 ; File is busy (delete)
(defextconst $dupFNErr -48)	 ; duplicate filename (rename)
(defextconst $opWrErr -49)	 ; file already open with with write permission
(defextconst $paramErr -50)	 ; error in user parameter list
(defextconst $rfNumErr -51)	 ; refnum error
(defextconst $gfpErr -52)	 ; get file position error
(defextconst $volOffLinErr -53)	 ; volume not on line error (was Ejected)
(defextconst $permErr -54)	 ; permissions error (on file open)
(defextconst $volOnLinErr -55)	 ; drive volume already on-line at MountVol
(defextconst $nsDrvErr -56)	 ; no such drive (tried to mount a bad drive num)
(defextconst $noMacDskErr -57)	 ; not a mac diskette (sig bytes are wrong)
(defextconst $extFSErr -58)	 ; volume in question belongs to an external fs
(defextconst $fsRnErr -59)	 ; file system internal error:
							 ;	during rename the old entry was deleted but could
							 ;	 not be restored . . .
(defextconst $badMDBErr -60)	 ; bad master directory block
(defextconst $wrPermErr -61)	 ; write permissions error

; Font Manager Error Codes

(defextconst $fontDecError -64)	 ; error during font declaration
(defextconst $fontNotDeclared -65)	 ; font not declared
(defextconst $fontSubErr -66)	 ; font substitution occured

; Disk, Serial Ports, Clock Specific Errors

(defextconst $firstDskErr -84)
(defextconst $lastDskErr -64)

(defextconst $noDriveErr -64)	 ; drive not installed
(defextconst $offLinErr -65)	 ; r/w requested for an off-line drive

(defextconst $noNybErr -66)	 ; couldn't find 5 nybbles in 200 tries
(defextconst $noAdrMkErr -67)	 ; couldn't find valid addr mark
(defextconst $dataVerErr -68)	 ; read verify compare failed
(defextconst $badCksmErr -69)	 ; addr mark checksum didn't check
(defextconst $badBtSlpErr -70)	 ; bad addr mark bit slip nibbles
(defextconst $noDtaMkErr -71)	 ; couldn't find a data mark header
(defextconst $badDCksum -72)	 ; bad data mark checksum
(defextconst $badDBtSlp -73)	 ; bad data mark bit slip nibbles
(defextconst $wrUnderrun -74)	 ; write underrun occurred

(defextconst $cantStepErr -75)	 ; step handshake failed
(defextconst $tk0BadErr -76)	 ; track 0 detect doesn't change
(defextconst $initIWMErr -77)	 ; unable to initialize IWM
(defextconst $twoSideErr -78)	 ; tried to read 2nd side on a 1-sided drive
(defextconst $spdAdjErr -79)	 ; unable to correctly adjust disk speed
(defextconst $seekErr -80)	 ; track number wrong on address mark
(defextconst $sectNFErr -81)	 ; sector number never found on a track

(defextconst $fmt1Err -82)	 ; can't find sector 0 after track format
(defextconst $fmt2Err -83)	 ; can't get enough sync
(defextconst $verErr -84)	 ; track failed to verify


(defextconst $clkRdErr -85)	 ; unable to read same clock value twice
(defextconst $clkWrErr -86)	 ; time written did not verify
(defextconst $prWrErr -87)	 ; parameter ram written didn't read-verify
(defextconst $prInitErr -88)	 ; InitUtil found the parameter ram uninitialized

(defextconst $rcvrErr -89)	 ; SCC receiver error (framing, parity, OR)
(defextconst $breakRecd -90)	 ; Break received (SCC)

; AppleTalk error codes

(defextconst $ddpSktErr -91)	 ; error in soket number
(defextconst $ddpLenErr -92)	 ; data length too big
(defextconst $noBridgeErr -93)	 ; no network bridge for non-local send
(defextconst $lapProtErr -94)	 ; error in attaching/detaching protocol
(defextconst $excessCollsns -95)	 ; excessive collisions on write
(defextconst $portInUse -97)	 ; driver Open error code (port is in use)
(defextconst $portNotCf -98)	 ; driver Open error code (parameter RAM not
							 ; configured for this connection)
(defextconst $memROZErr -99)	 ; hard error in ROZ

; Scrap Manager error codes

(defextconst $noScrapErr -100)	 ; No scrap exists error
(defextconst $noTypeErr -102)	 ; No object of that type in scrap

; Storage allocator error codes

(defextconst $memFullErr -108)	 ; Not enough room in heap zone
(defextconst $nilHandleErr -109)	 ; Handle was NIL in HandleZone or other;
(defextconst $memWZErr -111)	 ; WhichZone failed (applied to free block);
(defextconst $memPurErr -112)	 ; trying to purge a locked or non-purgeable block;

(defextconst $memAdrErr -110)	 ; address was odd, or out of range;
(defextconst $memAZErr -113)	 ; Address in zone check failed;
(defextconst $memPCErr -114)	 ; Pointer Check failed;
(defextconst $memBCErr -115)	 ; Block Check failed;
(defextconst $memSCErr -116)	 ; Size Check failed;
(defextconst $memLockedErr -117)	 ; trying to move a locked block (MoveHHi)

; New system error codes :

(defextconst $dirNFErr -120)	 ; Directory not found
(defextconst $tmwdoErr -121)	 ; No free WDCB available
(defextconst $badMovErr -122)	 ; Move into offspring error
(defextconst $wrgVolTypErr -123)	 ; Wrong volume type error			
							 ; [operation not supported for MFS]		
(defextconst $volGoneErr -124)	 ; Server volume has been disconnected.

; Resource Manager error codes (other than I/O errors)

(defextconst $resNotFound -192)	 ; Resource not found
(defextconst $resFNotFound -193)	 ; Resource file not found
(defextconst $addResFailed -194)	 ; AddResource failed
(defextconst $addRefFailed -195)	 ; AddReference failed
(defextconst $rmvResFailed -196)	 ; RmveResource failed
(defextconst $rmvRefFailed -197)	 ; RmveReference failed
(defextconst $resAttrErr -198)	 ; attribute inconsistent with operation
(defextconst $mapReadErr -199)	 ; map inconsistent with operation

;______________________________________________________________
;
; some miscellaneous result codes

(defextconst $evtNotEnb 1)	 ; event not enabled at PostEvent

;  System Error Alert ID definitions.  These are just for reference because
;  one cannot intercept the calls and do anything programmatically...

(defextconst $dsSysErr 32767)	 ; general system error
(defextconst $dsBusError 1)		 ; bus error
(defextconst $dsAddressErr 2)		 ; address error
(defextconst $dsIllInstErr 3)		 ; illegal instruction error
(defextconst $dsZeroDivErr 4)		 ; zero divide error
(defextconst $dsChkErr 5)		 ; check trap error
(defextconst $dsOvflowErr 6)		 ; overflow trap error
(defextconst $dsPrivErr 7)		 ; privelege violation error
(defextconst $dsTraceErr 8)		 ; trace mode error
(defextconst $dsLineAErr 9)		 ; line 1010 trap error
(defextconst $dsLineFErr 10) 	 ; line 1111 trap error
(defextconst $dsMiscErr 11) 	 ; miscellaneous hardware exception error
(defextconst $dsCoreErr 12) 	 ; unimplemented core routine error
(defextconst $dsIrqErr 13) 	 ; uninstalled interrupt error

(defextconst $dsIOCoreErr 14) 	 ; IO Core Error
(defextconst $dsLoadErr 15) 	 ; Segment Loader Error
(defextconst $dsFPErr 16) 	 ; Floating point error

(defextconst $dsNoPackErr 17) 	 ; package 0 not present
(defextconst $dsNoPk1 18) 	 ; package 1 not present
(defextconst $dsNoPk2 19) 	 ; package 2 not present
(defextconst $dsNoPk3 20) 	 ; package 3 not present
(defextconst $dsNoPk4 21) 	 ; package 4 not present
(defextconst $dsNoPk5 22) 	 ; package 5 not present
(defextconst $dsNoPk6 23) 	 ; package 6 not present
(defextconst $dsNoPk7 24) 	 ; package 7 not present

(defextconst $dsMemFullErr 25) 	 ; out of memory!
(defextconst $dsBadLaunch 26) 	 ; can't launch file

(defextconst $dsFSErr 27) 	 ; file system map has been trashed
(defextconst $dsStknHeap 28) 	 ; stack has moved into application heap
(defextconst $dsReinsert 30) 	 ; request user to reinsert off-line volume
(defextconst $dsNotThe1 31) 	 ; not the disk I wanted
(defextconst $negZcbFreeErr 33) 	 ; ZcbFree has gone negative
(defextconst $shutDownAlert 42) 	 ; handled like a shutdown error
(defextconst $menuPrgErr 84) 	 ; happens when a menu is purged

; serial driver error masks
(defextconst $swOverrunErr 1)
(defextconst $parityErr 16)
(defextconst $hwOverrunErr 32)
(defextconst $framingErr 64)


;************ ADDITIONS MADE FOR NEW QUICKDRAW AND COLOR **************
; Note: the following error codes are also used but not documented anywhere obvious!!
;
; (defextconst $dsGreeting 40)                  ; welcome to Macintosh greeting
; (defextconst $dsFinderErr 41)                  ; can't load the Finder error
;

;Slot Declaration ROM Manager Errors

(defextconst $siInitSDTblErr 1)           ;slot int dispatch table could not be initialized.
(defextconst $siInitVBLQsErr 2)           ;VBLqueues for all slots could not be initialized.
(defextconst $siInitSPTblErr 3)           ;slot priority table could not be initialized.

(defextconst $sdmJTInitErr 10)       ;SDM Jump Table could not be initialized.
(defextconst $sdmInitErr 11)       ;SDM could not be initialized.
(defextconst $sdmSRTInitErr 12)       ;Slot Resource Table could not be initialized.
(defextconst $sdmPRAMInitErr 13)       ;Slot PRAM could not be initialized.
(defextconst $sdmPriInitErr 14)       ;Cards could not be initialized.
	
; Menu Manager Errors

(defextconst $dsMBarNFnd 85)
(defextconst $dsHMenuFindErr 86)

; Color Quickdraw & Color Manager Errors

(defextconst $cMatchErr -150)      ; Color2Index failed to find an index
(defextconst $cTempMemErr -151)      ; failed to allocate memory for temporary structures
(defextconst $cNoMemErr -152)      ; failed to allocate memory for structure
(defextconst $cRangeErr -153)      ; range error on colorTable request
(defextconst $cProtectErr -154)      ; colorTable entry protection violation
(defextconst $cDevErr -155)      ; invalid type of graphics device
(defextconst $cResErr -156)      ; invalid resolution for MakeITable

; errors for Color2Index/ITabMatch					

(defextconst $iTabPurgErr -9)
(defextconst $noColMatch -10)

; errors for MakeITable

(defextconst $qAllocErr -11)
(defextconst $tblAllocErr -12)
(defextconst $overRun -13)
(defextconst $noRoomErr -14)

; errors for SetEntry

(defextconst $seOutOfRange -15)
(defextconst $seProtErr -16)

(defextconst $i2CRangeErr -17)
(defextconst $gdBadDev -18)
(defextconst $reRangeErr -19)
(defextconst $seInvRequest -20)
(defextconst $seNoMemErr -21)

;more errors

(defextconst $unitTblFullErr -29)	 		; unit table has no more entries
(defextconst $dceExtErr -30)	 		; dce extension error
(defextconst $dsBadSlotInt 51)          ; unserviceable slot interrupt
(defextconst $dsBadSANEopcode 81)          ; bad opcode given to SANE Pack4

(defextconst $memROZWarn -99) 		; soft error in ROZ
(defextconst $memROZError -99) 		; hard error in ROZ

(defextconst $updPixMemErr -125)		;insufficient memory to update a pixmap

;Menu Manager

(defextconst $mBarNFnd -126)		; system error code for MBDF not found
(defextconst $hMenuFindErr -127)        ; could not find HMenu's parent in MenuKey

;Sound Manager Error Returns 

(defextconst $noHardware -200)
(defextconst $notEnoughHardware -201)
(defextconst $queueFull -203)
(defextconst $resProblem -204)
(defextconst $badChannel -205)
(defextconst $badFormat -206)


;---The following errors may be generated during system Init. If they are,
;   they will be logged into the sInfo array and returned each time a call
;   to the slot manager is made (for the card wich generated the error).

;Errors specific to the start mgr.
(defextconst $smSDMInitErr -290)		;Error, SDM could not be initialized.
(defextconst $smSRTInitErr -291)		;Error, Slot Resource Table could not be initialized.
(defextconst $smPRAMInitErr -292)		;Error, Slot Resource Table could not be initialized.
(defextconst $smPriInitErr -293)		;Error, Cards could not be initialized.

(defextconst $smEmptySlot -300)		;No card in slot   							
(defextconst $smCRCFail -301)		;CRC check failed for declaration data		
(defextconst $smFormatErr -302)		;FHeader Format is not Apple's				
(defextconst $smRevisionErr -303)		;Wrong revison level						
(defextconst $smNoDir -304)		;Directory offset is Nil					
(defextconst $smLWTstBad -305)		;Long Word test field <> $5A932BC7.		
(defextconst $smNosInfoArray -306)		;No sInfoArray. Memory Mgr error.		
(defextconst $smResrvErr -307)		;Fatal reserved error. Resreved field <> 0.
(defextconst $smUnExBusErr -308)		;Unexpected BusError	
(defextconst $smBLFieldBad -309)		;ByteLanes field was bad.
(defextconst $smFHBlockRdErr -310)		;Error occured during _sGetFHeader.
(defextconst $smFHBlkDispErr -311)		;Error occured during _sDisposePtr (Dispose of FHeader block).
(defextconst $smDisposePErr -312)		;_DisposePointer error
(defextconst $smNoBoardsRsrc -313)		;No Board sResource.
(defextconst $smGetPRErr -314)		;Error occured during _sGetPRAMRec (See SIMStatus).
(defextconst $smNoBoardId -315)		;No Board Id.
(defextconst $smIntStatVErr -316)		;The InitStatusV field was negative after primary or secondary init.
(defextconst $smIntTblVErr -317)		;An error occured while trying to initialize the Slot Resource Table.
(defextconst $smNoJmpTbl -318)        ;SDM jump table could not be created.
(defextconst $smBadBoardId -319)        ;BoardId was wrong, re-init the PRAM record.
(defextconst $smBusErrTO -320)        ;BusError time out.


;---The following errors may be generated at any time after system Init and will not
;   be logged into the sInfo array.

(defextconst $smBadRefId -330)		;Reference Id not found in List				
(defextconst $smBadsList -331)		;Bad sList: Id1 < Id2 < Id3 ...  format is not followed.
(defextconst $smReservedErr -332)		;Reserved field not zero					
(defextconst $smCodeRevErr -333)		;Code revision is wrong						
(defextconst $smCPUErr -334)		;Code revision is wrong
(defextconst $smsPointerNil -335)		;LPointer is nil {From sOffsetData. If this error occurs, check sInfo rec for more information.}
(defextconst $smNilsBlockErr -336)		;Nil sBlock error {Dont allocate and try to use a nil sBlock}
(defextconst $smSlotOOBErr -337)		;Slot out of bounds error
(defextconst $smSelOOBErr -338)		;Selector out of bounds error
(defextconst $smNewPErr -339)		;_NewPtr error
(defextconst $smBlkMoveErr -340)		;_BlockMove error
(defextconst $smCkStatusErr -341)		;Status of slot = fail.
(defextconst $smGetDrvrNamErr -342)		;Error occured during _sGetDrvrName.
(defextconst $smDisDrvrNamErr -343)		;Error occured during _sDisDrvrName.
(defextconst $smNoMoresRsrcs -344)		;No more sResources
(defextconst $smsGetDrvrErr -345)		;Error occurred during _sGetDriver.
(defextconst $smBadsPtrErr -346)		;Bad pointer was passed to sCalcsPointer
(defextconst $smByteLanesErr -347)		;NumByteLanes was determined to be zero.
(defextconst $smOffsetErr -348)		;Offset was too big (temporary error, should be fixed)
(defextconst $smNoGoodOpens -349)		;No opens were successfull in the loop.	
(defextconst $smSRTOvrFlErr -350)        ;SRT over flow.
(defextconst $smRecNotFnd -351)        ;Record not found in the SRT.


;Device Manager Slot Support Error

(defextconst $slotNumErr -360)	; invalid slot # error


; AppleTalk - NBP error codes

(defextconst $nbpBuffOvr -1024)	 ; Buffer overflow in LookupName
(defextconst $nbpNoConfirm -1025)	 ; Name not confirmed on ConfirmName
(defextconst $nbpConfDiff -1026)	 ; Name confirmed at different socket
(defextconst $nbpDuplicate -1027)	 ; Duplicate name exists already
(defextconst $nbpNotFound -1028)	 ; Name not found on remove
(defextconst $nbpNISErr -1029)	 ; Error trying to open the NIS

; ASP errors codes (XPP driver)

(defextconst $aspBadVersNum -1066)   ; Server cannot support this ASP version
(defextconst $aspBufTooSmall -1067)   ; Buffer too small
(defextconst $aspNoMoreSess -1068)   ; No more sessions on server
(defextconst $aspNoServers -1069)   ; No servers at that address
(defextconst $aspParamErr -1070)   ; Parameter error
(defextconst $aspServerBusy -1071)   ; Server cannot open another session
(defextconst $aspSessClosed -1072)   ; Session closed
(defextconst $aspSizeErr -1073)   ; Command block too big
(defextconst $aspTooMany -1074)   ; Too many clients (server error)
(defextconst $aspNoAck -1075)   ; No ack on attention request (server err)

;AppleTalk -  ATP error codes

(defextconst $reqFailed -1096)	 ; SendRequest failed: retry count exceeded
(defextconst $tooManyReqs -1097)	 ; Too many concurrent requests
(defextconst $tooManySkts -1098)	 ; Too many concurrent responding-sockets
(defextconst $badATPSkt -1099)	 ; Bad ATP-responding socket
(defextconst $badBuffNum -1100)	 ; Bad response buffer number specififed
(defextconst $noRelErr -1101)	 ; No release received
(defextconst $cbNotFound -1102)	 ; Control Block (TCB or RspCB) not found
(defextconst $noSendResp -1103)	 ; AddResponse issued without SendResponse
(defextconst $noDataArea -1104)	 ; No data area for request to MPP
(defextconst $reqAborted -1105)	 ; SendRequest aborted by RelTCB

(defextconst $buf2SmallErr -3101)
(defextconst $noMPPErr -3102)
(defextconst $ckSumErr -3103)
(defextconst $extractErr -3104)
(defextconst $readQErr -3105)
(defextconst $atpLenErr -3106)
(defextconst $atpBadRsp -3107)
(defextconst $recNotFnd -3108)
(defextconst $sktClosedErr -3109)

; AFP errors codes (XPP driver)

(defextconst $afpAccessDenied -5000)		;        { $EC78 }
(defextconst $afpAuthContinue -5001)		;        { $EC77 }
(defextconst $afpBadUAM -5002)		;        { $EC76 }
(defextconst $afpBadVersNum -5003)		;        { $EC75 }
(defextconst $afpBitmapErr -5004)		;        { $EC74 }
(defextconst $afpCantMove -5005)		;        { $EC73 }
(defextconst $afpDenyConflict -5006)		;        { $EC72 }
(defextconst $afpDirNotEmpty -5007)		;        { $EC71 }
(defextconst $afpDiskFull -5008)		;        { $EC70 }
(defextconst $afpEofError -5009)		;        { $EC6F }
(defextconst $afpFileBusy -5010)		;        { $EC6E }
(defextconst $afpFlatVol -5011)		;        { $EC6D }
(defextconst $afpItemNotFound -5012)		;        { $EC6C }
(defextconst $afpLockErr -5013)		;        { $EC6B }
(defextconst $afpMiscErr -5014)		;        { $EC6A }
(defextconst $afpNoMoreLocks -5015)		;        { $EC69 }
(defextconst $afpNoServer -5016)		;        { $EC68 }
(defextconst $afpObjectExists -5017)		;        { $EC67 }
(defextconst $afpObjectNotFound -5018)		;        { $EC66 }
(defextconst $afpParmErr -5019)		;        { $EC65 }
(defextconst $afpRangeNotLocked -5020)		;        { $EC64 }
(defextconst $afpRangeOverlap -5021)		;        { $EC63 }
(defextconst $afpSessClosed -5022)		;        { $EC62 }
(defextconst $afpUserNotAuth -5023)		;        { $EC61 }
(defextconst $afpCallNotSupported -5024)		;        { $EC60 }
(defextconst $afpObjectTypeErr -5025)		;        { $EC5F }
(defextconst $afpTooManyFilesOpen -5026)		;        { $EC5E }
(defextconst $afpServerGoingDown -5027)		;        { $EC5D }
(defextconst $afpCantRename -5028)		;        { $EC5C }
(defextconst $afpDirNotFound -5029)		;		 { $EC5B }
(defextconst $afpIconTypeError -5030)		;        { $EC5A }

; SysEnvirons Errors

(defextconst $envNotPresent -5500) 			; returned by glue.
(defextconst $envBadVers -5501) 			; Version non-positive
(defextconst $envVersTooBig -5502) 			; Version bigger than call can handle


) ;eval-when (eval compile)

(export (internal-toolequ-names))
(internal-toolequ-defs)

(provide "TOOLEQU")

(eval-when (eval compile)
  (setq *internal-toolequ-defs () *internal-toolequ-names ()))
