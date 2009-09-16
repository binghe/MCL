(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AIFF.h"
; at Sunday July 2,2006 7:23:30 pm.
; 
;      File:       CarbonCore/AIFF.h
;  
;      Contains:   Definition of AIFF file format components.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1989-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AIFF__
; #define __AIFF__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k

(defconstant $AIFFID :|AIFF|)
(defconstant $AIFCID :|AIFC|)
(defconstant $FormatVersionID :|FVER|)
(defconstant $CommonID :|COMM|)
(defconstant $FORMID :|FORM|)
(defconstant $SoundDataID :|SSND|)
(defconstant $MarkerID :|MARK|)
(defconstant $InstrumentID :|INST|)
(defconstant $MIDIDataID :|MIDI|)
(defconstant $AudioRecordingID :|AESD|)
(defconstant $ApplicationSpecificID :|APPL|)
(defconstant $CommentID :|COMT|)
(defconstant $NameID :|NAME|)
(defconstant $AuthorID :|AUTH|)
(defconstant $CopyrightID :|(c) |)
(defconstant $AnnotationID :|ANNO|)

(defconstant $NoLooping 0)
(defconstant $ForwardLooping 1)
(defconstant $ForwardBackwardLooping 2)
;  AIFF-C Versions 

(defconstant $AIFCVersion1 #xA2805140)
;  Compression Names 
(defconstant $NoneName "\\pnot compressed")
; #define NoneName                        "\pnot compressed"
(defconstant $ACE2to1Name "\\pACE 2-to-1")
; #define ACE2to1Name                     "\pACE 2-to-1"
(defconstant $ACE8to3Name "\\pACE 8-to-3")
; #define ACE8to3Name                     "\pACE 8-to-3"
(defconstant $MACE3to1Name "\\pMACE 3-to-1")
; #define MACE3to1Name                    "\pMACE 3-to-1"
(defconstant $MACE6to1Name "\\pMACE 6-to-1")
; #define MACE6to1Name                    "\pMACE 6-to-1"
;  Compression Types 

(defconstant $NoneType :|NONE|)
(defconstant $ACE2Type :|ACE2|)
(defconstant $ACE8Type :|ACE8|)
(defconstant $MACE3Type :|MAC3|)
(defconstant $MACE6Type :|MAC6|)

(def-mactype :ID (find-mactype ':UInt32))

(def-mactype :MarkerIdType (find-mactype ':SInt16))
(defrecord ChunkHeader
   (ckID :UInt32)
   (ckSize :signed-long)
)

;type name? (%define-record :ChunkHeader (find-record-descriptor ':ChunkHeader))
(defrecord ContainerChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (formType :UInt32)
)

;type name? (%define-record :ContainerChunk (find-record-descriptor ':ContainerChunk))
(defrecord FormatVersionChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (timestamp :UInt32)
)

;type name? (%define-record :FormatVersionChunk (find-record-descriptor ':FormatVersionChunk))

(def-mactype :FormatVersionChunkPtr (find-mactype '(:pointer :FormatVersionChunk)))
(defrecord CommonChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (numChannels :SInt16)
   (numSampleFrames :UInt32)
   (sampleSize :SInt16)
   (sampleRate :Float80)
)

;type name? (%define-record :CommonChunk (find-record-descriptor ':CommonChunk))

(def-mactype :CommonChunkPtr (find-mactype '(:pointer :CommonChunk)))
(defrecord ExtCommonChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (numChannels :SInt16)
   (numSampleFrames :UInt32)
   (sampleSize :SInt16)
   (sampleRate :Float80)
   (compressionType :UInt32)
   (compressionName (:array :character 1))      ;  variable length array, Pascal string 
)

;type name? (%define-record :ExtCommonChunk (find-record-descriptor ':ExtCommonChunk))

(def-mactype :ExtCommonChunkPtr (find-mactype '(:pointer :ExtCommonChunk)))
(defrecord SoundDataChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (offset :UInt32)
   (blockSize :UInt32)
)

;type name? (%define-record :SoundDataChunk (find-record-descriptor ':SoundDataChunk))

(def-mactype :SoundDataChunkPtr (find-mactype '(:pointer :SoundDataChunk)))
(defrecord Marker
   (id :SInt16)
   (position :UInt32)
   (markerName (:string 255))
)

;type name? (%define-record :Marker (find-record-descriptor ':Marker))
(defrecord MarkerChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (numMarkers :UInt16)
   (Markers (:array :Marker 1))                 ;  variable length array 
)

;type name? (%define-record :MarkerChunk (find-record-descriptor ':MarkerChunk))

(def-mactype :MarkerChunkPtr (find-mactype '(:pointer :MarkerChunk)))
(defrecord AIFFLoop
   (playMode :SInt16)
   (beginLoop :SInt16)
   (endLoop :SInt16)
)

;type name? (%define-record :AIFFLoop (find-record-descriptor ':AIFFLoop))
(defrecord InstrumentChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (baseFrequency :UInt8)
   (detune :UInt8)
   (lowFrequency :UInt8)
   (highFrequency :UInt8)
   (lowVelocity :UInt8)
   (highVelocity :UInt8)
   (gain :SInt16)
   (sustainLoop :AIFFLoop)
   (releaseLoop :AIFFLoop)
)

;type name? (%define-record :InstrumentChunk (find-record-descriptor ':InstrumentChunk))

(def-mactype :InstrumentChunkPtr (find-mactype '(:pointer :InstrumentChunk)))
(defrecord MIDIDataChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (MIDIdata (:array :UInt8 1))                 ;  variable length array 
)

;type name? (%define-record :MIDIDataChunk (find-record-descriptor ':MIDIDataChunk))

(def-mactype :MIDIDataChunkPtr (find-mactype '(:pointer :MIDIDataChunk)))
(defrecord AudioRecordingChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (AESChannelStatus (:array :UInt8 24))
)

;type name? (%define-record :AudioRecordingChunk (find-record-descriptor ':AudioRecordingChunk))

(def-mactype :AudioRecordingChunkPtr (find-mactype '(:pointer :AudioRecordingChunk)))
(defrecord ApplicationSpecificChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (applicationSignature :OSType)
   (data (:array :UInt8 1))                     ;  variable length array 
)

;type name? (%define-record :ApplicationSpecificChunk (find-record-descriptor ':ApplicationSpecificChunk))

(def-mactype :ApplicationSpecificChunkPtr (find-mactype '(:pointer :ApplicationSpecificChunk)))
(defrecord Comment
   (timeStamp :UInt32)
   (marker :SInt16)
   (count :UInt16)
   (text (:array :character 1))                 ;  variable length array, Pascal string 
)

;type name? (%define-record :Comment (find-record-descriptor ':Comment))
(defrecord CommentsChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (numComments :UInt16)
   (comments (:array :Comment 1))               ;  variable length array 
)

;type name? (%define-record :CommentsChunk (find-record-descriptor ':CommentsChunk))

(def-mactype :CommentsChunkPtr (find-mactype '(:pointer :CommentsChunk)))
(defrecord TextChunk
   (ckID :UInt32)
   (ckSize :signed-long)
   (text (:array :character 1))                 ;  variable length array, Pascal string 
)

;type name? (%define-record :TextChunk (find-record-descriptor ':TextChunk))

(def-mactype :TextChunkPtr (find-mactype '(:pointer :TextChunk)))
; #pragma options align=reset

; #endif /* __AIFF__ */


(provide-interface "AIFF")