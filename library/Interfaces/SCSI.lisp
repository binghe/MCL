(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCSI.h"
; at Sunday July 2,2006 7:23:32 pm.
; 
;      File:       OSServices/SCSI.h
;  
;      Contains:   SCSI Family Interfaces.
;  
;      Version:    OSServices-62.7~16
;  
;      Copyright:  © 1986-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SCSI__
; #define __SCSI__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
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
; #pragma options align=mac68k
;  TIB opcodes 

(defconstant $scInc 1)
(defconstant $scNoInc 2)
(defconstant $scAdd 3)
(defconstant $scMove 4)
(defconstant $scLoop 5)
(defconstant $scNop 6)
(defconstant $scStop 7)
(defconstant $scComp 8)
;  TIB instruction 
(defrecord SCSIInstr
   (scOpcode :UInt16)
   (scParam1 :signed-long)
   (scParam2 :signed-long)
)

;type name? (%define-record :SCSIInstr (find-record-descriptor ':SCSIInstr))
; 
;  *  SCSIReset()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIGet()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSISelect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSICmd()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIRead()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIRBlind()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIWrite()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIWBlind()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIStat()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSISelAtn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIMsgIn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SCSIMsgOut()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(defconstant $scsiVERSION 43)
; 
;  * SCSI Completion routine callback for SCSIAction.
;  

(def-mactype :SCSICallbackProcPtr (find-mactype ':pointer)); (void * scsiPB)

(def-mactype :SCSICallbackUPP (find-mactype '(:pointer :OpaqueSCSICallbackProcPtr)))
; 
;  *  NewSCSICallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSCSICallbackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_2
   (:pointer :OpaqueSCSICallbackProcPtr)
() )
; 
;  *  DisposeSCSICallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSCSICallbackUPP" 
   ((userUPP (:pointer :OpaqueSCSICallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_2
   nil
() )
; 
;  *  InvokeSCSICallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSCSICallbackUPP" 
   ((scsiPB :pointer)
    (userUPP (:pointer :OpaqueSCSICallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_2
   nil
() )
;  
;    SCSI Manager 4.3 function codes 
;  

(defconstant $SCSINop 0)                        ;  Execute nothing                          

(defconstant $SCSIExecIO 1)                     ;  Execute the specified IO                  

(defconstant $SCSIBusInquiry 3)                 ;  Get parameters for entire path of HBAs           

(defconstant $SCSIReleaseQ 4)                   ;  Release the frozen SIM queue for particular LUN      

(defconstant $SCSIAbortCommand 16)              ;  Abort the selected Control Block             

(defconstant $SCSIResetBus 17)                  ;  Reset the SCSI bus                         

(defconstant $SCSIResetDevice 18)               ;  Reset the SCSI device                      

(defconstant $SCSITerminateIO 19)               ;  Terminate any pending IO                    


(defconstant $vendorUnique #xC0)                ;  0xC0 thru 0xFF 

;  Allocation length defines for some of the fields 

(defconstant $handshakeDataLength 8)            ;  Handshake data length 

(defconstant $maxCDBLength 16)                  ;  Space for the CDB bytes/pointer 

(defconstant $vendorIDLength 16)                ;  ASCII string len for Vendor ID  

;  Define DeviceIdent structure 
(defrecord DeviceIdent
   (diReserved :UInt8)                          ;  reserved           
   (bus :UInt8)                                 ;  SCSI - Bus Number   
   (targetID :UInt8)                            ;  SCSI - Target SCSI ID  
   (LUN :UInt8)                                 ;  SCSI - LUN            
)

;type name? (%define-record :DeviceIdent (find-record-descriptor ':DeviceIdent))
;  Constants for the diReserved field of DeviceIdent 
;  used to distinguish whether the DeviceIdent holds 
;  information about a SCSI device (kBusTypeSCSI)    
;  or an ATA device (kBusTypeATA).  The other        
;  constants are pretty much deprecated.  Let me     
;  know if you see any.                              

(defconstant $kBusTypeSCSI 0)
(defconstant $kBusTypeATA 1)
(defconstant $kBusTypePCMCIA 2)
(defconstant $kBusTypeMediaBay 3)
;  If diReserved indicates that a DeviceIdent is     
;  really for ATA, you can cast it to DeviceIdentATA 
;  to get at the important fields.                   
(defrecord DeviceIdentATA
   (diReserved :UInt8)
   (busNum :UInt8)
   (devNum :UInt8)
   (diReserved2 :UInt8)
)

;type name? (%define-record :DeviceIdentATA (find-record-descriptor ':DeviceIdentATA))
;  Command Descriptor Block structure 
(defrecord CDB
   (:variant
   (
   (cdbPtr (:pointer :UInt8))
   )
                                                ;  pointer to the CDB, or 
   (
   (cdbBytes (:array :UInt8 16))
   )
                                                ;  the actual CDB to send 
   )
)

;type name? (%define-record :CDB (find-record-descriptor ':CDB))

(def-mactype :CDBPtr (find-mactype '(:pointer :CDB)))
;  Scatter/gather list element (Deprecated for MacOS8) 
(defrecord SGRecord
   (SGAddr :pointer)
   (SGCount :UInt32)
)

;type name? (%define-record :SGRecord (find-record-descriptor ':SGRecord))
; #define SCSIPBHdr                        struct SCSIHdr* qLink;                short           scsiReserved1;        UInt16          scsiPBLength;         UInt8           scsiFunctionCode;     UInt8           scsiReserved2;        volatile OSErr  scsiResult;           DeviceIdent     scsiDevice;           SCSICallbackUPP scsiCompletion;       UInt32          scsiFlags;            UInt8 *         scsiDriverStorage;    Ptr             scsiXPTprivate;       long            scsiReserved3;
(defrecord SCSIHdr
   (qLink (:pointer :scsihdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
)

;type name? (%define-record :SCSIHdr (find-record-descriptor ':SCSIHdr))
(defrecord SCSI_PB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
)

;type name? (%define-record :SCSI_PB (find-record-descriptor ':SCSI_PB))
(defrecord SCSI_IO
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
   (scsiResultFlags :UInt16)                    ;  <- Flags which modify the scsiResult field     
   (scsiReserved3pt5 :UInt16)                   ;  -> Reserved                           
   (scsiDataPtr (:pointer :UInt8))              ;  -> Pointer to the data buffer or the S/G list      
   (scsiDataLength :UInt32)                     ;  -> Data transfer length                   
   (scsiSensePtr (:pointer :UInt8))             ;  -> Ptr to autosense data buffer            
   (scsiSenseLength :UInt8)                     ;  -> size of the autosense buffer              
   (scsiCDBLength :UInt8)                       ;  -> Number of bytes for the CDB               
   (scsiSGListCount :UInt16)                    ;  -> num of scatter gather list entries           
   (scsiReserved4 :UInt32)                      ;  <-     reserved for output                   
   (scsiSCSIstatus :UInt8)                      ;  <- Returned scsi device status               
   (scsiSenseResidual :SInt8)                   ;  <- Autosense residual length             
   (scsiReserved5 :UInt16)                      ;  <-     reserved for output                 
   (scsiDataResidual :signed-long)              ;  <- Returned Transfer residual length          
   (scsiCDB :CDB)                               ;  -> Actual CDB or pointer to CDB            
   (scsiTimeout :signed-long)                   ;  -> Timeout value (Time Mgr format) (CAM timeout) 
   (scsiReserved5pt5 (:pointer :UInt8))         ;  -> Reserved                           
   (scsiReserved5pt6 :UInt16)                   ;  -> Reserved                           
   (scsiIOFlags :UInt16)                        ;  -> additional I/O flags                      
   (scsiTagAction :UInt8)                       ;  -> What to do for tag queuing                
   (scsiReserved6 :UInt8)                       ;  ->     reserved for input                   
   (scsiReserved7 :UInt16)                      ;  ->     reserved for input                   
   (scsiSelectTimeout :UInt16)                  ;  -> Select timeout value                 
   (scsiDataType :UInt8)                        ;  -> Data description type (i.e. buffer, TIB, S/G)   
   (scsiTransferType :UInt8)                    ;  -> Transfer type (i.e. Blind vs Polled)       
   (scsiReserved8 :UInt32)                      ;  ->     reserved for input                  
   (scsiReserved9 :UInt32)                      ;  ->     reserved for input                  
   (scsiHandshake (:array :UInt16 8))           ;  -> handshaking points (null term'd)    
   (scsiReserved10 :UInt32)                     ;  ->     reserved for input                  
   (scsiReserved11 :UInt32)                     ;  ->   reserved for input                   
   (scsiCommandLink (:pointer :scsi_io))        ;  -> Ptr to the next PB in linked cmd chain      
   (scsiSIMpublics (:array :UInt8 8))           ;  ->     reserved for input to 3rd-party SIMs     
   (scsiAppleReserved6 (:array :UInt8 8))       ;  -> reserved for input                     
                                                ;  XPT layer privates (for old-API emulation) 
   (scsiCurrentPhase :UInt16)                   ;  <- phase upon completing old call            
   (scsiSelector :SInt16)                       ;  -> selector specified in old calls            
   (scsiOldCallResult :SInt16)                  ;  <- result of old call                     
   (scsiSCSImessage :UInt8)                     ;  <- Returned scsi device message (for SCSIComplete)
   (XPTprivateFlags :UInt8)                     ;  <> various flags                       
   (XPTextras (:array :UInt8 12))               ;                               
)

;type name? (%define-record :SCSI_IO (find-record-descriptor ':SCSI_IO))

(%define-record :SCSIExecIOPB (find-record-descriptor ':SCSI_IO))
;  Bus inquiry PB 
(defrecord SCSIBusInquiryPB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
   (scsiEngineCount :UInt16)                    ;  <- Number of engines on HBA                
   (scsiMaxTransferType :UInt16)                ;  <- Number of transfer types for this HBA      
   (scsiDataTypes :UInt32)                      ;  <- which data types are supported by this SIM  
   (scsiIOpbSize :UInt16)                       ;  <- Size of SCSI_IO PB for this SIM/HBA          
   (scsiMaxIOpbSize :UInt16)                    ;  <- Size of max SCSI_IO PB for all SIM/HBAs        
   (scsiFeatureFlags :UInt32)                   ;  <- Supported features flags field           
   (scsiVersionNumber :UInt8)                   ;  <- Version number for the SIM/HBA           
   (scsiHBAInquiry :UInt8)                      ;  <- Mimic of INQ byte 7 for the HBA           
   (scsiTargetModeFlags :UInt8)                 ;  <- Flags for target mode support           
   (scsiScanFlags :UInt8)                       ;  <- Scan related feature flags            
   (scsiSIMPrivatesPtr :UInt32)                 ;  <- Ptr to SIM private data area              
   (scsiSIMPrivatesSize :UInt32)                ;  <- Size of SIM private data area           
   (scsiAsyncFlags :UInt32)                     ;  <- Event cap. for Async Callback           
   (scsiHiBusID :UInt8)                         ;  <- Highest path ID in the subsystem         
   (scsiInitiatorID :UInt8)                     ;  <- ID of the HBA on the SCSI bus           
   (scsiBIReserved0 :UInt16)                    ;                                   
   (scsiBIReserved1 :UInt32)                    ;  <-                                
   (scsiFlagsSupported :UInt32)                 ;  <- which scsiFlags are supported           
   (scsiIOFlagsSupported :UInt16)               ;  <- which scsiIOFlags are supported           
   (scsiWeirdStuff :UInt16)                     ;  <-                               
   (scsiMaxTarget :UInt16)                      ;  <- maximum Target number supported           
   (scsiMaxLUN :UInt16)                         ;  <- maximum Logical Unit number supported    
   (scsiSIMVendor (:array :character 16))       ;  <- Vendor ID of SIM (or XPT if bus<FF)        
   (scsiHBAVendor (:array :character 16))       ;  <- Vendor ID of the HBA                
   (scsiControllerFamily (:array :character 16));  <- Family of SCSI Controller           
   (scsiControllerType (:array :character 16))  ;  <- Specific Model of SCSI Controller used  
   (scsiXPTversion (:array :character 4))       ;  <- version number of XPT              
   (scsiSIMversion (:array :character 4))       ;  <- version number of SIM              
   (scsiHBAversion (:array :character 4))       ;  <- version number of HBA              
   (scsiHBAslotType :UInt8)                     ;  <- type of "slot" that this HBA is in       
   (scsiHBAslotNumber :UInt8)                   ;  <- slot number of this HBA                  
   (scsiSIMsRsrcID :UInt16)                     ;  <- resource ID of this SIM                  
   (scsiBIReserved3 :UInt16)                    ;  <-                               
   (scsiAdditionalLength :UInt16)               ;  <- additional BusInquiry PB len              
)

;type name? (%define-record :SCSIBusInquiryPB (find-record-descriptor ':SCSIBusInquiryPB))
;  Abort SIM Request PB 
(defrecord SCSIAbortCommandPB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
   (scsiIOptr (:pointer :SCSI_IO))              ;  Pointer to the PB to abort        
)

;type name? (%define-record :SCSIAbortCommandPB (find-record-descriptor ':SCSIAbortCommandPB))
;  Terminate I/O Process Request PB 
(defrecord SCSITerminateIOPB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
   (scsiIOptr (:pointer :SCSI_IO))              ;  Pointer to the PB to terminate        
)

;type name? (%define-record :SCSITerminateIOPB (find-record-descriptor ':SCSITerminateIOPB))
;  Reset SCSI Bus PB 
(defrecord SCSIResetBusPB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
)

;type name? (%define-record :SCSIResetBusPB (find-record-descriptor ':SCSIResetBusPB))
;  Reset SCSI Device PB 
(defrecord SCSIResetDevicePB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
)

;type name? (%define-record :SCSIResetDevicePB (find-record-descriptor ':SCSIResetDevicePB))
;  Release SIM Queue PB 
(defrecord SCSIReleaseQPB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage (:pointer :UInt8))        ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
)

;type name? (%define-record :SCSIReleaseQPB (find-record-descriptor ':SCSIReleaseQPB))
;  SCSI Get Virtual ID Info PB 
(defrecord SCSIGetVirtualIDInfoPB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage :pointer)                 ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
   (scsiOldCallID :UInt16)                      ;  -> SCSI ID of device in question   
   (scsiExists :Boolean)                        ;  <- true if device exists        
   (filler :SInt8)
)

;type name? (%define-record :SCSIGetVirtualIDInfoPB (find-record-descriptor ':SCSIGetVirtualIDInfoPB))
;  Create/Lookup/Remove RefNum for Device PB 
(defrecord SCSIDriverPB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage :pointer)                 ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
   (scsiDriver :SInt16)                         ;  -> DriverRefNum, For SetDriver, <- For GetNextDriver 
   (scsiDriverFlags :UInt16)                    ;  <> Details of driver/device       
   (scsiNextDevice :DeviceIdent)                ;  <- DeviceIdent of the NEXT Item in the list  
)

;type name? (%define-record :SCSIDriverPB (find-record-descriptor ':SCSIDriverPB))
;  Load Driver PB 
(defrecord SCSILoadDriverPB
   (qLink (:pointer :SCSIHdr))                  ;  (internal use, must be nil on entry)   
   (scsiReserved1 :SInt16)                      ;  ->     reserved for input          
   (scsiPBLength :UInt16)                       ;  -> Length of the entire PB        
   (scsiFunctionCode :UInt8)                    ;  -> function selector           
   (scsiReserved2 :UInt8)                       ;  <-     reserved for output          
   (scsiResult :SInt16)                         ;  <- Returned result               
   (scsiDevice :DeviceIdent)                    ;  -> Device Identifier (bus+target+lun)
   (scsiCompletion (:pointer :OpaqueSCSICallbackProcPtr));  -> Callback on completion function     
   (scsiFlags :UInt32)                          ;  -> assorted flags            
   (scsiDriverStorage :pointer)                 ;  <> Ptr for driver private use   
   (scsiXPTprivate :pointer)                    ;  private field for use in XPT      
   (scsiReserved3 :signed-long)                 ;  reserved                    
   (scsiLoadedRefNum :SInt16)                   ;  <- SIM returns refnum of driver      
   (scsiDiskLoadFailed :Boolean)                ;  -> if true, indicates call after failure to load 
   (filler :SInt8)
)

;type name? (%define-record :SCSILoadDriverPB (find-record-descriptor ':SCSILoadDriverPB))
;  Defines for the scsiTransferType field 

(defconstant $scsiTransferBlind 0)
(defconstant $scsiTransferPolled 1)

(defconstant $scsiErrorBase -7936)

(defconstant $scsiRequestInProgress 1)          ;  1   = PB request is in progress          
;  Execution failed  00-2F 

(defconstant $scsiRequestAborted -7934)         ;  -7934 = PB request aborted by the host        

(defconstant $scsiUnableToAbort -7933)          ;  -7933 = Unable to Abort PB request          

(defconstant $scsiNonZeroStatus -7932)          ;  -7932 = PB request completed with an err   

(defconstant $scsiUnused05 -7931)               ;  -7931 =                        

(defconstant $scsiUnused06 -7930)               ;  -7930 =                        

(defconstant $scsiUnused07 -7929)               ;  -7929 =                        

(defconstant $scsiUnused08 -7928)               ;  -7928 =                        

(defconstant $scsiUnableToTerminate -7927)      ;  -7927 = Unable to Terminate I/O PB req        

(defconstant $scsiSelectTimeout -7926)          ;  -7926 = Target selection timeout        

(defconstant $scsiCommandTimeout -7925)         ;  -7925 = Command timeout              

(defconstant $scsiIdentifyMessageRejected -7924);  -7924 =                        

(defconstant $scsiMessageRejectReceived -7923)  ;  -7923 = Message reject received           

(defconstant $scsiSCSIBusReset -7922)           ;  -7922 = SCSI bus reset sent/received    

(defconstant $scsiParityError -7921)            ;  -7921 = Uncorrectable parity error occured     

(defconstant $scsiAutosenseFailed -7920)        ;  -7920 = Autosense: Request sense cmd fail  

(defconstant $scsiUnused11 -7919)               ;  -7919 =                        

(defconstant $scsiDataRunError -7918)           ;  -7918 = Data overrun/underrun error     

(defconstant $scsiUnexpectedBusFree -7917)      ;  -7917 = Unexpected BUS free              

(defconstant $scsiSequenceFailed -7916)         ;  -7916 = Target bus phase sequence failure  

(defconstant $scsiWrongDirection -7915)         ;  -7915 = Data phase was in wrong direction  

(defconstant $scsiUnused16 -7914)               ;  -7914 =                        

(defconstant $scsiBDRsent -7913)                ;  -7913 = A SCSI BDR msg was sent to target  

(defconstant $scsiTerminated -7912)             ;  -7912 = PB request terminated by the host  

(defconstant $scsiNoNexus -7911)                ;  -7911 = Nexus is not established        

(defconstant $scsiCDBReceived -7910)            ;  -7910 = The SCSI CDB has been received        
;  Couldn't begin execution  30-3F 

(defconstant $scsiTooManyBuses -7888)           ;  -7888 = Register failed because we're full 

(defconstant $scsiBusy -7887)                   ;  -7887 = SCSI subsystem is busy           

(defconstant $scsiProvideFail -7886)            ;  -7886 = Unable to provide requ. capability 

(defconstant $scsiDeviceNotThere -7885)         ;  -7885 = SCSI device not installed/there    

(defconstant $scsiNoHBA -7884)                  ;  -7884 = No HBA detected Error           

(defconstant $scsiDeviceConflict -7883)         ;  -7883 = sorry, max 1 refNum per DeviceIdent    

(defconstant $scsiNoSuchXref -7882)             ;  -7882 = no such RefNum xref              

(defconstant $scsiQLinkInvalid -7881)           ;  -7881 = pre-linked PBs not supported      
;    (The QLink field was nonzero)          
;  Parameter errors  40-7F 

(defconstant $scsiPBLengthError -7872)          ;  -7872 = (scsiPBLength is insuf'ct/invalid  

(defconstant $scsiFunctionNotAvailable -7871)   ;  -7871 = The requ. func is not available    

(defconstant $scsiRequestInvalid -7870)         ;  -7870 = PB request is invalid           

(defconstant $scsiBusInvalid -7869)             ;  -7869 = Bus ID supplied is invalid        

(defconstant $scsiTIDInvalid -7868)             ;  -7868 = Target ID supplied is invalid      

(defconstant $scsiLUNInvalid -7867)             ;  -7867 = LUN supplied is invalid         

(defconstant $scsiIDInvalid -7866)              ;  -7866 = The initiator ID is invalid     

(defconstant $scsiDataTypeInvalid -7865)        ;  -7865 = scsiDataType requested not supported 

(defconstant $scsiTransferTypeInvalid -7864)    ;  -7864 = scsiTransferType field is too high     
;  -7863 = scsiCDBLength field is too big        

(defconstant $scsiCDBLengthInvalid -7863)
;  New errors for SCSI Family         

(defconstant $scsiUnused74 -7862)               ;  -7862 =                          

(defconstant $scsiUnused75 -7861)               ;  -7861 =                          

(defconstant $scsiBadDataLength -7860)          ;  -7860 = a zero data length in PB        

(defconstant $scsiPartialPrepared -7859)        ;  -7859 = could not do full prepare mem for I/O

(defconstant $scsiInvalidMsgType -7858)         ;  -7858 = Invalid message type (internal)       

(defconstant $scsiUnused79 -7857)               ;  -7857 =                              

(defconstant $scsiBadConnID -7856)              ;  -7856 = Bad Connection ID                

(defconstant $scsiUnused81 -7855)               ;  -7855 =                          

(defconstant $scsiIOInProgress -7854)           ;  -7854 = Can't close conn, IO in prog      

(defconstant $scsiTargetReserved -7853)         ;  -7853 = Target already reserved          

(defconstant $scsiUnused84 -7852)               ;  -7852 =                          

(defconstant $scsiUnused85 -7851)               ;  -7851 =                          

(defconstant $scsiBadConnType -7850)            ;  -7850 = Bad connection type              
;  -7849 = No matching service category      

(defconstant $scsiCannotLoadPlugin -7849)
;  +++ 
; 
;  * scsiFamilyInternalError and scsiPluginInternalError are intended to handle consistency check failures.
;  * For example, if the family stores a record on a lookaside queue, but does not find that record
;  * it can use this error to report this failure. SCSI Manager 4.3 uses dsIOCoreErr in a few places,
;  * but this is probably not the best error. In general, internal errors should be reported as bugs.
;  *
;  * The following range of errors is provided for third-party (non-Apple) SCSI SIM and device driver vendors.
;  * In general, they would be used for error conditions that are not covered by the standardized errors.
;  * They should not normally be conveyed to normal applications, but might be used for communication between
;  * a plug-in and a vendor-provided device driver (for example, to manage RAID hot-swapping).
;  *
;  * Note: I don't know how many SCSI errors are reserved in the error code architecture. Don't assume that
;  * we'll actually get sixteen, but we should reserve at least one.
;  

(defconstant $scsiFamilyInternalError -7849)    ;  -7849 = Internal consistency check failed  

(defconstant $scsiPluginInternalError -7848)    ;  -7848 = Internal consistency check failed  

(defconstant $scsiVendorSpecificErrorBase -7808);  ??    = Start of third-party error range     

(defconstant $scsiVendorSpecificErrorCount 16)  ;  Number of third-party errors             

;  --- 

(defconstant $scsiExecutionErrors -7936)
(defconstant $scsiNotExecutedErrors -7888)
(defconstant $scsiParameterErrors -7872)
;  Defines for the scsiResultFlags field 

(defconstant $scsiSIMQFrozen 1)                 ;  The SIM queue is frozen w/this err        

(defconstant $scsiAutosenseValid 2)             ;  Autosense data valid for target         

(defconstant $scsiBusNotFree 4)                 ;  At time of callback, SCSI bus is not free  

;  Defines for the bit numbers of the scsiFlags field in the PB header for the SCSIExecIO function 

(defconstant $kbSCSIDisableAutosense 29)        ;  Disable auto sense feature               

(defconstant $kbSCSIFlagReservedA 28)           ;                              

(defconstant $kbSCSIFlagReserved0 27)           ;                              

(defconstant $kbSCSICDBLinked 26)               ;  The PB contains a linked CDB             

(defconstant $kbSCSIQEnable 25)                 ;  Target queue actions are enabled          

(defconstant $kbSCSICDBIsPointer 24)            ;  The CDB field contains a pointer          

(defconstant $kbSCSIFlagReserved1 23)           ;                                

(defconstant $kbSCSIInitiateSyncData 22)        ;  Attempt Sync data xfer and SDTR          

(defconstant $kbSCSIDisableSyncData 21)         ;  Disable sync, go to async            

(defconstant $kbSCSISIMQHead 20)                ;  Place PB at the head of SIM Q          

(defconstant $kbSCSISIMQFreeze 19)              ;  Return the SIM Q to frozen state          

(defconstant $kbSCSISIMQNoFreeze 18)            ;  Disallow SIM Q freezing                 

(defconstant $kbSCSIDoDisconnect 17)            ;  Definitely do disconnect               

(defconstant $kbSCSIDontDisconnect 16)          ;  Definitely don't disconnect              

(defconstant $kbSCSIDataReadyForDMA 15)         ;  Data buffer(s) are ready for DMA          

(defconstant $kbSCSIFlagReserved3 14)           ;                                

(defconstant $kbSCSIDataPhysical 13)            ;  SG/Buffer data ptrs are physical          

(defconstant $kbSCSISensePhysical 12)           ;  Autosense buffer ptr is physical          

(defconstant $kbSCSIFlagReserved5 11)           ;                                

(defconstant $kbSCSIFlagReserved6 10)           ;                                

(defconstant $kbSCSIFlagReserved7 9)            ;                                

(defconstant $kbSCSIFlagReserved8 8)            ;                                

(defconstant $kbSCSIDataBufferValid 7)          ;  Data buffer valid                 

(defconstant $kbSCSIStatusBufferValid 6)        ;  Status buffer valid                 

(defconstant $kbSCSIMessageBufferValid 5)       ;  Message buffer valid                

(defconstant $kbSCSIFlagReserved9 4)            ;                              

;  Defines for the bit masks of the scsiFlags field 

(defconstant $scsiDirectionMask #xC0000000)     ;  Data direction mask                 

(defconstant $scsiDirectionNone #xC0000000)     ;  Data direction (11: no data)          

(defconstant $scsiDirectionReserved 0)          ;  Data direction (00: reserved)       

(defconstant $scsiDirectionOut #x80000000)      ;  Data direction (10: DATA OUT)       

(defconstant $scsiDirectionIn #x40000000)       ;  Data direction (01: DATA IN)          

(defconstant $scsiDisableAutosense #x20000000)  ;  Disable auto sense feature          

(defconstant $scsiFlagReservedA #x10000000)     ;                            

(defconstant $scsiFlagReserved0 #x8000000)      ;                            

(defconstant $scsiCDBLinked #x4000000)          ;  The PB contains a linked CDB          

(defconstant $scsiQEnable #x2000000)            ;  Target queue actions are enabled      

(defconstant $scsiCDBIsPointer #x1000000)       ;  The CDB field contains a pointer      

(defconstant $scsiFlagReserved1 #x800000)       ;                            

(defconstant $scsiInitiateSyncData #x400000)    ;  Attempt Sync data xfer and SDTR         

(defconstant $scsiDisableSyncData #x200000)     ;  Disable sync, go to async          

(defconstant $scsiSIMQHead #x100000)            ;  Place PB at the head of SIM Q       

(defconstant $scsiSIMQFreeze #x80000)           ;  Return the SIM Q to frozen state      

(defconstant $scsiSIMQNoFreeze #x40000)         ;  Disallow SIM Q freezing              

(defconstant $scsiDoDisconnect #x20000)         ;  Definitely do disconnect             

(defconstant $scsiDontDisconnect #x10000)       ;  Definitely don't disconnect          

(defconstant $scsiDataReadyForDMA #x8000)       ;  Data buffer(s) are ready for DMA      

(defconstant $scsiFlagReserved3 #x4000)         ;   

(defconstant $scsiDataPhysical #x2000)          ;  SG/Buffer data ptrs are physical      

(defconstant $scsiSensePhysical #x1000)         ;  Autosense buffer ptr is physical      

(defconstant $scsiFlagReserved5 #x800)          ;                          

(defconstant $scsiFlagReserved6 #x400)          ;                            

(defconstant $scsiFlagReserved7 #x200)          ;                            

(defconstant $scsiFlagReserved8 #x100)          ;                            

;  bit masks for the scsiIOFlags field in SCSIExecIOPB 

(defconstant $scsiNoParityCheck 2)              ;  disable parity checking                 

(defconstant $scsiDisableSelectWAtn 4)          ;  disable select w/Atn                    

(defconstant $scsiSavePtrOnDisconnect 8)        ;  do SaveDataPointer upon Disconnect msg          

(defconstant $scsiNoBucketIn 16)                ;  donÕt bit bucket in during this I/O           

(defconstant $scsiNoBucketOut 32)               ;  donÕt bit bucket out during this I/O        

(defconstant $scsiDisableWide 64)               ;  disable wide transfer negotiation           

(defconstant $scsiInitiateWide #x80)            ;  initiate wide transfer negotiation           

(defconstant $scsiRenegotiateSense #x100)       ;  renegotiate sync/wide before issuing autosense     

(defconstant $scsiDisableDiscipline #x200)      ;  disable parameter checking on SCSIExecIO calls 

(defconstant $scsiIOFlagReserved0080 #x80)      ;                                 

(defconstant $scsiIOFlagReserved8000 #x8000)    ;                                   

;  Defines for the Bus Inquiry PB fields. 
;  scsiHBAInquiry field bits 

(defconstant $scsiBusMDP #x80)                  ;  Supports Modify Data Pointer message               

(defconstant $scsiBusWide32 64)                 ;  Supports 32 bit wide SCSI                    

(defconstant $scsiBusWide16 32)                 ;  Supports 16 bit wide SCSI                    

(defconstant $scsiBusSDTR 16)                   ;  Supports Sync Data Transfer Req message              

(defconstant $scsiBusLinkedCDB 8)               ;  Supports linked CDBs                         

(defconstant $scsiBusTagQ 2)                    ;  Supports tag queue message                    

(defconstant $scsiBusSoftReset 1)               ;  Supports soft reset                           

;  Defines for the scsiDataType field 

(defconstant $scsiDataBuffer 0)                 ;  single contiguous buffer supplied            

(defconstant $scsiDataTIB 1)                    ;  TIB supplied (ptr in scsiDataPtr)           

(defconstant $scsiDataSG 2)                     ;  scatter/gather list supplied             

(defconstant $scsiDataIOTable 3)                ; #(7/11/95) Prepared by Block Storage         

;  scsiDataTypes field bits  
;   bits 0->15 Apple-defined, 16->30 3rd-party unique, 31 = reserved 

(defconstant $scsiBusDataTIB 2)                 ;  TIB supplied (ptr in scsiDataPtr)   

(defconstant $scsiBusDataBuffer 1)              ;  single contiguous buffer supplied      

(defconstant $scsiBusDataSG 4)                  ;  scatter/gather list supplied        

(defconstant $scsiBusDataIOTable 8)             ;  (2/6/95) Prepare Memory for IO
;                             

(defconstant $scsiBusDataReserved #x80000000)
;  scsiScanFlags field bits 

(defconstant $scsiBusScansDevices #x80)         ;  Bus scans for and maintains device list         

(defconstant $scsiBusScansOnInit 64)            ;  Bus scans performed at power-up/reboot        

(defconstant $scsiBusLoadsROMDrivers 32)        ;  may load ROM drivers to support targets       

;  scsiFeatureFlags field bits 

(defconstant $scsiBusLVD #x400)                 ;  HBA is Low Voltage Differential Bus         

(defconstant $scsiBusUltra3SCSI #x200)          ;  HBA supports Ultra3 SCSI               

(defconstant $scsiBusUltra2SCSI #x100)          ;  HBA supports Ultra2 SCSI               

(defconstant $scsiBusInternalExternalMask #xC0) ;  bus internal/external mask           

(defconstant $scsiBusInternalExternalUnknown 0) ;  not known whether bus is inside or outside     

(defconstant $scsiBusInternalExternal #xC0)     ;  bus goes inside and outside the box       

(defconstant $scsiBusInternal #x80)             ;  bus goes inside the box                

(defconstant $scsiBusExternal 64)               ;  bus goes outside the box             

(defconstant $scsiBusCacheCoherentDMA 32)       ;  DMA is cache coherent                

(defconstant $scsiBusOldCallCapable 16)         ;  SIM is old call capable                

(defconstant $scsiBusUltraSCSI 8)               ;  HBA supports Ultra SCSI                 

(defconstant $scsiBusDifferential 4)            ;  Single Ended (0) or Differential (1)    

(defconstant $scsiBusFastSCSI 2)                ;  HBA supports fast SCSI                  

(defconstant $scsiBusDMAavailable 1)            ;  DMA is available                  

;  scsiWeirdStuff field bits 

(defconstant $scsiOddDisconnectUnsafeRead1 1)   ;  Disconnects on odd byte boundries are unsafe with DMA and/or blind reads 

(defconstant $scsiOddDisconnectUnsafeWrite1 2)  ;  Disconnects on odd byte boundries are unsafe with DMA and/or blind writes 

(defconstant $scsiBusErrorsUnsafe 4)            ;  Non-handshaked delays or disconnects during blind transfers may cause a crash 

(defconstant $scsiRequiresHandshake 8)          ;  Non-handshaked delays or disconnects during blind transfers may cause data corruption 

(defconstant $scsiTargetDrivenSDTRSafe 16)      ;  Targets which initiate synchronous negotiations are supported 

(defconstant $scsiOddCountForPhysicalUnsafe 32) ;  If using physical addrs all counts must be even, and disconnects must be on even boundries 

(defconstant $scsiAbortCmdFixed 64)             ;  Set if abort command is fixed to properly make callbacks 

(defconstant $scsiMeshACKTimingFixed #x80)      ;  Set if bug allowing Mesh to release ACK prematurely is fixed 

;  scsiHBAslotType values 

(defconstant $scsiMotherboardBus 0)             ;  A built in Apple supplied bus            

(defconstant $scsiNuBus 1)                      ;  A SIM on a NuBus card                   

(defconstant $scsiPDSBus 3)                     ;     "  on a PDS card                    

(defconstant $scsiPCIBus 4)                     ;     "  on a PCI bus card                   

(defconstant $scsiPCMCIABus 5)                  ;     "  on a PCMCIA card                  

(defconstant $scsiFireWireBridgeBus 6)          ;     "  connected through a FireWire bridge   

(defconstant $scsiUSBBus 7)                     ;     "  connected on a USB bus               

;  Defines for the scsiDriverFlags field (in SCSIDriverPB) 

(defconstant $scsiDeviceSensitive 1)            ;  Only driver should access this device          

(defconstant $scsiDeviceNoOldCallAccess 2)      ;  no old call access to this device            

; 
;  * SCSI bus status. These values are returned by the SCSI target in the status phase.
;  * They are not related to Macintosh status values (except that values other than
;  * scsiStatusGood will result in scsiResult set to scsiNonZeroStatus).
;  

(defconstant $scsiStatGood 0)                   ;  Good Status

(defconstant $scsiStatCheckCondition 2)         ;  Check Condition

(defconstant $scsiStatConditionMet 4)           ;  Condition Met

(defconstant $scsiStatBusy 8)                   ;  Busy

(defconstant $scsiStatIntermediate 16)          ;  Intermediate

(defconstant $scsiStatIntermedMet 20)           ;  Intermediate - Condition Met

(defconstant $scsiStatResvConflict 24)          ;  Reservation conflict

(defconstant $scsiStatTerminated 34)            ;  Command terminated

(defconstant $scsiStatQFull 40)                 ;  Queue full

;  SCSI messages

(defconstant $kCmdCompleteMsg 0)
(defconstant $kExtendedMsg 1)                   ;  0x01

(defconstant $kSaveDataPointerMsg 2)            ;  0x02

(defconstant $kRestorePointersMsg 3)            ;  0x03

(defconstant $kDisconnectMsg 4)                 ;  0x04

(defconstant $kInitiatorDetectedErrorMsg 5)     ;  0x05

(defconstant $kAbortMsg 6)                      ;  0x06

(defconstant $kMsgRejectMsg 7)                  ;  0x07

(defconstant $kNoOperationMsg 8)                ;  0x08

(defconstant $kMsgParityErrorMsg 9)             ;  0x09

(defconstant $kLinkedCmdCompleteMsg 10)         ;  0x0a

(defconstant $kLinkedCmdCompleteWithFlagMsg 11) ;  0x0b

(defconstant $kBusDeviceResetMsg 12)            ;  0x0c

(defconstant $kAbortTagMsg 13)                  ;  0x0d

(defconstant $kClearQueueMsg 14)                ;  0x0e

(defconstant $kInitiateRecoveryMsg 15)          ;  0x0f

(defconstant $kReleaseRecoveryMsg 16)           ;  0x10

(defconstant $kTerminateIOProcessMsg 17)        ;  0x11

(defconstant $kSimpleQueueTag 32)               ;  0x20

(defconstant $kHeadOfQueueTagMsg 33)            ;  0x21

(defconstant $kOrderedQueueTagMsg 34)           ;  0x22

(defconstant $kIgnoreWideResidueMsg 35)         ;  0x23

; 
;  *  SCSIAction()   *** DEPRECATED ***
;  *  
;  *  Deprecated:
;  *    Use the SCSITaskUserClient API instead.
;  *  
;  *  Discussion:
;  *    This routine is deprecated. It is exported and callable, but it
;  *    is no longer being maintained.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework but deprecated in 10.2
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  

(deftrap-inline "_SCSIAction" 
   ((parameterBlock (:pointer :SCSI_PB))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_2
   :OSErr
() )
; 
;  *  SCSIRegisterBus()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  
; 
;  *  SCSIDeregisterBus()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  
; 
;  *  SCSIReregisterBus()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  
; 
;  *  SCSIKillXPT()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.5 and later
;  
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __SCSI__ */


(provide-interface "SCSI")