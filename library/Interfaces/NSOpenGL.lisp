(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSOpenGL.h"
; at Sunday July 2,2006 7:30:54 pm.
; 
;         NSOpenGL.h
;         Application Kit
;         Copyright (c) 2000-2003, Apple Computer, Inc.
;         All rights reserved.
; 

; #import <Foundation/NSObject.h>
; 
; ** NSOpenGL current API version
; 
(defconstant $NSOPENGL_CURRENT_VERSION 1)
; #define NSOPENGL_CURRENT_VERSION  1
; 
; ** Option names for NSOpenGLSetOption and NSOpenGLGetOption.
; 

(defconstant $NSOpenGLGOFormatCacheSize #x1F5)  ;  Set the size of the pixel format cache        

(defconstant $NSOpenGLGOClearFormatCache #x1F6) ;  Reset the pixel format cache if true          

(defconstant $NSOpenGLGORetainRenderers #x1F7)  ;  Whether to retain loaded renderers in memory  

(defconstant $NSOpenGLGOResetLibrary #x1F8)     ;  Do a soft reset of the CGL library if true    

(def-mactype :NSOpenGLGlobalOption (find-mactype ':SINT32))
; 
; ** Library global options.
; 

(deftrap-inline "_NSOpenGLSetOption" 
   ((pname :SInt32)
    (param :signed-long)
   )
   nil
() )

(deftrap-inline "_NSOpenGLGetOption" 
   ((pname :SInt32)
    (param (:pointer :long))
   )
   nil
() )
; 
; ** Library version.
; 

(deftrap-inline "_NSOpenGLGetVersion" 
   ((major (:pointer :long))
    (minor (:pointer :long))
   )
   nil
() )
; ********************
; ** NSOpenGLPixelFormat
; ********************
; 
; ** Attribute names for [NSOpenGLPixelFormat initWithAttributes]
; ** and [NSOpenGLPixelFormat getValues:forAttribute:forVirtualScreen].
; 

(defconstant $NSOpenGLPFAAllRenderers 1)        ;  choose from all available renderers          

(defconstant $NSOpenGLPFADoubleBuffer 5)        ;  choose a double buffered pixel format        

(defconstant $NSOpenGLPFAStereo 6)              ;  stereo buffering supported                   

(defconstant $NSOpenGLPFAAuxBuffers 7)          ;  number of aux buffers                        

(defconstant $NSOpenGLPFAColorSize 8)           ;  number of color buffer bits                  

(defconstant $NSOpenGLPFAAlphaSize 11)          ;  number of alpha component bits               

(defconstant $NSOpenGLPFADepthSize 12)          ;  number of depth buffer bits                  

(defconstant $NSOpenGLPFAStencilSize 13)        ;  number of stencil buffer bits                

(defconstant $NSOpenGLPFAAccumSize 14)          ;  number of accum buffer bits                  

(defconstant $NSOpenGLPFAMinimumPolicy 51)      ;  never choose smaller buffers than requested  

(defconstant $NSOpenGLPFAMaximumPolicy 52)      ;  choose largest buffers of type requested     

(defconstant $NSOpenGLPFAOffScreen 53)          ;  choose an off-screen capable renderer        

(defconstant $NSOpenGLPFAFullScreen 54)         ;  choose a full-screen capable renderer        

(defconstant $NSOpenGLPFASampleBuffers 55)      ;  number of multi sample buffers               

(defconstant $NSOpenGLPFASamples 56)            ;  number of samples per multi sample buffer    

(defconstant $NSOpenGLPFAAuxDepthStencil 57)    ;  each aux buffer has its own depth stencil    

(defconstant $NSOpenGLPFARendererID 70)         ;  request renderer by ID                       

(defconstant $NSOpenGLPFASingleRenderer 71)     ;  choose a single renderer for all screens     

(defconstant $NSOpenGLPFANoRecovery 72)         ;  disable all failure recovery systems         

(defconstant $NSOpenGLPFAAccelerated 73)        ;  choose a hardware accelerated renderer       

(defconstant $NSOpenGLPFAClosestPolicy 74)      ;  choose the closest color buffer to request   

(defconstant $NSOpenGLPFARobust 75)             ;  renderer does not need failure recovery      

(defconstant $NSOpenGLPFABackingStore 76)       ;  back buffer contents are valid after swap    

(defconstant $NSOpenGLPFAMPSafe 78)             ;  renderer is multi-processor safe             

(defconstant $NSOpenGLPFAWindow 80)             ;  can be used to render to an onscreen window  

(defconstant $NSOpenGLPFAMultiScreen 81)        ;  single window can span multiple screens      

(defconstant $NSOpenGLPFACompliant 83)          ;  renderer is opengl compliant                 

(defconstant $NSOpenGLPFAScreenMask 84)         ;  bit mask of supported physical screens       

(defconstant $NSOpenGLPFAPixelBuffer 90)        ;  can be used to render to a pbuffer           

(defconstant $NSOpenGLPFAVirtualScreenCount #x80);  number of virtual screens in this format     

(def-mactype :NSOpenGLPixelFormatAttribute (find-mactype ':SINT32))
; 
; ** NSOpenGLPixelFormat interface.
; 

(def-mactype :NSOpenGLPixelFormatAuxiliary (find-mactype ':_CGLPixelFormatObject))
#| @INTERFACE 
NSOpenGLPixelFormat : NSObject <NSCoding>
{
private
    NSOpenGLPixelFormatAuxiliary* _pixelFormatAuxiliary;
    NSData*                       _pixelAttributes;
    unsigned long                 _reserved1;
    unsigned long                 _reserved2;
    unsigned long                 _reserved3;
}

- (id)initWithAttributes:(NSOpenGLPixelFormatAttribute*)attribs;
- (id)initWithData:(NSData*)attribs;

- (NSData*)attributes;
- (void)setAttributes:(NSData*)attribs;

- (void)getValues:(long*)vals forAttribute:(NSOpenGLPixelFormatAttribute)attrib forVirtualScreen:(int)screen;
- (int)numberOfVirtualScreens;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void *)CGLPixelFormatObj;
#endif

|#
; ********************
; ** NSOpenGLPixelBuffer
; ********************

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
#| @INTERFACE 
NSOpenGLPixelBuffer : NSObject
{
private
    struct _CGLPBufferObject	*_pixelBufferAuxiliary;
    void			*_reserved1;
    void			*_reserved2;
}


- (id)initWithTextureTarget:(unsigned long)target textureInternalFormat:(unsigned long)format textureMaxMipMapLevel:(long)maxLevel pixelsWide:(int)pixelsWide pixelsHigh:(int)pixelsHigh;
- (int)pixelsWide;
- (int)pixelsHigh;
- (unsigned long)textureTarget;
- (unsigned long)textureInternalFormat;
- (long)textureMaxMipMapLevel;
|#

; #endif

; ****************
; ** NSOpenGLContext
; ****************
; 
; ** Parameter names for [NSOpenGLContext setParameter] and [NSOpenGLContext getParameter].
; 

(defconstant $NSOpenGLCPSwapRectangle #xC8)     ;  Set or get the swap rectangle {x, y, w, h}       

(defconstant $NSOpenGLCPSwapRectangleEnable #xC9);  Enable or disable the swap rectangle             

(defconstant $NSOpenGLCPRasterizationEnable #xDD);  Enable or disable all rasterization              

(defconstant $NSOpenGLCPSwapInterval #xDE)      ;  0 -> Don't sync, n -> Sync every n retrace       

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2

(defconstant $NSOpenGLCPSurfaceOrder #xEB)      ;  1 -> Above Window (default), -1 -> Below Window  

(defconstant $NSOpenGLCPSurfaceOpacity #xEC)    ;  1-> Surface is opaque (default), 0 -> non-opaque 

; #endif


(defconstant $NSOpenGLCPStateValidation #x12D)  ;  Validate state for multi-screen functionality    

(def-mactype :NSOpenGLContextParameter (find-mactype ':SINT32))
; 
; ** NSOpenGLContext interface.
; 

(%define-record :NSOpenGLContextAuxiliary (find-record-descriptor ':_CGLContextObject))
#| @INTERFACE 
NSOpenGLContext : NSObject
{
private
	NSView                   *_view;
	NSOpenGLContextAuxiliary *_contextAuxiliary;
}


- (id)initWithFormat:(NSOpenGLPixelFormat *)format shareContext:(NSOpenGLContext *)share;


- (void)setView:(NSView *)view;
- (NSView *)view;
- (void)setFullScreen;
- (void)setOffScreen:(void *)baseaddr width:(long)width height:(long)height rowbytes:(long)rowbytes;
- (void)clearDrawable;
- (void)update;


- (void)flushBuffer;


- (void)makeCurrentContext;
+ (void)clearCurrentContext;
+ (NSOpenGLContext *)currentContext;


- (void)copyAttributesFromContext:(NSOpenGLContext *)context withMask:(unsigned long)mask;


- (void)setValues:(const long *)vals forParameter:(NSOpenGLContextParameter)param;
- (void)getValues:(long *)vals forParameter:(NSOpenGLContextParameter)param;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2


- (void)setCurrentVirtualScreen:(int)screen;
- (int)currentVirtualScreen;


- (void)createTexture:(unsigned long)target fromView:(NSView*)view internalFormat:(unsigned long)format;

#endif

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void *)CGLContextObj;


- (void)setPixelBuffer:(NSOpenGLPixelBuffer *)pixelBuffer cubeMapFace:(unsigned long)face mipMapLevel:(long)level currentVirtualScreen:(int)screen;
- (NSOpenGLPixelBuffer *)pixelBuffer;
- (unsigned long)pixelBufferCubeMapFace;
- (long)pixelBufferMipMapLevel;

- (void)setTextureImageToPixelBuffer:(NSOpenGLPixelBuffer *)pixelBuffer colorBuffer:(unsigned long)source;
#endif

|#

(provide-interface "NSOpenGL")