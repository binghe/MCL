(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:WebFrameView.h"
; at Sunday July 2,2006 7:32:18 pm.
; 	
;     WebFrameView.h
;     Copyright (C) 2003 Apple Computer, Inc. All rights reserved.    
;     
;     Public header file.
; 

; #import <Cocoa/Cocoa.h>
#| @PROTOCOL 
WebDocumentView;


interface WebFrameView : NSView
{
private
    WebFrameViewPrivate *_private;
}


- (WebFrame *)webFrame;


- (NSView <WebDocumentView> *)documentView;


- (void)setAllowsScrolling:(BOOL)flag;


- (BOOL)allowsScrolling;


|#

(provide-interface "WebFrameView")