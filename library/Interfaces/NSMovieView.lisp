(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSMovieView.h"
; at Sunday July 2,2006 7:30:53 pm.
; 
;         NSMovieView.h
;         Copyright (c) 1998-2003, Apple Computer, Inc. All rights reserved.
; 

; #import <AppKit/NSView.h>

(defconstant $NSQTMovieNormalPlayback 0)
(defconstant $NSQTMovieLoopingPlayback 1)
(defconstant $NSQTMovieLoopingBackAndForthPlayback 2)
(def-mactype :NSQTMovieLoopMode (find-mactype ':SINT32))
(defrecord __MVFlags
   (editable :UInt32)
   (loopMode :SInt32)
   (playsEveryFrame :UInt32)
   (playsSelectionOnly :UInt32)
   (controllerVisible :UInt32)
   (reserved :UInt32)
)
(%define-record :_MVFlags (find-record-descriptor :__MVFLAGS))
#| @INTERFACE 
NSMovieView : NSView
{
  protected
    NSMovie*       _fMovie;
    float          _fRate;
    float          _fVolume;
    _MVFlags       _fFlags;

    void*          _fAuxData;
    unsigned long  _fReserved1;
    unsigned long  _fReserved2;
    unsigned long  _fReserved3;
}

- (void) setMovie:(NSMovie*)movie;
- (NSMovie*) movie;

- (void* ) movieController;
- (NSRect) movieRect;

    
- (void)start:(id)sender;
- (void)stop:(id)sender;
- (BOOL)isPlaying;

- (void)gotoPosterFrame:(id)sender;
- (void)gotoBeginning:(id)sender;
- (void)gotoEnd:(id)sender;
- (void)stepForward:(id)sender;
- (void)stepBack:(id)sender;

- (void)setRate:(float)rate;
- (float)rate;

    
- (void)setVolume:(float)volume;
- (float)volume;
- (void)setMuted:(BOOL)mute;
- (BOOL)isMuted;

    
- (void)setLoopMode:(NSQTMovieLoopMode)mode;
- (NSQTMovieLoopMode)loopMode;
- (void)setPlaysSelectionOnly:(BOOL)flag;
- (BOOL)playsSelectionOnly;
- (void)setPlaysEveryFrame:(BOOL)flag;
- (BOOL)playsEveryFrame;

    
- (void)showController:(BOOL)show adjustingSize:(BOOL)adjustSize;
- (BOOL)isControllerVisible;

    
- (void)resizeWithMagnification:(float)magnification;
- (NSSize)sizeForMagnification:(float)magnification;

    
- (void)setEditable:(BOOL)editable;
- (BOOL)isEditable;

- (void)cut:(id)sender;
- (void)copy:(id)sender;
- (void)paste:(id)sender;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)delete:(id)sender;
#endif
- (void)selectAll:(id)sender;

- (void)clear:(id)sender;	
|#

(provide-interface "NSMovieView")