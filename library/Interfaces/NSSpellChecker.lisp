(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSSpellChecker.h"
; at Sunday July 2,2006 7:31:00 pm.
; 
;         NSSpellChecker.h
; 	Application Kit
; 	Copyright (c) 1990-2003, Apple Computer, Inc.
; 	All rights reserved.
; 

; #import <Foundation/NSObject.h>

; #import <Foundation/NSRange.h>
;  The NSSpellChecker object is used by a client (e.g. a document in an application) to spell-check a given NSString.  There is only one NSSpellChecker instance per application (since spell-checking is interactive and you only have one mouse and one keyboard).
; 
; The string being spell-checked need only be valid for the duration of the call to checkSpellingOfString:... or countWordsInString:.
; 
; The usual usage of this is to implement a checkSpelling: method in an object that has text to check, then, upon receiving checkSpelling:, the object calls [[NSSpellChecker sharedInstance] checkSpellingOfString:...] with an NSString object consisting of the text that should be checked.  The caller is responsible for selecting the misspelled word that is found and for updating the panel UI if desired with the updateSpellPanelWithMisspelledWord: method.
; 
#| @INTERFACE 
NSSpellChecker : NSObject  {



private
        id _guessesBrowser;
    id _wordField;
    id _languagePopUp;
    id _guessesList;
    id _panel;
    id _userDictionaries;
    id _correctButton;
    id _guessButton;
    id _ignoreButton;
    id _accessoryView;
    id _dictionaryBrowser;
    NSString *_selectionString;
    void *_spellServers;
    NSString *_lastGuess;
    
    struct __scFlags {
        unsigned int autoShowGuesses:1;
        unsigned int needDelayedGuess:1;
        unsigned int unignoreInProgress:1;
        unsigned int wordFieldEdited:1;
        unsigned int _reserved:28;
    } _scFlags;
    
    id _deleteButton;
    id _openButton;
    id _learnButton;
    id _forgetButton;

    void *_reservedSpellChecker1;
}


+ (NSSpellChecker *)sharedSpellChecker;
+ (BOOL)sharedSpellCheckerExists;


+ (int)uniqueSpellDocumentTag;


- (NSRange)checkSpellingOfString:(NSString *)stringToCheck startingAt:(int)startingOffset language:(NSString *)language wrap:(BOOL)wrapFlag inSpellDocumentWithTag:(int)tag wordCount:(int *)wordCount;

- (NSRange)checkSpellingOfString:(NSString *)stringToCheck startingAt:(int)startingOffset;


- (int)countWordsInString:(NSString *)stringToCount language:(NSString *)language;


- (void)updateSpellingPanelWithMisspelledWord:(NSString *)word;



- (NSPanel *)spellingPanel;
- (NSView *)accessoryView;
- (void)setAccessoryView:(NSView *)aView;


- (void)ignoreWord:(NSString *)wordToIgnore inSpellDocumentWithTag:(int)tag;

- (NSArray *)ignoredWordsInSpellDocumentWithTag:(int)tag;
- (void)setIgnoredWords:(NSArray *)words inSpellDocumentWithTag:(int)tag;
- (NSArray *)guessesForWord:(NSString *)word;


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (NSArray *)completionsForPartialWordRange:(NSRange)range inString:(NSString *)string language:(NSString *)language inSpellDocumentWithTag:(int)tag;
#endif


- (void)closeSpellDocumentWithTag:(int)tag;


- (NSString *)language;
- (BOOL)setLanguage:(NSString *)language;


- (void)setWordFieldStringValue:(NSString *)aString;

|#

(provide-interface "NSSpellChecker")