(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSColor.h"
; at Sunday July 2,2006 7:30:38 pm.
; 
; 	NSColor.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 
;  NSColors store colors. Often the only NSColor message you send is the "set" method, which makes the receiver the current color in the drawing context. There is usually no need to dive in and get the individual components (for instance, red, green, blue) that make up a color.
; 
; An NSColor may be in one of various colorspaces. Different colorspaces have different ways of getting at the components which define colors in that colorspace. Implementations of NSColors exist for the following colorspaces:
; 
;   NSDeviceCMYKColorSpace	Cyan, magenta, yellow, black, and alpha components
;   NSDeviceWhiteColorSpace	White and alpha components
;   NSDeviceRGBColorSpace		Red, green, blue, and alpha components
; 				Hue, saturation, brightness, and alpha components
;   NSCalibratedWhiteColorSpace	White and alpha components
;   NSCalibratedRGBColorSpace	Red, green, blue, and alpha components
; 				Hue, saturation, brightness, and alpha components
;   NSNamedColorSpace		Catalog name, color name components
; 
; Alpha component defines opacity on devices which support it (1.0 == full opacity). On other devices the alpha is ignored when the color is used.
; 
; It's illegal to ask a color for components that are not defined for its colorspace. If you need to ask a color for a certain set of components (for instance, you need to know the RGB components of a color you got from the color panel), you should first convert the color to the appropriate colorspace using the colorUsingColorSpaceName: method.  If the color is already in the specified colorspace, you get the same color back; otherwise you get a conversion which is usually lossy or is correct only for the current device. You might also get back nil if the specified conversion cannot be done.
; 
; Subclassers of NSColor need to implement the methods colorSpaceName, set, the various methods which return the components for that color space, and the NSCoding protocol. Some other methods such as colorWithAlphaComponent:, isEqual:, colorUsingColorSpaceName:device: may also be implemented if they make sense for the colorspace. If isEqual: is overridden, so should hash (because if [a isEqual:b] then [a hash] == [b hash]). Mutable subclassers (if any) should also implement copyWithZone: to a true copy.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSGeometry.h>

; #import <AppKit/AppKitDefines.h>

; #import <AppKit/NSCell.h>
(defconstant $NSAppKitVersionNumberWithPatternColorLeakFix 641.0)
; #define NSAppKitVersionNumberWithPatternColorLeakFix 641.0
#| @INTERFACE 
NSColor : NSObject <NSCopying, NSCoding>



+ (NSColor *)colorWithCalibratedWhite:(float)white alpha:(float)alpha;



+ (NSColor *)colorWithCalibratedHue:(float)hue saturation:(float)saturation brightness:(float)brightness alpha:(float)alpha;
+ (NSColor *)colorWithCalibratedRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;



+ (NSColor *)colorWithDeviceWhite:(float)white alpha:(float)alpha;
+ (NSColor *)colorWithDeviceHue:(float)hue saturation:(float)saturation brightness:(float)brightness alpha:(float)alpha;
+ (NSColor *)colorWithDeviceRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;
+ (NSColor *)colorWithDeviceCyan:(float)cyan magenta:(float)magenta yellow:(float)yellow black:(float)black alpha:(float)alpha;



+ (NSColor *)colorWithCatalogName:(NSString *)listName colorName:(NSString *)colorName;


+ (NSColor *)blackColor;	
+ (NSColor *)darkGrayColor;	
+ (NSColor *)lightGrayColor;	
+ (NSColor *)whiteColor;	
+ (NSColor *)grayColor;		
+ (NSColor *)redColor;		
+ (NSColor *)greenColor;	
+ (NSColor *)blueColor;		
+ (NSColor *)cyanColor;		
+ (NSColor *)yellowColor;	
+ (NSColor *)magentaColor;	
+ (NSColor *)orangeColor;	
+ (NSColor *)purpleColor;	
+ (NSColor *)brownColor;	
+ (NSColor *)clearColor;	

+ (NSColor *)controlShadowColor;		+ (NSColor *)controlDarkShadowColor;		+ (NSColor *)controlColor;			+ (NSColor *)controlHighlightColor;		+ (NSColor *)controlLightHighlightColor;	+ (NSColor *)controlTextColor;			+ (NSColor *)controlBackgroundColor;		+ (NSColor *)selectedControlColor;		+ (NSColor *)secondarySelectedControlColor;	+ (NSColor *)selectedControlTextColor;		+ (NSColor *)disabledControlTextColor;		+ (NSColor *)textColor;				+ (NSColor *)textBackgroundColor;		+ (NSColor *)selectedTextColor;			+ (NSColor *)selectedTextBackgroundColor;	+ (NSColor *)gridColor;				+ (NSColor *)keyboardFocusIndicatorColor;	+ (NSColor *)windowBackgroundColor;		
+ (NSColor *)scrollBarColor;			+ (NSColor *)knobColor;     			+ (NSColor *)selectedKnobColor;       		
+ (NSColor *)windowFrameColor;			+ (NSColor *)windowFrameTextColor;		
+ (NSColor *)selectedMenuItemColor;		+ (NSColor *)selectedMenuItemTextColor;		
+ (NSColor *)highlightColor;     	     	+ (NSColor *)shadowColor;     			
+ (NSColor *)headerColor;			+ (NSColor *)headerTextColor;			
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
+ (NSColor *)alternateSelectedControlColor;	+ (NSColor *)alternateSelectedControlTextColor;		#endif

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
+ (NSArray *)controlAlternatingRowBackgroundColors;	#endif

- (NSColor *)highlightWithLevel:(float)val;	- (NSColor *)shadowWithLevel:(float)val;	
+ (NSColor *)colorForControlTint:(NSControlTint)controlTint;	
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
+ (NSControlTint) currentControlTint;	#endif



- (void)set;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

- (void)setFill;
- (void)setStroke;
#endif


- (NSString *)colorSpaceName;


 
- (NSColor *)colorUsingColorSpaceName:(NSString *)colorSpace;
- (NSColor *)colorUsingColorSpaceName:(NSString *)colorSpace device:(NSDictionary *)deviceDescription;



- (NSColor *)blendedColorWithFraction:(float)fraction ofColor:(NSColor *)color;



- (NSColor *)colorWithAlphaComponent:(float)alpha;





- (NSString *)catalogNameComponent;
- (NSString *)colorNameComponent;


- (NSString *)localizedCatalogNameComponent;
- (NSString *)localizedColorNameComponent;


- (float)redComponent;
- (float)greenComponent;
- (float)blueComponent;
- (void)getRed:(float *)red green:(float *)green blue:(float *)blue alpha:(float *)alpha;


- (float)hueComponent;
- (float)saturationComponent;
- (float)brightnessComponent;
- (void)getHue:(float *)hue saturation:(float *)saturation brightness:(float *)brightness alpha:(float *)alpha;



- (float)whiteComponent;
- (void)getWhite:(float *)white alpha:(float *)alpha;



- (float)cyanComponent;
- (float)magentaComponent;
- (float)yellowComponent;
- (float)blackComponent;
- (void)getCyan:(float *)cyan magenta:(float *)magenta yellow:(float *)yellow black:(float *)black alpha:(float *)alpha;



- (float)alphaComponent;



+ (NSColor *)colorFromPasteboard:(NSPasteboard *)pasteBoard;
- (void)writeToPasteboard:(NSPasteboard *)pasteBoard;


+ (NSColor*)colorWithPatternImage:(NSImage*)image;
- (NSImage*)patternImage; 


- (void)drawSwatchInRect:(NSRect)rect;



+ (void)setIgnoresAlpha:(BOOL)flag;
+ (BOOL)ignoresAlpha;

|#
#| @INTERFACE 
NSCoder(NSAppKitColorExtensions)


- (NSColor *)decodeNXColor;

|#
(def-mactype :NSSystemColorsDidChangeNotification (find-mactype '(:pointer :NSString)))

(provide-interface "NSColor")