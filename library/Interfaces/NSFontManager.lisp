(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSFontManager.h"
; at Sunday July 2,2006 7:30:48 pm.
; 
; 	NSFontManager.h
; 	Application Kit
; 	Copyright (c) 1994-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

(def-mactype :NSFontTraitMask (find-mactype ':UInt32))
; 
;  * Font Traits
;  *
;  * This list should be kept small since the more traits that are assigned
;  * to a given font, the harder it will be to map it to some other family.
;  * Some traits are mutually exclusive such as NSExpanded and NSCondensed.
;  

(defconstant $NSItalicFontMask 1)
(defconstant $NSBoldFontMask 2)
(defconstant $NSUnboldFontMask 4)
(defconstant $NSNonStandardCharacterSetFontMask 8)
(defconstant $NSNarrowFontMask 16)
(defconstant $NSExpandedFontMask 32)
(defconstant $NSCondensedFontMask 64)
(defconstant $NSSmallCapsFontMask #x80)
(defconstant $NSPosterFontMask #x100)
(defconstant $NSCompressedFontMask #x200)
(defconstant $NSFixedPitchFontMask #x400)
(defconstant $NSUnitalicFontMask #x1000000)

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(defconstant $NSFontCollectionApplicationOnlyMask 1)

; #endif

#| @INTERFACE 
NSFontManager : NSObject
{

private
    id                  _panel;
    unsigned int        _reservedFMInt1;
    SEL                 _action;
    int                 _whatToDo;
    NSFontTraitMask     _traitToChange;
    NSFont *            _selFont;
    struct _fmFlags {
	unsigned int        multipleFont:1;
	unsigned int        disabled:1;
	unsigned int	    makePanelKey:1;
	unsigned int        myNotification:1;
	unsigned int        _RESERVED:12;
    }                   _fmFlags;
    unsigned short      _lastPos;
    id		        _delegate;
    id			_collections;
    unsigned int        _reservedFMint3;
    unsigned int        _reservedFMint4;
}

+ (void)setFontPanelFactory:(Class)factoryId;
+ (void)setFontManagerFactory:(Class)factoryId;
+ (NSFontManager *)sharedFontManager;

- (BOOL)isMultiple;
- (NSFont *)selectedFont;
- (void)setSelectedFont:(NSFont *)fontObj isMultiple:(BOOL)flag;
- (void)setFontMenu:(NSMenu *)newMenu;
- (NSMenu *)fontMenu:(BOOL)create;
- (NSFontPanel *)fontPanel:(BOOL)create;
- (NSFont *)fontWithFamily:(NSString *)family traits:(NSFontTraitMask)traits weight:(int)weight size:(float)size;
- (NSFontTraitMask)traitsOfFont:(NSFont *)fontObj;
- (int)weightOfFont:(NSFont *)fontObj;


- (NSArray *)availableFonts;
- (NSArray *)availableFontFamilies;
- (NSArray *)availableMembersOfFontFamily:(NSString *)fam;

- (NSFont *)convertFont:(NSFont *)fontObj;
- (NSFont *)convertFont:(NSFont *)fontObj toSize:(float)size;
- (NSFont *)convertFont:(NSFont *)fontObj toFace:(NSString *)typeface;
- (NSFont *)convertFont:(NSFont *)fontObj toFamily:(NSString *)family;
- (NSFont *)convertFont:(NSFont *)fontObj toHaveTrait:(NSFontTraitMask)trait;
- (NSFont *)convertFont:(NSFont *)fontObj toNotHaveTrait:(NSFontTraitMask)trait;
- (NSFont *)convertWeight:(BOOL)upFlag ofFont:(NSFont *)fontObj;
- (BOOL)isEnabled;
- (void)setEnabled:(BOOL)flag;
- (SEL)action;
- (void)setAction:(SEL)aSelector;
- (BOOL)sendAction;
- (void)setDelegate:(id)anObject;
- (id)delegate;

- (NSString *) localizedNameForFamily:(NSString *)family face:(NSString *)faceKey;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)setSelectedAttributes:(NSDictionary *)attributes isMultiple:(BOOL)flag;
- (NSDictionary *)convertAttributes:(NSDictionary *)attributes;

- (NSArray *) availableFontNamesMatchingFontDescriptor: (NSFontDescriptor *) descriptor;

- (NSArray *) collectionNames;
- (NSArray *) fontDescriptorsInCollection: (NSString *) collectionNames;
- (BOOL) addCollection: (NSString *) collectionName options: (int) collectionOptions;
- (BOOL) removeCollection: (NSString *) collectionName;

- (void) addFontDescriptors: (NSArray *) descriptors  toCollection: (NSString *) collectionName;
- (void) removeFontDescriptor: (NSFontDescriptor *) descriptor fromCollection: (NSString *) collection;
#endif

|#
#| @INTERFACE 
NSFontManager(NSFontManagerMenuActionMethods)

- (BOOL)fontNamed:(NSString *)fName hasTraits:(NSFontTraitMask)someTraits;


- (NSArray *)availableFontNamesWithTraits:(NSFontTraitMask)someTraits;


- (void)addFontTrait:(id)sender;
- (void)removeFontTrait:(id)sender;
- (void)modifyFontViaPanel:(id)sender;
- (void)modifyFont:(id)sender;
- (void)orderFrontFontPanel:(id)sender;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (void)orderFrontStylesPanel:(id)sender;
#endif

|#
;  And these "actions" are really tag values in Font Menu cells which send any of the action messages listed above.  Normally, they're pre-defined in the font panel.
; 
(def-mactype :_NSFontAction (find-mactype ':sint32))

(defconstant $NSNoFontChangeAction 0)
(defconstant $NSViaPanelFontAction 1)
(defconstant $NSAddTraitFontAction 2)
(defconstant $NSSizeUpFontAction 3)
(defconstant $NSSizeDownFontAction 4)
(defconstant $NSHeavierFontAction 5)
(defconstant $NSLighterFontAction 6)
(defconstant $NSRemoveTraitFontAction 7)
(def-mactype :NSFontAction (find-mactype ':SINT32))
;  This method is perhaps inappropriately named; it is sent to the delegate of the shared NSFontPanel instance, not to the delegate of the NSFontManager.
; 
#| @INTERFACE 
NSObject(NSFontManagerDelegate)
- (BOOL)fontManager:(id)sender willIncludeFont:(NSString *)fontName;
|#
;  This is the message that's propagated up the responder chain.
; 
#| @INTERFACE 
NSObject(NSFontManagerResponderMethod)
- (void)changeFont:(id)sender;
|#

(provide-interface "NSFontManager")