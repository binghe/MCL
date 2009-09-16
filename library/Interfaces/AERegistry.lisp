(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AERegistry.h"
; at Sunday July 2,2006 7:24:26 pm.
; 
;      File:       AE/AERegistry.h
;  
;      Contains:   AppleEvents Registry Interface.
;  
;      Version:    AppleEvents-275~1
;  
;      Copyright:  © 1993-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AEREGISTRY__
; #define __AEREGISTRY__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __APPLEEVENTS__
#| #|
#include <AEAppleEvents.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k

(defconstant $cAEList :|list|)                  ;   0x6c697374  

(defconstant $cApplication :|capp|)             ;   0x63617070  

(defconstant $cArc :|carc|)                     ;   0x63617263  

(defconstant $cBoolean :|bool|)                 ;   0x626f6f6c  

(defconstant $cCell :|ccel|)                    ;   0x6363656c  

(defconstant $cChar :|cha |)                    ;   0x63686120  

(defconstant $cColorTable :|clrt|)              ;   0x636c7274  

(defconstant $cColumn :|ccol|)                  ;   0x63636f6c  

(defconstant $cDocument :|docu|)                ;   0x646f6375  

(defconstant $cDrawingArea :|cdrw|)             ;   0x63647277  

(defconstant $cEnumeration :|enum|)             ;   0x656e756d  

(defconstant $cFile :|file|)                    ;   0x66696c65  

(defconstant $cFixed :|fixd|)                   ;   0x66697864  

(defconstant $cFixedPoint :|fpnt|)              ;   0x66706e74  

(defconstant $cFixedRectangle :|frct|)          ;   0x66726374  

(defconstant $cGraphicLine :|glin|)             ;   0x676c696e  

(defconstant $cGraphicObject :|cgob|)           ;   0x63676f62  

(defconstant $cGraphicShape :|cgsh|)            ;   0x63677368  

(defconstant $cGraphicText :|cgtx|)             ;   0x63677478  

(defconstant $cGroupedGraphic :|cpic|)          ;   0x63706963  


(defconstant $cInsertionLoc :|insl|)            ;   0x696e736c  

(defconstant $cInsertionPoint :|cins|)          ;   0x63696e73  

(defconstant $cIntlText :|itxt|)                ;   0x69747874  

(defconstant $cIntlWritingCode :|intl|)         ;   0x696e746c  

(defconstant $cItem :|citm|)                    ;   0x6369746d  

(defconstant $cLine :|clin|)                    ;   0x636c696e  

(defconstant $cLongDateTime :|ldt |)            ;   0x6c647420  

(defconstant $cLongFixed :|lfxd|)               ;   0x6c667864  

(defconstant $cLongFixedPoint :|lfpt|)          ;   0x6c667074  

(defconstant $cLongFixedRectangle :|lfrc|)      ;   0x6c667263  

(defconstant $cLongInteger :|long|)             ;   0x6c6f6e67  

(defconstant $cLongPoint :|lpnt|)               ;   0x6c706e74  

(defconstant $cLongRectangle :|lrct|)           ;   0x6c726374  

(defconstant $cMachineLoc :|mLoc|)              ;   0x6d4c6f63  

(defconstant $cMenu :|cmnu|)                    ;   0x636d6e75  

(defconstant $cMenuItem :|cmen|)                ;   0x636d656e  

(defconstant $cObject :|cobj|)                  ;   0x636f626a  

(defconstant $cObjectSpecifier :|obj |)         ;   0x6f626a20  

(defconstant $cOpenableObject :|coob|)          ;   0x636f6f62  

(defconstant $cOval :|covl|)                    ;   0x636f766c  


(defconstant $cParagraph :|cpar|)               ;   0x63706172  

(defconstant $cPICT :|PICT|)                    ;   0x50494354  

(defconstant $cPixel :|cpxl|)                   ;   0x6370786c  

(defconstant $cPixelMap :|cpix|)                ;   0x63706978  

(defconstant $cPolygon :|cpgn|)                 ;   0x6370676e  

(defconstant $cProperty :|prop|)                ;   0x70726f70  

(defconstant $cQDPoint :|QDpt|)                 ;   0x51447074  

(defconstant $cQDRectangle :|qdrt|)             ;   0x71647274  

(defconstant $cRectangle :|crec|)               ;   0x63726563  

(defconstant $cRGBColor :|cRGB|)                ;   0x63524742  

(defconstant $cRotation :|trot|)                ;   0x74726f74  

(defconstant $cRoundedRectangle :|crrc|)        ;   0x63727263  

(defconstant $cRow :|crow|)                     ;   0x63726f77  

(defconstant $cSelection :|csel|)               ;   0x6373656c  

(defconstant $cShortInteger :|shor|)            ;   0x73686f72  

(defconstant $cTable :|ctbl|)                   ;   0x6374626c  

(defconstant $cText :|ctxt|)                    ;   0x63747874  

(defconstant $cTextFlow :|cflo|)                ;   0x63666c6f  

(defconstant $cTextStyles :|tsty|)              ;   0x74737479  

(defconstant $cType :|type|)                    ;   0x74797065  


(defconstant $cVersion :|vers|)                 ;   0x76657273  

(defconstant $cWindow :|cwin|)                  ;   0x6377696e  

(defconstant $cWord :|cwor|)                    ;   0x63776f72  

(defconstant $enumArrows :|arro|)               ;   0x6172726f  

(defconstant $enumJustification :|just|)        ;   0x6a757374  

(defconstant $enumKeyForm :|kfrm|)              ;   0x6b66726d  

(defconstant $enumPosition :|posi|)             ;   0x706f7369  

(defconstant $enumProtection :|prtn|)           ;   0x7072746e  

(defconstant $enumQuality :|qual|)              ;   0x7175616c  

(defconstant $enumSaveOptions :|savo|)          ;   0x7361766f  

(defconstant $enumStyle :|styl|)                ;   0x7374796c  

(defconstant $enumTransferMode :|tran|)         ;   0x7472616e  

(defconstant $formUniqueID :|ID  |)             ;   0x49442020  

(defconstant $kAEAbout :|abou|)                 ;   0x61626f75  

(defconstant $kAEAfter :|afte|)                 ;   0x61667465  

(defconstant $kAEAliasSelection :|sali|)        ;   0x73616c69  

(defconstant $kAEAllCaps :|alcp|)               ;   0x616c6370  

(defconstant $kAEArrowAtEnd :|aren|)            ;   0x6172656e  

(defconstant $kAEArrowAtStart :|arst|)          ;   0x61727374  

(defconstant $kAEArrowBothEnds :|arbo|)         ;   0x6172626f  


(defconstant $kAEAsk :|ask |)                   ;   0x61736b20  

(defconstant $kAEBefore :|befo|)                ;   0x6265666f  

(defconstant $kAEBeginning :|bgng|)             ;   0x62676e67  

(defconstant $kAEBeginsWith :|bgwt|)            ;   0x62677774  

(defconstant $kAEBeginTransaction :|begi|)      ;   0x62656769  

(defconstant $kAEBold :|bold|)                  ;   0x626f6c64  

(defconstant $kAECaseSensEquals :|cseq|)        ;   0x63736571  

(defconstant $kAECentered :|cent|)              ;   0x63656e74  

(defconstant $kAEChangeView :|view|)            ;   0x76696577  

(defconstant $kAEClone :|clon|)                 ;   0x636c6f6e  

(defconstant $kAEClose :|clos|)                 ;   0x636c6f73  

(defconstant $kAECondensed :|cond|)             ;   0x636f6e64  

(defconstant $kAEContains :|cont|)              ;   0x636f6e74  

(defconstant $kAECopy :|copy|)                  ;   0x636f7079  

(defconstant $kAECoreSuite :|core|)             ;   0x636f7265  

(defconstant $kAECountElements :|cnte|)         ;   0x636e7465  

(defconstant $kAECreateElement :|crel|)         ;   0x6372656c  

(defconstant $kAECreatePublisher :|cpub|)       ;   0x63707562  

(defconstant $kAECut :|cut |)                   ;   0x63757420  

(defconstant $kAEDelete :|delo|)                ;   0x64656c6f  


(defconstant $kAEDoObjectsExist :|doex|)        ;   0x646f6578  

(defconstant $kAEDoScript :|dosc|)              ;   0x646f7363  

(defconstant $kAEDrag :|drag|)                  ;   0x64726167  

(defconstant $kAEDuplicateSelection :|sdup|)    ;   0x73647570  

(defconstant $kAEEditGraphic :|edit|)           ;   0x65646974  

(defconstant $kAEEmptyTrash :|empt|)            ;   0x656d7074  

(defconstant $kAEEnd :|end |)                   ;   0x656e6420  

(defconstant $kAEEndsWith :|ends|)              ;   0x656e6473  

(defconstant $kAEEndTransaction :|endt|)        ;   0x656e6474  

(defconstant $kAEEquals :|=   |)                ;   0x3d202020  

(defconstant $kAEExpanded :|pexp|)              ;   0x70657870  

(defconstant $kAEFast :|fast|)                  ;   0x66617374  

(defconstant $kAEFinderEvents :|FNDR|)          ;   0x464e4452  

(defconstant $kAEFormulaProtect :|fpro|)        ;   0x6670726f  

(defconstant $kAEFullyJustified :|full|)        ;   0x66756c6c  

(defconstant $kAEGetClassInfo :|qobj|)          ;   0x716f626a  

(defconstant $kAEGetData :|getd|)               ;   0x67657464  

(defconstant $kAEGetDataSize :|dsiz|)           ;   0x6473697a  

(defconstant $kAEGetEventInfo :|gtei|)          ;   0x67746569  

(defconstant $kAEGetInfoSelection :|sinf|)      ;   0x73696e66  


(defconstant $kAEGetPrivilegeSelection :|sprv|) ;   0x73707276  

(defconstant $kAEGetSuiteInfo :|gtsi|)          ;   0x67747369  

(defconstant $kAEGreaterThan :|>   |)           ;   0x3e202020  

(defconstant $kAEGreaterThanEquals :|>=  |)     ;   0x3e3d2020  

(defconstant $kAEGrow :|grow|)                  ;   0x67726f77  

(defconstant $kAEHidden :|hidn|)                ;   0x6869646e  

(defconstant $kAEHiQuality :|hiqu|)             ;   0x68697175  

(defconstant $kAEImageGraphic :|imgr|)          ;   0x696d6772  

(defconstant $kAEIsUniform :|isun|)             ;   0x6973756e  

(defconstant $kAEItalic :|ital|)                ;   0x6974616c  

(defconstant $kAELeftJustified :|left|)         ;   0x6c656674  

(defconstant $kAELessThan :|<   |)              ;   0x3c202020  

(defconstant $kAELessThanEquals :|<=  |)        ;   0x3c3d2020  

(defconstant $kAELowercase :|lowc|)             ;   0x6c6f7763  

(defconstant $kAEMakeObjectsVisible :|mvis|)    ;   0x6d766973  

(defconstant $kAEMiscStandards :|misc|)         ;   0x6d697363  

(defconstant $kAEModifiable :|modf|)            ;   0x6d6f6466  

(defconstant $kAEMove :|move|)                  ;   0x6d6f7665  

(defconstant $kAENo :|no  |)                    ;   0x6e6f2020  

(defconstant $kAENoArrow :|arno|)               ;   0x61726e6f  


(defconstant $kAENonmodifiable :|nmod|)         ;   0x6e6d6f64  

(defconstant $kAEOpen :|odoc|)                  ;   0x6f646f63  

(defconstant $kAEOpenSelection :|sope|)         ;   0x736f7065  

(defconstant $kAEOutline :|outl|)               ;   0x6f75746c  

(defconstant $kAEPageSetup :|pgsu|)             ;   0x70677375  

(defconstant $kAEPaste :|past|)                 ;   0x70617374  

(defconstant $kAEPlain :|plan|)                 ;   0x706c616e  

(defconstant $kAEPrint :|pdoc|)                 ;   0x70646f63  

(defconstant $kAEPrintSelection :|spri|)        ;   0x73707269  

(defconstant $kAEPrintWindow :|pwin|)           ;   0x7077696e  

(defconstant $kAEPutAwaySelection :|sput|)      ;   0x73707574  

(defconstant $kAEQDAddOver :|addo|)             ;   0x6164646f  

(defconstant $kAEQDAddPin :|addp|)              ;   0x61646470  

(defconstant $kAEQDAdMax :|admx|)               ;   0x61646d78  

(defconstant $kAEQDAdMin :|admn|)               ;   0x61646d6e  

(defconstant $kAEQDBic :|bic |)                 ;   0x62696320  

(defconstant $kAEQDBlend :|blnd|)               ;   0x626c6e64  

(defconstant $kAEQDCopy :|cpy |)                ;   0x63707920  

(defconstant $kAEQDNotBic :|nbic|)              ;   0x6e626963  

(defconstant $kAEQDNotCopy :|ncpy|)             ;   0x6e637079  


(defconstant $kAEQDNotOr :|ntor|)               ;   0x6e746f72  

(defconstant $kAEQDNotXor :|nxor|)              ;   0x6e786f72  

(defconstant $kAEQDOr :|or  |)                  ;   0x6f722020  

(defconstant $kAEQDSubOver :|subo|)             ;   0x7375626f  

(defconstant $kAEQDSubPin :|subp|)              ;   0x73756270  

(defconstant $kAEQDSupplementalSuite :|qdsp|)   ;   0x71647370  

(defconstant $kAEQDXor :|xor |)                 ;   0x786f7220  

(defconstant $kAEQuickdrawSuite :|qdrw|)        ;   0x71647277  

(defconstant $kAEQuitAll :|quia|)               ;   0x71756961  

(defconstant $kAERedo :|redo|)                  ;   0x7265646f  

(defconstant $kAERegular :|regl|)               ;   0x7265676c  

(defconstant $kAEReopenApplication :|rapp|)     ;   0x72617070  

(defconstant $kAEReplace :|rplc|)               ;   0x72706c63  

(defconstant $kAERequiredSuite :|reqd|)         ;   0x72657164  

(defconstant $kAERestart :|rest|)               ;   0x72657374  

(defconstant $kAERevealSelection :|srev|)       ;   0x73726576  

(defconstant $kAERevert :|rvrt|)                ;   0x72767274  

(defconstant $kAERightJustified :|rght|)        ;   0x72676874  

(defconstant $kAESave :|save|)                  ;   0x73617665  

(defconstant $kAESelect :|slct|)                ;   0x736c6374  

(defconstant $kAESetData :|setd|)               ;   0x73657464  


(defconstant $kAESetPosition :|posn|)           ;   0x706f736e  

(defconstant $kAEShadow :|shad|)                ;   0x73686164  

(defconstant $kAEShowClipboard :|shcl|)         ;   0x7368636c  

(defconstant $kAEShutDown :|shut|)              ;   0x73687574  

(defconstant $kAESleep :|slep|)                 ;   0x736c6570  

(defconstant $kAESmallCaps :|smcp|)             ;   0x736d6370  

(defconstant $kAESpecialClassProperties :|c@#!|);   0x63402321  

(defconstant $kAEStrikethrough :|strk|)         ;   0x7374726b  

(defconstant $kAESubscript :|sbsc|)             ;   0x73627363  

(defconstant $kAESuperscript :|spsc|)           ;   0x73707363  

(defconstant $kAETableSuite :|tbls|)            ;   0x74626c73  

(defconstant $kAETextSuite :|TEXT|)             ;   0x54455854  

(defconstant $kAETransactionTerminated :|ttrm|) ;   0x7474726d  

(defconstant $kAEUnderline :|undl|)             ;   0x756e646c  

(defconstant $kAEUndo :|undo|)                  ;   0x756e646f  

(defconstant $kAEWholeWordEquals :|wweq|)       ;   0x77776571  

(defconstant $kAEYes :|yes |)                   ;   0x79657320  

(defconstant $kAEZoom :|zoom|)                  ;   0x7a6f6f6d  

;  events that can be sent to the "system" process (eg, loginwindow) on OS X 10.2 or later 

(defconstant $kAELogOut :|logo|)
(defconstant $kAEReallyLogOut :|rlgo|)
(defconstant $kAEShowRestartDialog :|rrst|)
(defconstant $kAEShowShutdownDialog :|rsdn|)
;  EventRecord Classes and EventIDs 

(defconstant $kAEMouseClass :|mous|)
(defconstant $kAEDown :|down|)
(defconstant $kAEUp :|up  |)
(defconstant $kAEMoved :|move|)
(defconstant $kAEStoppedMoving :|stop|)
(defconstant $kAEWindowClass :|wind|)
(defconstant $kAEUpdate :|updt|)
(defconstant $kAEActivate :|actv|)
(defconstant $kAEDeactivate :|dact|)
(defconstant $kAECommandClass :|cmnd|)          ;  Modern Command Event Class 

(defconstant $kAEKeyClass :|keyc|)
(defconstant $kAERawKey :|rkey|)                ;  Modern Raw Key Event 

(defconstant $kAEVirtualKey :|keyc|)            ;  Modern Virtual Key Event 

(defconstant $kAENavigationKey :|nave|)         ;  Modern Navigation Key Event 

(defconstant $kAEAutoDown :|auto|)
(defconstant $kAEApplicationClass :|appl|)
(defconstant $kAESuspend :|susp|)
(defconstant $kAEResume :|rsme|)
(defconstant $kAEDiskEvent :|disk|)
(defconstant $kAENullEvent :|null|)
(defconstant $kAEWakeUpEvent :|wake|)
(defconstant $kAEScrapEvent :|scrp|)
(defconstant $kAEHighLevel :|high|)

(defconstant $keyAEAngle :|kang|)               ;   0x6b616e67  

(defconstant $keyAEArcAngle :|parc|)            ;   0x70617263  


(defconstant $keyAEBaseAddr :|badd|)            ;   0x62616464  

(defconstant $keyAEBestType :|pbst|)            ;   0x70627374  

(defconstant $keyAEBgndColor :|kbcl|)           ;   0x6b62636c  

(defconstant $keyAEBgndPattern :|kbpt|)         ;   0x6b627074  

(defconstant $keyAEBounds :|pbnd|)              ;   0x70626e64  

(defconstant $keyAECellList :|kclt|)            ;   0x6b636c74  

(defconstant $keyAEClassID :|clID|)             ;   0x636c4944  

(defconstant $keyAEColor :|colr|)               ;   0x636f6c72  

(defconstant $keyAEColorTable :|cltb|)          ;   0x636c7462  

(defconstant $keyAECurveHeight :|kchd|)         ;   0x6b636864  

(defconstant $keyAECurveWidth :|kcwd|)          ;   0x6b637764  

(defconstant $keyAEDashStyle :|pdst|)           ;   0x70647374  

(defconstant $keyAEData :|data|)                ;   0x64617461  

(defconstant $keyAEDefaultType :|deft|)         ;   0x64656674  

(defconstant $keyAEDefinitionRect :|pdrt|)      ;   0x70647274  

(defconstant $keyAEDescType :|dstp|)            ;   0x64737470  

(defconstant $keyAEDestination :|dest|)         ;   0x64657374  

(defconstant $keyAEDoAntiAlias :|anta|)         ;   0x616e7461  

(defconstant $keyAEDoDithered :|gdit|)          ;   0x67646974  

(defconstant $keyAEDoRotate :|kdrt|)            ;   0x6b647274  


(defconstant $keyAEDoScale :|ksca|)             ;   0x6b736361  

(defconstant $keyAEDoTranslate :|ktra|)         ;   0x6b747261  

(defconstant $keyAEEditionFileLoc :|eloc|)      ;   0x656c6f63  

(defconstant $keyAEElements :|elms|)            ;   0x656c6d73  

(defconstant $keyAEEndPoint :|pend|)            ;   0x70656e64  

(defconstant $keyAEEventClass :|evcl|)          ;   0x6576636c  

(defconstant $keyAEEventID :|evti|)             ;   0x65767469  

(defconstant $keyAEFile :|kfil|)                ;   0x6b66696c  

(defconstant $keyAEFileType :|fltp|)            ;   0x666c7470  

(defconstant $keyAEFillColor :|flcl|)           ;   0x666c636c  

(defconstant $keyAEFillPattern :|flpt|)         ;   0x666c7074  

(defconstant $keyAEFlipHorizontal :|kfho|)      ;   0x6b66686f  

(defconstant $keyAEFlipVertical :|kfvt|)        ;   0x6b667674  

(defconstant $keyAEFont :|font|)                ;   0x666f6e74  

(defconstant $keyAEFormula :|pfor|)             ;   0x70666f72  

(defconstant $keyAEGraphicObjects :|gobs|)      ;   0x676f6273  

(defconstant $keyAEID :|ID  |)                  ;   0x49442020  

(defconstant $keyAEImageQuality :|gqua|)        ;   0x67717561  

(defconstant $keyAEInsertHere :|insh|)          ;   0x696e7368  

(defconstant $keyAEKeyForms :|keyf|)            ;   0x6b657966  


(defconstant $keyAEKeyword :|kywd|)             ;   0x6b797764  

(defconstant $keyAELevel :|levl|)               ;   0x6c65766c  

(defconstant $keyAELineArrow :|arro|)           ;   0x6172726f  

(defconstant $keyAEName :|pnam|)                ;   0x706e616d  

(defconstant $keyAENewElementLoc :|pnel|)       ;   0x706e656c  

(defconstant $keyAEObject :|kobj|)              ;   0x6b6f626a  

(defconstant $keyAEObjectClass :|kocl|)         ;   0x6b6f636c  

(defconstant $keyAEOffStyles :|ofst|)           ;   0x6f667374  

(defconstant $keyAEOnStyles :|onst|)            ;   0x6f6e7374  

(defconstant $keyAEParameters :|prms|)          ;   0x70726d73  

(defconstant $keyAEParamFlags :|pmfg|)          ;   0x706d6667  

(defconstant $keyAEPenColor :|ppcl|)            ;   0x7070636c  

(defconstant $keyAEPenPattern :|pppa|)          ;   0x70707061  

(defconstant $keyAEPenWidth :|ppwd|)            ;   0x70707764  

(defconstant $keyAEPixelDepth :|pdpt|)          ;   0x70647074  

(defconstant $keyAEPixMapMinus :|kpmm|)         ;   0x6b706d6d  

(defconstant $keyAEPMTable :|kpmt|)             ;   0x6b706d74  

(defconstant $keyAEPointList :|ptlt|)           ;   0x70746c74  

(defconstant $keyAEPointSize :|ptsz|)           ;   0x7074737a  

(defconstant $keyAEPosition :|kpos|)            ;   0x6b706f73  


(defconstant $keyAEPropData :|prdt|)            ;   0x70726474  

(defconstant $keyAEProperties :|qpro|)          ;   0x7170726f  

(defconstant $keyAEProperty :|kprp|)            ;   0x6b707270  

(defconstant $keyAEPropFlags :|prfg|)           ;   0x70726667  

(defconstant $keyAEPropID :|prop|)              ;   0x70726f70  

(defconstant $keyAEProtection :|ppro|)          ;   0x7070726f  

(defconstant $keyAERenderAs :|kren|)            ;   0x6b72656e  

(defconstant $keyAERequestedType :|rtyp|)       ;   0x72747970  

(defconstant $keyAEResult :|----|)              ;   0x2d2d2d2d  

(defconstant $keyAEResultInfo :|rsin|)          ;   0x7273696e  

(defconstant $keyAERotation :|prot|)            ;   0x70726f74  

(defconstant $keyAERotPoint :|krtp|)            ;   0x6b727470  

(defconstant $keyAERowList :|krls|)             ;   0x6b726c73  

(defconstant $keyAESaveOptions :|savo|)         ;   0x7361766f  

(defconstant $keyAEScale :|pscl|)               ;   0x7073636c  

(defconstant $keyAEScriptTag :|psct|)           ;   0x70736374  

(defconstant $keyAEShowWhere :|show|)           ;   0x73686f77  

(defconstant $keyAEStartAngle :|pang|)          ;   0x70616e67  

(defconstant $keyAEStartPoint :|pstp|)          ;   0x70737470  

(defconstant $keyAEStyles :|ksty|)              ;   0x6b737479  


(defconstant $keyAESuiteID :|suit|)             ;   0x73756974  

(defconstant $keyAEText :|ktxt|)                ;   0x6b747874  

(defconstant $keyAETextColor :|ptxc|)           ;   0x70747863  

(defconstant $keyAETextFont :|ptxf|)            ;   0x70747866  

(defconstant $keyAETextPointSize :|ptps|)       ;   0x70747073  

(defconstant $keyAETextStyles :|txst|)          ;   0x74787374  

(defconstant $keyAETextLineHeight :|ktlh|)      ;  type ShortInteger 

(defconstant $keyAETextLineAscent :|ktas|)      ;  type ShortInteger 

(defconstant $keyAETheText :|thtx|)             ;   0x74687478  

(defconstant $keyAETransferMode :|pptm|)        ;   0x7070746d  

(defconstant $keyAETranslation :|ptrs|)         ;   0x70747273  

(defconstant $keyAETryAsStructGraf :|toog|)     ;   0x746f6f67  

(defconstant $keyAEUniformStyles :|ustl|)       ;   0x7573746c  

(defconstant $keyAEUpdateOn :|pupd|)            ;   0x70757064  

(defconstant $keyAEUserTerm :|utrm|)            ;   0x7574726d  

(defconstant $keyAEWindow :|wndw|)              ;   0x776e6477  

(defconstant $keyAEWritingCode :|wrcd|)         ;   0x77726364  


(defconstant $keyMiscellaneous :|fmsc|)         ;   0x666d7363  

(defconstant $keySelection :|fsel|)             ;   0x6673656c  

(defconstant $keyWindow :|kwnd|)                ;   0x6b776e64  
;  EventRecord keys 

(defconstant $keyWhen :|when|)
(defconstant $keyWhere :|wher|)
(defconstant $keyModifiers :|mods|)
(defconstant $keyKey :|key |)
(defconstant $keyKeyCode :|code|)
(defconstant $keyKeyboard :|keyb|)
(defconstant $keyDriveNumber :|drv#|)
(defconstant $keyErrorCode :|err#|)
(defconstant $keyHighLevelClass :|hcls|)
(defconstant $keyHighLevelID :|hid |)

(defconstant $pArcAngle :|parc|)                ;   0x70617263  

(defconstant $pBackgroundColor :|pbcl|)         ;   0x7062636c  

(defconstant $pBackgroundPattern :|pbpt|)       ;   0x70627074  

(defconstant $pBestType :|pbst|)                ;   0x70627374  

(defconstant $pBounds :|pbnd|)                  ;   0x70626e64  

(defconstant $pClass :|pcls|)                   ;   0x70636c73  

(defconstant $pClipboard :|pcli|)               ;   0x70636c69  

(defconstant $pColor :|colr|)                   ;   0x636f6c72  

(defconstant $pColorTable :|cltb|)              ;   0x636c7462  

(defconstant $pContents :|pcnt|)                ;   0x70636e74  

(defconstant $pCornerCurveHeight :|pchd|)       ;   0x70636864  

(defconstant $pCornerCurveWidth :|pcwd|)        ;   0x70637764  

(defconstant $pDashStyle :|pdst|)               ;   0x70647374  

(defconstant $pDefaultType :|deft|)             ;   0x64656674  

(defconstant $pDefinitionRect :|pdrt|)          ;   0x70647274  

(defconstant $pEnabled :|enbl|)                 ;   0x656e626c  

(defconstant $pEndPoint :|pend|)                ;   0x70656e64  

(defconstant $pFillColor :|flcl|)               ;   0x666c636c  

(defconstant $pFillPattern :|flpt|)             ;   0x666c7074  

(defconstant $pFont :|font|)                    ;   0x666f6e74  


(defconstant $pFormula :|pfor|)                 ;   0x70666f72  

(defconstant $pGraphicObjects :|gobs|)          ;   0x676f6273  

(defconstant $pHasCloseBox :|hclb|)             ;   0x68636c62  

(defconstant $pHasTitleBar :|ptit|)             ;   0x70746974  

(defconstant $pID :|ID  |)                      ;   0x49442020  

(defconstant $pIndex :|pidx|)                   ;   0x70696478  

(defconstant $pInsertionLoc :|pins|)            ;   0x70696e73  

(defconstant $pIsFloating :|isfl|)              ;   0x6973666c  

(defconstant $pIsFrontProcess :|pisf|)          ;   0x70697366  

(defconstant $pIsModal :|pmod|)                 ;   0x706d6f64  

(defconstant $pIsModified :|imod|)              ;   0x696d6f64  

(defconstant $pIsResizable :|prsz|)             ;   0x7072737a  

(defconstant $pIsStationeryPad :|pspd|)         ;   0x70737064  

(defconstant $pIsZoomable :|iszm|)              ;   0x69737a6d  

(defconstant $pIsZoomed :|pzum|)                ;   0x707a756d  

(defconstant $pItemNumber :|itmn|)              ;   0x69746d6e  

(defconstant $pJustification :|pjst|)           ;   0x706a7374  

(defconstant $pLineArrow :|arro|)               ;   0x6172726f  

(defconstant $pMenuID :|mnid|)                  ;   0x6d6e6964  

(defconstant $pName :|pnam|)                    ;   0x706e616d  


(defconstant $pNewElementLoc :|pnel|)           ;   0x706e656c  

(defconstant $pPenColor :|ppcl|)                ;   0x7070636c  

(defconstant $pPenPattern :|pppa|)              ;   0x70707061  

(defconstant $pPenWidth :|ppwd|)                ;   0x70707764  

(defconstant $pPixelDepth :|pdpt|)              ;   0x70647074  

(defconstant $pPointList :|ptlt|)               ;   0x70746c74  

(defconstant $pPointSize :|ptsz|)               ;   0x7074737a  

(defconstant $pProtection :|ppro|)              ;   0x7070726f  

(defconstant $pRotation :|prot|)                ;   0x70726f74  

(defconstant $pScale :|pscl|)                   ;   0x7073636c  

(defconstant $pScript :|scpt|)                  ;   0x73637074  

(defconstant $pScriptTag :|psct|)               ;   0x70736374  

(defconstant $pSelected :|selc|)                ;   0x73656c63  

(defconstant $pSelection :|sele|)               ;   0x73656c65  

(defconstant $pStartAngle :|pang|)              ;   0x70616e67  

(defconstant $pStartPoint :|pstp|)              ;   0x70737470  

(defconstant $pTextColor :|ptxc|)               ;   0x70747863  

(defconstant $pTextFont :|ptxf|)                ;   0x70747866  

(defconstant $pTextItemDelimiters :|txdl|)      ;   0x7478646c  

(defconstant $pTextPointSize :|ptps|)           ;   0x70747073  


(defconstant $pTextStyles :|txst|)              ;   0x74787374  

(defconstant $pTransferMode :|pptm|)            ;   0x7070746d  

(defconstant $pTranslation :|ptrs|)             ;   0x70747273  

(defconstant $pUniformStyles :|ustl|)           ;   0x7573746c  

(defconstant $pUpdateOn :|pupd|)                ;   0x70757064  

(defconstant $pUserSelection :|pusl|)           ;   0x7075736c  

(defconstant $pVersion :|vers|)                 ;   0x76657273  

(defconstant $pVisible :|pvis|)                 ;   0x70766973  


(defconstant $typeAEText :|tTXT|)               ;   0x74545854  

(defconstant $typeArc :|carc|)                  ;   0x63617263  

(defconstant $typeBest :|best|)                 ;   0x62657374  

(defconstant $typeCell :|ccel|)                 ;   0x6363656c  

(defconstant $typeClassInfo :|gcli|)            ;   0x67636c69  

(defconstant $typeColorTable :|clrt|)           ;   0x636c7274  

(defconstant $typeColumn :|ccol|)               ;   0x63636f6c  

(defconstant $typeDashStyle :|tdas|)            ;   0x74646173  

(defconstant $typeData :|tdta|)                 ;   0x74647461  

(defconstant $typeDrawingArea :|cdrw|)          ;   0x63647277  

(defconstant $typeElemInfo :|elin|)             ;   0x656c696e  

(defconstant $typeEnumeration :|enum|)          ;   0x656e756d  

(defconstant $typeEPS :|EPS |)                  ;   0x45505320  

(defconstant $typeEventInfo :|evin|)            ;   0x6576696e  


(defconstant $typeFinderWindow :|fwin|)         ;   0x6677696e  

(defconstant $typeFixedPoint :|fpnt|)           ;   0x66706e74  

(defconstant $typeFixedRectangle :|frct|)       ;   0x66726374  

(defconstant $typeGraphicLine :|glin|)          ;   0x676c696e  

(defconstant $typeGraphicText :|cgtx|)          ;   0x63677478  

(defconstant $typeGroupedGraphic :|cpic|)       ;   0x63706963  

(defconstant $typeInsertionLoc :|insl|)         ;   0x696e736c  

(defconstant $typeIntlText :|itxt|)             ;   0x69747874  

(defconstant $typeIntlWritingCode :|intl|)      ;   0x696e746c  

(defconstant $typeLongDateTime :|ldt |)         ;   0x6c647420  

(defconstant $typeISO8601DateTime :|isot|)      ;   0x69736f74  data is ascii text of an ISO8601 date 

(defconstant $typeLongFixed :|lfxd|)            ;   0x6c667864  

(defconstant $typeLongFixedPoint :|lfpt|)       ;   0x6c667074  

(defconstant $typeLongFixedRectangle :|lfrc|)   ;   0x6c667263  

(defconstant $typeLongPoint :|lpnt|)            ;   0x6c706e74  

(defconstant $typeLongRectangle :|lrct|)        ;   0x6c726374  

(defconstant $typeMachineLoc :|mLoc|)           ;   0x6d4c6f63  

(defconstant $typeOval :|covl|)                 ;   0x636f766c  

(defconstant $typeParamInfo :|pmin|)            ;   0x706d696e  

(defconstant $typePict :|PICT|)                 ;   0x50494354  


(defconstant $typePixelMap :|cpix|)             ;   0x63706978  

(defconstant $typePixMapMinus :|tpmm|)          ;   0x74706d6d  

(defconstant $typePolygon :|cpgn|)              ;   0x6370676e  

(defconstant $typePropInfo :|pinf|)             ;   0x70696e66  

(defconstant $typePtr :|ptr |)                  ;   0x70747220  

(defconstant $typeQDPoint :|QDpt|)              ;   0x51447074  

(defconstant $typeQDRegion :|Qrgn|)             ;   0x51447074  (data is actual region data, including rectangle and size, _not_ region handle or ptr)

(defconstant $typeRectangle :|crec|)            ;   0x63726563  

(defconstant $typeRGB16 :|tr16|)                ;   0x74723136  

(defconstant $typeRGB96 :|tr96|)                ;   0x74723936  

(defconstant $typeRGBColor :|cRGB|)             ;   0x63524742  

(defconstant $typeRotation :|trot|)             ;   0x74726f74  

(defconstant $typeRoundedRectangle :|crrc|)     ;   0x63727263  

(defconstant $typeRow :|crow|)                  ;   0x63726f77  

(defconstant $typeScrapStyles :|styl|)          ;   0x7374796c  

(defconstant $typeScript :|scpt|)               ;   0x73637074  

(defconstant $typeStyledText :|STXT|)           ;   0x53545854  

(defconstant $typeSuiteInfo :|suin|)            ;   0x7375696e  

(defconstant $typeTable :|ctbl|)                ;   0x6374626c  

(defconstant $typeTextStyles :|tsty|)           ;   0x74737479  


(defconstant $typeTIFF :|TIFF|)                 ;   0x54494646  

(defconstant $typeJPEG :|JPEG|)
(defconstant $typeGIF :|GIFf|)
(defconstant $typeVersion :|vers|)              ;   0x76657273  


(defconstant $kAEMenuClass :|menu|)
(defconstant $kAEMenuSelect :|mhit|)
(defconstant $kAEMouseDown :|mdwn|)
(defconstant $kAEMouseDownInBack :|mdbk|)
(defconstant $kAEKeyDown :|kdwn|)
(defconstant $kAEResized :|rsiz|)
(defconstant $kAEPromise :|prom|)

(defconstant $keyMenuID :|mid |)
(defconstant $keyMenuItem :|mitm|)
(defconstant $keyCloseAllWindows :|caw |)
(defconstant $keyOriginalBounds :|obnd|)
(defconstant $keyNewBounds :|nbnd|)
(defconstant $keyLocalWhere :|lwhr|)

(defconstant $typeHIMenu :|mobj|)
(defconstant $typeHIWindow :|wobj|)

(defconstant $kBySmallIcon 0)
(defconstant $kByIconView 1)
(defconstant $kByNameView 2)
(defconstant $kByDateView 3)
(defconstant $kBySizeView 4)
(defconstant $kByKindView 5)
(defconstant $kByCommentView 6)
(defconstant $kByLabelView 7)
(defconstant $kByVersionView 8)

(defconstant $kAEInfo 11)
(defconstant $kAEMain 0)
(defconstant $kAESharing 13)

(defconstant $kAEZoomIn 7)
(defconstant $kAEZoomOut 8)

(defconstant $kTextServiceClass :|tsvc|)
(defconstant $kUpdateActiveInputArea :|updt|)   ;  update the active input area 

(defconstant $kShowHideInputWindow :|shiw|)     ;  show or hide the input window 

(defconstant $kPos2Offset :|p2st|)              ;  converting global coordinates to char position 

(defconstant $kOffset2Pos :|st2p|)              ;  converting char position to global coordinates 

(defconstant $kUnicodeNotFromInputMethod :|unim|);  Unicode text when event not handled by Input Method or no Input Method 

(defconstant $kGetSelectedText :|gtxt|)         ;  Get text for current selection 

(defconstant $keyAETSMDocumentRefcon :|refc|)   ;  TSM document refcon, typeLongInteger 

(defconstant $keyAEServerInstance :|srvi|)      ;  component instance 

(defconstant $keyAETheData :|kdat|)             ;  typeText 

(defconstant $keyAEFixLength :|fixl|)           ;  fix len 

(defconstant $keyAEUpdateRange :|udng|)         ;  typeTextRangeArray 

(defconstant $keyAECurrentPoint :|cpos|)        ;  current point 

(defconstant $keyAEBufferSize :|buff|)          ;  buffer size to get the text 

(defconstant $keyAEMoveView :|mvvw|)            ;  move view flag 

(defconstant $keyAENextBody :|nxbd|)            ;  next or previous body 

(defconstant $keyAETSMScriptTag :|sclg|)
(defconstant $keyAETSMTextFont :|ktxf|)         ;  FMFontFamily or FOND ID 

(defconstant $keyAETSMTextFMFont :|ktxm|)       ;  FMFont 

(defconstant $keyAETSMTextPointSize :|ktps|)
(defconstant $keyAETSMEventRecord :|tevt|)      ;  Low level Event Record, typeLowLevelEventRecord 

(defconstant $keyAETSMEventRef :|tevr|)         ;  Carbon EventRef, typeEventRef 

(defconstant $keyAETextServiceEncoding :|tsen|) ;  Text Service encoding, mac or Unicode in UpdateActiveInputArea or GetSelectedText events. 

(defconstant $keyAETextServiceMacEncoding :|tmen|);  Target mac encoding for TSM conversion of text from Unicode text service. 

(defconstant $keyAETSMGlyphInfoArray :|tgia|)   ;  typeGlyphInfoArray 

(defconstant $typeTextRange :|txrn|)            ;  TextRange 

(defconstant $typeComponentInstance :|cmpi|)    ;  server instance 

(defconstant $typeOffsetArray :|ofay|)          ;  offset array 

(defconstant $typeTextRangeArray :|tray|)
(defconstant $typeLowLevelEventRecord :|evtr|)  ;  Low Level Event Record 

(defconstant $typeGlyphInfoArray :|glia|)       ;  Glyph/FMFont info array for sub ranges of Unicode text.  See GlyphInfoArray in TextServices.h  

(defconstant $typeEventRef :|evrf|)             ;  Carbon EventRef 

(defconstant $typeText :|TEXT|)                 ;  Plain text 

;  Desc type constants 

(defconstant $kTSMOutsideOfBody 1)
(defconstant $kTSMInsideOfBody 2)
(defconstant $kTSMInsideOfActiveInputArea 3)

(defconstant $kNextBody 1)
(defconstant $kPreviousBody 2)
(defrecord TextRange
   (fStart :signed-long)
   (fEnd :signed-long)
   (fHiliteStyle :SInt16)
)

;type name? (%define-record :TextRange (find-record-descriptor ':TextRange))

(def-mactype :TextRangePtr (find-mactype '(:pointer :TextRange)))

(def-mactype :TextRangeHandle (find-mactype '(:handle :TextRange)))
(defrecord TextRangeArray
   (fNumOfRanges :SInt16)                       ;  specify the size of the fRange array 
   (fRange (:array :TextRange 1))               ;  when fNumOfRanges > 1, the size of this array has to be calculated 
)

;type name? (%define-record :TextRangeArray (find-record-descriptor ':TextRangeArray))

(def-mactype :TextRangeArrayPtr (find-mactype '(:pointer :TextRangeArray)))

(def-mactype :TextRangeArrayHandle (find-mactype '(:handle :TextRangeArray)))
(defrecord OffsetArray
   (fNumOfOffsets :SInt16)                      ;  specify the size of the fOffset array 
   (fOffset (:array :signed-long 1))            ;  when fNumOfOffsets > 1, the size of this array has to be calculated 
)

;type name? (%define-record :OffsetArray (find-record-descriptor ':OffsetArray))

(def-mactype :OffsetArrayPtr (find-mactype '(:pointer :OffsetArray)))

(def-mactype :OffsetArrayHandle (find-mactype '(:handle :OffsetArray)))
(defrecord WritingCode
   (theScriptCode :SInt16)
   (theLangCode :SInt16)
)

;type name? (%define-record :WritingCode (find-record-descriptor ':WritingCode))
(defrecord IntlText
   (theScriptCode :SInt16)
   (theLangCode :SInt16)
   (theText (:array :character 1))              ;  variable length data 
)

;type name? (%define-record :IntlText (find-record-descriptor ':IntlText))
;  Hilite styles 

(defconstant $kCaretPosition 1)                 ;  specify caret position 

(defconstant $kRawText 2)                       ;  specify range of raw text 

(defconstant $kSelectedRawText 3)               ;  specify range of selected raw text 

(defconstant $kConvertedText 4)                 ;  specify range of converted text 

(defconstant $kSelectedConvertedText 5)         ;  specify range of selected converted text 

(defconstant $kBlockFillText 6)                 ;  Block Fill hilite style 

(defconstant $kOutlineText 7)                   ;  Outline hilite style 

(defconstant $kSelectedText 8)                  ;  Selected hilite style 


(defconstant $keyAEHiliteRange :|hrng|)         ;  typeTextRangeArray for System 7, typeHiliteRangeArray for System 8 

(defconstant $keyAEPinRange :|pnrg|)            ;  typeTextRange for System 7, typeTextRegionRange for System 8   

(defconstant $keyAEClauseOffsets :|clau|)       ;  typeOffsetArray for System 7, typeClauseOffsetArray for System 8 

(defconstant $keyAEOffset :|ofst|)              ;  typeLongInteger for System 7, typeByteOffset for System 8  

(defconstant $keyAEPoint :|gpos|)               ;  typePoint for System 7, typeQDPoint for System 8 

(defconstant $keyAELeftSide :|klef|)            ;  typeBoolean 

(defconstant $keyAERegionClass :|rgnc|)         ;  typeShortInteger for System 7, typeRegionClass for System 8 

(defconstant $keyAEDragging :|bool|)            ;  typeBoolean 


; #if OLDROUTINENAMES
#| 
(defconstant $keyAELeadingEdge :|klef|)
 |#

; #endif  /* OLDROUTINENAMES */

;  AppleScript 1.3: New Text types 

(defconstant $typeUnicodeText :|utxt|)
(defconstant $typeStyledUnicodeText :|sutx|)
(defconstant $typeUTF8Text :|utf8|)
(defconstant $typeEncodedString :|encs|)
(defconstant $typeCString :|cstr|)
(defconstant $typePString :|pstr|)
;  AppleScript 1.3: Unit types 

(defconstant $typeMeters :|metr|)               ;  Base Unit 

(defconstant $typeInches :|inch|)
(defconstant $typeFeet :|feet|)
(defconstant $typeYards :|yard|)
(defconstant $typeMiles :|mile|)
(defconstant $typeKilometers :|kmtr|)
(defconstant $typeCentimeters :|cmtr|)
(defconstant $typeSquareMeters :|sqrm|)         ;  Base Unit 

(defconstant $typeSquareFeet :|sqft|)
(defconstant $typeSquareYards :|sqyd|)
(defconstant $typeSquareMiles :|sqmi|)
(defconstant $typeSquareKilometers :|sqkm|)
(defconstant $typeLiters :|litr|)               ;  Base Unit 

(defconstant $typeQuarts :|qrts|)
(defconstant $typeGallons :|galn|)
(defconstant $typeCubicMeters :|cmet|)          ;  Base Unit 

(defconstant $typeCubicFeet :|cfet|)
(defconstant $typeCubicInches :|cuin|)
(defconstant $typeCubicCentimeter :|ccmt|)
(defconstant $typeCubicYards :|cyrd|)
(defconstant $typeKilograms :|kgrm|)            ;  Base Unit 

(defconstant $typeGrams :|gram|)
(defconstant $typeOunces :|ozs |)
(defconstant $typePounds :|lbs |)
(defconstant $typeDegreesC :|degc|)             ;  Base Unit 

(defconstant $typeDegreesF :|degf|)
(defconstant $typeDegreesK :|degk|)
;  AppleScript 1.3: Folder Actions 

(defconstant $kFAServerApp :|ssrv|)             ;  Creator code for Folder Actions Server

(defconstant $kDoFolderActionEvent :|fola|)     ;  Event the Finder sends to the Folder Actions FBA

(defconstant $kFolderActionCode :|actn|)        ;  Parameter that contains the Folder Action

(defconstant $kFolderOpenedEvent :|fopn|)       ;  Value of kFolderActionCode parameter; sent to script as event

(defconstant $kFolderClosedEvent :|fclo|)
(defconstant $kFolderWindowMovedEvent :|fsiz|)
(defconstant $kFolderItemsAddedEvent :|fget|)
(defconstant $kFolderItemsRemovedEvent :|flos|)
(defconstant $kItemList :|flst|)                ;  List parameter for added and removed items

(defconstant $kNewSizeParameter :|fnsz|)        ;  Parameter for moved window

(defconstant $kFASuiteCode :|faco|)             ;  Suite code for the following events

(defconstant $kFAAttachCommand :|atfa|)         ;  Attach event id

(defconstant $kFARemoveCommand :|rmfa|)         ;  Remove event id

(defconstant $kFAEditCommand :|edfa|)           ;  Edit event id

(defconstant $kFAFileParam :|faal|)             ;  Key for file parameter for Attach

(defconstant $kFAIndexParam :|indx|)            ;  Key for index (0-based) parameter for Remove and Edit

;  AppleScript 1.3 Internet Suite 
;  Suite code 

(defconstant $kAEInternetSuite :|gurl|)
(defconstant $kAEISWebStarSuite #x575757BD)
;  Events 

(defconstant $kAEISGetURL :|gurl|)
(defconstant $KAEISHandleCGI :|sdoc|)
;  Classes 

(defconstant $cURL :|url |)
(defconstant $cInternetAddress :|IPAD|)
(defconstant $cHTML :|html|)
(defconstant $cFTPItem :|ftp |)
;  Parameters 

(defconstant $kAEISHTTPSearchArgs :|kfor|)
(defconstant $kAEISPostArgs :|post|)
(defconstant $kAEISMethod :|meth|)
(defconstant $kAEISClientAddress :|addr|)
(defconstant $kAEISUserName :|user|)
(defconstant $kAEISPassword :|pass|)
(defconstant $kAEISFromUser :|frmu|)
(defconstant $kAEISServerName :|svnm|)
(defconstant $kAEISServerPort :|svpt|)
(defconstant $kAEISScriptName :|scnm|)
(defconstant $kAEISContentType :|ctyp|)
(defconstant $kAEISReferrer :|refr|)
(defconstant $kAEISUserAgent :|Agnt|)
(defconstant $kAEISAction :|Kact|)
(defconstant $kAEISActionPath :|Kapt|)
(defconstant $kAEISClientIP :|Kcip|)
(defconstant $kAEISFullRequest :|Kfrq|)
;  Properties 

(defconstant $pScheme :|pusc|)
(defconstant $pHost :|HOST|)
(defconstant $pPath :|FTPc|)
(defconstant $pUserName :|RAun|)
(defconstant $pUserPassword :|RApw|)
(defconstant $pDNSForm :|pDNS|)
(defconstant $pURL :|pURL|)
(defconstant $pTextEncoding :|ptxe|)
(defconstant $pFTPKind :|kind|)
;  Scheme enumerations 

(defconstant $eScheme :|esch|)
(defconstant $eurlHTTP :|http|)                 ;  RFC 2068 

(defconstant $eurlHTTPS :|htps|)
(defconstant $eurlFTP :|ftp |)                  ;  RFC 1738 

(defconstant $eurlMail :|mail|)                 ;  RFC 2638 

(defconstant $eurlFile :|file|)                 ;  RFC 1738 

(defconstant $eurlGopher :|gphr|)               ;  RFC 1738 

(defconstant $eurlTelnet :|tlnt|)               ;  RFC 1738 

(defconstant $eurlNews :|news|)                 ;  RFC 1738 

(defconstant $eurlSNews :|snws|)
(defconstant $eurlNNTP :|nntp|)                 ;  RFC 1738 

(defconstant $eurlMessage :|mess|)
(defconstant $eurlMailbox :|mbox|)
(defconstant $eurlMulti :|mult|)
(defconstant $eurlLaunch :|laun|)
(defconstant $eurlAFP :|afp |)
(defconstant $eurlAT :|at  |)
(defconstant $eurlEPPC :|eppc|)
(defconstant $eurlRTSP :|rtsp|)                 ;  RFC 2326 

(defconstant $eurlIMAP :|imap|)                 ;  RFC 2192 

(defconstant $eurlNFS :|unfs|)                  ;  RFC 2224 

(defconstant $eurlPOP :|upop|)                  ;  RFC 2384 

(defconstant $eurlLDAP :|uldp|)                 ;  RFC 2255 

(defconstant $eurlUnknown :|url?|)
;  AppleScript 1.3: Connectivity Suite in aeut 

(defconstant $kConnSuite :|macc|)
(defconstant $cDevSpec :|cdev|)
(defconstant $cAddressSpec :|cadr|)
(defconstant $cADBAddress :|cadb|)
(defconstant $cAppleTalkAddress :|cat |)
(defconstant $cBusAddress :|cbus|)
(defconstant $cEthernetAddress :|cen |)
(defconstant $cFireWireAddress :|cfw |)
(defconstant $cIPAddress :|cip |)
(defconstant $cLocalTalkAddress :|clt |)
(defconstant $cSCSIAddress :|cscs|)
(defconstant $cTokenRingAddress :|ctok|)
(defconstant $cUSBAddress :|cusb|)              ;  
;  Properties 

(defconstant $pDeviceType :|pdvt|)
(defconstant $pDeviceAddress :|pdva|)
(defconstant $pConduit :|pcon|)
(defconstant $pProtocol :|pprt|)                ;  cde 4/27/98 was 'ppro' conflicted with DB suite 

(defconstant $pATMachine :|patm|)
(defconstant $pATZone :|patz|)
(defconstant $pATType :|patt|)
(defconstant $pDottedDecimal :|pipd|)
(defconstant $pDNS :|pdns|)
(defconstant $pPort :|ppor|)
(defconstant $pNetwork :|pnet|)
(defconstant $pNode :|pnod|)
(defconstant $pSocket :|psoc|)
(defconstant $pSCSIBus :|pscb|)
(defconstant $pSCSILUN :|pslu|)                 ;  cde 5/22/98 per WWDC developer request 
;  Enumerations and enumerators 

(defconstant $eDeviceType :|edvt|)
(defconstant $eAddressSpec :|eads|)
(defconstant $eConduit :|econ|)
(defconstant $eProtocol :|epro|)
(defconstant $eADB :|eadb|)
(defconstant $eAnalogAudio :|epau|)
(defconstant $eAppleTalk :|epat|)
(defconstant $eAudioLineIn :|ecai|)
(defconstant $eAudioLineOut :|ecal|)            ;  cde 4/24/98 changed from 'ecao' to not conflict 

(defconstant $eAudioOut :|ecao|)
(defconstant $eBus :|ebus|)
(defconstant $eCDROM :|ecd |)
(defconstant $eCommSlot :|eccm|)
(defconstant $eDigitalAudio :|epda|)
(defconstant $eDisplay :|edds|)
(defconstant $eDVD :|edvd|)
(defconstant $eEthernet :|ecen|)
(defconstant $eFireWire :|ecfw|)
(defconstant $eFloppy :|efd |)
(defconstant $eHD :|ehd |)
(defconstant $eInfrared :|ecir|)
(defconstant $eIP :|epip|)
(defconstant $eIrDA :|epir|)
(defconstant $eIRTalk :|epit|)
(defconstant $eKeyboard :|ekbd|)
(defconstant $eLCD :|edlc|)
(defconstant $eLocalTalk :|eclt|)
(defconstant $eMacIP :|epmi|)
(defconstant $eMacVideo :|epmv|)
(defconstant $eMicrophone :|ecmi|)
(defconstant $eModemPort :|ecmp|)
(defconstant $eModemPrinterPort :|empp|)
(defconstant $eModem :|edmm|)
(defconstant $eMonitorOut :|ecmn|)
(defconstant $eMouse :|emou|)
(defconstant $eNuBusCard :|ednb|)
(defconstant $eNuBus :|enub|)
(defconstant $ePCcard :|ecpc|)
(defconstant $ePCIbus :|ecpi|)
(defconstant $ePCIcard :|edpi|)
(defconstant $ePDSslot :|ecpd|)
(defconstant $ePDScard :|epds|)
(defconstant $ePointingDevice :|edpd|)
(defconstant $ePostScript :|epps|)
(defconstant $ePPP :|eppp|)
(defconstant $ePrinterPort :|ecpp|)
(defconstant $ePrinter :|edpr|)
(defconstant $eSvideo :|epsv|)
(defconstant $eSCSI :|ecsc|)
(defconstant $eSerial :|epsr|)
(defconstant $eSpeakers :|edsp|)
(defconstant $eStorageDevice :|edst|)
(defconstant $eSVGA :|epsg|)
(defconstant $eTokenRing :|etok|)
(defconstant $eTrackball :|etrk|)
(defconstant $eTrackpad :|edtp|)
(defconstant $eUSB :|ecus|)
(defconstant $eVideoIn :|ecvi|)
(defconstant $eVideoMonitor :|edvm|)
(defconstant $eVideoOut :|ecvo|)
;  AppleScript 1.3: Keystroke class 

(defconstant $cKeystroke :|kprs|)
(defconstant $pKeystrokeKey :|kMsg|)
(defconstant $pModifiers :|kMod|)
(defconstant $pKeyKind :|kknd|)
(defconstant $eModifiers :|eMds|)
(defconstant $eOptionDown :|Kopt|)
(defconstant $eCommandDown :|Kcmd|)
(defconstant $eControlDown :|Kctl|)
(defconstant $eShiftDown :|Ksft|)
(defconstant $eCapsLockDown :|Kclk|)
(defconstant $eKeyKind :|ekst|)                 ;  
;  Special keys all start with 'ks' 

(defconstant $eEscapeKey #x6B733500)            ;  Third byte is virtual key code byte        

(defconstant $eDeleteKey #x6B733300)            ;  (see IM Mac Toolbox Essentials, pp. 2-43) 

(defconstant $eTabKey #x6B733000)
(defconstant $eReturnKey #x6B732400)
(defconstant $eClearKey #x6B734700)
(defconstant $eEnterKey #x6B734C00)
(defconstant $eUpArrowKey #x6B737E00)
(defconstant $eDownArrowKey #x6B737D00)
(defconstant $eLeftArrowKey #x6B737B00)
(defconstant $eRightArrowKey #x6B737C00)
(defconstant $eHelpKey #x6B737200)
(defconstant $eHomeKey #x6B737300)
(defconstant $ePageUpKey #x6B737400)
(defconstant $ePageDownKey #x6B737900)
(defconstant $eForwardDelKey #x6B737500)
(defconstant $eEndKey #x6B737700)
(defconstant $eF1Key #x6B737A00)
(defconstant $eF2Key #x6B737800)
(defconstant $eF3Key #x6B736300)
(defconstant $eF4Key #x6B737600)
(defconstant $eF5Key #x6B736000)
(defconstant $eF6Key #x6B736100)
(defconstant $eF7Key #x6B736200)
(defconstant $eF8Key #x6B736400)
(defconstant $eF9Key #x6B736500)
(defconstant $eF10Key #x6B736D00)
(defconstant $eF11Key #x6B736700)
(defconstant $eF12Key #x6B736F00)
(defconstant $eF13Key #x6B736900)
(defconstant $eF14Key #x6B736B00)
(defconstant $eF15Key #x6B737100)
; #pragma options align=reset

; #endif /* __AEREGISTRY__ */


(provide-interface "AERegistry")